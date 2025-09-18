Return-Path: <stable+bounces-179121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE2B50420
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EA917F571
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E89E31690B;
	Tue,  9 Sep 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxw9X+H8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E732C322;
	Tue,  9 Sep 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437881; cv=none; b=DcT859LfF860XC2OPDmkT2RTNOMoTx/JEEpb4xZE6v3pW33nPgMvtrLoVxK5aCHd0j8c0w8f2QflLpXGC8A8ziS+IuUlYGvvvwH+QUqtcjfppD2JuH2GgQSxi96etOcglB3q/KNVdJJivi0Y/SzvCt99hFoHMADNn2e1BrpVZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437881; c=relaxed/simple;
	bh=Tuiw376v0I073QLwqTmbLKJGQ9bCUu/dTcxgcBJvJew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DElVnx2UoKBOKUCvNFs3r0pijqap4TbHzy5fpfWEU0kNvc9qWfatFeG8qIwGh97Tokt6wkS2a94IQKHKfX2Uv31XDFlrMCEYmnGUsW6xu3T0C6I3es0Hi46qgkOSILI6jcNGXGNsg/ZAwvA5sUeBwjMQ9n23K/pvIdo4TtTSevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxw9X+H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D86C4CEF8;
	Tue,  9 Sep 2025 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437880;
	bh=Tuiw376v0I073QLwqTmbLKJGQ9bCUu/dTcxgcBJvJew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxw9X+H8BZhIfGWkmtgUIXCNOU9cl0XjhnE1Z1YkeE5LV+DZ16l3CIDhd/uDUP3+m
	 upy5YvLVc7O4gpJ/gWVUzf9qEptrk/fbNKL21bLcvoVs9vQ0C9W5eqoGXF+AQsClCT
	 TMHU20buwDsaFD5ntG+6/HhuWD4E0UPS4hu/VdH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.46
Date: Tue,  9 Sep 2025 19:11:04 +0200
Message-ID: <2025090904-tapered-abroad-7bac@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090904-culminate-fraternal-7edf@gregkh>
References: <2025090904-culminate-fraternal-7edf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index cc59990e3796..4a4c5e04417d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 45
+SUBLEVEL = 46
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
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
index a90e28c07e3f..6835f28c1e3c 100644
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
index ae64731266f3..e7c16a7ee6c2 100644
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
index 3ddc5aaa7c5f..9eac178ab2c2 100644
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
@@ -179,6 +193,10 @@ m24c64: eeprom@57 {
 	};
 };
 
+&usdhc2 {
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+};
+
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -228,6 +246,10 @@ pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
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
index a5a7e374bc59..a7afc83d2f26 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -966,6 +966,7 @@ spiflash: flash@0 {
 		reg = <0>;
 		m25p,fast-read;
 		spi-max-frequency = <10000000>;
+		vcc-supply = <&vcc_3v0>;
 	};
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
index a650f5e11fc5..b657f058bf4d 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -195,10 +195,17 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
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
@@ -270,7 +277,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
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
index 36b25af56324..65764ec1cc13 100644
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
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bcd4e26..49af37f781bb 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -36,8 +36,7 @@ endif
 
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
-	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
-	--hash-style=sysv --build-id -T
+	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
 
 #
 # Shared build commands.
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa8f2da87a0a..d160c3b83026 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,7 +61,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	# LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
-	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
+	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000 && CMODEL_MEDANY
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 776354895b81..96a52344b2fb 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -90,7 +90,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU_NUM(tp)
+	lw    \tmp, TASK_TI_CPU_NUM(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 33a5a9f2a0d4..af483de85dfc 100644
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
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 4cc631fa7039..563425b4963c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1150,7 +1150,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
 			/* Load current CPU number in T1 */
-			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			/* Load address of __per_cpu_offset array in T2 */
 			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
@@ -1557,7 +1557,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
 			/* Load current CPU number in R0 */
-			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
+			emit_lw(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			break;
 		}
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index a98e53491a4e..746433efad50 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -41,6 +41,9 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() 0
 #endif /* CONFIG_X86_5LEVEL */
 
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d8853afd314b..63de8dbaa75e 100644
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
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 83b696ba0cac..3fe0681399f6 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -218,9 +218,7 @@ static ssize_t flag_store(struct device *dev, const char *page, size_t count,
 	else
 		lim.integrity.flags |= flag;
 
-	blk_mq_freeze_queue(q);
-	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
+	err = queue_limits_commit_update_frozen(q, &lim);
 	if (err)
 		return err;
 	return count;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9ae3eee4b5ae..f24fffdb6c29 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -444,6 +444,30 @@ int queue_limits_commit_update(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(queue_limits_commit_update);
 
+/**
+ * queue_limits_commit_update_frozen - commit an atomic update of queue limits
+ * @q:		queue to update
+ * @lim:	limits to apply
+ *
+ * Apply the limits in @lim that were obtained from queue_limits_start_update()
+ * and updated with the new values by the caller to @q.  Freezes the queue
+ * before the update and unfreezes it after.
+ *
+ * Returns 0 if successful, else a negative error code.
+ */
+int queue_limits_commit_update_frozen(struct request_queue *q,
+		struct queue_limits *lim)
+{
+	int ret;
+
+	blk_mq_freeze_queue(q);
+	ret = queue_limits_commit_update(q, lim);
+	blk_mq_unfreeze_queue(q);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(queue_limits_commit_update_frozen);
+
 /**
  * queue_limits_set - apply queue limits to queue
  * @q:		queue to update
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5915fb98ffdc..f1160cc2cf85 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1510,7 +1510,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	unsigned int nr_seq_zones, nr_conv_zones;
 	unsigned int pool_size;
 	struct queue_limits lim;
-	int ret;
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1561,11 +1560,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	blk_mq_freeze_queue(q);
-	ret = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
-
-	return ret;
+	return queue_limits_commit_update_frozen(q, &lim);
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 00208c4a6580..ea2909c4745a 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -689,7 +689,7 @@ static void ivpu_bo_unbind_all_user_contexts(struct ivpu_device *vdev)
 static void ivpu_dev_fini(struct ivpu_device *vdev)
 {
 	ivpu_jobs_abort_all(vdev);
-	ivpu_pm_cancel_recovery(vdev);
+	ivpu_pm_disable_recovery(vdev);
 	ivpu_pm_disable(vdev);
 	ivpu_prepare_for_reset(vdev);
 	ivpu_shutdown(vdev);
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 2269569bdee7..ad02b71c73bb 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -382,10 +382,10 @@ void ivpu_pm_init(struct ivpu_device *vdev)
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
index b70efe6c36e4..ba5b9d567e7b 100644
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
index bf3be532e089..64c4dda5d6db 100644
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
index 4cdff387deff..10a2b554b3cc 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -121,7 +121,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		*val = data.ret.value;
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
@@ -150,7 +150,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 
 		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index fd6c565f8a50..4bedcb49a73a 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1106,9 +1106,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 	else
 		lim.features &= ~BLK_FEAT_WRITE_CACHE;
-	blk_mq_freeze_queue(disk->queue);
-	i = queue_limits_commit_update(disk->queue, &lim);
-	blk_mq_unfreeze_queue(disk->queue);
+	i = queue_limits_commit_update_frozen(disk->queue, &lim);
 	if (i)
 		return i;
 	return count;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 9ac22e4a070b..59872e73c187 100644
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
@@ -433,22 +455,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
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
 
@@ -650,6 +658,21 @@ static int vhci_open(struct inode *inode, struct file *file)
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
@@ -661,6 +684,8 @@ static int vhci_release(struct inode *inode, struct file *file)
 	hdev = data->hdev;
 
 	if (hdev) {
+		if (!IS_ERR_OR_NULL(hdev->debugfs))
+			vhci_debugfs_remove(hdev);
 		hci_unregister_dev(hdev);
 		hci_free_dev(hdev);
 	}
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index b69eabf12a24..1bf4fc461a8c 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -420,15 +420,11 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 {
 	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
 		if (vd->tx.cookie == cookie)
@@ -452,9 +448,11 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock_irqsave(&cvc->pc->lock, flags);
+	spin_lock(&cvc->vc.lock);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock(&cvc->vc.lock);
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3d42f6c3308e..8553ac4c0ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -433,7 +433,7 @@ static int psp_sw_init(void *handle)
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
 		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
-		ret = -ENOMEM;
+		return -ENOMEM;
 	}
 
 	adev->psp.xgmi_context.supports_extended_data =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0adb106e2c42..37d53578825b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2292,11 +2292,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					true, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return drm_sched_entity_flush(&vm->delayed, timeout);
+	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
 }
 
 static void amdgpu_vm_destroy_task_info(struct kref *kref)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 70c1399f738d..baafbb5c032a 100644
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
index f154c24499c8..a67b6b20b677 100644
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
index a7fcb135827f..1036b7a37390 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1394,17 +1394,12 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 
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
index 77ac3f114d24..0b30b3ed9d4b 100644
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
index abf439e743f2..6c3cae593ad5 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -1497,6 +1497,7 @@ static struct dpp_funcs dcn30_dpp_funcs = {
 	.dpp_dppclk_control		= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
 	.dpp_get_gamut_remap		= dpp3_cm_get_gamut_remap,
+	.dpp_force_disable_cursor 	= dpp_force_disable_cursor,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index efcc1a6b364c..01137ec02f08 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -502,3 +502,75 @@ void dcn314_disable_link_output(struct dc_link *link,
 
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
index 68e6de6b5758..5251dde383bb 100644
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
index 4d17d1e1c38b..9859ec688e56 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -375,6 +375,17 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 
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
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index 22443fe4a39f..d0092b293090 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -352,6 +352,8 @@ nvkm_fifo_dtor(struct nvkm_engine *engine)
 	mutex_destroy(&fifo->userd.mutex);
 
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
index a0f3277605a5..c5ecbcae2967 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h
@@ -40,6 +40,7 @@ struct nvkm_fifo_func {
 	void (*start)(struct nvkm_fifo *, unsigned long *);
 
 	int (*nonstall_ctor)(struct nvkm_fifo *);
+	void (*nonstall_dtor)(struct nvkm_fifo *);
 	const struct nvkm_event_func *nonstall;
 
 	const struct nvkm_runl_func *runl;
@@ -198,6 +199,7 @@ extern const struct nvkm_fifo_func_mmu_fault tu102_fifo_mmu_fault;
 
 int ga100_fifo_runl_ctor(struct nvkm_fifo *);
 int ga100_fifo_nonstall_ctor(struct nvkm_fifo *);
+void ga100_fifo_nonstall_dtor(struct nvkm_fifo *);
 extern const struct nvkm_event_func ga100_fifo_nonstall;
 extern const struct nvkm_runl_func ga100_runl;
 extern const struct nvkm_runq_func ga100_runq;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c
index 3454c7d29502..f978e49a4d54 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c
@@ -660,6 +660,7 @@ r535_fifo_new(const struct nvkm_fifo_func *hw, struct nvkm_device *device,
 	rm->chan.func = &r535_chan;
 	rm->nonstall = &ga100_fifo_nonstall;
 	rm->nonstall_ctor = ga100_fifo_nonstall_ctor;
+	rm->nonstall_dtor = ga100_fifo_nonstall_dtor;
 
 	return nvkm_fifo_new_(rm, device, type, inst, pfifo);
 }
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c2783d04c6e0..9910c6d3fef3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -45,6 +45,38 @@ static int hid_ignore_special_drivers = 0;
 module_param_named(ignore_special_drivers, hid_ignore_special_drivers, int, 0600);
 MODULE_PARM_DESC(ignore_special_drivers, "Ignore any special drivers and handle all devices by generic driver");
 
+/*
+ * Convert a signed n-bit integer to signed 32-bit integer.
+ */
+
+static s32 snto32(__u32 value, unsigned int n)
+{
+	if (!value || !n)
+		return 0;
+
+	if (n > 32)
+		n = 32;
+
+	return sign_extend32(value, n - 1);
+}
+
+/*
+ * Convert a signed 32-bit integer to a signed n-bit integer.
+ */
+
+static u32 s32ton(__s32 value, unsigned int n)
+{
+	s32 a;
+
+	if (!value || !n)
+		return 0;
+
+	a = value >> (n - 1);
+	if (a && a != -1)
+		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
+	return value & ((1 << n) - 1);
+}
+
 /*
  * Register a new report for a device.
  */
@@ -425,7 +457,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		 * both this and the standard encoding. */
 		raw_value = item_sdata(item);
 		if (!(raw_value & 0xfffffff0))
-			parser->global.unit_exponent = hid_snto32(raw_value, 4);
+			parser->global.unit_exponent = snto32(raw_value, 4);
 		else
 			parser->global.unit_exponent = raw_value;
 		return 0;
@@ -1317,46 +1349,6 @@ int hid_open_report(struct hid_device *device)
 }
 EXPORT_SYMBOL_GPL(hid_open_report);
 
-/*
- * Convert a signed n-bit integer to signed 32-bit integer. Common
- * cases are done through the compiler, the screwed things has to be
- * done by hand.
- */
-
-static s32 snto32(__u32 value, unsigned n)
-{
-	if (!value || !n)
-		return 0;
-
-	if (n > 32)
-		n = 32;
-
-	switch (n) {
-	case 8:  return ((__s8)value);
-	case 16: return ((__s16)value);
-	case 32: return ((__s32)value);
-	}
-	return value & (1 << (n - 1)) ? value | (~0U << n) : value;
-}
-
-s32 hid_snto32(__u32 value, unsigned n)
-{
-	return snto32(value, n);
-}
-EXPORT_SYMBOL_GPL(hid_snto32);
-
-/*
- * Convert a signed 32-bit integer to a signed n-bit integer.
- */
-
-static u32 s32ton(__s32 value, unsigned n)
-{
-	s32 a = value >> (n - 1);
-	if (a && a != -1)
-		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
-	return value & ((1 << n) - 1);
-}
-
 /*
  * Extract/implement a data field from/to a little endian report (bit array).
  *
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 234ddd4422d9..59f630962338 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3296,13 +3296,13 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 					 120);
 		}
 
-		v = hid_snto32(hid_field_extract(hdev, data+3, 0, 12), 12);
+		v = sign_extend32(hid_field_extract(hdev, data + 3, 0, 12), 11);
 		input_report_rel(hidpp->input, REL_X, v);
 
-		v = hid_snto32(hid_field_extract(hdev, data+3, 12, 12), 12);
+		v = sign_extend32(hid_field_extract(hdev, data + 3, 12, 12), 11);
 		input_report_rel(hidpp->input, REL_Y, v);
 
-		v = hid_snto32(data[6], 8);
+		v = sign_extend32(data[6], 7);
 		if (v != 0)
 			hidpp_scroll_counter_handle_scroll(hidpp->input,
 					&hidpp->vertical_wheel_counter, v);
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
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 0da1d0723f88..e7e1833ff04b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -426,8 +426,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	struct block_device *bdev;
 	struct mddev *mddev = bitmap->mddev;
 	struct bitmap_storage *store = &bitmap->storage;
-	unsigned int bitmap_limit = (bitmap->storage.file_pages - pg_index) <<
-		PAGE_SHIFT;
+	unsigned long num_pages = bitmap->storage.file_pages;
+	unsigned int bitmap_limit = (num_pages - pg_index % num_pages) << PAGE_SHIFT;
 	loff_t sboff, offset = mddev->bitmap_info.offset;
 	sector_t ps = pg_index * PAGE_SIZE / SECTOR_SIZE;
 	unsigned int size = PAGE_SIZE;
@@ -436,7 +436,7 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 
 	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
 	/* we compare length (page numbers), not page offset. */
-	if ((pg_index - store->sb_index) == store->file_pages - 1) {
+	if ((pg_index - store->sb_index) == num_pages - 1) {
 		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
 
 		if (last_page_size == 0)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4b3291723670..d26307644292 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8996,6 +8996,11 @@ void md_do_sync(struct md_thread *thread)
 	}
 
 	action = md_sync_action(mddev);
+	if (action == ACTION_FROZEN || action == ACTION_IDLE) {
+		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		goto skip;
+	}
+
 	desc = md_sync_action_name(action);
 	mddev->last_sync_action = action;
 
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 4378d3250bd7..f3750ceaa582 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -293,3 +293,13 @@ static inline bool raid1_should_read_first(struct mddev *mddev,
 
 	return false;
 }
+
+/*
+ * bio with REQ_RAHEAD or REQ_NOWAIT can fail at anytime, before such IO is
+ * submitted to the underlying disks, hence don't record badblocks or retry
+ * in this case.
+ */
+static inline bool raid1_should_handle_error(struct bio *bio)
+{
+	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT));
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index fe1599db69c8..faccf7344ef9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -371,14 +371,16 @@ static void raid1_end_read_request(struct bio *bio)
 	 */
 	update_head_pos(r1_bio->read_disk, r1_bio);
 
-	if (uptodate)
+	if (uptodate) {
 		set_bit(R1BIO_Uptodate, &r1_bio->state);
-	else if (test_bit(FailFast, &rdev->flags) &&
-		 test_bit(R1BIO_FailFast, &r1_bio->state))
+	} else if (test_bit(FailFast, &rdev->flags) &&
+		 test_bit(R1BIO_FailFast, &r1_bio->state)) {
 		/* This was a fail-fast read so we definitely
 		 * want to retry */
 		;
-	else {
+	} else if (!raid1_should_handle_error(bio)) {
+		uptodate = 1;
+	} else {
 		/* If all other devices have failed, we want to return
 		 * the error upwards rather than fail the last device.
 		 * Here we redefine "uptodate" to mean "Don't want to retry"
@@ -449,16 +451,15 @@ static void raid1_end_write_request(struct bio *bio)
 	struct bio *to_put = NULL;
 	int mirror = find_bio_disk(r1_bio, bio);
 	struct md_rdev *rdev = conf->mirrors[mirror].rdev;
-	bool discard_error;
 	sector_t lo = r1_bio->sector;
 	sector_t hi = r1_bio->sector + r1_bio->sectors;
-
-	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
+	bool ignore_error = !raid1_should_handle_error(bio) ||
+		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
 	/*
 	 * 'one mirror IO has finished' event handler:
 	 */
-	if (bio->bi_status && !discard_error) {
+	if (bio->bi_status && !ignore_error) {
 		set_bit(WriteErrorSeen,	&rdev->flags);
 		if (!test_and_set_bit(WantReplacement, &rdev->flags))
 			set_bit(MD_RECOVERY_NEEDED, &
@@ -509,7 +510,7 @@ static void raid1_end_write_request(struct bio *bio)
 
 		/* Maybe we can clear some bad blocks. */
 		if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors) &&
-		    !discard_error) {
+		    !ignore_error) {
 			r1_bio->bios[mirror] = IO_MADE_GOOD;
 			set_bit(R1BIO_MadeGood, &r1_bio->state);
 		}
@@ -1223,7 +1224,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 	int i = 0;
 	struct bio *behind_bio = NULL;
 
-	behind_bio = bio_alloc_bioset(NULL, vcnt, 0, GFP_NOIO,
+	behind_bio = bio_alloc_bioset(NULL, vcnt, bio->bi_opf, GFP_NOIO,
 				      &r1_bio->mddev->bio_set);
 
 	/* discard op, we don't support writezero/writesame yet */
@@ -1315,8 +1316,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct r1conf *conf = mddev->private;
 	struct raid1_info *mirror;
 	struct bio *read_bio;
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	int rdisk;
 	bool r1bio_existed = !!r1_bio;
@@ -1393,13 +1392,12 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	}
 	read_bio = bio_alloc_clone(mirror->rdev->bdev, bio, gfp,
 				   &mddev->bio_set);
-
+	read_bio->bi_opf &= ~REQ_NOWAIT;
 	r1_bio->bios[rdisk] = read_bio;
 
 	read_bio->bi_iter.bi_sector = r1_bio->sector +
 		mirror->rdev->data_offset;
 	read_bio->bi_end_io = raid1_end_read_request;
-	read_bio->bi_opf = op | do_sync;
 	if (test_bit(FailFast, &mirror->rdev->flags) &&
 	    test_bit(R1BIO_FailFast, &r1_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
@@ -1615,11 +1613,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				wait_for_serialization(rdev, r1_bio);
 		}
 
+		mbio->bi_opf &= ~REQ_NOWAIT;
 		r1_bio->bios[i] = mbio;
 
 		mbio->bi_iter.bi_sector	= (r1_bio->sector + rdev->data_offset);
 		mbio->bi_end_io	= raid1_end_write_request;
-		mbio->bi_opf = bio_op(bio) | (bio->bi_opf & (REQ_SYNC | REQ_FUA));
 		if (test_bit(FailFast, &rdev->flags) &&
 		    !test_bit(WriteMostly, &rdev->flags) &&
 		    conf->raid_disks - mddev->degraded > 1)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7515a98001ca..6579bbb6a39a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -398,6 +398,8 @@ static void raid10_end_read_request(struct bio *bio)
 		 * wait for the 'master' bio.
 		 */
 		set_bit(R10BIO_Uptodate, &r10_bio->state);
+	} else if (!raid1_should_handle_error(bio)) {
+		uptodate = 1;
 	} else {
 		/* If all other devices that store this block have
 		 * failed, we want to return the error upwards rather
@@ -455,9 +457,8 @@ static void raid10_end_write_request(struct bio *bio)
 	int slot, repl;
 	struct md_rdev *rdev = NULL;
 	struct bio *to_put = NULL;
-	bool discard_error;
-
-	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
+	bool ignore_error = !raid1_should_handle_error(bio) ||
+		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
 	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
 
@@ -471,7 +472,7 @@ static void raid10_end_write_request(struct bio *bio)
 	/*
 	 * this branch is our 'one mirror IO has finished' event handler:
 	 */
-	if (bio->bi_status && !discard_error) {
+	if (bio->bi_status && !ignore_error) {
 		if (repl)
 			/* Never record new bad blocks to replacement,
 			 * just fail it.
@@ -526,7 +527,7 @@ static void raid10_end_write_request(struct bio *bio)
 		/* Maybe we can clear some bad blocks. */
 		if (rdev_has_badblock(rdev, r10_bio->devs[slot].addr,
 				      r10_bio->sectors) &&
-		    !discard_error) {
+		    !ignore_error) {
 			bio_put(bio);
 			if (repl)
 				r10_bio->devs[slot].repl_bio = IO_MADE_GOOD;
@@ -1146,8 +1147,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r10conf *conf = mddev->private;
 	struct bio *read_bio;
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	struct md_rdev *rdev;
 	char b[BDEVNAME_SIZE];
@@ -1219,6 +1218,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->master_bio = bio;
 	}
 	read_bio = bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_set);
+	read_bio->bi_opf &= ~REQ_NOWAIT;
 
 	r10_bio->devs[slot].bio = read_bio;
 	r10_bio->devs[slot].rdev = rdev;
@@ -1226,7 +1226,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_iter.bi_sector = r10_bio->devs[slot].addr +
 		choose_data_offset(r10_bio, rdev);
 	read_bio->bi_end_io = raid10_end_read_request;
-	read_bio->bi_opf = op | do_sync;
 	if (test_bit(FailFast, &rdev->flags) &&
 	    test_bit(R10BIO_FailFast, &r10_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
@@ -1240,9 +1239,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 				  struct bio *bio, bool replacement,
 				  int n_copy)
 {
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
-	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
@@ -1253,6 +1249,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 			     conf->mirrors[devnum].rdev;
 
 	mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO, &mddev->bio_set);
+	mbio->bi_opf &= ~REQ_NOWAIT;
 	if (replacement)
 		r10_bio->devs[n_copy].repl_bio = mbio;
 	else
@@ -1261,7 +1258,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	mbio->bi_iter.bi_sector	= (r10_bio->devs[n_copy].addr +
 				   choose_data_offset(r10_bio, rdev));
 	mbio->bi_end_io	= raid10_end_write_request;
-	mbio->bi_opf = op | do_sync | do_fua;
 	if (!replacement && test_bit(FailFast,
 				     &conf->mirrors[devnum].rdev->flags)
 			 && enough(conf, devnum))
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5edd024347bd..30daa2db80b1 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -76,6 +76,8 @@
 #define FREQSEL_225M_200M		0x7
 #define PHY_DLL_TIMEOUT_MS		100
 
+#define SDHCI_HW_RST_EN		BIT(4)
+
 /* Default settings for ZynqMP Clock Phases */
 #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
 #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
@@ -97,6 +99,9 @@
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
+#define CD_STABLE_TIMEOUT_US		1000000
+#define CD_STABLE_MAX_SLEEP_US		10
+
 /**
  * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
  *
@@ -204,12 +209,15 @@ struct sdhci_arasan_data {
  * 19MHz instead
  */
 #define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
+/* Enable CD stable check before power-up */
+#define SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE	BIT(3)
 };
 
 struct sdhci_arasan_of_data {
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 	const struct sdhci_pltfm_data *pdata;
 	const struct sdhci_arasan_clk_ops *clk_ops;
+	u32 quirks;
 };
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
@@ -475,6 +483,21 @@ static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static void sdhci_arasan_hw_reset(struct sdhci_host *host)
+{
+	u8 reg;
+
+	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	reg |= SDHCI_HW_RST_EN;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* As per eMMC spec, minimum 1us is required but give it 2us for good measure */
+	usleep_range(2, 5);
+	reg &= ~SDHCI_HW_RST_EN;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* As per eMMC spec, minimum 200us is required but give it 300us for good measure */
+	usleep_range(300, 500);
+}
+
 static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 				       struct mmc_ios *ios)
 {
@@ -497,6 +520,24 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host, unsigned char mode,
+						   unsigned short vdd)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/*
+	 * Ensure that the card detect logic has stabilized before powering up, this is
+	 * necessary after a host controller reset.
+	 */
+	if (mode == MMC_POWER_UP && sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE)
+		read_poll_timeout(sdhci_readl, reg, reg & SDHCI_CD_STABLE, CD_STABLE_MAX_SLEEP_US,
+				  CD_STABLE_TIMEOUT_US, false, host, SDHCI_PRESENT_STATE);
+
+	sdhci_set_power_and_bus_voltage(host, mode, vdd);
+}
+
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -504,7 +545,8 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_power = sdhci_arasan_set_power_and_bus_voltage,
+	.hw_reset = sdhci_arasan_hw_reset,
 };
 
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
@@ -552,7 +594,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_power = sdhci_arasan_set_power_and_bus_voltage,
 	.irq = sdhci_arasan_cqhci_irq,
 };
 
@@ -1429,6 +1471,7 @@ static const struct sdhci_arasan_clk_ops zynqmp_clk_ops = {
 static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
 	.pdata = &sdhci_arasan_zynqmp_pdata,
 	.clk_ops = &zynqmp_clk_ops,
+	.quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
 };
 
 static const struct sdhci_arasan_clk_ops versal_clk_ops = {
@@ -1439,6 +1482,7 @@ static const struct sdhci_arasan_clk_ops versal_clk_ops = {
 static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 	.pdata = &sdhci_arasan_zynqmp_pdata,
 	.clk_ops = &versal_clk_ops,
+	.quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
 };
 
 static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
@@ -1449,6 +1493,7 @@ static const struct sdhci_arasan_clk_ops versal_net_clk_ops = {
 static struct sdhci_arasan_of_data sdhci_arasan_versal_net_data = {
 	.pdata = &sdhci_arasan_versal_net_pdata,
 	.clk_ops = &versal_net_clk_ops,
+	.quirks = SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE,
 };
 
 static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
@@ -1927,6 +1972,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
+	sdhci_arasan->quirks |= data->quirks;
+
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 844cf2b8f727..c903c6fcc666 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2378,6 +2378,9 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	int ret;
 
+	if (!b53_support_eee(ds, port))
+		return 0;
+
 	ret = phy_init_eee(phy, false);
 	if (ret)
 		return 0;
@@ -2388,13 +2391,16 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 }
 EXPORT_SYMBOL(b53_eee_init);
 
-int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
+bool b53_support_eee(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
 
-	if (is5325(dev) || is5365(dev))
-		return -EOPNOTSUPP;
+	return !is5325(dev) && !is5365(dev) && !is63xx(dev);
+}
+EXPORT_SYMBOL(b53_support_eee);
 
+int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
+{
 	return 0;
 }
 EXPORT_SYMBOL(b53_get_mac_eee);
@@ -2404,9 +2410,6 @@ int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 	struct b53_device *dev = ds->priv;
 	struct ethtool_keee *p = &dev->ports[port].eee;
 
-	if (is5325(dev) || is5365(dev))
-		return -EOPNOTSUPP;
-
 	p->eee_enabled = e->eee_enabled;
 	b53_eee_enable_set(ds, port, e->eee_enabled);
 
@@ -2463,6 +2466,7 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_setup		= b53_setup_port,
 	.port_enable		= b53_enable_port,
 	.port_disable		= b53_disable_port,
+	.support_eee		= b53_support_eee,
 	.get_mac_eee		= b53_get_mac_eee,
 	.set_mac_eee		= b53_set_mac_eee,
 	.port_bridge_join	= b53_br_join,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 4f8c97098d2a..e908397e8b9a 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -387,6 +387,7 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy);
+bool b53_support_eee(struct dsa_switch *ds, int port);
 int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c4771a07878e..f1372830d5fa 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1233,6 +1233,7 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.port_setup		= b53_setup_port,
 	.port_enable		= bcm_sf2_port_setup,
 	.port_disable		= bcm_sf2_port_disable,
+	.support_eee		= b53_support_eee,
 	.get_mac_eee		= b53_get_mac_eee,
 	.set_mac_eee		= b53_set_mac_eee,
 	.port_bridge_join	= b53_br_join,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 08886c3a28c6..8a6f3e230fce 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4207,7 +4207,7 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
 		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
-				    ring_nr, i, bp->rx_ring_size);
+				    ring_nr, i, bp->rx_agg_ring_size);
 			break;
 		}
 		prod = NEXT_RX_AGG(prod);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6c2d69ef1a8d..f7e8c08d8441 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1234,11 +1234,12 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	u16 queue_index = queue - bp->queues;
+	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
 	int packets = 0;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
@@ -1297,7 +1298,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->dev, queue_index);
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return packets;
 }
@@ -1713,8 +1714,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	if (queue->tx_head == queue->tx_tail)
 		goto out_tx_ptr_unlock;
@@ -1726,19 +1728,20 @@ static void macb_tx_restart(struct macb_queue *queue)
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
@@ -1746,7 +1749,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	return retval;
 }
 
@@ -2314,6 +2317,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct macb_queue *queue = &bp->queues[queue_index];
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
+	unsigned long flags;
 	bool is_lso;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
@@ -2374,7 +2378,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
 	}
 
-	spin_lock_bh(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
@@ -2396,15 +2400,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	wmb();
 	skb_tx_timestamp(skb);
 
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
index aa80c3702232..a360d3dffccd 100644
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
index 208c2f0857b6..ded8f43fdf06 100644
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
index 74d4f2fde3e0..bd5db525f193 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3193,12 +3193,14 @@ static irqreturn_t ice_ll_ts_intr(int __always_unused irq, void *data)
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 1468a0f0df2b..52d9caab2fcb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2278,6 +2278,7 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	struct sockaddr *addr = p;
+	u8 old_mac_addr[ETH_ALEN];
 	struct idpf_vport *vport;
 	int err = 0;
 
@@ -2301,17 +2302,19 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
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
index 151beea20d34..f27a8cf3816d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3513,6 +3513,16 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
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
@@ -3642,6 +3652,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -3649,6 +3660,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 9482e0cca8b7..0b9ecb10aa7c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3443,13 +3443,13 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 
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
index 272f178906d6..64d86068b51e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1606,6 +1606,13 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -1651,8 +1658,9 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 drop:
 	spin_unlock(&eth->page_lock);
-	stats->tx_dropped++;
 	dev_kfree_skb_any(skb);
+dropped:
+	stats->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
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
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1775e060d39d..3339c5e1a57a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1127,6 +1127,15 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
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
@@ -1139,6 +1148,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
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
diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index d5b05e803219..ca35a50bb640 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -224,5 +224,4 @@ void ipvlan_l3s_unregister(struct ipvl_port *port)
 
 	dev->priv_flags &= ~IFF_L3MDEV_RX_HANDLER;
 	ipvlan_unregister_nf_hook(read_pnet(&port->pnet));
-	dev->l3mdev_ops = NULL;
 }
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 090a56a5e456..8b10112c30dc 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1843,7 +1843,7 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 	if (tb_sa[MACSEC_SA_ATTR_PN]) {
 		spin_lock_bh(&rx_sa->lock);
-		rx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
@@ -2085,7 +2085,7 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&tx_sa->lock);
-	tx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+	tx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 	spin_unlock_bh(&tx_sa->lock);
 
 	if (tb_sa[MACSEC_SA_ATTR_ACTIVE])
@@ -2397,7 +2397,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&tx_sa->lock);
 		prev_pn = tx_sa->next_pn_halves;
-		tx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		tx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&tx_sa->lock);
 	}
 
@@ -2495,7 +2495,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&rx_sa->lock);
 		prev_pn = rx_sa->next_pn_halves;
-		rx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index d0a722d43368..a7acbed14b0a 100644
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
index 920f35f8f84e..fa24ba8f6bff 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -455,12 +455,12 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
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
 
@@ -485,7 +485,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		 * packet in the FIFO right now, reschedule it for later
 		 * packets.
 		 */
-		__skb_queue_tail(&ptp->tx_queue, skb);
+		skb_queue_tail(&ptp->tx_queue, skb);
 	}
 }
 
@@ -1065,6 +1065,7 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 	case HWTSTAMP_TX_ON:
 		break;
 	case HWTSTAMP_TX_OFF:
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 		break;
 	default:
 		return -ERANGE;
@@ -1089,9 +1090,6 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 
 	mutex_lock(&vsc8531->ts_lock);
 
-	__skb_queue_purge(&vsc8531->ptp->tx_queue);
-	__skb_queue_head_init(&vsc8531->ptp->tx_queue);
-
 	/* Disable predictor while configuring the 1588 block */
 	val = vsc85xx_ts_read_csr(phydev, PROCESSOR,
 				  MSCC_PHY_PTP_INGR_PREDICTOR);
@@ -1177,9 +1175,7 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-	mutex_lock(&vsc8531->ts_lock);
-	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
-	mutex_unlock(&vsc8531->ts_lock);
+	skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	return;
 
 out:
@@ -1545,6 +1541,7 @@ void vsc8584_ptp_deinit(struct phy_device *phydev)
 	if (vsc8531->ptp->ptp_clock) {
 		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
 		skb_queue_purge(&vsc8531->rx_skbs_list);
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 	}
 }
 
@@ -1568,7 +1565,7 @@ irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 	if (rc & VSC85XX_1588_INT_FIFO_ADD) {
 		vsc85xx_get_tx_ts(priv->ptp);
 	} else if (rc & VSC85XX_1588_INT_FIFO_OVERFLOW) {
-		__skb_queue_purge(&priv->ptp->tx_queue);
+		skb_queue_purge(&priv->ptp->tx_queue);
 		vsc85xx_ts_reset_fifo(phydev);
 	}
 
@@ -1588,6 +1585,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
 	skb_queue_head_init(&vsc8531->rx_skbs_list);
+	skb_queue_head_init(&vsc8531->ptp->tx_queue);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 0553b0b356b3..afc1566488b3 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1753,7 +1753,6 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		 */
 		if (net_ratelimit())
 			netdev_err(ppp->dev, "ppp: compressor dropped pkt\n");
-		kfree_skb(skb);
 		consume_skb(new_skb);
 		new_skb = NULL;
 	}
@@ -1855,9 +1854,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
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
index 4abfdfcf0e28..5c89e03f93d6 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2088,6 +2088,13 @@ static const struct usb_device_id cdc_devs[] = {
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
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 0a0f0e18762b..f04da733240c 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1363,8 +1363,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1057, 2)},	/* Telit FN980 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
-	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
-	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990A */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1077, 2)},	/* Telit FN990A w/audio */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1a7077093800..bbfa4eed1755 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -428,8 +428,8 @@ static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
 	return NULL;
 }
 
-static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
-					const u8 *mac, __be32 vni)
+static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
+					   const u8 *mac, __be32 vni)
 {
 	struct vxlan_fdb *f;
 
@@ -1048,7 +1048,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if (ndm_flags & NTF_USE)
-		WRITE_ONCE(f->used, jiffies);
+		WRITE_ONCE(f->updated, jiffies);
 
 	if (notify) {
 		if (rd == NULL)
@@ -1292,7 +1292,7 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 	int err = -ENOENT;
 
-	f = vxlan_find_mac(vxlan, addr, src_vni);
+	f = __vxlan_find_mac(vxlan, addr, src_vni);
 	if (!f)
 		return err;
 
@@ -1437,9 +1437,10 @@ static int vxlan_fdb_get(struct sk_buff *skb,
  * and Tunnel endpoint.
  * Return true if packet is bogus and should be dropped.
  */
-static bool vxlan_snoop(struct net_device *dev,
-			union vxlan_addr *src_ip, const u8 *src_mac,
-			u32 src_ifindex, __be32 vni)
+static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
+					union vxlan_addr *src_ip,
+					const u8 *src_mac, u32 src_ifindex,
+					__be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb *f;
@@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
 
 	/* Ignore packets from invalid src-address */
 	if (!is_valid_ether_addr(src_mac))
-		return true;
+		return SKB_DROP_REASON_MAC_INVALID_SOURCE;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
@@ -1455,21 +1456,21 @@ static bool vxlan_snoop(struct net_device *dev,
 		ifindex = src_ifindex;
 #endif
 
-	f = vxlan_find_mac(vxlan, src_mac, vni);
+	f = __vxlan_find_mac(vxlan, src_mac, vni);
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
 
+		/* Don't override an fdb with nexthop with a learnt entry */
+		if (rcu_access_pointer(f->nh))
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
+
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
-			return false;
+			return SKB_NOT_DROPPED_YET;
 
 		/* Don't migrate static entries, drop packets */
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
-			return true;
-
-		/* Don't override an fdb with nexthop with a learnt entry */
-		if (rcu_access_pointer(f->nh))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		if (net_ratelimit())
 			netdev_info(dev,
@@ -1497,7 +1498,7 @@ static bool vxlan_snoop(struct net_device *dev,
 		spin_unlock(&vxlan->hash_lock[hash_index]);
 	}
 
-	return false;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
@@ -1604,9 +1605,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
+static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  struct vxlan_sock *vs,
+					  struct sk_buff *skb, __be32 vni)
 {
 	union vxlan_addr saddr;
 	u32 ifindex = skb->dev->ifindex;
@@ -1617,7 +1618,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 
 	/* Ignore packet loops (and multicast echo) */
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
+		return SKB_DROP_REASON_LOCAL_MAC;
 
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
@@ -1630,11 +1631,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
-	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
+	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		return SKB_NOT_DROPPED_YET;
 
-	return true;
+	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source,
+			   ifindex, vni);
 }
 
 static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
@@ -1671,13 +1672,15 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
+	enum skb_drop_reason reason;
 	bool raw_proto = false;
 	void *oiph;
 	__be32 vni = 0;
 	int nh;
 
 	/* Need UDP and VXLAN header to be present */
-	if (!pskb_may_pull(skb, VXLAN_HLEN))
+	reason = pskb_may_pull_reason(skb, VXLAN_HLEN);
+	if (reason)
 		goto drop;
 
 	unparsed = *vxlan_hdr(skb);
@@ -1686,6 +1689,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
 			   ntohl(vxlan_hdr(skb)->vx_flags),
 			   ntohl(vxlan_hdr(skb)->vx_vni));
+		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		/* Return non vxlan pkt */
 		goto drop;
 	}
@@ -1699,8 +1703,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
-	if (!vxlan)
+	if (!vxlan) {
+		reason = SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND;
 		goto drop;
+	}
 
 	/* For backwards compatibility, only allow reserved fields to be
 	 * used by VXLAN extensions if explicitly requested.
@@ -1713,8 +1719,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
+				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto drop;
+	}
 
 	if (vs->flags & VXLAN_F_REMCSUM_RX)
 		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
@@ -1728,8 +1736,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), flags,
 					 key32_to_tunnel_id(vni), sizeof(*md));
 
-		if (!tun_dst)
+		if (!tun_dst) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto drop;
+		}
 
 		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 
@@ -1753,11 +1763,13 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * is more robust and provides a little more security in
 		 * adding extensions to VXLAN.
 		 */
+		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		goto drop;
 	}
 
 	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		if (reason)
 			goto drop;
 	} else {
 		skb_reset_mac_header(skb);
@@ -1773,7 +1785,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1785,6 +1798,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	oiph = skb->head + nh;
 
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
+		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
@@ -1799,6 +1813,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		dev_core_stats_rx_dropped_inc(vxlan->dev);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
@@ -1811,8 +1826,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	/* Consume bad packet */
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
@@ -1885,6 +1901,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	n = neigh_lookup(&arp_tbl, &tip, dev);
 
 	if (n) {
+		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
 
@@ -1893,12 +1910,17 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		f = vxlan_find_mac(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+		rcu_read_lock();
+		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		if (f)
+			rdst = first_remote_rcu(f);
+		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
 			/* bridge-local neighbor */
 			neigh_release(n);
+			rcu_read_unlock();
 			goto out;
 		}
+		rcu_read_unlock();
 
 		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
 				n->ha, sha);
@@ -2049,6 +2071,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
 
 	if (n) {
+		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
 
@@ -2057,8 +2080,10 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		f = vxlan_find_mac(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		if (f)
+			rdst = first_remote_rcu(f);
+		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
 			/* bridge-local neighbor */
 			neigh_release(n);
 			goto out;
@@ -2616,14 +2641,10 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
 	hash = skb_get_hash(skb);
 
-	rcu_read_lock();
 	nh = rcu_dereference(f->nh);
-	if (!nh) {
-		rcu_read_unlock();
+	if (!nh)
 		goto drop;
-	}
 	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
-	rcu_read_unlock();
 
 	if (likely(do_xmit))
 		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
@@ -2708,7 +2729,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
 			else
-				kfree_skb(skb);
+				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2750,7 +2771,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	eth = eth_hdr(skb);
-	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+	rcu_read_lock();
+	f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	did_rsc = false;
 
 	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
@@ -2758,11 +2780,11 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
 		did_rsc = route_shortcircuit(dev, skb);
 		if (did_rsc)
-			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	}
 
 	if (f == NULL) {
-		f = vxlan_find_mac(vxlan, all_zeros_mac, vni);
+		f = vxlan_find_mac_tx(vxlan, all_zeros_mac, vni);
 		if (f == NULL) {
 			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
 			    !is_multicast_ether_addr(eth->h_dest))
@@ -2771,8 +2793,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb(skb);
-			return NETDEV_TX_OK;
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
+			goto out;
 		}
 	}
 
@@ -2794,9 +2816,11 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 	}
 
+out:
+	rcu_read_unlock();
 	return NETDEV_TX_OK;
 }
 
@@ -4700,7 +4724,7 @@ vxlan_fdb_offloaded_set(struct net_device *dev,
 
 	spin_lock_bh(&vxlan->hash_lock[hash_index]);
 
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
 		goto out;
 
@@ -4756,7 +4780,7 @@ vxlan_fdb_external_learn_del(struct net_device *dev,
 	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	spin_lock_bh(&vxlan->hash_lock[hash_index]);
 
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
 		err = -ENOENT;
 	else if (f->flags & NTF_EXT_LEARNED)
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 60eb95a06d55..ec86d1c02483 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 76a351a997d5..c6279ef98a5c 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -56,9 +56,7 @@ static inline struct hlist_head *vs_head(struct net *net, __be16 port)
 	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
 }
 
-/* First remote destination for a forwarding entry.
- * Guaranteed to be non-NULL because remotes are never deleted.
- */
+/* First remote destination for a forwarding entry. */
 static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
 {
 	if (rcu_access_pointer(fdb->nh))
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2ec1771262fd..bb46ef986b2a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1972,6 +1972,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	ath11k_mac_scan_finish(ar);
 	ath11k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09fdb7be0e19..cd9f9fb6ab68 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -409,6 +409,8 @@ struct ath11k_vif {
 	bool do_not_send_tmpl;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
+	u32 num_stations;
+	bool reinstall_group_keys;
 
 	struct ath11k_reg_tpc_power_info reg_tpc_info;
 
@@ -689,7 +691,7 @@ struct ath11k {
 	struct mutex conf_mutex;
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath11k_sta info, ath11k_vif info,
-	 * channel context data, survey info, test mode data.
+	 * channel context data, survey info, test mode data, channel_update_queue.
 	 */
 	spinlock_t data_lock;
 
@@ -747,6 +749,9 @@ struct ath11k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct channel_update_work;
+	/* protected with data_lock */
+	struct list_head channel_update_queue;
 
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ddf4ec6b244b..9db3369d3204 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4307,6 +4307,40 @@ static int ath11k_clear_peer_keys(struct ath11k_vif *arvif,
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
@@ -4316,6 +4350,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
+	bool is_ap_with_no_sta;
 	const u8 *peer_addr;
 	int ret = 0;
 	u32 flags = 0;
@@ -4376,16 +4411,57 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
@@ -4984,6 +5060,7 @@ static int ath11k_mac_inc_num_stations(struct ath11k_vif *arvif,
 		return -ENOBUFS;
 
 	ar->num_stations++;
+	arvif->num_stations++;
 
 	return 0;
 }
@@ -4999,6 +5076,7 @@ static void ath11k_mac_dec_num_stations(struct ath11k_vif *arvif,
 		return;
 
 	ar->num_stations--;
+	arvif->num_stations--;
 }
 
 static u32 ath11k_mac_ieee80211_sta_bw_to_wmi(struct ath11k *ar,
@@ -6289,6 +6367,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath11k *ar = hw->priv;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct scan_chan_list_params *params;
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
@@ -6304,6 +6383,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
 
@@ -6313,10 +6393,19 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	}
 
 	spin_lock_bh(&ar->data_lock);
+
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
 		list_del(&ppdu_stats->list);
 		kfree(ppdu_stats);
 	}
+
+	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
+						  struct scan_chan_list_params,
+						  list))) {
+		list_del(&params->list);
+		kfree(params);
+	}
+
 	spin_unlock_bh(&ar->data_lock);
 
 	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
@@ -9519,6 +9608,21 @@ static int ath11k_mac_station_add(struct ath11k *ar,
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
@@ -10101,6 +10205,7 @@ static const struct wiphy_iftype_ext_capab ath11k_iftypes_ext_capa[] = {
 
 static void __ath11k_mac_unregister(struct ath11k *ar)
 {
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(ar->hw);
@@ -10500,6 +10605,8 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->thermal.wmi_sync);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
+		INIT_WORK(&ar->channel_update_work, ath11k_regd_update_chan_list_work);
+		INIT_LIST_HEAD(&ar->channel_update_queue);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
 
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b0f289784dd3..d62a2014315a 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 
@@ -55,6 +55,19 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath11k_dbg(ar->ab, ATH11K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "driver initiated regd update\n");
+		if (ar->state != ATH11K_STATE_ON)
+			return;
+
+		ret = ath11k_reg_update_chan_list(ar, true);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to update channel list: %d\n", ret);
+
+		return;
+	}
+
 	/* Currently supporting only General User Hints. Cell base user
 	 * hints to be handled later.
 	 * Hints from other sources like Core, Beacons are not expected for
@@ -111,32 +124,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 	struct channel_param *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret, left;
-
-	if (wait && ar->state_11d != ATH11K_11D_IDLE) {
-		left = wait_for_completion_timeout(&ar->completed_11d_scan,
-						   ATH11K_SCAN_TIMEOUT_HZ);
-		if (!left) {
-			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-				   "failed to receive 11d scan complete: timed out\n");
-			ar->state_11d = ATH11K_11D_IDLE;
-		}
-		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "11d scan wait left time %d\n", left);
-	}
-
-	if (wait &&
-	    (ar->scan.state == ATH11K_SCAN_STARTING ||
-	    ar->scan.state == ATH11K_SCAN_RUNNING)) {
-		left = wait_for_completion_timeout(&ar->scan.completed,
-						   ATH11K_SCAN_TIMEOUT_HZ);
-		if (!left)
-			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-				   "failed to receive hw scan complete: timed out\n");
-
-		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "hw scan wait left time %d\n", left);
-	}
+	int i, ret = 0;
 
 	if (ar->state == ATH11K_STATE_RESTARTING)
 		return 0;
@@ -218,6 +206,16 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 		}
 	}
 
+	if (wait) {
+		spin_lock_bh(&ar->data_lock);
+		list_add_tail(&params->list, &ar->channel_update_queue);
+		spin_unlock_bh(&ar->data_lock);
+
+		queue_work(ar->ab->workqueue, &ar->channel_update_work);
+
+		return 0;
+	}
+
 	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
 	kfree(params);
 
@@ -293,12 +291,6 @@ int ath11k_regd_update(struct ath11k *ar)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH11K_STATE_ON) {
-		ret = ath11k_reg_update_chan_list(ar, true);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
 err:
 	ath11k_warn(ab, "failed to perform regd update : %d\n", ret);
@@ -804,6 +796,54 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	return new_regd;
 }
 
+void ath11k_regd_update_chan_list_work(struct work_struct *work)
+{
+	struct ath11k *ar = container_of(work, struct ath11k,
+					 channel_update_work);
+	struct scan_chan_list_params *params;
+	struct list_head local_update_list;
+	int left;
+
+	INIT_LIST_HEAD(&local_update_list);
+
+	spin_lock_bh(&ar->data_lock);
+	list_splice_tail_init(&ar->channel_update_queue, &local_update_list);
+	spin_unlock_bh(&ar->data_lock);
+
+	while ((params = list_first_entry_or_null(&local_update_list,
+						  struct scan_chan_list_params,
+						  list))) {
+		if (ar->state_11d != ATH11K_11D_IDLE) {
+			left = wait_for_completion_timeout(&ar->completed_11d_scan,
+							   ATH11K_SCAN_TIMEOUT_HZ);
+			if (!left) {
+				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+					   "failed to receive 11d scan complete: timed out\n");
+				ar->state_11d = ATH11K_11D_IDLE;
+			}
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+				   "reg 11d scan wait left time %d\n", left);
+		}
+
+		if ((ar->scan.state == ATH11K_SCAN_STARTING ||
+		     ar->scan.state == ATH11K_SCAN_RUNNING)) {
+			left = wait_for_completion_timeout(&ar->scan.completed,
+							   ATH11K_SCAN_TIMEOUT_HZ);
+			if (!left)
+				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+					   "failed to receive hw scan complete: timed out\n");
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+				   "reg hw scan wait left time %d\n", left);
+		}
+
+		ath11k_wmi_send_scan_chan_list_cmd(ar, params);
+		list_del(&params->list);
+		kfree(params);
+	}
+}
+
 static bool ath11k_reg_is_world_alpha(char *alpha)
 {
 	if (alpha[0] == '0' && alpha[1] == '0')
@@ -977,6 +1017,7 @@ void ath11k_regd_update_work(struct work_struct *work)
 void ath11k_reg_init(struct ath11k *ar)
 {
 	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	ar->hw->wiphy->reg_notifier = ath11k_reg_notifier;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 263ea9061948..72b483594015 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_REG_H
@@ -33,6 +33,7 @@ void ath11k_reg_init(struct ath11k *ar);
 void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
+void ath11k_regd_update_chan_list_work(struct work_struct *work);
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
 		      struct cur_regulatory_info *reg_info, bool intersect,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8982b909c821..30b4b0c17682 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3817,6 +3817,7 @@ struct wmi_stop_scan_cmd {
 };
 
 struct scan_chan_list_params {
+	struct list_head list;
 	u32 pdev_id;
 	u16 nallchans;
 	struct channel_param ch_param[];
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 1e8495f50c16..6531cff58ae9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -392,10 +392,8 @@ void brcmf_btcoex_detach(struct brcmf_cfg80211_info *cfg)
 	if (!cfg->btcoex)
 		return;
 
-	if (cfg->btcoex->timer_on) {
-		cfg->btcoex->timer_on = false;
-		timer_shutdown_sync(&cfg->btcoex->timer);
-	}
+	timer_shutdown_sync(&cfg->btcoex->timer);
+	cfg->btcoex->timer_on = false;
 
 	cancel_work_sync(&cfg->btcoex->work);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 86d6286a1537..e5fbb5fcc4ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -741,6 +741,12 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		goto out;
 	}
 
+	if (!(data->functions[DSM_FUNC_QUERY] & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
+				func, data->functions[DSM_FUNC_QUERY]);
+		goto out;
+	}
+
 	*value = data->functions[func];
 	ret = 0;
 out:
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index afe9bcd3ad46..37bb788f83e3 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1150,10 +1150,13 @@ static int lbs_associate(struct lbs_private *priv,
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
index fca3eea7ee84..59bea82eab29 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4680,8 +4680,9 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
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
index 855019fe5485..2a9eae68d9ba 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -667,7 +667,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	goto done;
 
 err_add_intf:
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 err_init_chan_scan:
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
@@ -1515,7 +1515,7 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 	wiphy_free(adapter->wiphy);
 	adapter->wiphy = NULL;
 
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 	mwifiex_free_cmd_buffers(adapter);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 0ca83f1a3e3e..5373f8c419b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1586,6 +1586,10 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 	skb_queue_splice_tail_init(&wcid->tx_pending, &list);
 	spin_unlock(&wcid->tx_pending.lock);
 
+	spin_lock(&wcid->tx_offchannel.lock);
+	skb_queue_splice_tail_init(&wcid->tx_offchannel, &list);
+	spin_unlock(&wcid->tx_offchannel.lock);
+
 	spin_unlock_bh(&phy->tx_lock);
 
 	while ((skb = __skb_dequeue(&list)) != NULL) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index a095fb31e391..f1bd0c174acf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1459,7 +1459,7 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt76_connac2_tx_check_aggr(sta, txwi);
+		mt7925_tx_check_aggr(sta, e->skb, wcid);
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a635b223dab1..59d4357819ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1187,6 +1187,9 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		struct mt792x_bss_conf *mconf;
 		struct mt792x_link_sta *mlink;
 
+		if (vif->type == NL80211_IFTYPE_AP)
+			break;
+
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		if (!link_sta)
 			continue;
@@ -2005,8 +2008,10 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 265958f7b787..5f5544b6214c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1834,8 +1834,8 @@ mt7996_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version)
 {
+	struct uni_header hdr = {};
 	struct ra_fixed_rate *req;
-	struct uni_header hdr;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 	int len;
@@ -3115,7 +3115,7 @@ int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans)
 {
 	struct {
 		u8 __rsv[4];
-	} __packed hdr;
+	} __packed hdr = {};
 	struct hdr_trans_blacklist *req_blacklist;
 	struct hdr_trans_en *req_en;
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 065a1e453745..634b6dacd1e0 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -334,6 +334,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct sk_buff_head *head;
 
 	if (mt76_testmode_enabled(phy)) {
@@ -351,7 +352,8 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 
 	if ((info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) ||
-	    (info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK))
+	    ((info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK) &&
+	     ieee80211_is_probe_req(hdr->frame_control)))
 		head = &wcid->tx_offchannel;
 	else
 		head = &wcid->tx_pending;
@@ -643,6 +645,7 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 {
 	LIST_HEAD(tx_list);
+	int ret = 0;
 
 	if (list_empty(&phy->tx_list))
 		return;
@@ -654,13 +657,13 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
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
@@ -669,9 +672,6 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 		    !skb_queue_empty(&wcid->tx_offchannel) &&
 		    list_empty(&wcid->tx_list))
 			list_add_tail(&wcid->tx_list, &phy->tx_list);
-
-		if (ret < 0)
-			break;
 	}
 	spin_unlock(&phy->tx_lock);
 
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index c259da8161e4..2bce867dd4ac 100644
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
index 2ec20886d176..dfb917c117fa 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -62,8 +62,11 @@ static int __init of_numa_parse_memory_nodes(void)
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
index 80137c7afe0d..5b639c942f17 100644
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
 
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 04686ae1e976..6f5437d210a6 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -242,6 +242,20 @@ static const struct dmi_system_id fwbug_list[] = {
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
 
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 90ad0045fec5..8f06adf82836 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -654,8 +654,6 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
-	case 0x5D: /* Wireless console Toggle */
-	case 0x5E: /* Wireless console Enable */
 	case 0x5F: /* Wireless console Disable */
 		if (quirks->ignore_key_wlan)
 			*code = ASUS_WMI_KEY_IGNORE;
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 12fb0943b5dc..7e0b86535d02 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -167,7 +167,7 @@ static int tpmi_get_logical_id(unsigned int cpu, struct tpmi_cpu_info *info)
 
 	info->punit_thread_id = FIELD_GET(LP_ID_MASK, data);
 	info->punit_core_id = FIELD_GET(MODULE_ID_MASK, data);
-	info->pkg_id = topology_physical_package_id(cpu);
+	info->pkg_id = topology_logical_package_id(cpu);
 	info->linux_cpu = cpu;
 
 	return 0;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index e6c9112a8862..9e44406921b7 100644
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
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e1b06f803a94..ee1d5dec3bc6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -177,9 +177,8 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 
 		lim = queue_limits_start_update(sdkp->disk->queue);
 		sd_set_flush_flag(sdkp, &lim);
-		blk_mq_freeze_queue(sdkp->disk->queue);
-		ret = queue_limits_commit_update(sdkp->disk->queue, &lim);
-		blk_mq_unfreeze_queue(sdkp->disk->queue);
+		ret = queue_limits_commit_update_frozen(sdkp->disk->queue,
+				&lim);
 		if (ret)
 			return ret;
 		return count;
@@ -483,9 +482,7 @@ provisioning_mode_store(struct device *dev, struct device_attribute *attr,
 
 	lim = queue_limits_start_update(sdkp->disk->queue);
 	sd_config_discard(sdkp, &lim, mode);
-	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
-	blk_mq_unfreeze_queue(sdkp->disk->queue);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
 	if (err)
 		return err;
 	return count;
@@ -594,9 +591,7 @@ max_write_same_blocks_store(struct device *dev, struct device_attribute *attr,
 
 	lim = queue_limits_start_update(sdkp->disk->queue);
 	sd_config_write_same(sdkp, &lim);
-	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
-	blk_mq_unfreeze_queue(sdkp->disk->queue);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
 	if (err)
 		return err;
 	return count;
@@ -3803,9 +3798,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	sd_config_write_same(sdkp, &lim);
 	kfree(buffer);
 
-	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
-	blk_mq_unfreeze_queue(sdkp->disk->queue);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
 	if (err)
 		return err;
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 198bec87bb8e..add13e306898 100644
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
@@ -795,12 +801,7 @@ static int get_sectorsize(struct scsi_cd *cd)
 		set_capacity(cd->disk, cd->capacity);
 	}
 
-	lim = queue_limits_start_update(q);
-	lim.logical_block_size = sector_size;
-	blk_mq_freeze_queue(q);
-	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
-	return err;
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
index f8cacb9c7408..5e96913fd946 100644
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
@@ -420,7 +423,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	else
 		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
-		temp |= CFGR1_PCSPOL;
+		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
+				   BIT(fsl_lpspi->config.chip_select));
+
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
@@ -529,14 +534,13 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
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
 
@@ -727,12 +731,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
 	ret = fsl_lpspi_wait_for_completion(controller);
-	if (ret)
-		return ret;
 
 	fsl_lpspi_reset(fsl_lpspi);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
@@ -780,7 +782,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 
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
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 017191b9f864..e6fe6cc35821 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -66,10 +66,14 @@
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
 
-#define LVTS_MONINT_OFFSET_SENSOR0		0xC
-#define LVTS_MONINT_OFFSET_SENSOR1		0x180
-#define LVTS_MONINT_OFFSET_SENSOR2		0x3000
-#define LVTS_MONINT_OFFSET_SENSOR3		0x3000000
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0		BIT(3)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1		BIT(8)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR2		BIT(13)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR3		BIT(25)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR0		BIT(2)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR1		BIT(7)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR2		BIT(12)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR3		BIT(24)
 
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
@@ -329,23 +333,41 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 {
-	u32 masks[] = {
-		LVTS_MONINT_OFFSET_SENSOR0,
-		LVTS_MONINT_OFFSET_SENSOR1,
-		LVTS_MONINT_OFFSET_SENSOR2,
-		LVTS_MONINT_OFFSET_SENSOR3,
+	static const u32 high_offset_inten_masks[] = {
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR2,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR3,
+	};
+	static const u32 low_offset_inten_masks[] = {
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR0,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR1,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR2,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR3,
 	};
 	u32 value = 0;
 	int i;
 
 	value = readl(LVTS_MONINT(lvts_ctrl->base));
 
-	for (i = 0; i < ARRAY_SIZE(masks); i++) {
+	for (i = 0; i < ARRAY_SIZE(high_offset_inten_masks); i++) {
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
-		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
-			value |= masks[i];
-		else
-			value &= ~masks[i];
+		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh) {
+			/*
+			 * The minimum threshold needs to be configured in the
+			 * OFFSETL register to get working interrupts, but we
+			 * don't actually want to generate interrupts when
+			 * crossing it.
+			 */
+			if (lvts_ctrl->low_thresh == -INT_MAX) {
+				value &= ~low_offset_inten_masks[i];
+				value |= high_offset_inten_masks[i];
+			} else {
+				value |= low_offset_inten_masks[i] | high_offset_inten_masks[i];
+			}
+		} else {
+			value &= ~(low_offset_inten_masks[i] | high_offset_inten_masks[i]);
+		}
 	}
 
 	writel(value, LVTS_MONINT(lvts_ctrl->base));
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index db53a3263fbd..89f582612fb9 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -247,7 +247,7 @@ struct btrfs_inode {
 		u64 new_delalloc_bytes;
 		/*
 		 * The offset of the last dir index key that was logged.
-		 * This is used only for directories.
+		 * This is used only for directories. Protected by 'log_mutex'.
 		 */
 		u64 last_dir_index_offset;
 	};
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f84e3f9fad84..98d087a14be5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7767,6 +7767,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_sub_trans = 0;
 	ei->logged_trans = 0;
 	ei->delalloc_bytes = 0;
+	/* new_delalloc_bytes and last_dir_index_offset are in a union. */
 	ei->new_delalloc_bytes = 0;
 	ei->defrag_bytes = 0;
 	ei->disk_i_size = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 31adea5b0b96..f917fdae7e67 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3322,6 +3322,31 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
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
@@ -3339,15 +3364,32 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
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
@@ -3356,10 +3398,8 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
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
@@ -3413,8 +3453,7 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 		 * Set logged_trans to a value greater than 0 and less then the
 		 * current transaction to avoid doing the search in future calls.
 		 */
-		inode->logged_trans = trans->transid - 1;
-		return 0;
+		return mark_inode_as_not_logged(trans, inode);
 	}
 
 	/*
@@ -3422,20 +3461,9 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
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
@@ -4028,7 +4056,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 
 /*
  * If the inode was logged before and it was evicted, then its
- * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * last_dir_index_offset is 0, so we don't know the value of the last index
  * key offset. If that's the case, search for it and update the inode. This
  * is to avoid lookups in the log tree every time we try to insert a dir index
  * key from a leaf changed in the current transaction, and to allow us to always
@@ -4044,7 +4072,7 @@ static int update_last_dir_index_offset(struct btrfs_inode *inode,
 
 	lockdep_assert_held(&inode->log_mutex);
 
-	if (inode->last_dir_index_offset != (u64)-1)
+	if (inode->last_dir_index_offset != 0)
 		return 0;
 
 	if (!ctx->logged_before) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2fdb2987c83a..8e8edfe0c619 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2186,6 +2186,40 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
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
@@ -2270,31 +2304,12 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
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
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a95525bfb99c..d8120b88fa00 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1823,7 +1823,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
+	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
+	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..ada46189b086 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -513,4 +513,33 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+/*
+ * Pass journal explicitly as it may not be cached in the sbi->s_journal in some
+ * cases
+ */
+static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *journal)
+{
+	int err = 0;
+
+	/*
+	 * At this point only two things can be operating on the journal.
+	 * JBD2 thread performing transaction commit and s_sb_upd_work
+	 * issuing sb update through the journal. Once we set
+	 * EXT4_JOURNAL_DESTROY, new ext4_handle_error() calls will not
+	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
+	 * ext4_handle_error() calls from the running transaction commit are
+	 * finished. Hence no new s_sb_upd_work can be queued after we
+	 * flush it here.
+	 */
+	ext4_set_mount_flag(sbi->s_sb, EXT4_MF_JOURNAL_DESTROY);
+
+	ext4_force_commit(sbi->s_sb);
+	flush_work(&sbi->s_sb_upd_work);
+
+	err = jbd2_journal_destroy(journal);
+	sbi->s_journal = NULL;
+
+	return err;
+}
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 722ac723f49b..58d125ad2371 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -719,9 +719,13 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * In case the fs should keep running, we need to writeout
 		 * superblock through the journal. Due to lock ordering
 		 * constraints, it may not be safe to do it right here so we
-		 * defer superblock flushing to a workqueue.
+		 * defer superblock flushing to a workqueue. We just need to be
+		 * careful when the journal is already shutting down. If we get
+		 * here in that case, just update the sb directly as the last
+		 * transaction won't commit anyway.
 		 */
-		if (continue_fs && journal)
+		if (continue_fs && journal &&
+		    !ext4_test_mount_flag(sb, EXT4_MF_JOURNAL_DESTROY))
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
@@ -1306,18 +1310,17 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_li_request(sb);
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 
-	flush_work(&sbi->s_sb_upd_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
 	ext4_release_orphan_info(sb);
 
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
-		err = jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		err = ext4_journal_destroy(sbi, sbi->s_journal);
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
-	}
+	} else
+		flush_work(&sbi->s_sb_upd_work);
 
 	ext4_es_unregister_shrinker(sbi);
 	timer_shutdown_sync(&sbi->s_err_report);
@@ -4955,10 +4958,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	return 0;
 
 out:
-	/* flush s_sb_upd_work before destroying the journal. */
-	flush_work(&sbi->s_sb_upd_work);
-	jbd2_journal_destroy(sbi->s_journal);
-	sbi->s_journal = NULL;
+	ext4_journal_destroy(sbi, sbi->s_journal);
 	return -EINVAL;
 }
 
@@ -5647,10 +5647,7 @@ failed_mount8: __maybe_unused
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
-		/* flush s_sb_upd_work before journal destroy. */
-		flush_work(&sbi->s_sb_upd_work);
-		jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		ext4_journal_destroy(sbi, sbi->s_journal);
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
@@ -5958,7 +5955,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	return journal;
 
 out_journal:
-	jbd2_journal_destroy(journal);
+	ext4_journal_destroy(EXT4_SB(sb), journal);
 out_bdev:
 	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
@@ -6075,8 +6072,7 @@ static int ext4_load_journal(struct super_block *sb,
 	EXT4_SB(sb)->s_journal = journal;
 	err = ext4_clear_journal_err(sb, es);
 	if (err) {
-		EXT4_SB(sb)->s_journal = NULL;
-		jbd2_journal_destroy(journal);
+		ext4_journal_destroy(EXT4_SB(sb), journal);
 		return err;
 	}
 
@@ -6094,7 +6090,7 @@ static int ext4_load_journal(struct super_block *sb,
 	return 0;
 
 err_out:
-	jbd2_journal_destroy(journal);
+	ext4_journal_destroy(EXT4_SB(sb), journal);
 	return err;
 }
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2391b09f4ced..4ae226778d64 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2572,10 +2572,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			wakeup_bdi = inode_io_list_move_locked(inode, wb,
 							       dirty_list);
 
-			spin_unlock(&wb->list_lock);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_dirty_inode_enqueue(inode);
-
 			/*
 			 * If this is the first dirty inode for this bdi,
 			 * we have to wake-up the corresponding bdi thread
@@ -2585,6 +2581,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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
diff --git a/fs/namespace.c b/fs/namespace.c
index 962fda4fa246..c8519302f582 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2227,7 +2227,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
 	namespace_unlock();
 }
 
-bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
 
@@ -2241,6 +2241,16 @@ bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return false;
 }
 
+bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+{
+	bool res;
+
+	read_seqlock_excl(&mount_lock);
+	res = __has_locked_children(mnt, dentry);
+	read_sequnlock_excl(&mount_lock);
+	return res;
+}
+
 /**
  * clone_private_mount - create a private clone of a path
  * @path: path to clone
@@ -2268,7 +2278,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 		return ERR_PTR(-EPERM);
 	}
 
-	if (has_locked_children(old_mnt, path->dentry))
+	if (__has_locked_children(old_mnt, path->dentry))
 		goto invalid;
 
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
@@ -2762,7 +2772,7 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
 		return mnt;
 
-	if (!recurse && has_locked_children(old, old_path->dentry))
+	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return mnt;
 
 	if (recurse)
@@ -3152,7 +3162,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 		goto out;
 
 	/* From mount should not have locked children in place of To's root */
-	if (has_locked_children(from, to->mnt.mnt_root))
+	if (__has_locked_children(from, to->mnt.mnt_root))
 		goto out;
 
 	/* Setting sharing groups is only allowed on private mounts */
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 2cc5c99fe941..4a7509389cf3 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1205,6 +1205,9 @@ static void ocfs2_clear_inode(struct inode *inode)
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
index e21d99fa9263..a87a9404e0d0 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -362,6 +362,25 @@ static const struct inode_operations proc_dir_inode_operations = {
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
@@ -369,6 +388,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
+	pde_set_flags(dp);
+
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
 	if (pde_subdir_insert(dir, dp) == false) {
@@ -557,20 +578,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
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
@@ -581,7 +588,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 	if (!p)
 		return NULL;
 	p->proc_ops = proc_ops;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
@@ -632,7 +638,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -663,7 +668,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a901aed77141..cd9c97f6f948 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -990,6 +990,8 @@ queue_limits_start_update(struct request_queue *q)
 	mutex_lock(&q->limits_lock);
 	return q->limits;
 }
+int queue_limits_commit_update_frozen(struct request_queue *q,
+		struct queue_limits *lim);
 int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7e029c82ae45..26ee360c345f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -77,9 +77,6 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATTACH_TYPE];
 #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_enabled_key[atype])
 
-#define for_each_cgroup_storage_type(stype) \
-	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
-
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -518,8 +515,6 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
 
-#define for_each_cgroup_storage_type(stype) for (; false; )
-
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1150a595aa54..6db72c66de91 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -205,6 +205,20 @@ enum btf_field_type {
 	BPF_WORKQUEUE  = (1 << 10),
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
+	__BPF_CGROUP_STORAGE_MAX
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+};
+
+#ifdef CONFIG_CGROUP_BPF
+# define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
+#else
+# define for_each_cgroup_storage_type(stype) for (; false; )
+#endif /* CONFIG_CGROUP_BPF */
+
 typedef void (*btf_dtor_kfunc_t)(void *);
 
 struct btf_field_kptr {
@@ -256,6 +270,19 @@ struct bpf_list_node_kern {
 	void *owner;
 } __attribute__((aligned(8)));
 
+/* 'Ownership' of program-containing map is claimed by the first program
+ * that is going to use this map or by the first program which FD is
+ * stored in the map to make sure that all callers and callees have the
+ * same prog type, JITed flag and xdp_has_frags flag.
+ */
+struct bpf_map_owner {
+	enum bpf_prog_type type;
+	bool jited;
+	bool xdp_has_frags;
+	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
+	const struct btf_type *attach_func_proto;
+};
+
 struct bpf_map {
 	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
@@ -288,24 +315,15 @@ struct bpf_map {
 		struct rcu_head rcu;
 	};
 	atomic64_t writecnt;
-	/* 'Ownership' of program-containing map is claimed by the first program
-	 * that is going to use this map or by the first program which FD is
-	 * stored in the map to make sure that all callers and callees have the
-	 * same prog type, JITed flag and xdp_has_frags flag.
-	 */
-	struct {
-		const struct btf_type *attach_func_proto;
-		spinlock_t lock;
-		enum bpf_prog_type type;
-		bool jited;
-		bool xdp_has_frags;
-	} owner;
+	spinlock_t owner_lock;
+	struct bpf_map_owner *owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
 	bool free_after_rcu_gp;
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
+	u64 cookie; /* write-once */
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
@@ -1025,14 +1043,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-enum bpf_cgroup_storage_type {
-	BPF_CGROUP_STORAGE_SHARED,
-	BPF_CGROUP_STORAGE_PERCPU,
-	__BPF_CGROUP_STORAGE_MAX
-};
-
-#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
-
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  */
@@ -1980,6 +1990,16 @@ static inline bool bpf_map_flags_access_ok(u32 access_flags)
 	       (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
 }
 
+static inline struct bpf_map_owner *bpf_map_owner_alloc(struct bpf_map *map)
+{
+	return kzalloc(sizeof(*map->owner), GFP_ATOMIC);
+}
+
+static inline void bpf_map_owner_free(struct bpf_map *map)
+{
+	kfree(map->owner);
+}
+
 struct bpf_event_entry {
 	struct perf_event *event;
 	struct file *perf_file;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 017d31f1d27b..7d8d09318fa9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -978,7 +978,6 @@ const struct hid_device_id *hid_match_device(struct hid_device *hdev,
 					     struct hid_driver *hdrv);
 bool hid_compare_device_paths(struct hid_device *hdev_a,
 			      struct hid_device *hdev_b, char separator);
-s32 hid_snto32(__u32 value, unsigned n);
 __u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
 		     unsigned offset, unsigned n);
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 5ce332fc6ff5..61675ea95e0b 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -646,8 +646,16 @@ struct io_kiocb {
 	atomic_t			refs;
 	bool				cancel_seq_set;
 	struct io_task_work		io_task_work;
-	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
-	struct hlist_node		hash_node;
+	union {
+		/*
+		 * for polled requests, i.e. IORING_OP_POLL_ADD and async armed
+		 * poll
+		 */
+		struct hlist_node	hash_node;
+
+		/* for private io_kiocb freeing */
+		struct rcu_head		rcu_head;
+	};
 	/* internal polling, see IORING_FEAT_FAST_POLL */
 	struct async_poll		*apoll;
 	/* opcode allocated if it needs to store data for async defer */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index be6ca84db4d8..1ba6e32909f8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1697,6 +1697,22 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
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
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b2827fce5a2d..314328ab0b84 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3153,9 +3153,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
 	return skb_inner_network_header(skb) - skb->data;
 }
 
+static inline enum skb_drop_reason
+pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
+}
+
 static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
 {
-	return pskb_may_pull(skb, skb_network_offset(skb) + len);
+	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 /*
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 2dcf76219131..1fce4f606770 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -209,22 +209,6 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
 
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
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 4748680e8c88..02e7be19b042 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -92,6 +92,14 @@
 	FN(PACKET_SOCK_ERROR)		\
 	FN(TC_CHAIN_NOTFOUND)		\
 	FN(TC_RECLASSIFY_LOOP)		\
+	FN(VXLAN_INVALID_HDR)		\
+	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(MAC_INVALID_SOURCE)		\
+	FN(VXLAN_ENTRY_EXISTS)		\
+	FN(NO_TX_TARGET)		\
+	FN(IP_TUNNEL_ECN)		\
+	FN(TUNNEL_TXINFO)		\
+	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
 /**
@@ -418,6 +426,38 @@ enum skb_drop_reason {
 	 * iterations.
 	 */
 	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_INVALID_HDR: VXLAN header is invalid. E.g.:
+	 * 1) reserved fields are not zero
+	 * 2) "I" flag is not set
+	 */
+	SKB_DROP_REASON_VXLAN_INVALID_HDR,
+	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
+	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */
+	SKB_DROP_REASON_MAC_INVALID_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_ENTRY_EXISTS: trying to migrate a static
+	 * entry or an entry pointing to a nexthop.
+	 */
+	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
+	/** @SKB_DROP_REASON_NO_TX_TARGET: no target found for xmit */
+	SKB_DROP_REASON_NO_TX_TARGET,
+	/**
+	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
+	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
+	 */
+	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metadata
+	 * reached a device which is in "external" mode.
+	 */
+	SKB_DROP_REASON_TUNNEL_TXINFO,
+	/**
+	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
+	 * the MAC address of the local netdev.
+	 */
+	SKB_DROP_REASON_LOCAL_MAC,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/dsa.h b/include/net/dsa.h
index d7a6c2930277..877f9b270cf6 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1003,6 +1003,7 @@ struct dsa_switch_ops {
 	/*
 	 * Port's MAC EEE settings
 	 */
+	bool	(*support_eee)(struct dsa_switch *ds, int port);
 	int	(*set_mac_eee)(struct dsa_switch *ds, int port,
 			       struct ethtool_keee *e);
 	int	(*get_mac_eee)(struct dsa_switch *ds, int port,
@@ -1398,5 +1399,6 @@ static inline bool dsa_user_dev_check(const struct net_device *dev)
 
 netdev_tx_t dsa_enqueue_skb(struct sk_buff *skb, struct net_device *dev);
 void dsa_port_phylink_mac_change(struct dsa_switch *ds, int port, bool up);
+bool dsa_supports_eee(struct dsa_switch *ds, int port);
 
 #endif
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6a070478254d..ae83a969ae64 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -439,7 +439,8 @@ int ip_tunnel_encap_del_ops(const struct ip_tunnel_encap_ops *op,
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
-static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+static inline enum skb_drop_reason
+pskb_inet_may_pull_reason(struct sk_buff *skb)
 {
 	int nhlen;
 
@@ -456,7 +457,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 		nhlen = 0;
 	}
 
-	return pskb_network_may_pull(skb, nhlen);
+	return pskb_network_may_pull_reason(skb, nhlen);
+}
+
+static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+{
+	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
 /* Variant of pskb_inet_may_pull().
diff --git a/io_uring/msg_ring.c b/io_uring/msg_ring.c
index 35b1b585e9cb..b68e009bce21 100644
--- a/io_uring/msg_ring.c
+++ b/io_uring/msg_ring.c
@@ -82,7 +82,7 @@ static void io_msg_tw_complete(struct io_kiocb *req, struct io_tw_state *ts)
 		spin_unlock(&ctx->msg_lock);
 	}
 	if (req)
-		kmem_cache_free(req_cachep, req);
+		kfree_rcu(req, rcu_head);
 	percpu_ref_put(&ctx->refs);
 }
 
@@ -91,7 +91,7 @@ static int io_msg_remote_post(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	req->task = READ_ONCE(ctx->submitter_task);
 	if (!req->task) {
-		kmem_cache_free(req_cachep, req);
+		kfree_rcu(req, rcu_head);
 		return -EOWNERDEAD;
 	}
 	req->opcode = IORING_OP_NOP;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 767dcb8471f6..6f91e3a123e5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2310,28 +2310,44 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 				      const struct bpf_prog *fp)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
-	bool ret;
 	struct bpf_prog_aux *aux = fp->aux;
+	enum bpf_cgroup_storage_type i;
+	bool ret = false;
+	u64 cookie;
 
 	if (fp->kprobe_override)
-		return false;
+		return ret;
 
-	spin_lock(&map->owner.lock);
-	if (!map->owner.type) {
-		/* There's no owner yet where we could check for
-		 * compatibility.
-		 */
-		map->owner.type  = prog_type;
-		map->owner.jited = fp->jited;
-		map->owner.xdp_has_frags = aux->xdp_has_frags;
-		map->owner.attach_func_proto = aux->attach_func_proto;
+	spin_lock(&map->owner_lock);
+	/* There's no owner yet where we could check for compatibility. */
+	if (!map->owner) {
+		map->owner = bpf_map_owner_alloc(map);
+		if (!map->owner)
+			goto err;
+		map->owner->type  = prog_type;
+		map->owner->jited = fp->jited;
+		map->owner->xdp_has_frags = aux->xdp_has_frags;
+		map->owner->attach_func_proto = aux->attach_func_proto;
+		for_each_cgroup_storage_type(i) {
+			map->owner->storage_cookie[i] =
+				aux->cgroup_storage[i] ?
+				aux->cgroup_storage[i]->cookie : 0;
+		}
 		ret = true;
 	} else {
-		ret = map->owner.type  == prog_type &&
-		      map->owner.jited == fp->jited &&
-		      map->owner.xdp_has_frags == aux->xdp_has_frags;
+		ret = map->owner->type  == prog_type &&
+		      map->owner->jited == fp->jited &&
+		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		for_each_cgroup_storage_type(i) {
+			if (!ret)
+				break;
+			cookie = aux->cgroup_storage[i] ?
+				 aux->cgroup_storage[i]->cookie : 0;
+			ret = map->owner->storage_cookie[i] == cookie ||
+			      !cookie;
+		}
 		if (ret &&
-		    map->owner.attach_func_proto != aux->attach_func_proto) {
+		    map->owner->attach_func_proto != aux->attach_func_proto) {
 			switch (prog_type) {
 			case BPF_PROG_TYPE_TRACING:
 			case BPF_PROG_TYPE_LSM:
@@ -2344,8 +2360,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 			}
 		}
 	}
-	spin_unlock(&map->owner.lock);
-
+err:
+	spin_unlock(&map->owner_lock);
 	return ret;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ab74a226e3d6..ba4543e771a6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/cookie.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -51,6 +52,7 @@
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
 DEFINE_PER_CPU(int, bpf_prog_active);
+DEFINE_COOKIE(bpf_map_cookie);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
@@ -765,6 +767,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
+	bpf_map_owner_free(map);
 	bpf_map_free(map);
 }
 
@@ -859,12 +862,12 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 	struct bpf_map *map = filp->private_data;
 	u32 type = 0, jited = 0;
 
-	if (map_type_contains_progs(map)) {
-		spin_lock(&map->owner.lock);
-		type  = map->owner.type;
-		jited = map->owner.jited;
-		spin_unlock(&map->owner.lock);
+	spin_lock(&map->owner_lock);
+	if (map->owner) {
+		type  = map->owner->type;
+		jited = map->owner->jited;
 	}
+	spin_unlock(&map->owner_lock);
 
 	seq_printf(m,
 		   "map_type:\t%u\n"
@@ -1360,10 +1363,14 @@ static int map_create(union bpf_attr *attr)
 	if (err < 0)
 		goto free_map;
 
+	preempt_disable();
+	map->cookie = gen_cookie_next(&bpf_map_cookie);
+	preempt_enable();
+
 	atomic64_set(&map->refcnt, 1);
 	atomic64_set(&map->usercnt, 1);
 	mutex_init(&map->freeze_mutex);
-	spin_lock_init(&map->owner.lock);
+	spin_lock_init(&map->owner_lock);
 
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..4bd825c24e26 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2174,6 +2174,8 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 		goto unlock;
 
 	hop_masks = bsearch(&k, k.masks, sched_domains_numa_levels, sizeof(k.masks[0]), hop_cmp);
+	if (!hop_masks)
+		goto unlock;
 	hop = hop_masks	- k.masks;
 
 	ret = hop ?
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index d8fb281e439d..d4ac26ad1d3e 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1548,6 +1548,7 @@ static void kasan_strings(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 
 	kfree(ptr);
 
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 91894fc54c64..0aecd537645a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -432,9 +432,15 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
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
@@ -731,6 +737,11 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
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
@@ -738,6 +749,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 			 * be freed while the kmemleak_lock is held.
 			 */
 			dump_object_info(parent);
+			printk_deferred_exit();
 			return -EEXIST;
 		}
 	}
@@ -851,13 +863,8 @@ static void delete_object_part(unsigned long ptr, size_t size,
 
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
@@ -877,8 +884,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
 
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
diff --git a/mm/slub.c b/mm/slub.c
index dc527b59f5a9..7fbba36f7aac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -935,19 +935,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
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
@@ -969,9 +969,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -1027,22 +1027,31 @@ void skip_orig_size_check(struct kmem_cache *s, const void *object)
 	set_orig_size(s, (void *)object, s->object_size);
 }
 
-static void slab_bug(struct kmem_cache *s, char *fmt, ...)
+static void __slab_bug(struct kmem_cache *s, const char *fmt, va_list argsp)
 {
 	struct va_format vaf;
 	va_list args;
 
-	va_start(args, fmt);
+	va_copy(args, argsp);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	pr_err("=============================================================================\n");
-	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
+	pr_err("BUG %s (%s): %pV\n", s ? s->name : "<unknown>", print_tainted(), &vaf);
 	pr_err("-----------------------------------------------------------------------------\n\n");
 	va_end(args);
 }
 
+static void slab_bug(struct kmem_cache *s, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	__slab_bug(s, fmt, args);
+	va_end(args);
+}
+
 __printf(2, 3)
-static void slab_fix(struct kmem_cache *s, char *fmt, ...)
+static void slab_fix(struct kmem_cache *s, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -1095,19 +1104,24 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
 			      size_from_object(s) - off);
-
-	dump_stack();
 }
 
 static void object_err(struct kmem_cache *s, struct slab *slab,
-			u8 *object, char *reason)
+			u8 *object, const char *reason)
 {
 	if (slab_add_kunit_errors())
 		return;
 
-	slab_bug(s, "%s", reason);
-	print_trailer(s, slab, object);
+	slab_bug(s, reason);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	WARN_ON(1);
 }
 
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
@@ -1124,22 +1138,30 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 	return false;
 }
 
+static void __slab_err(struct slab *slab)
+{
+	if (slab_in_kunit_test())
+		return;
+
+	print_slab_info(slab);
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	WARN_ON(1);
+}
+
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 			const char *fmt, ...)
 {
 	va_list args;
-	char buf[100];
 
 	if (slab_add_kunit_errors())
 		return;
 
 	va_start(args, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, args);
+	__slab_bug(s, fmt, args);
 	va_end(args);
-	slab_bug(s, "%s", buf);
-	print_slab_info(slab);
-	dump_stack();
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	__slab_err(slab);
 }
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
@@ -1176,7 +1198,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 					  s->inuse - poison_size);
 }
 
-static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
+static void restore_bytes(struct kmem_cache *s, const char *message, u8 data,
 						void *from, void *to)
 {
 	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
@@ -1191,8 +1213,8 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 
 static pad_check_attributes int
 check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, char *what,
-		       u8 *start, unsigned int value, unsigned int bytes)
+		       u8 *object, const char *what, u8 *start, unsigned int value,
+		       unsigned int bytes, bool slab_obj_print)
 {
 	u8 *fault;
 	u8 *end;
@@ -1211,10 +1233,11 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	if (slab_add_kunit_errors())
 		goto skip_bug_print;
 
-	slab_bug(s, "%s overwritten", what);
-	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
-					fault, end - 1, fault - addr,
-					fault[0], value);
+	pr_err("[%s overwritten] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	       what, fault, end - 1, fault - addr, fault[0], value);
+
+	if (slab_obj_print)
+		object_err(s, slab, object, "Object corrupt");
 
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
@@ -1278,7 +1301,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		return 1;
 
 	return check_bytes_and_report(s, slab, p, "Object padding",
-			p + off, POISON_INUSE, size_from_object(s) - off);
+			p + off, POISON_INUSE, size_from_object(s) - off, true);
 }
 
 /* Check the pad bytes at the end of a slab page */
@@ -1311,9 +1334,10 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
-	slab_err(s, slab, "Padding overwritten. 0x%p-0x%p @offset=%tu",
-			fault, end - 1, fault - start);
+	slab_bug(s, "Padding overwritten. 0x%p-0x%p @offset=%tu",
+		 fault, end - 1, fault - start);
 	print_section(KERN_ERR, "Padding ", pad, remainder);
+	__slab_err(slab);
 
 	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
 }
@@ -1328,11 +1352,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
-			object - s->red_left_pad, val, s->red_left_pad))
+			object - s->red_left_pad, val, s->red_left_pad, ret))
 			ret = 0;
 
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
-			endobject, val, s->inuse - s->object_size))
+			endobject, val, s->inuse - s->object_size, ret))
 			ret = 0;
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
@@ -1341,7 +1365,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (s->object_size > orig_size  &&
 				!check_bytes_and_report(s, slab, object,
 					"kmalloc Redzone", p + orig_size,
-					val, s->object_size - orig_size)) {
+					val, s->object_size - orig_size, ret)) {
 				ret = 0;
 			}
 		}
@@ -1349,7 +1373,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
-				s->inuse - s->object_size))
+				s->inuse - s->object_size, ret))
 				ret = 0;
 		}
 	}
@@ -1365,11 +1389,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (kasan_meta_size < s->object_size - 1 &&
 			    !check_bytes_and_report(s, slab, p, "Poison",
 					p + kasan_meta_size, POISON_FREE,
-					s->object_size - kasan_meta_size - 1))
+					s->object_size - kasan_meta_size - 1, ret))
 				ret = 0;
 			if (kasan_meta_size < s->object_size &&
 			    !check_bytes_and_report(s, slab, p, "End Poison",
-					p + s->object_size - 1, POISON_END, 1))
+					p + s->object_size - 1, POISON_END, 1, ret))
 				ret = 0;
 		}
 		/*
@@ -1395,11 +1419,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		ret = 0;
 	}
 
-	if (!ret && !slab_in_kunit_test()) {
-		print_trailer(s, slab, object);
-		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-	}
-
 	return ret;
 }
 
@@ -1634,12 +1653,12 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
 				 object);
 		} else if (!slab->slab_cache) {
-			pr_err("SLUB <none>: no slab for object 0x%p.\n",
-			       object);
-			dump_stack();
-		} else
+			slab_err(NULL, slab, "No slab cache for object 0x%p",
+				 object);
+		} else {
 			object_err(s, slab, object,
-					"page slab pointer corrupt.");
+				   "page slab pointer corrupt.");
+		}
 		return 0;
 	}
 	return 1;
@@ -1872,9 +1891,9 @@ static inline bool free_debug_processing(struct kmem_cache *s,
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
@@ -3822,9 +3841,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -3856,7 +3880,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr,
+				  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 		return freelist;
 	}
@@ -4344,8 +4369,12 @@ static noinline void free_to_partial_list(
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
 
@@ -5444,14 +5473,14 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	return !!oo_objects(s->oo);
 }
 
-static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
-			      const char *text)
+static void list_slab_objects(struct kmem_cache *s, struct slab *slab)
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = slab_address(slab);
 	void *p;
 
-	slab_err(s, slab, text, s->name);
+	if (!slab_add_kunit_errors())
+		slab_bug(s, "Objects remaining on __kmem_cache_shutdown()");
 
 	spin_lock(&object_map_lock);
 	__fill_map(object_map, s, slab);
@@ -5466,6 +5495,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 		}
 	}
 	spin_unlock(&object_map_lock);
+
+	__slab_err(slab);
 #endif
 }
 
@@ -5486,8 +5517,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
 		} else {
-			list_slab_objects(s, slab,
-			  "Objects remaining in %s on __kmem_cache_shutdown()");
+			list_slab_objects(s, slab);
 		}
 	}
 	spin_unlock_irq(&n->list_lock);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c0388b2e959d..2628fc02be08 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -474,10 +474,5 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
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
index dc38539f8560..eb6c5cb27ed1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -462,9 +462,6 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
-	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
-#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -532,6 +529,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			sparse_buffer_fini();
 			goto failed;
 		}
+		memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						   PAGE_SIZE));
 		check_usemap_section_nr(nid, usage);
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 				SECTION_IS_EARLY);
@@ -643,7 +642,6 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
@@ -819,10 +817,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
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
@@ -867,6 +869,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8b0f2fbd6a75..904095f69a6e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1432,10 +1432,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
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
index 71ebd0284f95..0adc783fb83c 100644
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
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bc2aa514b8c5..5f5137764b80 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3354,7 +3354,7 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	 * advertising data. This also applies to the case
 	 * where BR/EDR was toggled during the AUTO_OFF phase.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	    list_empty(&hdev->adv_instances)) {
 		if (ext_adv_capable(hdev)) {
 			err = hci_setup_ext_adv_instance_sync(hdev, 0x00);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 615c18e290ab..b35f1551b9be 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1409,7 +1409,10 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	l2cap_sock_cleanup_listen(sk);
+	release_sock(sk);
+
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, SHUT_RDWR);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 17a5f5923d61..5ad3f3ef4ca7 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -653,9 +653,6 @@ static unsigned int br_nf_local_in(void *priv,
 		break;
 	}
 
-	ct = container_of(nfct, struct nf_conn, ct_general);
-	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
-
 	return ret;
 }
 #endif
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index 412816076b8b..392f1cb5cc47 100644
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
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 25258b33e59e..9c77c80e8fe9 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1589,6 +1589,22 @@ dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 	return pcs;
 }
 
+/* dsa_supports_eee - indicate that EEE is supported
+ * @ds: pointer to &struct dsa_switch
+ * @port: port index
+ *
+ * A default implementation for the .support_eee() DSA operations member,
+ * which drivers can use to indicate that they support EEE on all of their
+ * user ports.
+ *
+ * Returns: true
+ */
+bool dsa_supports_eee(struct dsa_switch *ds, int port)
+{
+	return true;
+}
+EXPORT_SYMBOL_GPL(dsa_supports_eee);
+
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 64f660d2334b..06267c526dc4 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1231,6 +1231,10 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
+	/* Check whether the switch supports EEE */
+	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+		return -EOPNOTSUPP;
+
 	/* Port's PHY and MAC both need to be EEE capable */
 	if (!dev->phydev || !dp->pl)
 		return -ENODEV;
@@ -1251,6 +1255,10 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
+	/* Check whether the switch supports EEE */
+	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+		return -EOPNOTSUPP;
+
 	/* Port's PHY and MAC both need to be EEE capable */
 	if (!dev->phydev || !dp->pl)
 		return -ENODEV;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a55e95046984..46fa50576f58 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -351,14 +351,13 @@ static void inetdev_destroy(struct in_device *in_dev)
 
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
index b8111ec651b5..8f11870b7737 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -799,11 +799,12 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
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
@@ -818,7 +819,8 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 		goto out;
 
 	orig_ip = ip_hdr(skb_in)->saddr;
-	ip_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.ip;
+	dir = CTINFO2DIR(ctinfo);
+	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
 	__icmp_send(skb_in, type, code, info, &opts);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
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
index 59173f58ce99..882ce5444572 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1417,17 +1417,17 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
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
@@ -1517,25 +1517,19 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
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
@@ -1562,13 +1556,17 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
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
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 70aeebfc4182..9a552569143b 100644
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
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9c563cdbea90..fc07fc4ed998 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -743,6 +743,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
 	unsigned int i;
 	bool ret = false;
 
+	if (!lnk->smcibdev->ibdev->dma_device)
+		return ret;
+
 	/* for now there is just one DMA address */
 	for_each_sg(buf_slot->sgt[lnk->link_idx].sgl, sg,
 		    buf_slot->sgt[lnk->link_idx].nents, i) {
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d80ab1725f28..f00ccc6d803b 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1868,7 +1868,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			 */
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			if (!new->pub.hidden_beacon_bss)
+				kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 268171600087..e0d3c713538b 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -903,13 +903,16 @@ void __cfg80211_connect_result(struct net_device *dev,
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
index 4fd6b6ab3e32..32a4e6bfa047 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -223,7 +223,11 @@ fn main() {
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
@@ -243,7 +247,11 @@ fn main() {
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
index b05ef4bec660..70a90117361c 100644
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
index b31b15cf453a..a28a59926ada 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11328,6 +11328,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x300f, "TongFang X6AR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x3019, "TongFang X6FR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ef30d4aaf81a..7bd87193c617 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4212,9 +4212,11 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
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
index cb40497faee4..b7e55be9bd9f 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -20,7 +20,7 @@ def test_receive(cfg, ipv4=False, extra_args=None):
         ip_args = f"-6 -S {cfg.remote_v6} -D {cfg.v6}"
 
     rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
-    tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
+    tx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
 
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(34000, proto="udp")
@@ -43,7 +43,7 @@ def test_transmit(cfg, ipv4=False, extra_args=None):
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

