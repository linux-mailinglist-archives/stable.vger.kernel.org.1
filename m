Return-Path: <stable+bounces-154809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B31AE07CF
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586793B2B45
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13148270EBC;
	Thu, 19 Jun 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zkt8sk+5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704D28B418;
	Thu, 19 Jun 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341053; cv=none; b=axJrWAA8KLssN0x3msVcYc0GnXUnCx165zjlEU8i5tedtIfjYfavZ4w+XGzJ2dS5zB83vMuyF1hhA0BRW4eGxi5ClukHlIVcpq0CupfLy8cuKvEwJI5ogOmwVrzyOHJqUPgRxm3lmVsYPB0pjxGFDdsbrhW1KzXn/87TtWEpoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341053; c=relaxed/simple;
	bh=PfU7Cb+HNaXrlzL1PsnQW7oz+owj/ul3Vy38gYJ4ovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrPjZxqM1XAh9XcJaXVJvFkdNWHB/HXdQVXUwcJUffhN2d03Iw+T2VSB1ekpV1Yn2HivAQIyOIqG5tNBylypmOxDrBg44qfJ2YTDaHsj2QW7BOImJhNNL+QVxyFnKT109daEtmfUVirYSjkp6gUxcHkiAu037F6QhJZHSwxLwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zkt8sk+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54F9C4CEEF;
	Thu, 19 Jun 2025 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750341052;
	bh=PfU7Cb+HNaXrlzL1PsnQW7oz+owj/ul3Vy38gYJ4ovc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zkt8sk+59xtbUtXttJ9h73pVLjTEqEpaxbFykVIQLaaVhObdsqtWSLOVzVBb+AXXg
	 z15fsvSsY+c/6NHva4OHN6WIV8YLMbhBuw//enWdG0mqD95GEfxPbvUjdAF3gidRLT
	 FofrXg+SvSwQ/tWwlt+daQjxjMhbfp9m735c+SFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.34
Date: Thu, 19 Jun 2025 15:50:37 +0200
Message-ID: <2025061936-harness-jellied-5841@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025061936-unaltered-document-bd7e@gregkh>
References: <2025061936-unaltered-document-bd7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index ec6115d3796b..5575c58357d6 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -27,22 +27,31 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 2
+    const: 3
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: ext
 
 required:
   - reg
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
 examples:
   - |
     pwm@44b00000 {
-       compatible = "adi,axi-pwmgen-2.00.a";
-       reg = <0x44b00000 0x1000>;
-       clocks = <&spi_clk>;
-       #pwm-cells = <2>;
+        compatible = "adi,axi-pwmgen-2.00.a";
+        reg = <0x44b00000 0x1000>;
+        clocks = <&fpga_clk>, <&spi_clk>;
+        clock-names = "axi", "ext";
+        #pwm-cells = <3>;
     };
diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
index 119de3d7f9dd..44548a9da158 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
@@ -35,8 +35,8 @@ additionalProperties: false
 examples:
   - |
     pwm: pwm@f0408000 {
-       compatible = "brcm,bcm7038-pwm";
-       reg = <0xf0408000 0x28>;
-       #pwm-cells = <2>;
-       clocks = <&upg_fixed>;
+        compatible = "brcm,bcm7038-pwm";
+        reg = <0xf0408000 0x28>;
+        #pwm-cells = <2>;
+        clocks = <&upg_fixed>;
     };
diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
index e86c8053b366..fd785da5d3d7 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
@@ -43,9 +43,9 @@ examples:
     #include <dt-bindings/clock/bcm281xx.h>
 
     pwm@3e01a000 {
-       compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
-       reg = <0x3e01a000 0xcc>;
-       clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
-       #pwm-cells = <3>;
+        compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+        reg = <0x3e01a000 0xcc>;
+        clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
+        #pwm-cells = <3>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
index 6327bb2f6ee0..698266c09e25 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
@@ -33,7 +33,7 @@ patternProperties:
 
   "^ldo-v(camio18|aud28|aux18|io18|io28|rf12|rf18|cn18|cn28|fe28)$":
     type: object
-    $ref: fixed-regulator.yaml#
+    $ref: regulator.yaml#
     unevaluatedProperties: false
     description:
       Properties for single fixed LDO regulator.
@@ -112,7 +112,6 @@ examples:
           regulator-enable-ramp-delay = <220>;
         };
         mt6357_vfe28_reg: ldo-vfe28 {
-          compatible = "regulator-fixed";
           regulator-name = "vfe28";
           regulator-min-microvolt = <2800000>;
           regulator-max-microvolt = <2800000>;
@@ -125,14 +124,12 @@ examples:
           regulator-enable-ramp-delay = <110>;
         };
         mt6357_vrf18_reg: ldo-vrf18 {
-          compatible = "regulator-fixed";
           regulator-name = "vrf18";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <1800000>;
           regulator-enable-ramp-delay = <110>;
         };
         mt6357_vrf12_reg: ldo-vrf12 {
-          compatible = "regulator-fixed";
           regulator-name = "vrf12";
           regulator-min-microvolt = <1200000>;
           regulator-max-microvolt = <1200000>;
@@ -157,14 +154,12 @@ examples:
           regulator-enable-ramp-delay = <264>;
         };
         mt6357_vcn28_reg: ldo-vcn28 {
-          compatible = "regulator-fixed";
           regulator-name = "vcn28";
           regulator-min-microvolt = <2800000>;
           regulator-max-microvolt = <2800000>;
           regulator-enable-ramp-delay = <264>;
         };
         mt6357_vcn18_reg: ldo-vcn18 {
-          compatible = "regulator-fixed";
           regulator-name = "vcn18";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <1800000>;
@@ -183,7 +178,6 @@ examples:
           regulator-enable-ramp-delay = <264>;
         };
         mt6357_vcamio_reg: ldo-vcamio18 {
-          compatible = "regulator-fixed";
           regulator-name = "vcamio";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <1800000>;
@@ -212,28 +206,24 @@ examples:
           regulator-always-on;
         };
         mt6357_vaux18_reg: ldo-vaux18 {
-          compatible = "regulator-fixed";
           regulator-name = "vaux18";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <1800000>;
           regulator-enable-ramp-delay = <264>;
         };
         mt6357_vaud28_reg: ldo-vaud28 {
-          compatible = "regulator-fixed";
           regulator-name = "vaud28";
           regulator-min-microvolt = <2800000>;
           regulator-max-microvolt = <2800000>;
           regulator-enable-ramp-delay = <264>;
         };
         mt6357_vio28_reg: ldo-vio28 {
-          compatible = "regulator-fixed";
           regulator-name = "vio28";
           regulator-min-microvolt = <2800000>;
           regulator-max-microvolt = <2800000>;
           regulator-enable-ramp-delay = <264>;
         };
         mt6357_vio18_reg: ldo-vio18 {
-          compatible = "regulator-fixed";
           regulator-name = "vio18";
           regulator-min-microvolt = <1800000>;
           regulator-max-microvolt = <1800000>;
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
index de0b4ae740ff..a975bce59975 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
@@ -50,7 +50,7 @@ required:
   - compatible
 
 allOf:
-  - $ref: reserved-memory.yaml
+  - $ref: /schemas/reserved-memory/reserved-memory.yaml
 
 unevaluatedProperties: false
 
@@ -61,7 +61,7 @@ examples:
         #size-cells = <2>;
 
         qman-fqd {
-            compatible = "shared-dma-pool";
+            compatible = "fsl,qman-fqd";
             size = <0 0x400000>;
             alignment = <0 0x400000>;
             no-map;
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 71a1a399e1e1..af9a8d43b247 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -846,6 +846,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^liontron,.*":
+    description: Shenzhen Liontron Technology Co., Ltd
   "^liteon,.*":
     description: LITE-ON Technology Corp.
   "^litex,.*":
diff --git a/Documentation/gpu/xe/index.rst b/Documentation/gpu/xe/index.rst
index 3f07aa3b5432..89bbdcccf8eb 100644
--- a/Documentation/gpu/xe/index.rst
+++ b/Documentation/gpu/xe/index.rst
@@ -16,6 +16,7 @@ DG2, etc is provided to prototype the driver.
    xe_migrate
    xe_cs
    xe_pm
+   xe_gt_freq
    xe_pcode
    xe_gt_mcr
    xe_wa
diff --git a/Documentation/gpu/xe/xe_gt_freq.rst b/Documentation/gpu/xe/xe_gt_freq.rst
new file mode 100644
index 000000000000..c0811200e327
--- /dev/null
+++ b/Documentation/gpu/xe/xe_gt_freq.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+==========================
+Xe GT Frequency Management
+==========================
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_gt_freq.c
+   :doc: Xe GT Frequency Management
+
+Internal API
+============
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_gt_freq.c
+   :internal:
diff --git a/Makefile b/Makefile
index c53dd3520193..b58a061cb359 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 33
+SUBLEVEL = 34
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index ce8baff6a9f4..e42e1a75a715 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -152,7 +152,7 @@ nand_controller: nand-controller {
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/microchip/tny_a9263.dts b/arch/arm/boot/dts/microchip/tny_a9263.dts
index 62b7d9f9a926..c8b6318aaa83 100644
--- a/arch/arm/boot/dts/microchip/tny_a9263.dts
+++ b/arch/arm/boot/dts/microchip/tny_a9263.dts
@@ -64,7 +64,7 @@ nand_controller: nand-controller {
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/microchip/usb_a9263.dts b/arch/arm/boot/dts/microchip/usb_a9263.dts
index 45745915b2e1..454176ce6d3f 100644
--- a/arch/arm/boot/dts/microchip/usb_a9263.dts
+++ b/arch/arm/boot/dts/microchip/usb_a9263.dts
@@ -58,7 +58,7 @@ usb1: gadget@fff78000 {
 			};
 
 			spi0: spi@fffa4000 {
-				cs-gpios = <&pioB 15 GPIO_ACTIVE_HIGH>;
+				cs-gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 				status = "okay";
 				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
@@ -84,7 +84,7 @@ nand_controller: nand-controller {
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index ac7494ed633e..be87c396f05f 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -213,12 +213,6 @@ sleep_clk: sleep_clk {
 		};
 	};
 
-	sfpb_mutex: hwmutex {
-		compatible = "qcom,sfpb-mutex";
-		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
-		#hwlock-cells = <1>;
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
@@ -284,6 +278,40 @@ scm {
 		};
 	};
 
+	replicator {
+		compatible = "arm,coresight-static-replicator";
+
+		clocks = <&rpmcc RPM_QDSS_CLK>;
+		clock-names = "apb_pclk";
+
+		in-ports {
+			port {
+				replicator_in: endpoint {
+					remote-endpoint = <&funnel_out>;
+				};
+			};
+		};
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				replicator_out0: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				replicator_out1: endpoint {
+					remote-endpoint = <&tpiu_in>;
+				};
+			};
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -305,9 +333,10 @@ tlmm_pinmux: pinctrl@800000 {
 			pinctrl-0 = <&ps_hold_default_state>;
 		};
 
-		sfpb_wrapper_mutex: syscon@1200000 {
-			compatible = "syscon";
-			reg = <0x01200000 0x8000>;
+		sfpb_mutex: hwmutex@1200600 {
+			compatible = "qcom,sfpb-mutex";
+			reg = <0x01200600 0x100>;
+			#hwlock-cells = <1>;
 		};
 
 		intc: interrupt-controller@2000000 {
@@ -326,6 +355,8 @@ timer@200a000 {
 				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <27000000>;
+			clocks = <&sleep_clk>;
+			clock-names = "sleep";
 			cpu-offset = <0x80000>;
 		};
 
@@ -1532,39 +1563,6 @@ tpiu_in: endpoint {
 			};
 		};
 
-		replicator {
-			compatible = "arm,coresight-static-replicator";
-
-			clocks = <&rpmcc RPM_QDSS_CLK>;
-			clock-names = "apb_pclk";
-
-			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					replicator_out0: endpoint {
-						remote-endpoint = <&etb_in>;
-					};
-				};
-				port@1 {
-					reg = <1>;
-					replicator_out1: endpoint {
-						remote-endpoint = <&tpiu_in>;
-					};
-				};
-			};
-
-			in-ports {
-				port {
-					replicator_in: endpoint {
-						remote-endpoint = <&funnel_out>;
-					};
-				};
-			};
-		};
-
 		funnel@1a04000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x1a04000 0x1000>;
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 080019aa6fcd..fcf287edd0e5 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -2,7 +2,6 @@
 menuconfig ARCH_ASPEED
 	bool "Aspeed BMC architectures"
 	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V6 || ARCH_MULTI_V7
-	select SRAM
 	select WATCHDOG
 	select ASPEED_WATCHDOG
 	select MFD_SYSCON
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a11a7a42edbf..7887d18cce3e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -322,9 +322,9 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 24 if ARM64_VA_BITS=39
 	default 27 if ARM64_VA_BITS=42
 	default 30 if ARM64_VA_BITS=47
-	default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
-	default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
-	default 33 if ARM64_VA_BITS=48
+	default 29 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
+	default 31 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
+	default 33 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
 	default 14 if ARM64_64K_PAGES
 	default 16 if ARM64_16K_PAGES
 	default 18
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
index 97ff1ddd6318..734a75198f06 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
@@ -124,6 +124,7 @@ &sai5 {
 	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
 	assigned-clock-rates = <24576000>;
 	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 62ed64663f49..9ba0cb89fa24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -233,6 +233,7 @@ eeprom@50 {
 	rtc: rtc@51 {
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
index 1df5ceb11387..37fc5ed98d7f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
@@ -124,6 +124,7 @@ &sai5 {
 	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
 	assigned-clock-rates = <24576000>;
 	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
index 2a64115eebf1..bb11590473a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -242,6 +242,7 @@ eeprom@50 {
 	rtc: rtc@51 {
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index 15f7ab58db36..88561df70d03 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -257,6 +257,7 @@ eeprom@50 {
 	rtc: rtc@51 {
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
index 5fafa842d312..dca4e5c3d8e2 100644
--- a/arch/arm64/boot/dts/mediatek/mt6357.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
@@ -60,7 +60,6 @@ mt6357_vpa_reg: buck-vpa {
 			};
 
 			mt6357_vfe28_reg: ldo-vfe28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vfe28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -75,7 +74,6 @@ mt6357_vxo22_reg: ldo-vxo22 {
 			};
 
 			mt6357_vrf18_reg: ldo-vrf18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vrf18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -83,7 +81,6 @@ mt6357_vrf18_reg: ldo-vrf18 {
 			};
 
 			mt6357_vrf12_reg: ldo-vrf12 {
-				compatible = "regulator-fixed";
 				regulator-name = "vrf12";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
@@ -112,7 +109,6 @@ mt6357_vcn33_wifi_reg: ldo-vcn33-wifi {
 			};
 
 			mt6357_vcn28_reg: ldo-vcn28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vcn28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -120,7 +116,6 @@ mt6357_vcn28_reg: ldo-vcn28 {
 			};
 
 			mt6357_vcn18_reg: ldo-vcn18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vcn18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -142,7 +137,6 @@ mt6357_vcamd_reg: ldo-vcamd {
 			};
 
 			mt6357_vcamio_reg: ldo-vcamio18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -175,7 +169,6 @@ mt6357_vsram_proc_reg: ldo-vsram-proc {
 			};
 
 			mt6357_vaux18_reg: ldo-vaux18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vaux18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -183,7 +176,6 @@ mt6357_vaux18_reg: ldo-vaux18 {
 			};
 
 			mt6357_vaud28_reg: ldo-vaud28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vaud28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -191,7 +183,6 @@ mt6357_vaud28_reg: ldo-vaud28 {
 			};
 
 			mt6357_vio28_reg: ldo-vio28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vio28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -199,7 +190,6 @@ mt6357_vio28_reg: ldo-vio28 {
 			};
 
 			mt6357_vio18_reg: ldo-vio18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 8e1b8c85c6ed..779d6dfb55c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -18,6 +18,8 @@ mt6359codec: mt6359codec {
 		};
 
 		regulators {
+			compatible = "mediatek,mt6359-regulator";
+
 			mt6359_vs1_buck_reg: buck_vs1 {
 				regulator-name = "vs1";
 				regulator-min-microvolt = <800000>;
@@ -296,7 +298,7 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 			};
 		};
 
-		mt6359rtc: mt6359rtc {
+		mt6359rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 22924f61ec9e..c4fafd51b122 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -280,14 +280,10 @@ panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port {
-			dsi_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-	};
+&dsi_out {
+	remote-endpoint = <&panel_in>;
 };
 
 &gic {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 92c41463d10e..65be2c2c26d4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1836,6 +1836,10 @@ dsi0: dsi@14014000 {
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
 			status = "disabled";
+
+			port {
+				dsi_out: endpoint { };
+			};
 		};
 
 		dpi0: dpi@14015000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index f013dbad9dc4..2e138b54f556 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -617,22 +617,6 @@ power-domain@MT8195_POWER_DOMAIN_VPPSYS0 {
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
-					power-domain@MT8195_POWER_DOMAIN_VDEC1 {
-						reg = <MT8195_POWER_DOMAIN_VDEC1>;
-						clocks = <&vdecsys CLK_VDEC_LARB1>;
-						clock-names = "vdec1-0";
-						mediatek,infracfg = <&infracfg_ao>;
-						#power-domain-cells = <0>;
-					};
-
-					power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
-						reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
-						clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>;
-						clock-names = "venc1-larb";
-						mediatek,infracfg = <&infracfg_ao>;
-						#power-domain-cells = <0>;
-					};
-
 					power-domain@MT8195_POWER_DOMAIN_VDOSYS0 {
 						reg = <MT8195_POWER_DOMAIN_VDOSYS0>;
 						clocks = <&topckgen CLK_TOP_CFG_VDO0>,
@@ -678,15 +662,25 @@ power-domain@MT8195_POWER_DOMAIN_VDEC0 {
 							clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
 							clock-names = "vdec0-0";
 							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
 							#power-domain-cells = <0>;
-						};
 
-						power-domain@MT8195_POWER_DOMAIN_VDEC2 {
-							reg = <MT8195_POWER_DOMAIN_VDEC2>;
-							clocks = <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
-							clock-names = "vdec2-0";
-							mediatek,infracfg = <&infracfg_ao>;
-							#power-domain-cells = <0>;
+							power-domain@MT8195_POWER_DOMAIN_VDEC1 {
+								reg = <MT8195_POWER_DOMAIN_VDEC1>;
+								clocks = <&vdecsys CLK_VDEC_LARB1>;
+								clock-names = "vdec1-0";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8195_POWER_DOMAIN_VDEC2 {
+								reg = <MT8195_POWER_DOMAIN_VDEC2>;
+								clocks = <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
+								clock-names = "vdec2-0";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
 						};
 
 						power-domain@MT8195_POWER_DOMAIN_VENC {
@@ -694,7 +688,17 @@ power-domain@MT8195_POWER_DOMAIN_VENC {
 							clocks = <&vencsys CLK_VENC_LARB>;
 							clock-names = "venc0-larb";
 							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
 							#power-domain-cells = <0>;
+
+							power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
+								reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
+								clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>;
+								clock-names = "venc1-larb";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
 						};
 
 						power-domain@MT8195_POWER_DOMAIN_VDOSYS1 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 2b3bb5d0af17..f0b7949df92c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -621,9 +621,7 @@ uartb: serial@3110000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTB>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTB>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -633,9 +631,7 @@ uartd: serial@3130000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTD>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTD>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -645,9 +641,7 @@ uarte: serial@3140000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTE>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTE>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -657,9 +651,7 @@ uartf: serial@3150000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTF>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTF>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -1236,9 +1228,7 @@ uartc: serial@c280000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTC>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTC>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -1248,9 +1238,7 @@ uartg: serial@c290000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTG>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTG>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 33f92b77cd9d..c36950774785 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -766,9 +766,7 @@ uartd: serial@3130000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTD>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTD>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
@@ -778,9 +776,7 @@ uarte: serial@3140000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTE>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTE>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
@@ -790,9 +786,7 @@ uartf: serial@3150000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTF>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTF>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
@@ -817,9 +811,7 @@ uarth: serial@3170000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTH>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTH>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
@@ -1616,9 +1608,7 @@ uartc: serial@c280000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTC>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTC>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
@@ -1628,9 +1618,7 @@ uartg: serial@c290000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTG>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTG>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 1c53ccc5e3cb..9c1b2e7d3997 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -11,6 +11,7 @@ aliases {
 		rtc0 = "/i2c@7000d000/pmic@3c";
 		rtc1 = "/rtc@7000e000";
 		serial0 = &uarta;
+		serial3 = &uartd;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
index 91e104b0f865..a5294a42c287 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
@@ -111,6 +111,13 @@ mp5496_l2: l2 {
 			regulator-always-on;
 			regulator-boot-on;
 		};
+
+		mp5496_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 	};
 };
 
@@ -146,7 +153,7 @@ &usb_0_dwc3 {
 };
 
 &usb_0_qmpphy {
-	vdda-pll-supply = <&mp5496_l2>;
+	vdda-pll-supply = <&mp5496_l5>;
 	vdda-phy-supply = <&regulator_fixed_0p925>;
 
 	status = "okay";
@@ -154,7 +161,7 @@ &usb_0_qmpphy {
 
 &usb_0_qusbphy {
 	vdd-supply = <&regulator_fixed_0p925>;
-	vdda-pll-supply = <&mp5496_l2>;
+	vdda-pll-supply = <&mp5496_l5>;
 	vdda-phy-dpdm-supply = <&regulator_fixed_3p3>;
 
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 79bc42ffb6a1..2cfdf5bd5fd9 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1073,7 +1073,7 @@ spi0: spi@4a80000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1092,7 +1092,7 @@ uart0: serial@4a80000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				status = "disabled";
@@ -1137,7 +1137,7 @@ spi1: spi@4a84000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1184,7 +1184,7 @@ spi2: spi@4a88000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1231,7 +1231,7 @@ spi3: spi@4a8c000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1278,7 +1278,7 @@ spi4: spi@4a90000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1297,7 +1297,7 @@ uart4: serial@4a90000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				status = "disabled";
@@ -1342,7 +1342,7 @@ spi5: spi@4a94000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 6a28cab97189..8e5951da5920 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1131,9 +1131,6 @@ &sound {
 		"VA DMIC0", "MIC BIAS1",
 		"VA DMIC1", "MIC BIAS1",
 		"VA DMIC2", "MIC BIAS3",
-		"VA DMIC0", "VA MIC BIAS1",
-		"VA DMIC1", "VA MIC BIAS1",
-		"VA DMIC2", "VA MIC BIAS3",
 		"TX SWR_ADC1", "ADC2_OUTPUT";
 
 	wcd-playback-dai-link {
diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 962c8aa40044..dc604be4afc6 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -167,6 +167,7 @@ &blsp1_dma {
 	 * BAM DMA interconnects support is in place.
 	 */
 	/delete-property/ clocks;
+	/delete-property/ clock-names;
 };
 
 &blsp1_uart2 {
@@ -179,6 +180,7 @@ &blsp2_dma {
 	 * BAM DMA interconnects support is in place.
 	 */
 	/delete-property/ clocks;
+	/delete-property/ clock-names;
 };
 
 &blsp2_uart1 {
diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index 7167f75bced3..a9926ad6c6f9 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -107,6 +107,7 @@ &qusb2phy0 {
 	status = "okay";
 
 	vdd-supply = <&vreg_l1b_0p925>;
+	vdda-pll-supply = <&vreg_l10a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l7b_3p125>;
 };
 
@@ -404,6 +405,8 @@ &sdhc_1 {
 &sdhc_2 {
 	status = "okay";
 
+	cd-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+
 	vmmc-supply = <&vreg_l5b_2p95>;
 	vqmmc-supply = <&vreg_l2b_2p95>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index d37a433130b9..5948b401165c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -135,8 +135,6 @@ vdda_pll_cc_ebi23:
 		vdda_sp_sensor:
 		vdda_ufs1_core:
 		vdda_ufs2_core:
-		vdda_usb1_ss_core:
-		vdda_usb2_ss_core:
 		vreg_l1a_0p875: ldo1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
@@ -157,6 +155,7 @@ vreg_l3a_1p0: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vdda_usb1_ss_core:
 		vdd_wcss_cx:
 		vdd_wcss_mx:
 		vdda_wcss_pll:
@@ -383,8 +382,8 @@ &ufs_mem_phy {
 };
 
 &sdhc_2 {
-	pinctrl-names = "default";
 	pinctrl-0 = <&sdc2_clk_state &sdc2_cmd_state &sdc2_data_state &sd_card_det_n_state>;
+	pinctrl-names = "default";
 	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&vreg_l21a_2p95>;
 	vqmmc-supply = <&vddpx_2>;
@@ -418,16 +417,9 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
-&wifi {
-	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	status = "okay";
-};
-
 &tlmm {
-	gpio-reserved-ranges = <0 4>, <27 4>, <81 4>, <85 4>;
+	gpio-reserved-ranges = <27 4>, /* SPI (eSE - embedded Secure Element) */
+			       <85 4>; /* SPI (fingerprint reader) */
 
 	sdc2_clk_state: sdc2-clk-state {
 		pins = "sdc2_clk";
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index faa36d17b9f2..e17937f76806 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -606,7 +606,7 @@ cpu7_opp8: opp-1632000000 {
 		};
 
 		cpu7_opp9: opp-1747200000 {
-			opp-hz = /bits/ 64 <1708800000>;
+			opp-hz = /bits/ 64 <1747200000>;
 			opp-peak-kBps = <5412000 42393600>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 404473fa491a..0be8f2befec7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1806,11 +1806,11 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x594 0x0011>,
 				 <&apps_smmu 0x596 0x0011>;
-			/* FIXME: Probing BAM DMA causes some abort and system hang */
-			status = "fail";
 		};
 
 		crypto: crypto@1dfa000 {
@@ -1822,8 +1822,6 @@ crypto: crypto@1dfa000 {
 				 <&apps_smmu 0x596 0x0011>;
 			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 			interconnect-names = "memory";
-			/* FIXME: dependency BAM DMA is disabled */
-			status = "disabled";
 		};
 
 		ipa: ipa@1e40000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index fddf979de38d..edde21972f5a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3605,8 +3605,11 @@ mdss: display-subsystem@ae00000 {
 			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 
 			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
-					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
-			interconnect-names = "mdp0-mem";
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			power-domains = <&dispcc MDSS_GDSC>;
 
@@ -6354,20 +6357,20 @@ map0 {
 
 			trips {
 				gpu0_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6387,20 +6390,20 @@ map0 {
 
 			trips {
 				gpu1_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6420,20 +6423,20 @@ map0 {
 
 			trips {
 				gpu2_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6453,20 +6456,20 @@ map0 {
 
 			trips {
 				gpu3_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6486,20 +6489,20 @@ map0 {
 
 			trips {
 				gpu4_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6519,20 +6522,20 @@ map0 {
 
 			trips {
 				gpu5_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6552,20 +6555,20 @@ map0 {
 
 			trips {
 				gpu6_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
@@ -6585,20 +6588,20 @@ map0 {
 
 			trips {
 				gpu7_alert0: trip-point0 {
-					temperature = <85000>;
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <90000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
 				trip-point2 {
-					temperature = <110000>;
-					hysteresis = <1000>;
+					temperature = <115000>;
+					hysteresis = <0>;
 					type = "critical";
 				};
 			};
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 19da90704b7c..001a9dc0a4ba 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -267,6 +267,7 @@ vreg_l12b: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b: ldo13 {
@@ -288,6 +289,7 @@ vreg_l15b: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b: ldo16 {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5a5abd5fa658..5082ecb32089 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -20,6 +20,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -4284,6 +4285,8 @@ usb_2_dwc3: usb@a200000 {
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
 
+				dma-coherent;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -6412,8 +6415,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6438,7 +6441,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6464,7 +6467,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6490,7 +6493,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6516,7 +6519,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6542,7 +6545,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6568,7 +6571,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6594,7 +6597,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6620,7 +6623,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6638,8 +6641,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6656,8 +6659,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6674,7 +6677,7 @@ trip-point0 {
 				};
 
 				mem-critical {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -6692,7 +6695,7 @@ trip-point0 {
 				};
 
 				video-critical {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6710,8 +6713,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6736,7 +6739,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6762,7 +6765,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6788,7 +6791,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6814,7 +6817,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6840,7 +6843,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6866,7 +6869,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6892,7 +6895,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6918,7 +6921,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -6936,8 +6939,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6954,8 +6957,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6972,8 +6975,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6998,7 +7001,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7024,7 +7027,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7050,7 +7053,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7076,7 +7079,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7102,7 +7105,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7128,7 +7131,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7154,7 +7157,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7180,7 +7183,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7198,8 +7201,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7216,8 +7219,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7234,8 +7237,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7252,8 +7255,8 @@ trip-point0 {
 				};
 
 				nsp0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7270,8 +7273,8 @@ trip-point0 {
 				};
 
 				nsp1-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7288,8 +7291,8 @@ trip-point0 {
 				};
 
 				nsp2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7306,33 +7309,34 @@ trip-point0 {
 				};
 
 				nsp3-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
 		};
 
 		gpuss-0-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 5>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss0_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7340,25 +7344,26 @@ trip-point2 {
 		};
 
 		gpuss-1-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 6>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss1_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7366,25 +7371,26 @@ trip-point2 {
 		};
 
 		gpuss-2-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 7>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss2_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7392,25 +7398,26 @@ trip-point2 {
 		};
 
 		gpuss-3-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 8>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss3_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7418,25 +7425,26 @@ trip-point2 {
 		};
 
 		gpuss-4-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 9>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss4_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7444,25 +7452,26 @@ trip-point2 {
 		};
 
 		gpuss-5-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 10>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss5_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7470,25 +7479,26 @@ trip-point2 {
 		};
 
 		gpuss-6-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 11>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss6_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss6_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7496,25 +7506,26 @@ trip-point2 {
 		};
 
 		gpuss-7-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 12>;
 
-			trips {
-				trip-point0 {
-					temperature = <85000>;
-					hysteresis = <1000>;
-					type = "passive";
+			cooling-maps {
+				map0 {
+					trip = <&gpuss7_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+			};
 
-				trip-point1 {
-					temperature = <90000>;
+			trips {
+				gpuss7_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
-					type = "hot";
+					type = "passive";
 				};
 
-				trip-point2 {
-					temperature = <125000>;
+				gpu-critical {
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -7533,7 +7544,7 @@ trip-point0 {
 
 				camera0-critical {
 					temperature = <115000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -7551,7 +7562,7 @@ trip-point0 {
 
 				camera0-critical {
 					temperature = <115000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-ard-audio-da7212.dtso b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-ard-audio-da7212.dtso
index e6cf304c77ee..5d820bd32ff6 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-ard-audio-da7212.dtso
+++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-ard-audio-da7212.dtso
@@ -108,7 +108,7 @@ sound_clk_pins: sound-clk {
 	};
 
 	tpu0_pins: tpu0 {
-		groups = "tpu_to0_a";
+		groups = "tpu_to0_b";
 		function = "tpu";
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index f6f15946579e..57466fbfd3f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -284,14 +284,6 @@ &uart2 {
 	status = "okay";
 };
 
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
 &vopb {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
index f2cc086e5001..887c9be1b410 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
@@ -636,6 +636,7 @@ flash@0 {
 		spi-max-frequency = <104000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
+		vcc-supply = <&vcc_1v8>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index 93189f830640..c30354268c8f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -486,9 +486,12 @@ &saradc {
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
 	non-removable;
 	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 83e7e0fbe783..ad4331bc0780 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -428,16 +428,15 @@ xin32k: clock-2 {
 		#clock-cells = <0>;
 	};
 
-	pmu_sram: sram@10f000 {
-		compatible = "mmio-sram";
-		reg = <0x0 0x0010f000 0x0 0x100>;
-		ranges = <0 0x0 0x0010f000 0x100>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 
-		scmi_shmem: sram@0 {
+		scmi_shmem: shmem@10f000 {
 			compatible = "arm,scmi-shmem";
-			reg = <0x0 0x100>;
+			reg = <0x0 0x0010f000 0x0 0x100>;
+			no-map;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8230d53cd696..f7a557e6af54 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -557,6 +557,7 @@ &usb1 {
 &ospi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
+	status = "okay";
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8fe7dbae33bf..f988dd79add8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1536,6 +1536,9 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_HDMI=m
+CONFIG_PHY_MTK_MIPI_DSI=m
+CONFIG_PHY_MTK_DP=m
 CONFIG_PHY_QCOM_EDP=m
 CONFIG_PHY_QCOM_PCIE2=m
 CONFIG_PHY_QCOM_QMP=m
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index da6d2c1c0b03..5f4dc6364dbb 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -370,12 +370,14 @@
 /*
  * ISS values for SME traps
  */
-
-#define ESR_ELx_SME_ISS_SME_DISABLED	0
-#define ESR_ELx_SME_ISS_ILL		1
-#define ESR_ELx_SME_ISS_SM_DISABLED	2
-#define ESR_ELx_SME_ISS_ZA_DISABLED	3
-#define ESR_ELx_SME_ISS_ZT_DISABLED	4
+#define ESR_ELx_SME_ISS_SMTC_MASK		GENMASK(2, 0)
+#define ESR_ELx_SME_ISS_SMTC(esr)		((esr) & ESR_ELx_SME_ISS_SMTC_MASK)
+
+#define ESR_ELx_SME_ISS_SMTC_SME_DISABLED	0
+#define ESR_ELx_SME_ISS_SMTC_ILL		1
+#define ESR_ELx_SME_ISS_SMTC_SM_DISABLED	2
+#define ESR_ELx_SME_ISS_SMTC_ZA_DISABLED	3
+#define ESR_ELx_SME_ISS_SMTC_ZT_DISABLED	4
 
 /* ISS field definitions for MOPS exceptions */
 #define ESR_ELx_MOPS_ISS_MEM_INST	(UL(1) << 24)
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index f2a84efc3618..c8dcb67b81a7 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -6,6 +6,7 @@
 #define __ASM_FP_H
 
 #include <asm/errno.h>
+#include <asm/percpu.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
@@ -94,6 +95,8 @@ struct cpu_fp_state {
 	enum fp_type to_save;
 };
 
+DECLARE_PER_CPU(struct cpu_fp_state, fpsimd_last_state);
+
 extern void fpsimd_bind_state_to_cpu(struct cpu_fp_state *fp_state);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 3fcd9d080bf2..d23315ef7b67 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -393,20 +393,16 @@ static bool cortex_a76_erratum_1463225_debug_handler(struct pt_regs *regs)
  * As per the ABI exit SME streaming mode and clear the SVE state not
  * shared with FPSIMD on syscall entry.
  */
-static inline void fp_user_discard(void)
+static inline void fpsimd_syscall_enter(void)
 {
-	/*
-	 * If SME is active then exit streaming mode.  If ZA is active
-	 * then flush the SVE registers but leave userspace access to
-	 * both SVE and SME enabled, otherwise disable SME for the
-	 * task and fall through to disabling SVE too.  This means
-	 * that after a syscall we never have any streaming mode
-	 * register state to track, if this changes the KVM code will
-	 * need updating.
-	 */
+	/* Ensure PSTATE.SM is clear, but leave PSTATE.ZA as-is. */
 	if (system_supports_sme())
 		sme_smstop_sm();
 
+	/*
+	 * The CPU is not in streaming mode. If non-streaming SVE is not
+	 * supported, there is no SVE state that needs to be discarded.
+	 */
 	if (!system_supports_sve())
 		return;
 
@@ -416,6 +412,33 @@ static inline void fp_user_discard(void)
 		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
 		sve_flush_live(true, sve_vq_minus_one);
 	}
+
+	/*
+	 * Any live non-FPSIMD SVE state has been zeroed. Allow
+	 * fpsimd_save_user_state() to lazily discard SVE state until either
+	 * the live state is unbound or fpsimd_syscall_exit() is called.
+	 */
+	__this_cpu_write(fpsimd_last_state.to_save, FP_STATE_FPSIMD);
+}
+
+static __always_inline void fpsimd_syscall_exit(void)
+{
+	if (!system_supports_sve())
+		return;
+
+	/*
+	 * The current task's user FPSIMD/SVE/SME state is now bound to this
+	 * CPU. The fpsimd_last_state.to_save value is either:
+	 *
+	 * - FP_STATE_FPSIMD, if the state has not been reloaded on this CPU
+	 *   since fpsimd_syscall_enter().
+	 *
+	 * - FP_STATE_CURRENT, if the state has been reloaded on this CPU at
+	 *   any point.
+	 *
+	 * Reset this to FP_STATE_CURRENT to stop lazy discarding.
+	 */
+	__this_cpu_write(fpsimd_last_state.to_save, FP_STATE_CURRENT);
 }
 
 UNHANDLED(el1t, 64, sync)
@@ -707,10 +730,11 @@ static void noinstr el0_svc(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
-	fp_user_discard();
+	fpsimd_syscall_enter();
 	local_daif_restore(DAIF_PROCCTX);
 	do_el0_svc(regs);
 	exit_to_user_mode(regs);
+	fpsimd_syscall_exit();
 }
 
 static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f38d22dac140..8854bce5cfe2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -119,7 +119,7 @@
  *   whatever is in the FPSIMD registers is not saved to memory, but discarded.
  */
 
-static DEFINE_PER_CPU(struct cpu_fp_state, fpsimd_last_state);
+DEFINE_PER_CPU(struct cpu_fp_state, fpsimd_last_state);
 
 __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX] = {
 #ifdef CONFIG_ARM64_SVE
@@ -359,9 +359,6 @@ static void task_fpsimd_load(void)
 	WARN_ON(preemptible());
 	WARN_ON(test_thread_flag(TIF_KERNEL_FPSTATE));
 
-	if (system_supports_fpmr())
-		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
-
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
@@ -413,6 +410,9 @@ static void task_fpsimd_load(void)
 			restore_ffr = system_supports_fa64();
 	}
 
+	if (system_supports_fpmr())
+		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
+
 	if (restore_sve_regs) {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),
@@ -453,12 +453,15 @@ static void fpsimd_save_user_state(void)
 		*(last->fpmr) = read_sysreg_s(SYS_FPMR);
 
 	/*
-	 * If a task is in a syscall the ABI allows us to only
-	 * preserve the state shared with FPSIMD so don't bother
-	 * saving the full SVE state in that case.
+	 * Save SVE state if it is live.
+	 *
+	 * The syscall ABI discards live SVE state at syscall entry. When
+	 * entering a syscall, fpsimd_syscall_enter() sets to_save to
+	 * FP_STATE_FPSIMD to allow the SVE state to be lazily discarded until
+	 * either new SVE state is loaded+bound or fpsimd_syscall_exit() is
+	 * called prior to a return to userspace.
 	 */
-	if ((last->to_save == FP_STATE_CURRENT && test_thread_flag(TIF_SVE) &&
-	     !in_syscall(current_pt_regs())) ||
+	if ((last->to_save == FP_STATE_CURRENT && test_thread_flag(TIF_SVE)) ||
 	    last->to_save == FP_STATE_SVE) {
 		save_sve_regs = true;
 		save_ffr = true;
@@ -651,7 +654,7 @@ static void __fpsimd_to_sve(void *sst, struct user_fpsimd_state const *fst,
  * task->thread.uw.fpsimd_state must be up to date before calling this
  * function.
  */
-static void fpsimd_to_sve(struct task_struct *task)
+static inline void fpsimd_to_sve(struct task_struct *task)
 {
 	unsigned int vq;
 	void *sst = task->thread.sve_state;
@@ -675,7 +678,7 @@ static void fpsimd_to_sve(struct task_struct *task)
  * bytes of allocated kernel memory.
  * task->thread.sve_state must be up to date before calling this function.
  */
-static void sve_to_fpsimd(struct task_struct *task)
+static inline void sve_to_fpsimd(struct task_struct *task)
 {
 	unsigned int vq, vl;
 	void const *sst = task->thread.sve_state;
@@ -1436,7 +1439,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 	 * If this not a trap due to SME being disabled then something
 	 * is being used in the wrong mode, report as SIGILL.
 	 */
-	if (ESR_ELx_ISS(esr) != ESR_ELx_SME_ISS_SME_DISABLED) {
+	if (ESR_ELx_SME_ISS_SMTC(esr) != ESR_ELx_SME_ISS_SMTC_SME_DISABLED) {
 		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 		return;
 	}
@@ -1460,6 +1463,8 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 		sme_set_vq(vq_minus_one);
 
 		fpsimd_bind_task_to_cpu();
+	} else {
+		fpsimd_flush_task_state(current);
 	}
 
 	put_cpu_fpsimd_context();
@@ -1573,8 +1578,8 @@ void fpsimd_thread_switch(struct task_struct *next)
 		fpsimd_save_user_state();
 
 	if (test_tsk_thread_flag(next, TIF_KERNEL_FPSTATE)) {
-		fpsimd_load_kernel_state(next);
 		fpsimd_flush_cpu_state();
+		fpsimd_load_kernel_state(next);
 	} else {
 		/*
 		 * Fix up TIF_FOREIGN_FPSTATE to correctly describe next's
@@ -1661,6 +1666,9 @@ void fpsimd_flush_thread(void)
 		current->thread.svcr = 0;
 	}
 
+	if (system_supports_fpmr())
+		current->thread.uw.fpmr = 0;
+
 	current->thread.fp_type = FP_STATE_FPSIMD;
 
 	put_cpu_fpsimd_context();
@@ -1801,7 +1809,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	get_cpu_fpsimd_context();
 
 	current->thread.uw.fpsimd_state = *state;
-	if (test_thread_flag(TIF_SVE))
+	if (current->thread.fp_type == FP_STATE_SVE)
 		fpsimd_to_sve(current);
 
 	task_fpsimd_load();
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 9d01361696a1..ae551b857137 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -83,7 +83,26 @@ HYPERCALL3(vcpu_op);
 HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 HYPERCALL2(vm_assist);
-HYPERCALL3(dm_op);
+
+SYM_FUNC_START(HYPERVISOR_dm_op)
+	mov x16, #__HYPERVISOR_dm_op;	\
+	/*
+	 * dm_op hypercalls are issued by the userspace. The kernel needs to
+	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
+	 * translations to user memory via AT instructions. Since AT
+	 * instructions are not affected by the PAN bit (ARMv8.1), we only
+	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
+	 * is enabled (it implies that hardware UAO and PAN disabled).
+	 */
+	uaccess_ttbr0_enable x6, x7, x8
+	hvc XEN_IMM
+
+	/*
+	 * Disable userspace access from kernel once the hyp call completed.
+	 */
+	uaccess_ttbr0_disable x6, x7
+	ret
+SYM_FUNC_END(HYPERVISOR_dm_op);
 
 SYM_FUNC_START(privcmd_call)
 	mov x16, x0
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index e324410ef239..d26c7f4f8c36 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -793,7 +793,7 @@ static void __init mac_identify(void)
 	}
 
 	macintosh_config = mac_data_table;
-	for (m = macintosh_config; m->ident != -1; m++) {
+	for (m = &mac_data_table[1]; m->ident != -1; m++) {
 		if (m->ident == model) {
 			macintosh_config = m;
 			break;
diff --git a/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts b/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts
index c7ea4f1c0bb2..6c277ab83d4b 100644
--- a/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts
+++ b/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts
@@ -29,6 +29,7 @@ msi: msi-controller@2ff00000 {
 		compatible = "loongson,pch-msi-1.0";
 		reg = <0 0x2ff00000 0 0x8>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		msi-controller;
 		loongson,msi-base-vec = <64>;
 		loongson,msi-num-vecs = <64>;
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f43c1198768c..b4006a4a1121 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -162,7 +162,7 @@ endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 
-ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)(CONFIG_PPC_BOOK3S),)
+ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)$(CONFIG_PPC_BOOK3S),)
 obj-y				+= ppc_save_regs.o
 endif
 
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 9ac3266e4965..a325c1c02f96 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -359,7 +359,10 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	if (TRAP(regs) == INTERRUPT_SYSTEM_RESET)
 		is_via_system_reset = 1;
 
-	crash_smp_send_stop();
+	if (IS_ENABLED(CONFIG_SMP))
+		crash_smp_send_stop();
+	else
+		crash_kexec_prepare();
 
 	crash_save_cpu(regs, crashing_cpu);
 
diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 0b6365d85d11..dc6f75d3ac6e 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -521,6 +521,15 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
+	/*
+	 * Map complete page to the paste address. So the user
+	 * space should pass 0ULL to the offset parameter.
+	 */
+	if (vma->vm_pgoff) {
+		pr_debug("Page offset unsupported to map paste address\n");
+		return -EINVAL;
+	}
+
 	/* Ensure instance has an open send window */
 	if (!txwin) {
 		pr_err("No send window open?\n");
diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 877720c64515..35471b679638 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -48,11 +48,15 @@ static ssize_t memtrace_read(struct file *filp, char __user *ubuf,
 static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct memtrace_entry *ent = filp->private_data;
+	unsigned long ent_nrpages = ent->size >> PAGE_SHIFT;
+	unsigned long vma_nrpages = vma_pages(vma);
 
-	if (ent->size < vma->vm_end - vma->vm_start)
+	/* The requested page offset should be within object's page count */
+	if (vma->vm_pgoff >= ent_nrpages)
 		return -EINVAL;
 
-	if (vma->vm_pgoff << PAGE_SHIFT >= ent->size)
+	/* The requested mapping range should remain within the bounds */
+	if (vma_nrpages > ent_nrpages - vma->vm_pgoff)
 		return -EINVAL;
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index d6ebc19fb99c..eec333dd2e59 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -197,7 +197,7 @@ static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
 
 static void tce_free_pSeries(struct iommu_table *tbl)
 {
-	if (!tbl->it_userspace)
+	if (tbl->it_userspace)
 		tce_iommu_userspace_view_free(tbl);
 }
 
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index d14bfc23e315..36ac96eac9c9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -429,7 +429,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	val.data_u64 = 0;
 	if (user_mode(regs)) {
-		if (copy_from_user(&val, (u8 __user *)addr, len))
+		if (copy_from_user_nofault(&val, (u8 __user *)addr, len))
 			return -1;
 	} else {
 		memcpy(&val, (u8 *)addr, len);
@@ -530,7 +530,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -EOPNOTSUPP;
 
 	if (user_mode(regs)) {
-		if (copy_to_user((u8 __user *)addr, &val, len))
+		if (copy_to_user_nofault((u8 __user *)addr, &val, len))
 			return -1;
 	} else {
 		memcpy((u8 *)addr, &val, len);
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 6e704ed86a83..635c67ed3665 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -139,9 +139,9 @@ void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
 	struct kvm_vcpu *tmp;
 
 	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
-		spin_lock(&vcpu->arch.mp_state_lock);
+		spin_lock(&tmp->arch.mp_state_lock);
 		WRITE_ONCE(tmp->arch.mp_state.mp_state, KVM_MP_STATE_STOPPED);
-		spin_unlock(&vcpu->arch.mp_state_lock);
+		spin_unlock(&tmp->arch.mp_state_lock);
 	}
 	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9d440a0b729e..64bb8b71013a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -605,17 +605,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	}
 	/* Setup stack and backchain */
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
-		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-			/* lgr %w1,%r15 (backchain) */
-			EMIT4(0xb9040000, REG_W1, REG_15);
+		/* lgr %w1,%r15 (backchain) */
+		EMIT4(0xb9040000, REG_W1, REG_15);
 		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
 		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
 		/* aghi %r15,-STK_OFF */
 		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
-		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-			/* stg %w1,152(%r15) (backchain) */
-			EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
-				      REG_15, 152);
+		/* stg %w1,152(%r15) (backchain) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
+			      REG_15, 152);
 	}
 }
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0bfde2ea5cb8..cdf7bf029836 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -38,7 +38,6 @@ struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
-	struct hlist_node node;
 };
 
 struct amd_uncore_pmu {
@@ -890,6 +889,39 @@ static void amd_uncore_umc_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
+static void amd_uncore_umc_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new, shift;
+	s64 delta;
+
+	shift = COUNTER_SHIFT + 1;
+	prev = local64_read(&hwc->prev_count);
+
+	/*
+	 * UMC counters do not have RDPMC assignments. Read counts directly
+	 * from the corresponding PERF_CTR.
+	 */
+	rdmsrl(hwc->event_base, new);
+
+	/*
+	 * Unlike the other uncore counters, UMC counters saturate and set the
+	 * Overflow bit (bit 48) on overflow. Since they do not roll over,
+	 * proactively reset the corresponding PERF_CTR when bit 47 is set so
+	 * that the counter never gets a chance to saturate.
+	 */
+	if (new & BIT_ULL(63 - COUNTER_SHIFT)) {
+		wrmsrl(hwc->event_base, 0);
+		local64_set(&hwc->prev_count, 0);
+	} else {
+		local64_set(&hwc->prev_count, new);
+	}
+
+	delta = (new << shift) - (prev << shift);
+	delta >>= shift;
+	local64_add(delta, &event->count);
+}
+
 static
 void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -967,7 +999,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.del		= amd_uncore_del,
 				.start		= amd_uncore_umc_start,
 				.stop		= amd_uncore_stop,
-				.read		= amd_uncore_read,
+				.read		= amd_uncore_umc_read,
 				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 				.module		= THIS_MODULE,
 			};
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d691ce..3e4e85f71a6a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -117,13 +117,10 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
-		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
-			mb();
-			clflush((void *)&current_thread_info()->flags);
-			mb();
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 
 		if (!need_resched()) {
 			if (ecx & 1) {
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..8727c7e21dd1 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,26 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+/*
+ * To prevent immediate repeat of single step trap on return from SIGTRAP
+ * handler if the trap flag (TF) is set without an external debugger attached,
+ * clear the software event flag in the augmented SS, ensuring no single-step
+ * trap is pending upon ERETU completion.
+ *
+ * Note, this function should be called in sigreturn() before the original
+ * state is restored to make sure the TF is read from the entry frame.
+ */
+static __always_inline void prevent_single_step_upon_eretu(struct pt_regs *regs)
+{
+	/*
+	 * If the trap flag (TF) is set, i.e., the sigreturn() SYSCALL instruction
+	 * is being single-stepped, do not clear the software event flag in the
+	 * augmented SS, thus a debugger won't skip over the following instruction.
+	 */
+#ifdef CONFIG_X86_FRED
+	if (!(regs->flags & X86_EFLAGS_TF))
+		regs->fred_ss.swevent = 0;
+#endif
+}
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 39e9ec3dea98..b48775445523 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1007,17 +1007,18 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
-	/* AMD-defined flags: level 0x80000001 */
+	/*
+	 * Check if extended CPUID leaves are implemented: Max extended
+	 * CPUID leaf must be in the 0x80000001-0x8000ffff range.
+	 */
 	eax = cpuid_eax(0x80000000);
-	c->extended_cpuid_level = eax;
+	c->extended_cpuid_level = ((eax & 0xffff0000) == 0x80000000) ? eax : 0;
 
-	if ((eax & 0xffff0000) == 0x80000000) {
-		if (eax >= 0x80000001) {
-			cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
+	if (c->extended_cpuid_level >= 0x80000001) {
+		cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
 
-			c->x86_capability[CPUID_8000_0001_ECX] = ecx;
-			c->x86_capability[CPUID_8000_0001_EDX] = edx;
-		}
+		c->x86_capability[CPUID_8000_0001_ECX] = ecx;
+		c->x86_capability[CPUID_8000_0001_EDX] = edx;
 	}
 
 	if (c->extended_cpuid_level >= 0x80000007) {
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 079f046ee26d..e8021d3e5882 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -696,6 +696,8 @@ static int load_late_locked(void)
 		return load_late_stop_cpus(true);
 	case UCODE_NFOUND:
 		return -ENOENT;
+	case UCODE_OK:
+		return 0;
 	default:
 		return -EBADFD;
 	}
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 7b29ebda024f..1ececfce7a46 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -591,7 +591,7 @@ static void get_fixed_ranges(mtrr_type *frs)
 
 void mtrr_save_fixed_ranges(void *info)
 {
-	if (boot_cpu_has(X86_FEATURE_MTRR))
+	if (mtrr_state.have_fixed)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 }
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index e2fab3ceb09f..9a101150376d 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -33,8 +33,9 @@ void io_bitmap_share(struct task_struct *tsk)
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
-static void task_update_io_bitmap(struct task_struct *tsk)
+static void task_update_io_bitmap(void)
 {
+	struct task_struct *tsk = current;
 	struct thread_struct *t = &tsk->thread;
 
 	if (t->iopl_emul == 3 || t->io_bitmap) {
@@ -54,7 +55,12 @@ void io_bitmap_exit(struct task_struct *tsk)
 	struct io_bitmap *iobm = tsk->thread.io_bitmap;
 
 	tsk->thread.io_bitmap = NULL;
-	task_update_io_bitmap(tsk);
+	/*
+	 * Don't touch the TSS when invoked on a failed fork(). TSS
+	 * reflects the state of @current and not the state of @tsk.
+	 */
+	if (tsk == current)
+		task_update_io_bitmap();
 	if (iobm && refcount_dec_and_test(&iobm->refcnt))
 		kfree(iobm);
 }
@@ -192,8 +198,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 	}
 
 	t->iopl_emul = level;
-	task_update_io_bitmap(current);
-
+	task_update_io_bitmap();
 	return 0;
 }
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index feca4f20b06a..85fa2db38dc4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -414,7 +414,7 @@ static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
 	bool handled = false;
 
 	for (i = 0; i < 4; i++)
-		pir_copy[i] = pir[i];
+		pir_copy[i] = READ_ONCE(pir[i]);
 
 	for (i = 0; i < 4; i++) {
 		if (!pir_copy[i])
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c7ce3655b707..1dbd7a34645c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -180,6 +180,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
 	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
@@ -468,6 +469,11 @@ void native_tss_update_io_bitmap(void)
 	} else {
 		struct io_bitmap *iobm = t->io_bitmap;
 
+		if (WARN_ON_ONCE(!iobm)) {
+			clear_thread_flag(TIF_IO_BITMAP);
+			native_tss_invalidate_io_bitmap();
+		}
+
 		/*
 		 * Only copy bitmap data when the sequence number differs. The
 		 * update time is accounted to the incoming task.
@@ -906,13 +912,10 @@ static __init bool prefer_mwait_c1_over_halt(void)
 static __cpuidle void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
-		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
-			mb(); /* quirk */
-			clflush((void *)&current_thread_info()->flags);
-			mb(); /* quirk */
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 		if (!need_resched()) {
 			__sti_mwait(0, 0);
 			raw_local_irq_disable();
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 98123ff10506..42bbc42bd350 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -152,6 +152,8 @@ SYSCALL32_DEFINE0(sigreturn)
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
 	sigset_t set;
 
+	prevent_single_step_upon_eretu(regs);
+
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -175,6 +177,8 @@ SYSCALL32_DEFINE0(rt_sigreturn)
 	struct rt_sigframe_ia32 __user *frame;
 	sigset_t set;
 
+	prevent_single_step_upon_eretu(regs);
+
 	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
 
 	if (!access_ok(frame, sizeof(*frame)))
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index ee9453891901..d483b585c6c6 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -250,6 +250,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	sigset_t set;
 	unsigned long uc_flags;
 
+	prevent_single_step_upon_eretu(regs);
+
 	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
@@ -366,6 +368,8 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	sigset_t set;
 	unsigned long uc_flags;
 
+	prevent_single_step_upon_eretu(regs);
+
 	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
 
 	if (!access_ok(frame, sizeof(*frame)))
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index f5dd84eb55dc..cd3fd5155f6e 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -35,7 +35,7 @@
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
 #
-# REX2 Prefix
+# REX2 Prefix Superscripts
 #  - (!REX2): REX2 is not allowed
 #  - (REX2): REX2 variant e.g. JMPABS
 
@@ -286,10 +286,10 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
-e1: LOOPE/LOOPZ Jb (f64) (!REX2)
-e2: LOOP Jb (f64) (!REX2)
-e3: JrCXZ Jb (f64) (!REX2)
+e0: LOOPNE/LOOPNZ Jb (f64),(!REX2)
+e1: LOOPE/LOOPZ Jb (f64),(!REX2)
+e2: LOOP Jb (f64),(!REX2)
+e3: JrCXZ Jb (f64),(!REX2)
 e4: IN AL,Ib (!REX2)
 e5: IN eAX,Ib (!REX2)
 e6: OUT Ib,AL (!REX2)
@@ -298,10 +298,10 @@ e7: OUT Ib,eAX (!REX2)
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64) (!REX2)
-e9: JMP-near Jz (f64) (!REX2)
-ea: JMP-far Ap (i64) (!REX2)
-eb: JMP-short Jb (f64) (!REX2)
+e8: CALL Jz (f64),(!REX2)
+e9: JMP-near Jz (f64),(!REX2)
+ea: JMP-far Ap (i64),(!REX2)
+eb: JMP-short Jb (f64),(!REX2)
 ec: IN AL,DX (!REX2)
 ed: IN eAX,DX (!REX2)
 ee: OUT DX,AL (!REX2)
@@ -478,22 +478,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64) (!REX2)
-81: JNO Jz (f64) (!REX2)
-82: JB/JC/JNAE Jz (f64) (!REX2)
-83: JAE/JNB/JNC Jz (f64) (!REX2)
-84: JE/JZ Jz (f64) (!REX2)
-85: JNE/JNZ Jz (f64) (!REX2)
-86: JBE/JNA Jz (f64) (!REX2)
-87: JA/JNBE Jz (f64) (!REX2)
-88: JS Jz (f64) (!REX2)
-89: JNS Jz (f64) (!REX2)
-8a: JP/JPE Jz (f64) (!REX2)
-8b: JNP/JPO Jz (f64) (!REX2)
-8c: JL/JNGE Jz (f64) (!REX2)
-8d: JNL/JGE Jz (f64) (!REX2)
-8e: JLE/JNG Jz (f64) (!REX2)
-8f: JNLE/JG Jz (f64) (!REX2)
+80: JO Jz (f64),(!REX2)
+81: JNO Jz (f64),(!REX2)
+82: JB/JC/JNAE Jz (f64),(!REX2)
+83: JAE/JNB/JNC Jz (f64),(!REX2)
+84: JE/JZ Jz (f64),(!REX2)
+85: JNE/JNZ Jz (f64),(!REX2)
+86: JBE/JNA Jz (f64),(!REX2)
+87: JA/JNBE Jz (f64),(!REX2)
+88: JS Jz (f64),(!REX2)
+89: JNS Jz (f64),(!REX2)
+8a: JP/JPE Jz (f64),(!REX2)
+8b: JNP/JPO Jz (f64),(!REX2)
+8c: JL/JNGE Jz (f64),(!REX2)
+8d: JNL/JGE Jz (f64),(!REX2)
+8e: JLE/JNG Jz (f64),(!REX2)
+8f: JNLE/JG Jz (f64),(!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 414118435240..164ded9eb144 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1321,7 +1321,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	bdev = bio->bi_bdev;
-	submit_bio_noacct_nocheck(bio);
 
 	/*
 	 * blk-mq devices will reuse the extra reference on the request queue
@@ -1329,8 +1328,12 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	 * path for BIO-based devices will not do that. So drop this extra
 	 * reference here.
 	 */
-	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
+	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
+		bdev->bd_disk->fops->submit_bio(bio);
 		blk_queue_exit(bdev->bd_disk->queue);
+	} else {
+		blk_mq_submit_bio(bio);
+	}
 
 put_zwplug:
 	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */
diff --git a/block/elevator.c b/block/elevator.c
index 43ba4ab1ada7..1f76e9efd771 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -752,7 +752,6 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 {
 	struct request_queue *q = disk->queue;
-	struct elevator_queue *eq = q->elevator;
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
@@ -763,7 +762,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 		len += sprintf(name+len, "[none] ");
 	} else {
 		len += sprintf(name+len, "none ");
-		cur = eq->type;
+		cur = q->elevator->type;
 	}
 
 	spin_lock(&elv_list_lock);
diff --git a/crypto/api.c b/crypto/api.c
index c2c4eb14ef95..5ce54328fef1 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -220,10 +220,19 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg,
 		if (crypto_is_test_larval(larval))
 			crypto_larval_kill(larval);
 		alg = ERR_PTR(-ETIMEDOUT);
-	} else if (!alg) {
+	} else if (!alg || PTR_ERR(alg) == -EEXIST) {
+		int err = alg ? -EEXIST : -EAGAIN;
+
+		/*
+		 * EEXIST is expected because two probes can be scheduled
+		 * at the same time with one using alg_name and the other
+		 * using driver_name.  Do a re-lookup but do not retry in
+		 * case we hit a quirk like gcm_base(ctr(aes),...) which
+		 * will never match.
+		 */
 		alg = &larval->alg;
 		alg = crypto_alg_lookup(alg->cra_name, type, mask) ?:
-		      ERR_PTR(-EAGAIN);
+		      ERR_PTR(err);
 	} else if (IS_ERR(alg))
 		;
 	else if (crypto_is_test_larval(larval) &&
diff --git a/crypto/lrw.c b/crypto/lrw.c
index e216fbf2b786..4bede0031c63 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -322,7 +322,7 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	err = crypto_grab_skcipher(spawn, skcipher_crypto_instance(inst),
 				   cipher_name, 0, mask);
-	if (err == -ENOENT) {
+	if (err == -ENOENT && memcmp(cipher_name, "ecb(", 4)) {
 		err = -ENAMETOOLONG;
 		if (snprintf(ecb_name, CRYPTO_MAX_ALG_NAME, "ecb(%s)",
 			     cipher_name) >= CRYPTO_MAX_ALG_NAME)
@@ -356,7 +356,7 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
 	/* Alas we screwed up the naming so we have to mangle the
 	 * cipher name.
 	 */
-	if (!strncmp(cipher_name, "ecb(", 4)) {
+	if (!memcmp(cipher_name, "ecb(", 4)) {
 		int len;
 
 		len = strscpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
diff --git a/crypto/xts.c b/crypto/xts.c
index 672e1a3f0b0c..91e391a6ba27 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -363,7 +363,7 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	err = crypto_grab_skcipher(&ctx->spawn, skcipher_crypto_instance(inst),
 				   cipher_name, 0, mask);
-	if (err == -ENOENT) {
+	if (err == -ENOENT && memcmp(cipher_name, "ecb(", 4)) {
 		err = -ENAMETOOLONG;
 		if (snprintf(name, CRYPTO_MAX_ALG_NAME, "ecb(%s)",
 			     cipher_name) >= CRYPTO_MAX_ALG_NAME)
@@ -397,7 +397,7 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	/* Alas we screwed up the naming so we have to mangle the
 	 * cipher name.
 	 */
-	if (!strncmp(cipher_name, "ecb(", 4)) {
+	if (!memcmp(cipher_name, "ecb(", 4)) {
 		int len;
 
 		len = strscpy(name, cipher_name + 4, sizeof(name));
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 5241f4c01c76..89a4ac447a2b 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -201,6 +201,12 @@ acpi_ex_read_serial_bus(union acpi_operand_object *obj_desc,
 		function = ACPI_READ;
 		break;
 
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+
+		buffer_length = ACPI_FFH_INPUT_BUFFER_SIZE;
+		function = ACPI_READ;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 3cfe7e7475f2..070c07d68dfb 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -23,6 +23,7 @@ config ACPI_APEI_GHES
 	select ACPI_HED
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
+	select ARM_SDE_INTERFACE if ARM64
 	help
 	  Generic Hardware Error Source provides a way to report
 	  platform hardware errors (such as that from chipset). It
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cff6685fa6cc..6cf40e8ac321 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1612,7 +1612,7 @@ void __init acpi_ghes_init(void)
 {
 	int rc;
 
-	sdei_init();
+	acpi_sdei_init();
 
 	if (acpi_disabled)
 		return;
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e78e3754d99e..dab941dc984a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -463,7 +463,7 @@ bool cppc_allow_fast_switch(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		desired_reg = &cpc_ptr->cpc_regs[DESIRED_PERF];
 		if (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index df9328c850bd..f2c943b934be 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -42,7 +42,6 @@ static struct acpi_osi_entry
 osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Module Device", true},
 	{"Processor Device", true},
-	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
 };
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 14c7bac4100b..7d59c6c9185f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -534,7 +534,7 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
 	{
-		/* MECHREV Jiaolong17KS Series GM7XG0M */
+		/* MECHREVO Jiaolong17KS Series GM7XG0M */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
 		},
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1abe61f11525..faf4cdec23f0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -916,6 +916,8 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	if (!dev->power.is_suspended)
 		goto Complete;
 
+	dev->power.is_suspended = false;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -971,7 +973,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
-	dev->power.is_suspended = false;
 
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 292f127cae0a..02fa8106ef54 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -224,19 +224,22 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
-	sector_t aligned_sector = (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
+	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
+	sector_t aligned_end = round_down(
+			sector + (size >> SECTOR_SHIFT), PAGE_SECTORS);
 	struct page *page;
 
-	size -= (aligned_sector - sector) * SECTOR_SIZE;
+	if (aligned_end <= aligned_sector)
+		return;
+
 	xa_lock(&brd->brd_pages);
-	while (size >= PAGE_SIZE && aligned_sector < rd_size * 2) {
+	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
 		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
 		if (page) {
 			__free_page(page);
 			brd->brd_nr_pages--;
 		}
 		aligned_sector += PAGE_SECTORS;
-		size -= PAGE_SIZE;
 	}
 	xa_unlock(&brd->brd_pages);
 }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0843d229b0f7..e9a197474b9d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -323,11 +323,14 @@ static void lo_complete_rq(struct request *rq)
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct loop_device *lo = rq->q->queuedata;
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
+	if (req_op(rq) == REQ_OP_WRITE)
+		file_end_write(lo->lo_backing_file);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -402,9 +405,10 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		cmd->iocb.ki_flags = 0;
 	}
 
-	if (rw == ITER_SOURCE)
+	if (rw == ITER_SOURCE) {
+		file_start_write(lo->lo_backing_file);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-	else
+	} else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 645047fb92fd..51d6d91ed404 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2705,7 +2705,7 @@ static int btintel_uefi_get_dsbr(u32 *dsbr_var)
 	} __packed data;
 
 	efi_status_t status;
-	unsigned long data_size = 0;
+	unsigned long data_size = sizeof(data);
 	efi_guid_t guid = EFI_GUID(0xe65d8884, 0xd4af, 0x4b20, 0x8d, 0x03,
 				   0x77, 0x2e, 0xcc, 0x3d, 0xa5, 0x31);
 
@@ -2715,16 +2715,10 @@ static int btintel_uefi_get_dsbr(u32 *dsbr_var)
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return -EOPNOTSUPP;
 
-	status = efi.get_variable(BTINTEL_EFI_DSBR, &guid, NULL, &data_size,
-				  NULL);
-
-	if (status != EFI_BUFFER_TOO_SMALL || !data_size)
-		return -EIO;
-
 	status = efi.get_variable(BTINTEL_EFI_DSBR, &guid, NULL, &data_size,
 				  &data);
 
-	if (status != EFI_SUCCESS)
+	if (status != EFI_SUCCESS || data_size != sizeof(data))
 		return -ENXIO;
 
 	*dsbr_var = data.dsbr;
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d225f0a37f98..34812bf7587d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -231,8 +231,13 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 {
 	int i, ret;
+	struct rxq *rxq = &data->rxq;
+
+	/* Post (BTINTEL_PCIE_RX_DESCS_COUNT - 3) buffers to overcome the
+	 * hardware issues leading to race condition at the firmware.
+	 */
 
-	for (i = 0; i < BTINTEL_PCIE_RX_MAX_QUEUE; i++) {
+	for (i = 0; i < rxq->count - 3; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
@@ -1147,8 +1152,8 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	 *  + size of index * Number of queues(2) * type of index array(4)
 	 *  + size of context information
 	 */
-	total = (sizeof(struct tfd) + sizeof(struct urbd0) + sizeof(struct frbd)
-		+ sizeof(struct urbd1)) * BTINTEL_DESCS_COUNT;
+	total = (sizeof(struct tfd) + sizeof(struct urbd0)) * BTINTEL_PCIE_TX_DESCS_COUNT;
+	total += (sizeof(struct frbd) + sizeof(struct urbd1)) * BTINTEL_PCIE_RX_DESCS_COUNT;
 
 	/* Add the sum of size of index array and size of ci struct */
 	total += (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4) + sizeof(struct ctx_info);
@@ -1173,36 +1178,36 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	data->dma_v_addr = v_addr;
 
 	/* Setup descriptor count */
-	data->txq.count = BTINTEL_DESCS_COUNT;
-	data->rxq.count = BTINTEL_DESCS_COUNT;
+	data->txq.count = BTINTEL_PCIE_TX_DESCS_COUNT;
+	data->rxq.count = BTINTEL_PCIE_RX_DESCS_COUNT;
 
 	/* Setup tfds */
 	data->txq.tfds_p_addr = p_addr;
 	data->txq.tfds = v_addr;
 
-	p_addr += (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	v_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
 
 	/* Setup urbd0 */
 	data->txq.urbd0s_p_addr = p_addr;
 	data->txq.urbd0s = v_addr;
 
-	p_addr += (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	v_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
 
 	/* Setup FRBD*/
 	data->rxq.frbds_p_addr = p_addr;
 	data->rxq.frbds = v_addr;
 
-	p_addr += (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	v_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
 
 	/* Setup urbd1 */
 	data->rxq.urbd1s_p_addr = p_addr;
 	data->rxq.urbd1s = v_addr;
 
-	p_addr += (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	v_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
 
 	/* Setup data buffers for txq */
 	err = btintel_pcie_setup_txq_bufs(data, &data->txq);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 8b7824ad005a..ee0eec0237af 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -81,8 +81,11 @@ enum {
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
 
-/* The number of descriptors in TX/RX queues */
-#define BTINTEL_DESCS_COUNT	16
+/* The number of descriptors in TX queues */
+#define BTINTEL_PCIE_TX_DESCS_COUNT	32
+
+/* The number of descriptors in RX queues */
+#define BTINTEL_PCIE_RX_DESCS_COUNT	64
 
 /* Number of Queue for TX and RX
  * It indicates the index of the IA(Index Array)
@@ -104,9 +107,6 @@ enum {
 /* Doorbell vector for TFD */
 #define BTINTEL_PCIE_TX_DB_VEC	0
 
-/* Number of pending RX requests for downlink */
-#define BTINTEL_PCIE_RX_MAX_QUEUE	6
-
 /* Doorbell vector for FRBD */
 #define BTINTEL_PCIE_RX_DB_VEC	513
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 930d8a3ba722..58d16ff166c2 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	if (mc_bus)
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index a18a8768feb4..6cb26b6e7347 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -271,6 +271,8 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL,
 				   "fw-clk-%s",
 				   rpi_firmware_clk_names[id]);
+	if (!init.name)
+		return ERR_PTR(-ENOMEM);
 	init.ops = &raspberrypi_firmware_clk_ops;
 	init.flags = CLK_GET_RATE_NOCACHE;
 
diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index f6634cc8663e..418668184ec3 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -1694,6 +1694,9 @@ static struct clk_branch camcc_sys_tmr_clk = {
 
 static struct gdsc bps_gdsc = {
 	.gdscr = 0x6004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "bps_gdsc",
 	},
@@ -1703,6 +1706,9 @@ static struct gdsc bps_gdsc = {
 
 static struct gdsc ipe_0_gdsc = {
 	.gdscr = 0x7004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ipe_0_gdsc",
 	},
@@ -1712,6 +1718,9 @@ static struct gdsc ipe_0_gdsc = {
 
 static struct gdsc ife_0_gdsc = {
 	.gdscr = 0x9004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ife_0_gdsc",
 	},
@@ -1720,6 +1729,9 @@ static struct gdsc ife_0_gdsc = {
 
 static struct gdsc ife_1_gdsc = {
 	.gdscr = 0xa004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ife_1_gdsc",
 	},
@@ -1728,6 +1740,9 @@ static struct gdsc ife_1_gdsc = {
 
 static struct gdsc ife_2_gdsc = {
 	.gdscr = 0xb004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ife_2_gdsc",
 	},
@@ -1736,6 +1751,9 @@ static struct gdsc ife_2_gdsc = {
 
 static struct gdsc titan_top_gdsc = {
 	.gdscr = 0x14004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "titan_top_gdsc",
 	},
diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index 2bc6b5f99f57..d52fd4b49a02 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -680,6 +680,9 @@ static struct clk_branch disp_cc_xo_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x1004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index 7431c9a65044..45193b3d714b 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -432,7 +432,7 @@ static const struct parent_map gcc_xo_gpll0_gpll1a_gpll6_sleep_map[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0, 1 },
 	{ P_GPLL1_AUX, 2 },
-	{ P_GPLL6, 2 },
+	{ P_GPLL6, 3 },
 	{ P_SLEEP_CLK, 6 },
 };
 
@@ -1113,7 +1113,7 @@ static struct clk_rcg2 jpeg0_clk_src = {
 };
 
 static const struct freq_tbl ftbl_gcc_camss_mclk0_1_clk[] = {
-	F(24000000, P_GPLL0, 1, 1, 45),
+	F(24000000, P_GPLL6, 1, 1, 45),
 	F(66670000, P_GPLL0, 12, 0, 0),
 	{ }
 };
diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 74346dc02606..a4d6dff9d0f7 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -2320,6 +2320,9 @@ static struct clk_branch gcc_video_xo_clk = {
 
 static struct gdsc usb30_prim_gdsc = {
 	.gdscr = 0x1a004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
@@ -2328,6 +2331,9 @@ static struct gdsc usb30_prim_gdsc = {
 
 static struct gdsc ufs_phy_gdsc = {
 	.gdscr = 0x3a004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ufs_phy_gdsc",
 	},
diff --git a/drivers/clk/qcom/gpucc-sm6350.c b/drivers/clk/qcom/gpucc-sm6350.c
index 1e12ad8948db..644bdc41892c 100644
--- a/drivers/clk/qcom/gpucc-sm6350.c
+++ b/drivers/clk/qcom/gpucc-sm6350.c
@@ -412,6 +412,9 @@ static struct clk_branch gpu_cc_gx_vsense_clk = {
 static struct gdsc gpu_cx_gdsc = {
 	.gdscr = 0x106c,
 	.gds_hw_ctrl = 0x1540,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x8,
 	.pd = {
 		.name = "gpu_cx_gdsc",
 	},
@@ -422,6 +425,9 @@ static struct gdsc gpu_cx_gdsc = {
 static struct gdsc gpu_gx_gdsc = {
 	.gdscr = 0x100c,
 	.clamp_io_ctrl = 0x1508,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x2,
 	.pd = {
 		.name = "gpu_gx_gdsc",
 		.power_on = gdsc_gx_do_nothing_enable,
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 229473855c5b..bc762ba87a19 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -3,12 +3,14 @@
  * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
  */
 
+#include <linux/cleanup.h>
 #include <linux/counter.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -19,6 +21,7 @@ struct interrupt_cnt_priv {
 	struct gpio_desc *gpio;
 	int irq;
 	bool enabled;
+	struct mutex lock;
 	struct counter_signal signals;
 	struct counter_synapse synapses;
 	struct counter_count cnts;
@@ -41,6 +44,8 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
+	guard(mutex)(&priv->lock);
+
 	*enable = priv->enabled;
 
 	return 0;
@@ -51,6 +56,8 @@ static int interrupt_cnt_enable_write(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
+	guard(mutex)(&priv->lock);
+
 	if (priv->enabled == enable)
 		return 0;
 
@@ -227,6 +234,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mutex_init(&priv->lock);
+
 	ret = devm_counter_add(dev, counter);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add counter\n");
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 19b7fb4a93e8..05f67661553c 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -275,13 +275,16 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	} else {
 		if (nr_sgs > 0)
 			dma_unmap_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
-		dma_unmap_sg(ce->dev, areq->dst, nd, DMA_FROM_DEVICE);
+
+		if (nr_sgd > 0)
+			dma_unmap_sg(ce->dev, areq->dst, nd, DMA_FROM_DEVICE);
 	}
 
 theend_iv:
 	if (areq->iv && ivsize > 0) {
-		if (rctx->addr_iv)
+		if (!dma_mapping_error(ce->dev, rctx->addr_iv))
 			dma_unmap_single(ce->dev, rctx->addr_iv, rctx->ivlen, DMA_TO_DEVICE);
+
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
 			memcpy(areq->iv, chan->backup_iv, ivsize);
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index e55e58e164db..fcc6832a065c 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -832,13 +832,12 @@ static int sun8i_ce_pm_init(struct sun8i_ce_dev *ce)
 	err = pm_runtime_set_suspended(ce->dev);
 	if (err)
 		return err;
-	pm_runtime_enable(ce->dev);
-	return err;
-}
 
-static void sun8i_ce_pm_exit(struct sun8i_ce_dev *ce)
-{
-	pm_runtime_disable(ce->dev);
+	err = devm_pm_runtime_enable(ce->dev);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int sun8i_ce_get_clks(struct sun8i_ce_dev *ce)
@@ -1041,7 +1040,7 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 			       "sun8i-ce-ns", ce);
 	if (err) {
 		dev_err(ce->dev, "Cannot request CryptoEngine Non-secure IRQ (err=%d)\n", err);
-		goto error_irq;
+		goto error_pm;
 	}
 
 	err = sun8i_ce_register_algs(ce);
@@ -1082,8 +1081,6 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 	return 0;
 error_alg:
 	sun8i_ce_unregister_algs(ce);
-error_irq:
-	sun8i_ce_pm_exit(ce);
 error_pm:
 	sun8i_ce_free_chanlist(ce, MAXFLOW - 1);
 	return err;
@@ -1104,8 +1101,6 @@ static void sun8i_ce_remove(struct platform_device *pdev)
 #endif
 
 	sun8i_ce_free_chanlist(ce, MAXFLOW - 1);
-
-	sun8i_ce_pm_exit(ce);
 }
 
 static const struct of_device_id sun8i_ce_crypto_of_match_table[] = {
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index 6072dd9f390b..3f9d79ea01aa 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -343,9 +343,8 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	u32 common;
 	u64 byte_count;
 	__le32 *bf;
-	void *buf = NULL;
+	void *buf, *result;
 	int j, i, todo;
-	void *result = NULL;
 	u64 bs;
 	int digestsize;
 	dma_addr_t addr_res, addr_pad;
@@ -365,14 +364,14 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	buf = kcalloc(2, bs, GFP_KERNEL | GFP_DMA);
 	if (!buf) {
 		err = -ENOMEM;
-		goto theend;
+		goto err_out;
 	}
 	bf = (__le32 *)buf;
 
 	result = kzalloc(digestsize, GFP_KERNEL | GFP_DMA);
 	if (!result) {
 		err = -ENOMEM;
-		goto theend;
+		goto err_free_buf;
 	}
 
 	flow = rctx->flow;
@@ -398,7 +397,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 		dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
-		goto theend;
+		goto err_free_result;
 	}
 
 	len = areq->nbytes;
@@ -411,7 +410,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (len > 0) {
 		dev_err(ce->dev, "remaining len %d\n", len);
 		err = -EINVAL;
-		goto theend;
+		goto err_unmap_src;
 	}
 	addr_res = dma_map_single(ce->dev, result, digestsize, DMA_FROM_DEVICE);
 	cet->t_dst[0].addr = desc_addr_val_le32(ce, addr_res);
@@ -419,7 +418,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (dma_mapping_error(ce->dev, addr_res)) {
 		dev_err(ce->dev, "DMA map dest\n");
 		err = -EINVAL;
-		goto theend;
+		goto err_unmap_src;
 	}
 
 	byte_count = areq->nbytes;
@@ -441,7 +440,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	}
 	if (!j) {
 		err = -EINVAL;
-		goto theend;
+		goto err_unmap_result;
 	}
 
 	addr_pad = dma_map_single(ce->dev, buf, j * 4, DMA_TO_DEVICE);
@@ -450,7 +449,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	if (dma_mapping_error(ce->dev, addr_pad)) {
 		dev_err(ce->dev, "DMA error on padding SG\n");
 		err = -EINVAL;
-		goto theend;
+		goto err_unmap_result;
 	}
 
 	if (ce->variant->hash_t_dlen_in_bits)
@@ -463,16 +462,25 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	err = sun8i_ce_run_task(ce, flow, crypto_ahash_alg_name(tfm));
 
 	dma_unmap_single(ce->dev, addr_pad, j * 4, DMA_TO_DEVICE);
-	dma_unmap_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
+
+err_unmap_result:
 	dma_unmap_single(ce->dev, addr_res, digestsize, DMA_FROM_DEVICE);
+	if (!err)
+		memcpy(areq->result, result, algt->alg.hash.base.halg.digestsize);
 
+err_unmap_src:
+	dma_unmap_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
 
-	memcpy(areq->result, result, algt->alg.hash.base.halg.digestsize);
-theend:
-	kfree(buf);
+err_free_result:
 	kfree(result);
+
+err_free_buf:
+	kfree(buf);
+
+err_out:
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
+
 	return 0;
 }
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 3b5c2af013d0..83df4d719053 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -308,8 +308,8 @@ struct sun8i_ce_hash_tfm_ctx {
  * @flow:	the flow to use for this request
  */
 struct sun8i_ce_hash_reqctx {
-	struct ahash_request fallback_req;
 	int flow;
+	struct ahash_request fallback_req; // keep at the end
 };
 
 /*
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 9b9605ce8ee6..8831bcb230c2 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -141,7 +141,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 
 	/* we need to copy all IVs from source in case DMA is bi-directionnal */
 	while (sg && len) {
-		if (sg_dma_len(sg) == 0) {
+		if (sg->length == 0) {
 			sg = sg_next(sg);
 			continue;
 		}
diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index 0f37dfd42d85..3876e3ce822f 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -459,6 +459,9 @@ static int mv_cesa_skcipher_queue_req(struct skcipher_request *req,
 	struct mv_cesa_skcipher_req *creq = skcipher_request_ctx(req);
 	struct mv_cesa_engine *engine;
 
+	if (!req->cryptlen)
+		return 0;
+
 	ret = mv_cesa_skcipher_req_init(req, tmpl);
 	if (ret)
 		return ret;
diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index f150861ceaf6..6815eddc9068 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -663,7 +663,7 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 	if (ret)
 		goto err_free_tdma;
 
-	if (iter.src.sg) {
+	if (iter.base.len > iter.src.op_offset) {
 		/*
 		 * Add all the new data, inserting an operation block and
 		 * launch command between each full SRAM block-worth of
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7d89385c3c45..38b54719587c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5572,7 +5572,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
-
+		if (!uc->name)
+			return -ENOMEM;
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
 		tasklet_setup(&uc->vc.task, udma_vchan_complete);
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index fbdf005bed3a..ac4b3d95531c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -95,7 +95,7 @@ static u32 offsets_demand2_spr[] = {0x22c70, 0x22d80, 0x22f18, 0x22d58, 0x22c64,
 static u32 offsets_demand_spr_hbm0[] = {0x2a54, 0x2a60, 0x2b10, 0x2a58, 0x2a5c, 0x0ee0};
 static u32 offsets_demand_spr_hbm1[] = {0x2e54, 0x2e60, 0x2f10, 0x2e58, 0x2e5c, 0x0fb0};
 
-static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable,
+static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable, u32 *rrl_ctl,
 				      u32 *offsets_scrub, u32 *offsets_demand,
 				      u32 *offsets_demand2)
 {
@@ -108,10 +108,10 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 
 	if (enable) {
 		/* Save default configurations */
-		imc->chan[chan].retry_rd_err_log_s = s;
-		imc->chan[chan].retry_rd_err_log_d = d;
+		rrl_ctl[0] = s;
+		rrl_ctl[1] = d;
 		if (offsets_demand2)
-			imc->chan[chan].retry_rd_err_log_d2 = d2;
+			rrl_ctl[2] = d2;
 
 		s &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
 		s |=  RETRY_RD_ERR_LOG_EN;
@@ -125,25 +125,25 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 		}
 	} else {
 		/* Restore default configurations */
-		if (imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_UC)
+		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_UC)
 			s |=  RETRY_RD_ERR_LOG_UC;
-		if (imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_NOOVER)
+		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_NOOVER)
 			s |=  RETRY_RD_ERR_LOG_NOOVER;
-		if (!(imc->chan[chan].retry_rd_err_log_s & RETRY_RD_ERR_LOG_EN))
+		if (!(rrl_ctl[0] & RETRY_RD_ERR_LOG_EN))
 			s &= ~RETRY_RD_ERR_LOG_EN;
-		if (imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_UC)
+		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_UC)
 			d |=  RETRY_RD_ERR_LOG_UC;
-		if (imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_NOOVER)
+		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_NOOVER)
 			d |=  RETRY_RD_ERR_LOG_NOOVER;
-		if (!(imc->chan[chan].retry_rd_err_log_d & RETRY_RD_ERR_LOG_EN))
+		if (!(rrl_ctl[1] & RETRY_RD_ERR_LOG_EN))
 			d &= ~RETRY_RD_ERR_LOG_EN;
 
 		if (offsets_demand2) {
-			if (imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_UC)
+			if (rrl_ctl[2] & RETRY_RD_ERR_LOG_UC)
 				d2 |=  RETRY_RD_ERR_LOG_UC;
-			if (!(imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_NOOVER))
+			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_NOOVER))
 				d2 &=  ~RETRY_RD_ERR_LOG_NOOVER;
-			if (!(imc->chan[chan].retry_rd_err_log_d2 & RETRY_RD_ERR_LOG_EN))
+			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_EN))
 				d2 &= ~RETRY_RD_ERR_LOG_EN;
 		}
 	}
@@ -157,6 +157,7 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 static void enable_retry_rd_err_log(bool enable)
 {
 	int i, j, imc_num, chan_num;
+	struct skx_channel *chan;
 	struct skx_imc *imc;
 	struct skx_dev *d;
 
@@ -171,8 +172,9 @@ static void enable_retry_rd_err_log(bool enable)
 			if (!imc->mbase)
 				continue;
 
+			chan = d->imc[i].chan;
 			for (j = 0; j < chan_num; j++)
-				__enable_retry_rd_err_log(imc, j, enable,
+				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
 							  res_cfg->offsets_scrub,
 							  res_cfg->offsets_demand,
 							  res_cfg->offsets_demand2);
@@ -186,12 +188,13 @@ static void enable_retry_rd_err_log(bool enable)
 			if (!imc->mbase || !imc->hbm_mc)
 				continue;
 
+			chan = d->imc[i].chan;
 			for (j = 0; j < chan_num; j++) {
-				__enable_retry_rd_err_log(imc, j, enable,
+				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[0],
 							  res_cfg->offsets_scrub_hbm0,
 							  res_cfg->offsets_demand_hbm0,
 							  NULL);
-				__enable_retry_rd_err_log(imc, j, enable,
+				__enable_retry_rd_err_log(imc, j, enable, chan[j].rrl_ctl[1],
 							  res_cfg->offsets_scrub_hbm1,
 							  res_cfg->offsets_demand_hbm1,
 							  NULL);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 85ec3196664d..88f5ff249f2e 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -115,6 +115,7 @@ EXPORT_SYMBOL_GPL(skx_adxl_get);
 
 void skx_adxl_put(void)
 {
+	adxl_component_count = 0;
 	kfree(adxl_values);
 	kfree(adxl_msg);
 }
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 849198fd14da..f40eb6e4f631 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -79,6 +79,9 @@
  */
 #define MCACOD_EXT_MEM_ERR	0x280
 
+/* Max RRL register sets per {,sub-,pseudo-}channel. */
+#define NUM_RRL_SET		3
+
 /*
  * Each cpu socket contains some pci devices that provide global
  * information, and also some that are local to each of the two
@@ -117,9 +120,11 @@ struct skx_dev {
 		struct skx_channel {
 			struct pci_dev	*cdev;
 			struct pci_dev	*edev;
-			u32 retry_rd_err_log_s;
-			u32 retry_rd_err_log_d;
-			u32 retry_rd_err_log_d2;
+			/*
+			 * Two groups of RRL control registers per channel to save default RRL
+			 * settings of two {sub-,pseudo-}channels in Linux RRL control mode.
+			 */
+			u32 rrl_ctl[2][NUM_RRL_SET];
 			struct skx_dimm {
 				u8 close_pg;
 				u8 bank_xor_enable;
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 9f35f69e0f9e..f7044bf53d1f 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -31,7 +31,6 @@ config ARM_SCPI_PROTOCOL
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
-	depends on ACPI_APEI_GHES
 	help
 	  The Software Delegated Exception Interface (SDEI) is an ARM
 	  standard for registering callbacks from the platform firmware
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 3e8051fe8296..71e2a9a89f6a 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1062,13 +1062,12 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
-void __init sdei_init(void)
+void __init acpi_sdei_init(void)
 {
 	struct platform_device *pdev;
 	int ret;
 
-	ret = platform_driver_register(&sdei_driver);
-	if (ret || !sdei_present_acpi())
+	if (!sdei_present_acpi())
 		return;
 
 	pdev = platform_device_register_simple(sdei_driver.driver.name,
@@ -1081,6 +1080,12 @@ void __init sdei_init(void)
 	}
 }
 
+static int __init sdei_init(void)
+{
+	return platform_driver_register(&sdei_driver);
+}
+arch_initcall(sdei_init);
+
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..1ad414da9920 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -603,6 +603,7 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
  * @image:	EFI loaded image protocol
  * @soft_limit:	preferred address for loading the initrd
  * @hard_limit:	upper limit address for loading the initrd
+ * @out:	pointer to store the address of the initrd table
  *
  * Return:	status code
  */
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2328ca58bba6..d6701d81cf68 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -759,8 +759,10 @@ int __init psci_dt_init(void)
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
-	if (!np || !of_device_is_available(np))
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	init_fn = (psci_initcall_t)matched_np->data;
 	ret = init_fn(np);
diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 9cb37aefbac4..1902ebf5a298 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -263,6 +263,7 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
 	img_buf = init_test_buffer(test, IMAGE_SIZE);
 
 	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 5c54c9fd4461..a76fc15a55f5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -144,6 +144,10 @@ int atomctrl_initialize_mc_reg_table(
 	vram_info = (ATOM_VRAM_INFO_HEADER_V2_1 *)
 		smu_atom_get_data_table(hwmgr->adev,
 				GetIndexIntoMasterTable(DATA, VRAM_Info), &size, &frev, &crev);
+	if (!vram_info) {
+		pr_err("Could not retrieve the VramInfo table!");
+		return -EINVAL;
+	}
 
 	if (module_index >= vram_info->ucNumOfVRAMModule) {
 		pr_err("Invalid VramInfo table.");
@@ -181,6 +185,10 @@ int atomctrl_initialize_mc_reg_table_v2_2(
 	vram_info = (ATOM_VRAM_INFO_HEADER_V2_2 *)
 		smu_atom_get_data_table(hwmgr->adev,
 				GetIndexIntoMasterTable(DATA, VRAM_Info), &size, &frev, &crev);
+	if (!vram_info) {
+		pr_err("Could not retrieve the VramInfo table!");
+		return -EINVAL;
+	}
 
 	if (module_index >= vram_info->ucNumOfVRAMModule) {
 		pr_err("Invalid VramInfo table.");
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 4d1d40e1f1b4..748bed8acd2d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -879,7 +879,11 @@ static int lt9611uxc_probe(struct i2c_client *client)
 		}
 	}
 
-	return lt9611uxc_audio_init(dev, lt9611uxc);
+	ret = lt9611uxc_audio_init(dev, lt9611uxc);
+	if (ret)
+		goto err_remove_bridge;
+
+	return 0;
 
 err_remove_bridge:
 	free_irq(client->irq, lt9611uxc);
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index 642bb15fb547..25c0424e34db 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -314,8 +314,8 @@
 #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(20, 16)
 #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
 #define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(12, 8)
-#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, val)
 #define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(4, 0)
-#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, val)
 
 #endif /* __INTEL_PSR_REGS_H__ */
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 8aaadbb702df..b48373b16677 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -633,7 +633,7 @@ static int guc_submission_send_busy_loop(struct intel_guc *guc,
 		atomic_inc(&guc->outstanding_submission_g2h);
 
 	ret = intel_guc_send_busy_loop(guc, action, len, g2h_len_dw, loop);
-	if (ret)
+	if (ret && g2h_len_dw)
 		atomic_dec(&guc->outstanding_submission_g2h);
 
 	return ret;
@@ -3422,18 +3422,29 @@ static inline int guc_lrc_desc_unpin(struct intel_context *ce)
 	 * GuC is active, lets destroy this context, but at this point we can still be racing
 	 * with suspend, so we undo everything if the H2G fails in deregister_context so
 	 * that GuC reset will find this context during clean up.
+	 *
+	 * There is a race condition where the reset code could have altered
+	 * this context's state and done a wakeref put before we try to
+	 * deregister it here. So check if the context is still set to be
+	 * destroyed before undoing earlier changes, to avoid two wakeref puts
+	 * on the same context.
 	 */
 	ret = deregister_context(ce, ce->guc_id.id);
 	if (ret) {
+		bool pending_destroyed;
 		spin_lock_irqsave(&ce->guc_state.lock, flags);
-		set_context_registered(ce);
-		clr_context_destroyed(ce);
+		pending_destroyed = context_destroyed(ce);
+		if (pending_destroyed) {
+			set_context_registered(ce);
+			clr_context_destroyed(ce);
+		}
 		spin_unlock_irqrestore(&ce->guc_state.lock, flags);
 		/*
 		 * As gt-pm is awake at function entry, intel_wakeref_put_async merely decrements
 		 * the wakeref immediately but per function spec usage call this after unlock.
 		 */
-		intel_wakeref_put_async(&gt->wakeref);
+		if (pending_destroyed)
+			intel_wakeref_put_async(&gt->wakeref);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 4e93fd075e03..42e62b040961 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -463,7 +463,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 
 	ret = drmm_mode_config_init(drm);
 	if (ret)
-		goto put_mutex_dev;
+		return ret;
 
 	drm->mode_config.min_width = 64;
 	drm->mode_config.min_height = 64;
@@ -481,8 +481,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	for (i = 0; i < private->data->mmsys_dev_num; i++) {
 		drm->dev_private = private->all_drm_private[i];
 		ret = component_bind_all(private->all_drm_private[i]->dev, drm);
-		if (ret)
-			goto put_mutex_dev;
+		if (ret) {
+			while (--i >= 0)
+				component_unbind_all(private->all_drm_private[i]->dev, drm);
+			return ret;
+		}
 	}
 
 	/*
@@ -575,9 +578,6 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 err_component_unbind:
 	for (i = 0; i < private->data->mmsys_dev_num; i++)
 		component_unbind_all(private->all_drm_private[i]->dev, drm);
-put_mutex_dev:
-	for (i = 0; i < private->data->mmsys_dev_num; i++)
-		put_device(private->all_drm_private[i]->mutex_dev);
 
 	return ret;
 }
@@ -648,8 +648,10 @@ static int mtk_drm_bind(struct device *dev)
 		return 0;
 
 	drm = drm_dev_alloc(&mtk_drm_driver, dev);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
+	if (IS_ERR(drm)) {
+		ret = PTR_ERR(drm);
+		goto err_put_dev;
+	}
 
 	private->drm_master = true;
 	drm->dev_private = private;
@@ -675,18 +677,31 @@ static int mtk_drm_bind(struct device *dev)
 	drm_dev_put(drm);
 	for (i = 0; i < private->data->mmsys_dev_num; i++)
 		private->all_drm_private[i]->drm = NULL;
+err_put_dev:
+	for (i = 0; i < private->data->mmsys_dev_num; i++) {
+		/* For device_find_child in mtk_drm_get_all_priv() */
+		put_device(private->all_drm_private[i]->dev);
+	}
+	put_device(private->mutex_dev);
 	return ret;
 }
 
 static void mtk_drm_unbind(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
+	int i;
 
 	/* for multi mmsys dev, unregister drm dev in mmsys master */
 	if (private->drm_master) {
 		drm_dev_unregister(private->drm);
 		mtk_drm_kms_deinit(private->drm);
 		drm_dev_put(private->drm);
+
+		for (i = 0; i < private->data->mmsys_dev_num; i++) {
+			/* For device_find_child in mtk_drm_get_all_priv() */
+			put_device(private->all_drm_private[i]->dev);
+		}
+		put_device(private->mutex_dev);
 	}
 	private->mtk_drm_bound = false;
 	private->drm_master = false;
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 4bd0baa2a4f5..f59452e8fa6f 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -168,7 +168,7 @@ static const struct meson_drm_soc_attr meson_drm_soc_attrs[] = {
 	/* S805X/S805Y HDMI PLL won't lock for HDMI PHY freq > 1,65GHz */
 	{
 		.limits = {
-			.max_hdmi_phy_freq = 1650000,
+			.max_hdmi_phy_freq = 1650000000,
 		},
 		.attrs = (const struct soc_device_attribute []) {
 			{ .soc_id = "GXL (S805*)", },
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 3f9345c14f31..be4b0e4df6e1 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -37,7 +37,7 @@ struct meson_drm_match_data {
 };
 
 struct meson_drm_soc_limits {
-	unsigned int max_hdmi_phy_freq;
+	unsigned long long max_hdmi_phy_freq;
 };
 
 struct meson_drm {
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 0593a1cde906..2ad8383fcaed 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -70,12 +70,12 @@ static void meson_encoder_hdmi_set_vclk(struct meson_encoder_hdmi *encoder_hdmi,
 {
 	struct meson_drm *priv = encoder_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
-	unsigned int phy_freq;
-	unsigned int vclk_freq;
-	unsigned int venc_freq;
-	unsigned int hdmi_freq;
+	unsigned long long phy_freq;
+	unsigned long long vclk_freq;
+	unsigned long long venc_freq;
+	unsigned long long hdmi_freq;
 
-	vclk_freq = mode->clock;
+	vclk_freq = mode->clock * 1000ULL;
 
 	/* For 420, pixel clock is half unlike venc clock */
 	if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
@@ -107,7 +107,8 @@ static void meson_encoder_hdmi_set_vclk(struct meson_encoder_hdmi *encoder_hdmi,
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		venc_freq /= 2;
 
-	dev_dbg(priv->dev, "vclk:%d phy=%d venc=%d hdmi=%d enci=%d\n",
+	dev_dbg(priv->dev,
+		"phy:%lluHz vclk=%lluHz venc=%lluHz hdmi=%lluHz enci=%d\n",
 		phy_freq, vclk_freq, venc_freq, hdmi_freq,
 		priv->venc.hdmi_use_enci);
 
@@ -122,10 +123,11 @@ static enum drm_mode_status meson_encoder_hdmi_mode_valid(struct drm_bridge *bri
 	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
 	struct meson_drm *priv = encoder_hdmi->priv;
 	bool is_hdmi2_sink = display_info->hdmi.scdc.supported;
-	unsigned int phy_freq;
-	unsigned int vclk_freq;
-	unsigned int venc_freq;
-	unsigned int hdmi_freq;
+	unsigned long long clock = mode->clock * 1000ULL;
+	unsigned long long phy_freq;
+	unsigned long long vclk_freq;
+	unsigned long long venc_freq;
+	unsigned long long hdmi_freq;
 	int vic = drm_match_cea_mode(mode);
 	enum drm_mode_status status;
 
@@ -144,12 +146,12 @@ static enum drm_mode_status meson_encoder_hdmi_mode_valid(struct drm_bridge *bri
 		if (status != MODE_OK)
 			return status;
 
-		return meson_vclk_dmt_supported_freq(priv, mode->clock);
+		return meson_vclk_dmt_supported_freq(priv, clock);
 	/* Check against supported VIC modes */
 	} else if (!meson_venc_hdmi_supported_vic(vic))
 		return MODE_BAD;
 
-	vclk_freq = mode->clock;
+	vclk_freq = clock;
 
 	/* For 420, pixel clock is half unlike venc clock */
 	if (drm_mode_is_420_only(display_info, mode) ||
@@ -179,7 +181,8 @@ static enum drm_mode_status meson_encoder_hdmi_mode_valid(struct drm_bridge *bri
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		venc_freq /= 2;
 
-	dev_dbg(priv->dev, "%s: vclk:%d phy=%d venc=%d hdmi=%d\n",
+	dev_dbg(priv->dev,
+		"%s: vclk:%lluHz phy=%lluHz venc=%lluHz hdmi=%lluHz\n",
 		__func__, phy_freq, vclk_freq, venc_freq, hdmi_freq);
 
 	return meson_vclk_vic_supported_freq(priv, phy_freq, vclk_freq);
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a82119eb58e..dfe0c28a0f05 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -110,7 +110,7 @@
 #define HDMI_PLL_LOCK		BIT(31)
 #define HDMI_PLL_LOCK_G12A	(3 << 30)
 
-#define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST(_freq * 1000, 1001)
+#define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST_ULL((_freq) * 1000ULL, 1001ULL)
 
 /* VID PLL Dividers */
 enum {
@@ -360,11 +360,11 @@ enum {
 };
 
 struct meson_vclk_params {
-	unsigned int pll_freq;
-	unsigned int phy_freq;
-	unsigned int vclk_freq;
-	unsigned int venc_freq;
-	unsigned int pixel_freq;
+	unsigned long long pll_freq;
+	unsigned long long phy_freq;
+	unsigned long long vclk_freq;
+	unsigned long long venc_freq;
+	unsigned long long pixel_freq;
 	unsigned int pll_od1;
 	unsigned int pll_od2;
 	unsigned int pll_od3;
@@ -372,11 +372,11 @@ struct meson_vclk_params {
 	unsigned int vclk_div;
 } params[] = {
 	[MESON_VCLK_HDMI_ENCI_54000] = {
-		.pll_freq = 4320000,
-		.phy_freq = 270000,
-		.vclk_freq = 54000,
-		.venc_freq = 54000,
-		.pixel_freq = 54000,
+		.pll_freq = 4320000000,
+		.phy_freq = 270000000,
+		.vclk_freq = 54000000,
+		.venc_freq = 54000000,
+		.pixel_freq = 54000000,
 		.pll_od1 = 4,
 		.pll_od2 = 4,
 		.pll_od3 = 1,
@@ -384,11 +384,11 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_DDR_54000] = {
-		.pll_freq = 4320000,
-		.phy_freq = 270000,
-		.vclk_freq = 54000,
-		.venc_freq = 54000,
-		.pixel_freq = 27000,
+		.pll_freq = 4320000000,
+		.phy_freq = 270000000,
+		.vclk_freq = 54000000,
+		.venc_freq = 54000000,
+		.pixel_freq = 27000000,
 		.pll_od1 = 4,
 		.pll_od2 = 4,
 		.pll_od3 = 1,
@@ -396,11 +396,11 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_DDR_148500] = {
-		.pll_freq = 2970000,
-		.phy_freq = 742500,
-		.vclk_freq = 148500,
-		.venc_freq = 148500,
-		.pixel_freq = 74250,
+		.pll_freq = 2970000000,
+		.phy_freq = 742500000,
+		.vclk_freq = 148500000,
+		.venc_freq = 148500000,
+		.pixel_freq = 74250000,
 		.pll_od1 = 4,
 		.pll_od2 = 1,
 		.pll_od3 = 1,
@@ -408,11 +408,11 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_74250] = {
-		.pll_freq = 2970000,
-		.phy_freq = 742500,
-		.vclk_freq = 74250,
-		.venc_freq = 74250,
-		.pixel_freq = 74250,
+		.pll_freq = 2970000000,
+		.phy_freq = 742500000,
+		.vclk_freq = 74250000,
+		.venc_freq = 74250000,
+		.pixel_freq = 74250000,
 		.pll_od1 = 2,
 		.pll_od2 = 2,
 		.pll_od3 = 2,
@@ -420,11 +420,11 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_148500] = {
-		.pll_freq = 2970000,
-		.phy_freq = 1485000,
-		.vclk_freq = 148500,
-		.venc_freq = 148500,
-		.pixel_freq = 148500,
+		.pll_freq = 2970000000,
+		.phy_freq = 1485000000,
+		.vclk_freq = 148500000,
+		.venc_freq = 148500000,
+		.pixel_freq = 148500000,
 		.pll_od1 = 1,
 		.pll_od2 = 2,
 		.pll_od3 = 2,
@@ -432,11 +432,11 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_297000] = {
-		.pll_freq = 5940000,
-		.phy_freq = 2970000,
-		.venc_freq = 297000,
-		.vclk_freq = 297000,
-		.pixel_freq = 297000,
+		.pll_freq = 5940000000,
+		.phy_freq = 2970000000,
+		.venc_freq = 297000000,
+		.vclk_freq = 297000000,
+		.pixel_freq = 297000000,
 		.pll_od1 = 2,
 		.pll_od2 = 1,
 		.pll_od3 = 1,
@@ -444,11 +444,11 @@ struct meson_vclk_params {
 		.vclk_div = 2,
 	},
 	[MESON_VCLK_HDMI_594000] = {
-		.pll_freq = 5940000,
-		.phy_freq = 5940000,
-		.venc_freq = 594000,
-		.vclk_freq = 594000,
-		.pixel_freq = 594000,
+		.pll_freq = 5940000000,
+		.phy_freq = 5940000000,
+		.venc_freq = 594000000,
+		.vclk_freq = 594000000,
+		.pixel_freq = 594000000,
 		.pll_od1 = 1,
 		.pll_od2 = 1,
 		.pll_od3 = 2,
@@ -456,11 +456,11 @@ struct meson_vclk_params {
 		.vclk_div = 1,
 	},
 	[MESON_VCLK_HDMI_594000_YUV420] = {
-		.pll_freq = 5940000,
-		.phy_freq = 2970000,
-		.venc_freq = 594000,
-		.vclk_freq = 594000,
-		.pixel_freq = 297000,
+		.pll_freq = 5940000000,
+		.phy_freq = 2970000000,
+		.venc_freq = 594000000,
+		.vclk_freq = 594000000,
+		.pixel_freq = 297000000,
 		.pll_od1 = 2,
 		.pll_od2 = 1,
 		.pll_od3 = 1,
@@ -617,16 +617,16 @@ static void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
 				3 << 20, pll_od_to_reg(od3) << 20);
 }
 
-#define XTAL_FREQ 24000
+#define XTAL_FREQ (24 * 1000 * 1000)
 
 static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
-					 unsigned int pll_freq)
+					 unsigned long long pll_freq)
 {
 	/* The GXBB PLL has a /2 pre-multiplier */
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
-		pll_freq /= 2;
+		pll_freq = DIV_ROUND_DOWN_ULL(pll_freq, 2);
 
-	return pll_freq / XTAL_FREQ;
+	return DIV_ROUND_DOWN_ULL(pll_freq, XTAL_FREQ);
 }
 
 #define HDMI_FRAC_MAX_GXBB	4096
@@ -635,12 +635,13 @@ static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
 
 static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
 					    unsigned int m,
-					    unsigned int pll_freq)
+					    unsigned long long pll_freq)
 {
-	unsigned int parent_freq = XTAL_FREQ;
+	unsigned long long parent_freq = XTAL_FREQ;
 	unsigned int frac_max = HDMI_FRAC_MAX_GXL;
 	unsigned int frac_m;
 	unsigned int frac;
+	u32 remainder;
 
 	/* The GXBB PLL has a /2 pre-multiplier and a larger FRAC width */
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
@@ -652,11 +653,11 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
 		frac_max = HDMI_FRAC_MAX_G12A;
 
 	/* We can have a perfect match !*/
-	if (pll_freq / m == parent_freq &&
-	    pll_freq % m == 0)
+	if (div_u64_rem(pll_freq, m, &remainder) == parent_freq &&
+	    remainder == 0)
 		return 0;
 
-	frac = div_u64((u64)pll_freq * (u64)frac_max, parent_freq);
+	frac = mul_u64_u64_div_u64(pll_freq, frac_max, parent_freq);
 	frac_m = m * frac_max;
 	if (frac_m > frac)
 		return frac_max;
@@ -666,7 +667,7 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
 }
 
 static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
-					   unsigned int m,
+					   unsigned long long m,
 					   unsigned int frac)
 {
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
@@ -694,7 +695,7 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
 }
 
 static bool meson_hdmi_pll_find_params(struct meson_drm *priv,
-				       unsigned int freq,
+				       unsigned long long freq,
 				       unsigned int *m,
 				       unsigned int *frac,
 				       unsigned int *od)
@@ -706,7 +707,7 @@ static bool meson_hdmi_pll_find_params(struct meson_drm *priv,
 			continue;
 		*frac = meson_hdmi_pll_get_frac(priv, *m, freq * *od);
 
-		DRM_DEBUG_DRIVER("PLL params for %dkHz: m=%x frac=%x od=%d\n",
+		DRM_DEBUG_DRIVER("PLL params for %lluHz: m=%x frac=%x od=%d\n",
 				 freq, *m, *frac, *od);
 
 		if (meson_hdmi_pll_validate_params(priv, *m, *frac))
@@ -718,7 +719,7 @@ static bool meson_hdmi_pll_find_params(struct meson_drm *priv,
 
 /* pll_freq is the frequency after the OD dividers */
 enum drm_mode_status
-meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq)
+meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned long long freq)
 {
 	unsigned int od, m, frac;
 
@@ -741,7 +742,7 @@ EXPORT_SYMBOL_GPL(meson_vclk_dmt_supported_freq);
 
 /* pll_freq is the frequency after the OD dividers */
 static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
-				       unsigned int pll_freq)
+				       unsigned long long pll_freq)
 {
 	unsigned int od, m, frac, od1, od2, od3;
 
@@ -756,7 +757,7 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
 			od1 = od / od2;
 		}
 
-		DRM_DEBUG_DRIVER("PLL params for %dkHz: m=%x frac=%x od=%d/%d/%d\n",
+		DRM_DEBUG_DRIVER("PLL params for %lluHz: m=%x frac=%x od=%d/%d/%d\n",
 				 pll_freq, m, frac, od1, od2, od3);
 
 		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
@@ -764,17 +765,48 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
 		return;
 	}
 
-	DRM_ERROR("Fatal, unable to find parameters for PLL freq %d\n",
+	DRM_ERROR("Fatal, unable to find parameters for PLL freq %lluHz\n",
 		  pll_freq);
 }
 
+static bool meson_vclk_freqs_are_matching_param(unsigned int idx,
+						unsigned long long phy_freq,
+						unsigned long long vclk_freq)
+{
+	DRM_DEBUG_DRIVER("i = %d vclk_freq = %lluHz alt = %lluHz\n",
+			 idx, params[idx].vclk_freq,
+			 FREQ_1000_1001(params[idx].vclk_freq));
+	DRM_DEBUG_DRIVER("i = %d phy_freq = %lluHz alt = %lluHz\n",
+			 idx, params[idx].phy_freq,
+			 FREQ_1000_1001(params[idx].phy_freq));
+
+	/* Match strict frequency */
+	if (phy_freq == params[idx].phy_freq &&
+	    vclk_freq == params[idx].vclk_freq)
+		return true;
+
+	/* Match 1000/1001 variant: vclk deviation has to be less than 1kHz
+	 * (drm EDID is defined in 1kHz steps, so everything smaller must be
+	 * rounding error) and the PHY freq deviation has to be less than
+	 * 10kHz (as the TMDS clock is 10 times the pixel clock, so anything
+	 * smaller must be rounding error as well).
+	 */
+	if (abs(vclk_freq - FREQ_1000_1001(params[idx].vclk_freq)) < 1000 &&
+	    abs(phy_freq - FREQ_1000_1001(params[idx].phy_freq)) < 10000)
+		return true;
+
+	/* no match */
+	return false;
+}
+
 enum drm_mode_status
-meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
-			      unsigned int vclk_freq)
+meson_vclk_vic_supported_freq(struct meson_drm *priv,
+			      unsigned long long phy_freq,
+			      unsigned long long vclk_freq)
 {
 	int i;
 
-	DRM_DEBUG_DRIVER("phy_freq = %d vclk_freq = %d\n",
+	DRM_DEBUG_DRIVER("phy_freq = %lluHz vclk_freq = %lluHz\n",
 			 phy_freq, vclk_freq);
 
 	/* Check against soc revision/package limits */
@@ -785,19 +817,7 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 	}
 
 	for (i = 0 ; params[i].pixel_freq ; ++i) {
-		DRM_DEBUG_DRIVER("i = %d pixel_freq = %d alt = %d\n",
-				 i, params[i].pixel_freq,
-				 FREQ_1000_1001(params[i].pixel_freq));
-		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
-				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/10)*10);
-		/* Match strict frequency */
-		if (phy_freq == params[i].phy_freq &&
-		    vclk_freq == params[i].vclk_freq)
-			return MODE_OK;
-		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
-		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
+		if (meson_vclk_freqs_are_matching_param(i, phy_freq, vclk_freq))
 			return MODE_OK;
 	}
 
@@ -805,8 +825,9 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 }
 EXPORT_SYMBOL_GPL(meson_vclk_vic_supported_freq);
 
-static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
-			   unsigned int od1, unsigned int od2, unsigned int od3,
+static void meson_vclk_set(struct meson_drm *priv,
+			   unsigned long long pll_base_freq, unsigned int od1,
+			   unsigned int od2, unsigned int od3,
 			   unsigned int vid_pll_div, unsigned int vclk_div,
 			   unsigned int hdmi_tx_div, unsigned int venc_div,
 			   bool hdmi_use_enci, bool vic_alternate_clock)
@@ -826,15 +847,15 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 		meson_hdmi_pll_generic_set(priv, pll_base_freq);
 	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
 		switch (pll_base_freq) {
-		case 2970000:
+		case 2970000000:
 			m = 0x3d;
 			frac = vic_alternate_clock ? 0xd02 : 0xe00;
 			break;
-		case 4320000:
+		case 4320000000:
 			m = vic_alternate_clock ? 0x59 : 0x5a;
 			frac = vic_alternate_clock ? 0xe8f : 0;
 			break;
-		case 5940000:
+		case 5940000000:
 			m = 0x7b;
 			frac = vic_alternate_clock ? 0xa05 : 0xc00;
 			break;
@@ -844,15 +865,15 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
 		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
 		switch (pll_base_freq) {
-		case 2970000:
+		case 2970000000:
 			m = 0x7b;
 			frac = vic_alternate_clock ? 0x281 : 0x300;
 			break;
-		case 4320000:
+		case 4320000000:
 			m = vic_alternate_clock ? 0xb3 : 0xb4;
 			frac = vic_alternate_clock ? 0x347 : 0;
 			break;
-		case 5940000:
+		case 5940000000:
 			m = 0xf7;
 			frac = vic_alternate_clock ? 0x102 : 0x200;
 			break;
@@ -861,15 +882,15 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
 	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
 		switch (pll_base_freq) {
-		case 2970000:
+		case 2970000000:
 			m = 0x7b;
 			frac = vic_alternate_clock ? 0x140b4 : 0x18000;
 			break;
-		case 4320000:
+		case 4320000000:
 			m = vic_alternate_clock ? 0xb3 : 0xb4;
 			frac = vic_alternate_clock ? 0x1a3ee : 0;
 			break;
-		case 5940000:
+		case 5940000000:
 			m = 0xf7;
 			frac = vic_alternate_clock ? 0x8148 : 0x10000;
 			break;
@@ -1025,14 +1046,14 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 }
 
 void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
-		      unsigned int phy_freq, unsigned int vclk_freq,
-		      unsigned int venc_freq, unsigned int dac_freq,
+		      unsigned long long phy_freq, unsigned long long vclk_freq,
+		      unsigned long long venc_freq, unsigned long long dac_freq,
 		      bool hdmi_use_enci)
 {
 	bool vic_alternate_clock = false;
-	unsigned int freq;
-	unsigned int hdmi_tx_div;
-	unsigned int venc_div;
+	unsigned long long freq;
+	unsigned long long hdmi_tx_div;
+	unsigned long long venc_div;
 
 	if (target == MESON_VCLK_TARGET_CVBS) {
 		meson_venci_cvbs_clock_config(priv);
@@ -1052,27 +1073,25 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		return;
 	}
 
-	hdmi_tx_div = vclk_freq / dac_freq;
+	hdmi_tx_div = DIV_ROUND_DOWN_ULL(vclk_freq, dac_freq);
 
 	if (hdmi_tx_div == 0) {
-		pr_err("Fatal Error, invalid HDMI-TX freq %d\n",
+		pr_err("Fatal Error, invalid HDMI-TX freq %lluHz\n",
 		       dac_freq);
 		return;
 	}
 
-	venc_div = vclk_freq / venc_freq;
+	venc_div = DIV_ROUND_DOWN_ULL(vclk_freq, venc_freq);
 
 	if (venc_div == 0) {
-		pr_err("Fatal Error, invalid HDMI venc freq %d\n",
+		pr_err("Fatal Error, invalid HDMI venc freq %lluHz\n",
 		       venc_freq);
 		return;
 	}
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
-		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
-		    (vclk_freq == params[freq].vclk_freq ||
-		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
+		if (meson_vclk_freqs_are_matching_param(freq, phy_freq,
+							vclk_freq)) {
 			if (vclk_freq != params[freq].vclk_freq)
 				vic_alternate_clock = true;
 			else
@@ -1098,7 +1117,8 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 	}
 
 	if (!params[freq].pixel_freq) {
-		pr_err("Fatal Error, invalid HDMI vclk freq %d\n", vclk_freq);
+		pr_err("Fatal Error, invalid HDMI vclk freq %lluHz\n",
+		       vclk_freq);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/meson/meson_vclk.h b/drivers/gpu/drm/meson/meson_vclk.h
index 60617aaf18dd..7ac55744e574 100644
--- a/drivers/gpu/drm/meson/meson_vclk.h
+++ b/drivers/gpu/drm/meson/meson_vclk.h
@@ -20,17 +20,18 @@ enum {
 };
 
 /* 27MHz is the CVBS Pixel Clock */
-#define MESON_VCLK_CVBS			27000
+#define MESON_VCLK_CVBS			(27 * 1000 * 1000)
 
 enum drm_mode_status
-meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq);
+meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned long long freq);
 enum drm_mode_status
-meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
-			      unsigned int vclk_freq);
+meson_vclk_vic_supported_freq(struct meson_drm *priv,
+			      unsigned long long phy_freq,
+			      unsigned long long vclk_freq);
 
 void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
-		      unsigned int phy_freq, unsigned int vclk_freq,
-		      unsigned int venc_freq, unsigned int dac_freq,
+		      unsigned long long phy_freq, unsigned long long vclk_freq,
+		      unsigned long long venc_freq, unsigned long long dac_freq,
 		      bool hdmi_use_enci);
 
 #endif /* __MESON_VCLK_H */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d903ad9c0b5f..d2189441aa38 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -554,7 +554,6 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	if (adreno_is_7c3(gpu)) {
 		gpu->ubwc_config.highest_bank_bit = 14;
 		gpu->ubwc_config.amsbc = 1;
-		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 36cc9dbc00b5..d8d5a91c00ec 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -76,7 +76,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	{
 		.name = "sspp_0", .id = SSPP_VIG0,
 		.base = 0x4000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 0,
 		.type = SSPP_TYPE_VIG,
@@ -84,7 +84,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_1", .id = SSPP_VIG1,
 		.base = 0x6000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 4,
 		.type = SSPP_TYPE_VIG,
@@ -92,7 +92,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_2", .id = SSPP_VIG2,
 		.base = 0x8000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 8,
 		.type = SSPP_TYPE_VIG,
@@ -100,7 +100,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_3", .id = SSPP_VIG3,
 		.base = 0xa000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 12,
 		.type = SSPP_TYPE_VIG,
@@ -108,7 +108,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_8", .id = SSPP_DMA0,
 		.base = 0x24000, .len = 0x1f0,
-		.features = DMA_SDM845_MASK,
+		.features = DMA_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 1,
 		.type = SSPP_TYPE_DMA,
@@ -116,7 +116,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_9", .id = SSPP_DMA1,
 		.base = 0x26000, .len = 0x1f0,
-		.features = DMA_SDM845_MASK,
+		.features = DMA_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 5,
 		.type = SSPP_TYPE_DMA,
@@ -124,7 +124,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_10", .id = SSPP_DMA2,
 		.base = 0x28000, .len = 0x1f0,
-		.features = DMA_CURSOR_SDM845_MASK,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 9,
 		.type = SSPP_TYPE_DMA,
@@ -132,7 +132,7 @@ static const struct dpu_sspp_cfg sm8150_sspp[] = {
 	}, {
 		.name = "sspp_11", .id = SSPP_DMA3,
 		.base = 0x2a000, .len = 0x1f0,
-		.features = DMA_CURSOR_SDM845_MASK,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 13,
 		.type = SSPP_TYPE_DMA,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index e8eacdb47967..485c3041c801 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -75,7 +75,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	{
 		.name = "sspp_0", .id = SSPP_VIG0,
 		.base = 0x4000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 0,
 		.type = SSPP_TYPE_VIG,
@@ -83,7 +83,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_1", .id = SSPP_VIG1,
 		.base = 0x6000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 4,
 		.type = SSPP_TYPE_VIG,
@@ -91,7 +91,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_2", .id = SSPP_VIG2,
 		.base = 0x8000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 8,
 		.type = SSPP_TYPE_VIG,
@@ -99,7 +99,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_3", .id = SSPP_VIG3,
 		.base = 0xa000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 12,
 		.type = SSPP_TYPE_VIG,
@@ -107,7 +107,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_8", .id = SSPP_DMA0,
 		.base = 0x24000, .len = 0x1f0,
-		.features = DMA_SDM845_MASK,
+		.features = DMA_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 1,
 		.type = SSPP_TYPE_DMA,
@@ -115,7 +115,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_9", .id = SSPP_DMA1,
 		.base = 0x26000, .len = 0x1f0,
-		.features = DMA_SDM845_MASK,
+		.features = DMA_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 5,
 		.type = SSPP_TYPE_DMA,
@@ -123,7 +123,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_10", .id = SSPP_DMA2,
 		.base = 0x28000, .len = 0x1f0,
-		.features = DMA_CURSOR_SDM845_MASK,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 9,
 		.type = SSPP_TYPE_DMA,
@@ -131,7 +131,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_11", .id = SSPP_DMA3,
 		.base = 0x2a000, .len = 0x1f0,
-		.features = DMA_CURSOR_SDM845_MASK,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 13,
 		.type = SSPP_TYPE_DMA,
diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index 04ce925b3d9d..49cfa84b34f0 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -22,7 +22,6 @@ struct sofef00_panel {
 	struct mipi_dsi_device *dsi;
 	struct regulator *supply;
 	struct gpio_desc *reset_gpio;
-	const struct drm_display_mode *mode;
 };
 
 static inline
@@ -159,26 +158,11 @@ static const struct drm_display_mode enchilada_panel_mode = {
 	.height_mm = 145,
 };
 
-static const struct drm_display_mode fajita_panel_mode = {
-	.clock = (1080 + 72 + 16 + 36) * (2340 + 32 + 4 + 18) * 60 / 1000,
-	.hdisplay = 1080,
-	.hsync_start = 1080 + 72,
-	.hsync_end = 1080 + 72 + 16,
-	.htotal = 1080 + 72 + 16 + 36,
-	.vdisplay = 2340,
-	.vsync_start = 2340 + 32,
-	.vsync_end = 2340 + 32 + 4,
-	.vtotal = 2340 + 32 + 4 + 18,
-	.width_mm = 68,
-	.height_mm = 145,
-};
-
 static int sofef00_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector)
 {
 	struct drm_display_mode *mode;
-	struct sofef00_panel *ctx = to_sofef00_panel(panel);
 
-	mode = drm_mode_duplicate(connector->dev, ctx->mode);
+	mode = drm_mode_duplicate(connector->dev, &enchilada_panel_mode);
 	if (!mode)
 		return -ENOMEM;
 
@@ -239,13 +223,6 @@ static int sofef00_panel_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->mode = of_device_get_match_data(dev);
-
-	if (!ctx->mode) {
-		dev_err(dev, "Missing device mode\n");
-		return -ENODEV;
-	}
-
 	ctx->supply = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(ctx->supply))
 		return dev_err_probe(dev, PTR_ERR(ctx->supply),
@@ -295,14 +272,7 @@ static void sofef00_panel_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id sofef00_panel_of_match[] = {
-	{ // OnePlus 6 / enchilada
-		.compatible = "samsung,sofef00",
-		.data = &enchilada_panel_mode,
-	},
-	{ // OnePlus 6T / fajita
-		.compatible = "samsung,s6e3fc2x01",
-		.data = &fajita_panel_mode,
-	},
+	{ .compatible = "samsung,sofef00" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sofef00_panel_of_match);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d041ff542a4e..82db3daf4f81 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2141,13 +2141,14 @@ static const struct display_timing evervision_vgg644804_timing = {
 static const struct panel_desc evervision_vgg644804 = {
 	.timings = &evervision_vgg644804_timing,
 	.num_timings = 1,
-	.bpc = 8,
+	.bpc = 6,
 	.size = {
 		.width = 115,
 		.height = 86,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
-	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 static const struct display_timing evervision_vgg804821_timing = {
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 0e6f94df690d..b57824abeb9e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -780,6 +780,7 @@ int panthor_vm_active(struct panthor_vm *vm)
 	if (ptdev->mmu->as.faulty_mask & panthor_mmu_as_fault_mask(ptdev, as)) {
 		gpu_write(ptdev, MMU_INT_CLEAR, panthor_mmu_as_fault_mask(ptdev, as));
 		ptdev->mmu->as.faulty_mask &= ~panthor_mmu_as_fault_mask(ptdev, as);
+		ptdev->mmu->irq.mask |= panthor_mmu_as_fault_mask(ptdev, as);
 		gpu_write(ptdev, MMU_INT_MASK, ~ptdev->mmu->as.faulty_mask);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index b7b3b3add166..a7a323dc5cf9 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -133,8 +133,8 @@
 #define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
 
 #define GPU_COHERENCY_PROTOCOL				0x304
-#define   GPU_COHERENCY_ACE				0
-#define   GPU_COHERENCY_ACE_LITE			1
+#define   GPU_COHERENCY_ACE_LITE			0
+#define   GPU_COHERENCY_ACE				1
 #define   GPU_COHERENCY_NONE				31
 
 #define MCU_CONTROL					0x700
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
index 70d8ad065bfa..4c8fe83dd610 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
@@ -705,7 +705,7 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
 		ret = of_parse_phandle_with_fixed_args(np, vsps_prop_name,
 						       cells, i, &args);
 		if (ret < 0)
-			goto error;
+			goto done;
 
 		/*
 		 * Add the VSP to the list or update the corresponding existing
@@ -743,13 +743,11 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
 		vsp->dev = rcdu;
 
 		ret = rcar_du_vsp_init(vsp, vsps[i].np, vsps[i].crtcs_mask);
-		if (ret < 0)
-			goto error;
+		if (ret)
+			goto done;
 	}
 
-	return 0;
-
-error:
+done:
 	for (i = 0; i < ARRAY_SIZE(vsps); ++i)
 		of_node_put(vsps[i].np);
 
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 1e8ec50b759e..ff5a749710db 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -200,6 +200,11 @@ static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helper_funcs = {
 	.atomic_check = tegra_rgb_encoder_atomic_check,
 };
 
+static void tegra_dc_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 int tegra_dc_rgb_probe(struct tegra_dc *dc)
 {
 	struct device_node *np;
@@ -207,7 +212,14 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	int err;
 
 	np = of_get_child_by_name(dc->dev->of_node, "rgb");
-	if (!np || !of_device_is_available(np))
+	if (!np)
+		return -ENODEV;
+
+	err = devm_add_action_or_reset(dc->dev, tegra_dc_of_node_put, np);
+	if (err < 0)
+		return err;
+
+	if (!of_device_is_available(np))
 		return -ENODEV;
 
 	rgb = devm_kzalloc(dc->dev, sizeof(*rgb), GFP_KERNEL);
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
index e70d7c3076ac..f0ddc223c1f8 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
@@ -75,24 +75,30 @@ int vc4_mock_atomic_add_output(struct kunit *test,
 	int ret;
 
 	encoder = vc4_find_encoder_by_type(drm, type);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder);
+	if (!encoder)
+		return -ENODEV;
 
 	crtc = vc4_find_crtc_for_encoder(test, drm, encoder);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	if (!crtc)
+		return -ENODEV;
 
 	output = encoder_to_vc4_dummy_output(encoder);
 	conn = &output->connector;
 	conn_state = drm_atomic_get_connector_state(state, conn);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
 
 	ret = drm_atomic_set_crtc_for_connector(conn_state, crtc);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		return ret;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
 
 	ret = drm_atomic_set_mode_for_crtc(crtc_state, &default_mode);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		return ret;
 
 	crtc_state->active = true;
 
@@ -113,26 +119,32 @@ int vc4_mock_atomic_del_output(struct kunit *test,
 	int ret;
 
 	encoder = vc4_find_encoder_by_type(drm, type);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder);
+	if (!encoder)
+		return -ENODEV;
 
 	crtc = vc4_find_crtc_for_encoder(test, drm, encoder);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	if (!crtc)
+		return -ENODEV;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
 
 	crtc_state->active = false;
 
 	ret = drm_atomic_set_mode_for_crtc(crtc_state, NULL);
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	if (ret)
+		return ret;
 
 	output = encoder_to_vc4_dummy_output(encoder);
 	conn = &output->connector;
 	conn_state = drm_atomic_get_connector_state(state, conn);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
 
 	ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 40b4d084e3ce..91b589a497d0 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -198,7 +198,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		i++;
 	}
 
-	vkms_state->active_planes = kcalloc(i, sizeof(plane), GFP_KERNEL);
+	vkms_state->active_planes = kcalloc(i, sizeof(*vkms_state->active_planes), GFP_KERNEL);
 	if (!vkms_state->active_planes)
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 183cda50094c..e8e49f13cfa2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -51,11 +51,13 @@ static void vmw_bo_release(struct vmw_bo *vbo)
 			mutex_lock(&res->dev_priv->cmdbuf_mutex);
 			(void)vmw_resource_reserve(res, false, true);
 			vmw_resource_mob_detach(res);
+			if (res->dirty)
+				res->func->dirty_free(res);
 			if (res->coherent)
 				vmw_bo_dirty_release(res->guest_memory_bo);
 			res->guest_memory_bo = NULL;
 			res->guest_memory_offset = 0;
-			vmw_resource_unreserve(res, false, false, false, NULL,
+			vmw_resource_unreserve(res, true, false, false, NULL,
 					       0);
 			mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 		}
@@ -73,9 +75,9 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 {
 	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
 
-	WARN_ON(vbo->dirty);
 	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
 	vmw_bo_release(vbo);
+	WARN_ON(vbo->dirty);
 	kfree(vbo);
 }
 
@@ -849,9 +851,9 @@ void vmw_bo_placement_set_default_accelerated(struct vmw_bo *bo)
 	vmw_bo_placement_set(bo, domain, domain);
 }
 
-void vmw_bo_add_detached_resource(struct vmw_bo *vbo, struct vmw_resource *res)
+int vmw_bo_add_detached_resource(struct vmw_bo *vbo, struct vmw_resource *res)
 {
-	xa_store(&vbo->detached_resources, (unsigned long)res, res, GFP_KERNEL);
+	return xa_err(xa_store(&vbo->detached_resources, (unsigned long)res, res, GFP_KERNEL));
 }
 
 void vmw_bo_del_detached_resource(struct vmw_bo *vbo, struct vmw_resource *res)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index c21ba7ff7736..940c0a0b9c45 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -142,7 +142,7 @@ void vmw_bo_move_notify(struct ttm_buffer_object *bo,
 			struct ttm_resource *mem);
 void vmw_bo_swap_notify(struct ttm_buffer_object *bo);
 
-void vmw_bo_add_detached_resource(struct vmw_bo *vbo, struct vmw_resource *res);
+int vmw_bo_add_detached_resource(struct vmw_bo *vbo, struct vmw_resource *res);
 void vmw_bo_del_detached_resource(struct vmw_bo *vbo, struct vmw_resource *res);
 struct vmw_surface *vmw_bo_surface(struct vmw_bo *vbo);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 2e52d73eba48..ea741bc4ac3f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -4086,6 +4086,23 @@ static int vmw_execbuf_tie_context(struct vmw_private *dev_priv,
 	return 0;
 }
 
+/*
+ * DMA fence callback to remove a seqno_waiter
+ */
+struct seqno_waiter_rm_context {
+	struct dma_fence_cb base;
+	struct vmw_private *dev_priv;
+};
+
+static void seqno_waiter_rm_cb(struct dma_fence *f, struct dma_fence_cb *cb)
+{
+	struct seqno_waiter_rm_context *ctx =
+		container_of(cb, struct seqno_waiter_rm_context, base);
+
+	vmw_seqno_waiter_remove(ctx->dev_priv);
+	kfree(ctx);
+}
+
 int vmw_execbuf_process(struct drm_file *file_priv,
 			struct vmw_private *dev_priv,
 			void __user *user_commands, void *kernel_commands,
@@ -4266,6 +4283,15 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 		} else {
 			/* Link the fence with the FD created earlier */
 			fd_install(out_fence_fd, sync_file->file);
+			struct seqno_waiter_rm_context *ctx =
+				kmalloc(sizeof(*ctx), GFP_KERNEL);
+			ctx->dev_priv = dev_priv;
+			vmw_seqno_waiter_add(dev_priv);
+			if (dma_fence_add_callback(&fence->base, &ctx->base,
+						   seqno_waiter_rm_cb) < 0) {
+				vmw_seqno_waiter_remove(dev_priv);
+				kfree(ctx);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index a73af8a355fb..c4d5fe5f330f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -273,7 +273,7 @@ int vmw_user_resource_lookup_handle(struct vmw_private *dev_priv,
 		goto out_bad_resource;
 
 	res = converter->base_obj_to_res(base);
-	kref_get(&res->kref);
+	vmw_resource_reference(res);
 
 	*p_res = res;
 	ret = 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5721c74da3e0..d7a8070330ba 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -658,7 +658,7 @@ static void vmw_user_surface_free(struct vmw_resource *res)
 	struct vmw_user_surface *user_srf =
 	    container_of(srf, struct vmw_user_surface, srf);
 
-	WARN_ON_ONCE(res->dirty);
+	WARN_ON(res->dirty);
 	if (user_srf->master)
 		drm_master_put(&user_srf->master);
 	kfree(srf->offsets);
@@ -689,8 +689,7 @@ static void vmw_user_surface_base_release(struct ttm_base_object **p_base)
 	 * Dumb buffers own the resource and they'll unref the
 	 * resource themselves
 	 */
-	if (res && res->guest_memory_bo && res->guest_memory_bo->is_dumb)
-		return;
+	WARN_ON(res && res->guest_memory_bo && res->guest_memory_bo->is_dumb);
 
 	vmw_resource_unreference(&res);
 }
@@ -871,7 +870,12 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 			vmw_resource_unreference(&res);
 			goto out_unlock;
 		}
-		vmw_bo_add_detached_resource(res->guest_memory_bo, res);
+
+		ret = vmw_bo_add_detached_resource(res->guest_memory_bo, res);
+		if (unlikely(ret != 0)) {
+			vmw_resource_unreference(&res);
+			goto out_unlock;
+		}
 	}
 
 	tmp = vmw_resource_reference(&srf->res);
@@ -1670,6 +1674,14 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 
 	}
 
+	if (res->guest_memory_bo) {
+		ret = vmw_bo_add_detached_resource(res->guest_memory_bo, res);
+		if (unlikely(ret != 0)) {
+			vmw_resource_unreference(&res);
+			goto out_unlock;
+		}
+	}
+
 	tmp = vmw_resource_reference(res);
 	ret = ttm_prime_object_init(tfile, res->guest_memory_size, &user_srf->prime,
 				    VMW_RES_SURFACE,
@@ -1684,7 +1696,6 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 	rep->handle      = user_srf->prime.base.handle;
 	rep->backup_size = res->guest_memory_size;
 	if (res->guest_memory_bo) {
-		vmw_bo_add_detached_resource(res->guest_memory_bo, res);
 		rep->buffer_map_handle =
 			drm_vma_node_offset_addr(&res->guest_memory_bo->tbo.base.vma_node);
 		rep->buffer_size = res->guest_memory_bo->tbo.base.size;
@@ -2358,12 +2369,19 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	vbo = res->guest_memory_bo;
 	vbo->is_dumb = true;
 	vbo->dumb_surface = vmw_res_to_srf(res);
-
+	drm_gem_object_put(&vbo->tbo.base);
+	/*
+	 * Unset the user surface dtor since this in not actually exposed
+	 * to userspace. The suface is owned via the dumb_buffer's GEM handle
+	 */
+	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
+						struct vmw_user_surface, srf);
+	usurf->prime.base.refcount_release = NULL;
 err:
 	if (res)
 		vmw_resource_unreference(&res);
-	if (ret)
-		ttm_ref_object_base_unref(tfile, arg.rep.handle);
+
+	ttm_ref_object_base_unref(tfile, arg.rep.handle);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_freq.c b/drivers/gpu/drm/xe/xe_gt_freq.c
index ab76973f3e1e..a05fde2c7b12 100644
--- a/drivers/gpu/drm/xe/xe_gt_freq.c
+++ b/drivers/gpu/drm/xe/xe_gt_freq.c
@@ -32,6 +32,7 @@
  * Xe's Freq provides a sysfs API for frequency management:
  *
  * device/tile#/gt#/freq0/<item>_freq *read-only* files:
+ *
  * - act_freq: The actual resolved frequency decided by PCODE.
  * - cur_freq: The current one requested by GuC PC to the PCODE.
  * - rpn_freq: The Render Performance (RP) N level, which is the minimal one.
@@ -39,6 +40,7 @@
  * - rp0_freq: The Render Performance (RP) 0 level, which is the maximum one.
  *
  * device/tile#/gt#/freq0/<item>_freq *read-write* files:
+ *
  * - min_freq: Min frequency request.
  * - max_freq: Max frequency request.
  *             If max <= min, then freq_min becomes a fixed frequency request.
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 025d64943467..23028afbbe1d 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -910,6 +910,7 @@ static int xe_pci_suspend(struct device *dev)
 
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3cold);
 
 	return 0;
 }
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 0fb210e40a41..9eafff0b6ea4 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -192,7 +192,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		goto cleanup;
 
 	input_device->report_desc_size = le16_to_cpu(
-					desc->desc[0].wDescriptorLength);
+					desc->rpt_desc.wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -210,7 +210,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       le16_to_cpu(desc->desc[0].wDescriptorLength));
+	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index bf0f51ef0149..01625dbb28e8 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -984,12 +984,11 @@ static int usbhid_parse(struct hid_device *hid)
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	struct usb_device *dev = interface_to_usbdev (intf);
 	struct hid_descriptor *hdesc;
+	struct hid_class_descriptor *hcdesc;
 	u32 quirks = 0;
 	unsigned int rsize = 0;
 	char *rdesc;
-	int ret, n;
-	int num_descriptors;
-	size_t offset = offsetof(struct hid_descriptor, desc);
+	int ret;
 
 	quirks = hid_lookup_quirk(hid);
 
@@ -1011,20 +1010,19 @@ static int usbhid_parse(struct hid_device *hid)
 		return -ENODEV;
 	}
 
-	if (hdesc->bLength < sizeof(struct hid_descriptor)) {
-		dbg_hid("hid descriptor is too short\n");
+	if (!hdesc->bNumDescriptors ||
+	    hdesc->bLength != sizeof(*hdesc) +
+			      (hdesc->bNumDescriptors - 1) * sizeof(*hcdesc)) {
+		dbg_hid("hid descriptor invalid, bLen=%hhu bNum=%hhu\n",
+			hdesc->bLength, hdesc->bNumDescriptors);
 		return -EINVAL;
 	}
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);
 	hid->country = hdesc->bCountryCode;
 
-	num_descriptors = min_t(int, hdesc->bNumDescriptors,
-	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
-
-	for (n = 0; n < num_descriptors; n++)
-		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
-			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
+	if (hdesc->rpt_desc.bDescriptorType == HID_DT_REPORT)
+		rsize = le16_to_cpu(hdesc->rpt_desc.wDescriptorLength);
 
 	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
 		dbg_hid("weird size of report descriptor (%u)\n", rsize);
@@ -1052,6 +1050,11 @@ static int usbhid_parse(struct hid_device *hid)
 		goto err;
 	}
 
+	if (hdesc->bNumDescriptors > 1)
+		hid_warn(intf,
+			"%u unsupported optional hid class descriptors\n",
+			(int)(hdesc->bNumDescriptors - 1));
+
 	hid->quirks |= quirks;
 
 	return 0;
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 9555366aeaf0..fdc157c7394d 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -910,6 +910,10 @@ static int asus_ec_hwmon_read_string(struct device *dev,
 {
 	struct ec_sensors_data *state = dev_get_drvdata(dev);
 	int sensor_index = find_ec_sensor_index(state, type, channel);
+
+	if (sensor_index < 0)
+		return sensor_index;
+
 	*str = get_sensor_info(state, sensor_index)->label;
 
 	return 0;
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index d8ad64ea81f1..25fd02955c38 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -458,12 +458,17 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
 		       void *data)
 {
-	int rc;
+	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
 
-	CS_UNLOCK(catu_drvdata->base);
-	rc = catu_enable_hw(catu_drvdata, mode, data);
-	CS_LOCK(catu_drvdata->base);
+	guard(raw_spinlock_irqsave)(&catu_drvdata->spinlock);
+	if (csdev->refcnt == 0) {
+		CS_UNLOCK(catu_drvdata->base);
+		rc = catu_enable_hw(catu_drvdata, mode, data);
+		CS_LOCK(catu_drvdata->base);
+	}
+	if (!rc)
+		csdev->refcnt++;
 	return rc;
 }
 
@@ -486,12 +491,15 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 
 static int catu_disable(struct coresight_device *csdev, void *__unused)
 {
-	int rc;
+	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
 
-	CS_UNLOCK(catu_drvdata->base);
-	rc = catu_disable_hw(catu_drvdata);
-	CS_LOCK(catu_drvdata->base);
+	guard(raw_spinlock_irqsave)(&catu_drvdata->spinlock);
+	if (--csdev->refcnt == 0) {
+		CS_UNLOCK(catu_drvdata->base);
+		rc = catu_disable_hw(catu_drvdata);
+		CS_LOCK(catu_drvdata->base);
+	}
 	return rc;
 }
 
@@ -550,6 +558,7 @@ static int __catu_probe(struct device *dev, struct resource *res)
 	dev->platform_data = pdata;
 
 	drvdata->base = base;
+	raw_spin_lock_init(&drvdata->spinlock);
 	catu_desc.access = CSDEV_ACCESS_IOMEM(base);
 	catu_desc.pdata = pdata;
 	catu_desc.dev = dev;
@@ -702,7 +711,7 @@ static int __init catu_init(void)
 {
 	int ret;
 
-	ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver);
+	ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver, THIS_MODULE);
 	tmc_etr_set_catu_ops(&etr_catu_buf_ops);
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 141feac1c14b..755776cd19c5 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -65,6 +65,7 @@ struct catu_drvdata {
 	void __iomem *base;
 	struct coresight_device *csdev;
 	int irq;
+	raw_spinlock_t spinlock;
 };
 
 #define CATU_REG32(name, offset)					\
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 6ba013975741..84cdde6f0e4d 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -228,7 +228,7 @@ struct cscfg_feature_csdev {
  * @feats_csdev:references to the device features to enable.
  */
 struct cscfg_config_csdev {
-	const struct cscfg_config_desc *config_desc;
+	struct cscfg_config_desc *config_desc;
 	struct coresight_device *csdev;
 	bool enabled;
 	struct list_head node;
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c42aa9fddab9..c7e35a431ab0 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1422,17 +1422,17 @@ module_init(coresight_init);
 module_exit(coresight_exit);
 
 int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
-			  struct platform_driver *pdev_drv)
+			  struct platform_driver *pdev_drv, struct module *owner)
 {
 	int ret;
 
-	ret = amba_driver_register(amba_drv);
+	ret = __amba_driver_register(amba_drv, owner);
 	if (ret) {
 		pr_err("%s: error registering AMBA driver\n", drv);
 		return ret;
 	}
 
-	ret = platform_driver_register(pdev_drv);
+	ret = __platform_driver_register(pdev_drv, owner);
 	if (!ret)
 		return 0;
 
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 75962dae9aa1..cc599c5ef4b2 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -774,7 +774,8 @@ static struct platform_driver debug_platform_driver = {
 
 static int __init debug_init(void)
 {
-	return coresight_init_driver("debug", &debug_driver, &debug_platform_driver);
+	return coresight_init_driver("debug", &debug_driver, &debug_platform_driver,
+				     THIS_MODULE);
 }
 
 static void __exit debug_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 5a819c8970fb..8f451b051ddc 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -433,7 +433,8 @@ static struct amba_driver dynamic_funnel_driver = {
 
 static int __init funnel_init(void)
 {
-	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver);
+	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver,
+				     THIS_MODULE);
 }
 
 static void __exit funnel_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3e55be9c8418..f7607c72857c 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -438,7 +438,8 @@ static struct amba_driver dynamic_replicator_driver = {
 
 static int __init replicator_init(void)
 {
-	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver);
+	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver,
+				     THIS_MODULE);
 }
 
 static void __exit replicator_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index cb3e04755c99..65bc50a6d3e9 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -1047,7 +1047,7 @@ static struct platform_driver stm_platform_driver = {
 
 static int __init stm_init(void)
 {
-	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver);
+	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver, THIS_MODULE);
 }
 
 static void __exit stm_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11138a9762b0..30a561d87481 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -867,6 +867,25 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
 }
 EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
 
+static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc)
+{
+	if (!atomic_fetch_inc(&config_desc->active_cnt)) {
+		/* must ensure that config cannot be unloaded in use */
+		if (unlikely(cscfg_owner_get(config_desc->load_owner))) {
+			atomic_dec(&config_desc->active_cnt);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void cscfg_config_desc_put(struct cscfg_config_desc *config_desc)
+{
+	if (!atomic_dec_return(&config_desc->active_cnt))
+		cscfg_owner_put(config_desc->load_owner);
+}
+
 /*
  * This activate configuration for either perf or sysfs. Perf can have multiple
  * active configs, selected per event, sysfs is limited to one.
@@ -890,22 +909,17 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
 			if (config_desc->available == false)
 				return -EBUSY;
 
-			/* must ensure that config cannot be unloaded in use */
-			err = cscfg_owner_get(config_desc->load_owner);
-			if (err)
+			if (!cscfg_config_desc_get(config_desc)) {
+				err = -EINVAL;
 				break;
+			}
+
 			/*
 			 * increment the global active count - control changes to
 			 * active configurations
 			 */
 			atomic_inc(&cscfg_mgr->sys_active_cnt);
 
-			/*
-			 * mark the descriptor as active so enable config on a
-			 * device instance will use it
-			 */
-			atomic_inc(&config_desc->active_cnt);
-
 			err = 0;
 			dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
 			break;
@@ -920,9 +934,8 @@ static void _cscfg_deactivate_config(unsigned long cfg_hash)
 
 	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
 		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
-			atomic_dec(&config_desc->active_cnt);
 			atomic_dec(&cscfg_mgr->sys_active_cnt);
-			cscfg_owner_put(config_desc->load_owner);
+			cscfg_config_desc_put(config_desc);
 			dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
 			break;
 		}
@@ -1047,7 +1060,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 				     unsigned long cfg_hash, int preset)
 {
 	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
-	const struct cscfg_config_desc *config_desc;
+	struct cscfg_config_desc *config_desc;
 	unsigned long flags;
 	int err = 0;
 
@@ -1062,8 +1075,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
 		config_desc = config_csdev_item->config_desc;
-		if ((atomic_read(&config_desc->active_cnt)) &&
-		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
+		if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
+				cscfg_config_desc_get(config_desc)) {
 			config_csdev_active = config_csdev_item;
 			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
 			break;
@@ -1097,7 +1110,11 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 				err = -EBUSY;
 			spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 		}
+
+		if (err)
+			cscfg_config_desc_put(config_desc);
 	}
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
@@ -1136,8 +1153,10 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
 	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 
 	/* true if there was an enabled active config */
-	if (config_csdev)
+	if (config_csdev) {
 		cscfg_csdev_disable_config(config_csdev);
+		cscfg_config_desc_put(config_csdev->config_desc);
+	}
 }
 EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 3a482fd2cb22..475fa4bb6813 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -741,7 +741,7 @@ static struct platform_driver tmc_platform_driver = {
 
 static int __init tmc_init(void)
 {
-	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver);
+	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver, THIS_MODULE);
 }
 
 static void __exit tmc_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b048e146fbb1..f9ecd05cbe5c 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -318,7 +318,7 @@ static struct platform_driver tpiu_platform_driver = {
 
 static int __init tpiu_init(void)
 {
-	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver);
+	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver, THIS_MODULE);
 }
 
 static void __exit tpiu_exit(void)
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 30a7392c4f8b..9c9e0c950b42 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -300,9 +300,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 
 	switch (st->channels[channel].cfg.filter_type) {
 	case AD7124_SINC3_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
 	case AD7124_SINC4_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index b097f04172c8..4bd6b5aac4fe 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
  */
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -79,6 +79,8 @@
 #define MCP3910_CONFIG1_CLKEXT		BIT(6)
 #define MCP3910_CONFIG1_VREFEXT		BIT(7)
 
+#define MCP3910_CHANNEL(ch)		(MCP3911_REG_CHANNEL0 + (ch))
+
 #define MCP3910_REG_OFFCAL_CH0		0x0f
 #define MCP3910_OFFCAL(ch)		(MCP3910_REG_OFFCAL_CH0 + (ch) * 6)
 
@@ -110,6 +112,7 @@ struct mcp3911_chip_info {
 	int (*get_offset)(struct mcp3911 *adc, int channel, int *val);
 	int (*set_offset)(struct mcp3911 *adc, int channel, int val);
 	int (*set_scale)(struct mcp3911 *adc, int channel, u32 val);
+	int (*get_raw)(struct mcp3911 *adc, int channel, int *val);
 };
 
 struct mcp3911 {
@@ -170,6 +173,18 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask, u32 val, u8 len
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_read_s24(struct mcp3911 *const adc, u8 const reg, s32 *const val)
+{
+	u32 uval;
+	int const ret = mcp3911_read(adc, reg, &uval, 3);
+
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(uval, 23);
+	return ret;
+}
+
 static int mcp3910_enable_offset(struct mcp3911 *adc, bool enable)
 {
 	unsigned int mask = MCP3910_CONFIG0_EN_OFFCAL;
@@ -194,6 +209,11 @@ static int mcp3910_set_offset(struct mcp3911 *adc, int channel, int val)
 	return adc->chip->enable_offset(adc, 1);
 }
 
+static int mcp3910_get_raw(struct mcp3911 *adc, int channel, s32 *val)
+{
+	return mcp3911_read_s24(adc, MCP3910_CHANNEL(channel), val);
+}
+
 static int mcp3911_enable_offset(struct mcp3911 *adc, bool enable)
 {
 	unsigned int mask = MCP3911_STATUSCOM_EN_OFFCAL;
@@ -218,6 +238,11 @@ static int mcp3911_set_offset(struct mcp3911 *adc, int channel, int val)
 	return adc->chip->enable_offset(adc, 1);
 }
 
+static int mcp3911_get_raw(struct mcp3911 *adc, int channel, s32 *val)
+{
+	return mcp3911_read_s24(adc, MCP3911_CHANNEL(channel), val);
+}
+
 static int mcp3910_get_osr(struct mcp3911 *adc, u32 *val)
 {
 	int ret;
@@ -321,12 +346,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&adc->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = mcp3911_read(adc,
-				   MCP3911_CHANNEL(channel->channel), val, 3);
+		ret = adc->chip->get_raw(adc, channel->channel, val);
 		if (ret)
 			return ret;
-
-		*val = sign_extend32(*val, 23);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		ret = adc->chip->get_offset(adc, channel->channel, val);
@@ -799,6 +821,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3911] = {
 		.channels = mcp3911_channels,
@@ -810,6 +833,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3911_get_offset,
 		.set_offset = mcp3911_set_offset,
 		.set_scale = mcp3911_set_scale,
+		.get_raw = mcp3911_get_raw,
 	},
 	[MCP3912] = {
 		.channels = mcp3912_channels,
@@ -821,6 +845,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3913] = {
 		.channels = mcp3913_channels,
@@ -832,6 +857,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3914] = {
 		.channels = mcp3914_channels,
@@ -843,6 +869,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3918] = {
 		.channels = mcp3918_channels,
@@ -854,6 +881,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 	[MCP3919] = {
 		.channels = mcp3919_channels,
@@ -865,6 +893,7 @@ static const struct mcp3911_chip_info mcp3911_chip_info[] = {
 		.get_offset = mcp3910_get_offset,
 		.set_offset = mcp3910_set_offset,
 		.set_scale = mcp3910_set_scale,
+		.get_raw = mcp3910_get_raw,
 	},
 };
 static const struct of_device_id mcp3911_dt_ids[] = {
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 7ef249d83286..c3f9fa307b84 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1081,7 +1081,7 @@ static int pac1934_chip_identify(struct pac1934_chip_info *info)
 
 /*
  * documentation related to the ACPI device definition
- * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
  */
 static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 					     struct pac1934_chip_info *info)
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index d85b7d3de866..cc8ce0fe74e7 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -14,6 +14,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
@@ -70,6 +71,16 @@
 #define ADMV8818_HPF_WR0_MSK			GENMASK(7, 4)
 #define ADMV8818_LPF_WR0_MSK			GENMASK(3, 0)
 
+#define ADMV8818_BAND_BYPASS       0
+#define ADMV8818_BAND_MIN          1
+#define ADMV8818_BAND_MAX          4
+#define ADMV8818_BAND_CORNER_LOW   0
+#define ADMV8818_BAND_CORNER_HIGH  1
+
+#define ADMV8818_STATE_MIN   0
+#define ADMV8818_STATE_MAX   15
+#define ADMV8818_NUM_STATES  16
+
 enum {
 	ADMV8818_BW_FREQ,
 	ADMV8818_CENTER_FREQ
@@ -90,20 +101,24 @@ struct admv8818_state {
 	struct mutex		lock;
 	unsigned int		filter_mode;
 	u64			cf_hz;
+	u64			lpf_margin_hz;
+	u64			hpf_margin_hz;
 };
 
-static const unsigned long long freq_range_hpf[4][2] = {
+static const unsigned long long freq_range_hpf[5][2] = {
+	{0ULL, 0ULL}, /* bypass */
 	{1750000000ULL, 3550000000ULL},
 	{3400000000ULL, 7250000000ULL},
 	{6600000000, 12000000000},
 	{12500000000, 19900000000}
 };
 
-static const unsigned long long freq_range_lpf[4][2] = {
+static const unsigned long long freq_range_lpf[5][2] = {
+	{U64_MAX, U64_MAX}, /* bypass */
 	{2050000000ULL, 3850000000ULL},
 	{3350000000ULL, 7250000000ULL},
 	{7000000000, 13000000000},
-	{12550000000, 18500000000}
+	{12550000000, 18850000000}
 };
 
 static const struct regmap_config admv8818_regmap_config = {
@@ -121,44 +136,59 @@ static const char * const admv8818_modes[] = {
 
 static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 {
-	unsigned int hpf_step = 0, hpf_band = 0, i, j;
-	u64 freq_step;
-	int ret;
+	int band, state, ret;
+	unsigned int hpf_state = ADMV8818_STATE_MIN, hpf_band = ADMV8818_BAND_BYPASS;
+	u64 freq_error, min_freq_error, freq_corner, freq_step;
 
-	if (freq < freq_range_hpf[0][0])
+	if (freq < freq_range_hpf[ADMV8818_BAND_MIN][ADMV8818_BAND_CORNER_LOW])
 		goto hpf_write;
 
-	if (freq > freq_range_hpf[3][1]) {
-		hpf_step = 15;
-		hpf_band = 4;
-
+	if (freq >= freq_range_hpf[ADMV8818_BAND_MAX][ADMV8818_BAND_CORNER_HIGH]) {
+		hpf_state = ADMV8818_STATE_MAX;
+		hpf_band = ADMV8818_BAND_MAX;
 		goto hpf_write;
 	}
 
-	for (i = 0; i < 4; i++) {
-		freq_step = div_u64((freq_range_hpf[i][1] -
-			freq_range_hpf[i][0]), 15);
+	/* Close HPF frequency gap between 12 and 12.5 GHz */
+	if (freq >= 12000ULL * HZ_PER_MHZ && freq < 12500ULL * HZ_PER_MHZ) {
+		hpf_state = ADMV8818_STATE_MAX;
+		hpf_band = 3;
+		goto hpf_write;
+	}
 
-		if (freq > freq_range_hpf[i][0] &&
-		    (freq < freq_range_hpf[i][1] + freq_step)) {
-			hpf_band = i + 1;
+	min_freq_error = U64_MAX;
+	for (band = ADMV8818_BAND_MIN; band <= ADMV8818_BAND_MAX; band++) {
+		/*
+		 * This (and therefore all other ranges) have a corner
+		 * frequency higher than the target frequency.
+		 */
+		if (freq_range_hpf[band][ADMV8818_BAND_CORNER_LOW] > freq)
+			break;
 
-			for (j = 1; j <= 16; j++) {
-				if (freq < (freq_range_hpf[i][0] + (freq_step * j))) {
-					hpf_step = j - 1;
-					break;
-				}
+		freq_step = freq_range_hpf[band][ADMV8818_BAND_CORNER_HIGH] -
+			    freq_range_hpf[band][ADMV8818_BAND_CORNER_LOW];
+		freq_step = div_u64(freq_step, ADMV8818_NUM_STATES - 1);
+
+		for (state = ADMV8818_STATE_MIN; state <= ADMV8818_STATE_MAX; state++) {
+			freq_corner = freq_range_hpf[band][ADMV8818_BAND_CORNER_LOW] +
+				      freq_step * state;
+
+			/*
+			 * This (and therefore all other states) have a corner
+			 * frequency higher than the target frequency.
+			 */
+			if (freq_corner > freq)
+				break;
+
+			freq_error = freq - freq_corner;
+			if (freq_error < min_freq_error) {
+				min_freq_error = freq_error;
+				hpf_state = state;
+				hpf_band = band;
 			}
-			break;
 		}
 	}
 
-	/* Close HPF frequency gap between 12 and 12.5 GHz */
-	if (freq >= 12000 * HZ_PER_MHZ && freq <= 12500 * HZ_PER_MHZ) {
-		hpf_band = 3;
-		hpf_step = 15;
-	}
-
 hpf_write:
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
 				 ADMV8818_SW_IN_SET_WR0_MSK |
@@ -170,7 +200,7 @@ static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 
 	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
 				  ADMV8818_HPF_WR0_MSK,
-				  FIELD_PREP(ADMV8818_HPF_WR0_MSK, hpf_step));
+				  FIELD_PREP(ADMV8818_HPF_WR0_MSK, hpf_state));
 }
 
 static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
@@ -186,31 +216,52 @@ static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 
 static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 {
-	unsigned int lpf_step = 0, lpf_band = 0, i, j;
-	u64 freq_step;
-	int ret;
+	int band, state, ret;
+	unsigned int lpf_state = ADMV8818_STATE_MIN, lpf_band = ADMV8818_BAND_BYPASS;
+	u64 freq_error, min_freq_error, freq_corner, freq_step;
 
-	if (freq > freq_range_lpf[3][1])
+	if (freq > freq_range_lpf[ADMV8818_BAND_MAX][ADMV8818_BAND_CORNER_HIGH])
 		goto lpf_write;
 
-	if (freq < freq_range_lpf[0][0]) {
-		lpf_band = 1;
-
+	if (freq < freq_range_lpf[ADMV8818_BAND_MIN][ADMV8818_BAND_CORNER_LOW]) {
+		lpf_state = ADMV8818_STATE_MIN;
+		lpf_band = ADMV8818_BAND_MIN;
 		goto lpf_write;
 	}
 
-	for (i = 0; i < 4; i++) {
-		if (freq > freq_range_lpf[i][0] && freq < freq_range_lpf[i][1]) {
-			lpf_band = i + 1;
-			freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
+	min_freq_error = U64_MAX;
+	for (band = ADMV8818_BAND_MAX; band >= ADMV8818_BAND_MIN; --band) {
+		/*
+		 * At this point the highest corner frequency of
+		 * all remaining ranges is below the target.
+		 * LPF corner should be >= the target.
+		 */
+		if (freq > freq_range_lpf[band][ADMV8818_BAND_CORNER_HIGH])
+			break;
+
+		freq_step = freq_range_lpf[band][ADMV8818_BAND_CORNER_HIGH] -
+			    freq_range_lpf[band][ADMV8818_BAND_CORNER_LOW];
+		freq_step = div_u64(freq_step, ADMV8818_NUM_STATES - 1);
+
+		for (state = ADMV8818_STATE_MAX; state >= ADMV8818_STATE_MIN; --state) {
+
+			freq_corner = freq_range_lpf[band][ADMV8818_BAND_CORNER_LOW] +
+				      state * freq_step;
 
-			for (j = 0; j <= 15; j++) {
-				if (freq < (freq_range_lpf[i][0] + (freq_step * j))) {
-					lpf_step = j;
-					break;
-				}
+			/*
+			 * At this point all other states in range will
+			 * place the corner frequency below the target
+			 * LPF corner should >= the target.
+			 */
+			if (freq > freq_corner)
+				break;
+
+			freq_error = freq_corner - freq;
+			if (freq_error < min_freq_error) {
+				min_freq_error = freq_error;
+				lpf_state = state;
+				lpf_band = band;
 			}
-			break;
 		}
 	}
 
@@ -225,7 +276,7 @@ static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 
 	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
 				  ADMV8818_LPF_WR0_MSK,
-				  FIELD_PREP(ADMV8818_LPF_WR0_MSK, lpf_step));
+				  FIELD_PREP(ADMV8818_LPF_WR0_MSK, lpf_state));
 }
 
 static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
@@ -242,16 +293,28 @@ static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 static int admv8818_rfin_band_select(struct admv8818_state *st)
 {
 	int ret;
+	u64 hpf_corner_target, lpf_corner_target;
 
 	st->cf_hz = clk_get_rate(st->clkin);
 
+	/* Check for underflow */
+	if (st->cf_hz > st->hpf_margin_hz)
+		hpf_corner_target = st->cf_hz - st->hpf_margin_hz;
+	else
+		hpf_corner_target = 0;
+
+	/* Check for overflow */
+	lpf_corner_target = st->cf_hz + st->lpf_margin_hz;
+	if (lpf_corner_target < st->cf_hz)
+		lpf_corner_target = U64_MAX;
+
 	mutex_lock(&st->lock);
 
-	ret = __admv8818_hpf_select(st, st->cf_hz);
+	ret = __admv8818_hpf_select(st, hpf_corner_target);
 	if (ret)
 		goto exit;
 
-	ret = __admv8818_lpf_select(st, st->cf_hz);
+	ret = __admv8818_lpf_select(st, lpf_corner_target);
 exit:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -278,8 +341,11 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
 
 	hpf_state = FIELD_GET(ADMV8818_HPF_WR0_MSK, data);
 
-	*hpf_freq = div_u64(freq_range_hpf[hpf_band - 1][1] - freq_range_hpf[hpf_band - 1][0], 15);
-	*hpf_freq = freq_range_hpf[hpf_band - 1][0] + (*hpf_freq * hpf_state);
+	*hpf_freq = freq_range_hpf[hpf_band][ADMV8818_BAND_CORNER_HIGH] -
+		    freq_range_hpf[hpf_band][ADMV8818_BAND_CORNER_LOW];
+	*hpf_freq = div_u64(*hpf_freq, ADMV8818_NUM_STATES - 1);
+	*hpf_freq = freq_range_hpf[hpf_band][ADMV8818_BAND_CORNER_LOW] +
+		    (*hpf_freq * hpf_state);
 
 	return ret;
 }
@@ -316,8 +382,11 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 
 	lpf_state = FIELD_GET(ADMV8818_LPF_WR0_MSK, data);
 
-	*lpf_freq = div_u64(freq_range_lpf[lpf_band - 1][1] - freq_range_lpf[lpf_band - 1][0], 15);
-	*lpf_freq = freq_range_lpf[lpf_band - 1][0] + (*lpf_freq * lpf_state);
+	*lpf_freq = freq_range_lpf[lpf_band][ADMV8818_BAND_CORNER_HIGH] -
+		    freq_range_lpf[lpf_band][ADMV8818_BAND_CORNER_LOW];
+	*lpf_freq = div_u64(*lpf_freq, ADMV8818_NUM_STATES - 1);
+	*lpf_freq = freq_range_lpf[lpf_band][ADMV8818_BAND_CORNER_LOW] +
+		    (*lpf_freq * lpf_state);
 
 	return ret;
 }
@@ -333,6 +402,19 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 	return ret;
 }
 
+static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
+								struct iio_chan_spec const *chan,
+								long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_64;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int admv8818_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long info)
@@ -341,6 +423,9 @@ static int admv8818_write_raw(struct iio_dev *indio_dev,
 
 	u64 freq = ((u64)val2 << 32 | (u32)val);
 
+	if ((s64)freq < 0)
+		return -EINVAL;
+
 	switch (info) {
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return admv8818_lpf_select(st, freq);
@@ -502,6 +587,7 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 
 static const struct iio_info admv8818_info = {
 	.write_raw = admv8818_write_raw,
+	.write_raw_get_fmt = admv8818_write_raw_get_fmt,
 	.read_raw = admv8818_read_raw,
 	.debugfs_reg_access = &admv8818_reg_access,
 };
@@ -641,6 +727,32 @@ static int admv8818_clk_setup(struct admv8818_state *st)
 	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
 }
 
+static int admv8818_read_properties(struct admv8818_state *st)
+{
+	struct spi_device *spi = st->spi;
+	u32 mhz;
+	int ret;
+
+	ret = device_property_read_u32(&spi->dev, "adi,lpf-margin-mhz", &mhz);
+	if (ret == 0)
+		st->lpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
+	else if (ret == -EINVAL)
+		st->lpf_margin_hz = 0;
+	else
+		return ret;
+
+
+	ret = device_property_read_u32(&spi->dev, "adi,hpf-margin-mhz", &mhz);
+	if (ret == 0)
+		st->hpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
+	else if (ret == -EINVAL)
+		st->hpf_margin_hz = 0;
+	else if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int admv8818_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -672,6 +784,10 @@ static int admv8818_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	ret = admv8818_read_properties(st);
+	if (ret)
+		return ret;
+
 	ret = admv8818_init(st);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 07fb8d3c037f..d45e3909dafe 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -166,7 +166,7 @@ struct cm_port {
 struct cm_device {
 	struct kref kref;
 	struct list_head list;
-	spinlock_t mad_agent_lock;
+	rwlock_t mad_agent_lock;
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
@@ -284,7 +284,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return ERR_PTR(-EINVAL);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	mad_agent = cm_id_priv->av.port->mad_agent;
 	if (!mad_agent) {
 		m = ERR_PTR(-EINVAL);
@@ -315,7 +315,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	m->context[0] = cm_id_priv;
 
 out:
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return m;
 }
 
@@ -1294,10 +1294,10 @@ static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return cpu_to_be64(low_tid);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	if (cm_id_priv->av.port->mad_agent)
 		hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return cpu_to_be64(hi_tid | low_tid);
 }
 
@@ -4374,7 +4374,7 @@ static int cm_add_one(struct ib_device *ib_device)
 		return -ENOMEM;
 
 	kref_init(&cm_dev->kref);
-	spin_lock_init(&cm_dev->mad_agent_lock);
+	rwlock_init(&cm_dev->mad_agent_lock);
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
@@ -4490,9 +4490,9 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		 * The above ensures no call paths from the work are running,
 		 * the remaining paths all take the mad_agent_lock.
 		 */
-		spin_lock(&cm_dev->mad_agent_lock);
+		write_lock(&cm_dev->mad_agent_lock);
 		port->mad_agent = NULL;
-		spin_unlock(&cm_dev->mad_agent_lock);
+		write_unlock(&cm_dev->mad_agent_lock);
 		ib_unregister_mad_agent(mad_agent);
 		ib_port_unregister_client_groups(ib_device, i,
 						 cm_counter_groups);
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 176d0b3e4488..81bc24a346d3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -5231,7 +5231,8 @@ static int cma_netevent_callback(struct notifier_block *self,
 			   neigh->ha, ETH_ALEN))
 			continue;
 		cma_id_get(current_id);
-		queue_work(cma_wq, &current_id->id.net_work);
+		if (!queue_work(cma_wq, &current_id->id.net_work))
+			cma_id_put(current_id);
 	}
 out:
 	spin_unlock_irqrestore(&id_table_lock, flags);
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 4fc5b9d5fea8..307c35888b30 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -33,7 +33,6 @@
 #include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
-#include "hnae3.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f5c3e560df58..985b9d7d69f2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -43,7 +43,6 @@
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 91a5665465ff..bc7466830eaf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -34,6 +34,7 @@
 #define _HNS_ROCE_HW_V2_H
 
 #include <linux/bitops.h>
+#include "hnae3.h"
 
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8d0b63d4b50a..e7a497cc125c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,7 +37,6 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 356d98816949..f637b73b946e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -4,7 +4,6 @@
 #include <rdma/rdma_cm.h>
 #include <rdma/restrack.h>
 #include <uapi/rdma/rdma_netlink.h>
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index d3dcc272200a..146d03ae40bd 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -21,8 +21,10 @@ mlx5_get_rsc(struct mlx5_qp_table *table, u32 rsn)
 	spin_lock_irqsave(&table->lock, flags);
 
 	common = radix_tree_lookup(&table->tree, rsn);
-	if (common)
+	if (common && !common->invalid)
 		refcount_inc(&common->refcount);
+	else
+		common = NULL;
 
 	spin_unlock_irqrestore(&table->lock, flags);
 
@@ -178,6 +180,18 @@ static int create_resource_common(struct mlx5_ib_dev *dev,
 	return 0;
 }
 
+static void modify_resource_common_state(struct mlx5_ib_dev *dev,
+					 struct mlx5_core_qp *qp,
+					 bool invalid)
+{
+	struct mlx5_qp_table *table = &dev->qp_table;
+	unsigned long flags;
+
+	spin_lock_irqsave(&table->lock, flags);
+	qp->common.invalid = invalid;
+	spin_unlock_irqrestore(&table->lock, flags);
+}
+
 static void destroy_resource_common(struct mlx5_ib_dev *dev,
 				    struct mlx5_core_qp *qp)
 {
@@ -609,8 +623,20 @@ int mlx5_core_create_rq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
 int mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
 				 struct mlx5_core_qp *rq)
 {
+	int ret;
+
+	/* The rq destruction can be called again in case it fails, hence we
+	 * mark the common resource as invalid and only once FW destruction
+	 * is completed successfully we actually destroy the resources.
+	 */
+	modify_resource_common_state(dev, rq, true);
+	ret = destroy_rq_tracked(dev, rq->qpn, rq->uid);
+	if (ret) {
+		modify_resource_common_state(dev, rq, false);
+		return ret;
+	}
 	destroy_resource_common(dev, rq);
-	return destroy_rq_tracked(dev, rq->qpn, rq->uid);
+	return 0;
 }
 
 static void destroy_sq_tracked(struct mlx5_ib_dev *dev, u32 sqn, u16 uid)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index e2468bc04a5c..c2516c754958 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2016 Zodiac Inflight Innovations
  */
 
+#include "linux/device.h"
 #include <linux/kernel.h>
 #include <linux/rmi.h>
 #include <linux/firmware.h>
@@ -298,39 +299,30 @@ static int rmi_f34_update_firmware(struct f34_data *f34,
 	return ret;
 }
 
-static int rmi_f34_status(struct rmi_function *fn)
-{
-	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
-
-	/*
-	 * The status is the percentage complete, or once complete,
-	 * zero for success or a negative return code.
-	 */
-	return f34->update_status;
-}
-
 static ssize_t rmi_driver_bootloader_id_show(struct device *dev,
 					     struct device_attribute *dattr,
 					     char *buf)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
-	struct rmi_function *fn = data->f34_container;
+	struct rmi_function *fn;
 	struct f34_data *f34;
 
-	if (fn) {
-		f34 = dev_get_drvdata(&fn->dev);
-
-		if (f34->bl_version == 5)
-			return sysfs_emit(buf, "%c%c\n",
-					  f34->bootloader_id[0],
-					  f34->bootloader_id[1]);
-		else
-			return sysfs_emit(buf, "V%d.%d\n",
-					  f34->bootloader_id[1],
-					  f34->bootloader_id[0]);
-	}
+	fn = data->f34_container;
+	if (!fn)
+		return -ENODEV;
 
-	return 0;
+	f34 = dev_get_drvdata(&fn->dev);
+	if (!f34)
+		return -ENODEV;
+
+	if (f34->bl_version == 5)
+		return sysfs_emit(buf, "%c%c\n",
+				  f34->bootloader_id[0],
+				  f34->bootloader_id[1]);
+	else
+		return sysfs_emit(buf, "V%d.%d\n",
+				  f34->bootloader_id[1],
+				  f34->bootloader_id[0]);
 }
 
 static DEVICE_ATTR(bootloader_id, 0444, rmi_driver_bootloader_id_show, NULL);
@@ -343,13 +335,16 @@ static ssize_t rmi_driver_configuration_id_show(struct device *dev,
 	struct rmi_function *fn = data->f34_container;
 	struct f34_data *f34;
 
-	if (fn) {
-		f34 = dev_get_drvdata(&fn->dev);
+	fn = data->f34_container;
+	if (!fn)
+		return -ENODEV;
 
-		return sysfs_emit(buf, "%s\n", f34->configuration_id);
-	}
+	f34 = dev_get_drvdata(&fn->dev);
+	if (!f34)
+		return -ENODEV;
 
-	return 0;
+
+	return sysfs_emit(buf, "%s\n", f34->configuration_id);
 }
 
 static DEVICE_ATTR(configuration_id, 0444,
@@ -365,10 +360,14 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 
 	if (!data->f34_container) {
 		dev_warn(dev, "%s: No F34 present!\n", __func__);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	f34 = dev_get_drvdata(&data->f34_container->dev);
+	if (!f34) {
+		dev_warn(dev, "%s: No valid F34 present!\n", __func__);
+		return -ENODEV;
+	}
 
 	if (f34->bl_version >= 7) {
 		if (data->pdt_props & HAS_BSR) {
@@ -494,10 +493,18 @@ static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
 						char *buf)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
-	int update_status = 0;
+	struct f34_data *f34;
+	int update_status = -ENODEV;
 
-	if (data->f34_container)
-		update_status = rmi_f34_status(data->f34_container);
+	/*
+	 * The status is the percentage complete, or once complete,
+	 * zero for success or a negative return code.
+	 */
+	if (data->f34_container) {
+		f34 = dev_get_drvdata(&data->f34_container->dev);
+		if (f34)
+			update_status = f34->update_status;
+	}
 
 	return sysfs_emit(buf, "%d\n", update_status);
 }
@@ -517,33 +524,21 @@ static const struct attribute_group rmi_firmware_attr_group = {
 	.attrs = rmi_firmware_attrs,
 };
 
-static int rmi_f34_probe(struct rmi_function *fn)
+static int rmi_f34v5_probe(struct f34_data *f34)
 {
-	struct f34_data *f34;
-	unsigned char f34_queries[9];
+	struct rmi_function *fn = f34->fn;
+	u8 f34_queries[9];
 	bool has_config_id;
-	u8 version = fn->fd.function_version;
-	int ret;
-
-	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
-	if (!f34)
-		return -ENOMEM;
-
-	f34->fn = fn;
-	dev_set_drvdata(&fn->dev, f34);
-
-	/* v5 code only supported version 0, try V7 probe */
-	if (version > 0)
-		return rmi_f34v7_probe(f34);
+	int error;
 
 	f34->bl_version = 5;
 
-	ret = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
-			     f34_queries, sizeof(f34_queries));
-	if (ret) {
+	error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
+			       f34_queries, sizeof(f34_queries));
+	if (error) {
 		dev_err(&fn->dev, "%s: Failed to query properties\n",
 			__func__);
-		return ret;
+		return error;
 	}
 
 	snprintf(f34->bootloader_id, sizeof(f34->bootloader_id),
@@ -569,11 +564,11 @@ static int rmi_f34_probe(struct rmi_function *fn)
 		f34->v5.config_blocks);
 
 	if (has_config_id) {
-		ret = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
-				     f34_queries, sizeof(f34_queries));
-		if (ret) {
+		error = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
+				       f34_queries, sizeof(f34_queries));
+		if (error) {
 			dev_err(&fn->dev, "Failed to read F34 config ID\n");
-			return ret;
+			return error;
 		}
 
 		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
@@ -582,12 +577,34 @@ static int rmi_f34_probe(struct rmi_function *fn)
 			 f34_queries[2], f34_queries[3]);
 
 		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Configuration ID: %s\n",
-			 f34->configuration_id);
+			f34->configuration_id);
 	}
 
 	return 0;
 }
 
+static int rmi_f34_probe(struct rmi_function *fn)
+{
+	struct f34_data *f34;
+	u8 version = fn->fd.function_version;
+	int error;
+
+	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
+	if (!f34)
+		return -ENOMEM;
+
+	f34->fn = fn;
+
+	/* v5 code only supported version 0 */
+	error = version == 0 ? rmi_f34v5_probe(f34) : rmi_f34v7_probe(f34);
+	if (error)
+		return error;
+
+	dev_set_drvdata(&fn->dev, f34);
+
+	return 0;
+}
+
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
 {
 	return sysfs_create_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b3aa1f5d5321..1469ad0794f2 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -199,7 +199,6 @@ source "drivers/iommu/iommufd/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
-	select DMAR_TABLE if INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 879009adef40..0ad55649e2d0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2394,6 +2394,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	unsigned int pgsize_idx, pgsize_idx_next;
 	unsigned long pgsizes;
 	size_t offset, pgsize, pgsize_next;
+	size_t offset_end;
 	unsigned long addr_merge = paddr | iova;
 
 	/* Page sizes supported by the hardware and small enough for @size */
@@ -2434,7 +2435,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	 * If size is big enough to accommodate the larger page, reduce
 	 * the number of smaller pages.
 	 */
-	if (offset + pgsize_next <= size)
+	if (!check_add_overflow(offset, pgsize_next, &offset_end) &&
+	    offset_end <= size)
 		size = offset;
 
 out_set_count:
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index f815dab3be50..0657bd3d8f97 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -226,7 +226,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 {
 	u32 *arg = data;
 	u32 val;
-	int ret;
+	int ret, count;
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
@@ -240,11 +240,20 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 	case IMX_MU_TYPE_TXDB_V2:
 		imx_mu_write(priv, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx),
 			     priv->dcfg->xCR[IMX_MU_GCR]);
-		ret = readl_poll_timeout(priv->base + priv->dcfg->xCR[IMX_MU_GCR], val,
-					 !(val & IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx)),
-					 0, 1000);
-		if (ret)
-			dev_warn_ratelimited(priv->dev, "channel type: %d failure\n", cp->type);
+		ret = -ETIMEDOUT;
+		count = 0;
+		while (ret && (count < 10)) {
+			ret =
+			readl_poll_timeout(priv->base + priv->dcfg->xCR[IMX_MU_GCR], val,
+					   !(val & IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx)),
+					   0, 10000);
+
+			if (ret) {
+				dev_warn_ratelimited(priv->dev,
+						     "channel type: %d timeout, %d times, retry\n",
+						     cp->type, ++count);
+			}
+		}
 		break;
 	default:
 		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 9c43ed9bdd37..d24f71819c3d 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -92,18 +92,6 @@ struct gce_plat {
 	u32 gce_num;
 };
 
-static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
-{
-	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
-
-	if (enable)
-		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
-	else
-		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
-
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
-}
-
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 {
 	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
@@ -112,6 +100,19 @@ u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 }
 EXPORT_SYMBOL(cmdq_get_shift_pa);
 
+static void cmdq_gctl_value_toggle(struct cmdq *cmdq, bool ddr_enable)
+{
+	u32 val = cmdq->pdata->control_by_sw ? GCE_CTRL_BY_SW : 0;
+
+	if (!cmdq->pdata->control_by_sw && !cmdq->pdata->sw_ddr_en)
+		return;
+
+	if (cmdq->pdata->sw_ddr_en && ddr_enable)
+		val |= GCE_DDR_EN;
+
+	writel(val, cmdq->base + GCE_GCTL_VALUE);
+}
+
 static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
 {
 	u32 status;
@@ -140,16 +141,10 @@ static void cmdq_thread_resume(struct cmdq_thread *thread)
 static void cmdq_init(struct cmdq *cmdq)
 {
 	int i;
-	u32 gctl_regval = 0;
 
 	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
-	if (cmdq->pdata->control_by_sw)
-		gctl_regval = GCE_CTRL_BY_SW;
-	if (cmdq->pdata->sw_ddr_en)
-		gctl_regval |= GCE_DDR_EN;
 
-	if (gctl_regval)
-		writel(gctl_regval, cmdq->base + GCE_GCTL_VALUE);
+	cmdq_gctl_value_toggle(cmdq, true);
 
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
@@ -315,14 +310,21 @@ static irqreturn_t cmdq_irq_handler(int irq, void *dev)
 static int cmdq_runtime_resume(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
+	int ret;
 
-	return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+	ret = clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+	if (ret)
+		return ret;
+
+	cmdq_gctl_value_toggle(cmdq, true);
+	return 0;
 }
 
 static int cmdq_runtime_suspend(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 
+	cmdq_gctl_value_toggle(cmdq, false);
 	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
 	return 0;
 }
@@ -347,9 +349,6 @@ static int cmdq_suspend(struct device *dev)
 	if (task_running)
 		dev_warn(dev, "exist running task(s) in suspend\n");
 
-	if (cmdq->pdata->sw_ddr_en)
-		cmdq_sw_ddr_enable(cmdq, false);
-
 	return pm_runtime_force_suspend(dev);
 }
 
@@ -360,9 +359,6 @@ static int cmdq_resume(struct device *dev)
 	WARN_ON(pm_runtime_force_resume(dev));
 	cmdq->suspended = false;
 
-	if (cmdq->pdata->sw_ddr_en)
-		cmdq_sw_ddr_enable(cmdq, true);
-
 	return 0;
 }
 
@@ -370,9 +366,6 @@ static void cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
-	if (cmdq->pdata->sw_ddr_en)
-		cmdq_sw_ddr_enable(cmdq, false);
-
 	if (!IS_ENABLED(CONFIG_PM))
 		cmdq_runtime_suspend(&pdev->dev);
 
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 3637761f3585..f3a3f2ef6322 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -141,6 +141,7 @@ struct mapped_device {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_zones;
 	void *zone_revalidate_map;
+	struct task_struct *revalidate_map_task;
 #endif
 
 #ifdef CONFIG_IMA
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index b690905ab89f..347881f323d5 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -47,14 +47,15 @@ enum feature_flag_bits {
 };
 
 struct per_bio_data {
-	bool bio_submitted;
+	bool bio_can_corrupt;
+	struct bvec_iter saved_iter;
 };
 
 static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 			  struct dm_target *ti)
 {
-	int r;
-	unsigned int argc;
+	int r = 0;
+	unsigned int argc = 0;
 	const char *arg_name;
 
 	static const struct dm_arg _args[] = {
@@ -65,14 +66,13 @@ static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 		{0, PROBABILITY_BASE, "Invalid random corrupt argument"},
 	};
 
-	/* No feature arguments supplied. */
-	if (!as->argc)
-		return 0;
-
-	r = dm_read_arg_group(_args, as, &argc, &ti->error);
-	if (r)
+	if (as->argc && (r = dm_read_arg_group(_args, as, &argc, &ti->error)))
 		return r;
 
+	/* No feature arguments supplied. */
+	if (!argc)
+		goto error_all_io;
+
 	while (argc) {
 		arg_name = dm_shift_arg(as);
 		argc--;
@@ -217,6 +217,7 @@ static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 	if (!fc->corrupt_bio_byte && !test_bit(ERROR_READS, &fc->flags) &&
 	    !test_bit(DROP_WRITES, &fc->flags) && !test_bit(ERROR_WRITES, &fc->flags) &&
 	    !fc->random_read_corrupt && !fc->random_write_corrupt) {
+error_all_io:
 		set_bit(ERROR_WRITES, &fc->flags);
 		set_bit(ERROR_READS, &fc->flags);
 	}
@@ -339,7 +340,8 @@ static void flakey_map_bio(struct dm_target *ti, struct bio *bio)
 }
 
 static void corrupt_bio_common(struct bio *bio, unsigned int corrupt_bio_byte,
-			       unsigned char corrupt_bio_value)
+			       unsigned char corrupt_bio_value,
+			       struct bvec_iter start)
 {
 	struct bvec_iter iter;
 	struct bio_vec bvec;
@@ -348,7 +350,7 @@ static void corrupt_bio_common(struct bio *bio, unsigned int corrupt_bio_byte,
 	 * Overwrite the Nth byte of the bio's data, on whichever page
 	 * it falls.
 	 */
-	bio_for_each_segment(bvec, bio, iter) {
+	__bio_for_each_segment(bvec, bio, iter, start) {
 		if (bio_iter_len(bio, iter) > corrupt_bio_byte) {
 			unsigned char *segment = bvec_kmap_local(&bvec);
 			segment[corrupt_bio_byte] = corrupt_bio_value;
@@ -357,36 +359,31 @@ static void corrupt_bio_common(struct bio *bio, unsigned int corrupt_bio_byte,
 				"(rw=%c bi_opf=%u bi_sector=%llu size=%u)\n",
 				bio, corrupt_bio_value, corrupt_bio_byte,
 				(bio_data_dir(bio) == WRITE) ? 'w' : 'r', bio->bi_opf,
-				(unsigned long long)bio->bi_iter.bi_sector,
-				bio->bi_iter.bi_size);
+				(unsigned long long)start.bi_sector,
+				start.bi_size);
 			break;
 		}
 		corrupt_bio_byte -= bio_iter_len(bio, iter);
 	}
 }
 
-static void corrupt_bio_data(struct bio *bio, struct flakey_c *fc)
+static void corrupt_bio_data(struct bio *bio, struct flakey_c *fc,
+			     struct bvec_iter start)
 {
 	unsigned int corrupt_bio_byte = fc->corrupt_bio_byte - 1;
 
-	if (!bio_has_data(bio))
-		return;
-
-	corrupt_bio_common(bio, corrupt_bio_byte, fc->corrupt_bio_value);
+	corrupt_bio_common(bio, corrupt_bio_byte, fc->corrupt_bio_value, start);
 }
 
-static void corrupt_bio_random(struct bio *bio)
+static void corrupt_bio_random(struct bio *bio, struct bvec_iter start)
 {
 	unsigned int corrupt_byte;
 	unsigned char corrupt_value;
 
-	if (!bio_has_data(bio))
-		return;
-
-	corrupt_byte = get_random_u32() % bio->bi_iter.bi_size;
+	corrupt_byte = get_random_u32() % start.bi_size;
 	corrupt_value = get_random_u8();
 
-	corrupt_bio_common(bio, corrupt_byte, corrupt_value);
+	corrupt_bio_common(bio, corrupt_byte, corrupt_value, start);
 }
 
 static void clone_free(struct bio *clone)
@@ -481,7 +478,7 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 	unsigned int elapsed;
 	struct per_bio_data *pb = dm_per_bio_data(bio, sizeof(struct per_bio_data));
 
-	pb->bio_submitted = false;
+	pb->bio_can_corrupt = false;
 
 	if (op_is_zone_mgmt(bio_op(bio)))
 		goto map_bio;
@@ -490,10 +487,11 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 	elapsed = (jiffies - fc->start_time) / HZ;
 	if (elapsed % (fc->up_interval + fc->down_interval) >= fc->up_interval) {
 		bool corrupt_fixed, corrupt_random;
-		/*
-		 * Flag this bio as submitted while down.
-		 */
-		pb->bio_submitted = true;
+
+		if (bio_has_data(bio)) {
+			pb->bio_can_corrupt = true;
+			pb->saved_iter = bio->bi_iter;
+		}
 
 		/*
 		 * Error reads if neither corrupt_bio_byte or drop_writes or error_writes are set.
@@ -516,6 +514,8 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 			return DM_MAPIO_SUBMITTED;
 		}
 
+		if (!pb->bio_can_corrupt)
+			goto map_bio;
 		/*
 		 * Corrupt matching writes.
 		 */
@@ -535,9 +535,11 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 			struct bio *clone = clone_bio(ti, fc, bio);
 			if (clone) {
 				if (corrupt_fixed)
-					corrupt_bio_data(clone, fc);
+					corrupt_bio_data(clone, fc,
+							 clone->bi_iter);
 				if (corrupt_random)
-					corrupt_bio_random(clone);
+					corrupt_bio_random(clone,
+							   clone->bi_iter);
 				submit_bio(clone);
 				return DM_MAPIO_SUBMITTED;
 			}
@@ -559,21 +561,21 @@ static int flakey_end_io(struct dm_target *ti, struct bio *bio,
 	if (op_is_zone_mgmt(bio_op(bio)))
 		return DM_ENDIO_DONE;
 
-	if (!*error && pb->bio_submitted && (bio_data_dir(bio) == READ)) {
+	if (!*error && pb->bio_can_corrupt && (bio_data_dir(bio) == READ)) {
 		if (fc->corrupt_bio_byte) {
 			if ((fc->corrupt_bio_rw == READ) &&
 			    all_corrupt_bio_flags_match(bio, fc)) {
 				/*
 				 * Corrupt successful matching READs while in down state.
 				 */
-				corrupt_bio_data(bio, fc);
+				corrupt_bio_data(bio, fc, pb->saved_iter);
 			}
 		}
 		if (fc->random_read_corrupt) {
 			u64 rnd = get_random_u64();
 			u32 rem = do_div(rnd, PROBABILITY_BASE);
 			if (rem < fc->random_read_corrupt)
-				corrupt_bio_random(bio);
+				corrupt_bio_random(bio, pb->saved_iter);
 		}
 		if (test_bit(ERROR_READS, &fc->flags)) {
 			/*
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index c0d41c36e06e..04cc36a9d5ca 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -56,24 +56,31 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 {
 	struct mapped_device *md = disk->private_data;
 	struct dm_table *map;
-	int srcu_idx, ret;
+	struct dm_table *zone_revalidate_map = md->zone_revalidate_map;
+	int srcu_idx, ret = -EIO;
+	bool put_table = false;
 
-	if (!md->zone_revalidate_map) {
-		/* Regular user context */
+	if (!zone_revalidate_map || md->revalidate_map_task != current) {
+		/*
+		 * Regular user context or
+		 * Zone revalidation during __bind() is in progress, but this
+		 * call is from a different process
+		 */
 		if (dm_suspended_md(md))
 			return -EAGAIN;
 
 		map = dm_get_live_table(md, &srcu_idx);
-		if (!map)
-			return -EIO;
+		put_table = true;
 	} else {
 		/* Zone revalidation during __bind() */
-		map = md->zone_revalidate_map;
+		map = zone_revalidate_map;
 	}
 
-	ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb, data);
+	if (map)
+		ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb,
+					     data);
 
-	if (!md->zone_revalidate_map)
+	if (put_table)
 		dm_put_live_table(md, srcu_idx);
 
 	return ret;
@@ -175,7 +182,9 @@ int dm_revalidate_zones(struct dm_table *t, struct request_queue *q)
 	 * our table for dm_blk_report_zones() to use directly.
 	 */
 	md->zone_revalidate_map = t;
+	md->revalidate_map_task = current;
 	ret = blk_revalidate_disk_zones(disk);
+	md->revalidate_map_task = NULL;
 	md->zone_revalidate_map = NULL;
 
 	if (ret) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d29125ee9e72..92e5a233f516 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2410,21 +2410,29 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 			       struct queue_limits *limits)
 {
 	struct dm_table *old_map;
-	sector_t size;
+	sector_t size, old_size;
 	int ret;
 
 	lockdep_assert_held(&md->suspend_lock);
 
 	size = dm_table_get_size(t);
 
+	old_size = dm_get_size(md);
+	set_capacity(md->disk, size);
+
+	ret = dm_table_set_restrictions(t, md->queue, limits);
+	if (ret) {
+		set_capacity(md->disk, old_size);
+		old_map = ERR_PTR(ret);
+		goto out;
+	}
+
 	/*
 	 * Wipe any geometry if the size of the table changed.
 	 */
-	if (size != dm_get_size(md))
+	if (size != old_size)
 		memset(&md->geometry, 0, sizeof(md->geometry));
 
-	set_capacity(md->disk, size);
-
 	dm_table_event_callback(t, event_callback, md);
 
 	if (dm_table_request_based(t)) {
@@ -2442,10 +2450,10 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		 * requests in the queue may refer to bio from the old bioset,
 		 * so you must walk through the queue to unprep.
 		 */
-		if (!md->mempools) {
+		if (!md->mempools)
 			md->mempools = t->mempools;
-			t->mempools = NULL;
-		}
+		else
+			dm_free_md_mempools(t->mempools);
 	} else {
 		/*
 		 * The md may already have mempools that need changing.
@@ -2454,14 +2462,8 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		 */
 		dm_free_md_mempools(md->mempools);
 		md->mempools = t->mempools;
-		t->mempools = NULL;
-	}
-
-	ret = dm_table_set_restrictions(t, md->queue, limits);
-	if (ret) {
-		old_map = ERR_PTR(ret);
-		goto out;
 	}
+	t->mempools = NULL;
 
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 232c93eea7ee..18cad5ac92d8 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -260,8 +260,10 @@ int hantro_postproc_init(struct hantro_ctx *ctx)
 
 	for (i = 0; i < num_buffers; i++) {
 		ret = hantro_postproc_alloc(ctx, i);
-		if (ret)
+		if (ret) {
+			hantro_postproc_free(ctx);
 			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index e58990c85ed8..e36805f07282 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -122,8 +122,8 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	if (IS_ERR(lpass->sfr0_clk))
 		return PTR_ERR(lpass->sfr0_clk);
 
-	lpass->top = regmap_init_mmio(dev, base_top,
-					&exynos_lpass_reg_conf);
+	lpass->top = devm_regmap_init_mmio(dev, base_top,
+					   &exynos_lpass_reg_conf);
 	if (IS_ERR(lpass->top)) {
 		dev_err(dev, "LPASS top regmap initialization failed\n");
 		return PTR_ERR(lpass->top);
@@ -141,11 +141,9 @@ static void exynos_lpass_remove(struct platform_device *pdev)
 {
 	struct exynos_lpass *lpass = platform_get_drvdata(pdev);
 
-	exynos_lpass_disable(lpass);
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		exynos_lpass_disable(lpass);
-	regmap_exit(lpass->top);
 }
 
 static int __maybe_unused exynos_lpass_suspend(struct device *dev)
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 792236f56399..b9cc85ea2c40 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -129,7 +129,7 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
+MODULE_DEVICE_TABLE(spi, stmpe_spi_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index ad7c7f157319..5e44b518f36c 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -324,7 +324,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 	guard(mutex)(&tp->mutex);
 
 	/* rom xfer is big endian */
-	cpu_to_be32_array((u32 *)tp->tx_buf, obuf, words);
+	cpu_to_be32_array((__be32 *)tp->tx_buf, obuf, words);
 
 	ret = read_poll_timeout(gpiod_get_value_cansleep, ret,
 				!ret, VSC_TP_ROM_XFER_POLL_DELAY_US,
@@ -340,7 +340,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 
 	if (ibuf)
-		be32_to_cpu_array(ibuf, (u32 *)tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, (__be32 *)tp->rx_buf, words);
 
 	return ret;
 }
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index abe79f6fd2a7..b64944367ac5 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -227,6 +227,7 @@ static int drv_cp_harray_to_user(void __user *user_buf_uva,
 static int vmci_host_setup_notify(struct vmci_ctx *context,
 				  unsigned long uva)
 {
+	struct page *page;
 	int retval;
 
 	if (context->notify_page) {
@@ -243,13 +244,11 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 	/*
 	 * Lock physical page backing a given user VA.
 	 */
-	retval = get_user_pages_fast(uva, 1, FOLL_WRITE, &context->notify_page);
-	if (retval != 1) {
-		context->notify_page = NULL;
+	retval = get_user_pages_fast(uva, 1, FOLL_WRITE, &page);
+	if (retval != 1)
 		return VMCI_ERROR_GENERIC;
-	}
-	if (context->notify_page == NULL)
-		return VMCI_ERROR_UNAVAILABLE;
+
+	context->notify_page = page;
 
 	/*
 	 * Map the locked page and set up notify pointer.
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8fd80dac11bf..bf29aad082a1 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -787,6 +788,29 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 	}
 }
 
+static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int ret;
+
+	/*
+	 * This works around the design of the RK3576's power domains, which
+	 * makes the PD_NVM power domain, which the sdhci controller on the
+	 * RK3576 is in, never come back the same way once it's run-time
+	 * suspended once. This can happen during early kernel boot if no driver
+	 * is using either PD_NVM or its child power domain PD_SDGMAC for a
+	 * short moment, leading to it being turned off to save power. By
+	 * keeping it on, sdhci suspending won't lead to PD_NVM becoming a
+	 * candidate for getting turned off.
+	 */
+	ret = dev_pm_genpd_rpm_always_on(dev, true);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "failed to set PD rpm always on, SoC may hang later: %pe\n",
+			 ERR_PTR(ret));
+
+	dwcmshc_rk35xx_postinit(host, dwc_priv);
+}
+
 static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1218,6 +1242,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 	.postinit = dwcmshc_rk35xx_postinit,
 };
 
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_rk35xx_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	},
+	.init = dwcmshc_rk35xx_init,
+	.postinit = dwcmshc_rk3576_postinit,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_th1520_ops,
@@ -1316,6 +1352,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
 	},
+	{
+		.compatible = "rockchip,rk3576-dwcmshc",
+		.data = &sdhci_dwcmshc_rk3576_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3568-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index 47e10945b8d2..63cb206269dd 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -614,7 +614,7 @@ static int mxic_ecc_finish_io_req_external(struct nand_device *nand,
 {
 	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
 	struct mxic_ecc_ctx *ctx = nand_to_ecc_ctx(nand);
-	int nents, step, ret;
+	int nents, step, ret = 0;
 
 	if (req->mode == MTD_OPS_RAW)
 		return 0;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4d2e30f4ee25..2a513dbbd975 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2113,15 +2113,26 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 * set the master's mac address to that of the first slave
 		 */
 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
-		ss.ss_family = slave_dev->type;
-		res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
-					  extack);
-		if (res) {
-			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
-			goto err_restore_mtu;
-		}
+	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
+		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
+		/* Set slave to random address to avoid duplicate mac
+		 * address in later fail over.
+		 */
+		eth_random_addr(ss.__data);
+	} else {
+		goto skip_mac_set;
 	}
 
+	ss.ss_family = slave_dev->type;
+	res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, extack);
+	if (res) {
+		slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
+		goto err_restore_mtu;
+	}
+
+skip_mac_set:
+
 	/* set no_addrconf flag before open to prevent IPv6 addrconf */
 	slave_dev->priv_flags |= IFF_NO_ADDRCONF;
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0168ad495e6c..71c30a81c36d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1326,24 +1326,7 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 		off = B53_RGMII_CTRL_P(port);
 
 	b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		rgmii_ctrl |= (RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
-		break;
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_TXC);
-		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
-		break;
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC);
-		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
-		break;
-	case PHY_INTERFACE_MODE_RGMII:
-	default:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
-		break;
-	}
+	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 
 	if (port != dev->imp_port) {
 		if (is63268(dev))
@@ -1373,8 +1356,7 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	 * tx_clk aligned timing (restoring to reset defaults)
 	 */
 	b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
-	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC |
-			RGMII_CTRL_TIMING_SEL);
+	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 
 	/* PHY_INTERFACE_MODE_RGMII_TXID means TX internal delay, make
 	 * sure that we enable the port TX clock internal delay to
@@ -1394,7 +1376,10 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
 	if (interface == PHY_INTERFACE_MODE_RGMII)
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
-	rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
+
+	if (dev->chip_id != BCM53115_DEVICE_ID)
+		rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
+
 	b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
 
 	dev_info(ds->dev, "Configured port %d for %s\n", port,
@@ -1458,6 +1443,10 @@ static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_REVMII, config->supported_interfaces);
 
+	/* BCM63xx RGMII ports support RGMII */
+	if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
+		phy_interface_set_rgmii(config->supported_interfaces);
+
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100;
 
@@ -2047,9 +2036,6 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 
 		b53_get_vlan_entry(dev, pvid, vl);
 		vl->members &= ~BIT(port);
-		if (vl->members == BIT(cpu_port))
-			vl->members &= ~BIT(cpu_port);
-		vl->untag = vl->members;
 		b53_set_vlan_entry(dev, pvid, vl);
 	}
 
@@ -2128,8 +2114,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 		}
 
 		b53_get_vlan_entry(dev, pvid, vl);
-		vl->members |= BIT(port) | BIT(cpu_port);
-		vl->untag |= BIT(port) | BIT(cpu_port);
+		vl->members |= BIT(port);
 		b53_set_vlan_entry(dev, pvid, vl);
 	}
 }
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 862c4575701f..14f39d1f59d3 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2207,7 +2207,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 			stats[stats_idx++] = (struct stats) {
 				.stat_name = cpu_to_be32(RX_BUFFERS_POSTED),
-				.value = cpu_to_be64(priv->rx[0].fill_cnt),
+				.value = cpu_to_be64(priv->rx[idx].fill_cnt),
 				.queue_id = cpu_to_be32(idx),
 			};
 		}
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index f879426cb552..26053cc85d1c 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -770,6 +770,9 @@ static int gve_tx_add_skb_dqo(struct gve_tx_ring *tx,
 	s16 completion_tag;
 
 	pkt = gve_alloc_pending_packet(tx);
+	if (!pkt)
+		return -ENOMEM;
+
 	pkt->skb = skb;
 	completion_tag = pkt - tx->dqo.pending_packets;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index dfa785e39458..625fa93fc18b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if the VF is in reset, resets successfully, or resets
- * are disabled and false otherwise.
+ * Return: True if reset was performed successfully or if resets are disabled.
+ * False if reset is already in progress.
  **/
 bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
@@ -1566,7 +1566,7 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 
 	/* If VF is being reset already we don't need to continue. */
 	if (test_and_set_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-		return true;
+		return false;
 
 	i40e_trigger_vf_reset(vf, flr);
 
@@ -4328,7 +4328,10 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 		reg = rd32(hw, I40E_GLGEN_VFLRSTAT(reg_idx));
 		if (reg & BIT(bit_idx))
 			/* i40e_reset_vf will clear the bit in GLGEN_VFLRSTAT */
-			i40e_reset_vf(vf, true);
+			if (!i40e_reset_vf(vf, true)) {
+				/* At least one VF did not finish resetting, retry next time */
+				set_bit(__I40E_VFLR_EVENT_PENDING, pf->state);
+			}
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 63d2105fce93..d1abd21cfc64 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2761,6 +2761,27 @@ void ice_map_xdp_rings(struct ice_vsi *vsi)
 	}
 }
 
+/**
+ * ice_unmap_xdp_rings - Unmap XDP rings from interrupt vectors
+ * @vsi: the VSI with XDP rings being unmapped
+ */
+static void ice_unmap_xdp_rings(struct ice_vsi *vsi)
+{
+	int v_idx;
+
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
+		struct ice_tx_ring *ring;
+
+		ice_for_each_tx_ring(ring, q_vector->tx)
+			if (!ring->tx_buf || !ice_ring_is_xdp(ring))
+				break;
+
+		/* restore the value of last node prior to XDP setup */
+		q_vector->tx.tx_ring = ring;
+	}
+}
+
 /**
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
@@ -2824,7 +2845,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	if (status) {
 		dev_err(dev, "Failed VSI LAN queue config for XDP, error: %d\n",
 			status);
-		goto clear_xdp_rings;
+		goto unmap_xdp_rings;
 	}
 
 	/* assign the prog only when it's not already present on VSI;
@@ -2840,6 +2861,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 		ice_vsi_assign_bpf_prog(vsi, prog);
 
 	return 0;
+unmap_xdp_rings:
+	ice_unmap_xdp_rings(vsi);
 clear_xdp_rings:
 	ice_for_each_xdp_txq(vsi, i)
 		if (vsi->xdp_rings[i]) {
@@ -2856,6 +2879,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	mutex_unlock(&pf->avail_q_mutex);
 
 	devm_kfree(dev, vsi->xdp_rings);
+	vsi->xdp_rings = NULL;
+
 	return -ENOMEM;
 }
 
@@ -2871,7 +2896,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf = vsi->back;
-	int i, v_idx;
+	int i;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
 	 * rings
@@ -2879,17 +2904,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 	if (cfg_type == ICE_XDP_CFG_PART)
 		goto free_qmap;
 
-	ice_for_each_q_vector(vsi, v_idx) {
-		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
-		struct ice_tx_ring *ring;
-
-		ice_for_each_tx_ring(ring, q_vector->tx)
-			if (!ring->tx_buf || !ice_ring_is_xdp(ring))
-				break;
-
-		/* restore the value of last node prior to XDP setup */
-		q_vector->tx.tx_ring = ring;
-	}
+	ice_unmap_xdp_rings(vsi);
 
 free_qmap:
 	mutex_lock(&pf->avail_q_mutex);
@@ -3034,11 +3049,14 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		xdp_ring_err = ice_vsi_determine_xdp_res(vsi);
 		if (xdp_ring_err) {
 			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
+			goto resume_if;
 		} else {
 			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog,
 							     ICE_XDP_CFG_FULL);
-			if (xdp_ring_err)
+			if (xdp_ring_err) {
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
+				goto resume_if;
+			}
 		}
 		xdp_features_set_redirect_target(vsi->netdev, true);
 		/* reallocate Rx queues that are used for zero-copy */
@@ -3056,6 +3074,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Rx resources failed");
 	}
 
+resume_if:
 	if (if_running)
 		ret = ice_up(vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 6ca13c5dcb14..d9d09296d1d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -84,6 +84,27 @@ ice_sched_find_node_by_teid(struct ice_sched_node *start_node, u32 teid)
 	return NULL;
 }
 
+/**
+ * ice_sched_find_next_vsi_node - find the next node for a given VSI
+ * @vsi_node: VSI support node to start search with
+ *
+ * Return: Next VSI support node, or NULL.
+ *
+ * The function returns a pointer to the next node from the VSI layer
+ * assigned to the given VSI, or NULL if there is no such a node.
+ */
+static struct ice_sched_node *
+ice_sched_find_next_vsi_node(struct ice_sched_node *vsi_node)
+{
+	unsigned int vsi_handle = vsi_node->vsi_handle;
+
+	while ((vsi_node = vsi_node->sibling) != NULL)
+		if (vsi_node->vsi_handle == vsi_handle)
+			break;
+
+	return vsi_node;
+}
+
 /**
  * ice_aqc_send_sched_elem_cmd - send scheduling elements cmd
  * @hw: pointer to the HW struct
@@ -1084,8 +1105,10 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 		if (parent->num_children < max_child_nodes) {
 			new_num_nodes = max_child_nodes - parent->num_children;
 		} else {
-			/* This parent is full, try the next sibling */
-			parent = parent->sibling;
+			/* This parent is full,
+			 * try the next available sibling.
+			 */
+			parent = ice_sched_find_next_vsi_node(parent);
 			/* Don't modify the first node TEID memory if the
 			 * first node was added already in the above call.
 			 * Instead send some temp memory for all other
@@ -1528,12 +1551,23 @@ ice_sched_get_free_qparent(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 	/* get the first queue group node from VSI sub-tree */
 	qgrp_node = ice_sched_get_first_node(pi, vsi_node, qgrp_layer);
 	while (qgrp_node) {
+		struct ice_sched_node *next_vsi_node;
+
 		/* make sure the qgroup node is part of the VSI subtree */
 		if (ice_sched_find_node_in_subtree(pi->hw, vsi_node, qgrp_node))
 			if (qgrp_node->num_children < max_children &&
 			    qgrp_node->owner == owner)
 				break;
 		qgrp_node = qgrp_node->sibling;
+		if (qgrp_node)
+			continue;
+
+		next_vsi_node = ice_sched_find_next_vsi_node(vsi_node);
+		if (!next_vsi_node)
+			break;
+
+		vsi_node = next_vsi_node;
+		qgrp_node = ice_sched_get_first_node(pi, vsi_node, qgrp_layer);
 	}
 
 	/* Select the best queue group */
@@ -1604,16 +1638,16 @@ ice_sched_get_agg_node(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 /**
  * ice_sched_calc_vsi_child_nodes - calculate number of VSI child nodes
  * @hw: pointer to the HW struct
- * @num_qs: number of queues
+ * @num_new_qs: number of new queues that will be added to the tree
  * @num_nodes: num nodes array
  *
  * This function calculates the number of VSI child nodes based on the
  * number of queues.
  */
 static void
-ice_sched_calc_vsi_child_nodes(struct ice_hw *hw, u16 num_qs, u16 *num_nodes)
+ice_sched_calc_vsi_child_nodes(struct ice_hw *hw, u16 num_new_qs, u16 *num_nodes)
 {
-	u16 num = num_qs;
+	u16 num = num_new_qs;
 	u8 i, qgl, vsil;
 
 	qgl = ice_sched_get_qgrp_layer(hw);
@@ -1779,7 +1813,11 @@ ice_sched_add_vsi_support_nodes(struct ice_port_info *pi, u16 vsi_handle,
 		if (!parent)
 			return -EIO;
 
-		if (i == vsil)
+		/* Do not modify the VSI handle for already existing VSI nodes,
+		 * (if no new VSI node was added to the tree).
+		 * Assign the VSI handle only to newly added VSI nodes.
+		 */
+		if (i == vsil && num_added)
 			parent->vsi_handle = vsi_handle;
 	}
 
@@ -1812,6 +1850,41 @@ ice_sched_add_vsi_to_topo(struct ice_port_info *pi, u16 vsi_handle, u8 tc)
 					       num_nodes);
 }
 
+/**
+ * ice_sched_recalc_vsi_support_nodes - recalculate VSI support nodes count
+ * @hw: pointer to the HW struct
+ * @vsi_node: pointer to the leftmost VSI node that needs to be extended
+ * @new_numqs: new number of queues that has to be handled by the VSI
+ * @new_num_nodes: pointer to nodes count table to modify the VSI layer entry
+ *
+ * This function recalculates the number of supported nodes that need to
+ * be added after adding more Tx queues for a given VSI.
+ * The number of new VSI support nodes that shall be added will be saved
+ * to the @new_num_nodes table for the VSI layer.
+ */
+static void
+ice_sched_recalc_vsi_support_nodes(struct ice_hw *hw,
+				   struct ice_sched_node *vsi_node,
+				   unsigned int new_numqs, u16 *new_num_nodes)
+{
+	u32 vsi_nodes_cnt = 1;
+	u32 max_queue_cnt = 1;
+	u32 qgl, vsil;
+
+	qgl = ice_sched_get_qgrp_layer(hw);
+	vsil = ice_sched_get_vsi_layer(hw);
+
+	for (u32 i = vsil; i <= qgl; i++)
+		max_queue_cnt *= hw->max_children[i];
+
+	while ((vsi_node = ice_sched_find_next_vsi_node(vsi_node)) != NULL)
+		vsi_nodes_cnt++;
+
+	if (new_numqs > (max_queue_cnt * vsi_nodes_cnt))
+		new_num_nodes[vsil] = DIV_ROUND_UP(new_numqs, max_queue_cnt) -
+				      vsi_nodes_cnt;
+}
+
 /**
  * ice_sched_update_vsi_child_nodes - update VSI child nodes
  * @pi: port information structure
@@ -1863,15 +1936,25 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 			return status;
 	}
 
-	if (new_numqs)
-		ice_sched_calc_vsi_child_nodes(hw, new_numqs, new_num_nodes);
-	/* Keep the max number of queue configuration all the time. Update the
-	 * tree only if number of queues > previous number of queues. This may
+	ice_sched_recalc_vsi_support_nodes(hw, vsi_node,
+					   new_numqs, new_num_nodes);
+	ice_sched_calc_vsi_child_nodes(hw, new_numqs - prev_numqs,
+				       new_num_nodes);
+
+	/* Never decrease the number of queues in the tree. Update the tree
+	 * only if number of queues > previous number of queues. This may
 	 * leave some extra nodes in the tree if number of queues < previous
 	 * number but that wouldn't harm anything. Removing those extra nodes
 	 * may complicate the code if those nodes are part of SRL or
 	 * individually rate limited.
+	 * Also, add the required VSI support nodes if the existing ones cannot
+	 * handle the requested new number of queues.
 	 */
+	status = ice_sched_add_vsi_support_nodes(pi, vsi_handle, tc_node,
+						 new_num_nodes);
+	if (status)
+		return status;
+
 	status = ice_sched_add_vsi_child_nodes(pi, vsi_handle, tc_node,
 					       new_num_nodes, owner);
 	if (status)
@@ -2012,6 +2095,58 @@ static bool ice_sched_is_leaf_node_present(struct ice_sched_node *node)
 	return (node->info.data.elem_type == ICE_AQC_ELEM_TYPE_LEAF);
 }
 
+/**
+ * ice_sched_rm_vsi_subtree - remove all nodes assigned to a given VSI
+ * @pi: port information structure
+ * @vsi_node: pointer to the leftmost node of the VSI to be removed
+ * @owner: LAN or RDMA
+ * @tc: TC number
+ *
+ * Return: Zero in case of success, or -EBUSY if the VSI has leaf nodes in TC.
+ *
+ * This function removes all the VSI support nodes associated with a given VSI
+ * and its LAN or RDMA children nodes from the scheduler tree.
+ */
+static int
+ice_sched_rm_vsi_subtree(struct ice_port_info *pi,
+			 struct ice_sched_node *vsi_node, u8 owner, u8 tc)
+{
+	u16 vsi_handle = vsi_node->vsi_handle;
+	bool all_vsi_nodes_removed = true;
+	int j = 0;
+
+	while (vsi_node) {
+		struct ice_sched_node *next_vsi_node;
+
+		if (ice_sched_is_leaf_node_present(vsi_node)) {
+			ice_debug(pi->hw, ICE_DBG_SCHED, "VSI has leaf nodes in TC %d\n", tc);
+			return -EBUSY;
+		}
+		while (j < vsi_node->num_children) {
+			if (vsi_node->children[j]->owner == owner)
+				ice_free_sched_node(pi, vsi_node->children[j]);
+			else
+				j++;
+		}
+
+		next_vsi_node = ice_sched_find_next_vsi_node(vsi_node);
+
+		/* remove the VSI if it has no children */
+		if (!vsi_node->num_children)
+			ice_free_sched_node(pi, vsi_node);
+		else
+			all_vsi_nodes_removed = false;
+
+		vsi_node = next_vsi_node;
+	}
+
+	/* clean up aggregator related VSI info if any */
+	if (all_vsi_nodes_removed)
+		ice_sched_rm_agg_vsi_info(pi, vsi_handle);
+
+	return 0;
+}
+
 /**
  * ice_sched_rm_vsi_cfg - remove the VSI and its children nodes
  * @pi: port information structure
@@ -2038,7 +2173,6 @@ ice_sched_rm_vsi_cfg(struct ice_port_info *pi, u16 vsi_handle, u8 owner)
 
 	ice_for_each_traffic_class(i) {
 		struct ice_sched_node *vsi_node, *tc_node;
-		u8 j = 0;
 
 		tc_node = ice_sched_get_tc_node(pi, i);
 		if (!tc_node)
@@ -2048,31 +2182,12 @@ ice_sched_rm_vsi_cfg(struct ice_port_info *pi, u16 vsi_handle, u8 owner)
 		if (!vsi_node)
 			continue;
 
-		if (ice_sched_is_leaf_node_present(vsi_node)) {
-			ice_debug(pi->hw, ICE_DBG_SCHED, "VSI has leaf nodes in TC %d\n", i);
-			status = -EBUSY;
+		status = ice_sched_rm_vsi_subtree(pi, vsi_node, owner, i);
+		if (status)
 			goto exit_sched_rm_vsi_cfg;
-		}
-		while (j < vsi_node->num_children) {
-			if (vsi_node->children[j]->owner == owner) {
-				ice_free_sched_node(pi, vsi_node->children[j]);
 
-				/* reset the counter again since the num
-				 * children will be updated after node removal
-				 */
-				j = 0;
-			} else {
-				j++;
-			}
-		}
-		/* remove the VSI if it has no children */
-		if (!vsi_node->num_children) {
-			ice_free_sched_node(pi, vsi_node);
-			vsi_ctx->sched.vsi_node[i] = NULL;
+		vsi_ctx->sched.vsi_node[i] = NULL;
 
-			/* clean up aggregator related VSI info if any */
-			ice_sched_rm_agg_vsi_info(pi, vsi_handle);
-		}
 		if (owner == ICE_SCHED_NODE_OWNER_LAN)
 			vsi_ctx->sched.max_lanq[i] = 0;
 		else
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 615e74d03845..ba645ab22d39 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1802,11 +1802,19 @@ void idpf_vc_event_task(struct work_struct *work)
 	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
-	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags) ||
-	    test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
-		set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
-		idpf_init_hard_reset(adapter);
-	}
+	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
+		goto func_reset;
+
+	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
+		goto drv_load;
+
+	return;
+
+func_reset:
+	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+drv_load:
+	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
+	idpf_init_hard_reset(adapter);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index dfd7cf1d9aa0..a986dd572555 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -362,17 +362,18 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 {
 	struct idpf_tx_offload_params offload = { };
 	struct idpf_tx_buf *first;
+	int csum, tso, needed;
 	unsigned int count;
 	__be16 protocol;
-	int csum, tso;
 
 	count = idpf_tx_desc_count_required(tx_q, skb);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
-	if (idpf_tx_maybe_stop_common(tx_q,
-				      count + IDPF_TX_DESCS_PER_CACHE_LINE +
-				      IDPF_TX_DESCS_FOR_CTX)) {
+	needed = count + IDPF_TX_DESCS_PER_CACHE_LINE + IDPF_TX_DESCS_FOR_CTX;
+	if (!netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+				       IDPF_DESC_UNUSED(tx_q),
+				       needed, needed)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		u64_stats_update_begin(&tx_q->stats_sync);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 623bf17f87f9..c6c36de58b9d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2132,6 +2132,19 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
+/* Global conditions to tell whether the txq (and related resources)
+ * has room to allow the use of "size" descriptors.
+ */
+static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
+{
+	if (IDPF_DESC_UNUSED(tx_q) < size ||
+	    IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
+		IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
+	    IDPF_TX_BUF_RSV_LOW(tx_q))
+		return 0;
+	return 1;
+}
+
 /**
  * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop conditions
  * @tx_q: the queue to be checked
@@ -2142,29 +2155,11 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
 				     unsigned int descs_needed)
 {
-	if (idpf_tx_maybe_stop_common(tx_q, descs_needed))
-		goto out;
-
-	/* If there are too many outstanding completions expected on the
-	 * completion queue, stop the TX queue to give the device some time to
-	 * catch up
-	 */
-	if (unlikely(IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
-		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq)))
-		goto splitq_stop;
-
-	/* Also check for available book keeping buffers; if we are low, stop
-	 * the queue to wait for more completions
-	 */
-	if (unlikely(IDPF_TX_BUF_RSV_LOW(tx_q)))
-		goto splitq_stop;
-
-	return 0;
-
-splitq_stop:
-	netif_stop_subqueue(tx_q->netdev, tx_q->idx);
+	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+				      idpf_txq_has_room(tx_q, descs_needed),
+				      1, 1))
+		return 0;
 
-out:
 	u64_stats_update_begin(&tx_q->stats_sync);
 	u64_stats_inc(&tx_q->q_stats.q_busy);
 	u64_stats_update_end(&tx_q->stats_sync);
@@ -2190,12 +2185,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 	tx_q->next_to_use = val;
 
-	if (idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED)) {
-		u64_stats_update_begin(&tx_q->stats_sync);
-		u64_stats_inc(&tx_q->q_stats.q_busy);
-		u64_stats_update_end(&tx_q->stats_sync);
-	}
-
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
 	 * applicable for weak-ordered memory model archs,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9c1fe84108ed..ffeeaede6cf8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1052,12 +1052,4 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
-static inline bool idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q,
-					     u32 needed)
-{
-	return !netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-					  IDPF_DESC_UNUSED(tx_q),
-					  needed, needed);
-}
-
 #endif /* !_IDPF_TXRX_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 99bdb95bf226..151beea20d34 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -376,7 +376,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
  * All waiting threads will be woken-up and their transaction aborted. Further
  * operations on that object will fail.
  */
-static void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 83da5d8da56b..23271cf0a216 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -66,5 +66,6 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 
 #endif /* _IDPF_VIRTCHNL_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 35acc07bd964..5765bac119f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -1638,6 +1638,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	if (!node->is_static)
 		dwrr_del_node = true;
 
+	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
 	/* destroy the leaf node */
 	otx2_qos_disable_sq(pfvf, qid);
 	otx2_qos_destroy_node(pfvf, node);
@@ -1682,9 +1683,6 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	}
 	kfree(new_cfg);
 
-	/* update tx_real_queues */
-	otx2_qos_update_tx_netdev_queues(pfvf);
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
index 9d887bfc3108..ac9345644068 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
@@ -256,6 +256,26 @@ int otx2_qos_enable_sq(struct otx2_nic *pfvf, int qidx)
 	return err;
 }
 
+static int otx2_qos_nix_npa_ndc_sync(struct otx2_nic *pfvf)
+{
+	struct ndc_sync_op *req;
+	int rc;
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_ndc_sync_op(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->nix_lf_tx_sync = true;
+	req->npa_lf_sync = true;
+	rc = otx2_sync_mbox_msg(&pfvf->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+	return rc;
+}
+
 void otx2_qos_disable_sq(struct otx2_nic *pfvf, int qidx)
 {
 	struct otx2_qset *qset = &pfvf->qset;
@@ -285,6 +305,8 @@ void otx2_qos_disable_sq(struct otx2_nic *pfvf, int qidx)
 
 	otx2_qos_sqb_flush(pfvf, sq_idx);
 	otx2_smq_flush(pfvf, otx2_get_smq_idx(pfvf, sq_idx));
+	/* NIX/NPA NDC sync */
+	otx2_qos_nix_npa_ndc_sync(pfvf);
 	otx2_cleanup_tx_cqes(pfvf, cq);
 
 	mutex_lock(&pfvf->mbox.lock);
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index c2ab87828d85..5eb7a97e7eb1 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1468,6 +1468,8 @@ static __maybe_unused int mtk_star_suspend(struct device *dev)
 	if (netif_running(ndev))
 		mtk_star_disable(ndev);
 
+	netif_device_detach(ndev);
+
 	clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 
 	return 0;
@@ -1492,6 +1494,8 @@ static __maybe_unused int mtk_star_resume(struct device *dev)
 			clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 	}
 
+	netif_device_attach(ndev);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..d73a2044dc26 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
-	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 max_val_cycles = freq_khz * 1000ULL * MLX4_EN_WRAP_AROUND_SEC;
 	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 08ab0999f7b3..14192da4b8ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -706,8 +706,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-				 * as we know this is a page_pool page.
+				/* No need to check page_pool_page_is_pp() as we
+				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 1baf8933a07c..39dcbf863421 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -266,8 +266,7 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 				  struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
-	struct xfrm_state *x = sa_entry->x;
-	struct net_device *netdev;
+	struct net_device *netdev = sa_entry->dev;
 	struct neighbour *n;
 	u8 addr[ETH_ALEN];
 	const void *pkey;
@@ -277,8 +276,6 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
-	netdev = x->xso.real_dev;
-
 	mlx5_query_mac_address(mdev, addr);
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
@@ -707,6 +704,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 		return -ENOMEM;
 
 	sa_entry->x = x;
+	sa_entry->dev = netdev;
 	sa_entry->ipsec = ipsec;
 	/* Check if this SA is originated from acquire flow temporary SA */
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
@@ -849,8 +847,6 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 	struct mlx5e_ipsec_sa_entry *sa_entry;
 	struct mlx5e_ipsec *ipsec;
 	struct neighbour *n = ptr;
-	struct net_device *netdev;
-	struct xfrm_state *x;
 	unsigned long idx;
 
 	if (event != NETEVENT_NEIGH_UPDATE || !(n->nud_state & NUD_VALID))
@@ -870,11 +866,9 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 				continue;
 		}
 
-		x = sa_entry->x;
-		netdev = x->xso.real_dev;
 		data = sa_entry->work->data;
 
-		neigh_ha_snapshot(data->addr, n, netdev);
+		neigh_ha_snapshot(data->addr, n, sa_entry->dev);
 		queue_work(ipsec->wq, &sa_entry->work->work);
 	}
 
@@ -1005,8 +999,8 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	size_t headers;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_state_lock));
+		       lockdep_is_held(&net->xfrm.xfrm_cfg_mutex) ||
+		       lockdep_is_held(&net->xfrm.xfrm_state_lock));
 
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
 		return;
@@ -1141,7 +1135,7 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
 static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 				 struct netlink_ext_ack *extack)
 {
-	struct net_device *netdev = x->xdo.real_dev;
+	struct net_device *netdev = x->xdo.dev;
 	struct mlx5e_ipsec_pol_entry *pol_entry;
 	struct mlx5e_priv *priv;
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 7d943e93cf6d..9aff779c77c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -260,6 +260,7 @@ struct mlx5e_ipsec_limits {
 struct mlx5e_ipsec_sa_entry {
 	struct mlx5e_ipsec_esn_state esn_state;
 	struct xfrm_state *x;
+	struct net_device *dev;
 	struct mlx5e_ipsec *ipsec;
 	struct mlx5_accel_esp_xfrm_attrs attrs;
 	void (*set_iv_op)(struct sk_buff *skb, struct xfrm_state *x,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 218d5402cd1a..4d766eea32a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2028,9 +2028,8 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
 	return err;
 }
 
-static bool mlx5_flow_has_geneve_opt(struct mlx5e_tc_flow *flow)
+static bool mlx5_flow_has_geneve_opt(struct mlx5_flow_spec *spec)
 {
-	struct mlx5_flow_spec *spec = &flow->attr->parse_attr->spec;
 	void *headers_v = MLX5_ADDR_OF(fte_match_param,
 				       spec->match_value,
 				       misc_parameters_3);
@@ -2069,7 +2068,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	}
 	complete_all(&flow->del_hw_done);
 
-	if (mlx5_flow_has_geneve_opt(flow))
+	if (mlx5_flow_has_geneve_opt(&attr->parse_attr->spec))
 		mlx5_geneve_tlv_option_del(priv->mdev->geneve);
 
 	if (flow->decap_route)
@@ -2574,12 +2573,13 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
 
 		err = mlx5e_tc_tun_parse(filter_dev, priv, tmp_spec, f, match_level);
 		if (err) {
-			kvfree(tmp_spec);
 			NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
 			netdev_warn(priv->netdev, "Failed to parse tunnel attributes");
-			return err;
+		} else {
+			err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
 		}
-		err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
+		if (mlx5_flow_has_geneve_opt(tmp_spec))
+			mlx5_geneve_tlv_option_del(priv->mdev->geneve);
 		kvfree(tmp_spec);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 7aef30dbd82d..6544546a1153 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1295,12 +1295,15 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_ECPF, enabled_events);
 		if (ret)
 			goto ecpf_err;
-		if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-			ret = mlx5_eswitch_load_ec_vf_vports(esw, esw->esw_funcs.num_ec_vfs,
-							     enabled_events);
-			if (ret)
-				goto ec_vf_err;
-		}
+	}
+
+	/* Enable ECVF vports */
+	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
+		ret = mlx5_eswitch_load_ec_vf_vports(esw,
+						     esw->esw_funcs.num_ec_vfs,
+						     enabled_events);
+		if (ret)
+			goto ec_vf_err;
 	}
 
 	/* Enable VF vports */
@@ -1331,9 +1334,11 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 {
 	mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
 
+	if (mlx5_core_ec_sriov_enabled(esw->dev))
+		mlx5_eswitch_unload_ec_vf_vports(esw,
+						 esw->esw_funcs.num_ec_vfs);
+
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		if (mlx5_core_ec_sriov_enabled(esw->dev))
-			mlx5_eswitch_unload_ec_vf_vports(esw, esw->esw_funcs.num_vfs);
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 0ce999706d41..1bc88743d2df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2200,6 +2200,7 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 	struct mlx5_flow_handle *rule;
 	struct match_list *iter;
 	bool take_write = false;
+	bool try_again = false;
 	struct fs_fte *fte;
 	u64  version = 0;
 	int err;
@@ -2264,6 +2265,7 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 		nested_down_write_ref_node(&g->node, FS_LOCK_PARENT);
 
 		if (!g->node.active) {
+			try_again = true;
 			up_write_ref_node(&g->node, false);
 			continue;
 		}
@@ -2285,7 +2287,8 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 			tree_put_node(&fte->node, false);
 		return rule;
 	}
-	rule = ERR_PTR(-ENOENT);
+	err = try_again ? -EAGAIN : -ENOENT;
+	rule = ERR_PTR(err);
 out:
 	kmem_cache_free(steering->ftes_cache, fte);
 	return rule;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 972e8e9df585..9bc9bd83c232 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
 static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
 {
 	struct device *device = mlx5_core_dma_dev(dev);
-	int nid = dev_to_node(device);
+	int nid = dev->priv.numa_node;
 	struct page *page;
 	u64 zero_addr = 1;
 	u64 addr;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
index ab5f8f07f1f7..72b19b05c0cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
@@ -558,6 +558,9 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 	HWS_SET_HDR(fc, match_param, IP_PROTOCOL_O,
 		    outer_headers.ip_protocol,
 		    eth_l3_outer.protocol_next_header);
+	HWS_SET_HDR(fc, match_param, IP_VERSION_O,
+		    outer_headers.ip_version,
+		    eth_l3_outer.ip_version);
 	HWS_SET_HDR(fc, match_param, IP_TTL_O,
 		    outer_headers.ttl_hoplimit,
 		    eth_l3_outer.time_to_live_hop_limit);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 812ad9d61676..9836fbbea0cc 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1330,7 +1330,7 @@ static int lan743x_mac_set_mtu(struct lan743x_adapter *adapter, int new_mtu)
 }
 
 /* PHY */
-static int lan743x_phy_reset(struct lan743x_adapter *adapter)
+static int lan743x_hw_reset_phy(struct lan743x_adapter *adapter)
 {
 	u32 data;
 
@@ -1346,11 +1346,6 @@ static int lan743x_phy_reset(struct lan743x_adapter *adapter)
 				  50000, 1000000);
 }
 
-static int lan743x_phy_init(struct lan743x_adapter *adapter)
-{
-	return lan743x_phy_reset(adapter);
-}
-
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 {
 	u32 id_rev;
@@ -3505,10 +3500,6 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	ret = lan743x_phy_init(adapter);
-	if (ret)
-		return ret;
-
 	ret = lan743x_ptp_init(adapter);
 	if (ret)
 		return ret;
@@ -3642,6 +3633,10 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	if (ret)
 		goto cleanup_pci;
 
+	ret = lan743x_hw_reset_phy(adapter);
+	if (ret)
+		goto cleanup_pci;
+
 	ret = lan743x_hardware_init(adapter, pdev);
 	if (ret)
 		goto cleanup_pci;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 534d4716d5f7..b34e015eedf9 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -353,6 +353,11 @@ static void lan966x_ifh_set_rew_op(void *ifh, u64 rew_op)
 	lan966x_ifh_set(ifh, rew_op, IFH_POS_REW_CMD, IFH_WID_REW_CMD);
 }
 
+static void lan966x_ifh_set_oam_type(void *ifh, u64 oam_type)
+{
+	lan966x_ifh_set(ifh, oam_type, IFH_POS_PDU_TYPE, IFH_WID_PDU_TYPE);
+}
+
 static void lan966x_ifh_set_timestamp(void *ifh, u64 timestamp)
 {
 	lan966x_ifh_set(ifh, timestamp, IFH_POS_TIMESTAMP, IFH_WID_TIMESTAMP);
@@ -380,6 +385,7 @@ static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
 			return err;
 
 		lan966x_ifh_set_rew_op(ifh, LAN966X_SKB_CB(skb)->rew_op);
+		lan966x_ifh_set_oam_type(ifh, LAN966X_SKB_CB(skb)->pdu_type);
 		lan966x_ifh_set_timestamp(ifh, LAN966X_SKB_CB(skb)->ts_id);
 	}
 
@@ -874,6 +880,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	lan966x_vlan_port_set_vlan_aware(port, 0);
 	lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
 	lan966x_vlan_port_apply(port);
+	lan966x_vlan_port_rew_host(port);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 25cb2f61986f..8aa39497818f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -75,6 +75,10 @@
 #define IFH_REW_OP_ONE_STEP_PTP		0x3
 #define IFH_REW_OP_TWO_STEP_PTP		0x4
 
+#define IFH_PDU_TYPE_NONE		0
+#define IFH_PDU_TYPE_IPV4		7
+#define IFH_PDU_TYPE_IPV6		8
+
 #define FDMA_RX_DCB_MAX_DBS		1
 #define FDMA_TX_DCB_MAX_DBS		1
 
@@ -254,6 +258,7 @@ struct lan966x_phc {
 
 struct lan966x_skb_cb {
 	u8 rew_op;
+	u8 pdu_type;
 	u16 ts_id;
 	unsigned long jiffies;
 };
@@ -492,6 +497,7 @@ void lan966x_vlan_port_apply(struct lan966x_port *port);
 bool lan966x_vlan_cpu_member_cpu_vlan_mask(struct lan966x *lan966x, u16 vid);
 void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
 				      bool vlan_aware);
+void lan966x_vlan_port_rew_host(struct lan966x_port *port);
 int lan966x_vlan_port_set_vid(struct lan966x_port *port,
 			      u16 vid,
 			      bool pvid,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 63905bb5a63a..87e5e81d40dc 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -322,34 +322,55 @@ void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
 	*cfg = phc->hwtstamp_config;
 }
 
-static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
+static void lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb,
+				 u8 *rew_op, u8 *pdu_type)
 {
 	struct ptp_header *header;
 	u8 msgtype;
 	int type;
 
-	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP)
-		return IFH_REW_OP_NOOP;
+	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
 	type = ptp_classify_raw(skb);
-	if (type == PTP_CLASS_NONE)
-		return IFH_REW_OP_NOOP;
+	if (type == PTP_CLASS_NONE) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
 	header = ptp_parse_header(skb, type);
-	if (!header)
-		return IFH_REW_OP_NOOP;
+	if (!header) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
-	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP)
-		return IFH_REW_OP_TWO_STEP_PTP;
+	if (type & PTP_CLASS_L2)
+		*pdu_type = IFH_PDU_TYPE_NONE;
+	if (type & PTP_CLASS_IPV4)
+		*pdu_type = IFH_PDU_TYPE_IPV4;
+	if (type & PTP_CLASS_IPV6)
+		*pdu_type = IFH_PDU_TYPE_IPV6;
+
+	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP) {
+		*rew_op = IFH_REW_OP_TWO_STEP_PTP;
+		return;
+	}
 
 	/* If it is sync and run 1 step then set the correct operation,
 	 * otherwise run as 2 step
 	 */
 	msgtype = ptp_get_msgtype(header, type);
-	if ((msgtype & 0xf) == 0)
-		return IFH_REW_OP_ONE_STEP_PTP;
+	if ((msgtype & 0xf) == 0) {
+		*rew_op = IFH_REW_OP_ONE_STEP_PTP;
+		return;
+	}
 
-	return IFH_REW_OP_TWO_STEP_PTP;
+	*rew_op = IFH_REW_OP_TWO_STEP_PTP;
 }
 
 static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
@@ -374,10 +395,12 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
 {
 	struct lan966x *lan966x = port->lan966x;
 	unsigned long flags;
+	u8 pdu_type;
 	u8 rew_op;
 
-	rew_op = lan966x_ptp_classify(port, skb);
+	lan966x_ptp_classify(port, skb, &rew_op, &pdu_type);
 	LAN966X_SKB_CB(skb)->rew_op = rew_op;
+	LAN966X_SKB_CB(skb)->pdu_type = pdu_type;
 
 	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
 		return 0;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
index 1c88120eb291..bcb4db76b75c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
@@ -297,6 +297,7 @@ static void lan966x_port_bridge_leave(struct lan966x_port *port,
 	lan966x_vlan_port_set_vlan_aware(port, false);
 	lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
 	lan966x_vlan_port_apply(port);
+	lan966x_vlan_port_rew_host(port);
 }
 
 int lan966x_port_changeupper(struct net_device *dev,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
index fa34a739c748..7da22520724c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
@@ -149,6 +149,27 @@ void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
 	port->vlan_aware = vlan_aware;
 }
 
+/* When the interface is in host mode, the interface should not be vlan aware
+ * but it should insert all the tags that it gets from the network stack.
+ * The tags are not in the data of the frame but actually in the skb and the ifh
+ * is configured already to get this tag. So what we need to do is to update the
+ * rewriter to insert the vlan tag for all frames which have a vlan tag
+ * different than 0.
+ */
+void lan966x_vlan_port_rew_host(struct lan966x_port *port)
+{
+	struct lan966x *lan966x = port->lan966x;
+	u32 val;
+
+	/* Tag all frames except when VID=0*/
+	val = REW_TAG_CFG_TAG_CFG_SET(2);
+
+	/* Update only some bits in the register */
+	lan_rmw(val,
+		REW_TAG_CFG_TAG_CFG,
+		lan966x, REW_TAG_CFG(port->chip_port));
+}
+
 void lan966x_vlan_port_apply(struct lan966x_port *port)
 {
 	struct lan966x *lan966x = port->lan966x;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index c9693f77e1f6..ac6f2e3a3fcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -32,6 +32,11 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	int i, ret = 0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		netdev_warn(priv->dev, "Invalid PTP rate");
+		return -EINVAL;
+	}
+
 	ret |= est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
 	ret |= est_write(est_addr, EST_BTR_HIGH, cfg->btr[1], false);
 	ret |= est_write(est_addr, EST_TER, cfg->ter, false);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 918d7f2e8ba9..f68e3ece919c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -835,6 +835,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
 		return -EOPNOTSUPP;
 
+	if (!priv->plat->clk_ptp_rate) {
+		netdev_err(priv->dev, "Invalid PTP clock rate");
+		return -EINVAL;
+	}
+
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index aaf008bdbbcd..8fd868b671a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -419,6 +419,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
+	static int bus_id = -ENODEV;
 	int phy_mode;
 	void *ret;
 	int rc;
@@ -454,8 +455,14 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	of_property_read_u32(np, "max-speed", &plat->max_speed);
 
 	plat->bus_id = of_alias_get_id(np, "ethernet");
-	if (plat->bus_id < 0)
-		plat->bus_id = 0;
+	if (plat->bus_id < 0) {
+		if (bus_id < 0)
+			bus_id = of_alias_get_highest_id("ethernet");
+		/* No ethernet alias found, init at -1 so first bus_id is 0 */
+		if (bus_id < 0)
+			bus_id = -1;
+		plat->bus_id = ++bus_id;
+	}
 
 	/* Default to phy auto-detection */
 	plat->phy_addr = -1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index a6b1de9a251d..5c85040a1b93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -303,7 +303,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
-	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
+	if (priv->plat->has_gmac4)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
 	stmmac_ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 6f0edae38ea2..172ae38381b4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -29,6 +29,14 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	spin_lock(&prueth->stats_lock);
 
 	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
+		/* In MII mode TX lines are swapped inside ICSSG, so read Tx stats
+		 * from slice1 for port0 and slice0 for port1 to get accurate Tx
+		 * stats for a given port
+		 */
+		if (emac->phy_if == PHY_INTERFACE_MODE_MII &&
+		    icssg_all_miig_stats[i].offset >= ICSSG_TX_PACKET_OFFSET &&
+		    icssg_all_miig_stats[i].offset <= ICSSG_TX_BYTE_OFFSET)
+			base = stats_base[slice ^ 1];
 		regmap_read(prueth->miig_rt,
 			    base + icssg_all_miig_stats[i].offset,
 			    &val);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fe3438abcd25..2d47b35443af 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -843,7 +843,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	dev_consume_skb_any(skbuf_dma->skb);
 	netif_txq_completed_wake(txq, 1, len,
 				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
-				 2 * MAX_SKB_FRAGS);
+				 2);
 }
 
 /**
@@ -877,7 +877,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 
 	dma_dev = lp->tx_chan->device;
 	sg_len = skb_shinfo(skb)->nr_frags + 1;
-	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= sg_len) {
+	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= 1) {
 		netif_stop_queue(ndev);
 		if (net_ratelimit())
 			netdev_warn(ndev, "TX ring unexpectedly full\n");
@@ -927,7 +927,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	txq = skb_get_tx_queue(lp->ndev, skb);
 	netdev_tx_sent_queue(txq, skb->len);
 	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
-			     MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS);
+			     1, 2);
 
 	dmaengine_submit(dma_tx_desc);
 	dma_async_issue_pending(lp->tx_chan);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ee2159282573..090a56a5e456 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -246,15 +246,39 @@ static sci_t make_sci(const u8 *addr, __be16 port)
 	return sci;
 }
 
-static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
+static sci_t macsec_active_sci(struct macsec_secy *secy)
 {
-	sci_t sci;
+	struct macsec_rx_sc *rx_sc = rcu_dereference_bh(secy->rx_sc);
+
+	/* Case single RX SC */
+	if (rx_sc && !rcu_dereference_bh(rx_sc->next))
+		return (rx_sc->active) ? rx_sc->sci : 0;
+	/* Case no RX SC or multiple */
+	else
+		return 0;
+}
+
+static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
+			      struct macsec_rxh_data *rxd)
+{
+	struct macsec_dev *macsec;
+	sci_t sci = 0;
 
-	if (sci_present)
+	/* SC = 1 */
+	if (sci_present) {
 		memcpy(&sci, hdr->secure_channel_id,
 		       sizeof(hdr->secure_channel_id));
-	else
+	/* SC = 0; ES = 0 */
+	} else if ((!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) &&
+		   (list_is_singular(&rxd->secys))) {
+		/* Only one SECY should exist on this scenario */
+		macsec = list_first_or_null_rcu(&rxd->secys, struct macsec_dev,
+						secys);
+		if (macsec)
+			return macsec_active_sci(&macsec->secy);
+	} else {
 		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
+	}
 
 	return sci;
 }
@@ -1108,7 +1132,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
 	unsigned int len;
-	sci_t sci;
+	sci_t sci = 0;
 	u32 hdr_pn;
 	bool cbit;
 	struct pcpu_rx_sc_stats *rxsc_stats;
@@ -1155,11 +1179,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
 	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
-	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 
+	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
+	if (!sci)
+		goto drop_nosc;
+
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
 
@@ -1282,6 +1309,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsa_put(rx_sa);
 drop_nosa:
 	macsec_rxsc_put(rx_sc);
+drop_nosc:
 	rcu_read_unlock();
 drop_direct:
 	kfree_skb(skb);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 1b29d1d794a2..79b898311819 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -353,7 +353,8 @@ static int nsim_poll(struct napi_struct *napi, int budget)
 	int done;
 
 	done = nsim_rcv(rq, budget);
-	napi_complete(napi);
+	if (done < budget)
+		napi_complete_done(napi, done);
 
 	return done;
 }
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7e2f10182c0c..591e8fd33d8e 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -889,6 +889,9 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->read)
 		retval = bus->read(bus, addr, regnum);
 	else
@@ -918,6 +921,9 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->write)
 		err = bus->write(bus, addr, regnum, val);
 	else
@@ -979,6 +985,9 @@ int __mdiobus_c45_read(struct mii_bus *bus, int addr, int devad, u32 regnum)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->read_c45)
 		retval = bus->read_c45(bus, addr, devad, regnum);
 	else
@@ -1010,6 +1019,9 @@ int __mdiobus_c45_write(struct mii_bus *bus, int addr, int devad, u32 regnum,
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->write_c45)
 		err = bus->write_c45(bus, addr, devad, regnum, val);
 	else
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 738a8822fcf0..ce49f3ac6939 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -943,7 +943,9 @@ static int vsc85xx_ip1_conf(struct phy_device *phydev, enum ts_blk blk,
 	/* UDP checksum offset in IPv4 packet
 	 * according to: https://tools.ietf.org/html/rfc768
 	 */
-	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26) | IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
+	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26);
+	if (enable)
+		val |= IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
 	vsc85xx_ts_write_csr(phydev, blk, MSCC_ANA_IP1_NXT_PROT_UDP_CHKSUM,
 			     val);
 
@@ -1163,18 +1165,24 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
 
 	if (!vsc8531->ptp->configured)
-		return;
+		goto out;
 
-	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_OFF) {
-		kfree_skb(skb);
-		return;
-	}
+	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_OFF)
+		goto out;
+
+	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		if (ptp_msg_is_sync(skb, type))
+			goto out;
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 	mutex_lock(&vsc8531->ts_lock);
 	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	mutex_unlock(&vsc8531->ts_lock);
+	return;
+
+out:
+	kfree_skb(skb);
 }
 
 static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8af44224480f..13dea33d86ff 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2010,8 +2010,10 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner = NULL;
 	struct mii_bus *bus;
 
-	if (phydev->devlink)
+	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
+		phydev->devlink = NULL;
+	}
 
 	if (phydev->sysfs_links) {
 		if (dev)
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index ff5be2cbf17b..9201ee10a13f 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -30,11 +30,14 @@ static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
 	ret = usbnet_read_cmd_nopm(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR |
 				   USB_RECIP_DEVICE, value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < size)) {
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
 
+		ret = ret < 0 ? ret : -ENODATA;
+	}
+
 	return ret;
 }
 
@@ -46,11 +49,14 @@ static int aqc111_read_cmd(struct usbnet *dev, u8 cmd, u16 value,
 	ret = usbnet_read_cmd(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE, value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < size)) {
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
 
+		ret = ret < 0 ? ret : -ENODATA;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 151d7cdfc480..c48c2de6f961 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1560,6 +1560,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 	return (hlen + (hdr.tcp->doff << 2));
 }
 
+static void
+vmxnet3_lro_tunnel(struct sk_buff *skb, __be16 ip_proto)
+{
+	struct udphdr *uh = NULL;
+
+	if (ip_proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		if (iph->protocol == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	} else {
+		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
+
+		if (iph->nexthdr == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	}
+	if (uh) {
+		if (uh->check)
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+}
+
 static int
 vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 		       struct vmxnet3_adapter *adapter, int quota)
@@ -1873,6 +1897,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			if (segCnt != 0 && mss != 0) {
 				skb_shinfo(skb)->gso_type = rcd->v4 ?
 					SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+				if (encap_lro)
+					vmxnet3_lro_tunnel(skb, skb->protocol);
 				skb_shinfo(skb)->gso_size = mss;
 				skb_shinfo(skb)->gso_segs = segCnt;
 			} else if ((segCnt != 0 || skb->len > mtu) && !encap_lro) {
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 45e9b908dbfb..acb9ce7a626a 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -364,6 +364,7 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
+	dev_set_threaded(dev, true);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 0fe47d51013c..59f7ccb33fde 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -937,7 +937,9 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	dev_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
-	ath10k_snoc_irq_enable(ar);
+	/* IRQs are left enabled when we restart due to a firmware crash */
+	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
+		ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
 
 	clear_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7eba6ee054ff..8002fb32a2cc 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -855,6 +855,7 @@ void ath11k_fw_stats_init(struct ath11k *ar)
 	INIT_LIST_HEAD(&ar->fw_stats.bcn);
 
 	init_completion(&ar->fw_stats_complete);
+	init_completion(&ar->fw_stats_done);
 }
 
 void ath11k_fw_stats_free(struct ath11k_fw_stats *stats)
@@ -1811,6 +1812,20 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 {
 	int ret;
 
+	switch (ath11k_crypto_mode) {
+	case ATH11K_CRYPT_MODE_SW:
+		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	case ATH11K_CRYPT_MODE_HW:
+		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	default:
+		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
+		return -EINVAL;
+	}
+
 	ret = ath11k_core_start_firmware(ab, ab->fw_mode);
 	if (ret) {
 		ath11k_err(ab, "failed to start firmware: %d\n", ret);
@@ -1829,20 +1844,6 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		goto err_firmware_stop;
 	}
 
-	switch (ath11k_crypto_mode) {
-	case ATH11K_CRYPT_MODE_SW:
-		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
-		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-		break;
-	case ATH11K_CRYPT_MODE_HW:
-		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
-		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-		break;
-	default:
-		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
-		return -EINVAL;
-	}
-
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
 		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
 
@@ -1915,6 +1916,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 void ath11k_core_halt(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
+	struct list_head *pos, *n;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -1929,7 +1931,12 @@ void ath11k_core_halt(struct ath11k *ar)
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
-	INIT_LIST_HEAD(&ar->arvifs);
+
+	spin_lock_bh(&ar->data_lock);
+	list_for_each_safe(pos, n, &ar->arvifs)
+		list_del_init(pos);
+	spin_unlock_bh(&ar->data_lock);
+
 	idr_init(&ar->txmgmt_idr);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..fcdec14eb3cf 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -599,6 +599,8 @@ struct ath11k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
+	u32 num_vdev_recvd;
+	u32 num_bcn_recvd;
 };
 
 struct ath11k_dbg_htt_stats {
@@ -780,7 +782,7 @@ struct ath11k {
 	u8 alpha2[REG_ALPHA2_LEN + 1];
 	struct ath11k_fw_stats fw_stats;
 	struct completion fw_stats_complete;
-	bool fw_stats_done;
+	struct completion fw_stats_done;
 
 	/* protected by conf_mutex */
 	bool ps_state_enable;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 57281a135dd7..5d46f8e4c231 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -93,57 +93,14 @@ void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 	spin_unlock_bh(&dbr_data->lock);
 }
 
-static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
-{
-	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats_done = false;
-	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
-	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
-	spin_unlock_bh(&ar->data_lock);
-}
-
 void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *stats)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_pdev *pdev;
-	bool is_end;
-	static unsigned int num_vdev, num_bcn;
-	size_t total_vdevs_started = 0;
-	int i;
-
-	/* WMI_REQUEST_PDEV_STAT request has been already processed */
-
-	if (stats->stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
-		ar->fw_stats_done = true;
-		return;
-	}
-
-	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
-		if (list_empty(&stats->vdevs)) {
-			ath11k_warn(ab, "empty vdev stats");
-			return;
-		}
-		/* FW sends all the active VDEV stats irrespective of PDEV,
-		 * hence limit until the count of all VDEVs started
-		 */
-		for (i = 0; i < ab->num_radios; i++) {
-			pdev = rcu_dereference(ab->pdevs_active[i]);
-			if (pdev && pdev->ar)
-				total_vdevs_started += ar->num_started_vdevs;
-		}
-
-		is_end = ((++num_vdev) == total_vdevs_started);
-
-		list_splice_tail_init(&stats->vdevs,
-				      &ar->fw_stats.vdevs);
-
-		if (is_end) {
-			ar->fw_stats_done = true;
-			num_vdev = 0;
-		}
-		return;
-	}
+	bool is_end = true;
 
+	/* WMI_REQUEST_PDEV_STAT, WMI_REQUEST_RSSI_PER_CHAIN_STAT and
+	 * WMI_REQUEST_VDEV_STAT requests have been already processed.
+	 */
 	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
 		if (list_empty(&stats->bcn)) {
 			ath11k_warn(ab, "empty bcn stats");
@@ -152,97 +109,18 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
+		if (ar->num_started_vdevs)
+			is_end = ((++ar->fw_stats.num_bcn_recvd) ==
+				  ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
 
-		if (is_end) {
-			ar->fw_stats_done = true;
-			num_bcn = 0;
-		}
+		if (is_end)
+			complete(&ar->fw_stats_done);
 	}
 }
 
-static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
-					   struct stats_request_params *req_param)
-{
-	struct ath11k_base *ab = ar->ab;
-	unsigned long timeout, time_left;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + msecs_to_jiffies(3 * 1000);
-
-	ath11k_debugfs_fw_stats_reset(ar);
-
-	reinit_completion(&ar->fw_stats_complete);
-
-	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
-
-	if (ret) {
-		ath11k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
-
-		spin_lock_bh(&ar->data_lock);
-		if (ar->fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
-	}
-	return 0;
-}
-
-int ath11k_debugfs_get_fw_stats(struct ath11k *ar, u32 pdev_id,
-				u32 vdev_id, u32 stats_id)
-{
-	struct ath11k_base *ab = ar->ab;
-	struct stats_request_params req_param;
-	int ret;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
-
-	req_param.pdev_id = pdev_id;
-	req_param.vdev_id = vdev_id;
-	req_param.stats_id = stats_id;
-
-	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
-	if (ret)
-		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
-		   pdev_id, vdev_id, stats_id);
-
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-
-	return ret;
-}
-
 static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 {
 	struct ath11k *ar = inode->i_private;
@@ -268,7 +146,7 @@ static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 	req_param.vdev_id = 0;
 	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
 
-	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
 	if (ret) {
 		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
 		goto err_free;
@@ -339,7 +217,7 @@ static int ath11k_open_vdev_stats(struct inode *inode, struct file *file)
 	req_param.vdev_id = 0;
 	req_param.stats_id = WMI_REQUEST_VDEV_STAT;
 
-	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
 		goto err_free;
@@ -415,7 +293,7 @@ static int ath11k_open_bcn_stats(struct inode *inode, struct file *file)
 			continue;
 
 		req_param.vdev_id = arvif->vdev_id;
-		ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+		ret = ath11k_mac_fw_stats_request(ar, &req_param);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
 			goto err_free;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index a39e458637b0..ed7fec177588 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH11K_DEBUGFS_H_
@@ -273,8 +273,6 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
 void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *stats);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
-int ath11k_debugfs_get_fw_stats(struct ath11k *ar, u32 pdev_id,
-				u32 vdev_id, u32 stats_id);
 
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
@@ -381,12 +379,6 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
-static inline int ath11k_debugfs_get_fw_stats(struct ath11k *ar,
-					      u32 pdev_id, u32 vdev_id, u32 stats_id)
-{
-	return 0;
-}
-
 static inline void
 ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 				enum wmi_direct_buffer_module id,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f8068d2e848c..7ead581f5bfd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8938,6 +8938,86 @@ static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
 	}
 }
 
+static void ath11k_mac_fw_stats_reset(struct ath11k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
+	spin_unlock_bh(&ar->data_lock);
+}
+
+int ath11k_mac_fw_stats_request(struct ath11k *ar,
+				struct stats_request_params *req_param)
+{
+	struct ath11k_base *ab = ar->ab;
+	unsigned long time_left;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ath11k_mac_fw_stats_reset(ar);
+
+	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
+
+	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
+
+	if (ret) {
+		ath11k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
+				   u32 vdev_id, u32 stats_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	req_param.pdev_id = pdev_id;
+	req_param.vdev_id = vdev_id;
+	req_param.stats_id = stats_id;
+
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
+	if (ret)
+		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
@@ -8975,8 +9055,8 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
 	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
 	    ar->ab->hw_params.supports_rssi_stats &&
-	    !ath11k_debugfs_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-					 WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
+	    !ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				     WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
 		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
 	}
 
@@ -8984,8 +9064,8 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	if (!signal &&
 	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
 	    ar->ab->hw_params.supports_rssi_stats &&
-	    !(ath11k_debugfs_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-					WMI_REQUEST_VDEV_STAT)))
+	    !(ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				      WMI_REQUEST_VDEV_STAT)))
 		signal = arsta->rssi_beacon;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
@@ -9331,11 +9411,13 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 
 	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
 
 	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index f5800fbecff8..5e61eea1bb03 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_MAC_H
@@ -179,4 +179,6 @@ int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
 void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_chanctx_conf *ctx);
+int ath11k_mac_fw_stats_request(struct ath11k *ar,
+				struct stats_request_params *req_param);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 87abfa547529..5f7edf622de7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8157,6 +8157,11 @@ static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff
 static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct ath11k_fw_stats stats = {};
+	size_t total_vdevs_started = 0;
+	struct ath11k_pdev *pdev;
+	bool is_end = true;
+	int i;
+
 	struct ath11k *ar;
 	int ret;
 
@@ -8183,18 +8188,50 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 
 	spin_lock_bh(&ar->data_lock);
 
-	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
+	/* WMI_REQUEST_PDEV_STAT, WMI_REQUEST_VDEV_STAT and
+	 * WMI_REQUEST_RSSI_PER_CHAIN_STAT can be requested via mac ops or via
 	 * debugfs fw stats. Therefore, processing it separately.
 	 */
 	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
 		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
-		ar->fw_stats_done = true;
+		complete(&ar->fw_stats_done);
+		goto complete;
+	}
+
+	if (stats.stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
+		complete(&ar->fw_stats_done);
+		goto complete;
+	}
+
+	if (stats.stats_id == WMI_REQUEST_VDEV_STAT) {
+		if (list_empty(&stats.vdevs)) {
+			ath11k_warn(ab, "empty vdev stats");
+			goto complete;
+		}
+		/* FW sends all the active VDEV stats irrespective of PDEV,
+		 * hence limit until the count of all VDEVs started
+		 */
+		for (i = 0; i < ab->num_radios; i++) {
+			pdev = rcu_dereference(ab->pdevs_active[i]);
+			if (pdev && pdev->ar)
+				total_vdevs_started += ar->num_started_vdevs;
+		}
+
+		if (total_vdevs_started)
+			is_end = ((++ar->fw_stats.num_vdev_recvd) ==
+				  total_vdevs_started);
+
+		list_splice_tail_init(&stats.vdevs,
+				      &ar->fw_stats.vdevs);
+
+		if (is_end)
+			complete(&ar->fw_stats_done);
+
 		goto complete;
 	}
 
-	/* WMI_REQUEST_VDEV_STAT, WMI_REQUEST_BCN_STAT and WMI_REQUEST_RSSI_PER_CHAIN_STAT
-	 * are currently requested only via debugfs fw stats. Hence, processing these
-	 * in debugfs context
+	/* WMI_REQUEST_BCN_STAT is currently requested only via debugfs fw stats.
+	 * Hence, processing it in debugfs context
 	 */
 	ath11k_debugfs_fw_stats_process(ar, &stats);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 8bb8ee98188b..c3c76e268062 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1004,6 +1004,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 
 void ath12k_core_halt(struct ath12k *ar)
 {
+	struct list_head *pos, *n;
 	struct ath12k_base *ab = ar->ab;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -1019,7 +1020,12 @@ void ath12k_core_halt(struct ath12k *ar)
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
-	INIT_LIST_HEAD(&ar->arvifs);
+
+	spin_lock_bh(&ar->data_lock);
+	list_for_each_safe(pos, n, &ar->arvifs)
+		list_del_init(pos);
+	spin_unlock_bh(&ar->data_lock);
+
 	idr_init(&ar->txmgmt_idr);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f1b7e74aefe4..6f2e7ecc66af 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1646,6 +1646,9 @@ static ssize_t ath12k_write_htt_stats_type(struct file *file,
 	const int size = 32;
 	int num_args;
 
+	if (count > size)
+		return -EINVAL;
+
 	char *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 4cbba96121a1..1623298ba2c4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -228,12 +228,6 @@ static void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 	ab->hal_rx_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
 }
 
-static u16 ath12k_dp_rxdesc_get_mpdu_frame_ctrl(struct ath12k_base *ab,
-						struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_frame_ctl(desc);
-}
-
 static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
@@ -1768,6 +1762,7 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 	struct hal_rx_desc *ldesc;
 	int space_extra, rem_len, buf_len;
 	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	bool is_continuation;
 
 	/* As the msdu is spread across multiple rx buffers,
 	 * find the offset to the start of msdu for computing
@@ -1816,7 +1811,8 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 	rem_len = msdu_len - buf_first_len;
 	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
 		rxcb = ATH12K_SKB_RXCB(skb);
-		if (rxcb->is_continuation)
+		is_continuation = rxcb->is_continuation;
+		if (is_continuation)
 			buf_len = DP_RX_BUFFER_SIZE - hal_rx_desc_sz;
 		else
 			buf_len = rem_len;
@@ -1834,7 +1830,7 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 		dev_kfree_skb_any(skb);
 
 		rem_len -= buf_len;
-		if (!rxcb->is_continuation)
+		if (!is_continuation)
 			break;
 	}
 
@@ -2067,10 +2063,13 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
 	struct ath12k_base *ab = ar->ab;
 	size_t hdr_len, crypto_len;
-	struct ieee80211_hdr *hdr;
-	u16 qos_ctl;
-	__le16 fc;
-	u8 *crypto_hdr;
+	struct ieee80211_hdr hdr;
+	__le16 qos_ctl;
+	u8 *crypto_hdr, mesh_ctrl;
+
+	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, &hdr);
+	hdr_len = ieee80211_hdrlen(hdr.frame_control);
+	mesh_ctrl = ath12k_dp_rx_h_mesh_ctl_present(ab, rx_desc);
 
 	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
 		crypto_len = ath12k_dp_rx_crypto_param_len(ar, enctype);
@@ -2078,27 +2077,21 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 		ath12k_dp_rx_desc_get_crypto_header(ab, rx_desc, crypto_hdr, enctype);
 	}
 
-	fc = cpu_to_le16(ath12k_dp_rxdesc_get_mpdu_frame_ctrl(ab, rx_desc));
-	hdr_len = ieee80211_hdrlen(fc);
 	skb_push(msdu, hdr_len);
-	hdr = (struct ieee80211_hdr *)msdu->data;
-	hdr->frame_control = fc;
-
-	/* Get wifi header from rx_desc */
-	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, hdr);
+	memcpy(msdu->data, &hdr, min(hdr_len, sizeof(hdr)));
 
 	if (rxcb->is_mcbc)
 		status->flag &= ~RX_FLAG_PN_VALIDATED;
 
 	/* Add QOS header */
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
-		qos_ctl = rxcb->tid;
-		if (ath12k_dp_rx_h_mesh_ctl_present(ab, rx_desc))
-			qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		struct ieee80211_hdr *qos_ptr = (struct ieee80211_hdr *)msdu->data;
 
-		/* TODO: Add other QoS ctl fields when required */
-		memcpy(msdu->data + (hdr_len - IEEE80211_QOS_CTL_LEN),
-		       &qos_ctl, IEEE80211_QOS_CTL_LEN);
+		qos_ctl = cpu_to_le16(rxcb->tid & IEEE80211_QOS_CTL_TID_MASK);
+		if (mesh_ctrl)
+			qos_ctl |= cpu_to_le16(IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT);
+
+		memcpy(ieee80211_get_qos_ctl(qos_ptr), &qos_ctl, IEEE80211_QOS_CTL_LEN);
 	}
 }
 
@@ -3693,6 +3686,15 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
+
+	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE) {
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "invalid msdu len in tkip mic err %u\n", msdu_len);
+		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", desc,
+				sizeof(*desc));
+		return true;
+	}
+
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 201ffdb8c44a..734e3da4cbf1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -566,6 +566,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH:
 		ath12k_dp_tx_free_txbuf(ab, msdu, mac_id, tx_ring);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index ca04bfae8bdc..bfa404997710 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
@@ -511,11 +511,6 @@ static void ath12k_hw_qcn9274_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274.mpdu_start.pn[1]);
 }
 
-static u16 ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274.mpdu_start.frame_ctrl);
-}
-
 static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
@@ -552,9 +547,9 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
 
 	s = &hal->srng_config[HAL_TCL_DATA];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
@@ -566,29 +561,29 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
 	s = &hal->srng_config[HAL_CE_SRC];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
 		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
@@ -736,7 +731,6 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
-	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl,
 	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail,
@@ -975,11 +969,6 @@ ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[1]);
 }
 
-static u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.frame_ctrl);
-}
-
 static bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
@@ -1080,8 +1069,6 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr,
-	.rx_desc_get_mpdu_frame_ctl =
-		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_frame_ctl,
 	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail,
@@ -1330,11 +1317,6 @@ static void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[1]);
 }
 
-static u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.frame_ctrl);
-}
-
 static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
@@ -1371,9 +1353,9 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 
 	s = &hal->srng_config[HAL_TCL_DATA];
 	s->max_rings = 5;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
@@ -1386,31 +1368,31 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 
 	s = &hal->srng_config[HAL_CE_SRC];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
 		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
@@ -1555,7 +1537,6 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_is_da_mcbc = ath12k_hw_wcn7850_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
-	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl,
 	.dp_rx_h_msdu_done = ath12k_hw_wcn7850_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail,
@@ -1756,7 +1737,7 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 			      HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
 	      u32_encode_bits((srng->entry_size * srng->num_entries),
 			      HAL_TCL1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET, val);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(ab), val);
 
 	val = u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
 	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(ab), val);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 8a78bb9a10bc..fb7ec6fce07d 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_H
@@ -44,10 +44,14 @@ struct ath12k_base;
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
-#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG		0x01b80000
-#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG		0x01b81000
-#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG		0x01b82000
-#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG		0x01b83000
+#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce0_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce0_dest_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce1_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce1_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -57,8 +61,10 @@ struct ath12k_base;
 /* SW2TCL(x) R0 ring configuration address */
 #define HAL_TCL1_RING_CMN_CTRL_REG		0x00000020
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
-#define HAL_TCL1_RING_BASE_LSB			0x00000900
-#define HAL_TCL1_RING_BASE_MSB			0x00000904
+#define HAL_TCL1_RING_BASE_LSB(ab) \
+	((ab)->hw_params->regs->hal_tcl1_ring_base_lsb)
+#define HAL_TCL1_RING_BASE_MSB(ab) \
+	((ab)->hw_params->regs->hal_tcl1_ring_base_msb)
 #define HAL_TCL1_RING_ID(ab)			((ab)->hw_params->regs->hal_tcl1_ring_id)
 #define HAL_TCL1_RING_MISC(ab) \
 	((ab)->hw_params->regs->hal_tcl1_ring_misc)
@@ -76,30 +82,31 @@ struct ath12k_base;
 	((ab)->hw_params->regs->hal_tcl1_ring_msi1_base_msb)
 #define HAL_TCL1_RING_MSI1_DATA(ab) \
 	((ab)->hw_params->regs->hal_tcl1_ring_msi1_data)
-#define HAL_TCL2_RING_BASE_LSB			0x00000978
+#define HAL_TCL2_RING_BASE_LSB(ab) \
+	((ab)->hw_params->regs->hal_tcl2_ring_base_lsb)
 #define HAL_TCL_RING_BASE_LSB(ab) \
 	((ab)->hw_params->regs->hal_tcl_ring_base_lsb)
 
-#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab)				\
-	(HAL_TCL1_RING_MSI1_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab)				\
-	(HAL_TCL1_RING_MSI1_BASE_MSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MSI1_DATA_OFFSET(ab)				\
-	(HAL_TCL1_RING_MSI1_DATA(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_BASE_MSB_OFFSET				\
-	(HAL_TCL1_RING_BASE_MSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_ID_OFFSET(ab)				\
-	(HAL_TCL1_RING_ID(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab)			\
-	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab) \
-		(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab) \
-		(HAL_TCL1_RING_TP_ADDR_LSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab) \
-		(HAL_TCL1_RING_TP_ADDR_MSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MISC_OFFSET(ab) \
-		(HAL_TCL1_RING_MISC(ab) - HAL_TCL1_RING_BASE_LSB)
+#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MSI1_BASE_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab)	({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MSI1_BASE_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_MSI1_DATA_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MSI1_DATA(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_BASE_MSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_BASE_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_ID_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_ID(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_TP_ADDR_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_TP_ADDR_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_MISC_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MISC(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
 
 /* SW2TCL(x) R2 ring pointers (head/tail) address */
 #define HAL_TCL1_RING_HP			0x00002000
@@ -1068,7 +1075,6 @@ struct hal_rx_ops {
 	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
 	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
 				      struct ieee80211_hdr *hdr);
-	u16 (*rx_desc_get_mpdu_frame_ctl)(struct hal_rx_desc *desc);
 	void (*rx_desc_get_crypto_header)(struct hal_rx_desc *desc,
 					  u8 *crypto_hdr,
 					  enum hal_encrypt_type enctype);
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 4f745cfd7d8e..c68998e9667c 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include "core.h"
 
@@ -1296,6 +1296,7 @@ enum hal_wbm_htt_tx_comp_status {
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX,
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index ec1bda95e555..e3eb22bb9e1c 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -615,6 +615,9 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -677,6 +680,14 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 
 	/* REO status ring address */
 	.hal_reo_status_ring_base = 0x00000a84,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e38338,
 };
 
 static const struct ath12k_hw_regs qcn9274_v2_regs = {
@@ -691,6 +702,9 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -757,6 +771,14 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 
 	/* REO status ring address */
 	.hal_reo_status_ring_base = 0x00000aa0,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e38338,
 };
 
 static const struct ath12k_hw_regs wcn7850_regs = {
@@ -771,6 +793,9 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -833,6 +858,14 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 
 	/* REO status ring address */
 	.hal_reo_status_ring_base = 0x00000a84,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e40304,
 };
 
 static const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 8d52182e28ae..862b11325a90 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HW_H
@@ -293,6 +293,9 @@ struct ath12k_hw_regs {
 	u32 hal_tcl1_ring_msi1_base_msb;
 	u32 hal_tcl1_ring_msi1_data;
 	u32 hal_tcl_ring_base_lsb;
+	u32 hal_tcl1_ring_base_lsb;
+	u32 hal_tcl1_ring_base_msb;
+	u32 hal_tcl2_ring_base_lsb;
 
 	u32 hal_tcl_status_ring_base_lsb;
 
@@ -316,6 +319,11 @@ struct ath12k_hw_regs {
 	u32 pcie_qserdes_sysclk_en_sel;
 	u32 pcie_pcs_osc_dtct_config_base;
 
+	u32 hal_umac_ce0_src_reg_base;
+	u32 hal_umac_ce0_dest_reg_base;
+	u32 hal_umac_ce1_src_reg_base;
+	u32 hal_umac_ce1_dest_reg_base;
+
 	u32 hal_ppe_rel_ring_base;
 
 	u32 hal_reo2_ring_base;
@@ -347,6 +355,8 @@ struct ath12k_hw_regs {
 	u32 hal_reo_cmd_ring_base;
 
 	u32 hal_reo_status_ring_base;
+
+	u32 gcc_gcc_pcie_hot_rst;
 };
 
 static inline const char *ath12k_bd_ie_type_str(enum ath12k_bd_ie_type type)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 45d537066345..26f4b440c26d 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -290,10 +290,10 @@ static void ath12k_pci_enable_ltssm(struct ath12k_base *ab)
 
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci ltssm 0x%x\n", val);
 
-	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST(ab));
 	val |= GCC_GCC_PCIE_HOT_RST_VAL;
-	ath12k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
-	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	ath12k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST(ab), val);
+	val = ath12k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST(ab));
 
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci pcie_hot_rst 0x%x\n", val);
 
@@ -1514,12 +1514,12 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 err_mhi_unregister:
 	ath12k_mhi_unregister(ab_pci);
 
-err_pci_msi_free:
-	ath12k_pci_msi_free(ab_pci);
-
 err_irq_affinity_cleanup:
 	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
+err_pci_msi_free:
+	ath12k_pci_msi_free(ab_pci);
+
 err_pci_free_region:
 	ath12k_pci_free_region(ab_pci);
 
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 31584a7ad80e..9321674eef8b 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -28,7 +28,9 @@
 #define PCIE_PCIE_PARF_LTSSM			0x1e081b0
 #define PARM_LTSSM_VALUE			0x111
 
-#define GCC_GCC_PCIE_HOT_RST			0x1e38338
+#define GCC_GCC_PCIE_HOT_RST(ab) \
+	((ab)->hw_params->regs->gcc_gcc_pcie_hot_rst)
+
 #define GCC_GCC_PCIE_HOT_RST_VAL		0x10
 
 #define PCIE_PCIE_INT_ALL_CLEAR			0x1e08228
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 30836a09d550..17ac54047f9a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2157,7 +2157,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 
 	for (i = 0; i < arg->peer_eht_mcs_count; i++) {
 		eht_mcs = ptr;
-		eht_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
+		eht_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_EHT_RATE_SET,
 							     sizeof(*eht_mcs));
 
 		eht_mcs->rx_mcs_set = cpu_to_le32(arg->peer_eht_rx_mcs_set[i]);
@@ -4372,6 +4372,7 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 	return 0;
 
 err:
+	kfree(svc_rdy_ext.mac_phy_caps);
 	ath12k_wmi_free_dbring_caps(ab);
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index 547634f82183..81fa7cbad892 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	int slot;
 
+	if (!priv->cur_beacon_conf.enable_beacon)
+		return;
+
 	if (swba->beacon_pending != 0) {
 		priv->beacon.bmisscnt++;
 		if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a8c4e354e2ce..5f8f24580444 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
+ * Copyright(c) 2025 Intel Corporation
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *****************************************************************************/
@@ -2709,6 +2710,7 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 							  optimal_rate);
 		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
 					     &txrc->reported_rate);
+		txrc->reported_rate.count = 1;
 	}
 	spin_unlock_bh(&lq_sta->pers.lock);
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 738bafc3749b..66f0f5377ac1 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -403,14 +403,12 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 
 		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 		    bss_desc->bcn_ht_oper->ht_param &
-		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
-			chan_list->chan_scan_param[0].radio_type |=
-				CHAN_BW_40MHZ << 2;
+		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
 			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
 					  radio_type,
 					  (bss_desc->bcn_ht_oper->ht_param &
 					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
-		}
+
 		*buffer += struct_size(chan_list, chan_scan_param, 1);
 		ret_len += struct_size(chan_list, chan_scan_param, 1);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 2e7604eed27b..a6245c3ccef4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -649,6 +649,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.base = devm_ioremap(dev->mt76.dev,
 					      pci_resource_start(pci_dev, 0),
 					      pci_resource_len(pci_dev, 0));
+		if (!wed->wlan.base)
+			return -ENOMEM;
+
 		wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 		wed->wlan.wpdma_int = pci_resource_start(pci_dev, 0) +
 				      MT_INT_WED_SOURCE_CSR;
@@ -676,6 +679,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.bus_type = MTK_WED_BUS_AXI;
 		wed->wlan.base = devm_ioremap(dev->mt76.dev, res->start,
 					      resource_size(res));
+		if (!wed->wlan.base)
+			return -ENOMEM;
+
 		wed->wlan.phy_base = res->start;
 		wed->wlan.wpdma_int = res->start + MT_INT_SOURCE_CSR;
 		wed->wlan.wpdma_mask = res->start + MT_INT_MASK_CSR;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 2396e1795fe1..a19c108ad4b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -769,7 +769,7 @@ int mt7925_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 	int ret;
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(WSYS_CONFIG),
-					&req, sizeof(req), false, NULL);
+					&req, sizeof(req), true, NULL);
 	return ret;
 }
 
@@ -1411,7 +1411,7 @@ int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
 	};
 
 	return mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(EFUSE_CTRL),
-					 &req, sizeof(req), false, NULL);
+					 &req, sizeof(req), true, NULL);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_eeprom);
 
@@ -2087,8 +2087,6 @@ int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		},
 	};
 
-	mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req), true);
-
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
 				 true);
 }
@@ -2743,7 +2741,7 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 	conf->band = 0; /* unused */
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SET_DBDC_PARMS),
-				    false);
+				    true);
 
 	return err;
 }
@@ -2771,6 +2769,9 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 	int max_len;
 
+	if (test_bit(MT76_HW_SCANNING, &phy->state))
+		return -EBUSY;
+
 	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
 				sizeof(*bssid) + sizeof(*chan_info) +
 				sizeof(*misc) + sizeof(*ie);
@@ -2858,7 +2859,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	}
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
-				    false);
+				    true);
 	if (err < 0)
 		clear_bit(MT76_HW_SCANNING, &phy->state);
 
@@ -2964,7 +2965,7 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 	}
 
 	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
-				     false);
+				     true);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_sched_scan_req);
 
@@ -3000,7 +3001,7 @@ mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
 
 	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
-				     false);
+				     true);
 }
 
 int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
@@ -3039,7 +3040,7 @@ int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
 	}
 
 	return mt76_mcu_send_msg(phy->dev, MCU_UNI_CMD(SCAN_REQ),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_cancel_hw_scan);
 
@@ -3144,7 +3145,7 @@ int mt7925_mcu_set_channel_domain(struct mt76_phy *phy)
 	memcpy(__skb_push(skb, sizeof(req)), &req, sizeof(req));
 
 	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SET_DOMAIN_INFO),
-				     false);
+				     true);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_channel_domain);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 69a7d9b2e38b..4b68d2fc5e09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -493,7 +493,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
 			       MT_RXQ_ID(MT_RXQ_MCU),
 			       MT7996_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE,
+			       MT7996_RX_MCU_BUF_SIZE,
 			       MT_RXQ_RING_BASE(MT_RXQ_MCU));
 	if (ret)
 		return ret;
@@ -502,7 +502,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT_RXQ_ID(MT_RXQ_MCU_WA),
 			       MT7996_RX_MCU_RING_SIZE_WA,
-			       MT_RX_BUF_SIZE,
+			       MT7996_RX_MCU_BUF_SIZE,
 			       MT_RXQ_RING_BASE(MT_RXQ_MCU_WA));
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d8a013812d1e..c55038554114 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1193,6 +1193,9 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454,
 			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 
+	eht_cap_elem->mac_cap_info[1] |=
+		IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK;
+
 	eht_cap_elem->phy_cap_info[0] =
 		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index b6209ed1cfe0..bffee73b780c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -323,6 +323,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	wed->wlan.base = devm_ioremap(dev->mt76.dev,
 				      pci_resource_start(pci_dev, 0),
 				      pci_resource_len(pci_dev, 0));
+	if (!wed->wlan.base)
+		return -ENOMEM;
+
 	wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 
 	if (hif2) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ab8c9070630b..425fd030bee0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -28,6 +28,9 @@
 #define MT7996_RX_RING_SIZE		1536
 #define MT7996_RX_MCU_RING_SIZE		512
 #define MT7996_RX_MCU_RING_SIZE_WA	1024
+/* scatter-gather of mcu event is not supported in connac3 */
+#define MT7996_RX_MCU_BUF_SIZE		(2048 + \
+					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 #define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
 #define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index a99776af56c2..c476e65c4d71 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -309,7 +309,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	u8 para[2] = {0};
+	u8 para[6] = {};
 	u8 times;
 	u16 tbtt_interval = coex_stat->wl_beacon_interval;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 1dbe1cdbc3fd..3157cd834233 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3993,7 +3993,8 @@ static void rtw8822c_dpk_cal_coef1(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, REG_NCTL0, 0x00001148);
 	rtw_write32(rtwdev, REG_NCTL0, 0x00001149);
 
-	check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55);
+	if (!check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55))
+		rtw_warn(rtwdev, "DPK stuck, performance may be suboptimal");
 
 	rtw_write8(rtwdev, 0x1b10, 0x0);
 	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SUBPAGE, 0x0000000c);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 1d62b38526c4..5b8e88c9759d 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -718,10 +718,7 @@ static u8 rtw_sdio_get_tx_qsel(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	case RTW_TX_QUEUE_H2C:
 		return TX_DESC_QSEL_H2C;
 	case RTW_TX_QUEUE_MGMT:
-		if (rtw_chip_wcpu_11n(rtwdev))
-			return TX_DESC_QSEL_HIGH;
-		else
-			return TX_DESC_QSEL_MGMT;
+		return TX_DESC_QSEL_MGMT;
 	case RTW_TX_QUEUE_HI0:
 		return TX_DESC_QSEL_HIGH;
 	default:
@@ -1228,10 +1225,7 @@ static void rtw_sdio_process_tx_queue(struct rtw_dev *rtwdev,
 		return;
 	}
 
-	if (queue <= RTW_TX_QUEUE_VO)
-		rtw_sdio_indicate_tx_status(rtwdev, skb);
-	else
-		dev_kfree_skb_any(skb);
+	rtw_sdio_indicate_tx_status(rtwdev, skb);
 }
 
 static void rtw_sdio_tx_handler(struct work_struct *work)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e5c90050e711..7dbce3b10a7d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5016,7 +5016,7 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
-#define RTW89_SCAN_DELAY_TSF_UNIT 104800
+#define RTW89_SCAN_DELAY_TSF_UNIT 1000000
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
 				 struct rtw89_vif_link *rtwvif_link,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0ac84f968994..e203d3b2a827 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -228,7 +228,7 @@ int rtw89_pci_sync_skb_for_device_and_validate_rx_info(struct rtw89_dev *rtwdev,
 						       struct sk_buff *skb)
 {
 	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
-	int rx_tag_retry = 100;
+	int rx_tag_retry = 1000;
 	int ret;
 
 	do {
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 8755c5e6a65b..c814fbd756a1 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -550,8 +550,8 @@ static int mhi_mbim_newlink(void *ctxt, struct net_device *ndev, u32 if_id,
 	struct mhi_mbim_link *link = wwan_netdev_drvpriv(ndev);
 	struct mhi_mbim_context *mbim = ctxt;
 
-	link->session = if_id;
 	link->mbim = mbim;
+	link->session = mhi_mbim_get_link_mux_id(link->mbim->mdev->mhi_cntrl) + if_id;
 	link->ndev = ndev;
 	u64_stats_init(&link->rx_syncp);
 	u64_stats_init(&link->tx_syncp);
@@ -607,7 +607,7 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 {
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_mbim_context *mbim;
-	int err, link_id;
+	int err;
 
 	mbim = devm_kzalloc(&mhi_dev->dev, sizeof(*mbim), GFP_KERNEL);
 	if (!mbim)
@@ -628,11 +628,8 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 	/* Number of transfer descriptors determines size of the queue */
 	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 
-	/* Get the corresponding mux_id from mhi */
-	link_id = mhi_mbim_get_link_mux_id(cntrl);
-
 	/* Register wwan link ops with MHI controller representing WWAN instance */
-	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, link_id);
+	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, 0);
 }
 
 static void mhi_mbim_remove(struct mhi_device *mhi_dev)
diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 91fa082e9cab..fc0a7cb181df 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -302,7 +302,7 @@ static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id
 	ccmni->ctlb = ctlb;
 	ccmni->dev = dev;
 	atomic_set(&ccmni->usage, 0);
-	ctlb->ccmni_inst[if_id] = ccmni;
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], ccmni);
 
 	ret = register_netdevice(dev);
 	if (ret)
@@ -324,6 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
 	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
 		return;
 
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], NULL);
 	unregister_netdevice(dev);
 }
 
@@ -419,7 +420,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
 
 	skb_cb = T7XX_SKB_CB(skb);
 	netif_id = skb_cb->netif_idx;
-	ccmni = ccmni_ctlb->ccmni_inst[netif_id];
+	ccmni = READ_ONCE(ccmni_ctlb->ccmni_inst[netif_id]);
 	if (!ccmni) {
 		dev_kfree_skb(skb);
 		return;
@@ -441,7 +442,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
 
 static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
 {
-	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
 	struct netdev_queue *net_queue;
 
 	if (netif_running(ccmni->dev) && atomic_read(&ccmni->usage) > 0) {
@@ -453,7 +454,7 @@ static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno
 
 static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
 {
-	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
 	struct netdev_queue *net_queue;
 
 	if (atomic_read(&ccmni->usage) > 0) {
@@ -471,7 +472,7 @@ static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
 	if (ctlb->md_sta != MD_STATE_READY)
 		return;
 
-	if (!ctlb->ccmni_inst[0]) {
+	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
 		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
 		return;
 	}
diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 2b9e6cfaf2a8..1a0058be5821 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -145,7 +145,7 @@ static const char * const nvme_statuses[] = {
 	[NVME_SC_BAD_ATTRIBUTES] = "Conflicting Attributes",
 	[NVME_SC_INVALID_PI] = "Invalid Protection Information",
 	[NVME_SC_READ_ONLY] = "Attempted Write to Read Only Range",
-	[NVME_SC_ONCS_NOT_SUPPORTED] = "ONCS Not Supported",
+	[NVME_SC_CMD_SIZE_LIM_EXCEEDED	] = "Command Size Limits Exceeded",
 	[NVME_SC_ZONE_BOUNDARY_ERROR] = "Zoned Boundary Error",
 	[NVME_SC_ZONE_FULL] = "Zone Is Full",
 	[NVME_SC_ZONE_READ_ONLY] = "Zone Is Read Only",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98dad1bdff44..eca764fede48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -284,7 +284,6 @@ static blk_status_t nvme_error_status(u16 status)
 	case NVME_SC_NS_NOT_READY:
 		return BLK_STS_TARGET;
 	case NVME_SC_BAD_ATTRIBUTES:
-	case NVME_SC_ONCS_NOT_SUPPORTED:
 	case NVME_SC_INVALID_OPCODE:
 	case NVME_SC_INVALID_FIELD:
 	case NVME_SC_INVALID_NS:
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index dc7922f22600..80dd09aa01a3 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -82,8 +82,6 @@ static int nvme_status_to_pr_err(int status)
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
 		return PR_STS_RESERVATION_CONFLICT;
-	case NVME_SC_ONCS_NOT_SUPPORTED:
-		return -EOPNOTSUPP;
 	case NVME_SC_BAD_ATTRIBUTES:
 	case NVME_SC_INVALID_OPCODE:
 	case NVME_SC_INVALID_FIELD:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..4606c8813666 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -62,14 +62,7 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 		return  NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 	case -EOPNOTSUPP:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		switch (req->cmd->common.opcode) {
-		case nvme_cmd_dsm:
-		case nvme_cmd_write_zeroes:
-			return NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
-		default:
-			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
-		}
-		break;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	case -ENODATA:
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
 		return NVME_SC_ACCESS_DENIED;
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index da195d61a966..f1b5ffc00ce8 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -623,12 +623,13 @@ fcloop_fcp_recv_work(struct work_struct *work)
 {
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
-	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	struct nvmefc_fcp_req *fcpreq;
 	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
+	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -643,16 +644,19 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	}
 	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
-	if (unlikely(aborted))
-		ret = -ECANCELED;
-	else {
-		if (likely(!check_for_drop(tfcp_req)))
-			ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
-				&tfcp_req->tgt_fcp_req,
-				fcpreq->cmdaddr, fcpreq->cmdlen);
-		else
-			pr_info("%s: dropped command ********\n", __func__);
+	if (unlikely(aborted)) {
+		/* the abort handler will call fcloop_call_host_done */
+		return;
+	}
+
+	if (unlikely(check_for_drop(tfcp_req))) {
+		pr_info("%s: dropped command ********\n", __func__);
+		return;
 	}
+
+	ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
+				   &tfcp_req->tgt_fcp_req,
+				   fcpreq->cmdaddr, fcpreq->cmdlen);
 	if (ret)
 		fcloop_call_host_done(fcpreq, tfcp_req, ret);
 }
@@ -667,9 +671,10 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
-	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
+		fcpreq = tfcp_req->fcpreq;
+		tfcp_req->fcpreq = NULL;
 		break;
 	case INI_IO_COMPLETED:
 		completed = true;
@@ -691,10 +696,6 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irqsave(&tfcp_req->reqlock, flags);
-	tfcp_req->fcpreq = NULL;
-	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
-
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index eaf31c823cbe..73ecbc13c5b2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -145,15 +145,8 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
 		break;
 	case BLK_STS_NOTSUPP:
+		status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		switch (req->cmd->common.opcode) {
-		case nvme_cmd_dsm:
-		case nvme_cmd_write_zeroes:
-			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
-			break;
-		default:
-			status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
-		}
 		break;
 	case BLK_STS_MEDIUM:
 		status = NVME_SC_ACCESS_DENIED;
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 8682adaacd69..7da717d6c7fa 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -213,6 +213,7 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	econfig.word_size = 1;
 	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
+	econfig.priv = dev;
 	econfig.add_legacy_fixed_of_cells = true;
 	econfig.reg_read = zynqmp_nvmem_read;
 	econfig.reg_write = zynqmp_nvmem_write;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 576e9beefc7c..9a72f75e5c2d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1916,15 +1916,16 @@ static int __init unittest_data_add(void)
 	rc = of_resolve_phandles(unittest_data_node);
 	if (rc) {
 		pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
-		of_overlay_mutex_unlock();
-		return -EINVAL;
+		rc = -EINVAL;
+		goto unlock;
 	}
 
 	/* attach the sub-tree to live tree */
 	if (!of_root) {
 		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
 		kfree(unittest_data);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto unlock;
 	}
 
 	EXPECT_BEGIN(KERN_INFO,
@@ -1943,9 +1944,10 @@ static int __init unittest_data_add(void)
 	EXPECT_END(KERN_INFO,
 		   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
+unlock:
 	of_overlay_mutex_unlock();
 
-	return 0;
+	return rc;
 }
 
 #ifdef CONFIG_OF_OVERLAY
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..741e10a575ec 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -570,14 +570,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (!bridge->ops)
 		bridge->ops = &cdns_pcie_host_ops;
 
-	ret = pci_host_probe(bridge);
-	if (ret < 0)
-		goto err_init;
-
-	return 0;
-
- err_init:
-	pm_runtime_put_sync(dev);
-
-	return ret;
+	return pci_host_probe(bridge);
 }
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 3a5511c3f7d9..5d77a0164860 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -403,6 +403,7 @@ static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_1M,
 };
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index fefab2758a06..ddc65368e77d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -541,7 +541,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
 
 	/* Assert PERST# before setting up the clock */
-	gpiod_set_value(reset, 1);
+	gpiod_set_value_cansleep(reset, 1);
 
 	ret = apple_pcie_setup_refclk(pcie, port);
 	if (ret < 0)
@@ -552,7 +552,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 
 	/* Deassert PERST# */
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
-	gpiod_set_value(reset, 0);
+	gpiod_set_value_cansleep(reset, 0);
 
 	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 	msleep(100);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 50bc2892a36c..963d2f3aa5d4 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -236,12 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
+	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
 			  epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
+	epf_bar[bar].aligned_size = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -264,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -281,12 +282,18 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			return NULL;
 		}
 		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
 	}
 
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	/*
+	 * Allocate enough memory to accommodate the iATU alignment
+	 * requirement.  In most cases, this will be the same as .size but
+	 * it might be different if, for example, the fixed size of a BAR
+	 * is smaller than align.
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -297,7 +304,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -306,6 +313,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
+	epf_bar[bar].aligned_size = aligned_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..b78e0e417324 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1676,24 +1676,19 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 
 	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops) {
-		kfree(ri);
-		return NULL;
-	}
+	if (!root_ops)
+		goto free_ri;
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
+	if (!ri->cfg)
+		goto free_root_ops;
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		return NULL;
+		goto free_cfg;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1710,6 +1705,14 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
+
+free_cfg:
+	pci_ecam_free(ri->cfg);
+free_root_ops:
+	kfree(root_ops);
+free_ri:
+	kfree(ri);
+	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25c07af1686b..7ca5422feb2d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4945,7 +4945,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		delay);
 	if (!pcie_wait_for_link_delay(dev, true, delay)) {
 		/* Did not train, no need to wait any further */
-		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
 		return -ENOTTY;
 	}
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b6ef7efa3c1..cdc54315d879 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -260,40 +260,48 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 void dpc_process_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
-	struct aer_err_info info;
+	struct aer_err_info info = {};
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
-
-	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
 
 	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
-	ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
-	pci_warn(pdev, "%s detected\n",
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR) ?
-		 "unmasked uncorrectable error" :
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE) ?
-		 "ERR_NONFATAL" :
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
-		 "ERR_FATAL" :
-		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
-		 "RP PIO error" :
-		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
-		 "software trigger" :
-		 "reserved error");
-
-	/* show RP PIO error detail information */
-	if (pdev->dpc_rp_extensions &&
-	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
-	    ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO)
-		dpc_process_rp_pio_error(pdev);
-	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
-		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		 aer_get_device_error_info(pdev, &info)) {
-		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+
+	switch (reason) {
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR:
+		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
+			 status);
+		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
+		    aer_get_device_error_info(pdev, &info)) {
+			aer_print_error(pdev, &info);
+			pci_aer_clear_nonfatal_status(pdev);
+			pci_aer_clear_fatal_status(pdev);
+		}
+		break;
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
+				     &source);
+		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
+			 status,
+			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
+				"ERR_FATAL" : "ERR_NONFATAL",
+			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
+			 PCI_SLOT(source), PCI_FUNC(source));
+		break;
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
+		ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
+		pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
+			 status,
+			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
+			 "RP PIO error" :
+			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
+			 "software trigger" :
+			 "reserved error");
+		/* show RP PIO error detail information */
+		if (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO &&
+		    pdev->dpc_rp_extensions)
+			dpc_process_rp_pio_error(pdev);
+		break;
 	}
 }
 
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index 07446d784a1a..c1e755c356a3 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -511,7 +511,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 
 	fmt_attr_fill(pmu->info.hw_info->fmt_attr);
 
-	pmu->cpu = smp_processor_id();
+	pmu->cpu = raw_smp_processor_id();
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME);
 	if (!name)
diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 90fcfe693439..b87d3a9ba7d5 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -576,6 +576,23 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 	return err;
 }
 
+static void arm_ni_remove(struct platform_device *pdev)
+{
+	struct arm_ni *ni = platform_get_drvdata(pdev);
+
+	for (int i = 0; i < ni->num_cds; i++) {
+		struct arm_ni_cd *cd = ni->cds + i;
+
+		if (!cd->pmu_base)
+			continue;
+
+		writel_relaxed(0, cd->pmu_base + NI_PMCR);
+		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
+		perf_pmu_unregister(&cd->pmu);
+		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
+	}
+}
+
 static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
 {
 	u32 reg = readl_relaxed(base + NI_NODE_TYPE);
@@ -644,6 +661,7 @@ static int arm_ni_probe(struct platform_device *pdev)
 	ni->num_cds = num_cds;
 	ni->part = part;
 	ni->id = atomic_fetch_inc(&id);
+	platform_set_drvdata(pdev, ni);
 
 	for (int v = 0; v < cfg.num_components; v++) {
 		reg = readl_relaxed(cfg.base + NI_CHILD_PTR(v));
@@ -657,8 +675,11 @@ static int arm_ni_probe(struct platform_device *pdev)
 				reg = readl_relaxed(pd.base + NI_CHILD_PTR(c));
 				arm_ni_probe_domain(base + reg, &cd);
 				ret = arm_ni_init_cd(ni, &cd, res->start);
-				if (ret)
+				if (ret) {
+					ni->cds[cd.id].pmu_base = NULL;
+					arm_ni_remove(pdev);
 					return ret;
+				}
 			}
 		}
 	}
@@ -666,23 +687,6 @@ static int arm_ni_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void arm_ni_remove(struct platform_device *pdev)
-{
-	struct arm_ni *ni = platform_get_drvdata(pdev);
-
-	for (int i = 0; i < ni->num_cds; i++) {
-		struct arm_ni_cd *cd = ni->cds + i;
-
-		if (!cd->pmu_base)
-			continue;
-
-		writel_relaxed(0, cd->pmu_base + NI_PMCR);
-		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
-		perf_pmu_unregister(&cd->pmu);
-		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
-	}
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id arm_ni_of_match[] = {
 	{ .compatible = "arm,ni-700" },
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 8e2cd2c178d6..c12efd127a61 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2044,12 +2044,16 @@ static void __iomem *qmp_usb_iomap(struct device *dev, struct device_node *np,
 					int index, bool exclusive)
 {
 	struct resource res;
+	void __iomem *mem;
 
 	if (!exclusive) {
 		if (of_address_to_resource(np, index, &res))
 			return IOMEM_ERR_PTR(-EINVAL);
 
-		return devm_ioremap(dev, res.start, resource_size(&res));
+		mem = devm_ioremap(dev, res.start, resource_size(&res));
+		if (!mem)
+			return IOMEM_ERR_PTR(-ENOMEM);
+		return mem;
 	}
 
 	return devm_of_iomap(dev, np, index, NULL);
diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 9b99fdd43f5f..5547f8df8e71 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -192,6 +192,7 @@
 #define LN3_TX_SER_RATE_SEL_HBR2	BIT(3)
 #define LN3_TX_SER_RATE_SEL_HBR3	BIT(2)
 
+#define HDMI14_MAX_RATE			340000000
 #define HDMI20_MAX_RATE			600000000
 
 struct lcpll_config {
@@ -780,9 +781,7 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
-	int i;
-
-	hdptx->rate = rate * 100;
+	int ret, i;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
 		if (rate == ropll_tmds_cfg[i].bit_rate) {
@@ -841,7 +840,11 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN,
 			   PLL_PCG_CLK_EN);
 
-	return rk_hdptx_post_enable_pll(hdptx);
+	ret = rk_hdptx_post_enable_pll(hdptx);
+	if (!ret)
+		hdptx->rate = rate * 100;
+
+	return ret;
 }
 
 static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
@@ -851,7 +854,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (rate >= 3400000) {
+	if (rate > HDMI14_MAX_RATE / 100) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
 	} else {
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 93ab277d9943..fbe74e4ef320 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1819,12 +1819,16 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	struct at91_gpio_chip *at91_chip = NULL;
 	struct gpio_chip *chip;
 	struct pinctrl_gpio_range *range;
+	int alias_idx;
 	int ret = 0;
 	int irq, i;
-	int alias_idx = of_alias_get_id(np, "gpio");
 	uint32_t ngpio;
 	char **names;
 
+	alias_idx = of_alias_get_id(np, "gpio");
+	if (alias_idx < 0)
+		return alias_idx;
+
 	BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
 	if (gpio_chips[alias_idx])
 		return dev_err_probe(dev, -EBUSY, "%d slot is occupied.\n", alias_idx);
diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
index f5c1c427b44e..61b7c22e963c 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -165,6 +165,10 @@ static const struct pinctrl_pin_desc qcm2290_pins[] = {
 	PINCTRL_PIN(62, "GPIO_62"),
 	PINCTRL_PIN(63, "GPIO_63"),
 	PINCTRL_PIN(64, "GPIO_64"),
+	PINCTRL_PIN(65, "GPIO_65"),
+	PINCTRL_PIN(66, "GPIO_66"),
+	PINCTRL_PIN(67, "GPIO_67"),
+	PINCTRL_PIN(68, "GPIO_68"),
 	PINCTRL_PIN(69, "GPIO_69"),
 	PINCTRL_PIN(70, "GPIO_70"),
 	PINCTRL_PIN(71, "GPIO_71"),
@@ -179,12 +183,17 @@ static const struct pinctrl_pin_desc qcm2290_pins[] = {
 	PINCTRL_PIN(80, "GPIO_80"),
 	PINCTRL_PIN(81, "GPIO_81"),
 	PINCTRL_PIN(82, "GPIO_82"),
+	PINCTRL_PIN(83, "GPIO_83"),
+	PINCTRL_PIN(84, "GPIO_84"),
+	PINCTRL_PIN(85, "GPIO_85"),
 	PINCTRL_PIN(86, "GPIO_86"),
 	PINCTRL_PIN(87, "GPIO_87"),
 	PINCTRL_PIN(88, "GPIO_88"),
 	PINCTRL_PIN(89, "GPIO_89"),
 	PINCTRL_PIN(90, "GPIO_90"),
 	PINCTRL_PIN(91, "GPIO_91"),
+	PINCTRL_PIN(92, "GPIO_92"),
+	PINCTRL_PIN(93, "GPIO_93"),
 	PINCTRL_PIN(94, "GPIO_94"),
 	PINCTRL_PIN(95, "GPIO_95"),
 	PINCTRL_PIN(96, "GPIO_96"),
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 23b4bc1e5da8..a2ac1702d0df 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -809,8 +809,8 @@ static const struct samsung_pin_ctrl exynosautov920_pin_ctrl[] = {
 		.pin_banks	= exynosautov920_pin_banks0,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks0),
 		.eint_wkup_init	= exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 		.retention_data	= &exynosautov920_retention_data,
 	}, {
 		/* pin-controller instance 1 AUD data */
@@ -821,43 +821,43 @@ static const struct samsung_pin_ctrl exynosautov920_pin_ctrl[] = {
 		.pin_banks	= exynosautov920_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks2),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 3 HSI1 data */
 		.pin_banks	= exynosautov920_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks3),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 4 HSI2 data */
 		.pin_banks	= exynosautov920_pin_banks4,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks4),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 5 HSI2UFS data */
 		.pin_banks	= exynosautov920_pin_banks5,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks5),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 6 PERIC0 data */
 		.pin_banks	= exynosautov920_pin_banks6,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks6),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	}, {
 		/* pin-controller instance 7 PERIC1 data */
 		.pin_banks	= exynosautov920_pin_banks7,
 		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks7),
 		.eint_gpio_init	= exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= exynosautov920_pinctrl_suspend,
+		.resume		= exynosautov920_pinctrl_resume,
 	},
 };
 
@@ -1024,15 +1024,15 @@ static const struct samsung_pin_ctrl gs101_pin_ctrl[] __initconst = {
 		.pin_banks	= gs101_pin_alive,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_alive),
 		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (FAR_ALIVE) */
 		.pin_banks	= gs101_pin_far_alive,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_far_alive),
 		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (GSACORE) */
 		.pin_banks	= gs101_pin_gsacore,
@@ -1046,29 +1046,29 @@ static const struct samsung_pin_ctrl gs101_pin_ctrl[] __initconst = {
 		.pin_banks	= gs101_pin_peric0,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_peric0),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (PERIC1) */
 		.pin_banks	= gs101_pin_peric1,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_peric1),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume	= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (HSI1) */
 		.pin_banks	= gs101_pin_hsi1,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_hsi1),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	}, {
 		/* pin banks of gs101 pin-controller (HSI2) */
 		.pin_banks	= gs101_pin_hsi2,
 		.nr_banks	= ARRAY_SIZE(gs101_pin_hsi2),
 		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
+		.suspend	= gs101_pinctrl_suspend,
+		.resume		= gs101_pinctrl_resume,
 	},
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index ac6dc22b37c9..7887fd416651 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -761,153 +761,187 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	return 0;
 }
 
-static void exynos_pinctrl_suspend_bank(
-				struct samsung_pinctrl_drv_data *drvdata,
-				struct samsung_pin_bank *bank)
+static void exynos_set_wakeup(struct samsung_pin_bank *bank)
 {
-	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	const void __iomem *regs = bank->eint_base;
+	struct exynos_irq_chip *irq_chip;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for saving state\n");
-		return;
+	if (bank->irq_chip) {
+		irq_chip = bank->irq_chip;
+		irq_chip->set_eint_wakeup_mask(bank->drvdata, irq_chip);
 	}
-
-	save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
-						+ bank->eint_offset);
-	save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset);
-	save->eint_fltcon1 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset + 4);
-	save->eint_mask = readl(regs + bank->irq_chip->eint_mask
-						+ bank->eint_offset);
-
-	clk_disable(bank->drvdata->pclk);
-
-	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
-	pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltcon0);
-	pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
-	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
 
-static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drvdata,
-					    struct samsung_pin_bank *bank)
+void exynos_pinctrl_suspend(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	const void __iomem *regs = bank->eint_base;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for saving state\n");
-		return;
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
+				       + bank->eint_offset);
+		save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+					   + 2 * bank->eint_offset);
+		save->eint_fltcon1 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+					   + 2 * bank->eint_offset + 4);
+		save->eint_mask = readl(regs + bank->irq_chip->eint_mask
+					+ bank->eint_offset);
+
+		pr_debug("%s: save     con %#010x\n",
+			 bank->name, save->eint_con);
+		pr_debug("%s: save fltcon0 %#010x\n",
+			 bank->name, save->eint_fltcon0);
+		pr_debug("%s: save fltcon1 %#010x\n",
+			 bank->name, save->eint_fltcon1);
+		pr_debug("%s: save    mask %#010x\n",
+			 bank->name, save->eint_mask);
+	} else if (bank->eint_type == EINT_TYPE_WKUP) {
+		exynos_set_wakeup(bank);
 	}
-
-	save->eint_con = readl(regs + bank->pctl_offset + bank->eint_con_offset);
-	save->eint_mask = readl(regs + bank->pctl_offset + bank->eint_mask_offset);
-
-	clk_disable(bank->drvdata->pclk);
-
-	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
-	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
 
-void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
+void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
 {
-	struct samsung_pin_bank *bank = drvdata->pin_banks;
-	struct exynos_irq_chip *irq_chip = NULL;
-	int i;
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	const void __iomem *regs = bank->eint_base;
 
-	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
-		if (bank->eint_type == EINT_TYPE_GPIO) {
-			if (bank->eint_con_offset)
-				exynosauto_pinctrl_suspend_bank(drvdata, bank);
-			else
-				exynos_pinctrl_suspend_bank(drvdata, bank);
-		}
-		else if (bank->eint_type == EINT_TYPE_WKUP) {
-			if (!irq_chip) {
-				irq_chip = bank->irq_chip;
-				irq_chip->set_eint_wakeup_mask(drvdata,
-							       irq_chip);
-			}
-		}
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
+				       + bank->eint_offset);
+
+		save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+					   + bank->eint_fltcon_offset);
+
+		/* fltcon1 register only exists for pins 4-7 */
+		if (bank->nr_pins > 4)
+			save->eint_fltcon1 = readl(regs +
+						EXYNOS_GPIO_EFLTCON_OFFSET
+						+ bank->eint_fltcon_offset + 4);
+
+		save->eint_mask = readl(regs + bank->irq_chip->eint_mask
+					+ bank->eint_offset);
+
+		pr_debug("%s: save     con %#010x\n",
+			 bank->name, save->eint_con);
+		pr_debug("%s: save fltcon0 %#010x\n",
+			 bank->name, save->eint_fltcon0);
+		if (bank->nr_pins > 4)
+			pr_debug("%s: save fltcon1 %#010x\n",
+				 bank->name, save->eint_fltcon1);
+		pr_debug("%s: save    mask %#010x\n",
+			 bank->name, save->eint_mask);
+	} else if (bank->eint_type == EINT_TYPE_WKUP) {
+		exynos_set_wakeup(bank);
 	}
 }
 
-static void exynos_pinctrl_resume_bank(
-				struct samsung_pinctrl_drv_data *drvdata,
-				struct samsung_pin_bank *bank)
+void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
-	void __iomem *regs = bank->eint_base;
+	const void __iomem *regs = bank->eint_base;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for restoring state\n");
-		return;
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		save->eint_con = readl(regs + bank->pctl_offset +
+				       bank->eint_con_offset);
+		save->eint_mask = readl(regs + bank->pctl_offset +
+					bank->eint_mask_offset);
+		pr_debug("%s: save     con %#010x\n",
+			 bank->name, save->eint_con);
+		pr_debug("%s: save    mask %#010x\n",
+			 bank->name, save->eint_mask);
+	} else if (bank->eint_type == EINT_TYPE_WKUP) {
+		exynos_set_wakeup(bank);
 	}
+}
 
-	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
-			readl(regs + EXYNOS_GPIO_ECON_OFFSET
-			+ bank->eint_offset), save->eint_con);
-	pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
-			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-			+ 2 * bank->eint_offset), save->eint_fltcon0);
-	pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
-			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
-			+ 2 * bank->eint_offset + 4), save->eint_fltcon1);
-	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
-			readl(regs + bank->irq_chip->eint_mask
-			+ bank->eint_offset), save->eint_mask);
-
-	writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
-						+ bank->eint_offset);
-	writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset);
-	writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
-						+ 2 * bank->eint_offset + 4);
-	writel(save->eint_mask, regs + bank->irq_chip->eint_mask
-						+ bank->eint_offset);
+void gs101_pinctrl_resume(struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
 
-	clk_disable(bank->drvdata->pclk);
+	void __iomem *regs = bank->eint_base;
+	void __iomem *eint_fltcfg0 = regs + EXYNOS_GPIO_EFLTCON_OFFSET
+		     + bank->eint_fltcon_offset;
+
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_ECON_OFFSET
+			       + bank->eint_offset), save->eint_con);
+
+		pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
+			 readl(eint_fltcfg0), save->eint_fltcon0);
+
+		/* fltcon1 register only exists for pins 4-7 */
+		if (bank->nr_pins > 4)
+			pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
+				 readl(eint_fltcfg0 + 4), save->eint_fltcon1);
+
+		pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->irq_chip->eint_mask
+			       + bank->eint_offset), save->eint_mask);
+
+		writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
+		       + bank->eint_offset);
+		writel(save->eint_fltcon0, eint_fltcfg0);
+
+		if (bank->nr_pins > 4)
+			writel(save->eint_fltcon1, eint_fltcfg0 + 4);
+		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
+		       + bank->eint_offset);
+	}
 }
 
-static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
-					   struct samsung_pin_bank *bank)
+void exynos_pinctrl_resume(struct samsung_pin_bank *bank)
 {
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	void __iomem *regs = bank->eint_base;
 
-	if (clk_enable(bank->drvdata->pclk)) {
-		dev_err(bank->gpio_chip.parent,
-			"unable to enable clock for restoring state\n");
-		return;
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_ECON_OFFSET
+			       + bank->eint_offset), save->eint_con);
+		pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+			       + 2 * bank->eint_offset), save->eint_fltcon0);
+		pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
+			 readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
+			       + 2 * bank->eint_offset + 4),
+			 save->eint_fltcon1);
+		pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->irq_chip->eint_mask
+			       + bank->eint_offset), save->eint_mask);
+
+		writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
+		       + bank->eint_offset);
+		writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
+		       + 2 * bank->eint_offset);
+		writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
+		       + 2 * bank->eint_offset + 4);
+		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
+		       + bank->eint_offset);
 	}
-
-	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
-		 readl(regs + bank->pctl_offset + bank->eint_con_offset), save->eint_con);
-	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
-		 readl(regs + bank->pctl_offset + bank->eint_mask_offset), save->eint_mask);
-
-	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
-	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
-
-	clk_disable(bank->drvdata->pclk);
 }
 
-void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
+void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank)
 {
-	struct samsung_pin_bank *bank = drvdata->pin_banks;
-	int i;
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = bank->eint_base;
 
-	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
-		if (bank->eint_type == EINT_TYPE_GPIO) {
-			if (bank->eint_con_offset)
-				exynosauto_pinctrl_resume_bank(drvdata, bank);
-			else
-				exynos_pinctrl_resume_bank(drvdata, bank);
-		}
+	if (bank->eint_type == EINT_TYPE_GPIO) {
+		/* exynosautov920 has eint_con_offset for all but one bank */
+		if (!bank->eint_con_offset)
+			exynos_pinctrl_resume(bank);
+
+		pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->pctl_offset + bank->eint_con_offset),
+			 save->eint_con);
+		pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			 readl(regs + bank->pctl_offset +
+			       bank->eint_mask_offset), save->eint_mask);
+
+		writel(save->eint_con,
+		       regs + bank->pctl_offset + bank->eint_con_offset);
+		writel(save->eint_mask,
+		       regs + bank->pctl_offset + bank->eint_mask_offset);
+	}
 }
 
 static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 97a43fa4dfc5..c70b8ead56b4 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -211,8 +211,12 @@ struct exynos_muxed_weint_data {
 
 int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d);
 int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d);
-void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata);
-void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata);
+void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank);
+void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank);
+void exynos_pinctrl_suspend(struct samsung_pin_bank *bank);
+void exynos_pinctrl_resume(struct samsung_pin_bank *bank);
+void gs101_pinctrl_suspend(struct samsung_pin_bank *bank);
+void gs101_pinctrl_resume(struct samsung_pin_bank *bank);
 struct samsung_retention_ctrl *
 exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 		      const struct samsung_retention_data *data);
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 63ac89a802d3..210534586c0c 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1333,6 +1333,7 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 {
 	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
+	struct samsung_pin_bank *bank;
 	int i;
 
 	i = clk_enable(drvdata->pclk);
@@ -1343,7 +1344,7 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 	}
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
-		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
+		bank = &drvdata->pin_banks[i];
 		const void __iomem *reg = bank->pctl_base + bank->pctl_offset;
 		const u8 *offs = bank->type->reg_offset;
 		const u8 *widths = bank->type->fld_width;
@@ -1371,10 +1372,14 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 		}
 	}
 
+	for (i = 0; i < drvdata->nr_banks; i++) {
+		bank = &drvdata->pin_banks[i];
+		if (drvdata->suspend)
+			drvdata->suspend(bank);
+	}
+
 	clk_disable(drvdata->pclk);
 
-	if (drvdata->suspend)
-		drvdata->suspend(drvdata);
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
 		drvdata->retention_ctrl->enable(drvdata);
 
@@ -1392,6 +1397,7 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 {
 	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
+	struct samsung_pin_bank *bank;
 	int ret;
 	int i;
 
@@ -1406,11 +1412,14 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 		return ret;
 	}
 
-	if (drvdata->resume)
-		drvdata->resume(drvdata);
+	for (i = 0; i < drvdata->nr_banks; i++) {
+		bank = &drvdata->pin_banks[i];
+		if (drvdata->resume)
+			drvdata->resume(bank);
+	}
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
-		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
+		bank = &drvdata->pin_banks[i];
 		void __iomem *reg = bank->pctl_base + bank->pctl_offset;
 		const u8 *offs = bank->type->reg_offset;
 		const u8 *widths = bank->type->fld_width;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 14c3b6b96585..7ffd2e193e42 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -285,8 +285,8 @@ struct samsung_pin_ctrl {
 	int		(*eint_gpio_init)(struct samsung_pinctrl_drv_data *);
 	int		(*eint_wkup_init)(struct samsung_pinctrl_drv_data *);
 	void		(*pud_value_init)(struct samsung_pinctrl_drv_data *drvdata);
-	void		(*suspend)(struct samsung_pinctrl_drv_data *);
-	void		(*resume)(struct samsung_pinctrl_drv_data *);
+	void		(*suspend)(struct samsung_pin_bank *bank);
+	void		(*resume)(struct samsung_pin_bank *bank);
 };
 
 /**
@@ -335,8 +335,8 @@ struct samsung_pinctrl_drv_data {
 
 	struct samsung_retention_ctrl	*retention_ctrl;
 
-	void (*suspend)(struct samsung_pinctrl_drv_data *);
-	void (*resume)(struct samsung_pinctrl_drv_data *);
+	void (*suspend)(struct samsung_pin_bank *bank);
+	void (*resume)(struct samsung_pin_bank *bank);
 };
 
 /**
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 05913e9fe082..8b1f894f5e79 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -697,6 +697,37 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
 
+/**
+ * dev_pm_genpd_rpm_always_on() - Control if the PM domain can be powered off.
+ *
+ * @dev: Device for which the PM domain may need to stay on for.
+ * @on: Value to set or unset for the condition.
+ *
+ * For some usecases a consumer driver requires its device to remain power-on
+ * from the PM domain perspective during runtime. This function allows the
+ * behaviour to be dynamically controlled for a device attached to a genpd.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Return: Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	genpd_lock(genpd);
+	dev_gpd_data(dev)->rpm_always_on = on;
+	genpd_unlock(genpd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -868,6 +899,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 		if (!pm_runtime_suspended(pdd->dev) ||
 			irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
+
+		/* The device may need its PM domain to stay powered on. */
+		if (to_gpd_data(pdd)->rpm_always_on)
+			return -EBUSY;
 	}
 
 	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 16512654295f..f1e0a0857a90 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -129,12 +129,11 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 		"	str	%4, [%0, %6]\n\t"
 		/* Disable SDRAM1 accesses */
 		"1:	tst	%1, #0\n\t"
-		"	beq	2f\n\t"
 		"	strne	%3, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
 		/* Power down SDRAM1 */
 		"	strne	%4, [%1, %6]\n\t"
 		/* Reset CPU */
-		"2:	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
+		"	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
 
 		"	b	.\n\t"
 		:
@@ -145,7 +144,7 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
 		  "r" (reset->data->reset_args),
 		  "r" (reset->ramc_lpr)
-		: "r4");
+	);
 
 	return NOTIFY_DONE;
 }
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469e..528d86a33f37 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -98,17 +98,7 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	bool in_use = false;
-
-	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
-		return true;
-
-	if (!ptp->is_virtual_clock && ptp->n_vclocks)
-		in_use = true;
-
-	mutex_unlock(&ptp->n_vclocks_mux);
-
-	return in_use;
+	return !ptp->is_virtual_clock;
 }
 
 /* Check if ptp clock shall be free running */
diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index 198d45f8e884..3d333b61fb18 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2022 Laurent Pinchart <laurent.pinchart@idesonboard.com>
 // Copyright (C) 2018 Avnet, Inc.
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -133,11 +134,11 @@ static int max20086_regulators_register(struct max20086 *chip)
 static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 {
 	struct of_regulator_match *matches;
-	struct device_node *node;
 	unsigned int i;
 	int ret;
 
-	node = of_get_child_by_name(chip->dev->of_node, "regulators");
+	struct device_node *node __free(device_node) =
+		of_get_child_by_name(chip->dev->of_node, "regulators");
 	if (!node) {
 		dev_err(chip->dev, "regulators node not found\n");
 		return -ENODEV;
@@ -153,7 +154,6 @@ static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 
 	ret = of_regulator_match(chip->dev, node, matches,
 				 chip->info->num_outputs);
-	of_node_put(node);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to match regulators\n");
 		return -EINVAL;
diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index dd36fd077911..1e197f773474 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -197,6 +197,7 @@ struct qcom_iris *qcom_iris_probe(struct device *parent, bool *use_48mhz_xo)
 
 err_device_del:
 	device_del(&iris->dev);
+	put_device(&iris->dev);
 
 	return ERR_PTR(ret);
 }
@@ -204,4 +205,5 @@ struct qcom_iris *qcom_iris_probe(struct device *parent, bool *use_48mhz_xo)
 void qcom_iris_remove(struct qcom_iris *iris)
 {
 	device_del(&iris->dev);
+	put_device(&iris->dev);
 }
diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 8be3f631c192..2ae0655ddf1d 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -115,10 +115,6 @@ static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
 	const char *name = kproc->rproc->name;
 	u32 msg = omap_mbox_message(data);
 
-	/* Do not forward messages from a detached core */
-	if (kproc->rproc->state == RPROC_DETACHED)
-		return;
-
 	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
 
 	switch (msg) {
@@ -159,10 +155,6 @@ static void k3_dsp_rproc_kick(struct rproc *rproc, int vqid)
 	mbox_msg_t msg = (mbox_msg_t)vqid;
 	int ret;
 
-	/* Do not forward messages to a detached core */
-	if (kproc->rproc->state == RPROC_DETACHED)
-		return;
-
 	/* send the index of the triggered virtqueue in the mailbox payload */
 	ret = mbox_send_message(kproc->mbox, (void *)msg);
 	if (ret < 0)
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 747ee467da88..4894461aa65f 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -194,10 +194,6 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
 	const char *name = kproc->rproc->name;
 	u32 msg = omap_mbox_message(data);
 
-	/* Do not forward message from a detached core */
-	if (kproc->rproc->state == RPROC_DETACHED)
-		return;
-
 	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
 
 	switch (msg) {
@@ -233,10 +229,6 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
 	mbox_msg_t msg = (mbox_msg_t)vqid;
 	int ret;
 
-	/* Do not forward message to a detached core */
-	if (kproc->rproc->state == RPROC_DETACHED)
-		return;
-
 	/* send the index of the triggered virtqueue in the mailbox payload */
 	ret = mbox_send_message(kproc->mbox, (void *)msg);
 	if (ret < 0)
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 43f601c84b4f..79d35ab43729 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -746,7 +746,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 	__le32 hdr[5] = { cpu_to_le32(len), };
 	int tlen = sizeof(hdr) + len;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	/* Word aligned channels only accept word size aligned data */
 	if (channel->info_word && len % 4)
diff --git a/drivers/rtc/rtc-loongson.c b/drivers/rtc/rtc-loongson.c
index 90e9d97a86b4..c9d5b91a6544 100644
--- a/drivers/rtc/rtc-loongson.c
+++ b/drivers/rtc/rtc-loongson.c
@@ -129,6 +129,14 @@ static u32 loongson_rtc_handler(void *id)
 {
 	struct loongson_rtc_priv *priv = (struct loongson_rtc_priv *)id;
 
+	rtc_update_irq(priv->rtcdev, 1, RTC_AF | RTC_IRQF);
+
+	/*
+	 * The TOY_MATCH0_REG should be cleared 0 here,
+	 * otherwise the interrupt cannot be cleared.
+	 */
+	regmap_write(priv->regmap, TOY_MATCH0_REG, 0);
+
 	spin_lock(&priv->lock);
 	/* Disable RTC alarm wakeup and interrupt */
 	writel(readl(priv->pm_base + PM1_EN_REG) & ~RTC_EN,
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 27a191fa3704..e66c9c6fd372 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -485,9 +485,15 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	rtc->periodic_irq = ret;
-	rtc->carry_irq = platform_get_irq(pdev, 1);
-	rtc->alarm_irq = platform_get_irq(pdev, 2);
+	if (!pdev->dev.of_node) {
+		rtc->periodic_irq = ret;
+		rtc->carry_irq = platform_get_irq(pdev, 1);
+		rtc->alarm_irq = platform_get_irq(pdev, 2);
+	} else {
+		rtc->alarm_irq = ret;
+		rtc->periodic_irq = platform_get_irq(pdev, 1);
+		rtc->carry_irq = platform_get_irq(pdev, 2);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index e98e6b2b9f57..d9500b730690 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1850,33 +1850,14 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 	}
 	hisi_sas_dereg_device(hisi_hba, device);
 
-	rc = hisi_sas_debug_I_T_nexus_reset(device);
-	if (rc == TMF_RESP_FUNC_COMPLETE && dev_is_sata(device)) {
-		struct sas_phy *local_phy;
-
+	if (dev_is_sata(device)) {
 		rc = hisi_sas_softreset_ata_disk(device);
-		switch (rc) {
-		case -ECOMM:
-			rc = -ENODEV;
-			break;
-		case TMF_RESP_FUNC_FAILED:
-		case -EMSGSIZE:
-		case -EIO:
-			local_phy = sas_get_local_phy(device);
-			rc = sas_phy_enable(local_phy, 0);
-			if (!rc) {
-				local_phy->enabled = 0;
-				dev_err(dev, "Disabled local phy of ATA disk %016llx due to softreset fail (%d)\n",
-					SAS_ADDR(device->sas_addr), rc);
-				rc = -ENODEV;
-			}
-			sas_put_local_phy(local_phy);
-			break;
-		default:
-			break;
-		}
+		if (rc == TMF_RESP_FUNC_FAILED)
+			dev_err(dev, "ata disk %016llx reset (%d)\n",
+				SAS_ADDR(device->sas_addr), rc);
 	}
 
+	rc = hisi_sas_debug_I_T_nexus_reset(device);
 	if ((rc == TMF_RESP_FUNC_COMPLETE) || (rc == -ENODEV))
 		hisi_sas_release_task(hisi_hba, device);
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index e979ec1478c1..e895bd25098f 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -699,7 +699,7 @@ static u32 qedf_get_login_failures(void *cookie)
 }
 
 static struct qed_fcoe_cb_ops qedf_cb_ops = {
-	{
+	.common = {
 		.link_update = qedf_link_update,
 		.bw_update = qedf_bw_update,
 		.schedule_recovery_handler = qedf_schedule_recovery_handler,
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 8274fe0ec714..7a5bebf5b096 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3526,7 +3526,7 @@ static int iscsi_new_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.new_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_new_fnode;
 	}
 
 	index = transport->new_flashnode(shost, data, len);
@@ -3536,7 +3536,6 @@ static int iscsi_new_flashnode(struct iscsi_transport *transport,
 	else
 		err = -EIO;
 
-put_host:
 	scsi_host_put(shost);
 
 exit_new_fnode:
@@ -3561,7 +3560,7 @@ static int iscsi_del_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.del_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_del_fnode;
 	}
 
 	idx = ev->u.del_flashnode.flashnode_idx;
@@ -3603,7 +3602,7 @@ static int iscsi_login_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.login_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_login_fnode;
 	}
 
 	idx = ev->u.login_flashnode.flashnode_idx;
@@ -3655,7 +3654,7 @@ static int iscsi_logout_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.logout_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_logout_fnode;
 	}
 
 	idx = ev->u.logout_flashnode.flashnode_idx;
@@ -3705,7 +3704,7 @@ static int iscsi_logout_flashnode_sid(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.logout_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_logout_sid;
 	}
 
 	session = iscsi_session_lookup(ev->u.logout_flashnode_sid.sid);
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index d919a74746a0..8cc9f924a8ae 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5990,7 +5990,7 @@ static bool pqi_is_parity_write_stream(struct pqi_ctrl_info *ctrl_info,
 			pqi_stream_data->next_lba = rmd.first_block +
 				rmd.block_cnt;
 			pqi_stream_data->last_accessed = jiffies;
-			per_cpu_ptr(device->raid_io_stats, smp_processor_id())->write_stream_cnt++;
+				per_cpu_ptr(device->raid_io_stats, raw_smp_processor_id())->write_stream_cnt++;
 			return true;
 		}
 
@@ -6069,7 +6069,7 @@ static int pqi_scsi_queue_command(struct Scsi_Host *shost, struct scsi_cmnd *scm
 			rc = pqi_raid_bypass_submit_scsi_cmd(ctrl_info, device, scmd, queue_group);
 			if (rc == 0 || rc == SCSI_MLQUEUE_HOST_BUSY) {
 				raid_bypassed = true;
-				per_cpu_ptr(device->raid_io_stats, smp_processor_id())->raid_bypass_cnt++;
+				per_cpu_ptr(device->raid_io_stats, raw_smp_processor_id())->raid_bypass_cnt++;
 			}
 		}
 		if (!raid_bypassed)
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 888b5840c015..d2e63277f0aa 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -166,7 +166,7 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
+	if (lpc_snoop->irq < 0)
 		return -ENODEV;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
@@ -200,11 +200,15 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name) {
+		rc = -ENOMEM;
+		goto err_free_fifo;
+	}
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
 	if (rc)
-		return rc;
+		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
 	switch (channel) {
@@ -221,7 +225,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		hicrb_en = HICRB_ENSNP1D;
 		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_misc_deregister;
 	}
 
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -231,6 +236,12 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		regmap_update_bits(lpc_snoop->regmap, HICRB,
 				hicrb_en, hicrb_en);
 
+	return 0;
+
+err_misc_deregister:
+	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+err_free_fifo:
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 	return rc;
 }
 
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index cefcbd61c628..95d8a8f728db 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -578,7 +578,7 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 	smp2p->mbox_client.knows_txdone = true;
 	smp2p->mbox_chan = mbox_request_channel(&smp2p->mbox_client, 0);
 	if (IS_ERR(smp2p->mbox_chan)) {
-		if (PTR_ERR(smp2p->mbox_chan) != -ENODEV)
+		if (PTR_ERR(smp2p->mbox_chan) != -ENOENT)
 			return PTR_ERR(smp2p->mbox_chan);
 
 		smp2p->mbox_chan = NULL;
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 1ca857c2a4aa..8df12efeea21 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -745,7 +745,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	reset = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index ef3a7226db12..a95badb7b711 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -523,7 +523,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	reset = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 532b2e9c31d0..4c5f12b76de6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi {
 	size_t			max_xfer_len;
 	u32			ref_clk_hz;
 	bool			use_multi_mode;
+	bool			last_msg_kept_cs;
 };
 
 struct omap2_mcspi_cs {
@@ -1269,6 +1270,10 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	 * multi-mode is applicable.
 	 */
 	mcspi->use_multi_mode = true;
+
+	if (mcspi->last_msg_kept_cs)
+		mcspi->use_multi_mode = false;
+
 	list_for_each_entry(tr, &msg->transfers, transfer_list) {
 		if (!tr->bits_per_word)
 			bits_per_word = msg->spi->bits_per_word;
@@ -1287,18 +1292,19 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 			mcspi->use_multi_mode = false;
 		}
 
-		/* Check if transfer asks to change the CS status after the transfer */
-		if (!tr->cs_change)
-			mcspi->use_multi_mode = false;
-
-		/*
-		 * If at least one message is not compatible, switch back to single mode
-		 *
-		 * The bits_per_word of certain transfer can be different, but it will have no
-		 * impact on the signal itself.
-		 */
-		if (!mcspi->use_multi_mode)
-			break;
+		if (list_is_last(&tr->transfer_list, &msg->transfers)) {
+			/* Check if transfer asks to keep the CS status after the whole message */
+			if (tr->cs_change) {
+				mcspi->use_multi_mode = false;
+				mcspi->last_msg_kept_cs = true;
+			} else {
+				mcspi->last_msg_kept_cs = false;
+			}
+		} else {
+			/* Check if transfer asks to change the CS status after the transfer */
+			if (!tr->cs_change)
+				mcspi->use_multi_mode = false;
+		}
 	}
 
 	omap2_mcspi_set_mode(ctlr);
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 3519656515ea..1870f8c85213 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -918,6 +918,7 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	void *rx_buf = t->rx_buf;
 	unsigned int len = t->len;
 	unsigned int bits = t->bits_per_word;
+	unsigned int max_wdlen = 256;
 	unsigned int bytes_per_word;
 	unsigned int words;
 	int n;
@@ -931,17 +932,17 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	if (!spi_controller_is_target(p->ctlr))
 		sh_msiof_spi_set_clk_regs(p, t);
 
+	if (tx_buf)
+		max_wdlen = min(max_wdlen, p->tx_fifo_size);
+	if (rx_buf)
+		max_wdlen = min(max_wdlen, p->rx_fifo_size);
+
 	while (ctlr->dma_tx && len > 15) {
 		/*
 		 *  DMA supports 32-bit words only, hence pack 8-bit and 16-bit
 		 *  words, with byte resp. word swapping.
 		 */
-		unsigned int l = 0;
-
-		if (tx_buf)
-			l = min(round_down(len, 4), p->tx_fifo_size * 4);
-		if (rx_buf)
-			l = min(round_down(len, 4), p->rx_fifo_size * 4);
+		unsigned int l = min(round_down(len, 4), max_wdlen * 4);
 
 		if (bits <= 8) {
 			copy32 = copy_bswap32;
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2d48ad844fb8..92348ebc60c7 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -134,7 +134,7 @@
 #define QSPI_COMMAND_VALUE_SET(X)		(((x) & 0xFF) << 0)
 
 #define QSPI_CMB_SEQ_CMD_CFG			0x1a0
-#define QSPI_COMMAND_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_COMMAND_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_COMMAND_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_COMMAND_SDR_DDR			BIT(12)
 #define QSPI_COMMAND_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -147,7 +147,7 @@
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
 
 #define QSPI_CMB_SEQ_ADDR_CFG			0x1ac
-#define QSPI_ADDRESS_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_ADDRESS_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_ADDRESS_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_ADDRESS_SDR_DDR			BIT(12)
 #define QSPI_ADDRESS_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -1036,10 +1036,6 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 addr_config = 0;
 
-	/* Extract Address configuration and value */
-	is_ddr = 0; //Only SDR mode supported
-	bus_width = 0; //X1 mode
-
 	if (is_ddr)
 		addr_config |= QSPI_ADDRESS_SDR_DDR;
 	else
@@ -1079,13 +1075,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 		switch (transfer_phase) {
 		case CMD_TRANSFER:
 			/* X1 SDR mode */
-			cmd_config = tegra_qspi_cmd_config(false, 0,
+			cmd_config = tegra_qspi_cmd_config(false, xfer->tx_nbits,
 							   xfer->len);
 			cmd_value = *((const u8 *)(xfer->tx_buf));
 			break;
 		case ADDR_TRANSFER:
 			/* X1 SDR mode */
-			addr_config = tegra_qspi_addr_config(false, 0,
+			addr_config = tegra_qspi_addr_config(false, xfer->tx_nbits,
 							     xfer->len);
 			address_value = *((const u32 *)(xfer->tx_buf));
 			break;
@@ -1163,26 +1159,22 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				ret = -EIO;
 				goto exit;
 			}
-			if (!xfer->cs_change) {
-				tegra_qspi_transfer_end(spi);
-				spi_transfer_delay_exec(xfer);
-			}
 			break;
 		default:
 			ret = -EINVAL;
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
+		if (!xfer->cs_change && transfer_phase == DATA_TRANSFER) {
+			tegra_qspi_transfer_end(spi);
+			spi_transfer_delay_exec(xfer);
+		}
 		transfer_phase++;
 	}
 	ret = 0;
 
 exit:
 	msg->status = ret;
-	if (ret < 0) {
-		tegra_qspi_transfer_end(spi);
-		spi_transfer_delay_exec(xfer);
-	}
 
 	return ret;
 }
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index ac398b5a9736..a1d941b0be00 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -213,8 +213,14 @@ static int rkvdec_enum_framesizes(struct file *file, void *priv,
 	if (!fmt)
 		return -EINVAL;
 
-	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
-	fsize->stepwise = fmt->frmsize;
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width = 1;
+	fsize->stepwise.max_width = fmt->frmsize.max_width;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.min_height = 1;
+	fsize->stepwise.max_height = fmt->frmsize.max_height;
+	fsize->stepwise.step_height = 1;
+
 	return 0;
 }
 
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 3295b27ab70d..ae063d1bc95f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -209,6 +209,13 @@ static const struct debugfs_reg32 lvts_regs[] = {
 	LVTS_DEBUG_FS_REGS(LVTS_CLKEN),
 };
 
+static void lvts_debugfs_exit(void *data)
+{
+	struct lvts_domain *lvts_td = data;
+
+	debugfs_remove_recursive(lvts_td->dom_dentry);
+}
+
 static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 {
 	struct debugfs_regset32 *regset;
@@ -241,12 +248,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 		debugfs_create_regset32("registers", 0400, dentry, regset);
 	}
 
-	return 0;
-}
-
-static void lvts_debugfs_exit(struct lvts_domain *lvts_td)
-{
-	debugfs_remove_recursive(lvts_td->dom_dentry);
+	return devm_add_action_or_reset(dev, lvts_debugfs_exit, lvts_td);
 }
 
 #else
@@ -257,8 +259,6 @@ static inline int lvts_debugfs_init(struct device *dev,
 	return 0;
 }
 
-static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
-
 #endif
 
 static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
@@ -1352,8 +1352,6 @@ static void lvts_remove(struct platform_device *pdev)
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
-
-	lvts_debugfs_exit(lvts_td);
 }
 
 static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 402fdf8b1cde..57821b6f4e46 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -440,10 +440,10 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 			bool configured = val & PORT_CS_19_PC;
 			usb4 = port->usb4;
 
-			if (((flags & TB_WAKE_ON_CONNECT) |
+			if (((flags & TB_WAKE_ON_CONNECT) &&
 			      device_may_wakeup(&usb4->dev)) && !configured)
 				val |= PORT_CS_19_WOC;
-			if (((flags & TB_WAKE_ON_DISCONNECT) |
+			if (((flags & TB_WAKE_ON_DISCONNECT) &&
 			      device_may_wakeup(&usb4->dev)) && configured)
 				val |= PORT_CS_19_WOD;
 			if ((flags & TB_WAKE_ON_USB4) && configured)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0dd68bdbfbcf..4f57991944dc 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1168,16 +1168,6 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 	}
 
-	sg_init_table(&sg, 1);
-	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
-					   UART_XMIT_SIZE, dma->tx_addr);
-	if (ret != 1) {
-		serial8250_clear_THRI(p);
-		return 0;
-	}
-
-	dma->tx_size = sg_dma_len(&sg);
-
 	if (priv->habit & OMAP_DMA_TX_KICK) {
 		unsigned char c;
 		u8 tx_lvl;
@@ -1202,18 +1192,22 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 			ret = -EBUSY;
 			goto err;
 		}
-		if (dma->tx_size < 4) {
+		if (kfifo_len(&tport->xmit_fifo) < 4) {
 			ret = -EINVAL;
 			goto err;
 		}
-		if (!kfifo_get(&tport->xmit_fifo, &c)) {
+		if (!uart_fifo_out(&p->port, &c, 1)) {
 			ret = -EINVAL;
 			goto err;
 		}
 		skip_byte = c;
-		/* now we need to recompute due to kfifo_get */
-		kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
-				UART_XMIT_SIZE, dma->tx_addr);
+	}
+
+	sg_init_table(&sg, 1);
+	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1, UART_XMIT_SIZE, dma->tx_addr);
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto err;
 	}
 
 	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
@@ -1223,6 +1217,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
+	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
 
 	desc->callback = omap_8250_dma_tx_complete;
diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index fb082ee73d5b..9b54f017f2e8 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -523,7 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	}
 	port->membase = devm_ioremap(&pdev->dev, res->start,
 				resource_size(res));
-
+	if (!port->membase) {
+		ret = -ENOMEM;
+		goto failed;
+	}
 	ret = platform_get_irq_byname(pdev, "rx");
 	mlb_usio_irq[index][RX] = ret;
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 76cf177b040e..aacbed76c7c5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3074,10 +3074,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3104,11 +3100,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3278,8 +3269,6 @@ static void sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3444,6 +3433,11 @@ static int sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
+	sciport->port.dev = &dev->dev;
+	ret = devm_pm_runtime_enable(&dev->dev);
+	if (ret)
+		return ret;
+
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
@@ -3457,13 +3451,7 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
-	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
-	}
-
-	return 0;
+	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
 static int sci_probe(struct platform_device *dev)
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 4b91072f3a4e..1f2bdd2e1cc5 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1103,8 +1103,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	case VT_WAITACTIVE:
 	case VT_RELDISP:
 	case VT_DISALLOCATE:
-	case VT_RESIZE:
-	case VT_RESIZEX:
 		return vt_ioctl(tty, cmd, arg);
 
 	/*
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 45b04f3c3776..420e943bb73a 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -670,7 +670,6 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct ufs_hw_queue *hwq;
-	unsigned long flags;
 	int err;
 
 	/* Skip task abort in case previous aborts failed and report failure */
@@ -709,10 +708,5 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 		return FAILED;
 	}
 
-	spin_lock_irqsave(&hwq->cq_lock, flags);
-	if (ufshcd_cmd_inflight(lrbp->cmd))
-		ufshcd_release_scsi_cmd(hba, lrbp);
-	spin_unlock_irqrestore(&hwq->cq_lock, flags);
-
 	return SUCCESS;
 }
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 247e425428c8..374f505fec3d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6577,9 +6577,14 @@ static void ufshcd_err_handler(struct work_struct *work)
 		up(&hba->host_sem);
 		return;
 	}
-	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	ufshcd_err_handling_prepare(hba);
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	ufshcd_set_eh_in_progress(hba);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	/* Complete requests that have door-bell cleared by h/w */
 	ufshcd_complete_requests(hba, false);
 	spin_lock_irqsave(hba->host->host_lock, flags);
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 4557b1bcd635..a715f377d0a8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -366,10 +366,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count) {
+	if (phy->power_count)
 		phy_power_off(phy);
-		phy_exit(phy);
-	}
+
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 79d06958d619..38e693cd3efc 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -28,7 +28,8 @@
 unsigned int cdnsp_port_speed(unsigned int port_status)
 {
 	/*Detect gadget speed based on PORTSC register*/
-	if (DEV_SUPERSPEEDPLUS(port_status))
+	if (DEV_SUPERSPEEDPLUS(port_status) ||
+	    DEV_SSP_GEN1x2(port_status) || DEV_SSP_GEN2x2(port_status))
 		return USB_SPEED_SUPER_PLUS;
 	else if (DEV_SUPERSPEED(port_status))
 		return USB_SPEED_SUPER;
@@ -546,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 	dma_addr_t cmd_deq_dma;
 	union cdnsp_trb *event;
 	u32 cycle_state;
+	u32 retry = 10;
 	int ret, val;
 	u64 cmd_dma;
 	u32  flags;
@@ -577,8 +579,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 		flags = le32_to_cpu(event->event_cmd.flags);
 
 		/* Check the owner of the TRB. */
-		if ((flags & TRB_CYCLE) != cycle_state)
+		if ((flags & TRB_CYCLE) != cycle_state) {
+			/*
+			 * Give some extra time to get chance controller
+			 * to finish command before returning error code.
+			 * Checking CMD_RING_BUSY is not sufficient because
+			 * this bit is cleared to '0' when the Command
+			 * Descriptor has been executed by controller
+			 * and not when command completion event has
+			 * be added to event ring.
+			 */
+			if (retry--) {
+				udelay(20);
+				continue;
+			}
+
 			return -EINVAL;
+		}
 
 		cmd_dma = le64_to_cpu(event->event_cmd.cmd_trb);
 
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 12534be52f39..2afa3e558f85 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -285,11 +285,15 @@ struct cdnsp_port_regs {
 #define XDEV_HS			(0x3 << 10)
 #define XDEV_SS			(0x4 << 10)
 #define XDEV_SSP		(0x5 << 10)
+#define XDEV_SSP1x2		(0x6 << 10)
+#define XDEV_SSP2x2		(0x7 << 10)
 #define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0 << 10))
 #define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
 #define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
 #define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
 #define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SSP_GEN1x2(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP1x2)
+#define DEV_SSP_GEN2x2(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP2x2)
 #define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
 #define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
 /* Port Link State Write Strobe - set this when changing link state */
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 66f3d9324ba2..75de29725a45 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -565,14 +565,15 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 
 	rv = usbtmc_get_stb(file_data, &stb);
 
-	if (rv > 0) {
-		srq_asserted = atomic_xchg(&file_data->srq_asserted,
-					srq_asserted);
-		if (srq_asserted)
-			stb |= 0x40; /* Set RQS bit */
+	if (rv < 0)
+		return rv;
+
+	srq_asserted = atomic_xchg(&file_data->srq_asserted, srq_asserted);
+	if (srq_asserted)
+		stb |= 0x40; /* Set RQS bit */
+
+	rv = put_user(stb, (__u8 __user *)arg);
 
-		rv = put_user(stb, (__u8 __user *)arg);
-	}
 	return rv;
 
 }
@@ -2201,7 +2202,7 @@ static long usbtmc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case USBTMC_IOCTL_GET_STB:
 		retval = usbtmc_get_stb(file_data, &tmp_byte);
-		if (retval > 0)
+		if (!retval)
 			retval = put_user(tmp_byte, (__u8 __user *)arg);
 		break;
 
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 145787c424e0..da3d0e525b64 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6135,6 +6135,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
 	struct usb_device_descriptor	descriptor;
+	struct usb_interface		*intf;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -6192,6 +6193,18 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	if (!udev->actconfig)
 		goto done;
 
+	/*
+	 * Some devices can't handle setting default altsetting 0 with a
+	 * Set-Interface request. Disable host-side endpoints of those
+	 * interfaces here. Enable and reset them back after host has set
+	 * its internal endpoint structures during usb_hcd_alloc_bandwith()
+	 */
+	for (i = 0; i < udev->actconfig->desc.bNumInterfaces; i++) {
+		intf = udev->actconfig->interface[i];
+		if (intf->cur_altsetting->desc.bAlternateSetting == 0)
+			usb_disable_interface(udev, intf, true);
+	}
+
 	mutex_lock(hcd->bandwidth_mutex);
 	ret = usb_hcd_alloc_bandwidth(udev, udev->actconfig, NULL, NULL);
 	if (ret < 0) {
@@ -6223,12 +6236,11 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	 */
 	for (i = 0; i < udev->actconfig->desc.bNumInterfaces; i++) {
 		struct usb_host_config *config = udev->actconfig;
-		struct usb_interface *intf = config->interface[i];
 		struct usb_interface_descriptor *desc;
 
+		intf = config->interface[i];
 		desc = &intf->cur_altsetting->desc;
 		if (desc->bAlternateSetting == 0) {
-			usb_disable_interface(udev, intf, true);
 			usb_enable_interface(udev, intf, true);
 			ret = 0;
 		} else {
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 03c22114214b..494e21a11cd2 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -165,6 +165,8 @@ static int usb_acpi_add_usb4_devlink(struct usb_device *udev)
 		return 0;
 
 	hub = usb_hub_to_struct_hub(udev->parent);
+	if (!hub)
+		return 0;
 	port_dev = hub->ports[udev->portnum - 1];
 
 	struct fwnode_handle *nhi_fwnode __free(fwnode_handle) =
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 740311c4fa24..c7a05f842745 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -144,8 +144,8 @@ static struct hid_descriptor hidg_desc = {
 	.bcdHID				= cpu_to_le16(0x0101),
 	.bCountryCode			= 0x00,
 	.bNumDescriptors		= 0x1,
-	/*.desc[0].bDescriptorType	= DYNAMIC */
-	/*.desc[0].wDescriptorLenght	= DYNAMIC */
+	/*.rpt_desc.bDescriptorType	= DYNAMIC */
+	/*.rpt_desc.wDescriptorLength	= DYNAMIC */
 };
 
 /* Super-Speed Support */
@@ -939,8 +939,8 @@ static int hidg_setup(struct usb_function *f,
 			struct hid_descriptor hidg_desc_copy = hidg_desc;
 
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
-			hidg_desc_copy.desc[0].bDescriptorType = HID_DT_REPORT;
-			hidg_desc_copy.desc[0].wDescriptorLength =
+			hidg_desc_copy.rpt_desc.bDescriptorType = HID_DT_REPORT;
+			hidg_desc_copy.rpt_desc.wDescriptorLength =
 				cpu_to_le16(hidg->report_desc_length);
 
 			length = min_t(unsigned short, length,
@@ -1210,8 +1210,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	 * We can use hidg_desc struct here but we should not relay
 	 * that its content won't change after returning from this function.
 	 */
-	hidg_desc.desc[0].bDescriptorType = HID_DT_REPORT;
-	hidg_desc.desc[0].wDescriptorLength =
+	hidg_desc.rpt_desc.bDescriptorType = HID_DT_REPORT;
+	hidg_desc.rpt_desc.wDescriptorLength =
 		cpu_to_le16(hidg->report_desc_length);
 
 	hidg_hs_in_ep_desc.bEndpointAddress =
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 4b3d5075621a..d709e24c1fd4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1570,7 +1570,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
 {
 	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
 	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = container_of(drv,
+	const struct usb_gadget_driver *driver = container_of(drv,
 			struct usb_gadget_driver, driver);
 
 	/* If the driver specifies a udc_name, it must match the UDC's name */
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index b4d5408a4371..cf716ae870b8 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -36,9 +36,10 @@
 #define USB5744_CMD_CREG_ACCESS			0x99
 #define USB5744_CMD_CREG_ACCESS_LSB		0x37
 #define USB5744_CREG_MEM_ADDR			0x00
+#define USB5744_CREG_MEM_RD_ADDR		0x04
 #define USB5744_CREG_WRITE			0x00
-#define USB5744_CREG_RUNTIMEFLAGS2		0x41
-#define USB5744_CREG_RUNTIMEFLAGS2_LSB		0x1D
+#define USB5744_CREG_READ			0x01
+#define USB5744_CREG_RUNTIMEFLAGS2		0x411D
 #define USB5744_CREG_BYPASS_UDC_SUSPEND		BIT(3)
 
 static void onboard_dev_attach_usb_driver(struct work_struct *work);
@@ -309,11 +310,88 @@ static void onboard_dev_attach_usb_driver(struct work_struct *work)
 		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
 }
 
+#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV_USB5744)
+static int onboard_dev_5744_i2c_read_byte(struct i2c_client *client, u16 addr, u8 *data)
+{
+	struct i2c_msg msg[2];
+	u8 rd_buf[3];
+	int ret;
+
+	u8 wr_buf[7] = {0, USB5744_CREG_MEM_ADDR, 4,
+			USB5744_CREG_READ, 1,
+			addr >> 8 & 0xff,
+			addr & 0xff};
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = sizeof(wr_buf);
+	msg[0].buf = wr_buf;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret < 0)
+		return ret;
+
+	wr_buf[0] = USB5744_CMD_CREG_ACCESS;
+	wr_buf[1] = USB5744_CMD_CREG_ACCESS_LSB;
+	wr_buf[2] = 0;
+	msg[0].len = 3;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret < 0)
+		return ret;
+
+	wr_buf[0] = 0;
+	wr_buf[1] = USB5744_CREG_MEM_RD_ADDR;
+	msg[0].len = 2;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = 2;
+	msg[1].buf = rd_buf;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+	*data = rd_buf[1];
+
+	return 0;
+}
+
+static int onboard_dev_5744_i2c_write_byte(struct i2c_client *client, u16 addr, u8 data)
+{
+	struct i2c_msg msg[2];
+	int ret;
+
+	u8 wr_buf[8] = {0, USB5744_CREG_MEM_ADDR, 5,
+			USB5744_CREG_WRITE, 1,
+			addr >> 8 & 0xff,
+			addr & 0xff,
+			data};
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = sizeof(wr_buf);
+	msg[0].buf = wr_buf;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret < 0)
+		return ret;
+
+	msg[0].len = 3;
+	wr_buf[0] = USB5744_CMD_CREG_ACCESS;
+	wr_buf[1] = USB5744_CMD_CREG_ACCESS_LSB;
+	wr_buf[2] = 0;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int onboard_dev_5744_i2c_init(struct i2c_client *client)
 {
-#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV_USB5744)
 	struct device *dev = &client->dev;
 	int ret;
+	u8 reg;
 
 	/*
 	 * Set BYPASS_UDC_SUSPEND bit to ensure MCU is always enabled
@@ -321,20 +399,16 @@ static int onboard_dev_5744_i2c_init(struct i2c_client *client)
 	 * The command writes 5 bytes to memory and single data byte in
 	 * configuration register.
 	 */
-	char wr_buf[7] = {USB5744_CREG_MEM_ADDR, 5,
-			  USB5744_CREG_WRITE, 1,
-			  USB5744_CREG_RUNTIMEFLAGS2,
-			  USB5744_CREG_RUNTIMEFLAGS2_LSB,
-			  USB5744_CREG_BYPASS_UDC_SUSPEND};
-
-	ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
+	ret = onboard_dev_5744_i2c_read_byte(client,
+					     USB5744_CREG_RUNTIMEFLAGS2, &reg);
 	if (ret)
-		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
+		return dev_err_probe(dev, ret, "CREG_RUNTIMEFLAGS2 read failed\n");
 
-	ret = i2c_smbus_write_word_data(client, USB5744_CMD_CREG_ACCESS,
-					USB5744_CMD_CREG_ACCESS_LSB);
+	reg |= USB5744_CREG_BYPASS_UDC_SUSPEND;
+	ret = onboard_dev_5744_i2c_write_byte(client,
+					      USB5744_CREG_RUNTIMEFLAGS2, reg);
 	if (ret)
-		return dev_err_probe(dev, ret, "Configuration Register Access Command failed\n");
+		return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
 
 	/* Send SMBus command to boot hub. */
 	ret = i2c_smbus_write_word_data(client, USB5744_CMD_ATTACH,
@@ -343,10 +417,13 @@ static int onboard_dev_5744_i2c_init(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "USB Attach with SMBus command failed\n");
 
 	return ret;
+}
 #else
+static int onboard_dev_5744_i2c_init(struct i2c_client *client)
+{
 	return -ENODEV;
-#endif
 }
+#endif
 
 static int onboard_dev_probe(struct platform_device *pdev)
 {
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 7324de52d950..161786e9b7e4 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -685,10 +685,29 @@ static int usbhs_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&priv->notify_hotplug_work, usbhsc_notify_hotplug);
 	spin_lock_init(usbhs_priv_to_lock(priv));
 
+	/*
+	 * Acquire clocks and enable power management (PM) early in the
+	 * probe process, as the driver accesses registers during
+	 * initialization. Ensure the device is active before proceeding.
+	 */
+	pm_runtime_enable(dev);
+
+	ret = usbhsc_clk_get(dev, priv);
+	if (ret)
+		goto probe_pm_disable;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto probe_clk_put;
+
+	ret = usbhsc_clk_prepare_enable(priv);
+	if (ret)
+		goto probe_pm_put;
+
 	/* call pipe and module init */
 	ret = usbhs_pipe_probe(priv);
 	if (ret < 0)
-		return ret;
+		goto probe_clk_dis_unprepare;
 
 	ret = usbhs_fifo_probe(priv);
 	if (ret < 0)
@@ -705,10 +724,6 @@ static int usbhs_probe(struct platform_device *pdev)
 	if (ret)
 		goto probe_fail_rst;
 
-	ret = usbhsc_clk_get(dev, priv);
-	if (ret)
-		goto probe_fail_clks;
-
 	/*
 	 * deviece reset here because
 	 * USB device might be used in boot loader.
@@ -721,7 +736,7 @@ static int usbhs_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_warn(dev, "USB function not selected (GPIO)\n");
 			ret = -ENOTSUPP;
-			goto probe_end_mod_exit;
+			goto probe_assert_rest;
 		}
 	}
 
@@ -735,14 +750,19 @@ static int usbhs_probe(struct platform_device *pdev)
 	ret = usbhs_platform_call(priv, hardware_init, pdev);
 	if (ret < 0) {
 		dev_err(dev, "platform init failed.\n");
-		goto probe_end_mod_exit;
+		goto probe_assert_rest;
 	}
 
 	/* reset phy for connection */
 	usbhs_platform_call(priv, phy_reset, pdev);
 
-	/* power control */
-	pm_runtime_enable(dev);
+	/*
+	 * Disable the clocks that were enabled earlier in the probe path,
+	 * and let the driver handle the clocks beyond this point.
+	 */
+	usbhsc_clk_disable_unprepare(priv);
+	pm_runtime_put(dev);
+
 	if (!usbhs_get_dparam(priv, runtime_pwctrl)) {
 		usbhsc_power_ctrl(priv, 1);
 		usbhs_mod_autonomy_mode(priv);
@@ -759,9 +779,7 @@ static int usbhs_probe(struct platform_device *pdev)
 
 	return ret;
 
-probe_end_mod_exit:
-	usbhsc_clk_put(priv);
-probe_fail_clks:
+probe_assert_rest:
 	reset_control_assert(priv->rsts);
 probe_fail_rst:
 	usbhs_mod_remove(priv);
@@ -769,6 +787,14 @@ static int usbhs_probe(struct platform_device *pdev)
 	usbhs_fifo_remove(priv);
 probe_end_pipe_exit:
 	usbhs_pipe_remove(priv);
+probe_clk_dis_unprepare:
+	usbhsc_clk_disable_unprepare(priv);
+probe_pm_put:
+	pm_runtime_put(dev);
+probe_clk_put:
+	usbhsc_clk_put(priv);
+probe_pm_disable:
+	pm_runtime_disable(dev);
 
 	dev_info(dev, "probe failed (%d)\n", ret);
 
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index aa879253d3b8..13044ee5be10 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -449,7 +449,7 @@ ATTRIBUTE_GROUPS(typec);
 
 static int typec_match(struct device *dev, const struct device_driver *driver)
 {
-	struct typec_altmode_driver *drv = to_altmode_driver(driver);
+	const struct typec_altmode_driver *drv = to_altmode_driver(driver);
 	struct typec_altmode *altmode = to_typec_altmode(dev);
 	const struct typec_device_id *id;
 
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index fd1b80593367..648311f5e3cf 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -166,7 +166,8 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 		return;
 	}
 
-	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
+	if (count > sizeof(struct pd_message) + 1 ||
+	    count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
 		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
 		return;
 	}
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bbd7f53f7d59..1d8e760df483 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -568,6 +568,15 @@ struct pd_rx_event {
 	enum tcpm_transmit_type rx_sop_type;
 };
 
+struct altmode_vdm_event {
+	struct kthread_work work;
+	struct tcpm_port *port;
+	u32 header;
+	u32 *data;
+	int cnt;
+	enum tcpm_transmit_type tx_sop_type;
+};
+
 static const char * const pd_rev[] = {
 	[PD_REV10]		= "rev1",
 	[PD_REV20]		= "rev2",
@@ -1562,18 +1571,68 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	mod_vdm_delayed_work(port, 0);
 }
 
-static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
-				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
+static void tcpm_queue_vdm_work(struct kthread_work *work)
 {
-	if (port->state != SRC_READY && port->state != SNK_READY &&
-	    port->state != SRC_VDM_IDENTITY_REQUEST)
-		return;
+	struct altmode_vdm_event *event = container_of(work,
+						       struct altmode_vdm_event,
+						       work);
+	struct tcpm_port *port = event->port;
 
 	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
+	if (port->state != SRC_READY && port->state != SNK_READY &&
+	    port->state != SRC_VDM_IDENTITY_REQUEST) {
+		tcpm_log_force(port, "dropping altmode_vdm_event");
+		goto port_unlock;
+	}
+
+	tcpm_queue_vdm(port, event->header, event->data, event->cnt, event->tx_sop_type);
+
+port_unlock:
+	kfree(event->data);
+	kfree(event);
 	mutex_unlock(&port->lock);
 }
 
+static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
+				   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
+{
+	struct altmode_vdm_event *event;
+	u32 *data_cpy;
+	int ret = -ENOMEM;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		goto err_event;
+
+	data_cpy = kcalloc(cnt, sizeof(u32), GFP_KERNEL);
+	if (!data_cpy)
+		goto err_data;
+
+	kthread_init_work(&event->work, tcpm_queue_vdm_work);
+	event->port = port;
+	event->header = header;
+	memcpy(data_cpy, data, sizeof(u32) * cnt);
+	event->data = data_cpy;
+	event->cnt = cnt;
+	event->tx_sop_type = tx_sop_type;
+
+	ret = kthread_queue_work(port->wq, &event->work);
+	if (!ret) {
+		ret = -EBUSY;
+		goto err_queue;
+	}
+
+	return 0;
+
+err_queue:
+	kfree(data_cpy);
+err_data:
+	kfree(event);
+err_event:
+	tcpm_log_force(port, "failed to queue altmode vdm, err:%d", ret);
+	return ret;
+}
+
 static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	u32 vdo = p[VDO_INDEX_IDH];
@@ -2784,8 +2843,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
 }
 
 static int tcpm_altmode_exit(struct typec_altmode *altmode)
@@ -2801,8 +2859,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
 }
 
 static int tcpm_altmode_vdm(struct typec_altmode *altmode,
@@ -2810,9 +2867,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
-
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
 }
 
 static const struct typec_altmode_ops tcpm_altmode_ops = {
@@ -2836,8 +2891,7 @@ static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_pl
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
 }
 
 static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop)
@@ -2853,8 +2907,7 @@ static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plu
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
 }
 
 static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
@@ -2862,9 +2915,7 @@ static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
-
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
 }
 
 static const struct typec_cable_ops tcpm_cable_ops = {
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 0d632ba5d2a3..68300fcd3c41 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -350,6 +350,32 @@ static int vf_qm_func_stop(struct hisi_qm *qm)
 	return hisi_qm_mb(qm, QM_MB_CMD_PAUSE_QM, 0, 0, 0);
 }
 
+static int vf_qm_version_check(struct acc_vf_data *vf_data, struct device *dev)
+{
+	switch (vf_data->acc_magic) {
+	case ACC_DEV_MAGIC_V2:
+		if (vf_data->major_ver != ACC_DRV_MAJOR_VER) {
+			dev_info(dev, "migration driver version<%u.%u> not match!\n",
+				 vf_data->major_ver, vf_data->minor_ver);
+			return -EINVAL;
+		}
+		break;
+	case ACC_DEV_MAGIC_V1:
+		/* Correct dma address */
+		vf_data->eqe_dma = vf_data->qm_eqc_dw[QM_XQC_ADDR_HIGH];
+		vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
+		vf_data->eqe_dma |= vf_data->qm_eqc_dw[QM_XQC_ADDR_LOW];
+		vf_data->aeqe_dma = vf_data->qm_aeqc_dw[QM_XQC_ADDR_HIGH];
+		vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
+		vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 			     struct hisi_acc_vf_migration_file *migf)
 {
@@ -363,7 +389,8 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	if (migf->total_length < QM_MATCH_SIZE || hisi_acc_vdev->match_done)
 		return 0;
 
-	if (vf_data->acc_magic != ACC_DEV_MAGIC) {
+	ret = vf_qm_version_check(vf_data, dev);
+	if (ret) {
 		dev_err(dev, "failed to match ACC_DEV_MAGIC\n");
 		return -EINVAL;
 	}
@@ -399,13 +426,6 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 		return -EINVAL;
 	}
 
-	ret = qm_write_regs(vf_qm, QM_VF_STATE, &vf_data->vf_qm_state, 1);
-	if (ret) {
-		dev_err(dev, "failed to write QM_VF_STATE\n");
-		return ret;
-	}
-
-	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
 	hisi_acc_vdev->match_done = true;
 	return 0;
 }
@@ -418,7 +438,9 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	int vf_id = hisi_acc_vdev->vf_id;
 	int ret;
 
-	vf_data->acc_magic = ACC_DEV_MAGIC;
+	vf_data->acc_magic = ACC_DEV_MAGIC_V2;
+	vf_data->major_ver = ACC_DRV_MAJOR_VER;
+	vf_data->minor_ver = ACC_DRV_MINOR_VER;
 	/* Save device id */
 	vf_data->dev_id = hisi_acc_vdev->vf_dev->device;
 
@@ -441,6 +463,19 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	return 0;
 }
 
+static void vf_qm_xeqc_save(struct hisi_qm *qm,
+			    struct hisi_acc_vf_migration_file *migf)
+{
+	struct acc_vf_data *vf_data = &migf->vf_data;
+	u16 eq_head, aeq_head;
+
+	eq_head = vf_data->qm_eqc_dw[0] & 0xFFFF;
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, eq_head, 0);
+
+	aeq_head = vf_data->qm_aeqc_dw[0] & 0xFFFF;
+	qm_db(qm, 0, QM_DOORBELL_CMD_AEQ, aeq_head, 0);
+}
+
 static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 			   struct hisi_acc_vf_migration_file *migf)
 {
@@ -456,6 +491,20 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	if (migf->total_length < sizeof(struct acc_vf_data))
 		return -EINVAL;
 
+	if (!vf_data->eqe_dma || !vf_data->aeqe_dma ||
+	    !vf_data->sqc_dma || !vf_data->cqc_dma) {
+		dev_info(dev, "resume dma addr is NULL!\n");
+		hisi_acc_vdev->vf_qm_state = QM_NOT_READY;
+		return 0;
+	}
+
+	ret = qm_write_regs(qm, QM_VF_STATE, &vf_data->vf_qm_state, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_VF_STATE\n");
+		return -EINVAL;
+	}
+	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
+
 	qm->eqe_dma = vf_data->eqe_dma;
 	qm->aeqe_dma = vf_data->aeqe_dma;
 	qm->sqc_dma = vf_data->sqc_dma;
@@ -516,12 +565,12 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 		return -EINVAL;
 
 	/* Every reg is 32 bit, the dma address is 64 bit. */
-	vf_data->eqe_dma = vf_data->qm_eqc_dw[1];
+	vf_data->eqe_dma = vf_data->qm_eqc_dw[QM_XQC_ADDR_HIGH];
 	vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
-	vf_data->eqe_dma |= vf_data->qm_eqc_dw[0];
-	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[1];
+	vf_data->eqe_dma |= vf_data->qm_eqc_dw[QM_XQC_ADDR_LOW];
+	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[QM_XQC_ADDR_HIGH];
 	vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
-	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[0];
+	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
 
 	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
 	ret = qm_get_sqc(vf_qm, &vf_data->sqc_dma);
@@ -537,6 +586,9 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	}
 
 	migf->total_length = sizeof(struct acc_vf_data);
+	/* Save eqc and aeqc interrupt information */
+	vf_qm_xeqc_save(vf_qm, migf);
+
 	return 0;
 }
 
@@ -1326,6 +1378,7 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
 	hisi_acc_vdev->pf_qm = pf_qm;
 	hisi_acc_vdev->vf_dev = pdev;
+	hisi_acc_vdev->vf_qm_state = QM_NOT_READY;
 	mutex_init(&hisi_acc_vdev->state_mutex);
 
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_PRE_COPY;
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 5bab46602fad..465284168906 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -38,6 +38,9 @@
 #define QM_REG_ADDR_OFFSET	0x0004
 
 #define QM_XQC_ADDR_OFFSET	32U
+#define QM_XQC_ADDR_LOW	0x1
+#define QM_XQC_ADDR_HIGH	0x2
+
 #define QM_VF_AEQ_INT_MASK	0x0004
 #define QM_VF_EQ_INT_MASK	0x000c
 #define QM_IFC_INT_SOURCE_V	0x0020
@@ -49,10 +52,15 @@
 #define QM_EQC_DW0		0X8000
 #define QM_AEQC_DW0		0X8020
 
+#define ACC_DRV_MAJOR_VER 1
+#define ACC_DRV_MINOR_VER 0
+
+#define ACC_DEV_MAGIC_V1	0XCDCDCDCDFEEDAACC
+#define ACC_DEV_MAGIC_V2	0xAACCFEEDDECADEDE
+
 struct acc_vf_data {
 #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
 	/* QM match information */
-#define ACC_DEV_MAGIC	0XCDCDCDCDFEEDAACC
 	u64 acc_magic;
 	u32 qp_num;
 	u32 dev_id;
@@ -60,7 +68,9 @@ struct acc_vf_data {
 	u32 qp_base;
 	u32 vf_qm_state;
 	/* QM reserved match information */
-	u32 qm_rsv_state[3];
+	u16 major_ver;
+	u16 minor_ver;
+	u32 qm_rsv_state[2];
 
 	/* QM RW regs */
 	u32 aeq_int_mask;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index bf391b40e576..8338cfd61fe1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -294,7 +294,7 @@ static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
 			struct rb_node *p;
 
 			for (p = rb_prev(n); p; p = rb_prev(p)) {
-				struct vfio_dma *dma = rb_entry(n,
+				struct vfio_dma *dma = rb_entry(p,
 							struct vfio_dma, node);
 
 				vfio_dma_bitmap_free(dma);
diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 10129095a4c1..b19e5f73de8b 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1406,9 +1406,11 @@ static int wled_configure(struct wled *wled)
 	wled->ctrl_addr = be32_to_cpu(*prop_addr);
 
 	rc = of_property_read_string(dev->of_node, "label", &wled->name);
-	if (rc)
+	if (rc) {
 		wled->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
-
+		if (!wled->name)
+			return -ENOMEM;
+	}
 	switch (wled->version) {
 	case 3:
 		u32_opts = wled3_opts;
diff --git a/drivers/video/fbdev/core/fbcvt.c b/drivers/video/fbdev/core/fbcvt.c
index 64843464c661..cd3821bd82e5 100644
--- a/drivers/video/fbdev/core/fbcvt.c
+++ b/drivers/video/fbdev/core/fbcvt.c
@@ -312,7 +312,7 @@ int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb)
 	cvt.f_refresh = cvt.refresh;
 	cvt.interlace = 1;
 
-	if (!cvt.xres || !cvt.yres || !cvt.refresh) {
+	if (!cvt.xres || !cvt.yres || !cvt.refresh || cvt.f_refresh > INT_MAX) {
 		printk(KERN_INFO "fbcvt: Invalid input parameters\n");
 		return 1;
 	}
diff --git a/drivers/watchdog/exar_wdt.c b/drivers/watchdog/exar_wdt.c
index 7c61ff343271..c2e3bb08df89 100644
--- a/drivers/watchdog/exar_wdt.c
+++ b/drivers/watchdog/exar_wdt.c
@@ -221,7 +221,7 @@ static const struct watchdog_info exar_wdt_info = {
 	.options	= WDIOF_KEEPALIVEPING |
 			  WDIOF_SETTIMEOUT |
 			  WDIOF_MAGICCLOSE,
-	.identity	= "Exar/MaxLinear XR28V38x Watchdog",
+	.identity	= "Exar XR28V38x Watchdog",
 };
 
 static const struct watchdog_ops exar_wdt_ops = {
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 4bd31242bd77..e47bb157aa09 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -700,15 +700,18 @@ static int __init balloon_add_regions(void)
 
 		/*
 		 * Extra regions are accounted for in the physmap, but need
-		 * decreasing from current_pages to balloon down the initial
-		 * allocation, because they are already accounted for in
-		 * total_pages.
+		 * decreasing from current_pages and target_pages to balloon
+		 * down the initial allocation, because they are already
+		 * accounted for in total_pages.
 		 */
-		if (extra_pfn_end - start_pfn >= balloon_stats.current_pages) {
+		pages = extra_pfn_end - start_pfn;
+		if (pages >= balloon_stats.current_pages ||
+		    pages >= balloon_stats.target_pages) {
 			WARN(1, "Extra pages underflow current target");
 			return -ERANGE;
 		}
-		balloon_stats.current_pages -= extra_pfn_end - start_pfn;
+		balloon_stats.current_pages -= pages;
+		balloon_stats.target_pages -= pages;
 	}
 
 	return 0;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 819c75233235..db78c06ba0cc 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -160,4 +160,5 @@ const struct address_space_operations v9fs_addr_operations = {
 	.invalidate_folio	= netfs_invalidate_folio,
 	.direct_IO		= noop_direct_IO,
 	.writepages		= netfs_writepages,
+	.migrate_folio		= filemap_migrate_folio,
 };
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6d08c100b01d..5f9a43734812 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1252,8 +1252,11 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (!prealloc)
 			goto search_again;
 		ret = split_state(tree, state, prealloc, end + 1);
-		if (ret)
+		if (ret) {
 			extent_io_tree_panic(tree, state, "split", ret);
+			prealloc = NULL;
+			goto out;
+		}
 
 		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
@@ -1456,6 +1459,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (IS_ERR(inserted_state)) {
 			ret = PTR_ERR(inserted_state);
 			extent_io_tree_panic(tree, prealloc, "insert", ret);
+			goto out;
 		}
 		cache_state(inserted_state, cached_state);
 		if (inserted_state == prealloc)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9ce1270addb0..1ab5b0c1b9b7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4857,8 +4857,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio)) {
-		btrfs_delalloc_release_space(inode, data_reserved, block_start,
-					     blocksize, true);
+		if (only_release_metadata)
+			btrfs_delalloc_release_metadata(inode, blocksize, true);
+		else
+			btrfs_delalloc_release_space(inode, data_reserved,
+						     block_start, blocksize, true);
 		btrfs_delalloc_release_extents(inode, blocksize);
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d8fcc3eb85c8..3fcc7c092c5e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -153,12 +153,14 @@ struct scrub_stripe {
 	unsigned int init_nr_io_errors;
 	unsigned int init_nr_csum_errors;
 	unsigned int init_nr_meta_errors;
+	unsigned int init_nr_meta_gen_errors;
 
 	/*
 	 * The following error bitmaps are all for the current status.
 	 * Every time we submit a new read, these bitmaps may be updated.
 	 *
-	 * error_bitmap = io_error_bitmap | csum_error_bitmap | meta_error_bitmap;
+	 * error_bitmap = io_error_bitmap | csum_error_bitmap |
+	 *		  meta_error_bitmap | meta_generation_bitmap;
 	 *
 	 * IO and csum errors can happen for both metadata and data.
 	 */
@@ -166,6 +168,7 @@ struct scrub_stripe {
 	unsigned long io_error_bitmap;
 	unsigned long csum_error_bitmap;
 	unsigned long meta_error_bitmap;
+	unsigned long meta_gen_error_bitmap;
 
 	/* For writeback (repair or replace) error reporting. */
 	unsigned long write_error_bitmap;
@@ -616,7 +619,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
 
 	if (logical != btrfs_stack_header_bytenr(header)) {
-		bitmap_set(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
 		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
@@ -672,7 +675,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (stripe->sectors[sector_nr].generation !=
 	    btrfs_stack_header_generation(header)) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_gen_error_bitmap, sector_nr, sectors_per_tree);
 		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad generation, has %llu want %llu",
@@ -684,6 +687,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
 	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
+	bitmap_clear(&stripe->meta_gen_error_bitmap, sector_nr, sectors_per_tree);
 }
 
 static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
@@ -972,8 +976,22 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("header error", dev, false,
 						     stripe->logical, physical);
+		if (test_bit(sector_nr, &stripe->meta_gen_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub_print_common_warning("generation error", dev, false,
+						     stripe->logical, physical);
 	}
 
+	/* Update the device stats. */
+	for (int i = 0; i < stripe->init_nr_io_errors; i++)
+		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_READ_ERRS);
+	for (int i = 0; i < stripe->init_nr_csum_errors; i++)
+		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
+	/* Generation mismatch error is based on each metadata, not each block. */
+	for (int i = 0; i < stripe->init_nr_meta_gen_errors;
+	     i += (fs_info->nodesize >> fs_info->sectorsize_bits))
+		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_GENERATION_ERRS);
+
 	spin_lock(&sctx->stat_lock);
 	sctx->stat.data_extents_scrubbed += stripe->nr_data_extents;
 	sctx->stat.tree_extents_scrubbed += stripe->nr_meta_extents;
@@ -982,7 +1000,8 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	sctx->stat.no_csum += nr_nodatacsum_sectors;
 	sctx->stat.read_errors += stripe->init_nr_io_errors;
 	sctx->stat.csum_errors += stripe->init_nr_csum_errors;
-	sctx->stat.verify_errors += stripe->init_nr_meta_errors;
+	sctx->stat.verify_errors += stripe->init_nr_meta_errors +
+				    stripe->init_nr_meta_gen_errors;
 	sctx->stat.uncorrectable_errors +=
 		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
 	sctx->stat.corrected_errors += nr_repaired_sectors;
@@ -1028,6 +1047,8 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 						    stripe->nr_sectors);
 	stripe->init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
 						    stripe->nr_sectors);
+	stripe->init_nr_meta_gen_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
+							stripe->nr_sectors);
 
 	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
 		goto out;
@@ -1142,6 +1163,9 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		bitmap_set(&stripe->write_error_bitmap, sector_nr,
 			   bio_size >> fs_info->sectorsize_bits);
 		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
+		for (int i = 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
+			btrfs_dev_stat_inc_and_print(stripe->dev,
+						     BTRFS_DEV_STAT_WRITE_ERRS);
 	}
 	bio_put(&bbio->bio);
 
@@ -1508,10 +1532,12 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 	stripe->init_nr_io_errors = 0;
 	stripe->init_nr_csum_errors = 0;
 	stripe->init_nr_meta_errors = 0;
+	stripe->init_nr_meta_gen_errors = 0;
 	stripe->error_bitmap = 0;
 	stripe->io_error_bitmap = 0;
 	stripe->csum_error_bitmap = 0;
 	stripe->meta_error_bitmap = 0;
+	stripe->meta_gen_error_bitmap = 0;
 }
 
 /*
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3421448fef0e..5fcdab614517 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -188,8 +188,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
 				bdev_file_open_by_path(dif->path,
 						BLK_OPEN_READ, sb->s_type, NULL);
-		if (IS_ERR(file))
+		if (IS_ERR(file)) {
+			if (file == ERR_PTR(-ENOTBLK))
+				return -EINVAL;
 			return PTR_ERR(file);
+		}
 
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
@@ -537,24 +540,52 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static struct inode *erofs_nfs_get_inode(struct super_block *sb,
-					 u64 ino, u32 generation)
+static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
 {
-	return erofs_iget(sb, ino);
+	erofs_nid_t nid = EROFS_I(inode)->nid;
+	int len = parent ? 6 : 3;
+
+	if (*max_len < len) {
+		*max_len = len;
+		return FILEID_INVALID;
+	}
+
+	fh[0] = (u32)(nid >> 32);
+	fh[1] = (u32)(nid & 0xffffffff);
+	fh[2] = inode->i_generation;
+
+	if (parent) {
+		nid = EROFS_I(parent)->nid;
+
+		fh[3] = (u32)(nid >> 32);
+		fh[4] = (u32)(nid & 0xffffffff);
+		fh[5] = parent->i_generation;
+	}
+
+	*max_len = len;
+	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
 }
 
 static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
-				    erofs_nfs_get_inode);
+	if ((fh_type != FILEID_INO64_GEN &&
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
+		return NULL;
+
+	return d_obtain_alias(erofs_iget(sb,
+		((u64)fid->raw[0] << 32) | fid->raw[1]));
 }
 
 static struct dentry *erofs_fh_to_parent(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
-				    erofs_nfs_get_inode);
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
+		return NULL;
+
+	return d_obtain_alias(erofs_iget(sb,
+		((u64)fid->raw[3] << 32) | fid->raw[4]));
 }
 
 static struct dentry *erofs_get_parent(struct dentry *child)
@@ -570,7 +601,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 }
 
 static const struct export_operations erofs_export_ops = {
-	.encode_fh = generic_encode_ino32_fh,
+	.encode_fh = erofs_encode_fh,
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1b0050b8421d..62c7fd1168a1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -53,8 +53,8 @@ bool f2fs_is_cp_guaranteed(struct page *page)
 	struct inode *inode;
 	struct f2fs_sb_info *sbi;
 
-	if (!mapping)
-		return false;
+	if (fscrypt_is_bounce_page(page))
+		return page_private_gcing(fscrypt_pagecache_page(page));
 
 	inode = mapping->host;
 	sbi = F2FS_I_SB(inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1c783c2e4902..1219e37fa7ad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2508,8 +2508,14 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	blkcnt_t sectors = count << F2FS_LOG_SECTORS_PER_BLOCK;
 
 	spin_lock(&sbi->stat_lock);
-	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
-	sbi->total_valid_block_count -= (block_t)count;
+	if (unlikely(sbi->total_valid_block_count < count)) {
+		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%lu, count:%u",
+			  sbi->total_valid_block_count, inode->i_ino, count);
+		sbi->total_valid_block_count = 0;
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+	} else {
+		sbi->total_valid_block_count -= count;
+	}
 	if (sbi->reserved_blocks &&
 		sbi->current_reserved_blocks < sbi->reserved_blocks)
 		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e0469316c7cd..cd56c0e66657 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2072,6 +2072,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
+		if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, segno)))
+			continue;
+
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 57d46e1439de..6f70f377f121 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -413,7 +413,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	if (is_inode_flag_set(dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)))
+			F2FS_I(inode)->i_projid)))
 		return -EXDEV;
 
 	err = f2fs_dquot_initialize(dir);
@@ -905,7 +905,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(new_dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)))
+			F2FS_I(old_inode)->i_projid)))
 		return -EXDEV;
 
 	/*
@@ -1098,10 +1098,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if ((is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			!projid_eq(F2FS_I(new_dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)) ||
-	    (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
+			F2FS_I(old_inode)->i_projid)) ||
+	    (is_inode_flag_set(old_dir, FI_PROJ_INHERIT) &&
 			!projid_eq(F2FS_I(old_dir)->i_projid,
-			F2FS_I(new_dentry->d_inode)->i_projid)))
+			F2FS_I(new_inode)->i_projid)))
 		return -EXDEV;
 
 	err = f2fs_dquot_initialize(old_dir);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 0c004dd5595b..05a342933f98 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -431,7 +431,6 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
-	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi);
 
 	spin_lock(&free_i->segmap_lock);
 	clear_bit(segno, free_i->free_segmap);
@@ -439,7 +438,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 
 	next = find_next_bit(free_i->free_segmap,
 			start_segno + SEGS_PER_SEC(sbi), start_segno);
-	if (next >= start_segno + usable_segs) {
+	if (next >= start_segno + f2fs_usable_segs_in_sec(sbi)) {
 		clear_bit(secno, free_i->free_secmap);
 		free_i->free_sections++;
 	}
@@ -465,22 +464,36 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
-	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi);
+	bool ret;
 
 	spin_lock(&free_i->segmap_lock);
-	if (test_and_clear_bit(segno, free_i->free_segmap)) {
-		free_i->free_segments++;
-
-		if (!inmem && IS_CURSEC(sbi, secno))
-			goto skip_free;
-		next = find_next_bit(free_i->free_segmap,
-				start_segno + SEGS_PER_SEC(sbi), start_segno);
-		if (next >= start_segno + usable_segs) {
-			if (test_and_clear_bit(secno, free_i->free_secmap))
-				free_i->free_sections++;
-		}
-	}
-skip_free:
+	ret = test_and_clear_bit(segno, free_i->free_segmap);
+	if (!ret)
+		goto unlock_out;
+
+	free_i->free_segments++;
+
+	if (!inmem && IS_CURSEC(sbi, secno))
+		goto unlock_out;
+
+	/* check large section */
+	next = find_next_bit(free_i->free_segmap,
+			     start_segno + SEGS_PER_SEC(sbi), start_segno);
+	if (next < start_segno + f2fs_usable_segs_in_sec(sbi))
+		goto unlock_out;
+
+	ret = test_and_clear_bit(secno, free_i->free_secmap);
+	if (!ret)
+		goto unlock_out;
+
+	free_i->free_sections++;
+
+	if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[BG_GC]) == secno)
+		sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+	if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[FG_GC]) == secno)
+		sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
+
+unlock_out:
 	spin_unlock(&free_i->segmap_lock);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 573cc4725e2e..faa76531246e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1862,9 +1862,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_fsid    = u64_to_fsid(id);
 
 #ifdef CONFIG_QUOTA
-	if (is_inode_flag_set(dentry->d_inode, FI_PROJ_INHERIT) &&
+	if (is_inode_flag_set(d_inode(dentry), FI_PROJ_INHERIT) &&
 			sb_has_quota_limits_enabled(sb, PRJQUOTA)) {
-		f2fs_statfs_project(sb, F2FS_I(dentry->d_inode)->i_projid, buf);
+		f2fs_statfs_project(sb, F2FS_I(d_inode(dentry))->i_projid, buf);
 	}
 #endif
 	return 0;
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 58b9067b2391..95e5256821a5 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -156,15 +156,19 @@ static int fs_index(const char __user * __name)
 static int fs_name(unsigned int index, char __user * buf)
 {
 	struct file_system_type * tmp;
-	int len, res;
+	int len, res = -EINVAL;
 
 	read_lock(&file_systems_lock);
-	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
-		if (index <= 0 && try_module_get(tmp->owner))
+	for (tmp = file_systems; tmp; tmp = tmp->next, index--) {
+		if (index == 0) {
+			if (try_module_get(tmp->owner))
+				res = 0;
 			break;
+		}
+	}
 	read_unlock(&file_systems_lock);
-	if (!tmp)
-		return -EINVAL;
+	if (res)
+		return res;
 
 	/* OK, we got the reference, so we can safely block */
 	len = strlen(tmp->name) + 1;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4f1eca99786b..aecce4bb5e1a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1183,7 +1183,6 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 		   const struct gfs2_glock_operations *glops, int create,
 		   struct gfs2_glock **glp)
 {
-	struct super_block *s = sdp->sd_vfs;
 	struct lm_lockname name = { .ln_number = number,
 				    .ln_type = glops->go_type,
 				    .ln_sbd = sdp };
@@ -1246,7 +1245,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_mapping->host;
+		mapping->host = sdp->sd_inode;
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->i_private_data = NULL;
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 95d8081681dc..72a0601ce65e 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -168,7 +168,7 @@ void gfs2_ail_flush(struct gfs2_glock *gl, bool fsync)
 static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct address_space *metamapping = &sdp->sd_aspace;
+	struct address_space *metamapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
 	loff_t start = (rgd->rd_addr * bsize) & PAGE_MASK;
@@ -225,7 +225,7 @@ static int rgrp_go_sync(struct gfs2_glock *gl)
 static void rgrp_go_inval(struct gfs2_glock *gl, int flags)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct address_space *mapping = &sdp->sd_aspace;
+	struct address_space *mapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
 	loff_t start, end;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index bd1348bff90e..e5535d7b4659 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -793,7 +793,7 @@ struct gfs2_sbd {
 
 	/* Log stuff */
 
-	struct address_space sd_aspace;
+	struct inode *sd_inode;
 
 	spinlock_t sd_log_lock;
 
@@ -849,6 +849,13 @@ struct gfs2_sbd {
 	unsigned long sd_glock_dqs_held;
 };
 
+#define GFS2_BAD_INO 1
+
+static inline struct address_space *gfs2_aspace(struct gfs2_sbd *sdp)
+{
+	return sdp->sd_inode->i_mapping;
+}
+
 static inline void gfs2_glstats_inc(struct gfs2_glock *gl, int which)
 {
 	gl->gl_stats.stats[which]++;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 1b95db2c3aac..3be24285ab01 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -659,7 +659,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR(inode)) {
 		if (S_ISDIR(inode->i_mode)) {
 			iput(inode);
-			inode = ERR_PTR(-EISDIR);
+			inode = NULL;
+			error = -EISDIR;
 			goto fail_gunlock;
 		}
 		d_instantiate(dentry, inode);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index fea3efcc2f93..960d6afcdfad 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -132,7 +132,7 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 	unsigned int bufnum;
 
 	if (mapping == NULL)
-		mapping = &sdp->sd_aspace;
+		mapping = gfs2_aspace(sdp);
 
 	shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
 	index = blkno >> shift;             /* convert block to page */
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 831d988c2ceb..b7c8a6684d02 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -44,9 +44,7 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 		struct gfs2_glock_aspace *gla =
 			container_of(mapping, struct gfs2_glock_aspace, mapping);
 		return gla->glock.gl_name.ln_sbd;
-	} else if (mapping->a_ops == &gfs2_rgrp_aops)
-		return container_of(mapping, struct gfs2_sbd, sd_aspace);
-	else
+	} else
 		return inode->i_sb->s_fs_info;
 }
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e83d293c3614..4a0f7de41b2b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -64,15 +64,17 @@ static void gfs2_tune_init(struct gfs2_tune *gt)
 
 void free_sbd(struct gfs2_sbd *sdp)
 {
+	struct super_block *sb = sdp->sd_vfs;
+
 	if (sdp->sd_lkstats)
 		free_percpu(sdp->sd_lkstats);
+	sb->s_fs_info = NULL;
 	kfree(sdp);
 }
 
 static struct gfs2_sbd *init_sbd(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp;
-	struct address_space *mapping;
 
 	sdp = kzalloc(sizeof(struct gfs2_sbd), GFP_KERNEL);
 	if (!sdp)
@@ -109,16 +111,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	INIT_LIST_HEAD(&sdp->sd_sc_inodes_list);
 
-	mapping = &sdp->sd_aspace;
-
-	address_space_init_once(mapping);
-	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_mapping->host;
-	mapping->flags = 0;
-	mapping_set_gfp_mask(mapping, GFP_NOFS);
-	mapping->i_private_data = NULL;
-	mapping->writeback_index = 0;
-
 	spin_lock_init(&sdp->sd_log_lock);
 	atomic_set(&sdp->sd_log_pinned, 0);
 	INIT_LIST_HEAD(&sdp->sd_log_revokes);
@@ -1135,6 +1127,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
+	struct address_space *mapping;
 	int error;
 
 	sdp = init_sbd(sb);
@@ -1156,6 +1149,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NOSEC;
 	sb->s_magic = GFS2_MAGIC;
 	sb->s_op = &gfs2_super_ops;
+
 	sb->s_d_op = &gfs2_dops;
 	sb->s_export_op = &gfs2_export_ops;
 	sb->s_qcop = &gfs2_quotactl_ops;
@@ -1181,9 +1175,21 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 		sdp->sd_tune.gt_statfs_quantum = 30;
 	}
 
+	/* Set up an address space for metadata writes */
+	sdp->sd_inode = new_inode(sb);
+	error = -ENOMEM;
+	if (!sdp->sd_inode)
+		goto fail_free;
+	sdp->sd_inode->i_ino = GFS2_BAD_INO;
+	sdp->sd_inode->i_size = OFFSET_MAX;
+
+	mapping = gfs2_aspace(sdp);
+	mapping->a_ops = &gfs2_rgrp_aops;
+	mapping_set_gfp_mask(mapping, GFP_NOFS);
+
 	error = init_names(sdp, silent);
 	if (error)
-		goto fail_free;
+		goto fail_iput;
 
 	snprintf(sdp->sd_fsname, sizeof(sdp->sd_fsname), "%s", sdp->sd_table_name);
 
@@ -1192,7 +1198,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE, 0,
 			sdp->sd_fsname);
 	if (!sdp->sd_glock_wq)
-		goto fail_free;
+		goto fail_iput;
 
 	sdp->sd_delete_wq = alloc_workqueue("gfs2-delete/%s",
 			WQ_MEM_RECLAIM | WQ_FREEZABLE, 0, sdp->sd_fsname);
@@ -1309,9 +1315,10 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_glock_wq:
 	if (sdp->sd_glock_wq)
 		destroy_workqueue(sdp->sd_glock_wq);
+fail_iput:
+	iput(sdp->sd_inode);
 fail_free:
 	free_sbd(sdp);
-	sb->s_fs_info = NULL;
 	return error;
 }
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b9cef63c7871..5ecb857cf74e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -648,7 +648,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_jindex_free(sdp);
 	/*  Take apart glock structures and buffer lists  */
 	gfs2_gl_hash_clear(sdp);
-	truncate_inode_pages_final(&sdp->sd_aspace);
+	iput(sdp->sd_inode);
 	gfs2_delete_debugfs_file(sdp);
 
 	gfs2_sys_fs_del(sdp);
@@ -674,7 +674,7 @@ static int gfs2_sync_fs(struct super_block *sb, int wait)
 	return sdp->sd_log_error;
 }
 
-static int gfs2_do_thaw(struct gfs2_sbd *sdp)
+static int gfs2_do_thaw(struct gfs2_sbd *sdp, enum freeze_holder who)
 {
 	struct super_block *sb = sdp->sd_vfs;
 	int error;
@@ -682,7 +682,7 @@ static int gfs2_do_thaw(struct gfs2_sbd *sdp)
 	error = gfs2_freeze_lock_shared(sdp);
 	if (error)
 		goto fail;
-	error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+	error = thaw_super(sb, who);
 	if (!error)
 		return 0;
 
@@ -710,7 +710,7 @@ void gfs2_freeze_func(struct work_struct *work)
 	gfs2_freeze_unlock(sdp);
 	set_bit(SDF_FROZEN, &sdp->sd_flags);
 
-	error = gfs2_do_thaw(sdp);
+	error = gfs2_do_thaw(sdp, FREEZE_HOLDER_USERSPACE);
 	if (error)
 		goto out;
 
@@ -728,6 +728,7 @@ void gfs2_freeze_func(struct work_struct *work)
 /**
  * gfs2_freeze_super - prevent further writes to the filesystem
  * @sb: the VFS structure for the filesystem
+ * @who: freeze flags
  *
  */
 
@@ -744,7 +745,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 	for (;;) {
-		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = freeze_super(sb, who);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
 				error);
@@ -758,7 +759,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 			break;
 		}
 
-		error = gfs2_do_thaw(sdp);
+		error = gfs2_do_thaw(sdp, who);
 		if (error)
 			goto out;
 
@@ -796,6 +797,7 @@ static int gfs2_freeze_fs(struct super_block *sb)
 /**
  * gfs2_thaw_super - reallow writes to the filesystem
  * @sb: the VFS structure for the filesystem
+ * @who: freeze flags
  *
  */
 
@@ -814,7 +816,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 	atomic_inc(&sb->s_active);
 	gfs2_freeze_unlock(sdp);
 
-	error = gfs2_do_thaw(sdp);
+	error = gfs2_do_thaw(sdp, who);
 
 	if (!error) {
 		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ecc699f8d9fc..628618302102 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -764,7 +764,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 	fs_err(sdp, "error %d adding sysfs files\n", error);
 	kobject_put(&sdp->sd_kobj);
 	wait_for_completion(&sdp->sd_kobj_unregister);
-	sb->s_fs_info = NULL;
 	return error;
 }
 
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe..5dc90a498e75 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1560,8 +1560,9 @@ void kernfs_break_active_protection(struct kernfs_node *kn)
  * invoked before finishing the kernfs operation.  Note that while this
  * function restores the active reference, it doesn't and can't actually
  * restore the active protection - @kn may already or be in the process of
- * being removed.  Once kernfs_break_active_protection() is invoked, that
- * protection is irreversibly gone for the kernfs operation instance.
+ * being drained and removed.  Once kernfs_break_active_protection() is
+ * invoked, that protection is irreversibly gone for the kernfs operation
+ * instance.
  *
  * While this function may be called at any point after
  * kernfs_break_active_protection() is invoked, its most useful location
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..1943c8bd479b 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -778,8 +778,9 @@ bool kernfs_should_drain_open_files(struct kernfs_node *kn)
 	/*
 	 * @kn being deactivated guarantees that @kn->attr.open can't change
 	 * beneath us making the lockless test below safe.
+	 * Callers post kernfs_unbreak_active_protection may be counted in
+	 * kn->active by now, do not WARN_ON because of them.
 	 */
-	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
 	rcu_read_lock();
 	on = rcu_dereference(kn->attr.open);
diff --git a/fs/namespace.c b/fs/namespace.c
index c1ac585e41e3..843bc6191f30 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2714,6 +2714,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
+	if (!check_mnt(mnt)) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -3151,7 +3155,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 	if (IS_MNT_SLAVE(from)) {
 		struct mount *m = from->mnt_master;
 
-		list_add(&to->mnt_slave, &m->mnt_slave_list);
+		list_add(&to->mnt_slave, &from->mnt_slave);
 		to->mnt_master = m;
 	}
 
@@ -3176,18 +3180,25 @@ static int do_set_group(struct path *from_path, struct path *to_path)
  * Check if path is overmounted, i.e., if there's a mount on top of
  * @path->mnt with @path->dentry as mountpoint.
  *
- * Context: This function expects namespace_lock() to be held.
+ * Context: namespace_sem must be held at least shared.
+ * MUST NOT be called under lock_mount_hash() (there one should just
+ * call __lookup_mnt() and check if it returns NULL).
  * Return: If path is overmounted true is returned, false if not.
  */
 static inline bool path_overmounted(const struct path *path)
 {
+	unsigned seq = read_seqbegin(&mount_lock);
+	bool no_child;
+
 	rcu_read_lock();
-	if (unlikely(__lookup_mnt(path->mnt, path->dentry))) {
-		rcu_read_unlock();
-		return true;
-	}
+	no_child = !__lookup_mnt(path->mnt, path->dentry);
 	rcu_read_unlock();
-	return false;
+	if (need_seqretry(&mount_lock, seq)) {
+		read_seqlock_excl(&mount_lock);
+		no_child = !__lookup_mnt(path->mnt, path->dentry);
+		read_sequnlock_excl(&mount_lock);
+	}
+	return unlikely(!no_child);
 }
 
 /**
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ae5c5e39afa0..da5286514d8c 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1046,6 +1046,16 @@ int nfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
+	/*
+	 * The SB_RDONLY flag has been removed from the superblock during
+	 * mounts to prevent interference between different filesystems.
+	 * Similarly, it is also necessary to ignore the SB_RDONLY flag
+	 * during reconfiguration; otherwise, it may also result in the
+	 * creation of redundant superblocks when mounting a directory with
+	 * different rw and ro flags multiple times.
+	 */
+	fc->sb_flags_mask &= ~SB_RDONLY;
+
 	/*
 	 * Userspace mount programs that send binary options generally send
 	 * them populated with default values. We have no way to know which
@@ -1303,8 +1313,17 @@ int nfs_get_tree_common(struct fs_context *fc)
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
+	/*
+	 * When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of a
+	 * superblock among each filesystem that mounts sub-directories
+	 * belonging to a single exported root path.
+	 * To prevent interference between different filesystems, the
+	 * SB_RDONLY flag should be removed from the superblock.
+	 */
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
+	else
+		fc->sb_flags &= ~SB_RDONLY;
 
 	/* -o noac implies -o sync */
 	if (server->flags & NFS_MOUNT_NOAC)
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index ef5061bb56da..9c51a4ac2627 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2103,11 +2103,13 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
 
 	ret = nilfs_btree_do_lookup(btree, path, key, NULL, level + 1, 0);
 	if (ret < 0) {
-		if (unlikely(ret == -ENOENT))
+		if (unlikely(ret == -ENOENT)) {
 			nilfs_crit(btree->b_inode->i_sb,
 				   "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
 				   btree->b_inode->i_ino,
 				   (unsigned long long)key, level);
+			ret = -EINVAL;
+		}
 		goto out;
 	}
 
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 893ab36824cc..2d8dc6b35b54 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -273,6 +273,9 @@ static int nilfs_direct_propagate(struct nilfs_bmap *bmap,
 	dat = nilfs_bmap_get_dat(bmap);
 	key = nilfs_bmap_data_get_key(bmap, bh);
 	ptr = nilfs_direct_get_ptr(bmap, key);
+	if (ptr == NILFS_BMAP_INVALID_PTR)
+		return -EINVAL;
+
 	if (!buffer_nilfs_volatile(bh)) {
 		oldreq.pr_entry_nr = ptr;
 		newreq.pr_entry_nr = ptr;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 78d20e4baa2c..1bf2a6593dec 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2182,6 +2182,10 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,
 
 		e = hdr_first_de(&n->index->ihdr);
 		fnd_push(fnd, n, e);
+		if (!e) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		if (!de_is_last(e)) {
 			/*
@@ -2203,6 +2207,10 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,
 
 	n = fnd->nodes[level];
 	te = hdr_first_de(&n->index->ihdr);
+	if (!te) {
+		err = -EINVAL;
+		goto out;
+	}
 	/* Copy the candidate entry into the replacement entry buffer. */
 	re = kmalloc(le16_to_cpu(te->size) + sizeof(u64), GFP_NOFS);
 	if (!re) {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index a1e11228dafd..5c05cccd2d40 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -805,6 +805,10 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		ret = 0;
 		goto out;
 	}
+	if (is_compressed(ni)) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter,
 				 wr ? ntfs_get_block_direct_IO_W :
@@ -2108,5 +2112,6 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 	.dirty_folio	= block_dirty_folio,
+	.direct_IO	= ntfs_direct_IO,
 };
 // clang-format on
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index e272429da3db..de7f12858729 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -674,7 +674,7 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 			break;
 	}
 out:
-	kfree(rec);
+	ocfs2_free_quota_recovery(rec);
 	return status;
 }
 
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 8667f403a0ab..cf8d9de2298f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2780,10 +2780,10 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	io_req->TotalParameterCount = 0;
 	io_req->TotalDataCount = 0;
-	io_req->MaxParameterCount = cpu_to_le32(2);
+	io_req->MaxParameterCount = cpu_to_le32(0);
 	/* BB find exact data count max from sess structure BB */
 	io_req->MaxDataCount = cpu_to_le32(CIFSMaxBufSize & 0xFFFFFF00);
-	io_req->MaxSetupCount = 4;
+	io_req->MaxSetupCount = 1;
 	io_req->Reserved = 0;
 	io_req->ParameterOffset = 0;
 	io_req->DataCount = 0;
@@ -2810,6 +2810,22 @@ int cifs_query_reparse_point(const unsigned int xid,
 		goto error;
 	}
 
+	/* SetupCount must be 1, otherwise offset to ByteCount is incorrect. */
+	if (io_rsp->SetupCount != 1) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/*
+	 * ReturnedDataLen is output length of executed IOCTL.
+	 * DataCount is output length transferred over network.
+	 * Check that we have full FSCTL_GET_REPARSE_POINT buffer.
+	 */
+	if (data_count != le16_to_cpu(io_rsp->ReturnedDataLen)) {
+		rc = -EIO;
+		goto error;
+	}
+
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
 	if (start >= end) {
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 22e812808e5c..3a27d4268b3c 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -202,6 +202,11 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
 
 	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
+	if (!msblk->devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
 	mutex_init(&msblk->meta_index_mutex);
diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index d8c4a5dcca7a..0b343776da8c 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -146,6 +146,14 @@ xfs_discard_extents(
 	return error;
 }
 
+/*
+ * Care must be taken setting up the trim cursor as the perags may not have been
+ * initialised when the cursor is initialised. e.g. a clean mount which hasn't
+ * read in AGFs and the first operation run on the mounted fs is a trim. This
+ * can result in perag fields that aren't initialised until
+ * xfs_trim_gather_extents() calls xfs_alloc_read_agf() to lock down the AG for
+ * the free space search.
+ */
 struct xfs_trim_cur {
 	xfs_agblock_t	start;
 	xfs_extlen_t	count;
@@ -183,6 +191,14 @@ xfs_trim_gather_extents(
 	if (error)
 		goto out_trans_cancel;
 
+	/*
+	 * First time through tcur->count will not have been initialised as
+	 * pag->pagf_longest is not guaranteed to be valid before we read
+	 * the AGF buffer above.
+	 */
+	if (!tcur->count)
+		tcur->count = pag->pagf_longest;
+
 	if (tcur->by_bno) {
 		/* sub-AG discard request always starts at tcur->start */
 		cur = xfs_bnobt_init_cursor(mp, tp, agbp, pag);
@@ -329,7 +345,6 @@ xfs_trim_perag_extents(
 {
 	struct xfs_trim_cur	tcur = {
 		.start		= start,
-		.count		= pag->pagf_longest,
 		.end		= end,
 		.minlen		= minlen,
 	};
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 255701e1251b..f652a5028b59 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -46,12 +46,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
-void __init sdei_init(void);
+void __init acpi_sdei_init(void);
 void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
-static inline void sdei_init(void) { }
+static inline void acpi_sdei_init(void) { }
 static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9e98fb87e7ef..1289b8e48780 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -294,7 +294,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 
 	fi->folio = page_folio(bvec->bv_page);
 	fi->offset = bvec->bv_offset +
-			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
+			PAGE_SIZE * folio_page_idx(fi->folio, bvec->bv_page);
 	fi->_seg_count = bvec->bv_len;
 	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
 	fi->_next = folio_next(fi->folio);
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f41c7f0ef91e..a8333b82e766 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -57,9 +57,12 @@ static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
  * @offset:	offset into the folio
  */
 static inline void bvec_set_folio(struct bio_vec *bv, struct folio *folio,
-		unsigned int len, unsigned int offset)
+		size_t len, size_t offset)
 {
-	bvec_set_page(bv, &folio->page, len, offset);
+	unsigned long nr = offset / PAGE_SIZE;
+
+	WARN_ON_ONCE(len > UINT_MAX);
+	bvec_set_page(bv, folio_page(folio, nr), len, offset % PAGE_SIZE);
 }
 
 /**
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f106b1025111..59f99b7da43f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -683,7 +683,7 @@ coresight_find_output_type(struct coresight_platform_data *pdata,
 			   union coresight_dev_subtype subtype);
 
 int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
-			  struct platform_driver *pdev_drv);
+			  struct platform_driver *pdev_drv, struct module *owner);
 
 void coresight_remove_driver(struct amba_driver *amba_drv,
 			     struct platform_driver *pdev_drv);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 018de72505b0..017d31f1d27b 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -736,8 +736,9 @@ struct hid_descriptor {
 	__le16 bcdHID;
 	__u8  bCountryCode;
 	__u8  bNumDescriptors;
+	struct hid_class_descriptor rpt_desc;
 
-	struct hid_class_descriptor desc[1];
+	struct hid_class_descriptor opt_descs[];
 } __attribute__ ((packed));
 
 #define HID_DEVICE(b, g, ven, prod)					\
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 777f6aa8efa7..d07c1f0ad3de 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -111,6 +111,8 @@
 
 /* bits unique to S1G beacon */
 #define IEEE80211_S1G_BCN_NEXT_TBTT	0x100
+#define IEEE80211_S1G_BCN_CSSID		0x200
+#define IEEE80211_S1G_BCN_ANO		0x400
 
 /* see 802.11ah-2016 9.9 NDP CMAC frames */
 #define IEEE80211_S1G_1MHZ_NDP_BITS	25
@@ -153,9 +155,6 @@
 
 #define IEEE80211_ANO_NETTYPE_WILD              15
 
-/* bits unique to S1G beacon */
-#define IEEE80211_S1G_BCN_NEXT_TBTT    0x100
-
 /* control extension - for IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTL_EXT */
 #define IEEE80211_CTL_EXT_POLL		0x2000
 #define IEEE80211_CTL_EXT_SPR		0x3000
@@ -627,6 +626,42 @@ static inline bool ieee80211_is_s1g_beacon(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON);
 }
 
+/**
+ * ieee80211_s1g_has_next_tbtt - check if IEEE80211_S1G_BCN_NEXT_TBTT
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame contains the variable-length
+ *	next TBTT field
+ */
+static inline bool ieee80211_s1g_has_next_tbtt(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT));
+}
+
+/**
+ * ieee80211_s1g_has_ano - check if IEEE80211_S1G_BCN_ANO
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame contains the variable-length
+ *	ANO field
+ */
+static inline bool ieee80211_s1g_has_ano(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_ANO));
+}
+
+/**
+ * ieee80211_s1g_has_cssid - check if IEEE80211_S1G_BCN_CSSID
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame contains the variable-length
+ *	compressed SSID field
+ */
+static inline bool ieee80211_s1g_has_cssid(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_CSSID));
+}
+
 /**
  * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
  * @fc: frame control bytes in little-endian byteorder
@@ -1245,16 +1280,40 @@ struct ieee80211_ext {
 			u8 change_seq;
 			u8 variable[0];
 		} __packed s1g_beacon;
-		struct {
-			u8 sa[ETH_ALEN];
-			__le32 timestamp;
-			u8 change_seq;
-			u8 next_tbtt[3];
-			u8 variable[0];
-		} __packed s1g_short_beacon;
 	} u;
 } __packed __aligned(2);
 
+/**
+ * ieee80211_s1g_optional_len - determine length of optional S1G beacon fields
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: total length in bytes of the optional fixed-length fields
+ *
+ * S1G beacons may contain up to three optional fixed-length fields that
+ * precede the variable-length elements. Whether these fields are present
+ * is indicated by flags in the frame control field.
+ *
+ * From IEEE 802.11-2024 section 9.3.4.3:
+ *  - Next TBTT field may be 0 or 3 bytes
+ *  - Short SSID field may be 0 or 4 bytes
+ *  - Access Network Options (ANO) field may be 0 or 1 byte
+ */
+static inline size_t
+ieee80211_s1g_optional_len(__le16 fc)
+{
+	size_t len = 0;
+
+	if (ieee80211_s1g_has_next_tbtt(fc))
+		len += 3;
+
+	if (ieee80211_s1g_has_cssid(fc))
+		len += 4;
+
+	if (ieee80211_s1g_has_ano(fc))
+		len += 1;
+
+	return len;
+}
+
 #define IEEE80211_TWT_CONTROL_NDP			BIT(0)
 #define IEEE80211_TWT_CONTROL_RESP_MODE			BIT(1)
 #define IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST	BIT(3)
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index efeca5bd7600..84b080591837 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -45,10 +45,7 @@ struct mdio_device {
 	unsigned int reset_deassert_delay;
 };
 
-static inline struct mdio_device *to_mdio_device(const struct device *dev)
-{
-	return container_of(dev, struct mdio_device, dev);
-}
+#define to_mdio_device(__dev)	container_of_const(__dev, struct mdio_device, dev)
 
 /* struct mdio_driver_common: Common to all MDIO drivers */
 struct mdio_driver_common {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d4b2c09cd5fe..da9749739abd 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -395,6 +395,7 @@ struct mlx5_core_rsc_common {
 	enum mlx5_res_type	res;
 	refcount_t		refcount;
 	struct completion	free;
+	bool			invalid;
 };
 
 struct mlx5_uars_page {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8617adc6becd..059ca4767e14 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4243,4 +4243,62 @@ static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
 }
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
+/*
+ * DMA mapping IDs for page_pool
+ *
+ * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
+ * stashes it in the upper bits of page->pp_magic. We always want to be able to
+ * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
+ * pages can have arbitrary kernel pointers stored in the same field as pp_magic
+ * (since it overlaps with page->lru.next), so we must ensure that we cannot
+ * mistake a valid kernel pointer with any of the values we write into this
+ * field.
+ *
+ * On architectures that set POISON_POINTER_DELTA, this is already ensured,
+ * since this value becomes part of PP_SIGNATURE; meaning we can just use the
+ * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
+ * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
+ * 0, we make sure that we leave the two topmost bits empty, as that guarantees
+ * we won't mistake a valid kernel pointer for a value we set, regardless of the
+ * VMSPLIT setting.
+ *
+ * Altogether, this means that the number of bits available is constrained by
+ * the size of an unsigned long (at the upper end, subtracting two bits per the
+ * above), and the definition of PP_SIGNATURE (with or without
+ * POISON_POINTER_DELTA).
+ */
+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
+#if POISON_POINTER_DELTA > 0
+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
+ * index to not overlap with that if set
+ */
+#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
+#else
+/* Always leave out the topmost two; see above. */
+#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+#endif
+
+#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
+				  PP_DMA_INDEX_SHIFT)
+
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page, as well as the
+ * bits used for the DMA index. page_is_pfmemalloc() is checked in
+ * __page_pool_put_page() to avoid recycling the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
+
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+#else
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1c101f6fad2f..84d4f0657b7a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1954,7 +1954,7 @@ enum {
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
-	NVME_SC_ONCS_NOT_SUPPORTED	= 0x183,
+	NVME_SC_CMD_SIZE_LIM_EXCEEDED	= 0x183,
 
 	/*
 	 * I/O Command Set Specific - Fabrics commands:
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..89e9d6049883 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -389,24 +389,37 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	struct_size((type *)NULL, member, count)
 
 /**
- * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
- * Enables caller macro to pass (different) initializer.
+ * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass arbitrary trailing expressions
  *
  * @type: structure type name, including "struct" keyword.
  * @name: Name for a variable to define.
  * @member: Name of the array member.
  * @count: Number of elements in the array; must be compile-time const.
- * @initializer: initializer expression (could be empty for no init).
+ * @trailer: Trailing expressions for attributes and/or initializers.
  */
-#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
+#define __DEFINE_FLEX(type, name, member, count, trailer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
 		       "onstack flex array members require compile-time const count"); \
 	union {									\
 		u8 bytes[struct_size_t(type, member, count)];			\
 		type obj;							\
-	} name##_u initializer;							\
+	} name##_u trailer;							\
 	type *name = (type *)&name##_u
 
+/**
+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass (different) initializer.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ * @initializer: Initializer expression (e.g., pass `= { }` at minimum).
+ */
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
+	__DEFINE_FLEX(type, name, member, count, = { .obj initializer })
+
 /**
  * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
  * flexible array member, when it does not have a __counted_by annotation.
@@ -421,7 +434,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Use __struct_size(@name) to get compile-time size of it afterwards.
  */
 #define DEFINE_RAW_FLEX(type, name, member, count)	\
-	_DEFINE_FLEX(type, name, member, count, = {})
+	__DEFINE_FLEX(type, name, member, count, = { })
 
 /**
  * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
@@ -438,6 +451,6 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Use __struct_size(@NAME) to get compile-time size of it afterwards.
  */
 #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
-	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .COUNTER = COUNT, })
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4..cd6f8f4bc454 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -114,6 +114,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @aligned_size: the size actually allocated to accommodate the iATU alignment
+ *                requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  */
@@ -121,6 +123,7 @@ struct pci_epf_bar {
 	dma_addr_t	phys_addr;
 	void		*addr;
 	size_t		size;
+	size_t		aligned_size;
 	enum pci_barno	barno;
 	int		flags;
 };
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 945264f457d8..dfc7b97f9648 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -792,10 +792,7 @@ struct phy_device {
 #define PHY_F_NO_IRQ		0x80000000
 #define PHY_F_RXC_ALWAYS_ON	0x40000000
 
-static inline struct phy_device *to_phy_device(const struct device *dev)
-{
-	return container_of(to_mdio_device(dev), struct phy_device, mdio);
-}
+#define to_phy_device(__dev)	container_of_const(to_mdio_device(__dev), struct phy_device, mdio)
 
 /**
  * struct phy_tdr_config - Configuration of a TDR raw test
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index cf4b11be3709..c6716f474ba4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -251,6 +251,7 @@ struct generic_pm_domain_data {
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
 	bool hw_mode;
+	bool rpm_always_on;
 	void *data;
 };
 
@@ -283,6 +284,7 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
 int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
 bool dev_pm_genpd_get_hwmode(struct device *dev);
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -366,6 +368,11 @@ static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
 	return false;
 }
 
+static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
+{
+	return -EOPNOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 331a9a996fa8..8ca2235f78d5 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -70,6 +70,10 @@
 #define KEY_DESTROY		0xbd
 
 /********** net/core/page_pool.c **********/
+/*
+ * page_pool uses additional free bits within this value to store data, see the
+ * definition of PP_DMA_INDEX_MASK in mm.h
+ */
 #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
 
 /********** net/core/skbuff.c **********/
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0387d64e2c66..36fb3edfa403 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -140,6 +140,7 @@ struct virtio_vsock_sock {
 	u32 last_fwd_cnt;
 	u32 rx_bytes;
 	u32 buf_alloc;
+	u32 buf_used;
 	struct sk_buff_head rx_queue;
 	u32 msg_count;
 };
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4f3b537476e1..e9e3366d059e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -538,6 +538,7 @@ struct hci_dev {
 	struct hci_conn_hash	conn_hash;
 
 	struct list_head	mesh_pending;
+	struct mutex		mgmt_pending_lock;
 	struct list_head	mgmt_pending;
 	struct list_head	reject_list;
 	struct list_head	accept_list;
@@ -2379,7 +2380,6 @@ void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
 void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
-void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle);
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
diff --git a/include/net/netfilter/nft_fib.h b/include/net/netfilter/nft_fib.h
index 6e202ed5e63f..7370fba844ef 100644
--- a/include/net/netfilter/nft_fib.h
+++ b/include/net/netfilter/nft_fib.h
@@ -2,6 +2,7 @@
 #ifndef _NFT_FIB_H_
 #define _NFT_FIB_H_
 
+#include <net/l3mdev.h>
 #include <net/netfilter/nf_tables.h>
 
 struct nft_fib {
@@ -39,6 +40,14 @@ static inline bool nft_fib_can_skip(const struct nft_pktinfo *pkt)
 	return nft_fib_is_loopback(pkt->skb, indev);
 }
 
+static inline int nft_fib_l3mdev_master_ifindex_rcu(const struct nft_pktinfo *pkt,
+						    const struct net_device *iif)
+{
+	const struct net_device *dev = iif ? iif : pkt->skb->dev;
+
+	return l3mdev_master_ifindex_rcu(dev);
+}
+
 int nft_fib_dump(struct sk_buff *skb, const struct nft_expr *expr, bool reset);
 int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		 const struct nlattr * const tb[]);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..f53e2c90b686 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <net/netmem.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
@@ -33,6 +34,9 @@
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
 				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
 
+/* Index limit to stay within PP_DMA_INDEX_BITS for DMA indices */
+#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
+
 /*
  * Fast allocation side cache array/stack
  *
@@ -216,6 +220,8 @@ struct page_pool {
 
 	void *mp_priv;
 
+	struct xarray dma_mapped;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/include/net/sock.h b/include/net/sock.h
index fa9b9dadbe17..b7270b6b9e9c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2942,8 +2942,11 @@ int sock_ioctl_inout(struct sock *sk, unsigned int cmd,
 int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 static inline bool sk_is_readable(struct sock *sk)
 {
-	if (sk->sk_prot->sock_is_readable)
-		return sk->sk_prot->sock_is_readable(sk);
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	if (prot->sock_is_readable)
+		return prot->sock_is_readable(sk);
+
 	return false;
 }
 #endif	/* _SOCK_H */
diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index b098ceadbe74..9a70048adbc0 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -223,7 +223,7 @@ struct hdac_driver {
 	struct device_driver driver;
 	int type;
 	const struct hda_device_id *id_table;
-	int (*match)(struct hdac_device *dev, struct hdac_driver *drv);
+	int (*match)(struct hdac_device *dev, const struct hdac_driver *drv);
 	void (*unsol_event)(struct hdac_device *dev, unsigned int event);
 
 	/* fields used by ext bus APIs */
@@ -235,7 +235,7 @@ struct hdac_driver {
 #define drv_to_hdac_driver(_drv) container_of(_drv, struct hdac_driver, driver)
 
 const struct hda_device_id *
-hdac_get_device_id(struct hdac_device *hdev, struct hdac_driver *drv);
+hdac_get_device_id(struct hdac_device *hdev, const struct hdac_driver *drv);
 
 /*
  * Bus verb operators
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index ecdbe473a49f..c6c624eb9866 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -146,18 +146,26 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
 
 	if (has_lock && (ctx->flags & IORING_SETUP_SQPOLL)) {
 		struct io_sq_data *sq = ctx->sq_data;
+		struct task_struct *tsk;
 
+		rcu_read_lock();
+		tsk = rcu_dereference(sq->thread);
 		/*
 		 * sq->thread might be NULL if we raced with the sqpoll
 		 * thread termination.
 		 */
-		if (sq->thread) {
+		if (tsk) {
+			get_task_struct(tsk);
+			rcu_read_unlock();
+			getrusage(tsk, RUSAGE_SELF, &sq_usage);
+			put_task_struct(tsk);
 			sq_pid = sq->task_pid;
 			sq_cpu = sq->sq_cpu;
-			getrusage(sq->thread, RUSAGE_SELF, &sq_usage);
 			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
 					 + sq_usage.ru_stime.tv_usec);
 			sq_work_time = sq->work_time;
+		} else {
+			rcu_read_unlock();
 		}
 	}
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index bd3b3f7a6f6c..64870f51b678 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2916,7 +2916,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 			struct task_struct *tsk;
 
 			io_sq_thread_park(sqd);
-			tsk = sqd->thread;
+			tsk = sqpoll_task_locked(sqd);
 			if (tsk && tsk->io_uring && tsk->io_uring->io_wq)
 				io_wq_cancel_cb(tsk->io_uring->io_wq,
 						io_cancel_ctx_cb, ctx, true);
@@ -3153,7 +3153,7 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 	s64 inflight;
 	DEFINE_WAIT(wait);
 
-	WARN_ON_ONCE(sqd && sqd->thread != current);
+	WARN_ON_ONCE(sqd && sqpoll_task_locked(sqd) != current);
 
 	if (!current->io_uring)
 		return;
diff --git a/io_uring/register.c b/io_uring/register.c
index eca26d4884d9..a325b493ae12 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -268,6 +268,8 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		sqd = ctx->sq_data;
 		if (sqd) {
+			struct task_struct *tsk;
+
 			/*
 			 * Observe the correct sqd->lock -> ctx->uring_lock
 			 * ordering. Fine to drop uring_lock here, we hold
@@ -277,8 +279,9 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 			mutex_unlock(&ctx->uring_lock);
 			mutex_lock(&sqd->lock);
 			mutex_lock(&ctx->uring_lock);
-			if (sqd->thread)
-				tctx = sqd->thread->io_uring;
+			tsk = sqpoll_task_locked(sqd);
+			if (tsk)
+				tctx = tsk->io_uring;
 		}
 	} else {
 		tctx = current->io_uring;
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 430922c54168..9a6306894895 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -30,7 +30,7 @@ enum {
 void io_sq_thread_unpark(struct io_sq_data *sqd)
 	__releases(&sqd->lock)
 {
-	WARN_ON_ONCE(sqd->thread == current);
+	WARN_ON_ONCE(sqpoll_task_locked(sqd) == current);
 
 	/*
 	 * Do the dance but not conditional clear_bit() because it'd race with
@@ -45,24 +45,32 @@ void io_sq_thread_unpark(struct io_sq_data *sqd)
 void io_sq_thread_park(struct io_sq_data *sqd)
 	__acquires(&sqd->lock)
 {
-	WARN_ON_ONCE(data_race(sqd->thread) == current);
+	struct task_struct *tsk;
 
 	atomic_inc(&sqd->park_pending);
 	set_bit(IO_SQ_THREAD_SHOULD_PARK, &sqd->state);
 	mutex_lock(&sqd->lock);
-	if (sqd->thread)
-		wake_up_process(sqd->thread);
+
+	tsk = sqpoll_task_locked(sqd);
+	if (tsk) {
+		WARN_ON_ONCE(tsk == current);
+		wake_up_process(tsk);
+	}
 }
 
 void io_sq_thread_stop(struct io_sq_data *sqd)
 {
-	WARN_ON_ONCE(sqd->thread == current);
+	struct task_struct *tsk;
+
 	WARN_ON_ONCE(test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state));
 
 	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
 	mutex_lock(&sqd->lock);
-	if (sqd->thread)
-		wake_up_process(sqd->thread);
+	tsk = sqpoll_task_locked(sqd);
+	if (tsk) {
+		WARN_ON_ONCE(tsk == current);
+		wake_up_process(tsk);
+	}
 	mutex_unlock(&sqd->lock);
 	wait_for_completion(&sqd->exited);
 }
@@ -277,7 +285,8 @@ static int io_sq_thread(void *data)
 	/* offload context creation failed, just exit */
 	if (!current->io_uring) {
 		mutex_lock(&sqd->lock);
-		sqd->thread = NULL;
+		rcu_assign_pointer(sqd->thread, NULL);
+		put_task_struct(current);
 		mutex_unlock(&sqd->lock);
 		goto err_out;
 	}
@@ -386,7 +395,8 @@ static int io_sq_thread(void *data)
 		io_sq_tw(&retry_list, UINT_MAX);
 
 	io_uring_cancel_generic(true, sqd);
-	sqd->thread = NULL;
+	rcu_assign_pointer(sqd->thread, NULL);
+	put_task_struct(current);
 	list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
 		atomic_or(IORING_SQ_NEED_WAKEUP, &ctx->rings->sq_flags);
 	io_run_task_work();
@@ -496,7 +506,10 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 			goto err_sqpoll;
 		}
 
-		sqd->thread = tsk;
+		mutex_lock(&sqd->lock);
+		rcu_assign_pointer(sqd->thread, tsk);
+		mutex_unlock(&sqd->lock);
+
 		task_to_put = get_task_struct(tsk);
 		ret = io_uring_alloc_task_context(tsk, ctx);
 		wake_up_new_task(tsk);
@@ -507,9 +520,6 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		ret = -EINVAL;
 		goto err;
 	}
-
-	if (task_to_put)
-		put_task_struct(task_to_put);
 	return 0;
 err_sqpoll:
 	complete(&ctx->sq_data->exited);
@@ -527,10 +537,13 @@ __cold int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx,
 	int ret = -EINVAL;
 
 	if (sqd) {
+		struct task_struct *tsk;
+
 		io_sq_thread_park(sqd);
 		/* Don't set affinity for a dying thread */
-		if (sqd->thread)
-			ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
+		tsk = sqpoll_task_locked(sqd);
+		if (tsk)
+			ret = io_wq_cpu_affinity(tsk->io_uring, mask);
 		io_sq_thread_unpark(sqd);
 	}
 
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index 4171666b1cf4..b83dcdec9765 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -8,7 +8,7 @@ struct io_sq_data {
 	/* ctx's that are using this sqd */
 	struct list_head	ctx_list;
 
-	struct task_struct	*thread;
+	struct task_struct __rcu *thread;
 	struct wait_queue_head	wait;
 
 	unsigned		sq_thread_idle;
@@ -29,3 +29,9 @@ void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 void io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
 int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);
+
+static inline struct task_struct *sqpoll_task_locked(struct io_sq_data *sqd)
+{
+	return rcu_dereference_protected(sqd->thread,
+					 lockdep_is_held(&sqd->lock));
+}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a60a6a2ce0d7..68a327158989 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2303,8 +2303,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 	return 0;
 }
 
-bool bpf_prog_map_compatible(struct bpf_map *map,
-			     const struct bpf_prog *fp)
+static bool __bpf_prog_map_compatible(struct bpf_map *map,
+				      const struct bpf_prog *fp)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
@@ -2313,14 +2313,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	if (fp->kprobe_override)
 		return false;
 
-	/* XDP programs inserted into maps are not guaranteed to run on
-	 * a particular netdev (and can run outside driver context entirely
-	 * in the case of devmap and cpumap). Until device checks
-	 * are implemented, prohibit adding dev-bound programs to program maps.
-	 */
-	if (bpf_prog_is_dev_bound(aux))
-		return false;
-
 	spin_lock(&map->owner.lock);
 	if (!map->owner.type) {
 		/* There's no owner yet where we could check for
@@ -2354,6 +2346,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	return ret;
 }
 
+bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
+{
+	/* XDP programs inserted into maps are not guaranteed to run on
+	 * a particular netdev (and can run outside driver context entirely
+	 * in the case of devmap and cpumap). Until device checks
+	 * are implemented, prohibit adding dev-bound programs to program maps.
+	 */
+	if (bpf_prog_is_dev_bound(fp->aux))
+		return false;
+
+	return __bpf_prog_map_compatible(map, fp);
+}
+
 static int bpf_check_tail_call(const struct bpf_prog *fp)
 {
 	struct bpf_prog_aux *aux = fp->aux;
@@ -2366,7 +2371,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 		if (!map_type_contains_progs(map))
 			continue;
 
-		if (!bpf_prog_map_compatible(map, fp)) {
+		if (!__bpf_prog_map_compatible(map, fp)) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2414,7 +2419,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = false;
+	bool jit_needed = fp->jit_requested;
 
 	if (fp->bpf_func)
 		goto finalize;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 285a4548450b..9ce82904f761 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6031,6 +6031,9 @@ static int perf_event_set_output(struct perf_event *event,
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -6099,7 +6102,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 
-		err = perf_event_set_bpf_prog(event, prog, 0);
+		err = __perf_event_set_bpf_prog(event, prog, 0);
 		if (err) {
 			bpf_prog_put(prog);
 			return err;
@@ -9715,14 +9718,14 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle &&
-			     hwc->interrupts > max_samples_per_tick)) {
-			__this_cpu_inc(perf_throttled_count);
-			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
-			hwc->interrupts = MAX_INTERRUPTS;
-			perf_log_throttle(event, 0);
-			ret = 1;
-		}
+	}
+
+	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
+		__this_cpu_inc(perf_throttled_count);
+		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
+		hwc->interrupts = MAX_INTERRUPTS;
+		perf_log_throttle(event, 0);
+		ret = 1;
 	}
 
 	if (event->attr.freq) {
@@ -10756,8 +10759,9 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 	return false;
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
-			    u64 bpf_cookie)
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie)
 {
 	bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
 
@@ -10795,6 +10799,20 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 	return perf_event_attach_bpf_prog(event, prog, bpf_cookie);
 }
 
+int perf_event_set_bpf_prog(struct perf_event *event,
+			    struct bpf_prog *prog,
+			    u64 bpf_cookie)
+{
+	struct perf_event_context *ctx;
+	int ret;
+
+	ctx = perf_event_ctx_lock(event);
+	ret = __perf_event_set_bpf_prog(event, prog, bpf_cookie);
+	perf_event_ctx_unlock(event, ctx);
+
+	return ret;
+}
+
 void perf_event_free_bpf_prog(struct perf_event *event)
 {
 	if (!perf_event_is_tracing(event)) {
@@ -10814,7 +10832,15 @@ static void perf_event_free_filter(struct perf_event *event)
 {
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie)
+{
+	return -ENOENT;
+}
+
+int perf_event_set_bpf_prog(struct perf_event *event,
+			    struct bpf_prog *prog,
 			    u64 bpf_cookie)
 {
 	return -ENOENT;
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 4e1778071d70..1c9fe741fe6d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	unsigned long prev_cost = ULONG_MAX;
 	int i, ret;
 
+	/* This is needed only for CPUs and EAS skip other devices */
+	if (!_is_cpu_device(dev))
+		return 0;
+
 	/* Compute the cost of each performance state. */
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d8bad1eeedd3..85008ead2ac9 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -89,6 +89,11 @@ void hibernate_release(void)
 	atomic_inc(&hibernate_atomic);
 }
 
+bool hibernation_in_progress(void)
+{
+	return !atomic_read(&hibernate_atomic);
+}
+
 bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..0622e7dacf17 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -613,7 +613,8 @@ bool pm_debug_messages_on __read_mostly;
 
 bool pm_debug_messages_should_print(void)
 {
-	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
+	return pm_debug_messages_on && (hibernation_in_progress() ||
+		pm_suspend_target_state != PM_SUSPEND_ON);
 }
 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index de0e6b1077f2..6d1ec7b23e84 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -71,10 +71,14 @@ extern void enable_restore_image_protection(void);
 static inline void enable_restore_image_protection(void) {}
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
+extern bool hibernation_in_progress(void);
+
 #else /* !CONFIG_HIBERNATION */
 
 static inline void hibernate_reserved_size_init(void) {}
 static inline void hibernate_image_size_init(void) {}
+
+static inline bool hibernation_in_progress(void) { return false; }
 #endif /* !CONFIG_HIBERNATION */
 
 #define power_attr(_name) \
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 52571dcad768..4e941999a53b 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -49,6 +49,9 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
 			len += sysfs_emit_at(buf, len, "%s ", wl->name);
 	}
 
+	if (len > 0)
+		--len;
+
 	len += sysfs_emit_at(buf, len, "\n");
 
 	mutex_unlock(&wakelocks_lock);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4ed863219521..cefa831c8cb3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -802,6 +802,10 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
 	return 0;
 }
 
+#ifndef arch_irq_stat_cpu
+#define arch_irq_stat_cpu(cpu) 0
+#endif
+
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
@@ -937,9 +941,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
 			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
 			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
-			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
-			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
-			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
+			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
+			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
+			rsrp->nr_csw = nr_context_switches_cpu(cpu);
 			rsrp->jiffies = jiffies;
 			rsrp->gp_seq = rdp->gp_seq;
 		}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..1bba2225e744 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -168,7 +168,7 @@ struct rcu_snap_record {
 	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
 	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
 	u64		cputime_system; /* Accumulated cputime of kernel tasks */
-	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
+	u64		nr_hardirqs;	/* Accumulated number of hard irqs */
 	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
 	unsigned long long nr_csw;	/* Accumulated number of task switches */
 	unsigned long   jiffies;	/* Track jiffies value */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4432db6d0b99..4d524a2212a8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -457,8 +457,8 @@ static void print_cpu_stat_info(int cpu)
 	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
-	pr_err("\t number: %8ld %10d %12lld\n",
-		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
+	pr_err("\t number: %8lld %10d %12lld\n",
+		kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu) - rsrp->nr_hardirqs,
 		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
 		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
 	pr_err("\tcputime: %8lld %10lld %12lld   ==> %d(ms)\n",
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9bb1b4c5842..51f36de5990a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2229,6 +2229,12 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * just go back and repeat.
 		 */
 		rq = task_rq_lock(p, &rf);
+		/*
+		 * If task is sched_delayed, force dequeue it, to avoid always
+		 * hitting the tick timeout in the queued case
+		 */
+		if (p->se.sched_delayed)
+			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		trace_sched_wait_task(p);
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
@@ -6517,12 +6523,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Otherwise marks the task's __state as RUNNING
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long task_state)
+			      unsigned long *task_state_p)
 {
+	unsigned long task_state = *task_state_p;
 	int flags = DEQUEUE_NOCLOCK;
 
 	if (signal_pending_state(task_state, p)) {
 		WRITE_ONCE(p->__state, TASK_RUNNING);
+		*task_state_p = TASK_RUNNING;
 		return false;
 	}
 
@@ -6656,7 +6664,7 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		try_to_block_task(rq, prev, prev_state);
+		try_to_block_task(rq, prev, &prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 6bcee4704059..d44641108ba8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1400,6 +1400,15 @@ void run_posix_cpu_timers(void)
 
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * Ensure that release_task(tsk) can't happen while
+	 * handle_posix_cpu_timers() is running. Otherwise, a concurrent
+	 * posix_cpu_timer_del() may fail to lock_task_sighand(tsk) and
+	 * miss timer->it.cpu.firing != 0.
+	 */
+	if (tsk->exit_state)
+		return;
+
 	/*
 	 * If the actual expiry is deferred to task work context and the
 	 * work is already scheduled there is no point to do anything here.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e5c063fc8ef9..3ec7df7dbeec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1828,7 +1828,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
 	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
 	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(tp_regs->regs))) {
+	if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
 		this_cpu_dec(bpf_raw_tp_nest_level);
 		return ERR_PTR(-EBUSY);
 	}
@@ -2932,6 +2932,9 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
+	if (attr->link_create.flags)
+		return -EINVAL;
+
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
@@ -3346,7 +3349,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	if (pid) {
+		rcu_read_lock();
 		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
+		rcu_read_unlock();
 		if (!task) {
 			err = -ESRCH;
 			goto error_path_put;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index baa5547e977a..6ab740d3185b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2796,6 +2796,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	if (nr_pages < 2)
 		nr_pages = 2;
 
+	/*
+	 * Keep CPUs from coming online while resizing to synchronize
+	 * with new per CPU buffers being created.
+	 */
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 	atomic_inc(&buffer->resizing);
@@ -2840,7 +2846,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			cond_resched();
 		}
 
-		cpus_read_lock();
 		/*
 		 * Fire off all the required work handlers
 		 * We can't schedule on offline CPUs, but it's not necessary
@@ -2880,7 +2885,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			cpu_buffer->nr_pages_to_update = 0;
 		}
 
-		cpus_read_unlock();
 	} else {
 		cpu_buffer = buffer->buffers[cpu_id];
 
@@ -2908,8 +2912,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			goto out_err;
 		}
 
-		cpus_read_lock();
-
 		/* Can't run something on an offline CPU. */
 		if (!cpu_online(cpu_id))
 			rb_update_pages(cpu_buffer);
@@ -2928,7 +2930,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		}
 
 		cpu_buffer->nr_pages_to_update = 0;
-		cpus_read_unlock();
 	}
 
  out:
@@ -6754,7 +6755,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	old_size = buffer->subbuf_size;
 
 	/* prevent another thread from changing buffer sizes */
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
@@ -6859,7 +6860,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
 
 	return 0;
 
@@ -6868,7 +6868,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	buffer->subbuf_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
 
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
@@ -7274,8 +7273,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
-		if (missed_events) {
+	if (missed_events) {
+		if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
 			struct buffer_data_page *bpage = reader->page;
 			unsigned int commit;
 			/*
@@ -7296,13 +7295,23 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 				local_add(RB_MISSED_STORED, &bpage->commit);
 			}
 			local_add(RB_MISSED_EVENTS, &bpage->commit);
+		} else if (!WARN_ONCE(cpu_buffer->reader_page == cpu_buffer->tail_page,
+				      "Reader on commit with %ld missed events",
+				      missed_events)) {
+			/*
+			 * There shouldn't be any missed events if the tail_page
+			 * is on the reader page. But if the tail page is not on the
+			 * reader page and the commit_page is, that would mean that
+			 * there's a commit_overrun (an interrupt preempted an
+			 * addition of an event and then filled the buffer
+			 * with new events). In this case it's not an
+			 * error, but it should still be reported.
+			 *
+			 * TODO: Add missed events to the page for user space to know.
+			 */
+			pr_info("Ring buffer [%d] commit overrun lost %ld events at timestamp:%lld\n",
+				cpu, missed_events, cpu_buffer->reader_page->page->time_stamp);
 		}
-	} else {
-		/*
-		 * There really shouldn't be any missed events if the commit
-		 * is on the reader page.
-		 */
-		WARN_ON_ONCE(missed_events);
 	}
 
 	cpu_buffer->lost_events = 0;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 82da3ac14024..57e1af1d3e6d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1731,6 +1731,9 @@ extern int event_enable_register_trigger(char *glob,
 extern void event_enable_unregister_trigger(char *glob,
 					    struct event_trigger_data *test,
 					    struct trace_event_file *file);
+extern struct event_trigger_data *
+trigger_data_alloc(struct event_command *cmd_ops, char *cmd, char *param,
+		   void *private_data);
 extern void trigger_data_free(struct event_trigger_data *data);
 extern int event_trigger_init(struct event_trigger_data *data);
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
@@ -1757,11 +1760,6 @@ extern bool event_trigger_check_remove(const char *glob);
 extern bool event_trigger_empty_param(const char *param);
 extern int event_trigger_separate_filter(char *param_and_filter, char **param,
 					 char **filter, bool param_required);
-extern struct event_trigger_data *
-event_trigger_alloc(struct event_command *cmd_ops,
-		    char *cmd,
-		    char *param,
-		    void *private_data);
 extern int event_trigger_parse_num(char *trigger,
 				   struct event_trigger_data *trigger_data);
 extern int event_trigger_set_filter(struct event_command *cmd_ops,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4ebafc655223..3379e14d38e9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5249,17 +5249,94 @@ hist_trigger_actions(struct hist_trigger_data *hist_data,
 	}
 }
 
+/*
+ * The hist_pad structure is used to save information to create
+ * a histogram from the histogram trigger. It's too big to store
+ * on the stack, so when the histogram trigger is initialized
+ * a percpu array of 4 hist_pad structures is allocated.
+ * This will cover every context from normal, softirq, irq and NMI
+ * in the very unlikely event that a tigger happens at each of
+ * these contexts and interrupts a currently active trigger.
+ */
+struct hist_pad {
+	unsigned long		entries[HIST_STACKTRACE_DEPTH];
+	u64			var_ref_vals[TRACING_MAP_VARS_MAX];
+	char			compound_key[HIST_KEY_SIZE_MAX];
+};
+
+static struct hist_pad __percpu *hist_pads;
+static DEFINE_PER_CPU(int, hist_pad_cnt);
+static refcount_t hist_pad_ref;
+
+/* One hist_pad for every context (normal, softirq, irq, NMI) */
+#define MAX_HIST_CNT 4
+
+static int alloc_hist_pad(void)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (refcount_read(&hist_pad_ref)) {
+		refcount_inc(&hist_pad_ref);
+		return 0;
+	}
+
+	hist_pads = __alloc_percpu(sizeof(struct hist_pad) * MAX_HIST_CNT,
+				   __alignof__(struct hist_pad));
+	if (!hist_pads)
+		return -ENOMEM;
+
+	refcount_set(&hist_pad_ref, 1);
+	return 0;
+}
+
+static void free_hist_pad(void)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (!refcount_dec_and_test(&hist_pad_ref))
+		return;
+
+	free_percpu(hist_pads);
+	hist_pads = NULL;
+}
+
+static struct hist_pad *get_hist_pad(void)
+{
+	struct hist_pad *hist_pad;
+	int cnt;
+
+	if (WARN_ON_ONCE(!hist_pads))
+		return NULL;
+
+	preempt_disable();
+
+	hist_pad = per_cpu_ptr(hist_pads, smp_processor_id());
+
+	if (this_cpu_read(hist_pad_cnt) == MAX_HIST_CNT) {
+		preempt_enable();
+		return NULL;
+	}
+
+	cnt = this_cpu_inc_return(hist_pad_cnt) - 1;
+
+	return &hist_pad[cnt];
+}
+
+static void put_hist_pad(void)
+{
+	this_cpu_dec(hist_pad_cnt);
+	preempt_enable();
+}
+
 static void event_hist_trigger(struct event_trigger_data *data,
 			       struct trace_buffer *buffer, void *rec,
 			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
-	unsigned long entries[HIST_STACKTRACE_DEPTH];
-	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
-	char compound_key[HIST_KEY_SIZE_MAX];
 	struct tracing_map_elt *elt = NULL;
 	struct hist_field *key_field;
+	struct hist_pad *hist_pad;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -5267,12 +5344,18 @@ static void event_hist_trigger(struct event_trigger_data *data,
 	if (unlikely(!rbe))
 		return;
 
-	memset(compound_key, 0, hist_data->key_size);
+	hist_pad = get_hist_pad();
+	if (!hist_pad)
+		return;
+
+	memset(hist_pad->compound_key, 0, hist_data->key_size);
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
+			unsigned long *entries = hist_pad->entries;
+
 			memset(entries, 0, HIST_STACKTRACE_SIZE);
 			if (key_field->field) {
 				unsigned long *stack, n_entries;
@@ -5296,26 +5379,31 @@ static void event_hist_trigger(struct event_trigger_data *data,
 		}
 
 		if (use_compound_key)
-			add_to_key(compound_key, key, key_field, rec);
+			add_to_key(hist_pad->compound_key, key, key_field, rec);
 	}
 
 	if (use_compound_key)
-		key = compound_key;
+		key = hist_pad->compound_key;
 
 	if (hist_data->n_var_refs &&
-	    !resolve_var_refs(hist_data, key, var_ref_vals, false))
-		return;
+	    !resolve_var_refs(hist_data, key, hist_pad->var_ref_vals, false))
+		goto out;
 
 	elt = tracing_map_insert(hist_data->map, key);
 	if (!elt)
-		return;
+		goto out;
 
-	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, var_ref_vals);
+	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, hist_pad->var_ref_vals);
 
-	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+	if (resolve_var_refs(hist_data, key, hist_pad->var_ref_vals, true)) {
+		hist_trigger_actions(hist_data, elt, buffer, rec, rbe,
+				     key, hist_pad->var_ref_vals);
+	}
 
 	hist_poll_wakeup();
+
+ out:
+	put_hist_pad();
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -6160,6 +6248,9 @@ static int event_hist_trigger_init(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
+	if (alloc_hist_pad() < 0)
+		return -ENOMEM;
+
 	if (!data->ref && hist_data->attrs->name)
 		save_named_trigger(hist_data->attrs->name, data);
 
@@ -6204,6 +6295,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 
 		destroy_hist_data(hist_data);
 	}
+	free_hist_pad();
 }
 
 static struct event_trigger_ops event_hist_trigger_ops = {
@@ -6219,9 +6311,7 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
 
 	save_named_trigger(data->named_data->name, data);
 
-	event_hist_trigger_init(data->named_data);
-
-	return 0;
+	return event_hist_trigger_init(data->named_data);
 }
 
 static void event_hist_trigger_named_free(struct event_trigger_data *data)
@@ -6708,7 +6798,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		return PTR_ERR(hist_data);
 	}
 
-	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, hist_data);
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, hist_data);
 	if (!trigger_data) {
 		ret = -ENOMEM;
 		goto out_free;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 27e21488d574..d5dbda9b0e4b 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -825,7 +825,7 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 }
 
 /**
- * event_trigger_alloc - allocate and init event_trigger_data for a trigger
+ * trigger_data_alloc - allocate and init event_trigger_data for a trigger
  * @cmd_ops: The event_command operations for the trigger
  * @cmd: The cmd string
  * @param: The param string
@@ -836,14 +836,14 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
  * trigger_ops to assign to the event_trigger_data.  @private_data can
  * also be passed in and associated with the event_trigger_data.
  *
- * Use event_trigger_free() to free an event_trigger_data object.
+ * Use trigger_data_free() to free an event_trigger_data object.
  *
  * Return: The trigger_data object success, NULL otherwise
  */
-struct event_trigger_data *event_trigger_alloc(struct event_command *cmd_ops,
-					       char *cmd,
-					       char *param,
-					       void *private_data)
+struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
+					      char *cmd,
+					      char *param,
+					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
@@ -1010,13 +1010,13 @@ event_trigger_parse(struct event_command *cmd_ops,
 		return ret;
 
 	ret = -ENOMEM;
-	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, file);
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, file);
 	if (!trigger_data)
 		goto out;
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		kfree(trigger_data);
+		trigger_data_free(trigger_data);
 		ret = 0;
 		goto out;
 	}
@@ -1043,7 +1043,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
-	kfree(trigger_data);
+	trigger_data_free(trigger_data);
 	goto out;
 }
 
@@ -1814,7 +1814,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->enable = enable;
 	enable_data->file = event_enable_file;
 
-	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, enable_data);
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
 	if (!trigger_data) {
 		kfree(enable_data);
 		goto out;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bdb37d572e97..8ede6be556a9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -820,7 +820,7 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
 	size_t size = i->count;
 
 	do {
-		size_t len = bvec->bv_len;
+		size_t len = bvec->bv_len - skip;
 
 		if (len > size)
 			len = size;
diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
index 92b2cccd5e76..484fd85251b4 100644
--- a/lib/kunit/static_stub.c
+++ b/lib/kunit/static_stub.c
@@ -96,7 +96,7 @@ void __kunit_activate_static_stub(struct kunit *test,
 
 	/* If the replacement address is NULL, deactivate the stub. */
 	if (!replacement_addr) {
-		kunit_deactivate_static_stub(test, replacement_addr);
+		kunit_deactivate_static_stub(test, real_fn_addr);
 		return;
 	}
 
diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
index 77fa00a13df7..80f8abe10968 100644
--- a/lib/usercopy_kunit.c
+++ b/lib/usercopy_kunit.c
@@ -27,6 +27,7 @@
 			    !defined(CONFIG_MICROBLAZE) &&	\
 			    !defined(CONFIG_NIOS2) &&		\
 			    !defined(CONFIG_PPC32) &&		\
+			    !defined(CONFIG_SPARC32) &&		\
 			    !defined(CONFIG_SUPERH))
 # define TEST_U64
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 882903f42300..752576749db9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -872,9 +872,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -901,10 +899,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-#ifdef CONFIG_PAGE_POOL
-	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
+	if (unlikely(page_pool_page_is_pp(page)))
 		bad_reason = "page_pool leak";
-#endif
 	return bad_reason;
 }
 
diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 1bc51e2b05a3..3f72111ba651 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -242,7 +242,7 @@ u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 {
 	struct adv_info *adv = NULL;
 	u8 ad_len = 0, flags = 0;
@@ -286,7 +286,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		/* If flags would still be empty, then there is no need to
 		 * include the "Flags" AD field".
 		 */
-		if (flags) {
+		if (flags && (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_FLAGS;
 			ptr[2] = flags;
@@ -316,7 +316,8 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 
 		/* Provide Tx Power only if we can provide a valid value for it */
-		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+		if (adv_tx_power != HCI_TX_POWER_INVALID &&
+		    (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_TX_POWER;
 			ptr[2] = (u8)adv_tx_power;
@@ -366,17 +367,19 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 {
-	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, len))) {
+	size_t dlen;
+
+	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, &dlen))) {
 		u16 value = get_unaligned_le16(eir);
 
 		if (uuid == value) {
 			if (len)
-				*len -= 2;
+				*len = dlen - 2;
 			return &eir[2];
 		}
 
-		eir += *len;
-		eir_len -= *len;
+		eir += dlen;
+		eir_len -= dlen;
 	}
 
 	return NULL;
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index 5c89a05e8b29..9372db83f912 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -9,7 +9,7 @@
 
 void eir_create(struct hci_dev *hdev, u8 *data);
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
 u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
 u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ae66fa0a5fb5..c6c1232db4e2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2067,6 +2067,8 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 
+	bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
+
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
 	if (IS_ERR(conn))
 		return conn;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 72439764186e..0d3816c80758 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1877,10 +1877,8 @@ void hci_free_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	if (monitor->handle)
 		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 
-	if (monitor->state != ADV_MONITOR_STATE_NOT_REGISTERED) {
+	if (monitor->state != ADV_MONITOR_STATE_NOT_REGISTERED)
 		hdev->adv_monitors_cnt--;
-		mgmt_adv_monitor_removed(hdev, monitor->handle);
-	}
 
 	kfree(monitor);
 }
@@ -2507,6 +2505,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
+	mutex_init(&hdev->mgmt_pending_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -3416,23 +3415,18 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 
 	bt_dev_err(hdev, "link tx timeout");
 
-	rcu_read_lock();
+	hci_dev_lock(hdev);
 
 	/* Kill stalled connections */
-	list_for_each_entry_rcu(c, &h->list, list) {
+	list_for_each_entry(c, &h->list, list) {
 		if (c->type == type && c->sent) {
 			bt_dev_err(hdev, "killing stalled connection %pMR",
 				   &c->dst);
-			/* hci_disconnect might sleep, so, we have to release
-			 * the RCU read lock before calling it.
-			 */
-			rcu_read_unlock();
 			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
-			rcu_read_lock();
 		}
 	}
 
-	rcu_read_unlock();
+	hci_dev_unlock(hdev);
 }
 
 static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
@@ -4071,10 +4065,13 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	err = hci_send_frame(hdev, skb);
-	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, -err);
-		return;
+	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
+		err = hci_send_frame(hdev, skb);
+		if (err < 0) {
+			hci_cmd_sync_cancel_sync(hdev, -err);
+			return;
+		}
+		atomic_dec(&hdev->cmd_cnt);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4082,8 +4079,6 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
-
-	atomic_dec(&hdev->cmd_cnt);
 }
 
 static void hci_cmd_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 889463340351..5c4c3d04d8b9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6333,6 +6333,17 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 			info->secondary_phy &= 0x1f;
 		}
 
+		/* Check if PA Sync is pending and if the hci_conn SID has not
+		 * been set update it.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+			if (conn && conn->sid == HCI_SID_INVALID)
+				conn->sid = info->sid;
+		}
+
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
@@ -7136,7 +7147,8 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 
 	/* Only match event if command OGF is for LE */
 	if (hdev->req_skb &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
+	   (hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 ||
+	    hci_skb_opcode(hdev->req_skb) == HCI_OP_NOP) &&
 	    hci_skb_event(hdev->req_skb) == ev->subevent) {
 		*opcode = hci_skb_opcode(hdev->req_skb);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
@@ -7492,8 +7504,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->recv_event);
 	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+	hci_dev_unlock(hdev);
 
 	event = hdr->evt;
 	if (!event) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6597936fbd51..a00316d79dbf 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1559,7 +1559,8 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 {
 	u8 bid[3];
-	u8 ad[4 + 3];
+	u8 ad[HCI_MAX_EXT_AD_LENGTH];
+	u8 len;
 
 	/* Skip if NULL adv as instance 0x00 is used for general purpose
 	 * advertising so it cannot used for the likes of Broadcast Announcement
@@ -1585,8 +1586,10 @@ static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 
 	/* Generate Broadcast ID */
 	get_random_bytes(bid, sizeof(bid));
-	eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
-	hci_set_adv_instance_data(hdev, adv->instance, sizeof(ad), ad, 0, NULL);
+	len = eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
+	memcpy(ad + len, adv->adv_data, adv->adv_data_len);
+	hci_set_adv_instance_data(hdev, adv->instance, len + adv->adv_data_len,
+				  ad, 0, NULL);
 
 	return hci_update_adv_data_sync(hdev, adv->instance);
 }
@@ -1603,8 +1606,15 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
-		/* Create an instance if that could not be found */
-		if (!adv) {
+		if (adv) {
+			/* Turn it into periodic advertising */
+			adv->periodic = true;
+			adv->per_adv_data_len = data_len;
+			if (data)
+				memcpy(adv->per_adv_data, data, data_len);
+			adv->flags = flags;
+		} else if (!adv) {
+			/* Create an instance if that could not be found */
 			adv = hci_add_per_instance(hdev, instance, flags,
 						   data_len, data,
 						   sync_interval,
@@ -1836,7 +1846,8 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 			return 0;
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu->data);
+	len = eir_create_adv_data(hdev, instance, pdu->data,
+				  HCI_MAX_EXT_AD_LENGTH);
 
 	pdu->length = len;
 	pdu->handle = adv ? adv->handle : instance;
@@ -1867,7 +1878,7 @@ static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = eir_create_adv_data(hdev, instance, cp.data);
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
@@ -6890,20 +6901,37 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct hci_conn *conn = data;
+	struct hci_conn *pa_sync;
+
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (!err)
+	if (err == -ECANCELED)
 		return;
 
+	hci_dev_lock(hdev);
+
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
-	if (err == -ECANCELED)
-		return;
+	if (!hci_conn_valid(hdev, conn))
+		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
-	hci_dev_lock(hdev);
+	if (!err)
+		goto unlock;
 
-	hci_update_passive_scan_sync(hdev);
+	/* Add connection to indicate PA sync error */
+	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
 
+	if (IS_ERR(pa_sync))
+		goto unlock;
+
+	set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
+
+	/* Notify iso layer */
+	hci_connect_cfm(pa_sync, bt_status(err));
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6917,9 +6945,23 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
+	if (conn->sync_handle != HCI_SYNC_HANDLE_INVALID)
+		return -EINVAL;
+
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
 		return -EBUSY;
 
+	/* Stop scanning if SID has not been set and active scanning is enabled
+	 * so we use passive scanning which will be scanning using the allow
+	 * list programmed to contain only the connection address.
+	 */
+	if (conn->sid == HCI_SID_INVALID &&
+	    hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+		hci_scan_disable_sync(hdev);
+		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	}
+
 	/* Mark HCI_CONN_CREATE_PA_SYNC so hci_update_passive_scan_sync can
 	 * program the address in the allow list so PA advertisements can be
 	 * received.
@@ -6928,6 +6970,14 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
+	 * it.
+	 */
+	if (conn->sid == HCI_SID_INVALID)
+		__hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					 HCI_EV_LE_EXT_ADV_REPORT,
+					 conn->conn_timeout, NULL);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.options = qos->bcast.options;
 	cp.sid = conn->sid;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 72bf9b1db224..a08a0f3d5003 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -938,7 +938,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
 
-	if (sa->iso_bc->bc_sid > 0x0f)
+	if (sa->iso_bc->bc_sid > 0x0f && sa->iso_bc->bc_sid != HCI_SID_INVALID)
 		return -EINVAL;
 
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
@@ -1963,6 +1963,9 @@ static bool iso_match_sid(struct sock *sk, void *data)
 {
 	struct hci_ev_le_pa_sync_established *ev = data;
 
+	if (iso_pi(sk)->bc_sid == HCI_SID_INVALID)
+		return true;
+
 	return ev->sid == iso_pi(sk)->bc_sid;
 }
 
@@ -2009,8 +2012,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (ev1) {
 		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
-		if (sk && !ev1->status)
+		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
+			iso_pi(sk)->bc_sid = ev1->sid;
+		}
 
 		goto done;
 	}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 66fa5d6fea6c..a40534bf9084 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4835,7 +4835,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
-		result = L2CAP_CR_LE_AUTHENTICATION;
+		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
+			L2CAP_CR_LE_ENCRYPTION : L2CAP_CR_LE_AUTHENTICATION;
 		chan = NULL;
 		goto response_unlock;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d4700f940e8a..7664e7ba372c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1440,22 +1440,17 @@ static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
 
-	list_del(&cmd->list);
-
 	if (match->sk == NULL) {
 		match->sk = cmd->sk;
 		sock_hold(match->sk);
 	}
-
-	mgmt_pending_free(cmd);
 }
 
 static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	u8 *status = data;
 
-	mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
-	mgmt_pending_remove(cmd);
+	mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, *status);
 }
 
 static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
@@ -1469,8 +1464,6 @@ static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 	if (cmd->cmd_complete) {
 		cmd->cmd_complete(cmd, match->mgmt_status);
-		mgmt_pending_remove(cmd);
-
 		return;
 	}
 
@@ -1479,13 +1472,13 @@ static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 static int generic_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
-	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+	return mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status,
 				 cmd->param, cmd->param_len);
 }
 
 static int addr_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 {
-	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+	return mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status,
 				 cmd->param, sizeof(struct mgmt_addr_info));
 }
 
@@ -1525,7 +1518,7 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 
 	if (err) {
 		u8 mgmt_err = mgmt_status(err);
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 		goto done;
 	}
@@ -1700,7 +1693,7 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 
 	if (err) {
 		u8 mgmt_err = mgmt_status(err);
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
 		goto done;
 	}
 
@@ -1936,8 +1929,8 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 			new_settings(hdev, NULL);
 		}
 
-		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, cmd_status_rsp,
-				     &mgmt_err);
+		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true,
+				     cmd_status_rsp, &mgmt_err);
 		return;
 	}
 
@@ -1947,7 +1940,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true, settings_rsp, &match);
 
 	if (changed)
 		new_settings(hdev, match.sk);
@@ -2067,12 +2060,12 @@ static void set_le_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
-							&status);
+		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, cmd_status_rsp,
+				     &status);
 		return;
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
 
@@ -2131,7 +2124,7 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	struct sock *sk = cmd->sk;
 
 	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
+		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
 				     cmd_status_rsp, &status);
 		return;
 	}
@@ -2572,7 +2565,7 @@ static void mgmt_class_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 			  mgmt_status(err), hdev->dev_class, 3);
 
 	mgmt_pending_free(cmd);
@@ -3360,7 +3353,7 @@ static int pairing_complete(struct mgmt_pending_cmd *cmd, u8 status)
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
-	err = mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE,
+	err = mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_PAIR_DEVICE,
 				status, &rp, sizeof(rp));
 
 	/* So we don't get further callbacks for this connection */
@@ -5172,24 +5165,14 @@ static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
-void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle)
+static void mgmt_adv_monitor_removed(struct sock *sk, struct hci_dev *hdev,
+				     __le16 handle)
 {
 	struct mgmt_ev_adv_monitor_removed ev;
-	struct mgmt_pending_cmd *cmd;
-	struct sock *sk_skip = NULL;
-	struct mgmt_cp_remove_adv_monitor *cp;
-
-	cmd = pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev);
-	if (cmd) {
-		cp = cmd->param;
-
-		if (cp->monitor_handle)
-			sk_skip = cmd->sk;
-	}
 
-	ev.monitor_handle = cpu_to_le16(handle);
+	ev.monitor_handle = handle;
 
-	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk_skip);
+	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
 static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
@@ -5260,7 +5243,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 		hci_update_passive_scan(hdev);
 	}
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
 	mgmt_pending_remove(cmd);
 
@@ -5291,8 +5274,7 @@ static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 
 	if (pending_find(MGMT_OP_SET_LE, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) ||
-	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev)) {
+	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev)) {
 		status = MGMT_STATUS_BUSY;
 		goto unlock;
 	}
@@ -5462,8 +5444,7 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+	if (status == -ECANCELED)
 		return;
 
 	hci_dev_lock(hdev);
@@ -5472,12 +5453,14 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 
 	rp.monitor_handle = cp->monitor_handle;
 
-	if (!status)
+	if (!status) {
+		mgmt_adv_monitor_removed(cmd->sk, hdev, cp->monitor_handle);
 		hci_update_passive_scan(hdev);
+	}
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
@@ -5487,10 +5470,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-
-	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
-		return -ECANCELED;
-
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
@@ -5509,14 +5488,13 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (pending_find(MGMT_OP_SET_LE, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev)) {
 		status = MGMT_STATUS_BUSY;
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_ADV_MONITOR, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_REMOVE_ADV_MONITOR, hdev, data, len);
 	if (!cmd) {
 		status = MGMT_STATUS_NO_RESOURCES;
 		goto unlock;
@@ -5526,7 +5504,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 				  mgmt_remove_adv_monitor_complete);
 
 	if (err) {
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 		if (err == -ENOMEM)
 			status = MGMT_STATUS_NO_RESOURCES;
@@ -5879,7 +5857,7 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 	    cmd != pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
 		return;
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
 	mgmt_pending_remove(cmd);
 
@@ -6117,7 +6095,7 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
 	mgmt_pending_remove(cmd);
 
@@ -6342,7 +6320,7 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	u8 status = mgmt_status(err);
 
 	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev,
+		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true,
 				     cmd_status_rsp, &status);
 		return;
 	}
@@ -6352,7 +6330,7 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
-	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, settings_rsp,
+	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true, settings_rsp,
 			     &match);
 
 	new_settings(hdev, match.sk);
@@ -6696,7 +6674,7 @@ static void set_bredr_complete(struct hci_dev *hdev, void *data, int err)
 		 */
 		hci_dev_clear_flag(hdev, HCI_BREDR_ENABLED);
 
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
 	} else {
 		send_settings_rsp(cmd->sk, MGMT_OP_SET_BREDR, hdev);
 		new_settings(hdev, cmd->sk);
@@ -6833,7 +6811,7 @@ static void set_secure_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (err) {
 		u8 mgmt_err = mgmt_status(err);
 
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
 		goto done;
 	}
 
@@ -7280,7 +7258,7 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, status,
 			  &rp, sizeof(rp));
 
 	mgmt_pending_free(cmd);
@@ -7440,7 +7418,7 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 	}
 
 complete:
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
+	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
 			  sizeof(rp));
 
 	mgmt_pending_free(cmd);
@@ -8690,10 +8668,10 @@ static void add_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	rp.instance = cp->instance;
 
 	if (err)
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
 				mgmt_status(err));
 	else
-		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 				  mgmt_status(err), &rp, sizeof(rp));
 
 	add_adv_complete(hdev, cmd->sk, cp->instance, err);
@@ -8881,10 +8859,10 @@ static void add_ext_adv_params_complete(struct hci_dev *hdev, void *data,
 
 		hci_remove_adv_instance(hdev, cp->instance);
 
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
 				mgmt_status(err));
 	} else {
-		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 				  mgmt_status(err), &rp, sizeof(rp));
 	}
 
@@ -9031,10 +9009,10 @@ static void add_ext_adv_data_complete(struct hci_dev *hdev, void *data, int err)
 	rp.instance = cp->instance;
 
 	if (err)
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
 				mgmt_status(err));
 	else
-		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 				  mgmt_status(err), &rp, sizeof(rp));
 
 	mgmt_pending_free(cmd);
@@ -9193,10 +9171,10 @@ static void remove_advertising_complete(struct hci_dev *hdev, void *data,
 	rp.instance = cp->instance;
 
 	if (err)
-		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
 				mgmt_status(err));
 	else
-		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 				  MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 
 	mgmt_pending_free(cmd);
@@ -9467,7 +9445,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
+	mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);
 
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0,
@@ -9505,7 +9483,8 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 		hci_update_passive_scan(hdev);
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, true, settings_rsp,
+			     &match);
 
 	new_settings(hdev, match.sk);
 
@@ -9520,7 +9499,8 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	struct cmd_lookup match = { NULL, hdev };
 	u8 zero_cod[] = { 0, 0, 0 };
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, true, settings_rsp,
+			     &match);
 
 	/* If the power off is because of hdev unregistration let
 	 * use the appropriate INVALID_INDEX status. Otherwise use
@@ -9534,7 +9514,7 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	else
 		match.mgmt_status = MGMT_STATUS_NOT_POWERED;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
+	mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
@@ -9775,7 +9755,6 @@ static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
 	device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, cmd->sk);
 
 	cmd->cmd_complete(cmd, 0);
-	mgmt_pending_remove(cmd);
 }
 
 bool mgmt_powering_down(struct hci_dev *hdev)
@@ -9831,8 +9810,8 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_cp_disconnect *cp;
 	struct mgmt_pending_cmd *cmd;
 
-	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-			     hdev);
+	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, true,
+			     unpair_device_rsp, hdev);
 
 	cmd = pending_find(MGMT_OP_DISCONNECT, hdev);
 	if (!cmd)
@@ -10025,7 +10004,7 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
-		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev,
+		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, true,
 				     cmd_status_rsp, &mgmt_err);
 		return;
 	}
@@ -10035,8 +10014,8 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	else
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_LINK_SECURITY);
 
-	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
-			     &match);
+	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, true,
+			     settings_rsp, &match);
 
 	if (changed)
 		new_settings(hdev, match.sk);
@@ -10060,9 +10039,12 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 {
 	struct cmd_lookup match = { NULL, hdev, mgmt_status(status) };
 
-	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
-	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
-	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, false, sk_lookup,
+			     &match);
+	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, false, sk_lookup,
+			     &match);
+	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, false, sk_lookup,
+			     &match);
 
 	if (!status) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class,
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 17ab909a7c07..a88a07da3947 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -217,47 +217,47 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 					   struct hci_dev *hdev)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd, *tmp;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
 
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
 		if (hci_sock_get_channel(cmd->sk) != channel)
 			continue;
-		if (cmd->opcode == opcode)
-			return cmd;
-	}
 
-	return NULL;
-}
-
-struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						u16 opcode,
-						struct hci_dev *hdev,
-						const void *data)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->user_data != data)
-			continue;
-		if (cmd->opcode == opcode)
+		if (cmd->opcode == opcode) {
+			mutex_unlock(&hdev->mgmt_pending_lock);
 			return cmd;
+		}
 	}
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return NULL;
 }
 
-void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
+void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data)
 {
 	struct mgmt_pending_cmd *cmd, *tmp;
 
+	mutex_lock(&hdev->mgmt_pending_lock);
+
 	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
 		if (opcode > 0 && cmd->opcode != opcode)
 			continue;
 
+		if (remove)
+			list_del(&cmd->list);
+
 		cb(cmd, data);
+
+		if (remove)
+			mgmt_pending_free(cmd);
 	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 }
 
 struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
@@ -271,7 +271,7 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 		return NULL;
 
 	cmd->opcode = opcode;
-	cmd->index = hdev->id;
+	cmd->hdev = hdev;
 
 	cmd->param = kmemdup(data, len, GFP_KERNEL);
 	if (!cmd->param) {
@@ -297,7 +297,9 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	if (!cmd)
 		return NULL;
 
+	mutex_lock(&hdev->mgmt_pending_lock);
 	list_add_tail(&cmd->list, &hdev->mgmt_pending);
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	return cmd;
 }
@@ -311,7 +313,10 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
 
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 {
+	mutex_lock(&cmd->hdev->mgmt_pending_lock);
 	list_del(&cmd->list);
+	mutex_unlock(&cmd->hdev->mgmt_pending_lock);
+
 	mgmt_pending_free(cmd);
 }
 
@@ -321,7 +326,7 @@ void mgmt_mesh_foreach(struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx, *tmp;
 
-	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mgmt_pending, list) {
+	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mesh_pending, list) {
 		if (!sk || mesh_tx->sk == sk)
 			cb(mesh_tx, data);
 	}
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index bdf978605d5a..024e51dd6937 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -33,7 +33,7 @@ struct mgmt_mesh_tx {
 struct mgmt_pending_cmd {
 	struct list_head list;
 	u16 opcode;
-	int index;
+	struct hci_dev *hdev;
 	void *param;
 	size_t param_len;
 	struct sock *sk;
@@ -54,11 +54,7 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 
 struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 					   struct hci_dev *hdev);
-struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						u16 opcode,
-						struct hci_dev *hdev,
-						const void *data);
-void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
+void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data);
 struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..6482de4d8750 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -60,19 +60,19 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 		struct ip_fraglist_iter iter;
 		struct sk_buff *frag;
 
-		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < ll_rs)
+		if (first_len - hlen > mtu)
 			goto blackhole;
 
-		if (skb_cloned(skb))
+		if (skb_cloned(skb) ||
+		    skb_headroom(skb) < ll_rs)
 			goto slow_path;
 
 		skb_walk_frags(skb, frag) {
-			if (frag->len > mtu ||
-			    skb_headroom(frag) < hlen + ll_rs)
+			if (frag->len > mtu)
 				goto blackhole;
 
-			if (skb_shared(frag))
+			if (skb_shared(frag) ||
+			    skb_headroom(frag) < hlen + ll_rs)
 				goto slow_path;
 		}
 
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e00..cd95394399b4 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -5,7 +5,7 @@
 
 static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp_magic;
+	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
 static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
@@ -15,9 +15,16 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
 
 static inline void netmem_clear_pp_magic(netmem_ref netmem)
 {
+	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
+
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
+static inline bool netmem_is_pp(netmem_ref netmem)
+{
+	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
 {
 	__netmem_clear_lsb(netmem)->pp = pool;
@@ -28,4 +35,28 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
 {
 	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
 }
+
+static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return 0;
+
+	magic = __netmem_clear_lsb(netmem)->pp_magic;
+
+	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
+}
+
+static inline void netmem_set_dma_index(netmem_ref netmem,
+					unsigned long id)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return;
+
+	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
+	__netmem_clear_lsb(netmem)->pp_magic = magic;
+}
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c8ce069605c4..0f23b3126bda 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -151,9 +151,9 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 EXPORT_SYMBOL(page_pool_ethtool_stats_get);
 
 #else
-#define alloc_stat_inc(pool, __stat)
-#define recycle_stat_inc(pool, __stat)
-#define recycle_stat_add(pool, __stat, val)
+#define alloc_stat_inc(...)	do { } while (0)
+#define recycle_stat_inc(...)	do { } while (0)
+#define recycle_stat_add(...)	do { } while (0)
 #endif
 
 static bool page_pool_producer_lock(struct page_pool *pool)
@@ -273,8 +273,7 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
+	xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
 
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
@@ -312,9 +311,7 @@ static int page_pool_init(struct page_pool *pool,
 static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
-
-	if (pool->dma_map)
-		put_device(pool->p.dev);
+	xa_destroy(&pool->dma_mapped);
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
@@ -455,13 +452,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {
+		rcu_read_lock();
+		/* re-check under rcu_read_lock() to sync with page_pool_scrub() */
+		if (pool->dma_sync)
+			__page_pool_dma_sync_for_device(pool, netmem,
+							dma_sync_size);
+		rcu_read_unlock();
+	}
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
+	int err;
+	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -475,15 +480,30 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	if (page_pool_set_dma_addr_netmem(netmem, dma))
+	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
+		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
 		goto unmap_failed;
+	}
+
+	if (in_softirq())
+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
+			       PP_DMA_INDEX_LIMIT, gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  PP_DMA_INDEX_LIMIT, gfp);
+	if (err) {
+		WARN_ONCE(err != -ENOMEM, "couldn't track DMA mapping, please report to netdev@");
+		goto unset_failed;
+	}
 
+	netmem_set_dma_index(netmem, id);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
 
+unset_failed:
+	page_pool_set_dma_addr_netmem(netmem, 0);
 unmap_failed:
-	WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
@@ -500,7 +520,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
 		put_page(page);
 		return NULL;
 	}
@@ -547,7 +567,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
-		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
@@ -649,6 +669,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -657,6 +679,17 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 		 */
 		return;
 
+	id = netmem_get_dma_index(netmem);
+	if (!id)
+		return;
+
+	if (in_softirq())
+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
+	else
+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
+	if (old != page)
+		return;
+
 	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	/* When page is unmapped, it cannot be returned to our pool */
@@ -664,6 +697,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
+	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -700,19 +734,16 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 
 static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 {
-	int ret;
-	/* BH protection not needed if current is softirq */
-	if (in_softirq())
-		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
-	else
-		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
+	bool in_softirq, ret;
 
-	if (!ret) {
+	/* BH protection not needed if current is softirq */
+	in_softirq = page_pool_producer_lock(pool);
+	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
+	if (ret)
 		recycle_stat_inc(pool, ring);
-		return true;
-	}
+	page_pool_producer_unlock(pool, in_softirq);
 
-	return false;
+	return ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -1038,8 +1069,29 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
 static void page_pool_scrub(struct page_pool *pool)
 {
+	unsigned long id;
+	void *ptr;
+
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	if (!pool->destroy_cnt++ && pool->dma_map) {
+		if (pool->dma_sync) {
+			/* Disable page_pool_dma_sync_for_device() */
+			pool->dma_sync = false;
+
+			/* Make sure all concurrent returns that may see the old
+			 * value of dma_sync (and thus perform a sync) have
+			 * finished before doing the unmapping below. Skip the
+			 * wait if the device doesn't actually need syncing, or
+			 * if there are no outstanding mapped pages.
+			 */
+			if (dma_dev_need_sync(pool->p.dev) &&
+			    !xa_empty(&pool->dma_mapped))
+				synchronize_net();
+		}
+
+		xa_for_each(&pool->dma_mapped, id, ptr)
+			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+	}
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
@@ -1049,10 +1101,14 @@ static void page_pool_scrub(struct page_pool *pool)
 
 static int page_pool_release(struct page_pool *pool)
 {
+	bool in_softirq;
 	int inflight;
 
 	page_pool_scrub(pool);
 	inflight = page_pool_inflight(pool, true);
+	/* Acquire producer lock to make sure producers have exited. */
+	in_softirq = page_pool_producer_lock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 	if (!inflight)
 		__page_pool_destroy(pool);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f220306731da..fdb36165c58f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -925,11 +925,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_netmem(netmem_ref netmem)
-{
-	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -1027,14 +1022,7 @@ bool napi_pp_put_page(netmem_ref netmem)
 {
 	netmem = netmem_compound_head(netmem);
 
-	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
-	 * in order to preserve any existing bits, such as bit 0 for the
-	 * head page of compound page and bit 1 for pfmemalloc page, so
-	 * mask those bits for freeing side when doing below checking,
-	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
-	 * to avoid recycling the pfmemalloc page.
-	 */
-	if (unlikely(!is_pp_netmem(netmem)))
+	if (unlikely(!netmem_is_pp(netmem)))
 		return false;
 
 	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
@@ -1074,7 +1062,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
-		if (likely(is_pp_netmem(head_netmem)))
+		if (likely(netmem_is_pp(head_netmem)))
 			page_pool_ref_netmem(head_netmem);
 		else
 			page_ref_inc(netmem_to_page(head_netmem));
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f76cbf49c68c..a8d238dd982a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -529,16 +529,22 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					u32 off, u32 len,
 					struct sk_psock *psock,
 					struct sock *sk,
-					struct sk_msg *msg)
+					struct sk_msg *msg,
+					bool take_ref)
 {
 	int num_sge, copied;
 
+	/* skb_to_sgvec will fail when the total number of fragments in
+	 * frag_list and frags exceeds MAX_MSG_FRAGS. For example, the
+	 * caller may aggregate multiple skbs.
+	 */
 	num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
 	if (num_sge < 0) {
 		/* skb linearize may fail with ENOMEM, but lets simply try again
 		 * later if this happens. Under memory pressure we don't want to
 		 * drop the skb. We need to linearize the skb so that the mapping
 		 * in skb_to_sgvec can not error.
+		 * Note that skb_linearize requires the skb not to be shared.
 		 */
 		if (skb_linearize(skb))
 			return -EAGAIN;
@@ -555,7 +561,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	msg->sg.start = 0;
 	msg->sg.size = copied;
 	msg->sg.end = num_sge;
-	msg->skb = skb;
+	msg->skb = take_ref ? skb_get(skb) : skb;
 
 	sk_psock_queue_msg(psock, msg);
 	sk_psock_data_ready(sk, psock);
@@ -563,7 +569,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len);
+				     u32 off, u32 len, bool take_ref);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len)
@@ -577,7 +583,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * correctly.
 	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len);
+		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -589,7 +595,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -600,7 +606,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
  * because the skb is already accounted for here.
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len)
+				     u32 off, u32 len, bool take_ref)
 {
 	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -609,7 +615,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	if (unlikely(!msg))
 		return -EAGAIN;
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -618,18 +624,13 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
-	int err = 0;
-
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	skb_get(skb);
-	err = sk_psock_skb_ingress(psock, skb, off, len);
-	if (err < 0)
-		kfree_skb(skb);
-	return err;
+
+	return sk_psock_skb_ingress(psock, skb, off, len);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -654,12 +655,14 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* Increment the psock refcnt to synchronize with close(fd) path in
+	 * sock_map_close(), ensuring we wait for backlog thread completion
+	 * before sk_socket freed. If refcnt increment fails, it indicates
+	 * sock_map_close() completed with sk_socket potentially already freed.
+	 */
+	if (!sk_psock_get(psock->sk))
+		return;
 	mutex_lock(&psock->work_mutex);
-	if (unlikely(state->len)) {
-		len = state->len;
-		off = state->off;
-	}
-
 	while ((skb = skb_peek(&psock->ingress_skb))) {
 		len = skb->len;
 		off = 0;
@@ -669,6 +672,13 @@ static void sk_psock_backlog(struct work_struct *work)
 			off = stm->offset;
 			len = stm->full_len;
 		}
+
+		/* Resume processing from previous partial state */
+		if (unlikely(state->len)) {
+			len = state->len;
+			off = state->off;
+		}
+
 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
 		do {
@@ -696,11 +706,14 @@ static void sk_psock_backlog(struct work_struct *work)
 			len -= ret;
 		} while (len);
 
+		/* The entire skb sent, clear state */
+		sk_psock_skb_state(psock, state, 0, 0);
 		skb = skb_dequeue(&psock->ingress_skb);
 		kfree_skb(skb);
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
+	sk_psock_put(psock->sk, psock);
 }
 
 struct sk_psock *sk_psock_init(struct sock *sk, int node)
@@ -1013,7 +1026,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len);
+			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index 0842dc9189bf..3c5386c76d6f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3157,16 +3157,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = false;
+	bool charged = true;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
 	if (memcg) {
-		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
+		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
+		if (!charged)
 			goto suppress_allocation;
-		charged = true;
 	}
 
 	/* Under limit. */
@@ -3251,7 +3251,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (charged)
+	if (memcg && charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..23e7d736718b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -381,8 +381,8 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		page = virt_to_head_page(data);
 		if (napi_direct && xdp_return_frame_no_direct())
 			napi_direct = false;
-		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-		 * as mem->type knows this a page_pool page
+		/* No need to check netmem_is_pp() as mem->type knows this a
+		 * page_pool page
 		 */
 		page_pool_put_full_page(page->pp, page, napi_direct);
 		break;
diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 8c3c068728e5..fe75821623a4 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -257,7 +257,7 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	int source_port;
 	u8 *brcm_tag;
 
-	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_PORT_ID)))
+	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
 		return NULL;
 
 	brcm_tag = dsa_etype_header_pos_rx(skb);
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index d25d717c121f..f514eb52b8d4 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -49,7 +49,12 @@ void nft_fib4_eval_type(const struct nft_expr *expr, struct nft_regs *regs,
 	else
 		addr = iph->saddr;
 
-	*dst = inet_dev_addr_type(nft_net(pkt), dev, addr);
+	if (priv->flags & (NFTA_FIB_F_IIF | NFTA_FIB_F_OIF)) {
+		*dst = inet_dev_addr_type(nft_net(pkt), dev, addr);
+		return;
+	}
+
+	*dst = inet_addr_type_dev_table(nft_net(pkt), pkt->skb->dev, addr);
 }
 EXPORT_SYMBOL_GPL(nft_fib4_eval_type);
 
@@ -64,8 +69,8 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct flowi4 fl4 = {
 		.flowi4_scope = RT_SCOPE_UNIVERSE,
 		.flowi4_iif = LOOPBACK_IFINDEX,
+		.flowi4_proto = pkt->tprot,
 		.flowi4_uid = sock_net_uid(nft_net(pkt), NULL),
-		.flowi4_l3mdev = l3mdev_master_ifindex_rcu(nft_in(pkt)),
 	};
 	const struct net_device *oif;
 	const struct net_device *found;
@@ -89,6 +94,8 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	else
 		oif = NULL;
 
+	fl4.flowi4_l3mdev = nft_fib_l3mdev_master_ifindex_rcu(pkt, oif);
+
 	iph = skb_header_pointer(pkt->skb, noff, sizeof(_iph), &_iph);
 	if (!iph) {
 		regs->verdict.code = NFT_BREAK;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index da5d4aea1b59..845730184c5d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -332,6 +332,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	bool copy_dtor;
 	__sum16 check;
 	__be16 newlen;
+	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
@@ -360,6 +361,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
+		ret = __skb_linearize(gso_skb);
+		if (ret)
+			return ERR_PTR(ret);
+
 		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
 		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
 		gso_skb->csum_offset = offsetof(struct udphdr, check);
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 581ce055bf52..4541836ee3da 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -164,20 +164,20 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		struct ip6_fraglist_iter iter;
 		struct sk_buff *frag2;
 
-		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
+		if (first_len - hlen > mtu)
 			goto blackhole;
 
-		if (skb_cloned(skb))
+		if (skb_cloned(skb) ||
+		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag2) {
-			if (frag2->len > mtu ||
-			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
+			if (frag2->len > mtu)
 				goto blackhole;
 
 			/* Partially cloned skb? */
-			if (skb_shared(frag2))
+			if (skb_shared(frag2) ||
+			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
 				goto slow_path;
 		}
 
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 7fd9d7b21cd4..421036a3605b 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -50,6 +50,7 @@ static int nft_fib6_flowi_init(struct flowi6 *fl6, const struct nft_fib *priv,
 		fl6->flowi6_mark = pkt->skb->mark;
 
 	fl6->flowlabel = (*(__be32 *)iph) & IPV6_FLOWINFO_MASK;
+	fl6->flowi6_l3mdev = nft_fib_l3mdev_master_ifindex_rcu(pkt, dev);
 
 	return lookup_flags;
 }
@@ -73,8 +74,6 @@ static u32 __nft_fib6_eval_type(const struct nft_fib *priv,
 	else if (priv->flags & NFTA_FIB_F_OIF)
 		dev = nft_out(pkt);
 
-	fl6.flowi6_l3mdev = l3mdev_master_ifindex_rcu(dev);
-
 	nft_fib6_flowi_init(&fl6, priv, pkt, dev, iph);
 
 	if (dev && nf_ipv6_chk_addr(nft_net(pkt), &fl6.daddr, dev, true))
@@ -158,6 +157,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 {
 	const struct nft_fib *priv = nft_expr_priv(expr);
 	int noff = skb_network_offset(pkt->skb);
+	const struct net_device *found = NULL;
 	const struct net_device *oif = NULL;
 	u32 *dest = &regs->data[priv->dreg];
 	struct ipv6hdr *iph, _iph;
@@ -165,7 +165,6 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		.flowi6_iif = LOOPBACK_IFINDEX,
 		.flowi6_proto = pkt->tprot,
 		.flowi6_uid = sock_net_uid(nft_net(pkt), NULL),
-		.flowi6_l3mdev = l3mdev_master_ifindex_rcu(nft_in(pkt)),
 	};
 	struct rt6_info *rt;
 	int lookup_flags;
@@ -203,11 +202,15 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	if (rt->rt6i_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
 		goto put_rt_err;
 
-	if (oif && oif != rt->rt6i_idev->dev &&
-	    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) != oif->ifindex)
-		goto put_rt_err;
+	if (!oif) {
+		found = rt->rt6i_idev->dev;
+	} else {
+		if (oif == rt->rt6i_idev->dev ||
+		    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) == oif->ifindex)
+			found = oif;
+	}
 
-	nft_fib_store_result(dest, priv, rt->rt6i_idev->dev);
+	nft_fib_store_result(dest, priv, found);
  put_rt_err:
 	ip6_rt_put(rt);
 }
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index c74705ead984..e445a0a45568 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1644,10 +1644,8 @@ static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_SRH]	= { .type = NLA_BINARY },
 	[SEG6_LOCAL_TABLE]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_VRFTABLE]	= { .type = NLA_U32 },
-	[SEG6_LOCAL_NH4]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct in_addr) },
-	[SEG6_LOCAL_NH6]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct in6_addr) },
+	[SEG6_LOCAL_NH4]	= NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
+	[SEG6_LOCAL_NH6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_LOCAL_IIF]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_OIF]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_BPF]	= { .type = NLA_NESTED },
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8fa9b9dd4611..16bb3db67eaa 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6728,11 +6728,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	bssid = ieee80211_get_bssid(hdr, len, sdata->vif.type);
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		struct ieee80211_ext *ext = (void *) mgmt;
-
-		if (ieee80211_is_s1g_short_beacon(ext->frame_control))
-			variable = ext->u.s1g_short_beacon.variable;
-		else
-			variable = ext->u.s1g_beacon.variable;
+		variable = ext->u.s1g_beacon.variable +
+			   ieee80211_s1g_optional_len(ext->frame_control);
 	}
 
 	baselen = (u8 *) variable - (u8 *) mgmt;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index adb88c06b598..ce6d5857214e 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -260,6 +260,7 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
+	struct ieee80211_ext *ext;
 	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
 
@@ -269,12 +270,10 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		return;
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_short_beacon.variable);
-		else
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_beacon);
+		ext = (struct ieee80211_ext *)mgmt;
+		min_hdr_len =
+			offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+			ieee80211_s1g_optional_len(ext->frame_control);
 	}
 
 	if (skb->len < min_hdr_len)
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 4e0842df5234..2c260f33b55c 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -143,16 +143,15 @@ struct ncsi_channel_vlan_filter {
 };
 
 struct ncsi_channel_stats {
-	u32 hnc_cnt_hi;		/* Counter cleared            */
-	u32 hnc_cnt_lo;		/* Counter cleared            */
-	u32 hnc_rx_bytes;	/* Rx bytes                   */
-	u32 hnc_tx_bytes;	/* Tx bytes                   */
-	u32 hnc_rx_uc_pkts;	/* Rx UC packets              */
-	u32 hnc_rx_mc_pkts;     /* Rx MC packets              */
-	u32 hnc_rx_bc_pkts;	/* Rx BC packets              */
-	u32 hnc_tx_uc_pkts;	/* Tx UC packets              */
-	u32 hnc_tx_mc_pkts;	/* Tx MC packets              */
-	u32 hnc_tx_bc_pkts;	/* Tx BC packets              */
+	u64 hnc_cnt;		/* Counter cleared            */
+	u64 hnc_rx_bytes;	/* Rx bytes                   */
+	u64 hnc_tx_bytes;	/* Tx bytes                   */
+	u64 hnc_rx_uc_pkts;	/* Rx UC packets              */
+	u64 hnc_rx_mc_pkts;     /* Rx MC packets              */
+	u64 hnc_rx_bc_pkts;	/* Rx BC packets              */
+	u64 hnc_tx_uc_pkts;	/* Tx UC packets              */
+	u64 hnc_tx_mc_pkts;	/* Tx MC packets              */
+	u64 hnc_tx_bc_pkts;	/* Tx BC packets              */
 	u32 hnc_fcs_err;	/* FCS errors                 */
 	u32 hnc_align_err;	/* Alignment errors           */
 	u32 hnc_false_carrier;	/* False carrier detection    */
@@ -181,7 +180,7 @@ struct ncsi_channel_stats {
 	u32 hnc_tx_1023_frames;	/* Tx 512-1023 bytes frames   */
 	u32 hnc_tx_1522_frames;	/* Tx 1024-1522 bytes frames  */
 	u32 hnc_tx_9022_frames;	/* Tx 1523-9022 bytes frames  */
-	u32 hnc_rx_valid_bytes;	/* Rx valid bytes             */
+	u64 hnc_rx_valid_bytes;	/* Rx valid bytes             */
 	u32 hnc_rx_runt_pkts;	/* Rx error runt packets      */
 	u32 hnc_rx_jabber_pkts;	/* Rx error jabber packets    */
 	u32 ncsi_rx_cmds;	/* Rx NCSI commands           */
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index f2f3b5c1b941..24edb2737972 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -252,16 +252,15 @@ struct ncsi_rsp_gp_pkt {
 /* Get Controller Packet Statistics */
 struct ncsi_rsp_gcps_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;            /* Response header            */
-	__be32                  cnt_hi;         /* Counter cleared            */
-	__be32                  cnt_lo;         /* Counter cleared            */
-	__be32                  rx_bytes;       /* Rx bytes                   */
-	__be32                  tx_bytes;       /* Tx bytes                   */
-	__be32                  rx_uc_pkts;     /* Rx UC packets              */
-	__be32                  rx_mc_pkts;     /* Rx MC packets              */
-	__be32                  rx_bc_pkts;     /* Rx BC packets              */
-	__be32                  tx_uc_pkts;     /* Tx UC packets              */
-	__be32                  tx_mc_pkts;     /* Tx MC packets              */
-	__be32                  tx_bc_pkts;     /* Tx BC packets              */
+	__be64                  cnt;            /* Counter cleared            */
+	__be64                  rx_bytes;       /* Rx bytes                   */
+	__be64                  tx_bytes;       /* Tx bytes                   */
+	__be64                  rx_uc_pkts;     /* Rx UC packets              */
+	__be64                  rx_mc_pkts;     /* Rx MC packets              */
+	__be64                  rx_bc_pkts;     /* Rx BC packets              */
+	__be64                  tx_uc_pkts;     /* Tx UC packets              */
+	__be64                  tx_mc_pkts;     /* Tx MC packets              */
+	__be64                  tx_bc_pkts;     /* Tx BC packets              */
 	__be32                  fcs_err;        /* FCS errors                 */
 	__be32                  align_err;      /* Alignment errors           */
 	__be32                  false_carrier;  /* False carrier detection    */
@@ -290,11 +289,11 @@ struct ncsi_rsp_gcps_pkt {
 	__be32                  tx_1023_frames; /* Tx 512-1023 bytes frames   */
 	__be32                  tx_1522_frames; /* Tx 1024-1522 bytes frames  */
 	__be32                  tx_9022_frames; /* Tx 1523-9022 bytes frames  */
-	__be32                  rx_valid_bytes; /* Rx valid bytes             */
+	__be64                  rx_valid_bytes; /* Rx valid bytes             */
 	__be32                  rx_runt_pkts;   /* Rx error runt packets      */
 	__be32                  rx_jabber_pkts; /* Rx error jabber packets    */
 	__be32                  checksum;       /* Checksum                   */
-};
+}  __packed __aligned(4);
 
 /* Get NCSI Statistics */
 struct ncsi_rsp_gns_pkt {
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 4a8ce2949fae..8668888c5a2f 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -926,16 +926,15 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 
 	/* Update HNC's statistics */
 	ncs = &nc->stats;
-	ncs->hnc_cnt_hi         = ntohl(rsp->cnt_hi);
-	ncs->hnc_cnt_lo         = ntohl(rsp->cnt_lo);
-	ncs->hnc_rx_bytes       = ntohl(rsp->rx_bytes);
-	ncs->hnc_tx_bytes       = ntohl(rsp->tx_bytes);
-	ncs->hnc_rx_uc_pkts     = ntohl(rsp->rx_uc_pkts);
-	ncs->hnc_rx_mc_pkts     = ntohl(rsp->rx_mc_pkts);
-	ncs->hnc_rx_bc_pkts     = ntohl(rsp->rx_bc_pkts);
-	ncs->hnc_tx_uc_pkts     = ntohl(rsp->tx_uc_pkts);
-	ncs->hnc_tx_mc_pkts     = ntohl(rsp->tx_mc_pkts);
-	ncs->hnc_tx_bc_pkts     = ntohl(rsp->tx_bc_pkts);
+	ncs->hnc_cnt            = be64_to_cpu(rsp->cnt);
+	ncs->hnc_rx_bytes       = be64_to_cpu(rsp->rx_bytes);
+	ncs->hnc_tx_bytes       = be64_to_cpu(rsp->tx_bytes);
+	ncs->hnc_rx_uc_pkts     = be64_to_cpu(rsp->rx_uc_pkts);
+	ncs->hnc_rx_mc_pkts     = be64_to_cpu(rsp->rx_mc_pkts);
+	ncs->hnc_rx_bc_pkts     = be64_to_cpu(rsp->rx_bc_pkts);
+	ncs->hnc_tx_uc_pkts     = be64_to_cpu(rsp->tx_uc_pkts);
+	ncs->hnc_tx_mc_pkts     = be64_to_cpu(rsp->tx_mc_pkts);
+	ncs->hnc_tx_bc_pkts     = be64_to_cpu(rsp->tx_bc_pkts);
 	ncs->hnc_fcs_err        = ntohl(rsp->fcs_err);
 	ncs->hnc_align_err      = ntohl(rsp->align_err);
 	ncs->hnc_false_carrier  = ntohl(rsp->false_carrier);
@@ -964,7 +963,7 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 	ncs->hnc_tx_1023_frames = ntohl(rsp->tx_1023_frames);
 	ncs->hnc_tx_1522_frames = ntohl(rsp->tx_1522_frames);
 	ncs->hnc_tx_9022_frames = ntohl(rsp->tx_9022_frames);
-	ncs->hnc_rx_valid_bytes = ntohl(rsp->rx_valid_bytes);
+	ncs->hnc_rx_valid_bytes = be64_to_cpu(rsp->rx_valid_bytes);
 	ncs->hnc_rx_runt_pkts   = ntohl(rsp->rx_runt_pkts);
 	ncs->hnc_rx_jabber_pkts = ntohl(rsp->rx_jabber_pkts);
 
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 4085c436e306..02f10a46fab7 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -248,7 +248,7 @@ static noinline bool
 nf_nat_used_tuple_new(const struct nf_conntrack_tuple *tuple,
 		      const struct nf_conn *ignored_ct)
 {
-	static const unsigned long uses_nat = IPS_NAT_MASK | IPS_SEQ_ADJUST_BIT;
+	static const unsigned long uses_nat = IPS_NAT_MASK | IPS_SEQ_ADJUST;
 	const struct nf_conntrack_tuple_hash *thash;
 	const struct nf_conntrack_zone *zone;
 	struct nf_conn *ct;
@@ -287,8 +287,14 @@ nf_nat_used_tuple_new(const struct nf_conntrack_tuple *tuple,
 	zone = nf_ct_zone(ignored_ct);
 
 	thash = nf_conntrack_find_get(net, zone, tuple);
-	if (unlikely(!thash)) /* clashing entry went away */
-		return false;
+	if (unlikely(!thash)) {
+		struct nf_conntrack_tuple reply;
+
+		nf_ct_invert_tuple(&reply, tuple);
+		thash = nf_conntrack_find_get(net, zone, &reply);
+		if (!thash) /* clashing entry went away */
+			return false;
+	}
 
 	ct = nf_ct_tuplehash_to_ctrack(thash);
 
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index 9b2d7463d3d3..df0798da2329 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -19,10 +19,16 @@ struct nft_quota {
 };
 
 static inline bool nft_overquota(struct nft_quota *priv,
-				 const struct sk_buff *skb)
+				 const struct sk_buff *skb,
+				 bool *report)
 {
-	return atomic64_add_return(skb->len, priv->consumed) >=
-	       atomic64_read(&priv->quota);
+	u64 consumed = atomic64_add_return(skb->len, priv->consumed);
+	u64 quota = atomic64_read(&priv->quota);
+
+	if (report)
+		*report = consumed >= quota;
+
+	return consumed > quota;
 }
 
 static inline bool nft_quota_invert(struct nft_quota *priv)
@@ -34,7 +40,7 @@ static inline void nft_quota_do_eval(struct nft_quota *priv,
 				     struct nft_regs *regs,
 				     const struct nft_pktinfo *pkt)
 {
-	if (nft_overquota(priv, pkt->skb) ^ nft_quota_invert(priv))
+	if (nft_overquota(priv, pkt->skb, NULL) ^ nft_quota_invert(priv))
 		regs->verdict.code = NFT_BREAK;
 }
 
@@ -51,13 +57,13 @@ static void nft_quota_obj_eval(struct nft_object *obj,
 			       const struct nft_pktinfo *pkt)
 {
 	struct nft_quota *priv = nft_obj_data(obj);
-	bool overquota;
+	bool overquota, report;
 
-	overquota = nft_overquota(priv, pkt->skb);
+	overquota = nft_overquota(priv, pkt->skb, &report);
 	if (overquota ^ nft_quota_invert(priv))
 		regs->verdict.code = NFT_BREAK;
 
-	if (overquota &&
+	if (report &&
 	    !test_and_set_bit(NFT_QUOTA_DEPLETED_BIT, &priv->flags))
 		nft_obj_notify(nft_net(pkt), obj->key.table, obj, 0, 0,
 			       NFT_MSG_NEWOBJ, 0, nft_pf(pkt), 0, GFP_ATOMIC);
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7be342b495f5..0529e4ef7520 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -683,6 +683,30 @@ static int pipapo_realloc_mt(struct nft_pipapo_field *f,
 	return 0;
 }
 
+
+/**
+ * lt_calculate_size() - Get storage size for lookup table with overflow check
+ * @groups:	Amount of bit groups
+ * @bb:		Number of bits grouped together in lookup table buckets
+ * @bsize:	Size of each bucket in lookup table, in longs
+ *
+ * Return: allocation size including alignment overhead, negative on overflow
+ */
+static ssize_t lt_calculate_size(unsigned int groups, unsigned int bb,
+				 unsigned int bsize)
+{
+	ssize_t ret = groups * NFT_PIPAPO_BUCKETS(bb) * sizeof(long);
+
+	if (check_mul_overflow(ret, bsize, &ret))
+		return -1;
+	if (check_add_overflow(ret, NFT_PIPAPO_ALIGN_HEADROOM, &ret))
+		return -1;
+	if (ret > INT_MAX)
+		return -1;
+
+	return ret;
+}
+
 /**
  * pipapo_resize() - Resize lookup or mapping table, or both
  * @f:		Field containing lookup and mapping tables
@@ -701,6 +725,7 @@ static int pipapo_resize(struct nft_pipapo_field *f,
 	long *new_lt = NULL, *new_p, *old_lt = f->lt, *old_p;
 	unsigned int new_bucket_size, copy;
 	int group, bucket, err;
+	ssize_t lt_size;
 
 	if (rules >= NFT_PIPAPO_RULE0_MAX)
 		return -ENOSPC;
@@ -719,10 +744,11 @@ static int pipapo_resize(struct nft_pipapo_field *f,
 	else
 		copy = new_bucket_size;
 
-	new_lt = kvzalloc(f->groups * NFT_PIPAPO_BUCKETS(f->bb) *
-			  new_bucket_size * sizeof(*new_lt) +
-			  NFT_PIPAPO_ALIGN_HEADROOM,
-			  GFP_KERNEL);
+	lt_size = lt_calculate_size(f->groups, f->bb, new_bucket_size);
+	if (lt_size < 0)
+		return -ENOMEM;
+
+	new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return -ENOMEM;
 
@@ -907,7 +933,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 {
 	unsigned int groups, bb;
 	unsigned long *new_lt;
-	size_t lt_size;
+	ssize_t lt_size;
 
 	lt_size = f->groups * NFT_PIPAPO_BUCKETS(f->bb) * f->bsize *
 		  sizeof(*f->lt);
@@ -917,15 +943,17 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		groups = f->groups * 2;
 		bb = NFT_PIPAPO_GROUP_BITS_LARGE_SET;
 
-		lt_size = groups * NFT_PIPAPO_BUCKETS(bb) * f->bsize *
-			  sizeof(*f->lt);
+		lt_size = lt_calculate_size(groups, bb, f->bsize);
+		if (lt_size < 0)
+			return;
 	} else if (f->bb == NFT_PIPAPO_GROUP_BITS_LARGE_SET &&
 		   lt_size < NFT_PIPAPO_LT_SIZE_LOW) {
 		groups = f->groups / 2;
 		bb = NFT_PIPAPO_GROUP_BITS_SMALL_SET;
 
-		lt_size = groups * NFT_PIPAPO_BUCKETS(bb) * f->bsize *
-			  sizeof(*f->lt);
+		lt_size = lt_calculate_size(groups, bb, f->bsize);
+		if (lt_size < 0)
+			return;
 
 		/* Don't increase group width if the resulting lookup table size
 		 * would exceed the upper size threshold for a "small" set.
@@ -936,7 +964,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		return;
 	}
 
-	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL_ACCOUNT);
+	new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return;
 
@@ -1451,13 +1479,15 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 
 	for (i = 0; i < old->field_count; i++) {
 		unsigned long *new_lt;
+		ssize_t lt_size;
 
 		memcpy(dst, src, offsetof(struct nft_pipapo_field, lt));
 
-		new_lt = kvzalloc(src->groups * NFT_PIPAPO_BUCKETS(src->bb) *
-				  src->bsize * sizeof(*dst->lt) +
-				  NFT_PIPAPO_ALIGN_HEADROOM,
-				  GFP_KERNEL_ACCOUNT);
+		lt_size = lt_calculate_size(src->groups, src->bb, src->bsize);
+		if (lt_size < 0)
+			goto out_lt;
+
+		new_lt = kvzalloc(lt_size, GFP_KERNEL_ACCOUNT);
 		if (!new_lt)
 			goto out_lt;
 
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index c15db28c5ebc..be7c16c79f71 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1113,6 +1113,25 @@ bool nft_pipapo_avx2_estimate(const struct nft_set_desc *desc, u32 features,
 	return true;
 }
 
+/**
+ * pipapo_resmap_init_avx2() - Initialise result map before first use
+ * @m:		Matching data, including mapping table
+ * @res_map:	Result map
+ *
+ * Like pipapo_resmap_init() but do not set start map bits covered by the first field.
+ */
+static inline void pipapo_resmap_init_avx2(const struct nft_pipapo_match *m, unsigned long *res_map)
+{
+	const struct nft_pipapo_field *f = m->f;
+	int i;
+
+	/* Starting map doesn't need to be set to all-ones for this implementation,
+	 * but we do need to zero the remaining bits, if any.
+	 */
+	for (i = f->bsize; i < m->bsize_max; i++)
+		res_map[i] = 0ul;
+}
+
 /**
  * nft_pipapo_avx2_lookup() - Lookup function for AVX2 implementation
  * @net:	Network namespace
@@ -1171,7 +1190,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	res  = scratch->map + (map_index ? m->bsize_max : 0);
 	fill = scratch->map + (map_index ? 0 : m->bsize_max);
 
-	/* Starting map doesn't need to be set for this implementation */
+	pipapo_resmap_init_avx2(m, res);
 
 	nft_pipapo_avx2_prepare();
 
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 0d99786c322e..e18d322290fb 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -624,10 +624,10 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 		struct geneve_opt *opt;
 		int offset = 0;
 
-		inner = nla_nest_start_noflag(skb, NFTA_TUNNEL_KEY_OPTS_GENEVE);
-		if (!inner)
-			goto failure;
 		while (opts->len > offset) {
+			inner = nla_nest_start_noflag(skb, NFTA_TUNNEL_KEY_OPTS_GENEVE);
+			if (!inner)
+				goto failure;
 			opt = (struct geneve_opt *)(opts->u.data + offset);
 			if (nla_put_be16(skb, NFTA_TUNNEL_KEY_GENEVE_CLASS,
 					 opt->opt_class) ||
@@ -637,8 +637,8 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 				    opt->length * 4, opt->opt_data))
 				goto inner_failure;
 			offset += sizeof(*opt) + opt->length * 4;
+			nla_nest_end(skb, inner);
 		}
-		nla_nest_end(skb, inner);
 	}
 	nla_nest_end(skb, nest);
 	return 0;
diff --git a/net/netfilter/xt_TCPOPTSTRIP.c b/net/netfilter/xt_TCPOPTSTRIP.c
index 30e99464171b..93f064306901 100644
--- a/net/netfilter/xt_TCPOPTSTRIP.c
+++ b/net/netfilter/xt_TCPOPTSTRIP.c
@@ -91,7 +91,7 @@ tcpoptstrip_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 	return tcpoptstrip_mangle_packet(skb, par, ip_hdrlen(skb));
 }
 
-#if IS_ENABLED(CONFIG_IP6_NF_MANGLE)
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
 static unsigned int
 tcpoptstrip_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 {
@@ -119,7 +119,7 @@ static struct xt_target tcpoptstrip_tg_reg[] __read_mostly = {
 		.targetsize = sizeof(struct xt_tcpoptstrip_target_info),
 		.me         = THIS_MODULE,
 	},
-#if IS_ENABLED(CONFIG_IP6_NF_MANGLE)
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
 	{
 		.name       = "TCPOPTSTRIP",
 		.family     = NFPROTO_IPV6,
diff --git a/net/netfilter/xt_mark.c b/net/netfilter/xt_mark.c
index 65b965ca40ea..59b9d04400ca 100644
--- a/net/netfilter/xt_mark.c
+++ b/net/netfilter/xt_mark.c
@@ -48,7 +48,7 @@ static struct xt_target mark_tg_reg[] __read_mostly = {
 		.targetsize     = sizeof(struct xt_mark_tginfo2),
 		.me             = THIS_MODULE,
 	},
-#if IS_ENABLED(CONFIG_IP_NF_ARPTABLES)
+#if IS_ENABLED(CONFIG_IP_NF_ARPTABLES) || IS_ENABLED(CONFIG_NFT_COMPAT_ARP)
 	{
 		.name           = "MARK",
 		.revision       = 2,
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index cd9160bbc919..33b77084a4e5 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1165,6 +1165,11 @@ int netlbl_conn_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		if (sk->sk_family != AF_INET6) {
+			ret_val = -EAFNOSUPPORT;
+			goto conn_setattr_return;
+		}
+
 		addr6 = (struct sockaddr_in6 *)addr;
 		entry = netlbl_domhsh_getentry_af6(secattr->domain,
 						   &addr6->sin6_addr);
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 8a848ce72e29..b80bd3a90773 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -788,7 +788,7 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
 			memset(&key->ipv4, 0, sizeof(key->ipv4));
 		}
 	} else if (eth_p_mpls(key->eth.type)) {
-		u8 label_count = 1;
+		size_t label_count = 1;
 
 		memset(&key->mpls, 0, sizeof(key->mpls));
 		skb_set_inner_network_header(skb, skb->mac_len);
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 2c069f0181c6..037f764822b9 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -661,7 +661,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
 			list_del_init(&q->classes[i].alist);
-		qdisc_tree_flush_backlog(q->classes[i].qdisc);
+		qdisc_purge_queue(q->classes[i].qdisc);
 	}
 	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index cc30f7a32f1a..9e2b9a490db2 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -211,7 +211,7 @@ static int prio_tune(struct Qdisc *sch, struct nlattr *opt,
 	memcpy(q->prio2band, qopt->priomap, TC_PRIO_MAX+1);
 
 	for (i = q->bands; i < oldbands; i++)
-		qdisc_tree_flush_backlog(q->queues[i]);
+		qdisc_purge_queue(q->queues[i]);
 
 	for (i = oldbands; i < q->bands; i++) {
 		q->queues[i] = queues[i];
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index b5f096588fae..0f0701ed397e 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -283,7 +283,7 @@ static int __red_change(struct Qdisc *sch, struct nlattr **tb,
 	q->userbits = userbits;
 	q->limit = ctl->limit;
 	if (child) {
-		qdisc_tree_flush_backlog(q->qdisc);
+		qdisc_purge_queue(q->qdisc);
 		old_child = q->qdisc;
 		q->qdisc = child;
 	}
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 58b42dcf8f20..a903b3c46805 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		/* It is difficult to believe, but ALL THE SLOTS HAVE LENGTH 1. */
 		x = q->tail->next;
 		slot = &q->slots[x];
-		q->tail->next = slot->next;
+		if (slot->next == x)
+			q->tail = NULL; /* no more active slots */
+		else
+			q->tail->next = slot->next;
 		q->ht[slot->hash] = SFQ_EMPTY_SLOT;
 		goto drop;
 	}
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dc26b22d53c7..4c977f049670 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -452,7 +452,7 @@ static int tbf_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 	if (child) {
-		qdisc_tree_flush_backlog(q->qdisc);
+		qdisc_purge_queue(q->qdisc);
 		old = q->qdisc;
 		q->qdisc = child;
 	}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index aca8bdf65d72..ca6172822b68 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -406,12 +406,12 @@ static void svc_rdma_xprt_done(struct rpcrdma_notification *rn)
  */
 static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 {
+	unsigned int ctxts, rq_depth, maxpayload;
 	struct svcxprt_rdma *listen_rdma;
 	struct svcxprt_rdma *newxprt = NULL;
 	struct rdma_conn_param conn_param;
 	struct rpcrdma_connect_private pmsg;
 	struct ib_qp_init_attr qp_attr;
-	unsigned int ctxts, rq_depth;
 	struct ib_device *dev;
 	int ret = 0;
 	RPC_IFDEBUG(struct sockaddr *sap);
@@ -462,12 +462,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_bc_requests = 2;
 	}
 
-	/* Arbitrarily estimate the number of rw_ctxs needed for
-	 * this transport. This is enough rw_ctxs to make forward
-	 * progress even if the client is using one rkey per page
-	 * in each Read chunk.
+	/* Arbitrary estimate of the needed number of rdma_rw contexts.
 	 */
-	ctxts = 3 * RPCSVC_MAXPAGES;
+	maxpayload = min(xprt->xpt_server->sv_max_payload,
+			 RPCSVC_MAXPAYLOAD_RDMA);
+	ctxts = newxprt->sc_max_requests * 3 *
+		rdma_rw_mr_factor(dev, newxprt->sc_port_num,
+				  maxpayload >> PAGE_SHIFT);
+
 	newxprt->sc_sq_depth = rq_depth + ctxts;
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 8584893b4785..79f91b6ca8c8 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -818,7 +818,11 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 	}
 
 	/* Get net to avoid freed tipc_crypto when delete namespace */
-	get_net(aead->crypto->net);
+	if (!maybe_get_net(aead->crypto->net)) {
+		tipc_bearer_put(b);
+		rc = -ENODEV;
+		goto exit;
+	}
 
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 7bcc9b4408a2..8fb5925f2389 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -908,6 +908,13 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 					    &msg_redir, send, flags);
 		lock_sock(sk);
 		if (err < 0) {
+			/* Regardless of whether the data represented by
+			 * msg_redir is sent successfully, we have already
+			 * uncharged it via sk_msg_return_zero(). The
+			 * msg->sg.size represents the remaining unprocessed
+			 * data, which needs to be uncharged here.
+			 */
+			sk_mem_uncharge(sk, msg->sg.size);
 			*copied -= sk_msg_free_nocharge(sk, &msg_redir);
 			msg->sg.size = 0;
 		}
@@ -1120,9 +1127,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ctx->open_rec && ret == -ENOSPC)
+				else if (ctx->open_rec && ret == -ENOSPC) {
+					if (msg_pl->cork_bytes) {
+						ret = 0;
+						goto send_end;
+					}
 					goto rollback_iter;
-				else if (ret != -EAGAIN)
+				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
 			continue;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..2c9b1011cdcc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -441,18 +441,20 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->rx_bytes + len > vvs->buf_alloc)
+	if (vvs->buf_used + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
+	vvs->buf_used += len;
 	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-					u32 len)
+					u32 bytes_read, u32 bytes_dequeued)
 {
-	vvs->rx_bytes -= len;
-	vvs->fwd_cnt += len;
+	vvs->rx_bytes -= bytes_read;
+	vvs->buf_used -= bytes_dequeued;
+	vvs->fwd_cnt += bytes_dequeued;
 }
 
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
@@ -581,11 +583,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 				   size_t len)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	size_t bytes, total = 0;
 	struct sk_buff *skb;
 	u32 fwd_cnt_delta;
 	bool low_rx_bytes;
 	int err = -EFAULT;
+	size_t total = 0;
 	u32 free_space;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -597,6 +599,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
+		size_t bytes, dequeued = 0;
+
 		skb = skb_peek(&vvs->rx_queue);
 
 		bytes = min_t(size_t, len - total,
@@ -620,12 +624,12 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 		VIRTIO_VSOCK_SKB_CB(skb)->offset += bytes;
 
 		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->offset) {
-			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-
-			virtio_transport_dec_rx_pkt(vvs, pkt_len);
+			dequeued = le32_to_cpu(virtio_vsock_hdr(skb)->len);
 			__skb_unlink(skb, &vvs->rx_queue);
 			consume_skb(skb);
 		}
+
+		virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);
 	}
 
 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
@@ -781,7 +785,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 				msg->msg_flags |= MSG_EOR;
 		}
 
-		virtio_transport_dec_rx_pkt(vvs, pkt_len);
+		virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
 		kfree_skb(skb);
 	}
 
@@ -1735,6 +1739,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 pkt_len;
 	int off = 0;
 	int err;
 
@@ -1752,7 +1757,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count--;
 
-	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
+	pkt_len = le32_to_cpu(hdr->len);
+	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f0dd1f448d4d..d80ab1725f28 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3213,6 +3213,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	const u8 *ie;
 	size_t ielen;
 	u64 tsf;
+	size_t s1g_optional_len;
 
 	if (WARN_ON(!mgmt))
 		return NULL;
@@ -3227,12 +3228,11 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		ext = (void *) mgmt;
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_short_beacon.variable);
-		else
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_beacon.variable);
+		s1g_optional_len =
+			ieee80211_s1g_optional_len(ext->frame_control);
+		min_hdr_len =
+			offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+			s1g_optional_len;
 	} else {
 		/* same for beacons */
 		min_hdr_len = offsetof(struct ieee80211_mgmt,
@@ -3248,11 +3248,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		const struct ieee80211_s1g_bcn_compat_ie *compat;
 		const struct element *elem;
 
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			ie = ext->u.s1g_short_beacon.variable;
-		else
-			ie = ext->u.s1g_beacon.variable;
-
+		ie = ext->u.s1g_beacon.variable + s1g_optional_len;
 		elem = cfg80211_find_elem(WLAN_EID_S1G_BCN_COMPAT, ie, ielen);
 		if (!elem)
 			return NULL;
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index b33c4591e09a..32ad8f3fc81e 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -373,7 +373,6 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 
 	xdo->dev = dev;
 	netdev_tracker_alloc(dev, &xdo->dev_tracker, GFP_ATOMIC);
-	xdo->real_dev = dev;
 	xdo->type = XFRM_DEV_OFFLOAD_PACKET;
 	switch (dir) {
 	case XFRM_POLICY_IN:
@@ -395,7 +394,6 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 	err = dev->xfrmdev_ops->xdo_dev_policy_add(xp, extack);
 	if (err) {
 		xdo->dev = NULL;
-		xdo->real_dev = NULL;
 		xdo->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		xdo->dir = 0;
 		netdev_put(dev, &xdo->dev_tracker);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index abd725386cb6..7a298058fc16 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1487,7 +1487,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			xso->type = XFRM_DEV_OFFLOAD_PACKET;
 			xso->dir = xdo->dir;
 			xso->dev = xdo->dev;
-			xso->real_dev = xdo->real_dev;
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
 			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
 			error = xso->dev->xfrmdev_ops->xdo_dev_state_add(x, NULL);
@@ -1495,7 +1494,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 				xso->dir = 0;
 				netdev_put(xso->dev, &xso->dev_tracker);
 				xso->dev = NULL;
-				xso->real_dev = NULL;
 				xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 				x->km.state = XFRM_STATE_DEAD;
 				to_put = x;
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 87a71fd40c3c..f62204fe563f 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -196,6 +196,9 @@ pub fn len(&self) -> usize {
     #[inline]
     pub unsafe fn set_len(&mut self, new_len: usize) {
         debug_assert!(new_len <= self.capacity());
+
+        // INVARIANT: By the safety requirements of this method `new_len` represents the exact
+        // number of elements stored within `self`.
         self.len = new_len;
     }
 
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 3222c1070444..ef12c8f929ed 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -123,6 +123,38 @@ static inline tree build_const_char_string(int len, const char *str)
 	return cstr;
 }
 
+static inline void __add_type_attr(tree type, const char *attr, tree args)
+{
+	tree oldattr;
+
+	if (type == NULL_TREE)
+		return;
+	oldattr = lookup_attribute(attr, TYPE_ATTRIBUTES(type));
+	if (oldattr != NULL_TREE) {
+		gcc_assert(TREE_VALUE(oldattr) == args || TREE_VALUE(TREE_VALUE(oldattr)) == TREE_VALUE(args));
+		return;
+	}
+
+	TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
+	TYPE_ATTRIBUTES(type) = tree_cons(get_identifier(attr), args, TYPE_ATTRIBUTES(type));
+}
+
+static inline void add_type_attr(tree type, const char *attr, tree args)
+{
+	tree main_variant = TYPE_MAIN_VARIANT(type);
+
+	__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	__add_type_attr(TYPE_CANONICAL(main_variant), attr, args);
+	__add_type_attr(main_variant, attr, args);
+
+	for (type = TYPE_NEXT_VARIANT(main_variant); type; type = TYPE_NEXT_VARIANT(type)) {
+		if (!lookup_attribute(attr, TYPE_ATTRIBUTES(type)))
+			TYPE_ATTRIBUTES(type) = TYPE_ATTRIBUTES(main_variant);
+
+		__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	}
+}
+
 #define PASS_INFO(NAME, REF, ID, POS)		\
 struct register_pass_info NAME##_pass_info = {	\
 	.pass = make_##NAME##_pass(),		\
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 5694df3da2e9..ff65a4f87f24 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -73,6 +73,9 @@ static tree handle_randomize_layout_attr(tree *node, tree name, tree args, int f
 
 	if (TYPE_P(*node)) {
 		type = *node;
+	} else if (TREE_CODE(*node) == FIELD_DECL) {
+		*no_add_attrs = false;
+		return NULL_TREE;
 	} else {
 		gcc_assert(TREE_CODE(*node) == TYPE_DECL);
 		type = TREE_TYPE(*node);
@@ -344,35 +347,18 @@ static int relayout_struct(tree type)
 
 	shuffle(type, (tree *)newtree, shuffle_length);
 
-	/*
-	 * set up a bogus anonymous struct field designed to error out on unnamed struct initializers
-	 * as gcc provides no other way to detect such code
-	 */
-	list = make_node(FIELD_DECL);
-	TREE_CHAIN(list) = newtree[0];
-	TREE_TYPE(list) = void_type_node;
-	DECL_SIZE(list) = bitsize_zero_node;
-	DECL_NONADDRESSABLE_P(list) = 1;
-	DECL_FIELD_BIT_OFFSET(list) = bitsize_zero_node;
-	DECL_SIZE_UNIT(list) = size_zero_node;
-	DECL_FIELD_OFFSET(list) = size_zero_node;
-	DECL_CONTEXT(list) = type;
-	// to satisfy the constify plugin
-	TREE_READONLY(list) = 1;
-
 	for (i = 0; i < num_fields - 1; i++)
 		TREE_CHAIN(newtree[i]) = newtree[i+1];
 	TREE_CHAIN(newtree[num_fields - 1]) = NULL_TREE;
 
+	add_type_attr(type, "randomize_performed", NULL_TREE);
+	add_type_attr(type, "designated_init", NULL_TREE);
+	if (has_flexarray)
+		add_type_attr(type, "has_flexarray", NULL_TREE);
+
 	main_variant = TYPE_MAIN_VARIANT(type);
-	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_FIELDS(variant) = list;
-		TYPE_ATTRIBUTES(variant) = copy_list(TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("randomize_performed"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("designated_init"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		if (has_flexarray)
-			TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("has_flexarray"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
+	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant))
+		TYPE_FIELDS(variant) = newtree[0];
 
 	/*
 	 * force a re-layout of the main variant
@@ -440,10 +426,8 @@ static void randomize_type(tree type)
 	if (lookup_attribute("randomize_layout", TYPE_ATTRIBUTES(TYPE_MAIN_VARIANT(type))) || is_pure_ops_struct(type))
 		relayout_struct(type);
 
-	for (variant = TYPE_MAIN_VARIANT(type); variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
-		TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("randomize_considered"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
+	add_type_attr(type, "randomize_considered", NULL_TREE);
+
 #ifdef __DEBUG_PLUGIN
 	fprintf(stderr, "Marking randomize_considered on struct %s\n", ORIG_TYPE_NAME(type));
 #ifdef __DEBUG_VERBOSE
diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
index 4492be5d2317..bac9f8603734 100644
--- a/sound/core/seq_device.c
+++ b/sound/core/seq_device.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static int snd_seq_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct snd_seq_device *sdev = to_seq_dev(dev);
-	struct snd_seq_driver *sdrv = to_seq_drv(drv);
+	const struct snd_seq_driver *sdrv = to_seq_drv(drv);
 
 	return strcmp(sdrv->id, sdev->id) == 0 &&
 		sdrv->argsize == sdev->argsize;
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index 7545ace7b0ee..eb72a7af2e56 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -21,7 +21,7 @@ MODULE_LICENSE("GPL");
  * driver id_table and returns the matching device id entry.
  */
 const struct hda_device_id *
-hdac_get_device_id(struct hdac_device *hdev, struct hdac_driver *drv)
+hdac_get_device_id(struct hdac_device *hdev, const struct hdac_driver *drv)
 {
 	if (drv->id_table) {
 		const struct hda_device_id *id  = drv->id_table;
@@ -38,7 +38,7 @@ hdac_get_device_id(struct hdac_device *hdev, struct hdac_driver *drv)
 }
 EXPORT_SYMBOL_GPL(hdac_get_device_id);
 
-static int hdac_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
+static int hdac_codec_match(struct hdac_device *dev, const struct hdac_driver *drv)
 {
 	if (hdac_get_device_id(dev, drv))
 		return 1;
@@ -49,7 +49,7 @@ static int hdac_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
 static int hda_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
-	struct hdac_driver *hdrv = drv_to_hdac_driver(drv);
+	const struct hdac_driver *hdrv = drv_to_hdac_driver(drv);
 
 	if (hdev->type != hdrv->type)
 		return 0;
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index b7ca2a83fbb0..90633970b59f 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -18,10 +18,10 @@
 /*
  * find a matching codec id
  */
-static int hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
+static int hda_codec_match(struct hdac_device *dev, const struct hdac_driver *drv)
 {
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
-	struct hda_codec_driver *driver =
+	const struct hda_codec_driver *driver =
 		container_of(drv, struct hda_codec_driver, core);
 	const struct hda_device_id *list;
 	/* check probe_id instead of vendor_id if set */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dce568091200..e714e91c2712 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7616,6 +7616,24 @@ static void alc245_fixup_hp_spectre_x360_16_aa0xxx(struct hda_codec *codec,
 	alc245_fixup_hp_gpio_led(codec, fix, action);
 }
 
+static void alc245_fixup_hp_zbook_firefly_g12a(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static const hda_nid_t conn[] = { 0x02 };
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->gen.auto_mute_via_amp = 1;
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	}
+
+	cs35l41_fixup_i2c_two(codec, fix, action);
+	alc245_fixup_hp_mute_led_coefbit(codec, fix, action);
+	alc285_fixup_hp_coef_micmute_led(codec, fix, action);
+}
+
 /*
  * ALC287 PCM hooks
  */
@@ -7963,6 +7981,7 @@ enum {
 	ALC256_FIXUP_HEADPHONE_AMP_VOL,
 	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
 	ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX,
+	ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A,
 	ALC285_FIXUP_ASUS_GA403U,
 	ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC,
 	ALC285_FIXUP_ASUS_GA403U_I2C_SPEAKER2_TO_DAC1,
@@ -10251,6 +10270,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_spectre_x360_16_aa0xxx,
 	},
+	[ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_zbook_firefly_g12a,
+	},
 	[ALC285_FIXUP_ASUS_GA403U] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_asus_ga403u,
@@ -10770,11 +10793,50 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d86, "HP Elite X360 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8c, "HP EliteBook 13 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8d, "HP Elite X360 13 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8e, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d8f, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e11, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e12, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e13, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e17, "HP ZBook Firefly 14 G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e1b, "HP EliteBook G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e1c, "HP EliteBook G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e36, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index c9e7d40c47cc..4a4ec1c09e13 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -464,6 +464,28 @@ static int mca_configure_serdes(struct mca_cluster *cl, int serdes_unit,
 	return -EINVAL;
 }
 
+static int mca_fe_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct mca_cluster *cl = mca_dai_to_cluster(dai);
+	unsigned int mask, nchannels;
+
+	if (cl->tdm_slots) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			mask = cl->tdm_tx_mask;
+		else
+			mask = cl->tdm_rx_mask;
+
+		nchannels = hweight32(mask);
+	} else {
+		nchannels = 2;
+	}
+
+	return snd_pcm_hw_constraint_minmax(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_CHANNELS,
+					    1, nchannels);
+}
+
 static int mca_fe_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int slot_width)
 {
@@ -680,6 +702,7 @@ static int mca_fe_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops mca_fe_ops = {
+	.startup = mca_fe_startup,
 	.set_fmt = mca_fe_set_fmt,
 	.set_bclk_ratio = mca_set_bclk_ratio,
 	.set_tdm_slot = mca_fe_set_tdm_slot,
diff --git a/sound/soc/codecs/hda.c b/sound/soc/codecs/hda.c
index ddc00927313c..dc7794c9ac44 100644
--- a/sound/soc/codecs/hda.c
+++ b/sound/soc/codecs/hda.c
@@ -152,7 +152,7 @@ int hda_codec_probe_complete(struct hda_codec *codec)
 	ret = snd_hda_codec_build_controls(codec);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to create controls %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	/* Bus suspended codecs as it does not manage their pm */
@@ -160,7 +160,7 @@ int hda_codec_probe_complete(struct hda_codec *codec)
 	/* rpm was forbidden in snd_hda_codec_device_new() */
 	snd_hda_codec_set_power_save(codec, 2000);
 	snd_hda_codec_register(codec);
-out:
+
 	/* Complement pm_runtime_get_sync(bus) in probe */
 	pm_runtime_mark_last_busy(bus->dev);
 	pm_runtime_put_autosuspend(bus->dev);
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 39a7d39536fe..4326555aac03 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -540,7 +540,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	tas2764_reset(tas2764);
 
 	if (tas2764->irq) {
-		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0x00);
 		if (ret < 0)
 			return ret;
 
diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 1767ded4d983..c9978fb9c74e 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -372,7 +372,10 @@ static ssize_t trace_control_write(struct file *file, const char __user *from, s
 		return ret;
 
 	num_elems = *array;
-	resource_mask = array[1];
+	if (!num_elems) {
+		ret = -EINVAL;
+		goto free_array;
+	}
 
 	/*
 	 * Disable if just resource mask is provided - no log priority flags.
@@ -380,6 +383,7 @@ static ssize_t trace_control_write(struct file *file, const char __user *from, s
 	 * Enable input format:   mask, prio1, .., prioN
 	 * Where 'N' equals number of bits set in the 'mask'.
 	 */
+	resource_mask = array[1];
 	if (num_elems == 1) {
 		ret = disable_logs(adev, resource_mask);
 	} else {
diff --git a/sound/soc/intel/avs/ipc.c b/sound/soc/intel/avs/ipc.c
index 4fba46e77c47..eff1d46040da 100644
--- a/sound/soc/intel/avs/ipc.c
+++ b/sound/soc/intel/avs/ipc.c
@@ -169,7 +169,9 @@ static void avs_dsp_exception_caught(struct avs_dev *adev, union avs_notify_msg
 
 	dev_crit(adev->dev, "communication severed, rebooting dsp..\n");
 
-	cancel_delayed_work_sync(&ipc->d0ix_work);
+	/* Avoid deadlock as the exception may be the response to SET_D0IX. */
+	if (current_work() != &ipc->d0ix_work.work)
+		cancel_delayed_work_sync(&ipc->d0ix_work);
 	ipc->in_d0ix = false;
 	/* Re-enabled on recovery completion. */
 	pm_runtime_disable(adev->dev);
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 8ebf6c7502aa..400cec09c3a3 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -822,12 +822,12 @@ SND_SOC_DAILINK_DEFS(ETDM1_IN_BE,
 
 SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_IN")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
-		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
diff --git a/sound/soc/sof/amd/pci-acp70.c b/sound/soc/sof/amd/pci-acp70.c
index a5d8b6a95a22..fe2ad0395f5d 100644
--- a/sound/soc/sof/amd/pci-acp70.c
+++ b/sound/soc/sof/amd/pci-acp70.c
@@ -34,6 +34,7 @@ static const struct sof_amd_acp_desc acp70_chip_info = {
 	.ext_intr_cntl = ACP70_EXTERNAL_INTR_CNTL,
 	.ext_intr_stat	= ACP70_EXT_INTR_STAT,
 	.ext_intr_stat1	= ACP70_EXT_INTR_STAT1,
+	.acp_error_stat = ACP70_ERROR_STATUS,
 	.dsp_intr_base	= ACP70_DSP_SW_INTR_BASE,
 	.acp_sw0_i2s_err_reason = ACP7X_SW0_I2S_ERROR_REASON,
 	.sram_pte_offset = ACP70_SRAM_PTE_OFFSET,
diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 2fe4969cdc3b..9db2cdb32128 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -780,7 +780,8 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 
 		/* allocate memory for max number of pipeline IDs */
 		pipeline_list->pipelines = kcalloc(ipc4_data->max_num_pipelines,
-						   sizeof(struct snd_sof_widget *), GFP_KERNEL);
+						   sizeof(*pipeline_list->pipelines),
+						   GFP_KERNEL);
 		if (!pipeline_list->pipelines) {
 			sof_ipc4_pcm_free(sdev, spcm);
 			return -ENOMEM;
diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index cf43ac19c4a6..55e7cb96858f 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -361,17 +361,20 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	if (!card->dai_link)
 		return -ENOMEM;
 
-	compnent = devm_kzalloc(dev, sizeof(*compnent), GFP_KERNEL);
+	compnent = devm_kzalloc(dev, 2 * sizeof(*compnent), GFP_KERNEL);
 	if (!compnent)
 		return -ENOMEM;
-	card->dai_link->cpus		= compnent;
+	card->dai_link->cpus		= &compnent[0];
 	card->dai_link->num_cpus	= 1;
 	card->dai_link->codecs		= &snd_soc_dummy_dlc;
 	card->dai_link->num_codecs	= 1;
+	card->dai_link->platforms	= &compnent[1];
+	card->dai_link->num_platforms	= 1;
 
 	card->dai_link->name = card->name;
 	card->dai_link->stream_name = card->name;
 	card->dai_link->cpus->dai_name = dev_name(ad->dssdev);
+	card->dai_link->platforms->name = dev_name(ad->dssdev);
 	card->num_links = 1;
 	card->dev = dev;
 
diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 4727043fd745..77f06da93151 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -57,6 +57,7 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0002, 0x81, 2), /* Solid State Logic SSL2+ */
 	IMPLICIT_FB_FIXED_DEV(0x0499, 0x172f, 0x81, 2), /* Steinberg UR22C */
 	IMPLICIT_FB_FIXED_DEV(0x0d9a, 0x00df, 0x81, 2), /* RTX6001 */
+	IMPLICIT_FB_FIXED_DEV(0x19f7, 0x000a, 0x84, 3), /* RODE AI-1 */
 	IMPLICIT_FB_FIXED_DEV(0x22f0, 0x0006, 0x81, 3), /* Allen&Heath Qu-16 */
 	IMPLICIT_FB_FIXED_DEV(0x1686, 0xf029, 0x82, 2), /* Zoom UAC-2 */
 	IMPLICIT_FB_FIXED_DEV(0x2466, 0x8003, 0x86, 2), /* Fractal Audio Axe-Fx II */
diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a95d3f..40a9e59c2fd5 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
-#include <stdio.h>
+#include <err.h>
+#include <getopt.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <getopt.h>
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
@@ -145,14 +146,14 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
 		if (!func->leafs)
-			perror("malloc func leaf");
+			err(EXIT_FAILURE, NULL);
 
 		func->nr = 1;
 	} else {
 		s = func->nr;
 		func->leafs = realloc(func->leafs, (s + 1) * sizeof(*leaf));
 		if (!func->leafs)
-			perror("realloc f->leafs");
+			err(EXIT_FAILURE, NULL);
 
 		func->nr++;
 	}
@@ -211,7 +212,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range = malloc(sizeof(struct cpuid_range));
 	if (!range)
-		perror("malloc range");
+		err(EXIT_FAILURE, NULL);
 
 	if (input_eax & 0x80000000)
 		range->is_ext = true;
@@ -220,7 +221,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
-		perror("malloc range->funcs");
+		err(EXIT_FAILURE, NULL);
 
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
@@ -395,8 +396,8 @@ static int parse_line(char *line)
 	return 0;
 
 err_exit:
-	printf("Warning: wrong line format:\n");
-	printf("\tline[%d]: %s\n", flines, line);
+	warnx("Wrong line format:\n"
+	      "\tline[%d]: %s", flines, line);
 	return -1;
 }
 
@@ -418,10 +419,8 @@ static void parse_text(void)
 		file = fopen("./cpuid.csv", "r");
 	}
 
-	if (!file) {
-		printf("Fail to open '%s'\n", filename);
-		return;
-	}
+	if (!file)
+		err(EXIT_FAILURE, "%s", filename);
 
 	while (1) {
 		ret = getline(&line, &len, file);
@@ -530,7 +529,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	func_idx = index & 0xffff;
 
 	if ((func_idx + 1) > (u32)range->nr) {
-		printf("ERR: invalid input index (0x%x)\n", index);
+		warnx("Invalid input index (0x%x)", index);
 		return NULL;
 	}
 	return &range->funcs[func_idx];
@@ -562,7 +561,7 @@ static void show_info(void)
 				return;
 			}
 
-			printf("ERR: invalid input subleaf (0x%x)\n", user_sub);
+			warnx("Invalid input subleaf (0x%x)", user_sub);
 		}
 
 		show_func(func);
@@ -593,15 +592,15 @@ static void setup_platform_cpuid(void)
 
 static void usage(void)
 {
-	printf("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
-		"\t-a|--all             Show both bit flags and complex bit fields info\n"
-		"\t-b|--bitflags        Show boolean flags only\n"
-		"\t-d|--detail          Show details of the flag/fields (default)\n"
-		"\t-f|--flags           Specify the cpuid csv file\n"
-		"\t-h|--help            Show usage info\n"
-		"\t-l|--leaf=index      Specify the leaf you want to check\n"
-		"\t-r|--raw             Show raw cpuid data\n"
-		"\t-s|--subleaf=sub     Specify the subleaf you want to check\n"
+	warnx("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	      "\t-a|--all             Show both bit flags and complex bit fields info\n"
+	      "\t-b|--bitflags        Show boolean flags only\n"
+	      "\t-d|--detail          Show details of the flag/fields (default)\n"
+	      "\t-f|--flags           Specify the CPUID CSV file\n"
+	      "\t-h|--help            Show usage info\n"
+	      "\t-l|--leaf=index      Specify the leaf you want to check\n"
+	      "\t-r|--raw             Show raw CPUID data\n"
+	      "\t-s|--subleaf=sub     Specify the subleaf you want to check"
 	);
 }
 
@@ -652,7 +651,7 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			printf("%s: Invalid option '%c'\n", argv[0], optopt);
+			warnx("Invalid option '%c'", optopt);
 			return -1;
 	}
 
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index f5dd84eb55dc..cd3fd5155f6e 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -35,7 +35,7 @@
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
 #
-# REX2 Prefix
+# REX2 Prefix Superscripts
 #  - (!REX2): REX2 is not allowed
 #  - (REX2): REX2 variant e.g. JMPABS
 
@@ -286,10 +286,10 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
-e1: LOOPE/LOOPZ Jb (f64) (!REX2)
-e2: LOOP Jb (f64) (!REX2)
-e3: JrCXZ Jb (f64) (!REX2)
+e0: LOOPNE/LOOPNZ Jb (f64),(!REX2)
+e1: LOOPE/LOOPZ Jb (f64),(!REX2)
+e2: LOOP Jb (f64),(!REX2)
+e3: JrCXZ Jb (f64),(!REX2)
 e4: IN AL,Ib (!REX2)
 e5: IN eAX,Ib (!REX2)
 e6: OUT Ib,AL (!REX2)
@@ -298,10 +298,10 @@ e7: OUT Ib,eAX (!REX2)
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64) (!REX2)
-e9: JMP-near Jz (f64) (!REX2)
-ea: JMP-far Ap (i64) (!REX2)
-eb: JMP-short Jb (f64) (!REX2)
+e8: CALL Jz (f64),(!REX2)
+e9: JMP-near Jz (f64),(!REX2)
+ea: JMP-far Ap (i64),(!REX2)
+eb: JMP-short Jb (f64),(!REX2)
 ec: IN AL,DX (!REX2)
 ed: IN eAX,DX (!REX2)
 ee: OUT DX,AL (!REX2)
@@ -478,22 +478,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64) (!REX2)
-81: JNO Jz (f64) (!REX2)
-82: JB/JC/JNAE Jz (f64) (!REX2)
-83: JAE/JNB/JNC Jz (f64) (!REX2)
-84: JE/JZ Jz (f64) (!REX2)
-85: JNE/JNZ Jz (f64) (!REX2)
-86: JBE/JNA Jz (f64) (!REX2)
-87: JA/JNBE Jz (f64) (!REX2)
-88: JS Jz (f64) (!REX2)
-89: JNS Jz (f64) (!REX2)
-8a: JP/JPE Jz (f64) (!REX2)
-8b: JNP/JPO Jz (f64) (!REX2)
-8c: JL/JNGE Jz (f64) (!REX2)
-8d: JNL/JGE Jz (f64) (!REX2)
-8e: JLE/JNG Jz (f64) (!REX2)
-8f: JNLE/JG Jz (f64) (!REX2)
+80: JO Jz (f64),(!REX2)
+81: JNO Jz (f64),(!REX2)
+82: JB/JC/JNAE Jz (f64),(!REX2)
+83: JAE/JNB/JNC Jz (f64),(!REX2)
+84: JE/JZ Jz (f64),(!REX2)
+85: JNE/JNZ Jz (f64),(!REX2)
+86: JBE/JNA Jz (f64),(!REX2)
+87: JA/JNBE Jz (f64),(!REX2)
+88: JS Jz (f64),(!REX2)
+89: JNS Jz (f64),(!REX2)
+8a: JP/JPE Jz (f64),(!REX2)
+8b: JNP/JPO Jz (f64),(!REX2)
+8c: JL/JNGE Jz (f64),(!REX2)
+8d: JNL/JGE Jz (f64),(!REX2)
+8e: JLE/JNG Jz (f64),(!REX2)
+8f: JNLE/JG Jz (f64),(!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 9af426d43299..afab728468bf 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -221,7 +221,7 @@ static int cgroup_has_attached_progs(int cgroup_fd)
 	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
 		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
 
-		if (count < 0)
+		if (count < 0 && errno != EINVAL)
 			return -1;
 
 		if (count > 0) {
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 4b8079f294f6..b0072e64b010 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,7 +19,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
+		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc
diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index c0e13cdf9660..b997c68bd945 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -388,7 +388,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
 #define ___arrow10(a, b, c, d, e, f, g, h, i, j) a->b->c->d->e->f->g->h->i->j
 #define ___arrow(...) ___apply(___arrow, ___narg(__VA_ARGS__))(__VA_ARGS__)
 
+#if defined(__clang__) && (__clang_major__ >= 19)
+#define ___type(...) __typeof_unqual__(___arrow(__VA_ARGS__))
+#elif defined(__GNUC__) && (__GNUC__ >= 14)
+#define ___type(...) __typeof_unqual__(___arrow(__VA_ARGS__))
+#else
 #define ___type(...) typeof(___arrow(__VA_ARGS__))
+#endif
 
 #define ___read(read_fn, dst, src_type, src, accessor)			    \
 	read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6e4d417604fa..bb24f6bac207 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -60,6 +60,8 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#define MAX_EVENT_NAME_LEN	64
+
 #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
 
 #define BPF_INSN_SZ (sizeof(struct bpf_insn))
@@ -283,7 +285,7 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 	old_errno = errno;
 
 	va_start(args, format);
-	__libbpf_pr(level, format, args);
+	print_fn(level, format, args);
 	va_end(args);
 
 	errno = old_errno;
@@ -887,7 +889,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		if (sec_off + prog_sz > sec_sz) {
+		if (sec_off + prog_sz > sec_sz || sec_off + prog_sz < sec_off) {
 			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
 				sec_name, sec_off);
 			return -LIBBPF_ERRNO__FORMAT;
@@ -11039,16 +11041,16 @@ static const char *tracefs_available_filter_functions_addrs(void)
 			     : TRACEFS"/available_filter_functions_addrs";
 }
 
-static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
-					 const char *kfunc_name, size_t offset)
+static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
+					const char *name, size_t offset)
 {
 	static int index = 0;
 	int i;
 
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
-		 __sync_fetch_and_add(&index, 1));
+	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
+		 __sync_fetch_and_add(&index, 1), name, offset);
 
-	/* sanitize binary_path in the probe name */
+	/* sanitize name in the probe name */
 	for (i = 0; buf[i]; i++) {
 		if (!isalnum(buf[i]))
 			buf[i] = '_';
@@ -11174,9 +11176,9 @@ int probe_kern_syscall_wrapper(int token_fd)
 
 		return pfd >= 0 ? 1 : 0;
 	} else { /* legacy mode */
-		char probe_name[128];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
-		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
+		gen_probe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
 		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
 			return 0;
 
@@ -11233,10 +11235,10 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 					    func_name, offset,
 					    -1 /* pid */, 0 /* ref_ctr_off */);
 	} else {
-		char probe_name[256];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
-		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     func_name, offset);
+		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
+					    func_name, offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
@@ -11744,20 +11746,6 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
-static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
-					 const char *binary_path, uint64_t offset)
-{
-	int i;
-
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
-
-	/* sanitize binary_path in the probe name */
-	for (i = 0; buf[i]; i++) {
-		if (!isalnum(buf[i]))
-			buf[i] = '_';
-	}
-}
-
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
@@ -12173,13 +12161,14 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
 	} else {
-		char probe_name[PATH_MAX + 64];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
 		if (ref_ctr_off)
 			return libbpf_err_ptr(-EINVAL);
 
-		gen_uprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     binary_path, func_offset);
+		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
+					    strrchr(binary_path, '/') ? : binary_path,
+					    func_offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
@@ -13256,7 +13245,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = sample_period;
 	attr.wakeup_events = sample_period;
 
 	p.attr = &attr;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 179f6b31cbd6..d4ab9315afe7 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1220,7 +1220,7 @@ static int linker_append_sec_data(struct bpf_linker *linker, struct src_obj *obj
 		} else {
 			if (!secs_match(dst_sec, src_sec)) {
 				pr_warn("ELF sections %s are incompatible\n", src_sec->sec_name);
-				return -1;
+				return -EINVAL;
 			}
 
 			/* "license" and "version" sections are deduped */
@@ -2067,7 +2067,7 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 			}
 		} else if (!secs_match(dst_sec, src_sec)) {
 			pr_warn("sections %s are not compatible\n", src_sec->sec_name);
-			return -1;
+			return -EINVAL;
 		}
 
 		/* shdr->sh_link points to SYMTAB */
diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index 975e265eab3b..06663f9ea581 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -63,16 +63,16 @@ static int validate_nla(struct nlattr *nla, int maxtype,
 		minlen = nla_attr_minlen[pt->type];
 
 	if (libbpf_nla_len(nla) < minlen)
-		return -1;
+		return -EINVAL;
 
 	if (pt->maxlen && libbpf_nla_len(nla) > pt->maxlen)
-		return -1;
+		return -EINVAL;
 
 	if (pt->type == LIBBPF_NLA_STRING) {
 		char *data = libbpf_nla_data(nla);
 
 		if (data[libbpf_nla_len(nla) - 1] != '\0')
-			return -1;
+			return -EINVAL;
 	}
 
 	return 0;
@@ -118,19 +118,18 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
 		if (policy) {
 			err = validate_nla(nla, maxtype, policy);
 			if (err < 0)
-				goto errout;
+				return err;
 		}
 
-		if (tb[type])
+		if (tb[type]) {
 			pr_warn("Attribute of type %#x found multiple times in message, "
 				"previous attribute is being ignored.\n", type);
+		}
 
 		tb[type] = nla;
 	}
 
-	err = 0;
-errout:
-	return err;
+	return 0;
 }
 
 /**
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4fce0074076f..a737286de759 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -222,7 +222,8 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_7___rustc17rust_begin_unwind")				||
 	       strstr(func->name, "_4core9panicking13assert_failed")					||
 	       strstr(func->name, "_4core9panicking11panic_const24panic_const_")			||
-	       (strstr(func->name, "_4core5slice5index24slice_") &&
+	       (strstr(func->name, "_4core5slice5index") &&
+		strstr(func->name, "slice_") &&
 		str_ends_with(func->name, "_fail"));
 }
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b102a4c525e4..a2034fa18325 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -569,6 +569,8 @@ ifndef NO_LIBELF
     ifeq ($(feature-libdebuginfod), 1)
       CFLAGS += -DHAVE_DEBUGINFOD_SUPPORT
       EXTLIBS += -ldebuginfod
+    else
+      $(warning No elfutils/debuginfod.h found, no debuginfo server support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent)
     endif
   endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8ee59ecb1411..b61c355fbdee 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1143,7 +1143,8 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
-		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
+		$(INSTALL) tests/shell/base_report/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
+		$(INSTALL) tests/shell/base_report/*.txt '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight' ; \
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..ab9035573a15 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3471,7 +3471,7 @@ static struct option __record_options[] = {
 		    "sample selected machine registers on interrupt,"
 		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
-		    "sample selected machine registers on interrupt,"
+		    "sample selected machine registers in user space,"
 		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ecd26e058baf..f77e4f4b6f03 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1327,7 +1327,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
 		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
-	{ .name	    = "rseq",	    .errpid = true,
+	{ .name	    = "rseq",
 	  .arg = { [0] = { .from_user = true /* rseq */, }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
@@ -1351,7 +1351,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "sendto",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ },
 		   [4] = SCA_SOCKADDR_FROM_USER(addr), }, },
-	{ .name	    = "set_robust_list",	    .errpid = true,
+	{ .name	    = "set_robust_list",
 	  .arg = { [0] = { .from_user = true /* head */, }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
 	{ .name	    = "setitimer",
@@ -2873,8 +2873,8 @@ errno_print: {
 	else if (sc->fmt->errpid) {
 		struct thread *child = machine__find_thread(trace->host, ret, ret);
 
+		fprintf(trace->output, "%ld", ret);
 		if (child != NULL) {
-			fprintf(trace->output, "%ld", ret);
 			if (thread__comm_set(child))
 				fprintf(trace->output, " (%s)", thread__comm_str(child));
 			thread__put(child);
@@ -3986,10 +3986,13 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		if (!strcmp(thread__comm_str(parent), "sshd") ||
 		    strstarts(thread__comm_str(parent), "gnome-terminal")) {
 			pids[nr++] = thread__tid(parent);
+			thread__put(parent);
 			break;
 		}
+		thread__put(thread);
 		thread = parent;
 	}
+	thread__put(thread);
 
 	err = evlist__append_tp_filter_pids(trace->evlist, nr, pids);
 	if (!err && trace->filter_pids.map)
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 121cf61ba1b3..e0b2e7268ef6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -680,7 +680,10 @@ class CallGraphModelBase(TreeModel):
 				s = value.replace("%", "\\%")
 				s = s.replace("_", "\\_")
 				# Translate * and ? into SQL LIKE pattern characters % and _
-				trans = string.maketrans("*?", "%_")
+				if sys.version_info[0] == 3:
+					trans = str.maketrans("*?", "%_")
+				else:
+					trans = string.maketrans("*?", "%_")
 				match = " LIKE '" + str(s).translate(trans) + "'"
 			else:
 				match = " GLOB '" + str(value) + "'"
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5cab17a1942e..ee43d8fa2ed6 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -258,7 +258,7 @@ static int compar(const void *a, const void *b)
 	const struct event_node *nodeb = b;
 	s64 cmp = nodea->event_time - nodeb->event_time;
 
-	return cmp;
+	return cmp < 0 ? -1 : (cmp > 0 ? 1 : 0);
 }
 
 static int process_events(struct evlist *evlist,
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 49ba82bf3391..3283b6313bab 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3267,10 +3267,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 				/*
 				 * No need to set actions->dso here since
 				 * it's just to remove the current filter.
-				 * Ditto for thread below.
 				 */
 				do_zoom_dso(browser, actions);
 			} else if (top == &browser->hists->thread_filter) {
+				actions->thread = thread;
 				do_zoom_thread(browser, actions);
 			} else if (top == &browser->hists->socket_filter) {
 				do_zoom_socket(browser, actions);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fd2597613f3d..61f10578e121 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -127,6 +127,7 @@ struct intel_pt {
 
 	bool single_pebs;
 	bool sample_pebs;
+	int pebs_data_src_fmt;
 	struct evsel *pebs_evsel;
 
 	u64 evt_sample_type;
@@ -175,6 +176,7 @@ enum switch_state {
 struct intel_pt_pebs_event {
 	struct evsel *evsel;
 	u64 id;
+	int data_src_fmt;
 };
 
 struct intel_pt_queue {
@@ -2232,7 +2234,146 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
 	}
 }
 
-static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel, u64 id)
+#define P(a, b) PERF_MEM_S(a, b)
+#define OP_LH (P(OP, LOAD) | P(LVL, HIT))
+#define LEVEL(x) P(LVLNUM, x)
+#define REM P(REMOTE, REMOTE)
+#define SNOOP_NONE_MISS (P(SNOOP, NONE) | P(SNOOP, MISS))
+
+#define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
+#define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
+
+/* Based on kernel __intel_pmu_pebs_data_source_grt() and pebs_data_source */
+static const u64 pebs_data_source_grt[PERF_PEBS_DATA_SOURCE_GRT_MAX] = {
+	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),         /* L3 miss|SNP N/A */
+	OP_LH | P(LVL, L1)  | LEVEL(L1)  | P(SNOOP, NONE),             /* L1 hit|SNP None */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),             /* LFB/MAB hit|SNP None */
+	OP_LH | P(LVL, L2)  | LEVEL(L2)  | P(SNOOP, NONE),             /* L2 hit|SNP None */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, NONE),             /* L3 hit|SNP None */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HIT),              /* L3 hit|SNP Hit */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HITM),             /* L3 hit|SNP HitM */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HITM),             /* L3 hit|SNP HitM */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOPX, FWD),             /* L3 hit|SNP Fwd */
+	OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM),   /* Remote L3 hit|SNP HitM */
+	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, HIT),         /* RAM hit|SNP Hit */
+	OP_LH | P(LVL, REM_RAM1) | REM | LEVEL(L3) | P(SNOOP, HIT),    /* Remote L3 hit|SNP Hit */
+	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | SNOOP_NONE_MISS,       /* RAM hit|SNP None or Miss */
+	OP_LH | P(LVL, REM_RAM1) | LEVEL(RAM) | REM | SNOOP_NONE_MISS, /* Remote RAM hit|SNP None or Miss */
+	OP_LH | P(LVL, IO)  | LEVEL(NA) | P(SNOOP, NONE),              /* I/O hit|SNP None */
+	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),              /* Uncached hit|SNP None */
+};
+
+/* Based on kernel __intel_pmu_pebs_data_source_cmt() and pebs_data_source */
+static const u64 pebs_data_source_cmt[PERF_PEBS_DATA_SOURCE_GRT_MAX] = {
+	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),       /* L3 miss|SNP N/A */
+	OP_LH | P(LVL, L1)  | LEVEL(L1)  | P(SNOOP, NONE),           /* L1 hit|SNP None */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),           /* LFB/MAB hit|SNP None */
+	OP_LH | P(LVL, L2)  | LEVEL(L2)  | P(SNOOP, NONE),           /* L2 hit|SNP None */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, NONE),           /* L3 hit|SNP None */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, MISS),           /* L3 hit|SNP Hit */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HIT),            /* L3 hit|SNP HitM */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOPX, FWD),           /* L3 hit|SNP HitM */
+	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HITM),           /* L3 hit|SNP Fwd */
+	OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM), /* Remote L3 hit|SNP HitM */
+	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE),      /* RAM hit|SNP Hit */
+	OP_LH | LEVEL(RAM) | REM | P(SNOOP, NONE),                   /* Remote L3 hit|SNP Hit */
+	OP_LH | LEVEL(RAM) | REM | P(SNOOPX, FWD),                   /* RAM hit|SNP None or Miss */
+	OP_LH | LEVEL(RAM) | REM | P(SNOOP, HITM),                   /* Remote RAM hit|SNP None or Miss */
+	OP_LH | P(LVL, IO)  | LEVEL(NA) | P(SNOOP, NONE),            /* I/O hit|SNP None */
+	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),            /* Uncached hit|SNP None */
+};
+
+/* Based on kernel pebs_set_tlb_lock() */
+static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
+{
+	/*
+	 * TLB access
+	 * 0 = did not miss 2nd level TLB
+	 * 1 = missed 2nd level TLB
+	 */
+	if (tlb)
+		*val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		*val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	/* locked prefix */
+	if (lock)
+		*val |= P(LOCK, LOCKED);
+}
+
+/* Based on kernel __grt_latency_data() */
+static u64 intel_pt_grt_latency_data(u8 dse, bool tlb, bool lock, bool blk,
+				     const u64 *pebs_data_source)
+{
+	u64 val;
+
+	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
+	val = pebs_data_source[dse];
+
+	pebs_set_tlb_lock(&val, tlb, lock);
+
+	if (blk)
+		val |= P(BLK, DATA);
+	else
+		val |= P(BLK, NA);
+
+	return val;
+}
+
+/* Default value for data source */
+#define PERF_MEM_NA (PERF_MEM_S(OP, NA)    |\
+		     PERF_MEM_S(LVL, NA)   |\
+		     PERF_MEM_S(SNOOP, NA) |\
+		     PERF_MEM_S(LOCK, NA)  |\
+		     PERF_MEM_S(TLB, NA)   |\
+		     PERF_MEM_S(LVLNUM, NA))
+
+enum DATA_SRC_FORMAT {
+	DATA_SRC_FORMAT_ERR  = -1,
+	DATA_SRC_FORMAT_NA   =  0,
+	DATA_SRC_FORMAT_GRT  =  1,
+	DATA_SRC_FORMAT_CMT  =  2,
+};
+
+/* Based on kernel grt_latency_data() and cmt_latency_data */
+static u64 intel_pt_get_data_src(u64 mem_aux_info, int data_src_fmt)
+{
+	switch (data_src_fmt) {
+	case DATA_SRC_FORMAT_GRT: {
+		union {
+			u64 val;
+			struct {
+				unsigned int dse:4;
+				unsigned int locked:1;
+				unsigned int stlb_miss:1;
+				unsigned int fwd_blk:1;
+				unsigned int reserved:25;
+			};
+		} x = {.val = mem_aux_info};
+		return intel_pt_grt_latency_data(x.dse, x.stlb_miss, x.locked, x.fwd_blk,
+						 pebs_data_source_grt);
+	}
+	case DATA_SRC_FORMAT_CMT: {
+		union {
+			u64 val;
+			struct {
+				unsigned int dse:5;
+				unsigned int locked:1;
+				unsigned int stlb_miss:1;
+				unsigned int fwd_blk:1;
+				unsigned int reserved:24;
+			};
+		} x = {.val = mem_aux_info};
+		return intel_pt_grt_latency_data(x.dse, x.stlb_miss, x.locked, x.fwd_blk,
+						 pebs_data_source_cmt);
+	}
+	default:
+		return PERF_MEM_NA;
+	}
+}
+
+static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel,
+					 u64 id, int data_src_fmt)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
 	struct perf_sample sample = { .ip = 0, };
@@ -2350,6 +2491,18 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		}
 	}
 
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		if (items->has_mem_aux_info && data_src_fmt) {
+			if (data_src_fmt < 0) {
+				pr_err("Intel PT missing data_src info\n");
+				return -1;
+			}
+			sample.data_src = intel_pt_get_data_src(items->mem_aux_info, data_src_fmt);
+		} else {
+			sample.data_src = PERF_MEM_NA;
+		}
+	}
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION && items->has_tsx_aux_info) {
 		u64 ax = items->has_rax ? items->rax : 0;
 		/* Refer kernel's intel_hsw_transaction() */
@@ -2368,9 +2521,10 @@ static int intel_pt_synth_single_pebs_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	struct evsel *evsel = pt->pebs_evsel;
+	int data_src_fmt = pt->pebs_data_src_fmt;
 	u64 id = evsel->core.id[0];
 
-	return intel_pt_do_synth_pebs_sample(ptq, evsel, id);
+	return intel_pt_do_synth_pebs_sample(ptq, evsel, id, data_src_fmt);
 }
 
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
@@ -2395,7 +2549,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 				       hw_id);
 			return intel_pt_synth_single_pebs_sample(ptq);
 		}
-		err = intel_pt_do_synth_pebs_sample(ptq, pe->evsel, pe->id);
+		err = intel_pt_do_synth_pebs_sample(ptq, pe->evsel, pe->id, pe->data_src_fmt);
 		if (err)
 			return err;
 	}
@@ -3355,6 +3509,49 @@ static int intel_pt_process_itrace_start(struct intel_pt *pt,
 					event->itrace_start.tid);
 }
 
+/*
+ * Events with data_src are identified by L1_Hit_Indication
+ * refer https://github.com/intel/perfmon
+ */
+static int intel_pt_data_src_fmt(struct intel_pt *pt, struct evsel *evsel)
+{
+	struct perf_env *env = pt->machine->env;
+	int fmt = DATA_SRC_FORMAT_NA;
+
+	if (!env->cpuid)
+		return DATA_SRC_FORMAT_ERR;
+
+	/*
+	 * PEBS-via-PT is only supported on E-core non-hybrid. Of those only
+	 * Gracemont and Crestmont have data_src. Check for:
+	 *	Alderlake N   (Gracemont)
+	 *	Sierra Forest (Crestmont)
+	 *	Grand Ridge   (Crestmont)
+	 */
+
+	if (!strncmp(env->cpuid, "GenuineIntel,6,190,", 19))
+		fmt = DATA_SRC_FORMAT_GRT;
+
+	if (!strncmp(env->cpuid, "GenuineIntel,6,175,", 19) ||
+	    !strncmp(env->cpuid, "GenuineIntel,6,182,", 19))
+		fmt = DATA_SRC_FORMAT_CMT;
+
+	if (fmt == DATA_SRC_FORMAT_NA)
+		return fmt;
+
+	/*
+	 * Only data_src events are:
+	 *	mem-loads	event=0xd0,umask=0x5
+	 *	mem-stores	event=0xd0,umask=0x6
+	 */
+	if (evsel->core.attr.type == PERF_TYPE_RAW &&
+	    ((evsel->core.attr.config & 0xffff) == 0x5d0 ||
+	     (evsel->core.attr.config & 0xffff) == 0x6d0))
+		return fmt;
+
+	return DATA_SRC_FORMAT_NA;
+}
+
 static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
 					     union perf_event *event,
 					     struct perf_sample *sample)
@@ -3375,6 +3572,7 @@ static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
 
 	ptq->pebs[hw_id].evsel = evsel;
 	ptq->pebs[hw_id].id = sample->id;
+	ptq->pebs[hw_id].data_src_fmt = intel_pt_data_src_fmt(pt, evsel);
 
 	return 0;
 }
@@ -3924,6 +4122,7 @@ static void intel_pt_setup_pebs_events(struct intel_pt *pt)
 			}
 			pt->single_pebs = true;
 			pt->sample_pebs = true;
+			pt->pebs_data_src_fmt = intel_pt_data_src_fmt(pt, evsel);
 			pt->pebs_evsel = evsel;
 		}
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9be2f4479f52..20fd742984e3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1974,7 +1974,7 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, &al);
+	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2076,7 +2076,7 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, &al);
+		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2104,6 +2104,8 @@ static int add_callchain_ip(struct thread *thread,
 		}
 		if (symbols)
 			thread__find_symbol(thread, *cpumode, ip, &al);
+		else
+			thread__find_map(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index c6f369b5d893..36c1d3090689 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -90,11 +90,23 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 {
 	FILE *fp;
 	int ret = -1;
-	bool need_swap = false;
+	bool need_swap = false, elf32;
 	u8 e_ident[EI_NIDENT];
-	size_t buf_size;
-	void *buf;
 	int i;
+	union {
+		struct {
+			Elf32_Ehdr ehdr32;
+			Elf32_Phdr *phdr32;
+		};
+		struct {
+			Elf64_Ehdr ehdr64;
+			Elf64_Phdr *phdr64;
+		};
+	} hdrs;
+	void *phdr;
+	size_t phdr_size;
+	void *buf = NULL;
+	size_t buf_size = 0;
 
 	fp = fopen(filename, "r");
 	if (fp == NULL)
@@ -108,117 +120,79 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 		goto out;
 
 	need_swap = check_need_swap(e_ident[EI_DATA]);
+	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
 
-	/* for simplicity */
-	fseek(fp, 0, SEEK_SET);
-
-	if (e_ident[EI_CLASS] == ELFCLASS32) {
-		Elf32_Ehdr ehdr;
-		Elf32_Phdr *phdr;
-
-		if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
-			goto out;
+	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
+		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64),
+		  1, fp) != 1)
+		goto out;
 
-		if (need_swap) {
-			ehdr.e_phoff = bswap_32(ehdr.e_phoff);
-			ehdr.e_phentsize = bswap_16(ehdr.e_phentsize);
-			ehdr.e_phnum = bswap_16(ehdr.e_phnum);
+	if (need_swap) {
+		if (elf32) {
+			hdrs.ehdr32.e_phoff = bswap_32(hdrs.ehdr32.e_phoff);
+			hdrs.ehdr32.e_phentsize = bswap_16(hdrs.ehdr32.e_phentsize);
+			hdrs.ehdr32.e_phnum = bswap_16(hdrs.ehdr32.e_phnum);
+		} else {
+			hdrs.ehdr64.e_phoff = bswap_64(hdrs.ehdr64.e_phoff);
+			hdrs.ehdr64.e_phentsize = bswap_16(hdrs.ehdr64.e_phentsize);
+			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
 		}
+	}
+	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
+			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
+	phdr = malloc(phdr_size);
+	if (phdr == NULL)
+		goto out;
 
-		buf_size = ehdr.e_phentsize * ehdr.e_phnum;
-		buf = malloc(buf_size);
-		if (buf == NULL)
-			goto out;
-
-		fseek(fp, ehdr.e_phoff, SEEK_SET);
-		if (fread(buf, buf_size, 1, fp) != 1)
-			goto out_free;
-
-		for (i = 0, phdr = buf; i < ehdr.e_phnum; i++, phdr++) {
-			void *tmp;
-			long offset;
-
-			if (need_swap) {
-				phdr->p_type = bswap_32(phdr->p_type);
-				phdr->p_offset = bswap_32(phdr->p_offset);
-				phdr->p_filesz = bswap_32(phdr->p_filesz);
-			}
-
-			if (phdr->p_type != PT_NOTE)
-				continue;
-
-			buf_size = phdr->p_filesz;
-			offset = phdr->p_offset;
-			tmp = realloc(buf, buf_size);
-			if (tmp == NULL)
-				goto out_free;
-
-			buf = tmp;
-			fseek(fp, offset, SEEK_SET);
-			if (fread(buf, buf_size, 1, fp) != 1)
-				goto out_free;
+	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
+	if (fread(phdr, phdr_size, 1, fp) != 1)
+		goto out_free;
 
-			ret = read_build_id(buf, buf_size, bid, need_swap);
-			if (ret == 0) {
-				ret = bid->size;
-				break;
-			}
-		}
-	} else {
-		Elf64_Ehdr ehdr;
-		Elf64_Phdr *phdr;
+	if (elf32)
+		hdrs.phdr32 = phdr;
+	else
+		hdrs.phdr64 = phdr;
 
-		if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
-			goto out;
+	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
+		size_t p_filesz;
 
 		if (need_swap) {
-			ehdr.e_phoff = bswap_64(ehdr.e_phoff);
-			ehdr.e_phentsize = bswap_16(ehdr.e_phentsize);
-			ehdr.e_phnum = bswap_16(ehdr.e_phnum);
+			if (elf32) {
+				hdrs.phdr32[i].p_type = bswap_32(hdrs.phdr32[i].p_type);
+				hdrs.phdr32[i].p_offset = bswap_32(hdrs.phdr32[i].p_offset);
+				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);
+			} else {
+				hdrs.phdr64[i].p_type = bswap_32(hdrs.phdr64[i].p_type);
+				hdrs.phdr64[i].p_offset = bswap_64(hdrs.phdr64[i].p_offset);
+				hdrs.phdr64[i].p_filesz = bswap_64(hdrs.phdr64[i].p_filesz);
+			}
 		}
+		if ((elf32 ? hdrs.phdr32[i].p_type : hdrs.phdr64[i].p_type) != PT_NOTE)
+			continue;
 
-		buf_size = ehdr.e_phentsize * ehdr.e_phnum;
-		buf = malloc(buf_size);
-		if (buf == NULL)
-			goto out;
-
-		fseek(fp, ehdr.e_phoff, SEEK_SET);
-		if (fread(buf, buf_size, 1, fp) != 1)
-			goto out_free;
-
-		for (i = 0, phdr = buf; i < ehdr.e_phnum; i++, phdr++) {
+		p_filesz = elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr64[i].p_filesz;
+		if (p_filesz > buf_size) {
 			void *tmp;
-			long offset;
-
-			if (need_swap) {
-				phdr->p_type = bswap_32(phdr->p_type);
-				phdr->p_offset = bswap_64(phdr->p_offset);
-				phdr->p_filesz = bswap_64(phdr->p_filesz);
-			}
 
-			if (phdr->p_type != PT_NOTE)
-				continue;
-
-			buf_size = phdr->p_filesz;
-			offset = phdr->p_offset;
+			buf_size = p_filesz;
 			tmp = realloc(buf, buf_size);
 			if (tmp == NULL)
 				goto out_free;
-
 			buf = tmp;
-			fseek(fp, offset, SEEK_SET);
-			if (fread(buf, buf_size, 1, fp) != 1)
-				goto out_free;
+		}
+		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
+		if (fread(buf, p_filesz, 1, fp) != 1)
+			goto out_free;
 
-			ret = read_build_id(buf, buf_size, bid, need_swap);
-			if (ret == 0) {
-				ret = bid->size;
-				break;
-			}
+		ret = read_build_id(buf, p_filesz, bid, need_swap);
+		if (ret == 0) {
+			ret = bid->size;
+			break;
 		}
 	}
 out_free:
 	free(buf);
+	free(phdr);
 out:
 	fclose(fp);
 	return ret;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0ffdd52d86d7..309d573eac9a 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -406,7 +406,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al)
+					bool symbols, struct addr_location *al)
 {
 	size_t i;
 	const u8 cpumodes[] = {
@@ -417,7 +417,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
-		thread__find_symbol(thread, cpumodes[i], addr, al);
+		if (symbols)
+			thread__find_symbol(thread, cpumodes[i], addr, al);
+		else
+			thread__find_map(thread, cpumodes[i], addr, al);
+
 		if (al->map)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 6cbf6eb2812e..1fb32e7d62a4 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -122,7 +122,7 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al);
+					bool symbols, struct addr_location *al);
 
 int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit);
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 12424bf08551..4c322586730d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4491,6 +4491,38 @@ unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
 	return (value & value_mask) >> value_shift;
 }
 
+
+/* Rapl domain enumeration helpers */
+static inline int get_rapl_num_domains(void)
+{
+	int num_packages = topo.max_package_id + 1;
+	int num_cores_per_package;
+	int num_cores;
+
+	if (!platform->has_per_core_rapl)
+		return num_packages;
+
+	num_cores_per_package = topo.max_core_id + 1;
+	num_cores = num_cores_per_package * num_packages;
+
+	return num_cores;
+}
+
+static inline int get_rapl_domain_id(int cpu)
+{
+	int nr_cores_per_package = topo.max_core_id + 1;
+	int rapl_core_id;
+
+	if (!platform->has_per_core_rapl)
+		return cpus[cpu].physical_package_id;
+
+	/* Compute the system-wide unique core-id for @cpu */
+	rapl_core_id = cpus[cpu].physical_core_id;
+	rapl_core_id += cpus[cpu].physical_package_id * nr_cores_per_package;
+
+	return rapl_core_id;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -4544,7 +4576,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		goto done;
 
 	if (platform->has_per_core_rapl) {
-		status = get_rapl_counters(cpu, c->core_id, c, p);
+		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
 	}
@@ -4610,7 +4642,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
 	if (!platform->has_per_core_rapl) {
-		status = get_rapl_counters(cpu, p->package_id, c, p);
+		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
 	}
@@ -7570,7 +7602,7 @@ void linux_perf_init(void)
 
 void rapl_perf_init(void)
 {
-	const unsigned int num_domains = (platform->has_per_core_rapl ? topo.max_core_id : topo.max_package_id) + 1;
+	const unsigned int num_domains = get_rapl_num_domains();
 	bool *domain_visited = calloc(num_domains, sizeof(bool));
 
 	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
@@ -7611,8 +7643,7 @@ void rapl_perf_init(void)
 				continue;
 
 			/* Skip already seen and handled RAPL domains */
-			next_domain =
-			    platform->has_per_core_rapl ? cpus[cpu].physical_core_id : cpus[cpu].physical_package_id;
+			next_domain = get_rapl_domain_id(cpu);
 
 			assert(next_domain < num_domains);
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9cf769d41568..85c5f39131d3 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -196,7 +196,7 @@ export KHDR_INCLUDES
 
 all:
 	@ret=1;							\
-	for TARGET in $(TARGETS); do				\
+	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do	\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index a4a1f93878d4..fad98f01e2c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -63,6 +63,12 @@ static void test_bpf_nf_ct(int mode)
 		.repeat = 1,
 	);
 
+	if (SYS_NOFAIL("iptables-legacy --version")) {
+		fprintf(stdout, "Missing required iptables-legacy tool\n");
+		test__skip();
+		return;
+	}
+
 	skel = test_bpf_nf__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
 		return;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3e9b009580d4..7f69d7b5bd4d 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -970,6 +970,14 @@ void run_subtest(struct test_loader *tester,
 	emit_verifier_log(tester->log_buf, false /*force*/);
 	validate_msgs(tester->log_buf, &subspec->expect_msgs, emit_verifier_log);
 
+	/* Restore capabilities because the kernel will silently ignore requests
+	 * for program info (such as xlated program text) if we are not
+	 * bpf-capable. Also, for some reason test_verifier executes programs
+	 * with all capabilities restored. Do the same here.
+	 */
+	if (restore_capabilities(&caps))
+		goto tobj_cleanup;
+
 	if (subspec->expect_xlated.cnt) {
 		err = get_xlated_program_text(bpf_program__fd(tprog),
 					      tester->log_buf, tester->log_buf_sz);
@@ -995,12 +1003,6 @@ void run_subtest(struct test_loader *tester,
 	}
 
 	if (should_do_test_run(spec, subspec)) {
-		/* For some reason test_verifier executes programs
-		 * with all capabilities restored. Do the same here.
-		 */
-		if (restore_capabilities(&caps))
-			goto tobj_cleanup;
-
 		/* Do bpf_map__attach_struct_ops() for each struct_ops map.
 		 * This should trigger bpf_struct_ops->reg callback on kernel side.
 		 */
diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index e350c521b467..3aad9db921b5 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -244,9 +244,10 @@ do_suspend()
 					printf "Failed to suspend using RTC wake alarm\n"
 					return 1
 				fi
+			else
+				echo $filename > $SYSFS/power/state
 			fi
 
-			echo $filename > $SYSFS/power/state
 			printf "Came out of $1\n"
 
 			printf "Do basic tests after finishing $1 to verify cpufreq state\n\n"
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 8c3a73461475..60c84d935a2b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1618,14 +1618,8 @@ void teardown_trace_fixture(struct __test_metadata *_metadata,
 {
 	if (tracer) {
 		int status;
-		/*
-		 * Extract the exit code from the other process and
-		 * adopt it for ourselves in case its asserts failed.
-		 */
 		ASSERT_EQ(0, kill(tracer, SIGUSR1));
 		ASSERT_EQ(tracer, waitpid(tracer, &status, 0));
-		if (WEXITSTATUS(status))
-			_metadata->exit_code = KSFT_FAIL;
 	}
 }
 
@@ -3155,12 +3149,15 @@ TEST(syscall_restart)
 	ret = get_syscall(_metadata, child_pid);
 #if defined(__arm__)
 	/*
-	 * FIXME:
 	 * - native ARM registers do NOT expose true syscall.
 	 * - compat ARM registers on ARM64 DO expose true syscall.
+	 * - values of utsbuf.machine include 'armv8l' or 'armb8b'
+	 *   for ARM64 running in compat mode.
 	 */
 	ASSERT_EQ(0, uname(&utsbuf));
-	if (strncmp(utsbuf.machine, "arm", 3) == 0) {
+	if ((strncmp(utsbuf.machine, "arm", 3) == 0) &&
+	    (strncmp(utsbuf.machine, "armv8l", 6) != 0) &&
+	    (strncmp(utsbuf.machine, "armv8b", 6) != 0)) {
 		EXPECT_EQ(__NR_nanosleep, ret);
 	} else
 #endif

