Return-Path: <stable+bounces-179122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D397B5041B
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E893B20A1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C53680AF;
	Tue,  9 Sep 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8NRijqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40648335BB2;
	Tue,  9 Sep 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437885; cv=none; b=BBvqGH+MolmVOB6F50zj5Zx/jleirZeRTiL8k4/F66YAtDjTzL2tvLbPPyA3Eyn7sQJ+rOdW9ne449Ty6uKZkckEnxhOldUoMwYqUcq89qfLCqS+gXDTOKlL46Ej8rr6zqtx1ViNzMcrhN15bfwlTvGHoej+dc/fztMdYgykDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437885; c=relaxed/simple;
	bh=Kd45cCcP7UxoHmj89AbjDoFE2P/ODgEDhp4RO3bzk1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUkxKiWqCV88OjXcDFICiJ6K3XhZKnUaWjPZKM0DHJi470x4oVV100vVhGqKgvl71KKl15CsoQ24HRULbtbw6s2kPYaatkeIxseW02zFCSjcyFWrG+NgwGMsQB51xZp2/oGCxF34FnvilVjbuSC3PTufcc9WgAJHLMucZbFddr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8NRijqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4784CC4AF0B;
	Tue,  9 Sep 2025 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437884;
	bh=Kd45cCcP7UxoHmj89AbjDoFE2P/ODgEDhp4RO3bzk1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y8NRijqhsKdHZ10UdKV0lWFQxV+oKCVgJpAk2TND712VniTciqZXLsSJ2AJy36ONF
	 D3e2FjlLjLLHXUyfDoeVckBhASU7mMnWCaHpoeHrEmkpSbhE1ktrGKycbxGynvrp+F
	 tPb++SQZmAfmOoGQxMslPNHIZyIbPbm8ypXUulHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.16.6
Date: Tue,  9 Sep 2025 19:11:11 +0200
Message-ID: <2025090911-rebuilt-self-37c4@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090911-tactics-molar-588d@gregkh>
References: <2025090911-tactics-molar-588d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 58a78d215577..0200497da26c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 16
-SUBLEVEL = 5
+SUBLEVEL = 6
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 53a657cf4efb..dfe1f0616a81 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -352,6 +352,8 @@ &rtt {
 
 &sdmmc1 {
 	bus-width = <4>;
+	no-1-8-v;
+	sdhci-caps-mask = <0x0 0x00200000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index d0fc5977258f..16078ff60ef0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -555,6 +555,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
index 7f754e0a5d69..68c2e0156a5c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
@@ -609,6 +609,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts
index d7fd9d36f824..f7346b3d35fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts
@@ -467,6 +467,10 @@ &pwm4 {
 	status = "okay";
 };
 
+&reg_usdhc2_vqmmc {
+	status = "okay";
+};
+
 &sai5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai5>;
@@ -876,8 +880,7 @@ pinctrl_usdhc2: usdhc2grp {
 			   <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d2>,
 			   <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d2>,
 			   <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d2>,
-			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d2>,
-			   <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0>;
+			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d2>;
 	};
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
@@ -886,8 +889,7 @@ pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 			   <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4>,
-			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>,
-			   <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0>;
+			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>;
 	};
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
@@ -896,8 +898,7 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 			   <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4>,
-			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>,
-			   <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0>;
+			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>;
 	};
 
 	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index 23c612e80dd3..092b1b65a88c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -603,6 +603,10 @@ &pwm3 {
 	status = "okay";
 };
 
+&reg_usdhc2_vqmmc {
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -982,8 +986,7 @@ pinctrl_usdhc2: usdhc2grp {
 			   <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d2>,
 			   <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d2>,
 			   <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d2>,
-			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d2>,
-			   <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0>;
+			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d2>;
 	};
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
@@ -992,8 +995,7 @@ pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 			   <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4>,
-			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>,
-			   <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0>;
+			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>;
 	};
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
@@ -1002,8 +1004,7 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 			   <MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4>,
 			   <MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4>,
-			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>,
-			   <MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0>;
+			   <MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4>;
 	};
 
 	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
index 6067ca3be814..0a592fa2d8bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
@@ -24,6 +24,20 @@ reg_vcc3v3: regulator-vcc3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vqmmc>;
+		regulator-name = "V_SD2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+		vin-supply = <&ldo5_reg>;
+		status = "disabled";
+	};
 };
 
 &A53_0 {
@@ -180,6 +194,10 @@ m24c64: eeprom@57 {
 	};
 };
 
+&usdhc2 {
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+};
+
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -229,6 +247,10 @@ pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x10>;
 	};
 
+	pinctrl_reg_usdhc2_vqmmc: regusdhc2vqmmcgrp {
+		fsl,pins = <MX8MP_IOMUXC_GPIO1_IO04__GPIO1_IO04		0xc0>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194>,
 			   <MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5473070823cb..6cadde440fff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -966,6 +966,7 @@ spiflash: flash@0 {
 		reg = <0>;
 		m25p,fast-read;
 		spi-max-frequency = <10000000>;
+		vcc-supply = <&vcc_3v0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
index e04f21d8c831..431ff77d4518 100644
--- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
@@ -250,6 +250,7 @@ eeprom@50 {
 		compatible = "belling,bl24c16a", "atmel,24c16";
 		reg = <0x50>;
 		pagesize = <16>;
+		read-only;
 		vcc-supply = <&vcc_3v3_pmu>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 121e4d1c3fa5..8222f1fae8fa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -77,7 +77,7 @@ &analog_sound {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hp_detect>;
 	simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
-	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
+	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
 	simple-audio-card,widgets =
 		"Microphone", "Onboard Microphone",
 		"Microphone", "Microphone Jack",
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
index 91d56c34a1e4..8a8f3b26754d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
@@ -365,6 +365,8 @@ &sdhci {
 	max-frequency = <200000000>;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..fb9b88eebeb1 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -19,6 +19,7 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
+	struct plt_entry	*init_ftrace_trampolines;
 };
 
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index b9ae8349e35d..fb944b46846d 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -2,6 +2,7 @@ SECTIONS {
 	.plt 0 : { BYTE(0) }
 	.init.plt 0 : { BYTE(0) }
 	.text.ftrace_trampoline 0 : { BYTE(0) }
+	.init.text.ftrace_trampoline 0 : { BYTE(0) }
 
 #ifdef CONFIG_KASAN_SW_TAGS
 	/*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5a890714ee2e..5adad37ab4fa 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -258,10 +258,17 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod)
+static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 {
 #ifdef CONFIG_MODULES
-	struct plt_entry *plt = mod->arch.ftrace_trampolines;
+	struct plt_entry *plt = NULL;
+
+	if (within_module_mem_type(addr, mod, MOD_INIT_TEXT))
+		plt = mod->arch.init_ftrace_trampolines;
+	else if (within_module_mem_type(addr, mod, MOD_TEXT))
+		plt = mod->arch.ftrace_trampolines;
+	else
+		return NULL;
 
 	return &plt[FTRACE_PLT_IDX];
 #else
@@ -332,7 +339,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod);
+	plt = get_ftrace_plt(mod, pc);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index bde32979c06a..7afd370da9f4 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -283,7 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned long core_plts = 0;
 	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
-	Elf_Shdr *pltsec, *tramp = NULL;
+	Elf_Shdr *pltsec, *tramp = NULL, *init_tramp = NULL;
 	int i;
 
 	/*
@@ -298,6 +298,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		else if (!strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name,
+				 ".init.text.ftrace_trampoline"))
+			init_tramp = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
@@ -363,5 +366,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
 	}
 
+	if (init_tramp) {
+		init_tramp->sh_type = SHT_NOBITS;
+		init_tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+		init_tramp->sh_addralign = __alignof__(struct plt_entry);
+		init_tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
+	}
+
 	return 0;
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 06bb680bfe97..8b6f5cd58883 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -453,6 +453,17 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
 	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
 
 	mod->arch.ftrace_trampolines = plts;
+
+	s = find_section(hdr, sechdrs, ".init.text.ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	plts = (void *)s->sh_addr;
+
+	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
+
+	mod->arch.init_ftrace_trampolines = plts;
+
 #endif
 	return 0;
 }
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 4740cb5b2388..c9f7ca778364 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -677,6 +677,11 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
 	for (i = 1; i < 32; i++)
 		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
 
+#ifdef CONFIG_CPU_HAS_LBT
+	if (extctx->lbt.addr)
+		err |= protected_save_lbt_context(extctx);
+#endif
+
 	if (extctx->lasx.addr)
 		err |= protected_save_lasx_context(extctx);
 	else if (extctx->lsx.addr)
@@ -684,11 +689,6 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
 	else if (extctx->fpu.addr)
 		err |= protected_save_fpu_context(extctx);
 
-#ifdef CONFIG_CPU_HAS_LBT
-	if (extctx->lbt.addr)
-		err |= protected_save_lbt_context(extctx);
-#endif
-
 	/* Set the "end" magic */
 	info = (struct sctx_info *)extctx->end.addr;
 	err |= __put_user(0, &info->magic);
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 367906b10f81..f3092f2de8b5 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/clockchips.h>
+#include <linux/cpuhotplug.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -102,6 +103,23 @@ static int constant_timer_next_event(unsigned long delta, struct clock_event_dev
 	return 0;
 }
 
+static int arch_timer_starting(unsigned int cpu)
+{
+	set_csr_ecfg(ECFGF_TIMER);
+
+	return 0;
+}
+
+static int arch_timer_dying(unsigned int cpu)
+{
+	constant_set_state_shutdown(this_cpu_ptr(&constant_clockevent_device));
+
+	/* Clear Timer Interrupt */
+	write_csr_tintclear(CSR_TINTCLR_TI);
+
+	return 0;
+}
+
 static unsigned long get_loops_per_jiffy(void)
 {
 	unsigned long lpj = (unsigned long)const_clock_freq;
@@ -172,6 +190,10 @@ int constant_clockevent_init(void)
 	lpj_fine = get_loops_per_jiffy();
 	pr_info("Constant clock event device register\n");
 
+	cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
+			  "clockevents/loongarch/timer:starting",
+			  arch_timer_starting, arch_timer_dying);
+
 	return 0;
 }
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1c5544401530..b29eff4ace2d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -69,7 +69,7 @@ config RISCV
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	# LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
-	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
+	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000 && CMODEL_MEDANY
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index a8a2af6dfe9d..2a16e88e13de 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,7 +91,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU_NUM(tp)
+	lw    \tmp, TASK_TI_CPU_NUM(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index b88a6218b7f2..f5f4f7f85543 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -209,7 +209,7 @@ do {									\
 		err = 0;						\
 		break;							\
 __gu_failed:								\
-		x = 0;							\
+		x = (__typeof__(x))0;					\
 		err = -EFAULT;						\
 } while (0)
 
@@ -311,7 +311,7 @@ do {								\
 do {								\
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&	\
 	    !IS_ALIGNED((uintptr_t)__gu_ptr, sizeof(*__gu_ptr))) {	\
-		__inttype(x) ___val = (__inttype(x))x;			\
+		__typeof__(*(__gu_ptr)) ___val = (x);		\
 		if (__asm_copy_to_user_sum_enabled(__gu_ptr, &(___val), sizeof(*__gu_ptr))) \
 			goto label;				\
 		break;						\
@@ -438,10 +438,10 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
-	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
+	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
-	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
+	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 75656afa2d6b..4fdf187a62bf 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -46,7 +46,7 @@
 	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
 	 * a1 = BIT_MASK(cpu)
 	 */
-	REG_L 	a2, TASK_TI_CPU(tp)
+	lw	a2, TASK_TI_CPU(tp)
 	/*
 	 * Compute the new_vmalloc element position:
 	 * (cpu / 64) * 8 = (cpu >> 6) << 3
diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
index f4755d49b89e..a00aa92c824f 100644
--- a/arch/riscv/kernel/kexec_elf.c
+++ b/arch/riscv/kernel/kexec_elf.c
@@ -28,7 +28,7 @@ static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 	int i;
 	int ret = 0;
 	size_t size;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	const struct elf_phdr *phdr;
 
 	kbuf.image = image;
@@ -66,7 +66,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 {
 	int i;
 	int ret;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	const struct elf_phdr *phdr;
 	unsigned long lowest_paddr = ULONG_MAX;
 	unsigned long lowest_vaddr = ULONG_MAX;
diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
index 26a81774a78a..8f2eb900910b 100644
--- a/arch/riscv/kernel/kexec_image.c
+++ b/arch/riscv/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct riscv_image_header *h;
 	u64 flags;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	int ret;
 
 	/* Check Image header */
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index e36104af2e24..b9eb41b0a975 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -261,7 +261,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	int ret;
 	void *fdt;
 	unsigned long initrd_pbase = 0UL;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	char *modified_cmdline = NULL;
 
 	kbuf.image = image;
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 10e01ff06312..9883a55d61b5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1356,7 +1356,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
 			/* Load current CPU number in T1 */
-			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			/* Load address of __per_cpu_offset array in T2 */
 			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
@@ -1763,7 +1763,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
 			/* Load current CPU number in R0 */
-			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
+			emit_lw(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			break;
 		}
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 4604f924d8b8..7eb61ef6a185 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -36,6 +36,9 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..458e5148d69e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -223,6 +223,24 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+/*
+ * Make kernel mappings visible in all page tables in the system.
+ * This is necessary except when the init task populates kernel mappings
+ * during the boot process. In that case, all processes originating from
+ * the init task copies the kernel mappings, so there is no issue.
+ * Otherwise, missing synchronization could lead to kernel crashes due
+ * to missing page table entries for certain kernel mappings.
+ *
+ * Synchronization is performed at the top level, which is the PGD in
+ * 5-level paging systems. But in 4-level paging systems, however,
+ * pgd_populate() is a no-op, so synchronization is done at the P4D level.
+ * sync_global_pgds() handles this difference between paging levels.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 0e7748c5e117..83a9f99ea7f9 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -677,7 +677,7 @@ static void ivpu_bo_unbind_all_user_contexts(struct ivpu_device *vdev)
 static void ivpu_dev_fini(struct ivpu_device *vdev)
 {
 	ivpu_jobs_abort_all(vdev);
-	ivpu_pm_cancel_recovery(vdev);
+	ivpu_pm_disable_recovery(vdev);
 	ivpu_pm_disable(vdev);
 	ivpu_prepare_for_reset(vdev);
 	ivpu_shutdown(vdev);
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index ea30db181cd7..d2c6cebdc901 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -408,10 +408,10 @@ void ivpu_pm_init(struct ivpu_device *vdev)
 	ivpu_dbg(vdev, PM, "Autosuspend delay = %d\n", delay);
 }
 
-void ivpu_pm_cancel_recovery(struct ivpu_device *vdev)
+void ivpu_pm_disable_recovery(struct ivpu_device *vdev)
 {
 	drm_WARN_ON(&vdev->drm, delayed_work_pending(&vdev->pm->job_timeout_work));
-	cancel_work_sync(&vdev->pm->recovery_work);
+	disable_work_sync(&vdev->pm->recovery_work);
 }
 
 void ivpu_pm_enable(struct ivpu_device *vdev)
diff --git a/drivers/accel/ivpu/ivpu_pm.h b/drivers/accel/ivpu/ivpu_pm.h
index 89b264cc0e3e..a2aa7a27f32e 100644
--- a/drivers/accel/ivpu/ivpu_pm.h
+++ b/drivers/accel/ivpu/ivpu_pm.h
@@ -25,7 +25,7 @@ struct ivpu_pm_info {
 void ivpu_pm_init(struct ivpu_device *vdev);
 void ivpu_pm_enable(struct ivpu_device *vdev);
 void ivpu_pm_disable(struct ivpu_device *vdev);
-void ivpu_pm_cancel_recovery(struct ivpu_device *vdev);
+void ivpu_pm_disable_recovery(struct ivpu_device *vdev);
 
 int ivpu_pm_suspend_cb(struct device *dev);
 int ivpu_pm_resume_cb(struct device *dev);
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 98759d6199d3..65f0f56ad753 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -937,8 +937,10 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
 
 	new_sids = krealloc_array(sids, count + new_count,
 				  sizeof(*new_sids), GFP_KERNEL);
-	if (!new_sids)
+	if (!new_sids) {
+		kfree(sids);
 		return NULL;
+	}
 
 	for (i = count; i < total_count; i++)
 		new_sids[i] = id_start++;
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 440cf9fb91aa..42c1a9052470 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		*val = data.ret.value;
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
@@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 
 		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index f7d8c3c00655..2fef08254d78 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -380,6 +380,28 @@ static const struct file_operations force_devcoredump_fops = {
 	.write		= force_devcd_write,
 };
 
+static void vhci_debugfs_init(struct vhci_data *data)
+{
+	struct hci_dev *hdev = data->hdev;
+
+	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
+			    &force_suspend_fops);
+
+	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
+			    &force_wakeup_fops);
+
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
+				    &msft_opcode_fops);
+
+	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
+		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
+				    &aosp_capable_fops);
+
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+}
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -434,22 +456,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		return -EBUSY;
 	}
 
-	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
-			    &force_suspend_fops);
-
-	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
-			    &force_wakeup_fops);
-
-	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
-		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
-				    &msft_opcode_fops);
-
-	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
-		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
-				    &aosp_capable_fops);
-
-	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
-			    &force_devcoredump_fops);
+	if (!IS_ERR_OR_NULL(hdev->debugfs))
+		vhci_debugfs_init(data);
 
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
@@ -651,6 +659,21 @@ static int vhci_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static void vhci_debugfs_remove(struct hci_dev *hdev)
+{
+	debugfs_lookup_and_remove("force_suspend", hdev->debugfs);
+
+	debugfs_lookup_and_remove("force_wakeup", hdev->debugfs);
+
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_lookup_and_remove("msft_opcode", hdev->debugfs);
+
+	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
+		debugfs_lookup_and_remove("aosp_capable", hdev->debugfs);
+
+	debugfs_lookup_and_remove("force_devcoredump", hdev->debugfs);
+}
+
 static int vhci_release(struct inode *inode, struct file *file)
 {
 	struct vhci_data *data = file->private_data;
@@ -662,6 +685,8 @@ static int vhci_release(struct inode *inode, struct file *file)
 	hdev = data->hdev;
 
 	if (hdev) {
+		if (!IS_ERR_OR_NULL(hdev->debugfs))
+			vhci_debugfs_remove(hdev);
 		hci_unregister_dev(hdev);
 		hci_free_dev(hdev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7d8b98aa5271..f9ceda7861f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -447,7 +447,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
 		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
-		ret = -ENOMEM;
+		return -ENOMEM;
 	}
 
 	adev->psp.xgmi_context.supports_extended_data =
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index bf7c22f81cda..ba73518f5cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 47e05783c4a0..b01d88d078fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 276c025c4c03..81760a26f2ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index e62ccf9eb73d..19a265bd4d19 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..3f6a828cad8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -641,8 +641,9 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
 		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
-			dev_err(mes->adev->dev, "MES FW version must be larger than 0x63 to support limit single process feature.\n");
-			return -EINVAL;
+			dev_warn_once(mes->adev->dev,
+				      "MES FW version must be larger than 0x63 to support limit single process feature.\n");
+			return 0;
 		}
 		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
 		misc_pkt.change_config.opcode =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 041bca58add5..9ac52eb6f593 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1376,15 +1376,15 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(6, 0, 0):
-		if ((adev->sdma.instance[0].fw_version >= 24) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 27) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 2):
-		if ((adev->sdma.instance[0].fw_version >= 21) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 23) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 25) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 27) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 4a9d07c31bc5..0c50fe266c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -896,13 +896,13 @@ void dce110_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
@@ -1798,13 +1798,13 @@ void dce60_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 75fb77bca83b..01480a04f85e 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -520,6 +520,15 @@ void dpp1_dppclk_control(
 		REG_UPDATE(DPP_CONTROL, DPP_CLOCK_ENABLE, 0);
 }
 
+void dpp_force_disable_cursor(struct dpp *dpp_base)
+{
+	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
+
+	/* Force disable cursor */
+	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, 0);
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = 0;
+}
+
 static const struct dpp_funcs dcn10_dpp_funcs = {
 		.dpp_read_state = dpp_read_state,
 		.dpp_reset = dpp_reset,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
index c48139bed11f..f466182963f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
@@ -1525,4 +1525,6 @@ void dpp1_construct(struct dcn10_dpp *dpp1,
 
 void dpp1_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust);
+void dpp_force_disable_cursor(struct dpp *dpp_base);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 2d70586cef40..09be2a90cc79 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -1494,6 +1494,7 @@ static struct dpp_funcs dcn30_dpp_funcs = {
 	.dpp_dppclk_control		= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
 	.dpp_get_gamut_remap		= dpp3_cm_get_gamut_remap,
+	.dpp_force_disable_cursor 	= dpp_force_disable_cursor,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index e68f21fd5f0f..560984533950 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -528,3 +528,75 @@ void dcn314_disable_link_output(struct dc_link *link,
 
 	apply_symclk_on_tx_off_wa(link);
 }
+
+/**
+ * dcn314_dpp_pg_control - DPP power gate control.
+ *
+ * @hws: dce_hwseq reference.
+ * @dpp_inst: DPP instance reference.
+ * @power_on: true if we want to enable power gate, false otherwise.
+ *
+ * Enable or disable power gate in the specific DPP instance.
+ * If power gating is disabled, will force disable cursor in the DPP instance.
+ */
+void dcn314_dpp_pg_control(
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool power_on)
+{
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+
+
+	if (hws->ctx->dc->debug.disable_dpp_power_gate) {
+		/* Workaround for DCN314 with disabled power gating */
+		if (!power_on) {
+
+			/* Force disable cursor if power gating is disabled */
+			struct dpp *dpp = hws->ctx->dc->res_pool->dpps[dpp_inst];
+			if (dpp && dpp->funcs->dpp_force_disable_cursor)
+				dpp->funcs->dpp_force_disable_cursor(dpp);
+		}
+		return;
+	}
+	if (REG(DOMAIN1_PG_CONFIG) == 0)
+		return;
+
+	switch (dpp_inst) {
+	case 0: /* DPP0 */
+		REG_UPDATE(DOMAIN1_PG_CONFIG,
+				DOMAIN1_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN1_PG_STATUS,
+				DOMAIN1_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 1: /* DPP1 */
+		REG_UPDATE(DOMAIN3_PG_CONFIG,
+				DOMAIN3_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN3_PG_STATUS,
+				DOMAIN3_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 2: /* DPP2 */
+		REG_UPDATE(DOMAIN5_PG_CONFIG,
+				DOMAIN5_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN5_PG_STATUS,
+				DOMAIN5_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 3: /* DPP3 */
+		REG_UPDATE(DOMAIN7_PG_CONFIG,
+				DOMAIN7_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN7_PG_STATUS,
+				DOMAIN7_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index 2305ad282f21..6c072d0274ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -47,4 +47,6 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
+void dcn314_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index f5112742edf9..9f454fa90e65 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -141,6 +141,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn31_hubp_pg_control,
+	.dpp_pg_control = dcn314_dpp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 0c5675d1c593..1b7c085dc2cc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -349,6 +349,9 @@ struct dpp_funcs {
 		struct dpp *dpp_base,
 		enum dc_color_space color_space,
 		struct dc_csc_transform cursor_csc_color_matrix);
+
+	void (*dpp_force_disable_cursor)(struct dpp *dpp_base);
+
 };
 
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 834b42a4d31f..4545ac42778a 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -392,6 +392,17 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 
 	gpiod_set_value_cansleep(pdata->enable_gpio, 1);
 
+	/*
+	 * After EN is deasserted and an external clock is detected, the bridge
+	 * will sample GPIO3:1 to determine its frequency. The driver will
+	 * overwrite this setting in ti_sn_bridge_set_refclk_freq(). But this is
+	 * racy. Thus we have to wait a couple of us. According to the datasheet
+	 * the GPIO lines has to be stable at least 5 us (td5) but it seems that
+	 * is not enough and the refclk frequency value is still lost or
+	 * overwritten by the bridge itself. Waiting for 20us seems to work.
+	 */
+	usleep_range(20, 30);
+
 	/*
 	 * If we have a reference clock we can enable communication w/ the
 	 * panel (including the aux channel) w/out any need for an input clock
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index f2a6559a2710..ea78c6c8ca7a 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -725,7 +725,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
+		ret = drm_dp_dpcd_probe(aux, DP_TRAINING_PATTERN_SET);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/nouveau/gv100_fence.c b/drivers/gpu/drm/nouveau/gv100_fence.c
index cccdeca72002..317e516c4ec7 100644
--- a/drivers/gpu/drm/nouveau/gv100_fence.c
+++ b/drivers/gpu/drm/nouveau/gv100_fence.c
@@ -18,7 +18,7 @@ gv100_fence_emit32(struct nouveau_channel *chan, u64 virtual, u32 sequence)
 	struct nvif_push *push = &chan->chan.push;
 	int ret;
 
-	ret = PUSH_WAIT(push, 8);
+	ret = PUSH_WAIT(push, 13);
 	if (ret)
 		return ret;
 
@@ -32,6 +32,11 @@ gv100_fence_emit32(struct nouveau_channel *chan, u64 virtual, u32 sequence)
 		  NVDEF(NVC36F, SEM_EXECUTE, PAYLOAD_SIZE, 32BIT) |
 		  NVDEF(NVC36F, SEM_EXECUTE, RELEASE_TIMESTAMP, DIS));
 
+	PUSH_MTHD(push, NVC36F, MEM_OP_A, 0,
+				MEM_OP_B, 0,
+				MEM_OP_C, NVDEF(NVC36F, MEM_OP_C, MEMBAR_TYPE, SYS_MEMBAR),
+				MEM_OP_D, NVDEF(NVC36F, MEM_OP_D, OPERATION, MEMBAR));
+
 	PUSH_MTHD(push, NVC36F, NON_STALL_INTERRUPT, 0);
 
 	PUSH_KICK(push);
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h
index 8735dda4c8a7..338f74b9f501 100644
--- a/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h
@@ -7,6 +7,91 @@
 
 #define NVC36F_NON_STALL_INTERRUPT                                 (0x00000020)
 #define NVC36F_NON_STALL_INTERRUPT_HANDLE                                 31:0
+// NOTE - MEM_OP_A and MEM_OP_B have been replaced in gp100 with methods for
+// specifying the page address for a targeted TLB invalidate and the uTLB for
+// a targeted REPLAY_CANCEL for UVM.
+// The previous MEM_OP_A/B functionality is in MEM_OP_C/D, with slightly
+// rearranged fields.
+#define NVC36F_MEM_OP_A                                            (0x00000028)
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_CANCEL_TARGET_CLIENT_UNIT_ID        5:0  // only relevant for REPLAY_CANCEL_TARGETED
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_INVALIDATION_SIZE                   5:0  // Used to specify size of invalidate, used for invalidates which are not of the REPLAY_CANCEL_TARGETED type
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_CANCEL_TARGET_GPC_ID               10:6  // only relevant for REPLAY_CANCEL_TARGETED
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_CANCEL_MMU_ENGINE_ID                6:0  // only relevant for REPLAY_CANCEL_VA_GLOBAL
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_SYSMEMBAR                         11:11
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_SYSMEMBAR_EN                 0x00000001
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_SYSMEMBAR_DIS                0x00000000
+#define NVC36F_MEM_OP_A_TLB_INVALIDATE_TARGET_ADDR_LO                    31:12
+#define NVC36F_MEM_OP_B                                            (0x0000002c)
+#define NVC36F_MEM_OP_B_TLB_INVALIDATE_TARGET_ADDR_HI                     31:0
+#define NVC36F_MEM_OP_C                                            (0x00000030)
+#define NVC36F_MEM_OP_C_MEMBAR_TYPE                                        2:0
+#define NVC36F_MEM_OP_C_MEMBAR_TYPE_SYS_MEMBAR                      0x00000000
+#define NVC36F_MEM_OP_C_MEMBAR_TYPE_MEMBAR                          0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB                                 0:0
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_ONE                      0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_ALL                      0x00000001  // Probably nonsensical for MMU_TLB_INVALIDATE_TARGETED
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_GPC                                 1:1
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_GPC_ENABLE                   0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_GPC_DISABLE                  0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY                              4:2  // only relevant if GPC ENABLE
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_NONE                  0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_START                 0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_START_ACK_ALL         0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_CANCEL_TARGETED       0x00000003
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_CANCEL_GLOBAL         0x00000004
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_REPLAY_CANCEL_VA_GLOBAL      0x00000005
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE                            6:5  // only relevant if GPC ENABLE
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE_NONE                0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE_GLOBALLY            0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACK_TYPE_INTRANODE           0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE                         9:7 //only relevant for REPLAY_CANCEL_VA_GLOBAL
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_READ                 0
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_WRITE                1
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ATOMIC_STRONG        2
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_RSVRVD               3
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ATOMIC_WEAK          4
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ATOMIC_ALL           5
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_WRITE_AND_ATOMIC     6
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_ACCESS_TYPE_VIRT_ALL                  7
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL                    9:7  // Invalidate affects this level and all below
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_ALL         0x00000000  // Invalidate tlb caches at all levels of the page table
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_PTE_ONLY    0x00000001
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE0  0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE1  0x00000003
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE2  0x00000004
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE3  0x00000005
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE4  0x00000006
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PAGE_TABLE_LEVEL_UP_TO_PDE5  0x00000007
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE                          11:10  // only relevant if PDB_ONE
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE_VID_MEM             0x00000000
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE_SYS_MEM_COHERENT    0x00000002
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_APERTURE_SYS_MEM_NONCOHERENT 0x00000003
+#define NVC36F_MEM_OP_C_TLB_INVALIDATE_PDB_ADDR_LO                       31:12  // only relevant if PDB_ONE
+#define NVC36F_MEM_OP_C_ACCESS_COUNTER_CLR_TARGETED_NOTIFY_TAG            19:0
+// MEM_OP_D MUST be preceded by MEM_OPs A-C.
+#define NVC36F_MEM_OP_D                                            (0x00000034)
+#define NVC36F_MEM_OP_D_TLB_INVALIDATE_PDB_ADDR_HI                        26:0  // only relevant if PDB_ONE
+#define NVC36F_MEM_OP_D_OPERATION                                        31:27
+#define NVC36F_MEM_OP_D_OPERATION_MEMBAR                            0x00000005
+#define NVC36F_MEM_OP_D_OPERATION_MMU_TLB_INVALIDATE                0x00000009
+#define NVC36F_MEM_OP_D_OPERATION_MMU_TLB_INVALIDATE_TARGETED       0x0000000a
+#define NVC36F_MEM_OP_D_OPERATION_L2_PEERMEM_INVALIDATE             0x0000000d
+#define NVC36F_MEM_OP_D_OPERATION_L2_SYSMEM_INVALIDATE              0x0000000e
+// CLEAN_LINES is an alias for Tegra/GPU IP usage
+#define NVC36F_MEM_OP_B_OPERATION_L2_INVALIDATE_CLEAN_LINES         0x0000000e
+#define NVC36F_MEM_OP_D_OPERATION_L2_CLEAN_COMPTAGS                 0x0000000f
+#define NVC36F_MEM_OP_D_OPERATION_L2_FLUSH_DIRTY                    0x00000010
+#define NVC36F_MEM_OP_D_OPERATION_L2_WAIT_FOR_SYS_PENDING_READS     0x00000015
+#define NVC36F_MEM_OP_D_OPERATION_ACCESS_COUNTER_CLR                0x00000016
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE                            1:0
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_MIMC                0x00000000
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_MOMC                0x00000001
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_ALL                 0x00000002
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TYPE_TARGETED            0x00000003
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_TYPE                   2:2
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_TYPE_MIMC       0x00000000
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_TYPE_MOMC       0x00000001
+#define NVC36F_MEM_OP_D_ACCESS_COUNTER_CLR_TARGETED_BANK                   6:3
 #define NVC36F_SEM_ADDR_LO                                         (0x0000005c)
 #define NVC36F_SEM_ADDR_LO_OFFSET                                         31:2
 #define NVC36F_SEM_ADDR_HI                                         (0x00000060)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index fdffa0391b31..6fd4e60634fb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -350,6 +350,8 @@ nvkm_fifo_dtor(struct nvkm_engine *engine)
 	nvkm_chid_unref(&fifo->chid);
 
 	nvkm_event_fini(&fifo->nonstall.event);
+	if (fifo->func->nonstall_dtor)
+		fifo->func->nonstall_dtor(fifo);
 	mutex_destroy(&fifo->mutex);
 
 	if (fifo->func->dtor)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
index e74493a4569e..6848a56f20c0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
@@ -517,19 +517,11 @@ ga100_fifo_nonstall_intr(struct nvkm_inth *inth)
 static void
 ga100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
 {
-	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
-	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
-
-	nvkm_inth_block(&runl->nonstall.inth);
 }
 
 static void
 ga100_fifo_nonstall_allow(struct nvkm_event *event, int type, int index)
 {
-	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
-	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
-
-	nvkm_inth_allow(&runl->nonstall.inth);
 }
 
 const struct nvkm_event_func
@@ -564,12 +556,26 @@ ga100_fifo_nonstall_ctor(struct nvkm_fifo *fifo)
 		if (ret)
 			return ret;
 
+		nvkm_inth_allow(&runl->nonstall.inth);
+
 		nr = max(nr, runl->id + 1);
 	}
 
 	return nr;
 }
 
+void
+ga100_fifo_nonstall_dtor(struct nvkm_fifo *fifo)
+{
+	struct nvkm_runl *runl;
+
+	nvkm_runl_foreach(runl, fifo) {
+		if (runl->nonstall.vector < 0)
+			continue;
+		nvkm_inth_block(&runl->nonstall.inth);
+	}
+}
+
 int
 ga100_fifo_runl_ctor(struct nvkm_fifo *fifo)
 {
@@ -599,6 +605,7 @@ ga100_fifo = {
 	.runl_ctor = ga100_fifo_runl_ctor,
 	.mmu_fault = &tu102_fifo_mmu_fault,
 	.nonstall_ctor = ga100_fifo_nonstall_ctor,
+	.nonstall_dtor = ga100_fifo_nonstall_dtor,
 	.nonstall = &ga100_fifo_nonstall,
 	.runl = &ga100_runl,
 	.runq = &ga100_runq,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
index 755235f55b3a..18a0b1f4eab7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
@@ -30,6 +30,7 @@ ga102_fifo = {
 	.runl_ctor = ga100_fifo_runl_ctor,
 	.mmu_fault = &tu102_fifo_mmu_fault,
 	.nonstall_ctor = ga100_fifo_nonstall_ctor,
+	.nonstall_dtor = ga100_fifo_nonstall_dtor,
 	.nonstall = &ga100_fifo_nonstall,
 	.runl = &ga100_runl,
 	.runq = &ga100_runq,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
index 5e81ae195329..fff1428ef267 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
@@ -41,6 +41,7 @@ struct nvkm_fifo_func {
 	void (*start)(struct nvkm_fifo *, unsigned long *);
 
 	int (*nonstall_ctor)(struct nvkm_fifo *);
+	void (*nonstall_dtor)(struct nvkm_fifo *);
 	const struct nvkm_event_func *nonstall;
 
 	const struct nvkm_runl_func *runl;
@@ -200,6 +201,7 @@ u32 tu102_chan_doorbell_handle(struct nvkm_chan *);
 
 int ga100_fifo_runl_ctor(struct nvkm_fifo *);
 int ga100_fifo_nonstall_ctor(struct nvkm_fifo *);
+void ga100_fifo_nonstall_dtor(struct nvkm_fifo *);
 extern const struct nvkm_event_func ga100_fifo_nonstall;
 extern const struct nvkm_runl_func ga100_runl;
 extern const struct nvkm_runq_func ga100_runq;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
index 1ac5628c5140..4ed54b386a60 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
@@ -601,6 +601,7 @@ r535_fifo_new(const struct nvkm_fifo_func *hw, struct nvkm_device *device,
 	rm->chan.func = &r535_chan;
 	rm->nonstall = &ga100_fifo_nonstall;
 	rm->nonstall_ctor = ga100_fifo_nonstall_ctor;
+	rm->nonstall_dtor = ga100_fifo_nonstall_dtor;
 
 	return nvkm_fifo_new_(rm, device, type, inst, pfifo);
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 186f6452a7d3..b50927a824b4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2579,12 +2579,13 @@ static int vop2_win_init(struct vop2 *vop2)
 }
 
 /*
- * The window registers are only updated when config done is written.
- * Until that they read back the old value. As we read-modify-write
- * these registers mark them as non-volatile. This makes sure we read
- * the new values from the regmap register cache.
+ * The window and video port registers are only updated when config
+ * done is written. Until that they read back the old value. As we
+ * read-modify-write these registers mark them as non-volatile. This
+ * makes sure we read the new values from the regmap register cache.
  */
 static const struct regmap_range vop2_nonvolatile_range[] = {
+	regmap_reg_range(RK3568_VP0_CTRL_BASE, RK3588_VP3_CTRL_BASE + 255),
 	regmap_reg_range(0x1000, 0x23ff),
 };
 
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 74635b444122..50326e756f89 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -803,8 +803,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		return ret;
 	}
 
-	tt_has_data = ttm && (ttm_tt_is_populated(ttm) ||
-			      (ttm->page_flags & TTM_TT_FLAG_SWAPPED));
+	tt_has_data = ttm && (ttm_tt_is_populated(ttm) || ttm_tt_is_swapped(ttm));
 
 	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
 					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 9a5fd16a4ec2..5c90c3e59f80 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -300,7 +300,7 @@ static int ina238_write_in(struct device *dev, u32 attr, int channel,
 		regval = clamp_val(val, -163, 163);
 		regval = (regval * 1000 * 4) /
 			 (INA238_SHUNT_VOLTAGE_LSB * data->gain);
-		regval = clamp_val(regval, S16_MIN, S16_MAX);
+		regval = clamp_val(regval, S16_MIN, S16_MAX) & 0xffff;
 
 		switch (attr) {
 		case hwmon_in_max:
@@ -426,9 +426,10 @@ static int ina238_write_power(struct device *dev, u32 attr, long val)
 	 * Unsigned postive values. Compared against the 24-bit power register,
 	 * lower 8-bits are truncated. Same conversion to/from uW as POWER
 	 * register.
+	 * The first clamp_val() is to establish a baseline to avoid overflows.
 	 */
-	regval = clamp_val(val, 0, LONG_MAX);
-	regval = div_u64(val * 4 * 100 * data->rshunt, data->config->power_calculate_factor *
+	regval = clamp_val(val, 0, LONG_MAX / 2);
+	regval = div_u64(regval * 4 * 100 * data->rshunt, data->config->power_calculate_factor *
 			1000ULL * INA238_FIXED_SHUNT * data->gain);
 	regval = clamp_val(regval >> 8, 0, U16_MAX);
 
@@ -481,7 +482,7 @@ static int ina238_write_temp(struct device *dev, u32 attr, long val)
 		return -EOPNOTSUPP;
 
 	/* Signed */
-	regval = clamp_val(val, -40000, 125000);
+	val = clamp_val(val, -40000, 125000);
 	regval = div_s64(val * 10000, data->config->temp_lsb) << data->config->temp_shift;
 	regval = clamp_val(regval, S16_MIN, S16_MAX) & (0xffff << data->config->temp_shift);
 
diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index a5f89aab3fb4..c25a54d5b39a 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -561,15 +561,14 @@ static int mlxreg_fan_cooling_config(struct device *dev, struct mlxreg_fan *fan)
 		if (!pwm->connected)
 			continue;
 		pwm->fan = fan;
+		/* Set minimal PWM speed. */
+		pwm->last_hwmon_state = MLXREG_FAN_PWM_DUTY2STATE(MLXREG_FAN_MIN_DUTY);
 		pwm->cdev = devm_thermal_of_cooling_device_register(dev, NULL, mlxreg_fan_name[i],
 								    pwm, &mlxreg_fan_cooling_ops);
 		if (IS_ERR(pwm->cdev)) {
 			dev_err(dev, "Failed to register cooling device\n");
 			return PTR_ERR(pwm->cdev);
 		}
-
-		/* Set minimal PWM speed. */
-		pwm->last_hwmon_state = MLXREG_FAN_PWM_DUTY2STATE(MLXREG_FAN_MIN_DUTY);
 	}
 
 	return 0;
diff --git a/drivers/isdn/mISDN/dsp_hwec.c b/drivers/isdn/mISDN/dsp_hwec.c
index 0b3f29195330..0cd216e28f00 100644
--- a/drivers/isdn/mISDN/dsp_hwec.c
+++ b/drivers/isdn/mISDN/dsp_hwec.c
@@ -51,14 +51,14 @@ void dsp_hwec_enable(struct dsp *dsp, const char *arg)
 		goto _do;
 
 	{
-		char *dup, *tok, *name, *val;
+		char *dup, *next, *tok, *name, *val;
 		int tmp;
 
-		dup = kstrdup(arg, GFP_ATOMIC);
+		dup = next = kstrdup(arg, GFP_ATOMIC);
 		if (!dup)
 			return;
 
-		while ((tok = strsep(&dup, ","))) {
+		while ((tok = strsep(&next, ","))) {
 			if (!strlen(tok))
 				continue;
 			name = strsep(&tok, "=");
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8746b22060a7..3f355bb85797 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9089,6 +9089,11 @@ void md_do_sync(struct md_thread *thread)
 	}
 
 	action = md_sync_action(mddev);
+	if (action == ACTION_FROZEN || action == ACTION_IDLE) {
+		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		goto skip;
+	}
+
 	desc = md_sync_action_name(action);
 	mddev->last_sync_action = action;
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6cee738a645f..6d5233605794 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1226,7 +1226,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 	int i = 0;
 	struct bio *behind_bio = NULL;
 
-	behind_bio = bio_alloc_bioset(NULL, vcnt, 0, GFP_NOIO,
+	behind_bio = bio_alloc_bioset(NULL, vcnt, bio->bi_opf, GFP_NOIO,
 				      &r1_bio->mddev->bio_set);
 
 	/* discard op, we don't support writezero/writesame yet */
diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
index 1c88bfaea46b..ab3bc645da56 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.c
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -779,7 +779,8 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 			continue;
 		if (led_num > 1) {
 			dev_err(dev, "invalid LED specified port %d\n", port);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_led;
 		}
 
 		if (led_num == 0)
@@ -823,17 +824,25 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 		init_data.devname_mandatory = true;
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
 						 port, led_num);
-		if (!init_data.devicename)
-			return -ENOMEM;
+		if (!init_data.devicename) {
+			ret = -ENOMEM;
+			goto err_put_led;
+		}
 
 		ret = devm_led_classdev_register_ext(dev, l, &init_data);
 		kfree(init_data.devicename);
 
 		if (ret) {
 			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);
-			return ret;
+			goto err_put_led;
 		}
 	}
 
+	fwnode_handle_put(leds);
 	return 0;
+
+err_put_led:
+	fwnode_handle_put(led);
+	fwnode_handle_put(leds);
+	return ret;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index cb76ab78904f..d47c1d81c49b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4390,7 +4390,7 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
 		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
-				    ring_nr, i, bp->rx_ring_size);
+				    ring_nr, i, bp->rx_agg_ring_size);
 			break;
 		}
 		prod = NEXT_RX_AGG(prod);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d949d2ba6cb9..f5d7556afb97 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1223,12 +1223,13 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	u16 queue_index = queue - bp->queues;
+	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
 	int packets = 0;
 	u32 bytes = 0;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
@@ -1291,7 +1292,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->dev, queue_index);
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return packets;
 }
@@ -1707,8 +1708,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	if (queue->tx_head == queue->tx_tail)
 		goto out_tx_ptr_unlock;
@@ -1720,19 +1722,20 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 out_tx_ptr_unlock:
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 }
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
 	bool retval = false;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	if (queue->tx_head != queue->tx_tail) {
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1740,7 +1743,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	return retval;
 }
 
@@ -2308,6 +2311,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct macb_queue *queue = &bp->queues[queue_index];
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
+	unsigned long flags;
 	bool is_lso;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
@@ -2368,7 +2372,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
 	}
 
-	spin_lock_bh(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
@@ -2392,15 +2396,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
 			     skb->len);
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
 		netif_stop_subqueue(dev, queue_index);
 
 unlock:
-	spin_unlock_bh(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 21495b5dce25..9efb60842ad1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1493,13 +1493,17 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
 		 */
-		if (phy_np &&
-		    !of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
-			/* Wait until the phy drivers are available */
-			pd = of_phy_find_device(phy_np);
-			if (!pd)
-				goto defer;
-			bgx->lmac[lmac].phydev = pd;
+		if (phy_np) {
+			if (!of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
+				/* Wait until the phy drivers are available */
+				pd = of_phy_find_device(phy_np);
+				if (!pd) {
+					of_node_put(phy_np);
+					goto defer;
+				}
+				bgx->lmac[lmac].phydev = pd;
+			}
+			of_node_put(phy_np);
 		}
 
 		lmac++;
@@ -1515,11 +1519,11 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	 * for phy devices we may have already found.
 	 */
 	while (lmac) {
+		lmac--;
 		if (bgx->lmac[lmac].phydev) {
 			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
 			bgx->lmac[lmac].phydev = NULL;
 		}
-		lmac--;
 	}
 	of_node_put(node);
 	return -EPROBE_DEFER;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..641a36dd0e60 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -549,12 +549,12 @@ static int e1000_set_eeprom(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
+	size_t total_len, max_len;
 	u16 *eeprom_buff;
-	void *ptr;
-	int max_len;
+	int ret_val = 0;
 	int first_word;
 	int last_word;
-	int ret_val = 0;
+	void *ptr;
 	u16 i;
 
 	if (eeprom->len == 0)
@@ -569,6 +569,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	max_len = hw->nvm.word_size * 2;
 
+	if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
+	    total_len > max_len)
+		return -EFBIG;
+
 	first_word = eeprom->offset >> 1;
 	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
 	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 59263551c383..0b099e5f4816 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -359,8 +359,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
 		goto free_cdev;
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
+	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 	if (mac)
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
 	else
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 6cd9da662ae1..a5c794371dfe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -40,48 +40,6 @@ static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
  * setup, adding or removing filters, or other things.  Many of
  * these will be useful for some forms of unit testing.
  **************************************************************/
-static char i40e_dbg_command_buf[256] = "";
-
-/**
- * i40e_dbg_command_read - read for command datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
-				     size_t count, loff_t *ppos)
-{
-	struct i40e_pf *pf = filp->private_data;
-	struct i40e_vsi *main_vsi;
-	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
-	int len;
-
-	/* don't allow partial reads */
-	if (*ppos != 0)
-		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOSPC;
-
-	main_vsi = i40e_pf_get_main_vsi(pf);
-	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
-		       i40e_dbg_command_buf);
-
-	bytes_not_copied = copy_to_user(buffer, buf, len);
-	kfree(buf);
-
-	if (bytes_not_copied)
-		return -EFAULT;
-
-	*ppos = len;
-	return len;
-}
 
 static char *i40e_filter_state_string[] = {
 	"INVALID",
@@ -1621,7 +1579,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 static const struct file_operations i40e_dbg_command_fops = {
 	.owner = THIS_MODULE,
 	.open =  simple_open,
-	.read =  i40e_dbg_command_read,
 	.write = i40e_dbg_command_write,
 };
 
@@ -1630,48 +1587,6 @@ static const struct file_operations i40e_dbg_command_fops = {
  * The netdev_ops entry in debugfs is for giving the driver commands
  * to be executed from the netdev operations.
  **************************************************************/
-static char i40e_dbg_netdev_ops_buf[256] = "";
-
-/**
- * i40e_dbg_netdev_ops_read - read for netdev_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
-					size_t count, loff_t *ppos)
-{
-	struct i40e_pf *pf = filp->private_data;
-	struct i40e_vsi *main_vsi;
-	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
-	int len;
-
-	/* don't allow partal reads */
-	if (*ppos != 0)
-		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOSPC;
-
-	main_vsi = i40e_pf_get_main_vsi(pf);
-	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
-		       i40e_dbg_netdev_ops_buf);
-
-	bytes_not_copied = copy_to_user(buffer, buf, len);
-	kfree(buf);
-
-	if (bytes_not_copied)
-		return -EFAULT;
-
-	*ppos = len;
-	return len;
-}
 
 /**
  * i40e_dbg_netdev_ops_write - write into netdev_ops datum
@@ -1685,35 +1600,36 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 					 size_t count, loff_t *ppos)
 {
 	struct i40e_pf *pf = filp->private_data;
+	char *cmd_buf, *buf_tmp;
 	int bytes_not_copied;
 	struct i40e_vsi *vsi;
-	char *buf_tmp;
 	int vsi_seid;
 	int i, cnt;
 
 	/* don't allow partial writes */
 	if (*ppos != 0)
 		return 0;
-	if (count >= sizeof(i40e_dbg_netdev_ops_buf))
-		return -ENOSPC;
 
-	memset(i40e_dbg_netdev_ops_buf, 0, sizeof(i40e_dbg_netdev_ops_buf));
-	bytes_not_copied = copy_from_user(i40e_dbg_netdev_ops_buf,
-					  buffer, count);
-	if (bytes_not_copied)
+	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!cmd_buf)
+		return count;
+	bytes_not_copied = copy_from_user(cmd_buf, buffer, count);
+	if (bytes_not_copied) {
+		kfree(cmd_buf);
 		return -EFAULT;
-	i40e_dbg_netdev_ops_buf[count] = '\0';
+	}
+	cmd_buf[count] = '\0';
 
-	buf_tmp = strchr(i40e_dbg_netdev_ops_buf, '\n');
+	buf_tmp = strchr(cmd_buf, '\n');
 	if (buf_tmp) {
 		*buf_tmp = '\0';
-		count = buf_tmp - i40e_dbg_netdev_ops_buf + 1;
+		count = buf_tmp - cmd_buf + 1;
 	}
 
-	if (strncmp(i40e_dbg_netdev_ops_buf, "change_mtu", 10) == 0) {
+	if (strncmp(cmd_buf, "change_mtu", 10) == 0) {
 		int mtu;
 
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i %i",
+		cnt = sscanf(&cmd_buf[11], "%i %i",
 			     &vsi_seid, &mtu);
 		if (cnt != 2) {
 			dev_info(&pf->pdev->dev, "change_mtu <vsi_seid> <mtu>\n");
@@ -1735,8 +1651,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
 		}
 
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "set_rx_mode", 11) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i", &vsi_seid);
+	} else if (strncmp(cmd_buf, "set_rx_mode", 11) == 0) {
+		cnt = sscanf(&cmd_buf[11], "%i", &vsi_seid);
 		if (cnt != 1) {
 			dev_info(&pf->pdev->dev, "set_rx_mode <vsi_seid>\n");
 			goto netdev_ops_write_done;
@@ -1756,8 +1672,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
 		}
 
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "napi", 4) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[4], "%i", &vsi_seid);
+	} else if (strncmp(cmd_buf, "napi", 4) == 0) {
+		cnt = sscanf(&cmd_buf[4], "%i", &vsi_seid);
 		if (cnt != 1) {
 			dev_info(&pf->pdev->dev, "napi <vsi_seid>\n");
 			goto netdev_ops_write_done;
@@ -1775,21 +1691,20 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "napi called\n");
 		}
 	} else {
-		dev_info(&pf->pdev->dev, "unknown command '%s'\n",
-			 i40e_dbg_netdev_ops_buf);
+		dev_info(&pf->pdev->dev, "unknown command '%s'\n", cmd_buf);
 		dev_info(&pf->pdev->dev, "available commands\n");
 		dev_info(&pf->pdev->dev, "  change_mtu <vsi_seid> <mtu>\n");
 		dev_info(&pf->pdev->dev, "  set_rx_mode <vsi_seid>\n");
 		dev_info(&pf->pdev->dev, "  napi <vsi_seid>\n");
 	}
 netdev_ops_write_done:
+	kfree(cmd_buf);
 	return count;
 }
 
 static const struct file_operations i40e_dbg_netdev_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = i40e_dbg_netdev_ops_read,
 	.write = i40e_dbg_netdev_ops_write,
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d42892c8c5a1..a34faa489473 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3172,12 +3172,14 @@ static irqreturn_t ice_ll_ts_intr(int __always_unused irq, void *data)
 	hw = &pf->hw;
 	tx = &pf->ptp.port.tx;
 	spin_lock_irqsave(&tx->lock, flags);
-	ice_ptp_complete_tx_single_tstamp(tx);
+	if (tx->init) {
+		ice_ptp_complete_tx_single_tstamp(tx);
 
-	idx = find_next_bit_wrap(tx->in_use, tx->len,
-				 tx->last_ll_ts_idx_read + 1);
-	if (idx != tx->len)
-		ice_ptp_req_tx_single_tstamp(tx, idx);
+		idx = find_next_bit_wrap(tx->in_use, tx->len,
+					 tx->last_ll_ts_idx_read + 1);
+		if (idx != tx->len)
+			ice_ptp_req_tx_single_tstamp(tx, idx);
+	}
 	spin_unlock_irqrestore(&tx->lock, flags);
 
 	val = GLINT_DYN_CTL_INTENA_M | GLINT_DYN_CTL_CLEARPBA_M |
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 55cad824c5b9..69e05bafb1e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2877,16 +2877,19 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		 */
 		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
 			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
-			u8 idx;
+			u8 idx, last;
 
 			if (!ice_pf_state_is_nominal(pf))
 				return IRQ_HANDLED;
 
 			spin_lock(&tx->lock);
-			idx = find_next_bit_wrap(tx->in_use, tx->len,
-						 tx->last_ll_ts_idx_read + 1);
-			if (idx != tx->len)
-				ice_ptp_req_tx_single_tstamp(tx, idx);
+			if (tx->init) {
+				last = tx->last_ll_ts_idx_read + 1;
+				idx = find_next_bit_wrap(tx->in_use, tx->len,
+							 last);
+				if (idx != tx->len)
+					ice_ptp_req_tx_single_tstamp(tx, idx);
+			}
 			spin_unlock(&tx->lock);
 
 			return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index e9f8da9f7979..5fc6147ecd93 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2277,6 +2277,7 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	struct sockaddr *addr = p;
+	u8 old_mac_addr[ETH_ALEN];
 	struct idpf_vport *vport;
 	int err = 0;
 
@@ -2300,17 +2301,19 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		goto unlock_mutex;
 
+	ether_addr_copy(old_mac_addr, vport->default_mac_addr);
+	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	vport_config = vport->adapter->vport_config[vport->idx];
 	err = idpf_add_mac_filter(vport, np, addr->sa_data, false);
 	if (err) {
 		__idpf_del_mac_filter(vport_config, addr->sa_data);
+		ether_addr_copy(vport->default_mac_addr, netdev->dev_addr);
 		goto unlock_mutex;
 	}
 
-	if (is_valid_ether_addr(vport->default_mac_addr))
-		idpf_del_mac_filter(vport, np, vport->default_mac_addr, false);
+	if (is_valid_ether_addr(old_mac_addr))
+		__idpf_del_mac_filter(vport_config, old_mac_addr);
 
-	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	eth_hw_addr_set(netdev, addr->sa_data);
 
 unlock_mutex:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 24febaaa8fbb..cb9a27307670 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3507,6 +3507,16 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
+static void idpf_set_mac_type(struct idpf_vport *vport,
+			      struct virtchnl2_mac_addr *mac_addr)
+{
+	bool is_primary;
+
+	is_primary = ether_addr_equal(vport->default_mac_addr, mac_addr->addr);
+	mac_addr->type = is_primary ? VIRTCHNL2_MAC_ADDR_PRIMARY :
+				      VIRTCHNL2_MAC_ADDR_EXTRA;
+}
+
 /**
  * idpf_mac_filter_async_handler - Async callback for mac filters
  * @adapter: private data struct
@@ -3636,6 +3646,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -3643,6 +3654,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index d8a919ab7027..05a1f9f5914f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3565,13 +3565,13 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
-			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
 					 edata->supported);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
-			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
 					 edata->advertised);
 	}
 
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b38e4f2de674..880f27ca84d4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1737,6 +1737,13 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool gso = false;
 	int tx_num;
 
+	if (skb_vlan_tag_present(skb) &&
+	    !eth_proto_is_802_3(eth_hdr(skb)->h_proto)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			goto dropped;
+	}
+
 	/* normally we can rely on the stack not calling this more than once,
 	 * however we have 2 queues running on the same ring so we need to lock
 	 * the ring access
@@ -1782,8 +1789,9 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 drop:
 	spin_unlock(&eth->page_lock);
-	stats->tx_dropped++;
 	dev_kfree_skb_any(skb);
+dropped:
+	stats->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b33285d755b9..a626fd0d2073 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -267,8 +267,10 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 	pp.dma_dir = priv->dma_dir;
 
 	ring->pp = page_pool_create(&pp);
-	if (!ring->pp)
+	if (IS_ERR(ring->pp)) {
+		err = PTR_ERR(ring->pp);
 		goto err_ring;
+	}
 
 	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
 		goto err_pp;
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 84c41f193561..79b800d2b72c 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -423,13 +423,16 @@ static void lan865x_remove(struct spi_device *spi)
 	free_netdev(priv->netdev);
 }
 
-static const struct spi_device_id spidev_spi_ids[] = {
+static const struct spi_device_id lan865x_ids[] = {
 	{ .name = "lan8650" },
+	{ .name = "lan8651" },
 	{},
 };
+MODULE_DEVICE_TABLE(spi, lan865x_ids);
 
 static const struct of_device_id lan865x_dt_ids[] = {
 	{ .compatible = "microchip,lan8650" },
+	{ .compatible = "microchip,lan8651" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
@@ -441,7 +444,7 @@ static struct spi_driver lan865x_driver = {
 	 },
 	.probe = lan865x_probe,
 	.remove = lan865x_remove,
-	.id_table = spidev_spi_ids,
+	.id_table = lan865x_ids,
 };
 module_spi_driver(lan865x_driver);
 
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index db200e4ec284..91a906a7918a 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1249,7 +1249,8 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
-	spi_setup(tc6->spi);
+	if (spi_setup(tc6->spi) < 0)
+		return NULL;
 
 	tc6->spi_ctrl_tx_buf = devm_kzalloc(&tc6->spi->dev,
 					    OA_TC6_CTRL_SPI_BUF_SIZE,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 231ca141331f..dbdbc40109c5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1522,7 +1522,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 		}
 	}
 
-	if (single_port) {
+	if (single_port && num_tx) {
 		netif_txq = netdev_get_tx_queue(ndev, chn);
 		netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
 		am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0d8a05fe541a..ec6d47dc984a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1168,6 +1168,15 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
+
+	if (IS_ERR(app_metadata)) {
+		if (net_ratelimit())
+			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
+		dev_kfree_skb_any(skb);
+		lp->ndev->stats.rx_dropped++;
+		goto rx_submit;
+	}
+
 	/* TODO: Derive app word index programmatically */
 	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
 	skb_put(skb, rx_len);
@@ -1180,6 +1189,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_add(&lp->rx_bytes, rx_len);
 	u64_stats_update_end(&lp->rx_stat_sync);
 
+rx_submit:
 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
 				   RX_BUF_NUM_DEFAULT); i++)
 		axienet_rx_submit_desc(lp->ndev);
diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index a31d5d5e6593..97e88886253f 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1576,7 +1576,7 @@ do_reset(struct net_device *dev, int full)
 	    msleep(40);			/* wait 40 msec to let it complete */
 	}
 	if (full_duplex)
-	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR | FullDuplex));
+	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR) | FullDuplex);
     } else {  /* No MII */
 	SelectPage(0);
 	value = GetByte(XIRCREG_ESR);	 /* read the ESR */
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4c75d1fea552..01329fe7451a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1844,7 +1844,7 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 	if (tb_sa[MACSEC_SA_ATTR_PN]) {
 		spin_lock_bh(&rx_sa->lock);
-		rx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
@@ -2086,7 +2086,7 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&tx_sa->lock);
-	tx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+	tx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 	spin_unlock_bh(&tx_sa->lock);
 
 	if (tb_sa[MACSEC_SA_ATTR_ACTIVE])
@@ -2398,7 +2398,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&tx_sa->lock);
 		prev_pn = tx_sa->next_pn_halves;
-		tx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		tx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&tx_sa->lock);
 	}
 
@@ -2496,7 +2496,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&rx_sa->lock);
 		prev_pn = rx_sa->next_pn_halves;
-		rx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 775a386d0aca..36ccc53b1797 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -183,6 +183,7 @@ static void mctp_usb_in_complete(struct urb *urb)
 		struct mctp_usb_hdr *hdr;
 		u8 pkt_len; /* length of MCTP packet, no USB header */
 
+		skb_reset_mac_header(skb);
 		hdr = skb_pull_data(skb, sizeof(*hdr));
 		if (!hdr)
 			break;
diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index d79bb9b06cd2..ce73d9474d5b 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -19,7 +19,7 @@
 #define MIIC_PRCMD			0x0
 #define MIIC_ESID_CODE			0x4
 
-#define MIIC_MODCTRL			0x20
+#define MIIC_MODCTRL			0x8
 #define MIIC_MODCTRL_SW_MODE		GENMASK(4, 0)
 
 #define MIIC_CONVCTRL(port)		(0x100 + (port) * 4)
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 72847320cb65..d692df7d975c 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -456,12 +456,12 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		*p++ = (reg >> 24) & 0xff;
 	}
 
-	len = skb_queue_len(&ptp->tx_queue);
+	len = skb_queue_len_lockless(&ptp->tx_queue);
 	if (len < 1)
 		return;
 
 	while (len--) {
-		skb = __skb_dequeue(&ptp->tx_queue);
+		skb = skb_dequeue(&ptp->tx_queue);
 		if (!skb)
 			return;
 
@@ -486,7 +486,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		 * packet in the FIFO right now, reschedule it for later
 		 * packets.
 		 */
-		__skb_queue_tail(&ptp->tx_queue, skb);
+		skb_queue_tail(&ptp->tx_queue, skb);
 	}
 }
 
@@ -1068,6 +1068,7 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_TX_ON:
 		break;
 	case HWTSTAMP_TX_OFF:
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 		break;
 	default:
 		return -ERANGE;
@@ -1092,9 +1093,6 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 
 	mutex_lock(&vsc8531->ts_lock);
 
-	__skb_queue_purge(&vsc8531->ptp->tx_queue);
-	__skb_queue_head_init(&vsc8531->ptp->tx_queue);
-
 	/* Disable predictor while configuring the 1588 block */
 	val = vsc85xx_ts_read_csr(phydev, PROCESSOR,
 				  MSCC_PHY_PTP_INGR_PREDICTOR);
@@ -1180,9 +1178,7 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-	mutex_lock(&vsc8531->ts_lock);
-	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
-	mutex_unlock(&vsc8531->ts_lock);
+	skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	return;
 
 out:
@@ -1548,6 +1544,7 @@ void vsc8584_ptp_deinit(struct phy_device *phydev)
 	if (vsc8531->ptp->ptp_clock) {
 		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
 		skb_queue_purge(&vsc8531->rx_skbs_list);
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 	}
 }
 
@@ -1571,7 +1568,7 @@ irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 	if (rc & VSC85XX_1588_INT_FIFO_ADD) {
 		vsc85xx_get_tx_ts(priv->ptp);
 	} else if (rc & VSC85XX_1588_INT_FIFO_OVERFLOW) {
-		__skb_queue_purge(&priv->ptp->tx_queue);
+		skb_queue_purge(&priv->ptp->tx_queue);
 		vsc85xx_ts_reset_fifo(phydev);
 	}
 
@@ -1591,6 +1588,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
 	skb_queue_head_init(&vsc8531->rx_skbs_list);
+	skb_queue_head_init(&vsc8531->ptp->tx_queue);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 5e7672d2022c..bb5343c03925 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1752,7 +1752,6 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		 */
 		if (net_ratelimit())
 			netdev_err(ppp->dev, "ppp: compressor dropped pkt\n");
-		kfree_skb(skb);
 		consume_skb(new_skb);
 		new_skb = NULL;
 	}
@@ -1854,9 +1853,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 					   "down - pkt dropped.\n");
 			goto drop;
 		}
-		skb = pad_compress_skb(ppp, skb);
-		if (!skb)
+		new_skb = pad_compress_skb(ppp, skb);
+		if (!new_skb)
 			goto drop;
+		skb = new_skb;
 	}
 
 	/*
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index ea0e5e276cd6..5d123df0a866 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2087,6 +2087,13 @@ static const struct usb_device_id cdc_devs[] = {
 	  .driver_info = (unsigned long)&wwan_info,
 	},
 
+	/* Intel modem (label from OEM reads Fibocom L850-GL) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x8087, 0x095a,
+		USB_CLASS_COMM,
+		USB_CDC_SUBCLASS_NCM, USB_CDC_PROTO_NONE),
+	  .driver_info = (unsigned long)&wwan_info,
+	},
+
 	/* DisplayLink docking stations */
 	{ .match_flags = USB_DEVICE_ID_MATCH_INT_INFO
 		| USB_DEVICE_ID_MATCH_VENDOR,
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 97792de896b7..45cec14d76f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1445,6 +1445,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		if (READ_ONCE(f->updated) != now)
 			WRITE_ONCE(f->updated, now);
 
+		/* Don't override an fdb with nexthop with a learnt entry */
+		if (rcu_access_pointer(f->nh))
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
+
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
 			return SKB_NOT_DROPPED_YET;
@@ -1453,10 +1457,6 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
-		/* Don't override an fdb with nexthop with a learnt entry */
-		if (rcu_access_pointer(f->nh))
-			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
-
 		if (net_ratelimit())
 			netdev_info(dev,
 				    "%pM migrated from %pIS to %pIS\n",
@@ -1880,6 +1880,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	n = neigh_lookup(&arp_tbl, &tip, dev);
 
 	if (n) {
+		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
 
@@ -1890,7 +1891,9 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 		rcu_read_lock();
 		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+		if (f)
+			rdst = first_remote_rcu(f);
+		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
 			/* bridge-local neighbor */
 			neigh_release(n);
 			rcu_read_unlock();
@@ -2047,6 +2050,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
 
 	if (n) {
+		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
 
@@ -2056,7 +2060,9 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		}
 
 		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+		if (f)
+			rdst = first_remote_rcu(f);
+		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
 			/* bridge-local neighbor */
 			neigh_release(n);
 			goto out;
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index d328aed9feef..55b84c0cbd65 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -61,9 +61,7 @@ static inline struct hlist_head *vs_head(struct net *net, __be16 port)
 	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
 }
 
-/* First remote destination for a forwarding entry.
- * Guaranteed to be non-NULL because remotes are never deleted.
- */
+/* First remote destination for a forwarding entry. */
 static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
 {
 	if (rcu_access_pointer(fdb->nh))
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6b2f207975e3..5d0210953fa3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -410,6 +410,8 @@ struct ath11k_vif {
 	bool do_not_send_tmpl;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
+	u32 num_stations;
+	bool reinstall_group_keys;
 
 	struct ath11k_reg_tpc_power_info reg_tpc_info;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 977f370fd6de..5f6cc763c86a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4317,6 +4317,40 @@ static int ath11k_clear_peer_keys(struct ath11k_vif *arvif,
 	return first_errno;
 }
 
+static int ath11k_set_group_keys(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_base *ab = ar->ab;
+	const u8 *addr = arvif->bssid;
+	int i, ret, first_errno = 0;
+	struct ath11k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find(ab, arvif->vdev_id, addr);
+	spin_unlock_bh(&ab->base_lock);
+
+	if (!peer)
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(peer->keys); i++) {
+		struct ieee80211_key_conf *key = peer->keys[i];
+
+		if (!key || (key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+			continue;
+
+		ret = ath11k_install_key(arvif, key, SET_KEY, addr,
+					 WMI_KEY_GROUP);
+		if (ret < 0 && first_errno == 0)
+			first_errno = ret;
+
+		if (ret < 0)
+			ath11k_warn(ab, "failed to set group key of idx %d for vdev %d: %d\n",
+				    i, arvif->vdev_id, ret);
+	}
+
+	return first_errno;
+}
+
 static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
@@ -4326,6 +4360,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
+	bool is_ap_with_no_sta;
 	const u8 *peer_addr;
 	int ret = 0;
 	u32 flags = 0;
@@ -4386,16 +4421,57 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	else
 		flags |= WMI_KEY_GROUP;
 
-	ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
-	if (ret) {
-		ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);
-		goto exit;
-	}
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "%s for peer %pM on vdev %d flags 0x%X, type = %d, num_sta %d\n",
+		   cmd == SET_KEY ? "SET_KEY" : "DEL_KEY", peer_addr, arvif->vdev_id,
+		   flags, arvif->vdev_type, arvif->num_stations);
+
+	/* Allow group key clearing only in AP mode when no stations are
+	 * associated. There is a known race condition in firmware where
+	 * group addressed packets may be dropped if the key is cleared
+	 * and immediately set again during rekey.
+	 *
+	 * During GTK rekey, mac80211 issues a clear key (if the old key
+	 * exists) followed by an install key operation for same key
+	 * index. This causes ath11k to send two WMI commands in quick
+	 * succession: one to clear the old key and another to install the
+	 * new key in the same slot.
+	 *
+	 * Under certain conditions—especially under high load or time
+	 * sensitive scenarios, firmware may process these commands
+	 * asynchronously in a way that firmware assumes the key is
+	 * cleared whereas hardware has a valid key. This inconsistency
+	 * between hardware and firmware leads to group addressed packet
+	 * drops after rekey.
+	 * Only setting the same key again can restore a valid key in
+	 * firmware and allow packets to be transmitted.
+	 *
+	 * There is a use case where an AP can transition from Secure mode
+	 * to open mode without a vdev restart by just deleting all
+	 * associated peers and clearing key, Hence allow clear key for
+	 * that case alone. Mark arvif->reinstall_group_keys in such cases
+	 * and reinstall the same key when the first peer is added,
+	 * allowing firmware to recover from the race if it had occurred.
+	 */
 
-	ret = ath11k_dp_peer_rx_pn_replay_config(arvif, peer_addr, cmd, key);
-	if (ret) {
-		ath11k_warn(ab, "failed to offload PN replay detection %d\n", ret);
-		goto exit;
+	is_ap_with_no_sta = (vif->type == NL80211_IFTYPE_AP &&
+			     !arvif->num_stations);
+	if ((flags & WMI_KEY_PAIRWISE) || cmd == SET_KEY || is_ap_with_no_sta) {
+		ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
+		if (ret) {
+			ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);
+			goto exit;
+		}
+
+		ret = ath11k_dp_peer_rx_pn_replay_config(arvif, peer_addr, cmd, key);
+		if (ret) {
+			ath11k_warn(ab, "failed to offload PN replay detection %d\n",
+				    ret);
+			goto exit;
+		}
+
+		if ((flags & WMI_KEY_GROUP) && cmd == SET_KEY && is_ap_with_no_sta)
+			arvif->reinstall_group_keys = true;
 	}
 
 	spin_lock_bh(&ab->base_lock);
@@ -4994,6 +5070,7 @@ static int ath11k_mac_inc_num_stations(struct ath11k_vif *arvif,
 		return -ENOBUFS;
 
 	ar->num_stations++;
+	arvif->num_stations++;
 
 	return 0;
 }
@@ -5009,6 +5086,7 @@ static void ath11k_mac_dec_num_stations(struct ath11k_vif *arvif,
 		return;
 
 	ar->num_stations--;
+	arvif->num_stations--;
 }
 
 static u32 ath11k_mac_ieee80211_sta_bw_to_wmi(struct ath11k *ar,
@@ -9536,6 +9614,21 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 		goto exit;
 	}
 
+	/* Driver allows the DEL KEY followed by SET KEY sequence for
+	 * group keys for only when there is no clients associated, if at
+	 * all firmware has entered the race during that window,
+	 * reinstalling the same key when the first sta connects will allow
+	 * firmware to recover from the race.
+	 */
+	if (arvif->num_stations == 1 && arvif->reinstall_group_keys) {
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "set group keys on 1st station add for vdev %d\n",
+			   arvif->vdev_id);
+		ret = ath11k_set_group_keys(arvif);
+		if (ret)
+			goto dec_num_station;
+		arvif->reinstall_group_keys = false;
+	}
+
 	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
 	if (!arsta->rx_stats) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 1d0d4a668946..eac5d48cade6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2370,6 +2370,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 
 	eml_cap = arg->ml.eml_cap;
 	if (u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP)) {
+		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT);
 		/* Padding delay */
 		eml_pad_delay = ieee80211_emlsr_pad_delay_in_us(eml_cap);
 		ml_params->emlsr_padding_delay_us = cpu_to_le32(eml_pad_delay);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 69ef8cf203d2..67c0c5a92f99 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -393,10 +393,8 @@ void brcmf_btcoex_detach(struct brcmf_cfg80211_info *cfg)
 	if (!cfg->btcoex)
 		return;
 
-	if (cfg->btcoex->timer_on) {
-		cfg->btcoex->timer_on = false;
-		timer_shutdown_sync(&cfg->btcoex->timer);
-	}
+	timer_shutdown_sync(&cfg->btcoex->timer);
+	cfg->btcoex->timer_on = false;
 
 	cancel_work_sync(&cfg->btcoex->work);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index bee7d92293b8..7ec22738b5d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -169,7 +169,7 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 
 	BUILD_BUG_ON(ARRAY_SIZE(acpi_dsm_size) != DSM_FUNC_NUM_FUNCS);
 
-	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
+	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size) || !func))
 		return -EINVAL;
 
 	expected_size = acpi_dsm_size[func];
@@ -178,6 +178,29 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 	if (expected_size != sizeof(u8) && expected_size != sizeof(u32))
 		return -EOPNOTSUPP;
 
+	if (!fwrt->acpi_dsm_funcs_valid) {
+		ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV,
+					       DSM_FUNC_QUERY,
+					       &iwl_guid, &tmp,
+					       acpi_dsm_size[DSM_FUNC_QUERY]);
+		if (ret) {
+			/* always indicate BIT(0) to avoid re-reading */
+			fwrt->acpi_dsm_funcs_valid = BIT(0);
+			return ret;
+		}
+
+		IWL_DEBUG_RADIO(fwrt, "ACPI DSM validity bitmap 0x%x\n",
+				(u32)tmp);
+		/* always indicate BIT(0) to avoid re-reading */
+		fwrt->acpi_dsm_funcs_valid = tmp | BIT(0);
+	}
+
+	if (!(fwrt->acpi_dsm_funcs_valid & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "ACPI DSM %d not indicated as valid\n",
+				func);
+		return -ENODATA;
+	}
+
 	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
 				       &iwl_guid, &tmp, expected_size);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 0444a736c2b2..bd3bc2846cfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -113,6 +113,10 @@ struct iwl_txf_iter_data {
  * @phy_filters: specific phy filters as read from WPFC BIOS table
  * @ppag_bios_rev: PPAG BIOS revision
  * @ppag_bios_source: see &enum bios_source
+ * @acpi_dsm_funcs_valid: bitmap indicating which DSM values are valid,
+ *	zero (default initialization) means it hasn't been read yet,
+ *	and BIT(0) is set when it has since function 0 also has this
+ *	bitmap and is always supported
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -189,6 +193,10 @@ struct iwl_fw_runtime {
 	bool uats_valid;
 	u8 uefi_tables_lock_status;
 	struct iwl_phy_specific_cfg phy_filters;
+
+#ifdef CONFIG_ACPI
+	u32 acpi_dsm_funcs_valid;
+#endif
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 48126ec6b94b..99a17b9323e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -747,6 +747,12 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		goto out;
 	}
 
+	if (!(data->functions[DSM_FUNC_QUERY] & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
+				func, data->functions[DSM_FUNC_QUERY]);
+		goto out;
+	}
+
 	*value = data->functions[func];
 
 	IWL_DEBUG_RADIO(fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 0a9e0dbb58fb..4e47ccb43bd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -670,6 +670,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
 		     DEVICE(0x0082), SUBDEV_MASKED(0xC000, 0xF000)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
+		     DEVICE(0x0085), SUBDEV_MASKED(0xC000, 0xF000)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_d_name,
 		     DEVICE(0x0082), SUBDEV(0x4820)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow1_name,
@@ -726,10 +728,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x0083), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
 		     DEVICE(0x0083), SUBDEV_MASKED(0x6, 0xF)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0084), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0084), SUBDEV(0x1216)),
-	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0084), SUBDEV(0x1316)),
+		     DEVICE(0x0084), SUBDEV_MASKED(0x6, 0xF)),
 
 /* 100 Series WiFi */
 	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
@@ -961,6 +963,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24F3), SUBDEV(0x0004)),
 	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
 		     DEVICE(0x24F3), SUBDEV(0x0044)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F5)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F6)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
 		     DEVICE(0x24FD)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
@@ -1503,11 +1511,15 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
 	 * but not bits [15:8]. So if we have bits set in lower word, assume
 	 * the device is alive.
+	 * Alternatively, if the scratch value is 0xFFFFFFFF, then we no longer
+	 * have access to the device and consider it powered off.
 	 * For older devices, just try silently to grab the NIC.
 	 */
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		if (!(iwl_read32(trans, CSR_FUNC_SCRATCH) &
-		      CSR_FUNC_SCRATCH_POWER_OFF_MASK))
+		u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
+
+		if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
+		    scratch == ~0U)
 			device_was_powered_off = true;
 	} else {
 		/*
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 2e2c193716d9..309556541a83 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1151,10 +1151,13 @@ static int lbs_associate(struct lbs_private *priv,
 	/* add SSID TLV */
 	rcu_read_lock();
 	ssid_eid = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
-	if (ssid_eid)
-		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_eid[1]);
-	else
+	if (ssid_eid) {
+		u32 ssid_len = min(ssid_eid[1], IEEE80211_MAX_SSID_LEN);
+
+		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_len);
+	} else {
 		lbs_deb_assoc("no SSID\n");
+	}
 	rcu_read_unlock();
 
 	/* add DS param TLV */
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 60c12328c2f3..8085a1ae4bdb 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4668,8 +4668,9 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
 	 * additional active scan request for hidden SSIDs on passive channels.
 	 */
 	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
-	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
-						 adapter->num_in_chan_stats));
+	adapter->chan_stats = kcalloc(adapter->num_in_chan_stats,
+				      sizeof(*adapter->chan_stats),
+				      GFP_KERNEL);
 
 	if (!adapter->chan_stats)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 7b50a88a18e5..1ec069bc8ea1 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -642,7 +642,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	goto done;
 
 err_add_intf:
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 err_init_chan_scan:
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
@@ -1485,7 +1485,7 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 	wiphy_free(adapter->wiphy);
 	adapter->wiphy = NULL;
 
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 	mwifiex_free_cmd_buffers(adapter);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 45c8db939d55..8e6ce16ab5b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -818,6 +818,43 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
+static void mt76_reset_phy(struct mt76_phy *phy)
+{
+	if (!phy)
+		return;
+
+	INIT_LIST_HEAD(&phy->tx_list);
+}
+
+void mt76_reset_device(struct mt76_dev *dev)
+{
+	int i;
+
+	rcu_read_lock();
+	for (i = 0; i < ARRAY_SIZE(dev->wcid); i++) {
+		struct mt76_wcid *wcid;
+
+		wcid = rcu_dereference(dev->wcid[i]);
+		if (!wcid)
+			continue;
+
+		wcid->sta = 0;
+		mt76_wcid_cleanup(dev, wcid);
+		rcu_assign_pointer(dev->wcid[i], NULL);
+	}
+	rcu_read_unlock();
+
+	INIT_LIST_HEAD(&dev->wcid_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	dev->vif_mask = 0;
+	memset(dev->wcid_mask, 0, sizeof(dev->wcid_mask));
+
+	mt76_reset_phy(&dev->phy);
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++)
+		mt76_reset_phy(dev->phys[i]);
+}
+EXPORT_SYMBOL_GPL(mt76_reset_device);
+
 struct mt76_phy *mt76_vif_phy(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif)
 {
@@ -1679,6 +1716,10 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 	skb_queue_splice_tail_init(&wcid->tx_pending, &list);
 	spin_unlock(&wcid->tx_pending.lock);
 
+	spin_lock(&wcid->tx_offchannel.lock);
+	skb_queue_splice_tail_init(&wcid->tx_offchannel, &list);
+	spin_unlock(&wcid->tx_offchannel.lock);
+
 	spin_unlock_bh(&phy->tx_lock);
 
 	while ((skb = __skb_dequeue(&list)) != NULL) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0ecf77fcbe3d..0290ddbb2424 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1241,6 +1241,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			 struct ieee80211_rate *rates, int n_rates);
 void mt76_unregister_device(struct mt76_dev *dev);
 void mt76_free_device(struct mt76_dev *dev);
+void mt76_reset_device(struct mt76_dev *dev);
 void mt76_unregister_phy(struct mt76_phy *phy);
 
 struct mt76_phy *mt76_alloc_radio_phy(struct mt76_dev *dev, unsigned int size,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6639976afcee..1c0d310146d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1460,17 +1460,15 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 	if (i == 10)
 		dev_err(dev->mt76.dev, "chip full reset failed\n");
 
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	while (!list_empty(&dev->mt76.sta_poll_list))
-		list_del_init(dev->mt76.sta_poll_list.next);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
-
-	memset(dev->mt76.wcid_mask, 0, sizeof(dev->mt76.wcid_mask));
-	dev->mt76.vif_mask = 0;
 	dev->phy.omac_mask = 0;
 	if (phy2)
 		phy2->omac_mask = 0;
 
+	mt76_reset_device(&dev->mt76);
+
+	INIT_LIST_HEAD(&dev->sta_rc_list);
+	INIT_LIST_HEAD(&dev->twt_list);
+
 	i = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	dev->mt76.global_wcid.idx = i;
 	dev->recovery.hw_full_reset = false;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 77f73ae1d7ec..f6b431c422eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1457,11 +1457,8 @@ static int mt7921_pre_channel_switch(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
 		return -EOPNOTSUPP;
 
-	/* Avoid beacon loss due to the CAC(Channel Availability Check) time
-	 * of the AP.
-	 */
 	if (!cfg80211_chandef_usable(hw->wiphy, &chsw->chandef,
-				     IEEE80211_CHAN_RADAR))
+				     IEEE80211_CHAN_DISABLED))
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 75823c9fd3a1..b581ab9427f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1449,7 +1449,7 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt76_connac2_tx_check_aggr(sta, txwi);
+		mt7925_tx_check_aggr(sta, e->skb, wcid);
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 5b001548dffc..5ea16a0eeea4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1191,6 +1191,9 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		struct mt792x_bss_conf *mconf;
 		struct mt792x_link_sta *mlink;
 
+		if (vif->type == NL80211_IFTYPE_AP)
+			break;
+
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		if (!link_sta)
 			continue;
@@ -2067,8 +2070,10 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 					     GFP_KERNEL);
 			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
 					     GFP_KERNEL);
-			if (!mconf || !mlink)
+			if (!mconf || !mlink) {
+				mt792x_mutex_release(dev);
 				return -ENOMEM;
+			}
 		}
 
 		mconfs[link_id] = mconf;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 300c863f0e3e..cd457be26523 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1834,13 +1834,13 @@ mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
 	struct tlv *tlv;
 	u16 eml_cap;
 
+	if (!ieee80211_vif_is_mld(vif))
+		return;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT_MLD, sizeof(*eht_mld));
 	eht_mld = (struct sta_rec_eht_mld *)tlv;
 	eht_mld->mld_type = 0xff;
 
-	if (!ieee80211_vif_is_mld(vif))
-		return;
-
 	ext_capa = cfg80211_get_iftype_ext_capa(wiphy,
 						ieee80211_vif_type_p2p(vif));
 	if (!ext_capa)
@@ -1912,6 +1912,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	struct mt76_dev *dev = phy->dev;
 	struct mt792x_bss_conf *mconf;
 	struct sk_buff *skb;
+	int conn_state;
 
 	mconf = mt792x_vif_to_link(mvif, info->wcid->link_id);
 
@@ -1920,10 +1921,13 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+				    CONN_STATE_DISCONNECT;
+
 	if (info->enable && info->link_sta) {
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
-					      info->enable, info->newly);
+					      conn_state, info->newly);
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 37b21ad828b9..a7a5ac8b7d26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -62,7 +62,7 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	int i;
 
 	wcid = mt76_wcid_ptr(dev, idx);
-	if (!wcid)
+	if (!wcid || !wcid->sta)
 		return NULL;
 
 	if (!mt7996_band_valid(dev, band_idx))
@@ -903,8 +903,12 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 				       IEEE80211_TX_CTRL_MLO_LINK);
 
 	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
-	if (mvif)
-		mlink = rcu_dereference(mvif->mt76.link[link_id]);
+	if (mvif) {
+		if (wcid->offchannel)
+			mlink = rcu_dereference(mvif->mt76.offchannel_link);
+		if (!mlink)
+			mlink = rcu_dereference(mvif->mt76.link[link_id]);
+	}
 
 	if (mlink) {
 		omac_idx = mlink->omac_idx;
@@ -1696,43 +1700,53 @@ mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
 static void
 mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct ieee80211_hw *hw = priv;
+	struct ieee80211_bss_conf *link_conf;
+	struct mt7996_phy *phy = priv;
+	struct mt7996_dev *dev = phy->dev;
+	unsigned int link_id;
+
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_AP:
-		mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
 		break;
 	default:
-		break;
+		return;
+	}
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		struct mt7996_vif_link *link;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link || link->phy != phy)
+			continue;
+
+		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf);
 	}
 }
 
+void mt7996_mac_update_beacons(struct mt7996_phy *phy)
+{
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, phy);
+}
+
 static void
 mt7996_update_beacons(struct mt7996_dev *dev)
 {
 	struct mt76_phy *phy2, *phy3;
 
-	ieee80211_iterate_active_interfaces(dev->mt76.hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7996_update_vif_beacon, dev->mt76.hw);
+	mt7996_mac_update_beacons(&dev->phy);
 
 	phy2 = dev->mt76.phys[MT_BAND1];
-	if (!phy2)
-		return;
-
-	ieee80211_iterate_active_interfaces(phy2->hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7996_update_vif_beacon, phy2->hw);
+	if (phy2)
+		mt7996_mac_update_beacons(phy2->priv);
 
 	phy3 = dev->mt76.phys[MT_BAND2];
-	if (!phy3)
-		return;
-
-	ieee80211_iterate_active_interfaces(phy3->hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7996_update_vif_beacon, phy3->hw);
+	if (phy3)
+		mt7996_mac_update_beacons(phy3->priv);
 }
 
 void mt7996_tx_token_put(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f41b2c98bc45..f6590ef85c0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -516,6 +516,9 @@ int mt7996_set_channel(struct mt76_phy *mphy)
 	struct mt7996_phy *phy = mphy->priv;
 	int ret;
 
+	if (mphy->offchannel)
+		mt7996_mac_update_beacons(phy);
+
 	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_SWITCH);
 	if (ret)
 		goto out;
@@ -533,6 +536,8 @@ int mt7996_set_channel(struct mt76_phy *mphy)
 
 	mt7996_mac_reset_counters(phy);
 	phy->noise = 0;
+	if (!mphy->offchannel)
+		mt7996_mac_update_beacons(phy);
 
 out:
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index dd4b7b8c34ea..a808218da394 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1879,8 +1879,8 @@ mt7996_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version)
 {
+	struct uni_header hdr = {};
 	struct ra_fixed_rate *req;
-	struct uni_header hdr;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 	int len;
@@ -2755,13 +2755,15 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link_conf)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt76_vif_link *mlink = mt76_vif_conf_link(&dev->mt76, vif, link_conf);
+	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
+	struct mt76_vif_link *mlink = link ? &link->mt76 : NULL;
 	struct ieee80211_mutable_offsets offs;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
 	struct bss_bcn_content_tlv *bcn;
 	int len, extra_len = 0;
+	bool enabled = link_conf->enable_beacon;
 
 	if (link_conf->nontransmitted)
 		return 0;
@@ -2769,13 +2771,16 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!mlink)
 		return -EINVAL;
 
+	if (link->phy && link->phy->mt76->offchannel)
+		enabled = false;
+
 	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink,
 					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, link_conf->link_id);
-	if (link_conf->enable_beacon && !skb) {
+	if (enabled && !skb) {
 		dev_kfree_skb(rskb);
 		return -EINVAL;
 	}
@@ -2794,7 +2799,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	len = ALIGN(sizeof(*bcn) + MT_TXD_SIZE + extra_len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_CONTENT, len);
 	bcn = (struct bss_bcn_content_tlv *)tlv;
-	bcn->enable = link_conf->enable_beacon;
+	bcn->enable = enabled;
 	if (!bcn->enable)
 		goto out;
 
@@ -3372,7 +3377,7 @@ int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans)
 {
 	struct {
 		u8 __rsv[4];
-	} __packed hdr;
+	} __packed hdr = {};
 	struct hdr_trans_blacklist *req_blacklist;
 	struct hdr_trans_en *req_en;
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 33ac16b64ef1..8509d508e1e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -732,6 +732,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
 			   enum mt76_txq_id qid, u32 changed);
+void mt7996_mac_update_beacons(struct mt7996_phy *phy);
 void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
 void mt7996_mac_work(struct work_struct *work);
 void mt7996_mac_reset_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index e6cf16706667..8ab5840fee57 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -332,6 +332,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct sk_buff_head *head;
 
 	if (mt76_testmode_enabled(phy)) {
@@ -349,7 +350,8 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 
 	if ((info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) ||
-	    (info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK))
+	    ((info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK) &&
+	     ieee80211_is_probe_req(hdr->frame_control)))
 		head = &wcid->tx_offchannel;
 	else
 		head = &wcid->tx_pending;
@@ -644,6 +646,7 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 {
 	LIST_HEAD(tx_list);
+	int ret = 0;
 
 	if (list_empty(&phy->tx_list))
 		return;
@@ -655,13 +658,13 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 	list_splice_init(&phy->tx_list, &tx_list);
 	while (!list_empty(&tx_list)) {
 		struct mt76_wcid *wcid;
-		int ret;
 
 		wcid = list_first_entry(&tx_list, struct mt76_wcid, tx_list);
 		list_del_init(&wcid->tx_list);
 
 		spin_unlock(&phy->tx_lock);
-		ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_offchannel);
+		if (ret >= 0)
+			ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_offchannel);
 		if (ret >= 0 && !phy->offchannel)
 			ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_pending);
 		spin_lock(&phy->tx_lock);
@@ -670,9 +673,6 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 		    !skb_queue_empty(&wcid->tx_offchannel) &&
 		    list_empty(&wcid->tx_list))
 			list_add_tail(&wcid->tx_list, &phy->tx_list);
-
-		if (ret < 0)
-			break;
 	}
 	spin_unlock(&phy->tx_lock);
 
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 5dd7f6a38900..cc56018b2e32 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1290,7 +1290,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 		rcu_read_lock();
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 		if (ssidie) {
-			join.ssid_len = ssidie[1];
+			join.ssid_len = min(ssidie[1], IEEE80211_MAX_SSID_LEN);
 			memcpy(join.ssid, &ssidie[2], join.ssid_len);
 		}
 		rcu_read_unlock();
diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 230d5f628c1b..cd2dc8e825c9 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
 			r = -EINVAL;
 		}
 
-		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
+		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
 			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
+			if (!r)
+				node_set(nid, numa_nodes_parsed);
+		}
 
 		if (!i || r) {
 			of_node_put(np);
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 1b1dff56ec7b..441cdf83f5a4 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -215,6 +215,8 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 
 	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
index b04b16496b0c..2677b577c1f8 100644
--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index bf9d070a4496..da494fe451ba 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -375,7 +375,9 @@ static int do_validate_mem(struct pcmcia_socket *s,
 
 	if (validate && !s->fake_cis) {
 		/* move it to the validated data set */
-		add_interval(&s_data->mem_db_valid, base, size);
+		ret = add_interval(&s_data->mem_db_valid, base, size);
+		if (ret)
+			return ret;
 		sub_interval(&s_data->mem_db, base, size);
 	}
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 69336bd778ee..13eb22b35aa8 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -129,6 +129,7 @@ enum acer_wmi_predator_v4_oc {
 enum acer_wmi_gaming_misc_setting {
 	ACER_WMID_MISC_SETTING_OC_1			= 0x0005,
 	ACER_WMID_MISC_SETTING_OC_2			= 0x0007,
+	/* Unreliable on some models */
 	ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES	= 0x000A,
 	ACER_WMID_MISC_SETTING_PLATFORM_PROFILE		= 0x000B,
 };
@@ -794,9 +795,6 @@ static bool platform_profile_support;
  */
 static int last_non_turbo_profile = INT_MIN;
 
-/* The most performant supported profile */
-static int acer_predator_v4_max_perf;
-
 enum acer_predator_v4_thermal_profile {
 	ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET		= 0x00,
 	ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED	= 0x01,
@@ -2014,7 +2012,7 @@ acer_predator_v4_platform_profile_set(struct device *dev,
 	if (err)
 		return err;
 
-	if (tp != acer_predator_v4_max_perf)
+	if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO)
 		last_non_turbo_profile = tp;
 
 	return 0;
@@ -2023,55 +2021,14 @@ acer_predator_v4_platform_profile_set(struct device *dev,
 static int
 acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
 {
-	unsigned long supported_profiles;
-	int err;
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
 
-	err = WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES,
-					   (u8 *)&supported_profiles);
-	if (err)
-		return err;
-
-	/* Iterate through supported profiles in order of increasing performance */
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_ECO, &supported_profiles)) {
-		set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
-		acer_predator_v4_max_perf = ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
-		last_non_turbo_profile = ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET, &supported_profiles)) {
-		set_bit(PLATFORM_PROFILE_QUIET, choices);
-		acer_predator_v4_max_perf = ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
-		last_non_turbo_profile = ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED, &supported_profiles)) {
-		set_bit(PLATFORM_PROFILE_BALANCED, choices);
-		acer_predator_v4_max_perf = ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
-		last_non_turbo_profile = ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE, &supported_profiles)) {
-		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
-		acer_predator_v4_max_perf = ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE;
-
-		/* We only use this profile as a fallback option in case no prior
-		 * profile is supported.
-		 */
-		if (last_non_turbo_profile < 0)
-			last_non_turbo_profile = ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO, &supported_profiles)) {
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
-		acer_predator_v4_max_perf = ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
-
-		/* We need to handle the hypothetical case where only the turbo profile
-		 * is supported. In this case the turbo toggle will essentially be a
-		 * no-op.
-		 */
-		if (last_non_turbo_profile < 0)
-			last_non_turbo_profile = ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
-	}
+	/* Set default non-turbo profile */
+	last_non_turbo_profile = ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
 
 	return 0;
 }
@@ -2108,19 +2065,15 @@ static int acer_thermal_profile_change(void)
 		if (cycle_gaming_thermal_profile) {
 			platform_profile_cycle();
 		} else {
-			/* Do nothing if no suitable platform profiles where found */
-			if (last_non_turbo_profile < 0)
-				return 0;
-
 			err = WMID_gaming_get_misc_setting(
 				ACER_WMID_MISC_SETTING_PLATFORM_PROFILE, &current_tp);
 			if (err)
 				return err;
 
-			if (current_tp == acer_predator_v4_max_perf)
+			if (current_tp == ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO)
 				tp = last_non_turbo_profile;
 			else
-				tp = acer_predator_v4_max_perf;
+				tp = ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
 
 			err = WMID_gaming_set_misc_setting(
 				ACER_WMID_MISC_SETTING_PLATFORM_PROFILE, tp);
@@ -2128,7 +2081,7 @@ static int acer_thermal_profile_change(void)
 				return err;
 
 			/* Store last profile for toggle */
-			if (current_tp != acer_predator_v4_max_perf)
+			if (current_tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO)
 				last_non_turbo_profile = current_tp;
 
 			platform_profile_notify(platform_profile_device);
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index ded4c84f5ed1..18fb44139de2 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -28,10 +28,15 @@ static struct quirk_entry quirk_spurious_8042 = {
 	.spurious_8042 = true,
 };
 
+static struct quirk_entry quirk_s2idle_spurious_8042 = {
+	.s2idle_bug_mmio = FCH_PM_BASE + FCH_PM_SCRATCH,
+	.spurious_8042 = true,
+};
+
 static const struct dmi_system_id fwbug_list[] = {
 	{
 		.ident = "L14 Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20X5"),
@@ -39,7 +44,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "T14s Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20XF"),
@@ -47,7 +52,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "X13 Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20XH"),
@@ -55,7 +60,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "T14 Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20XK"),
@@ -63,7 +68,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "T14 Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UD"),
@@ -71,7 +76,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "T14 Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UE"),
@@ -79,7 +84,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "T14s Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
@@ -87,7 +92,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "T14s Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
@@ -95,7 +100,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "P14s Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "20Y1"),
@@ -103,7 +108,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "P14s Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A0"),
@@ -111,7 +116,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "P14s Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
@@ -152,7 +157,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "IdeaPad 1 14AMN7",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
@@ -160,7 +165,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "IdeaPad 1 15AMN7",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
@@ -168,7 +173,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "IdeaPad 1 15AMN7",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
@@ -176,7 +181,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "IdeaPad Slim 3 14AMN8",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
@@ -184,7 +189,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	},
 	{
 		.ident = "IdeaPad Slim 3 15AMN8",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
@@ -193,7 +198,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4434 */
 	{
 		.ident = "Lenovo Yoga 6 13ALC6",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
@@ -202,7 +207,7 @@ static const struct dmi_system_id fwbug_list[] = {
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
 	{
 		.ident = "HP Laptop 15s-eq2xxx",
-		.driver_data = &quirk_s2idle_bug,
+		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15s-eq2xxx"),
@@ -243,6 +248,20 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
 		}
 	},
+	{
+		.ident = "TUXEDO InfinityBook Pro 14/15 AMD Gen10",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxHP4NAx"),
+		}
+	},
+	{
+		.ident = "TUXEDO InfinityBook Pro 14/15 AMD Gen10",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		}
+	},
 	{}
 };
 
@@ -285,6 +304,16 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 {
 	const struct dmi_system_id *dmi_id;
 
+	/*
+	 * IRQ1 may cause an interrupt during resume even without a keyboard
+	 * press.
+	 *
+	 * Affects Renoir, Cezanne and Barcelo SoCs
+	 *
+	 * A solution is available in PMFW 64.66.0, but it must be activated by
+	 * SBIOS. If SBIOS is known to have the fix a quirk can be added for
+	 * a given system to avoid workaround.
+	 */
 	if (dev->cpu_id == AMD_CPU_ID_CZN)
 		dev->disable_8042_wakeup = true;
 
@@ -295,6 +324,5 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 	if (dev->quirks->s2idle_bug_mmio)
 		pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
 			dmi_id->ident);
-	if (dev->quirks->spurious_8042)
-		dev->disable_8042_wakeup = true;
+	dev->disable_8042_wakeup = dev->quirks->spurious_8042;
 }
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 0b9b23eb7c2c..bd318fd02ccf 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -530,19 +530,6 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
 {
 	struct device *d;
-	int rc;
-
-	/* cezanne platform firmware has a fix in 64.66.0 */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
-		if (!pdev->major) {
-			rc = amd_pmc_get_smu_version(pdev);
-			if (rc)
-				return rc;
-		}
-
-		if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
-			return 0;
-	}
 
 	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
 	if (!d)
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index f84c3d03c1de..e6726be5890e 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -655,8 +655,6 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
-	case 0x5D: /* Wireless console Toggle */
-	case 0x5E: /* Wireless console Enable */
 	case 0x5F: /* Wireless console Disable */
 		if (quirks->ignore_key_wlan)
 			*code = ASUS_WMI_KEY_IGNORE;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f7191fdded14..e72a2b5d158e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -5088,16 +5088,22 @@ static int asus_wmi_probe(struct platform_device *pdev)
 
 	asus_s2idle_check_register();
 
-	return asus_wmi_add(pdev);
+	ret = asus_wmi_add(pdev);
+	if (ret)
+		asus_s2idle_check_unregister();
+
+	return ret;
 }
 
 static bool used;
+static DEFINE_MUTEX(register_mutex);
 
 int __init_or_module asus_wmi_register_driver(struct asus_wmi_driver *driver)
 {
 	struct platform_driver *platform_driver;
 	struct platform_device *platform_device;
 
+	guard(mutex)(&register_mutex);
 	if (used)
 		return -EBUSY;
 
@@ -5120,6 +5126,7 @@ EXPORT_SYMBOL_GPL(asus_wmi_register_driver);
 
 void asus_wmi_unregister_driver(struct asus_wmi_driver *driver)
 {
+	guard(mutex)(&register_mutex);
 	asus_s2idle_check_unregister();
 
 	platform_device_unregister(driver->platform_device);
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 9d8247bb9cfa..8641353b2e06 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -178,7 +178,7 @@ static int tpmi_get_logical_id(unsigned int cpu, struct tpmi_cpu_info *info)
 
 	info->punit_thread_id = FIELD_GET(LP_ID_MASK, data);
 	info->punit_core_id = FIELD_GET(MODULE_ID_MASK, data);
-	info->pkg_id = topology_physical_package_id(cpu);
+	info->pkg_id = topology_logical_package_id(cpu);
 	info->linux_cpu = cpu;
 
 	return 0;
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 1e7f72e57557..538828547595 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4557,8 +4557,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_debugfs_remove_device(bp);
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
-	if (timer_pending(&bp->watchdog))
-		timer_delete_sync(&bp->watchdog);
+	timer_delete_sync(&bp->watchdog);
 	if (bp->ts0)
 		ptp_ocp_unregister_ext(bp->ts0);
 	if (bp->ts1)
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index fba2e62027b7..4cfc928bcf2d 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1243,7 +1243,7 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_async_xchg_ctx *ctxp =
 		container_of(rsp, struct lpfc_async_xchg_ctx, hdlrctx.fcp_req);
-	struct rqb_dmabuf *nvmebuf = ctxp->rqb_buffer;
+	struct rqb_dmabuf *nvmebuf;
 	struct lpfc_hba *phba = ctxp->phba;
 	unsigned long iflag;
 
@@ -1251,13 +1251,18 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	lpfc_nvmeio_data(phba, "NVMET DEFERRCV: xri x%x sz %d CPU %02x\n",
 			 ctxp->oxid, ctxp->size, raw_smp_processor_id());
 
+	spin_lock_irqsave(&ctxp->ctxlock, iflag);
+	nvmebuf = ctxp->rqb_buffer;
 	if (!nvmebuf) {
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
 				"6425 Defer rcv: no buffer oxid x%x: "
 				"flg %x ste %x\n",
 				ctxp->oxid, ctxp->flag, ctxp->state);
 		return;
 	}
+	ctxp->rqb_buffer = NULL;
+	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 	tgtp = phba->targetport->private;
 	if (tgtp)
@@ -1265,9 +1270,6 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 
 	/* Free the nvmebuf since a new buffer already replaced it */
 	nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
-	spin_lock_irqsave(&ctxp->ctxlock, iflag);
-	ctxp->rqb_buffer = NULL;
-	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
 /**
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index b17796d5ee66..add13e306898 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -475,13 +475,21 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 
 static int sr_revalidate_disk(struct scsi_cd *cd)
 {
+	struct request_queue *q = cd->device->request_queue;
 	struct scsi_sense_hdr sshdr;
+	struct queue_limits lim;
+	int sector_size;
 
 	/* if the unit is not ready, nothing more to do */
 	if (scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES, &sshdr))
 		return 0;
 	sr_cd_check(&cd->cdi);
-	return get_sectorsize(cd);
+	sector_size = get_sectorsize(cd);
+
+	lim = queue_limits_start_update(q);
+	lim.logical_block_size = sector_size;
+	lim.features |= BLK_FEAT_ROTATIONAL;
+	return queue_limits_commit_update_frozen(q, &lim);
 }
 
 static int sr_block_open(struct gendisk *disk, blk_mode_t mode)
@@ -721,10 +729,8 @@ static int sr_probe(struct device *dev)
 
 static int get_sectorsize(struct scsi_cd *cd)
 {
-	struct request_queue *q = cd->device->request_queue;
 	static const u8 cmd[10] = { READ_CAPACITY };
 	unsigned char buffer[8] = { };
-	struct queue_limits lim;
 	int err;
 	int sector_size;
 	struct scsi_failure failure_defs[] = {
@@ -795,9 +801,7 @@ static int get_sectorsize(struct scsi_cd *cd)
 		set_capacity(cd->disk, cd->capacity);
 	}
 
-	lim = queue_limits_start_update(q);
-	lim.logical_block_size = sector_size;
-	return queue_limits_commit_update_frozen(q, &lim);
+	return sector_size;
 }
 
 static int get_capabilities(struct scsi_cd *cd)
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 64e0facc392e..29124aa6d03b 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -39,12 +39,14 @@ static bool mdt_header_valid(const struct firmware *fw)
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
-		return false;
+	if (ehdr->e_shentsize || ehdr->e_shnum) {
+		if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+			return false;
 
-	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
-	if (shend > fw->size)
-		return false;
+		shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+		if (shend > fw->size)
+			return false;
+	}
 
 	return true;
 }
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1a22d356a73d..90e4028ca14f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,8 +3,9 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
-// Copyright 2018 NXP Semiconductors
+// Copyright 2018, 2023, 2025 NXP
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -70,7 +71,7 @@
 #define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
-#define CFGR1_PCSPOL	BIT(8)
+#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_HOST	BIT(0)
 #define FSR_TXCOUNT	(0xFF)
@@ -82,6 +83,8 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
 
+#define SR_CLEAR_MASK	GENMASK(13, 8)
+
 struct fsl_lpspi_devtype_data {
 	u8 prescale_max;
 };
@@ -424,7 +427,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	else
 		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
-		temp |= CFGR1_PCSPOL;
+		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
+				   BIT(fsl_lpspi->config.chip_select));
+
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
@@ -533,14 +538,13 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 		fsl_lpspi_intctrl(fsl_lpspi, 0);
 	}
 
-	/* W1C for all flags in SR */
-	temp = 0x3F << 8;
-	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
-
 	/* Clear FIFO and disable module */
 	temp = CR_RRF | CR_RTF;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 
+	/* W1C for all flags in SR */
+	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
+
 	return 0;
 }
 
@@ -731,12 +735,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
 	ret = fsl_lpspi_wait_for_completion(controller);
-	if (ret)
-		return ret;
 
 	fsl_lpspi_reset(fsl_lpspi);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
@@ -786,7 +788,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index fa828fcaaef2..073607fb51cb 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -458,10 +458,6 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct mchp_coreqspi *qspi = spi_controller_get_devdata(mem->spi->controller);
-	unsigned long clk_hz;
-	u32 baud_rate_val;
-
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
@@ -484,14 +480,6 @@ static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_
 			return false;
 	}
 
-	clk_hz = clk_get_rate(qspi->clk);
-	if (!clk_hz)
-		return false;
-
-	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
-	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER)
-		return false;
-
 	return true;
 }
 
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index e98e997680c7..cfc81327f7a4 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1615,11 +1615,13 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed.\n");
-		goto err_spi_init;
+		goto err_register_controller;
 	}
 
 	return 0;
 
+err_register_controller:
+	nand_ecc_unregister_on_host_hw_engine(&snandc->qspi->ecc_eng);
 err_spi_init:
 	qcom_nandc_unalloc(snandc);
 err_snand_alloc:
@@ -1641,7 +1643,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	spi_unregister_controller(ctlr);
-
+	nand_ecc_unregister_on_host_hw_engine(&snandc->qspi->ecc_eng);
 	qcom_nandc_unalloc(snandc);
 
 	clk_disable_unprepare(snandc->aon_clk);
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f9ef7d94cebd..a963eed70c1d 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
  * with a matching configuration.
  */
 
-static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
+static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
@@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	ffa_ops = ffa_dev->ops;
 	notif_ops = ffa_ops->notifier_ops;
 
-	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..2a7d253d9c55 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -230,7 +230,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
 		rc = -ENOMEM;
-		goto err;
+		goto err_pages;
 	}
 
 	for (i = 0; i < nr_pages; i++)
@@ -243,11 +243,13 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 		rc = shm_register(shm->ctx, shm, pages, nr_pages,
 				  (unsigned long)shm->kaddr);
 		if (rc)
-			goto err;
+			goto err_kfree;
 	}
 
 	return 0;
-err:
+err_kfree:
+	kfree(pages);
+err_pages:
 	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
 	return rc;
@@ -560,9 +562,13 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
  */
 void tee_shm_put(struct tee_shm *shm)
 {
-	struct tee_device *teedev = shm->ctx->teedev;
+	struct tee_device *teedev;
 	bool do_release = false;
 
+	if (!shm || !shm->ctx || !shm->ctx->teedev)
+		return;
+
+	teedev = shm->ctx->teedev;
 	mutex_lock(&teedev->mutex);
 	if (refcount_dec_and_test(&shm->refcount)) {
 		/*
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a79fa0726f1d..216eff293ffe 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -248,7 +248,7 @@ struct btrfs_inode {
 		u64 new_delalloc_bytes;
 		/*
 		 * The offset of the last dir index key that was logged.
-		 * This is used only for directories.
+		 * This is used only for directories. Protected by 'log_mutex'.
 		 */
 		u64 last_dir_index_offset;
 	};
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3711a5d07342..fac4000a5bca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1483,7 +1483,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 /*
  * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors.
+ * Return <0 for critical errors, and the sector will have its dirty flag cleared.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
@@ -1506,8 +1506,17 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(filepos < i_size);
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
-	if (IS_ERR(em))
+	if (IS_ERR(em)) {
+		/*
+		 * When submission failed, we should still clear the folio dirty.
+		 * Or the folio will be written back again but without any
+		 * ordered extent.
+		 */
+		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
 		return PTR_ERR(em);
+	}
 
 	extent_offset = filepos - em->start;
 	em_end = btrfs_extent_map_end(em);
@@ -1637,8 +1646,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
 	 *
-	 * If we hit any error, the corresponding sector will still be dirty
-	 * thus no need to clear PAGECACHE_TAG_DIRTY.
+	 * If we hit any error, the corresponding sector will have its dirty
+	 * flag cleared and writeback finished, thus no need to handle the error case.
 	 */
 	if (!submitted_io && !error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df4c8312aae3..ffa5d6c15940 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7827,6 +7827,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_sub_trans = 0;
 	ei->logged_trans = 0;
 	ei->delalloc_bytes = 0;
+	/* new_delalloc_bytes and last_dir_index_offset are in a union. */
 	ei->new_delalloc_bytes = 0;
 	ei->defrag_bytes = 0;
 	ei->disk_i_size = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index afc05e406689..56d30ec0f52f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3309,6 +3309,31 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static bool mark_inode_as_not_logged(const struct btrfs_trans_handle *trans,
+				     struct btrfs_inode *inode)
+{
+	bool ret = false;
+
+	/*
+	 * Do this only if ->logged_trans is still 0 to prevent races with
+	 * concurrent logging as we may see the inode not logged when
+	 * inode_logged() is called but it gets logged after inode_logged() did
+	 * not find it in the log tree and we end up setting ->logged_trans to a
+	 * value less than trans->transid after the concurrent logging task has
+	 * set it to trans->transid. As a consequence, subsequent rename, unlink
+	 * and link operations may end up not logging new names and removing old
+	 * names from the log.
+	 */
+	spin_lock(&inode->lock);
+	if (inode->logged_trans == 0)
+		inode->logged_trans = trans->transid - 1;
+	else if (inode->logged_trans == trans->transid)
+		ret = true;
+	spin_unlock(&inode->lock);
+
+	return ret;
+}
+
 /*
  * Check if an inode was logged in the current transaction. This correctly deals
  * with the case where the inode was logged but has a logged_trans of 0, which
@@ -3326,15 +3351,32 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
-	if (inode->logged_trans == trans->transid)
+	/*
+	 * Quick lockless call, since once ->logged_trans is set to the current
+	 * transaction, we never set it to a lower value anywhere else.
+	 */
+	if (data_race(inode->logged_trans) == trans->transid)
 		return 1;
 
 	/*
-	 * If logged_trans is not 0, then we know the inode logged was not logged
-	 * in this transaction, so we can return false right away.
+	 * If logged_trans is not 0 and not trans->transid, then we know the
+	 * inode was not logged in this transaction, so we can return false
+	 * right away. We take the lock to avoid a race caused by load/store
+	 * tearing with a concurrent btrfs_log_inode() call or a concurrent task
+	 * in this function further below - an update to trans->transid can be
+	 * teared into two 32 bits updates for example, in which case we could
+	 * see a positive value that is not trans->transid and assume the inode
+	 * was not logged when it was.
 	 */
-	if (inode->logged_trans > 0)
+	spin_lock(&inode->lock);
+	if (inode->logged_trans == trans->transid) {
+		spin_unlock(&inode->lock);
+		return 1;
+	} else if (inode->logged_trans > 0) {
+		spin_unlock(&inode->lock);
 		return 0;
+	}
+	spin_unlock(&inode->lock);
 
 	/*
 	 * If no log tree was created for this root in this transaction, then
@@ -3343,10 +3385,8 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	 * transaction's ID, to avoid the search below in a future call in case
 	 * a log tree gets created after this.
 	 */
-	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state)) {
-		inode->logged_trans = trans->transid - 1;
-		return 0;
-	}
+	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state))
+		return mark_inode_as_not_logged(trans, inode);
 
 	/*
 	 * We have a log tree and the inode's logged_trans is 0. We can't tell
@@ -3400,8 +3440,7 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 		 * Set logged_trans to a value greater than 0 and less then the
 		 * current transaction to avoid doing the search in future calls.
 		 */
-		inode->logged_trans = trans->transid - 1;
-		return 0;
+		return mark_inode_as_not_logged(trans, inode);
 	}
 
 	/*
@@ -3409,20 +3448,9 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	 * the current transacion's ID, to avoid future tree searches as long as
 	 * the inode is not evicted again.
 	 */
+	spin_lock(&inode->lock);
 	inode->logged_trans = trans->transid;
-
-	/*
-	 * If it's a directory, then we must set last_dir_index_offset to the
-	 * maximum possible value, so that the next attempt to log the inode does
-	 * not skip checking if dir index keys found in modified subvolume tree
-	 * leaves have been logged before, otherwise it would result in attempts
-	 * to insert duplicate dir index keys in the log tree. This must be done
-	 * because last_dir_index_offset is an in-memory only field, not persisted
-	 * in the inode item or any other on-disk structure, so its value is lost
-	 * once the inode is evicted.
-	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode))
-		inode->last_dir_index_offset = (u64)-1;
+	spin_unlock(&inode->lock);
 
 	return 1;
 }
@@ -4014,7 +4042,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 
 /*
  * If the inode was logged before and it was evicted, then its
- * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * last_dir_index_offset is 0, so we don't know the value of the last index
  * key offset. If that's the case, search for it and update the inode. This
  * is to avoid lookups in the log tree every time we try to insert a dir index
  * key from a leaf changed in the current transaction, and to allow us to always
@@ -4030,7 +4058,7 @@ static int update_last_dir_index_offset(struct btrfs_inode *inode,
 
 	lockdep_assert_held(&inode->log_mutex);
 
-	if (inode->last_dir_index_offset != (u64)-1)
+	if (inode->last_dir_index_offset != 0)
 		return 0;
 
 	if (!ctx->logged_before) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index af5ba3ad2eb8..d7a1193332d9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2252,6 +2252,40 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 	rcu_read_unlock();
 }
 
+static int call_zone_finish(struct btrfs_block_group *block_group,
+			    struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_device *device = stripe->dev;
+	const u64 physical = stripe->physical;
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	int ret;
+
+	if (!device->bdev)
+		return 0;
+
+	if (zinfo->max_active_zones == 0)
+		return 0;
+
+	if (btrfs_dev_is_sequential(device, physical)) {
+		unsigned int nofs_flags;
+
+		nofs_flags = memalloc_nofs_save();
+		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+				       physical >> SECTOR_SHIFT,
+				       zinfo->zone_size >> SECTOR_SHIFT);
+		memalloc_nofs_restore(nofs_flags);
+
+		if (ret)
+			return ret;
+	}
+
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
+		zinfo->reserved_active_zones++;
+	btrfs_dev_clear_active_zone(device, physical);
+
+	return 0;
+}
+
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
@@ -2336,31 +2370,12 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	down_read(&dev_replace->rwsem);
 	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
-		struct btrfs_device *device = map->stripes[i].dev;
-		const u64 physical = map->stripes[i].physical;
-		struct btrfs_zoned_device_info *zinfo = device->zone_info;
-		unsigned int nofs_flags;
-
-		if (!device->bdev)
-			continue;
-
-		if (zinfo->max_active_zones == 0)
-			continue;
-
-		nofs_flags = memalloc_nofs_save();
-		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
-				       physical >> SECTOR_SHIFT,
-				       zinfo->zone_size >> SECTOR_SHIFT);
-		memalloc_nofs_restore(nofs_flags);
 
+		ret = call_zone_finish(block_group, &map->stripes[i]);
 		if (ret) {
 			up_read(&dev_replace->rwsem);
 			return ret;
 		}
-
-		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
-			zinfo->reserved_active_zones++;
-		btrfs_dev_clear_active_zone(device, physical);
 	}
 	up_read(&dev_replace->rwsem);
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..a07b8cf73ae2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2608,10 +2608,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			wakeup_bdi = inode_io_list_move_locked(inode, wb,
 							       dirty_list);
 
-			spin_unlock(&wb->list_lock);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_dirty_inode_enqueue(inode);
-
 			/*
 			 * If this is the first dirty inode for this bdi,
 			 * we have to wake-up the corresponding bdi thread
@@ -2621,6 +2617,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (wakeup_bdi &&
 			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
 				wb_wakeup_delayed(wb);
+
+			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
+			trace_writeback_dirty_inode_enqueue(inode);
+
 			return;
 		}
 	}
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 12e5d1f73325..561d3b755fe8 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1219,6 +1219,9 @@ static void ocfs2_clear_inode(struct inode *inode)
 	 * the journal is flushed before journal shutdown. Thus it is safe to
 	 * have inodes get cleaned up after journal shutdown.
 	 */
+	if (!osb->journal)
+		return;
+
 	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
 				       &oi->ip_jinode);
 }
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index e0e50914ab25..409bc1d11eca 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -364,6 +364,25 @@ static const struct inode_operations proc_dir_inode_operations = {
 	.setattr	= proc_notify_change,
 };
 
+static void pde_set_flags(struct proc_dir_entry *pde)
+{
+	const struct proc_ops *proc_ops = pde->proc_ops;
+
+	if (!proc_ops)
+		return;
+
+	if (proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
+		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
+	if (proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
+}
+
 /* returns the registered entry, or frees dp and returns NULL on failure */
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp)
@@ -371,6 +390,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
+	pde_set_flags(dp);
+
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
 	if (pde_subdir_insert(dir, dp) == false) {
@@ -559,20 +580,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static void pde_set_flags(struct proc_dir_entry *pde)
-{
-	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
-		pde->flags |= PROC_ENTRY_PERMANENT;
-	if (pde->proc_ops->proc_read_iter)
-		pde->flags |= PROC_ENTRY_proc_read_iter;
-#ifdef CONFIG_COMPAT
-	if (pde->proc_ops->proc_compat_ioctl)
-		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
-#endif
-	if (pde->proc_ops->proc_lseek)
-		pde->flags |= PROC_ENTRY_proc_lseek;
-}
-
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		const struct proc_ops *proc_ops, void *data)
@@ -583,7 +590,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 	if (!p)
 		return NULL;
 	p->proc_ops = proc_ops;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
@@ -634,7 +640,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -665,7 +670,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index 4cc6e0896fad..f8659d36793f 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -629,6 +629,9 @@ cifs_strndup_to_utf16(const char *src, const int maxlen, int *utf16_len,
 	int len;
 	__le16 *dst;
 
+	if (!src)
+		return NULL;
+
 	len = cifs_local_to_utf16_bytes(src, maxlen, cp);
 	len += 2; /* NULL */
 	dst = kmalloc(len, GFP_KERNEL);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index df366ee15456..e62064cb9e08 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -169,6 +169,7 @@ enum cpuhp_state {
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_TEGRA_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
+	CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_REALTEK_TIMER_STARTING,
diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..9174fa59bbc5
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0b6e1f781d86..6dbf8303bd0e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1695,6 +1695,22 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
@@ -1815,10 +1831,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..2759dac6be44 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -219,22 +219,6 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 		     struct page **pages, unsigned int page_shift);
 
-/*
- * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
- */
-#ifndef ARCH_PAGE_TABLE_SYNC_MASK
-#define ARCH_PAGE_TABLE_SYNC_MASK 0
-#endif
-
-/*
- * There is no default implementation for arch_sync_kernel_mappings(). It is
- * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
- * is 0.
- */
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
-
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
diff --git a/include/net/sock.h b/include/net/sock.h
index e3ab20345685..a348ae145eda 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -285,6 +285,7 @@ struct sk_filter;
   *	@sk_ack_backlog: current listen backlog
   *	@sk_max_ack_backlog: listen backlog set in listen()
   *	@sk_uid: user id of owner
+  *	@sk_ino: inode number (zero if orphaned)
   *	@sk_prefer_busy_poll: prefer busypolling over softirq processing
   *	@sk_busy_poll_budget: napi processing budget when busypolling
   *	@sk_priority: %SO_PRIORITY setting
@@ -518,6 +519,7 @@ struct sock {
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
 	kuid_t			sk_uid;
+	unsigned long		sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
 	struct pid		*sk_peer_pid;
@@ -2056,6 +2058,10 @@ static inline int sk_rx_queue_get(const struct sock *sk)
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
 	sk->sk_socket = sock;
+	if (sock) {
+		WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
+		WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
+	}
 }
 
 static inline wait_queue_head_t *sk_sleep(struct sock *sk)
@@ -2077,6 +2083,7 @@ static inline void sock_orphan(struct sock *sk)
 	sk_set_socket(sk, NULL);
 	sk->sk_wq  = NULL;
 	/* Note: sk_uid is unchanged. */
+	WRITE_ONCE(sk->sk_ino, 0);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -2087,12 +2094,15 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	parent->sk = sk;
 	sk_set_socket(sk, parent);
-	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	security_sock_graft(sk, parent);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
-kuid_t sock_i_uid(struct sock *sk);
+static inline unsigned long sock_i_ino(const struct sock *sk)
+{
+	/* Paired with WRITE_ONCE() in sock_graft() and sock_orphan() */
+	return READ_ONCE(sk->sk_ino);
+}
 
 static inline kuid_t sk_uid(const struct sock *sk)
 {
@@ -2100,9 +2110,6 @@ static inline kuid_t sk_uid(const struct sock *sk)
 	return READ_ONCE(sk->sk_uid);
 }
 
-unsigned long __sock_i_ino(struct sock *sk);
-unsigned long sock_i_ino(struct sock *sk);
-
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
 {
 	return sk ? sk_uid(sk) : make_kuid(net->user_ns, 0);
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 2beb30be2c5f..8e0eb832bc01 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1784,10 +1784,12 @@ enum nft_synproxy_attributes {
  * enum nft_device_attributes - nf_tables device netlink attributes
  *
  * @NFTA_DEVICE_NAME: name of this device (NLA_STRING)
+ * @NFTA_DEVICE_PREFIX: device name prefix, a simple wildcard (NLA_STRING)
  */
 enum nft_devices_attributes {
 	NFTA_DEVICE_UNSPEC,
 	NFTA_DEVICE_NAME,
+	NFTA_DEVICE_PREFIX,
 	__NFTA_DEVICE_MAX
 };
 #define NFTA_DEVICE_MAX		(__NFTA_DEVICE_MAX - 1)
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index e3f42018ed46..f7708fe2c457 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
 
 	/* handle trailing slashes */
 	pathlen -= parentlen;
-	while (p[pathlen - 1] == '/')
+	while (pathlen > 0 && p[pathlen - 1] == '/')
 		pathlen--;
 
 	if (pathlen != dlen)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe48e020..ac36069bd252 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2212,6 +2212,8 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 		goto unlock;
 
 	hop_masks = bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]), hop_cmp);
+	if (!hop_masks)
+		goto unlock;
 	hop = hop_masks	- k.masks;
 
 	ret = hop ?
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ced6b29fcf76..8fce3370c84e 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index c9cdafdde132..00ca3c4def37 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1578,9 +1578,11 @@ static void kasan_strings(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 
 	src = kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
 	strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
+	OPTIMIZER_HIDE_VAR(src);
 
 	/*
 	 * Make sure that strscpy() does not trigger KASAN if it overreads into
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 84265983f239..1ac56ceb29b6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -437,9 +437,15 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 		else if (untagged_objp == untagged_ptr || alias)
 			return object;
 		else {
+			/*
+			 * Printk deferring due to the kmemleak_lock held.
+			 * This is done to avoid deadlock.
+			 */
+			printk_deferred_enter();
 			kmemleak_warn("Found object by alias at 0x%08lx\n",
 				      ptr);
 			dump_object_info(object);
+			printk_deferred_exit();
 			break;
 		}
 	}
@@ -736,6 +742,11 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 		else if (untagged_objp + parent->size <= untagged_ptr)
 			link = &parent->rb_node.rb_right;
 		else {
+			/*
+			 * Printk deferring due to the kmemleak_lock held.
+			 * This is done to avoid deadlock.
+			 */
+			printk_deferred_enter();
 			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
 				      ptr);
 			/*
@@ -743,6 +754,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 			 * be freed while the kmemleak_lock is held.
 			 */
 			dump_object_info(parent);
+			printk_deferred_exit();
 			return -EEXIST;
 		}
 	}
@@ -856,13 +868,8 @@ static void delete_object_part(unsigned long ptr, size_t size,
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = __find_and_remove_object(ptr, 1, objflags);
-	if (!object) {
-#ifdef DEBUG
-		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
-			      ptr, size);
-#endif
+	if (!object)
 		goto unlock;
-	}
 
 	/*
 	 * Create one or two objects that may result from the memory block
@@ -882,8 +889,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
 
 unlock:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
-	if (object)
+	if (object) {
 		__delete_object(object);
+	} else {
+#ifdef DEBUG
+		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
+			      ptr, size);
+#endif
+	}
 
 out:
 	if (object_l)
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..ce460711fa4e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3108,7 +3108,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 
 	if (pgd_none(*pgd)) {
 		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
 		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/slub.c b/mm/slub.c
index 394646988b1c..09b6404ac575 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -926,19 +926,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 #ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(void)
+static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	depot_stack_handle_t handle;
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
-	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+	handle = stack_depot_save(entries, nr_entries, gfp_flags);
 
 	return handle;
 }
 #else
-static inline depot_stack_handle_t set_track_prepare(void)
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	return 0;
 }
@@ -960,9 +960,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -1104,7 +1104,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, reason);
-	print_trailer(s, slab, object);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 	WARN_ON(1);
@@ -1885,9 +1890,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
-static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
-			     enum track_item alloc, unsigned long addr) {}
+			     enum track_item alloc, unsigned long addr, gfp_t gfp_flags) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -3844,9 +3849,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			 * For debug caches here we had to go through
 			 * alloc_single_from_partial() so just store the
 			 * tracking info and return the object.
+			 *
+			 * Due to disabled preemption we need to disallow
+			 * blocking. The flags are further adjusted by
+			 * gfp_nested_mask() in stack_depot itself.
 			 */
 			if (s->flags & SLAB_STORE_USER)
-				set_track(s, freelist, TRACK_ALLOC, addr);
+				set_track(s, freelist, TRACK_ALLOC, addr,
+					  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 			return freelist;
 		}
@@ -3878,7 +3888,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr,
+				  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 		return freelist;
 	}
@@ -4389,8 +4400,12 @@ static noinline void free_to_partial_list(
 	unsigned long flags;
 	depot_stack_handle_t handle = 0;
 
+	/*
+	 * We cannot use GFP_NOWAIT as there are callsites where waking up
+	 * kswapd could deadlock
+	 */
 	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
+		handle = set_track_prepare(__GFP_NOWARN);
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fd2ab5118e13..dbd8daccade2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 #include "hugetlb_vmemmap.h"
@@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
@@ -578,11 +578,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
-	if (system_state == SYSTEM_BOOTING)
-		memmap_boot_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
-	else
-		memmap_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
-
 	return pfn_to_page(pfn);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 3c012cf83cc2..e6075b622407 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -454,9 +454,6 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
-	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
-#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -567,6 +564,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				sparse_buffer_fini();
 				goto failed;
 			}
+			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+							   PAGE_SIZE));
 			sparse_init_early_section(nid, map, pnum, 0);
 		}
 	}
@@ -680,7 +679,6 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
@@ -856,10 +854,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early)
+	if (!section_is_early) {
+		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	else if (memmap)
+	} else if (memmap) {
+		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
+							  PAGE_SIZE)));
 		free_map_bootmem(memmap);
+	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -904,6 +906,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2f4b98f2c8ad..563449d7b092 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1453,10 +1453,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		folio_unlock(src_folio);
 		folio_put(src_folio);
 	}
-	if (dst_pte)
-		pte_unmap(dst_pte);
+	/*
+	 * Unmap in reverse order (LIFO) to maintain proper kmap_local
+	 * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte
+	 * first, then src_pte, so we must unmap src_pte first, then dst_pte.
+	 */
 	if (src_pte)
 		pte_unmap(src_pte);
+	if (dst_pte)
+		pte_unmap(dst_pte);
 	mmu_notifier_invalidate_range_end(&range);
 	if (si)
 		put_swap_device(si);
diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
index 9c1241292d1d..01787fb6a7bc 100644
--- a/net/appletalk/atalk_proc.c
+++ b/net/appletalk/atalk_proc.c
@@ -181,7 +181,7 @@ static int atalk_seq_socket_show(struct seq_file *seq, void *v)
 		   sk_wmem_alloc_get(s),
 		   sk_rmem_alloc_get(s),
 		   s->sk_state,
-		   from_kuid_munged(seq_user_ns(seq), sock_i_uid(s)));
+		   from_kuid_munged(seq_user_ns(seq), sk_uid(s)));
 out:
 	return 0;
 }
diff --git a/net/atm/resources.c b/net/atm/resources.c
index b19d851e1f44..7c6fdedbcf4e 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -112,7 +112,9 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 
 	if (atm_proc_dev_register(dev) < 0) {
 		pr_err("atm_proc_dev_register failed for dev %s\n", type);
-		goto out_fail;
+		mutex_unlock(&atm_dev_mutex);
+		kfree(dev);
+		return NULL;
 	}
 
 	if (atm_register_sysfs(dev, parent) < 0) {
@@ -128,7 +130,7 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 	return dev;
 
 out_fail:
-	kfree(dev);
+	put_device(&dev->class_dev);
 	dev = NULL;
 	goto out;
 }
diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index 1cac25aca637..f2d66af86359 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -433,6 +433,10 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 int ax25_kiss_rcv(struct sk_buff *skb, struct net_device *dev,
 		  struct packet_type *ptype, struct net_device *orig_dev)
 {
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	skb_orphan(skb);
 
 	if (!net_eq(dev_net(dev), &init_net)) {
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9f56308779cc..af97d077369f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 6ad2f72f53f4..ee9bf84c88a7 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -815,7 +815,7 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 			   refcount_read(&sk->sk_refcnt),
 			   sk_rmem_alloc_get(sk),
 			   sk_wmem_alloc_get(sk),
-			   from_kuid(seq_user_ns(seq), sock_i_uid(sk)),
+			   from_kuid(seq_user_ns(seq), sk_uid(sk)),
 			   sock_i_ino(sk),
 			   bt->parent ? sock_i_ino(bt->parent) : 0LU);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 749bba1512eb..a25439f1eeac 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3344,7 +3344,7 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	 * advertising data. This also applies to the case
 	 * where BR/EDR was toggled during the AUTO_OFF phase.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	    list_empty(&hdev->adv_instances)) {
 		if (ext_adv_capable(hdev)) {
 			err = hci_setup_ext_adv_instance_sync(hdev, 0x00);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 82d943c4cb50..05b7480970f7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1422,7 +1422,10 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	l2cap_sock_cleanup_listen(sk);
+	release_sock(sk);
+
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, SHUT_RDWR);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 94cbe967d1c1..083e2fe96441 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -626,9 +626,6 @@ static unsigned int br_nf_local_in(void *priv,
 		break;
 	}
 
-	ct = container_of(nfct, struct nf_conn, ct_general);
-	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
-
 	return ret;
 }
 #endif
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index 7d426a8e29f3..f112156db587 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -90,10 +90,12 @@ static void est_timer(struct timer_list *t)
 	rate = (b_packets - est->last_packets) << (10 - est->intvl_log);
 	rate = (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
 
+	preempt_disable_nested();
 	write_seqcount_begin(&est->seq);
 	est->avbps += brate;
 	est->avpps += rate;
 	write_seqcount_end(&est->seq);
+	preempt_enable_nested();
 
 	est->last_bytes = b_bytes;
 	est->last_packets = b_packets;
diff --git a/net/core/sock.c b/net/core/sock.c
index 9fae9239f939..10c1df62338b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2788,39 +2788,6 @@ void sock_pfree(struct sk_buff *skb)
 EXPORT_SYMBOL(sock_pfree);
 #endif /* CONFIG_INET */
 
-kuid_t sock_i_uid(struct sock *sk)
-{
-	kuid_t uid;
-
-	read_lock_bh(&sk->sk_callback_lock);
-	uid = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_uid : GLOBAL_ROOT_UID;
-	read_unlock_bh(&sk->sk_callback_lock);
-	return uid;
-}
-EXPORT_SYMBOL(sock_i_uid);
-
-unsigned long __sock_i_ino(struct sock *sk)
-{
-	unsigned long ino;
-
-	read_lock(&sk->sk_callback_lock);
-	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock(&sk->sk_callback_lock);
-	return ino;
-}
-EXPORT_SYMBOL(__sock_i_ino);
-
-unsigned long sock_i_ino(struct sock *sk)
-{
-	unsigned long ino;
-
-	local_bh_disable();
-	ino = __sock_i_ino(sk);
-	local_bh_enable();
-	return ino;
-}
-EXPORT_SYMBOL(sock_i_ino);
-
 /*
  * Allocate a skb from the socket's send buffer.
  */
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c47d3828d4f6..942a887bf089 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -340,14 +340,13 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 static int __init inet_blackhole_dev_init(void)
 {
-	int err = 0;
+	struct in_device *in_dev;
 
 	rtnl_lock();
-	if (!inetdev_init(blackhole_netdev))
-		err = -ENOMEM;
+	in_dev = inetdev_init(blackhole_netdev);
 	rtnl_unlock();
 
-	return err;
+	return PTR_ERR_OR_ZERO(in_dev);
 }
 late_initcall(inet_blackhole_dev_init);
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 717cb7d3607a..14beae97f81b 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -797,11 +797,12 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	struct sk_buff *cloned_skb = NULL;
 	struct ip_options opts = { 0 };
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct nf_conn *ct;
 	__be32 orig_ip;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmp_send(skb_in, type, code, info, &opts);
 		return;
 	}
@@ -816,7 +817,8 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 		goto out;
 
 	orig_ip = ip_hdr(skb_in)->saddr;
-	ip_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.ip;
+	dir = CTINFO2DIR(ctinfo);
+	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
 	__icmp_send(skb_in, type, code, info, &opts);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 46750c96d08e..f4157d26ec9e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -168,7 +168,7 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
 }
 
 static bool inet_bind_conflict(const struct sock *sk, struct sock *sk2,
-			       kuid_t sk_uid, bool relax,
+			       kuid_t uid, bool relax,
 			       bool reuseport_cb_ok, bool reuseport_ok)
 {
 	int bound_dev_if2;
@@ -185,12 +185,12 @@ static bool inet_bind_conflict(const struct sock *sk, struct sock *sk2,
 			if (!relax || (!reuseport_ok && sk->sk_reuseport &&
 				       sk2->sk_reuseport && reuseport_cb_ok &&
 				       (sk2->sk_state == TCP_TIME_WAIT ||
-					uid_eq(sk_uid, sock_i_uid(sk2)))))
+					uid_eq(uid, sk_uid(sk2)))))
 				return true;
 		} else if (!reuseport_ok || !sk->sk_reuseport ||
 			   !sk2->sk_reuseport || !reuseport_cb_ok ||
 			   (sk2->sk_state != TCP_TIME_WAIT &&
-			    !uid_eq(sk_uid, sock_i_uid(sk2)))) {
+			    !uid_eq(uid, sk_uid(sk2)))) {
 			return true;
 		}
 	}
@@ -198,7 +198,7 @@ static bool inet_bind_conflict(const struct sock *sk, struct sock *sk2,
 }
 
 static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *sk2,
-				   kuid_t sk_uid, bool relax,
+				   kuid_t uid, bool relax,
 				   bool reuseport_cb_ok, bool reuseport_ok)
 {
 	if (ipv6_only_sock(sk2)) {
@@ -211,20 +211,20 @@ static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *sk2,
 #endif
 	}
 
-	return inet_bind_conflict(sk, sk2, sk_uid, relax,
+	return inet_bind_conflict(sk, sk2, uid, relax,
 				  reuseport_cb_ok, reuseport_ok);
 }
 
 static bool inet_bhash2_conflict(const struct sock *sk,
 				 const struct inet_bind2_bucket *tb2,
-				 kuid_t sk_uid,
+				 kuid_t uid,
 				 bool relax, bool reuseport_cb_ok,
 				 bool reuseport_ok)
 {
 	struct sock *sk2;
 
 	sk_for_each_bound(sk2, &tb2->owners) {
-		if (__inet_bhash2_conflict(sk, sk2, sk_uid, relax,
+		if (__inet_bhash2_conflict(sk, sk2, uid, relax,
 					   reuseport_cb_ok, reuseport_ok))
 			return true;
 	}
@@ -242,8 +242,8 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind2_bucket *tb2, /* may be null */
 				  bool relax, bool reuseport_ok)
 {
-	kuid_t uid = sock_i_uid((struct sock *)sk);
 	struct sock_reuseport *reuseport_cb;
+	kuid_t uid = sk_uid(sk);
 	bool reuseport_cb_ok;
 	struct sock *sk2;
 
@@ -287,11 +287,11 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l3mdev,
 					  bool relax, bool reuseport_ok)
 {
-	kuid_t uid = sock_i_uid((struct sock *)sk);
 	const struct net *net = sock_net(sk);
 	struct sock_reuseport *reuseport_cb;
 	struct inet_bind_hashbucket *head2;
 	struct inet_bind2_bucket *tb2;
+	kuid_t uid = sk_uid(sk);
 	bool conflict = false;
 	bool reuseport_cb_ok;
 
@@ -425,15 +425,13 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
 				     struct sock *sk)
 {
-	kuid_t uid = sock_i_uid(sk);
-
 	if (tb->fastreuseport <= 0)
 		return 0;
 	if (!sk->sk_reuseport)
 		return 0;
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		return 0;
-	if (!uid_eq(tb->fastuid, uid))
+	if (!uid_eq(tb->fastuid, sk_uid(sk)))
 		return 0;
 	/* We only need to check the rcv_saddr if this tb was once marked
 	 * without fastreuseport and then was reset, as we can only know that
@@ -458,14 +456,13 @@ static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
 void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 			       struct sock *sk)
 {
-	kuid_t uid = sock_i_uid(sk);
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 
 	if (hlist_empty(&tb->bhash2)) {
 		tb->fastreuse = reuse;
 		if (sk->sk_reuseport) {
 			tb->fastreuseport = FASTREUSEPORT_ANY;
-			tb->fastuid = uid;
+			tb->fastuid = sk_uid(sk);
 			tb->fast_rcv_saddr = sk->sk_rcv_saddr;
 			tb->fast_ipv6_only = ipv6_only_sock(sk);
 			tb->fast_sk_family = sk->sk_family;
@@ -492,7 +489,7 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 			 */
 			if (!sk_reuseport_match(tb, sk)) {
 				tb->fastreuseport = FASTREUSEPORT_STRICT;
-				tb->fastuid = uid;
+				tb->fastuid = sk_uid(sk);
 				tb->fast_rcv_saddr = sk->sk_rcv_saddr;
 				tb->fast_ipv6_only = ipv6_only_sock(sk);
 				tb->fast_sk_family = sk->sk_family;
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 1d1d6ad53f4c..2fa53b16fe77 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -181,7 +181,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 		goto errout;
 #endif
 
-	r->idiag_uid = from_kuid_munged(user_ns, sock_i_uid(sk));
+	r->idiag_uid = from_kuid_munged(user_ns, sk_uid(sk));
 	r->idiag_inode = sock_i_ino(sk);
 
 	memset(&inet_sockopt, 0, sizeof(inet_sockopt));
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 77a0b52b2eab..ceeeec9b7290 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -721,8 +721,8 @@ static int inet_reuseport_add_sock(struct sock *sk,
 {
 	struct inet_bind_bucket *tb = inet_csk(sk)->icsk_bind_hash;
 	const struct hlist_nulls_node *node;
+	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
-	kuid_t uid = sock_i_uid(sk);
 
 	sk_nulls_for_each_rcu(sk2, node, &ilb->nulls_head) {
 		if (sk2 != sk &&
@@ -730,7 +730,7 @@ static int inet_reuseport_add_sock(struct sock *sk,
 		    ipv6_only_sock(sk2) == ipv6_only_sock(sk) &&
 		    sk2->sk_bound_dev_if == sk->sk_bound_dev_if &&
 		    inet_csk(sk2)->icsk_bind_hash == tb &&
-		    sk2->sk_reuseport && uid_eq(uid, sock_i_uid(sk2)) &&
+		    sk2->sk_reuseport && uid_eq(uid, sk_uid(sk2)) &&
 		    inet_rcv_saddr_equal(sk, sk2, false))
 			return reuseport_add_sock(sk, sk2,
 						  inet_rcv_saddr_any(sk));
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 4eacaf00e2e9..031df4c19fcc 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -1116,7 +1116,7 @@ static void ping_v4_format_sock(struct sock *sp, struct seq_file *f,
 		sk_wmem_alloc_get(sp),
 		sk_rmem_alloc_get(sp),
 		0, 0L, 0,
-		from_kuid_munged(seq_user_ns(f), sock_i_uid(sp)),
+		from_kuid_munged(seq_user_ns(f), sk_uid(sp)),
 		0, sock_i_ino(sp),
 		refcount_read(&sp->sk_refcnt), sp,
 		atomic_read(&sp->sk_drops));
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 32f942d0f944..1d2c89d63cc7 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -1043,7 +1043,7 @@ static void raw_sock_seq_show(struct seq_file *seq, struct sock *sp, int i)
 		sk_wmem_alloc_get(sp),
 		sk_rmem_alloc_get(sp),
 		0, 0L, 0,
-		from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
+		from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
 		0, sock_i_ino(sp),
 		refcount_read(&sp->sk_refcnt), sp, atomic_read(&sp->sk_drops));
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..429fb34b075e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2896,7 +2896,7 @@ static void get_openreq4(const struct request_sock *req,
 		jiffies_delta_to_clock_t(delta),
 		req->num_timeout,
 		from_kuid_munged(seq_user_ns(f),
-				 sock_i_uid(req->rsk_listener)),
+				 sk_uid(req->rsk_listener)),
 		0,  /* non standard timer */
 		0, /* open_requests have no inode */
 		0,
@@ -2954,7 +2954,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 		timer_active,
 		jiffies_delta_to_clock_t(timer_expires - jiffies),
 		icsk->icsk_retransmits,
-		from_kuid_munged(seq_user_ns(f), sock_i_uid(sk)),
+		from_kuid_munged(seq_user_ns(f), sk_uid(sk)),
 		icsk->icsk_probes_out,
 		sock_i_ino(sk),
 		refcount_read(&sk->sk_refcnt), sk,
@@ -3246,9 +3246,9 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		const struct request_sock *req = v;
 
 		uid = from_kuid_munged(seq_user_ns(seq),
-				       sock_i_uid(req->rsk_listener));
+				       sk_uid(req->rsk_listener));
 	} else {
-		uid = from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
+		uid = from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
 	}
 
 	meta.seq = seq;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f94bb222aa2d..19573ee64a0f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -145,8 +145,8 @@ static int udp_lib_lport_inuse(struct net *net, __u16 num,
 			       unsigned long *bitmap,
 			       struct sock *sk, unsigned int log)
 {
+	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
-	kuid_t uid = sock_i_uid(sk);
 
 	sk_for_each(sk2, &hslot->head) {
 		if (net_eq(sock_net(sk2), net) &&
@@ -158,7 +158,7 @@ static int udp_lib_lport_inuse(struct net *net, __u16 num,
 		    inet_rcv_saddr_equal(sk, sk2, true)) {
 			if (sk2->sk_reuseport && sk->sk_reuseport &&
 			    !rcu_access_pointer(sk->sk_reuseport_cb) &&
-			    uid_eq(uid, sock_i_uid(sk2))) {
+			    uid_eq(uid, sk_uid(sk2))) {
 				if (!bitmap)
 					return 0;
 			} else {
@@ -180,8 +180,8 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
 				struct udp_hslot *hslot2,
 				struct sock *sk)
 {
+	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
-	kuid_t uid = sock_i_uid(sk);
 	int res = 0;
 
 	spin_lock(&hslot2->lock);
@@ -195,7 +195,7 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
 		    inet_rcv_saddr_equal(sk, sk2, true)) {
 			if (sk2->sk_reuseport && sk->sk_reuseport &&
 			    !rcu_access_pointer(sk->sk_reuseport_cb) &&
-			    uid_eq(uid, sock_i_uid(sk2))) {
+			    uid_eq(uid, sk_uid(sk2))) {
 				res = 0;
 			} else {
 				res = 1;
@@ -210,7 +210,7 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
 static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
 {
 	struct net *net = sock_net(sk);
-	kuid_t uid = sock_i_uid(sk);
+	kuid_t uid = sk_uid(sk);
 	struct sock *sk2;
 
 	sk_for_each(sk2, &hslot->head) {
@@ -220,7 +220,7 @@ static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
 		    ipv6_only_sock(sk2) == ipv6_only_sock(sk) &&
 		    (udp_sk(sk2)->udp_port_hash == udp_sk(sk)->udp_port_hash) &&
 		    (sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
-		    sk2->sk_reuseport && uid_eq(uid, sock_i_uid(sk2)) &&
+		    sk2->sk_reuseport && uid_eq(uid, sk_uid(sk2)) &&
 		    inet_rcv_saddr_equal(sk, sk2, false)) {
 			return reuseport_add_sock(sk, sk2,
 						  inet_rcv_saddr_any(sk));
@@ -3387,7 +3387,7 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 		sk_wmem_alloc_get(sp),
 		udp_rqueue_get(sp),
 		0, 0L, 0,
-		from_kuid_munged(seq_user_ns(f), sock_i_uid(sp)),
+		from_kuid_munged(seq_user_ns(f), sk_uid(sp)),
 		0, sock_i_ino(sp),
 		refcount_read(&sp->sk_refcnt), sp,
 		atomic_read(&sp->sk_drops));
@@ -3630,7 +3630,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 		goto unlock;
 	}
 
-	uid = from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
+	uid = from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, false);
 	ret = udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 83f5aa5e133a..281722817a65 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -1064,7 +1064,7 @@ void __ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
 		   sk_wmem_alloc_get(sp),
 		   rqueue,
 		   0, 0L, 0,
-		   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
+		   from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
 		   0,
 		   sock_i_ino(sp),
 		   refcount_read(&sp->sk_refcnt), sp,
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 9e3574880cb0..233914b63bdb 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -54,11 +54,12 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 	struct inet6_skb_parm parm = { 0 };
 	struct sk_buff *cloned_skb = NULL;
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct in6_addr orig_ip;
 	struct nf_conn *ct;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmpv6_send(skb_in, type, code, info, &parm);
 		return;
 	}
@@ -73,7 +74,8 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 		goto out;
 
 	orig_ip = ipv6_hdr(skb_in)->saddr;
-	ipv6_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.in6;
+	dir = CTINFO2DIR(ctinfo);
+	ipv6_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.in6;
 	__icmpv6_send(skb_in, type, code, info, &parm);
 	ipv6_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f61b0396ef6b..5604ae6163f4 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1431,17 +1431,17 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	ireq = inet_rsk(req);
 
 	if (sk_acceptq_is_full(sk))
-		goto out_overflow;
+		goto exit_overflow;
 
 	if (!dst) {
 		dst = inet6_csk_route_req(sk, &fl6, req, IPPROTO_TCP);
 		if (!dst)
-			goto out;
+			goto exit;
 	}
 
 	newsk = tcp_create_openreq_child(sk, req, skb);
 	if (!newsk)
-		goto out_nonewsk;
+		goto exit_nonewsk;
 
 	/*
 	 * No need to charge this sock to the relevant IPv6 refcnt debug socks
@@ -1525,25 +1525,19 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 			const union tcp_md5_addr *addr;
 
 			addr = (union tcp_md5_addr *)&newsk->sk_v6_daddr;
-			if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key)) {
-				inet_csk_prepare_forced_close(newsk);
-				tcp_done(newsk);
-				goto out;
-			}
+			if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key))
+				goto put_and_exit;
 		}
 	}
 #endif
 #ifdef CONFIG_TCP_AO
 	/* Copy over tcp_ao_info if any */
 	if (tcp_ao_copy_all_matching(sk, newsk, req, skb, AF_INET6))
-		goto out; /* OOM */
+		goto put_and_exit; /* OOM */
 #endif
 
-	if (__inet_inherit_port(sk, newsk) < 0) {
-		inet_csk_prepare_forced_close(newsk);
-		tcp_done(newsk);
-		goto out;
-	}
+	if (__inet_inherit_port(sk, newsk) < 0)
+		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
 				       &found_dup_sk);
 	if (*own_req) {
@@ -1570,13 +1564,17 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	return newsk;
 
-out_overflow:
+exit_overflow:
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENOVERFLOWS);
-out_nonewsk:
+exit_nonewsk:
 	dst_release(dst);
-out:
+exit:
 	tcp_listendrop(sk);
 	return NULL;
+put_and_exit:
+	inet_csk_prepare_forced_close(newsk);
+	tcp_done(newsk);
+	goto exit;
 }
 
 INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
@@ -2168,7 +2166,7 @@ static void get_openreq6(struct seq_file *seq,
 		   jiffies_to_clock_t(ttd),
 		   req->num_timeout,
 		   from_kuid_munged(seq_user_ns(seq),
-				    sock_i_uid(req->rsk_listener)),
+				    sk_uid(req->rsk_listener)),
 		   0,  /* non standard timer */
 		   0, /* open_requests have no inode */
 		   0, req);
@@ -2234,7 +2232,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 		   timer_active,
 		   jiffies_delta_to_clock_t(timer_expires - jiffies),
 		   icsk->icsk_retransmits,
-		   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
+		   from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
 		   icsk->icsk_probes_out,
 		   sock_i_ino(sp),
 		   refcount_read(&sp->sk_refcnt), sp,
diff --git a/net/key/af_key.c b/net/key/af_key.c
index b5d761700776..2ebde0352245 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3788,7 +3788,7 @@ static int pfkey_seq_show(struct seq_file *f, void *v)
 			       refcount_read(&s->sk_refcnt),
 			       sk_rmem_alloc_get(s),
 			       sk_wmem_alloc_get(s),
-			       from_kuid_munged(seq_user_ns(f), sock_i_uid(s)),
+			       from_kuid_munged(seq_user_ns(f), sk_uid(s)),
 			       sock_i_ino(s)
 			       );
 	return 0;
diff --git a/net/llc/llc_proc.c b/net/llc/llc_proc.c
index 07e9abb5978a..aa81c67b24a1 100644
--- a/net/llc/llc_proc.c
+++ b/net/llc/llc_proc.c
@@ -151,7 +151,7 @@ static int llc_seq_socket_show(struct seq_file *seq, void *v)
 		   sk_wmem_alloc_get(sk),
 		   sk_rmem_alloc_get(sk) - llc->copied_seq,
 		   sk->sk_state,
-		   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
+		   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
 		   llc->link);
 out:
 	return 0;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 006d02dce949..b73a6d7f3e93 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1193,6 +1193,14 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			     "required MCSes not supported, disabling EHT\n");
 	}
 
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
+	    channel->band != NL80211_BAND_2GHZ &&
+	    conn->bw_limit == IEEE80211_CONN_BW_LIMIT_40) {
+		conn->mode = IEEE80211_CONN_MODE_HE;
+		link_id_info(sdata, link_id,
+			     "required bandwidth not supported, disabling EHT\n");
+	}
+
 	/* the mode can only decrease, so this must terminate */
 	if (ap_mode != conn->mode) {
 		kfree(elems);
diff --git a/net/mac80211/tests/chan-mode.c b/net/mac80211/tests/chan-mode.c
index 96c7b3ab2744..adc069065e73 100644
--- a/net/mac80211/tests/chan-mode.c
+++ b/net/mac80211/tests/chan-mode.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel mode functions
  *
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <kunit/test.h>
@@ -28,6 +28,10 @@ static const struct determine_chan_mode_case {
 	u8 vht_basic_mcs_1_4, vht_basic_mcs_5_8;
 	u8 he_basic_mcs_1_4, he_basic_mcs_5_8;
 	u8 eht_mcs7_min_nss;
+	u16 eht_disabled_subchannels;
+	u8 eht_bw;
+	enum ieee80211_conn_bw_limit conn_bw_limit;
+	enum ieee80211_conn_bw_limit expected_bw_limit;
 	int error;
 } determine_chan_mode_cases[] = {
 	{
@@ -128,6 +132,14 @@ static const struct determine_chan_mode_case {
 		.conn_mode = IEEE80211_CONN_MODE_EHT,
 		.eht_mcs7_min_nss = 0x15,
 		.error = EINVAL,
+	}, {
+		.desc = "80 MHz EHT is downgraded to 40 MHz HE due to puncturing",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HE,
+		.conn_bw_limit = IEEE80211_CONN_BW_LIMIT_80,
+		.expected_bw_limit = IEEE80211_CONN_BW_LIMIT_40,
+		.eht_disabled_subchannels = 0x08,
+		.eht_bw = IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ,
 	}
 };
 KUNIT_ARRAY_PARAM_DESC(determine_chan_mode, determine_chan_mode_cases, desc)
@@ -138,7 +150,7 @@ static void test_determine_chan_mode(struct kunit *test)
 	struct t_sdata *t_sdata = T_SDATA(test);
 	struct ieee80211_conn_settings conn = {
 		.mode = params->conn_mode,
-		.bw_limit = IEEE80211_CONN_BW_LIMIT_20,
+		.bw_limit = params->conn_bw_limit,
 	};
 	struct cfg80211_bss cbss = {
 		.channel = &t_sdata->band_5ghz.channels[0],
@@ -191,14 +203,21 @@ static void test_determine_chan_mode(struct kunit *test)
 		0x7f, 0x01, 0x00, 0x88, 0x88, 0x88, 0x00, 0x00,
 		0x00,
 		/* EHT Operation */
-		WLAN_EID_EXTENSION, 0x09, WLAN_EID_EXT_EHT_OPERATION,
-		0x01, params->eht_mcs7_min_nss ? params->eht_mcs7_min_nss : 0x11,
-		0x00, 0x00, 0x00, 0x00, 0x24, 0x00,
+		WLAN_EID_EXTENSION, 0x0b, WLAN_EID_EXT_EHT_OPERATION,
+		0x03, params->eht_mcs7_min_nss ? params->eht_mcs7_min_nss : 0x11,
+		0x00, 0x00, 0x00, params->eht_bw,
+		params->eht_bw == IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ ? 42 : 36,
+		0x00,
+		u16_get_bits(params->eht_disabled_subchannels, 0xff),
+		u16_get_bits(params->eht_disabled_subchannels, 0xff00),
 	};
 	struct ieee80211_chan_req chanreq = {};
 	struct cfg80211_chan_def ap_chandef = {};
 	struct ieee802_11_elems *elems;
 
+	/* To force EHT downgrade to HE on punctured 80 MHz downgraded to 40 MHz */
+	set_bit(IEEE80211_HW_DISALLOW_PUNCTURING, t_sdata->local.hw.flags);
+
 	if (params->strict)
 		set_bit(IEEE80211_HW_STRICT, t_sdata->local.hw.flags);
 	else
@@ -237,6 +256,7 @@ static void test_determine_chan_mode(struct kunit *test)
 	} else {
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elems);
 		KUNIT_ASSERT_EQ(test, conn.mode, params->expected_mode);
+		KUNIT_ASSERT_EQ(test, conn.bw_limit, params->expected_bw_limit);
 	}
 }
 
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 9d5db3feedec..4dee06171361 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -346,7 +346,7 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 
-	return -EINVAL;
+	return -ENOPROTOOPT;
 }
 
 /* helpers for reading/writing the tag ioc, handling compatibility across the
diff --git a/net/mctp/route.c b/net/mctp/route.c
index d9c8e5a5f9ce..19ff259d7bc4 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -325,6 +325,7 @@ static void mctp_skb_set_flow(struct sk_buff *skb, struct mctp_sk_key *key) {}
 static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev) {}
 #endif
 
+/* takes ownership of skb, both in success and failure cases */
 static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 {
 	struct mctp_hdr *hdr = mctp_hdr(skb);
@@ -334,8 +335,10 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 		& MCTP_HDR_SEQ_MASK;
 
 	if (!key->reasm_head) {
-		/* Since we're manipulating the shared frag_list, ensure it isn't
-		 * shared with any other SKBs.
+		/* Since we're manipulating the shared frag_list, ensure it
+		 * isn't shared with any other SKBs. In the cloned case,
+		 * this will free the skb; callers can no longer access it
+		 * safely.
 		 */
 		key->reasm_head = skb_unshare(skb, GFP_ATOMIC);
 		if (!key->reasm_head)
@@ -349,10 +352,10 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 	exp_seq = (key->last_seq + 1) & MCTP_HDR_SEQ_MASK;
 
 	if (this_seq != exp_seq)
-		return -EINVAL;
+		goto err_free;
 
 	if (key->reasm_head->len + skb->len > mctp_message_maxlen)
-		return -EINVAL;
+		goto err_free;
 
 	skb->next = NULL;
 	skb->sk = NULL;
@@ -366,6 +369,10 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 	key->reasm_head->truesize += skb->truesize;
 
 	return 0;
+
+err_free:
+	kfree_skb(skb);
+	return -EINVAL;
 }
 
 static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
@@ -476,18 +483,16 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * key isn't observable yet
 			 */
 			mctp_frag_queue(key, skb);
+			skb = NULL;
 
 			/* if the key_add fails, we've raced with another
 			 * SOM packet with the same src, dest and tag. There's
 			 * no way to distinguish future packets, so all we
-			 * can do is drop; we'll free the skb on exit from
-			 * this function.
+			 * can do is drop.
 			 */
 			rc = mctp_key_add(key, msk);
-			if (!rc) {
+			if (!rc)
 				trace_mctp_key_acquire(key);
-				skb = NULL;
-			}
 
 			/* we don't need to release key->lock on exit, so
 			 * clean up here and suppress the unlock via
@@ -505,8 +510,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 				key = NULL;
 			} else {
 				rc = mctp_frag_queue(key, skb);
-				if (!rc)
-					skb = NULL;
+				skb = NULL;
 			}
 		}
 
@@ -516,17 +520,16 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		 */
 
 		/* we need to be continuing an existing reassembly... */
-		if (!key->reasm_head)
+		if (!key->reasm_head) {
 			rc = -EINVAL;
-		else
+		} else {
 			rc = mctp_frag_queue(key, skb);
+			skb = NULL;
+		}
 
 		if (rc)
 			goto out_unlock;
 
-		/* we've queued; the queue owns the skb now */
-		skb = NULL;
-
 		/* end of message? deliver to socket, and we're done with
 		 * the reassembly/response key
 		 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76cb699885b3..1063c53850c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3537,7 +3537,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_lock_bh(&sk->sk_callback_lock);
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	sk_set_socket(sk, parent);
-	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 4ed5878cb25b..ceb48c3ca0a4 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -368,7 +368,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 			    (cur->tuple.src.l3num == NFPROTO_UNSPEC ||
 			     cur->tuple.src.l3num == me->tuple.src.l3num) &&
 			    cur->tuple.dst.protonum == me->tuple.dst.protonum) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
@@ -379,7 +379,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 		hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
 			if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple,
 						     &mask)) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 46ca725d6538..0e86434ca13b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1953,6 +1953,18 @@ static int nft_dump_stats(struct sk_buff *skb, struct nft_stats __percpu *stats)
 	return -ENOSPC;
 }
 
+static bool hook_is_prefix(struct nft_hook *hook)
+{
+	return strlen(hook->ifname) >= hook->ifnamelen;
+}
+
+static int nft_nla_put_hook_dev(struct sk_buff *skb, struct nft_hook *hook)
+{
+	int attr = hook_is_prefix(hook) ? NFTA_DEVICE_PREFIX : NFTA_DEVICE_NAME;
+
+	return nla_put_string(skb, attr, hook->ifname);
+}
+
 static int nft_dump_basechain_hook(struct sk_buff *skb,
 				   const struct net *net, int family,
 				   const struct nft_base_chain *basechain,
@@ -1984,16 +1996,15 @@ static int nft_dump_basechain_hook(struct sk_buff *skb,
 			if (!first)
 				first = hook;
 
-			if (nla_put(skb, NFTA_DEVICE_NAME,
-				    hook->ifnamelen, hook->ifname))
+			if (nft_nla_put_hook_dev(skb, hook))
 				goto nla_put_failure;
 			n++;
 		}
 		nla_nest_end(skb, nest_devs);
 
 		if (n == 1 &&
-		    nla_put(skb, NFTA_HOOK_DEV,
-			    first->ifnamelen, first->ifname))
+		    !hook_is_prefix(first) &&
+		    nla_put_string(skb, NFTA_HOOK_DEV, first->ifname))
 			goto nla_put_failure;
 	}
 	nla_nest_end(skb, nest);
@@ -2297,7 +2308,8 @@ void nf_tables_chain_destroy(struct nft_chain *chain)
 }
 
 static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
-					      const struct nlattr *attr)
+					      const struct nlattr *attr,
+					      bool prefix)
 {
 	struct nf_hook_ops *ops;
 	struct net_device *dev;
@@ -2314,7 +2326,8 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 	if (err < 0)
 		goto err_hook_free;
 
-	hook->ifnamelen = nla_len(attr);
+	/* include the terminating NUL-char when comparing non-prefixes */
+	hook->ifnamelen = strlen(hook->ifname) + !prefix;
 
 	/* nf_tables_netdev_event() is called under rtnl_mutex, this is
 	 * indirectly serializing all the other holders of the commit_mutex with
@@ -2361,14 +2374,22 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 	struct nft_hook *hook, *next;
 	const struct nlattr *tmp;
 	int rem, n = 0, err;
+	bool prefix;
 
 	nla_for_each_nested(tmp, attr, rem) {
-		if (nla_type(tmp) != NFTA_DEVICE_NAME) {
+		switch (nla_type(tmp)) {
+		case NFTA_DEVICE_NAME:
+			prefix = false;
+			break;
+		case NFTA_DEVICE_PREFIX:
+			prefix = true;
+			break;
+		default:
 			err = -EINVAL;
 			goto err_hook;
 		}
 
-		hook = nft_netdev_hook_alloc(net, tmp);
+		hook = nft_netdev_hook_alloc(net, tmp, prefix);
 		if (IS_ERR(hook)) {
 			NL_SET_BAD_ATTR(extack, tmp);
 			err = PTR_ERR(hook);
@@ -2414,7 +2435,7 @@ static int nft_chain_parse_netdev(struct net *net, struct nlattr *tb[],
 	int err;
 
 	if (tb[NFTA_HOOK_DEV]) {
-		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV]);
+		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV], false);
 		if (IS_ERR(hook)) {
 			NL_SET_BAD_ATTR(extack, tb[NFTA_HOOK_DEV]);
 			return PTR_ERR(hook);
@@ -9424,8 +9445,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 
 	list_for_each_entry_rcu(hook, hook_list, list,
 				lockdep_commit_lock_is_held(net)) {
-		if (nla_put(skb, NFTA_DEVICE_NAME,
-			    hook->ifnamelen, hook->ifname))
+		if (nft_nla_put_hook_dev(skb, hook))
 			goto nla_put_failure;
 	}
 	nla_nest_end(skb, nest_devs);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 61981e01fd6f..b8e58132e8af 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -168,7 +168,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 __sock_i_ino(sk)) < 0) {
+				 sock_i_ino(sk)) < 0) {
 			ret = 1;
 			break;
 		}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c7c7de3403f7..a7017d7f0927 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4782,7 +4782,7 @@ static int packet_seq_show(struct seq_file *seq, void *v)
 			   READ_ONCE(po->ifindex),
 			   packet_sock_flag(po, PACKET_SOCK_RUNNING),
 			   atomic_read(&s->sk_rmem_alloc),
-			   from_kuid_munged(seq_user_ns(seq), sock_i_uid(s)),
+			   from_kuid_munged(seq_user_ns(seq), sk_uid(s)),
 			   sock_i_ino(s));
 	}
 
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 47f69f3dbf73..6ce1dcc284d9 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -153,7 +153,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 
 	if ((req->pdiag_show & PACKET_SHOW_INFO) &&
 	    nla_put_u32(skb, PACKET_DIAG_UID,
-			from_kuid_munged(user_ns, sock_i_uid(sk))))
+			from_kuid_munged(user_ns, sk_uid(sk))))
 		goto out_nlmsg_trim;
 
 	if ((req->pdiag_show & PACKET_SHOW_MCLIST) &&
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 5ce0b3ee5def..ea4d5e6533db 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -584,7 +584,7 @@ static int pn_sock_seq_show(struct seq_file *seq, void *v)
 			sk->sk_protocol, pn->sobject, pn->dobject,
 			pn->resource, sk->sk_state,
 			sk_wmem_alloc_get(sk), sk_rmem_alloc_get(sk),
-			from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
+			from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
 			sock_i_ino(sk),
 			refcount_read(&sk->sk_refcnt), sk,
 			atomic_read(&sk->sk_drops));
@@ -755,7 +755,7 @@ static int pn_res_seq_show(struct seq_file *seq, void *v)
 
 		seq_printf(seq, "%02X %5u %lu",
 			   (int) (psk - pnres.sk),
-			   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
+			   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
 			   sock_i_ino(sk));
 	}
 	seq_pad(seq, '\n');
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 6fcdcaeed40e..7e99894778d4 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -756,7 +756,7 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 			struct sock *sk2 = ep2->base.sk;
 
 			if (!net_eq(sock_net(sk2), net) || sk2 == sk ||
-			    !uid_eq(sock_i_uid(sk2), sock_i_uid(sk)) ||
+			    !uid_eq(sk_uid(sk2), sk_uid(sk)) ||
 			    !sk2->sk_reuseport)
 				continue;
 
diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index ec00ee75d59a..74bff317e205 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -177,7 +177,7 @@ static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5lu ", ep, sk,
 			   sctp_sk(sk)->type, sk->sk_state, hash,
 			   ep->base.bind_addr.port,
-			   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
+			   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
 			   sock_i_ino(sk));
 
 		sctp_seq_dump_local_addrs(seq, &ep->base);
@@ -267,7 +267,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq, void *v)
 		   assoc->assoc_id,
 		   assoc->sndbuf_used,
 		   atomic_read(&assoc->rmem_alloc),
-		   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
+		   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
 		   sock_i_ino(sk),
 		   epb->bind_addr.port,
 		   assoc->peer.port);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1e5739858c20..aa6400811018 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8345,8 +8345,8 @@ static int sctp_get_port_local(struct sock *sk, union sctp_addr *addr)
 	bool reuse = (sk->sk_reuse || sp->reuse);
 	struct sctp_bind_hashbucket *head; /* hash list */
 	struct net *net = sock_net(sk);
-	kuid_t uid = sock_i_uid(sk);
 	struct sctp_bind_bucket *pp;
+	kuid_t uid = sk_uid(sk);
 	unsigned short snum;
 	int ret;
 
@@ -8444,7 +8444,7 @@ static int sctp_get_port_local(struct sock *sk, union sctp_addr *addr)
 			    (reuse && (sk2->sk_reuse || sp2->reuse) &&
 			     sk2->sk_state != SCTP_SS_LISTENING) ||
 			    (sk->sk_reuseport && sk2->sk_reuseport &&
-			     uid_eq(uid, sock_i_uid(sk2))))
+			     uid_eq(uid, sk_uid(sk2))))
 				continue;
 
 			if ((!sk->sk_bound_dev_if || !bound_dev_if2 ||
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 521f5df80e10..8a794333e992 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -426,8 +426,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 {
 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
 
-	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
-		return false;
 	if (hdr->version == SMC_V1) {
 		if (ntohs(hdr->length) != sizeof(struct smc_clc_msg_decline))
 			return false;
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6fdb2d96777a..8ed2f6689b01 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -64,7 +64,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	if (nla_put_u8(skb, SMC_DIAG_SHUTDOWN, sk->sk_shutdown))
 		return 1;
 
-	r->diag_uid = from_kuid_munged(user_ns, sock_i_uid(sk));
+	r->diag_uid = from_kuid_munged(user_ns, sk_uid(sk));
 	r->diag_inode = sock_i_ino(sk);
 	return 0;
 }
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 53828833a3f7..a42ef3f77b96 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -742,6 +742,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
 	unsigned int i;
 	bool ret = false;
 
+	if (!lnk->smcibdev->ibdev->dma_device)
+		return ret;
+
 	/* for now there is just one DMA address */
 	for_each_sg(buf_slot->sgt[lnk->link_idx].sgl, sg,
 		    buf_slot->sgt[lnk->link_idx].nents, i) {
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 7c61d47ea208..e028bf658499 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3642,7 +3642,7 @@ int tipc_sk_fill_sock_diag(struct sk_buff *skb, struct netlink_callback *cb,
 	    nla_put_u32(skb, TIPC_NLA_SOCK_INO, sock_i_ino(sk)) ||
 	    nla_put_u32(skb, TIPC_NLA_SOCK_UID,
 			from_kuid_munged(sk_user_ns(NETLINK_CB(cb->skb).sk),
-					 sock_i_uid(sk))) ||
+					 sk_uid(sk))) ||
 	    nla_put_u64_64bit(skb, TIPC_NLA_SOCK_COOKIE,
 			      tipc_diag_gen_cookie(sk),
 			      TIPC_NLA_SOCK_PAD))
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 52b155123985..564c970d97ff 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3697,7 +3697,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 		goto unlock;
 	}
 
-	uid = from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
+	uid = from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, false);
 	ret = unix_prog_seq_show(prog, &meta, v, uid);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 79b182d0e62a..ca3473026151 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -106,7 +106,7 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb,
 			    struct user_namespace *user_ns)
 {
-	uid_t uid = from_kuid_munged(user_ns, sock_i_uid(sk));
+	uid_t uid = from_kuid_munged(user_ns, sk_uid(sk));
 	return nla_put(nlskb, UNIX_DIAG_UID, sizeof(uid_t), &uid);
 }
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index e8a4fe44ec2d..f2a66af385dc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1905,7 +1905,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			 */
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			if (!new->pub.hidden_beacon_bss)
+				kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index cf998500a965..05d06512983c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -901,13 +901,16 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!wdev->u.client.ssid_len) {
 		rcu_read_lock();
 		for_each_valid_link(cr, link) {
+			u32 ssid_len;
+
 			ssid = ieee80211_bss_get_elem(cr->links[link].bss,
 						      WLAN_EID_SSID);
 
 			if (!ssid || !ssid->datalen)
 				continue;
 
-			memcpy(wdev->u.client.ssid, ssid->data, ssid->datalen);
+			ssid_len = min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
+			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
 			wdev->u.client.ssid_len = ssid->datalen;
 			break;
 		}
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 09dcea0cbbed..0e0bca031c03 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -119,7 +119,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 
 	if ((req->xdiag_show & XDP_SHOW_INFO) &&
 	    nla_put_u32(nlskb, XDP_DIAG_UID,
-			from_kuid_munged(user_ns, sock_i_uid(sk))))
+			from_kuid_munged(user_ns, sk_uid(sk))))
 		goto out_nlmsg_trim;
 
 	if ((req->xdiag_show & XDP_SHOW_RING_CFG) &&
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 31803674aecc..a1181cfae962 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -209,6 +209,7 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
 ///
 /// For the duration of 'a, the referenced vma must be undergoing initialization in an
 /// `f_ops->mmap()` hook.
+#[repr(transparent)]
 pub struct VmaNew {
     vma: VmaRef,
 }
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 693dbbebebba..0ba2aac3b8dc 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -86,10 +86,14 @@ kasan_params += hwasan-instrument-stack=$(stack_enable) \
 		hwasan-use-short-granules=0 \
 		hwasan-inline-all-checks=0
 
-# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
-ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
-	kasan_params += hwasan-kernel-mem-intrinsic-prefix=1
-endif
+# Instrument memcpy/memset/memmove calls by using instrumented __(hw)asan_mem*().
+ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	ifdef CONFIG_CC_IS_GCC
+		kasan_params += asan-kernel-mem-intrinsic-prefix=1
+	else
+		kasan_params += hwasan-kernel-mem-intrinsic-prefix=1
+	endif
+endif # CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
 
 endif # CONFIG_KASAN_SW_TAGS
 
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 39c82908ff3a..38b3416bb979 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -225,7 +225,11 @@ fn main() {
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("supported-sanitizers", ["kcfi", "kernel-address"]);
-        ts.push("target-pointer-width", "64");
+        if cfg.rustc_version_atleast(1, 91, 0) {
+            ts.push("target-pointer-width", 64);
+        } else {
+            ts.push("target-pointer-width", "64");
+        }
     } else if cfg.has("X86_32") {
         // This only works on UML, as i386 otherwise needs regparm support in rustc
         if !cfg.has("UML") {
@@ -245,7 +249,11 @@ fn main() {
         }
         ts.push("features", features);
         ts.push("llvm-target", "i386-unknown-linux-gnu");
-        ts.push("target-pointer-width", "32");
+        if cfg.rustc_version_atleast(1, 91, 0) {
+            ts.push("target-pointer-width", 32);
+        } else {
+            ts.push("target-pointer-width", "32");
+        }
     } else if cfg.has("LOONGARCH") {
         panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
     } else {
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 9a7793eb16e9..bc43ea4d4e16 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1991,6 +1991,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
+	SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec98833e3d2..8458ca4d8d9d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11427,6 +11427,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x300f, "TongFang X6AR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x3019, "TongFang X6FR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 8c5ebbe8a1f3..eab99e9ba2c6 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -282,7 +282,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 {
 	efi_guid_t efi_guid = tasdev_fct_efi_guid[LENOVO];
 	char *vars[TASDEV_CALIB_N] = {
-		"R0_%d", "InvR0_%d", "R0_Low_%d", "Power_%d", "TLim_%d"
+		"R0_%d", "R0_Low_%d", "InvR0_%d", "Power_%d", "TLim_%d"
 	};
 	efi_char16_t efi_name[TAS2563_CAL_VAR_NAME_MAX];
 	unsigned long max_size = TAS2563_CAL_DATA_SIZE;
@@ -292,6 +292,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	struct cali_reg *r = &cd->cali_reg_array;
 	unsigned int offset = 0;
 	unsigned char *data;
+	__be32 bedata;
 	efi_status_t status;
 	unsigned int attr;
 	int ret, i, j, k;
@@ -333,6 +334,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 					i, j, status);
 				return -EINVAL;
 			}
+			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
+			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
 		}
 	}
diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
index a72f36d3ca2c..4f4ed24cb361 100644
--- a/sound/soc/renesas/rcar/core.c
+++ b/sound/soc/renesas/rcar/core.c
@@ -597,7 +597,7 @@ int rsnd_dai_connect(struct rsnd_mod *mod,
 
 	dev_dbg(dev, "%s is connected to io (%s)\n",
 		rsnd_mod_name(mod),
-		snd_pcm_direction_name(io->substream->stream));
+		rsnd_io_is_play(io) ? "Playback" : "Capture");
 
 	return 0;
 }
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16bbc074dc5f..d31ee6e9abef 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -375,8 +375,9 @@ struct snd_soc_component
 	for_each_component(component) {
 		if ((dev == component->dev) &&
 		    (!driver_name ||
-		     (driver_name == component->driver->name) ||
-		     (strcmp(component->driver->name, driver_name) == 0))) {
+		     (component->driver->name &&
+		      ((component->driver->name == driver_name) ||
+		       (strcmp(component->driver->name, driver_name) == 0))))) {
 			found_component = component;
 			break;
 		}
diff --git a/sound/soc/sof/intel/ptl.c b/sound/soc/sof/intel/ptl.c
index 1bc1f54c470d..4633cd01e7dd 100644
--- a/sound/soc/sof/intel/ptl.c
+++ b/sound/soc/sof/intel/ptl.c
@@ -143,6 +143,7 @@ const struct sof_intel_dsp_desc wcl_chip_info = {
 	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
 	.check_sdw_irq = lnl_dsp_check_sdw_irq,
 	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
+	.sdw_process_wakeen = hda_sdw_process_wakeen_common,
 	.check_ipc_irq = mtl_dsp_check_ipc_irq,
 	.cl_init = mtl_dsp_cl_init,
 	.power_down_dsp = mtl_power_down_dsp,
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 0ee532acbb60..ec95a063beb1 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -327,12 +327,16 @@ static bool focusrite_valid_sample_rate(struct snd_usb_audio *chip,
 		max_rate = combine_quad(&fmt[6]);
 
 		switch (max_rate) {
+		case 192000:
+			if (rate == 176400 || rate == 192000)
+				return true;
+			fallthrough;
+		case 96000:
+			if (rate == 88200 || rate == 96000)
+				return true;
+			fallthrough;
 		case 48000:
 			return (rate == 44100 || rate == 48000);
-		case 96000:
-			return (rate == 88200 || rate == 96000);
-		case 192000:
-			return (rate == 176400 || rate == 192000);
 		default:
 			usb_audio_info(chip,
 				"%u:%d : unexpected max rate: %u\n",
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index d0efb3dd8675..9530c59b3cf4 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4339,9 +4339,11 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
 	/* lowest playback value is muted on some devices */
+	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
 	case USB_ID(0x0d8c, 0x000c): /* C-Media */
 	case USB_ID(0x0d8c, 0x0014): /* C-Media */
 	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
+	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
 		break;
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index ed565eb52275..342e056c8c66 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -77,7 +77,7 @@ $(OUTPUT)gpio-watch: $(GPIO_WATCH_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -f $(OUTPUT)include/linux/gpio.h
+	rm -rf $(OUTPUT)include
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 76032e01c2e7..0725a52b6ad7 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -830,7 +830,7 @@ class TypeArrayNest(Type):
                      'ynl_attr_for_each_nested(attr2, attr) {',
                      '\tif (ynl_attr_validate(yarg, attr2))',
                      '\t\treturn YNL_PARSE_CB_ERROR;',
-                     f'\t{var}->_count.{self.c_name}++;',
+                     f'\tn_{self.c_name}++;',
                      '}']
         return get_lines, None, local_vars
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index c81444059ad0..d9123c9637ba 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -290,9 +290,15 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 		info_node->info_linear = info_linear;
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
-			free(info_linear);
+			/*
+			 * Insert failed, likely because of a duplicate event
+			 * made by the sideband thread. Ignore synthesizing the
+			 * metadata.
+			 */
 			free(info_node);
+			goto out;
 		}
+		/* info_linear is now owned by info_node and shouldn't be freed below. */
 		info_linear = NULL;
 
 		/*
@@ -451,18 +457,18 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	return err;
 }
 
-static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
+static int perf_env__add_bpf_info(struct perf_env *env, u32 id)
 {
 	struct bpf_prog_info_node *info_node;
 	struct perf_bpil *info_linear;
 	struct btf *btf = NULL;
 	u64 arrays;
 	u32 btf_id;
-	int fd;
+	int fd, err = 0;
 
 	fd = bpf_prog_get_fd_by_id(id);
 	if (fd < 0)
-		return;
+		return -EINVAL;
 
 	arrays = 1UL << PERF_BPIL_JITED_KSYMS;
 	arrays |= 1UL << PERF_BPIL_JITED_FUNC_LENS;
@@ -475,6 +481,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
 		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
+		err = PTR_ERR(info_linear);
 		goto out;
 	}
 
@@ -484,38 +491,46 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	if (info_node) {
 		info_node->info_linear = info_linear;
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
+			pr_debug("%s: duplicate add bpf info request for id %u\n",
+				 __func__, btf_id);
 			free(info_linear);
 			free(info_node);
+			goto out;
 		}
-	} else
+	} else {
 		free(info_linear);
+		err = -ENOMEM;
+		goto out;
+	}
 
 	if (btf_id == 0)
 		goto out;
 
 	btf = btf__load_from_kernel_by_id(btf_id);
-	if (libbpf_get_error(btf)) {
-		pr_debug("%s: failed to get BTF of id %u, aborting\n",
-			 __func__, btf_id);
-		goto out;
+	if (!btf) {
+		err = -errno;
+		pr_debug("%s: failed to get BTF of id %u %d\n", __func__, btf_id, err);
+	} else {
+		perf_env__fetch_btf(env, btf_id, btf);
 	}
-	perf_env__fetch_btf(env, btf_id, btf);
 
 out:
 	btf__free(btf);
 	close(fd);
+	return err;
 }
 
 static int bpf_event__sb_cb(union perf_event *event, void *data)
 {
 	struct perf_env *env = data;
+	int ret = 0;
 
 	if (event->header.type != PERF_RECORD_BPF_EVENT)
 		return -1;
 
 	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
-		perf_env__add_bpf_info(env, event->bpf.id);
+		ret = perf_env__add_bpf_info(env, event->bpf.id);
 
 	case PERF_BPF_EVENT_PROG_UNLOAD:
 		/*
@@ -529,7 +544,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index 80b1d2b3729b..5a66dc8594aa 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -20,7 +20,7 @@ struct bpil_array_desc {
 				 */
 };
 
-static struct bpil_array_desc bpil_array_desc[] = {
+static const struct bpil_array_desc bpil_array_desc[] = {
 	[PERF_BPIL_JITED_INSNS] = {
 		offsetof(struct bpf_prog_info, jited_prog_insns),
 		offsetof(struct bpf_prog_info, jited_prog_len),
@@ -115,7 +115,7 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	__u32 info_len = sizeof(info);
 	__u32 data_len = 0;
 	int i, err;
-	void *ptr;
+	__u8 *ptr;
 
 	if (arrays >> PERF_BPIL_LAST_ARRAY)
 		return ERR_PTR(-EINVAL);
@@ -126,15 +126,15 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 		pr_debug("can't get prog info: %s", strerror(errno));
 		return ERR_PTR(-EFAULT);
 	}
+	if (info.type >= __MAX_BPF_PROG_TYPE)
+		pr_debug("%s:%d: unexpected program type %u\n", __func__, __LINE__, info.type);
 
 	/* step 2: calculate total size of all arrays */
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		bool include_array = (arrays & (1UL << i)) > 0;
-		struct bpil_array_desc *desc;
 		__u32 count, size;
 
-		desc = bpil_array_desc + i;
-
 		/* kernel is too old to support this field */
 		if (info_len < desc->array_offset + sizeof(__u32) ||
 		    info_len < desc->count_offset + sizeof(__u32) ||
@@ -163,19 +163,20 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	ptr = info_linear->data;
 
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u32 count, size;
 
 		if ((arrays & (1UL << i)) == 0)
 			continue;
 
-		desc  = bpil_array_desc + i;
 		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
 		size  = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
 		bpf_prog_info_set_offset_u32(&info_linear->info,
 					     desc->count_offset, count);
 		bpf_prog_info_set_offset_u32(&info_linear->info,
 					     desc->size_offset, size);
+		assert(ptr >= info_linear->data);
+		assert(ptr < &info_linear->data[data_len]);
 		bpf_prog_info_set_offset_u64(&info_linear->info,
 					     desc->array_offset,
 					     ptr_to_u64(ptr));
@@ -189,27 +190,45 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 		free(info_linear);
 		return ERR_PTR(-EFAULT);
 	}
+	if (info_linear->info.type >= __MAX_BPF_PROG_TYPE) {
+		pr_debug("%s:%d: unexpected program type %u\n",
+			 __func__, __LINE__, info_linear->info.type);
+	}
 
 	/* step 6: verify the data */
+	ptr = info_linear->data;
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
-		__u32 v1, v2;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
+		__u32 count1, count2, size1, size2;
+		__u64 ptr2;
 
 		if ((arrays & (1UL << i)) == 0)
 			continue;
 
-		desc = bpil_array_desc + i;
-		v1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
-		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
+		count1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		count2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->count_offset);
-		if (v1 != v2)
-			pr_warning("%s: mismatch in element count\n", __func__);
+		if (count1 != count2) {
+			pr_warning("%s: mismatch in element count %u vs %u\n", __func__, count1, count2);
+			free(info_linear);
+			return ERR_PTR(-ERANGE);
+		}
 
-		v1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
-		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
+		size1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+		size2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->size_offset);
-		if (v1 != v2)
-			pr_warning("%s: mismatch in rec size\n", __func__);
+		if (size1 != size2) {
+			pr_warning("%s: mismatch in rec size %u vs %u\n", __func__, size1, size2);
+			free(info_linear);
+			return ERR_PTR(-ERANGE);
+		}
+		ptr2 = bpf_prog_info_read_offset_u64(&info_linear->info, desc->array_offset);
+		if (ptr_to_u64(ptr) != ptr2) {
+			pr_warning("%s: mismatch in array %p vs %llx\n", __func__, ptr, ptr2);
+			free(info_linear);
+			return ERR_PTR(-ERANGE);
+		}
+		ptr += roundup(count1 * size1, sizeof(__u64));
 	}
 
 	/* step 7: update info_len and data_len */
@@ -224,13 +243,12 @@ void bpil_addr_to_offs(struct perf_bpil *info_linear)
 	int i;
 
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u64 addr, offs;
 
 		if ((info_linear->arrays & (1UL << i)) == 0)
 			continue;
 
-		desc = bpil_array_desc + i;
 		addr = bpf_prog_info_read_offset_u64(&info_linear->info,
 						     desc->array_offset);
 		offs = addr - ptr_to_u64(info_linear->data);
@@ -244,13 +262,12 @@ void bpil_offs_to_addr(struct perf_bpil *info_linear)
 	int i;
 
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u64 addr, offs;
 
 		if ((info_linear->arrays & (1UL << i)) == 0)
 			continue;
 
-		desc = bpil_array_desc + i;
 		offs = bpf_prog_info_read_offset_u64(&info_linear->info,
 						     desc->array_offset);
 		addr = offs + ptr_to_u64(info_linear->data);
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 0677b58374ab..59ace394cf3e 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -62,8 +62,8 @@ int cmd_set(int argc, char **argv)
 
 	params.params = 0;
 	/* parameter parsing */
-	while ((ret = getopt_long(argc, argv, "b:e:m:",
-						set_opts, NULL)) != -1) {
+	while ((ret = getopt_long(argc, argv, "b:e:m:t:",
+				  set_opts, NULL)) != -1) {
 		switch (ret) {
 		case 'b':
 			if (params.perf_bias)
diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
index cd23af875317..3e3a89a34afe 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -17,7 +17,7 @@ def test_receive(cfg, ipver="6", extra_args=None):
     ip_args = f"-{ipver} -S {cfg.remote_addr_v[ipver]} -D {cfg.addr_v[ipver]}"
 
     rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
-    tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
+    tx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
 
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(34000, proto="udp")
@@ -37,7 +37,7 @@ def test_transmit(cfg, ipver="6", extra_args=None):
     if extra_args != "-U -Z":
         extra_args += " -r 1"
 
-    rx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
+    rx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
     tx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -L 1 -n 100 {ip_args} -T {extra_args}"
 
     with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
diff --git a/tools/testing/selftests/net/bind_bhash.c b/tools/testing/selftests/net/bind_bhash.c
index 57ff67a3751e..da04b0b19b73 100644
--- a/tools/testing/selftests/net/bind_bhash.c
+++ b/tools/testing/selftests/net/bind_bhash.c
@@ -75,7 +75,7 @@ static void *setup(void *arg)
 	int *array = (int *)arg;
 
 	for (i = 0; i < MAX_CONNECTIONS; i++) {
-		sock_fd = bind_socket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
+		sock_fd = bind_socket(SO_REUSEPORT, setup_addr);
 		if (sock_fd < 0) {
 			ret = sock_fd;
 			pthread_exit(&ret);
@@ -103,7 +103,7 @@ int main(int argc, const char *argv[])
 
 	setup_addr = use_v6 ? setup_addr_v6 : setup_addr_v4;
 
-	listener_fd = bind_socket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
+	listener_fd = bind_socket(SO_REUSEPORT, setup_addr);
 	if (listen(listener_fd, 100) < 0) {
 		perror("listen failed");
 		return -1;
diff --git a/tools/testing/selftests/net/netfilter/conntrack_clash.sh b/tools/testing/selftests/net/netfilter/conntrack_clash.sh
index 606a43a60f73..7fc6c5dbd551 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_clash.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_clash.sh
@@ -99,7 +99,7 @@ run_one_clash_test()
 	local entries
 	local cre
 
-	if ! ip netns exec "$ns" ./udpclash $daddr $dport;then
+	if ! ip netns exec "$ns" timeout 30 ./udpclash $daddr $dport;then
 		echo "INFO: did not receive expected number of replies for $daddr:$dport"
 		ip netns exec "$ctns" conntrack -S
 		# don't fail: check if clash resolution triggered after all.
diff --git a/tools/testing/selftests/net/netfilter/conntrack_resize.sh b/tools/testing/selftests/net/netfilter/conntrack_resize.sh
index 788cd56ea4a0..615fe3c6f405 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_resize.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_resize.sh
@@ -187,7 +187,7 @@ ct_udpclash()
 	[ -x udpclash ] || return
 
         while [ $now -lt $end ]; do
-		ip netns exec "$ns" ./udpclash 127.0.0.1 $((RANDOM%65536)) > /dev/null 2>&1
+		ip netns exec "$ns" timeout 30 ./udpclash 127.0.0.1 $((RANDOM%65536)) > /dev/null 2>&1
 
 		now=$(date +%s)
 	done
@@ -277,6 +277,7 @@ check_taint()
 insert_flood()
 {
 	local n="$1"
+	local timeout="$2"
 	local r=0
 
 	r=$((RANDOM%$insert_count))
@@ -302,7 +303,7 @@ test_floodresize_all()
 	read tainted_then < /proc/sys/kernel/tainted
 
 	for n in "$nsclient1" "$nsclient2";do
-		insert_flood "$n" &
+		insert_flood "$n" "$timeout" &
 	done
 
 	# resize table constantly while flood/insert/dump/flushs
diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index a4ee5496f2a1..45832df98295 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -20,6 +20,7 @@ ret=0
 SOCAT_TIMEOUT=60
 
 nsin=""
+nsin_small=""
 ns1out=""
 ns2out=""
 
@@ -36,7 +37,7 @@ cleanup() {
 
 	cleanup_all_ns
 
-	rm -f "$nsin" "$ns1out" "$ns2out"
+	rm -f "$nsin" "$nsin_small" "$ns1out" "$ns2out"
 
 	[ "$log_netns" -eq 0 ] && sysctl -q net.netfilter.nf_log_all_netns="$log_netns"
 }
@@ -72,6 +73,7 @@ lmtu=1500
 rmtu=2000
 
 filesize=$((2 * 1024 * 1024))
+filesize_small=$((filesize / 16))
 
 usage(){
 	echo "nft_flowtable.sh [OPTIONS]"
@@ -89,7 +91,10 @@ do
 		o) omtu=$OPTARG;;
 		l) lmtu=$OPTARG;;
 		r) rmtu=$OPTARG;;
-		s) filesize=$OPTARG;;
+		s)
+			filesize=$OPTARG
+			filesize_small=$((OPTARG / 16))
+		;;
 		*) usage;;
 	esac
 done
@@ -215,6 +220,7 @@ if ! ip netns exec "$ns2" ping -c 1 -q 10.0.1.99 > /dev/null; then
 fi
 
 nsin=$(mktemp)
+nsin_small=$(mktemp)
 ns1out=$(mktemp)
 ns2out=$(mktemp)
 
@@ -265,6 +271,7 @@ check_counters()
 check_dscp()
 {
 	local what=$1
+	local pmtud="$2"
 	local ok=1
 
 	local counter
@@ -277,37 +284,39 @@ check_dscp()
 	local pc4z=${counter%*bytes*}
 	local pc4z=${pc4z#*packets}
 
+	local failmsg="FAIL: pmtu $pmtu: $what counters do not match, expected"
+
 	case "$what" in
 	"dscp_none")
 		if [ "$pc4" -gt 0 ] || [ "$pc4z" -eq 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 == 0, dscp0 > 0, but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 == 0, dscp0 > 0, but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	"dscp_fwd")
 		if [ "$pc4" -eq 0 ] || [ "$pc4z" -eq 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 and dscp0 > 0 but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 and dscp0 > 0 but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	"dscp_ingress")
 		if [ "$pc4" -eq 0 ] || [ "$pc4z" -gt 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	"dscp_egress")
 		if [ "$pc4" -eq 0 ] || [ "$pc4z" -gt 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	*)
-		echo "FAIL: Unknown DSCP check" 1>&2
+		echo "$failmsg: Unknown DSCP check" 1>&2
 		ret=1
 		ok=0
 	esac
@@ -319,9 +328,9 @@ check_dscp()
 
 check_transfer()
 {
-	in=$1
-	out=$2
-	what=$3
+	local in=$1
+	local out=$2
+	local what=$3
 
 	if ! cmp "$in" "$out" > /dev/null 2>&1; then
 		echo "FAIL: file mismatch for $what" 1>&2
@@ -342,25 +351,39 @@ test_tcp_forwarding_ip()
 {
 	local nsa=$1
 	local nsb=$2
-	local dstip=$3
-	local dstport=$4
+	local pmtu=$3
+	local dstip=$4
+	local dstport=$5
 	local lret=0
+	local socatc
+	local socatl
+	local infile="$nsin"
+
+	if [ $pmtu -eq 0 ]; then
+		infile="$nsin_small"
+	fi
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$nsin" > "$ns2out" &
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
 	lpid=$!
 
 	busywait 1000 listener_ready
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$nsin" > "$ns1out"
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
+	socatc=$?
 
 	wait $lpid
+	socatl=$?
 
-	if ! check_transfer "$nsin" "$ns2out" "ns1 -> ns2"; then
+	if [ $socatl -ne 0 ] || [ $socatc -ne 0 ];then
+		rc=1
+	fi
+
+	if ! check_transfer "$infile" "$ns2out" "ns1 -> ns2"; then
 		lret=1
 		ret=1
 	fi
 
-	if ! check_transfer "$nsin" "$ns1out" "ns1 <- ns2"; then
+	if ! check_transfer "$infile" "$ns1out" "ns1 <- ns2"; then
 		lret=1
 		ret=1
 	fi
@@ -370,14 +393,16 @@ test_tcp_forwarding_ip()
 
 test_tcp_forwarding()
 {
-	test_tcp_forwarding_ip "$1" "$2" 10.0.2.99 12345
+	local pmtu="$3"
+
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.0.2.99 12345
 
 	return $?
 }
 
 test_tcp_forwarding_set_dscp()
 {
-	check_dscp "dscp_none"
+	local pmtu="$3"
 
 ip netns exec "$nsr1" nft -f - <<EOF
 table netdev dscpmangle {
@@ -388,8 +413,8 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2"  10.0.2.99 12345
-	check_dscp "dscp_ingress"
+	test_tcp_forwarding_ip "$1" "$2" "$3" 10.0.2.99 12345
+	check_dscp "dscp_ingress" "$pmtu"
 
 	ip netns exec "$nsr1" nft delete table netdev dscpmangle
 else
@@ -405,10 +430,10 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2"  10.0.2.99 12345
-	check_dscp "dscp_egress"
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	check_dscp "dscp_egress" "$pmtu"
 
-	ip netns exec "$nsr1" nft flush table netdev dscpmangle
+	ip netns exec "$nsr1" nft delete table netdev dscpmangle
 else
 	echo "SKIP: Could not load netdev:egress for veth1"
 fi
@@ -416,48 +441,53 @@ fi
 	# partial.  If flowtable really works, then both dscp-is-0 and dscp-is-cs3
 	# counters should have seen packets (before and after ft offload kicks in).
 	ip netns exec "$nsr1" nft -a insert rule inet filter forward ip dscp set cs3
-	test_tcp_forwarding_ip "$1" "$2"  10.0.2.99 12345
-	check_dscp "dscp_fwd"
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	check_dscp "dscp_fwd" "$pmtu"
 }
 
 test_tcp_forwarding_nat()
 {
+	local nsa="$1"
+	local nsb="$2"
+	local pmtu="$3"
+	local what="$4"
 	local lret
-	local pmtu
 
-	test_tcp_forwarding_ip "$1" "$2" 10.0.2.99 12345
-	lret=$?
+	[ "$pmtu" -eq 0 ] && what="$what (pmtu disabled)"
 
-	pmtu=$3
-	what=$4
+	test_tcp_forwarding_ip "$nsa" "$nsb" "$pmtu" 10.0.2.99 12345
+	lret=$?
 
 	if [ "$lret" -eq 0 ] ; then
 		if [ "$pmtu" -eq 1 ] ;then
-			check_counters "flow offload for ns1/ns2 with masquerade and pmtu discovery $what"
+			check_counters "flow offload for ns1/ns2 with masquerade $what"
 		else
 			echo "PASS: flow offload for ns1/ns2 with masquerade $what"
 		fi
 
-		test_tcp_forwarding_ip "$1" "$2" 10.6.6.6 1666
+		test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.6.6.6 1666
 		lret=$?
 		if [ "$pmtu" -eq 1 ] ;then
-			check_counters "flow offload for ns1/ns2 with dnat and pmtu discovery $what"
+			check_counters "flow offload for ns1/ns2 with dnat $what"
 		elif [ "$lret" -eq 0 ] ; then
 			echo "PASS: flow offload for ns1/ns2 with dnat $what"
 		fi
+	else
+		echo "FAIL: flow offload for ns1/ns2 with dnat $what"
 	fi
 
 	return $lret
 }
 
 make_file "$nsin" "$filesize"
+make_file "$nsin_small" "$filesize_small"
 
 # First test:
 # No PMTU discovery, nsr1 is expected to fragment packets from ns1 to ns2 as needed.
 # Due to MTU mismatch in both directions, all packets (except small packets like pure
 # acks) have to be handled by normal forwarding path.  Therefore, packet counters
 # are not checked.
-if test_tcp_forwarding "$ns1" "$ns2"; then
+if test_tcp_forwarding "$ns1" "$ns2" 0; then
 	echo "PASS: flow offloaded for ns1/ns2"
 else
 	echo "FAIL: flow offload for ns1/ns2:" 1>&2
@@ -489,8 +519,9 @@ table ip nat {
 }
 EOF
 
+check_dscp "dscp_none" "0"
 if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 0 ""; then
-	echo "FAIL: flow offload for ns1/ns2 with dscp update" 1>&2
+	echo "FAIL: flow offload for ns1/ns2 with dscp update and no pmtu discovery" 1>&2
 	exit 0
 fi
 
@@ -512,6 +543,14 @@ ip netns exec "$ns2" sysctl net.ipv4.ip_no_pmtu_disc=0 > /dev/null
 # are lower than file size and packets were forwarded via flowtable layer.
 # For earlier tests (large mtus), packets cannot be handled via flowtable
 # (except pure acks and other small packets).
+ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+ip netns exec "$ns2"  nft reset counters table inet filter >/dev/null
+
+if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 ""; then
+	echo "FAIL: flow offload for ns1/ns2 with dscp update and pmtu discovery" 1>&2
+	exit 0
+fi
+
 ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
 
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 ""; then
@@ -644,7 +683,7 @@ ip -net "$ns2" route del 192.168.10.1 via 10.0.2.1
 ip -net "$ns2" route add default via 10.0.2.1
 ip -net "$ns2" route add default via dead:2::1
 
-if test_tcp_forwarding "$ns1" "$ns2"; then
+if test_tcp_forwarding "$ns1" "$ns2" 1; then
 	check_counters "ipsec tunnel mode for ns1/ns2"
 else
 	echo "FAIL: ipsec tunnel mode for ns1/ns2"
@@ -668,7 +707,7 @@ if [ "$1" = "" ]; then
 	fi
 
 	echo "re-run with random mtus and file size: -o $o -l $l -r $r -s $filesize"
-	$0 -o "$o" -l "$l" -r "$r" -s "$filesize"
+	$0 -o "$o" -l "$l" -r "$r" -s "$filesize" || ret=1
 fi
 
 exit $ret
diff --git a/tools/testing/selftests/net/netfilter/udpclash.c b/tools/testing/selftests/net/netfilter/udpclash.c
index 85c7b906ad08..79de163d61ab 100644
--- a/tools/testing/selftests/net/netfilter/udpclash.c
+++ b/tools/testing/selftests/net/netfilter/udpclash.c
@@ -29,7 +29,7 @@ struct thread_args {
 	int sockfd;
 };
 
-static int wait = 1;
+static volatile int wait = 1;
 
 static void *thread_main(void *varg)
 {

