Return-Path: <stable+bounces-124281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF6A5F455
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B4B17EA3A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613A2673A0;
	Thu, 13 Mar 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iz/MS7wY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E847267399;
	Thu, 13 Mar 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868875; cv=none; b=UUCSgR93XpjCqLDVPbBFBlAs/iSxA9406xeitfKT+Px5ziDWmfqfgG4Wmfc1JdsNMBqTTZ2szO0FP6n4LaQgk9hvi58KovhFqNYBbc7MDzmeo2Cn8bRXf0IXQ3lUDb0l3SzAZZNRYikISJlXapw8dQw6uLZbQ+gXaL8tquCz3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868875; c=relaxed/simple;
	bh=XrATmr12AC5Eupgsowgv2tbeC2ZaM5XGBgl9yo0LO48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWLjiY0njJ7ZwfiGTmCinmbC6Hdt/OadNvIl2RcMqAt+LJ+8u9Bl22jRyD3rPI7/1ACccYFwFWq7wZlWLuCwZKR2AucX5ktBvK/27NrucfMw4gM2khC+8GISgCLjIBzsNU/jrdCDiE9DaSBOZjwnnSBr45CUcAPutPdoIVpbFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iz/MS7wY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC09C4CEDD;
	Thu, 13 Mar 2025 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868875;
	bh=XrATmr12AC5Eupgsowgv2tbeC2ZaM5XGBgl9yo0LO48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iz/MS7wYrLpw5Hj9wse92KJAcUhV0WDUP+/9VPQ6vCZdysDysvRVmt1P+yvNGl3Qt
	 yHllOV2uTS44V/n+90ZBLkipIXIxwl20sCOGvC4zh9yTGZdBxVivckqnNLApxIEUyU
	 XnR/qWWtvdA9KhdIgwkIKCmbIo4bJHNTCfLW1RKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.291
Date: Thu, 13 Mar 2025 13:27:42 +0100
Message-ID: <2025031341-preamble-virus-287f@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031341-obsessive-broom-7322@gregkh>
References: <2025031341-obsessive-broom-7322@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..ccb9df705fb1 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -21,7 +21,7 @@ properties:
   "#address-cells":
     const: 1
     description: |
-      The cell is the slot ID if a function subnode is used.
+      The cell is the SDIO function number if a function subnode is used.
 
   "#size-cells":
     const: 0
diff --git a/Makefile b/Makefile
index dc7f459fc670..010b5c1c3cf5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 290
+SUBLEVEL = 291
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
@@ -956,6 +956,11 @@ ifeq ($(CONFIG_RELR),y)
 LDFLAGS_vmlinux	+= --pack-dyn-relocs=relr --use-android-relr-tags
 endif
 
+# userspace programs are linked via the compiler, use the correct linker
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
+endif
+
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
 
diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index c29194181025..22170f7b8be8 100644
--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -42,6 +42,8 @@ struct pt_regs {
 	unsigned long trap_a0;
 	unsigned long trap_a1;
 	unsigned long trap_a2;
+/* This makes the stack 16-byte aligned as GCC expects */
+	unsigned long __pad0;
 /* These are saved by PAL-code: */
 	unsigned long ps;
 	unsigned long pc;
diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index 2e125e5c1508..05d9296af5ea 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -32,7 +32,9 @@ void foo(void)
         DEFINE(CRED_EGID, offsetof(struct cred, egid));
         BLANK();
 
+	DEFINE(SP_OFF, offsetof(struct pt_regs, ps));
 	DEFINE(SIZEOF_PT_REGS, sizeof(struct pt_regs));
+	DEFINE(SWITCH_STACK_SIZE, sizeof(struct switch_stack));
 	DEFINE(PT_PTRACED, PT_PTRACED);
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index c27d01232799..f0ccc58f8fed 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -15,10 +15,6 @@
 	.set noat
 	.cfi_sections	.debug_frame
 
-/* Stack offsets.  */
-#define SP_OFF			184
-#define SWITCH_STACK_SIZE	320
-
 .macro	CFI_START_OSF_FRAME	func
 	.align	4
 	.globl	\func
@@ -199,8 +195,8 @@ CFI_END_OSF_FRAME entArith
 CFI_START_OSF_FRAME entMM
 	SAVE_ALL
 /* save $9 - $15 so the inline exception code can manipulate them.  */
-	subq	$sp, 56, $sp
-	.cfi_adjust_cfa_offset	56
+	subq	$sp, 64, $sp
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -215,7 +211,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_rel_offset	$13, 32
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 /* handle the fault */
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
@@ -228,7 +224,7 @@ CFI_START_OSF_FRAME entMM
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	addq	$sp, 56, $sp
+	addq	$sp, 64, $sp
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -236,7 +232,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 /* finish up the syscall as normal.  */
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entMM
@@ -383,8 +379,8 @@ entUnaUser:
 	.cfi_restore	$0
 	.cfi_adjust_cfa_offset	-256
 	SAVE_ALL		/* setup normal kernel stack */
-	lda	$sp, -56($sp)
-	.cfi_adjust_cfa_offset	56
+	lda	$sp, -64($sp)
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -400,7 +396,7 @@ entUnaUser:
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
 	lda	$8, 0x3fff
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 	bic	$sp, $8, $8
 	jsr	$26, do_entUnaUser
 	ldq	$9, 0($sp)
@@ -410,7 +406,7 @@ entUnaUser:
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	lda	$sp, 56($sp)
+	lda	$sp, 64($sp)
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -418,7 +414,7 @@ entUnaUser:
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entUna
 
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 1a0a98cfdae7..f9b3f1695ae1 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -709,7 +709,7 @@ s_reg_to_mem (unsigned long s_reg)
 static int unauser_reg_offsets[32] = {
 	R(r0), R(r1), R(r2), R(r3), R(r4), R(r5), R(r6), R(r7), R(r8),
 	/* r9 ... r15 are stored in front of regs.  */
-	-56, -48, -40, -32, -24, -16, -8,
+	-64, -56, -48, -40, -32, -24, -16,	/* padding at -8 */
 	R(r16), R(r17), R(r18),
 	R(r19), R(r20), R(r21), R(r22), R(r23), R(r24), R(r25), R(r26),
 	R(r27), R(r28), R(gp),
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index a86286d2d3f3..13532d244166 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -77,8 +77,8 @@ __load_new_mm_context(struct mm_struct *next_mm)
 
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
-	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+10 : (r)-10])
+	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-17 :	\
+				 (r) <= 18 ? (r)+11 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a79f0b6c3429..2f9154c13ea8 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -320,7 +320,7 @@
 		clock-names = "spi", "wrap";
 	};
 
-	cir: cir@10013000 {
+	cir: ir-receiver@10013000 {
 		compatible = "mediatek,mt7623-cir";
 		reg = <0 0x10013000 0 0x1000>;
 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 2b66afcf026e..1158bee050e1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -303,11 +303,10 @@
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
@@ -316,7 +315,6 @@
 			};
 
 			mt6397_vpca7_reg: buck_vpca7 {
-				regulator-compatible = "buck_vpca7";
 				regulator-name = "vpca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -325,7 +323,6 @@
 			};
 
 			mt6397_vsramca15_reg: buck_vsramca15 {
-				regulator-compatible = "buck_vsramca15";
 				regulator-name = "vsramca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -334,7 +331,6 @@
 			};
 
 			mt6397_vsramca7_reg: buck_vsramca7 {
-				regulator-compatible = "buck_vsramca7";
 				regulator-name = "vsramca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -343,7 +339,6 @@
 			};
 
 			mt6397_vcore_reg: buck_vcore {
-				regulator-compatible = "buck_vcore";
 				regulator-name = "vcore";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -352,7 +347,6 @@
 			};
 
 			mt6397_vgpu_reg: buck_vgpu {
-				regulator-compatible = "buck_vgpu";
 				regulator-name = "vgpu";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -361,7 +355,6 @@
 			};
 
 			mt6397_vdrm_reg: buck_vdrm {
-				regulator-compatible = "buck_vdrm";
 				regulator-name = "vdrm";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1400000>;
@@ -370,7 +363,6 @@
 			};
 
 			mt6397_vio18_reg: buck_vio18 {
-				regulator-compatible = "buck_vio18";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1620000>;
 				regulator-max-microvolt = <1980000>;
@@ -379,19 +371,16 @@
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
@@ -399,18 +388,15 @@
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
@@ -418,7 +404,6 @@
 			};
 
 			mt6397_vmch_reg: ldo_vmch {
-				regulator-compatible = "ldo_vmch";
 				regulator-name = "vmch";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -426,7 +411,6 @@
 			};
 
 			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-				regulator-compatible = "ldo_vemc3v3";
 				regulator-name = "vemc_3v3";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -434,7 +418,6 @@
 			};
 
 			mt6397_vgp1_reg: ldo_vgp1 {
-				regulator-compatible = "ldo_vgp1";
 				regulator-name = "vcamd";
 				regulator-min-microvolt = <1220000>;
 				regulator-max-microvolt = <3300000>;
@@ -442,7 +425,6 @@
 			};
 
 			mt6397_vgp2_reg: ldo_vgp2 {
-				regulator-compatible = "ldo_vgp2";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <3300000>;
@@ -450,7 +432,6 @@
 			};
 
 			mt6397_vgp3_reg: ldo_vgp3 {
-				regulator-compatible = "ldo_vgp3";
 				regulator-name = "vcamaf";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -458,7 +439,6 @@
 			};
 
 			mt6397_vgp4_reg: ldo_vgp4 {
-				regulator-compatible = "ldo_vgp4";
 				regulator-name = "vgp4";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -466,7 +446,6 @@
 			};
 
 			mt6397_vgp5_reg: ldo_vgp5 {
-				regulator-compatible = "ldo_vgp5";
 				regulator-name = "vgp5";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3000000>;
@@ -474,7 +453,6 @@
 			};
 
 			mt6397_vgp6_reg: ldo_vgp6 {
-				regulator-compatible = "ldo_vgp6";
 				regulator-name = "vgp6";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -482,7 +460,6 @@
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-				regulator-compatible = "ldo_vibr";
 				regulator-name = "vibr";
 				regulator-min-microvolt = <1300000>;
 				regulator-max-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index a5aef31ada30..5f8538fb14a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -176,7 +176,7 @@
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x23>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 97c42be71338..1510f457b615 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -87,16 +87,18 @@ int populate_cache_leaves(unsigned int cpu)
 	unsigned int level, idx;
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *infos = this_cpu_ci->info_list;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+	     idx < this_cpu_ci->num_leaves; level++) {
 		type = get_cache_type(level);
 		if (type == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			if (idx + 1 >= this_cpu_ci->num_leaves)
+				break;
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_DATA, level);
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_INST, level);
 		} else {
-			ci_leaf_init(this_leaf++, type, level);
+			ci_leaf_init(&infos[idx++], type, level);
 		}
 	}
 	return 0;
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 92b8a02e588a..9c5f07749933 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -56,7 +56,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
-	__typeof__(*(ptr)) __oldval = 0;			\
+	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index f69eae3f32bd..ec98052b148d 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -202,8 +202,10 @@ int die(const char *str, struct pt_regs *regs, long err)
 	printk(KERN_EMERG "Oops: %s[#%d]:\n", str, ++die.counter);
 
 	if (notify_die(DIE_OOPS, str, regs, err, pt_cause(regs), SIGSEGV) ==
-	    NOTIFY_STOP)
+	    NOTIFY_STOP) {
+		spin_unlock_irq(&die.lock);
 		return 1;
+	}
 
 	print_modules();
 	show_regs(regs);
diff --git a/arch/m68k/include/asm/vga.h b/arch/m68k/include/asm/vga.h
index 4742e6bc3ab8..cdd414fa8710 100644
--- a/arch/m68k/include/asm/vga.h
+++ b/arch/m68k/include/asm/vga.h
@@ -9,7 +9,7 @@
  */
 #ifndef CONFIG_PCI
 
-#include <asm/raw_io.h>
+#include <asm/io.h>
 #include <asm/kmap.h>
 
 /*
@@ -29,9 +29,9 @@
 #define inw_p(port)		0
 #define outb_p(port, val)	do { } while (0)
 #define outw(port, val)		do { } while (0)
-#define readb			raw_inb
-#define writeb			raw_outb
-#define writew			raw_outw
+#define readb			__raw_readb
+#define writeb			__raw_writeb
+#define writew			__raw_writew
 
 #endif /* CONFIG_PCI */
 #endif /* _ASM_M68K_VGA_H */
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 2625232bfe52..df7b9febc960 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -264,7 +264,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 #define S_R_SP	(0xafb0 << 16)	/* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
 
-unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
+static unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
 		old_parent_ra, unsigned long parent_ra_addr, unsigned long fp)
 {
 	unsigned long sp, ip, tmp;
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 80c953414882..864743b46f45 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -83,6 +83,34 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
 }
 #endif
 
+/*
+ * With 4K page size the real_pte machinery is all nops.
+ */
+static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep, int offset)
+{
+	return (real_pte_t){pte};
+}
+
+#define __rpte_to_pte(r)	((r).pte)
+
+static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
+{
+	return pte_val(__rpte_to_pte(rpte)) >> H_PAGE_F_GIX_SHIFT;
+}
+
+#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
+	do {							         \
+		index = 0;					         \
+		shift = mmu_psize_defs[psize].shift;		         \
+
+#define pte_iterate_hashed_end() } while(0)
+
+/*
+ * We expect this to be called only for user addresses or kernel virtual
+ * addresses other than the linear mapping.
+ */
+#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
+
 /*
  * 4K PTE format is different from 64K PTE format. Saving the hash_slot is just
  * a matter of returning the PTE bits that need to be modified. On 64K PTE,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e1eb8aa9cfbb..712bba181359 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -324,32 +324,6 @@ extern unsigned long pci_io_base;
 
 #ifndef __ASSEMBLY__
 
-/*
- * This is the default implementation of various PTE accessors, it's
- * used in all cases except Book3S with 64K pages where we have a
- * concept of sub-pages
- */
-#ifndef __real_pte
-
-#define __real_pte(e, p, o)		((real_pte_t){(e)})
-#define __rpte_to_pte(r)	((r).pte)
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> H_PAGE_F_GIX_SHIFT)
-
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
-
-#define pte_iterate_hashed_end() } while(0)
-
-/*
- * We expect this to be called only for user addresses or kernel virtual
- * addresses other than the linear mapping.
- */
-#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
-
-#endif /* __real_pte */
-
 static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep, unsigned long clr,
 				       unsigned long set, int huge)
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index a05f289e613e..f1eab35bab60 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -45,7 +45,7 @@ static int text_area_cpu_up(unsigned int cpu)
 {
 	struct vm_struct *area;
 
-	area = get_vm_area(PAGE_SIZE, VM_ALLOC);
+	area = get_vm_area(PAGE_SIZE, 0);
 	if (!area) {
 		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
 			cpu);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 893ba3f562c4..7bb5b12ce92c 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -472,8 +472,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
 
 	switch(rets[0]) {
 	case 0:
-		result = EEH_STATE_MMIO_ACTIVE |
-			 EEH_STATE_DMA_ACTIVE;
+		result = EEH_STATE_MMIO_ACTIVE	|
+			 EEH_STATE_DMA_ACTIVE	|
+			 EEH_STATE_MMIO_ENABLED	|
+			 EEH_STATE_DMA_ENABLED;
 		break;
 	case 1:
 		result = EEH_STATE_RESET_ACTIVE |
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index 7837c791f7e8..aad7fc57e306 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -46,7 +46,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		break;
 	case FUTEX_OP_ANDN:
 		__futex_atomic_op("lr %2,%1\nnr %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
+				  ret, oldval, newval, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
 		__futex_atomic_op("lr %2,%1\nxr %2,%5\n",
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 596b2a2cd837..283d799f3ca7 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1228,8 +1228,14 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
 	rcu_read_unlock();
 	if (page) {
-		if (page_ref_inc_return(page) == 2)
-			return page_to_virt(page);
+		if (page_ref_inc_return(page) == 2) {
+			if (page->index == addr)
+				return page_to_virt(page);
+			/*
+			 * We raced with someone reusing + putting this vsie
+			 * page before we grabbed it.
+			 */
+		}
 		page_ref_dec(page);
 	}
 
@@ -1259,15 +1265,20 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			kvm->arch.vsie.next++;
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		if (page->index != ULONG_MAX)
+			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+					  page->index >> 9);
 	}
-	page->index = addr;
-	/* double use of the same address */
+	/* Mark it as invalid until it resides in the tree. */
+	page->index = ULONG_MAX;
+
+	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
 		page_ref_dec(page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
 	}
+	page->index = addr;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	vsie_page = page_to_virt(page);
@@ -1360,7 +1371,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		vsie_page = page_to_virt(page);
 		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		if (page->index != ULONG_MAX)
+			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+					  page->index >> 9);
 		__free_page(page);
 	}
 	kvm->arch.vsie.page_count = 0;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index e3b5de7b9598..ead78f981345 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -538,6 +538,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index cae566567e15..89b5e0202ec1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -795,7 +795,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 1d9b8aaea06c..c062d3e90eca 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -152,8 +152,8 @@ static void geode_configure(void)
 	u8 ccr3;
 	local_irq_save(flags);
 
-	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+	/* Suspend on halt power saving */
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0418606ec3c0..8806cce4d12f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -795,26 +795,37 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K	0x01
-#define TLB_INST_4M	0x02
-#define TLB_INST_2M_4M	0x03
+#define TLB_INST_4K		0x01
+#define TLB_INST_4M		0x02
+#define TLB_INST_2M_4M		0x03
 
-#define TLB_INST_ALL	0x05
-#define TLB_INST_1G	0x06
+#define TLB_INST_ALL		0x05
+#define TLB_INST_1G		0x06
 
-#define TLB_DATA_4K	0x11
-#define TLB_DATA_4M	0x12
-#define TLB_DATA_2M_4M	0x13
-#define TLB_DATA_4K_4M	0x14
+#define TLB_DATA_4K		0x11
+#define TLB_DATA_4M		0x12
+#define TLB_DATA_2M_4M		0x13
+#define TLB_DATA_4K_4M		0x14
 
-#define TLB_DATA_1G	0x16
+#define TLB_DATA_1G		0x16
+#define TLB_DATA_1G_2M_4M	0x17
 
-#define TLB_DATA0_4K	0x21
-#define TLB_DATA0_4M	0x22
-#define TLB_DATA0_2M_4M	0x23
+#define TLB_DATA0_4K		0x21
+#define TLB_DATA0_4M		0x22
+#define TLB_DATA0_2M_4M		0x23
 
-#define STLB_4K		0x41
-#define STLB_4K_2M	0x42
+#define STLB_4K			0x41
+#define STLB_4K_2M		0x42
+
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of
+ * entries for their respective TLB types.  The 0x63 descriptor is an
+ * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
+ * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
+ * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
+ * intel_tlb_table[] mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES	32
 
 static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
@@ -836,7 +847,8 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
+						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
 	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
 	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
 	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
@@ -936,6 +948,12 @@ static void intel_tlb_lookup(const unsigned char desc)
 		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
 		break;
+	case TLB_DATA_1G_2M_4M:
+		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		fallthrough;
 	case TLB_DATA_1G:
 		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
@@ -959,7 +977,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 3 ; j++)
+		for (j = 0 ; j < 4 ; j++)
 			if (regs[j] & (1 << 31))
 				regs[j] = 0;
 
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 2b7999a1a50a..80e262bb627f 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
 
+#include <asm/hypervisor.h>
 #include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
@@ -39,9 +40,15 @@ static bool __init use_pit(void)
 
 bool __init pit_timer_init(void)
 {
-	if (!use_pit())
+	if (!use_pit()) {
+		/*
+		 * Don't just ignore the PIT. Ensure it's stopped, because
+		 * VMMs otherwise steal CPU time just to pointlessly waggle
+		 * the (masked) IRQ.
+		 */
+		clockevent_i8253_disable();
 		return false;
-
+	}
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
 	return true;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 086b274fa60f..b3bed9a9f78d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -211,33 +211,39 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
+#define INTEL_MATCH(_model, ucode) { .vendor  = X86_VENDOR_INTEL,	\
+				     .family  = 6,			\
+				     .model = _model,			\
+				     .driver_data = ucode,		\
+				   }
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N,	0x11),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index c8dbee62ec2a..d61e40466d78 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -106,6 +106,51 @@ static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
  */
 static DEFINE_SPINLOCK(xen_reservation_lock);
 
+/* Protected by xen_reservation_lock. */
+#define MIN_CONTIG_ORDER 9 /* 2MB */
+static unsigned int discontig_frames_order = MIN_CONTIG_ORDER;
+static unsigned long discontig_frames_early[1UL << MIN_CONTIG_ORDER] __initdata;
+static unsigned long *discontig_frames __refdata = discontig_frames_early;
+static bool discontig_frames_dyn;
+
+static int alloc_discontig_frames(unsigned int order)
+{
+	unsigned long *new_array, *old_array;
+	unsigned int old_order;
+	unsigned long flags;
+
+	BUG_ON(order < MIN_CONTIG_ORDER);
+	BUILD_BUG_ON(sizeof(discontig_frames_early) != PAGE_SIZE);
+
+	new_array = (unsigned long *)__get_free_pages(GFP_KERNEL,
+						      order - MIN_CONTIG_ORDER);
+	if (!new_array)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&xen_reservation_lock, flags);
+
+	old_order = discontig_frames_order;
+
+	if (order > discontig_frames_order || !discontig_frames_dyn) {
+		if (!discontig_frames_dyn)
+			old_array = NULL;
+		else
+			old_array = discontig_frames;
+
+		discontig_frames = new_array;
+		discontig_frames_order = order;
+		discontig_frames_dyn = true;
+	} else {
+		old_array = new_array;
+	}
+
+	spin_unlock_irqrestore(&xen_reservation_lock, flags);
+
+	free_pages((unsigned long)old_array, old_order - MIN_CONTIG_ORDER);
+
+	return 0;
+}
+
 /*
  * Note about cr3 (pagetable base) values:
  *
@@ -842,6 +887,7 @@ void xen_mm_pin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -852,6 +898,7 @@ void xen_mm_pin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static int __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
@@ -874,6 +921,9 @@ static void __init xen_after_bootmem(void)
 	SetPagePinned(virt_to_page(level3_user_vsyscall));
 #endif
 	xen_pgd_walk(&init_mm, xen_mark_pinned, FIXADDR_TOP);
+
+	if (alloc_discontig_frames(MIN_CONTIG_ORDER))
+		BUG();
 }
 
 static int xen_unpin_page(struct mm_struct *mm, struct page *page,
@@ -961,6 +1011,7 @@ void xen_mm_unpin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -972,6 +1023,7 @@ void xen_mm_unpin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
@@ -2467,10 +2519,6 @@ void __init xen_init_mmu_ops(void)
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
 
-/* Protected by xen_reservation_lock. */
-#define MAX_CONTIG_ORDER 9 /* 2MB */
-static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
-
 #define VOID_PTE (mfn_pte(0, __pgprot(0)))
 static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
 				unsigned long *in_frames,
@@ -2587,24 +2635,25 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				 unsigned int address_bits,
 				 dma_addr_t *dma_handle)
 {
-	unsigned long *in_frames = discontig_frames, out_frame;
+	unsigned long *in_frames, out_frame;
 	unsigned long  flags;
 	int            success;
 	unsigned long vstart = (unsigned long)phys_to_virt(pstart);
 
-	/*
-	 * Currently an auto-translated guest will not perform I/O, nor will
-	 * it require PAE page directories below 4GB. Therefore any calls to
-	 * this function are redundant and can be ignored.
-	 */
+	if (unlikely(order > discontig_frames_order)) {
+		if (!discontig_frames_dyn)
+			return -ENOMEM;
 
-	if (unlikely(order > MAX_CONTIG_ORDER))
-		return -ENOMEM;
+		if (alloc_discontig_frames(order))
+			return -ENOMEM;
+	}
 
 	memset((void *) vstart, 0, PAGE_SIZE << order);
 
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
+	in_frames = discontig_frames;
+
 	/* 1. Zap current PTEs, remembering MFNs. */
 	xen_zap_pfn_range(vstart, order, in_frames, NULL);
 
@@ -2628,12 +2677,12 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 {
-	unsigned long *out_frames = discontig_frames, in_frame;
+	unsigned long *out_frames, in_frame;
 	unsigned long  flags;
 	int success;
 	unsigned long vstart;
 
-	if (unlikely(order > MAX_CONTIG_ORDER))
+	if (unlikely(order > discontig_frames_order))
 		return;
 
 	vstart = (unsigned long)phys_to_virt(pstart);
@@ -2641,6 +2690,8 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
+	out_frames = discontig_frames;
+
 	/* 1. Find start MFN of contiguous extent. */
 	in_frame = virt_to_mfn(vstart);
 
diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index 1ca63e97bccc..05705ead955e 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b6095335636c..ca619d852757 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -51,13 +51,25 @@ int mac_partition(struct parsed_partitions *state)
 	}
 	secsize = be16_to_cpu(md->block_size);
 	put_dev_sector(sect);
+
+	/*
+	 * If the "block size" is not a power of 2, things get weird - we might
+	 * end up with a partition straddling a sector boundary, so we wouldn't
+	 * be able to read a partition entry with read_part_sector().
+	 * Real block sizes are probably (?) powers of two, so just require
+	 * that.
+	 */
+	if (!is_power_of_2(secsize))
+		return -1;
 	datasize = round_down(secsize, 512);
 	data = read_part_sector(state, datasize / 512, &sect);
 	if (!data)
 		return -1;
 	partoffset = secsize % 512;
-	if (partoffset + sizeof(*part) > datasize)
+	if (partoffset + sizeof(*part) > datasize) {
+		put_dev_sector(sect);
 		return -1;
+	}
 	part = (struct mac_partition *) (data + partoffset);
 	if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC) {
 		put_dev_sector(sect);
@@ -110,8 +122,8 @@ int mac_partition(struct parsed_partitions *state)
 				int i, l;
 
 				goodness++;
-				l = strlen(part->name);
-				if (strcmp(part->name, "/") == 0)
+				l = strnlen(part->name, sizeof(part->name));
+				if (strncmp(part->name, "/", sizeof(part->name)) == 0)
 					goodness++;
 				for (i = 0; i <= l - 4; ++i) {
 					if (strncasecmp(part->name + i, "root",
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index ef7d21f39d4a..601cbee29cca 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -177,8 +177,8 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	{
 #ifndef CONFIG_CRYPTO_FIPS
 	.key =
-	"\x30\x81\x9A" /* sequence of 154 bytes */
-	"\x02\x01\x01" /* version - integer of 1 byte */
+	"\x30\x82\x01\x38" /* sequence of 312 bytes */
+	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x41" /* modulus - integer of 65 bytes */
 	"\x00\xAA\x36\xAB\xCE\x88\xAC\xFD\xFF\x55\x52\x3C\x7F\xC4\x52\x3F"
 	"\x90\xEF\xA0\x0D\xF3\x77\x4A\x25\x9F\x2E\x62\xB4\xC5\xD9\x9C\xB5"
@@ -191,24 +191,37 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\xC2\xCD\x2D\xFF\x43\x40\x98\xCD\x20\xD8\xA1\x38\xD0\x90\xBF\x64"
 	"\x79\x7C\x3F\xA7\xA2\xCD\xCB\x3C\xD1\xE0\xBD\xBA\x26\x54\xB4\xF9"
 	"\xDF\x8E\x8A\xE5\x9D\x73\x3D\x9F\x33\xB3\x01\x62\x4A\xFD\x1D\x51"
-	"\x02\x01\x00" /* prime1 - integer of 1 byte */
-	"\x02\x01\x00" /* prime2 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
-	"\x02\x01\x00", /* coefficient - integer of 1 byte */
+	"\x02\x21" /* prime1 - integer of 33 bytes */
+	"\x00\xD8\x40\xB4\x16\x66\xB4\x2E\x92\xEA\x0D\xA3\xB4\x32\x04\xB5"
+	"\xCF\xCE\x33\x52\x52\x4D\x04\x16\xA5\xA4\x41\xE7\x00\xAF\x46\x12"
+	"\x0D"
+	"\x02\x21" /* prime2 - integer of 33 bytes */
+	"\x00\xC9\x7F\xB1\xF0\x27\xF4\x53\xF6\x34\x12\x33\xEA\xAA\xD1\xD9"
+	"\x35\x3F\x6C\x42\xD0\x88\x66\xB1\xD0\x5A\x0F\x20\x35\x02\x8B\x9D"
+	"\x89"
+	"\x02\x20" /* exponent1 - integer of 32 bytes */
+	"\x59\x0B\x95\x72\xA2\xC2\xA9\xC4\x06\x05\x9D\xC2\xAB\x2F\x1D\xAF"
+	"\xEB\x7E\x8B\x4F\x10\xA7\x54\x9E\x8E\xED\xF5\xB4\xFC\xE0\x9E\x05"
+	"\x02\x21" /* exponent2 - integer of 33 bytes */
+	"\x00\x8E\x3C\x05\x21\xFE\x15\xE0\xEA\x06\xA3\x6F\xF0\xF1\x0C\x99"
+	"\x52\xC3\x5B\x7A\x75\x14\xFD\x32\x38\xB8\x0A\xAD\x52\x98\x62\x8D"
+	"\x51"
+	"\x02\x20" /* coefficient - integer of 32 bytes */
+	"\x36\x3F\xF7\x18\x9D\xA8\xE9\x0B\x1D\x34\x1F\x71\xD0\x9B\x76\xA8"
+	"\xA9\x43\xE1\x1D\x10\xB2\x4D\x24\x9F\x2D\xEA\xFE\xF8\x0C\x18\x26",
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\x63\x1c\xcd\x7b\xe1\x7e\xe4\xde\xc9\xa8\x89\xa1\x74\xcb\x3c\x63"
 	"\x7d\x24\xec\x83\xc3\x15\xe4\x7f\x73\x05\x34\xd1\xec\x22\xbb\x8a"
 	"\x5e\x32\x39\x6d\xc1\x1d\x7d\x50\x3b\x9f\x7a\xad\xf0\x2e\x25\x53"
 	"\x9f\x6e\xbd\x4c\x55\x84\x0c\x9b\xcf\x1a\x4b\x51\x1e\x9e\x0c\x06",
-	.key_len = 157,
+	.key_len = 316,
 	.m_size = 8,
 	.c_size = 64,
 	}, {
 	.key =
-	"\x30\x82\x01\x1D" /* sequence of 285 bytes */
-	"\x02\x01\x01" /* version - integer of 1 byte */
+	"\x30\x82\x02\x5B" /* sequence of 603 bytes */
+	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x81\x81" /* modulus - integer of 129 bytes */
 	"\x00\xBB\xF8\x2F\x09\x06\x82\xCE\x9C\x23\x38\xAC\x2B\x9D\xA8\x71"
 	"\xF7\x36\x8D\x07\xEE\xD4\x10\x43\xA4\x40\xD6\xB6\xF0\x74\x54\xF5"
@@ -230,12 +243,35 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\x93\x99\x26\xED\x4F\x74\xA1\x3E\xDD\xFB\xE1\xA1\xCE\xCC\x48\x94"
 	"\xAF\x94\x28\xC2\xB7\xB8\x88\x3F\xE4\x46\x3A\x4B\xC8\x5B\x1C\xB3"
 	"\xC1"
-	"\x02\x01\x00" /* prime1 - integer of 1 byte */
-	"\x02\x01\x00" /* prime2 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
-	"\x02\x01\x00", /* coefficient - integer of 1 byte */
-	.key_len = 289,
+	"\x02\x41" /* prime1 - integer of 65 bytes */
+	"\x00\xEE\xCF\xAE\x81\xB1\xB9\xB3\xC9\x08\x81\x0B\x10\xA1\xB5\x60"
+	"\x01\x99\xEB\x9F\x44\xAE\xF4\xFD\xA4\x93\xB8\x1A\x9E\x3D\x84\xF6"
+	"\x32\x12\x4E\xF0\x23\x6E\x5D\x1E\x3B\x7E\x28\xFA\xE7\xAA\x04\x0A"
+	"\x2D\x5B\x25\x21\x76\x45\x9D\x1F\x39\x75\x41\xBA\x2A\x58\xFB\x65"
+	"\x99"
+	"\x02\x41" /* prime2 - integer of 65 bytes */
+	"\x00\xC9\x7F\xB1\xF0\x27\xF4\x53\xF6\x34\x12\x33\xEA\xAA\xD1\xD9"
+	"\x35\x3F\x6C\x42\xD0\x88\x66\xB1\xD0\x5A\x0F\x20\x35\x02\x8B\x9D"
+	"\x86\x98\x40\xB4\x16\x66\xB4\x2E\x92\xEA\x0D\xA3\xB4\x32\x04\xB5"
+	"\xCF\xCE\x33\x52\x52\x4D\x04\x16\xA5\xA4\x41\xE7\x00\xAF\x46\x15"
+	"\x03"
+	"\x02\x40" /* exponent1 - integer of 64 bytes */
+	"\x54\x49\x4C\xA6\x3E\xBA\x03\x37\xE4\xE2\x40\x23\xFC\xD6\x9A\x5A"
+	"\xEB\x07\xDD\xDC\x01\x83\xA4\xD0\xAC\x9B\x54\xB0\x51\xF2\xB1\x3E"
+	"\xD9\x49\x09\x75\xEA\xB7\x74\x14\xFF\x59\xC1\xF7\x69\x2E\x9A\x2E"
+	"\x20\x2B\x38\xFC\x91\x0A\x47\x41\x74\xAD\xC9\x3C\x1F\x67\xC9\x81"
+	"\x02\x40" /* exponent2 - integer of 64 bytes */
+	"\x47\x1E\x02\x90\xFF\x0A\xF0\x75\x03\x51\xB7\xF8\x78\x86\x4C\xA9"
+	"\x61\xAD\xBD\x3A\x8A\x7E\x99\x1C\x5C\x05\x56\xA9\x4C\x31\x46\xA7"
+	"\xF9\x80\x3F\x8F\x6F\x8A\xE3\x42\xE9\x31\xFD\x8A\xE4\x7A\x22\x0D"
+	"\x1B\x99\xA4\x95\x84\x98\x07\xFE\x39\xF9\x24\x5A\x98\x36\xDA\x3D"
+	"\x02\x41" /* coefficient - integer of 65 bytes */
+	"\x00\xB0\x6C\x4F\xDA\xBB\x63\x01\x19\x8D\x26\x5B\xDB\xAE\x94\x23"
+	"\xB3\x80\xF2\x71\xF7\x34\x53\x88\x50\x93\x07\x7F\xCD\x39\xE2\x11"
+	"\x9F\xC9\x86\x32\x15\x4F\x58\x83\xB1\x67\xA9\x67\xBF\x40\x2B\x4E"
+	"\x9E\x2E\x0F\x96\x56\xE6\x98\xEA\x36\x66\xED\xFB\x25\x79\x80\x39"
+	"\xF7",
+	.key_len = 607,
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\x74\x1b\x55\xac\x47\xb5\x08\x0a\x6e\x2b\x2d\xf7\x94\xb8\x8a\x95"
@@ -251,9 +287,9 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	}, {
 #endif
 	.key =
-	"\x30\x82\x02\x1F" /* sequence of 543 bytes */
-	"\x02\x01\x01" /* version - integer of 1 byte */
-	"\x02\x82\x01\x00" /* modulus - integer of 256 bytes */
+	"\x30\x82\x04\xA3" /* sequence of 1187 bytes */
+	"\x02\x01\x00" /* version - integer of 1 byte */
+	"\x02\x82\x01\x01\x00" /* modulus - integer of 256 bytes */
 	"\xDB\x10\x1A\xC2\xA3\xF1\xDC\xFF\x13\x6B\xED\x44\xDF\xF0\x02\x6D"
 	"\x13\xC7\x88\xDA\x70\x6B\x54\xF1\xE8\x27\xDC\xC3\x0F\x99\x6A\xFA"
 	"\xC6\x67\xFF\x1D\x1E\x3C\x1D\xC1\xB5\x5F\x6C\xC0\xB2\x07\x3A\x6D"
@@ -288,12 +324,55 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\x62\xFF\xE9\x46\xB8\xD8\x44\xDB\xA5\xCC\x31\x54\x34\xCE\x3E\x82"
 	"\xD6\xBF\x7A\x0B\x64\x21\x6D\x88\x7E\x5B\x45\x12\x1E\x63\x8D\x49"
 	"\xA7\x1D\xD9\x1E\x06\xCD\xE8\xBA\x2C\x8C\x69\x32\xEA\xBE\x60\x71"
-	"\x02\x01\x00" /* prime1 - integer of 1 byte */
-	"\x02\x01\x00" /* prime2 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
-	"\x02\x01\x00", /* coefficient - integer of 1 byte */
-	.key_len = 547,
+	"\x02\x81\x81" /* prime1 - integer of 129 bytes */
+	"\x00\xFA\xAC\xE1\x37\x5E\x32\x11\x34\xC6\x72\x58\x2D\x91\x06\x3E"
+	"\x77\xE7\x11\x21\xCD\x4A\xF8\xA4\x3F\x0F\xEF\x31\xE3\xF3\x55\xA0"
+	"\xB9\xAC\xB6\xCB\xBB\x41\xD0\x32\x81\x9A\x8F\x7A\x99\x30\x77\x6C"
+	"\x68\x27\xE2\x96\xB5\x72\xC9\xC3\xD4\x42\xAA\xAA\xCA\x95\x8F\xFF"
+	"\xC9\x9B\x52\x34\x30\x1D\xCF\xFE\xCF\x3C\x56\x68\x6E\xEF\xE7\x6C"
+	"\xD7\xFB\x99\xF5\x4A\xA5\x21\x1F\x2B\xEA\x93\xE8\x98\x26\xC4\x6E"
+	"\x42\x21\x5E\xA0\xA1\x2A\x58\x35\xBB\x10\xE7\xBA\x27\x0A\x3B\xB3"
+	"\xAF\xE2\x75\x36\x04\xAC\x56\xA0\xAB\x52\xDE\xCE\xDD\x2C\x28\x77"
+	"\x03"
+	"\x02\x81\x81" /* prime2 - integer of 129 bytes */
+	"\x00\xDF\xB7\x52\xB6\xD7\xC0\xE2\x96\xE7\xC9\xFE\x5D\x71\x5A\xC4"
+	"\x40\x96\x2F\xE5\x87\xEA\xF3\xA5\x77\x11\x67\x3C\x8D\x56\x08\xA7"
+	"\xB5\x67\xFA\x37\xA8\xB8\xCF\x61\xE8\x63\xD8\x38\x06\x21\x2B\x92"
+	"\x09\xA6\x39\x3A\xEA\xA8\xB4\x45\x4B\x36\x10\x4C\xE4\x00\x66\x71"
+	"\x65\xF8\x0B\x94\x59\x4F\x8C\xFD\xD5\x34\xA2\xE7\x62\x84\x0A\xA7"
+	"\xBB\xDB\xD9\x8A\xCD\x05\xE1\xCC\x57\x7B\xF1\xF1\x1F\x11\x9D\xBA"
+	"\x3E\x45\x18\x99\x1B\x41\x64\x43\xEE\x97\x5D\x77\x13\x5B\x74\x69"
+	"\x73\x87\x95\x05\x07\xBE\x45\x07\x17\x7E\x4A\x69\x22\xF3\xDB\x05"
+	"\x39"
+	"\x02\x81\x80" /* exponent1 - integer of 128 bytes */
+	"\x5E\xD8\xDC\xDA\x53\x44\xC4\x67\xE0\x92\x51\x34\xE4\x83\xA5\x4D"
+	"\x3E\xDB\xA7\x9B\x82\xBB\x73\x81\xFC\xE8\x77\x4B\x15\xBE\x17\x73"
+	"\x49\x9B\x5C\x98\xBC\xBD\x26\xEF\x0C\xE9\x2E\xED\x19\x7E\x86\x41"
+	"\x1E\x9E\x48\x81\xDD\x2D\xE4\x6F\xC2\xCD\xCA\x93\x9E\x65\x7E\xD5"
+	"\xEC\x73\xFD\x15\x1B\xA2\xA0\x7A\x0F\x0D\x6E\xB4\x53\x07\x90\x92"
+	"\x64\x3B\x8B\xA9\x33\xB3\xC5\x94\x9B\x4C\x5D\x9C\x7C\x46\xA4\xA5"
+	"\x56\xF4\xF3\xF8\x27\x0A\x7B\x42\x0D\x92\x70\x47\xE7\x42\x51\xA9"
+	"\xC2\x18\xB1\x58\xB1\x50\x91\xB8\x61\x41\xB6\xA9\xCE\xD4\x7C\xBB"
+	"\x02\x81\x80" /* exponent2 - integer of 128 bytes */
+	"\x54\x09\x1F\x0F\x03\xD8\xB6\xC5\x0C\xE8\xB9\x9E\x0C\x38\x96\x43"
+	"\xD4\xA6\xC5\x47\xDB\x20\x0E\xE5\xBD\x29\xD4\x7B\x1A\xF8\x41\x57"
+	"\x49\x69\x9A\x82\xCC\x79\x4A\x43\xEB\x4D\x8B\x2D\xF2\x43\xD5\xA5"
+	"\xBE\x44\xFD\x36\xAC\x8C\x9B\x02\xF7\x9A\x03\xE8\x19\xA6\x61\xAE"
+	"\x76\x10\x93\x77\x41\x04\xAB\x4C\xED\x6A\xCC\x14\x1B\x99\x8D\x0C"
+	"\x6A\x37\x3B\x86\x6C\x51\x37\x5B\x1D\x79\xF2\xA3\x43\x10\xC6\xA7"
+	"\x21\x79\x6D\xF9\xE9\x04\x6A\xE8\x32\xFF\xAE\xFD\x1C\x7B\x8C\x29"
+	"\x13\xA3\x0C\xB2\xAD\xEC\x6C\x0F\x8D\x27\x12\x7B\x48\xB2\xDB\x31"
+	"\x02\x81\x81" /* coefficient - integer of 129 bytes */
+	"\x00\x8D\x1B\x05\xCA\x24\x1F\x0C\x53\x19\x52\x74\x63\x21\xFA\x78"
+	"\x46\x79\xAF\x5C\xDE\x30\xA4\x6C\x20\x38\xE6\x97\x39\xB8\x7A\x70"
+	"\x0D\x8B\x6C\x6D\x13\x74\xD5\x1C\xDE\xA9\xF4\x60\x37\xFE\x68\x77"
+	"\x5E\x0B\x4E\x5E\x03\x31\x30\xDF\xD6\xAE\x85\xD0\x81\xBB\x61\xC7"
+	"\xB1\x04\x5A\xC4\x6D\x56\x1C\xD9\x64\xE7\x85\x7F\x88\x91\xC9\x60"
+	"\x28\x05\xE2\xC6\x24\x8F\xDD\x61\x64\xD8\x09\xDE\x7E\xD3\x4A\x61"
+	"\x1A\xD3\x73\x58\x4B\xD8\xA0\x54\x25\x48\x83\x6F\x82\x6C\xAF\x36"
+	"\x51\x2A\x5D\x14\x2F\x41\x25\x00\xDD\xF8\xF3\x95\xFE\x31\x25\x50"
+	"\x12",
+	.key_len = 1191,
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\xb2\x97\x76\xb4\xae\x3e\x38\x3c\x7e\x64\x1f\xcc\xa2\x7f\xf6\xbe"
@@ -720,7 +799,7 @@ static const struct akcipher_testvec ecrdsa_tv_template[] = {
 static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
 	{
 	.key =
-	"\x30\x82\x03\x1f\x02\x01\x00\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
+	"\x30\x82\x04\xa5\x02\x01\x00\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
 	"\x8c\x92\x31\xe7\x69\x02\xa2\xd5\x5c\x78\xde\xa2\x0c\x8f\xfe\x28"
 	"\x59\x31\xdf\x40\x9c\x60\x61\x06\xb9\x2f\x62\x40\x80\x76\xcb\x67"
 	"\x4a\xb5\x59\x56\x69\x17\x07\xfa\xf9\x4c\xbd\x6c\x37\x7a\x46\x7d"
@@ -736,42 +815,66 @@ static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
 	"\x9e\x49\x63\x6e\x02\xc1\xc9\x3a\x9b\xa5\x22\x1b\x07\x95\xd6\x10"
 	"\x02\x50\xfd\xfd\xd1\x9b\xbe\xab\xc2\xc0\x74\xd7\xec\x00\xfb\x11"
 	"\x71\xcb\x7a\xdc\x81\x79\x9f\x86\x68\x46\x63\x82\x4d\xb7\xf1\xe6"
-	"\x16\x6f\x42\x63\xf4\x94\xa0\xca\x33\xcc\x75\x13\x02\x82\x01\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x01"
-	"\x02\x82\x01\x00\x62\xb5\x60\x31\x4f\x3f\x66\x16\xc1\x60\xac\x47"
-	"\x2a\xff\x6b\x69\x00\x4a\xb2\x5c\xe1\x50\xb9\x18\x74\xa8\xe4\xdc"
-	"\xa8\xec\xcd\x30\xbb\xc1\xc6\xe3\xc6\xac\x20\x2a\x3e\x5e\x8b\x12"
-	"\xe6\x82\x08\x09\x38\x0b\xab\x7c\xb3\xcc\x9c\xce\x97\x67\xdd\xef"
-	"\x95\x40\x4e\x92\xe2\x44\xe9\x1d\xc1\x14\xfd\xa9\xb1\xdc\x71\x9c"
-	"\x46\x21\xbd\x58\x88\x6e\x22\x15\x56\xc1\xef\xe0\xc9\x8d\xe5\x80"
-	"\x3e\xda\x7e\x93\x0f\x52\xf6\xf5\xc1\x91\x90\x9e\x42\x49\x4f\x8d"
-	"\x9c\xba\x38\x83\xe9\x33\xc2\x50\x4f\xec\xc2\xf0\xa8\xb7\x6e\x28"
-	"\x25\x56\x6b\x62\x67\xfe\x08\xf1\x56\xe5\x6f\x0e\x99\xf1\xe5\x95"
-	"\x7b\xef\xeb\x0a\x2c\x92\x97\x57\x23\x33\x36\x07\xdd\xfb\xae\xf1"
-	"\xb1\xd8\x33\xb7\x96\x71\x42\x36\xc5\xa4\xa9\x19\x4b\x1b\x52\x4c"
-	"\x50\x69\x91\xf0\x0e\xfa\x80\x37\x4b\xb5\xd0\x2f\xb7\x44\x0d\xd4"
-	"\xf8\x39\x8d\xab\x71\x67\x59\x05\x88\x3d\xeb\x48\x48\x33\x88\x4e"
-	"\xfe\xf8\x27\x1b\xd6\x55\x60\x5e\x48\xb7\x6d\x9a\xa8\x37\xf9\x7a"
-	"\xde\x1b\xcd\x5d\x1a\x30\xd4\xe9\x9e\x5b\x3c\x15\xf8\x9c\x1f\xda"
-	"\xd1\x86\x48\x55\xce\x83\xee\x8e\x51\xc7\xde\x32\x12\x47\x7d\x46"
-	"\xb8\x35\xdf\x41\x02\x01\x00\x02\x01\x00\x02\x01\x00\x02\x01\x00"
-	"\x02\x01\x00",
-	.key_len = 804,
+	"\x16\x6f\x42\x63\xf4\x94\xa0\xca\x33\xcc\x75\x13\x02\x03\x01\x00"
+	"\x01\x02\x82\x01\x00\x62\xb5\x60\x31\x4f\x3f\x66\x16\xc1\x60\xac"
+	"\x47\x2a\xff\x6b\x69\x00\x4a\xb2\x5c\xe1\x50\xb9\x18\x74\xa8\xe4"
+	"\xdc\xa8\xec\xcd\x30\xbb\xc1\xc6\xe3\xc6\xac\x20\x2a\x3e\x5e\x8b"
+	"\x12\xe6\x82\x08\x09\x38\x0b\xab\x7c\xb3\xcc\x9c\xce\x97\x67\xdd"
+	"\xef\x95\x40\x4e\x92\xe2\x44\xe9\x1d\xc1\x14\xfd\xa9\xb1\xdc\x71"
+	"\x9c\x46\x21\xbd\x58\x88\x6e\x22\x15\x56\xc1\xef\xe0\xc9\x8d\xe5"
+	"\x80\x3e\xda\x7e\x93\x0f\x52\xf6\xf5\xc1\x91\x90\x9e\x42\x49\x4f"
+	"\x8d\x9c\xba\x38\x83\xe9\x33\xc2\x50\x4f\xec\xc2\xf0\xa8\xb7\x6e"
+	"\x28\x25\x56\x6b\x62\x67\xfe\x08\xf1\x56\xe5\x6f\x0e\x99\xf1\xe5"
+	"\x95\x7b\xef\xeb\x0a\x2c\x92\x97\x57\x23\x33\x36\x07\xdd\xfb\xae"
+	"\xf1\xb1\xd8\x33\xb7\x96\x71\x42\x36\xc5\xa4\xa9\x19\x4b\x1b\x52"
+	"\x4c\x50\x69\x91\xf0\x0e\xfa\x80\x37\x4b\xb5\xd0\x2f\xb7\x44\x0d"
+	"\xd4\xf8\x39\x8d\xab\x71\x67\x59\x05\x88\x3d\xeb\x48\x48\x33\x88"
+	"\x4e\xfe\xf8\x27\x1b\xd6\x55\x60\x5e\x48\xb7\x6d\x9a\xa8\x37\xf9"
+	"\x7a\xde\x1b\xcd\x5d\x1a\x30\xd4\xe9\x9e\x5b\x3c\x15\xf8\x9c\x1f"
+	"\xda\xd1\x86\x48\x55\xce\x83\xee\x8e\x51\xc7\xde\x32\x12\x47\x7d"
+	"\x46\xb8\x35\xdf\x41\x02\x81\x81\x00\xe4\x4c\xae\xde\x16\xfd\x9f"
+	"\x83\x55\x5b\x84\x4a\xcf\x1c\xf1\x37\x95\xad\xca\x29\x7f\x2d\x6e"
+	"\x32\x81\xa4\x2b\x26\x14\x96\x1d\x40\x05\xec\x0c\xaf\x3f\x2c\x6f"
+	"\x2c\xe8\xbf\x1d\xee\xd0\xb3\xef\x7c\x5b\x9e\x88\x4f\x2a\x8b\x0e"
+	"\x4a\xbd\xb7\x8c\xfa\x10\x0e\x3b\xda\x68\xad\x41\x2b\xe4\x96\xfa"
+	"\x7f\x80\x52\x5f\x07\x9f\x0e\x3b\x5e\x96\x45\x1a\x13\x2b\x94\xce"
+	"\x1f\x07\x69\x85\x35\xfc\x69\x63\x5b\xf8\xf8\x3f\xce\x9d\x40\x1e"
+	"\x7c\xad\xfb\x9e\xce\xe0\x01\xf8\xef\x59\x5d\xdc\x00\x79\xab\x8a"
+	"\x3f\x80\xa2\x76\x32\x94\xa9\xea\x65\x02\x81\x81\x00\xf1\x38\x60"
+	"\x90\x0d\x0c\x2e\x3d\x34\xe5\x90\xea\x21\x43\x1f\x68\x63\x16\x7b"
+	"\x25\x8d\xde\x82\x2b\x52\xf8\xa3\xfd\x0f\x39\xe7\xe9\x5e\x32\x75"
+	"\x15\x7d\xd0\xc9\xce\x06\xe5\xfb\xa9\xcb\x22\xe5\xdb\x49\x09\xf2"
+	"\xe6\xb7\xa5\xa7\x75\x2e\x91\x2d\x2b\x5d\xf1\x48\x61\x45\x43\xd7"
+	"\xbd\xfc\x11\x73\xb5\x11\x9f\xb2\x18\x3a\x6f\x36\xa7\xc2\xd3\x18"
+	"\x4d\xf0\xc5\x1f\x70\x8c\x9b\xc5\x1d\x95\xa8\x5a\x9e\x8c\xb1\x4b"
+	"\x6a\x2a\x84\x76\x2c\xd8\x4f\x47\xb0\x81\x84\x02\x45\xf0\x85\xf8"
+	"\x0c\x6d\xa7\x0c\x4d\x2c\xb2\x5b\x81\x70\xfd\x6e\x17\x02\x81\x81"
+	"\x00\x8d\x07\xc5\xfa\x92\x4f\x48\xcb\xd3\xdd\xfe\x02\x4c\xa1\x7f"
+	"\x6d\xab\xfc\x38\xe7\x9b\x95\xcf\xfe\x49\x51\xc6\x09\xf7\x2b\xa8"
+	"\x94\x15\x54\x75\x9d\x88\xb4\x05\x55\xc3\xcd\xd4\x4a\xe4\x08\x53"
+	"\xc8\x09\xbd\x0c\x4d\x83\x65\x75\x85\xbc\x5e\xf8\x2a\xbd\xe2\x5d"
+	"\x1d\x16\x0e\xf9\x34\x89\x38\xaf\x34\x36\x6c\x2c\x22\x44\x22\x81"
+	"\x90\x73\xd9\xea\x3a\xaf\x70\x74\x48\x7c\xc6\xb5\xb0\xdc\xe5\xa9"
+	"\xa8\x76\x4b\xbc\xf7\x00\xf3\x4c\x22\x0f\x44\x62\x1d\x40\x0a\x57"
+	"\xe2\x5b\xdd\x7c\x7b\x9a\xad\xda\x70\x52\x21\x8a\x4c\xc2\xc3\x98"
+	"\x75\x02\x81\x81\x00\xed\x24\x5c\xa2\x21\x81\xa1\x0f\xa1\x2a\x33"
+	"\x0e\x49\xc7\x00\x60\x92\x51\x6e\x9d\x9b\xdc\x6d\x22\x04\x7e\xd6"
+	"\x51\x19\x9f\xf6\xe3\x91\x2c\x8f\xb8\xa2\x29\x19\xcc\x47\x31\xdf"
+	"\xf8\xab\xf0\xd2\x02\x83\xca\x99\x16\xc2\xe2\xc3\x3f\x4b\x99\x83"
+	"\xcb\x87\x9e\x86\x66\xc2\x3e\x91\x21\x80\x66\xf3\xd6\xc5\xcd\xb6"
+	"\xbb\x64\xef\x22\xcf\x48\x94\x58\xe7\x7e\xd5\x7c\x34\x1c\xb7\xa2"
+	"\xd0\x93\xe9\x9f\xb5\x11\x61\xd7\x5f\x37\x0f\x64\x52\x70\x11\x78"
+	"\xcc\x08\x77\xeb\xf8\x30\x1e\xb4\x9e\x1b\x4a\xc7\xa8\x33\x51\xe0"
+	"\xed\xdf\x53\xf6\xdf\x02\x81\x81\x00\x86\xd9\x4c\xee\x65\x61\xc1"
+	"\x19\xa9\xd5\x74\x9b\xd5\xca\xf6\x83\x2b\x06\xb4\x20\xfe\x45\x29"
+	"\xe8\xe3\xfa\xe1\x4f\x28\x8e\x63\x2f\x74\xc3\x3a\x5c\x9a\xf5\x9e"
+	"\x0e\x0d\xc5\xfe\xa0\x4c\x00\xce\x7b\xa4\x19\x17\x59\xaf\x13\x3a"
+	"\x03\x8f\x54\xf5\x60\x39\x2e\xd9\x06\xb3\x7c\xd6\x90\x06\x41\x77"
+	"\xf3\x93\xe1\x7a\x01\x41\xc1\x8f\xfe\x4c\x88\x39\xdb\xde\x71\x9e"
+	"\x58\xd1\x49\x50\x80\xb2\x5a\x4f\x69\x8b\xb8\xfe\x63\xd4\x42\x3d"
+	"\x37\x61\xa8\x4c\xff\xb6\x99\x4c\xf4\x51\xe0\x44\xaa\x69\x79\x3f"
+	"\x81\xa4\x61\x3d\x26\xe9\x04\x52\x64",
+	.key_len = 1193,
 	/*
 	 * m is SHA256 hash of following message:
 	 * "\x49\x41\xbe\x0a\x0c\xc9\xf6\x35\x51\xe4\x27\x56\x13\x71\x4b\xd0"
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e0d82fab1f44..50bed5a70812 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -128,8 +128,6 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -707,14 +705,16 @@ static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
+	const char *msg = GHES_PFX "Fatal hardware error";
+
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
-	/* reboot to log the error! */
 	if (!panic_timeout)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
+		pr_emerg("%s but panic disabled\n", msg);
+
+	panic(msg);
 }
 
 static int ghes_proc(struct ghes *ghes)
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f970a40a2f7a..0b0969e64f5c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -873,6 +873,8 @@ int bus_register(struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&bus->p->subsys);
+	/* Above kset_unregister() will kfree @bus->p */
+	bus->p = NULL;
 out:
 	kfree(bus->p);
 	bus->p = NULL;
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 54cb9a02254f..94ba16c2f936 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -808,6 +808,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d);
@@ -854,6 +855,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
 	kfree(d);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f2d847ffcbc7..a3a0f09a4f47 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2039,6 +2039,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 		flush_workqueue(nbd->recv_workq);
 	nbd_clear_que(nbd);
 	nbd->task_setup = NULL;
+	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
 	mutex_unlock(&nbd->config_lock);
 
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 09e3e25562a8..f56b92880cda 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -309,6 +309,9 @@ static int ipmb_probe(struct i2c_client *client,
 	ipmb_dev->miscdev.name = devm_kasprintf(&client->dev, GFP_KERNEL,
 						"%s%d", "ipmb-",
 						client->adapter->nr);
+	if (!ipmb_dev->miscdev.name)
+		return -ENOMEM;
+
 	ipmb_dev->miscdev.fops = &ipmb_fops;
 	ipmb_dev->miscdev.parent = &client->dev;
 	ret = misc_register(&ipmb_dev->miscdev);
diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 776ead319ae9..9df572579afb 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -287,7 +287,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 			vco = vco_pre * f;
 		}
 
-		delta = abs(target_rate - vco);
+		delta = abs(target_vco_rate - vco);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_r = r;
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 6bf33ba6493c..960b0604d810 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -236,6 +236,8 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	mask |= config->pre_div_mask;
 	mask |= config->post_div_mask;
 	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
 
 	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
 
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index a1cd64d71cec..113c56bee92a 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -331,7 +331,7 @@ static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_rpmh *c = to_clk_rpmh(hw);
 
-	return c->aggr_state * c->unit;
+	return (unsigned long)c->aggr_state * c->unit;
 }
 
 static const struct clk_ops clk_rpmh_bcm_ops = {
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb10b83..cb215e6f2e83 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -108,11 +108,8 @@ int __init clocksource_i8253_init(void)
 #endif
 
 #ifdef CONFIG_CLKEVT_I8253
-static int pit_shutdown(struct clock_event_device *evt)
+void clockevent_i8253_disable(void)
 {
-	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
-		return 0;
-
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
@@ -123,6 +120,14 @@ static int pit_shutdown(struct clock_event_device *evt)
 	}
 
 	raw_spin_unlock(&i8253_lock);
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
+	clockevent_i8253_disable();
 	return 0;
 }
 
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index af0c00dabb22..f91c9f9adf44 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -25,6 +25,7 @@ struct s3c64xx_dvfs {
 	unsigned int vddarm_max;
 };
 
+#ifdef CONFIG_REGULATOR
 static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[0] = { 1000000, 1150000 },
 	[1] = { 1050000, 1150000 },
@@ -32,6 +33,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[3] = { 1200000, 1350000 },
 	[4] = { 1300000, 1350000 },
 };
+#endif
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0, 0,  66000 },
@@ -53,15 +55,16 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 				      unsigned int index)
 {
-	struct s3c64xx_dvfs *dvfs;
-	unsigned int old_freq, new_freq;
+	unsigned int new_freq = s3c64xx_freq_table[index].frequency;
 	int ret;
 
+#ifdef CONFIG_REGULATOR
+	struct s3c64xx_dvfs *dvfs;
+	unsigned int old_freq;
+
 	old_freq = clk_get_rate(policy->clk) / 1000;
-	new_freq = s3c64xx_freq_table[index].frequency;
 	dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_data];
 
-#ifdef CONFIG_REGULATOR
 	if (vddarm && new_freq > old_freq) {
 		ret = regulator_set_voltage(vddarm,
 					    dvfs->vddarm_min,
diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 08d4ce3bfddf..a768bb29d5c9 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -40,16 +40,19 @@ static void qce_unregister_algs(struct qce_device *qce)
 static int qce_register_algs(struct qce_device *qce)
 {
 	const struct qce_algo_ops *ops;
-	int i, ret = -ENODEV;
+	int i, j, ret = -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(qce_ops); i++) {
 		ops = qce_ops[i];
 		ret = ops->register_algs(qce);
-		if (ret)
-			break;
+		if (ret) {
+			for (j = i - 1; j >= 0; j--)
+				ops->unregister_algs(qce);
+			return ret;
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int qce_handle_request(struct crypto_async_request *async_req)
@@ -214,7 +217,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 
 	ret = qce_check_version(qce);
 	if (ret)
-		goto err_clks;
+		goto err_dma;
 
 	spin_lock_init(&qce->lock);
 	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index b570f08888ee..01089e5c565f 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -217,7 +217,6 @@ struct edma_desc {
 struct edma_cc;
 
 struct edma_tc {
-	struct device_node		*node;
 	u16				id;
 };
 
@@ -2414,13 +2413,13 @@ static int edma_probe(struct platform_device *pdev)
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
 	}
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 7dfbd0f6b76b..6415ff6817d9 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -170,7 +170,7 @@ config ISCSI_IBFT
 	select ISCSI_BOOT_SYSFS
 	select ISCSI_IBFT_FIND if X86
 	depends on ACPI && SCSI && SCSI_LOWLEVEL
-	default	n
+	default n
 	help
 	  This option enables support for detection and exposing of iSCSI
 	  Boot Firmware Table (iBFT) via sysfs to userspace. If you wish to
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 100575973e1f..35bf2ecc71b4 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -77,6 +77,22 @@ struct bcm_kona_gpio {
 struct bcm_kona_gpio_bank {
 	int id;
 	int irq;
+	/*
+	 * Used to keep track of lock/unlock operations for each GPIO in the
+	 * bank.
+	 *
+	 * All GPIOs are locked by default (see bcm_kona_gpio_reset), and the
+	 * unlock count for all GPIOs is 0 by default. Each unlock increments
+	 * the counter, and each lock decrements the counter.
+	 *
+	 * The lock function only locks the GPIO once its unlock counter is
+	 * down to 0. This is necessary because the GPIO is unlocked in two
+	 * places in this driver: once for requested GPIOs, and once for
+	 * requested IRQs. Since it is possible for a GPIO to be requested
+	 * as both a GPIO and an IRQ, we need to ensure that we don't lock it
+	 * too early.
+	 */
+	u8 gpio_unlock_count[GPIO_PER_BANK];
 	/* Used in the interrupt handler */
 	struct bcm_kona_gpio *kona_gpio;
 };
@@ -94,14 +110,24 @@ static void bcm_kona_gpio_lock_gpio(struct bcm_kona_gpio *kona_gpio,
 	u32 val;
 	unsigned long flags;
 	int bank_id = GPIO_BANK(gpio);
+	int bit = GPIO_BIT(gpio);
+	struct bcm_kona_gpio_bank *bank = &kona_gpio->banks[bank_id];
 
-	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
+	if (bank->gpio_unlock_count[bit] == 0) {
+		dev_err(kona_gpio->gpio_chip.parent,
+			"Unbalanced locks for GPIO %u\n", gpio);
+		return;
+	}
 
-	val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
-	val |= BIT(gpio);
-	bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+	if (--bank->gpio_unlock_count[bit] == 0) {
+		raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
-	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+		val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
+		val |= BIT(bit);
+		bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+
+		raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+	}
 }
 
 static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
@@ -110,14 +136,20 @@ static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
 	u32 val;
 	unsigned long flags;
 	int bank_id = GPIO_BANK(gpio);
+	int bit = GPIO_BIT(gpio);
+	struct bcm_kona_gpio_bank *bank = &kona_gpio->banks[bank_id];
 
-	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
+	if (bank->gpio_unlock_count[bit] == 0) {
+		raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
-	val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
-	val &= ~BIT(gpio);
-	bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+		val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
+		val &= ~BIT(bit);
+		bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
 
-	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+	}
+
+	++bank->gpio_unlock_count[bit];
 }
 
 static int bcm_kona_gpio_get_dir(struct gpio_chip *chip, unsigned gpio)
@@ -368,6 +400,7 @@ static void bcm_kona_gpio_irq_mask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MASK(bank_id));
@@ -390,6 +423,7 @@ static void bcm_kona_gpio_irq_unmask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MSKCLR(bank_id));
@@ -487,15 +521,26 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 static int bcm_kona_gpio_irq_reqres(struct irq_data *d)
 {
 	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = d->hwirq;
 
-	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, d->hwirq);
+	/*
+	 * We need to unlock the GPIO before any other operations are performed
+	 * on the relevant GPIO configuration registers
+	 */
+	bcm_kona_gpio_unlock_gpio(kona_gpio, gpio);
+
+	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, gpio);
 }
 
 static void bcm_kona_gpio_irq_relres(struct irq_data *d)
 {
 	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = d->hwirq;
+
+	/* Once we no longer use it, lock the GPIO again */
+	bcm_kona_gpio_lock_gpio(kona_gpio, gpio);
 
-	gpiochip_relres_irq(&kona_gpio->gpio_chip, d->hwirq);
+	gpiochip_relres_irq(&kona_gpio->gpio_chip, gpio);
 }
 
 static struct irq_chip bcm_gpio_irq_chip = {
@@ -629,7 +674,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		bank->irq = platform_get_irq(pdev, i);
 		bank->kona_gpio = kona_gpio;
 		if (bank->irq < 0) {
-			dev_err(dev, "Couldn't get IRQ for bank %d", i);
+			dev_err(dev, "Couldn't get IRQ for bank %d\n", i);
 			ret = -ENOENT;
 			goto err_irq_domain;
 		}
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index f0b6c68e848e..37b731d22cb0 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -418,7 +418,12 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	p->has_both_edge_trigger = info->has_both_edge_trigger;
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
-	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
+	if (ret) {
+		*npins = RCAR_MAX_GPIO_PER_BANK;
+	} else {
+		*npins = args.args[2];
+		of_node_put(args.np);
+	}
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(p->dev, "Invalid number of gpio lines %u, using %u\n",
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 994d542daf53..06f4bd31638b 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -188,7 +188,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 		[REG_IE][CSB] = STMPE_IDX_IEGPIOR_CSB,
 		[REG_IE][MSB] = STMPE_IDX_IEGPIOR_MSB,
 	};
-	int i, j;
+	int ret, i, j;
 
 	/*
 	 * STMPE1600: to be able to get IRQ from pins,
@@ -196,8 +196,16 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 	 * GPSR or GPCR registers
 	 */
 	if (stmpe->partnum == STMPE1600) {
-		stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_LSB]);
-		stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_CSB]);
+		ret = stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_LSB]);
+		if (ret < 0) {
+			dev_err(stmpe->dev, "Failed to read GPMR_LSB: %d\n", ret);
+			goto err;
+		}
+		ret = stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_CSB]);
+		if (ret < 0) {
+			dev_err(stmpe->dev, "Failed to read GPMR_CSB: %d\n", ret);
+			goto err;
+		}
 	}
 
 	for (i = 0; i < CACHE_NR_REGS; i++) {
@@ -219,6 +227,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 		}
 	}
 
+err:
 	mutex_unlock(&stmpe_gpio->irq_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9dcb38bab0e1..69bfaa9a8f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -766,6 +766,22 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
+	if ((amdgpu_runtime_pm != 0) &&
+	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
+	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
+	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
+		DRM_WARN("System can't access extended configuration space,please check!!\n");
+
+	/* skip if the bios has already enabled large BAR */
+	if (adev->gmc.real_vram_size &&
+	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
+		return 0;
+
 	/* Check if the root BUS has 64bit memory resources */
 	root = adev->pdev->bus;
 	while (root->parent)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
index 01dc46dc9c8a..ec680695ed03 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
@@ -1369,6 +1369,8 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 			GetIndexIntoMasterTable(DATA, SMU_Info),
 			&size, &frev, &crev);
 
+	if (!psmu_info)
+		return -EINVAL;
 
 	for (i = 0; i < psmu_info->ucSclkEntryNum; i++) {
 		table->entry[i].ucVco_setting = psmu_info->asSclkFcwRangeEntry[i].ucVco_setting;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index b72840c06ab7..1389b0c4e73a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -159,6 +159,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
 					       kwb_conn->wb_layer->layer_type,
 					       &n_formats);
+	if (!formats) {
+		kfree(kwb_conn);
+		return -ENOMEM;
+	}
 
 	err = drm_writeback_connector_init(&kms->base, wb_conn,
 					   &komeda_wb_connector_funcs,
diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
index b15cee85b702..2b66804044f8 100644
--- a/drivers/gpu/drm/drm_dp_cec.c
+++ b/drivers/gpu/drm/drm_dp_cec.c
@@ -303,16 +303,6 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 	if (!aux->transfer)
 		return;
 
-#ifndef CONFIG_MEDIA_CEC_RC
-	/*
-	 * CEC_CAP_RC is part of CEC_CAP_DEFAULTS, but it is stripped by
-	 * cec_allocate_adapter() if CONFIG_MEDIA_CEC_RC is undefined.
-	 *
-	 * Do this here as well to ensure the tests against cec_caps are
-	 * correct.
-	 */
-	cec_caps &= ~CEC_CAP_RC;
-#endif
 	cancel_delayed_work_sync(&aux->cec.unregister_work);
 
 	mutex_lock(&aux->cec.lock);
@@ -329,7 +319,9 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 		num_las = CEC_MAX_LOG_ADDRS;
 
 	if (aux->cec.adap) {
-		if (aux->cec.adap->capabilities == cec_caps &&
+		/* Check if the adapter properties have changed */
+		if ((aux->cec.adap->capabilities & CEC_CAP_MONITOR_ALL) ==
+		    (cec_caps & CEC_CAP_MONITOR_ALL) &&
 		    aux->cec.adap->available_log_addrs == num_las) {
 			/* Unchanged, so just set the phys addr */
 			cec_s_phys_addr_from_edid(aux->cec.adap, edid);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 2aabe8433cee..3d04ac6d821d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -350,6 +350,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
+	pgprot_t prot;
 
 	lockdep_assert_held(&obj->lock);
 
@@ -357,8 +358,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
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
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 44856e3a7108..b24dea5726ed 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -361,7 +361,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev)
 	return -1;
 }
 
-static void r300_gpu_init(struct radeon_device *rdev)
+/* rs400_gpu_init also calls this! */
+void r300_gpu_init(struct radeon_device *rdev)
 {
 	uint32_t gb_tile_config, tmp;
 
diff --git a/drivers/gpu/drm/radeon/radeon_asic.h b/drivers/gpu/drm/radeon/radeon_asic.h
index a74fa18cd27b..e5a85950d801 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.h
+++ b/drivers/gpu/drm/radeon/radeon_asic.h
@@ -165,6 +165,7 @@ void r200_set_safe_registers(struct radeon_device *rdev);
  */
 extern int r300_init(struct radeon_device *rdev);
 extern void r300_fini(struct radeon_device *rdev);
+extern void r300_gpu_init(struct radeon_device *rdev);
 extern int r300_suspend(struct radeon_device *rdev);
 extern int r300_resume(struct radeon_device *rdev);
 extern int r300_asic_reset(struct radeon_device *rdev, bool hard);
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index 117f60af1ee4..7c2715f93064 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -257,8 +257,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rdev)
 
 static void rs400_gpu_init(struct radeon_device *rdev)
 {
-	/* FIXME: is this correct ? */
-	r420_pipes_init(rdev);
+	/* Earlier code was calling r420_pipes_init and then
+	 * rs400_mc_wait_for_idle(rdev). The problem is that
+	 * at least on my Mobility Radeon Xpress 200M RC410 card
+	 * that ends up in this code path ends up num_gb_pipes == 3
+	 * while the card seems to have only one pipe. With the
+	 * r420 pipe initialization method.
+	 *
+	 * Problems shown up as HyperZ glitches, see:
+	 * https://bugs.freedesktop.org/show_bug.cgi?id=110897
+	 *
+	 * Delegating initialization to r300 code seems to work
+	 * and results in proper pipe numbers. The rs400 cards
+	 * are said to be not r400, but r300 kind of cards.
+	 */
+	r300_gpu_init(rdev);
+
 	if (rs400_mc_wait_for_idle(rdev)) {
 		pr_warn("rs400: Failed to wait MC idle while programming pipes. Bad things might happen. %08x\n",
 			RREG32(RADEON_MC_STATUS));
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index d79086498aff..4fe2a8770504 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -21,7 +21,7 @@
  *
  */
 
-#if !defined(_GPU_SCHED_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_GPU_SCHED_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _GPU_SCHED_TRACE_H_
 
 #include <linux/stringify.h>
@@ -96,7 +96,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 		      __entry->seqno)
 );
 
-#endif
+#endif /* _GPU_SCHED_TRACE_H_ */
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index bf8d4afe0d6a..da7bdfdd193f 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -188,7 +188,7 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	static const u8 flatbattery[] = { 0x25, 0x87, 0xe0 };
 	unsigned long flags;
 
-	if (len != 5)
+	if (len != 5 || !(hid->claimed & HID_CLAIMED_INPUT))
 		goto out;
 
 	if (!memcmp(data, keydown, sizeof(keydown))) {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 10ee4d3269b9..ad0c5b353c16 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1117,6 +1117,8 @@ static void hid_apply_multiplier(struct hid_device *hid,
 	while (multiplier_collection->parent_idx != -1 &&
 	       multiplier_collection->type != HID_COLLECTION_LOGICAL)
 		multiplier_collection = &hid->collection[multiplier_collection->parent_idx];
+	if (multiplier_collection->type != HID_COLLECTION_LOGICAL)
+		multiplier_collection = NULL;
 
 	effective_multiplier = hid_calculate_multiplier(hid, multiplier);
 
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 2ebad3ed4e3a..727c5c018cb9 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -258,11 +258,13 @@ static int cbas_ec_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cbas_ec_acpi_ids[] = {
 	{ "GOOG000B", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
+#endif
 
 static struct platform_driver cbas_ec_driver = {
 	.probe = cbas_ec_probe,
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5994e7d1b82d..cb0bbba5c1c9 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1601,9 +1601,12 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		break;
 	}
 
-	if (suffix)
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index f9983145d4e7..244a5429ff7d 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -730,23 +730,30 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	return ret;
 }
 
+static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
+{
+	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+
+	if (hsdev->pending.status)
+		complete(&hsdev->pending.ready);
+
+	return 0;
+}
+
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
 	unsigned long flags;
-	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
 	spin_lock_irqsave(&data->lock, flags);
-	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
-		struct hid_sensor_hub_device *hsdev =
-			data->hid_sensor_hub_client_devs[i].platform_data;
-		if (hsdev->pending.status)
-			complete(&hsdev->pending.ready);
-	}
+	device_for_each_child(&hdev->dev, NULL,
+			      sensor_hub_finalize_pending_fn);
 	spin_unlock_irqrestore(&data->lock, flags);
+
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
 }
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index b8aae69ad15d..ef5236855771 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -263,12 +263,14 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
  */
 void ishtp_hid_remove(struct ishtp_cl_data *client_data)
 {
+	void *data;
 	int i;
 
 	for (i = 0; i < client_data->num_hid_devices; ++i) {
 		if (client_data->hid_sensor_hubs[i]) {
-			kfree(client_data->hid_sensor_hubs[i]->driver_data);
+			data = client_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(client_data->hid_sensor_hubs[i]);
+			kfree(data);
 			client_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0ec75848ca80..7851cbec79dc 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4851,6 +4851,10 @@ static const struct wacom_features wacom_features_0x94 =
 	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
 	.driver_data = (kernel_ulong_t)&wacom_features_##prod
 
+#define PCI_DEVICE_WACOM(prod)						\
+	HID_DEVICE(BUS_PCI, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
+	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+
 #define USB_DEVICE_LENOVO(prod)					\
 	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
 	.driver_data = (kernel_ulong_t)&wacom_features_##prod
@@ -5020,6 +5024,7 @@ const struct hid_device_id wacom_ids[] = {
 
 	{ USB_DEVICE_WACOM(HID_ANY_ID) },
 	{ I2C_DEVICE_WACOM(HID_ANY_ID) },
+	{ PCI_DEVICE_WACOM(HID_ANY_ID) },
 	{ BT_DEVICE_WACOM(HID_ANY_ID) },
 	{ }
 };
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 7802bbf5f958..59424103f634 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -22,11 +22,13 @@
  */
 #define AD7314_TEMP_MASK		0x7FE0
 #define AD7314_TEMP_SHIFT		5
+#define AD7314_LEADING_ZEROS_MASK	BIT(15)
 
 /*
  * ADT7301 and ADT7302 temperature masks
  */
 #define ADT7301_TEMP_MASK		0x3FFF
+#define ADT7301_LEADING_ZEROS_MASK	(BIT(15) | BIT(14))
 
 enum ad7314_variant {
 	adt7301,
@@ -65,12 +67,20 @@ static ssize_t ad7314_temperature_show(struct device *dev,
 		return ret;
 	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
 	case ad7314:
+		if (ret & AD7314_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
 		data = sign_extend32(data, 9);
 
 		return sprintf(buf, "%d\n", 250 * data);
 	case adt7301:
 	case adt7302:
+		if (ret & ADT7301_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		/*
 		 * Documented as a 13 bit twos complement register
 		 * with a sign bit - which is a 14 bit 2's complement
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 7e20beb8b11f..1305f81c4ae3 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -177,40 +177,40 @@ static const struct ntc_compensation ncpXXwf104[] = {
 };
 
 static const struct ntc_compensation ncpXXxh103[] = {
-	{ .temp_c	= -40, .ohm	= 247565 },
-	{ .temp_c	= -35, .ohm	= 181742 },
-	{ .temp_c	= -30, .ohm	= 135128 },
-	{ .temp_c	= -25, .ohm	= 101678 },
-	{ .temp_c	= -20, .ohm	= 77373 },
-	{ .temp_c	= -15, .ohm	= 59504 },
-	{ .temp_c	= -10, .ohm	= 46222 },
-	{ .temp_c	= -5, .ohm	= 36244 },
-	{ .temp_c	= 0, .ohm	= 28674 },
-	{ .temp_c	= 5, .ohm	= 22878 },
-	{ .temp_c	= 10, .ohm	= 18399 },
-	{ .temp_c	= 15, .ohm	= 14910 },
-	{ .temp_c	= 20, .ohm	= 12169 },
+	{ .temp_c	= -40, .ohm	= 195652 },
+	{ .temp_c	= -35, .ohm	= 148171 },
+	{ .temp_c	= -30, .ohm	= 113347 },
+	{ .temp_c	= -25, .ohm	= 87559 },
+	{ .temp_c	= -20, .ohm	= 68237 },
+	{ .temp_c	= -15, .ohm	= 53650 },
+	{ .temp_c	= -10, .ohm	= 42506 },
+	{ .temp_c	= -5, .ohm	= 33892 },
+	{ .temp_c	= 0, .ohm	= 27219 },
+	{ .temp_c	= 5, .ohm	= 22021 },
+	{ .temp_c	= 10, .ohm	= 17926 },
+	{ .temp_c	= 15, .ohm	= 14674 },
+	{ .temp_c	= 20, .ohm	= 12081 },
 	{ .temp_c	= 25, .ohm	= 10000 },
-	{ .temp_c	= 30, .ohm	= 8271 },
-	{ .temp_c	= 35, .ohm	= 6883 },
-	{ .temp_c	= 40, .ohm	= 5762 },
-	{ .temp_c	= 45, .ohm	= 4851 },
-	{ .temp_c	= 50, .ohm	= 4105 },
-	{ .temp_c	= 55, .ohm	= 3492 },
-	{ .temp_c	= 60, .ohm	= 2985 },
-	{ .temp_c	= 65, .ohm	= 2563 },
-	{ .temp_c	= 70, .ohm	= 2211 },
-	{ .temp_c	= 75, .ohm	= 1915 },
-	{ .temp_c	= 80, .ohm	= 1666 },
-	{ .temp_c	= 85, .ohm	= 1454 },
-	{ .temp_c	= 90, .ohm	= 1275 },
-	{ .temp_c	= 95, .ohm	= 1121 },
-	{ .temp_c	= 100, .ohm	= 990 },
-	{ .temp_c	= 105, .ohm	= 876 },
-	{ .temp_c	= 110, .ohm	= 779 },
-	{ .temp_c	= 115, .ohm	= 694 },
-	{ .temp_c	= 120, .ohm	= 620 },
-	{ .temp_c	= 125, .ohm	= 556 },
+	{ .temp_c	= 30, .ohm	= 8315 },
+	{ .temp_c	= 35, .ohm	= 6948 },
+	{ .temp_c	= 40, .ohm	= 5834 },
+	{ .temp_c	= 45, .ohm	= 4917 },
+	{ .temp_c	= 50, .ohm	= 4161 },
+	{ .temp_c	= 55, .ohm	= 3535 },
+	{ .temp_c	= 60, .ohm	= 3014 },
+	{ .temp_c	= 65, .ohm	= 2586 },
+	{ .temp_c	= 70, .ohm	= 2228 },
+	{ .temp_c	= 75, .ohm	= 1925 },
+	{ .temp_c	= 80, .ohm	= 1669 },
+	{ .temp_c	= 85, .ohm	= 1452 },
+	{ .temp_c	= 90, .ohm	= 1268 },
+	{ .temp_c	= 95, .ohm	= 1110 },
+	{ .temp_c	= 100, .ohm	= 974 },
+	{ .temp_c	= 105, .ohm	= 858 },
+	{ .temp_c	= 110, .ohm	= 758 },
+	{ .temp_c	= 115, .ohm	= 672 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
 };
 
 /*
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index c0bc43d01018..81d4e9e85d3e 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -101,6 +101,8 @@ static int pmbus_identify(struct i2c_client *client,
 		if (pmbus_check_byte_register(client, 0, PMBUS_PAGE)) {
 			int page;
 
+			info->pages = PMBUS_PAGES;
+
 			for (page = 1; page < PMBUS_PAGES; page++) {
 				if (pmbus_set_page(client, page) < 0)
 					break;
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index f5d3cf86753f..559a73bab51e 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -719,7 +719,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (!ctx->pcc_comm_addr) {
+		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
 			dev_err(&pdev->dev,
 				"Failed to ioremap PCC comm region\n");
 			rc = -ENOMEM;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index c15c9c2daf17..9089f7179290 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -324,6 +324,21 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Arrow Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7724),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-H */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe324),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-P/U */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe424),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Rocket Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c19),
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 541dbcf22d0e..13e4b2c40d83 100644
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
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index baa129a6c912..20335542a81a 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -384,10 +384,10 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
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
 
diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index ac2f5d6272dc..1d433542cc91 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -267,7 +267,7 @@ static int lp8860_init(struct lp8860_led *led)
 		goto out;
 	}
 
-	reg_count = ARRAY_SIZE(lp8860_eeprom_disp_regs) / sizeof(lp8860_eeprom_disp_regs[0]);
+	reg_count = ARRAY_SIZE(lp8860_eeprom_disp_regs);
 	for (i = 0; i < reg_count; i++) {
 		ret = regmap_write(led->eeprom_regmap,
 				lp8860_eeprom_disp_regs[i].reg,
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index 6b495fc36fd0..51e890554457 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -310,12 +310,8 @@ static int cxd2841er_set_reg_bits(struct cxd2841er_priv *priv,
 
 static u32 cxd2841er_calc_iffreq_xtal(enum cxd2841er_xtal xtal, u32 ifhz)
 {
-	u64 tmp;
-
-	tmp = (u64) ifhz * 16777216;
-	do_div(tmp, ((xtal == SONY_XTAL_24000) ? 48000000 : 41000000));
-
-	return (u32) tmp;
+	return div_u64(ifhz * 16777216ull,
+		       (xtal == SONY_XTAL_24000) ? 48000000 : 41000000);
 }
 
 static u32 cxd2841er_calc_iffreq(u32 ifhz)
diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 2e5a49e87a74..78725828be18 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1368,6 +1368,7 @@ static int ov5640_get_light_freq(struct ov5640_dev *sensor)
 			light_freq = 50;
 		} else {
 			/* 60Hz */
+			light_freq = 60;
 		}
 	}
 
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
index 1aac167abb17..6a2a85cc3e5f 100644
--- a/drivers/media/platform/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/exynos4-is/mipi-csis.c
@@ -941,13 +941,19 @@ static int s5pcsis_pm_resume(struct device *dev, bool runtime)
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
diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index ee624804862e..3c8c262e3c68 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -529,10 +529,19 @@ static int s3c_camif_remove(struct platform_device *pdev)
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
index a7deca1fefb7..f50362bb59f2 100644
--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -200,8 +200,10 @@ static int iguanair_send(struct iguanair *ir, unsigned size)
 	if (rc)
 		return rc;
 
-	if (wait_for_completion_timeout(&ir->completion, TIMEOUT) == 0)
+	if (wait_for_completion_timeout(&ir->completion, TIMEOUT) == 0) {
+		usb_kill_urb(ir->urb_out);
 		return -ETIMEDOUT;
+	}
 
 	return rc;
 }
diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
index 5ac1a6af8782..8c573c3a83d5 100644
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -372,8 +372,9 @@ static int lme2510_int_read(struct dvb_usb_adapter *adap)
 	struct dvb_usb_device *d = adap_to_d(adap);
 	struct lme2510_state *lme_int = adap_to_priv(adap);
 	struct usb_host_endpoint *ep;
+	int ret;
 
-	lme_int->lme_urb = usb_alloc_urb(0, GFP_ATOMIC);
+	lme_int->lme_urb = usb_alloc_urb(0, GFP_KERNEL);
 
 	if (lme_int->lme_urb == NULL)
 			return -ENOMEM;
@@ -389,11 +390,20 @@ static int lme2510_int_read(struct dvb_usb_adapter *adap)
 
 	/* Quirk of pipe reporting PIPE_BULK but behaves as interrupt */
 	ep = usb_pipe_endpoint(d->udev, lme_int->lme_urb->pipe);
+	if (!ep) {
+		usb_free_urb(lme_int->lme_urb);
+		return -ENODEV;
+	}
 
 	if (usb_endpoint_type(&ep->desc) == USB_ENDPOINT_XFER_BULK)
 		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa);
 
-	usb_submit_urb(lme_int->lme_urb, GFP_ATOMIC);
+	ret = usb_submit_urb(lme_int->lme_urb, GFP_KERNEL);
+	if (ret) {
+		usb_free_urb(lme_int->lme_urb);
+		return ret;
+	}
+
 	info("INT Interrupt Service Started");
 
 	return 0;
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e3457449faae..923494567d89 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1306,6 +1306,40 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
 	uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
 }
 
+static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
+				struct uvc_fh *new_handle)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (new_handle) {
+		if (ctrl->handle)
+			dev_warn_ratelimited(&handle->stream->dev->udev->dev,
+					     "UVC non compliance: Setting an async control with a pending operation.");
+
+		if (new_handle == ctrl->handle)
+			return;
+
+		if (ctrl->handle) {
+			WARN_ON(!ctrl->handle->pending_async_ctrls);
+			if (ctrl->handle->pending_async_ctrls)
+				ctrl->handle->pending_async_ctrls--;
+		}
+
+		ctrl->handle = new_handle;
+		handle->pending_async_ctrls++;
+		return;
+	}
+
+	/* Cannot clear the handle for a control not owned by us.*/
+	if (WARN_ON(ctrl->handle != handle))
+		return;
+
+	ctrl->handle = NULL;
+	if (WARN_ON(!handle->pending_async_ctrls))
+		return;
+	handle->pending_async_ctrls--;
+}
+
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 			   struct uvc_control *ctrl, const u8 *data)
 {
@@ -1316,7 +1350,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_set_handle(handle, ctrl, NULL);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1367,10 +1402,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;
@@ -1400,13 +1433,13 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
-	u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 	unsigned int i;
 	unsigned int j;
 
 	for (i = 0; i < xctrls_count; ++i) {
-		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
+		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1528,7 +1561,9 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1572,6 +1607,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (ret < 0)
 			return ret;
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;
@@ -1587,7 +1626,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback);
 		if (ret < 0)
 			goto done;
 	}
@@ -1711,9 +1751,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2042,7 +2079,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0);
 		if (ret < 0)
 			return ret;
 	}
@@ -2374,6 +2411,30 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 	return 0;
 }
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
+{
+	struct uvc_entity *entity;
+
+	mutex_lock(&handle->chain->ctrl_mutex);
+
+	if (!handle->pending_async_ctrls) {
+		mutex_unlock(&handle->chain->ctrl_mutex);
+		return;
+	}
+
+	list_for_each_entry(entity, &handle->chain->dev->entities, list) {
+		unsigned int i;
+		for (i = 0; i < entity->ncontrols; ++i) {
+			if (entity->controls[i].handle != handle)
+				continue;
+			uvc_ctrl_set_handle(handle, &entity->controls[i], NULL);
+		}
+	}
+
+	WARN_ON(handle->pending_async_ctrls);
+	mutex_unlock(&handle->chain->ctrl_mutex);
+}
+
 /*
  * Cleanup device controls.
  */
diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index da72577c2998..d7c81e205e8b 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -486,7 +486,8 @@ static void uvc_queue_buffer_complete(struct kref *ref)
 
 	buf->state = buf->error ? UVC_BUF_STATE_ERROR : UVC_BUF_STATE_DONE;
 	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, buf->bytesused);
-	vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_DONE);
+	vb2_buffer_done(&buf->buf.vb2_buf, buf->error ? VB2_BUF_STATE_ERROR :
+							VB2_BUF_STATE_DONE);
 }
 
 /*
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 73725051cc16..6edf491dd873 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -269,6 +269,7 @@ int uvc_status_init(struct uvc_device *dev)
 	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (dev->int_urb == NULL) {
 		kfree(dev->status);
+		dev->status = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 96ef64b6a232..32dfb8617074 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -589,6 +589,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_trace(UVC_TRACE_CALLS, "uvc_v4l2_release\n");
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 97817b350f98..6993cb33b357 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -447,7 +447,11 @@ struct uvc_video_chain {
 	struct uvc_entity *processing;		/* Processing unit */
 	struct uvc_entity *selector;		/* Selector unit */
 
-	struct mutex ctrl_mutex;		/* Protects ctrl.info */
+	struct mutex ctrl_mutex;		/*
+						 * Protects ctrl.info,
+						 * ctrl.handle and
+						 * uvc_fh.pending_async_ctrls
+						 */
 
 	struct v4l2_prio_state prio;		/* V4L2 priority state */
 	u32 caps;				/* V4L2 chain-wide caps */
@@ -693,6 +697,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -865,6 +870,8 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
 			   unsigned int n_terms, unsigned int threshold);
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 3bbb29a7e7a5..d5a3c1923c0a 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -685,8 +685,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x2917), LPC_ICH9ME},
 	{ PCI_VDEVICE(INTEL, 0x2918), LPC_ICH9},
 	{ PCI_VDEVICE(INTEL, 0x2919), LPC_ICH9M},
-	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
 	{ PCI_VDEVICE(INTEL, 0x2b9c), LPC_COUGARMOUNTAIN},
+	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
+	{ PCI_VDEVICE(INTEL, 0x31e8), LPC_GLK},
 	{ PCI_VDEVICE(INTEL, 0x3a14), LPC_ICH10DO},
 	{ PCI_VDEVICE(INTEL, 0x3a16), LPC_ICH10R},
 	{ PCI_VDEVICE(INTEL, 0x3a18), LPC_ICH10},
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index f1f766b70965..cae2d4371b49 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -60,7 +60,7 @@ static struct platform_device digsy_mtc_eeprom = {
 };
 
 static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
-	.dev_id         = "spi_gpio",
+	.dev_id         = "spi_gpio.1",
 	.table          = {
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CLK,
 			    "sck", GPIO_ACTIVE_HIGH),
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6a2646c481ec..f1bfaad2ce27 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -801,7 +801,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 			vma = find_vma(current->mm, ctx->args[i].ptr);
 			if (vma)
-				pages[i].addr += ctx->args[i].ptr -
+				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;
 
 			pg_start = (ctx->args[i].ptr & PAGE_MASK) >> PAGE_SHIFT;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index e614fd82a32a..2362a70460f1 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -379,6 +379,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 	if (card->type == MMC_TYPE_SD_COMBO)
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
+	max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
+
 	return max_dtr;
 }
 
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 9e81cd982dd3..05252174b73b 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2921,6 +2921,7 @@ static int do_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = ONENAND_IS_4KB_PAGE(this) ?
 		onenand_mlc_read_ops_nolock(mtd, from, &ops) :
 		onenand_read_ops_nolock(mtd, from, &ops);
+	*retlen = ops.retlen;
 
 	/* Exit OTP access mode */
 	this->command(mtd, ONENAND_CMD_RESET, 0, 0);
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 7f2c551e5d69..41c096c2af5b 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -746,7 +746,7 @@ static int cfv_probe(struct virtio_device *vdev)
 
 	if (cfv->vr_rx)
 		vdev->vringh_config->del_vrhs(cfv->vdev);
-	if (cfv->vdev)
+	if (cfv->vq_tx)
 		vdev->config->del_vqs(cfv->vdev);
 	free_netdev(netdev);
 	return err;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index f2b0408ce87d..42cb74ec6d99 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -391,15 +391,16 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
 			KBUILD_MODNAME, ret);
-		goto exit_free_device;
+		goto exit_pm_runtime;
 	}
 
 	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
 		 KBUILD_MODNAME, priv->base, dev->irq);
 	return 0;
 
-exit_free_device:
+exit_pm_runtime:
 	pm_runtime_disable(priv->device);
+exit_free_device:
 	free_c_can_dev(dev);
 exit:
 	dev_err(&pdev->dev, "probe failed\n");
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b060e1fe3bab..55aa87771333 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -55,6 +55,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/crc32poly.h>
+#include <linux/dmi.h>
 
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -18192,6 +18193,50 @@ static int tg3_resume(struct device *device)
 
 static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
 
+/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
+ * PCIe AER event on the tg3 device if the tg3 device is not, or cannot
+ * be, powered down.
+ */
+static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
+		},
+	},
+	{}
+};
+
 static void tg3_shutdown(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -18208,6 +18253,19 @@ static void tg3_shutdown(struct pci_dev *pdev)
 
 	if (system_state == SYSTEM_POWER_OFF)
 		tg3_power_down(tp);
+	else if (system_state == SYSTEM_RESTART &&
+		 dmi_first_match(tg3_restart_aer_quirk_table) &&
+		 pdev->current_state != PCI_D3cold &&
+		 pdev->current_state != PCI_UNKNOWN) {
+		/* Disable PCIe AER on the tg3 to avoid a fatal
+		 * error during this system restart.
+		 */
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+					   PCI_EXP_DEVCTL_CERE |
+					   PCI_EXP_DEVCTL_NFERE |
+					   PCI_EXP_DEVCTL_FERE |
+					   PCI_EXP_DEVCTL_URRE);
+	}
 
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 03983bd46eef..bf864b2d0cac 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1177,6 +1177,8 @@ struct macb {
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
 	struct net_device	*dev;
+	/* Protects hw_stats and ethtool_stats */
+	spinlock_t		stats_lock;
 	union {
 		struct macb_stats	macb;
 		struct gem_stats	gem;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 12dd18cbdba3..a750c752846c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1483,10 +1483,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 		if (status & MACB_BIT(ISR_ROVR)) {
 			/* We missed at least one packet */
+			spin_lock(&bp->stats_lock);
 			if (macb_is_gem(bp))
 				bp->hw_stats.gem.rx_overruns++;
 			else
 				bp->hw_stats.macb.rx_overruns++;
+			spin_unlock(&bp->stats_lock);
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
@@ -2567,6 +2569,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	if (!netif_running(bp->dev))
 		return nstat;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
@@ -2596,6 +2599,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
 	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underrun;
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -2603,12 +2607,13 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 static void gem_get_ethtool_stats(struct net_device *dev,
 				  struct ethtool_stats *stats, u64 *data)
 {
-	struct macb *bp;
+	struct macb *bp = netdev_priv(dev);
 
-	bp = netdev_priv(dev);
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
 			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static int gem_get_sset_count(struct net_device *dev, int sset)
@@ -2658,6 +2663,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 		return gem_get_stats(bp);
 
 	/* read stats from hardware */
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 
 	/* Convert HW stats into netdevice stats */
@@ -2691,6 +2697,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 	nstat->tx_carrier_errors = hwstat->tx_carrier_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underruns;
 	/* Don't know about heartbeat or window errors... */
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -4306,6 +4313,7 @@ static int macb_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
 
 	spin_lock_init(&bp->lock);
+	spin_lock_init(&bp->stats_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 1d5d8984b49a..fdf69fe78fbb 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1781,10 +1781,11 @@ dm9000_drv_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 	dm9000_release_board(pdev, dm);
-	free_netdev(ndev);		/* free device structure */
 	if (dm->power_supply)
 		regulator_disable(dm->power_supply);
 
+	free_netdev(ndev);		/* free device structure */
+
 	dev_dbg(&pdev->dev, "released and freed device\n");
 	return 0;
 }
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index cf3e6f2892ff..ad72599aa894 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -564,7 +564,7 @@ struct be_adapter {
 	struct be_dma_mem mbox_mem_alloced;
 
 	struct be_mcc_obj mcc_obj;
-	struct mutex mcc_lock;	/* For serializing mcc cmds to BE card */
+	spinlock_t mcc_lock;	/* For serializing mcc cmds to BE card */
 	spinlock_t mcc_cq_lock;
 
 	u16 cfg_num_rx_irqs;		/* configured via set-channels */
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 1288b5e3d220..9812a9a5d033 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -573,7 +573,7 @@ int be_process_mcc(struct be_adapter *adapter)
 /* Wait till no more pending mcc requests are present */
 static int be_mcc_wait_compl(struct be_adapter *adapter)
 {
-#define mcc_timeout		12000 /* 12s timeout */
+#define mcc_timeout		120000 /* 12s timeout */
 	int i, status = 0;
 	struct be_mcc_obj *mcc_obj = &adapter->mcc_obj;
 
@@ -587,7 +587,7 @@ static int be_mcc_wait_compl(struct be_adapter *adapter)
 
 		if (atomic_read(&mcc_obj->q.used) == 0)
 			break;
-		usleep_range(500, 1000);
+		udelay(100);
 	}
 	if (i == mcc_timeout) {
 		dev_err(&adapter->pdev->dev, "FW not responding\n");
@@ -865,7 +865,7 @@ static bool use_mcc(struct be_adapter *adapter)
 static int be_cmd_lock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter)) {
-		mutex_lock(&adapter->mcc_lock);
+		spin_lock_bh(&adapter->mcc_lock);
 		return 0;
 	} else {
 		return mutex_lock_interruptible(&adapter->mbox_lock);
@@ -876,7 +876,7 @@ static int be_cmd_lock(struct be_adapter *adapter)
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter))
-		return mutex_unlock(&adapter->mcc_lock);
+		return spin_unlock_bh(&adapter->mcc_lock);
 	else
 		return mutex_unlock(&adapter->mbox_lock);
 }
@@ -1046,7 +1046,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	struct be_cmd_req_mac_query *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1075,7 +1075,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1087,7 +1087,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, u8 *mac_addr,
 	struct be_cmd_req_pmac_add *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1112,7 +1112,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	 if (base_status(status) == MCC_STATUS_UNAUTHORIZED_REQUEST)
 		status = -EPERM;
@@ -1130,7 +1130,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	if (pmac_id == -1)
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1150,7 +1150,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1413,7 +1413,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	struct be_dma_mem *q_mem = &rxq->dma_mem;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1443,7 +1443,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1507,7 +1507,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	struct be_cmd_req_q_destroy *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1524,7 +1524,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	q->created = false;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1592,7 +1592,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	struct be_cmd_req_hdr *hdr;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1620,7 +1620,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1636,7 +1636,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 			    CMD_SUBSYSTEM_ETH))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1659,7 +1659,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1696,7 +1696,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	struct be_cmd_req_link_status *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	if (link_status)
 		*link_status = LINK_DOWN;
@@ -1735,7 +1735,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1746,7 +1746,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 	struct be_cmd_req_get_cntl_addnl_attribs *req;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1761,7 +1761,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1810,7 +1810,7 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 	if (!get_fat_cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	while (total_size) {
 		buf_size = min(total_size, (u32)60*1024);
@@ -1848,9 +1848,9 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 		log_offset += buf_size;
 	}
 err:
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_fat_cmd.size,
 			  get_fat_cmd.va, get_fat_cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1861,7 +1861,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 	struct be_cmd_req_get_fw_version *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1884,7 +1884,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 			sizeof(adapter->fw_on_flash));
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1898,7 +1898,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 	struct be_cmd_req_modify_eq_delay *req;
 	int status = 0, i;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1921,7 +1921,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1948,7 +1948,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 	struct be_cmd_req_vlan_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1970,7 +1970,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1981,7 +1981,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 	struct be_cmd_req_rx_filter *req = mem->va;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2014,7 +2014,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2045,7 +2045,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2065,7 +2065,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (base_status(status) == MCC_STATUS_FEATURE_NOT_SUPPORTED)
 		return  -EOPNOTSUPP;
@@ -2084,7 +2084,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2107,7 +2107,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2188,7 +2188,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 	if (!(be_if_cap_flags(adapter) & BE_IF_FLAGS_RSS))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2213,7 +2213,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2225,7 +2225,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	struct be_cmd_req_enable_disable_beacon *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2246,7 +2246,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2257,7 +2257,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	struct be_cmd_req_get_beacon_state *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2281,7 +2281,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2305,7 +2305,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2327,7 +2327,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		memcpy(data, resp->page_data + off, len);
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
@@ -2344,7 +2344,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	void *ctxt = NULL;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2386,7 +2386,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(60000)))
@@ -2405,7 +2405,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2459,7 +2459,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2477,7 +2477,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2490,7 +2490,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	struct lancer_cmd_resp_read_object *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2524,7 +2524,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	}
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2536,7 +2536,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	struct be_cmd_write_flashrom *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2561,7 +2561,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(40000)))
@@ -2572,7 +2572,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2583,7 +2583,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2610,7 +2610,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 		memcpy(flashed_crc, req->crc, 4);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3216,7 +3216,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	struct be_cmd_req_acpi_wol_magic_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3233,7 +3233,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3248,7 +3248,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3271,7 +3271,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(SET_LB_MODE_TIMEOUT)))
@@ -3280,7 +3280,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3297,7 +3297,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3323,7 +3323,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 	if (status)
 		goto err;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	wait_for_completion(&adapter->et_cmd_compl);
 	resp = embedded_payload(wrb);
@@ -3331,7 +3331,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 
 	return status;
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3347,7 +3347,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3381,7 +3381,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3392,7 +3392,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	struct be_cmd_req_seeprom_read *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3408,7 +3408,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3423,7 +3423,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3468,7 +3468,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 	}
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3478,7 +3478,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	struct be_cmd_req_set_qos *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3498,7 +3498,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3610,7 +3610,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	struct be_cmd_req_get_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3642,7 +3642,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3654,7 +3654,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 	struct be_cmd_req_set_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3674,7 +3674,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3706,7 +3706,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3770,7 +3770,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 	}
 
 out:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_mac_list_cmd.size,
 			  get_mac_list_cmd.va, get_mac_list_cmd.dma);
 	return status;
@@ -3830,7 +3830,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	if (!cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3852,7 +3852,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 
 err:
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3888,7 +3888,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3929,7 +3929,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3943,7 +3943,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	int status;
 	u16 vid;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3990,7 +3990,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4189,7 +4189,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 	struct be_cmd_req_set_ext_fat_caps *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4205,7 +4205,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4683,7 +4683,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 	if (iface == 0xFFFFFFFF)
 		return -1;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4700,7 +4700,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4734,7 +4734,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	struct be_cmd_resp_get_iface_list *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4755,7 +4755,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4849,7 +4849,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	if (BEx_chip(adapter))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4867,7 +4867,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	req->enable = 1;
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4940,7 +4940,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 	u32 link_config = 0;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4968,7 +4968,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4999,8 +4999,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	if (mutex_lock_interruptible(&adapter->mcc_lock))
-		return -1;
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5038,7 +5037,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 		dev_info(&adapter->pdev->dev,
 			 "Adapter does not support HW error recovery\n");
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -5052,7 +5051,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	struct be_cmd_resp_hdr *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5075,7 +5074,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	memcpy(wrb_payload, resp, sizeof(*resp) + resp->response_length);
 	be_dws_le_to_cpu(wrb_payload, sizeof(*resp) + resp->response_length);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 EXPORT_SYMBOL(be_roce_mcc_cmd);
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 51dddf63d40f..4b9380003c85 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5803,8 +5803,8 @@ static int be_drv_init(struct be_adapter *adapter)
 	}
 
 	mutex_init(&adapter->mbox_lock);
-	mutex_init(&adapter->mcc_lock);
 	mutex_init(&adapter->rx_filter_lock);
+	spin_lock_init(&adapter->mcc_lock);
 	spin_lock_init(&adapter->mcc_cq_lock);
 	init_completion(&adapter->et_cmd_compl);
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f11824a078e9..5660a83356eb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -732,6 +732,8 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
 	int total_len, data_left;
 	struct bufdesc *bdp = txq->bd.cur;
+	struct bufdesc *tmp_bdp;
+	struct bufdesc_ex *ebdp;
 	struct tso_t tso;
 	unsigned int index = 0;
 	int ret;
@@ -805,7 +807,34 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
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
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 6122057d60c0..0f55444861cd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -318,7 +318,7 @@ static const struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
 		       MVPP2_PRS_RI_VLAN_MASK),
 	/* Non IP flow, with vlan tag */
 	MVPP2_DEF_FLOW(MVPP22_FLOW_ETHERNET, MVPP2_FL_NON_IP_TAG,
-		       MVPP22_CLS_HEK_OPT_VLAN,
+		       MVPP22_CLS_HEK_TAGGED,
 		       0, 0),
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
index 29e95d0a6ad1..5fa1b7c33c54 100644
--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
@@ -14,7 +14,6 @@
 #define MLXFW_FSM_STATE_WAIT_TIMEOUT_MS 30000
 #define MLXFW_FSM_STATE_WAIT_ROUNDS \
 	(MLXFW_FSM_STATE_WAIT_TIMEOUT_MS / MLXFW_FSM_STATE_WAIT_CYCLE_MS)
-#define MLXFW_FSM_MAX_COMPONENT_SIZE (10 * (1 << 20))
 
 static const char * const mlxfw_fsm_state_err_str[] = {
 	[MLXFW_FSM_STATE_ERR_ERROR] =
@@ -111,7 +110,6 @@ static int mlxfw_flash_component(struct mlxfw_dev *mlxfw_dev,
 	if (err)
 		return err;
 
-	comp_max_size = min_t(u32, comp_max_size, MLXFW_FSM_MAX_COMPONENT_SIZE);
 	if (comp->data_size > comp_max_size) {
 		pr_err("Component %d is of size %d which is bigger than limit %d\n",
 		       comp->index, comp->data_size, comp_max_size);
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
index 2ec62c8d86e1..59486fe2ad18 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
@@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
 	struct sk_buff *skb;
 
 	skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
 	skb_put(skb, size);
 
 	return skb;
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 50d85d037230..f808e60b4ee4 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3496,10 +3496,12 @@ static int sh_eth_suspend(struct device *dev)
 
 	netif_device_detach(ndev);
 
+	rtnl_lock();
 	if (mdp->wol_enabled)
 		ret = sh_eth_wol_setup(ndev);
 	else
 		ret = sh_eth_close(ndev);
+	rtnl_unlock();
 
 	return ret;
 }
@@ -3513,10 +3515,12 @@ static int sh_eth_resume(struct device *dev)
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
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 961cbd2b377d..8fa466b87938 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1867,21 +1867,9 @@ static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_dev *geneve, *next;
-	struct net_device *dev, *aux;
 
-	/* gather any geneve devices that were moved into this ns */
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &geneve_link_ops)
-			unregister_netdevice_queue(dev, head);
-
-	/* now gather any other geneve devices that were created in this ns */
-	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next) {
-		/* If geneve->dev is in the same netns, it was already added
-		 * to the list by the previous loop.
-		 */
-		if (!net_eq(dev_net(geneve->dev), net))
-			unregister_netdevice_queue(geneve->dev, head);
-	}
+	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
+		geneve_dellink(geneve->dev, head);
 }
 
 static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 68698457add0..fa43b0f26bfb 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1366,11 +1366,6 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
-		struct net_device *dev;
-
-		for_each_netdev(net, dev)
-			if (dev->rtnl_link_ops == &gtp_link_ops)
-				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 7788f72c262e..1dd5044cc643 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -241,8 +241,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int blackhole_neigh_construct(struct net_device *dev,
+				     struct neighbour *n)
+{
+	n->output = blackhole_neigh_output;
+	return 0;
+}
+
 static const struct net_device_ops blackhole_netdev_ops = {
 	.ndo_start_xmit = blackhole_netdev_xmit,
+	.ndo_neigh_construct = blackhole_neigh_construct,
 };
 
 /* This is a dst-dummy device used specifically for invalidated
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 3cd4196b36b2..7b9337e16d6e 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,17 @@
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
 
+/* The filter instructions generated by libpcap are constructed
+ * assuming a four-byte PPP header on each packet, where the last
+ * 2 bytes are the protocol field defined in the RFC and the first
+ * byte of the first 2 bytes indicates the direction.
+ * The second byte is currently unused, but we still need to initialize
+ * it to prevent crafted BPF programs from reading them which would
+ * cause reading of uninitialized data.
+ */
+#define PPP_FILTER_OUTBOUND_TAG 0x0100
+#define PPP_FILTER_INBOUND_TAG  0x0000
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -1541,10 +1552,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* check if the packet passes the pass and active filters.
+		 * See comment for PPP_FILTER_OUTBOUND_TAG above.
+		 */
+		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    BPF_PROG_RUN(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2223,14 +2234,13 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* network protocol frame - give it to the kernel */
 
 #ifdef CONFIG_PPP_FILTER
-		/* check if the packet passes the pass and active filters */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
 		if (ppp->pass_filter || ppp->active_filter) {
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
-
-			*(u8 *)skb_push(skb, 2) = 0;
+			/* Check if the packet passes the pass and active filters.
+			 * See comment for PPP_FILTER_INBOUND_TAG above.
+			 */
+			*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
 			if (ppp->pass_filter &&
 			    BPF_PROG_RUN(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 56caff2d01c4..197aea66b30d 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1165,6 +1165,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
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
@@ -2656,7 +2663,9 @@ static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
 				ctx.data.u32_val = nla_get_u32(attr_data);
 				break;
 			case TEAM_OPTION_TYPE_STRING:
-				if (nla_len(attr_data) > TEAM_STRING_MAX_LEN) {
+				if (nla_len(attr_data) > TEAM_STRING_MAX_LEN ||
+				    !memchr(nla_data(attr_data), '\0',
+					    nla_len(attr_data))) {
 					err = -EINVAL;
 					goto team_put;
 				}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0adce9bf7a1e..1a6b4cdc3bd5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -642,7 +642,7 @@ static inline bool tun_not_capable(struct tun_struct *tun)
 	struct net *net = dev_net(tun->dev);
 
 	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
-		  (gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
+		(gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
 		!ns_capable(net->user_ns, CAP_NET_ADMIN);
 }
 
diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 13a9a83b8538..8c2838cba77b 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -179,9 +179,7 @@ static int genelink_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	dev->hard_mtu = GL_RCV_BUF_SIZE;
 	dev->net->hard_header_len += 4;
-	dev->in = usb_rcvbulkpipe(dev->udev, dev->driver_info->in);
-	dev->out = usb_sndbulkpipe(dev->udev, dev->driver_info->out);
-	return 0;
+	return usbnet_get_endpoints(dev, intf);
 }
 
 static const struct driver_info	genelink_info = {
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 387091cb9134..3829b7eb3fc9 100644
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
@@ -597,9 +605,9 @@ static void free_skb_pool(rtl8150_t *dev)
 		dev_kfree_skb(dev->rx_skb_pool[i]);
 }
 
-static void rx_fixup(unsigned long data)
+static void rx_fixup(struct tasklet_struct *t)
 {
-	struct rtl8150 *dev = (struct rtl8150 *)data;
+	struct rtl8150 *dev = from_tasklet(dev, t, tl);
 	struct sk_buff *skb;
 	int status;
 
@@ -886,6 +894,13 @@ static int rtl8150_probe(struct usb_interface *intf,
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
@@ -899,7 +914,14 @@ static int rtl8150_probe(struct usb_interface *intf,
 		return -ENOMEM;
 	}
 
-	tasklet_init(&dev->tl, rx_fixup, (unsigned long)dev);
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(&intf->dev, "couldn't find required endpoints\n");
+		goto out;
+	}
+
+	tasklet_setup(&dev->tl, rx_fixup);
 	spin_lock_init(&dev->rx_pool_lock);
 
 	dev->udev = udev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 4907a667f963..946b7a99e7c9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -538,6 +538,11 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
 	struct ethhdr *eh;
 	u16 type;
 
+	if (!ifp) {
+		brcmu_pkt_buf_free_skb(txp);
+		return;
+	}
+
 	eh = (struct ethhdr *)(txp->data);
 	type = ntohs(eh->h_proto);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index a3f094568cfb..90ae800cbccd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -23445,6 +23445,9 @@ wlc_phy_iqcal_gainparams_nphy(struct brcms_phy *pi, u16 core_no,
 			}
 		}
 
+		if (WARN_ON(k == NPHY_IQCAL_NUMGAINS))
+			return;
+
 		params->txgm = tbl_iqcal_gainparams_nphy[band_idx][k][1];
 		params->pga = tbl_iqcal_gainparams_nphy[band_idx][k][2];
 		params->pad = tbl_iqcal_gainparams_nphy[band_idx][k][3];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 9e63230da1ec..03de1ca54c94 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1113,7 +1113,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
 				 fseq_ver->version);
 			}
 			break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 8fb0b54738ca..c98aeb1b824d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -448,8 +448,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	/* <1> timer */
 	timer_setup(&rtlpriv->works.watchdog_timer,
 		    rtl_watch_dog_timer_callback, 0);
-	timer_setup(&rtlpriv->works.dualmac_easyconcurrent_retrytimer,
-		    rtl_easy_concurrent_retrytimer_callback, 0);
+
 	/* <2> work queue */
 	rtlpriv->works.hw = hw;
 	rtlpriv->works.rtl_wq = wq;
@@ -1995,8 +1994,7 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	unsigned long flags;
 
-	struct rtl_bssid_entry *entry;
-	bool entry_found = false;
+	struct rtl_bssid_entry *entry = NULL, *iter;
 
 	/* check if it is scanning */
 	if (!mac->act_scanning)
@@ -2009,10 +2007,10 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 
 	spin_lock_irqsave(&rtlpriv->locks.scan_list_lock, flags);
 
-	list_for_each_entry(entry, &rtlpriv->scan_list.list, list) {
-		if (memcmp(entry->bssid, hdr->addr3, ETH_ALEN) == 0) {
-			list_del_init(&entry->list);
-			entry_found = true;
+	list_for_each_entry(iter, &rtlpriv->scan_list.list, list) {
+		if (memcmp(iter->bssid, hdr->addr3, ETH_ALEN) == 0) {
+			list_del_init(&iter->list);
+			entry = iter;
 			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
 				"Update BSSID=%pM to scan list (total=%d)\n",
 				hdr->addr3, rtlpriv->scan_list.num);
@@ -2020,7 +2018,7 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 		}
 	}
 
-	if (!entry_found) {
+	if (!entry) {
 		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 
 		if (!entry)
@@ -2379,19 +2377,6 @@ void rtl_c2hcmd_wq_callback(void *data)
 	rtl_c2hcmd_launcher(hw, 1);
 }
 
-void rtl_easy_concurrent_retrytimer_callback(struct timer_list *t)
-{
-	struct rtl_priv *rtlpriv =
-		from_timer(rtlpriv, t, works.dualmac_easyconcurrent_retrytimer);
-	struct ieee80211_hw *hw = rtlpriv->hw;
-	struct rtl_priv *buddy_priv = rtlpriv->buddy_priv;
-
-	if (buddy_priv == NULL)
-		return;
-
-	rtlpriv->cfg->ops->dualmac_easy_concurrent(hw);
-}
-
 /*********************************************************
  *
  * frame process functions
@@ -2737,9 +2722,6 @@ MODULE_AUTHOR("Larry Finger	<Larry.FInger@lwfinger.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 802.11n PCI wireless core");
 
-struct rtl_global_var rtl_global_var = {};
-EXPORT_SYMBOL_GPL(rtl_global_var);
-
 static int __init rtl_core_module_init(void)
 {
 	BUILD_BUG_ON(TX_PWR_BY_RATE_NUM_RATE < TX_PWR_BY_RATE_NUM_SECTION);
@@ -2753,10 +2735,6 @@ static int __init rtl_core_module_init(void)
 	/* add debugfs */
 	rtl_debugfs_add_topdir();
 
-	/* init some global vars */
-	INIT_LIST_HEAD(&rtl_global_var.glb_priv_list);
-	spin_lock_init(&rtl_global_var.glb_list_lock);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index e4a7e074ae3f..f24908642ea9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -127,8 +127,6 @@ int rtl_send_smps_action(struct ieee80211_hw *hw,
 u8 *rtl_find_ie(u8 *data, unsigned int len, u8 ie);
 void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len);
 u8 rtl_tid_to_ac(u8 tid);
-void rtl_easy_concurrent_retrytimer_callback(struct timer_list *t);
-extern struct rtl_global_var rtl_global_var;
 void rtl_phy_scan_operation_backup(struct ieee80211_hw *hw, u8 operation);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 1c77b3b2173c..b16b1f1fb1e0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -295,47 +295,6 @@ static bool rtl_pci_get_amd_l1_patch(struct ieee80211_hw *hw)
 	return status;
 }
 
-static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
-				     struct rtl_priv **buddy_priv)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
-	bool find_buddy_priv = false;
-	struct rtl_priv *tpriv;
-	struct rtl_pci_priv *tpcipriv = NULL;
-
-	if (!list_empty(&rtlpriv->glb_var->glb_priv_list)) {
-		list_for_each_entry(tpriv, &rtlpriv->glb_var->glb_priv_list,
-				    list) {
-			tpcipriv = (struct rtl_pci_priv *)tpriv->priv;
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
-				find_buddy_priv = true;
-				break;
-			}
-		}
-	}
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"find_buddy_priv %d\n", find_buddy_priv);
-
-	if (find_buddy_priv)
-		*buddy_priv = tpriv;
-
-	return find_buddy_priv;
-}
-
 static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 					struct ieee80211_hw *hw)
 {
@@ -444,11 +403,6 @@ static void _rtl_pci_tx_chk_waitq(struct ieee80211_hw *hw)
 	if (!rtlpriv->rtlhal.earlymode_enable)
 		return;
 
-	if (rtlpriv->dm.supp_phymode_switch &&
-	    (rtlpriv->easy_concurrent_ctl.switch_in_process ||
-	    (rtlpriv->buddy_priv &&
-	    rtlpriv->buddy_priv->easy_concurrent_ctl.switch_in_process)))
-		return;
 	/* we just use em for BE/BK/VI/VO */
 	for (tid = 7; tid >= 0; tid--) {
 		u8 hw_queue = ac_to_hwq[rtl_tid_to_ac(tid)];
@@ -2027,7 +1981,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
-	list_add_tail(&rtlpriv->list, &rtlpriv->glb_var->glb_priv_list);
 
 	return true;
 }
@@ -2174,7 +2127,6 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	rtlpriv->rtlhal.interface = INTF_PCI;
 	rtlpriv->cfg = (struct rtl_hal_cfg *)(id->driver_data);
 	rtlpriv->intf_ops = &rtl_pci_ops;
-	rtlpriv->glb_var = &rtl_global_var;
 	rtl_efuse_ops_init(hw);
 
 	/* MEM map */
@@ -2225,7 +2177,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
 		pr_err("Can't init_sw_vars\n");
 		err = -ENODEV;
-		goto fail3;
+		goto fail2;
 	}
 	rtlpriv->cfg->ops->init_sw_leds(hw);
 
@@ -2243,14 +2195,14 @@ int rtl_pci_probe(struct pci_dev *pdev,
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
 
@@ -2273,16 +2225,19 @@ int rtl_pci_probe(struct pci_dev *pdev,
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
@@ -2333,7 +2288,6 @@ void rtl_pci_disconnect(struct pci_dev *pdev)
 	if (rtlpci->using_msi)
 		pci_disable_msi(rtlpci->pdev);
 
-	list_del(&rtlpriv->list);
 	if (rtlpriv->io.pci_mem_start != 0) {
 		pci_iounmap(pdev, (void __iomem *)rtlpriv->io.pci_mem_start);
 		pci_release_regions(pdev);
@@ -2393,7 +2347,6 @@ const struct rtl_intf_ops rtl_pci_ops = {
 	.read_efuse_byte = read_efuse_byte,
 	.adapter_start = rtl_pci_start,
 	.adapter_stop = rtl_pci_stop,
-	.check_buddy_priv = rtl_pci_check_buddy_priv,
 	.adapter_tx = rtl_pci_tx,
 	.flush = rtl_pci_flush,
 	.reset_trx_ring = rtl_pci_reset_trx_ring,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c
index a6e4384ceea1..5fce3db52cd9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c
@@ -144,10 +144,10 @@ static void _rtl92s_dm_txpowertracking_callback_thermalmeter(
 
 	thermalvalue = (u8)rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0x1f);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermal meter 0x%x\n",
-		 thermalvalue,
-		 rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermal meter 0x%x\n",
+		thermalvalue,
+		rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
 
 	if (thermalvalue) {
 		rtlpriv->dm.thermalvalue = thermalvalue;
@@ -158,8 +158,8 @@ static void _rtl92s_dm_txpowertracking_callback_thermalmeter(
 				 (rtlpriv->efuse.thermalmeter[0] << 8) |
 				 (thermalvalue << 16));
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Write to FW Thermal Val = 0x%x\n", fw_cmd);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Write to FW Thermal Val = 0x%x\n", fw_cmd);
 
 			rtl_write_dword(rtlpriv, WFM5, fw_cmd);
 			rtl92s_phy_chk_fwcmd_iodone(hw);
@@ -264,10 +264,10 @@ static void _rtl92s_dm_refresh_rateadaptive_mask(struct ieee80211_hw *hw)
 		}
 
 		if (ra->pre_ratr_state != ra->ratr_state) {
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI = %ld RSSI_LEVEL = %d PreState = %d, CurState = %d\n",
-				 rtlpriv->dm.undec_sm_pwdb, ra->ratr_state,
-				 ra->pre_ratr_state, ra->ratr_state);
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"RSSI = %ld RSSI_LEVEL = %d PreState = %d, CurState = %d\n",
+				rtlpriv->dm.undec_sm_pwdb, ra->ratr_state,
+				ra->pre_ratr_state, ra->ratr_state);
 
 			rcu_read_lock();
 			sta = rtl_find_sta(hw, mac->bssid);
@@ -576,8 +576,8 @@ static void _rtl92s_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TX_HIGHPWR_LEVEL_NORMAL;
 
@@ -588,21 +588,21 @@ static void _rtl92s_dm_dynamic_txpower(struct ieee80211_hw *hw)
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb = rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-				 undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb = rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%lx\n",
-				 undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"STA Default Port PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		}
 	} else {
 		undec_sm_pwdb = rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "AP Ext Port PWDB = 0x%lx\n",
-			 undec_sm_pwdb);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"AP Ext Port PWDB = 0x%lx\n",
+			undec_sm_pwdb);
 	}
 
 	txpwr_threshold_lv2 = TX_POWER_NEAR_FIELD_THRESH_LVL2;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
index 541b7881735e..61bc3a384fda 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
@@ -39,8 +39,8 @@ static bool _rtl92s_firmware_enable_cpu(struct ieee80211_hw *hw)
 	do {
 		cpustatus = rtl_read_byte(rtlpriv, TCR);
 		if (cpustatus & IMEM_RDY) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "IMEM Ready after CPU has refilled\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"IMEM Ready after CPU has refilled\n");
 			break;
 		}
 
@@ -195,8 +195,8 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 	short pollingcnt = 1000;
 	bool rtstatus = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "LoadStaus(%d)\n", loadfw_status);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"LoadStaus(%d)\n", loadfw_status);
 
 	firmware->fwstatus = (enum fw_status)loadfw_status;
 
@@ -256,9 +256,9 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 			goto status_check_fail;
 		}
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "DMEM code download success, cpustatus(%#x)\n",
-			 cpustatus);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"DMEM code download success, cpustatus(%#x)\n",
+			cpustatus);
 
 		/* Prevent Delay too much and being scheduled out */
 		/* Polling Load Firmware ready */
@@ -270,9 +270,9 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 			udelay(40);
 		} while (pollingcnt--);
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Polling Load Firmware ready, cpustatus(%x)\n",
-			 cpustatus);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Polling Load Firmware ready, cpustatus(%x)\n",
+			cpustatus);
 
 		if (((cpustatus & LOAD_FW_READY) != LOAD_FW_READY) ||
 		    (pollingcnt <= 0)) {
@@ -290,8 +290,8 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 		rtl_write_dword(rtlpriv, RCR, (tmpu4b | RCR_APPFCS |
 				RCR_APP_ICV | RCR_APP_MIC));
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Current RCR settings(%#x)\n", tmpu4b);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Current RCR settings(%#x)\n", tmpu4b);
 
 		/* Set to normal mode. */
 		rtl_write_byte(rtlpriv, LBKMD_SEL, LBK_NORMAL);
@@ -304,9 +304,9 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 	}
 
 status_check_fail:
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "loadfw_status(%d), rtstatus(%x)\n",
-		 loadfw_status, rtstatus);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"loadfw_status(%d), rtstatus(%x)\n",
+		loadfw_status, rtstatus);
 	return rtstatus;
 }
 
@@ -337,11 +337,11 @@ int rtl92s_download_fw(struct ieee80211_hw *hw)
 	firmware->firmwareversion =  byte(pfwheader->version, 0);
 	firmware->pfwheader->fwpriv.hci_sel = 1;/* pcie */
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "signature:%x, version:%x, size:%x, imemsize:%x, sram size:%x\n",
-		 pfwheader->signature,
-		 pfwheader->version, pfwheader->dmem_size,
-		 pfwheader->img_imem_size, pfwheader->img_sram_size);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"signature:%x, version:%x, size:%x, imemsize:%x, sram size:%x\n",
+		pfwheader->signature,
+		pfwheader->version, pfwheader->dmem_size,
+		pfwheader->img_imem_size, pfwheader->img_sram_size);
 
 	/* 2. Retrieve IMEM image. */
 	if ((pfwheader->img_imem_size == 0) || (pfwheader->img_imem_size >
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
index 6d6e8994460d..b04f5595414a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
@@ -111,8 +111,8 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 			u8 e_aci;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "HW_VAR_SLOT_TIME %x\n", val[0]);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 			rtl_write_byte(rtlpriv, SLOT_TIME, val[0]);
 
@@ -156,9 +156,9 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 				*val = min_spacing_to_set;
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-					 mac->min_space_cfg);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+					mac->min_space_cfg);
 
 				rtl_write_byte(rtlpriv, AMPDU_MIN_SPACE,
 					       mac->min_space_cfg);
@@ -172,9 +172,9 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			mac->min_space_cfg = rtlpriv->rtlhal.minspace_cfg;
 			mac->min_space_cfg |= (density_to_set << 3);
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-				 mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+				mac->min_space_cfg);
 
 			rtl_write_byte(rtlpriv, AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
@@ -215,9 +215,9 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					    (factorlevel[17] << 4));
 				rtl_write_byte(rtlpriv, AGGLEN_LMT_H, regtoset);
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
-					 factor_toset);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+					factor_toset);
 			}
 			break;
 		}
@@ -253,9 +253,9 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					acm_ctrl |= ACMHW_VOQEN;
 					break;
 				default:
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
-						 acm);
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
+						acm);
 					break;
 				}
 			} else {
@@ -276,8 +276,8 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				}
 			}
 
-			RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
-				 "HW_VAR_ACM_CTRL Write 0x%X\n", acm_ctrl);
+			rtl_dbg(rtlpriv, COMP_QOS, DBG_TRACE,
+				"HW_VAR_ACM_CTRL Write 0x%X\n", acm_ctrl);
 			rtl_write_byte(rtlpriv, ACMHWCTRL, acm_ctrl);
 			break;
 		}
@@ -417,14 +417,14 @@ void rtl92se_enable_hw_security_config(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value = 0x0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
-		 rtlpriv->sec.pairwise_enc_algorithm,
-		 rtlpriv->sec.group_enc_algorithm);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
+		rtlpriv->sec.pairwise_enc_algorithm,
+		rtlpriv->sec.group_enc_algorithm);
 
 	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-			 "not open hw encryption\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"not open hw encryption\n");
 		return;
 	}
 
@@ -435,8 +435,8 @@ void rtl92se_enable_hw_security_config(struct ieee80211_hw *hw)
 		sec_reg_value |= SCR_RXUSEDK;
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD, "The SECR-value %x\n",
-		 sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD, "The SECR-value %x\n",
+		sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 
@@ -870,10 +870,10 @@ static void _rtl92se_macconfig_after_fwdownload(struct ieee80211_hw *hw)
 
 		/* Change Program timing */
 		rtl_write_byte(rtlpriv, REG_EFUSE_CTRL + 3, 0x72);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "EFUSE CONFIG OK\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "EFUSE CONFIG OK\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "OK\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "OK\n");
 
 }
 
@@ -960,9 +960,8 @@ int rtl92se_hw_init(struct ieee80211_hw *hw)
 	/* 2. download firmware */
 	rtstatus = rtl92s_download_fw(hw);
 	if (!rtstatus) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now... "
-			 "Please copy FW into /lib/firmware/rtlwifi\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now... Please copy FW into /lib/firmware/rtlwifi\n");
 		err = 1;
 		goto exit;
 	}
@@ -1014,7 +1013,7 @@ int rtl92se_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, RF_CTRL, 0x07);
 
 	if (!rtl92s_phy_rf_config(hw)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "RF Config failed\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "RF Config failed\n");
 		err = rtstatus;
 		goto exit;
 	}
@@ -1147,23 +1146,23 @@ static int _rtl92se_set_media_status(struct ieee80211_hw *hw,
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		bt_msr |= (MSR_LINK_NONE << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to NO LINK!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		bt_msr |= (MSR_LINK_ADHOC << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to Ad Hoc!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		bt_msr |= (MSR_LINK_MANAGED << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to STA!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		bt_msr |= (MSR_LINK_MASTER << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to AP!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to AP!\n");
 		break;
 	default:
 		pr_err("Network type %d not supported!\n", type);
@@ -1606,8 +1605,8 @@ void rtl92se_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
-		 add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
+		add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1671,11 +1670,11 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 
 	eeprom_id = *((u16 *)&hwinfo[0]);
 	if (eeprom_id != RTL8190_EEPROM_ID) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "EEPROM ID(%#x) is invalid!!\n", eeprom_id);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"EEPROM ID(%#x) is invalid!!\n", eeprom_id);
 		rtlefuse->autoload_failflag = true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 	}
 
@@ -1692,16 +1691,16 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 	rtlefuse->eeprom_smid = *(u16 *)&hwinfo[EEPROM_SMID];
 	rtlefuse->eeprom_version = *(u16 *)&hwinfo[EEPROM_VERSION];
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROMId = 0x%4x\n", eeprom_id);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM VID = 0x%4x\n", rtlefuse->eeprom_vid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM DID = 0x%4x\n", rtlefuse->eeprom_did);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM SVID = 0x%4x\n", rtlefuse->eeprom_svid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM SMID = 0x%4x\n", rtlefuse->eeprom_smid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROMId = 0x%4x\n", eeprom_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM VID = 0x%4x\n", rtlefuse->eeprom_vid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM DID = 0x%4x\n", rtlefuse->eeprom_did);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM SVID = 0x%4x\n", rtlefuse->eeprom_svid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM SMID = 0x%4x\n", rtlefuse->eeprom_smid);
 
 	for (i = 0; i < 6; i += 2) {
 		usvalue = *(u16 *)&hwinfo[EEPROM_MAC_ADDR + i];
@@ -1711,7 +1710,7 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 	for (i = 0; i < 6; i++)
 		rtl_write_byte(rtlpriv, MACIDR0 + i, rtlefuse->dev_addr[i]);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
 
 	/* Get Tx Power Level by Channel */
 	/* Read Tx power of Channel 1 ~ 14 from EEPROM. */
@@ -1964,15 +1963,15 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 		tempval = rtl_read_byte(rtlpriv, 0x07);
 		if (!(tempval & BIT(0))) {
 			rtlefuse->b1x1_recvcombine = true;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "RF_TYPE=1T2R but only 1SS\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"RF_TYPE=1T2R but only 1SS\n");
 		}
 	}
 	rtlefuse->b1ss_support = rtlefuse->b1x1_recvcombine;
 	rtlefuse->eeprom_oemid = *&hwinfo[EEPROM_CUSTOMID];
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "EEPROM Customer ID: 0x%2x\n",
-		 rtlefuse->eeprom_oemid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "EEPROM Customer ID: 0x%2x\n",
+		rtlefuse->eeprom_oemid);
 
 	/* set channel paln to world wide 13 */
 	rtlefuse->channel_plan = COUNTRY_CODE_WORLD_WIDE_13;
@@ -1987,15 +1986,15 @@ void rtl92se_read_eeprom_info(struct ieee80211_hw *hw)
 	tmp_u1b = rtl_read_byte(rtlpriv, EPROM_CMD);
 
 	if (tmp_u1b & BIT(4)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
 		rtlefuse->epromtype = EEPROM_93C46;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
 		rtlefuse->epromtype = EEPROM_BOOT_EFUSE;
 	}
 
 	if (tmp_u1b & BIT(5)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 		_rtl92se_read_adapter_info(hw);
 	} else {
@@ -2101,8 +2100,8 @@ static void rtl92se_update_hal_rate_table(struct ieee80211_hw *hw,
 	else
 		rtl92s_phy_set_fw_cmd(hw, FW_CMD_RA_REFRESH_BG);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
-		 rtl_read_dword(rtlpriv, ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+		rtl_read_dword(rtlpriv, ARFR0));
 }
 
 static void rtl92se_update_hal_rate_mask(struct ieee80211_hw *hw,
@@ -2256,8 +2255,8 @@ static void rtl92se_update_hal_rate_mask(struct ieee80211_hw *hw,
 
 	mask |= (bmulticast ? 1 : 0) << 9 | (macid & 0x1f) << 4 | (band & 0xf);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_TRACE, "mask = %x, bitmap = %x\n",
-		 mask, ratr_bitmap);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_TRACE, "mask = %x, bitmap = %x\n",
+		mask, ratr_bitmap);
 	rtl_write_dword(rtlpriv, 0x2c4, ratr_bitmap);
 	rtl_write_dword(rtlpriv, WFM5, (FW_RA_UPDATE_MASK | (mask << 8)));
 
@@ -2332,15 +2331,15 @@ bool rtl92se_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	rfpwr_toset = _rtl92se_rf_onoff_detect(hw);
 
 	if ((ppsc->hwradiooff) && (rfpwr_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "RFKILL-HW Radio ON, RF ON\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"RFKILL-HW Radio ON, RF ON\n");
 
 		rfpwr_toset = ERFON;
 		ppsc->hwradiooff = false;
 		actuallyset = true;
 	} else if ((!ppsc->hwradiooff) && (rfpwr_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF,
-			 DBG_DMESG, "RFKILL-HW Radio OFF, RF OFF\n");
+		rtl_dbg(rtlpriv, COMP_RF,
+			DBG_DMESG, "RFKILL-HW Radio OFF, RF OFF\n");
 
 		rfpwr_toset = ERFOFF;
 		ppsc->hwradiooff = true;
@@ -2404,7 +2403,7 @@ void rtl92se_set_key(struct ieee80211_hw *hw, u32 key_index, u8 *p_macaddr,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2463,26 +2462,26 @@ void rtl92se_set_key(struct ieee80211_hw *hw, u32 key_index, u8 *p_macaddr,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "delete one entry, entry_id is %d\n",
-				 entry_id);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"delete one entry, entry_id is %d\n",
+				entry_id);
 			if (mac->opmode == NL80211_IFTYPE_AP)
 				rtl_cam_del_entry(hw, p_macaddr);
 			rtl_cam_delete_one_entry(hw, p_macaddr, entry_id);
 		} else {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "add one entry\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"add one entry\n");
 			if (is_pairwise) {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set Pairwise key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set Pairwise key\n");
 
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
 					entry_id, enc_algo,
 					CAM_CONFIG_NO_USEDK,
 					rtlpriv->sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set group key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set group key\n");
 
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 					rtl_cam_add_one_entry(hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
index 2d18bc1ee480..ecbf425f679f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
@@ -27,8 +27,8 @@ void rtl92se_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 LEDCFG, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		LEDCFG, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, LEDCFG);
 
@@ -57,8 +57,8 @@ void rtl92se_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	rtlpriv = rtl_priv(hw);
 	if (!rtlpriv || rtlpriv->max_fw_size)
 		return;
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 LEDCFG, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		LEDCFG, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, LEDCFG);
 
@@ -119,7 +119,7 @@ void rtl92se_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
 	    ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
 
 	_rtl92se_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
index f377531bc2bd..cd735d61f630 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
@@ -19,15 +19,15 @@ u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue = 0, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
-		 regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
+		regaddr, bitmask);
 
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
-		 bitmask, regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+		bitmask, regaddr, originalvalue);
 
 	return returnvalue;
 
@@ -39,9 +39,9 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
@@ -51,9 +51,9 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 
 }
 
@@ -111,8 +111,8 @@ static u32 _rtl92s_phy_rf_serial_read(struct ieee80211_hw *hw,
 	retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 				 BLSSI_READBACK_DATA);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf_rb, retvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf_rb, retvalue);
 
 	return retvalue;
 
@@ -134,8 +134,8 @@ static void _rtl92s_phy_rf_serial_write(struct ieee80211_hw *hw,
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
 
@@ -145,8 +145,8 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
@@ -158,9 +158,9 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		 regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 
 	return readback_value;
 }
@@ -175,9 +175,9 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	if (!((rtlphy->rf_pathmap >> rfpath) & 0x1))
 		return;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -192,9 +192,9 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 }
 
@@ -227,9 +227,9 @@ void rtl92s_phy_set_bw_mode(struct ieee80211_hw *hw,
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u8 reg_bw_opmode;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
-		 rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
-		 "20MHz" : "40MHz");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
+		rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
+		"20MHz" : "40MHz");
 
 	if (rtlphy->set_bwmode_inprogress)
 		return;
@@ -284,7 +284,7 @@ void rtl92s_phy_set_bw_mode(struct ieee80211_hw *hw,
 
 	rtl92s_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 }
 
 static bool _rtl92s_phy_set_sw_chnl_cmdarray(struct swchnlcmd *cmdtable,
@@ -422,8 +422,8 @@ u8 rtl92s_phy_sw_chnl(struct ieee80211_hw *hw)
 	u32 delay;
 	bool ret;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "switch to channel%d\n",
-		 rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "switch to channel%d\n",
+		rtlphy->current_channel);
 
 	if (rtlphy->sw_chnl_inprogress)
 		return 0;
@@ -459,7 +459,7 @@ u8 rtl92s_phy_sw_chnl(struct ieee80211_hw *hw)
 
 	rtlphy->sw_chnl_inprogress = false;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 
 	return 1;
 }
@@ -518,20 +518,19 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				u32 initializecount = 0;
 				do {
 					initializecount++;
-					RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-						 "IPS Set eRf nic enable\n");
+					rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+						"IPS Set eRf nic enable\n");
 					rtstatus = rtl_ps_enable_nic(hw);
 				} while (!rtstatus && (initializecount < 10));
 
 				RT_CLEAR_PS_LEVEL(ppsc,
 						  RT_RF_OFF_LEVL_HALT_NIC);
 			} else {
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-					 "awake, sleeped:%d ms state_inap:%x\n",
-					 jiffies_to_msecs(jiffies -
-							  ppsc->
-							  last_sleep_jiffies),
-					 rtlpriv->psc.state_inap);
+				rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+					"awake, slept:%d ms state_inap:%x\n",
+					jiffies_to_msecs(jiffies -
+					ppsc->last_sleep_jiffies),
+					rtlpriv->psc.state_inap);
 				ppsc->last_awake_jiffies = jiffies;
 				rtl_write_word(rtlpriv, CMDR, 0x37FC);
 				rtl_write_byte(rtlpriv, TXPAUSE, 0x00);
@@ -548,8 +547,8 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		}
 	case ERFOFF:{
 			if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "IPS Set eRf nic disable\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic disable\n");
 				rtl_ps_disable_nic(hw);
 				RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
 			} else {
@@ -574,34 +573,34 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					queue_id++;
 					continue;
 				} else {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] = %d before doze!\n",
-						 i + 1, queue_id,
-						 skb_queue_len(&ring->queue));
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"eRf Off/Sleep: %d times TcbBusyQueue[%d] = %d before doze!\n",
+						i + 1, queue_id,
+						skb_queue_len(&ring->queue));
 
 					udelay(10);
 					i++;
 				}
 
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
-						 MAX_DOZE_WAITING_TIMES_9x,
-						 queue_id,
-						 skb_queue_len(&ring->queue));
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
+						MAX_DOZE_WAITING_TIMES_9x,
+						queue_id,
+						skb_queue_len(&ring->queue));
 					break;
 				}
 			}
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-				 "Set ERFSLEEP awaked:%d ms\n",
-				 jiffies_to_msecs(jiffies -
-						  ppsc->last_awake_jiffies));
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+				"Set ERFSLEEP awaked:%d ms\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_awake_jiffies));
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-				 "sleep awaked:%d ms state_inap:%x\n",
-				 jiffies_to_msecs(jiffies -
-						  ppsc->last_awake_jiffies),
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+				"sleep awaked:%d ms state_inap:%x\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_awake_jiffies),
 				 rtlpriv->psc.state_inap);
 			ppsc->last_sleep_jiffies = jiffies;
 			_rtl92se_phy_set_rf_sleep(hw);
@@ -956,7 +955,7 @@ u8 rtl92s_phy_config_rf(struct ieee80211_hw *hw, enum radio_path rfpath)
 		radio_b_tblen = RADIOB_ARRAYLENGTH;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	rtstatus = true;
 
 	switch (rfpath) {
@@ -1076,20 +1075,20 @@ void rtl92s_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 			ROFDM0_XCAGCCORE1, MASKBYTE0);
 	rtlphy->default_initialgain[3] = rtl_get_bbreg(hw,
 			ROFDM0_XDAGCCORE1, MASKBYTE0);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x)\n",
-		 rtlphy->default_initialgain[0],
-		 rtlphy->default_initialgain[1],
-		 rtlphy->default_initialgain[2],
-		 rtlphy->default_initialgain[3]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x)\n",
+		rtlphy->default_initialgain[0],
+		rtlphy->default_initialgain[1],
+		rtlphy->default_initialgain[2],
+		rtlphy->default_initialgain[3]);
 
 	/* read framesync */
 	rtlphy->framesync = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3, MASKBYTE0);
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
 					      MASKDWORD);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Default framesync (0x%x) = 0x%x\n",
-		 ROFDM0_RXDETECTOR3, rtlphy->framesync);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Default framesync (0x%x) = 0x%x\n",
+		ROFDM0_RXDETECTOR3, rtlphy->framesync);
 
 }
 
@@ -1151,10 +1150,10 @@ void rtl92s_phy_set_txpower(struct ieee80211_hw *hw, u8	channel)
 	_rtl92s_phy_get_txpower_index(hw, channel, &cckpowerlevel[0],
 			&ofdmpowerlevel[0]);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-		 "Channel-%d, cckPowerLevel (A / B) = 0x%x / 0x%x, ofdmPowerLevel (A / B) = 0x%x / 0x%x\n",
-		 channel, cckpowerlevel[0], cckpowerlevel[1],
-		 ofdmpowerlevel[0], ofdmpowerlevel[1]);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+		"Channel-%d, cckPowerLevel (A / B) = 0x%x / 0x%x, ofdmPowerLevel (A / B) = 0x%x / 0x%x\n",
+		channel, cckpowerlevel[0], cckpowerlevel[1],
+		ofdmpowerlevel[0], ofdmpowerlevel[1]);
 
 	_rtl92s_phy_ccxpower_indexcheck(hw, channel, &cckpowerlevel[0],
 			&ofdmpowerlevel[0]);
@@ -1212,17 +1211,17 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 skip:
 	switch (rtlhal->current_fwcmd_io) {
 	case FW_CMD_RA_RESET:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_RESET\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_RESET\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_RESET);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_ACTIVE:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_ACTIVE\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_ACTIVE\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_ACTIVE);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_N:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_REFRESH_N\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_REFRESH_N\n");
 		input = FW_RA_REFRESH;
 		rtl_write_dword(rtlpriv, WFM5, input);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
@@ -1230,29 +1229,29 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_BG:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG,
-			 "FW_CMD_RA_REFRESH_BG\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG,
+			"FW_CMD_RA_REFRESH_BG\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_REFRESH);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_DISABLE_RSSI_MASK);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_N_COMB:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG,
-			 "FW_CMD_RA_REFRESH_N_COMB\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG,
+			"FW_CMD_RA_REFRESH_N_COMB\n");
 		input = FW_RA_IOT_N_COMB;
 		rtl_write_dword(rtlpriv, WFM5, input);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_BG_COMB:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG,
-			 "FW_CMD_RA_REFRESH_BG_COMB\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG,
+			"FW_CMD_RA_REFRESH_BG_COMB\n");
 		input = FW_RA_IOT_BG_COMB;
 		rtl_write_dword(rtlpriv, WFM5, input);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_IQK_ENABLE:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_IQK_ENABLE\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_IQK_ENABLE\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_IQK_ENABLE);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
@@ -1287,7 +1286,7 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_CCA, MASKBYTE2, 0xcd);
 		break;
 	case FW_CMD_LPS_ENTER:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_ENTER\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_ENTER\n");
 		current_aid = rtlpriv->mac80211.assoc_id;
 		rtl_write_dword(rtlpriv, WFM5, (FW_LPS_ENTER |
 				((current_aid | 0xc000) << 8)));
@@ -1296,18 +1295,18 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		 * turbo mode until driver leave LPS */
 		break;
 	case FW_CMD_LPS_LEAVE:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_LEAVE\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_LEAVE\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_LPS_LEAVE);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_ADD_A2_ENTRY:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_ADD_A2_ENTRY\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_ADD_A2_ENTRY\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_ADD_A2_ENTRY);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_CTRL_DM_BY_DRIVER:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-			 "FW_CMD_CTRL_DM_BY_DRIVER\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"FW_CMD_CTRL_DM_BY_DRIVER\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_CTRL_DM_BY_DRIVER);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
@@ -1332,9 +1331,9 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 	u16	fw_cmdmap = FW_CMD_IO_QUERY(rtlpriv);
 	bool postprocessing = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-		 "Set FW Cmd(%#x), set_fwcmd_inprogress(%d)\n",
-		 fw_cmdio, rtlhal->set_fwcmd_inprogress);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+		"Set FW Cmd(%#x), set_fwcmd_inprogress(%d)\n",
+		fw_cmdio, rtlhal->set_fwcmd_inprogress);
 
 	do {
 		/* We re-map to combined FW CMD ones if firmware version */
@@ -1371,30 +1370,30 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 		 * DM map table in the future. */
 		switch (fw_cmdio) {
 		case FW_CMD_RA_INIT:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "RA init!!\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "RA init!!\n");
 			fw_cmdmap |= FW_RA_INIT_CTL;
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			/* Clear control flag to sync with FW. */
 			FW_CMD_IO_CLR(rtlpriv, FW_RA_INIT_CTL);
 			break;
 		case FW_CMD_DIG_DISABLE:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "Set DIG disable!!\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Set DIG disable!!\n");
 			fw_cmdmap &= ~FW_DIG_ENABLE_CTL;
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			break;
 		case FW_CMD_DIG_ENABLE:
 		case FW_CMD_DIG_RESUME:
 			if (!(rtlpriv->dm.dm_flag & HAL_DM_DIG_DISABLE)) {
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-					 "Set DIG enable or resume!!\n");
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Set DIG enable or resume!!\n");
 				fw_cmdmap |= (FW_DIG_ENABLE_CTL | FW_SS_CTL);
 				FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			}
 			break;
 		case FW_CMD_DIG_HALT:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "Set DIG halt!!\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Set DIG halt!!\n");
 			fw_cmdmap &= ~(FW_DIG_ENABLE_CTL | FW_SS_CTL);
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			break;
@@ -1409,9 +1408,9 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 			fw_param |= ((thermalval << 24) |
 				     (rtlefuse->thermalmeter[0] << 16));
 
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "Set TxPwr tracking!! FwCmdMap(%#x), FwParam(%#x)\n",
-				 fw_cmdmap, fw_param);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Set TxPwr tracking!! FwCmdMap(%#x), FwParam(%#x)\n",
+				fw_cmdmap, fw_param);
 
 			FW_CMD_PARA_SET(rtlpriv, fw_param);
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
@@ -1431,9 +1430,9 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 			/* Clear FW parameter in terms of RA parts. */
 			fw_param &= FW_RA_PARAM_CLR;
 
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "[FW CMD] [New Version] Set RA/IOT Comb in n mode!! FwCmdMap(%#x), FwParam(%#x)\n",
-				 fw_cmdmap, fw_param);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"[FW CMD] [New Version] Set RA/IOT Comb in n mode!! FwCmdMap(%#x), FwParam(%#x)\n",
+				fw_cmdmap, fw_param);
 
 			FW_CMD_PARA_SET(rtlpriv, fw_param);
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
@@ -1519,8 +1518,8 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			break;
 		case FW_CMD_PAPE_CONTROL:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "[FW CMD] Set PAPE Control\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"[FW CMD] Set PAPE Control\n");
 			fw_cmdmap &= ~FW_PAPE_CTL_BY_SW_HW;
 
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
index a37855f57e76..85f6d0d4dd79 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
@@ -95,13 +95,13 @@ static void _rtl92s_get_powerbase(struct ieee80211_hw *hw, u8 *p_pwrlevel,
 	}
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "40MHz finalpwr_idx (A / B) = 0x%x / 0x%x\n",
-			 p_final_pwridx[0], p_final_pwridx[1]);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"40MHz finalpwr_idx (A / B) = 0x%x / 0x%x\n",
+			p_final_pwridx[0], p_final_pwridx[1]);
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "20MHz finalpwr_idx (A / B) = 0x%x / 0x%x\n",
-			 p_final_pwridx[0], p_final_pwridx[1]);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"20MHz finalpwr_idx (A / B) = 0x%x / 0x%x\n",
+			p_final_pwridx[0], p_final_pwridx[1]);
 	}
 }
 
@@ -124,9 +124,9 @@ static void _rtl92s_set_antennadiff(struct ieee80211_hw *hw,
 		if (ant_pwr_diff < -8)
 			ant_pwr_diff = -8;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Antenna Diff from RF-B to RF-A = %d (0x%x)\n",
-			 ant_pwr_diff, ant_pwr_diff & 0xf);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Antenna Diff from RF-B to RF-A = %d (0x%x)\n",
+			ant_pwr_diff, ant_pwr_diff & 0xf);
 
 		ant_pwr_diff &= 0xf;
 	}
@@ -143,8 +143,8 @@ static void _rtl92s_set_antennadiff(struct ieee80211_hw *hw,
 	rtl_set_bbreg(hw, RFPGA0_TXGAINSTAGE, (BXBTXAGC | BXCTXAGC | BXDTXAGC),
 		      u4reg_val);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Write BCD-Diff(0x%x) = 0x%x\n",
-		 RFPGA0_TXGAINSTAGE, u4reg_val);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Write BCD-Diff(0x%x) = 0x%x\n",
+		RFPGA0_TXGAINSTAGE, u4reg_val);
 }
 
 static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
@@ -169,8 +169,8 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 		writeval = rtlphy->mcs_offset[chnlgroup][index] +
 				((index < 2) ? pwrbase0 : pwrbase1);
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "RTK better performance, writeval = 0x%x\n", writeval);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"RTK better performance, writeval = 0x%x\n", writeval);
 		break;
 	case 1:
 		/* Realtek regulatory increase power diff defined
@@ -178,9 +178,9 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
 			writeval = ((index < 2) ? pwrbase0 : pwrbase1);
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "Realtek regulatory, 40MHz, writeval = 0x%x\n",
-				 writeval);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"Realtek regulatory, 40MHz, writeval = 0x%x\n",
+				writeval);
 		} else {
 			chnlgroup = 0;
 
@@ -199,16 +199,16 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 					+ ((index < 2) ?
 					pwrbase0 : pwrbase1);
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "Realtek regulatory, 20MHz, writeval = 0x%x\n",
-				 writeval);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"Realtek regulatory, 20MHz, writeval = 0x%x\n",
+				writeval);
 		}
 		break;
 	case 2:
 		/* Better regulatory don't increase any power diff */
 		writeval = ((index < 2) ? pwrbase0 : pwrbase1);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Better regulatory, writeval = 0x%x\n", writeval);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Better regulatory, writeval = 0x%x\n", writeval);
 		break;
 	case 3:
 		/* Customer defined power diff. increase power diff
@@ -216,15 +216,15 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 		chnlgroup = 0;
 
 		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "customer's limit, 40MHz = 0x%x\n",
-				 rtlefuse->pwrgroup_ht40
-				 [RF90_PATH_A][chnl - 1]);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"customer's limit, 40MHz = 0x%x\n",
+				rtlefuse->pwrgroup_ht40
+				[RF90_PATH_A][chnl - 1]);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "customer's limit, 20MHz = 0x%x\n",
-				 rtlefuse->pwrgroup_ht20
-				 [RF90_PATH_A][chnl - 1]);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"customer's limit, 20MHz = 0x%x\n",
+				rtlefuse->pwrgroup_ht20
+				[RF90_PATH_A][chnl - 1]);
 		}
 
 		for (i = 0; i < 4; i++) {
@@ -256,20 +256,20 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 				(pwrdiff_limit[2] << 16) |
 				(pwrdiff_limit[1] << 8) |
 				(pwrdiff_limit[0]);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Customer's limit = 0x%x\n", customer_limit);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Customer's limit = 0x%x\n", customer_limit);
 
 		writeval = customer_limit + ((index < 2) ?
 					     pwrbase0 : pwrbase1);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Customer, writeval = 0x%x\n", writeval);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Customer, writeval = 0x%x\n", writeval);
 		break;
 	default:
 		chnlgroup = 0;
 		writeval = rtlphy->mcs_offset[chnlgroup][index] +
 				((index < 2) ? pwrbase0 : pwrbase1);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "RTK better performance, writeval = 0x%x\n", writeval);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"RTK better performance, writeval = 0x%x\n", writeval);
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index 1c7ee569f4bf..78547e4035dc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -66,24 +66,25 @@ static void rtl92se_fw_cb(const struct firmware *firmware, void *context)
 	struct rt_firmware *pfirmware = NULL;
 	char *fw_name = "rtlwifi/rtl8192sefw.bin";
 
-	RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "Firmware callback routine entered!\n");
-	complete(&rtlpriv->firmware_loading_complete);
+	rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+		"Firmware callback routine entered!\n");
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index efb432c6d785..4ec8c9362060 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -333,8 +333,8 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 	u8 bw_40 = 0;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	if (mac->opmode == NL80211_IFTYPE_STATION) {
@@ -487,7 +487,7 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 	/* DOWRD 8 */
 	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
@@ -502,8 +502,8 @@ void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 			PCI_DMA_TODEVICE);
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	/* Clear all status	*/
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index fc1548ad434f..9e31ce0a9f56 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1079,11 +1079,11 @@ int rtl_usb_probe(struct usb_interface *intf,
 	return 0;
 
 error_out:
+	rtl_usb_deinit(hw);
 	rtl_deinit_core(hw);
 error_out2:
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
-	complete(&rtlpriv->firmware_loading_complete);
 	kfree(rtlpriv->usb_data);
 	return -ENODEV;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index abec9ceabe28..0dbe442d6c3e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2302,7 +2302,6 @@ struct rtl_hal_ops {
 			  u32 regaddr, u32 bitmask, u32 data);
 	void (*linked_set_reg)(struct ieee80211_hw *hw);
 	void (*chk_switch_dmdp)(struct ieee80211_hw *hw);
-	void (*dualmac_easy_concurrent)(struct ieee80211_hw *hw);
 	void (*dualmac_switch_to_dmdp)(struct ieee80211_hw *hw);
 	bool (*phy_rf6052_config)(struct ieee80211_hw *hw);
 	void (*phy_rf6052_set_cck_txpower)(struct ieee80211_hw *hw,
@@ -2338,8 +2337,6 @@ struct rtl_intf_ops {
 	void (*read_efuse_byte)(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf);
 	int (*adapter_start)(struct ieee80211_hw *hw);
 	void (*adapter_stop)(struct ieee80211_hw *hw);
-	bool (*check_buddy_priv)(struct ieee80211_hw *hw,
-				 struct rtl_priv **buddy_priv);
 
 	int (*adapter_tx)(struct ieee80211_hw *hw,
 			  struct ieee80211_sta *sta,
@@ -2468,7 +2465,6 @@ struct rtl_works {
 
 	/*timer */
 	struct timer_list watchdog_timer;
-	struct timer_list dualmac_easyconcurrent_retrytimer;
 	struct timer_list fw_clockoff_timer;
 	struct timer_list fast_antenna_training_timer;
 	/*task */
@@ -2500,14 +2496,6 @@ struct rtl_debug {
 #define MIMO_PS_DYNAMIC			1
 #define MIMO_PS_NOLIMIT			3
 
-struct rtl_dualmac_easy_concurrent_ctl {
-	enum band_type currentbandtype_backfordmdp;
-	bool close_bbandrf_for_dmsp;
-	bool change_to_dmdp;
-	bool change_to_dmsp;
-	bool switch_in_process;
-};
-
 struct rtl_dmsp_ctl {
 	bool activescan_for_slaveofdmsp;
 	bool scan_for_anothermac_fordmsp;
@@ -2592,14 +2580,6 @@ struct dig_t {
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
@@ -2745,10 +2725,7 @@ struct rtl_scan_list {
 struct rtl_priv {
 	struct ieee80211_hw *hw;
 	struct completion firmware_loading_complete;
-	struct list_head list;
 	struct rtl_priv *buddy_priv;
-	struct rtl_global_var *glb_var;
-	struct rtl_dualmac_easy_concurrent_ctl easy_concurrent_ctl;
 	struct rtl_dmsp_ctl dmsp_ctl;
 	struct rtl_locks locks;
 	struct rtl_works works;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index be0ed19f9356..5af0f0fdecda 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2546,24 +2546,24 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
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
@@ -2578,7 +2578,7 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 
 		ret = wl12xx_init_fw(wl);
 		if (ret < 0)
-			goto out;
+			goto out_unlock;
 	}
 
 	/*
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a841fd4929ad..dd4b99ea956a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1251,7 +1251,13 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+
+	/*
+	 * It's either a kernel error or the host observed a connection
+	 * lost. In either case it's not possible communicate with the
+	 * controller and thus enter the error code path.
+	 */
+	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
 		return status;
 
 	/*
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 01a17505a2fc..d439a392ea8e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1083,6 +1083,8 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 		return -EINVAL;
 
 	if (cell->bit_offset || cell->nbits) {
+		if (len != BITS_TO_BYTES(cell->nbits) && len != cell->bytes)
+			return -EINVAL;
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 424f51b029fc..b3486c5e2ea5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -988,10 +988,10 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 	/* The path could begin with an alias */
 	if (*path != '/') {
 		int len;
-		const char *p = separator;
+		const char *p = strchrnul(path, '/');
 
-		if (!p)
-			p = strchrnul(path, '/');
+		if (separator && separator < p)
+			p = separator;
 		len = p - path;
 
 		/* of_aliases must not be NULL */
@@ -1733,7 +1733,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 		 * specifier into the out_args structure, keeping the
 		 * bits specified in <list>-map-pass-thru.
 		 */
-		match_array = map - new_size;
 		for (i = 0; i < new_size; i++) {
 			__be32 val = *(map - new_size + i);
 
@@ -1742,6 +1741,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				val |= cpu_to_be32(out_args->args[i]) & pass[i];
 			}
 
+			initial_match_array[i] = val;
 			out_args->args[i] = be32_to_cpu(val);
 		}
 		out_args->args_count = list_size = new_size;
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index bf9fe2c02549..1ca9af8cab96 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2624,6 +2624,7 @@ enum parport_pc_pci_cards {
 	netmos_9815,
 	netmos_9901,
 	netmos_9865,
+	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
 	brainboxes_uc146,
@@ -2689,6 +2690,7 @@ static struct parport_pc_pci {
 	/* netmos_9815 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
+	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
@@ -2779,6 +2781,9 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  0xA000, 0x1000, 0, 0, netmos_9865 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 	  0xA000, 0x2000, 0, 0, netmos_9865 },
+	/* ASIX AX99100 PCIe to Multi I/O Controller */
+	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+	  0xA000, 0x2000, 0, 0, asix_ax99100 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2091508c1620..3c08c2c7d339 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -578,7 +578,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 7f6279fb4f8f..f4cedf5d7af5 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -287,9 +287,9 @@ exynos5_usbdrd_pipe3_set_refclk(struct phy_usb_instance *inst)
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
 	/* FSEL settings corresponding to reference clock */
-	reg &= ~PHYCLKRST_FSEL_PIPE_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_PIPE_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	switch (phy_drd->extrefclk) {
 	case EXYNOS5_FSEL_50MHZ:
 		reg |= (PHYCLKRST_MPLL_MULTIPLIER_50M_REF |
@@ -331,9 +331,9 @@ exynos5_usbdrd_utmi_set_refclk(struct phy_usb_instance *inst)
 	reg &= ~PHYCLKRST_REFCLKSEL_MASK;
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
-	reg &= ~PHYCLKRST_FSEL_UTMI_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_UTMI_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	reg |= PHYCLKRST_FSEL(phy_drd->extrefclk);
 
 	return reg;
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 6f3afaf9398f..22d36dc8678c 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -415,6 +415,7 @@ static int tegra186_utmi_phy_exit(struct phy *phy)
 	unsigned int index = lane->index;
 	struct device *dev = padctl->dev;
 	int err;
+	u32 reg;
 
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
@@ -422,6 +423,16 @@ static int tegra186_utmi_phy_exit(struct phy *phy)
 		return -ENODEV;
 	}
 
+	if (port->mode == USB_DR_MODE_OTG ||
+	    port->mode == USB_DR_MODE_PERIPHERAL) {
+		/* reset VBUS&ID OVERRIDE */
+		reg = padctl_readl(padctl, USB2_VBUS_ID);
+		reg &= ~VBUS_OVERRIDE;
+		reg &= ~ID_OVERRIDE(~0);
+		reg |= ID_OVERRIDE_FLOATING;
+		padctl_writel(padctl, reg, USB2_VBUS_ID);
+	}
+
 	if (port->supply && port->mode == USB_DR_MODE_HOST) {
 		err = regulator_disable(port->supply);
 		if (err) {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f0d6bb567d1d..fbb9a5c7f8b8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9699,6 +9699,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('G', '8', true),       /* ThinkPad X131e */
 	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 6e367826aae9..d5e1fbac87f2 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -247,9 +247,9 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 				      DA9150_QIF_SD_GAIN_SIZE);
 	da9150_fg_read_sync_end(fg);
 
-	div = (u64) (sd_gain * shunt_val * 65536ULL);
+	div = 65536ULL * sd_gain * shunt_val;
 	do_div(div, 1000000);
-	res = (u64) (iavg * 1000000ULL);
+	res = 1000000ULL * iavg;
 	do_div(res, div);
 
 	val->intval = (int) res;
diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index e0de1df2ede0..541b03706808 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -232,8 +232,8 @@ static int pps_gpio_probe(struct platform_device *pdev)
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
index 4fd0cbf7f931..3a21177c0d1a 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -34,7 +34,7 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
 			PPS_CAPTURECLEAR, NULL);
 
-	dev_dbg(pps->dev, "PPS %s at %lu\n",
+	dev_dbg(&pps->dev, "PPS %s at %lu\n",
 			status ? "assert" : "clear", jiffies);
 }
 
@@ -71,7 +71,7 @@ static int pps_tty_open(struct tty_struct *tty)
 		goto err_unregister;
 	}
 
-	dev_info(pps->dev, "source \"%s\" added\n", info.path);
+	dev_dbg(&pps->dev, "source \"%s\" added\n", info.path);
 
 	return 0;
 
@@ -91,7 +91,7 @@ static void pps_tty_close(struct tty_struct *tty)
 	if (WARN_ON(!pps))
 		return;
 
-	dev_info(pps->dev, "removed\n");
+	dev_info(&pps->dev, "removed\n");
 	pps_unregister_source(pps);
 }
 
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 84e49204912f..b2a991c10c74 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -83,7 +83,7 @@ static void parport_irq(void *handle)
 	/* check the signal (no signal means the pulse is lost this time) */
 	if (!signal_is_set(port)) {
 		local_irq_restore(flags);
-		dev_err(dev->pps->dev, "lost the signal\n");
+		dev_err(&dev->pps->dev, "lost the signal\n");
 		goto out_assert;
 	}
 
@@ -100,7 +100,7 @@ static void parport_irq(void *handle)
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
index 22a65ad4e46e..2d008e0d116a 100644
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
 
@@ -332,22 +348,13 @@ static void pps_device_destruct(struct device *dev)
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
@@ -364,40 +371,29 @@ int pps_register_cdev(struct pps_device *pps)
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
@@ -407,7 +403,13 @@ void pps_unregister_cdev(struct pps_device *pps)
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
@@ -427,6 +429,11 @@ void pps_unregister_cdev(struct pps_device *pps)
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
@@ -449,13 +456,11 @@ EXPORT_SYMBOL(pps_lookup_dev);
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
 	pps_class = class_create(THIS_MODULE, "pps");
 	if (IS_ERR(pps_class)) {
 		pr_err("failed to allocate class\n");
@@ -463,8 +468,9 @@ static int __init pps_init(void)
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
@@ -477,8 +483,7 @@ static int __init pps_init(void)
 
 remove_class:
 	class_destroy(pps_class);
-
-	return err;
+	return pps_major;
 }
 
 subsys_initcall(pps_init);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index a6ff02a02cab..073791a0c6db 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -178,6 +178,11 @@ static void ptp_clock_release(struct device *dev)
 	kfree(ptp);
 }
 
+static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 static void ptp_aux_kworker(struct kthread_work *work)
 {
 	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
@@ -223,6 +228,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->pincfg_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
 
+	if (!ptp->info->enable)
+		ptp->info->enable = ptp_enable;
+
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
 		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 2371151bc8fc..2e6490cc1f46 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1743,7 +1743,8 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
+			mport->net = NULL;
 			goto cleanup;
 		}
 	}
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index b1cd6e028f2b..5cb0a1f661c6 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -873,7 +873,10 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 		dev_set_name(&net->dev, "rnet_%d", net->id);
 		net->dev.parent = &mport->dev;
 		net->dev.release = rio_scan_release_dev;
-		rio_add_net(net);
+		if (rio_add_net(net)) {
+			put_device(&net->dev);
+			net = NULL;
+		}
 	}
 
 	return net;
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 7a0a235e4465..c4b72fa8ad81 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -377,7 +377,7 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 					"failed to parse DT for regulator %pOFn\n",
 					child);
 				of_node_put(child);
-				return -EINVAL;
+				goto err_put;
 			}
 			match->of_node = of_node_get(child);
 			count++;
@@ -386,6 +386,18 @@ int of_regulator_match(struct device *dev, struct device_node *node,
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
 
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 3e7ea5244562..5251b6cc2def 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -332,7 +332,16 @@ static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
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
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 69023ddceb59..7df4e8cfeb92 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4627,8 +4627,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	if (!ioc->is_gen35_ioc && ioc->manu_pg11.EEDPTagMode == 0) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
-		ioc->manu_pg11.EEDPTagMode &= ~0x3;
-		ioc->manu_pg11.EEDPTagMode |= 0x1;
+		ioc->manu_pg11.EEDPTagMode = 0x1;
 		mpt3sas_config_set_manufacturing_pg11(ioc, &mpi_reply,
 		    &ioc->manu_pg11);
 	}
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 44f4e10f9bf9..ffba2c340440 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1639,6 +1639,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
 	payload_sz = sizeof(cmd_request->mpb);
+	payload->range.len = 0;
 
 	if (sg_count) {
 		if (sg_count > MAX_PAGE_BUFFER_COUNT) {
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index bad366e49159..78e72a1aec9b 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -213,6 +213,7 @@ int ufs_bsg_probe(struct ufs_hba *hba)
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), ufs_bsg_request, NULL, 0);
 	if (IS_ERR(q)) {
 		ret = PTR_ERR(q);
+		device_del(bsg_dev);
 		goto out;
 	}
 
diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index ddf0371ad52b..c1171ec5efeb 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -147,8 +147,9 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-
-	if (!ret && need_tid && !txn->msg->comp) {
+	if (ret == -ETIMEDOUT) {
+		slim_free_txn_tid(ctrl, txn);
+	} else if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		timeout = wait_for_completion_timeout(txn->comp,
diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index 41e929407196..acb2ad3c567c 100644
--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -116,7 +116,8 @@ struct qcom_smem_state *qcom_smem_state_get(struct device *dev,
 
 	if (args.args_count != 1) {
 		dev_err(dev, "invalid #qcom,smem-state-cells\n");
-		return ERR_PTR(-EINVAL);
+		state = ERR_PTR(-EINVAL);
+		goto put;
 	}
 
 	state = of_node_to_state(args.np);
diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e087d681e807..78b0f427f6ec 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -436,7 +436,7 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 	if (!qs->attr.soc_id || !qs->attr.revision)
 		return -ENOMEM;
 
-	if (offsetof(struct socinfo, serial_num) <= item_size) {
+	if (offsetofend(struct socinfo, serial_num) <= item_size) {
 		qs->attr.serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"%u",
 							le32_to_cpu(info->serial_num));
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 34856c9ad931..a5a0f2d2f273 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -40,6 +40,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/mxs-spi.h>
 #include <trace/events/spi.h>
+#include <linux/dma/mxs-dma.h>
 
 #define DRIVER_NAME		"mxs-spi"
 
@@ -253,7 +254,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 		desc = dmaengine_prep_slave_sg(ssp->dmach,
 				&dma_xfer[sg_count].sg, 1,
 				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
 
 		if (!desc) {
 			dev_err(ssp->dev,
diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index 2d3efd2a6dde..d9b34605ff9b 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -55,23 +55,19 @@ int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
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
 
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..d0f397c90242 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -80,7 +80,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req;
-	bool interruptable;
 	u32 ret;
 
 	/*
@@ -111,36 +110,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/*
 	 * Wait for supplicant to process and return result, once we've
 	 * returned from wait_for_completion(&req->c) successfully we have
-	 * exclusive access again.
+	 * exclusive access again. Allow the wait to be killable such that
+	 * the wait doesn't turn into an indefinite state if the supplicant
+	 * gets hung for some reason.
 	 */
-	while (wait_for_completion_interruptible(&req->c)) {
+	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
-		interruptable = !supp->ctx;
-		if (interruptable) {
-			/*
-			 * There's no supplicant available and since the
-			 * supp->mutex currently is held none can
-			 * become available until the mutex released
-			 * again.
-			 *
-			 * Interrupting an RPC to supplicant is only
-			 * allowed as a way of slightly improving the user
-			 * experience in case the supplicant hasn't been
-			 * started yet. During normal operation the supplicant
-			 * will serve all requests in a timely manner and
-			 * interrupting then wouldn't make sense.
-			 */
-			if (req->in_queue) {
-				list_del(&req->link);
-				req->in_queue = false;
-			}
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
 		}
 		mutex_unlock(&supp->mutex);
-
-		if (interruptable) {
-			req->ret = TEEC_ERROR_COMMUNICATION;
-			break;
-		}
+		req->ret = TEEC_ERROR_COMMUNICATION;
 	}
 
 	ret = req->ret;
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 04bf2b297fdc..12b9a134fb80 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -300,6 +300,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
+extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -316,6 +317,7 @@ static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
+static inline void serial8250_tx_dma_flush(struct uart_8250_port *p) { }
 static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bdc7bb7a1b92..0b4139c0a975 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -126,6 +126,22 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	return ret;
 }
 
+void serial8250_tx_dma_flush(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	/*
+	 * kfifo_reset() has been called by the serial core, avoid
+	 * advancing and underflowing in __dma_tx_complete().
+	 */
+	dma->tx_size = 0;
+
+	dmaengine_terminate_async(dma->rxchan);
+}
+
 int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 1ff5920e5278..9bce71e450e9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -67,6 +67,8 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
 			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
@@ -5757,6 +5759,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 		0xA000, 0x3004,
 		0, 0, pbn_b0_bt_4_115200 },
+
+	/*
+	 * ASIX AX99100 PCIe to Multi I/O Controller
+	 */
+	{	PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/* Intel CE4100 */
 	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
 		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5d8022cdb50a..6b3ff20a0656 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2473,6 +2473,14 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
 	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
 }
 
+static void serial8250_flush_buffer(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (up->dma)
+		serial8250_tx_dma_flush(up);
+}
+
 static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 					      unsigned int baud,
 					      unsigned int *frac)
@@ -3119,6 +3127,7 @@ static const struct uart_ops serial8250_pops = {
 	.break_ctl	= serial8250_break_ctl,
 	.startup	= serial8250_startup,
 	.shutdown	= serial8250_shutdown,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_termios	= serial8250_set_termios,
 	.set_ldisc	= serial8250_set_ldisc,
 	.pm		= serial8250_pm,
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d570edf21239..5eeb034de5b8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -166,6 +166,7 @@ struct sci_port {
 static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
+static bool sci_uart_earlycon;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3345,6 +3346,7 @@ static int sci_probe_single(struct platform_device *dev,
 static int sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p;
+	struct resource *res;
 	struct sci_port *sp;
 	unsigned int dev_id;
 	int ret;
@@ -3372,6 +3374,26 @@ static int sci_probe(struct platform_device *dev)
 	}
 
 	sp = &sci_ports[dev_id];
+
+	/*
+	 * In case:
+	 * - the probed port alias is zero (as the one used by earlycon), and
+	 * - the earlycon is still active (e.g., "earlycon keep_bootcon" in
+	 *   bootargs)
+	 *
+	 * defer the probe of this serial. This is a debug scenario and the user
+	 * must be aware of it.
+	 *
+	 * Except when the probed port is the same as the earlycon port.
+	 */
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (sci_uart_earlycon && sp == &sci_ports[0] && sp->port.mapbase != res->start)
+		return dev_err_probe(&dev->dev, -EBUSY, "sci_port[0] is used by earlycon!\n");
+
 	platform_set_drvdata(dev, sp);
 
 	ret = sci_probe_single(dev, dev_id, p, sp);
@@ -3455,7 +3477,7 @@ early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct plat_sci_port port_cfg __initdata;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
@@ -3470,6 +3492,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_uart_earlycon = true;
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 51d42c69fb5e..a4d863f6cda7 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1135,7 +1135,10 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	struct usb_endpoint_descriptor *in, *out;
+	static const u8 ep_addrs[] = {
+		CXACRU_EP_CMD + USB_DIR_IN,
+		CXACRU_EP_CMD + USB_DIR_OUT,
+		0};
 	int ret;
 
 	/* instance init */
@@ -1183,13 +1186,11 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	}
 
 	if (usb_endpoint_xfer_int(&cmd_ep->desc))
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						NULL, NULL, &in, &out);
+		ret = usb_check_int_endpoints(intf, ep_addrs);
 	else
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						&in, &out, NULL, NULL);
+		ret = usb_check_bulk_endpoints(intf, ep_addrs);
 
-	if (ret) {
+	if (!ret) {
 		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
 		ret = -ENODEV;
 		goto fail;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 8b9740142152..59a354822413 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -359,7 +359,7 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 static void acm_ctrl_irq(struct urb *urb)
 {
 	struct acm *acm = urb->context;
-	struct usb_cdc_notification *dr = urb->transfer_buffer;
+	struct usb_cdc_notification *dr;
 	unsigned int current_size = urb->actual_length;
 	unsigned int expected_size, copy_size, alloc_size;
 	int retval;
@@ -386,14 +386,25 @@ static void acm_ctrl_irq(struct urb *urb)
 
 	usb_mark_last_busy(acm->dev);
 
-	if (acm->nb_index)
+	if (acm->nb_index == 0) {
+		/*
+		 * The first chunk of a message must contain at least the
+		 * notification header with the length field, otherwise we
+		 * can't get an expected_size.
+		 */
+		if (current_size < sizeof(struct usb_cdc_notification)) {
+			dev_dbg(&acm->control->dev, "urb too short\n");
+			goto exit;
+		}
+		dr = urb->transfer_buffer;
+	} else {
 		dr = (struct usb_cdc_notification *)acm->notification_buffer;
-
+	}
 	/* size = notification-header + (optional) data */
 	expected_size = sizeof(struct usb_cdc_notification) +
 					le16_to_cpu(dr->wLength);
 
-	if (current_size < expected_size) {
+	if (acm->nb_index != 0 || current_size < expected_size) {
 		/* notification is transmitted fragmented, reassemble */
 		if (acm->nb_size < expected_size) {
 			u8 *new_buffer;
@@ -1733,13 +1744,16 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x0870, 0x0001), /* Metricom GS Modem */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
-	{ USB_DEVICE(0x045b, 0x023c),	/* Renesas USB Download mode */
+	{ USB_DEVICE(0x045b, 0x023c),	/* Renesas R-Car H3 USB Download mode */
+	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
+	},
+	{ USB_DEVICE(0x045b, 0x0247),	/* Renesas R-Car D3 USB Download mode */
 	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
 	},
-	{ USB_DEVICE(0x045b, 0x0248),	/* Renesas USB Download mode */
+	{ USB_DEVICE(0x045b, 0x0248),	/* Renesas R-Car M3-N USB Download mode */
 	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
 	},
-	{ USB_DEVICE(0x045b, 0x024D),	/* Renesas USB Download mode */
+	{ USB_DEVICE(0x045b, 0x024D),	/* Renesas R-Car E3 USB Download mode */
 	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
 	},
 	{ USB_DEVICE(0x0e8d, 0x0003), /* FIREFLY, MediaTek Inc; andrey.arapov@gmail.com */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 686a75c37591..f7c365db1e9c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1792,6 +1792,17 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
 
+	/*
+	 * The USB 2.0 spec prohibits hubs from having more than one
+	 * configuration or interface, and we rely on this prohibition.
+	 * Refuse to accept a device that violates it.
+	 */
+	if (hdev->descriptor.bNumConfigurations > 1 ||
+			hdev->actconfig->desc.bNumInterfaces > 1) {
+		dev_err(&intf->dev, "Invalid hub with more than one config or interface\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Set default autosuspend delay as 0 to speedup bus suspend,
 	 * based on the below considerations:
@@ -4551,7 +4562,7 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev);
+		retval = hcd->driver->address_device(hcd, udev, USB_CTRL_SET_TIMEOUT);
 	else
 		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a158bf40373b..4d076872c43e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -338,6 +338,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
 
+	/* Prolific Single-LUN Mass Storage Card Reader */
+	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_NO_LPM },
+
 	/* Saitek Cyborg Gold Joystick */
 	{ USB_DEVICE(0x06a3, 0x0006), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
@@ -430,6 +434,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Sony Xperia XZ1 Compact (lilac) smartphone in fastboot mode */
+	{ USB_DEVICE(0x0fce, 0x0dde), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
@@ -520,6 +527,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Blackmagic Design UltraStudio SDI */
 	{ USB_DEVICE(0x1edb, 0xbd4f), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Teclast disk */
+	{ USB_DEVICE(0x1f75, 0x0917), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Hauppauge HVR-950q */
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index abc2271799e0..74d2dbf9a535 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4548,6 +4548,7 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	spin_lock_irqsave(&hsotg->lock, flags);
 
 	hsotg->driver = NULL;
+	hsotg->gadget.dev.of_node = NULL;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
 	hsotg->enabled = 0;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6caedef5575d..fd8b986794d0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1966,11 +1966,39 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
+	u32			saved_config = 0;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
 
+	/*
+	 * When operating in USB 2.0 speeds (HS/FS), ensure that
+	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
+	 * or stopping the controller. This resolves timeout issues that occur
+	 * during frequent role switches between host and device modes.
+	 *
+	 * Save and clear these settings, then restore them after completing the
+	 * controller start or stop sequence.
+	 *
+	 * This solution was discovered through experimentation as it is not
+	 * mentioned in the dwc3 programming guide. It has been tested on an
+	 * Exynos platforms.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
+		saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	}
+
+	if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+		saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	}
+
+	if (saved_config)
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
 		if (dwc->revision <= DWC3_REVISION_187A) {
@@ -1998,10 +2026,17 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	do {
+		usleep_range(1000, 2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
 
+	if (saved_config) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= saved_config;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
 	if (!timeout)
 		return -ETIMEDOUT;
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 3596ff37b9ef..4b2e9df97b11 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -915,10 +915,11 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		power = min(power, 900U);
 done:
-	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
-		usb_gadget_set_selfpowered(gadget);
-	else
+	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
+	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
 		usb_gadget_clear_selfpowered(gadget);
+	else
+		usb_gadget_set_selfpowered(gadget);
 
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
@@ -2365,7 +2366,10 @@ void composite_suspend(struct usb_gadget *gadget)
 
 	cdev->suspended = 1;
 
-	usb_gadget_set_selfpowered(gadget);
+	if (cdev->config &&
+	    cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
+		usb_gadget_set_selfpowered(gadget);
+
 	usb_gadget_vbus_draw(gadget, 2);
 }
 
@@ -2394,8 +2398,11 @@ void composite_resume(struct usb_gadget *gadget)
 		else
 			maxpower = min(maxpower, 900U);
 
-		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
+		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW ||
+		    !(cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
 			usb_gadget_clear_selfpowered(gadget);
+		else
+			usb_gadget_set_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
 	}
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 0e083a53da53..3e8ea1bbe429 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -87,7 +87,7 @@ struct f_midi {
 	struct snd_rawmidi_substream *out_substream[MAX_PORTS];
 
 	unsigned long		out_triggered;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	unsigned int in_ports;
 	unsigned int out_ports;
 	int index;
@@ -282,7 +282,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
 			req->length = 0;
-			f_midi_transmit(midi);
+			queue_work(system_highpri_wq, &midi->work);
 			return;
 		}
 		break;
@@ -698,9 +698,11 @@ static void f_midi_transmit(struct f_midi *midi)
 	f_midi_drop_out_substreams(midi);
 }
 
-static void f_midi_in_tasklet(unsigned long data)
+static void f_midi_in_work(struct work_struct *work)
 {
-	struct f_midi *midi = (struct f_midi *) data;
+	struct f_midi *midi;
+
+	midi = container_of(work, struct f_midi, work);
 	f_midi_transmit(midi);
 }
 
@@ -737,7 +739,7 @@ static void f_midi_in_trigger(struct snd_rawmidi_substream *substream, int up)
 	VDBG(midi, "%s() %d\n", __func__, up);
 	midi->in_ports_array[substream->number].active = up;
 	if (up)
-		tasklet_hi_schedule(&midi->tasklet);
+		queue_work(system_highpri_wq, &midi->work);
 }
 
 static int f_midi_out_open(struct snd_rawmidi_substream *substream)
@@ -875,7 +877,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	int status, n, jack = 1, i = 0, endpoint_descriptor_index = 0;
 
 	midi->gadget = cdev->gadget;
-	tasklet_init(&midi->tasklet, f_midi_in_tasklet, (unsigned long) midi);
+	INIT_WORK(&midi->work, f_midi_in_work);
 	status = f_midi_register_card(midi);
 	if (status < 0)
 		goto fail_register;
@@ -997,11 +999,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* configure the endpoint descriptors ... */
-	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
-	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
+	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
+	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
 
-	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
-	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
+	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
+	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
 
 	/* ... and add them to the list */
 	endpoint_descriptor_index = i;
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 41a10bcc2efc..90fe33f9e095 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -245,7 +245,6 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
-	struct usb_gadget *gadget = fuas_to_gadget(fu);
 	int ret;
 
 	init_completion(&cmd->write_complete);
@@ -256,22 +255,6 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
 		return -EINVAL;
 	}
 
-	if (!gadget->sg_supported) {
-		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_KERNEL);
-		if (!cmd->data_buf)
-			return -ENOMEM;
-
-		fu->bot_req_out->buf = cmd->data_buf;
-	} else {
-		fu->bot_req_out->buf = NULL;
-		fu->bot_req_out->num_sgs = se_cmd->t_data_nents;
-		fu->bot_req_out->sg = se_cmd->t_data_sg;
-	}
-
-	fu->bot_req_out->complete = usbg_data_write_cmpl;
-	fu->bot_req_out->length = se_cmd->data_length;
-	fu->bot_req_out->context = cmd;
-
 	ret = usbg_prepare_w_request(cmd, fu->bot_req_out);
 	if (ret)
 		goto cleanup;
@@ -971,6 +954,7 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 	return;
 
 cleanup:
+	target_put_sess_cmd(se_cmd);
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
@@ -1063,8 +1047,7 @@ static void usbg_cmd_work(struct work_struct *work)
 
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
+			TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
 
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
@@ -1193,8 +1176,7 @@ static void bot_cmd_work(struct work_struct *work)
 
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-				TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
+				TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
 
 static int bot_submit_command(struct f_uas *fu,
@@ -2017,43 +1999,39 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 	bot_intf_desc.bInterfaceNumber = iface;
 	uasp_intf_desc.bInterfaceNumber = iface;
 	fu->iface = iface;
-	ep = usb_ep_autoconfig_ss(gadget, &uasp_ss_bi_desc,
-			&uasp_bi_ep_comp_desc);
+	ep = usb_ep_autoconfig(gadget, &uasp_fs_bi_desc);
 	if (!ep)
 		goto ep_fail;
 
 	fu->ep_in = ep;
 
-	ep = usb_ep_autoconfig_ss(gadget, &uasp_ss_bo_desc,
-			&uasp_bo_ep_comp_desc);
+	ep = usb_ep_autoconfig(gadget, &uasp_fs_bo_desc);
 	if (!ep)
 		goto ep_fail;
 	fu->ep_out = ep;
 
-	ep = usb_ep_autoconfig_ss(gadget, &uasp_ss_status_desc,
-			&uasp_status_in_ep_comp_desc);
+	ep = usb_ep_autoconfig(gadget, &uasp_fs_status_desc);
 	if (!ep)
 		goto ep_fail;
 	fu->ep_status = ep;
 
-	ep = usb_ep_autoconfig_ss(gadget, &uasp_ss_cmd_desc,
-			&uasp_cmd_comp_desc);
+	ep = usb_ep_autoconfig(gadget, &uasp_fs_cmd_desc);
 	if (!ep)
 		goto ep_fail;
 	fu->ep_cmd = ep;
 
 	/* Assume endpoint addresses are the same for both speeds */
-	uasp_bi_desc.bEndpointAddress =	uasp_ss_bi_desc.bEndpointAddress;
-	uasp_bo_desc.bEndpointAddress = uasp_ss_bo_desc.bEndpointAddress;
+	uasp_bi_desc.bEndpointAddress =	uasp_fs_bi_desc.bEndpointAddress;
+	uasp_bo_desc.bEndpointAddress = uasp_fs_bo_desc.bEndpointAddress;
 	uasp_status_desc.bEndpointAddress =
-		uasp_ss_status_desc.bEndpointAddress;
-	uasp_cmd_desc.bEndpointAddress = uasp_ss_cmd_desc.bEndpointAddress;
-
-	uasp_fs_bi_desc.bEndpointAddress = uasp_ss_bi_desc.bEndpointAddress;
-	uasp_fs_bo_desc.bEndpointAddress = uasp_ss_bo_desc.bEndpointAddress;
-	uasp_fs_status_desc.bEndpointAddress =
-		uasp_ss_status_desc.bEndpointAddress;
-	uasp_fs_cmd_desc.bEndpointAddress = uasp_ss_cmd_desc.bEndpointAddress;
+		uasp_fs_status_desc.bEndpointAddress;
+	uasp_cmd_desc.bEndpointAddress = uasp_fs_cmd_desc.bEndpointAddress;
+
+	uasp_ss_bi_desc.bEndpointAddress = uasp_fs_bi_desc.bEndpointAddress;
+	uasp_ss_bo_desc.bEndpointAddress = uasp_fs_bo_desc.bEndpointAddress;
+	uasp_ss_status_desc.bEndpointAddress =
+		uasp_fs_status_desc.bEndpointAddress;
+	uasp_ss_cmd_desc.bEndpointAddress = uasp_fs_cmd_desc.bEndpointAddress;
 
 	ret = usb_assign_descriptors(f, uasp_fs_function_desc,
 			uasp_hs_function_desc, uasp_ss_function_desc,
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index e04acf2dfa65..2952e5feb2ee 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -306,7 +306,7 @@ struct renesas_usb3_request {
 	struct list_head	queue;
 };
 
-#define USB3_EP_NAME_SIZE	8
+#define USB3_EP_NAME_SIZE	16
 struct renesas_usb3_ep {
 	struct usb_ep ep;
 	struct renesas_usb3 *usb3;
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index f6d04491df60..7c98941d1108 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -945,6 +945,15 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
 	 * booting from USB disk or using a usb keyboard
 	 */
 	hcc_params = readl(base + EHCI_HCC_PARAMS);
+
+	/* LS7A EHCI controller doesn't have extended capabilities, the
+	 * EECP (EHCI Extended Capabilities Pointer) field of HCCPARAMS
+	 * register should be 0x0 but it reads as 0xa0.  So clear it to
+	 * avoid error messages on boot.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_LOONGSON && pdev->device == 0x7a14)
+		hcc_params &= ~(0xffL << 8);
+
 	offset = (hcc_params >> 8) & 0xff;
 	while (offset && --count) {
 		pci_read_config_dword(pdev, offset, &cap);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index b3ee977fab99..610190bf62da 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1766,6 +1766,8 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	}
 
 	command->status = 0;
+	/* set default timeout to 5000 ms */
+	command->timeout_ms = XHCI_CMD_DEFAULT_TIMEOUT;
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index f35476af78a3..e585fa63f766 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -25,8 +25,8 @@
 #define SPARSE_CNTL_ENABLE	0xC12C
 
 /* Device for a quirk */
-#define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
-#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK	0x1000
+#define PCI_VENDOR_ID_FRESCO_LOGIC		0x1b73
+#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK		0x1000
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1009	0x1009
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
@@ -35,8 +35,8 @@
 #define PCI_DEVICE_ID_EJ168		0x7023
 #define PCI_DEVICE_ID_EJ188		0x7052
 
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
 #define PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI		0x22b5
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI		0xa12f
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 086c567ca7d0..08b016864fc0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -285,9 +285,10 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	readl(&xhci->dba->doorbell[0]);
 }
 
-static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci, unsigned long delay)
+static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer, delay);
+	return mod_delayed_work(system_wq, &xhci->cmd_timer,
+			msecs_to_jiffies(xhci->current_cmd->timeout_ms));
 }
 
 static struct xhci_command *xhci_next_queued_cmd(struct xhci_hcd *xhci)
@@ -331,7 +332,8 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		if (cur_cmd)
+			xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
@@ -1561,7 +1563,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	if (!list_is_singular(&xhci->cmd_list)) {
 		xhci->current_cmd = list_first_entry(&cmd->cmd_list,
 						struct xhci_command, cmd_list);
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	} else if (xhci->current_cmd == cmd) {
 		xhci->current_cmd = NULL;
 	}
@@ -4096,7 +4098,7 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	/* if there are no other commands queued we start the timeout timer */
 	if (list_empty(&xhci->cmd_list)) {
 		xhci->current_cmd = cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	}
 
 	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dfc406be0856..3383d7f0c88f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4105,12 +4105,18 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 0;
 }
 
-/*
- * Issue an Address Device command and optionally send a corresponding
- * SetAddress request to the device.
+/**
+ * xhci_setup_device - issues an Address Device command to assign a unique
+ *			USB bus address.
+ * @hcd: USB host controller data structure.
+ * @udev: USB dev structure representing the connected device.
+ * @setup: Enum specifying setup mode: address only or with context.
+ * @timeout_ms: Max wait time (ms) for the command operation to complete.
+ *
+ * Return: 0 if successful; otherwise, negative error code.
  */
 static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
-			     enum xhci_setup_dev setup)
+			     enum xhci_setup_dev setup, unsigned int timeout_ms)
 {
 	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
 	unsigned long flags;
@@ -4167,6 +4173,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	command->in_ctx = virt_dev->in_ctx;
+	command->timeout_ms = timeout_ms;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
@@ -4295,14 +4302,16 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	return ret;
 }
 
-static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev,
+			       unsigned int timeout_ms)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS, timeout_ms);
 }
 
 static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY,
+				 XHCI_CMD_DEFAULT_TIMEOUT);
 }
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 421bc7ad413e..d27b08d43e39 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -815,6 +815,8 @@ struct xhci_command {
 	struct completion		*completion;
 	union xhci_trb			*command_trb;
 	struct list_head		cmd_list;
+	/* xHCI command response timeout in milliseconds */
+	unsigned int			timeout_ms;
 };
 
 /* drop context bitmasks */
@@ -1550,8 +1552,11 @@ struct xhci_td {
 	bool			urb_length_set;
 };
 
-/* xHCI command default timeout value */
-#define XHCI_CMD_DEFAULT_TIMEOUT	(5 * HZ)
+/*
+ * xHCI command default timeout value in milliseconds.
+ * USB 3.2 spec, section 9.2.6.1
+ */
+#define XHCI_CMD_DEFAULT_TIMEOUT	5000
 
 /* command descriptor */
 struct xhci_cd {
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index a3c30b609433..ab3332002872 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -313,8 +313,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
@@ -777,6 +779,8 @@ static int usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	flush_delayed_work(&priv->notify_hotplug_work);
+
 	/* power off */
 	if (!usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 53489cafecc1..5a4605bbaa8b 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1094,7 +1094,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
-	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
 		 !IS_ERR(gpriv->transceiver) ? "" : "no ");
 
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index aa4fb7a66dce..4e00a185a4b6 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -317,14 +317,15 @@ usb_role_switch_register(struct device *parent,
 	sw->dev.type = &usb_role_dev_type;
 	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
 
+	sw->registered = true;
+
 	ret = device_register(&sw->dev);
 	if (ret) {
+		sw->registered = false;
 		put_device(&sw->dev);
 		return ERR_PTR(ret);
 	}
 
-	sw->registered = true;
-
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 79f8e3a043fc..1f7a2db1b193 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -619,15 +619,6 @@ static void option_instat_callback(struct urb *urb);
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
-/* MeiG Smart Technology products */
-#define MEIGSMART_VENDOR_ID			0x2dee
-/* MeiG Smart SRM815/SRM825L based on Qualcomm 315 */
-#define MEIGSMART_PRODUCT_SRM825L		0x4d22
-/* MeiG Smart SLM320 based on UNISOC UIS8910 */
-#define MEIGSMART_PRODUCT_SLM320		0x4d41
-/* MeiG Smart SLM770A based on ASR1803 */
-#define MEIGSMART_PRODUCT_SLM770A		0x4d57
-
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -1367,15 +1358,15 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1063, 0xff),	/* Telit LN920 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990 (PCIe) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
@@ -1403,6 +1394,22 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x60) },	/* Telit FN990B (rmnet) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x30),
+	  .driver_info = NCTRL(5) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x60) },	/* Telit FN990B (MBIM) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x30),
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x60) },	/* Telit FN990B (RNDIS) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x30),
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x60) },	/* Telit FN990B (ECM) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x30),
+	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -2347,6 +2354,14 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a05, 0xff) },			/* Fibocom FM650-CN (NCM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a06, 0xff) },			/* Fibocom FM650-CN (RNDIS mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a07, 0xff) },			/* Fibocom FM650-CN (MBIM mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d41, 0xff, 0, 0) },		/* MeiG Smart SLM320 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d57, 0xff, 0, 0) },		/* MeiG Smart SLM770A */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0, 0) },		/* MeiG Smart SRM815 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0x10, 0x02) },	/* MeiG Smart SLM828 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0x10, 0x03) },	/* MeiG Smart SLM828 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM815 and SRM825L */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825L */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825L */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
@@ -2403,12 +2418,6 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..76ab5eb6d7f2 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -217,6 +217,11 @@ static int rt1711h_probe(struct i2c_client *client,
 {
 	int ret;
 	struct rt1711h_chip *chip;
+	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
+			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
+			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
+			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
+			       TCPC_ALERT_FAULT;
 
 	ret = rt1711h_check_revision(client);
 	if (ret < 0) {
@@ -258,6 +263,12 @@ static int rt1711h_probe(struct i2c_client *client,
 					dev_name(chip->dev), chip);
 	if (ret < 0)
 		return ret;
+
+	/* Enable alert interrupts */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	enable_irq_wake(client->irq);
 
 	return 0;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 07db1f1a1f72..c626a6acfad6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3035,7 +3035,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->caps_count = 0;
 			port->pd_capable = true;
 			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
-					    PD_T_SEND_SOURCE_CAP);
+					    PD_T_SENDER_RESPONSE);
 		}
 		break;
 	case SRC_SEND_CAPABILITIES_TIMEOUT:
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 0268e654cae6..b2be951e8af9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -28,7 +28,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		5000
+#define UCSI_TIMEOUT_MS		10000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 83f81d24df78..94e3fb9f4224 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "vfio_pci_private.h"
 
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 9165bf6ad018..bb17e355fa18 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -410,6 +410,11 @@ static ssize_t vfio_platform_read_mmio(struct vfio_platform_region *reg,
 
 	count = min_t(size_t, count, reg->size - off);
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap_nocache(reg->addr, reg->size);
@@ -492,6 +497,11 @@ static ssize_t vfio_platform_write_mmio(struct vfio_platform_region *reg,
 
 	count = min_t(size_t, count, reg->size - off);
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap_nocache(reg->addr, reg->size);
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
index 0282d4eef139..3b16c3342cb7 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -102,6 +102,7 @@ struct device_node *dss_of_port_get_parent_device(struct device_node *port)
 		np = of_get_next_parent(np);
 	}
 
+	of_node_put(np);
 	return NULL;
 }
 
diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 94f1f398eefa..cccc8e74f49b 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -82,7 +82,7 @@ union afs_xdr_dir_block {
 
 	struct {
 		struct afs_xdr_dir_hdr	hdr;
-		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		u8			alloc_ctrs[AFS_DIR_BLOCKS_WITH_CTR];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
 	} meta;
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 22a7d7547a91..28fa3ff8843a 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -529,7 +529,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * 28 bits (256 MB) is way more than reasonable in this case.
 	 * If some top bits are set we have probable binary corruption.
 	*/
-	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
+	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
 		pr_err("bad header\n");
 		ret = -ENOEXEC;
 		goto err;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d9a581f46f13..004894e6dd23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7679,8 +7679,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	btrfs_release_path(path);
@@ -11081,6 +11079,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 89ad7e12c08b..062154c6a65f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4789,8 +4789,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		WARN_ON(!first_cow && level == 0);
 
 		node = rc->backref_cache.path[level];
-		BUG_ON(node->bytenr != buf->start &&
-		       node->new_bytenr != buf->start);
+
+		/*
+		 * If node->bytenr != buf->start and node->new_bytenr !=
+		 * buf->start then we've got the wrong backref node for what we
+		 * expected to see here and the cache is incorrect.
+		 */
+		if (unlikely(node->bytenr != buf->start && node->new_bytenr != buf->start)) {
+			btrfs_err(fs_info,
+"bytenr %llu was found but our backref cache was expecting %llu or %llu",
+				  buf->start, node->bytenr, node->new_bytenr);
+			return -EUCLEAN;
+		}
 
 		drop_node_buffer(node);
 		extent_buffer_get(cow);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ea8b5b2d859d..a90bf46ea518 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1217,7 +1217,7 @@ static int btrfs_fill_super(struct super_block *sb,
 
 	err = open_ctree(sb, fs_devices, (char *)data);
 	if (err) {
-		btrfs_err(fs_info, "open_ctree failed");
+		btrfs_err(fs_info, "open_ctree failed: %d", err);
 		return err;
 	}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1d25bf0c55cc..094b024bbf0c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -174,8 +174,10 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	cur_trans = fs_info->running_transaction;
 	if (cur_trans) {
 		if (TRANS_ABORTED(cur_trans)) {
+			const int abort_error = cur_trans->aborted;
+
 			spin_unlock(&fs_info->trans_lock);
-			return cur_trans->aborted;
+			return abort_error;
 		}
 		if (btrfs_blocked_trans_types[cur_trans->state] & type) {
 			spin_unlock(&fs_info->trans_lock);
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d490f28aa7f6..1b2347479cc6 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1060,6 +1060,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = false;
 		break;
 	case -NFS4ERR_DELAY:
+		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
 
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index cd363e2fc071..3d7e692f3e7f 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -64,12 +64,6 @@ static inline unsigned int nilfs_chunk_size(struct inode *inode)
 	return inode->i_sb->s_blocksize;
 }
 
-static inline void nilfs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /*
  * Return the offset into page `page_nr' of the last valid
  * byte in that page, plus one.
@@ -450,8 +444,7 @@ int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 	return 0;
 }
 
-/* Releases the page */
-void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct page *page, struct inode *inode)
 {
 	unsigned int from = (char *)de - (char *)page_address(page);
@@ -461,12 +454,15 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		return err;
+	}
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
-	nilfs_put_page(page);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
+	return 0;
 }
 
 /*
@@ -569,7 +565,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 
 /*
  * nilfs_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date. Releases the page.
+ * previous entry. Page is up-to-date.
  */
 int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 {
@@ -598,14 +594,16 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		from = (char *)pde - (char *)page_address(page);
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		goto out;
+	}
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
 	nilfs_commit_chunk(page, mapping, from, to);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 out:
-	nilfs_put_page(page);
 	return err;
 }
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6b2f580c9672..7e4edc588d62 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -170,7 +170,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping, false);
+		nilfs_clear_dirty_pages(mapping);
 		return -EROFS;
 	}
 
@@ -193,7 +193,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -1271,7 +1271,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			if (size) {
 				if (phys && blkphy << blkbits == phys + size) {
 					/* The current extent goes on */
-					size += n << blkbits;
+					size += (u64)n << blkbits;
 				} else {
 					/* Terminate the current extent */
 					ret = fiemap_fill_next_extent(
@@ -1284,14 +1284,14 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 					flags = FIEMAP_EXTENT_MERGED;
 					logical = blkoff << blkbits;
 					phys = blkphy << blkbits;
-					size = n << blkbits;
+					size = (u64)n << blkbits;
 				}
 			} else {
 				/* Start a new extent */
 				flags = FIEMAP_EXTENT_MERGED;
 				logical = blkoff << blkbits;
 				phys = blkphy << blkbits;
-				size = n << blkbits;
+				size = (u64)n << blkbits;
 			}
 			blkoff += n;
 		}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index c1f964916489..1a907acc701d 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -410,7 +410,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -631,10 +631,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
 	if (mi->mi_palloc_cache)
 		nilfs_palloc_clear_cache(inode);
 
-	nilfs_clear_dirty_pages(inode->i_mapping, true);
+	nilfs_clear_dirty_pages(inode->i_mapping);
 	nilfs_copy_back_pages(inode->i_mapping, shadow->inode->i_mapping);
 
-	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
+	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping);
 	nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
 			      NILFS_I(shadow->inode)->i_assoc_inode->i_mapping);
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 446af9c21a29..380af65e9ea1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -295,6 +295,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
+	nilfs_put_page(page);
 	if (err)
 		goto out;
 
@@ -402,7 +403,10 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		err = nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		nilfs_put_page(new_page);
+		if (unlikely(err))
+			goto out_dir;
 		nilfs_mark_inode_dirty(new_dir);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
@@ -425,28 +429,27 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 */
 	old_inode->i_ctime = current_time(old_inode);
 
-	nilfs_delete_entry(old_de, old_page);
-
-	if (dir_de) {
-		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
-		drop_nlink(old_dir);
+	err = nilfs_delete_entry(old_de, old_page);
+	if (likely(!err)) {
+		if (dir_de) {
+			err = nilfs_set_link(old_inode, dir_de, dir_page,
+					     new_dir);
+			drop_nlink(old_dir);
+		}
+		nilfs_mark_inode_dirty(old_dir);
 	}
-	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-	err = nilfs_transaction_commit(old_dir->i_sb);
-	return err;
-
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		nilfs_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	nilfs_put_page(old_page);
 out:
-	nilfs_transaction_abort(old_dir->i_sb);
+	if (likely(!err))
+		err = nilfs_transaction_commit(old_dir->i_sb);
+	else
+		nilfs_transaction_abort(old_dir->i_sb);
 	return err;
 }
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 973231603ff6..df67e013de24 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -240,8 +240,14 @@ nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
 extern int nilfs_delete_entry(struct nilfs_dir_entry *, struct page *);
 extern int nilfs_empty_dir(struct inode *);
 extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
-extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
-			   struct page *, struct inode *);
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+		   struct page *page, struct inode *inode);
+
+static inline void nilfs_put_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
 
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index a5b2fcab6d4a..79925342900e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -355,9 +355,8 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 /**
  * nilfs_clear_dirty_pages - discard dirty pages in address space
  * @mapping: address space with dirty pages for discarding
- * @silent: suppress [true] or print [false] warning messages
  */
-void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
+void nilfs_clear_dirty_pages(struct address_space *mapping)
 {
 	struct pagevec pvec;
 	unsigned int i;
@@ -378,7 +377,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(page->mapping == mapping))
-				nilfs_clear_dirty_page(page, silent);
+				nilfs_clear_dirty_page(page);
 
 			unlock_page(page);
 		}
@@ -390,44 +389,54 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 /**
  * nilfs_clear_dirty_page - discard dirty page
  * @page: dirty page that will be discarded
- * @silent: suppress [true] or print [false] warning messages
+ *
+ * nilfs_clear_dirty_page() clears working states including dirty state for
+ * the page and its buffers.  If the page has buffers, clear only if it is
+ * confirmed that none of the buffer heads are busy (none have valid
+ * references and none are locked).
  */
-void nilfs_clear_dirty_page(struct page *page, bool silent)
+void nilfs_clear_dirty_page(struct page *page)
 {
-	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
-
 	BUG_ON(!PageLocked(page));
 
-	if (!silent)
-		nilfs_warn(sb, "discard dirty page: offset=%lld, ino=%lu",
-			   page_offset(page), inode->i_ino);
-
-	ClearPageUptodate(page);
-	ClearPageMappedToDisk(page);
-	ClearPageChecked(page);
-
 	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+		struct buffer_head *bh, *head = page_buffers(page);
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
 			 BIT(BH_Delay));
+		bool busy, invalidated = false;
 
-		bh = head = page_buffers(page);
+recheck_buffers:
+		busy = false;
+		bh = head;
 		do {
-			lock_buffer(bh);
-			if (!silent)
-				nilfs_warn(sb,
-					   "discard dirty block: blocknr=%llu, size=%zu",
-					   (u64)bh->b_blocknr, bh->b_size);
+			if (atomic_read(&bh->b_count) | buffer_locked(bh)) {
+				busy = true;
+				break;
+			}
+		} while (bh = bh->b_this_page, bh != head);
 
+		if (busy) {
+			if (invalidated)
+				return;
+			invalidate_bh_lrus();
+			invalidated = true;
+			goto recheck_buffers;
+		}
+
+		bh = head;
+		do {
+			lock_buffer(bh);
 			set_mask_bits(&bh->b_state, clear_bits, 0);
 			unlock_buffer(bh);
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
+	ClearPageUptodate(page);
+	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 	__nilfs_clear_page_dirty(page);
 }
 
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 62b9bb469e92..a5b9b5a457ab 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
-void nilfs_clear_dirty_pages(struct address_space *, bool);
+void nilfs_clear_dirty_page(struct page *page);
+void nilfs_clear_dirty_pages(struct address_space *mapping);
 void nilfs_mapping_init(struct address_space *mapping, struct inode *inode);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 9a5dd4106c3d..ad28737122ca 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -732,7 +732,6 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
-		unlock_page(page);
 
 		bh = head = page_buffers(page);
 		do {
@@ -742,11 +741,14 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
+				unlock_page(page);
 				pagevec_release(&pvec);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
+
+		unlock_page(page);
 	}
 	pagevec_release(&pvec);
 	cond_resched();
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 74a3e63242e8..0d3387cb693f 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1067,26 +1067,39 @@ int ocfs2_find_entry(const char *name, int namelen,
 {
 	struct buffer_head *bh;
 	struct ocfs2_dir_entry *res_dir = NULL;
+	int ret = 0;
 
 	if (ocfs2_dir_indexed(dir))
 		return ocfs2_find_entry_dx(name, namelen, dir, lookup);
 
+	if (unlikely(i_size_read(dir) <= 0)) {
+		ret = -EFSCORRUPTED;
+		mlog_errno(ret);
+		goto out;
+	}
 	/*
 	 * The unindexed dir code only uses part of the lookup
 	 * structure, so there's no reason to push it down further
 	 * than this.
 	 */
-	if (OCFS2_I(dir)->ip_dyn_features & OCFS2_INLINE_DATA_FL)
+	if (OCFS2_I(dir)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		if (unlikely(i_size_read(dir) > dir->i_sb->s_blocksize)) {
+			ret = -EFSCORRUPTED;
+			mlog_errno(ret);
+			goto out;
+		}
 		bh = ocfs2_find_entry_id(name, namelen, dir, &res_dir);
-	else
+	} else {
 		bh = ocfs2_find_entry_el(name, namelen, dir, &res_dir);
+	}
 
 	if (bh == NULL)
 		return -ENOENT;
 
 	lookup->dl_leaf_bh = bh;
 	lookup->dl_entry = res_dir;
-	return 0;
+out:
+	return ret;
 }
 
 /*
@@ -2013,6 +2026,7 @@ int ocfs2_lookup_ino_from_name(struct inode *dir, const char *name,
  *
  * Return 0 if the name does not exist
  * Return -EEXIST if the directory contains the name
+ * Return -EFSCORRUPTED if found corruption
  *
  * Callers should have i_mutex + a cluster lock on dir
  */
@@ -2026,9 +2040,12 @@ int ocfs2_check_dir_for_entry(struct inode *dir,
 	trace_ocfs2_check_dir_for_entry(
 		(unsigned long long)OCFS2_I(dir)->ip_blkno, namelen, name);
 
-	if (ocfs2_find_entry(name, namelen, dir, &lookup) == 0) {
+	ret = ocfs2_find_entry(name, namelen, dir, &lookup);
+	if (ret == 0) {
 		ret = -EEXIST;
 		mlog_errno(ret);
+	} else if (ret == -ENOENT) {
+		ret = 0;
 	}
 
 	ocfs2_free_dir_lookup_result(&lookup);
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 1ce3780e8b49..742bf103d2eb 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -749,6 +749,11 @@ static int ocfs2_release_dquot(struct dquot *dquot)
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
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 16b6eed909d4..6ce2c9fbb9db 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2350,7 +2350,7 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			mlog(ML_ERROR, "found superblock with incorrect block "
 			     "size bits: found %u, should be 9, 10, 11, or 12\n",
 			     blksz_bits);
-		} else if ((1 << le32_to_cpu(blksz_bits)) != blksz) {
+		} else if ((1 << blksz_bits) != blksz) {
 			mlog(ML_ERROR, "found superblock with incorrect block "
 			     "size: found %u, should be %u\n", 1 << blksz_bits, blksz);
 		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index 94cfacc9bad7..f3e80c00ca69 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -66,7 +66,7 @@ static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
 
 	if (status < 0) {
 		mlog_errno(status);
-		return status;
+		goto out;
 	}
 
 	fe = (struct ocfs2_dinode *) bh->b_data;
@@ -77,9 +77,10 @@ static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
 	memcpy(kaddr, link, len + 1);
 	kunmap_atomic(kaddr);
 	SetPageUptodate(page);
+out:
 	unlock_page(page);
 	brelse(bh);
-	return 0;
+	return status;
 }
 
 const struct address_space_operations ocfs2_fast_symlink_aops = {
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f543384..fa41db088488 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -393,9 +393,9 @@ static ssize_t orangefs_debug_write(struct file *file,
 	 * Thwart users who try to jamb a ridiculous number
 	 * of bytes into the debug file...
 	 */
-	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN + 1) {
+	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN) {
 		silly = count;
-		count = ORANGEFS_MAX_DEBUG_STRING_LEN + 1;
+		count = ORANGEFS_MAX_DEBUG_STRING_LEN;
 	}
 
 	buf = kzalloc(ORANGEFS_MAX_DEBUG_STRING_LEN, GFP_KERNEL);
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index f31649080a88..95a9ff9e2399 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	gid_t i_gid;
 	int err;
 
+	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
+	if (inode->i_ino == 0)
+		return -EINVAL;
+
 	err = squashfs_get_id(sb, le16_to_cpu(sqsh_ino->uid), &i_uid);
 	if (err)
 		return err;
@@ -58,7 +62,6 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
-	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
 	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
 	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
 	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 992b74f9c941..b5efbaf7eac2 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -925,16 +925,20 @@ void ubifs_dump_tnc(struct ubifs_info *c)
 
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
diff --git a/fs/udf/super.c b/fs/udf/super.c
index a1962c93bd26..9f2de5e7c6e1 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1160,7 +1160,7 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
 		/* Check whether math over bitmap won't overflow. */
 		if (check_add_overflow(map->s_partition_len,
-				       sizeof(struct spaceBitmapDesc) << 3,
+				       (u32)(sizeof(struct spaceBitmapDesc) << 3),
 				       &sum)) {
 			udf_err(sb, "Partition %d is too long (%u)\n", p_index,
 				map->s_partition_len);
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f6f834..bf169cfef7f1 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -24,6 +24,7 @@ extern raw_spinlock_t i8253_lock;
 extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
+extern void clockevent_i8253_disable(void);
 
 extern void setup_pit_timer(void);
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 01517747214a..b70a35b97210 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -575,6 +575,9 @@ static inline struct task_struct *this_cpu_ksoftirqd(void)
 
 /* Tasklets --- multithreaded analogue of BHs.
 
+   This API is deprecated. Please consider using threaded IRQs instead:
+   https://lore.kernel.org/lkml/20200716081538.2sivhkj4hcyrusem@linutronix.de
+
    Main feature differing them of generic softirqs: tasklet
    is running only on one CPU simultaneously.
 
@@ -598,10 +601,31 @@ struct tasklet_struct
 	struct tasklet_struct *next;
 	unsigned long state;
 	atomic_t count;
-	void (*func)(unsigned long);
+	bool use_callback;
+	union {
+		void (*func)(unsigned long data);
+		void (*callback)(struct tasklet_struct *t);
+	};
 	unsigned long data;
 };
 
+#define DECLARE_TASKLET(name, _callback)		\
+struct tasklet_struct name = {				\
+	.count = ATOMIC_INIT(0),			\
+	.callback = _callback,				\
+	.use_callback = true,				\
+}
+
+#define DECLARE_TASKLET_DISABLED(name, _callback)	\
+struct tasklet_struct name = {				\
+	.count = ATOMIC_INIT(1),			\
+	.callback = _callback,				\
+	.use_callback = true,				\
+}
+
+#define from_tasklet(var, callback_tasklet, tasklet_fieldname)	\
+	container_of(callback_tasklet, typeof(*var), tasklet_fieldname)
+
 #define DECLARE_TASKLET_OLD(name, _func)		\
 struct tasklet_struct name = {				\
 	.count = ATOMIC_INIT(0),			\
@@ -681,6 +705,8 @@ extern void tasklet_kill(struct tasklet_struct *t);
 extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
+extern void tasklet_setup(struct tasklet_struct *t,
+			  void (*callback)(struct tasklet_struct *));
 
 /*
  * Autoprobing for irqs:
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 1f96ce2b47df..d84b677c728a 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -63,10 +63,10 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 
 	preempt_disable();
 	mod = __module_address((unsigned long)ptr);
-	preempt_enable();
 
 	if (mod)
 		ptr = dereference_module_function_descriptor(mod, ptr);
+	preempt_enable();
 #endif
 	return ptr;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ee7d57478a45..81812f60c63c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -567,6 +567,15 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 {
 	int num_vcpus = atomic_read(&kvm->online_vcpus);
+
+	/*
+	 * Explicitly verify the target vCPU is online, as the anti-speculation
+	 * logic only limits the CPU's ability to speculate, e.g. given a "bad"
+	 * index, clamping the index to 0 would return vCPU0, not NULL.
+	 */
+	if (i >= num_vcpus)
+		return NULL;
+
 	i = array_index_nospec(i, num_vcpus);
 
 	/* Pairs with smp_wmb() in kvm_vm_ioctl_create_vcpu.  */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a6bb64dccb88..f5c1058f565c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2216,6 +2216,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 63e7c77ba942..54788a3cdcf5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -44,41 +44,61 @@
 #define is_non_negative(a) ((a) > 0 || (a) == 0)
 #define is_negative(a) (!(is_non_negative(a)))
 
-#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
+ * Allows for effectively applying __must_check to a macro so we can have
+ * both the type-agnostic benefits of the macros while also being able to
+ * enforce that the return value is, in fact, checked.
  */
-#define check_add_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-})
+static inline bool __must_check __must_check_overflow(bool overflow)
+{
+	return unlikely(overflow);
+}
 
-#define check_sub_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-})
+#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
+ */
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-#define check_mul_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-})
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
+
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 #else
 
@@ -191,21 +211,20 @@
 })
 
 
-#define check_add_overflow(a, b, d)					\
+#define check_add_overflow(a, b, d)	__must_check_overflow(		\
 	__builtin_choose_expr(is_signed_type(typeof(a)),		\
 			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d))
+			__unsigned_add_overflow(a, b, d)))
 
-#define check_sub_overflow(a, b, d)					\
+#define check_sub_overflow(a, b, d)	__must_check_overflow(		\
 	__builtin_choose_expr(is_signed_type(typeof(a)),		\
 			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d))
+			__unsigned_sub_overflow(a, b, d)))
 
-#define check_mul_overflow(a, b, d)					\
+#define check_mul_overflow(a, b, d)	__must_check_overflow(		\
 	__builtin_choose_expr(is_signed_type(typeof(a)),		\
 			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d))
-
+			__unsigned_mul_overflow(a, b, d)))
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
@@ -226,9 +245,9 @@
  * - 'a << s' sets the sign bit, if any, in '*d'.
  *
  * '*d' will hold the results of the attempted shift, but is not
- * considered "safe for use" if false is returned.
+ * considered "safe for use" if true is returned.
  */
-#define check_shl_overflow(a, s, d) ({					\
+#define check_shl_overflow(a, s, d) __must_check_overflow(({		\
 	typeof(a) _a = a;						\
 	typeof(s) _s = s;						\
 	typeof(d) _d = d;						\
@@ -238,7 +257,7 @@
 	*_d = (_a_full << _to_shift);					\
 	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
 	(*_d >> _to_shift) != _a);					\
-})
+}))
 
 /**
  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3272705105b1..840d095cd369 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1764,6 +1764,10 @@
 #define PCI_SUBDEVICE_ID_AT_2700FX	0x2701
 #define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
 
+#define PCI_VENDOR_ID_ASIX		0x125b
+#define PCI_DEVICE_ID_ASIX_AX99100	0x9100
+#define PCI_DEVICE_ID_ASIX_AX99100_LB	0x9110
+
 #define PCI_VENDOR_ID_ESS		0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
 #define PCI_DEVICE_ID_ESS_ESS1978	0x1978
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
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index a57e023755aa..0c00709ead14 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -385,8 +385,9 @@ struct hc_driver {
 		 * or bandwidth constraints.
 		 */
 	void	(*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
-		/* Returns the hardware-chosen device address */
-	int	(*address_device)(struct usb_hcd *, struct usb_device *udev);
+		/* Set the hardware-chosen device address */
+	int	(*address_device)(struct usb_hcd *, struct usb_device *udev,
+				  unsigned int timeout_ms);
 		/* prepares the hardware to send commands to the device */
 	int	(*enable_device)(struct usb_hcd *, struct usb_device *udev);
 		/* Notifies the HCD after a hub descriptor is fetched.
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 02171416c68e..efd7987982a8 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -158,6 +158,22 @@ struct flow_dissector_key_ports {
 	};
 };
 
+/**
+ * struct flow_dissector_key_ports_range
+ * @tp: port number from packet
+ * @tp_min: min port number in range
+ * @tp_max: max port number in range
+ */
+struct flow_dissector_key_ports_range {
+	union {
+		struct flow_dissector_key_ports tp;
+		struct {
+			struct flow_dissector_key_ports tp_min;
+			struct flow_dissector_key_ports tp_max;
+		};
+	};
+};
+
 /**
  * flow_dissector_key_icmp:
  *	@ports: type and code of ICMP header
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index c6f7bd22db60..dc4274dcdec7 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -48,6 +48,10 @@ struct flow_match_ports {
 	struct flow_dissector_key_ports *key, *mask;
 };
 
+struct flow_match_ports_range {
+	struct flow_dissector_key_ports_range *key, *mask;
+};
+
 struct flow_match_icmp {
 	struct flow_dissector_key_icmp *key, *mask;
 };
@@ -90,6 +94,8 @@ void flow_rule_match_ip(const struct flow_rule *rule,
 			struct flow_match_ip *out);
 void flow_rule_match_ports(const struct flow_rule *rule,
 			   struct flow_match_ports *out);
+void flow_rule_match_ports_range(const struct flow_rule *rule,
+				 struct flow_match_ports_range *out);
 void flow_rule_match_tcp(const struct flow_rule *rule,
 			 struct flow_match_tcp *out);
 void flow_rule_match_icmp(const struct flow_rule *rule,
diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index e942372b077b..062da1588be0 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -179,10 +179,12 @@ struct sk_buff *l3mdev_l3_out(struct sock *sk, struct sk_buff *skb, u16 proto)
 	if (netif_is_l3_slave(dev)) {
 		struct net_device *master;
 
+		rcu_read_lock();
 		master = netdev_master_upper_dev_get_rcu(dev);
 		if (master && master->l3mdev_ops->l3mdev_l3_out)
 			skb = master->l3mdev_ops->l3mdev_l3_out(master, sk,
 								skb, proto);
+		rcu_read_unlock();
 	}
 
 	return skb;
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0d61b452b908..334286b57994 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -310,21 +310,30 @@ static inline int check_net(const struct net *net)
 
 typedef struct {
 #ifdef CONFIG_NET_NS
-	struct net *net;
+	struct net __rcu *net;
 #endif
 } possible_net_t;
 
 static inline void write_pnet(possible_net_t *pnet, struct net *net)
 {
 #ifdef CONFIG_NET_NS
-	pnet->net = net;
+	rcu_assign_pointer(pnet->net, net);
 #endif
 }
 
 static inline struct net *read_pnet(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
-	return pnet->net;
+	return rcu_dereference_protected(pnet->net, true);
+#else
+	return &init_net;
+#endif
+}
+
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
+{
+#ifdef CONFIG_NET_NS
+	return rcu_dereference(pnet->net);
 #else
 	return &init_net;
 #endif
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..b799f3bcba82 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -7,6 +7,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+#define PG_COUNT_TO_KB(x) ((x) << (PAGE_SHIFT - 10))
+
 TRACE_EVENT(oom_score_adj_update,
 
 	TP_PROTO(struct task_struct *task),
@@ -72,19 +74,45 @@ TRACE_EVENT(reclaim_retry_zone,
 );
 
 TRACE_EVENT(mark_victim,
-	TP_PROTO(int pid),
+	TP_PROTO(struct task_struct *task, uid_t uid),
 
-	TP_ARGS(pid),
+	TP_ARGS(task, uid),
 
 	TP_STRUCT__entry(
 		__field(int, pid)
+		__string(comm, task->comm)
+		__field(unsigned long, total_vm)
+		__field(unsigned long, anon_rss)
+		__field(unsigned long, file_rss)
+		__field(unsigned long, shmem_rss)
+		__field(uid_t, uid)
+		__field(unsigned long, pgtables)
+		__field(short, oom_score_adj)
 	),
 
 	TP_fast_assign(
-		__entry->pid = pid;
+		__entry->pid = task->pid;
+		__assign_str(comm, task->comm);
+		__entry->total_vm = PG_COUNT_TO_KB(task->mm->total_vm);
+		__entry->anon_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_ANONPAGES));
+		__entry->file_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_FILEPAGES));
+		__entry->shmem_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_SHMEMPAGES));
+		__entry->uid = uid;
+		__entry->pgtables = mm_pgtables_bytes(task->mm) >> 10;
+		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d", __entry->pid)
+	TP_printk("pid=%d comm=%s total-vm=%lukB anon-rss=%lukB file-rss:%lukB shmem-rss:%lukB uid=%u pgtables=%lukB oom_score_adj=%hd",
+		__entry->pid,
+		__get_str(comm),
+		__entry->total_vm,
+		__entry->anon_rss,
+		__entry->file_rss,
+		__entry->shmem_rss,
+		__entry->uid,
+		__entry->pgtables,
+		__entry->oom_score_adj
+	)
 );
 
 TRACE_EVENT(wake_reaper,
diff --git a/kernel/acct.c b/kernel/acct.c
index 6d98aed403ba..bddb31472f9e 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -85,48 +85,50 @@ struct bsd_acct_struct {
 	atomic_long_t		count;
 	struct rcu_head		rcu;
 	struct mutex		lock;
-	int			active;
+	bool			active;
+	bool			check_space;
 	unsigned long		needcheck;
 	struct file		*file;
 	struct pid_namespace	*ns;
 	struct work_struct	work;
 	struct completion	done;
+	acct_t			ac;
 };
 
-static void do_acct_process(struct bsd_acct_struct *acct);
+static void fill_ac(struct bsd_acct_struct *acct);
+static void acct_write_process(struct bsd_acct_struct *acct);
 
 /*
  * Check the amount of free space and suspend/resume accordingly.
  */
-static int check_free_space(struct bsd_acct_struct *acct)
+static bool check_free_space(struct bsd_acct_struct *acct)
 {
 	struct kstatfs sbuf;
 
-	if (time_is_after_jiffies(acct->needcheck))
-		goto out;
+	if (!acct->check_space)
+		return acct->active;
 
 	/* May block */
 	if (vfs_statfs(&acct->file->f_path, &sbuf))
-		goto out;
+		return acct->active;
 
 	if (acct->active) {
 		u64 suspend = sbuf.f_blocks * SUSPEND;
 		do_div(suspend, 100);
 		if (sbuf.f_bavail <= suspend) {
-			acct->active = 0;
+			acct->active = false;
 			pr_info("Process accounting paused\n");
 		}
 	} else {
 		u64 resume = sbuf.f_blocks * RESUME;
 		do_div(resume, 100);
 		if (sbuf.f_bavail >= resume) {
-			acct->active = 1;
+			acct->active = true;
 			pr_info("Process accounting resumed\n");
 		}
 	}
 
 	acct->needcheck = jiffies + ACCT_TIMEOUT*HZ;
-out:
 	return acct->active;
 }
 
@@ -171,7 +173,11 @@ static void acct_pin_kill(struct fs_pin *pin)
 {
 	struct bsd_acct_struct *acct = to_acct(pin);
 	mutex_lock(&acct->lock);
-	do_acct_process(acct);
+	/*
+	 * Fill the accounting struct with the exiting task's info
+	 * before punting to the workqueue.
+	 */
+	fill_ac(acct);
 	schedule_work(&acct->work);
 	wait_for_completion(&acct->done);
 	cmpxchg(&acct->ns->bacct, pin, NULL);
@@ -184,6 +190,9 @@ static void close_work(struct work_struct *work)
 {
 	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
 	struct file *file = acct->file;
+
+	/* We were fired by acct_pin_kill() which holds acct->lock. */
+	acct_write_process(acct);
 	if (file->f_op->flush)
 		file->f_op->flush(file, NULL);
 	__fput_sync(file);
@@ -216,6 +225,20 @@ static int acct_on(struct filename *pathname)
 		return -EACCES;
 	}
 
+	/* Exclude kernel kernel internal filesystems. */
+	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
+	/* Exclude procfs and sysfs. */
+	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
 	if (!(file->f_mode & FMODE_CAN_WRITE)) {
 		kfree(acct);
 		filp_close(file, NULL);
@@ -383,9 +406,7 @@ static comp2_t encode_comp2_t(u64 value)
 		return (value & (MAXFRACT2>>1)) | (exp << (MANTSIZE2-1));
 	}
 }
-#endif
-
-#if ACCT_VERSION == 3
+#elif ACCT_VERSION == 3
 /*
  * encode an u64 into a 32 bit IEEE float
  */
@@ -414,12 +435,26 @@ static u32 encode_float(u64 value)
  *  do_exit() or when switching to a different output file.
  */
 
-static void fill_ac(acct_t *ac)
+static void fill_ac(struct bsd_acct_struct *acct)
 {
 	struct pacct_struct *pacct = &current->signal->pacct;
+	struct file *file = acct->file;
+	acct_t *ac = &acct->ac;
 	u64 elapsed, run_time;
 	struct tty_struct *tty;
 
+	lockdep_assert_held(&acct->lock);
+
+	if (time_is_after_jiffies(acct->needcheck)) {
+		acct->check_space = false;
+
+		/* Don't fill in @ac if nothing will be written. */
+		if (!acct->active)
+			return;
+	} else {
+		acct->check_space = true;
+	}
+
 	/*
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
@@ -466,65 +501,61 @@ static void fill_ac(acct_t *ac)
 	ac->ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac->ac_exitcode = pacct->ac_exitcode;
 	spin_unlock_irq(&current->sighand->siglock);
-}
-/*
- *  do_acct_process does all actual work. Caller holds the reference to file.
- */
-static void do_acct_process(struct bsd_acct_struct *acct)
-{
-	acct_t ac;
-	unsigned long flim;
-	const struct cred *orig_cred;
-	struct file *file = acct->file;
 
-	/*
-	 * Accounting records are not subject to resource limits.
-	 */
-	flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
-	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
-	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(file->f_cred);
-
-	/*
-	 * First check to see if there is enough free_space to continue
-	 * the process accounting system.
-	 */
-	if (!check_free_space(acct))
-		goto out;
-
-	fill_ac(&ac);
 	/* we really need to bite the bullet and change layout */
-	ac.ac_uid = from_kuid_munged(file->f_cred->user_ns, orig_cred->uid);
-	ac.ac_gid = from_kgid_munged(file->f_cred->user_ns, orig_cred->gid);
+	ac->ac_uid = from_kuid_munged(file->f_cred->user_ns, current_uid());
+	ac->ac_gid = from_kgid_munged(file->f_cred->user_ns, current_gid());
 #if ACCT_VERSION == 1 || ACCT_VERSION == 2
 	/* backward-compatible 16 bit fields */
-	ac.ac_uid16 = ac.ac_uid;
-	ac.ac_gid16 = ac.ac_gid;
-#endif
-#if ACCT_VERSION == 3
+	ac->ac_uid16 = ac->ac_uid;
+	ac->ac_gid16 = ac->ac_gid;
+#elif ACCT_VERSION == 3
 	{
 		struct pid_namespace *ns = acct->ns;
 
-		ac.ac_pid = task_tgid_nr_ns(current, ns);
+		ac->ac_pid = task_tgid_nr_ns(current, ns);
 		rcu_read_lock();
-		ac.ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent),
-					     ns);
+		ac->ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent), ns);
 		rcu_read_unlock();
 	}
 #endif
+}
+
+static void acct_write_process(struct bsd_acct_struct *acct)
+{
+	struct file *file = acct->file;
+	const struct cred *cred;
+	acct_t *ac = &acct->ac;
+
+	/* Perform file operations on behalf of whoever enabled accounting */
+	cred = override_creds(file->f_cred);
+
 	/*
-	 * Get freeze protection. If the fs is frozen, just skip the write
-	 * as we could deadlock the system otherwise.
+	 * First check to see if there is enough free_space to continue
+	 * the process accounting system. Then get freeze protection. If
+	 * the fs is frozen, just skip the write as we could deadlock
+	 * the system otherwise.
 	 */
-	if (file_start_write_trylock(file)) {
+	if (check_free_space(acct) && file_start_write_trylock(file)) {
 		/* it's been opened O_APPEND, so position is irrelevant */
 		loff_t pos = 0;
-		__kernel_write(file, &ac, sizeof(acct_t), &pos);
+		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-out:
+
+	revert_creds(cred);
+}
+
+static void do_acct_process(struct bsd_acct_struct *acct)
+{
+	unsigned long flim;
+
+	/* Accounting records are not subject to resource limits. */
+	flim = rlimit(RLIMIT_FSIZE);
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	fill_ac(acct);
+	acct_write_process(acct);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	revert_creds(orig_cred);
 }
 
 /**
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e1e546d742be..dd55fd475f12 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5217,14 +5217,15 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (!value)
 		return -EINVAL;
 
-	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
-		return -EINVAL;
-
-	if (perf_event_check_period(event, value))
-		return -EINVAL;
-
-	if (!event->attr.freq && (value & (1ULL << 63)))
-		return -EINVAL;
+	if (event->attr.freq) {
+		if (value > sysctl_perf_event_sample_rate)
+			return -EINVAL;
+	} else {
+		if (perf_event_check_period(event, value))
+			return -EINVAL;
+		if (value & (1ULL << 63))
+			return -EINVAL;
+	}
 
 	event_function_call(event, __perf_event_period, &value);
 
diff --git a/kernel/padata.c b/kernel/padata.c
index a544da60014c..47aebcda65d5 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -940,7 +940,7 @@ static ssize_t padata_sysfs_store(struct kobject *kobj, struct attribute *attr,
 
 	pinst = kobj2pinst(kobj);
 	pentry = attr2pentry(attr);
-	if (pentry->show)
+	if (pentry->store)
 		ret = pentry->store(pinst, attr, buf, count);
 
 	return ret;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f8934f9746e6..78d913a082be 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -578,7 +578,11 @@ int hibernation_platform_enter(void)
 
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
@@ -590,6 +594,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+ Enable_irqs:
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ae1a97dd0c3c..f6e1e154d9c1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -457,7 +457,7 @@ static u32 clear_idx;
 /* record buffer */
 #define LOG_ALIGN __alignof__(struct printk_log)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51ac62637e4e..d71fe6fe4c98 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -176,13 +176,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-		steal = paravirt_steal_clock(cpu_of(rq));
+		u64 prev_steal;
+
+		steal = prev_steal = paravirt_steal_clock(cpu_of(rq));
 		steal -= rq->prev_steal_time_rq;
 
 		if (unlikely(steal > delta))
 			steal = delta;
 
-		rq->prev_steal_time_rq += steal;
+		rq->prev_steal_time_rq = prev_steal;
 		delta -= steal;
 	}
 #endif
@@ -5712,7 +5714,7 @@ SYSCALL_DEFINE0(sched_yield)
 #ifndef CONFIG_PREEMPTION
 int __sched _cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && !irqs_disabled()) {
 		preempt_schedule_common();
 		return 1;
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0427a86743a4..c5518b39cb4e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -520,7 +520,10 @@ static void tasklet_action_common(struct softirq_action *a,
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
 							&t->state))
 					BUG();
-				t->func(t->data);
+				if (t->use_callback)
+					t->callback(t);
+				else
+					t->func(t->data);
 				tasklet_unlock(t);
 				continue;
 			}
@@ -546,6 +549,18 @@ static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
 	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
 
+void tasklet_setup(struct tasklet_struct *t,
+		   void (*callback)(struct tasklet_struct *))
+{
+	t->next = NULL;
+	t->state = 0;
+	atomic_set(&t->count, 0);
+	t->callback = callback;
+	t->use_callback = true;
+	t->data = 0;
+}
+EXPORT_SYMBOL(tasklet_setup);
+
 void tasklet_init(struct tasklet_struct *t,
 		  void (*func)(unsigned long), unsigned long data)
 {
@@ -553,6 +568,7 @@ void tasklet_init(struct tasklet_struct *t,
 	t->state = 0;
 	atomic_set(&t->count, 0);
 	t->func = func;
+	t->use_callback = false;
 	t->data = data;
 }
 EXPORT_SYMBOL(tasklet_init);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4a31763a8c5d..ac3125d0c73f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -653,7 +653,7 @@ BPF_CALL_1(bpf_send_signal, u32, sig)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (irqs_disabled()) {
+	if (!preemptible()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2eb1a8ec5755..fd393ae98706 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -514,6 +514,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
+	unsigned long long stddev_denom;
 #endif
 	mutex_lock(&ftrace_profile_lock);
 
@@ -535,23 +536,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
 
-	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
-		stddev = 0;
-	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
+	/*
+	 * Variance formula:
+	 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+	 * Maybe Welford's method is better here?
+	 * Divide only by 1000 for ns^2 -> us^2 conversion.
+	 * trace_print_graph_duration will divide by 1000 again.
+	 */
+	stddev = 0;
+	stddev_denom = rec->counter * (rec->counter - 1) * 1000;
+	if (stddev_denom) {
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
-
-		/*
-		 * Divide only 1000 for ns^2 -> us^2 conversion.
-		 * trace_print_graph_duration will divide 1000 again.
-		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, stddev_denom);
 	}
 
 	trace_seq_init(&s);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5ac119509335..6f5565553e5f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1221,6 +1221,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
+	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1229,8 +1230,12 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
index ee927ffeb718..a1a32864fdf8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -42,6 +42,8 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/cred.h>
+#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -429,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
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
@@ -721,6 +728,7 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
  */
 static void mark_oom_victim(struct task_struct *tsk)
 {
+	const struct cred *cred;
 	struct mm_struct *mm = tsk->mm;
 
 	WARN_ON(oom_killer_disabled);
@@ -742,7 +750,9 @@ static void mark_oom_victim(struct task_struct *tsk)
 	 */
 	__thaw_task(tsk);
 	atomic_inc(&oom_victims);
-	trace_mark_victim(tsk->pid);
+	cred = get_task_cred(tsk);
+	trace_mark_victim(tsk, cred->uid.val);
+	put_cred(cred);
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0ad582945f54..a0c01c3575bc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4469,6 +4469,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
+	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 796d95797ab4..c75fca3eed49 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -124,7 +124,8 @@ int vlan_check_real_dev(struct net_device *real_dev,
 {
 	const char *name = real_dev->name;
 
-	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (real_dev->features & NETIF_F_VLAN_CHALLENGED ||
+	    real_dev->type != ARPHRD_ETHER) {
 		pr_info("VLANs not supported on %s\n", name);
 		NL_SET_ERR_MSG_MOD(extack, "VLANs not supported on device");
 		return -EOPNOTSUPP;
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index bb7ec1a3915d..6728d1593929 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -117,6 +117,7 @@ void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
 int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio);
+void vlan_dev_free_egress_priority(const struct net_device *dev);
 int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result);
 
@@ -126,7 +127,6 @@ int vlan_check_real_dev(struct net_device *real_dev,
 void vlan_setup(struct net_device *dev);
 int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack);
 void unregister_vlan_dev(struct net_device *dev, struct list_head *head);
-void vlan_dev_uninit(struct net_device *dev);
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev);
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 0a3a16791621..b5384e5fb781 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -590,7 +590,7 @@ static int vlan_dev_init(struct net_device *dev)
 }
 
 /* Note: this function might be called multiple times for the same device. */
-void vlan_dev_uninit(struct net_device *dev)
+void vlan_dev_free_egress_priority(const struct net_device *dev)
 {
 	struct vlan_priority_tci_mapping *pm;
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
@@ -604,6 +604,16 @@ void vlan_dev_uninit(struct net_device *dev)
 	}
 }
 
+static void vlan_dev_uninit(struct net_device *dev)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+
+	vlan_dev_free_egress_priority(dev);
+
+	/* Get rid of the vlan's reference to real_dev */
+	dev_put(vlan->real_dev);
+}
+
 static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
@@ -793,9 +803,6 @@ static void vlan_dev_free(struct net_device *dev)
 
 	free_percpu(vlan->vlan_pcpu_stats);
 	vlan->vlan_pcpu_stats = NULL;
-
-	/* Get rid of the vlan's reference to real_dev */
-	dev_put(vlan->real_dev);
 }
 
 void vlan_setup(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 99b277775257..dca1ec705b6c 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -187,10 +187,11 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 
 	err = vlan_changelink(dev, tb, data, extack);
-	if (!err)
-		err = register_vlan_dev(dev, extack);
 	if (err)
-		vlan_dev_uninit(dev);
+		return err;
+	err = register_vlan_dev(dev, extack);
+	if (err)
+		vlan_dev_free_egress_priority(dev);
 	return err;
 }
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 64054edc2e3c..8a68f68109bf 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -115,8 +115,6 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
-	INIT_WORK(&hardif_neigh->bat_v.metric_work,
-		  batadv_v_elp_throughput_metric_update);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index aae73f94b2c8..b6d580494b89 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
 #include <linux/random.h>
@@ -25,6 +26,7 @@
 #include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -40,6 +42,18 @@
 #include "routing.h"
 #include "send.h"
 
+/**
+ * struct batadv_v_metric_queue_entry - list of hardif neighbors which require
+ *  and metric update
+ */
+struct batadv_v_metric_queue_entry {
+	/** @hardif_neigh: hardif neighbor scheduled for metric update */
+	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	/** @list: list node for metric_queue */
+	struct list_head list;
+};
+
 /**
  * batadv_v_elp_start_timer() - restart timer for ELP periodic work
  * @hard_iface: the interface for which the timer has to be reset
@@ -58,25 +72,36 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
+ * @pthroughput: calculated throughput towards the given neighbour in multiples
+ *  of 100kpbs (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
  *
- * Return: The throughput towards the given neighbour in multiples of 100kpbs
- *         (a value of '1' equals to 0.1Mbps, '10' equals 1Mbps, etc).
+ * Return: true when value behind @pthroughput was set
  */
-static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
+static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
+					u32 *pthroughput)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct net_device *soft_iface = hard_iface->soft_iface;
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
 
+	/* don't query throughput when no longer associated with any
+	 * batman-adv interface
+	 */
+	if (!soft_iface)
+		return false;
+
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
 	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
-	if (throughput != 0)
-		return throughput;
+	if (throughput != 0) {
+		*pthroughput = throughput;
+		return true;
+	}
 
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
@@ -103,21 +128,31 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 * possible to delete this neighbor. For now set
 			 * the throughput metric to 0.
 			 */
-			return 0;
+			*pthroughput = 0;
+			return true;
 		}
 		if (ret)
 			goto default_throughput;
 		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
 			goto default_throughput;
 
-		return sinfo.expected_throughput / 100;
+		*pthroughput = sinfo.expected_throughput / 100;
+		return true;
 	}
 
+	memset(&link_settings, 0, sizeof(link_settings));
+
+	/* only use rtnl_trylock because the elp worker will be cancelled while
+	 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+	 * wait forever when the elp work_item was started and it is then also
+	 * trying to rtnl_lock
+	 */
+	if (!rtnl_trylock())
+		return false;
+
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	memset(&link_settings, 0, sizeof(link_settings));
-	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
 	if (ret == 0) {
@@ -128,13 +163,15 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
 
 		throughput = link_settings.base.speed;
-		if (throughput && throughput != SPEED_UNKNOWN)
-			return throughput * 10;
+		if (throughput && throughput != SPEED_UNKNOWN) {
+			*pthroughput = throughput * 10;
+			return true;
+		}
 	}
 
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(soft_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
 			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,
@@ -143,31 +180,26 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	}
 
 	/* if none of the above cases apply, return the base_throughput */
-	return BATADV_THROUGHPUT_DEFAULT_VALUE;
+	*pthroughput = BATADV_THROUGHPUT_DEFAULT_VALUE;
+	return true;
 }
 
 /**
  * batadv_v_elp_throughput_metric_update() - worker updating the throughput
  *  metric of a single hop neighbour
- * @work: the work queue item
+ * @neigh: the neighbour to probe
  */
-void batadv_v_elp_throughput_metric_update(struct work_struct *work)
+static void
+batadv_v_elp_throughput_metric_update(struct batadv_hardif_neigh_node *neigh)
 {
-	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
-	struct batadv_hardif_neigh_node *neigh;
-
-	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
-				   metric_work);
-	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
-			     bat_v);
+	u32 throughput;
+	bool valid;
 
-	ewma_throughput_add(&neigh->bat_v.throughput,
-			    batadv_v_elp_get_throughput(neigh));
+	valid = batadv_v_elp_get_throughput(neigh, &throughput);
+	if (!valid)
+		return;
 
-	/* decrement refcounter to balance increment performed before scheduling
-	 * this task
-	 */
-	batadv_hardif_neigh_put(neigh);
+	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
 }
 
 /**
@@ -241,14 +273,16 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
  */
 static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
+	struct batadv_v_metric_queue_entry *metric_entry;
+	struct batadv_v_metric_queue_entry *metric_safe;
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
 	struct batadv_elp_packet *elp_packet;
+	struct list_head metric_queue;
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
-	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -284,6 +318,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+	INIT_LIST_HEAD(&metric_queue);
+
 	/* The throughput metric is updated on each sent packet. This way, if a
 	 * node is dead and no longer sends packets, batman-adv is still able to
 	 * react timely to its death.
@@ -308,16 +344,28 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 		/* Reading the estimated throughput from cfg80211 is a task that
 		 * may sleep and that is not allowed in an rcu protected
-		 * context. Therefore schedule a task for that.
+		 * context. Therefore add it to metric_queue and process it
+		 * outside rcu protected context.
 		 */
-		ret = queue_work(batadv_event_workqueue,
-				 &hardif_neigh->bat_v.metric_work);
-
-		if (!ret)
+		metric_entry = kzalloc(sizeof(*metric_entry), GFP_ATOMIC);
+		if (!metric_entry) {
 			batadv_hardif_neigh_put(hardif_neigh);
+			continue;
+		}
+
+		metric_entry->hardif_neigh = hardif_neigh;
+		list_add(&metric_entry->list, &metric_queue);
 	}
 	rcu_read_unlock();
 
+	list_for_each_entry_safe(metric_entry, metric_safe, &metric_queue, list) {
+		batadv_v_elp_throughput_metric_update(metric_entry->hardif_neigh);
+
+		batadv_hardif_neigh_put(metric_entry->hardif_neigh);
+		list_del(&metric_entry->list);
+		kfree(metric_entry);
+	}
+
 restart_timer:
 	batadv_v_elp_start_timer(hard_iface);
 out:
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 1a29505f4f66..5595fa531d7c 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -10,7 +10,6 @@
 #include "main.h"
 
 #include <linux/skbuff.h>
-#include <linux/workqueue.h>
 
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
@@ -19,6 +18,5 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
-void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9fdf1be9b99b..a4a4c0c0c887 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -603,9 +603,6 @@ struct batadv_hardif_neigh_node_bat_v {
 	 *  neighbor
 	 */
 	unsigned long last_unicast_tx;
-
-	/** @metric_work: work queue callback item for metric update */
-	struct work_struct metric_work;
 };
 
 /**
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6ec6f6a06521..e6d93501e106 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1678,7 +1678,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
-		sock->sk = NULL;
+		if (sock)
+			sock->sk = NULL;
 		return NULL;
 	}
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 2e3dc74fea21..29f9a343b0db 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1055,7 +1055,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 	todo_size = size;
 
-	while (todo_size) {
+	do {
 		struct j1939_sk_buff_cb *skcb;
 
 		segment_size = min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
@@ -1100,7 +1100,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
-	}
+	} while (todo_size);
 
 	switch (ret) {
 	case 0: /* OK */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 7cef19287a3f..d75b71f6491a 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -378,8 +378,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j1939_session *session,
 	skb_queue_walk(&session->skb_queue, do_skb) {
 		do_skcb = j1939_skb_to_cb(do_skb);
 
-		if (offset_start >= do_skcb->offset &&
-		    offset_start < (do_skcb->offset + do_skb->len)) {
+		if ((offset_start >= do_skcb->offset &&
+		     offset_start < (do_skcb->offset + do_skb->len)) ||
+		     (offset_start == 0 && do_skcb->offset == 0 && do_skb->len == 0)) {
 			skb = do_skb;
 		}
 	}
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index b37465af47e4..0c8afafcce43 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1650,30 +1650,30 @@ static int __init init_net_drop_monitor(void)
 		return -ENOSPC;
 	}
 
-	rc = genl_register_family(&net_drop_monitor_family);
-	if (rc) {
-		pr_err("Could not create drop monitor netlink family\n");
-		return rc;
+	for_each_possible_cpu(cpu) {
+		net_dm_cpu_data_init(cpu);
+		net_dm_hw_cpu_data_init(cpu);
 	}
-	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = register_netdevice_notifier(&dropmon_net_notifier);
 	if (rc < 0) {
 		pr_crit("Failed to register netdevice notifier\n");
+		return rc;
+	}
+
+	rc = genl_register_family(&net_drop_monitor_family);
+	if (rc) {
+		pr_err("Could not create drop monitor netlink family\n");
 		goto out_unreg;
 	}
+	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = 0;
 
-	for_each_possible_cpu(cpu) {
-		net_dm_cpu_data_init(cpu);
-		net_dm_hw_cpu_data_init(cpu);
-	}
-
 	goto out;
 
 out_unreg:
-	genl_unregister_family(&net_drop_monitor_family);
+	WARN_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 out:
 	return rc;
 }
@@ -1682,19 +1682,18 @@ static void exit_net_drop_monitor(void)
 {
 	int cpu;
 
-	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
-
 	/*
 	 * Because of the module_get/put we do in the trace state change path
 	 * we are guarnateed not to have any current users when we get here
 	 */
+	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
+
+	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 
 	for_each_possible_cpu(cpu) {
 		net_dm_hw_cpu_data_fini(cpu);
 		net_dm_cpu_data_fini(cpu);
 	}
-
-	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
 }
 
 module_init(init_net_drop_monitor);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5daa72a930a9..96d2635aaae0 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -705,23 +705,30 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 			 void *target_container, void *data, int nhoff,
 			 u8 ip_proto, int hlen)
 {
-	enum flow_dissector_key_id dissector_ports = FLOW_DISSECTOR_KEY_MAX;
-	struct flow_dissector_key_ports *key_ports;
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
+	struct flow_dissector_key_ports *key_ports = NULL;
+	__be32 ports;
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS;
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS_RANGE;
+		key_ports = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_PORTS,
+						      target_container);
 
-	if (dissector_ports == FLOW_DISSECTOR_KEY_MAX)
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS_RANGE))
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+
+	if (!key_ports && !key_ports_range)
 		return;
 
-	key_ports = skb_flow_dissector_target(flow_dissector,
-					      dissector_ports,
-					      target_container);
-	key_ports->ports = __skb_flow_get_ports(skb, nhoff, ip_proto,
-						data, hlen);
+	ports = __skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
+
+	if (key_ports)
+		key_ports->ports = ports;
+
+	if (key_ports_range)
+		key_ports_range->tp.ports = ports;
 }
 
 static void
@@ -774,6 +781,7 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 				     struct flow_dissector *flow_dissector,
 				     void *target_container)
 {
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
 	struct flow_dissector_key_ports *key_ports = NULL;
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_basic *key_basic;
@@ -818,20 +826,21 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	}
 
-	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS)) {
 		key_ports = skb_flow_dissector_target(flow_dissector,
 						      FLOW_DISSECTOR_KEY_PORTS,
 						      target_container);
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		key_ports = skb_flow_dissector_target(flow_dissector,
-						      FLOW_DISSECTOR_KEY_PORTS_RANGE,
-						      target_container);
-
-	if (key_ports) {
 		key_ports->src = flow_keys->sport;
 		key_ports->dst = flow_keys->dport;
 	}
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+		key_ports_range->tp.src = flow_keys->sport;
+		key_ports_range->tp.dst = flow_keys->dport;
+	}
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 45b6a59ac124..3d54eca5960d 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -97,6 +97,13 @@ void flow_rule_match_ports(const struct flow_rule *rule,
 }
 EXPORT_SYMBOL(flow_rule_match_ports);
 
+void flow_rule_match_ports_range(const struct flow_rule *rule,
+				 struct flow_match_ports_range *out)
+{
+	FLOW_DISSECTOR_MATCH(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE, out);
+}
+EXPORT_SYMBOL(flow_rule_match_ports_range);
+
 void flow_rule_match_tcp(const struct flow_rule *rule,
 			 struct flow_match_tcp *out)
 {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 4dfe17f1a76a..7ef3630ea20d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3364,10 +3364,12 @@ static const struct seq_operations neigh_stat_seq_ops = {
 static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid)
 {
-	struct net *net = dev_net(n->dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
+	struct net *net;
 
+	rcu_read_lock();
+	net = dev_net_rcu(n->dev);
 	skb = nlmsg_new(neigh_nlmsg_size(), GFP_ATOMIC);
 	if (skb == NULL)
 		goto errout;
@@ -3380,10 +3382,11 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 		goto errout;
 	}
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
-	return;
+	goto out;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+out:
+	rcu_read_unlock();
 }
 
 void neigh_app_ns(struct neighbour *n)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index da2be54f5e62..c82aaf656cda 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5226,11 +5226,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->offload_fwd_mark = 0;
 	skb->offload_l3_fwd_mark = 0;
 #endif
+	ipvs_reset(skb);
 
 	if (!xnet)
 		return;
 
-	ipvs_reset(skb);
 	skb->mark = 0;
 	skb->tstamp = 0;
 }
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 586598887095..b3b39b0e0745 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -242,7 +242,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	int ret, weight;
 
 	mutex_lock(&dev_weight_mutex);
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
 		WRITE_ONCE(dev_rx_weight, weight * dev_weight_rx_bias);
@@ -356,6 +356,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_rx_bias",
@@ -363,6 +364,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_tx_bias",
@@ -370,6 +372,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "netdev_max_backlog",
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index b8fe943ae89d..9455b96449e5 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -637,10 +637,12 @@ static int arp_xmit_finish(struct net *net, struct sock *sk, struct sk_buff *skb
  */
 void arp_xmit(struct sk_buff *skb)
 {
+	rcu_read_lock();
 	/* Send it off, maybe filter it using firewalling first.  */
 	NF_HOOK(NFPROTO_ARP, NF_ARP_OUT,
-		dev_net(skb->dev), NULL, skb, NULL, skb->dev,
+		dev_net_rcu(skb->dev), NULL, skb, NULL, skb->dev,
 		arp_xmit_finish);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(arp_xmit);
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 9910844c890b..6855372d57a3 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1317,10 +1317,11 @@ __be32 inet_select_addr(const struct net_device *dev, __be32 dst, int scope)
 	__be32 addr = 0;
 	unsigned char localnet_scope = RT_SCOPE_HOST;
 	struct in_device *in_dev;
-	struct net *net = dev_net(dev);
+	struct net *net;
 	int master_idx;
 
 	rcu_read_lock();
+	net = dev_net_rcu(dev);
 	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev)
 		goto no_in_dev;
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 4a1a90a13540..78ca019f0a32 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -321,9 +321,6 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 	list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {
 		if (e < s_e)
 			goto next_entry2;
-		if (filter->dev &&
-		    !mr_mfc_uses_dev(mrt, mfc, filter->dev))
-			goto next_entry2;
 
 		err = fill(mrt, skb, NETLINK_CB(cb->skb).portid,
 			   cb->nlh->nlmsg_seq, mfc, RTM_NEWROUTE, flags);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f3e77b1e1d4b..da280a2df4e6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -423,7 +423,13 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	bool res;
+
+	rcu_read_lock();
+	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
+	rcu_read_unlock();
+
+	return res;
 }
 
 void rt_cache_flush(struct net *net)
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fc61cd3fea65..27b7887f4f4e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -11,12 +11,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -115,8 +118,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold((__force __wsum)((__force u32)th->check +
 					       (__force u32)delta));
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1ccdb6a9ab89..013260256875 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -849,9 +849,9 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min_t(int, datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 487a92d75c70..6505a6fd245a 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -204,13 +204,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
 	copy_dtor = gso_skb->destructor == sock_wfree;
-	if (copy_dtor)
+	if (copy_dtor) {
 		gso_skb->destructor = NULL;
+		gso_skb->sk = NULL;
+	}
 
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
-		if (copy_dtor)
+		if (copy_dtor) {
 			gso_skb->destructor = sock_wfree;
+			gso_skb->sk = sk;
+		}
 		return segs;
 	}
 
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 6a6a30e82810..d54259b03a4d 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -88,13 +88,15 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected) {
+		/* cache only if we don't create a dst reference loop */
+		if (ilwt->connected && orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 	}
 
+	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 	return dst_output(net, sk, skb);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 64729e7e6a86..fe10f1ce167b 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -416,15 +416,11 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 {
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	struct sock *sk = dev_net(dev)->ipv6.ndisc_sk;
 	struct sk_buff *skb;
 
 	skb = alloc_skb(hlen + sizeof(struct ipv6hdr) + len + tlen, GFP_ATOMIC);
-	if (!skb) {
-		ND_PRINTK(0, err, "ndisc: %s failed to allocate an skb\n",
-			  __func__);
+	if (!skb)
 		return NULL;
-	}
 
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
@@ -435,7 +431,9 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 	/* Manually assign socket ownership as we avoid calling
 	 * sock_alloc_send_pskb() to bypass wmem buffer limits
 	 */
-	skb_set_owner_w(skb, sk);
+	rcu_read_lock();
+	skb_set_owner_w(skb, dev_net_rcu(dev)->ipv6.ndisc_sk);
+	rcu_read_unlock();
 
 	return skb;
 }
@@ -472,16 +470,20 @@ static void ndisc_send_skb(struct sk_buff *skb,
 			   const struct in6_addr *daddr,
 			   const struct in6_addr *saddr)
 {
+	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(skb->dev);
-	struct sock *sk = net->ipv6.ndisc_sk;
 	struct inet6_dev *idev;
+	struct net *net;
+	struct sock *sk;
 	int err;
-	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	u8 type;
 
 	type = icmp6h->icmp6_type;
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
+	sk = net->ipv6.ndisc_sk;
 	if (!dst) {
 		struct flowi6 fl6;
 		int oif = skb->dev->ifindex;
@@ -489,6 +491,7 @@ static void ndisc_send_skb(struct sk_buff *skb,
 		icmpv6_flow_init(sk, &fl6, type, saddr, daddr, oif);
 		dst = icmp6_dst_alloc(skb->dev, &fl6);
 		if (IS_ERR(dst)) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return;
 		}
@@ -503,7 +506,6 @@ static void ndisc_send_skb(struct sk_buff *skb,
 
 	ip6_nd_hdr(skb, saddr, daddr, inet6_sk(sk)->hop_limit, skb->len);
 
-	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
@@ -1597,7 +1599,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	bool ret;
 
 	if (netif_is_l3_master(skb->dev)) {
-		dev = __dev_get_by_index(dev_net(skb->dev), IPCB(skb)->iif);
+		dev = dev_get_by_index_rcu(dev_net(skb->dev), IPCB(skb)->iif);
 		if (!dev)
 			return;
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 364abcf4b6c1..99908861246d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3090,13 +3090,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e6fdb842e89d..db948e3a9bdc 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1141,9 +1141,9 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min_t(int, datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index df26557a0244..942ace4af18d 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -24,7 +24,7 @@
 #include <net/llc_s_ac.h>
 #include <net/llc_s_ev.h>
 #include <net/llc_sap.h>
-
+#include <net/sock.h>
 
 /**
  *	llc_sap_action_unit_data_ind - forward UI PDU to network layer
@@ -40,6 +40,26 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 	return 0;
 }
 
+static int llc_prepare_and_xmit(struct sk_buff *skb)
+{
+	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
+	struct sk_buff *nskb;
+	int rc;
+
+	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
+	if (rc)
+		return rc;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	if (skb->sk)
+		skb_set_owner_w(nskb, skb->sk);
+
+	return dev_queue_xmit(nskb);
+}
+
 /**
  *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
  *	@sap: SAP
@@ -52,17 +72,12 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -77,17 +92,12 @@ int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -133,17 +143,12 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_test_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 6710f6b8764b..6e27cf742eb9 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1295,6 +1295,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		nd->state = ncsi_dev_state_probe_package;
 		break;
 	case ncsi_dev_state_probe_package:
+		if (ndp->package_probe_id >= 8) {
+			/* Last package probed, finishing */
+			ndp->flags |= NCSI_DEV_PROBED;
+			break;
+		}
+
 		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_SP;
@@ -1373,13 +1379,8 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		if (ret)
 			goto error;
 
-		/* Probe next package */
+		/* Probe next package after receiving response */
 		ndp->package_probe_id++;
-		if (ndp->package_probe_id >= 8) {
-			/* Probe finished */
-			ndp->flags |= NCSI_DEV_PROBED;
-			break;
-		}
 		nd->state = ncsi_dev_state_probe_package;
 		ndp->active_package = NULL;
 		break;
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 4fe336ff2bfa..f8140488b08a 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -548,6 +548,8 @@ static u8 nci_hci_create_pipe(struct nci_dev *ndev, u8 dest_host,
 
 	pr_debug("pipe created=%d\n", pipe);
 
+	if (pipe >= NCI_HCI_MAX_PIPES)
+		pipe = NCI_HCI_INVALID_PIPE;
 	return pipe;
 }
 
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 4c537e74b18c..20a57a3dc281 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1912,6 +1912,7 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 {
 	struct ovs_header *ovs_header;
 	struct ovs_vport_stats vport_stats;
+	struct net *net_vport;
 	int err;
 
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_vport_genl_family,
@@ -1928,12 +1929,15 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	    nla_put_u32(skb, OVS_VPORT_ATTR_IFINDEX, vport->dev->ifindex))
 		goto nla_put_failure;
 
-	if (!net_eq(net, dev_net(vport->dev))) {
-		int id = peernet2id_alloc(net, dev_net(vport->dev), gfp);
+	rcu_read_lock();
+	net_vport = dev_net_rcu(vport->dev);
+	if (!net_eq(net, net_vport)) {
+		int id = peernet2id_alloc(net, net_vport, GFP_ATOMIC);
 
 		if (nla_put_s32(skb, OVS_VPORT_ATTR_NETNSID, id))
-			goto nla_put_failure;
+			goto nla_put_failure_unlock;
 	}
+	rcu_read_unlock();
 
 	ovs_vport_get_stats(vport, &vport_stats);
 	if (nla_put_64bit(skb, OVS_VPORT_ATTR_STATS,
@@ -1951,6 +1955,8 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	genlmsg_end(skb, ovs_header);
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	err = -EMSGSIZE;
 error:
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 9b36fb6aa3e1..cd9370e4b50b 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -678,11 +678,9 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	struct net_device *dev;
 	ax25_address *source;
 	ax25_uid_assoc *user;
+	int err = -EINVAL;
 	int n;
 
-	if (!sock_flag(sk, SOCK_ZAPPED))
-		return -EINVAL;
-
 	if (addr_len != sizeof(struct sockaddr_rose) && addr_len != sizeof(struct full_sockaddr_rose))
 		return -EINVAL;
 
@@ -695,8 +693,15 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	if ((unsigned int) addr->srose_ndigis > ROSE_MAX_DIGIS)
 		return -EINVAL;
 
-	if ((dev = rose_dev_get(&addr->srose_addr)) == NULL)
-		return -EADDRNOTAVAIL;
+	lock_sock(sk);
+
+	if (!sock_flag(sk, SOCK_ZAPPED))
+		goto out_release;
+
+	err = -EADDRNOTAVAIL;
+	dev = rose_dev_get(&addr->srose_addr);
+	if (!dev)
+		goto out_release;
 
 	source = &addr->srose_call;
 
@@ -707,7 +712,8 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	} else {
 		if (ax25_uid_policy && !capable(CAP_NET_BIND_SERVICE)) {
 			dev_put(dev);
-			return -EACCES;
+			err = -EACCES;
+			goto out_release;
 		}
 		rose->source_call   = *source;
 	}
@@ -729,8 +735,10 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	rose_insert_socket(sk);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	return 0;
+	err = 0;
+out_release:
+	release_sock(sk);
+	return err;
 }
 
 static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags)
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
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index c92318f68f92..803107b30814 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -54,13 +54,7 @@ struct fl_flow_key {
 	struct flow_dissector_key_ip ip;
 	struct flow_dissector_key_ip enc_ip;
 	struct flow_dissector_key_enc_opts enc_opts;
-	union {
-		struct flow_dissector_key_ports tp;
-		struct {
-			struct flow_dissector_key_ports tp_min;
-			struct flow_dissector_key_ports tp_max;
-		};
-	} tp_range;
+	struct flow_dissector_key_ports_range tp_range;
 	struct flow_dissector_key_ct ct;
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index b8dc03a7487e..178044a845df 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1593,6 +1593,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
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
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index f2a49bccb5ef..fc96ec46e6f6 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -622,6 +622,63 @@ static bool cake_ddst(int flow_mode)
 	return (flow_mode & CAKE_FLOW_DUAL_DST) == CAKE_FLOW_DUAL_DST;
 }
 
+static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count))
+		q->hosts[flow->srchost].srchost_bulk_flow_count--;
+}
+
+static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->srchost].srchost_bulk_flow_count++;
+}
+
+static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
+}
+
+static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
+}
+
+static u16 cake_get_flow_quantum(struct cake_tin_data *q,
+				 struct cake_flow *flow,
+				 int flow_mode)
+{
+	u16 host_load = 1;
+
+	if (cake_dsrc(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->srchost].srchost_bulk_flow_count);
+
+	if (cake_ddst(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
+
+	/* The shifted prandom_u32() is a way to apply dithering to avoid
+	 * accumulating roundoff errors
+	 */
+	return (q->flow_quantum * quantum_div[host_load] +
+		(prandom_u32() >> 16)) >> 16;
+}
+
 static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		     int flow_mode, u16 flow_override, u16 host_override)
 {
@@ -753,10 +810,8 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		allocate_dst = cake_ddst(flow_mode);
 
 		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			if (allocate_src)
-				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			if (allocate_dst)
-				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+			cake_dec_srchost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
+			cake_dec_dsthost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
 		}
 found:
 		/* reserve queue for future packets in same flow */
@@ -781,9 +836,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].srchost_tag = srchost_hash;
 found_src:
 			srchost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[srchost_idx].srchost_bulk_flow_count++;
 			q->flows[reduced_hash].srchost = srchost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 
 		if (allocate_dst) {
@@ -804,9 +860,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].dsthost_tag = dsthost_hash;
 found_dst:
 			dsthost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[dsthost_idx].dsthost_bulk_flow_count++;
 			q->flows[reduced_hash].dsthost = dsthost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 	}
 
@@ -1821,10 +1878,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	/* flowchain */
 	if (!flow->set || flow->set == CAKE_SET_DECAYING) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-		u16 host_load = 1;
-
 		if (!flow->set) {
 			list_add_tail(&flow->flowchain, &b->new_flows);
 		} else {
@@ -1834,18 +1887,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		b->sparse_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		flow->deficit = (b->flow_quantum *
-				 quantum_div[host_load]) >> 16;
+		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
 		 */
@@ -1853,12 +1896,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->sparse_flow_count--;
 		b->bulk_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			srchost->srchost_bulk_flow_count++;
-
-		if (cake_ddst(q->flow_mode))
-			dsthost->dsthost_bulk_flow_count++;
-
+		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 	}
 
 	if (q->buffer_used > q->buffer_max_used)
@@ -1915,13 +1954,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	struct cake_host *srchost, *dsthost;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
 	bool first_flow = true;
 	struct sk_buff *skb;
-	u16 host_load;
 	u64 delay;
 	u32 len;
 
@@ -2021,11 +2058,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	q->cur_flow = flow - b->flows;
 	first_flow = false;
 
-	/* triple isolation (modified DRR++) */
-	srchost = &b->hosts[flow->srchost];
-	dsthost = &b->hosts[flow->dsthost];
-	host_load = 1;
-
 	/* flow isolation (DRR++) */
 	if (flow->deficit <= 0) {
 		/* Keep all flows with deficits out of the sparse and decaying
@@ -2037,11 +2069,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				b->sparse_flow_count--;
 				b->bulk_flow_count++;
 
-				if (cake_dsrc(q->flow_mode))
-					srchost->srchost_bulk_flow_count++;
-
-				if (cake_ddst(q->flow_mode))
-					dsthost->dsthost_bulk_flow_count++;
+				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 				flow->set = CAKE_SET_BULK;
 			} else {
@@ -2053,19 +2082,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		WARN_ON(host_load > CAKE_QUEUES);
-
-		/* The shifted prandom_u32() is a way to apply dithering to
-		 * avoid accumulating roundoff errors
-		 */
-		flow->deficit += (b->flow_quantum * quantum_div[host_load] +
-				  (prandom_u32() >> 16)) >> 16;
+		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2089,11 +2106,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 					b->decaying_flow_count++;
 				} else if (flow->set == CAKE_SET_SPARSE ||
@@ -2111,12 +2125,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				else if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
-
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 				} else
 					b->decaying_flow_count--;
 
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index 56f4c1621e44..b76c3d199ca1 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -38,6 +38,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	unsigned int prev_backlog;
 
+	if (unlikely(READ_ONCE(sch->limit) == 0))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < sch->limit))
 		return qdisc_enqueue_tail(skb, sch);
 
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 73c952d48275..27bd18c74e85 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -739,9 +739,9 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 				if (err != NET_XMIT_SUCCESS) {
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 					sch->qstats.backlog -= pkt_len;
 					sch->q.qlen--;
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index d050e7013860..2215314dc4c5 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1652,12 +1652,14 @@ static void remove_cache_proc_entries(struct cache_detail *cd)
 	}
 }
 
-#ifdef CONFIG_PROC_FS
 static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 {
 	struct proc_dir_entry *p;
 	struct sunrpc_net *sn;
 
+	if (!IS_ENABLED(CONFIG_PROC_FS))
+		return 0;
+
 	sn = net_generic(net, sunrpc_net_id);
 	cd->procfs = proc_mkdir(cd->name, sn->proc_net_rpc);
 	if (cd->procfs == NULL)
@@ -1685,12 +1687,6 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 	remove_cache_proc_entries(cd);
 	return -ENOMEM;
 }
-#else /* CONFIG_PROC_FS */
-static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
-{
-	return 0;
-}
-#endif
 
 void __init cache_initialize(void)
 {
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4cd65a1a07f9..5d490633a7f1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1185,6 +1185,11 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
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
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a27b2fae4843..9717acb97745 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3409,6 +3409,11 @@ static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* cooked monitor mode is incompatible with other modes */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES &&
+	    *mntrflags != MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1f5ea82b58bf..213655aa6e48 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -385,7 +385,8 @@ static bool is_an_alpha2(const char *alpha2)
 {
 	if (!alpha2)
 		return false;
-	return isalpha(alpha2[0]) && isalpha(alpha2[1]);
+	return isascii(alpha2[0]) && isalpha(alpha2[0]) &&
+	       isascii(alpha2[1]) && isalpha(alpha2[1]);
 }
 
 static bool alpha2_equal(const char *alpha2_x, const char *alpha2_y)
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index a51193485c50..c85fd32b70da 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -36,6 +36,10 @@ KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
 KBUILD_CFLAGS += -Wno-missing-field-initializers
 KBUILD_CFLAGS += -Wno-sign-compare
 
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Wno-enum-enum-conversion
+endif
+
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
 
 else
@@ -52,7 +56,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
 KBUILD_CFLAGS += -Wno-enum-compare-conditional
-KBUILD_CFLAGS += -Wno-enum-enum-conversion
 endif
 
 endif
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 23eff234184f..a87fafbbec26 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -241,6 +241,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 						"unchanged\n");
 				}
 				sym->is_declared = 1;
+				free_list(defn, NULL);
 				return sym;
 			} else if (!sym->is_declared) {
 				if (sym->is_override && flag_preserve) {
@@ -249,6 +250,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 					print_type_name(type, name);
 					fprintf(stderr, " modversion change\n");
 					sym->is_declared = 1;
+					free_list(defn, NULL);
 					return sym;
 				} else {
 					status = is_unknown_symbol(sym) ?
@@ -256,6 +258,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 				}
 			} else {
 				error_with_pos("redefinition of %s", name);
+				free_list(defn, NULL);
 				return sym;
 			}
 			break;
@@ -271,11 +274,15 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
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
@@ -482,7 +489,7 @@ static void read_reference(FILE *f)
 			defn = def;
 			def = read_node(f);
 		}
-		subsym = add_reference_symbol(xstrdup(sym->string), sym->tag,
+		subsym = add_reference_symbol(sym->string, sym->tag,
 					      defn, is_extern);
 		subsym->is_override = is_override;
 		free_node(sym);
diff --git a/scripts/genksyms/genksyms.h b/scripts/genksyms/genksyms.h
index 2bcdb9bebab4..4ead4e0adb82 100644
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
index e22b42245bcc..84813ce54a2d 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -149,14 +149,19 @@ simple_declaration:
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
@@ -167,6 +172,11 @@ init_declarator_list:
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
@@ -469,12 +479,12 @@ enumerator_list:
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
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 364979233a17..7a720b43b0ce 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -210,7 +210,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
+	struct name_snapshot filename;
 	int result = 0;
 	int length;
 	void *tmpbuf;
@@ -273,9 +273,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -388,6 +392,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -401,7 +406,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 1be146e17d9f..836d85d02d79 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -387,7 +387,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -400,7 +403,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -409,8 +415,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 1b467381986f..360cf2960f34 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2674,7 +2674,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cc9b8b6595c8..59fc56a970a9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2246,6 +2246,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	/* KONTRON SinglePC may cause a stall at runtime resume */
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
+	/* Dell ALC3271 */
+	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5c0a40083342..132ef5648864 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -949,6 +949,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9b344b80f950..93bb7c5922e7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3111,6 +3111,7 @@ enum {
 	ALC269_TYPE_ALC257,
 	ALC269_TYPE_ALC215,
 	ALC269_TYPE_ALC225,
+	ALC269_TYPE_ALC287,
 	ALC269_TYPE_ALC294,
 	ALC269_TYPE_ALC300,
 	ALC269_TYPE_ALC623,
@@ -3147,6 +3148,7 @@ static int alc269_parse_auto_config(struct hda_codec *codec)
 	case ALC269_TYPE_ALC257:
 	case ALC269_TYPE_ALC215:
 	case ALC269_TYPE_ALC225:
+	case ALC269_TYPE_ALC287:
 	case ALC269_TYPE_ALC294:
 	case ALC269_TYPE_ALC300:
 	case ALC269_TYPE_ALC623:
@@ -3656,6 +3658,7 @@ static void alc225_init(struct hda_codec *codec)
 				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
 		msleep(75);
+		alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
 		alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
 	}
 }
@@ -3710,6 +3713,79 @@ static void alc225_shutup(struct hda_codec *codec)
 	}
 }
 
+static void alc222_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		return;
+
+	msleep(30);
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+		msleep(75);
+	}
+}
+
+static void alc222_shutup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		hp_pin = 0x21;
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
+	alc_auto_setup_eapd(codec, false);
+	alc_shutup_pins(codec);
+}
+
 static void alc_default_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -9342,7 +9418,6 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0215:
 	case 0x10ec0245:
 	case 0x10ec0285:
-	case 0x10ec0287:
 	case 0x10ec0289:
 		spec->codec_variant = ALC269_TYPE_ALC215;
 		spec->shutup = alc225_shutup;
@@ -9357,6 +9432,12 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->init_hook = alc225_init;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC225, ALC295 and ALC299 */
 		break;
+	case 0x10ec0287:
+		spec->codec_variant = ALC269_TYPE_ALC287;
+		spec->shutup = alc225_shutup;
+		spec->init_hook = alc225_init;
+		spec->gen.mixer_nid = 0; /* no loopback on ALC287 */
+		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
 	case 0x10ec0294:
@@ -9369,8 +9450,11 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC300;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
 		break;
+	case 0x10ec0222:
 	case 0x10ec0623:
 		spec->codec_variant = ALC269_TYPE_ALC623;
+		spec->shutup = alc222_shutup;
+		spec->init_hook = alc222_init;
 		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 4117ab6e9b6f..83ffdb7e5120 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -234,7 +234,6 @@ static const struct snd_kcontrol_new es8328_right_line_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 6, 1, 0),
 	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 6, 1, 0),
@@ -244,7 +243,6 @@ static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
 static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 6, 1, 0),
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 6, 1, 0),
 };
 
@@ -337,10 +335,10 @@ static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", ES8328_DACPOWER,
 			ES8328_DACPOWER_LDAC_OFF, 1),
 
-	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Left Mixer", ES8328_DACCONTROL17, 7, 0,
 		&es8328_left_mixer_controls[0],
 		ARRAY_SIZE(es8328_left_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Right Mixer", ES8328_DACCONTROL20, 7, 0,
 		&es8328_right_mixer_controls[0],
 		ARRAY_SIZE(es8328_right_mixer_controls)),
 
@@ -419,19 +417,14 @@ static const struct snd_soc_dapm_route es8328_dapm_routes[] = {
 	{ "Right Line Mux", "PGA", "Right PGA Mux" },
 	{ "Right Line Mux", "Differential", "Differential Mux" },
 
-	{ "Left Out 1", NULL, "Left DAC" },
-	{ "Right Out 1", NULL, "Right DAC" },
-	{ "Left Out 2", NULL, "Left DAC" },
-	{ "Right Out 2", NULL, "Right DAC" },
-
-	{ "Left Mixer", "Playback Switch", "Left DAC" },
+	{ "Left Mixer", NULL, "Left DAC" },
 	{ "Left Mixer", "Left Bypass Switch", "Left Line Mux" },
 	{ "Left Mixer", "Right Playback Switch", "Right DAC" },
 	{ "Left Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "Right Mixer", "Left Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Left Bypass Switch", "Left Line Mux" },
-	{ "Right Mixer", "Playback Switch", "Right DAC" },
+	{ "Right Mixer", NULL, "Right DAC" },
 	{ "Right Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "DAC DIG", NULL, "DAC STM" },
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 53a15be38b56..104cfb56d225 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -909,7 +909,22 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
-	{	/* Vexia Edu Atla 10 tablet */
+	{
+		/* Vexia Edu Atla 10 tablet 5V version */
+		.matches = {
+			/* Having all 3 of these not set is somewhat unique */
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Vexia Edu Atla 10 tablet 9V version */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 680d64e0d69f..82f3a3e37e91 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -175,6 +175,7 @@ struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
 	unsigned int val_fctl_ftx;
+	unsigned int mclk_multiplier;
 };
 
 struct sun4i_spdif_dev {
@@ -311,6 +312,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk *= host->quirks->mclk_multiplier;
 
 	ret = clk_set_rate(host->spdif_clk, mclk);
 	if (ret < 0) {
@@ -345,6 +347,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk_div *= host->quirks->mclk_multiplier;
 
 	reg_val = 0;
 	reg_val |= SUN4I_SPDIF_TXCFG_ASS;
@@ -427,24 +430,28 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
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
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index d1c5cb526b9f..0dbf86315dbe 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -407,7 +407,12 @@ static int cmpworker(const void *p1, const void *p2)
 
 	struct worker *w1 = (struct worker *) p1;
 	struct worker *w2 = (struct worker *) p2;
-	return w1->tid > w2->tid;
+
+	if (w1->tid > w2->tid)
+		return 1;
+	if (w1->tid < w2->tid)
+		return -1;
+	return 0;
 }
 
 int bench_epoll_wait(int argc, const char **argv)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dc228bdf2bbc..2f0917dbadcf 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1175,7 +1175,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_STRING(0, "objdump", &report.annotation_opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
-		    "Disable symbol demangling"),
+		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b8fab267e855..5631d44a3f6b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -796,7 +796,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
+		    __map__is_kernel(al.map) && !map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 				dso__strerror_load(al.map->dso, serr, sizeof(serr));
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c8c01e706118..6a444123a095 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1582,8 +1582,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
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
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index bd63bd14417f..5cf802b6c550 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2139,7 +2139,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr;
+	unsigned int cs_queue_nr, queue_nr, i;
 	u8 trace_chan_id;
 	u64 timestamp;
 	struct auxtrace_queue *queue;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 953db9dd25eb..f8239fbe6b09 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -21,7 +21,7 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 	up_write(&env->bpf_progs.lock);
 }
 
-void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
+bool __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
 {
 	__u32 prog_id = info_node->info_linear->info.id;
 	struct bpf_prog_info_node *node;
@@ -39,13 +39,14 @@ void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info
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
index b0778483fa04..9c5777a2ea7e 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -117,7 +117,7 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-void __perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a68feeb3eb00..a66a05091a97 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2724,7 +2724,10 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpf_program__bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		__perf_env__insert_bpf_prog_info(env, info_node);
+		if (!__perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -2777,7 +2780,8 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		__perf_env__insert_btf(env, node);
+		if (!__perf_env__insert_btf(env, node))
+			free(node);
 		node = NULL;
 	}
 
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 7a76d6300374..0e8c0b879d4b 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -29,7 +29,7 @@ static int mperf_get_count_percent(unsigned int self_id, double *percent,
 				   unsigned int cpu);
 static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 				unsigned int cpu);
-static struct timespec time_start, time_end;
+static struct timespec *time_start, *time_end;
 
 static cstate_t mperf_cstates[MPERF_CSTATE_COUNT] = {
 	{
@@ -135,7 +135,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
 	} else if (max_freq_mode == MAX_FREQ_SYSFS) {
-		timediff = max_frequency * timespec_diff_us(time_start, time_end);
+		timediff = max_frequency * timespec_diff_us(time_start[cpu], time_end[cpu]);
 		*percent = 100.0 * mperf_diff / timediff;
 		dprint("%s: MAXFREQ - mperf_diff: %llu, time_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, timediff);
@@ -168,7 +168,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
 		/* Calculate max_freq from TSC count */
 		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
-		time_diff = timespec_diff_us(time_start, time_end);
+		time_diff = timespec_diff_us(time_start[cpu], time_end[cpu]);
 		max_frequency = tsc_diff / time_diff;
 	}
 
@@ -187,9 +187,8 @@ static int mperf_start(void)
 {
 	int cpu;
 
-	clock_gettime(CLOCK_REALTIME, &time_start);
-
 	for (cpu = 0; cpu < cpu_count; cpu++) {
+		clock_gettime(CLOCK_REALTIME, &time_start[cpu]);
 		mperf_get_tsc(&tsc_at_measure_start[cpu]);
 		mperf_init_stats(cpu);
 	}
@@ -204,9 +203,9 @@ static int mperf_stop(void)
 	for (cpu = 0; cpu < cpu_count; cpu++) {
 		mperf_measure_stats(cpu);
 		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
 	}
 
-	clock_gettime(CLOCK_REALTIME, &time_end);
 	return 0;
 }
 
@@ -307,6 +306,8 @@ struct cpuidle_monitor *mperf_register(void)
 	aperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
 	tsc_at_measure_start = calloc(cpu_count, sizeof(unsigned long long));
 	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
+	time_start = calloc(cpu_count, sizeof(struct timespec));
+	time_end = calloc(cpu_count, sizeof(struct timespec));
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
@@ -319,6 +320,8 @@ void mperf_unregister(void)
 	free(aperf_current_count);
 	free(tsc_at_measure_start);
 	free(tsc_at_measure_end);
+	free(time_start);
+	free(time_end);
 	free(is_valid);
 }
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index e7adb429018b..10b3c5b25b69 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2319,6 +2319,11 @@ sub get_version {
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
@@ -2861,8 +2866,6 @@ sub run_bisect_test {
 
     my $failed = 0;
     my $result;
-    my $output;
-    my $ret;
 
     $in_bisect = 1;
 
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 21bde60c9523..e42d8959cbf1 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -286,6 +286,7 @@ else
 	client_connect
 	verify_data
 	server_listen
+	wait_for_port ${port} ${netcat_opt}
 fi
 
 # bpf_skb_net_shrink does not take tunnel flags yet, cannot update L3.
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..9465f1aca2af 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -603,17 +603,49 @@
 	if (_metadata->passed && _metadata->step < 255) \
 		_metadata->step++;
 
+#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
 	if (_assert) __INC_STEP(_metadata); \
 	if (!(__exp _t __seen)) { \
-		unsigned long long __exp_print = (uintptr_t)__exp; \
-		unsigned long long __seen_print = (uintptr_t)__seen; \
-		__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
-			 _expected_str, __exp_print, #_t, \
-			 _seen_str, __seen_print); \
+		/* Report with actual signedness to avoid weird output. */ \
+		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		case 0: { \
+			uintmax_t __exp_print = (uintmax_t)__exp; \
+			uintmax_t __seen_print = (uintmax_t)__seen; \
+			__TH_LOG("Expected %s (%ju) %s %s (%ju)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 1: { \
+			uintmax_t __exp_print = (uintmax_t)__exp; \
+			intmax_t  __seen_print = (intmax_t)__seen; \
+			__TH_LOG("Expected %s (%ju) %s %s (%jd)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 2: { \
+			intmax_t  __exp_print = (intmax_t)__exp; \
+			uintmax_t __seen_print = (uintmax_t)__seen; \
+			__TH_LOG("Expected %s (%jd) %s %s (%ju)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 3: { \
+			intmax_t  __exp_print = (intmax_t)__exp; \
+			intmax_t  __seen_print = (intmax_t)__seen; \
+			__TH_LOG("Expected %s (%jd) %s %s (%jd)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		} \
 		_metadata->passed = 0; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de2..0e137182a4f4 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -94,6 +94,19 @@ struct testcase testcases_v4[] = {
 		.gso_len = CONST_MSS_V4,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V4,
+		.gso_len = CONST_MSS_V4 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V4,
+	},
+	{
+		/* MSS < datalen < gso_len: fail */
+		.tlen = CONST_MSS_V4 + 1,
+		.gso_len = CONST_MSS_V4 + 2,
+		.tfail = true,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V4 + 1,
@@ -197,6 +210,19 @@ struct testcase testcases_v6[] = {
 		.gso_len = CONST_MSS_V6,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V6,
+		.gso_len = CONST_MSS_V6 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V6,
+	},
+	{
+		/* MSS < datalen < gso_len: fail */
+		.tlen = CONST_MSS_V6 + 1,
+		.gso_len = CONST_MSS_V6 + 2,
+		.tfail = true
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V6 + 1,

