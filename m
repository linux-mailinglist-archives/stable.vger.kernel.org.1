Return-Path: <stable+bounces-114378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A425EA2D54E
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B3188D79D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C91A2398;
	Sat,  8 Feb 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQc3fpjp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F529199E80;
	Sat,  8 Feb 2025 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007331; cv=none; b=j71SGiu0l3Z+Hk4lBHvcNpTlGb1QgRflNFINUqge0xbkzO7tKkXs8UQf0wEhs0f3enHUlhYnGL0MhhAnI/AvebkdToBsAyk1eI4+E7D6iQS7n723BxZndWG7NIBavqnBmWcbvmQqcCGKyggd9Z3l7+1ceahsMHjzLsTmQA8jJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007331; c=relaxed/simple;
	bh=ETi2trRH+/fl/GYfqBRk03aOH+eUqAob58Hs5qbKADg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBFrVuEnjsGO3xWfBMLp2Zhlm9d0WKaSbxpvMnBoGK+QxpCEOPSi2NfPotzqnmncwTJKANos7Ypos7OSYmF4UCwzXxtTYQkdn9/7WouLK1ZBp66FzbdWufQv2COcUXwwKWZ2E/elhSAJiUqZKkIEI0AXpehwiD6gSNr84I+Uc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQc3fpjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF4C4CED6;
	Sat,  8 Feb 2025 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739007330;
	bh=ETi2trRH+/fl/GYfqBRk03aOH+eUqAob58Hs5qbKADg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zQc3fpjp/XT+sqvhV0jtAlgyiIYV7FEM2RxBFwaq/4lbVOSsVfuDRFIiGd65VSnQf
	 f60YBmej/Q6sdAwLMoEpoC7o5gep9LACFDp06Jbc60V3lVFx2o/s4T5AlmtiidK11i
	 ua/OTTCLEGsSjayUFD9VBvdMNlAgj6nobln97aS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.13
Date: Sat,  8 Feb 2025 10:35:16 +0100
Message-ID: <2025020816-nearly-icky-b493@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025020816-legible-uranium-3071@gregkh>
References: <2025020816-legible-uranium-3071@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 12e4aecdae94..d1154eb43810 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -68,7 +68,7 @@ is to define the default namespace in the ``Makefile`` of the subsystem. E.g. to
 export all symbols defined in usb-common into the namespace USB_COMMON, add a
 line like this to drivers/usb/common/Makefile::
 
-	ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
+	ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"USB_COMMON"'
 
 That will affect all EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() statements. A
 symbol exported with EXPORT_SYMBOL_NS() while this definition is present, will
@@ -79,7 +79,7 @@ A second option to define the default namespace is directly in the compilation
 unit as preprocessor statement. The above example would then read::
 
 	#undef  DEFAULT_SYMBOL_NAMESPACE
-	#define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
+	#define DEFAULT_SYMBOL_NAMESPACE "USB_COMMON"
 
 within the corresponding compilation unit before any EXPORT_SYMBOL macro is
 used.
diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index ccb53c6b96c1..98c0800732ef 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - fsl,imx91-ccm
       - fsl,imx93-ccm
 
   reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index e850a8894758..bb40bb9e036e 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -27,7 +27,7 @@ properties:
     description: |
       For multicolor LED support this property should be defined as either
       LED_COLOR_ID_RGB or LED_COLOR_ID_MULTI which can be found in
-      include/linux/leds/common.h.
+      include/dt-bindings/leds/common.h.
     enum: [ 8, 9 ]
 
 required:
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
index bb81307dc11b..4fc78efaa550 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -50,15 +50,15 @@ properties:
     minimum: 0
     maximum: 1
 
-  rohm,charger-sense-resistor-ohms:
-    minimum: 10000000
-    maximum: 50000000
+  rohm,charger-sense-resistor-micro-ohms:
+    minimum: 10000
+    maximum: 50000
     description: |
-      BD71827 and BD71828 have SAR ADC for measuring charging currents.
-      External sense resistor (RSENSE in data sheet) should be used. If
-      something other but 30MOhm resistor is used the resistance value
-      should be given here in Ohms.
-    default: 30000000
+      BD71815 has SAR ADC for measuring charging currents. External sense
+      resistor (RSENSE in data sheet) should be used. If something other
+      but a 30 mOhm resistor is used the resistance value should be given
+      here in micro Ohms.
+    default: 30000
 
   regulators:
     $ref: /schemas/regulator/rohm,bd71815-regulator.yaml
@@ -67,7 +67,7 @@ properties:
 
   gpio-reserved-ranges:
     description: |
-      Usage of BD71828 GPIO pins can be changed via OTP. This property can be
+      Usage of BD71815 GPIO pins can be changed via OTP. This property can be
       used to mark the pins which should not be configured for GPIO. Please see
       the ../gpio/gpio.txt for more information.
 
@@ -113,7 +113,7 @@ examples:
             gpio-controller;
             #gpio-cells = <2>;
 
-            rohm,charger-sense-resistor-ohms = <10000000>;
+            rohm,charger-sense-resistor-micro-ohms = <10000>;
 
             regulators {
                 buck1: buck1 {
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 58ae298cd2fc..23884b8184a9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -25,7 +25,7 @@ properties:
   "#address-cells":
     const: 1
     description: |
-      The cell is the slot ID if a function subnode is used.
+      The cell is the SDIO function number if a function subnode is used.
 
   "#size-cells":
     const: 0
diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
index cd4aa27218a1..fa6743bb269d 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -35,10 +35,6 @@ properties:
         $ref: regulator.yaml#
         unevaluatedProperties: false
 
-        properties:
-          regulator-compatible:
-            pattern: "^vbuck[1-4]$"
-
     additionalProperties: false
 
 required:
@@ -56,7 +52,6 @@ examples:
 
       regulators {
         vbuck1 {
-          regulator-compatible = "vbuck1";
           regulator-min-microvolt = <300000>;
           regulator-max-microvolt = <1193750>;
           regulator-enable-ramp-delay = <256>;
@@ -64,7 +59,6 @@ examples:
         };
 
         vbuck3 {
-          regulator-compatible = "vbuck3";
           regulator-min-microvolt = <300000>;
           regulator-max-microvolt = <1193750>;
           regulator-enable-ramp-delay = <256>;
diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index bba40158dd5c..8e50b900d51c 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -272,7 +272,7 @@ The available attributes are:
       echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode
 
     Async mode without interrupts (caller must poll) can be enabled by
-    writing 'async' to it::
+    writing 'async' to it (please see Caveat)::
 
       echo async > /sys/bus/dsa/drivers/crypto/sync_mode
 
@@ -283,6 +283,13 @@ The available attributes are:
 
     The default mode is 'sync'.
 
+    Caveat: since the only mechanism that iaa_crypto currently implements
+    for async polling without interrupts is via the 'sync' mode as
+    described earlier, writing 'async' to
+    '/sys/bus/dsa/drivers/crypto/sync_mode' will internally enable the
+    'sync' mode. This is to ensure correct iaa_crypto behavior until true
+    async polling without interrupts is enabled in iaa_crypto.
+
 .. _iaa_default_config:
 
 IAA Default Configuration
diff --git a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
index 17abc25ee4c1..6657f82c0101 100644
--- a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
+++ b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
@@ -69,7 +69,7 @@ Per esempio per esportare tutti i simboli definiti in usb-common nello spazio
 dei nomi USB_COMMON, si può aggiungere la seguente linea in
 drivers/usb/common/Makefile::
 
-	ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
+	ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"USB_COMMON"'
 
 Questo cambierà tutte le macro EXPORT_SYMBOL() ed EXPORT_SYMBOL_GPL(). Invece,
 un simbolo esportato con EXPORT_SYMBOL_NS() non verrà cambiato e il simbolo
@@ -79,7 +79,7 @@ Una seconda possibilità è quella di definire il simbolo di preprocessore
 direttamente nei file da compilare. L'esempio precedente diventerebbe::
 
 	#undef  DEFAULT_SYMBOL_NAMESPACE
-	#define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
+	#define DEFAULT_SYMBOL_NAMESPACE "USB_COMMON"
 
 Questo va messo prima di un qualsiasi uso di EXPORT_SYMBOL.
 
diff --git a/Documentation/translations/zh_CN/core-api/symbol-namespaces.rst b/Documentation/translations/zh_CN/core-api/symbol-namespaces.rst
index bb16f0611046..f3e73834f7d7 100644
--- a/Documentation/translations/zh_CN/core-api/symbol-namespaces.rst
+++ b/Documentation/translations/zh_CN/core-api/symbol-namespaces.rst
@@ -66,7 +66,7 @@
 子系统的 ``Makefile`` 中定义默认命名空间。例如，如果要将usb-common中定义的所有符号导
 出到USB_COMMON命名空间，可以在drivers/usb/common/Makefile中添加这样一行::
 
-       ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
+       ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"USB_COMMON"'
 
 这将影响所有 EXPORT_SYMBOL() 和 EXPORT_SYMBOL_GPL() 语句。当这个定义存在时，
 用EXPORT_SYMBOL_NS()导出的符号仍然会被导出到作为命名空间参数传递的命名空间中，
@@ -76,7 +76,7 @@
 成::
 
        #undef  DEFAULT_SYMBOL_NAMESPACE
-       #define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
+       #define DEFAULT_SYMBOL_NAMESPACE "USB_COMMON"
 
 应置于相关编译单元中任何 EXPORT_SYMBOL 宏之前
 
diff --git a/Makefile b/Makefile
index 9e6246e733eb..5442ff45f963 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 12
+SUBLEVEL = 13
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -509,7 +509,7 @@ KGZIP		= gzip
 KBZIP2		= bzip2
 KLZOP		= lzop
 LZMA		= lzma
-LZ4		= lz4c
+LZ4		= lz4
 XZ		= xz
 ZSTD		= zstd
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..14d175103106 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -284,12 +284,12 @@ &i2c10 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
@@ -461,22 +461,20 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
@@ -511,22 +509,20 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6b6e77596ffa..b108265e9bde 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -440,7 +440,7 @@ gmac0: ethernet@ff800000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "ahb";
+			reset-names = "stmmaceth", "stmmaceth-ocp";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -460,7 +460,7 @@ gmac1: ethernet@ff802000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "ahb";
+			reset-names = "stmmaceth", "stmmaceth-ocp";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -480,7 +480,7 @@ gmac2: ethernet@ff804000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "ahb";
+			reset-names = "stmmaceth", "stmmaceth-ocp";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index 814586abc297..fd7a89cc337d 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -308,7 +308,7 @@ pwrap: pwrap@1000d000 {
 		clock-names = "spi", "wrap";
 	};
 
-	cir: cir@10013000 {
+	cir: ir-receiver@10013000 {
 		compatible = "mediatek,mt7623-cir";
 		reg = <0 0x10013000 0 0x1000>;
 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..35a933eec573 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -197,6 +197,7 @@ qspi1_flash: flash@0 {
 
 &sdmmc0 {
 	bus-width = <4>;
+	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 951a0c97d3c6..5933840bb8f7 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -514,6 +514,7 @@ kernel@200000 {
 
 &sdmmc0 {
 	bus-width = <4>;
+	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	disable-wp;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index 028961eb7108..91ca23a66bf3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -135,6 +135,7 @@ vgen6_reg: vldo4 {
 	lm75a: temperature-sensor@48 {
 		compatible = "national,lm75a";
 		reg = <0x48>;
+		vs-supply = <&vgen4_reg>;
 	};
 
 	/* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
diff --git a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
index ddad6497775b..ffb7233b063d 100644
--- a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
@@ -85,8 +85,8 @@ regulators {
 
 			vddcpu: buck1 { /* VDD_CPU_1V2 */
 				regulator-name = "vddcpu";
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <1250000>;
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-initial-mode = <0>;
 				regulator-over-current-protection;
diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index 4f878ec102c1..fdc42a89bd37 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -129,7 +129,7 @@ ipcc: mailbox@4c001000 {
 			reg = <0x4c001000 0x400>;
 			st,proc-id = <0>;
 			interrupts-extended =
-				<&exti 61 1>,
+				<&exti 61 IRQ_TYPE_LEVEL_HIGH>,
 				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "rx", "tx";
 			clocks = <&rcc IPCC>;
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
index bb4f8a0b937f..abe2dfe70636 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
@@ -6,18 +6,6 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 
-/ {
-	aliases {
-		serial0 = &uart4;
-		serial1 = &usart3;
-		serial2 = &uart8;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
 &adc {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
index 171d7c7658fa..0fb4e55843b9 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
@@ -7,16 +7,6 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	aliases {
-		serial0 = &uart4;
-		serial1 = &usart3;
-		serial2 = &uart8;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	clk_ext_audio_codec: clock-codec {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi
index b5bc53accd6b..01c693cc0344 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi
@@ -7,16 +7,6 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	aliases {
-		serial0 = &uart4;
-		serial1 = &usart3;
-		serial2 = &uart8;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	led {
 		compatible = "gpio-leds";
 
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
index 74a11ccc5333..142d4a8731f8 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
@@ -14,6 +14,13 @@ aliases {
 		ethernet1 = &ksz8851;
 		rtc0 = &hwrtc;
 		rtc1 = &rtc;
+		serial0 = &uart4;
+		serial1 = &uart8;
+		serial2 = &usart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@c0000000 {
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index b9b995f8a36e..05a1547642b6 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -598,7 +598,21 @@ static int at91_suspend_finish(unsigned long val)
 	return 0;
 }
 
-static void at91_pm_switch_ba_to_vbat(void)
+/**
+ * at91_pm_switch_ba_to_auto() - Configure Backup Unit Power Switch
+ * to automatic/hardware mode.
+ *
+ * The Backup Unit Power Switch can be managed either by software or hardware.
+ * Enabling hardware mode allows the automatic transition of power between
+ * VDDANA (or VDDIN33) and VDDBU (or VBAT, respectively), based on the
+ * availability of these power sources.
+ *
+ * If the Backup Unit Power Switch is already in automatic mode, no action is
+ * required. If it is in software-controlled mode, it is switched to automatic
+ * mode to enhance safety and eliminate the need for toggling between power
+ * sources.
+ */
+static void at91_pm_switch_ba_to_auto(void)
 {
 	unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
 	unsigned int val;
@@ -609,24 +623,19 @@ static void at91_pm_switch_ba_to_vbat(void)
 
 	val = readl(soc_pm.data.sfrbu + offset);
 
-	/* Already on VBAT. */
-	if (!(val & soc_pm.sfrbu_regs.pswbu.state))
+	/* Already on auto/hardware. */
+	if (!(val & soc_pm.sfrbu_regs.pswbu.ctrl))
 		return;
 
-	val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
-	val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
+	val &= ~soc_pm.sfrbu_regs.pswbu.ctrl;
+	val |= soc_pm.sfrbu_regs.pswbu.key;
 	writel(val, soc_pm.data.sfrbu + offset);
-
-	/* Wait for update. */
-	val = readl(soc_pm.data.sfrbu + offset);
-	while (val & soc_pm.sfrbu_regs.pswbu.state)
-		val = readl(soc_pm.data.sfrbu + offset);
 }
 
 static void at91_pm_suspend(suspend_state_t state)
 {
 	if (soc_pm.data.mode == AT91_PM_BACKUP) {
-		at91_pm_switch_ba_to_vbat();
+		at91_pm_switch_ba_to_auto();
 
 		cpu_suspend(0, at91_suspend_finish);
 
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 3312ef93355d..a5bf5554800f 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -289,7 +289,7 @@ static struct gpiod_lookup_table nokia770_irq_gpio_table = {
 		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
 			    GPIO_ACTIVE_HIGH),
 		/* GPIO used for retu IRQ */
-		GPIO_LOOKUP("gpio-48-63", 15, "retu_irq",
+		GPIO_LOOKUP("gpio-48-63", 14, "retu_irq",
 			    GPIO_ACTIVE_HIGH),
 		/* GPIO used for tahvo IRQ */
 		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 379c2c8466f5..86d44349e095 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -390,6 +390,8 @@ &sound {
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_rgb666_pins>;
+	assigned-clocks = <&ccu CLK_TCON0>;
+	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index b407e1dd08a7..ec055510af8b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -369,6 +369,8 @@ &sound {
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_rgb666_pins>;
+	assigned-clocks = <&ccu CLK_TCON0>;
+	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index a5c3920e0f04..0fecf0abb204 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -445,6 +445,8 @@ tcon0: lcd-controller@1c0c000 {
 			clock-names = "ahb", "tcon-ch0";
 			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
+			assigned-clocks = <&ccu CLK_TCON0>;
+			assigned-clock-parents = <&ccu CLK_PLL_MIPI>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
 
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 04b9b3d31f4f..7bc3852c6ef8 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -917,7 +917,7 @@ xcvr: xcvr@42680000 {
 				reg-names = "ram", "regs", "rxfifo", "txfifo";
 				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
 					 <&clk IMX93_CLK_SPDIF_GATE>,
 					 <&clk IMX93_CLK_DUMMY>,
 					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
index b1ea7dcaed17..47234d0858dd 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -435,7 +435,7 @@ &cp1_eth1 {
 	managed = "in-band-status";
 	phy-mode = "sgmii";
 	phy = <&cp1_phy0>;
-	phys = <&cp0_comphy3 1>;
+	phys = <&cp1_comphy3 1>;
 	status = "okay";
 };
 
@@ -444,7 +444,7 @@ &cp1_eth2 {
 	managed = "in-band-status";
 	phy-mode = "sgmii";
 	phy = <&cp1_phy1>;
-	phys = <&cp0_comphy5 2>;
+	phys = <&cp1_comphy5 2>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index aa728331e876..284e240b7997 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -129,6 +129,7 @@ i2c@11003000 {
 			reg = <0 0x11003000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
 			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
 				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
 			clock-names = "main", "dma";
@@ -142,6 +143,7 @@ i2c@11004000 {
 			reg = <0 0x11004000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
 			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
 				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
 			clock-names = "main", "dma";
@@ -155,6 +157,7 @@ i2c@11005000 {
 			reg = <0 0x11005000 0 0x1000>,
 			      <0 0x10217180 0 0x80>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
 			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
 				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
 			clock-names = "main", "dma";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index b4d85147b77b..309e2d104fdc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -931,7 +931,7 @@ pmic: pmic {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		clock: mt6397clock {
+		clock: clocks {
 			compatible = "mediatek,mt6397-clk";
 			#clock-cells = <1>;
 		};
@@ -942,11 +942,10 @@ pio6397: pinctrl {
 			#gpio-cells = <2>;
 		};
 
-		regulator: mt6397regulator {
+		regulators {
 			compatible = "mediatek,mt6397-regulator";
 
 			mt6397_vpca15_reg: buck_vpca15 {
-				regulator-compatible = "buck_vpca15";
 				regulator-name = "vpca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -956,7 +955,6 @@ mt6397_vpca15_reg: buck_vpca15 {
 			};
 
 			mt6397_vpca7_reg: buck_vpca7 {
-				regulator-compatible = "buck_vpca7";
 				regulator-name = "vpca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -966,7 +964,6 @@ mt6397_vpca7_reg: buck_vpca7 {
 			};
 
 			mt6397_vsramca15_reg: buck_vsramca15 {
-				regulator-compatible = "buck_vsramca15";
 				regulator-name = "vsramca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -975,7 +972,6 @@ mt6397_vsramca15_reg: buck_vsramca15 {
 			};
 
 			mt6397_vsramca7_reg: buck_vsramca7 {
-				regulator-compatible = "buck_vsramca7";
 				regulator-name = "vsramca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -984,7 +980,6 @@ mt6397_vsramca7_reg: buck_vsramca7 {
 			};
 
 			mt6397_vcore_reg: buck_vcore {
-				regulator-compatible = "buck_vcore";
 				regulator-name = "vcore";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -993,7 +988,6 @@ mt6397_vcore_reg: buck_vcore {
 			};
 
 			mt6397_vgpu_reg: buck_vgpu {
-				regulator-compatible = "buck_vgpu";
 				regulator-name = "vgpu";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -1002,7 +996,6 @@ mt6397_vgpu_reg: buck_vgpu {
 			};
 
 			mt6397_vdrm_reg: buck_vdrm {
-				regulator-compatible = "buck_vdrm";
 				regulator-name = "vdrm";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1400000>;
@@ -1011,7 +1004,6 @@ mt6397_vdrm_reg: buck_vdrm {
 			};
 
 			mt6397_vio18_reg: buck_vio18 {
-				regulator-compatible = "buck_vio18";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1620000>;
 				regulator-max-microvolt = <1980000>;
@@ -1020,18 +1012,15 @@ mt6397_vio18_reg: buck_vio18 {
 			};
 
 			mt6397_vtcxo_reg: ldo_vtcxo {
-				regulator-compatible = "ldo_vtcxo";
 				regulator-name = "vtcxo";
 				regulator-always-on;
 			};
 
 			mt6397_va28_reg: ldo_va28 {
-				regulator-compatible = "ldo_va28";
 				regulator-name = "va28";
 			};
 
 			mt6397_vcama_reg: ldo_vcama {
-				regulator-compatible = "ldo_vcama";
 				regulator-name = "vcama";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -1039,18 +1028,15 @@ mt6397_vcama_reg: ldo_vcama {
 			};
 
 			mt6397_vio28_reg: ldo_vio28 {
-				regulator-compatible = "ldo_vio28";
 				regulator-name = "vio28";
 				regulator-always-on;
 			};
 
 			mt6397_vusb_reg: ldo_vusb {
-				regulator-compatible = "ldo_vusb";
 				regulator-name = "vusb";
 			};
 
 			mt6397_vmc_reg: ldo_vmc {
-				regulator-compatible = "ldo_vmc";
 				regulator-name = "vmc";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
@@ -1058,7 +1044,6 @@ mt6397_vmc_reg: ldo_vmc {
 			};
 
 			mt6397_vmch_reg: ldo_vmch {
-				regulator-compatible = "ldo_vmch";
 				regulator-name = "vmch";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -1066,7 +1051,6 @@ mt6397_vmch_reg: ldo_vmch {
 			};
 
 			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-				regulator-compatible = "ldo_vemc3v3";
 				regulator-name = "vemc_3v3";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -1074,7 +1058,6 @@ mt6397_vemc_3v3_reg: ldo_vemc3v3 {
 			};
 
 			mt6397_vgp1_reg: ldo_vgp1 {
-				regulator-compatible = "ldo_vgp1";
 				regulator-name = "vcamd";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -1082,7 +1065,6 @@ mt6397_vgp1_reg: ldo_vgp1 {
 			};
 
 			mt6397_vgp2_reg: ldo_vgp2 {
-				regulator-compatible = "ldo_vgp2";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -1090,7 +1072,6 @@ mt6397_vgp2_reg: ldo_vgp2 {
 			};
 
 			mt6397_vgp3_reg: ldo_vgp3 {
-				regulator-compatible = "ldo_vgp3";
 				regulator-name = "vcamaf";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -1098,7 +1079,6 @@ mt6397_vgp3_reg: ldo_vgp3 {
 			};
 
 			mt6397_vgp4_reg: ldo_vgp4 {
-				regulator-compatible = "ldo_vgp4";
 				regulator-name = "vgp4";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -1106,7 +1086,6 @@ mt6397_vgp4_reg: ldo_vgp4 {
 			};
 
 			mt6397_vgp5_reg: ldo_vgp5 {
-				regulator-compatible = "ldo_vgp5";
 				regulator-name = "vgp5";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3000000>;
@@ -1114,7 +1093,6 @@ mt6397_vgp5_reg: ldo_vgp5 {
 			};
 
 			mt6397_vgp6_reg: ldo_vgp6 {
-				regulator-compatible = "ldo_vgp6";
 				regulator-name = "vgp6";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -1123,7 +1101,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-				regulator-compatible = "ldo_vibr";
 				regulator-name = "vibr";
 				regulator-min-microvolt = <1300000>;
 				regulator-max-microvolt = <3300000>;
@@ -1131,7 +1108,7 @@ mt6397_vibr_reg: ldo_vibr {
 			};
 		};
 
-		rtc: mt6397rtc {
+		rtc: rtc {
 			compatible = "mediatek,mt6397-rtc";
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index bb4671c18e3b..9fffed0ef4bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -307,11 +307,10 @@ pmic: pmic {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		mt6397regulator: mt6397regulator {
+		regulators {
 			compatible = "mediatek,mt6397-regulator";
 
 			mt6397_vpca15_reg: buck_vpca15 {
-				regulator-compatible = "buck_vpca15";
 				regulator-name = "vpca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -320,7 +319,6 @@ mt6397_vpca15_reg: buck_vpca15 {
 			};
 
 			mt6397_vpca7_reg: buck_vpca7 {
-				regulator-compatible = "buck_vpca7";
 				regulator-name = "vpca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -329,7 +327,6 @@ mt6397_vpca7_reg: buck_vpca7 {
 			};
 
 			mt6397_vsramca15_reg: buck_vsramca15 {
-				regulator-compatible = "buck_vsramca15";
 				regulator-name = "vsramca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -338,7 +335,6 @@ mt6397_vsramca15_reg: buck_vsramca15 {
 			};
 
 			mt6397_vsramca7_reg: buck_vsramca7 {
-				regulator-compatible = "buck_vsramca7";
 				regulator-name = "vsramca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -347,7 +343,6 @@ mt6397_vsramca7_reg: buck_vsramca7 {
 			};
 
 			mt6397_vcore_reg: buck_vcore {
-				regulator-compatible = "buck_vcore";
 				regulator-name = "vcore";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -356,7 +351,6 @@ mt6397_vcore_reg: buck_vcore {
 			};
 
 			mt6397_vgpu_reg: buck_vgpu {
-				regulator-compatible = "buck_vgpu";
 				regulator-name = "vgpu";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -365,7 +359,6 @@ mt6397_vgpu_reg: buck_vgpu {
 			};
 
 			mt6397_vdrm_reg: buck_vdrm {
-				regulator-compatible = "buck_vdrm";
 				regulator-name = "vdrm";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1400000>;
@@ -374,7 +367,6 @@ mt6397_vdrm_reg: buck_vdrm {
 			};
 
 			mt6397_vio18_reg: buck_vio18 {
-				regulator-compatible = "buck_vio18";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1620000>;
 				regulator-max-microvolt = <1980000>;
@@ -383,19 +375,16 @@ mt6397_vio18_reg: buck_vio18 {
 			};
 
 			mt6397_vtcxo_reg: ldo_vtcxo {
-				regulator-compatible = "ldo_vtcxo";
 				regulator-name = "vtcxo";
 				regulator-always-on;
 			};
 
 			mt6397_va28_reg: ldo_va28 {
-				regulator-compatible = "ldo_va28";
 				regulator-name = "va28";
 				regulator-always-on;
 			};
 
 			mt6397_vcama_reg: ldo_vcama {
-				regulator-compatible = "ldo_vcama";
 				regulator-name = "vcama";
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <2800000>;
@@ -403,18 +392,15 @@ mt6397_vcama_reg: ldo_vcama {
 			};
 
 			mt6397_vio28_reg: ldo_vio28 {
-				regulator-compatible = "ldo_vio28";
 				regulator-name = "vio28";
 				regulator-always-on;
 			};
 
 			mt6397_vusb_reg: ldo_vusb {
-				regulator-compatible = "ldo_vusb";
 				regulator-name = "vusb";
 			};
 
 			mt6397_vmc_reg: ldo_vmc {
-				regulator-compatible = "ldo_vmc";
 				regulator-name = "vmc";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
@@ -422,7 +408,6 @@ mt6397_vmc_reg: ldo_vmc {
 			};
 
 			mt6397_vmch_reg: ldo_vmch {
-				regulator-compatible = "ldo_vmch";
 				regulator-name = "vmch";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -430,7 +415,6 @@ mt6397_vmch_reg: ldo_vmch {
 			};
 
 			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-				regulator-compatible = "ldo_vemc3v3";
 				regulator-name = "vemc_3v3";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -438,7 +422,6 @@ mt6397_vemc_3v3_reg: ldo_vemc3v3 {
 			};
 
 			mt6397_vgp1_reg: ldo_vgp1 {
-				regulator-compatible = "ldo_vgp1";
 				regulator-name = "vcamd";
 				regulator-min-microvolt = <1220000>;
 				regulator-max-microvolt = <3300000>;
@@ -446,7 +429,6 @@ mt6397_vgp1_reg: ldo_vgp1 {
 			};
 
 			mt6397_vgp2_reg: ldo_vgp2 {
-				regulator-compatible = "ldo_vgp2";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <3300000>;
@@ -454,7 +436,6 @@ mt6397_vgp2_reg: ldo_vgp2 {
 			};
 
 			mt6397_vgp3_reg: ldo_vgp3 {
-				regulator-compatible = "ldo_vgp3";
 				regulator-name = "vcamaf";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -462,7 +443,6 @@ mt6397_vgp3_reg: ldo_vgp3 {
 			};
 
 			mt6397_vgp4_reg: ldo_vgp4 {
-				regulator-compatible = "ldo_vgp4";
 				regulator-name = "vgp4";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -470,7 +450,6 @@ mt6397_vgp4_reg: ldo_vgp4 {
 			};
 
 			mt6397_vgp5_reg: ldo_vgp5 {
-				regulator-compatible = "ldo_vgp5";
 				regulator-name = "vgp5";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3000000>;
@@ -478,7 +457,6 @@ mt6397_vgp5_reg: ldo_vgp5 {
 			};
 
 			mt6397_vgp6_reg: ldo_vgp6 {
-				regulator-compatible = "ldo_vgp6";
 				regulator-name = "vgp6";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -486,7 +464,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-				regulator-compatible = "ldo_vibr";
 				regulator-name = "vibr";
 				regulator-min-microvolt = <1300000>;
 				regulator-max-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 65860b33c01f..3935d83a047e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -26,6 +26,10 @@ &touchscreen {
 	hid-descr-addr = <0x0001>;
 };
 
+&mt6358codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_DAMU";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
index e8241587949b..561770fcf69e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -12,3 +12,18 @@ / {
 	chassis-type = "laptop";
 	compatible = "google,juniper-sku17", "google,juniper", "mediatek,mt8183";
 };
+
+&i2c0 {
+	touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <70>;
+		hid-descr-addr = <0x0001>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
index 76d33540166f..c942e461a177 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
@@ -6,6 +6,21 @@
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
 
+&i2c0 {
+	touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <70>;
+		hid-descr-addr = <0x0001>;
+	};
+};
+
 &i2c2 {
 	trackpad@2c {
 		compatible = "hid-over-i2c";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 49e053b932e7..80888bd4ad82 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -39,8 +39,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
 	pp3300_panel: pp3300-panel {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_panel";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pp3300_panel_pins>;
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 0a6578aacf82..9cd5e0cef02a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1024,7 +1024,8 @@ pwrap: pwrap@1000d000 {
 		};
 
 		keyboard: keyboard@10010000 {
-			compatible = "mediatek,mt6779-keypad";
+			compatible = "mediatek,mt8183-keypad",
+				     "mediatek,mt6779-keypad";
 			reg = <0 0x10010000 0 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_EDGE_FALLING>;
 			clocks = <&clk26m>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 148c332018b0..ac34ba3afacb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1570,6 +1570,8 @@ ssusb0: usb@11201000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x420 2>;
 			status = "disabled";
 
 			usb_host0: usb@11200000 {
@@ -1583,8 +1585,6 @@ usb_host0: usb@11200000 {
 					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
 				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 				interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
-				mediatek,syscon-wakeup = <&pericfg 0x420 2>;
-				wakeup-source;
 				status = "disabled";
 			};
 		};
@@ -1636,6 +1636,8 @@ ssusb1: usb@11281000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg 0x424 2>;
 			status = "disabled";
 
 			usb_host1: usb@11280000 {
@@ -1649,8 +1651,6 @@ usb_host1: usb@11280000 {
 					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
 				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck","xhci_ck";
 				interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH 0>;
-				mediatek,syscon-wakeup = <&pericfg 0x424 2>;
-				wakeup-source;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 08d71ddf3668..ad52c1d6e4ee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1420,7 +1420,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -1430,7 +1429,6 @@ mt6315_6_vbuck1: vbuck1 {
 			};
 
 			mt6315_6_vbuck3: vbuck3 {
-				regulator-compatible = "vbuck3";
 				regulator-name = "Vlcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -1447,7 +1445,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <800000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 2c7b2223ee76..5056e07399e2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1285,7 +1285,6 @@ mt6315@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -1303,7 +1302,6 @@ mt6315@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 31d424b8fc7c..bfb75296795c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -137,7 +137,6 @@ charger {
 			richtek,vinovp-microvolt = <14500000>;
 
 			otg_vbus_regulator: usb-otg-vbus-regulator {
-				regulator-compatible = "usb-otg-vbus";
 				regulator-name = "usb-otg-vbus";
 				regulator-min-microvolt = <4425000>;
 				regulator-max-microvolt = <5825000>;
@@ -149,7 +148,6 @@ regulator {
 			LDO_VIN3-supply = <&mt6360_buck2>;
 
 			mt6360_buck1: buck1 {
-				regulator-compatible = "BUCK1";
 				regulator-name = "mt6360,buck1";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -160,7 +158,6 @@ MT6360_OPMODE_LP
 			};
 
 			mt6360_buck2: buck2 {
-				regulator-compatible = "BUCK2";
 				regulator-name = "mt6360,buck2";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -171,7 +168,6 @@ MT6360_OPMODE_LP
 			};
 
 			mt6360_ldo1: ldo1 {
-				regulator-compatible = "LDO1";
 				regulator-name = "mt6360,ldo1";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -180,7 +176,6 @@ mt6360_ldo1: ldo1 {
 			};
 
 			mt6360_ldo2: ldo2 {
-				regulator-compatible = "LDO2";
 				regulator-name = "mt6360,ldo2";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -189,7 +184,6 @@ mt6360_ldo2: ldo2 {
 			};
 
 			mt6360_ldo3: ldo3 {
-				regulator-compatible = "LDO3";
 				regulator-name = "mt6360,ldo3";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -198,7 +192,6 @@ mt6360_ldo3: ldo3 {
 			};
 
 			mt6360_ldo5: ldo5 {
-				regulator-compatible = "LDO5";
 				regulator-name = "mt6360,ldo5";
 				regulator-min-microvolt = <2700000>;
 				regulator-max-microvolt = <3600000>;
@@ -207,7 +200,6 @@ mt6360_ldo5: ldo5 {
 			};
 
 			mt6360_ldo6: ldo6 {
-				regulator-compatible = "LDO6";
 				regulator-name = "mt6360,ldo6";
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
@@ -216,7 +208,6 @@ mt6360_ldo6: ldo6 {
 			};
 
 			mt6360_ldo7: ldo7 {
-				regulator-compatible = "LDO7";
 				regulator-name = "mt6360,ldo7";
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index ade685ed2190..f013dbad9dc4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1611,9 +1611,6 @@ pcie1: pcie@112f8000 {
 			phy-names = "pcie-phy";
 			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
 
-			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P1_SWRST>;
-			reset-names = "mac";
-
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
@@ -3138,7 +3135,7 @@ larb20: larb@1b010000 {
 		};
 
 		ovl0: ovl@1c000000 {
-			compatible = "mediatek,mt8195-disp-ovl", "mediatek,mt8183-disp-ovl";
+			compatible = "mediatek,mt8195-disp-ovl";
 			reg = <0 0x1c000000 0 0x1000>;
 			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 9c91fe8ea0f9..2bf8c9d02b6e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -449,7 +449,8 @@ pwrap: pwrap@1000d000 {
 		};
 
 		keypad: keypad@10010000 {
-			compatible = "mediatek,mt6779-keypad";
+			compatible = "mediatek,mt8365-keypad",
+				     "mediatek,mt6779-keypad";
 			reg = <0 0x10010000 0 0x1000>;
 			wakeup-source;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index b4b48eb93f3c..6f34b06a0359 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -820,7 +820,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
@@ -837,7 +836,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 14ec970c4e49..41dc34837b02 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -812,7 +812,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
@@ -829,7 +828,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index d0b03dc4d3f4..e30623ebac0e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -144,10 +144,10 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
 		bl31_secmon_reserved: secmon@43000000 {
 			no-map;
-			reg = <0 0x43000000 0 0x20000>;
+			reg = <0 0x43000000 0 0x30000>;
 		};
 	};
 
@@ -206,7 +206,7 @@ watchdog@10007000 {
 			compatible = "mediatek,mt8516-wdt",
 				     "mediatek,mt6589-wdt";
 			reg = <0 0x10007000 0 0x1000>;
-			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_FALLING>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
 			#reset-cells = <1>;
 		};
 
@@ -268,7 +268,7 @@ gic: interrupt-controller@10310000 {
 			interrupt-parent = <&gic>;
 			interrupt-controller;
 			reg = <0 0x10310000 0 0x1000>,
-			      <0 0x10320000 0 0x1000>,
+			      <0 0x1032f000 0 0x2000>,
 			      <0 0x10340000 0 0x2000>,
 			      <0 0x10360000 0 0x2000>;
 			interrupts = <GIC_PPI 9
@@ -344,6 +344,7 @@ i2c0: i2c@11009000 {
 			reg = <0 0x11009000 0 0x90>,
 			      <0 0x11000180 0 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <2>;
 			clocks = <&topckgen CLK_TOP_I2C0>,
 				 <&topckgen CLK_TOP_APDMA>;
 			clock-names = "main", "dma";
@@ -358,6 +359,7 @@ i2c1: i2c@1100a000 {
 			reg = <0 0x1100a000 0 0x90>,
 			      <0 0x11000200 0 0x80>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <2>;
 			clocks = <&topckgen CLK_TOP_I2C1>,
 				 <&topckgen CLK_TOP_APDMA>;
 			clock-names = "main", "dma";
@@ -372,6 +374,7 @@ i2c2: i2c@1100b000 {
 			reg = <0 0x1100b000 0 0x90>,
 			      <0 0x11000280 0 0x80>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <2>;
 			clocks = <&topckgen CLK_TOP_I2C2>,
 				 <&topckgen CLK_TOP_APDMA>;
 			clock-names = "main", "dma";
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index ec8dfb3d1c6d..a356db5fcc5f 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -47,7 +47,6 @@ key-volume-down {
 };
 
 &i2c0 {
-	clock-div = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
 	status = "okay";
@@ -156,7 +155,6 @@ cam-pwdn-hog {
 };
 
 &i2c2 {
-	clock-div = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 984c85eab41a..570331baa09e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3900,7 +3900,7 @@ spi@c260000 {
 			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
 			resets = <&bpmp TEGRA234_RESET_SPI2>;
 			reset-names = "spi";
-			dmas = <&gpcdma 19>, <&gpcdma 19>;
+			dmas = <&gpcdma 16>, <&gpcdma 16>;
 			dma-names = "rx", "tx";
 			dma-coherent;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index ae002c7cf126..b13c169ec70d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -207,6 +207,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
+
+sdm845-db845c-navigation-mezzanine-dtbs	:= sdm845-db845c.dtb sdm845-db845c-navigation-mezzanine.dtbo
+
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0ee44706b70b..800bfe83dbf8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -125,7 +125,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 7af210789879..effa3aaeb250 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -34,7 +34,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index fc2a7f13f690..8a7de1dba2b9 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -34,7 +34,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 			clock-output-names = "sleep_clk";
 		};
 	};
@@ -437,6 +437,15 @@ usb3: usb@f92f8800 {
 			#size-cells = <1>;
 			ranges;
 
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq",
+					  "ss_phy_irq";
+
 			clocks = <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_SLEEP_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index f8e9d90afab0..dbad8f57f2fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -64,7 +64,7 @@ led@0 {
 		};
 
 		led@1 {
-			reg = <0>;
+			reg = <1>;
 			chan-name = "button-backlight1";
 			led-cur = /bits/ 8 <0x32>;
 			max-cur = /bits/ 8 <0xc8>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index e5966724f37c..0a8884145865 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3065,9 +3065,14 @@ usb3: usb@6af8800 {
 			#size-cells = <1>;
 			ranges;
 
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq",
+					  "ss_phy_irq";
 
 			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 4667e47a74bc..75930f957696 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -942,8 +942,6 @@ &usb_1_hsphy {
 
 	qcom,squelch-detector-bp = <(-2090)>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index cddc16bac0ce..81a161c0cc5a 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -28,7 +28,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
index f6960e2d466a..e6ac529e6b72 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
@@ -367,7 +367,7 @@ &pm8550b_eusb2_repeater {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &ufs_mem_hc {
diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
index e65305f8136c..c73eda75faf8 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -31,7 +31,7 @@ xo_board: xo-board-clk {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 1888d99d398b..f99fb9159e0b 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -545,7 +545,7 @@ can@0 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index 1c781d9e24cf..52ce51e56e2f 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -31,7 +31,7 @@ xo_board: xo-board-clk {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 0c1b21def4b6..adb71aeff339 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -517,7 +517,7 @@ &serdes1 {
 };
 
 &sleep_clk {
-	clock-frequency = <32764>;
+	clock-frequency = <32000>;
 };
 
 &spi16 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi b/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi
index ee35a454dbf6..59162b3afcb8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi
@@ -6,82 +6,82 @@
  * by Qualcomm firmware.
  */
 
-&CPU0 {
+&cpu0 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-			   &LITTLE_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&little_cpu_sleep_0
+			   &little_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU1 {
+&cpu1 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-			   &LITTLE_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&little_cpu_sleep_0
+			   &little_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU2 {
+&cpu2 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-			   &LITTLE_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&little_cpu_sleep_0
+			   &little_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU3 {
+&cpu3 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-			   &LITTLE_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&little_cpu_sleep_0
+			   &little_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU4 {
+&cpu4 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-			   &LITTLE_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&little_cpu_sleep_0
+			   &little_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU5 {
+&cpu5 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-			   &LITTLE_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&little_cpu_sleep_0
+			   &little_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU6 {
+&cpu6 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&BIG_CPU_SLEEP_0
-			   &BIG_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&big_cpu_sleep_0
+			   &big_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
-&CPU7 {
+&cpu7 {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
 
-	cpu-idle-states = <&BIG_CPU_SLEEP_0
-			   &BIG_CPU_SLEEP_1
-			   &CLUSTER_SLEEP_0>;
+	cpu-idle-states = <&big_cpu_sleep_0
+			   &big_cpu_sleep_1
+			   &cluster_sleep_0>;
 };
 
 /delete-node/ &domain_idle_states;
 
 &idle_states {
-	CLUSTER_SLEEP_0: cluster-sleep-0 {
+	cluster_sleep_0: cluster-sleep-0 {
 		compatible = "arm,idle-state";
 		idle-state-name = "cluster-power-down";
 		arm,psci-suspend-param = <0x40003444>;
@@ -92,15 +92,15 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 	};
 };
 
-/delete-node/ &CPU_PD0;
-/delete-node/ &CPU_PD1;
-/delete-node/ &CPU_PD2;
-/delete-node/ &CPU_PD3;
-/delete-node/ &CPU_PD4;
-/delete-node/ &CPU_PD5;
-/delete-node/ &CPU_PD6;
-/delete-node/ &CPU_PD7;
-/delete-node/ &CLUSTER_PD;
+/delete-node/ &cpu_pd0;
+/delete-node/ &cpu_pd1;
+/delete-node/ &cpu_pd2;
+/delete-node/ &cpu_pd3;
+/delete-node/ &cpu_pd4;
+/delete-node/ &cpu_pd5;
+/delete-node/ &cpu_pd6;
+/delete-node/ &cpu_pd7;
+/delete-node/ &cluster_pd;
 
 &apps_rsc {
 	/delete-property/ power-domains;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 3c124bbe2f4c..25b17b0425f2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -53,14 +53,14 @@ skin-temp-crit {
 			cooling-maps {
 				map0 {
 					trip = <&skin_temp_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map1 {
 					trip = <&skin_temp_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index b2df22faafe8..f57976906d63 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -71,14 +71,14 @@ skin-temp-crit {
 			cooling-maps {
 				map0 {
 					trip = <&skin_temp_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map1 {
 					trip = <&skin_temp_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index ac8d4589e3fb..f7300ffbb451 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -12,11 +12,11 @@
 
 / {
 	thermal-zones {
-		5v-choke-thermal {
+		choke-5v-thermal {
 			thermal-sensors = <&pm6150_adc_tm 1>;
 
 			trips {
-				5v-choke-crit {
+				choke-5v-crit {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 00229b1515e6..ff8996b4de4e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -78,6 +78,7 @@ panel: panel@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_rst>;
 		avdd-supply = <&ppvar_lcd>;
+		avee-supply = <&ppvar_lcd>;
 		pp1800-supply = <&v1p8_disp>;
 		pp3300-supply = <&pp3300_dx_edp>;
 		backlight = <&backlight>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index af89d80426ab..d4925be3b1fc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -78,14 +78,14 @@ skin-temp-crit {
 			cooling-maps {
 				map0 {
 					trip = <&skin_temp_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map1 {
 					trip = <&skin_temp_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index b5ebf8980325..249b257fc6a7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -77,28 +77,28 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x0>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD0>;
+			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_0: l2-cache {
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
-				L3_0: l3-cache {
+				next-level-cache = <&l3_0>;
+				l3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
 					cache-unified;
@@ -106,206 +106,206 @@ L3_0: l3-cache {
 			};
 		};
 
-		CPU1: cpu@100 {
+		cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x100>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD1>;
+			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
-			next-level-cache = <&L2_100>;
+			next-level-cache = <&l2_100>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_100: l2-cache {
+			l2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU2: cpu@200 {
+		cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x200>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD2>;
+			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
-			next-level-cache = <&L2_200>;
+			next-level-cache = <&l2_200>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_200: l2-cache {
+			l2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU3: cpu@300 {
+		cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x300>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD3>;
+			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
-			next-level-cache = <&L2_300>;
+			next-level-cache = <&l2_300>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_300: l2-cache {
+			l2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU4: cpu@400 {
+		cpu4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x400>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD4>;
+			power-domains = <&cpu_pd4>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
-			next-level-cache = <&L2_400>;
+			next-level-cache = <&l2_400>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_400: l2-cache {
+			l2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU5: cpu@500 {
+		cpu5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x500>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD5>;
+			power-domains = <&cpu_pd5>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
-			next-level-cache = <&L2_500>;
+			next-level-cache = <&l2_500>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_500: l2-cache {
+			l2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU6: cpu@600 {
+		cpu6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x600>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD6>;
+			power-domains = <&cpu_pd6>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <480>;
-			next-level-cache = <&L2_600>;
+			next-level-cache = <&l2_600>;
 			operating-points-v2 = <&cpu6_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_600: l2-cache {
+			l2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU7: cpu@700 {
+		cpu7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x700>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD7>;
+			power-domains = <&cpu_pd7>;
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <480>;
-			next-level-cache = <&L2_700>;
+			next-level-cache = <&l2_700>;
 			operating-points-v2 = <&cpu6_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_700: l2-cache {
+			l2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 
 				core2 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 
 				core3 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 
 				core4 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 
 				core5 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 
 				core6 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 
 				core7 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
@@ -313,7 +313,7 @@ core7 {
 		idle_states: idle-states {
 			entry-method = "psci";
 
-			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+			little_cpu_sleep_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "little-power-down";
 				arm,psci-suspend-param = <0x40000003>;
@@ -323,7 +323,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				local-timer-stop;
 			};
 
-			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
+			little_cpu_sleep_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "little-rail-power-down";
 				arm,psci-suspend-param = <0x40000004>;
@@ -333,7 +333,7 @@ LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				local-timer-stop;
 			};
 
-			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+			big_cpu_sleep_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "big-power-down";
 				arm,psci-suspend-param = <0x40000003>;
@@ -343,7 +343,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				local-timer-stop;
 			};
 
-			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
+			big_cpu_sleep_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "big-rail-power-down";
 				arm,psci-suspend-param = <0x40000004>;
@@ -355,7 +355,7 @@ BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 		};
 
 		domain_idle_states: domain-idle-states {
-			CLUSTER_SLEEP_PC: cluster-sleep-0 {
+			cluster_sleep_pc: cluster-sleep-0 {
 				compatible = "domain-idle-state";
 				idle-state-name = "cluster-l3-power-collapse";
 				arm,psci-suspend-param = <0x41000044>;
@@ -364,7 +364,7 @@ CLUSTER_SLEEP_PC: cluster-sleep-0 {
 				min-residency-us = <6118>;
 			};
 
-			CLUSTER_SLEEP_CX_RET: cluster-sleep-1 {
+			cluster_sleep_cx_ret: cluster-sleep-1 {
 				compatible = "domain-idle-state";
 				idle-state-name = "cluster-cx-retention";
 				arm,psci-suspend-param = <0x41001244>;
@@ -373,7 +373,7 @@ CLUSTER_SLEEP_CX_RET: cluster-sleep-1 {
 				min-residency-us = <8467>;
 			};
 
-			CLUSTER_AOSS_SLEEP: cluster-sleep-2 {
+			cluster_aoss_sleep: cluster-sleep-2 {
 				compatible = "domain-idle-state";
 				idle-state-name = "cluster-power-down";
 				arm,psci-suspend-param = <0x4100b244>;
@@ -583,59 +583,59 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		CPU_PD1: cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		CPU_PD2: cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		CPU_PD3: cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		CPU_PD4: cpu4 {
+		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		CPU_PD5: cpu5 {
+		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		CPU_PD6: cpu6 {
+		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
 		};
 
-		CPU_PD7: cpu7 {
+		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
 		};
 
-		CLUSTER_PD: cpu-cluster0 {
+		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_PC
-					      &CLUSTER_SLEEP_CX_RET
-					      &CLUSTER_AOSS_SLEEP>;
+			domain-idle-states = <&cluster_sleep_pc
+					      &cluster_sleep_cx_ret
+					      &cluster_aoss_sleep>;
 		};
 	};
 
@@ -2546,7 +2546,7 @@ etm@7040000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07040000 0 0x1000>;
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2566,7 +2566,7 @@ etm@7140000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07140000 0 0x1000>;
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2586,7 +2586,7 @@ etm@7240000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07240000 0 0x1000>;
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2606,7 +2606,7 @@ etm@7340000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07340000 0 0x1000>;
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2626,7 +2626,7 @@ etm@7440000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07440000 0 0x1000>;
 
-			cpu = <&CPU4>;
+			cpu = <&cpu4>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2646,7 +2646,7 @@ etm@7540000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07540000 0 0x1000>;
 
-			cpu = <&CPU5>;
+			cpu = <&cpu5>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2666,7 +2666,7 @@ etm@7640000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07640000 0 0x1000>;
 
-			cpu = <&CPU6>;
+			cpu = <&cpu6>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -2686,7 +2686,7 @@ etm@7740000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07740000 0 0x1000>;
 
-			cpu = <&CPU7>;
+			cpu = <&cpu7>;
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -3734,7 +3734,7 @@ apps_rsc: rsc@18200000 {
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
-			power-domains = <&CLUSTER_PD>;
+			power-domains = <&cluster_pd>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sc7180-rpmh-clk";
@@ -4063,21 +4063,21 @@ cpu0_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu0_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu0_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4111,21 +4111,21 @@ cpu1_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu1_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu1_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4159,21 +4159,21 @@ cpu2_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu2_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4207,21 +4207,21 @@ cpu3_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu3_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu3_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4255,21 +4255,21 @@ cpu4_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu4_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu4_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4303,21 +4303,21 @@ cpu5_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu5_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu5_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4351,13 +4351,13 @@ cpu6_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu6_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu6_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4391,13 +4391,13 @@ cpu7_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu7_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu7_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4431,13 +4431,13 @@ cpu8_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu8_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu8_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -4471,13 +4471,13 @@ cpu9_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu9_alert0>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu9_alert1>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3d8410683402..8fbc95cf63fe 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -83,7 +83,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 80a57aa22839..b1e0e51a5582 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2725,7 +2725,7 @@ usb_2_qmpphy1: phy@88f1000 {
 
 		remoteproc_adsp: remoteproc@3000000 {
 			compatible = "qcom,sc8280xp-adsp-pas";
-			reg = <0 0x03000000 0 0x100>;
+			reg = <0 0x03000000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -3882,26 +3882,26 @@ camss: camss@ac5a000 {
 				    "vfe3",
 				    "csid3";
 
-			interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 760 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 761 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 640 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 641 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 758 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 759 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 760 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 761 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 762 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 764 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "csid1_lite",
 					  "vfe_lite1",
 					  "csiphy3",
@@ -5205,7 +5205,7 @@ cpufreq_hw: cpufreq@18591000 {
 
 		remoteproc_nsp0: remoteproc@1b300000 {
 			compatible = "qcom,sc8280xp-nsp0-pas";
-			reg = <0 0x1b300000 0 0x100>;
+			reg = <0 0x1b300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_nsp0_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -5336,7 +5336,7 @@ compute-cb@14 {
 
 		remoteproc_nsp1: remoteproc@21300000 {
 			compatible = "qcom,sc8280xp-nsp1-pas";
-			reg = <0 0x21300000 0 0x100>;
+			reg = <0 0x21300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 887 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_nsp1_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts
deleted file mode 100644
index a21caa6f3fa2..000000000000
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts
+++ /dev/null
@@ -1,104 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2022, Linaro Ltd.
- */
-
-/dts-v1/;
-
-#include "sdm845-db845c.dts"
-
-&camss {
-	vdda-phy-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l26a_1p2>;
-
-	status = "okay";
-
-	ports {
-		port@0 {
-			csiphy0_ep: endpoint {
-				data-lanes = <0 1 2 3>;
-				remote-endpoint = <&ov8856_ep>;
-			};
-		};
-	};
-};
-
-&cci {
-	status = "okay";
-};
-
-&cci_i2c0 {
-	camera@10 {
-		compatible = "ovti,ov8856";
-		reg = <0x10>;
-
-		/* CAM0_RST_N */
-		reset-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cam0_default>;
-
-		clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
-		clock-names = "xvclk";
-		clock-frequency = <19200000>;
-
-		/*
-		 * The &vreg_s4a_1p8 trace is powered on as a,
-		 * so it is represented by a fixed regulator.
-		 *
-		 * The 2.8V vdda-supply and 1.2V vddd-supply regulators
-		 * both have to be enabled through the power management
-		 * gpios.
-		 */
-		dovdd-supply = <&vreg_lvs1a_1p8>;
-		avdd-supply = <&cam0_avdd_2v8>;
-		dvdd-supply = <&cam0_dvdd_1v2>;
-
-		port {
-			ov8856_ep: endpoint {
-				link-frequencies = /bits/ 64
-					<360000000 180000000>;
-				data-lanes = <1 2 3 4>;
-				remote-endpoint = <&csiphy0_ep>;
-			};
-		};
-	};
-};
-
-&cci_i2c1 {
-	camera@60 {
-		compatible = "ovti,ov7251";
-
-		/* I2C address as per ov7251.txt linux documentation */
-		reg = <0x60>;
-
-		/* CAM3_RST_N */
-		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cam3_default>;
-
-		clocks = <&clock_camcc CAM_CC_MCLK3_CLK>;
-		clock-names = "xclk";
-		clock-frequency = <24000000>;
-
-		/*
-		 * The &vreg_s4a_1p8 trace always powered on.
-		 *
-		 * The 2.8V vdda-supply regulator is enabled when the
-		 * vreg_s4a_1p8 trace is pulled high.
-		 * It too is represented by a fixed regulator.
-		 *
-		 * No 1.2V vddd-supply regulator is used.
-		 */
-		vdddo-supply = <&vreg_lvs1a_1p8>;
-		vdda-supply = <&cam3_avdd_2v8>;
-
-		status = "disabled";
-
-		port {
-			ov7251_ep: endpoint {
-				data-lanes = <0 1>;
-/*				remote-endpoint = <&csiphy3_ep>; */
-			};
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
new file mode 100644
index 000000000000..51f1a4883ab8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/qcom,camcc-sdm845.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&camss {
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			csiphy0_ep: endpoint {
+				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&ov8856_ep>;
+			};
+		};
+	};
+};
+
+&cci {
+	status = "okay";
+};
+
+&cci_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	camera@10 {
+		compatible = "ovti,ov8856";
+		reg = <0x10>;
+
+		/* CAM0_RST_N */
+		reset-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam0_default>;
+
+		clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
+		clock-names = "xvclk";
+		clock-frequency = <19200000>;
+
+		/*
+		 * The &vreg_s4a_1p8 trace is powered on as a,
+		 * so it is represented by a fixed regulator.
+		 *
+		 * The 2.8V vdda-supply and 1.2V vddd-supply regulators
+		 * both have to be enabled through the power management
+		 * gpios.
+		 */
+		dovdd-supply = <&vreg_lvs1a_1p8>;
+		avdd-supply = <&cam0_avdd_2v8>;
+		dvdd-supply = <&cam0_dvdd_1v2>;
+
+		port {
+			ov8856_ep: endpoint {
+				link-frequencies = /bits/ 64
+					<360000000 180000000>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 54077549b9da..0a0cef9dfcc4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4326,16 +4326,16 @@ camss: camss@acb3000 {
 				"vfe1",
 				"vfe_lite";
 
-			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 469 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "csid0",
 				"csid1",
 				"csid2",
diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 7cf3fcb469a8..dcb925348e3f 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -34,7 +34,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index 1e05cd00b635..0bbacab6842c 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -29,7 +29,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 133610d14fc4..1f7fd429ad42 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -28,7 +28,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			clock-output-names = "sleep_clk";
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 4d519dd6e7ef..72e01437ded1 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -29,7 +29,7 @@ xo_board_clk: xo-board-clk {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
index 12dd72859a43..a53145a610a3 100644
--- a/arch/arm64/boot/dts/qcom/sm7125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
@@ -6,11 +6,11 @@
 #include "sc7180.dtsi"
 
 /* SM7125 uses Kryo 465 instead of Kryo 468 */
-&CPU0 { compatible = "qcom,kryo465"; };
-&CPU1 { compatible = "qcom,kryo465"; };
-&CPU2 { compatible = "qcom,kryo465"; };
-&CPU3 { compatible = "qcom,kryo465"; };
-&CPU4 { compatible = "qcom,kryo465"; };
-&CPU5 { compatible = "qcom,kryo465"; };
-&CPU6 { compatible = "qcom,kryo465"; };
-&CPU7 { compatible = "qcom,kryo465"; };
+&cpu0 { compatible = "qcom,kryo465"; };
+&cpu1 { compatible = "qcom,kryo465"; };
+&cpu2 { compatible = "qcom,kryo465"; };
+&cpu3 { compatible = "qcom,kryo465"; };
+&cpu4 { compatible = "qcom,kryo465"; };
+&cpu5 { compatible = "qcom,kryo465"; };
+&cpu6 { compatible = "qcom,kryo465"; };
+&cpu7 { compatible = "qcom,kryo465"; };
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 2ee2561b57b1..52b16a4fdc43 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -32,7 +32,7 @@ / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
-	qcom,msm-id = <434 0x10000>, <459 0x10000>;
+	qcom,msm-id = <459 0x10000>;
 	qcom,board-id = <8 32>;
 
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index b039773c4465..a1323a8b8e6b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -376,8 +376,8 @@ da7280@4a {
 		pinctrl-0 = <&da7280_intr_default>;
 
 		dlg,actuator-type = "LRA";
-		dlg,dlg,const-op-mode = <1>;
-		dlg,dlg,periodic-op-mode = <1>;
+		dlg,const-op-mode = <1>;
+		dlg,periodic-op-mode = <1>;
 		dlg,nom-microvolt = <2000000>;
 		dlg,abs-max-microvolt = <2000000>;
 		dlg,imax-microamp = <129000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 630f4eff20bf..faa36d17b9f2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -84,7 +84,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
@@ -4481,20 +4481,20 @@ camss: camss@ac6a000 {
 				    "vfe_lite0",
 				    "vfe_lite1";
 
-			interrupts = <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "csiphy0",
 					  "csiphy1",
 					  "csiphy2",
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 37a2aba0d4ca..041750d71e45 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -42,7 +42,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 38cb524cc568..f7d52e491b69 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -43,7 +43,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 01c921602605..29bc1ddfc7b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1172,7 +1172,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index ab447fc252f7..5648ab60ba4c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -825,7 +825,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 6052dd922ec5..3a6cb2791304 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -1005,7 +1005,7 @@ &remoteproc_mpss {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
index 3d351e90bb39..62a6b90697b0 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
@@ -565,7 +565,7 @@ &remoteproc_mpss {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index 85d487ef80a0..d90dc7b37c4a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -722,7 +722,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 127c7aacd4fc..59363267d2e0 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -1117,7 +1117,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index c63822f5b127..74275ca668c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -734,7 +734,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 8ca0d28eba9b..1689699d6de7 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -1045,7 +1045,7 @@ &remoteproc_mpss {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &spi4 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 01ac3769ffa6..cd54fd723ce4 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5624,7 +5624,7 @@ compute-cb@8 {
 
 					/* note: secure cb9 in downstream */
 
-					compute-cb@10 {
+					compute-cb@12 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <12>;
 
@@ -5634,7 +5634,7 @@ compute-cb@10 {
 						dma-coherent;
 					};
 
-					compute-cb@11 {
+					compute-cb@13 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <13>;
 
@@ -5644,7 +5644,7 @@ compute-cb@11 {
 						dma-coherent;
 					};
 
-					compute-cb@12 {
+					compute-cb@14 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <14>;
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index cdb401767c42..89e39d552785 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -680,14 +680,14 @@ &qupv3_2 {
 
 &remoteproc_adsp {
 	firmware-name = "qcom/x1e80100/microsoft/Romulus/qcadsp8380.mbn",
-			"qcom/x1e80100/microsoft/Romulus/adsp_dtb.mbn";
+			"qcom/x1e80100/microsoft/Romulus/adsp_dtbs.elf";
 
 	status = "okay";
 };
 
 &remoteproc_cdsp {
 	firmware-name = "qcom/x1e80100/microsoft/Romulus/qccdsp8380.mbn",
-			"qcom/x1e80100/microsoft/Romulus/cdsp_dtb.mbn";
+			"qcom/x1e80100/microsoft/Romulus/cdsp_dtbs.elf";
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a97ceff939d8..f0797df9619b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -38,7 +38,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 21bfa4e03972..612cdc7efabb 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -42,11 +42,6 @@ aliases {
 #endif
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 7945d44e6ee1..af2ab1629104 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,10 +12,15 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
-		serial0 = &scif0;
+		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial3:115200n8";
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
index bd6419a5c20a..8311af4c8689 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
@@ -74,6 +74,23 @@ vcc_io: regulator-3v3-vcc-io {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	/*
+	 * HW revision prior to v1.2 must pull GPIO4_D6 low to access sdmmc.
+	 * This is modeled as an always-on active low fixed regulator.
+	 */
+	vcc_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_2030>;
+		regulator-name = "vcc_sd";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+	};
+
 	vcc5v0_sys: regulator-5v0-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -181,6 +198,12 @@ pwr_led: pwr-led {
 		};
 	};
 
+	sdmmc {
+		sdmmc_2030: sdmmc-2030 {
+			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	wifi {
 		wifi_reg_on: wifi-reg-on {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -233,7 +256,7 @@ &sdmmc {
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
-	vmmc-supply = <&vcc_io>;
+	vmmc-supply = <&vcc_sd>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
index 170b14f92f51..f9ef0af8aa1a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
@@ -53,7 +53,7 @@ hdmi_tx_5v: hdmi-tx-5v-regulator {
 
 	pdm_codec: pdm-codec {
 		compatible = "dmic-codec";
-		num-channels = <1>;
+		num-channels = <2>;
 		#sound-dai-cells = <0>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e..562e6d57bc99 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -41,10 +41,6 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM64x SoC
-k3-am642-hummingboard-t-pcie-dtbs := \
-	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-pcie.dtbo
-k3-am642-hummingboard-t-usb3-dtbs := \
-	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 5b92aef5b284..60c6814206a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -23,7 +23,6 @@ gic500: interrupt-controller@1800000 {
 		interrupt-controller;
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
 		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
-		      <0x00 0x01880000 0x00 0xc0000>,   /* GICR */
 		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
 		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
 		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 16a578ae2b41..56945d29e015 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -18,7 +18,6 @@ gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
 		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
-		      <0x00 0x01880000 0x00 0xc0000>,   /* GICR */
 		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
 		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
 		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
new file mode 100644
index 000000000000..023b2a6aaa56
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53, with PCI-E.
+ *
+ */
+
+#include "k3-am642-hummingboard-t.dts"
+
+#include "k3-serdes.h"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T with PCI-E";
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_pins>;
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes_mux {
+	idle-state = <1>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
deleted file mode 100644
index bd9a5caf20da..000000000000
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
- *
- * Overlay for SolidRun AM642 HummingBoard-T to enable PCI-E.
- */
-
-/dts-v1/;
-/plugin/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/phy/phy.h>
-
-#include "k3-serdes.h"
-
-&pcie0_rc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie0_default_pins>;
-	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
-	phys = <&serdes0_link>;
-	phy-names = "pcie-phy";
-	num-lanes = <1>;
-	status = "okay";
-};
-
-&serdes0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	serdes0_link: phy@0 {
-		reg = <0>;
-		cdns,num-lanes = <1>;
-		cdns,phy-type = <PHY_TYPE_PCIE>;
-		#phy-cells = <0>;
-		resets = <&serdes_wiz0 1>;
-	};
-};
-
-&serdes_ln_ctrl {
-	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
-};
-
-&serdes_mux {
-	idle-state = <1>;
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
new file mode 100644
index 000000000000..ee9bd618f370
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53, with USB-3.1 Gen 1.
+ *
+ */
+
+#include "k3-am642-hummingboard-t.dts"
+
+#include "k3-serdes.h"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T with USB-3.1 Gen 1";
+};
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes_mux {
+	idle-state = <0>;
+};
+
+&usbss0 {
+	/delete-property/ ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	phys = <&serdes0_link>;
+	phy-names = "cdns3,usb3-phy";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
deleted file mode 100644
index ffcc3bd3c7bc..000000000000
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
- *
- * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
- */
-
-/dts-v1/;
-/plugin/;
-
-#include <dt-bindings/phy/phy.h>
-
-#include "k3-serdes.h"
-
-&serdes0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	serdes0_link: phy@0 {
-		reg = <0>;
-		cdns,num-lanes = <1>;
-		cdns,phy-type = <PHY_TYPE_USB3>;
-		#phy-cells = <0>;
-		resets = <&serdes_wiz0 1>;
-	};
-};
-
-&serdes_ln_ctrl {
-	idle-states = <AM64_SERDES0_LANE0_USB>;
-};
-
-&serdes_mux {
-	idle-state = <0>;
-};
-
-&usbss0 {
-	/delete-property/ ti,usb2-only;
-};
-
-&usb0 {
-	maximum-speed = "super-speed";
-	phys = <&serdes0_link>;
-	phy-names = "cdns3,usb3-phy";
-};
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..8fe7dbae33bf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1347,7 +1347,6 @@ CONFIG_SM_DISPCC_6115=m
 CONFIG_SM_DISPCC_8250=y
 CONFIG_SM_DISPCC_8450=m
 CONFIG_SM_DISPCC_8550=m
-CONFIG_SM_DISPCC_8650=m
 CONFIG_SM_GCC_4450=y
 CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index bf6cf5579cf4..9c58fb81f7fd 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -56,7 +56,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
-	__typeof__(*(ptr)) __oldval = 0;			\
+	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 75e062722d28..040a958de1df 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -195,8 +195,10 @@ int die(const char *str, struct pt_regs *regs, long err)
 	printk(KERN_EMERG "Oops: %s[#%d]:\n", str, ++die.counter);
 
 	if (notify_die(DIE_OOPS, str, regs, err, pt_cause(regs), SIGSEGV) ==
-	    NOTIFY_STOP)
+	    NOTIFY_STOP) {
+		spin_unlock_irq(&die.lock);
 		return 1;
+	}
 
 	print_modules();
 	show_regs(regs);
diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/include/asm/hw_breakpoint.h
index d78330916bd1..13b2462f3d8c 100644
--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -38,8 +38,8 @@ struct arch_hw_breakpoint {
  * Limits.
  * Changing these will require modifications to the register accessors.
  */
-#define LOONGARCH_MAX_BRP		8
-#define LOONGARCH_MAX_WRP		8
+#define LOONGARCH_MAX_BRP		14
+#define LOONGARCH_MAX_WRP		14
 
 /* Virtual debug register bases. */
 #define CSR_CFG_ADDR	0
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 64ad277e096e..aaa4ad6b8594 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -959,6 +959,36 @@
 #define LOONGARCH_CSR_DB7CTRL		0x34a	/* data breakpoint 7 control */
 #define LOONGARCH_CSR_DB7ASID		0x34b	/* data breakpoint 7 asid */
 
+#define LOONGARCH_CSR_DB8ADDR		0x350	/* data breakpoint 8 address */
+#define LOONGARCH_CSR_DB8MASK		0x351	/* data breakpoint 8 mask */
+#define LOONGARCH_CSR_DB8CTRL		0x352	/* data breakpoint 8 control */
+#define LOONGARCH_CSR_DB8ASID		0x353	/* data breakpoint 8 asid */
+
+#define LOONGARCH_CSR_DB9ADDR		0x358	/* data breakpoint 9 address */
+#define LOONGARCH_CSR_DB9MASK		0x359	/* data breakpoint 9 mask */
+#define LOONGARCH_CSR_DB9CTRL		0x35a	/* data breakpoint 9 control */
+#define LOONGARCH_CSR_DB9ASID		0x35b	/* data breakpoint 9 asid */
+
+#define LOONGARCH_CSR_DB10ADDR		0x360	/* data breakpoint 10 address */
+#define LOONGARCH_CSR_DB10MASK		0x361	/* data breakpoint 10 mask */
+#define LOONGARCH_CSR_DB10CTRL		0x362	/* data breakpoint 10 control */
+#define LOONGARCH_CSR_DB10ASID		0x363	/* data breakpoint 10 asid */
+
+#define LOONGARCH_CSR_DB11ADDR		0x368	/* data breakpoint 11 address */
+#define LOONGARCH_CSR_DB11MASK		0x369	/* data breakpoint 11 mask */
+#define LOONGARCH_CSR_DB11CTRL		0x36a	/* data breakpoint 11 control */
+#define LOONGARCH_CSR_DB11ASID		0x36b	/* data breakpoint 11 asid */
+
+#define LOONGARCH_CSR_DB12ADDR		0x370	/* data breakpoint 12 address */
+#define LOONGARCH_CSR_DB12MASK		0x371	/* data breakpoint 12 mask */
+#define LOONGARCH_CSR_DB12CTRL		0x372	/* data breakpoint 12 control */
+#define LOONGARCH_CSR_DB12ASID		0x373	/* data breakpoint 12 asid */
+
+#define LOONGARCH_CSR_DB13ADDR		0x378	/* data breakpoint 13 address */
+#define LOONGARCH_CSR_DB13MASK		0x379	/* data breakpoint 13 mask */
+#define LOONGARCH_CSR_DB13CTRL		0x37a	/* data breakpoint 13 control */
+#define LOONGARCH_CSR_DB13ASID		0x37b	/* data breakpoint 13 asid */
+
 #define LOONGARCH_CSR_FWPC		0x380	/* instruction breakpoint config */
 #define LOONGARCH_CSR_FWPS		0x381	/* instruction breakpoint status */
 
@@ -1002,6 +1032,36 @@
 #define LOONGARCH_CSR_IB7CTRL		0x3ca	/* inst breakpoint 7 control */
 #define LOONGARCH_CSR_IB7ASID		0x3cb	/* inst breakpoint 7 asid */
 
+#define LOONGARCH_CSR_IB8ADDR		0x3d0	/* inst breakpoint 8 address */
+#define LOONGARCH_CSR_IB8MASK		0x3d1	/* inst breakpoint 8 mask */
+#define LOONGARCH_CSR_IB8CTRL		0x3d2	/* inst breakpoint 8 control */
+#define LOONGARCH_CSR_IB8ASID		0x3d3	/* inst breakpoint 8 asid */
+
+#define LOONGARCH_CSR_IB9ADDR		0x3d8	/* inst breakpoint 9 address */
+#define LOONGARCH_CSR_IB9MASK		0x3d9	/* inst breakpoint 9 mask */
+#define LOONGARCH_CSR_IB9CTRL		0x3da	/* inst breakpoint 9 control */
+#define LOONGARCH_CSR_IB9ASID		0x3db	/* inst breakpoint 9 asid */
+
+#define LOONGARCH_CSR_IB10ADDR		0x3e0	/* inst breakpoint 10 address */
+#define LOONGARCH_CSR_IB10MASK		0x3e1	/* inst breakpoint 10 mask */
+#define LOONGARCH_CSR_IB10CTRL		0x3e2	/* inst breakpoint 10 control */
+#define LOONGARCH_CSR_IB10ASID		0x3e3	/* inst breakpoint 10 asid */
+
+#define LOONGARCH_CSR_IB11ADDR		0x3e8	/* inst breakpoint 11 address */
+#define LOONGARCH_CSR_IB11MASK		0x3e9	/* inst breakpoint 11 mask */
+#define LOONGARCH_CSR_IB11CTRL		0x3ea	/* inst breakpoint 11 control */
+#define LOONGARCH_CSR_IB11ASID		0x3eb	/* inst breakpoint 11 asid */
+
+#define LOONGARCH_CSR_IB12ADDR		0x3f0	/* inst breakpoint 12 address */
+#define LOONGARCH_CSR_IB12MASK		0x3f1	/* inst breakpoint 12 mask */
+#define LOONGARCH_CSR_IB12CTRL		0x3f2	/* inst breakpoint 12 control */
+#define LOONGARCH_CSR_IB12ASID		0x3f3	/* inst breakpoint 12 asid */
+
+#define LOONGARCH_CSR_IB13ADDR		0x3f8	/* inst breakpoint 13 address */
+#define LOONGARCH_CSR_IB13MASK		0x3f9	/* inst breakpoint 13 mask */
+#define LOONGARCH_CSR_IB13CTRL		0x3fa	/* inst breakpoint 13 control */
+#define LOONGARCH_CSR_IB13ASID		0x3fb	/* inst breakpoint 13 asid */
+
 #define LOONGARCH_CSR_DEBUG		0x500	/* debug config */
 #define LOONGARCH_CSR_DERA		0x501	/* debug era */
 #define LOONGARCH_CSR_DESAVE		0x502	/* debug save */
diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
index a6e4b605bfa8..c35f9bf38033 100644
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -51,7 +51,13 @@ int hw_breakpoint_slots(int type)
 	READ_WB_REG_CASE(OFF, 4, REG, T, VAL);		\
 	READ_WB_REG_CASE(OFF, 5, REG, T, VAL);		\
 	READ_WB_REG_CASE(OFF, 6, REG, T, VAL);		\
-	READ_WB_REG_CASE(OFF, 7, REG, T, VAL);
+	READ_WB_REG_CASE(OFF, 7, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 8, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 9, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 10, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 11, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 12, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 13, REG, T, VAL);
 
 #define GEN_WRITE_WB_REG_CASES(OFF, REG, T, VAL)	\
 	WRITE_WB_REG_CASE(OFF, 0, REG, T, VAL);		\
@@ -61,7 +67,13 @@ int hw_breakpoint_slots(int type)
 	WRITE_WB_REG_CASE(OFF, 4, REG, T, VAL);		\
 	WRITE_WB_REG_CASE(OFF, 5, REG, T, VAL);		\
 	WRITE_WB_REG_CASE(OFF, 6, REG, T, VAL);		\
-	WRITE_WB_REG_CASE(OFF, 7, REG, T, VAL);
+	WRITE_WB_REG_CASE(OFF, 7, REG, T, VAL);		\
+	WRITE_WB_REG_CASE(OFF, 8, REG, T, VAL);		\
+	WRITE_WB_REG_CASE(OFF, 9, REG, T, VAL);		\
+	WRITE_WB_REG_CASE(OFF, 10, REG, T, VAL);	\
+	WRITE_WB_REG_CASE(OFF, 11, REG, T, VAL);	\
+	WRITE_WB_REG_CASE(OFF, 12, REG, T, VAL);	\
+	WRITE_WB_REG_CASE(OFF, 13, REG, T, VAL);
 
 static u64 read_wb_reg(int reg, int n, int t)
 {
diff --git a/arch/loongarch/power/platform.c b/arch/loongarch/power/platform.c
index 0909729dc2e1..5bbdb9fd76e5 100644
--- a/arch/loongarch/power/platform.c
+++ b/arch/loongarch/power/platform.c
@@ -17,7 +17,7 @@ void enable_gpe_wakeup(void)
 	if (acpi_gbl_reduced_hardware)
 	       return;
 
-	acpi_enable_all_wakeup_gpes();
+	acpi_hw_enable_all_wakeup_gpes();
 }
 
 void enable_pci_wakeup(void)
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 18a3028ac3b6..dad2e7980f24 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -15,6 +15,15 @@
 
 extern bool hugetlb_disabled;
 
+static inline bool hugepages_supported(void)
+{
+	if (hugetlb_disabled)
+		return false;
+
+	return HPAGE_SHIFT != 0;
+}
+#define hugepages_supported hugepages_supported
+
 void __init hugetlbpage_init_defaultsize(void);
 
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 76381e14e800..0ebae6e4c19d 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -687,7 +687,7 @@ void iommu_table_clear(struct iommu_table *tbl)
 void iommu_table_reserve_pages(struct iommu_table *tbl,
 		unsigned long res_start, unsigned long res_end)
 {
-	int i;
+	unsigned long i;
 
 	WARN_ON_ONCE(res_end < res_start);
 	/*
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 534cd159e9ab..ae6f7a235d8b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1650,7 +1650,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		iommu_table_setparms_common(newtbl, pci->phb->bus->number, create.liobn,
 					    dynamic_addr, dynamic_len, page_shift, NULL,
 					    &iommu_table_lpar_multi_ops);
-		iommu_init_table(newtbl, pci->phb->node, start, end);
+		iommu_init_table(newtbl, pci->phb->node,
+				 start >> page_shift, end >> page_shift);
 
 		pci->table_group->tables[default_win_removed ? 0 : 1] = newtbl;
 
@@ -2065,7 +2066,9 @@ static long spapr_tce_create_table(struct iommu_table_group *table_group, int nu
 							    offset, 1UL << window_shift,
 							    IOMMU_PAGE_SHIFT_4K, NULL,
 							    &iommu_table_lpar_multi_ops);
-				iommu_init_table(tbl, pci->phb->node, start, end);
+				iommu_init_table(tbl, pci->phb->node,
+						 start >> IOMMU_PAGE_SHIFT_4K,
+						 end >> IOMMU_PAGE_SHIFT_4K);
 
 				table_group->tables[0] = tbl;
 
@@ -2136,7 +2139,7 @@ static long spapr_tce_create_table(struct iommu_table_group *table_group, int nu
 	/* New table for using DDW instead of the default DMA window */
 	iommu_table_setparms_common(tbl, pci->phb->bus->number, create.liobn, win_addr,
 				    1UL << len, page_shift, NULL, &iommu_table_lpar_multi_ops);
-	iommu_init_table(tbl, pci->phb->node, start, end);
+	iommu_init_table(tbl, pci->phb->node, start >> page_shift, end >> page_shift);
 
 	pci->table_group->tables[num] = tbl;
 	set_iommu_table_base(&pdev->dev, tbl);
@@ -2205,6 +2208,9 @@ static long spapr_tce_unset_window(struct iommu_table_group *table_group, int nu
 	const char *win_name;
 	int ret = -ENODEV;
 
+	if (!tbl) /* The table was never created OR window was never opened */
+		return 0;
+
 	mutex_lock(&dma_win_init_mutex);
 
 	if ((num == 0) && is_default_window_table(table_group, tbl))
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 682b3feee451..a30fb2fb8a2b 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -309,7 +309,7 @@ static int __init riscv_v_sysctl_init(void)
 static int __init riscv_v_sysctl_init(void) { return 0; }
 #endif /* ! CONFIG_SYSCTL */
 
-static int riscv_v_init(void)
+static int __init riscv_v_init(void)
 {
 	return riscv_v_sysctl_init();
 }
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cc1f9cffe2a5..62f2c9e8e05f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -65,6 +65,7 @@ config S390
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 7fd57398221e..9b7720932787 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
 endif
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -D__DECOMPRESSOR
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index eb00fa1771da..ad17d91ad2e6 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -137,6 +137,7 @@ void sclp_early_printk(const char *s);
 void __sclp_early_printk(const char *s, unsigned int len);
 void sclp_emergency_printk(const char *s);
 
+int sclp_init(void);
 int sclp_early_get_memsize(unsigned long *mem);
 int sclp_early_get_hsa_size(unsigned long *hsa_size);
 int _sclp_get_core_info(struct sclp_core_info *info);
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index e2e0aa463fbd..c3075e4a8efc 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -981,7 +981,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = cpuhw->usedss;
 		raw.frag.data = cpuhw->stop;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index fa7325454266..10725f5a6f0f 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -478,7 +478,7 @@ static int paicrypt_push_sample(size_t rawsize, struct paicrypt_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 7f462bef1fc0..a8f0bad99cf0 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -503,7 +503,7 @@ static int paiext_push_sample(size_t rawsize, struct paiext_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a3fea683b227..99f165726ca9 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1006,3 +1006,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Add system specific data to the random pool */
 	setup_randomness();
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	sclp_init();
+}
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 24eccaa29337..bdcf2a3b6c41 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,7 +13,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..c3a2f6f57770 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1118,7 +1118,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 				.data = ibs_data.data,
 			},
 		};
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	if (perf_ibs == &perf_ibs_op)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 427d1daf06d0..6b981868905f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1735,7 +1735,7 @@ struct kvm_x86_ops {
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
-	void (*hwapic_isr_update)(int isr);
+	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 766f092dab80..f1fac08fdef2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -495,14 +495,6 @@ static int x86_cluster_flags(void)
 }
 #endif
 
-static int x86_die_flags(void)
-{
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-	       return x86_sched_itmt_flags();
-
-	return 0;
-}
-
 /*
  * Set if a package/die has multiple NUMA nodes inside.
  * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
@@ -538,7 +530,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(PKG)
+			cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(PKG)
 		};
 	}
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 95c6beb8ce27..375bbb9600d3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -763,7 +763,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(apic->apicv_active))
-		kvm_x86_call(hwapic_isr_update)(vec);
+		kvm_x86_call(hwapic_isr_update)(apic->vcpu, vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -808,7 +808,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(apic->apicv_active))
-		kvm_x86_call(hwapic_isr_update)(apic_find_highest_isr(apic));
+		kvm_x86_call(hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -2786,7 +2786,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (apic->apicv_active) {
 		kvm_x86_call(apicv_post_state_restore)(vcpu);
 		kvm_x86_call(hwapic_irr_update)(vcpu, -1);
-		kvm_x86_call(hwapic_isr_update)(-1);
+		kvm_x86_call(hwapic_isr_update)(vcpu, -1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -3102,9 +3102,8 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	kvm_apic_update_apicv(vcpu);
 	if (apic->apicv_active) {
 		kvm_x86_call(apicv_post_state_restore)(vcpu);
-		kvm_x86_call(hwapic_irr_update)(vcpu,
-						apic_find_highest_irr(apic));
-		kvm_x86_call(hwapic_isr_update)(apic_find_highest_isr(apic));
+		kvm_x86_call(hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
+		kvm_x86_call(hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 92fee5e8a3c7..968ddf714054 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6847,7 +6847,7 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	kvm_release_pfn_clean(pfn);
 }
 
-void vmx_hwapic_isr_update(int max_isr)
+void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 	u16 status;
 	u8 old;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index a55981c5216e..48dc76bf0ec0 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -48,7 +48,7 @@ void vmx_migrate_timers(struct kvm_vcpu *vcpu);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
-void vmx_hwapic_isr_update(int max_isr);
+void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr);
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
 void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector);
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 88e3ad73c385..9aed61fcd0bf 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -118,17 +118,18 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
-	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
-	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
-	struct iov_iter iter;
+	unsigned short orig_nr_vecs = bip->bip_max_vcnt - 1;
+	struct bio_vec *orig_bvecs = &bip->bip_vec[1];
+	struct bio_vec *bounce_bvec = &bip->bip_vec[0];
+	size_t bytes = bounce_bvec->bv_len;
+	struct iov_iter orig_iter;
 	int ret;
 
-	iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
-	ret = copy_to_iter(bvec_virt(bip->bip_vec), bytes, &iter);
+	iov_iter_bvec(&orig_iter, ITER_DEST, orig_bvecs, orig_nr_vecs, bytes);
+	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
 	WARN_ON_ONCE(ret != bytes);
 
-	bio_integrity_unpin_bvec(copy, nr_vecs, true);
+	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs, true);
 }
 
 /**
diff --git a/block/blk-core.c b/block/blk-core.c
index 4f791a3114a1..42023addf9cd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -629,8 +629,14 @@ static void __submit_bio(struct bio *bio)
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-		disk->fops->submit_bio(bio);
+	
+		if ((bio->bi_opf & REQ_POLLED) &&
+		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
+			bio->bi_status = BLK_STS_NOTSUPP;
+			bio_endio(bio);
+		} else {
+			disk->fops->submit_bio(bio);
+		}
 		blk_queue_exit(disk->queue);
 	}
 
@@ -805,12 +811,6 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
-	if (!(q->limits.features & BLK_FEAT_POLL) &&
-			(bio->bi_opf & REQ_POLLED)) {
-		bio_clear_polled(bio);
-		goto not_supported;
-	}
-
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		break;
@@ -935,7 +935,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 		return 0;
 
 	q = bdev_get_queue(bdev);
-	if (cookie == BLK_QC_T_NONE || !(q->limits.features & BLK_FEAT_POLL))
+	if (cookie == BLK_QC_T_NONE)
 		return 0;
 
 	blk_flush_plug(current->plug, false);
@@ -956,7 +956,8 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	} else {
 		struct gendisk *disk = q->disk;
 
-		if (disk && disk->fops->poll_bio)
+		if ((q->limits.features & BLK_FEAT_POLL) && disk &&
+		    disk->fops->poll_bio)
 			ret = disk->fops->poll_bio(bio, iob, flags);
 	}
 	blk_queue_exit(q);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e76651e786d..662e52ab0646 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3092,14 +3092,21 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	/*
-	 * Device reconfiguration may change logical block size, so alignment
-	 * check has to be done with queue usage counter held
+	 * Device reconfiguration may change logical block size or reduce the
+	 * number of poll queues, so the checks for alignment and poll support
+	 * have to be done with queue usage counter held.
 	 */
 	if (unlikely(bio_unaligned(bio, q))) {
 		bio_io_error(bio);
 		goto queue_exit;
 	}
 
+	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
+		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_endio(bio);
+		goto queue_exit;
+	}
+
 	bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 	if (!bio)
 		goto queue_exit;
@@ -4325,12 +4332,6 @@ void blk_mq_release(struct request_queue *q)
 	blk_mq_sysfs_deinit(q);
 }
 
-static bool blk_mq_can_poll(struct blk_mq_tag_set *set)
-{
-	return set->nr_maps > HCTX_TYPE_POLL &&
-		set->map[HCTX_TYPE_POLL].nr_queues;
-}
-
 struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
 		struct queue_limits *lim, void *queuedata)
 {
@@ -4341,7 +4342,7 @@ struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
 	if (!lim)
 		lim = &default_lim;
 	lim->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT;
-	if (blk_mq_can_poll(set))
+	if (set->nr_maps > HCTX_TYPE_POLL)
 		lim->features |= BLK_FEAT_POLL;
 
 	q = blk_alloc_queue(lim, set->numa_node);
@@ -5029,8 +5030,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		struct queue_limits lim;
-
 		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
@@ -5044,13 +5043,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			set->nr_hw_queues = prev_nr_hw_queues;
 			goto fallback;
 		}
-		lim = queue_limits_start_update(q);
-		if (blk_mq_can_poll(set))
-			lim.features |= BLK_FEAT_POLL;
-		else
-			lim.features &= ~BLK_FEAT_POLL;
-		if (queue_limits_commit_update(q, &lim) < 0)
-			pr_warn("updating the poll flag failed\n");
 		blk_mq_map_swqueue(q);
 	}
 
@@ -5110,9 +5102,9 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie,
 		struct io_comp_batch *iob, unsigned int flags)
 {
-	struct blk_mq_hw_ctx *hctx = xa_load(&q->hctx_table, cookie);
-
-	return blk_hctx_poll(q, hctx, iob, flags);
+	if (!blk_mq_can_poll(q))
+		return 0;
+	return blk_hctx_poll(q, xa_load(&q->hctx_table, cookie), iob, flags);
 }
 
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f4ac1af77a26..364c0415293c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -451,4 +451,10 @@ do {								\
 #define blk_mq_run_dispatch_ops(q, dispatch_ops)		\
 	__blk_mq_run_dispatch_ops(q, true, dispatch_ops)	\
 
+static inline bool blk_mq_can_poll(struct request_queue *q)
+{
+	return (q->limits.features & BLK_FEAT_POLL) &&
+		q->tag_set->map[HCTX_TYPE_POLL].nr_queues;
+}
+
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 207577145c54..692b27266220 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -256,10 +256,17 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 		!!(disk->queue->limits.features & _feature));		\
 }
 
-QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
 QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
 QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
 
+static ssize_t queue_poll_show(struct gendisk *disk, char *page)
+{
+	if (queue_is_mq(disk->queue))
+		return sysfs_emit(page, "%u\n", blk_mq_can_poll(disk->queue));
+	return sysfs_emit(page, "%u\n",
+		!!(disk->queue->limits.features & BLK_FEAT_POLL));
+}
+
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
 	if (blk_queue_is_zoned(disk->queue))
diff --git a/block/genhd.c b/block/genhd.c
index 8645cf3b0816..99344f53c789 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -778,7 +778,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 }
 
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
-void blk_request_module(dev_t devt)
+static bool blk_probe_dev(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -788,14 +788,26 @@ void blk_request_module(dev_t devt)
 		if ((*n)->major == major && (*n)->probe) {
 			(*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
-			return;
+			return true;
 		}
 	}
 	mutex_unlock(&major_names_lock);
+	return false;
+}
+
+void blk_request_module(dev_t devt)
+{
+	int error;
+
+	if (blk_probe_dev(devt))
+		return;
 
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
+	error = request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt));
+	/* Make old-style 2.4 aliases work */
+	if (error > 0)
+		error = request_module("block-major-%d", MAJOR(devt));
+	if (!error)
+		blk_probe_dev(devt);
 }
 #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index e259180c8914..aa3bd050d8cd 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 004d27e41315..c067412d909a 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -1022,6 +1022,8 @@ static void __init crypto_start_tests(void)
 	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
 		return;
 
+	set_crypto_boot_test_finished();
+
 	for (;;) {
 		struct crypto_larval *larval = NULL;
 		struct crypto_alg *q;
@@ -1053,8 +1055,6 @@ static void __init crypto_start_tests(void)
 		if (!larval)
 			break;
 	}
-
-	set_crypto_boot_test_finished();
 }
 
 static int __init crypto_algapi_init(void)
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 79bbfe00d241..b8543a34caea 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -103,8 +103,6 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 
 acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
-acpi_status acpi_hw_enable_all_wakeup_gpes(void);
-
 u8 acpi_hw_check_all_gpes(acpi_handle gpe_skip_device, u32 gpe_skip_number);
 
 acpi_status
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 7cea4495f19b..300e5d919986 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -371,19 +371,25 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	result = sysfs_create_link(&pdev->dev.kobj,
 				   &cdev->device.kobj,
 				   "thermal_cooling");
-	if (result)
+	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'thermal_cooling'\n");
+		goto err_unregister;
+	}
 
 	result = sysfs_create_link(&cdev->device.kobj,
 				   &pdev->dev.kobj,
 				   "device");
 	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
-		goto err_end;
+		goto err_remove_link;
 	}
 
 	return 0;
 
+err_remove_link:
+	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
+err_unregister:
+	thermal_cooling_device_unregister(cdev);
 err_end:
 	if (fan->acpi4)
 		acpi_fan_delete_attributes(device);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index cb5359235c70..ce460e1ab137 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -323,8 +323,12 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 	struct subsys_private *sp = class_to_subsys(class);
 	struct klist_node *start_knode = NULL;
 
-	if (!sp)
+	memset(iter, 0, sizeof(*iter));
+	if (!sp) {
+		pr_crit("%s: class %p was not registered yet\n",
+			__func__, class);
 		return;
+	}
 
 	if (start)
 		start_knode = &start->p->knode_class;
@@ -351,6 +355,9 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
 	struct klist_node *knode;
 	struct device *dev;
 
+	if (!iter->sp)
+		return NULL;
+
 	while (1) {
 		knode = klist_next(&iter->ki);
 		if (!knode)
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..450458267e6e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2180,6 +2180,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	flush_workqueue(nbd->recv_workq);
 	nbd_clear_que(nbd);
 	nbd->task_setup = NULL;
+	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
 	mutex_unlock(&nbd->config_lock);
 
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index ff45ed766469..226ffc743238 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -384,9 +384,9 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	unsigned int devidx;
 	struct queue_limits lim = {
 		.logical_block_size	= dev->blk_size,
-		.max_hw_sectors		= dev->bounce_size >> 9,
+		.max_hw_sectors		= BOUNCE_SIZE >> 9,
 		.max_segments		= -1,
-		.max_segment_size	= dev->bounce_size,
+		.max_segment_size	= BOUNCE_SIZE,
 		.dma_alignment		= dev->blk_size - 1,
 		.features		= BLK_FEAT_WRITE_CACHE |
 					  BLK_FEAT_ROTATIONAL,
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index a1153ada74d2..0a60660fc8ce 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -553,6 +553,9 @@ static const char *btbcm_get_board_name(struct device *dev)
 
 	/* get rid of any '/' in the compatible string */
 	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+	if (!board_type)
+		return NULL;
+
 	strreplace(board_type, '/', '-');
 
 	return board_type;
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index a028984f2782..84a1ad61c4ad 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1336,13 +1336,12 @@ static void btnxpuart_tx_work(struct work_struct *work)
 
 	while ((skb = nxp_dequeue(nxpdev))) {
 		len = serdev_device_write_buf(serdev, skb->data, skb->len);
-		serdev_device_wait_until_sent(serdev, 0);
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
 		if (skb->len > 0) {
 			skb_queue_head(&nxpdev->txq, skb);
-			break;
+			continue;
 		}
 
 		switch (hci_skb_pkt_type(skb)) {
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 0bcb44cf7b31..0a6ca6dfb948 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1351,12 +1351,14 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	btrtl_set_quirks(hdev, btrtl_dev);
 
-	hci_set_hw_info(hdev,
+	if (btrtl_dev->ic_info) {
+		hci_set_hw_info(hdev,
 			"RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
 			btrtl_dev->ic_info->lmp_subver,
 			btrtl_dev->ic_info->hci_rev,
 			btrtl_dev->ic_info->hci_ver,
 			btrtl_dev->ic_info->hci_bus);
+	}
 
 	btrtl_free(btrtl_dev);
 	return ret;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0c85c981a833..258a5cb6f27a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2632,8 +2632,15 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
 	int err;
 
+	/*
+	 * The function usb_driver_claim_interface() is documented to need
+	 * locks held if it's not called from a probe routine. The code here
+	 * is called from the hci_power_on workqueue, so grab the lock.
+	 */
+	device_lock(&btmtk_data->isopkt_intf->dev);
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
+	device_unlock(&btmtk_data->isopkt_intf->dev);
 	if (err < 0) {
 		btmtk_data->isopkt_intf = NULL;
 		bt_dev_err(data->hdev, "Failed to claim iso interface");
diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
index 749a3295c2bd..3ca7068a3052 100644
--- a/drivers/cdx/Makefile
+++ b/drivers/cdx/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
 #
 
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CDX_BUS
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"CDX_BUS"'
 
 obj-$(CONFIG_CDX_BUS) += cdx.o controller/
 
diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 7296127181ec..8a14fd0291d8 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -321,6 +321,9 @@ static int ipmb_probe(struct i2c_client *client)
 	ipmb_dev->miscdev.name = devm_kasprintf(&client->dev, GFP_KERNEL,
 						"%s%d", "ipmb-",
 						client->adapter->nr);
+	if (!ipmb_dev->miscdev.name)
+		return -ENOMEM;
+
 	ipmb_dev->miscdev.fops = &ipmb_fops;
 	ipmb_dev->miscdev.parent = &client->dev;
 	ret = misc_register(&ipmb_dev->miscdev);
diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index a14fafc583d4..310f17dd9511 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -292,7 +292,6 @@ static void complete_response(struct ssif_bmc_ctx *ssif_bmc)
 	ssif_bmc->nbytes_processed = 0;
 	ssif_bmc->remain_len = 0;
 	ssif_bmc->busy = false;
-	memset(&ssif_bmc->part_buf, 0, sizeof(struct ssif_part_buffer));
 	wake_up_all(&ssif_bmc->wait_queue);
 }
 
@@ -744,9 +743,11 @@ static void on_stop_event(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
 			ssif_bmc->aborting = true;
 		}
 	} else if (ssif_bmc->state == SSIF_RES_SENDING) {
-		if (ssif_bmc->is_singlepart_read || ssif_bmc->block_num == 0xFF)
+		if (ssif_bmc->is_singlepart_read || ssif_bmc->block_num == 0xFF) {
+			memset(&ssif_bmc->part_buf, 0, sizeof(struct ssif_part_buffer));
 			/* Invalidate response buffer to denote it is sent */
 			complete_response(ssif_bmc);
+		}
 		ssif_bmc->state = SSIF_READY;
 	}
 
diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 65d422a588e1..9d178afc73bd 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -292,7 +292,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 			vco = vco_pre * f;
 		}
 
-		delta = abs(target_rate - vco);
+		delta = abs(target_vco_rate - vco);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_r = r;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d02451f951cf..5b4ab94193c2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5391,8 +5391,10 @@ const char *of_clk_get_parent_name(const struct device_node *np, int index)
 		count++;
 	}
 	/* We went off the end of 'clock-indices' without finding it */
-	if (of_property_present(clkspec.np, "clock-indices") && !found)
+	if (of_property_present(clkspec.np, "clock-indices") && !found) {
+		of_node_put(clkspec.np);
 		return NULL;
+	}
 
 	if (of_property_read_string_index(clkspec.np, "clock-output-names",
 					  index,
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 516dbd170c8a..fb18f507f121 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -399,8 +399,9 @@ static const char * const imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_r
 
 static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
 						  "dummy", "dummy", "gpu_pll_out", "vpu_pll_out",
-						  "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
-						  "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
+						  "arm_pll_out", "sys_pll1_out", "sys_pll2_out",
+						  "sys_pll3_out", "dummy", "dummy", "osc_24m",
+						  "dummy", "osc_32k"};
 
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..c5f358a75f30 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,6 +15,11 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 208
+
+#define PLAT_IMX93 BIT(0)
+#define PLAT_IMX91 BIT(1)
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
@@ -33,6 +38,7 @@ static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_mub;
 static u32 share_count_pdm;
+static u32 share_count_spdif;
 
 static const char * const a55_core_sels[] = {"a55_alt", "arm_pll"};
 static const char *parent_names[MAX_SEL][4] = {
@@ -53,6 +59,7 @@ static const struct imx93_clk_root {
 	u32 off;
 	enum clk_sel sel;
 	unsigned long flags;
+	unsigned long plat;
 } root_array[] = {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
@@ -63,9 +70,9 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR2,		"lptmr2_root",		0x0780,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_TPM2,		"tpm2_root",		0x0880,	TPM_SEL, },
@@ -120,15 +127,15 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
 	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
-	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
 	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
 	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
 	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
@@ -137,13 +144,16 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
 	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
 	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
-	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX91_CLK_ENET1_QOS_TSN,	"enet1_qos_tsn_root",   0x2b00, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET_TIMER,		"enet_timer_root",      0x2b80, LOW_SPEED_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET2_REGULAR,	"enet2_regular_root",   0x2c80, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
 };
@@ -155,6 +165,7 @@ static const struct imx93_clk_ccgr {
 	u32 off;
 	unsigned long flags;
 	u32 *shared_count;
+	unsigned long plat;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -167,10 +178,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
 	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
 	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
-	{ IMX93_CLK_MU1_A_GATE,		"mu1_a",	"bus_aon_root",		0x84c0, CLK_IGNORE_UNUSED },
-	{ IMX93_CLK_MU2_A_GATE,		"mu2_a",	"bus_wakeup_root",	0x84c0, CLK_IGNORE_UNUSED },
-	{ IMX93_CLK_MU1_B_GATE,		"mu1_b",	"bus_aon_root",		0x8500, 0, &share_count_mub },
-	{ IMX93_CLK_MU2_B_GATE,		"mu2_b",	"bus_wakeup_root",	0x8500, 0, &share_count_mub },
+	{ IMX93_CLK_MU1_A_GATE,		"mu1_a",	"bus_aon_root",		0x84c0, CLK_IGNORE_UNUSED, NULL, PLAT_IMX93 },
+	{ IMX93_CLK_MU2_A_GATE,		"mu2_a",	"bus_wakeup_root",	0x84c0, CLK_IGNORE_UNUSED, NULL, PLAT_IMX93 },
+	{ IMX93_CLK_MU1_B_GATE,		"mu1_b",	"bus_aon_root",		0x8500, 0, &share_count_mub, PLAT_IMX93 },
+	{ IMX93_CLK_MU2_B_GATE,		"mu2_b",	"bus_wakeup_root",	0x8500, 0, &share_count_mub, PLAT_IMX93 },
 	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"m33_root",		0x8540, },
 	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
 	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi1",	"flexspi1_root",	0x8640, },
@@ -178,8 +189,8 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_GPIO2_GATE,		"gpio2",	"bus_wakeup_root",	0x88c0, },
 	{ IMX93_CLK_GPIO3_GATE,		"gpio3",	"bus_wakeup_root",	0x8900, },
 	{ IMX93_CLK_GPIO4_GATE,		"gpio4",	"bus_wakeup_root",	0x8940, },
-	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, },
-	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, },
+	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, 0, NULL, PLAT_IMX93},
+	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, 0, NULL, PLAT_IMX93},
 	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"bus_aon_root",		0x8a00, },
 	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"bus_wakeup_root",	0x8a40, },
 	{ IMX93_CLK_LPTMR1_GATE,	"lptmr1",	"lptmr1_root",		0x8a80, },
@@ -228,10 +239,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_SAI3_GATE,          "sai3",         "sai3_root",            0x94c0, 0, &share_count_sai3},
 	{ IMX93_CLK_SAI3_IPG,		"sai3_ipg_clk", "bus_wakeup_root",	0x94c0, 0, &share_count_sai3},
 	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
-	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
-	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
+	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, 0, NULL, PLAT_IMX93 },
+	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, 0, NULL, PLAT_IMX93 },
 	{ IMX93_CLK_LCDIF_GATE,		"lcdif",	"media_apb_root",	0x9640, },
-	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, },
+	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, 0, NULL, PLAT_IMX93 },
 	{ IMX93_CLK_ISI_GATE,		"isi",		"media_apb_root",	0x96c0, },
 	{ IMX93_CLK_NIC_MEDIA_GATE,	"nic_media",	"media_axi_root",	0x9700, },
 	{ IMX93_CLK_USB_CONTROLLER_GATE, "usb_controller", "hsio_root",		0x9a00, },
@@ -242,10 +253,13 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
 	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
-	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
+	{ IMX93_CLK_SPDIF_IPG,		"spdif_ipg_clk", "bus_wakeup_root",	0x9c00, 0, &share_count_spdif},
+	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, 0, &share_count_spdif},
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
-	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
-	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
+	{ IMX91_CLK_ENET2_REGULAR_GATE, "enet2_regular", "wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX91, },
+	{ IMX91_CLK_ENET1_QOS_TSN_GATE, "enet1_qos_tsn", "wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX91, },
 	/* Critical because clk accessed during CPU idle */
 	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
@@ -265,6 +279,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	const struct imx93_clk_ccgr *ccgr;
 	void __iomem *base, *anatop_base;
 	int i, ret;
+	const unsigned long plat = (unsigned long)device_get_match_data(&pdev->dev);
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
@@ -314,17 +329,20 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
-		clks[root->clk] = imx93_clk_composite_flags(root->name,
-							    parent_names[root->sel],
-							    4, base + root->off, 3,
-							    root->flags);
+		if (!root->plat || root->plat & plat)
+			clks[root->clk] = imx93_clk_composite_flags(root->name,
+								    parent_names[root->sel],
+								    4, base + root->off, 3,
+								    root->flags);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
-		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
-						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
-						 ccgr->shared_count);
+		if (!ccgr->plat || ccgr->plat & plat)
+			clks[ccgr->clk] = imx93_clk_gate(NULL,
+							 ccgr->name, ccgr->parent_name,
+							 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
+							 ccgr->shared_count);
 	}
 
 	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
@@ -354,7 +372,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx93_clk_of_match[] = {
-	{ .compatible = "fsl,imx93-ccm" },
+	{ .compatible = "fsl,imx93-ccm", .data = (void *)PLAT_IMX93 },
+	{ .compatible = "fsl,imx91-ccm", .data = (void *)PLAT_IMX91 },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
index 85e76c7712ad..b73524ae64b1 100644
--- a/drivers/clk/qcom/camcc-x1e80100.c
+++ b/drivers/clk/qcom/camcc-x1e80100.c
@@ -2212,6 +2212,8 @@ static struct clk_branch cam_cc_sfe_0_fast_ahb_clk = {
 	},
 };
 
+static struct gdsc cam_cc_titan_top_gdsc;
+
 static struct gdsc cam_cc_bps_gdsc = {
 	.gdscr = 0x10004,
 	.en_rest_wait_val = 0x2,
@@ -2221,6 +2223,7 @@ static struct gdsc cam_cc_bps_gdsc = {
 		.name = "cam_cc_bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2233,6 +2236,7 @@ static struct gdsc cam_cc_ife_0_gdsc = {
 		.name = "cam_cc_ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2245,6 +2249,7 @@ static struct gdsc cam_cc_ife_1_gdsc = {
 		.name = "cam_cc_ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2257,6 +2262,7 @@ static struct gdsc cam_cc_ipe_0_gdsc = {
 		.name = "cam_cc_ipe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -2269,6 +2275,7 @@ static struct gdsc cam_cc_sfe_0_gdsc = {
 		.name = "cam_cc_sfe_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &cam_cc_titan_top_gdsc.pd,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index dc3aa7014c3e..c6692808a822 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -454,7 +454,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
@@ -470,7 +470,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
@@ -486,7 +486,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
@@ -502,7 +502,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
@@ -518,7 +518,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
@@ -534,7 +534,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
@@ -550,7 +550,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
@@ -566,7 +566,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
@@ -582,7 +582,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
@@ -598,7 +598,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
@@ -614,7 +614,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
@@ -630,7 +630,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
@@ -646,7 +646,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
@@ -662,7 +662,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
@@ -678,7 +678,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
@@ -694,7 +694,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 8ea25aa25dff..7288af845434 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6083,7 +6083,7 @@ static struct gdsc gcc_usb20_prim_gdsc = {
 	.pd = {
 		.name = "gcc_usb20_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 76285fbbdeaa..4b5d8b741e4e 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -264,7 +264,6 @@ static int mtmips_register_pherip_clocks(struct device_node *np,
 	}
 
 static struct mtmips_clk_fixed rt3883_fixed_clocks[] = {
-	CLK_FIXED("xtal", NULL, 40000000),
 	CLK_FIXED("periph", "xtal", 40000000)
 };
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1b421b809796..0f27c33192e1 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -981,7 +981,7 @@ static void __init cpg_mssr_reserved_exit(struct cpg_mssr_priv *priv)
 static int __init cpg_mssr_reserved_init(struct cpg_mssr_priv *priv,
 					 const struct cpg_mssr_info *info)
 {
-	struct device_node *soc = of_find_node_by_path("/soc");
+	struct device_node *soc __free(device_node) = of_find_node_by_path("/soc");
 	struct device_node *node;
 	uint32_t args[MAX_PHANDLE_ARGS];
 	unsigned int *ids = NULL;
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index c255dba2c96d..6727a3e30a12 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -535,11 +535,11 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 				 CLK_SET_RATE_PARENT);
 
 /*
- * DSI output seems to work only when PLL_MIPI selected. Set it and prevent
- * the mux from reparenting.
+ * Experiments showed that RGB output requires pll-video0-2x, while DSI
+ * requires pll-mipi. It will not work with incorrect clock, the screen will
+ * be blank.
+ * sun50i-a64.dtsi assigns pll-mipi as TCON0 parent by default
  */
-#define SUN50I_A64_TCON0_CLK_REG	0x118
-
 static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x" };
 static const u8 tcon0_table[] = { 0, 2, };
 static SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(tcon0_clk, "tcon0", tcon0_parents,
@@ -959,11 +959,6 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
-	/* Set PLL MIPI as parent for TCON0 */
-	val = readl(reg + SUN50I_A64_TCON0_CLK_REG);
-	val &= ~GENMASK(26, 24);
-	writel(val | (0 << 24), reg + SUN50I_A64_TCON0_CLK_REG);
-
 	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_desc);
 	if (ret)
 		return ret;
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
index a8c11c0b4e06..dfba88a5ad0f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
@@ -21,7 +21,6 @@
 
 /* PLL_VIDEO0 exported for HDMI PHY */
 
-#define CLK_PLL_VIDEO0_2X		8
 #define CLK_PLL_VE			9
 #define CLK_PLL_DDR0			10
 
@@ -32,7 +31,6 @@
 #define CLK_PLL_PERIPH1_2X		14
 #define CLK_PLL_VIDEO1			15
 #define CLK_PLL_GPU			16
-#define CLK_PLL_MIPI			17
 #define CLK_PLL_HSIC			18
 #define CLK_PLL_DE			19
 #define CLK_PLL_DDR1			20
diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 1015fab95251..4c9555fc6184 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -657,7 +657,7 @@ static struct ccu_div apb_pclk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("apb-pclk",
 						      apb_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_IGNORE_UNUSED),
 	},
 };
 
@@ -794,13 +794,13 @@ static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_
 		0x134, BIT(7), 0);
 static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), 0);
 static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
-		0x140, BIT(9), 0);
+		0x140, BIT(9), CLK_IGNORE_UNUSED);
 static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
 		0x150, BIT(9), 0);
 static CCU_GATE(CLK_PERISYS_APB2_HCLK, perisys_apb2_hclk, "perisys-apb2-hclk", perisys_ahb_hclk_pd,
-		0x150, BIT(10), 0);
+		0x150, BIT(10), CLK_IGNORE_UNUSED);
 static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", perisys_ahb_hclk_pd,
-		0x150, BIT(11), 0);
+		0x150, BIT(11), CLK_IGNORE_UNUSED);
 static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
 		0x150, BIT(12), 0);
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), 0);
@@ -896,7 +896,6 @@ static struct ccu_common *th1520_div_clks[] = {
 	&vo_axi_clk.common,
 	&vp_apb_clk.common,
 	&vp_axi_clk.common,
-	&cpu2vp_clk.common,
 	&venc_clk.common,
 	&dpu0_clk.common,
 	&dpu1_clk.common,
@@ -916,6 +915,7 @@ static struct ccu_common *th1520_gate_clks[] = {
 	&bmu_clk.common,
 	&cpu2aon_x2h_clk.common,
 	&cpu2peri_x2h_clk.common,
+	&cpu2vp_clk.common,
 	&perisys_apb1_hclk.common,
 	&perisys_apb2_hclk.common,
 	&perisys_apb3_hclk.common,
@@ -1048,7 +1048,8 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		hw = devm_clk_hw_register_gate_parent_data(dev,
 							   cg->common.hw.init->name,
 							   cg->common.hw.init->parent_data,
-							   0, base + cg->common.cfg0,
+							   cg->common.hw.init->flags,
+							   base + cg->common.cfg0,
 							   ffs(cg->enable) - 1, 0, NULL);
 		if (IS_ERR(hw))
 			return PTR_ERR(hw);
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0f04feb6cafa..47e910c22a80 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -626,7 +626,14 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 #endif
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-static u64 get_max_boost_ratio(unsigned int cpu)
+/*
+ * get_max_boost_ratio: Computes the max_boost_ratio as the ratio
+ * between the highest_perf and the nominal_perf.
+ *
+ * Returns the max_boost_ratio for @cpu. Returns the CPPC nominal
+ * frequency via @nominal_freq if it is non-NULL pointer.
+ */
+static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 {
 	struct cppc_perf_caps perf_caps;
 	u64 highest_perf, nominal_perf;
@@ -655,6 +662,9 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	nominal_perf = perf_caps.nominal_perf;
 
+	if (nominal_freq)
+		*nominal_freq = perf_caps.nominal_freq;
+
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
 		return 0;
@@ -667,8 +677,12 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
 }
+
 #else
-static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
+static inline u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
+{
+	return 0;
+}
 #endif
 
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
@@ -678,9 +692,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct acpi_cpufreq_data *data;
 	unsigned int cpu = policy->cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	u64 max_boost_ratio, nominal_freq = 0;
 	unsigned int valid_states = 0;
 	unsigned int result = 0;
-	u64 max_boost_ratio;
 	unsigned int i;
 #ifdef CONFIG_SMP
 	static int blacklisted;
@@ -830,16 +844,20 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
 
-	max_boost_ratio = get_max_boost_ratio(cpu);
+	max_boost_ratio = get_max_boost_ratio(cpu, &nominal_freq);
 	if (max_boost_ratio) {
-		unsigned int freq = freq_table[0].frequency;
+		unsigned int freq = nominal_freq;
 
 		/*
-		 * Because the loop above sorts the freq_table entries in the
-		 * descending order, freq is the maximum frequency in the table.
-		 * Assume that it corresponds to the CPPC nominal frequency and
-		 * use it to set cpuinfo.max_freq.
+		 * The loop above sorts the freq_table entries in the
+		 * descending order. If ACPI CPPC has not advertised
+		 * the nominal frequency (this is possible in CPPC
+		 * revisions prior to 3), then use the first entry in
+		 * the pstate table as a proxy for nominal frequency.
 		 */
+		if (!freq)
+			freq = freq_table[0].frequency;
+
 		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
 	} else {
 		/*
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 900d6844c43d..e73997806383 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -143,14 +143,12 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 }
 
 /* Get the frequency requested by the cpufreq core for the CPU */
-static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
+static unsigned int qcom_cpufreq_get_freq(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data;
 	const struct qcom_cpufreq_soc_data *soc_data;
-	struct cpufreq_policy *policy;
 	unsigned int index;
 
-	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
 		return 0;
 
@@ -163,12 +161,10 @@ static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
 	return policy->freq_table[index].frequency;
 }
 
-static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+static unsigned int __qcom_cpufreq_hw_get(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data;
-	struct cpufreq_policy *policy;
 
-	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
 		return 0;
 
@@ -177,7 +173,12 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	if (data->throttle_irq >= 0)
 		return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
 
-	return qcom_cpufreq_get_freq(cpu);
+	return qcom_cpufreq_get_freq(policy);
+}
+
+static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+{
+	return __qcom_cpufreq_hw_get(cpufreq_cpu_get_raw(cpu));
 }
 
 static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
@@ -363,7 +364,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	 * If h/w throttled frequency is higher than what cpufreq has requested
 	 * for, then stop polling and switch back to interrupt mechanism.
 	 */
-	if (throttled_freq >= qcom_cpufreq_get_freq(cpu))
+	if (throttled_freq >= qcom_cpufreq_get_freq(cpufreq_cpu_get_raw(cpu)))
 		enable_irq(data->throttle_irq);
 	else
 		mod_delayed_work(system_highpri_wq, &data->throttle_work,
@@ -441,7 +442,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 		return data->throttle_irq;
 
 	data->cancel_throttle = false;
-	data->policy = policy;
 
 	mutex_init(&data->throttle_lock);
 	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
@@ -552,6 +552,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = data;
 	policy->dvfs_possible_from_any_cpu = true;
+	data->policy = policy;
 
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
@@ -622,11 +623,24 @@ static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned lon
 {
 	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
 
-	return qcom_lmh_get_throttle_freq(data);
+	return __qcom_cpufreq_hw_get(data->policy) * HZ_PER_KHZ;
+}
+
+/*
+ * Since we cannot determine the closest rate of the target rate, let's just
+ * return the actual rate at which the clock is running at. This is needed to
+ * make clk_set_rate() API work properly.
+ */
+static int qcom_cpufreq_hw_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	req->rate = qcom_cpufreq_hw_recalc_rate(hw, 0);
+
+	return 0;
 }
 
 static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
 	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
+	.determine_rate = qcom_cpufreq_hw_determine_rate,
 };
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 87781c1534ee..079a22cc9f02 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2024 NXP
  */
 
 #define pr_fmt(fmt) "caam blob_gen: " fmt
@@ -104,7 +105,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 	}
 
 	ctrlpriv = dev_get_drvdata(jrdev->parent);
-	moo = FIELD_GET(CSTA_MOO, rd_reg32(&ctrlpriv->ctrl->perfmon.status));
+	moo = FIELD_GET(CSTA_MOO, rd_reg32(&ctrlpriv->jr[0]->perfmon.status));
 	if (moo != CSTA_MOO_SECURE && moo != CSTA_MOO_TRUSTED)
 		dev_warn(jrdev,
 			 "using insecure test key, enable HAB to use unique device key!\n");
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 410c83712e28..30c2b1a64695 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -37,6 +37,7 @@ struct sec_aead_req {
 	u8 *a_ivin;
 	dma_addr_t a_ivin_dma;
 	struct aead_request *aead_req;
+	bool fallback;
 };
 
 /* SEC request of Crypto */
@@ -90,9 +91,7 @@ struct sec_auth_ctx {
 	dma_addr_t a_key_dma;
 	u8 *a_key;
 	u8 a_key_len;
-	u8 mac_len;
 	u8 a_alg;
-	bool fallback;
 	struct crypto_shash *hash_tfm;
 	struct crypto_aead *fallback_aead_tfm;
 };
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 0558f98e221f..a9b1b9b0b03b 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -948,15 +948,14 @@ static int sec_aead_mac_init(struct sec_aead_req *req)
 	struct aead_request *aead_req = req->aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
 	size_t authsize = crypto_aead_authsize(tfm);
-	u8 *mac_out = req->out_mac;
 	struct scatterlist *sgl = aead_req->src;
+	u8 *mac_out = req->out_mac;
 	size_t copy_size;
 	off_t skip_size;
 
 	/* Copy input mac */
 	skip_size = aead_req->assoclen + aead_req->cryptlen - authsize;
-	copy_size = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac_out,
-				       authsize, skip_size);
+	copy_size = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac_out, authsize, skip_size);
 	if (unlikely(copy_size != authsize))
 		return -EINVAL;
 
@@ -1120,10 +1119,7 @@ static int sec_aead_setauthsize(struct crypto_aead *aead, unsigned int authsize)
 	struct sec_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	if (unlikely(a_ctx->fallback_aead_tfm))
-		return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
-
-	return 0;
+	return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
 }
 
 static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
@@ -1139,7 +1135,6 @@ static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
 static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 			   const u32 keylen, const enum sec_hash_alg a_alg,
 			   const enum sec_calg c_alg,
-			   const enum sec_mac_len mac_len,
 			   const enum sec_cmode c_mode)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
@@ -1151,7 +1146,6 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 	ctx->a_ctx.a_alg = a_alg;
 	ctx->c_ctx.c_alg = c_alg;
-	ctx->a_ctx.mac_len = mac_len;
 	c_ctx->c_mode = c_mode;
 
 	if (c_mode == SEC_CMODE_CCM || c_mode == SEC_CMODE_GCM) {
@@ -1162,13 +1156,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		}
 		memcpy(c_ctx->c_key, key, keylen);
 
-		if (unlikely(a_ctx->fallback_aead_tfm)) {
-			ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
-			if (ret)
-				return ret;
-		}
-
-		return 0;
+		return sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
 	}
 
 	ret = crypto_authenc_extractkeys(&keys, key, keylen);
@@ -1187,10 +1175,15 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
-	if ((ctx->a_ctx.mac_len & SEC_SQE_LEN_RATE_MASK)  ||
-	    (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK)) {
+	if (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK) {
 		ret = -EINVAL;
-		dev_err(dev, "MAC or AUTH key length error!\n");
+		dev_err(dev, "AUTH key length error!\n");
+		goto bad_key;
+	}
+
+	ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
+	if (ret) {
+		dev_err(dev, "set sec fallback key err!\n");
 		goto bad_key;
 	}
 
@@ -1202,27 +1195,19 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 }
 
 
-#define GEN_SEC_AEAD_SETKEY_FUNC(name, aalg, calg, maclen, cmode)	\
-static int sec_setkey_##name(struct crypto_aead *tfm, const u8 *key,	\
-	u32 keylen)							\
-{									\
-	return sec_aead_setkey(tfm, key, keylen, aalg, calg, maclen, cmode);\
-}
-
-GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha1, SEC_A_HMAC_SHA1,
-			 SEC_CALG_AES, SEC_HMAC_SHA1_MAC, SEC_CMODE_CBC)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha256, SEC_A_HMAC_SHA256,
-			 SEC_CALG_AES, SEC_HMAC_SHA256_MAC, SEC_CMODE_CBC)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha512, SEC_A_HMAC_SHA512,
-			 SEC_CALG_AES, SEC_HMAC_SHA512_MAC, SEC_CMODE_CBC)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_ccm, 0, SEC_CALG_AES,
-			 SEC_HMAC_CCM_MAC, SEC_CMODE_CCM)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_gcm, 0, SEC_CALG_AES,
-			 SEC_HMAC_GCM_MAC, SEC_CMODE_GCM)
-GEN_SEC_AEAD_SETKEY_FUNC(sm4_ccm, 0, SEC_CALG_SM4,
-			 SEC_HMAC_CCM_MAC, SEC_CMODE_CCM)
-GEN_SEC_AEAD_SETKEY_FUNC(sm4_gcm, 0, SEC_CALG_SM4,
-			 SEC_HMAC_GCM_MAC, SEC_CMODE_GCM)
+#define GEN_SEC_AEAD_SETKEY_FUNC(name, aalg, calg, cmode)				\
+static int sec_setkey_##name(struct crypto_aead *tfm, const u8 *key, u32 keylen)	\
+{											\
+	return sec_aead_setkey(tfm, key, keylen, aalg, calg, cmode);			\
+}
+
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha1, SEC_A_HMAC_SHA1, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha256, SEC_A_HMAC_SHA256, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha512, SEC_A_HMAC_SHA512, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_ccm, 0, SEC_CALG_AES, SEC_CMODE_CCM)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_gcm, 0, SEC_CALG_AES, SEC_CMODE_GCM)
+GEN_SEC_AEAD_SETKEY_FUNC(sm4_ccm, 0, SEC_CALG_SM4, SEC_CMODE_CCM)
+GEN_SEC_AEAD_SETKEY_FUNC(sm4_gcm, 0, SEC_CALG_SM4, SEC_CMODE_GCM)
 
 static int sec_aead_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
 {
@@ -1470,9 +1455,10 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
-	struct sec_cipher_req *c_req = &req->c_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	size_t authsize = crypto_aead_authsize(tfm);
 	struct sec_aead_req *a_req = &req->aead_req;
-	size_t authsize = ctx->a_ctx.mac_len;
+	struct sec_cipher_req *c_req = &req->c_req;
 	u32 data_size = aead_req->cryptlen;
 	u8 flage = 0;
 	u8 cm, cl;
@@ -1513,10 +1499,8 @@ static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
 static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
-	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
-	size_t authsize = crypto_aead_authsize(tfm);
-	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_aead_req *a_req = &req->aead_req;
+	struct sec_cipher_req *c_req = &req->c_req;
 
 	memcpy(c_req->c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
 
@@ -1524,15 +1508,11 @@ static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
 		/*
 		 * CCM 16Byte Cipher_IV: {1B_Flage,13B_IV,2B_counter},
 		 * the  counter must set to 0x01
+		 * CCM 16Byte Auth_IV: {1B_AFlage,13B_IV,2B_Ptext_length}
 		 */
-		ctx->a_ctx.mac_len = authsize;
-		/* CCM 16Byte Auth_IV: {1B_AFlage,13B_IV,2B_Ptext_length} */
 		set_aead_auth_iv(ctx, req);
-	}
-
-	/* GCM 12Byte Cipher_IV == Auth_IV */
-	if (ctx->c_ctx.c_mode == SEC_CMODE_GCM) {
-		ctx->a_ctx.mac_len = authsize;
+	} else if (ctx->c_ctx.c_mode == SEC_CMODE_GCM) {
+		/* GCM 12Byte Cipher_IV == Auth_IV */
 		memcpy(a_req->a_ivin, c_req->c_ivin, SEC_AIV_SIZE);
 	}
 }
@@ -1542,9 +1522,11 @@ static void sec_auth_bd_fill_xcm(struct sec_auth_ctx *ctx, int dir,
 {
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	/* C_ICV_Len is MAC size, 0x4 ~ 0x10 */
-	sec_sqe->type2.icvw_kmode |= cpu_to_le16((u16)ctx->mac_len);
+	sec_sqe->type2.icvw_kmode |= cpu_to_le16((u16)authsize);
 
 	/* mode set to CCM/GCM, don't set {A_Alg, AKey_Len, MAC_Len} */
 	sec_sqe->type2.a_key_addr = sec_sqe->type2.c_key_addr;
@@ -1568,9 +1550,11 @@ static void sec_auth_bd_fill_xcm_v3(struct sec_auth_ctx *ctx, int dir,
 {
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	/* C_ICV_Len is MAC size, 0x4 ~ 0x10 */
-	sqe3->c_icv_key |= cpu_to_le16((u16)ctx->mac_len << SEC_MAC_OFFSET_V3);
+	sqe3->c_icv_key |= cpu_to_le16((u16)authsize << SEC_MAC_OFFSET_V3);
 
 	/* mode set to CCM/GCM, don't set {A_Alg, AKey_Len, MAC_Len} */
 	sqe3->a_key_addr = sqe3->c_key_addr;
@@ -1594,11 +1578,12 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	sec_sqe->type2.a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
-	sec_sqe->type2.mac_key_alg =
-			cpu_to_le32(ctx->mac_len / SEC_SQE_LEN_RATE);
+	sec_sqe->type2.mac_key_alg = cpu_to_le32(authsize / SEC_SQE_LEN_RATE);
 
 	sec_sqe->type2.mac_key_alg |=
 			cpu_to_le32((u32)((ctx->a_key_len) /
@@ -1648,11 +1633,13 @@ static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	sqe3->a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
 	sqe3->auth_mac_key |=
-			cpu_to_le32((u32)(ctx->mac_len /
+			cpu_to_le32((u32)(authsize /
 			SEC_SQE_LEN_RATE) << SEC_MAC_OFFSET_V3);
 
 	sqe3->auth_mac_key |=
@@ -1703,9 +1690,9 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 {
 	struct aead_request *a_req = req->aead_req.aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
+	size_t authsize = crypto_aead_authsize(tfm);
 	struct sec_aead_req *aead_req = &req->aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
-	size_t authsize = crypto_aead_authsize(tfm);
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
 	struct aead_request *backlog_aead_req;
 	struct sec_req *backlog_req;
@@ -1718,10 +1705,8 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 	if (!err && c_req->encrypt) {
 		struct scatterlist *sgl = a_req->dst;
 
-		sz = sg_pcopy_from_buffer(sgl, sg_nents(sgl),
-					  aead_req->out_mac,
-					  authsize, a_req->cryptlen +
-					  a_req->assoclen);
+		sz = sg_pcopy_from_buffer(sgl, sg_nents(sgl), aead_req->out_mac,
+					  authsize, a_req->cryptlen + a_req->assoclen);
 		if (unlikely(sz != authsize)) {
 			dev_err(c->dev, "copy out mac err!\n");
 			err = -EINVAL;
@@ -1929,8 +1914,10 @@ static void sec_aead_exit(struct crypto_aead *tfm)
 
 static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 {
+	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
-	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
+	const char *aead_name = alg->base.cra_name;
 	int ret;
 
 	ret = sec_aead_init(tfm);
@@ -1939,11 +1926,20 @@ static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 		return ret;
 	}
 
-	auth_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
-	if (IS_ERR(auth_ctx->hash_tfm)) {
+	a_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
+	if (IS_ERR(a_ctx->hash_tfm)) {
 		dev_err(ctx->dev, "aead alloc shash error!\n");
 		sec_aead_exit(tfm);
-		return PTR_ERR(auth_ctx->hash_tfm);
+		return PTR_ERR(a_ctx->hash_tfm);
+	}
+
+	a_ctx->fallback_aead_tfm = crypto_alloc_aead(aead_name, 0,
+						     CRYPTO_ALG_NEED_FALLBACK | CRYPTO_ALG_ASYNC);
+	if (IS_ERR(a_ctx->fallback_aead_tfm)) {
+		dev_err(ctx->dev, "aead driver alloc fallback tfm error!\n");
+		crypto_free_shash(ctx->a_ctx.hash_tfm);
+		sec_aead_exit(tfm);
+		return PTR_ERR(a_ctx->fallback_aead_tfm);
 	}
 
 	return 0;
@@ -1953,6 +1949,7 @@ static void sec_aead_ctx_exit(struct crypto_aead *tfm)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
 
+	crypto_free_aead(ctx->a_ctx.fallback_aead_tfm);
 	crypto_free_shash(ctx->a_ctx.hash_tfm);
 	sec_aead_exit(tfm);
 }
@@ -1979,7 +1976,6 @@ static int sec_aead_xcm_ctx_init(struct crypto_aead *tfm)
 		sec_aead_exit(tfm);
 		return PTR_ERR(a_ctx->fallback_aead_tfm);
 	}
-	a_ctx->fallback = false;
 
 	return 0;
 }
@@ -2233,21 +2229,20 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
 	struct aead_request *req = sreq->aead_req.aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	size_t authsize = crypto_aead_authsize(tfm);
+	size_t sz = crypto_aead_authsize(tfm);
 	u8 c_mode = ctx->c_ctx.c_mode;
 	struct device *dev = ctx->dev;
 	int ret;
 
-	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
-	    req->assoclen > SEC_MAX_AAD_LEN)) {
-		dev_err(dev, "aead input spec error!\n");
+	/* Hardware does not handle cases where authsize is less than 4 bytes */
+	if (unlikely(sz < MIN_MAC_LEN)) {
+		sreq->aead_req.fallback = true;
 		return -EINVAL;
 	}
 
-	if (unlikely((c_mode == SEC_CMODE_GCM && authsize < DES_BLOCK_SIZE) ||
-	   (c_mode == SEC_CMODE_CCM && (authsize < MIN_MAC_LEN ||
-		authsize & MAC_LEN_MASK)))) {
-		dev_err(dev, "aead input mac length error!\n");
+	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
+	    req->assoclen > SEC_MAX_AAD_LEN)) {
+		dev_err(dev, "aead input spec error!\n");
 		return -EINVAL;
 	}
 
@@ -2266,7 +2261,7 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (sreq->c_req.encrypt)
 		sreq->c_req.c_len = req->cryptlen;
 	else
-		sreq->c_req.c_len = req->cryptlen - authsize;
+		sreq->c_req.c_len = req->cryptlen - sz;
 	if (c_mode == SEC_CMODE_CBC) {
 		if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
 			dev_err(dev, "aead crypto length error!\n");
@@ -2292,8 +2287,8 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 
 	if (ctx->sec->qm.ver == QM_HW_V2) {
 		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
-		    req->cryptlen <= authsize))) {
-			ctx->a_ctx.fallback = true;
+			     req->cryptlen <= authsize))) {
+			sreq->aead_req.fallback = true;
 			return -EINVAL;
 		}
 	}
@@ -2321,16 +2316,9 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 				bool encrypt)
 {
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
-	struct device *dev = ctx->dev;
 	struct aead_request *subreq;
 	int ret;
 
-	/* Kunpeng920 aead mode not support input 0 size */
-	if (!a_ctx->fallback_aead_tfm) {
-		dev_err(dev, "aead fallback tfm is NULL!\n");
-		return -EINVAL;
-	}
-
 	subreq = aead_request_alloc(a_ctx->fallback_aead_tfm, GFP_KERNEL);
 	if (!subreq)
 		return -ENOMEM;
@@ -2362,10 +2350,11 @@ static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
 	req->aead_req.aead_req = a_req;
 	req->c_req.encrypt = encrypt;
 	req->ctx = ctx;
+	req->aead_req.fallback = false;
 
 	ret = sec_aead_param_check(ctx, req);
 	if (unlikely(ret)) {
-		if (ctx->a_ctx.fallback)
+		if (req->aead_req.fallback)
 			return sec_aead_soft_crypto(ctx, a_req, encrypt);
 		return -EINVAL;
 	}
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 27a0ee5ad913..04725b514382 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -23,17 +23,6 @@ enum sec_hash_alg {
 	SEC_A_HMAC_SHA512 = 0x15,
 };
 
-enum sec_mac_len {
-	SEC_HMAC_CCM_MAC   = 16,
-	SEC_HMAC_GCM_MAC   = 16,
-	SEC_SM3_MAC        = 32,
-	SEC_HMAC_SM3_MAC   = 32,
-	SEC_HMAC_MD5_MAC   = 16,
-	SEC_HMAC_SHA1_MAC   = 20,
-	SEC_HMAC_SHA256_MAC = 32,
-	SEC_HMAC_SHA512_MAC = 64,
-};
-
 enum sec_cmode {
 	SEC_CMODE_ECB    = 0x0,
 	SEC_CMODE_CBC    = 0x1,
diff --git a/drivers/crypto/intel/iaa/Makefile b/drivers/crypto/intel/iaa/Makefile
index b64b208d2344..55bda7770fac 100644
--- a/drivers/crypto/intel/iaa/Makefile
+++ b/drivers/crypto/intel/iaa/Makefile
@@ -3,7 +3,7 @@
 # Makefile for IAA crypto device drivers
 #
 
-ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
+ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE='"IDXD"'
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 237f87000070..d2f07e34f314 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -173,7 +173,7 @@ static int set_iaa_sync_mode(const char *name)
 		async_mode = false;
 		use_irq = false;
 	} else if (sysfs_streq(name, "async")) {
-		async_mode = true;
+		async_mode = false;
 		use_irq = false;
 	} else if (sysfs_streq(name, "async_irq")) {
 		async_mode = true;
diff --git a/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
index f8a77bff8844..e43361392c83 100644
--- a/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
+++ b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
@@ -471,6 +471,7 @@ static int init_ixp_crypto(struct device *dev)
 			return -ENODEV;
 		}
 		npe_id = npe_spec.args[0];
+		of_node_put(npe_spec.np);
 
 		ret = of_parse_phandle_with_fixed_args(np, "queue-rx", 1, 0,
 						       &queue_spec);
@@ -479,6 +480,7 @@ static int init_ixp_crypto(struct device *dev)
 			return -ENODEV;
 		}
 		recv_qid = queue_spec.args[0];
+		of_node_put(queue_spec.np);
 
 		ret = of_parse_phandle_with_fixed_args(np, "queue-txready", 1, 0,
 						       &queue_spec);
@@ -487,6 +489,7 @@ static int init_ixp_crypto(struct device *dev)
 			return -ENODEV;
 		}
 		send_qid = queue_spec.args[0];
+		of_node_put(queue_spec.np);
 	} else {
 		/*
 		 * Hardcoded engine when using platform data, this goes away
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index eac73cbfdd38..7acf9c576149 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_QAT) += intel_qat.o
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CRYPTO_QAT
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"CRYPTO_QAT"'
 intel_qat-objs := adf_cfg.o \
 	adf_isr.o \
 	adf_ctl_drv.o \
diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index ae7a0f8435fc..3106fd1e84b9 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -1752,10 +1752,13 @@ static int tegra_cmac_digest(struct ahash_request *req)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
+	int ret;
 
-	tegra_cmac_init(req);
-	rctx->task |= SHA_UPDATE | SHA_FINAL;
+	ret = tegra_cmac_init(req);
+	if (ret)
+		return ret;
 
+	rctx->task |= SHA_UPDATE | SHA_FINAL;
 	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
 }
 
diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 4d4bd727f498..0b5cdd5676b1 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -615,13 +615,16 @@ static int tegra_sha_digest(struct ahash_request *req)
 	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
+	int ret;
 
 	if (ctx->fallback)
 		return tegra_sha_fallback_digest(req);
 
-	tegra_sha_init(req);
-	rctx->task |= SHA_UPDATE | SHA_FINAL;
+	ret = tegra_sha_init(req);
+	if (ret)
+		return ret;
 
+	rctx->task |= SHA_UPDATE | SHA_FINAL;
 	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
 }
 
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index 2b4a0d406e1e..9ff9d7b87b64 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,4 +1,4 @@
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"IDXD"'
 
 obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
 idxd_bus-y := bus.o
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 5f8d2e93ff3f..7f861fb07cb8 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -208,7 +208,6 @@ struct edma_desc {
 struct edma_cc;
 
 struct edma_tc {
-	struct device_node		*node;
 	u16				id;
 };
 
@@ -2466,13 +2465,13 @@ static int edma_probe(struct platform_device *pdev)
 			if (ret || i == ecc->num_tc)
 				break;
 
-			ecc->tc_list[i].node = tc_args.np;
 			ecc->tc_list[i].id = i;
 			queue_priority_mapping[i][1] = tc_args.args[0];
 			if (queue_priority_mapping[i][1] > lowest_priority) {
 				lowest_priority = queue_priority_mapping[i][1];
 				info->default_queue = i;
 			}
+			of_node_put(tc_args.np);
 		}
 
 		/* See if we have optional dma-channel-mask array */
diff --git a/drivers/firewire/device-attribute-test.c b/drivers/firewire/device-attribute-test.c
index 2f123c6b0a16..97478a96d1c9 100644
--- a/drivers/firewire/device-attribute-test.c
+++ b/drivers/firewire/device-attribute-test.c
@@ -99,6 +99,7 @@ static void device_attr_simple_avc(struct kunit *test)
 	struct device *unit0_dev = (struct device *)&unit0.device;
 	static const int unit0_expected_ids[] = {0x00ffffff, 0x00ffffff, 0x0000a02d, 0x00010001};
 	char *buf = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
 	int ids[4] = {0, 0, 0, 0};
 
 	// Ensure associations for node and unit devices.
@@ -180,6 +181,7 @@ static void device_attr_legacy_avc(struct kunit *test)
 	struct device *unit0_dev = (struct device *)&unit0.device;
 	static const int unit0_expected_ids[] = {0x00012345, 0x00fedcba, 0x00abcdef, 0x00543210};
 	char *buf = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
 	int ids[4] = {0, 0, 0, 0};
 
 	// Ensure associations for node and unit devices.
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index cc807ed35aed..1e509595ac03 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -91,6 +91,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 		_ret_;						\
 	})
 
+#ifdef CONFIG_EFI
 static int __init efifb_set_system(const struct dmi_system_id *id)
 {
 	struct efifb_dmi_info *info = id->driver_data;
@@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 	.add_links = efifb_add_links,
 };
 
-#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 14afd68664a9..a6bdedbbf708 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2001,13 +2001,17 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
-		if (irq != -ENXIO)
-			return irq;
+		if (irq != -ENXIO) {
+			ret = irq;
+			goto err;
+		}
 	} else {
 		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
 						IRQF_ONESHOT, "qcom-scm", __scm);
-		if (ret < 0)
-			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
+		if (ret < 0) {
+			dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
+			goto err;
+		}
 	}
 
 	__get_convention();
@@ -2026,14 +2030,18 @@ static int qcom_scm_probe(struct platform_device *pdev)
 		qcom_scm_disable_sdi();
 
 	ret = of_reserved_mem_device_init(__scm->dev);
-	if (ret && ret != -ENODEV)
-		return dev_err_probe(__scm->dev, ret,
-				     "Failed to setup the reserved memory region for TZ mem\n");
+	if (ret && ret != -ENODEV) {
+		dev_err_probe(__scm->dev, ret,
+			      "Failed to setup the reserved memory region for TZ mem\n");
+		goto err;
+	}
 
 	ret = qcom_tzmem_enable(__scm->dev);
-	if (ret)
-		return dev_err_probe(__scm->dev, ret,
-				     "Failed to enable the TrustZone memory allocator\n");
+	if (ret) {
+		dev_err_probe(__scm->dev, ret,
+			      "Failed to enable the TrustZone memory allocator\n");
+		goto err;
+	}
 
 	memset(&pool_config, 0, sizeof(pool_config));
 	pool_config.initial_size = 0;
@@ -2041,9 +2049,11 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	pool_config.max_size = SZ_256K;
 
 	__scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, &pool_config);
-	if (IS_ERR(__scm->mempool))
-		return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
-				     "Failed to create the SCM memory pool\n");
+	if (IS_ERR(__scm->mempool)) {
+		dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
+			      "Failed to create the SCM memory pool\n");
+		goto err;
+	}
 
 	/*
 	 * Initialize the QSEECOM interface.
@@ -2059,6 +2069,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
 	return 0;
+
+err:
+	/* Paired with smp_load_acquire() in qcom_scm_is_available(). */
+	smp_store_release(&__scm, NULL);
+
+	return ret;
 }
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 53b1eb876a12..2c9512589297 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -14,7 +14,7 @@
 
 #include "gpio-idio-16.h"
 
-#define DEFAULT_SYMBOL_NAMESPACE GPIO_IDIO_16
+#define DEFAULT_SYMBOL_NAMESPACE "GPIO_IDIO_16"
 
 #define IDIO_16_DAT_BASE 0x0
 #define IDIO_16_OUT_BASE IDIO_16_DAT_BASE
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 4cb455b2bdee..619b6fb9d833 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -490,8 +490,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	port->gc.request = mxc_gpio_request;
 	port->gc.free = mxc_gpio_free;
 	port->gc.to_irq = mxc_gpio_to_irq;
-	port->gc.base = (pdev->id < 0) ? of_alias_get_id(np, "gpio") * 32 :
-					     pdev->id * 32;
+	port->gc.base = of_alias_get_id(np, "gpio") * 32;
 
 	err = devm_gpiochip_add_data(&pdev->dev, &port->gc, port);
 	if (err)
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 3f2d33ee20cc..e49802f26e07 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1088,7 +1088,8 @@ static int pca953x_probe(struct i2c_client *client)
 		 */
 		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
+			return dev_err_probe(dev, PTR_ERR(reset_gpio),
+					     "Failed to get reset gpio\n");
 	}
 
 	chip->client = client;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 3bc0cbf45bc5..a46d6dd6de32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1133,8 +1133,7 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 	uint32_t low, high;
 	uint64_t queue_addr = 0;
 
-	if (!adev->debug_exp_resets &&
-	    !adev->gfx.num_gfx_rings)
+	if (!amdgpu_gpu_recovery)
 		return 0;
 
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
@@ -1185,6 +1184,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 	uint32_t low, high, pipe_reset_data = 0;
 	uint64_t queue_addr = 0;
 
+	if (!amdgpu_gpu_recovery)
+		return 0;
+
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9f922ec50ea2..ae9ca6788df7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2065,6 +2065,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	DRM_INFO("amdgpu: ttm finalized\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e7cd51c95141..e2501c98e107 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7251,10 +7251,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
-	if (!adev->debug_exp_resets &&
-	    !adev->gfx.num_gfx_rings)
-		return -EINVAL;
-
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ffdb966c4127..5dc3454d7d36 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3062,9 +3062,6 @@ static void gfx_v9_4_3_ring_soft_recovery(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t value = 0;
 
-	if (!adev->debug_exp_resets)
-		return;
-
 	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
@@ -3580,9 +3577,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r;
 
-	if (!adev->debug_exp_resets)
-		return -EINVAL;
-
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6fca2915ea8f..84c6b0f5c4c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -943,6 +943,8 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		vcn_inst = GET_INST(VCN, i);
 
+		vcn_v4_0_3_fw_shared_init(adev, vcn_inst);
+
 		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
 		header.version = MMSCH_VERSION;
 		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a0bc2c0ac04d..20ad72d1b0d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -697,6 +697,8 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *mst_output_port;
 	struct amdgpu_dm_connector *mst_root;
 	struct drm_dp_aux *dsc_aux;
+	uint32_t mst_local_bw;
+	uint16_t vc_full_pbn;
 	struct mutex handle_mst_msg_ready;
 
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 3d624ae6d9bd..754dbc544f03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -155,6 +155,17 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 	return 0;
 }
 
+
+static inline void
+amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
+{
+	aconnector->edid = NULL;
+	aconnector->dsc_aux = NULL;
+	aconnector->mst_output_port->passthrough_aux = NULL;
+	aconnector->mst_local_bw = 0;
+	aconnector->vc_full_pbn = 0;
+}
+
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
@@ -182,9 +193,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->edid = NULL;
-		aconnector->dsc_aux = NULL;
-		port->passthrough_aux = NULL;
+		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
 	}
 
 	aconnector->mst_status = MST_STATUS_DEFAULT;
@@ -500,9 +509,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->edid = NULL;
-		aconnector->dsc_aux = NULL;
-		port->passthrough_aux = NULL;
+		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
 
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
@@ -1815,9 +1822,18 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			struct drm_dp_mst_port *immediate_upstream_port = NULL;
 			uint32_t end_link_bw = 0;
 
-			/*Get last DP link BW capability*/
-			if (dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw)) {
-				if (stream_kbps > end_link_bw) {
+			/*Get last DP link BW capability. Mode shall be supported by Legacy peer*/
+			if (aconnector->mst_output_port->pdt != DP_PEER_DEVICE_DP_LEGACY_CONV &&
+				aconnector->mst_output_port->pdt != DP_PEER_DEVICE_NONE) {
+				if (aconnector->vc_full_pbn != aconnector->mst_output_port->full_pbn) {
+					dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw);
+					aconnector->vc_full_pbn = aconnector->mst_output_port->full_pbn;
+					aconnector->mst_local_bw = end_link_bw;
+				} else {
+					end_link_bw = aconnector->mst_local_bw;
+				}
+
+				if (end_link_bw > 0 && stream_kbps > end_link_bw) {
 					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
 							 "Mode required bw can't fit into last link\n");
 					return DC_FAIL_BANDWIDTH_VALIDATE;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index e1da48b05d00..961d8936150a 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -194,6 +194,9 @@ void dpp_reset(struct dpp *dpp_base)
 	dpp->filter_h = NULL;
 	dpp->filter_v = NULL;
 
+	memset(&dpp_base->pos, 0, sizeof(dpp_base->pos));
+	memset(&dpp_base->att, 0, sizeof(dpp_base->att));
+
 	memset(&dpp->scl_data, 0, sizeof(dpp->scl_data));
 	memset(&dpp->pwl_data, 0, sizeof(dpp->pwl_data));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 22ac2b7e49ae..da963f73829f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -532,6 +532,12 @@ void hubp1_dcc_control(struct hubp *hubp, bool enable,
 			SECONDARY_SURFACE_DCC_IND_64B_BLK, dcc_ind_64b_blk);
 }
 
+void hubp_reset(struct hubp *hubp)
+{
+	memset(&hubp->pos, 0, sizeof(hubp->pos));
+	memset(&hubp->att, 0, sizeof(hubp->att));
+}
+
 void hubp1_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
@@ -1337,8 +1343,9 @@ static void hubp1_wait_pipe_read_start(struct hubp *hubp)
 
 void hubp1_init(struct hubp *hubp)
 {
-	//do nothing
+	hubp_reset(hubp);
 }
+
 static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_program_surface_flip_and_addr =
 			hubp1_program_surface_flip_and_addr,
@@ -1351,6 +1358,7 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_set_vm_context0_settings = hubp1_set_vm_context0_settings,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_hubp_blank_en = hubp1_set_hubp_blank_en,
 	.set_cursor_attributes	= hubp1_cursor_set_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index 69119b2fdce2..193e48b440ef 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -746,6 +746,8 @@ void hubp1_dcc_control(struct hubp *hubp,
 		bool enable,
 		enum hubp_ind_block_size independent_64b_blks);
 
+void hubp_reset(struct hubp *hubp);
+
 bool hubp1_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 0637e4c552d8..b405fa22f87a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -1660,6 +1660,7 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp2_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
index cd2bfcc51276..6efcb10abf3d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
@@ -121,6 +121,7 @@ static struct hubp_funcs dcn201_hubp_funcs = {
 	.set_cursor_position	= hubp1_cursor_set_position,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.hubp_clk_cntl = hubp1_clk_cntl,
 	.hubp_vtg_sel = hubp1_vtg_sel,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index e13d69a22c1c..4e2d9d381db3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -811,6 +811,8 @@ static void hubp21_init(struct hubp *hubp)
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
+
+	hubp_reset(hubp);
 }
 static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
@@ -823,6 +825,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp21_set_vm_system_aperture_settings,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = hubp21_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp1_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 60a64d290352..c55b1b8be8ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -483,6 +483,8 @@ void hubp3_init(struct hubp *hubp)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
+
+	hubp_reset(hubp);
 }
 
 static struct hubp_funcs dcn30_hubp_funcs = {
@@ -497,6 +499,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 8394e8c06919..a65a0ddee646 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -79,6 +79,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index ca5b4b28a664..45023fa9b708 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -181,6 +181,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index d1f05b82b3dd..e7625290c0e4 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -199,6 +199,7 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index b1ebf5053b4f..2d52100510f0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -141,7 +141,7 @@ void hubp401_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor
 
 void hubp401_init(struct hubp *hubp)
 {
-	//For now nothing to do, HUBPREQ_DEBUG_DB register is removed on DCN4x.
+	hubp_reset(hubp);
 }
 
 void hubp401_vready_at_or_After_vsync(struct hubp *hubp,
@@ -974,6 +974,7 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = hubp401_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp401_cursor_set_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index a6a1db5ba8ba..fd0530251c6e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1286,6 +1286,7 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 		if (hws->funcs.hubp_pg_control)
 			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
@@ -1447,6 +1448,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index bd309dbdf7b2..f6b17bd3f714 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -787,6 +787,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
@@ -940,6 +941,7 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 /*to do, need to support both case*/
 	hubp->power_gated = true;
 
+	hubp->funcs->hubp_reset(hubp);
 	dpp->funcs->dpp_reset(dpp);
 
 	pipe_ctx->stream = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 16580d624278..eec16b0a199d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -152,6 +152,8 @@ struct hubp_funcs {
 	void (*dcc_control)(struct hubp *hubp, bool enable,
 			enum hubp_ind_block_size blk_size);
 
+	void (*hubp_reset)(struct hubp *hubp);
+
 	void (*mem_program_viewport)(
 			struct hubp *hubp,
 			const struct rect *viewport,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index b56298d9da98..5c54c9fd4461 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1420,6 +1420,8 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 			GetIndexIntoMasterTable(DATA, SMU_Info),
 			&size, &frev, &crev);
 
+	if (!psmu_info)
+		return -EINVAL;
 
 	for (i = 0; i < psmu_info->ucSclkEntryNum; i++) {
 		table->entry[i].ucVco_setting = psmu_info->asSclkFcwRangeEntry[i].ucVco_setting;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
index 3007b054c873..776d58ea63ae 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
@@ -1120,13 +1120,14 @@ static int vega10_enable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
 	result = vega10_program_didt_config_registers(hwmgr, SEEDCForceStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 	result |= vega10_program_didt_config_registers(hwmgr, SEEDCCtrlForceStallConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 	if (0 != result)
-		return result;
+		goto exit_safe_mode;
 
 	vega10_didt_set_mask(hwmgr, false);
 
+exit_safe_mode:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
-	return 0;
+	return result;
 }
 
 static int vega10_disable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 008d86cc562a..cf891e7677c0 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -300,7 +300,7 @@
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-#define AUX_FIFO_MAX_SIZE 32
+#define AUX_FIFO_MAX_SIZE 16
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index feb7a3a75981..936a8f95d80f 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -347,6 +347,8 @@ static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
 		is_limited_range ? HDMI_QUANTIZATION_RANGE_LIMITED : HDMI_QUANTIZATION_RANGE_FULL;
 	int ret;
 
+	infoframe->set = false;
+
 	ret = drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
 	if (ret)
 		return ret;
@@ -376,6 +378,8 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 		&infoframe->data.spd;
 	int ret;
 
+	infoframe->set = false;
+
 	ret = hdmi_spd_infoframe_init(frame,
 				      connector->hdmi.vendor,
 				      connector->hdmi.product);
@@ -398,6 +402,8 @@ static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
 		&infoframe->data.drm;
 	int ret;
 
+	infoframe->set = false;
+
 	if (connector->max_bpc < 10)
 		return 0;
 
@@ -425,6 +431,8 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
 		&infoframe->data.vendor.hdmi;
 	int ret;
 
+	infoframe->set = false;
+
 	if (!info->has_hdmi_infoframe)
 		return 0;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5c0c9d4e3be1..d3f6df047f5a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -342,6 +342,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
+	pgprot_t prot;
 
 	lockdep_assert_held(&obj->lock);
 
@@ -349,8 +350,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, obj->base.size >> PAGE_SHIFT,
-			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	switch (obj->flags & ETNA_BO_CACHE_MASK) {
+	case ETNA_BO_CACHED:
+		prot = PAGE_KERNEL;
+		break;
+	case ETNA_BO_UNCACHED:
+		prot = pgprot_noncached(PAGE_KERNEL);
+		break;
+	case ETNA_BO_WC:
+	default:
+		prot = pgprot_writecombine(PAGE_KERNEL);
+	}
+
+	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
 }
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 14db7376c712..e386b059187a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1603,7 +1603,9 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	gmu->dev = &pdev->dev;
 
-	of_dma_configure(gmu->dev, node, true);
+	ret = of_dma_configure(gmu->dev, node, true);
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(gmu->dev);
 
@@ -1668,7 +1670,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	gmu->dev = &pdev->dev;
 
-	of_dma_configure(gmu->dev, node, true);
+	ret = of_dma_configure(gmu->dev, node, true);
+	if (ret)
+		return ret;
 
 	/* Fow now, don't do anything fancy until we get our feet under us */
 	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
index eb5dfff2ec4f..e187e7b1cef1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
@@ -160,6 +160,7 @@ static const struct dpu_lm_cfg sm8650_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x400,
@@ -167,6 +168,7 @@ static const struct dpu_lm_cfg sm8650_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x400,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
index cbbdaebe357e..daef07924886 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
@@ -65,6 +65,54 @@ static const struct dpu_sspp_cfg sdm670_sspp[] = {
 	},
 };
 
+static const struct dpu_lm_cfg sdm670_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_1,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_1", .id = LM_1,
+		.base = 0x45000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_0,
+		.pingpong = PINGPONG_1,
+		.dspp = DSPP_1,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_5,
+		.pingpong = PINGPONG_2,
+	}, {
+		.name = "lm_5", .id = LM_5,
+		.base = 0x49000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_2,
+		.pingpong = PINGPONG_3,
+	},
+};
+
+static const struct dpu_dspp_cfg sdm670_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &sdm845_dspp_sblk,
+	}, {
+		.name = "dspp_1", .id = DSPP_1,
+		.base = 0x56000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &sdm845_dspp_sblk,
+	},
+};
+
 static const struct dpu_dsc_cfg sdm670_dsc[] = {
 	{
 		.name = "dsc_0", .id = DSC_0,
@@ -88,8 +136,10 @@ const struct dpu_mdss_cfg dpu_sdm670_cfg = {
 	.ctl = sdm845_ctl,
 	.sspp_count = ARRAY_SIZE(sdm670_sspp),
 	.sspp = sdm670_sspp,
-	.mixer_count = ARRAY_SIZE(sdm845_lm),
-	.mixer = sdm845_lm,
+	.mixer_count = ARRAY_SIZE(sdm670_lm),
+	.mixer = sdm670_lm,
+	.dspp_count = ARRAY_SIZE(sdm670_dspp),
+	.dspp = sdm670_dspp,
 	.pingpong_count = ARRAY_SIZE(sdm845_pp),
 	.pingpong = sdm845_pp,
 	.dsc_count = ARRAY_SIZE(sdm670_dsc),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 6ccfde82fecd..421afacb7248 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -164,6 +164,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -171,6 +172,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index bab19ddd1d4f..641023b102bf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -163,6 +163,7 @@ static const struct dpu_lm_cfg sc8180x_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -170,6 +171,7 @@ static const struct dpu_lm_cfg sc8180x_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
index a57d50b1f028..e8916ae826a6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
@@ -162,6 +162,7 @@ static const struct dpu_lm_cfg sm8250_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -169,6 +170,7 @@ static const struct dpu_lm_cfg sm8250_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index aced16e350da..f7c08e89c882 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -162,6 +162,7 @@ static const struct dpu_lm_cfg sm8350_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -169,6 +170,7 @@ static const struct dpu_lm_cfg sm8350_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index ad48defa154f..a1dbbf5c652f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -160,6 +160,7 @@ static const struct dpu_lm_cfg sm8550_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -167,6 +168,7 @@ static const struct dpu_lm_cfg sm8550_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index a3e60ac70689..e084406ebb07 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -159,6 +159,7 @@ static const struct dpu_lm_cfg x1e80100_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -166,6 +167,7 @@ static const struct dpu_lm_cfg x1e80100_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 576995ddce37..8bbc7fb881d5 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -389,7 +389,7 @@ struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 
 	/* TODO: different regulators in other cases? */
 	mdp4_lcdc_encoder->regs[0].supply = "lvds-vccs-3p3v";
-	mdp4_lcdc_encoder->regs[1].supply = "lvds-vccs-3p3v";
+	mdp4_lcdc_encoder->regs[1].supply = "lvds-pll-vdda";
 	mdp4_lcdc_encoder->regs[2].supply = "lvds-vdda";
 
 	ret = devm_regulator_bulk_get(dev->dev,
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index a599fc5d63c5..f4e01da5c55b 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -329,10 +329,10 @@ static void dp_audio_safe_to_exit_level(struct dp_audio_private *audio)
 		safe_to_exit_level = 5;
 		break;
 	default:
+		safe_to_exit_level = 14;
 		drm_dbg_dp(audio->drm_dev,
 				"setting the default safe_to_exit_level = %u\n",
 				safe_to_exit_level);
-		safe_to_exit_level = 14;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index e6ffaf92d26d..1c4211cfa2a4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -137,7 +137,7 @@ static inline u32 pll_get_integloop_gain(u64 frac_start, u64 bclk, u32 ref_clk,
 
 	base <<= (digclk_divsel == 2 ? 1 : 0);
 
-	return (base <= 2046 ? base : 2046);
+	return base;
 }
 
 static inline u32 pll_get_pll_cmp(u64 fdata, unsigned long ref_clk)
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index af6a6fcb1173..6749f0fbca96 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -244,7 +244,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ret = priv->kms_init(ddev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
-		priv->kms = NULL;
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 6fbff516c1c1..01dff89bed4e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -445,8 +445,8 @@ int panthor_device_resume(struct device *dev)
 	    drm_dev_enter(&ptdev->base, &cookie)) {
 		panthor_gpu_resume(ptdev);
 		panthor_mmu_resume(ptdev);
-		ret = drm_WARN_ON(&ptdev->base, panthor_fw_resume(ptdev));
-		if (!ret) {
+		ret = panthor_fw_resume(ptdev);
+		if (!drm_WARN_ON(&ptdev->base, ret)) {
 			panthor_sched_resume(ptdev);
 		} else {
 			panthor_mmu_suspend(ptdev);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9873172e3fd3..5880d87fe6b3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -33,7 +33,6 @@
 #include <uapi/linux/videodev2.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
 
-#include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_vop2.h"
 #include "rockchip_rgb.h"
@@ -550,6 +549,25 @@ static bool rockchip_vop2_mod_supported(struct drm_plane *plane, u32 format,
 	if (modifier == DRM_FORMAT_MOD_INVALID)
 		return false;
 
+	if (vop2->data->soc_id == 3568 || vop2->data->soc_id == 3566) {
+		if (vop2_cluster_window(win)) {
+			if (modifier == DRM_FORMAT_MOD_LINEAR) {
+				drm_dbg_kms(vop2->drm,
+					    "Cluster window only supports format with afbc\n");
+				return false;
+			}
+		}
+	}
+
+	if (format == DRM_FORMAT_XRGB2101010 || format == DRM_FORMAT_XBGR2101010) {
+		if (vop2->data->soc_id == 3588) {
+			if (!rockchip_afbc(plane, modifier)) {
+				drm_dbg_kms(vop2->drm, "Only support 32 bpp format with afbc\n");
+				return false;
+			}
+		}
+	}
+
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
@@ -1320,6 +1338,12 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		&fb->format->format,
 		afbc_en ? "AFBC" : "", &yrgb_mst);
 
+	if (vop2->data->soc_id > 3568) {
+		vop2_win_write(win, VOP2_WIN_AXI_BUS_ID, win->data->axi_bus_id);
+		vop2_win_write(win, VOP2_WIN_AXI_YRGB_R_ID, win->data->axi_yrgb_r_id);
+		vop2_win_write(win, VOP2_WIN_AXI_UV_R_ID, win->data->axi_uv_r_id);
+	}
+
 	if (vop2_cluster_window(win))
 		vop2_win_write(win, VOP2_WIN_AFBC_HALF_BLOCK_EN, half_block_en);
 
@@ -1721,9 +1745,9 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		else
 			dclk_out_rate = v_pixclk >> 2;
 
-		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000);
+		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000000);
 		if (!dclk_rate) {
-			drm_err(vop2->drm, "DP dclk_out_rate out of range, dclk_out_rate: %ld KHZ\n",
+			drm_err(vop2->drm, "DP dclk_out_rate out of range, dclk_out_rate: %ld Hz\n",
 				dclk_out_rate);
 			return 0;
 		}
@@ -1738,9 +1762,9 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		 * dclk_rate = N * dclk_core_rate N = (1,2,4 ),
 		 * we get a little factor here
 		 */
-		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000);
+		dclk_rate = rk3588_calc_dclk(dclk_out_rate, 600000000);
 		if (!dclk_rate) {
-			drm_err(vop2->drm, "MIPI dclk out of range, dclk_out_rate: %ld KHZ\n",
+			drm_err(vop2->drm, "MIPI dclk out of range, dclk_out_rate: %ld Hz\n",
 				dclk_out_rate);
 			return 0;
 		}
@@ -2159,7 +2183,6 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2 *vop2, u8 port_id)
 
 static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_win)
 {
-	u32 offset = (main_win->data->phys_id * 0x10);
 	struct vop2_alpha_config alpha_config;
 	struct vop2_alpha alpha;
 	struct drm_plane_state *bottom_win_pstate;
@@ -2167,6 +2190,7 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	u16 src_glb_alpha_val, dst_glb_alpha_val;
 	bool premulti_en = false;
 	bool swap = false;
+	u32 offset = 0;
 
 	/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/top win */
 	bottom_win_pstate = main_win->base.state;
@@ -2185,6 +2209,22 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	vop2_parse_alpha(&alpha_config, &alpha);
 
 	alpha.src_color_ctrl.bits.src_dst_swap = swap;
+
+	switch (main_win->data->phys_id) {
+	case ROCKCHIP_VOP2_CLUSTER0:
+		offset = 0x0;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER1:
+		offset = 0x10;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER2:
+		offset = 0x20;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER3:
+		offset = 0x30;
+		break;
+	}
+
 	vop2_writel(vop2, RK3568_CLUSTER0_MIX_SRC_COLOR_CTRL + offset,
 		    alpha.src_color_ctrl.val);
 	vop2_writel(vop2, RK3568_CLUSTER0_MIX_DST_COLOR_CTRL + offset,
@@ -2232,6 +2272,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 		struct vop2_win *win = to_vop2_win(plane);
 		int zpos = plane->state->normalized_zpos;
 
+		/*
+		 * Need to configure alpha from second layer.
+		 */
+		if (zpos == 0)
+			continue;
+
 		if (plane->state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
 			premulti_en = 1;
 		else
@@ -2308,7 +2354,10 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
-	unsigned int nlayer, ofs;
+	u8 layer_id;
+	u8 old_layer_id;
+	u8 layer_sel_id;
+	unsigned int ofs;
 	u32 ovl_ctrl;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
@@ -2352,9 +2401,30 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	for (i = 0; i < vp->id; i++)
 		ofs += vop2->vps[i].nlayers;
 
-	nlayer = 0;
 	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
 		struct vop2_win *win = to_vop2_win(plane);
+		struct vop2_win *old_win;
+
+		layer_id = (u8)(plane->state->normalized_zpos + ofs);
+
+		/*
+		 * Find the layer this win bind in old state.
+		 */
+		for (old_layer_id = 0; old_layer_id < vop2->data->win_size; old_layer_id++) {
+			layer_sel_id = (layer_sel >> (4 * old_layer_id)) & 0xf;
+			if (layer_sel_id == win->data->layer_sel_id)
+				break;
+		}
+
+		/*
+		 * Find the win bind to this layer in old state
+		 */
+		for (i = 0; i < vop2->data->win_size; i++) {
+			old_win = &vop2->win[i];
+			layer_sel_id = (layer_sel >> (4 * layer_id)) & 0xf;
+			if (layer_sel_id == old_win->data->layer_sel_id)
+				break;
+		}
 
 		switch (win->data->phys_id) {
 		case ROCKCHIP_VOP2_CLUSTER0:
@@ -2399,17 +2469,14 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 			break;
 		}
 
-		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(plane->state->normalized_zpos + ofs,
-							  0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(plane->state->normalized_zpos + ofs,
-							 win->data->layer_sel_id);
-		nlayer++;
-	}
-
-	/* configure unused layers to 0x5 (reserved) */
-	for (; nlayer < vp->nlayers; nlayer++) {
-		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(nlayer + ofs, 0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(nlayer + ofs, 5);
+		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(layer_id, 0x7);
+		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(layer_id, win->data->layer_sel_id);
+		/*
+		 * When we bind a window from layerM to layerN, we also need to move the old
+		 * window on layerN to layerM to avoid one window selected by two or more layers.
+		 */
+		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, 0x7);
+		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, old_win->data->layer_sel_id);
 	}
 
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
@@ -2444,9 +2511,11 @@ static void vop2_setup_dly_for_windows(struct vop2 *vop2)
 			sdly |= FIELD_PREP(RK3568_SMART_DLY_NUM__ESMART1, dly);
 			break;
 		case ROCKCHIP_VOP2_SMART0:
+		case ROCKCHIP_VOP2_ESMART2:
 			sdly |= FIELD_PREP(RK3568_SMART_DLY_NUM__SMART0, dly);
 			break;
 		case ROCKCHIP_VOP2_SMART1:
+		case ROCKCHIP_VOP2_ESMART3:
 			sdly |= FIELD_PREP(RK3568_SMART_DLY_NUM__SMART1, dly);
 			break;
 		}
@@ -2865,6 +2934,10 @@ static struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_Y2R_EN] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 8, 8),
 	[VOP2_WIN_R2Y_EN] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 9, 9),
 	[VOP2_WIN_CSC_MODE] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 10, 11),
+	[VOP2_WIN_AXI_YRGB_R_ID] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL2, 0, 3),
+	[VOP2_WIN_AXI_UV_R_ID] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL2, 5, 8),
+	/* RK3588 only, reserved bit on rk3568*/
+	[VOP2_WIN_AXI_BUS_ID] = REG_FIELD(RK3568_CLUSTER_CTRL, 13, 13),
 
 	/* Scale */
 	[VOP2_WIN_SCALE_YRGB_X] = REG_FIELD(RK3568_CLUSTER_WIN_SCL_FACTOR_YRGB, 0, 15),
@@ -2957,6 +3030,10 @@ static struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_YMIRROR] = REG_FIELD(RK3568_SMART_CTRL1, 31, 31),
 	[VOP2_WIN_COLOR_KEY] = REG_FIELD(RK3568_SMART_COLOR_KEY_CTRL, 0, 29),
 	[VOP2_WIN_COLOR_KEY_EN] = REG_FIELD(RK3568_SMART_COLOR_KEY_CTRL, 31, 31),
+	[VOP2_WIN_AXI_YRGB_R_ID] = REG_FIELD(RK3568_SMART_CTRL1, 4, 8),
+	[VOP2_WIN_AXI_UV_R_ID] = REG_FIELD(RK3568_SMART_CTRL1, 12, 16),
+	/* RK3588 only, reserved register on rk3568 */
+	[VOP2_WIN_AXI_BUS_ID] = REG_FIELD(RK3588_SMART_AXI_CTRL, 1, 1),
 
 	/* Scale */
 	[VOP2_WIN_SCALE_YRGB_X] = REG_FIELD(RK3568_SMART_REGION0_SCL_FACTOR_YRGB, 0, 15),
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 615a16196aff..130aaa40316d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -9,6 +9,7 @@
 
 #include <linux/regmap.h>
 #include <drm/drm_modes.h>
+#include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
 
 #define VOP2_VP_FEATURE_OUTPUT_10BIT        BIT(0)
@@ -78,6 +79,9 @@ enum vop2_win_regs {
 	VOP2_WIN_COLOR_KEY,
 	VOP2_WIN_COLOR_KEY_EN,
 	VOP2_WIN_DITHER_UP,
+	VOP2_WIN_AXI_BUS_ID,
+	VOP2_WIN_AXI_YRGB_R_ID,
+	VOP2_WIN_AXI_UV_R_ID,
 
 	/* scale regs */
 	VOP2_WIN_SCALE_YRGB_X,
@@ -140,6 +144,10 @@ struct vop2_win_data {
 	unsigned int layer_sel_id;
 	uint64_t feature;
 
+	uint8_t axi_bus_id;
+	uint8_t axi_yrgb_r_id;
+	uint8_t axi_uv_r_id;
+
 	unsigned int max_upscale_factor;
 	unsigned int max_downscale_factor;
 	const u8 dly[VOP2_DLY_MODE_MAX];
@@ -308,6 +316,7 @@ enum dst_factor_mode {
 
 #define RK3568_CLUSTER_WIN_CTRL0		0x00
 #define RK3568_CLUSTER_WIN_CTRL1		0x04
+#define RK3568_CLUSTER_WIN_CTRL2		0x08
 #define RK3568_CLUSTER_WIN_YRGB_MST		0x10
 #define RK3568_CLUSTER_WIN_CBR_MST		0x14
 #define RK3568_CLUSTER_WIN_VIR			0x18
@@ -330,6 +339,7 @@ enum dst_factor_mode {
 /* (E)smart register definition, offset relative to window base */
 #define RK3568_SMART_CTRL0			0x00
 #define RK3568_SMART_CTRL1			0x04
+#define RK3588_SMART_AXI_CTRL			0x08
 #define RK3568_SMART_REGION0_CTRL		0x10
 #define RK3568_SMART_REGION0_YRGB_MST		0x14
 #define RK3568_SMART_REGION0_CBR_MST		0x18
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 18efb3fe1c00..e473a8f8fd32 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -313,7 +313,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
  * AXI1 is a read only bus.
  *
  * Every window on a AXI bus must assigned two unique
- * read id(yrgb_id/uv_id, valid id are 0x1~0xe).
+ * read id(yrgb_r_id/uv_r_id, valid id are 0x1~0xe).
  *
  * AXI0:
  * Cluster0/1, Esmart0/1, WriteBack
@@ -333,6 +333,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 0,
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 2,
+		.axi_uv_r_id = 3,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -349,6 +352,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 6,
+		.axi_uv_r_id = 7,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -364,6 +370,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 2,
+		.axi_uv_r_id = 3,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -379,6 +388,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 6,
+		.axi_uv_r_id = 7,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -393,6 +405,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 2,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 0x0a,
+		.axi_uv_r_id = 0x0b,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
@@ -406,6 +421,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 3,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 0x0c,
+		.axi_uv_r_id = 0x01,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
@@ -419,6 +437,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 6,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 0x0a,
+		.axi_uv_r_id = 0x0b,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
@@ -432,6 +453,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 7,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 0x0c,
+		.axi_uv_r_id = 0x0d,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 19e3ee7ac897..76816f2551c1 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -237,8 +237,8 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	if (v3d->ver >= 40) {
 		int cycle_count_reg = V3D_PCTR_CYCLE_COUNT(v3d->ver);
 		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
-			       V3D_SET_FIELD(cycle_count_reg,
-					     V3D_PCTR_S0));
+			       V3D_SET_FIELD_VER(cycle_count_reg,
+						 V3D_PCTR_S0, v3d->ver));
 		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_CLR, 1);
 		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_EN, 1);
 	} else {
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 6ee56cbd3f1b..e3013ac3a5c2 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -240,17 +240,18 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 
 	for (i = 0; i < ncounters; i++) {
 		u32 source = i / 4;
-		u32 channel = V3D_SET_FIELD(perfmon->counters[i], V3D_PCTR_S0);
+		u32 channel = V3D_SET_FIELD_VER(perfmon->counters[i], V3D_PCTR_S0,
+						v3d->ver);
 
 		i++;
-		channel |= V3D_SET_FIELD(i < ncounters ? perfmon->counters[i] : 0,
-					 V3D_PCTR_S1);
+		channel |= V3D_SET_FIELD_VER(i < ncounters ? perfmon->counters[i] : 0,
+					     V3D_PCTR_S1, v3d->ver);
 		i++;
-		channel |= V3D_SET_FIELD(i < ncounters ? perfmon->counters[i] : 0,
-					 V3D_PCTR_S2);
+		channel |= V3D_SET_FIELD_VER(i < ncounters ? perfmon->counters[i] : 0,
+					     V3D_PCTR_S2, v3d->ver);
 		i++;
-		channel |= V3D_SET_FIELD(i < ncounters ? perfmon->counters[i] : 0,
-					 V3D_PCTR_S3);
+		channel |= V3D_SET_FIELD_VER(i < ncounters ? perfmon->counters[i] : 0,
+					     V3D_PCTR_S3, v3d->ver);
 		V3D_CORE_WRITE(0, V3D_V4_PCTR_0_SRC_X(source), channel);
 	}
 
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index 1b1a62ad9585..6da3c69082bd 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -15,6 +15,14 @@
 		fieldval & field##_MASK;				\
 	 })
 
+#define V3D_SET_FIELD_VER(value, field, ver)				\
+	({								\
+		typeof(ver) _ver = (ver);				\
+		u32 fieldval = (value) << field##_SHIFT(_ver);		\
+		WARN_ON((fieldval & ~field##_MASK(_ver)) != 0);		\
+		fieldval & field##_MASK(_ver);				\
+	 })
+
 #define V3D_GET_FIELD(word, field) (((word) & field##_MASK) >>		\
 				    field##_SHIFT)
 
@@ -354,18 +362,15 @@
 #define V3D_V4_PCTR_0_SRC_28_31                        0x0067c
 #define V3D_V4_PCTR_0_SRC_X(x)                         (V3D_V4_PCTR_0_SRC_0_3 + \
 							4 * (x))
-# define V3D_PCTR_S0_MASK                              V3D_MASK(6, 0)
-# define V3D_V7_PCTR_S0_MASK                           V3D_MASK(7, 0)
-# define V3D_PCTR_S0_SHIFT                             0
-# define V3D_PCTR_S1_MASK                              V3D_MASK(14, 8)
-# define V3D_V7_PCTR_S1_MASK                           V3D_MASK(15, 8)
-# define V3D_PCTR_S1_SHIFT                             8
-# define V3D_PCTR_S2_MASK                              V3D_MASK(22, 16)
-# define V3D_V7_PCTR_S2_MASK                           V3D_MASK(23, 16)
-# define V3D_PCTR_S2_SHIFT                             16
-# define V3D_PCTR_S3_MASK                              V3D_MASK(30, 24)
-# define V3D_V7_PCTR_S3_MASK                           V3D_MASK(31, 24)
-# define V3D_PCTR_S3_SHIFT                             24
+# define V3D_PCTR_S0_MASK(ver) (((ver) >= 71) ? V3D_MASK(7, 0) : V3D_MASK(6, 0))
+# define V3D_PCTR_S0_SHIFT(ver)                        0
+# define V3D_PCTR_S1_MASK(ver) (((ver) >= 71) ? V3D_MASK(15, 8) : V3D_MASK(14, 8))
+# define V3D_PCTR_S1_SHIFT(ver)                        8
+# define V3D_PCTR_S2_MASK(ver) (((ver) >= 71) ? V3D_MASK(23, 16) : V3D_MASK(22, 16))
+# define V3D_PCTR_S2_SHIFT(ver)                        16
+# define V3D_PCTR_S3_MASK(ver) (((ver) >= 71) ? V3D_MASK(31, 24) : V3D_MASK(30, 24))
+# define V3D_PCTR_S3_SHIFT(ver)                        24
+
 #define V3D_PCTR_CYCLE_COUNT(ver) ((ver >= 71) ? 0 : 32)
 
 /* Output values of the counters. */
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 935ccc38d129..155deef867ac 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1125,6 +1125,8 @@ static void hid_apply_multiplier(struct hid_device *hid,
 	while (multiplier_collection->parent_idx != -1 &&
 	       multiplier_collection->type != HID_COLLECTION_LOGICAL)
 		multiplier_collection = &hid->collection[multiplier_collection->parent_idx];
+	if (multiplier_collection->type != HID_COLLECTION_LOGICAL)
+		multiplier_collection = NULL;
 
 	effective_multiplier = hid_calculate_multiplier(hid, multiplier);
 
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index fda9dce3da99..9d80635a91eb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -810,10 +810,23 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 		}
 
-		if ((usage->hid & 0xf0) == 0x90) { /* SystemControl*/
-			switch (usage->hid & 0xf) {
-			case 0xb: map_key_clear(KEY_DO_NOT_DISTURB); break;
-			default: goto ignore;
+		if ((usage->hid & 0xf0) == 0x90) { /* SystemControl & D-pad */
+			switch (usage->hid) {
+			case HID_GD_UP:	   usage->hat_dir = 1; break;
+			case HID_GD_DOWN:  usage->hat_dir = 5; break;
+			case HID_GD_RIGHT: usage->hat_dir = 3; break;
+			case HID_GD_LEFT:  usage->hat_dir = 7; break;
+			case HID_GD_DO_NOT_DISTURB:
+				map_key_clear(KEY_DO_NOT_DISTURB); break;
+			default: goto unknown;
+			}
+
+			if (usage->hid <= HID_GD_LEFT) {
+				if (field->dpad) {
+					map_abs(field->dpad);
+					goto ignore;
+				}
+				map_abs(ABS_HAT0X);
 			}
 			break;
 		}
@@ -844,22 +857,6 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		if (field->application == HID_GD_SYSTEM_CONTROL)
 			goto ignore;
 
-		if ((usage->hid & 0xf0) == 0x90) {	/* D-pad */
-			switch (usage->hid) {
-			case HID_GD_UP:	   usage->hat_dir = 1; break;
-			case HID_GD_DOWN:  usage->hat_dir = 5; break;
-			case HID_GD_RIGHT: usage->hat_dir = 3; break;
-			case HID_GD_LEFT:  usage->hat_dir = 7; break;
-			default: goto unknown;
-			}
-			if (field->dpad) {
-				map_abs(field->dpad);
-				goto ignore;
-			}
-			map_abs(ABS_HAT0X);
-			break;
-		}
-
 		switch (usage->hid) {
 		/* These usage IDs map directly to the usage codes. */
 		case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index d1b7ccfb3e05..e07d63db5e1f 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2078,7 +2078,7 @@ static const struct hid_device_id mt_devices[] = {
 		     I2C_DEVICE_ID_GOODIX_01E8) },
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-		     I2C_DEVICE_ID_GOODIX_01E8) },
+		     I2C_DEVICE_ID_GOODIX_01E9) },
 
 	/* GoodTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index cf1679b0d4fb..6c3e758bbb09 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -170,6 +170,14 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 	ep = &usbif->cur_altsetting->endpoint[1];
 	b_ep = ep->desc.bEndpointAddress;
 
+	/* Are the expected endpoints present? */
+	u8 ep_addr[1] = {b_ep};
+
+	if (!usb_check_int_endpoints(usbif, ep_addr)) {
+		hid_err(hdev, "Unexpected non-int endpoint\n");
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(setup_arr); ++i) {
 		memcpy(send_buf, setup_arr[i], setup_arr_sizes[i]);
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08a3c863f80a..58480a3f4683 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -413,7 +413,7 @@ config SENSORS_ASPEED
 	  will be called aspeed_pwm_tacho.
 
 config SENSORS_ASPEED_G6
-	tristate "ASPEED g6 PWM and Fan tach driver"
+	tristate "ASPEED G6 PWM and Fan tach driver"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on PWM
 	help
@@ -421,7 +421,7 @@ config SENSORS_ASPEED_G6
 	  controllers.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called aspeed_pwm_tacho.
+	  will be called aspeed_g6_pwm_tach.
 
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index ee04795b98aa..fa3351351825 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -42,6 +42,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#undef DEFAULT_SYMBOL_NAMESPACE
+#define DEFAULT_SYMBOL_NAMESPACE "HWMON_NCT6775"
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -56,9 +59,6 @@
 #include "lm75.h"
 #include "nct6775.h"
 
-#undef DEFAULT_SYMBOL_NAMESPACE
-#define DEFAULT_SYMBOL_NAMESPACE HWMON_NCT6775
-
 #define USE_ALTERNATE
 
 /* used to set data->name = nct6775_device_names[data->sio_kind] */
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 9d88b4fa03e4..b3282785523d 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -8,6 +8,9 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
+
+#define DEFAULT_SYMBOL_NAMESPACE	"I2C_DW_COMMON"
+
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -29,8 +32,6 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
-#define DEFAULT_SYMBOL_NAMESPACE	I2C_DW_COMMON
-
 #include "i2c-designware-core.h"
 
 static char *abort_sources[] = {
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index e8ac9a7bf0b3..28188c6d0555 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -8,6 +8,9 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
+
+#define DEFAULT_SYMBOL_NAMESPACE	"I2C_DW"
+
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -22,8 +25,6 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#define DEFAULT_SYMBOL_NAMESPACE	I2C_DW
-
 #include "i2c-designware-core.h"
 
 #define AMD_TIMEOUT_MIN_US	25
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 7035296aa24c..f0f0f1f2131d 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -6,6 +6,9 @@
  *
  * Copyright (C) 2016 Synopsys Inc.
  */
+
+#define DEFAULT_SYMBOL_NAMESPACE	"I2C_DW"
+
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -16,8 +19,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
-#define DEFAULT_SYMBOL_NAMESPACE	I2C_DW
-
 #include "i2c-designware-core.h"
 
 static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8d694672c110..dbcd3984f257 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1624,6 +1624,7 @@ EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
 
 void dw_i3c_common_remove(struct dw_i3c_master *master)
 {
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	pm_runtime_disable(master->dev);
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index 1211f4317a9f..aba96ca9bce5 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_INFINIBAND_OCRDMA)		+= ocrdma/
 obj-$(CONFIG_INFINIBAND_VMWARE_PVRDMA)	+= vmw_pvrdma/
 obj-$(CONFIG_INFINIBAND_USNIC)		+= usnic/
 obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
-obj-$(CONFIG_INFINIBAND_HNS)		+= hns/
+obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 14e434ff51ed..a7067c3c0679 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4395,9 +4395,10 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 	case BNXT_RE_MMAP_TOGGLE_PAGE:
 		/* Driver doesn't expect write access for user space */
 		if (vma->vm_flags & VM_WRITE)
-			return -EFAULT;
-		ret = vm_insert_page(vma, vma->vm_start,
-				     virt_to_page((void *)bnxt_entry->mem_offset));
+			ret = -EFAULT;
+		else
+			ret = vm_insert_page(vma, vma->vm_start,
+					     virt_to_page((void *)bnxt_entry->mem_offset));
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 80970a1738f8..034b85c42255 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -1114,8 +1114,10 @@ static inline struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * The math here assumes sizeof cpl_pass_accept_req >= sizeof
 	 * cpl_rx_pkt.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req) +
-			sizeof(struct rss_header) - pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req) +
+				 sizeof(struct rss_header)) - pktshift,
+			GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 7b5c4522b426..955f061a55e9 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1599,6 +1599,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
 	int count;
 	int rq_flushed = 0, sq_flushed;
 	unsigned long flag;
+	struct ib_event ev;
 
 	pr_debug("qhp %p rchp %p schp %p\n", qhp, rchp, schp);
 
@@ -1607,6 +1608,13 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
 	if (schp != rchp)
 		spin_lock(&schp->lock);
 	spin_lock(&qhp->lock);
+	if (qhp->srq && qhp->attr.state == C4IW_QP_STATE_ERROR &&
+	    qhp->ibqp.event_handler) {
+		ev.device = qhp->ibqp.device;
+		ev.element.qp = &qhp->ibqp;
+		ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
+		qhp->ibqp.event_handler(&ev, qhp->ibqp.qp_context);
+	}
 
 	if (qhp->wq.flushed) {
 		spin_unlock(&qhp->lock);
diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index ab3fbba70789..44cdb706fe27 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -1,21 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config INFINIBAND_HNS
-	tristate "HNS RoCE Driver"
-	depends on NET_VENDOR_HISILICON
-	depends on ARM64 || (COMPILE_TEST && 64BIT)
-	depends on (HNS_DSAF && HNS_ENET) || HNS3
-	help
-	  This is a RoCE/RDMA driver for the Hisilicon RoCE engine.
-
-	  To compile HIP08 driver as module, choose M here.
-
 config INFINIBAND_HNS_HIP08
-	bool "Hisilicon Hip08 Family RoCE support"
-	depends on INFINIBAND_HNS && PCI && HNS3
-	depends on INFINIBAND_HNS=m || HNS3=y
+	tristate "Hisilicon Hip08 Family RoCE support"
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on PCI && HNS3
 	help
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
 	  The RoCE engine is a PCI device.
 
-	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
-	  module will be called hns-roce-hw-v2.
+	  To compile this driver, choose M here. This module will be called
+	  hns-roce-hw-v2.
diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index be1e1cdbcfa8..7917af8e6380 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -5,12 +5,9 @@
 
 ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
-hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
+hns-roce-hw-v2-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o \
-	hns_roce_debugfs.o
+	hns_roce_debugfs.o hns_roce_hw_v2.o
 
-ifdef CONFIG_INFINIBAND_HNS_HIP08
-hns-roce-hw-v2-objs := hns_roce_hw_v2.o $(hns-roce-objs)
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v2.o
-endif
+obj-$(CONFIG_INFINIBAND_HNS_HIP08) += hns-roce-hw-v2.o
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 529db874d67c..b1bbdcff631d 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -351,7 +351,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	struct mlx4_port_gid_table   *port_gid_table;
 	int ret = 0;
 	int hw_update = 0;
-	struct gid_entry *gids;
+	struct gid_entry *gids = NULL;
 
 	if (!rdma_cap_roce_gid_table(attr->device, attr->port_num))
 		return -EINVAL;
@@ -389,10 +389,10 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	}
 	spin_unlock_bh(&iboe->lock);
 
-	if (!ret && hw_update) {
+	if (gids)
 		ret = mlx4_ib_update_gids(gids, ibdev, attr->port_num);
-		kfree(gids);
-	}
+
+	kfree(gids);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4b37446758fd..64b441542cd5 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -228,13 +228,27 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *imr = mr->parent;
 
+	/*
+	 * If userspace is racing freeing the parent implicit ODP MR then we can
+	 * loose the race with parent destruction. In this case
+	 * mlx5_ib_free_odp_mr() will free everything in the implicit_children
+	 * xarray so NOP is fine. This child MR cannot be destroyed here because
+	 * we are under its umem_mutex.
+	 */
 	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
 		return;
 
-	xa_erase(&imr->implicit_children, idx);
+	xa_lock(&imr->implicit_children);
+	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
+	    mr) {
+		xa_unlock(&imr->implicit_children);
+		return;
+	}
+
 	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
-		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
-			 mlx5_base_mkey(mr->mmkey.key));
+		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			   mlx5_base_mkey(mr->mmkey.key));
+	xa_unlock(&imr->implicit_children);
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
@@ -500,18 +514,18 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		refcount_inc(&ret->mmkey.usecount);
 		goto out_lock;
 	}
-	xa_unlock(&imr->implicit_children);
 
 	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
-		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-			       &mr->mmkey, GFP_KERNEL);
+		ret = __xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+				 &mr->mmkey, GFP_KERNEL);
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
-			xa_erase(&imr->implicit_children, idx);
-			goto out_mr;
+			__xa_erase(&imr->implicit_children, idx);
+			goto out_lock;
 		}
 		mr->mmkey.type = MLX5_MKEY_IMPLICIT_CHILD;
 	}
+	xa_unlock(&imr->implicit_children);
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
@@ -944,8 +958,7 @@ static struct mlx5_ib_mkey *find_odp_mkey(struct mlx5_ib_dev *dev, u32 key)
 /*
  * Handle a single data segment in a page-fault WQE or RDMA region.
  *
- * Returns number of OS pages retrieved on success. The caller may continue to
- * the next data segment.
+ * Returns zero on success. The caller may continue to the next data segment.
  * Can return the following error codes:
  * -EAGAIN to designate a temporary error. The caller will abort handling the
  *  page fault and resolve it.
@@ -958,7 +971,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 					 u32 *bytes_committed,
 					 u32 *bytes_mapped)
 {
-	int npages = 0, ret, i, outlen, cur_outlen = 0, depth = 0;
+	int ret, i, outlen, cur_outlen = 0, depth = 0, pages_in_range;
 	struct pf_frame *head = NULL, *frame;
 	struct mlx5_ib_mkey *mmkey;
 	struct mlx5_ib_mr *mr;
@@ -993,13 +1006,20 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
+		pages_in_range = (ALIGN(io_virt + bcnt, PAGE_SIZE) -
+				  (io_virt & PAGE_MASK)) >>
+				 PAGE_SHIFT;
 		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0, false);
 		if (ret < 0)
 			goto end;
 
 		mlx5_update_odp_stats(mr, faults, ret);
 
-		npages += ret;
+		if (ret < pages_in_range) {
+			ret = -EFAULT;
+			goto end;
+		}
+
 		ret = 0;
 		break;
 
@@ -1090,7 +1110,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	kfree(out);
 
 	*bytes_committed = 0;
-	return ret ? ret : npages;
+	return ret;
 }
 
 /*
@@ -1109,8 +1129,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
  *                   the committed bytes).
  * @receive_queue: receive WQE end of sg list
  *
- * Returns the number of pages loaded if positive, zero for an empty WQE, or a
- * negative error code.
+ * Returns zero for success or a negative error code.
  */
 static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 				   struct mlx5_pagefault *pfault,
@@ -1118,7 +1137,7 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 				   void *wqe_end, u32 *bytes_mapped,
 				   u32 *total_wqe_bytes, bool receive_queue)
 {
-	int ret = 0, npages = 0;
+	int ret = 0;
 	u64 io_virt;
 	__be32 key;
 	u32 byte_count;
@@ -1175,10 +1194,9 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 						    bytes_mapped);
 		if (ret < 0)
 			break;
-		npages += ret;
 	}
 
-	return ret < 0 ? ret : npages;
+	return ret;
 }
 
 /*
@@ -1414,12 +1432,6 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 	free_page((unsigned long)wqe_start);
 }
 
-static int pages_in_range(u64 address, u32 length)
-{
-	return (ALIGN(address + length, PAGE_SIZE) -
-		(address & PAGE_MASK)) >> PAGE_SHIFT;
-}
-
 static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 					   struct mlx5_pagefault *pfault)
 {
@@ -1458,7 +1470,7 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 	if (ret == -EAGAIN) {
 		/* We're racing with an invalidation, don't prefetch */
 		prefetch_activated = 0;
-	} else if (ret < 0 || pages_in_range(address, length) > ret) {
+	} else if (ret < 0) {
 		mlx5_ib_page_fault_resume(dev, pfault, 1);
 		if (ret != -ENOENT)
 			mlx5_ib_dbg(dev, "PAGE FAULT error %d. QP 0x%llx, type: 0x%x\n",
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index d2f57ead78ad..003f681e5dc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -129,7 +129,7 @@ enum rxe_device_param {
 enum rxe_port_param {
 	RXE_PORT_GID_TBL_LEN		= 1024,
 	RXE_PORT_PORT_CAP_FLAGS		= IB_PORT_CM_SUP,
-	RXE_PORT_MAX_MSG_SZ		= 0x800000,
+	RXE_PORT_MAX_MSG_SZ		= (1UL << 31),
 	RXE_PORT_BAD_PKEY_CNTR		= 0,
 	RXE_PORT_QKEY_VIOL_CNTR		= 0,
 	RXE_PORT_LID			= 0,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 67567d62195e..d9cb682fd71f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -178,7 +178,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 {
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
-	static int timeout = RXE_POOL_TIMEOUT;
 	int ret, err = 0;
 	void *xa_ret;
 
@@ -202,19 +201,19 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	 * return to rdma-core
 	 */
 	if (sleepable) {
-		if (!completion_done(&elem->complete) && timeout) {
+		if (!completion_done(&elem->complete)) {
 			ret = wait_for_completion_timeout(&elem->complete,
-					timeout);
+					msecs_to_jiffies(50000));
 
 			/* Shouldn't happen. There are still references to
 			 * the object but, rather than deadlock, free the
 			 * object or pass back to rdma-core.
 			 */
 			if (WARN_ON(!ret))
-				err = -EINVAL;
+				err = -ETIMEDOUT;
 		}
 	} else {
-		unsigned long until = jiffies + timeout;
+		unsigned long until = jiffies + RXE_POOL_TIMEOUT;
 
 		/* AH objects are unique in that the destroy_ah verb
 		 * can be called in atomic context. This delay
@@ -226,7 +225,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 			mdelay(1);
 
 		if (WARN_ON(!completion_done(&elem->complete)))
-			err = -EINVAL;
+			err = -ETIMEDOUT;
 	}
 
 	if (pool->cleanup)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8a5fc20fd186..589ac0d8489d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -696,7 +696,7 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		for (i = 0; i < ibwr->num_sge; i++)
 			length += ibwr->sg_list[i].length;
 
-		if (length > (1UL << 31)) {
+		if (length > RXE_PORT_MAX_MSG_SZ) {
 			rxe_err_qp(qp, "message length too long\n");
 			break;
 		}
@@ -980,8 +980,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	for (i = 0; i < num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	/* IBA max message size is 2^31 */
-	if (length >= (1UL<<31)) {
+	if (length > RXE_PORT_MAX_MSG_SZ) {
 		err = -EINVAL;
 		rxe_dbg("message length too long\n");
 		goto err_out;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4e17d546d4cc..bf38ac6f87c4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -584,6 +584,9 @@ static void dev_free(struct kref *ref)
 	list_del(&dev->entry);
 	mutex_unlock(&pool->mutex);
 
+	if (pool->ops && pool->ops->deinit)
+		pool->ops->deinit(dev);
+
 	ib_dealloc_pd(dev->ib_pd);
 	kfree(dev);
 }
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2916e77f589b..7289ae0b83ac 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3978,7 +3978,6 @@ static struct srp_host *srp_add_port(struct srp_device *device, u32 port)
 	return host;
 
 put_host:
-	device_del(&host->dev);
 	put_device(&host->dev);
 	return NULL;
 }
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..6fac9ee8dd3e 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -87,7 +87,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  */
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
-void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..a24a97a2c646 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1606,15 +1606,6 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 	domain_flush_complete(domain);
 }
 
-void amd_iommu_domain_update(struct protection_domain *domain)
-{
-	/* Update device table */
-	amd_iommu_update_and_flush_device_table(domain);
-
-	/* Flush domain TLB(s) and wait for completion */
-	amd_iommu_domain_flush_all(domain);
-}
-
 int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 353fea58cd31..f1a8f8c75cb0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2702,9 +2702,14 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		 * Translation Requests and Translated transactions are denied
 		 * as though ATS is disabled for the stream (STE.EATS == 0b00),
 		 * causing F_BAD_ATS_TREQ and F_TRANSL_FORBIDDEN events
-		 * (IHI0070Ea 5.2 Stream Table Entry). Thus ATS can only be
-		 * enabled if we have arm_smmu_domain, those always have page
-		 * tables.
+		 * (IHI0070Ea 5.2 Stream Table Entry).
+		 *
+		 * However, if we have installed a CD table and are using S1DSS
+		 * then ATS will work in S1DSS bypass. See "13.6.4 Full ATS
+		 * skipping stage 1".
+		 *
+		 * Disable ATS if we are going to create a normal 0b100 bypass
+		 * STE.
 		 */
 		state->ats_enabled = arm_smmu_ats_supported(master);
 	}
@@ -3017,8 +3022,10 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	if (arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
-		 * on even though the RID will fail ATS queries with UR. This is
-		 * because we have no idea what the PASID's need.
+		 * on because we have to assume a PASID is using ATS. For
+		 * IDENTITY this will setup things so that S1DSS=bypass which
+		 * follows the explanation in "13.6.4 Full ATS skipping stage 1"
+		 * and allows for ATS on the RID to work.
 		 */
 		state.cd_needs_ats = true;
 		arm_smmu_attach_prepare(&state, domain);
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index d90b9e253412..2cdc4f542df4 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -130,7 +130,7 @@ struct iova_bitmap {
 static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
 						 unsigned long iova)
 {
-	unsigned long pgsize = 1 << bitmap->mapped.pgshift;
+	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
 
 	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
 }
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b5f5d27ee963..649fe79d0f0c 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -130,7 +130,7 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (wait_event_timeout(ictx->destroy_wait,
 				refcount_read(&to_destroy->shortterm_users) ==
 					0,
-				msecs_to_jiffies(10000)))
+				msecs_to_jiffies(60000)))
 		return 0;
 
 	pr_crit("Time out waiting for iommufd object to become free\n");
diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
index b4998402b8c6..711ac4bd6058 100644
--- a/drivers/leds/leds-cht-wcove.c
+++ b/drivers/leds/leds-cht-wcove.c
@@ -394,7 +394,7 @@ static int cht_wc_leds_probe(struct platform_device *pdev)
 		led->cdev.pattern_clear = cht_wc_leds_pattern_clear;
 		led->cdev.max_brightness = 255;
 
-		ret = led_classdev_register(&pdev->dev, &led->cdev);
+		ret = devm_led_classdev_register(&pdev->dev, &led->cdev);
 		if (ret < 0)
 			return ret;
 	}
@@ -406,10 +406,6 @@ static int cht_wc_leds_probe(struct platform_device *pdev)
 static void cht_wc_leds_remove(struct platform_device *pdev)
 {
 	struct cht_wc_leds *leds = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < CHT_WC_LED_COUNT; i++)
-		led_classdev_unregister(&leds->leds[i].cdev);
 
 	/* Restore LED1 regs if hw-control was active else leave LED1 off */
 	if (!(leds->led1_initial_regs.ctrl & CHT_WC_LED1_SWCTL))
diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index af5a908b8d9e..e95287416ef8 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -439,6 +439,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	}
 	gpio_ext_pdev = of_find_device_by_node(gpio_ext_np);
 	if (!gpio_ext_pdev) {
+		of_node_put(gpio_ext_np);
 		dev_err(dev, "Failed to find platform device for gpio-ext\n");
 		return -ENODEV;
 	}
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index c3a42dd66ce5..2e3087556adb 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1671,24 +1671,13 @@ __acquires(bitmap->lock)
 }
 
 static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
-			     unsigned long sectors, bool behind)
+			     unsigned long sectors)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
 	if (!bitmap)
 		return 0;
 
-	if (behind) {
-		int bw;
-		atomic_inc(&bitmap->behind_writes);
-		bw = atomic_read(&bitmap->behind_writes);
-		if (bw > bitmap->behind_writes_used)
-			bitmap->behind_writes_used = bw;
-
-		pr_debug("inc write-behind count %d/%lu\n",
-			 bw, bitmap->mddev->bitmap_info.max_write_behind);
-	}
-
 	while (sectors) {
 		sector_t blocks;
 		bitmap_counter_t *bmc;
@@ -1737,21 +1726,13 @@ static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
 }
 
 static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
-			    unsigned long sectors, bool success, bool behind)
+			    unsigned long sectors)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
 	if (!bitmap)
 		return;
 
-	if (behind) {
-		if (atomic_dec_and_test(&bitmap->behind_writes))
-			wake_up(&bitmap->behind_wait);
-		pr_debug("dec write-behind count %d/%lu\n",
-			 atomic_read(&bitmap->behind_writes),
-			 bitmap->mddev->bitmap_info.max_write_behind);
-	}
-
 	while (sectors) {
 		sector_t blocks;
 		unsigned long flags;
@@ -1764,15 +1745,16 @@ static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
 			return;
 		}
 
-		if (success && !bitmap->mddev->degraded &&
-		    bitmap->events_cleared < bitmap->mddev->events) {
-			bitmap->events_cleared = bitmap->mddev->events;
-			bitmap->need_sync = 1;
-			sysfs_notify_dirent_safe(bitmap->sysfs_can_clear);
-		}
-
-		if (!success && !NEEDED(*bmc))
+		if (!bitmap->mddev->degraded) {
+			if (bitmap->events_cleared < bitmap->mddev->events) {
+				bitmap->events_cleared = bitmap->mddev->events;
+				bitmap->need_sync = 1;
+				sysfs_notify_dirent_safe(
+						bitmap->sysfs_can_clear);
+			}
+		} else if (!NEEDED(*bmc)) {
 			*bmc |= NEEDED_MASK;
+		}
 
 		if (COUNTER(*bmc) == COUNTER_MAX)
 			wake_up(&bitmap->overflow_wait);
@@ -2062,6 +2044,37 @@ static void md_bitmap_free(void *data)
 	kfree(bitmap);
 }
 
+static void bitmap_start_behind_write(struct mddev *mddev)
+{
+	struct bitmap *bitmap = mddev->bitmap;
+	int bw;
+
+	if (!bitmap)
+		return;
+
+	atomic_inc(&bitmap->behind_writes);
+	bw = atomic_read(&bitmap->behind_writes);
+	if (bw > bitmap->behind_writes_used)
+		bitmap->behind_writes_used = bw;
+
+	pr_debug("inc write-behind count %d/%lu\n",
+		 bw, bitmap->mddev->bitmap_info.max_write_behind);
+}
+
+static void bitmap_end_behind_write(struct mddev *mddev)
+{
+	struct bitmap *bitmap = mddev->bitmap;
+
+	if (!bitmap)
+		return;
+
+	if (atomic_dec_and_test(&bitmap->behind_writes))
+		wake_up(&bitmap->behind_wait);
+	pr_debug("dec write-behind count %d/%lu\n",
+		 atomic_read(&bitmap->behind_writes),
+		 bitmap->mddev->bitmap_info.max_write_behind);
+}
+
 static void bitmap_wait_behind_writes(struct mddev *mddev)
 {
 	struct bitmap *bitmap = mddev->bitmap;
@@ -2342,7 +2355,10 @@ static int bitmap_get_stats(void *data, struct md_bitmap_stats *stats)
 
 	if (!bitmap)
 		return -ENOENT;
-
+	if (bitmap->mddev->bitmap_info.external)
+		return -ENOENT;
+	if (!bitmap->storage.sb_page) /* no superblock */
+		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);
 	kunmap_local(sb);
@@ -2981,6 +2997,9 @@ static struct bitmap_operations bitmap_ops = {
 	.dirty_bits		= bitmap_dirty_bits,
 	.unplug			= bitmap_unplug,
 	.daemon_work		= bitmap_daemon_work,
+
+	.start_behind_write	= bitmap_start_behind_write,
+	.end_behind_write	= bitmap_end_behind_write,
 	.wait_behind_writes	= bitmap_wait_behind_writes,
 
 	.startwrite		= bitmap_startwrite,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 662e6fc141a7..31c93019c76b 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -84,12 +84,15 @@ struct bitmap_operations {
 			   unsigned long e);
 	void (*unplug)(struct mddev *mddev, bool sync);
 	void (*daemon_work)(struct mddev *mddev);
+
+	void (*start_behind_write)(struct mddev *mddev);
+	void (*end_behind_write)(struct mddev *mddev);
 	void (*wait_behind_writes)(struct mddev *mddev);
 
 	int (*startwrite)(struct mddev *mddev, sector_t offset,
-			  unsigned long sectors, bool behind);
+			  unsigned long sectors);
 	void (*endwrite)(struct mddev *mddev, sector_t offset,
-			 unsigned long sectors, bool success, bool behind);
+			 unsigned long sectors);
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 67108c397c5a..44c4c518430d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8376,6 +8376,10 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	spin_unlock(&all_mddevs_lock);
+
+	/* prevent bitmap to be freed after checking */
+	mutex_lock(&mddev->bitmap_info.mutex);
+
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : ", mdname(mddev));
@@ -8451,6 +8455,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
+	mutex_unlock(&mddev->bitmap_info.mutex);
 	spin_lock(&all_mddevs_lock);
 
 	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
@@ -8745,12 +8750,32 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
+static void md_bitmap_start(struct mddev *mddev,
+			    struct md_io_clone *md_io_clone)
+{
+	if (mddev->pers->bitmap_sector)
+		mddev->pers->bitmap_sector(mddev, &md_io_clone->offset,
+					   &md_io_clone->sectors);
+
+	mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
+				      md_io_clone->sectors);
+}
+
+static void md_bitmap_end(struct mddev *mddev, struct md_io_clone *md_io_clone)
+{
+	mddev->bitmap_ops->endwrite(mddev, md_io_clone->offset,
+				    md_io_clone->sectors);
+}
+
 static void md_end_clone_io(struct bio *bio)
 {
 	struct md_io_clone *md_io_clone = bio->bi_private;
 	struct bio *orig_bio = md_io_clone->orig_bio;
 	struct mddev *mddev = md_io_clone->mddev;
 
+	if (bio_data_dir(orig_bio) == WRITE && mddev->bitmap)
+		md_bitmap_end(mddev, md_io_clone);
+
 	if (bio->bi_status && !orig_bio->bi_status)
 		orig_bio->bi_status = bio->bi_status;
 
@@ -8775,6 +8800,12 @@ static void md_clone_bio(struct mddev *mddev, struct bio **bio)
 	if (blk_queue_io_stat(bdev->bd_disk->queue))
 		md_io_clone->start_time = bio_start_io_acct(*bio);
 
+	if (bio_data_dir(*bio) == WRITE && mddev->bitmap) {
+		md_io_clone->offset = (*bio)->bi_iter.bi_sector;
+		md_io_clone->sectors = bio_sectors(*bio);
+		md_bitmap_start(mddev, md_io_clone);
+	}
+
 	clone->bi_end_io = md_end_clone_io;
 	clone->bi_private = md_io_clone;
 	*bio = clone;
@@ -8793,6 +8824,9 @@ void md_free_cloned_bio(struct bio *bio)
 	struct bio *orig_bio = md_io_clone->orig_bio;
 	struct mddev *mddev = md_io_clone->mddev;
 
+	if (bio_data_dir(orig_bio) == WRITE && mddev->bitmap)
+		md_bitmap_end(mddev, md_io_clone);
+
 	if (bio->bi_status && !orig_bio->bi_status)
 		orig_bio->bi_status = bio->bi_status;
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 5d2e6bd58e4d..8826dce9717d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -746,6 +746,9 @@ struct md_personality
 	void *(*takeover) (struct mddev *mddev);
 	/* Changes the consistency policy of an active array. */
 	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
+	/* convert io ranges from array to bitmap */
+	void (*bitmap_sector)(struct mddev *mddev, sector_t *offset,
+			      unsigned long *sectors);
 };
 
 struct md_sysfs_entry {
@@ -828,6 +831,8 @@ struct md_io_clone {
 	struct mddev	*mddev;
 	struct bio	*orig_bio;
 	unsigned long	start_time;
+	sector_t	offset;
+	unsigned long	sectors;
 	struct bio	bio_clone;
 };
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6c9d24203f39..d83fe3b3abc0 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -420,10 +420,8 @@ static void close_write(struct r1bio *r1_bio)
 		r1_bio->behind_master_bio = NULL;
 	}
 
-	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors,
-				    !test_bit(R1BIO_Degraded, &r1_bio->state),
-				    test_bit(R1BIO_BehindIO, &r1_bio->state));
+	if (test_bit(R1BIO_BehindIO, &r1_bio->state))
+		mddev->bitmap_ops->end_behind_write(mddev);
 	md_write_end(mddev);
 }
 
@@ -480,8 +478,6 @@ static void raid1_end_write_request(struct bio *bio)
 		if (!test_bit(Faulty, &rdev->flags))
 			set_bit(R1BIO_WriteError, &r1_bio->state);
 		else {
-			/* Fail the request */
-			set_bit(R1BIO_Degraded, &r1_bio->state);
 			/* Finished with this branch */
 			r1_bio->bios[mirror] = NULL;
 			to_put = bio;
@@ -1492,11 +1488,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			break;
 		}
 		r1_bio->bios[i] = NULL;
-		if (!rdev || test_bit(Faulty, &rdev->flags)) {
-			if (i < conf->raid_disks)
-				set_bit(R1BIO_Degraded, &r1_bio->state);
+		if (!rdev || test_bit(Faulty, &rdev->flags))
 			continue;
-		}
 
 		atomic_inc(&rdev->nr_pending);
 		if (test_bit(WriteErrorSeen, &rdev->flags)) {
@@ -1522,16 +1515,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 					 */
 					max_sectors = bad_sectors;
 				rdev_dec_pending(rdev, mddev);
-				/* We don't set R1BIO_Degraded as that
-				 * only applies if the disk is
-				 * missing, so it might be re-added,
-				 * and we want to know to recover this
-				 * chunk.
-				 * In this case the device is here,
-				 * and the fact that this chunk is not
-				 * in-sync is recorded in the bad
-				 * block log
-				 */
 				continue;
 			}
 			if (is_bad) {
@@ -1611,9 +1594,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			    stats.behind_writes < max_write_behind)
 				alloc_behind_master_bio(r1_bio, bio);
 
-			mddev->bitmap_ops->startwrite(
-				mddev, r1_bio->sector, r1_bio->sectors,
-				test_bit(R1BIO_BehindIO, &r1_bio->state));
+			if (test_bit(R1BIO_BehindIO, &r1_bio->state))
+				mddev->bitmap_ops->start_behind_write(mddev);
 			first_clone = 0;
 		}
 
@@ -2567,12 +2549,10 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * errors.
 			 */
 			fail = true;
-			if (!narrow_write_error(r1_bio, m)) {
+			if (!narrow_write_error(r1_bio, m))
 				md_error(conf->mddev,
 					 conf->mirrors[m].rdev);
 				/* an I/O failed, we can't clear the bitmap */
-				set_bit(R1BIO_Degraded, &r1_bio->state);
-			}
 			rdev_dec_pending(conf->mirrors[m].rdev,
 					 conf->mddev);
 		}
@@ -2663,8 +2643,6 @@ static void raid1d(struct md_thread *thread)
 			list_del(&r1_bio->retry_list);
 			idx = sector_to_idx(r1_bio->sector);
 			atomic_dec(&conf->nr_queued[idx]);
-			if (mddev->degraded)
-				set_bit(R1BIO_Degraded, &r1_bio->state);
 			if (test_bit(R1BIO_WriteError, &r1_bio->state))
 				close_write(r1_bio);
 			raid_end_bio_io(r1_bio);
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 5300cbaa58a4..33f318fcc268 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -188,7 +188,6 @@ struct r1bio {
 enum r1bio_state {
 	R1BIO_Uptodate,
 	R1BIO_IsSync,
-	R1BIO_Degraded,
 	R1BIO_BehindIO,
 /* Set ReadError on bios that experience a readerror so that
  * raid1d knows what to do with them.
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 862b1fb71d86..daf42acc4fb6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -428,10 +428,6 @@ static void close_write(struct r10bio *r10_bio)
 {
 	struct mddev *mddev = r10_bio->mddev;
 
-	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				    !test_bit(R10BIO_Degraded, &r10_bio->state),
-				    false);
 	md_write_end(mddev);
 }
 
@@ -501,7 +497,6 @@ static void raid10_end_write_request(struct bio *bio)
 				set_bit(R10BIO_WriteError, &r10_bio->state);
 			else {
 				/* Fail the request */
-				set_bit(R10BIO_Degraded, &r10_bio->state);
 				r10_bio->devs[slot].bio = NULL;
 				to_put = bio;
 				dec_rdev = 1;
@@ -1430,10 +1425,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->devs[i].bio = NULL;
 		r10_bio->devs[i].repl_bio = NULL;
 
-		if (!rdev && !rrdev) {
-			set_bit(R10BIO_Degraded, &r10_bio->state);
+		if (!rdev && !rrdev)
 			continue;
-		}
 		if (rdev && test_bit(WriteErrorSeen, &rdev->flags)) {
 			sector_t first_bad;
 			sector_t dev_sector = r10_bio->devs[i].addr;
@@ -1450,14 +1443,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 					 * to other devices yet
 					 */
 					max_sectors = bad_sectors;
-				/* We don't set R10BIO_Degraded as that
-				 * only applies if the disk is missing,
-				 * so it might be re-added, and we want to
-				 * know to recover this chunk.
-				 * In this case the device is here, and the
-				 * fact that this chunk is not in-sync is
-				 * recorded in the bad block log.
-				 */
 				continue;
 			}
 			if (is_bad) {
@@ -1493,8 +1478,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	md_account_bio(mddev, &bio);
 	r10_bio->master_bio = bio;
 	atomic_set(&r10_bio->remaining, 1);
-	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				      false);
 
 	for (i = 0; i < conf->copies; i++) {
 		if (r10_bio->devs[i].bio)
@@ -2910,11 +2893,8 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				if (!narrow_write_error(r10_bio, m)) {
+				if (!narrow_write_error(r10_bio, m))
 					md_error(conf->mddev, rdev);
-					set_bit(R10BIO_Degraded,
-						&r10_bio->state);
-				}
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
@@ -2973,8 +2953,6 @@ static void raid10d(struct md_thread *thread)
 			r10_bio = list_first_entry(&tmp, struct r10bio,
 						   retry_list);
 			list_del(&r10_bio->retry_list);
-			if (mddev->degraded)
-				set_bit(R10BIO_Degraded, &r10_bio->state);
 
 			if (test_bit(R10BIO_WriteError,
 				     &r10_bio->state))
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 2e75e88d0802..3f16ad6904a9 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -161,7 +161,6 @@ enum r10bio_state {
 	R10BIO_IsSync,
 	R10BIO_IsRecover,
 	R10BIO_IsReshape,
-	R10BIO_Degraded,
 /* Set ReadError on bios that experience a read error
  * so that raid10d knows what to do with them.
  */
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index b4f7b79fd187..011246e16a99 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -313,10 +313,6 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
 		if (sh->dev[i].written) {
 			set_bit(R5_UPTODATE, &sh->dev[i].flags);
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
-			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state),
-					false);
 		}
 	}
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2fa1f270fb1d..39e7596e78c0 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -906,8 +906,7 @@ static bool stripe_can_batch(struct stripe_head *sh)
 	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return false;
 	return test_bit(STRIPE_BATCH_READY, &sh->state) &&
-		!test_bit(STRIPE_BITMAP_PENDING, &sh->state) &&
-		is_full_stripe_write(sh);
+	       is_full_stripe_write(sh);
 }
 
 /* we only do back search */
@@ -1345,8 +1344,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				submit_bio_noacct(rbi);
 		}
 		if (!rdev && !rrdev) {
-			if (op_is_write(op))
-				set_bit(STRIPE_DEGRADED, &sh->state);
 			pr_debug("skip op %d on disc %d for sector %llu\n",
 				bi->bi_opf, i, (unsigned long long)sh->sector);
 			clear_bit(R5_LOCKED, &sh->dev[i].flags);
@@ -2884,7 +2881,6 @@ static void raid5_end_write_request(struct bio *bi)
 			set_bit(R5_MadeGoodRepl, &sh->dev[i].flags);
 	} else {
 		if (bi->bi_status) {
-			set_bit(STRIPE_DEGRADED, &sh->state);
 			set_bit(WriteErrorSeen, &rdev->flags);
 			set_bit(R5_WriteError, &sh->dev[i].flags);
 			if (!test_and_set_bit(WantReplacement, &rdev->flags))
@@ -3548,29 +3544,9 @@ static void __add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 		 (*bip)->bi_iter.bi_sector, sh->sector, dd_idx,
 		 sh->dev[dd_idx].sector);
 
-	if (conf->mddev->bitmap && firstwrite) {
-		/* Cannot hold spinlock over bitmap_startwrite,
-		 * but must ensure this isn't added to a batch until
-		 * we have added to the bitmap and set bm_seq.
-		 * So set STRIPE_BITMAP_PENDING to prevent
-		 * batching.
-		 * If multiple __add_stripe_bio() calls race here they
-		 * much all set STRIPE_BITMAP_PENDING.  So only the first one
-		 * to complete "bitmap_startwrite" gets to set
-		 * STRIPE_BIT_DELAY.  This is important as once a stripe
-		 * is added to a batch, STRIPE_BIT_DELAY cannot be changed
-		 * any more.
-		 */
-		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
-		spin_unlock_irq(&sh->stripe_lock);
-		conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf), false);
-		spin_lock_irq(&sh->stripe_lock);
-		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
-		if (!sh->batch_head) {
-			sh->bm_seq = conf->seq_flush+1;
-			set_bit(STRIPE_BIT_DELAY, &sh->state);
-		}
+	if (conf->mddev->bitmap && firstwrite && !sh->batch_head) {
+		sh->bm_seq = conf->seq_flush+1;
+		set_bit(STRIPE_BIT_DELAY, &sh->state);
 	}
 }
 
@@ -3621,7 +3597,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 	BUG_ON(sh->batch_head);
 	for (i = disks; i--; ) {
 		struct bio *bi;
-		int bitmap_end = 0;
 
 		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
 			struct md_rdev *rdev = conf->disks[i].rdev;
@@ -3646,8 +3621,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		sh->dev[i].towrite = NULL;
 		sh->overwrite_disks = 0;
 		spin_unlock_irq(&sh->stripe_lock);
-		if (bi)
-			bitmap_end = 1;
 
 		log_stripe_write_finished(sh);
 
@@ -3662,11 +3635,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			bio_io_error(bi);
 			bi = nextbi;
 		}
-		if (bitmap_end)
-			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false, false);
-		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
 		sh->dev[i].written = NULL;
@@ -3675,7 +3643,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			sh->dev[i].page = sh->dev[i].orig_page;
 		}
 
-		if (bi) bitmap_end = 1;
 		while (bi && bi->bi_iter.bi_sector <
 		       sh->dev[i].sector + RAID5_STRIPE_SECTORS(conf)) {
 			struct bio *bi2 = r5_next_bio(conf, bi, sh->dev[i].sector);
@@ -3709,10 +3676,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 				bi = nextbi;
 			}
 		}
-		if (bitmap_end)
-			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false, false);
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -4061,10 +4024,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 					bio_endio(wbi);
 					wbi = wbi2;
 				}
-				conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state),
-					false);
+
 				if (head_sh->batch_head) {
 					sh = list_first_entry(&sh->batch_list,
 							      struct stripe_head,
@@ -4341,7 +4301,6 @@ static void handle_parity_checks5(struct r5conf *conf, struct stripe_head *sh,
 		s->locked++;
 		set_bit(R5_Wantwrite, &dev->flags);
 
-		clear_bit(STRIPE_DEGRADED, &sh->state);
 		set_bit(STRIPE_INSYNC, &sh->state);
 		break;
 	case check_state_run:
@@ -4498,7 +4457,6 @@ static void handle_parity_checks6(struct r5conf *conf, struct stripe_head *sh,
 			clear_bit(R5_Wantwrite, &dev->flags);
 			s->locked--;
 		}
-		clear_bit(STRIPE_DEGRADED, &sh->state);
 
 		set_bit(STRIPE_INSYNC, &sh->state);
 		break;
@@ -4892,8 +4850,7 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 					  (1 << STRIPE_COMPUTE_RUN)  |
 					  (1 << STRIPE_DISCARD) |
 					  (1 << STRIPE_BATCH_READY) |
-					  (1 << STRIPE_BATCH_ERR) |
-					  (1 << STRIPE_BITMAP_PENDING)),
+					  (1 << STRIPE_BATCH_ERR)),
 			"stripe state: %lx\n", sh->state);
 		WARN_ONCE(head_sh->state & ((1 << STRIPE_DISCARD) |
 					      (1 << STRIPE_REPLACED)),
@@ -4901,7 +4858,6 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 
 		set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
 					    (1 << STRIPE_PREREAD_ACTIVE) |
-					    (1 << STRIPE_DEGRADED) |
 					    (1 << STRIPE_ON_UNPLUG_LIST)),
 			      head_sh->state & (1 << STRIPE_INSYNC));
 
@@ -5785,10 +5741,6 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		}
 		spin_unlock_irq(&sh->stripe_lock);
 		if (conf->mddev->bitmap) {
-			for (d = 0; d < conf->raid_disks - conf->max_degraded;
-			     d++)
-				mddev->bitmap_ops->startwrite(mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf), false);
 			sh->bm_seq = conf->seq_flush + 1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}
@@ -5929,6 +5881,54 @@ static enum reshape_loc get_reshape_loc(struct mddev *mddev,
 	return LOC_BEHIND_RESHAPE;
 }
 
+static void raid5_bitmap_sector(struct mddev *mddev, sector_t *offset,
+				unsigned long *sectors)
+{
+	struct r5conf *conf = mddev->private;
+	sector_t start = *offset;
+	sector_t end = start + *sectors;
+	sector_t prev_start = start;
+	sector_t prev_end = end;
+	int sectors_per_chunk;
+	enum reshape_loc loc;
+	int dd_idx;
+
+	sectors_per_chunk = conf->chunk_sectors *
+		(conf->raid_disks - conf->max_degraded);
+	start = round_down(start, sectors_per_chunk);
+	end = round_up(end, sectors_per_chunk);
+
+	start = raid5_compute_sector(conf, start, 0, &dd_idx, NULL);
+	end = raid5_compute_sector(conf, end, 0, &dd_idx, NULL);
+
+	/*
+	 * For LOC_INSIDE_RESHAPE, this IO will wait for reshape to make
+	 * progress, hence it's the same as LOC_BEHIND_RESHAPE.
+	 */
+	loc = get_reshape_loc(mddev, conf, prev_start);
+	if (likely(loc != LOC_AHEAD_OF_RESHAPE)) {
+		*offset = start;
+		*sectors = end - start;
+		return;
+	}
+
+	sectors_per_chunk = conf->prev_chunk_sectors *
+		(conf->previous_raid_disks - conf->max_degraded);
+	prev_start = round_down(prev_start, sectors_per_chunk);
+	prev_end = round_down(prev_end, sectors_per_chunk);
+
+	prev_start = raid5_compute_sector(conf, prev_start, 1, &dd_idx, NULL);
+	prev_end = raid5_compute_sector(conf, prev_end, 1, &dd_idx, NULL);
+
+	/*
+	 * for LOC_AHEAD_OF_RESHAPE, reshape can make progress before this IO
+	 * is handled in make_stripe_request(), we can't know this here hence
+	 * we set bits for both.
+	 */
+	*offset = min(start, prev_start);
+	*sectors = max(end, prev_end) - *offset;
+}
+
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
 		sector_t logical_sector, struct bio *bi)
@@ -8977,6 +8977,7 @@ static struct md_personality raid6_personality =
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
 	.prepare_suspend = raid5_prepare_suspend,
+	.bitmap_sector	= raid5_bitmap_sector,
 };
 static struct md_personality raid5_personality =
 {
@@ -9002,6 +9003,7 @@ static struct md_personality raid5_personality =
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
 	.prepare_suspend = raid5_prepare_suspend,
+	.bitmap_sector	= raid5_bitmap_sector,
 };
 
 static struct md_personality raid4_personality =
@@ -9028,6 +9030,7 @@ static struct md_personality raid4_personality =
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
 	.prepare_suspend = raid5_prepare_suspend,
+	.bitmap_sector	= raid5_bitmap_sector,
 };
 
 static int __init raid5_init(void)
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 896ecfc4afa6..2e42c1641049 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -358,7 +358,6 @@ enum {
 	STRIPE_REPLACED,
 	STRIPE_PREREAD_ACTIVE,
 	STRIPE_DELAYED,
-	STRIPE_DEGRADED,
 	STRIPE_BIT_DELAY,
 	STRIPE_EXPANDING,
 	STRIPE_EXPAND_SOURCE,
@@ -372,9 +371,6 @@ enum {
 	STRIPE_ON_RELEASE_LIST,
 	STRIPE_BATCH_READY,
 	STRIPE_BATCH_ERR,
-	STRIPE_BITMAP_PENDING,	/* Being added to bitmap, don't add
-				 * to batch yet.
-				 */
 	STRIPE_LOG_TRAPPED,	/* trapped into log (see raid5-cache.c)
 				 * this bit is used in two scenarios:
 				 *
diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 458905dfb3e1..a87a265cd839 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -269,7 +269,6 @@ static const struct cci_reg_sequence imx290_global_init_settings[] = {
 	{ IMX290_WINWV, 1097 },
 	{ IMX290_XSOUTSEL, IMX290_XSOUTSEL_XVSOUTSEL_VSYNC |
 			   IMX290_XSOUTSEL_XHSOUTSEL_HSYNC },
-	{ CCI_REG8(0x3011), 0x02 },
 	{ CCI_REG8(0x3012), 0x64 },
 	{ CCI_REG8(0x3013), 0x00 },
 };
@@ -277,6 +276,7 @@ static const struct cci_reg_sequence imx290_global_init_settings[] = {
 static const struct cci_reg_sequence imx290_global_init_settings_290[] = {
 	{ CCI_REG8(0x300f), 0x00 },
 	{ CCI_REG8(0x3010), 0x21 },
+	{ CCI_REG8(0x3011), 0x00 },
 	{ CCI_REG8(0x3016), 0x09 },
 	{ CCI_REG8(0x3070), 0x02 },
 	{ CCI_REG8(0x3071), 0x11 },
@@ -330,6 +330,7 @@ static const struct cci_reg_sequence xclk_regs[][IMX290_NUM_CLK_REGS] = {
 };
 
 static const struct cci_reg_sequence imx290_global_init_settings_327[] = {
+	{ CCI_REG8(0x3011), 0x02 },
 	{ CCI_REG8(0x309e), 0x4A },
 	{ CCI_REG8(0x309f), 0x4A },
 	{ CCI_REG8(0x313b), 0x61 },
diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index 0bfe3046fcc8..c74097a59c42 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -547,7 +547,7 @@ static int imx412_update_exp_gain(struct imx412 *imx412, u32 exposure, u32 gain)
 
 	lpfr = imx412->vblank + imx412->cur_mode->height;
 
-	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u",
+	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u\n",
 		exposure, gain, lpfr);
 
 	ret = imx412_write_reg(imx412, IMX412_REG_HOLD, 1, 1);
@@ -594,7 +594,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_VBLANK:
 		imx412->vblank = imx412->vblank_ctrl->val;
 
-		dev_dbg(imx412->dev, "Received vblank %u, new lpfr %u",
+		dev_dbg(imx412->dev, "Received vblank %u, new lpfr %u\n",
 			imx412->vblank,
 			imx412->vblank + imx412->cur_mode->height);
 
@@ -613,7 +613,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
 		exposure = ctrl->val;
 		analog_gain = imx412->again_ctrl->val;
 
-		dev_dbg(imx412->dev, "Received exp %u, analog gain %u",
+		dev_dbg(imx412->dev, "Received exp %u, analog gain %u\n",
 			exposure, analog_gain);
 
 		ret = imx412_update_exp_gain(imx412, exposure, analog_gain);
@@ -622,7 +622,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		break;
 	default:
-		dev_err(imx412->dev, "Invalid control %d", ctrl->id);
+		dev_err(imx412->dev, "Invalid control %d\n", ctrl->id);
 		ret = -EINVAL;
 	}
 
@@ -803,14 +803,14 @@ static int imx412_start_streaming(struct imx412 *imx412)
 	ret = imx412_write_regs(imx412, reg_list->regs,
 				reg_list->num_of_regs);
 	if (ret) {
-		dev_err(imx412->dev, "fail to write initial registers");
+		dev_err(imx412->dev, "fail to write initial registers\n");
 		return ret;
 	}
 
 	/* Setup handler will write actual exposure and gain */
 	ret =  __v4l2_ctrl_handler_setup(imx412->sd.ctrl_handler);
 	if (ret) {
-		dev_err(imx412->dev, "fail to setup handler");
+		dev_err(imx412->dev, "fail to setup handler\n");
 		return ret;
 	}
 
@@ -821,7 +821,7 @@ static int imx412_start_streaming(struct imx412 *imx412)
 	ret = imx412_write_reg(imx412, IMX412_REG_MODE_SELECT,
 			       1, IMX412_MODE_STREAMING);
 	if (ret) {
-		dev_err(imx412->dev, "fail to start streaming");
+		dev_err(imx412->dev, "fail to start streaming\n");
 		return ret;
 	}
 
@@ -895,7 +895,7 @@ static int imx412_detect(struct imx412 *imx412)
 		return ret;
 
 	if (val != IMX412_ID) {
-		dev_err(imx412->dev, "chip id mismatch: %x!=%x",
+		dev_err(imx412->dev, "chip id mismatch: %x!=%x\n",
 			IMX412_ID, val);
 		return -ENXIO;
 	}
@@ -927,7 +927,7 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
 	imx412->reset_gpio = devm_gpiod_get_optional(imx412->dev, "reset",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(imx412->reset_gpio)) {
-		dev_err(imx412->dev, "failed to get reset gpio %ld",
+		dev_err(imx412->dev, "failed to get reset gpio %ld\n",
 			PTR_ERR(imx412->reset_gpio));
 		return PTR_ERR(imx412->reset_gpio);
 	}
@@ -935,13 +935,13 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
 	/* Get sensor input clock */
 	imx412->inclk = devm_clk_get(imx412->dev, NULL);
 	if (IS_ERR(imx412->inclk)) {
-		dev_err(imx412->dev, "could not get inclk");
+		dev_err(imx412->dev, "could not get inclk\n");
 		return PTR_ERR(imx412->inclk);
 	}
 
 	rate = clk_get_rate(imx412->inclk);
 	if (rate != IMX412_INCLK_RATE) {
-		dev_err(imx412->dev, "inclk frequency mismatch");
+		dev_err(imx412->dev, "inclk frequency mismatch\n");
 		return -EINVAL;
 	}
 
@@ -966,14 +966,14 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
 
 	if (bus_cfg.bus.mipi_csi2.num_data_lanes != IMX412_NUM_DATA_LANES) {
 		dev_err(imx412->dev,
-			"number of CSI2 data lanes %d is not supported",
+			"number of CSI2 data lanes %d is not supported\n",
 			bus_cfg.bus.mipi_csi2.num_data_lanes);
 		ret = -EINVAL;
 		goto done_endpoint_free;
 	}
 
 	if (!bus_cfg.nr_of_link_frequencies) {
-		dev_err(imx412->dev, "no link frequencies defined");
+		dev_err(imx412->dev, "no link frequencies defined\n");
 		ret = -EINVAL;
 		goto done_endpoint_free;
 	}
@@ -1034,7 +1034,7 @@ static int imx412_power_on(struct device *dev)
 
 	ret = clk_prepare_enable(imx412->inclk);
 	if (ret) {
-		dev_err(imx412->dev, "fail to enable inclk");
+		dev_err(imx412->dev, "fail to enable inclk\n");
 		goto error_reset;
 	}
 
@@ -1145,7 +1145,7 @@ static int imx412_init_controls(struct imx412 *imx412)
 		imx412->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	if (ctrl_hdlr->error) {
-		dev_err(imx412->dev, "control init failed: %d",
+		dev_err(imx412->dev, "control init failed: %d\n",
 			ctrl_hdlr->error);
 		v4l2_ctrl_handler_free(ctrl_hdlr);
 		return ctrl_hdlr->error;
@@ -1183,7 +1183,7 @@ static int imx412_probe(struct i2c_client *client)
 
 	ret = imx412_parse_hw_config(imx412);
 	if (ret) {
-		dev_err(imx412->dev, "HW configuration is not supported");
+		dev_err(imx412->dev, "HW configuration is not supported\n");
 		return ret;
 	}
 
@@ -1191,14 +1191,14 @@ static int imx412_probe(struct i2c_client *client)
 
 	ret = imx412_power_on(imx412->dev);
 	if (ret) {
-		dev_err(imx412->dev, "failed to power-on the sensor");
+		dev_err(imx412->dev, "failed to power-on the sensor\n");
 		goto error_mutex_destroy;
 	}
 
 	/* Check module identity */
 	ret = imx412_detect(imx412);
 	if (ret) {
-		dev_err(imx412->dev, "failed to find sensor: %d", ret);
+		dev_err(imx412->dev, "failed to find sensor: %d\n", ret);
 		goto error_power_off;
 	}
 
@@ -1208,7 +1208,7 @@ static int imx412_probe(struct i2c_client *client)
 
 	ret = imx412_init_controls(imx412);
 	if (ret) {
-		dev_err(imx412->dev, "failed to init controls: %d", ret);
+		dev_err(imx412->dev, "failed to init controls: %d\n", ret);
 		goto error_power_off;
 	}
 
@@ -1222,14 +1222,14 @@ static int imx412_probe(struct i2c_client *client)
 	imx412->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&imx412->sd.entity, 1, &imx412->pad);
 	if (ret) {
-		dev_err(imx412->dev, "failed to init entity pads: %d", ret);
+		dev_err(imx412->dev, "failed to init entity pads: %d\n", ret);
 		goto error_handler_free;
 	}
 
 	ret = v4l2_async_register_subdev_sensor(&imx412->sd);
 	if (ret < 0) {
 		dev_err(imx412->dev,
-			"failed to register async subdev: %d", ret);
+			"failed to register async subdev: %d\n", ret);
 		goto error_media_entity;
 	}
 
diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 9f52af6f047f..87e5d7ce5a47 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -40,7 +40,7 @@
 /* Exposure control */
 #define OV9282_REG_EXPOSURE	0x3500
 #define OV9282_EXPOSURE_MIN	1
-#define OV9282_EXPOSURE_OFFSET	12
+#define OV9282_EXPOSURE_OFFSET	25
 #define OV9282_EXPOSURE_STEP	1
 #define OV9282_EXPOSURE_DEFAULT	0x0282
 
diff --git a/drivers/media/platform/marvell/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
index c81593c969e0..a62c3a484cb3 100644
--- a/drivers/media/platform/marvell/mcam-core.c
+++ b/drivers/media/platform/marvell/mcam-core.c
@@ -935,7 +935,12 @@ static int mclk_enable(struct clk_hw *hw)
 	ret = pm_runtime_resume_and_get(cam->dev);
 	if (ret < 0)
 		return ret;
-	clk_enable(cam->clk[0]);
+	ret = clk_enable(cam->clk[0]);
+	if (ret) {
+		pm_runtime_put(cam->dev);
+		return ret;
+	}
+
 	mcam_reg_write(cam, REG_CLKCTRL, (mclk_src << 29) | mclk_div);
 	mcam_ctlr_power_up(cam);
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 1bf85c1cf964..b8c9bb017fb5 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2679,11 +2679,12 @@ static void mxc_jpeg_detach_pm_domains(struct mxc_jpeg_dev *jpeg)
 	int i;
 
 	for (i = 0; i < jpeg->num_domains; i++) {
-		if (jpeg->pd_dev[i] && !pm_runtime_suspended(jpeg->pd_dev[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_dev[i]) &&
+		    !pm_runtime_suspended(jpeg->pd_dev[i]))
 			pm_runtime_force_suspend(jpeg->pd_dev[i]);
-		if (jpeg->pd_link[i] && !IS_ERR(jpeg->pd_link[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_link[i]))
 			device_link_del(jpeg->pd_link[i]);
-		if (jpeg->pd_dev[i] && !IS_ERR(jpeg->pd_dev[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_dev[i]))
 			dev_pm_domain_detach(jpeg->pd_dev[i], true);
 		jpeg->pd_dev[i] = NULL;
 		jpeg->pd_link[i] = NULL;
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
index 4091f1c0e78b..a71eb30323c8 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
@@ -861,6 +861,7 @@ int mxc_isi_video_buffer_prepare(struct mxc_isi_dev *isi, struct vb2_buffer *vb2
 				 const struct mxc_isi_format_info *info,
 				 const struct v4l2_pix_format_mplane *pix)
 {
+	struct vb2_v4l2_buffer *v4l2_buf = to_vb2_v4l2_buffer(vb2);
 	unsigned int i;
 
 	for (i = 0; i < info->mem_planes; i++) {
@@ -875,6 +876,8 @@ int mxc_isi_video_buffer_prepare(struct mxc_isi_dev *isi, struct vb2_buffer *vb2
 		vb2_set_plane_payload(vb2, i, size);
 	}
 
+	v4l2_buf->field = pix->field;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/samsung/exynos4-is/mipi-csis.c b/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
index 4b9b20ba3504..38c5f22b850b 100644
--- a/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
@@ -940,13 +940,19 @@ static int s5pcsis_pm_resume(struct device *dev, bool runtime)
 					       state->supplies);
 			goto unlock;
 		}
-		clk_enable(state->clock[CSIS_CLK_GATE]);
+		ret = clk_enable(state->clock[CSIS_CLK_GATE]);
+		if (ret) {
+			phy_power_off(state->phy);
+			regulator_bulk_disable(CSIS_NUM_SUPPLIES,
+					       state->supplies);
+			goto unlock;
+		}
 	}
 	if (state->flags & ST_STREAMING)
 		s5pcsis_start_stream(state);
 
 	state->flags &= ~ST_SUSPENDED;
- unlock:
+unlock:
 	mutex_unlock(&state->lock);
 	return ret ? -EAGAIN : 0;
 }
diff --git a/drivers/media/platform/samsung/s3c-camif/camif-core.c b/drivers/media/platform/samsung/s3c-camif/camif-core.c
index e4529f666e20..8c597dd01713 100644
--- a/drivers/media/platform/samsung/s3c-camif/camif-core.c
+++ b/drivers/media/platform/samsung/s3c-camif/camif-core.c
@@ -527,10 +527,19 @@ static void s3c_camif_remove(struct platform_device *pdev)
 static int s3c_camif_runtime_resume(struct device *dev)
 {
 	struct camif_dev *camif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(camif->clock[CLK_GATE]);
+	if (ret)
+		return ret;
 
-	clk_enable(camif->clock[CLK_GATE]);
 	/* null op on s3c244x */
-	clk_enable(camif->clock[CLK_CAM]);
+	ret = clk_enable(camif->clock[CLK_CAM]);
+	if (ret) {
+		clk_disable(camif->clock[CLK_GATE]);
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/media/rc/iguanair.c b/drivers/media/rc/iguanair.c
index 276bf3c8a8cb..8af94246e591 100644
--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -194,8 +194,10 @@ static int iguanair_send(struct iguanair *ir, unsigned size)
 	if (rc)
 		return rc;
 
-	if (wait_for_completion_timeout(&ir->completion, TIMEOUT) == 0)
+	if (wait_for_completion_timeout(&ir->completion, TIMEOUT) == 0) {
+		usb_kill_urb(ir->urb_out);
 		return -ETIMEDOUT;
+	}
 
 	return rc;
 }
diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 0d2c42819d39..218f712f56b1 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -322,13 +322,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			/* demod access via firmware interface */
+			u32 reg;
+
 			if (msg[0].len < 3 || msg[1].len < 1) {
 				ret = -EOPNOTSUPP;
 				goto unlock;
 			}
-			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
-					msg[0].buf[2];
+
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+				msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
@@ -385,13 +388,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			/* demod access via firmware interface */
+			u32 reg;
+
 			if (msg[0].len < 3) {
 				ret = -EOPNOTSUPP;
 				goto unlock;
 			}
-			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
-					msg[0].buf[2];
+
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+				msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
index 8a34e6c0d6a6..f0537b741d13 100644
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -373,6 +373,7 @@ static int lme2510_int_read(struct dvb_usb_adapter *adap)
 	struct dvb_usb_device *d = adap_to_d(adap);
 	struct lme2510_state *lme_int = adap_to_priv(adap);
 	struct usb_host_endpoint *ep;
+	int ret;
 
 	lme_int->lme_urb = usb_alloc_urb(0, GFP_KERNEL);
 
@@ -390,11 +391,20 @@ static int lme2510_int_read(struct dvb_usb_adapter *adap)
 
 	/* Quirk of pipe reporting PIPE_BULK but behaves as interrupt */
 	ep = usb_pipe_endpoint(d->udev, lme_int->lme_urb->pipe);
+	if (!ep) {
+		usb_free_urb(lme_int->lme_urb);
+		return -ENODEV;
+	}
 
 	if (usb_endpoint_type(&ep->desc) == USB_ENDPOINT_XFER_BULK)
 		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa);
 
-	usb_submit_urb(lme_int->lme_urb, GFP_KERNEL);
+	ret = usb_submit_urb(lme_int->lme_urb, GFP_KERNEL);
+	if (ret) {
+		usb_free_urb(lme_int->lme_urb);
+		return ret;
+	}
+
 	info("INT Interrupt Service Started");
 
 	return 0;
diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 16fa17bbd15e..83ed7821fa2a 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -483,7 +483,8 @@ static void uvc_queue_buffer_complete(struct kref *ref)
 
 	buf->state = buf->error ? UVC_BUF_STATE_ERROR : UVC_BUF_STATE_DONE;
 	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, buf->bytesused);
-	vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_DONE);
+	vb2_buffer_done(&buf->buf.vb2_buf, buf->error ? VB2_BUF_STATE_ERROR :
+							VB2_BUF_STATE_DONE);
 }
 
 /*
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index a78a88c710e2..b5f6682ff383 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -269,6 +269,7 @@ int uvc_status_init(struct uvc_device *dev)
 	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->int_urb) {
 		kfree(dev->status);
+		dev->status = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 7193f848d17e..9b7d30a21a5b 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -474,14 +474,15 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 
 	ram_code = tegra_read_ram_code();
 
-	for (np = of_find_node_by_name(dev->of_node, "emc-tables"); np;
-	     np = of_find_node_by_name(np, "emc-tables")) {
+	for_each_child_of_node(dev->of_node, np) {
+		if (!of_node_name_eq(np, "emc-tables"))
+			continue;
 		err = of_property_read_u32(np, "nvidia,ram-code", &value);
 		if (err || value != ram_code) {
 			struct device_node *lpddr2_np;
 			bool cfg_mismatches = false;
 
-			lpddr2_np = of_find_node_by_name(np, "lpddr2");
+			lpddr2_np = of_get_child_by_name(np, "lpddr2");
 			if (lpddr2_np) {
 				const struct lpddr2_info *info;
 
@@ -518,7 +519,6 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 			}
 
 			if (cfg_mismatches) {
-				of_node_put(np);
 				continue;
 			}
 		}
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 2ce15f60eb10..729e79e1be49 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -27,7 +28,7 @@
 
 static struct platform_driver syscon_driver;
 
-static DEFINE_SPINLOCK(syscon_list_slock);
+static DEFINE_MUTEX(syscon_list_lock);
 static LIST_HEAD(syscon_list);
 
 struct syscon {
@@ -54,6 +55,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	struct resource res;
 	struct reset_control *reset;
 
+	WARN_ON(!mutex_is_locked(&syscon_list_lock));
+
 	struct syscon *syscon __free(kfree) = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
@@ -144,9 +147,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	syscon->regmap = regmap;
 	syscon->np = np;
 
-	spin_lock(&syscon_list_slock);
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
 
 	return_ptr(syscon);
 
@@ -167,7 +168,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 {
 	struct syscon *entry, *syscon = NULL;
 
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -175,11 +176,11 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	spin_unlock(&syscon_list_slock);
-
 	if (!syscon)
 		syscon = of_syscon_register(np, check_res);
 
+	mutex_unlock(&syscon_list_lock);
+
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
 
@@ -210,7 +211,7 @@ int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
 		return -ENOMEM;
 
 	/* check if syscon entry already exists */
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -223,12 +224,12 @@ int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
 
 	/* register the regmap in syscon list */
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
+	mutex_unlock(&syscon_list_lock);
 
 	return 0;
 
 err_unlock:
-	spin_unlock(&syscon_list_slock);
+	mutex_unlock(&syscon_list_lock);
 	kfree(syscon);
 	return ret;
 }
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index f150d8769f19..285a748748d7 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,6 +286,7 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_ucr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
+	u8 interrupt_val = 0;
 	u16 *buf;
 
 	if (!status)
@@ -308,6 +309,20 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
 	}
 
+	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
+	/* Cross check presence with interrupts */
+	if (*status & XD_CD)
+		if (!(interrupt_val & XD_INT))
+			*status &= ~XD_CD;
+
+	if (*status & SD_CD)
+		if (!(interrupt_val & SD_INT))
+			*status &= ~SD_CD;
+
+	if (*status & MS_CD)
+		if (!(interrupt_val & MS_INT))
+			*status &= ~MS_CD;
+
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;
diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index dbe3eb361cca..4b6cbee23fe8 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -174,26 +174,30 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 	priv->hbdev.np = of_get_next_child(np, NULL);
 	ret = of_address_to_resource(priv->hbdev.np, 0, &res);
 	if (ret)
-		return ret;
+		goto put_node;
 
 	if (of_property_read_bool(dev->of_node, "mux-controls")) {
 		struct mux_control *control = devm_mux_control_get(dev, NULL);
 
-		if (IS_ERR(control))
-			return PTR_ERR(control);
+		if (IS_ERR(control)) {
+			ret = PTR_ERR(control);
+			goto put_node;
+		}
 
 		ret = mux_control_select(control, 1);
 		if (ret) {
 			dev_err(dev, "Failed to select HBMC mux\n");
-			return ret;
+			goto put_node;
 		}
 		priv->mux_ctrl = control;
 	}
 
 	priv->hbdev.map.size = resource_size(&res);
 	priv->hbdev.map.virt = devm_ioremap_resource(dev, &res);
-	if (IS_ERR(priv->hbdev.map.virt))
-		return PTR_ERR(priv->hbdev.map.virt);
+	if (IS_ERR(priv->hbdev.map.virt)) {
+		ret = PTR_ERR(priv->hbdev.map.virt);
+		goto disable_mux;
+	}
 
 	priv->ctlr.dev = dev;
 	priv->ctlr.ops = &am654_hbmc_ops;
@@ -226,6 +230,8 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 disable_mux:
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
+put_node:
+	of_node_put(priv->hbdev.np);
 	return ret;
 }
 
@@ -241,6 +247,7 @@ static void am654_hbmc_remove(struct platform_device *pdev)
 
 	if (dev_priv->rx_chan)
 		dma_release_channel(dev_priv->rx_chan);
+	of_node_put(priv->hbdev.np);
 }
 
 static const struct of_device_id am654_hbmc_dt_ids[] = {
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 1b2ec0fec60c..e76df6a00ed4 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2342,6 +2342,11 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 		brcmnand_send_cmd(host, CMD_PROGRAM_PAGE);
 		status = brcmnand_waitfunc(chip);
 
+		if (status < 0) {
+			ret = status;
+			goto out;
+		}
+
 		if (status & NAND_STATUS_FAIL) {
 			dev_info(ctrl->dev, "program failed at %llx\n",
 				(unsigned long long)addr);
diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index d73ef262991d..6fee9a41839c 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -328,8 +328,7 @@
 #define BGMAC_RX_FRAME_OFFSET			30		/* There are 2 unused bytes between header and real data */
 #define BGMAC_RX_BUF_OFFSET			(NET_SKB_PAD + NET_IP_ALIGN - \
 						 BGMAC_RX_FRAME_OFFSET)
-/* Jumbo frame size with FCS */
-#define BGMAC_RX_MAX_FRAME_SIZE			9724
+#define BGMAC_RX_MAX_FRAME_SIZE			1536
 #define BGMAC_RX_BUF_SIZE			(BGMAC_RX_FRAME_OFFSET + BGMAC_RX_MAX_FRAME_SIZE)
 #define BGMAC_RX_ALLOC_SIZE			(SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) + \
 						 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 150cc94ae9f8..25a604379b2f 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1777,10 +1777,11 @@ static void dm9000_drv_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 	dm9000_release_board(pdev, dm);
-	free_netdev(ndev);		/* free device structure */
 	if (dm->power_supply)
 		regulator_disable(dm->power_supply);
 
+	free_netdev(ndev);		/* free device structure */
+
 	dev_dbg(&pdev->dev, "released and freed device\n");
 }
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 49d1748e0c04..2b05d9c6c21a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -840,6 +840,8 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int hdr_len, total_len, data_left;
 	struct bufdesc *bdp = txq->bd.cur;
+	struct bufdesc *tmp_bdp;
+	struct bufdesc_ex *ebdp;
 	struct tso_t tso;
 	unsigned int index = 0;
 	int ret;
@@ -913,7 +915,34 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	return 0;
 
 err_release:
-	/* TODO: Release all used data descriptors for TSO */
+	/* Release all used data descriptors for TSO */
+	tmp_bdp = txq->bd.cur;
+
+	while (tmp_bdp != bdp) {
+		/* Unmap data buffers */
+		if (tmp_bdp->cbd_bufaddr &&
+		    !IS_TSO_HEADER(txq, fec32_to_cpu(tmp_bdp->cbd_bufaddr)))
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(tmp_bdp->cbd_bufaddr),
+					 fec16_to_cpu(tmp_bdp->cbd_datlen),
+					 DMA_TO_DEVICE);
+
+		/* Clear standard buffer descriptor fields */
+		tmp_bdp->cbd_sc = 0;
+		tmp_bdp->cbd_datlen = 0;
+		tmp_bdp->cbd_bufaddr = 0;
+
+		/* Handle extended descriptor if enabled */
+		if (fep->bufdesc_ex) {
+			ebdp = (struct bufdesc_ex *)tmp_bdp;
+			ebdp->cbd_esc = 0;
+		}
+
+		tmp_bdp = fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
+	}
+
+	dev_kfree_skb_any(skb);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 9a63fbc69408..b25fb400f476 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -40,6 +40,21 @@ EXPORT_SYMBOL(hnae3_unregister_ae_algo_prepare);
  */
 static DEFINE_MUTEX(hnae3_common_lock);
 
+/* ensure the drivers being unloaded one by one */
+static DEFINE_MUTEX(hnae3_unload_lock);
+
+void hnae3_acquire_unload_lock(void)
+{
+	mutex_lock(&hnae3_unload_lock);
+}
+EXPORT_SYMBOL(hnae3_acquire_unload_lock);
+
+void hnae3_release_unload_lock(void)
+{
+	mutex_unlock(&hnae3_unload_lock);
+}
+EXPORT_SYMBOL(hnae3_release_unload_lock);
+
 static bool hnae3_client_match(enum hnae3_client_type client_type)
 {
 	if (client_type == HNAE3_CLIENT_KNIC ||
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index d873523e84f2..388c70331a55 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -963,4 +963,6 @@ int hnae3_register_client(struct hnae3_client *client);
 void hnae3_set_client_init_flag(struct hnae3_client *client,
 				struct hnae3_ae_dev *ae_dev,
 				unsigned int inited);
+void hnae3_acquire_unload_lock(void);
+void hnae3_release_unload_lock(void);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 73825b6bd485..dc60ac3bde7f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -6002,9 +6002,11 @@ module_init(hns3_init_module);
  */
 static void __exit hns3_exit_module(void)
 {
+	hnae3_acquire_unload_lock();
 	pci_unregister_driver(&hns3_driver);
 	hnae3_unregister_client(&client);
 	hns3_dbg_unregister_debugfs();
+	hnae3_release_unload_lock();
 }
 module_exit(hns3_exit_module);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9a67fe0554a5..06eedf80cfac 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12929,9 +12929,11 @@ static int __init hclge_init(void)
 
 static void __exit hclge_exit(void)
 {
+	hnae3_acquire_unload_lock();
 	hnae3_unregister_ae_algo_prepare(&ae_algo);
 	hnae3_unregister_ae_algo(&ae_algo);
 	destroy_workqueue(hclge_wq);
+	hnae3_release_unload_lock();
 }
 module_init(hclge_init);
 module_exit(hclge_exit);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index d47bd8d6145f..fd5992164846 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3412,8 +3412,10 @@ static int __init hclgevf_init(void)
 
 static void __exit hclgevf_exit(void)
 {
+	hnae3_acquire_unload_lock();
 	hnae3_unregister_ae_algo(&ae_algovf);
 	destroy_workqueue(hclgevf_wq);
+	hnae3_release_unload_lock();
 }
 module_init(hclgevf_init);
 module_exit(hclgevf_exit);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f782402cd789..5516795cc250 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -773,6 +773,11 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		f->state = IAVF_VLAN_ADD;
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
+	} else if (f->state == IAVF_VLAN_REMOVE) {
+		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
+		 * We can safely only change the state here.
+		 */
+		f->state = IAVF_VLAN_ACTIVE;
 	}
 
 clearout:
@@ -793,8 +798,18 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
-		f->state = IAVF_VLAN_REMOVE;
-		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
+		/* IAVF_ADD_VLAN means that VLAN wasn't even added yet.
+		 * Remove it from the list.
+		 */
+		if (f->state == IAVF_VLAN_ADD) {
+			list_del(&f->list);
+			kfree(f);
+			adapter->num_vlan_filters--;
+		} else {
+			f->state = IAVF_VLAN_REMOVE;
+			iavf_schedule_aq_request(adapter,
+						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
+		}
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 80f3dfd27124..66ae0352c6bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1491,7 +1491,23 @@ struct ice_aqc_dnl_equa_param {
 #define ICE_AQC_RX_EQU_POST1 (0x12 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
-#define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINHF (0x20 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINLF (0x21 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINDC (0x22 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_BW (0x23 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_GAIN (0x30 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_GAIN2 (0x31 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_2 (0x32 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_3 (0x33 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_4 (0x34 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_5 (0x35 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_6 (0x36 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_7 (0x37 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_8 (0x38 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_9 (0x39 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_10 (0x3A << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_11 (0x3B << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_12 (0x3C << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_TX_EQU_PRE1 0x0
 #define ICE_AQC_TX_EQU_PRE3 0x3
 #define ICE_AQC_TX_EQU_ATTEN 0x4
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d5cc934d1359..7d1feeb317be 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -693,75 +693,52 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
 static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
 			      struct ice_serdes_equalization_to_ethtool *ptr)
 {
+	static const int tx = ICE_AQC_OP_CODE_TX_EQU;
+	static const int rx = ICE_AQC_OP_CODE_RX_EQU;
+	struct {
+		int data_in;
+		int opcode;
+		int *out;
+	} aq_params[] = {
+		{ ICE_AQC_TX_EQU_PRE1, tx, &ptr->tx_equ_pre1 },
+		{ ICE_AQC_TX_EQU_PRE3, tx, &ptr->tx_equ_pre3 },
+		{ ICE_AQC_TX_EQU_ATTEN, tx, &ptr->tx_equ_atten },
+		{ ICE_AQC_TX_EQU_POST1, tx, &ptr->tx_equ_post1 },
+		{ ICE_AQC_TX_EQU_PRE2, tx, &ptr->tx_equ_pre2 },
+		{ ICE_AQC_RX_EQU_PRE2, rx, &ptr->rx_equ_pre2 },
+		{ ICE_AQC_RX_EQU_PRE1, rx, &ptr->rx_equ_pre1 },
+		{ ICE_AQC_RX_EQU_POST1, rx, &ptr->rx_equ_post1 },
+		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
+		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINHF, rx, &ptr->rx_equ_ctle_gainhf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINLF, rx, &ptr->rx_equ_ctle_gainlf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINDC, rx, &ptr->rx_equ_ctle_gaindc },
+		{ ICE_AQC_RX_EQU_CTLE_BW, rx, &ptr->rx_equ_ctle_bw },
+		{ ICE_AQC_RX_EQU_DFE_GAIN, rx, &ptr->rx_equ_dfe_gain },
+		{ ICE_AQC_RX_EQU_DFE_GAIN2, rx, &ptr->rx_equ_dfe_gain_2 },
+		{ ICE_AQC_RX_EQU_DFE_2, rx, &ptr->rx_equ_dfe_2 },
+		{ ICE_AQC_RX_EQU_DFE_3, rx, &ptr->rx_equ_dfe_3 },
+		{ ICE_AQC_RX_EQU_DFE_4, rx, &ptr->rx_equ_dfe_4 },
+		{ ICE_AQC_RX_EQU_DFE_5, rx, &ptr->rx_equ_dfe_5 },
+		{ ICE_AQC_RX_EQU_DFE_6, rx, &ptr->rx_equ_dfe_6 },
+		{ ICE_AQC_RX_EQU_DFE_7, rx, &ptr->rx_equ_dfe_7 },
+		{ ICE_AQC_RX_EQU_DFE_8, rx, &ptr->rx_equ_dfe_8 },
+		{ ICE_AQC_RX_EQU_DFE_9, rx, &ptr->rx_equ_dfe_9 },
+		{ ICE_AQC_RX_EQU_DFE_10, rx, &ptr->rx_equ_dfe_10 },
+		{ ICE_AQC_RX_EQU_DFE_11, rx, &ptr->rx_equ_dfe_11 },
+		{ ICE_AQC_RX_EQU_DFE_12, rx, &ptr->rx_equ_dfe_12 },
+	};
 	int err;
 
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE1,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_pre1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE3,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_pre3);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_ATTEN,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_atten);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_POST1,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_post1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE2,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_pre2);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_PRE2,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_pre2);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_PRE1,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_pre1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_POST1,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_post1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_BFLF,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_bflf);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_BFHF,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_bfhf);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_DRATE,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_drate);
-	if (err)
-		return err;
+	for (int i = 0; i < ARRAY_SIZE(aq_params); i++) {
+		err = ice_aq_get_phy_equalization(hw, aq_params[i].data_in,
+						  aq_params[i].opcode,
+						  serdes_num, aq_params[i].out);
+		if (err)
+			break;
+	}
 
-	return 0;
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 9acccae38625..23b2cfbc9684 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -10,17 +10,33 @@ struct ice_phy_type_to_ethtool {
 };
 
 struct ice_serdes_equalization_to_ethtool {
-	int rx_equalization_pre2;
-	int rx_equalization_pre1;
-	int rx_equalization_post1;
-	int rx_equalization_bflf;
-	int rx_equalization_bfhf;
-	int rx_equalization_drate;
-	int tx_equalization_pre1;
-	int tx_equalization_pre3;
-	int tx_equalization_atten;
-	int tx_equalization_post1;
-	int tx_equalization_pre2;
+	int rx_equ_pre2;
+	int rx_equ_pre1;
+	int rx_equ_post1;
+	int rx_equ_bflf;
+	int rx_equ_bfhf;
+	int rx_equ_ctle_gainhf;
+	int rx_equ_ctle_gainlf;
+	int rx_equ_ctle_gaindc;
+	int rx_equ_ctle_bw;
+	int rx_equ_dfe_gain;
+	int rx_equ_dfe_gain_2;
+	int rx_equ_dfe_2;
+	int rx_equ_dfe_3;
+	int rx_equ_dfe_4;
+	int rx_equ_dfe_5;
+	int rx_equ_dfe_6;
+	int rx_equ_dfe_7;
+	int rx_equ_dfe_8;
+	int rx_equ_dfe_9;
+	int rx_equ_dfe_10;
+	int rx_equ_dfe_11;
+	int rx_equ_dfe_12;
+	int tx_equ_pre1;
+	int tx_equ_pre3;
+	int tx_equ_atten;
+	int tx_equ_post1;
+	int tx_equ_pre2;
 };
 
 struct ice_regdump_to_ethtool {
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 6509d807627c..4f56d53d56b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -257,7 +257,6 @@ ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *table, int size,
 /*** ICE_SID_RXPARSER_BOOST_TCAM and ICE_SID_LBL_RXPARSER_TMEM sections ***/
 #define ICE_BST_TCAM_TABLE_SIZE		256
 #define ICE_BST_TCAM_KEY_SIZE		20
-#define ICE_BST_KEY_TCAM_SIZE		19
 
 /* Boost TCAM item */
 struct ice_bst_tcam_item {
@@ -401,7 +400,6 @@ u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag);
 #define ICE_PARSER_GPR_NUM	128
 #define ICE_PARSER_FLG_NUM	64
 #define ICE_PARSER_ERR_NUM	16
-#define ICE_BST_KEY_SIZE	10
 #define ICE_MARKER_ID_SIZE	9
 #define ICE_MARKER_MAX_SIZE	\
 		(ICE_MARKER_ID_SIZE * BITS_PER_BYTE - 1)
@@ -431,13 +429,13 @@ struct ice_parser_rt {
 	u8 pkt_buf[ICE_PARSER_MAX_PKT_LEN + ICE_PARSER_PKT_REV];
 	u16 pkt_len;
 	u16 po;
-	u8 bst_key[ICE_BST_KEY_SIZE];
+	u8 bst_key[ICE_BST_TCAM_KEY_SIZE];
 	struct ice_pg_cam_key pg_key;
+	u8 pg_prio;
 	struct ice_alu *alu0;
 	struct ice_alu *alu1;
 	struct ice_alu *alu2;
 	struct ice_pg_cam_action *action;
-	u8 pg_prio;
 	struct ice_gpr_pu pu;
 	u8 markers[ICE_MARKER_ID_SIZE];
 	bool protocols[ICE_PO_PAIR_SIZE];
diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index dedf5e854e4b..3995d662e050 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -125,22 +125,20 @@ static void ice_bst_key_init(struct ice_parser_rt *rt,
 	else
 		key[idd] = imem->b_kb.prio;
 
-	idd = ICE_BST_KEY_TCAM_SIZE - 1;
+	idd = ICE_BST_TCAM_KEY_SIZE - 2;
 	for (i = idd; i >= 0; i--) {
 		int j;
 
 		j = ho + idd - i;
 		if (j < ICE_PARSER_MAX_PKT_LEN)
-			key[i] = rt->pkt_buf[ho + idd - i];
+			key[i] = rt->pkt_buf[j];
 		else
 			key[i] = 0;
 	}
 
-	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Generated Boost TCAM Key:\n");
-	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "%02X %02X %02X %02X %02X %02X %02X %02X %02X %02X\n",
-		  key[0], key[1], key[2], key[3], key[4],
-		  key[5], key[6], key[7], key[8], key[9]);
-	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "\n");
+	ice_debug_array_w_prefix(rt->psr->hw, ICE_DBG_PARSER,
+				 KBUILD_MODNAME ": Generated Boost TCAM Key",
+				 key, ICE_BST_TCAM_KEY_SIZE);
 }
 
 static u16 ice_bit_rev_u16(u16 v, int len)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index 4849590a5591..b28991dd1870 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -376,6 +376,9 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 		if (!(le16_to_cpu(desc->flags) & IDPF_CTLQ_FLAG_DD))
 			break;
 
+		/* Ensure no other fields are read until DD flag is checked */
+		dma_rmb();
+
 		/* strip off FW internal code */
 		desc_err = le16_to_cpu(desc->ret_val) & 0xff;
 
@@ -563,6 +566,9 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 		if (!(flags & IDPF_CTLQ_FLAG_DD))
 			break;
 
+		/* Ensure no other fields are read until DD flag is checked */
+		dma_rmb();
+
 		q_msg[i].vmvf_type = (flags &
 				      (IDPF_CTLQ_FLAG_FTYPE_VM |
 				       IDPF_CTLQ_FLAG_FTYPE_PF)) >>
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index db476b3314c8..dfd56fc5ff65 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -174,7 +174,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
 
-	adapter->init_wq = alloc_workqueue("%s-%s-init", 0, 0,
+	adapter->init_wq = alloc_workqueue("%s-%s-init",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->init_wq) {
@@ -183,7 +184,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
-	adapter->serv_wq = alloc_workqueue("%s-%s-service", 0, 0,
+	adapter->serv_wq = alloc_workqueue("%s-%s-service",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->serv_wq) {
@@ -192,7 +194,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", 0, 0,
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
+					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					  dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
@@ -201,7 +204,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_mbx_wq_alloc;
 	}
 
-	adapter->stats_wq = alloc_workqueue("%s-%s-stats", 0, 0,
+	adapter->stats_wq = alloc_workqueue("%s-%s-stats",
+					    WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					    dev_driver_string(dev),
 					    dev_name(dev));
 	if (!adapter->stats_wq) {
@@ -210,7 +214,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_stats_wq_alloc;
 	}
 
-	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event", 0, 0,
+	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event",
+					       WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					       dev_driver_string(dev),
 					       dev_name(dev));
 	if (!adapter->vc_event_wq) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d46c95f91b0d..99bdb95bf226 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		return -EINVAL;
 	}
 	xn = &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
 
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
@@ -3077,12 +3078,21 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	bool remove_in_prog;
+
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
+	/* Avoid transaction timeouts when called during reset */
+	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
+	if (!remove_in_prog)
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
-	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
+	if (remove_in_prog)
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..730aa5632cce 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -995,12 +995,6 @@ static void octep_get_stats64(struct net_device *netdev,
 	struct octep_device *oct = netdev_priv(netdev);
 	int q;
 
-	if (netif_running(netdev))
-		octep_ctrl_net_get_if_stats(oct,
-					    OCTEP_CTRL_NET_INVALID_VFID,
-					    &oct->iface_rx_stats,
-					    &oct->iface_tx_stats);
-
 	tx_packets = 0;
 	tx_bytes = 0;
 	rx_packets = 0;
@@ -1018,10 +1012,6 @@ static void octep_get_stats64(struct net_device *netdev,
 	stats->tx_bytes = tx_bytes;
 	stats->rx_packets = rx_packets;
 	stats->rx_bytes = rx_bytes;
-	stats->multicast = oct->iface_rx_stats.mcast_pkts;
-	stats->rx_errors = oct->iface_rx_stats.err_pkts;
-	stats->collisions = oct->iface_tx_stats.xscol;
-	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;
 }
 
 /**
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..4c699514fd57 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -799,14 +799,6 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 	stats->tx_bytes = tx_bytes;
 	stats->rx_packets = rx_packets;
 	stats->rx_bytes = rx_bytes;
-	if (!octep_vf_get_if_stats(oct)) {
-		stats->multicast = oct->iface_rx_stats.mcast_pkts;
-		stats->rx_errors = oct->iface_rx_stats.err_pkts;
-		stats->rx_dropped = oct->iface_rx_stats.dropped_pkts_fifo_full +
-				    oct->iface_rx_stats.err_pkts;
-		stats->rx_missed_errors = oct->iface_rx_stats.dropped_pkts_fifo_full;
-		stats->tx_dropped = oct->iface_tx_stats.dropped;
-	}
 }
 
 /**
diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 2c26eb185283..20cf7ba9d750 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -258,11 +258,11 @@
 #define REG_GDM3_FWD_CFG		GDM3_BASE
 #define GDM3_PAD_EN_MASK		BIT(28)
 
-#define REG_GDM4_FWD_CFG		(GDM4_BASE + 0x100)
+#define REG_GDM4_FWD_CFG		GDM4_BASE
 #define GDM4_PAD_EN_MASK		BIT(28)
 #define GDM4_SPORT_OFFSET0_MASK		GENMASK(11, 8)
 
-#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x33c)
+#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x23c)
 #define GDM4_SPORT_OFF2_MASK		GENMASK(19, 16)
 #define GDM4_SPORT_OFF1_MASK		GENMASK(15, 12)
 #define GDM4_SPORT_OFF0_MASK		GENMASK(11, 8)
@@ -2123,17 +2123,14 @@ static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_disable(&qdma->q_rx[i].napi);
 		netif_napi_del(&qdma->q_rx[i].napi);
 		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
 		if (qdma->q_rx[i].page_pool)
 			page_pool_destroy(qdma->q_rx[i].page_pool);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
-		napi_disable(&qdma->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
-	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
 		if (!qdma->q_tx[i].ndesc)
@@ -2158,6 +2155,21 @@ static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 	}
 }
 
+static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+		napi_disable(&qdma->q_tx_irq[i].napi);
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
+			continue;
+
+		napi_disable(&qdma->q_rx[i].napi);
+	}
+}
+
 static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
@@ -2713,7 +2725,7 @@ static int airoha_probe(struct platform_device *pdev)
 
 	err = airoha_hw_init(pdev, eth);
 	if (err)
-		goto error;
+		goto error_hw_cleanup;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
@@ -2728,13 +2740,16 @@ static int airoha_probe(struct platform_device *pdev)
 		err = airoha_alloc_gdm_port(eth, np);
 		if (err) {
 			of_node_put(np);
-			goto error;
+			goto error_napi_stop;
 		}
 	}
 
 	return 0;
 
-error:
+error_napi_stop:
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_stop_napi(&eth->qdma[i]);
+error_hw_cleanup:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_hw_cleanup(&eth->qdma[i]);
 
@@ -2755,8 +2770,10 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+		airoha_qdma_stop_napi(&eth->qdma[i]);
 		airoha_hw_cleanup(&eth->qdma[i]);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
index 3f4c58bada37..ab5f8f07f1f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
@@ -70,7 +70,7 @@
 			u32 second_dw_mask = (mask) & ((1 << _bit_off) - 1); \
 			_HWS_SET32(p, (v) >> _bit_off, byte_off, 0, (mask) >> _bit_off); \
 			_HWS_SET32(p, (v) & second_dw_mask, (byte_off) + DW_SIZE, \
-				    (bit_off) % BITS_IN_DW, second_dw_mask); \
+				    (bit_off + BITS_IN_DW) % BITS_IN_DW, second_dw_mask); \
 		} else { \
 			_HWS_SET32(p, v, byte_off, (bit_off), (mask)); \
 		} \
diff --git a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
index 46245e0b2462..43c84900369a 100644
--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
@@ -14,7 +14,6 @@
 #define MLXFW_FSM_STATE_WAIT_TIMEOUT_MS 30000
 #define MLXFW_FSM_STATE_WAIT_ROUNDS \
 	(MLXFW_FSM_STATE_WAIT_TIMEOUT_MS / MLXFW_FSM_STATE_WAIT_CYCLE_MS)
-#define MLXFW_FSM_MAX_COMPONENT_SIZE (10 * (1 << 20))
 
 static const int mlxfw_fsm_state_errno[] = {
 	[MLXFW_FSM_STATE_ERR_ERROR] = -EIO,
@@ -229,7 +228,6 @@ static int mlxfw_flash_component(struct mlxfw_dev *mlxfw_dev,
 		return err;
 	}
 
-	comp_max_size = min_t(u32, comp_max_size, MLXFW_FSM_MAX_COMPONENT_SIZE);
 	if (comp->data_size > comp_max_size) {
 		MLXFW_ERR_MSG(mlxfw_dev, extack,
 			      "Component size is bigger than limit", -EINVAL);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
index 69cd689dbc83..5afe6b155ef0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
@@ -1003,10 +1003,10 @@ static void mlxsw_sp_mr_route_stats_update(struct mlxsw_sp *mlxsw_sp,
 	mr->mr_ops->route_stats(mlxsw_sp, mr_route->route_priv, &packets,
 				&bytes);
 
-	if (mr_route->mfc->mfc_un.res.pkt != packets)
-		mr_route->mfc->mfc_un.res.lastuse = jiffies;
-	mr_route->mfc->mfc_un.res.pkt = packets;
-	mr_route->mfc->mfc_un.res.bytes = bytes;
+	if (atomic_long_read(&mr_route->mfc->mfc_un.res.pkt) != packets)
+		WRITE_ONCE(mr_route->mfc->mfc_un.res.lastuse, jiffies);
+	atomic_long_set(&mr_route->mfc->mfc_un.res.pkt, packets);
+	atomic_long_set(&mr_route->mfc->mfc_un.res.bytes, bytes);
 }
 
 static void mlxsw_sp_mr_stats_update(struct work_struct *work)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 6f6b0566c65b..cc4f0d16c763 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3208,10 +3208,15 @@ static int ravb_suspend(struct device *dev)
 
 	netif_device_detach(ndev);
 
-	if (priv->wol_enabled)
-		return ravb_wol_setup(ndev);
+	rtnl_lock();
+	if (priv->wol_enabled) {
+		ret = ravb_wol_setup(ndev);
+		rtnl_unlock();
+		return ret;
+	}
 
 	ret = ravb_close(ndev);
+	rtnl_unlock();
 	if (ret)
 		return ret;
 
@@ -3236,19 +3241,20 @@ static int ravb_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
+	rtnl_lock();
 	/* If WoL is enabled restore the interface. */
-	if (priv->wol_enabled) {
+	if (priv->wol_enabled)
 		ret = ravb_wol_restore(ndev);
-		if (ret)
-			return ret;
-	} else {
+	else
 		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			return ret;
+	if (ret) {
+		rtnl_unlock();
+		return ret;
 	}
 
 	/* Reopening the interface will restore the device to the working state. */
 	ret = ravb_open(ndev);
+	rtnl_unlock();
 	if (ret < 0)
 		goto out_rpm_put;
 
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 7a25903e35c3..bc12c0c7347f 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3494,10 +3494,12 @@ static int sh_eth_suspend(struct device *dev)
 
 	netif_device_detach(ndev);
 
+	rtnl_lock();
 	if (mdp->wol_enabled)
 		ret = sh_eth_wol_setup(ndev);
 	else
 		ret = sh_eth_close(ndev);
+	rtnl_unlock();
 
 	return ret;
 }
@@ -3511,10 +3513,12 @@ static int sh_eth_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
+	rtnl_lock();
 	if (mdp->wol_enabled)
 		ret = sh_eth_wol_restore(ndev);
 	else
 		ret = sh_eth_open(ndev);
+	rtnl_unlock();
 
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index 5c2551369812..6c3b74000d3b 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -59,6 +59,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
 	.rxfh_per_ctx_key	= true,
+	.cap_rss_rxnfc_adds	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index bb1930818beb..83d715544f7f 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -263,6 +263,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
 	.rxfh_per_ctx_key	= true,
+	.cap_rss_rxnfc_adds	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cf7b59b8cc64..918d7f2e8ba9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7236,6 +7236,36 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (priv->dma_cap.tsoen)
 		dev_info(priv->device, "TSO supported\n");
 
+	if (priv->dma_cap.number_rx_queues &&
+	    priv->plat->rx_queues_to_use > priv->dma_cap.number_rx_queues) {
+		dev_warn(priv->device,
+			 "Number of Rx queues (%u) exceeds dma capability\n",
+			 priv->plat->rx_queues_to_use);
+		priv->plat->rx_queues_to_use = priv->dma_cap.number_rx_queues;
+	}
+	if (priv->dma_cap.number_tx_queues &&
+	    priv->plat->tx_queues_to_use > priv->dma_cap.number_tx_queues) {
+		dev_warn(priv->device,
+			 "Number of Tx queues (%u) exceeds dma capability\n",
+			 priv->plat->tx_queues_to_use);
+		priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
+	}
+
+	if (priv->dma_cap.rx_fifo_size &&
+	    priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
+		dev_warn(priv->device,
+			 "Rx FIFO size (%u) exceeds dma capability\n",
+			 priv->plat->rx_fifo_size);
+		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
+	}
+	if (priv->dma_cap.tx_fifo_size &&
+	    priv->plat->tx_fifo_size > priv->dma_cap.tx_fifo_size) {
+		dev_warn(priv->device,
+			 "Tx FIFO size (%u) exceeds dma capability\n",
+			 priv->plat->tx_fifo_size);
+		priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
+	}
+
 	priv->hw->vlan_fail_q_en =
 		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index dfca13b82bdc..b13c7e958e6b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2207,7 +2207,7 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		if (tx_chn->irq)
+		if (tx_chn->irq > 0)
 			devm_free_irq(dev, tx_chn->irq, tx_chn);
 
 		netif_napi_del(&tx_chn->napi_tx);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bf02efa10956..84181dcb9883 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -129,6 +129,7 @@ struct netdevsim {
 		u32 sleep;
 		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
 		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
+		struct dentry *ddir;
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 02dc3123eb6c..640b4983a9a0 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -112,9 +112,11 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
 	struct net_device *dev = file->private_data;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
 	rtnl_lock();
-	udp_tunnel_nic_reset_ntf(dev);
+	if (dev->reg_state == NETREG_REGISTERED) {
+		memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
+		udp_tunnel_nic_reset_ntf(dev);
+	}
 	rtnl_unlock();
 
 	return count;
@@ -144,23 +146,23 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 	else
 		ns->udp_ports.ports = nsim_dev->udp_ports.__ports;
 
-	debugfs_create_u32("udp_ports_inject_error", 0600,
-			   ns->nsim_dev_port->ddir,
+	ns->udp_ports.ddir = debugfs_create_dir("udp_ports",
+						ns->nsim_dev_port->ddir);
+
+	debugfs_create_u32("inject_error", 0600, ns->udp_ports.ddir,
 			   &ns->udp_ports.inject_error);
 
 	ns->udp_ports.dfs_ports[0].array = ns->udp_ports.ports[0];
 	ns->udp_ports.dfs_ports[0].n_elements = NSIM_UDP_TUNNEL_N_PORTS;
-	debugfs_create_u32_array("udp_ports_table0", 0400,
-				 ns->nsim_dev_port->ddir,
+	debugfs_create_u32_array("table0", 0400, ns->udp_ports.ddir,
 				 &ns->udp_ports.dfs_ports[0]);
 
 	ns->udp_ports.dfs_ports[1].array = ns->udp_ports.ports[1];
 	ns->udp_ports.dfs_ports[1].n_elements = NSIM_UDP_TUNNEL_N_PORTS;
-	debugfs_create_u32_array("udp_ports_table1", 0400,
-				 ns->nsim_dev_port->ddir,
+	debugfs_create_u32_array("table1", 0400, ns->udp_ports.ddir,
 				 &ns->udp_ports.dfs_ports[1]);
 
-	debugfs_create_file("udp_ports_reset", 0200, ns->nsim_dev_port->ddir,
+	debugfs_create_file("reset", 0200, ns->udp_ports.ddir,
 			    dev, &nsim_udp_tunnels_info_reset_fops);
 
 	/* Note: it's not normal to allocate the info struct like this!
@@ -196,6 +198,9 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 
 void nsim_udp_tunnels_info_destroy(struct net_device *dev)
 {
+	struct netdevsim *ns = netdev_priv(dev);
+
+	debugfs_remove_recursive(ns->udp_ports.ddir);
 	kfree(dev->udp_tunnel_nic_info);
 	dev->udp_tunnel_nic_info = NULL;
 }
diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index c812f16eaa3a..b3a5a0af19da 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -95,6 +95,10 @@
 
 #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
 
+struct mv88q2xxx_priv {
+	bool enable_temp;
+};
+
 struct mmd_val {
 	int devad;
 	u32 regnum;
@@ -669,17 +673,12 @@ static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
 
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
 	char *hwmon_name;
-	int ret;
-
-	/* Enable temperature sense */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
-			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
-	if (ret < 0)
-		return ret;
 
+	priv->enable_temp = true;
 	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
 	if (IS_ERR(hwmon_name))
 		return PTR_ERR(hwmon_name);
@@ -702,6 +701,14 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 
 static int mv88q2xxx_probe(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
 	return mv88q2xxx_hwmon_probe(phydev);
 }
 
@@ -792,6 +799,18 @@ static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
 
 static int mv88q222x_config_init(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	int ret;
+
+	/* Enable temperature sense */
+	if (priv->enable_temp) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
 		return mv88q222x_revb0_config_init(phydev);
 	else
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765..5ca6ecf0ce5f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1329,9 +1329,9 @@ int tap_queue_resize(struct tap_dev *tap)
 	list_for_each_entry(q, &tap->queue_list, next)
 		rings[i++] = &q->ring;
 
-	ret = ptr_ring_resize_multiple(rings, n,
-				       dev->tx_queue_len, GFP_KERNEL,
-				       __skb_array_destroy_skb);
+	ret = ptr_ring_resize_multiple_bh(rings, n,
+					  dev->tx_queue_len, GFP_KERNEL,
+					  __skb_array_destroy_skb);
 
 	kfree(rings);
 	return ret;
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 1c85dda83825..7f4ef219eee4 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1175,6 +1175,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EBUSY;
 	}
 
+	if (netdev_has_upper_dev(port_dev, dev)) {
+		NL_SET_ERR_MSG(extack, "Device is already a lower device of the team interface");
+		netdev_err(dev, "Device %s is already a lower device of the team interface\n",
+			   portname);
+		return -EBUSY;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 03fe9e3ee7af..6fc60950100c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3697,9 +3697,9 @@ static int tun_queue_resize(struct tun_struct *tun)
 	list_for_each_entry(tfile, &tun->disabled, next)
 		rings[i++] = &tfile->tx_ring;
 
-	ret = ptr_ring_resize_multiple(rings, n,
-				       dev->tx_queue_len, GFP_KERNEL,
-				       tun_ptr_free);
+	ret = ptr_ring_resize_multiple_bh(rings, n,
+					  dev->tx_queue_len, GFP_KERNEL,
+					  tun_ptr_free);
 
 	kfree(rings);
 	return ret;
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 01a3b2417a54..ddff6f19ff98 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -71,6 +71,14 @@
 #define MSR_SPEED		(1<<3)
 #define MSR_LINK		(1<<2)
 
+/* USB endpoints */
+enum rtl8150_usb_ep {
+	RTL8150_USB_EP_CONTROL = 0,
+	RTL8150_USB_EP_BULK_IN = 1,
+	RTL8150_USB_EP_BULK_OUT = 2,
+	RTL8150_USB_EP_INT_IN = 3,
+};
+
 /* Interrupt pipe data */
 #define INT_TSR			0x00
 #define INT_RSR			0x01
@@ -867,6 +875,13 @@ static int rtl8150_probe(struct usb_interface *intf,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	rtl8150_t *dev;
 	struct net_device *netdev;
+	static const u8 bulk_ep_addr[] = {
+		RTL8150_USB_EP_BULK_IN | USB_DIR_IN,
+		RTL8150_USB_EP_BULK_OUT | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		RTL8150_USB_EP_INT_IN | USB_DIR_IN,
+		0};
 
 	netdev = alloc_etherdev(sizeof(rtl8150_t));
 	if (!netdev)
@@ -880,6 +895,13 @@ static int rtl8150_probe(struct usb_interface *intf,
 		return -ENOMEM;
 	}
 
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(&intf->dev, "couldn't find required endpoints\n");
+		goto out;
+	}
+
 	tasklet_setup(&dev->tl, rx_fixup);
 	spin_lock_init(&dev->rx_pool_lock);
 
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index d2023e7131bd..6e6e9f05509a 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -411,6 +411,11 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 	struct tunnel_msg *tmsg;
 	struct net_device *dev;
 
+	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(struct tunnel_msg))) {
+		NL_SET_ERR_MSG(cb->extack, "Invalid msg length");
+		return -EINVAL;
+	}
+
 	tmsg = nlmsg_data(cb->nlh);
 
 	if (tmsg->flags & ~TUNNEL_MSG_VALID_USER_FLAGS) {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 40088e62572e..40b52d12b432 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3872,6 +3872,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 		ath11k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
 		if (rbm != HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST &&
+		    rbm != HAL_RX_BUF_RBM_SW1_BM &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM) {
 			ab->soc_stats.invalid_rbm++;
 			ath11k_warn(ab, "invalid return buffer manager %d\n", rbm);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 8f7dd43dc1bd..753bd93f0212 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -372,7 +372,8 @@ int ath11k_hal_wbm_desc_parse_err(struct ath11k_base *ab, void *desc,
 
 	ret_buf_mgr = FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
 				wbm_desc->buf_addr_info.info1);
-	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
+	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW1_BM &&
+	    ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
 		ab->soc_stats.invalid_rbm++;
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8946141aa0dc..fbf5d5728357 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7220,9 +7220,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 							chandef->chan->band,
 							arvif->vif->type);
 	arg.min_power = 0;
-	arg.max_power = chandef->chan->max_power * 2;
-	arg.max_reg_power = chandef->chan->max_reg_power * 2;
-	arg.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
+	arg.max_power = chandef->chan->max_power;
+	arg.max_reg_power = chandef->chan->max_reg_power;
+	arg.max_antenna_gain = chandef->chan->max_antenna_gain;
 
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 408776562a7e..cd36cab6db75 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1590,7 +1590,10 @@ static int wcn36xx_probe(struct platform_device *pdev)
 	}
 
 	n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
-	wcn->chan_survey = devm_kmalloc(wcn->dev, n_channels, GFP_KERNEL);
+	wcn->chan_survey = devm_kcalloc(wcn->dev,
+					n_channels,
+					sizeof(struct wcn36xx_chan_survey),
+					GFP_KERNEL);
 	if (!wcn->chan_survey) {
 		ret = -ENOMEM;
 		goto out_wq;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index 31e080e4da66..ab3d6cfcb02b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -6,6 +6,8 @@
 #ifndef _fwil_h_
 #define _fwil_h_
 
+#include "debug.h"
+
 /*******************************************************************************
  * Dongle command codes that are interpreted by firmware
  ******************************************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 091fb6fd7c78..834f7c9bb9e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -13,9 +13,12 @@
 #include <linux/efi.h>
 #include "fw/runtime.h"
 
-#define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
-				  0xb2, 0xec, 0xf5, 0xa3,	\
-				  0x59, 0x4f, 0x4a, 0xea)
+#define IWL_EFI_WIFI_GUID	EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
+					 0xb2, 0xec, 0xf5, 0xa3,	\
+					 0x59, 0x4f, 0x4a, 0xea)
+#define IWL_EFI_WIFI_BT_GUID	EFI_GUID(0xe65d8884, 0xd4af, 0x4b20,	\
+					 0x8d, 0x03, 0x77, 0x2e,	\
+					 0xcc, 0x3d, 0xa5, 0x31)
 
 struct iwl_uefi_pnvm_mem_desc {
 	__le32 addr;
@@ -61,7 +64,7 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 
 	*len = 0;
 
-	data = iwl_uefi_get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_VAR_GUID,
+	data = iwl_uefi_get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_WIFI_GUID,
 				     &package_size);
 	if (IS_ERR(data)) {
 		IWL_DEBUG_FW(trans,
@@ -76,18 +79,18 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
-static
-void *iwl_uefi_get_verified_variable(struct iwl_trans *trans,
-				     efi_char16_t *uefi_var_name,
-				     char *var_name,
-				     unsigned int expected_size,
-				     unsigned long *size)
+static void *
+iwl_uefi_get_verified_variable_guid(struct iwl_trans *trans,
+				    efi_guid_t *guid,
+				    efi_char16_t *uefi_var_name,
+				    char *var_name,
+				    unsigned int expected_size,
+				    unsigned long *size)
 {
 	void *var;
 	unsigned long var_size;
 
-	var = iwl_uefi_get_variable(uefi_var_name, &IWL_EFI_VAR_GUID,
-				    &var_size);
+	var = iwl_uefi_get_variable(uefi_var_name, guid, &var_size);
 
 	if (IS_ERR(var)) {
 		IWL_DEBUG_RADIO(trans,
@@ -112,6 +115,18 @@ void *iwl_uefi_get_verified_variable(struct iwl_trans *trans,
 	return var;
 }
 
+static void *
+iwl_uefi_get_verified_variable(struct iwl_trans *trans,
+			       efi_char16_t *uefi_var_name,
+			       char *var_name,
+			       unsigned int expected_size,
+			       unsigned long *size)
+{
+	return iwl_uefi_get_verified_variable_guid(trans, &IWL_EFI_WIFI_GUID,
+						   uefi_var_name, var_name,
+						   expected_size, size);
+}
+
 int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data)
 {
@@ -311,8 +326,9 @@ void iwl_uefi_get_step_table(struct iwl_trans *trans)
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
-	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_STEP_NAME,
-					      "STEP", sizeof(*data), NULL);
+	data = iwl_uefi_get_verified_variable_guid(trans, &IWL_EFI_WIFI_BT_GUID,
+						   IWL_UEFI_STEP_NAME,
+						   "STEP", sizeof(*data), NULL);
 	if (IS_ERR(data))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index b607961970e9..9b8624304fa3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -530,18 +530,15 @@ static void iwl_mvm_bt_coex_notif_iterator(void *_data, u8 *mac,
 					   struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = _data;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	for (int link_id = 0;
-	     link_id < IEEE80211_MLD_MAX_NUM_LINKS;
-	     link_id++) {
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_check(vif->link_conf[link_id],
-					      lockdep_is_held(&mvm->mutex));
+	for_each_vif_active_link(vif, link_conf, link_id) {
 		struct ieee80211_chanctx_conf *chanctx_conf =
 			rcu_dereference_check(link_conf->chanctx_conf,
 					      lockdep_is_held(&mvm->mutex));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ca026b5256ce..5f4942f6cc68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1880,7 +1880,9 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "Next reclaimed packet:%d\n",
 						   next_reclaimed);
-				iwl_mvm_count_mpdu(mvmsta, sta_id, 1, true, 0);
+				if (tid < IWL_MAX_TID_COUNT)
+					iwl_mvm_count_mpdu(mvmsta, sta_id, 1,
+							   true, 0);
 			} else {
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "NDP - don't update next_reclaimed\n");
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9d5561f44134..0ca83f1a3e3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -958,11 +958,11 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 
 	if (chandef->chan != phy->main_chan)
 		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
-	mt76_worker_enable(&dev->tx_worker);
 
 	ret = dev->drv->set_channel(phy);
 
 	clear_bit(MT76_RESET, &phy->state);
+	mt76_worker_enable(&dev->tx_worker);
 	mt76_worker_schedule(&dev->tx_worker);
 
 	mutex_unlock(&dev->mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 96e34277fece..1cc8fc8fefe7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1113,7 +1113,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
-	return mt76_connac_mcu_uni_add_dev(phy->mt76, &vif->bss_conf,
+	return mt76_connac_mcu_uni_add_dev(phy->mt76, &vif->bss_conf, &mvif->mt76,
 					   &mvif->sta.wcid, enable);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 864246f94088..7d07e720e4ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1137,10 +1137,10 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ba_tlv);
 
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct ieee80211_bss_conf *bss_conf,
+				struct mt76_vif *mvif,
 				struct mt76_wcid *wcid,
 				bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)bss_conf->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1b0e80dfc346..57a8340fa700 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1938,6 +1938,7 @@ void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
 				bool enable, bool tx);
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct ieee80211_bss_conf *bss_conf,
+				struct mt76_vif *mvif,
 				struct mt76_wcid *wcid,
 				bool enable);
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6bef96e3d2a3..77d82ccd7307 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -82,7 +82,7 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&phy->dev->mt76.mutex);
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 60, 130);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 60 * 1000, 130 * 1000), 1000);
 
 	if ((i - 1 == MT7915_CRIT_TEMP_IDX &&
 	     val > phy->throttle_temp[MT7915_MAX_TEMP_IDX]) ||
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cf77ce0c8759..799e8d2cc7e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1388,6 +1388,8 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	if (dev_is_pci(mdev->dev)) {
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 		if (dev->hif2) {
+			mt76_wr(dev, MT_PCIE_RECOG_ID,
+				dev->hif2->index | MT_PCIE_RECOG_ID_SEM);
 			if (is_mt7915(mdev))
 				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
 			else
@@ -1442,9 +1444,11 @@ static void
 mt7915_mac_full_reset(struct mt7915_dev *dev)
 {
 	struct mt76_phy *ext_phy;
+	struct mt7915_phy *phy2;
 	int i;
 
 	ext_phy = dev->mt76.phys[MT_BAND1];
+	phy2 = ext_phy ? ext_phy->priv : NULL;
 
 	dev->recovery.hw_full_reset = true;
 
@@ -1474,6 +1478,9 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 
 	memset(dev->mt76.wcid_mask, 0, sizeof(dev->mt76.wcid_mask));
 	dev->mt76.vif_mask = 0;
+	dev->phy.omac_mask = 0;
+	if (phy2)
+		phy2->omac_mask = 0;
 
 	i = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	dev->mt76.global_wcid.idx = i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d75e8dea1fbd..8c0d63cebf3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -246,8 +246,10 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, mt7915_wtbl_size(dev));
-	if (idx < 0)
-		return -ENOSPC;
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
@@ -619,8 +621,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC)
 		set_bss_info = vif->cfg.assoc;
 	if (changed & BSS_CHANGED_BEACON_ENABLED &&
+	    info->enable_beacon &&
 	    vif->type != NL80211_IFTYPE_AP)
-		set_bss_info = set_sta = info->enable_beacon;
+		set_bss_info = set_sta = 1;
 
 	if (set_bss_info == 1)
 		mt7915_mcu_add_bss_info(phy, vif, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 44e112b8b5b3..2e7604eed27b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -484,7 +484,7 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 			continue;
 
 		ofs = addr - dev->reg.map[i].phys;
-		if (ofs > dev->reg.map[i].size)
+		if (ofs >= dev->reg.map[i].size)
 			continue;
 
 		return dev->reg.map[i].maps + ofs;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ac0b1f0eb27c..5fe872ef2e93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -191,6 +191,7 @@ struct mt7915_hif {
 	struct device *dev;
 	void __iomem *regs;
 	int irq;
+	u32 index;
 };
 
 struct mt7915_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 39132894e8ea..07b0a5766eab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -42,6 +42,7 @@ static struct mt7915_hif *mt7915_pci_get_hif2(u32 idx)
 			continue;
 
 		get_device(hif->dev);
+		hif->index = idx;
 		goto out;
 	}
 	hif = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 047106b65d2b..bd1455698ebe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -647,6 +647,7 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 		ieee80211_disconnect(vif, true);
 
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+				    &mvif->bss_conf.mt76,
 				    &mvif->sta.deflink.wcid, true);
 	mt7921_mcu_set_tx(dev, vif);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index a7f5bfbc02ed..e2dfd3670c4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -308,6 +308,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					  &mvif->bss_conf.mt76,
 					  &mvif->sta.deflink.wcid, true);
 	if (ret)
 		goto out;
@@ -531,7 +532,13 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else {
 		if (idx == *wcid_keyidx)
 			*wcid_keyidx = -1;
-		goto out;
+
+		/* For security issue we don't trigger the key deletion when
+		 * reassociating. But we should trigger the deletion process
+		 * to avoid using incorrect cipher after disconnection,
+		 */
+		if (vif->type != NL80211_IFTYPE_STATION || vif->cfg.assoc)
+			goto out;
 	}
 
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 634c42bbf23f..a095fb31e391 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -49,7 +49,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 			break;
 		mlink = list_first_entry(&sta_poll_list,
 					 struct mt792x_link_sta, wcid.poll_list);
-		msta = container_of(mlink, struct mt792x_sta, deflink);
+		msta = mlink->sta;
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		list_del_init(&mlink->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
@@ -1271,6 +1271,7 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 	struct mt792x_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct ieee80211_bss_conf *bss_conf;
+	struct mt792x_bss_conf *mconf;
 	int i;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
@@ -1278,8 +1279,9 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		mconf = mt792x_vif_to_link(mvif, i);
 
-		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf,
+		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
 					    &mvif->sta.deflink.wcid, true);
 		mt7925_mcu_set_tx(dev, bss_conf);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 791c8b00e112..ddc67423efe2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -365,18 +365,14 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
 			       0 : mconf->mt76.idx;
 	mconf->mt76.band_idx = 0xff;
-	mconf->mt76.wmm_idx = mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
+			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
 	else
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf,
-					  &mlink->wcid, true);
-	if (ret)
-		goto out;
-
 	dev->mt76.vif_mask |= BIT_ULL(mconf->mt76.idx);
 	mvif->phy->omac_mask |= BIT_ULL(mconf->mt76.omac_idx);
 
@@ -384,7 +380,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.phy_idx = 0;
 	mlink->wcid.hw_key_idx = -1;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_wcid_init(&mlink->wcid);
@@ -395,6 +391,12 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	ewma_rssi_init(&mconf->rssi);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->wcid);
+
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
+					  &mlink->wcid, true);
+	if (ret)
+		goto out;
+
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = idx;
@@ -837,6 +839,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	u8 link_id = link_sta->link_id;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
+	struct mt76_wcid *wcid;
 	int ret, idx;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -850,11 +853,20 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.phy_idx = 0;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
 	mlink->wcid.link_valid = !!link_sta->sta->valid_links;
+	mlink->sta = msta;
+
+	wcid = &mlink->wcid;
+	ewma_signal_init(&wcid->rssi);
+	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
+	mt76_wcid_init(wcid);
+	ewma_avg_signal_init(&mlink->avg_ack_signal);
+	memset(mlink->airtime_ac, 0,
+	       sizeof(msta->deflink.airtime_ac));
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
@@ -866,9 +878,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
 	/* should update bss info before STA add */
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-					link_conf, link_sta, false);
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		if (ieee80211_vif_is_mld(vif))
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, link_sta != mlink->pri_link);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, false);
+	}
 
 	if (ieee80211_vif_is_mld(vif) &&
 	    link_sta == mlink->pri_link) {
@@ -904,7 +921,6 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, unsigned long new_links)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct mt76_wcid *wcid;
 	unsigned int link_id;
 	int err = 0;
 
@@ -921,14 +937,6 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 				err = -ENOMEM;
 				break;
 			}
-
-			wcid = &mlink->wcid;
-			ewma_signal_init(&wcid->rssi);
-			rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
-			mt76_wcid_init(wcid);
-			ewma_avg_signal_init(&mlink->avg_ack_signal);
-			memset(mlink->airtime_ac, 0,
-			       sizeof(msta->deflink.airtime_ac));
 		}
 
 		msta->valid_links |= BIT(link_id);
@@ -1141,8 +1149,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
-					link_sta, false);
+		mt792x_mac_link_bss_remove(dev, mconf, mlink);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1200,12 +1207,45 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* hw link idx */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = 0,
+			.band_idx = 0,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = true,
+		},
+	};
 	unsigned long rem;
 
 	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
+	if (ieee80211_vif_is_mld(vif)) {
+		mt7925_mcu_set_dbdc(&dev->mphy, false);
+
+		/* recovery omac address for the legacy interface */
+		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+				  &dev_req, sizeof(dev_req), true);
+	}
+
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
@@ -1250,22 +1290,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, params, true);
+		mt7925_mcu_uni_rx_ba(dev, vif, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, params, false);
+		mt7925_mcu_uni_rx_ba(dev, vif, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, params, true);
+		mt7925_mcu_uni_tx_ba(dev, vif, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1274,7 +1314,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
@@ -1895,6 +1935,13 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7925_mcu_set_tx(dev, info);
 
+	if (changed & BSS_CHANGED_BSSID) {
+		if (ieee80211_vif_is_mld(vif) &&
+		    hweight16(mvif->valid_links) == 2)
+			/* Indicate the secondary setup done */
+			mt7925_mcu_uni_bss_bcnft(dev, info, true);
+	}
+
 	mt792x_mutex_release(dev);
 }
 
@@ -1946,6 +1993,8 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 					     GFP_KERNEL);
 			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
 					     GFP_KERNEL);
+			if (!mconf || !mlink)
+				return -ENOMEM;
 		}
 
 		mconfs[link_id] = mconf;
@@ -1974,6 +2023,8 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto free;
 
 		if (mconf != &mvif->bss_conf) {
+			mt7925_mcu_set_bss_pm(dev, link_conf, true);
+
 			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
 						 vif->active_links);
 			if (err < 0)
@@ -2071,18 +2122,16 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct ieee80211_bss_conf *pri_link_conf;
 	struct mt792x_bss_conf *mconf;
 
 	mutex_lock(&dev->mt76.mutex);
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
-		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
-			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
+			mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
 						NULL, false);
 	} else {
 		mconf = &mvif->bss_conf;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..ce3d8197b026 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -123,10 +123,8 @@ EXPORT_SYMBOL_GPL(mt7925_mcu_regval);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
 				 struct ieee80211_bss_conf *link_conf)
 {
-	struct ieee80211_vif *mvif = container_of((void *)link_conf->vif,
-						  struct ieee80211_vif,
-						  drv_priv);
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct ieee80211_vif *mvif = link_conf->vif;
 	struct sk_buff *skb;
 	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
 			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
@@ -531,10 +529,10 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 
 static int
 mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+		  struct mt76_wcid *wcid,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -562,28 +560,60 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 /** starec & wtbl **/
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct mt76_wcid *wcid;
+	u8 link_id, ret;
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mlink = mt792x_sta_to_link(msta, link_id);
+		wcid = &mlink->wcid;
 
-	if (enable && !params->amsdu)
-		msta->deflink.wcid.amsdu = false;
+		if (enable && !params->amsdu)
+			mlink->wcid.amsdu = false;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
-				 enable, true);
+		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
+					enable, true);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct mt76_wcid *wcid;
+	u8 link_id, ret;
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mlink = mt792x_sta_to_link(msta, link_id);
+		wcid = &mlink->wcid;
+
+		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
+					enable, false);
+		if (ret < 0)
+			break;
+	}
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
-				 enable, false);
+	return ret;
 }
 
 static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
@@ -638,7 +668,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
 		clc = (const struct mt7925_clc *)(clc_base + offset);
 
-		if (clc->idx > ARRAY_SIZE(phy->clc))
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
 			break;
 
 		/* do not init buf again if chip reset triggered */
@@ -823,7 +853,7 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
 			mt7925_mcu_parse_phy_cap(dev, tlv->data);
 			break;
 		case MT_NIC_CAP_CHIP_CAP:
-			memcpy(&dev->phy.chip_cap, (void *)skb->data, sizeof(u64));
+			dev->phy.chip_cap = le64_to_cpu(*(__le64 *)tlv->data);
 			break;
 		case MT_NIC_CAP_EML_CAP:
 			mt7925_mcu_parse_eml_cap(dev, tlv->data);
@@ -1153,7 +1183,12 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 			u8 rsv[4];
 		} __packed hdr;
 		struct roc_acquire_tlv roc[2];
-	} __packed req;
+	} __packed req = {
+			.roc[0].tag = cpu_to_le16(UNI_ROC_NUM),
+			.roc[0].len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.roc[1].tag = cpu_to_le16(UNI_ROC_NUM),
+			.roc[1].len = cpu_to_le16(sizeof(struct roc_acquire_tlv))
+	};
 
 	if (!mconf || hweight16(vif->valid_links) < 2 ||
 	    hweight16(sel_links) != 2)
@@ -1200,6 +1235,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		req.roc[i].bw_from_ap = CMD_CBW_20MHZ;
 		req.roc[i].center_chan = center_ch;
 		req.roc[i].center_chan_from_ap = center_ch;
+		req.roc[i].center_chan2 = 0;
+		req.roc[i].center_chan2_from_ap = 0;
 
 		/* STR : 0xfe indicates BAND_ALL with enabling DBDC
 		 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
@@ -1215,7 +1252,7 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 	}
 
 	return mt76_mcu_send_msg(&mvif->phy->dev->mt76, MCU_UNI_CMD(ROC),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
@@ -1264,7 +1301,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 	}
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
@@ -1294,7 +1331,7 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
@@ -1357,7 +1394,7 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 				 &ps_req, sizeof(ps_req), true);
 }
 
-static int
+int
 mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev,
 			 struct ieee80211_bss_conf *link_conf, bool enable)
 {
@@ -1447,12 +1484,12 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
 	int err;
 
 	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
-				&req1, sizeof(req1), false);
+				&req1, sizeof(req1), true);
 	if (err < 0 || !enable)
 		return err;
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 static void
@@ -1898,7 +1935,11 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
-	info.newly = link_sta ? state != MT76_STA_INFO_STATE_ASSOC : true;
+
+	if (link_sta)
+		info.newly = state != MT76_STA_INFO_STATE_ASSOC;
+	else
+		info.newly = state == MT76_STA_INFO_STATE_ASSOC ? false : true;
 
 	if (ieee80211_vif_is_mld(vif))
 		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
@@ -1914,32 +1955,21 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 {
 #define MT7925_FIF_BIT_CLR		BIT(1)
 #define MT7925_FIF_BIT_SET		BIT(0)
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	unsigned long valid = ieee80211_vif_is_mld(vif) ?
-				      mvif->valid_links : BIT(0);
-	struct ieee80211_bss_conf *bss_conf;
 	int err = 0;
-	int i;
 
 	if (enable) {
-		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
-			bss_conf = mt792x_vif_to_bss_conf(vif, i);
-			err = mt7925_mcu_uni_bss_bcnft(dev, bss_conf, true);
-			if (err < 0)
-				return err;
-		}
+		err = mt7925_mcu_uni_bss_bcnft(dev, &vif->bss_conf, true);
+		if (err < 0)
+			return err;
 
 		return mt7925_mcu_set_rxfilter(dev, 0,
 					       MT7925_FIF_BIT_SET,
 					       MT_WF_RFCR_DROP_OTHER_BEACON);
 	}
 
-	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
-		bss_conf = mt792x_vif_to_bss_conf(vif, i);
-		err = mt7925_mcu_set_bss_pm(dev, bss_conf, false);
-		if (err)
-			return err;
-	}
+	err = mt7925_mcu_set_bss_pm(dev, &vif->bss_conf, false);
+	if (err < 0)
+		return err;
 
 	return mt7925_mcu_set_rxfilter(dev, 0,
 				       MT7925_FIF_BIT_CLR,
@@ -1976,8 +2006,6 @@ int mt7925_get_txpwr_info(struct mt792x_dev *dev, u8 band_idx, struct mt7925_txp
 int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-
 	struct {
 		struct {
 			u8 band_idx;
@@ -1991,7 +2019,7 @@ int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed enable;
 	} __packed req = {
 		.hdr = {
-			.band_idx = mvif->bss_conf.mt76.band_idx,
+			.band_idx = 0,
 		},
 		.enable = {
 			.tag = cpu_to_le16(UNI_SNIFFER_ENABLE),
@@ -2050,7 +2078,7 @@ int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
 		} __packed tlv;
 	} __packed req = {
 		.hdr = {
-			.band_idx = vif->bss_conf.mt76.band_idx,
+			.band_idx = 0,
 		},
 		.tlv = {
 			.tag = cpu_to_le16(UNI_SNIFFER_CONFIG),
@@ -2179,11 +2207,27 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 	req = (struct bss_rlm_tlv *)tlv;
 	req->control_channel = chandef->chan->hw_value;
 	req->center_chan = ieee80211_frequency_to_channel(freq1);
-	req->center_chan2 = ieee80211_frequency_to_channel(freq2);
+	req->center_chan2 = 0;
 	req->tx_streams = hweight8(phy->antenna_mask);
 	req->ht_op_info = 4; /* set HT 40M allowed */
 	req->rx_streams = hweight8(phy->antenna_mask);
-	req->band = band;
+	req->center_chan2 = 0;
+	req->sco = 0;
+	req->band = 1;
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		req->band = 1;
+		break;
+	case NL80211_BAND_5GHZ:
+		req->band = 2;
+		break;
+	case NL80211_BAND_6GHZ:
+		req->band = 3;
+		break;
+	default:
+		break;
+	}
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_40:
@@ -2194,6 +2238,7 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		req->bw = CMD_CBW_8080MHZ;
+		req->center_chan2 = ieee80211_frequency_to_channel(freq2);
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		req->bw = CMD_CBW_160MHZ;
@@ -2463,6 +2508,7 @@ static void
 mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 		       struct ieee80211_bss_conf *link_conf)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct bss_mld_tlv *mld;
@@ -2483,7 +2529,7 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 	mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
 			     IEEE80211_EML_CAP_EMLSR_SUPP);
 
-	memcpy(mld->mac_addr, link_conf->addr, ETH_ALEN);
+	memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
 }
 
 static void
@@ -2614,7 +2660,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
-int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
+int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 {
 	struct mt76_dev *mdev = phy->dev;
 
@@ -2634,7 +2680,7 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_MBMC_SETTING, sizeof(*conf));
 	conf = (struct mbmc_conf_tlv *)tlv;
 
-	conf->mbmc_en = 1;
+	conf->mbmc_en = enable;
 	conf->band = 0; /* unused */
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SET_DBDC_PARMS),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index ac53bdc99332..fe6a613ba008 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -616,7 +616,7 @@ mt7925_mcu_get_cipher(int cipher)
 	}
 }
 
-int mt7925_mcu_set_dbdc(struct mt76_phy *phy);
+int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable);
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
 int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
@@ -643,4 +643,7 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
 				 struct ieee80211_bss_conf *link_conf);
+int
+mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev,
+			 struct ieee80211_bss_conf *link_conf, bool enable);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index f5c02e5f5066..df3c705d1cb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -242,9 +242,11 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable);
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7925_scan_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index ab12616ec2b8..2b8b9b2977f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -241,6 +241,7 @@ static inline struct mt792x_bss_conf *
 mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
 {
 	struct ieee80211_vif *vif;
+	struct mt792x_bss_conf *bss_conf;
 
 	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
 
@@ -248,8 +249,10 @@ mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
 	    link_id >= IEEE80211_LINK_UNSPECIFIED)
 		return &mvif->bss_conf;
 
-	return rcu_dereference_protected(mvif->link_conf[link_id],
-		lockdep_is_held(&mvif->phy->dev->mt76.mutex));
+	bss_conf = rcu_dereference_protected(mvif->link_conf[link_id],
+					     lockdep_is_held(&mvif->phy->dev->mt76.mutex));
+
+	return bss_conf ? bss_conf : &mvif->bss_conf;
 }
 
 static inline struct mt792x_link_sta *
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 78fe37c2e07b..b87eed4d168d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -147,7 +147,8 @@ void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
 	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mlink->wcid, false);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
+				    &mlink->wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 106273935b26..05978d9c7b91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -153,7 +153,7 @@ struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 		return NULL;
 
 	link = container_of(wcid, struct mt792x_link_sta, wcid);
-	sta = container_of(link, struct mt792x_sta, deflink);
+	sta = link->sta;
 	if (!sta->vif)
 		return NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5e96973226bb..d8a013812d1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -16,9 +16,6 @@
 
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_ADHOC)
-	}, {
 		.max = 16,
 		.types = BIT(NL80211_IFTYPE_AP)
 #ifdef CONFIG_MAC80211_MESH
@@ -85,7 +82,7 @@ static ssize_t mt7996_thermal_temp_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&phy->dev->mt76.mutex);
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 40, 130);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 40 * 1000, 130 * 1000), 1000);
 
 	/* add a safety margin ~10 */
 	if ((i - 1 == MT7996_CRIT_TEMP_IDX &&
@@ -1080,6 +1077,9 @@ mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 	he_cap_elem->phy_cap_info[2] = IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
 				       IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
 
+	he_cap_elem->phy_cap_info[7] =
+			IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
 		he_cap_elem->mac_cap_info[0] |= IEEE80211_HE_MAC_CAP0_TWT_RES;
@@ -1119,8 +1119,7 @@ mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 			IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
 			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
 		he_cap_elem->phy_cap_info[7] |=
-			IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
-			IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP;
 		he_cap_elem->phy_cap_info[8] |=
 			IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
 			IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
@@ -1190,7 +1189,9 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 
 	eht_cap_elem->mac_cap_info[0] =
 		IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
-		IEEE80211_EHT_MAC_CAP0_OM_CONTROL;
+		IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+		u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454,
+			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 
 	eht_cap_elem->phy_cap_info[0] =
 		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
@@ -1233,21 +1234,20 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK;
 
 	eht_cap_elem->phy_cap_info[4] =
+		IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI |
 		u8_encode_bits(min_t(int, sts - 1, 2),
 			       IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
 
 	eht_cap_elem->phy_cap_info[5] =
 		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US,
 			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
-		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
+		u8_encode_bits(u8_get_bits(1, GENMASK(1, 0)),
 			       IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK);
 
 	val = width == NL80211_CHAN_WIDTH_320 ? 0xf :
 	      width == NL80211_CHAN_WIDTH_160 ? 0x7 :
 	      width == NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
 	eht_cap_elem->phy_cap_info[6] =
-		u8_encode_bits(u8_get_bits(0x11, GENMASK(4, 2)),
-			       IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK) |
 		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
 
 	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0d21414e2c88..f590902fdeea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -819,6 +819,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct ieee80211_key_conf *key, int pid,
 			   enum mt76_txq_id qid, u32 changed)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
@@ -886,8 +887,9 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS;
 	if (is_mt7996(&dev->mt76))
 		val |= FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
-	else
+	else if (is_8023 || !ieee80211_is_mgmt(hdr->frame_control))
 		val |= FIELD_PREP(MT_TXD6_MSDU_CNT_V2, 1);
+
 	txwi[6] = cpu_to_le32(val);
 	txwi[7] = 0;
 
@@ -897,7 +899,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
-		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		bool mcast = ieee80211_is_data(hdr->frame_control) &&
 			     is_multicast_ether_addr(hdr->addr1);
 		u8 idx = MT7996_BASIC_RATES_TBL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 39f071ece35e..4d11083b86c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -496,8 +496,7 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 
 	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
 			     MT_WF_RFCR_DROP_RTS |
-			     MT_WF_RFCR_DROP_CTL_RSV |
-			     MT_WF_RFCR_DROP_NDPA);
+			     MT_WF_RFCR_DROP_CTL_RSV);
 
 	*total_flags = flags;
 	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6c445a9dbc03..265958f7b787 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2070,7 +2070,7 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (vif->bss_conf.vht_ldpc &&
+		if ((vif->type != NL80211_IFTYPE_AP || vif->bss_conf.vht_ldpc) &&
 		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
@@ -3666,6 +3666,13 @@ int mt7996_mcu_get_chip_config(struct mt7996_dev *dev, u32 *cap)
 
 int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch)
 {
+	enum {
+		IDX_TX_TIME,
+		IDX_RX_TIME,
+		IDX_OBSS_AIRTIME,
+		IDX_NON_WIFI_TIME,
+		IDX_NUM
+	};
 	struct {
 		struct {
 			u8 band;
@@ -3675,16 +3682,15 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch)
 			__le16 tag;
 			__le16 len;
 			__le32 offs;
-		} data[4];
+		} data[IDX_NUM];
 	} __packed req = {
 		.hdr.band = phy->mt76->band_idx,
 	};
-	/* strict order */
 	static const u32 offs[] = {
-		UNI_MIB_TX_TIME,
-		UNI_MIB_RX_TIME,
-		UNI_MIB_OBSS_AIRTIME,
-		UNI_MIB_NON_WIFI_TIME,
+		[IDX_TX_TIME] = UNI_MIB_TX_TIME,
+		[IDX_RX_TIME] = UNI_MIB_RX_TIME,
+		[IDX_OBSS_AIRTIME] = UNI_MIB_OBSS_AIRTIME,
+		[IDX_NON_WIFI_TIME] = UNI_MIB_NON_WIFI_TIME,
 	};
 	struct mt76_channel_state *state = phy->mt76->chan_state;
 	struct mt76_channel_state *state_ts = &phy->state_ts;
@@ -3693,7 +3699,7 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch)
 	struct sk_buff *skb;
 	int i, ret;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < IDX_NUM; i++) {
 		req.data[i].tag = cpu_to_le16(UNI_CMD_MIB_DATA);
 		req.data[i].len = cpu_to_le16(sizeof(req.data[i]));
 		req.data[i].offs = cpu_to_le32(offs[i]);
@@ -3712,17 +3718,24 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch)
 		goto out;
 
 #define __res_u64(s) le64_to_cpu(res[s].data)
-	state->cc_tx += __res_u64(1) - state_ts->cc_tx;
-	state->cc_bss_rx += __res_u64(2) - state_ts->cc_bss_rx;
-	state->cc_rx += __res_u64(2) + __res_u64(3) - state_ts->cc_rx;
-	state->cc_busy += __res_u64(0) + __res_u64(1) + __res_u64(2) + __res_u64(3) -
+	state->cc_tx += __res_u64(IDX_TX_TIME) - state_ts->cc_tx;
+	state->cc_bss_rx += __res_u64(IDX_RX_TIME) - state_ts->cc_bss_rx;
+	state->cc_rx += __res_u64(IDX_RX_TIME) +
+			__res_u64(IDX_OBSS_AIRTIME) -
+			state_ts->cc_rx;
+	state->cc_busy += __res_u64(IDX_TX_TIME) +
+			  __res_u64(IDX_RX_TIME) +
+			  __res_u64(IDX_OBSS_AIRTIME) +
+			  __res_u64(IDX_NON_WIFI_TIME) -
 			  state_ts->cc_busy;
-
 out:
-	state_ts->cc_tx = __res_u64(1);
-	state_ts->cc_bss_rx = __res_u64(2);
-	state_ts->cc_rx = __res_u64(2) + __res_u64(3);
-	state_ts->cc_busy = __res_u64(0) + __res_u64(1) + __res_u64(2) + __res_u64(3);
+	state_ts->cc_tx = __res_u64(IDX_TX_TIME);
+	state_ts->cc_bss_rx = __res_u64(IDX_RX_TIME);
+	state_ts->cc_rx = __res_u64(IDX_RX_TIME) + __res_u64(IDX_OBSS_AIRTIME);
+	state_ts->cc_busy = __res_u64(IDX_TX_TIME) +
+			    __res_u64(IDX_RX_TIME) +
+			    __res_u64(IDX_OBSS_AIRTIME) +
+			    __res_u64(IDX_NON_WIFI_TIME);
 #undef __res_u64
 
 	dev_kfree_skb(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 40e45fb2b626..442f72450352 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -177,7 +177,7 @@ static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 			continue;
 
 		ofs = addr - dev->reg.map[i].phys;
-		if (ofs > dev->reg.map[i].size)
+		if (ofs >= dev->reg.map[i].size)
 			continue;
 
 		return dev->reg.map[i].mapped + ofs;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 58ff06823389..f9e67b8c3b3c 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -33,9 +33,9 @@ int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
 
 		ret = usb_control_msg(udev, pipe, req, req_type, val,
 				      offset, buf, len, MT_VEND_REQ_TOUT_MS);
-		if (ret == -ENODEV)
+		if (ret == -ENODEV || ret == -EPROTO)
 			set_bit(MT76_REMOVED, &dev->phy.state);
-		if (ret >= 0 || ret == -ENODEV)
+		if (ret >= 0 || ret == -ENODEV || ret == -EPROTO)
 			return ret;
 		usleep_range(5000, 10000);
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index aab4605de9c4..ff61867d142f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -575,9 +575,15 @@ static void rtl_free_entries_from_ack_queue(struct ieee80211_hw *hw,
 
 void rtl_deinit_core(struct ieee80211_hw *hw)
 {
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
 	rtl_c2hcmd_launcher(hw, 0);
 	rtl_free_entries_from_scan_list(hw);
 	rtl_free_entries_from_ack_queue(hw, false);
+	if (rtlpriv->works.rtl_wq) {
+		destroy_workqueue(rtlpriv->works.rtl_wq);
+		rtlpriv->works.rtl_wq = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(rtl_deinit_core);
 
@@ -2696,9 +2702,6 @@ MODULE_AUTHOR("Larry Finger	<Larry.FInger@lwfinger.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 802.11n PCI wireless core");
 
-struct rtl_global_var rtl_global_var = {};
-EXPORT_SYMBOL_GPL(rtl_global_var);
-
 static int __init rtl_core_module_init(void)
 {
 	BUILD_BUG_ON(TX_PWR_BY_RATE_NUM_RATE < TX_PWR_BY_RATE_NUM_SECTION);
@@ -2712,10 +2715,6 @@ static int __init rtl_core_module_init(void)
 	/* add debugfs */
 	rtl_debugfs_add_topdir();
 
-	/* init some global vars */
-	INIT_LIST_HEAD(&rtl_global_var.glb_priv_list);
-	spin_lock_init(&rtl_global_var.glb_list_lock);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index f081a9a90563..f3a6a43a42ec 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -124,7 +124,6 @@ int rtl_send_smps_action(struct ieee80211_hw *hw,
 u8 *rtl_find_ie(u8 *data, unsigned int len, u8 ie);
 void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len);
 u8 rtl_tid_to_ac(u8 tid);
-extern struct rtl_global_var rtl_global_var;
 void rtl_phy_scan_operation_backup(struct ieee80211_hw *hw, u8 operation);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 11709b6c83f1..0eafc4d125f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -295,46 +295,6 @@ static bool rtl_pci_get_amd_l1_patch(struct ieee80211_hw *hw)
 	return status;
 }
 
-static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
-				     struct rtl_priv **buddy_priv)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
-	struct rtl_priv *tpriv = NULL, *iter;
-	struct rtl_pci_priv *tpcipriv = NULL;
-
-	if (!list_empty(&rtlpriv->glb_var->glb_priv_list)) {
-		list_for_each_entry(iter, &rtlpriv->glb_var->glb_priv_list,
-				    list) {
-			tpcipriv = (struct rtl_pci_priv *)iter->priv;
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-				"pcipriv->ndis_adapter.funcnumber %x\n",
-				pcipriv->ndis_adapter.funcnumber);
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-				"tpcipriv->ndis_adapter.funcnumber %x\n",
-				tpcipriv->ndis_adapter.funcnumber);
-
-			if (pcipriv->ndis_adapter.busnumber ==
-			    tpcipriv->ndis_adapter.busnumber &&
-			    pcipriv->ndis_adapter.devnumber ==
-			    tpcipriv->ndis_adapter.devnumber &&
-			    pcipriv->ndis_adapter.funcnumber !=
-			    tpcipriv->ndis_adapter.funcnumber) {
-				tpriv = iter;
-				break;
-			}
-		}
-	}
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"find_buddy_priv %d\n", tpriv != NULL);
-
-	if (tpriv)
-		*buddy_priv = tpriv;
-
-	return tpriv != NULL;
-}
-
 static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 					struct ieee80211_hw *hw)
 {
@@ -1696,8 +1656,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 	synchronize_irq(rtlpci->pdev->irq);
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
-
-	destroy_workqueue(rtlpriv->works.rtl_wq);
 }
 
 static int rtl_pci_init(struct ieee80211_hw *hw, struct pci_dev *pdev)
@@ -2011,7 +1969,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
-	list_add_tail(&rtlpriv->list, &rtlpriv->glb_var->glb_priv_list);
 
 	return true;
 }
@@ -2158,7 +2115,6 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	rtlpriv->rtlhal.interface = INTF_PCI;
 	rtlpriv->cfg = (struct rtl_hal_cfg *)(id->driver_data);
 	rtlpriv->intf_ops = &rtl_pci_ops;
-	rtlpriv->glb_var = &rtl_global_var;
 	rtl_efuse_ops_init(hw);
 
 	/* MEM map */
@@ -2209,7 +2165,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
 		pr_err("Can't init_sw_vars\n");
 		err = -ENODEV;
-		goto fail3;
+		goto fail2;
 	}
 	rtl_init_sw_leds(hw);
 
@@ -2227,14 +2183,14 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	err = rtl_pci_init(hw, pdev);
 	if (err) {
 		pr_err("Failed to init PCI\n");
-		goto fail3;
+		goto fail4;
 	}
 
 	err = ieee80211_register_hw(hw);
 	if (err) {
 		pr_err("Can't register mac80211 hw.\n");
 		err = -ENODEV;
-		goto fail3;
+		goto fail5;
 	}
 	rtlpriv->mac80211.mac80211_registered = 1;
 
@@ -2257,16 +2213,19 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
 	return 0;
 
-fail3:
-	pci_set_drvdata(pdev, NULL);
+fail5:
+	rtl_pci_deinit(hw);
+fail4:
 	rtl_deinit_core(hw);
+fail3:
+	wait_for_completion(&rtlpriv->firmware_loading_complete);
+	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 
 fail2:
 	if (rtlpriv->io.pci_mem_start != 0)
 		pci_iounmap(pdev, (void __iomem *)rtlpriv->io.pci_mem_start);
 
 	pci_release_regions(pdev);
-	complete(&rtlpriv->firmware_loading_complete);
 
 fail1:
 	if (hw)
@@ -2317,7 +2276,6 @@ void rtl_pci_disconnect(struct pci_dev *pdev)
 	if (rtlpci->using_msi)
 		pci_disable_msi(rtlpci->pdev);
 
-	list_del(&rtlpriv->list);
 	if (rtlpriv->io.pci_mem_start != 0) {
 		pci_iounmap(pdev, (void __iomem *)rtlpriv->io.pci_mem_start);
 		pci_release_regions(pdev);
@@ -2376,7 +2334,6 @@ EXPORT_SYMBOL(rtl_pci_resume);
 const struct rtl_intf_ops rtl_pci_ops = {
 	.adapter_start = rtl_pci_start,
 	.adapter_stop = rtl_pci_stop,
-	.check_buddy_priv = rtl_pci_check_buddy_priv,
 	.adapter_tx = rtl_pci_tx,
 	.flush = rtl_pci_flush,
 	.reset_trx_ring = rtl_pci_reset_trx_ring,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index bbf8ff63dced..e63c67b1861b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -64,22 +64,23 @@ static void rtl92se_fw_cb(const struct firmware *firmware, void *context)
 
 	rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
 		"Firmware callback routine entered!\n");
-	complete(&rtlpriv->firmware_loading_complete);
 	if (!firmware) {
 		pr_err("Firmware %s not available\n", fw_name);
 		rtlpriv->max_fw_size = 0;
-		return;
+		goto exit;
 	}
 	if (firmware->size > rtlpriv->max_fw_size) {
 		pr_err("Firmware is too big!\n");
 		rtlpriv->max_fw_size = 0;
 		release_firmware(firmware);
-		return;
+		goto exit;
 	}
 	pfirmware = (struct rt_firmware *)rtlpriv->rtlhal.pfirmware;
 	memcpy(pfirmware->sz_fw_tmpbuffer, firmware->data, firmware->size);
 	pfirmware->sz_fw_tmpbufferlen = firmware->size;
 	release_firmware(firmware);
+exit:
+	complete(&rtlpriv->firmware_loading_complete);
 }
 
 static int rtl92s_init_sw_vars(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 1be51ea3f3c8..9eddbada8af1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -2033,8 +2033,10 @@ static bool _rtl8821ae_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 			if (!_rtl8821ae_check_condition(hw, v1)) {
 				i += 2; /* skip the pair of expression*/
 				v2 = array[i+1];
-				while (v2 != 0xDEAD)
+				while (v2 != 0xDEAD) {
 					i += 3;
+					v2 = array[i + 1];
+				}
 			}
 		}
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index d37a017b2b81..f5718e570011 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -629,11 +629,6 @@ static void _rtl_usb_cleanup_rx(struct ieee80211_hw *hw)
 	tasklet_kill(&rtlusb->rx_work_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 
-	if (rtlpriv->works.rtl_wq) {
-		destroy_workqueue(rtlpriv->works.rtl_wq);
-		rtlpriv->works.rtl_wq = NULL;
-	}
-
 	skb_queue_purge(&rtlusb->rx_queue);
 
 	while ((urb = usb_get_from_anchor(&rtlusb->rx_cleanup_urbs))) {
@@ -1028,19 +1023,22 @@ int rtl_usb_probe(struct usb_interface *intf,
 	err = ieee80211_register_hw(hw);
 	if (err) {
 		pr_err("Can't register mac80211 hw.\n");
-		goto error_out;
+		goto error_init_vars;
 	}
 	rtlpriv->mac80211.mac80211_registered = 1;
 
 	set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
 	return 0;
 
+error_init_vars:
+	wait_for_completion(&rtlpriv->firmware_loading_complete);
+	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 error_out:
+	rtl_usb_deinit(hw);
 	rtl_deinit_core(hw);
 error_out2:
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
-	complete(&rtlpriv->firmware_loading_complete);
 	kfree(rtlpriv->usb_data);
 	ieee80211_free_hw(hw);
 	return -ENODEV;
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index ae6e351bc83c..f1830ddcdd8c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2270,8 +2270,6 @@ struct rtl_intf_ops {
 	/*com */
 	int (*adapter_start)(struct ieee80211_hw *hw);
 	void (*adapter_stop)(struct ieee80211_hw *hw);
-	bool (*check_buddy_priv)(struct ieee80211_hw *hw,
-				 struct rtl_priv **buddy_priv);
 
 	int (*adapter_tx)(struct ieee80211_hw *hw,
 			  struct ieee80211_sta *sta,
@@ -2514,14 +2512,6 @@ struct dig_t {
 	u32 rssi_max;
 };
 
-struct rtl_global_var {
-	/* from this list we can get
-	 * other adapter's rtl_priv
-	 */
-	struct list_head glb_priv_list;
-	spinlock_t glb_list_lock;
-};
-
 #define IN_4WAY_TIMEOUT_TIME	(30 * MSEC_PER_SEC)	/* 30 seconds */
 
 struct rtl_btc_info {
@@ -2667,9 +2657,7 @@ struct rtl_scan_list {
 struct rtl_priv {
 	struct ieee80211_hw *hw;
 	struct completion firmware_loading_complete;
-	struct list_head list;
 	struct rtl_priv *buddy_priv;
-	struct rtl_global_var *glb_var;
 	struct rtl_dmsp_ctl dmsp_ctl;
 	struct rtl_locks locks;
 	struct rtl_works works;
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index ba6332da8019..4df4e04c3e67 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -10,6 +10,10 @@
 #include "ps.h"
 #include "util.h"
 
+static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
+			       enum rtw89_chanctx_idx idx1,
+			       enum rtw89_chanctx_idx idx2);
+
 static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
 						 u8 center_chan)
 {
@@ -226,11 +230,15 @@ static void rtw89_config_default_chandef(struct rtw89_dev *rtwdev)
 void rtw89_entity_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 
 	hal->entity_pause = false;
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_CHANCTX);
 	bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	atomic_set(&hal->roc_chanctx_idx, RTW89_CHANCTX_IDLE);
+
+	INIT_LIST_HEAD(&mgnt->active_list);
+
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -272,6 +280,143 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_normalize_link_chanctx(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_vif_link *cur;
+
+	if (unlikely(!rtwvif_link->chanctx_assigned))
+		return;
+
+	cur = rtw89_vif_get_link_inst(rtwvif, 0);
+	if (!cur || !cur->chanctx_assigned)
+		return;
+
+	if (cur == rtwvif_link)
+		return;
+
+	rtw89_swap_chanctx(rtwdev, rtwvif_link->chanctx_idx, cur->chanctx_idx);
+}
+
+const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
+					       const char *caller_message,
+					       u8 link_index)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
+	enum rtw89_chanctx_idx chanctx_idx;
+	enum rtw89_chanctx_idx roc_idx;
+	enum rtw89_entity_mode mode;
+	u8 role_index;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (unlikely(link_index >= __RTW89_MLD_MAX_LINK_NUM)) {
+		WARN(1, "link index %u is invalid (max link inst num: %d)\n",
+		     link_index, __RTW89_MLD_MAX_LINK_NUM);
+		goto dflt;
+	}
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_SCC_OR_SMLD:
+	case RTW89_ENTITY_MODE_MCC:
+		role_index = 0;
+		break;
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		role_index = 1;
+		break;
+	default:
+		WARN(1, "Invalid ent mode: %d\n", mode);
+		goto dflt;
+	}
+
+	chanctx_idx = mgnt->chanctx_tbl[role_index][link_index];
+	if (chanctx_idx == RTW89_CHANCTX_IDLE)
+		goto dflt;
+
+	roc_idx = atomic_read(&hal->roc_chanctx_idx);
+	if (roc_idx != RTW89_CHANCTX_IDLE) {
+		/* ROC is ongoing (given ROC runs on RTW89_ROC_BY_LINK_INDEX).
+		 * If @link_index is the same as RTW89_ROC_BY_LINK_INDEX, get
+		 * the ongoing ROC chanctx.
+		 */
+		if (link_index == RTW89_ROC_BY_LINK_INDEX)
+			chanctx_idx = roc_idx;
+	}
+
+	return rtw89_chan_get(rtwdev, chanctx_idx);
+
+dflt:
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "%s (%s): prefetch NULL on link index %u\n",
+		    __func__, caller_message ?: "", link_index);
+
+	return rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+}
+EXPORT_SYMBOL(__rtw89_mgnt_chan_get);
+
+static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
+	struct rtw89_vif_link *link;
+	struct rtw89_vif *role;
+	u8 pos = 0;
+	int i, j;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++)
+		mgnt->active_roles[i] = NULL;
+
+	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++) {
+		for (j = 0; j < __RTW89_MLD_MAX_LINK_NUM; j++)
+			mgnt->chanctx_tbl[i][j] = RTW89_CHANCTX_IDLE;
+	}
+
+	/* To be consistent with legacy behavior, expect the first active role
+	 * which uses RTW89_CHANCTX_0 to put at position 0, and make its first
+	 * link instance take RTW89_CHANCTX_0. (normalizing)
+	 */
+	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
+		for (i = 0; i < role->links_inst_valid_num; i++) {
+			link = rtw89_vif_get_link_inst(role, i);
+			if (!link || !link->chanctx_assigned)
+				continue;
+
+			if (link->chanctx_idx == RTW89_CHANCTX_0) {
+				rtw89_normalize_link_chanctx(rtwdev, link);
+
+				list_del(&role->mgnt_entry);
+				list_add(&role->mgnt_entry, &mgnt->active_list);
+				goto fill;
+			}
+		}
+	}
+
+fill:
+	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
+		if (unlikely(pos >= RTW89_MAX_INTERFACE_NUM)) {
+			rtw89_warn(rtwdev,
+				   "%s: active roles are over max iface num\n",
+				   __func__);
+			break;
+		}
+
+		for (i = 0; i < role->links_inst_valid_num; i++) {
+			link = rtw89_vif_get_link_inst(role, i);
+			if (!link || !link->chanctx_assigned)
+				continue;
+
+			mgnt->chanctx_tbl[pos][i] = link->chanctx_idx;
+		}
+
+		mgnt->active_roles[pos++] = role;
+	}
+}
+
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 {
 	DECLARE_BITMAP(recalc_map, NUM_OF_RTW89_CHANCTX) = {};
@@ -298,9 +443,14 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		set_bit(RTW89_CHANCTX_0, recalc_map);
 		fallthrough;
 	case 1:
-		mode = RTW89_ENTITY_MODE_SCC;
+		mode = RTW89_ENTITY_MODE_SCC_OR_SMLD;
 		break;
 	case 2 ... NUM_OF_RTW89_CHANCTX:
+		if (w.active_roles == 1) {
+			mode = RTW89_ENTITY_MODE_SCC_OR_SMLD;
+			break;
+		}
+
 		if (w.active_roles != NUM_OF_RTW89_MCC_ROLES) {
 			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 				    "unhandled ent: %d chanctxs %d roles\n",
@@ -327,6 +477,8 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		rtw89_assign_entity_chan(rtwdev, idx, &chan);
 	}
 
+	rtw89_entity_recalc_mgnt_roles(rtwdev);
+
 	if (hal->entity_pause)
 		return rtw89_get_entity_mode(rtwdev);
 
@@ -650,7 +802,7 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 
 	mcc_role->limit.max_toa = max_toa_us / 1024;
 	mcc_role->limit.max_tob = max_tob_us / 1024;
-	mcc_role->limit.max_dur = max_dur_us / 1024;
+	mcc_role->limit.max_dur = mcc_role->limit.max_toa + mcc_role->limit.max_tob;
 	mcc_role->limit.enable = true;
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
@@ -716,6 +868,7 @@ struct rtw89_mcc_fill_role_selector {
 };
 
 static_assert((u8)NUM_OF_RTW89_CHANCTX >= NUM_OF_RTW89_MCC_ROLES);
+static_assert(RTW89_MAX_INTERFACE_NUM >= NUM_OF_RTW89_MCC_ROLES);
 
 static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *mcc_role,
@@ -745,14 +898,18 @@ static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 
 static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_mcc_fill_role_selector sel = {};
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_vif *rtwvif;
 	int ret;
+	int i;
 
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		if (!rtw89_vif_is_active_role(rtwvif))
-			continue;
+	for (i = 0; i < NUM_OF_RTW89_MCC_ROLES; i++) {
+		rtwvif = mgnt->active_roles[i];
+		if (!rtwvif)
+			break;
 
 		rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 		if (unlikely(!rtwvif_link)) {
@@ -760,14 +917,7 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 			continue;
 		}
 
-		if (sel.bind_vif[rtwvif_link->chanctx_idx]) {
-			rtw89_warn(rtwdev,
-				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
-				   rtwvif_link->mac_id, rtwvif_link->chanctx_idx);
-			continue;
-		}
-
-		sel.bind_vif[rtwvif_link->chanctx_idx] = rtwvif_link;
+		sel.bind_vif[i] = rtwvif_link;
 	}
 
 	ret = rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_fill_role_iterator, &sel);
@@ -2381,7 +2531,25 @@ void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 	hal->entity_pause = true;
 }
 
-void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
+static void rtw89_chanctx_proceed_cb(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chanctx_cb_parm *parm)
+{
+	int ret;
+
+	if (!parm || !parm->cb)
+		return;
+
+	ret = parm->cb(rtwdev, parm->data);
+	if (ret)
+		rtw89_warn(rtwdev, "%s (%s): cb failed: %d\n", __func__,
+			   parm->caller ?: "unknown", ret);
+}
+
+/* pass @cb_parm if there is a @cb_parm->cb which needs to invoke right after
+ * call rtw89_set_channel() and right before proceed entity according to mode.
+ */
+void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
+			   const struct rtw89_chanctx_cb_parm *cb_parm)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
@@ -2389,14 +2557,18 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	if (!hal->entity_pause)
+	if (unlikely(!hal->entity_pause)) {
+		rtw89_chanctx_proceed_cb(rtwdev, cb_parm);
 		return;
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "chanctx proceed\n");
 
 	hal->entity_pause = false;
 	rtw89_set_channel(rtwdev);
 
+	rtw89_chanctx_proceed_cb(rtwdev, cb_parm);
+
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC:
@@ -2501,12 +2673,18 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_entity_weight w = {};
 
 	rtwvif_link->chanctx_idx = cfg->idx;
 	rtwvif_link->chanctx_assigned = true;
 	cfg->ref_count++;
 
+	if (list_empty(&rtwvif->mgnt_entry))
+		list_add_tail(&rtwvif->mgnt_entry, &mgnt->active_list);
+
 	if (cfg->idx == RTW89_CHANCTX_0)
 		goto out;
 
@@ -2526,6 +2704,7 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_chanctx_idx roll;
 	enum rtw89_entity_mode cur;
@@ -2536,6 +2715,9 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 	rtwvif_link->chanctx_assigned = false;
 	cfg->ref_count--;
 
+	if (!rtw89_vif_is_active_role(rtwvif))
+		list_del_init(&rtwvif->mgnt_entry);
+
 	if (cfg->ref_count != 0)
 		goto out;
 
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 4ed777ea5064..092a6f676894 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -38,23 +38,32 @@ enum rtw89_chanctx_pause_reasons {
 	RTW89_CHANCTX_PAUSE_REASON_ROC,
 };
 
+struct rtw89_chanctx_cb_parm {
+	int (*cb)(struct rtw89_dev *rtwdev, void *data);
+	void *data;
+	const char *caller;
+};
+
 struct rtw89_entity_weight {
 	unsigned int active_chanctxs;
 	unsigned int active_roles;
 };
 
-static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
+static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return READ_ONCE(hal->entity_active);
+	return READ_ONCE(hal->entity_active[phy_idx]);
 }
 
-static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev, bool active)
+static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy_idx,
+					  bool active)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	WRITE_ONCE(hal->entity_active, active);
+	WRITE_ONCE(hal->entity_active[phy_idx], active);
 }
 
 static inline
@@ -97,7 +106,16 @@ void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
 void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 			 enum rtw89_chanctx_pause_reasons rsn);
-void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev);
+void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
+			   const struct rtw89_chanctx_cb_parm *cb_parm);
+
+const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
+					       const char *caller_message,
+					       u8 link_index);
+
+#define rtw89_mgnt_chan_get(rtwdev, link_index) \
+	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5b8e65f6de6a..f82a26be6fa8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -192,13 +192,13 @@ static const struct ieee80211_iface_combination rtw89_iface_combs[] = {
 	{
 		.limits = rtw89_iface_limits,
 		.n_limits = ARRAY_SIZE(rtw89_iface_limits),
-		.max_interfaces = 2,
+		.max_interfaces = RTW89_MAX_INTERFACE_NUM,
 		.num_different_channels = 1,
 	},
 	{
 		.limits = rtw89_iface_limits_mcc,
 		.n_limits = ARRAY_SIZE(rtw89_iface_limits_mcc),
-		.max_interfaces = 2,
+		.max_interfaces = RTW89_MAX_INTERFACE_NUM,
 		.num_different_channels = 2,
 	},
 };
@@ -341,83 +341,47 @@ void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 	rtw89_chan_create(chan, center_chan, channel->hw_value, band, bandwidth);
 }
 
-void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
+static void __rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_phy_idx phy_idx)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_chan *chan;
-	enum rtw89_chanctx_idx chanctx_idx;
-	enum rtw89_chanctx_idx roc_idx;
-	enum rtw89_phy_idx phy_idx;
-	enum rtw89_entity_mode mode;
 	bool entity_active;
 
-	entity_active = rtw89_get_entity_state(rtwdev);
+	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
 	if (!entity_active)
 		return;
 
-	mode = rtw89_get_entity_mode(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_SCC:
-	case RTW89_ENTITY_MODE_MCC:
-		chanctx_idx = RTW89_CHANCTX_0;
-		break;
-	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		chanctx_idx = RTW89_CHANCTX_1;
-		break;
-	default:
-		WARN(1, "Invalid ent mode: %d\n", mode);
-		return;
-	}
+	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
+}
 
-	roc_idx = atomic_read(&hal->roc_chanctx_idx);
-	if (roc_idx != RTW89_CHANCTX_IDLE)
-		chanctx_idx = roc_idx;
+void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan;
 
-	phy_idx = RTW89_PHY_0;
-	chan = rtw89_chan_get(rtwdev, chanctx_idx);
-	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
+	chan = rtw89_mgnt_chan_get(rtwdev, 0);
+	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_0);
+
+	if (!rtwdev->support_mlo)
+		return;
+
+	chan = rtw89_mgnt_chan_get(rtwdev, 1);
+	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_1);
 }
 
-int rtw89_set_channel(struct rtw89_dev *rtwdev)
+static void __rtw89_set_channel(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_mac_idx mac_idx,
+				enum rtw89_phy_idx phy_idx)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan_rcd *chan_rcd;
-	const struct rtw89_chan *chan;
-	enum rtw89_chanctx_idx chanctx_idx;
-	enum rtw89_chanctx_idx roc_idx;
-	enum rtw89_mac_idx mac_idx;
-	enum rtw89_phy_idx phy_idx;
 	struct rtw89_channel_help_params bak;
-	enum rtw89_entity_mode mode;
 	bool entity_active;
 
-	entity_active = rtw89_get_entity_state(rtwdev);
-
-	mode = rtw89_entity_recalc(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_SCC:
-	case RTW89_ENTITY_MODE_MCC:
-		chanctx_idx = RTW89_CHANCTX_0;
-		break;
-	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		chanctx_idx = RTW89_CHANCTX_1;
-		break;
-	default:
-		WARN(1, "Invalid ent mode: %d\n", mode);
-		return -EINVAL;
-	}
-
-	roc_idx = atomic_read(&hal->roc_chanctx_idx);
-	if (roc_idx != RTW89_CHANCTX_IDLE)
-		chanctx_idx = roc_idx;
+	entity_active = rtw89_get_entity_state(rtwdev, phy_idx);
 
-	mac_idx = RTW89_MAC_0;
-	phy_idx = RTW89_PHY_0;
-
-	chan = rtw89_chan_get(rtwdev, chanctx_idx);
-	chan_rcd = rtw89_chan_rcd_get(rtwdev, chanctx_idx);
+	chan_rcd = rtw89_chan_rcd_get_by_chan(chan);
 
 	rtw89_chip_set_channel_prepare(rtwdev, &bak, chan, mac_idx, phy_idx);
 
@@ -432,7 +396,29 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 		rtw89_chip_rfk_band_changed(rtwdev, phy_idx, chan);
 	}
 
-	rtw89_set_entity_state(rtwdev, true);
+	rtw89_set_entity_state(rtwdev, phy_idx, true);
+}
+
+int rtw89_set_channel(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan;
+	enum rtw89_entity_mode mode;
+
+	mode = rtw89_entity_recalc(rtwdev);
+	if (mode < 0 || mode >= NUM_OF_RTW89_ENTITY_MODE) {
+		WARN(1, "Invalid ent mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	chan = rtw89_mgnt_chan_get(rtwdev, 0);
+	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_0, RTW89_PHY_0);
+
+	if (!rtwdev->support_mlo)
+		return 0;
+
+	chan = rtw89_mgnt_chan_get(rtwdev, 1);
+	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_1, RTW89_PHY_1);
+
 	return 0;
 }
 
@@ -3157,9 +3143,10 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, RTW89_ROC_BY_LINK_INDEX);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "roc start: find no link on HW-0\n");
+		rtw89_err(rtwdev, "roc start: find no link on HW-%u\n",
+			  RTW89_ROC_BY_LINK_INDEX);
 		return;
 	}
 
@@ -3211,9 +3198,10 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, RTW89_ROC_BY_LINK_INDEX);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "roc end: find no link on HW-0\n");
+		rtw89_err(rtwdev, "roc end: find no link on HW-%u\n",
+			  RTW89_ROC_BY_LINK_INDEX);
 		return;
 	}
 
@@ -3224,7 +3212,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, NULL);
-	rtw89_chanctx_proceed(rtwdev);
+	rtw89_chanctx_proceed(rtwdev, NULL);
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, false);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index de33320b1354..ff3048d2489f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3424,6 +3424,8 @@ enum rtw89_roc_state {
 	RTW89_ROC_MGMT,
 };
 
+#define RTW89_ROC_BY_LINK_INDEX 0
+
 struct rtw89_roc {
 	struct ieee80211_channel chan;
 	struct delayed_work roc_work;
@@ -4619,7 +4621,7 @@ enum rtw89_chanctx_changes {
 };
 
 enum rtw89_entity_mode {
-	RTW89_ENTITY_MODE_SCC,
+	RTW89_ENTITY_MODE_SCC_OR_SMLD,
 	RTW89_ENTITY_MODE_MCC_PREPARE,
 	RTW89_ENTITY_MODE_MCC,
 
@@ -4628,6 +4630,16 @@ enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_UNHANDLED = -ESRCH,
 };
 
+#define RTW89_MAX_INTERFACE_NUM 2
+
+/* only valid when running with chanctx_ops */
+struct rtw89_entity_mgnt {
+	struct list_head active_list;
+	struct rtw89_vif *active_roles[RTW89_MAX_INTERFACE_NUM];
+	enum rtw89_chanctx_idx chanctx_tbl[RTW89_MAX_INTERFACE_NUM]
+					  [__RTW89_MLD_MAX_LINK_NUM];
+};
+
 struct rtw89_chanctx {
 	struct cfg80211_chan_def chandef;
 	struct rtw89_chan chan;
@@ -4668,9 +4680,10 @@ struct rtw89_hal {
 	struct rtw89_chanctx chanctx[NUM_OF_RTW89_CHANCTX];
 	struct cfg80211_chan_def roc_chandef;
 
-	bool entity_active;
+	bool entity_active[RTW89_PHY_MAX];
 	bool entity_pause;
 	enum rtw89_entity_mode entity_mode;
+	struct rtw89_entity_mgnt entity_mgnt;
 
 	struct rtw89_edcca_bak edcca_bak;
 	u32 disabled_dm_bitmap; /* bitmap of enum rtw89_dm_type */
@@ -5607,6 +5620,7 @@ struct rtw89_dev {
 struct rtw89_vif {
 	struct rtw89_dev *rtwdev;
 	struct list_head list;
+	struct list_head mgnt_entry;
 
 	u8 mac_addr[ETH_ALEN];
 	__be32 ip_addr;
@@ -6361,6 +6375,15 @@ const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
 	return &hal->chanctx[idx].rcd;
 }
 
+static inline
+const struct rtw89_chan_rcd *rtw89_chan_rcd_get_by_chan(const struct rtw89_chan *chan)
+{
+	const struct rtw89_chanctx *chanctx =
+		container_of_const(chan, struct rtw89_chanctx, chan);
+
+	return &chanctx->rcd;
+}
+
 static inline
 const struct rtw89_chan *rtw89_scan_chan_get(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e6bceef691e9..620e076d1b59 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6637,21 +6637,24 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
 }
 
-void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
-			    struct rtw89_vif_link *rtwvif_link,
-			    bool aborted)
+struct rtw89_hw_scan_complete_cb_data {
+	struct rtw89_vif_link *rtwvif_link;
+	bool aborted;
+};
+
+static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_hw_scan_complete_cb_data *cb_data = data;
+	struct rtw89_vif_link *rtwvif_link = cb_data->rtwvif_link;
 	struct cfg80211_scan_info info = {
-		.aborted = aborted,
+		.aborted = cb_data->aborted,
 	};
 	struct rtw89_vif *rtwvif;
 
 	if (!rtwvif_link)
-		return;
-
-	rtw89_chanctx_proceed(rtwdev);
+		return -EINVAL;
 
 	rtwvif = rtwvif_link->rtwvif;
 
@@ -6672,6 +6675,29 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
 	scan_info->abort = false;
+
+	return 0;
+}
+
+void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
+			    struct rtw89_vif_link *rtwvif_link,
+			    bool aborted)
+{
+	struct rtw89_hw_scan_complete_cb_data cb_data = {
+		.rtwvif_link = rtwvif_link,
+		.aborted = aborted,
+	};
+	const struct rtw89_chanctx_cb_parm cb_parm = {
+		.cb = rtw89_hw_scan_complete_cb,
+		.data = &cb_data,
+		.caller = __func__,
+	};
+
+	/* The things here needs to be done after setting channel (for coex)
+	 * and before proceeding entity mode (for MCC). So, pass a callback
+	 * of them for the right sequence rather than doing them directly.
+	 */
+	rtw89_chanctx_proceed(rtwdev, &cb_parm);
 }
 
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4e15d539e3d1..4574aa62839b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1483,7 +1483,8 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_PWR_MAJOR);
-		rtw89_set_entity_state(rtwdev, false);
+		rtw89_set_entity_state(rtwdev, RTW89_PHY_0, false);
+		rtw89_set_entity_state(rtwdev, RTW89_PHY_1, false);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 13fb3cac2701..8351a70d325d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -189,8 +189,10 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
-	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif)) {
 		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+		INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+	}
 
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 
@@ -1271,11 +1273,11 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
 
-	if (!rtwdev->scanning)
-		return;
-
 	mutex_lock(&rtwdev->mutex);
 
+	if (!rtwdev->scanning)
+		goto out;
+
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "cancel hw scan: find no link on HW-0\n");
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 0c77b8524160..42805ed7ca12 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2612,24 +2612,24 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 	if (test_bit(WL1271_FLAG_RECOVERY_IN_PROGRESS, &wl->flags) ||
 	    test_bit(WLVIF_FLAG_INITIALIZED, &wlvif->flags)) {
 		ret = -EBUSY;
-		goto out;
+		goto out_unlock;
 	}
 
 
 	ret = wl12xx_init_vif_data(wl, vif);
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 
 	wlvif->wl = wl;
 	role_type = wl12xx_get_role_type(wl, wlvif);
 	if (role_type == WL12XX_INVALID_ROLE_TYPE) {
 		ret = -EINVAL;
-		goto out;
+		goto out_unlock;
 	}
 
 	ret = wlcore_allocate_hw_queue_base(wl, wlvif);
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 
 	/*
 	 * TODO: after the nvs issue will be solved, move this block
@@ -2644,7 +2644,7 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 
 		ret = wl12xx_init_fw(wl);
 		if (ret < 0)
-			goto out;
+			goto out_unlock;
 	}
 
 	/*
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 249914b90dbf..4c409efd8cec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3085,7 +3085,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-	struct nvme_effects_log	*cel = xa_load(&ctrl->cels, csi);
+	struct nvme_effects_log *old, *cel = xa_load(&ctrl->cels, csi);
 	int ret;
 
 	if (cel)
@@ -3102,7 +3102,11 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 		return ret;
 	}
 
-	xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
+	old = xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		kfree(cel);
+		return xa_err(old);
+	}
 out:
 	*log = cel;
 	return 0;
@@ -3164,6 +3168,25 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
+		u8 csi, struct nvme_effects_log **log)
+{
+	struct nvme_effects_log *effects, *old;
+
+	effects = kzalloc(sizeof(*effects), GFP_KERNEL);
+	if (!effects)
+		return -ENOMEM;
+
+	old = xa_store(&ctrl->cels, csi, effects, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		kfree(effects);
+		return xa_err(old);
+	}
+
+	*log = effects;
+	return 0;
+}
+
 static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 {
 	struct nvme_effects_log	*log = ctrl->effects;
@@ -3210,10 +3233,9 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	}
 
 	if (!ctrl->effects) {
-		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
-		if (!ctrl->effects)
-			return -ENOMEM;
-		xa_store(&ctrl->cels, NVME_CSI_NVM, ctrl->effects, GFP_KERNEL);
+		ret = nvme_init_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
+		if (ret < 0)
+			return ret;
 	}
 
 	nvme_init_known_nvm_effects(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55abfe5e1d25..8305d3c12807 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -54,6 +54,8 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -127,6 +129,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_IO_CPU_SET	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -1562,23 +1565,56 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
+/**
+ * Track the number of queues assigned to each cpu using a global per-cpu
+ * counter and select the least used cpu from the mq_map. Our goal is to spread
+ * different controllers I/O threads across different cpu cores.
+ *
+ * Note that the accounting is not 100% perfect, but we don't need to be, we're
+ * simply putting our best effort to select the best candidate cpu core that we
+ * find at any given point.
+ */
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
-	int n = 0;
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map = NULL;
+	int cpu, min_queues = INT_MAX, io_cpu;
+
+	if (wq_unbound)
+		goto out;
 
 	if (nvme_tcp_default_queue(queue))
-		n = qid - 1;
+		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
 	else if (nvme_tcp_read_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
+		mq_map = set->map[HCTX_TYPE_READ].mq_map;
 	else if (nvme_tcp_poll_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
-				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	if (wq_unbound)
-		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
+
+	if (WARN_ON(!mq_map))
+		goto out;
+
+	/* Search for the least used cpu from the mq_map */
+	io_cpu = WORK_CPU_UNBOUND;
+	for_each_online_cpu(cpu) {
+		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+
+		if (mq_map[cpu] != qid)
+			continue;
+		if (num_queues < min_queues) {
+			io_cpu = cpu;
+			min_queues = num_queues;
+		}
+	}
+	if (io_cpu != WORK_CPU_UNBOUND) {
+		queue->io_cpu = io_cpu;
+		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
+		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
+	}
+out:
+	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+		qid, queue->io_cpu);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1722,7 +1758,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1844,6 +1880,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
@@ -1878,9 +1917,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
+		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+	} else
 		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
@@ -2856,6 +2896,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -2873,6 +2914,9 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu)
+		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 546e76ac407c..8c80f4dc8b3f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -8,7 +8,6 @@
 
 #define pr_fmt(fmt)	"OF: fdt: " fmt
 
-#include <linux/acpi.h>
 #include <linux/crash_dump.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
@@ -512,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1214,14 +1211,10 @@ void __init unflatten_device_tree(void)
 {
 	void *fdt = initial_boot_params;
 
-	/* Don't use the bootloader provided DTB if ACPI is enabled */
-	if (!acpi_disabled)
-		fdt = NULL;
+	/* Save the statically-placed regions in the reserved_mem array */
+	fdt_scan_reserved_mem_reg_nodes();
 
-	/*
-	 * Populate an empty root node when ACPI is enabled or bootloader
-	 * doesn't provide one.
-	 */
+	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
 		fdt = (void *) __dtb_empty_root_begin;
 		/* fdt_totalsize() will be used for copy size */
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index c235d6c909a1..106988622525 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -9,6 +9,7 @@
  */
 
 #define FDT_ALIGN_SIZE 8
+#define MAX_RESERVED_REGIONS    64
 
 /**
  * struct alias_prop - Alias property in 'aliases' node
@@ -183,7 +184,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void fdt_init_reserved_mem(void);
+void __init fdt_scan_reserved_mem_reg_nodes(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46e1c3fbc769..45445a1600a9 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -51,11 +50,13 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 			memblock_phys_free(base, size);
 	}
 
-	kmemleak_ignore_phys(base);
+	if (!err)
+		kmemleak_ignore_phys(base);
 
 	return err;
 }
 
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem);
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -74,6 +75,9 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 	rmem->base = base;
 	rmem->size = size;
 
+	/* Call the region specific initialization function */
+	fdt_init_reserved_mem_node(rmem);
+
 	reserved_mem_count++;
 	return;
 }
@@ -106,7 +110,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int first = 1;
 	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
@@ -134,10 +137,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
@@ -165,12 +164,82 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+static void __init __rmem_check_for_overlap(void);
+
+/**
+ * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * reserved memory regions.
+ *
+ * This function is used to scan through the DT and store the
+ * information for the reserved memory regions that are defined using
+ * the "reg" property. The region node number, name, base address, and
+ * size are all stored in the reserved_mem array by calling the
+ * fdt_reserved_mem_save_node() function.
+ */
+void __init fdt_scan_reserved_mem_reg_nodes(void)
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	const void *fdt = initial_boot_params;
+	phys_addr_t base, size;
+	const __be32 *prop;
+	int node, child;
+	int len;
+
+	if (!fdt)
+		return;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0) {
+		pr_info("Reserved memory: No reserved-memory node in the DT\n");
+		return;
+	}
+
+	if (__reserved_mem_check_root(node)) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+
+		prop = of_get_flat_dt_prop(child, "reg", &len);
+		if (!prop)
+			continue;
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+		if (len && len % t_len != 0) {
+			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+			       uname);
+			continue;
+		}
+
+		if (len > t_len)
+			pr_warn("%s() ignores %d regions in node '%s'\n",
+				__func__, len / t_len - 1, uname);
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size)
+			fdt_reserved_mem_save_node(child, uname, base, size);
+	}
+
+	/* check for overlapping reserved regions */
+	__rmem_check_for_overlap();
+}
+
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
+
 /*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
+	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -192,8 +261,24 @@ int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+		/*
+		 * Save the nodes for the dynamically-placed regions
+		 * into an array which will be used for allocation right
+		 * after all the statically-placed regions are reserved
+		 * or marked as no-map. This is done to avoid dynamically
+		 * allocating from one of the statically-placed regions.
+		 */
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
+			dynamic_nodes[dynamic_nodes_cnt] = child;
+			dynamic_nodes_cnt++;
+		}
+	}
+	for (int i = 0; i < dynamic_nodes_cnt; i++) {
+		const char *uname;
+
+		child = dynamic_nodes[i];
+		uname = fdt_get_name(fdt, child, NULL);
+		__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
@@ -253,8 +338,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -334,9 +418,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		return -ENOMEM;
 	}
 
-	*res_base = base;
-	*res_size = size;
-
+	/* Save region in the reserved_mem array */
+	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -425,48 +508,37 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * fdt_init_reserved_mem_node() - Initialize a reserved memory region
+ * @rmem: reserved_mem struct of the memory region to be initialized.
+ *
+ * This function is used to call the region specific initialization
+ * function for a reserved memory region.
  */
-void __init fdt_init_reserved_mem(void)
+static void __init fdt_init_reserved_mem_node(struct reserved_mem *rmem)
 {
-	int i;
-
-	/* check for overlapping reserved regions */
-	__rmem_check_for_overlap();
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserved_mem *rmem = &reserved_mem[i];
-		unsigned long node = rmem->fdt_node;
-		int err = 0;
-		bool nomap;
+	unsigned long node = rmem->fdt_node;
+	int err = 0;
+	bool nomap;
 
-		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-		if (rmem->size == 0)
-			err = __reserved_mem_alloc_size(node, rmem->name,
-						 &rmem->base, &rmem->size);
-		if (err == 0) {
-			err = __reserved_mem_init_node(rmem);
-			if (err != 0 && err != -ENOENT) {
-				pr_info("node %s compatible matching fail\n",
-					rmem->name);
-				if (nomap)
-					memblock_clear_nomap(rmem->base, rmem->size);
-				else
-					memblock_phys_free(rmem->base,
-							   rmem->size);
-			} else {
-				phys_addr_t end = rmem->base + rmem->size - 1;
-				bool reusable =
-					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
-
-				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-					nomap ? "nomap" : "map",
-					reusable ? "reusable" : "non-reusable",
-					rmem->name ? rmem->name : "unknown");
-			}
-		}
+	err = __reserved_mem_init_node(rmem);
+	if (err != 0 && err != -ENOENT) {
+		pr_info("node %s compatible matching fail\n", rmem->name);
+		if (nomap)
+			memblock_clear_nomap(rmem->base, rmem->size);
+		else
+			memblock_phys_free(rmem->base, rmem->size);
+	} else {
+		phys_addr_t end = rmem->base + rmem->size - 1;
+		bool reusable =
+			(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+
+		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+			nomap ? "nomap" : "map",
+			reusable ? "reusable" : "non-reusable",
+			rmem->name ? rmem->name : "unknown");
 	}
 }
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 7bd8390f2fba..906a33ae717f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1317,9 +1317,9 @@ static struct device_node *parse_interrupt_map(struct device_node *np,
 	addrcells = of_bus_n_addr_cells(np);
 
 	imap = of_get_property(np, "interrupt-map", &imaplen);
-	imaplen /= sizeof(*imap);
 	if (!imap)
 		return NULL;
+	imaplen /= sizeof(*imap);
 
 	imap_end = imap + imaplen;
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3aa18737470f..5ac209472c0c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -101,11 +101,30 @@ struct opp_table *_find_opp_table(struct device *dev)
  * representation in the OPP table and manage the clock configuration themselves
  * in an platform specific way.
  */
-static bool assert_single_clk(struct opp_table *opp_table)
+static bool assert_single_clk(struct opp_table *opp_table,
+			      unsigned int __always_unused index)
 {
 	return !WARN_ON(opp_table->clk_count > 1);
 }
 
+/*
+ * Returns true if clock table is large enough to contain the clock index.
+ */
+static bool assert_clk_index(struct opp_table *opp_table,
+			     unsigned int index)
+{
+	return opp_table->clk_count > index;
+}
+
+/*
+ * Returns true if bandwidth table is large enough to contain the bandwidth index.
+ */
+static bool assert_bandwidth_index(struct opp_table *opp_table,
+				   unsigned int index)
+{
+	return opp_table->path_count > index;
+}
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
@@ -499,12 +518,12 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
 		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 				unsigned long opp_key, unsigned long key),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table))
+	if (assert && !assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&opp_table->lock);
@@ -532,7 +551,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key),
-	  bool (*assert)(struct opp_table *opp_table))
+	  bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -555,7 +574,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
 		unsigned long key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	/*
 	 * The value of key will be updated here, but will be ignored as the
@@ -568,7 +587,7 @@ static struct dev_pm_opp *_find_key_exact(struct device *dev,
 static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _opp_table_find_key(opp_table, key, index, available, read,
 				   _compare_ceil, assert);
@@ -577,7 +596,7 @@ static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 		int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_ceil,
 			 assert);
@@ -586,7 +605,7 @@ static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 static struct dev_pm_opp *_find_key_floor(struct device *dev,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_floor,
 			 assert);
@@ -647,7 +666,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)
 {
-	return _find_key_exact(dev, freq, index, available, _read_freq, NULL);
+	return _find_key_exact(dev, freq, index, available, _read_freq,
+			       assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
 
@@ -707,7 +727,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq,
 				  u32 index)
 {
-	return _find_key_ceil(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_ceil(dev, freq, index, true, _read_freq,
+			      assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
 
@@ -760,7 +781,7 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq,
 				   u32 index)
 {
-	return _find_key_floor(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_floor(dev, freq, index, true, _read_freq, assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
 
@@ -878,7 +899,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
+			     assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -909,7 +931,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
+			      assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -1702,7 +1725,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		return;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		goto put_table;
 
 	mutex_lock(&opp_table->lock);
@@ -2054,7 +2077,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol, u_volt = data->u_volt;
 	int ret;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		return -EINVAL;
 
 	new_opp = _opp_allocate(opp_table);
@@ -2911,7 +2934,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}
@@ -2987,7 +3010,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 55c8cfef97d4..dcab0e7ace10 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -959,7 +959,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
 	if (ret)
-		goto free_opp;
+		goto put_node;
 
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
@@ -1009,6 +1009,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 free_required_opps:
 	_of_opp_free_required_opps(opp_table, new_opp);
+put_node:
+	of_node_put(np);
 free_opp:
 	_opp_free(new_opp);
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8d5c90aa4d4..ad3028b755d1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -598,10 +598,9 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable)
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 	return 0;
 }
 
@@ -630,19 +629,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
-	if (enable) {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-	}
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
 	return 0;
 }
 
 static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (!enable)
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 	return 0;
 }
 
@@ -775,6 +775,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
@@ -966,7 +967,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;
@@ -1391,7 +1394,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx_pcie->controller_id = 1;
 		break;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..120e2aca5164 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -946,6 +946,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 		return ret;
 	}
 
+	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6483e1874477..4c141e05f84e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1559,6 +1559,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
 		pci_unlock_rescan_remove();
+
+		qcom_pcie_icc_opp_update(pcie);
 	} else {
 		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
 			      status);
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 047e2cef5afc..c5e0d025bc43 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 		}
 		if (!devm_request_mem_region(&pdev->dev, res->start,
 					     resource_size(res),
-					     outbound_name)) {
+					     res->name)) {
 			dev_err(pcie->dev, "Cannot request memory region %s.\n",
 				outbound_name);
 			return -EIO;
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 48f60a04b740..3fdfffdf0270 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -7,27 +7,31 @@
  * Author: Daire McNamara <daire.mcnamara@microchip.com>
  */
 
+#include <linux/align.h>
+#include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
+#include <linux/wordpart.h>
 
 #include "../../pci.h"
 #include "pcie-plda.h"
 
+#define MC_MAX_NUM_INBOUND_WINDOWS		8
+#define MPFS_NC_BOUNCE_ADDR			0x80000000
+
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
 
-#define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
-#define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
-
 /* PCIe Controller Phy Regs */
 #define SEC_ERROR_EVENT_CNT			0x20
 #define DED_ERROR_EVENT_CNT			0x24
@@ -128,7 +132,6 @@
 	[EVENT_LOCAL_ ## x] = { __stringify(x), s }
 
 #define PCIE_EVENT(x) \
-	.base = MC_PCIE_CTRL_ADDR, \
 	.offset = PCIE_EVENT_INT, \
 	.mask_offset = PCIE_EVENT_INT, \
 	.mask_high = 1, \
@@ -136,7 +139,6 @@
 	.enb_mask = PCIE_EVENT_INT_ENB_MASK
 
 #define SEC_EVENT(x) \
-	.base = MC_PCIE_CTRL_ADDR, \
 	.offset = SEC_ERROR_INT, \
 	.mask_offset = SEC_ERROR_INT_MASK, \
 	.mask = SEC_ERROR_INT_ ## x ## _INT, \
@@ -144,7 +146,6 @@
 	.enb_mask = 0
 
 #define DED_EVENT(x) \
-	.base = MC_PCIE_CTRL_ADDR, \
 	.offset = DED_ERROR_INT, \
 	.mask_offset = DED_ERROR_INT_MASK, \
 	.mask_high = 1, \
@@ -152,7 +153,6 @@
 	.enb_mask = 0
 
 #define LOCAL_EVENT(x) \
-	.base = MC_PCIE_BRIDGE_ADDR, \
 	.offset = ISTATUS_LOCAL, \
 	.mask_offset = IMASK_LOCAL, \
 	.mask_high = 0, \
@@ -179,7 +179,8 @@ struct event_map {
 
 struct mc_pcie {
 	struct plda_pcie_rp plda;
-	void __iomem *axi_base_addr;
+	void __iomem *bridge_base_addr;
+	void __iomem *ctrl_base_addr;
 };
 
 struct cause {
@@ -253,7 +254,6 @@ static struct event_map local_status_to_event[] = {
 };
 
 static struct {
-	u32 base;
 	u32 offset;
 	u32 mask;
 	u32 shift;
@@ -325,8 +325,7 @@ static inline u32 reg_to_event(u32 reg, struct event_map field)
 
 static u32 pcie_events(struct mc_pcie *port)
 {
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
-	u32 reg = readl_relaxed(ctrl_base_addr + PCIE_EVENT_INT);
+	u32 reg = readl_relaxed(port->ctrl_base_addr + PCIE_EVENT_INT);
 	u32 val = 0;
 	int i;
 
@@ -338,8 +337,7 @@ static u32 pcie_events(struct mc_pcie *port)
 
 static u32 sec_errors(struct mc_pcie *port)
 {
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
-	u32 reg = readl_relaxed(ctrl_base_addr + SEC_ERROR_INT);
+	u32 reg = readl_relaxed(port->ctrl_base_addr + SEC_ERROR_INT);
 	u32 val = 0;
 	int i;
 
@@ -351,8 +349,7 @@ static u32 sec_errors(struct mc_pcie *port)
 
 static u32 ded_errors(struct mc_pcie *port)
 {
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
-	u32 reg = readl_relaxed(ctrl_base_addr + DED_ERROR_INT);
+	u32 reg = readl_relaxed(port->ctrl_base_addr + DED_ERROR_INT);
 	u32 val = 0;
 	int i;
 
@@ -364,8 +361,7 @@ static u32 ded_errors(struct mc_pcie *port)
 
 static u32 local_events(struct mc_pcie *port)
 {
-	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	u32 reg = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
+	u32 reg = readl_relaxed(port->bridge_base_addr + ISTATUS_LOCAL);
 	u32 val = 0;
 	int i;
 
@@ -412,8 +408,12 @@ static void mc_ack_event_irq(struct irq_data *data)
 	void __iomem *addr;
 	u32 mask;
 
-	addr = mc_port->axi_base_addr + event_descs[event].base +
-		event_descs[event].offset;
+	if (event_descs[event].offset == ISTATUS_LOCAL)
+		addr = mc_port->bridge_base_addr;
+	else
+		addr = mc_port->ctrl_base_addr;
+
+	addr += event_descs[event].offset;
 	mask = event_descs[event].mask;
 	mask |= event_descs[event].enb_mask;
 
@@ -429,8 +429,12 @@ static void mc_mask_event_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	addr = mc_port->axi_base_addr + event_descs[event].base +
-		event_descs[event].mask_offset;
+	if (event_descs[event].offset == ISTATUS_LOCAL)
+		addr = mc_port->bridge_base_addr;
+	else
+		addr = mc_port->ctrl_base_addr;
+
+	addr += event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 	if (event_descs[event].enb_mask) {
 		mask <<= PCIE_EVENT_INT_ENB_SHIFT;
@@ -460,8 +464,12 @@ static void mc_unmask_event_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	addr = mc_port->axi_base_addr + event_descs[event].base +
-		event_descs[event].mask_offset;
+	if (event_descs[event].offset == ISTATUS_LOCAL)
+		addr = mc_port->bridge_base_addr;
+	else
+		addr = mc_port->ctrl_base_addr;
+
+	addr += event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 
 	if (event_descs[event].enb_mask)
@@ -554,26 +562,20 @@ static const struct plda_event mc_event = {
 
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
-
-	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, ctrl_base_addr +
-		       SEC_ERROR_INT);
-	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
+	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT,
+		       port->ctrl_base_addr + SEC_ERROR_INT);
+	writel_relaxed(0, port->ctrl_base_addr + SEC_ERROR_EVENT_CNT);
 }
 
 static inline void mc_clear_deds(struct mc_pcie *port)
 {
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
-
-	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, ctrl_base_addr +
-		       DED_ERROR_INT);
-	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
+	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT,
+		       port->ctrl_base_addr + DED_ERROR_INT);
+	writel_relaxed(0, port->ctrl_base_addr + DED_ERROR_EVENT_CNT);
 }
 
 static void mc_disable_interrupts(struct mc_pcie *port)
 {
-	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
 	u32 val;
 
 	/* Ensure ECC bypass is enabled */
@@ -581,22 +583,22 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	      ECC_CONTROL_RX_RAM_ECC_BYPASS |
 	      ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
 	      ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS;
-	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
+	writel_relaxed(val, port->ctrl_base_addr + ECC_CONTROL);
 
 	/* Disable SEC errors and clear any outstanding */
-	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, ctrl_base_addr +
-		       SEC_ERROR_INT_MASK);
+	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT,
+		       port->ctrl_base_addr + SEC_ERROR_INT_MASK);
 	mc_clear_secs(port);
 
 	/* Disable DED errors and clear any outstanding */
-	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, ctrl_base_addr +
-		       DED_ERROR_INT_MASK);
+	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT,
+		       port->ctrl_base_addr + DED_ERROR_INT_MASK);
 	mc_clear_deds(port);
 
 	/* Disable local interrupts and clear any outstanding */
-	writel_relaxed(0, bridge_base_addr + IMASK_LOCAL);
-	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_LOCAL);
-	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_MSI);
+	writel_relaxed(0, port->bridge_base_addr + IMASK_LOCAL);
+	writel_relaxed(GENMASK(31, 0), port->bridge_base_addr + ISTATUS_LOCAL);
+	writel_relaxed(GENMASK(31, 0), port->bridge_base_addr + ISTATUS_MSI);
 
 	/* Disable PCIe events and clear any outstanding */
 	val = PCIE_EVENT_INT_L2_EXIT_INT |
@@ -605,11 +607,96 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	      PCIE_EVENT_INT_L2_EXIT_INT_MASK |
 	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
 	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
-	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
+	writel_relaxed(val, port->ctrl_base_addr + PCIE_EVENT_INT);
 
 	/* Disable host interrupts and clear any outstanding */
-	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
-	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
+	writel_relaxed(0, port->bridge_base_addr + IMASK_HOST);
+	writel_relaxed(GENMASK(31, 0), port->bridge_base_addr + ISTATUS_HOST);
+}
+
+static void mc_pcie_setup_inbound_atr(struct mc_pcie *port, int window_index,
+				      u64 axi_addr, u64 pcie_addr, u64 size)
+{
+	u32 table_offset = window_index * ATR_ENTRY_SIZE;
+	void __iomem *table_addr = port->bridge_base_addr + table_offset;
+	u32 atr_sz;
+	u32 val;
+
+	atr_sz = ilog2(size) - 1;
+
+	val = ALIGN_DOWN(lower_32_bits(pcie_addr), SZ_4K);
+	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
+	val |= ATR_IMPL_ENABLE;
+
+	writel(val, table_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+
+	writel(upper_32_bits(pcie_addr), table_addr + ATR0_PCIE_WIN0_SRC_ADDR);
+
+	writel(lower_32_bits(axi_addr), table_addr + ATR0_PCIE_WIN0_TRSL_ADDR_LSB);
+	writel(upper_32_bits(axi_addr), table_addr + ATR0_PCIE_WIN0_TRSL_ADDR_UDW);
+
+	writel(TRSL_ID_AXI4_MASTER_0, table_addr + ATR0_PCIE_WIN0_TRSL_PARAM);
+}
+
+static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev,
+					struct mc_pcie *port)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *dn = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int atr_index = 0;
+
+	/*
+	 * MPFS PCIe Root Port is 32-bit only, behind a Fabric Interface
+	 * Controller FPGA logic block which contains the AXI-S interface.
+	 *
+	 * From the point of view of the PCIe Root Port, there are only two
+	 * supported Root Port configurations:
+	 *
+	 * Configuration 1: for use with fully coherent designs; supports a
+	 * window from 0x0 (CPU space) to specified PCIe space.
+	 *
+	 * Configuration 2: for use with non-coherent designs; supports two
+	 * 1 GB windows to CPU space; one mapping CPU space 0 to PCIe space
+	 * 0x80000000 and a second mapping CPU space 0x40000000 to PCIe
+	 * space 0xc0000000. This cfg needs two windows because of how the
+	 * MSI space is allocated in the AXI-S range on MPFS.
+	 *
+	 * The FIC interface outside the PCIe block *must* complete the
+	 * inbound address translation as per MCHP MPFS FPGA design
+	 * guidelines.
+	 */
+	if (device_property_read_bool(dev, "dma-noncoherent")) {
+		/*
+		 * Always need same two tables in this case.  Need two tables
+		 * due to hardware interactions between address and size.
+		 */
+		mc_pcie_setup_inbound_atr(port, 0, 0,
+					  MPFS_NC_BOUNCE_ADDR, SZ_1G);
+		mc_pcie_setup_inbound_atr(port, 1, SZ_1G,
+					  MPFS_NC_BOUNCE_ADDR + SZ_1G, SZ_1G);
+	} else {
+		/* Find any DMA ranges */
+		if (of_pci_dma_range_parser_init(&parser, dn)) {
+			/* No DMA range property - setup default */
+			mc_pcie_setup_inbound_atr(port, 0, 0, 0, SZ_4G);
+			return 0;
+		}
+
+		for_each_of_range(&parser, &range) {
+			if (atr_index >= MC_MAX_NUM_INBOUND_WINDOWS) {
+				dev_err(dev, "too many inbound ranges; %d available tables\n",
+					MC_MAX_NUM_INBOUND_WINDOWS);
+				return -EINVAL;
+			}
+			mc_pcie_setup_inbound_atr(port, atr_index, 0,
+						  range.pci_addr, range.size);
+			atr_index++;
+		}
+	}
+
+	return 0;
 }
 
 static int mc_platform_init(struct pci_config_window *cfg)
@@ -617,12 +704,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
+	plda_pcie_setup_window(port->bridge_base_addr, 0, cfg->res.start,
 			       cfg->res.start,
 			       resource_size(&cfg->res));
 
@@ -634,6 +719,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	ret = mc_pcie_setup_inbound_ranges(pdev, port);
+	if (ret)
+		return ret;
+
 	port->plda.event_ops = &mc_event_ops;
 	port->plda.event_irq_chip = &mc_event_irq_chip;
 	port->plda.events_bitmap = GENMASK(NUM_EVENTS - 1, 0);
@@ -649,7 +738,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 static int mc_host_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	void __iomem *bridge_base_addr;
+	void __iomem *apb_base_addr;
 	struct plda_pcie_rp *plda;
 	int ret;
 	u32 val;
@@ -661,30 +750,45 @@ static int mc_host_probe(struct platform_device *pdev)
 	plda = &port->plda;
 	plda->dev = dev;
 
-	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->axi_base_addr))
-		return PTR_ERR(port->axi_base_addr);
+	port->bridge_base_addr = devm_platform_ioremap_resource_byname(pdev,
+								    "bridge");
+	port->ctrl_base_addr = devm_platform_ioremap_resource_byname(pdev,
+								    "ctrl");
+	if (!IS_ERR(port->bridge_base_addr) && !IS_ERR(port->ctrl_base_addr))
+		goto addrs_set;
+
+	/*
+	 * The original, incorrect, binding that lumped the control and
+	 * bridge addresses together still needs to be handled by the driver.
+	 */
+	apb_base_addr = devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(apb_base_addr))
+		return dev_err_probe(dev, PTR_ERR(apb_base_addr),
+				     "both legacy apb register and ctrl/bridge regions missing");
+
+	port->bridge_base_addr = apb_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	port->ctrl_base_addr = apb_base_addr + MC_PCIE1_CTRL_ADDR;
 
+addrs_set:
 	mc_disable_interrupts(port);
 
-	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	plda->bridge_addr = bridge_base_addr;
+	plda->bridge_addr = port->bridge_base_addr;
 	plda->num_events = NUM_EVENTS;
 
 	/* Allow enabling MSI by disabling MSI-X */
-	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
+	val = readl(port->bridge_base_addr + PCIE_PCI_IRQ_DW0);
 	val &= ~MSIX_CAP_MASK;
-	writel(val, bridge_base_addr + PCIE_PCI_IRQ_DW0);
+	writel(val, port->bridge_base_addr + PCIE_PCI_IRQ_DW0);
 
 	/* Pick num vectors from bitfile programmed onto FPGA fabric */
-	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
+	val = readl(port->bridge_base_addr + PCIE_PCI_IRQ_DW0);
 	val &= NUM_MSI_MSGS_MASK;
 	val >>= NUM_MSI_MSGS_SHIFT;
 
 	plda->msi.num_vectors = 1 << val;
 
 	/* Pick vector address from design */
-	plda->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
+	plda->msi.vector_phy = readl_relaxed(port->bridge_base_addr + IMSI_ADDR);
 
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 8533dc618d45..4153214ca410 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -8,11 +8,14 @@
  * Author: Daire McNamara <daire.mcnamara@microchip.com>
  */
 
+#include <linux/align.h>
+#include <linux/bitfield.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/pci_regs.h>
 #include <linux/pci-ecam.h>
+#include <linux/wordpart.h>
 
 #include "pcie-plda.h"
 
@@ -502,8 +505,9 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_TRSL_PARAM);
 
-	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
-			    ATR_IMPL_ENABLE;
+	val = ALIGN_DOWN(lower_32_bits(axi_addr), SZ_4K);
+	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
+	val |= ATR_IMPL_ENABLE;
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
 
@@ -518,13 +522,20 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	val = upper_32_bits(pci_addr);
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+
+void plda_pcie_setup_inbound_address_translation(struct plda_pcie_rp *port)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 val;
 
 	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
 	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
 	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
-EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+EXPORT_SYMBOL_GPL(plda_pcie_setup_inbound_address_translation);
 
 int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 			   struct plda_pcie_rp *port)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 0e7dc0d8e5ba..61ece26065ea 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -89,14 +89,15 @@
 
 /* PCIe AXI slave table init defines */
 #define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
-#define  ATR_SIZE_SHIFT				1
-#define  ATR_IMPL_ENABLE			1
+#define  ATR_SIZE_MASK				GENMASK(6, 1)
+#define  ATR_IMPL_ENABLE			BIT(0)
 #define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
 #define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
 #define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
 #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
 #define  PCIE_TX_RX_INTERFACE			0x00000000u
 #define  PCIE_CONFIG_INTERFACE			0x00000001u
+#define  TRSL_ID_AXI4_MASTER_0			0x00000004u
 
 #define CONFIG_SPACE_ADDR_OFFSET		0x1000u
 
@@ -204,6 +205,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
+void plda_pcie_setup_inbound_address_translation(struct plda_pcie_rp *port);
 int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 			   struct plda_pcie_rp *port);
 int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..14b4c68ab4e1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 
 fail_back_rx:
 	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_tx = NULL;
+	epf_test->dma_chan_rx = NULL;
 
 fail_back_tx:
 	dma_cap_zero(mask);
@@ -361,8 +361,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 
 	ktime_get_ts64(&start);
 	if (reg->flags & FLAG_USE_DMA) {
-		if (epf_test->dma_private) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
+		if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
+			dev_err(dev, "DMA controller doesn't support MEMCPY\n");
 			ret = -EINVAL;
 			goto err_map_addr;
 		}
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 62f7dff43730..de665342dc16 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -856,7 +856,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f4f10c60c1d2..dcc662be0800 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -438,9 +438,9 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
  *  - Any spurious wake up event during switch sequence to be ignored and
  *    cleared
  */
-static void nmk_gpio_glitch_slpm_init(unsigned int *slpm)
+static int nmk_gpio_glitch_slpm_init(unsigned int *slpm)
 {
-	int i;
+	int i, j, ret;
 
 	for (i = 0; i < NMK_MAX_BANKS; i++) {
 		struct nmk_gpio_chip *chip = nmk_gpio_chips[i];
@@ -449,11 +449,21 @@ static void nmk_gpio_glitch_slpm_init(unsigned int *slpm)
 		if (!chip)
 			break;
 
-		clk_enable(chip->clk);
+		ret = clk_enable(chip->clk);
+		if (ret) {
+			for (j = 0; j < i; j++) {
+				chip = nmk_gpio_chips[j];
+				clk_disable(chip->clk);
+			}
+
+			return ret;
+		}
 
 		slpm[i] = readl(chip->addr + NMK_GPIO_SLPC);
 		writel(temp, chip->addr + NMK_GPIO_SLPC);
 	}
+
+	return 0;
 }
 
 static void nmk_gpio_glitch_slpm_restore(unsigned int *slpm)
@@ -923,7 +933,9 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 
 			slpm[nmk_chip->bank] &= ~BIT(bit);
 		}
-		nmk_gpio_glitch_slpm_init(slpm);
+		ret = nmk_gpio_glitch_slpm_init(slpm);
+		if (ret)
+			goto out_pre_slpm_init;
 	}
 
 	for (i = 0; i < g->grp.npins; i++) {
@@ -940,7 +952,10 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		dev_dbg(npct->dev, "setting pin %d to altsetting %d\n",
 			g->grp.pins[i], g->altsetting);
 
-		clk_enable(nmk_chip->clk);
+		ret = clk_enable(nmk_chip->clk);
+		if (ret)
+			goto out_glitch;
+
 		/*
 		 * If the pin is switching to altfunc, and there was an
 		 * interrupt installed on it which has been lazy disabled,
@@ -988,6 +1003,7 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_chip *chip;
 	unsigned int bit;
+	int ret;
 
 	if (!range) {
 		dev_err(npct->dev, "invalid range\n");
@@ -1004,7 +1020,9 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 	find_nmk_gpio_from_pin(pin, &bit);
 
-	clk_enable(nmk_chip->clk);
+	ret = clk_enable(nmk_chip->clk);
+	if (ret)
+		return ret;
 	/* There is no glitch when converting any pin to GPIO */
 	__nmk_gpio_set_mode(nmk_chip, bit, NMK_GPIO_ALT_GPIO);
 	clk_disable(nmk_chip->clk);
@@ -1058,6 +1076,7 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	unsigned long cfg;
 	int pull, slpm, output, val, i;
 	bool lowemi, gpiomode, sleep;
+	int ret;
 
 	nmk_chip = find_nmk_gpio_from_pin(pin, &bit);
 	if (!nmk_chip) {
@@ -1116,7 +1135,9 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			output ? (val ? "high" : "low") : "",
 			lowemi ? "on" : "off");
 
-		clk_enable(nmk_chip->clk);
+		ret = clk_enable(nmk_chip->clk);
+		if (ret)
+			return ret;
 		if (gpiomode)
 			/* No glitch when going to GPIO mode */
 			__nmk_gpio_set_mode(nmk_chip, bit, NMK_GPIO_ALT_GPIO);
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 7f66ec73199a..a12766b3bc8a 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -908,12 +908,13 @@ static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 	return false;
 }
 
-static int amd_gpio_suspend(struct device *dev)
+static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
 	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
 	unsigned long flags;
 	int i;
+	u32 wake_mask = is_suspend ? WAKE_SOURCE_SUSPEND : WAKE_SOURCE_HIBERNATE;
 
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;
@@ -925,11 +926,11 @@ static int amd_gpio_suspend(struct device *dev)
 		gpio_dev->saved_regs[i] = readl(gpio_dev->base + pin * 4) & ~PIN_IRQ_PENDING;
 
 		/* mask any interrupts not intended to be a wake source */
-		if (!(gpio_dev->saved_regs[i] & WAKE_SOURCE)) {
+		if (!(gpio_dev->saved_regs[i] & wake_mask)) {
 			writel(gpio_dev->saved_regs[i] & ~BIT(INTERRUPT_MASK_OFF),
 			       gpio_dev->base + pin * 4);
-			pm_pr_dbg("Disabling GPIO #%d interrupt for suspend.\n",
-				  pin);
+			pm_pr_dbg("Disabling GPIO #%d interrupt for %s.\n",
+				  pin, is_suspend ? "suspend" : "hibernate");
 		}
 
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
@@ -938,6 +939,16 @@ static int amd_gpio_suspend(struct device *dev)
 	return 0;
 }
 
+static int amd_gpio_suspend(struct device *dev)
+{
+	return amd_gpio_suspend_hibernate_common(dev, true);
+}
+
+static int amd_gpio_hibernate(struct device *dev)
+{
+	return amd_gpio_suspend_hibernate_common(dev, false);
+}
+
 static int amd_gpio_resume(struct device *dev)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
@@ -961,8 +972,12 @@ static int amd_gpio_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops amd_gpio_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(amd_gpio_suspend,
-				     amd_gpio_resume)
+	.suspend_late = amd_gpio_suspend,
+	.resume_early = amd_gpio_resume,
+	.freeze_late = amd_gpio_hibernate,
+	.thaw_early = amd_gpio_resume,
+	.poweroff_late = amd_gpio_hibernate,
+	.restore_early = amd_gpio_resume,
 };
 #endif
 
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index cf59089f2776..c9522c62d791 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -80,10 +80,9 @@
 #define FUNCTION_MASK		GENMASK(1, 0)
 #define FUNCTION_INVALID	GENMASK(7, 0)
 
-#define WAKE_SOURCE	(BIT(WAKE_CNTRL_OFF_S0I3) | \
-			 BIT(WAKE_CNTRL_OFF_S3)   | \
-			 BIT(WAKE_CNTRL_OFF_S4)   | \
-			 BIT(WAKECNTRL_Z_OFF))
+#define WAKE_SOURCE_SUSPEND  (BIT(WAKE_CNTRL_OFF_S0I3) | \
+			      BIT(WAKE_CNTRL_OFF_S3))
+#define WAKE_SOURCE_HIBERNATE BIT(WAKE_CNTRL_OFF_S4)
 
 struct amd_function {
 	const char *name;
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index b79c211c0374..ac6dc22b37c9 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -636,7 +636,7 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 		if (clk_enable(b->drvdata->pclk)) {
 			dev_err(b->gpio_chip.parent,
 				"unable to enable clock for pending IRQs\n");
-			return;
+			goto out;
 		}
 	}
 
@@ -652,6 +652,7 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 	if (eintd->nr_banks)
 		clk_disable(eintd->banks[0]->drvdata->pclk);
 
+out:
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 5b7fa77c1184..03f3f707d275 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -86,7 +86,6 @@ struct stm32_pinctrl_group {
 
 struct stm32_gpio_bank {
 	void __iomem *base;
-	struct clk *clk;
 	struct reset_control *rstc;
 	spinlock_t lock;
 	struct gpio_chip gpio_chip;
@@ -108,6 +107,7 @@ struct stm32_pinctrl {
 	unsigned ngroups;
 	const char **grp_names;
 	struct stm32_gpio_bank *banks;
+	struct clk_bulk_data *clks;
 	unsigned nbanks;
 	const struct stm32_pinctrl_match_data *match_data;
 	struct irq_domain	*domain;
@@ -1308,12 +1308,6 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	if (IS_ERR(bank->base))
 		return PTR_ERR(bank->base);
 
-	err = clk_prepare_enable(bank->clk);
-	if (err) {
-		dev_err(dev, "failed to prepare_enable clk (%d)\n", err);
-		return err;
-	}
-
 	bank->gpio_chip = stm32_gpio_template;
 
 	fwnode_property_read_string(fwnode, "st,bank-name", &bank->gpio_chip.label);
@@ -1360,26 +1354,20 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 							   bank->fwnode, &stm32_gpio_domain_ops,
 							   bank);
 
-		if (!bank->domain) {
-			err = -ENODEV;
-			goto err_clk;
-		}
+		if (!bank->domain)
+			return -ENODEV;
 	}
 
 	names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
-	if (!names) {
-		err = -ENOMEM;
-		goto err_clk;
-	}
+	if (!names)
+		return -ENOMEM;
 
 	for (i = 0; i < npins; i++) {
 		stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
 		if (stm32_pin && stm32_pin->pin.name) {
 			names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s", stm32_pin->pin.name);
-			if (!names[i]) {
-				err = -ENOMEM;
-				goto err_clk;
-			}
+			if (!names[i])
+				return -ENOMEM;
 		} else {
 			names[i] = NULL;
 		}
@@ -1390,15 +1378,11 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	err = gpiochip_add_data(&bank->gpio_chip, bank);
 	if (err) {
 		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
-		goto err_clk;
+		return err;
 	}
 
 	dev_info(dev, "%s bank added\n", bank->gpio_chip.label);
 	return 0;
-
-err_clk:
-	clk_disable_unprepare(bank->clk);
-	return err;
 }
 
 static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pdev)
@@ -1621,6 +1605,11 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	if (!pctl->banks)
 		return -ENOMEM;
 
+	pctl->clks = devm_kcalloc(dev, banks, sizeof(*pctl->clks),
+				  GFP_KERNEL);
+	if (!pctl->clks)
+		return -ENOMEM;
+
 	i = 0;
 	for_each_gpiochip_node(dev, child) {
 		struct stm32_gpio_bank *bank = &pctl->banks[i];
@@ -1632,24 +1621,27 @@ int stm32_pctl_probe(struct platform_device *pdev)
 			return -EPROBE_DEFER;
 		}
 
-		bank->clk = of_clk_get_by_name(np, NULL);
-		if (IS_ERR(bank->clk)) {
+		pctl->clks[i].clk = of_clk_get_by_name(np, NULL);
+		if (IS_ERR(pctl->clks[i].clk)) {
 			fwnode_handle_put(child);
-			return dev_err_probe(dev, PTR_ERR(bank->clk),
+			return dev_err_probe(dev, PTR_ERR(pctl->clks[i].clk),
 					     "failed to get clk\n");
 		}
+		pctl->clks[i].id = "pctl";
 		i++;
 	}
 
+	ret = clk_bulk_prepare_enable(banks, pctl->clks);
+	if (ret) {
+		dev_err(dev, "failed to prepare_enable clk (%d)\n", ret);
+		return ret;
+	}
+
 	for_each_gpiochip_node(dev, child) {
 		ret = stm32_gpiolib_register_bank(pctl, child);
 		if (ret) {
 			fwnode_handle_put(child);
-
-			for (i = 0; i < pctl->nbanks; i++)
-				clk_disable_unprepare(pctl->banks[i].clk);
-
-			return ret;
+			goto err_register;
 		}
 
 		pctl->nbanks++;
@@ -1658,6 +1650,15 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	dev_info(dev, "Pinctrl STM32 initialized\n");
 
 	return 0;
+err_register:
+	for (i = 0; i < pctl->nbanks; i++) {
+		struct stm32_gpio_bank *bank = &pctl->banks[i];
+
+		gpiochip_remove(&bank->gpio_chip);
+	}
+
+	clk_bulk_disable_unprepare(banks, pctl->clks);
+	return ret;
 }
 
 static int __maybe_unused stm32_pinctrl_restore_gpio_regs(
@@ -1726,10 +1727,8 @@ static int __maybe_unused stm32_pinctrl_restore_gpio_regs(
 int __maybe_unused stm32_pinctrl_suspend(struct device *dev)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(dev);
-	int i;
 
-	for (i = 0; i < pctl->nbanks; i++)
-		clk_disable(pctl->banks[i].clk);
+	clk_bulk_disable(pctl->nbanks, pctl->clks);
 
 	return 0;
 }
@@ -1738,10 +1737,11 @@ int __maybe_unused stm32_pinctrl_resume(struct device *dev)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(dev);
 	struct stm32_pinctrl_group *g = pctl->groups;
-	int i;
+	int i, ret;
 
-	for (i = 0; i < pctl->nbanks; i++)
-		clk_enable(pctl->banks[i].clk);
+	ret = clk_bulk_enable(pctl->nbanks, pctl->clks);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < pctl->ngroups; i++, g++)
 		stm32_pinctrl_restore_gpio_regs(pctl, g->pin);
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 9d18dfca6a67..9ff7b487dc48 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1168,7 +1168,7 @@ static int mlxbf_pmc_program_l3_counter(unsigned int blk_num, u32 cnt_num, u32 e
 /* Method to handle crspace counter programming */
 static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num, u32 evt)
 {
-	void *addr;
+	void __iomem *addr;
 	u32 word;
 	int ret;
 
@@ -1192,7 +1192,7 @@ static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num,
 /* Method to clear crspace counter value */
 static int mlxbf_pmc_clear_crspace_counter(unsigned int blk_num, u32 cnt_num)
 {
-	void *addr;
+	void __iomem *addr;
 
 	addr = pmc->block[blk_num].mmio_base +
 		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
@@ -1405,7 +1405,7 @@ static int mlxbf_pmc_read_l3_event(unsigned int blk_num, u32 cnt_num, u64 *resul
 static int mlxbf_pmc_read_crspace_event(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	u32 word, evt;
-	void *addr;
+	void __iomem *addr;
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index ae087f1471c1..a60efbaf4817 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -601,7 +601,7 @@ static const struct regulator_init_data lenovo_yoga_tab2_1380_bq24190_vbus_init_
 	.num_consumer_supplies = 1,
 };
 
-struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
+static struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
 	.regulator_init_data = &lenovo_yoga_tab2_1380_bq24190_vbus_init_data,
 };
 
@@ -726,7 +726,7 @@ static const struct platform_device_info lenovo_yoga_tab2_1380_pdevs[] __initcon
 	},
 };
 
-const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
+static const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
 	"bq24190_charger",            /* For the Vbus regulator for lc824206xa */
 	NULL
 };
diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 791fdc9326dd..93e662912b53 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -214,8 +214,8 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dev_info(data->pps->dev, "Registered IRQ %d as PPS source\n",
-		 data->irq);
+	dev_dbg(&data->pps->dev, "Registered IRQ %d as PPS source\n",
+		data->irq);
 
 	return 0;
 }
diff --git a/drivers/pps/clients/pps-ktimer.c b/drivers/pps/clients/pps-ktimer.c
index d33106bd7a29..2f465549b843 100644
--- a/drivers/pps/clients/pps-ktimer.c
+++ b/drivers/pps/clients/pps-ktimer.c
@@ -56,7 +56,7 @@ static struct pps_source_info pps_ktimer_info = {
 
 static void __exit pps_ktimer_exit(void)
 {
-	dev_info(pps->dev, "ktimer PPS source unregistered\n");
+	dev_dbg(&pps->dev, "ktimer PPS source unregistered\n");
 
 	del_timer_sync(&ktimer);
 	pps_unregister_source(pps);
@@ -74,7 +74,7 @@ static int __init pps_ktimer_init(void)
 	timer_setup(&ktimer, pps_ktimer_event, 0);
 	mod_timer(&ktimer, jiffies + HZ);
 
-	dev_info(pps->dev, "ktimer PPS source registered\n");
+	dev_dbg(&pps->dev, "ktimer PPS source registered\n");
 
 	return 0;
 }
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 443d6bae19d1..fa5660f3c4b7 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -32,7 +32,7 @@ static void pps_tty_dcd_change(struct tty_struct *tty, bool active)
 	pps_event(pps, &ts, active ? PPS_CAPTUREASSERT :
 			PPS_CAPTURECLEAR, NULL);
 
-	dev_dbg(pps->dev, "PPS %s at %lu\n",
+	dev_dbg(&pps->dev, "PPS %s at %lu\n",
 			active ? "assert" : "clear", jiffies);
 }
 
@@ -69,7 +69,7 @@ static int pps_tty_open(struct tty_struct *tty)
 		goto err_unregister;
 	}
 
-	dev_info(pps->dev, "source \"%s\" added\n", info.path);
+	dev_dbg(&pps->dev, "source \"%s\" added\n", info.path);
 
 	return 0;
 
@@ -89,7 +89,7 @@ static void pps_tty_close(struct tty_struct *tty)
 	if (WARN_ON(!pps))
 		return;
 
-	dev_info(pps->dev, "removed\n");
+	dev_info(&pps->dev, "removed\n");
 	pps_unregister_source(pps);
 }
 
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index abaffb4e1c1c..24db06750297 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -81,7 +81,7 @@ static void parport_irq(void *handle)
 	/* check the signal (no signal means the pulse is lost this time) */
 	if (!signal_is_set(port)) {
 		local_irq_restore(flags);
-		dev_err(dev->pps->dev, "lost the signal\n");
+		dev_err(&dev->pps->dev, "lost the signal\n");
 		goto out_assert;
 	}
 
@@ -98,7 +98,7 @@ static void parport_irq(void *handle)
 	/* timeout */
 	dev->cw_err++;
 	if (dev->cw_err >= CLEAR_WAIT_MAX_ERRORS) {
-		dev_err(dev->pps->dev, "disabled clear edge capture after %d"
+		dev_err(&dev->pps->dev, "disabled clear edge capture after %d"
 				" timeouts\n", dev->cw_err);
 		dev->cw = 0;
 		dev->cw_err = 0;
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..92d1b62ea239 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -41,7 +41,7 @@ static void pps_add_offset(struct pps_ktime *ts, struct pps_ktime *offset)
 static void pps_echo_client_default(struct pps_device *pps, int event,
 		void *data)
 {
-	dev_info(pps->dev, "echo %s %s\n",
+	dev_info(&pps->dev, "echo %s %s\n",
 		event & PPS_CAPTUREASSERT ? "assert" : "",
 		event & PPS_CAPTURECLEAR ? "clear" : "");
 }
@@ -112,7 +112,7 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 		goto kfree_pps;
 	}
 
-	dev_info(pps->dev, "new PPS source %s\n", info->name);
+	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
 
 	return pps;
 
@@ -166,7 +166,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	/* check event type */
 	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
 
-	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
+	dev_dbg(&pps->dev, "PPS event at %lld.%09ld\n",
 			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
 
 	timespec_to_pps_ktime(&ts_real, ts->ts_real);
@@ -188,7 +188,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		/* Save the time stamp */
 		pps->assert_tu = ts_real;
 		pps->assert_sequence++;
-		dev_dbg(pps->dev, "capture assert seq #%u\n",
+		dev_dbg(&pps->dev, "capture assert seq #%u\n",
 			pps->assert_sequence);
 
 		captured = ~0;
@@ -202,7 +202,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		/* Save the time stamp */
 		pps->clear_tu = ts_real;
 		pps->clear_sequence++;
-		dev_dbg(pps->dev, "capture clear seq #%u\n",
+		dev_dbg(&pps->dev, "capture clear seq #%u\n",
 			pps->clear_sequence);
 
 		captured = ~0;
diff --git a/drivers/pps/kc.c b/drivers/pps/kc.c
index 50dc59af45be..fbd23295afd7 100644
--- a/drivers/pps/kc.c
+++ b/drivers/pps/kc.c
@@ -43,11 +43,11 @@ int pps_kc_bind(struct pps_device *pps, struct pps_bind_args *bind_args)
 			pps_kc_hardpps_mode = 0;
 			pps_kc_hardpps_dev = NULL;
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_info(pps->dev, "unbound kernel"
+			dev_info(&pps->dev, "unbound kernel"
 					" consumer\n");
 		} else {
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_err(pps->dev, "selected kernel consumer"
+			dev_err(&pps->dev, "selected kernel consumer"
 					" is not bound\n");
 			return -EINVAL;
 		}
@@ -57,11 +57,11 @@ int pps_kc_bind(struct pps_device *pps, struct pps_bind_args *bind_args)
 			pps_kc_hardpps_mode = bind_args->edge;
 			pps_kc_hardpps_dev = pps;
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_info(pps->dev, "bound kernel consumer: "
+			dev_info(&pps->dev, "bound kernel consumer: "
 				"edge=0x%x\n", bind_args->edge);
 		} else {
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_err(pps->dev, "another kernel consumer"
+			dev_err(&pps->dev, "another kernel consumer"
 					" is already bound\n");
 			return -EINVAL;
 		}
@@ -83,7 +83,7 @@ void pps_kc_remove(struct pps_device *pps)
 		pps_kc_hardpps_mode = 0;
 		pps_kc_hardpps_dev = NULL;
 		spin_unlock_irq(&pps_kc_hardpps_lock);
-		dev_info(pps->dev, "unbound kernel consumer"
+		dev_info(&pps->dev, "unbound kernel consumer"
 				" on device removal\n");
 	} else
 		spin_unlock_irq(&pps_kc_hardpps_lock);
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 25d47907db17..6a02245ea35f 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -25,7 +25,7 @@
  * Local variables
  */
 
-static dev_t pps_devt;
+static int pps_major;
 static struct class *pps_class;
 
 static DEFINE_MUTEX(pps_idr_lock);
@@ -62,7 +62,7 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
 	else {
 		unsigned long ticks;
 
-		dev_dbg(pps->dev, "timeout %lld.%09d\n",
+		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
 				(long long) fdata->timeout.sec,
 				fdata->timeout.nsec);
 		ticks = fdata->timeout.sec * HZ;
@@ -80,7 +80,7 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
 
 	/* Check for pending signals */
 	if (err == -ERESTARTSYS) {
-		dev_dbg(pps->dev, "pending signal caught\n");
+		dev_dbg(&pps->dev, "pending signal caught\n");
 		return -EINTR;
 	}
 
@@ -98,7 +98,7 @@ static long pps_cdev_ioctl(struct file *file,
 
 	switch (cmd) {
 	case PPS_GETPARAMS:
-		dev_dbg(pps->dev, "PPS_GETPARAMS\n");
+		dev_dbg(&pps->dev, "PPS_GETPARAMS\n");
 
 		spin_lock_irq(&pps->lock);
 
@@ -114,7 +114,7 @@ static long pps_cdev_ioctl(struct file *file,
 		break;
 
 	case PPS_SETPARAMS:
-		dev_dbg(pps->dev, "PPS_SETPARAMS\n");
+		dev_dbg(&pps->dev, "PPS_SETPARAMS\n");
 
 		/* Check the capabilities */
 		if (!capable(CAP_SYS_TIME))
@@ -124,14 +124,14 @@ static long pps_cdev_ioctl(struct file *file,
 		if (err)
 			return -EFAULT;
 		if (!(params.mode & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR))) {
-			dev_dbg(pps->dev, "capture mode unspecified (%x)\n",
+			dev_dbg(&pps->dev, "capture mode unspecified (%x)\n",
 								params.mode);
 			return -EINVAL;
 		}
 
 		/* Check for supported capabilities */
 		if ((params.mode & ~pps->info.mode) != 0) {
-			dev_dbg(pps->dev, "unsupported capabilities (%x)\n",
+			dev_dbg(&pps->dev, "unsupported capabilities (%x)\n",
 								params.mode);
 			return -EINVAL;
 		}
@@ -144,7 +144,7 @@ static long pps_cdev_ioctl(struct file *file,
 		/* Restore the read only parameters */
 		if ((params.mode & (PPS_TSFMT_TSPEC | PPS_TSFMT_NTPFP)) == 0) {
 			/* section 3.3 of RFC 2783 interpreted */
-			dev_dbg(pps->dev, "time format unspecified (%x)\n",
+			dev_dbg(&pps->dev, "time format unspecified (%x)\n",
 								params.mode);
 			pps->params.mode |= PPS_TSFMT_TSPEC;
 		}
@@ -165,7 +165,7 @@ static long pps_cdev_ioctl(struct file *file,
 		break;
 
 	case PPS_GETCAP:
-		dev_dbg(pps->dev, "PPS_GETCAP\n");
+		dev_dbg(&pps->dev, "PPS_GETCAP\n");
 
 		err = put_user(pps->info.mode, iuarg);
 		if (err)
@@ -176,7 +176,7 @@ static long pps_cdev_ioctl(struct file *file,
 	case PPS_FETCH: {
 		struct pps_fdata fdata;
 
-		dev_dbg(pps->dev, "PPS_FETCH\n");
+		dev_dbg(&pps->dev, "PPS_FETCH\n");
 
 		err = copy_from_user(&fdata, uarg, sizeof(struct pps_fdata));
 		if (err)
@@ -206,7 +206,7 @@ static long pps_cdev_ioctl(struct file *file,
 	case PPS_KC_BIND: {
 		struct pps_bind_args bind_args;
 
-		dev_dbg(pps->dev, "PPS_KC_BIND\n");
+		dev_dbg(&pps->dev, "PPS_KC_BIND\n");
 
 		/* Check the capabilities */
 		if (!capable(CAP_SYS_TIME))
@@ -218,7 +218,7 @@ static long pps_cdev_ioctl(struct file *file,
 
 		/* Check for supported capabilities */
 		if ((bind_args.edge & ~pps->info.mode) != 0) {
-			dev_err(pps->dev, "unsupported capabilities (%x)\n",
+			dev_err(&pps->dev, "unsupported capabilities (%x)\n",
 					bind_args.edge);
 			return -EINVAL;
 		}
@@ -227,7 +227,7 @@ static long pps_cdev_ioctl(struct file *file,
 		if (bind_args.tsformat != PPS_TSFMT_TSPEC ||
 				(bind_args.edge & ~PPS_CAPTUREBOTH) != 0 ||
 				bind_args.consumer != PPS_KC_HARDPPS) {
-			dev_err(pps->dev, "invalid kernel consumer bind"
+			dev_err(&pps->dev, "invalid kernel consumer bind"
 					" parameters (%x)\n", bind_args.edge);
 			return -EINVAL;
 		}
@@ -259,7 +259,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		struct pps_fdata fdata;
 		int err;
 
-		dev_dbg(pps->dev, "PPS_FETCH\n");
+		dev_dbg(&pps->dev, "PPS_FETCH\n");
 
 		err = copy_from_user(&compat, uarg, sizeof(struct pps_fdata_compat));
 		if (err)
@@ -296,20 +296,36 @@ static long pps_cdev_compat_ioctl(struct file *file,
 #define pps_cdev_compat_ioctl	NULL
 #endif
 
+static struct pps_device *pps_idr_get(unsigned long id)
+{
+	struct pps_device *pps;
+
+	mutex_lock(&pps_idr_lock);
+	pps = idr_find(&pps_idr, id);
+	if (pps)
+		get_device(&pps->dev);
+
+	mutex_unlock(&pps_idr_lock);
+	return pps;
+}
+
 static int pps_cdev_open(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
+	struct pps_device *pps = pps_idr_get(iminor(inode));
+
+	if (!pps)
+		return -ENODEV;
+
 	file->private_data = pps;
-	kobject_get(&pps->dev->kobj);
 	return 0;
 }
 
 static int pps_cdev_release(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
-	kobject_put(&pps->dev->kobj);
+	struct pps_device *pps = file->private_data;
+
+	WARN_ON(pps->id != iminor(inode));
+	put_device(&pps->dev);
 	return 0;
 }
 
@@ -331,22 +347,13 @@ static void pps_device_destruct(struct device *dev)
 {
 	struct pps_device *pps = dev_get_drvdata(dev);
 
-	cdev_del(&pps->cdev);
-
-	/* Now we can release the ID for re-use */
 	pr_debug("deallocating pps%d\n", pps->id);
-	mutex_lock(&pps_idr_lock);
-	idr_remove(&pps_idr, pps->id);
-	mutex_unlock(&pps_idr_lock);
-
-	kfree(dev);
 	kfree(pps);
 }
 
 int pps_register_cdev(struct pps_device *pps)
 {
 	int err;
-	dev_t devt;
 
 	mutex_lock(&pps_idr_lock);
 	/*
@@ -363,40 +370,29 @@ int pps_register_cdev(struct pps_device *pps)
 		goto out_unlock;
 	}
 	pps->id = err;
-	mutex_unlock(&pps_idr_lock);
-
-	devt = MKDEV(MAJOR(pps_devt), pps->id);
-
-	cdev_init(&pps->cdev, &pps_cdev_fops);
-	pps->cdev.owner = pps->info.owner;
 
-	err = cdev_add(&pps->cdev, devt, 1);
-	if (err) {
-		pr_err("%s: failed to add char device %d:%d\n",
-				pps->info.name, MAJOR(pps_devt), pps->id);
+	pps->dev.class = pps_class;
+	pps->dev.parent = pps->info.dev;
+	pps->dev.devt = MKDEV(pps_major, pps->id);
+	dev_set_drvdata(&pps->dev, pps);
+	dev_set_name(&pps->dev, "pps%d", pps->id);
+	err = device_register(&pps->dev);
+	if (err)
 		goto free_idr;
-	}
-	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
-							"pps%d", pps->id);
-	if (IS_ERR(pps->dev)) {
-		err = PTR_ERR(pps->dev);
-		goto del_cdev;
-	}
 
 	/* Override the release function with our own */
-	pps->dev->release = pps_device_destruct;
+	pps->dev.release = pps_device_destruct;
 
-	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name,
-			MAJOR(pps_devt), pps->id);
+	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
+		 pps->id);
 
+	get_device(&pps->dev);
+	mutex_unlock(&pps_idr_lock);
 	return 0;
 
-del_cdev:
-	cdev_del(&pps->cdev);
-
 free_idr:
-	mutex_lock(&pps_idr_lock);
 	idr_remove(&pps_idr, pps->id);
+	put_device(&pps->dev);
 out_unlock:
 	mutex_unlock(&pps_idr_lock);
 	return err;
@@ -406,7 +402,13 @@ void pps_unregister_cdev(struct pps_device *pps)
 {
 	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
-	device_destroy(pps_class, pps->dev->devt);
+	device_destroy(pps_class, pps->dev.devt);
+
+	/* Now we can release the ID for re-use */
+	mutex_lock(&pps_idr_lock);
+	idr_remove(&pps_idr, pps->id);
+	put_device(&pps->dev);
+	mutex_unlock(&pps_idr_lock);
 }
 
 /*
@@ -426,6 +428,11 @@ void pps_unregister_cdev(struct pps_device *pps)
  * so that it will not be used again, even if the pps device cannot
  * be removed from the idr due to pending references holding the minor
  * number in use.
+ *
+ * Since pps_idr holds a reference to the device, the returned
+ * pps_device is guaranteed to be valid until pps_unregister_cdev() is
+ * called on it. But after calling pps_unregister_cdev(), it may be
+ * freed at any time.
  */
 struct pps_device *pps_lookup_dev(void const *cookie)
 {
@@ -448,13 +455,11 @@ EXPORT_SYMBOL(pps_lookup_dev);
 static void __exit pps_exit(void)
 {
 	class_destroy(pps_class);
-	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
+	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
 }
 
 static int __init pps_init(void)
 {
-	int err;
-
 	pps_class = class_create("pps");
 	if (IS_ERR(pps_class)) {
 		pr_err("failed to allocate class\n");
@@ -462,8 +467,9 @@ static int __init pps_init(void)
 	}
 	pps_class->dev_groups = pps_groups;
 
-	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
-	if (err < 0) {
+	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
+				      &pps_cdev_fops);
+	if (pps_major < 0) {
 		pr_err("failed to allocate char device region\n");
 		goto remove_class;
 	}
@@ -476,8 +482,7 @@ static int __init pps_init(void)
 
 remove_class:
 	class_destroy(pps_class);
-
-	return err;
+	return pps_major;
 }
 
 subsys_initcall(pps_init);
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index ea96a14d72d1..bf6468c56419 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/poll.h>
@@ -176,6 +177,9 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct timespec64 ts;
 	int enable, err = 0;
 
+	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
+		arg = (unsigned long)compat_ptr(arg);
+
 	tsevq = pccontext->private_clkdata;
 
 	switch (cmd) {
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 5feecaadde8e..120db96d9e95 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4420,7 +4420,7 @@ ptp_ocp_complete(struct ptp_ocp *bp)
 
 	pps = pps_lookup_dev(bp->ptp);
 	if (pps)
-		ptp_ocp_symlink(bp, pps->dev, "pps");
+		ptp_ocp_symlink(bp, &pps->dev, "pps");
 
 	ptp_ocp_debugfs_add_device(bp);
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 210368099a06..174939359ae3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2011-2012 Avionic Design GmbH
  */
 
-#define DEFAULT_SYMBOL_NAMESPACE PWM
+#define DEFAULT_SYMBOL_NAMESPACE "PWM"
 
 #include <linux/acpi.h>
 #include <linux/module.h>
diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index c8425493b95d..6dabec93a3c6 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -9,7 +9,7 @@
  * Author: Raymond Tan <raymond.tan@intel.com>
  */
 
-#define DEFAULT_SYMBOL_NAMESPACE dwc_pwm
+#define DEFAULT_SYMBOL_NAMESPACE "dwc_pwm"
 
 #include <linux/bitops.h>
 #include <linux/export.h>
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 867e2bc8c601..3b99feb3bb49 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -19,7 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/time.h>
 
-#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
+#define DEFAULT_SYMBOL_NAMESPACE "PWM_LPSS"
 
 #include "pwm-lpss.h"
 
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 989731256f50..5832dce8ed9d 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -167,8 +167,12 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *chip,
 	regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
 	state->enabled = !!FIELD_GET(STM32_LPTIM_ENABLE, val);
 	/* Keep PWM counter clock refcount in sync with PWM initial state */
-	if (state->enabled)
-		clk_enable(priv->clk);
+	if (state->enabled) {
+		int ret = clk_enable(priv->clk);
+
+		if (ret)
+			return ret;
+	}
 
 	regmap_read(priv->regmap, STM32_LPTIM_CFGR, &val);
 	presc = FIELD_GET(STM32_LPTIM_PRESC, val);
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index eb24054f9729..4f231f8aae7d 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -688,8 +688,11 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	chip->ops = &stm32pwm_ops;
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
-	for (i = 0; i < num_enabled; i++)
-		clk_enable(priv->clk);
+	for (i = 0; i < num_enabled; i++) {
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
 
 	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1179766811f5..4bb2652740d0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4946,7 +4946,7 @@ int _regulator_bulk_get(struct device *dev, int num_consumers,
 						       consumers[i].supply, get_type);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
-					    "Failed to get supply '%s'",
+					    "Failed to get supply '%s'\n",
 					    consumers[i].supply);
 			consumers[i].consumer = NULL;
 			goto err;
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3f490d81abc2..deab0b95b663 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -446,7 +446,7 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 					"failed to parse DT for regulator %pOFn\n",
 					child);
 				of_node_put(child);
-				return -EINVAL;
+				goto err_put;
 			}
 			match->of_node = of_node_get(child);
 			count++;
@@ -455,6 +455,18 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 	}
 
 	return count;
+
+err_put:
+	for (i = 0; i < num_matches; i++) {
+		struct of_regulator_match *match = &matches[i];
+
+		match->init_data = NULL;
+		if (match->of_node) {
+			of_node_put(match->of_node);
+			match->of_node = NULL;
+		}
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(of_regulator_match);
 
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index e744c07507ee..f98a11d4cf29 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1326,6 +1326,11 @@ static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_clus
 	return ret;
 }
 
+static const struct of_device_id scp_core_match[] = {
+	{ .compatible = "mediatek,scp-core" },
+	{}
+};
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1357,13 +1362,15 @@ static int scp_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
 	mutex_init(&scp_cluster->cluster_lock);
 
-	ret = devm_of_platform_populate(dev);
+	ret = of_platform_populate(dev_of_node(dev), scp_core_match, NULL, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
 
 	ret = scp_cluster_init(pdev, scp_cluster);
-	if (ret)
+	if (ret) {
+		of_platform_depopulate(dev);
 		return ret;
+	}
 
 	return 0;
 }
@@ -1379,6 +1386,7 @@ static void scp_remove(struct platform_device *pdev)
 		rproc_del(scp->rproc);
 		scp_free(scp);
 	}
+	of_platform_depopulate(&pdev->dev);
 	mutex_destroy(&scp_cluster->cluster_lock);
 }
 
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f276956f2c5c..ef6febe35633 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2486,6 +2486,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	rproc->dev.driver_data = rproc;
 	idr_init(&rproc->notifyids);
 
+	/* Assign a unique device index and name */
+	rproc->index = ida_alloc(&rproc_dev_index, GFP_KERNEL);
+	if (rproc->index < 0) {
+		dev_err(dev, "ida_alloc failed: %d\n", rproc->index);
+		goto put_device;
+	}
+
 	rproc->name = kstrdup_const(name, GFP_KERNEL);
 	if (!rproc->name)
 		goto put_device;
@@ -2496,13 +2503,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (rproc_alloc_ops(rproc, ops))
 		goto put_device;
 
-	/* Assign a unique device index and name */
-	rproc->index = ida_alloc(&rproc_dev_index, GFP_KERNEL);
-	if (rproc->index < 0) {
-		dev_err(dev, "ida_alloc failed: %d\n", rproc->index);
-		goto put_device;
-	}
-
 	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
 
 	atomic_set(&rproc->power, 0);
diff --git a/drivers/rtc/rtc-loongson.c b/drivers/rtc/rtc-loongson.c
index e8ffc1ab90b0..90e9d97a86b4 100644
--- a/drivers/rtc/rtc-loongson.c
+++ b/drivers/rtc/rtc-loongson.c
@@ -114,6 +114,13 @@ static irqreturn_t loongson_rtc_isr(int irq, void *id)
 	struct loongson_rtc_priv *priv = (struct loongson_rtc_priv *)id;
 
 	rtc_update_irq(priv->rtcdev, 1, RTC_AF | RTC_IRQF);
+
+	/*
+	 * The TOY_MATCH0_REG should be cleared 0 here,
+	 * otherwise the interrupt cannot be cleared.
+	 */
+	regmap_write(priv->regmap, TOY_MATCH0_REG, 0);
+
 	return IRQ_HANDLED;
 }
 
@@ -131,11 +138,7 @@ static u32 loongson_rtc_handler(void *id)
 	writel(RTC_STS, priv->pm_base + PM1_STS_REG);
 	spin_unlock(&priv->lock);
 
-	/*
-	 * The TOY_MATCH0_REG should be cleared 0 here,
-	 * otherwise the interrupt cannot be cleared.
-	 */
-	return regmap_write(priv->regmap, TOY_MATCH0_REG, 0);
+	return ACPI_INTERRUPT_HANDLED;
 }
 
 static int loongson_rtc_set_enabled(struct device *dev)
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index fdbc07f14036..905986c61655 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -322,7 +322,16 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 static int pcf85063_nvmem_read(void *priv, unsigned int offset,
 			       void *val, size_t bytes)
 {
-	return regmap_read(priv, PCF85063_REG_RAM, val);
+	unsigned int tmp;
+	int ret;
+
+	ret = regmap_read(priv, PCF85063_REG_RAM, &tmp);
+	if (ret < 0)
+		return ret;
+
+	*(u8 *)val = tmp;
+
+	return 0;
 }
 
 static int pcf85063_nvmem_write(void *priv, unsigned int offset,
diff --git a/drivers/rtc/rtc-tps6594.c b/drivers/rtc/rtc-tps6594.c
index e69667634137..7c6246e3f029 100644
--- a/drivers/rtc/rtc-tps6594.c
+++ b/drivers/rtc/rtc-tps6594.c
@@ -37,7 +37,7 @@
 #define MAX_OFFSET (277774)
 
 // Number of ticks per hour
-#define TICKS_PER_HOUR (32768 * 3600)
+#define TICKS_PER_HOUR (32768 * 3600LL)
 
 // Multiplier for ppb conversions
 #define PPB_MULT NANO
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index fbffd451031f..45bd001206a2 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -245,7 +245,6 @@ static void sclp_request_timeout(bool force_restart);
 static void sclp_process_queue(void);
 static void __sclp_make_read_req(void);
 static int sclp_init_mask(int calculate);
-static int sclp_init(void);
 
 static void
 __sclp_queue_read_req(void)
@@ -1251,8 +1250,7 @@ static struct platform_driver sclp_pdrv = {
 
 /* Initialize SCLP driver. Return zero if driver is operational, non-zero
  * otherwise. */
-static int
-sclp_init(void)
+int sclp_init(void)
 {
 	unsigned long flags;
 	int rc = 0;
@@ -1305,13 +1303,7 @@ sclp_init(void)
 
 static __init int sclp_initcall(void)
 {
-	int rc;
-
-	rc = platform_driver_register(&sclp_pdrv);
-	if (rc)
-		return rc;
-
-	return sclp_init();
+	return platform_driver_register(&sclp_pdrv);
 }
 
 arch_initcall(sclp_initcall);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 10b8e4dc64f8..7589f48aebc8 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -2951,6 +2951,7 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 		.max_hw_sectors		= MPI3MR_MAX_APP_XFER_SECTORS,
 		.max_segments		= MPI3MR_MAX_APP_XFER_SEGMENTS,
 	};
+	struct request_queue *q;
 
 	device_initialize(bsg_dev);
 
@@ -2966,14 +2967,17 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 		return;
 	}
 
-	mrioc->bsg_queue = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
+	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
 			mpi3mr_bsg_request, NULL, 0);
-	if (IS_ERR(mrioc->bsg_queue)) {
+	if (IS_ERR(q)) {
 		ioc_err(mrioc, "%s: bsg registration failed\n",
 		    dev_name(bsg_dev));
 		device_del(bsg_dev);
 		put_device(bsg_dev);
+		return;
 	}
+
+	mrioc->bsg_queue = q;
 }
 
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 16ac2267c71e..c1d8f2c91a5e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5629,8 +5629,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	if (!ioc->is_gen35_ioc && ioc->manu_pg11.EEDPTagMode == 0) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
-		ioc->manu_pg11.EEDPTagMode &= ~0x3;
-		ioc->manu_pg11.EEDPTagMode |= 0x1;
+		ioc->manu_pg11.EEDPTagMode = 0x1;
 		mpt3sas_config_set_manufacturing_pg11(ioc, &mpi_reply,
 		    &ioc->manu_pg11);
 	}
diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 2a42b28931c9..298b542dd1c0 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -399,7 +399,7 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 
 static int __init atmel_soc_device_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 
 	if (!of_match_node(at91_soc_allowed_list, np))
 		return 0;
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 4a2f84c4d22e..532b2e9c31d0 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1561,10 +1561,15 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (IS_ERR(mcspi->ref_clk))
-		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
-	else
+	if (IS_ERR(mcspi->ref_clk)) {
+		status = PTR_ERR(mcspi->ref_clk);
+		dev_err_probe(&pdev->dev, status, "Failed to get ref_clk");
+		goto free_ctlr;
+	}
+	if (mcspi->ref_clk)
 		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
+	else
+		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
 	ctlr->max_speed_hz = mcspi->ref_clk_hz;
 	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
 
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index b67455bda972..de4c18247432 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -379,12 +379,21 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
+	int ret;
 
 	if (ctlr->busy)
 		return -EBUSY;
 
-	clk_enable(qspi->refclk);
-	clk_enable(qspi->pclk);
+	ret = clk_enable(qspi->refclk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(qspi->pclk);
+	if (ret) {
+		clk_disable(qspi->refclk);
+		return ret;
+	}
+
 	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 
diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index 118bff988bc7..bb28daa4d713 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -54,22 +54,18 @@ int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
 			break;
 
 		ret = imx_media_of_add_csi(imxmd, csi_np);
+		of_node_put(csi_np);
 		if (ret) {
 			/* unavailable or already added is not an error */
 			if (ret == -ENODEV || ret == -EEXIST) {
-				of_node_put(csi_np);
 				continue;
 			}
 
 			/* other error, can't continue */
-			goto err_out;
+			return ret;
 		}
 	}
 
 	return 0;
-
-err_out:
-	of_node_put(csi_np);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(imx_media_add_of_subdevs);
diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/media/max96712/max96712.c
index 6bdbccbee05a..b528727ada75 100644
--- a/drivers/staging/media/max96712/max96712.c
+++ b/drivers/staging/media/max96712/max96712.c
@@ -421,7 +421,6 @@ static int max96712_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	priv->client = client;
-	i2c_set_clientdata(client, priv);
 
 	priv->regmap = devm_regmap_init_i2c(client, &max96712_i2c_regmap);
 	if (IS_ERR(priv->regmap))
@@ -454,7 +453,8 @@ static int max96712_probe(struct i2c_client *client)
 
 static void max96712_remove(struct i2c_client *client)
 {
-	struct max96712_priv *priv = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct max96712_priv *priv = container_of(sd, struct max96712_priv, sd);
 
 	v4l2_async_unregister_subdev(&priv->sd);
 
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index afbf7738c7c4..58b28be63c79 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1154,7 +1154,7 @@ static char kgdbfdc_rbuf[4];
 
 /* write buffer to allow compaction */
 static unsigned int kgdbfdc_wbuflen;
-static char kgdbfdc_wbuf[4];
+static u8 kgdbfdc_wbuf[4];
 
 static void __iomem *kgdbfdc_setup(void)
 {
@@ -1215,7 +1215,7 @@ static int kgdbfdc_read_char(void)
 /* push an FDC word from write buffer to TX FIFO */
 static void kgdbfdc_push_one(void)
 {
-	const char *bufs[1] = { kgdbfdc_wbuf };
+	const u8 *bufs[1] = { kgdbfdc_wbuf };
 	struct fdc_word word;
 	void __iomem *regs;
 	unsigned int i;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7dc52b..11519aa2598a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2059,7 +2059,8 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-static void wait_for_lsr(struct uart_8250_port *up, int bits)
+/* Returns true if @bits were set, false on timeout */
+static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
@@ -2074,11 +2075,11 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
 		udelay(1);
 		touch_nmi_watchdog();
 	}
+
+	return (tmout != 0);
 }
 
-/*
- *	Wait for transmitter & holding register to empty
- */
+/* Wait for transmitter and holding register to empty with timeout */
 static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 {
 	unsigned int tmout;
@@ -3297,6 +3298,16 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
+static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			return;
+	}
+}
+
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3306,13 +3317,15 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 static void serial8250_console_fifo_write(struct uart_8250_port *up,
 					  const char *s, unsigned int count)
 {
-	int i;
 	const char *end = s + count;
 	unsigned int fifosize = up->tx_loadsz;
+	unsigned int tx_count = 0;
 	bool cr_sent = false;
+	unsigned int i;
 
 	while (s != end) {
-		wait_for_lsr(up, UART_LSR_THRE);
+		/* Allow timeout for each byte of a possibly full FIFO */
+		fifo_wait_for_lsr(up, fifosize);
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3323,7 +3336,14 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 				cr_sent = false;
 			}
 		}
+		tx_count = i;
 	}
+
+	/*
+	 * Allow timeout for each byte written since the caller will only wait
+	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
+	 */
+	fifo_wait_for_lsr(up, tx_count);
 }
 
 /*
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ad88a33a504f..6a0a1cce3a89 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -8,7 +8,7 @@
  */
 
 #undef DEFAULT_SYMBOL_NAMESPACE
-#define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
+#define DEFAULT_SYMBOL_NAMESPACE "SERIAL_NXP_SC16IS7XX"
 
 #include <linux/bits.h>
 #include <linux/clk.h>
diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 6c09d97ae006..58023f735c19 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -257,6 +257,7 @@ int ufs_bsg_probe(struct ufs_hba *hba)
 			NULL, 0);
 	if (IS_ERR(q)) {
 		ret = PTR_ERR(q);
+		device_del(bsg_dev);
 		goto out;
 	}
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 98114c2827c0..244e3e04e1ad 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1660,8 +1660,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
-	const char		*usb_psy_name;
-	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1696,13 +1694,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
 
-	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
-	if (ret >= 0) {
-		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
-		if (!dwc->usb_psy)
-			dev_err(dev, "couldn't get usb power supply\n");
-	}
-
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
 	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
@@ -2105,6 +2096,23 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	return 0;
 }
 
+static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
+{
+	struct power_supply *usb_psy;
+	const char *usb_psy_name;
+	int ret;
+
+	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
+	if (ret < 0)
+		return NULL;
+
+	usb_psy = power_supply_get_by_name(usb_psy_name);
+	if (!usb_psy)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return usb_psy;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -2161,6 +2169,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_software_properties(dwc);
 
+	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
+	if (IS_ERR(dwc->usb_psy))
+		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
@@ -2585,12 +2597,15 @@ static int dwc3_resume(struct device *dev)
 	pinctrl_pm_select_default_state(dev);
 
 	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto out;
 
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret)
 		pm_runtime_set_suspended(dev);
 
+out:
 	pm_runtime_enable(dev);
 
 	return ret;
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 538185a4d1b4..c507e576bbe0 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -166,6 +166,7 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 	if (ret)
 		return ret;
 
+	of_node_put(args.np);
 	am62->offset = args.args[0];
 
 	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 15bb3aa12aa8..48dee166e5d8 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1066,7 +1066,6 @@ static void usbg_cmd_work(struct work_struct *work)
 out:
 	transport_send_check_condition_and_sense(se_cmd,
 			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
@@ -1195,7 +1194,6 @@ static void bot_cmd_work(struct work_struct *work)
 out:
 	transport_send_check_condition_and_sense(se_cmd,
 				TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
 static int bot_submit_command(struct f_uas *fu,
@@ -2051,9 +2049,14 @@ static void tcm_delayed_set_alt(struct work_struct *wq)
 
 static int tcm_get_alt(struct usb_function *f, unsigned intf)
 {
-	if (intf == bot_intf_desc.bInterfaceNumber)
+	struct f_uas *fu = to_f_uas(f);
+
+	if (fu->iface != intf)
+		return -EOPNOTSUPP;
+
+	if (fu->flags & USBG_IS_BOT)
 		return USB_G_ALT_INT_BBB;
-	if (intf == uasp_intf_desc.bInterfaceNumber)
+	else if (fu->flags & USBG_IS_UAS)
 		return USB_G_ALT_INT_UAS;
 
 	return -EOPNOTSUPP;
@@ -2063,6 +2066,9 @@ static int tcm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 {
 	struct f_uas *fu = to_f_uas(f);
 
+	if (fu->iface != intf)
+		return -EOPNOTSUPP;
+
 	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
 		struct guas_setup_wq *work;
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b267dae14d39..4384b86ea7b6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -422,7 +422,8 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci);
+		if (cur_cmd)
+			xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
index 46635fa4a340..28db337f190b 100644
--- a/drivers/usb/storage/Makefile
+++ b/drivers/usb/storage/Makefile
@@ -8,7 +8,7 @@
 
 ccflags-y := -I $(srctree)/drivers/scsi
 
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE='"USB_STORAGE"'
 
 obj-$(CONFIG_USB_UAS)		+= uas.o
 obj-$(CONFIG_USB_STORAGE)	+= usb-storage.o
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 24a6a4354df8..b2c83f552da5 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -27,6 +27,7 @@
 #define	VPPS_NEW_MIN_PERCENT			95
 #define	VPPS_VALID_MIN_MV			100
 #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
+#define	VPPS_SHUTDOWN_MIN_PERCENT		85
 
 struct tcpci {
 	struct device *dev;
@@ -366,7 +367,8 @@ static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
 }
 
 static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-						   bool pps_active, u32 requested_vbus_voltage_mv)
+						   bool pps_active, u32 requested_vbus_voltage_mv,
+						   u32 apdo_min_voltage_mv)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
 	unsigned int pwr_ctrl, threshold = 0;
@@ -388,9 +390,12 @@ static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum ty
 		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
 	} else if (mode == TYPEC_PWR_MODE_PD) {
 		if (pps_active)
-			threshold = ((VPPS_NEW_MIN_PERCENT * requested_vbus_voltage_mv / 100) -
-				     VSINKPD_MIN_IR_DROP_MV - VPPS_VALID_MIN_MV) *
-				     VSINKDISCONNECT_PD_MIN_PERCENT / 100;
+			/*
+			 * To prevent disconnect when the source is in Current Limit Mode.
+			 * Set the threshold to the lowest possible voltage vPpsShutdown (min)
+			 */
+			threshold = VPPS_SHUTDOWN_MIN_PERCENT * apdo_min_voltage_mv / 100 -
+				    VSINKPD_MIN_IR_DROP_MV;
 		else
 			threshold = ((VSRC_NEW_MIN_PERCENT * requested_vbus_voltage_mv / 100) -
 				     VSINKPD_MIN_IR_DROP_MV - VSRC_VALID_MIN_MV) *
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 7ae341a40342..48ddf2770461 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2928,10 +2928,12 @@ static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port,
 		return 0;
 
 	ret = port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc, mode, pps_active,
-							    requested_vbus_voltage);
+							    requested_vbus_voltage,
+							    port->pps_data.min_volt);
 	tcpm_log_force(port,
-		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u ret:%d",
-		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage, ret);
+		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u pps_apdo_min_volt:%u ret:%d",
+		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage,
+		       port->pps_data.min_volt, ret);
 
 	return ret;
 }
@@ -4757,7 +4759,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->caps_count = 0;
 			port->pd_capable = true;
 			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
-					    PD_T_SEND_SOURCE_CAP);
+					    PD_T_SENDER_RESPONSE);
 		}
 		break;
 	case SRC_SEND_CAPABILITIES_TIMEOUT:
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
index d5a43b3bf45e..c46108a16a9d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -102,6 +102,7 @@ struct device_node *dss_of_port_get_parent_device(struct device_node *port)
 		np = of_get_next_parent(np);
 	}
 
+	of_node_put(np);
 	return NULL;
 }
 
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 563d842014df..cc239251e193 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -301,6 +301,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
 	if (node) {
 		ret = of_address_to_resource(node, 0, &res);
+		of_node_put(node);
 		if (ret) {
 			dev_err(dev, "No memory address assigned to the region.\n");
 			goto err_iomap;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ada363af5aab..50edd1cae28a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1472,7 +1472,12 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 		op->file[1].vnode = vnode;
 	}
 
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+
+	/* Not all systems that can host afs servers have ENOTEMPTY. */
+	if (ret == -EEXIST)
+		ret = -ENOTEMPTY;
+	return ret;
 
 error:
 	return afs_put_operation(op);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c9d620175e80..d9760b2a8d8d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1346,6 +1346,15 @@ extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 
+static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
+{
+	int r = refcount_read(&call->ref);
+
+	trace_afs_call(call->debug_id, why, r,
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
+}
+
 static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
 				    gfp_t gfp)
 {
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 9f2a3bb56ec6..a122c6366ce1 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -430,11 +430,16 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	return;
 
 error_do_abort:
-	if (ret != -ECONNABORTED) {
+	if (ret != -ECONNABORTED)
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret,
 					afs_abort_send_data_error);
-	} else {
+	if (call->async) {
+		afs_see_call(call, afs_call_trace_async_abort);
+		return;
+	}
+
+	if (ret == -ECONNABORTED) {
 		len = 0;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
@@ -445,6 +450,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	call->error = ret;
 	trace_afs_call_done(call);
 error_kill_call:
+	if (call->async)
+		afs_see_call(call, afs_call_trace_async_kill);
 	if (call->type->done)
 		call->type->done(call);
 
@@ -602,7 +609,6 @@ static void afs_deliver_to_call(struct afs_call *call)
 	abort_code = 0;
 call_complete:
 	afs_set_call_complete(call, ret, remote_abort);
-	state = AFS_CALL_COMPLETE;
 	goto done;
 }
 
diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 8ca868164507..cc5f143d21a3 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -88,7 +88,7 @@ union afs_xdr_dir_block {
 
 	struct {
 		struct afs_xdr_dir_hdr	hdr;
-		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		u8			alloc_ctrs[AFS_DIR_BLOCKS_WITH_CTR];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
 	} meta;
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 024227aba4cd..362845f9aaae 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -666,8 +666,9 @@ static int yfs_deliver_fs_remove_file2(struct afs_call *call)
 static void yfs_done_fs_remove_file2(struct afs_call *call)
 {
 	if (call->error == -ECONNABORTED &&
-	    call->abort_code == RX_INVALID_OPERATION) {
-		set_bit(AFS_SERVER_FL_NO_RM2, &call->server->flags);
+	    (call->abort_code == RX_INVALID_OPERATION ||
+	     call->abort_code == RXGEN_OPCODE)) {
+		set_bit(AFS_SERVER_FL_NO_RM2, &call->op->server->flags);
 		call->op->flags |= AFS_OPERATION_DOWNGRADE;
 	}
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a3c861b2a6d2..9d9ce308488d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2001,6 +2001,53 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	return ret < 0 ? ret : can_nocow;
 }
 
+/*
+ * Cleanup the dirty folios which will never be submitted due to error.
+ *
+ * When running a delalloc range, we may need to split the ranges (due to
+ * fragmentation or NOCOW). If we hit an error in the later part, we will error
+ * out and previously successfully executed range will never be submitted, thus
+ * we have to cleanup those folios by clearing their dirty flag, starting and
+ * finishing the writeback.
+ */
+static void cleanup_dirty_folios(struct btrfs_inode *inode,
+				 struct folio *locked_folio,
+				 u64 start, u64 end, int error)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
+	u32 len;
+
+	ASSERT(end + 1 - start < U32_MAX);
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(end + 1, fs_info->sectorsize));
+	len = end + 1 - start;
+
+	/*
+	 * Handle the locked folio first.
+	 * The btrfs_folio_clamp_*() helpers can handle range out of the folio case.
+	 */
+	btrfs_folio_clamp_finish_io(fs_info, locked_folio, start, len);
+
+	for (pgoff_t index = start_index; index <= end_index; index++) {
+		struct folio *folio;
+
+		/* Already handled at the beginning. */
+		if (index == locked_folio->index)
+			continue;
+		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
+		/* Cache already dropped, no need to do any cleanup. */
+		if (IS_ERR(folio))
+			continue;
+		btrfs_folio_clamp_finish_io(fs_info, locked_folio, start, len);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	mapping_set_error(mapping, error);
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -2016,6 +2063,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_path *path;
 	u64 cow_start = (u64)-1;
+	/*
+	 * If not 0, represents the inclusive end of the last fallback_to_cow()
+	 * range. Only for error handling.
+	 */
+	u64 cow_end = 0;
 	u64 cur_offset = start;
 	int ret;
 	bool check_prev = true;
@@ -2176,6 +2228,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					      found_key.offset - 1);
 			cow_start = (u64)-1;
 			if (ret) {
+				cow_end = found_key.offset - 1;
 				btrfs_dec_nocow_writers(nocow_bg);
 				goto error;
 			}
@@ -2249,24 +2302,54 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		cow_start = cur_offset;
 
 	if (cow_start != (u64)-1) {
-		cur_offset = end;
 		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
 		cow_start = (u64)-1;
-		if (ret)
+		if (ret) {
+			cow_end = end;
 			goto error;
+		}
 	}
 
 	btrfs_free_path(path);
 	return 0;
 
 error:
+	/*
+	 * There are several error cases:
+	 *
+	 * 1) Failed without falling back to COW
+	 *    start         cur_offset             end
+	 *    |/////////////|                      |
+	 *
+	 *    For range [start, cur_offset) the folios are already unlocked (except
+	 *    @locked_folio), EXTENT_DELALLOC already removed.
+	 *    Only need to clear the dirty flag as they will never be submitted.
+	 *    Ordered extent and extent maps are handled by
+	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
+	 *
+	 * 2) Failed with error from fallback_to_cow()
+	 *    start         cur_offset  cow_end    end
+	 *    |/////////////|-----------|          |
+	 *
+	 *    For range [start, cur_offset) it's the same as case 1).
+	 *    But for range [cur_offset, cow_end), the folios have dirty flag
+	 *    cleared and unlocked, EXTENT_DEALLLOC cleared by cow_file_range().
+	 *
+	 *    Thus we should not call extent_clear_unlock_delalloc() on range
+	 *    [cur_offset, cow_end), as the folios are already unlocked.
+	 *
+	 * So clear the folio dirty flags for [start, cur_offset) first.
+	 */
+	if (cur_offset > start)
+		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+
 	/*
 	 * If an error happened while a COW region is outstanding, cur_offset
-	 * needs to be reset to cow_start to ensure the COW region is unlocked
-	 * as well.
+	 * needs to be reset to @cow_end + 1 to skip the COW range, as
+	 * cow_file_range() will do the proper cleanup at error.
 	 */
-	if (cow_start != (u64)-1)
-		cur_offset = cow_start;
+	if (cow_end)
+		cur_offset = cow_end + 1;
 
 	/*
 	 * We need to lock the extent here because we're clearing DELALLOC and
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e70ed857fc74..4fcd6cd4c1c2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1839,9 +1839,19 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	 * Thus its reserved space should all be zero, no matter if qgroup
 	 * is consistent or the mode.
 	 */
-	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
+	if (qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
+	    qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
+	    qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_warn_rl(fs_info,
+"to be deleted qgroup %u/%llu has non-zero numbers, data %llu meta prealloc %llu meta pertrans %llu",
+			      btrfs_qgroup_level(qgroup->qgroupid),
+			      btrfs_qgroup_subvolid(qgroup->qgroupid),
+			      qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA],
+			      qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC],
+			      qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
+
+	}
 	/*
 	 * The same for rfer/excl numbers, but that's only if our qgroup is
 	 * consistent and if it's in regular qgroup mode.
@@ -1850,8 +1860,9 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	 */
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
 	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
-		if (WARN_ON(qgroup->rfer || qgroup->excl ||
-			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
+		if (qgroup->rfer || qgroup->excl ||
+		    qgroup->rfer_cmpr || qgroup->excl_cmpr) {
+			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 			btrfs_warn_rl(fs_info,
 "to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
 				      btrfs_qgroup_level(qgroup->qgroupid),
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index fe4d719d506b..ec7328a6bfd7 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -868,6 +868,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	unsigned long writeback_bitmap;
 	unsigned long ordered_bitmap;
 	unsigned long checked_bitmap;
+	unsigned long locked_bitmap;
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
@@ -880,15 +881,16 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	GET_SUBPAGE_BITMAP(subpage, fs_info, writeback, &writeback_bitmap);
 	GET_SUBPAGE_BITMAP(subpage, fs_info, ordered, &ordered_bitmap);
 	GET_SUBPAGE_BITMAP(subpage, fs_info, checked, &checked_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &checked_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &locked_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
 	btrfs_warn(fs_info,
-"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
+"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl locked=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
 		    start, len, folio_pos(folio),
 		    sectors_per_page, &uptodate_bitmap,
 		    sectors_per_page, &dirty_bitmap,
+		    sectors_per_page, &locked_bitmap,
 		    sectors_per_page, &writeback_bitmap,
 		    sectors_per_page, &ordered_bitmap,
 		    sectors_per_page, &checked_bitmap);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 4b85d91d0e18..cdb554e0d215 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -152,6 +152,19 @@ DECLARE_BTRFS_SUBPAGE_OPS(writeback);
 DECLARE_BTRFS_SUBPAGE_OPS(ordered);
 DECLARE_BTRFS_SUBPAGE_OPS(checked);
 
+/*
+ * Helper for error cleanup, where a folio will have its dirty flag cleared,
+ * with writeback started and finished.
+ */
+static inline void btrfs_folio_clamp_finish_io(struct btrfs_fs_info *fs_info,
+					       struct folio *locked_folio,
+					       u64 start, u32 len)
+{
+	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
+	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
+	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);
+}
+
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 					struct folio *folio, u64 start, u32 len);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8292e488d3d7..73343503ea60 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -972,7 +972,7 @@ static int btrfs_fill_super(struct super_block *sb,
 
 	err = open_ctree(sb, fs_devices);
 	if (err) {
-		btrfs_err(fs_info, "open_ctree failed");
+		btrfs_err(fs_info, "open_ctree failed: %d", err);
 		return err;
 	}
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index dddedaef5e93..0c01e4423ee2 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -824,9 +824,12 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		r->res_first_lkid = 0;
 	}
 
-	/* A dir record will not be on the scan list. */
-	if (r->res_dir_nodeid != our_nodeid)
-		del_scan(ls, r);
+	/* we always deactivate scan timer for the rsb, when
+	 * we move it out of the inactive state as rsb state
+	 * can be changed and scan timers are only for inactive
+	 * rsbs.
+	 */
+	del_scan(ls, r);
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
 	kref_init(&r->res_ref); /* ref is now used in active state */
@@ -989,10 +992,10 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		r->res_nodeid = 0;
 	}
 
+	del_scan(ls, r);
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
 	kref_init(&r->res_ref);
-	del_scan(ls, r);
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	goto out;
@@ -1337,9 +1340,13 @@ static int _dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *na
 	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
 			    r_nodeid, result);
 
-	/* A dir record rsb should never be on scan list. */
-	/* Try to fix this with del_scan? */
-	WARN_ON(!list_empty(&r->res_scan_list));
+	/* A dir record rsb should never be on scan list.
+	 * Except when we are the dir and master node.
+	 * This function should only be called by the dir
+	 * node.
+	 */
+	WARN_ON(!list_empty(&r->res_scan_list) &&
+		r->res_master_nodeid != our_nodeid);
 
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
@@ -1430,16 +1437,23 @@ static void deactivate_rsb(struct kref *kref)
 	list_move(&r->res_slow_list, &ls->ls_slow_inactive);
 
 	/*
-	 * When the rsb becomes unused:
-	 * - If it's not a dir record for a remote master rsb,
-	 *   then it is put on the scan list to be freed.
-	 * - If it's a dir record for a remote master rsb,
-	 *   then it is kept in the inactive state until
-	 *   receive_remove() from the master node.
+	 * When the rsb becomes unused, there are two possibilities:
+	 * 1. Leave the inactive rsb in place (don't remove it).
+	 * 2. Add it to the scan list to be removed.
+	 *
+	 * 1 is done when the rsb is acting as the dir record
+	 * for a remotely mastered rsb.  The rsb must be left
+	 * in place as an inactive rsb to act as the dir record.
+	 *
+	 * 2 is done when a) the rsb is not the master and not the
+	 * dir record, b) when the rsb is both the master and the
+	 * dir record, c) when the rsb is master but not dir record.
+	 *
+	 * (If no directory is used, the rsb can always be removed.)
 	 */
-	if (!dlm_no_directory(ls) &&
-	    (r->res_master_nodeid != our_nodeid) &&
-	    (dlm_dir_nodeid(r) != our_nodeid))
+	if (dlm_no_directory(ls) ||
+	    (r->res_master_nodeid == our_nodeid ||
+	     dlm_dir_nodeid(r) != our_nodeid))
 		add_scan(ls, r);
 
 	if (r->res_lvbptr) {
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cb3a10b041c2..f2d88a358169 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -462,7 +462,8 @@ static bool dlm_lowcomms_con_has_addr(const struct connection *con,
 int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr)
 {
 	struct connection *con;
-	bool ret, idx;
+	bool ret;
+	int idx;
 
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, GFP_NOFS);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 77e785a6dfa7..edbabb3256c9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -205,12 +205,6 @@ enum {
 	EROFS_ZIP_CACHE_READAROUND
 };
 
-/* basic unit of the workstation of a super_block */
-struct erofs_workgroup {
-	pgoff_t index;
-	struct lockref lockref;
-};
-
 enum erofs_kmap_type {
 	EROFS_NO_KMAP,		/* don't map the buffer */
 	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
@@ -452,20 +446,15 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-void erofs_workgroup_put(struct erofs_workgroup *grp);
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index);
-struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
-					       struct erofs_workgroup *grp);
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+extern atomic_long_t erofs_global_shrink_cnt;
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *egrp);
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 void *z_erofs_get_gbuf(unsigned int requiredpages);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1a00f061798a..a8fb4b525f54 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -44,12 +44,15 @@ __Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS);
  * A: Field should be accessed / updated in atomic for parallelized code.
  */
 struct z_erofs_pcluster {
-	struct erofs_workgroup obj;
 	struct mutex lock;
+	struct lockref lockref;
 
 	/* A: point to next chained pcluster or TAILs */
 	z_erofs_next_pcluster_t next;
 
+	/* I: start block address of this pcluster */
+	erofs_off_t index;
+
 	/* L: the maximum decompression size of this round */
 	unsigned int length;
 
@@ -108,7 +111,7 @@ struct z_erofs_decompressqueue {
 
 static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
 {
-	return !pcl->obj.index;
+	return !pcl->index;
 }
 
 static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
@@ -548,7 +551,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 		if (READ_ONCE(pcl->compressed_bvecs[i].page))
 			continue;
 
-		page = find_get_page(mc, pcl->obj.index + i);
+		page = find_get_page(mc, pcl->index + i);
 		if (!page) {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
@@ -564,13 +567,13 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 				continue;
 			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
 		}
-		spin_lock(&pcl->obj.lockref.lock);
+		spin_lock(&pcl->lockref.lock);
 		if (!pcl->compressed_bvecs[i].page) {
 			pcl->compressed_bvecs[i].page = page ? page : newpage;
-			spin_unlock(&pcl->obj.lockref.lock);
+			spin_unlock(&pcl->lockref.lock);
 			continue;
 		}
-		spin_unlock(&pcl->obj.lockref.lock);
+		spin_unlock(&pcl->lockref.lock);
 
 		if (page)
 			put_page(page);
@@ -587,11 +590,9 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 }
 
 /* (erofs_shrinker) disconnect cached encoded data with pclusters */
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *grp)
+static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
+					       struct z_erofs_pcluster *pcl)
 {
-	struct z_erofs_pcluster *const pcl =
-		container_of(grp, struct z_erofs_pcluster, obj);
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	struct folio *folio;
 	int i;
@@ -626,8 +627,8 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 		return true;
 
 	ret = false;
-	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->obj.lockref.count <= 0) {
+	spin_lock(&pcl->lockref.lock);
+	if (pcl->lockref.count <= 0) {
 		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 		for (; bvec < end; ++bvec) {
 			if (bvec->page && page_folio(bvec->page) == folio) {
@@ -638,7 +639,7 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 			}
 		}
 	}
-	spin_unlock(&pcl->obj.lockref.lock);
+	spin_unlock(&pcl->lockref.lock);
 	return ret;
 }
 
@@ -689,15 +690,15 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 
 	if (exclusive) {
 		/* give priority for inplaceio to use file pages first */
-		spin_lock(&pcl->obj.lockref.lock);
+		spin_lock(&pcl->lockref.lock);
 		while (fe->icur > 0) {
 			if (pcl->compressed_bvecs[--fe->icur].page)
 				continue;
 			pcl->compressed_bvecs[fe->icur] = *bvec;
-			spin_unlock(&pcl->obj.lockref.lock);
+			spin_unlock(&pcl->lockref.lock);
 			return 0;
 		}
-		spin_unlock(&pcl->obj.lockref.lock);
+		spin_unlock(&pcl->lockref.lock);
 
 		/* otherwise, check if it can be used as a bvpage */
 		if (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED &&
@@ -710,13 +711,30 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	return ret;
 }
 
+static bool z_erofs_get_pcluster(struct z_erofs_pcluster *pcl)
+{
+	if (lockref_get_not_zero(&pcl->lockref))
+		return true;
+
+	spin_lock(&pcl->lockref.lock);
+	if (__lockref_is_dead(&pcl->lockref)) {
+		spin_unlock(&pcl->lockref.lock);
+		return false;
+	}
+
+	if (!pcl->lockref.count++)
+		atomic_long_dec(&erofs_global_shrink_cnt);
+	spin_unlock(&pcl->lockref.lock);
+	return true;
+}
+
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
-	struct z_erofs_pcluster *pcl;
-	struct erofs_workgroup *grp;
+	struct z_erofs_pcluster *pcl, *pre;
 	int err;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
@@ -730,8 +748,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
-	spin_lock_init(&pcl->obj.lockref.lock);
-	pcl->obj.lockref.count = 1;	/* one ref for this request */
+	spin_lock_init(&pcl->lockref.lock);
+	pcl->lockref.count = 1;		/* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
@@ -749,19 +767,26 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(!mutex_trylock(&pcl->lock));
 
 	if (ztailpacking) {
-		pcl->obj.index = 0;	/* which indicates ztailpacking */
+		pcl->index = 0;		/* which indicates ztailpacking */
 	} else {
-		pcl->obj.index = erofs_blknr(sb, map->m_pa);
-
-		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
-		if (IS_ERR(grp)) {
-			err = PTR_ERR(grp);
-			goto err_out;
+		pcl->index = erofs_blknr(sb, map->m_pa);
+		while (1) {
+			xa_lock(&sbi->managed_pslots);
+			pre = __xa_cmpxchg(&sbi->managed_pslots, pcl->index,
+					   NULL, pcl, GFP_KERNEL);
+			if (!pre || xa_is_err(pre) || z_erofs_get_pcluster(pre)) {
+				xa_unlock(&sbi->managed_pslots);
+				break;
+			}
+			/* try to legitimize the current in-tree one */
+			xa_unlock(&sbi->managed_pslots);
+			cond_resched();
 		}
-
-		if (grp != &pcl->obj) {
-			fe->pcl = container_of(grp,
-					struct z_erofs_pcluster, obj);
+		if (xa_is_err(pre)) {
+			err = xa_err(pre);
+			goto err_out;
+		} else if (pre) {
+			fe->pcl = pre;
 			err = -EEXIST;
 			goto err_out;
 		}
@@ -781,7 +806,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
 	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
-	struct erofs_workgroup *grp = NULL;
+	struct z_erofs_pcluster *pcl = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -789,14 +814,23 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
-		grp = erofs_find_workgroup(sb, blknr);
+		while (1) {
+			rcu_read_lock();
+			pcl = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
+			if (!pcl || z_erofs_get_pcluster(pcl)) {
+				DBG_BUGON(pcl && blknr != pcl->index);
+				rcu_read_unlock();
+				break;
+			}
+			rcu_read_unlock();
+		}
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
 
-	if (grp) {
-		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
+	if (pcl) {
+		fe->pcl = pcl;
 		ret = -EEXIST;
 	} else {
 		ret = z_erofs_register_pcluster(fe);
@@ -851,12 +885,72 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
 {
-	struct z_erofs_pcluster *const pcl =
-		container_of(grp, struct z_erofs_pcluster, obj);
+	int free = false;
+
+	spin_lock(&pcl->lockref.lock);
+	if (pcl->lockref.count)
+		goto out;
+
+	/*
+	 * Note that all cached folios should be detached before deleted from
+	 * the XArray.  Otherwise some folios could be still attached to the
+	 * orphan old pcluster when the new one is available in the tree.
+	 */
+	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
+		goto out;
+
+	/*
+	 * It's impossible to fail after the pcluster is freezed, but in order
+	 * to avoid some race conditions, add a DBG_BUGON to observe this.
+	 */
+	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
+
+	lockref_mark_dead(&pcl->lockref);
+	free = true;
+out:
+	spin_unlock(&pcl->lockref.lock);
+	if (free) {
+		atomic_long_dec(&erofs_global_shrink_cnt);
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
+	}
+	return free;
+}
+
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink)
+{
+	struct z_erofs_pcluster *pcl;
+	unsigned long index, freed = 0;
+
+	xa_lock(&sbi->managed_pslots);
+	xa_for_each(&sbi->managed_pslots, index, pcl) {
+		/* try to shrink each valid pcluster */
+		if (!erofs_try_to_release_pcluster(sbi, pcl))
+			continue;
+		xa_unlock(&sbi->managed_pslots);
+
+		++freed;
+		if (!--nr_shrink)
+			return freed;
+		xa_lock(&sbi->managed_pslots);
+	}
+	xa_unlock(&sbi->managed_pslots);
+	return freed;
+}
+
+static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+{
+	if (lockref_put_or_lock(&pcl->lockref))
+		return;
 
-	call_rcu(&pcl->rcu, z_erofs_rcu_callback);
+	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
+	if (pcl->lockref.count == 1)
+		atomic_long_inc(&erofs_global_shrink_cnt);
+	--pcl->lockref.count;
+	spin_unlock(&pcl->lockref.lock);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -877,7 +971,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		erofs_workgroup_put(&pcl->obj);
+		z_erofs_put_pcluster(pcl);
 
 	fe->pcl = NULL;
 }
@@ -1309,7 +1403,7 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
-			erofs_workgroup_put(&be.pcl->obj);
+			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
@@ -1391,9 +1485,9 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	bvec->bv_offset = 0;
 	bvec->bv_len = PAGE_SIZE;
 repeat:
-	spin_lock(&pcl->obj.lockref.lock);
+	spin_lock(&pcl->lockref.lock);
 	zbv = pcl->compressed_bvecs[nr];
-	spin_unlock(&pcl->obj.lockref.lock);
+	spin_unlock(&pcl->lockref.lock);
 	if (!zbv.page)
 		goto out_allocfolio;
 
@@ -1455,23 +1549,23 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_put(folio);
 out_allocfolio:
 	page = __erofs_allocpage(&f->pagepool, gfp, true);
-	spin_lock(&pcl->obj.lockref.lock);
+	spin_lock(&pcl->lockref.lock);
 	if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
 		if (page)
 			erofs_pagepool_add(&f->pagepool, page);
-		spin_unlock(&pcl->obj.lockref.lock);
+		spin_unlock(&pcl->lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
 	pcl->compressed_bvecs[nr].page = page ? page : ERR_PTR(-ENOMEM);
-	spin_unlock(&pcl->obj.lockref.lock);
+	spin_unlock(&pcl->lockref.lock);
 	bvec->bv_page = page;
 	if (!page)
 		return;
 	folio = page_folio(page);
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp)) {
+	    filemap_add_folio(mc, folio, pcl->index + nr, gfp)) {
 		/* turn into a temporary shortlived folio (1 ref) */
 		folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 		return;
@@ -1603,7 +1697,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 
 		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
-			.m_pa = erofs_pos(sb, pcl->obj.index),
+			.m_pa = erofs_pos(sb, pcl->index),
 		};
 		(void)erofs_map_dev(sb, &mdev);
 
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 37afe2024840..75704f58ecfa 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2024 Alibaba Cloud
  */
 #include "internal.h"
 
@@ -19,13 +20,12 @@ static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages,
 module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
 module_param_named(reserved_pages, z_erofs_rsv_nrpages, uint, 0444);
 
-static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
-/* protected by 'erofs_sb_list_lock' */
-static unsigned int shrinker_run_no;
+atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
 
-/* protects the mounted 'erofs_sb_list' */
+/* protects `erofs_sb_list_lock` and the mounted `erofs_sb_list` */
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
+static unsigned int shrinker_run_no;
 static struct shrinker *erofs_shrinker_info;
 
 static unsigned int z_erofs_gbuf_id(void)
@@ -214,145 +214,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-static bool erofs_workgroup_get(struct erofs_workgroup *grp)
-{
-	if (lockref_get_not_zero(&grp->lockref))
-		return true;
-
-	spin_lock(&grp->lockref.lock);
-	if (__lockref_is_dead(&grp->lockref)) {
-		spin_unlock(&grp->lockref.lock);
-		return false;
-	}
-
-	if (!grp->lockref.count++)
-		atomic_long_dec(&erofs_global_shrink_cnt);
-	spin_unlock(&grp->lockref.lock);
-	return true;
-}
-
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_workgroup *grp;
-
-repeat:
-	rcu_read_lock();
-	grp = xa_load(&sbi->managed_pslots, index);
-	if (grp) {
-		if (!erofs_workgroup_get(grp)) {
-			/* prefer to relax rcu read side */
-			rcu_read_unlock();
-			goto repeat;
-		}
-
-		DBG_BUGON(index != grp->index);
-	}
-	rcu_read_unlock();
-	return grp;
-}
-
-struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
-					       struct erofs_workgroup *grp)
-{
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	struct erofs_workgroup *pre;
-
-	DBG_BUGON(grp->lockref.count < 1);
-repeat:
-	xa_lock(&sbi->managed_pslots);
-	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
-			   NULL, grp, GFP_KERNEL);
-	if (pre) {
-		if (xa_is_err(pre)) {
-			pre = ERR_PTR(xa_err(pre));
-		} else if (!erofs_workgroup_get(pre)) {
-			/* try to legitimize the current in-tree one */
-			xa_unlock(&sbi->managed_pslots);
-			cond_resched();
-			goto repeat;
-		}
-		grp = pre;
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return grp;
-}
-
-static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
-{
-	atomic_long_dec(&erofs_global_shrink_cnt);
-	erofs_workgroup_free_rcu(grp);
-}
-
-void erofs_workgroup_put(struct erofs_workgroup *grp)
-{
-	if (lockref_put_or_lock(&grp->lockref))
-		return;
-
-	DBG_BUGON(__lockref_is_dead(&grp->lockref));
-	if (grp->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--grp->lockref.count;
-	spin_unlock(&grp->lockref.lock);
-}
-
-static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
-					   struct erofs_workgroup *grp)
-{
-	int free = false;
-
-	spin_lock(&grp->lockref.lock);
-	if (grp->lockref.count)
-		goto out;
-
-	/*
-	 * Note that all cached pages should be detached before deleted from
-	 * the XArray. Otherwise some cached pages could be still attached to
-	 * the orphan old workgroup when the new one is available in the tree.
-	 */
-	if (erofs_try_to_free_all_cached_folios(sbi, grp))
-		goto out;
-
-	/*
-	 * It's impossible to fail after the workgroup is freezed,
-	 * however in order to avoid some race conditions, add a
-	 * DBG_BUGON to observe this in advance.
-	 */
-	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
-
-	lockref_mark_dead(&grp->lockref);
-	free = true;
-out:
-	spin_unlock(&grp->lockref.lock);
-	if (free)
-		__erofs_workgroup_free(grp);
-	return free;
-}
-
-static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-					      unsigned long nr_shrink)
-{
-	struct erofs_workgroup *grp;
-	unsigned int freed = 0;
-	unsigned long index;
-
-	xa_lock(&sbi->managed_pslots);
-	xa_for_each(&sbi->managed_pslots, index, grp) {
-		/* try to shrink each valid workgroup */
-		if (!erofs_try_to_release_workgroup(sbi, grp))
-			continue;
-		xa_unlock(&sbi->managed_pslots);
-
-		++freed;
-		if (!--nr_shrink)
-			return freed;
-		xa_lock(&sbi->managed_pslots);
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return freed;
-}
-
 void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -369,8 +230,8 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining workgroups in memory */
-	erofs_shrink_workstation(sbi, ~0UL);
+	/* clean up all remaining pclusters in memory */
+	z_erofs_shrink_scan(sbi, ~0UL);
 
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
@@ -418,9 +279,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
-
-		freed += erofs_shrink_workstation(sbi, nr - freed);
-
+		freed += z_erofs_shrink_scan(sbi, nr - freed);
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
 		p = p->next;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 47a5c806cf16..54dd52de7269 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -175,7 +175,8 @@ static unsigned long dir_block_index(unsigned int level,
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct page *dentry_page,
 				const struct f2fs_filename *fname,
-				int *max_slots)
+				int *max_slots,
+				bool use_hash)
 {
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
@@ -183,7 +184,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	return f2fs_find_target_dentry(&d, fname, max_slots);
+	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
 }
 
 static inline int f2fs_match_name(const struct inode *dir,
@@ -208,7 +209,8 @@ static inline int f2fs_match_name(const struct inode *dir,
 }
 
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots)
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
@@ -231,7 +233,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
-		if (de->hash_code == fname->hash) {
+		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
 					      le16_to_cpu(de->name_len));
@@ -258,11 +260,12 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
 	unsigned int nbucket, nblock;
-	unsigned int bidx, end_block;
+	unsigned int bidx, end_block, bucket_no;
 	struct page *dentry_page;
 	struct f2fs_dir_entry *de = NULL;
 	pgoff_t next_pgofs;
@@ -272,8 +275,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
 
+	bucket_no = use_hash ? le32_to_cpu(fname->hash) % nbucket : 0;
+
+start_find_bucket:
 	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
-			       le32_to_cpu(fname->hash) % nbucket);
+			       bucket_no);
 	end_block = bidx + nblock;
 
 	while (bidx < end_block) {
@@ -290,7 +296,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots);
+		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			*res_page = ERR_CAST(de);
 			de = NULL;
@@ -307,12 +313,18 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		bidx++;
 	}
 
-	if (!de && room && F2FS_I(dir)->chash != fname->hash) {
-		F2FS_I(dir)->chash = fname->hash;
-		F2FS_I(dir)->clevel = level;
-	}
+	if (de)
+		return de;
 
-	return de;
+	if (likely(use_hash)) {
+		if (room && F2FS_I(dir)->chash != fname->hash) {
+			F2FS_I(dir)->chash = fname->hash;
+			F2FS_I(dir)->clevel = level;
+		}
+	} else if (++bucket_no < nbucket) {
+		goto start_find_bucket;
+	}
+	return NULL;
 }
 
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
@@ -323,11 +335,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	struct f2fs_dir_entry *de = NULL;
 	unsigned int max_depth;
 	unsigned int level;
+	bool use_hash = true;
 
 	*res_page = NULL;
 
+#if IS_ENABLED(CONFIG_UNICODE)
+start_find_entry:
+#endif
 	if (f2fs_has_inline_dentry(dir)) {
-		de = f2fs_find_in_inline_dir(dir, fname, res_page);
+		de = f2fs_find_in_inline_dir(dir, fname, res_page, use_hash);
 		goto out;
 	}
 
@@ -343,11 +359,18 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, fname, res_page);
+		de = find_in_level(dir, level, fname, res_page, use_hash);
 		if (de || IS_ERR(*res_page))
 			break;
 	}
+
 out:
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (IS_CASEFOLDED(dir) && !de && use_hash) {
+		use_hash = false;
+		goto start_find_entry;
+	}
+#endif
 	/* This is to increase the speed of f2fs_create */
 	if (!de)
 		F2FS_I(dir)->task = current;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cec3dd205b3d..b52df8aa9535 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3579,7 +3579,8 @@ int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
 			struct f2fs_filename *fname);
 void f2fs_free_filename(struct f2fs_filename *fname);
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots);
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
@@ -4199,7 +4200,8 @@ int f2fs_write_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page);
+					struct page **res_page,
+					bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 005babf1bed1..3b91a95d4276 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -352,7 +352,8 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
@@ -369,7 +370,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	inline_dentry = inline_data_addr(dir, ipage);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = f2fs_find_target_dentry(&d, fname, NULL);
+	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
 	unlock_page(ipage);
 	if (IS_ERR(de)) {
 		*res_page = ERR_CAST(de);
diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997..18735dc8269a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -125,7 +125,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.data		= &sysctl_nr_open,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_douintvec_minmax,
 		.extra1		= &sysctl_nr_open_min,
 		.extra2		= &sysctl_nr_open_max,
 	},
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 084f6ed2dd7a..94f3cc42c740 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -94,32 +94,17 @@ __uml_setup("hostfs=", hostfs_args,
 static char *__dentry_name(struct dentry *dentry, char *name)
 {
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
-	char *root;
-	size_t len;
-	struct hostfs_fs_info *fsi;
-
-	fsi = dentry->d_sb->s_fs_info;
-	root = fsi->host_root_path;
-	len = strlen(root);
-	if (IS_ERR(p)) {
-		__putname(name);
-		return NULL;
-	}
-
-	/*
-	 * This function relies on the fact that dentry_path_raw() will place
-	 * the path name at the end of the provided buffer.
-	 */
-	BUG_ON(p + strlen(p) + 1 != name + PATH_MAX);
+	struct hostfs_fs_info *fsi = dentry->d_sb->s_fs_info;
+	char *root = fsi->host_root_path;
+	size_t len = strlen(root);
 
-	strscpy(name, root, PATH_MAX);
-	if (len > p - name) {
+	if (IS_ERR(p) || len > p - name) {
 		__putname(name);
 		return NULL;
 	}
 
-	if (p > name + len)
-		strcpy(name + len, p);
+	memcpy(name, root, len);
+	memmove(name + len, p, name + PATH_MAX - p);
 
 	return name;
 }
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 637528e6368e..21b2b38fae9f 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -331,7 +331,7 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 		hdr->res.op_status = NFS4_OK;
 		hdr->task.tk_status = 0;
 	} else {
-		hdr->res.op_status = nfs4_stat_to_errno(status);
+		hdr->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		hdr->task.tk_status = status;
 	}
 }
@@ -669,7 +669,7 @@ nfs_local_commit_done(struct nfs_commit_data *data, int status)
 		data->task.tk_status = 0;
 	} else {
 		nfs_reset_boot_verifier(data->inode);
-		data->res.op_status = nfs4_stat_to_errno(status);
+		data->res.op_status = nfs_localio_errno_to_nfs4_stat(status);
 		data->task.tk_status = status;
 	}
 }
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 531c9c20ef1d..9f0d69e65264 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -552,7 +552,7 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 		.rpc_message = &msg,
 		.callback_ops = &nfs42_offload_cancel_ops,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
 	};
 	int status;
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..becc3149aa9e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -144,9 +144,11 @@
 					 decode_putfh_maxsz + \
 					 decode_offload_cancel_maxsz)
 #define NFS4_enc_copy_notify_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
 					 encode_copy_notify_maxsz)
 #define NFS4_dec_copy_notify_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
 					 decode_copy_notify_maxsz)
 #define NFS4_enc_deallocate_sz		(compound_encode_hdr_maxsz + \
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index 34a115176f97..af09aed09fd2 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -15,7 +15,7 @@ static const struct {
 	{ NFS_OK,		0		},
 	{ NFSERR_PERM,		-EPERM		},
 	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
+	{ NFSERR_IO,		-EIO		},
 	{ NFSERR_NXIO,		-ENXIO		},
 /*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
 	{ NFSERR_ACCES,		-EACCES		},
@@ -45,7 +45,6 @@ static const struct {
 	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
 	{ NFSERR_BADTYPE,	-EBADTYPE	},
 	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
 };
 
 /**
@@ -59,26 +58,29 @@ int nfs_stat_to_errno(enum nfs_stat status)
 {
 	int i;
 
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
+	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
 		if (nfs_errtbl[i].stat == (int)status)
 			return nfs_errtbl[i].errno;
 	}
-	return nfs_errtbl[i].errno;
+	return -EIO;
 }
 EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
 
 /*
  * We need to translate between nfs v4 status return values and
  * the local errno values which may not be the same.
+ *
+ * nfs4_errtbl_common[] is used before more specialized mappings
+ * available in nfs4_errtbl[] or nfs4_errtbl_localio[].
  */
 static const struct {
 	int stat;
 	int errno;
-} nfs4_errtbl[] = {
+} nfs4_errtbl_common[] = {
 	{ NFS4_OK,		0		},
 	{ NFS4ERR_PERM,		-EPERM		},
 	{ NFS4ERR_NOENT,	-ENOENT		},
-	{ NFS4ERR_IO,		-errno_NFSERR_IO},
+	{ NFS4ERR_IO,		-EIO		},
 	{ NFS4ERR_NXIO,		-ENXIO		},
 	{ NFS4ERR_ACCESS,	-EACCES		},
 	{ NFS4ERR_EXIST,	-EEXIST		},
@@ -98,15 +100,20 @@ static const struct {
 	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
 	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
 	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
 	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
-	{ NFS4ERR_LOCKED,	-EAGAIN		},
 	{ NFS4ERR_SYMLINK,	-ELOOP		},
-	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+};
+
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl[] = {
+	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFS4ERR_LOCKED,	-EAGAIN		},
+	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_NOXATTR,	-ENODATA	},
 	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
-	{ -1,			-EIO		}
 };
 
 /*
@@ -116,7 +123,14 @@ static const struct {
 int nfs4_stat_to_errno(int stat)
 {
 	int i;
-	for (i = 0; nfs4_errtbl[i].stat != -1; i++) {
+
+	/* First check nfs4_errtbl_common */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_common); i++) {
+		if (nfs4_errtbl_common[i].stat == stat)
+			return nfs4_errtbl_common[i].errno;
+	}
+	/* Then check nfs4_errtbl */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl); i++) {
 		if (nfs4_errtbl[i].stat == stat)
 			return nfs4_errtbl[i].errno;
 	}
@@ -132,3 +146,56 @@ int nfs4_stat_to_errno(int stat)
 	return -stat;
 }
 EXPORT_SYMBOL_GPL(nfs4_stat_to_errno);
+
+/*
+ * This table is useful for conversion from local errno to NFS error.
+ * It provides more logically correct mappings for use with LOCALIO
+ * (which is focused on converting from errno to NFS status).
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl_localio[] = {
+	/* Map errors differently than nfs4_errtbl */
+	{ NFS4ERR_IO,		-EREMOTEIO	},
+	{ NFS4ERR_DELAY,	-EAGAIN		},
+	{ NFS4ERR_FBIG,		-E2BIG		},
+	/* Map errors not handled by nfs4_errtbl */
+	{ NFS4ERR_STALE,	-EBADF		},
+	{ NFS4ERR_STALE,	-EOPENSTALE	},
+	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
+	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
+	{ NFS4ERR_DELAY,	-ENOMEM		},
+	{ NFS4ERR_IO,		-ETXTBSY	},
+	{ NFS4ERR_IO,		-EBUSY		},
+	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
+	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
+	{ NFS4ERR_IO,		-EUCLEAN	},
+	{ NFS4ERR_PERM,		-ENOKEY		},
+};
+
+/*
+ * Convert an errno to an NFS error code for LOCALIO.
+ */
+__u32 nfs_localio_errno_to_nfs4_stat(int errno)
+{
+	int i;
+
+	/* First check nfs4_errtbl_common */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_common); i++) {
+		if (nfs4_errtbl_common[i].errno == errno)
+			return nfs4_errtbl_common[i].stat;
+	}
+	/* Then check nfs4_errtbl_localio */
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl_localio); i++) {
+		if (nfs4_errtbl_localio[i].errno == errno)
+			return nfs4_errtbl_localio[i].stat;
+	}
+	/* If we cannot translate the error, the recovery routines should
+	 * handle it.
+	 * Note: remaining NFSv4 error codes have values > 10000, so should
+	 * not conflict with native Linux error codes.
+	 */
+	return NFS4ERR_SERVERFAULT;
+}
+EXPORT_SYMBOL_GPL(nfs_localio_errno_to_nfs4_stat);
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index f61c58fbf117..0cc32e9c71cb 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -400,7 +400,7 @@ int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 	return 0;
 }
 
-void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct folio *folio, struct inode *inode)
 {
 	size_t from = offset_in_folio(folio, de);
@@ -410,11 +410,15 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 
 	folio_lock(folio);
 	err = nilfs_prepare_chunk(folio, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		folio_unlock(folio);
+		return err;
+	}
 	de->inode = cpu_to_le64(inode->i_ino);
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
 	nilfs_commit_chunk(folio, mapping, from, to);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	return 0;
 }
 
 /*
@@ -543,7 +547,10 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct folio *folio)
 		from = (char *)pde - kaddr;
 	folio_lock(folio);
 	err = nilfs_prepare_chunk(folio, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		folio_unlock(folio);
+		goto out;
+	}
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 1d836a5540f3..e02fae6757f1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -406,8 +406,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		nilfs_set_link(new_dir, new_de, new_folio, old_inode);
+		err = nilfs_set_link(new_dir, new_de, new_folio, old_inode);
 		folio_release_kmap(new_folio, new_de);
+		if (unlikely(err))
+			goto out_dir;
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -430,28 +432,27 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	 */
 	inode_set_ctime_current(old_inode);
 
-	nilfs_delete_entry(old_de, old_folio);
-
-	if (dir_de) {
-		nilfs_set_link(old_inode, dir_de, dir_folio, new_dir);
-		folio_release_kmap(dir_folio, dir_de);
-		drop_nlink(old_dir);
+	err = nilfs_delete_entry(old_de, old_folio);
+	if (likely(!err)) {
+		if (dir_de) {
+			err = nilfs_set_link(old_inode, dir_de, dir_folio,
+					     new_dir);
+			drop_nlink(old_dir);
+		}
+		nilfs_mark_inode_dirty(old_dir);
 	}
-	folio_release_kmap(old_folio, old_de);
-
-	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-	err = nilfs_transaction_commit(old_dir->i_sb);
-	return err;
-
 out_dir:
 	if (dir_de)
 		folio_release_kmap(dir_folio, dir_de);
 out_old:
 	folio_release_kmap(old_folio, old_de);
 out:
-	nilfs_transaction_abort(old_dir->i_sb);
+	if (likely(!err))
+		err = nilfs_transaction_commit(old_dir->i_sb);
+	else
+		nilfs_transaction_abort(old_dir->i_sb);
 	return err;
 }
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index dff241c53fc5..cb6ed54accd7 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -261,8 +261,8 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *, const struct qstr *,
 int nilfs_delete_entry(struct nilfs_dir_entry *, struct folio *);
 int nilfs_empty_dir(struct inode *);
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct folio **);
-void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
-			   struct folio *, struct inode *);
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+		   struct folio *folio, struct inode *inode);
 
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 6dd8b854cd1f..06f18fe86407 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -392,6 +392,11 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 /**
  * nilfs_clear_folio_dirty - discard dirty folio
  * @folio: dirty folio that will be discarded
+ *
+ * nilfs_clear_folio_dirty() clears working states including dirty state for
+ * the folio and its buffers.  If the folio has buffers, clear only if it is
+ * confirmed that none of the buffer heads are busy (none have valid
+ * references and none are locked).
  */
 void nilfs_clear_folio_dirty(struct folio *folio)
 {
@@ -399,10 +404,6 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 
 	BUG_ON(!folio_test_locked(folio));
 
-	folio_clear_uptodate(folio);
-	folio_clear_mappedtodisk(folio);
-	folio_clear_checked(folio);
-
 	head = folio_buffers(folio);
 	if (head) {
 		const unsigned long clear_bits =
@@ -410,6 +411,25 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
 			 BIT(BH_Delay));
+		bool busy, invalidated = false;
+
+recheck_buffers:
+		busy = false;
+		bh = head;
+		do {
+			if (atomic_read(&bh->b_count) | buffer_locked(bh)) {
+				busy = true;
+				break;
+			}
+		} while (bh = bh->b_this_page, bh != head);
+
+		if (busy) {
+			if (invalidated)
+				return;
+			invalidate_bh_lrus();
+			invalidated = true;
+			goto recheck_buffers;
+		}
 
 		bh = head;
 		do {
@@ -419,6 +439,9 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
+	folio_clear_uptodate(folio);
+	folio_clear_mappedtodisk(folio);
+	folio_clear_checked(folio);
 	__nilfs_clear_folio_dirty(folio);
 }
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 587251830897..58a598b548fa 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -734,7 +734,6 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		if (!head)
 			head = create_empty_buffers(folio,
 					i_blocksize(inode), 0);
-		folio_unlock(folio);
 
 		bh = head;
 		do {
@@ -744,11 +743,14 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
+				folio_unlock(folio);
 				folio_batch_release(&fbatch);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
+
+		folio_unlock(folio);
 	}
 	folio_batch_release(&fbatch);
 	cond_resched();
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 3404e7a30c33..15d9acd456ec 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -761,6 +761,11 @@ static int ocfs2_release_dquot(struct dquot *dquot)
 	handle = ocfs2_start_trans(osb,
 		ocfs2_calc_qdel_credits(dquot->dq_sb, dquot->dq_id.type));
 	if (IS_ERR(handle)) {
+		/*
+		 * Mark dquot as inactive to avoid endless cycle in
+		 * quota_release_workfn().
+		 */
+		clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 		status = PTR_ERR(handle);
 		mlog_errno(status);
 		goto out_ilock;
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 65b2473e22ff..fa6b8cb788a1 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -89,7 +89,7 @@ static struct pstore_device_info *pstore_device_info;
 		_##name_ = check_size(name, alignsize);		\
 	else							\
 		_##name_ = 0;					\
-	/* Synchronize module parameters with resuls. */	\
+	/* Synchronize module parameters with results. */	\
 	name = _##name_ / 1024;					\
 	dev->zone.name = _##name_;				\
 }
@@ -121,7 +121,7 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 	if (pstore_device_info)
 		return -EBUSY;
 
-	/* zero means not limit on which backends to attempt to store. */
+	/* zero means no limit on which backends attempt to store. */
 	if (!dev->flags)
 		dev->flags = UINT_MAX;
 
diff --git a/fs/select.c b/fs/select.c
index a77907faf2b4..834f438296e2 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -787,7 +787,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
 	}
 	return 0;
 Efault:
-	user_access_end();
+	user_read_access_end();
 	return -EFAULT;
 }
 
@@ -1361,7 +1361,7 @@ static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
 	}
 	return 0;
 Efault:
-	user_access_end();
+	user_read_access_end();
 	return -EFAULT;
 }
 
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c68ad526a4de..ebe9a7d7c70e 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1395,7 +1395,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 				      const struct cifs_fid *cifsfid, u32 *pacllen,
-				      u32 __maybe_unused unused)
+				      u32 info)
 {
 	struct smb_ntsd *pntsd = NULL;
 	unsigned int xid;
@@ -1407,7 +1407,7 @@ struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 
 	xid = get_xid();
 	rc = CIFSSMBGetCIFSACL(xid, tlink_tcon(tlink), cifsfid->netfid, &pntsd,
-				pacllen);
+				pacllen, info);
 	free_xid(xid);
 
 	cifs_put_tlink(tlink);
@@ -1419,7 +1419,7 @@ struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 }
 
 static struct smb_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
-		const char *path, u32 *pacllen)
+		const char *path, u32 *pacllen, u32 info)
 {
 	struct smb_ntsd *pntsd = NULL;
 	int oplock = 0;
@@ -1446,9 +1446,12 @@ static struct smb_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
 		.fid = &fid,
 	};
 
+	if (info & SACL_SECINFO)
+		oparms.desired_access |= SYSTEM_SECURITY;
+
 	rc = CIFS_open(xid, &oparms, &oplock, NULL);
 	if (!rc) {
-		rc = CIFSSMBGetCIFSACL(xid, tcon, fid.netfid, &pntsd, pacllen);
+		rc = CIFSSMBGetCIFSACL(xid, tcon, fid.netfid, &pntsd, pacllen, info);
 		CIFSSMBClose(xid, tcon, fid.netfid);
 	}
 
@@ -1472,7 +1475,7 @@ struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
 	if (inode)
 		open_file = find_readable_file(CIFS_I(inode), true);
 	if (!open_file)
-		return get_cifs_acl_by_path(cifs_sb, path, pacllen);
+		return get_cifs_acl_by_path(cifs_sb, path, pacllen, info);
 
 	pntsd = get_cifs_acl_by_fid(cifs_sb, &open_file->fid, pacllen, info);
 	cifsFileInfo_put(open_file);
@@ -1485,7 +1488,7 @@ int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 {
 	int oplock = 0;
 	unsigned int xid;
-	int rc, access_flags;
+	int rc, access_flags = 0;
 	struct cifs_tcon *tcon;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
@@ -1498,10 +1501,12 @@ int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 	tcon = tlink_tcon(tlink);
 	xid = get_xid();
 
-	if (aclflag == CIFS_ACL_OWNER || aclflag == CIFS_ACL_GROUP)
-		access_flags = WRITE_OWNER;
-	else
-		access_flags = WRITE_DAC;
+	if (aclflag & CIFS_ACL_OWNER || aclflag & CIFS_ACL_GROUP)
+		access_flags |= WRITE_OWNER;
+	if (aclflag & CIFS_ACL_SACL)
+		access_flags |= SYSTEM_SECURITY;
+	if (aclflag & CIFS_ACL_DACL)
+		access_flags |= WRITE_DAC;
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a697e53ccee2..907af3cbffd1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -568,7 +568,7 @@ extern int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 		const struct nls_table *nls_codepage,
 		struct cifs_sb_info *cifs_sb);
 extern int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen);
+			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen, __u32 info);
 extern int CIFSSMBSetCIFSACL(const unsigned int, struct cifs_tcon *, __u16,
 			struct smb_ntsd *pntsd, __u32 len, int aclflag);
 extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 0eae60731c20..e2a14e25da87 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3427,7 +3427,7 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
 /* Get Security Descriptor (by handle) from remote server for a file or dir */
 int
 CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
-		  struct smb_ntsd **acl_inf, __u32 *pbuflen)
+		  struct smb_ntsd **acl_inf, __u32 *pbuflen, __u32 info)
 {
 	int rc = 0;
 	int buf_type = 0;
@@ -3450,7 +3450,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	pSMB->MaxSetupCount = 0;
 	pSMB->Fid = fid; /* file handle always le */
 	pSMB->AclFlags = cpu_to_le32(CIFS_ACL_OWNER | CIFS_ACL_GROUP |
-				     CIFS_ACL_DACL);
+				     CIFS_ACL_DACL | info);
 	pSMB->ByteCount = cpu_to_le16(11); /* 3 bytes pad + 8 bytes parm */
 	inc_rfc1001_len(pSMB, 11);
 	iov[0].iov_base = (char *)pSMB;
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 273358d20a46..50f96259d9ad 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -413,7 +413,7 @@ _initiate_cifs_search(const unsigned int xid, struct file *file,
 		cifsFile->invalidHandle = false;
 	} else if ((rc == -EOPNOTSUPP) &&
 		   (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) {
-		cifs_sb->mnt_cifs_flags &= ~CIFS_MOUNT_SERVER_INUM;
+		cifs_autodisable_serverino(cifs_sb);
 		goto ffirst_retry;
 	}
 error_exit:
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index d3abb99cc990..e56a8df23fec 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -674,11 +674,12 @@ int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 	return parse_reparse_point(buf, plen, cifs_sb, full_path, true, data);
 }
 
-static void wsl_to_fattr(struct cifs_open_info_data *data,
+static bool wsl_to_fattr(struct cifs_open_info_data *data,
 			 struct cifs_sb_info *cifs_sb,
 			 u32 tag, struct cifs_fattr *fattr)
 {
 	struct smb2_file_full_ea_info *ea;
+	bool have_xattr_dev = false;
 	u32 next = 0;
 
 	switch (tag) {
@@ -721,13 +722,24 @@ static void wsl_to_fattr(struct cifs_open_info_data *data,
 			fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
 		else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen))
 			fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
-		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen))
+		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
+			/* File type in reparse point tag and in xattr mode must match. */
+			if (S_DT(fattr->cf_mode) != S_DT(le32_to_cpu(*(__le32 *)v)))
+				return false;
 			fattr->cf_mode = (umode_t)le32_to_cpu(*(__le32 *)v);
-		else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen))
+		} else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen)) {
 			fattr->cf_rdev = reparse_mkdev(v);
+			have_xattr_dev = true;
+		}
 	} while (next);
 out:
+
+	/* Major and minor numbers for char and block devices are mandatory. */
+	if (!have_xattr_dev && (tag == IO_REPARSE_TAG_LX_CHR || tag == IO_REPARSE_TAG_LX_BLK))
+		return false;
+
 	fattr->cf_dtype = S_DT(fattr->cf_mode);
+	return true;
 }
 
 static bool posix_reparse_to_fattr(struct cifs_sb_info *cifs_sb,
@@ -801,7 +813,9 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 	case IO_REPARSE_TAG_AF_UNIX:
 	case IO_REPARSE_TAG_LX_CHR:
 	case IO_REPARSE_TAG_LX_BLK:
-		wsl_to_fattr(data, cifs_sb, tag, fattr);
+		ok = wsl_to_fattr(data, cifs_sb, tag, fattr);
+		if (!ok)
+			return false;
 		break;
 	case IO_REPARSE_TAG_NFS:
 		ok = posix_reparse_to_fattr(cifs_sb, fattr, data);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7571fefeb83a..6bacf754b57e 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -658,7 +658,8 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 
 	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		memset(&tmp_iface, 0, sizeof(tmp_iface));
-		tmp_iface.speed = le64_to_cpu(p->LinkSpeed);
+		/* default to 1Gbps when link speed is unset */
+		tmp_iface.speed = le64_to_cpu(p->LinkSpeed) ?: 1000000000;
 		tmp_iface.rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
 		tmp_iface.rss_capable = le32_to_cpu(p->Capability & RSS_CAPABLE) ? 1 : 0;
 
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 5cc69beaa62e..10a86c02a8b3 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -946,16 +946,20 @@ void ubifs_dump_tnc(struct ubifs_info *c)
 
 	pr_err("\n");
 	pr_err("(pid %d) start dumping TNC tree\n", current->pid);
-	znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, NULL);
-	level = znode->level;
-	pr_err("== Level %d ==\n", level);
-	while (znode) {
-		if (level != znode->level) {
-			level = znode->level;
-			pr_err("== Level %d ==\n", level);
+	if (c->zroot.znode) {
+		znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, NULL);
+		level = znode->level;
+		pr_err("== Level %d ==\n", level);
+		while (znode) {
+			if (level != znode->level) {
+				level = znode->level;
+				pr_err("== Level %d ==\n", level);
+			}
+			ubifs_dump_znode(c, znode);
+			znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, znode);
 		}
-		ubifs_dump_znode(c, znode);
-		znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, znode);
+	} else {
+		pr_err("empty TNC tree in memory\n");
 	}
 	pr_err("(pid %d) finish dumping TNC tree\n", current->pid);
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..6bcbdc8bf186 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -663,9 +663,8 @@ xfs_buf_find_insert(
 		spin_unlock(&bch->bc_lock);
 		goto out_free_buf;
 	}
-	if (bp) {
+	if (bp && atomic_inc_not_zero(&bp->b_hold)) {
 		/* found an existing buffer */
-		atomic_inc(&bp->b_hold);
 		spin_unlock(&bch->bc_lock);
 		error = xfs_buf_find_lock(bp, flags);
 		if (error)
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index fa50e5308292..0b0b0f31aca2 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -153,6 +153,79 @@ xfs_dax_notify_failure_thaw(
 	thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 }
 
+static int
+xfs_dax_translate_range(
+	struct xfs_buftarg	*btp,
+	u64			offset,
+	u64			len,
+	xfs_daddr_t		*daddr,
+	uint64_t		*bblen)
+{
+	u64			dev_start = btp->bt_dax_part_off;
+	u64			dev_len = bdev_nr_bytes(btp->bt_bdev);
+	u64			dev_end = dev_start + dev_len - 1;
+
+	/* Notify failure on the whole device. */
+	if (offset == 0 && len == U64_MAX) {
+		offset = dev_start;
+		len = dev_len;
+	}
+
+	/* Ignore the range out of filesystem area */
+	if (offset + len - 1 < dev_start)
+		return -ENXIO;
+	if (offset > dev_end)
+		return -ENXIO;
+
+	/* Calculate the real range when it touches the boundary */
+	if (offset > dev_start)
+		offset -= dev_start;
+	else {
+		len -= dev_start - offset;
+		offset = 0;
+	}
+	if (offset + len - 1 > dev_end)
+		len = dev_end - offset + 1;
+
+	*daddr = BTOBB(offset);
+	*bblen = BTOBB(len);
+	return 0;
+}
+
+static int
+xfs_dax_notify_logdev_failure(
+	struct xfs_mount	*mp,
+	u64			offset,
+	u64			len,
+	int			mf_flags)
+{
+	xfs_daddr_t		daddr;
+	uint64_t		bblen;
+	int			error;
+
+	/*
+	 * Return ENXIO instead of shutting down the filesystem if the failed
+	 * region is beyond the end of the log.
+	 */
+	error = xfs_dax_translate_range(mp->m_logdev_targp,
+			offset, len, &daddr, &bblen);
+	if (error)
+		return error;
+
+	/*
+	 * In the pre-remove case the failure notification is attempting to
+	 * trigger a force unmount.  The expectation is that the device is
+	 * still present, but its removal is in progress and can not be
+	 * cancelled, proceed with accessing the log device.
+	 */
+	if (mf_flags & MF_MEM_PRE_REMOVE)
+		return 0;
+
+	xfs_err(mp, "ondisk log corrupt, shutting down fs!");
+	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+	return -EFSCORRUPTED;
+}
+
 static int
 xfs_dax_notify_ddev_failure(
 	struct xfs_mount	*mp,
@@ -263,8 +336,9 @@ xfs_dax_notify_failure(
 	int			mf_flags)
 {
 	struct xfs_mount	*mp = dax_holder(dax_dev);
-	u64			ddev_start;
-	u64			ddev_end;
+	xfs_daddr_t		daddr;
+	uint64_t		bblen;
+	int			error;
 
 	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
@@ -279,17 +353,7 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
-		/*
-		 * In the pre-remove case the failure notification is attempting
-		 * to trigger a force unmount.  The expectation is that the
-		 * device is still present, but its removal is in progress and
-		 * can not be cancelled, proceed with accessing the log device.
-		 */
-		if (mf_flags & MF_MEM_PRE_REMOVE)
-			return 0;
-		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
-		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
-		return -EFSCORRUPTED;
+		return xfs_dax_notify_logdev_failure(mp, offset, len, mf_flags);
 	}
 
 	if (!xfs_has_rmapbt(mp)) {
@@ -297,33 +361,12 @@ xfs_dax_notify_failure(
 		return -EOPNOTSUPP;
 	}
 
-	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
-	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
-
-	/* Notify failure on the whole device. */
-	if (offset == 0 && len == U64_MAX) {
-		offset = ddev_start;
-		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
-	}
-
-	/* Ignore the range out of filesystem area */
-	if (offset + len - 1 < ddev_start)
-		return -ENXIO;
-	if (offset > ddev_end)
-		return -ENXIO;
-
-	/* Calculate the real range when it touches the boundary */
-	if (offset > ddev_start)
-		offset -= ddev_start;
-	else {
-		len -= ddev_start - offset;
-		offset = 0;
-	}
-	if (offset + len - 1 > ddev_end)
-		len = ddev_end - offset + 1;
+	error = xfs_dax_translate_range(mp->m_ddev_targp, offset, len, &daddr,
+			&bblen);
+	if (error)
+		return error;
 
-	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
-			mf_flags);
+	return xfs_dax_notify_ddev_failure(mp, daddr, bblen, mf_flags);
 }
 
 const struct dax_holder_operations xfs_dax_holder_operations = {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d076ebd19a61..78b24b090488 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -763,6 +763,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_enable_all_wakeup_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..c393fad3a346 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,11 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
+#define IMX93_CLK_SPDIF_IPG		207
 
 #endif
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index 175892189e9d..4f220ea7a23c 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -44,7 +44,9 @@
 #define _DT_BINDINGS_CLK_SUN50I_A64_H_
 
 #define CLK_PLL_VIDEO0		7
+#define CLK_PLL_VIDEO0_2X	8
 #define CLK_PLL_PERIPH0		11
+#define CLK_PLL_MIPI		17
 
 #define CLK_CPUX		21
 #define CLK_BUS_MIPI_DSI	28
diff --git a/include/linux/btf.h b/include/linux/btf.h
index b8a583194c4a..d99178ce01d2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -352,6 +352,11 @@ static inline bool btf_type_is_scalar(const struct btf_type *t)
 	return btf_type_is_int(t) || btf_type_is_enum(t);
 }
 
+static inline bool btf_type_is_fwd(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
+}
+
 static inline bool btf_type_is_typedef(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 45e598fe3476..77e6e195d1d6 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -52,8 +52,8 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
 #define __COREDUMP_PRINTK(Level, Format, ...) \
 	do {	\
 		char comm[TASK_COMM_LEN];	\
-	\
-		get_task_comm(comm, current);	\
+		/* This will always be NUL terminated. */ \
+		memcpy(comm, current->comm, sizeof(comm)); \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
 	} while (0)	\
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..b8b935b52603 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -734,6 +734,9 @@ struct kernel_ethtool_ts_info {
  * @rxfh_per_ctx_key: device supports setting different RSS key for each
  *	additional context. Netlink API should report hfunc, key, and input_xfrm
  *	for every context, not just context 0.
+ * @cap_rss_rxnfc_adds: device supports nonzero ring_cookie in filters with
+ *	%FLOW_RSS flag; the queue ID from the filter is added to the value from
+ *	the indirection table to determine the delivery queue.
  * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
  *	size as returned by @get_rxfh_indir_size may change during lifetime
  *	of the device. Leave as 0 if the table size is constant.
@@ -956,6 +959,7 @@ struct ethtool_ops {
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
 	u32	rxfh_per_ctx_key:1;
+	u32	cap_rss_rxnfc_adds:1;
 	u32	rxfh_indir_space;
 	u16	rxfh_key_space;
 	u16	rxfh_priv_size;
diff --git a/include/linux/export.h b/include/linux/export.h
index 0bbd02fd351d..1e04dbc675c2 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -60,7 +60,7 @@
 #endif
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
-#define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, __stringify(DEFAULT_SYMBOL_NAMESPACE))
+#define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, DEFAULT_SYMBOL_NAMESPACE)
 #else
 #define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, "")
 #endif
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a7d60a1c72a0..dd3342301253 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -218,6 +218,7 @@ struct hid_item {
 #define HID_GD_DOWN		0x00010091
 #define HID_GD_RIGHT		0x00010092
 #define HID_GD_LEFT		0x00010093
+#define HID_GD_DO_NOT_DISTURB	0x0001009b
 /* Microsoft Win8 Wireless Radio Controls CA usage codes */
 #define HID_GD_RFKILL_BTN	0x000100c6
 #define HID_GD_RFKILL_LED	0x000100c7
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 456bca45ff05..3750e56bfcbb 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5053,28 +5053,24 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 {
 	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u16 control = le16_to_cpu(mle->control);
-	u8 common = 0;
 
 	switch (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE)) {
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		/*
 		 * The length is the first octet pointed by mle->variable so no
 		 * need to add anything
 		 */
 		break;
-	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
-		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
-			common += ETH_ALEN;
-		return common;
 	default:
 		WARN_ON(1);
 		return 0;
 	}
 
-	return sizeof(*mle) + common + mle->variable[0];
+	return sizeof(*mle) + mle->variable[0];
 }
 
 /**
@@ -5312,8 +5308,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
-		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
-			common += ETH_ALEN;
+		common = ETH_ALEN + 1;
 		break;
 	default:
 		/* we don't know this type */
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index c3f075e8f60c..1c6a6c1704d8 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -57,10 +57,10 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 
 	preempt_disable();
 	mod = __module_address((unsigned long)ptr);
-	preempt_enable();
 
 	if (mod)
 		ptr = dereference_module_function_descriptor(mod, ptr);
+	preempt_enable();
 #endif
 	return ptr;
 }
diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 9dd4bf157255..58a2401e4b55 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -146,9 +146,9 @@ struct mr_mfc {
 			unsigned long last_assert;
 			int minvif;
 			int maxvif;
-			unsigned long bytes;
-			unsigned long pkt;
-			unsigned long wrong_if;
+			atomic_long_t bytes;
+			atomic_long_t pkt;
+			atomic_long_t wrong_if;
 			unsigned long lastuse;
 			unsigned char ttls[MAXVIFS];
 			refcount_t refcount;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8896705ccd63..02d3bafebbe7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2222,7 +2222,7 @@ struct net_device {
 	void 			*atalk_ptr;
 #endif
 #if IS_ENABLED(CONFIG_AX25)
-	void			*ax25_ptr;
+	struct ax25_dev	__rcu	*ax25_ptr;
 #endif
 #if IS_ENABLED(CONFIG_CFG80211)
 	struct wireless_dev	*ieee80211_ptr;
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
index 5fc02df88252..a541c3a02887 100644
--- a/include/linux/nfs_common.h
+++ b/include/linux/nfs_common.h
@@ -9,9 +9,10 @@
 #include <uapi/linux/nfs.h>
 
 /* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO EIO
 
 int nfs_stat_to_errno(enum nfs_stat status);
 int nfs4_stat_to_errno(int stat);
 
+__u32 nfs_localio_errno_to_nfs4_stat(int errno);
+
 #endif /* _LINUX_NFS_COMMON_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fb908843f209..347901525a46 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1266,12 +1266,18 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 }
 
 static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
+					     struct perf_event *event,
 					     struct perf_raw_record *raw)
 {
 	struct perf_raw_frag *frag = &raw->frag;
 	u32 sum = 0;
 	int size;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_RAW))
+		return;
+
 	do {
 		sum += frag->size;
 		if (perf_raw_frag_last(frag))
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..c7abce28ed29 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -56,8 +56,7 @@ struct pps_device {
 
 	unsigned int id;			/* PPS source unique ID */
 	void const *lookup_cookie;		/* For pps_lookup_dev() only */
-	struct cdev cdev;
-	struct device *dev;
+	struct device dev;
 	struct fasync_struct *async_queue;	/* fasync method */
 	spinlock_t lock;
 };
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index fd037c127bb0..551329220e4f 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -615,15 +615,14 @@ static inline int ptr_ring_resize_noprof(struct ptr_ring *r, int size, gfp_t gfp
 /*
  * Note: producer lock is nested within consumer lock, so if you
  * resize you must make sure all uses nest correctly.
- * In particular if you consume ring in interrupt or BH context, you must
- * disable interrupts/BH when doing so.
+ * In particular if you consume ring in BH context, you must
+ * disable BH when doing so.
  */
-static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
-						  unsigned int nrings,
-						  int size,
-						  gfp_t gfp, void (*destroy)(void *))
+static inline int ptr_ring_resize_multiple_bh_noprof(struct ptr_ring **rings,
+						     unsigned int nrings,
+						     int size, gfp_t gfp,
+						     void (*destroy)(void *))
 {
-	unsigned long flags;
 	void ***queues;
 	int i;
 
@@ -638,12 +637,12 @@ static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
 	}
 
 	for (i = 0; i < nrings; ++i) {
-		spin_lock_irqsave(&(rings[i])->consumer_lock, flags);
+		spin_lock_bh(&(rings[i])->consumer_lock);
 		spin_lock(&(rings[i])->producer_lock);
 		queues[i] = __ptr_ring_swap_queue(rings[i], queues[i],
 						  size, gfp, destroy);
 		spin_unlock(&(rings[i])->producer_lock);
-		spin_unlock_irqrestore(&(rings[i])->consumer_lock, flags);
+		spin_unlock_bh(&(rings[i])->consumer_lock);
 	}
 
 	for (i = 0; i < nrings; ++i)
@@ -662,8 +661,8 @@ static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
 noqueues:
 	return -ENOMEM;
 }
-#define ptr_ring_resize_multiple(...) \
-		alloc_hooks(ptr_ring_resize_multiple_noprof(__VA_ARGS__))
+#define ptr_ring_resize_multiple_bh(...) \
+		alloc_hooks(ptr_ring_resize_multiple_bh_noprof(__VA_ARGS__))
 
 static inline void ptr_ring_cleanup(struct ptr_ring *r, void (*destroy)(void *))
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 02eaf84c8626..8982820dae21 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -944,6 +944,7 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
+	unsigned			sched_task_hot:1;
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/include/linux/skb_array.h b/include/linux/skb_array.h
index 926496c9cc9c..bf178238a308 100644
--- a/include/linux/skb_array.h
+++ b/include/linux/skb_array.h
@@ -199,17 +199,18 @@ static inline int skb_array_resize(struct skb_array *a, int size, gfp_t gfp)
 	return ptr_ring_resize(&a->ring, size, gfp, __skb_array_destroy_skb);
 }
 
-static inline int skb_array_resize_multiple_noprof(struct skb_array **rings,
-						   int nrings, unsigned int size,
-						   gfp_t gfp)
+static inline int skb_array_resize_multiple_bh_noprof(struct skb_array **rings,
+						      int nrings,
+						      unsigned int size,
+						      gfp_t gfp)
 {
 	BUILD_BUG_ON(offsetof(struct skb_array, ring));
-	return ptr_ring_resize_multiple_noprof((struct ptr_ring **)rings,
-					       nrings, size, gfp,
-					       __skb_array_destroy_skb);
+	return ptr_ring_resize_multiple_bh_noprof((struct ptr_ring **)rings,
+					          nrings, size, gfp,
+					          __skb_array_destroy_skb);
 }
-#define skb_array_resize_multiple(...)	\
-		alloc_hooks(skb_array_resize_multiple_noprof(__VA_ARGS__))
+#define skb_array_resize_multiple_bh(...)	\
+		alloc_hooks(skb_array_resize_multiple_bh_noprof(__VA_ARGS__))
 
 static inline void skb_array_cleanup(struct skb_array *a)
 {
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 061da9546a81..b22e659f81ba 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -163,7 +163,8 @@ struct tcpc_dev {
 	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
 	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
 	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-						 bool pps_active, u32 requested_vbus_voltage);
+						 bool pps_active, u32 requested_vbus_voltage,
+						 u32 pps_apdo_min_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
 	void (*check_contaminant)(struct tcpc_dev *dev);
diff --git a/include/net/ax25.h b/include/net/ax25.h
index cb622d84cd0c..4ee141aae0a2 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -231,6 +231,7 @@ typedef struct ax25_dev {
 #endif
 	refcount_t		refcount;
 	bool device_up;
+	struct rcu_head		rcu;
 } ax25_dev;
 
 typedef struct ax25_cb {
@@ -290,9 +291,8 @@ static inline void ax25_dev_hold(ax25_dev *ax25_dev)
 
 static inline void ax25_dev_put(ax25_dev *ax25_dev)
 {
-	if (refcount_dec_and_test(&ax25_dev->refcount)) {
-		kfree(ax25_dev);
-	}
+	if (refcount_dec_and_test(&ax25_dev->refcount))
+		kfree_rcu(ax25_dev, rcu);
 }
 static inline __be16 ax25_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
@@ -335,9 +335,9 @@ void ax25_digi_invert(const ax25_digi *, ax25_digi *);
 extern spinlock_t ax25_dev_lock;
 
 #if IS_ENABLED(CONFIG_AX25)
-static inline ax25_dev *ax25_dev_ax25dev(struct net_device *dev)
+static inline ax25_dev *ax25_dev_ax25dev(const struct net_device *dev)
 {
-	return dev->ax25_ptr;
+	return rcu_dereference_rtnl(dev->ax25_ptr);
 }
 #endif
 
diff --git a/include/net/inetpeer.h b/include/net/inetpeer.h
index 74ff688568a0..f475757daafb 100644
--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -96,30 +96,28 @@ static inline struct in6_addr *inetpeer_get_addr_v6(struct inetpeer_addr *iaddr)
 
 /* can be called with or without local BH being disabled */
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
-			       const struct inetpeer_addr *daddr,
-			       int create);
+			       const struct inetpeer_addr *daddr);
 
 static inline struct inet_peer *inet_getpeer_v4(struct inet_peer_base *base,
 						__be32 v4daddr,
-						int vif, int create)
+						int vif)
 {
 	struct inetpeer_addr daddr;
 
 	daddr.a4.addr = v4daddr;
 	daddr.a4.vif = vif;
 	daddr.family = AF_INET;
-	return inet_getpeer(base, &daddr, create);
+	return inet_getpeer(base, &daddr);
 }
 
 static inline struct inet_peer *inet_getpeer_v6(struct inet_peer_base *base,
-						const struct in6_addr *v6daddr,
-						int create)
+						const struct in6_addr *v6daddr)
 {
 	struct inetpeer_addr daddr;
 
 	daddr.a6 = *v6daddr;
 	daddr.family = AF_INET6;
-	return inet_getpeer(base, &daddr, create);
+	return inet_getpeer(base, &daddr);
 }
 
 static inline int inetpeer_addr_cmp(const struct inetpeer_addr *a,
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 471c353d32a4..788513cc384b 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -442,6 +442,9 @@ struct nft_set_ext;
  *	@remove: remove element from set
  *	@walk: iterate over all set elements
  *	@get: get set elements
+ *	@ksize: kernel set size
+ * 	@usize: userspace set size
+ *	@adjust_maxsize: delta to adjust maximum set size
  *	@commit: commit set elements
  *	@abort: abort set elements
  *	@privsize: function to return size of set private data
@@ -495,6 +498,9 @@ struct nft_set_ops {
 					       const struct nft_set *set,
 					       const struct nft_set_elem *elem,
 					       unsigned int flags);
+	u32				(*ksize)(u32 size);
+	u32				(*usize)(u32 size);
+	u32				(*adjust_maxsize)(const struct nft_set *set);
 	void				(*commit)(struct nft_set *set);
 	void				(*abort)(const struct nft_set *set);
 	u64				(*privsize)(const struct nlattr * const nla[],
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index ae60d6664095..23dd647fe024 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -43,6 +43,7 @@ struct netns_xfrm {
 	struct hlist_head	__rcu *state_bysrc;
 	struct hlist_head	__rcu *state_byspi;
 	struct hlist_head	__rcu *state_byseq;
+	struct hlist_head	 __percpu *state_cache_input;
 	unsigned int		state_hmask;
 	unsigned int		state_num;
 	struct work_struct	state_hash_work;
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 4880b3a7aced..4229e4fcd2a9 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -75,11 +75,11 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
 }
 
 #ifdef CONFIG_NET_CLS_ACT
-DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
+DECLARE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
 
 static inline bool tcf_block_bypass_sw(struct tcf_block *block)
 {
-	return block && block->bypass_wanted;
+	return block && !atomic_read(&block->useswcnt);
 }
 #endif
 
@@ -759,6 +759,15 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
 		cls_common->extack = extack;
 }
 
+static inline void tcf_proto_update_usesw(struct tcf_proto *tp, u32 flags)
+{
+	if (tp->usesw)
+		return;
+	if (tc_skip_sw(flags) && tc_in_hw(flags))
+		return;
+	tp->usesw = true;
+}
+
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 static inline struct tc_skb_ext *tc_skb_ext_alloc(struct sk_buff *skb)
 {
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 5d74fa7e694c..1e6324f0d4ef 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -425,6 +425,7 @@ struct tcf_proto {
 	spinlock_t		lock;
 	bool			deleting;
 	bool			counted;
+	bool			usesw;
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
 	struct hlist_node	destroy_ht_node;
@@ -474,9 +475,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
-	bool bypass_wanted;
-	atomic_t filtercnt; /* Number of filters */
-	atomic_t skipswcnt; /* Number of skip_sw filters */
+	atomic_t useswcnt;
 	atomic_t offloadcnt; /* Number of oddloaded filters */
 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
 	unsigned int lockeddevcnt; /* Number of devs that require rtnl lock. */
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a0bdd58f401c..83e9ef25b8d0 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -184,10 +184,13 @@ struct xfrm_state {
 	};
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
+	struct hlist_node	state_cache;
+	struct hlist_node	state_cache_input;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
 
+	u32			pcpu_num;
 	struct xfrm_id		id;
 	struct xfrm_selector	sel;
 	struct xfrm_mark	mark;
@@ -536,6 +539,7 @@ struct xfrm_policy_queue {
  *	@xp_net: network namespace the policy lives in
  *	@bydst: hlist node for SPD hash table or rbtree list
  *	@byidx: hlist node for index hash table
+ *	@state_cache_list: hlist head for policy cached xfrm states
  *	@lock: serialize changes to policy structure members
  *	@refcnt: reference count, freed once it reaches 0
  *	@pos: kernel internal tie-breaker to determine age of policy
@@ -566,6 +570,8 @@ struct xfrm_policy {
 	struct hlist_node	bydst;
 	struct hlist_node	byidx;
 
+	struct hlist_head	state_cache_list;
+
 	/* This lock only affects elements except for entry. */
 	rwlock_t		lock;
 	refcount_t		refcnt;
@@ -1217,9 +1223,19 @@ static inline int __xfrm_policy_check2(struct sock *sk, int dir,
 
 	if (xo) {
 		x = xfrm_input_state(skb);
-		if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
-			return (xo->flags & CRYPTO_DONE) &&
-			       (xo->status & CRYPTO_SUCCESS);
+		if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
+			bool check = (xo->flags & CRYPTO_DONE) &&
+				     (xo->status & CRYPTO_SUCCESS);
+
+			/* The packets here are plain ones and secpath was
+			 * needed to indicate that hardware already handled
+			 * them and there is no need to do nothing in addition.
+			 *
+			 * Consume secpath which was set by drivers.
+			 */
+			secpath_reset(skb);
+			return check;
+		}
 	}
 
 	return __xfrm_check_nopolicy(net, skb, dir) ||
@@ -1645,6 +1661,10 @@ int xfrm_state_update(struct xfrm_state *x);
 struct xfrm_state *xfrm_state_lookup(struct net *net, u32 mark,
 				     const xfrm_address_t *daddr, __be32 spi,
 				     u8 proto, unsigned short family);
+struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
+					   const xfrm_address_t *daddr,
+					   __be32 spi, u8 proto,
+					   unsigned short family);
 struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 					    const xfrm_address_t *daddr,
 					    const xfrm_address_t *saddr,
@@ -1684,7 +1704,7 @@ struct xfrmk_spdinfo {
 	u32 spdhmcnt;
 };
 
-struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
+struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 int xfrm_state_delete(struct xfrm_state *x);
 int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
@@ -1796,7 +1816,7 @@ int verify_spi_info(u8 proto, u32 min, u32 max, struct netlink_ext_ack *extack);
 int xfrm_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi,
 		   struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_find_acq(struct net *net, const struct xfrm_mark *mark,
-				 u8 mode, u32 reqid, u32 if_id, u8 proto,
+				 u8 mode, u32 reqid, u32 if_id, u32 pcpu_num, u8 proto,
 				 const xfrm_address_t *daddr,
 				 const xfrm_address_t *saddr, int create,
 				 unsigned short family);
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 957295364a5e..4c7a40e149a5 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -2,8 +2,6 @@
 #ifndef __SOUND_HDAUDIO_EXT_H
 #define __SOUND_HDAUDIO_EXT_H
 
-#include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/iopoll.h>
 #include <sound/hdaudio.h>
 
 int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
@@ -119,49 +117,6 @@ int snd_hdac_ext_bus_link_put(struct hdac_bus *bus, struct hdac_ext_link *hlink)
 
 void snd_hdac_ext_bus_link_power(struct hdac_device *codec, bool enable);
 
-#define snd_hdac_adsp_writeb(chip, reg, value) \
-	snd_hdac_reg_writeb(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readb(chip, reg) \
-	snd_hdac_reg_readb(chip, (chip)->dsp_ba + (reg))
-#define snd_hdac_adsp_writew(chip, reg, value) \
-	snd_hdac_reg_writew(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readw(chip, reg) \
-	snd_hdac_reg_readw(chip, (chip)->dsp_ba + (reg))
-#define snd_hdac_adsp_writel(chip, reg, value) \
-	snd_hdac_reg_writel(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readl(chip, reg) \
-	snd_hdac_reg_readl(chip, (chip)->dsp_ba + (reg))
-#define snd_hdac_adsp_writeq(chip, reg, value) \
-	snd_hdac_reg_writeq(chip, (chip)->dsp_ba + (reg), value)
-#define snd_hdac_adsp_readq(chip, reg) \
-	snd_hdac_reg_readq(chip, (chip)->dsp_ba + (reg))
-
-#define snd_hdac_adsp_updateb(chip, reg, mask, val) \
-	snd_hdac_adsp_writeb(chip, reg, \
-			(snd_hdac_adsp_readb(chip, reg) & ~(mask)) | (val))
-#define snd_hdac_adsp_updatew(chip, reg, mask, val) \
-	snd_hdac_adsp_writew(chip, reg, \
-			(snd_hdac_adsp_readw(chip, reg) & ~(mask)) | (val))
-#define snd_hdac_adsp_updatel(chip, reg, mask, val) \
-	snd_hdac_adsp_writel(chip, reg, \
-			(snd_hdac_adsp_readl(chip, reg) & ~(mask)) | (val))
-#define snd_hdac_adsp_updateq(chip, reg, mask, val) \
-	snd_hdac_adsp_writeq(chip, reg, \
-			(snd_hdac_adsp_readq(chip, reg) & ~(mask)) | (val))
-
-#define snd_hdac_adsp_readb_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readb_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_adsp_readw_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readw_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_adsp_readl_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readl_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_adsp_readq_poll(chip, reg, val, cond, delay_us, timeout_us) \
-	readq_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
-			   delay_us, timeout_us)
-
 struct hdac_ext_device;
 
 /* ops common to all codec drivers */
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index a0aed1a428a1..9a75590227f2 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -118,6 +118,8 @@ enum yfs_cm_operation {
  */
 #define afs_call_traces \
 	EM(afs_call_trace_alloc,		"ALLOC") \
+	EM(afs_call_trace_async_abort,		"ASYAB") \
+	EM(afs_call_trace_async_kill,		"ASYKL") \
 	EM(afs_call_trace_free,			"FREE ") \
 	EM(afs_call_trace_get,			"GET  ") \
 	EM(afs_call_trace_put,			"PUT  ") \
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index cc22596c7250..666fe1779ccc 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -117,6 +117,7 @@
 #define rxrpc_call_poke_traces \
 	EM(rxrpc_call_poke_abort,		"Abort")	\
 	EM(rxrpc_call_poke_complete,		"Compl")	\
+	EM(rxrpc_call_poke_conn_abort,		"Conn-abort")	\
 	EM(rxrpc_call_poke_error,		"Error")	\
 	EM(rxrpc_call_poke_idle,		"Idle")		\
 	EM(rxrpc_call_poke_set_timeout,		"Set-timo")	\
@@ -282,6 +283,7 @@
 	EM(rxrpc_call_see_activate_client,	"SEE act-clnt") \
 	EM(rxrpc_call_see_connect_failed,	"SEE con-fail") \
 	EM(rxrpc_call_see_connected,		"SEE connect ") \
+	EM(rxrpc_call_see_conn_abort,		"SEE conn-abt") \
 	EM(rxrpc_call_see_disconnected,		"SEE disconn ") \
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
@@ -956,6 +958,29 @@ TRACE_EVENT(rxrpc_rx_abort,
 		      __entry->abort_code)
 	    );
 
+TRACE_EVENT(rxrpc_rx_conn_abort,
+	    TP_PROTO(const struct rxrpc_connection *conn, const struct sk_buff *skb),
+
+	    TP_ARGS(conn, skb),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	conn)
+		    __field(rxrpc_serial_t,	serial)
+		    __field(u32,		abort_code)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->conn = conn->debug_id;
+		    __entry->serial = rxrpc_skb(skb)->hdr.serial;
+		    __entry->abort_code = skb->priority;
+			   ),
+
+	    TP_printk("C=%08x ABORT %08x ac=%d",
+		      __entry->conn,
+		      __entry->serial,
+		      __entry->abort_code)
+	    );
+
 TRACE_EVENT(rxrpc_rx_challenge,
 	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t serial,
 		     u32 version, u32 nonce, u32 min_level),
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index f28701500714..d73a97e3030a 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -322,6 +322,7 @@ enum xfrm_attr_type_t {
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
 	XFRMA_SA_DIR,		/* __u8 */
 	XFRMA_NAT_KEEPALIVE_INTERVAL,	/* __u32 in seconds for NAT keepalive */
+	XFRMA_SA_PCPU,		/* __u32 */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
@@ -437,6 +438,7 @@ struct xfrm_userpolicy_info {
 #define XFRM_POLICY_LOCALOK	1	/* Allow user to override global policy */
 	/* Automatically expand selector to include matching ICMP payloads. */
 #define XFRM_POLICY_ICMP	2
+#define XFRM_POLICY_CPU_ACQUIRE	4
 	__u8				share;
 };
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 883510a3e8d0..874f9e2defd5 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -340,7 +340,7 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	if (!prot || !prot->ioctl)
 		return -EOPNOTSUPP;
 
-	switch (cmd->sqe->cmd_op) {
+	switch (cmd->cmd_op) {
 	case SOCKET_URING_OP_SIOCINQ:
 		ret = prot->ioctl(sk, SIOCINQ, &arg);
 		if (ret)
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index e52b3ad231b9..93e48c7cad4e 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -212,7 +212,7 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
-	atomic_t mmap_count;
+	refcount_t mmap_count;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -222,7 +222,7 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
 	if (!vml)
 		return -ENOMEM;
-	atomic_set(&vml->mmap_count, 1);
+	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
 	list_add(&vml->head, &arena->vma_list);
@@ -233,7 +233,7 @@ static void arena_vm_open(struct vm_area_struct *vma)
 {
 	struct vma_list *vml = vma->vm_private_data;
 
-	atomic_inc(&vml->mmap_count);
+	refcount_inc(&vml->mmap_count);
 }
 
 static void arena_vm_close(struct vm_area_struct *vma)
@@ -242,7 +242,7 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	if (!atomic_dec_and_test(&vml->mmap_count))
+	if (!refcount_dec_and_test(&vml->mmap_count))
 		return;
 	guard(mutex)(&arena->lock);
 	/* update link list under lock */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index c938dea5ddbf..050c784498ab 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -797,8 +797,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
-	smap->bpf_ma = bpf_ma;
-	if (bpf_ma) {
+	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
+	 * preemptible context. Thus, enforce all storages to use
+	 * bpf_mem_alloc when CONFIG_PREEMPT_RT is enabled.
+	 */
+	smap->bpf_ma = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : bpf_ma;
+	if (smap->bpf_ma) {
 		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
 		if (err)
 			goto free_smap;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index b3a2ce1e5e22..b70d0eef8a28 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -311,6 +311,20 @@ void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 	kfree(arg_info);
 }
 
+static bool is_module_member(const struct btf *btf, u32 id)
+{
+	const struct btf_type *t;
+
+	t = btf_type_resolve_ptr(btf, id, NULL);
+	if (!t)
+		return false;
+
+	if (!__btf_type_is_struct(t) && !btf_type_is_fwd(t))
+		return false;
+
+	return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
+}
+
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
@@ -390,6 +404,13 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			goto errout;
 		}
 
+		if (!st_ops_ids[IDX_MODULE_ID] && is_module_member(btf, member->type)) {
+			pr_warn("'struct module' btf id not found. Is CONFIG_MODULES enabled? bpf_struct_ops '%s' needs module support.\n",
+				st_ops->name);
+			err = -EOPNOTSUPP;
+			goto errout;
+		}
+
 		func_proto = btf_type_resolve_func_ptr(btf,
 						       member->type,
 						       NULL);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 41d20b7199c4..a44f4be592be 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -498,11 +498,6 @@ bool btf_type_is_void(const struct btf_type *t)
 	return t == &btf_void;
 }
 
-static bool btf_type_is_fwd(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
-}
-
 static bool btf_type_is_datasec(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3d45ebe8afb4..a05aeb345896 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1593,10 +1593,24 @@ void bpf_timer_cancel_and_free(void *val)
 	 * To avoid these issues, punt to workqueue context when we are in a
 	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running))
+	if (this_cpu_read(hrtimer_running)) {
 		queue_work(system_unbound_wq, &t->cb.delete_work);
-	else
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/* If the timer is running on other CPU, also use a kworker to
+		 * wait for the completion of the timer instead of trying to
+		 * acquire a sleepable lock in hrtimer_cancel() to wait for its
+		 * completion.
+		 */
+		if (hrtimer_try_to_cancel(&t->timer) >= 0)
+			kfree_rcu(t, cb.rcu);
+		else
+			queue_work(system_unbound_wq, &t->cb.delete_work);
+	} else {
 		bpf_timer_delete_work(&t->cb.delete_work);
+	}
 }
 
 /* This function is called by map_delete/update_elem for individual element and
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..3b2bdca9f1d4 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -330,7 +330,8 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 #include <linux/of_reserved_mem.h>
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
-static struct reserved_mem *dma_reserved_default_memory __initdata;
+static phys_addr_t dma_reserved_default_memory_base __initdata;
+static phys_addr_t dma_reserved_default_memory_size __initdata;
 #endif
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
@@ -376,9 +377,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
 	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
-		WARN(dma_reserved_default_memory,
+		WARN(dma_reserved_default_memory_size,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
-		dma_reserved_default_memory = rmem;
+		dma_reserved_default_memory_base = rmem->base;
+		dma_reserved_default_memory_size = rmem->size;
 	}
 #endif
 
@@ -391,10 +393,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 #ifdef CONFIG_DMA_GLOBAL_POOL
 static int __init dma_init_reserved_memory(void)
 {
-	if (!dma_reserved_default_memory)
+	if (!dma_reserved_default_memory_size)
 		return -ENOMEM;
-	return dma_init_global_coherent(dma_reserved_default_memory->base,
-					dma_reserved_default_memory->size);
+	return dma_init_global_coherent(dma_reserved_default_memory_base,
+					dma_reserved_default_memory_size);
 }
 core_initcall(dma_init_reserved_memory);
 #endif /* CONFIG_DMA_GLOBAL_POOL */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index df27d08a7232..501d8c2fedff 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10375,9 +10375,9 @@ static struct pmu perf_tracepoint = {
 };
 
 static int perf_tp_filter_match(struct perf_event *event,
-				struct perf_sample_data *data)
+				struct perf_raw_record *raw)
 {
-	void *record = data->raw->frag.data;
+	void *record = raw->frag.data;
 
 	/* only top level events have filters set */
 	if (event->parent)
@@ -10389,7 +10389,7 @@ static int perf_tp_filter_match(struct perf_event *event,
 }
 
 static int perf_tp_event_match(struct perf_event *event,
-				struct perf_sample_data *data,
+				struct perf_raw_record *raw,
 				struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
@@ -10400,7 +10400,7 @@ static int perf_tp_event_match(struct perf_event *event,
 	if (event->attr.exclude_kernel && !user_mode(regs))
 		return 0;
 
-	if (!perf_tp_filter_match(event, data))
+	if (!perf_tp_filter_match(event, raw))
 		return 0;
 
 	return 1;
@@ -10426,6 +10426,7 @@ EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
 static void __perf_tp_event_target_task(u64 count, void *record,
 					struct pt_regs *regs,
 					struct perf_sample_data *data,
+					struct perf_raw_record *raw,
 					struct perf_event *event)
 {
 	struct trace_entry *entry = record;
@@ -10435,13 +10436,17 @@ static void __perf_tp_event_target_task(u64 count, void *record,
 	/* Cannot deliver synchronous signal to other task. */
 	if (event->attr.sigtrap)
 		return;
-	if (perf_tp_event_match(event, data, regs))
+	if (perf_tp_event_match(event, raw, regs)) {
+		perf_sample_data_init(data, 0, 0);
+		perf_sample_save_raw_data(data, event, raw);
 		perf_swevent_event(event, count, data, regs);
+	}
 }
 
 static void perf_tp_event_target_task(u64 count, void *record,
 				      struct pt_regs *regs,
 				      struct perf_sample_data *data,
+				      struct perf_raw_record *raw,
 				      struct perf_event_context *ctx)
 {
 	unsigned int cpu = smp_processor_id();
@@ -10449,15 +10454,15 @@ static void perf_tp_event_target_task(u64 count, void *record,
 	struct perf_event *event, *sibling;
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 }
 
@@ -10475,15 +10480,10 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		},
 	};
 
-	perf_sample_data_init(&data, 0, 0);
-	perf_sample_save_raw_data(&data, &raw);
-
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs)) {
-			perf_swevent_event(event, count, &data, regs);
-
+		if (perf_tp_event_match(event, &raw, regs)) {
 			/*
 			 * Here use the same on-stack perf_sample_data,
 			 * some members in data are event-specific and
@@ -10493,7 +10493,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			 * because data->sample_flags is set.
 			 */
 			perf_sample_data_init(&data, 0, 0);
-			perf_sample_save_raw_data(&data, &raw);
+			perf_sample_save_raw_data(&data, event, &raw);
+			perf_swevent_event(event, count, &data, regs);
 		}
 	}
 
@@ -10510,7 +10511,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		perf_tp_event_target_task(count, record, regs, &data, &raw, ctx);
 		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fe0272cd84a5..a29df4b02a2e 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -441,10 +441,6 @@ static inline struct cpumask *irq_desc_get_pending_mask(struct irq_desc *desc)
 {
 	return desc->pending_mask;
 }
-static inline bool handle_enforce_irqctx(struct irq_data *data)
-{
-	return irqd_is_handle_enforce_irqctx(data);
-}
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
@@ -471,11 +467,12 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
 {
 	return false;
 }
+#endif /* !CONFIG_GENERIC_PENDING_IRQ */
+
 static inline bool handle_enforce_irqctx(struct irq_data *data)
 {
-	return false;
+	return irqd_is_handle_enforce_irqctx(data);
 }
-#endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
 static inline int irq_domain_activate_irq(struct irq_data *data, bool reserve)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..93a07387af3b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2583,7 +2583,10 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	ret = module_enable_rodata_ro(mod, true);
 	if (ret)
-		goto fail_mutex_unlock;
+		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
+			"ro_after_init data might still be writable\n",
+			mod->name, ret);
+
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {
@@ -2622,8 +2625,6 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
-fail_mutex_unlock:
-	mutex_unlock(&module_mutex);
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
diff --git a/kernel/padata.c b/kernel/padata.c
index d899f34558af..22770372bdf3 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -47,6 +47,22 @@ struct padata_mt_job_state {
 static void padata_free_pd(struct parallel_data *pd);
 static void __init padata_mt_helper(struct work_struct *work);
 
+static inline void padata_get_pd(struct parallel_data *pd)
+{
+	refcount_inc(&pd->refcnt);
+}
+
+static inline void padata_put_pd_cnt(struct parallel_data *pd, int cnt)
+{
+	if (refcount_sub_and_test(cnt, &pd->refcnt))
+		padata_free_pd(pd);
+}
+
+static inline void padata_put_pd(struct parallel_data *pd)
+{
+	padata_put_pd_cnt(pd, 1);
+}
+
 static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
 {
 	int cpu, target_cpu;
@@ -206,7 +222,7 @@ int padata_do_parallel(struct padata_shell *ps,
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-	refcount_inc(&pd->refcnt);
+	padata_get_pd(pd);
 	padata->pd = pd;
 	padata->cb_cpu = *cb_cpu;
 
@@ -336,8 +352,14 @@ static void padata_reorder(struct parallel_data *pd)
 	smp_mb();
 
 	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
-	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
+	if (!list_empty(&reorder->list) && padata_find_next(pd, false)) {
+		/*
+		 * Other context(eg. the padata_serial_worker) can finish the request.
+		 * To avoid UAF issue, add pd ref here, and put pd ref after reorder_work finish.
+		 */
+		padata_get_pd(pd);
 		queue_work(pinst->serial_wq, &pd->reorder_work);
+	}
 }
 
 static void invoke_padata_reorder(struct work_struct *work)
@@ -348,6 +370,8 @@ static void invoke_padata_reorder(struct work_struct *work)
 	pd = container_of(work, struct parallel_data, reorder_work);
 	padata_reorder(pd);
 	local_bh_enable();
+	/* Pairs with putting the reorder_work in the serial_wq */
+	padata_put_pd(pd);
 }
 
 static void padata_serial_worker(struct work_struct *serial_work)
@@ -380,8 +404,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 	}
 	local_bh_enable();
 
-	if (refcount_sub_and_test(cnt, &pd->refcnt))
-		padata_free_pd(pd);
+	padata_put_pd_cnt(pd, cnt);
 }
 
 /**
@@ -688,8 +711,7 @@ static int padata_replace(struct padata_instance *pinst)
 	synchronize_rcu();
 
 	list_for_each_entry_continue_reverse(ps, &pinst->pslist, list)
-		if (refcount_dec_and_test(&ps->opd->refcnt))
-			padata_free_pd(ps->opd);
+		padata_put_pd(ps->opd);
 
 	pinst->flags &= ~PADATA_RESET;
 
@@ -977,7 +999,7 @@ static ssize_t padata_sysfs_store(struct kobject *kobj, struct attribute *attr,
 
 	pinst = kobj2pinst(kobj);
 	pentry = attr2pentry(attr);
-	if (pentry->show)
+	if (pentry->store)
 		ret = pentry->store(pinst, attr, buf, count);
 
 	return ret;
@@ -1128,11 +1150,16 @@ void padata_free_shell(struct padata_shell *ps)
 	if (!ps)
 		return;
 
+	/*
+	 * Wait for all _do_serial calls to finish to avoid touching
+	 * freed pd's and ps's.
+	 */
+	synchronize_rcu();
+
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
 	pd = rcu_dereference_protected(ps->pd, 1);
-	if (refcount_dec_and_test(&pd->refcnt))
-		padata_free_pd(pd);
+	padata_put_pd(pd);
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e35829d36039..b483fcea811b 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -608,7 +608,11 @@ int hibernation_platform_enter(void)
 
 	local_irq_disable();
 	system_state = SYSTEM_SUSPEND;
-	syscore_suspend();
+
+	error = syscore_suspend();
+	if (error)
+		goto Enable_irqs;
+
 	if (pm_wakeup_pending()) {
 		error = -EAGAIN;
 		goto Power_up;
@@ -620,6 +624,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+ Enable_irqs:
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3fcb48502adb..5eef70000b43 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -335,3 +335,9 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
 void console_prepend_replay(struct printk_message *pmsg);
 #endif
+
+#ifdef CONFIG_SMP
+bool is_printk_cpu_sync_owner(void);
+#else
+static inline bool is_printk_cpu_sync_owner(void) { return false; }
+#endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..7530df62ff7c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4892,6 +4892,11 @@ void console_try_replay_all(void)
 static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
 static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
 
+bool is_printk_cpu_sync_owner(void)
+{
+	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
+}
+
 /**
  * __printk_cpu_sync_wait() - Busy wait until the printk cpu-reentrant
  *                            spinning lock is not owned by any CPU.
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 2b35a9d3919d..e6198da7c735 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -43,10 +43,15 @@ bool is_printk_legacy_deferred(void)
 	/*
 	 * The per-CPU variable @printk_context can be read safely in any
 	 * context. CPU migration is always disabled when set.
+	 *
+	 * A context holding the printk_cpu_sync must not spin waiting for
+	 * another CPU. For legacy printing, it could be the console_lock
+	 * or the port lock.
 	 */
 	return (force_legacy_kthread() ||
 		this_cpu_read(printk_context) ||
-		in_nmi());
+		in_nmi() ||
+		is_printk_cpu_sync_owner());
 }
 
 asmlinkage int vprintk(const char *fmt, va_list args)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d07dc87787df..aba41c69f09c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2024,10 +2024,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_inc(rq, p);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
+	psi_enqueue(p, flags);
+
+	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, flags & ENQUEUE_MIGRATED);
-	}
 
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
@@ -2044,10 +2044,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & DEQUEUE_SAVE)) {
+	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeue(rq, p);
-		psi_dequeue(p, !(flags & DEQUEUE_SLEEP));
-	}
+
+	psi_dequeue(p, flags);
 
 	/*
 	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
@@ -6507,6 +6507,45 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #define SM_PREEMPT		1
 #define SM_RTLOCK_WAIT		2
 
+/*
+ * Helper function for __schedule()
+ *
+ * If a task does not have signals pending, deactivate it
+ * Otherwise marks the task's __state as RUNNING
+ */
+static bool try_to_block_task(struct rq *rq, struct task_struct *p,
+			      unsigned long task_state)
+{
+	int flags = DEQUEUE_NOCLOCK;
+
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		return false;
+	}
+
+	p->sched_contributes_to_load =
+		(task_state & TASK_UNINTERRUPTIBLE) &&
+		!(task_state & TASK_NOLOAD) &&
+		!(task_state & TASK_FROZEN);
+
+	if (unlikely(is_special_task_state(task_state)))
+		flags |= DEQUEUE_SPECIAL;
+
+	/*
+	 * __schedule()			ttwu()
+	 *   prev_state = prev->state;    if (p->on_rq && ...)
+	 *   if (prev_state)		    goto out;
+	 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+	 *				  p->state = TASK_WAKING
+	 *
+	 * Where __schedule() and ttwu() have matching control dependencies.
+	 *
+	 * After this, schedule() must not care about p->state any more.
+	 */
+	block_task(rq, p, flags);
+	return true;
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6554,7 +6593,6 @@ static void __sched notrace __schedule(int sched_mode)
 	 * as a preemption by schedule_debug() and RCU.
 	 */
 	bool preempt = sched_mode > SM_NONE;
-	bool block = false;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6615,33 +6653,7 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		if (signal_pending_state(prev_state, prev)) {
-			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
-			int flags = DEQUEUE_NOCLOCK;
-
-			prev->sched_contributes_to_load =
-				(prev_state & TASK_UNINTERRUPTIBLE) &&
-				!(prev_state & TASK_NOLOAD) &&
-				!(prev_state & TASK_FROZEN);
-
-			if (unlikely(is_special_task_state(prev_state)))
-				flags |= DEQUEUE_SPECIAL;
-
-			/*
-			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;    if (p->on_rq && ...)
-			 *   if (prev_state)		    goto out;
-			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
-			 *				  p->state = TASK_WAKING
-			 *
-			 * Where __schedule() and ttwu() have matching control dependencies.
-			 *
-			 * After this, schedule() must not care about p->state any more.
-			 */
-			block_task(rq, prev, flags);
-			block = true;
-		}
+		try_to_block_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
@@ -6686,7 +6698,8 @@ static void __sched notrace __schedule(int sched_mode)
 
 		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, block);
+		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
+					     prev->se.sched_delayed);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 28c77904ea74..e51d5ce730be 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = true;
+		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 		return true;
 	}
 
@@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
 	if (sg_policy->need_freq_update)
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = false;
 	else if (sg_policy->next_freq == next_freq)
 		return false;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 60be5f8bbe71..65e7be644872 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5647,9 +5647,9 @@ static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
-	 * Enabling NEXT_BUDDY will affect latency but not fairness.
+	 * Picking the ->next buddy will affect latency but not fairness.
 	 */
-	if (sched_feat(NEXT_BUDDY) &&
+	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
 		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
@@ -9418,6 +9418,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	int tsk_cache_hot;
 
 	lockdep_assert_rq_held(env->src_rq);
+	if (p->sched_task_hot)
+		p->sched_task_hot = 0;
 
 	/*
 	 * We do not migrate tasks that are:
@@ -9490,10 +9492,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	if (tsk_cache_hot <= 0 ||
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
-		if (tsk_cache_hot == 1) {
-			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->stats.nr_forced_migrations);
-		}
+		if (tsk_cache_hot == 1)
+			p->sched_task_hot = 1;
 		return 1;
 	}
 
@@ -9508,6 +9508,12 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 {
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (p->sched_task_hot) {
+		p->sched_task_hot = 0;
+		schedstat_inc(env->sd->lb_hot_gained[env->idle]);
+		schedstat_inc(p->stats.nr_forced_migrations);
+	}
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }
@@ -9668,6 +9674,9 @@ static int detach_tasks(struct lb_env *env)
 
 		continue;
 next:
+		if (p->sched_task_hot)
+			schedstat_inc(p->stats.nr_failed_migrations_hot);
+
 		list_move(&p->se.group_node, tasks);
 	}
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 290874079f60..050d7503064e 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -31,6 +31,15 @@ SCHED_FEAT(PREEMPT_SHORT, true)
  */
 SCHED_FEAT(NEXT_BUDDY, false)
 
+/*
+ * Allow completely ignoring cfs_rq->next; which can be set from various
+ * places:
+ *   - NEXT_BUDDY (wakeup preemption)
+ *   - yield_to_task()
+ *   - cgroup dequeue / pick
+ */
+SCHED_FEAT(PICK_BUDDY, true)
+
 /*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f2ef520513c4..5426969cf478 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2095,34 +2095,6 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 
 #endif /* CONFIG_SMP */
 
-#include "stats.h"
-
-#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
-
-extern void __sched_core_account_forceidle(struct rq *rq);
-
-static inline void sched_core_account_forceidle(struct rq *rq)
-{
-	if (schedstat_enabled())
-		__sched_core_account_forceidle(rq);
-}
-
-extern void __sched_core_tick(struct rq *rq);
-
-static inline void sched_core_tick(struct rq *rq)
-{
-	if (sched_core_enabled(rq) && schedstat_enabled())
-		__sched_core_tick(rq);
-}
-
-#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
-
-static inline void sched_core_account_forceidle(struct rq *rq) { }
-
-static inline void sched_core_tick(struct rq *rq) { }
-
-#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
-
 #ifdef CONFIG_CGROUP_SCHED
 
 /*
@@ -3209,6 +3181,34 @@ extern void nohz_run_idle_balance(int cpu);
 static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
+#include "stats.h"
+
+#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
+
+extern void __sched_core_account_forceidle(struct rq *rq);
+
+static inline void sched_core_account_forceidle(struct rq *rq)
+{
+	if (schedstat_enabled())
+		__sched_core_account_forceidle(rq);
+}
+
+extern void __sched_core_tick(struct rq *rq);
+
+static inline void sched_core_tick(struct rq *rq)
+{
+	if (sched_core_enabled(rq) && schedstat_enabled())
+		__sched_core_tick(rq);
+}
+
+#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
+
+static inline void sched_core_account_forceidle(struct rq *rq) { }
+
+static inline void sched_core_tick(struct rq *rq) { }
+
+#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 struct irqtime {
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 767e098a3bd1..6ade91bce63e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -127,21 +127,29 @@ static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
  * go through migration requeues. In this case, *sleeping* states need
  * to be transferred.
  */
-static inline void psi_enqueue(struct task_struct *p, bool migrate)
+static inline void psi_enqueue(struct task_struct *p, int flags)
 {
 	int clear = 0, set = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	/* Same runqueue, nothing changed for psi */
+	if (flags & ENQUEUE_RESTORE)
+		return;
+
+	/* psi_sched_switch() will handle the flags */
+	if (task_on_cpu(task_rq(p), p))
+		return;
+
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
-		SCHED_WARN_ON(!migrate);
+		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
 		if (p->in_iowait)
 			set |= TSK_IOWAIT;
-	} else if (migrate) {
+	} else if (flags & ENQUEUE_MIGRATED) {
 		/* CPU migration of runnable task */
 		set = TSK_RUNNING;
 		if (p->in_memstall)
@@ -158,17 +166,14 @@ static inline void psi_enqueue(struct task_struct *p, bool migrate)
 	psi_task_change(p, clear, set);
 }
 
-static inline void psi_dequeue(struct task_struct *p, bool migrate)
+static inline void psi_dequeue(struct task_struct *p, int flags)
 {
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	/*
-	 * When migrating a task to another CPU, clear all psi
-	 * state. The enqueue callback above will work it out.
-	 */
-	if (migrate)
-		psi_task_change(p, p->psi_flags, 0);
+	/* Same runqueue, nothing changed for psi */
+	if (flags & DEQUEUE_SAVE)
+		return;
 
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
@@ -176,6 +181,14 @@ static inline void psi_dequeue(struct task_struct *p, bool migrate)
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
 	 */
+	if (flags & DEQUEUE_SLEEP)
+		return;
+
+	/*
+	 * When migrating a task to another CPU, clear all psi
+	 * state. The enqueue callback above will work it out.
+	 */
+	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 1784ed1fb3fe..f9cb7896c1b9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1471,7 +1471,7 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 	struct rq *rq, *p_rq;
 	int yielded = 0;
 
-	scoped_guard (irqsave) {
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		rq = this_rq();
 
 again:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 50881898e758..449efaaa387a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -619,7 +619,8 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
-			u64 flags, struct perf_sample_data *sd)
+			u64 flags, struct perf_raw_record *raw,
+			struct perf_sample_data *sd)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	unsigned int cpu = smp_processor_id();
@@ -644,6 +645,8 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
+	perf_sample_save_raw_data(sd, event, raw);
+
 	return perf_event_output(event, sd, regs);
 }
 
@@ -687,9 +690,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	err = __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_trace_nest_level);
 	preempt_enable();
@@ -748,9 +750,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	ret = __bpf_perf_event_output(regs, map, flags, sd);
+	ret = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
 	preempt_enable();
@@ -832,7 +833,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (irqs_disabled()) {
+	if (!preemptible()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6c902639728b..0e9a1d4cf89b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -584,10 +584,6 @@ static struct bucket_table *rhashtable_insert_one(
 	 */
 	rht_assign_locked(bkt, obj);
 
-	atomic_inc(&ht->nelems);
-	if (rht_grow_above_75(ht, tbl))
-		schedule_work(&ht->run_work);
-
 	return NULL;
 }
 
@@ -615,15 +611,23 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
+			bool inserted;
+
 			flags = rht_lock(tbl, bkt);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
 							hash, obj, data);
+			inserted = data && !new_tbl;
+			if (inserted)
+				atomic_inc(&ht->nelems);
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
 			rht_unlock(tbl, bkt, flags);
+
+			if (inserted && rht_grow_above_75(ht, tbl))
+				schedule_work(&ht->run_work);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 53db98d2c4a1..ae1d184d035a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1139,6 +1139,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
+	int i = 0;
 
 	BUG_ON(mem_cgroup_is_root(memcg));
 
@@ -1147,8 +1148,12 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct task_struct *task;
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
-		while (!ret && (task = css_task_iter_next(&it)))
+		while (!ret && (task = css_task_iter_next(&it))) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				cond_resched();
 			ret = fn(task, arg);
+		}
 		css_task_iter_end(&it);
 		if (ret) {
 			mem_cgroup_iter_break(memcg, iter);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 4d7a0004df2c..8aa712afd8ae 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -45,6 +45,7 @@
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
 #include <linux/cred.h>
+#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -431,10 +432,15 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
+		int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p)
+		for_each_process(p) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				touch_softlockup_watchdog();
 			dump_task(p, oc);
+		}
 		rcu_read_unlock();
 	}
 }
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d6f9fae06a9d..aa6c714892ec 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -467,7 +467,7 @@ static int ax25_ctl_ioctl(const unsigned int cmd, void __user *arg)
 	goto out_put;
 }
 
-static void ax25_fillin_cb_from_dev(ax25_cb *ax25, ax25_dev *ax25_dev)
+static void ax25_fillin_cb_from_dev(ax25_cb *ax25, const ax25_dev *ax25_dev)
 {
 	ax25->rtt     = msecs_to_jiffies(ax25_dev->values[AX25_VALUES_T1]) / 2;
 	ax25->t1      = msecs_to_jiffies(ax25_dev->values[AX25_VALUES_T1]);
@@ -677,22 +677,22 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		rtnl_lock();
-		dev = __dev_get_by_name(&init_net, devname);
+		rcu_read_lock();
+		dev = dev_get_by_name_rcu(&init_net, devname);
 		if (!dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
-		rtnl_unlock();
+		rcu_read_unlock();
 		break;
 
 	default:
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 9efd6690b344..3733c0254a50 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -90,7 +90,7 @@ void ax25_dev_device_up(struct net_device *dev)
 
 	spin_lock_bh(&ax25_dev_lock);
 	list_add(&ax25_dev->list, &ax25_dev_list);
-	dev->ax25_ptr     = ax25_dev;
+	rcu_assign_pointer(dev->ax25_ptr, ax25_dev);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	ax25_register_dev_sysctl(ax25_dev);
@@ -125,7 +125,7 @@ void ax25_dev_device_down(struct net_device *dev)
 		}
 	}
 
-	dev->ax25_ptr = NULL;
+	RCU_INIT_POINTER(dev->ax25_ptr, NULL);
 	spin_unlock_bh(&ax25_dev_lock);
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
diff --git a/net/ax25/ax25_ip.c b/net/ax25/ax25_ip.c
index 36249776c021..215d4ccf12b9 100644
--- a/net/ax25/ax25_ip.c
+++ b/net/ax25/ax25_ip.c
@@ -122,6 +122,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff *skb)
 	if (dev == NULL)
 		dev = skb->dev;
 
+	rcu_read_lock();
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL) {
 		kfree_skb(skb);
 		goto put;
@@ -202,7 +203,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff *skb)
 	ax25_queue_xmit(skb, dev);
 
 put:
-
+	rcu_read_unlock();
 	ax25_route_lock_unuse();
 	return NETDEV_TX_OK;
 }
diff --git a/net/ax25/ax25_out.c b/net/ax25/ax25_out.c
index 3db76d2470e9..8bca2ace98e5 100644
--- a/net/ax25/ax25_out.c
+++ b/net/ax25/ax25_out.c
@@ -39,10 +39,14 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 	 * specified.
 	 */
 	if (paclen == 0) {
-		if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
+		rcu_read_lock();
+		ax25_dev = ax25_dev_ax25dev(dev);
+		if (!ax25_dev) {
+			rcu_read_unlock();
 			return NULL;
-
+		}
 		paclen = ax25_dev->values[AX25_VALUES_PACLEN];
+		rcu_read_unlock();
 	}
 
 	/*
@@ -53,13 +57,19 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		return ax25;		/* It already existed */
 	}
 
-	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
+	rcu_read_lock();
+	ax25_dev = ax25_dev_ax25dev(dev);
+	if (!ax25_dev) {
+		rcu_read_unlock();
 		return NULL;
+	}
 
-	if ((ax25 = ax25_create_cb()) == NULL)
+	if ((ax25 = ax25_create_cb()) == NULL) {
+		rcu_read_unlock();
 		return NULL;
-
+	}
 	ax25_fillin_cb(ax25, ax25_dev);
+	rcu_read_unlock();
 
 	ax25->source_addr = *src;
 	ax25->dest_addr   = *dest;
@@ -358,7 +368,9 @@ void ax25_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned char *ptr;
 
+	rcu_read_lock();
 	skb->protocol = ax25_type_trans(skb, ax25_fwd_dev(dev));
+	rcu_read_unlock();
 
 	ptr  = skb_push(skb, 1);
 	*ptr = 0x00;			/* KISS */
diff --git a/net/ax25/ax25_route.c b/net/ax25/ax25_route.c
index b7c4d656a94b..69de75db0c9c 100644
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -406,6 +406,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
 		ax25_route_lock_unuse();
 		return -EHOSTUNREACH;
 	}
+	rcu_read_lock();
 	if ((ax25->ax25_dev = ax25_dev_ax25dev(ax25_rt->dev)) == NULL) {
 		err = -EHOSTUNREACH;
 		goto put;
@@ -442,6 +443,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
 	}
 
 put:
+	rcu_read_unlock();
 	ax25_route_lock_unuse();
 	return err;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 1867a6a8d76d..2e0fe38d0e87 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1279,7 +1279,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
 rollback:
 	ret = device_rename(&dev->dev, dev->name);
 	if (ret) {
+		write_seqlock_bh(&netdev_rename_lock);
 		memcpy(dev->name, oldname, IFNAMSIZ);
+		write_sequnlock_bh(&netdev_rename_lock);
 		WRITE_ONCE(dev->name_assign_type, old_assign_type);
 		up_write(&devnet_rename_sem);
 		return ret;
@@ -2134,8 +2136,8 @@ EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
 #ifdef CONFIG_NET_CLS_ACT
-DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
-EXPORT_SYMBOL(tcf_bypass_check_needed_key);
+DEFINE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
+EXPORT_SYMBOL(tcf_sw_enabled_key);
 #endif
 
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4028,10 +4030,13 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 	if (!miniq)
 		return ret;
 
-	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
-		if (tcf_block_bypass_sw(miniq->block))
-			return ret;
-	}
+	/* Global bypass */
+	if (!static_branch_likely(&tcf_sw_enabled_key))
+		return ret;
+
+	/* Block-wise bypass */
+	if (tcf_block_bypass_sw(miniq->block))
+		return ret;
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
@@ -9590,6 +9595,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Program bound to different device");
 			return -EINVAL;
 		}
+		if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+			return -EINVAL;
+		}
 		if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
 			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
 			return -EINVAL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 46da488ff070..a2f990bf51e5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7662,7 +7662,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 86a2476678c4..5dd54a813398 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -303,7 +303,7 @@ static int proc_do_dev_weight(const struct ctl_table *table, int write,
 	int ret, weight;
 
 	mutex_lock(&dev_weight_mutex);
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
 		WRITE_ONCE(net_hotdata.dev_rx_weight, weight * dev_weight_rx_bias);
@@ -396,6 +396,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_rx_bias",
@@ -403,6 +404,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_tx_bias",
@@ -410,6 +412,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "netdev_max_backlog",
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 65cfe76dafbe..8b9692c35e70 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -992,7 +992,13 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (rc)
 		return rc;
 
-	if (ops->get_rxfh) {
+	/* Nonzero ring with RSS only makes sense if NIC adds them together */
+	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS &&
+	    !ops->cap_rss_rxnfc_adds &&
+	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
+		return -EINVAL;
+
+	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
 		rc = ops->get_rxfh(dev, &rxfh);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e3f0ef6b851b..4d18dc29b304 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
 		pm_runtime_get_sync(dev->dev.parent);
 
 	if (!netif_device_present(dev) ||
-	    dev->reg_state == NETREG_UNREGISTERING) {
+	    dev->reg_state >= NETREG_UNREGISTERING) {
 		ret = -ENODEV;
 		goto err;
 	}
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 40c5fbbd155d..c0217476eb17 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -688,9 +688,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;
 
 	if (frame->is_vlan) {
-		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
+		/* Note: skb->mac_len might be wrong here. */
+		if (!pskb_may_pull(skb,
+				   skb_mac_offset(skb) +
+				   offsetofend(struct hsr_vlan_ethhdr, vlanhdr)))
 			return -EINVAL;
-		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
+		vlan_hdr = (struct hsr_vlan_ethhdr *)skb_mac_header(skb);
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
 		netdev_warn_once(skb->dev, "VLAN not yet supported");
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 80c4ea0e12f4..e0d94270da28 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -53,9 +53,9 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		if (sp->len == XFRM_MAX_DEPTH)
 			goto out_reset;
 
-		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
-				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
-				      spi, IPPROTO_ESP, AF_INET);
+		x = xfrm_input_state_lookup(dev_net(skb->dev), skb->mark,
+					    (xfrm_address_t *)&ip_hdr(skb)->daddr,
+					    spi, IPPROTO_ESP, AF_INET);
 
 		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
 			/* non-offload path will record the error and audit log */
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index c3ad41573b33..932bd775fc26 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -312,7 +312,6 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	bool rc = true;
-	int vif;
 
 	if (!apply_ratelimit)
 		return true;
@@ -321,12 +320,12 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
 		goto out;
 
-	vif = l3mdev_master_ifindex(dst->dev);
-	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif, 1);
+	rcu_read_lock();
+	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
+			       l3mdev_master_ifindex_rcu(dst->dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 5bd759963451..9c5ffe3b5f77 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -95,6 +95,7 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 {
 	struct rb_node **pp, *parent, *next;
 	struct inet_peer *p;
+	u32 now;
 
 	pp = &base->rb_root.rb_node;
 	parent = NULL;
@@ -108,8 +109,9 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 		p = rb_entry(parent, struct inet_peer, rb_node);
 		cmp = inetpeer_addr_cmp(daddr, &p->daddr);
 		if (cmp == 0) {
-			if (!refcount_inc_not_zero(&p->refcnt))
-				break;
+			now = jiffies;
+			if (READ_ONCE(p->dtime) != now)
+				WRITE_ONCE(p->dtime, now);
 			return p;
 		}
 		if (gc_stack) {
@@ -155,9 +157,6 @@ static void inet_peer_gc(struct inet_peer_base *base,
 	for (i = 0; i < gc_cnt; i++) {
 		p = gc_stack[i];
 
-		/* The READ_ONCE() pairs with the WRITE_ONCE()
-		 * in inet_putpeer()
-		 */
 		delta = (__u32)jiffies - READ_ONCE(p->dtime);
 
 		if (delta < ttl || !refcount_dec_if_one(&p->refcnt))
@@ -173,31 +172,23 @@ static void inet_peer_gc(struct inet_peer_base *base,
 	}
 }
 
+/* Must be called under RCU : No refcount change is done here. */
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
-			       const struct inetpeer_addr *daddr,
-			       int create)
+			       const struct inetpeer_addr *daddr)
 {
 	struct inet_peer *p, *gc_stack[PEER_MAX_GC];
 	struct rb_node **pp, *parent;
 	unsigned int gc_cnt, seq;
-	int invalidated;
 
 	/* Attempt a lockless lookup first.
 	 * Because of a concurrent writer, we might not find an existing entry.
 	 */
-	rcu_read_lock();
 	seq = read_seqbegin(&base->lock);
 	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
-	invalidated = read_seqretry(&base->lock, seq);
-	rcu_read_unlock();
 
 	if (p)
 		return p;
 
-	/* If no writer did a change during our lookup, we can return early. */
-	if (!create && !invalidated)
-		return NULL;
-
 	/* retry an exact lookup, taking the lock before.
 	 * At least, nodes should be hot in our cache.
 	 */
@@ -206,12 +197,12 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 	gc_cnt = 0;
 	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
-	if (!p && create) {
+	if (!p) {
 		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
 			p->dtime = (__u32)jiffies;
-			refcount_set(&p->refcnt, 2);
+			refcount_set(&p->refcnt, 1);
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 			p->rate_tokens = 0;
@@ -236,15 +227,9 @@ EXPORT_SYMBOL_GPL(inet_getpeer);
 
 void inet_putpeer(struct inet_peer *p)
 {
-	/* The WRITE_ONCE() pairs with itself (we run lockless)
-	 * and the READ_ONCE() in inet_peer_gc()
-	 */
-	WRITE_ONCE(p->dtime, (__u32)jiffies);
-
 	if (refcount_dec_and_test(&p->refcnt))
 		call_rcu(&p->rcu, inetpeer_free_rcu);
 }
-EXPORT_SYMBOL_GPL(inet_putpeer);
 
 /*
  *	Check transmit rate limitation for given message.
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a92664a5ef2e..9ca0a183a55f 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -82,15 +82,20 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
 {
 	struct ipq *qp = container_of(q, struct ipq, q);
-	struct net *net = q->fqdir->net;
-
 	const struct frag_v4_compare_key *key = a;
+	struct net *net = q->fqdir->net;
+	struct inet_peer *p = NULL;
 
 	q->key.v4 = *key;
 	qp->ecn = 0;
-	qp->peer = q->fqdir->max_dist ?
-		inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif, 1) :
-		NULL;
+	if (q->fqdir->max_dist) {
+		rcu_read_lock();
+		p = inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif);
+		if (p && !refcount_inc_not_zero(&p->refcnt))
+			p = NULL;
+		rcu_read_unlock();
+	}
+	qp->peer = p;
 }
 
 static void ip4_frag_free(struct inet_frag_queue *q)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 449a2ac40bdc..de0d9cc7806a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -817,7 +817,7 @@ static void ipmr_update_thresholds(struct mr_table *mrt, struct mr_mfc *cache,
 				cache->mfc_un.res.maxvif = vifi + 1;
 		}
 	}
-	cache->mfc_un.res.lastuse = jiffies;
+	WRITE_ONCE(cache->mfc_un.res.lastuse, jiffies);
 }
 
 static int vif_add(struct net *net, struct mr_table *mrt,
@@ -1667,9 +1667,9 @@ int ipmr_ioctl(struct sock *sk, int cmd, void *arg)
 		rcu_read_lock();
 		c = ipmr_cache_find(mrt, sr->src.s_addr, sr->grp.s_addr);
 		if (c) {
-			sr->pktcnt = c->_c.mfc_un.res.pkt;
-			sr->bytecnt = c->_c.mfc_un.res.bytes;
-			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr->pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 			return 0;
 		}
@@ -1739,9 +1739,9 @@ int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_lock();
 		c = ipmr_cache_find(mrt, sr.src.s_addr, sr.grp.s_addr);
 		if (c) {
-			sr.pktcnt = c->_c.mfc_un.res.pkt;
-			sr.bytecnt = c->_c.mfc_un.res.bytes;
-			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr.bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr.wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
@@ -1974,9 +1974,9 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	int vif, ct;
 
 	vif = c->_c.mfc_parent;
-	c->_c.mfc_un.res.pkt++;
-	c->_c.mfc_un.res.bytes += skb->len;
-	c->_c.mfc_un.res.lastuse = jiffies;
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
 
 	if (c->mfc_origin == htonl(INADDR_ANY) && true_vifi >= 0) {
 		struct mfc_cache *cache_proxy;
@@ -2007,7 +2007,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			goto dont_forward;
 		}
 
-		c->_c.mfc_un.res.wrong_if++;
+		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
@@ -3015,9 +3015,9 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 
 		if (it->cache != &mrt->mfc_unres_queue) {
 			seq_printf(seq, " %8lu %8lu %8lu",
-				   mfc->_c.mfc_un.res.pkt,
-				   mfc->_c.mfc_un.res.bytes,
-				   mfc->_c.mfc_un.res.wrong_if);
+				   atomic_long_read(&mfc->_c.mfc_un.res.pkt),
+				   atomic_long_read(&mfc->_c.mfc_un.res.bytes),
+				   atomic_long_read(&mfc->_c.mfc_un.res.wrong_if));
 			for (n = mfc->_c.mfc_un.res.minvif;
 			     n < mfc->_c.mfc_un.res.maxvif; n++) {
 				if (VIF_EXISTS(mrt, n) &&
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index f0af12a2f70b..28d77d454d44 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -263,9 +263,9 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 	lastuse = READ_ONCE(c->mfc_un.res.lastuse);
 	lastuse = time_after_eq(jiffies, lastuse) ? jiffies - lastuse : 0;
 
-	mfcs.mfcs_packets = c->mfc_un.res.pkt;
-	mfcs.mfcs_bytes = c->mfc_un.res.bytes;
-	mfcs.mfcs_wrong_if = c->mfc_un.res.wrong_if;
+	mfcs.mfcs_packets = atomic_long_read(&c->mfc_un.res.pkt);
+	mfcs.mfcs_bytes = atomic_long_read(&c->mfc_un.res.bytes);
+	mfcs.mfcs_wrong_if = atomic_long_read(&c->mfc_un.res.wrong_if);
 	if (nla_put_64bit(skb, RTA_MFC_STATS, sizeof(mfcs), &mfcs, RTA_PAD) ||
 	    nla_put_u64_64bit(skb, RTA_EXPIRES, jiffies_to_clock_t(lastuse),
 			      RTA_PAD))
@@ -330,9 +330,6 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 	list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {
 		if (e < s_e)
 			goto next_entry2;
-		if (filter->dev &&
-		    !mr_mfc_uses_dev(mrt, mfc, filter->dev))
-			goto next_entry2;
 
 		err = fill(mrt, skb, NETLINK_CB(cb->skb).portid,
 			   cb->nlh->nlmsg_seq, mfc, RTM_NEWROUTE, flags);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 723ac9181558..2a27913588d0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -870,11 +870,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	}
 	log_martians = IN_DEV_LOG_MARTIANS(in_dev);
 	vif = l3mdev_master_ifindex_rcu(rt->dst.dev);
-	rcu_read_unlock();
 
 	net = dev_net(rt->dst.dev);
-	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif, 1);
+	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
+		rcu_read_unlock();
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST,
 			  rt_nexthop(rt, ip_hdr(skb)->daddr));
 		return;
@@ -893,7 +893,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	 */
 	if (peer->n_redirects >= ip_rt_redirect_number) {
 		peer->rate_last = jiffies;
-		goto out_put_peer;
+		goto out_unlock;
 	}
 
 	/* Check for load limit; set rate_last to the latest sent
@@ -914,8 +914,8 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);
 	}
-out_put_peer:
-	inet_putpeer(peer);
+out_unlock:
+	rcu_read_unlock();
 }
 
 static int ip_error(struct sk_buff *skb)
@@ -975,9 +975,9 @@ static int ip_error(struct sk_buff *skb)
 		break;
 	}
 
+	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
-			       l3mdev_master_ifindex(skb->dev), 1);
-
+			       l3mdev_master_ifindex_rcu(skb->dev));
 	send = true;
 	if (peer) {
 		now = jiffies;
@@ -989,8 +989,9 @@ static int ip_error(struct sk_buff *skb)
 			peer->rate_tokens -= ip_rt_error_cost;
 		else
 			send = false;
-		inet_putpeer(peer);
 	}
+	rcu_read_unlock();
+
 	if (send)
 		icmp_send(skb, ICMP_DEST_UNREACH, code, 0);
 
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..76c23675ae50 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 delay)
 	if (after(tp->snd_una, ca->end_seq))
 		bictcp_hystart_reset(sk);
 
+	/* hystart triggers when cwnd is larger than some threshold */
+	if (tcp_snd_cwnd(tp) < hystart_low_window)
+		return;
+
 	if (hystart_detect & HYSTART_ACK_TRAIN) {
 		u32 now = bictcp_clock_us(sk);
 
@@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
 	if (ca->delay_min == 0 || ca->delay_min > delay)
 		ca->delay_min = delay;
 
-	/* hystart triggers when cwnd is larger than some threshold */
-	if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-	    tcp_snd_cwnd(tp) >= hystart_low_window)
+	if (!ca->found && tcp_in_slow_start(tp) && hystart)
 		hystart_update(sk, delay);
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8efc58716ce9..6d5387811c32 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -265,11 +265,14 @@ static u16 tcp_select_window(struct sock *sk)
 	u32 cur_win, new_win;
 
 	/* Make the window 0 if we failed to queue the data because we
-	 * are out of memory. The window is temporary, so we don't store
-	 * it on the socket.
+	 * are out of memory.
 	 */
-	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
+	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
+		tp->pred_flags = 0;
+		tp->rcv_wnd = 0;
+		tp->rcv_wup = tp->rcv_nxt;
 		return 0;
+	}
 
 	cur_win = tcp_receive_window(tp);
 	new_win = __tcp_select_window(sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ff85242720a0..d2eeb6fc49b3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -420,6 +420,49 @@ u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
+/**
+ * udp4_lib_lookup1() - Simplified lookup using primary hash (destination port)
+ * @net:	Network namespace
+ * @saddr:	Source address, network order
+ * @sport:	Source port, network order
+ * @daddr:	Destination address, network order
+ * @hnum:	Destination port, host order
+ * @dif:	Destination interface index
+ * @sdif:	Destination bridge port index, if relevant
+ * @udptable:	Set of UDP hash tables
+ *
+ * Simplified lookup to be used as fallback if no sockets are found due to a
+ * potential race between (receive) address change, and lookup happening before
+ * the rehash operation. This function ignores SO_REUSEPORT groups while scoring
+ * result sockets, because if we have one, we don't need the fallback at all.
+ *
+ * Called under rcu_read_lock().
+ *
+ * Return: socket with highest matching score if any, NULL if none
+ */
+static struct sock *udp4_lib_lookup1(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     const struct udp_table *udptable)
+{
+	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
+	struct udp_hslot *hslot = &udptable->hash[slot];
+	struct sock *sk, *result = NULL;
+	int score, badness = 0;
+
+	sk_for_each_rcu(sk, &hslot->head) {
+		score = compute_score(sk, net,
+				      saddr, sport, daddr, hnum, dif, sdif);
+		if (score > badness) {
+			result = sk;
+			badness = score;
+		}
+	}
+
+	return result;
+}
+
 /* called with rcu_read_lock() */
 static struct sock *udp4_lib_lookup2(const struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -525,6 +568,19 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  htonl(INADDR_ANY), hnum, dif, sdif,
 				  hslot2, skb);
+	if (!IS_ERR_OR_NULL(result))
+		goto done;
+
+	/* Primary hash (destination port) lookup as fallback for this race:
+	 *   1. __ip4_datagram_connect() sets sk_rcv_saddr
+	 *   2. lookup (this function): new sk_rcv_saddr, hashes not updated yet
+	 *   3. rehash operation updating _secondary and four-tuple_ hashes
+	 * The primary hash doesn't need an update after 1., so, thanks to this
+	 * further step, 1. and 3. don't need to be atomic against the lookup.
+	 */
+	result = udp4_lib_lookup1(net, saddr, sport, daddr, hnum, dif, sdif,
+				  udptable);
+
 done:
 	if (IS_ERR(result))
 		return NULL;
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 919ebfabbe4e..7b41fb4f00b5 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -80,9 +80,9 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		if (sp->len == XFRM_MAX_DEPTH)
 			goto out_reset;
 
-		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
-				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
-				      spi, IPPROTO_ESP, AF_INET6);
+		x = xfrm_input_state_lookup(dev_net(skb->dev), skb->mark,
+					    (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
+					    spi, IPPROTO_ESP, AF_INET6);
 
 		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
 			/* non-offload path will record the error and audit log */
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 071b0bc1179d..a6984a29fdb9 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -222,10 +222,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (rt->rt6i_dst.plen < 128)
 			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
 
-		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr, 1);
+		rcu_read_lock();
+		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
-		if (peer)
-			inet_putpeer(peer);
+		rcu_read_unlock();
 	}
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f26841f1490f..434ddf263b88 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -613,15 +613,15 @@ int ip6_forward(struct sk_buff *skb)
 		else
 			target = &hdr->daddr;
 
-		peer = inet_getpeer_v6(net->ipv6.peers, &hdr->daddr, 1);
+		rcu_read_lock();
+		peer = inet_getpeer_v6(net->ipv6.peers, &hdr->daddr);
 
 		/* Limit redirects both by destination (here)
 		   and by source (inside ndisc_send_redirect)
 		 */
 		if (inet_peer_xrlim_allow(peer, 1*HZ))
 			ndisc_send_redirect(skb, target);
-		if (peer)
-			inet_putpeer(peer);
+		rcu_read_unlock();
 	} else {
 		int addrtype = ipv6_addr_type(&hdr->saddr);
 
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index d5057401701c..440048d609c3 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -506,9 +506,9 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 
 		if (it->cache != &mrt->mfc_unres_queue) {
 			seq_printf(seq, " %8lu %8lu %8lu",
-				   mfc->_c.mfc_un.res.pkt,
-				   mfc->_c.mfc_un.res.bytes,
-				   mfc->_c.mfc_un.res.wrong_if);
+				   atomic_long_read(&mfc->_c.mfc_un.res.pkt),
+				   atomic_long_read(&mfc->_c.mfc_un.res.bytes),
+				   atomic_long_read(&mfc->_c.mfc_un.res.wrong_if));
 			for (n = mfc->_c.mfc_un.res.minvif;
 			     n < mfc->_c.mfc_un.res.maxvif; n++) {
 				if (VIF_EXISTS(mrt, n) &&
@@ -870,7 +870,7 @@ static void ip6mr_update_thresholds(struct mr_table *mrt,
 				cache->mfc_un.res.maxvif = vifi + 1;
 		}
 	}
-	cache->mfc_un.res.lastuse = jiffies;
+	WRITE_ONCE(cache->mfc_un.res.lastuse, jiffies);
 }
 
 static int mif6_add(struct net *net, struct mr_table *mrt,
@@ -1928,9 +1928,9 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
-			sr->pktcnt = c->_c.mfc_un.res.pkt;
-			sr->bytecnt = c->_c.mfc_un.res.bytes;
-			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr->pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 			return 0;
 		}
@@ -2000,9 +2000,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
-			sr.pktcnt = c->_c.mfc_un.res.pkt;
-			sr.bytecnt = c->_c.mfc_un.res.bytes;
-			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr.bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr.wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
@@ -2125,9 +2125,9 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	int true_vifi = ip6mr_find_vif(mrt, dev);
 
 	vif = c->_c.mfc_parent;
-	c->_c.mfc_un.res.pkt++;
-	c->_c.mfc_un.res.bytes += skb->len;
-	c->_c.mfc_un.res.lastuse = jiffies;
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
 
 	if (ipv6_addr_any(&c->mf6c_origin) && true_vifi >= 0) {
 		struct mfc6_cache *cache_proxy;
@@ -2145,7 +2145,7 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
 	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
-		c->_c.mfc_un.res.wrong_if++;
+		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index aba94a348673..d044c67019de 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1731,10 +1731,12 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 			  "Redirect: destination is not a neighbour\n");
 		goto release;
 	}
-	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr, 1);
+
+	rcu_read_lock();
+	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
+
 	if (!ret)
 		goto release;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0cef8ae5d1ea..896c9c827a28 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -159,6 +159,49 @@ static int compute_score(struct sock *sk, const struct net *net,
 	return score;
 }
 
+/**
+ * udp6_lib_lookup1() - Simplified lookup using primary hash (destination port)
+ * @net:	Network namespace
+ * @saddr:	Source address, network order
+ * @sport:	Source port, network order
+ * @daddr:	Destination address, network order
+ * @hnum:	Destination port, host order
+ * @dif:	Destination interface index
+ * @sdif:	Destination bridge port index, if relevant
+ * @udptable:	Set of UDP hash tables
+ *
+ * Simplified lookup to be used as fallback if no sockets are found due to a
+ * potential race between (receive) address change, and lookup happening before
+ * the rehash operation. This function ignores SO_REUSEPORT groups while scoring
+ * result sockets, because if we have one, we don't need the fallback at all.
+ *
+ * Called under rcu_read_lock().
+ *
+ * Return: socket with highest matching score if any, NULL if none
+ */
+static struct sock *udp6_lib_lookup1(const struct net *net,
+				     const struct in6_addr *saddr, __be16 sport,
+				     const struct in6_addr *daddr,
+				     unsigned int hnum, int dif, int sdif,
+				     const struct udp_table *udptable)
+{
+	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
+	struct udp_hslot *hslot = &udptable->hash[slot];
+	struct sock *sk, *result = NULL;
+	int score, badness = 0;
+
+	sk_for_each_rcu(sk, &hslot->head) {
+		score = compute_score(sk, net,
+				      saddr, sport, daddr, hnum, dif, sdif);
+		if (score > badness) {
+			result = sk;
+			badness = score;
+		}
+	}
+
+	return result;
+}
+
 /* called with rcu_read_lock() */
 static struct sock *udp6_lib_lookup2(const struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
@@ -263,6 +306,13 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  &in6addr_any, hnum, dif, sdif,
 				  hslot2, skb);
+	if (!IS_ERR_OR_NULL(result))
+		goto done;
+
+	/* Cover address change/lookup/rehash race: see __udp4_lib_lookup() */
+	result = udp6_lib_lookup1(net, saddr, sport, daddr, hnum, dif, sdif,
+				  udptable);
+
 done:
 	if (IS_ERR(result))
 		return NULL;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index f79fb99271ed..c56bb4f451e6 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1354,7 +1354,7 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
 	}
 
 	if (hdr->sadb_msg_seq) {
-		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
+		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, UINT_MAX);
 		if (x && !xfrm_addr_equal(&x->id.daddr, xdaddr, family)) {
 			xfrm_state_put(x);
 			x = NULL;
@@ -1362,7 +1362,8 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
 	}
 
 	if (!x)
-		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, proto, xdaddr, xsaddr, 1, family);
+		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, UINT_MAX,
+				  proto, xdaddr, xsaddr, 1, family);
 
 	if (x == NULL)
 		return -ENOENT;
@@ -1417,7 +1418,7 @@ static int pfkey_acquire(struct sock *sk, struct sk_buff *skb, const struct sadb
 	if (hdr->sadb_msg_seq == 0 || hdr->sadb_msg_errno == 0)
 		return 0;
 
-	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
+	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, UINT_MAX);
 	if (x == NULL)
 		return 0;
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 68596ef78b15..d0b145888e13 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -728,7 +728,7 @@ static ssize_t ieee80211_if_parse_active_links(struct ieee80211_sub_if_data *sda
 {
 	u16 active_links;
 
-	if (kstrtou16(buf, 0, &active_links))
+	if (kstrtou16(buf, 0, &active_links) || !active_links)
 		return -EINVAL;
 
 	return ieee80211_set_active_links(&sdata->vif, active_links) ?: buflen;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d382d9729e85..a06644084d15 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -724,6 +724,9 @@ static inline void drv_flush_sta(struct ieee80211_local *local,
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
 
+	if (!sta->uploaded)
+		return;
+
 	trace_drv_flush_sta(local, sdata, &sta->sta);
 	if (local->ops->flush_sta)
 		local->ops->flush_sta(&local->hw, &sdata->vif, &sta->sta);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 694b43091fec..6f3a86040cfc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2994,6 +2994,7 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	}
 
 	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
+	ieee80211_set_qos_hdr(sdata, fwd_skb);
 	ieee80211_add_pending_skb(local, fwd_skb);
 
 rx_accept:
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index b0dd008e2114..dd595d9b5e50 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -405,9 +405,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
 			subflow->mpc_drop = 1;
 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
-		} else {
-			subflow->mpc_drop = 0;
 		}
+	} else if (ssk->sk_state == TCP_SYN_SENT) {
+		subflow->mpc_drop = 0;
 	}
 }
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 123f3f297284..fd2de185bc93 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,7 +108,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
-			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
@@ -157,11 +156,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		pr_debug("DSS\n");
 		ptr++;
 
-		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
-		 * map vs DSS map in mptcp_incoming_options(), and reconstruct
-		 * map info accordingly
-		 */
-		mp_opt->mpc_map = 0;
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
 		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
@@ -369,8 +363,11 @@ void mptcp_get_options(const struct sk_buff *skb,
 	const unsigned char *ptr;
 	int length;
 
-	/* initialize option status */
-	mp_opt->suboptions = 0;
+	/* Ensure that casting the whole status to u32 is efficient and safe */
+	BUILD_BUG_ON(sizeof_field(struct mptcp_options_received, status) != sizeof(u32));
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_options_received, status),
+				 sizeof(u32)));
+	*(u32 *)&mp_opt->status = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 45a2b5f05d38..8c4f934d198c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2049,7 +2049,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
+			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b9d850ce85a..fac774825aff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1766,8 +1766,10 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		 * see mptcp_disconnect().
 		 * Attempt it again outside the problematic scope.
 		 */
-		if (!mptcp_disconnect(sk, 0))
+		if (!mptcp_disconnect(sk, 0)) {
+			sk->sk_disconnects++;
 			sk->sk_socket->state = SS_UNCONNECTED;
+		}
 	}
 	inet_clear_bit(DEFER_CONNECT, sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 73526f1d768f..b70a303e0828 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -149,22 +149,24 @@ struct mptcp_options_received {
 	u32	subflow_seq;
 	u16	data_len;
 	__sum16	csum;
-	u16	suboptions;
+	struct_group(status,
+		u16 suboptions;
+		u16 use_map:1,
+		    dsn64:1,
+		    data_fin:1,
+		    use_ack:1,
+		    ack64:1,
+		    mpc_map:1,
+		    reset_reason:4,
+		    reset_transient:1,
+		    echo:1,
+		    backup:1,
+		    deny_join_id0:1,
+		    __unused:2;
+	);
+	u8	join_id;
 	u32	token;
 	u32	nonce;
-	u16	use_map:1,
-		dsn64:1,
-		data_fin:1,
-		use_ack:1,
-		ack64:1,
-		mpc_map:1,
-		reset_reason:4,
-		reset_transient:1,
-		echo:1,
-		backup:1,
-		deny_join_id0:1,
-		__unused:2;
-	u8	join_id;
 	u64	thmac;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_addr_info addr;
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 14bd66909ca4..4a8ce2949fae 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1089,14 +1089,12 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_gmcma_pkt *rsp;
-	struct sockaddr saddr;
-	int ret = -1;
 	int i;
 
 	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
-	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
@@ -1108,20 +1106,20 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 			    rsp->addresses[i][4], rsp->addresses[i][5]);
 	}
 
+	saddr->sa_family = ndev->type;
 	for (i = 0; i < rsp->address_count; i++) {
-		memcpy(saddr.sa_data, &rsp->addresses[i], ETH_ALEN);
-		ret = ndev->netdev_ops->ndo_set_mac_address(ndev, &saddr);
-		if (ret < 0) {
+		if (!is_valid_ether_addr(rsp->addresses[i])) {
 			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
-				    saddr.sa_data);
+				    rsp->addresses[i]);
 			continue;
 		}
-		netdev_warn(ndev, "NCSI: Set MAC address to %pM\n", saddr.sa_data);
+		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
+		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
 		break;
 	}
 
-	ndp->gma_flag = ret == 0;
-	return ret;
+	ndp->gma_flag = 1;
+	return 0;
 }
 
 static struct ncsi_rsp_handler {
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 42dc8cc721ff..939510247ef5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4647,6 +4647,14 @@ static int nf_tables_fill_set_concat(struct sk_buff *skb,
 	return 0;
 }
 
+static u32 nft_set_userspace_size(const struct nft_set_ops *ops, u32 size)
+{
+	if (ops->usize)
+		return ops->usize(size);
+
+	return size;
+}
+
 static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			      const struct nft_set *set, u16 event, u16 flags)
 {
@@ -4717,7 +4725,8 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 	if (!nest)
 		goto nla_put_failure;
 	if (set->size &&
-	    nla_put_be32(skb, NFTA_SET_DESC_SIZE, htonl(set->size)))
+	    nla_put_be32(skb, NFTA_SET_DESC_SIZE,
+			 htonl(nft_set_userspace_size(set->ops, set->size))))
 		goto nla_put_failure;
 
 	if (set->field_count > 1 &&
@@ -4959,7 +4968,7 @@ static int nft_set_desc_concat_parse(const struct nlattr *attr,
 static int nft_set_desc_concat(struct nft_set_desc *desc,
 			       const struct nlattr *nla)
 {
-	u32 num_regs = 0, key_num_regs = 0;
+	u32 len = 0, num_regs;
 	struct nlattr *attr;
 	int rem, err, i;
 
@@ -4973,12 +4982,12 @@ static int nft_set_desc_concat(struct nft_set_desc *desc,
 	}
 
 	for (i = 0; i < desc->field_count; i++)
-		num_regs += DIV_ROUND_UP(desc->field_len[i], sizeof(u32));
+		len += round_up(desc->field_len[i], sizeof(u32));
 
-	key_num_regs = DIV_ROUND_UP(desc->klen, sizeof(u32));
-	if (key_num_regs != num_regs)
+	if (len != desc->klen)
 		return -EINVAL;
 
+	num_regs = DIV_ROUND_UP(desc->klen, sizeof(u32));
 	if (num_regs > NFT_REG32_COUNT)
 		return -E2BIG;
 
@@ -5085,6 +5094,15 @@ static bool nft_set_is_same(const struct nft_set *set,
 	return true;
 }
 
+static u32 nft_set_kernel_size(const struct nft_set_ops *ops,
+			       const struct nft_set_desc *desc)
+{
+	if (ops->ksize)
+		return ops->ksize(desc->size);
+
+	return desc->size;
+}
+
 static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 			    const struct nlattr * const nla[])
 {
@@ -5267,6 +5285,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (err < 0)
 			return err;
 
+		if (desc.size)
+			desc.size = nft_set_kernel_size(set->ops, &desc);
+
 		err = 0;
 		if (!nft_set_is_same(set, &desc, exprs, num_exprs, flags)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_SET_NAME]);
@@ -5289,6 +5310,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
 
+	if (desc.size)
+		desc.size = nft_set_kernel_size(ops, &desc);
+
 	udlen = 0;
 	if (nla[NFTA_SET_USERDATA])
 		udlen = nla_len(nla[NFTA_SET_USERDATA]);
@@ -6855,6 +6879,27 @@ static bool nft_setelem_valid_key_end(const struct nft_set *set,
 	return true;
 }
 
+static u32 nft_set_maxsize(const struct nft_set *set)
+{
+	u32 maxsize, delta;
+
+	if (!set->size)
+		return UINT_MAX;
+
+	if (set->ops->adjust_maxsize)
+		delta = set->ops->adjust_maxsize(set);
+	else
+		delta = 0;
+
+	if (check_add_overflow(set->size, set->ndeact, &maxsize))
+		return UINT_MAX;
+
+	if (check_add_overflow(maxsize, delta, &maxsize))
+		return UINT_MAX;
+
+	return maxsize;
+}
+
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
 {
@@ -7218,7 +7263,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
-		unsigned int max = set->size ? set->size + set->ndeact : UINT_MAX;
+		unsigned int max = nft_set_maxsize(set);
 
 		if (!atomic_add_unless(&set->nelems, 1, max)) {
 			err = -ENFILE;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 2f732fae5a83..da9ebd00b198 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -289,6 +289,15 @@ static bool nft_flow_offload_skip(struct sk_buff *skb, int family)
 	return false;
 }
 
+static void flow_offload_ct_tcp(struct nf_conn *ct)
+{
+	/* conntrack will not see all packets, disable tcp window validation. */
+	spin_lock_bh(&ct->lock);
+	ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
+	ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
+	spin_unlock_bh(&ct->lock);
+}
+
 static void nft_flow_offload_eval(const struct nft_expr *expr,
 				  struct nft_regs *regs,
 				  const struct nft_pktinfo *pkt)
@@ -356,11 +365,8 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		goto err_flow_alloc;
 
 	flow_offload_route_init(flow, &route);
-
-	if (tcph) {
-		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
-		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
-	}
+	if (tcph)
+		flow_offload_ct_tcp(ct);
 
 	__set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
 	ret = flow_offload_add(flowtable, flow);
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index b7ea21327549..2e8ef16ff191 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -750,6 +750,46 @@ static void nft_rbtree_gc_init(const struct nft_set *set)
 	priv->last_gc = jiffies;
 }
 
+/* rbtree stores ranges as singleton elements, each range is composed of two
+ * elements ...
+ */
+static u32 nft_rbtree_ksize(u32 size)
+{
+	return size * 2;
+}
+
+/* ... hide this detail to userspace. */
+static u32 nft_rbtree_usize(u32 size)
+{
+	if (!size)
+		return 0;
+
+	return size / 2;
+}
+
+static u32 nft_rbtree_adjust_maxsize(const struct nft_set *set)
+{
+	struct nft_rbtree *priv = nft_set_priv(set);
+	struct nft_rbtree_elem *rbe;
+	struct rb_node *node;
+	const void *key;
+
+	node = rb_last(&priv->root);
+	if (!node)
+		return 0;
+
+	rbe = rb_entry(node, struct nft_rbtree_elem, node);
+	if (!nft_rbtree_interval_end(rbe))
+		return 0;
+
+	key = nft_set_ext_key(&rbe->ext);
+	if (memchr(key, 1, set->klen))
+		return 0;
+
+	/* this is the all-zero no-match element. */
+	return 1;
+}
+
 const struct nft_set_type nft_set_rbtree_type = {
 	.features	= NFT_SET_INTERVAL | NFT_SET_MAP | NFT_SET_OBJECT | NFT_SET_TIMEOUT,
 	.ops		= {
@@ -768,5 +808,8 @@ const struct nft_set_type nft_set_rbtree_type = {
 		.lookup		= nft_rbtree_lookup,
 		.walk		= nft_rbtree_walk,
 		.get		= nft_rbtree_get,
+		.ksize		= nft_rbtree_ksize,
+		.usize		= nft_rbtree_usize,
+		.adjust_maxsize = nft_rbtree_adjust_maxsize,
 	},
 };
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 59050caab65c..72c65d938a15 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -397,15 +397,15 @@ static int rose_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
-	int opt;
+	unsigned int opt;
 
 	if (level != SOL_ROSE)
 		return -ENOPROTOOPT;
 
-	if (optlen < sizeof(int))
+	if (optlen < sizeof(unsigned int))
 		return -EINVAL;
 
-	if (copy_from_sockptr(&opt, optval, sizeof(int)))
+	if (copy_from_sockptr(&opt, optval, sizeof(unsigned int)))
 		return -EFAULT;
 
 	switch (optname) {
@@ -414,31 +414,31 @@ static int rose_setsockopt(struct socket *sock, int level, int optname,
 		return 0;
 
 	case ROSE_T1:
-		if (opt < 1)
+		if (opt < 1 || opt > UINT_MAX / HZ)
 			return -EINVAL;
 		rose->t1 = opt * HZ;
 		return 0;
 
 	case ROSE_T2:
-		if (opt < 1)
+		if (opt < 1 || opt > UINT_MAX / HZ)
 			return -EINVAL;
 		rose->t2 = opt * HZ;
 		return 0;
 
 	case ROSE_T3:
-		if (opt < 1)
+		if (opt < 1 || opt > UINT_MAX / HZ)
 			return -EINVAL;
 		rose->t3 = opt * HZ;
 		return 0;
 
 	case ROSE_HOLDBACK:
-		if (opt < 1)
+		if (opt < 1 || opt > UINT_MAX / HZ)
 			return -EINVAL;
 		rose->hb = opt * HZ;
 		return 0;
 
 	case ROSE_IDLE:
-		if (opt < 0)
+		if (opt > UINT_MAX / (60 * HZ))
 			return -EINVAL;
 		rose->idle = opt * 60 * HZ;
 		return 0;
diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index f06ddbed3fed..1525773e94aa 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -122,6 +122,10 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 	struct rose_sock *rose = rose_sk(sk);
 
 	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + HZ/20);
+		goto out;
+	}
 	switch (rose->state) {
 	case ROSE_STATE_0:
 		/* Magic here: If we listen() and a new link dies before it
@@ -152,6 +156,7 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 	}
 
 	rose_start_heartbeat(sk);
+out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
@@ -162,6 +167,10 @@ static void rose_timer_expiry(struct timer_list *t)
 	struct sock *sk = &rose->sock;
 
 	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		sk_reset_timer(sk, &rose->timer, jiffies + HZ/20);
+		goto out;
+	}
 	switch (rose->state) {
 	case ROSE_STATE_1:	/* T1 */
 	case ROSE_STATE_4:	/* T2 */
@@ -182,6 +191,7 @@ static void rose_timer_expiry(struct timer_list *t)
 		}
 		break;
 	}
+out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
@@ -192,6 +202,10 @@ static void rose_idletimer_expiry(struct timer_list *t)
 	struct sock *sk = &rose->sock;
 
 	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		sk_reset_timer(sk, &rose->idletimer, jiffies + HZ/20);
+		goto out;
+	}
 	rose_clear_queues(sk);
 
 	rose_write_internal(sk, ROSE_CLEAR_REQUEST);
@@ -207,6 +221,7 @@ static void rose_idletimer_expiry(struct timer_list *t)
 		sk->sk_state_change(sk);
 		sock_set_flag(sk, SOCK_DEAD);
 	}
+out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 598b4ee389fc..2a1396cd892f 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -63,11 +63,12 @@ int rxrpc_abort_conn(struct rxrpc_connection *conn, struct sk_buff *skb,
 /*
  * Mark a connection as being remotely aborted.
  */
-static bool rxrpc_input_conn_abort(struct rxrpc_connection *conn,
+static void rxrpc_input_conn_abort(struct rxrpc_connection *conn,
 				   struct sk_buff *skb)
 {
-	return rxrpc_set_conn_aborted(conn, skb, skb->priority, -ECONNABORTED,
-				      RXRPC_CALL_REMOTELY_ABORTED);
+	trace_rxrpc_rx_conn_abort(conn, skb);
+	rxrpc_set_conn_aborted(conn, skb, skb->priority, -ECONNABORTED,
+			       RXRPC_CALL_REMOTELY_ABORTED);
 }
 
 /*
@@ -202,11 +203,14 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn)
 
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
 		call = conn->channels[i].call;
-		if (call)
+		if (call) {
+			rxrpc_see_call(call, rxrpc_call_see_conn_abort);
 			rxrpc_set_call_completion(call,
 						  conn->completion,
 						  conn->abort_code,
 						  conn->error);
+			rxrpc_poke_call(call, rxrpc_call_poke_conn_abort);
+		}
 	}
 
 	_leave("");
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 552ba84a255c..5d0842efde69 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -238,7 +238,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 	bool use;
 	int slot;
 
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 
 	while (!list_empty(collector)) {
 		peer = list_entry(collector->next,
@@ -249,7 +249,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 			continue;
 
 		use = __rxrpc_use_local(peer->local, rxrpc_local_use_peer_keepalive);
-		spin_unlock(&rxnet->peer_hash_lock);
+		spin_unlock_bh(&rxnet->peer_hash_lock);
 
 		if (use) {
 			keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
@@ -269,17 +269,17 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 			 */
 			slot += cursor;
 			slot &= mask;
-			spin_lock(&rxnet->peer_hash_lock);
+			spin_lock_bh(&rxnet->peer_hash_lock);
 			list_add_tail(&peer->keepalive_link,
 				      &rxnet->peer_keepalive[slot & mask]);
-			spin_unlock(&rxnet->peer_hash_lock);
+			spin_unlock_bh(&rxnet->peer_hash_lock);
 			rxrpc_unuse_local(peer->local, rxrpc_local_unuse_peer_keepalive);
 		}
 		rxrpc_put_peer(peer, rxrpc_peer_put_keepalive);
-		spin_lock(&rxnet->peer_hash_lock);
+		spin_lock_bh(&rxnet->peer_hash_lock);
 	}
 
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 
 /*
@@ -309,7 +309,7 @@ void rxrpc_peer_keepalive_worker(struct work_struct *work)
 	 * second; the bucket at cursor + 1 goes at now + 1s and so
 	 * on...
 	 */
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	list_splice_init(&rxnet->peer_keepalive_new, &collector);
 
 	stop = cursor + ARRAY_SIZE(rxnet->peer_keepalive);
@@ -321,7 +321,7 @@ void rxrpc_peer_keepalive_worker(struct work_struct *work)
 	}
 
 	base = now;
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 
 	rxnet->peer_keepalive_base = base;
 	rxnet->peer_keepalive_cursor = cursor;
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 49dcda67a0d5..956fc7ea4b73 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -313,10 +313,10 @@ void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 	hash_key = rxrpc_peer_hash_key(local, &peer->srx);
 	rxrpc_init_peer(local, peer, hash_key);
 
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
 	list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 
 /*
@@ -348,7 +348,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 			return NULL;
 		}
 
-		spin_lock(&rxnet->peer_hash_lock);
+		spin_lock_bh(&rxnet->peer_hash_lock);
 
 		/* Need to check that we aren't racing with someone else */
 		peer = __rxrpc_lookup_peer_rcu(local, srx, hash_key);
@@ -361,7 +361,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 				      &rxnet->peer_keepalive_new);
 		}
 
-		spin_unlock(&rxnet->peer_hash_lock);
+		spin_unlock_bh(&rxnet->peer_hash_lock);
 
 		if (peer)
 			rxrpc_free_peer(candidate);
@@ -411,10 +411,10 @@ static void __rxrpc_put_peer(struct rxrpc_peer *peer)
 
 	ASSERT(hlist_empty(&peer->error_targets));
 
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_del_rcu(&peer->hash_link);
 	list_del_init(&peer->keepalive_link);
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 
 	rxrpc_free_peer(peer);
 }
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index bbc778c233c8..dfa306708494 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -390,6 +390,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 	tp->protocol = protocol;
 	tp->prio = prio;
 	tp->chain = chain;
+	tp->usesw = !tp->ops->reoffload;
 	spin_lock_init(&tp->lock);
 	refcount_set(&tp->refcnt, 1);
 
@@ -410,39 +411,31 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
-static void tcf_maintain_bypass(struct tcf_block *block)
+static void tcf_proto_count_usesw(struct tcf_proto *tp, bool add)
 {
-	int filtercnt = atomic_read(&block->filtercnt);
-	int skipswcnt = atomic_read(&block->skipswcnt);
-	bool bypass_wanted = filtercnt > 0 && filtercnt == skipswcnt;
-
-	if (bypass_wanted != block->bypass_wanted) {
 #ifdef CONFIG_NET_CLS_ACT
-		if (bypass_wanted)
-			static_branch_inc(&tcf_bypass_check_needed_key);
-		else
-			static_branch_dec(&tcf_bypass_check_needed_key);
-#endif
-		block->bypass_wanted = bypass_wanted;
+	struct tcf_block *block = tp->chain->block;
+	bool counted = false;
+
+	if (!add) {
+		if (tp->usesw && tp->counted) {
+			if (!atomic_dec_return(&block->useswcnt))
+				static_branch_dec(&tcf_sw_enabled_key);
+			tp->counted = false;
+		}
+		return;
 	}
-}
-
-static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
-{
-	lockdep_assert_not_held(&block->cb_lock);
 
-	down_write(&block->cb_lock);
-	if (*counted != add) {
-		if (add) {
-			atomic_inc(&block->filtercnt);
-			*counted = true;
-		} else {
-			atomic_dec(&block->filtercnt);
-			*counted = false;
-		}
+	spin_lock(&tp->lock);
+	if (tp->usesw && !tp->counted) {
+		counted = true;
+		tp->counted = true;
 	}
-	tcf_maintain_bypass(block);
-	up_write(&block->cb_lock);
+	spin_unlock(&tp->lock);
+
+	if (counted && atomic_inc_return(&block->useswcnt) == 1)
+		static_branch_inc(&tcf_sw_enabled_key);
+#endif
 }
 
 static void tcf_chain_put(struct tcf_chain *chain);
@@ -451,7 +444,7 @@ static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
-	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
+	tcf_proto_count_usesw(tp, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2404,7 +2397,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-		tcf_block_filter_cnt_update(block, &tp->counted, true);
+		tcf_proto_count_usesw(tp, true);
 		/* q pointer is NULL for shared blocks */
 		if (q)
 			q->flags &= ~TCQ_F_CAN_BYPASS;
@@ -3521,8 +3514,6 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
 		return;
 	*flags |= TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_inc(&block->skipswcnt);
 	atomic_inc(&block->offloadcnt);
 }
 
@@ -3531,8 +3522,6 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
 	if (!(*flags & TCA_CLS_FLAGS_IN_HW))
 		return;
 	*flags &= ~TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_dec(&block->skipswcnt);
 	atomic_dec(&block->offloadcnt);
 }
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 1941ebec23ff..7fbe42f0e5c2 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -509,6 +509,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(prog->gen_flags))
 		prog->gen_flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, prog->gen_flags);
+
 	if (oldprog) {
 		idr_replace(&head->handle_idr, prog, handle);
 		list_replace_rcu(&oldprog->link, &prog->link);
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1008ec8a464c..03505673d523 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2503,6 +2503,8 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(fnew->flags))
 		fnew->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, fnew->flags);
+
 	spin_lock(&tp->lock);
 
 	/* tp was deleted concurrently. -EAGAIN will cause caller to lookup
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 9f1e62ca508d..f03bf5da39ee 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -228,6 +228,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(new->flags))
 		new->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, new->flags);
+
 	*arg = head;
 	rcu_assign_pointer(tp->root, new);
 	return 0;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d3a03c57545b..2a1c00048fd6 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -951,6 +951,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(new->flags))
 			new->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, new->flags);
+
 		u32_replace_knode(tp, tp_c, new);
 		tcf_unbind_filter(tp, &n->res);
 		tcf_exts_get_net(&n->exts);
@@ -1164,6 +1166,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, n->flags);
+
 		ins = &ht->ht[TC_U32_HASH(handle)];
 		for (pins = rtnl_dereference(*ins); pins;
 		     ins = &pins->next, pins = rtnl_dereference(*ins))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index a1d27bc039a3..d26ac6bd9b10 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1664,6 +1664,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				q = qdisc_lookup(dev, tcm->tcm_handle);
 				if (!q)
 					goto create_n_graft;
+				if (q->parent != tcm->tcm_parent) {
+					NL_SET_ERR_MSG(extack, "Cannot move an existing qdisc to a different parent");
+					return -EINVAL;
+				}
 				if (n->nlmsg_flags & NLM_F_EXCL) {
 					NL_SET_ERR_MSG(extack, "Exclusivity flag on, cannot override");
 					return -EEXIST;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 38ec18f73de4..8874ae668095 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -911,8 +911,8 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
-	return skb_array_resize_multiple(bands, PFIFO_FAST_BANDS, new_len,
-					 GFP_KERNEL);
+	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
+					    GFP_KERNEL);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 3b9245a3c767..65d5b59da583 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -77,12 +77,6 @@
 #define SFQ_EMPTY_SLOT		0xffff
 #define SFQ_DEFAULT_HASH_DIVISOR 1024
 
-/* We use 16 bits to store allot, and want to handle packets up to 64K
- * Scale allot by 8 (1<<3) so that no overflow occurs.
- */
-#define SFQ_ALLOT_SHIFT		3
-#define SFQ_ALLOT_SIZE(X)	DIV_ROUND_UP(X, 1 << SFQ_ALLOT_SHIFT)
-
 /* This type should contain at least SFQ_MAX_DEPTH + 1 + SFQ_MAX_FLOWS values */
 typedef u16 sfq_index;
 
@@ -104,7 +98,7 @@ struct sfq_slot {
 	sfq_index	next; /* next slot in sfq RR chain */
 	struct sfq_head dep; /* anchor in dep[] chains */
 	unsigned short	hash; /* hash value (index in ht[]) */
-	short		allot; /* credit for this slot */
+	int		allot; /* credit for this slot */
 
 	unsigned int    backlog;
 	struct red_vars vars;
@@ -120,7 +114,6 @@ struct sfq_sched_data {
 	siphash_key_t 	perturbation;
 	u8		cur_depth;	/* depth of longest slot */
 	u8		flags;
-	unsigned short  scaled_quantum; /* SFQ_ALLOT_SIZE(quantum) */
 	struct tcf_proto __rcu *filter_list;
 	struct tcf_block *block;
 	sfq_index	*ht;		/* Hash table ('divisor' slots) */
@@ -456,7 +449,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->scaled_quantum;
+		slot->allot = q->quantum;
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -493,7 +486,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->scaled_quantum;
+		slot->allot += q->quantum;
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -512,7 +505,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -= qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -595,7 +588,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->scaled_quantum;
+			slot->allot = q->quantum;
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -628,7 +621,8 @@ static void sfq_perturbation(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -646,14 +640,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
 
-	/* slot->allot is a short, make sure quantum is not too big. */
-	if (ctl->quantum) {
-		unsigned int scaled = SFQ_ALLOT_SIZE(ctl->quantum);
-
-		if (scaled <= 0 || scaled > SHRT_MAX)
-			return -EINVAL;
+	if ((int)ctl->quantum < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
+		return -EINVAL;
 	}
-
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -662,11 +652,13 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		if (!p)
 			return -ENOMEM;
 	}
+	if (ctl->limit == 1) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 	sch_tree_lock(sch);
-	if (ctl->quantum) {
+	if (ctl->quantum)
 		q->quantum = ctl->quantum;
-		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
-	}
 	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
@@ -762,12 +754,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
 	q->quantum = psched_mtu(qdisc_dev(sch));
-	q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
 	if (opt) {
-		int err = sfq_change(sch, opt);
+		int err = sfq_change(sch, opt, extack);
 		if (err)
 			return err;
 	}
@@ -878,7 +869,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6cc7b846cff1..ebc41a7b13db 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2738,7 +2738,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
 			release_sock(clcsk);
 		} else if (!atomic_read(&smc_sk(nsk)->conn.bytes_to_rcv)) {
 			lock_sock(nsk);
-			smc_rx_wait(smc_sk(nsk), &timeo, smc_rx_data_available);
+			smc_rx_wait(smc_sk(nsk), &timeo, 0, smc_rx_data_available);
 			release_sock(nsk);
 		}
 	}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index f0cbe77a80b4..79047721df51 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -238,22 +238,23 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	return -ENOMEM;
 }
 
-static int smc_rx_data_available_and_no_splice_pend(struct smc_connection *conn)
+static int smc_rx_data_available_and_no_splice_pend(struct smc_connection *conn, size_t peeked)
 {
-	return atomic_read(&conn->bytes_to_rcv) &&
+	return smc_rx_data_available(conn, peeked) &&
 	       !atomic_read(&conn->splice_pending);
 }
 
 /* blocks rcvbuf consumer until >=len bytes available or timeout or interrupted
  *   @smc    smc socket
  *   @timeo  pointer to max seconds to wait, pointer to value 0 for no timeout
+ *   @peeked  number of bytes already peeked
  *   @fcrit  add'l criterion to evaluate as function pointer
  * Returns:
  * 1 if at least 1 byte available in rcvbuf or if socket error/shutdown.
  * 0 otherwise (nothing in rcvbuf nor timeout, e.g. interrupted).
  */
-int smc_rx_wait(struct smc_sock *smc, long *timeo,
-		int (*fcrit)(struct smc_connection *conn))
+int smc_rx_wait(struct smc_sock *smc, long *timeo, size_t peeked,
+		int (*fcrit)(struct smc_connection *conn, size_t baseline))
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct smc_connection *conn = &smc->conn;
@@ -262,7 +263,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	struct sock *sk = &smc->sk;
 	int rc;
 
-	if (fcrit(conn))
+	if (fcrit(conn, peeked))
 		return 1;
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	add_wait_queue(sk_sleep(sk), &wait);
@@ -271,7 +272,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 			   cflags->peer_conn_abort ||
 			   READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN ||
 			   conn->killed ||
-			   fcrit(conn),
+			   fcrit(conn, peeked),
 			   &wait);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -322,11 +323,11 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 	return -EAGAIN;
 }
 
-static bool smc_rx_recvmsg_data_available(struct smc_sock *smc)
+static bool smc_rx_recvmsg_data_available(struct smc_sock *smc, size_t peeked)
 {
 	struct smc_connection *conn = &smc->conn;
 
-	if (smc_rx_data_available(conn))
+	if (smc_rx_data_available(conn, peeked))
 		return true;
 	else if (conn->urg_state == SMC_URG_VALID)
 		/* we received a single urgent Byte - skip */
@@ -344,10 +345,10 @@ static bool smc_rx_recvmsg_data_available(struct smc_sock *smc)
 int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		   struct pipe_inode_info *pipe, size_t len, int flags)
 {
-	size_t copylen, read_done = 0, read_remaining = len;
+	size_t copylen, read_done = 0, read_remaining = len, peeked_bytes = 0;
 	size_t chunk_len, chunk_off, chunk_len_sum;
 	struct smc_connection *conn = &smc->conn;
-	int (*func)(struct smc_connection *conn);
+	int (*func)(struct smc_connection *conn, size_t baseline);
 	union smc_host_cursor cons;
 	int readable, chunk;
 	char *rcvbuf_base;
@@ -384,14 +385,14 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		if (conn->killed)
 			break;
 
-		if (smc_rx_recvmsg_data_available(smc))
+		if (smc_rx_recvmsg_data_available(smc, peeked_bytes))
 			goto copy;
 
 		if (sk->sk_shutdown & RCV_SHUTDOWN) {
 			/* smc_cdc_msg_recv_action() could have run after
 			 * above smc_rx_recvmsg_data_available()
 			 */
-			if (smc_rx_recvmsg_data_available(smc))
+			if (smc_rx_recvmsg_data_available(smc, peeked_bytes))
 				goto copy;
 			break;
 		}
@@ -425,26 +426,28 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			}
 		}
 
-		if (!smc_rx_data_available(conn)) {
-			smc_rx_wait(smc, &timeo, smc_rx_data_available);
+		if (!smc_rx_data_available(conn, peeked_bytes)) {
+			smc_rx_wait(smc, &timeo, peeked_bytes, smc_rx_data_available);
 			continue;
 		}
 
 copy:
 		/* initialize variables for 1st iteration of subsequent loop */
 		/* could be just 1 byte, even after waiting on data above */
-		readable = atomic_read(&conn->bytes_to_rcv);
+		readable = smc_rx_data_available(conn, peeked_bytes);
 		splbytes = atomic_read(&conn->splice_pending);
 		if (!readable || (msg && splbytes)) {
 			if (splbytes)
 				func = smc_rx_data_available_and_no_splice_pend;
 			else
 				func = smc_rx_data_available;
-			smc_rx_wait(smc, &timeo, func);
+			smc_rx_wait(smc, &timeo, peeked_bytes, func);
 			continue;
 		}
 
 		smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
+		if ((flags & MSG_PEEK) && peeked_bytes)
+			smc_curs_add(conn->rmb_desc->len, &cons, peeked_bytes);
 		/* subsequent splice() calls pick up where previous left */
 		if (splbytes)
 			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
@@ -480,6 +483,8 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			}
 			read_remaining -= chunk_len;
 			read_done += chunk_len;
+			if (flags & MSG_PEEK)
+				peeked_bytes += chunk_len;
 
 			if (chunk_len_sum == copylen)
 				break; /* either on 1st or 2nd iteration */
diff --git a/net/smc/smc_rx.h b/net/smc/smc_rx.h
index db823c97d824..994f5e42d1ba 100644
--- a/net/smc/smc_rx.h
+++ b/net/smc/smc_rx.h
@@ -21,11 +21,11 @@ void smc_rx_init(struct smc_sock *smc);
 
 int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		   struct pipe_inode_info *pipe, size_t len, int flags);
-int smc_rx_wait(struct smc_sock *smc, long *timeo,
-		int (*fcrit)(struct smc_connection *conn));
-static inline int smc_rx_data_available(struct smc_connection *conn)
+int smc_rx_wait(struct smc_sock *smc, long *timeo, size_t peeked,
+		int (*fcrit)(struct smc_connection *conn, size_t baseline));
+static inline int smc_rx_data_available(struct smc_connection *conn, size_t peeked)
 {
-	return atomic_read(&conn->bytes_to_rcv);
+	return atomic_read(&conn->bytes_to_rcv) - peeked;
 }
 
 #endif /* SMC_RX_H */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 59e2c46240f5..3bfbb789c4be 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1083,9 +1083,6 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
 	/* If we have more data, signal svc_xprt_enqueue() to try again */
 	svsk->sk_tcplen = 0;
 	svsk->sk_marker = xdr_zero;
-
-	smp_wmb();
-	tcp_set_rcvlowat(svsk->sk_sk, 1);
 }
 
 /**
@@ -1175,17 +1172,10 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		goto err_delete;
 	if (len == want)
 		svc_tcp_fragment_received(svsk);
-	else {
-		/* Avoid more ->sk_data_ready() calls until the rest
-		 * of the message has arrived. This reduces service
-		 * thread wake-ups on large incoming messages. */
-		tcp_set_rcvlowat(svsk->sk_sk,
-				 svc_sock_reclen(svsk) - svsk->sk_tcplen);
-
+	else
 		trace_svcsock_tcp_recv_short(&svsk->sk_xprt,
 				svc_sock_reclen(svsk),
 				svsk->sk_tcplen - sizeof(rpc_fraghdr));
-	}
 	goto err_noclose;
 error:
 	if (len != -EAGAIN)
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 15724f171b0f..f5d116a1bdea 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1519,6 +1519,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		if (err < 0)
 			goto out;
 
+		/* sk_err might have been set as a result of an earlier
+		 * (failed) connect attempt.
+		 */
+		sk->sk_err = 0;
+
 		/* Mark sock as connecting and set the error code to in
 		 * progress in case this is a non-blocking connect.
 		 */
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d0aed41ded2f..18e132cdea72 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -763,12 +763,11 @@ static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
 		}
 	}
 
+	request->n_channels++;
 	request->channels[n_channels] = chan;
 	if (add_to_6ghz)
 		request->scan_6ghz_params[request->n_6ghz_params].channel_idx =
 			n_channels;
-
-	request->n_channels++;
 }
 
 static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,
@@ -858,9 +857,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 			if (ret)
 				continue;
 
-			entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
-					GFP_ATOMIC);
-
+			entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 			if (!entry)
 				continue;
 
diff --git a/net/wireless/tests/scan.c b/net/wireless/tests/scan.c
index 9f458be71659..79a99cf5e892 100644
--- a/net/wireless/tests/scan.c
+++ b/net/wireless/tests/scan.c
@@ -810,6 +810,8 @@ static void test_cfg80211_parse_colocated_ap(struct kunit *test)
 		skb_put_data(input, "123", 3);
 
 	ies = kunit_kzalloc(test, struct_size(ies, data, input->len), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ies);
+
 	ies->len = input->len;
 	memcpy(ies->data, input->data, input->len);
 
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 91357ccaf4af..5b9ee63e30b6 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -132,6 +132,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
 	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
 	[XFRMA_NAT_KEEPALIVE_INTERVAL]	= { .type = NLA_U32 },
+	[XFRMA_SA_PCPU]		= { .type = NLA_U32 },
 };
 
 static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
@@ -282,9 +283,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_MTIMER_THRESH:
 	case XFRMA_SA_DIR:
 	case XFRMA_NAT_KEEPALIVE_INTERVAL:
+	case XFRMA_SA_PCPU:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_PCPU);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -439,7 +441,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;
 
 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_PCPU);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 749e7eea99e4..841a60a6fbfe 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -572,7 +572,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		x = xfrm_state_lookup(net, mark, daddr, spi, nexthdr, family);
+		x = xfrm_input_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a2ea9dbac90b..8a1b83191a6c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -434,6 +434,7 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
 	if (policy) {
 		write_pnet(&policy->xp_net, net);
 		INIT_LIST_HEAD(&policy->walk.all);
+		INIT_HLIST_HEAD(&policy->state_cache_list);
 		INIT_HLIST_NODE(&policy->bydst);
 		INIT_HLIST_NODE(&policy->byidx);
 		rwlock_init(&policy->lock);
@@ -475,6 +476,9 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	struct net *net = xp_net(policy);
+	struct xfrm_state *x;
+
 	xfrm_dev_policy_delete(policy);
 
 	write_lock_bh(&policy->lock);
@@ -490,6 +494,13 @@ static void xfrm_policy_kill(struct xfrm_policy *policy)
 	if (del_timer(&policy->timer))
 		xfrm_pol_put(policy);
 
+	/* XXX: Flush state cache */
+	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	hlist_for_each_entry_rcu(x, &policy->state_cache_list, state_cache) {
+		hlist_del_init_rcu(&x->state_cache);
+	}
+	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+
 	xfrm_pol_put(policy);
 }
 
@@ -3275,6 +3286,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 		dst_release(dst);
 		dst = dst_orig;
 	}
+
 ok:
 	xfrm_pols_put(pols, drop_pols);
 	if (dst && dst->xfrm &&
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index bc56c6305725..235bbefc2aba 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -714,10 +714,12 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
 			oseq += skb_shinfo(skb)->gso_segs;
 		}
 
-		if (unlikely(xo->seq.low < replay_esn->oseq)) {
-			XFRM_SKB_CB(skb)->seq.output.hi = ++oseq_hi;
-			xo->seq.hi = oseq_hi;
-			replay_esn->oseq_hi = oseq_hi;
+		if (unlikely(oseq < replay_esn->oseq)) {
+			replay_esn->oseq_hi = ++oseq_hi;
+			if (xo->seq.low < replay_esn->oseq) {
+				XFRM_SKB_CB(skb)->seq.output.hi = oseq_hi;
+				xo->seq.hi = oseq_hi;
+			}
 			if (replay_esn->oseq_hi == 0) {
 				replay_esn->oseq--;
 				replay_esn->oseq_hi--;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 37478d36a8df..711e816fc404 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -34,6 +34,8 @@
 
 #define xfrm_state_deref_prot(table, net) \
 	rcu_dereference_protected((table), lockdep_is_held(&(net)->xfrm.xfrm_state_lock))
+#define xfrm_state_deref_check(table, net) \
+	rcu_dereference_check((table), lockdep_is_held(&(net)->xfrm.xfrm_state_lock))
 
 static void xfrm_state_gc_task(struct work_struct *work);
 
@@ -62,6 +64,8 @@ static inline unsigned int xfrm_dst_hash(struct net *net,
 					 u32 reqid,
 					 unsigned short family)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_dst_hash(daddr, saddr, reqid, family, net->xfrm.state_hmask);
 }
 
@@ -70,6 +74,8 @@ static inline unsigned int xfrm_src_hash(struct net *net,
 					 const xfrm_address_t *saddr,
 					 unsigned short family)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_src_hash(daddr, saddr, family, net->xfrm.state_hmask);
 }
 
@@ -77,11 +83,15 @@ static inline unsigned int
 xfrm_spi_hash(struct net *net, const xfrm_address_t *daddr,
 	      __be32 spi, u8 proto, unsigned short family)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_spi_hash(daddr, spi, proto, family, net->xfrm.state_hmask);
 }
 
 static unsigned int xfrm_seq_hash(struct net *net, u32 seq)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_seq_hash(seq, net->xfrm.state_hmask);
 }
 
@@ -665,6 +675,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		refcount_set(&x->refcnt, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
+		INIT_HLIST_NODE(&x->state_cache);
 		INIT_HLIST_NODE(&x->bydst);
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
@@ -679,6 +690,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		x->lft.hard_packet_limit = XFRM_INF;
 		x->replay_maxage = 0;
 		x->replay_maxdiff = 0;
+		x->pcpu_num = UINT_MAX;
 		spin_lock_init(&x->lock);
 	}
 	return x;
@@ -743,12 +755,18 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 	if (x->km.state != XFRM_STATE_DEAD) {
 		x->km.state = XFRM_STATE_DEAD;
+
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
 		if (x->km.seq)
 			hlist_del_rcu(&x->byseq);
+		if (!hlist_unhashed(&x->state_cache))
+			hlist_del_rcu(&x->state_cache);
+		if (!hlist_unhashed(&x->state_cache_input))
+			hlist_del_rcu(&x->state_cache_input);
+
 		if (x->id.spi)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
@@ -1033,16 +1051,38 @@ xfrm_init_tempstate(struct xfrm_state *x, const struct flowi *fl,
 	x->props.family = tmpl->encap_family;
 }
 
-static struct xfrm_state *__xfrm_state_lookup_all(struct net *net, u32 mark,
+struct xfrm_hash_state_ptrs {
+	const struct hlist_head *bydst;
+	const struct hlist_head *bysrc;
+	const struct hlist_head *byspi;
+	unsigned int hmask;
+};
+
+static void xfrm_hash_ptrs_get(const struct net *net, struct xfrm_hash_state_ptrs *ptrs)
+{
+	unsigned int sequence;
+
+	do {
+		sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
+
+		ptrs->bydst = xfrm_state_deref_check(net->xfrm.state_bydst, net);
+		ptrs->bysrc = xfrm_state_deref_check(net->xfrm.state_bysrc, net);
+		ptrs->byspi = xfrm_state_deref_check(net->xfrm.state_byspi, net);
+		ptrs->hmask = net->xfrm.state_hmask;
+	} while (read_seqcount_retry(&net->xfrm.xfrm_state_hash_generation, sequence));
+}
+
+static struct xfrm_state *__xfrm_state_lookup_all(const struct xfrm_hash_state_ptrs *state_ptrs,
+						  u32 mark,
 						  const xfrm_address_t *daddr,
 						  __be32 spi, u8 proto,
 						  unsigned short family,
 						  struct xfrm_dev_offload *xdo)
 {
-	unsigned int h = xfrm_spi_hash(net, daddr, spi, proto, family);
+	unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_byspi + h, byspi) {
+	hlist_for_each_entry_rcu(x, state_ptrs->byspi + h, byspi) {
 #ifdef CONFIG_XFRM_OFFLOAD
 		if (xdo->type == XFRM_DEV_OFFLOAD_PACKET) {
 			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
@@ -1076,15 +1116,16 @@ static struct xfrm_state *__xfrm_state_lookup_all(struct net *net, u32 mark,
 	return NULL;
 }
 
-static struct xfrm_state *__xfrm_state_lookup(struct net *net, u32 mark,
+static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
+					      u32 mark,
 					      const xfrm_address_t *daddr,
 					      __be32 spi, u8 proto,
 					      unsigned short family)
 {
-	unsigned int h = xfrm_spi_hash(net, daddr, spi, proto, family);
+	unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_byspi + h, byspi) {
+	hlist_for_each_entry_rcu(x, state_ptrs->byspi + h, byspi) {
 		if (x->props.family != family ||
 		    x->id.spi       != spi ||
 		    x->id.proto     != proto ||
@@ -1101,15 +1142,63 @@ static struct xfrm_state *__xfrm_state_lookup(struct net *net, u32 mark,
 	return NULL;
 }
 
-static struct xfrm_state *__xfrm_state_lookup_byaddr(struct net *net, u32 mark,
+struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
+					   const xfrm_address_t *daddr,
+					   __be32 spi, u8 proto,
+					   unsigned short family)
+{
+	struct xfrm_hash_state_ptrs state_ptrs;
+	struct hlist_head *state_cache_input;
+	struct xfrm_state *x = NULL;
+
+	state_cache_input = raw_cpu_ptr(net->xfrm.state_cache_input);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
+		if (x->props.family != family ||
+		    x->id.spi       != spi ||
+		    x->id.proto     != proto ||
+		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
+			continue;
+
+		if ((mark & x->mark.m) != x->mark.v)
+			continue;
+		if (!xfrm_state_hold_rcu(x))
+			continue;
+		goto out;
+	}
+
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
+
+	if (x && x->km.state == XFRM_STATE_VALID) {
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		if (hlist_unhashed(&x->state_cache_input)) {
+			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
+		} else {
+			hlist_del_rcu(&x->state_cache_input);
+			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
+		}
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	}
+
+out:
+	rcu_read_unlock();
+	return x;
+}
+EXPORT_SYMBOL(xfrm_input_state_lookup);
+
+static struct xfrm_state *__xfrm_state_lookup_byaddr(const struct xfrm_hash_state_ptrs *state_ptrs,
+						     u32 mark,
 						     const xfrm_address_t *daddr,
 						     const xfrm_address_t *saddr,
 						     u8 proto, unsigned short family)
 {
-	unsigned int h = xfrm_src_hash(net, daddr, saddr, family);
+	unsigned int h = __xfrm_src_hash(daddr, saddr, family, state_ptrs->hmask);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_bysrc + h, bysrc) {
+	hlist_for_each_entry_rcu(x, state_ptrs->bysrc + h, bysrc) {
 		if (x->props.family != family ||
 		    x->id.proto     != proto ||
 		    !xfrm_addr_equal(&x->id.daddr, daddr, family) ||
@@ -1129,14 +1218,17 @@ static struct xfrm_state *__xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 static inline struct xfrm_state *
 __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct net *net = xs_net(x);
 	u32 mark = x->mark.v & x->mark.m;
 
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
 	if (use_spi)
-		return __xfrm_state_lookup(net, mark, &x->id.daddr,
+		return __xfrm_state_lookup(&state_ptrs, mark, &x->id.daddr,
 					   x->id.spi, x->id.proto, family);
 	else
-		return __xfrm_state_lookup_byaddr(net, mark,
+		return __xfrm_state_lookup_byaddr(&state_ptrs, mark,
 						  &x->id.daddr,
 						  &x->props.saddr,
 						  x->id.proto, family);
@@ -1155,6 +1247,12 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 			       struct xfrm_state **best, int *acq_in_progress,
 			       int *error)
 {
+	/* We need the cpu id just as a lookup key,
+	 * we don't require it to be stable.
+	 */
+	unsigned int pcpu_id = get_cpu();
+	put_cpu();
+
 	/* Resolution logic:
 	 * 1. There is a valid state with matching selector. Done.
 	 * 2. Valid state with inappropriate selector. Skip.
@@ -1174,13 +1272,18 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 							&fl->u.__fl_common))
 			return;
 
+		if (x->pcpu_num != UINT_MAX && x->pcpu_num != pcpu_id)
+			return;
+
 		if (!*best ||
+		    ((*best)->pcpu_num == UINT_MAX && x->pcpu_num == pcpu_id) ||
 		    (*best)->km.dying > x->km.dying ||
 		    ((*best)->km.dying == x->km.dying &&
 		     (*best)->curlft.add_time < x->curlft.add_time))
 			*best = x;
 	} else if (x->km.state == XFRM_STATE_ACQ) {
-		*acq_in_progress = 1;
+		if (!*best || x->pcpu_num == pcpu_id)
+			*acq_in_progress = 1;
 	} else if (x->km.state == XFRM_STATE_ERROR ||
 		   x->km.state == XFRM_STATE_EXPIRED) {
 		if ((!x->sel.family ||
@@ -1199,6 +1302,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		unsigned short family, u32 if_id)
 {
 	static xfrm_address_t saddr_wildcard = { };
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct net *net = xp_net(pol);
 	unsigned int h, h_wildcard;
 	struct xfrm_state *x, *x0, *to_put;
@@ -1209,14 +1313,64 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	unsigned short encap_family = tmpl->encap_family;
 	unsigned int sequence;
 	struct km_event c;
+	unsigned int pcpu_id;
+	bool cached = false;
+
+	/* We need the cpu id just as a lookup key,
+	 * we don't require it to be stable.
+	 */
+	pcpu_id = get_cpu();
+	put_cpu();
 
 	to_put = NULL;
 
 	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
 
 	rcu_read_lock();
-	h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
-	hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {
+	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
+		if (x->props.family == encap_family &&
+		    x->props.reqid == tmpl->reqid &&
+		    (mark & x->mark.m) == x->mark.v &&
+		    x->if_id == if_id &&
+		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
+		    xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto &&
+		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+			xfrm_state_look_at(pol, x, fl, encap_family,
+					   &best, &acquire_in_progress, &error);
+	}
+
+	if (best)
+		goto cached;
+
+	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
+		if (x->props.family == encap_family &&
+		    x->props.reqid == tmpl->reqid &&
+		    (mark & x->mark.m) == x->mark.v &&
+		    x->if_id == if_id &&
+		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
+		    xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto &&
+		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+			xfrm_state_look_at(pol, x, fl, family,
+					   &best, &acquire_in_progress, &error);
+	}
+
+cached:
+	cached = true;
+	if (best)
+		goto found;
+	else if (error)
+		best = NULL;
+	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
+		WARN_ON(1);
+
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	h = __xfrm_dst_hash(daddr, saddr, tmpl->reqid, encap_family, state_ptrs.hmask);
+	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
 		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
 			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
@@ -1249,8 +1403,9 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	if (best || acquire_in_progress)
 		goto found;
 
-	h_wildcard = xfrm_dst_hash(net, daddr, &saddr_wildcard, tmpl->reqid, encap_family);
-	hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h_wildcard, bydst) {
+	h_wildcard = __xfrm_dst_hash(daddr, &saddr_wildcard, tmpl->reqid,
+				     encap_family, state_ptrs.hmask);
+	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h_wildcard, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
 		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
 			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
@@ -1282,10 +1437,13 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	}
 
 found:
-	x = best;
+	if (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) ||
+	    (best && (best->pcpu_num == pcpu_id)))
+		x = best;
+
 	if (!x && !error && !acquire_in_progress) {
 		if (tmpl->id.spi &&
-		    (x0 = __xfrm_state_lookup_all(net, mark, daddr,
+		    (x0 = __xfrm_state_lookup_all(&state_ptrs, mark, daddr,
 						  tmpl->id.spi, tmpl->id.proto,
 						  encap_family,
 						  &pol->xdo)) != NULL) {
@@ -1314,6 +1472,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		xfrm_init_tempstate(x, fl, tmpl, daddr, saddr, family);
 		memcpy(&x->mark, &pol->mark, sizeof(x->mark));
 		x->if_id = if_id;
+		if ((pol->flags & XFRM_POLICY_CPU_ACQUIRE) && best)
+			x->pcpu_num = pcpu_id;
 
 		error = security_xfrm_state_alloc_acquire(x, pol->security, fl->flowi_secid);
 		if (error) {
@@ -1352,6 +1512,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			x->km.state = XFRM_STATE_ACQ;
 			x->dir = XFRM_SA_DIR_OUT;
 			list_add(&x->km.all, &net->xfrm.state_all);
+			h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
 			XFRM_STATE_INSERT(bydst, &x->bydst,
 					  net->xfrm.state_bydst + h,
 					  x->xso.type);
@@ -1359,6 +1520,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			XFRM_STATE_INSERT(bysrc, &x->bysrc,
 					  net->xfrm.state_bysrc + h,
 					  x->xso.type);
+			INIT_HLIST_NODE(&x->state_cache);
 			if (x->id.spi) {
 				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
 				XFRM_STATE_INSERT(byspi, &x->byspi,
@@ -1392,6 +1554,11 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			x = NULL;
 			error = -ESRCH;
 		}
+
+		/* Use the already installed 'fallback' while the CPU-specific
+		 * SA acquire is handled*/
+		if (best)
+			x = best;
 	}
 out:
 	if (x) {
@@ -1402,6 +1569,15 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	} else {
 		*err = acquire_in_progress ? -EAGAIN : error;
 	}
+
+	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
+	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		if (hlist_unhashed(&x->state_cache))
+			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	}
+
 	rcu_read_unlock();
 	if (to_put)
 		xfrm_state_put(to_put);
@@ -1524,12 +1700,14 @@ static void __xfrm_state_bump_genids(struct xfrm_state *xnew)
 	unsigned int h;
 	u32 mark = xnew->mark.v & xnew->mark.m;
 	u32 if_id = xnew->if_id;
+	u32 cpu_id = xnew->pcpu_num;
 
 	h = xfrm_dst_hash(net, &xnew->id.daddr, &xnew->props.saddr, reqid, family);
 	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
 		if (x->props.family	== family &&
 		    x->props.reqid	== reqid &&
 		    x->if_id		== if_id &&
+		    x->pcpu_num		== cpu_id &&
 		    (mark & x->mark.m) == x->mark.v &&
 		    xfrm_addr_equal(&x->id.daddr, &xnew->id.daddr, family) &&
 		    xfrm_addr_equal(&x->props.saddr, &xnew->props.saddr, family))
@@ -1552,7 +1730,7 @@ EXPORT_SYMBOL(xfrm_state_insert);
 static struct xfrm_state *__find_acq_core(struct net *net,
 					  const struct xfrm_mark *m,
 					  unsigned short family, u8 mode,
-					  u32 reqid, u32 if_id, u8 proto,
+					  u32 reqid, u32 if_id, u32 pcpu_num, u8 proto,
 					  const xfrm_address_t *daddr,
 					  const xfrm_address_t *saddr,
 					  int create)
@@ -1569,6 +1747,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 		    x->id.spi       != 0 ||
 		    x->id.proto	    != proto ||
 		    (mark & x->mark.m) != x->mark.v ||
+		    x->pcpu_num != pcpu_num ||
 		    !xfrm_addr_equal(&x->id.daddr, daddr, family) ||
 		    !xfrm_addr_equal(&x->props.saddr, saddr, family))
 			continue;
@@ -1602,6 +1781,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 			break;
 		}
 
+		x->pcpu_num = pcpu_num;
 		x->km.state = XFRM_STATE_ACQ;
 		x->id.proto = proto;
 		x->props.family = family;
@@ -1630,7 +1810,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 	return x;
 }
 
-static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
+static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 
 int xfrm_state_add(struct xfrm_state *x)
 {
@@ -1656,7 +1836,7 @@ int xfrm_state_add(struct xfrm_state *x)
 	}
 
 	if (use_spi && x->km.seq) {
-		x1 = __xfrm_find_acq_byseq(net, mark, x->km.seq);
+		x1 = __xfrm_find_acq_byseq(net, mark, x->km.seq, x->pcpu_num);
 		if (x1 && ((x1->id.proto != x->id.proto) ||
 		    !xfrm_addr_equal(&x1->id.daddr, &x->id.daddr, family))) {
 			to_put = x1;
@@ -1666,7 +1846,7 @@ int xfrm_state_add(struct xfrm_state *x)
 
 	if (use_spi && !x1)
 		x1 = __find_acq_core(net, &x->mark, family, x->props.mode,
-				     x->props.reqid, x->if_id, x->id.proto,
+				     x->props.reqid, x->if_id, x->pcpu_num, x->id.proto,
 				     &x->id.daddr, &x->props.saddr, 0);
 
 	__xfrm_state_bump_genids(x);
@@ -1791,6 +1971,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->props.flags = orig->props.flags;
 	x->props.extra_flags = orig->props.extra_flags;
 
+	x->pcpu_num = orig->pcpu_num;
 	x->if_id = orig->if_id;
 	x->tfcpad = orig->tfcpad;
 	x->replay_maxdiff = orig->replay_maxdiff;
@@ -2041,10 +2222,13 @@ struct xfrm_state *
 xfrm_state_lookup(struct net *net, u32 mark, const xfrm_address_t *daddr, __be32 spi,
 		  u8 proto, unsigned short family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct xfrm_state *x;
 
 	rcu_read_lock();
-	x = __xfrm_state_lookup(net, mark, daddr, spi, proto, family);
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
 	rcu_read_unlock();
 	return x;
 }
@@ -2055,10 +2239,14 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 			 const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			 u8 proto, unsigned short family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct xfrm_state *x;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x = __xfrm_state_lookup_byaddr(net, mark, daddr, saddr, proto, family);
+
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup_byaddr(&state_ptrs, mark, daddr, saddr, proto, family);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	return x;
 }
@@ -2066,13 +2254,14 @@ EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
 
 struct xfrm_state *
 xfrm_find_acq(struct net *net, const struct xfrm_mark *mark, u8 mode, u32 reqid,
-	      u32 if_id, u8 proto, const xfrm_address_t *daddr,
+	      u32 if_id, u32 pcpu_num, u8 proto, const xfrm_address_t *daddr,
 	      const xfrm_address_t *saddr, int create, unsigned short family)
 {
 	struct xfrm_state *x;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x = __find_acq_core(net, mark, family, mode, reqid, if_id, proto, daddr, saddr, create);
+	x = __find_acq_core(net, mark, family, mode, reqid, if_id, pcpu_num,
+			    proto, daddr, saddr, create);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 	return x;
@@ -2207,7 +2396,7 @@ xfrm_state_sort(struct xfrm_state **dst, struct xfrm_state **src, int n,
 
 /* Silly enough, but I'm lazy to build resolution list */
 
-static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq)
+static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num)
 {
 	unsigned int h = xfrm_seq_hash(net, seq);
 	struct xfrm_state *x;
@@ -2215,6 +2404,7 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
 	hlist_for_each_entry_rcu(x, net->xfrm.state_byseq + h, byseq) {
 		if (x->km.seq == seq &&
 		    (mark & x->mark.m) == x->mark.v &&
+		    x->pcpu_num == pcpu_num &&
 		    x->km.state == XFRM_STATE_ACQ) {
 			xfrm_state_hold(x);
 			return x;
@@ -2224,12 +2414,12 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
 	return NULL;
 }
 
-struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq)
+struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num)
 {
 	struct xfrm_state *x;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x = __xfrm_find_acq_byseq(net, mark, seq);
+	x = __xfrm_find_acq_byseq(net, mark, seq, pcpu_num);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	return x;
 }
@@ -2988,6 +3178,11 @@ int __net_init xfrm_state_init(struct net *net)
 	net->xfrm.state_byseq = xfrm_hash_alloc(sz);
 	if (!net->xfrm.state_byseq)
 		goto out_byseq;
+
+	net->xfrm.state_cache_input = alloc_percpu(struct hlist_head);
+	if (!net->xfrm.state_cache_input)
+		goto out_state_cache_input;
+
 	net->xfrm.state_hmask = ((sz / sizeof(struct hlist_head)) - 1);
 
 	net->xfrm.state_num = 0;
@@ -2997,6 +3192,8 @@ int __net_init xfrm_state_init(struct net *net)
 			       &net->xfrm.xfrm_state_lock);
 	return 0;
 
+out_state_cache_input:
+	xfrm_hash_free(net->xfrm.state_byseq, sz);
 out_byseq:
 	xfrm_hash_free(net->xfrm.state_byspi, sz);
 out_byspi:
@@ -3026,6 +3223,7 @@ void xfrm_state_fini(struct net *net)
 	xfrm_hash_free(net->xfrm.state_bysrc, sz);
 	WARN_ON(!hlist_empty(net->xfrm.state_bydst));
 	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	free_percpu(net->xfrm.state_cache_input);
 }
 
 #ifdef CONFIG_AUDITSYSCALL
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index e3b8ce89831a..87013623773a 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -460,6 +460,12 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		}
 	}
 
+	if (!sa_dir && attrs[XFRMA_SA_PCPU]) {
+		NL_SET_ERR_MSG(extack, "SA_PCPU only supported with SA_DIR");
+		err = -EINVAL;
+		goto out;
+	}
+
 out:
 	return err;
 }
@@ -841,6 +847,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 		x->nat_keepalive_interval =
 			nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]);
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
+		if (x->pcpu_num >= num_possible_cpus())
+			goto error;
+	}
+
 	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
 	if (err)
 		goto error;
@@ -1296,6 +1308,11 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
+	if (x->pcpu_num != UINT_MAX) {
+		ret = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
+		if (ret)
+			goto out;
+	}
 	if (x->dir)
 		ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
 
@@ -1700,6 +1717,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 mark;
 	struct xfrm_mark m;
 	u32 if_id = 0;
+	u32 pcpu_num = UINT_MAX;
 
 	p = nlmsg_data(nlh);
 	err = verify_spi_info(p->info.id.proto, p->min, p->max, extack);
@@ -1716,8 +1734,16 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_IF_ID])
 		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
+		if (pcpu_num >= num_possible_cpus()) {
+			err = -EINVAL;
+			goto out_noput;
+		}
+	}
+
 	if (p->info.seq) {
-		x = xfrm_find_acq_byseq(net, mark, p->info.seq);
+		x = xfrm_find_acq_byseq(net, mark, p->info.seq, pcpu_num);
 		if (x && !xfrm_addr_equal(&x->id.daddr, daddr, family)) {
 			xfrm_state_put(x);
 			x = NULL;
@@ -1726,7 +1752,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (!x)
 		x = xfrm_find_acq(net, &m, p->info.mode, p->info.reqid,
-				  if_id, p->info.id.proto, daddr,
+				  if_id, pcpu_num, p->info.id.proto, daddr,
 				  &p->info.saddr, 1,
 				  family);
 	err = -ENOENT;
@@ -2526,7 +2552,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
 	       + nla_total_size(4) /* XFRM_AE_ETHR */
-	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
+	       + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
+	       + nla_total_size(4); /* XFRMA_SA_PCPU */
 }
 
 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2582,6 +2609,11 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		goto out_cancel;
+	if (x->pcpu_num != UINT_MAX) {
+		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
+		if (err)
+			goto out_cancel;
+	}
 
 	if (x->dir) {
 		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
@@ -2852,6 +2884,13 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	xfrm_mark_get(attrs, &mark);
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
+		err = -EINVAL;
+		if (x->pcpu_num >= num_possible_cpus())
+			goto free_state;
+	}
+
 	err = verify_newpolicy_info(&ua->policy, extack);
 	if (err)
 		goto free_state;
@@ -3182,6 +3221,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
 	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
 	[XFRMA_NAT_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },
+	[XFRMA_SA_PCPU]		= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
@@ -3348,7 +3388,8 @@ static inline unsigned int xfrm_expire_msgsize(void)
 {
 	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
 	       nla_total_size(sizeof(struct xfrm_mark)) +
-	       nla_total_size(sizeof_field(struct xfrm_state, dir));
+	       nla_total_size(sizeof_field(struct xfrm_state, dir)) +
+	       nla_total_size(4); /* XFRMA_SA_PCPU */
 }
 
 static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -3374,6 +3415,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		return err;
+	if (x->pcpu_num != UINT_MAX) {
+		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
+		if (err)
+			return err;
+	}
 
 	if (x->dir) {
 		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
@@ -3481,6 +3527,8 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	}
 	if (x->if_id)
 		l += nla_total_size(sizeof(x->if_id));
+	if (x->pcpu_num)
+		l += nla_total_size(sizeof(x->pcpu_num));
 
 	/* Must count x->lastused as it may become non-zero behind our back. */
 	l += nla_total_size_64bit(sizeof(u64));
@@ -3587,6 +3635,7 @@ static inline unsigned int xfrm_acquire_msgsize(struct xfrm_state *x,
 	       + nla_total_size(sizeof(struct xfrm_user_tmpl) * xp->xfrm_nr)
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(xfrm_user_sec_ctx_size(x->security))
+	       + nla_total_size(4) /* XFRMA_SA_PCPU */
 	       + userpolicy_type_attrsize();
 }
 
@@ -3623,6 +3672,8 @@ static int build_acquire(struct sk_buff *skb, struct xfrm_state *x,
 		err = xfrm_if_id_put(skb, xp->if_id);
 	if (!err && xp->xdo.dev)
 		err = copy_user_offload(&xp->xdo, skb);
+	if (!err && x->pcpu_num != UINT_MAX)
+		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
 	if (err) {
 		nlmsg_cancel(skb, nlh);
 		return err;
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 57565dfd74a2..07fab2ef534e 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -91,6 +91,9 @@ static int parse_path(char *env_path, const char ***const path_list)
 		}
 	}
 	*path_list = malloc(num_paths * sizeof(**path_list));
+	if (!*path_list)
+		return -1;
+
 	for (i = 0; i < num_paths; i++)
 		(*path_list)[i] = strsep(&env_path, ENV_DELIMITER);
 
@@ -127,6 +130,10 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 	env_path_name = strdup(env_path_name);
 	unsetenv(env_var);
 	num_paths = parse_path(env_path_name, &path_list);
+	if (num_paths < 0) {
+		fprintf(stderr, "Failed to allocate memory\n");
+		goto out_free_name;
+	}
 	if (num_paths == 1 && path_list[0][0] == '\0') {
 		/*
 		 * Allows to not use all possible restrictions (e.g. use
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 01a9f567d5af..fe5e132fcea8 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -371,10 +371,10 @@ quiet_cmd_lzo_with_size = LZO     $@
       cmd_lzo_with_size = { cat $(real-prereqs) | $(KLZOP) -9; $(size_append); } > $@
 
 quiet_cmd_lz4 = LZ4     $@
-      cmd_lz4 = cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout > $@
+      cmd_lz4 = cat $(real-prereqs) | $(LZ4) -l -9 - - > $@
 
 quiet_cmd_lz4_with_size = LZ4     $@
-      cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
+      cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -9 - -; \
                   $(size_append); } > $@
 
 # U-Boot mkimage
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index f3901c55df23..bbc6b7d3088c 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -239,6 +239,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 						"unchanged\n");
 				}
 				sym->is_declared = 1;
+				free_list(defn, NULL);
 				return sym;
 			} else if (!sym->is_declared) {
 				if (sym->is_override && flag_preserve) {
@@ -247,6 +248,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 					print_type_name(type, name);
 					fprintf(stderr, " modversion change\n");
 					sym->is_declared = 1;
+					free_list(defn, NULL);
 					return sym;
 				} else {
 					status = is_unknown_symbol(sym) ?
@@ -254,6 +256,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 				}
 			} else {
 				error_with_pos("redefinition of %s", name);
+				free_list(defn, NULL);
 				return sym;
 			}
 			break;
@@ -269,11 +272,15 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 				break;
 			}
 		}
+
+		free_list(sym->defn, NULL);
+		free(sym->name);
+		free(sym);
 		--nsyms;
 	}
 
 	sym = xmalloc(sizeof(*sym));
-	sym->name = name;
+	sym->name = xstrdup(name);
 	sym->type = type;
 	sym->defn = defn;
 	sym->expansion_trail = NULL;
@@ -480,7 +487,7 @@ static void read_reference(FILE *f)
 			defn = def;
 			def = read_node(f);
 		}
-		subsym = add_reference_symbol(xstrdup(sym->string), sym->tag,
+		subsym = add_reference_symbol(sym->string, sym->tag,
 					      defn, is_extern);
 		subsym->is_override = is_override;
 		free_node(sym);
diff --git a/scripts/genksyms/genksyms.h b/scripts/genksyms/genksyms.h
index 21ed2ec2d98c..5621533dcb8e 100644
--- a/scripts/genksyms/genksyms.h
+++ b/scripts/genksyms/genksyms.h
@@ -32,7 +32,7 @@ struct string_list {
 
 struct symbol {
 	struct symbol *hash_next;
-	const char *name;
+	char *name;
 	enum symbol_type type;
 	struct string_list *defn;
 	struct symbol *expansion_trail;
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index 8e9b5e69e8f0..689cb6bb40b6 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -152,14 +152,19 @@ simple_declaration:
 	;
 
 init_declarator_list_opt:
-	/* empty */				{ $$ = NULL; }
-	| init_declarator_list
+	/* empty */			{ $$ = NULL; }
+	| init_declarator_list		{ free_list(decl_spec, NULL); $$ = $1; }
 	;
 
 init_declarator_list:
 	init_declarator
 		{ struct string_list *decl = *$1;
 		  *$1 = NULL;
+
+		  /* avoid sharing among multiple init_declarators */
+		  if (decl_spec)
+		    decl_spec = copy_list_range(decl_spec, NULL);
+
 		  add_symbol(current_name,
 			     is_typedef ? SYM_TYPEDEF : SYM_NORMAL, decl, is_extern);
 		  current_name = NULL;
@@ -170,6 +175,11 @@ init_declarator_list:
 		  *$3 = NULL;
 		  free_list(*$2, NULL);
 		  *$2 = decl_spec;
+
+		  /* avoid sharing among multiple init_declarators */
+		  if (decl_spec)
+		    decl_spec = copy_list_range(decl_spec, NULL);
+
 		  add_symbol(current_name,
 			     is_typedef ? SYM_TYPEDEF : SYM_NORMAL, decl, is_extern);
 		  current_name = NULL;
@@ -472,12 +482,12 @@ enumerator_list:
 enumerator:
 	IDENT
 		{
-			const char *name = strdup((*$1)->string);
+			const char *name = (*$1)->string;
 			add_symbol(name, SYM_ENUM_CONST, NULL, 0);
 		}
 	| IDENT '=' EXPRESSION_PHRASE
 		{
-			const char *name = strdup((*$1)->string);
+			const char *name = (*$1)->string;
 			struct string_list *expr = copy_list_range(*$3, *$2);
 			add_symbol(name, SYM_ENUM_CONST, expr, 0);
 		}
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4286d5e7f95d..3b55e7a4131d 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -360,10 +360,12 @@ int conf_read_simple(const char *name, int def)
 
 			*p = '\0';
 
-			in = zconf_fopen(env);
+			name = env;
+
+			in = zconf_fopen(name);
 			if (in) {
 				conf_message("using defaults found in %s",
-					     env);
+					     name);
 				goto load;
 			}
 
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index a3af93aaaf32..453721e66c4e 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -376,6 +376,7 @@ static void sym_warn_unmet_dep(const struct symbol *sym)
 			       "  Selected by [m]:\n");
 
 	fputs(str_get(&gs), stderr);
+	str_free(&gs);
 	sym_warnings++;
 }
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e31b97a9f175..7adb25150488 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -937,10 +937,6 @@ static access_mask_t get_mode_access(const umode_t mode)
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
 		return LANDLOCK_ACCESS_FS_MAKE_SYM;
-	case 0:
-		/* A zero mode translates to S_IFREG. */
-	case S_IFREG:
-		return LANDLOCK_ACCESS_FS_MAKE_REG;
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
@@ -951,9 +947,12 @@ static access_mask_t get_mode_access(const umode_t mode)
 		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
 	case S_IFSOCK:
 		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
+	case S_IFREG:
+	case 0:
+		/* A zero mode translates to S_IFREG. */
 	default:
-		WARN_ON_ONCE(1);
-		return 0;
+		/* Treats weird files as regular files. */
+		return LANDLOCK_ACCESS_FS_MAKE_REG;
 	}
 }
 
diff --git a/sound/core/seq/Kconfig b/sound/core/seq/Kconfig
index 0374bbf51cd4..e4f58cb985d4 100644
--- a/sound/core/seq/Kconfig
+++ b/sound/core/seq/Kconfig
@@ -62,7 +62,7 @@ config SND_SEQ_VIRMIDI
 
 config SND_SEQ_UMP
 	bool "Support for UMP events"
-	default y if SND_SEQ_UMP_CLIENT
+	default SND_UMP
 	help
 	  Say Y here to enable the support for handling UMP (Universal MIDI
 	  Packet) events via ALSA sequencer infrastructure, which is an
@@ -71,6 +71,6 @@ config SND_SEQ_UMP
 	  among legacy and UMP clients.
 
 config SND_SEQ_UMP_CLIENT
-	def_tristate SND_UMP
+	def_tristate SND_UMP && SND_SEQ_UMP
 
 endif # SND_SEQUENCER
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c4de5a253ad..5d99a4ea176a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10143,6 +10143,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1360, "Acer Aspire A115", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x141f, "Acer Spin SP513-54N", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x142b, "Acer Swift SF314-42", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 56ce9e4b6acc..92c5ff0deea2 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -181,6 +181,7 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 			break;
 		default:
 			dev_err(dev, "Unknown chip revision %d\n", chip->acp_rev);
+			spin_unlock_irq(&adata->acp_lock);
 			return -EINVAL;
 		}
 	}
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 54cbc3feae32..69cb0b39f220 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -79,7 +79,7 @@ snd-soc-cs35l56-shared-y := cs35l56-shared.o
 snd-soc-cs35l56-i2c-y := cs35l56-i2c.o
 snd-soc-cs35l56-spi-y := cs35l56-spi.o
 snd-soc-cs35l56-sdw-y := cs35l56-sdw.o
-snd-soc-cs40l50-objs := cs40l50-codec.o
+snd-soc-cs40l50-y := cs40l50-codec.o
 snd-soc-cs42l42-y := cs42l42.o
 snd-soc-cs42l42-i2c-y := cs42l42-i2c.o
 snd-soc-cs42l42-sdw-y := cs42l42-sdw.o
@@ -324,8 +324,8 @@ snd-soc-wcd-classh-y := wcd-clsh-v2.o
 snd-soc-wcd-mbhc-y := wcd-mbhc-v2.o
 snd-soc-wcd9335-y := wcd9335.o
 snd-soc-wcd934x-y := wcd934x.o
-snd-soc-wcd937x-objs := wcd937x.o
-snd-soc-wcd937x-sdw-objs := wcd937x-sdw.o
+snd-soc-wcd937x-y := wcd937x.o
+snd-soc-wcd937x-sdw-y := wcd937x-sdw.o
 snd-soc-wcd938x-y := wcd938x.o
 snd-soc-wcd938x-sdw-y := wcd938x-sdw.o
 snd-soc-wcd939x-y := wcd939x.o
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 486db60bf2dd..f17f02d01f8c 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2191,6 +2191,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	mutex_init(&da7213->ctrl_lock);
+
 	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
 	pm_runtime_use_autosuspend(&i2c->dev);
 	pm_runtime_set_active(&i2c->dev);
diff --git a/sound/soc/intel/avs/apl.c b/sound/soc/intel/avs/apl.c
index 27516ef57185..3dccf0a57a3a 100644
--- a/sound/soc/intel/avs/apl.c
+++ b/sound/soc/intel/avs/apl.c
@@ -12,6 +12,7 @@
 #include "avs.h"
 #include "messages.h"
 #include "path.h"
+#include "registers.h"
 #include "topology.h"
 
 static irqreturn_t avs_apl_dsp_interrupt(struct avs_dev *adev)
@@ -125,7 +126,7 @@ int avs_apl_coredump(struct avs_dev *adev, union avs_notify_msg *msg)
 	struct avs_apl_log_buffer_layout layout;
 	void __iomem *addr, *buf;
 	size_t dump_size;
-	u16 offset = 0;
+	u32 offset = 0;
 	u8 *dump, *pos;
 
 	dump_size = AVS_FW_REGS_SIZE + msg->ext.coredump.stack_dump_size;
diff --git a/sound/soc/intel/avs/cnl.c b/sound/soc/intel/avs/cnl.c
index bd3c4bb8bf5a..03f8fb0dc187 100644
--- a/sound/soc/intel/avs/cnl.c
+++ b/sound/soc/intel/avs/cnl.c
@@ -9,6 +9,7 @@
 #include <sound/hdaudio_ext.h>
 #include "avs.h"
 #include "messages.h"
+#include "registers.h"
 
 static void avs_cnl_ipc_interrupt(struct avs_dev *adev)
 {
diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 73d4bde9b2f7..82839d0994ee 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -829,10 +829,10 @@ static const struct avs_spec jsl_desc = {
 	.hipc = &cnl_hipc_spec,
 };
 
-#define AVS_TGL_BASED_SPEC(sname)		\
+#define AVS_TGL_BASED_SPEC(sname, min)		\
 static const struct avs_spec sname##_desc = {	\
 	.name = #sname,				\
-	.min_fw_version = { 10,	29, 0, 5646 },	\
+	.min_fw_version = { 10,	min, 0, 5646 },	\
 	.dsp_ops = &avs_tgl_dsp_ops,		\
 	.core_init_mask = 1,			\
 	.attributes = AVS_PLATATTR_IMR,		\
@@ -840,11 +840,11 @@ static const struct avs_spec sname##_desc = {	\
 	.hipc = &cnl_hipc_spec,			\
 }
 
-AVS_TGL_BASED_SPEC(lkf);
-AVS_TGL_BASED_SPEC(tgl);
-AVS_TGL_BASED_SPEC(ehl);
-AVS_TGL_BASED_SPEC(adl);
-AVS_TGL_BASED_SPEC(adl_n);
+AVS_TGL_BASED_SPEC(lkf, 28);
+AVS_TGL_BASED_SPEC(tgl, 29);
+AVS_TGL_BASED_SPEC(ehl, 30);
+AVS_TGL_BASED_SPEC(adl, 35);
+AVS_TGL_BASED_SPEC(adl_n, 35);
 
 static const struct pci_device_id avs_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP, &skl_desc) },
diff --git a/sound/soc/intel/avs/loader.c b/sound/soc/intel/avs/loader.c
index 890efd2f1fea..37de077a9983 100644
--- a/sound/soc/intel/avs/loader.c
+++ b/sound/soc/intel/avs/loader.c
@@ -308,7 +308,7 @@ avs_hda_init_rom(struct avs_dev *adev, unsigned int dma_id, bool purge)
 	}
 
 	/* await ROM init */
-	ret = snd_hdac_adsp_readq_poll(adev, spec->sram->rom_status_offset, reg,
+	ret = snd_hdac_adsp_readl_poll(adev, spec->sram->rom_status_offset, reg,
 				       (reg & 0xF) == AVS_ROM_INIT_DONE ||
 				       (reg & 0xF) == APL_ROM_FW_ENTERED,
 				       AVS_ROM_INIT_POLLING_US, APL_ROM_INIT_TIMEOUT_US);
diff --git a/sound/soc/intel/avs/registers.h b/sound/soc/intel/avs/registers.h
index f76e91cff2a9..5b6d60eb3c18 100644
--- a/sound/soc/intel/avs/registers.h
+++ b/sound/soc/intel/avs/registers.h
@@ -9,6 +9,8 @@
 #ifndef __SOUND_SOC_INTEL_AVS_REGS_H
 #define __SOUND_SOC_INTEL_AVS_REGS_H
 
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/sizes.h>
 
 #define AZX_PCIREG_PGCTL		0x44
@@ -98,4 +100,47 @@
 #define avs_downlink_addr(adev) \
 	avs_sram_addr(adev, AVS_DOWNLINK_WINDOW)
 
+#define snd_hdac_adsp_writeb(adev, reg, value) \
+	snd_hdac_reg_writeb(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readb(adev, reg) \
+	snd_hdac_reg_readb(&(adev)->base.core, (adev)->dsp_ba + (reg))
+#define snd_hdac_adsp_writew(adev, reg, value) \
+	snd_hdac_reg_writew(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readw(adev, reg) \
+	snd_hdac_reg_readw(&(adev)->base.core, (adev)->dsp_ba + (reg))
+#define snd_hdac_adsp_writel(adev, reg, value) \
+	snd_hdac_reg_writel(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readl(adev, reg) \
+	snd_hdac_reg_readl(&(adev)->base.core, (adev)->dsp_ba + (reg))
+#define snd_hdac_adsp_writeq(adev, reg, value) \
+	snd_hdac_reg_writeq(&(adev)->base.core, (adev)->dsp_ba + (reg), value)
+#define snd_hdac_adsp_readq(adev, reg) \
+	snd_hdac_reg_readq(&(adev)->base.core, (adev)->dsp_ba + (reg))
+
+#define snd_hdac_adsp_updateb(adev, reg, mask, val) \
+	snd_hdac_adsp_writeb(adev, reg, \
+			(snd_hdac_adsp_readb(adev, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updatew(adev, reg, mask, val) \
+	snd_hdac_adsp_writew(adev, reg, \
+			(snd_hdac_adsp_readw(adev, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updatel(adev, reg, mask, val) \
+	snd_hdac_adsp_writel(adev, reg, \
+			(snd_hdac_adsp_readl(adev, reg) & ~(mask)) | (val))
+#define snd_hdac_adsp_updateq(adev, reg, mask, val) \
+	snd_hdac_adsp_writeq(adev, reg, \
+			(snd_hdac_adsp_readq(adev, reg) & ~(mask)) | (val))
+
+#define snd_hdac_adsp_readb_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readb_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readw_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readw_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readl_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readl_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_adsp_readq_poll(adev, reg, val, cond, delay_us, timeout_us) \
+	readq_poll_timeout((adev)->dsp_ba + (reg), val, cond, \
+			   delay_us, timeout_us)
+
 #endif /* __SOUND_SOC_INTEL_AVS_REGS_H */
diff --git a/sound/soc/intel/avs/skl.c b/sound/soc/intel/avs/skl.c
index 34f859d6e5a4..d66ef000de9e 100644
--- a/sound/soc/intel/avs/skl.c
+++ b/sound/soc/intel/avs/skl.c
@@ -12,6 +12,7 @@
 #include "avs.h"
 #include "cldma.h"
 #include "messages.h"
+#include "registers.h"
 
 void avs_skl_ipc_interrupt(struct avs_dev *adev)
 {
diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 5cda527020c7..d612f20ed989 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1466,7 +1466,7 @@ avs_tplg_path_template_create(struct snd_soc_component *comp, struct avs_tplg *o
 
 static const struct avs_tplg_token_parser mod_init_config_parsers[] = {
 	{
-		.token = AVS_TKN_MOD_INIT_CONFIG_ID_U32,
+		.token = AVS_TKN_INIT_CONFIG_ID_U32,
 		.type = SND_SOC_TPLG_TUPLE_TYPE_WORD,
 		.offset = offsetof(struct avs_tplg_init_config, id),
 		.parse = avs_parse_word_token,
@@ -1519,7 +1519,7 @@ static int avs_tplg_parse_initial_configs(struct snd_soc_component *comp,
 		esize = le32_to_cpu(tuples->size) + le32_to_cpu(tmp->size);
 
 		ret = parse_dictionary_entries(comp, tuples, esize, config, 1, sizeof(*config),
-					       AVS_TKN_MOD_INIT_CONFIG_ID_U32,
+					       AVS_TKN_INIT_CONFIG_ID_U32,
 					       mod_init_config_parsers,
 					       ARRAY_SIZE(mod_init_config_parsers));
 
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 41042259f2b2..9f2dc24d44cb 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -22,6 +22,8 @@ static int quirk_override = -1;
 module_param_named(quirk, quirk_override, int, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
+#define DMIC_DEFAULT_CHANNELS 2
+
 static void log_quirks(struct device *dev)
 {
 	if (SOC_SDW_JACK_JDSRC(sof_sdw_quirk))
@@ -584,17 +586,32 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "3838")
+			DMI_MATCH(DMI_PRODUCT_NAME, "83JX")
 		},
-		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS | SOC_SDW_CODEC_MIC),
 	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "3832")
+			DMI_MATCH(DMI_PRODUCT_NAME, "83LC")
 		},
-		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS | SOC_SDW_CODEC_MIC),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83MC")
+		},
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS | SOC_SDW_CODEC_MIC),
+	},	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83NM")
+		},
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS | SOC_SDW_CODEC_MIC),
 	},
 	{
 		.callback = sof_sdw_quirk_cb,
@@ -1063,17 +1080,19 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 		hdmi_num = SOF_PRE_TGL_HDMI_COUNT;
 
 	/* enable dmic01 & dmic16k */
-	if (sof_sdw_quirk & SOC_SDW_PCH_DMIC || mach_params->dmic_num) {
-		if (ctx->ignore_internal_dmic)
-			dev_warn(dev, "Ignoring PCH DMIC\n");
-		else
-			dmic_num = 2;
+	if (ctx->ignore_internal_dmic) {
+		dev_warn(dev, "Ignoring internal DMIC\n");
+		mach_params->dmic_num = 0;
+	} else if (mach_params->dmic_num) {
+		dmic_num = 2;
+	} else if (sof_sdw_quirk & SOC_SDW_PCH_DMIC) {
+		dmic_num = 2;
+		/*
+		 * mach_params->dmic_num will be used to set the cfg-mics value of
+		 * card->components string. Set it to the default value.
+		 */
+		mach_params->dmic_num = DMIC_DEFAULT_CHANNELS;
 	}
-	/*
-	 * mach_params->dmic_num will be used to set the cfg-mics value of card->components
-	 * string. Overwrite it to the actual number of PCH DMICs used in the device.
-	 */
-	mach_params->dmic_num = dmic_num;
 
 	if (sof_sdw_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
 		bt_num = 1;
diff --git a/sound/soc/mediatek/mt8365/Makefile b/sound/soc/mediatek/mt8365/Makefile
index 52ba45a8498a..b197025e34bb 100644
--- a/sound/soc/mediatek/mt8365/Makefile
+++ b/sound/soc/mediatek/mt8365/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # MTK Platform driver
-snd-soc-mt8365-pcm-objs := \
+snd-soc-mt8365-pcm-y := \
 	mt8365-afe-clk.o \
 	mt8365-afe-pcm.o \
 	mt8365-dai-adda.o \
diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index d1f28699652f..acd75e48851f 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -22,7 +22,6 @@
 
 #define DRV_NAME "rockchip-i2s-tdm"
 
-#define DEFAULT_MCLK_FS				256
 #define CH_GRP_MAX				4  /* The max channel 8 / 2 */
 #define MULTIPLEX_CH_MAX			10
 
@@ -70,6 +69,8 @@ struct rk_i2s_tdm_dev {
 	bool has_playback;
 	bool has_capture;
 	struct snd_soc_dai_driver *dai;
+	unsigned int mclk_rx_freq;
+	unsigned int mclk_tx_freq;
 };
 
 static int to_ch_num(unsigned int val)
@@ -645,6 +646,27 @@ static int rockchip_i2s_trcm_mode(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
+				       unsigned int freq, int dir)
+{
+	struct rk_i2s_tdm_dev *i2s_tdm = to_info(cpu_dai);
+
+	if (i2s_tdm->clk_trcm) {
+		i2s_tdm->mclk_tx_freq = freq;
+		i2s_tdm->mclk_rx_freq = freq;
+	} else {
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			i2s_tdm->mclk_tx_freq = freq;
+		else
+			i2s_tdm->mclk_rx_freq = freq;
+	}
+
+	dev_dbg(i2s_tdm->dev, "The target mclk_%s freq is: %d\n",
+		stream ? "rx" : "tx", freq);
+
+	return 0;
+}
+
 static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params,
 				      struct snd_soc_dai *dai)
@@ -659,15 +681,19 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 
 		if (i2s_tdm->clk_trcm == TRCM_TX) {
 			mclk = i2s_tdm->mclk_tx;
+			mclk_rate = i2s_tdm->mclk_tx_freq;
 		} else if (i2s_tdm->clk_trcm == TRCM_RX) {
 			mclk = i2s_tdm->mclk_rx;
+			mclk_rate = i2s_tdm->mclk_rx_freq;
 		} else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			mclk = i2s_tdm->mclk_tx;
+			mclk_rate = i2s_tdm->mclk_tx_freq;
 		} else {
 			mclk = i2s_tdm->mclk_rx;
+			mclk_rate = i2s_tdm->mclk_rx_freq;
 		}
 
-		err = clk_set_rate(mclk, DEFAULT_MCLK_FS * params_rate(params));
+		err = clk_set_rate(mclk, mclk_rate);
 		if (err)
 			return err;
 
@@ -827,6 +853,7 @@ static const struct snd_soc_dai_ops rockchip_i2s_tdm_dai_ops = {
 	.hw_params = rockchip_i2s_tdm_hw_params,
 	.set_bclk_ratio	= rockchip_i2s_tdm_set_bclk_ratio,
 	.set_fmt = rockchip_i2s_tdm_set_fmt,
+	.set_sysclk = rockchip_i2s_tdm_set_sysclk,
 	.set_tdm_slot = rockchip_dai_tdm_slot,
 	.trigger = rockchip_i2s_tdm_trigger,
 };
diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 040ce0431fd2..32db2cead8a4 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -258,8 +258,7 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 			    unsigned int channels)
 {
-	static s8 ckdv[16] = { 1,  2,  4,  8, 16, 32, 64, 128,
-			       6, 12, 24, 48, 96, -1, -1, -1 };
+	static u8 ckdv[] = { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 };
 	unsigned int channel_bits = 32;	/* System Word Length */
 	unsigned long bclk_rate = rate * channels * channel_bits;
 	unsigned int div;
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 0aa416423246..7cf623cbe9ed 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -176,6 +176,7 @@ struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
 	unsigned int val_fctl_ftx;
+	unsigned int mclk_multiplier;
 };
 
 struct sun4i_spdif_dev {
@@ -313,6 +314,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk *= host->quirks->mclk_multiplier;
 
 	ret = clk_set_rate(host->spdif_clk, mclk);
 	if (ret < 0) {
@@ -347,6 +349,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk_div *= host->quirks->mclk_multiplier;
 
 	reg_val = 0;
 	reg_val |= SUN4I_SPDIF_TXCFG_ASS;
@@ -540,24 +543,28 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
+	.mclk_multiplier = 1,
 };
 
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
+	.mclk_multiplier = 1,
 };
 
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
+	.mclk_multiplier = 4,
 };
 
 static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks = {
 	.reg_dac_txdata = SUN8I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN50I_H6_SPDIF_FCTL_FTX,
 	.has_reset      = true,
+	.mclk_multiplier = 1,
 };
 
 static const struct of_device_id sun4i_spdif_of_match[] = {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7968d6a2f592..a97efb7b131e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2343,6 +2343,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 156b62a163c5..8a48cc2536f5 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -226,7 +226,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	/* Wrong Checksum */
 	rcsum = xbc_calc_checksum(*buf, size);
 	if (csum != rcsum) {
-		pr_err("checksum error: %d != %d\n", csum, rcsum);
+		pr_err("checksum error: %u != %u\n", csum, rcsum);
 		return -EINVAL;
 	}
 
@@ -395,7 +395,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	xbc_get_info(&ret, NULL);
 	printf("\tNumber of nodes: %d\n", ret);
 	printf("\tSize: %u bytes\n", (unsigned int)size);
-	printf("\tChecksum: %d\n", (unsigned int)csum);
+	printf("\tChecksum: %u\n", (unsigned int)csum);
 
 	/* TODO: Check the options by schema */
 	xbc_exit();
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 2f082b01ff22..42ec5ddaab8d 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -117,12 +117,12 @@ struct xdp_options {
 	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
 
 /* Request transmit timestamp. Upon completion, put it into tx_timestamp
- * field of union xsk_tx_metadata.
+ * field of struct xsk_tx_metadata.
  */
 #define XDP_TXMD_FLAGS_TIMESTAMP		(1 << 0)
 
 /* Request transmit checksum offload. Checksum start position and offset
- * are communicated via csum_start and csum_offset fields of union
+ * are communicated via csum_start and csum_offset fields of struct
  * xsk_tx_metadata.
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3c131039c523..27e7bfae953b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1185,6 +1185,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	elf = elf_begin(fd, ELF_C_READ, NULL);
 	if (!elf) {
+		err = -LIBBPF_ERRNO__FORMAT;
 		pr_warn("failed to open %s as ELF file\n", path);
 		goto done;
 	}
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index 4f7399d85eab..8ef8003480da 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -212,7 +212,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 	 * need to match both name and size, otherwise embedding the base
 	 * struct/union in the split type is invalid.
 	 */
-	for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
+	for (id = r->nr_dist_base_types; id < r->nr_dist_base_types + r->nr_split_types; id++) {
 		err = btf_mark_embedded_composite_type_ids(r, id);
 		if (err)
 			goto done;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 6985ab0f1ca9..777600822d8e 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -567,17 +567,15 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 	}
 	obj->elf = elf_begin(obj->fd, ELF_C_READ_MMAP, NULL);
 	if (!obj->elf) {
-		err = -errno;
 		pr_warn_elf("failed to parse ELF file '%s'", filename);
-		return err;
+		return -EINVAL;
 	}
 
 	/* Sanity check ELF file high-level properties */
 	ehdr = elf64_getehdr(obj->elf);
 	if (!ehdr) {
-		err = -errno;
 		pr_warn_elf("failed to get ELF header for %s", filename);
-		return err;
+		return -EINVAL;
 	}
 	if (ehdr->e_ident[EI_DATA] != host_endianness) {
 		err = -EOPNOTSUPP;
@@ -593,9 +591,8 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 	}
 
 	if (elf_getshdrstrndx(obj->elf, &obj->shstrs_sec_idx)) {
-		err = -errno;
 		pr_warn_elf("failed to get SHSTRTAB section index for %s", filename);
-		return err;
+		return -EINVAL;
 	}
 
 	scn = NULL;
@@ -605,26 +602,23 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 
 		shdr = elf64_getshdr(scn);
 		if (!shdr) {
-			err = -errno;
 			pr_warn_elf("failed to get section #%zu header for %s",
 				    sec_idx, filename);
-			return err;
+			return -EINVAL;
 		}
 
 		sec_name = elf_strptr(obj->elf, obj->shstrs_sec_idx, shdr->sh_name);
 		if (!sec_name) {
-			err = -errno;
 			pr_warn_elf("failed to get section #%zu name for %s",
 				    sec_idx, filename);
-			return err;
+			return -EINVAL;
 		}
 
 		data = elf_getdata(scn, 0);
 		if (!data) {
-			err = -errno;
 			pr_warn_elf("failed to get section #%zu (%s) data from %s",
 				    sec_idx, sec_name, filename);
-			return err;
+			return -EINVAL;
 		}
 
 		sec = add_src_sec(obj, sec_name);
@@ -2635,14 +2629,14 @@ int bpf_linker__finalize(struct bpf_linker *linker)
 
 	/* Finalize ELF layout */
 	if (elf_update(linker->elf, ELF_C_NULL) < 0) {
-		err = -errno;
+		err = -EINVAL;
 		pr_warn_elf("failed to finalize ELF layout");
 		return libbpf_err(err);
 	}
 
 	/* Write out final ELF contents */
 	if (elf_update(linker->elf, ELF_C_WRITE) < 0) {
-		err = -errno;
+		err = -EINVAL;
 		pr_warn_elf("failed to write ELF contents");
 		return libbpf_err(err);
 	}
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 93794f01bb67..6ff28e7bf5e3 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -659,7 +659,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
 		 */
 		usdt_abs_ip = note.loc_addr;
-		if (base_addr)
+		if (base_addr && note.base_addr)
 			usdt_abs_ip += base_addr - note.base_addr;
 
 		/* When attaching uprobes (which is what USDTs basically are)
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index e16cef160bc2..ce32cb35007d 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -95,7 +95,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 
 	ynl_attr_for_each_payload(start, data_len, attr) {
 		astart_off = (char *)attr - (char *)start;
-		aend_off = astart_off + ynl_attr_data_len(attr);
+		aend_off = (char *)ynl_attr_data_end(attr) - (char *)start;
 		if (aend_off <= off)
 			continue;
 
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index dc42de1785ce..908165fcec7d 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,5 +1,6 @@
 arch/arm64/tools/gen-sysreg.awk
 arch/arm64/tools/sysreg
+arch/*/include/uapi/asm/bpf_perf_event.h
 tools/perf
 tools/arch
 tools/scripts
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d6989195a061..11e49cafa3af 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2367,10 +2367,10 @@ int cmd_inject(int argc, const char **argv)
 	};
 	int ret;
 	const char *known_build_ids = NULL;
-	bool build_ids;
-	bool build_id_all;
-	bool mmap2_build_ids;
-	bool mmap2_build_id_all;
+	bool build_ids = false;
+	bool build_id_all = false;
+	bool mmap2_build_ids = false;
+	bool mmap2_build_id_all = false;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..33a456980664 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1591,8 +1591,8 @@ static const struct {
 	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
+	/* alias for optimistic spinning only */
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex:spin",	"mutex-spin" },
 };
 
 static const char *get_type_str(unsigned int flags)
@@ -1617,19 +1617,6 @@ static const char *get_type_name(unsigned int flags)
 	return "unknown";
 }
 
-static unsigned int get_type_flag(const char *str)
-{
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].name, str))
-			return lock_type_table[i].flags;
-	}
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].str, str))
-			return lock_type_table[i].flags;
-	}
-	return UINT_MAX;
-}
-
 static void lock_filter_finish(void)
 {
 	zfree(&filters.types);
@@ -2350,29 +2337,58 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 			   int unset __maybe_unused)
 {
 	char *s, *tmp, *tok;
-	int ret = 0;
 
 	s = strdup(str);
 	if (s == NULL)
 		return -1;
 
 	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		unsigned int flags = get_type_flag(tok);
+		bool found = false;
 
-		if (flags == -1U) {
-			pr_err("Unknown lock flags: %s\n", tok);
-			ret = -1;
-			break;
+		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
+		if (strchr(tok, ':')) {
+			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+				if (!strcmp(lock_type_table[i].str, tok) &&
+				    add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+					break;
+				}
+			}
+
+			if (!found) {
+				pr_err("Unknown lock flags name: %s\n", tok);
+				free(s);
+				return -1;
+			}
+
+			continue;
 		}
 
-		if (!add_lock_type(flags)) {
-			ret = -1;
-			break;
+		/*
+		 * Otherwise `tok` is `name` in `lock_type_table`.
+		 * Single lock name could contain multiple flags.
+		 */
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].name, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+				} else {
+					free(s);
+					return -1;
+				}
+			}
 		}
+
+		if (!found) {
+			pr_err("Unknown lock name: %s\n", tok);
+			free(s);
+			return -1;
+		}
+
 	}
 
 	free(s);
-	return ret;
+	return 0;
 }
 
 static bool add_lock_addr(unsigned long addr)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5dc17ffee27a..645deec294c8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1418,7 +1418,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
 		   "addr2line binary to use for line numbers"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
-		    "Disable symbol demangling"),
+		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 724a79386321..ca3e8eca6610 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -809,7 +809,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
+		    __map__is_kernel(al.map) && !map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ffa129527309..ecd26e058baf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2122,8 +2122,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 		return PTR_ERR(sc->tp_format);
 	}
 
+	/*
+	 * The tracepoint format contains __syscall_nr field, so it's one more
+	 * than the actual number of syscall arguments.
+	 */
 	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
-					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields))
+					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields - 1))
 		return -ENOMEM;
 
 	sc->args = sc->tp_format->format.fields;
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 5a3b8a5a9b5c..8d1e6bbeac90 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -26,8 +26,12 @@ check_vmlinux() {
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
-  # test flight just to see if landlock_add_rule and libbpf are available
-  $TESTPROG
+  # test flight just to see if landlock_add_rule is available
+  if ! perf trace $TESTPROG 2>&1 | grep -q landlock
+  then
+    echo "No landlock system call found, skipping to non-syscall tracing."
+    return
+  fi
 
   if perf trace -e $syscall $TESTPROG 2>&1 | \
      grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 13608237c50e..c81444059ad0 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -289,7 +289,10 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		}
 
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 		info_linear = NULL;
 
 		/*
@@ -480,7 +483,10 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_node = malloc(sizeof(struct bpf_prog_info_node));
 	if (info_node) {
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 	} else
 		free(info_linear);
 
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 4a62ed593e84..e4352881e3fa 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -431,9 +431,9 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
 	bool augmented, do_output = false;
-	int zero = 0, size, aug_size, index,
-	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
 	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
+	s64 aug_size, size;
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
 	void *arg, *payload_offset;
@@ -484,14 +484,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		} else if (size > 0 && size <= value_size) { /* struct */
 			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
 				augmented = true;
-		} else if (size < 0 && size >= -6) { /* buffer */
+		} else if ((int)size < 0 && size >= -6) { /* buffer */
 			index = -(size + 1);
 			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
 			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
-			aug_size = args->args[index];
-
-			if (aug_size > TRACE_AUG_MAX_BUF)
-				aug_size = TRACE_AUG_MAX_BUF;
+			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
 
 			if (aug_size > 0) {
 				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1edbccfc3281..d981b6f4bc5e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -22,15 +22,19 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
-void perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
 {
+	bool ret;
+
 	down_write(&env->bpf_progs.lock);
-	__perf_env__insert_bpf_prog_info(env, info_node);
+	ret = __perf_env__insert_bpf_prog_info(env, info_node);
 	up_write(&env->bpf_progs.lock);
+
+	return ret;
 }
 
-void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
+bool __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
 {
 	__u32 prog_id = info_node->info_linear->info.id;
 	struct bpf_prog_info_node *node;
@@ -48,13 +52,14 @@ void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated bpf prog info %u\n", prog_id);
-			return;
+			return false;
 		}
 	}
 
 	rb_link_node(&info_node->rb_node, parent, p);
 	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
 	env->bpf_progs.infos_cnt++;
+	return true;
 }
 
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 51b36c36019b..38de0af2a680 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -176,9 +176,9 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-void __perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
-void perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index b2536a59c44e..90c6ce2212e4 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -288,7 +288,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 {
 	struct expr_parse_ctx *ctx;
 
-	ctx = malloc(sizeof(struct expr_parse_ctx));
+	ctx = calloc(1, sizeof(struct expr_parse_ctx));
 	if (!ctx)
 		return NULL;
 
@@ -297,9 +297,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
 		free(ctx);
 		return NULL;
 	}
-	ctx->sctx.user_requested_cpu_list = NULL;
-	ctx->sctx.runtime = 0;
-	ctx->sctx.system_wide = false;
 
 	return ctx;
 }
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a6386d12afd7..7b99f58f7bf2 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3188,7 +3188,10 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		__perf_env__insert_bpf_prog_info(env, info_node);
+		if (!__perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -3235,7 +3238,8 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		__perf_env__insert_btf(env, node);
+		if (!__perf_env__insert_btf(env, node))
+			free(node);
 		node = NULL;
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 27d5345d2b30..9be2f4479f52 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1003,7 +1003,7 @@ static int machine__get_running_kernel_start(struct machine *machine,
 
 	err = kallsyms__get_symbol_start(filename, "_edata", &addr);
 	if (err)
-		err = kallsyms__get_function_start(filename, "_etext", &addr);
+		err = kallsyms__get_symbol_start(filename, "_etext", &addr);
 	if (!err)
 		*end = addr;
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..09c9cc326c08 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1136,8 +1136,13 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	struct map *result = NULL;
 
 	down_read(maps__lock(maps));
+	while (!maps__maps_by_address_sorted(maps)) {
+		up_read(maps__lock(maps));
+		maps__sort_by_address(maps);
+		down_read(maps__lock(maps));
+	}
 	i = maps__by_address_index(maps, map);
-	if (i < maps__nr_maps(maps))
+	if (++i < maps__nr_maps(maps))
 		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index cb185c5659d6..68f5de2d79c7 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -266,11 +266,16 @@ pid_t nsinfo__pid(const struct nsinfo  *nsi)
 	return RC_CHK_ACCESS(nsi)->pid;
 }
 
-pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
+bool nsinfo__in_pidns(const struct nsinfo *nsi)
 {
 	return RC_CHK_ACCESS(nsi)->in_pidns;
 }
 
+void nsinfo__set_in_pidns(struct nsinfo *nsi)
+{
+	RC_CHK_ACCESS(nsi)->in_pidns = true;
+}
+
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 8c0731c6cbb7..e95c79b80e27 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -58,7 +58,8 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
-pid_t nsinfo__in_pidns(const struct nsinfo  *nsi);
+bool nsinfo__in_pidns(const struct nsinfo  *nsi);
+void nsinfo__set_in_pidns(struct nsinfo *nsi);
 
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
 void nsinfo__mountns_exit(struct nscookie *nc);
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index ae6af354a81d..08a399b0be28 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -33,7 +33,7 @@ static int mperf_get_count_percent(unsigned int self_id, double *percent,
 				   unsigned int cpu);
 static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 				unsigned int cpu);
-static struct timespec time_start, time_end;
+static struct timespec *time_start, *time_end;
 
 static cstate_t mperf_cstates[MPERF_CSTATE_COUNT] = {
 	{
@@ -174,7 +174,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
 	} else if (max_freq_mode == MAX_FREQ_SYSFS) {
-		timediff = max_frequency * timespec_diff_us(time_start, time_end);
+		timediff = max_frequency * timespec_diff_us(time_start[cpu], time_end[cpu]);
 		*percent = 100.0 * mperf_diff / timediff;
 		dprint("%s: MAXFREQ - mperf_diff: %llu, time_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, timediff);
@@ -207,7 +207,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
 		/* Calculate max_freq from TSC count */
 		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
-		time_diff = timespec_diff_us(time_start, time_end);
+		time_diff = timespec_diff_us(time_start[cpu], time_end[cpu]);
 		max_frequency = tsc_diff / time_diff;
 	}
 
@@ -226,9 +226,8 @@ static int mperf_start(void)
 {
 	int cpu;
 
-	clock_gettime(CLOCK_REALTIME, &time_start);
-
 	for (cpu = 0; cpu < cpu_count; cpu++) {
+		clock_gettime(CLOCK_REALTIME, &time_start[cpu]);
 		mperf_get_tsc(&tsc_at_measure_start[cpu]);
 		mperf_init_stats(cpu);
 	}
@@ -243,9 +242,9 @@ static int mperf_stop(void)
 	for (cpu = 0; cpu < cpu_count; cpu++) {
 		mperf_measure_stats(cpu);
 		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
 	}
 
-	clock_gettime(CLOCK_REALTIME, &time_end);
 	return 0;
 }
 
@@ -349,6 +348,8 @@ struct cpuidle_monitor *mperf_register(void)
 	aperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
 	tsc_at_measure_start = calloc(cpu_count, sizeof(unsigned long long));
 	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
+	time_start = calloc(cpu_count, sizeof(struct timespec));
+	time_end = calloc(cpu_count, sizeof(struct timespec));
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
@@ -361,6 +362,8 @@ void mperf_unregister(void)
 	free(aperf_current_count);
 	free(tsc_at_measure_start);
 	free(tsc_at_measure_end);
+	free(time_start);
+	free(time_end);
 	free(is_valid);
 }
 
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 067717bce1d4..56c7ff6efcda 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -33,6 +33,9 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		msr0xXXX is a hex offset, eg. msr0x10
 		/sys/path... is an absolute path to a sysfs attribute
 		<device> is a perf device from /sys/bus/event_source/devices/<device> eg. cstate_core
+			On Intel hybrid platforms, instead of one "cpu" perf device there are two, "cpu_core" and "cpu_atom" devices for P and E cores respectively.
+			Turbostat, in this case, allow user to use "cpu" device and will automatically detect the type of a CPU and translate it to "cpu_core" and "cpu_atom" accordingly.
+			For a complete example see "ADD PERF COUNTER EXAMPLE #2 (using virtual "cpu" device)".
 		<event> is a perf event for given device from /sys/bus/event_source/devices/<device>/events/<event> eg. c1-residency
 			perf/cstate_core/c1-residency would then use /sys/bus/event_source/devices/cstate_core/events/c1-residency
 
@@ -387,6 +390,28 @@ CPU     pCPU%c1 CPU%c1
 
 .fi
 
+.SH ADD PERF COUNTER EXAMPLE #2 (using virtual cpu device)
+Here we run on hybrid, Raptor Lake platform.
+We limit turbostat to show output for just cpu0 (pcore) and cpu12 (ecore).
+We add a counter showing number of L3 cache misses, using virtual "cpu" device,
+labeling it with the column header, "VCMISS".
+We add a counter showing number of L3 cache misses, using virtual "cpu_core" device,
+labeling it with the column header, "PCMISS". This will fail on ecore cpu12.
+We add a counter showing number of L3 cache misses, using virtual "cpu_atom" device,
+labeling it with the column header, "ECMISS". This will fail on pcore cpu0.
+We display it only once, after the conclusion of 0.1 second sleep.
+.nf
+sudo ./turbostat --quiet --cpu 0,12 --show CPU --add perf/cpu/cache-misses,cpu,delta,raw,VCMISS --add perf/cpu_core/cache-misses,cpu,delta,raw,PCMISS --add perf/cpu_atom/cache-misses,cpu,delta,raw,ECMISS sleep .1
+turbostat: added_perf_counters_init_: perf/cpu_atom/cache-misses: failed to open counter on cpu0
+turbostat: added_perf_counters_init_: perf/cpu_core/cache-misses: failed to open counter on cpu12
+0.104630 sec
+CPU                 ECMISS                  PCMISS                  VCMISS
+-       0x0000000000000000      0x0000000000000000      0x0000000000000000
+0       0x0000000000000000      0x0000000000007951      0x0000000000007796
+12      0x000000000001137a      0x0000000000000000      0x0000000000011392
+
+.fi
+
 .SH ADD PMT COUNTER EXAMPLE
 Here we limit turbostat to showing just the CPU number 0.
 We add two counters, showing crystal clock count and the DC6 residency.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a5ebee8b23bb..235e82fe7d0a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -31,6 +31,9 @@
 )
 // end copied section
 
+#define CPUID_LEAF_MODEL_ID			0x1A
+#define CPUID_LEAF_MODEL_ID_CORE_TYPE_SHIFT	24
+
 #define X86_VENDOR_INTEL	0
 
 #include INTEL_FAMILY_HEADER
@@ -89,6 +92,11 @@
 #define PERF_DEV_NAME_BYTES 32
 #define PERF_EVT_NAME_BYTES 32
 
+#define INTEL_ECORE_TYPE	0x20
+#define INTEL_PCORE_TYPE	0x40
+
+#define ROUND_UP_TO_PAGE_SIZE(n) (((n) + 0x1000UL-1UL) & ~(0x1000UL-1UL))
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
@@ -1079,8 +1087,8 @@ int backwards_count;
 char *progname;
 
 #define CPU_SUBSET_MAXCPUS	1024	/* need to use before probe... */
-cpu_set_t *cpu_present_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
-size_t cpu_present_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
+cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
+size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
 #define MAX_ADDED_THREAD_COUNTERS 24
 #define MAX_ADDED_CORE_COUNTERS 8
 #define MAX_ADDED_PACKAGE_COUNTERS 16
@@ -1848,6 +1856,7 @@ struct cpu_topology {
 	int logical_node_id;	/* 0-based count within the package */
 	int physical_core_id;
 	int thread_id;
+	int type;
 	cpu_set_t *put_ids;	/* Processing Unit/Thread IDs */
 } *cpus;
 
@@ -5659,6 +5668,32 @@ int init_thread_id(int cpu)
 	return 0;
 }
 
+int set_my_cpu_type(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int max_level;
+
+	__cpuid(0, max_level, ebx, ecx, edx);
+
+	if (max_level < CPUID_LEAF_MODEL_ID)
+		return 0;
+
+	__cpuid(CPUID_LEAF_MODEL_ID, eax, ebx, ecx, edx);
+
+	return (eax >> CPUID_LEAF_MODEL_ID_CORE_TYPE_SHIFT);
+}
+
+int set_cpu_hybrid_type(int cpu)
+{
+	if (cpu_migrate(cpu))
+		return -1;
+
+	int type = set_my_cpu_type();
+
+	cpus[cpu].type = type;
+	return 0;
+}
+
 /*
  * snapshot_proc_interrupts()
  *
@@ -8188,6 +8223,33 @@ int dir_filter(const struct dirent *dirp)
 		return 0;
 }
 
+char *possible_file = "/sys/devices/system/cpu/possible";
+char possible_buf[1024];
+
+int initialize_cpu_possible_set(void)
+{
+	FILE *fp;
+
+	fp = fopen(possible_file, "r");
+	if (!fp) {
+		warn("open %s", possible_file);
+		return -1;
+	}
+	if (fread(possible_buf, sizeof(char), 1024, fp) == 0) {
+		warn("read %s", possible_file);
+		goto err;
+	}
+	if (parse_cpu_str(possible_buf, cpu_possible_set, cpu_possible_setsize)) {
+		warnx("%s: cpu str malformat %s\n", possible_file, cpu_effective_str);
+		goto err;
+	}
+	return 0;
+
+err:
+	fclose(fp);
+	return -1;
+}
+
 void topology_probe(bool startup)
 {
 	int i;
@@ -8219,6 +8281,16 @@ void topology_probe(bool startup)
 	CPU_ZERO_S(cpu_present_setsize, cpu_present_set);
 	for_all_proc_cpus(mark_cpu_present);
 
+	/*
+	 * Allocate and initialize cpu_possible_set
+	 */
+	cpu_possible_set = CPU_ALLOC((topo.max_cpu_num + 1));
+	if (cpu_possible_set == NULL)
+		err(3, "CPU_ALLOC");
+	cpu_possible_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
+	CPU_ZERO_S(cpu_possible_setsize, cpu_possible_set);
+	initialize_cpu_possible_set();
+
 	/*
 	 * Allocate and initialize cpu_effective_set
 	 */
@@ -8287,6 +8359,8 @@ void topology_probe(bool startup)
 
 	for_all_proc_cpus(init_thread_id);
 
+	for_all_proc_cpus(set_cpu_hybrid_type);
+
 	/*
 	 * For online cpus
 	 * find max_core_id, max_package_id
@@ -8551,6 +8625,35 @@ void check_perf_access(void)
 		bic_enabled &= ~BIC_IPC;
 }
 
+bool perf_has_hybrid_devices(void)
+{
+	/*
+	 *  0: unknown
+	 *  1: has separate perf device for p and e core
+	 * -1: doesn't have separate perf device for p and e core
+	 */
+	static int cached;
+
+	if (cached > 0)
+		return true;
+
+	if (cached < 0)
+		return false;
+
+	if (access("/sys/bus/event_source/devices/cpu_core", F_OK)) {
+		cached = -1;
+		return false;
+	}
+
+	if (access("/sys/bus/event_source/devices/cpu_atom", F_OK)) {
+		cached = -1;
+		return false;
+	}
+
+	cached = 1;
+	return true;
+}
+
 int added_perf_counters_init_(struct perf_counter_info *pinfo)
 {
 	size_t num_domains = 0;
@@ -8607,29 +8710,56 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 			if (domain_visited[next_domain])
 				continue;
 
-			perf_type = read_perf_type(pinfo->device);
+			/*
+			 * Intel hybrid platforms expose different perf devices for P and E cores.
+			 * Instead of one, "/sys/bus/event_source/devices/cpu" device, there are
+			 * "/sys/bus/event_source/devices/{cpu_core,cpu_atom}".
+			 *
+			 * This makes it more complicated to the user, because most of the counters
+			 * are available on both and have to be handled manually, otherwise.
+			 *
+			 * Code below, allow user to use the old "cpu" name, which is translated accordingly.
+			 */
+			const char *perf_device = pinfo->device;
+
+			if (strcmp(perf_device, "cpu") == 0 && perf_has_hybrid_devices()) {
+				switch (cpus[cpu].type) {
+				case INTEL_PCORE_TYPE:
+					perf_device = "cpu_core";
+					break;
+
+				case INTEL_ECORE_TYPE:
+					perf_device = "cpu_atom";
+					break;
+
+				default: /* Don't change, we will probably fail and report a problem soon. */
+					break;
+				}
+			}
+
+			perf_type = read_perf_type(perf_device);
 			if (perf_type == (unsigned int)-1) {
 				warnx("%s: perf/%s/%s: failed to read %s",
-				      __func__, pinfo->device, pinfo->event, "type");
+				      __func__, perf_device, pinfo->event, "type");
 				continue;
 			}
 
-			perf_config = read_perf_config(pinfo->device, pinfo->event);
+			perf_config = read_perf_config(perf_device, pinfo->event);
 			if (perf_config == (unsigned int)-1) {
 				warnx("%s: perf/%s/%s: failed to read %s",
-				      __func__, pinfo->device, pinfo->event, "config");
+				      __func__, perf_device, pinfo->event, "config");
 				continue;
 			}
 
 			/* Scale is not required, some counters just don't have it. */
-			perf_scale = read_perf_scale(pinfo->device, pinfo->event);
+			perf_scale = read_perf_scale(perf_device, pinfo->event);
 			if (perf_scale == 0.0)
 				perf_scale = 1.0;
 
 			fd_perf = open_perf_counter(cpu, perf_type, perf_config, -1, 0);
 			if (fd_perf == -1) {
 				warnx("%s: perf/%s/%s: failed to open counter on cpu%d",
-				      __func__, pinfo->device, pinfo->event, cpu);
+				      __func__, perf_device, pinfo->event, cpu);
 				continue;
 			}
 
@@ -8639,7 +8769,7 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 
 			if (debug)
 				fprintf(stderr, "Add perf/%s/%s cpu%d: %d\n",
-					pinfo->device, pinfo->event, cpu, pinfo->fd_perf_per_domain[next_domain]);
+					perf_device, pinfo->event, cpu, pinfo->fd_perf_per_domain[next_domain]);
 		}
 
 		pinfo = pinfo->next;
@@ -8762,7 +8892,7 @@ struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 		if (fd_pmt == -1)
 			goto loop_cleanup_and_break;
 
-		mmap_size = (size + 0x1000UL) & (~0x1000UL);
+		mmap_size = ROUND_UP_TO_PAGE_SIZE(size);
 		mmio = mmap(0, mmap_size, PROT_READ, MAP_SHARED, fd_pmt, 0);
 		if (mmio != MAP_FAILED) {
 
@@ -9001,6 +9131,18 @@ void turbostat_init()
 	}
 }
 
+void affinitize_child(void)
+{
+	/* Prefer cpu_possible_set, if available */
+	if (sched_setaffinity(0, cpu_possible_setsize, cpu_possible_set)) {
+		warn("sched_setaffinity cpu_possible_set");
+
+		/* Otherwise, allow child to run on same cpu set as turbostat */
+		if (sched_setaffinity(0, cpu_allowed_setsize, cpu_allowed_set))
+			warn("sched_setaffinity cpu_allowed_set");
+	}
+}
+
 int fork_it(char **argv)
 {
 	pid_t child_pid;
@@ -9016,6 +9158,7 @@ int fork_it(char **argv)
 	child_pid = fork();
 	if (!child_pid) {
 		/* child */
+		affinitize_child();
 		execvp(argv[0], argv);
 		err(errno, "exec %s", argv[0]);
 	} else {
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index dacad94e2be4..c76ad0be54e2 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2419,6 +2419,11 @@ sub get_version {
     return if ($have_version);
     doprint "$make kernelrelease ... ";
     $version = `$make -s kernelrelease | tail -1`;
+    if (!length($version)) {
+	run_command "$make allnoconfig" or return 0;
+	doprint "$make kernelrelease ... ";
+	$version = `$make -s kernelrelease | tail -1`;
+    }
     chomp($version);
     doprint "$version\n";
     $have_version = 1;
@@ -2960,8 +2965,6 @@ sub run_bisect_test {
 
     my $failed = 0;
     my $result;
-    my $output;
-    my $ret;
 
     $in_bisect = 1;
 
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 43a029318478..6fc29996ae29 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -193,9 +193,9 @@ ifeq ($(shell expr $(MAKE_VERSION) \>= 4.4), 1)
 $(let OUTPUT,$(OUTPUT)/,\
 	$(eval include ../../../build/Makefile.feature))
 else
-OUTPUT := $(OUTPUT)/
+override OUTPUT := $(OUTPUT)/
 $(eval include ../../../build/Makefile.feature)
-OUTPUT := $(patsubst %/,%,$(OUTPUT))
+override OUTPUT := $(patsubst %/,%,$(OUTPUT))
 endif
 endif
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index ca84726d5ac1..b72b966df77b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -385,7 +385,7 @@ static void test_distilled_base_missing_err(void)
 		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED");
 	btf5 = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
-		return;
+		goto cleanup;
 	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
 	VALIDATE_RAW_BTF(
 		btf5,
@@ -478,7 +478,7 @@ static void test_distilled_base_multi_err2(void)
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
 	btf5 = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
-		return;
+		goto cleanup;
 	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
 	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [2] int */
 	VALIDATE_RAW_BTF(
diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index d50cbd8040d4..e59af2aa6601 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -171,6 +171,10 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 		/* See also arch_adjust_kprobe_addr(). */
 		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
 			entry_offset = 4;
+		if (skel->kconfig->CONFIG_PPC64 &&
+		    skel->kconfig->CONFIG_KPROBES_ON_FTRACE &&
+		    !skel->kconfig->CONFIG_PPC_FTRACE_OUT_OF_LINE)
+			entry_offset = 4;
 		err = verify_perf_link_info(link_fd, type, kprobe_addr, 0, entry_offset);
 		ASSERT_OK(err, "verify_perf_link_info");
 	} else {
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 21c5a37846ad..40f22454cf05 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1496,8 +1496,8 @@ static void test_tailcall_bpf2bpf_hierarchy_3(void)
 	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
 }
 
-/* test_tailcall_freplace checks that the attached freplace prog is OK to
- * update the prog_array map.
+/* test_tailcall_freplace checks that the freplace prog fails to update the
+ * prog_array map, no matter whether the freplace prog attaches to its target.
  */
 static void test_tailcall_freplace(void)
 {
@@ -1505,7 +1505,7 @@ static void test_tailcall_freplace(void)
 	struct bpf_link *freplace_link = NULL;
 	struct bpf_program *freplace_prog;
 	struct tc_bpf2bpf *tc_skel = NULL;
-	int prog_fd, map_fd;
+	int prog_fd, tc_prog_fd, map_fd;
 	char buff[128] = {};
 	int err, key;
 
@@ -1523,9 +1523,10 @@ static void test_tailcall_freplace(void)
 	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
 		goto out;
 
-	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	tc_prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
 	freplace_prog = freplace_skel->progs.entry_freplace;
-	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
+	err = bpf_program__set_attach_target(freplace_prog, tc_prog_fd,
+					     "subprog_tc");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
 
@@ -1533,27 +1534,116 @@ static void test_tailcall_freplace(void)
 	if (!ASSERT_OK(err, "tailcall_freplace__load"))
 		goto out;
 
-	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
-						     "subprog");
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	prog_fd = bpf_program__fd(freplace_prog);
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update jmp_table failure");
+
+	freplace_link = bpf_program__attach_freplace(freplace_prog, tc_prog_fd,
+						     "subprog_tc");
 	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
 		goto out;
 
-	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
-	prog_fd = bpf_program__fd(freplace_prog);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update jmp_table failure");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
+/* test_tailcall_bpf2bpf_freplace checks the failure that fails to attach a tail
+ * callee prog with freplace prog or fails to update an extended prog to
+ * prog_array map.
+ */
+static void test_tailcall_bpf2bpf_freplace(void)
+{
+	struct tailcall_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	char buff[128] = {};
+	int prog_fd, map_fd;
+	int err, key;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	freplace_skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     prog_fd, "subprog_tc");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_freplace__load"))
+		goto out;
+
+	/* OK to attach then detach freplace prog. */
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_link__destroy(freplace_link);
+	if (!ASSERT_OK(err, "destroy link"))
+		goto out;
+
+	/* OK to update prog_array map then delete element from the map. */
+
 	key = 0;
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
 	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
 	if (!ASSERT_OK(err, "update jmp_table"))
 		goto out;
 
-	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
-	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 34, "test_run retval");
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	/* Fail to attach a tail callee prog with freplace prog. */
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace failure"))
+		goto out;
+
+	err = bpf_map_delete_elem(map_fd, &key);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	/* Fail to update an extended prog to prog_array map. */
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "update jmp_table failure"))
+		goto out;
 
 out:
 	bpf_link__destroy(freplace_link);
-	tc_bpf2bpf__destroy(tc_skel);
 	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
 }
 
 void test_tailcalls(void)
@@ -1606,4 +1696,6 @@ void test_tailcalls(void)
 	test_tailcall_bpf2bpf_hierarchy_3();
 	if (test__start_subtest("tailcall_freplace"))
 		test_tailcall_freplace();
+	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
+		test_tailcall_bpf2bpf_freplace();
 }
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index 79f5087dade2..fe6249d99b31 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -5,10 +5,11 @@
 #include "bpf_misc.h"
 
 __noinline
-int subprog(struct __sk_buff *skb)
+int subprog_tc(struct __sk_buff *skb)
 {
 	int ret = 1;
 
+	__sink(skb);
 	__sink(ret);
 	/* let verifier know that 'subprog_tc' can change pointers to skb->data */
 	bpf_skb_change_proto(skb, 0, 0);
@@ -18,7 +19,7 @@ int subprog(struct __sk_buff *skb)
 SEC("tc")
 int entry_tc(struct __sk_buff *skb)
 {
-	return subprog(skb);
+	return subprog_tc(skb);
 }
 
 char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 6afa834756e9..fac33a14f200 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -6,13 +6,20 @@
 #include <stdbool.h>
 
 extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+extern bool CONFIG_PPC_FTRACE_OUT_OF_LINE __kconfig __weak;
+extern bool CONFIG_KPROBES_ON_FTRACE __kconfig __weak;
+extern bool CONFIG_PPC64 __kconfig __weak;
 
-/* This function is here to have CONFIG_X86_KERNEL_IBT
- * used and added to object BTF.
+/* This function is here to have CONFIG_X86_KERNEL_IBT,
+ * CONFIG_PPC_FTRACE_OUT_OF_LINE, CONFIG_KPROBES_ON_FTRACE,
+ * CONFIG_PPC6 used and added to object BTF.
  */
 int unused(void)
 {
-	return CONFIG_X86_KERNEL_IBT ? 0 : 1;
+	return CONFIG_X86_KERNEL_IBT ||
+			CONFIG_PPC_FTRACE_OUT_OF_LINE ||
+			CONFIG_KPROBES_ON_FTRACE ||
+			CONFIG_PPC64 ? 0 : 1;
 }
 
 SEC("kprobe")
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 7989ec608454..cb55a908bb0d 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -305,6 +305,7 @@ else
 	client_connect
 	verify_data
 	server_listen
+	wait_for_port ${port} ${netcat_opt}
 fi
 
 # serverside, use BPF for decap
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797..ad6c08dfd6c8 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -79,7 +79,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XSK_UMEM__DEFAULT_FLAGS,
+		.flags = XDP_UMEM_TX_METADATA_LEN,
 		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx = 0;
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 384cfa3d38a6..92c2f0376c08 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -142,7 +142,7 @@ function pre_ethtool {
 }
 
 function check_table {
-    local path=$NSIM_DEV_DFS/ports/$port/udp_ports_table$1
+    local path=$NSIM_DEV_DFS/ports/$port/udp_ports/table$1
     local -n expected=$2
     local last=$3
 
@@ -212,7 +212,7 @@ function check_tables {
 }
 
 function print_table {
-    local path=$NSIM_DEV_DFS/ports/$port/udp_ports_table$1
+    local path=$NSIM_DEV_DFS/ports/$port/udp_ports/table$1
     read -a have < $path
 
     tree $NSIM_DEV_DFS/
@@ -641,7 +641,7 @@ for port in 0 1; do
     NSIM_NETDEV=`get_netdev_name old_netdevs`
     ip link set dev $NSIM_NETDEV up
 
-    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
+    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
 
     msg="1 - create VxLANs v6"
     exp0=( 0 0 0 0 )
@@ -663,7 +663,7 @@ for port in 0 1; do
     new_geneve gnv0 20000
 
     msg="2 - destroy GENEVE"
-    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
+    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
     exp1=( `mke 20000 2` 0 0 0 )
     del_dev gnv0
 
@@ -764,7 +764,7 @@ for port in 0 1; do
     msg="create VxLANs v4"
     new_vxlan vxlan0 10000 $NSIM_NETDEV
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="NIC device goes down"
@@ -775,7 +775,7 @@ for port in 0 1; do
     fi
     check_tables
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="NIC device goes up again"
@@ -789,7 +789,7 @@ for port in 0 1; do
     del_dev vxlan0
     check_tables
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="destroy NIC"
@@ -896,7 +896,7 @@ msg="vacate VxLAN in overflow table"
 exp0=( `mke 10000 1` `mke 10004 1` 0 `mke 10003 1` )
 del_dev vxlan2
 
-echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
 check_tables
 
 msg="tunnels destroyed 2"
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
index 35e8d47d6072..8a7ce647a60d 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
@@ -15,11 +15,11 @@ find_alternate_gid() {
 	tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: -f3
 }
 
-mount_tracefs_with_options() {
+remount_tracefs_with_options() {
 	local mount_point="$1"
 	local options="$2"
 
-	mount -t tracefs -o "$options" nodev "$mount_point"
+	mount -t tracefs -o "remount,$options" nodev "$mount_point"
 
 	setup
 }
@@ -81,7 +81,7 @@ test_gid_mount_option() {
 
 	# Unmount existing tracefs instance and mount with new GID
 	unmount_tracefs "$mount_point"
-	mount_tracefs_with_options "$mount_point" "$new_options"
+	remount_tracefs_with_options "$mount_point" "$new_options"
 
 	check_gid "$mount_point" "$other_group"
 
@@ -92,7 +92,7 @@ test_gid_mount_option() {
 
 	# Unmount and remount with the original GID
 	unmount_tracefs "$mount_point"
-	mount_tracefs_with_options "$mount_point" "$mount_options"
+	remount_tracefs_with_options "$mount_point" "$mount_options"
 	check_gid "$mount_point" "$original_group"
 }
 
diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..14e7f3ec3f84 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -40,7 +40,7 @@ ktap_skip_all() {
 __ktap_test() {
 	result="$1"
 	description="$2"
-	directive="$3" # optional
+	directive="${3:-}" # optional
 
 	local directive_str=
 	[ ! -z "$directive" ] && directive_str="# $directive"
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index a5a72415e37b..666c9fde76da 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -760,33 +760,33 @@
 		/* Report with actual signedness to avoid weird output. */ \
 		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
 		case 0: { \
-			unsigned long long __exp_print = (uintptr_t)__exp; \
-			unsigned long long __seen_print = (uintptr_t)__seen; \
-			__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
+			uintmax_t __exp_print = (uintmax_t)__exp; \
+			uintmax_t __seen_print = (uintmax_t)__seen; \
+			__TH_LOG("Expected %s (%ju) %s %s (%ju)", \
 				 _expected_str, __exp_print, #_t, \
 				 _seen_str, __seen_print); \
 			break; \
 			} \
 		case 1: { \
-			unsigned long long __exp_print = (uintptr_t)__exp; \
-			long long __seen_print = (intptr_t)__seen; \
-			__TH_LOG("Expected %s (%llu) %s %s (%lld)", \
+			uintmax_t __exp_print = (uintmax_t)__exp; \
+			intmax_t  __seen_print = (intmax_t)__seen; \
+			__TH_LOG("Expected %s (%ju) %s %s (%jd)", \
 				 _expected_str, __exp_print, #_t, \
 				 _seen_str, __seen_print); \
 			break; \
 			} \
 		case 2: { \
-			long long __exp_print = (intptr_t)__exp; \
-			unsigned long long __seen_print = (uintptr_t)__seen; \
-			__TH_LOG("Expected %s (%lld) %s %s (%llu)", \
+			intmax_t  __exp_print = (intmax_t)__exp; \
+			uintmax_t __seen_print = (uintmax_t)__seen; \
+			__TH_LOG("Expected %s (%jd) %s %s (%ju)", \
 				 _expected_str, __exp_print, #_t, \
 				 _seen_str, __seen_print); \
 			break; \
 			} \
 		case 3: { \
-			long long __exp_print = (intptr_t)__exp; \
-			long long __seen_print = (intptr_t)__seen; \
-			__TH_LOG("Expected %s (%lld) %s %s (%lld)", \
+			intmax_t  __exp_print = (intmax_t)__exp; \
+			intmax_t  __seen_print = (intmax_t)__seen; \
+			__TH_LOG("Expected %s (%jd) %s %s (%jd)", \
 				 _expected_str, __exp_print, #_t, \
 				 _seen_str, __seen_print); \
 			break; \
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 348e2dbdb4e0..480f13e77fcc 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
 TEST_GEN_PROGS_EXTENDED := true
 
 # Short targets:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
 
 include ../lib.mk
 
 # Targets with $(OUTPUT)/ prefix:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6788762188fe..97d360eae4f6 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2003,8 +2003,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	ASSERT_EQ(1, WIFEXITED(status));
 	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
 	{
-		TH_LOG("Unexpected return code for \"%s\": %s", path,
-		       strerror(errno));
+		TH_LOG("Unexpected return code for \"%s\"", path);
 	};
 }
 
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 82c3264b115e..704b88b6a8d2 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../../
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 5d796622e730..580610c46e5a 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 
 top_srcdir = ../../../../..
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
diff --git a/tools/testing/selftests/net/openvswitch/Makefile b/tools/testing/selftests/net/openvswitch/Makefile
index 2f1508abc826..3fd1da2ec07d 100644
--- a/tools/testing/selftests/net/openvswitch/Makefile
+++ b/tools/testing/selftests/net/openvswitch/Makefile
@@ -2,7 +2,7 @@
 
 top_srcdir = ../../../../..
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := openvswitch.sh
 
diff --git a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
index 580fcac0a09f..b71ef8a493ed 100644
--- a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
+++ b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
@@ -20,7 +20,7 @@ static int test_gettimeofday(void)
 		gettimeofday(&tv_end, NULL);
 	}
 
-	timersub(&tv_start, &tv_end, &tv_diff);
+	timersub(&tv_end, &tv_start, &tv_diff);
 
 	printf("time = %.6f\n", tv_diff.tv_sec + (tv_diff.tv_usec) * 1e-6);
 
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 5b9772cdf265..f6156790c3b4 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -61,7 +61,6 @@ unsigned int rseq_size = -1U;
 unsigned int rseq_flags;
 
 static int rseq_ownership;
-static int rseq_reg_success;	/* At least one rseq registration has succeded. */
 
 /* Allocate a large area for the TLS. */
 #define RSEQ_THREAD_AREA_ALLOC_SIZE	1024
@@ -152,14 +151,27 @@ int rseq_register_current_thread(void)
 	}
 	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
-		if (RSEQ_READ_ONCE(rseq_reg_success)) {
+		/*
+		 * After at least one thread has registered successfully
+		 * (rseq_size > 0), the registration of other threads should
+		 * never fail.
+		 */
+		if (RSEQ_READ_ONCE(rseq_size) > 0) {
 			/* Incoherent success/failure within process. */
 			abort();
 		}
 		return -1;
 	}
 	assert(rseq_current_cpu_raw() >= 0);
-	RSEQ_WRITE_ONCE(rseq_reg_success, 1);
+
+	/*
+	 * The first thread to register sets the rseq_size to mimic the libc
+	 * behavior.
+	 */
+	if (RSEQ_READ_ONCE(rseq_size) == 0) {
+		RSEQ_WRITE_ONCE(rseq_size, get_rseq_kernel_feature_size());
+	}
+
 	return 0;
 }
 
@@ -235,12 +247,18 @@ void rseq_init(void)
 		return;
 	}
 	rseq_ownership = 1;
-	if (!rseq_available()) {
-		rseq_size = 0;
-		return;
-	}
+
+	/* Calculate the offset of the rseq area from the thread pointer. */
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+
+	/* rseq flags are deprecated, always set to 0. */
 	rseq_flags = 0;
+
+	/*
+	 * Set the size to 0 until at least one thread registers to mimic the
+	 * libc behavior.
+	 */
+	rseq_size = 0;
 }
 
 static __attribute__((destructor))
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 4e217b620e0c..062d10925a10 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -60,7 +60,14 @@
 extern ptrdiff_t rseq_offset;
 
 /*
- * Size of the registered rseq area. 0 if the registration was
+ * The rseq ABI is composed of extensible feature fields. The extensions
+ * are done by appending additional fields at the end of the structure.
+ * The rseq_size defines the size of the active feature set which can be
+ * used by the application for the current rseq registration. Features
+ * starting at offset >= rseq_size are inactive and should not be used.
+ *
+ * The rseq_size is the intersection between the available allocation
+ * size for the rseq area and the feature size supported by the kernel.
  * unsuccessful.
  */
 extern unsigned int rseq_size;
diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index c5264594064c..83faa4e354e3 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -156,8 +156,8 @@ int main(int argc, char **argv)
 	/* Check everything is sane before we start switching asynchronously */
 	if (do_sanity_check) {
 		for (i = 0; i < count; i++) {
-			printf("Validating clocksource %s\n",
-				clocksource_list[i]);
+			ksft_print_msg("Validating clocksource %s\n",
+					clocksource_list[i]);
 			if (change_clocksource(clocksource_list[i])) {
 				status = -1;
 				goto out;
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("Running Asynchronous Switching Tests...\n");
+	ksft_print_msg("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
 		return run_tests(runtime);

