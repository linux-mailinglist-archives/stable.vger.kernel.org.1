Return-Path: <stable+bounces-158764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2CAEB43A
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF1170681
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75329ACFC;
	Fri, 27 Jun 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPlLnWfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB229ACF9;
	Fri, 27 Jun 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019491; cv=none; b=LS3y7S57d9SQsvxqvaRwP9ZteZrKlVU/N4pHx7nrKxNLTheZw84HnITvMcWxOIrBG1kBWKBgfuTl5cFKsJundtLMSpRHpiO0NpnE/VydLvm+IPP39SZyBzNSkVSLr30dSAZVwYzA6TJWdNK6gKUqkU1P8fI24K87QlAVBCpI0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019491; c=relaxed/simple;
	bh=txugX47pi32c/+C2VMtc6Zoka5YmnJt4/JPbYmsUjro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8EHNtNa1aoovwzi3rcMEEjgDiQuA4gOTTZ92Vpn8QhfP37kNDltqJ+yxwnC0r+GvNp3zQ7kFQs6Rw27fYhvFxUgqkeo4KvsBzh/Y271b5UzeWy9j5MCZBU+zKYkO7+pFrk3QtWDrYR3v1P4xvizK/7Ku1utHml+RtEp5g2dXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPlLnWfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67FAC4CEE3;
	Fri, 27 Jun 2025 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019490;
	bh=txugX47pi32c/+C2VMtc6Zoka5YmnJt4/JPbYmsUjro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPlLnWfEo+7QqFmJqhjSh+lKv4gOkmosGhmiHzZ6cYkUifMAmrmO82r9UyNBN+N/Y
	 xwlexU5q8T6RLwKdrTc2mWiWQ0QdU0KKAxfkepLLsCRg6ciUKTAbAOA/0mHJrJApn+
	 QE7FLm4+AMK541tYop0ciKCnIUBczfEXY+H36JZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.239
Date: Fri, 27 Jun 2025 11:17:58 +0100
Message-ID: <2025062758-lid-tastiness-06af@gregkh>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025062758-grimacing-ferment-51d0@gregkh>
References: <2025062758-grimacing-ferment-51d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 12af5b0ecc8e..1eff15169983 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2954,6 +2954,7 @@
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
 					       ssbd=force-off [ARM64]
+					       nospectre_bhb [ARM64]
 					       tsx_async_abort=off [X86]
 
 				Exceptions:
@@ -3367,6 +3368,10 @@
 			vulnerability. System may allow data leaks with this
 			option.
 
+	nospectre_bhb   [ARM64] Disable all mitigations for Spectre-BHB (branch
+			history injection) vulnerability. System may allow data leaks
+			with this option.
+
 	nospec_store_bypass_disable
 			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
 
@@ -5122,8 +5127,6 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
-			Selecting specific mitigation does not force enable
-			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
diff --git a/MAINTAINERS b/MAINTAINERS
index cdb5f1f22f4c..beaa5f6294bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11633,6 +11633,15 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Mark Gross <mgross@linux.intel.com>
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
+F:	drivers/platform/surface/
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/Makefile b/Makefile
index 7d94034c906d..9ffd9397399d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 238
+SUBLEVEL = 239
 EXTRAVERSION =
 NAME = Dare mighty things
 
@@ -586,8 +586,7 @@ else
 CLANG_FLAGS	+= -fno-integrated-as
 endif
 CLANG_FLAGS	+= -Werror=unknown-warning-option
-KBUILD_CFLAGS	+= $(CLANG_FLAGS)
-KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 
@@ -1034,8 +1033,8 @@ LDFLAGS_vmlinux += --orphan-handling=warn
 endif
 
 # Align the bit size of userspace programs with the kernel
-KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 2d51d4bba6d4..f955fe22b663 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -145,6 +145,8 @@ davinci_mdio_default: davinci_mdio_default {
 			/* MDIO */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			/* Added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 
@@ -153,6 +155,8 @@ davinci_mdio_sleep: davinci_mdio_sleep {
 			/* MDIO reset value */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			/* Added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
@@ -374,6 +378,10 @@ &davinci_mdio {
 
 	ethphy0: ethernet-phy@0 {
 		reg = <0>;
+		/* Support GPIO reset on revision C3 boards */
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <300>;
+		reset-deassert-us = <50000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 71f60576761a..df206bdb6788 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -148,7 +148,7 @@ nand_controller: nand-controller {
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3f1002c34446..ba6cc81684c8 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -211,12 +211,6 @@ sleep_clk: sleep_clk {
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
@@ -360,9 +354,10 @@ tlmm_pinmux: pinctrl@800000 {
 			pinctrl-0 = <&ps_hold>;
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
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 62b7d9f9a926..c8b6318aaa83 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -64,7 +64,7 @@ nand_controller: nand-controller {
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 8a0cfbfd0c45..87a5f96014e0 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -58,7 +58,7 @@ usb1: gadget@fff78000 {
 			};
 
 			spi0: spi@fffa4000 {
-				cs-gpios = <&pioB 15 GPIO_ACTIVE_HIGH>;
+				cs-gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 				status = "okay";
 				mtd_dataflash@0 {
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
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 68550b23c938..eb6ca2ea8067 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -48,6 +48,7 @@
 #define CLKDM_NO_AUTODEPS			(1 << 4)
 #define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
 #define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
+#define CLKDM_STANDBY_FORCE_WAKEUP		BIT(7)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
index b4d5144df445..c53df9d42ecf 100644
--- a/arch/arm/mach-omap2/clockdomains33xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -27,7 +27,7 @@ static struct clockdomain l4ls_am33xx_clkdm = {
 	.pwrdm		= { .name = "per_pwrdm" },
 	.cm_inst	= AM33XX_CM_PER_MOD,
 	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
-	.flags		= CLKDM_CAN_SWSUP,
+	.flags		= CLKDM_CAN_SWSUP | CLKDM_STANDBY_FORCE_WAKEUP,
 };
 
 static struct clockdomain l3s_am33xx_clkdm = {
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index ac4882ebdca3..be84c6750026 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -28,6 +28,9 @@
 #include "cm-regbits-34xx.h"
 #include "cm-regbits-33xx.h"
 #include "prm33xx.h"
+#if IS_ENABLED(CONFIG_SUSPEND)
+#include <linux/suspend.h>
+#endif
 
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
@@ -336,8 +339,17 @@ static int am33xx_clkdm_clk_disable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
+#if IS_ENABLED(CONFIG_SUSPEND)
+	/*
+	 * In case of standby, Don't put the l4ls clk domain to sleep.
+	 * Since CM3 PM FW doesn't wake-up/enable the l4ls clk domain
+	 * upon wake-up, CM3 PM FW fails to wake-up th MPU.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_STANDBY &&
+	    (clkdm->flags & CLKDM_STANDBY_FORCE_WAKEUP))
+		return 0;
+#endif
 	hwsup = am33xx_cm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
-
 	if (!hwsup && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
 		am33xx_clkdm_sleep(clkdm);
 
diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
index 668dc84fd31e..527cf4b7e378 100644
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -264,7 +264,11 @@ int __init omap4_cpcap_init(void)
 
 static int __init cpcap_late_init(void)
 {
-	omap4_vc_set_pmic_signaling(PWRDM_POWER_RET);
+	if (!of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
+		return 0;
+
+	if (soc_is_omap443x() || soc_is_omap446x() || soc_is_omap447x())
+		omap4_vc_set_pmic_signaling(PWRDM_POWER_RET);
 
 	return 0;
 }
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 2660bdfcad4d..b378e514d137 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -483,7 +483,5 @@ void __init early_ioremap_init(void)
 bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
 				 unsigned long flags)
 {
-	unsigned long pfn = PHYS_PFN(offset);
-
-	return memblock_is_map_memory(pfn);
+	return memblock_is_map_memory(offset);
 }
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index b88c3c99b007..34b2e862b708 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -194,6 +194,7 @@ eeprom@50 {
 	rtc@51 {
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 3fc761c8d550..40be64a37c47 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -246,14 +246,6 @@ &uart2 {
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
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index a3538279d710..ec7d444b228d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -268,6 +268,8 @@ sdhci0: sdhci@4f80000 {
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
@@ -278,8 +280,9 @@ sdhci0: sdhci@4f80000 {
 		ti,otap-del-sel-ddr50 = <0x5>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
-		ti,otap-del-sel-hs400 = <0x0>;
-		ti,trm-icp = <0x8>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
+		ti,itap-del-sel-ddr52 = <0x0>;
 		dma-coherent;
 	};
 
@@ -290,19 +293,22 @@ sdhci1: sdhci@4fa0000 {
 		clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
 		clock-names = "clk_ahb", "clk_xin";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0x8>;
 		ti,otap-del-sel-sdr104 = <0x7>;
 		ti,otap-del-sel-ddr50 = <0x4>;
 		ti,otap-del-sel-ddr52 = <0x4>;
 		ti,otap-del-sel-hs200 = <0x7>;
-		ti,clkbuf-sel = <0x7>;
-		ti,otap-del-sel = <0x2>;
-		ti,trm-icp = <0x8>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-sd-hs = <0x1>;
+		ti,itap-del-sel-sdr12 = <0xa>;
+		ti,itap-del-sel-sdr25 = <0x1>;
 		dma-coherent;
 		no-1-8-v;
 	};
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 423bc03a21f2..dc88e9d2e5d2 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -80,6 +80,7 @@
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
 #define ARM_CPU_PART_CORTEX_A520	0xD80
 #define ARM_CPU_PART_CORTEX_A710	0xD47
 #define ARM_CPU_PART_CORTEX_A715	0xD4D
@@ -144,6 +145,7 @@
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_X1C MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
 #define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index c16ed5b68768..e1d166beb99b 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -34,18 +34,6 @@
  */
 #define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
 
-/*
- * BRK instruction encoding
- * The #imm16 value should be placed at bits[20:5] within BRK ins
- */
-#define AARCH64_BREAK_MON	0xd4200000
-
-/*
- * BRK instruction for provoking a fault on purpose
- * Unlike kgdb, #imm16 value with unallocated handler is used for faulting.
- */
-#define AARCH64_BREAK_FAULT	(AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
-
 #define AARCH64_BREAK_KGDB_DYN_DBG	\
 	(AARCH64_BREAK_MON | (KGDB_DYN_DBG_BRK_IMM << 5))
 
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index d45b42295254..1ef7bcc4a9b1 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -9,10 +9,23 @@
 #define	__ASM_INSN_H
 #include <linux/build_bug.h>
 #include <linux/types.h>
+#include <asm/brk-imm.h>
 
 /* A64 instructions are always 32 bits. */
 #define	AARCH64_INSN_SIZE		4
 
+/*
+ * BRK instruction encoding
+ * The #imm16 value should be placed at bits[20:5] within BRK ins
+ */
+#define AARCH64_BREAK_MON      0xd4200000
+
+/*
+ * BRK instruction for provoking a fault on purpose
+ * Unlike kgdb, #imm16 value with unallocated handler is used for faulting.
+ */
+#define AARCH64_BREAK_FAULT    (AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
+
 #ifndef __ASSEMBLY__
 /*
  * ARM Architecture Reference Manual for ARMv8 Profile-A, Issue A.a
@@ -206,7 +219,9 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_LOAD_EX,
+	AARCH64_INSN_LDST_LOAD_ACQ_EX,
 	AARCH64_INSN_LDST_STORE_EX,
+	AARCH64_INSN_LDST_STORE_REL_EX,
 };
 
 enum aarch64_insn_adsb_type {
@@ -281,6 +296,36 @@ enum aarch64_insn_adr_type {
 	AARCH64_INSN_ADR_TYPE_ADR,
 };
 
+enum aarch64_insn_mem_atomic_op {
+	AARCH64_INSN_MEM_ATOMIC_ADD,
+	AARCH64_INSN_MEM_ATOMIC_CLR,
+	AARCH64_INSN_MEM_ATOMIC_EOR,
+	AARCH64_INSN_MEM_ATOMIC_SET,
+	AARCH64_INSN_MEM_ATOMIC_SWP,
+};
+
+enum aarch64_insn_mem_order_type {
+	AARCH64_INSN_MEM_ORDER_NONE,
+	AARCH64_INSN_MEM_ORDER_ACQ,
+	AARCH64_INSN_MEM_ORDER_REL,
+	AARCH64_INSN_MEM_ORDER_ACQREL,
+};
+
+enum aarch64_insn_mb_type {
+	AARCH64_INSN_MB_SY,
+	AARCH64_INSN_MB_ST,
+	AARCH64_INSN_MB_LD,
+	AARCH64_INSN_MB_ISH,
+	AARCH64_INSN_MB_ISHST,
+	AARCH64_INSN_MB_ISHLD,
+	AARCH64_INSN_MB_NSH,
+	AARCH64_INSN_MB_NSHST,
+	AARCH64_INSN_MB_NSHLD,
+	AARCH64_INSN_MB_OSH,
+	AARCH64_INSN_MB_OSHST,
+	AARCH64_INSN_MB_OSHLD,
+};
+
 #define	__AARCH64_INSN_FUNCS(abbr, mask, val)				\
 static __always_inline bool aarch64_insn_is_##abbr(u32 code)		\
 {									\
@@ -298,6 +343,11 @@ __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
+__AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
+__AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
+__AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
+__AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
+__AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
@@ -370,6 +420,14 @@ __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
 __AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
 __AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
 __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
+__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
+__AARCH64_INSN_FUNCS(dsb_base,	0xFFFFF0FF, 0xD503309F)
+__AARCH64_INSN_FUNCS(dsb_nxs,	0xFFFFF3FF, 0xD503323F)
+__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)
+__AARCH64_INSN_FUNCS(sb,	0xFFFFFFFF, 0xD50330FF)
+__AARCH64_INSN_FUNCS(clrex,	0xFFFFF0FF, 0xD503305F)
+__AARCH64_INSN_FUNCS(ssbb,	0xFFFFFFFF, 0xD503309F)
+__AARCH64_INSN_FUNCS(pssbb,	0xFFFFFFFF, 0xD503349F)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -381,6 +439,19 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
 	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
 }
 
+static inline bool aarch64_insn_is_dsb(u32 insn)
+{
+	return aarch64_insn_is_dsb_base(insn) || aarch64_insn_is_dsb_nxs(insn);
+}
+
+static inline bool aarch64_insn_is_barrier(u32 insn)
+{
+	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
+	       aarch64_insn_is_isb(insn) || aarch64_insn_is_sb(insn) ||
+	       aarch64_insn_is_clrex(insn) || aarch64_insn_is_ssbb(insn) ||
+	       aarch64_insn_is_pssbb(insn);
+}
+
 int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
@@ -419,13 +490,6 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register state,
 				   enum aarch64_insn_size_type size,
 				   enum aarch64_insn_ldst_type type);
-u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
-			   enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size);
-u32 aarch64_insn_gen_stadd(enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size);
 u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
 				 enum aarch64_insn_register src,
 				 int imm, enum aarch64_insn_variant variant,
@@ -486,6 +550,43 @@ u32 aarch64_insn_gen_prefetch(enum aarch64_insn_register base,
 			      enum aarch64_insn_prfm_type type,
 			      enum aarch64_insn_prfm_target target,
 			      enum aarch64_insn_prfm_policy policy);
+#ifdef CONFIG_ARM64_LSE_ATOMICS
+u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
+				  enum aarch64_insn_register address,
+				  enum aarch64_insn_register value,
+				  enum aarch64_insn_size_type size,
+				  enum aarch64_insn_mem_atomic_op op,
+				  enum aarch64_insn_mem_order_type order);
+u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
+			 enum aarch64_insn_register address,
+			 enum aarch64_insn_register value,
+			 enum aarch64_insn_size_type size,
+			 enum aarch64_insn_mem_order_type order);
+#else
+static inline
+u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
+				  enum aarch64_insn_register address,
+				  enum aarch64_insn_register value,
+				  enum aarch64_insn_size_type size,
+				  enum aarch64_insn_mem_atomic_op op,
+				  enum aarch64_insn_mem_order_type order)
+{
+	return AARCH64_BREAK_FAULT;
+}
+
+static inline
+u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
+			 enum aarch64_insn_register address,
+			 enum aarch64_insn_register value,
+			 enum aarch64_insn_size_type size,
+			 enum aarch64_insn_mem_order_type order)
+{
+	return AARCH64_BREAK_FAULT;
+}
+#endif
+u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
+u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type);
+
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index e48afcb69392..09073bb6712a 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -32,7 +32,9 @@ void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
-u8 spectre_bhb_loop_affected(int scope);
+extern bool __nospectre_bhb;
+u8 get_spectre_bhb_loop_value(void);
+bool is_spectre_bhb_fw_mitigated(void);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7d4fdf974542..2d84453f5200 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2014-2016 Zi Shen Lim <zlim.lnx@gmail.com>
  */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
@@ -721,10 +722,16 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 
 	switch (type) {
 	case AARCH64_INSN_LDST_LOAD_EX:
+	case AARCH64_INSN_LDST_LOAD_ACQ_EX:
 		insn = aarch64_insn_get_load_ex_value();
+		if (type == AARCH64_INSN_LDST_LOAD_ACQ_EX)
+			insn |= BIT(15);
 		break;
 	case AARCH64_INSN_LDST_STORE_EX:
+	case AARCH64_INSN_LDST_STORE_REL_EX:
 		insn = aarch64_insn_get_store_ex_value();
+		if (type == AARCH64_INSN_LDST_STORE_REL_EX)
+			insn |= BIT(15);
 		break;
 	default:
 		pr_err("%s: unknown load/store exclusive encoding %d\n", __func__, type);
@@ -746,12 +753,65 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 					    state);
 }
 
-u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
-			   enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size)
+#ifdef CONFIG_ARM64_LSE_ATOMICS
+static u32 aarch64_insn_encode_ldst_order(enum aarch64_insn_mem_order_type type,
+					  u32 insn)
 {
-	u32 insn = aarch64_insn_get_ldadd_value();
+	u32 order;
+
+	switch (type) {
+	case AARCH64_INSN_MEM_ORDER_NONE:
+		order = 0;
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQ:
+		order = 2;
+		break;
+	case AARCH64_INSN_MEM_ORDER_REL:
+		order = 1;
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQREL:
+		order = 3;
+		break;
+	default:
+		pr_err("%s: unknown mem order %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn &= ~GENMASK(23, 22);
+	insn |= order << 22;
+
+	return insn;
+}
+
+u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
+				  enum aarch64_insn_register address,
+				  enum aarch64_insn_register value,
+				  enum aarch64_insn_size_type size,
+				  enum aarch64_insn_mem_atomic_op op,
+				  enum aarch64_insn_mem_order_type order)
+{
+	u32 insn;
+
+	switch (op) {
+	case AARCH64_INSN_MEM_ATOMIC_ADD:
+		insn = aarch64_insn_get_ldadd_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_CLR:
+		insn = aarch64_insn_get_ldclr_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_EOR:
+		insn = aarch64_insn_get_ldeor_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_SET:
+		insn = aarch64_insn_get_ldset_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_SWP:
+		insn = aarch64_insn_get_swp_value();
+		break;
+	default:
+		pr_err("%s: unimplemented mem atomic op %d\n", __func__, op);
+		return AARCH64_BREAK_FAULT;
+	}
 
 	switch (size) {
 	case AARCH64_INSN_SIZE_32:
@@ -764,6 +824,8 @@ u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
 
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
+	insn = aarch64_insn_encode_ldst_order(order, insn);
+
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
 					    result);
 
@@ -774,18 +836,69 @@ u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
 					    value);
 }
 
-u32 aarch64_insn_gen_stadd(enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size)
+static u32 aarch64_insn_encode_cas_order(enum aarch64_insn_mem_order_type type,
+					 u32 insn)
 {
-	/*
-	 * STADD is simply encoded as an alias for LDADD with XZR as
-	 * the destination register.
-	 */
-	return aarch64_insn_gen_ldadd(AARCH64_INSN_REG_ZR, address,
-				      value, size);
+	u32 order;
+
+	switch (type) {
+	case AARCH64_INSN_MEM_ORDER_NONE:
+		order = 0;
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQ:
+		order = BIT(22);
+		break;
+	case AARCH64_INSN_MEM_ORDER_REL:
+		order = BIT(15);
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQREL:
+		order = BIT(15) | BIT(22);
+		break;
+	default:
+		pr_err("%s: unknown mem order %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn &= ~(BIT(15) | BIT(22));
+	insn |= order;
+
+	return insn;
 }
 
+u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
+			 enum aarch64_insn_register address,
+			 enum aarch64_insn_register value,
+			 enum aarch64_insn_size_type size,
+			 enum aarch64_insn_mem_order_type order)
+{
+	u32 insn;
+
+	switch (size) {
+	case AARCH64_INSN_SIZE_32:
+	case AARCH64_INSN_SIZE_64:
+		break;
+	default:
+		pr_err("%s: unimplemented size encoding %d\n", __func__, size);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_get_cas_value();
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_cas_order(order, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    result);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    address);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
+					    value);
+}
+#endif
+
 static u32 aarch64_insn_encode_prfm_imm(enum aarch64_insn_prfm_type type,
 					enum aarch64_insn_prfm_target target,
 					enum aarch64_insn_prfm_policy policy,
@@ -1697,3 +1810,61 @@ u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
 }
+
+static u32 __get_barrier_crm_val(enum aarch64_insn_mb_type type)
+{
+	switch (type) {
+	case AARCH64_INSN_MB_SY:
+		return 0xf;
+	case AARCH64_INSN_MB_ST:
+		return 0xe;
+	case AARCH64_INSN_MB_LD:
+		return 0xd;
+	case AARCH64_INSN_MB_ISH:
+		return 0xb;
+	case AARCH64_INSN_MB_ISHST:
+		return 0xa;
+	case AARCH64_INSN_MB_ISHLD:
+		return 0x9;
+	case AARCH64_INSN_MB_NSH:
+		return 0x7;
+	case AARCH64_INSN_MB_NSHST:
+		return 0x6;
+	case AARCH64_INSN_MB_NSHLD:
+		return 0x5;
+	default:
+		pr_err("%s: unknown barrier type %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+}
+
+u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
+{
+	u32 opt;
+	u32 insn;
+
+	opt = __get_barrier_crm_val(type);
+	if (opt == AARCH64_BREAK_FAULT)
+		return AARCH64_BREAK_FAULT;
+
+	insn = aarch64_insn_get_dmb_value();
+	insn &= ~GENMASK(11, 8);
+	insn |= (opt << 8);
+
+	return insn;
+}
+
+u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type)
+{
+	u32 opt, insn;
+
+	opt = __get_barrier_crm_val(type);
+	if (opt == AARCH64_BREAK_FAULT)
+		return AARCH64_BREAK_FAULT;
+
+	insn = aarch64_insn_get_dsb_base_value();
+	insn &= ~GENMASK(11, 8);
+	insn |= (opt << 8);
+
+	return insn;
+}
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 45fdfe70b69f..2773bf189a3f 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -853,53 +853,89 @@ enum mitigation_state arm64_get_spectre_bhb_state(void)
  * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
  * SCOPE_SYSTEM call will give the right answer.
  */
-u8 spectre_bhb_loop_affected(int scope)
+static bool is_spectre_bhb_safe(int scope)
+{
+	static const struct midr_range spectre_bhb_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
+		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
+		{},
+	};
+	static bool all_safe = true;
+
+	if (scope != SCOPE_LOCAL_CPU)
+		return all_safe;
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_safe_list))
+		return true;
+
+	all_safe = false;
+
+	return false;
+}
+
+static u8 spectre_bhb_loop_affected(void)
 {
 	u8 k = 0;
-	static u8 max_bhb_k;
-
-	if (scope == SCOPE_LOCAL_CPU) {
-		static const struct midr_range spectre_bhb_k32_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k24_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
-			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k11_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k8_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-			{},
-		};
-
-		if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
-			k = 32;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
-			k = 24;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
-			k = 11;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
-			k =  8;
-
-		max_bhb_k = max(max_bhb_k, k);
-	} else {
-		k = max_bhb_k;
-	}
+
+	static const struct midr_range spectre_bhb_k132_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k38_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k32_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k24_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k11_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k8_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k132_list))
+		k = 132;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k38_list))
+		k = 38;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+		k = 32;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
+		k = 24;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
+		k = 11;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
+		k =  8;
 
 	return k;
 }
@@ -925,29 +961,13 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
 	}
 }
 
-static bool is_spectre_bhb_fw_affected(int scope)
+static bool has_spectre_bhb_fw_mitigation(void)
 {
-	static bool system_affected;
 	enum mitigation_state fw_state;
 	bool has_smccc = arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE;
-	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		{},
-	};
-	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-					 spectre_bhb_firmware_mitigated_list);
-
-	if (scope != SCOPE_LOCAL_CPU)
-		return system_affected;
 
 	fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-	if (cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
-		system_affected = true;
-		return true;
-	}
-
-	return false;
+	return has_smccc && fw_state == SPECTRE_MITIGATED;
 }
 
 static bool supports_ecbhb(int scope)
@@ -963,6 +983,8 @@ static bool supports_ecbhb(int scope)
 						    ID_AA64MMFR1_ECBHB_SHIFT);
 }
 
+static u8 max_bhb_k;
+
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 			     int scope)
 {
@@ -971,16 +993,23 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 	if (supports_csv2p3(scope))
 		return false;
 
-	if (supports_clearbhb(scope))
-		return true;
+	if (is_spectre_bhb_safe(scope))
+		return false;
 
-	if (spectre_bhb_loop_affected(scope))
-		return true;
+	/*
+	 * At this point the core isn't known to be "safe" so we're going to
+	 * assume it's vulnerable. We still need to update `max_bhb_k` though,
+	 * but only if we aren't mitigating with clearbhb though.
+	 */
+	if (scope == SCOPE_LOCAL_CPU && !supports_clearbhb(SCOPE_LOCAL_CPU))
+		max_bhb_k = max(max_bhb_k, spectre_bhb_loop_affected());
 
-	if (is_spectre_bhb_fw_affected(scope))
-		return true;
+	return true;
+}
 
-	return false;
+u8 get_spectre_bhb_loop_value(void)
+{
+	return max_bhb_k;
 }
 
 static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
@@ -1059,9 +1088,18 @@ static void kvm_setup_bhb_slot(const char *hyp_vecs_start)
 static void kvm_setup_bhb_slot(const char *hyp_vecs_start) { }
 #endif /* CONFIG_KVM */
 
+static bool spectre_bhb_fw_mitigated;
+bool __read_mostly __nospectre_bhb;
+static int __init parse_spectre_bhb_param(char *str)
+{
+	__nospectre_bhb = true;
+	return 0;
+}
+early_param("nospectre_bhb", parse_spectre_bhb_param);
+
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
-	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
+	enum mitigation_state state = SPECTRE_VULNERABLE;
 
 	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
 		return;
@@ -1070,7 +1108,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		/* No point mitigating Spectre-BHB alone. */
 	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
 		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
-	} else if (cpu_mitigations_off()) {
+	} else if (cpu_mitigations_off() || __nospectre_bhb) {
 		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
 		state = SPECTRE_MITIGATED;
@@ -1079,8 +1117,8 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
 
 		state = SPECTRE_MITIGATED;
-	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
-		switch (spectre_bhb_loop_affected(SCOPE_SYSTEM)) {
+	} else if (spectre_bhb_loop_affected()) {
+		switch (max_bhb_k) {
 		case 8:
 			kvm_setup_bhb_slot(__spectre_bhb_loop_k8);
 			break;
@@ -1096,26 +1134,28 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_LOOP);
 
 		state = SPECTRE_MITIGATED;
-	} else if (is_spectre_bhb_fw_affected(SCOPE_LOCAL_CPU)) {
-		fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-		if (fw_state == SPECTRE_MITIGATED) {
-			kvm_setup_bhb_slot(__smccc_workaround_3_smc);
-			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
+	} else if (has_spectre_bhb_fw_mitigation()) {
+		kvm_setup_bhb_slot(__smccc_workaround_3_smc);
+		this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
 
-			state = SPECTRE_MITIGATED;
-		}
+		state = SPECTRE_MITIGATED;
+		spectre_bhb_fw_mitigated = true;
 	}
 
 	update_mitigation_state(&spectre_bhb_state, state);
 }
 
+bool is_spectre_bhb_fw_mitigated(void)
+{
+	return spectre_bhb_fw_mitigated;
+}
+
 /* Patched to correct the immediate */
 void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 				   __le32 *origptr, __le32 *updptr, int nr_inst)
 {
 	u8 rd;
 	u32 insn;
-	u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
 
 	BUG_ON(nr_inst != 1); /* MOV -> MOV */
 
@@ -1124,7 +1164,7 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 
 	insn = le32_to_cpu(*origptr);
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
-	insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
+	insn = aarch64_insn_gen_movewide(rd, max_bhb_k, 0,
 					 AARCH64_INSN_VARIANT_64BIT,
 					 AARCH64_INSN_MOVEWIDE_ZERO);
 	*updptr++ = cpu_to_le32(insn);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6c9e7662c07f..5d52eac22d83 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -140,7 +140,7 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 
 	addr += n;
 	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
+		return READ_ONCE_NOCHECK(*addr);
 	else
 		return 0;
 }
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index cc0cf0f5c7c3..9d9250c7cc72 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -89,9 +89,16 @@
 #define A64_STXR(sf, Rt, Rn, Rs) \
 	A64_LSX(sf, Rt, Rn, Rs, STORE_EX)
 
-/* LSE atomics */
+/*
+ * LSE atomics
+ *
+ * STADD is simply encoded as an alias for LDADD with XZR as
+ * the destination register.
+ */
 #define A64_STADD(sf, Rn, Rs) \
-	aarch64_insn_gen_stadd(Rn, Rs, A64_SIZE(sf))
+	aarch64_insn_gen_atomic_ld_op(A64_ZR, Rn, Rs, \
+		A64_SIZE(sf), AARCH64_INSN_MEM_ATOMIC_ADD, \
+		AARCH64_INSN_MEM_ORDER_NONE)
 
 /* Add/subtract (immediate) */
 #define A64_ADDSUB_IMM(sf, Rd, Rn, imm12, type) \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 18627cbd6da4..970d8f318177 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -7,14 +7,17 @@
 
 #define pr_fmt(fmt) "bpf_jit: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/cpu.h>
 #include <linux/filter.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/set_memory.h>
 
@@ -328,7 +331,51 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 #undef jmp_offset
 }
 
-static void build_epilogue(struct jit_ctx *ctx)
+/* Clobbers BPF registers 1-4, aka x0-x3 */
+static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
+{
+	const u8 r1 = bpf2a64[BPF_REG_1]; /* aka x0 */
+	u8 k = get_spectre_bhb_loop_value();
+
+	if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY) ||
+	    cpu_mitigations_off() || __nospectre_bhb ||
+	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
+		return;
+
+	if (capable(CAP_SYS_ADMIN))
+		return;
+
+	if (supports_clearbhb(SCOPE_SYSTEM)) {
+		emit(aarch64_insn_gen_hint(AARCH64_INSN_HINT_CLEARBHB), ctx);
+		return;
+	}
+
+	if (k) {
+		emit_a64_mov_i64(r1, k, ctx);
+		emit(A64_B(1), ctx);
+		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
+		emit(A64_B_(A64_COND_NE, -2), ctx);
+		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
+		emit(aarch64_insn_get_isb_value(), ctx);
+	}
+
+	if (is_spectre_bhb_fw_mitigated()) {
+		emit(A64_ORR_I(false, r1, AARCH64_INSN_REG_ZR,
+			       ARM_SMCCC_ARCH_WORKAROUND_3), ctx);
+		switch (arm_smccc_1_1_get_conduit()) {
+		case SMCCC_CONDUIT_HVC:
+			emit(aarch64_insn_get_hvc_value(), ctx);
+			break;
+		case SMCCC_CONDUIT_SMC:
+			emit(aarch64_insn_get_smc_value(), ctx);
+			break;
+		default:
+			pr_err_once("Firmware mitigation enabled with unknown conduit\n");
+		}
+	}
+}
+
+static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 {
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 r6 = bpf2a64[BPF_REG_6];
@@ -347,10 +394,13 @@ static void build_epilogue(struct jit_ctx *ctx)
 	emit(A64_POP(r8, r9, A64_SP), ctx);
 	emit(A64_POP(r6, r7, A64_SP), ctx);
 
+	if (was_classic)
+		build_bhb_mitigation(ctx);
+
 	/* Restore FP/LR registers */
 	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
 
-	/* Set return value */
+	/* Move the return value from bpf:r0 (aka x7) to x0 */
 	emit(A64_MOV(1, A64_R(0), r0), ctx);
 
 	emit(A64_RET(A64_LR), ctx);
@@ -1057,7 +1107,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, was_classic);
 
 	extable_size = prog->aux->num_exentries *
 		sizeof(struct exception_table_entry);
@@ -1089,7 +1139,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, was_classic);
 
 	/* 3. Extra pass to validate JITed code. */
 	if (validate_code(&ctx)) {
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 5b09aca55108..d0ccf2d76f70 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -84,7 +84,26 @@ HYPERCALL1(tmem_op);
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
index 2bea1799b8de..856042fecd81 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -800,7 +800,7 @@ static void __init mac_identify(void)
 	}
 
 	macintosh_config = mac_data_table;
-	for (m = macintosh_config; m->ident != -1; m++) {
+	for (m = &mac_data_table[1]; m->ident != -1; m++) {
 		if (m->ident == model) {
 			macintosh_config = m;
 			break;
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 289fb4b88d0e..5303a386cd6d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -110,7 +110,7 @@ endif
 # (specifically newer than 2.24.51.20140728) we then also need to explicitly
 # set ".set hardfloat" in all files which manipulate floating point registers.
 #
-ifneq ($(call as-option,-Wa$(comma)-msoft-float,),)
+ifneq ($(call cc-option,$(cflags-y) -Wa$(comma)-msoft-float,),)
 	cflags-y		+= -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float
 endif
 
@@ -153,7 +153,7 @@ cflags-y += -fno-stack-check
 #
 # Avoid this by explicitly disabling that assembler behaviour.
 #
-cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-y += $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 #
 # CPU-dependent compiler/assembler options for optimization.
@@ -319,7 +319,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
-CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
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
diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index ae023b9a1c51..bc3cad78990d 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -28,7 +28,7 @@ cflags-$(CONFIG_CPU_LOONGSON2F) += \
 # binutils does not merge support for the flag then we can revisit & remove
 # this later - for now it ensures vendor toolchains don't cause problems.
 #
-cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 2131d3fd7333..638aaaba44ce 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -29,6 +29,7 @@ endif
 # offsets.
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
+	$(filter -std=%,$(KBUILD_CFLAGS)) \
 	-O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
 	-mrelax-pic-calls $(call cc-option, -mexplicit-relocs) \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 2600d76c310c..966fef8249bb 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -277,4 +277,20 @@ extern void __init mmu_init(void);
 extern void update_mmu_cache(struct vm_area_struct *vma,
 			     unsigned long address, pte_t *pte);
 
+static inline int pte_same(pte_t pte_a, pte_t pte_b);
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+static inline int ptep_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pte_t *ptep,
+					pte_t entry, int dirty)
+{
+	if (!pte_same(*ptep, entry))
+		set_ptes(vma->vm_mm, address, ptep, entry, 1);
+	/*
+	 * update_mmu_cache will unconditionally execute, handling both
+	 * the case that the PTE changed and the spurious fault case.
+	 */
+	return true;
+}
+
 #endif /* _ASM_NIOS2_PGTABLE_H */
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index dff453687530..4e5aecc263a2 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -22,6 +22,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
+KBUILD_CFLAGS += -std=gnu11
 
 OBJECTS += $(obj)/head.o $(obj)/real2.o $(obj)/firmware.o $(obj)/misc.o $(obj)/piggy.o
 
diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 47062b457049..c6df6fefbe8c 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -162,6 +162,9 @@ int vas_copy_crb(void *crb, int offset);
  */
 int vas_paste_crb(struct vas_window *win, int offset, bool re);
 
+void vas_win_paste_addr(struct vas_window *window, u64 *addr,
+			int *len);
+
 /*
  * Register / unregister coprocessor type to VAS API which will be exported
  * to user space. Applications can use this API to open / close window
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 20c417ad9c6d..fbc6eaaf10e1 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1525,6 +1525,8 @@ int eeh_pe_configure(struct eeh_pe *pe)
 	/* Invalid PE ? */
 	if (!pe)
 		return -ENODEV;
+	else
+		ret = eeh_ops->configure_bridge(pe);
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 7a5e8f4541e3..594544a65b02 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -20,6 +20,7 @@ source "arch/powerpc/platforms/embedded6xx/Kconfig"
 source "arch/powerpc/platforms/44x/Kconfig"
 source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
+source "arch/powerpc/platforms/book3s/Kconfig"
 
 config KVM_GUEST
 	bool "KVM Guest support"
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 143d4417f6cc..0e75d7df387b 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
 obj-$(CONFIG_AMIGAONE)		+= amigaone/
+obj-$(CONFIG_PPC_BOOK3S)	+= book3s/
diff --git a/arch/powerpc/platforms/book3s/Kconfig b/arch/powerpc/platforms/book3s/Kconfig
new file mode 100644
index 000000000000..34c931592ef0
--- /dev/null
+++ b/arch/powerpc/platforms/book3s/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+config PPC_VAS
+	bool "IBM Virtual Accelerator Switchboard (VAS)"
+	depends on (PPC_POWERNV || PPC_PSERIES) && PPC_64K_PAGES
+	default y
+	help
+	  This enables support for IBM Virtual Accelerator Switchboard (VAS).
+
+	  VAS devices are found in POWER9-based and later systems, they
+	  provide access to accelerator coprocessors such as NX-GZIP and
+	  NX-842. This config allows the kernel to use NX-842 accelerators,
+	  and user-mode APIs for the NX-GZIP accelerator on POWER9 PowerNV
+	  and POWER10 PowerVM platforms.
+
+	  If unsure, say "N".
diff --git a/arch/powerpc/platforms/book3s/Makefile b/arch/powerpc/platforms/book3s/Makefile
new file mode 100644
index 000000000000..e790f1910f61
--- /dev/null
+++ b/arch/powerpc/platforms/book3s/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_PPC_VAS)	+= vas-api.o
diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
new file mode 100644
index 000000000000..9bf6bc700ae9
--- /dev/null
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * VAS user space API for its accelerators (Only NX-GZIP is supported now)
+ * Copyright (C) 2019 Haren Myneni, IBM Corp
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+#include <asm/vas.h>
+#include <uapi/asm/vas-api.h>
+
+/*
+ * The driver creates the device node that can be used as follows:
+ * For NX-GZIP
+ *
+ *	fd = open("/dev/crypto/nx-gzip", O_RDWR);
+ *	rc = ioctl(fd, VAS_TX_WIN_OPEN, &attr);
+ *	paste_addr = mmap(NULL, PAGE_SIZE, prot, MAP_SHARED, fd, 0ULL).
+ *	vas_copy(&crb, 0, 1);
+ *	vas_paste(paste_addr, 0, 1);
+ *	close(fd) or exit process to close window.
+ *
+ * where "vas_copy" and "vas_paste" are defined in copy-paste.h.
+ * copy/paste returns to the user space directly. So refer NX hardware
+ * documententation for exact copy/paste usage and completion / error
+ * conditions.
+ */
+
+/*
+ * Wrapper object for the nx-gzip device - there is just one instance of
+ * this node for the whole system.
+ */
+static struct coproc_dev {
+	struct cdev cdev;
+	struct device *device;
+	char *name;
+	dev_t devt;
+	struct class *class;
+	enum vas_cop_type cop_type;
+} coproc_device;
+
+struct coproc_instance {
+	struct coproc_dev *coproc;
+	struct vas_window *txwin;
+};
+
+static char *coproc_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "crypto/%s", dev_name(dev));
+}
+
+static int coproc_open(struct inode *inode, struct file *fp)
+{
+	struct coproc_instance *cp_inst;
+
+	cp_inst = kzalloc(sizeof(*cp_inst), GFP_KERNEL);
+	if (!cp_inst)
+		return -ENOMEM;
+
+	cp_inst->coproc = container_of(inode->i_cdev, struct coproc_dev,
+					cdev);
+	fp->private_data = cp_inst;
+
+	return 0;
+}
+
+static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
+{
+	void __user *uptr = (void __user *)arg;
+	struct vas_tx_win_attr txattr = {};
+	struct vas_tx_win_open_attr uattr;
+	struct coproc_instance *cp_inst;
+	struct vas_window *txwin;
+	int rc, vasid;
+
+	cp_inst = fp->private_data;
+
+	/*
+	 * One window for file descriptor
+	 */
+	if (cp_inst->txwin)
+		return -EEXIST;
+
+	rc = copy_from_user(&uattr, uptr, sizeof(uattr));
+	if (rc) {
+		pr_err("%s(): copy_from_user() returns %d\n", __func__, rc);
+		return -EFAULT;
+	}
+
+	if (uattr.version != 1) {
+		pr_err("Invalid version\n");
+		return -EINVAL;
+	}
+
+	vasid = uattr.vas_id;
+
+	vas_init_tx_win_attr(&txattr, cp_inst->coproc->cop_type);
+
+	txattr.lpid = mfspr(SPRN_LPID);
+	txattr.pidr = mfspr(SPRN_PID);
+	txattr.user_win = true;
+	txattr.rsvd_txbuf_count = false;
+	txattr.pswid = false;
+
+	pr_devel("Pid %d: Opening txwin, PIDR %ld\n", txattr.pidr,
+				mfspr(SPRN_PID));
+
+	txwin = vas_tx_win_open(vasid, cp_inst->coproc->cop_type, &txattr);
+	if (IS_ERR(txwin)) {
+		pr_err("%s() vas_tx_win_open() failed, %ld\n", __func__,
+					PTR_ERR(txwin));
+		return PTR_ERR(txwin);
+	}
+
+	cp_inst->txwin = txwin;
+
+	return 0;
+}
+
+static int coproc_release(struct inode *inode, struct file *fp)
+{
+	struct coproc_instance *cp_inst = fp->private_data;
+
+	if (cp_inst->txwin) {
+		vas_win_close(cp_inst->txwin);
+		cp_inst->txwin = NULL;
+	}
+
+	kfree(cp_inst);
+	fp->private_data = NULL;
+
+	/*
+	 * We don't know here if user has other receive windows
+	 * open, so we can't really call clear_thread_tidr().
+	 * So, once the process calls set_thread_tidr(), the
+	 * TIDR value sticks around until process exits, resulting
+	 * in an extra copy in restore_sprs().
+	 */
+
+	return 0;
+}
+
+static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
+{
+	struct coproc_instance *cp_inst = fp->private_data;
+	struct vas_window *txwin;
+	unsigned long pfn;
+	u64 paste_addr;
+	pgprot_t prot;
+	int rc;
+
+	txwin = cp_inst->txwin;
+
+	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
+		pr_debug("%s(): size 0x%zx, PAGE_SIZE 0x%zx\n", __func__,
+				(vma->vm_end - vma->vm_start), PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	/*
+	 * Map complete page to the paste address. So the user
+	 * space should pass 0ULL to the offset parameter.
+	 */
+	if (vma->vm_pgoff) {
+		pr_debug("Page offset unsupported to map paste address\n");
+		return -EINVAL;
+	}
+
+	/* Ensure instance has an open send window */
+	if (!txwin) {
+		pr_err("%s(): No send window open?\n", __func__);
+		return -EINVAL;
+	}
+
+	vas_win_paste_addr(txwin, &paste_addr, NULL);
+	pfn = paste_addr >> PAGE_SHIFT;
+
+	/* flags, page_prot from cxl_mmap(), except we want cachable */
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
+
+	prot = __pgprot(pgprot_val(vma->vm_page_prot) | _PAGE_DIRTY);
+
+	rc = remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			vma->vm_end - vma->vm_start, prot);
+
+	pr_devel("%s(): paste addr %llx at %lx, rc %d\n", __func__,
+			paste_addr, vma->vm_start, rc);
+
+	return rc;
+}
+
+static long coproc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case VAS_TX_WIN_OPEN:
+		return coproc_ioc_tx_win_open(fp, arg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct file_operations coproc_fops = {
+	.open = coproc_open,
+	.release = coproc_release,
+	.mmap = coproc_mmap,
+	.unlocked_ioctl = coproc_ioctl,
+};
+
+/*
+ * Supporting only nx-gzip coprocessor type now, but this API code
+ * extended to other coprocessor types later.
+ */
+int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
+				const char *name)
+{
+	int rc = -EINVAL;
+	dev_t devno;
+
+	rc = alloc_chrdev_region(&coproc_device.devt, 1, 1, name);
+	if (rc) {
+		pr_err("Unable to allocate coproc major number: %i\n", rc);
+		return rc;
+	}
+
+	pr_devel("%s device allocated, dev [%i,%i]\n", name,
+			MAJOR(coproc_device.devt), MINOR(coproc_device.devt));
+
+	coproc_device.class = class_create(mod, name);
+	if (IS_ERR(coproc_device.class)) {
+		rc = PTR_ERR(coproc_device.class);
+		pr_err("Unable to create %s class %d\n", name, rc);
+		goto err_class;
+	}
+	coproc_device.class->devnode = coproc_devnode;
+	coproc_device.cop_type = cop_type;
+
+	coproc_fops.owner = mod;
+	cdev_init(&coproc_device.cdev, &coproc_fops);
+
+	devno = MKDEV(MAJOR(coproc_device.devt), 0);
+	rc = cdev_add(&coproc_device.cdev, devno, 1);
+	if (rc) {
+		pr_err("cdev_add() failed %d\n", rc);
+		goto err_cdev;
+	}
+
+	coproc_device.device = device_create(coproc_device.class, NULL,
+			devno, NULL, name, MINOR(devno));
+	if (IS_ERR(coproc_device.device)) {
+		rc = PTR_ERR(coproc_device.device);
+		pr_err("Unable to create coproc-%d %d\n", MINOR(devno), rc);
+		goto err;
+	}
+
+	pr_devel("%s: Added dev [%d,%d]\n", __func__, MAJOR(devno),
+			MINOR(devno));
+
+	return 0;
+
+err:
+	cdev_del(&coproc_device.cdev);
+err_cdev:
+	class_destroy(coproc_device.class);
+err_class:
+	unregister_chrdev_region(coproc_device.devt, 1);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vas_register_coproc_api);
+
+void vas_unregister_coproc_api(void)
+{
+	dev_t devno;
+
+	cdev_del(&coproc_device.cdev);
+	devno = MKDEV(MAJOR(coproc_device.devt), 0);
+	device_destroy(coproc_device.class, devno);
+
+	class_destroy(coproc_device.class);
+	unregister_chrdev_region(coproc_device.devt, 1);
+}
+EXPORT_SYMBOL_GPL(vas_unregister_coproc_api);
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 938803eab0ad..b3cb3d0c51c7 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -33,20 +33,6 @@ config PPC_MEMTRACE
 	  Enabling this option allows for the removal of memory (RAM)
 	  from the kernel mappings to be used for hardware tracing.
 
-config PPC_VAS
-	bool "IBM Virtual Accelerator Switchboard (VAS)"
-	depends on PPC_POWERNV && PPC_64K_PAGES
-	default y
-	help
-	  This enables support for IBM Virtual Accelerator Switchboard (VAS).
-
-	  VAS allows accelerators in co-processors like NX-GZIP and NX-842
-	  to be accessible to kernel subsystems and user processes.
-
-	  VAS adapters are found in POWER9 based systems.
-
-	  If unsure, say N.
-
 config SCOM_DEBUGFS
 	bool "Expose SCOM controllers via debugfs"
 	depends on DEBUG_FS
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 2eb6ae150d1f..c747a1f1d25b 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
 obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
-obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o vas-fault.o vas-api.o
+obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o vas-fault.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
 obj-$(CONFIG_SCOM_DEBUGFS) += opal-xscom.o
 obj-$(CONFIG_PPC_SECURE_BOOT) += opal-secvar.o
diff --git a/arch/powerpc/platforms/powernv/vas-api.c b/arch/powerpc/platforms/powernv/vas-api.c
deleted file mode 100644
index 98ed5d8c5441..000000000000
--- a/arch/powerpc/platforms/powernv/vas-api.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * VAS user space API for its accelerators (Only NX-GZIP is supported now)
- * Copyright (C) 2019 Haren Myneni, IBM Corp
- */
-
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/cdev.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <asm/vas.h>
-#include <uapi/asm/vas-api.h>
-#include "vas.h"
-
-/*
- * The driver creates the device node that can be used as follows:
- * For NX-GZIP
- *
- *	fd = open("/dev/crypto/nx-gzip", O_RDWR);
- *	rc = ioctl(fd, VAS_TX_WIN_OPEN, &attr);
- *	paste_addr = mmap(NULL, PAGE_SIZE, prot, MAP_SHARED, fd, 0ULL).
- *	vas_copy(&crb, 0, 1);
- *	vas_paste(paste_addr, 0, 1);
- *	close(fd) or exit process to close window.
- *
- * where "vas_copy" and "vas_paste" are defined in copy-paste.h.
- * copy/paste returns to the user space directly. So refer NX hardware
- * documententation for exact copy/paste usage and completion / error
- * conditions.
- */
-
-/*
- * Wrapper object for the nx-gzip device - there is just one instance of
- * this node for the whole system.
- */
-static struct coproc_dev {
-	struct cdev cdev;
-	struct device *device;
-	char *name;
-	dev_t devt;
-	struct class *class;
-	enum vas_cop_type cop_type;
-} coproc_device;
-
-struct coproc_instance {
-	struct coproc_dev *coproc;
-	struct vas_window *txwin;
-};
-
-static char *coproc_devnode(struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "crypto/%s", dev_name(dev));
-}
-
-static int coproc_open(struct inode *inode, struct file *fp)
-{
-	struct coproc_instance *cp_inst;
-
-	cp_inst = kzalloc(sizeof(*cp_inst), GFP_KERNEL);
-	if (!cp_inst)
-		return -ENOMEM;
-
-	cp_inst->coproc = container_of(inode->i_cdev, struct coproc_dev,
-					cdev);
-	fp->private_data = cp_inst;
-
-	return 0;
-}
-
-static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
-{
-	void __user *uptr = (void __user *)arg;
-	struct vas_tx_win_attr txattr = {};
-	struct vas_tx_win_open_attr uattr;
-	struct coproc_instance *cp_inst;
-	struct vas_window *txwin;
-	int rc, vasid;
-
-	cp_inst = fp->private_data;
-
-	/*
-	 * One window for file descriptor
-	 */
-	if (cp_inst->txwin)
-		return -EEXIST;
-
-	rc = copy_from_user(&uattr, uptr, sizeof(uattr));
-	if (rc) {
-		pr_err("%s(): copy_from_user() returns %d\n", __func__, rc);
-		return -EFAULT;
-	}
-
-	if (uattr.version != 1) {
-		pr_err("Invalid version\n");
-		return -EINVAL;
-	}
-
-	vasid = uattr.vas_id;
-
-	vas_init_tx_win_attr(&txattr, cp_inst->coproc->cop_type);
-
-	txattr.lpid = mfspr(SPRN_LPID);
-	txattr.pidr = mfspr(SPRN_PID);
-	txattr.user_win = true;
-	txattr.rsvd_txbuf_count = false;
-	txattr.pswid = false;
-
-	pr_devel("Pid %d: Opening txwin, PIDR %ld\n", txattr.pidr,
-				mfspr(SPRN_PID));
-
-	txwin = vas_tx_win_open(vasid, cp_inst->coproc->cop_type, &txattr);
-	if (IS_ERR(txwin)) {
-		pr_err("%s() vas_tx_win_open() failed, %ld\n", __func__,
-					PTR_ERR(txwin));
-		return PTR_ERR(txwin);
-	}
-
-	cp_inst->txwin = txwin;
-
-	return 0;
-}
-
-static int coproc_release(struct inode *inode, struct file *fp)
-{
-	struct coproc_instance *cp_inst = fp->private_data;
-
-	if (cp_inst->txwin) {
-		vas_win_close(cp_inst->txwin);
-		cp_inst->txwin = NULL;
-	}
-
-	kfree(cp_inst);
-	fp->private_data = NULL;
-
-	/*
-	 * We don't know here if user has other receive windows
-	 * open, so we can't really call clear_thread_tidr().
-	 * So, once the process calls set_thread_tidr(), the
-	 * TIDR value sticks around until process exits, resulting
-	 * in an extra copy in restore_sprs().
-	 */
-
-	return 0;
-}
-
-static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
-{
-	struct coproc_instance *cp_inst = fp->private_data;
-	struct vas_window *txwin;
-	unsigned long pfn;
-	u64 paste_addr;
-	pgprot_t prot;
-	int rc;
-
-	txwin = cp_inst->txwin;
-
-	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
-		pr_debug("%s(): size 0x%zx, PAGE_SIZE 0x%zx\n", __func__,
-				(vma->vm_end - vma->vm_start), PAGE_SIZE);
-		return -EINVAL;
-	}
-
-	/* Ensure instance has an open send window */
-	if (!txwin) {
-		pr_err("%s(): No send window open?\n", __func__);
-		return -EINVAL;
-	}
-
-	vas_win_paste_addr(txwin, &paste_addr, NULL);
-	pfn = paste_addr >> PAGE_SHIFT;
-
-	/* flags, page_prot from cxl_mmap(), except we want cachable */
-	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
-
-	prot = __pgprot(pgprot_val(vma->vm_page_prot) | _PAGE_DIRTY);
-
-	rc = remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
-			vma->vm_end - vma->vm_start, prot);
-
-	pr_devel("%s(): paste addr %llx at %lx, rc %d\n", __func__,
-			paste_addr, vma->vm_start, rc);
-
-	return rc;
-}
-
-static long coproc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case VAS_TX_WIN_OPEN:
-		return coproc_ioc_tx_win_open(fp, arg);
-	default:
-		return -EINVAL;
-	}
-}
-
-static struct file_operations coproc_fops = {
-	.open = coproc_open,
-	.release = coproc_release,
-	.mmap = coproc_mmap,
-	.unlocked_ioctl = coproc_ioctl,
-};
-
-/*
- * Supporting only nx-gzip coprocessor type now, but this API code
- * extended to other coprocessor types later.
- */
-int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
-				const char *name)
-{
-	int rc = -EINVAL;
-	dev_t devno;
-
-	rc = alloc_chrdev_region(&coproc_device.devt, 1, 1, name);
-	if (rc) {
-		pr_err("Unable to allocate coproc major number: %i\n", rc);
-		return rc;
-	}
-
-	pr_devel("%s device allocated, dev [%i,%i]\n", name,
-			MAJOR(coproc_device.devt), MINOR(coproc_device.devt));
-
-	coproc_device.class = class_create(mod, name);
-	if (IS_ERR(coproc_device.class)) {
-		rc = PTR_ERR(coproc_device.class);
-		pr_err("Unable to create %s class %d\n", name, rc);
-		goto err_class;
-	}
-	coproc_device.class->devnode = coproc_devnode;
-	coproc_device.cop_type = cop_type;
-
-	coproc_fops.owner = mod;
-	cdev_init(&coproc_device.cdev, &coproc_fops);
-
-	devno = MKDEV(MAJOR(coproc_device.devt), 0);
-	rc = cdev_add(&coproc_device.cdev, devno, 1);
-	if (rc) {
-		pr_err("cdev_add() failed %d\n", rc);
-		goto err_cdev;
-	}
-
-	coproc_device.device = device_create(coproc_device.class, NULL,
-			devno, NULL, name, MINOR(devno));
-	if (IS_ERR(coproc_device.device)) {
-		rc = PTR_ERR(coproc_device.device);
-		pr_err("Unable to create coproc-%d %d\n", MINOR(devno), rc);
-		goto err;
-	}
-
-	pr_devel("%s: Added dev [%d,%d]\n", __func__, MAJOR(devno),
-			MINOR(devno));
-
-	return 0;
-
-err:
-	cdev_del(&coproc_device.cdev);
-err_cdev:
-	class_destroy(coproc_device.class);
-err_class:
-	unregister_chrdev_region(coproc_device.devt, 1);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(vas_register_coproc_api);
-
-void vas_unregister_coproc_api(void)
-{
-	dev_t devno;
-
-	cdev_del(&coproc_device.cdev);
-	devno = MKDEV(MAJOR(coproc_device.devt), 0);
-	device_destroy(coproc_device.class, devno);
-
-	class_destroy(coproc_device.class);
-	unregister_chrdev_region(coproc_device.devt, 1);
-}
-EXPORT_SYMBOL_GPL(vas_unregister_coproc_api);
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 1f6e73809205..032b04d4d3d4 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -437,8 +437,6 @@ extern irqreturn_t vas_fault_handler(int irq, void *dev_id);
 extern void vas_return_credit(struct vas_window *window, bool tx);
 extern struct vas_window *vas_pswid_to_window(struct vas_instance *vinst,
 						uint32_t pswid);
-extern void vas_win_paste_addr(struct vas_window *window, u64 *addr,
-					int *len);
 
 static inline int vas_window_pid(struct vas_window *window)
 {
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cd0cbdafedbd..03742d7cb61a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -543,17 +543,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
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
 
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 6e7c4762bd23..d3be09092a3b 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -229,7 +229,7 @@ static inline int __pcilg_mio_inuser(
 		:
 		[cc] "+d" (cc), [val] "=d" (val), [len] "+d" (len),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:
 		[ioaddr] "a" (addr)
 		: "cc", "memory");
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 9509d345edcb..e1a750baf036 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -49,7 +49,7 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
-KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
+KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
 # sev-es.c indirectly inludes inat-table.h which is generated during
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9b3611e4cb80..045ab6d0a98b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1231,13 +1231,9 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
-	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
-	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
-		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
-
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1250,7 +1246,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return mode;
+		return SPECTRE_V2_USER_CMD_AUTO;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1260,8 +1256,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return mode;
+	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
+	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 840fdffec850..db225e325ccf 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -931,17 +931,18 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
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
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index a29997e6cf9e..214c8a8c4793 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -350,7 +350,7 @@ static void get_fixed_ranges(mtrr_type *frs)
 
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
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 38c517a786f4..34e7c49b8057 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -143,6 +143,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
 	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
@@ -401,6 +402,11 @@ void native_tss_update_io_bitmap(void)
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
diff --git a/crypto/lrw.c b/crypto/lrw.c
index 80d9076e42e0..7adc105c12f7 100644
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
index 74dc199d5486..a4677e1a1611 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -360,7 +360,7 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 
 	err = crypto_grab_skcipher(&ctx->spawn, skcipher_crypto_instance(inst),
 				   cipher_name, 0, mask);
-	if (err == -ENOENT) {
+	if (err == -ENOENT && memcmp(cipher_name, "ecb(", 4)) {
 		err = -ENAMETOOLONG;
 		if (snprintf(ctx->name, CRYPTO_MAX_ALG_NAME, "ecb(%s)",
 			     cipher_name) >= CRYPTO_MAX_ALG_NAME)
@@ -394,7 +394,7 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	/* Alas we screwed up the naming so we have to mangle the
 	 * cipher name.
 	 */
-	if (!strncmp(cipher_name, "ecb(", 4)) {
+	if (!memcmp(cipher_name, "ecb(", 4)) {
 		int len;
 
 		len = strscpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index fb9ed5e1da89..2bdae8a25e08 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -668,6 +668,8 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	union acpi_parse_object *arguments[ACPI_OBJ_NUM_OPERANDS];
 	u32 arg_count = 0;
 	u32 index = walk_state->num_operands;
+	u32 prev_num_operands = walk_state->num_operands;
+	u32 new_num_operands;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_create_operands, first_arg);
@@ -696,6 +698,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 
 	/* Create the interpreter arguments, in reverse order */
 
+	new_num_operands = index;
 	index--;
 	for (i = 0; i < arg_count; i++) {
 		arg = arguments[index];
@@ -720,7 +723,11 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 * pop everything off of the operand stack and delete those
 	 * objects
 	 */
-	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
+	walk_state->num_operands = i;
+	acpi_ds_obj_stack_pop_and_delete(new_num_operands, walk_state);
+
+	/* Restore operand count */
+	walk_state->num_operands = prev_num_operands;
 
 	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 2480c26c5171..bf708126a752 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -636,7 +636,8 @@ acpi_status
 acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status)
 {
-	acpi_status status2;
+	acpi_status return_status = status;
+	u8 ascending = TRUE;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_complete_final_op, walk_state);
 
@@ -650,7 +651,7 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  op));
 	do {
 		if (op) {
-			if (walk_state->ascending_callback != NULL) {
+			if (ascending && walk_state->ascending_callback != NULL) {
 				walk_state->op = op;
 				walk_state->op_info =
 				    acpi_ps_get_opcode_info(op->common.
@@ -672,49 +673,26 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 				}
 
 				if (status == AE_CTRL_TERMINATE) {
-					status = AE_OK;
-
-					/* Clean up */
-					do {
-						if (op) {
-							status2 =
-							    acpi_ps_complete_this_op
-							    (walk_state, op);
-							if (ACPI_FAILURE
-							    (status2)) {
-								return_ACPI_STATUS
-								    (status2);
-							}
-						}
-
-						acpi_ps_pop_scope(&
-								  (walk_state->
-								   parser_state),
-								  &op,
-								  &walk_state->
-								  arg_types,
-								  &walk_state->
-								  arg_count);
-
-					} while (op);
-
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = AE_CTRL_TERMINATE;
 				}
 
 				else if (ACPI_FAILURE(status)) {
 
 					/* First error is most important */
 
-					(void)
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = status;
 				}
 			}
 
-			status2 = acpi_ps_complete_this_op(walk_state, op);
-			if (ACPI_FAILURE(status2)) {
-				return_ACPI_STATUS(status2);
+			status = acpi_ps_complete_this_op(walk_state, op);
+			if (ACPI_FAILURE(status)) {
+				ascending = FALSE;
+				if (ACPI_SUCCESS(return_status) ||
+				    return_status == AE_CTRL_TERMINATE) {
+					return_status = status;
+				}
 			}
 		}
 
@@ -724,5 +702,5 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 
 	} while (op);
 
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(return_status);
 }
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 681c11f4af4e..a288643e8acd 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -333,11 +333,8 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 
 	pos = string;
 
-	if (size != ACPI_UINT32_MAX) {
-		end = string + size;
-	} else {
-		end = ACPI_CAST_PTR(char, ACPI_UINT32_MAX);
-	}
+	size = ACPI_MIN(size, ACPI_PTR_DIFF(ACPI_MAX_PTR, string));
+	end = string + size;
 
 	for (; *format; ++format) {
 		if (*format != '%') {
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..71e0d64a7792 100644
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
index a6c851411073..72087e05b5a5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1478,7 +1478,7 @@ void __init ghes_init(void)
 {
 	int rc;
 
-	sdei_init();
+	acpi_sdei_init();
 
 	if (acpi_disabled)
 		return;
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f9fb092f33a2..4a188cc28b5c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -255,10 +255,23 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
 			ret = -ENODEV;
-		else
-			val->intval = battery->rate_now * 1000;
+			break;
+		}
+
+		val->intval = battery->rate_now * 1000;
+		/*
+		 * When discharging, the current should be reported as a
+		 * negative number as per the power supply class interface
+		 * definition.
+		 */
+		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
+		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
+		    acpi_battery_handle_discharging(battery)
+				== POWER_SUPPLY_STATUS_DISCHARGING)
+			val->intval = -val->intval;
+
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 9f6853809138..d93409f2b2a0 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -42,7 +42,6 @@ static struct acpi_osi_entry
 osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Module Device", true},
 	{"Processor Device", true},
-	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
 	/*
 	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 38044e679795..e5c4d954514d 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -368,7 +368,8 @@ static unsigned long via_mode_filter(struct ata_device *dev, unsigned long mask)
 	}
 
 	if (dev->class == ATA_DEV_ATAPI &&
-	    dmi_check_system(no_atapi_dma_dmi_table)) {
+	    (dmi_check_system(no_atapi_dma_dmi_table) ||
+	     config->id == PCI_DEVICE_ID_VIA_6415)) {
 		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
 		mask &= ATA_MASK_PIO;
 	}
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index 96bea1ab1ecc..ff558908897f 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,9 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		goto done;
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f5a032b6b8d6..7a76f0c53f54 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2676,7 +2676,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-	if (index >= num_domains)
+	if (num_domains < 0 || index >= num_domains)
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 00a0bdcbb4aa..5600ceb9212d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -903,6 +903,8 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	if (!dev->power.is_suspended)
 		goto Complete;
 
+	dev->power.is_suspended = false;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -958,7 +960,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
-	dev->power.is_suspended = false;
 
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4950864d3ea5..58d376b1cd68 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -998,7 +998,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b664c36388e2..89b53ca086d6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -508,7 +508,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if (index * sizeof(*ref) >= prop->length)
+	if ((index + 1) * sizeof(*ref) > prop->length)
 		return -ENOENT;
 
 	ref_array = prop->pointer;
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index e2ea2356da06..ec043f4bb1f2 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -198,6 +198,7 @@ aoedev_downdev(struct aoedev *d)
 {
 	struct aoetgt *t, **tt, **te;
 	struct list_head *head, *pos, *nx;
+	struct request *rq, *rqnext;
 	int i;
 
 	d->flags &= ~DEVFL_UP;
@@ -223,6 +224,13 @@ aoedev_downdev(struct aoedev *d)
 	/* clean out the in-process request (if any) */
 	aoe_failip(d);
 
+	/* clean out any queued block requests */
+	list_for_each_entry_safe(rq, rqnext, &d->rq_list, queuelist) {
+		list_del_init(&rq->queuelist);
+		blk_mq_start_request(rq);
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+	}
+
 	/* fast fail all pending I/O */
 	if (d->blkq) {
 		/* UP is cleared, freeze+quiesce to insure all are errored */
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index e329cdd7156c..9c207f1c19fb 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -800,8 +800,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
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
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 305015486b91..ca8e2aec6ce2 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -214,12 +214,19 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
 	if (error < 0)
 		goto error_cleanup_resource;
 
-	dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
-						   &dpmcp_dev->dev,
-						   DL_FLAG_AUTOREMOVE_CONSUMER);
-	if (!dpmcp_dev->consumer_link) {
-		error = -EINVAL;
-		goto error_cleanup_mc_io;
+	/* If the DPRC device itself tries to allocate a portal (usually for
+	 * UAPI interaction), don't add a device link between them since the
+	 * DPMCP device is an actual child device of the DPRC and a reverse
+	 * dependency is not allowed.
+	 */
+	if (mc_dev != mc_bus_dev) {
+		dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
+							   &dpmcp_dev->dev,
+							   DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!dpmcp_dev->consumer_link) {
+			error = -EINVAL;
+			goto error_cleanup_mc_io;
+		}
 	}
 
 	*new_mc_io = mc_io;
diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index 85a0225db522..14d77dc618cc 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -19,7 +19,7 @@
 /**
  * Timeout in milliseconds to wait for the completion of an MC command
  */
-#define MC_CMD_COMPLETION_TIMEOUT_MS	500
+#define MC_CMD_COMPLETION_TIMEOUT_MS	15000
 
 /*
  * usleep_range() min and max values used to throttle down polling
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index fe8ecd6eaa4d..19300745ceaa 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -454,6 +454,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 	struct mhi_cmd *mhi_cmd;
 	struct mhi_event_ctxt *er_ctxt;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	bool reset_device = false;
 	int ret, i;
 
 	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
@@ -485,8 +486,23 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		return;
 	}
 
-	/* Trigger MHI RESET so that the device will not access host memory */
 	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		/*
+		 * If the device is in PBL or SBL, it will only respond to
+		 * RESET if the device is in SYSERR state. SYSERR might
+		 * already be cleared at this point.
+		 */
+		enum mhi_state cur_state = mhi_get_mhi_state(mhi_cntrl);
+		enum mhi_ee_type cur_ee = mhi_get_exec_env(mhi_cntrl);
+
+		if (cur_state == MHI_STATE_SYS_ERR)
+			reset_device = true;
+		else if (cur_ee != MHI_EE_PBL && cur_ee != MHI_EE_SBL)
+			reset_device = true;
+	}
+
+	/* Trigger MHI RESET so that the device will not access host memory */
+	if (reset_device) {
 		u32 in_reset = -1;
 		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
 
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index b1aa793b9eed..ed38c25fb0c5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -687,51 +687,6 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	return 0;
 }
 
-/* Interconnect instances to probe before l4_per instances */
-static struct resource early_bus_ranges[] = {
-	/* am3/4 l4_wkup */
-	{ .start = 0x44c00000, .end = 0x44c00000 + 0x300000, },
-	/* omap4/5 and dra7 l4_cfg */
-	{ .start = 0x4a000000, .end = 0x4a000000 + 0x300000, },
-	/* omap4 l4_wkup */
-	{ .start = 0x4a300000, .end = 0x4a300000 + 0x30000,  },
-	/* omap5 and dra7 l4_wkup without dra7 dcan segment */
-	{ .start = 0x4ae00000, .end = 0x4ae00000 + 0x30000,  },
-};
-
-static atomic_t sysc_defer = ATOMIC_INIT(10);
-
-/**
- * sysc_defer_non_critical - defer non_critical interconnect probing
- * @ddata: device driver data
- *
- * We want to probe l4_cfg and l4_wkup interconnect instances before any
- * l4_per instances as l4_per instances depend on resources on l4_cfg and
- * l4_wkup interconnects.
- */
-static int sysc_defer_non_critical(struct sysc *ddata)
-{
-	struct resource *res;
-	int i;
-
-	if (!atomic_read(&sysc_defer))
-		return 0;
-
-	for (i = 0; i < ARRAY_SIZE(early_bus_ranges); i++) {
-		res = &early_bus_ranges[i];
-		if (ddata->module_pa >= res->start &&
-		    ddata->module_pa <= res->end) {
-			atomic_set(&sysc_defer, 0);
-
-			return 0;
-		}
-	}
-
-	atomic_dec_if_positive(&sysc_defer);
-
-	return -EPROBE_DEFER;
-}
-
 static struct device_node *stdout_path;
 
 static void sysc_init_stdout_path(struct sysc *ddata)
@@ -956,10 +911,6 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 	if (error)
 		return error;
 
-	error = sysc_defer_non_critical(ddata);
-	if (error)
-		return error;
-
 	sysc_check_children(ddata);
 
 	error = sysc_parse_registers(ddata);
diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 969227e2df21..f6e7ff6e9d7c 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -199,6 +199,8 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL,
 				   "fw-clk-%s",
 				   rpi_firmware_clk_names[id]);
+	if (!init.name)
+		return ERR_PTR(-ENOMEM);
 	init.ops = &raspberrypi_firmware_clk_ops;
 	init.flags = CLK_GET_RATE_NOCACHE;
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 3280b7410a13..d6b42cd9c913 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3906,6 +3906,7 @@ static const struct clk_parent_data spicc_sclk_parent_data[] = {
 	{ .hw = &g12a_clk81.hw },
 	{ .hw = &g12a_fclk_div4.hw },
 	{ .hw = &g12a_fclk_div3.hw },
+	{ .hw = &g12a_fclk_div2.hw },
 	{ .hw = &g12a_fclk_div5.hw },
 	{ .hw = &g12a_fclk_div7.hw },
 };
diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index 39ebb443ae3d..a51f5c25782f 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -433,7 +433,7 @@ static const struct parent_map gcc_xo_gpll0_gpll1a_gpll6_sleep_map[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0, 1 },
 	{ P_GPLL1_AUX, 2 },
-	{ P_GPLL6, 2 },
+	{ P_GPLL6, 3 },
 	{ P_SLEEP_CLK, 6 },
 };
 
@@ -1075,7 +1075,7 @@ static struct clk_rcg2 jpeg0_clk_src = {
 };
 
 static const struct freq_tbl ftbl_gcc_camss_mclk0_1_clk[] = {
-	F(24000000, P_GPLL0, 1, 1, 45),
+	F(24000000, P_GPLL6, 1, 1, 45),
 	F(66670000, P_GPLL0, 12, 0, 0),
 	{ }
 };
diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 6a46f85ad837..4a8c72d99573 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -429,6 +429,7 @@ static const char *const rk3036_critical_clocks[] __initconst = {
 	"hclk_peri",
 	"pclk_peri",
 	"pclk_ddrupctl",
+	"ddrphy",
 };
 
 static void __init rk3036_clk_init(struct device_node *np)
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 4109dda5e36d..0f74c5e5ed0f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -657,7 +657,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (nominal_freq)
-		*nominal_freq = perf_caps.nominal_freq;
+		*nominal_freq = perf_caps.nominal_freq * 1000;
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d13139497da4..6294e10657b4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2637,8 +2637,10 @@ int cpufreq_boost_trigger_state(int state)
 	unsigned long flags;
 	int ret = 0;
 
-	if (cpufreq_driver->boost_enabled == state)
-		return 0;
+	/*
+	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
+	 * make sure all policies are in sync with global boost flag.
+	 */
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = state;
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 558027516aed..0cacbd51b480 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -295,8 +295,8 @@ struct sun8i_ce_hash_tfm_ctx {
  * @flow:	the flow to use for this request
  */
 struct sun8i_ce_hash_reqctx {
-	struct ahash_request fallback_req;
 	int flow;
+	struct ahash_request fallback_req; // keep at the end
 };
 
 /*
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 8a94f812e6d2..f8603b931b9b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -117,7 +117,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 
 	/* we need to copy all IVs from source in case DMA is bi-directionnal */
 	while (sg && len) {
-		if (sg_dma_len(sg) == 0) {
+		if (sg->length == 0) {
 			sg = sg_next(sg);
 			continue;
 		}
diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index 06211858bf2e..967338426959 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -94,7 +94,7 @@ static int mv_cesa_std_process(struct mv_cesa_engine *engine, u32 status)
 
 static int mv_cesa_int_process(struct mv_cesa_engine *engine, u32 status)
 {
-	if (engine->chain.first && engine->chain.last)
+	if (engine->chain_hw.first && engine->chain_hw.last)
 		return mv_cesa_tdma_process(engine, status);
 
 	return mv_cesa_std_process(engine, status);
diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index fa56b45620c7..4051d566359e 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -439,8 +439,10 @@ struct mv_cesa_dev {
  *			SRAM
  * @queue:		fifo of the pending crypto requests
  * @load:		engine load counter, useful for load balancing
- * @chain:		list of the current tdma descriptors being processed
- *			by this engine.
+ * @chain_hw:		list of the current tdma descriptors being processed
+ *			by the hardware.
+ * @chain_sw:		list of the current tdma descriptors that will be
+ *			submitted to the hardware.
  * @complete_queue:	fifo of the processed requests by the engine
  *
  * Structure storing CESA engine information.
@@ -459,7 +461,8 @@ struct mv_cesa_engine {
 	struct gen_pool *pool;
 	struct crypto_queue queue;
 	atomic_t load;
-	struct mv_cesa_tdma_chain chain;
+	struct mv_cesa_tdma_chain chain_hw;
+	struct mv_cesa_tdma_chain chain_sw;
 	struct list_head complete_queue;
 	int irq;
 };
diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index 8dc10f998894..051a661a63ee 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -449,6 +449,9 @@ static int mv_cesa_skcipher_queue_req(struct skcipher_request *req,
 	struct mv_cesa_skcipher_req *creq = skcipher_request_ctx(req);
 	struct mv_cesa_engine *engine;
 
+	if (!req->cryptlen)
+		return 0;
+
 	ret = mv_cesa_skcipher_req_init(req, tmpl);
 	if (ret)
 		return ret;
diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index 8441c3198d46..823a8fb114bb 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -639,7 +639,7 @@ static int mv_cesa_ahash_dma_req_init(struct ahash_request *req)
 	if (ret)
 		goto err_free_tdma;
 
-	if (iter.src.sg) {
+	if (iter.base.len > iter.src.op_offset) {
 		/*
 		 * Add all the new data, inserting an operation block and
 		 * launch command between each full SRAM block-worth of
diff --git a/drivers/crypto/marvell/cesa/tdma.c b/drivers/crypto/marvell/cesa/tdma.c
index 5d9c48fb72b2..9619c9e886aa 100644
--- a/drivers/crypto/marvell/cesa/tdma.c
+++ b/drivers/crypto/marvell/cesa/tdma.c
@@ -38,6 +38,15 @@ void mv_cesa_dma_step(struct mv_cesa_req *dreq)
 {
 	struct mv_cesa_engine *engine = dreq->engine;
 
+	spin_lock_bh(&engine->lock);
+	if (engine->chain_sw.first == dreq->chain.first) {
+		engine->chain_sw.first = NULL;
+		engine->chain_sw.last = NULL;
+	}
+	engine->chain_hw.first = dreq->chain.first;
+	engine->chain_hw.last = dreq->chain.last;
+	spin_unlock_bh(&engine->lock);
+
 	writel_relaxed(0, engine->regs + CESA_SA_CFG);
 
 	mv_cesa_set_int_mask(engine, CESA_SA_INT_ACC0_IDMA_DONE);
@@ -96,25 +105,27 @@ void mv_cesa_dma_prepare(struct mv_cesa_req *dreq,
 void mv_cesa_tdma_chain(struct mv_cesa_engine *engine,
 			struct mv_cesa_req *dreq)
 {
-	if (engine->chain.first == NULL && engine->chain.last == NULL) {
-		engine->chain.first = dreq->chain.first;
-		engine->chain.last  = dreq->chain.last;
-	} else {
-		struct mv_cesa_tdma_desc *last;
+	struct mv_cesa_tdma_desc *last = engine->chain_sw.last;
 
-		last = engine->chain.last;
+	/*
+	 * Break the DMA chain if the request being queued needs the IV
+	 * regs to be set before lauching the request.
+	 */
+	if (!last || dreq->chain.first->flags & CESA_TDMA_SET_STATE)
+		engine->chain_sw.first = dreq->chain.first;
+	else {
 		last->next = dreq->chain.first;
-		engine->chain.last = dreq->chain.last;
-
-		/*
-		 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
-		 * the last element of the current chain, or if the request
-		 * being queued needs the IV regs to be set before lauching
-		 * the request.
-		 */
-		if (!(last->flags & CESA_TDMA_BREAK_CHAIN) &&
-		    !(dreq->chain.first->flags & CESA_TDMA_SET_STATE))
-			last->next_dma = cpu_to_le32(dreq->chain.first->cur_dma);
+		last->next_dma = cpu_to_le32(dreq->chain.first->cur_dma);
+	}
+	last = dreq->chain.last;
+	engine->chain_sw.last = last;
+	/*
+	 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
+	 * the last element of the current chain.
+	 */
+	if (last->flags & CESA_TDMA_BREAK_CHAIN) {
+		engine->chain_sw.first = NULL;
+		engine->chain_sw.last = NULL;
 	}
 }
 
@@ -127,7 +138,7 @@ int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
 
 	tdma_cur = readl(engine->regs + CESA_TDMA_CUR);
 
-	for (tdma = engine->chain.first; tdma; tdma = next) {
+	for (tdma = engine->chain_hw.first; tdma; tdma = next) {
 		spin_lock_bh(&engine->lock);
 		next = tdma->next;
 		spin_unlock_bh(&engine->lock);
@@ -149,12 +160,12 @@ int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
 								 &backlog);
 
 			/* Re-chaining to the next request */
-			engine->chain.first = tdma->next;
+			engine->chain_hw.first = tdma->next;
 			tdma->next = NULL;
 
 			/* If this is the last request, clear the chain */
-			if (engine->chain.first == NULL)
-				engine->chain.last  = NULL;
+			if (engine->chain_hw.first == NULL)
+				engine->chain_hw.last  = NULL;
 			spin_unlock_bh(&engine->lock);
 
 			ctx = crypto_tfm_ctx(req->tfm);
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 597a92438afc..4264d88a5e6b 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -127,8 +127,7 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 			ubuf->sg = NULL;
 		}
 	} else {
-		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
-				    direction);
+		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
 	return ret;
@@ -143,7 +142,7 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
 	if (!ubuf->sg)
 		return -EINVAL;
 
-	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, direction);
+	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
 	return 0;
 }
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1f01bd483c6b..cade321095d2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3672,7 +3672,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
-
+		if (!uc->name)
+			return -ENOMEM;
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
 		tasklet_setup(&uc->vc.task, udma_vchan_complete);
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 99aaada3a2d9..61de8b1ed75e 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1704,9 +1704,9 @@ static ssize_t altr_edac_a10_device_trig(struct file *file,
 
 	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR)
-		writel(priv->ue_set_mask, set_addr);
+		writew(priv->ue_set_mask, set_addr);
 	else
-		writel(priv->ce_set_mask, set_addr);
+		writew(priv->ce_set_mask, set_addr);
 
 	/* Ensure the interrupt test bits are set */
 	wmb();
@@ -1736,7 +1736,7 @@ static ssize_t altr_edac_a10_device_trig2(struct file *file,
 
 	local_irq_save(flags);
 	if (trig_type == ALTR_UE_TRIGGER_CHAR) {
-		writel(priv->ue_set_mask, set_addr);
+		writew(priv->ue_set_mask, set_addr);
 	} else {
 		/* Setup read/write of 4 bytes */
 		writel(ECC_WORD_WRITE, drvdata->base + ECC_BLK_DBYTECTRL_OFST);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index b585cbe3eff9..1c408e665f7c 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -112,6 +112,7 @@ EXPORT_SYMBOL_GPL(skx_adxl_get);
 
 void skx_adxl_put(void)
 {
+	adxl_component_count = 0;
 	kfree(adxl_values);
 	kfree(adxl_msg);
 }
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index a83101310e34..67023e184bb1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -72,7 +72,6 @@ config ARM_SCPI_POWER_DOMAIN
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
-	depends on ACPI_APEI_GHES
 	help
 	  The Software Delegated Exception Interface (SDEI) is an ARM
 	  standard for registering callbacks from the platform firmware
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index b160851c524c..0fbf12df19d0 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1063,13 +1063,12 @@ static bool __init sdei_present_acpi(void)
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
@@ -1082,6 +1081,12 @@ void __init sdei_init(void)
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
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..2c435a8d3548 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -571,8 +571,10 @@ int __init psci_dt_init(void)
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
-	if (!np || !of_device_is_available(np))
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	init_fn = (psci_initcall_t)matched_np->data;
 	ret = init_fn(np);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 72410a2d4e6b..567183a69660 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4002,8 +4002,6 @@ static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 79c52c7a02e3..d447b2416b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2896,8 +2896,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
 				buffer[count++] = cpu_to_le32(ext->reg_index - 0xa000);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 04eaf3a8fddb..d6f3d3cfc19f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4000,8 +4000,6 @@ static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
 				buffer[count++] = cpu_to_le32(ext->reg_index - PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index c36258d56b44..0459e7b71945 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1268,8 +1268,6 @@ static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 432c24f3c798..5bd1fcd02396 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1741,8 +1741,6 @@ static void gfx_v9_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dadeb2013fd9..dc468dfce391 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -396,6 +396,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
+	/* Allow context switch so we don't cross-process starve with a massive
+	 * command buffer of long-running SDMA commands
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 260133562db5..45420968e5f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8098,16 +8098,20 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 	 */
 	conn_state = drm_atomic_get_connector_state(state, connector);
 
-	ret = PTR_ERR_OR_ZERO(conn_state);
-	if (ret)
+	/* Check for error in getting connector state */
+	if (IS_ERR(conn_state)) {
+		ret = PTR_ERR(conn_state);
 		goto out;
+	}
 
 	/* Attach crtc to drm_atomic_state*/
 	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
 
-	ret = PTR_ERR_OR_ZERO(crtc_state);
-	if (ret)
+	/* Check for error in getting crtc state */
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
 		goto out;
+	}
 
 	/* force a restore */
 	crtc_state->mode_changed = true;
@@ -8115,9 +8119,11 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 	/* Attach plane to drm_atomic_state */
 	plane_state = drm_atomic_get_plane_state(state, plane);
 
-	ret = PTR_ERR_OR_ZERO(plane_state);
-	if (ret)
+	/* Check for error in getting plane state */
+	if (IS_ERR(plane_state)) {
+		ret = PTR_ERR(plane_state);
 		goto out;
+	}
 
 	/* Call commit internally with the state we just constructed */
 	ret = drm_atomic_commit(state);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 5fcaf78334ff..54db9af8437d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -10,7 +10,7 @@ DCN20 = dcn20_resource.o dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o d
 DCN20 += dcn20_dsc.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := $(if $(CONFIG_CC_IS_GCC), -mhard-float) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 07684d3e375a..90eefd2c3ecf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -6,7 +6,7 @@ DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
 	 dcn21_hwseq.o dcn21_link_encoder.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := $(if $(CONFIG_CC_IS_GCC), -mhard-float) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 417331438c30..ce8251151b45 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -26,7 +26,8 @@
 # subcomponents.
 
 ifdef CONFIG_X86
-dml_ccflags := -mhard-float -msse
+dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
+dml_ccflags := $(dml_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e8baa07450b7..3d8f08d89561 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1778,10 +1778,10 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 		 * that we can get the current state of the GPIO.
 		 */
 		dp->irq = gpiod_to_irq(dp->hpd_gpiod);
-		irq_flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		irq_flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN;
 	} else {
 		dp->irq = platform_get_irq(pdev, 0);
-		irq_flags = 0;
+		irq_flags = IRQF_NO_AUTOEN;
 	}
 
 	if (dp->irq == -ENXIO) {
@@ -1798,7 +1798,6 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 		dev_err(&pdev->dev, "failed to request irq\n");
 		goto err_disable_clk;
 	}
-	disable_irq(dp->irq);
 
 	return dp;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index ccd44d0418f8..8bcf87726ec6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -102,7 +102,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
 
 	/* Wait for a response */
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
-		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
+		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);
 
 	if (ret) {
 		DRM_DEV_ERROR(gmu->dev,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 33880f66625e..f9da37999946 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -353,7 +353,8 @@ static void dpu_encoder_phys_vid_underrun_irq(void *arg, int irq_idx)
 static bool dpu_encoder_phys_vid_needs_single_flush(
 		struct dpu_encoder_phys *phys_enc)
 {
-	return phys_enc->split_role != ENC_ROLE_SOLO;
+	return !(phys_enc->hw_ctl->caps->features & BIT(DPU_CTL_ACTIVE_CFG)) &&
+		phys_enc->split_role != ENC_ROLE_SOLO;
 }
 
 static void _dpu_encoder_phys_vid_setup_irq_hw_idx(
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index de182c004843..9c78c6c528be 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -107,11 +107,15 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 	if (num == 0)
 		return num;
 
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		return ret;
+
 	init_ddc(hdmi_i2c);
 
 	ret = ddc_clear_irq(hdmi_i2c);
 	if (ret)
-		return ret;
+		goto fail;
 
 	for (i = 0; i < num; i++) {
 		struct i2c_msg *p = &msgs[i];
@@ -169,7 +173,7 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 				hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS),
 				hdmi_read(hdmi, REG_HDMI_DDC_HW_STATUS),
 				hdmi_read(hdmi, REG_HDMI_DDC_INT_CTRL));
-		return ret;
+		goto fail;
 	}
 
 	ddc_status = hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS);
@@ -202,7 +206,13 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 		}
 	}
 
+	pm_runtime_put(&hdmi->pdev->dev);
+
 	return i;
+
+fail:
+	pm_runtime_put(&hdmi->pdev->dev);
+	return ret;
 }
 
 static u32 msm_hdmi_i2c_func(struct i2c_adapter *adapter)
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index f2f3280c3a50..171cc170c458 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -40,7 +40,7 @@
 #include "nouveau_connector.h"
 
 static struct ida bl_ida;
-#define BL_NAME_SIZE 15 // 12 for name + 2 for digits + 1 for '\0'
+#define BL_NAME_SIZE 24 // 12 for name + 11 for digits + 1 for '\0'
 
 struct nouveau_backlight {
 	struct backlight_device *dev;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 7015e22872bb..41b4a6715dad 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -626,7 +626,7 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
 		ret = of_parse_phandle_with_fixed_args(np, vsps_prop_name,
 						       cells, i, &args);
 		if (ret < 0)
-			goto error;
+			goto done;
 
 		/*
 		 * Add the VSP to the list or update the corresponding existing
@@ -664,13 +664,11 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
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
index 4142a56ca764..a3052f645c47 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -170,6 +170,11 @@ static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helper_funcs = {
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
@@ -177,7 +182,14 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
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
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 1ae5cd47d954..2225e764e709 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -194,7 +194,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		i++;
 	}
 
-	vkms_state->active_planes = kcalloc(i, sizeof(plane), GFP_KERNEL);
+	vkms_state->active_planes = kcalloc(i, sizeof(*vkms_state->active_planes), GFP_KERNEL);
 	if (!vkms_state->active_planes)
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 616f6cb62278..987633c6c49f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -4027,6 +4027,23 @@ static int vmw_execbuf_tie_context(struct vmw_private *dev_priv,
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
@@ -4220,6 +4237,15 @@ int vmw_execbuf_process(struct drm_file *file_priv,
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
 
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index b7704dd6809d..bf77cfb723d5 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -199,7 +199,8 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (!input_device->hid_desc)
 		goto cleanup;
 
-	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
+	input_device->report_desc_size = le16_to_cpu(
+					desc->rpt_desc.wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -217,7 +218,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       desc->desc[0].wDescriptorLength);
+	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 009a0469d54f..c3b104c72e49 100644
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
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index d052502dc2c0..18f1b57431ff 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -41,6 +41,14 @@ struct temp_sensor_2 {
 	u8 value;
 } __packed;
 
+struct temp_sensor_10 {
+	u32 sensor_id;
+	u8 fru_type;
+	u8 value;
+	u8 throttle;
+	u8 reserved;
+} __packed;
+
 struct freq_sensor_1 {
 	u16 sensor_id;
 	u16 value;
@@ -307,6 +315,53 @@ static ssize_t occ_show_temp_2(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
 }
 
+static ssize_t occ_show_temp_10(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_10 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_10 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&temp->sensor_id);
+		break;
+	case 1:
+		val = temp->value;
+		if (val == OCC_TEMP_SENSOR_FAULT)
+			return -EREMOTEIO;
+
+		/* sensor not ready */
+		if (val == 0)
+			return -EAGAIN;
+
+		val *= 1000;
+		break;
+	case 2:
+		val = temp->fru_type;
+		break;
+	case 3:
+		val = temp->value == OCC_TEMP_SENSOR_FAULT;
+		break;
+	case 4:
+		val = temp->throttle * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
 static ssize_t occ_show_freq_1(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -406,12 +461,10 @@ static ssize_t occ_show_power_1(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
 }
 
-static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
+static u64 occ_get_powr_avg(u64 accum, u32 samples)
 {
-	u64 divisor = get_unaligned_be32(samples);
-
-	return (divisor == 0) ? 0 :
-		div64_u64(get_unaligned_be64(accum) * 1000000ULL, divisor);
+	return (samples == 0) ? 0 :
+		mul_u64_u32_div(accum, 1000000UL, samples);
 }
 
 static ssize_t occ_show_power_2(struct device *dev,
@@ -436,8 +489,8 @@ static ssize_t occ_show_power_2(struct device *dev,
 				get_unaligned_be32(&power->sensor_id),
 				power->function_id, power->apss_channel);
 	case 1:
-		val = occ_get_powr_avg(&power->accumulator,
-				       &power->update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->accumulator),
+				       get_unaligned_be32(&power->update_tag));
 		break;
 	case 2:
 		val = (u64)get_unaligned_be32(&power->update_tag) *
@@ -474,8 +527,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_system\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 1:
-		val = occ_get_powr_avg(&power->system.accumulator,
-				       &power->system.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->system.accumulator),
+				       get_unaligned_be32(&power->system.update_tag));
 		break;
 	case 2:
 		val = (u64)get_unaligned_be32(&power->system.update_tag) *
@@ -488,8 +541,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_proc\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 5:
-		val = occ_get_powr_avg(&power->proc.accumulator,
-				       &power->proc.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->proc.accumulator),
+				       get_unaligned_be32(&power->proc.update_tag));
 		break;
 	case 6:
 		val = (u64)get_unaligned_be32(&power->proc.update_tag) *
@@ -502,8 +555,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_vdd\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 9:
-		val = occ_get_powr_avg(&power->vdd.accumulator,
-				       &power->vdd.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->vdd.accumulator),
+				       get_unaligned_be32(&power->vdd.update_tag));
 		break;
 	case 10:
 		val = (u64)get_unaligned_be32(&power->vdd.update_tag) *
@@ -516,8 +569,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_vdn\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 13:
-		val = occ_get_powr_avg(&power->vdn.accumulator,
-				       &power->vdn.update_tag);
+		val = occ_get_powr_avg(get_unaligned_be64(&power->vdn.accumulator),
+				       get_unaligned_be32(&power->vdn.update_tag));
 		break;
 	case 14:
 		val = (u64)get_unaligned_be32(&power->vdn.update_tag) *
@@ -623,6 +676,9 @@ static ssize_t occ_show_caps_3(struct device *dev,
 	case 7:
 		val = caps->user_source;
 		break;
+	case 8:
+		val = get_unaligned_be16(&caps->soft_min) * 1000000ULL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -694,29 +750,30 @@ static ssize_t occ_show_extended(struct device *dev,
 }
 
 /*
- * Some helper macros to make it easier to define an occ_attribute. Since these
- * are dynamically allocated, we shouldn't use the existing kernel macros which
+ * A helper to make it easier to define an occ_attribute. Since these
+ * are dynamically allocated, we cannot use the existing kernel macros which
  * stringify the name argument.
  */
-#define ATTR_OCC(_name, _mode, _show, _store) {				\
-	.attr	= {							\
-		.name = _name,						\
-		.mode = VERIFY_OCTAL_PERMISSIONS(_mode),		\
-	},								\
-	.show	= _show,						\
-	.store	= _store,						\
-}
-
-#define SENSOR_ATTR_OCC(_name, _mode, _show, _store, _nr, _index) {	\
-	.dev_attr	= ATTR_OCC(_name, _mode, _show, _store),	\
-	.index		= _index,					\
-	.nr		= _nr,						\
+static void occ_init_attribute(struct occ_attribute *attr, int mode,
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf),
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count),
+	int nr, int index, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(attr->name, sizeof(attr->name), fmt, args);
+	va_end(args);
+
+	attr->sensor.dev_attr.attr.name = attr->name;
+	attr->sensor.dev_attr.attr.mode = mode;
+	attr->sensor.dev_attr.show = show;
+	attr->sensor.dev_attr.store = store;
+	attr->sensor.index = index;
+	attr->sensor.nr = nr;
 }
 
-#define OCC_INIT_ATTR(_name, _mode, _show, _store, _nr, _index)		\
-	((struct sensor_device_attribute_2)				\
-		SENSOR_ATTR_OCC(_name, _mode, _show, _store, _nr, _index))
-
 /*
  * Allocate and instatiate sensor_device_attribute_2s. It's most efficient to
  * use our own instead of the built-in hwmon attribute types.
@@ -745,6 +802,10 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		num_attrs += (sensors->temp.num_sensors * 4);
 		show_temp = occ_show_temp_2;
 		break;
+	case 0x10:
+		num_attrs += (sensors->temp.num_sensors * 5);
+		show_temp = occ_show_temp_10;
+		break;
 	default:
 		sensors->temp.num_sensors = 0;
 	}
@@ -779,12 +840,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	case 1:
 		num_attrs += (sensors->caps.num_sensors * 7);
 		break;
-	case 3:
-		show_caps = occ_show_caps_3;
-		fallthrough;
 	case 2:
 		num_attrs += (sensors->caps.num_sensors * 8);
 		break;
+	case 3:
+		show_caps = occ_show_caps_3;
+		num_attrs += (sensors->caps.num_sensors * 9);
+		break;
 	default:
 		sensors->caps.num_sensors = 0;
 	}
@@ -797,14 +859,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		sensors->extended.num_sensors = 0;
 	}
 
-	occ->attrs = devm_kzalloc(dev, sizeof(*occ->attrs) * num_attrs,
+	occ->attrs = devm_kcalloc(dev, num_attrs, sizeof(*occ->attrs),
 				  GFP_KERNEL);
 	if (!occ->attrs)
 		return -ENOMEM;
 
 	/* null-terminated list */
-	occ->group.attrs = devm_kzalloc(dev, sizeof(*occ->group.attrs) *
-					num_attrs + 1, GFP_KERNEL);
+	occ->group.attrs = devm_kcalloc(dev, num_attrs + 1,
+					sizeof(*occ->group.attrs),
+					GFP_KERNEL);
 	if (!occ->group.attrs)
 		return -ENOMEM;
 
@@ -814,50 +877,47 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		s = i + 1;
 		temp = ((struct temp_sensor_2 *)sensors->temp.data) + i;
 
-		snprintf(attr->name, sizeof(attr->name), "temp%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_temp, NULL,
-					     0, i);
+		occ_init_attribute(attr, 0444, show_temp, NULL,
+				   0, i, "temp%d_label", s);
 		attr++;
 
-		if (sensors->temp.version > 1 &&
+		if (sensors->temp.version == 2 &&
 		    temp->fru_type == OCC_FRU_TYPE_VRM) {
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_alarm", s);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   1, i, "temp%d_alarm", s);
 		} else {
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_input", s);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   1, i, "temp%d_input", s);
 		}
 
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_temp, NULL,
-					     1, i);
 		attr++;
 
 		if (sensors->temp.version > 1) {
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_fru_type", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_temp, NULL, 2, i);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   2, i, "temp%d_fru_type", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "temp%d_fault", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_temp, NULL, 3, i);
+			occ_init_attribute(attr, 0444, show_temp, NULL,
+					   3, i, "temp%d_fault", s);
 			attr++;
+
+			if (sensors->temp.version == 0x10) {
+				occ_init_attribute(attr, 0444, show_temp, NULL,
+						   4, i, "temp%d_max", s);
+				attr++;
+			}
 		}
 	}
 
 	for (i = 0; i < sensors->freq.num_sensors; ++i) {
 		s = i + 1;
 
-		snprintf(attr->name, sizeof(attr->name), "freq%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_freq, NULL,
-					     0, i);
+		occ_init_attribute(attr, 0444, show_freq, NULL,
+				   0, i, "freq%d_label", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "freq%d_input", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_freq, NULL,
-					     1, i);
+		occ_init_attribute(attr, 0444, show_freq, NULL,
+				   1, i, "freq%d_input", s);
 		attr++;
 	}
 
@@ -873,32 +933,24 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 			s = (i * 4) + 1;
 
 			for (j = 0; j < 4; ++j) {
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_label", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_label", s);
 				attr++;
 
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_average", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_average", s);
 				attr++;
 
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_average_interval", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_average_interval", s);
 				attr++;
 
-				snprintf(attr->name, sizeof(attr->name),
-					 "power%d_input", s);
-				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-							     show_power, NULL,
-							     nr++, i);
+				occ_init_attribute(attr, 0444, show_power,
+						   NULL, nr++, i,
+						   "power%d_input", s);
 				attr++;
 
 				s++;
@@ -910,28 +962,20 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		for (i = 0; i < sensors->power.num_sensors; ++i) {
 			s = i + 1;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_label", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 0, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   0, i, "power%d_label", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_average", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 1, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   1, i, "power%d_average", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_average_interval", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 2, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   2, i, "power%d_average_interval", s);
 			attr++;
 
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_input", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_power, NULL, 3, i);
+			occ_init_attribute(attr, 0444, show_power, NULL,
+					   3, i, "power%d_input", s);
 			attr++;
 		}
 
@@ -939,68 +983,61 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	}
 
 	if (sensors->caps.num_sensors >= 1) {
-		snprintf(attr->name, sizeof(attr->name), "power%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     0, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   0, 0, "power%d_label", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     1, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   1, 0, "power%d_cap", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_input", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     2, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   2, 0, "power%d_input", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name),
-			 "power%d_cap_not_redundant", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     3, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   3, 0, "power%d_cap_not_redundant", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap_max", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     4, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   4, 0, "power%d_cap_max", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap_min", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
-					     5, 0);
+		occ_init_attribute(attr, 0444, show_caps, NULL,
+				   5, 0, "power%d_cap_min", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "power%d_cap_user",
-			 s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0644, show_caps,
-					     occ_store_caps_user, 6, 0);
+		occ_init_attribute(attr, 0644, show_caps, occ_store_caps_user,
+				   6, 0, "power%d_cap_user", s);
 		attr++;
 
 		if (sensors->caps.version > 1) {
-			snprintf(attr->name, sizeof(attr->name),
-				 "power%d_cap_user_source", s);
-			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-						     show_caps, NULL, 7, 0);
+			occ_init_attribute(attr, 0444, show_caps, NULL,
+					   7, 0, "power%d_cap_user_source", s);
 			attr++;
+
+			if (sensors->caps.version > 2) {
+				occ_init_attribute(attr, 0444, show_caps, NULL,
+						   8, 0,
+						   "power%d_cap_min_soft", s);
+				attr++;
+			}
 		}
 	}
 
 	for (i = 0; i < sensors->extended.num_sensors; ++i) {
 		s = i + 1;
 
-		snprintf(attr->name, sizeof(attr->name), "extn%d_label", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-					     occ_show_extended, NULL, 0, i);
+		occ_init_attribute(attr, 0444, occ_show_extended, NULL,
+				   0, i, "extn%d_label", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "extn%d_flags", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-					     occ_show_extended, NULL, 1, i);
+		occ_init_attribute(attr, 0444, occ_show_extended, NULL,
+				   1, i, "extn%d_flags", s);
 		attr++;
 
-		snprintf(attr->name, sizeof(attr->name), "extn%d_input", s);
-		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
-					     occ_show_extended, NULL, 2, i);
+		occ_init_attribute(attr, 0444, occ_show_extended, NULL,
+				   2, i, "extn%d_input", s);
 		attr++;
 	}
 
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 5b54a9b9ed1a..09b8ccc040c6 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -97,7 +97,7 @@ static int i2c_dw_unreg_slave(struct i2c_client *slave)
 	dev->disable(dev);
 	synchronize_irq(dev->irq);
 	dev->slave = NULL;
-	pm_runtime_put(dev->dev);
+	pm_runtime_put_sync_suspend(dev->dev);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index d97694ac29ca..3f30c3cff720 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -1950,10 +1950,14 @@ static int npcm_i2c_init_module(struct npcm_i2c *bus, enum i2c_mode mode,
 
 	/* check HW is OK: SDA and SCL should be high at this point. */
 	if ((npcm_i2c_get_SDA(&bus->adap) == 0) || (npcm_i2c_get_SCL(&bus->adap) == 0)) {
-		dev_err(bus->dev, "I2C%d init fail: lines are low\n", bus->num);
-		dev_err(bus->dev, "SDA=%d SCL=%d\n", npcm_i2c_get_SDA(&bus->adap),
-			npcm_i2c_get_SCL(&bus->adap));
-		return -ENXIO;
+		dev_warn(bus->dev, " I2C%d SDA=%d SCL=%d, attempting to recover\n", bus->num,
+				 npcm_i2c_get_SDA(&bus->adap), npcm_i2c_get_SCL(&bus->adap));
+		if (npcm_i2c_recovery_tgclk(&bus->adap)) {
+			dev_err(bus->dev, "I2C%d init fail: SDA=%d SCL=%d\n",
+				bus->num, npcm_i2c_get_SDA(&bus->adap),
+				npcm_i2c_get_SCL(&bus->adap));
+			return -ENXIO;
+		}
 	}
 
 	npcm_i2c_int_enable(bus, true);
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 99d1288e6682..503814fca4dc 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -320,9 +320,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 
 	switch (st->channel_config[channel].filter_type) {
 	case AD7124_SINC3_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
 	case AD7124_SINC4_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index e9f4043966ae..0798ac74d972 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -151,7 +151,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
-				  (val & 0x1FF));
+				  (val & 0xFF));
 
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 213cce1c3111..91f0f381082b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	/*
 	 * T°C = (temp / 132.48) + 25
-	 * Tm°C = 1000 * ((temp * 100 / 13248) + 25)
+	 * Tm°C = 1000 * ((temp / 132.48) + 25)
+	 * Tm°C = 7.548309 * temp + 25000
+	 * Tm°C = (temp + 3312) * 7.548309
 	 * scale: 100000 / 13248 ~= 7.548309
-	 * offset: 25000
+	 * offset: 3312
 	 */
 	case IIO_CHAN_INFO_SCALE:
 		*val = 7;
 		*val2 = 548309;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000;
+		*val = 3312;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 13aa8dd42f7d..bb744ba155e2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -42,7 +42,6 @@
 #include <rdma/ib_umem.h>
 #include <rdma/uverbs_ioctl.h>
 
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 8948d2b5577d..80d14261cc4e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -34,6 +34,7 @@
 #define _HNS_ROCE_HW_V2_H
 
 #include <linux/bitops.h>
+#include "hnae3.h"
 
 #define HNS_ROCE_VF_QPC_BT_NUM			256
 #define HNS_ROCE_VF_SCCC_BT_NUM			64
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 3c79668c6b3b..9078855aad18 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,7 +37,6 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
-#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include <rdma/hns-abi.h>
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 259444c0a630..8acab99f7ea6 100644
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
index 9a306da7f949..245b7675bb4d 100644
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
 
@@ -172,6 +174,18 @@ static int create_resource_common(struct mlx5_ib_dev *dev,
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
@@ -578,8 +592,20 @@ int mlx5_core_create_rq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
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
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index e5cb20e7f57b..7ced98d07431 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -845,6 +845,12 @@ static int ims_pcu_flash_firmware(struct ims_pcu *pcu,
 		addr = be32_to_cpu(rec->addr) / 2;
 		len = be16_to_cpu(rec->len);
 
+		if (len > sizeof(pcu->cmd_buf) - 1 - sizeof(*fragment)) {
+			dev_err(pcu->dev,
+				"Invalid record length in firmware: %d\n", len);
+			return -EINVAL;
+		}
+
 		fragment = (void *)&pcu->cmd_buf[1];
 		put_unaligned_le32(addr, &fragment->addr);
 		fragment->len = len;
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index cdcb7737c46a..b6549f44a67b 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -74,9 +74,14 @@ static int bbc_spkr_event(struct input_dev *dev, unsigned int type, unsigned int
 		return -1;
 
 	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
 	}
 
 	if (value > 20 && value < 32767)
@@ -112,9 +117,14 @@ static int grover_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 		return -1;
 
 	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
 	}
 
 	if (value > 20 && value < 32767)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index e5dca9868f87..c93a8ccd87c7 100644
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
-			return scnprintf(buf, PAGE_SIZE, "%c%c\n",
-					 f34->bootloader_id[0],
-					 f34->bootloader_id[1]);
-		else
-			return scnprintf(buf, PAGE_SIZE, "V%d.%d\n",
-					 f34->bootloader_id[1],
-					 f34->bootloader_id[0]);
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
 
-		return scnprintf(buf, PAGE_SIZE, "%s\n", f34->configuration_id);
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
 
 	if (f34->bl_version == 7) {
 		if (data->pdt_props & HAS_BSR) {
@@ -494,12 +493,20 @@ static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
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
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", update_status);
+	return sysfs_emit(buf, "%d\n", update_status);
 }
 
 static DEVICE_ATTR(update_fw_status, 0444,
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
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a9a3f9c649c7..334303b1d27b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -750,6 +750,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 {
 	iommu_ga_log_notifier = notifier;
 
+	/*
+	 * Ensure all in-flight IRQ handlers run to completion before returning
+	 * to the caller, e.g. to ensure module code isn't unloaded while it's
+	 * being executed in the IRQ handler.
+	 */
+	if (!notifier)
+		synchronize_rcu();
+
 	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index fa09bc4e4c54..a4578b3321de 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -128,10 +128,9 @@ static void queue_bio(struct mirror_set *ms, struct bio *bio, int rw)
 	spin_lock_irqsave(&ms->lock, flags);
 	should_wake = !(bl->head);
 	bio_list_add(bl, bio);
-	spin_unlock_irqrestore(&ms->lock, flags);
-
 	if (should_wake)
 		wakeup_mirrord(ms);
+	spin_unlock_irqrestore(&ms->lock, flags);
 }
 
 static void dispatch_bios(void *context, struct bio_list *bio_list)
@@ -638,9 +637,9 @@ static void write_callback(unsigned long error, void *context)
 	if (!ms->failures.head)
 		should_wake = 1;
 	bio_list_add(&ms->failures, bio);
-	spin_unlock_irqrestore(&ms->lock, flags);
 	if (should_wake)
 		wakeup_mirrord(ms);
+	spin_unlock_irqrestore(&ms->lock, flags);
 }
 
 static void do_write(struct mirror_set *ms, struct bio *bio)
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 748131151c49..83b49e7ae978 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -465,7 +465,7 @@ vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 	return 0;
 }
 
@@ -476,7 +476,7 @@ vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 	return 0;
 }
 
diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 2f4ceaa80593..ab4750ca9241 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -1663,8 +1663,8 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856, struct device *dev)
 	if (!is_acpi_node(fwnode)) {
 		ov8856->xvclk = devm_clk_get(dev, "xvclk");
 		if (IS_ERR(ov8856->xvclk)) {
-			dev_err(dev, "could not get xvclk clock (%pe)\n",
-				ov8856->xvclk);
+			dev_err_probe(dev, PTR_ERR(ov8856->xvclk),
+				      "could not get xvclk clock\n");
 			return PTR_ERR(ov8856->xvclk);
 		}
 
@@ -1758,11 +1758,8 @@ static int ov8856_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ret = ov8856_get_hwcfg(ov8856, &client->dev);
-	if (ret) {
-		dev_err(&client->dev, "failed to get HW configuration: %d",
-			ret);
+	if (ret)
 		return ret;
-	}
 
 	v4l2_i2c_subdev_init(&ov8856->sd, client, &ov8856_subdev_ops);
 
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 8e9df9007d2e..1b3441510b6f 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -309,6 +309,10 @@ static int tc358743_get_detected_timings(struct v4l2_subdev *sd,
 
 	memset(timings, 0, sizeof(struct v4l2_dv_timings));
 
+	/* if HPD is low, ignore any video */
+	if (!(i2c_rd8(sd, HPD_CTL) & MASK_HPD_OUT0))
+		return -ENOLINK;
+
 	if (no_signal(sd)) {
 		v4l2_dbg(1, debug, sd, "%s: no valid signal\n", __func__);
 		return -ENOLINK;
diff --git a/drivers/media/platform/exynos4-is/fimc-is-regs.c b/drivers/media/platform/exynos4-is/fimc-is-regs.c
index 366e6393817d..5f9c44e825a5 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-regs.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-regs.c
@@ -164,6 +164,7 @@ int fimc_is_hw_change_mode(struct fimc_is *is)
 	if (WARN_ON(is->config_index >= ARRAY_SIZE(cmd)))
 		return -EINVAL;
 
+	fimc_is_hw_wait_intmsr0_intmsd0(is);
 	mcuctl_write(cmd[is->config_index], is, MCUCTL_REG_ISSR(0));
 	mcuctl_write(is->sensor_index, is, MCUCTL_REG_ISSR(1));
 	mcuctl_write(is->setfile.sub_index, is, MCUCTL_REG_ISSR(2));
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 987b1d010c04..b8bbd9d71b79 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -290,7 +290,7 @@ static int venus_probe(struct platform_device *pdev)
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		goto err_core_deinit;
+		goto err_hfi_destroy;
 
 	platform_set_drvdata(pdev, core);
 
@@ -322,24 +322,24 @@ static int venus_probe(struct platform_device *pdev)
 
 	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
 	if (ret)
-		goto err_venus_shutdown;
+		goto err_core_deinit;
 
 	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
 	if (ret)
-		goto err_venus_shutdown;
+		goto err_core_deinit;
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret) {
 		pm_runtime_get_noresume(dev);
-		goto err_dev_unregister;
+		goto err_core_deinit;
 	}
 
 	venus_dbgfs_init(core);
 
 	return 0;
 
-err_dev_unregister:
-	v4l2_device_unregister(&core->v4l2_dev);
+err_core_deinit:
+	hfi_core_deinit(core, false);
 err_venus_shutdown:
 	venus_shutdown(core);
 err_firmware_deinit:
@@ -350,9 +350,9 @@ static int venus_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
+	v4l2_device_unregister(&core->v4l2_dev);
+err_hfi_destroy:
 	hfi_destroy(core);
-err_core_deinit:
-	hfi_core_deinit(core, false);
 err_core_put:
 	if (core->pm_ops->core_put)
 		core->pm_ops->core_put(core);
diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
index 7838e6272712..f3023e91b3eb 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -497,7 +497,7 @@ int vidtv_channel_si_init(struct vidtv_mux *m)
 	vidtv_psi_sdt_table_destroy(m->si.sdt);
 free_pat:
 	vidtv_psi_pat_table_destroy(m->si.pat);
-	return 0;
+	return -EINVAL;
 }
 
 void vidtv_channel_si_destroy(struct vidtv_mux *m)
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 9370c684e076..8886b58d1805 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -962,8 +962,8 @@ int vivid_vid_cap_s_selection(struct file *file, void *fh, struct v4l2_selection
 			if (dev->has_compose_cap) {
 				v4l2_rect_set_min_size(compose, &min_rect);
 				v4l2_rect_set_max_size(compose, &max_rect);
-				v4l2_rect_map_inside(compose, &fmt);
 			}
+			v4l2_rect_map_inside(compose, &fmt);
 			dev->fmt_cap_rect = fmt;
 			tpg_s_buf_height(&dev->tpg, fmt.height);
 		} else if (dev->has_compose_cap) {
diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
index 7707de7bae7c..bdfb8afff262 100644
--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -119,9 +119,8 @@ static void cxusb_gpio_tuner(struct dvb_usb_device *d, int onoff)
 
 	o[0] = GPIO_TUNER;
 	o[1] = onoff;
-	cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1);
 
-	if (i != 0x01)
+	if (!cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1) && i != 0x01)
 		dev_info(&d->udev->dev, "gpio_write failed.\n");
 
 	st->gpio_write_state[GPIO_TUNER] = onoff;
diff --git a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
index 5a47dcbf1c8e..303b055fefea 100644
--- a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
+++ b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
@@ -520,12 +520,13 @@ static int hdcs_init(struct sd *sd)
 static int hdcs_dump(struct sd *sd)
 {
 	u16 reg, val;
+	int err = 0;
 
 	pr_info("Dumping sensor registers:\n");
 
-	for (reg = HDCS_IDENT; reg <= HDCS_ROWEXPH; reg++) {
-		stv06xx_read_sensor(sd, reg, &val);
+	for (reg = HDCS_IDENT; reg <= HDCS_ROWEXPH && !err; reg++) {
+		err = stv06xx_read_sensor(sd, reg, &val);
 		pr_info("reg 0x%02x = 0x%02x\n", reg, val);
 	}
-	return 0;
+	return (err < 0) ? err : 0;
 }
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 4c31aa0a941e..0c49a2d19cbc 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1029,25 +1029,25 @@ int __video_register_device(struct video_device *vdev,
 	vdev->dev.class = &video_class;
 	vdev->dev.devt = MKDEV(VIDEO_MAJOR, vdev->minor);
 	vdev->dev.parent = vdev->dev_parent;
+	vdev->dev.release = v4l2_device_release;
 	dev_set_name(&vdev->dev, "%s%d", name_base, vdev->num);
+
+	/* Increase v4l2_device refcount */
+	v4l2_device_get(vdev->v4l2_dev);
+
 	mutex_lock(&videodev_lock);
 	ret = device_register(&vdev->dev);
 	if (ret < 0) {
 		mutex_unlock(&videodev_lock);
 		pr_err("%s: device_register failed\n", __func__);
-		goto cleanup;
+		put_device(&vdev->dev);
+		return ret;
 	}
-	/* Register the release callback that will be called when the last
-	   reference to the device goes away. */
-	vdev->dev.release = v4l2_device_release;
 
 	if (nr != -1 && nr != vdev->num && warn_if_nr_in_use)
 		pr_warn("%s: requested %s%d, got %s\n", __func__,
 			name_base, nr, video_device_node_name(vdev));
 
-	/* Increase v4l2_device refcount */
-	v4l2_device_get(vdev->v4l2_dev);
-
 	/* Part 5: Register the entity. */
 	ret = video_register_media_controller(vdev);
 
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 99bd0e73c19c..ffda3445d1c0 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -144,7 +144,6 @@ static int exynos_lpass_remove(struct platform_device *pdev)
 {
 	struct exynos_lpass *lpass = platform_get_drvdata(pdev);
 
-	exynos_lpass_disable(lpass);
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		exynos_lpass_disable(lpass);
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 7351734f7593..07fa56e5337d 100644
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
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 52eb28f3277c..782190531f2f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -818,6 +818,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
@@ -1045,6 +1046,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 1401fc4632b5..d9d3bf9b9277 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -117,7 +117,6 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
 	}
 #endif
 
-	skb_tx_timestamp(skb);
 	return aq_nic_xmit(aq_nic, skb);
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 54aa84f06e40..8b0531c085be 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -751,6 +751,8 @@ int aq_nic_xmit(struct aq_nic_s *self, struct sk_buff *skb)
 
 	frags = aq_nic_map_skb(self, skb, ring);
 
+	skb_tx_timestamp(skb);
+
 	if (likely(frags)) {
 		err = self->aq_hw_ops->hw_ring_tx_xmit(self->aq_hw,
 						       ring, frags);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 74f3cabf8ed6..2a103be1c9d8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4571,7 +4571,11 @@ static int macb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		if (err) {
+			dev_err(&pdev->dev, "failed to set DMA mask\n");
+			goto err_out_free_netdev;
+		}
 		bp->hw_dma_cap |= HW_DMA_CAP_64B;
 	}
 #endif
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 66e0fbdcef22..b7f992103da3 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -146,6 +146,8 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
+
+	spin_lock_init(&np->stats_lock);
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
 
@@ -869,7 +871,6 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	dev->stats.tx_errors++;
 	/* Ttransmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
@@ -906,9 +907,15 @@ tx_error (struct net_device *dev, int tx_status)
 		rio_set_led_mode(dev);
 		/* Let TxStartThresh stay default value */
 	}
+
+	spin_lock(&np->stats_lock);
 	/* Maximum Collisions */
 	if (tx_status & 0x08)
 		dev->stats.collisions++;
+
+	dev->stats.tx_errors++;
+	spin_unlock(&np->stats_lock);
+
 	/* Restart the Tx */
 	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
 }
@@ -1077,7 +1084,9 @@ get_stats (struct net_device *dev)
 	int i;
 #endif
 	unsigned int stat_reg;
+	unsigned long flags;
 
+	spin_lock_irqsave(&np->stats_lock, flags);
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
@@ -1127,6 +1136,9 @@ get_stats (struct net_device *dev)
 	dr16(TCPCheckSumErrors);
 	dr16(UDPCheckSumErrors);
 	dr16(IPCheckSumErrors);
+
+	spin_unlock_irqrestore(&np->stats_lock, flags);
+
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 0e33e2eaae96..56aff2f0bdbf 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -372,6 +372,8 @@ struct netdev_private {
 	struct pci_dev *pdev;
 	void __iomem *ioaddr;
 	void __iomem *eeprom_addr;
+	// To ensure synchronization when stats are updated.
+	spinlock_t stats_lock;
 	spinlock_t tx_lock;
 	spinlock_t rx_lock;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 9812a9a5d033..d9bceb26f4e5 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -1608,7 +1608,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	/* version 1 of the cmd is not supported only by BE2 */
 	if (BE2_chip(adapter))
 		hdr->version = 0;
-	if (BE3_chip(adapter) || lancer_chip(adapter))
+	else if (BE3_chip(adapter) || lancer_chip(adapter))
 		hdr->version = 1;
 	else
 		hdr->version = 2;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b76d1d019a81..f458a97dd791 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1086,7 +1086,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 			stats[stats_idx++] = (struct stats) {
 				.stat_name = cpu_to_be32(RX_BUFFERS_POSTED),
-				.value = cpu_to_be64(priv->rx[0].fill_cnt),
+				.value = cpu_to_be64(priv->rx[idx].fill_cnt),
 				.queue_id = cpu_to_be32(idx),
 			};
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 59a467f7aba3..430f236be653 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1320,10 +1320,11 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
 void i40e_clear_hw(struct i40e_hw *hw)
 {
 	u32 num_queues, base_queue;
-	u32 num_pf_int;
-	u32 num_vf_int;
+	s32 num_pf_int;
+	s32 num_vf_int;
 	u32 num_vfs;
-	u32 i, j;
+	s32 i;
+	u32 j;
 	u32 val;
 	u32 eol = 0x7ff;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4f23243bbfbb..852ece241a27 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1495,8 +1495,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
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
@@ -1515,7 +1515,7 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 
 	/* If VF is being reset already we don't need to continue. */
 	if (test_and_set_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-		return true;
+		return false;
 
 	i40e_trigger_vf_reset(vf, flr);
 
@@ -4170,7 +4170,10 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 085b1a0d67c5..bb27474805c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -376,6 +376,50 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
 	return false;
 }
 
+/**
+ * ice_arfs_cmp - Check if aRFS filter matches this flow.
+ * @fltr_info: filter info of the saved ARFS entry.
+ * @fk: flow dissector keys.
+ * @n_proto:  One of htons(ETH_P_IP) or htons(ETH_P_IPV6).
+ * @ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.
+ *
+ * Since this function assumes limited values for n_proto and ip_proto, it
+ * is meant to be called only from ice_rx_flow_steer().
+ *
+ * Return:
+ * * true	- fltr_info refers to the same flow as fk.
+ * * false	- fltr_info and fk refer to different flows.
+ */
+static bool
+ice_arfs_cmp(const struct ice_fdir_fltr *fltr_info, const struct flow_keys *fk,
+	     __be16 n_proto, u8 ip_proto)
+{
+	/* Determine if the filter is for IPv4 or IPv6 based on flow_type,
+	 * which is one of ICE_FLTR_PTYPE_NONF_IPV{4,6}_{TCP,UDP}.
+	 */
+	bool is_v4 = fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
+		     fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP;
+
+	/* Following checks are arranged in the quickest and most discriminative
+	 * fields first for early failure.
+	 */
+	if (is_v4)
+		return n_proto == htons(ETH_P_IP) &&
+			fltr_info->ip.v4.src_port == fk->ports.src &&
+			fltr_info->ip.v4.dst_port == fk->ports.dst &&
+			fltr_info->ip.v4.src_ip == fk->addrs.v4addrs.src &&
+			fltr_info->ip.v4.dst_ip == fk->addrs.v4addrs.dst &&
+			fltr_info->ip.v4.proto == ip_proto;
+
+	return fltr_info->ip.v6.src_port == fk->ports.src &&
+		fltr_info->ip.v6.dst_port == fk->ports.dst &&
+		fltr_info->ip.v6.proto == ip_proto &&
+		!memcmp(&fltr_info->ip.v6.src_ip, &fk->addrs.v6addrs.src,
+			sizeof(struct in6_addr)) &&
+		!memcmp(&fltr_info->ip.v6.dst_ip, &fk->addrs.v6addrs.dst,
+			sizeof(struct in6_addr));
+}
+
 /**
  * ice_rx_flow_steer - steer the Rx flow to where application is being run
  * @netdev: ptr to the netdev being adjusted
@@ -447,6 +491,10 @@ ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
 			continue;
 
 		fltr_info = &arfs_entry->fltr_info;
+
+		if (!ice_arfs_cmp(fltr_info, &fk, n_proto, ip_proto))
+			continue;
+
 		ret = fltr_info->fltr_id;
 
 		if (fltr_info->q_index == rxq_idx ||
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index f5bfb662f1df..504a5913caf0 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1396,16 +1396,16 @@ ice_sched_get_vsi_node(struct ice_hw *hw, struct ice_sched_node *tc_node,
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
@@ -1646,8 +1646,9 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 	if (status)
 		return status;
 
-	if (new_numqs)
-		ice_sched_calc_vsi_child_nodes(hw, new_numqs, new_num_nodes);
+	ice_sched_calc_vsi_child_nodes(hw, new_numqs - prev_numqs,
+				       new_num_nodes);
+
 	/* Keep the max number of queue configuration all the time. Update the
 	 * tree only if number of queues > previous number of queues. This may
 	 * leave some extra nodes in the tree if number of queues < previous
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 96d2891f1675..9d884699ed9c 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1409,6 +1409,8 @@ static __maybe_unused int mtk_star_suspend(struct device *dev)
 	if (netif_running(ndev))
 		mtk_star_disable(ndev);
 
+	netif_device_detach(ndev);
+
 	clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 
 	return 0;
@@ -1433,6 +1435,8 @@ static __maybe_unused int mtk_star_resume(struct device *dev)
 			clk_bulk_disable_unprepare(MTK_STAR_NCLKS, priv->clks);
 	}
 
+	netif_device_attach(ndev);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 024788549c25..060698b0c65c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -251,7 +251,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
-	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 max_val_cycles = freq_khz * 1000ULL * MLX4_EN_WRAP_AROUND_SEC;
 	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 962851000ace..7cb4dde12b92 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1905,6 +1905,7 @@ static int mlx4_en_get_ts_info(struct net_device *dev,
 	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS) {
 		info->so_timestamping |=
 			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index c1a33f05702e..4b237a0fee34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1869,6 +1869,7 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 	struct mlx5_flow_handle *rule;
 	struct match_list *iter;
 	bool take_write = false;
+	bool try_again = false;
 	struct fs_fte *fte;
 	u64  version = 0;
 	int err;
@@ -1928,6 +1929,7 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 		nested_down_write_ref_node(&g->node, FS_LOCK_PARENT);
 
 		if (!g->node.active) {
+			try_again = true;
 			up_write_ref_node(&g->node, false);
 			continue;
 		}
@@ -1949,7 +1951,8 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
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
index 1ea71f06fdb1..b7ccdef697fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -272,7 +272,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
 static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
 {
 	struct device *device = mlx5_core_dma_dev(dev);
-	int nid = dev_to_node(device);
+	int nid = dev->priv.numa_node;
 	struct page *page;
 	u64 zero_addr = 1;
 	u64 addr;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index e77cf11356c0..78702b0a1b42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -440,19 +440,22 @@ int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int err;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
 
 	*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
 				nic_vport_context.node_guid);
-
+out:
 	kvfree(out);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_node_guid);
 
@@ -494,19 +497,22 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int err;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
 
 	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
 				   nic_vport_context.qkey_violation_counter);
-
+out:
 	kvfree(out);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a0f490a90757..26a230c60efb 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -918,7 +918,7 @@ static int lan743x_mac_set_mtu(struct lan743x_adapter *adapter, int new_mtu)
 }
 
 /* PHY */
-static int lan743x_phy_reset(struct lan743x_adapter *adapter)
+static int lan743x_hw_reset_phy(struct lan743x_adapter *adapter)
 {
 	u32 data;
 
@@ -952,7 +952,7 @@ static void lan743x_phy_update_flowcontrol(struct lan743x_adapter *adapter,
 
 static int lan743x_phy_init(struct lan743x_adapter *adapter)
 {
-	return lan743x_phy_reset(adapter);
+	return lan743x_hw_reset_phy(adapter);
 }
 
 static void lan743x_phy_link_status_change(struct net_device *netdev)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index f02ce09020fb..7ebbb81375e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -400,6 +400,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
+	static int bus_id = -ENODEV;
 	int phy_mode;
 	int rc;
 
@@ -435,8 +436,14 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
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
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5e30fd017b3a..e6a013da6680 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -260,15 +260,39 @@ static sci_t make_sci(u8 *addr, __be16 port)
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
@@ -1096,7 +1120,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
 	unsigned int len;
-	sci_t sci;
+	sci_t sci = 0;
 	u32 hdr_pn;
 	bool cbit;
 	struct pcpu_rx_sc_stats *rxsc_stats;
@@ -1143,11 +1167,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
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
 
@@ -1270,6 +1297,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsa_put(rx_sa);
 drop_nosa:
 	macsec_rxsc_put(rx_sc);
+drop_nosc:
 	rcu_read_unlock();
 drop_direct:
 	kfree_skb(skb);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index e9303be48655..d15deb3281ed 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -754,7 +754,13 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
 
 	WARN_ON_ONCE(!mutex_is_locked(&bus->mdio_lock));
 
-	retval = bus->read(bus, addr, regnum);
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
+	if (bus->read)
+		retval = bus->read(bus, addr, regnum);
+	else
+		retval = -EOPNOTSUPP;
 
 	trace_mdio_access(bus, 1, addr, regnum, retval, retval);
 	mdiobus_stats_acct(&bus->stats[addr], true, retval);
@@ -780,7 +786,13 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
 
 	WARN_ON_ONCE(!mutex_is_locked(&bus->mdio_lock));
 
-	err = bus->write(bus, addr, regnum, val);
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
+	if (bus->write)
+		err = bus->write(bus, addr, regnum, val);
+	else
+		err = -EOPNOTSUPP;
 
 	trace_mdio_access(bus, 0, addr, regnum, val, err);
 	mdiobus_stats_acct(&bus->stats[addr], false, err);
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index b97ee79f3cdf..85102e895665 100644
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
 
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 895d4f5166f9..485959771431 100644
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
 
diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index f69d9b902da0..a206ffa76f1b 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -178,6 +178,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 {
 	struct usbnet *dev = netdev_priv(netdev);
 	unsigned char buff[2];
+	int ret;
 
 	netdev_dbg(netdev, "%s phy_id:%02x loc:%02x\n",
 		   __func__, phy_id, loc);
@@ -185,8 +186,10 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (phy_id != 0)
 		return -ENODEV;
 
-	control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
-		     CONTROL_TIMEOUT_MS);
+	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
+			   CONTROL_TIMEOUT_MS);
+	if (ret < 0)
+		return ret;
 
 	return (buff[0] | buff[1] << 8);
 }
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3b889fed9882..50a7a1abb90a 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1355,6 +1355,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
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
@@ -1591,6 +1615,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			if (segCnt != 0 && mss != 0) {
 				skb_shinfo(skb)->gso_type = rcd->v4 ?
 					SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+				if (encap_lro)
+					vmxnet3_lro_tunnel(skb, skb->protocol);
 				skb_shinfo(skb)->gso_size = mss;
 				skb_shinfo(skb)->gso_segs = segCnt;
 			} else if ((segCnt != 0 || skb->len > mtu) && !encap_lro) {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 7d7aa7d76880..7973d4070ee3 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -712,10 +712,10 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	if (rd == NULL)
 		return -ENOMEM;
 
-	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
-		kfree(rd);
-		return -ENOMEM;
-	}
+	/* The driver can work correctly without a dst cache, so do not treat
+	 * dst cache initialization errors as fatal.
+	 */
+	dst_cache_init(&rd->dst_cache, GFP_ATOMIC | __GFP_NOWARN);
 
 	rd->remote_ip = *ip;
 	rd->remote_port = port;
diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 05a61975c83f..869524852fba 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -626,7 +626,7 @@ static int ath10k_ahb_hif_start(struct ath10k *ar)
 {
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot ahb hif start\n");
 
-	napi_enable(&ar->napi);
+	ath10k_core_napi_enable(ar);
 	ath10k_ce_enable_interrupts(ar);
 	ath10k_pci_enable_legacy_irq(ar);
 
@@ -644,8 +644,7 @@ static void ath10k_ahb_hif_stop(struct ath10k *ar)
 	ath10k_ahb_irq_disable(ar);
 	synchronize_irq(ar_ahb->irq);
 
-	napi_synchronize(&ar->napi);
-	napi_disable(&ar->napi);
+	ath10k_core_napi_sync_disable(ar);
 
 	ath10k_pci_flush(ar);
 }
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index d03a36c45f9f..a2a52c627672 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2292,6 +2292,42 @@ static int ath10k_init_hw_params(struct ath10k *ar)
 	return 0;
 }
 
+void ath10k_core_start_recovery(struct ath10k *ar)
+{
+	if (test_and_set_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags)) {
+		ath10k_warn(ar, "already restarting\n");
+		return;
+	}
+
+	queue_work(ar->workqueue, &ar->restart_work);
+}
+EXPORT_SYMBOL(ath10k_core_start_recovery);
+
+void ath10k_core_napi_enable(struct ath10k *ar)
+{
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (test_bit(ATH10K_FLAG_NAPI_ENABLED, &ar->dev_flags))
+		return;
+
+	napi_enable(&ar->napi);
+	set_bit(ATH10K_FLAG_NAPI_ENABLED, &ar->dev_flags);
+}
+EXPORT_SYMBOL(ath10k_core_napi_enable);
+
+void ath10k_core_napi_sync_disable(struct ath10k *ar)
+{
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (!test_bit(ATH10K_FLAG_NAPI_ENABLED, &ar->dev_flags))
+		return;
+
+	napi_synchronize(&ar->napi);
+	napi_disable(&ar->napi);
+	clear_bit(ATH10K_FLAG_NAPI_ENABLED, &ar->dev_flags);
+}
+EXPORT_SYMBOL(ath10k_core_napi_sync_disable);
+
 static void ath10k_core_restart(struct work_struct *work)
 {
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index b50ab9e229dc..30c01f18b3d2 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -857,6 +857,12 @@ enum ath10k_dev_flags {
 
 	/* Per Station statistics service */
 	ATH10K_FLAG_PEER_STATS,
+
+	/* Indicates that ath10k device is during recovery process and not complete */
+	ATH10K_FLAG_RESTARTING,
+
+	/* protected by conf_mutex */
+	ATH10K_FLAG_NAPI_ENABLED,
 };
 
 enum ath10k_cal_mode {
@@ -1297,6 +1303,8 @@ static inline bool ath10k_peer_stats_enabled(struct ath10k *ar)
 
 extern unsigned long ath10k_coredump_mask;
 
+void ath10k_core_napi_sync_disable(struct ath10k *ar);
+void ath10k_core_napi_enable(struct ath10k *ar);
 struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 				  enum ath10k_bus bus,
 				  enum ath10k_hw_rev hw_rev,
@@ -1312,6 +1320,7 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		      const struct ath10k_fw_components *fw_components);
 int ath10k_wait_for_suspend(struct ath10k *ar, u32 suspend_opt);
 void ath10k_core_stop(struct ath10k *ar);
+void ath10k_core_start_recovery(struct ath10k *ar);
 int ath10k_core_register(struct ath10k *ar,
 			 const struct ath10k_bus_params *bus_params);
 void ath10k_core_unregister(struct ath10k *ar);
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index ab737177a86b..64d48d8cce50 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -583,7 +583,7 @@ static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
 		ret = ath10k_debug_fw_assert(ar);
 	} else if (!strcmp(buf, "hw-restart")) {
 		ath10k_info(ar, "user requested hw restart\n");
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 		ret = 0;
 	} else {
 		ret = -EINVAL;
@@ -2005,7 +2005,7 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 		}
 	} else {
 		ath10k_info(ar, "restarting firmware due to btcoex change");
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 	}
 
 	if (val)
@@ -2136,7 +2136,7 @@ static ssize_t ath10k_write_peer_stats(struct file *file,
 
 	ath10k_info(ar, "restarting firmware due to Peer stats change");
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 	ret = count;
 
 exit:
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 323b6763cb0f..5dd0239e9d51 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7969,6 +7969,7 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 		ath10k_info(ar, "device successfully recovered\n");
 		ar->state = ATH10K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
+		clear_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags);
 	}
 
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 2c8f04b415c7..24ae59c57206 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1774,7 +1774,7 @@ static void ath10k_pci_fw_dump_work(struct work_struct *work)
 
 	mutex_unlock(&ar->dump_mutex);
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 }
 
 static void ath10k_pci_fw_crashed_dump(struct ath10k *ar)
@@ -1958,7 +1958,7 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif start\n");
 
-	napi_enable(&ar->napi);
+	ath10k_core_napi_enable(ar);
 
 	ath10k_pci_irq_enable(ar);
 	ath10k_pci_rx_post(ar);
@@ -2076,8 +2076,9 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
 
 	ath10k_pci_irq_disable(ar);
 	ath10k_pci_irq_sync(ar);
-	napi_synchronize(&ar->napi);
-	napi_disable(&ar->napi);
+
+	ath10k_core_napi_sync_disable(ar);
+
 	cancel_work_sync(&ar_pci->dump_work);
 
 	/* Most likely the device has HTT Rx ring configured. The only way to
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 418e40560f59..7cb1bc8d6e01 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -562,7 +562,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 				    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
 			ret = -ENOMEM;
 
-			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_core_start_recovery(ar);
 			ath10k_warn(ar, "exceeds length, start recovery\n");
 
 			goto err;
@@ -961,7 +961,7 @@ static int ath10k_sdio_mbox_read_int_status(struct ath10k *ar,
 	ret = ath10k_sdio_read(ar, MBOX_HOST_INT_STATUS_ADDRESS,
 			       irq_proc_reg, sizeof(*irq_proc_reg));
 	if (ret) {
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 		ath10k_warn(ar, "read int status fail, start recovery\n");
 		goto out;
 	}
@@ -1863,7 +1863,7 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 	int ret;
 
-	napi_enable(&ar->napi);
+	ath10k_core_napi_enable(ar);
 
 	/* Sleep 20 ms before HIF interrupts are disabled.
 	 * This will give target plenty of time to process the BMI done
@@ -1990,8 +1990,7 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
 
 	spin_unlock_bh(&ar_sdio->wr_async_lock);
 
-	napi_synchronize(&ar->napi);
-	napi_disable(&ar->napi);
+	ath10k_core_napi_sync_disable(ar);
 }
 
 #ifdef CONFIG_PM
@@ -2505,7 +2504,7 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
 
 	ath10k_sdio_enable_intrs(ar);
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 }
 
 static int ath10k_sdio_probe(struct sdio_func *func,
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index f7ee1032b172..616fcaed061f 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -923,8 +923,7 @@ static void ath10k_snoc_hif_stop(struct ath10k *ar)
 	if (!test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
 		ath10k_snoc_irq_disable(ar);
 
-	napi_synchronize(&ar->napi);
-	napi_disable(&ar->napi);
+	ath10k_core_napi_sync_disable(ar);
 	ath10k_snoc_buffer_cleanup(ar);
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif stop\n");
 }
@@ -934,8 +933,11 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
-	napi_enable(&ar->napi);
-	ath10k_snoc_irq_enable(ar);
+
+	ath10k_core_napi_enable(ar);
+	/* IRQs are left enabled when we restart due to a firmware crash */
+	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
+		ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
 
 	clear_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags);
@@ -1315,7 +1317,7 @@ int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type)
 	switch (type) {
 	case ATH10K_QMI_EVENT_FW_READY_IND:
 		if (test_bit(ATH10K_SNOC_FLAG_REGISTERED, &ar_snoc->flags)) {
-			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_core_start_recovery(ar);
 			break;
 		}
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index dc5d9f9be34f..c9a74f3e2e60 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1957,7 +1957,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	if (ret == -EAGAIN) {
 		ath10k_warn(ar, "wmi command %d timeout, restarting hardware\n",
 			    cmd_id);
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 473d92240a82..6282ccad79d5 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -736,6 +736,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 void ath11k_core_halt(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
+	struct list_head *pos, *n;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -749,7 +750,12 @@ void ath11k_core_halt(struct ath11k *ar)
 
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
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index c745897aa3d6..259a36b4c7cb 100644
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
diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index a5265997b576..debac4699687 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -438,14 +438,21 @@ static void carl9170_usb_rx_complete(struct urb *urb)
 
 		if (atomic_read(&ar->rx_anch_urbs) == 0) {
 			/*
-			 * The system is too slow to cope with
-			 * the enormous workload. We have simply
-			 * run out of active rx urbs and this
-			 * unfortunately leads to an unpredictable
-			 * device.
+			 * At this point, either the system is too slow to
+			 * cope with the enormous workload (so we have simply
+			 * run out of active rx urbs and this unfortunately
+			 * leads to an unpredictable device), or the device
+			 * is not fully functional after an unsuccessful
+			 * firmware loading attempts (so it doesn't pass
+			 * ieee80211_register_hw() and there is no internal
+			 * workqueue at all).
 			 */
 
-			ieee80211_queue_work(ar->hw, &ar->ping_work);
+			if (ar->registered)
+				ieee80211_queue_work(ar->hw, &ar->ping_work);
+			else
+				pr_warn_once("device %s is not registered\n",
+					     dev_name(&ar->udev->dev));
 		}
 	} else {
 		/*
diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index bece14e4ff0d..459c35912d76 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -233,6 +233,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 
 	mutex_lock(&priv->eeprom_mutex);
 	priv->eeprom = buf;
+	priv->eeprom_slice_size = len;
 	eeprom_hdr = skb_put(skb, eeprom_hdr_size + len);
 
 	if (priv->fw_var < 0x509) {
@@ -255,6 +256,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 		ret = -EBUSY;
 	}
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	mutex_unlock(&priv->eeprom_mutex);
 	return ret;
 }
diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
index 3356ea708d81..97fc863fef81 100644
--- a/drivers/net/wireless/intersil/p54/p54.h
+++ b/drivers/net/wireless/intersil/p54/p54.h
@@ -258,6 +258,7 @@ struct p54_common {
 
 	/* eeprom handling */
 	void *eeprom;
+	size_t eeprom_slice_size;
 	struct completion eeprom_comp;
 	struct mutex eeprom_mutex;
 };
diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 873fea59894f..6333b1000f92 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -500,14 +500,19 @@ static void p54_rx_eeprom_readback(struct p54_common *priv,
 		return ;
 
 	if (priv->fw_var >= 0x509) {
-		memcpy(priv->eeprom, eeprom->v2.data,
-		       le16_to_cpu(eeprom->v2.len));
+		if (le16_to_cpu(eeprom->v2.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v2.data, priv->eeprom_slice_size);
 	} else {
-		memcpy(priv->eeprom, eeprom->v1.data,
-		       le16_to_cpu(eeprom->v1.len));
+		if (le16_to_cpu(eeprom->v1.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v1.data, priv->eeprom_slice_size);
 	}
 
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	tmp = p54_find_and_unlink_skb(priv, hdr->req_id);
 	dev_kfree_skb_any(tmp);
 	complete(&priv->eeprom_comp);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 82a193aac09d..95c548f45bdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
+	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
+	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
 	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index ffc2deba29ac..c845e8389765 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_usb *usb = &dev->mt76.usb;
+	bool vht;
 	int err;
 
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
@@ -215,7 +216,17 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
-	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
+	switch (dev->mt76.rev) {
+	case 0x76320044:
+		/* these ASIC revisions do not support VHT */
+		vht = false;
+		break;
+	default:
+		vht = true;
+		break;
+	}
+
+	err = mt76_register_device(&dev->mt76, vht, mt76x02_rates,
 				   ARRAY_SIZE(mt76x02_rates));
 	if (err)
 		goto fail;
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 925e4f807eb9..f024533d34a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -155,6 +155,16 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8192SE &&
 	    init_aspm == 0x43)
 		ppsc->support_aspm = false;
+
+	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
+	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	 * amounts of PCIe AER errors during and after boot up, causing
+	 * heavy lags, poor network throughput, and occasional lock-ups.
+	 */
+	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
+	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
+	     rtlpci->pdev->subsystem_device == 0x1723))
+		ppsc->support_aspm = false;
 }
 
 static bool _rtl_pci_platform_switch_device_pci_aspm(
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index abed17e4c8c7..a7fc2287521f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3157,7 +3157,8 @@ static void rtw8822c_dpk_cal_coef1(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, REG_NCTL0, 0x00001148);
 	rtw_write32(rtwdev, REG_NCTL0, 0x00001149);
 
-	check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55);
+	if (!check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55))
+		rtw_warn(rtwdev, "DPK stuck, performance may be suboptimal");
 
 	rtw_write8(rtwdev, 0x1b10, 0x0);
 	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SUBPAGE, 0x0000000c);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 4d8d15ac51ef..c29176bdecd1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -548,14 +548,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 24916e78c507..31bcda363cbb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5356,7 +5356,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index ab83f78f3eb1..cabbaacdb6e6 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -263,7 +263,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 void dpc_process_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
-	struct aer_err_info info;
+	struct aer_err_info info = {};
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6564df6c9d0c..7d9f048ed18f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4828,6 +4828,18 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
+static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Loongson PCIe Root Ports don't advertise an ACS capability, but
+	 * they do not allow peer-to-peer transactions between Root Ports.
+	 * Allow each Root Port to be in a separate IOMMU group by masking
+	 * SV/RR/CR/UF bits.
+	 */
+	return pci_acs_ctrl_enabled(acs_flags,
+		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+}
+
 /*
  * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
  * multi-function devices, the hardware isolates the functions by
@@ -4961,6 +4973,17 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
+	/* Loongson PCIe Root Ports */
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C19, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x3C29, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A09, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A19, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A29, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A39, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A49, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A59, pci_quirk_loongson_acs },
+	{ PCI_VENDOR_ID_LOONGSON, 0x7A69, pci_quirk_loongson_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	/* Zhaoxin multi-function devices */
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 85a0052bb0e6..ee4457832ccd 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -354,9 +354,7 @@ static int armada_37xx_pmx_set_by_name(struct pinctrl_dev *pctldev,
 
 	val = grp->val[func];
 
-	regmap_update_bits(info->regmap, reg, mask, val);
-
-	return 0;
+	return regmap_update_bits(info->regmap, reg, mask, val);
 }
 
 static int armada_37xx_pmx_set(struct pinctrl_dev *pctldev,
@@ -398,10 +396,13 @@ static int armada_37xx_gpio_get_direction(struct gpio_chip *chip,
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = OUTPUT_EN;
 	unsigned int val, mask;
+	int ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
-	regmap_read(info->regmap, reg, &val);
+	ret = regmap_read(info->regmap, reg, &val);
+	if (ret)
+		return ret;
 
 	if (val & mask)
 		return GPIO_LINE_DIRECTION_OUT;
@@ -413,20 +414,22 @@ static int armada_37xx_gpio_direction_output(struct gpio_chip *chip,
 					     unsigned int offset, int value)
 {
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
-	unsigned int reg = OUTPUT_EN;
+	unsigned int en_offset = offset;
+	unsigned int reg = OUTPUT_VAL;
 	unsigned int mask, val, ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
+	val = value ? mask : 0;
 
-	ret = regmap_update_bits(info->regmap, reg, mask, mask);
-
+	ret = regmap_update_bits(info->regmap, reg, mask, val);
 	if (ret)
 		return ret;
 
-	reg = OUTPUT_VAL;
-	val = value ? mask : 0;
-	regmap_update_bits(info->regmap, reg, mask, val);
+	reg = OUTPUT_EN;
+	armada_37xx_update_reg(&reg, &en_offset);
+
+	regmap_update_bits(info->regmap, reg, mask, mask);
 
 	return 0;
 }
@@ -436,11 +439,14 @@ static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = INPUT_VAL;
 	unsigned int val, mask;
+	int ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
 
-	regmap_read(info->regmap, reg, &val);
+	ret = regmap_read(info->regmap, reg, &val);
+	if (ret)
+		return ret;
 
 	return (val & mask) != 0;
 }
@@ -465,16 +471,17 @@ static int armada_37xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 {
 	struct armada_37xx_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct gpio_chip *chip = range->gc;
+	int ret;
 
 	dev_dbg(info->dev, "gpio_direction for pin %u as %s-%d to %s\n",
 		offset, range->name, offset, input ? "input" : "output");
 
 	if (input)
-		armada_37xx_gpio_direction_input(chip, offset);
+		ret = armada_37xx_gpio_direction_input(chip, offset);
 	else
-		armada_37xx_gpio_direction_output(chip, offset, 0);
+		ret = armada_37xx_gpio_direction_output(chip, offset, 0);
 
-	return 0;
+	return ret;
 }
 
 static int armada_37xx_gpio_request_enable(struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index bb9348f14b1b..3b299f4e2c93 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1820,12 +1820,16 @@ static int at91_gpio_probe(struct platform_device *pdev)
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
 	if (gpio_chips[alias_idx]) {
 		ret = -EBUSY;
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 971426bb4302..18fc6a08569e 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -13,3 +13,5 @@ source "drivers/platform/chrome/Kconfig"
 source "drivers/platform/mellanox/Kconfig"
 
 source "drivers/platform/olpc/Kconfig"
+
+source "drivers/platform/surface/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 6fda58c021ca..4de08ef4ec9d 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)		+= mips/
 obj-$(CONFIG_OLPC_EC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
+obj-$(CONFIG_SURFACE_PLATFORMS)	+= surface/
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
new file mode 100644
index 000000000000..b67926ece95f
--- /dev/null
+++ b/drivers/platform/surface/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microsoft Surface Platform-Specific Drivers
+#
+
+menuconfig SURFACE_PLATFORMS
+	bool "Microsoft Surface Platform-Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for platform-specific device drivers
+	  for Microsoft Surface devices. This option alone does not add any
+	  kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
new file mode 100644
index 000000000000..3700f9e84299
--- /dev/null
+++ b/drivers/platform/surface/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/surface
+# Microsoft Surface Platform-Specific Drivers
+#
diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
index 03c3ff34bcf5..68a860a97f31 100644
--- a/drivers/platform/x86/dell_rbu.c
+++ b/drivers/platform/x86/dell_rbu.c
@@ -292,7 +292,7 @@ static int packet_read_list(char *data, size_t * pread_length)
 	remaining_bytes = *pread_length;
 	bytes_read = rbu_data.packet_read_count;
 
-	list_for_each_entry(newpacket, (&packet_data_head.list)->next, list) {
+	list_for_each_entry(newpacket, &packet_data_head.list, list) {
 		bytes_copied = do_packet_read(pdest, newpacket,
 			remaining_bytes, bytes_read, &temp_count);
 		remaining_bytes -= bytes_copied;
@@ -315,14 +315,14 @@ static void packet_empty_list(void)
 {
 	struct packet_data *newpacket, *tmp;
 
-	list_for_each_entry_safe(newpacket, tmp, (&packet_data_head.list)->next, list) {
+	list_for_each_entry_safe(newpacket, tmp, &packet_data_head.list, list) {
 		list_del(&newpacket->list);
 
 		/*
 		 * zero out the RBU packet memory before freeing
 		 * to make sure there are no stale RBU packets left in memory
 		 */
-		memset(newpacket->data, 0, rbu_data.packetsize);
+		memset(newpacket->data, 0, newpacket->length);
 		set_memory_wb((unsigned long)newpacket->data,
 			1 << newpacket->ordernum);
 		free_pages((unsigned long) newpacket->data,
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3ff9d93a5226..6659001291f4 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -81,12 +81,11 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
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
@@ -97,7 +96,7 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
 		  "r" (reset->args),
 		  "r" (reset->ramc_lpr)
-		: "r4");
+	);
 
 	return NOTIFY_DONE;
 }
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index be2aac8fbf43..b8131f823654 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2000,7 +2000,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 6fbae8fc2e50..d0c8edadec4b 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -32,6 +33,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -48,7 +50,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && ++retry < 3) {
+			/* sleep 10 milliseconds when busy */
+			usleep_range(10000, 11000);
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index db4c265287ae..b35ef7e9381e 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -787,6 +787,9 @@ static int riocm_ch_send(u16 ch_id, void *buf, int len)
 	if (buf == NULL || ch_id == 0 || len == 0 || len > RIO_MAX_MSG_SIZE)
 		return -EINVAL;
 
+	if (len < sizeof(struct rio_ch_chan_hdr))
+		return -EINVAL;		/* insufficient data from user */
+
 	ch = riocm_get_channel(ch_id);
 	if (!ch) {
 		riocm_error("%s(%d) ch_%d not found", current->comm,
diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index e34face736f4..091a55819fc1 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -40,11 +40,14 @@ static int max14577_reg_get_current_limit(struct regulator_dev *rdev)
 	struct max14577 *max14577 = rdev_get_drvdata(rdev);
 	const struct maxim_charger_current *limits =
 		&maxim_charger_currents[max14577->dev_type];
+	int ret;
 
 	if (rdev_get_id(rdev) != MAX14577_CHARGER)
 		return -EINVAL;
 
-	max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	if (ret < 0)
+		return ret;
 
 	if ((reg_data & CHGCTRL4_MBCICHWRCL_MASK) == 0)
 		return limits->min;
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index b5167ef93abf..6facf1b31d46 100644
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
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ddd334e049e..6a4aa5abe366 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -10,6 +10,16 @@ config RTC_MC146818_LIB
 	bool
 	select RTC_LIB
 
+config RTC_LIB_KUNIT_TEST
+	tristate "KUnit test for RTC lib functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select RTC_LIB
+	help
+	  Enable this option to test RTC library functions.
+
+	  If unsure, say N.
+
 menuconfig RTC_CLASS
 	bool "Real Time Clock"
 	default n
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index bfb57464118d..03ab2329a0e2 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -183,3 +183,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= lib_test.o
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 625effe6cb65..b1ce3bd724b2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -314,7 +314,7 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
 	 *
 	 * Otherwise the offset seconds should be 0.
 	 */
-	if (rtc->start_secs > rtc->range_max ||
+	if ((rtc->start_secs >= 0 && rtc->start_secs > rtc->range_max) ||
 	    rtc->start_secs + range_secs - 1 < rtc->range_min)
 		rtc->offset_secs = rtc->start_secs - rtc->range_min;
 	else if (rtc->start_secs > rtc->range_min)
diff --git a/drivers/rtc/lib.c b/drivers/rtc/lib.c
index 23284580df97..13b5b1f20465 100644
--- a/drivers/rtc/lib.c
+++ b/drivers/rtc/lib.c
@@ -6,6 +6,8 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * based on arch/arm/common/rtctime.c and other bits
+ *
+ * Author: Cassio Neri <cassio.neri@gmail.com> (rtc_time64_to_tm)
  */
 
 #include <linux/export.h>
@@ -22,8 +24,6 @@ static const unsigned short rtc_ydays[2][13] = {
 	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
 };
 
-#define LEAPS_THRU_END_OF(y) ((y) / 4 - (y) / 100 + (y) / 400)
-
 /*
  * The number of days in the month.
  */
@@ -42,42 +42,109 @@ int rtc_year_days(unsigned int day, unsigned int month, unsigned int year)
 }
 EXPORT_SYMBOL(rtc_year_days);
 
-/*
- * rtc_time64_to_tm - Converts time64_t to rtc_time.
- * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
+/**
+ * rtc_time64_to_tm - converts time64_t to rtc_time.
+ *
+ * @time:	The number of seconds since 01-01-1970 00:00:00.
+ *		Works for values since at least 1900
+ * @tm:		Pointer to the struct rtc_time.
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
-	unsigned int month, year, secs;
-	int days;
+	int days, secs;
 
-	/* time must be positive */
-	days = div_s64_rem(time, 86400, &secs);
+	u64 u64tmp;
+	u32 u32tmp, udays, century, day_of_century, year_of_century, year,
+		day_of_year, month, day;
+	bool is_Jan_or_Feb, is_leap_year;
 
-	/* day of the week, 1970-01-01 was a Thursday */
-	tm->tm_wday = (days + 4) % 7;
+	/*
+	 * Get days and seconds while preserving the sign to
+	 * handle negative time values (dates before 1970-01-01)
+	 */
+	days = div_s64_rem(time, 86400, &secs);
 
-	year = 1970 + days / 365;
-	days -= (year - 1970) * 365
-		+ LEAPS_THRU_END_OF(year - 1)
-		- LEAPS_THRU_END_OF(1970 - 1);
-	while (days < 0) {
-		year -= 1;
-		days += 365 + is_leap_year(year);
+	/*
+	 * We need 0 <= secs < 86400 which isn't given for negative
+	 * values of time. Fixup accordingly.
+	 */
+	if (secs < 0) {
+		days -= 1;
+		secs += 86400;
 	}
-	tm->tm_year = year - 1900;
-	tm->tm_yday = days + 1;
-
-	for (month = 0; month < 11; month++) {
-		int newdays;
 
-		newdays = days - rtc_month_days(month, year);
-		if (newdays < 0)
-			break;
-		days = newdays;
-	}
-	tm->tm_mon = month;
-	tm->tm_mday = days + 1;
+	/* day of the week, 1970-01-01 was a Thursday */
+	tm->tm_wday = (days + 4) % 7;
+	/* Ensure tm_wday is always positive */
+	if (tm->tm_wday < 0)
+		tm->tm_wday += 7;
+
+	/*
+	 * The following algorithm is, basically, Proposition 6.3 of Neri
+	 * and Schneider [1]. In a few words: it works on the computational
+	 * (fictitious) calendar where the year starts in March, month = 2
+	 * (*), and finishes in February, month = 13. This calendar is
+	 * mathematically convenient because the day of the year does not
+	 * depend on whether the year is leap or not. For instance:
+	 *
+	 * March 1st		0-th day of the year;
+	 * ...
+	 * April 1st		31-st day of the year;
+	 * ...
+	 * January 1st		306-th day of the year; (Important!)
+	 * ...
+	 * February 28th	364-th day of the year;
+	 * February 29th	365-th day of the year (if it exists).
+	 *
+	 * After having worked out the date in the computational calendar
+	 * (using just arithmetics) it's easy to convert it to the
+	 * corresponding date in the Gregorian calendar.
+	 *
+	 * [1] "Euclidean Affine Functions and Applications to Calendar
+	 * Algorithms". https://arxiv.org/abs/2102.06959
+	 *
+	 * (*) The numbering of months follows rtc_time more closely and
+	 * thus, is slightly different from [1].
+	 */
+
+	udays		= days + 719468;
+
+	u32tmp		= 4 * udays + 3;
+	century		= u32tmp / 146097;
+	day_of_century	= u32tmp % 146097 / 4;
+
+	u32tmp		= 4 * day_of_century + 3;
+	u64tmp		= 2939745ULL * u32tmp;
+	year_of_century	= upper_32_bits(u64tmp);
+	day_of_year	= lower_32_bits(u64tmp) / 2939745 / 4;
+
+	year		= 100 * century + year_of_century;
+	is_leap_year	= year_of_century != 0 ?
+		year_of_century % 4 == 0 : century % 4 == 0;
+
+	u32tmp		= 2141 * day_of_year + 132377;
+	month		= u32tmp >> 16;
+	day		= ((u16) u32tmp) / 2141;
+
+	/*
+	 * Recall that January 01 is the 306-th day of the year in the
+	 * computational (not Gregorian) calendar.
+	 */
+	is_Jan_or_Feb	= day_of_year >= 306;
+
+	/* Converts to the Gregorian calendar. */
+	year		= year + is_Jan_or_Feb;
+	month		= is_Jan_or_Feb ? month - 12 : month;
+	day		= day + 1;
+
+	day_of_year	= is_Jan_or_Feb ?
+		day_of_year - 306 : day_of_year + 31 + 28 + is_leap_year;
+
+	/* Converts to rtc_time's format. */
+	tm->tm_year	= (int) (year - 1900);
+	tm->tm_mon	= (int) month;
+	tm->tm_mday	= (int) day;
+	tm->tm_yday	= (int) day_of_year + 1;
 
 	tm->tm_hour = secs / 3600;
 	secs -= tm->tm_hour * 3600;
diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
new file mode 100644
index 000000000000..fa6fd2875b3d
--- /dev/null
+++ b/drivers/rtc/lib_test.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: LGPL-2.1+
+
+#include <kunit/test.h>
+#include <linux/rtc.h>
+
+/*
+ * Advance a date by one day.
+ */
+static void advance_date(int *year, int *month, int *mday, int *yday)
+{
+	if (*mday != rtc_month_days(*month - 1, *year)) {
+		++*mday;
+		++*yday;
+		return;
+	}
+
+	*mday = 1;
+	if (*month != 12) {
+		++*month;
+		++*yday;
+		return;
+	}
+
+	*month = 1;
+	*yday  = 1;
+	++*year;
+}
+
+/*
+ * Checks every day in a 160000 years interval starting on 1970-01-01
+ * against the expected result.
+ */
+static void rtc_time64_to_tm_test_date_range(struct kunit *test)
+{
+	/*
+	 * 160000 years	= (160000 / 400) * 400 years
+	 *		= (160000 / 400) * 146097 days
+	 *		= (160000 / 400) * 146097 * 86400 seconds
+	 */
+	time64_t total_secs = ((time64_t) 160000) / 400 * 146097 * 86400;
+
+	int year	= 1970;
+	int month	= 1;
+	int mday	= 1;
+	int yday	= 1;
+
+	struct rtc_time result;
+	time64_t secs;
+	s64 days;
+
+	for (secs = 0; secs <= total_secs; secs += 86400) {
+
+		rtc_time64_to_tm(secs, &result);
+
+		days = div_s64(secs, 86400);
+
+		#define FAIL_MSG "%d/%02d/%02d (%2d) : %lld", \
+			year, month, mday, yday, days
+
+		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, month - 1, result.tm_mon, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, mday, result.tm_mday, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, yday, result.tm_yday, FAIL_MSG);
+
+		advance_date(&year, &month, &mday, &yday);
+	}
+}
+
+static struct kunit_case rtc_lib_test_cases[] = {
+	KUNIT_CASE(rtc_time64_to_tm_test_date_range),
+	{}
+};
+
+static struct kunit_suite rtc_lib_test_suite = {
+	.name = "rtc_lib_test_cases",
+	.test_cases = rtc_lib_test_cases,
+};
+
+kunit_test_suite(rtc_lib_test_suite);
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 9167b48014a1..7d2367104a9b 100644
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
diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 3c7f5ecf5511..27ad03550aa5 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -450,6 +450,8 @@ static ssize_t zfcp_sysfs_unit_add_store(struct device *dev,
 	if (kstrtoull(buf, 0, (unsigned long long *) &fcp_lun))
 		return -EINVAL;
 
+	flush_work(&port->rport_work);
+
 	retval = zfcp_unit_add(port, fcp_lun);
 	if (retval)
 		return retval;
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 353c360b0c6a..ca91527a1807 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4772,7 +4772,7 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 		case CMD_GEN_REQUEST64_CR:
 			if (iocb->context_un.ndlp == ndlp)
 				return 1;
-			fallthrough;
+			break;
 		case CMD_ELS_REQUEST64_CR:
 			if (icmd->un.elsreq64.remoteID == ndlp->nlp_DID)
 				return 1;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 84f90f4d5abd..ff39c596f000 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -5530,9 +5530,9 @@ lpfc_sli4_get_ctl_attr(struct lpfc_hba *phba)
 	phba->sli4_hba.lnk_info.lnk_no =
 		bf_get(lpfc_cntl_attr_lnk_numb, cntl_attr);
 
-	memset(phba->BIOSVersion, 0, sizeof(phba->BIOSVersion));
-	strlcat(phba->BIOSVersion, (char *)cntl_attr->bios_ver_str,
+	memcpy(phba->BIOSVersion, cntl_attr->bios_ver_str,
 		sizeof(phba->BIOSVersion));
+	phba->BIOSVersion[sizeof(phba->BIOSVersion) - 1] = '\0';
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 			"3086 lnk_type:%d, lnk_numb:%d, bios_ver:%s\n",
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 912845415d9b..22b0bfc3f055 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -692,7 +692,7 @@ static u32 qedf_get_login_failures(void *cookie)
 }
 
 static struct qed_fcoe_cb_ops qedf_cb_ops = {
-	{
+	.common = {
 		.link_update = qedf_link_update,
 		.bw_update = qedf_bw_update,
 		.schedule_recovery_handler = qedf_schedule_recovery_handler,
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 548adbe54444..9fdfe1be9516 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3502,7 +3502,7 @@ static int iscsi_new_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.new_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_new_fnode;
 	}
 
 	index = transport->new_flashnode(shost, data, len);
@@ -3512,7 +3512,6 @@ static int iscsi_new_flashnode(struct iscsi_transport *transport,
 	else
 		err = -EIO;
 
-put_host:
 	scsi_host_put(shost);
 
 exit_new_fnode:
@@ -3537,7 +3536,7 @@ static int iscsi_del_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.del_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_del_fnode;
 	}
 
 	idx = ev->u.del_flashnode.flashnode_idx;
@@ -3579,7 +3578,7 @@ static int iscsi_login_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.login_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_login_fnode;
 	}
 
 	idx = ev->u.login_flashnode.flashnode_idx;
@@ -3631,7 +3630,7 @@ static int iscsi_logout_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.logout_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_logout_fnode;
 	}
 
 	idx = ev->u.logout_flashnode.flashnode_idx;
@@ -3681,7 +3680,7 @@ static int iscsi_logout_flashnode_sid(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.logout_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_logout_sid;
 	}
 
 	session = iscsi_session_lookup(ev->u.logout_flashnode_sid.sid);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index dca2a06e5cb8..8c98dc672ca8 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -400,7 +400,7 @@ MODULE_PARM_DESC(ring_avail_percent_lowater,
 /*
  * Timeout in seconds for all devices managed by this driver.
  */
-static int storvsc_timeout = 180;
+static const int storvsc_timeout = 180;
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
 static struct scsi_transport_template *fc_transport_template;
@@ -779,7 +779,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 		return;
 	}
 
-	t = wait_for_completion_timeout(&request->wait_event, 10*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0) {
 		dev_err(dev, "Failed to create sub-channel: timed out\n");
 		return;
@@ -840,7 +840,7 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 	if (ret != 0)
 		return ret;
 
-	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0)
 		return -ETIMEDOUT;
 
@@ -1301,6 +1301,8 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size,
 		return ret;
 
 	ret = storvsc_channel_init(device, is_fc);
+	if (ret)
+		vmbus_close(device->channel);
 
 	return ret;
 }
@@ -1623,7 +1625,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	if (ret != 0)
 		return FAILED;
 
-	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0)
 		return TIMEOUT_ERROR;
 
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 538d7aab8db5..43e30937fc9d 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -168,7 +168,7 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
+	if (lpc_snoop->irq < 0)
 		return -ENODEV;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
@@ -202,11 +202,15 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
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
@@ -223,7 +227,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		hicrb_en = HICRB_ENSNP1D;
 		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_misc_deregister;
 	}
 
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -233,6 +238,12 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
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
 
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 02f56fc001b4..7d8e5c66f6d1 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -357,7 +357,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	reset = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index b31b5f4e959e..da559b86f6b1 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -533,7 +533,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	reset = devm_reset_control_get_optional_shared(dev, NULL);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 12fd02f92e37..f1ca8b5356bc 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -915,6 +915,7 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	void *rx_buf = t->rx_buf;
 	unsigned int len = t->len;
 	unsigned int bits = t->bits_per_word;
+	unsigned int max_wdlen = 256;
 	unsigned int bytes_per_word;
 	unsigned int words;
 	int n;
@@ -928,17 +929,17 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	if (!spi_controller_is_slave(p->ctlr))
 		sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
 
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
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 7d91d64b26f3..3d2ae33a8bc9 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -412,7 +412,7 @@ static ssize_t ad5933_store(struct device *dev,
 		ret = ad5933_cmd(st, 0);
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
-		val = clamp(val, (u16)0, (u16)0x7FF);
+		val = clamp(val, (u16)0, (u16)0x7FC);
 		st->settling_cycles = val;
 
 		/* 2x, 4x handling, see datasheet */
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 86483f1c070b..3266f1d78e88 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -178,8 +178,14 @@ static int rkvdec_enum_framesizes(struct file *file, void *priv,
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
 
@@ -821,24 +827,24 @@ static int rkvdec_open(struct file *filp)
 	rkvdec_reset_decoded_fmt(ctx);
 	v4l2_fh_init(&ctx->fh, video_devdata(filp));
 
-	ret = rkvdec_init_ctrls(ctx);
-	if (ret)
-		goto err_free_ctx;
-
 	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(rkvdec->m2m_dev, ctx,
 					    rkvdec_queue_init);
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
-		goto err_cleanup_ctrls;
+		goto err_free_ctx;
 	}
 
+	ret = rkvdec_init_ctrls(ctx);
+	if (ret)
+		goto err_cleanup_m2m_ctx;
+
 	filp->private_data = &ctx->fh;
 	v4l2_fh_add(&ctx->fh);
 
 	return 0;
 
-err_cleanup_ctrls:
-	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
+err_cleanup_m2m_ctx:
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 
 err_free_ctx:
 	kfree(ctx);
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 9cc4a7b63b0d..e6de0e80b793 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
@@ -19,7 +20,7 @@
 
 #define TEE_NUM_DEVICES	32
 
-#define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
+#define TEE_IOCTL_PARAM_SIZE(x) (size_mul(sizeof(struct tee_param), (x)))
 
 #define TEE_UUID_NS_NAME_SIZE	128
 
@@ -492,7 +493,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;
 
-	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+	if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	if (arg.num_params) {
@@ -570,7 +571,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;
 
-	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+	if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	if (arg.num_params) {
@@ -704,7 +705,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 	if (get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
-	if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) != buf.buf_len)
+	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	params = kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL);
@@ -803,7 +804,7 @@ static int tee_ioctl_supp_send(struct tee_context *ctx,
 	    get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
-	if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) > buf.buf_len)
+	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) > buf.buf_len)
 		return -EINVAL;
 
 	params = kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL);
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index c73792ca727a..38492dbd60f3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -264,7 +264,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
 	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
 		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
 		enable ? "en" : "dis");
-	if (tsens_version(priv) > VER_1_X)
+	if (tsens_version(priv) >= VER_2_X)
 		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
 	else
 		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
@@ -316,7 +316,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
 	if (ret)
 		return ret;
-	if (tsens_version(priv) > VER_1_X) {
+	if (tsens_version(priv) >= VER_2_X) {
 		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
 		if (ret)
 			return ret;
@@ -360,7 +360,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 
 static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 {
-	if (ver > VER_1_X)
+	if (ver >= VER_2_X)
 		return mask & (1 << hw_id);
 
 	/* v1, v0.1 don't have a irq mask register */
@@ -560,7 +560,7 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 static int tsens_enable_irq(struct tsens_priv *priv)
 {
 	int ret;
-	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
+	int val = tsens_version(priv) >= VER_2_X ? 7 : 1;
 
 	ret = regmap_field_write(priv->rf[INT_EN], val);
 	if (ret < 0)
@@ -826,7 +826,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
-	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+	if (tsens_version(priv) >= VER_2_X &&  ver_minor > 2) {
 		/* Watchdog is present only on v2.3+ */
 		priv->feat->has_watchdog = 1;
 		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 772acb190f50..85a6b093a097 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -131,6 +131,11 @@ static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
 	struct tb_ctl *ctl = req->ctl;
 
 	mutex_lock(&ctl->request_queue_lock);
+	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
+		mutex_unlock(&ctl->request_queue_lock);
+		return;
+	}
+
 	list_del(&req->list);
 	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
 	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 8f2cab7f66ad..d9f094514945 100644
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
index 26c5c585c221..2e1783ae8a9b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -157,6 +157,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -165,6 +166,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -806,6 +808,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -837,6 +840,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		serial_port_out(port, SCxTDR, c);
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1204,6 +1208,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!uart_circ_empty(xmit)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1686,6 +1692,19 @@ static void sci_flush_buffer(struct uart_port *port)
 		s->cookie_tx = -EINVAL;
 	}
 }
+
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	if (!s->chan_tx)
+		return;
+
+	status = dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
+	if (status == DMA_COMPLETE || status == DMA_IN_PROGRESS)
+		s->tx_occurred = true;
+}
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
@@ -1695,6 +1714,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -2007,6 +2030,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = serial_port_in(port, SCxSR);
 	unsigned short in_tx_fifo = sci_txfill(port);
+	struct sci_port *s = to_sci_port(port);
+
+	sci_dma_check_tx_occurred(s);
+
+	if (!s->tx_occurred)
+		return TIOCSER_TEMT;
 
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
@@ -2177,6 +2206,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
@@ -2992,10 +3022,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3025,11 +3051,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, int ch)
@@ -3187,8 +3208,6 @@ static int sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3290,7 +3309,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3319,6 +3339,11 @@ static int sci_probe_single(struct platform_device *dev,
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
@@ -3332,13 +3357,31 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
-	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
+	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
+		/*
+		 * Skip cleanup the sci_port[0] in early_console_exit(), this
+		 * port is the same as the earlycon one.
+		 */
+		sci_uart_earlycon_dev_probing = true;
 	}
 
-	return 0;
+	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
 static int sci_probe(struct platform_device *dev)
@@ -3396,7 +3439,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3479,6 +3522,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg;
 
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port = &sci_ports[0];
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	if (!sci_uart_earlycon_dev_probing) {
+		memset(sci_port, 0, sizeof(*sci_port));
+		sci_uart_earlycon = false;
+	}
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3498,6 +3557,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index b10b86e2c17e..b62ab122fb4a 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1104,8 +1104,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	case VT_WAITACTIVE:
 	case VT_RELDISP:
 	case VT_DISALLOCATE:
-	case VT_RESIZE:
-	case VT_RESIZEX:
 		return vt_ioctl(tty, cmd, arg);
 
 	/*
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 3343cac60737..67cfe838a787 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -288,13 +288,13 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[INT_PAGE_MAP].name = "int_page";
 	pdata->info.mem[INT_PAGE_MAP].addr
 		= (uintptr_t)vmbus_connection.int_page;
-	pdata->info.mem[INT_PAGE_MAP].size = PAGE_SIZE;
+	pdata->info.mem[INT_PAGE_MAP].size = HV_HYP_PAGE_SIZE;
 	pdata->info.mem[INT_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	pdata->info.mem[MON_PAGE_MAP].name = "monitor_page";
 	pdata->info.mem[MON_PAGE_MAP].addr
 		= (uintptr_t)vmbus_connection.monitor_pages[1];
-	pdata->info.mem[MON_PAGE_MAP].size = PAGE_SIZE;
+	pdata->info.mem[MON_PAGE_MAP].size = HV_HYP_PAGE_SIZE;
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index f76fedd8fa90..ff706f48e0ad 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -486,6 +486,7 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 	__u8 stb;
 	int rv;
 	long wait_rv;
+	unsigned long expire;
 
 	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
 		data->iin_ep_present);
@@ -528,10 +529,11 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 	}
 
 	if (data->iin_ep_present) {
+		expire = msecs_to_jiffies(file_data->timeout);
 		wait_rv = wait_event_interruptible_timeout(
 			data->waitq,
 			atomic_read(&data->iin_data_valid) != 0,
-			file_data->timeout);
+			expire);
 		if (wait_rv < 0) {
 			dev_dbg(dev, "wait interrupted %ld\n", wait_rv);
 			rv = wait_rv;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 29e8f4833124..b88e3a5e8616 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6014,6 +6014,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
 	struct usb_device_descriptor	descriptor;
+	struct usb_interface		*intf;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -6074,6 +6075,18 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
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
@@ -6105,12 +6118,11 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
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
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index d9936c530874..89ffadb1a4f0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -369,6 +369,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* SanDisk Extreme 55AE */
+	{ USB_DEVICE(0x0781, 0x55ae), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ba018aeb21d8..2f30699f0426 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -114,8 +114,8 @@ static struct hid_descriptor hidg_desc = {
 	.bcdHID				= cpu_to_le16(0x0101),
 	.bCountryCode			= 0x00,
 	.bNumDescriptors		= 0x1,
-	/*.desc[0].bDescriptorType	= DYNAMIC */
-	/*.desc[0].wDescriptorLenght	= DYNAMIC */
+	/*.rpt_desc.bDescriptorType	= DYNAMIC */
+	/*.rpt_desc.wDescriptorLength	= DYNAMIC */
 };
 
 /* Super-Speed Support */
@@ -724,8 +724,8 @@ static int hidg_setup(struct usb_function *f,
 			struct hid_descriptor hidg_desc_copy = hidg_desc;
 
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
-			hidg_desc_copy.desc[0].bDescriptorType = HID_DT_REPORT;
-			hidg_desc_copy.desc[0].wDescriptorLength =
+			hidg_desc_copy.rpt_desc.bDescriptorType = HID_DT_REPORT;
+			hidg_desc_copy.rpt_desc.wDescriptorLength =
 				cpu_to_le16(hidg->report_desc_length);
 
 			length = min_t(unsigned short, length,
@@ -966,8 +966,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	 * We can use hidg_desc struct here but we should not relay
 	 * that its content won't change after returning from this function.
 	 */
-	hidg_desc.desc[0].bDescriptorType = HID_DT_REPORT;
-	hidg_desc.desc[0].wDescriptorLength =
+	hidg_desc.rpt_desc.bDescriptorType = HID_DT_REPORT;
+	hidg_desc.rpt_desc.wDescriptorLength =
 		cpu_to_le16(hidg->report_desc_length);
 
 	hidg_hs_in_ep_desc.bEndpointAddress =
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index df679908b8d2..23d160ef4cd2 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -678,10 +678,29 @@ static int usbhs_probe(struct platform_device *pdev)
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
@@ -698,10 +717,6 @@ static int usbhs_probe(struct platform_device *pdev)
 	if (ret)
 		goto probe_fail_rst;
 
-	ret = usbhsc_clk_get(dev, priv);
-	if (ret)
-		goto probe_fail_clks;
-
 	/*
 	 * deviece reset here because
 	 * USB device might be used in boot loader.
@@ -714,7 +729,7 @@ static int usbhs_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_warn(dev, "USB function not selected (GPIO)\n");
 			ret = -ENOTSUPP;
-			goto probe_end_mod_exit;
+			goto probe_assert_rest;
 		}
 	}
 
@@ -728,14 +743,19 @@ static int usbhs_probe(struct platform_device *pdev)
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
@@ -752,9 +772,7 @@ static int usbhs_probe(struct platform_device *pdev)
 
 	return ret;
 
-probe_end_mod_exit:
-	usbhsc_clk_put(priv);
-probe_fail_clks:
+probe_assert_rest:
 	reset_control_assert(priv->rsts);
 probe_fail_rst:
 	usbhs_mod_remove(priv);
@@ -762,6 +780,14 @@ static int usbhs_probe(struct platform_device *pdev)
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
 
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index d460d71b4257..1477e31d7763 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -52,6 +52,13 @@ UNUSUAL_DEV(0x059f, 0x1061, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES | US_FL_NO_SAME),
 
+/* Reported-by: Zhihong Zhou <zhouzhihong@greatwall.com.cn> */
+UNUSUAL_DEV(0x0781, 0x55e8, 0x0000, 0x9999,
+		"SanDisk",
+		"",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* Reported-by: Hongling Zeng <zenghongling@kylinos.cn> */
 UNUSUAL_DEV(0x090c, 0x2000, 0x0000, 0x9999,
 		"Hiksemi",
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 9b01f88ae476..b2a543e7cac4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -269,7 +269,7 @@ static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
 			struct rb_node *p;
 
 			for (p = rb_prev(n); p; p = rb_prev(p)) {
-				struct vfio_dma *dma = rb_entry(n,
+				struct vfio_dma *dma = rb_entry(p,
 							struct vfio_dma, node);
 
 				vfio_dma_bitmap_free(dma);
diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 486d35da0150..54c4bb66009f 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1404,9 +1404,11 @@ static int wled_configure(struct wled *wled)
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
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 042e166d9268..ae555fa5f583 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1200,7 +1200,7 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else
+		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,
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
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1704deaf4152..285e6f5ae13c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1062,8 +1062,10 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	    !list_empty(&info->modelist))
 		ret = fb_add_videomode(&mode, &info->modelist);
 
-	if (ret)
+	if (ret) {
+		info->var = old_var;
 		return ret;
+	}
 
 	event.info = info;
 	event.data = &mode;
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index d708c091bf1b..180526220d8c 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -164,6 +164,7 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt = &driver_data->wdt;
 
 	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
+	da9052_wdt->min_hw_heartbeat_ms = DA9052_TWDMIN;
 	da9052_wdt->info = &da9052_wdt_info;
 	da9052_wdt->ops = &da9052_wdt_ops;
 	da9052_wdt->parent = dev;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 12388ed4faa5..fcacee2b3c0f 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -619,7 +619,7 @@ static int populate_attrs(struct config_item *item)
 				break;
 		}
 	}
-	if (t->ct_bin_attrs) {
+	if (!error && t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 314d5407a1be..a75d5fb2404c 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -804,4 +804,5 @@ int exfat_create_upcase_table(struct super_block *sb)
 void exfat_free_upcase_table(struct exfat_sb_info *sbi)
 {
 	kvfree(sbi->vol_utbl);
+	sbi->vol_utbl = NULL;
 }
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fec021e6bb60..1dc1292d8977 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3229,6 +3229,13 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
 	return 1 << sbi->s_log_groups_per_flex;
 }
 
+static inline loff_t ext4_get_maxbytes(struct inode *inode)
+{
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return inode->i_sb->s_maxbytes;
+	return EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+}
+
 #define ext4_std_error(sb, errno)				\
 do {								\
 	if ((errno))						\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ffdc68b11c01..12da59c03c7c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1526,7 +1526,7 @@ static int ext4_ext_search_left(struct inode *inode,
 static int ext4_ext_search_right(struct inode *inode,
 				 struct ext4_ext_path *path,
 				 ext4_lblk_t *logical, ext4_fsblk_t *phys,
-				 struct ext4_extent *ret_ex)
+				 struct ext4_extent *ret_ex, int flags)
 {
 	struct buffer_head *bh = NULL;
 	struct ext4_extent_header *eh;
@@ -1600,7 +1600,8 @@ static int ext4_ext_search_right(struct inode *inode,
 	ix++;
 	while (++depth < path->p_depth) {
 		/* subtract from p_depth to get proper eh_depth */
-		bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+		bh = read_extent_tree_block(inode, ix, path->p_depth - depth,
+					    flags);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		eh = ext_block_hdr(bh);
@@ -1608,7 +1609,7 @@ static int ext4_ext_search_right(struct inode *inode,
 		put_bh(bh);
 	}
 
-	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, flags);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	eh = ext_block_hdr(bh);
@@ -2367,18 +2368,19 @@ int ext4_ext_calc_credits_for_single_extent(struct inode *inode, int nrblocks,
 int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 {
 	int index;
-	int depth;
 
 	/* If we are converting the inline data, only one is needed here. */
 	if (ext4_has_inline_data(inode))
 		return 1;
 
-	depth = ext_depth(inode);
-
+	/*
+	 * Extent tree can change between the time we estimate credits and
+	 * the time we actually modify the tree. Assume the worst case.
+	 */
 	if (extents <= 1)
-		index = depth * 2;
+		index = EXT4_MAX_EXTENT_DEPTH * 2;
 	else
-		index = depth * 3;
+		index = EXT4_MAX_EXTENT_DEPTH * 3;
 
 	return index;
 }
@@ -2793,6 +2795,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
+	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
 
 	partial.pclu = 0;
 	partial.lblk = 0;
@@ -2823,8 +2826,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL,
-					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
+		path = ext4_find_extent(inode, end, NULL, flags);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -2889,7 +2891,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    NULL);
+						    NULL, flags);
 			if (err < 0)
 				goto out;
 			if (pblk) {
@@ -2966,8 +2968,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				  i + 1, ext4_idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			bh = read_extent_tree_block(inode, path[i].p_idx,
-						    depth - i - 1,
-						    EXT4_EX_NOCACHE);
+						    depth - i - 1, flags);
 			if (IS_ERR(bh)) {
 				/* should we reset i_size? */
 				err = PTR_ERR(bh);
@@ -4269,7 +4270,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto out;
 	ar.lright = map->m_lblk;
-	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
+	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright,
+				    &ex2, 0);
 	if (err < 0)
 		goto out;
 
@@ -4969,12 +4971,7 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
 
 static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
 {
-	u64 maxbytes;
-
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		maxbytes = inode->i_sb->s_maxbytes;
-	else
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+	u64 maxbytes = ext4_get_maxbytes(inode);
 
 	if (*len == 0)
 		return -EINVAL;
@@ -5037,7 +5034,9 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
+		inode_lock_shared(inode);
 		error = ext4_ext_precache(inode);
+		inode_unlock_shared(inode);
 		if (error)
 			return error;
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c78df91f17da..bbed22731ac9 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -858,12 +858,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes;
-
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
-	else
-		maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = ext4_get_maxbytes(inode);
 
 	switch (whence) {
 	default:
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index da1ca9e0869f..8ccbb3703954 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -389,7 +389,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 }
 
 static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
-				    unsigned int len)
+				    loff_t len)
 {
 	int ret, size, no_expand;
 	struct ext4_inode_info *ei = EXT4_I(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 15d020279d3b..ef39d6b141a6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4868,7 +4868,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ei->i_file_acl |=
 			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	inode->i_size = ext4_isize(sb, raw_inode);
-	if ((size = i_size_read(inode)) < 0) {
+	size = i_size_read(inode);
+	if (size < 0 || size > ext4_get_maxbytes(inode)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "iget: bad i_size value: %lld", size);
 		ret = -EFSCORRUPTED;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 56829507e68c..b6da12b4c8a8 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1139,8 +1139,14 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return 0;
 	}
 	case EXT4_IOC_PRECACHE_EXTENTS:
-		return ext4_ext_precache(inode);
+	{
+		int ret;
 
+		inode_lock_shared(inode);
+		ret = ext4_ext_precache(inode);
+		inode_unlock_shared(inode);
+		return ret;
+	}
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 		if (!ext4_has_feature_encrypt(sb))
 			return -EOPNOTSUPP;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1b764f70b70e..9eb20211619d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -77,7 +77,7 @@ static bool __is_cp_guaranteed(struct page *page)
 	struct inode *inode;
 	struct f2fs_sb_info *sbi;
 
-	if (!mapping)
+	if (fscrypt_is_bounce_page(page))
 		return false;
 
 	if (f2fs_is_compressed_page(page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 10231d5bba15..4e42ca56da86 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2076,8 +2076,14 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
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
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 56d23bc25435..7be488ecb210 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -396,7 +396,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	if (is_inode_flag_set(dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)))
+			F2FS_I(inode)->i_projid)))
 		return -EXDEV;
 
 	err = dquot_initialize(dir);
@@ -606,6 +606,15 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 
+	if (unlikely(inode->i_nlink == 0)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+			  __func__, inode->i_ino);
+		err = -EFSCORRUPTED;
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		f2fs_put_page(page, 0);
+		goto fail;
+	}
+
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
@@ -932,7 +941,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(new_dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)))
+			F2FS_I(old_inode)->i_projid)))
 		return -EXDEV;
 
 	/*
@@ -1122,10 +1131,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
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
 
 	err = dquot_initialize(old_dir);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9afbb51bd678..b7997df291a6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1507,9 +1507,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -3017,6 +3017,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t user_block_count, valid_user_blocks;
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
+	unsigned int sit_blk_cnt;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3118,6 +3119,13 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	if (sit_bitmap_size * 8 < sit_blk_cnt) {
+		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
+			 sit_bitmap_size, sit_blk_cnt);
+		return 1;
+	}
+
 	cp_pack_start_sum = __start_sum_addr(sbi);
 	cp_payload = __cp_payload(sbi);
 	if (cp_pack_start_sum < cp_payload + 1 ||
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 90b8d879fbaf..1ab8eb5edf28 100644
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
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 22905a076a6a..f266dec20517 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -636,7 +636,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR(inode)) {
 		if (S_ISDIR(inode->i_mode)) {
 			iput(inode);
-			inode = ERR_PTR(-EISDIR);
+			inode = NULL;
+			error = -EISDIR;
 			goto fail_gunlock;
 		}
 		d_instantiate(dentry, inode);
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 5564aa8b4592..432d32c7c479 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -939,14 +939,15 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
+			spin_unlock(&ls->ls_recover_spin);
 			msleep_interruptible(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
 				start_gen, mount_gen, lvb_gen,
 				ls->ls_recover_flags);
+			spin_unlock(&ls->ls_recover_spin);
 		}
-		spin_unlock(&ls->ls_recover_spin);
 		goto restart;
 	}
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 1baf2d607268..c2241469cf90 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1492,7 +1492,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 				jh->b_next_transaction == transaction);
 		spin_unlock(&jh->b_state_lock);
 	}
-	if (jh->b_modified == 1) {
+	if (data_race(jh->b_modified == 1)) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
 		if (data_race(jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata)) {
@@ -1511,7 +1511,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out;
 	}
 
-	journal = transaction->t_journal;
 	spin_lock(&jh->b_state_lock);
 
 	if (is_handle_aborted(handle)) {
@@ -1526,6 +1525,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
+	journal = transaction->t_journal;
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 5fbaf6ab9f48..796dd3807a5d 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -427,7 +427,9 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
 			.totlen =	cpu_to_je32(c->cleanmarker_size)
 		};
 
-		jffs2_prealloc_raw_node_refs(c, jeb, 1);
+		ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
+		if (ret)
+			goto filebad;
 
 		marker.hdr_crc = cpu_to_je32(crc32(0, &marker, sizeof(struct jffs2_unknown_node)-4));
 
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..62879c218d4b 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -256,7 +256,9 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 
 		jffs2_dbg(1, "%s(): Skipping %d bytes in nextblock to ensure page alignment\n",
 			  __func__, skip);
-		jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
+		ret = jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
+		if (ret)
+			goto out;
 		jffs2_scan_dirty_space(c, c->nextblock, skip);
 	}
 #endif
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 4fe64519870f..d83372d3e1a0 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -858,7 +858,10 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
 	spin_unlock(&c->erase_completion_lock);
 
 	jeb = c->nextblock;
-	jffs2_prealloc_raw_node_refs(c, jeb, 1);
+	ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
+
+	if (ret)
+		goto out;
 
 	if (!c->summary->sum_num || !c->summary->sum_list_head) {
 		JFFS2_WARNING("Empty summary info!!!\n");
@@ -872,6 +875,8 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
 	datasize += padsize;
 
 	ret = jffs2_sum_write_data(c, jeb, infosize, datasize, padsize);
+
+out:
 	spin_lock(&c->erase_completion_lock);
 	return ret;
 }
diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 5f4b305030ad..4b660296caf3 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -86,7 +86,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	down_read(&sb->s_umount);
 	bmp = JFS_SBI(ip->i_sb)->bmap;
 
-	if (minlen > bmp->db_agsize ||
+	if (bmp == NULL ||
+	    minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
 	    range->len < sb->s_blocksize) {
 		up_read(&sb->s_umount);
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 417d1c2fc291..27ca98614b0b 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2909,7 +2909,7 @@ void dtInitRoot(tid_t tid, struct inode *ip, u32 idotdot)
  *	     fsck.jfs should really fix this, but it currently does not.
  *	     Called from jfs_readdir when bad index is detected.
  */
-static void add_missing_indices(struct inode *inode, s64 bn)
+static int add_missing_indices(struct inode *inode, s64 bn)
 {
 	struct ldtentry *d;
 	struct dt_lock *dtlck;
@@ -2918,7 +2918,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	struct lv *lv;
 	struct metapage *mp;
 	dtpage_t *p;
-	int rc;
+	int rc = 0;
 	s8 *stbl;
 	tid_t tid;
 	struct tlock *tlck;
@@ -2943,6 +2943,16 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 
 	stbl = DT_GETSTBL(p);
 	for (i = 0; i < p->header.nextindex; i++) {
+		if (stbl[i] < 0) {
+			jfs_err("jfs: add_missing_indices: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+				i, stbl[i], (long)inode->i_ino, (long long)bn);
+			rc = -EIO;
+
+			DT_PUTPAGE(mp);
+			txAbort(tid, 0);
+			goto end;
+		}
+
 		d = (struct ldtentry *) &p->slot[stbl[i]];
 		index = le32_to_cpu(d->index);
 		if ((index < 2) || (index >= JFS_IP(inode)->next_index)) {
@@ -2960,6 +2970,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	(void) txCommit(tid, 1, &inode, 0);
 end:
 	txEnd(tid);
+	return rc;
 }
 
 /*
@@ -3313,7 +3324,8 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		if (fix_page) {
-			add_missing_indices(ip, bn);
+			if ((rc = add_missing_indices(ip, bn)))
+				goto out;
 			page_fixed = 1;
 		}
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 869cc6e06d88..2d5af6653cd1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2308,6 +2308,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
+	if (!check_mnt(mnt)) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2d2238548a6e..7c58a1688f7f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1000,6 +1000,16 @@ int nfs_reconfigure(struct fs_context *fc)
 
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
@@ -1248,8 +1258,17 @@ int nfs_get_tree_common(struct fs_context *fc)
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
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8cf0e4e62bc8..1da06a15b13f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3537,7 +3537,8 @@ bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 	struct nfs4_op_map *allow = &cstate->clp->cl_spo_must_allow;
 	u32 opiter;
 
-	if (!cstate->minorversion)
+	if (rqstp->rq_procinfo != &nfsd_version4.vs_proc[NFSPROC4_COMPOUND] ||
+	    cstate->minorversion == 0)
 		return false;
 
 	if (cstate->spo_must_allowed)
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 29eb9861684e..b71af165b577 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -427,13 +427,13 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_filecache;
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_init_umount_work(nn);
+#endif
 	ret = nfs4_state_start_net(net);
 	if (ret)
 		goto out_reply_cache;
 
-#ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	nfsd4_ssc_init_umount_work(nn);
-#endif
 	nn->nfsd_net_up = true;
 	return 0;
 
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 7c9f4d79bdbc..4a5e8495fa67 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2097,11 +2097,13 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
 
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
index 7faf8c285d6c..a72371cd6b95 100644
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
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 88cc94be1076..5a47b5c2fdc0 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -86,6 +86,11 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	msblk = sb->s_fs_info;
 
 	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
+	if (!msblk->devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
 	mutex_init(&msblk->meta_index_mutex);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 7334037624c5..a2bf54fb946a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -524,7 +524,7 @@ typedef u64 acpi_integer;
 
 /* Support for the special RSDP signature (8 characters) */
 
-#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
+#define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
 #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
 
 /* Support for OEMx signature (x can be any character) */
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
 
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 5d5ff2203fa2..bc24d19ec2b3 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -248,6 +248,12 @@ static inline void atm_account_tx(struct atm_vcc *vcc, struct sk_buff *skb)
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 }
 
+static inline void atm_return_tx(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	WARN_ON_ONCE(refcount_sub_and_test(ATM_SKB(skb)->acct_truesize,
+					   &sk_atm(vcc)->sk_wmem_alloc));
+}
+
 static inline void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
 	atomic_add(truesize, &sk_atm(vcc)->sk_rmem_alloc);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 340f4fef5b5a..5d5d0bc7ca50 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1793,7 +1793,7 @@ static inline void bpf_map_offload_map_free(struct bpf_map *map)
 }
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
-#if defined(CONFIG_BPF_STREAM_PARSER)
+#if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
 int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 			 struct bpf_prog *old, u32 which);
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
@@ -1802,7 +1802,18 @@ int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 fl
 void sock_map_unhash(struct sock *sk);
 void sock_map_destroy(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
+
+void bpf_sk_reuseport_detach(struct sock *sk);
+int bpf_fd_reuseport_array_lookup_elem(struct bpf_map *map, void *key,
+				       void *value);
+int bpf_fd_reuseport_array_update_elem(struct bpf_map *map, void *key,
+				       void *value, u64 map_flags);
 #else
+static inline void bpf_sk_reuseport_detach(struct sock *sk)
+{
+}
+
+#ifdef CONFIG_BPF_SYSCALL
 static inline int sock_map_prog_update(struct bpf_map *map,
 				       struct bpf_prog *prog,
 				       struct bpf_prog *old, u32 which)
@@ -1827,20 +1838,7 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
 {
 	return -EOPNOTSUPP;
 }
-#endif /* CONFIG_BPF_STREAM_PARSER */
 
-#if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
-void bpf_sk_reuseport_detach(struct sock *sk);
-int bpf_fd_reuseport_array_lookup_elem(struct bpf_map *map, void *key,
-				       void *value);
-int bpf_fd_reuseport_array_update_elem(struct bpf_map *map, void *key,
-				       void *value, u64 map_flags);
-#else
-static inline void bpf_sk_reuseport_detach(struct sock *sk)
-{
-}
-
-#ifdef CONFIG_BPF_SYSCALL
 static inline int bpf_fd_reuseport_array_lookup_elem(struct bpf_map *map,
 						     void *key, void *value)
 {
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index a8137bb6dd3c..2bb5801b5887 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -103,10 +103,6 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
-#if defined(CONFIG_BPF_STREAM_PARSER)
-BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
-BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
-#endif
 #ifdef CONFIG_BPF_LSM
 BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
 #endif
@@ -115,6 +111,8 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CPUMAP, cpu_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_XSKMAP, xsk_map_ops)
 #endif
 #ifdef CONFIG_INET
+BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY, reuseport_array_ops)
 #endif
 #endif
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 9e306bf9959d..03627c96d814 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -674,8 +674,9 @@ struct hid_descriptor {
 	__le16 bcdHID;
 	__u8  bCountryCode;
 	__u8  bNumDescriptors;
+	struct hid_class_descriptor rpt_desc;
 
-	struct hid_class_descriptor desc[1];
+	struct hid_class_descriptor opt_descs[];
 } __attribute__ ((packed));
 
 #define HID_DEVICE(b, g, ven, prod)					\
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 90c66b9458c3..1c03935aa3d1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -188,6 +188,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -369,6 +371,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 	return 0;
 }
 
+static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
+
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 56cb2fbc496e..0737d5fc35c7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -390,6 +390,7 @@ struct mlx5_core_rsc_common {
 	enum mlx5_res_type	res;
 	refcount_t		refcount;
 	struct completion	free;
+	bool			invalid;
 };
 
 struct mlx5_uars_page {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 94e630862d58..e159a11424f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2318,6 +2318,9 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	atomic_set(&page->pt_share_count, 0);
+#endif
 	inc_zone_page_state(page, NR_PAGETABLE);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4eb38918da8f..b6cf570dc98c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -151,6 +151,9 @@ struct page {
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+				atomic_t pt_share_count;
+#endif
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 49db90cfe375..e9e9fabbfedd 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -71,7 +71,9 @@ struct sk_psock_link {
 };
 
 struct sk_psock_parser {
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+#endif
 	bool				enabled;
 	void (*saved_data_ready)(struct sock *sk);
 };
@@ -307,9 +309,25 @@ static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 
 struct sk_psock *sk_psock_init(struct sock *sk, int node);
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock);
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock);
 void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock);
+#else
+static inline int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
+{
+}
+
+static inline void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
+{
+}
+#endif
+
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock);
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock);
 
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 8b7d0c31598f..5b6a87f5486a 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -152,7 +152,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/include/net/sock.h b/include/net/sock.h
index 548f9aab9aa1..bc9a1e535d58 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1226,7 +1226,7 @@ struct proto {
 #endif
 
 	bool			(*stream_memory_free)(const struct sock *sk, int wake);
-	bool			(*stream_memory_read)(const struct sock *sk);
+	bool			(*sock_is_readable)(struct sock *sk);
 	/* Memory pressure */
 	void			(*enter_memory_pressure)(struct sock *sk);
 	void			(*leave_memory_pressure)(struct sock *sk);
@@ -2825,4 +2825,13 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs);
 
 int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len);
 
+static inline bool sk_is_readable(struct sock *sk)
+{
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	if (prot->sock_is_readable)
+		return prot->sock_is_readable(sk);
+
+	return false;
+}
 #endif	/* _SOCK_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aad2e79ac6a..4c87936a33d6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1445,6 +1445,18 @@ static inline bool tcp_rmem_pressure(const struct sock *sk)
 	return atomic_read(&sk->sk_rmem_alloc) > threshold;
 }
 
+static inline bool tcp_epollin_ready(const struct sock *sk, int target)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	int avail = READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->copied_seq);
+
+	if (avail <= 0)
+		return false;
+
+	return (avail >= target) || tcp_rmem_pressure(sk) ||
+	       (tcp_receive_window(tp) <= inet_csk(sk)->icsk_ack.rcv_mss);
+}
+
 extern void tcp_openreq_init_rwin(struct request_sock *req,
 				  const struct sock *sk_listener,
 				  const struct dst_entry *dst);
@@ -2262,25 +2274,27 @@ void tcp_update_ulp(struct sock *sk, struct proto *p,
 	__MODULE_INFO(alias, alias_userspace, name);		\
 	__MODULE_INFO(alias, alias_tcp_ulp, "tcp-ulp-" name)
 
+#ifdef CONFIG_NET_SOCK_MSG
 struct sk_msg;
 struct sk_psock;
 
-#ifdef CONFIG_BPF_STREAM_PARSER
+#ifdef CONFIG_BPF_SYSCALL
 struct proto *tcp_bpf_get_proto(struct sock *sk, struct sk_psock *psock);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
-#else
-static inline void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
-{
-}
-#endif /* CONFIG_BPF_STREAM_PARSER */
+#endif /* CONFIG_BPF_SYSCALL */
 
-#ifdef CONFIG_NET_SOCK_MSG
 int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg, u32 bytes,
 			  int flags);
 int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
 		      struct msghdr *msg, int len, int flags);
 #endif /* CONFIG_NET_SOCK_MSG */
 
+#if !defined(CONFIG_BPF_SYSCALL) || !defined(CONFIG_NET_SOCK_MSG)
+static inline void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
+{
+}
+#endif
+
 #ifdef CONFIG_CGROUP_BPF
 static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 				      struct sk_buff *skb,
diff --git a/include/net/tls.h b/include/net/tls.h
index d9cb597cab46..c76a827a678a 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -377,7 +377,7 @@ void tls_sw_release_resources_rx(struct sock *sk);
 void tls_sw_free_ctx_rx(struct tls_context *tls_ctx);
 int tls_sw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		   int nonblock, int flags, int *addr_len);
-bool tls_sw_stream_read(const struct sock *sk);
+bool tls_sw_sock_is_readable(struct sock *sk);
 ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   struct pipe_inode_info *pipe,
 			   size_t len, unsigned int flags);
diff --git a/include/net/udp.h b/include/net/udp.h
index e2550a4547a7..db599b15b630 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -514,9 +514,9 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 	return segs;
 }
 
-#ifdef CONFIG_BPF_STREAM_PARSER
+#ifdef CONFIG_BPF_SYSCALL
 struct sk_psock;
 struct proto *udp_bpf_get_proto(struct sock *sk, struct sk_psock *psock);
-#endif /* BPF_STREAM_PARSER */
+#endif
 
 #endif	/* _UDP_H */
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index db4f2cec8360..0e02e6460fd7 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -235,24 +235,6 @@ DEFINE_EVENT(erofs__map_blocks_exit, z_erofs_map_blocks_iter_exit,
 	TP_ARGS(inode, map, flags, ret)
 );
 
-TRACE_EVENT(erofs_destroy_inode,
-	TP_PROTO(struct inode *inode),
-
-	TP_ARGS(inode),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	erofs_nid_t,	nid		)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_I(inode)->nid;
-	),
-
-	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
-);
-
 #endif /* _TRACE_EROFS_H */
 
  /* This part must be outside protection */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 29cc0eb2e488..2292fb44bbac 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -909,6 +909,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -3937,6 +3938,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1bbd81f031fe..1ee25344c076 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -153,10 +153,18 @@ enum v4l2_buf_type {
 	V4L2_BUF_TYPE_SDR_OUTPUT           = 12,
 	V4L2_BUF_TYPE_META_CAPTURE         = 13,
 	V4L2_BUF_TYPE_META_OUTPUT	   = 14,
+	/*
+	 * Note: V4L2_TYPE_IS_VALID and V4L2_TYPE_IS_OUTPUT must
+	 * be updated if a new type is added.
+	 */
 	/* Deprecated, do not use */
 	V4L2_BUF_TYPE_PRIVATE              = 0x80,
 };
 
+#define V4L2_TYPE_IS_VALID(type)		 \
+	((type) >= V4L2_BUF_TYPE_VIDEO_CAPTURE &&\
+	 (type) <= V4L2_BUF_TYPE_META_OUTPUT)
+
 #define V4L2_TYPE_IS_MULTIPLANAR(type)			\
 	((type) == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE	\
 	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
@@ -164,14 +172,14 @@ enum v4l2_buf_type {
 #define V4L2_TYPE_IS_OUTPUT(type)				\
 	((type) == V4L2_BUF_TYPE_VIDEO_OUTPUT			\
 	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE		\
-	 || (type) == V4L2_BUF_TYPE_VIDEO_OVERLAY		\
 	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY	\
 	 || (type) == V4L2_BUF_TYPE_VBI_OUTPUT			\
 	 || (type) == V4L2_BUF_TYPE_SLICED_VBI_OUTPUT		\
 	 || (type) == V4L2_BUF_TYPE_SDR_OUTPUT			\
 	 || (type) == V4L2_BUF_TYPE_META_OUTPUT)
 
-#define V4L2_TYPE_IS_CAPTURE(type) (!V4L2_TYPE_IS_OUTPUT(type))
+#define V4L2_TYPE_IS_CAPTURE(type)	\
+	(V4L2_TYPE_IS_VALID(type) && !V4L2_TYPE_IS_OUTPUT(type))
 
 enum v4l2_tuner_type {
 	V4L2_TUNER_RADIO	     = 1,
diff --git a/init/Kconfig b/init/Kconfig
index 233166e54df3..a6a4eaec73c8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1720,6 +1720,7 @@ config BPF_SYSCALL
 	select BPF
 	select IRQ_WORK
 	select TASKS_TRACE_RCU
+	select NET_SOCK_MSG if INET
 	default n
 	help
 	  Enable the bpf() system call that allows to manipulate eBPF
diff --git a/ipc/shm.c b/ipc/shm.c
index b418731d66e8..323a5810a947 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -417,8 +417,11 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
 void shm_destroy_orphaned(struct ipc_namespace *ns)
 {
 	down_write(&shm_ids(ns).rwsem);
-	if (shm_ids(ns).in_use)
+	if (shm_ids(ns).in_use) {
+		rcu_read_lock();
 		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
+		rcu_read_unlock();
+	}
 	up_write(&shm_ids(ns).rwsem);
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6d50e371a2b..75251870430e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1796,12 +1796,29 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
+ * Return -ENOENT if we exhausted all instructions within given state.
+ *
+ * It's legal to have a bit of a looping with the same starting and ending
+ * insn index within the same state, e.g.: 3->4->5->3, so just because current
+ * instruction index is the same as state's first_idx doesn't mean we are
+ * done. If there is still some jump history left, we should keep going. We
+ * need to take into account that we might have a jump history between given
+ * state's parent and itself, due to checkpointing. In this case, we'll have
+ * history entry recording a jump from last instruction of parent state and
+ * first instruction of given state.
  */
 static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
 			     u32 *history)
 {
 	u32 cnt = *history;
 
+	if (i == st->first_insn_idx) {
+		if (cnt == 0)
+			return -ENOENT;
+		if (cnt == 1 && st->jmp_history[0].idx == i)
+			return -ENOENT;
+	}
+
 	if (cnt && st->jmp_history[cnt - 1].idx == i) {
 		i = st->jmp_history[cnt - 1].prev_idx;
 		(*history)--;
@@ -2269,9 +2286,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				 * Nothing to be tracked further in the parent state.
 				 */
 				return 0;
-			if (i == first_idx)
-				break;
 			i = get_prev_insn_idx(st, i, &history);
+			if (i == -ENOENT)
+				break;
 			if (i >= env->prog->len) {
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f19d6ab039e..b133abe23a4b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6628,6 +6628,10 @@ perf_sample_ustack_size(u16 stack_size, u16 header_size,
 	if (!regs)
 		return 0;
 
+	/* No mm, no stack, no dump. */
+	if (!current->mm)
+		return 0;
+
 	/*
 	 * Check if we fit in with the requested stack size into the:
 	 * - TASK_SIZE
@@ -7228,6 +7232,9 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
+	if (!current->mm)
+		user = false;
+
 	if (!kernel && !user)
 		return &__empty_callchain;
 
@@ -9031,14 +9038,14 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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
diff --git a/kernel/exit.c b/kernel/exit.c
index af9c8e794e4d..cfdf2d275bba 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -844,6 +844,15 @@ void __noreturn do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	/*
+	 * Since sampling can touch ->mm, make sure to stop everything before we
+	 * tear it down.
+	 *
+	 * Also flushes inherited counters to the parent - before the parent
+	 * gets woken up by child-exit notifications.
+	 */
+	perf_event_exit_task(tsk);
+
 	exit_mm();
 
 	if (group_dead)
@@ -860,14 +869,6 @@ void __noreturn do_exit(long code)
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
-	/*
-	 * Flush inherited counters to the parent - before the parent
-	 * gets woken up by child-exit notifications.
-	 *
-	 * because of cgroup mode, must be called before cgroup_exit()
-	 */
-	perf_event_exit_task(tsk);
-
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
 
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
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b22508c5d2d9..bd49fec0f624 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -273,7 +273,7 @@ static void clocksource_verify_choose_cpus(void)
 {
 	int cpu, i, n = verify_n_cpus;
 
-	if (n < 0) {
+	if (n < 0 || n >= num_online_cpus()) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
 		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index bede1e608d95..c8bc6722ee95 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1373,6 +1373,15 @@ void run_posix_cpu_timers(void)
 
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
index 6957381b139c..782e64ff839d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1604,7 +1604,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
 	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
 	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(tp_regs->regs))) {
+	if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
 		this_cpu_dec(bpf_raw_tp_nest_level);
 		return ERR_PTR(-EBUSY);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7425989c3a12..5a33ee30b40f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6474,9 +6474,10 @@ void ftrace_release_mod(struct module *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (ftrace_disabled)
-		goto out_unlock;
-
+	/*
+	 * To avoid the UAF problem after the module is unloaded, the
+	 * 'mod_map' resource needs to be released unconditionally.
+	 */
 	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
 		if (mod_map->mod == mod) {
 			list_del_rcu(&mod_map->list);
@@ -6485,6 +6486,9 @@ void ftrace_release_mod(struct module *mod)
 		}
 	}
 
+	if (ftrace_disabled)
+		goto out_unlock;
+
 	/*
 	 * Each module has its own ftrace_pages, remove
 	 * them from the list.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d63d388acffc..42c38a26c801 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6686,7 +6686,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
 					  min((size_t)trace_seq_used(&iter->seq),
-						  PAGE_SIZE));
+						  (size_t)PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
diff --git a/lib/Kconfig b/lib/Kconfig
index 36326864249d..4f280d0d93db 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -692,4 +692,5 @@ config GENERIC_LIB_UCMPDI2
 
 config PLDMFW
 	bool
+	select CRC32
 	default n
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e4c690c21fc9..92550e398e5d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2227,7 +2227,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(freeze && !page);
 	if (page) {
 		VM_WARN_ON_ONCE(!PageLocked(page));
-		if (page != pmd_page(*pmd))
+		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
 			goto out;
 	}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02b7c8f9b0e8..1411c2f34bbf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -96,6 +96,8 @@ static inline void ClearPageHugeFreed(struct page *head)
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, bool take_locks);
 
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
 {
@@ -3700,6 +3702,39 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 	return 0;
 }
 
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
+	 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this
+	 * split, unshare PMDs in the PUD_SIZE interval surrounding addr now.
+	 * This function is called in the middle of a VMA split operation, with
+	 * MM, VMA and rmap all write-locked to prevent concurrent page table
+	 * walks (except hardware and gup_fast()).
+	 */
+	mmap_assert_write_locked(vma->vm_mm);
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+
+	if (addr & ~PUD_MASK) {
+		unsigned long floor = addr & PUD_MASK;
+		unsigned long ceil = floor + PUD_SIZE;
+
+		if (floor >= vma->vm_start && ceil <= vma->vm_end) {
+			/*
+			 * Locking:
+			 * Use take_locks=false here.
+			 * The file rmap lock is already held.
+			 * The hugetlb VMA lock can't be taken when we already
+			 * hold the file rmap lock, and we don't need it because
+			 * its purpose is to synchronize against concurrent page
+			 * table walks, which are not possible thanks to the
+			 * locks held by our caller.
+			 */
+			hugetlb_unshare_pmds(vma, floor, ceil, /* take_locks = */ false);
+		}
+	}
+}
+
 static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
 {
 	struct hstate *hstate = hstate_vma(vma);
@@ -5407,7 +5442,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 			spte = huge_pte_offset(svma->vm_mm, saddr,
 					       vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				atomic_inc(&virt_to_page(spte)->pt_share_count);
 				break;
 			}
 		}
@@ -5422,7 +5457,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		atomic_dec(&virt_to_page(spte)->pt_share_count);
 	}
 	spin_unlock(ptl);
 out:
@@ -5433,11 +5468,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 /*
  * unmap huge page backed by shared pte.
  *
- * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
- * indicated by page_count > 1, unmap is achieved by clearing pud and
- * decrementing the ref count. If count == 1, the pte page is not shared.
- *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
@@ -5445,17 +5476,26 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 					unsigned long *addr, pte_t *ptep)
 {
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 	pgd_t *pgd = pgd_offset(mm, *addr);
 	p4d_t *p4d = p4d_offset(pgd, *addr);
 	pud_t *pud = pud_offset(p4d, *addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-	BUG_ON(page_count(virt_to_page(ptep)) == 0);
-	if (page_count(virt_to_page(ptep)) == 1)
+	if (sz != PMD_SIZE)
+		return 0;
+	if (!atomic_read(&virt_to_page(ptep)->pt_share_count))
 		return 0;
 
 	pud_clear(pud);
-	put_page(virt_to_page(ptep));
+	/*
+	 * Once our caller drops the rmap lock, some other process might be
+	 * using this page table as a normal, non-hugetlb page table.
+	 * Wait for pending gup_fast() in other threads to finish before letting
+	 * that happen.
+	 */
+	tlb_remove_table_sync_one();
+	atomic_dec(&virt_to_page(ptep)->pt_share_count);
 	mm_dec_nr_pmds(mm);
 	/*
 	 * This update of passed address optimizes loops sequentially
@@ -5706,6 +5746,63 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	}
 }
 
+/*
+ * If @take_locks is false, the caller must ensure that no concurrent page table
+ * access can happen (except for gup_fast() and hardware page walks).
+ * If @take_locks is true, we take the hugetlb VMA lock (to lock out things like
+ * concurrent page fault handling) and the file rmap lock.
+ */
+static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
+				   unsigned long start,
+				   unsigned long end,
+				   bool take_locks)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long address;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	if (start >= end)
+		return;
+
+	flush_cache_range(vma, start, end);
+	/*
+	 * No need to call adjust_range_if_pmd_sharing_possible(), because
+	 * we have already done the PUD_SIZE alignment.
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	if (take_locks) {
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	} else {
+		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	}
+	for (address = start; address < end; address += PUD_SIZE) {
+		ptep = huge_pte_offset(mm, address, sz);
+		if (!ptep)
+			continue;
+		ptl = huge_pte_lock(h, mm, ptep);
+		huge_pmd_unshare(mm, vma, &address, ptep);
+		spin_unlock(ptl);
+	}
+	flush_hugetlb_tlb_range(vma, start, end);
+	if (take_locks) {
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/mm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+}
+
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 9f76625a1743..8c188ed3738a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -832,7 +832,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 again:
+	/*
+	 * Get rid of huge pages and shared page tables straddling the split
+	 * boundary.
+	 */
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
+	if (is_vm_hugetlb_page(orig_vma)) {
+		hugetlb_split(orig_vma, start);
+		hugetlb_split(orig_vma, end);
+	}
 
 	if (file) {
 		mapping = file->f_mapping;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b2c916474855..588dd69d117a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -557,8 +557,8 @@ int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
-		writeback_set_ratelimit();
 		vm_dirty_bytes = 0;
+		writeback_set_ratelimit();
 	}
 	return ret;
 }
diff --git a/net/Kconfig b/net/Kconfig
index a22c3fb88564..b0e834410a30 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -311,13 +311,9 @@ config BPF_STREAM_PARSER
 	select STREAM_PARSER
 	select NET_SOCK_MSG
 	help
-	  Enabling this allows a stream parser to be used with
+	  Enabling this allows a TCP stream parser to be used with
 	  BPF_MAP_TYPE_SOCKMAP.
 
-	  BPF_MAP_TYPE_SOCKMAP provides a map type to use with network sockets.
-	  It can be used to enforce socket policy, implement socket redirects,
-	  etc.
-
 config NET_FLOW_LIMIT
 	bool
 	depends on RPS
diff --git a/net/atm/common.c b/net/atm/common.c
index 1cfa9bf1d187..930eb302cd10 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -635,6 +635,7 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
 	if (!copy_from_iter_full(skb_put(skb, size), size, &m->msg_iter)) {
+		atm_return_tx(vcc, skb);
 		kfree_skb(skb);
 		error = -EFAULT;
 		goto out;
diff --git a/net/atm/lec.c b/net/atm/lec.c
index ca9952c52fb5..73078306504c 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -124,6 +124,7 @@ static unsigned char bus_mac[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 /* Device structures */
 static struct net_device *dev_lec[MAX_LEC_ITF];
+static DEFINE_MUTEX(lec_mutex);
 
 #if IS_ENABLED(CONFIG_BRIDGE)
 static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
@@ -687,6 +688,7 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 	int bytes_left;
 	struct atmlec_ioc ioc_data;
 
+	lockdep_assert_held(&lec_mutex);
 	/* Lecd must be up in this case */
 	bytes_left = copy_from_user(&ioc_data, arg, sizeof(struct atmlec_ioc));
 	if (bytes_left != 0)
@@ -712,6 +714,7 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 
 static int lec_mcast_attach(struct atm_vcc *vcc, int arg)
 {
+	lockdep_assert_held(&lec_mutex);
 	if (arg < 0 || arg >= MAX_LEC_ITF)
 		return -EINVAL;
 	arg = array_index_nospec(arg, MAX_LEC_ITF);
@@ -727,6 +730,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 	int i;
 	struct lec_priv *priv;
 
+	lockdep_assert_held(&lec_mutex);
 	if (arg < 0)
 		arg = 0;
 	if (arg >= MAX_LEC_ITF)
@@ -744,6 +748,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		snprintf(dev_lec[i]->name, IFNAMSIZ, "lec%d", i);
 		if (register_netdev(dev_lec[i])) {
 			free_netdev(dev_lec[i]);
+			dev_lec[i] = NULL;
 			return -EINVAL;
 		}
 
@@ -906,7 +911,6 @@ static void *lec_itf_walk(struct lec_state *state, loff_t *l)
 	v = (dev && netdev_priv(dev)) ?
 		lec_priv_walk(state, l, netdev_priv(dev)) : NULL;
 	if (!v && dev) {
-		dev_put(dev);
 		/* Partial state reset for the next time we get called */
 		dev = NULL;
 	}
@@ -930,6 +934,7 @@ static void *lec_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct lec_state *state = seq->private;
 
+	mutex_lock(&lec_mutex);
 	state->itf = 0;
 	state->dev = NULL;
 	state->locked = NULL;
@@ -947,8 +952,9 @@ static void lec_seq_stop(struct seq_file *seq, void *v)
 	if (state->dev) {
 		spin_unlock_irqrestore(&state->locked->lec_arp_lock,
 				       state->flags);
-		dev_put(state->dev);
+		state->dev = NULL;
 	}
+	mutex_unlock(&lec_mutex);
 }
 
 static void *lec_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1005,6 +1011,7 @@ static int lane_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		return -ENOIOCTLCMD;
 	}
 
+	mutex_lock(&lec_mutex);
 	switch (cmd) {
 	case ATMLEC_CTRL:
 		err = lecd_attach(vcc, (int)arg);
@@ -1019,6 +1026,7 @@ static int lane_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
+	mutex_unlock(&lec_mutex);
 	return err;
 }
 
diff --git a/net/atm/raw.c b/net/atm/raw.c
index b3ba44aab0ee..b11ef6dccc31 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -36,7 +36,7 @@ static void atm_pop_raw(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	pr_debug("(%d) %d -= %d\n",
 		 vcc->vci, sk_wmem_alloc_get(sk), ATM_SKB(skb)->acct_truesize);
-	WARN_ON(refcount_sub_and_test(ATM_SKB(skb)->acct_truesize, &sk->sk_wmem_alloc));
+	atm_return_tx(vcc, skb);
 	dev_kfree_skb_any(skb);
 	sk->sk_write_space(sk);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index be281a95a0a8..08d91a3d3460 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5861,7 +5861,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
-		result = L2CAP_CR_LE_AUTHENTICATION;
+		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
+			L2CAP_CR_LE_ENCRYPTION : L2CAP_CR_LE_AUTHENTICATION;
 		chan = NULL;
 		goto response_unlock;
 	}
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index d14b2dbbd1df..abf0c9460ddf 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -59,19 +59,19 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
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
 
diff --git a/net/core/Makefile b/net/core/Makefile
index 3e2c378e5f31..0c2233c826fd 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -16,7 +16,6 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-y += net-sysfs.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
-obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_NETPOLL) += netpoll.o
 obj-$(CONFIG_FIB_RULES) += fib_rules.o
@@ -28,10 +27,13 @@ obj-$(CONFIG_CGROUP_NET_PRIO) += netprio_cgroup.o
 obj-$(CONFIG_CGROUP_NET_CLASSID) += netclassid_cgroup.o
 obj-$(CONFIG_LWTUNNEL) += lwtunnel.o
 obj-$(CONFIG_LWTUNNEL_BPF) += lwt_bpf.o
-obj-$(CONFIG_BPF_STREAM_PARSER) += sock_map.o
 obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_NET_DEVLINK) += devlink.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
 obj-$(CONFIG_FAILOVER) += failover.o
+ifeq ($(CONFIG_INET),y)
+obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
+obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
+endif
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
diff --git a/net/core/filter.c b/net/core/filter.c
index b262cad02bad..2018001d16bf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1953,10 +1953,11 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 	bool is_pseudo = flags & BPF_F_PSEUDO_HDR;
 	bool is_mmzero = flags & BPF_F_MARK_MANGLED_0;
 	bool do_mforce = flags & BPF_F_MARK_ENFORCE;
+	bool is_ipv6   = flags & BPF_F_IPV6;
 	__sum16 *ptr;
 
 	if (unlikely(flags & ~(BPF_F_MARK_MANGLED_0 | BPF_F_MARK_ENFORCE |
-			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK)))
+			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK | BPF_F_IPV6)))
 		return -EINVAL;
 	if (unlikely(offset > 0xffff || offset & 1))
 		return -EFAULT;
@@ -1972,7 +1973,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 890e16bbc072..8680cdfbdb9d 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -664,15 +664,15 @@ static void sk_psock_link_destroy(struct sk_psock *psock)
 	}
 }
 
+static void sk_psock_done_strp(struct sk_psock *psock);
+
 static void sk_psock_destroy_deferred(struct work_struct *gc)
 {
 	struct sk_psock *psock = container_of(gc, struct sk_psock, gc);
 
 	/* No sk_callback_lock since already detached. */
 
-	/* Parser has been stopped */
-	if (psock->progs.skb_parser)
-		strp_done(&psock->parser.strp);
+	sk_psock_done_strp(psock);
 
 	cancel_work_sync(&psock->work);
 
@@ -769,14 +769,6 @@ static int sk_psock_bpf_run(struct sk_psock *psock, struct bpf_prog *prog,
 	return bpf_prog_run_pin_on_cpu(prog, skb);
 }
 
-static struct sk_psock *sk_psock_from_strp(struct strparser *strp)
-{
-	struct sk_psock_parser *parser;
-
-	parser = container_of(strp, struct sk_psock_parser, strp);
-	return container_of(parser, struct sk_psock, parser);
-}
-
 static void sk_psock_skb_redirect(struct sk_buff *skb)
 {
 	struct sk_psock *psock_other;
@@ -880,6 +872,24 @@ static void sk_psock_verdict_apply(struct sk_psock *psock,
 	}
 }
 
+static void sk_psock_write_space(struct sock *sk)
+{
+	struct sk_psock *psock;
+	void (*write_space)(struct sock *sk) = NULL;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (likely(psock)) {
+		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+			schedule_work(&psock->work);
+		write_space = psock->saved_write_space;
+	}
+	rcu_read_unlock();
+	if (write_space)
+		write_space(sk);
+}
+
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 {
 	struct sk_psock *psock;
@@ -912,6 +922,14 @@ static int sk_psock_strp_read_done(struct strparser *strp, int err)
 	return err;
 }
 
+static struct sk_psock *sk_psock_from_strp(struct strparser *strp)
+{
+	struct sk_psock_parser *parser;
+
+	parser = container_of(strp, struct sk_psock_parser, strp);
+	return container_of(parser, struct sk_psock, parser);
+}
+
 static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 {
 	struct sk_psock *psock = sk_psock_from_strp(strp);
@@ -948,6 +966,56 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 	rcu_read_unlock();
 }
 
+int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
+{
+	static const struct strp_callbacks cb = {
+		.rcv_msg	= sk_psock_strp_read,
+		.read_sock_done	= sk_psock_strp_read_done,
+		.parse_msg	= sk_psock_strp_parse,
+	};
+
+	psock->parser.enabled = false;
+	return strp_init(&psock->parser.strp, sk, &cb);
+}
+
+void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
+{
+	struct sk_psock_parser *parser = &psock->parser;
+
+	if (parser->enabled)
+		return;
+
+	parser->saved_data_ready = sk->sk_data_ready;
+	sk->sk_data_ready = sk_psock_strp_data_ready;
+	sk->sk_write_space = sk_psock_write_space;
+	parser->enabled = true;
+}
+
+void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
+{
+	struct sk_psock_parser *parser = &psock->parser;
+
+	if (!parser->enabled)
+		return;
+
+	sk->sk_data_ready = parser->saved_data_ready;
+	parser->saved_data_ready = NULL;
+	strp_stop(&parser->strp);
+	parser->enabled = false;
+}
+
+static void sk_psock_done_strp(struct sk_psock *psock)
+{
+	/* Parser has been stopped */
+	if (psock->progs.skb_parser)
+		strp_done(&psock->parser.strp);
+}
+#else
+static void sk_psock_done_strp(struct sk_psock *psock)
+{
+}
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 static int sk_psock_verdict_recv(read_descriptor_t *desc, struct sk_buff *skb,
 				 unsigned int offset, size_t orig_len)
 {
@@ -1000,35 +1068,6 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 	sock->ops->read_sock(sk, &desc, sk_psock_verdict_recv);
 }
 
-static void sk_psock_write_space(struct sock *sk)
-{
-	struct sk_psock *psock;
-	void (*write_space)(struct sock *sk) = NULL;
-
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (likely(psock)) {
-		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_work(&psock->work);
-		write_space = psock->saved_write_space;
-	}
-	rcu_read_unlock();
-	if (write_space)
-		write_space(sk);
-}
-
-int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
-{
-	static const struct strp_callbacks cb = {
-		.rcv_msg	= sk_psock_strp_read,
-		.read_sock_done	= sk_psock_strp_read_done,
-		.parse_msg	= sk_psock_strp_parse,
-	};
-
-	psock->parser.enabled = false;
-	return strp_init(&psock->parser.strp, sk, &cb);
-}
-
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 {
 	struct sk_psock_parser *parser = &psock->parser;
@@ -1042,32 +1081,6 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 	parser->enabled = true;
 }
 
-void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
-{
-	struct sk_psock_parser *parser = &psock->parser;
-
-	if (parser->enabled)
-		return;
-
-	parser->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_strp_data_ready;
-	sk->sk_write_space = sk_psock_write_space;
-	parser->enabled = true;
-}
-
-void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
-{
-	struct sk_psock_parser *parser = &psock->parser;
-
-	if (!parser->enabled)
-		return;
-
-	sk->sk_data_ready = parser->saved_data_ready;
-	parser->saved_data_ready = NULL;
-	strp_stop(&parser->strp);
-	parser->enabled = false;
-}
-
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 {
 	struct sk_psock_parser *parser = &psock->parser;
diff --git a/net/core/sock.c b/net/core/sock.c
index d5818a5a86fd..3c8b263d2cf2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3433,7 +3433,7 @@ static int assign_proto_idx(struct proto *prot)
 {
 	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
 
-	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
+	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR)) {
 		pr_err("PROTO_INUSE_NR exhausted\n");
 		return -ENOSPC;
 	}
@@ -3444,7 +3444,7 @@ static int assign_proto_idx(struct proto *prot)
 
 static void release_proto_idx(struct proto *prot)
 {
-	if (prot->inuse_idx != PROTO_INUSE_NR - 1)
+	if (prot->inuse_idx != PROTO_INUSE_NR)
 		clear_bit(prot->inuse_idx, proto_inuse_idx);
 }
 #else
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d334a2ccd523..3a9e0046a780 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1506,9 +1506,11 @@ int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	case BPF_SK_MSG_VERDICT:
 		pprog = &progs->msg_parser;
 		break;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	case BPF_SK_SKB_STREAM_PARSER:
 		pprog = &progs->skb_parser;
 		break;
+#endif
 	case BPF_SK_SKB_STREAM_VERDICT:
 		pprog = &progs->skb_verdict;
 		break;
diff --git a/net/core/utils.c b/net/core/utils.c
index 1f31a39236d5..d010fcf1dc08 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 EXPORT_SYMBOL(inet_proto_csum_replace16);
 
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr)
+				     __wsum diff, bool pseudohdr, bool ipv6)
 {
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		*sum = csum_fold(csum_add(diff, ~csum_unfold(*sum)));
-		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
+		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
 			skb->csum = ~csum_add(diff, ~skb->csum);
 	} else if (pseudohdr) {
 		*sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 5b77a46885b9..bbdd9c44f14e 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_TCP_CONG_LP) += tcp_lp.o
 obj-$(CONFIG_TCP_CONG_YEAH) += tcp_yeah.o
 obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
 obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
-obj-$(CONFIG_BPF_STREAM_PARSER) += udp_bpf.o
+obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
 obj-$(CONFIG_NETLABEL) += cipso_ipv4.o
 
 obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fea74ab2a4be..ac2d185c04ef 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -943,7 +943,7 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
 	/* At least one page per NUMA node. */
-	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+	nblocks = max_t(unsigned int, nblocks, num_online_nodes() * PAGE_SIZE / locksz);
 
 	nblocks = roundup_pow_of_two(nblocks);
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a2a7f2597e20..815b6b0089c2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -197,7 +197,11 @@ const __u8 ip_tos2prio[16] = {
 EXPORT_SYMBOL(ip_tos2prio);
 
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
 
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 24ebd51c5e0b..2d870d5e31cf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -476,22 +476,11 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
 	}
 }
 
-static inline bool tcp_stream_is_readable(const struct tcp_sock *tp,
-					  int target, struct sock *sk)
+static bool tcp_stream_is_readable(struct sock *sk, int target)
 {
-	int avail = READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->copied_seq);
-
-	if (avail > 0) {
-		if (avail >= target)
-			return true;
-		if (tcp_rmem_pressure(sk))
-			return true;
-		if (tcp_receive_window(tp) <= inet_csk(sk)->icsk_ack.rcv_mss)
-			return true;
-	}
-	if (sk->sk_prot->stream_memory_read)
-		return sk->sk_prot->stream_memory_read(sk);
-	return false;
+	if (tcp_epollin_ready(sk, target))
+		return true;
+	return sk_is_readable(sk);
 }
 
 /*
@@ -565,7 +554,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		    tp->urg_data)
 			target++;
 
-		if (tcp_stream_is_readable(tp, target, sk))
+		if (tcp_stream_is_readable(sk, target))
 			mask |= EPOLLIN | EPOLLRDNORM;
 
 		if (!(shutdown & SEND_SHUTDOWN)) {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 804464beb343..f97e357e2644 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -232,8 +232,8 @@ int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg,
 }
 EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
 
-#ifdef CONFIG_BPF_STREAM_PARSER
-static bool tcp_bpf_stream_read(const struct sock *sk)
+#ifdef CONFIG_BPF_SYSCALL
+static bool tcp_bpf_sock_is_readable(struct sock *sk)
 {
 	struct sk_psock *psock;
 	bool empty = true;
@@ -582,7 +582,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
-	prot[TCP_BPF_BASE].stream_memory_read	= tcp_bpf_stream_read;
+	prot[TCP_BPF_BASE].sock_is_readable	= tcp_bpf_sock_is_readable;
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
@@ -646,4 +646,4 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 	if (is_insidevar(prot, tcp_bpf_prots))
 		newsk->sk_prot = sk->sk_prot_creator;
 }
-#endif /* CONFIG_BPF_STREAM_PARSER */
+#endif /* CONFIG_BPF_SYSCALL */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7c2e714527f6..82382ac1514f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -640,10 +640,12 @@ EXPORT_SYMBOL(tcp_initialize_rcv_mss);
  */
 static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 {
-	u32 new_sample = tp->rcv_rtt_est.rtt_us;
-	long m = sample;
+	u32 new_sample, old_sample = tp->rcv_rtt_est.rtt_us;
+	long m = sample << 3;
 
-	if (new_sample != 0) {
+	if (old_sample == 0 || m < old_sample) {
+		new_sample = m;
+	} else {
 		/* If we sample in larger samples in the non-timestamp
 		 * case, we could grossly overestimate the RTT especially
 		 * with chatty applications or bulk transfer apps which
@@ -654,17 +656,9 @@ static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 		 * else with timestamps disabled convergence takes too
 		 * long.
 		 */
-		if (!win_dep) {
-			m -= (new_sample >> 3);
-			new_sample += m;
-		} else {
-			m <<= 3;
-			if (m < new_sample)
-				new_sample = m;
-		}
-	} else {
-		/* No previous measure. */
-		new_sample = m << 3;
+		if (win_dep)
+			return;
+		new_sample = old_sample - (old_sample >> 3) + sample;
 	}
 
 	tp->rcv_rtt_est.rtt_us = new_sample;
@@ -2430,20 +2424,33 @@ static inline bool tcp_packet_delayed(const struct tcp_sock *tp)
 {
 	const struct sock *sk = (const struct sock *)tp;
 
-	if (tp->retrans_stamp &&
-	    tcp_tsopt_ecr_before(tp, tp->retrans_stamp))
-		return true;  /* got echoed TS before first retransmission */
+	/* Received an echoed timestamp before the first retransmission? */
+	if (tp->retrans_stamp)
+		return tcp_tsopt_ecr_before(tp, tp->retrans_stamp);
+
+	/* We set tp->retrans_stamp upon the first retransmission of a loss
+	 * recovery episode, so normally if tp->retrans_stamp is 0 then no
+	 * retransmission has happened yet (likely due to TSQ, which can cause
+	 * fast retransmits to be delayed). So if snd_una advanced while
+	 * (tp->retrans_stamp is 0 then apparently a packet was merely delayed,
+	 * not lost. But there are exceptions where we retransmit but then
+	 * clear tp->retrans_stamp, so we check for those exceptions.
+	 */
 
-	/* Check if nothing was retransmitted (retrans_stamp==0), which may
-	 * happen in fast recovery due to TSQ. But we ignore zero retrans_stamp
-	 * in TCP_SYN_SENT, since when we set FLAG_SYN_ACKED we also clear
-	 * retrans_stamp even if we had retransmitted the SYN.
+	/* (1) For non-SACK connections, tcp_is_non_sack_preventing_reopen()
+	 * clears tp->retrans_stamp when snd_una == high_seq.
 	 */
-	if (!tp->retrans_stamp &&	   /* no record of a retransmit/SYN? */
-	    sk->sk_state != TCP_SYN_SENT)  /* not the FLAG_SYN_ACKED case? */
-		return true;  /* nothing was retransmitted */
+	if (!tcp_is_sack(tp) && !before(tp->snd_una, tp->high_seq))
+		return false;
 
-	return false;
+	/* (2) In TCP_SYN_SENT tcp_clean_rtx_queue() clears tp->retrans_stamp
+	 * when setting FLAG_SYN_ACKED is set, even if the SYN was
+	 * retransmitted.
+	 */
+	if (sk->sk_state == TCP_SYN_SENT)
+		return false;
+
+	return true;	/* tp->retrans_stamp is zero; no retransmit yet */
 }
 
 /* Undo procedures. */
@@ -5028,15 +5035,8 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 
 void tcp_data_ready(struct sock *sk)
 {
-	const struct tcp_sock *tp = tcp_sk(sk);
-	int avail = tp->rcv_nxt - tp->copied_seq;
-
-	if (avail < sk->sk_rcvlowat && !tcp_rmem_pressure(sk) &&
-	    !sock_flag(sk, SOCK_DONE) &&
-	    tcp_receive_window(tp) > inet_csk(sk)->icsk_ack.rcv_mss)
-		return;
-
-	sk->sk_data_ready(sk);
+	if (tcp_epollin_ready(sk, sk->sk_rcvlowat) || sock_flag(sk, SOCK_DONE))
+		sk->sk_data_ready(sk);
 }
 
 static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
@@ -6525,6 +6525,9 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
+		if (tp->rx_opt.tstamp_ok)
+			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
+
 		if (req) {
 			tcp_rcv_synrecv_state_fastopen(sk);
 		} else {
@@ -6549,9 +6552,6 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 
-		if (tp->rx_opt.tstamp_ok)
-			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
-
 		if (!inet_csk(sk)->icsk_ca_ops->cong_control)
 			tcp_update_pacing_rate(sk);
 
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index e17e756bb1ad..59997e5d1343 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1210,6 +1210,10 @@ static int calipso_req_setattr(struct request_sock *req,
 	struct ipv6_opt_hdr *old, *new;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	/* sk is NULL for SYN+ACK w/ SYN Cookie */
+	if (!sk)
+		return -ENOMEM;
+
 	if (req_inet->ipv6_opt && req_inet->ipv6_opt->hopopt)
 		old = req_inet->ipv6_opt->hopopt;
 	else
@@ -1250,6 +1254,10 @@ static void calipso_req_delattr(struct request_sock *req)
 	struct ipv6_txoptions *txopts;
 	struct sock *sk = sk_to_full_sk(req_to_sk(req));
 
+	/* sk is NULL for SYN+ACK w/ SYN Cookie */
+	if (!sk)
+		return;
+
 	if (!req_inet->ipv6_opt || !req_inet->ipv6_opt->hopopt)
 		return;
 
diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index 95e9146918cc..b8d43ed4689d 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -86,7 +86,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	case NEXTHDR_UDP:
@@ -97,7 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
-								diff, true);
+								diff, true, true);
 				if (!uh->check)
 					uh->check = CSUM_MANGLED_0;
 			}
@@ -111,7 +111,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	}
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index ab9a279dd6d4..93e1af6c2dfb 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -155,20 +155,20 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
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
index 1a08b00aa321..b7e543d4d57b 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -154,6 +154,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 {
 	const struct nft_fib *priv = nft_expr_priv(expr);
 	int noff = skb_network_offset(pkt->skb);
+	const struct net_device *found = NULL;
 	const struct net_device *oif = NULL;
 	u32 *dest = &regs->data[priv->dreg];
 	struct ipv6hdr *iph, _iph;
@@ -198,11 +199,15 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
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
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 4848e3c2f0af..a8e80cb6a5ce 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -620,7 +620,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				mesh_path_add_gate(mpath);
 		}
 		rcu_read_unlock();
-	} else {
+	} else if (ifmsh->mshcfg.dot11MeshForwarding) {
 		rcu_read_lock();
 		mpath = mesh_path_lookup(sdata, target_addr);
 		if (mpath) {
@@ -638,6 +638,8 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 		rcu_read_unlock();
+	} else {
+		forward = false;
 	}
 
 	if (reply) {
@@ -655,7 +657,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (forward && ifmsh->mshcfg.dot11MeshForwarding) {
+	if (forward) {
 		u32 preq_id;
 		u8 hopcount;
 
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 1dcbdab9319b..fa095bc8b0c1 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -80,8 +80,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
 
 	if (index < net->mpls.platform_labels) {
 		struct mpls_route __rcu **platform_label =
-			rcu_dereference(net->mpls.platform_label);
-		rt = rcu_dereference(platform_label[index]);
+			rcu_dereference_rtnl(net->mpls.platform_label);
+		rt = rcu_dereference_rtnl(platform_label[index]);
 	}
 	return rt;
 }
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index dea60e25e860..c61d2e2e93ad 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -140,16 +140,15 @@ struct ncsi_channel_vlan_filter {
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
@@ -178,7 +177,7 @@ struct ncsi_channel_stats {
 	u32 hnc_tx_1023_frames;	/* Tx 512-1023 bytes frames   */
 	u32 hnc_tx_1522_frames;	/* Tx 1024-1522 bytes frames  */
 	u32 hnc_tx_9022_frames;	/* Tx 1523-9022 bytes frames  */
-	u32 hnc_rx_valid_bytes;	/* Rx valid bytes             */
+	u64 hnc_rx_valid_bytes;	/* Rx valid bytes             */
 	u32 hnc_rx_runt_pkts;	/* Rx error runt packets      */
 	u32 hnc_rx_jabber_pkts;	/* Rx error jabber packets    */
 	u32 ncsi_rx_cmds;	/* Rx NCSI commands           */
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 3fbea7e74fb1..2729581360ec 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -246,16 +246,15 @@ struct ncsi_rsp_gp_pkt {
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
@@ -284,11 +283,11 @@ struct ncsi_rsp_gcps_pkt {
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
index 960e2cfc1fd2..88fb86cf7b20 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -933,16 +933,15 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 
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
@@ -971,7 +970,7 @@ static int ncsi_rsp_handler_gcps(struct ncsi_request *nr)
 	ncs->hnc_tx_1023_frames = ntohl(rsp->tx_1023_frames);
 	ncs->hnc_tx_1522_frames = ntohl(rsp->tx_1522_frames);
 	ncs->hnc_tx_9022_frames = ntohl(rsp->tx_9022_frames);
-	ncs->hnc_rx_valid_bytes = ntohl(rsp->rx_valid_bytes);
+	ncs->hnc_rx_valid_bytes = be64_to_cpu(rsp->rx_valid_bytes);
 	ncs->hnc_rx_runt_pkts   = ntohl(rsp->rx_runt_pkts);
 	ncs->hnc_rx_jabber_pkts = ntohl(rsp->rx_jabber_pkts);
 
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 826e5f8c78f3..07e73e50b713 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -88,13 +88,13 @@ static void nft_socket_eval(const struct nft_expr *expr,
 			*dest = sk->sk_mark;
 		} else {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		break;
 	case NFT_SOCKET_WILDCARD:
 		if (!sk_fullsock(sk)) {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		nft_socket_wildcard(pkt, regs, sk, dest);
 		break;
@@ -103,6 +103,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		regs->verdict.code = NFT_BREAK;
 	}
 
+out_put_sk:
 	if (sk != skb->sk)
 		sock_gen_put(sk);
 }
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index cfe6cf1be421..95f823032228 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -588,10 +588,10 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
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
@@ -601,8 +601,8 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 				    opt->length * 4, opt->opt_data))
 				goto inner_failure;
 			offset += sizeof(*opt) + opt->length * 4;
+			nla_nest_end(skb, inner);
 		}
-		nla_nest_end(skb, inner);
 	}
 	nla_nest_end(skb, nest);
 	return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 96059c99b915..19325925941f 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1140,6 +1140,11 @@ int netlbl_conn_setattr(struct sock *sk,
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
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 1204c438e87d..03a51bcb9c37 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -131,22 +131,22 @@ static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
 
 	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
 	nu->tty = tty;
-	tty->disc_data = nu;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
 	spin_lock_init(&nu->rx_lock);
 
 	ret = nu->ops.open(nu);
 	if (ret) {
-		tty->disc_data = NULL;
 		kfree(nu);
+		return ret;
 	} else if (!try_module_get(nu->owner)) {
 		nu->ops.close(nu);
-		tty->disc_data = NULL;
 		kfree(nu);
 		return -ENOENT;
 	}
-	return ret;
+	tty->disc_data = nu;
+
+	return 0;
 }
 
 /* ------ LDISC part ------ */
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 9bad601c7fe8..94531289ed26 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -638,7 +638,7 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
 			memset(&key->ipv4, 0, sizeof(key->ipv4));
 		}
 	} else if (eth_p_mpls(key->eth.type)) {
-		u8 label_count = 1;
+		size_t label_count = 1;
 
 		memset(&key->mpls, 0, sizeof(key->mpls));
 		skb_set_inner_network_header(skb, skb->mac_len);
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 35b8577aef7d..4f4da11a2c77 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -298,7 +298,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	 * to remove them.
 	 */
 	if (!ets_class_is_strict(q, cl) && sch->q.qlen)
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 }
 
 static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
@@ -499,7 +499,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			if (unlikely(!skb))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
@@ -674,8 +674,8 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del(&q->classes[i].alist);
-		qdisc_tree_flush_backlog(q->classes[i].qdisc);
+			list_del_init(&q->classes[i].alist);
+		qdisc_purge_queue(q->classes[i].qdisc);
 	}
 	q->nstrict = nstrict;
 	memcpy(q->prio2band, priomap, sizeof(priomap));
@@ -723,7 +723,7 @@ static void ets_qdisc_reset(struct Qdisc *sch)
 
 	for (band = q->nstrict; band < q->nbands; band++) {
 		if (q->classes[band].qdisc->q.qlen)
-			list_del(&q->classes[band].alist);
+			list_del_init(&q->classes[band].alist);
 	}
 	for (band = 0; band < q->nbands; band++)
 		qdisc_reset(q->classes[band].qdisc);
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 1c805fe05b82..3d92497af01f 100644
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
index 935d90874b1b..1b69b7b90d85 100644
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
index 066754a18569..e87560e24486 100644
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
@@ -317,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
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
@@ -456,7 +452,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->scaled_quantum;
+		slot->allot = q->quantum;
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -493,7 +489,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->scaled_quantum;
+		slot->allot += q->quantum;
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -512,7 +508,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -= qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -595,7 +591,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->scaled_quantum;
+			slot->allot = q->quantum;
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -608,6 +604,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	spin_lock(root_lock);
@@ -616,11 +613,16 @@ static void sfq_perturbation(struct timer_list *t)
 		sfq_rehash(sch);
 	spin_unlock(root_lock);
 
-	if (q->perturb_period)
-		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	/* q->perturb_period can change under us from
+	 * sfq_change() and sfq_destroy().
+	 */
+	period = READ_ONCE(q->perturb_period);
+	if (period)
+		mod_timer(&q->perturb_timer, jiffies + period);
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -629,6 +631,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -638,14 +649,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
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
@@ -654,38 +661,65 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		if (!p)
 			return -ENOMEM;
 	}
+
 	sch_tree_lock(sch);
-	if (ctl->quantum) {
-		q->quantum = ctl->quantum;
-		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
-	}
-	q->perturb_period = ctl->perturb_period * HZ;
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
+	if (ctl->quantum)
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
+	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
 	}
 
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
+
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
 		dropped += sfq_drop(sch, &to_free);
@@ -721,7 +755,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
@@ -754,12 +788,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -870,7 +903,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 5f50fdeaafa8..411970dc07f7 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -437,7 +437,7 @@ static int tbf_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 	if (child) {
-		qdisc_tree_flush_backlog(q->qdisc);
+		qdisc_purge_queue(q->qdisc);
 		old = q->qdisc;
 		q->qdisc = child;
 	}
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 3d6c9e35781e..196196ebe81a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8849,7 +8849,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
 		wq = rcu_dereference(sk->sk_wq);
 		if (wq) {
 			if (waitqueue_active(&wq->wait))
-				wake_up_interruptible(&wq->wait);
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
 
 			/* Note that we try to include the Async I/O support
 			 * here by modeling from the current TCP/UDP code.
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 486c466ab466..81a780c1226c 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -133,6 +133,8 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 
 	hlist_add_head_rcu(&new->cache_list, head);
 	detail->entries++;
+	if (detail->nextcheck > new->expiry_time)
+		detail->nextcheck = new->expiry_time + 1;
 	cache_get(new);
 	spin_unlock(&detail->hash_lock);
 
@@ -449,24 +451,21 @@ static int cache_clean(void)
 		}
 	}
 
+	spin_lock(&current_detail->hash_lock);
+
 	/* find a non-empty bucket in the table */
-	while (current_detail &&
-	       current_index < current_detail->hash_size &&
+	while (current_index < current_detail->hash_size &&
 	       hlist_empty(&current_detail->hash_table[current_index]))
 		current_index++;
 
 	/* find a cleanable entry in the bucket and clean it, or set to next bucket */
-
-	if (current_detail && current_index < current_detail->hash_size) {
+	if (current_index < current_detail->hash_size) {
 		struct cache_head *ch = NULL;
 		struct cache_detail *d;
 		struct hlist_head *head;
 		struct hlist_node *tmp;
 
-		spin_lock(&current_detail->hash_lock);
-
 		/* Ok, now to clean this strand */
-
 		head = &current_detail->hash_table[current_index];
 		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
 			if (current_detail->nextcheck > ch->expiry_time)
@@ -487,8 +486,10 @@ static int cache_clean(void)
 		spin_unlock(&cache_list_lock);
 		if (ch)
 			sunrpc_end_cache_remove_entry(ch, d);
-	} else
+	} else {
+		spin_unlock(&current_detail->hash_lock);
 		spin_unlock(&cache_list_lock);
+	}
 
 	return rv;
 }
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 159d891b81c5..cc409d55e157 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -419,7 +419,7 @@ static void tipc_aead_free(struct rcu_head *rp)
 	}
 	free_percpu(aead->tfm_entry);
 	kfree_sensitive(aead->key);
-	kfree(aead);
+	kfree_sensitive(aead);
 }
 
 static int tipc_aead_users(struct tipc_aead __rcu *aead)
@@ -822,7 +822,11 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
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
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 25e733919131..881f4c160dbf 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -481,7 +481,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = tipc_bearer_find(net, bname);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
@@ -492,7 +492,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = rtnl_dereference(tn->bearer_list[bid]);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9d7b52370155..63517995c692 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -731,12 +731,12 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
 	prot[TLS_BASE][TLS_SW] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_BASE][TLS_SW].recvmsg		  = tls_sw_recvmsg;
-	prot[TLS_BASE][TLS_SW].stream_memory_read = tls_sw_stream_read;
+	prot[TLS_BASE][TLS_SW].sock_is_readable   = tls_sw_sock_is_readable;
 	prot[TLS_BASE][TLS_SW].close		  = tls_sk_proto_close;
 
 	prot[TLS_SW][TLS_SW] = prot[TLS_SW][TLS_BASE];
 	prot[TLS_SW][TLS_SW].recvmsg		= tls_sw_recvmsg;
-	prot[TLS_SW][TLS_SW].stream_memory_read	= tls_sw_stream_read;
+	prot[TLS_SW][TLS_SW].sock_is_readable   = tls_sw_sock_is_readable;
 	prot[TLS_SW][TLS_SW].close		= tls_sk_proto_close;
 
 #ifdef CONFIG_TLS_DEVICE
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index ec57ca01b3c4..7a448fd96f81 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -859,6 +859,13 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		err = tcp_bpf_sendmsg_redir(sk_redir, &msg_redir, send, flags);
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
@@ -2040,7 +2047,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	return copied ? : err;
 }
 
-bool tls_sw_stream_read(const struct sock *sk)
+bool tls_sw_sock_is_readable(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 25696de8114a..3e5c8d09d82c 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -101,16 +101,16 @@ try-run = $(shell set -e;		\
 	fi)
 
 # as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+# Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 6d37cb780452..65a0ae119262 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -33,7 +33,7 @@ ld-option = $(success,$(LD) -v $(1))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler-with-cpp -o /dev/null -)
 
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)
diff --git a/scripts/as-version.sh b/scripts/as-version.sh
index 532270bd4b7e..68e9344c1bca 100755
--- a/scripts/as-version.sh
+++ b/scripts/as-version.sh
@@ -45,7 +45,7 @@ orig_args="$@"
 # Get the first line of the --version output.
 IFS='
 '
-set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler /dev/null -o /dev/null 2>/dev/null)
+set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler-with-cpp /dev/null -o /dev/null 2>/dev/null)
 
 # Split the line on spaces.
 IFS=' '
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 114245b6f7c7..5b315e3e8dc3 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -95,7 +95,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 
 	ctx->ctx_doi = XFRM_SC_DOI_LSM;
 	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
-	ctx->ctx_len = str_len;
+	ctx->ctx_len = str_len + 1;
 	memcpy(ctx->ctx_str, &uctx[1], str_len);
 	ctx->ctx_str[str_len] = '\0';
 	rc = security_context_to_sid(&selinux_state, ctx->ctx_str, str_len,
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 407bbf9264ac..dd7c7cb0de14 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2295,6 +2295,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	/* Dell ALC3271 */
 	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=220210 */
+	SND_PCI_QUIRK(0x17aa, 0x5079, "Lenovo Thinkpad E15", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b2df53215279..2c289a42d178 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9151,6 +9151,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0871, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0872, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x0879, "Dell Latitude 5420 Rugged", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x08ad, "Dell WYSE AIO", ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x08ae, "Dell WYSE NB", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0935, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 1928c1616a52..629cc24d51c3 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -158,11 +158,37 @@ static const struct snd_kcontrol_new isense_switch =
 static const struct snd_kcontrol_new vsense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2770_PWR_CTRL, 2, 1, 1);
 
+static int sense_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Powering up ISENSE/VSENSE requires a trip through the shutdown state.
+	 * Do that here to ensure that our changes are applied properly, otherwise
+	 * we might end up with non-functional IVSENSE if playback started earlier,
+	 * which would break software speaker protection.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_REG:
+		return snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						    TAS2770_PWR_CTRL_MASK,
+						    TAS2770_PWR_CTRL_SHUTDOWN);
+	case SND_SOC_DAPM_POST_REG:
+		return tas2770_update_pwr_ctrl(tas2770);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget tas2770_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2770_asi1_mux),
-	SND_SOC_DAPM_SWITCH("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch),
-	SND_SOC_DAPM_SWITCH("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch),
+	SND_SOC_DAPM_SWITCH_E("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2770_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 0e2691f011b7..150e12037dfe 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -245,7 +245,7 @@ static int meson_card_parse_of_optional(struct snd_soc_card *card,
 						    const char *p))
 {
 	/* If property is not provided, don't fail ... */
-	if (!of_property_read_bool(card->dev->of_node, propname))
+	if (!of_property_present(card->dev->of_node, propname))
 		return 0;
 
 	/* ... but do fail if it is provided and the parsing fails */
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 6be7a32933ad..8a63cf03eb3a 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -78,6 +78,10 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 		else
 			ret = snd_soc_dai_set_channel_map(cpu_dai, tx_ch_cnt,
 							  tx_ch, 0, NULL);
+		if (ret != 0 && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "failed to set cpu chan map, err:%d\n", ret);
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index 1b2f7cb8c6ad..686c8ff46ec8 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -607,6 +607,8 @@ static int tegra_ahub_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ahub->soc_data = of_device_get_match_data(&pdev->dev);
+	if (!ahub->soc_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, ahub);
 
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index a973e02babf5..08082fdf8218 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -367,6 +367,13 @@ static const struct usbmix_name_map corsair_virtuoso_map[] = {
 	{ 0 }
 };
 
+/* KTMicro USB */
+static struct usbmix_name_map s31b2_0022_map[] = {
+	{ 23, "Speaker Playback" },
+	{ 18, "Headphone Playback" },
+	{ 0 }
+};
+
 /* ASUS ROG Zenith II with Realtek ALC1220-VB */
 static const struct usbmix_name_map asus_zenith_ii_map[] = {
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad - broken response, disabled */
@@ -649,6 +656,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x1395, 0x0025),
 		.map = sennheiser_pc8_map,
 	},
+	{
+		/* KTMicro USB */
+		.id = USB_ID(0X31b2, 0x0022),
+		.map = s31b2_0022_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63ea5bc6f1c4..66c490c8d908 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -909,6 +909,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -3937,6 +3938,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index 1a04299a2a60..35ad5a845a14 100644
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
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 89905b4e9309..e9edf29026ed 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -521,6 +521,8 @@ ifndef NO_LIBELF
     ifeq ($(feature-libdebuginfod), 1)
       CFLAGS += -DHAVE_DEBUGINFOD_SUPPORT
       EXTLIBS += -ldebuginfod
+    else
+      $(warning No elfutils/debuginfod.h found, no debuginfo server support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent)
     endif
   endif
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 167cd8d3b7a2..42f6ec953b7c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2516,7 +2516,7 @@ static struct option __record_options[] = {
 		    "sample selected machine registers on interrupt,"
 		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
-		    "sample selected machine registers on interrupt,"
+		    "sample selected machine registers in user space,"
 		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 711d4f9f5645..4cea374b284c 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -679,7 +679,10 @@ class CallGraphModelBase(TreeModel):
 				s = value.replace("%", "\%")
 				s = s.replace("_", "\_")
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
index db5e1f70053a..7b28d468fc6e 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -255,7 +255,7 @@ static int compar(const void *a, const void *b)
 	const struct event_node *nodeb = b;
 	s64 cmp = nodea->event_time - nodeb->event_time;
 
-	return cmp;
+	return cmp < 0 ? -1 : (cmp > 0 ? 1 : 0);
 }
 
 static int process_events(struct evlist *evlist,
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f2586e46d53e..19e79e159996 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3241,10 +3241,10 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
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
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 413a7b9f3c4d..7f62635226fd 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3081,12 +3081,15 @@ TEST(syscall_restart)
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
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 703a255cddc6..c53dcf3e5aba 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
 # In theory, we do not care -m32 or -m64 for header compile tests.
 # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
-UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
+UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 

