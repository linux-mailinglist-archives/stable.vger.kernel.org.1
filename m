Return-Path: <stable+bounces-118581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E563A3F5E4
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D0188D9E2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37320AF86;
	Fri, 21 Feb 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXz/Fdjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158020AF84;
	Fri, 21 Feb 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144473; cv=none; b=ffHlPKeC5KuPA4P2dK5oN5N461DKDthWDLqhmGpCaNW25q0rSeYSY9nDReV6iT2wOhneCzAGziE5Vzq43id+DtmKvaK7G9/tioTpZqC3b4uZrrFau/jCDxaEnAjTLIZCmYbgZFZ0x+roHO7I7BTbTLYEeFtrq5GYiMiPqxmefkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144473; c=relaxed/simple;
	bh=RQShV4xS4ci/bOkJ/QCyKSVp0xa8DCDAnJstqwnTAQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXd/mJT90o1Btw40s20upHysWi8OfAISLkuRLG48OVjGu9ko65LoyWWapPRIT0adGmeD1cOrhBGUspI+N+iRpGZmAOJ9qx/JOoCeGzbqZUeZ7JXs7XdT/dW9m3mZr+lF3cXiaGZg+ujtanNzqFkl1aNHqyxXVgaFP9junUCmNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXz/Fdjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676F4C4CED6;
	Fri, 21 Feb 2025 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740144472;
	bh=RQShV4xS4ci/bOkJ/QCyKSVp0xa8DCDAnJstqwnTAQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXz/FdjxhdE88/xO4EN8C/TqB/04SVQcedNzy3NKzSdUVAx7r1lO/ll7fdrBNnEHs
	 uFoZTPjwkB4go16sXVGYddTon2YIfjVsZhCEZHwFo2rUY56rvPm+sbC/hk0Od85GX8
	 ITWvXTAHuFT2dsIqOV47h+UxiAPKghCCqA8bAX1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.129
Date: Fri, 21 Feb 2025 14:27:40 +0100
Message-ID: <2025022140-outflank-encounter-b4e4@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025022140-drowsily-dial-c8a6@gregkh>
References: <2025022140-drowsily-dial-c8a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index 31840e33dcf5..3452cc9ef337 100644
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
index fbface720678..d57999249974 100644
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
     $ref: ../regulator/rohm,bd71815-regulator.yaml
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
index 802e3ca8be4d..f6bd7d19f461 100644
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
index 364b58730be2..796c09f24f3e 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -31,10 +31,6 @@ properties:
         $ref: "regulator.yaml#"
         unevaluatedProperties: false
 
-        properties:
-          regulator-compatible:
-            pattern: "^vbuck[1-4]$"
-
     additionalProperties: false
 
 required:
@@ -52,7 +48,6 @@ examples:
 
       regulators {
         vbuck1 {
-          regulator-compatible = "vbuck1";
           regulator-min-microvolt = <300000>;
           regulator-max-microvolt = <1193750>;
           regulator-enable-ramp-delay = <256>;
@@ -60,7 +55,6 @@ examples:
         };
 
         vbuck3 {
-          regulator-compatible = "vbuck3";
           regulator-min-microvolt = <300000>;
           regulator-max-microvolt = <1193750>;
           regulator-enable-ramp-delay = <256>;
diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
index 5967c79c3baa..eee0d298774a 100644
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -54,6 +54,15 @@ KCONFIG_OVERWRITECONFIG
 If you set KCONFIG_OVERWRITECONFIG in the environment, Kconfig will not
 break symlinks when .config is a symlink to somewhere else.
 
+KCONFIG_WARN_UNKNOWN_SYMBOLS
+----------------------------
+This environment variable makes Kconfig warn about all unrecognized
+symbols in the config input.
+
+KCONFIG_WERROR
+--------------
+If set, Kconfig treats warnings as errors.
+
 `CONFIG_`
 ---------
 If you set `CONFIG_` in the environment, Kconfig will prefix all symbols
diff --git a/Makefile b/Makefile
index 1fc69d1f5b8c..2c81c91c0ac2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 128
+SUBLEVEL = 129
 EXTRAVERSION =
 NAME = Curry Ramen
 
@@ -528,7 +528,7 @@ KGZIP		= gzip
 KBZIP2		= bzip2
 KLZOP		= lzop
 LZMA		= lzma
-LZ4		= lz4c
+LZ4		= lz4
 XZ		= xz
 ZSTD		= zstd
 
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
index c41a5a9c3b9f..ba99cc9d27c7 100644
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
index d9a67b370e04..de72bd837c5a 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -707,7 +707,7 @@ s_reg_to_mem (unsigned long s_reg)
 static int unauser_reg_offsets[32] = {
 	R(r0), R(r1), R(r2), R(r3), R(r4), R(r5), R(r6), R(r7), R(r8),
 	/* r9 ... r15 are stored in front of regs.  */
-	-56, -48, -40, -32, -24, -16, -8,
+	-64, -56, -48, -40, -32, -24, -16,	/* padding at -8 */
 	R(r16), R(r17), R(r18),
 	R(r19), R(r20), R(r21), R(r22), R(r23), R(r24), R(r25), R(r26),
 	R(r27), R(r28), R(gp),
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 2b49aa94e4de..1179b7df4af9 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -78,8 +78,8 @@ __load_new_mm_context(struct mm_struct *next_mm)
 
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
-	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+10 : (r)-10])
+	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-17 :	\
+				 (r) <= 18 ? (r)+11 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 5733e3a4ea8e..3fdb79b0e8bf 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -12,6 +12,7 @@ &l4_cfg {						/* 0x4a000000 */
 	ranges = <0x00000000 0x4a000000 0x100000>,	/* segment 0 */
 		 <0x00100000 0x4a100000 0x100000>,	/* segment 1 */
 		 <0x00200000 0x4a200000 0x100000>;	/* segment 2 */
+	dma-ranges;
 
 	segment@0 {					/* 0x4a000000 */
 		compatible = "simple-pm-bus";
@@ -557,6 +558,7 @@ segment@100000 {					/* 0x4a100000 */
 			 <0x0007e000 0x0017e000 0x001000>,	/* ap 124 */
 			 <0x00059000 0x00159000 0x001000>,	/* ap 125 */
 			 <0x0005a000 0x0015a000 0x001000>;	/* ap 126 */
+		dma-ranges;
 
 		target-module@2000 {			/* 0x4a102000, ap 27 3c.0 */
 			compatible = "ti,sysc";
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 25d31e40a553..74767b670372 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -309,7 +309,7 @@ pwrap: pwrap@1000d000 {
 		clock-names = "spi", "wrap";
 	};
 
-	cir: cir@10013000 {
+	cir: ir-receiver@10013000 {
 		compatible = "mediatek,mt7623-cir";
 		reg = <0 0x10013000 0 0x1000>;
 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 437dd0352fd4..4d0d0d49a744 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -590,7 +590,21 @@ static int at91_suspend_finish(unsigned long val)
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
@@ -601,24 +615,19 @@ static void at91_pm_switch_ba_to_vbat(void)
 
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
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index e21feb85d822..1135ed0bf90c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -922,7 +922,7 @@ pmic: mt6397 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		clock: mt6397clock {
+		clock: clocks {
 			compatible = "mediatek,mt6397-clk";
 			#clock-cells = <1>;
 		};
@@ -934,11 +934,10 @@ pio6397: pinctrl {
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
@@ -948,7 +947,6 @@ mt6397_vpca15_reg: buck_vpca15 {
 			};
 
 			mt6397_vpca7_reg: buck_vpca7 {
-				regulator-compatible = "buck_vpca7";
 				regulator-name = "vpca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -958,7 +956,6 @@ mt6397_vpca7_reg: buck_vpca7 {
 			};
 
 			mt6397_vsramca15_reg: buck_vsramca15 {
-				regulator-compatible = "buck_vsramca15";
 				regulator-name = "vsramca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -967,7 +964,6 @@ mt6397_vsramca15_reg: buck_vsramca15 {
 			};
 
 			mt6397_vsramca7_reg: buck_vsramca7 {
-				regulator-compatible = "buck_vsramca7";
 				regulator-name = "vsramca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -976,7 +972,6 @@ mt6397_vsramca7_reg: buck_vsramca7 {
 			};
 
 			mt6397_vcore_reg: buck_vcore {
-				regulator-compatible = "buck_vcore";
 				regulator-name = "vcore";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -985,7 +980,6 @@ mt6397_vcore_reg: buck_vcore {
 			};
 
 			mt6397_vgpu_reg: buck_vgpu {
-				regulator-compatible = "buck_vgpu";
 				regulator-name = "vgpu";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -994,7 +988,6 @@ mt6397_vgpu_reg: buck_vgpu {
 			};
 
 			mt6397_vdrm_reg: buck_vdrm {
-				regulator-compatible = "buck_vdrm";
 				regulator-name = "vdrm";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1400000>;
@@ -1003,7 +996,6 @@ mt6397_vdrm_reg: buck_vdrm {
 			};
 
 			mt6397_vio18_reg: buck_vio18 {
-				regulator-compatible = "buck_vio18";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1620000>;
 				regulator-max-microvolt = <1980000>;
@@ -1012,18 +1004,15 @@ mt6397_vio18_reg: buck_vio18 {
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
@@ -1031,18 +1020,15 @@ mt6397_vcama_reg: ldo_vcama {
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
@@ -1050,7 +1036,6 @@ mt6397_vmc_reg: ldo_vmc {
 			};
 
 			mt6397_vmch_reg: ldo_vmch {
-				regulator-compatible = "ldo_vmch";
 				regulator-name = "vmch";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -1058,7 +1043,6 @@ mt6397_vmch_reg: ldo_vmch {
 			};
 
 			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-				regulator-compatible = "ldo_vemc3v3";
 				regulator-name = "vemc_3v3";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -1066,7 +1050,6 @@ mt6397_vemc_3v3_reg: ldo_vemc3v3 {
 			};
 
 			mt6397_vgp1_reg: ldo_vgp1 {
-				regulator-compatible = "ldo_vgp1";
 				regulator-name = "vcamd";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -1074,7 +1057,6 @@ mt6397_vgp1_reg: ldo_vgp1 {
 			};
 
 			mt6397_vgp2_reg: ldo_vgp2 {
-				regulator-compatible = "ldo_vgp2";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -1082,7 +1064,6 @@ mt6397_vgp2_reg: ldo_vgp2 {
 			};
 
 			mt6397_vgp3_reg: ldo_vgp3 {
-				regulator-compatible = "ldo_vgp3";
 				regulator-name = "vcamaf";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -1090,7 +1071,6 @@ mt6397_vgp3_reg: ldo_vgp3 {
 			};
 
 			mt6397_vgp4_reg: ldo_vgp4 {
-				regulator-compatible = "ldo_vgp4";
 				regulator-name = "vgp4";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -1098,7 +1078,6 @@ mt6397_vgp4_reg: ldo_vgp4 {
 			};
 
 			mt6397_vgp5_reg: ldo_vgp5 {
-				regulator-compatible = "ldo_vgp5";
 				regulator-name = "vgp5";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3000000>;
@@ -1106,7 +1085,6 @@ mt6397_vgp5_reg: ldo_vgp5 {
 			};
 
 			mt6397_vgp6_reg: ldo_vgp6 {
-				regulator-compatible = "ldo_vgp6";
 				regulator-name = "vgp6";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -1115,7 +1093,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-				regulator-compatible = "ldo_vibr";
 				regulator-name = "vibr";
 				regulator-min-microvolt = <1300000>;
 				regulator-max-microvolt = <3300000>;
@@ -1123,7 +1100,7 @@ mt6397_vibr_reg: ldo_vibr {
 			};
 		};
 
-		rtc: mt6397rtc {
+		rtc: rtc {
 			compatible = "mediatek,mt6397-rtc";
 		};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 49c7185243cc..8bc3ea1a7fbc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -307,11 +307,10 @@ pmic: mt6397 {
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
index 5cbb5a1ae3f2..ca4196870f9d 100644
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
index 8fa89db03e63..328294245a79 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -11,3 +11,18 @@ / {
 	model = "Google kenzo sku17 board";
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
index 629c4b7ecbc6..8e0575f8c1b2 100644
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
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 0814ed6a7272..7e5230581a1c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -901,7 +901,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -911,7 +910,6 @@ mt6315_6_vbuck1: vbuck1 {
 			};
 
 			mt6315_6_vbuck3: vbuck3 {
-				regulator-compatible = "vbuck3";
 				regulator-name = "Vlcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -928,7 +926,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <800000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 0243da99d9c6..e4861c6cd78e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -843,7 +843,6 @@ mt6315@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
@@ -861,7 +860,6 @@ mt6315@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 998c2e78168a..4e1803ab9963 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -120,7 +120,6 @@ charger {
 			richtek,vinovp-microvolt = <14500000>;
 
 			otg_vbus_regulator: usb-otg-vbus-regulator {
-				regulator-compatible = "usb-otg-vbus";
 				regulator-name = "usb-otg-vbus";
 				regulator-min-microvolt = <4425000>;
 				regulator-max-microvolt = <5825000>;
@@ -132,7 +131,6 @@ regulator {
 			LDO_VIN3-supply = <&mt6360_buck2>;
 
 			mt6360_buck1: buck1 {
-				regulator-compatible = "BUCK1";
 				regulator-name = "mt6360,buck1";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -143,7 +141,6 @@ MT6360_OPMODE_LP
 			};
 
 			mt6360_buck2: buck2 {
-				regulator-compatible = "BUCK2";
 				regulator-name = "mt6360,buck2";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -154,7 +151,6 @@ MT6360_OPMODE_LP
 			};
 
 			mt6360_ldo1: ldo1 {
-				regulator-compatible = "LDO1";
 				regulator-name = "mt6360,ldo1";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -163,7 +159,6 @@ mt6360_ldo1: ldo1 {
 			};
 
 			mt6360_ldo2: ldo2 {
-				regulator-compatible = "LDO2";
 				regulator-name = "mt6360,ldo2";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -172,7 +167,6 @@ mt6360_ldo2: ldo2 {
 			};
 
 			mt6360_ldo3: ldo3 {
-				regulator-compatible = "LDO3";
 				regulator-name = "mt6360,ldo3";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -181,7 +175,6 @@ mt6360_ldo3: ldo3 {
 			};
 
 			mt6360_ldo5: ldo5 {
-				regulator-compatible = "LDO5";
 				regulator-name = "mt6360,ldo5";
 				regulator-min-microvolt = <2700000>;
 				regulator-max-microvolt = <3600000>;
@@ -190,7 +183,6 @@ mt6360_ldo5: ldo5 {
 			};
 
 			mt6360_ldo6: ldo6 {
-				regulator-compatible = "LDO6";
 				regulator-name = "mt6360,ldo6";
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
@@ -199,7 +191,6 @@ mt6360_ldo6: ldo6 {
 			};
 
 			mt6360_ldo7: ldo7 {
-				regulator-compatible = "LDO7";
 				regulator-name = "mt6360,ldo7";
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index aa8fbaf15e62..274edce5d5e6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2000,7 +2000,7 @@ larb20: larb@1b010000 {
 		};
 
 		ovl0: ovl@1c000000 {
-			compatible = "mediatek,mt8195-disp-ovl", "mediatek,mt8183-disp-ovl";
+			compatible = "mediatek,mt8195-disp-ovl";
 			reg = <0 0x1c000000 0 0x1000>;
 			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index d1b67c82d761..5655f12723f1 100644
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
 
@@ -206,7 +206,7 @@ toprgu: toprgu@10007000 {
 			compatible = "mediatek,mt8516-wdt",
 				     "mediatek,mt6589-wdt";
 			reg = <0 0x10007000 0 0x1000>;
-			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_FALLING>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
 			#reset-cells = <1>;
 		};
 
@@ -269,7 +269,7 @@ gic: interrupt-controller@10310000 {
 			interrupt-parent = <&gic>;
 			interrupt-controller;
 			reg = <0 0x10310000 0 0x1000>,
-			      <0 0x10320000 0 0x1000>,
+			      <0 0x1032f000 0 0x2000>,
 			      <0 0x10340000 0 0x2000>,
 			      <0 0x10360000 0 0x2000>;
 			interrupts = <GIC_PPI 9
@@ -345,6 +345,7 @@ i2c0: i2c@11009000 {
 			reg = <0 0x11009000 0 0x90>,
 			      <0 0x11000180 0 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <2>;
 			clocks = <&topckgen CLK_TOP_I2C0>,
 				 <&topckgen CLK_TOP_APDMA>;
 			clock-names = "main", "dma";
@@ -359,6 +360,7 @@ i2c1: i2c@1100a000 {
 			reg = <0 0x1100a000 0 0x90>,
 			      <0 0x11000200 0 0x80>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <2>;
 			clocks = <&topckgen CLK_TOP_I2C1>,
 				 <&topckgen CLK_TOP_APDMA>;
 			clock-names = "main", "dma";
@@ -373,6 +375,7 @@ i2c2: i2c@1100b000 {
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
index 6598e9ac52b8..876c73a00a54 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1249,7 +1249,7 @@ sce-fabric@b600000 {
 			compatible = "nvidia,tegra234-sce-fabric";
 			reg = <0xb600000 0x40000>;
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-			status = "okay";
+			status = "disabled";
 		};
 
 		rce-fabric@be00000 {
@@ -1558,7 +1558,7 @@ bpmp-fabric@d600000 {
 		};
 
 		dce-fabric@de00000 {
-			compatible = "nvidia,tegra234-sce-fabric";
+			compatible = "nvidia,tegra234-dce-fabric";
 			reg = <0xde00000 0x40000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
 			status = "okay";
@@ -1574,6 +1574,8 @@ gic: interrupt-controller@f400000 {
 			#redistributor-regions = <1>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+
+			#address-cells = <0>;
 		};
 
 		smmu_iso: iommu@10000000{
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 987cebbda057..571ed1abdad4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -109,7 +109,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 3c6c2cf99fb9..0eb8eca13ad9 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -33,7 +33,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 			clock-output-names = "sleep_clk";
 		};
 	};
@@ -434,6 +434,15 @@ usb3: usb@f92f8800 {
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
index 3bbafb68ba5c..543282fe2abb 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -65,7 +65,7 @@ led@0 {
 		};
 
 		led@1 {
-			reg = <0>;
+			reg = <1>;
 			chan-name = "button-backlight1";
 			led-cur = /bits/ 8 <0x32>;
 			max-cur = /bits/ 8 <0xC8>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 3b9a4bf89701..b3ebd0298f64 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2968,9 +2968,14 @@ usb3: usb@6af8800 {
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
diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 8a4972e6a24c..b45ffd7d3b36 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -11,7 +11,7 @@ / {
 	thermal-zones {
 		pm6150_thermal: pm6150-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm6150_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 06d729ff65a9..e7526a7f41e2 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -5,6 +5,34 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm6150l-thermal {
+			thermal-sensors = <&pm6150l_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pm6150l_lsid4: pmic@4 {
 		compatible = "qcom,pm6150l", "qcom,spmi-pmic";
@@ -12,6 +40,13 @@ pm6150l_lsid4: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm6150l_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x4 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm6150l_adc: adc@3100 {
 			compatible = "qcom,spmi-adc5";
 			reg = <0x3100>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 9dee131b1e24..02b507691cc3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -306,14 +306,9 @@ panel@0 {
 
 		reset-gpios = <&pm6150l_gpio 3 GPIO_ACTIVE_HIGH>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				panel0_in: endpoint {
-					remote-endpoint = <&dsi0_out>;
-				};
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
 			};
 		};
 	};
@@ -333,10 +328,6 @@ &dsi_phy {
 	vdds-supply = <&vreg_l4a_0p8>;
 };
 
-&mdp {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 7ee407f7b6bb..f98162d3a081 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -26,7 +26,6 @@ adau7002: audio-codec-1 {
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <965>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index bfab67f4a7c9..a7b41498ba88 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -43,7 +43,6 @@ pp3300_touch: pp3300-touch {
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <965>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index a7582fb547ee..31f91f4e9736 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -12,14 +12,11 @@
 
 / {
 	thermal-zones {
-		5v-choke-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <250>;
-
+		choke-5v-thermal {
 			thermal-sensors = <&pm6150_adc_tm 1>;
 
 			trips {
-				5v-choke-crit {
+				choke-5v-crit {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 695b04fe7221..a2906126242c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -60,19 +60,15 @@ panel: panel@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_rst>;
 		avdd-supply = <&ppvar_lcd>;
+		avee-supply = <&ppvar_lcd>;
 		pp1800-supply = <&v1p8_disp>;
 		pp3300-supply = <&pp3300_dx_edp>;
 		backlight = <&backlight>;
 		rotation = <270>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				panel_in: endpoint {
-					remote-endpoint = <&dsi0_out>;
-				};
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 6312108e8b3e..ebb64b91c09f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -50,7 +50,6 @@ v1p8_mipi: v1p8-mipi {
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <574>;
@@ -124,14 +123,9 @@ panel: panel@0 {
 		backlight = <&backlight>;
 		rotation = <270>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				panel_in: endpoint {
-					remote-endpoint = <&dsi0_out>;
-				};
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index f55ce6f2fdc2..06b6774ef010 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -20,9 +20,6 @@
 / {
 	thermal-zones {
 		charger_thermal: charger-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150_adc_tm 0>;
 
 			trips {
@@ -777,6 +774,10 @@ alc5682: codec@1a {
 	};
 };
 
+&lpasscc {
+	status = "okay";
+};
+
 &lpass_cpu {
 	status = "okay";
 
@@ -802,7 +803,7 @@ hdmi@5 {
 	};
 };
 
-&mdp {
+&lpass_hm {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 13fe1c92bf35..a9f937b06847 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2937,8 +2937,6 @@ mdp: display-controller@ae01000 {
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
 
-				status = "disabled";
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -2985,7 +2983,8 @@ opp-460000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sc7180-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -3576,6 +3575,8 @@ lpasscc: clock-controller@62d00000 {
 			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 
 		lpass_cpu: lpass@62d87000 {
@@ -3621,13 +3622,14 @@ lpass_hm: clock-controller@63000000 {
 			clock-names = "iface", "bi_tcxo";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 	};
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 1>;
 			sustainable-power = <1052>;
@@ -3676,7 +3678,6 @@ map1 {
 
 		cpu1_thermal: cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 2>;
 			sustainable-power = <1052>;
@@ -3725,7 +3726,6 @@ map1 {
 
 		cpu2_thermal: cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 3>;
 			sustainable-power = <1052>;
@@ -3774,7 +3774,6 @@ map1 {
 
 		cpu3_thermal: cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 4>;
 			sustainable-power = <1052>;
@@ -3823,7 +3822,6 @@ map1 {
 
 		cpu4_thermal: cpu4-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 5>;
 			sustainable-power = <1052>;
@@ -3872,7 +3870,6 @@ map1 {
 
 		cpu5_thermal: cpu5-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 6>;
 			sustainable-power = <1052>;
@@ -3921,7 +3918,6 @@ map1 {
 
 		cpu6_thermal: cpu6-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 9>;
 			sustainable-power = <1425>;
@@ -3962,7 +3958,6 @@ map1 {
 
 		cpu7_thermal: cpu7-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 10>;
 			sustainable-power = <1425>;
@@ -4003,7 +3998,6 @@ map1 {
 
 		cpu8_thermal: cpu8-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 11>;
 			sustainable-power = <1425>;
@@ -4044,7 +4038,6 @@ map1 {
 
 		cpu9_thermal: cpu9-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 12>;
 			sustainable-power = <1425>;
@@ -4085,7 +4078,6 @@ map1 {
 
 		aoss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 0>;
 
@@ -4106,7 +4098,6 @@ aoss0_crit: aoss0_crit {
 
 		cpuss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -4126,7 +4117,6 @@ cpuss0_crit: cluster0_crit {
 
 		cpuss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -4146,7 +4136,6 @@ cpuss1_crit: cluster0_crit {
 
 		gpuss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -4174,7 +4163,6 @@ map0 {
 
 		gpuss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 14>;
 
@@ -4202,7 +4190,6 @@ map0 {
 
 		aoss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 0>;
 
@@ -4223,7 +4210,6 @@ aoss1_crit: aoss1_crit {
 
 		cwlan-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -4244,7 +4230,6 @@ cwlan_crit: cwlan_crit {
 
 		audio-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -4265,7 +4250,6 @@ audio_crit: audio_crit {
 
 		ddr-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -4286,7 +4270,6 @@ ddr_crit: ddr_crit {
 
 		q6-hvx-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -4307,7 +4290,6 @@ q6_hvx_crit: q6_hvx_crit {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 5>;
 
@@ -4328,7 +4310,6 @@ camera_crit: camera_crit {
 
 		mdm-core-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -4349,7 +4330,6 @@ mdm_crit: mdm_crit {
 
 		mdm-dsp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 7>;
 
@@ -4370,7 +4350,6 @@ mdm_dsp_crit: mdm_dsp_crit {
 
 		npu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 8>;
 
@@ -4391,7 +4370,6 @@ npu_crit: npu_crit {
 
 		video-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 9>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b5cd24d59ad9..b778728390e5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -79,7 +79,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 7e3aaf5de3f5..6b0d4bc6c541 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1119,7 +1119,7 @@ usb_2_ssphy1: phy@88f1e00 {
 
 		remoteproc_adsp: remoteproc@3000000 {
 			compatible = "qcom,sc8280xp-adsp-pas";
-			reg = <0 0x03000000 0 0x100>;
+			reg = <0 0x03000000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -1806,7 +1806,7 @@ cpufreq_hw: cpufreq@18591000 {
 
 		remoteproc_nsp0: remoteproc@1b300000 {
 			compatible = "qcom,sc8280xp-nsp0-pas";
-			reg = <0 0x1b300000 0 0x100>;
+			reg = <0 0x1b300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
 					      <&smp2p_nsp0_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -1937,7 +1937,7 @@ compute-cb@14 {
 
 		remoteproc_nsp1: remoteproc@21300000 {
 			compatible = "qcom,sc8280xp-nsp1-pas";
-			reg = <0 0x21300000 0 0x100>;
+			reg = <0 0x21300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 887 IRQ_TYPE_LEVEL_HIGH>,
 					      <&smp2p_nsp1_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 71644b9b8866..a5df310ce7f3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4234,16 +4234,16 @@ camss: camss@acb3000 {
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
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 271247b37175..a3876a322baa 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -27,7 +27,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			clock-output-names = "sleep_clk";
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index ba078099b805..2fb751330e49 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -855,7 +855,7 @@ tcsr_mutex: hwlock@1f40000 {
 
 		adsp: remoteproc@3000000 {
 			compatible = "qcom,sm6350-adsp-pas";
-			reg = <0 0x03000000 0 0x100>;
+			reg = <0x0 0x03000000 0x0 0x10000>;
 
 			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -923,7 +923,7 @@ compute-cb@5 {
 
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm6350-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
 					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 30c94fd4fe61..be47e34da990 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -20,7 +20,7 @@ / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
-	qcom,msm-id = <434 0x10000>, <459 0x10000>;
+	qcom,msm-id = <459 0x10000>;
 	qcom,board-id = <8 32>;
 
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 5397fba9417b..51ddbac3cfe5 100644
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
index c9780b2afd2f..eb500cb67c86 100644
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
@@ -3291,20 +3291,20 @@ camss: camss@ac6a000 {
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
index 888bf4cd73c3..956237489bc4 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -34,7 +34,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 
@@ -1641,7 +1641,7 @@ tcsr_mutex: hwlock@1f40000 {
 
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8350-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index aa0977af9411..3f79aea64446 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -33,7 +33,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 		};
 	};
 
@@ -2265,7 +2265,7 @@ compute-cb@8 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8450-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index e089e0c26a72..a6bae0a45a6d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -147,7 +147,7 @@ &gmac {
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x23>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index eb8690a6be16..04222028e53e 100644
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
index 9301ea388802..4b349d73da21 100644
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
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 6028f1fe2d1c..cc8b36acb996 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -38,6 +38,7 @@ SECTIONS
 	 */
 	/DISCARD/	: {
 		*(.note.GNU-stack .note.gnu.property)
+		*(.ARM.attributes)
 	}
 	.note		: { *(.note.*) }		:text	:note
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b0226eac7bda..a2fb4241f5fb 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -149,6 +149,7 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
+		*(.ARM.attributes)
 	}
 
 	. = KIMAGE_VADDR;
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 134dcf6bc650..99810310efdd 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -544,6 +544,18 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 
 static int __init hugetlbpage_init(void)
 {
+	/*
+	 * HugeTLB pages are supported on maximum four page table
+	 * levels (PUD, CONT PMD, PMD, CONT PTE) for a given base
+	 * page size, corresponding to hugetlb_add_hstate() calls
+	 * here.
+	 *
+	 * HUGE_MAX_HSTATE should at least match maximum supported
+	 * HugeTLB page sizes on the platform. Any new addition to
+	 * supported HugeTLB page sizes will also require changing
+	 * HUGE_MAX_HSTATE as well.
+	 */
+	BUILD_BUG_ON(HUGE_MAX_HSTATE < 4);
 	if (pud_sect_supported())
 		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
 
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index cdb705e1496a..72c6e16c3f23 100644
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
index 6447763ce5a9..b7e394cebe20 100644
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
index 8c401e42301c..f39e85fd58fa 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -248,7 +248,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 #define S_R_SP	(0xafb0 << 16)	/* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
 
-unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
+static unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
 		old_parent_ra, unsigned long parent_ra_addr, unsigned long fp)
 {
 	unsigned long sp, ip, tmp;
diff --git a/arch/mips/loongson64/boardinfo.c b/arch/mips/loongson64/boardinfo.c
index 280989c5a137..8bb275c93ac0 100644
--- a/arch/mips/loongson64/boardinfo.c
+++ b/arch/mips/loongson64/boardinfo.c
@@ -21,13 +21,11 @@ static ssize_t boardinfo_show(struct kobject *kobj,
 		       "BIOS Info\n"
 		       "Vendor\t\t\t: %s\n"
 		       "Version\t\t\t: %s\n"
-		       "ROM Size\t\t: %d KB\n"
 		       "Release Date\t\t: %s\n",
 		       strsep(&tmp_board_manufacturer, "-"),
 		       eboard->name,
 		       strsep(&tmp_bios_vendor, "-"),
 		       einter->description,
-		       einter->size,
 		       especial->special_name);
 }
 static struct kobj_attribute boardinfo_attr = __ATTR(boardinfo, 0444,
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 265bc57819df..c89e70df43d8 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1660,7 +1660,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		break;
 	}
 
-	case 0x3:
+	case 0x7:
 		if (MIPSInst_FUNC(ir) != pfetch_op)
 			return SIGILL;
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index ea71f7245a63..8d8f4909ae1a 100644
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
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 05668e964140..138fe5eb3801 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -242,7 +242,7 @@ static inline int tlbe_is_writable(struct kvm_book3e_206_tlb_entry *tlbe)
 	return tlbe->mas7_3 & (MAS3_SW|MAS3_UW);
 }
 
-static inline void kvmppc_e500_ref_setup(struct tlbe_ref *ref,
+static inline bool kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 					 struct kvm_book3e_206_tlb_entry *gtlbe,
 					 kvm_pfn_t pfn, unsigned int wimg)
 {
@@ -252,11 +252,7 @@ static inline void kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 	/* Use guest supplied MAS2_G and MAS2_E */
 	ref->flags |= (gtlbe->mas2 & MAS2_ATTRIB_MASK) | wimg;
 
-	/* Mark the page accessed */
-	kvm_set_pfn_accessed(pfn);
-
-	if (tlbe_is_writable(gtlbe))
-		kvm_set_pfn_dirty(pfn);
+	return tlbe_is_writable(gtlbe);
 }
 
 static inline void kvmppc_e500_ref_release(struct tlbe_ref *ref)
@@ -326,6 +322,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 {
 	struct kvm_memory_slot *slot;
 	unsigned long pfn = 0; /* silence GCC warning */
+	struct page *page = NULL;
 	unsigned long hva;
 	int pfnmap = 0;
 	int tsize = BOOK3E_PAGESZ_4K;
@@ -337,6 +334,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	unsigned int wimg = 0;
 	pgd_t *pgdir;
 	unsigned long flags;
+	bool writable = false;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_invalidate_seq;
@@ -446,7 +444,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	if (likely(!pfnmap)) {
 		tsize_pages = 1UL << (tsize + 10 - PAGE_SHIFT);
-		pfn = gfn_to_pfn_memslot(slot, gfn);
+		pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, NULL, &page);
 		if (is_error_noslot_pfn(pfn)) {
 			if (printk_ratelimit())
 				pr_err("%s: real page not found for gfn %lx\n",
@@ -481,7 +479,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -490,8 +487,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
-	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
+	local_irq_restore(flags);
 
+	writable = kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
@@ -499,11 +497,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	kvmppc_mmu_flush_icache(pfn);
 
 out:
+	kvm_release_faultin_page(kvm, page, !!ret, writable);
 	spin_unlock(&kvm->mmu_lock);
-
-	/* Drop refcount on page, so that mmu notifiers can clear it */
-	kvm_release_pfn_clean(pfn);
-
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index e5a58a9b2fe9..ce6759e082a7 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
 
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
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 5ed242897b0d..237f36d1e6c2 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -21,7 +21,7 @@ KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
 endif
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index eaeaeb3ff0be..752a2310f0d6 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -44,7 +44,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		break;
 	case FUTEX_OP_ANDN:
 		__futex_atomic_op("lr %2,%1\nnr %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
+				  ret, oldval, newval, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
 		__futex_atomic_op("lr %2,%1\nxr %2,%5\n",
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d90c818a9ae7..30e22aa9415c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1331,8 +1331,14 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
 
@@ -1362,15 +1368,20 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
@@ -1463,7 +1474,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
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
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 4cbf306b8181..be0626a07dd8 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -21,7 +21,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 897f56533e6c..21e1a3b6639d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -34,6 +34,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=i386', and future flags may depend on the target to
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
+KBUILD_CFLAGS += -std=gnu11
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3bc31cd20c81..117f86283183 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4582,8 +4582,11 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	init_debug_store_on_cpu(cpu);
 	/*
-	 * Deal with CPUs that don't clear their LBRs on power-up.
+	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
+	 * even boot with LBRs enabled.
 	 */
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && x86_pmu.lbr_nr)
+		msr_clear_bit(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR_BIT);
 	intel_pmu_lbr_reset();
 
 	cpuc->lbr_sel = NULL;
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 256eee99afc8..e2e1ec99c999 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -16,6 +16,7 @@
 # define PAGES_NR		4
 #endif
 
+# define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
 #ifndef __ASSEMBLY__
@@ -44,7 +45,6 @@ struct kimage;
 /* Maximum address we can use for the control code buffer */
 # define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
-# define KEXEC_CONTROL_PAGE_SIZE	4096
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
@@ -59,9 +59,6 @@ struct kimage;
 /* Maximum address we can use for the control pages */
 # define KEXEC_CONTROL_MEMORY_LIMIT     (MAXMEM-1)
 
-/* Allocate one page for the pdp and the second for the code */
-# define KEXEC_CONTROL_PAGE_SIZE  (4096UL + 4096UL)
-
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
@@ -146,6 +143,19 @@ struct kimage_arch {
 };
 #else
 struct kimage_arch {
+	/*
+	 * This is a kimage control page, as it must not overlap with either
+	 * source or destination address ranges.
+	 */
+	pgd_t *pgd;
+	/*
+	 * The virtual mapping of the control code page itself is used only
+	 * during the transition, while the current kernel's pages are all
+	 * in place. Thus the intermediate page table pages used to map it
+	 * are not control pages, but instead just normal pages obtained
+	 * with get_zeroed_page(). And have to be tracked (below) so that
+	 * they can be freed.
+	 */
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..c07c018a1c13 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -33,6 +33,8 @@ typedef struct {
 	 */
 	atomic64_t tlb_gen;
 
+	unsigned long next_trim_cpumask;
+
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..6f5c7584fe1e 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -106,6 +106,7 @@ static inline int init_new_context(struct task_struct *tsk,
 
 	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
+	mm->context.next_trim_cpumask = jiffies + HZ;
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 681e8401b8a3..5ffcfcc41282 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -357,7 +357,8 @@
 #define MSR_IA32_PASID_VALID		BIT_ULL(31)
 
 /* DEBUGCTLMSR bits (others vary by model): */
-#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_LBR_BIT		0	     /* last branch recording */
+#define DEBUGCTLMSR_LBR			(1UL <<  DEBUGCTLMSR_LBR_BIT)
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..d1eb6bbfd39e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -208,6 +208,7 @@ struct flush_tlb_info {
 	unsigned int		initiating_cpu;
 	u8			stride_shift;
 	u8			freed_tables;
+	u8			trim_cpumask;
 };
 
 void flush_tlb_local(void);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index e8cc042e4905..8992a6bce9f0 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -519,6 +519,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
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
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 24b6eaacc81e..5d61a342871b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -149,7 +149,8 @@ static void free_transition_pgtable(struct kimage *image)
 	image->arch.pte = NULL;
 }
 
-static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
+static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
+				   unsigned long control_page)
 {
 	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
 	unsigned long vaddr, paddr;
@@ -160,7 +161,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pte_t *pte;
 
 	vaddr = (unsigned long)relocate_kernel;
-	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
+	paddr = control_page;
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
@@ -219,7 +220,7 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
-static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
+static int init_pgtable(struct kimage *image, unsigned long control_page)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
@@ -228,12 +229,12 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		.kernpg_flag	= _KERNPG_TABLE_NOENC,
 	};
 	unsigned long mstart, mend;
-	pgd_t *level4p;
 	int result;
 	int i;
 
-	level4p = (pgd_t *)__va(start_pgtable);
-	clear_page(level4p);
+	image->arch.pgd = alloc_pgt_page(image);
+	if (!image->arch.pgd)
+		return -ENOMEM;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
@@ -247,8 +248,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 
-		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+		result = kernel_ident_mapping_init(&info, image->arch.pgd,
+						   mstart, mend);
 		if (result)
 			return result;
 	}
@@ -263,8 +264,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
 
-		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+		result = kernel_ident_mapping_init(&info, image->arch.pgd,
+						   mstart, mend);
 
 		if (result)
 			return result;
@@ -274,15 +275,19 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
 	 * not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_systab(&info, image->arch.pgd);
 	if (result)
 		return result;
 
-	result = map_acpi_tables(&info, level4p);
+	result = map_acpi_tables(&info, image->arch.pgd);
 	if (result)
 		return result;
 
-	return init_transition_pgtable(image, level4p);
+	/*
+	 * This must be last because the intermediate page table pages it
+	 * allocates will not be control pages and may overlap the image.
+	 */
+	return init_transition_pgtable(image, image->arch.pgd, control_page);
 }
 
 static void load_segments(void)
@@ -299,14 +304,14 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long start_pgtable;
+	unsigned long control_page;
 	int result;
 
 	/* Calculate the offsets */
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, start_pgtable);
+	result = init_pgtable(image, control_page);
 	if (result)
 		return result;
 
@@ -353,13 +358,12 @@ void machine_kexec(struct kimage *image)
 #endif
 	}
 
-	control_page = page_address(image->control_code_page) + PAGE_SIZE;
+	control_page = page_address(image->control_code_page);
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] =
-	  (unsigned long)__pa(page_address(image->control_code_page));
+	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
@@ -578,8 +582,7 @@ static void kexec_mark_crashkres(bool protect)
 
 	/* Don't touch the control code page used in crash_kexec().*/
 	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
-	/* Control code page is located in the 2nd page. */
-	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
+	kexec_mark_range(crashk_res.start, control - 1, protect);
 	control += KEXEC_CONTROL_PAGE_SIZE;
 	kexec_mark_range(control, crashk_res.end, protect);
 }
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 587975eca728..ca8dfc0c9edb 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -173,7 +173,6 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
 noinstr void __static_call_update_early(void *tramp, void *func)
 {
 	BUG_ON(system_state != SYSTEM_BOOTING);
-	BUG_ON(!early_boot_irqs_disabled);
 	BUG_ON(static_call_initialized);
 	__text_gen_insn(tramp, JMP32_INSN_OPCODE, tramp, func, JMP32_INSN_SIZE);
 	sync_core();
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 04cca46fed1e..28555bbd52e8 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1915,6 +1915,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	u32 vector;
 	bool all_cpus;
 
+	if (!lapic_in_kernel(vcpu))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 	if (hc->code == HVCALL_SEND_IPI) {
 		if (!hc->fast) {
 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
@@ -2518,7 +2521,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
-			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
+			if (!vcpu || lapic_in_kernel(vcpu))
+				ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
 			if (evmcs_ver)
 				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d392022dcb89..2fa130c4c173 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5150,7 +5150,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 	union kvm_mmu_page_role root_role;
 
 	/* NPT requires CR0.PG=1. */
-	WARN_ON_ONCE(cpu_role.base.direct);
+	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 974f30d38c79..b889dc6e20a7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -619,6 +619,11 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	u32 pause_count12;
 	u32 pause_thresh12;
 
+	nested_svm_transition_tlb_flush(vcpu);
+
+	/* Enter Guest-Mode */
+	enter_guest_mode(vcpu);
+
 	/*
 	 * Filled at exit: exit_code, exit_code_hi, exit_info_1, exit_info_2,
 	 * exit_int_info, exit_int_info_err, next_rip, insn_len, insn_bytes.
@@ -717,11 +722,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		}
 	}
 
-	nested_svm_transition_tlb_flush(vcpu);
-
-	/* Enter Guest-Mode */
-	enter_guest_mode(vcpu);
-
 	/*
 	 * Merge guest and host intercepts - must be called with vcpu in
 	 * guest-mode to take effect.
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9a85d7..b07e2167fceb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -878,9 +878,36 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
 
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool should_flush_tlb(int cpu, void *data)
 {
-	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
+	struct flush_tlb_info *info = data;
+
+	/* Lazy TLB will get flushed at the next context switch. */
+	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
+		return false;
+
+	/* No mm means kernel memory flush. */
+	if (!info->mm)
+		return true;
+
+	/* The target mm is loaded, and the CPU is not lazy. */
+	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
+		return true;
+
+	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
+	if (info->trim_cpumask)
+		return true;
+
+	return false;
+}
+
+static bool should_trim_cpumask(struct mm_struct *mm)
+{
+	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
+		WRITE_ONCE(mm->context.next_trim_cpumask, jiffies + HZ);
+		return true;
+	}
+	return false;
 }
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
@@ -914,7 +941,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	if (info->freed_tables)
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
+		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
 
@@ -965,6 +992,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
 	info->initiating_cpu	= smp_processor_id();
+	info->trim_cpumask	= 0;
 
 	return info;
 }
@@ -1007,6 +1035,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * flush_tlb_func_local() directly in this case.
 	 */
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ee29fb558f2e..7dabdb999565 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -97,6 +97,51 @@ static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
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
@@ -766,6 +811,7 @@ void xen_mm_pin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -776,6 +822,7 @@ void xen_mm_pin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
@@ -797,6 +844,9 @@ static void __init xen_after_bootmem(void)
 	SetPagePinned(virt_to_page(level3_user_vsyscall));
 #endif
 	xen_pgd_walk(&init_mm, xen_mark_pinned, FIXADDR_TOP);
+
+	if (alloc_discontig_frames(MIN_CONTIG_ORDER))
+		BUG();
 }
 
 static void xen_unpin_page(struct mm_struct *mm, struct page *page,
@@ -872,6 +922,7 @@ void xen_mm_unpin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -883,6 +934,7 @@ void xen_mm_unpin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
@@ -2177,10 +2229,6 @@ void __init xen_init_mmu_ops(void)
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
 
-/* Protected by xen_reservation_lock. */
-#define MAX_CONTIG_ORDER 9 /* 2MB */
-static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
-
 #define VOID_PTE (mfn_pte(0, __pgprot(0)))
 static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
 				unsigned long *in_frames,
@@ -2297,24 +2345,25 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
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
 
@@ -2338,12 +2387,12 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 
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
@@ -2351,6 +2400,8 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
+	out_frames = discontig_frames;
+
 	/* 1. Find start MFN of contiguous extent. */
 	in_frame = virt_to_mfn(vstart);
 
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 1cf94caa7600..31d9e56ad6c6 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -110,8 +110,8 @@ SYM_FUNC_START(xen_hypercall_hvm)
 	pop %ebx
 	pop %eax
 #else
-	lea xen_hypercall_amd(%rip), %rbx
-	cmp %rax, %rbx
+	lea xen_hypercall_amd(%rip), %rcx
+	cmp %rax, %rcx
 #ifdef CONFIG_FRAME_POINTER
 	pop %rax	/* Dummy pop. */
 #endif
@@ -125,6 +125,7 @@ SYM_FUNC_START(xen_hypercall_hvm)
 	pop %rcx
 	pop %rax
 #endif
+	FRAME_END
 	/* Use correct hypercall function. */
 	jz xen_hypercall_amd
 	jmp xen_hypercall_intel
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b7bf1cfdbb4b..cced5a2d5fb6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -924,6 +924,7 @@ static void blkcg_fill_root_iostats(void)
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
 		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 	}
+	class_dev_iter_exit(&iter);
 }
 
 static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
diff --git a/block/fops.c b/block/fops.c
index 01cb6260fa24..b02fe200c3ec 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -601,11 +601,12 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		file_accessed(iocb->ki_filp);
 
 		ret = blkdev_direct_IO(iocb, to);
-		if (ret >= 0) {
+		if (ret > 0) {
 			iocb->ki_pos += ret;
 			count -= ret;
 		}
-		iov_iter_revert(to, count - iov_iter_count(to));
+		if (ret != -EIOCBQUEUED)
+			iov_iter_revert(to, count - iov_iter_count(to));
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
diff --git a/block/genhd.c b/block/genhd.c
index 8256e11f85b7..1cb517969607 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -738,7 +738,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 }
 
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
-void blk_request_module(dev_t devt)
+static bool blk_probe_dev(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -748,14 +748,26 @@ void blk_request_module(dev_t devt)
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
index 0a747a0c782d..f98dbee94149 100644
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
index 7b521df00a39..6415213cd184 100644
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
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index dd808cf65c84..83a4b417b27b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -155,8 +155,6 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_panic_timeout __read_mostly = 30;
-
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -858,14 +856,16 @@ static void __ghes_panic(struct ghes *ghes,
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
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 52a0b303b70a..36907331a669 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -366,19 +366,25 @@ static int acpi_fan_probe(struct platform_device *pdev)
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
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index dd0261fd12d6..7747ca4168ab 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -263,9 +263,7 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
-		if (!handler->handler_addr ||
-		    !handler->static_data_buffer_addr ||
-		    !handler->acpi_param_buffer_addr) {
+		if (!handler->handler_addr) {
 			buffer->prm_status = PRM_HANDLER_ERROR;
 			return AE_OK;
 		}
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 62aee900af3d..f8a56aae97a5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1128,8 +1128,6 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 		}
 		break;
 	}
-	if (nval == 0)
-		return -EINVAL;
 
 	if (obj->type == ACPI_TYPE_BUFFER) {
 		if (proptype != DEV_PROP_U8)
@@ -1153,9 +1151,11 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 		ret = acpi_copy_property_array_uint(items, (u64 *)val, nval);
 		break;
 	case DEV_PROP_STRING:
-		ret = acpi_copy_property_array_string(
-			items, (char **)val,
-			min_t(u32, nval, obj->package.count));
+		nval = min_t(u32, nval, obj->package.count);
+		if (nval == 0)
+			return -ENODATA;
+
+		ret = acpi_copy_property_array_string(items, (char **)val, nval);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7916e369e15e..3601fd44430f 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -658,7 +658,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, count;
 
 	if (!qc->cursg) {
 		qc->curbytes = qc->nbytes;
@@ -674,25 +674,27 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
+	/* don't overrun current sg */
+	count = min(qc->cursg->length - qc->cursg_ofs, qc->sect_size);
+
+	trace_ata_sff_pio_transfer_data(qc, offset, count);
 
 	/*
 	 * Split the transfer when it splits a page boundary.  Note that the
 	 * split still has to be dword aligned like all ATA data transfers.
 	 */
 	WARN_ON_ONCE(offset % 4);
-	if (offset + qc->sect_size > PAGE_SIZE) {
+	if (offset + count > PAGE_SIZE) {
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0,
-			     qc->sect_size - split_len);
+		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
 	} else {
-		ata_pio_xfer(qc, page, offset, qc->sect_size);
+		ata_pio_xfer(qc, page, offset, count);
 	}
 
-	qc->curbytes += qc->sect_size;
-	qc->cursg_ofs += qc->sect_size;
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == qc->cursg->length) {
 		qc->cursg = sg_next(qc->cursg);
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index db19e9c76e4f..dfe0da4ed47e 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -1059,6 +1059,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
 	if (d->virt_buf) {
@@ -1139,6 +1140,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
 	if (d->config_buf) {
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1f3cd5de4117..7f6ef0a2b4a5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2133,6 +2133,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	flush_workqueue(nbd->recv_workq);
 	nbd_clear_que(nbd);
 	nbd->task_setup = NULL;
+	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
 	mutex_unlock(&nbd->config_lock);
 
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index a0e9e80d92ee..d6a4b1671d5b 100644
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
diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 09ca82356399..d8ae39295996 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -291,7 +291,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 			vco = vco_pre * f;
 		}
 
-		delta = abs(target_rate - vco);
+		delta = abs(target_vco_rate - vco);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_r = r;
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 2de49bbc40f3..444dfd6adfe6 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -398,8 +398,9 @@ static const char * const imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_r
 
 static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
 						  "dummy", "dummy", "gpu_pll_out", "vpu_pll_out",
-						  "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
-						  "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
+						  "arm_pll_out", "sys_pll1_out", "sys_pll2_out",
+						  "sys_pll3_out", "dummy", "dummy", "osc_24m",
+						  "dummy", "osc_32k"};
 
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8780fd107472..e63a90db1505 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -339,6 +339,8 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	mask |= config->pre_div_mask;
 	mask |= config->post_div_mask;
 	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
 
 	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
 
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 60819a39702d..97bfb3c726f8 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -332,7 +332,7 @@ static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_rpmh *c = to_clk_rpmh(hw);
 
-	return c->aggr_state * c->unit;
+	return (unsigned long)c->aggr_state * c->unit;
 }
 
 static const struct clk_ops clk_rpmh_bcm_ops = {
diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index 441f042f5ea4..ddacb4f76eca 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -187,13 +187,12 @@ static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
 	.cmd_rcgr = 0x1144,
 	.mnd_width = 0,
 	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_6,
 	.freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_aux_clk_src",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "bi_tcxo",
-		},
-		.num_parents = 1,
+		.parent_data = disp_cc_parent_data_6,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
 		.ops = &clk_rcg2_ops,
 	},
 };
diff --git a/drivers/clk/qcom/gcc-mdm9607.c b/drivers/clk/qcom/gcc-mdm9607.c
index 4c9078e99bb3..19c701b23ac7 100644
--- a/drivers/clk/qcom/gcc-mdm9607.c
+++ b/drivers/clk/qcom/gcc-mdm9607.c
@@ -536,7 +536,7 @@ static struct clk_rcg2 blsp1_uart5_apps_clk_src = {
 };
 
 static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
-	.cmd_rcgr = 0x6044,
+	.cmd_rcgr = 0x7044,
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index ef15e8f11402..0ea549d79283 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -455,7 +455,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
@@ -471,7 +471,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
@@ -487,7 +487,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
@@ -503,7 +503,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
@@ -519,7 +519,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
@@ -535,7 +535,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
@@ -551,7 +551,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
@@ -567,7 +567,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
@@ -583,7 +583,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
@@ -599,7 +599,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
@@ -615,7 +615,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
@@ -631,7 +631,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
@@ -647,7 +647,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
@@ -663,7 +663,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
@@ -679,7 +679,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
@@ -695,7 +695,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 0559a33faf00..428cd99dcdcb 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -182,6 +182,14 @@ static const struct clk_parent_data gcc_parent_data_2_ao[] = {
 	{ .hw = &gpll0_out_odd.clkr.hw },
 };
 
+static const struct parent_map gcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data gcc_parent_data_3[] = {
+	{ .fw_name = "bi_tcxo" },
+};
+
 static const struct parent_map gcc_parent_map_4[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -701,13 +709,12 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.cmd_rcgr = 0x3a0b0,
 	.mnd_width = 0,
 	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_ufs_phy_phy_aux_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "bi_tcxo",
-		},
-		.num_parents = 1,
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -764,13 +771,12 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.cmd_rcgr = 0x1a034,
 	.mnd_width = 0,
 	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "bi_tcxo",
-		},
-		.num_parents = 1,
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index 5f93b5526e13..52c1d5ebb0a1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -436,7 +436,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  0, 4,		/* M */
@@ -444,7 +444,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  0, 4,		/* M */
@@ -452,7 +452,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
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
 
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 1bb2b90ebb21..72464e4132e2 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -635,7 +635,14 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
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
@@ -658,6 +665,9 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
 	nominal_perf = perf_caps.nominal_perf;
 
+	if (nominal_freq)
+		*nominal_freq = perf_caps.nominal_freq;
+
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
 		return 0;
@@ -670,8 +680,12 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 
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
@@ -681,9 +695,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -833,16 +847,20 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index c6bdfc308e99..9cef71528076 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -24,6 +24,7 @@ struct s3c64xx_dvfs {
 	unsigned int vddarm_max;
 };
 
+#ifdef CONFIG_REGULATOR
 static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[0] = { 1000000, 1150000 },
 	[1] = { 1050000, 1150000 },
@@ -31,6 +32,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[3] = { 1200000, 1350000 },
 	[4] = { 1300000, 1350000 },
 };
+#endif
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0, 0,  66000 },
@@ -51,15 +53,16 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
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
index 09a20307d01e..55b95968ecb7 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -850,6 +850,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		ret = sec_skcipher_aes_sm4_setkey(c_ctx, keylen, c_mode);
 		break;
 	default:
+		dev_err(dev, "sec c_alg err!\n");
 		return -EINVAL;
 	}
 
@@ -953,15 +954,14 @@ static int sec_aead_mac_init(struct sec_aead_req *req)
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
 
@@ -1124,10 +1124,7 @@ static int sec_aead_setauthsize(struct crypto_aead *aead, unsigned int authsize)
 	struct sec_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	if (unlikely(a_ctx->fallback_aead_tfm))
-		return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
-
-	return 0;
+	return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
 }
 
 static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
@@ -1143,7 +1140,6 @@ static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
 static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 			   const u32 keylen, const enum sec_hash_alg a_alg,
 			   const enum sec_calg c_alg,
-			   const enum sec_mac_len mac_len,
 			   const enum sec_cmode c_mode)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
@@ -1155,7 +1151,6 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 	ctx->a_ctx.a_alg = a_alg;
 	ctx->c_ctx.c_alg = c_alg;
-	ctx->a_ctx.mac_len = mac_len;
 	c_ctx->c_mode = c_mode;
 
 	if (c_mode == SEC_CMODE_CCM || c_mode == SEC_CMODE_GCM) {
@@ -1166,16 +1161,11 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
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
 
-	if (crypto_authenc_extractkeys(&keys, key, keylen))
+	ret = crypto_authenc_extractkeys(&keys, key, keylen);
+	if (ret)
 		goto bad_key;
 
 	ret = sec_aead_aes_set_key(c_ctx, &keys);
@@ -1190,9 +1180,15 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
-	if ((ctx->a_ctx.mac_len & SEC_SQE_LEN_RATE_MASK)  ||
-	    (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK)) {
-		dev_err(dev, "MAC or AUTH key length error!\n");
+	if (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK) {
+		ret = -EINVAL;
+		dev_err(dev, "AUTH key length error!\n");
+		goto bad_key;
+	}
+
+	ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
+	if (ret) {
+		dev_err(dev, "set sec fallback key err!\n");
 		goto bad_key;
 	}
 
@@ -1200,31 +1196,23 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 bad_key:
 	memzero_explicit(&keys, sizeof(struct crypto_authenc_keys));
-	return -EINVAL;
+	return ret;
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
@@ -1473,9 +1461,10 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
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
@@ -1516,10 +1505,8 @@ static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
 static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
-	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
-	size_t authsize = crypto_aead_authsize(tfm);
-	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_aead_req *a_req = &req->aead_req;
+	struct sec_cipher_req *c_req = &req->c_req;
 
 	memcpy(c_req->c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
 
@@ -1527,15 +1514,11 @@ static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
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
@@ -1545,9 +1528,11 @@ static void sec_auth_bd_fill_xcm(struct sec_auth_ctx *ctx, int dir,
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
@@ -1571,9 +1556,11 @@ static void sec_auth_bd_fill_xcm_v3(struct sec_auth_ctx *ctx, int dir,
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
@@ -1597,11 +1584,12 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
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
@@ -1651,11 +1639,13 @@ static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
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
@@ -1706,9 +1696,9 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
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
@@ -1721,10 +1711,8 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
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
@@ -1933,8 +1921,10 @@ static void sec_aead_exit(struct crypto_aead *tfm)
 
 static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 {
+	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
-	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
+	const char *aead_name = alg->base.cra_name;
 	int ret;
 
 	ret = sec_aead_init(tfm);
@@ -1943,11 +1933,20 @@ static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
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
@@ -1957,6 +1956,7 @@ static void sec_aead_ctx_exit(struct crypto_aead *tfm)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
 
+	crypto_free_aead(ctx->a_ctx.fallback_aead_tfm);
 	crypto_free_shash(ctx->a_ctx.hash_tfm);
 	sec_aead_exit(tfm);
 }
@@ -1983,7 +1983,6 @@ static int sec_aead_xcm_ctx_init(struct crypto_aead *tfm)
 		sec_aead_exit(tfm);
 		return PTR_ERR(a_ctx->fallback_aead_tfm);
 	}
-	a_ctx->fallback = false;
 
 	return 0;
 }
@@ -2264,21 +2263,20 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
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
 
@@ -2297,7 +2295,7 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (sreq->c_req.encrypt)
 		sreq->c_req.c_len = req->cryptlen;
 	else
-		sreq->c_req.c_len = req->cryptlen - authsize;
+		sreq->c_req.c_len = req->cryptlen - sz;
 	if (c_mode == SEC_CMODE_CBC) {
 		if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
 			dev_err(dev, "aead crypto length error!\n");
@@ -2323,8 +2321,8 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 
 	if (ctx->sec->qm.ver == QM_HW_V2) {
 		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
-		    req->cryptlen <= authsize))) {
-			ctx->a_ctx.fallback = true;
+			     req->cryptlen <= authsize))) {
+			sreq->aead_req.fallback = true;
 			return -EINVAL;
 		}
 	}
@@ -2352,16 +2350,9 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
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
@@ -2393,10 +2384,11 @@ static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
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
index d033f63b583f..db3fceb88e69 100644
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
diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index d39a386b31ac..cfb149302e0a 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -469,6 +469,7 @@ static int init_ixp_crypto(struct device *dev)
 			return -ENODEV;
 		}
 		npe_id = npe_spec.args[0];
+		of_node_put(npe_spec.np);
 
 		ret = of_parse_phandle_with_fixed_args(np, "queue-rx", 1, 0,
 						       &queue_spec);
@@ -477,6 +478,7 @@ static int init_ixp_crypto(struct device *dev)
 			return -ENODEV;
 		}
 		recv_qid = queue_spec.args[0];
+		of_node_put(queue_spec.np);
 
 		ret = of_parse_phandle_with_fixed_args(np, "queue-txready", 1, 0,
 						       &queue_spec);
@@ -485,6 +487,7 @@ static int init_ixp_crypto(struct device *dev)
 			return -ENODEV;
 		}
 		send_qid = queue_spec.args[0];
+		of_node_put(queue_spec.np);
 	} else {
 		/*
 		 * Hardcoded engine when using platform data, this goes away
diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 6eb4d2e35629..6fe41ae98252 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -786,7 +786,7 @@ static int qce_aead_register_one(const struct qce_aead_def *def, struct qce_devi
 	alg->init			= qce_aead_init;
 	alg->exit			= qce_aead_exit;
 
-	alg->base.cra_priority		= 300;
+	alg->base.cra_priority		= 275;
 	alg->base.cra_flags		= CRYPTO_ALG_ASYNC |
 					  CRYPTO_ALG_ALLOCATES_MEMORY |
 					  CRYPTO_ALG_KERN_DRIVER_ONLY |
diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index d3780be44a76..df4ae3377b61 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -48,16 +48,19 @@ static void qce_unregister_algs(struct qce_device *qce)
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
@@ -236,7 +239,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 
 	ret = qce_check_version(qce);
 	if (ret)
-		goto err_clks;
+		goto err_dma;
 
 	spin_lock_init(&qce->lock);
 	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 37bafd7aeb79..f950f1bfc7ea 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -482,7 +482,7 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 
 	base = &alg->halg.base;
 	base->cra_blocksize = def->blocksize;
-	base->cra_priority = 300;
+	base->cra_priority = 175;
 	base->cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 	base->cra_ctxsize = sizeof(struct qce_sha_ctx);
 	base->cra_alignmask = 0;
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 5b493fdc1e74..ffb334eb5b34 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -461,7 +461,7 @@ static int qce_skcipher_register_one(const struct qce_skcipher_def *def,
 	alg->encrypt			= qce_skcipher_encrypt;
 	alg->decrypt			= qce_skcipher_decrypt;
 
-	alg->base.cra_priority		= 300;
+	alg->base.cra_priority		= 275;
 	alg->base.cra_flags		= CRYPTO_ALG_ASYNC |
 					  CRYPTO_ALG_ALLOCATES_MEMORY |
 					  CRYPTO_ALG_KERN_DRIVER_ONLY;
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 9212ac9f978f..89e06c87a258 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -209,7 +209,6 @@ struct edma_desc {
 struct edma_cc;
 
 struct edma_tc {
-	struct device_node		*node;
 	u16				id;
 };
 
@@ -2475,13 +2474,13 @@ static int edma_probe(struct platform_device *pdev)
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
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..5583ae61f214 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -139,7 +139,7 @@ config ISCSI_IBFT
 	select ISCSI_BOOT_SYSFS
 	select ISCSI_IBFT_FIND if X86
 	depends on ACPI && SCSI && SCSI_LOWLEVEL
-	default	n
+	default n
 	help
 	  This option enables support for detection and exposing of iSCSI
 	  Boot Firmware Table (iBFT) via sysfs to userspace. If you wish to
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 28d4defc5d0c..9786dfff9f84 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -835,13 +835,15 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
 		     EFI_MEMORY_NV | EFI_MEMORY_SP | EFI_MEMORY_CPU_CRYPTO |
-		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
+		     EFI_MEMORY_MORE_RELIABLE | EFI_MEMORY_HOT_PLUGGABLE |
+		     EFI_MEMORY_RUNTIME))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
 			 attr & EFI_MEMORY_RUNTIME		? "RUN" : "",
+			 attr & EFI_MEMORY_HOT_PLUGGABLE	? "HP"  : "",
 			 attr & EFI_MEMORY_MORE_RELIABLE	? "MR"  : "",
 			 attr & EFI_MEMORY_CPU_CRYPTO   	? "CC"  : "",
 			 attr & EFI_MEMORY_SP			? "SP"  : "",
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 748781c25787..0c3893f00d55 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -7,7 +7,7 @@
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index fff826f56728..5d88a5a46b09 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -25,6 +25,9 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 	if (md->type != EFI_CONVENTIONAL_MEMORY)
 		return 0;
 
+	if (md->attribute & EFI_MEMORY_HOT_PLUGGABLE)
+		return 0;
+
 	if (efi_soft_reserve_enabled() &&
 	    (md->attribute & EFI_MEMORY_SP))
 		return 0;
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index bf6fbd5d22a1..713ee2de02cf 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -53,6 +53,9 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (desc->attribute & EFI_MEMORY_HOT_PLUGGABLE)
+			continue;
+
 		if (efi_soft_reserve_enabled() &&
 		    (desc->attribute & EFI_MEMORY_SP))
 			continue;
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 456d0e5eaf78..f47968029983 100644
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
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 70770429ba48..3373e46e3ba0 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -68,6 +68,22 @@ struct bcm_kona_gpio {
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
@@ -85,14 +101,24 @@ static void bcm_kona_gpio_lock_gpio(struct bcm_kona_gpio *kona_gpio,
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
@@ -101,14 +127,20 @@ static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
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
@@ -359,6 +391,7 @@ static void bcm_kona_gpio_irq_mask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MASK(bank_id));
@@ -381,6 +414,7 @@ static void bcm_kona_gpio_irq_unmask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MSKCLR(bank_id));
@@ -476,15 +510,26 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
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
@@ -622,7 +667,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		bank->irq = platform_get_irq(pdev, i);
 		bank->kona_gpio = kona_gpio;
 		if (bank->irq < 0) {
-			dev_err(dev, "Couldn't get IRQ for bank %d", i);
+			dev_err(dev, "Couldn't get IRQ for bank %d\n", i);
 			ret = -ENOENT;
 			goto err_irq_domain;
 		}
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 853d9aa6b3b1..d456077c74f2 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -445,8 +445,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	port->gc.request = gpiochip_generic_request;
 	port->gc.free = gpiochip_generic_free;
 	port->gc.to_irq = mxc_gpio_to_irq;
-	port->gc.base = (pdev->id < 0) ? of_alias_get_id(np, "gpio") * 32 :
-					     pdev->id * 32;
+	port->gc.base = of_alias_get_id(np, "gpio") * 32;
 
 	err = devm_gpiochip_add_data(&pdev->dev, &port->gc, port);
 	if (err)
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 9ce54bf2030d..262b3d276df7 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -851,25 +851,6 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 	DECLARE_BITMAP(trigger, MAX_LINE);
 	int ret;
 
-	if (chip->driver_data & PCA_PCAL) {
-		/* Read the current interrupt status from the device */
-		ret = pca953x_read_regs(chip, PCAL953X_INT_STAT, trigger);
-		if (ret)
-			return false;
-
-		/* Check latched inputs and clear interrupt status */
-		ret = pca953x_read_regs(chip, chip->regs->input, cur_stat);
-		if (ret)
-			return false;
-
-		/* Apply filter for rising/falling edge selection */
-		bitmap_replace(new_stat, chip->irq_trig_fall, chip->irq_trig_raise, cur_stat, gc->ngpio);
-
-		bitmap_and(pending, new_stat, trigger, gc->ngpio);
-
-		return !bitmap_empty(pending, gc->ngpio);
-	}
-
 	ret = pca953x_read_regs(chip, chip->regs->input, cur_stat);
 	if (ret)
 		return false;
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 0fa4f0a93378..0ef21752b05b 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -191,7 +191,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 		[REG_IE][CSB] = STMPE_IDX_IEGPIOR_CSB,
 		[REG_IE][MSB] = STMPE_IDX_IEGPIOR_MSB,
 	};
-	int i, j;
+	int ret, i, j;
 
 	/*
 	 * STMPE1600: to be able to get IRQ from pins,
@@ -199,8 +199,16 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
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
@@ -222,6 +230,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 		}
 	}
 
+err:
 	mutex_unlock(&stmpe_gpio->irq_lock);
 }
 
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 2fc6b6ff7f16..8f094c898002 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -52,7 +52,6 @@
  * @dir: GPIO direction shadow register
  * @gpio_lock: Lock used for synchronization
  * @irq: IRQ used by GPIO device
- * @irqchip: IRQ chip
  * @enable: GPIO IRQ enable/disable bitfield
  * @rising_edge: GPIO IRQ rising edge enable/disable bitfield
  * @falling_edge: GPIO IRQ falling edge enable/disable bitfield
@@ -66,9 +65,8 @@ struct xgpio_instance {
 	DECLARE_BITMAP(state, 64);
 	DECLARE_BITMAP(last_irq_read, 64);
 	DECLARE_BITMAP(dir, 64);
-	spinlock_t gpio_lock;	/* For serializing operations */
+	raw_spinlock_t gpio_lock;	/* For serializing operations */
 	int irq;
-	struct irq_chip irqchip;
 	DECLARE_BITMAP(enable, 64);
 	DECLARE_BITMAP(rising_edge, 64);
 	DECLARE_BITMAP(falling_edge, 64);
@@ -181,14 +179,14 @@ static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write to GPIO signal and set its direction to output */
 	__assign_bit(bit, chip->state, val);
 
 	xgpio_write_ch(chip, XGPIO_DATA_OFFSET, bit, chip->state);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -212,7 +210,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	bitmap_remap(hw_mask, mask, chip->sw_map, chip->hw_map, 64);
 	bitmap_remap(hw_bits, bits, chip->sw_map, chip->hw_map, 64);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	bitmap_replace(state, chip->state, hw_bits, hw_mask, 64);
 
@@ -220,7 +218,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 
 	bitmap_copy(chip->state, state, 64);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -238,13 +236,13 @@ static int xgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Set the GPIO bit in shadow register and set direction as input */
 	__set_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -267,7 +265,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write state of GPIO signal */
 	__assign_bit(bit, chip->state, val);
@@ -277,7 +275,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	__clear_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -405,7 +403,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 	int bit = xgpio_to_bit(chip, irq_offset);
 	u32 mask = BIT(bit / 32), temp;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__clear_bit(bit, chip->enable);
 
@@ -415,7 +413,9 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 		temp &= ~mask;
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, temp);
 	}
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
+
+	gpiochip_disable_irq(&chip->gc, irq_offset);
 }
 
 /**
@@ -431,7 +431,9 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 	u32 old_enable = xgpio_get_value32(chip->enable, bit);
 	u32 mask = BIT(bit / 32), val;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	gpiochip_enable_irq(&chip->gc, irq_offset);
+
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__set_bit(bit, chip->enable);
 
@@ -450,7 +452,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, val);
 	}
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -515,7 +517,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 
 	chained_irq_enter(irqchip, desc);
 
-	spin_lock(&chip->gpio_lock);
+	raw_spin_lock(&chip->gpio_lock);
 
 	xgpio_read_ch_all(chip, XGPIO_DATA_OFFSET, all);
 
@@ -532,7 +534,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 	bitmap_copy(chip->last_irq_read, all, 64);
 	bitmap_or(all, rising, falling, 64);
 
-	spin_unlock(&chip->gpio_lock);
+	raw_spin_unlock(&chip->gpio_lock);
 
 	dev_dbg(gc->parent, "IRQ rising %*pb falling %*pb\n", 64, rising, 64, falling);
 
@@ -544,6 +546,16 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static const struct irq_chip xgpio_irq_chip = {
+	.name = "gpio-xilinx",
+	.irq_ack = xgpio_irq_ack,
+	.irq_mask = xgpio_irq_mask,
+	.irq_unmask = xgpio_irq_unmask,
+	.irq_set_type = xgpio_set_irq_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /**
  * xgpio_probe - Probe method for the GPIO device.
  * @pdev: pointer to the platform device
@@ -623,7 +635,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	bitmap_set(chip->hw_map,  0, width[0]);
 	bitmap_set(chip->hw_map, 32, width[1]);
 
-	spin_lock_init(&chip->gpio_lock);
+	raw_spin_lock_init(&chip->gpio_lock);
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = bitmap_weight(chip->hw_map, 64);
@@ -664,12 +676,6 @@ static int xgpio_probe(struct platform_device *pdev)
 	if (chip->irq <= 0)
 		goto skip_irq;
 
-	chip->irqchip.name = "gpio-xilinx";
-	chip->irqchip.irq_ack = xgpio_irq_ack;
-	chip->irqchip.irq_mask = xgpio_irq_mask;
-	chip->irqchip.irq_unmask = xgpio_irq_unmask;
-	chip->irqchip.irq_set_type = xgpio_set_irq_type;
-
 	/* Disable per-channel interrupts */
 	xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, 0);
 	/* Clear any existing per-channel interrupts */
@@ -679,7 +685,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	xgpio_writereg(chip->regs + XGPIO_GIER_OFFSET, XGPIO_GIER_IE);
 
 	girq = &chip->gc.irq;
-	girq->chip = &chip->irqchip;
+	gpio_irq_chip_set_chip(girq, &xgpio_irq_chip);
 	girq->parent_handler = xgpio_irqhandler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 33d73687e463..baa77a8e8365 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1640,6 +1640,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "PNP0C50:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from GPIO 11
+		 * Found in BIOS 1.04
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3954
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro V 14"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@11",
+		},
+	},
 	{} /* Terminating entry */
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1acef5f3838f..5eb994ed5471 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1555,16 +1555,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	return ret;
 }
 
-static unsigned int kbps_from_pbn(unsigned int pbn)
+static uint32_t kbps_from_pbn(unsigned int pbn)
 {
-	unsigned int kbps = pbn;
+	uint64_t kbps = (uint64_t)pbn;
 
 	kbps *= (1000000 / PEAK_FACTOR_X1000);
 	kbps *= 8;
 	kbps *= 54;
 	kbps /= 64;
 
-	return kbps;
+	return (uint32_t)kbps;
 }
 
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 3ce0ee0d012f..367b163537c4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -568,11 +568,19 @@ void dcn3_clk_mgr_construct(
 	dce_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 1d84a04acb3f..3ade764d3323 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -816,11 +816,19 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->smu_present = false;
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bbaeb6c567d0..f0db2d58fd6b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -83,7 +83,7 @@ static void dc_link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 8d7b2eee8c7c..3f32e9c3fbaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -65,8 +65,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 5a8d1a051314..6c58618f1b9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2062,6 +2062,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index d3f76512841b..73a7b1ec353e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1324,6 +1324,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1773,6 +1775,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 6b8abdb5c7f8..1a4280b89a1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1372,6 +1372,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1743,6 +1745,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	if (filter_modes_for_single_channel_workaround(dc, context))
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index b9b1e5ac4f53..e78954514e3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1325,6 +1325,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index af3eddc0cf32..932fe9b5c08c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1322,6 +1322,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index ef47fb2f6905..1b1534ffee9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1310,6 +1310,8 @@ static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
@@ -1855,6 +1857,9 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index aed92ced7b76..85430e5baa45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1296,6 +1296,8 @@ static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index cc3b62f73394..1fbd23922082 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1420,6 +1420,8 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 			GetIndexIntoMasterTable(DATA, SMU_Info),
 			&size, &frev, &crev);
 
+	if (!psmu_info)
+		return -EINVAL;
 
 	for (i = 0; i < psmu_info->ucSclkEntryNum; i++) {
 		table->entry[i].ucVco_setting = psmu_info->asSclkFcwRangeEntry[i].ucVco_setting;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1a02930d93df..537285f255ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -516,7 +516,8 @@ static int smu_sys_set_pp_table(void *handle,
 		return -EIO;
 	}
 
-	if (!smu_table->hardcode_pptable) {
+	if (!smu_table->hardcode_pptable || smu_table->power_play_table_size < size) {
+		kfree(smu_table->hardcode_pptable);
 		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
 		if (!smu_table->hardcode_pptable)
 			return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c79bff02a31a..1ba1bb4f5bd7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1759,7 +1759,6 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
 	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
-	gpu_metrics->average_mm_activity = 0;
 
 	/* Valid power data is available only from primary die */
 	if (aldebaran_is_primary(smu)) {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index ebccb74306a7..f30b3d5eeca5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -160,6 +160,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
 					       kwb_conn->wb_layer->layer_type,
 					       &n_formats);
+	if (!formats) {
+		kfree(kwb_conn);
+		return -ENOMEM;
+	}
 
 	err = drm_writeback_connector_init(&kms->base, wb_conn,
 					   &komeda_wb_connector_funcs,
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 5a23277be444..7c3bd539655b 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -296,11 +296,11 @@
 #define MAX_LANE_COUNT 4
 #define MAX_LINK_RATE HBR
 #define AUTO_TRAIN_RETRY 3
-#define MAX_HDCP_DOWN_STREAM_COUNT 10
+#define MAX_HDCP_DOWN_STREAM_COUNT 127
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-#define AUX_FIFO_MAX_SIZE 32
+#define AUX_FIFO_MAX_SIZE 16
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
@@ -2011,7 +2011,7 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 {
 	struct device *dev = &it6505->client->dev;
 	u8 av[5][4], bv[5][4];
-	int i, err;
+	int i, err, retry;
 
 	i = it6505_setup_sha1_input(it6505, it6505->sha1_input);
 	if (i <= 0) {
@@ -2020,22 +2020,28 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 	}
 
 	it6505_sha1_digest(it6505, it6505->sha1_input, i, (u8 *)av);
+	/*1B-05 V' must retry 3 times */
+	for (retry = 0; retry < 3; retry++) {
+		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
+				      sizeof(bv));
 
-	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
-			      sizeof(bv));
+		if (err < 0) {
+			dev_err(dev, "Read V' value Fail %d", retry);
+			continue;
+		}
 
-	if (err < 0) {
-		dev_err(dev, "Read V' value Fail");
-		return false;
-	}
+		for (i = 0; i < 5; i++) {
+			if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
+			    av[i][1] != av[i][2] || bv[i][0] != av[i][3])
+				break;
 
-	for (i = 0; i < 5; i++)
-		if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
-		    bv[i][1] != av[i][2] || bv[i][0] != av[i][3])
-			return false;
+			DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d, %d", retry, i);
+			return true;
+		}
+	}
 
-	DRM_DEV_DEBUG_DRIVER(dev, "V' all match!!");
-	return true;
+	DRM_DEV_DEBUG_DRIVER(dev, "V' NOT match!! %d", retry);
+	return false;
 }
 
 static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
@@ -2069,15 +2075,12 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
 	DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
 			     ksv_list_check ? "pass" : "fail");
-	if (ksv_list_check) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-				HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
+	if (ksv_list_check)
 		return;
-	}
+
 timeout:
-	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL);
+	it6505_start_hdcp(it6505);
 }
 
 static void it6505_hdcp_work(struct work_struct *work)
@@ -2292,14 +2295,20 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
 
 	if (dp_irq_vector & DP_CP_IRQ) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
-				HDCP_TRIGGER_CPIRQ);
-
 		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
 		if (bstatus < 0)
 			return bstatus;
 
 		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
+
+		/*Check BSTATUS when recive CP_IRQ */
+		if (bstatus & DP_BSTATUS_R0_PRIME_READY &&
+		    it6505->hdcp_status == HDCP_AUTH_GOING)
+			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
+					HDCP_TRIGGER_CPIRQ);
+		else if (bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE) &&
+			 it6505->hdcp_status == HDCP_AUTH_DONE)
+			it6505_start_hdcp(it6505);
 	}
 
 	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);
@@ -2419,7 +2428,11 @@ static void it6505_irq_hdcp_ksv_check(struct it6505 *it6505)
 {
 	struct device *dev = &it6505->client->dev;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "HDCP event Interrupt");
+	DRM_DEV_DEBUG_DRIVER(dev, "HDCP repeater R0 event Interrupt");
+	/* 1B01 HDCP encription should start when R0 is ready*/
+	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
+			HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
 	schedule_work(&it6505->hdcp_wait_ksv_list);
 }
 
diff --git a/drivers/gpu/drm/display/drm_dp_cec.c b/drivers/gpu/drm/display/drm_dp_cec.c
index ae39dc794190..868bf53db66c 100644
--- a/drivers/gpu/drm/display/drm_dp_cec.c
+++ b/drivers/gpu/drm/display/drm_dp_cec.c
@@ -310,16 +310,6 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
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
@@ -336,7 +326,9 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 		num_las = CEC_MAX_LOG_ADDRS;
 
 	if (aux->cec.adap) {
-		if (aux->cec.adap->capabilities == cec_caps &&
+		/* Check if the adapter properties have changed */
+		if ((aux->cec.adap->capabilities & CEC_CAP_MONITOR_ALL) ==
+		    (cec_caps & CEC_CAP_MONITOR_ALL) &&
 		    aux->cec.adap->available_log_addrs == num_las) {
 			/* Unchanged, so just set the phys addr */
 			cec_s_phys_addr_from_edid(aux->cec.adap, edid);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 442746d9777a..a0abfb3f05f0 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1495,14 +1495,14 @@ int drm_fb_helper_set_par(struct fb_info *info)
 }
 EXPORT_SYMBOL(drm_fb_helper_set_par);
 
-static void pan_set(struct drm_fb_helper *fb_helper, int x, int y)
+static void pan_set(struct drm_fb_helper *fb_helper, int dx, int dy)
 {
 	struct drm_mode_set *mode_set;
 
 	mutex_lock(&fb_helper->client.modeset_mutex);
 	drm_client_for_each_modeset(mode_set, &fb_helper->client) {
-		mode_set->x = x;
-		mode_set->y = y;
+		mode_set->x += dx;
+		mode_set->y += dy;
 	}
 	mutex_unlock(&fb_helper->client.modeset_mutex);
 }
@@ -1511,16 +1511,18 @@ static int pan_display_atomic(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
-	int ret;
+	int ret, dx, dy;
 
-	pan_set(fb_helper, var->xoffset, var->yoffset);
+	dx = var->xoffset - info->var.xoffset;
+	dy = var->yoffset - info->var.yoffset;
+	pan_set(fb_helper, dx, dy);
 
 	ret = drm_client_modeset_commit_locked(&fb_helper->client);
 	if (!ret) {
 		info->var.xoffset = var->xoffset;
 		info->var.yoffset = var->yoffset;
 	} else
-		pan_set(fb_helper, info->var.xoffset, info->var.yoffset);
+		pan_set(fb_helper, -dx, -dy);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 23d5058eca8d..740680205e8d 100644
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
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index bc523a3d1d42..00daeacc2f13 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -100,8 +100,6 @@ static const u32 icl_sdr_y_plane_formats[] = {
 	DRM_FORMAT_Y216,
 	DRM_FORMAT_XYUV8888,
 	DRM_FORMAT_XVYU2101010,
-	DRM_FORMAT_XVYU12_16161616,
-	DRM_FORMAT_XVYU16161616,
 };
 
 static const u32 icl_sdr_uv_plane_formats[] = {
@@ -128,8 +126,6 @@ static const u32 icl_sdr_uv_plane_formats[] = {
 	DRM_FORMAT_Y216,
 	DRM_FORMAT_XYUV8888,
 	DRM_FORMAT_XVYU2101010,
-	DRM_FORMAT_XVYU12_16161616,
-	DRM_FORMAT_XVYU16161616,
 };
 
 static const u32 icl_hdr_plane_formats[] = {
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 2e0eb6cb8eab..4047b01060d8 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -4764,12 +4764,20 @@ static inline void guc_log_context(struct drm_printer *p,
 {
 	drm_printf(p, "GuC lrc descriptor %u:\n", ce->guc_id.id);
 	drm_printf(p, "\tHW Context Desc: 0x%08x\n", ce->lrc.lrca);
-	drm_printf(p, "\t\tLRC Head: Internal %u, Memory %u\n",
-		   ce->ring->head,
-		   ce->lrc_reg_state[CTX_RING_HEAD]);
-	drm_printf(p, "\t\tLRC Tail: Internal %u, Memory %u\n",
-		   ce->ring->tail,
-		   ce->lrc_reg_state[CTX_RING_TAIL]);
+	if (intel_context_pin_if_active(ce)) {
+		drm_printf(p, "\t\tLRC Head: Internal %u, Memory %u\n",
+			   ce->ring->head,
+			   ce->lrc_reg_state[CTX_RING_HEAD]);
+		drm_printf(p, "\t\tLRC Tail: Internal %u, Memory %u\n",
+			   ce->ring->tail,
+			   ce->lrc_reg_state[CTX_RING_TAIL]);
+		intel_context_unpin(ce);
+	} else {
+		drm_printf(p, "\t\tLRC Head: Internal %u, Memory not pinned\n",
+			   ce->ring->head);
+		drm_printf(p, "\t\tLRC Tail: Internal %u, Memory not pinned\n",
+			   ce->ring->tail);
+	}
 	drm_printf(p, "\t\tContext Pin Count: %u\n",
 		   atomic_read(&ce->pin_count));
 	drm_printf(p, "\t\tGuC ID Ref Count: %u\n",
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index e050a2de5fd1..e25f76b46b0a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -164,7 +164,7 @@ static int igt_ppgtt_alloc(void *arg)
 		return PTR_ERR(ppgtt);
 
 	if (!ppgtt->vm.allocate_va_range)
-		goto err_ppgtt_cleanup;
+		goto ppgtt_vm_put;
 
 	/*
 	 * While we only allocate the page tables here and so we could
@@ -232,7 +232,7 @@ static int igt_ppgtt_alloc(void *arg)
 			goto retry;
 	}
 	i915_gem_ww_ctx_fini(&ww);
-
+ppgtt_vm_put:
 	i915_vm_put(&ppgtt->vm);
 	return err;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 1245c7aa49df..a2113d6a022b 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -410,10 +410,10 @@ static void dp_audio_safe_to_exit_level(struct dp_audio_private *audio)
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
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 0b33c3a1e6e3..6cfb2d968acb 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -948,9 +948,6 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->connector;
-	enum drm_connector_status old_status;
-
 	int ret;
 
 	mutex_lock(&dp->lock);
@@ -1012,11 +1009,7 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 out:
 	mutex_unlock(&dp->lock);
-
-	old_status = connector->status;
-	connector->status = connector->funcs->detect(connector, false);
-	if (old_status != connector->status)
-		drm_kms_helper_hotplug_event(dp->drm_dev);
+	drm_connector_helper_hpd_irq_event(&dp->connector);
 }
 
 static int cdn_dp_pd_event(struct notifier_block *nb,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 1641440837af..6298e3732887 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -31,6 +31,7 @@ struct rockchip_crtc_state {
 	int output_bpc;
 	int output_flags;
 	bool enable_afbc;
+	bool yuv_overlay;
 	u32 bus_format;
 	u32 bus_flags;
 	int color_space;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a6071464a543..955ef2caac89 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -463,6 +463,16 @@ static bool rockchip_vop2_mod_supported(struct drm_plane *plane, u32 format,
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
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
@@ -1395,8 +1405,18 @@ static void vop2_post_config(struct drm_crtc *crtc)
 	u32 top_margin = 100, bottom_margin = 100;
 	u16 hsize = hdisplay * (left_margin + right_margin) / 200;
 	u16 vsize = vdisplay * (top_margin + bottom_margin) / 200;
+	u16 hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
 	u16 hact_end, vact_end;
 	u32 val;
+	u32 bg_dly;
+	u32 pre_scan_dly;
+
+	bg_dly = vp->data->pre_scan_max_dly[3];
+	vop2_writel(vp->vop2, RK3568_VP_BG_MIX_CTRL(vp->id),
+		    FIELD_PREP(RK3568_VP_BG_MIX_CTRL__BG_DLY, bg_dly));
+
+	pre_scan_dly = ((bg_dly + (hdisplay >> 1) - 1) << 16) | hsync_len;
+	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
 
 	vsize = rounddown(vsize, 2);
 	hsize = rounddown(hsize, 2);
@@ -1556,6 +1576,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2->enable_count++;
 
+	vcstate->yuv_overlay = is_yuv_output(vcstate->bus_format);
+
 	vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
 
 	polflags = 0;
@@ -1583,7 +1605,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (vop2_output_uv_swap(vcstate->bus_format, vcstate->output_mode))
 		dsp_ctrl |= RK3568_VP_DSP_CTRL__DSP_RB_SWAP;
 
-	if (is_yuv_output(vcstate->bus_format))
+	if (vcstate->yuv_overlay)
 		dsp_ctrl |= RK3568_VP_DSP_CTRL__POST_DSP_OUT_R2Y;
 
 	vop2_dither_setup(crtc, &dsp_ctrl);
@@ -1737,7 +1759,6 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2 *vop2, u8 port_id)
 
 static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_win)
 {
-	u32 offset = (main_win->data->phys_id * 0x10);
 	struct vop2_alpha_config alpha_config;
 	struct vop2_alpha alpha;
 	struct drm_plane_state *bottom_win_pstate;
@@ -1745,6 +1766,7 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	u16 src_glb_alpha_val, dst_glb_alpha_val;
 	bool premulti_en = false;
 	bool swap = false;
+	u32 offset = 0;
 
 	/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/top win */
 	bottom_win_pstate = main_win->base.state;
@@ -1763,6 +1785,22 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
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
@@ -1810,6 +1848,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
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
@@ -1886,29 +1930,26 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
-	unsigned int nlayer, ofs;
-	struct drm_display_mode *adjusted_mode;
-	u16 hsync_len;
-	u16 hdisplay;
-	u32 bg_dly;
-	u32 pre_scan_dly;
+	u8 layer_id;
+	u8 old_layer_id;
+	u8 layer_sel_id;
+	unsigned int ofs;
+	u32 ovl_ctrl;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
 	struct vop2_video_port *vp1 = &vop2->vps[1];
 	struct vop2_video_port *vp2 = &vop2->vps[2];
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
-	adjusted_mode = &vp->crtc.state->adjusted_mode;
-	hsync_len = adjusted_mode->crtc_hsync_end - adjusted_mode->crtc_hsync_start;
-	hdisplay = adjusted_mode->crtc_hdisplay;
-
-	bg_dly = vp->data->pre_scan_max_dly[3];
-	vop2_writel(vop2, RK3568_VP_BG_MIX_CTRL(vp->id),
-		    FIELD_PREP(RK3568_VP_BG_MIX_CTRL__BG_DLY, bg_dly));
+	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
+	ovl_ctrl |= RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
+	if (vcstate->yuv_overlay)
+		ovl_ctrl |= RK3568_OVL_CTRL__YUV_MODE(vp->id);
+	else
+		ovl_ctrl &= ~RK3568_OVL_CTRL__YUV_MODE(vp->id);
 
-	pre_scan_dly = ((bg_dly + (hdisplay >> 1) - 1) << 16) | hsync_len;
-	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
+	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
 
-	vop2_writel(vop2, RK3568_OVL_CTRL, 0);
 	port_sel = vop2_readl(vop2, RK3568_OVL_PORT_SEL);
 	port_sel &= RK3568_OVL_PORT_SEL__SEL_PORT;
 
@@ -1936,9 +1977,30 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
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
@@ -1967,22 +2029,18 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
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
 	vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
-	vop2_writel(vop2, RK3568_OVL_CTRL, RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD);
 }
 
 static void vop2_setup_dly_for_windows(struct vop2 *vop2)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index f1234a151130..18f0573b2000 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -418,6 +418,7 @@ enum dst_factor_mode {
 #define VOP2_COLOR_KEY_MASK				BIT(31)
 
 #define RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD		BIT(28)
+#define RK3568_OVL_CTRL__YUV_MODE(vp)			BIT(vp)
 
 #define RK3568_VP_BG_MIX_CTRL__BG_DLY			GENMASK(31, 24)
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 95b75236fe5e..c986d432af50 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -599,7 +599,7 @@ void dispc_k2g_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 {
 	dispc_irq_t old_mask = dispc_k2g_read_irqenable(dispc);
 
-	/* clear the irqstatus for newly enabled irqs */
+	/* clear the irqstatus for irqs that will be enabled */
 	dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & mask);
 
 	dispc_k2g_vp_set_irqenable(dispc, 0, mask);
@@ -607,6 +607,9 @@ void dispc_k2g_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 
 	dispc_write(dispc, DISPC_IRQENABLE_SET, (1 << 0) | (1 << 7));
 
+	/* clear the irqstatus for irqs that were disabled */
+	dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & old_mask);
+
 	/* flush posted write */
 	dispc_k2g_read_irqenable(dispc);
 }
@@ -679,24 +682,20 @@ static
 void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t clearmask)
 {
 	unsigned int i;
-	u32 top_clear = 0;
 
 	for (i = 0; i < dispc->feat->num_vps; ++i) {
-		if (clearmask & DSS_IRQ_VP_MASK(i)) {
+		if (clearmask & DSS_IRQ_VP_MASK(i))
 			dispc_k3_vp_write_irqstatus(dispc, i, clearmask);
-			top_clear |= BIT(i);
-		}
 	}
 	for (i = 0; i < dispc->feat->num_planes; ++i) {
-		if (clearmask & DSS_IRQ_PLANE_MASK(i)) {
+		if (clearmask & DSS_IRQ_PLANE_MASK(i))
 			dispc_k3_vid_write_irqstatus(dispc, i, clearmask);
-			top_clear |= BIT(4 + i);
-		}
 	}
 	if (dispc->feat->subrev == DISPC_K2G)
 		return;
 
-	dispc_write(dispc, DISPC_IRQSTATUS, top_clear);
+	/* always clear the top level irqstatus */
+	dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQSTATUS));
 
 	/* Flush posted writes */
 	dispc_read(dispc, DISPC_IRQSTATUS);
@@ -742,7 +741,7 @@ static void dispc_k3_set_irqenable(struct dispc_device *dispc,
 
 	old_mask = dispc_k3_read_irqenable(dispc);
 
-	/* clear the irqstatus for newly enabled irqs */
+	/* clear the irqstatus for irqs that will be enabled */
 	dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & mask);
 
 	for (i = 0; i < dispc->feat->num_vps; ++i) {
@@ -767,6 +766,9 @@ static void dispc_k3_set_irqenable(struct dispc_device *dispc,
 	if (main_disable)
 		dispc_write(dispc, DISPC_IRQENABLE_CLR, main_disable);
 
+	/* clear the irqstatus for irqs that were disabled */
+	dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & old_mask);
+
 	/* Flush posted writes */
 	dispc_read(dispc, DISPC_IRQENABLE_SET);
 }
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 101332775b6a..ec99d644cbb0 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -175,6 +175,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct drm_v3d_perfmon_destroy *req = data;
+	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct v3d_perfmon *perfmon;
 
 	mutex_lock(&v3d_priv->perfmon.lock);
@@ -184,6 +185,10 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == v3d->active_perfmon)
+		v3d_perfmon_stop(v3d, perfmon, false);
+
 	v3d_perfmon_put(perfmon);
 
 	return 0;
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9b98470593b0..20a418f64533 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -190,6 +190,13 @@ struct virtio_gpu_framebuffer {
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
 
+struct virtio_gpu_plane_state {
+	struct drm_plane_state base;
+	struct virtio_gpu_fence *fence;
+};
+#define to_virtio_gpu_plane_state(x) \
+	container_of(x, struct virtio_gpu_plane_state, base)
+
 struct virtio_gpu_queue {
 	struct virtqueue *vq;
 	spinlock_t qlock;
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 4c09e313bebc..0c073ba4974f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -66,11 +66,28 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	return format;
 }
 
+static struct
+drm_plane_state *virtio_gpu_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct virtio_gpu_plane_state *new;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
+
+	return &new->base;
+}
+
 static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_duplicate_state = virtio_gpu_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
@@ -128,11 +145,13 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo;
 
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	vgplane_st = to_virtio_gpu_plane_state(plane->state);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-	if (vgfb->fence) {
+	if (vgplane_st->fence) {
 		struct virtio_gpu_object_array *objs;
 
 		objs = virtio_gpu_array_alloc(1);
@@ -141,13 +160,11 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 		virtio_gpu_array_lock_resv(objs);
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
-					      width, height, objs, vgfb->fence);
+					      width, height, objs,
+					      vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
-
-		dma_fence_wait_timeout(&vgfb->fence->f, true,
+		dma_fence_wait_timeout(&vgplane_st->fence->f, true,
 				       msecs_to_jiffies(50));
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
 	} else {
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, NULL, NULL);
@@ -237,20 +254,23 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo;
 
 	if (!new_state->fb)
 		return 0;
 
 	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
+	vgplane_st = to_virtio_gpu_plane_state(new_state);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 	if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob))
 		return 0;
 
-	if (bo->dumb && (plane->state->fb != new_state->fb)) {
-		vgfb->fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
+	if (bo->dumb) {
+		vgplane_st->fence = virtio_gpu_fence_alloc(vgdev,
+						     vgdev->fence_drv.context,
 						     0);
-		if (!vgfb->fence)
+		if (!vgplane_st->fence)
 			return -ENOMEM;
 	}
 
@@ -260,15 +280,15 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 					struct drm_plane_state *state)
 {
-	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 
 	if (!state->fb)
 		return;
 
-	vgfb = to_virtio_gpu_framebuffer(state->fb);
-	if (vgfb->fence) {
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
+	vgplane_st = to_virtio_gpu_plane_state(state);
+	if (vgplane_st->fence) {
+		dma_fence_put(&vgplane_st->fence->f);
+		vgplane_st->fence = NULL;
 	}
 }
 
@@ -281,6 +301,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo = NULL;
 	uint32_t handle;
 
@@ -293,6 +314,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 
 	if (plane->state->fb) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+		vgplane_st = to_virtio_gpu_plane_state(plane->state);
 		bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 		handle = bo->hw_res_handle;
 	} else {
@@ -312,11 +334,9 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, 0,
 			 plane->state->crtc_w,
 			 plane->state->crtc_h,
-			 0, 0, objs, vgfb->fence);
+			 0, 0, objs, vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
-		dma_fence_wait(&vgfb->fence->f, true);
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
+		dma_fence_wait(&vgplane_st->fence->f, true);
 	}
 
 	if (plane->state->fb != old_state->fb) {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b5887658c6af..7790e464e2c6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1129,6 +1129,8 @@ static void hid_apply_multiplier(struct hid_device *hid,
 	while (multiplier_collection->parent_idx != -1 &&
 	       multiplier_collection->type != HID_COLLECTION_LOGICAL)
 		multiplier_collection = &hid->collection[multiplier_collection->parent_idx];
+	if (multiplier_collection->type != HID_COLLECTION_LOGICAL)
+		multiplier_collection = NULL;
 
 	effective_multiplier = hid_calculate_multiplier(hid, multiplier);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e62104e1a603..6386043aab0b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1668,9 +1668,12 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
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
@@ -2072,7 +2075,7 @@ static const struct hid_device_id mt_devices[] = {
 		     I2C_DEVICE_ID_GOODIX_01E8) },
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-		     I2C_DEVICE_ID_GOODIX_01E8) },
+		     I2C_DEVICE_ID_GOODIX_01E9) },
 
 	/* GoodTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6abd3e2a9094..3eeac7011739 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -728,23 +728,30 @@ static int sensor_hub_probe(struct hid_device *hdev,
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
diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index cf1679b0d4fb..3b81468a1df2 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -170,6 +170,14 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 	ep = &usbif->cur_altsetting->endpoint[1];
 	b_ep = ep->desc.bEndpointAddress;
 
+	/* Are the expected endpoints present? */
+	u8 ep_addr[2] = {b_ep, 0};
+
+	if (!usb_check_int_endpoints(usbif, ep_addr)) {
+		hid_err(hdev, "Unexpected non-int endpoint\n");
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(setup_arr); ++i) {
 		memcpy(send_buf, setup_arr[i], setup_arr_sizes[i]);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 3551a6d3795e..ce54b8354a7d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4914,6 +4914,10 @@ static const struct wacom_features wacom_features_0x94 =
 	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
 	.driver_data = (kernel_ulong_t)&wacom_features_##prod
 
+#define PCI_DEVICE_WACOM(prod)						\
+	HID_DEVICE(BUS_PCI, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
+	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+
 #define USB_DEVICE_LENOVO(prod)					\
 	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
 	.driver_data = (kernel_ulong_t)&wacom_features_##prod
@@ -5083,6 +5087,7 @@ const struct hid_device_id wacom_ids[] = {
 
 	{ USB_DEVICE_WACOM(HID_ANY_ID) },
 	{ I2C_DEVICE_WACOM(HID_ANY_ID) },
+	{ PCI_DEVICE_WACOM(HID_ANY_ID) },
 	{ BT_DEVICE_WACOM(HID_ANY_ID) },
 	{ }
 };
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 14ae0cfc325e..d2499f302b50 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -355,6 +355,25 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
 	{}
 };
 
+static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
+	/*
+	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
+	 * excessive smoothing (similar to when the touchpad's firmware detects
+	 * a noisy signal) is sometimes applied. As some devices' (e.g, Lenovo
+	 * V15 G4) ACPI tables specify a 400KHz frequency for this device and
+	 * some I2C busses (e.g, Designware I2C) default to a 400KHz freq,
+	 * force the speed to 100KHz as a workaround.
+	 *
+	 * For future investigation: This problem may be related to the default
+	 * HCNT/LCNT values given by some busses' drivers, because they are not
+	 * specified in the aforementioned devices' ACPI tables, and because
+	 * the device works without issues on Windows at what is expected to be
+	 * a 400KHz frequency. The root cause of the issue is not known.
+	 */
+	{ "ELAN06FA", 0 },
+	{}
+};
+
 static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 					   void *data, void **return_value)
 {
@@ -373,6 +392,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
 		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
 
+	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
+		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
+
 	return AE_OK;
 }
 
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index bbefac0dbf36..7bb005de974e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1861,7 +1861,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 
 	if (master->ops->set_speed) {
-		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
+		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
 		if (ret)
 			goto err_bus_cleanup;
 	}
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 35b90bb686ad..c5a37f58079a 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1667,6 +1667,7 @@ static int cdns_i3c_master_remove(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	clk_disable_unprepare(master->sysclk);
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 2307fc531752..895b0c9c6d1d 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -154,6 +154,12 @@ struct as73211_data {
 	BIT(AS73211_SCAN_INDEX_TEMP) | \
 	AS73211_SCAN_MASK_COLOR)
 
+static const unsigned long as73211_scan_masks[] = {
+	AS73211_SCAN_MASK_COLOR,
+	AS73211_SCAN_MASK_ALL,
+	0
+};
+
 static const struct iio_chan_spec as73211_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -602,9 +608,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 
 		/* AS73211 starts reading at address 2 */
 		ret = i2c_master_recv(data->client,
-				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
+				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
 		if (ret < 0)
 			goto done;
+
+		/* Avoid pushing uninitialized data */
+		scan.chan[3] = 0;
 	}
 
 	if (data_result) {
@@ -612,9 +621,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 		 * Saturate all channels (in case of overflows). Temperature channel
 		 * is not affected by overflows.
 		 */
-		scan.chan[1] = cpu_to_le16(U16_MAX);
-		scan.chan[2] = cpu_to_le16(U16_MAX);
-		scan.chan[3] = cpu_to_le16(U16_MAX);
+		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+			scan.chan[3] = cpu_to_le16(U16_MAX);
+		} else {
+			scan.chan[0] = cpu_to_le16(U16_MAX);
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+		}
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
@@ -684,6 +699,7 @@ static int as73211_probe(struct i2c_client *client)
 	indio_dev->channels = as73211_channels;
 	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = as73211_scan_masks;
 
 	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
 	if (ret < 0)
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
 
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 15ee92081118..924940ca9de0 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -452,7 +452,6 @@ static void efa_ib_device_remove(struct efa_dev *dev)
 	ibdev_info(&dev->ibdev, "Unregister ib device\n");
 	ib_unregister_device(&dev->ibdev);
 	efa_destroy_eqs(dev);
-	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_NORMAL);
 	efa_release_doorbell_bar(dev);
 }
 
@@ -623,12 +622,14 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	return ERR_PTR(err);
 }
 
-static void efa_remove_device(struct pci_dev *pdev)
+static void efa_remove_device(struct pci_dev *pdev,
+			      enum efa_regs_reset_reason_types reset_reason)
 {
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 	struct efa_com_dev *edev;
 
 	edev = &dev->edev;
+	efa_com_dev_reset(edev, reset_reason);
 	efa_com_admin_destroy(edev);
 	efa_free_irq(dev, &dev->admin_irq);
 	efa_disable_msix(dev);
@@ -656,7 +657,7 @@ static int efa_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_remove_device:
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_INIT_ERR);
 	return err;
 }
 
@@ -665,7 +666,7 @@ static void efa_remove(struct pci_dev *pdev)
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 
 	efa_ib_device_remove(dev);
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_NORMAL);
 }
 
 static struct pci_driver efa_pci_driver = {
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index ba47874f90d3..7c3dc86ab7f0 100644
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
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d3cada2ae5a5..87fbee806100 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -808,8 +808,7 @@ static bool mkey_is_eq(struct mlx5_ib_mkey *mmkey, u32 key)
 /*
  * Handle a single data segment in a page-fault WQE or RDMA region.
  *
- * Returns number of OS pages retrieved on success. The caller may continue to
- * the next data segment.
+ * Returns zero on success. The caller may continue to the next data segment.
  * Can return the following error codes:
  * -EAGAIN to designate a temporary error. The caller will abort handling the
  *  page fault and resolve it.
@@ -822,7 +821,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 					 u32 *bytes_committed,
 					 u32 *bytes_mapped)
 {
-	int npages = 0, ret, i, outlen, cur_outlen = 0, depth = 0;
+	int ret, i, outlen, cur_outlen = 0, depth = 0, pages_in_range;
 	struct pf_frame *head = NULL, *frame;
 	struct mlx5_ib_mkey *mmkey;
 	struct mlx5_ib_mr *mr;
@@ -865,13 +864,20 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
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
 
@@ -962,7 +968,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	kfree(out);
 
 	*bytes_committed = 0;
-	return ret ? ret : npages;
+	return ret;
 }
 
 /*
@@ -981,8 +987,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
  *                   the committed bytes).
  * @receive_queue: receive WQE end of sg list
  *
- * Returns the number of pages loaded if positive, zero for an empty WQE, or a
- * negative error code.
+ * Returns zero for success or a negative error code.
  */
 static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 				   struct mlx5_pagefault *pfault,
@@ -990,7 +995,7 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 				   void *wqe_end, u32 *bytes_mapped,
 				   u32 *total_wqe_bytes, bool receive_queue)
 {
-	int ret = 0, npages = 0;
+	int ret = 0;
 	u64 io_virt;
 	u32 key;
 	u32 byte_count;
@@ -1046,10 +1051,9 @@ static int pagefault_data_segments(struct mlx5_ib_dev *dev,
 						    bytes_mapped);
 		if (ret < 0)
 			break;
-		npages += ret;
 	}
 
-	return ret < 0 ? ret : npages;
+	return ret;
 }
 
 /*
@@ -1285,12 +1289,6 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
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
@@ -1329,7 +1327,7 @@ static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,
 	if (ret == -EAGAIN) {
 		/* We're racing with an invalidation, don't prefetch */
 		prefetch_activated = 0;
-	} else if (ret < 0 || pages_in_range(address, length) > ret) {
+	} else if (ret < 0) {
 		mlx5_ib_page_fault_resume(dev, pfault, 1);
 		if (ret != -ENOENT)
 			mlx5_ib_dbg(dev, "PAGE FAULT error %d. QP 0x%x, type: 0x%x\n",
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 1151c0b5ccea..02cf5e851eb0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -221,7 +221,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 {
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
-	static int timeout = RXE_POOL_TIMEOUT;
 	int ret, err = 0;
 	void *xa_ret;
 
@@ -245,19 +244,19 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
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
@@ -269,7 +268,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 			mdelay(1);
 
 		if (WARN_ON(!completion_done(&elem->complete)))
-			err = -EINVAL;
+			err = -ETIMEDOUT;
 	}
 
 	if (pool->cleanup)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index c4dcef76e964..8df23ab974c1 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3983,7 +3983,6 @@ static struct srp_host *srp_add_port(struct srp_device *device, u32 port)
 	return host;
 
 put_host:
-	device_del(&host->dev);
 	put_device(&host->dev);
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 45b43f729f89..96b72f3dad0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3880,7 +3880,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-		return ret;
+		goto err_free_iopf;
 
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
@@ -3891,22 +3891,29 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu, bypass);
 	if (ret)
-		return ret;
+		goto err_disable;
 
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
-		return ret;
+		goto err_disable;
 
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ret;
+		goto err_free_sysfs;
 	}
 
 	return 0;
+
+err_free_sysfs:
+	iommu_device_sysfs_remove(&smmu->iommu);
+err_disable:
+	arm_smmu_device_disable(smmu);
+err_free_iopf:
+	iopf_queue_free(smmu->evtq.iopf);
+	return ret;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..ba1e4a90ab5f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -555,7 +555,8 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
 
-	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
+			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
 		int irq;
 		if (cpumask_test_cpu(smp_processor_id(),
 				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))
diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index e2b36d3187eb..b7da47333cd8 100644
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
diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d..6692de0af68f 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -440,6 +440,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	}
 	gpio_ext_pdev = of_find_device_by_node(gpio_ext_np);
 	if (!gpio_ext_pdev) {
+		of_node_put(gpio_ext_np);
 		dev_err(dev, "Failed to find platform device for gpio-ext\n");
 		return -ENODEV;
 	}
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 573481e436f5..e12cd1a62155 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -388,7 +388,6 @@ static void tegra_hsp_sm_recv32(struct tegra_hsp_channel *channel)
 	value = tegra_hsp_channel_readl(channel, HSP_SM_SHRD_MBOX);
 	value &= ~HSP_SM_SHRD_MBOX_FULL;
 	msg = (void *)(unsigned long)value;
-	mbox_chan_received_data(channel->chan, msg);
 
 	/*
 	 * Need to clear all bits here since some producers, such as TCU, depend
@@ -398,6 +397,8 @@ static void tegra_hsp_sm_recv32(struct tegra_hsp_channel *channel)
 	 * explicitly, so we have to make sure we cover all possible cases.
 	 */
 	tegra_hsp_channel_writel(channel, 0x0, HSP_SM_SHRD_MBOX);
+
+	mbox_chan_received_data(channel->chan, msg);
 }
 
 static const struct tegra_hsp_sm_ops tegra_hsp_sm_32bit_ops = {
@@ -433,7 +434,6 @@ static void tegra_hsp_sm_recv128(struct tegra_hsp_channel *channel)
 	value[3] = tegra_hsp_channel_readl(channel, HSP_SHRD_MBOX_TYPE1_DATA3);
 
 	msg = (void *)(unsigned long)value;
-	mbox_chan_received_data(channel->chan, msg);
 
 	/*
 	 * Clear data registers and tag.
@@ -443,6 +443,8 @@ static void tegra_hsp_sm_recv128(struct tegra_hsp_channel *channel)
 	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_DATA2);
 	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_DATA3);
 	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_TAG);
+
+	mbox_chan_received_data(channel->chan, msg);
 }
 
 static const struct tegra_hsp_sm_ops tegra_hsp_sm_128bit_ops = {
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 25e51dc6e559..57e662861c2e 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -56,6 +56,7 @@ struct convert_context {
 	struct bio *bio_out;
 	struct bvec_iter iter_out;
 	atomic_t cc_pending;
+	unsigned int tag_offset;
 	u64 cc_sector;
 	union {
 		struct skcipher_request *req;
@@ -1223,6 +1224,7 @@ static void crypt_convert_init(struct crypt_config *cc,
 	if (bio_out)
 		ctx->iter_out = bio_out->bi_iter;
 	ctx->cc_sector = sector + cc->iv_offset;
+	ctx->tag_offset = 0;
 	init_completion(&ctx->restart);
 }
 
@@ -1554,7 +1556,6 @@ static void crypt_free_req(struct crypt_config *cc, void *req, struct bio *base_
 static blk_status_t crypt_convert(struct crypt_config *cc,
 			 struct convert_context *ctx, bool atomic, bool reset_pending)
 {
-	unsigned int tag_offset = 0;
 	unsigned int sector_step = cc->sector_size >> SECTOR_SHIFT;
 	int r;
 
@@ -1577,9 +1578,9 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 		atomic_inc(&ctx->cc_pending);
 
 		if (crypt_integrity_aead(cc))
-			r = crypt_convert_block_aead(cc, ctx, ctx->r.req_aead, tag_offset);
+			r = crypt_convert_block_aead(cc, ctx, ctx->r.req_aead, ctx->tag_offset);
 		else
-			r = crypt_convert_block_skcipher(cc, ctx, ctx->r.req, tag_offset);
+			r = crypt_convert_block_skcipher(cc, ctx, ctx->r.req, ctx->tag_offset);
 
 		switch (r) {
 		/*
@@ -1599,8 +1600,8 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 					 * exit and continue processing in a workqueue
 					 */
 					ctx->r.req = NULL;
+					ctx->tag_offset++;
 					ctx->cc_sector += sector_step;
-					tag_offset++;
 					return BLK_STS_DEV_RESOURCE;
 				}
 			} else {
@@ -1614,8 +1615,8 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 		 */
 		case -EINPROGRESS:
 			ctx->r.req = NULL;
+			ctx->tag_offset++;
 			ctx->cc_sector += sector_step;
-			tag_offset++;
 			continue;
 		/*
 		 * The request was already processed (synchronously).
@@ -1623,7 +1624,7 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 		case 0:
 			atomic_dec(&ctx->cc_pending);
 			ctx->cc_sector += sector_step;
-			tag_offset++;
+			ctx->tag_offset++;
 			if (!atomic)
 				cond_resched();
 			continue;
@@ -2029,7 +2030,6 @@ static void kcryptd_crypt_write_continue(struct work_struct *work)
 	struct crypt_config *cc = io->cc;
 	struct convert_context *ctx = &io->ctx;
 	int crypt_finished;
-	sector_t sector = io->sector;
 	blk_status_t r;
 
 	wait_for_completion(&ctx->restart);
@@ -2046,10 +2046,8 @@ static void kcryptd_crypt_write_continue(struct work_struct *work)
 	}
 
 	/* Encryption was already finished, submit io now */
-	if (crypt_finished) {
+	if (crypt_finished)
 		kcryptd_crypt_write_io_submit(io, 0);
-		io->sector = sector;
-	}
 
 	crypt_dec_pending(io);
 }
@@ -2060,14 +2058,13 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	struct convert_context *ctx = &io->ctx;
 	struct bio *clone;
 	int crypt_finished;
-	sector_t sector = io->sector;
 	blk_status_t r;
 
 	/*
 	 * Prevent io from disappearing until this function completes.
 	 */
 	crypt_inc_pending(io);
-	crypt_convert_init(cc, ctx, NULL, io->base_bio, sector);
+	crypt_convert_init(cc, ctx, NULL, io->base_bio, io->sector);
 
 	clone = crypt_alloc_buffer(io, io->base_bio->bi_iter.bi_size);
 	if (unlikely(!clone)) {
@@ -2084,8 +2081,6 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 		io->ctx.iter_in = clone->bi_iter;
 	}
 
-	sector += bio_sectors(clone);
-
 	crypt_inc_pending(io);
 	r = crypt_convert(cc, ctx,
 			  test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags), true);
@@ -2109,10 +2104,8 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	}
 
 	/* Encryption was already finished, submit io now */
-	if (crypt_finished) {
+	if (crypt_finished)
 		kcryptd_crypt_write_io_submit(io, 0);
-		io->sector = sector;
-	}
 
 dec:
 	crypt_dec_pending(io);
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index e9d1eef40c62..798da5042136 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -311,12 +311,8 @@ static int cxd2841er_set_reg_bits(struct cxd2841er_priv *priv,
 
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
diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 5fdb922d24e0..eb9ad5a50d95 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3649,15 +3649,15 @@ static int ccs_probe(struct i2c_client *client)
 out_cleanup:
 	ccs_cleanup(sensor);
 
+out_free_ccs_limits:
+	kfree(sensor->ccs_limits);
+
 out_release_mdata:
 	kvfree(sensor->mdata.backing);
 
 out_release_sdata:
 	kvfree(sensor->sdata.backing);
 
-out_free_ccs_limits:
-	kfree(sensor->ccs_limits);
-
 out_power_off:
 	ccs_power_off(&client->dev);
 	mutex_destroy(&sensor->mutex);
diff --git a/drivers/media/i2c/ccs/ccs-data.c b/drivers/media/i2c/ccs/ccs-data.c
index 08400edf77ce..2591dba51e17 100644
--- a/drivers/media/i2c/ccs/ccs-data.c
+++ b/drivers/media/i2c/ccs/ccs-data.c
@@ -10,6 +10,7 @@
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include "ccs-data-defs.h"
 
@@ -97,7 +98,7 @@ ccs_data_parse_length_specifier(const struct __ccs_data_length_specifier *__len,
 		plen = ((size_t)
 			(__len3->length[0] &
 			 ((1 << CCS_DATA_LENGTH_SPECIFIER_SIZE_SHIFT) - 1))
-			<< 16) + (__len3->length[0] << 8) + __len3->length[1];
+			<< 16) + (__len3->length[1] << 8) + __len3->length[2];
 		break;
 	}
 	default:
@@ -948,15 +949,15 @@ int ccs_data_parse(struct ccs_data_container *ccsdata, const void *data,
 
 	rval = __ccs_data_parse(&bin, ccsdata, data, len, dev, verbose);
 	if (rval)
-		return rval;
+		goto out_cleanup;
 
 	rval = bin_backing_alloc(&bin);
 	if (rval)
-		return rval;
+		goto out_cleanup;
 
 	rval = __ccs_data_parse(&bin, ccsdata, data, len, dev, false);
 	if (rval)
-		goto out_free;
+		goto out_cleanup;
 
 	if (verbose && ccsdata->version)
 		print_ccs_data_version(dev, ccsdata->version);
@@ -965,15 +966,16 @@ int ccs_data_parse(struct ccs_data_container *ccsdata, const void *data,
 		rval = -EPROTO;
 		dev_dbg(dev, "parsing mismatch; base %p; now %p; end %p\n",
 			bin.base, bin.now, bin.end);
-		goto out_free;
+		goto out_cleanup;
 	}
 
 	ccsdata->backing = bin.base;
 
 	return 0;
 
-out_free:
+out_cleanup:
 	kvfree(bin.base);
+	memset(ccsdata, 0, sizeof(*ccsdata));
 
 	return rval;
 }
diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index 77fa6253ba3e..ab543bb8a621 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -549,7 +549,7 @@ static int imx412_update_exp_gain(struct imx412 *imx412, u32 exposure, u32 gain)
 
 	lpfr = imx412->vblank + imx412->cur_mode->height;
 
-	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u",
+	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u\n",
 		exposure, gain, lpfr);
 
 	ret = imx412_write_reg(imx412, IMX412_REG_HOLD, 1, 1);
@@ -596,7 +596,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_VBLANK:
 		imx412->vblank = imx412->vblank_ctrl->val;
 
-		dev_dbg(imx412->dev, "Received vblank %u, new lpfr %u",
+		dev_dbg(imx412->dev, "Received vblank %u, new lpfr %u\n",
 			imx412->vblank,
 			imx412->vblank + imx412->cur_mode->height);
 
@@ -615,7 +615,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
 		exposure = ctrl->val;
 		analog_gain = imx412->again_ctrl->val;
 
-		dev_dbg(imx412->dev, "Received exp %u, analog gain %u",
+		dev_dbg(imx412->dev, "Received exp %u, analog gain %u\n",
 			exposure, analog_gain);
 
 		ret = imx412_update_exp_gain(imx412, exposure, analog_gain);
@@ -624,7 +624,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		break;
 	default:
-		dev_err(imx412->dev, "Invalid control %d", ctrl->id);
+		dev_err(imx412->dev, "Invalid control %d\n", ctrl->id);
 		ret = -EINVAL;
 	}
 
@@ -805,14 +805,14 @@ static int imx412_start_streaming(struct imx412 *imx412)
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
 
@@ -823,7 +823,7 @@ static int imx412_start_streaming(struct imx412 *imx412)
 	ret = imx412_write_reg(imx412, IMX412_REG_MODE_SELECT,
 			       1, IMX412_MODE_STREAMING);
 	if (ret) {
-		dev_err(imx412->dev, "fail to start streaming");
+		dev_err(imx412->dev, "fail to start streaming\n");
 		return ret;
 	}
 
@@ -904,7 +904,7 @@ static int imx412_detect(struct imx412 *imx412)
 		return ret;
 
 	if (val != IMX412_ID) {
-		dev_err(imx412->dev, "chip id mismatch: %x!=%x",
+		dev_err(imx412->dev, "chip id mismatch: %x!=%x\n",
 			IMX412_ID, val);
 		return -ENXIO;
 	}
@@ -936,7 +936,7 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
 	imx412->reset_gpio = devm_gpiod_get_optional(imx412->dev, "reset",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(imx412->reset_gpio)) {
-		dev_err(imx412->dev, "failed to get reset gpio %ld",
+		dev_err(imx412->dev, "failed to get reset gpio %ld\n",
 			PTR_ERR(imx412->reset_gpio));
 		return PTR_ERR(imx412->reset_gpio);
 	}
@@ -944,13 +944,13 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
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
 
@@ -975,14 +975,14 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
 
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
@@ -1040,7 +1040,7 @@ static int imx412_power_on(struct device *dev)
 
 	ret = clk_prepare_enable(imx412->inclk);
 	if (ret) {
-		dev_err(imx412->dev, "fail to enable inclk");
+		dev_err(imx412->dev, "fail to enable inclk\n");
 		goto error_reset;
 	}
 
@@ -1151,7 +1151,7 @@ static int imx412_init_controls(struct imx412 *imx412)
 		imx412->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	if (ctrl_hdlr->error) {
-		dev_err(imx412->dev, "control init failed: %d",
+		dev_err(imx412->dev, "control init failed: %d\n",
 			ctrl_hdlr->error);
 		v4l2_ctrl_handler_free(ctrl_hdlr);
 		return ctrl_hdlr->error;
@@ -1184,7 +1184,7 @@ static int imx412_probe(struct i2c_client *client)
 
 	ret = imx412_parse_hw_config(imx412);
 	if (ret) {
-		dev_err(imx412->dev, "HW configuration is not supported");
+		dev_err(imx412->dev, "HW configuration is not supported\n");
 		return ret;
 	}
 
@@ -1192,14 +1192,14 @@ static int imx412_probe(struct i2c_client *client)
 
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
 
@@ -1209,7 +1209,7 @@ static int imx412_probe(struct i2c_client *client)
 
 	ret = imx412_init_controls(imx412);
 	if (ret) {
-		dev_err(imx412->dev, "failed to init controls: %d", ret);
+		dev_err(imx412->dev, "failed to init controls: %d\n", ret);
 		goto error_power_off;
 	}
 
@@ -1221,14 +1221,14 @@ static int imx412_probe(struct i2c_client *client)
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
 
diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index e0019668a8f8..ea4e02ead57a 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1971,6 +1971,7 @@ static int ov5640_get_light_freq(struct ov5640_dev *sensor)
 			light_freq = 50;
 		} else {
 			/* 60Hz */
+			light_freq = 60;
 		}
 	}
 
diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index df144a2f6eda..0ba4edd24d64 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -31,7 +31,7 @@
 /* Exposure control */
 #define OV9282_REG_EXPOSURE	0x3500
 #define OV9282_EXPOSURE_MIN	1
-#define OV9282_EXPOSURE_OFFSET	12
+#define OV9282_EXPOSURE_OFFSET	25
 #define OV9282_EXPOSURE_STEP	1
 #define OV9282_EXPOSURE_DEFAULT	0x0282
 
diff --git a/drivers/media/platform/marvell/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
index ad4a7922d0d7..22d1d11cd195 100644
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
index 26e010f85184..f2ecd3322d1e 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2097,11 +2097,12 @@ static void mxc_jpeg_detach_pm_domains(struct mxc_jpeg_dev *jpeg)
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
diff --git a/drivers/media/platform/samsung/exynos4-is/mipi-csis.c b/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
index 6a0d35f33e8c..f308ef618986 100644
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
index 6e8ef86566b7..38c586b01b17 100644
--- a/drivers/media/platform/samsung/s3c-camif/camif-core.c
+++ b/drivers/media/platform/samsung/s3c-camif/camif-core.c
@@ -528,10 +528,19 @@ static int s3c_camif_remove(struct platform_device *pdev)
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
diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index dff7265a42ca..c1621680ec57 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -191,10 +191,11 @@ static int vidtv_start_streaming(struct vidtv_dvb *dvb)
 
 	mux_args.mux_buf_sz  = mux_buf_sz;
 
-	dvb->streaming = true;
 	dvb->mux = vidtv_mux_init(dvb->fe[0], dev, &mux_args);
 	if (!dvb->mux)
 		return -ENOMEM;
+
+	dvb->streaming = true;
 	vidtv_mux_start_thread(dvb->mux);
 
 	dev_dbg_ratelimited(dev, "Started streaming\n");
@@ -205,6 +206,11 @@ static int vidtv_stop_streaming(struct vidtv_dvb *dvb)
 {
 	struct device *dev = &dvb->pdev->dev;
 
+	if (!dvb->streaming) {
+		dev_warn_ratelimited(dev, "No streaming. Skipping.\n");
+		return 0;
+	}
+
 	dvb->streaming = false;
 	vidtv_mux_stop_thread(dvb->mux);
 	vidtv_mux_destroy(dvb->mux);
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
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index dffc9d03235c..1bad64f4499a 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1531,10 +1531,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;
@@ -1564,13 +1562,13 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
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
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 3da5ae475f39..c8e72079b427 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -754,27 +754,14 @@ static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
 static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 
-static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
-					       u16 id, unsigned int num_pads,
-					       unsigned int extra_size)
+static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
+		unsigned int num_pads, unsigned int extra_size)
 {
 	struct uvc_entity *entity;
 	unsigned int num_inputs;
 	unsigned int size;
 	unsigned int i;
 
-	/* Per UVC 1.1+ spec 3.7.2, the ID should be non-zero. */
-	if (id == 0) {
-		dev_err(&dev->udev->dev, "Found Unit with invalid ID 0.\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
-	if (uvc_entity_by_id(dev, id)) {
-		dev_err(&dev->udev->dev, "Found multiple Units with ID %u\n", id);
-		return ERR_PTR(-EINVAL);
-	}
-
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
 		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
@@ -784,7 +771,7 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
 	if (entity == NULL)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	entity->id = id;
 	entity->type = type;
@@ -875,10 +862,10 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 			break;
 		}
 
-		unit = uvc_alloc_new_entity(dev, UVC_VC_EXTENSION_UNIT,
-					    buffer[3], p + 1, 2 * n);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(UVC_VC_EXTENSION_UNIT, buffer[3],
+					p + 1, 2*n);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -988,10 +975,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		term = uvc_alloc_new_entity(dev, type | UVC_TERM_INPUT,
-					    buffer[3], 1, n + p);
-		if (IS_ERR(term))
-			return PTR_ERR(term);
+		term = uvc_alloc_entity(type | UVC_TERM_INPUT, buffer[3],
+					1, n + p);
+		if (term == NULL)
+			return -ENOMEM;
 
 		if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA) {
 			term->camera.bControlSize = n;
@@ -1048,10 +1035,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
-		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
-					    buffer[3], 1, 0);
-		if (IS_ERR(term))
-			return PTR_ERR(term);
+		term = uvc_alloc_entity(type | UVC_TERM_OUTPUT, buffer[3],
+					1, 0);
+		if (term == NULL)
+			return -ENOMEM;
 
 		memcpy(term->baSourceID, &buffer[7], 1);
 
@@ -1072,10 +1059,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
-					    p + 1, 0);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, 0);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->baSourceID, &buffer[5], p);
 
@@ -1097,9 +1083,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3], 2, n);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(buffer[2], buffer[3], 2, n);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->baSourceID, &buffer[4], 1);
 		unit->processing.wMaxMultiplier =
@@ -1128,10 +1114,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
-					    p + 1, n);
-		if (IS_ERR(unit))
-			return PTR_ERR(unit);
+		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, n);
+		if (unit == NULL)
+			return -ENOMEM;
 
 		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1275,10 +1260,9 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 		return irq;
 	}
 
-	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
-				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
-	if (IS_ERR(unit))
-		return PTR_ERR(unit);
+	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
+	if (!unit)
+		return -ENOMEM;
 
 	unit->gpio.gpio_privacy = gpio_privacy;
 	unit->gpio.irq = irq;
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
index 4a92c989cf33..d594acf9d8ce 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -267,6 +267,7 @@ int uvc_status_init(struct uvc_device *dev)
 	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (dev->int_urb == NULL) {
 		kfree(dev->status);
+		dev->status = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/media/v4l2-core/v4l2-mc.c b/drivers/media/v4l2-core/v4l2-mc.c
index b01474717dca..541c99c24923 100644
--- a/drivers/media/v4l2-core/v4l2-mc.c
+++ b/drivers/media/v4l2-core/v4l2-mc.c
@@ -321,7 +321,7 @@ int v4l2_create_fwnode_links_to_pad(struct v4l2_subdev *src_sd,
 
 	sink_sd = media_entity_to_v4l2_subdev(sink->entity);
 
-	fwnode_graph_for_each_endpoint(dev_fwnode(src_sd->dev), endpoint) {
+	fwnode_graph_for_each_endpoint(src_sd->fwnode, endpoint) {
 		struct fwnode_handle *remote_ep;
 		int src_idx, sink_idx, ret;
 		struct media_pad *src;
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index d1f01f80dcbd..a68e281b7896 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -477,14 +477,15 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 
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
 
@@ -521,7 +522,6 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 			}
 
 			if (cfg_mismatches) {
-				of_node_put(np);
 				continue;
 			}
 		}
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 7b1c597b6879..03367fcac42a 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -756,8 +756,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
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
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ecfe15122091..8302cd63a73d 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -8,12 +8,14 @@
  * Author: Dong Aisheng <dong.aisheng@linaro.org>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -25,7 +27,7 @@
 
 static struct platform_driver syscon_driver;
 
-static DEFINE_SPINLOCK(syscon_list_slock);
+static DEFINE_MUTEX(syscon_list_lock);
 static LIST_HEAD(syscon_list);
 
 struct syscon {
@@ -43,7 +45,6 @@ static const struct regmap_config syscon_regmap_config = {
 static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 {
 	struct clk *clk;
-	struct syscon *syscon;
 	struct regmap *regmap;
 	void __iomem *base;
 	u32 reg_io_width;
@@ -51,20 +52,18 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
 
-	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	WARN_ON(!mutex_is_locked(&syscon_list_lock));
+
+	struct syscon *syscon __free(kfree) = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_address_to_resource(np, 0, &res)) {
-		ret = -ENOMEM;
-		goto err_map;
-	}
+	if (of_address_to_resource(np, 0, &res))
+		return ERR_PTR(-ENOMEM);
 
 	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -ENOMEM;
-		goto err_map;
-	}
+	if (!base)
+		return ERR_PTR(-ENOMEM);
 
 	/* Parse the device's DT node for an endianness specification */
 	if (of_property_read_bool(np, "big-endian"))
@@ -135,11 +134,9 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon->regmap = regmap;
 	syscon->np = np;
 
-	spin_lock(&syscon_list_slock);
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
 
-	return syscon;
+	return_ptr(syscon);
 
 err_attach:
 	if (!IS_ERR(clk))
@@ -148,8 +145,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
-err_map:
-	kfree(syscon);
 	return ERR_PTR(ret);
 }
 
@@ -158,7 +153,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 {
 	struct syscon *entry, *syscon = NULL;
 
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -166,17 +161,65 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	spin_unlock(&syscon_list_slock);
-
 	if (!syscon)
 		syscon = of_syscon_register(np, check_clk);
 
+	mutex_unlock(&syscon_list_lock);
+
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
 
 	return syscon->regmap;
 }
 
+/**
+ * of_syscon_register_regmap() - Register regmap for specified device node
+ * @np: Device tree node
+ * @regmap: Pointer to regmap object
+ *
+ * Register an externally created regmap object with syscon for the specified
+ * device tree node. This regmap will then be returned to client drivers using
+ * the syscon_regmap_lookup_by_phandle() API.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
+{
+	struct syscon *entry, *syscon = NULL;
+	int ret;
+
+	if (!np || !regmap)
+		return -EINVAL;
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return -ENOMEM;
+
+	/* check if syscon entry already exists */
+	mutex_lock(&syscon_list_lock);
+
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->np == np) {
+			ret = -EEXIST;
+			goto err_unlock;
+		}
+
+	syscon->regmap = regmap;
+	syscon->np = np;
+
+	/* register the regmap in syscon list */
+	list_add_tail(&syscon->list, &syscon_list);
+	mutex_unlock(&syscon_list_lock);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&syscon_list_lock);
+	kfree(syscon);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_syscon_register_regmap);
+
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	return device_node_get_regmap(np, false);
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
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6c94364019c8..0722de355e6e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -934,7 +934,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			mmap_read_lock(current->mm);
 			vma = find_vma(current->mm, ctx->args[i].ptr);
 			if (vma)
-				pages[i].addr += ctx->args[i].ptr -
+				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;
 			mmap_read_unlock(current->mm);
 
@@ -961,8 +961,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 					(pkt_size - rlen);
 			pages[i].addr = pages[i].addr &	PAGE_MASK;
 
-			pg_start = (args & PAGE_MASK) >> PAGE_SHIFT;
-			pg_end = ((args + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
+			pg_start = (rpra[i].buf.pv & PAGE_MASK) >> PAGE_SHIFT;
+			pg_end = ((rpra[i].buf.pv + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
 			args = args + mlen;
 			rlen -= mlen;
@@ -2119,7 +2119,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
 		if (err)
-			goto fdev_error;
+			goto populate_error;
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5914516df2f7..cb87e8273779 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -458,6 +458,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 	if (mmc_card_sd_combo(card))
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
+	max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
+
 	return max_dtr;
 }
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6b1fc2e0ad9f..04f6b8037e59 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -262,6 +262,7 @@
 #define MSDC_PAD_TUNE_CMD_SEL	  BIT(21)   /* RW */
 
 #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
+#define PAD_DS_TUNE_DLY2_SEL      BIT(1)	  /* RW */
 #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  GENMASK(11, 7)  /* RW */
 #define PAD_DS_TUNE_DLY3	  GENMASK(16, 12) /* RW */
@@ -307,6 +308,7 @@
 
 /* EMMC50_PAD_DS_TUNE mask */
 #define PAD_DS_DLY_SEL		BIT(16)	/* RW */
+#define PAD_DS_DLY2_SEL		BIT(15)	/* RW */
 #define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
 #define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
 
@@ -2293,13 +2295,23 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+
 	host->hs400_mode = true;
 
-	if (host->top_base)
-		writel(host->hs400_ds_delay,
-		       host->top_base + EMMC50_PAD_DS_TUNE);
-	else
-		writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	if (host->top_base) {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay,
+			       host->top_base + EMMC50_PAD_DS_TUNE);
+	} else {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->base + PAD_DS_TUNE,
+				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	}
 	/* hs400 mode must set it to 0 */
 	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
 	/* to improve read performance, set outstanding to 2 */
@@ -2319,14 +2331,11 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
 	if (host->top_base) {
 		sdr_set_bits(host->top_base + EMMC50_PAD_DS_TUNE,
 			     PAD_DS_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
-				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->top_base + EMMC50_PAD_DS_TUNE,
+			     PAD_DS_DLY2_SEL);
 	} else {
 		sdr_set_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->base + PAD_DS_TUNE,
-				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY2_SEL);
 	}
 
 	host->hs400_tuning = true;
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 28bd562c439e..c8488b8e2073 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -132,9 +132,18 @@
 /* Timeout value to avoid infinite waiting for pwr_irq */
 #define MSM_PWR_IRQ_TIMEOUT_MS 5000
 
+/* Max load for eMMC Vdd supply */
+#define MMC_VMMC_MAX_LOAD_UA	570000
+
 /* Max load for eMMC Vdd-io supply */
 #define MMC_VQMMC_MAX_LOAD_UA	325000
 
+/* Max load for SD Vdd supply */
+#define SD_VMMC_MAX_LOAD_UA	800000
+
+/* Max load for SD Vdd-io supply */
+#define SD_VQMMC_MAX_LOAD_UA	22000
+
 #define msm_host_readl(msm_host, host, offset) \
 	msm_host->var_ops->msm_readl_relaxed(host, offset)
 
@@ -1399,11 +1408,48 @@ static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
 	return ret;
 }
 
-static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
+static void msm_config_vmmc_regulator(struct mmc_host *mmc, bool hpm)
+{
+	int load;
+
+	if (!hpm)
+		load = 0;
+	else if (!mmc->card)
+		load = max(MMC_VMMC_MAX_LOAD_UA, SD_VMMC_MAX_LOAD_UA);
+	else if (mmc_card_mmc(mmc->card))
+		load = MMC_VMMC_MAX_LOAD_UA;
+	else if (mmc_card_sd(mmc->card))
+		load = SD_VMMC_MAX_LOAD_UA;
+	else
+		return;
+
+	regulator_set_load(mmc->supply.vmmc, load);
+}
+
+static void msm_config_vqmmc_regulator(struct mmc_host *mmc, bool hpm)
+{
+	int load;
+
+	if (!hpm)
+		load = 0;
+	else if (!mmc->card)
+		load = max(MMC_VQMMC_MAX_LOAD_UA, SD_VQMMC_MAX_LOAD_UA);
+	else if (mmc_card_sd(mmc->card))
+		load = SD_VQMMC_MAX_LOAD_UA;
+	else
+		return;
+
+	regulator_set_load(mmc->supply.vqmmc, load);
+}
+
+static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
+			      struct mmc_host *mmc, bool hpm)
 {
 	if (IS_ERR(mmc->supply.vmmc))
 		return 0;
 
+	msm_config_vmmc_regulator(mmc, hpm);
+
 	return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
 }
 
@@ -1416,6 +1462,8 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
 	if (msm_host->vqmmc_enabled == level)
 		return 0;
 
+	msm_config_vqmmc_regulator(mmc, level);
+
 	if (level) {
 		/* Set the IO voltage regulator to default voltage level */
 		if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
@@ -1638,7 +1686,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	}
 
 	if (pwr_state) {
-		ret = sdhci_msm_set_vmmc(mmc);
+		ret = sdhci_msm_set_vmmc(msm_host, mmc,
+					 pwr_state & REQ_BUS_ON);
 		if (!ret)
 			ret = sdhci_msm_set_vqmmc(msm_host, mmc,
 					pwr_state & REQ_BUS_ON);
diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index a6161ce340d4..4b6cbee23fe8 100644
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
@@ -226,10 +230,12 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 disable_mux:
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
+put_node:
+	of_node_put(priv->hbdev.np);
 	return ret;
 }
 
-static int am654_hbmc_remove(struct platform_device *pdev)
+static void am654_hbmc_remove(struct platform_device *pdev)
 {
 	struct am654_hbmc_priv *priv = platform_get_drvdata(pdev);
 	struct am654_hbmc_device_priv *dev_priv = priv->hbdev.priv;
@@ -241,8 +247,7 @@ static int am654_hbmc_remove(struct platform_device *pdev)
 
 	if (dev_priv->rx_chan)
 		dma_release_channel(dev_priv->rx_chan);
-
-	return 0;
+	of_node_put(priv->hbdev.np);
 }
 
 static const struct of_device_id am654_hbmc_dt_ids[] = {
@@ -256,7 +261,7 @@ MODULE_DEVICE_TABLE(of, am654_hbmc_dt_ids);
 
 static struct platform_driver am654_hbmc_platform_driver = {
 	.probe = am654_hbmc_probe,
-	.remove = am654_hbmc_remove,
+	.remove_new = am654_hbmc_remove,
 	.driver = {
 		.name = "hbmc-am654",
 		.of_match_table = am654_hbmc_dt_ids,
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index f66385faf631..0dc2ea4fc857 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2923,6 +2923,7 @@ static int do_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = ONENAND_IS_4KB_PAGE(this) ?
 		onenand_mlc_read_ops_nolock(mtd, from, &ops) :
 		onenand_read_ops_nolock(mtd, from, &ops);
+	*retlen = ops.retlen;
 
 	/* Exit OTP access mode */
 	this->command(mtd, ONENAND_CMD_RESET, 0, 0);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 86e95e9d6533..c5d7093d5413 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -395,15 +395,16 @@ static int c_can_plat_probe(struct platform_device *pdev)
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
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 64c349fd4600..f65c1a1e05cc 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -867,10 +867,12 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			}
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
-			cf->can_id |= CAN_ERR_CNT;
-			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
-			cf->data[6] = bec.txerr;
-			cf->data[7] = bec.rxerr;
+			if (skb) {
+				cf->can_id |= CAN_ERR_CNT;
+				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+				cf->data[6] = bec.txerr;
+				cf->data[7] = bec.rxerr;
+			}
 			break;
 		default:
 			netdev_warn(ndev, "unhandled error state (%d:%s)!\n",
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 06508eebb585..a467c8f91020 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1436,7 +1436,9 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
 	aq_ptp_ring_free(self);
 	aq_ptp_free(self);
 
-	if (likely(self->aq_fw_ops->deinit) && link_down) {
+	/* May be invoked during hot unplug. */
+	if (pci_device_is_present(self->pdev) &&
+	    likely(self->aq_fw_ops->deinit) && link_down) {
 		mutex_lock(&self->fwreq_mutex);
 		self->aq_fw_ops->deinit(self->aq_hw);
 		mutex_unlock(&self->fwreq_mutex);
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
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index dab0ab10d111..95d460237835 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -55,6 +55,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/crc32poly.h>
+#include <linux/dmi.h>
 
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -18114,6 +18115,50 @@ static int tg3_resume(struct device *device)
 
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
@@ -18130,6 +18175,19 @@ static void tg3_shutdown(struct pci_dev *pdev)
 
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
 
diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index b21e56de6167..c79d97f4ee90 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1778,10 +1778,11 @@ dm9000_drv_remove(struct platform_device *pdev)
 
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
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index aeab6c28892f..018ce4f4be6f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -818,6 +818,8 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int hdr_len, total_len, data_left;
 	struct bufdesc *bdp = txq->bd.cur;
+	struct bufdesc *tmp_bdp;
+	struct bufdesc_ex *ebdp;
 	struct tso_t tso;
 	unsigned int index = 0;
 	int ret;
@@ -891,7 +893,34 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
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
index 60b8d61af07f..7f993b3f8038 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -929,4 +929,6 @@ int hnae3_register_client(struct hnae3_client *client);
 void hnae3_set_client_init_flag(struct hnae3_client *client,
 				struct hnae3_ae_dev *ae_dev,
 				unsigned int inited);
+void hnae3_acquire_unload_lock(void);
+void hnae3_release_unload_lock(void);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0377a056aaec..9d27fad9f35f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -6007,9 +6007,11 @@ module_init(hns3_init_module);
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
index 45bd5c79e4da..ed1b49a36016 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -13250,9 +13250,11 @@ static int __init hclge_init(void)
 
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
index aebb104f4c29..06493853b2b4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3468,8 +3468,10 @@ static int __init hclgevf_init(void)
 
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
index 53b9fe35d803..7119bce4c091 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -830,6 +830,11 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
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
@@ -850,8 +855,18 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 2ac255bb918b..133e8220aaea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -186,17 +186,16 @@ static void mlx5_pps_out(struct work_struct *work)
 	}
 }
 
-static void mlx5_timestamp_overflow(struct work_struct *work)
+static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
 	struct mlx5_core_dev *mdev;
 	struct mlx5_timer *timer;
 	struct mlx5_clock *clock;
 	unsigned long flags;
 
-	timer = container_of(dwork, struct mlx5_timer, overflow_work);
-	clock = container_of(timer, struct mlx5_clock, timer);
+	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	timer = &clock->timer;
 
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
 		goto out;
@@ -207,7 +206,7 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
 out:
-	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
+	return timer->overflow_period;
 }
 
 static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
@@ -375,6 +374,7 @@ static int mlx5_ptp_adjfreq(struct ptp_clock_info *ptp, s32 delta)
 				       timer->nominal_c_mult + diff;
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+	ptp_schedule_worker(clock->ptp, timer->overflow_period);
 
 	return 0;
 }
@@ -708,6 +708,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_info = {
 	.settime64	= mlx5_ptp_settime,
 	.enable		= NULL,
 	.verify		= NULL,
+	.do_aux_work	= mlx5_timestamp_overflow,
 };
 
 static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
@@ -908,12 +909,11 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
 	do_div(ns, NSEC_PER_SEC / HZ);
 	timer->overflow_period = ns;
 
-	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
-	if (timer->overflow_period)
-		schedule_delayed_work(&timer->overflow_work, 0);
-	else
+	if (!timer->overflow_period) {
+		timer->overflow_period = HZ;
 		mlx5_core_warn(mdev,
-			       "invalid overflow period, overflow_work is not scheduled\n");
+			       "invalid overflow period, overflow_work is scheduled once per second\n");
+	}
 
 	if (clock_info)
 		clock_info->overflow_period = timer->overflow_period;
@@ -999,6 +999,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 
 	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
 	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+
+	if (clock->ptp)
+		ptp_schedule_worker(clock->ptp, 0);
 }
 
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
@@ -1015,7 +1018,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	}
 
 	cancel_work_sync(&clock->pps_info.out_work);
-	cancel_delayed_work_sync(&clock->timer.overflow_work);
 
 	if (mdev->clock_info) {
 		free_page((unsigned long)mdev->clock_info);
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
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index dcd79d7e2af4..ab4852e0925d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -768,7 +768,9 @@ static void __mlxsw_sp_port_get_stats(struct net_device *dev,
 	err = mlxsw_sp_get_hw_stats_by_group(&hw_stats, &len, grp);
 	if (err)
 		return;
-	mlxsw_sp_port_get_stats_raw(dev, grp, prio, ppcnt_pl);
+	err = mlxsw_sp_port_get_stats_raw(dev, grp, prio, ppcnt_pl);
+	if (err)
+		return;
 	for (i = 0; i < len; i++) {
 		data[data_index + i] = hw_stats[i].getter(ppcnt_pl);
 		if (!hw_stats[i].cells_bytes)
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 14dc5833c465..5f4297e83aaf 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3473,10 +3473,12 @@ static int sh_eth_suspend(struct device *dev)
 
 	netif_device_detach(ndev);
 
+	rtnl_lock();
 	if (mdp->wol_enabled)
 		ret = sh_eth_wol_setup(ndev);
 	else
 		ret = sh_eth_close(ndev);
+	rtnl_unlock();
 
 	return ret;
 }
@@ -3490,10 +3492,12 @@ static int sh_eth_resume(struct device *dev)
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
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 33df06a2de13..32828d4ac64c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1541,7 +1541,7 @@ void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		if (tx_chn->irq)
+		if (tx_chn->irq > 0)
 			devm_free_irq(dev, tx_chn->irq, tx_chn);
 
 		netif_napi_del(&tx_chn->napi_tx);
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index feca55eef993..ec1fc1d3ea36 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -39,10 +39,14 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 		if (!sap->used)
 			continue;
 
-		p += scnprintf(p, bufsize - (p - buf),
-			       "sa[%i] %cx ipaddr=0x%08x %08x %08x %08x\n",
-			       i, (sap->rx ? 'r' : 't'), sap->ipaddr[0],
-			       sap->ipaddr[1], sap->ipaddr[2], sap->ipaddr[3]);
+		if (sap->xs->props.family == AF_INET6)
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI6c\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr);
+		else
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI4\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr[3]);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7d8ed8d8df5c..02e3518e9a7e 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -98,6 +98,7 @@ struct netdevsim {
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
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 029875a59ff8..718bba014b57 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -937,6 +937,8 @@ static int nxp_c45_soft_reset(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	usleep_range(2000, 2050);
+
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
 					 VEND1_DEVICE_CONTROL, ret,
 					 !(ret & DEVICE_CONTROL_RESET), 20000,
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 872640a9e73a..c2327fa10747 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1171,6 +1171,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
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
@@ -2663,7 +2670,9 @@ static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
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
index ea98d93138c1..03478ae3ff24 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -580,7 +580,7 @@ static inline bool tun_not_capable(struct tun_struct *tun)
 	struct net *net = dev_net(tun->dev);
 
 	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
-		  (gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
+		(gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
 		!ns_capable(net->user_ns, CAP_NET_ADMIN);
 }
 
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
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 155d335c80a7..50be5a3c4779 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2982,8 +2982,11 @@ static int vxlan_init(struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
-		vxlan_vnigroup_init(vxlan);
+	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		err = vxlan_vnigroup_init(vxlan);
+		if (err)
+			return err;
+	}
 
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!dev->tstats) {
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 3d113d709d19..1ffc00e27080 100644
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
index d01616d06a32..2f6b22708b53 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3795,6 +3795,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 		ath11k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
 		if (rbm != HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST &&
+		    rbm != HAL_RX_BUF_RBM_SW1_BM &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM) {
 			ab->soc_stats.invalid_rbm++;
 			ath11k_warn(ab, "invalid return buffer manager %d\n", rbm);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 7f39c6fb7408..d1785e71ffc9 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -371,7 +371,8 @@ int ath11k_hal_wbm_desc_parse_err(struct ath11k_base *ab, void *desc,
 
 	ret_buf_mgr = FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
 				wbm_desc->buf_addr_info.info1);
-	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
+	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW1_BM &&
+	    ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
 		ab->soc_stats.invalid_rbm++;
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 6b8d2889d73f..b3a685f2ddd2 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1585,7 +1585,10 @@ static int wcn36xx_probe(struct platform_device *pdev)
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 175272c2694d..a7882a50232c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -539,6 +539,11 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
 	struct ethhdr *eh;
 	u16 type;
 
+	if (!ifp) {
+		brcmu_pkt_buf_free_skb(txp);
+		return;
+	}
+
 	eh = (struct ethhdr *)(txp->data);
 	type = ntohs(eh->h_proto);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 0eb852896322..f117c90c53f5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -89,13 +89,13 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	/* Set board-type to the first string of the machine compatible prop */
 	root = of_find_node_by_path("/");
 	if (root && err) {
-		char *board_type;
+		char *board_type = NULL;
 		const char *tmp;
 
-		of_property_read_string_index(root, "compatible", 0, &tmp);
-
 		/* get rid of '/' in the compatible string to be able to find the FW */
-		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+		if (!of_property_read_string_index(root, "compatible", 0, &tmp))
+			board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+
 		if (!board_type) {
 			of_node_put(root);
 			return;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 8580a2754789..42e7bc67e914 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -23427,6 +23427,9 @@ wlc_phy_iqcal_gainparams_nphy(struct brcms_phy *pi, u16 core_no,
 				break;
 		}
 
+		if (WARN_ON(k == NPHY_IQCAL_NUMGAINS))
+			return;
+
 		params->txgm = tbl_iqcal_gainparams_nphy[band_idx][k][1];
 		params->pga = tbl_iqcal_gainparams_nphy[band_idx][k][2];
 		params->pad = tbl_iqcal_gainparams_nphy[band_idx][k][3];
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index c96dfd7fd3dc..84980f6a0d60 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -123,7 +123,7 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 				    size_t expected_size)
 {
 	union acpi_object *obj;
-	int ret = 0;
+	int ret;
 
 	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL, guid);
 	if (IS_ERR(obj)) {
@@ -138,8 +138,10 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 	} else if (obj->type == ACPI_TYPE_BUFFER) {
 		__le64 le_value = 0;
 
-		if (WARN_ON_ONCE(expected_size > sizeof(le_value)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(expected_size > sizeof(le_value))) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		/* if the buffer size doesn't match the expected size */
 		if (obj->buffer.length != expected_size)
@@ -160,8 +162,9 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 	}
 
 	IWL_DEBUG_DEV_RADIO(dev,
-			    "ACPI: DSM method evaluated: func=%d, ret=%d\n",
-			    func, ret);
+			    "ACPI: DSM method evaluated: func=%d, value=%lld\n",
+			    func, *value);
+	ret = 0;
 out:
 	ACPI_FREE(obj);
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index bc68ede64ddb..74f5321611c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -423,7 +423,7 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 			continue;
 
 		ofs = addr - dev->reg.map[i].phys;
-		if (ofs > dev->reg.map[i].size)
+		if (ofs >= dev->reg.map[i].size)
 			continue;
 
 		return dev->reg.map[i].maps + ofs;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 172ba7199485..5070cc23917b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -469,7 +469,13 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 0597df2729a6..1e2133670291 100644
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
index 9e7e98b55eff..25570ec0918e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -452,8 +452,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	/* <1> timer */
 	timer_setup(&rtlpriv->works.watchdog_timer,
 		    rtl_watch_dog_timer_callback, 0);
-	timer_setup(&rtlpriv->works.dualmac_easyconcurrent_retrytimer,
-		    rtl_easy_concurrent_retrytimer_callback, 0);
+
 	/* <2> work queue */
 	rtlpriv->works.hw = hw;
 	rtlpriv->works.rtl_wq = wq;
@@ -576,9 +575,15 @@ static void rtl_free_entries_from_ack_queue(struct ieee80211_hw *hw,
 
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
 
@@ -2366,19 +2371,6 @@ static void rtl_c2hcmd_wq_callback(struct work_struct *work)
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
@@ -2724,9 +2716,6 @@ MODULE_AUTHOR("Larry Finger	<Larry.FInger@lwfinger.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 802.11n PCI wireless core");
 
-struct rtl_global_var rtl_global_var = {};
-EXPORT_SYMBOL_GPL(rtl_global_var);
-
 static int __init rtl_core_module_init(void)
 {
 	BUILD_BUG_ON(TX_PWR_BY_RATE_NUM_RATE < TX_PWR_BY_RATE_NUM_SECTION);
@@ -2740,10 +2729,6 @@ static int __init rtl_core_module_init(void)
 	/* add debugfs */
 	rtl_debugfs_add_topdir();
 
-	/* init some global vars */
-	INIT_LIST_HEAD(&rtl_global_var.glb_priv_list);
-	spin_lock_init(&rtl_global_var.glb_list_lock);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index 0e4f8a8ae3a5..f3a6a43a42ec 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -124,8 +124,6 @@ int rtl_send_smps_action(struct ieee80211_hw *hw,
 u8 *rtl_find_ie(u8 *data, unsigned int len, u8 ie);
 void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len);
 u8 rtl_tid_to_ac(u8 tid);
-void rtl_easy_concurrent_retrytimer_callback(struct timer_list *t);
-extern struct rtl_global_var rtl_global_var;
 void rtl_phy_scan_operation_backup(struct ieee80211_hw *hw, u8 operation);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 6116c1bec155..2a1bc168f771 100644
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
@@ -443,11 +403,6 @@ static void _rtl_pci_tx_chk_waitq(struct ieee80211_hw *hw)
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
@@ -1702,8 +1657,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 	synchronize_irq(rtlpci->pdev->irq);
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
-
-	destroy_workqueue(rtlpriv->works.rtl_wq);
 }
 
 static int rtl_pci_init(struct ieee80211_hw *hw, struct pci_dev *pdev)
@@ -2018,7 +1971,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
 	rtl_pci_parse_configuration(pdev, hw);
-	list_add_tail(&rtlpriv->list, &rtlpriv->glb_var->glb_priv_list);
 
 	return true;
 }
@@ -2165,7 +2117,6 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	rtlpriv->rtlhal.interface = INTF_PCI;
 	rtlpriv->cfg = (struct rtl_hal_cfg *)(id->driver_data);
 	rtlpriv->intf_ops = &rtl_pci_ops;
-	rtlpriv->glb_var = &rtl_global_var;
 	rtl_efuse_ops_init(hw);
 
 	/* MEM map */
@@ -2216,7 +2167,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
 		pr_err("Can't init_sw_vars\n");
 		err = -ENODEV;
-		goto fail3;
+		goto fail2;
 	}
 	rtlpriv->cfg->ops->init_sw_leds(hw);
 
@@ -2234,14 +2185,14 @@ int rtl_pci_probe(struct pci_dev *pdev,
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
 
@@ -2264,16 +2215,19 @@ int rtl_pci_probe(struct pci_dev *pdev,
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
@@ -2324,7 +2278,6 @@ void rtl_pci_disconnect(struct pci_dev *pdev)
 	if (rtlpci->using_msi)
 		pci_disable_msi(rtlpci->pdev);
 
-	list_del(&rtlpriv->list);
 	if (rtlpriv->io.pci_mem_start != 0) {
 		pci_iounmap(pdev, (void __iomem *)rtlpriv->io.pci_mem_start);
 		pci_release_regions(pdev);
@@ -2384,7 +2337,6 @@ const struct rtl_intf_ops rtl_pci_ops = {
 	.read_efuse_byte = read_efuse_byte,
 	.adapter_start = rtl_pci_start,
 	.adapter_stop = rtl_pci_stop,
-	.check_buddy_priv = rtl_pci_check_buddy_priv,
 	.adapter_tx = rtl_pci_tx,
 	.flush = rtl_pci_flush,
 	.reset_trx_ring = rtl_pci_reset_trx_ring,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index 6d352a3161b8..60d97e73ca28 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -67,22 +67,23 @@ static void rtl92se_fw_cb(const struct firmware *firmware, void *context)
 
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
index c269942b3f4a..af8d17b9e012 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
@@ -197,9 +197,9 @@ enum rtl8821a_h2c_cmd {
 
 /* _MEDIA_STATUS_RPT_PARM_CMD1 */
 #define SET_H2CCMD_MSRRPT_PARM_OPMODE(__cmd, __value)	\
-	u8p_replace_bits(__cmd + 1, __value, BIT(0))
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__cmd, __value)	\
-	u8p_replace_bits(__cmd + 1, __value, BIT(1))
+	u8p_replace_bits(__cmd, __value, BIT(1))
 
 /* AP_OFFLOAD */
 #define SET_H2CCMD_AP_OFFLOAD_ON(__cmd, __value)	\
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index a8eebafb9a7e..68dc0e6af6b1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -679,11 +679,6 @@ static void _rtl_usb_cleanup_rx(struct ieee80211_hw *hw)
 	tasklet_kill(&rtlusb->rx_work_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 
-	if (rtlpriv->works.rtl_wq) {
-		destroy_workqueue(rtlpriv->works.rtl_wq);
-		rtlpriv->works.rtl_wq = NULL;
-	}
-
 	skb_queue_purge(&rtlusb->rx_queue);
 
 	while ((urb = usb_get_from_anchor(&rtlusb->rx_cleanup_urbs))) {
@@ -1073,19 +1068,22 @@ int rtl_usb_probe(struct usb_interface *intf,
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
index 0bac788ccd6e..a8b5db365a30 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2300,7 +2300,6 @@ struct rtl_hal_ops {
 			  u32 regaddr, u32 bitmask, u32 data);
 	void (*linked_set_reg)(struct ieee80211_hw *hw);
 	void (*chk_switch_dmdp)(struct ieee80211_hw *hw);
-	void (*dualmac_easy_concurrent)(struct ieee80211_hw *hw);
 	void (*dualmac_switch_to_dmdp)(struct ieee80211_hw *hw);
 	bool (*phy_rf6052_config)(struct ieee80211_hw *hw);
 	void (*phy_rf6052_set_cck_txpower)(struct ieee80211_hw *hw,
@@ -2336,8 +2335,6 @@ struct rtl_intf_ops {
 	void (*read_efuse_byte)(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf);
 	int (*adapter_start)(struct ieee80211_hw *hw);
 	void (*adapter_stop)(struct ieee80211_hw *hw);
-	bool (*check_buddy_priv)(struct ieee80211_hw *hw,
-				 struct rtl_priv **buddy_priv);
 
 	int (*adapter_tx)(struct ieee80211_hw *hw,
 			  struct ieee80211_sta *sta,
@@ -2465,7 +2462,6 @@ struct rtl_works {
 
 	/*timer */
 	struct timer_list watchdog_timer;
-	struct timer_list dualmac_easyconcurrent_retrytimer;
 	struct timer_list fw_clockoff_timer;
 	struct timer_list fast_antenna_training_timer;
 	/*task */
@@ -2498,14 +2494,6 @@ struct rtl_debug {
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
@@ -2590,14 +2578,6 @@ struct dig_t {
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
@@ -2743,10 +2723,7 @@ struct rtl_scan_list {
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
index 28c0f06e311f..b88ceb1f9800 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2533,24 +2533,24 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
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
@@ -2565,7 +2565,7 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 
 		ret = wl12xx_init_fw(wl);
 		if (ret < 0)
-			goto out;
+			goto out_unlock;
 	}
 
 	/*
diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index 04517bd3325a..a066977af0be 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <net/rtnetlink.h>
 
 #include "iosm_ipc_imem.h"
@@ -18,6 +19,7 @@ MODULE_LICENSE("GPL v2");
 /* WWAN GUID */
 static guid_t wwan_acpi_guid = GUID_INIT(0xbad01b75, 0x22a8, 0x4f48, 0x87, 0x92,
 				       0xbd, 0xde, 0x94, 0x67, 0x74, 0x7d);
+static bool pci_registered;
 
 static void ipc_pcie_resources_release(struct iosm_pcie *ipc_pcie)
 {
@@ -448,7 +450,6 @@ static struct pci_driver iosm_ipc_driver = {
 	},
 	.id_table = iosm_ipc_ids,
 };
-module_pci_driver(iosm_ipc_driver);
 
 int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data,
 		      size_t size, dma_addr_t *mapping, int direction)
@@ -530,3 +531,56 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
 	IPC_CB(skb)->mapping = 0;
 	dev_kfree_skb(skb);
 }
+
+static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
+{
+	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
+		if (pci_registered) {
+			pci_unregister_driver(&iosm_ipc_driver);
+			pci_registered = false;
+		}
+	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
+		if (!pci_registered) {
+			int ret;
+
+			ret = pci_register_driver(&iosm_ipc_driver);
+			if (ret) {
+				pr_err(KBUILD_MODNAME ": unable to re-register PCI driver: %d\n",
+				       ret);
+			} else {
+				pci_registered = true;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct notifier_block pm_notifier = {
+	.notifier_call = pm_notify,
+};
+
+static int __init iosm_ipc_driver_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&iosm_ipc_driver);
+	if (ret)
+		return ret;
+
+	pci_registered = true;
+
+	register_pm_notifier(&pm_notifier);
+
+	return 0;
+}
+module_init(iosm_ipc_driver_init);
+
+static void __exit iosm_ipc_driver_exit(void)
+{
+	unregister_pm_notifier(&pm_notifier);
+
+	if (pci_registered)
+		pci_unregister_driver(&iosm_ipc_driver);
+}
+module_exit(iosm_ipc_driver_exit);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92ffeb660561..ba76cd3b5f85 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1609,7 +1609,13 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
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
@@ -3099,7 +3105,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-	struct nvme_effects_log	*cel = xa_load(&ctrl->cels, csi);
+	struct nvme_effects_log *old, *cel = xa_load(&ctrl->cels, csi);
 	int ret;
 
 	if (cel)
@@ -3116,7 +3122,11 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
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
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b3e322e4ade3..a02873792890 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring.h>
@@ -95,10 +96,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -122,7 +128,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	if (bdev)
 		bio_set_dev(bio, bdev);
 
-	if (bdev && meta_buffer && meta_len) {
+	if (has_metadata) {
 		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
 				meta_seed);
 		if (IS_ERR(meta)) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbc45b58099f..f939b6dc295e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3103,7 +3103,9 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		 * because of high power consumption (> 2 Watt) in s2idle
 		 * sleep. Only some boards with Intel CPU are affected.
 		 */
-		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
+		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
 		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad897b2c0b14..a3ab4829d186 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1532,6 +1532,8 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 		return -EINVAL;
 
 	if (cell->bit_offset || cell->nbits) {
+		if (len != BITS_TO_BYTES(cell->nbits) && len != cell->bytes)
+			return -EINVAL;
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 8499892044b7..729d9d879fd5 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -143,6 +143,7 @@ static int sdam_probe(struct platform_device *pdev)
 	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
 	sdam->sdam_config.owner = THIS_MODULE;
 	sdam->sdam_config.stride = 1;
+	sdam->sdam_config.size = sdam->size;
 	sdam->sdam_config.word_size = 1;
 	sdam->sdam_config.reg_read = sdam_read;
 	sdam->sdam_config.reg_write = sdam_write;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index e1b2b9275e68..90c934bb91da 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -974,10 +974,10 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
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
@@ -1635,7 +1635,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 		 * specifier into the out_args structure, keeping the
 		 * bits specified in <list>-map-pass-thru.
 		 */
-		match_array = map - new_size;
 		for (i = 0; i < new_size; i++) {
 			__be32 val = *(map - new_size + i);
 
@@ -1644,6 +1643,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				val |= cpu_to_be32(out_args->args[i]) & pass[i];
 			}
 
+			initial_match_array[i] = val;
 			out_args->args[i] = be32_to_cpu(val);
 		}
 		out_args->args_count = list_size = new_size;
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index f90975e00446..7c5f6565de85 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -50,7 +50,8 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 			memblock_phys_free(base, size);
 	}
 
-	kmemleak_ignore_phys(base);
+	if (!err)
+		kmemleak_ignore_phys(base);
 
 	return err;
 }
@@ -104,12 +105,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 
 	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
-		if (len != dt_root_addr_cells * sizeof(__be32)) {
+		if (len != dt_root_size_cells * sizeof(__be32)) {
 			pr_err("invalid alignment property in '%s' node.\n",
 				uname);
 			return -EINVAL;
 		}
-		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		align = dt_mem_next_cell(dt_root_size_cells, &prop);
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 71d3e3ba909a..4211cfb27350 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -104,11 +104,30 @@ struct opp_table *_find_opp_table(struct device *dev)
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
@@ -180,25 +199,24 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
 
 /**
- * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
- * @opp:	opp for which frequency has to be returned for
+ * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
+ *				   available opp with specified index
+ * @opp: opp for which frequency has to be returned for
+ * @index: index of the frequency within the required opp
  *
- * Return: frequency in hertz corresponding to the opp, else
- * return 0
+ * Return: frequency in hertz corresponding to the opp with specified index,
+ * else return 0
  */
-unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
 {
-	if (IS_ERR_OR_NULL(opp)) {
+	if (IS_ERR_OR_NULL(opp) || index >= opp->opp_table->clk_count) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return 0;
 	}
 
-	if (!assert_single_clk(opp->opp_table))
-		return 0;
-
-	return opp->rates[0];
+	return opp->rates[index];
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
 
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
@@ -497,12 +515,12 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
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
@@ -530,7 +548,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key),
-	  bool (*assert)(struct opp_table *opp_table))
+	  bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -553,7 +571,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
 		unsigned long key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	/*
 	 * The value of key will be updated here, but will be ignored as the
@@ -566,7 +584,7 @@ static struct dev_pm_opp *_find_key_exact(struct device *dev,
 static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _opp_table_find_key(opp_table, key, index, available, read,
 				   _compare_ceil, assert);
@@ -575,7 +593,7 @@ static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 		int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_ceil,
 			 assert);
@@ -584,7 +602,7 @@ static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 static struct dev_pm_opp *_find_key_floor(struct device *dev,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_floor,
 			 assert);
@@ -621,6 +639,35 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+/**
+ * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
+ *					 clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	frequency to search for
+ * @index:	Clock index
+ * @available:	true/false - match for available opp
+ *
+ * Search for the matching exact OPP for the clock corresponding to the
+ * specified index from a starting freq for a device.
+ *
+ * Return: matching *opp , else returns ERR_PTR in case of error and should be
+ * handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *
+dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
+				   u32 index, bool available)
+{
+	return _find_key_exact(dev, freq, index, available, _read_freq,
+			       assert_clk_index);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
+
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
@@ -653,6 +700,35 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
+/**
+ * dev_pm_opp_find_freq_ceil_indexed() - Search for a rounded ceil freq for the
+ *					 clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	Start frequency
+ * @index:	Clock index
+ *
+ * Search for the matching ceil *available* OPP for the clock corresponding to
+ * the specified index from a starting freq for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *
+dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq,
+				  u32 index)
+{
+	return _find_key_ceil(dev, freq, index, true, _read_freq,
+			      assert_clk_index);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
+
 /**
  * dev_pm_opp_find_freq_floor() - Search for a rounded floor freq
  * @dev:	device for which we do this operation
@@ -678,6 +754,34 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/**
+ * dev_pm_opp_find_freq_floor_indexed() - Search for a rounded floor freq for the
+ *					  clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	Start frequency
+ * @index:	Clock index
+ *
+ * Search for the matching floor *available* OPP for the clock corresponding to
+ * the specified index from a starting freq for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *
+dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq,
+				   u32 index)
+{
+	return _find_key_floor(dev, freq, index, true, _read_freq, assert_clk_index);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
+
 /**
  * dev_pm_opp_find_level_exact() - search for an exact level
  * @dev:		device for which we do this operation
@@ -752,7 +856,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
+			     assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -783,7 +888,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
+			      assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -1588,7 +1694,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		return;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		goto put_table;
 
 	mutex_lock(&opp_table->lock);
@@ -1939,7 +2045,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol;
 	int ret;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		return -EINVAL;
 
 	new_opp = _opp_allocate(opp_table);
@@ -2795,7 +2901,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}
@@ -2871,7 +2977,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 605d68673f92..c1b2d8927845 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -950,7 +950,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
 	if (ret)
-		goto free_opp;
+		goto put_node;
 
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
@@ -1003,6 +1003,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 free_required_opps:
 	_of_opp_free_required_opps(opp_table, new_opp);
+put_node:
+	of_node_put(np);
 free_opp:
 	_opp_free(new_opp);
 
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 4605758d3214..2e921ddbe748 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2612,6 +2612,7 @@ enum parport_pc_pci_cards {
 	netmos_9815,
 	netmos_9901,
 	netmos_9865,
+	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
 	brainboxes_uc146,
@@ -2678,6 +2679,7 @@ static struct parport_pc_pci {
 	/* netmos_9815 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
+	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
@@ -2770,6 +2772,9 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  0xA000, 0x1000, 0, 0, netmos_9865 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 	  0xA000, 0x2000, 0, 0, netmos_9865 },
+	/* ASIX AX99100 PCIe to Multi I/O Controller */
+	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+	  0xA000, 0x2000, 0, 0, asix_ax99100 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index f9682df1da61..209719fb6ddc 100644
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
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 2e8a4de2abab..bcf4f2ca82b3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 
 fail_back_rx:
 	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_tx = NULL;
+	epf_test->dma_chan_rx = NULL;
 
 fail_back_tx:
 	dma_cap_zero(mask);
@@ -328,7 +328,6 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 {
 	int ret;
-	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
@@ -373,16 +372,9 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	}
 
 	ktime_get_ts64(&start);
-	use_dma = !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret = -EINVAL;
-			goto err_map_addr;
-		}
-
-		if (epf_test->dma_private) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
+	if (reg->flags & FLAG_USE_DMA) {
+		if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
+			dev_err(dev, "DMA controller doesn't support MEMCPY\n");
 			ret = -EINVAL;
 			goto err_map_addr;
 		}
@@ -406,7 +398,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
 
 err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
@@ -430,7 +423,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
@@ -463,14 +455,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err_map_addr;
 	}
 
-	use_dma = !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret = -EINVAL;
-			goto err_dma_map;
-		}
-
+	if (reg->flags & FLAG_USE_DMA) {
 		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
 					       DMA_FROM_DEVICE);
 		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
@@ -495,7 +480,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		ktime_get_ts64(&end);
 	}
 
-	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
 
 	crc32 = crc32_le(~0, buf, reg->size);
 	if (crc32 != reg->checksum)
@@ -519,7 +505,6 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	int ret;
 	void __iomem *dst_addr;
 	void *buf;
-	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
@@ -555,14 +540,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	get_random_bytes(buf, reg->size);
 	reg->checksum = crc32_le(~0, buf, reg->size);
 
-	use_dma = !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
-		if (!epf_test->dma_supported) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
-			ret = -EINVAL;
-			goto err_dma_map;
-		}
-
+	if (reg->flags & FLAG_USE_DMA) {
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(dma_dev, src_phys_addr)) {
@@ -589,7 +567,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		ktime_get_ts64(&end);
 	}
 
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
+	pci_epf_test_print_rate("WRITE", reg->size, &start, &end,
+				reg->flags & FLAG_USE_DMA);
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -660,6 +639,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	reg->command = 0;
 	reg->status = 0;
 
+	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
+	    !epf_test->dma_supported) {
+		dev_err(dev, "Cannot transfer data using DMA\n");
+		goto reset_handler;
+	}
+
 	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index f5a5ec80d194..eb502426ea6c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -740,7 +740,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..7d21f134143c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -234,6 +234,7 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 
 	mutex_lock(&epf_pf->lock);
 	clear_bit(epf_vf->vfunc_no, &epf_pf->vfunction_num_map);
+	epf_vf->epf_pf = NULL;
 	list_del(&epf_vf->list);
 	mutex_unlock(&epf_pf->lock);
 }
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2b3df65005ca..fb115b8ba342 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5870,6 +5870,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
 SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
 SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
 
+#define SWITCHTEC_PCI100X_QUIRK(vid) \
+	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
+		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
+SWITCHTEC_PCI100X_QUIRK(0x1001);  /* PCI1001XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1002);  /* PCI1002XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
+
+
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
  * These IDs are used to forward responses to the originator on the other
@@ -6139,6 +6150,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 332af6938d7f..9011518b1d13 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1739,6 +1739,26 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 		.driver_data = gen, \
 	}
 
+#define SWITCHTEC_PCI100X_DEVICE(device_id, gen) \
+	{ \
+		.vendor     = PCI_VENDOR_ID_EFAR, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
+		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
+	}, \
+	{ \
+		.vendor     = PCI_VENDOR_ID_EFAR, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
+		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
+	}
+
 static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  /* PFX 24xG3 */
 	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  /* PFX 32xG3 */
@@ -1833,6 +1853,12 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
+	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 5abab6bc763a..f7c8ae980813 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1234,7 +1234,7 @@ static int cy8c95x0_irq_setup(struct cy8c95x0_pinctrl *chip, int irq)
 
 	ret = devm_request_threaded_irq(chip->dev, irq,
 					NULL, cy8c95x0_irq_handler,
-					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_HIGH,
+					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(chip->dev), chip);
 	if (ret) {
 		dev_err(chip->dev, "failed to request irq %d\n", irq);
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index bd13b5ef246d..0022ee0851fa 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1149,7 +1149,7 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq_optional(pdev, 0);
 	if (ret < 0 && ret != -ENXIO)
-		return ret;
+		goto err_put_banks;
 	if (ret > 0)
 		drvdata->irq = ret;
 
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index e198233c10ba..4a3f5f5b966d 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -85,7 +85,6 @@ struct stm32_pinctrl_group {
 
 struct stm32_gpio_bank {
 	void __iomem *base;
-	struct clk *clk;
 	struct reset_control *rstc;
 	spinlock_t lock;
 	struct gpio_chip gpio_chip;
@@ -107,6 +106,7 @@ struct stm32_pinctrl {
 	unsigned ngroups;
 	const char **grp_names;
 	struct stm32_gpio_bank *banks;
+	struct clk_bulk_data *clks;
 	unsigned nbanks;
 	const struct stm32_pinctrl_match_data *match_data;
 	struct irq_domain	*domain;
@@ -1273,6 +1273,30 @@ static const struct pinconf_ops stm32_pconf_ops = {
 	.pin_config_dbg_show	= stm32_pconf_dbg_show,
 };
 
+static struct stm32_desc_pin *stm32_pctrl_get_desc_pin_from_gpio(struct stm32_pinctrl *pctl,
+								 struct stm32_gpio_bank *bank,
+								 unsigned int offset)
+{
+	unsigned int stm32_pin_nb = bank->bank_nr * STM32_GPIO_PINS_PER_BANK + offset;
+	struct stm32_desc_pin *pin_desc;
+	int i;
+
+	/* With few exceptions (e.g. bank 'Z'), pin number matches with pin index in array */
+	if (stm32_pin_nb < pctl->npins) {
+		pin_desc = pctl->pins + stm32_pin_nb;
+		if (pin_desc->pin.number == stm32_pin_nb)
+			return pin_desc;
+	}
+
+	/* Otherwise, loop all array to find the pin with the right number */
+	for (i = 0; i < pctl->npins; i++) {
+		pin_desc = pctl->pins + i;
+		if (pin_desc->pin.number == stm32_pin_nb)
+			return pin_desc;
+	}
+	return NULL;
+}
+
 static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode_handle *fwnode)
 {
 	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
@@ -1283,6 +1307,8 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	struct resource res;
 	int npins = STM32_GPIO_PINS_PER_BANK;
 	int bank_nr, err, i = 0;
+	struct stm32_desc_pin *stm32_pin;
+	char **names;
 
 	if (!IS_ERR(bank->rstc))
 		reset_control_deassert(bank->rstc);
@@ -1294,12 +1320,6 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
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
@@ -1346,24 +1366,35 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 							   bank->fwnode, &stm32_gpio_domain_ops,
 							   bank);
 
-		if (!bank->domain) {
-			err = -ENODEV;
-			goto err_clk;
+		if (!bank->domain)
+			return -ENODEV;
+	}
+
+	names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	for (i = 0; i < npins; i++) {
+		stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
+		if (stm32_pin && stm32_pin->pin.name) {
+			names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s", stm32_pin->pin.name);
+			if (!names[i])
+				return -ENOMEM;
+		} else {
+			names[i] = NULL;
 		}
 	}
 
+	bank->gpio_chip.names = (const char * const *)names;
+
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
@@ -1591,6 +1622,11 @@ int stm32_pctl_probe(struct platform_device *pdev)
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
@@ -1602,24 +1638,27 @@ int stm32_pctl_probe(struct platform_device *pdev)
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
@@ -1628,6 +1667,15 @@ int stm32_pctl_probe(struct platform_device *pdev)
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
@@ -1696,10 +1744,8 @@ static int __maybe_unused stm32_pinctrl_restore_gpio_regs(
 int __maybe_unused stm32_pinctrl_suspend(struct device *dev)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(dev);
-	int i;
 
-	for (i = 0; i < pctl->nbanks; i++)
-		clk_disable(pctl->banks[i].clk);
+	clk_bulk_disable(pctl->nbanks, pctl->clks);
 
 	return 0;
 }
@@ -1708,10 +1754,11 @@ int __maybe_unused stm32_pinctrl_resume(struct device *dev)
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
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index ee67efdd5499..da765a7dedbc 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -88,6 +88,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
+	WMID_AC_EVENT = 0x8,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -1999,6 +2000,9 @@ static void acer_wmi_notify(u32 value, void *context)
 		if (return_value.key_num == 0x4)
 			acer_toggle_turbo();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index c42c3faa2c32..0f16436e5804 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -359,6 +359,9 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	struct int3472_cldb cldb;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	ret = skl_int3472_fill_cldb(adev, &cldb);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't fill CLDB structure\n");
diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index 5b8d1a9620a5..82fb2fbc1000 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -152,6 +152,9 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	int ret;
 	int i;
 
+	if (!adev)
+		return -ENODEV;
+
 	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
 	if (n_consumers < 0)
 		return n_consumers;
diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..bf3b6f1aa984 100644
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
index 53e9c304ae0a..c3f46efd64c3 100644
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
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 8eb902fe73a9..6b3600356797 100644
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
@@ -124,6 +125,9 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 	struct timespec64 ts;
 	int enable, err = 0;
 
+	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
+		arg = (unsigned long)compat_ptr(arg);
+
 	switch (cmd) {
 
 	case PTP_CLOCK_GETCAPS:
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 389599bd13bb..af66ed48dc00 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -188,6 +188,11 @@ static int ptp_getcycles64(struct ptp_clock_info *info, struct timespec64 *ts)
 		return info->gettime64(info, ts);
 }
 
+static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 static void ptp_aux_kworker(struct kthread_work *work)
 {
 	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
@@ -250,6 +255,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 			ptp->info->getcrosscycles = ptp->info->getcrosststamp;
 	}
 
+	if (!ptp->info->enable)
+		ptp->info->enable = ptp_enable;
+
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
 		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 8fee9b330b61..87b960e941ba 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3589,7 +3589,7 @@ ptp_ocp_complete(struct ptp_ocp *bp)
 
 	pps = pps_lookup_dev(bp->ptp);
 	if (pps)
-		ptp_ocp_symlink(bp, pps->dev, "pps");
+		ptp_ocp_symlink(bp, &pps->dev, "pps");
 
 	ptp_ocp_debugfs_add_device(bp);
 
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 31a185c6b8da..7f477082db1d 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -169,8 +169,12 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *chip,
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
index 2070d107c632..fda7d76f08b1 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -631,8 +631,11 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->chip.npwm = stm32_pwm_detect_channels(priv, &num_enabled);
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
-	for (i = 0; i < num_enabled; i++)
-		clk_enable(priv->clk);
+	for (i = 0; i < num_enabled; i++) {
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 518b64b2d69b..fc52551aa265 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4897,7 +4897,7 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
-					    "Failed to get supply '%s'",
+					    "Failed to get supply '%s'\n",
 					    consumers[i].supply);
 			consumers[i].consumer = NULL;
 			goto err;
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 59e71fd0db43..f23c12f4ffbf 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -435,7 +435,7 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 					"failed to parse DT for regulator %pOFn\n",
 					child);
 				of_node_put(child);
-				return -EINVAL;
+				goto err_put;
 			}
 			match->of_node = of_node_get(child);
 			count++;
@@ -444,6 +444,18 @@ int of_regulator_match(struct device *dev, struct device_node *node,
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
 
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c3f194d9384d..341787909bd2 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2464,6 +2464,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
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
@@ -2474,13 +2481,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
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
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 754e03984f98..6ffdc10b32d3 100644
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
diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index c9b85c838ebe..e8a2cad05e50 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -318,8 +318,8 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Getting the rtc_clk info */
-	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc_clk");
+	/* Getting the rtc info */
+	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc");
 	if (IS_ERR(xrtcdev->rtc_clk)) {
 		if (PTR_ERR(xrtcdev->rtc_clk) != -EPROBE_DEFER)
 			dev_warn(&pdev->dev, "Device clock not found.\n");
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 5c13358416c4..b5a3694bfe7f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5649,8 +5649,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	if (!ioc->is_gen35_ioc && ioc->manu_pg11.EEDPTagMode == 0) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
-		ioc->manu_pg11.EEDPTagMode &= ~0x3;
-		ioc->manu_pg11.EEDPTagMode |= 0x1;
+		ioc->manu_pg11.EEDPTagMode = 0x1;
 		mpt3sas_config_set_manufacturing_pg11(ioc, &mpi_reply,
 		    &ioc->manu_pg11);
 	}
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 8490181424c7..f8b949eaffcf 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4043,6 +4043,8 @@ struct qla_hw_data {
 		uint32_t	npiv_supported		:1;
 		uint32_t	pci_channel_io_perm_failure	:1;
 		uint32_t	fce_enabled		:1;
+		uint32_t	user_enabled_fce	:1;
+		uint32_t	fce_dump_buf_alloced	:1;
 		uint32_t	fac_supported		:1;
 
 		uint32_t	chip_reset_done		:1;
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 081af4d420a0..4a82b377928d 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -409,26 +409,31 @@ qla2x00_dfs_fce_show(struct seq_file *s, void *unused)
 
 	mutex_lock(&ha->fce_mutex);
 
-	seq_puts(s, "FCE Trace Buffer\n");
-	seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
-	seq_printf(s, "Base = %llx\n\n", (unsigned long long) ha->fce_dma);
-	seq_puts(s, "FCE Enable Registers\n");
-	seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
-	    ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
-	    ha->fce_mb[5], ha->fce_mb[6]);
-
-	fce = (uint32_t *) ha->fce;
-	fce_start = (unsigned long long) ha->fce_dma;
-	for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
-		if (cnt % 8 == 0)
-			seq_printf(s, "\n%llx: ",
-			    (unsigned long long)((cnt * 4) + fce_start));
-		else
-			seq_putc(s, ' ');
-		seq_printf(s, "%08x", *fce++);
-	}
+	if (ha->flags.user_enabled_fce) {
+		seq_puts(s, "FCE Trace Buffer\n");
+		seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
+		seq_printf(s, "Base = %llx\n\n", (unsigned long long)ha->fce_dma);
+		seq_puts(s, "FCE Enable Registers\n");
+		seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
+			   ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
+			   ha->fce_mb[5], ha->fce_mb[6]);
+
+		fce = (uint32_t *)ha->fce;
+		fce_start = (unsigned long long)ha->fce_dma;
+		for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
+			if (cnt % 8 == 0)
+				seq_printf(s, "\n%llx: ",
+					   (unsigned long long)((cnt * 4) + fce_start));
+			else
+				seq_putc(s, ' ');
+			seq_printf(s, "%08x", *fce++);
+		}
 
-	seq_puts(s, "\nEnd\n");
+		seq_puts(s, "\nEnd\n");
+	} else {
+		seq_puts(s, "FCE Trace is currently not enabled\n");
+		seq_puts(s, "\techo [ 1 | 0 ] > fce\n");
+	}
 
 	mutex_unlock(&ha->fce_mutex);
 
@@ -467,7 +472,7 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 	struct qla_hw_data *ha = vha->hw;
 	int rval;
 
-	if (ha->flags.fce_enabled)
+	if (ha->flags.fce_enabled || !ha->fce)
 		goto out;
 
 	mutex_lock(&ha->fce_mutex);
@@ -488,11 +493,88 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static ssize_t
+qla2x00_dfs_fce_write(struct file *file, const char __user *buffer,
+		      size_t count, loff_t *pos)
+{
+	struct seq_file *s = file->private_data;
+	struct scsi_qla_host *vha = s->private;
+	struct qla_hw_data *ha = vha->hw;
+	char *buf;
+	int rc = 0;
+	unsigned long enable;
+
+	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
+	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha)) {
+		ql_dbg(ql_dbg_user, vha, 0xd034,
+		       "this adapter does not support FCE.");
+		return -EINVAL;
+	}
+
+	buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(buf)) {
+		ql_dbg(ql_dbg_user, vha, 0xd037,
+		    "fail to copy user buffer.");
+		return PTR_ERR(buf);
+	}
+
+	enable = kstrtoul(buf, 0, 0);
+	rc = count;
+
+	mutex_lock(&ha->fce_mutex);
+
+	if (enable) {
+		if (ha->flags.user_enabled_fce) {
+			mutex_unlock(&ha->fce_mutex);
+			goto out_free;
+		}
+		ha->flags.user_enabled_fce = 1;
+		if (!ha->fce) {
+			rc = qla2x00_alloc_fce_trace(vha);
+			if (rc) {
+				ha->flags.user_enabled_fce = 0;
+				mutex_unlock(&ha->fce_mutex);
+				goto out_free;
+			}
+
+			/* adjust fw dump buffer to take into account of this feature */
+			if (!ha->flags.fce_dump_buf_alloced)
+				qla2x00_alloc_fw_dump(vha);
+		}
+
+		if (!ha->flags.fce_enabled)
+			qla_enable_fce_trace(vha);
+
+		ql_dbg(ql_dbg_user, vha, 0xd045, "User enabled FCE .\n");
+	} else {
+		if (!ha->flags.user_enabled_fce) {
+			mutex_unlock(&ha->fce_mutex);
+			goto out_free;
+		}
+		ha->flags.user_enabled_fce = 0;
+		if (ha->flags.fce_enabled) {
+			qla2x00_disable_fce_trace(vha, NULL, NULL);
+			ha->flags.fce_enabled = 0;
+		}
+
+		qla2x00_free_fce_trace(ha);
+		/* no need to re-adjust fw dump buffer */
+
+		ql_dbg(ql_dbg_user, vha, 0xd04f, "User disabled FCE .\n");
+	}
+
+	mutex_unlock(&ha->fce_mutex);
+out_free:
+	kfree(buf);
+	return rc;
+}
+
 static const struct file_operations dfs_fce_ops = {
 	.open		= qla2x00_dfs_fce_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= qla2x00_dfs_fce_release,
+	.write		= qla2x00_dfs_fce_write,
 };
 
 static int
@@ -671,8 +753,6 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
 		goto out;
-	if (!ha->fce)
-		goto out;
 
 	if (qla2x00_dfs_root)
 		goto create_dir;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 73cd869caf60..f991fb81c72b 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -11,6 +11,9 @@
 /*
  * Global Function Prototypes in qla_init.c source file.
  */
+int  qla2x00_alloc_fce_trace(scsi_qla_host_t *);
+void qla2x00_free_fce_trace(struct qla_hw_data *ha);
+void qla_enable_fce_trace(scsi_qla_host_t *);
 extern int qla2x00_initialize_adapter(scsi_qla_host_t *);
 extern int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a65c60160820..682e74196f4b 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2682,7 +2682,7 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
 	return rval;
 }
 
-static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+void qla_enable_fce_trace(scsi_qla_host_t *vha)
 {
 	int rval;
 	struct qla_hw_data *ha = vha->hw;
@@ -3718,25 +3718,24 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 	return rval;
 }
 
-static void
-qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
+int qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
 
 	if (!IS_FWI2_CAPABLE(ha))
-		return;
+		return -EINVAL;
 
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
-		return;
+		return -EINVAL;
 
 	if (ha->fce) {
 		ql_dbg(ql_dbg_init, vha, 0x00bd,
 		       "%s: FCE Mem is already allocated.\n",
 		       __func__);
-		return;
+		return -EIO;
 	}
 
 	/* Allocate memory for Fibre Channel Event Buffer. */
@@ -3746,7 +3745,7 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 		ql_log(ql_log_warn, vha, 0x00be,
 		       "Unable to allocate (%d KB) for FCE.\n",
 		       FCE_SIZE / 1024);
-		return;
+		return -ENOMEM;
 	}
 
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
@@ -3755,6 +3754,16 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
 	ha->fce_bufs = FCE_NUM_BUFFERS;
+	return 0;
+}
+
+void qla2x00_free_fce_trace(struct qla_hw_data *ha)
+{
+	if (!ha->fce)
+		return;
+	dma_free_coherent(&ha->pdev->dev, FCE_SIZE, ha->fce, ha->fce_dma);
+	ha->fce = NULL;
+	ha->fce_dma = 0;
 }
 
 static void
@@ -3845,9 +3854,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_alloc_fce_trace(vha);
-		if (ha->fce)
+		if (ha->fce) {
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
+			ha->flags.fce_dump_buf_alloced = 1;
+		}
 		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d47adab00f04..6ab3fdb06965 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1791,6 +1791,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
+	payload->range.len = 0;
 	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {
diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index dae8a2e0f745..78cb2c4bd392 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -367,7 +367,7 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 
 static int __init atmel_soc_device_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 
 	if (!of_match_node(at91_soc_allowed_list, np))
 		return 0;
diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index e848cc9a3cf8..a8be3a2f3382 100644
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
index 5401b075840b..e5f142026188 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -652,7 +652,7 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 	if (!qs->attr.soc_id || !qs->attr.revision)
 		return -ENOMEM;
 
-	if (offsetof(struct socinfo, serial_num) <= item_size) {
+	if (offsetofend(struct socinfo, serial_num) <= item_size) {
 		qs->attr.serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"%u",
 							le32_to_cpu(info->serial_num));
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 78f31b61a2aa..77ea6b522348 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -379,12 +379,21 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->master;
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
index 59f1eb7b62bc..3771bc410dff 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -55,22 +55,18 @@ int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
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
index 99b333b68198..f5805dc70ece 100644
--- a/drivers/staging/media/max96712/max96712.c
+++ b/drivers/staging/media/max96712/max96712.c
@@ -376,7 +376,6 @@ static int max96712_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	priv->client = client;
-	i2c_set_clientdata(client, priv);
 
 	priv->regmap = devm_regmap_init_i2c(client, &max96712_i2c_regmap);
 	if (IS_ERR(priv->regmap))
@@ -409,7 +408,8 @@ static int max96712_probe(struct i2c_client *client)
 
 static void max96712_remove(struct i2c_client *client)
 {
-	struct max96712_priv *priv = i2c_get_clientdata(client);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct max96712_priv *priv = container_of(sd, struct max96712_priv, sd);
 
 	v4l2_async_unregister_subdev(&priv->sd);
 
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index eeb7b43ebe53..78b927f474b7 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -344,6 +344,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
+extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -376,6 +377,7 @@ static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
+static inline void serial8250_tx_dma_flush(struct uart_8250_port *p) { }
 static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index a442f0dfd28e..0dd0ae76b90c 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -133,6 +133,22 @@ int serial8250_tx_dma(struct uart_8250_port *p)
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
index 38fb7126ab0e..6026cc50a7ea 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -66,6 +66,8 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
 			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
@@ -5890,6 +5892,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
index c744feabd7cd..711de54eda98 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2091,7 +2091,8 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-static void wait_for_lsr(struct uart_8250_port *up, int bits)
+/* Returns true if @bits were set, false on timeout */
+static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
@@ -2106,11 +2107,11 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
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
@@ -2549,6 +2550,14 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
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
@@ -3259,6 +3268,7 @@ static const struct uart_ops serial8250_pops = {
 	.break_ctl	= serial8250_break_ctl,
 	.startup	= serial8250_startup,
 	.shutdown	= serial8250_shutdown,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_termios	= serial8250_set_termios,
 	.set_ldisc	= serial8250_set_ldisc,
 	.pm		= serial8250_pm,
@@ -3349,6 +3359,16 @@ static void serial8250_console_restore(struct uart_8250_port *up)
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
@@ -3358,13 +3378,15 @@ static void serial8250_console_restore(struct uart_8250_port *up)
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
@@ -3375,7 +3397,14 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
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
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 08ad5ae41121..6182ae5f6fa1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -165,6 +165,7 @@ struct sci_port {
 static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
+static bool sci_uart_earlycon;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3318,6 +3319,7 @@ static int sci_probe_single(struct platform_device *dev,
 static int sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p;
+	struct resource *res;
 	struct sci_port *sp;
 	unsigned int dev_id;
 	int ret;
@@ -3347,6 +3349,26 @@ static int sci_probe(struct platform_device *dev)
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
@@ -3430,7 +3452,7 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct plat_sci_port port_cfg __initdata;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
@@ -3445,6 +3467,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_uart_earlycon = true;
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2eff7cff57c4..29afcc6d9bb7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -268,7 +268,7 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(port, data))
+		if (uart_prepare_sysrq_char(port, data))
 			continue;
 
 		if (is_rxbs_support) {
@@ -371,7 +371,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	    !(readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS))
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
-	spin_unlock(&port->lock);
+	uart_unlock_and_check_sysrq(port);
 	return IRQ_HANDLED;
 }
 
@@ -1231,10 +1231,8 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	unsigned int imr, ctrl;
 	int locked = 1;
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
 
diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index b99e3f3dc4ef..ead55e063d2b 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -181,6 +181,7 @@ void ufs_bsg_remove(struct ufs_hba *hba)
 		return;
 
 	bsg_remove_queue(hba->bsg_queue);
+	hba->bsg_queue = NULL;
 
 	device_del(bsg_dev);
 	put_device(bsg_dev);
@@ -219,6 +220,7 @@ int ufs_bsg_probe(struct ufs_hba *hba)
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), ufs_bsg_request, NULL, 0);
 	if (IS_ERR(q)) {
 		ret = PTR_ERR(q);
+		device_del(bsg_dev);
 		goto out;
 	}
 
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 984087bbf3e2..07872440a8d9 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -357,25 +357,29 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		data->pinctrl = devm_pinctrl_get(dev);
 		if (PTR_ERR(data->pinctrl) == -ENODEV)
 			data->pinctrl = NULL;
-		else if (IS_ERR(data->pinctrl))
-			return dev_err_probe(dev, PTR_ERR(data->pinctrl),
+		else if (IS_ERR(data->pinctrl)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->pinctrl),
 					     "pinctrl get failed\n");
+			goto err_put;
+		}
 
 		data->hsic_pad_regulator =
 				devm_regulator_get_optional(dev, "hsic");
 		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
 			/* no pad regualator is needed */
 			data->hsic_pad_regulator = NULL;
-		} else if (IS_ERR(data->hsic_pad_regulator))
-			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
+		} else if (IS_ERR(data->hsic_pad_regulator)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
 					     "Get HSIC pad regulator error\n");
+			goto err_put;
+		}
 
 		if (data->hsic_pad_regulator) {
 			ret = regulator_enable(data->hsic_pad_regulator);
 			if (ret) {
 				dev_err(dev,
 					"Failed to enable HSIC pad regulator\n");
-				return ret;
+				goto err_put;
 			}
 		}
 	}
@@ -389,13 +393,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 			dev_err(dev,
 				"pinctrl_hsic_idle lookup failed, err=%ld\n",
 					PTR_ERR(pinctrl_hsic_idle));
-			return PTR_ERR(pinctrl_hsic_idle);
+			ret = PTR_ERR(pinctrl_hsic_idle);
+			goto err_put;
 		}
 
 		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
 		if (ret) {
 			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
-			return ret;
+			goto err_put;
 		}
 
 		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
@@ -404,7 +409,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 			dev_err(dev,
 				"pinctrl_hsic_active lookup failed, err=%ld\n",
 					PTR_ERR(data->pinctrl_hsic_active));
-			return PTR_ERR(data->pinctrl_hsic_active);
+			ret = PTR_ERR(data->pinctrl_hsic_active);
+			goto err_put;
 		}
 	}
 
@@ -504,10 +510,12 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (pdata.flags & CI_HDRC_PMQOS)
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
+err_put:
+	put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
-static int ci_hdrc_imx_remove(struct platform_device *pdev)
+static void ci_hdrc_imx_remove(struct platform_device *pdev)
 {
 	struct ci_hdrc_imx_data *data = platform_get_drvdata(pdev);
 
@@ -527,8 +535,7 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 		if (data->hsic_pad_regulator)
 			regulator_disable(data->hsic_pad_regulator);
 	}
-
-	return 0;
+	put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
@@ -674,7 +681,7 @@ static const struct dev_pm_ops ci_hdrc_imx_pm_ops = {
 };
 static struct platform_driver ci_hdrc_imx_driver = {
 	.probe = ci_hdrc_imx_probe,
-	.remove = ci_hdrc_imx_remove,
+	.remove_new = ci_hdrc_imx_remove,
 	.shutdown = ci_hdrc_imx_shutdown,
 	.driver = {
 		.name = "imx_usb",
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 9ab40d106ab0..ead891de5e1d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -360,7 +360,7 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 static void acm_ctrl_irq(struct urb *urb)
 {
 	struct acm *acm = urb->context;
-	struct usb_cdc_notification *dr = urb->transfer_buffer;
+	struct usb_cdc_notification *dr;
 	unsigned int current_size = urb->actual_length;
 	unsigned int expected_size, copy_size, alloc_size;
 	int retval;
@@ -387,14 +387,25 @@ static void acm_ctrl_irq(struct urb *urb)
 
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
@@ -1703,13 +1714,16 @@ static const struct usb_device_id acm_ids[] = {
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
index 02922d923b7b..ead112aeb3c3 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1818,6 +1818,17 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
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
@@ -4651,7 +4662,6 @@ void usb_ep0_reinit(struct usb_device *udev)
 EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 
 #define usb_sndaddr0pipe()	(PIPE_CONTROL << 30)
-#define usb_rcvaddr0pipe()	((PIPE_CONTROL << 30) | USB_DIR_IN)
 
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
@@ -4757,7 +4767,7 @@ static int get_bMaxPacketSize0(struct usb_device *udev,
 	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
 		/* Start with invalid values in case the transfer fails */
 		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
-		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
+		rc = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 				USB_DT_DEVICE << 8, 0,
 				buf, size,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 13171454f959..027479179f09 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -432,6 +432,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Sony Xperia XZ1 Compact (lilac) smartphone in fastboot mode */
+	{ USB_DEVICE(0x0fce, 0x0dde), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
@@ -522,6 +525,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Blackmagic Design UltraStudio SDI */
 	{ USB_DEVICE(0x1edb, 0xbd4f), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Teclast disk */
+	{ USB_DEVICE(0x1f75, 0x0917), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Hauppauge HVR-950q */
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 1c8141d80e25..cea6c4fc7995 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4613,6 +4613,7 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	spin_lock_irqsave(&hsotg->lock, flags);
 
 	hsotg->driver = NULL;
+	hsotg->gadget.dev.of_node = NULL;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
 	hsotg->enabled = 0;
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 297e6032bdd1..7f46069c5dc3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1532,8 +1532,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
-	const char		*usb_psy_name;
-	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1566,13 +1564,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev = dwc->dev;
 
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
@@ -1850,6 +1841,23 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
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
@@ -1894,6 +1902,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
+	if (IS_ERR(dwc->usb_psy))
+		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index ed3e27f3cd61..b0bb8edbfef7 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -146,6 +146,7 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 	if (ret)
 		return ret;
 
+	of_node_put(args.np);
 	am62->offset = args.args[0];
 
 	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 489493a0adee..5d9f25715a60 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2485,10 +2485,38 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
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
 		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
@@ -2516,6 +2544,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
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
 
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index fddf539008a9..1d8521103b66 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -999,11 +999,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
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
index c21acebe8aae..3c9541357c24 100644
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
@@ -973,6 +956,7 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 	return;
 
 cleanup:
+	target_put_sess_cmd(se_cmd);
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
@@ -1065,8 +1049,7 @@ static void usbg_cmd_work(struct work_struct *work)
 
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
+			TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
 
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
@@ -1194,8 +1177,7 @@ static void bot_cmd_work(struct work_struct *work)
 
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-				TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
+				TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
 
 static int bot_submit_command(struct f_uas *fu,
@@ -1999,43 +1981,39 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
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
+		uasp_fs_status_desc.bEndpointAddress;
+	uasp_cmd_desc.bEndpointAddress = uasp_fs_cmd_desc.bEndpointAddress;
 
-	uasp_fs_bi_desc.bEndpointAddress = uasp_ss_bi_desc.bEndpointAddress;
-	uasp_fs_bo_desc.bEndpointAddress = uasp_ss_bo_desc.bEndpointAddress;
-	uasp_fs_status_desc.bEndpointAddress =
-		uasp_ss_status_desc.bEndpointAddress;
-	uasp_fs_cmd_desc.bEndpointAddress = uasp_ss_cmd_desc.bEndpointAddress;
+	uasp_ss_bi_desc.bEndpointAddress = uasp_fs_bi_desc.bEndpointAddress;
+	uasp_ss_bo_desc.bEndpointAddress = uasp_fs_bo_desc.bEndpointAddress;
+	uasp_ss_status_desc.bEndpointAddress =
+		uasp_fs_status_desc.bEndpointAddress;
+	uasp_ss_cmd_desc.bEndpointAddress = uasp_fs_cmd_desc.bEndpointAddress;
 
 	ret = usb_assign_descriptors(f, uasp_fs_function_desc,
 			uasp_hs_function_desc, uasp_ss_function_desc,
@@ -2079,9 +2057,14 @@ static void tcm_delayed_set_alt(struct work_struct *wq)
 
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
@@ -2091,6 +2074,9 @@ static int tcm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 {
 	struct f_uas *fu = to_f_uas(f);
 
+	if (fu->iface != intf)
+		return -EOPNOTSUPP;
+
 	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
 		struct guas_setup_wq *work;
 
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 32c9e369216c..0bbdf82f48cd 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -309,7 +309,7 @@ struct renesas_usb3_request {
 	struct list_head	queue;
 };
 
-#define USB3_EP_NAME_SIZE	8
+#define USB3_EP_NAME_SIZE	16
 struct renesas_usb3_ep {
 	struct usb_ep ep;
 	struct renesas_usb3 *usb3;
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 2665832f9add..b96d9062a083 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -946,6 +946,15 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
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
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 2503022a3123..85a2b3ca0507 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -380,7 +380,8 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci);
+		if (cur_cmd)
+			xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index a327f8bc5704..917dffe9aee5 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -354,14 +354,15 @@ usb_role_switch_register(struct device *parent,
 	dev_set_name(&sw->dev, "%s-role-switch",
 		     desc->name ? desc->name : dev_name(parent));
 
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
index 89e6a9afb808..7ca07ba1a139 100644
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
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f649769912e5..86efa3b2208b 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -26,6 +26,7 @@
 #define	VPPS_NEW_MIN_PERCENT			95
 #define	VPPS_VALID_MIN_MV			100
 #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
+#define	VPPS_SHUTDOWN_MIN_PERCENT		85
 
 struct tcpci {
 	struct device *dev;
@@ -336,7 +337,8 @@ static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
 }
 
 static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-						   bool pps_active, u32 requested_vbus_voltage_mv)
+						   bool pps_active, u32 requested_vbus_voltage_mv,
+						   u32 apdo_min_voltage_mv)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
 	unsigned int pwr_ctrl, threshold = 0;
@@ -358,9 +360,12 @@ static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum ty
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
index 013f61bbf28f..4291093f110d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2320,10 +2320,12 @@ static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port,
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
@@ -4114,7 +4116,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->caps_count = 0;
 			port->pd_capable = true;
 			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
-					    PD_T_SEND_SOURCE_CAP);
+					    PD_T_SENDER_RESPONSE);
 		}
 		break;
 	case SRC_SEND_CAPABILITIES_TIMEOUT:
diff --git a/drivers/vfio/iova_bitmap.c b/drivers/vfio/iova_bitmap.c
index dfab5b742191..76ef63b940d9 100644
--- a/drivers/vfio/iova_bitmap.c
+++ b/drivers/vfio/iova_bitmap.c
@@ -126,7 +126,7 @@ struct iova_bitmap {
 static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
 						 unsigned long iova)
 {
-	unsigned long pgsize = 1 << bitmap->mapped.pgshift;
+	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
 
 	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
 }
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index e27de61ac9fe..8191c8fcfb25 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "vfio_pci_priv.h"
 
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index af432b5b11ef..1820ed0f9e01 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -396,6 +396,11 @@ static ssize_t vfio_platform_read_mmio(struct vfio_platform_region *reg,
 
 	count = min_t(size_t, count, reg->size - off);
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
@@ -480,6 +485,11 @@ static ssize_t vfio_platform_write_mmio(struct vfio_platform_region *reg,
 
 	count = min_t(size_t, count, reg->size - off);
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
diff --git a/drivers/video/fbdev/omap/lcd_dma.c b/drivers/video/fbdev/omap/lcd_dma.c
index f85817635a8c..0da23c57e475 100644
--- a/drivers/video/fbdev/omap/lcd_dma.c
+++ b/drivers/video/fbdev/omap/lcd_dma.c
@@ -432,8 +432,8 @@ static int __init omap_init_lcd_dma(void)
 
 	spin_lock_init(&lcd_dma.lock);
 
-	r = request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
-			"LCD DMA", NULL);
+	r = request_threaded_irq(INT_DMA_LCD, NULL, lcd_dma_irq_handler,
+				 IRQF_ONESHOT, "LCD DMA", NULL);
 	if (r != 0)
 		pr_err("unable to request IRQ for LCD DMA (error %d)\n", r);
 
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
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0451e6ebc21a..0893c1012de6 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -74,19 +74,21 @@ static inline phys_addr_t xen_dma_to_phys(struct device *dev,
 	return xen_bus_to_phys(dev, dma_to_phys(dev, dma_addr));
 }
 
+static inline bool range_requires_alignment(phys_addr_t p, size_t size)
+{
+	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
+	phys_addr_t bus_addr = pfn_to_bfn(XEN_PFN_DOWN(p)) << XEN_PAGE_SHIFT;
+
+	return IS_ALIGNED(p, algn) && !IS_ALIGNED(bus_addr, algn);
+}
+
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
-	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
-	/* If buffer is physically aligned, ensure DMA alignment. */
-	if (IS_ALIGNED(p, algn) &&
-	    !IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn))
-		return 1;
-
 	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
@@ -155,7 +157,8 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_handle = xen_phys_to_dma(dev, phys);
 	if (*dma_handle + size - 1 > dma_mask ||
-	    range_straddles_page_boundary(phys, size)) {
+	    range_straddles_page_boundary(phys, size) ||
+	    range_requires_alignment(phys, size)) {
 		if (xen_create_contiguous_region(phys, order, fls64(dma_mask),
 				dma_handle) != 0)
 			goto out_free_pages;
@@ -181,7 +184,8 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	if (WARN_ON_ONCE(dma_handle + size - 1 > dev->coherent_dma_mask) ||
-	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size)))
+	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size) ||
+			 range_requires_alignment(phys, size)))
 	    	return;
 
 	if (TestClearPageXenRemapped(virt_to_page(vaddr)))
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 38d5260c4614..cb537c669a8e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1457,7 +1457,12 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
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
index 11571cca86c1..01f333e691d6 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -655,8 +655,9 @@ static int yfs_deliver_fs_remove_file2(struct afs_call *call)
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
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index cd6d5bbb4b9d..3f740d8abb4f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -478,7 +478,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * 28 bits (256 MB) is way more than reasonable in this case.
 	 * If some top bits are set we have probable binary corruption.
 	*/
-	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
+	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
 		pr_err("bad header\n");
 		ret = -ENOEXEC;
 		goto err;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c8231677c79e..9e06d1a0d373 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -234,7 +234,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (args->drop_cache)
 		btrfs_drop_extent_map_range(inode, args->start, args->end - 1, false);
 
-	if (args->start >= inode->disk_i_size && !args->replace_extent)
+	if (data_race(args->start >= inode->disk_i_size) && !args->replace_extent)
 		modify_tree = 0;
 
 	update_refs = (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID);
@@ -1122,7 +1122,6 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	loff_t pos = iocb->ki_pos;
 	int ret;
 	loff_t oldsize;
-	loff_t start_pos;
 
 	/*
 	 * Quickly bail out on NOWAIT writes if we don't have the nodatacow or
@@ -1147,9 +1146,8 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	 */
 	update_time_for_write(inode);
 
-	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
-	if (start_pos > oldsize) {
+	if (pos > oldsize) {
 		/* Expand hole size to cover write data, preventing empty gap */
 		loff_t end_pos = round_up(pos + count, fs_info->sectorsize);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b2cded5bf69c..a13ab3abef12 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7387,8 +7387,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	if (orig_start)
@@ -11370,6 +11368,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4c6ba97299cd..d6cda0b2e925 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4423,8 +4423,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
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
 
 		btrfs_backref_drop_node_buffer(node);
 		atomic_inc(&cow->refs);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d063379a031d..c0ff0c2fc01d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1468,7 +1468,7 @@ static int btrfs_fill_super(struct super_block *sb,
 
 	err = open_ctree(sb, fs_devices, (char *)data);
 	if (err) {
-		btrfs_err(fs_info, "open_ctree failed");
+		btrfs_err(fs_info, "open_ctree failed: %d", err);
 		return err;
 	}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 604241e6e2c1..ff3e0d4cf4b4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -262,8 +262,10 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
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
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index bde23e156a63..fd71775c703a 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -327,6 +327,8 @@ static void cachefiles_commit_object(struct cachefiles_object *object,
 static void cachefiles_clean_up_object(struct cachefiles_object *object,
 				       struct cachefiles_cache *cache)
 {
+	struct file *file;
+
 	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
 		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 			cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
@@ -342,10 +344,14 @@ static void cachefiles_clean_up_object(struct cachefiles_object *object,
 	}
 
 	cachefiles_unmark_inode_in_use(object, object->file);
-	if (object->file) {
-		fput(object->file);
-		object->file = NULL;
-	}
+
+	spin_lock(&object->lock);
+	file = object->file;
+	object->file = NULL;
+	spin_unlock(&object->lock);
+
+	if (file)
+		fput(file);
 }
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d1a0264b08a6..3389a373faf6 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -61,20 +61,26 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 {
 	struct cachefiles_object *object = kiocb->ki_filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct file *file = object->file;
+	struct file *file;
 	size_t len = iter->count;
 	loff_t pos = kiocb->ki_pos;
 	const struct cred *saved_cred;
 	int ret;
 
-	if (!file)
+	spin_lock(&object->lock);
+	file = object->file;
+	if (!file) {
+		spin_unlock(&object->lock);
 		return -ENOBUFS;
+	}
+	get_file(file);
+	spin_unlock(&object->lock);
 
 	cachefiles_begin_secure(cache, &saved_cred);
 	ret = __cachefiles_prepare_write(object, file, &pos, &len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
@@ -83,6 +89,8 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		kiocb->ki_pos += ret;
 	}
 
+out:
+	fput(file);
 	return ret;
 }
 
@@ -90,12 +98,22 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 					    int whence)
 {
 	struct cachefiles_object *object = filp->private_data;
-	struct file *file = object->file;
+	struct file *file;
+	loff_t ret;
 
-	if (!file)
+	spin_lock(&object->lock);
+	file = object->file;
+	if (!file) {
+		spin_unlock(&object->lock);
 		return -ENOBUFS;
+	}
+	get_file(file);
+	spin_unlock(&object->lock);
 
-	return vfs_llseek(file, pos, whence);
+	ret = vfs_llseek(file, pos, whence);
+	fput(file);
+
+	return ret;
 }
 
 static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
diff --git a/fs/exec.c b/fs/exec.c
index a42c9b8b070d..2039414cc662 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1362,7 +1362,28 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If the original filename was empty, alloc_bprm() made up a path
+	 * that will probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->comm_from_dentry) {
+		/*
+		 * Hold RCU lock to keep the name from being freed behind our back.
+		 * Use acquire semantics to make sure the terminating NUL from
+		 * __d_alloc() is seen.
+		 *
+		 * Note, we're deliberately sloppy here. We don't need to care about
+		 * detecting a concurrent rename and just want a terminated name.
+		 */
+		rcu_read_lock();
+		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
+				true);
+		rcu_read_unlock();
+	} else {
+		__set_task_comm(me, kbasename(bprm->filename), true);
+	}
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1521,11 +1542,13 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
-		if (filename->name[0] == '\0')
+		if (filename->name[0] == '\0') {
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
-		else
+			bprm->comm_from_dentry = 1;
+		} else {
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
 						  fd, filename->name);
+		}
 		if (!bprm->fdpath)
 			goto out_free;
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8f1860a4b1fb..29ac1e77b5d7 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -199,7 +199,8 @@ static unsigned long dir_block_index(unsigned int level,
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct page *dentry_page,
 				const struct f2fs_filename *fname,
-				int *max_slots)
+				int *max_slots,
+				bool use_hash)
 {
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
@@ -207,7 +208,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	return f2fs_find_target_dentry(&d, fname, max_slots);
+	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
@@ -284,7 +285,8 @@ static inline int f2fs_match_name(const struct inode *dir,
 }
 
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots)
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
@@ -307,7 +309,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
-		if (de->hash_code == fname->hash) {
+		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
 					      le16_to_cpu(de->name_len));
@@ -334,11 +336,12 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
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
@@ -348,8 +351,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
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
@@ -366,7 +372,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots);
+		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			*res_page = ERR_CAST(de);
 			de = NULL;
@@ -383,12 +389,18 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
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
@@ -399,11 +411,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
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
 
@@ -419,11 +435,18 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
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
index ad3e169b56a0..840a45855451 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3487,7 +3487,8 @@ int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
 			struct f2fs_filename *fname);
 void f2fs_free_filename(struct f2fs_filename *fname);
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots);
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
@@ -4100,7 +4101,8 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page);
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page);
+					struct page **res_page,
+					bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3bab52d33e80..5e2a0cb8d24d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1048,6 +1048,13 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				return err;
 		}
 
+		/*
+		 * wait for inflight dio, blocks should be removed after
+		 * IO completion.
+		 */
+		if (attr->ia_size < old_size)
+			inode_dio_wait(inode);
+
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -1880,6 +1887,12 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (ret)
 		goto out;
 
+	/*
+	 * wait for inflight dio, blocks should be removed after IO
+	 * completion.
+	 */
+	inode_dio_wait(inode);
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7a2fb9789e5e..33f54e5fd780 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -336,7 +336,8 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
@@ -353,7 +354,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	inline_dentry = inline_data_addr(dir, ipage);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = f2fs_find_target_dentry(&d, fname, NULL);
+	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
 	unlock_page(ipage);
 	if (IS_ERR(de)) {
 		*res_page = ERR_CAST(de);
diff --git a/fs/file_table.c b/fs/file_table.c
index dd88701e54a9..cecc866871bc 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -110,7 +110,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.data		= &sysctl_nr_open,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_douintvec_minmax,
 		.extra1		= &sysctl_nr_open_min,
 		.extra2		= &sysctl_nr_open_max,
 	},
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 4376881be791..8056b05bd8dc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -839,6 +839,9 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs4_pnfs_ds *ds;
 	u32 ds_idx;
 
+	if (NFS_SERVER(pgio->pg_inode)->flags &
+			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
+		pgio->pg_maxretrans = io_maxretrans;
 retry:
 	ff_layout_pg_check_layout(pgio, req);
 	/* Use full layout for now */
@@ -852,6 +855,8 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 		if (!pgio->pg_lseg)
 			goto out_nolseg;
 	}
+	/* Reset wb_nio, since getting layout segment was successful */
+	req->wb_nio = 0;
 
 	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
 	if (!ds) {
@@ -868,14 +873,24 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
 
 	pgio->pg_mirror_idx = ds_idx;
-
-	if (NFS_SERVER(pgio->pg_inode)->flags &
-			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
-		pgio->pg_maxretrans = io_maxretrans;
 	return;
 out_nolseg:
-	if (pgio->pg_error < 0)
-		return;
+	if (pgio->pg_error < 0) {
+		if (pgio->pg_error != -EAGAIN)
+			return;
+		/* Retry getting layout segment if lower layer returned -EAGAIN */
+		if (pgio->pg_maxretrans && req->wb_nio++ > pgio->pg_maxretrans) {
+			if (NFS_SERVER(pgio->pg_inode)->flags & NFS_MOUNT_SOFTERR)
+				pgio->pg_error = -ETIMEDOUT;
+			else
+				pgio->pg_error = -EIO;
+			return;
+		}
+		pgio->pg_error = 0;
+		/* Sleep for 1 second before retrying */
+		ssleep(1);
+		goto retry;
+	}
 out_mds:
 	trace_pnfs_mds_fallback_pg_init_read(pgio->pg_inode,
 			0, NFS4_MAX_UINT64, IOMODE_READ,
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 89c32a963dd1..923ccd3b540f 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -551,7 +551,7 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 		.rpc_message = &msg,
 		.callback_ops = &nfs42_offload_cancel_ops,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
 	};
 	int status;
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 20aa5e746497..fd51fd1cf5ff 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -129,9 +129,11 @@
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
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 65d4511b7af0..6c4fe9409611 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -84,6 +84,8 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index a34a22e272ad..e6bb621f1ffd 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -76,6 +76,8 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d2885dd4822d..272d3facfff9 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1202,6 +1202,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = false;
 		break;
 	case -NFS4ERR_DELAY:
+		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
 
@@ -1409,8 +1410,11 @@ nfsd4_run_cb_work(struct work_struct *work)
 		nfsd4_process_cb_update(cb);
 
 	clnt = clp->cl_cb_client;
-	if (!clnt) {
-		/* Callback channel broken, or client killed; give up: */
+	if (!clnt || clp->cl_state == NFSD4_COURTESY) {
+		/*
+		 * Callback channel broken, client killed or
+		 * nfs4_client in courtesy state; give up.
+		 */
 		nfsd41_destroy_cb(cb);
 		return;
 	}
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 072998626155..452fb23d2e4c 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -162,7 +162,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping, false);
+		nilfs_clear_dirty_pages(mapping);
 		return -EROFS;
 	}
 
@@ -185,7 +185,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -1267,7 +1267,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			if (size) {
 				if (phys && blkphy << blkbits == phys + size) {
 					/* The current extent goes on */
-					size += n << blkbits;
+					size += (u64)n << blkbits;
 				} else {
 					/* Terminate the current extent */
 					ret = fiemap_fill_next_extent(
@@ -1280,14 +1280,14 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
index d0808953296a..233954e22448 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -411,7 +411,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -634,10 +634,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
 	if (mi->mi_palloc_cache)
 		nilfs_palloc_clear_cache(inode);
 
-	nilfs_clear_dirty_pages(inode->i_mapping, true);
+	nilfs_clear_dirty_pages(inode->i_mapping);
 	nilfs_copy_back_pages(inode->i_mapping, shadow->inode->i_mapping);
 
-	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
+	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping);
 	nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
 			      NILFS_I(shadow->inode)->i_assoc_inode->i_mapping);
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index b4e2192e8796..bf090240f6ed 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -354,9 +354,8 @@ void nilfs_copy_back_pages(struct address_space *dmap,
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
@@ -377,7 +376,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(page->mapping == mapping))
-				nilfs_clear_dirty_page(page, silent);
+				nilfs_clear_dirty_page(page);
 
 			unlock_page(page);
 		}
@@ -389,44 +388,54 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
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
index 21ddcdd4d63e..f5432f6a2fb6 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
-void nilfs_clear_dirty_pages(struct address_space *, bool);
+void nilfs_clear_dirty_page(struct page *page);
+void nilfs_clear_dirty_pages(struct address_space *mapping);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6bc8ad0d41f8..af4ab80443fe 100644
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
index d27e15b54be4..de6fd4a09ffd 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1065,26 +1065,39 @@ int ocfs2_find_entry(const char *name, int namelen,
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
@@ -2011,6 +2024,7 @@ int ocfs2_lookup_ino_from_name(struct inode *dir, const char *name,
  *
  * Return 0 if the name does not exist
  * Return -EEXIST if the directory contains the name
+ * Return -EFSCORRUPTED if found corruption
  *
  * Callers should have i_rwsem + a cluster lock on dir
  */
@@ -2024,9 +2038,12 @@ int ocfs2_check_dir_for_entry(struct inode *dir,
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
index 0dffd6a44d39..24b031dc44ee 100644
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
index b39eff78ca48..8f7bb76d9cde 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2342,7 +2342,7 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			mlog(ML_ERROR, "found superblock with incorrect block "
 			     "size bits: found %u, should be 9, 10, 11, or 12\n",
 			     blksz_bits);
-		} else if ((1 << le32_to_cpu(blksz_bits)) != blksz) {
+		} else if ((1 << blksz_bits) != blksz) {
 			mlog(ML_ERROR, "found superblock with incorrect block "
 			     "size: found %u, should be %u\n", 1 << blksz_bits, blksz);
 		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index d4c5fdcfa1e4..f5cf2255dc09 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -65,7 +65,7 @@ static int ocfs2_fast_symlink_read_folio(struct file *f, struct folio *folio)
 
 	if (status < 0) {
 		mlog_errno(status);
-		return status;
+		goto out;
 	}
 
 	fe = (struct ocfs2_dinode *) bh->b_data;
@@ -76,9 +76,10 @@ static int ocfs2_fast_symlink_read_folio(struct file *f, struct folio *folio)
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
diff --git a/fs/proc/array.c b/fs/proc/array.c
index d210b2f8b7ed..86fde69ec11a 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -490,7 +490,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		 * a program is not able to use ptrace(2) in that case. It is
 		 * safe because the task has stopped executing permanently.
 		 */
-		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
+		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE|PF_POSTCOREDUMP))) {
 			if (try_get_task_stack(task)) {
 				eip = KSTK_EIP(task);
 				esp = KSTK_ESP(task);
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 4ae0cfcd15f2..c6911c999762 100644
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
index d4d881d439dc..3f730b8581f6 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -788,7 +788,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
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
 
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1d19c9e75277..71e519bf65e2 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -286,7 +286,7 @@ struct smb_version_operations {
 	int (*handle_cancelled_mid)(struct mid_q_entry *, struct TCP_Server_Info *);
 	void (*downgrade_oplock)(struct TCP_Server_Info *server,
 				 struct cifsInodeInfo *cinode, __u32 oplock,
-				 unsigned int epoch, bool *purge_cache);
+				 __u16 epoch, bool *purge_cache);
 	/* process transaction2 response */
 	bool (*check_trans2)(struct mid_q_entry *, struct TCP_Server_Info *,
 			     char *, int);
@@ -466,12 +466,12 @@ struct smb_version_operations {
 	/* if we can do cache read operations */
 	bool (*is_read_op)(__u32);
 	/* set oplock level for the inode */
-	void (*set_oplock_level)(struct cifsInodeInfo *, __u32, unsigned int,
-				 bool *);
+	void (*set_oplock_level)(struct cifsInodeInfo *cinode, __u32 oplock, __u16 epoch,
+				 bool *purge_cache);
 	/* create lease context buffer for CREATE request */
 	char * (*create_lease_buf)(u8 *lease_key, u8 oplock);
 	/* parse lease context buffer and return oplock/epoch info */
-	__u8 (*parse_lease_buf)(void *buf, unsigned int *epoch, char *lkey);
+	__u8 (*parse_lease_buf)(void *buf, __u16 *epoch, char *lkey);
 	ssize_t (*copychunk_range)(const unsigned int,
 			struct cifsFileInfo *src_file,
 			struct cifsFileInfo *target_file,
@@ -1328,7 +1328,7 @@ struct cifs_fid {
 	__u8 create_guid[16];
 	__u32 access;
 	struct cifs_pending_open *pending_open;
-	unsigned int epoch;
+	__u16 epoch;
 #ifdef CONFIG_CIFS_DEBUG2
 	__u64 mid;
 #endif /* CIFS_DEBUG2 */
@@ -1360,7 +1360,7 @@ struct cifsFileInfo {
 	bool swapfile:1;
 	bool oplock_break_cancelled:1;
 	bool offload:1; /* offload final part of _put to a wq */
-	unsigned int oplock_epoch; /* epoch from the lease break */
+	__u16 oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
 	spinlock_t file_info_lock; /* protects four flag/count fields above */
@@ -1510,7 +1510,7 @@ struct cifsInodeInfo {
 	spinlock_t	open_file_lock;	/* protects openFileList */
 	__u32 cifsAttrs; /* e.g. DOS archive bit, sparse, compressed, system */
 	unsigned int oplock;		/* oplock/lease level we have */
-	unsigned int epoch;		/* used to track lease state changes */
+	__u16 epoch;		/* used to track lease state changes */
 #define CIFS_INODE_PENDING_OPLOCK_BREAK   (0) /* oplock break in progress */
 #define CIFS_INODE_PENDING_WRITERS	  (1) /* Writes in progress */
 #define CIFS_INODE_FLAG_UNUSED		  (2) /* Unused flag */
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 96c0d2682ba2..225cc7e0304c 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -377,7 +377,7 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
 static void
 cifs_downgrade_oplock(struct TCP_Server_Info *server,
 		      struct cifsInodeInfo *cinode, __u32 oplock,
-		      unsigned int epoch, bool *purge_cache)
+		      __u16 epoch, bool *purge_cache)
 {
 	cifs_set_oplock_level(cinode, oplock);
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4b9cd9893ac6..5af8bf391d87 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -615,7 +615,8 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 
 	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		memset(&tmp_iface, 0, sizeof(tmp_iface));
-		tmp_iface.speed = le64_to_cpu(p->LinkSpeed);
+		/* default to 1Gbps when link speed is unset */
+		tmp_iface.speed = le64_to_cpu(p->LinkSpeed) ?: 1000000000;
 		tmp_iface.rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
 		tmp_iface.rss_capable = le32_to_cpu(p->Capability & RSS_CAPABLE) ? 1 : 0;
 
@@ -4110,22 +4111,22 @@ static long smb3_fallocate(struct file *file, struct cifs_tcon *tcon, int mode,
 static void
 smb2_downgrade_oplock(struct TCP_Server_Info *server,
 		      struct cifsInodeInfo *cinode, __u32 oplock,
-		      unsigned int epoch, bool *purge_cache)
+		      __u16 epoch, bool *purge_cache)
 {
 	server->ops->set_oplock_level(cinode, oplock, 0, NULL);
 }
 
 static void
 smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
-		       unsigned int epoch, bool *purge_cache);
+		       __u16 epoch, bool *purge_cache);
 
 static void
 smb3_downgrade_oplock(struct TCP_Server_Info *server,
 		       struct cifsInodeInfo *cinode, __u32 oplock,
-		       unsigned int epoch, bool *purge_cache)
+		       __u16 epoch, bool *purge_cache)
 {
 	unsigned int old_state = cinode->oplock;
-	unsigned int old_epoch = cinode->epoch;
+	__u16 old_epoch = cinode->epoch;
 	unsigned int new_state;
 
 	if (epoch > old_epoch) {
@@ -4145,7 +4146,7 @@ smb3_downgrade_oplock(struct TCP_Server_Info *server,
 
 static void
 smb2_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
-		      unsigned int epoch, bool *purge_cache)
+		      __u16 epoch, bool *purge_cache)
 {
 	oplock &= 0xFF;
 	cinode->lease_granted = false;
@@ -4169,7 +4170,7 @@ smb2_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 
 static void
 smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
-		       unsigned int epoch, bool *purge_cache)
+		       __u16 epoch, bool *purge_cache)
 {
 	char message[5] = {0};
 	unsigned int new_oplock = 0;
@@ -4206,7 +4207,7 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 
 static void
 smb3_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
-		      unsigned int epoch, bool *purge_cache)
+		      __u16 epoch, bool *purge_cache)
 {
 	unsigned int old_oplock = cinode->oplock;
 
@@ -4320,7 +4321,7 @@ smb3_create_lease_buf(u8 *lease_key, u8 oplock)
 }
 
 static __u8
-smb2_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
+smb2_parse_lease_buf(void *buf, __u16 *epoch, char *lease_key)
 {
 	struct create_lease *lc = (struct create_lease *)buf;
 
@@ -4331,7 +4332,7 @@ smb2_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 }
 
 static __u8
-smb3_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
+smb3_parse_lease_buf(void *buf, __u16 *epoch, char *lease_key)
 {
 	struct create_lease_v2 *lc = (struct create_lease_v2 *)buf;
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index bfe7b03307d4..217d381eb9fe 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2158,7 +2158,7 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 
 int smb2_parse_contexts(struct TCP_Server_Info *server,
 			struct kvec *rsp_iov,
-			unsigned int *epoch,
+			__u16 *epoch,
 			char *lease_key, __u8 *oplock,
 			struct smb2_file_all_info *buf,
 			struct create_posix_rsp *posix)
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index b325fde010ad..79e5e7764c3d 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -251,7 +251,7 @@ extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
 int smb2_parse_contexts(struct TCP_Server_Info *server,
 			struct kvec *rsp_iov,
-			unsigned int *epoch,
+			__u16 *epoch,
 			char *lease_key, __u8 *oplock,
 			struct smb2_file_all_info *buf,
 			struct create_posix_rsp *posix);
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 8752ac82c557..496855f755ac 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -567,6 +567,9 @@ ksmbd_ipc_spnego_authen_request(const char *spnego_blob, int blob_len)
 	struct ksmbd_spnego_authen_request *req;
 	struct ksmbd_spnego_authen_response *resp;
 
+	if (blob_len > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_spnego_authen_request) +
 			blob_len + 1);
 	if (!msg)
@@ -746,6 +749,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	struct ksmbd_rpc_command *req;
 	struct ksmbd_rpc_command *resp;
 
+	if (payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
 	if (!msg)
 		return NULL;
@@ -794,6 +800,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	struct ksmbd_rpc_command *req;
 	struct ksmbd_rpc_command *resp;
 
+	if (payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+		return NULL;
+
 	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
 	if (!msg)
 		return NULL;
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 3f128b9fdfbb..9613725ed193 100644
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
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index dc84c75be852..26961b0dae03 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1726,8 +1726,11 @@ xfs_inactive(
 		goto out;
 
 	/* Try to clean out the cow blocks if there are any. */
-	if (xfs_inode_has_cow_data(ip))
-		xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
+	if (xfs_inode_has_cow_data(ip)) {
+		error = xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
+		if (error)
+			goto out;
+	}
 
 	if (VFS_I(ip)->i_nlink != 0) {
 		/*
diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index b77673dd0558..26b2c449f3c6 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -19,28 +19,41 @@
 STATIC void
 xfs_fill_statvfs_from_dquot(
 	struct kstatfs		*statp,
+	struct xfs_inode	*ip,
 	struct xfs_dquot	*dqp)
 {
+	struct xfs_dquot_res	*blkres = &dqp->q_blk;
 	uint64_t		limit;
 
-	limit = dqp->q_blk.softlimit ?
-		dqp->q_blk.softlimit :
-		dqp->q_blk.hardlimit;
-	if (limit && statp->f_blocks > limit) {
-		statp->f_blocks = limit;
-		statp->f_bfree = statp->f_bavail =
-			(statp->f_blocks > dqp->q_blk.reserved) ?
-			 (statp->f_blocks - dqp->q_blk.reserved) : 0;
+	if (XFS_IS_REALTIME_MOUNT(ip->i_mount) &&
+	    (ip->i_diflags & (XFS_DIFLAG_RTINHERIT | XFS_DIFLAG_REALTIME)))
+		blkres = &dqp->q_rtb;
+
+	limit = blkres->softlimit ?
+		blkres->softlimit :
+		blkres->hardlimit;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > blkres->reserved)
+			remaining = limit - blkres->reserved;
+
+		statp->f_blocks = min(statp->f_blocks, limit);
+		statp->f_bfree = min(statp->f_bfree, remaining);
+		statp->f_bavail = min(statp->f_bavail, remaining);
 	}
 
 	limit = dqp->q_ino.softlimit ?
 		dqp->q_ino.softlimit :
 		dqp->q_ino.hardlimit;
-	if (limit && statp->f_files > limit) {
-		statp->f_files = limit;
-		statp->f_ffree =
-			(statp->f_files > dqp->q_ino.reserved) ?
-			 (statp->f_files - dqp->q_ino.reserved) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dqp->q_ino.reserved)
+			remaining = limit - dqp->q_ino.reserved;
+
+		statp->f_files = min(statp->f_files, limit);
+		statp->f_ffree = min(statp->f_ffree, remaining);
 	}
 }
 
@@ -61,7 +74,7 @@ xfs_qm_statvfs(
 	struct xfs_dquot	*dqp;
 
 	if (!xfs_qm_dqget(mp, ip->i_projid, XFS_DQTYPE_PROJ, false, &dqp)) {
-		xfs_fill_statvfs_from_dquot(statp, dqp);
+		xfs_fill_statvfs_from_dquot(statp, ip, dqp);
 		xfs_qm_dqput(dqp);
 	}
 }
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1c143c69da6e..2ef331132fca 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -849,12 +849,6 @@ xfs_fs_statfs(
 	ffree = statp->f_files - (icount - ifree);
 	statp->f_ffree = max_t(int64_t, ffree, 0);
 
-
-	if ((ip->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
-	    ((mp->m_qflags & (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))) ==
-			      (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))
-		xfs_qm_statvfs(ip, statp);
-
 	if (XFS_IS_REALTIME_MOUNT(mp) &&
 	    (ip->i_diflags & (XFS_DIFLAG_RTINHERIT | XFS_DIFLAG_REALTIME))) {
 		s64	freertx;
@@ -864,6 +858,11 @@ xfs_fs_statfs(
 		statp->f_bavail = statp->f_bfree = freertx * sbp->sb_rextsize;
 	}
 
+	if ((ip->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
+	    ((mp->m_qflags & (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))) ==
+			      (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))
+		xfs_qm_statvfs(ip, statp);
+
 	return 0;
 }
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8d51f69f9f5e..af9056d78fad 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -42,7 +42,9 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+		/* Set when "comm" must come from the dentry. */
+		comm_from_dentry:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index be8980b02355..6ab81c06afbc 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -71,9 +71,6 @@ enum {
 
 	/* Cgroup is frozen. */
 	CGRP_FROZEN,
-
-	/* Control group has to be killed. */
-	CGRP_KILL,
 };
 
 /* cgroup_root->flags */
@@ -424,6 +421,9 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
+	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	unsigned int kill_seq;
+
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
 	struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a849b533be5b..1d73c77051c0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -125,6 +125,7 @@ typedef	struct {
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
 #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
 #define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
+#define EFI_MEMORY_HOT_PLUGGABLE	BIT_ULL(20)	/* supports unplugging at runtime */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
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
 
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 160230bb1a9c..8e00918b15b4 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4571,28 +4571,24 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
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
@@ -4645,8 +4641,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, u8 len)
 		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
-		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
-			common += ETH_ALEN;
+		common = ETH_ALEN + 1;
 		break;
 	default:
 		/* we don't know this type */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9d87090953bc..2bfa9611be67 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -999,7 +999,7 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 0cd33be7142a..6d10bd2b9e0f 100644
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
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 637a60607c7d..66aaf8915277 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -879,6 +879,15 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
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
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index fecc2fa2a364..aad9c6b50463 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -17,20 +17,19 @@
 struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
-extern struct regmap *device_node_to_regmap(struct device_node *np);
-extern struct regmap *syscon_node_to_regmap(struct device_node *np);
-extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
-extern struct regmap *syscon_regmap_lookup_by_phandle(
-					struct device_node *np,
-					const char *property);
-extern struct regmap *syscon_regmap_lookup_by_phandle_args(
-					struct device_node *np,
-					const char *property,
-					int arg_count,
-					unsigned int *out_args);
-extern struct regmap *syscon_regmap_lookup_by_phandle_optional(
-					struct device_node *np,
-					const char *property);
+struct regmap *device_node_to_regmap(struct device_node *np);
+struct regmap *syscon_node_to_regmap(struct device_node *np);
+struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
+struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
+					       const char *property);
+struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
+						    const char *property,
+						    int arg_count,
+						    unsigned int *out_args);
+struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
+							const char *property);
+int of_syscon_register_regmap(struct device_node *np,
+			      struct regmap *regmap);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -70,6 +69,12 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
 	return NULL;
 }
 
+static inline int of_syscon_register_regmap(struct device_node *np,
+					struct regmap *regmap)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 2588ddd3512b..3c3e0f26c244 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -716,7 +716,6 @@ struct mlx5_timer {
 	struct timecounter         tc;
 	u32                        nominal_c_mult;
 	unsigned long              overflow_period;
-	struct delayed_work        overflow_work;
 };
 
 struct mlx5_clock {
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 662183994e88..d0b4920dee73 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2177,7 +2177,7 @@ struct net_device {
 	void 			*atalk_ptr;
 #endif
 #if IS_ENABLED(CONFIG_AX25)
-	void			*ax25_ptr;
+	struct ax25_dev	__rcu	*ax25_ptr;
 #endif
 #if IS_ENABLED(CONFIG_CFG80211)
 	struct wireless_dev	*ieee80211_ptr;
@@ -2538,6 +2538,12 @@ struct net *dev_net(const struct net_device *dev)
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
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69b8c46a42ea..9d7fb137bd93 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1754,6 +1754,10 @@
 #define PCI_SUBDEVICE_ID_AT_2700FX	0x2701
 #define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
 
+#define PCI_VENDOR_ID_ASIX		0x125b
+#define PCI_DEVICE_ID_ASIX_AX99100	0x9100
+#define PCI_DEVICE_ID_ASIX_AX99100_LB	0x9110
+
 #define PCI_VENDOR_ID_ESS		0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
 #define PCI_DEVICE_ID_ESS_ESS1978	0x1978
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb5890792..91f87d7e807c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -103,7 +103,7 @@ int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *su
 
 unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
-unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
@@ -121,17 +121,29 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
+
+struct dev_pm_opp *
+dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
+				   u32 index, bool available);
+
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_floor_indexed(struct device *dev,
+						      unsigned long *freq, u32 index);
+
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
+					     unsigned long *freq);
+
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_indexed(struct device *dev,
+						     unsigned long *freq, u32 index);
+
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
+
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level);
 
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
-					     unsigned long *freq);
-
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					   unsigned int *bw, int index);
 
@@ -200,7 +212,7 @@ static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
 	return 0;
 }
 
-static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
+static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
 {
 	return 0;
 }
@@ -247,26 +259,27 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
-					unsigned int level)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
+					unsigned long freq, bool available)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
-					unsigned int *level)
+static inline struct dev_pm_opp *
+dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
+				   u32 index, bool available)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
-					unsigned long freq, bool available)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
+					unsigned long *freq)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
-					unsigned long *freq)
+static inline struct dev_pm_opp *
+dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq, u32 index)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -277,6 +290,24 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *
+dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq, u32 index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					unsigned int level)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					unsigned int *level)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					unsigned int *bw, int index)
 {
@@ -631,4 +662,9 @@ static inline void dev_pm_opp_put_prop_name(int token)
 	dev_pm_opp_clear_config(token);
 }
 
+static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_freq_indexed(opp, 0);
+}
+
 #endif		/* __LINUX_OPP_H__ */
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e87a68b136da..4dc764f3d26f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -888,9 +888,7 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
-#ifdef CONFIG_PSI
-	unsigned			sched_psi_wake_requeue:1;
-#endif
+	unsigned			sched_task_hot:1;
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index aaa25ed1a8fe..00135a8d5773 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -38,6 +38,7 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned int kill_seq;
 };
 
 /*
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index bffc8d3e14ad..0af213187e9f 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -145,7 +145,8 @@ struct tcpc_dev {
 	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
 	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
 	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-						 bool pps_active, u32 requested_vbus_voltage);
+						 bool pps_active, u32 requested_vbus_voltage,
+						 u32 pps_apdo_min_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
 };
diff --git a/include/net/ax25.h b/include/net/ax25.h
index 1d55e8ee08b4..e9465aa07a4e 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -229,6 +229,7 @@ typedef struct ax25_dev {
 #endif
 	refcount_t		refcount;
 	bool device_up;
+	struct rcu_head		rcu;
 } ax25_dev;
 
 typedef struct ax25_cb {
@@ -291,9 +292,8 @@ static inline void ax25_dev_hold(ax25_dev *ax25_dev)
 
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
@@ -336,9 +336,9 @@ void ax25_digi_invert(const ax25_digi *, ax25_digi *);
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
diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index 031c661aa14d..bdfa9d414360 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -198,10 +198,12 @@ struct sk_buff *l3mdev_l3_out(struct sock *sk, struct sk_buff *skb, u16 proto)
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
index 17c7a8841834..ee50d5493662 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -353,21 +353,30 @@ static inline void put_net_track(struct net *net, netns_tracker *tracker)
 
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
diff --git a/include/net/route.h b/include/net/route.h
index af8431b25f80..f39617602237 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -362,10 +362,15 @@ static inline int inet_iif(const struct sk_buff *skb)
 static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-	struct net *net = dev_net(dst->dev);
 
-	if (hoplimit == 0)
+	if (hoplimit == 0) {
+		const struct net *net;
+
+		rcu_read_lock();
+		net = dev_net_rcu(dst->dev);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
+		rcu_read_unlock();
+	}
 	return hoplimit;
 }
 
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 743acbc43c85..80f657bf2e04 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -817,7 +817,7 @@ static inline int qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 }
 
 static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
-				  __u64 bytes, __u32 packets)
+				  __u64 bytes, __u64 packets)
 {
 	u64_stats_update_begin(&bstats->syncp);
 	u64_stats_add(&bstats->bytes, bytes);
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 9eb75683e012..cb2920c601e7 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,6 +14,7 @@
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <linux/bug.h>
+#include <linux/sched.h>
 
 #ifdef CONFIG_RV_REACTORS
 
@@ -324,10 +325,13 @@ static inline struct da_monitor *da_get_monitor_##name(struct task_struct *tsk)
 static void da_monitor_reset_all_##name(void)							\
 {												\
 	struct task_struct *g, *p;								\
+	int cpu;										\
 												\
 	read_lock(&tasklist_lock);								\
 	for_each_process_thread(g, p)								\
 		da_monitor_reset_##name(da_get_monitor_##name(p));				\
+	for_each_present_cpu(cpu)								\
+		da_monitor_reset_##name(da_get_monitor_##name(idle_task(cpu)));			\
 	read_unlock(&tasklist_lock);								\
 }												\
 												\
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 1ce8a91349e9..f410c22e080d 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -519,6 +519,7 @@
 #define KEY_NOTIFICATION_CENTER	0x1bc	/* Show/hide the notification center */
 #define KEY_PICKUP_PHONE	0x1bd	/* Answer incoming call */
 #define KEY_HANGUP_PHONE	0x1be	/* Decline incoming call */
+#define KEY_LINK_PHONE		0x1bf   /* AL Phone Syncing */
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fead2ce..2a4a6b7b77bb 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -347,8 +347,8 @@ enum {
 
 /* Possible values for dExtendedUFSFeaturesSupport */
 enum {
-	UFS_DEV_LOW_TEMP_NOTIF		= BIT(4),
-	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(5),
+	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(4),
+	UFS_DEV_LOW_TEMP_NOTIF		= BIT(5),
 	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 64502323be5e..33597284e1cb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1624,6 +1624,7 @@ bool io_alloc_async_data(struct io_kiocb *req)
 int io_req_prep_async(struct io_kiocb *req)
 {
 	const struct io_op_def *def = &io_op_defs[req->opcode];
+	int ret;
 
 	/* assign early for deferred execution for non-fixed file */
 	if (def->needs_file && !(req->flags & REQ_F_FIXED_FILE) && !req->file)
@@ -1636,7 +1637,9 @@ int io_req_prep_async(struct io_kiocb *req)
 		if (io_alloc_async_data(req))
 			return -EAGAIN;
 	}
-	return def->prep_async(req);
+	ret = def->prep_async(req);
+	io_kbuf_recycle(req, 0);
+	return ret;
 }
 
 static u32 io_get_sequence(struct io_kiocb *req)
diff --git a/io_uring/net.c b/io_uring/net.c
index f41acabf7b4a..dc7c1e44ec47 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1486,6 +1486,11 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 		io = &__io;
 	}
 
+	if (unlikely(req->flags & REQ_F_FAIL)) {
+		ret = -ECONNRESET;
+		goto out;
+	}
+
 	file_flags = force_nonblock ? O_NONBLOCK : 0;
 
 	ret = __sys_connect_file(req->file, &io->address,
diff --git a/io_uring/poll.c b/io_uring/poll.c
index a4084acaff91..bbdc9a7624a1 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -288,6 +288,8 @@ static int io_poll_check_events(struct io_kiocb *req, bool *locked)
 				return IOU_POLL_REISSUE;
 			}
 		}
+		if (unlikely(req->cqe.res & EPOLLERR))
+			req_set_fail(req);
 		if (req->apoll_events & EPOLLONESHOT)
 			return IOU_POLL_DONE;
 		if (io_is_uring_fops(req->file))
@@ -305,6 +307,8 @@ static int io_poll_check_events(struct io_kiocb *req, bool *locked)
 			}
 		} else {
 			int ret = io_poll_issue(req, locked);
+			io_kbuf_recycle(req, 0);
+
 			if (ret == IOU_STOP_MULTISHOT)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			if (ret < 0)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 692663bd864f..b75f62dccce6 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -772,6 +772,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 			goto done;
 		ret = 0;
 	} else if (ret == -EIOCBQUEUED) {
+		req->flags |= REQ_F_PARTIAL_IO;
+		io_kbuf_recycle(req, issue_flags);
 		if (iovec)
 			kfree(iovec);
 		return IOU_ISSUE_SKIP_COMPLETE;
@@ -795,6 +797,9 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 		goto done;
 	}
 
+	req->flags |= REQ_F_PARTIAL_IO;
+	io_kbuf_recycle(req, issue_flags);
+
 	io = req->async_data;
 	s = &io->s;
 	/*
@@ -935,6 +940,11 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	else
 		ret2 = -EINVAL;
 
+	if (ret2 == -EIOCBQUEUED) {
+		req->flags |= REQ_F_PARTIAL_IO;
+		io_kbuf_recycle(req, issue_flags);
+	}
+
 	if (req->flags & REQ_F_REISSUE) {
 		req->flags &= ~REQ_F_REISSUE;
 		ret2 = -EAGAIN;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 72ad4de66d10..6e54f0daebef 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3952,7 +3952,7 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
-	set_bit(CGRP_KILL, &cgrp->flags);
+	cgrp->kill_seq++;
 	spin_unlock_irq(&css_set_lock);
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
@@ -3968,10 +3968,6 @@ static void __cgroup_kill(struct cgroup *cgrp)
 		send_sig(SIGKILL, task, 0);
 	}
 	css_task_iter_end(&it);
-
-	spin_lock_irq(&css_set_lock);
-	clear_bit(CGRP_KILL, &cgrp->flags);
-	spin_unlock_irq(&css_set_lock);
 }
 
 static void cgroup_kill(struct cgroup *cgrp)
@@ -6409,6 +6405,10 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
+	if (kargs->cgrp)
+		kargs->kill_seq = kargs->cgrp->kill_seq;
+	else
+		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6592,6 +6592,7 @@ void cgroup_post_fork(struct task_struct *child,
 		      struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	unsigned int cgrp_kill_seq = 0;
 	unsigned long cgrp_flags = 0;
 	bool kill = false;
 	struct cgroup_subsys *ss;
@@ -6605,10 +6606,13 @@ void cgroup_post_fork(struct task_struct *child,
 
 	/* init tasks are special, only link regular threads */
 	if (likely(child->pid)) {
-		if (kargs->cgrp)
+		if (kargs->cgrp) {
 			cgrp_flags = kargs->cgrp->flags;
-		else
+			cgrp_kill_seq = kargs->cgrp->kill_seq;
+		} else {
 			cgrp_flags = cset->dfl_cgrp->flags;
+			cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+		}
 
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
@@ -6643,7 +6647,7 @@ void cgroup_post_fork(struct task_struct *child,
 		 * child down right after we finished preparing it for
 		 * userspace.
 		 */
-		kill = test_bit(CGRP_KILL, &cgrp_flags);
+		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
 	spin_unlock_irq(&css_set_lock);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7006fc8dd677..0ae90c15cad8 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -477,7 +477,6 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
 		cputime->sum_exec_runtime += user;
 		cputime->sum_exec_runtime += sys;
-		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
 
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index d545abe08087..95bccbe3495c 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -576,6 +576,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
+		if (!c->write)
+			continue;
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b557579..35e85323940c 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -429,10 +429,6 @@ static inline struct cpumask *irq_desc_get_pending_mask(struct irq_desc *desc)
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
@@ -459,11 +455,12 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
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
diff --git a/kernel/padata.c b/kernel/padata.c
index 3e7bf1bbc6c2..e2bef90e6fd0 100644
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
@@ -198,7 +214,7 @@ int padata_do_parallel(struct padata_shell *ps,
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-	refcount_inc(&pd->refcnt);
+	padata_get_pd(pd);
 	padata->pd = pd;
 	padata->cb_cpu = *cb_cpu;
 
@@ -328,8 +344,14 @@ static void padata_reorder(struct parallel_data *pd)
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
@@ -340,6 +362,8 @@ static void invoke_padata_reorder(struct work_struct *work)
 	pd = container_of(work, struct parallel_data, reorder_work);
 	padata_reorder(pd);
 	local_bh_enable();
+	/* Pairs with putting the reorder_work in the serial_wq */
+	padata_put_pd(pd);
 }
 
 static void padata_serial_worker(struct work_struct *serial_work)
@@ -372,8 +396,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 	}
 	local_bh_enable();
 
-	if (refcount_sub_and_test(cnt, &pd->refcnt))
-		padata_free_pd(pd);
+	padata_put_pd_cnt(pd, cnt);
 }
 
 /**
@@ -670,8 +693,7 @@ static int padata_replace(struct padata_instance *pinst)
 	synchronize_rcu();
 
 	list_for_each_entry_continue_reverse(ps, &pinst->pslist, list)
-		if (refcount_dec_and_test(&ps->opd->refcnt))
-			padata_free_pd(ps->opd);
+		padata_put_pd(ps->opd);
 
 	pinst->flags &= ~PADATA_RESET;
 
@@ -959,7 +981,7 @@ static ssize_t padata_sysfs_store(struct kobject *kobj, struct attribute *attr,
 
 	pinst = kobj2pinst(kobj);
 	pentry = attr2pentry(attr);
-	if (pentry->show)
+	if (pentry->store)
 		ret = pentry->store(pinst, attr, buf, count);
 
 	return ret;
@@ -1110,11 +1132,16 @@ void padata_free_shell(struct padata_shell *ps)
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
index 30d1274f03f6..ec34c96514b3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -599,7 +599,11 @@ int hibernation_platform_enter(void)
 
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
@@ -611,6 +615,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+ Enable_irqs:
 	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5a88134fba79..c93beab96c86 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -403,7 +403,7 @@ static struct latched_seq clear_seq = {
 /* record buffer */
 #define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54af671e8d51..2f7519022c01 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -704,13 +704,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
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
@@ -2049,7 +2051,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!(flags & ENQUEUE_RESTORE)) {
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, flags & ENQUEUE_WAKEUP);
+		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
 	uclamp_rq_inc(rq, p);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 853a07618a3c..542c0e82a900 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -84,7 +84,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = true;
+		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 		return true;
 	}
 
@@ -97,7 +97,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
 	if (sg_policy->need_freq_update)
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = false;
 	else if (sg_policy->next_freq == next_freq)
 		return false;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cf3bbddd4b7f..eedbe66e0527 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8317,6 +8317,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	int tsk_cache_hot;
 
 	lockdep_assert_rq_held(env->src_rq);
+	if (p->sched_task_hot)
+		p->sched_task_hot = 0;
 
 	/*
 	 * We do not migrate tasks that are:
@@ -8389,10 +8391,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
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
 
@@ -8407,6 +8407,12 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
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
@@ -8567,6 +8573,9 @@ static int detach_tasks(struct lb_env *env)
 
 		continue;
 next:
+		if (p->sched_task_hot)
+			schedstat_inc(p->stats.nr_failed_migrations_hot);
+
 		list_move(&p->se.group_node, tasks);
 	}
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index b49a96fad1d2..b02dfc322951 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -132,11 +132,9 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (p->in_memstall)
 		set |= TSK_MEMSTALL_RUNNING;
 
-	if (!wakeup || p->sched_psi_wake_requeue) {
+	if (!wakeup) {
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
-		if (p->sched_psi_wake_requeue)
-			p->sched_psi_wake_requeue = 0;
 	} else {
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
@@ -147,8 +145,6 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
-	int clear = TSK_RUNNING;
-
 	if (static_branch_likely(&psi_disabled))
 		return;
 
@@ -161,10 +157,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 	if (sleep)
 		return;
 
-	if (p->in_memstall)
-		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
-
-	psi_task_change(p, clear, 0);
+	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
@@ -176,19 +169,12 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	 * deregister its sleep-persistent psi states from the old
 	 * queue, and let psi_enqueue() know it has to requeue.
 	 */
-	if (unlikely(p->in_iowait || p->in_memstall)) {
+	if (unlikely(p->psi_flags)) {
 		struct rq_flags rf;
 		struct rq *rq;
-		int clear = 0;
-
-		if (p->in_iowait)
-			clear |= TSK_IOWAIT;
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
 
 		rq = __task_rq_lock(p, &rf);
-		psi_task_change(p, clear, 0);
-		p->sched_psi_wake_requeue = 1;
+		psi_task_change(p, p->psi_flags, 0);
 		__task_rq_unlock(rq, &rf);
 	}
 }
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a3650699463b..9e221a97d227 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -348,16 +348,18 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
 	cpus_read_lock();
-	preempt_disable();
+	migrate_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_empty(&cpus_chosen)) {
-		preempt_enable();
+		migrate_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
 	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
+		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	preempt_disable();
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
@@ -377,6 +379,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min = cs_nsec;
 	}
 	preempt_enable();
+	migrate_enable();
 	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f46903c1142b..af48f66466e8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -857,7 +857,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (irqs_disabled()) {
+	if (!preemptible()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b2dff1935893..e5fbae585e52 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1409,7 +1409,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1425,7 +1425,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1433,7 +1433,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
@@ -1441,7 +1441,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 config LOCKDEP_CIRCULAR_QUEUE_BITS
 	int "Bitsize for elements in circular_queue struct"
 	depends on LOCKDEP
-	range 10 30
+	range 10 26
 	default 12
 	help
 	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4c586008c6dd..b5d216bdd3a5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1890,11 +1890,11 @@ static inline int mab_no_null_split(struct maple_big_node *b_node,
  * Return: The first split location.  The middle split is set in @mid_split.
  */
 static inline int mab_calc_split(struct ma_state *mas,
-	 struct maple_big_node *bn, unsigned char *mid_split, unsigned long min)
+	 struct maple_big_node *bn, unsigned char *mid_split)
 {
 	unsigned char b_end = bn->b_end;
 	int split = b_end / 2; /* Assume equal split. */
-	unsigned char slot_min, slot_count = mt_slots[bn->type];
+	unsigned char slot_count = mt_slots[bn->type];
 
 	/*
 	 * To support gap tracking, all NULL entries are kept together and a node cannot
@@ -1927,17 +1927,7 @@ static inline int mab_calc_split(struct ma_state *mas,
 		split = b_end / 3;
 		*mid_split = split * 2;
 	} else {
-		slot_min = mt_min_slots[bn->type];
-
 		*mid_split = 0;
-		/*
-		 * Avoid having a range less than the slot count unless it
-		 * causes one node to be deficient.
-		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
-		 */
-		while (((bn->pivot[split] - min) < slot_count - 1) &&
-		       (split < slot_count - 1) && (b_end - split > slot_min))
-			split++;
 	}
 
 	/* Avoid ending a node on a NULL entry */
@@ -2663,7 +2653,7 @@ static inline struct maple_enode
 static inline unsigned char mas_mab_to_node(struct ma_state *mas,
 	struct maple_big_node *b_node, struct maple_enode **left,
 	struct maple_enode **right, struct maple_enode **middle,
-	unsigned char *mid_split, unsigned long min)
+	unsigned char *mid_split)
 {
 	unsigned char split = 0;
 	unsigned char slot_count = mt_slots[b_node->type];
@@ -2676,7 +2666,7 @@ static inline unsigned char mas_mab_to_node(struct ma_state *mas,
 	if (b_node->b_end < slot_count) {
 		split = b_node->b_end;
 	} else {
-		split = mab_calc_split(mas, b_node, mid_split, min);
+		split = mab_calc_split(mas, b_node, mid_split);
 		*right = mas_new_ma_node(mas, b_node);
 	}
 
@@ -3075,7 +3065,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 		mast->bn->b_end--;
 		mast->bn->type = mte_node_type(mast->orig_l->node);
 		split = mas_mab_to_node(mas, mast->bn, &left, &right, &middle,
-					&mid_split, mast->orig_l->min);
+					&mid_split);
 		mast_set_split_parents(mast, left, middle, right, split,
 				       mid_split);
 		mast_cp_to_nodes(mast, left, middle, right, split, mid_split);
@@ -3590,7 +3580,7 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		if (mas_push_data(mas, height, &mast, false))
 			break;
 
-		split = mab_calc_split(mas, b_node, &mid_split, prev_l_mas.min);
+		split = mab_calc_split(mas, b_node, &mid_split);
 		mast_split_data(&mast, mas, split);
 		/*
 		 * Usually correct, mab_mas_cp in the above call overwrites
diff --git a/mm/gup.c b/mm/gup.c
index f4911ddd3070..e31d00443c4e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1944,14 +1944,14 @@ struct page *get_dump_page(unsigned long addr)
 /*
  * Returns the number of collected pages. Return value is always >= 0.
  */
-static unsigned long collect_longterm_unpinnable_pages(
+static void collect_longterm_unpinnable_pages(
 					struct list_head *movable_page_list,
 					unsigned long nr_pages,
 					struct page **pages)
 {
-	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
+	unsigned long i;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1963,8 +1963,6 @@ static unsigned long collect_longterm_unpinnable_pages(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
-		collected++;
-
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -1986,8 +1984,6 @@ static unsigned long collect_longterm_unpinnable_pages(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
-
-	return collected;
 }
 
 /*
@@ -2080,12 +2076,10 @@ static int migrate_longterm_unpinnable_pages(
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	unsigned long collected;
 	LIST_HEAD(movable_page_list);
 
-	collected = collect_longterm_unpinnable_pages(&movable_page_list,
-						nr_pages, pages);
-	if (!collected)
+	collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
+	if (list_empty(&movable_page_list))
 		return 0;
 
 	return migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c597cfebb0e8..799d8503f35f 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -21,6 +21,7 @@
 #include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/moduleparam.h>
+#include <linux/nodemask.h>
 #include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/random.h>
@@ -997,6 +998,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 * properties (e.g. reside in DMAable memory).
 	 */
 	if ((flags & GFP_ZONEMASK) ||
+	    ((flags & __GFP_THISNODE) && num_online_nodes() > 1) ||
 	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32))) {
 		atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
 		return NULL;
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 646e2979641f..9430b2e283ca 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1520,7 +1520,7 @@ static void kmemleak_scan(void)
 			unsigned long phys = object->pointer;
 
 			if (PHYS_PFN(phys) < min_low_pfn ||
-			    PHYS_PFN(phys + object->size) >= max_low_pfn)
+			    PHYS_PFN(phys + object->size) > max_low_pfn)
 				__paint_it(object, KMEMLEAK_BLACK);
 		}
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index a1e0be871687..862e03493b7e 100644
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
@@ -677,22 +677,33 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
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
 
+		if (ax25->ax25_dev) {
+			if (dev == ax25->ax25_dev->dev) {
+				rcu_read_unlock();
+				break;
+			}
+			netdev_put(ax25->ax25_dev->dev, &ax25->dev_tracker);
+			ax25_dev_put(ax25->ax25_dev);
+		}
+
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
-		rtnl_unlock();
+		netdev_hold(dev, &ax25->dev_tracker, GFP_ATOMIC);
+		ax25_dev_hold(ax25->ax25_dev);
+		rcu_read_unlock();
 		break;
 
 	default:
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index e165fe108bb0..2b4f8df53b76 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -87,7 +87,7 @@ void ax25_dev_device_up(struct net_device *dev)
 
 	spin_lock_bh(&ax25_dev_lock);
 	list_add(&ax25_dev->list, &ax25_dev_list);
-	dev->ax25_ptr     = ax25_dev;
+	rcu_assign_pointer(dev->ax25_ptr, ax25_dev);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	ax25_register_dev_sysctl(ax25_dev);
@@ -122,7 +122,7 @@ void ax25_dev_device_down(struct net_device *dev)
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
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 54e41fc709c3..651e01b86141 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -113,8 +113,6 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
-	INIT_WORK(&hardif_neigh->bat_v.metric_work,
-		  batadv_v_elp_throughput_metric_update);
 }
 
 /**
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 98a624f32b94..6dbb4266b558 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
@@ -27,6 +28,7 @@
 #include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -42,6 +44,18 @@
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
@@ -60,25 +74,36 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
+ * @pthroughput: calculated throughput towards the given neighbour in multiples
+ *  of 100kpbs (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
  *
- * Return: The throughput towards the given neighbour in multiples of 100kpbs
- *         (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
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
@@ -105,27 +130,39 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 * possible to delete this neighbor. For now set
 			 * the throughput metric to 0.
 			 */
-			return 0;
+			*pthroughput = 0;
+			return true;
 		}
 		if (ret)
 			goto default_throughput;
 
-		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
-			return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			*pthroughput = sinfo.expected_throughput / 100;
+			return true;
+		}
 
 		/* try to estimate the expected throughput based on reported tx
 		 * rates
 		 */
-		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE))
-			return cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+			*pthroughput = cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+			return true;
+		}
 
 		goto default_throughput;
 	}
 
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
-	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
 	if (ret == 0) {
@@ -136,13 +173,15 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
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
@@ -151,31 +190,26 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
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
@@ -249,14 +283,16 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
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
@@ -292,6 +328,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+	INIT_LIST_HEAD(&metric_queue);
+
 	/* The throughput metric is updated on each sent packet. This way, if a
 	 * node is dead and no longer sends packets, batman-adv is still able to
 	 * react timely to its death.
@@ -316,16 +354,28 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
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
index 9e2740195fa2..c9cb0a307100 100644
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
index 76791815b26b..6f30afaabfdf 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -596,9 +596,6 @@ struct batadv_hardif_neigh_node_bat_v {
 	 *  neighbor
 	 */
 	unsigned long last_unicast_tx;
-
-	/** @metric_work: work queue callback item for metric update */
-	struct work_struct metric_work;
 };
 
 /**
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4e965916c17c..bdfc83eb7aef 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -728,12 +728,12 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 {
 	switch (chan->scid) {
 	case L2CAP_CID_ATT:
-		if (mtu < L2CAP_LE_MIN_MTU)
+		if (mtu && mtu < L2CAP_LE_MIN_MTU)
 			return false;
 		break;
 
 	default:
-		if (mtu < L2CAP_DEFAULT_MIN_MTU)
+		if (mtu && mtu < L2CAP_DEFAULT_MIN_MTU)
 			return false;
 	}
 
@@ -1920,7 +1920,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
-		sock->sk = NULL;
+		if (sock)
+			sock->sk = NULL;
 		return NULL;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dc3921269a5a..4f116e8c84a0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5524,10 +5524,16 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_remove_adv_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	if (status == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return;
 
 	hci_dev_lock(hdev);
 
+	cp = cmd->param;
+
 	rp.monitor_handle = cp->monitor_handle;
 
 	if (!status)
@@ -5545,6 +5551,10 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
+
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 58909b36561a..0a4267a24263 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 	todo_size = size;
 
-	while (todo_size) {
+	do {
 		struct j1939_sk_buff_cb *skcb;
 
 		segment_size = min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
@@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
-	}
+	} while (todo_size);
 
 	switch (ret) {
 	case 0: /* OK */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index a58f6f5dfcf8..76d625c668e0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j1939_session *session,
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
diff --git a/net/core/filter.c b/net/core/filter.c
index b35615c469e2..370f61f9bf4b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7529,7 +7529,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index fba8eb1bb281..de17f1323238 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1004,10 +1004,12 @@ bool __skb_flow_dissect(const struct net *net,
 					      FLOW_DISSECTOR_KEY_BASIC,
 					      target_container);
 
+	rcu_read_lock();
+
 	if (skb) {
 		if (!net) {
 			if (skb->dev)
-				net = dev_net(skb->dev);
+				net = dev_net_rcu(skb->dev);
 			else if (skb->sk)
 				net = sock_net(skb->sk);
 		}
@@ -1018,7 +1020,6 @@ bool __skb_flow_dissect(const struct net *net,
 		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
 		struct bpf_prog_array *run_array;
 
-		rcu_read_lock();
 		run_array = rcu_dereference(init_net.bpf.run_array[type]);
 		if (!run_array)
 			run_array = rcu_dereference(net->bpf.run_array[type]);
@@ -1046,17 +1047,17 @@ bool __skb_flow_dissect(const struct net *net,
 			prog = READ_ONCE(run_array->items[0].prog);
 			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
 						  hlen, flags);
-			if (result == BPF_FLOW_DISSECTOR_CONTINUE)
-				goto dissect_continue;
-			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
-						 target_container);
-			rcu_read_unlock();
-			return result == BPF_OK;
+			if (result != BPF_FLOW_DISSECTOR_CONTINUE) {
+				__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
+							 target_container);
+				rcu_read_unlock();
+				return result == BPF_OK;
+			}
 		}
-dissect_continue:
-		rcu_read_unlock();
 	}
 
+	rcu_read_unlock();
+
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct ethhdr *eth = eth_hdr(skb);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index dd0965e1afe8..2e2c009b5a2d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3498,10 +3498,12 @@ static const struct seq_operations neigh_stat_seq_ops = {
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
@@ -3514,10 +3516,11 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
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
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index d281d5343ff4..47ca6d3ddbb5 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -238,7 +238,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	int ret, weight;
 
 	mutex_lock(&dev_weight_mutex);
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
 		WRITE_ONCE(dev_rx_weight, weight * dev_weight_rx_bias);
@@ -363,6 +363,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_rx_bias",
@@ -370,6 +371,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_tx_bias",
@@ -377,6 +379,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "netdev_max_backlog",
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 5fe075bf479e..caeb7e75b287 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2592,13 +2592,14 @@ EXPORT_SYMBOL_GPL(dsa_slave_dev_check);
 static int dsa_slave_changeupper(struct net_device *dev,
 				 struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
+	struct dsa_port *dp;
 
 	if (!dsa_slave_dev_check(dev))
 		return err;
 
+	dp = dsa_slave_to_port(dev);
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	if (netif_is_bridge_master(info->upper_dev)) {
@@ -2652,11 +2653,13 @@ static int dsa_slave_changeupper(struct net_device *dev,
 static int dsa_slave_prechangeupper(struct net_device *dev,
 				    struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp;
 
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	dp = dsa_slave_to_port(dev);
+
 	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
 		dsa_port_pre_bridge_leave(dp, info->upper_dev);
 	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index fc4ccecf9495..e5efdf2817ef 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -41,7 +41,7 @@ int ethnl_ops_begin(struct net_device *dev)
 		pm_runtime_get_sync(dev->dev.parent);
 
 	if (!netif_device_present(dev) ||
-	    dev->reg_state == NETREG_UNREGISTERING) {
+	    dev->reg_state >= NETREG_UNREGISTERING) {
 		ret = -ENODEV;
 		goto err;
 	}
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 2790f3964d6b..9317f96127c1 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -588,9 +588,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
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
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index ccff96820a70..8f9b5568f1dc 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -658,10 +658,12 @@ static int arp_xmit_finish(struct net *net, struct sock *sk, struct sk_buff *skb
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
index 430ca93ba939..1738cc2bfc7f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1320,10 +1320,11 @@ __be32 inet_select_addr(const struct net_device *dev, __be32 dst, int scope)
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
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 9dffdd876fef..a21d32b3ae6c 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -316,7 +316,6 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	bool rc = true;
-	int vif;
 
 	if (!apply_ratelimit)
 		return true;
@@ -325,12 +324,12 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
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
@@ -404,10 +403,10 @@ static void icmp_push_reply(struct sock *sk,
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
-	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	bool apply_ratelimit = false;
+	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -610,12 +609,14 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct sock *sk;
 
 	if (!rt)
-		goto out;
+		return;
+
+	rcu_read_lock();
 
 	if (rt->dst.dev)
-		net = dev_net(rt->dst.dev);
+		net = dev_net_rcu(rt->dst.dev);
 	else if (skb_in->dev)
-		net = dev_net(skb_in->dev);
+		net = dev_net_rcu(skb_in->dev);
 	else
 		goto out;
 
@@ -784,7 +785,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	icmp_xmit_unlock(sk);
 out_bh_enable:
 	local_bh_enable();
-out:;
+out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(__icmp_send);
 
@@ -833,7 +835,7 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	 * avoid additional coding at protocol handlers.
 	 */
 	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return;
 	}
 
@@ -867,7 +869,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 
 	/*
 	 *	Incomplete header ?
@@ -978,7 +980,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
 {
 	if (skb->len < sizeof(struct iphdr)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 	}
 
@@ -1010,7 +1012,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 	/* should there be an ICMP stat for ignored echos? */
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
@@ -1039,9 +1041,9 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
-	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *in6_dev;
 	struct in_device *in_dev;
 	struct net_device *dev;
@@ -1180,7 +1182,7 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
-	__ICMP_INC_STATS(dev_net(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(dev_net_rcu(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
 	return SKB_DROP_REASON_PKT_TOO_SMALL;
 }
 
@@ -1197,7 +1199,7 @@ int icmp_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	struct icmphdr *icmph;
 
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
@@ -1370,9 +1372,9 @@ int icmp_err(struct sk_buff *skb, u32 info)
 	struct iphdr *iph = (struct iphdr *)skb->data;
 	int offset = iph->ihl<<2;
 	struct icmphdr *icmph = (struct icmphdr *)(skb->data + offset);
+	struct net *net = dev_net_rcu(skb->dev);
 	int type = icmp_hdr(skb)->type;
 	int code = icmp_hdr(skb)->code;
-	struct net *net = dev_net(skb->dev);
 
 	/*
 	 * Use ping_err to handle all icmp errors except those
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index e9fed83e9b3c..23896b6b8417 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -98,6 +98,7 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 {
 	struct rb_node **pp, *parent, *next;
 	struct inet_peer *p;
+	u32 now;
 
 	pp = &base->rb_root.rb_node;
 	parent = NULL;
@@ -111,8 +112,9 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
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
@@ -158,9 +160,6 @@ static void inet_peer_gc(struct inet_peer_base *base,
 	for (i = 0; i < gc_cnt; i++) {
 		p = gc_stack[i];
 
-		/* The READ_ONCE() pairs with the WRITE_ONCE()
-		 * in inet_putpeer()
-		 */
 		delta = (__u32)jiffies - READ_ONCE(p->dtime);
 
 		if (delta < ttl || !refcount_dec_if_one(&p->refcnt))
@@ -176,31 +175,23 @@ static void inet_peer_gc(struct inet_peer_base *base,
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
@@ -209,12 +200,12 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
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
@@ -239,15 +230,9 @@ EXPORT_SYMBOL_GPL(inet_getpeer);
 
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
index 6c309c1ec3b0..0ed999fdca2d 100644
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
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index f0af12a2f70b..de98ce66d38f 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
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
index fda88894d020..4574dcba9f19 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -393,7 +393,13 @@ static inline int ip_rt_proc_init(void)
 
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
@@ -882,11 +888,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
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
@@ -905,7 +911,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	 */
 	if (peer->n_redirects >= ip_rt_redirect_number) {
 		peer->rate_last = jiffies;
-		goto out_put_peer;
+		goto out_unlock;
 	}
 
 	/* Check for load limit; set rate_last to the latest sent
@@ -926,8 +932,8 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);
 	}
-out_put_peer:
-	inet_putpeer(peer);
+out_unlock:
+	rcu_read_unlock();
 }
 
 static int ip_error(struct sk_buff *skb)
@@ -987,9 +993,9 @@ static int ip_error(struct sk_buff *skb)
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
@@ -1001,8 +1007,9 @@ static int ip_error(struct sk_buff *skb)
 			peer->rate_tokens -= ip_rt_error_cost;
 		else
 			send = false;
-		inet_putpeer(peer);
 	}
+	rcu_read_unlock();
+
 	if (send)
 		icmp_send(skb, ICMP_DEST_UNREACH, code, 0);
 
@@ -1013,9 +1020,9 @@ out:	kfree_skb_reason(skb, reason);
 static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 {
 	struct dst_entry *dst = &rt->dst;
-	struct net *net = dev_net(dst->dev);
 	struct fib_result res;
 	bool lock = false;
+	struct net *net;
 	u32 old_mtu;
 
 	if (ip_mtu_locked(dst))
@@ -1025,6 +1032,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 	if (old_mtu < mtu)
 		return;
 
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1032,17 +1041,29 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 
 	if (rt->rt_pmtu == mtu && !lock &&
 	    time_before(jiffies, dst->expires - net->ipv4.ip_rt_mtu_expires / 2))
-		return;
+		goto out;
 
-	rcu_read_lock();
 	if (fib_lookup(net, fl4, &res, 0) == 0) {
 		struct fib_nh_common *nhc;
 
 		fib_select_path(net, &res, fl4, NULL);
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+		if (fib_info_num_path(res.fi) > 1) {
+			int nhsel;
+
+			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
+				nhc = fib_info_nhc(res.fi, nhsel);
+				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
+						      jiffies + net->ipv4.ip_rt_mtu_expires);
+			}
+			goto out;
+		}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH */
 		nhc = FIB_RES_NHC(res);
 		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 				      jiffies + net->ipv4.ip_rt_mtu_expires);
 	}
+out:
 	rcu_read_unlock();
 }
 
@@ -1305,10 +1326,15 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
-	struct net *net = dev_net(dst->dev);
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    net->ipv4.ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 768c10c1f649..b7c140874d97 100644
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
 
@@ -467,9 +471,7 @@ static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample)
 	if (ca->delay_min == 0 || ca->delay_min > delay)
 		ca->delay_min = delay;
 
-	/* hystart triggers when cwnd is larger than some threshold */
-	if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-	    tcp_snd_cwnd(tp) >= hystart_low_window)
+	if (!ca->found && tcp_in_slow_start(tp) && hystart)
 		hystart_update(sk, delay);
 }
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3f9c4b74fdc0..88da11922d67 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -939,9 +939,9 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index ed8cdf7b8b11..7d88fd314c39 100644
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
index 408247080361..d7f7a714bd23 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -610,15 +610,15 @@ int ip6_forward(struct sk_buff *skb)
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
 
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index a77769538940..a1b3f3e7921f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1731,21 +1731,19 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 	struct net_device *dev = idev->dev;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	struct net *net = dev_net(dev);
 	const struct in6_addr *saddr;
 	struct in6_addr addr_buf;
 	struct mld2_report *pmr;
 	struct sk_buff *skb;
 	unsigned int size;
 	struct sock *sk;
-	int err;
+	struct net *net;
 
-	sk = net->ipv6.igmp_sk;
 	/* we assume size > sizeof(ra) here
 	 * Also try to not allocate high-order pages for big MTU
 	 */
 	size = min_t(int, mtu, PAGE_SIZE / 2) + hlen + tlen;
-	skb = sock_alloc_send_skb(sk, size, 1, &err);
+	skb = alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -1753,6 +1751,12 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 	skb_reserve(skb, hlen);
 	skb_tailroom_reserve(skb, mtu, tlen);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
+	sk = net->ipv6.igmp_sk;
+	skb_set_owner_w(skb, sk);
+
 	if (ipv6_get_lladdr(dev, &addr_buf, IFA_F_TENTATIVE)) {
 		/* <draft-ietf-magma-mld-source-05.txt>:
 		 * use unspecified address as the source address
@@ -1764,6 +1768,8 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 
 	ip6_mc_hdr(sk, skb, dev, saddr, &mld2_all_mcr, NEXTHDR_HOP, 0);
 
+	rcu_read_unlock();
+
 	skb_put_data(skb, ra, sizeof(ra));
 
 	skb_set_transport_header(skb, skb_tail_pointer(skb) - skb->data);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index cfb4cf6e6654..1a6408a24d21 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -418,15 +418,11 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
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
@@ -437,7 +433,9 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 	/* Manually assign socket ownership as we avoid calling
 	 * sock_alloc_send_pskb() to bypass wmem buffer limits
 	 */
-	skb_set_owner_w(skb, sk);
+	rcu_read_lock();
+	skb_set_owner_w(skb, dev_net_rcu(dev)->ipv6.ndisc_sk);
+	rcu_read_unlock();
 
 	return skb;
 }
@@ -473,16 +471,20 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
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
@@ -490,6 +492,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		icmpv6_flow_init(sk, &fl6, type, saddr, daddr, oif);
 		dst = icmp6_dst_alloc(skb->dev, &fl6);
 		if (IS_ERR(dst)) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return;
 		}
@@ -504,7 +507,6 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, inet6_sk(sk)->hop_limit, skb->len);
 
-	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
@@ -1684,7 +1686,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	bool ret;
 
 	if (netif_is_l3_master(skb->dev)) {
-		dev = __dev_get_by_index(dev_net(skb->dev), IPCB(skb)->iif);
+		dev = dev_get_by_index_rcu(dev_net(skb->dev), IPCB(skb)->iif);
 		if (!dev)
 			return;
 	}
@@ -1721,10 +1723,12 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
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
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f3268bac9f19..17918f411386 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3190,13 +3190,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
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
index f55d08d2096a..4b063aa37e38 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1256,9 +1256,9 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 8ced615add71..f8416965c219 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -588,7 +588,7 @@ static ssize_t ieee80211_if_parse_active_links(struct ieee80211_sub_if_data *sda
 {
 	u16 active_links;
 
-	if (kstrtou16(buf, 0, &active_links))
+	if (kstrtou16(buf, 0, &active_links) || !active_links)
 		return -EINVAL;
 
 	return ieee80211_set_active_links(&sdata->vif, active_links) ?: buflen;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c4aa1b85bc61..f04fa61a6323 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -103,7 +103,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
-			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
@@ -152,11 +151,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -364,8 +358,11 @@ void mptcp_get_options(const struct sk_buff *skb,
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
index 3fd7de56a30f..ddbc352f8420 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2086,7 +2086,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
+			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0848e63bac65..e975693b8fa9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
@@ -1779,8 +1780,10 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
 		 * see mptcp_disconnect().
 		 * Attempt it again outside the problematic scope.
 		 */
-		if (!mptcp_disconnect(sk, 0))
+		if (!mptcp_disconnect(sk, 0)) {
+			sk->sk_disconnects++;
 			sk->sk_socket->state = SS_UNCONNECTED;
+		}
 	}
 
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d39ad72ac8e8..77e727d81cc2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -141,22 +141,24 @@ struct mptcp_options_received {
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
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ef0f8f73826f..4e0842df5234 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -289,6 +289,7 @@ enum {
 	ncsi_dev_state_config_sp	= 0x0301,
 	ncsi_dev_state_config_cis,
 	ncsi_dev_state_config_oem_gma,
+	ncsi_dev_state_config_apply_mac,
 	ncsi_dev_state_config_clear_vids,
 	ncsi_dev_state_config_svf,
 	ncsi_dev_state_config_ev,
@@ -322,6 +323,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_RESHUFFLE	4
 #define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
+	struct sockaddr     pending_mac;     /* MAC address received from GMA */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
index dda8b76b7798..7be177f55173 100644
--- a/net/ncsi/ncsi-cmd.c
+++ b/net/ncsi/ncsi-cmd.c
@@ -269,7 +269,8 @@ static struct ncsi_cmd_handler {
 	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_OEM,   -1, ncsi_cmd_handler_oem     },
 	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
-	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
+	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default },
+	{ NCSI_PKT_CMD_GMCMA,  0, ncsi_cmd_handler_default }
 };
 
 static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 760b33fa03a8..6a58ae8b5d03 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1038,17 +1038,34 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
-		nd->state = ncsi_dev_state_config_clear_vids;
+		nd->state = ncsi_dev_state_config_apply_mac;
 
-		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = np->id;
 		nca.channel = nc->id;
 		ndp->pending_req_num = 1;
-		ret = ncsi_gma_handler(&nca, nc->version.mf_id);
-		if (ret < 0)
+		if (nc->version.major >= 1 && nc->version.minor >= 2) {
+			nca.type = NCSI_PKT_CMD_GMCMA;
+			ret = ncsi_xmit_cmd(&nca);
+		} else {
+			nca.type = NCSI_PKT_CMD_OEM;
+			ret = ncsi_gma_handler(&nca, nc->version.mf_id);
+		}
+		if (ret < 0) {
+			nd->state = ncsi_dev_state_config_clear_vids;
 			schedule_work(&ndp->work);
+		}
 
 		break;
+	case ncsi_dev_state_config_apply_mac:
+		rtnl_lock();
+		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
+		rtnl_unlock();
+		if (ret < 0)
+			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
+
+		nd->state = ncsi_dev_state_config_clear_vids;
+
+		fallthrough;
 	case ncsi_dev_state_config_clear_vids:
 	case ncsi_dev_state_config_svf:
 	case ncsi_dev_state_config_ev:
@@ -1368,6 +1385,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
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
@@ -1484,13 +1507,8 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
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
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index c9d1da34dc4d..f2f3b5c1b941 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -338,6 +338,14 @@ struct ncsi_rsp_gpuuid_pkt {
 	__be32                  checksum;
 };
 
+/* Get MC MAC Address */
+struct ncsi_rsp_gmcma_pkt {
+	struct ncsi_rsp_pkt_hdr rsp;
+	unsigned char           address_count;
+	unsigned char           reserved[3];
+	unsigned char           addresses[][ETH_ALEN];
+};
+
 /* AEN: Link State Change */
 struct ncsi_aen_lsc_pkt {
 	struct ncsi_aen_pkt_hdr aen;        /* AEN header      */
@@ -398,6 +406,7 @@ struct ncsi_aen_hncdsc_pkt {
 #define NCSI_PKT_CMD_GPUUID	0x52 /* Get package UUID                 */
 #define NCSI_PKT_CMD_QPNPR	0x56 /* Query Pending NC PLDM request */
 #define NCSI_PKT_CMD_SNPR	0x57 /* Send NC PLDM Reply  */
+#define NCSI_PKT_CMD_GMCMA	0x58 /* Get MC MAC Address */
 
 
 /* NCSI packet responses */
@@ -433,6 +442,7 @@ struct ncsi_aen_hncdsc_pkt {
 #define NCSI_PKT_RSP_GPUUID	(NCSI_PKT_CMD_GPUUID + 0x80)
 #define NCSI_PKT_RSP_QPNPR	(NCSI_PKT_CMD_QPNPR   + 0x80)
 #define NCSI_PKT_RSP_SNPR	(NCSI_PKT_CMD_SNPR   + 0x80)
+#define NCSI_PKT_RSP_GMCMA	(NCSI_PKT_CMD_GMCMA  + 0x80)
 
 /* NCSI response code/reason */
 #define NCSI_PKT_RSP_C_COMPLETED	0x0000 /* Command Completed        */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index f22d67cb04d3..4a8ce2949fae 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -628,16 +628,14 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
-	int ret = 0;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
 
-	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
 		mac_addr_off = BCM_MAC_ADDR_OFFSET;
@@ -646,22 +644,17 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
-	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	saddr->sa_family = ndev->type;
+	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		eth_addr_inc((u8 *)saddr->sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
 		return -ENXIO;
 
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	rtnl_lock();
-	ret = dev_set_mac_address(ndev, &saddr, NULL);
-	rtnl_unlock();
-	if (ret < 0)
-		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
+	return 0;
 }
 
 /* Response handler for Mellanox card */
@@ -1093,6 +1086,42 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 	return ret;
 }
 
+static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
+{
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
+	struct net_device *ndev = ndp->ndev.dev;
+	struct ncsi_rsp_gmcma_pkt *rsp;
+	int i;
+
+	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
+	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
+		    rsp->address_count);
+	for (i = 0; i < rsp->address_count; i++) {
+		netdev_info(ndev, "NCSI: MAC address %d: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			    i, rsp->addresses[i][0], rsp->addresses[i][1],
+			    rsp->addresses[i][2], rsp->addresses[i][3],
+			    rsp->addresses[i][4], rsp->addresses[i][5]);
+	}
+
+	saddr->sa_family = ndev->type;
+	for (i = 0; i < rsp->address_count; i++) {
+		if (!is_valid_ether_addr(rsp->addresses[i])) {
+			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
+				    rsp->addresses[i]);
+			continue;
+		}
+		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
+		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
+		break;
+	}
+
+	ndp->gma_flag = 1;
+	return 0;
+}
+
 static struct ncsi_rsp_handler {
 	unsigned char	type;
 	int             payload;
@@ -1129,7 +1158,8 @@ static struct ncsi_rsp_handler {
 	{ NCSI_PKT_RSP_PLDM,   -1, ncsi_rsp_handler_pldm    },
 	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  },
 	{ NCSI_PKT_RSP_QPNPR,  -1, ncsi_rsp_handler_pldm    },
-	{ NCSI_PKT_RSP_SNPR,   -1, ncsi_rsp_handler_pldm    }
+	{ NCSI_PKT_RSP_SNPR,   -1, ncsi_rsp_handler_pldm    },
+	{ NCSI_PKT_RSP_GMCMA,  -1, ncsi_rsp_handler_gmcma   },
 };
 
 int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8176533c50ab..656c4fb76773 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4567,7 +4567,7 @@ static int nft_set_desc_concat_parse(const struct nlattr *attr,
 static int nft_set_desc_concat(struct nft_set_desc *desc,
 			       const struct nlattr *nla)
 {
-	u32 num_regs = 0, key_num_regs = 0;
+	u32 len = 0, num_regs;
 	struct nlattr *attr;
 	int rem, err, i;
 
@@ -4581,12 +4581,12 @@ static int nft_set_desc_concat(struct nft_set_desc *desc,
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
 
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 7a8707632a81..9d335aa58907 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -288,6 +288,15 @@ static bool nft_flow_offload_skip(struct sk_buff *skb, int family)
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
@@ -355,11 +364,8 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		goto err_flow_alloc;
 
 	flow_offload_route_init(flow, &route);
-
-	if (tcph) {
-		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
-		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
-	}
+	if (tcph)
+		flow_offload_ct_tcp(ct);
 
 	ret = flow_offload_add(flowtable, flow);
 	if (ret < 0)
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 78c4b6addf15..1057d5347e55 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -540,6 +540,8 @@ static u8 nci_hci_create_pipe(struct nci_dev *ndev, u8 dest_host,
 
 	pr_debug("pipe created=%d\n", pipe);
 
+	if (pipe >= NCI_HCI_MAX_PIPES)
+		pipe = NCI_HCI_INVALID_PIPE;
 	return pipe;
 }
 
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 3c7b24535409..a2d8b1b4c83e 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2076,6 +2076,7 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 {
 	struct ovs_header *ovs_header;
 	struct ovs_vport_stats vport_stats;
+	struct net *net_vport;
 	int err;
 
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_vport_genl_family,
@@ -2092,12 +2093,15 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
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
@@ -2115,6 +2119,8 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	genlmsg_end(skb, ovs_header);
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	err = -EMSGSIZE;
 error:
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 29b74a569e0b..b21c2ce40192 100644
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
@@ -701,11 +701,9 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
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
 
@@ -718,8 +716,15 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
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
 
@@ -730,7 +735,8 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	} else {
 		if (ax25_uid_policy && !capable(CAP_NET_BIND_SERVICE)) {
 			dev_put(dev);
-			return -EACCES;
+			err = -EACCES;
+			goto out_release;
 		}
 		rose->source_call   = *source;
 	}
@@ -753,8 +759,10 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
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
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index fe053e717260..cb379849c51a 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1638,6 +1638,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
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
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index f47ab622399f..cb38e58ee771 100644
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
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 66dcb18638fe..60754f366ab7 100644
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
@@ -608,6 +601,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock;
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	rcu_read_lock();
@@ -618,12 +612,17 @@ static void sfq_perturbation(struct timer_list *t)
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
 	rcu_read_unlock();
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -641,14 +640,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
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
@@ -657,12 +652,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
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
-	q->perturb_period = ctl->perturb_period * HZ;
+	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
@@ -724,7 +721,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
@@ -757,12 +754,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -873,7 +869,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e2bdd6aa3d89..c951e5c483b5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2645,7 +2645,7 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
 			release_sock(clcsk);
 		} else if (!atomic_read(&smc_sk(nsk)->conn.bytes_to_rcv)) {
 			lock_sock(nsk);
-			smc_rx_wait(smc_sk(nsk), &timeo, smc_rx_data_available);
+			smc_rx_wait(smc_sk(nsk), &timeo, 0, smc_rx_data_available);
 			release_sock(nsk);
 		}
 	}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index ffcc9996a3da..e57002d2ac37 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -234,22 +234,23 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
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
@@ -258,7 +259,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	struct sock *sk = &smc->sk;
 	int rc;
 
-	if (fcrit(conn))
+	if (fcrit(conn, peeked))
 		return 1;
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	add_wait_queue(sk_sleep(sk), &wait);
@@ -267,7 +268,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 			   cflags->peer_conn_abort ||
 			   READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN ||
 			   conn->killed ||
-			   fcrit(conn),
+			   fcrit(conn, peeked),
 			   &wait);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -318,11 +319,11 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
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
@@ -340,10 +341,10 @@ static bool smc_rx_recvmsg_data_available(struct smc_sock *smc)
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
@@ -380,14 +381,14 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
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
@@ -421,26 +422,28 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
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
@@ -476,6 +479,8 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
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
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 65f59739a041..25c18f8783ce 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2293,8 +2293,8 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
 	keylen = ntohl(*((__be32 *)(data + TIPC_AEAD_ALG_NAME)));
 
 	/* Verify the supplied size values */
-	if (unlikely(size != keylen + sizeof(struct tipc_aead_key) ||
-		     keylen > TIPC_AEAD_KEY_SIZE_MAX)) {
+	if (unlikely(keylen > TIPC_AEAD_KEY_SIZE_MAX ||
+		     size != keylen + sizeof(struct tipc_aead_key))) {
 		pr_debug("%s: invalid MSG_CRYPTO key size\n", rx->name);
 		goto exit;
 	}
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 398b6bab4b60..810293f160a8 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -799,10 +799,45 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		list_for_each_entry(intbss, &rdev->bss_list, list) {
 			struct cfg80211_bss *res = &intbss->pub;
 			const struct cfg80211_bss_ies *ies;
+			const struct element *ssid_elem;
+			struct cfg80211_colocated_ap *entry;
+			u32 s_ssid_tmp;
+			int ret;
 
 			ies = rcu_access_pointer(res->ies);
 			count += cfg80211_parse_colocated_ap(ies,
 							     &coloc_ap_list);
+
+			/* In case the scan request specified a specific BSSID
+			 * and the BSS is found and operating on 6GHz band then
+			 * add this AP to the collocated APs list.
+			 * This is relevant for ML probe requests when the lower
+			 * band APs have not been discovered.
+			 */
+			if (is_broadcast_ether_addr(rdev_req->bssid) ||
+			    !ether_addr_equal(rdev_req->bssid, res->bssid) ||
+			    res->channel->band != NL80211_BAND_6GHZ)
+				continue;
+
+			ret = cfg80211_calc_short_ssid(ies, &ssid_elem,
+						       &s_ssid_tmp);
+			if (ret)
+				continue;
+
+			entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+			if (!entry)
+				continue;
+
+			memcpy(entry->bssid, res->bssid, ETH_ALEN);
+			entry->short_ssid = s_ssid_tmp;
+			memcpy(entry->ssid, ssid_elem->data,
+			       ssid_elem->datalen);
+			entry->ssid_len = ssid_elem->datalen;
+			entry->short_ssid_valid = true;
+			entry->center_freq = res->channel->center_freq;
+
+			list_add_tail(&entry->list, &coloc_ap_list);
+			count++;
 		}
 		spin_unlock_bh(&rdev->bss_lock);
 	}
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index ce56d659c55a..7f52bb2e14c1 100644
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
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index f29bb3c72230..ce9b77bc167b 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -65,6 +65,9 @@ static int parse_path(char *env_path, const char ***const path_list)
 		}
 	}
 	*path_list = malloc(num_paths * sizeof(**path_list));
+	if (!*path_list)
+		return -1;
+
 	for (i = 0; i < num_paths; i++)
 		(*path_list)[i] = strsep(&env_path, ENV_PATH_TOKEN);
 
@@ -99,6 +102,10 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
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
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index fa5ef4180688..0971b1222e47 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -38,6 +38,10 @@ KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-type-limits
 KBUILD_CFLAGS += -Wno-shift-negative-value
 
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Wno-enum-enum-conversion
+endif
+
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
 
 else
@@ -66,7 +70,6 @@ KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
 KBUILD_CFLAGS += -Wno-enum-compare-conditional
-KBUILD_CFLAGS += -Wno-enum-enum-conversion
 endif
 
 endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d236e5658f9b..685ef0c610c6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -459,10 +459,10 @@ quiet_cmd_lzo_with_size = LZO     $@
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
index f5dfdb9d80e9..6b0eb3898e4e 100644
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
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 33d19e419908..662a5e7c37c2 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -827,6 +827,9 @@ int main(int ac, char **av)
 		break;
 	}
 
+	if (conf_errors())
+		exit(1);
+
 	if (sync_kconfig) {
 		name = getenv("KCONFIG_NOSILENTUPDATE");
 		if (name && *name) {
@@ -890,6 +893,9 @@ int main(int ac, char **av)
 		break;
 	}
 
+	if (sym_dep_errors())
+		exit(1);
+
 	if (input_mode == savedefconfig) {
 		if (conf_write_defconfig(defconfig_file)) {
 			fprintf(stderr, "n*** Error while saving defconfig to: %s\n\n",
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 992575f1e976..f214e8d3762e 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -155,6 +155,13 @@ static void conf_message(const char *fmt, ...)
 static const char *conf_filename;
 static int conf_lineno, conf_warnings;
 
+bool conf_errors(void)
+{
+	if (conf_warnings)
+		return getenv("KCONFIG_WERROR");
+	return false;
+}
+
 static void conf_warning(const char *fmt, ...)
 {
 	va_list ap;
@@ -346,10 +353,12 @@ int conf_read_simple(const char *name, int def)
 	FILE *in = NULL;
 	char   *line = NULL;
 	size_t  line_asize = 0;
-	char *p, *p2;
+	char *p, *p2, *val;
 	struct symbol *sym;
 	int i, def_flags;
+	const char *warn_unknown, *sym_name;
 
+	warn_unknown = getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
 	if (name) {
 		in = zconf_fopen(name);
 	} else {
@@ -382,10 +391,12 @@ int conf_read_simple(const char *name, int def)
 
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
 
@@ -424,71 +435,34 @@ int conf_read_simple(const char *name, int def)
 
 	while (compat_getline(&line, &line_asize, in) != -1) {
 		conf_lineno++;
-		sym = NULL;
 		if (line[0] == '#') {
-			if (memcmp(line + 2, CONFIG_, strlen(CONFIG_)))
+			if (line[1] != ' ')
+				continue;
+			p = line + 2;
+			if (memcmp(p, CONFIG_, strlen(CONFIG_)))
 				continue;
-			p = strchr(line + 2 + strlen(CONFIG_), ' ');
+			sym_name = p + strlen(CONFIG_);
+			p = strchr(sym_name, ' ');
 			if (!p)
 				continue;
 			*p++ = 0;
 			if (strncmp(p, "is not set", 10))
 				continue;
-			if (def == S_DEF_USER) {
-				sym = sym_find(line + 2 + strlen(CONFIG_));
-				if (!sym) {
-					conf_set_changed(true);
-					continue;
-				}
-			} else {
-				sym = sym_lookup(line + 2 + strlen(CONFIG_), 0);
-				if (sym->type == S_UNKNOWN)
-					sym->type = S_BOOLEAN;
-			}
-			if (sym->flags & def_flags) {
-				conf_warning("override: reassigning to symbol %s", sym->name);
-			}
-			switch (sym->type) {
-			case S_BOOLEAN:
-			case S_TRISTATE:
-				sym->def[def].tri = no;
-				sym->flags |= def_flags;
-				break;
-			default:
-				;
-			}
+
+			val = "n";
 		} else if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
-			p = strchr(line + strlen(CONFIG_), '=');
+			sym_name = line + strlen(CONFIG_);
+			p = strchr(sym_name, '=');
 			if (!p)
 				continue;
 			*p++ = 0;
+			val = p;
 			p2 = strchr(p, '\n');
 			if (p2) {
 				*p2-- = 0;
 				if (*p2 == '\r')
 					*p2 = 0;
 			}
-
-			sym = sym_find(line + strlen(CONFIG_));
-			if (!sym) {
-				if (def == S_DEF_AUTO)
-					/*
-					 * Reading from include/config/auto.conf
-					 * If CONFIG_FOO previously existed in
-					 * auto.conf but it is missing now,
-					 * include/config/FOO must be touched.
-					 */
-					conf_touch_dep(line + strlen(CONFIG_));
-				else
-					conf_set_changed(true);
-				continue;
-			}
-
-			if (sym->flags & def_flags) {
-				conf_warning("override: reassigning to symbol %s", sym->name);
-			}
-			if (conf_set_sym_val(sym, def, def_flags, p))
-				continue;
 		} else {
 			if (line[0] != '\r' && line[0] != '\n')
 				conf_warning("unexpected data: %.*s",
@@ -497,6 +471,31 @@ int conf_read_simple(const char *name, int def)
 			continue;
 		}
 
+		sym = sym_find(sym_name);
+		if (!sym) {
+			if (def == S_DEF_AUTO) {
+				/*
+				 * Reading from include/config/auto.conf.
+				 * If CONFIG_FOO previously existed in auto.conf
+				 * but it is missing now, include/config/FOO
+				 * must be touched.
+				 */
+				conf_touch_dep(sym_name);
+			} else {
+				if (warn_unknown)
+					conf_warning("unknown symbol: %s", sym_name);
+
+				conf_set_changed(true);
+			}
+			continue;
+		}
+
+		if (sym->flags & def_flags)
+			conf_warning("override: reassigning to symbol %s", sym->name);
+
+		if (conf_set_sym_val(sym, def, def_flags, val))
+			continue;
+
 		if (sym && sym_is_choice_value(sym)) {
 			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
 			switch (sym->def[def].tri) {
@@ -519,6 +518,7 @@ int conf_read_simple(const char *name, int def)
 	}
 	free(line);
 	fclose(in);
+
 	return 0;
 }
 
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index edd1e617b25c..e4931bde7ca7 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -12,6 +12,7 @@ void conf_set_changed(bool val);
 bool conf_get_changed(void);
 void conf_set_changed_callback(void (*fn)(void));
 void conf_set_message_callback(void (*fn)(const char *s));
+bool conf_errors(void);
 
 /* symbol.c */
 extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
@@ -22,6 +23,7 @@ void print_symbol_for_listconfig(struct symbol *sym);
 struct symbol ** sym_re_search(const char *pattern);
 const char * sym_type_name(enum symbol_type type);
 void sym_calc_value(struct symbol *sym);
+bool sym_dep_errors(void);
 enum symbol_type sym_get_type(struct symbol *sym);
 bool sym_tristate_within_range(struct symbol *sym,tristate tri);
 bool sym_set_tristate_value(struct symbol *sym,tristate tri);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 7b1df55b0176..1c0306c9d74e 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -40,6 +40,7 @@ static struct symbol symbol_empty = {
 
 struct symbol *modules_sym;
 static tristate modules_val;
+static int sym_warnings;
 
 enum symbol_type sym_get_type(struct symbol *sym)
 {
@@ -320,6 +321,15 @@ static void sym_warn_unmet_dep(struct symbol *sym)
 			       "  Selected by [m]:\n");
 
 	fputs(str_get(&gs), stderr);
+	str_free(&gs);
+	sym_warnings++;
+}
+
+bool sym_dep_errors(void)
+{
+	if (sym_warnings)
+		return getenv("KCONFIG_WERROR");
+	return false;
 }
 
 void sym_calc_value(struct symbol *sym)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7b0e5976113c..7b95afcc6b43 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -669,10 +669,6 @@ static inline access_mask_t get_mode_access(const umode_t mode)
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
@@ -683,9 +679,12 @@ static inline access_mask_t get_mode_access(const umode_t mode)
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
 
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 25310468bcdd..8e1ffd70b18a 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -143,6 +143,9 @@ static ssize_t handle_policy_update(struct file *file,
 	char *buf, *p, *end;
 	int err;
 
+	if (len >= KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	pol = kmalloc(sizeof(struct setid_ruleset), GFP_KERNEL);
 	if (!pol)
 		return -ENOMEM;
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index a7af085550b2..5f1cdd0af115 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2664,7 +2664,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 7c6b1fe8dfcc..58b2e25c448e 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -80,7 +80,11 @@ static int compare_input_type(const void *ap, const void *bp)
 
 	/* In case one has boost and the other one has not,
 	   pick the one with boost first. */
-	return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
+	if (a->has_boost_on_pin != b->has_boost_on_pin)
+		return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
+
+	/* Keep the original order */
+	return a->order - b->order;
 }
 
 /* Reorder the surround channels
@@ -400,6 +404,8 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	reorder_outputs(cfg->speaker_outs, cfg->speaker_pins);
 
 	/* sort inputs in the order of AUTO_PIN_* type */
+	for (i = 0; i < cfg->num_inputs; i++)
+		cfg->inputs[i].order = i;
 	sort(cfg->inputs, cfg->num_inputs, sizeof(cfg->inputs[0]),
 	     compare_input_type, NULL);
 
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index df63d66af1ab..8bb8202cf284 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -35,6 +35,7 @@ struct auto_pin_cfg_item {
 	unsigned int is_headset_mic:1;
 	unsigned int is_headphone_mic:1; /* Mic-only in headphone jack */
 	unsigned int has_boost_on_pin:1;
+	int order;
 };
 
 struct auto_pin_cfg;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eec488aa7890..183c8a587acf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9583,6 +9583,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1360, "Acer Aspire A115", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x141f, "Acer Spin SP513-54N", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x142b, "Acer Swift SF314-42", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
@@ -9792,6 +9793,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x887c, "HP Laptop 14s-fq1xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x888a, "HP ENVY x360 Convertible 15-eu0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
@@ -10212,6 +10214,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x9e56, "Lenovo ZhaoYang CF4620Z", ALC286_FIXUP_SONY_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1849, 0x0269, "Positivo Master C6400", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
 	SND_PCI_QUIRK(0x1849, 0xa233, "Positivo Master C6300", ALC269_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 44d4e6e51a35..6e358909bc5e 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -103,7 +103,7 @@ config SND_SOC_AMD_ACP6x
 config SND_SOC_AMD_YC_MACH
 	tristate "AMD YC support for DMIC"
 	select SND_SOC_DMIC
-	depends on SND_SOC_AMD_ACP6x
+	depends on SND_SOC_AMD_ACP6x && ACPI
 	help
 	  This option enables machine driver for Yellow Carp platform
 	  using dmic. ACP IP has PDM Decoder block with DMA controller.
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 9c1bf0eb2deb..b45ff8f65f5e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -297,6 +297,34 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83AS"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/intel/avs/apl.c b/sound/soc/intel/avs/apl.c
index f366478a875d..c4a0b9104151 100644
--- a/sound/soc/intel/avs/apl.c
+++ b/sound/soc/intel/avs/apl.c
@@ -112,7 +112,7 @@ static int apl_coredump(struct avs_dev *adev, union avs_notify_msg *msg)
 	struct apl_log_buffer_layout layout;
 	void __iomem *addr, *buf;
 	size_t dump_size;
-	u16 offset = 0;
+	u32 offset = 0;
 	u8 *dump, *pos;
 
 	dump_size = AVS_FW_REGS_SIZE + msg->ext.coredump.stack_dump_size;
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index e7d20011e288..67b343632a10 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1122,7 +1122,22 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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
diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index bcea52fa45a5..d20438cf8fc4 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -24,7 +24,6 @@
 
 #define DRV_NAME "rockchip-i2s-tdm"
 
-#define DEFAULT_MCLK_FS				256
 #define CH_GRP_MAX				4  /* The max channel 8 / 2 */
 #define MULTIPLEX_CH_MAX			10
 
@@ -72,6 +71,8 @@ struct rk_i2s_tdm_dev {
 	bool has_playback;
 	bool has_capture;
 	struct snd_soc_dai_driver *dai;
+	unsigned int mclk_rx_freq;
+	unsigned int mclk_tx_freq;
 };
 
 static int to_ch_num(unsigned int val)
@@ -641,6 +642,27 @@ static int rockchip_i2s_trcm_mode(struct snd_pcm_substream *substream,
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
@@ -655,15 +677,19 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 
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
 
@@ -822,6 +848,7 @@ static const struct snd_soc_dai_ops rockchip_i2s_tdm_dai_ops = {
 	.hw_params = rockchip_i2s_tdm_hw_params,
 	.set_bclk_ratio	= rockchip_i2s_tdm_set_bclk_ratio,
 	.set_fmt = rockchip_i2s_tdm_set_fmt,
+	.set_sysclk = rockchip_i2s_tdm_set_sysclk,
 	.set_tdm_slot = rockchip_dai_tdm_slot,
 	.trigger = rockchip_i2s_tdm_trigger,
 };
diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 5d6bae33ae34..468050467bb3 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -244,8 +244,7 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 			    unsigned int channels)
 {
-	static s8 ckdv[16] = { 1,  2,  4,  8, 16, 32, 64, 128,
-			       6, 12, 24, 48, 96, -1, -1, -1 };
+	static u8 ckdv[] = { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 };
 	unsigned int channel_bits = 32;	/* System Word Length */
 	unsigned long bclk_rate = rate * channels * channel_bits;
 	unsigned int div;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f3964060a044..3f998a09fc42 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -906,7 +906,13 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 		snd_soc_dai_digital_mute(dai, 0, substream->stream);
 
 out:
-	return soc_pcm_ret(rtd, ret);
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
+	return ret;
 }
 
 /* PCM prepare ops for non-DPCM streams */
@@ -918,6 +924,13 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dpcm_mutex_lock(rtd);
 	ret = __soc_pcm_prepare(rtd, substream);
 	snd_soc_dpcm_mutex_unlock(rtd);
+
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
 	return ret;
 }
 
@@ -2422,7 +2435,13 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
 	}
 
-	return soc_pcm_ret(fe, ret);
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
+	return ret;
 }
 
 static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
@@ -2459,7 +2478,13 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 	snd_soc_dpcm_mutex_unlock(fe);
 
-	return soc_pcm_ret(fe, ret);
+	/*
+	 * Don't use soc_pcm_ret() on .prepare callback to lower error log severity
+	 *
+	 * We don't want to log an error since we do not want to give userspace a way to do a
+	 * denial-of-service attack on the syslog / diskspace.
+	 */
+	return ret;
 }
 
 static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 484b0e7c2def..84e7b363ac3b 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -177,6 +177,7 @@ struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
 	unsigned int val_fctl_ftx;
+	unsigned int mclk_multiplier;
 };
 
 struct sun4i_spdif_dev {
@@ -314,6 +315,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk *= host->quirks->mclk_multiplier;
 
 	ret = clk_set_rate(host->spdif_clk, mclk);
 	if (ret < 0) {
@@ -348,6 +350,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk_div *= host->quirks->mclk_multiplier;
 
 	reg_val = 0;
 	reg_val |= SUN4I_SPDIF_TXCFG_ASS;
@@ -541,24 +544,28 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
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
index 219fa6ff14bd..e08e1b998044 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2241,6 +2241,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
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
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 7d28f21b007f..5a99bf6af445 100644
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
@@ -2597,14 +2591,14 @@ int bpf_linker__finalize(struct bpf_linker *linker)
 
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
index af1cb30556b4..b8e83712a5d7 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -653,7 +653,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
 		 */
 		usdt_abs_ip = note.loc_addr;
-		if (base_addr)
+		if (base_addr && note.base_addr)
 			usdt_abs_ip += base_addr - note.base_addr;
 
 		/* When attaching uprobes (which is what USDTs basically are)
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
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 99e17a0a1364..aecea16cbd02 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2399,6 +2399,11 @@ sub get_version {
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
@@ -2939,8 +2944,6 @@ sub run_bisect_test {
 
     my $failed = 0;
     my $result;
-    my $output;
-    my $ret;
 
     $in_bisect = 1;
 
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 365a2c7a89ba..8766e88b5a40 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -296,6 +296,7 @@ else
 	client_connect
 	verify_data
 	server_listen
+	wait_for_port ${port} ${netcat_opt}
 fi
 
 # bpf_skb_net_shrink does not take tunnel flags yet, cannot update L3.
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 185b02d2d4cd..7af78990b5bb 100755
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
@@ -640,7 +640,7 @@ for port in 0 1; do
     NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
-    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
+    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
 
     msg="1 - create VxLANs v6"
     exp0=( 0 0 0 0 )
@@ -662,7 +662,7 @@ for port in 0 1; do
     new_geneve gnv0 20000
 
     msg="2 - destroy GENEVE"
-    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
+    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
     exp1=( `mke 20000 2` 0 0 0 )
     del_dev gnv0
 
@@ -763,7 +763,7 @@ for port in 0 1; do
     msg="create VxLANs v4"
     new_vxlan vxlan0 10000 $NSIM_NETDEV
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="NIC device goes down"
@@ -774,7 +774,7 @@ for port in 0 1; do
     fi
     check_tables
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="NIC device goes up again"
@@ -788,7 +788,7 @@ for port in 0 1; do
     del_dev vxlan0
     check_tables
 
-    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
     check_tables
 
     msg="destroy NIC"
@@ -895,7 +895,7 @@ msg="vacate VxLAN in overflow table"
 exp0=( `mke 10000 1` `mke 10004 1` 0 `mke 10003 1` )
 del_dev vxlan2
 
-echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
 check_tables
 
 msg="tunnels destroyed 2"
diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index bf67b23ed29a..46101a800beb 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -46,12 +46,6 @@ remove_chip() {
 	rmdir $CONFIGFS_DIR/$CHIP || fail "Unable to remove the chip"
 }
 
-configfs_cleanup() {
-	for CHIP in `ls $CONFIGFS_DIR/`; do
-		remove_chip $CHIP
-	done
-}
-
 create_chip() {
 	local CHIP=$1
 
@@ -105,6 +99,13 @@ disable_chip() {
 	echo 0 > $CONFIGFS_DIR/$CHIP/live || fail "Unable to disable the chip"
 }
 
+configfs_cleanup() {
+	for CHIP in `ls $CONFIGFS_DIR/`; do
+		disable_chip $CHIP
+		remove_chip $CHIP
+	done
+}
+
 configfs_chip_name() {
 	local CHIP=$1
 	local BANK=$2
@@ -181,6 +182,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -n `cat $CONFIGFS_DIR/chip/bank/chip_name` || fail "chip_name doesn't work"
+disable_chip chip
 remove_chip chip
 
 echo "1.2. chip_name returns 'none' if the chip is still pending"
@@ -195,6 +197,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -n `cat $CONFIGFS_DIR/chip/dev_name` || fail "dev_name doesn't work"
+disable_chip chip
 remove_chip chip
 
 echo "2. Creating and configuring simulated chips"
@@ -204,6 +207,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test "`get_chip_num_lines chip bank`" = "1" || fail "default number of lines is not 1"
+disable_chip chip
 remove_chip chip
 
 echo "2.2. Number of lines can be specified"
@@ -212,6 +216,7 @@ create_bank chip bank
 set_num_lines chip bank 16
 enable_chip chip
 test "`get_chip_num_lines chip bank`" = "16" || fail "number of lines is not 16"
+disable_chip chip
 remove_chip chip
 
 echo "2.3. Label can be set"
@@ -220,6 +225,7 @@ create_bank chip bank
 set_label chip bank foobar
 enable_chip chip
 test "`get_chip_label chip bank`" = "foobar" || fail "label is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.4. Label can be left empty"
@@ -227,6 +233,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -z "`cat $CONFIGFS_DIR/chip/bank/label`" || fail "label is not empty"
+disable_chip chip
 remove_chip chip
 
 echo "2.5. Line names can be configured"
@@ -238,6 +245,7 @@ set_line_name chip bank 2 bar
 enable_chip chip
 test "`get_line_name chip bank 0`" = "foo" || fail "line name is incorrect"
 test "`get_line_name chip bank 2`" = "bar" || fail "line name is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.6. Line config can remain unused if offset is greater than number of lines"
@@ -248,6 +256,7 @@ set_line_name chip bank 5 foobar
 enable_chip chip
 test "`get_line_name chip bank 0`" = "" || fail "line name is incorrect"
 test "`get_line_name chip bank 1`" = "" || fail "line name is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.7. Line configfs directory names are sanitized"
@@ -267,6 +276,7 @@ for CHIP in $CHIPS; do
 	enable_chip $CHIP
 done
 for CHIP in $CHIPS; do
+  disable_chip $CHIP
 	remove_chip $CHIP
 done
 
@@ -278,6 +288,7 @@ echo foobar > $CONFIGFS_DIR/chip/bank/label 2> /dev/null && \
 	fail "Setting label of a live chip should fail"
 echo 8 > $CONFIGFS_DIR/chip/bank/num_lines 2> /dev/null && \
 	fail "Setting number of lines of a live chip should fail"
+disable_chip chip
 remove_chip chip
 
 echo "2.10. Can't create line items when chip is live"
@@ -285,6 +296,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 mkdir $CONFIGFS_DIR/chip/bank/line0 2> /dev/null && fail "Creating line item should fail"
+disable_chip chip
 remove_chip chip
 
 echo "2.11. Probe errors are propagated to user-space"
@@ -316,6 +328,7 @@ mkdir -p $CONFIGFS_DIR/chip/bank/line4/hog
 enable_chip chip
 $BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 4 2> /dev/null && \
 	fail "Setting the value of a hogged line shouldn't succeed"
+disable_chip chip
 remove_chip chip
 
 echo "3. Controlling simulated chips"
@@ -331,6 +344,7 @@ test "$?" = "1" || fail "pull set incorrectly"
 sysfs_set_pull chip bank 0 pull-down
 $BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip bank` 1
 test "$?" = "0" || fail "pull set incorrectly"
+disable_chip chip
 remove_chip chip
 
 echo "3.2. Pull can be read from sysfs"
@@ -344,6 +358,7 @@ SYSFS_PATH=/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/pull
 test `cat $SYSFS_PATH` = "pull-down" || fail "reading the pull failed"
 sysfs_set_pull chip bank 0 pull-up
 test `cat $SYSFS_PATH` = "pull-up" || fail "reading the pull failed"
+disable_chip chip
 remove_chip chip
 
 echo "3.3. Incorrect input in sysfs is rejected"
@@ -355,6 +370,7 @@ DEVNAME=`configfs_dev_name chip`
 CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/pull"
 echo foobar > $SYSFS_PATH 2> /dev/null && fail "invalid input not detected"
+disable_chip chip
 remove_chip chip
 
 echo "3.4. Can't write to value"
@@ -365,6 +381,7 @@ DEVNAME=`configfs_dev_name chip`
 CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 echo 1 > $SYSFS_PATH 2> /dev/null && fail "writing to 'value' succeeded unexpectedly"
+disable_chip chip
 remove_chip chip
 
 echo "4. Simulated GPIO chips are functional"
@@ -382,6 +399,7 @@ $BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 0 &
 sleep 0.1 # FIXME Any better way?
 test `cat $SYSFS_PATH` = "1" || fail "incorrect value read from sysfs"
 kill $!
+disable_chip chip
 remove_chip chip
 
 echo "4.2. Bias settings work correctly"
@@ -394,6 +412,7 @@ CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
 test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
+disable_chip chip
 remove_chip chip
 
 echo "GPIO $MODULE test PASS"
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 584687c3286d..9d1379da59df 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -709,33 +709,33 @@
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
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f2c3bffa6ea5..864309ebb0b4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1775,8 +1775,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	ASSERT_EQ(1, WIFEXITED(status));
 	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
 	{
-		TH_LOG("Unexpected return code for \"%s\": %s", path,
-		       strerror(errno));
+		TH_LOG("Unexpected return code for \"%s\"", path);
 	};
 }
 
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index be4a30a0d02a..9b44a091802c 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -227,7 +227,8 @@ static int rtattr_pack(struct nlmsghdr *nh, size_t req_sz,
 
 	attr->rta_len = RTA_LENGTH(size);
 	attr->rta_type = rta_type;
-	memcpy(RTA_DATA(attr), payload, size);
+	if (payload)
+		memcpy(RTA_DATA(attr), payload, size);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b9b947b30772..ae2d76d4b404 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1216,7 +1216,7 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd);
+		shutdown(fd, SHUT_WR);
 	} else if (--cfg_repeat > 0) {
 		xdisconnect(fd);
 
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index dbfa56173d29..33f4fb34ac9b 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -197,6 +197,12 @@
 #
 # - pmtu_ipv6_route_change
 #	Same as above but with IPv6
+#
+# - pmtu_ipv4_mp_exceptions
+#	Use the same topology as in pmtu_ipv4, but add routeable addresses
+#	on host A and B on lo reachable via both routers. Host A and B
+#	addresses have multipath routes to each other, b_r1 mtu = 1500.
+#	Check that PMTU exceptions are created for both paths.
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -266,7 +272,8 @@ tests="
 	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
 	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
 	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
-	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
+	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
+	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions	1"
 
 NS_A="ns-A"
 NS_B="ns-B"
@@ -353,6 +360,9 @@ tunnel6_a_addr="fd00:2::a"
 tunnel6_b_addr="fd00:2::b"
 tunnel6_mask="64"
 
+host4_a_addr="192.168.99.99"
+host4_b_addr="192.168.88.88"
+
 dummy6_0_prefix="fc00:1000::"
 dummy6_1_prefix="fc00:1001::"
 dummy6_mask="64"
@@ -907,6 +917,52 @@ setup_ovs_bridge() {
 	run_cmd ip route add ${prefix6}:${b_r1}::1 via ${prefix6}:${a_r1}::2
 }
 
+setup_multipath_new() {
+	# Set up host A with multipath routes to host B host4_b_addr
+	run_cmd ${ns_a} ip addr add ${host4_a_addr} dev lo
+	run_cmd ${ns_a} ip nexthop add id 401 via ${prefix4}.${a_r1}.2 dev veth_A-R1
+	run_cmd ${ns_a} ip nexthop add id 402 via ${prefix4}.${a_r2}.2 dev veth_A-R2
+	run_cmd ${ns_a} ip nexthop add id 403 group 401/402
+	run_cmd ${ns_a} ip route add ${host4_b_addr} src ${host4_a_addr} nhid 403
+
+	# Set up host B with multipath routes to host A host4_a_addr
+	run_cmd ${ns_b} ip addr add ${host4_b_addr} dev lo
+	run_cmd ${ns_b} ip nexthop add id 401 via ${prefix4}.${b_r1}.2 dev veth_B-R1
+	run_cmd ${ns_b} ip nexthop add id 402 via ${prefix4}.${b_r2}.2 dev veth_B-R2
+	run_cmd ${ns_b} ip nexthop add id 403 group 401/402
+	run_cmd ${ns_b} ip route add ${host4_a_addr} src ${host4_b_addr} nhid 403
+}
+
+setup_multipath_old() {
+	# Set up host A with multipath routes to host B host4_b_addr
+	run_cmd ${ns_a} ip addr add ${host4_a_addr} dev lo
+	run_cmd ${ns_a} ip route add ${host4_b_addr} \
+			src ${host4_a_addr} \
+			nexthop via ${prefix4}.${a_r1}.2 weight 1 \
+			nexthop via ${prefix4}.${a_r2}.2 weight 1
+
+	# Set up host B with multipath routes to host A host4_a_addr
+	run_cmd ${ns_b} ip addr add ${host4_b_addr} dev lo
+	run_cmd ${ns_b} ip route add ${host4_a_addr} \
+			src ${host4_b_addr} \
+			nexthop via ${prefix4}.${b_r1}.2 weight 1 \
+			nexthop via ${prefix4}.${b_r2}.2 weight 1
+}
+
+setup_multipath() {
+	if [ "$USE_NH" = "yes" ]; then
+		setup_multipath_new
+	else
+		setup_multipath_old
+	fi
+
+	# Set up routers with routes to dummies
+	run_cmd ${ns_r1} ip route add ${host4_a_addr} via ${prefix4}.${a_r1}.1
+	run_cmd ${ns_r2} ip route add ${host4_a_addr} via ${prefix4}.${a_r2}.1
+	run_cmd ${ns_r1} ip route add ${host4_b_addr} via ${prefix4}.${b_r1}.1
+	run_cmd ${ns_r2} ip route add ${host4_b_addr} via ${prefix4}.${b_r2}.1
+}
+
 setup() {
 	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
 
@@ -988,23 +1044,15 @@ link_get_mtu() {
 }
 
 route_get_dst_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
+	ns_cmd="${1}"; shift
 
-	if [ -z "${dsfield}" ]; then
-		dsfield=0
-	fi
-
-	${ns_cmd} ip route get "${dst}" dsfield "${dsfield}"
+	${ns_cmd} ip route get "$@"
 }
 
 route_get_dst_pmtu_from_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
+	ns_cmd="${1}"; shift
 
-	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "${dst}" "${dsfield}")"
+	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "$@")"
 }
 
 check_pmtu_value() {
@@ -1147,10 +1195,10 @@ test_pmtu_ipv4_dscp_icmp_exception() {
 	run_cmd "${ns_a}" ping -q -M want -Q "${dsfield}" -c 1 -w 1 -s "${len}" "${dst2}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" dsfield "${policy_mark}")"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
 
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" dsfield "${policy_mark}")"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -1197,9 +1245,9 @@ test_pmtu_ipv4_dscp_udp_exception() {
 		UDP:"${dst2}":50000,tos="${dsfield}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" dsfield "${policy_mark}")"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" dsfield "${policy_mark}")"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -2205,6 +2253,36 @@ test_pmtu_ipv6_route_change() {
 	test_pmtu_ipvX_route_change 6
 }
 
+test_pmtu_ipv4_mp_exceptions() {
+	setup namespaces routing multipath || return $ksft_skip
+
+	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
+	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
+	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
+	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
+
+	# Set up initial MTU values
+	mtu "${ns_a}"  veth_A-R1 2000
+	mtu "${ns_r1}" veth_R1-A 2000
+	mtu "${ns_r1}" veth_R1-B 1500
+	mtu "${ns_b}"  veth_B-R1 1500
+
+	mtu "${ns_a}"  veth_A-R2 2000
+	mtu "${ns_r2}" veth_R2-A 2000
+	mtu "${ns_r2}" veth_R2-B 1500
+	mtu "${ns_b}"  veth_B-R2 1500
+
+	# Ping and expect two nexthop exceptions for two routes
+	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
+
+	# Check that exceptions have been created with the correct PMTU
+	pmtu_a_R1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R1)"
+	pmtu_a_R2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R2)"
+
+	check_pmtu_value "1500" "${pmtu_a_R1}" "exceeding MTU (veth_A-R1)" || return 1
+	check_pmtu_value "1500" "${pmtu_a_R2}" "exceeding MTU (veth_A-R2)" || return 1
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index cafd14b1ed2a..ff1242f2afaa 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -813,10 +813,10 @@ kci_test_ipsec_offload()
 	# does driver have correct offload info
 	diff $sysfsf - << EOF
 SA count=2 tx=3
-sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
+sa[0] tx ipaddr=$dstip
 sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[0]    key=0x34333231 38373635 32313039 36353433
-sa[1] rx ipaddr=0x00000000 00000000 00000000 037ba8c0
+sa[1] rx ipaddr=$srcip
 sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[1]    key=0x34333231 38373635 32313039 36353433
 EOF
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index b02080d09fbc..d0fba50bd6ef 100644
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
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index b8ec6c15bccb..333195dc63d9 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -693,7 +693,7 @@ int osnoise_set_tracing_thresh(struct osnoise_context *context, long long tracin
 
 	retval = osnoise_write_ll_config("tracing_thresh", tracing_thresh);
 	if (retval < 0)
-		return -1;
+		return -2;
 
 	context->tracing_thresh = tracing_thresh;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index ed08295bfa12..b7a7dcd68b57 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -783,9 +783,20 @@ static struct osnoise_tool
 }
 
 static int stop_tracing;
+static struct trace_instance *hist_inst = NULL;
 static void stop_hist(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(hist_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
+	if (hist_inst)
+		trace_instance_stop(hist_inst);
 }
 
 /*
@@ -828,6 +839,12 @@ int timerlat_hist_main(int argc, char *argv[])
 	}
 
 	trace = &tool->trace;
+	/*
+	 * Save trace instance into global variable so that SIGINT can stop
+	 * the timerlat tracer.
+	 * Otherwise, rtla could loop indefinitely when overloaded.
+	 */
+	hist_inst = trace;
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -894,7 +911,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (trace_is_off(&tool->trace, &record->trace) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8fc0f6aa19da..46c3405a356f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -575,9 +575,20 @@ static struct osnoise_tool
 }
 
 static int stop_tracing;
+static struct trace_instance *top_inst = NULL;
 static void stop_top(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(top_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
+	if (top_inst)
+		trace_instance_stop(top_inst);
 }
 
 /*
@@ -620,6 +631,13 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 	trace = &top->trace;
+	/*
+	* Save trace instance into global variable so that SIGINT can stop
+	* the timerlat tracer.
+	* Otherwise, rtla could loop indefinitely when overloaded.
+	*/
+	top_inst = trace;
+
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -690,7 +708,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&top->trace, &record->trace)) {
+	if (trace_is_off(&top->trace, &record->trace) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e1ba6d9f4265..93e4032b2397 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -196,6 +196,14 @@ int trace_instance_start(struct trace_instance *trace)
 	return tracefs_trace_on(trace->inst);
 }
 
+/*
+ * trace_instance_stop - stop tracing a given rtla instance
+ */
+int trace_instance_stop(struct trace_instance *trace)
+{
+	return tracefs_trace_off(trace->inst);
+}
+
 /*
  * trace_events_free - free a list of trace events
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 2e9a89a25615..551a7cb81f63 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -21,6 +21,7 @@ struct trace_instance {
 
 int trace_instance_init(struct trace_instance *trace, char *tool_name);
 int trace_instance_start(struct trace_instance *trace);
+int trace_instance_stop(struct trace_instance *trace);
 void trace_instance_destroy(struct trace_instance *trace);
 
 struct trace_seq *get_trace_seq(void);

