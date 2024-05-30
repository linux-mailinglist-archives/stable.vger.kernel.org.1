Return-Path: <stable+bounces-47679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BA8D4691
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C51B233B2
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1714375A;
	Thu, 30 May 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YorZoXqG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82021142E60;
	Thu, 30 May 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055960; cv=none; b=DBdUwNk8tJ8hGtL+lRGDDMTLc5yWwTEoue1bgJcLnEaLfLfCnkbiHusjpLipfQ8+pOB5S3PzDQOQ+ZH/5mbo9vHKpkrGBvPZh/SgTd/BTP6gkq/nT3YsaSlUflp4VxheQZN+6L8o9ddmFbTD56mqkSWLJRP5zfsyhIYBvzKtKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055960; c=relaxed/simple;
	bh=cvMKS6Eu1e3LspQrlAIQlF3SvI/Bvn23mBggiz2hFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euB4XccINjmoIiIDzRNpbTQRKz3+4LHrfTm2WHUpbWK4LqycHRK6x3lTGQZii2bljRrrQBXOfiHkakXWWUdbcHJfdig516dyz+g0PjdCxfIK4gYOhwBjjrBM6LL/KwINXOZ9rLDKnAHrIp1rsub5ovS96QrVsrAFYdc28LqtV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YorZoXqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC07C2BBFC;
	Thu, 30 May 2024 07:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717055959;
	bh=cvMKS6Eu1e3LspQrlAIQlF3SvI/Bvn23mBggiz2hFo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YorZoXqG/fvlw+V+cSeLbeuVMCfS43CnHtwKfOBD2lpU+NqBWjGOlwDt+loA8NcOl
	 GHNIJDoQH06pC2XenpDfO0n5yUHzAC8ycLCBqFhcPjxpMCTiBfEAyk/nmOkuSq9ejW
	 9T/96TtexyLQUt8eTbzqZ6FrNd1pic7axRVrSe1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.8.12
Date: Thu, 30 May 2024 09:59:11 +0200
Message-ID: <2024053036-stipulate-bobsled-455f@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024053036-matron-confess-13e0@gregkh>
References: <2024053036-matron-confess-13e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31fdaf4fe9dd..9bfc972af240 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3399,6 +3399,9 @@
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
+			Note, "mitigations" is supported if and only if the
+			kernel was built with CPU_MITIGATIONS=y.
+
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
index cf456f8d9ddc..c87677f5e2a2 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
@@ -37,15 +37,15 @@ properties:
       active low.
     maxItems: 1
 
-  dovdd-supply:
+  DOVDD-supply:
     description:
       Definition of the regulator used as interface power supply.
 
-  avdd-supply:
+  AVDD-supply:
     description:
       Definition of the regulator used as analog power supply.
 
-  dvdd-supply:
+  DVDD-supply:
     description:
       Definition of the regulator used as digital power supply.
 
@@ -59,9 +59,9 @@ required:
   - reg
   - clocks
   - clock-names
-  - dovdd-supply
-  - avdd-supply
-  - dvdd-supply
+  - DOVDD-supply
+  - AVDD-supply
+  - DVDD-supply
   - reset-gpios
   - port
 
@@ -82,9 +82,9 @@ examples:
                 clock-names = "xvclk";
                 reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 
-                dovdd-supply = <&sw2_reg>;
-                dvdd-supply = <&sw2_reg>;
-                avdd-supply = <&reg_peri_3p15v>;
+                DOVDD-supply = <&sw2_reg>;
+                DVDD-supply = <&sw2_reg>;
+                AVDD-supply = <&reg_peri_3p15v>;
 
                 port {
                         ov2680_to_mipi: endpoint {
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 9793ea6f0fe6..575555810c2c 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -165,6 +165,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index 41a62fd2ae1f..c1fa379f5f3e 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -20,6 +20,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -68,6 +73,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index b634f57cd011..ca81c8afba79 100644
--- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -18,13 +18,15 @@ properties:
     oneOf:
       - enum:
           - loongson,ls2k1000-thermal
+          - loongson,ls2k2000-thermal
       - items:
           - enum:
-              - loongson,ls2k2000-thermal
+              - loongson,ls2k0500-thermal
           - const: loongson,ls2k1000-thermal
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -38,6 +40,24 @@ required:
   - interrupts
   - '#thermal-sensor-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls2k2000-thermal
+
+then:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 2
+
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Makefile b/Makefile
index ce6b03cce386..5447d5041e42 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 8
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index bddc82f78942..a83d29fed175 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -110,6 +110,7 @@ CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_SIMPLE_BRIDGE=y
+CONFIG_DRM_DW_HDMI=y
 CONFIG_DRM_LIMA=y
 CONFIG_FB_SIMPLE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 0a7186a93882..d4d7451c2c12 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -5,7 +5,6 @@
 #ifndef __ASM_IRQFLAGS_H
 #define __ASM_IRQFLAGS_H
 
-#include <asm/alternative.h>
 #include <asm/barrier.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f27acca550d5..5e7b0eb4687e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1518,6 +1518,27 @@ static void fpsimd_save_kernel_state(struct task_struct *task)
 	task->thread.kernel_fpsimd_cpu = smp_processor_id();
 }
 
+/*
+ * Invalidate any task's FPSIMD state that is present on this cpu.
+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
+ */
+static void fpsimd_flush_cpu_state(void)
+{
+	WARN_ON(!system_supports_fpsimd());
+	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may increase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sme_smstop();
+
+	set_thread_flag(TIF_FOREIGN_FPSTATE);
+}
+
 void fpsimd_thread_switch(struct task_struct *next)
 {
 	bool wrong_task, wrong_cpu;
@@ -1535,7 +1556,7 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 	if (test_tsk_thread_flag(next, TIF_KERNEL_FPSTATE)) {
 		fpsimd_load_kernel_state(next);
-		set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
+		fpsimd_flush_cpu_state();
 	} else {
 		/*
 		 * Fix up TIF_FOREIGN_FPSTATE to correctly describe next's
@@ -1824,27 +1845,6 @@ void fpsimd_flush_task_state(struct task_struct *t)
 	barrier();
 }
 
-/*
- * Invalidate any task's FPSIMD state that is present on this cpu.
- * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
- * before calling this function.
- */
-static void fpsimd_flush_cpu_state(void)
-{
-	WARN_ON(!system_supports_fpsimd());
-	__this_cpu_write(fpsimd_last_state.st, NULL);
-
-	/*
-	 * Leaving streaming mode enabled will cause issues for any kernel
-	 * NEON and leaving streaming mode or ZA enabled may increase power
-	 * consumption.
-	 */
-	if (system_supports_sme())
-		sme_smstop();
-
-	set_thread_flag(TIF_FOREIGN_FPSTATE);
-}
-
 /*
  * Save the FPSIMD state to memory and invalidate cpu view.
  * This function must be called with preemption disabled.
diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 0491bf453cd4..cac7cba81b65 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -884,4 +884,4 @@ static int __init init_hw_perf_events(void)
 
 	return 0;
 }
-early_initcall(init_hw_perf_events);
+pure_initcall(init_hw_perf_events);
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 3bcdd32a6b36..338b474910f7 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -430,7 +430,9 @@ resume:
 	movec	%a0,%dfc
 
 	/* restore status register */
-	movew	%a1@(TASK_THREAD+THREAD_SR),%sr
+	movew	%a1@(TASK_THREAD+THREAD_SR),%d0
+	oriw	#0x0700,%d0
+	movew	%d0,%sr
 
 	rts
 
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 4c8f8cbfa05f..e7f0f72c1b36 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -453,30 +453,18 @@ void mac_poweroff(void)
 
 void mac_reset(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_II &&
-	    macintosh_config->ident != MAC_MODEL_SE30) {
-		/* need ROMBASE in booter */
-		/* indeed, plus need to MAP THE ROM !! */
-
-		if (mac_bi_data.rombase == 0)
-			mac_bi_data.rombase = 0x40800000;
-
-		/* works on some */
-		rom_reset = (void *) (mac_bi_data.rombase + 0xa);
-
-		local_irq_disable();
-		rom_reset();
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
-	           macintosh_config->adb_type == MAC_ADB_CUDA) {
+	if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	    macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
+	} else
 #endif
 #ifdef CONFIG_ADB_PMU
-	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
+	if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
+	} else
 #endif
-	} else if (CPU_IS_030) {
-
+	if (CPU_IS_030) {
 		/* 030-specific reset routine.  The idea is general, but the
 		 * specific registers to reset are '030-specific.  Until I
 		 * have a non-030 machine, I can't test anything else.
@@ -524,6 +512,18 @@ void mac_reset(void)
 		    "jmp %/a0@\n\t" /* jump to the reset vector */
 		    ".chip 68k"
 		    : : "r" (offset), "a" (rombase) : "a0");
+	} else {
+		/* need ROMBASE in booter */
+		/* indeed, plus need to MAP THE ROM !! */
+
+		if (mac_bi_data.rombase == 0)
+			mac_bi_data.rombase = 0x40800000;
+
+		/* works on some */
+		rom_reset = (void *)(mac_bi_data.rombase + 0xa);
+
+		local_irq_disable();
+		rom_reset();
 	}
 
 	/* should never get here */
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 9370888c9a7e..90554a5558fb 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -180,29 +180,39 @@ asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 
 asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
 {
-	int code = FPE_FLTUNK;
-	unsigned long fpcsr = regs->fpcsr;
-
-	if (fpcsr & SPR_FPCSR_IVF)
-		code = FPE_FLTINV;
-	else if (fpcsr & SPR_FPCSR_OVF)
-		code = FPE_FLTOVF;
-	else if (fpcsr & SPR_FPCSR_UNF)
-		code = FPE_FLTUND;
-	else if (fpcsr & SPR_FPCSR_DZF)
-		code = FPE_FLTDIV;
-	else if (fpcsr & SPR_FPCSR_IXF)
-		code = FPE_FLTRES;
-
-	/* Clear all flags */
-	regs->fpcsr &= ~SPR_FPCSR_ALLF;
-
-	force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
+	if (user_mode(regs)) {
+		int code = FPE_FLTUNK;
+		unsigned long fpcsr = regs->fpcsr;
+
+		if (fpcsr & SPR_FPCSR_IVF)
+			code = FPE_FLTINV;
+		else if (fpcsr & SPR_FPCSR_OVF)
+			code = FPE_FLTOVF;
+		else if (fpcsr & SPR_FPCSR_UNF)
+			code = FPE_FLTUND;
+		else if (fpcsr & SPR_FPCSR_DZF)
+			code = FPE_FLTDIV;
+		else if (fpcsr & SPR_FPCSR_IXF)
+			code = FPE_FLTRES;
+
+		/* Clear all flags */
+		regs->fpcsr &= ~SPR_FPCSR_ALLF;
+
+		force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
+	} else {
+		pr_emerg("KERNEL: Illegal fpe exception 0x%.8lx\n", regs->pc);
+		die("Die:", regs, SIGFPE);
+	}
 }
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
+	if (user_mode(regs)) {
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
+	} else {
+		pr_emerg("KERNEL: Illegal trap exception 0x%.8lx\n", regs->pc);
+		die("Die:", regs, SIGILL);
+	}
 }
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 6f0c92e8149d..dcf61cbd3147 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -22,6 +22,7 @@ EXPORT_SYMBOL(memset);
 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
+EXPORT_SYMBOL(__cmpxchg_u8);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 558ec68d768e..60a2c5925161 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -566,10 +566,12 @@ static const struct fsl_msi_feature ipic_msi_feature = {
 	.msiir_offset = 0x38,
 };
 
+#ifdef CONFIG_EPAPR_PARAVIRT
 static const struct fsl_msi_feature vmpic_msi_feature = {
 	.fsl_pic_ip = FSL_PIC_IP_VMPIC,
 	.msiir_offset = 0,
 };
+#endif
 
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 910ba8837add..2acc7d876e1f 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -82,14 +82,14 @@ config ERRATA_THEAD
 
 	  Otherwise, please say "N" here to avoid unnecessary overhead.
 
-config ERRATA_THEAD_PBMT
-	bool "Apply T-Head memory type errata"
+config ERRATA_THEAD_MAE
+	bool "Apply T-Head's memory attribute extension (XTheadMae) errata"
 	depends on ERRATA_THEAD && 64BIT && MMU
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
-	  This will apply the memory type errata to handle the non-standard
-	  memory type bits in page-table-entries on T-Head SoCs.
+	  This will apply the memory attribute extension errata to handle the
+	  non-standard PTE utilization on T-Head SoCs (XTheadMae).
 
 	  If you don't know what to do here, say "Y".
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..bf6a0a6318ee 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,20 +19,26 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
-static bool errata_probe_pbmt(unsigned int stage,
-			      unsigned long arch_id, unsigned long impid)
+#define CSR_TH_SXSTATUS		0x5c0
+#define SXSTATUS_MAEE		_AC(0x200000, UL)
+
+static bool errata_probe_mae(unsigned int stage,
+			     unsigned long arch_id, unsigned long impid)
 {
-	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_MAE))
 		return false;
 
 	if (arch_id != 0 || impid != 0)
 		return false;
 
-	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
-	    stage == RISCV_ALTERNATIVES_MODULE)
-		return true;
+	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
+	    stage != RISCV_ALTERNATIVES_MODULE)
+		return false;
+
+	if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
+		return false;
 
-	return false;
+	return true;
 }
 
 /*
@@ -140,8 +146,8 @@ static u32 thead_errata_probe(unsigned int stage,
 {
 	u32 cpu_req_errata = 0;
 
-	if (errata_probe_pbmt(stage, archid, impid))
-		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
+	if (errata_probe_mae(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_MAE);
 
 	errata_probe_cmo(stage, archid, impid);
 
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index ea33288f8a25..9bad9dfa2f7a 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -23,7 +23,7 @@
 #endif
 
 #ifdef CONFIG_ERRATA_THEAD
-#define	ERRATA_THEAD_PBMT 0
+#define	ERRATA_THEAD_MAE 0
 #define	ERRATA_THEAD_PMU 1
 #define	ERRATA_THEAD_NUMBER 2
 #endif
@@ -53,20 +53,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
  * in the default case.
  */
 #define ALT_SVPBMT_SHIFT 61
-#define ALT_THEAD_PBMT_SHIFT 59
+#define ALT_THEAD_MAE_SHIFT 59
 #define ALT_SVPBMT(_val, prot)						\
 asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
 		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
 			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
 		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
-			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
+			ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
 		: "=r"(_val)						\
 		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
-		  "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
+		  "I"(prot##_THEAD >> ALT_THEAD_MAE_SHIFT),		\
 		  "I"(ALT_SVPBMT_SHIFT),				\
-		  "I"(ALT_THEAD_PBMT_SHIFT))
+		  "I"(ALT_THEAD_MAE_SHIFT))
 
-#ifdef CONFIG_ERRATA_THEAD_PBMT
+#ifdef CONFIG_ERRATA_THEAD_MAE
 /*
  * IO/NOCACHE memory types are handled together with svpbmt,
  * so on T-Head chips, check if no other memory type is set,
@@ -83,11 +83,11 @@ asm volatile(ALTERNATIVE(						\
 	"slli    t3, t3, %3\n\t"					\
 	"or      %0, %0, t3\n\t"					\
 	"2:",  THEAD_VENDOR_ID,						\
-		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
+		ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)		\
 	: "+r"(_val)							\
-	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
-	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),			\
-	  "I"(ALT_THEAD_PBMT_SHIFT)					\
+	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAE_SHIFT),		\
+	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAE_SHIFT),			\
+	  "I"(ALT_THEAD_MAE_SHIFT)					\
 	: "t3")
 #else
 #define ALT_THEAD_PMA(_val)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 0bd747d1d00f..29f031f68f48 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -516,33 +516,33 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		break;
 	/* src_reg = atomic_fetch_<op>(dst_reg + off16, src_reg) */
 	case BPF_ADD | BPF_FETCH:
-		emit(is64 ? rv_amoadd_d(rs, rs, rd, 0, 0) :
-		     rv_amoadd_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoadd_d(rs, rs, rd, 1, 1) :
+		     rv_amoadd_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_AND | BPF_FETCH:
-		emit(is64 ? rv_amoand_d(rs, rs, rd, 0, 0) :
-		     rv_amoand_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoand_d(rs, rs, rd, 1, 1) :
+		     rv_amoand_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_OR | BPF_FETCH:
-		emit(is64 ? rv_amoor_d(rs, rs, rd, 0, 0) :
-		     rv_amoor_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoor_d(rs, rs, rd, 1, 1) :
+		     rv_amoor_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_XOR | BPF_FETCH:
-		emit(is64 ? rv_amoxor_d(rs, rs, rd, 0, 0) :
-		     rv_amoxor_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoxor_d(rs, rs, rd, 1, 1) :
+		     rv_amoxor_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
 	case BPF_XCHG:
-		emit(is64 ? rv_amoswap_d(rs, rs, rd, 0, 0) :
-		     rv_amoswap_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
+		     rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 5cc46e0dde62..9725586f4259 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -146,7 +146,7 @@ int gmap_mprotect_notify(struct gmap *, unsigned long start,
 
 void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
 			     unsigned long gaddr, unsigned long vmaddr);
-int gmap_mark_unmergeable(void);
+int s390_disable_cow_sharing(void);
 void s390_unlist_old_asce(struct gmap *gmap);
 int s390_replace_asce(struct gmap *gmap);
 void s390_uv_destroy_pfns(unsigned long count, unsigned long *pfns);
diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index bb1b4bef1878..4c2dc7abc285 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -32,6 +32,11 @@ typedef struct {
 	unsigned int uses_skeys:1;
 	/* The mmu context uses CMM. */
 	unsigned int uses_cmm:1;
+	/*
+	 * The mmu context allows COW-sharing of memory pages (KSM, zeropage).
+	 * Note that COW-sharing during fork() is currently always allowed.
+	 */
+	unsigned int allow_cow_sharing:1;
 	/* The gmaps associated with this context are allowed to use huge pages. */
 	unsigned int allow_gmap_hpage_1m:1;
 } mm_context_t;
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 929af18b0908..a7789a9f6218 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -35,6 +35,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.has_pgste = 0;
 	mm->context.uses_skeys = 0;
 	mm->context.uses_cmm = 0;
+	mm->context.allow_cow_sharing = 1;
 	mm->context.allow_gmap_hpage_1m = 0;
 #endif
 	switch (mm->context.asce_limit) {
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 12a7b8678925..0a7055518ba2 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -566,10 +566,20 @@ static inline pud_t set_pud_bit(pud_t pud, pgprot_t prot)
 }
 
 /*
- * In the case that a guest uses storage keys
- * faults should no longer be backed by zero pages
+ * As soon as the guest uses storage keys or enables PV, we deduplicate all
+ * mapped shared zeropages and prevent new shared zeropages from getting
+ * mapped.
  */
-#define mm_forbids_zeropage mm_has_pgste
+#define mm_forbids_zeropage mm_forbids_zeropage
+static inline int mm_forbids_zeropage(struct mm_struct *mm)
+{
+#ifdef CONFIG_PGSTE
+	if (!mm->context.allow_cow_sharing)
+		return 1;
+#endif
+	return 0;
+}
+
 static inline int mm_uses_skeys(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea63ac769889..7c17be6ad480 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2631,9 +2631,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (r)
 			break;
 
-		mmap_write_lock(current->mm);
-		r = gmap_mark_unmergeable();
-		mmap_write_unlock(current->mm);
+		r = s390_disable_cow_sharing();
 		if (r)
 			break;
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 41a4a60c5e65..3b57837f3e91 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2547,41 +2547,6 @@ static inline void thp_split_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-/*
- * Remove all empty zero pages from the mapping for lazy refaulting
- * - This must be called after mm->context.has_pgste is set, to avoid
- *   future creation of zero pages
- * - This must be called after THP was disabled.
- *
- * mm contracts with s390, that even if mm were to remove a page table,
- * racing with the loop below and so causing pte_offset_map_lock() to fail,
- * it will never insert a page table containing empty zero pages once
- * mm_forbids_zeropage(mm) i.e. mm->context.has_pgste is set.
- */
-static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
-			   unsigned long end, struct mm_walk *walk)
-{
-	unsigned long addr;
-
-	for (addr = start; addr != end; addr += PAGE_SIZE) {
-		pte_t *ptep;
-		spinlock_t *ptl;
-
-		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-		if (!ptep)
-			break;
-		if (is_zero_pfn(pte_pfn(*ptep)))
-			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
-		pte_unmap_unlock(ptep, ptl);
-	}
-	return 0;
-}
-
-static const struct mm_walk_ops zap_zero_walk_ops = {
-	.pmd_entry	= __zap_zero_pages,
-	.walk_lock	= PGWALK_WRLOCK,
-};
-
 /*
  * switch on pgstes for its userspace process (for kvm)
  */
@@ -2599,22 +2564,142 @@ int s390_enable_sie(void)
 	mm->context.has_pgste = 1;
 	/* split thp mappings and disable thp for future mappings */
 	thp_split_mm(mm);
-	walk_page_range(mm, 0, TASK_SIZE, &zap_zero_walk_ops, NULL);
 	mmap_write_unlock(mm);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
-int gmap_mark_unmergeable(void)
+static int find_zeropage_pte_entry(pte_t *pte, unsigned long addr,
+				   unsigned long end, struct mm_walk *walk)
+{
+	unsigned long *found_addr = walk->private;
+
+	/* Return 1 of the page is a zeropage. */
+	if (is_zero_pfn(pte_pfn(*pte))) {
+		/*
+		 * Shared zeropage in e.g., a FS DAX mapping? We cannot do the
+		 * right thing and likely don't care: FAULT_FLAG_UNSHARE
+		 * currently only works in COW mappings, which is also where
+		 * mm_forbids_zeropage() is checked.
+		 */
+		if (!is_cow_mapping(walk->vma->vm_flags))
+			return -EFAULT;
+
+		*found_addr = addr;
+		return 1;
+	}
+	return 0;
+}
+
+static const struct mm_walk_ops find_zeropage_ops = {
+	.pte_entry	= find_zeropage_pte_entry,
+	.walk_lock	= PGWALK_WRLOCK,
+};
+
+/*
+ * Unshare all shared zeropages, replacing them by anonymous pages. Note that
+ * we cannot simply zap all shared zeropages, because this could later
+ * trigger unexpected userfaultfd missing events.
+ *
+ * This must be called after mm->context.allow_cow_sharing was
+ * set to 0, to avoid future mappings of shared zeropages.
+ *
+ * mm contracts with s390, that even if mm were to remove a page table,
+ * and racing with walk_page_range_vma() calling pte_offset_map_lock()
+ * would fail, it will never insert a page table containing empty zero
+ * pages once mm_forbids_zeropage(mm) i.e.
+ * mm->context.allow_cow_sharing is set to 0.
+ */
+static int __s390_unshare_zeropages(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+	unsigned long addr;
+	vm_fault_t fault;
+	int rc;
+
+	for_each_vma(vmi, vma) {
+		/*
+		 * We could only look at COW mappings, but it's more future
+		 * proof to catch unexpected zeropages in other mappings and
+		 * fail.
+		 */
+		if ((vma->vm_flags & VM_PFNMAP) || is_vm_hugetlb_page(vma))
+			continue;
+		addr = vma->vm_start;
+
+retry:
+		rc = walk_page_range_vma(vma, addr, vma->vm_end,
+					 &find_zeropage_ops, &addr);
+		if (rc < 0)
+			return rc;
+		else if (!rc)
+			continue;
+
+		/* addr was updated by find_zeropage_pte_entry() */
+		fault = handle_mm_fault(vma, addr,
+					FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
+					NULL);
+		if (fault & VM_FAULT_OOM)
+			return -ENOMEM;
+		/*
+		 * See break_ksm(): even after handle_mm_fault() returned 0, we
+		 * must start the lookup from the current address, because
+		 * handle_mm_fault() may back out if there's any difficulty.
+		 *
+		 * VM_FAULT_SIGBUS and VM_FAULT_SIGSEGV are unexpected but
+		 * maybe they could trigger in the future on concurrent
+		 * truncation. In that case, the shared zeropage would be gone
+		 * and we can simply retry and make progress.
+		 */
+		cond_resched();
+		goto retry;
+	}
+
+	return 0;
+}
+
+static int __s390_disable_cow_sharing(struct mm_struct *mm)
 {
+	int rc;
+
+	if (!mm->context.allow_cow_sharing)
+		return 0;
+
+	mm->context.allow_cow_sharing = 0;
+
+	/* Replace all shared zeropages by anonymous pages. */
+	rc = __s390_unshare_zeropages(mm);
 	/*
 	 * Make sure to disable KSM (if enabled for the whole process or
 	 * individual VMAs). Note that nothing currently hinders user space
 	 * from re-enabling it.
 	 */
-	return ksm_disable(current->mm);
+	if (!rc)
+		rc = ksm_disable(mm);
+	if (rc)
+		mm->context.allow_cow_sharing = 1;
+	return rc;
+}
+
+/*
+ * Disable most COW-sharing of memory pages for the whole process:
+ * (1) Disable KSM and unmerge/unshare any KSM pages.
+ * (2) Disallow shared zeropages and unshare any zerpages that are mapped.
+ *
+ * Not that we currently don't bother with COW-shared pages that are shared
+ * with parent/child processes due to fork().
+ */
+int s390_disable_cow_sharing(void)
+{
+	int rc;
+
+	mmap_write_lock(current->mm);
+	rc = __s390_disable_cow_sharing(current->mm);
+	mmap_write_unlock(current->mm);
+	return rc;
 }
-EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
+EXPORT_SYMBOL_GPL(s390_disable_cow_sharing);
 
 /*
  * Enable storage key handling from now on and initialize the storage
@@ -2683,7 +2768,7 @@ int s390_enable_skey(void)
 		goto out_up;
 
 	mm->context.uses_skeys = 1;
-	rc = gmap_mark_unmergeable();
+	rc = __s390_disable_cow_sharing(mm);
 	if (rc) {
 		mm->context.uses_skeys = 0;
 		goto out_up;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 5af0402e94b8..1d168a98ae21 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1427,8 +1427,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
 		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
 		      src_reg, dst_reg, off);				\
-	if (is32 && (insn->imm & BPF_FETCH))				\
-		EMIT_ZERO(src_reg);					\
+	if (insn->imm & BPF_FETCH) {					\
+		/* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */	\
+		_EMIT2(0x07e0);						\
+		if (is32)                                               \
+			EMIT_ZERO(src_reg);				\
+	}								\
 } while (0)
 		case BPF_ADD:
 		case BPF_ADD | BPF_FETCH:
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index aed1ea8e2c2f..74051b8ddf3e 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -44,17 +44,12 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (OPCODE_RTE(opcode))
 		return -EFAULT;	/* Bad breakpoint */
 
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = opcode;
 
 	return 0;
 }
 
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
-	p->opcode = *p->addr;
-}
-
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 3e07074e0098..06fed5a21e8b 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -33,7 +33,8 @@
  */
 
 /*	
- * asmlinkage __wsum csum_partial(const void *buf, int len, __wsum sum);
+ * unsigned int csum_partial(const unsigned char *buf, int len,
+ *                           unsigned int sum);
  */
 
 .text
@@ -45,31 +46,11 @@ ENTRY(csum_partial)
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */
+	mov	r5, r1
 	mov	r4, r0
-	tst	#3, r0		! Check alignment.
-	bt/s	2f		! Jump if alignment is ok.
-	 mov	r4, r7		! Keep a copy to check for alignment
+	tst	#2, r0		! Check alignment.
+	bt	2f		! Jump if alignment is ok.
 	!
-	tst	#1, r0		! Check alignment.
-	bt	21f		! Jump if alignment is boundary of 2bytes.
-
-	! buf is odd
-	tst	r5, r5
-	add	#-1, r5
-	bt	9f
-	mov.b	@r4+, r0
-	extu.b	r0, r0
-	addc	r0, r6		! t=0 from previous tst
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-	mov	r4, r0
-	tst	#2, r0
-	bt	2f
-21:
-	! buf is 2 byte aligned (len could be 0)
 	add	#-2, r5		! Alignment uses up two bytes.
 	cmp/pz	r5		!
 	bt/s	1f		! Jump if we had at least two bytes.
@@ -77,17 +58,16 @@ ENTRY(csum_partial)
 	bra	6f
 	 add	#2, r5		! r5 was < 2.  Deal with it.
 1:
+	mov	r5, r1		! Save new len for later use.
 	mov.w	@r4+, r0
 	extu.w	r0, r0
 	addc	r0, r6
 	bf	2f
 	add	#1, r6
 2:
-	! buf is 4 byte aligned (len could be 0)
-	mov	r5, r1
 	mov	#-5, r0
-	shld	r0, r1
-	tst	r1, r1
+	shld	r0, r5
+	tst	r5, r5
 	bt/s	4f		! if it's =0, go to 4f
 	 clrt
 	.align	2
@@ -109,31 +89,30 @@ ENTRY(csum_partial)
 	addc	r0, r6
 	addc	r2, r6
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	3b
 	 cmp/eq	#1, r0
-	! here, we know r1==0
-	addc	r1, r6			! add carry to r6
+	! here, we know r5==0
+	addc	r5, r6			! add carry to r6
 4:
-	mov	r5, r0
+	mov	r1, r0
 	and	#0x1c, r0
 	tst	r0, r0
-	bt	6f
-	! 4 bytes or more remaining
-	mov	r0, r1
-	shlr2	r1
+	bt/s	6f
+	 mov	r0, r5
+	shlr2	r5
 	mov	#0, r2
 5:
 	addc	r2, r6
 	mov.l	@r4+, r2
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	5b
 	 cmp/eq	#1, r0
 	addc	r2, r6
-	addc	r1, r6		! r1==0 here, so it means add carry-bit
+	addc	r5, r6		! r5==0 here, so it means add carry-bit
 6:
-	! 3 bytes or less remaining
+	mov	r1, r5
 	mov	#3, r0
 	and	r0, r5
 	tst	r5, r5
@@ -159,16 +138,6 @@ ENTRY(csum_partial)
 	mov	#0, r0
 	addc	r0, r6
 9:
-	! Check if the buffer was misaligned, if so realign sum
-	mov	r7, r0
-	tst	#1, r0
-	bt	10f
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-10:
 	rts
 	 mov	r6, r0
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f49999a6b83..bfccf1213871 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2474,9 +2474,13 @@ menuconfig CPU_MITIGATIONS
 	help
 	  Say Y here to enable options which enable mitigations for hardware
 	  vulnerabilities (usually related to speculative execution).
+	  Mitigations can be disabled or restricted to SMT systems at runtime
+	  via the "mitigations" kernel parameter.
 
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
+	  If you say N, all mitigations will be disabled.  This CANNOT be
+	  overridden at runtime.
+
+	  Say 'Y', unless you really know what you are doing.
 
 if CPU_MITIGATIONS
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index bf4a10a5794f..1dcb794c5479 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -398,6 +398,11 @@ SYM_CODE_START(startup_64)
 	call	sev_enable
 #endif
 
+	/* Preserve only the CR4 bits that must be preserved, and clear the rest */
+	movq	%cr4, %rax
+	andl	$(X86_CR4_PAE | X86_CR4_MCE | X86_CR4_LA57), %eax
+	movq	%rax, %cr4
+
 	/*
 	 * configure_5level_paging() updates the number of paging levels using
 	 * a trampoline in 32-bit addressable memory if the current number does
diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index ef73a3ab8726..791386d9a83a 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -154,5 +154,6 @@ SYM_TYPED_FUNC_START(nh_avx2)
 	vpaddq		T1, T0, T0
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
+	vzeroupper
 	RET
 SYM_FUNC_END(nh_avx2)
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 9918212faf91..0ffb072be956 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -716,6 +716,7 @@ SYM_TYPED_FUNC_START(sha256_transform_rorx)
 	popq	%r13
 	popq	%r12
 	popq	%rbx
+	vzeroupper
 	RET
 SYM_FUNC_END(sha256_transform_rorx)
 
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index f08496cd6870..24973f42c43f 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -680,6 +680,7 @@ SYM_TYPED_FUNC_START(sha512_transform_rorx)
 	pop	%r12
 	pop	%rbx
 
+	vzeroupper
 	RET
 SYM_FUNC_END(sha512_transform_rorx)
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e0ca8120aea8..1245000a8792 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
 
 static bool write_ok_or_segv(unsigned long ptr, size_t size)
 {
-	/*
-	 * XXX: if access_ok, get_user, and put_user handled
-	 * sig_on_uaccess_err, this could go away.
-	 */
-
 	if (!access_ok((void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
@@ -120,10 +115,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -172,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
@@ -234,12 +225,8 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto do_ret;  /* skip requested */
 
 	/*
-	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
-	 * preserve that behavior to make writing exploits harder.
+	 * With a real vsyscall, page faults cause SIGSEGV.
 	 */
-	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
-	current->thread.sig_on_uaccess_err = 1;
-
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
@@ -262,23 +249,12 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 	}
 
-	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
-
 check_fault:
 	if (ret == -EFAULT) {
 		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall fault (exploit attempt?)");
-
-		/*
-		 * If we failed to generate a signal for any reason,
-		 * generate one here.  (This should be impossible.)
-		 */
-		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
-				 !sigismember(&tsk->pending.signal, SIGSEGV)))
-			goto sigsegv;
-
-		return true;  /* Don't emulate the ret. */
+		goto sigsegv;
 	}
 
 	regs->ax = ret;
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 44b08b53ab32..c1d6cd58f809 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -62,7 +62,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old,
 	asm volatile(_lock "cmpxchg16b %[ptr]"				\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*ptr),				\
+		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
 		     : "memory");					\
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 9abb8cc4cd47..b78644962626 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -567,6 +567,8 @@ static inline void update_page_count(int level, unsigned long pages) { }
 extern pte_t *lookup_address(unsigned long address, unsigned int *level);
 extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 				    unsigned int *level);
+pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
+				  unsigned int *level, bool *nx, bool *rw);
 extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26620d7642a9..5636ad697394 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -479,7 +479,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..64df897c0ee3 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,8 +37,6 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
-extern int numa_fill_memblks(u64 start, u64 end);
-#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 13b45b9c806d..620f0af713ca 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -465,7 +465,7 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	return !__apply_microcode_amd(mc);
 }
 
-static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
+static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct firmware fw;
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 1123ef3ccf90..4334033658ed 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -193,11 +193,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	cur->warned = false;
 
 	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
+	 * The default adjust value cannot be assumed to be zero on any socket.
 	 */
-	if (tsc_async_resets)
-		cur->adjusted = bootval;
+	cur->adjusted = bootval;
 
 	/*
 	 * Check whether this CPU is the first in a package to come up. In
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 5168ee0360b2..d1ccd06c5312 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
@@ -698,10 +698,10 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66),(ev)
-51: vpdpbusds Vx,Hx,Wx (66),(ev)
-52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
-53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+50: vpdpbusd Vx,Hx,Wx (66)
+51: vpdpbusds Vx,Hx,Wx (66)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
 55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b01df023de04..e604d2d6cc8f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -717,39 +717,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 	WARN_ON_ONCE(user_mode(regs));
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			sanitize_error_code(address, &error_code);
-
-			set_signal_archinfo(address, error_code);
-
-			if (si_code == SEGV_PKUERR) {
-				force_sig_pkuerr((void __user *)address, pkey);
-			} else {
-				/* XXX: hwpoison faults will set the wrong code. */
-				force_sig_fault(signal, si_code, (void __user *)address);
-			}
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
-	}
 
 	/*
 	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 65e9a6e391c0..ce84ba86e69e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+#endif
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
@@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
-
-#endif
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 135bb594df8b..b4073fb452b6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -619,7 +619,8 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
  * Validate strict W^X semantics.
  */
 static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
-				  unsigned long pfn, unsigned long npg)
+				  unsigned long pfn, unsigned long npg,
+				  bool nx, bool rw)
 {
 	unsigned long end;
 
@@ -641,6 +642,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
 		return new;
 
+	/* Non-leaf translation entries can disable writing or execution. */
+	if (!rw || nx)
+		return new;
+
 	end = start + npg * PAGE_SIZE - 1;
 	WARN_ONCE(1, "CPA detected W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
 		  (unsigned long long)pgprot_val(old),
@@ -657,20 +662,26 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
+ * Return a pointer to the entry, the level of the mapping, and the effective
+ * NX and RW bits of all page table levels.
  */
-pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
-			     unsigned int *level)
+pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
+				  unsigned int *level, bool *nx, bool *rw)
 {
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 
 	*level = PG_LEVEL_NONE;
+	*nx = false;
+	*rw = true;
 
 	if (pgd_none(*pgd))
 		return NULL;
 
+	*nx |= pgd_flags(*pgd) & _PAGE_NX;
+	*rw &= pgd_flags(*pgd) & _PAGE_RW;
+
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
 		return NULL;
@@ -679,6 +690,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (p4d_large(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*nx |= p4d_flags(*p4d) & _PAGE_NX;
+	*rw &= p4d_flags(*p4d) & _PAGE_RW;
+
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
 		return NULL;
@@ -687,6 +701,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (pud_leaf(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*nx |= pud_flags(*pud) & _PAGE_NX;
+	*rw &= pud_flags(*pud) & _PAGE_RW;
+
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
 		return NULL;
@@ -695,11 +712,26 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (pmd_large(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
+	*nx |= pmd_flags(*pmd) & _PAGE_NX;
+	*rw &= pmd_flags(*pmd) & _PAGE_RW;
+
 	*level = PG_LEVEL_4K;
 
 	return pte_offset_kernel(pmd, address);
 }
 
+/*
+ * Lookup the page table entry for a virtual address in a specific pgd.
+ * Return a pointer to the entry and the level of the mapping.
+ */
+pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
+			     unsigned int *level)
+{
+	bool nx, rw;
+
+	return lookup_address_in_pgd_attr(pgd, address, level, &nx, &rw);
+}
+
 /*
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
@@ -715,13 +747,16 @@ pte_t *lookup_address(unsigned long address, unsigned int *level)
 EXPORT_SYMBOL_GPL(lookup_address);
 
 static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
-				  unsigned int *level)
+				  unsigned int *level, bool *nx, bool *rw)
 {
-	if (cpa->pgd)
-		return lookup_address_in_pgd(cpa->pgd + pgd_index(address),
-					       address, level);
+	pgd_t *pgd;
+
+	if (!cpa->pgd)
+		pgd = pgd_offset_k(address);
+	else
+		pgd = cpa->pgd + pgd_index(address);
 
-	return lookup_address(address, level);
+	return lookup_address_in_pgd_attr(pgd, address, level, nx, rw);
 }
 
 /*
@@ -849,12 +884,13 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
 	pte_t new_pte, *tmp;
 	enum pg_level level;
+	bool nx, rw;
 
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up already:
 	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
+	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (tmp != kpte)
 		return 1;
 
@@ -965,7 +1001,8 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
 				      psize, CPA_DETECT);
 
-	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages);
+	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages,
+			      nx, rw);
 
 	/*
 	 * If there is a conflict, split the large page.
@@ -1046,6 +1083,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	pte_t *pbase = (pte_t *)page_address(base);
 	unsigned int i, level;
 	pgprot_t ref_prot;
+	bool nx, rw;
 	pte_t *tmp;
 
 	spin_lock(&pgd_lock);
@@ -1053,7 +1091,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
+	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (tmp != kpte) {
 		spin_unlock(&pgd_lock);
 		return 1;
@@ -1594,10 +1632,11 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 	int do_split, err;
 	unsigned int level;
 	pte_t *kpte, old_pte;
+	bool nx, rw;
 
 	address = __cpa_addr(cpa, cpa->curpage);
 repeat:
-	kpte = _lookup_address_cpa(cpa, address, &level);
+	kpte = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (!kpte)
 		return __cpa_process_fault(cpa, address, primary);
 
@@ -1619,7 +1658,8 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
-		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1);
+		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1,
+				      nx, rw);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index df484885ccd4..f415c2cf5358 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1585,36 +1585,41 @@ st:			if (is_imm8(insn->off))
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
 				/* Conservatively check that src_reg + insn->off is a kernel address:
-				 *   src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
-				 * src_reg is used as scratch for src_reg += insn->off and restored
-				 * after emit_ldx if necessary
+				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
+				 *   and
+				 *   src_reg + insn->off < VSYSCALL_ADDR
 				 */
 
-				u64 limit = TASK_SIZE_MAX + PAGE_SIZE;
+				u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
 				u8 *end_of_jmp;
 
-				/* At end of these emitted checks, insn->off will have been added
-				 * to src_reg, so no need to do relative load with insn->off offset
-				 */
-				insn_off = 0;
+				/* movabsq r10, VSYSCALL_ADDR */
+				emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
+					       (u32)(long)VSYSCALL_ADDR);
 
-				/* movabsq r11, limit */
-				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
-				EMIT((u32)limit, 4);
-				EMIT(limit >> 32, 4);
+				/* mov src_reg, r11 */
+				EMIT_mov(AUX_REG, src_reg);
 
 				if (insn->off) {
-					/* add src_reg, insn->off */
-					maybe_emit_1mod(&prog, src_reg, true);
-					EMIT2_off32(0x81, add_1reg(0xC0, src_reg), insn->off);
+					/* add r11, insn->off */
+					maybe_emit_1mod(&prog, AUX_REG, true);
+					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
 				}
 
-				/* cmp src_reg, r11 */
-				maybe_emit_mod(&prog, src_reg, AUX_REG, true);
-				EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
+				/* sub r11, r10 */
+				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
+				EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
+
+				/* movabsq r10, limit */
+				emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
+					       (u32)(long)limit);
+
+				/* cmp r10, r11 */
+				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
+				EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
 
-				/* if unsigned '>=', goto load */
-				EMIT2(X86_JAE, 0);
+				/* if unsigned '>', goto load */
+				EMIT2(X86_JA, 0);
 				end_of_jmp = prog;
 
 				/* xor dst_reg, dst_reg */
@@ -1640,18 +1645,6 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JMP above */
 				start_of_ldx[-1] = prog - start_of_ldx;
 
-				if (insn->off && src_reg != dst_reg) {
-					/* sub src_reg, insn->off
-					 * Restore src_reg after "add src_reg, insn->off" in prev
-					 * if statement. But if src_reg == dst_reg, emit_ldx
-					 * above already clobbered src_reg, so no need to restore.
-					 * If add src_reg, insn->off was unnecessary, no need to
-					 * restore either.
-					 */
-					maybe_emit_1mod(&prog, src_reg, true);
-					EMIT2_off32(0x81, add_1reg(0xE8, src_reg), insn->off);
-				}
-
 				if (!bpf_prog->aux->extable)
 					break;
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 08aa0f25f12a..8d1c82795ea1 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b029fb81ebee..e7a44a7f617f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -746,6 +746,15 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes sections; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
+			continue;
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
diff --git a/block/blk-core.c b/block/blk-core.c
index 99d684085719..923b7d91e6dc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -976,10 +976,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
-	}
+	if (unlikely(time_after(now, stamp)) &&
+	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) &&
+	    (end || part_in_flight(part)))
+		__part_stat_add(part, io_ticks, now - stamp);
+
 	if (part->bd_partno) {
 		part = bdev_whole(part);
 		goto again;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2d470cf2173e..925c5eaac581 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -779,6 +779,8 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 25d2f3239eb6..f1d071810893 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -998,6 +998,8 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
@@ -1020,6 +1022,8 @@ static inline void blk_account_io_start(struct request *req)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, false);
+		part_stat_local_inc(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index 1ef920f72e0f..1154e87a4022 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -344,6 +344,7 @@ static inline bool blk_do_io_stat(struct request *rq)
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/block/fops.c b/block/fops.c
index 0cf8cf72cdfa..799821040601 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -387,7 +387,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->bdev = bdev;
 	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
-	if (iomap->offset >= isize)
+	if (offset >= isize)
 		return -EIO;
 	iomap->type = IOMAP_MAPPED;
 	iomap->addr = iomap->offset;
diff --git a/block/genhd.c b/block/genhd.c
index d0471f469f7d..2e4c2521584a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -118,7 +118,7 @@ static void part_stat_read_all(struct block_device *part,
 	}
 }
 
-static unsigned int part_in_flight(struct block_device *part)
+unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index c03bc105e575..152c85df92b2 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -70,8 +70,8 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 	}
 
 	if (*partdef == '(') {
-		int length;
-		char *next = strchr(++partdef, ')');
+		partdef++;
+		char *next = strsep(&partdef, ")");
 
 		if (!next) {
 			pr_warn("cmdline partition format is invalid.");
@@ -79,11 +79,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 			goto fail;
 		}
 
-		length = min_t(int, next - partdef,
-			       sizeof(new_subpart->name) - 1);
-		strscpy(new_subpart->name, partdef, length);
-
-		partdef = ++next;
+		strscpy(new_subpart->name, next, sizeof(new_subpart->name));
 	} else
 		new_subpart->name[0] = '\0';
 
@@ -117,14 +113,12 @@ static void free_subpart(struct cmdline_parts *parts)
 	}
 }
 
-static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
+static int parse_parts(struct cmdline_parts **parts, char *bdevdef)
 {
 	int ret = -EINVAL;
 	char *next;
-	int length;
 	struct cmdline_subpart **next_subpart;
 	struct cmdline_parts *newparts;
-	char buf[BDEVNAME_SIZE + 32 + 4];
 
 	*parts = NULL;
 
@@ -132,28 +126,19 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 	if (!newparts)
 		return -ENOMEM;
 
-	next = strchr(bdevdef, ':');
+	next = strsep(&bdevdef, ":");
 	if (!next) {
 		pr_warn("cmdline partition has no block device.");
 		goto fail;
 	}
 
-	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
-	strscpy(newparts->name, bdevdef, length);
+	strscpy(newparts->name, next, sizeof(newparts->name));
 	newparts->nr_subparts = 0;
 
 	next_subpart = &newparts->subpart;
 
-	while (next && *(++next)) {
-		bdevdef = next;
-		next = strchr(bdevdef, ',');
-
-		length = (!next) ? (sizeof(buf) - 1) :
-			min_t(int, next - bdevdef, sizeof(buf) - 1);
-
-		strscpy(buf, bdevdef, length);
-
-		ret = parse_subpart(next_subpart, buf);
+	while ((next = strsep(&bdevdef, ","))) {
+		ret = parse_subpart(next_subpart, next);
 		if (ret)
 			goto fail;
 
@@ -199,24 +184,17 @@ static int cmdline_parts_parse(struct cmdline_parts **parts,
 
 	*parts = NULL;
 
-	next = pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
+	pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	next_parts = parts;
 
-	while (next && *pbuf) {
-		next = strchr(pbuf, ';');
-		if (next)
-			*next = '\0';
-
-		ret = parse_parts(next_parts, pbuf);
+	while ((next = strsep(&pbuf, ";"))) {
+		ret = parse_parts(next_parts, next);
 		if (ret)
 			goto fail;
 
-		if (next)
-			pbuf = ++next;
-
 		next_parts = &(*next_parts)->next_parts;
 	}
 
@@ -250,7 +228,6 @@ static struct cmdline_parts *bdev_parts;
 static int add_part(int slot, struct cmdline_subpart *subpart,
 		struct parsed_partitions *state)
 {
-	int label_min;
 	struct partition_meta_info *info;
 	char tmp[sizeof(info->volname) + 4];
 
@@ -262,9 +239,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 
 	info = &state->parts[slot].info;
 
-	label_min = min_t(int, sizeof(info->volname) - 1,
-			  sizeof(subpart->name));
-	strscpy(info->volname, subpart->name, label_min);
+	strscpy(info->volname, subpart->name, sizeof(info->volname));
 
 	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
 	strlcat(state->pp_buf, tmp, PAGE_SIZE);
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 59ec726b7c77..684767ab23e2 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -15,6 +15,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select MPILIB
 	select CRYPTO_HASH_INFO
 	select CRYPTO_AKCIPHER
+	select CRYPTO_SIG
 	select CRYPTO_HASH
 	help
 	  This option provides support for asymmetric public key type handling.
@@ -85,5 +86,7 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 	depends on X509_CERTIFICATE_PARSER
+	depends on CRYPTO_RSA
+	depends on CRYPTO_SHA256
 
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 736c2eb8c0f3..f677ad2177c2 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -574,7 +574,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < ARRAY_SIZE(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 04e273167e92..8e01792228d1 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -325,6 +325,7 @@ static const struct lpss_device_desc bsw_i2c_dev_desc = {
 
 static const struct property_entry bsw_spi_properties[] = {
 	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BSW_SSP),
+	PROPERTY_ENTRY_U32("num-cs", 2),
 	{ }
 };
 
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 30f3fc13c29d..8d18af396de9 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -5,6 +5,7 @@
 
 ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
+CFLAGS_tbfind.o 		+= $(call cc-disable-warning, stringop-truncation)
 
 # use acpi.o to put all files here into acpi.o modparam namespace
 obj-y	+= acpi.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 569bd15f211b..3f84d8ed9d29 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -316,9 +316,14 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PAD_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_THERMAL))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT;
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_OVER_16_PSTATES_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GED_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_IRQ_RESOURCE_SOURCE_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PRMT))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_FFH))
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 0214518fc582..3ca22db3ed5d 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -206,6 +206,11 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+__weak int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 36755f263e8e..3584f389b92c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2372,6 +2372,8 @@ static void __exit null_exit(void)
 
 	if (g_queue_mode == NULL_Q_MQ && shared_tags)
 		blk_mq_free_tag_set(&tag_set);
+
+	mutex_destroy(&lock);
 }
 
 module_init(null_init);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 9658b33c824a..18f34998a120 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -121,13 +121,6 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 				((event->data[2] == MODULE_BROUGHT_UP) ||
 				(event->data[2] == MODULE_ALREADY_UP)) ?
 				"Bring-up succeed" : "Bring-up failed");
-
-			if (event->length > 3 && event->data[3])
-				priv->btmrvl_dev.dev_type = HCI_AMP;
-			else
-				priv->btmrvl_dev.dev_type = HCI_PRIMARY;
-
-			BT_DBG("dev_type: %d", priv->btmrvl_dev.dev_type);
 		} else if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_SHUTDOWN_REQ) {
 			BT_DBG("EVENT:%s", (event->data[2]) ?
@@ -686,8 +679,6 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	hdev->wakeup = btmrvl_wakeup;
 	SET_HCIDEV_DEV(hdev, &card->func->dev);
 
-	hdev->dev_type = priv->btmrvl_dev.dev_type;
-
 	ret = hci_register_dev(hdev);
 	if (ret < 0) {
 		BT_ERR("Can not register HCI device");
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 638074992c82..35fb26cbf229 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -148,8 +148,10 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	}
 
 	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
-	if (!build_label)
+	if (!build_label) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	hci_set_fw_info(hdev, "%s", build_label);
 
diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index 634cf8f5ed2d..0c91d7635ac3 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -134,7 +134,6 @@ static int rsi_hci_attach(void *priv, struct rsi_proto_ops *ops)
 		hdev->bus = HCI_USB;
 
 	hci_set_drvdata(hdev, h_adapter);
-	hdev->dev_type = HCI_PRIMARY;
 	hdev->open = rsi_hci_open;
 	hdev->close = rsi_hci_close;
 	hdev->flush = rsi_hci_flush;
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index f19d31ee37ea..fdcfe9c50313 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -32,9 +32,6 @@ static const struct sdio_device_id btsdio_table[] = {
 	/* Generic Bluetooth Type-B SDIO device */
 	{ SDIO_DEVICE_CLASS(SDIO_CLASS_BT_B) },
 
-	/* Generic Bluetooth AMP controller */
-	{ SDIO_DEVICE_CLASS(SDIO_CLASS_BT_AMP) },
-
 	{ }	/* Terminating entry */
 };
 
@@ -319,11 +316,6 @@ static int btsdio_probe(struct sdio_func *func,
 	hdev->bus = HCI_SDIO;
 	hci_set_drvdata(hdev, data);
 
-	if (id->class == SDIO_CLASS_BT_AMP)
-		hdev->dev_type = HCI_AMP;
-	else
-		hdev->dev_type = HCI_PRIMARY;
-
 	data->hdev = hdev;
 
 	SET_HCIDEV_DEV(hdev, &func->dev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index effa54629648..a1b82abe06c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4314,11 +4314,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
 
-	if (id->driver_info & BTUSB_AMP)
-		hdev->dev_type = HCI_AMP;
-	else
-		hdev->dev_type = HCI_PRIMARY;
-
 	data->hdev = hdev;
 
 	SET_HCIDEV_DEV(hdev, &intf->dev);
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 9a7243d5db71..0c2f15235b4c 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2361,7 +2361,6 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bcm4377->hdev = hdev;
 
 	hdev->bus = HCI_PCI;
-	hdev->dev_type = HCI_PRIMARY;
 	hdev->open = bcm4377_hci_open;
 	hdev->close = bcm4377_hci_close;
 	hdev->send = bcm4377_hci_send_frame;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a26367e9fb19..17a2f158a0df 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -667,11 +667,6 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	if (!test_bit(HCI_UART_RESET_ON_INIT, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
-		hdev->dev_type = HCI_AMP;
-	else
-		hdev->dev_type = HCI_PRIMARY;
-
 	/* Only call open() for the protocol after hdev is fully initialized as
 	 * open() (or a timer/workqueue it starts) may attempt to reference it.
 	 */
@@ -722,7 +717,6 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 {
 	unsigned long valid_flags = BIT(HCI_UART_RAW_DEVICE) |
 				    BIT(HCI_UART_RESET_ON_INIT) |
-				    BIT(HCI_UART_CREATE_AMP) |
 				    BIT(HCI_UART_INIT_PENDING) |
 				    BIT(HCI_UART_EXT_CONFIG) |
 				    BIT(HCI_UART_VND_DETECT);
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 214fff876eae..0eaec878fa1d 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -366,11 +366,6 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	if (test_bit(HCI_UART_EXT_CONFIG, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
 
-	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
-		hdev->dev_type = HCI_AMP;
-	else
-		hdev->dev_type = HCI_PRIMARY;
-
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 68c8c7e95d64..00bf7ae82c5b 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -37,7 +37,6 @@
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-#define HCI_UART_CREATE_AMP	2
 #define HCI_UART_INIT_PENDING	3
 #define HCI_UART_EXT_CONFIG	4
 #define HCI_UART_VND_DETECT	5
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 572d68d52965..28750a40f0ed 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -384,17 +384,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
-	__u8 dev_type;
 
 	if (data->hdev)
 		return -EBADFD;
 
-	/* bits 0-1 are dev_type (Primary or AMP) */
-	dev_type = opcode & 0x03;
-
-	if (dev_type != HCI_PRIMARY && dev_type != HCI_AMP)
-		return -EINVAL;
-
 	/* bits 2-5 are reserved (must be zero) */
 	if (opcode & 0x3c)
 		return -EINVAL;
@@ -412,7 +405,6 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	data->hdev = hdev;
 
 	hdev->bus = HCI_VIRTUAL;
-	hdev->dev_type = dev_type;
 	hci_set_drvdata(hdev, data);
 
 	hdev->open  = vhci_open_dev;
@@ -634,7 +626,7 @@ static void vhci_open_timeout(struct work_struct *work)
 	struct vhci_data *data = container_of(work, struct vhci_data,
 					      open_timeout.work);
 
-	vhci_create_device(data, amp ? HCI_AMP : HCI_PRIMARY);
+	vhci_create_device(data, 0x00);
 }
 
 static int vhci_open(struct inode *inode, struct file *file)
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 2ac70b560c46..18208e152a36 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -274,7 +274,6 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	switch (type) {
 	case VIRTIO_BT_CONFIG_TYPE_PRIMARY:
-	case VIRTIO_BT_CONFIG_TYPE_AMP:
 		break;
 	default:
 		return -EINVAL;
@@ -303,7 +302,6 @@ static int virtbt_probe(struct virtio_device *vdev)
 	vbt->hdev = hdev;
 
 	hdev->bus = HCI_VIRTIO;
-	hdev->dev_type = type;
 	hci_set_drvdata(hdev, vbt);
 
 	hdev->open  = virtbt_open;
diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 379bc245c520..0e903d6e22e3 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -220,7 +220,8 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 				if (err && i > RNG_NB_RECOVER_TRIES) {
 					dev_err((struct device *)priv->rng.priv,
 						"Couldn't recover from seed error\n");
-					return -ENOTRECOVERABLE;
+					retval = -ENOTRECOVERABLE;
+					goto exit_rpm;
 				}
 
 				continue;
@@ -238,7 +239,8 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 			if (err && i > RNG_NB_RECOVER_TRIES) {
 				dev_err((struct device *)priv->rng.priv,
 					"Couldn't recover from seed error");
-				return -ENOTRECOVERABLE;
+				retval = -ENOTRECOVERABLE;
+				goto exit_rpm;
 			}
 
 			continue;
@@ -250,6 +252,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 		max -= sizeof(u32);
 	}
 
+exit_rpm:
 	pm_runtime_mark_last_busy((struct device *) priv->rng.priv);
 	pm_runtime_put_sync_autosuspend((struct device *) priv->rng.priv);
 
@@ -353,13 +356,15 @@ static int stm32_rng_init(struct hwrng *rng)
 	err = readl_relaxed_poll_timeout_atomic(priv->base + RNG_SR, reg,
 						reg & RNG_SR_DRDY,
 						10, 100000);
-	if (err | (reg & ~RNG_SR_DRDY)) {
+	if (err || (reg & ~RNG_SR_DRDY)) {
 		clk_disable_unprepare(priv->clk);
 		dev_err((struct device *)priv->rng.priv,
 			"%s: timeout:%x SR: %x!\n", __func__, err, reg);
 		return -EINVAL;
 	}
 
+	clk_disable_unprepare(priv->clk);
+
 	return 0;
 }
 
@@ -384,6 +389,11 @@ static int __maybe_unused stm32_rng_runtime_suspend(struct device *dev)
 static int __maybe_unused stm32_rng_suspend(struct device *dev)
 {
 	struct stm32_rng_private *priv = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		return err;
 
 	if (priv->data->has_cond_reset) {
 		priv->pm_conf.nscr = readl_relaxed(priv->base + RNG_NSCR);
@@ -465,6 +475,8 @@ static int __maybe_unused stm32_rng_resume(struct device *dev)
 		writel_relaxed(reg, priv->base + RNG_CR);
 	}
 
+	clk_disable_unprepare(priv->clk);
+
 	return 0;
 }
 
diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 53e21ac302e6..4c3a5e4eb77a 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -25,10 +25,12 @@
 #define RS9_REG_SS_AMP_0V7			0x1
 #define RS9_REG_SS_AMP_0V8			0x2
 #define RS9_REG_SS_AMP_0V9			0x3
+#define RS9_REG_SS_AMP_DEFAULT			RS9_REG_SS_AMP_0V8
 #define RS9_REG_SS_AMP_MASK			0x3
 #define RS9_REG_SS_SSC_100			0
 #define RS9_REG_SS_SSC_M025			(1 << 3)
 #define RS9_REG_SS_SSC_M050			(3 << 3)
+#define RS9_REG_SS_SSC_DEFAULT			RS9_REG_SS_SSC_100
 #define RS9_REG_SS_SSC_MASK			(3 << 3)
 #define RS9_REG_SS_SSC_LOCK			BIT(5)
 #define RS9_REG_SR				0x2
@@ -205,8 +207,8 @@ static int rs9_get_common_config(struct rs9_driver_data *rs9)
 	int ret;
 
 	/* Set defaults */
-	rs9->pll_amplitude = RS9_REG_SS_AMP_0V7;
-	rs9->pll_ssc = RS9_REG_SS_SSC_100;
+	rs9->pll_amplitude = RS9_REG_SS_AMP_DEFAULT;
+	rs9->pll_ssc = RS9_REG_SS_SSC_DEFAULT;
 
 	/* Output clock amplitude */
 	ret = of_property_read_u32(np, "renesas,out-amplitude-microvolt",
@@ -247,13 +249,13 @@ static void rs9_update_config(struct rs9_driver_data *rs9)
 	int i;
 
 	/* If amplitude is non-default, update it. */
-	if (rs9->pll_amplitude != RS9_REG_SS_AMP_0V7) {
+	if (rs9->pll_amplitude != RS9_REG_SS_AMP_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_AMP_MASK,
 				   rs9->pll_amplitude);
 	}
 
 	/* If SSC is non-default, update it. */
-	if (rs9->pll_ssc != RS9_REG_SS_SSC_100) {
+	if (rs9->pll_ssc != RS9_REG_SS_SSC_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_SSC_MASK,
 				   rs9->pll_ssc);
 	}
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 01a2ef8f594e..3f62ec750733 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -53,7 +53,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_MM_DSI0, "mm_dsi0", "mm_sel", 17),
 	GATE_MM0(CLK_MM_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 18),
 	GATE_MM0(CLK_MM_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 19),
-	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "dpi0_sel", 20),
 	GATE_MM0(CLK_MM_MM_FAKE, "mm_fake", "mm_sel", 21),
 	GATE_MM0(CLK_MM_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 22),
 	GATE_MM0(CLK_MM_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 23),
diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index 3a2b3f90be25..094ec8a26d66 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -68,7 +68,7 @@ void fhctl_parse_dt(const u8 *compatible_node, struct mtk_pllfh_data *pllfhs,
 
 	node = of_find_compatible_node(NULL, NULL, compatible_node);
 	if (!node) {
-		pr_err("cannot find \"%s\"\n", compatible_node);
+		pr_warn("cannot find \"%s\"\n", compatible_node);
 		return;
 	}
 
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 2a9da0939377..be35803c7a4b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -439,6 +439,7 @@ config SC_CAMCC_7280
 
 config SC_CAMCC_8280XP
 	tristate "SC8280XP Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_8280XP
 	help
 	  Support for the camera clock controller on Qualcomm Technologies, Inc
@@ -1069,6 +1070,7 @@ config SM_GPUCC_8550
 
 config SM_GPUCC_8650
 	tristate "SM8650 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8650
 	help
 	  Support for the graphics clock controller on SM8650 devices.
diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 678b805f13d4..5e3da5558f4e 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -73,8 +73,9 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	},
 };
 
+/* 1.008 GHz configuration */
 static const struct alpha_pll_config ipq5018_pll_config = {
-	.l = 0x32,
+	.l = 0x2a,
 	.config_ctl_val = 0x4001075b,
 	.config_ctl_hi_val = 0x304,
 	.main_output_mask = BIT(0),
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 05898d2a8b22..58ae73295980 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -212,7 +212,6 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_USER_CTL] = 0x18,
 		[PLL_OFF_USER_CTL_U] = 0x1c,
 		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_CONFIG_CTL_U] = 0xff,
 		[PLL_OFF_TEST_CTL] = 0x30,
 		[PLL_OFF_TEST_CTL_U] = 0x34,
 		[PLL_OFF_STATUS] = 0x28,
diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index ea6f54ed846e..441f042f5ea4 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -221,26 +221,17 @@ static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] = {
-	F(162000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
 	.cmd_rcgr = 0x10f8,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_dp_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_link_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index 2c4aecd75186..239cc726c7e2 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -309,26 +309,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
-	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.cmd_rcgr = 0x819c,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -382,13 +373,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -442,13 +432,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -502,13 +491,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index f96d8b81fd9a..c9b8c2eb5c64 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -345,26 +345,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
-	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.cmd_rcgr = 0x8170,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_7,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -418,13 +409,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -478,13 +468,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -538,13 +527,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index f3b1d9d16bae..c9b139faf1a8 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -343,26 +343,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
-	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.cmd_rcgr = 0x8170,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_7,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -416,13 +407,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -476,13 +466,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -536,13 +525,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 1180e48c687a..275fb3b71ede 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2535,6 +2535,8 @@ static struct clk_branch vmem_ahb_clk = {
 
 static struct gdsc video_top_gdsc = {
 	.gdscr = 0x1024,
+	.cxcs = (unsigned int []){ 0x1028, 0x1034, 0x1038 },
+	.cxc_count = 3,
 	.pd = {
 		.name = "video_top",
 	},
@@ -2543,20 +2545,26 @@ static struct gdsc video_top_gdsc = {
 
 static struct gdsc video_subcore0_gdsc = {
 	.gdscr = 0x1040,
+	.cxcs = (unsigned int []){ 0x1048 },
+	.cxc_count = 1,
 	.pd = {
 		.name = "video_subcore0",
 	},
 	.parent = &video_top_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
 };
 
 static struct gdsc video_subcore1_gdsc = {
 	.gdscr = 0x1044,
+	.cxcs = (unsigned int []){ 0x104c },
+	.cxc_count = 1,
 	.pd = {
 		.name = "video_subcore1",
 	},
 	.parent = &video_top_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
 };
 
 static struct gdsc mdss_gdsc = {
diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index 4c2872f45387..ff3f85e906fe 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -139,7 +139,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
 	DEF_MOD("avb3",		214,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb4",		215,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb5",		216,	R8A779A0_CLK_S3D2),
-	DEF_MOD("canfd0",	328,	R8A779A0_CLK_CANFD),
+	DEF_MOD("canfd0",	328,	R8A779A0_CLK_S3D2),
 	DEF_MOD("csi40",	331,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi41",	400,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi42",	401,	R8A779A0_CLK_CSI0),
diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 075ade0925d4..9ad7ceb3ab1b 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -265,6 +265,10 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x5a8, 1),
 	DEF_MOD("tsu_pclk",	R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
 				0x5ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_MOD("nceplic_aclk",	R9A07G043_NCEPLIC_ACLK, R9A07G043_CLK_P1,
+				0x608, 0),
+#endif
 };
 
 static struct rzg2l_reset r9a07g043_resets[] = {
@@ -318,6 +322,10 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A07G043_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A07G043_TSU_PRESETN, 0x8ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_RST(R9A07G043_NCEPLIC_ARESETN, 0x908, 0),
+#endif
+
 };
 
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
@@ -327,6 +335,7 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 #endif
 #ifdef CONFIG_RISCV
 	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+	MOD_CLK_BASE + R9A07G043_NCEPLIC_ACLK,
 #endif
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
index e9c06eb93e66..f04bacacab2c 100644
--- a/drivers/clk/samsung/clk-exynosautov9.c
+++ b/drivers/clk/samsung/clk-exynosautov9.c
@@ -352,13 +352,13 @@ static const struct samsung_pll_clock top_pll_clks[] __initconst = {
 	/* CMU_TOP_PURECLKCOMP */
 	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED0, PLL_CON3_PLL_SHARED0, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared1_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED1, PLL_CON3_PLL_SHARED1, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared2_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED2_PLL, "fout_shared2_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED2, PLL_CON3_PLL_SHARED2, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared3_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED3_PLL, "fout_shared3_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED3, PLL_CON3_PLL_SHARED3, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared4_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED4_PLL, "fout_shared4_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED4, PLL_CON3_PLL_SHARED4, NULL),
 };
 
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 1a1857b0a6f4..ea8438550b49 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,9 +481,12 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct private_data *priv;
+
 	if (!policy)
 		return 0;
-	struct private_data *priv = policy->driver_data;
+
+	priv = policy->driver_data;
 
 	cpufreq_cpu_put(policy);
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 64420d9cfd1e..15f1d41920a3 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -741,10 +741,15 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_cpudata *cpu_data;
 	u64 delivered_perf;
 	int ret;
 
+	if (!policy)
+		return -ENODEV;
+
+	cpu_data = policy->driver_data;
+
 	cpufreq_cpu_put(policy);
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
@@ -822,10 +827,15 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_cpudata *cpu_data;
 	u64 desired_perf;
 	int ret;
 
+	if (!policy)
+		return -ENODEV;
+
+	cpu_data = policy->driver_data;
+
 	cpufreq_cpu_put(policy);
 
 	ret = cppc_get_desired_perf(cpu, &desired_perf);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3c2c955fbbbd..86f1bc7754ea 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1670,10 +1670,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+		return;
 	}
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	policy->freq_table = NULL;
 }
 
 static int cpufreq_offline(unsigned int cpu)
@@ -1731,7 +1734,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	/* We did light-weight exit earlier, do full tear down now */
-	if (cpufreq_driver->offline)
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
 	up_write(&policy->rwsem);
diff --git a/drivers/crypto/bcm/spu2.c b/drivers/crypto/bcm/spu2.c
index 07989bb8c220..3fdc64b5a65e 100644
--- a/drivers/crypto/bcm/spu2.c
+++ b/drivers/crypto/bcm/spu2.c
@@ -495,7 +495,7 @@ static void spu2_dump_omd(u8 *omd, u16 hash_key_len, u16 ciph_key_len,
 	if (hash_iv_len) {
 		packet_log("  Hash IV Length %u bytes\n", hash_iv_len);
 		packet_dump("  hash IV: ", ptr, hash_iv_len);
-		ptr += ciph_key_len;
+		ptr += hash_iv_len;
 	}
 
 	if (ciph_iv_len) {
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 473301237760..ff6ceb4feee0 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -39,44 +39,38 @@ static const struct sp_dev_vdata dev_vdata[] = {
 	},
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id sp_acpi_match[] = {
 	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
-#endif
 
-#ifdef CONFIG_OF
 static const struct of_device_id sp_of_match[] = {
 	{ .compatible = "amd,ccp-seattle-v1a",
 	  .data = (const void *)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sp_of_match);
-#endif
 
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
 	const struct of_device_id *match;
 
 	match = of_match_node(sp_of_match, pdev->dev.of_node);
 	if (match && match->data)
 		return (struct sp_dev_vdata *)match->data;
-#endif
+
 	return NULL;
 }
 
 static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_ACPI
 	const struct acpi_device_id *match;
 
 	match = acpi_match_device(sp_acpi_match, &pdev->dev);
 	if (match && match->driver_data)
 		return (struct sp_dev_vdata *)match->driver_data;
-#endif
+
 	return NULL;
 }
 
@@ -212,12 +206,8 @@ static int sp_platform_resume(struct platform_device *pdev)
 static struct platform_driver sp_platform_driver = {
 	.driver = {
 		.name = "ccp",
-#ifdef CONFIG_ACPI
 		.acpi_match_table = sp_acpi_match,
-#endif
-#ifdef CONFIG_OF
 		.of_match_table = sp_of_match,
-#endif
 	},
 	.probe = sp_platform_probe,
 	.remove_new = sp_platform_remove,
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 7909b51e97c3..7b8abfb797ff 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -296,7 +296,7 @@ static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
 	if (adf_gen4_init_thd2arb_map(accel_dev))
 		dev_warn(&GET_DEV(accel_dev),
-			 "Generate of the thread to arbiter map failed");
+			 "Failed to generate thread to arbiter mapping");
 
 	return GET_HW_DATA(accel_dev)->thd_to_arb_map;
 }
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index e171cddf6f02..7a5c5f9711c8 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -208,7 +208,7 @@ static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
 	if (adf_gen4_init_thd2arb_map(accel_dev))
 		dev_warn(&GET_DEV(accel_dev),
-			 "Generate of the thread to arbiter map failed");
+			 "Failed to generate thread to arbiter mapping");
 
 	return GET_HW_DATA(accel_dev)->thd_to_arb_map;
 }
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 9762f2bf7727..d26564cebdec 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -197,7 +197,9 @@ module_pci_driver(adf_driver);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel");
 MODULE_FIRMWARE(ADF_4XXX_FW);
+MODULE_FIRMWARE(ADF_402XX_FW);
 MODULE_FIRMWARE(ADF_4XXX_MMP);
+MODULE_FIRMWARE(ADF_402XX_MMP);
 MODULE_DESCRIPTION("Intel(R) QuickAssist Technology");
 MODULE_VERSION(ADF_DRV_VERSION);
 MODULE_SOFTDEP("pre: crypto-intel_qat");
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
index 7fc7a77f6aed..c7ad8cf07863 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
@@ -149,5 +149,6 @@ void adf_gen4_init_tl_data(struct adf_tl_hw_data *tl_data)
 	tl_data->sl_exec_counters = sl_exec_counters;
 	tl_data->rp_counters = rp_counters;
 	tl_data->num_rp_counters = ARRAY_SIZE(rp_counters);
+	tl_data->max_sl_cnt = ADF_GEN4_TL_MAX_SLICES_PER_TYPE;
 }
 EXPORT_SYMBOL_GPL(adf_gen4_init_tl_data);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.c b/drivers/crypto/intel/qat/qat_common/adf_rl.c
index d4f2db3c53d8..e10f0024f4b8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_rl.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.c
@@ -1125,7 +1125,7 @@ int adf_rl_start(struct adf_accel_dev *accel_dev)
 	}
 
 	if ((fw_caps & RL_CAPABILITY_MASK) != RL_CAPABILITY_VALUE) {
-		dev_info(&GET_DEV(accel_dev), "not supported\n");
+		dev_info(&GET_DEV(accel_dev), "feature not supported by FW\n");
 		ret = -EOPNOTSUPP;
 		goto ret_free;
 	}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.c b/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
index 2ff714d11bd2..74fb0c2ed241 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.c
@@ -41,6 +41,20 @@ static int validate_tl_data(struct adf_tl_hw_data *tl_data)
 	return 0;
 }
 
+static int validate_tl_slice_counters(struct icp_qat_fw_init_admin_slice_cnt *slice_count,
+				      u8 max_slices_per_type)
+{
+	u8 *sl_counter = (u8 *)slice_count;
+	int i;
+
+	for (i = 0; i < ADF_TL_SL_CNT_COUNT; i++) {
+		if (sl_counter[i] > max_slices_per_type)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int adf_tl_alloc_mem(struct adf_accel_dev *accel_dev)
 {
 	struct adf_tl_hw_data *tl_data = &GET_TL_DATA(accel_dev);
@@ -214,6 +228,13 @@ int adf_tl_run(struct adf_accel_dev *accel_dev, int state)
 		return ret;
 	}
 
+	ret = validate_tl_slice_counters(&telemetry->slice_cnt, tl_data->max_sl_cnt);
+	if (ret) {
+		dev_err(dev, "invalid value returned by FW\n");
+		adf_send_admin_tl_stop(accel_dev);
+		return ret;
+	}
+
 	telemetry->hbuffs = state;
 	atomic_set(&telemetry->state, state);
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
index 9be81cd3b886..e54a406cc1b4 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
@@ -40,6 +40,7 @@ struct adf_tl_hw_data {
 	u8 num_dev_counters;
 	u8 num_rp_counters;
 	u8 max_rp;
+	u8 max_sl_cnt;
 };
 
 struct adf_telemetry {
diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
index 79b4e74804f6..6bfc59e67747 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
@@ -138,6 +138,10 @@ int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev,
 		return -ENOMEM;
 	cptr_dma = dma_map_single(&pdev->dev, hctx, CN10K_CPT_HW_CTX_SIZE,
 				  DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&pdev->dev, cptr_dma)) {
+		kfree(hctx);
+		return -ENOMEM;
+	}
 
 	cn10k_cpt_hw_ctx_set(hctx, 1);
 	er_ctx->hw_ctx = hctx;
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5a3a3293b21b..313b217388fe 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -554,12 +554,14 @@ static void xdma_synchronize(struct dma_chan *chan)
 }
 
 /**
- * xdma_fill_descs - Fill hardware descriptors with contiguous memory block addresses
- * @sw_desc: tx descriptor state container
- * @src_addr: Value for a ->src_addr field of a first descriptor
- * @dst_addr: Value for a ->dst_addr field of a first descriptor
- * @size: Total size of a contiguous memory block
- * @filled_descs_num: Number of filled hardware descriptors for corresponding sw_desc
+ * xdma_fill_descs() - Fill hardware descriptors for one contiguous memory chunk.
+ *		       More than one descriptor will be used if the size is bigger
+ *		       than XDMA_DESC_BLEN_MAX.
+ * @sw_desc: Descriptor container
+ * @src_addr: First value for the ->src_addr field
+ * @dst_addr: First value for the ->dst_addr field
+ * @size: Size of the contiguous memory block
+ * @filled_descs_num: Index of the first descriptor to take care of in @sw_desc
  */
 static inline u32 xdma_fill_descs(struct xdma_desc *sw_desc, u64 src_addr,
 				  u64 dst_addr, u32 size, u32 filled_descs_num)
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a6856730ca90..22c2f1375e86 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -449,7 +449,7 @@ static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
 					      freq_size, GFP_KERNEL);
-		if (!src->freq_supported)
+		if (!dst->freq_supported)
 			return -ENOMEM;
 	}
 	if (src->board_label) {
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 9c5b6f8bd8bd..27996b7924c8 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -648,7 +648,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	memset(&res, 0, sizeof(res));
 	res.mce  = mce;
 	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
-	if (!pfn_to_online_page(res.addr >> PAGE_SHIFT)) {
+	if (!pfn_to_online_page(res.addr >> PAGE_SHIFT) && !arch_is_platform_page(res.addr)) {
 		pr_err("Invalid address 0x%llx in IA32_MC%d_ADDR\n", mce->addr, mce->bank);
 		return NOTIFY_DONE;
 	}
diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a840c6922e5b..4d5b68b6be67 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1006,8 +1006,7 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 	rc = xlnx_register_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
-				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR |
-				 XPM_EVENT_ERROR_MASK_NOC_CR | XPM_EVENT_ERROR_MASK_NOC_NCR,
+				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR,
 				 false, err_callback, mci);
 	if (rc) {
 		if (rc == -EACCES)
@@ -1044,8 +1043,6 @@ static int mc_remove(struct platform_device *pdev)
 
 	xlnx_unregister_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
 			      XPM_EVENT_ERROR_MASK_DDRMC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_NCR |
 			      XPM_EVENT_ERROR_MASK_DDRMC_NCR, err_callback, mci);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 90283f160a22..29c24578ad2b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1624,7 +1624,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
  + any potential issues with this, only allow validated machines for now.
  */
-static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
+static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,thinkpad-x13s", },
 	{ }
 };
@@ -1713,7 +1713,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
  */
 bool qcom_scm_is_available(void)
 {
-	return !!__scm;
+	return !!READ_ONCE(__scm);
 }
 EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
@@ -1794,10 +1794,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (!scm)
 		return -ENOMEM;
 
+	scm->dev = &pdev->dev;
 	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
 	if (ret < 0)
 		return ret;
 
+	init_completion(&scm->waitq_comp);
 	mutex_init(&scm->scm_bw_lock);
 
 	scm->path = devm_of_icc_get(&pdev->dev, NULL);
@@ -1829,10 +1831,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	__scm = scm;
-	__scm->dev = &pdev->dev;
-
-	init_completion(&__scm->waitq_comp);
+	/* Let all above stores be available after this */
+	smp_store_release(&__scm, scm);
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 322aada20f74..ac34876a97f8 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -97,8 +98,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 	if (size & 3)
 		return -EINVAL;
 
-	buf = dma_alloc_coherent(fw->cl.dev, PAGE_ALIGN(size), &bus_addr,
-				 GFP_ATOMIC);
+	buf = dma_alloc_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size),
+				 &bus_addr, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
@@ -126,7 +127,7 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 		ret = -EINVAL;
 	}
 
-	dma_free_coherent(fw->cl.dev, PAGE_ALIGN(size), buf, bus_addr);
+	dma_free_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size), buf, bus_addr);
 
 	return ret;
 }
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 98b8fd16183e..80cac3a5f976 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -78,6 +78,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
 #define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
 /* PCI Subdevice ID for PCIE_DEVICE_ID_INTEL_DFL */
+#define PCIE_SUBDEVICE_ID_INTEL_D5005		0x138d
 #define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
 #define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
 #define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
@@ -101,6 +102,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_D5005),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
 			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
diff --git a/drivers/gpio/gpio-npcm-sgpio.c b/drivers/gpio/gpio-npcm-sgpio.c
index d31788b43abc..260570614543 100644
--- a/drivers/gpio/gpio-npcm-sgpio.c
+++ b/drivers/gpio/gpio-npcm-sgpio.c
@@ -434,7 +434,7 @@ static void npcm_sgpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
-	unsigned int i, j, girq;
+	unsigned int i, j;
 	unsigned long reg;
 
 	chained_irq_enter(ic, desc);
@@ -443,11 +443,9 @@ static void npcm_sgpio_irq_handler(struct irq_desc *desc)
 		const struct npcm_sgpio_bank *bank = &npcm_sgpio_banks[i];
 
 		reg = ioread8(bank_reg(gpio, bank, EVENT_STS));
-		for_each_set_bit(j, &reg, 8) {
-			girq = irq_find_mapping(gc->irq.domain,
-						i * 8 + gpio->nout_sgpio + j);
-			generic_handle_domain_irq(gc->irq.domain, girq);
-		}
+		for_each_set_bit(j, &reg, 8)
+			generic_handle_domain_irq(gc->irq.domain,
+						  i * 8 + gpio->nout_sgpio + j);
 	}
 
 	chained_irq_exit(ic, desc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index daa66eb4f722..b1e2dd52e643 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -220,7 +220,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
-	     vram_size - reserved_for_pt)) {
+	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size))) {
 		ret = -ENOMEM;
 		goto release;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index da48b6da0107..420e5bc44e30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1129,6 +1129,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	del_timer_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9e5526046aa1..3af505e8cbbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -608,6 +608,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
+		bo->tbo.priority = 2;
+	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
 		bo->tbo.priority = 1;
 
 	if (!bp->destroy)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dcdecb18b230..42392a97daff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9194,7 +9194,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		4 + /* double SWITCH_BUFFER,
@@ -9285,7 +9285,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 		7 + /* gfx_v10_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v10_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v10_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0afe86bcc932..6a6fc422e44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6110,7 +6110,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		5 + /* COND_EXEC */
@@ -6195,7 +6195,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 		7 + /* gfx_v11_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v11_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v11_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3bc6943365a4..153932c1f64f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6991,7 +6991,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_0_emit_mem_sync */
 		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
@@ -7029,7 +7028,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_fence = gfx_v9_0_ring_emit_fence_kiq,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bdc01ca9609a..5c8d81bfce7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -509,10 +509,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = start_mgr << PAGE_SHIFT;
 	end = (last_mgr + 1) << PAGE_SHIFT;
 
+	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
+					prange->npages * PAGE_SIZE,
+					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+					node->xcp ? node->xcp->id : 0);
+	if (r) {
+		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
+		return -ENOSPC;
+	}
+
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
-		return r;
+		goto out;
 	}
 	ttm_res_offset = (start_mgr - prange->start + prange->offset) << PAGE_SHIFT;
 
@@ -545,6 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		svm_range_vram_node_free(prange);
 	}
 
+out:
+	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
+					prange->npages * PAGE_SIZE,
+					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+					node->xcp ? node->xcp->id : 0);
 	return r < 0 ? r : 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 58c1fe542193..451bb058cc62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -829,6 +829,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
+		/* If the process just called exec(3), it is possible that the
+		 * cleanup of the kfd_process (following the release of the mm
+		 * of the old process image) is still in the cleanup work queue.
+		 * Make sure to drain any job before trying to recreate any
+		 * resource for this process.
+		 */
+		flush_workqueue(kfd_process_wq);
+
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c50a0dc9c9c0..33205078202b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3424,7 +3424,7 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
-	return r;
+	return 0;
 }
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9044214dfdbd..c4ba397f8cef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3010,6 +3010,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 644da4637320..5506cf9b3672 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -145,6 +145,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	 */
 	clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 	if (safe_to_lower) {
+		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, false);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 			display_count = dcn315_get_active_display_cnt_wa(dc, context);
@@ -160,6 +164,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 		}
 	} else {
+		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, true);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in D0 */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
 			union display_idle_optimization_u idle_info = { 0 };
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index bbdbc78161a0..39c63565baa9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -696,8 +696,12 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					 * since we calculate mode support based on softmax being the max UCLK
 					 * frequency.
 					 */
-					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-							dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+					if (dc->debug.disable_dc_mode_overwrite) {
+						dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+					} else
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+								dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 				} else {
 					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
 				}
@@ -730,8 +734,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support) &&
-				!dc->work_arounds.clock_update_disable_mask.uclk)
+				!dc->work_arounds.clock_update_disable_mask.uclk) {
+			if (dc->clk_mgr->dc_mode_softmax_enabled && dc->debug.disable_dc_mode_overwrite)
+				dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
+						max((int)dc->clk_mgr->bw_params->dc_mode_softmax_memclk, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz)));
+
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+		}
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
 				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3c3d613c5f00..040b5c2a5758 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1804,6 +1804,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)
+		return false;
+
 	if (dc->link_srv->edp_is_ilr_optimization_required(link, crtc_timing)) {
 		DC_LOG_EVENT_LINK_TRAINING("Seamless boot disabled to optimize eDP link rate\n");
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 3538973bd0c6..c0372aa4ec83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -382,6 +382,11 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS) {
+				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
+					     i, TRANSFER_FUNC_POINTS);
+				return false;
+			}
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index deb6d162a2d5..7307b7b8d8ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -291,6 +291,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.dispclk_dppclk_vco_speed_mhz = 2400.0,
 	.num_chans = 4,
 	.dummy_pstate_latency_us = 10.0
 };
@@ -438,6 +439,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.dispclk_dppclk_vco_speed_mhz = 2500.0,
 };
 
 void dcn31_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 46cbb5a6c8e7..1a3c212ae63c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -999,8 +999,7 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->plane_res.dpp)
 			update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->plane_res.hubp->inst] = false;
 
-		if ((pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp) &&
-			pipe_ctx->plane_res.mpcc_inst >= 0)
+		if (pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_MPCC][pipe_ctx->plane_res.mpcc_inst] = false;
 
 		if (pipe_ctx->stream_res.dsc)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 5491b707cec8..5a965c26bf20 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -270,7 +270,7 @@ static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 
 	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw == link->dpia_bw_alloc_config.allocated_bw) {
+	if (req_bw && (req_bw == link->dpia_bw_alloc_config.allocated_bw)) {
 		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
 			__func__, link->link_index);
 	}
@@ -341,6 +341,14 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 			ret = true;
 			init_usb4_bw_struct(link);
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
+
+			/*
+			 * During DP tunnel creation, CM preallocates BW and reduces estimated BW of other
+			 * DPIA. CM release preallocation only when allocation is complete. Do zero alloc
+			 * to make the CM to release preallocation and update estimated BW correctly for
+			 * all DPIAs per host router
+			 */
+			link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f9c5bc624be3..f81f6110913d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2451,6 +2451,7 @@ static bool dcn20_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.dmcub_support = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 78491b04df10..ddb11eb8c3f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2205,6 +2205,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	return sizeof(*gpu_metrics);
 }
 
+static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(adev->pdev, i * 4,
+				       adev->pdev->saved_config_space[i]);
+	pci_restore_msi_state(adev->pdev);
+}
+
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
 	int ret = 0, index;
@@ -2226,6 +2237,20 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
+	/* Certain platforms have switches which assign virtual BAR values to
+	 * devices. OS uses the virtual BAR values and device behind the switch
+	 * is assgined another BAR value. When device's config space registers
+	 * are queried, switch returns the virtual BAR values. When mode-2 reset
+	 * is performed, switch is unaware of it, and will continue to return
+	 * the same virtual values to the OS.This affects
+	 * pci_restore_config_space() API as it doesn't write the value saved if
+	 * the current value read from config space is the same as what is
+	 * saved. As a workaround, make sure the config space is restored
+	 * always.
+	 */
+	if (!(adev->flags & AMD_IS_APU))
+		smu_v13_0_6_restore_pci_config(smu);
+
 	dev_dbg(smu->adev->dev, "wait for reset ack\n");
 	do {
 		ret = smu_cmn_wait_for_response(smu);
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 626709bec6f5..2577f0cef8fc 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -72,7 +72,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 29d91493b101..c1191ef5e8e6 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2076,10 +2076,8 @@ static int anx7625_setup_dsi_device(struct anx7625_data *ctx)
 	};
 
 	host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "fail to find dsi host.\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
@@ -2481,15 +2479,22 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
 	mutex_unlock(&ctx->aux_lock);
 }
 
+static void
+anx7625_audio_update_connector_status(struct anx7625_data *ctx,
+				      enum drm_connector_status status);
+
 static enum drm_connector_status
 anx7625_bridge_detect(struct drm_bridge *bridge)
 {
 	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
 	struct device *dev = ctx->dev;
+	enum drm_connector_status status;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "drm bridge detect\n");
 
-	return anx7625_sink_detect(ctx);
+	status = anx7625_sink_detect(ctx);
+	anx7625_audio_update_connector_status(ctx, status);
+	return status;
 }
 
 static struct edid *anx7625_bridge_get_edid(struct drm_bridge *bridge,
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 7d470527455b..bab8844c6fef 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2057,6 +2057,9 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode)
+		return;
+
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 82d23e4df09e..ff3284b6b1a3 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -563,10 +563,8 @@ static int chipone_dsi_host_attach(struct chipone *icn)
 
 	host = of_find_mipi_dsi_host_by_node(host_node);
 	of_node_put(host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 97d4af3d1365..0b5b98d3e5f6 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -494,10 +494,8 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 						 };
 
 	host = of_find_mipi_dsi_host_by_node(lt->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 9663601ce098..89bdd938757e 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -760,10 +760,8 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(lt9611->dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(lt9611->dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index e971b75e90ad..b803899126d5 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -265,10 +265,8 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 90a89d70d832..fea4f00a20f8 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -610,10 +610,8 @@ static int tc_attach_host(struct tc_data *tc)
 						};
 
 	host = of_find_mipi_dsi_host_by_node(tc->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index ca3348109bcd..6b559e071301 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -319,12 +319,11 @@ static int dlpc_host_attach(struct dlpc *dlpc)
 		.channel = 0,
 		.node = NULL,
 	};
+	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dlpc->host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dlpc->dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dlpc->dsi)) {
@@ -336,7 +335,11 @@ static int dlpc_host_attach(struct dlpc *dlpc)
 	dlpc->dsi->format = MIPI_DSI_FMT_RGB565;
 	dlpc->dsi->lanes = dlpc->dsi_lanes;
 
-	return devm_mipi_dsi_attach(dev, dlpc->dsi);
+	ret = devm_mipi_dsi_attach(dev, dlpc->dsi);
+	if (ret)
+		DRM_DEV_ERROR(dev, "failed to attach dsi host\n");
+
+	return ret;
 }
 
 static int dlpc3433_probe(struct i2c_client *client)
@@ -367,10 +370,8 @@ static int dlpc3433_probe(struct i2c_client *client)
 	drm_bridge_add(&dlpc->bridge);
 
 	ret = dlpc_host_attach(dlpc);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "failed to attach dsi host\n");
+	if (ret)
 		goto err_remove_bridge;
-	}
 
 	return 0;
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 62cc3893dca5..1f6e929c2f6a 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1591,7 +1591,6 @@ static int ti_sn_pwm_probe(struct auxiliary_device *adev,
 	pdata->pchip.ops = &ti_sn_pwm_ops;
 	pdata->pchip.npwm = 1;
 	pdata->pchip.of_xlate = of_pwm_single_xlate;
-	pdata->pchip.of_pwm_n_cells = 1;
 
 	devm_pm_runtime_enable(&adev->dev);
 
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 9faf76e55a56..da381257e7e5 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -237,11 +237,11 @@ i915:cml:
 i915:tgl:
   extends:
     - .i915
-  parallel: 8
+  parallel: 5
   variables:
-    DEVICE_TYPE: asus-cx9400-volteer
+    DEVICE_TYPE: acer-cp514-2h-1130g7-volteer
     GPU_VERSION: tgl
-    RUNNER_TAG: mesa-ci-x86-64-lava-asus-cx9400-volteer
+    RUNNER_TAG: mesa-ci-x86-64-lava-acer-cp514-2h-1130g7-volteer
 
 .amdgpu:
   extends:
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 26c188ce5f1c..fb80843e7f2d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -532,6 +532,15 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
 
 	mutex_lock(&aux->hw_mutex);
 
+	/*
+	 * If the device attached to the aux bus is powered down then there's
+	 * no reason to attempt a transfer. Error out immediately.
+	 */
+	if (aux->powered_down) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	/*
 	 * The specification doesn't give any recommendation on how often to
 	 * retry native transactions. We used to retry 7 times like for
@@ -599,6 +608,29 @@ int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset)
 }
 EXPORT_SYMBOL(drm_dp_dpcd_probe);
 
+/**
+ * drm_dp_dpcd_set_powered() - Set whether the DP device is powered
+ * @aux: DisplayPort AUX channel; for convenience it's OK to pass NULL here
+ *       and the function will be a no-op.
+ * @powered: true if powered; false if not
+ *
+ * If the endpoint device on the DP AUX bus is known to be powered down
+ * then this function can be called to make future transfers fail immediately
+ * instead of needing to time out.
+ *
+ * If this function is never called then a device defaults to being powered.
+ */
+void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered)
+{
+	if (!aux)
+		return;
+
+	mutex_lock(&aux->hw_mutex);
+	aux->powered_down = !powered;
+	mutex_unlock(&aux->hw_mutex);
+}
+EXPORT_SYMBOL(drm_dp_dpcd_set_powered);
+
 /**
  * drm_dp_dpcd_read() - read a series of bytes from the DPCD
  * @aux: DisplayPort AUX channel (SST or MST)
@@ -1858,6 +1890,9 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	struct drm_dp_aux_msg msg;
 	int err = 0;
 
+	if (aux->powered_down)
+		return -EBUSY;
+
 	dp_aux_i2c_transfer_size = clamp(dp_aux_i2c_transfer_size, 1, DP_AUX_MAX_PAYLOAD_BYTES);
 
 	memset(&msg, 0, sizeof(msg));
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 4f6f8c662d3f..ac502ea20089 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -687,11 +687,17 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 				 */
 				list_for_each_entry_from(next, &encoder->bridge_chain,
 							 chain_node) {
-					if (next->pre_enable_prev_first) {
+					if (!next->pre_enable_prev_first) {
 						next = list_prev_entry(next, chain_node);
 						limit = next;
 						break;
 					}
+
+					if (list_is_last(&next->chain_node,
+							 &encoder->bridge_chain)) {
+						limit = next;
+						break;
+					}
 				}
 
 				/* Call these bridges in reverse order */
@@ -774,7 +780,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 					/* Found first bridge that does NOT
 					 * request prev to be enabled first
 					 */
-					limit = list_prev_entry(next, chain_node);
+					limit = next;
 					break;
 				}
 			}
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 69c68804023f..9ef9a70a836c 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -7345,7 +7345,7 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
 static bool displayid_is_tiled_block(const struct displayid_iter *iter,
 				     const struct displayid_block *block)
 {
-	return (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_12 &&
+	return (displayid_version(iter) < DISPLAY_ID_STRUCTURE_VER_20 &&
 		block->tag == DATA_BLOCK_TILED_DISPLAY) ||
 		(displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
 		 block->tag == DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY);
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 843a6dbda93a..52a93149363b 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -654,7 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
 {
 	/* Note: Needs updating for non-default PPS or algorithm */
 	u8 tx[2] = { enable << 0, 0 };
@@ -679,8 +679,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps)
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps)
 {
 	struct mipi_dsi_msg msg = {
 		.channel = dsi->channel,
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 9b8445d2a128..89cb6799b547 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -632,8 +632,8 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	/* Disable TX clock gating on affected core revisions. */
 	if (etnaviv_is_model_rev(gpu, GC4000, 0x5222) ||
 	    etnaviv_is_model_rev(gpu, GC2000, 0x5108) ||
-	    etnaviv_is_model_rev(gpu, GC2000, 0x6202) ||
-	    etnaviv_is_model_rev(gpu, GC2000, 0x6203))
+	    etnaviv_is_model_rev(gpu, GC7000, 0x6202) ||
+	    etnaviv_is_model_rev(gpu, GC7000, 0x6203))
 		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
 
 	/* Disable SE and RA clock gating on affected core revisions. */
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index b7fef3c797e6..4f99b4af871c 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -46,7 +46,7 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 	if (!mips_data)
 		return -ENOMEM;
 
-	for (page_nr = 0; page_nr < ARRAY_SIZE(mips_data->pt_pages); page_nr++) {
+	for (page_nr = 0; page_nr < PVR_MIPS_PT_PAGE_COUNT; page_nr++) {
 		mips_data->pt_pages[page_nr] = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!mips_data->pt_pages[page_nr]) {
 			err = -ENOMEM;
@@ -102,7 +102,7 @@ pvr_vm_mips_fini(struct pvr_device *pvr_dev)
 	int page_nr;
 
 	vunmap(mips_data->pt);
-	for (page_nr = ARRAY_SIZE(mips_data->pt_pages) - 1; page_nr >= 0; page_nr--) {
+	for (page_nr = PVR_MIPS_PT_PAGE_COUNT - 1; page_nr >= 0; page_nr--) {
 		dma_unmap_page(from_pvr_device(pvr_dev)->dev,
 			       mips_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 3d17de34d72b..d398fa187116 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -992,10 +992,10 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 
 	mtk_crtc->mmsys_dev = priv->mmsys_dev;
 	mtk_crtc->ddp_comp_nr = path_len;
-	mtk_crtc->ddp_comp = devm_kmalloc_array(dev,
-						mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
-						sizeof(*mtk_crtc->ddp_comp),
-						GFP_KERNEL);
+	mtk_crtc->ddp_comp = devm_kcalloc(dev,
+					  mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
+					  sizeof(*mtk_crtc->ddp_comp),
+					  GFP_KERNEL);
 	if (!mtk_crtc->ddp_comp)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 4f2e3feabc0f..1bf229615b01 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -38,6 +38,9 @@ static struct mtk_drm_gem_obj *mtk_drm_gem_init(struct drm_device *dev,
 
 	size = round_up(size, PAGE_SIZE);
 
+	if (size == 0)
+		return ERR_PTR(-EINVAL);
+
 	mtk_gem_obj = kzalloc(sizeof(*mtk_gem_obj), GFP_KERNEL);
 	if (!mtk_gem_obj)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a82119eb58e..2a942dc6a6dc 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/10)*10);
+				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 03f4951c49f4..e67a80d56948 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -35,6 +35,7 @@ struct dp_aux_private {
 	bool no_send_stop;
 	bool initted;
 	bool is_edp;
+	bool enable_xfers;
 	u32 offset;
 	u32 segment;
 
@@ -301,6 +302,17 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 		goto exit;
 	}
 
+	/*
+	 * If we're using DP and an external display isn't connected then the
+	 * transfer won't succeed. Return right away. If we don't do this we
+	 * can end up with long timeouts if someone tries to access the DP AUX
+	 * character device when no DP device is connected.
+	 */
+	if (!aux->is_edp && !aux->enable_xfers) {
+		ret = -ENXIO;
+		goto exit;
+	}
+
 	/*
 	 * For eDP it's important to give a reasonably long wait here for HPD
 	 * to be asserted. This is because the panel driver may have _just_
@@ -433,6 +445,14 @@ irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux)
 	return IRQ_HANDLED;
 }
 
+void dp_aux_enable_xfers(struct drm_dp_aux *dp_aux, bool enabled)
+{
+	struct dp_aux_private *aux;
+
+	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
+	aux->enable_xfers = enabled;
+}
+
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux)
 {
 	struct dp_aux_private *aux;
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
index 511305da4f66..f3052cb43306 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.h
+++ b/drivers/gpu/drm/msm/dp/dp_aux.h
@@ -12,6 +12,7 @@
 int dp_aux_register(struct drm_dp_aux *dp_aux);
 void dp_aux_unregister(struct drm_dp_aux *dp_aux);
 irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux);
+void dp_aux_enable_xfers(struct drm_dp_aux *dp_aux, bool enabled);
 void dp_aux_init(struct drm_dp_aux *dp_aux);
 void dp_aux_deinit(struct drm_dp_aux *dp_aux);
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index fb588fde298a..780e9747be1f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1019,14 +1019,14 @@ static int dp_ctrl_update_vx_px(struct dp_ctrl_private *ctrl)
 	if (ret)
 		return ret;
 
-	if (voltage_swing_level >= DP_TRAIN_VOLTAGE_SWING_MAX) {
+	if (voltage_swing_level >= DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(ctrl->drm_dev,
 				"max. voltage swing level reached %d\n",
 				voltage_swing_level);
 		max_level_reached |= DP_TRAIN_MAX_SWING_REACHED;
 	}
 
-	if (pre_emphasis_level >= DP_TRAIN_PRE_EMPHASIS_MAX) {
+	if (pre_emphasis_level >= DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(ctrl->drm_dev,
 				"max. pre-emphasis level reached %d\n",
 				pre_emphasis_level);
@@ -1117,7 +1117,7 @@ static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
 		}
 
 		if (ctrl->link->phy_params.v_level >=
-			DP_TRAIN_VOLTAGE_SWING_MAX) {
+			DP_TRAIN_LEVEL_MAX) {
 			DRM_ERROR_RATELIMITED("max v_level reached\n");
 			return -EAGAIN;
 		}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 78464c395c3d..084086033679 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -565,6 +565,8 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	int ret;
 	struct platform_device *pdev = dp->dp_display.pdev;
 
+	dp_aux_enable_xfers(dp->aux, true);
+
 	mutex_lock(&dp->event_mutex);
 
 	state =  dp->hpd_state;
@@ -630,6 +632,8 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	u32 state;
 	struct platform_device *pdev = dp->dp_display.pdev;
 
+	dp_aux_enable_xfers(dp->aux, false);
+
 	mutex_lock(&dp->event_mutex);
 
 	state = dp->hpd_state;
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 49dfac1fd1ef..ea911d9244be 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -1109,6 +1109,7 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 {
 	int i;
+	u8 max_p_level;
 	int v_max = 0, p_max = 0;
 	struct dp_link_private *link;
 
@@ -1140,30 +1141,29 @@ int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 	 * Adjust the voltage swing and pre-emphasis level combination to within
 	 * the allowable range.
 	 */
-	if (dp_link->phy_params.v_level > DP_TRAIN_VOLTAGE_SWING_MAX) {
+	if (dp_link->phy_params.v_level > DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested vSwingLevel=%d, change to %d\n",
 			dp_link->phy_params.v_level,
-			DP_TRAIN_VOLTAGE_SWING_MAX);
-		dp_link->phy_params.v_level = DP_TRAIN_VOLTAGE_SWING_MAX;
+			DP_TRAIN_LEVEL_MAX);
+		dp_link->phy_params.v_level = DP_TRAIN_LEVEL_MAX;
 	}
 
-	if (dp_link->phy_params.p_level > DP_TRAIN_PRE_EMPHASIS_MAX) {
+	if (dp_link->phy_params.p_level > DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested preEmphasisLevel=%d, change to %d\n",
 			dp_link->phy_params.p_level,
-			DP_TRAIN_PRE_EMPHASIS_MAX);
-		dp_link->phy_params.p_level = DP_TRAIN_PRE_EMPHASIS_MAX;
+			DP_TRAIN_LEVEL_MAX);
+		dp_link->phy_params.p_level = DP_TRAIN_LEVEL_MAX;
 	}
 
-	if ((dp_link->phy_params.p_level > DP_TRAIN_PRE_EMPHASIS_LVL_1)
-		&& (dp_link->phy_params.v_level ==
-			DP_TRAIN_VOLTAGE_SWING_LVL_2)) {
+	max_p_level = DP_TRAIN_LEVEL_MAX - dp_link->phy_params.v_level;
+	if (dp_link->phy_params.p_level > max_p_level) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested preEmphasisLevel=%d, change to %d\n",
 			dp_link->phy_params.p_level,
-			DP_TRAIN_PRE_EMPHASIS_LVL_1);
-		dp_link->phy_params.p_level = DP_TRAIN_PRE_EMPHASIS_LVL_1;
+			max_p_level);
+		dp_link->phy_params.p_level = max_p_level;
 	}
 
 	drm_dbg_dp(link->drm_dev, "adjusted: v_level=%d, p_level=%d\n",
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 9dd4dd926530..79c3a02b8dac 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -19,19 +19,7 @@ struct dp_link_info {
 	unsigned long capabilities;
 };
 
-enum dp_link_voltage_level {
-	DP_TRAIN_VOLTAGE_SWING_LVL_0	= 0,
-	DP_TRAIN_VOLTAGE_SWING_LVL_1	= 1,
-	DP_TRAIN_VOLTAGE_SWING_LVL_2	= 2,
-	DP_TRAIN_VOLTAGE_SWING_MAX	= DP_TRAIN_VOLTAGE_SWING_LVL_2,
-};
-
-enum dp_link_preemaphasis_level {
-	DP_TRAIN_PRE_EMPHASIS_LVL_0	= 0,
-	DP_TRAIN_PRE_EMPHASIS_LVL_1	= 1,
-	DP_TRAIN_PRE_EMPHASIS_LVL_2	= 2,
-	DP_TRAIN_PRE_EMPHASIS_MAX	= DP_TRAIN_PRE_EMPHASIS_LVL_2,
-};
+#define DP_TRAIN_LEVEL_MAX	3
 
 struct dp_link_test_video {
 	u32 test_video_pattern;
diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 18de2f17e249..6494e8270756 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -340,6 +340,9 @@ static int __maybe_unused lcdif_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	return lcdif_rpm_suspend(dev);
 }
 
@@ -347,7 +350,8 @@ static int __maybe_unused lcdif_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
-	lcdif_rpm_resume(dev);
+	if (!pm_runtime_suspended(dev))
+		lcdif_rpm_resume(dev);
 
 	return drm_mode_config_helper_resume(drm);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
index 6a0a4d3b8902..027867c2a8c5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
@@ -1080,7 +1080,7 @@ r535_dp_aux_xfer(struct nvkm_outp *outp, u8 type, u32 addr, u8 *data, u8 *psize)
 	ret = nvkm_gsp_rm_ctrl_push(&disp->rm.objcom, &ctrl, sizeof(*ctrl));
 	if (ret) {
 		nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
-		return PTR_ERR(ctrl);
+		return ret;
 	}
 
 	memcpy(data, ctrl->data, size);
diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
index b715301ec79f..6c49270cb290 100644
--- a/drivers/gpu/drm/omapdrm/Kconfig
+++ b/drivers/gpu/drm/omapdrm/Kconfig
@@ -4,7 +4,7 @@ config DRM_OMAP
 	depends on DRM && OF
 	depends on ARCH_OMAP2PLUS
 	select DRM_KMS_HELPER
-	select FB_DMAMEM_HELPERS if DRM_FBDEV_EMULATION
+	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	select VIDEOMODE_HELPERS
 	select HDMI
 	default n
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 6b08b137af1a..523be34682ca 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -51,6 +51,10 @@ static void pan_worker(struct work_struct *work)
 	omap_gem_roll(bo, fbi->var.yoffset * npages);
 }
 
+FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(omap_fbdev,
+				   drm_fb_helper_damage_range,
+				   drm_fb_helper_damage_area)
+
 static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 		struct fb_info *fbi)
 {
@@ -78,11 +82,9 @@ static int omap_fbdev_pan_display(struct fb_var_screeninfo *var,
 
 static int omap_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	struct drm_fb_helper *helper = info->par;
-	struct drm_framebuffer *fb = helper->fb;
-	struct drm_gem_object *bo = drm_gem_fb_get_obj(fb, 0);
+	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
 
-	return drm_gem_mmap_obj(bo, omap_gem_mmap_size(bo), vma);
+	return fb_deferred_io_mmap(info, vma);
 }
 
 static void omap_fbdev_fb_destroy(struct fb_info *info)
@@ -94,6 +96,7 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 
 	DBG();
 
+	fb_deferred_io_cleanup(info);
 	drm_fb_helper_fini(helper);
 
 	omap_gem_unpin(bo);
@@ -104,15 +107,19 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 	kfree(fbdev);
 }
 
+/*
+ * For now, we cannot use FB_DEFAULT_DEFERRED_OPS and fb_deferred_io_mmap()
+ * because we use write-combine.
+ */
 static const struct fb_ops omap_fb_ops = {
 	.owner = THIS_MODULE,
-	__FB_DEFAULT_DMAMEM_OPS_RDWR,
+	__FB_DEFAULT_DEFERRED_OPS_RDWR(omap_fbdev),
 	.fb_check_var	= drm_fb_helper_check_var,
 	.fb_set_par	= drm_fb_helper_set_par,
 	.fb_setcmap	= drm_fb_helper_setcmap,
 	.fb_blank	= drm_fb_helper_blank,
 	.fb_pan_display = omap_fbdev_pan_display,
-	__FB_DEFAULT_DMAMEM_OPS_DRAW,
+	__FB_DEFAULT_DEFERRED_OPS_DRAW(omap_fbdev),
 	.fb_ioctl	= drm_fb_helper_ioctl,
 	.fb_mmap	= omap_fbdev_fb_mmap,
 	.fb_destroy	= omap_fbdev_fb_destroy,
@@ -213,6 +220,15 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	fbi->fix.smem_start = dma_addr;
 	fbi->fix.smem_len = bo->size;
 
+	/* deferred I/O */
+	helper->fbdefio.delay = HZ / 20;
+	helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
+
+	fbi->fbdefio = &helper->fbdefio;
+	ret = fb_deferred_io_init(fbi);
+	if (ret)
+		goto fail;
+
 	/* if we have DMM, then we can use it for scrolling by just
 	 * shuffling pages around in DMM rather than doing sw blit.
 	 */
@@ -238,8 +254,20 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	return ret;
 }
 
+static int omap_fbdev_dirty(struct drm_fb_helper *helper, struct drm_clip_rect *clip)
+{
+	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
+		return 0;
+
+	if (helper->fb->funcs->dirty)
+		return helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
+
+	return 0;
+}
+
 static const struct drm_fb_helper_funcs omap_fb_helper_funcs = {
 	.fb_probe = omap_fbdev_create,
+	.fb_dirty = omap_fbdev_dirty,
 };
 
 static struct drm_fb_helper *get_fb(struct fb_info *fbi)
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e5e3f0b9ca61..49b8a2484d92 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -397,6 +397,7 @@ static int panel_edp_suspend(struct device *dev)
 {
 	struct panel_edp *p = dev_get_drvdata(dev);
 
+	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get_boottime();
@@ -453,6 +454,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	}
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
+	drm_dp_dpcd_set_powered(p->aux, true);
 
 	delay = p->desc->delay.hpd_reliable;
 	if (p->no_hpd)
@@ -489,6 +491,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	return 0;
 
 error:
+	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get_boottime();
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 30919c872ac8..8e0f5c3e3b98 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -295,8 +295,6 @@ static int ltk050h3148w_init_sequence(struct ltk050h3146w *ctx)
 	mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x00);
 	mipi_dsi_dcs_write_seq(dsi, 0xc6, 0xef);
 	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x29);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, 1);
 	if (ret < 0) {
@@ -326,7 +324,8 @@ static const struct drm_display_mode ltk050h3148w_mode = {
 static const struct ltk050h3146w_desc ltk050h3148w_data = {
 	.mode = &ltk050h3148w_mode,
 	.init = ltk050h3148w_init_sequence,
-	.mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_VIDEO_BURST,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_VIDEO_BURST,
 };
 
 static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 648ce9201426..028fdac293f7 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -556,10 +556,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		}
 		dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
 		of_node_put(dsi_r);
-		if (!dsi_r_host) {
-			dev_err(dev, "Cannot get secondary DSI host\n");
-			return -EPROBE_DEFER;
-		}
+		if (!dsi_r_host)
+			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");
 
 		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
 		if (!nt->dsi[1]) {
diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 5703f4712d96..9c336c71562b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -72,6 +72,7 @@ static int atana33xc20_suspend(struct device *dev)
 	if (p->el3_was_on)
 		atana33xc20_wait(p->el_on3_off_time, 150);
 
+	drm_dp_dpcd_set_powered(p->aux, false);
 	ret = regulator_disable(p->supply);
 	if (ret)
 		return ret;
@@ -93,6 +94,7 @@ static int atana33xc20_resume(struct device *dev)
 	ret = regulator_enable(p->supply);
 	if (ret)
 		return ret;
+	drm_dp_dpcd_set_powered(p->aux, true);
 	p->powered_on_time = ktime_get_boottime();
 
 	if (p->no_hpd) {
@@ -107,19 +109,17 @@ static int atana33xc20_resume(struct device *dev)
 		if (hpd_asserted < 0)
 			ret = hpd_asserted;
 
-		if (ret)
+		if (ret) {
 			dev_warn(dev, "Error waiting for HPD GPIO: %d\n", ret);
-
-		return ret;
-	}
-
-	if (p->aux->wait_hpd_asserted) {
+			goto error;
+		}
+	} else if (p->aux->wait_hpd_asserted) {
 		ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
 
-		if (ret)
+		if (ret) {
 			dev_warn(dev, "Controller error waiting for HPD: %d\n", ret);
-
-		return ret;
+			goto error;
+		}
 	}
 
 	/*
@@ -131,6 +131,12 @@ static int atana33xc20_resume(struct device *dev)
 	 * right times.
 	 */
 	return 0;
+
+error:
+	drm_dp_dpcd_set_powered(p->aux, false);
+	regulator_disable(p->supply);
+
+	return ret;
 }
 
 static int atana33xc20_disable(struct drm_panel *panel)
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 72fdab8adb08..228c5c48e158 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2564,6 +2564,9 @@ static const struct panel_desc innolux_g121x1_l03 = {
 		.unprepare = 200,
 		.disable = 400,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 static const struct display_timing innolux_g156hce_l01_timings = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index fdd768bbd487..62ebbdb16253 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -706,6 +706,8 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	const struct drm_format_info *info;
 	u16 hor_scl_mode, ver_scl_mode;
 	u16 hscl_filter_mode, vscl_filter_mode;
+	uint16_t cbcr_src_w = src_w;
+	uint16_t cbcr_src_h = src_h;
 	u8 gt2 = 0;
 	u8 gt4 = 0;
 	u32 val;
@@ -763,27 +765,27 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	vop2_win_write(win, VOP2_WIN_YRGB_VSCL_FILTER_MODE, vscl_filter_mode);
 
 	if (info->is_yuv) {
-		src_w /= info->hsub;
-		src_h /= info->vsub;
+		cbcr_src_w /= info->hsub;
+		cbcr_src_h /= info->vsub;
 
 		gt4 = 0;
 		gt2 = 0;
 
-		if (src_h >= (4 * dst_h)) {
+		if (cbcr_src_h >= (4 * dst_h)) {
 			gt4 = 1;
-			src_h >>= 2;
-		} else if (src_h >= (2 * dst_h)) {
+			cbcr_src_h >>= 2;
+		} else if (cbcr_src_h >= (2 * dst_h)) {
 			gt2 = 1;
-			src_h >>= 1;
+			cbcr_src_h >>= 1;
 		}
 
-		hor_scl_mode = scl_get_scl_mode(src_w, dst_w);
-		ver_scl_mode = scl_get_scl_mode(src_h, dst_h);
+		hor_scl_mode = scl_get_scl_mode(cbcr_src_w, dst_w);
+		ver_scl_mode = scl_get_scl_mode(cbcr_src_h, dst_h);
 
-		val = vop2_scale_factor(src_w, dst_w);
+		val = vop2_scale_factor(cbcr_src_w, dst_w);
 		vop2_win_write(win, VOP2_WIN_SCALE_CBCR_X, val);
 
-		val = vop2_scale_factor(src_h, dst_h);
+		val = vop2_scale_factor(cbcr_src_h, dst_h);
 		vop2_win_write(win, VOP2_WIN_SCALE_CBCR_Y, val);
 
 		vop2_win_write(win, VOP2_WIN_VSD_CBCR_GT4, gt4);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f827f2654364..eff47465707b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2739,6 +2739,8 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 		index = 1;
 
 	addr = of_get_address(dev->of_node, index, NULL, NULL);
+	if (!addr)
+		return -EINVAL;
 
 	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index 9dbe6f4cb294..c89e6a2a5873 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -227,6 +227,11 @@ static void amd_sfh_resume(struct amd_mp2_dev *mp2)
 	struct amd_mp2_sensor_info info;
 	int i, status;
 
+	if (!cl_data->is_any_sensor_enabled) {
+		amd_sfh_clear_intr(mp2);
+		return;
+	}
+
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_sts[i] == SENSOR_DISABLED) {
 			info.sensor_idx = cl_data->sensor_idx[i];
@@ -252,6 +257,11 @@ static void amd_sfh_suspend(struct amd_mp2_dev *mp2)
 	struct amdtp_cl_data *cl_data = mp2->cl_data;
 	int i, status;
 
+	if (!cl_data->is_any_sensor_enabled) {
+		amd_sfh_clear_intr(mp2);
+		return;
+	}
+
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_idx[i] != HPD_IDX &&
 		    cl_data->sensor_sts[i] == SENSOR_ENABLED) {
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index f9cceaeffd08..da5ea5a23b08 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -944,9 +944,11 @@ static void mcp2221_hid_unregister(void *ptr)
 /* This is needed to be sure hid_hw_stop() isn't called twice by the subsystem */
 static void mcp2221_remove(struct hid_device *hdev)
 {
+#if IS_REACHABLE(CONFIG_IIO)
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
 	cancel_delayed_work_sync(&mcp->init_work);
+#endif
 }
 
 #if IS_REACHABLE(CONFIG_IIO)
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index ccc4032fb2b0..4b2c81b49b80 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -481,10 +481,10 @@ static const struct joycon_ctlr_button_mapping n64con_button_mappings[] = {
 	{ BTN_TR,		JC_BTN_R,	},
 	{ BTN_TR2,		JC_BTN_LSTICK,	}, /* ZR */
 	{ BTN_START,		JC_BTN_PLUS,	},
-	{ BTN_FORWARD,		JC_BTN_Y,	}, /* C UP */
-	{ BTN_BACK,		JC_BTN_ZR,	}, /* C DOWN */
-	{ BTN_LEFT,		JC_BTN_X,	}, /* C LEFT */
-	{ BTN_RIGHT,		JC_BTN_MINUS,	}, /* C RIGHT */
+	{ BTN_SELECT,		JC_BTN_Y,	}, /* C UP */
+	{ BTN_X,		JC_BTN_ZR,	}, /* C DOWN */
+	{ BTN_Y,		JC_BTN_X,	}, /* C LEFT */
+	{ BTN_C,		JC_BTN_MINUS,	}, /* C RIGHT */
 	{ BTN_MODE,		JC_BTN_HOME,	},
 	{ BTN_Z,		JC_BTN_CAP,	},
 	{ /* sentinel */ },
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 65e7eeb2fa64..ce5576ef3c86 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -172,6 +172,11 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0) {
+		dev_err(dev, "ISH: Failed to allocate IRQ vectors\n");
+		return ret;
+	}
+
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		irq_flag = IRQF_SHARED;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..64ace0b968f0 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -715,8 +715,10 @@ cma_validate_port(struct ib_device *device, u32 port,
 		rcu_read_lock();
 		ndev = rcu_dereference(sgid_attr->ndev);
 		if (!net_eq(dev_net(ndev), dev_addr->net) ||
-		    ndev->ifindex != bound_if_index)
+		    ndev->ifindex != bound_if_index) {
+			rdma_put_gid_attr(sgid_attr);
 			sgid_attr = ERR_PTR(-ENODEV);
+		}
 		rcu_read_unlock();
 		goto out;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 439d0c7c5d0c..04258676d072 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1013,7 +1013,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.stride = sizeof(struct sq_sge);
 	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
+	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
+				    : 0;
 	/* Update msn tbl size */
 	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
 		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 1b6d16af8c12..2517c972c651 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -151,7 +151,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		return ret;
 	}
 
-	ret = xa_err(xa_store(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to xa_store CQ, ret = %d.\n", ret);
 		goto err_put;
@@ -164,7 +164,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	return 0;
 
 err_xa:
-	xa_erase(&cq_table->array, hr_cq->cqn);
+	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 err_put:
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 
@@ -183,7 +183,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
 
-	xa_erase(&cq_table->array, hr_cq->cqn);
+	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 
 	/* Waiting interrupt process procedure carried out */
 	synchronize_irq(hr_dev->eq_table.eq[hr_cq->vector].irq);
@@ -477,13 +477,6 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 	struct ib_event event;
 	struct ib_cq *ibcq;
 
-	hr_cq = xa_load(&hr_dev->cq_table.array,
-			cqn & (hr_dev->caps.num_cqs - 1));
-	if (!hr_cq) {
-		dev_warn(dev, "async event for bogus CQ 0x%06x\n", cqn);
-		return;
-	}
-
 	if (event_type != HNS_ROCE_EVENT_TYPE_CQ_ID_INVALID &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW) {
@@ -492,7 +485,16 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		return;
 	}
 
-	refcount_inc(&hr_cq->refcount);
+	xa_lock(&hr_dev->cq_table.array);
+	hr_cq = xa_load(&hr_dev->cq_table.array,
+			cqn & (hr_dev->caps.num_cqs - 1));
+	if (hr_cq)
+		refcount_inc(&hr_cq->refcount);
+	xa_unlock(&hr_dev->cq_table.array);
+	if (!hr_cq) {
+		dev_warn(dev, "async event for bogus CQ 0x%06x\n", cqn);
+		return;
+	}
 
 	ibcq = &hr_cq->ib_cq;
 	if (ibcq->event_handler) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 7d23d3c51da4..fea6d7d508b6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -61,16 +61,16 @@ enum {
 	 (sizeof(struct scatterlist) + sizeof(void *)))
 
 #define check_whether_bt_num_3(type, hop_num) \
-	(type < HEM_TYPE_MTT && hop_num == 2)
+	((type) < HEM_TYPE_MTT && (hop_num) == 2)
 
 #define check_whether_bt_num_2(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == 2))
+	(((type) < HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 2))
 
 #define check_whether_bt_num_1(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0) || \
-	(type >= HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
+	(((type) < HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0))
 
 struct hns_roce_hem_chunk {
 	struct list_head	 list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 34e58e09b15d..f95ec4618fbe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2105,7 +2105,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 					 caps->gmv_bt_num *
 					 (HNS_HW_PAGE_SIZE / caps->gmv_entry_sz));
 
-		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+		caps->gmv_entry_num = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 							  caps->gmv_entry_sz);
 	} else {
 		u32 func_num = max_t(u32, 1, hr_dev->func_num);
@@ -3715,8 +3715,9 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		   wc->status == IB_WC_WR_FLUSH_ERR))
 		return;
 
-	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
-	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 4, cqe,
+	ibdev_err_ratelimited(&hr_dev->ib_dev, "error cqe status 0x%x:\n",
+			      cqe_status);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 4, cqe,
 		       cq->cqe_size, false);
 	wc->vendor_err = hr_reg_read(cqe, CQE_SUB_STATUS);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b55fe6911f9f..a33d3cedbc94 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,6 +37,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 91cd580480fe..0d42fd197c11 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -433,18 +433,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
-	int ret = 0;
+	int ret, sg_num = 0;
 
 	mr->npages = 0;
 	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
 				 sizeof(dma_addr_t), GFP_KERNEL);
 	if (!mr->page_list)
-		return ret;
+		return sg_num;
 
-	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
-	if (ret < 1) {
+	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	if (sg_num < 1) {
 		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
-			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
+			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
 		goto err_page_list;
 	}
 
@@ -455,17 +455,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
 	if (ret) {
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
-		ret = 0;
+		sg_num = 0;
 	} else {
 		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
-		ret = mr->npages;
 	}
 
 err_page_list:
 	kvfree(mr->page_list);
 	mr->page_list = NULL;
 
-	return ret;
+	return sg_num;
 }
 
 static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 4abae9477854..8f48c6723e07 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -123,7 +123,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		return ret;
 	}
 
-	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
 		goto err_put;
@@ -136,7 +136,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	return 0;
 
 err_xa:
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 
@@ -154,7 +154,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
 
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 
 	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 4a71e678d09c..89fcc09ded8a 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -39,37 +39,13 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	cq->cqe = attr->cqe;
-	cq->umem = ib_umem_get(ibdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
-			       IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->umem)) {
-		err = PTR_ERR(cq->umem);
-		ibdev_dbg(ibdev, "Failed to get umem for create cq, err %d\n",
-			  err);
-		return err;
-	}
-
-	err = mana_ib_create_zero_offset_dma_region(mdev, cq->umem, &cq->gdma_region);
+	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE, &cq->queue);
 	if (err) {
-		ibdev_dbg(ibdev,
-			  "Failed to create dma region for create cq, %d\n",
-			  err);
-		goto err_release_umem;
+		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
+		return err;
 	}
 
-	ibdev_dbg(ibdev,
-		  "create_dma_region ret %d gdma_region 0x%llx\n",
-		  err, cq->gdma_region);
-
-	/*
-	 * The CQ ID is not known at this time. The ID is generated at create_qp
-	 */
-	cq->id = INVALID_QUEUE_ID;
-
 	return 0;
-
-err_release_umem:
-	ib_umem_release(cq->umem);
-	return err;
 }
 
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
@@ -78,24 +54,16 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
 	struct gdma_context *gc;
-	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(mdev);
 
-	err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
-	if (err) {
-		ibdev_dbg(ibdev,
-			  "Failed to destroy dma region, %d\n", err);
-		return err;
+	if (cq->queue.id != INVALID_QUEUE_ID) {
+		kfree(gc->cq_table[cq->queue.id]);
+		gc->cq_table[cq->queue.id] = NULL;
 	}
 
-	if (cq->id != INVALID_QUEUE_ID) {
-		kfree(gc->cq_table[cq->id]);
-		gc->cq_table[cq->id] = NULL;
-	}
-
-	ib_umem_release(cq->umem);
+	mana_ib_destroy_queue(mdev, &cq->queue);
 
 	return 0;
 }
@@ -113,8 +81,10 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue *gdma_cq;
 
+	if (cq->queue.id >= gc->max_num_cqs)
+		return -EINVAL;
 	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[cq->id]);
+	WARN_ON(gc->cq_table[cq->queue.id]);
 	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
 	if (!gdma_cq)
 		return -ENOMEM;
@@ -122,7 +92,7 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	gdma_cq->cq.context = cq;
 	gdma_cq->type = GDMA_CQ;
 	gdma_cq->cq.callback = mana_ib_cq_handler;
-	gdma_cq->id = cq->id;
-	gc->cq_table[cq->id] = gdma_cq;
+	gdma_cq->id = cq->queue.id;
+	gc->cq_table[cq->queue.id] = gdma_cq;
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 71e33feee61b..4524c6b80748 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -237,6 +237,49 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
 }
 
+int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+			 struct mana_ib_queue *queue)
+{
+	struct ib_umem *umem;
+	int err;
+
+	queue->umem = NULL;
+	queue->id = INVALID_QUEUE_ID;
+	queue->gdma_region = GDMA_INVALID_DMA_REGION;
+
+	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %d\n", err);
+		return err;
+	}
+
+	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
+	if (err) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n", err);
+		goto free_umem;
+	}
+	queue->umem = umem;
+
+	ibdev_dbg(&mdev->ib_dev,
+		  "create_dma_region ret %d gdma_region 0x%llx\n",
+		  err, queue->gdma_region);
+
+	return 0;
+free_umem:
+	ib_umem_release(umem);
+	return err;
+}
+
+void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue)
+{
+	/* Ignore return code as there is not much we can do about it.
+	 * The error message is printed inside.
+	 */
+	mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);
+	ib_umem_release(queue->umem);
+}
+
 static int
 mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
 			    struct gdma_context *gc,
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index f83390eebb7d..6acb5c281c36 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -45,6 +45,12 @@ struct mana_ib_adapter_caps {
 	u32 max_inline_data_size;
 };
 
+struct mana_ib_queue {
+	struct ib_umem *umem;
+	u64 gdma_region;
+	u64 id;
+};
+
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
@@ -82,10 +88,8 @@ struct mana_ib_mr {
 
 struct mana_ib_cq {
 	struct ib_cq ibcq;
-	struct ib_umem *umem;
+	struct mana_ib_queue queue;
 	int cqe;
-	u64 gdma_region;
-	u64 id;
 	u32 comp_vector;
 };
 
@@ -169,6 +173,10 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 				  mana_handle_t gdma_region);
 
+int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+			 struct mana_ib_queue *queue);
+void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
+
 struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 6e7627745c95..d7485ee6a685 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -197,7 +197,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq_spec.gdma_region = wq->gdma_region;
 		wq_spec.queue_size = wq->wq_buf_size;
 
-		cq_spec.gdma_region = cq->gdma_region;
+		cq_spec.gdma_region = cq->queue.gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
 		eq = &mpc->ac->eqs[cq->comp_vector % gc->max_num_queues];
@@ -213,16 +213,16 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->gdma_region = GDMA_INVALID_DMA_REGION;
-		cq->gdma_region = GDMA_INVALID_DMA_REGION;
+		cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
 		wq->id = wq_spec.queue_index;
-		cq->id = cq_spec.queue_index;
+		cq->queue.id = cq_spec.queue_index;
 
 		ibdev_dbg(&mdev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
-			  ret, wq->rx_object, wq->id, cq->id);
+			  ret, wq->rx_object, wq->id, cq->queue.id);
 
-		resp.entries[i].cqid = cq->id;
+		resp.entries[i].cqid = cq->queue.id;
 		resp.entries[i].wqid = wq->id;
 
 		mana_ind_table[i] = wq->rx_object;
@@ -232,7 +232,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		if (ret)
 			goto fail;
 
-		gdma_cq_allocated[i] = gc->cq_table[cq->id];
+		gdma_cq_allocated[i] = gc->cq_table[cq->queue.id];
 	}
 	resp.num_entries = i;
 
@@ -264,7 +264,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 		cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 
-		gc->cq_table[cq->id] = NULL;
+		gc->cq_table[cq->queue.id] = NULL;
 		kfree(gdma_cq_allocated[i]);
 
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
@@ -374,7 +374,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	wq_spec.gdma_region = qp->sq_gdma_region;
 	wq_spec.queue_size = ucmd.sq_buf_size;
 
-	cq_spec.gdma_region = send_cq->gdma_region;
+	cq_spec.gdma_region = send_cq->queue.gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
 	eq_vec = send_cq->comp_vector % gc->max_num_queues;
@@ -392,10 +392,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	/* The GDMA regions are now owned by the WQ object */
 	qp->sq_gdma_region = GDMA_INVALID_DMA_REGION;
-	send_cq->gdma_region = GDMA_INVALID_DMA_REGION;
+	send_cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
 	qp->sq_id = wq_spec.queue_index;
-	send_cq->id = cq_spec.queue_index;
+	send_cq->queue.id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
 	err = mana_ib_install_cq_cb(mdev, send_cq);
@@ -404,10 +404,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
-		  qp->tx_object, qp->sq_id, send_cq->id);
+		  qp->tx_object, qp->sq_id, send_cq->queue.id);
 
 	resp.sqid = qp->sq_id;
-	resp.cqid = send_cq->id;
+	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
 	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
@@ -422,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 err_release_gdma_cq:
 	kfree(gdma_cq);
-	gc->cq_table[send_cq->id] = NULL;
+	gc->cq_table[send_cq->queue.id] = NULL;
 
 err_destroy_wq_obj:
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 96ffbbaf0a73..5a22be14d958 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/io.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
@@ -108,7 +109,6 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	__be32 mmio_wqe[16] = {};
 	unsigned long flags;
 	unsigned int idx;
-	int i;
 
 	if (unlikely(dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
 		return -EIO;
@@ -148,10 +148,8 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	 * we hit doorbell
 	 */
 	wmb();
-	for (i = 0; i < 8; i++)
-		mlx5_write64(&mmio_wqe[i * 2],
-			     bf->bfreg->map + bf->offset + i * 8);
-	io_stop_wc();
+	__iowrite64_copy(bf->bfreg->map + bf->offset, mmio_wqe,
+			 sizeof(mmio_wqe) / 8);
 
 	bf->offset ^= bf->buf_size;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bbe79b86c717..79ebafecca22 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -643,9 +643,10 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
-	/* User Mkey must hold either a rb_key or a cache_ent. */
+	/* Cacheable user Mkey must hold either a rb_key or a cache_ent. */
 	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
+	u8 cacheable : 1;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a8ee2ca1f4a1..ecc111ed5d86 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1158,6 +1158,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		if (IS_ERR(mr))
 			return mr;
 		mr->mmkey.rb_key = rb_key;
+		mr->mmkey.cacheable = true;
 		return mr;
 	}
 
@@ -1168,6 +1169,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->page_shift = order_base_2(page_size);
+	mr->mmkey.cacheable = true;
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 
 	return mr;
@@ -1570,7 +1572,8 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 	unsigned int diffs = current_access_flags ^ target_access_flags;
 
 	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
-		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING |
+		      IB_ACCESS_REMOTE_ATOMIC))
 		return false;
 	return mlx5r_umr_can_reconfig(dev, current_access_flags,
 				      target_access_flags);
@@ -1835,6 +1838,23 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	return ret;
 }
 
+static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+
+	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr))
+		return 0;
+
+	if (ent) {
+		spin_lock_irq(&ent->mkeys_queue.lock);
+		ent->in_use--;
+		mr->mmkey.cache_ent = NULL;
+		spin_unlock_irq(&ent->mkeys_queue.lock);
+	}
+	return destroy_mkey(dev, mr);
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1880,16 +1900,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	/* Stop DMA */
-	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
-		if (mlx5r_umr_revoke_mr(mr) ||
-		    cache_ent_find_and_store(dev, mr))
-			mr->mmkey.cache_ent = NULL;
-
-	if (!mr->mmkey.cache_ent) {
-		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
-		if (rc)
-			return rc;
-	}
+	rc = mlx5_revoke_mr(mr);
+	if (rc)
+		return rc;
 
 	if (mr->umem) {
 		bool is_odp = is_odp_mr(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d0bdc2d8adc8..acd2172bf092 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -131,12 +131,12 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
 	int must_sched;
 
-	skb_queue_tail(&qp->resp_pkts, skb);
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
+	skb_queue_tail(&qp->resp_pkts, skb);
+
 	if (must_sched)
 		rxe_sched_task(&qp->comp.task);
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cd59666158b1..e5827064ab1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -366,18 +366,10 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
-	if (skb->protocol == htons(ETH_P_IP)) {
+	if (skb->protocol == htons(ETH_P_IP))
 		err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	else
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else {
-		rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
-				skb->protocol);
-		atomic_dec(&pkt->qp->skb_out);
-		rxe_put(pkt->qp);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
 
 	if (unlikely(net_xmit_eval(err))) {
 		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 48f86839d36a..0930350522e3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -888,6 +888,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 {
 	int err = 0;
 	unsigned long flags;
+	int good = 0;
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 	while (ibwr) {
@@ -895,12 +896,15 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 		if (err) {
 			*bad_wr = ibwr;
 			break;
+		} else {
+			good++;
 		}
 		ibwr = ibwr->next;
 	}
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
-	if (!err)
+	/* kickoff processing of any posted wqes */
+	if (good)
 		rxe_sched_task(&qp->req.task);
 
 	spin_lock_irqsave(&qp->state_lock, flags);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 4bd161e86f8d..562df2b3ef18 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -184,8 +184,12 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 
 	ppriv = ipoib_priv(pdev);
 
-	snprintf(intf_name, sizeof(intf_name), "%s.%04x",
-		 ppriv->dev->name, pkey);
+	/* If you increase IFNAMSIZ, update snprintf below
+	 * to allow longer names.
+	 */
+	BUILD_BUG_ON(IFNAMSIZ != 16);
+	snprintf(intf_name, sizeof(intf_name), "%.10s.%04x", ppriv->dev->name,
+		 pkey);
 
 	ndev = ipoib_intf_alloc(ppriv->ca, ppriv->port, intf_name);
 	if (IS_ERR(ndev)) {
diff --git a/drivers/input/input.c b/drivers/input/input.c
index f71ea4fb173f..3212c63dcf5b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1378,19 +1378,19 @@ static int input_print_modalias_bits(char *buf, int size,
 				     char name, const unsigned long *bm,
 				     unsigned int min_bit, unsigned int max_bit)
 {
-	int len = 0, i;
+	int bit = min_bit;
+	int len = 0;
 
 	len += snprintf(buf, max(size, 0), "%c", name);
-	for (i = min_bit; i < max_bit; i++)
-		if (bm[BIT_WORD(i)] & BIT_MASK(i))
-			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
+	for_each_set_bit_from(bit, bm, max_bit)
+		len += snprintf(buf + len, max(size - len, 0), "%X,", bit);
 	return len;
 }
 
-static int input_print_modalias(char *buf, int size, const struct input_dev *id,
-				int add_cr)
+static int input_print_modalias_parts(char *buf, int size, int full_len,
+				      const struct input_dev *id)
 {
-	int len;
+	int len, klen, remainder, space;
 
 	len = snprintf(buf, max(size, 0),
 		       "input:b%04Xv%04Xp%04Xe%04X-",
@@ -1399,8 +1399,48 @@ static int input_print_modalias(char *buf, int size, const struct input_dev *id,
 
 	len += input_print_modalias_bits(buf + len, size - len,
 				'e', id->evbit, 0, EV_MAX);
-	len += input_print_modalias_bits(buf + len, size - len,
+
+	/*
+	 * Calculate the remaining space in the buffer making sure we
+	 * have place for the terminating 0.
+	 */
+	space = max(size - (len + 1), 0);
+
+	klen = input_print_modalias_bits(buf + len, size - len,
 				'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
+	len += klen;
+
+	/*
+	 * If we have more data than we can fit in the buffer, check
+	 * if we can trim key data to fit in the rest. We will indicate
+	 * that key data is incomplete by adding "+" sign at the end, like
+	 * this: * "k1,2,3,45,+,".
+	 *
+	 * Note that we shortest key info (if present) is "k+," so we
+	 * can only try to trim if key data is longer than that.
+	 */
+	if (full_len && size < full_len + 1 && klen > 3) {
+		remainder = full_len - len;
+		/*
+		 * We can only trim if we have space for the remainder
+		 * and also for at least "k+," which is 3 more characters.
+		 */
+		if (remainder <= space - 3) {
+			/*
+			 * We are guaranteed to have 'k' in the buffer, so
+			 * we need at least 3 additional bytes for storing
+			 * "+," in addition to the remainder.
+			 */
+			for (int i = size - 1 - remainder - 3; i >= 0; i--) {
+				if (buf[i] == 'k' || buf[i] == ',') {
+					strcpy(buf + i + 1, "+,");
+					len = i + 3; /* Not counting '\0' */
+					break;
+				}
+			}
+		}
+	}
+
 	len += input_print_modalias_bits(buf + len, size - len,
 				'r', id->relbit, 0, REL_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
@@ -1416,12 +1456,25 @@ static int input_print_modalias(char *buf, int size, const struct input_dev *id,
 	len += input_print_modalias_bits(buf + len, size - len,
 				'w', id->swbit, 0, SW_MAX);
 
-	if (add_cr)
-		len += snprintf(buf + len, max(size - len, 0), "\n");
-
 	return len;
 }
 
+static int input_print_modalias(char *buf, int size, const struct input_dev *id)
+{
+	int full_len;
+
+	/*
+	 * Printing is done in 2 passes: first one figures out total length
+	 * needed for the modalias string, second one will try to trim key
+	 * data in case when buffer is too small for the entire modalias.
+	 * If the buffer is too small regardless, it will fill as much as it
+	 * can (without trimming key data) into the buffer and leave it to
+	 * the caller to figure out what to do with the result.
+	 */
+	full_len = input_print_modalias_parts(NULL, 0, 0, id);
+	return input_print_modalias_parts(buf, size, full_len, id);
+}
+
 static ssize_t input_dev_show_modalias(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -1429,7 +1482,9 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 	struct input_dev *id = to_input_dev(dev);
 	ssize_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	return min_t(int, len, PAGE_SIZE);
 }
@@ -1641,6 +1696,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
 	return 0;
 }
 
+/*
+ * This is a pretty gross hack. When building uevent data the driver core
+ * may try adding more environment variables to kobj_uevent_env without
+ * telling us, so we have no idea how much of the buffer we can use to
+ * avoid overflows/-ENOMEM elsewhere. To work around this let's artificially
+ * reduce amount of memory we will use for the modalias environment variable.
+ *
+ * The potential additions are:
+ *
+ * SEQNUM=18446744073709551615 - (%llu - 28 bytes)
+ * HOME=/ (6 bytes)
+ * PATH=/sbin:/bin:/usr/sbin:/usr/bin (34 bytes)
+ *
+ * 68 bytes total. Allow extra buffer - 96 bytes
+ */
+#define UEVENT_ENV_EXTRA_LEN	96
+
 static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 					 const struct input_dev *dev)
 {
@@ -1650,9 +1722,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 		return -ENOMEM;
 
 	len = input_print_modalias(&env->buf[env->buflen - 1],
-				   sizeof(env->buf) - env->buflen,
-				   dev, 0);
-	if (len >= (sizeof(env->buf) - env->buflen))
+				   (int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN,
+				   dev);
+	if (len >= ((int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN))
 		return -ENOMEM;
 
 	env->buflen += len;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1fad51b51b0e..c2de2f063cb8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -207,6 +207,7 @@ static const struct xpad_device {
 	{ 0x0738, 0xcb29, "Saitek Aviator Stick AV8R02", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xf738, "Super SFIV FightStick TE S", 0, XTYPE_XBOX360 },
 	{ 0x07ff, 0xffff, "Mad Catz GamePad", 0, XTYPE_XBOX360 },
+	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", 0, XTYPE_XBOXONE },
 	{ 0x0c12, 0x0005, "Intec wireless", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8801, "Nyko Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
@@ -482,6 +483,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
 	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
 	XPAD_XBOX360_VENDOR(0x07ff),		/* Mad Catz Gamepad */
+	XPAD_XBOXONE_VENDOR(0x0b05),		/* ASUS controllers */
 	XPAD_XBOX360_VENDOR(0x0c12),		/* Zeroplus X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f Xbox One controllers */
diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index cda0c3ff5a28..2fbbaeb76d70 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -132,7 +132,13 @@ static void __exit amimouse_remove(struct platform_device *pdev)
 	input_unregister_device(dev);
 }
 
-static struct platform_driver amimouse_driver = {
+/*
+ * amimouse_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amimouse_driver __refdata = {
 	.remove_new = __exit_p(amimouse_remove),
 	.driver   = {
 		.name	= "amiga-mouse",
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ad33161f2374..e606d250d1d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3510,15 +3510,26 @@ EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
 				   struct iommu_group *group, ioasid_t pasid)
 {
-	struct group_device *device;
-	int ret = 0;
+	struct group_device *device, *last_gdev;
+	int ret;
 
 	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
 		if (ret)
-			break;
+			goto err_revert;
 	}
 
+	return 0;
+
+err_revert:
+	last_gdev = device;
+	for_each_group_device(group, device) {
+		const struct iommu_ops *ops = dev_iommu_ops(device->dev);
+
+		if (device == last_gdev)
+			break;
+		ops->remove_dev_pasid(device->dev, pasid);
+	}
 	return ret;
 }
 
@@ -3576,10 +3587,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret) {
-		__iommu_remove_group_pasid(group, pasid);
+	if (ret)
 		xa_erase(&group->pasid_array, pasid);
-	}
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 9c8b1349ee17..a1430ab60a8a 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,7 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 6e1e1f011bb2..dd4d699170f4 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -136,7 +136,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
 
 err_hwirq:
 	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 
 	return err;
 }
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index db9270da5b8e..b6ddf1d47cb4 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -140,24 +140,19 @@ static int macii_probe(void)
 /* Initialize the driver */
 static int macii_init(void)
 {
-	unsigned long flags;
 	int err;
 
-	local_irq_save(flags);
-
 	err = macii_init_via();
 	if (err)
-		goto out;
+		return err;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, 0, "ADB",
 			  macii_interrupt);
 	if (err)
-		goto out;
+		return err;
 
 	macii_state = idle;
-out:
-	local_irq_restore(flags);
-	return err;
+	return 0;
 }
 
 /* initialize the hardware */
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 5eabdb06c649..2ac43d1f1b92 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -154,8 +154,10 @@ static void delay_dtr(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	if (dc->kdelayd_wq)
+	if (dc->kdelayd_wq) {
+		timer_shutdown_sync(&dc->delay_timer);
 		destroy_workqueue(dc->kdelayd_wq);
+	}
 
 	if (dc->read.dev)
 		dm_put_device(ti, dc->read.dev);
@@ -240,19 +242,18 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ret = delay_class_ctr(ti, &dc->flush, argv);
 		if (ret)
 			goto bad;
-		max_delay = max(max_delay, dc->write.delay);
-		max_delay = max(max_delay, dc->flush.delay);
 		goto out;
 	}
 
 	ret = delay_class_ctr(ti, &dc->write, argv + 3);
 	if (ret)
 		goto bad;
+	max_delay = max(max_delay, dc->write.delay);
+
 	if (argc == 6) {
 		ret = delay_class_ctr(ti, &dc->flush, argv + 3);
 		if (ret)
 			goto bad;
-		max_delay = max(max_delay, dc->flush.delay);
 		goto out;
 	}
 
@@ -267,8 +268,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		 * In case of small requested delays, use kthread instead of
 		 * timers and workqueue to achieve better latency.
 		 */
-		dc->worker = kthread_create(&flush_worker_fn, dc,
-					    "dm-delay-flush-worker");
+		dc->worker = kthread_run(&flush_worker_fn, dc, "dm-delay-flush-worker");
 		if (IS_ERR(dc->worker)) {
 			ret = PTR_ERR(dc->worker);
 			dc->worker = NULL;
@@ -335,7 +335,7 @@ static void delay_presuspend(struct dm_target *ti)
 	mutex_unlock(&delayed_bios_lock);
 
 	if (!delay_is_fast(dc))
-		del_timer_sync(&dc->delay_timer);
+		timer_delete(&dc->delay_timer);
 	flush_delayed_bios(dc, true);
 }
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index a4976ceae868..ee67da44641b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1427,7 +1427,7 @@ __acquires(bitmap->lock)
 	sector_t chunk = offset >> bitmap->chunkshift;
 	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
 	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
-	sector_t csize;
+	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
 	int err;
 
 	if (page >= bitmap->pages) {
@@ -1436,6 +1436,7 @@ __acquires(bitmap->lock)
 		 * End-of-device while looking for a whole page or
 		 * user set a huge number to sysfs bitmap_set_bits.
 		 */
+		*blocks = csize - (offset & (csize - 1));
 		return NULL;
 	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
@@ -1444,8 +1445,7 @@ __acquires(bitmap->lock)
 	    bitmap->bp[page].map == NULL)
 		csize = ((sector_t)1) << (bitmap->chunkshift +
 					  PAGE_COUNTER_SHIFT);
-	else
-		csize = ((sector_t)1) << bitmap->chunkshift;
+
 	*blocks = csize - (offset & (csize - 1));
 
 	if (err < 0)
diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index f548b1bb75fb..e932d25ca7b3 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1475,7 +1475,7 @@ static int et8ek8_probe(struct i2c_client *client)
 	return ret;
 }
 
-static void __exit et8ek8_remove(struct i2c_client *client)
+static void et8ek8_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
 	struct et8ek8_sensor *sensor = to_et8ek8_sensor(subdev);
@@ -1517,7 +1517,7 @@ static struct i2c_driver et8ek8_i2c_driver = {
 		.of_match_table	= et8ek8_of_table,
 	},
 	.probe		= et8ek8_probe,
-	.remove		= __exit_p(et8ek8_remove),
+	.remove		= et8ek8_remove,
 	.id_table	= et8ek8_id_table,
 };
 
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index ed08bf4178f0..d5478779b310 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1789,11 +1789,6 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	v4l2_async_nf_init(&cio2->notifier, &cio2->v4l2_dev);
 
-	/* Register notifier for subdevices we care */
-	r = cio2_parse_firmware(cio2);
-	if (r)
-		goto fail_clean_notifier;
-
 	r = devm_request_irq(dev, pci_dev->irq, cio2_irq, IRQF_SHARED,
 			     CIO2_NAME, cio2);
 	if (r) {
@@ -1801,6 +1796,11 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 		goto fail_clean_notifier;
 	}
 
+	/* Register notifier for subdevices we care */
+	r = cio2_parse_firmware(cio2);
+	if (r)
+		goto fail_clean_notifier;
+
 	pm_runtime_put_noidle(dev);
 	pm_runtime_allow(dev);
 
diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index 7481f553f959..24ec576dc3bf 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -1488,7 +1488,9 @@ static int init_channel(struct ngene_channel *chan)
 	}
 
 	if (dev->ci.en && (io & NGENE_IO_TSOUT)) {
-		dvb_ca_en50221_init(adapter, dev->ci.en, 0, 1);
+		ret = dvb_ca_en50221_init(adapter, dev->ci.en, 0, 1);
+		if (ret != 0)
+			goto err;
 		set_transfer(chan, 1);
 		chan->dev->channel[2].DataFormatFlags = DF_SWAP32;
 		set_transfer(&chan->dev->channel[2], 1);
diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 0ea5fa956fe9..5be75bd4add3 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -235,10 +235,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
 
-	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
-	if (ret)
-		goto err_disable_pclk;
-
 	/* Enable DPHY clk and data lanes. */
 	if (csi2rx->dphy) {
 		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
@@ -248,6 +244,13 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		}
 
 		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+
+		ret = csi2rx_configure_ext_dphy(csi2rx);
+		if (ret) {
+			dev_err(csi2rx->dev,
+				"Failed to configure external DPHY: %d\n", ret);
+			goto err_disable_pclk;
+		}
 	}
 
 	/*
@@ -287,14 +290,9 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	reset_control_deassert(csi2rx->sys_rst);
 
-	if (csi2rx->dphy) {
-		ret = csi2rx_configure_ext_dphy(csi2rx);
-		if (ret) {
-			dev_err(csi2rx->dev,
-				"Failed to configure external DPHY: %d\n", ret);
-			goto err_disable_sysclk;
-		}
-	}
+	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
+	if (ret)
+		goto err_disable_sysclk;
 
 	clk_disable_unprepare(csi2rx->p_clk);
 
@@ -308,6 +306,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
 	}
 
+	if (csi2rx->dphy) {
+		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+		phy_power_off(csi2rx->dphy);
+	}
 err_disable_pclk:
 	clk_disable_unprepare(csi2rx->p_clk);
 
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
index 792336dada44..997a66318a29 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
@@ -59,7 +59,7 @@ enum rvin_isp_id {
 
 #define RVIN_REMOTES_MAX \
 	(((unsigned int)RVIN_CSI_MAX) > ((unsigned int)RVIN_ISP_MAX) ? \
-	 RVIN_CSI_MAX : RVIN_ISP_MAX)
+	 (unsigned int)RVIN_CSI_MAX : (unsigned int)RVIN_ISP_MAX)
 
 /**
  * enum rvin_dma_state - DMA states
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335..e3e6aa87fe08 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -62,7 +62,7 @@ struct shark_device {
 #ifdef SHARK_USE_LEDS
 	struct work_struct led_work;
 	struct led_classdev leds[NO_LEDS];
-	char led_names[NO_LEDS][32];
+	char led_names[NO_LEDS][64];
 	atomic_t brightness[NO_LEDS];
 	unsigned long brightness_new;
 #endif
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bbd90123a4e7..91a41aa3ced2 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/usb/uvc.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
@@ -2232,6 +2233,9 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	if (dev->quirks & UVC_QUIRK_NO_RESET_RESUME)
+		udev->quirks &= ~USB_QUIRK_RESET_RESUME;
+
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
 	usb_enable_autosuspend(udev);
 	return 0;
@@ -2574,6 +2578,33 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech Rally Bar Huddle */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x087c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
+	/* Logitech Rally Bar */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x089b,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
+	/* Logitech Rally Bar Mini */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x08d3,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
 	/* Chicony CNF7129 (Asus EEE 100HE) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b00..88218693f6f0 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -73,6 +73,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 4c6198c48dd6..45836f0a2b0a 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -732,6 +732,7 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		memset(&sel, 0, sizeof(sel));
 		sel.which = crop->which;
 		sel.pad = crop->pad;
+		sel.stream = crop->stream;
 		sel.target = V4L2_SEL_TGT_CROP;
 
 		rval = v4l2_subdev_call(
@@ -756,6 +757,7 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		memset(&sel, 0, sizeof(sel));
 		sel.which = crop->which;
 		sel.pad = crop->pad;
+		sel.stream = crop->stream;
 		sel.target = V4L2_SEL_TGT_CROP;
 		sel.r = crop->rect;
 
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 95ef971b5e1c..b28701138b4b 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -19,7 +19,7 @@ KASAN_SANITIZE_rodata.o			:= n
 KCSAN_SANITIZE_rodata.o			:= n
 KCOV_INSTRUMENT_rodata.o		:= n
 OBJECT_FILES_NON_STANDARD_rodata.o	:= y
-CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
+CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS) $(CC_FLAGS_CFI)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index b93404d65650..5b861dbff27e 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -61,7 +61,7 @@ static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
 	return fdesc;
 }
 
-static noinline void execute_location(void *dst, bool write)
+static noinline __nocfi void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 0de87bc63840..6d5c755411de 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -956,8 +956,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
 		size = mtd_otp_size(mtd, true);
-		if (size < 0)
-			return size;
+		if (size < 0) {
+			err = size;
+			goto err;
+		}
 
 		if (size > 0) {
 			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 39076735a3fb..9695f07b5eb2 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -402,7 +402,7 @@ static int hynix_nand_rr_init(struct nand_chip *chip)
 	if (ret)
 		pr_warn("failed to initialize read-retry infrastructure");
 
-	return 0;
+	return ret;
 }
 
 static void hynix_nand_extract_oobsize(struct nand_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 967d9136313f..2ad9e4cd7b30 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3135,6 +3135,7 @@ static int mv88e6xxx_software_reset(struct mv88e6xxx_chip *chip)
 static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 {
 	struct gpio_desc *gpiod = chip->reset;
+	int err;
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
@@ -3143,17 +3144,26 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 		 * mid-byte, causing the first EEPROM read after the reset
 		 * from the wrong location resulting in the switch booting
 		 * to wrong mode and inoperable.
+		 * For this reason, switch families with EEPROM support
+		 * generally wait for EEPROM loads to complete as their pre-
+		 * and post-reset handlers.
 		 */
-		if (chip->info->ops->get_eeprom)
-			mv88e6xxx_g2_eeprom_wait(chip);
+		if (chip->info->ops->hardware_reset_pre) {
+			err = chip->info->ops->hardware_reset_pre(chip);
+			if (err)
+				dev_err(chip->dev, "pre-reset error: %d\n", err);
+		}
 
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
 		usleep_range(10000, 20000);
 
-		if (chip->info->ops->get_eeprom)
-			mv88e6xxx_g2_eeprom_wait(chip);
+		if (chip->info->ops->hardware_reset_post) {
+			err = chip->info->ops->hardware_reset_post(chip);
+			if (err)
+				dev_err(chip->dev, "post-reset error: %d\n", err);
+		}
 	}
 }
 
@@ -4380,6 +4390,8 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4570,6 +4582,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4670,6 +4684,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4764,6 +4780,8 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4822,6 +4840,8 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4878,6 +4898,8 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4937,6 +4959,8 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4990,6 +5014,8 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.watchdog_ops = &mv88e6250_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6250_g1_wait_eeprom_done_prereset,
+	.hardware_reset_post = mv88e6xxx_g1_wait_eeprom_done,
 	.reset = mv88e6250_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5037,6 +5063,8 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5096,6 +5124,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5142,6 +5172,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5192,6 +5224,8 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5347,6 +5381,8 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5409,6 +5445,8 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5471,6 +5509,8 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5536,6 +5576,8 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.watchdog_ops = &mv88e6393x_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6393x_port_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 85eb293381a7..c34caf9815c5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -487,6 +487,12 @@ struct mv88e6xxx_ops {
 	int (*ppu_enable)(struct mv88e6xxx_chip *chip);
 	int (*ppu_disable)(struct mv88e6xxx_chip *chip);
 
+	/* Additional handlers to run before and after hard reset, to make sure
+	 * that the switch and EEPROM are in a good state.
+	 */
+	int (*hardware_reset_pre)(struct mv88e6xxx_chip *chip);
+	int (*hardware_reset_post)(struct mv88e6xxx_chip *chip);
+
 	/* Switch Software Reset */
 	int (*reset)(struct mv88e6xxx_chip *chip);
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 49444a72ff09..9820cd596757 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,6 +75,95 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
+static int mv88e6250_g1_eeprom_reload(struct mv88e6xxx_chip *chip)
+{
+	/* MV88E6185_G1_CTL1_RELOAD_EEPROM is also valid for 88E6250 */
+	int bit = __bf_shf(MV88E6185_G1_CTL1_RELOAD_EEPROM);
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL1, &val);
+	if (err)
+		return err;
+
+	val |= MV88E6185_G1_CTL1_RELOAD_EEPROM;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL1, val);
+	if (err)
+		return err;
+
+	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_CTL1, bit, 0);
+}
+
+/* Returns 0 when done, -EBUSY when waiting, other negative codes on error */
+static int mv88e6xxx_g1_is_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
+	if (err < 0) {
+		dev_err(chip->dev, "Error reading status");
+		return err;
+	}
+
+	/* If the switch is still resetting, it may not
+	 * respond on the bus, and so MDIO read returns
+	 * 0xffff. Differentiate between that, and waiting for
+	 * the EEPROM to be done by bit 0 being set.
+	 */
+	if (val == 0xffff || !(val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE)))
+		return -EBUSY;
+
+	return 0;
+}
+
+/* As the EEInt (EEPROM done) flag clears on read if the status register, this
+ * function must be called directly after a hard reset or EEPROM ReLoad request,
+ * or the done condition may have been missed
+ */
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	const unsigned long timeout = jiffies + 1 * HZ;
+	int ret;
+
+	/* Wait up to 1 second for the switch to finish reading the
+	 * EEPROM.
+	 */
+	while (time_before(jiffies, timeout)) {
+		ret = mv88e6xxx_g1_is_eeprom_done(chip);
+		if (ret != -EBUSY)
+			return ret;
+	}
+
+	dev_err(chip->dev, "Timeout waiting for EEPROM done");
+	return -ETIMEDOUT;
+}
+
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip)
+{
+	int ret;
+
+	ret = mv88e6xxx_g1_is_eeprom_done(chip);
+	if (ret != -EBUSY)
+		return ret;
+
+	/* Pre-reset, we don't know the state of the switch - when
+	 * mv88e6xxx_g1_is_eeprom_done() returns -EBUSY, that may be because
+	 * the switch is actually busy reading the EEPROM, or because
+	 * MV88E6XXX_G1_STS_IRQ_EEPROM_DONE has been cleared by an unrelated
+	 * status register read already.
+	 *
+	 * To account for the latter case, trigger another EEPROM reload for
+	 * another chance at seeing the done flag.
+	 */
+	ret = mv88e6250_g1_eeprom_reload(chip);
+	if (ret)
+		return ret;
+
+	return mv88e6xxx_g1_wait_eeprom_done(chip);
+}
+
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 1095261f5b49..3dbb7a1b8fe1 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -282,6 +282,8 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 705c3eb19cd3..d1fbadbf86d4 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1107,10 +1107,13 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
+	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d\n", __func__, netdev->dev_id);
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
+
 	mask = GMAC0_IRQ0_TXQ0_INTS << (6 * netdev->dev_id + txq);
 
 	if (en)
@@ -1119,6 +1122,8 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
 	val = en ? val | mask : val & ~mask;
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
+
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static void gmac_tx_irq(struct net_device *netdev, unsigned int txq_num)
@@ -1415,15 +1420,19 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	union gmac_rxdesc_3 word3;
 	struct page *page = NULL;
 	unsigned int page_offs;
+	unsigned long flags;
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
 	int frag_nr = 0;
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
 	rw.bits32 = readl(ptr_reg);
 	/* Reset interrupt as all packages until here are taken into account */
 	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
 	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
+
 	r = rw.bits.rptr;
 	w = rw.bits.wptr;
 
@@ -1726,10 +1735,9 @@ static irqreturn_t gmac_irq(int irq, void *data)
 		gmac_update_hw_stats(netdev);
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
+		spin_lock(&geth->irq_lock);
 		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
 		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
-
-		spin_lock(&geth->irq_lock);
 		u64_stats_update_begin(&port->ir_stats_syncp);
 		++port->stats.rx_fifo_errors;
 		u64_stats_update_end(&port->ir_stats_syncp);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bfdbdab443ae..5e6e1f7196f8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2769,7 +2769,7 @@ static int enetc_setup_xdp_prog(struct net_device *ndev, struct bpf_prog *prog,
 	if (priv->min_num_stack_tx_queues + num_xdp_tx_queues >
 	    priv->num_tx_rings) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Reserving %d XDP TXQs does not leave a minimum of %d for stack (total %d)",
+				       "Reserving %d XDP TXQs leaves under %d for stack (total %d)",
 				       num_xdp_tx_queues,
 				       priv->min_num_stack_tx_queues,
 				       priv->num_tx_rings);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8decb1b072c5..e92a83033059 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3678,29 +3678,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/**
- * fec_poll_controller - FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-static void fec_poll_controller(struct net_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = netdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif
-
 static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 	netdev_features_t features)
 {
@@ -4007,9 +3984,6 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index c979192e44d1..a545a7917e4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -536,7 +536,7 @@ static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
  *
  * Return 0 on success and a negative value on error.
  */
-int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
+static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
@@ -631,6 +631,62 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	return 0;
 }
 
+int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
+{
+	if (q_idx >= vsi->num_rxq)
+		return -EINVAL;
+
+	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
+}
+
+/**
+ * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
+ * @vsi: VSI
+ */
+static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
+{
+	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
+		vsi->rx_buf_len = ICE_RXBUF_1664;
+#if (PAGE_SIZE < 8192)
+	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
+		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
+		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
+#endif
+	} else {
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
+		vsi->rx_buf_len = ICE_RXBUF_3072;
+	}
+}
+
+/**
+ * ice_vsi_cfg_rxqs - Configure the VSI for Rx
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Rx VSI for operation.
+ */
+int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
+{
+	u16 i;
+
+	if (vsi->type == ICE_VSI_VF)
+		goto setup_rings;
+
+	ice_vsi_cfg_frame_size(vsi);
+setup_rings:
+	/* set up individual rings */
+	ice_for_each_rxq(vsi, i) {
+		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * __ice_vsi_get_qs - helper function for assigning queues from PF to VSI
  * @qs_cfg: gathered variables needed for pf->vsi queues assignment
@@ -826,7 +882,7 @@ void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
  * @ring: Tx ring to be configured
  * @qg_buf: queue group buffer
  */
-int
+static int
 ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 		struct ice_aqc_add_tx_qgrp *qg_buf)
 {
@@ -897,6 +953,80 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 	return 0;
 }
 
+int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
+			   u16 q_idx)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+
+	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
+		return -EINVAL;
+
+	qg_buf->num_txqs = 1;
+
+	return ice_vsi_cfg_txq(vsi, tx_rings[q_idx], qg_buf);
+}
+
+/**
+ * ice_vsi_cfg_txqs - Configure the VSI for Tx
+ * @vsi: the VSI being configured
+ * @rings: Tx ring array to be configured
+ * @count: number of Tx ring array elements
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Tx VSI for operation.
+ */
+static int
+ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	int err = 0;
+	u16 q_idx;
+
+	qg_buf->num_txqs = 1;
+
+	for (q_idx = 0; q_idx < count; q_idx++) {
+		err = ice_vsi_cfg_txq(vsi, rings[q_idx], qg_buf);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+/**
+ * ice_vsi_cfg_lan_txqs - Configure the VSI for Tx
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Tx VSI for operation.
+ */
+int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi)
+{
+	return ice_vsi_cfg_txqs(vsi, vsi->tx_rings, vsi->num_txq);
+}
+
+/**
+ * ice_vsi_cfg_xdp_txqs - Configure Tx queues dedicated for XDP in given VSI
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Tx queues dedicated for XDP in given VSI for operation.
+ */
+int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi)
+{
+	int ret;
+	int i;
+
+	ret = ice_vsi_cfg_txqs(vsi, vsi->xdp_rings, vsi->num_xdp_txq);
+	if (ret)
+		return ret;
+
+	ice_for_each_rxq(vsi, i)
+		ice_tx_xsk_pool(vsi, i);
+
+	return 0;
+}
+
 /**
  * ice_cfg_itr - configure the initial interrupt throttle values
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index 17321ba75602..b711bc921928 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -6,7 +6,8 @@
 
 #include "ice.h"
 
-int ice_vsi_cfg_rxq(struct ice_rx_ring *ring);
+int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
+int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
 int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
 int
 ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx, bool wait);
@@ -14,9 +15,10 @@ int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx);
 int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi);
 void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi);
 void ice_vsi_free_q_vectors(struct ice_vsi *vsi);
-int
-ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
-		struct ice_aqc_add_tx_qgrp *qg_buf);
+int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
+			   u16 q_idx);
+int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi);
+int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi);
 void ice_cfg_itr(struct ice_hw *hw, struct ice_q_vector *q_vector);
 void
 ice_cfg_txq_interrupt(struct ice_vsi *vsi, u16 txq, u16 msix_idx, u16 itr_idx);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 10c32cd80fff..ce50a322daa9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4700,7 +4700,7 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
 	u16 i, buf_size = __struct_size(qg_list);
 	struct ice_q_ctx *q_ctx;
 	int status = -ENOENT;
@@ -4922,7 +4922,7 @@ int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id)
 {
-	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
 	u16 qg_size = __struct_size(qg_list);
 	struct ice_hw *hw;
 	int status = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 8b7504a9df31..1bf8ee98f06f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1424,14 +1424,14 @@ ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 		goto exit;
 	}
 
-	conf_idx = le32_to_cpu(seg->signed_seg_idx);
-	start = le32_to_cpu(seg->signed_buf_start);
 	count = le32_to_cpu(seg->signed_buf_count);
-
 	state = ice_download_pkg_sig_seg(hw, seg);
-	if (state)
+	if (state || !count)
 		goto exit;
 
+	conf_idx = le32_to_cpu(seg->signed_seg_idx);
+	start = le32_to_cpu(seg->signed_buf_start);
+
 	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
 					    count);
 
@@ -1934,8 +1934,8 @@ static enum ice_ddp_state ice_init_pkg_info(struct ice_hw *hw,
  */
 static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 {
-	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
-		    ICE_PKG_CNT);
+	DEFINE_RAW_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
+			ICE_PKG_CNT);
 	u16 size = __struct_size(pkg_info);
 	u32 i;
 
@@ -1986,8 +1986,8 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 					     struct ice_pkg_hdr *ospkg,
 					     struct ice_seg **seg)
 {
-	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
-		    ICE_PKG_CNT);
+	DEFINE_RAW_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
+			ICE_PKG_CNT);
 	u16 size = __struct_size(pkg);
 	enum ice_ddp_state state;
 	u32 i;
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index a7a342809935..f0e76f0a6d60 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -491,7 +491,7 @@ static void
 ice_lag_move_vf_node_tc(struct ice_lag *lag, u8 oldport, u8 newport,
 			u16 vsi_num, u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
@@ -849,7 +849,7 @@ static void
 ice_lag_reclaim_vf_tc(struct ice_lag *lag, struct ice_hw *src_hw, u16 vsi_num,
 		      u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
@@ -1873,7 +1873,7 @@ static void
 ice_lag_move_vf_nodes_tc_sync(struct ice_lag *lag, struct ice_hw *dest_hw,
 			      u16 vsi_num, u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index cfc20684f25a..15bdf6ef3c09 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1671,27 +1671,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 	}
 }
 
-/**
- * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
- * @vsi: VSI
- */
-static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
-{
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		vsi->rx_buf_len = ICE_RXBUF_1664;
-#if (PAGE_SIZE < 8192)
-	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
-		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
-#endif
-	} else {
-		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		vsi->rx_buf_len = ICE_RXBUF_3072;
-	}
-}
-
 /**
  * ice_pf_state_is_nominal - checks the PF for nominal state
  * @pf: pointer to PF to check
@@ -1795,114 +1774,6 @@ ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
 	wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
 }
 
-int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
-{
-	if (q_idx >= vsi->num_rxq)
-		return -EINVAL;
-
-	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
-}
-
-int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx)
-{
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
-
-	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
-		return -EINVAL;
-
-	qg_buf->num_txqs = 1;
-
-	return ice_vsi_cfg_txq(vsi, tx_rings[q_idx], qg_buf);
-}
-
-/**
- * ice_vsi_cfg_rxqs - Configure the VSI for Rx
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Rx VSI for operation.
- */
-int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
-{
-	u16 i;
-
-	if (vsi->type == ICE_VSI_VF)
-		goto setup_rings;
-
-	ice_vsi_cfg_frame_size(vsi);
-setup_rings:
-	/* set up individual rings */
-	ice_for_each_rxq(vsi, i) {
-		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
-
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-/**
- * ice_vsi_cfg_txqs - Configure the VSI for Tx
- * @vsi: the VSI being configured
- * @rings: Tx ring array to be configured
- * @count: number of Tx ring array elements
- *
- * Return 0 on success and a negative value on error
- * Configure the Tx VSI for operation.
- */
-static int
-ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
-{
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
-	int err = 0;
-	u16 q_idx;
-
-	qg_buf->num_txqs = 1;
-
-	for (q_idx = 0; q_idx < count; q_idx++) {
-		err = ice_vsi_cfg_txq(vsi, rings[q_idx], qg_buf);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
-/**
- * ice_vsi_cfg_lan_txqs - Configure the VSI for Tx
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Tx VSI for operation.
- */
-int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi)
-{
-	return ice_vsi_cfg_txqs(vsi, vsi->tx_rings, vsi->num_txq);
-}
-
-/**
- * ice_vsi_cfg_xdp_txqs - Configure Tx queues dedicated for XDP in given VSI
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Tx queues dedicated for XDP in given VSI for operation.
- */
-int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi)
-{
-	int ret;
-	int i;
-
-	ret = ice_vsi_cfg_txqs(vsi, vsi->xdp_rings, vsi->num_xdp_txq);
-	if (ret)
-		return ret;
-
-	ice_for_each_rxq(vsi, i)
-		ice_tx_xsk_pool(vsi, i);
-
-	return 0;
-}
-
 /**
  * ice_intrl_usec_to_reg - convert interrupt rate limit to register value
  * @intrl: interrupt rate limit in usecs
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index bfcfc582a4c0..b5a1ed7cc4b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -54,14 +54,6 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf);
 
 void ice_update_eth_stats(struct ice_vsi *vsi);
 
-int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
-
-int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx);
-
-int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
-
-int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi);
-
 void ice_vsi_cfg_msix(struct ice_vsi *vsi);
 
 int ice_vsi_start_all_rx_rings(struct ice_vsi *vsi);
@@ -72,8 +64,6 @@ int
 ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 			  u16 rel_vmvf_num);
 
-int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi);
-
 int ice_vsi_stop_xdp_tx_rings(struct ice_vsi *vsi);
 
 void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index d174a4eeb899..a1525992d14b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -237,7 +237,7 @@ static int
 ice_sched_remove_elems(struct ice_hw *hw, struct ice_sched_node *parent,
 		       u32 node_teid)
 {
-	DEFINE_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
 	u16 buf_size = __struct_size(buf);
 	u16 num_groups_removed = 0;
 	int status;
@@ -2219,7 +2219,7 @@ int
 ice_sched_move_nodes(struct ice_port_info *pi, struct ice_sched_node *parent,
 		     u16 num_items, u32 *list)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	u16 buf_len = __struct_size(buf);
 	struct ice_sched_node *node;
 	u16 i, grps_movd = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index ba0ef91e4c19..b4ea935e8300 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1812,7 +1812,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 			   enum ice_sw_lkup_type lkup_type,
 			   enum ice_adminq_opc opc)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	struct ice_aqc_res_elem *vsi_ele;
 	int status;
@@ -2081,7 +2081,7 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 *r_assoc,
  */
 int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	int status;
 
@@ -4420,7 +4420,7 @@ int
 ice_alloc_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		   u16 *counter_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	int status;
 
@@ -4448,7 +4448,7 @@ int
 ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		  u16 counter_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	int status;
 
@@ -4478,7 +4478,7 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
  */
 int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	u16 res_type;
 	int status;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 2eecd0f39aa6..1857220d27fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -218,42 +218,28 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
  */
 static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
-	u16 size = __struct_size(qg_buf);
 	struct ice_q_vector *q_vector;
-	struct ice_tx_ring *tx_ring;
-	struct ice_rx_ring *rx_ring;
 	int err;
 
-	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
-		return -EINVAL;
-
-	qg_buf->num_txqs = 1;
-
-	tx_ring = vsi->tx_rings[q_idx];
-	rx_ring = vsi->rx_rings[q_idx];
-	q_vector = rx_ring->q_vector;
-
-	err = ice_vsi_cfg_txq(vsi, tx_ring, qg_buf);
+	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
 	if (err)
 		return err;
 
 	if (ice_is_xdp_ena_vsi(vsi)) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
-		memset(qg_buf, 0, size);
-		qg_buf->num_txqs = 1;
-		err = ice_vsi_cfg_txq(vsi, xdp_ring, qg_buf);
+		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
 		if (err)
 			return err;
 		ice_set_ring_xdp(xdp_ring);
 		ice_tx_xsk_pool(vsi, q_idx);
 	}
 
-	err = ice_vsi_cfg_rxq(rx_ring);
+	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
 	if (err)
 		return err;
 
+	q_vector = vsi->rx_rings[q_idx]->q_vector;
 	ice_qvec_cfg_msix(vsi, q_vector);
 
 	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 986d429d1175..6972d728431c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -376,7 +376,8 @@ static int idpf_set_ringparam(struct net_device *netdev,
 			    new_tx_count);
 
 	if (new_tx_count == vport->txq_desc_count &&
-	    new_rx_count == vport->rxq_desc_count)
+	    new_rx_count == vport->rxq_desc_count &&
+	    kring->tcp_data_split == idpf_vport_get_hsplit(vport))
 		goto unlock_mutex;
 
 	if (!idpf_vport_set_hsplit(vport, kring->tcp_data_split)) {
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index caa13b9cedff..d7d73295f0dc 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -110,16 +110,16 @@ static const struct mtk_reg_map mt7986_reg_map = {
 	.tx_irq_mask		= 0x461c,
 	.tx_irq_status		= 0x4618,
 	.pdma = {
-		.rx_ptr		= 0x6100,
-		.rx_cnt_cfg	= 0x6104,
-		.pcrx_ptr	= 0x6108,
-		.glo_cfg	= 0x6204,
-		.rst_idx	= 0x6208,
-		.delay_irq	= 0x620c,
-		.irq_status	= 0x6220,
-		.irq_mask	= 0x6228,
-		.adma_rx_dbg0	= 0x6238,
-		.int_grp	= 0x6250,
+		.rx_ptr		= 0x4100,
+		.rx_cnt_cfg	= 0x4104,
+		.pcrx_ptr	= 0x4108,
+		.glo_cfg	= 0x4204,
+		.rst_idx	= 0x4208,
+		.delay_irq	= 0x420c,
+		.irq_status	= 0x4220,
+		.irq_mask	= 0x4228,
+		.adma_rx_dbg0	= 0x4238,
+		.int_grp	= 0x4250,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
@@ -1107,7 +1107,7 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	rxd->rxd1 = READ_ONCE(dma_rxd->rxd1);
 	rxd->rxd3 = READ_ONCE(dma_rxd->rxd3);
 	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
 		rxd->rxd5 = READ_ONCE(dma_rxd->rxd5);
 		rxd->rxd6 = READ_ONCE(dma_rxd->rxd6);
 	}
@@ -1139,7 +1139,7 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 		eth->scratch_ring = eth->sram_base;
 	else
 		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
-						       cnt * soc->txrx.txd_size,
+						       cnt * soc->tx.desc_size,
 						       &eth->phy_scratch_ring,
 						       GFP_KERNEL);
 	if (unlikely(!eth->scratch_ring))
@@ -1155,17 +1155,17 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
 		return -ENOMEM;
 
-	phy_ring_tail = eth->phy_scratch_ring + soc->txrx.txd_size * (cnt - 1);
+	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
 
 	for (i = 0; i < cnt; i++) {
 		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
 		struct mtk_tx_dma_v2 *txd;
 
-		txd = eth->scratch_ring + i * soc->txrx.txd_size;
+		txd = eth->scratch_ring + i * soc->tx.desc_size;
 		txd->txd1 = addr;
 		if (i < cnt - 1)
 			txd->txd2 = eth->phy_scratch_ring +
-				    (i + 1) * soc->txrx.txd_size;
+				    (i + 1) * soc->tx.desc_size;
 
 		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
 		if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
@@ -1416,7 +1416,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	if (itxd == ring->last_free)
 		return -ENOMEM;
 
-	itx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->txrx.txd_size);
+	itx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_size);
 	memset(itx_buf, 0, sizeof(*itx_buf));
 
 	txd_info.addr = dma_map_single(eth->dma_dev, skb->data, txd_info.size,
@@ -1457,7 +1457,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 
 			memset(&txd_info, 0, sizeof(struct mtk_tx_dma_desc_info));
 			txd_info.size = min_t(unsigned int, frag_size,
-					      soc->txrx.dma_max_len);
+					      soc->tx.dma_max_len);
 			txd_info.qid = queue;
 			txd_info.last = i == skb_shinfo(skb)->nr_frags - 1 &&
 					!(frag_size - txd_info.size);
@@ -1470,7 +1470,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 			mtk_tx_set_dma_desc(dev, txd, &txd_info);
 
 			tx_buf = mtk_desc_to_tx_buf(ring, txd,
-						    soc->txrx.txd_size);
+						    soc->tx.desc_size);
 			if (new_desc)
 				memset(tx_buf, 0, sizeof(*tx_buf));
 			tx_buf->data = (void *)MTK_DMA_DUMMY_DESC;
@@ -1513,7 +1513,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		int next_idx;
 
-		next_idx = NEXT_DESP_IDX(txd_to_idx(ring, txd, soc->txrx.txd_size),
+		next_idx = NEXT_DESP_IDX(txd_to_idx(ring, txd, soc->tx.desc_size),
 					 ring->dma_size);
 		mtk_w32(eth, next_idx, MT7628_TX_CTX_IDX0);
 	}
@@ -1522,7 +1522,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 
 err_dma:
 	do {
-		tx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->txrx.txd_size);
+		tx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_size);
 
 		/* unmap dma */
 		mtk_tx_unmap(eth, tx_buf, NULL, false);
@@ -1547,7 +1547,7 @@ static int mtk_cal_txd_req(struct mtk_eth *eth, struct sk_buff *skb)
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			frag = &skb_shinfo(skb)->frags[i];
 			nfrags += DIV_ROUND_UP(skb_frag_size(frag),
-					       eth->soc->txrx.dma_max_len);
+					       eth->soc->tx.dma_max_len);
 		}
 	} else {
 		nfrags += skb_shinfo(skb)->nr_frags;
@@ -1654,7 +1654,7 @@ static struct mtk_rx_ring *mtk_get_rx_ring(struct mtk_eth *eth)
 
 		ring = &eth->rx_ring[i];
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
-		rxd = ring->dma + idx * eth->soc->txrx.rxd_size;
+		rxd = ring->dma + idx * eth->soc->rx.desc_size;
 		if (rxd->rxd2 & RX_DMA_DONE) {
 			ring->calc_idx_update = true;
 			return ring;
@@ -1822,7 +1822,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 	}
 	htxd = txd;
 
-	tx_buf = mtk_desc_to_tx_buf(ring, txd, soc->txrx.txd_size);
+	tx_buf = mtk_desc_to_tx_buf(ring, txd, soc->tx.desc_size);
 	memset(tx_buf, 0, sizeof(*tx_buf));
 	htx_buf = tx_buf;
 
@@ -1841,7 +1841,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 				goto unmap;
 
 			tx_buf = mtk_desc_to_tx_buf(ring, txd,
-						    soc->txrx.txd_size);
+						    soc->tx.desc_size);
 			memset(tx_buf, 0, sizeof(*tx_buf));
 			n_desc++;
 		}
@@ -1879,7 +1879,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 	} else {
 		int idx;
 
-		idx = txd_to_idx(ring, txd, soc->txrx.txd_size);
+		idx = txd_to_idx(ring, txd, soc->tx.desc_size);
 		mtk_w32(eth, NEXT_DESP_IDX(idx, ring->dma_size),
 			MT7628_TX_CTX_IDX0);
 	}
@@ -1890,7 +1890,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 
 unmap:
 	while (htxd != txd) {
-		tx_buf = mtk_desc_to_tx_buf(ring, htxd, soc->txrx.txd_size);
+		tx_buf = mtk_desc_to_tx_buf(ring, htxd, soc->tx.desc_size);
 		mtk_tx_unmap(eth, tx_buf, NULL, false);
 
 		htxd->txd3 = TX_DMA_LS0 | TX_DMA_OWNER_CPU;
@@ -2021,14 +2021,14 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			goto rx_done;
 
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
-		rxd = ring->dma + idx * eth->soc->txrx.rxd_size;
+		rxd = ring->dma + idx * eth->soc->rx.desc_size;
 		data = ring->data[idx];
 
 		if (!mtk_rx_get_desc(eth, &trxd, rxd))
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			u32 val = RX_DMA_GET_SPORT_V2(trxd.rxd5);
 
 			switch (val) {
@@ -2140,7 +2140,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		skb->dev = netdev;
 		bytes += skb->len;
 
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			reason = FIELD_GET(MTK_RXD5_PPE_CPU_REASON, trxd.rxd5);
 			hash = trxd.rxd5 & MTK_RXD5_FOE_ENTRY;
 			if (hash != MTK_RXD5_FOE_ENTRY)
@@ -2156,7 +2156,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			rxdcsum = &trxd.rxd4;
 		}
 
-		if (*rxdcsum & eth->soc->txrx.rx_dma_l4_valid)
+		if (*rxdcsum & eth->soc->rx.dma_l4_valid)
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		else
 			skb_checksum_none_assert(skb);
@@ -2280,7 +2280,7 @@ static int mtk_poll_tx_qdma(struct mtk_eth *eth, int budget,
 			break;
 
 		tx_buf = mtk_desc_to_tx_buf(ring, desc,
-					    eth->soc->txrx.txd_size);
+					    eth->soc->tx.desc_size);
 		if (!tx_buf->data)
 			break;
 
@@ -2331,7 +2331,7 @@ static int mtk_poll_tx_pdma(struct mtk_eth *eth, int budget,
 		}
 		mtk_tx_unmap(eth, tx_buf, &bq, true);
 
-		desc = ring->dma + cpu * eth->soc->txrx.txd_size;
+		desc = ring->dma + cpu * eth->soc->tx.desc_size;
 		ring->last_free = desc;
 		atomic_inc(&ring->free_count);
 
@@ -2421,7 +2421,7 @@ static int mtk_napi_rx(struct napi_struct *napi, int budget)
 	do {
 		int rx_done;
 
-		mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask,
+		mtk_w32(eth, eth->soc->rx.irq_done_mask,
 			reg_map->pdma.irq_status);
 		rx_done = mtk_poll_rx(napi, budget - rx_done_total, eth);
 		rx_done_total += rx_done;
@@ -2437,10 +2437,10 @@ static int mtk_napi_rx(struct napi_struct *napi, int budget)
 			return budget;
 
 	} while (mtk_r32(eth, reg_map->pdma.irq_status) &
-		 eth->soc->txrx.rx_irq_done_mask);
+		 eth->soc->rx.irq_done_mask);
 
 	if (napi_complete_done(napi, rx_done_total))
-		mtk_rx_irq_enable(eth, eth->soc->txrx.rx_irq_done_mask);
+		mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 
 	return rx_done_total;
 }
@@ -2449,7 +2449,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
 	struct mtk_tx_ring *ring = &eth->tx_ring;
-	int i, sz = soc->txrx.txd_size;
+	int i, sz = soc->tx.desc_size;
 	struct mtk_tx_dma_v2 *txd;
 	int ring_size;
 	u32 ofs, val;
@@ -2572,14 +2572,14 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 	}
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->txrx.txd_size,
+				  ring->dma_size * soc->tx.desc_size,
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
 
 	if (ring->dma_pdma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->txrx.txd_size,
+				  ring->dma_size * soc->tx.desc_size,
 				  ring->dma_pdma, ring->phys_pdma);
 		ring->dma_pdma = NULL;
 	}
@@ -2634,15 +2634,15 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM) ||
 	    rx_flag != MTK_RX_FLAGS_NORMAL) {
 		ring->dma = dma_alloc_coherent(eth->dma_dev,
-					       rx_dma_size * eth->soc->txrx.rxd_size,
-					       &ring->phys, GFP_KERNEL);
+				rx_dma_size * eth->soc->rx.desc_size,
+				&ring->phys, GFP_KERNEL);
 	} else {
 		struct mtk_tx_ring *tx_ring = &eth->tx_ring;
 
 		ring->dma = tx_ring->dma + tx_ring_size *
-			    eth->soc->txrx.txd_size * (ring_no + 1);
+			    eth->soc->tx.desc_size * (ring_no + 1);
 		ring->phys = tx_ring->phys + tx_ring_size *
-			     eth->soc->txrx.txd_size * (ring_no + 1);
+			     eth->soc->tx.desc_size * (ring_no + 1);
 	}
 
 	if (!ring->dma)
@@ -2653,7 +2653,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		dma_addr_t dma_addr;
 		void *data;
 
-		rxd = ring->dma + i * eth->soc->txrx.rxd_size;
+		rxd = ring->dma + i * eth->soc->rx.desc_size;
 		if (ring->page_pool) {
 			data = mtk_page_pool_get_buff(ring->page_pool,
 						      &dma_addr, GFP_KERNEL);
@@ -2690,7 +2690,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 		rxd->rxd3 = 0;
 		rxd->rxd4 = 0;
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			rxd->rxd5 = 0;
 			rxd->rxd6 = 0;
 			rxd->rxd7 = 0;
@@ -2744,7 +2744,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 			if (!ring->data[i])
 				continue;
 
-			rxd = ring->dma + i * eth->soc->txrx.rxd_size;
+			rxd = ring->dma + i * eth->soc->rx.desc_size;
 			if (!rxd->rxd1)
 				continue;
 
@@ -2761,7 +2761,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 
 	if (!in_sram && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * eth->soc->txrx.rxd_size,
+				  ring->dma_size * eth->soc->rx.desc_size,
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
@@ -3124,7 +3124,7 @@ static void mtk_dma_free(struct mtk_eth *eth)
 			netdev_reset_queue(eth->netdev[i]);
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
 		dma_free_coherent(eth->dma_dev,
-				  MTK_QDMA_RING_SIZE * soc->txrx.txd_size,
+				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
 				  eth->scratch_ring, eth->phy_scratch_ring);
 		eth->scratch_ring = NULL;
 		eth->phy_scratch_ring = 0;
@@ -3174,7 +3174,7 @@ static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
 
 	eth->rx_events++;
 	if (likely(napi_schedule_prep(&eth->rx_napi))) {
-		mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+		mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
 		__napi_schedule(&eth->rx_napi);
 	}
 
@@ -3200,9 +3200,9 @@ static irqreturn_t mtk_handle_irq(int irq, void *_eth)
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
 
 	if (mtk_r32(eth, reg_map->pdma.irq_mask) &
-	    eth->soc->txrx.rx_irq_done_mask) {
+	    eth->soc->rx.irq_done_mask) {
 		if (mtk_r32(eth, reg_map->pdma.irq_status) &
-		    eth->soc->txrx.rx_irq_done_mask)
+		    eth->soc->rx.irq_done_mask)
 			mtk_handle_irq_rx(irq, _eth);
 	}
 	if (mtk_r32(eth, reg_map->tx_irq_mask) & MTK_TX_DONE_INT) {
@@ -3220,10 +3220,10 @@ static void mtk_poll_controller(struct net_device *dev)
 	struct mtk_eth *eth = mac->hw;
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
-	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
 	mtk_handle_irq_rx(eth->irq[2], dev);
 	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
-	mtk_rx_irq_enable(eth, eth->soc->txrx.rx_irq_done_mask);
+	mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 }
 #endif
 
@@ -3387,7 +3387,7 @@ static int mtk_open(struct net_device *dev)
 		napi_enable(&eth->tx_napi);
 		napi_enable(&eth->rx_napi);
 		mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
-		mtk_rx_irq_enable(eth, soc->txrx.rx_irq_done_mask);
+		mtk_rx_irq_enable(eth, soc->rx.irq_done_mask);
 		refcount_set(&eth->dma_refcnt, 1);
 	}
 	else
@@ -3471,7 +3471,7 @@ static int mtk_stop(struct net_device *dev)
 	mtk_gdm_config(eth, MTK_GDMA_DROP_ALL);
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
-	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
 	napi_disable(&eth->tx_napi);
 	napi_disable(&eth->rx_napi);
 
@@ -3893,7 +3893,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
 		mtk_w32(eth,  val | BIT(4), MTK_FE_GLO_MISC);
@@ -3947,9 +3947,9 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 
 	/* FE int grouping */
 	mtk_w32(eth, MTK_TX_DONE_INT, reg_map->pdma.int_grp);
-	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->pdma.int_grp + 4);
+	mtk_w32(eth, eth->soc->rx.irq_done_mask, reg_map->pdma.int_grp + 4);
 	mtk_w32(eth, MTK_TX_DONE_INT, reg_map->qdma.int_grp);
-	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->qdma.int_grp + 4);
+	mtk_w32(eth, eth->soc->rx.irq_done_mask, reg_map->qdma.int_grp + 4);
 	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
 
 	if (mtk_is_netsys_v3_or_greater(eth)) {
@@ -5039,11 +5039,15 @@ static const struct mtk_soc_data mt2701_data = {
 	.required_clks = MT7623_CLKS_BITMAP,
 	.required_pctl = true,
 	.version = 1,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5059,11 +5063,15 @@ static const struct mtk_soc_data mt7621_data = {
 	.offload_version = 1,
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5081,11 +5089,15 @@ static const struct mtk_soc_data mt7622_data = {
 	.hash_offset = 2,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5102,11 +5114,15 @@ static const struct mtk_soc_data mt7623_data = {
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.disable_pll_modes = true,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5121,11 +5137,15 @@ static const struct mtk_soc_data mt7629_data = {
 	.required_pctl = false,
 	.has_accounting = true,
 	.version = 1,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5143,14 +5163,18 @@ static const struct mtk_soc_data mt7981_data = {
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma_v2),
-		.rxd_size = sizeof(struct mtk_rx_dma_v2),
-		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID_V2,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
 };
 
 static const struct mtk_soc_data mt7986_data = {
@@ -5165,14 +5189,18 @@ static const struct mtk_soc_data mt7986_data = {
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma_v2),
-		.rxd_size = sizeof(struct mtk_rx_dma_v2),
-		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID_V2,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
 };
 
 static const struct mtk_soc_data mt7988_data = {
@@ -5187,11 +5215,15 @@ static const struct mtk_soc_data mt7988_data = {
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma_v2),
-		.rxd_size = sizeof(struct mtk_rx_dma_v2),
-		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
+		.dma_len_offset = 8,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma_v2),
+		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 	},
@@ -5204,11 +5236,15 @@ static const struct mtk_soc_data rt5350_data = {
 	.required_clks = MT7628_CLKS_BITMAP,
 	.required_pctl = false,
 	.version = 1,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_PDMA,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID_PDMA,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9ae3b8a71d0e..39b50de1decb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -327,8 +327,8 @@
 /* QDMA descriptor txd3 */
 #define TX_DMA_OWNER_CPU	BIT(31)
 #define TX_DMA_LS0		BIT(30)
-#define TX_DMA_PLEN0(x)		(((x) & eth->soc->txrx.dma_max_len) << eth->soc->txrx.dma_len_offset)
-#define TX_DMA_PLEN1(x)		((x) & eth->soc->txrx.dma_max_len)
+#define TX_DMA_PLEN0(x)		(((x) & eth->soc->tx.dma_max_len) << eth->soc->tx.dma_len_offset)
+#define TX_DMA_PLEN1(x)		((x) & eth->soc->tx.dma_max_len)
 #define TX_DMA_SWC		BIT(14)
 #define TX_DMA_PQID		GENMASK(3, 0)
 #define TX_DMA_ADDR64_MASK	GENMASK(3, 0)
@@ -348,8 +348,8 @@
 /* QDMA descriptor rxd2 */
 #define RX_DMA_DONE		BIT(31)
 #define RX_DMA_LSO		BIT(30)
-#define RX_DMA_PREP_PLEN0(x)	(((x) & eth->soc->txrx.dma_max_len) << eth->soc->txrx.dma_len_offset)
-#define RX_DMA_GET_PLEN0(x)	(((x) >> eth->soc->txrx.dma_len_offset) & eth->soc->txrx.dma_max_len)
+#define RX_DMA_PREP_PLEN0(x)	(((x) & eth->soc->rx.dma_max_len) << eth->soc->rx.dma_len_offset)
+#define RX_DMA_GET_PLEN0(x)	(((x) >> eth->soc->rx.dma_len_offset) & eth->soc->rx.dma_max_len)
 #define RX_DMA_VTAG		BIT(15)
 #define RX_DMA_ADDR64_MASK	GENMASK(3, 0)
 #if IS_ENABLED(CONFIG_64BIT)
@@ -1153,10 +1153,9 @@ struct mtk_reg_map {
  * @foe_entry_size		Foe table entry size.
  * @has_accounting		Bool indicating support for accounting of
  *				offloaded flows.
- * @txd_size			Tx DMA descriptor size.
- * @rxd_size			Rx DMA descriptor size.
- * @rx_irq_done_mask		Rx irq done register mask.
- * @rx_dma_l4_valid		Rx DMA valid register mask.
+ * @desc_size			Tx/Rx DMA descriptor size.
+ * @irq_done_mask		Rx irq done register mask.
+ * @dma_l4_valid		Rx DMA valid register mask.
  * @dma_max_len			Max DMA tx/rx buffer length.
  * @dma_len_offset		Tx/Rx DMA length field offset.
  */
@@ -1174,13 +1173,17 @@ struct mtk_soc_data {
 	bool		has_accounting;
 	bool		disable_pll_modes;
 	struct {
-		u32	txd_size;
-		u32	rxd_size;
-		u32	rx_irq_done_mask;
-		u32	rx_dma_l4_valid;
+		u32	desc_size;
 		u32	dma_max_len;
 		u32	dma_len_offset;
-	} txrx;
+	} tx;
+	struct {
+		u32	desc_size;
+		u32	irq_done_mask;
+		u32	dma_l4_valid;
+		u32	dma_max_len;
+		u32	dma_len_offset;
+	} rx;
 };
 
 #define MTK_DMA_MONITOR_TIMEOUT		msecs_to_jiffies(1000)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 4957412ff1f6..20768ef2e9d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -969,19 +969,32 @@ static void cmd_work_handler(struct work_struct *work)
 	bool poll_cmd = ent->polling;
 	struct mlx5_cmd_layout *lay;
 	struct mlx5_core_dev *dev;
-	unsigned long cb_timeout;
-	struct semaphore *sem;
+	unsigned long timeout;
 	unsigned long flags;
 	int alloc_ret;
 	int cmd_mode;
 
+	complete(&ent->handling);
+
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
-	cb_timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
+	timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
 
-	complete(&ent->handling);
-	sem = ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem;
-	down(sem);
 	if (!ent->page_queue) {
+		if (down_timeout(&cmd->vars.sem, timeout)) {
+			mlx5_core_warn(dev, "%s(0x%x) timed out while waiting for a slot.\n",
+				       mlx5_command_str(ent->op), ent->op);
+			if (ent->callback) {
+				ent->callback(-EBUSY, ent->context);
+				mlx5_free_cmd_msg(dev, ent->out);
+				free_msg(dev, ent->in);
+				cmd_ent_put(ent);
+			} else {
+				ent->ret = -EBUSY;
+				complete(&ent->done);
+			}
+			complete(&ent->slotted);
+			return;
+		}
 		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
@@ -994,10 +1007,11 @@ static void cmd_work_handler(struct work_struct *work)
 				ent->ret = -EAGAIN;
 				complete(&ent->done);
 			}
-			up(sem);
+			up(&cmd->vars.sem);
 			return;
 		}
 	} else {
+		down(&cmd->vars.pages_sem);
 		ent->idx = cmd->vars.max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->vars.bitmask);
@@ -1005,6 +1019,8 @@ static void cmd_work_handler(struct work_struct *work)
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
+	complete(&ent->slotted);
+
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
@@ -1023,7 +1039,7 @@ static void cmd_work_handler(struct work_struct *work)
 	ent->ts1 = ktime_get_ns();
 	cmd_mode = cmd->mode;
 
-	if (ent->callback && schedule_delayed_work(&ent->cb_timeout_work, cb_timeout))
+	if (ent->callback && schedule_delayed_work(&ent->cb_timeout_work, timeout))
 		cmd_ent_get(ent);
 	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 
@@ -1143,6 +1159,9 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 		ent->ret = -ECANCELED;
 		goto out_err;
 	}
+
+	wait_for_completion(&ent->slotted);
+
 	if (cmd->mode == CMD_MODE_POLLING || ent->polling)
 		wait_for_completion(&ent->done);
 	else if (!wait_for_completion_timeout(&ent->done, timeout))
@@ -1157,6 +1176,9 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 	} else if (err == -ECANCELED) {
 		mlx5_core_warn(dev, "%s(0x%x) canceled on out of queue timeout.\n",
 			       mlx5_command_str(ent->op), ent->op);
+	} else if (err == -EBUSY) {
+		mlx5_core_warn(dev, "%s(0x%x) timeout while waiting for command semaphore.\n",
+			       mlx5_command_str(ent->op), ent->op);
 	}
 	mlx5_core_dbg(dev, "err %d, delivery status %s(%d)\n",
 		      err, deliv_status_to_str(ent->status), ent->status);
@@ -1208,6 +1230,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 	ent->polling = force_polling;
 
 	init_completion(&ent->handling);
+	init_completion(&ent->slotted);
 	if (!callback)
 		init_completion(&ent->done);
 
@@ -1225,7 +1248,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 		return 0; /* mlx5_cmd_comp_handler() will put(ent) */
 
 	err = wait_func(dev, ent);
-	if (err == -ETIMEDOUT || err == -ECANCELED)
+	if (err == -ETIMEDOUT || err == -ECANCELED || err == -EBUSY)
 		goto out_free;
 
 	ds = ent->ts2 - ent->ts1;
@@ -1611,6 +1634,9 @@ static int cmd_comp_notifier(struct notifier_block *nb,
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	eqe = data;
 
+	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return NOTIFY_DONE;
+
 	mlx5_cmd_comp_handler(dev, be32_to_cpu(eqe->data.cmd.vector), false);
 
 	return NOTIFY_OK;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 82e6abbc1734..c969b8e70980 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -28,8 +28,10 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5e_xsk_param *xsk,
 			      struct mlx5_core_dev *mdev)
 {
-	/* AF_XDP doesn't support frames larger than PAGE_SIZE. */
-	if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
+	/* AF_XDP doesn't support frames larger than PAGE_SIZE,
+	 * and xsk->chunk_size is limited to 65535 bytes.
+	 */
+	if ((size_t)xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
 		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
 			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 1b9bc32efd6f..c5ea1d1d2b03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1874,7 +1874,7 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 				 "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
 				 addr, vid, vport_num);
 			NL_SET_ERR_MSG_FMT_MOD(extack,
-					       "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
+					       "Failed to lookup vlan metadata for MDB (MAC=%pM,vid=%u,vport=%u)\n",
 					       addr, vid, vport_num);
 			return -EINVAL;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..ef55674876cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -833,7 +833,7 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 					     struct mlx5_eswitch *slave_esw, int max_slaves);
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
@@ -925,7 +925,7 @@ mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
 
 static inline int
-mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e3cce110e52f..58529d1a98b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2501,6 +2501,16 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 	esw_offloads_cleanup_reps(esw);
 }
 
+static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
+				   struct mlx5_eswitch_rep *rep, u8 rep_type)
+{
+	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
+			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
+		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
+
+	return 0;
+}
+
 static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
@@ -2525,13 +2535,11 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 	int err;
 
 	rep = mlx5_eswitch_get_rep(esw, vport_num);
-	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++)
-		if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
-				   REP_REGISTERED, REP_LOADED) == REP_REGISTERED) {
-			err = esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
-			if (err)
-				goto err_reps;
-		}
+	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
+		err = __esw_offloads_load_rep(esw, rep, rep_type);
+		if (err)
+			goto err_reps;
+	}
 
 	return 0;
 
@@ -3276,7 +3284,7 @@ static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
@@ -3289,13 +3297,13 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
 	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 		return 0;
 
-	ret = mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK);
+	ret = __esw_offloads_load_rep(esw, rep, REP_IB);
 	if (ret)
 		return ret;
 
 	mlx5_esw_for_each_rep(esw, i, rep) {
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
-			mlx5_esw_offloads_rep_load(esw, rep->vport);
+			__esw_offloads_load_rep(esw, rep, REP_IB);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 69d482f7c5a2..37598d116f3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -814,7 +814,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (shared_fdb)
 		for (i = 0; i < ldev->ports; i++)
 			if (!(ldev->pf[i].dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-				mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 }
 
 static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -922,7 +922,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			mlx5_rescan_drivers_locked(dev0);
 
 			for (i = 0; i < ldev->ports; i++) {
-				err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				if (err)
 					break;
 			}
@@ -933,7 +933,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
 				for (i = 0; i < ldev->ports; i++)
-					mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 82889f30506e..571ea26edd0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -99,7 +99,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
 	for (i = 0; i < ldev->ports; i++) {
-		err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 		if (err)
 			goto err_rescan_drivers;
 	}
@@ -113,7 +113,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
 	for (i = 0; i < ldev->ports; i++)
-		mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index e285823bd08f..0288e19e3a68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1680,6 +1680,8 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	struct devlink *devlink = priv_to_devlink(dev);
 	int err;
 
+	devl_lock(devlink);
+	devl_register(devlink);
 	dev->state = MLX5_DEVICE_STATE_UP;
 	err = mlx5_function_enable(dev, true, mlx5_tout_ms(dev, FW_PRE_INIT_TIMEOUT));
 	if (err) {
@@ -1693,27 +1695,21 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 		goto query_hca_caps_err;
 	}
 
-	devl_lock(devlink);
-	devl_register(devlink);
-
 	err = mlx5_devlink_params_register(priv_to_devlink(dev));
 	if (err) {
 		mlx5_core_warn(dev, "mlx5_devlink_param_reg err = %d\n", err);
-		goto params_reg_err;
+		goto query_hca_caps_err;
 	}
 
 	devl_unlock(devlink);
 	return 0;
 
-params_reg_err:
-	devl_unregister(devlink);
-	devl_unlock(devlink);
 query_hca_caps_err:
-	devl_unregister(devlink);
-	devl_unlock(devlink);
 	mlx5_function_disable(dev, true);
 out:
 	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
+	devl_unregister(devlink);
+	devl_unlock(devlink);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 7ebe71280827..b2986175d9af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -60,6 +60,13 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto remap_err;
 	}
 
+	/* Peer devlink logic expects to work on unregistered devlink instance. */
+	err = mlx5_core_peer_devlink_set(sf_dev, devlink);
+	if (err) {
+		mlx5_core_warn(mdev, "mlx5_core_peer_devlink_set err=%d\n", err);
+		goto peer_devlink_set_err;
+	}
+
 	if (MLX5_ESWITCH_MANAGER(sf_dev->parent_mdev))
 		err = mlx5_init_one_light(mdev);
 	else
@@ -69,20 +76,10 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto init_one_err;
 	}
 
-	err = mlx5_core_peer_devlink_set(sf_dev, devlink);
-	if (err) {
-		mlx5_core_warn(mdev, "mlx5_core_peer_devlink_set err=%d\n", err);
-		goto peer_devlink_set_err;
-	}
-
 	return 0;
 
-peer_devlink_set_err:
-	if (mlx5_dev_is_lightweight(sf_dev->mdev))
-		mlx5_uninit_one_light(sf_dev->mdev);
-	else
-		mlx5_uninit_one(sf_dev->mdev);
 init_one_err:
+peer_devlink_set_err:
 	iounmap(mdev->iseg);
 remap_err:
 	mlx5_mdev_uninit(mdev);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2635ef8958c8..61d88207eed4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1087,8 +1087,6 @@ static int lan966x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
 
-	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
-
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
 	} else {
@@ -1179,6 +1177,8 @@ static int lan966x_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "no ethernet-ports child found\n");
 
+	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
+
 	/* init switch */
 	lan966x_init(lan966x);
 	lan966x_stats_init(lan966x);
@@ -1257,6 +1257,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	destroy_workqueue(lan966x->stats_queue);
 	mutex_destroy(&lan966x->stats_lock);
 
+	debugfs_remove_recursive(lan966x->debugfs_root);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 2729a2c5acf9..ca814fe8a775 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -848,7 +848,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	}
 
 	if (!wait_for_completion_timeout(&ctx->comp_event,
-					 (msecs_to_jiffies(hwc->hwc_timeout) * HZ))) {
+					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
 		dev_err(hwc->dev, "HWC: Request timed out!\n");
 		err = -ETIMEDOUT;
 		goto out;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..8159b4c315b5 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1206,7 +1206,6 @@ static void qed_slowpath_task(struct work_struct *work)
 static int qed_slowpath_wq_start(struct qed_dev *cdev)
 {
 	struct qed_hwfn *hwfn;
-	char name[NAME_SIZE];
 	int i;
 
 	if (IS_VF(cdev))
@@ -1215,11 +1214,11 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
 	for_each_hwfn(cdev, i) {
 		hwfn = &cdev->hwfns[i];
 
-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
-			 cdev->pdev->bus->number,
-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
+		hwfn->slowpath_wq = alloc_workqueue("slowpath-%02x:%02x.%02x",
+					 0, 0, cdev->pdev->bus->number,
+					 PCI_SLOT(cdev->pdev->devfn),
+					 hwfn->abs_pf_id);
 
-		hwfn->slowpath_wq = alloc_workqueue(name, 0, 0);
 		if (!hwfn->slowpath_wq) {
 			DP_NOTICE(hwfn, "Cannot create slowpath workqueue\n");
 			return -ENOMEM;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 32b73f3988e8..70d0b32395cd 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4221,11 +4221,11 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
+	unsigned int frags;
 	u32 opts[2];
 
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
@@ -4248,6 +4248,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 
 	txd_first = tp->TxDescArray + entry;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;
@@ -4541,10 +4542,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
 
-	if (napi_schedule_prep(&tp->napi)) {
-		rtl_irq_disable(tp);
-		__napi_schedule(&tp->napi);
-	}
+	rtl_irq_disable(tp);
+	napi_schedule(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 46eee747c699..45ef5ac0788a 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -156,8 +156,8 @@ static inline void mcf_outsw(void *a, unsigned char *p, int l)
 		writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		_swapw(readw((a) + (r)))
-#define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
+#define SMC_inw(a, r)		ioread16be((a) + (r))
+#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 5a1d46dcd5de..618d455b457c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -225,6 +225,8 @@ struct stmmac_extra_stats {
 	unsigned long mtl_est_hlbf;
 	unsigned long mtl_est_btre;
 	unsigned long mtl_est_btrlm;
+	unsigned long max_sdu_txq_drop[MTL_MAX_TX_QUEUES];
+	unsigned long mtl_est_txq_hlbf[MTL_MAX_TX_QUEUES];
 	/* per queue statistics */
 	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
 	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f155e4841c62..1db1359d154f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -260,6 +260,8 @@ struct stmmac_priv {
 	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
 	struct stmmac_safety_stats sstats;
 	struct plat_stmmacenet_data *plat;
+	/* Protect est parameters */
+	struct mutex est_lock;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index 4da6ccc17c20..c9693f77e1f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -81,6 +81,7 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 	u32 status, value, feqn, hbfq, hbfs, btrl, btrl_max;
 	void __iomem *est_addr = priv->estaddr;
 	u32 txqcnt_mask = BIT(txqcnt) - 1;
+	int i;
 
 	status = readl(est_addr + EST_STATUS);
 
@@ -125,6 +126,11 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 
 		x->mtl_est_hlbf++;
 
+		for (i = 0; i < txqcnt; i++) {
+			if (feqn & BIT(i))
+				x->mtl_est_txq_hlbf[i]++;
+		}
+
 		/* Clear Interrupt */
 		writel(feqn, est_addr + EST_FRM_SZ_ERR);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 83b732c30c1b..12f4c0da838d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2491,6 +2491,13 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
+		if (priv->plat->est && priv->plat->est->enable &&
+		    priv->plat->est->max_sdu[queue] &&
+		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
+			priv->xstats.max_sdu_txq_drop[queue]++;
+			continue;
+		}
+
 		if (likely(priv->extend_desc))
 			tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
 		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
@@ -4485,6 +4492,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			return stmmac_tso_xmit(skb, dev);
 	}
 
+	if (priv->plat->est && priv->plat->est->enable &&
+	    priv->plat->est->max_sdu[queue] &&
+	    skb->len > priv->plat->est->max_sdu[queue]){
+		priv->xstats.max_sdu_txq_drop[queue]++;
+		goto max_sdu_err;
+	}
+
 	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
@@ -4702,6 +4716,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 dma_map_err:
 	netdev_err(priv->dev, "Tx DMA map failed\n");
+max_sdu_err:
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;
 	return NETDEV_TX_OK;
@@ -4858,6 +4873,13 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
+	if (priv->plat->est && priv->plat->est->enable &&
+	    priv->plat->est->max_sdu[queue] &&
+	    xdpf->len > priv->plat->est->max_sdu[queue]) {
+		priv->xstats.max_sdu_txq_drop[queue]++;
+		return STMMAC_XDP_CONSUMED;
+	}
+
 	if (likely(priv->extend_desc))
 		tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
 	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index e04830a3a1fb..0c5aab6dd7a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -70,11 +70,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	/* If EST is enabled, disabled it before adjust ptp time. */
 	if (priv->plat->est && priv->plat->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
@@ -87,7 +87,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		ktime_t current_time_ns, basetime;
 		u64 cycle_time;
 
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->plat->est->btr_reserve[0];
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->plat->est->enable = true;
 		ret = stmmac_est_configure(priv, priv, priv->plat->est,
 					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 26fa33e5ec34..620c16e9be3a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -915,8 +915,30 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 	return time;
 }
 
-static int tc_setup_taprio(struct stmmac_priv *priv,
-			   struct tc_taprio_qopt_offload *qopt)
+static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
+				     struct tc_taprio_qopt_offload *qopt)
+{
+	struct plat_stmmacenet_data *plat = priv->plat;
+	u32 num_tc = qopt->mqprio.qopt.num_tc;
+	u32 offset, count, i, j;
+
+	/* QueueMaxSDU received from the driver corresponds to the Linux traffic
+	 * class. Map queueMaxSDU per Linux traffic class to DWMAC Tx queues.
+	 */
+	for (i = 0; i < num_tc; i++) {
+		if (!qopt->max_sdu[i])
+			continue;
+
+		offset = qopt->mqprio.qopt.offset[i];
+		count = qopt->mqprio.qopt.count[i];
+
+		for (j = offset; j < offset + count; j++)
+			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+	}
+}
+
+static int tc_taprio_configure(struct stmmac_priv *priv,
+			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct plat_stmmacenet_data *plat = priv->plat;
@@ -968,8 +990,6 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
-	else if (qopt->cmd != TAPRIO_CMD_REPLACE)
-		return -EOPNOTSUPP;
 
 	if (qopt->num_entries >= dep)
 		return -EINVAL;
@@ -984,17 +1004,19 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		if (!plat->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->est_lock);
 	} else {
+		mutex_lock(&priv->est_lock);
 		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	priv->plat->est->gcl_size = size;
 	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
@@ -1025,7 +1047,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
@@ -1045,8 +1067,10 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	priv->plat->est->ter = qopt->cycle_time_extension;
 
+	tc_taprio_map_maxsdu_txq(priv, qopt);
+
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1057,7 +1081,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1074,11 +1098,16 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 disable:
 	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		/* Reset taprio status */
+		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+			priv->xstats.max_sdu_txq_drop[i] = 0;
+			priv->xstats.mtl_est_txq_hlbf[i] = 0;
+		}
+		mutex_unlock(&priv->est_lock);
 	}
 
 	priv->plat->fpe_cfg->enable = false;
@@ -1095,6 +1124,57 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	return ret;
 }
 
+static void tc_taprio_stats(struct stmmac_priv *priv,
+			    struct tc_taprio_qopt_offload *qopt)
+{
+	u64 window_drops = 0;
+	int i = 0;
+
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
+		window_drops += priv->xstats.max_sdu_txq_drop[i] +
+				priv->xstats.mtl_est_txq_hlbf[i];
+	qopt->stats.window_drops = window_drops;
+
+	/* Transmission overrun doesn't happen for stmmac, hence always 0 */
+	qopt->stats.tx_overruns = 0;
+}
+
+static void tc_taprio_queue_stats(struct stmmac_priv *priv,
+				  struct tc_taprio_qopt_offload *qopt)
+{
+	struct tc_taprio_qopt_queue_stats *q_stats = &qopt->queue_stats;
+	int queue = qopt->queue_stats.queue;
+
+	q_stats->stats.window_drops = priv->xstats.max_sdu_txq_drop[queue] +
+				      priv->xstats.mtl_est_txq_hlbf[queue];
+
+	/* Transmission overrun doesn't happen for stmmac, hence always 0 */
+	q_stats->stats.tx_overruns = 0;
+}
+
+static int tc_setup_taprio(struct stmmac_priv *priv,
+			   struct tc_taprio_qopt_offload *qopt)
+{
+	int err = 0;
+
+	switch (qopt->cmd) {
+	case TAPRIO_CMD_REPLACE:
+	case TAPRIO_CMD_DESTROY:
+		err = tc_taprio_configure(priv, qopt);
+		break;
+	case TAPRIO_CMD_STATS:
+		tc_taprio_stats(priv, qopt);
+		break;
+	case TAPRIO_CMD_QUEUE_STATS:
+		tc_taprio_queue_stats(priv, qopt);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static int tc_setup_etf(struct stmmac_priv *priv,
 			struct tc_etf_qopt_offload *qopt)
 {
@@ -1126,6 +1206,7 @@ static int tc_query_caps(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 
 		caps->gate_mask_per_txq = true;
+		caps->supports_queue_max_sdu = true;
 
 		return 0;
 	}
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 9bd1df8308d2..d3a2fbb14140 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -949,17 +949,6 @@ static irqreturn_t gem_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void gem_poll_controller(struct net_device *dev)
-{
-	struct gem *gp = netdev_priv(dev);
-
-	disable_irq(gp->pdev->irq);
-	gem_interrupt(gp->pdev->irq, dev);
-	enable_irq(gp->pdev->irq);
-}
-#endif
-
 static void gem_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct gem *gp = netdev_priv(dev);
@@ -2839,9 +2828,6 @@ static const struct net_device_ops gem_netdev_ops = {
 	.ndo_change_mtu		= gem_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = gem_set_mac_address,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller    = gem_poll_controller,
-#endif
 };
 
 static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 4a78e8a1cabf..3fa49448a74b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2156,7 +2156,12 @@ static int prueth_probe(struct platform_device *pdev)
 
 		prueth->registered_netdevs[PRUETH_MAC0] = prueth->emac[PRUETH_MAC0]->ndev;
 
-		emac_phy_connect(prueth->emac[PRUETH_MAC0]);
+		ret = emac_phy_connect(prueth->emac[PRUETH_MAC0]);
+		if (ret) {
+			dev_err(dev,
+				"can't connect to MII0 PHY, error -%d", ret);
+			goto netdev_unregister;
+		}
 		phy_attached_info(prueth->emac[PRUETH_MAC0]->ndev->phydev);
 	}
 
@@ -2168,7 +2173,12 @@ static int prueth_probe(struct platform_device *pdev)
 		}
 
 		prueth->registered_netdevs[PRUETH_MAC1] = prueth->emac[PRUETH_MAC1]->ndev;
-		emac_phy_connect(prueth->emac[PRUETH_MAC1]);
+		ret = emac_phy_connect(prueth->emac[PRUETH_MAC1]);
+		if (ret) {
+			dev_err(dev,
+				"can't connect to MII1 PHY, error %d", ret);
+			goto netdev_unregister;
+		}
 		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
 	}
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1db754615cca..c09a6f744575 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1958,7 +1958,7 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
-	wx->msix_in_use = false;
+	bitmap_zero(wx->state, WX_STATE_NBITS);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 08d3e4069c5f..c87afe5de1dd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1614,14 +1614,12 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 	/* One for non-queue interrupts */
 	nvecs += 1;
 
-	if (!wx->msix_in_use) {
-		wx->msix_entry = kcalloc(1, sizeof(struct msix_entry),
-					 GFP_KERNEL);
-		if (!wx->msix_entry) {
-			kfree(wx->msix_q_entries);
-			wx->msix_q_entries = NULL;
-			return -ENOMEM;
-		}
+	wx->msix_entry = kcalloc(1, sizeof(struct msix_entry),
+				 GFP_KERNEL);
+	if (!wx->msix_entry) {
+		kfree(wx->msix_q_entries);
+		wx->msix_q_entries = NULL;
+		return -ENOMEM;
 	}
 
 	nvecs = pci_alloc_irq_vectors_affinity(wx->pdev, nvecs,
@@ -1931,10 +1929,8 @@ void wx_reset_interrupt_capability(struct wx *wx)
 	if (pdev->msix_enabled) {
 		kfree(wx->msix_q_entries);
 		wx->msix_q_entries = NULL;
-		if (!wx->msix_in_use) {
-			kfree(wx->msix_entry);
-			wx->msix_entry = NULL;
-		}
+		kfree(wx->msix_entry);
+		wx->msix_entry = NULL;
 	}
 	pci_free_irq_vectors(wx->pdev);
 }
@@ -2694,15 +2690,63 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 		wx->rss_enabled = false;
 	}
 
-	if (changed &
-	    (NETIF_F_HW_VLAN_CTAG_RX |
-	     NETIF_F_HW_VLAN_STAG_RX))
+	netdev->features = features;
+
+	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
+		wx->do_reset(netdev);
+	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
-	return 1;
+	return 0;
 }
 EXPORT_SYMBOL(wx_set_features);
 
+#define NETIF_VLAN_STRIPPING_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
+					 NETIF_F_HW_VLAN_STAG_RX)
+
+#define NETIF_VLAN_INSERTION_FEATURES	(NETIF_F_HW_VLAN_CTAG_TX | \
+					 NETIF_F_HW_VLAN_STAG_TX)
+
+#define NETIF_VLAN_FILTERING_FEATURES	(NETIF_F_HW_VLAN_CTAG_FILTER | \
+					 NETIF_F_HW_VLAN_STAG_FILTER)
+
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features)
+{
+	netdev_features_t changed = netdev->features ^ features;
+	struct wx *wx = netdev_priv(netdev);
+
+	if (changed & NETIF_VLAN_STRIPPING_FEATURES) {
+		if ((features & NETIF_VLAN_STRIPPING_FEATURES) != NETIF_VLAN_STRIPPING_FEATURES &&
+		    (features & NETIF_VLAN_STRIPPING_FEATURES) != 0) {
+			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
+			features |= netdev->features & NETIF_VLAN_STRIPPING_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN stripping must be either both on or both off.");
+		}
+	}
+
+	if (changed & NETIF_VLAN_INSERTION_FEATURES) {
+		if ((features & NETIF_VLAN_INSERTION_FEATURES) != NETIF_VLAN_INSERTION_FEATURES &&
+		    (features & NETIF_VLAN_INSERTION_FEATURES) != 0) {
+			features &= ~NETIF_VLAN_INSERTION_FEATURES;
+			features |= netdev->features & NETIF_VLAN_INSERTION_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN insertion must be either both on or both off.");
+		}
+	}
+
+	if (changed & NETIF_VLAN_FILTERING_FEATURES) {
+		if ((features & NETIF_VLAN_FILTERING_FEATURES) != NETIF_VLAN_FILTERING_FEATURES &&
+		    (features & NETIF_VLAN_FILTERING_FEATURES) != 0) {
+			features &= ~NETIF_VLAN_FILTERING_FEATURES;
+			features |= netdev->features & NETIF_VLAN_FILTERING_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN filtering must be either both on or both off.");
+		}
+	}
+
+	return features;
+}
+EXPORT_SYMBOL(wx_fix_features);
+
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index ec909e876720..c41b29ea812f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -30,6 +30,8 @@ int wx_setup_resources(struct wx *wx);
 void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats);
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features);
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b4dc4f341117..5aaf7b1fa2db 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -982,8 +982,13 @@ struct wx_hw_stats {
 	u64 qmprc;
 };
 
+enum wx_state {
+	WX_STATE_RESETTING,
+	WX_STATE_NBITS,		/* must be last */
+};
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	DECLARE_BITMAP(state, WX_STATE_NBITS);
 
 	void *priv;
 	u8 __iomem *hw_addr;
@@ -1047,7 +1052,6 @@ struct wx {
 	unsigned int queues_per_pool;
 	struct msix_entry *msix_q_entries;
 	struct msix_entry *msix_entry;
-	bool msix_in_use;
 	struct wx_ring_feature ring_feature[RING_F_ARRAY_SIZE];
 
 	/* misc interrupt status block */
@@ -1072,6 +1076,8 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+
+	void (*do_reset)(struct net_device *netdev);
 };
 
 #define WX_INTR_ALL (~0ULL)
@@ -1132,4 +1138,19 @@ static inline struct wx *phylink_to_wx(struct phylink_config *config)
 	return container_of(config, struct wx, phylink_config);
 }
 
+static inline int wx_set_state_reset(struct wx *wx)
+{
+	u8 timeout = 50;
+
+	while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
+		timeout--;
+		if (!timeout)
+			return -EBUSY;
+
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
 #endif /* _WX_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 786a652ae64f..46a5a3e95202 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -52,7 +52,7 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i;
+	int i, err = 0;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
@@ -64,6 +64,10 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
+	err = wx_set_state_reset(wx);
+	if (err)
+		return err;
+
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
 			wx->tx_ring[i]->count = new_tx_count;
@@ -72,14 +76,16 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
-		return 0;
+		goto clear_reset;
 	}
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
 	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
-	if (!temp_ring)
-		return -ENOMEM;
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
 
 	ngbe_down(wx);
 
@@ -89,7 +95,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_configure(wx);
 	ngbe_up(wx);
 
-	return 0;
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	return err;
 }
 
 static int ngbe_set_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index fdd6b4f70b7a..e894e01d030d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -499,6 +499,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
+	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
diff --git a/drivers/net/ethernet/wangxun/txgbe/Makefile b/drivers/net/ethernet/wangxun/txgbe/Makefile
index 7507f762edfe..42718875277c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/Makefile
+++ b/drivers/net/ethernet/wangxun/txgbe/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_TXGBE) += txgbe.o
 txgbe-objs := txgbe_main.o \
               txgbe_hw.o \
               txgbe_phy.o \
+              txgbe_irq.o \
               txgbe_ethtool.o
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index db675512ce4d..31fde3fa7c6b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -19,7 +19,7 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i;
+	int i, err = 0;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
@@ -31,6 +31,10 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
+	err = wx_set_state_reset(wx);
+	if (err)
+		return err;
+
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
 			wx->tx_ring[i]->count = new_tx_count;
@@ -39,14 +43,16 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
-		return 0;
+		goto clear_reset;
 	}
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
 	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
-	if (!temp_ring)
-		return -ENOMEM;
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
 
 	txgbe_down(wx);
 
@@ -55,7 +61,9 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 
 	txgbe_up(wx);
 
-	return 0;
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	return err;
 }
 
 static int txgbe_set_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
new file mode 100644
index 000000000000..b3e3605d1edb
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/irqdomain.h>
+#include <linux/pci.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
+#include "../libwx/wx_hw.h"
+#include "txgbe_type.h"
+#include "txgbe_phy.h"
+#include "txgbe_irq.h"
+
+/**
+ * txgbe_irq_enable - Enable default interrupt generation settings
+ * @wx: pointer to private structure
+ * @queues: enable irqs for queues
+ **/
+void txgbe_irq_enable(struct wx *wx, bool queues)
+{
+	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
+
+	/* unmask interrupt */
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	if (queues)
+		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
+}
+
+/**
+ * txgbe_intr - msi/legacy mode Interrupt Handler
+ * @irq: interrupt number
+ * @data: pointer to a network interface device structure
+ **/
+static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
+{
+	struct wx_q_vector *q_vector;
+	struct wx *wx  = data;
+	struct pci_dev *pdev;
+	u32 eicr;
+
+	q_vector = wx->q_vector[0];
+	pdev = wx->pdev;
+
+	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
+	if (!eicr) {
+		/* shared interrupt alert!
+		 * the interrupt that we masked before the ICR read.
+		 */
+		if (netif_running(wx->netdev))
+			txgbe_irq_enable(wx, true);
+		return IRQ_NONE;        /* Not our interrupt */
+	}
+	wx->isb_mem[WX_ISB_VEC0] = 0;
+	if (!(pdev->msi_enabled))
+		wr32(wx, WX_PX_INTA, 1);
+
+	wx->isb_mem[WX_ISB_MISC] = 0;
+	/* would disable interrupts here but it is auto disabled */
+	napi_schedule_irqoff(&q_vector->napi);
+
+	/* re-enable link(maybe) and non-queue interrupts, no flush.
+	 * txgbe_poll will re-enable the queue interrupts
+	 */
+	if (netif_running(wx->netdev))
+		txgbe_irq_enable(wx, false);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * txgbe_request_msix_irqs - Initialize MSI-X interrupts
+ * @wx: board private structure
+ *
+ * Allocate MSI-X vectors and request interrupts from the kernel.
+ **/
+static int txgbe_request_msix_irqs(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	int vector, err;
+
+	for (vector = 0; vector < wx->num_q_vectors; vector++) {
+		struct wx_q_vector *q_vector = wx->q_vector[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
+
+		if (q_vector->tx.ring && q_vector->rx.ring)
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-TxRx-%d", netdev->name, entry->entry);
+		else
+			/* skip this unused q_vector */
+			continue;
+
+		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
+				  q_vector->name, q_vector);
+		if (err) {
+			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
+			       q_vector->name, err);
+			goto free_queue_irqs;
+		}
+	}
+
+	return 0;
+
+free_queue_irqs:
+	while (vector) {
+		vector--;
+		free_irq(wx->msix_q_entries[vector].vector,
+			 wx->q_vector[vector]);
+	}
+	wx_reset_interrupt_capability(wx);
+	return err;
+}
+
+/**
+ * txgbe_request_irq - initialize interrupts
+ * @wx: board private structure
+ *
+ * Attempt to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ **/
+int txgbe_request_irq(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	struct pci_dev *pdev = wx->pdev;
+	int err;
+
+	if (pdev->msix_enabled)
+		err = txgbe_request_msix_irqs(wx);
+	else if (pdev->msi_enabled)
+		err = request_irq(wx->pdev->irq, &txgbe_intr, 0,
+				  netdev->name, wx);
+	else
+		err = request_irq(wx->pdev->irq, &txgbe_intr, IRQF_SHARED,
+				  netdev->name, wx);
+
+	if (err)
+		wx_err(wx, "request_irq failed, Error %d\n", err);
+
+	return err;
+}
+
+static int txgbe_request_gpio_irq(struct txgbe *txgbe)
+{
+	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
+	return request_threaded_irq(txgbe->gpio_irq, NULL,
+				    txgbe_gpio_irq_handler,
+				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
+}
+
+static int txgbe_request_link_irq(struct txgbe *txgbe)
+{
+	txgbe->link_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
+	return request_threaded_irq(txgbe->link_irq, NULL,
+				    txgbe_link_irq_handler,
+				    IRQF_ONESHOT, "txgbe-link-irq", txgbe);
+}
+
+static const struct irq_chip txgbe_irq_chip = {
+	.name = "txgbe-misc-irq",
+};
+
+static int txgbe_misc_irq_domain_map(struct irq_domain *d,
+				     unsigned int irq,
+				     irq_hw_number_t hwirq)
+{
+	struct txgbe *txgbe = d->host_data;
+
+	irq_set_chip_data(irq, txgbe);
+	irq_set_chip(irq, &txgbe->misc.chip);
+	irq_set_nested_thread(irq, true);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
+	.map = txgbe_misc_irq_domain_map,
+};
+
+static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
+{
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	unsigned int nhandled = 0;
+	unsigned int sub_irq;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	if (eicr & TXGBE_PX_MISC_GPIO) {
+		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
+		handle_nested_irq(sub_irq);
+		nhandled++;
+	}
+	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
+		    TXGBE_PX_MISC_ETH_AN)) {
+		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
+		handle_nested_irq(sub_irq);
+		nhandled++;
+	}
+
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
+	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
+}
+
+static void txgbe_del_irq_domain(struct txgbe *txgbe)
+{
+	int hwirq, virq;
+
+	for (hwirq = 0; hwirq < txgbe->misc.nirqs; hwirq++) {
+		virq = irq_find_mapping(txgbe->misc.domain, hwirq);
+		irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(txgbe->misc.domain);
+}
+
+void txgbe_free_misc_irq(struct txgbe *txgbe)
+{
+	free_irq(txgbe->gpio_irq, txgbe);
+	free_irq(txgbe->link_irq, txgbe);
+	free_irq(txgbe->misc.irq, txgbe);
+	txgbe_del_irq_domain(txgbe);
+}
+
+int txgbe_setup_misc_irq(struct txgbe *txgbe)
+{
+	struct wx *wx = txgbe->wx;
+	int hwirq, err;
+
+	txgbe->misc.nirqs = 2;
+	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
+						   &txgbe_misc_irq_domain_ops, txgbe);
+	if (!txgbe->misc.domain)
+		return -ENOMEM;
+
+	for (hwirq = 0; hwirq < txgbe->misc.nirqs; hwirq++)
+		irq_create_mapping(txgbe->misc.domain, hwirq);
+
+	txgbe->misc.chip = txgbe_irq_chip;
+	if (wx->pdev->msix_enabled)
+		txgbe->misc.irq = wx->msix_entry->vector;
+	else
+		txgbe->misc.irq = wx->pdev->irq;
+
+	err = request_threaded_irq(txgbe->misc.irq, NULL,
+				   txgbe_misc_irq_handle,
+				   IRQF_ONESHOT,
+				   wx->netdev->name, txgbe);
+	if (err)
+		goto del_misc_irq;
+
+	err = txgbe_request_gpio_irq(txgbe);
+	if (err)
+		goto free_msic_irq;
+
+	err = txgbe_request_link_irq(txgbe);
+	if (err)
+		goto free_gpio_irq;
+
+	return 0;
+
+free_gpio_irq:
+	free_irq(txgbe->gpio_irq, txgbe);
+free_msic_irq:
+	free_irq(txgbe->misc.irq, txgbe);
+del_misc_irq:
+	txgbe_del_irq_domain(txgbe);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
new file mode 100644
index 000000000000..b77945e7a0f2
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+void txgbe_irq_enable(struct wx *wx, bool queues);
+int txgbe_request_irq(struct wx *wx);
+void txgbe_free_misc_irq(struct txgbe *txgbe);
+int txgbe_setup_misc_irq(struct txgbe *txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 3b151c410a5c..8c7a74981b90 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -17,6 +17,7 @@
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
+#include "txgbe_irq.h"
 #include "txgbe_ethtool.h"
 
 char txgbe_driver_name[] = "txgbe";
@@ -76,137 +77,11 @@ static int txgbe_enumerate_functions(struct wx *wx)
 	return physfns;
 }
 
-/**
- * txgbe_irq_enable - Enable default interrupt generation settings
- * @wx: pointer to private structure
- * @queues: enable irqs for queues
- **/
-static void txgbe_irq_enable(struct wx *wx, bool queues)
-{
-	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
-
-	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
-	if (queues)
-		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
-}
-
-/**
- * txgbe_intr - msi/legacy mode Interrupt Handler
- * @irq: interrupt number
- * @data: pointer to a network interface device structure
- **/
-static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
-{
-	struct wx_q_vector *q_vector;
-	struct wx *wx  = data;
-	struct pci_dev *pdev;
-	u32 eicr;
-
-	q_vector = wx->q_vector[0];
-	pdev = wx->pdev;
-
-	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
-	if (!eicr) {
-		/* shared interrupt alert!
-		 * the interrupt that we masked before the ICR read.
-		 */
-		if (netif_running(wx->netdev))
-			txgbe_irq_enable(wx, true);
-		return IRQ_NONE;        /* Not our interrupt */
-	}
-	wx->isb_mem[WX_ISB_VEC0] = 0;
-	if (!(pdev->msi_enabled))
-		wr32(wx, WX_PX_INTA, 1);
-
-	wx->isb_mem[WX_ISB_MISC] = 0;
-	/* would disable interrupts here but it is auto disabled */
-	napi_schedule_irqoff(&q_vector->napi);
-
-	/* re-enable link(maybe) and non-queue interrupts, no flush.
-	 * txgbe_poll will re-enable the queue interrupts
-	 */
-	if (netif_running(wx->netdev))
-		txgbe_irq_enable(wx, false);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * txgbe_request_msix_irqs - Initialize MSI-X interrupts
- * @wx: board private structure
- *
- * Allocate MSI-X vectors and request interrupts from the kernel.
- **/
-static int txgbe_request_msix_irqs(struct wx *wx)
-{
-	struct net_device *netdev = wx->netdev;
-	int vector, err;
-
-	for (vector = 0; vector < wx->num_q_vectors; vector++) {
-		struct wx_q_vector *q_vector = wx->q_vector[vector];
-		struct msix_entry *entry = &wx->msix_q_entries[vector];
-
-		if (q_vector->tx.ring && q_vector->rx.ring)
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-TxRx-%d", netdev->name, entry->entry);
-		else
-			/* skip this unused q_vector */
-			continue;
-
-		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
-				  q_vector->name, q_vector);
-		if (err) {
-			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
-			       q_vector->name, err);
-			goto free_queue_irqs;
-		}
-	}
-
-	return 0;
-
-free_queue_irqs:
-	while (vector) {
-		vector--;
-		free_irq(wx->msix_q_entries[vector].vector,
-			 wx->q_vector[vector]);
-	}
-	wx_reset_interrupt_capability(wx);
-	return err;
-}
-
-/**
- * txgbe_request_irq - initialize interrupts
- * @wx: board private structure
- *
- * Attempt to configure interrupts using the best available
- * capabilities of the hardware and kernel.
- **/
-static int txgbe_request_irq(struct wx *wx)
-{
-	struct net_device *netdev = wx->netdev;
-	struct pci_dev *pdev = wx->pdev;
-	int err;
-
-	if (pdev->msix_enabled)
-		err = txgbe_request_msix_irqs(wx);
-	else if (pdev->msi_enabled)
-		err = request_irq(wx->pdev->irq, &txgbe_intr, 0,
-				  netdev->name, wx);
-	else
-		err = request_irq(wx->pdev->irq, &txgbe_intr, IRQF_SHARED,
-				  netdev->name, wx);
-
-	if (err)
-		wx_err(wx, "request_irq failed, Error %d\n", err);
-
-	return err;
-}
-
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	txgbe_reinit_gpio_intr(wx);
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
 
@@ -394,6 +269,8 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
 
+	wx->do_reset = txgbe_do_reset;
+
 	return 0;
 }
 
@@ -518,6 +395,7 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -528,6 +406,7 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	else
 		txgbe_reset(wx);
 
+	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -536,6 +415,7 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
+	txgbe_setup_misc_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -543,6 +423,34 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void txgbe_reinit_locked(struct wx *wx)
+{
+	int err = 0;
+
+	netif_trans_update(wx->netdev);
+
+	err = wx_set_state_reset(wx);
+	if (err) {
+		wx_err(wx, "wait device reset timeout\n");
+		return;
+	}
+
+	txgbe_down(wx);
+	txgbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+void txgbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		txgbe_reinit_locked(wx);
+	else
+		txgbe_reset(wx);
+}
+
 static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_open               = txgbe_open,
 	.ndo_stop               = txgbe_close,
@@ -550,6 +458,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
+	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
@@ -751,10 +660,14 @@ static int txgbe_probe(struct pci_dev *pdev,
 	txgbe->wx = wx;
 	wx->priv = txgbe;
 
-	err = txgbe_init_phy(txgbe);
+	err = txgbe_setup_misc_irq(txgbe);
 	if (err)
 		goto err_release_hw;
 
+	err = txgbe_init_phy(txgbe);
+	if (err)
+		goto err_free_misc_irq;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_remove_phy;
@@ -781,6 +694,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
+err_free_misc_irq:
+	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -813,6 +728,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
+	txgbe_free_misc_irq(txgbe);
 
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 8cddc9ddb339..93295916b1d2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,8 +20,6 @@
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
-#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
-
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
 	struct txgbe_nodes *nodes = &txgbe->nodes;
@@ -294,6 +292,21 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 	return 0;
 }
 
+irqreturn_t txgbe_link_irq_handler(int irq, void *data)
+{
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	u32 status;
+	bool up;
+
+	status = rd32(wx, TXGBE_CFG_PORT_ST);
+	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
+
+	phylink_mac_change(wx->phylink, up);
+
+	return IRQ_HANDLED;
+}
+
 static int txgbe_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct wx *wx = gpiochip_get_data(chip);
@@ -439,7 +452,7 @@ static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
 }
 
 static const struct irq_chip txgbe_gpio_irq_chip = {
-	.name = "txgbe_gpio_irq",
+	.name = "txgbe-gpio-irq",
 	.irq_ack = txgbe_gpio_irq_ack,
 	.irq_mask = txgbe_gpio_irq_mask,
 	.irq_unmask = txgbe_gpio_irq_unmask,
@@ -448,29 +461,25 @@ static const struct irq_chip txgbe_gpio_irq_chip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static void txgbe_irq_handler(struct irq_desc *desc)
+irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct wx *wx = irq_desc_get_handler_data(desc);
-	struct txgbe *txgbe = wx->priv;
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
 	irq_hw_number_t hwirq;
 	unsigned long gpioirq;
 	struct gpio_chip *gc;
 	unsigned long flags;
-	u32 eicr;
-
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
-
-	chained_irq_enter(chip, desc);
 
 	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
 
 	gc = txgbe->gpio;
 	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
 		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
+		struct irq_data *d = irq_get_irq_data(gpio);
 		u32 irq_type = irq_get_trigger_type(gpio);
 
-		generic_handle_domain_irq(gc->irq.domain, hwirq);
+		txgbe_gpio_irq_ack(d);
+		handle_nested_irq(gpio);
 
 		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
@@ -479,17 +488,34 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 		}
 	}
 
-	chained_irq_exit(chip, desc);
+	return IRQ_HANDLED;
+}
+
+void txgbe_reinit_gpio_intr(struct wx *wx)
+{
+	struct txgbe *txgbe = wx->priv;
+	irq_hw_number_t hwirq;
+	unsigned long gpioirq;
+	struct gpio_chip *gc;
+	unsigned long flags;
+
+	/* for gpio interrupt pending before irq enable */
+	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
 
-	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
-		    TXGBE_PX_MISC_ETH_AN)) {
-		u32 reg = rd32(wx, TXGBE_CFG_PORT_ST);
+	gc = txgbe->gpio;
+	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
+		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
+		struct irq_data *d = irq_get_irq_data(gpio);
+		u32 irq_type = irq_get_trigger_type(gpio);
 
-		phylink_mac_change(wx->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
-	}
+		txgbe_gpio_irq_ack(d);
 
-	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC);
+		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
+			txgbe_toggle_trigger(gc, hwirq);
+			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
+		}
+	}
 }
 
 static int txgbe_gpio_init(struct txgbe *txgbe)
@@ -526,19 +552,6 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 
 	girq = &gc->irq;
 	gpio_irq_chip_set_chip(girq, &txgbe_gpio_irq_chip);
-	girq->parent_handler = txgbe_irq_handler;
-	girq->parent_handler_data = wx;
-	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(dev, girq->num_parents,
-				     sizeof(*girq->parents), GFP_KERNEL);
-	if (!girq->parents)
-		return -ENOMEM;
-
-	/* now only suuported on MSI-X interrupt */
-	if (!wx->msix_entry)
-		return -EPERM;
-
-	girq->parents[0] = wx->msix_entry->vector;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 
@@ -558,8 +571,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "%s.%d",
-		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
+		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -621,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = TXGBE_I2C_CLK_DEV_NAME;
+	info.name = "i2c_designware";
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
@@ -756,8 +769,6 @@ int txgbe_init_phy(struct txgbe *txgbe)
 		goto err_unregister_i2c;
 	}
 
-	wx->msix_in_use = true;
-
 	return 0;
 
 err_unregister_i2c:
@@ -790,5 +801,4 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy(txgbe->xpcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
-	txgbe->wx->msix_in_use = false;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 1ab592124986..8a026d804fe2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -4,6 +4,9 @@
 #ifndef _TXGBE_PHY_H_
 #define _TXGBE_PHY_H_
 
+irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
+void txgbe_reinit_gpio_intr(struct wx *wx);
+irqreturn_t txgbe_link_irq_handler(int irq, void *data);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 270a6fd9ad0b..f434a7865cb7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -5,6 +5,7 @@
 #define _TXGBE_TYPE_H_
 
 #include <linux/property.h>
+#include <linux/irq.h>
 
 /* Device IDs */
 #define TXGBE_DEV_ID_SP1000                     0x1001
@@ -133,6 +134,7 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
+void txgbe_do_reset(struct net_device *netdev);
 
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
@@ -169,15 +171,31 @@ struct txgbe_nodes {
 	const struct software_node *group[SWNODE_MAX + 1];
 };
 
+enum txgbe_misc_irqs {
+	TXGBE_IRQ_GPIO = 0,
+	TXGBE_IRQ_LINK,
+	TXGBE_IRQ_MAX
+};
+
+struct txgbe_irq {
+	struct irq_chip chip;
+	struct irq_domain *domain;
+	int nirqs;
+	int irq;
+};
+
 struct txgbe {
 	struct wx *wx;
 	struct txgbe_nodes nodes;
+	struct txgbe_irq misc;
 	struct dw_xpcs *xpcs;
 	struct platform_device *sfp_dev;
 	struct platform_device *i2c_dev;
 	struct clk_lookup *clock;
 	struct clk *clk;
 	struct gpio_chip *gpio;
+	unsigned int gpio_irq;
+	unsigned int link_irq;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 1f950c824418..827db6a6ff39 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4635,7 +4635,8 @@ static int lan8841_suspend(struct phy_device *phydev)
 	struct kszphy_priv *priv = phydev->priv;
 	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
 
-	ptp_cancel_worker_sync(ptp_priv->ptp_clock);
+	if (ptp_priv->ptp_clock)
+		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
 	return genphy_suspend(phydev);
 }
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 7b8afa589a53..284375f662f1 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1141,17 +1141,15 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			continue;
 		}
 
-		/* Clone SKB */
-		new_skb = skb_clone(skb, GFP_ATOMIC);
+		new_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 
 		if (!new_skb)
 			goto err;
 
-		new_skb->len = pkt_len;
+		skb_put(new_skb, pkt_len);
+		memcpy(new_skb->data, skb->data, pkt_len);
 		skb_pull(new_skb, AQ_RX_HW_PAD);
-		skb_set_tail_pointer(new_skb, new_skb->len);
 
-		new_skb->truesize = SKB_TRUESIZE(new_skb->len);
 		if (aqc111_data->rx_checksum)
 			aqc111_rx_checksum(new_skb, pkt_desc);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index edc34402e787..a5469cf5cf67 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1368,6 +1368,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 2fa46baa589e..cbea24666479 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1810,9 +1810,11 @@ static int smsc95xx_reset_resume(struct usb_interface *intf)
 
 static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
 {
-	skb->csum = *(u16 *)(skb_tail_pointer(skb) - 2);
+	u16 *csum_ptr = (u16 *)(skb_tail_pointer(skb) - 2);
+
+	skb->csum = (__force __wsum)get_unaligned(csum_ptr);
 	skb->ip_summed = CHECKSUM_COMPLETE;
-	skb_trim(skb, skb->len - 2);
+	skb_trim(skb, skb->len - 2); /* remove csum */
 }
 
 static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
@@ -1870,25 +1872,22 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				if (dev->net->features & NETIF_F_RXCSUM)
 					smsc95xx_rx_csum_offload(skb);
 				skb_trim(skb, skb->len - 4); /* remove fcs */
-				skb->truesize = size + sizeof(struct sk_buff);
 
 				return 1;
 			}
 
-			ax_skb = skb_clone(skb, GFP_ATOMIC);
+			ax_skb = netdev_alloc_skb_ip_align(dev->net, size);
 			if (unlikely(!ax_skb)) {
 				netdev_warn(dev->net, "Error allocating skb\n");
 				return 0;
 			}
 
-			ax_skb->len = size;
-			ax_skb->data = packet;
-			skb_set_tail_pointer(ax_skb, size);
+			skb_put(ax_skb, size);
+			memcpy(ax_skb->data, packet, size);
 
 			if (dev->net->features & NETIF_F_RXCSUM)
 				smsc95xx_rx_csum_offload(ax_skb);
 			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
-			ax_skb->truesize = size + sizeof(struct sk_buff);
 
 			usbnet_skb_return(dev, ax_skb);
 		}
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 3164451e1010..0a662e42ed96 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -421,19 +421,15 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			skb_pull(skb, 3);
 			skb->len = len;
 			skb_set_tail_pointer(skb, len);
-			skb->truesize = len + sizeof(struct sk_buff);
 			return 2;
 		}
 
-		/* skb_clone is used for address align */
-		sr_skb = skb_clone(skb, GFP_ATOMIC);
+		sr_skb = netdev_alloc_skb_ip_align(dev->net, len);
 		if (!sr_skb)
 			return 0;
 
-		sr_skb->len = len;
-		sr_skb->data = skb->data + 3;
-		skb_set_tail_pointer(sr_skb, len);
-		sr_skb->truesize = len + sizeof(struct sk_buff);
+		skb_put(sr_skb, len);
+		memcpy(sr_skb->data, skb->data + 3, len);
 		usbnet_skb_return(dev, sr_skb);
 
 		skb_pull(skb, len + SR_RX_OVERHEAD);
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index a742cec44e3d..91ddbe6136e0 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1590,6 +1590,20 @@ static int ar5523_probe(struct usb_interface *intf,
 	struct ar5523 *ar;
 	int error = -ENOMEM;
 
+	static const u8 bulk_ep_addr[] = {
+		AR5523_CMD_TX_PIPE | USB_DIR_OUT,
+		AR5523_DATA_TX_PIPE | USB_DIR_OUT,
+		AR5523_CMD_RX_PIPE | USB_DIR_IN,
+		AR5523_DATA_RX_PIPE | USB_DIR_IN,
+		0};
+
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
+		dev_err(&dev->dev,
+			"Could not find all expected endpoints\n");
+		error = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Load firmware if the device requires it.  This will return
 	 * -ENXIO on success and we'll get called back afer the usb
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 0032f8aa892f..4e3736d7aff7 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -720,6 +720,9 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.max_spatial_stream = 4,
 		.fw = {
 			.dir = WCN3990_HW_1_0_FW_DIR,
+			.board = WCN3990_HW_1_0_BOARD_DATA_FILE,
+			.board_size = WCN3990_BOARD_DATA_SZ,
+			.board_ext_size = WCN3990_BOARD_EXT_DATA_SZ,
 		},
 		.sw_decrypt_mcast_mgmt = true,
 		.rx_desc_ops = &wcn3990_rx_desc_ops,
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 394bf3c32abf..0f6de862c3a9 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -439,7 +439,7 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
 	}
 out:
 	mutex_unlock(&ar->conf_mutex);
-	return count;
+	return ret ?: count;
 }
 
 static const struct file_operations fops_peer_debug_trigger = {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 93c073091996..9aa2d821b507 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -133,6 +133,7 @@ enum qca9377_chip_id_rev {
 /* WCN3990 1.0 definitions */
 #define WCN3990_HW_1_0_DEV_VERSION	ATH10K_HW_WCN3990
 #define WCN3990_HW_1_0_FW_DIR		ATH10K_FW_DIR "/WCN3990/hw1.0"
+#define WCN3990_HW_1_0_BOARD_DATA_FILE "board.bin"
 
 #define ATH10K_FW_FILE_BASE		"firmware"
 #define ATH10K_FW_API_MAX		6
diff --git a/drivers/net/wireless/ath/ath10k/targaddrs.h b/drivers/net/wireless/ath/ath10k/targaddrs.h
index ec556bb88d65..ba37e6c7ced0 100644
--- a/drivers/net/wireless/ath/ath10k/targaddrs.h
+++ b/drivers/net/wireless/ath/ath10k/targaddrs.h
@@ -491,4 +491,7 @@ struct host_interest {
 #define QCA4019_BOARD_DATA_SZ	  12064
 #define QCA4019_BOARD_EXT_DATA_SZ 0
 
+#define WCN3990_BOARD_DATA_SZ	  26328
+#define WCN3990_BOARD_EXT_DATA_SZ 0
+
 #endif /* __TARGADDRS_H__ */
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 88befe92f95d..24f1ab278521 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1763,12 +1763,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
-	unsigned long time_left;
+	unsigned long time_left, i;
 
 	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
 						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
+	if (!time_left) {
+		/* Sometimes the PCI HIF doesn't receive interrupt
+		 * for the service ready message even if the buffer
+		 * was completed. PCIe sniffer shows that it's
+		 * because the corresponding CE ring doesn't fires
+		 * it. Workaround here by polling CE rings once.
+		 */
+		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
+
+		for (i = 0; i < CE_COUNT; i++)
+			ath10k_hif_send_complete_check(ar, i, 1);
+
+		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
+							WMI_SERVICE_READY_TIMEOUT_HZ);
+		if (!time_left) {
+			ath10k_warn(ar, "polling timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		ath10k_warn(ar, "service ready completion received, continuing normally\n");
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cc80310088ce..a46b8e677cd1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1234,14 +1234,7 @@ static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
 
 	enable_ps = arvif->ps;
 
-	if (!arvif->is_started) {
-		/* mac80211 can update vif powersave state while disconnected.
-		 * Firmware doesn't behave nicely and consumes more power than
-		 * necessary if PS is disabled on a non-started vdev. Hence
-		 * force-enable PS for non-running vdevs.
-		 */
-		psmode = WMI_STA_PS_MODE_ENABLED;
-	} else if (enable_ps) {
+	if (enable_ps) {
 		psmode = WMI_STA_PS_MODE_ENABLED;
 		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 77a132f6bbd1..b3440a5e38af 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2941,6 +2941,9 @@ static const struct qmi_msg_handler ath12k_qmi_msg_handlers[] = {
 		.decoded_size = sizeof(struct qmi_wlanfw_fw_ready_ind_msg_v01),
 		.fn = ath12k_qmi_msg_fw_ready_cb,
 	},
+
+	/* end of list */
+	{},
 };
 
 static int ath12k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 11cc3005c0f9..035d8f247e23 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1836,7 +1836,7 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		if (arg->bw_160)
 			cmd->peer_flags |= cpu_to_le32(WMI_PEER_160MHZ);
 		if (arg->bw_320)
-			cmd->peer_flags |= cpu_to_le32(WMI_PEER_EXT_320MHZ);
+			cmd->peer_flags_ext |= cpu_to_le32(WMI_PEER_EXT_320MHZ);
 
 		/* Typically if STBC is enabled for VHT it should be enabled
 		 * for HT as well
diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 6bb9aa2bfe65..88ef6e023f82 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
 	 * carl9170_tx_fill_rateinfo() has filled the rate information
 	 * before we get to this point.
 	 */
-	memset_after(&txinfo->status, 0, rates);
+	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
+	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));
 
 	if (atomic_read(&ar->tx_total_queued))
 		ar->tx_schedule = true;
diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index c4edf8355941..a3e03580cd9f 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -1069,6 +1069,38 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 			ar->usb_ep_cmd_is_bulk = true;
 	}
 
+	/* Verify that all expected endpoints are present */
+	if (ar->usb_ep_cmd_is_bulk) {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	} else {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	}
+
+	if (err) {
+		carl9170_free(ar);
+		return err;
+	}
+
 	usb_set_intfdata(intf, ar);
 	SET_IEEE80211_DEV(ar->hw, &intf->dev);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index d7fb88bb6ae1..06698a714b52 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1675,6 +1675,15 @@ struct brcmf_random_seed_footer {
 #define BRCMF_RANDOM_SEED_MAGIC		0xfeedc0de
 #define BRCMF_RANDOM_SEED_LENGTH	0x100
 
+static noinline_for_stack void
+brcmf_pcie_provide_random_bytes(struct brcmf_pciedev_info *devinfo, u32 address)
+{
+	u8 randbuf[BRCMF_RANDOM_SEED_LENGTH];
+
+	get_random_bytes(randbuf, BRCMF_RANDOM_SEED_LENGTH);
+	memcpy_toio(devinfo->tcm + address, randbuf, BRCMF_RANDOM_SEED_LENGTH);
+}
+
 static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 					const struct firmware *fw, void *nvram,
 					u32 nvram_len)
@@ -1717,7 +1726,6 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
-			void *randbuf;
 
 			/* Some Apple chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
@@ -1729,10 +1737,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 				    sizeof(footer));
 
 			address -= rand_len;
-			randbuf = kzalloc(rand_len, GFP_KERNEL);
-			get_random_bytes(randbuf, rand_len);
-			memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
-			kfree(randbuf);
+			brcmf_pcie_provide_random_bytes(devinfo, address);
 		}
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e321d41d1aba..05735817918b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1547,6 +1547,17 @@ static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
 					IWL_STA_MULTICAST);
 }
 
+void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return;
+
+	INIT_DELAYED_WORK(&mvmvif->csa_work,
+			  iwl_mvm_channel_switch_disconnect_wk);
+}
+
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
@@ -1557,6 +1568,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
+	iwl_mvm_mac_init_mvmvif(mvm, mvmvif);
+
 	mvmvif->mvm = mvm;
 
 	/* the first link always points to the default one */
@@ -1632,8 +1645,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = vif;
 
 	iwl_mvm_tcm_add_vif(mvm, vif);
-	INIT_DELAYED_WORK(&mvmvif->csa_work,
-			  iwl_mvm_channel_switch_disconnect_wk);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = true;
@@ -1671,6 +1682,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		/*
 		 * Flush the ROC worker which will flush the OFFCHANNEL queue.
@@ -1679,6 +1692,8 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 		 */
 		flush_work(&mvm->roc_done_wk);
 	}
+
+	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
 /* This function is doing the common part of removing the interface for
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 893b69fc841b..1b39c9ea55fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -14,6 +14,8 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
+	iwl_mvm_mac_init_mvmvif(mvm, mvmvif);
+
 	mvmvif->mvm = mvm;
 
 	/* Not much to do here. The stack will not allow interface
@@ -189,17 +191,13 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static unsigned int iwl_mvm_mld_count_active_links(struct ieee80211_vif *vif)
+static unsigned int iwl_mvm_mld_count_active_links(struct iwl_mvm_vif *mvmvif)
 {
 	unsigned int n_active = 0;
 	int i;
 
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		struct ieee80211_bss_conf *link_conf;
-
-		link_conf = link_conf_dereference_protected(vif, i);
-		if (link_conf &&
-		    rcu_access_pointer(link_conf->chanctx_conf))
+		if (mvmvif->link[i] && mvmvif->link[i]->phy_ctxt)
 			n_active++;
 	}
 
@@ -245,21 +243,18 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
-	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int n_active = iwl_mvm_mld_count_active_links(mvmvif);
 	unsigned int link_id = link_conf->link_id;
 	int ret;
 
-	/* if the assigned one was not counted yet, count it now */
-	if (!rcu_access_pointer(link_conf->chanctx_conf))
-		n_active++;
-
-	if (n_active > iwl_mvm_max_active_links(mvm, vif))
-		return -EOPNOTSUPP;
-
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
 		return -EINVAL;
 
+	/* if the assigned one was not counted yet, count it now */
+	if (!mvmvif->link[link_id]->phy_ctxt)
+		n_active++;
+
 	/* mac parameters such as HE support can change at this stage
 	 * For sta, need first to configure correct state from drv_sta_state
 	 * and only after that update mac config.
@@ -299,13 +294,8 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	 * this needs the phy context assigned (and in FW?), and we cannot
 	 * do it later because it needs to be initialized as soon as we're
 	 * able to TX on the link, i.e. when active.
-	 *
-	 * Firmware restart isn't quite correct yet for MLO, but we don't
-	 * need to do it in that case anyway since it will happen from the
-	 * normal station state callback.
 	 */
-	if (mvmvif->ap_sta &&
-	    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+	if (mvmvif->ap_sta) {
 		struct ieee80211_link_sta *link_sta;
 
 		rcu_read_lock();
@@ -419,7 +409,7 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
+	unsigned int n_active = iwl_mvm_mld_count_active_links(mvmvif);
 	unsigned int link_id = link_conf->link_id;
 
 	/* shouldn't happen, but verify link_id is valid before accessing */
@@ -1122,17 +1112,12 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 			     struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
 {
 	struct iwl_mvm_vif_link_info *new_link[IEEE80211_MLD_MAX_NUM_LINKS] = {};
-	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u16 removed = old_links & ~new_links;
 	u16 added = new_links & ~old_links;
 	int err, i;
 
-	if (hweight16(new_links) > 1 &&
-	    n_active > iwl_mvm_max_active_links(mvm, vif))
-		return -EOPNOTSUPP;
-
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 		int r;
 
@@ -1224,6 +1209,15 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   u16 desired_links)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	return hweight16(desired_links) <= iwl_mvm_max_active_links(mvm, vif);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1318,4 +1312,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 
 	.change_vif_links = iwl_mvm_mld_change_vif_links,
 	.change_sta_links = iwl_mvm_mld_change_sta_links,
+	.can_activate_links = iwl_mvm_mld_can_activate_links,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 23e64a757cfe..36dc291d98dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -9,7 +9,9 @@
 u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   int filter_link_id)
 {
+	struct ieee80211_link_sta *link_sta;
 	struct iwl_mvm_sta *mvmsta;
+	struct ieee80211_vif *vif;
 	unsigned int link_id;
 	u32 result = 0;
 
@@ -17,26 +19,27 @@ u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		return 0;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	vif = mvmsta->vif;
 
 	/* it's easy when the STA is not an MLD */
 	if (!sta->valid_links)
 		return BIT(mvmsta->deflink.sta_id);
 
 	/* but if it is an MLD, get the mask of all the FW STAs it has ... */
-	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
-		struct iwl_mvm_link_sta *link_sta;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct iwl_mvm_link_sta *mvm_link_sta;
 
 		/* unless we have a specific link in mind */
 		if (filter_link_id >= 0 && link_id != filter_link_id)
 			continue;
 
-		link_sta =
+		mvm_link_sta =
 			rcu_dereference_check(mvmsta->link[link_id],
 					      lockdep_is_held(&mvm->mutex));
-		if (!link_sta)
+		if (!mvm_link_sta)
 			continue;
 
-		result |= BIT(link_sta->sta_id);
+		result |= BIT(mvm_link_sta->sta_id);
 	}
 
 	return result;
@@ -582,14 +585,14 @@ static int iwl_mvm_mld_alloc_sta_links(struct iwl_mvm *mvm,
 				       struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
-		if (!rcu_access_pointer(sta->link[link_id]) ||
-		    mvm_sta->link[link_id])
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		if (WARN_ON(mvm_sta->link[link_id]))
 			continue;
 
 		ret = iwl_mvm_mld_alloc_sta_link(mvm, vif, sta, link_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fe0fa9ff533d..4653f608355c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1769,6 +1769,8 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm);
 
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm);
 
+void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif);
+
 /*
  * FW notifications / CMD responses handlers
  * Convention: iwl_mvm_rx_<NAME OF THE CMD>
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 97d44354dbbb..3dc6fb0600aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3173,8 +3173,13 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		struct iwl_mvm_vif_link_info *link_info =
 			scan_vif->link[mvm->scan_link_id];
 
-		if (!WARN_ON(!link_info))
+		/* It is possible that by the time the scan is complete the link
+		 * was already removed and is not valid.
+		 */
+		if (link_info)
 			memcpy(info.tsf_bssid, link_info->bssid, ETH_ALEN);
+		else
+			IWL_DEBUG_SCAN(mvm, "Scan link is no longer valid\n");
 
 		ieee80211_scan_completed(mvm->hw, &info);
 		mvm->scan_vif = NULL;
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 13bcb123d122..c0ecd769ada7 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2718,7 +2718,7 @@ __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
 		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_MULTICAST);
 		cmd->numaddr = cpu_to_le16(mc_count);
 		netdev_hw_addr_list_for_each(ha, mc_list) {
-			memcpy(cmd->addr[i], ha->addr, ETH_ALEN);
+			memcpy(cmd->addr[i++], ha->addr, ETH_ALEN);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 7a2f5d38562b..14304b063715 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -4,6 +4,13 @@
 #include "mac.h"
 #include "../dma.h"
 
+static const u8 wmm_queue_map[] = {
+	[IEEE80211_AC_BK] = 0,
+	[IEEE80211_AC_BE] = 1,
+	[IEEE80211_AC_VI] = 2,
+	[IEEE80211_AC_VO] = 3,
+};
+
 static void
 mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 {
@@ -22,10 +29,10 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct mt7603_sta *msta;
 	struct mt76_wcid *wcid;
+	u8 tid = 0, hwq = 0;
 	void *priv;
 	int idx;
 	u32 val;
-	u8 tid = 0;
 
 	if (skb->len < MT_TXD_SIZE + sizeof(struct ieee80211_hdr))
 		goto free;
@@ -42,19 +49,36 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 		goto free;
 
 	priv = msta = container_of(wcid, struct mt7603_sta, wcid);
-	val = le32_to_cpu(txd[0]);
-	val &= ~(MT_TXD0_P_IDX | MT_TXD0_Q_IDX);
-	val |= FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_HW_QUEUE_MGMT);
-	txd[0] = cpu_to_le32(val);
 
 	sta = container_of(priv, struct ieee80211_sta, drv_priv);
 	hdr = (struct ieee80211_hdr *)&skb->data[MT_TXD_SIZE];
-	if (ieee80211_is_data_qos(hdr->frame_control))
+
+	hwq = wmm_queue_map[IEEE80211_AC_BE];
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tid = *ieee80211_get_qos_ctl(hdr) &
-		      IEEE80211_QOS_CTL_TAG1D_MASK;
-	skb_set_queue_mapping(skb, tid_to_ac[tid]);
+			 IEEE80211_QOS_CTL_TAG1D_MASK;
+		u8 qid = tid_to_ac[tid];
+		hwq = wmm_queue_map[qid];
+		skb_set_queue_mapping(skb, qid);
+	} else if (ieee80211_is_data(hdr->frame_control)) {
+		skb_set_queue_mapping(skb, IEEE80211_AC_BE);
+		hwq = wmm_queue_map[IEEE80211_AC_BE];
+	} else {
+		skb_pull(skb, MT_TXD_SIZE);
+		if (!ieee80211_is_bufferable_mmpdu(skb))
+			goto free;
+		skb_push(skb, MT_TXD_SIZE);
+		skb_set_queue_mapping(skb, MT_TXQ_PSD);
+		hwq = MT_TX_HW_QUEUE_MGMT;
+	}
+
 	ieee80211_sta_set_buffered(sta, tid, true);
 
+	val = le32_to_cpu(txd[0]);
+	val &= ~(MT_TXD0_P_IDX | MT_TXD0_Q_IDX);
+	val |= FIELD_PREP(MT_TXD0_Q_IDX, hwq);
+	txd[0] = cpu_to_le32(val);
+
 	spin_lock_bh(&dev->ps_lock);
 	__skb_queue_tail(&msta->psq, skb);
 	if (skb_queue_len(&msta->psq) >= 64) {
@@ -151,12 +175,6 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 
 int mt7603_dma_init(struct mt7603_dev *dev)
 {
-	static const u8 wmm_queue_map[] = {
-		[IEEE80211_AC_BK] = 0,
-		[IEEE80211_AC_BE] = 1,
-		[IEEE80211_AC_VI] = 2,
-		[IEEE80211_AC_VO] = 3,
-	};
 	int ret;
 	int i;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index cf21d06257e5..dc8a77f0a1cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1393,6 +1393,7 @@ void mt7603_pse_client_reset(struct mt7603_dev *dev)
 		   MT_CLIENT_RESET_TX_R_E_2_S);
 
 	/* Start PSE client TX abort */
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_FORCE_TX_EOF);
 	mt76_set(dev, addr, MT_CLIENT_RESET_TX_R_E_1);
 	mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_1_S,
 		       MT_CLIENT_RESET_TX_R_E_1_S, 500);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ae19174b46ee..5809555a909d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2524,6 +2524,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
 			__le16 tag;
 			__le16 len;
 			u8 suspend;
+			u8 pad[7];
 		} __packed hif_suspend;
 	} req = {
 		.hif_suspend = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6c3696c8c700..450f4d221184 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1049,6 +1049,7 @@ static ssize_t
 mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
+	int i, ret, pwr, pwr160 = 0, pwr80 = 0, pwr40 = 0, pwr20 = 0;
 	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
@@ -1057,7 +1058,6 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 		.band_idx = phy->mt76->band_idx,
 	};
 	char buf[100];
-	int i, ret, pwr160 = 0, pwr80 = 0, pwr40 = 0, pwr20 = 0;
 	enum mac80211_rx_encoding mode;
 	u32 offs = 0, len = 0;
 
@@ -1130,8 +1130,8 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 	if (ret)
 		goto out;
 
-	mphy->txpower_cur = max(mphy->txpower_cur,
-				max(pwr160, max(pwr80, max(pwr40, pwr20))));
+	pwr = max3(pwr80, pwr40, pwr20);
+	mphy->txpower_cur = max3(mphy->txpower_cur, pwr160, pwr);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 2cf39276118e..1599338e0631 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -535,7 +535,7 @@ struct mt7925_wow_pattern_tlv {
 	u8 offset;
 	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
 	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
-	u8 rsv[4];
+	u8 rsv[7];
 } __packed;
 
 static inline enum connac3_mcu_cipher_type
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 9e70b960086a..10d13fa45c5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3733,6 +3733,7 @@ int mt7996_mcu_get_temperature(struct mt7996_phy *phy)
 	} __packed * res;
 	struct sk_buff *skb;
 	int ret;
+	u32 temp;
 
 	ret = mt76_mcu_send_and_get_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(THERMAL),
 					&req, sizeof(req), true, &skb);
@@ -3740,8 +3741,10 @@ int mt7996_mcu_get_temperature(struct mt7996_phy *phy)
 		return ret;
 
 	res = (void *)skb->data;
+	temp = le32_to_cpu(res->temperature);
+	dev_kfree_skb(skb);
 
-	return le32_to_cpu(res->temperature);
+	return temp;
 }
 
 int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state)
@@ -4468,7 +4471,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 		u8 band_idx;
 	} __packed req = {
 		.tag = cpu_to_le16(UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL),
-		.len = cpu_to_le16(sizeof(req) + MT7996_SKU_RATE_NUM - 4),
+		.len = cpu_to_le16(sizeof(req) + MT7996_SKU_PATH_NUM - 4),
 		.power_ctrl_id = UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL,
 		.power_limit_type = TX_POWER_LIMIT_TABLE_RATE,
 		.band_idx = phy->mt76->band_idx,
@@ -4483,7 +4486,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 	mphy->txpower_cur = tx_power;
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(req) + MT7996_SKU_RATE_NUM);
+				 sizeof(req) + MT7996_SKU_PATH_NUM);
 	if (!skb)
 		return -ENOMEM;
 
@@ -4507,6 +4510,9 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 	/* eht */
 	skb_put_data(skb, &la.eht[0], sizeof(la.eht));
 
+	/* padding */
+	skb_put_zero(skb, MT7996_SKU_PATH_NUM - MT7996_SKU_RATE_NUM);
+
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WM_UNI_CMD(TXPOWER), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index efd4a767eb37..c93f82548bee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -519,7 +519,7 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 	struct mt7996_dev *dev = from_tasklet(dev, t, mt76.irq_tasklet);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct mtk_wed_device *wed_hif2 = &dev->mt76.mmio.wed_hif2;
-	u32 i, intr, mask, intr1;
+	u32 i, intr, mask, intr1 = 0;
 
 	if (dev->hif2 && mtk_wed_device_active(wed_hif2)) {
 		mtk_wed_device_irq_set_mask(wed_hif2, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 36d1f247d55a..ddeb40d522c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -50,6 +50,7 @@
 #define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
 #define MT7996_SKU_RATE_NUM		417
+#define MT7996_SKU_PATH_NUM		494
 
 #define MT7996_MAX_TWT_AGRT		16
 #define MT7996_MAX_STA_TWT_AGRT		8
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 917c01e5e9ed..e86d5588ec60 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -54,7 +54,8 @@ static void rtw89_ps_power_mode_change_with_hci(struct rtw89_dev *rtwdev,
 
 static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 {
-	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode))
+	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode) &&
+	    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags))
 		rtw89_ps_power_mode_change_with_hci(rtwdev, enter);
 	else
 		rtw89_mac_power_mode_change(rtwdev, enter);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5c7ca36c09b6..abb4d1cc55d0 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -489,14 +489,17 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool include_bb = !!chip->bbmcu_nr;
+	bool disable_intr_for_dlfw = false;
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta *rtwsta = NULL;
 	bool is_conn = true;
 	int ret;
 
-	rtw89_hci_disable_intr(rtwdev);
+	if (chip_id == RTL8852C || chip_id == RTL8922A)
+		disable_intr_for_dlfw = true;
 
 	wow_sta = ieee80211_find_sta(wow_vif, rtwvif->bssid);
 	if (wow_sta)
@@ -504,12 +507,18 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	else
 		is_conn = false;
 
+	if (disable_intr_for_dlfw)
+		rtw89_hci_disable_intr(rtwdev);
+
 	ret = rtw89_fw_download(rtwdev, fw_type, include_bb);
 	if (ret) {
 		rtw89_warn(rtwdev, "download fw failed\n");
 		return ret;
 	}
 
+	if (disable_intr_for_dlfw)
+		rtw89_hci_enable_intr(rtwdev);
+
 	rtw89_phy_init_rf_reg(rtwdev, true);
 
 	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
@@ -552,7 +561,6 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	}
 
 	rtw89_mac_hw_mgnt_sec(rtwdev, wow);
-	rtw89_hci_enable_intr(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26153cb7647d..3cc79817e4d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -619,27 +619,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
-/*
- * Returns true for sink states that can't ever transition back to live.
- */
-static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
-{
-	switch (nvme_ctrl_state(ctrl)) {
-	case NVME_CTRL_NEW:
-	case NVME_CTRL_LIVE:
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	case NVME_CTRL_DELETING:
-	case NVME_CTRL_DELETING_NOIO:
-	case NVME_CTRL_DEAD:
-		return true;
-	default:
-		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
-		return true;
-	}
-}
-
 /*
  * Waits for the controller state to be resetting, or returns false if it is
  * not possible to ever transition to that state.
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74de1e64aeea..75386d3e0f98 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -247,7 +247,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 738719085e05..2a7bf574284f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -745,6 +745,27 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
+/*
+ * Returns true for sink states that can't ever transition back to live.
+ */
+static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
+{
+	switch (nvme_ctrl_state(ctrl)) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
+	case NVME_CTRL_DEAD:
+		return true;
+	default:
+		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
+		return true;
+	}
+}
+
 void nvme_complete_rq(struct request *req);
 void nvme_complete_batch_req(struct request *req);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 02565dc99ad8..710043086dff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
+	if (nvme_state_terminal(&dev->ctrl))
+		goto disable;
+
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
@@ -1390,8 +1393,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	return BLK_EH_RESET_TIMER;
 
 disable:
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+		if (nvme_state_terminal(&dev->ctrl))
+			nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
+	}
 
 	nvme_dev_disable(dev, false);
 	if (nvme_try_sched_reset(&dev->ctrl))
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..6eeb96578d1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -352,12 +352,18 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
 		!llist_empty(&queue->req_list);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+		nvme_tcp_queue_has_pending(queue);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -378,7 +384,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		mutex_unlock(&queue->send_mutex);
 	}
 
-	if (last && nvme_tcp_queue_more(queue))
+	if (last && nvme_tcp_queue_has_pending(queue))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..fb518b00f71f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -285,9 +285,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	if (shash_len != crypto_shash_digestsize(shash_tfm)) {
-		pr_debug("%s: hash len mismatch (len %d digest %d)\n",
-			 __func__, shash_len,
-			 crypto_shash_digestsize(shash_tfm));
+		pr_err("%s: hash len mismatch (len %d digest %d)\n",
+			__func__, shash_len,
+			crypto_shash_digestsize(shash_tfm));
 		ret = -EINVAL;
 		goto out_free_tfm;
 	}
@@ -370,7 +370,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2482a0db2504..3ef6bc655661 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -728,6 +728,18 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	NULL,
 };
 
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
+{
+	struct config_item *ns_item;
+	char name[12];
+
+	snprintf(name, sizeof(name), "%u", nsid);
+	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	ns_item = config_group_find_item(&subsys->namespaces_group, name);
+	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	return ns_item != NULL;
+}
+
 static void nvmet_ns_release(struct config_item *item)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8658e9c08534..7a6b3d37cca7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -425,10 +425,13 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
-	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
+	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		if (nvmet_subsys_nsid_exists(subsys, nsid))
+			return NVME_SC_INTERNAL_PATH_ERROR;
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..477416abf85a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,6 +542,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c8655fc5aa5b..8d4531a1606d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,6 +348,7 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+/* If cmd buffers are NULL, no operation is performed */
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
 	kfree(cmd->iov);
@@ -1580,13 +1581,9 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
 
-	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_free_cmd_buffers(cmd);
-	}
-
-	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-		nvmet_tcp_free_cmd_buffers(&queue->connect);
+	for (i = 0; i < queue->nr_cmds; i++, cmd++)
+		nvmet_tcp_free_cmd_buffers(cmd);
+	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
diff --git a/drivers/of/module.c b/drivers/of/module.c
index f58e624953a2..780fd82a7ecc 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -29,14 +29,15 @@ ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
 			 of_node_get_device_type(np));
 	tsize = csize;
+	if (csize >= len)
+		csize = len > 0 ? len - 1 : 0;
 	len -= csize;
-	if (str)
-		str += csize;
+	str += csize;
 
 	of_property_for_each_string(np, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
-		if (csize > len)
+		if (csize >= len)
 			continue;
 
 		csize = snprintf(str, len, "C%s", compat);
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index b90ba8aca3fa..ec4d5fc30781 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -337,15 +337,27 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
 			return false;
 
 		for (num = 0; num < counters; num++) {
+			/*
+			 * If we find a related event, then it's a valid group
+			 * since we don't need to allocate a new counter for it.
+			 */
 			if (hisi_pcie_pmu_cmp_event(event_group[num], sibling))
 				break;
 		}
 
+		/*
+		 * Otherwise it's a new event but if there's no available counter,
+		 * fail the check since we cannot schedule all the events in
+		 * the group simultaneously.
+		 */
+		if (num == HISI_PCIE_MAX_COUNTERS)
+			return false;
+
 		if (num == counters)
 			event_group[counters++] = sibling;
 	}
 
-	return counters <= HISI_PCIE_MAX_COUNTERS;
+	return true;
 }
 
 static int hisi_pcie_pmu_event_init(struct perf_event *event)
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 16869bf5bf4c..60062eaa342a 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1085,15 +1085,27 @@ static bool hns3_pmu_validate_event_group(struct perf_event *event)
 			return false;
 
 		for (num = 0; num < counters; num++) {
+			/*
+			 * If we find a related event, then it's a valid group
+			 * since we don't need to allocate a new counter for it.
+			 */
 			if (hns3_pmu_cmp_event(event_group[num], sibling))
 				break;
 		}
 
+		/*
+		 * Otherwise it's a new event but if there's no available counter,
+		 * fail the check since we cannot schedule all the events in
+		 * the group simultaneously.
+		 */
+		if (num == HNS3_PMU_MAX_HW_EVENTS)
+			return false;
+
 		if (num == counters)
 			event_group[counters++] = sibling;
 	}
 
-	return counters <= HNS3_PMU_MAX_HW_EVENTS;
+	return true;
 }
 
 static u32 hns3_pmu_get_filter_condition(struct perf_event *event)
@@ -1515,7 +1527,7 @@ static int hns3_pmu_irq_register(struct pci_dev *pdev,
 		return ret;
 	}
 
-	ret = devm_add_action(&pdev->dev, hns3_pmu_free_irq, pdev);
+	ret = devm_add_action_or_reset(&pdev->dev, hns3_pmu_free_irq, pdev);
 	if (ret) {
 		pci_err(pdev, "failed to add free irq action, ret = %d.\n", ret);
 		return ret;
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 30951f7131cd..1accdaaf282c 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -721,6 +721,7 @@ static struct miscdevice isst_if_char_driver = {
 static const struct x86_cpu_id hpm_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
 };
diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
index 54a2546bb93b..be80f0bda948 100644
--- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -2,8 +2,10 @@
 /* WMI driver for Xiaomi Laptops */
 
 #include <linux/acpi.h>
+#include <linux/device.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/wmi.h>
 
 #include <uapi/linux/input-event-codes.h>
@@ -20,12 +22,21 @@
 
 struct xiaomi_wmi {
 	struct input_dev *input_dev;
+	struct mutex key_lock;	/* Protects the key event sequence */
 	unsigned int key_code;
 };
 
+static void xiaomi_mutex_destroy(void *data)
+{
+	struct mutex *lock = data;
+
+	mutex_destroy(lock);
+}
+
 static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct xiaomi_wmi *data;
+	int ret;
 
 	if (wdev == NULL || context == NULL)
 		return -EINVAL;
@@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 		return -ENOMEM;
 	dev_set_drvdata(&wdev->dev, data);
 
+	mutex_init(&data->key_lock);
+	ret = devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data->key_lock);
+	if (ret < 0)
+		return ret;
+
 	data->input_dev = devm_input_allocate_device(&wdev->dev);
 	if (data->input_dev == NULL)
 		return -ENOMEM;
@@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
 	if (data == NULL)
 		return;
 
+	mutex_lock(&data->key_lock);
 	input_report_key(data->input_dev, data->key_code, 1);
 	input_sync(data->input_dev);
 	input_report_key(data->input_dev, data->key_code, 0);
 	input_sync(data->input_dev);
+	mutex_unlock(&data->key_lock);
 }
 
 static const struct wmi_device_id xiaomi_wmi_id_table[] = {
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 5f858e426bbd..05b8f325a887 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4277,7 +4277,7 @@ static int ptp_ocp_dpll_direction_set(const struct dpll_pin *pin,
 		return -EOPNOTSUPP;
 	mode = direction == DPLL_PIN_DIRECTION_INPUT ?
 			    SMA_MODE_IN : SMA_MODE_OUT;
-	return ptp_ocp_sma_store_val(bp, 0, mode, sma_nr);
+	return ptp_ocp_sma_store_val(bp, 0, mode, sma_nr + 1);
 }
 
 static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
@@ -4298,7 +4298,7 @@ static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
 	tbl = bp->sma_op->tbl[sma->mode];
 	for (i = 0; tbl[i].name; i++)
 		if (tbl[i].frequency == frequency)
-			return ptp_ocp_sma_store_val(bp, i, sma->mode, sma_nr);
+			return ptp_ocp_sma_store_val(bp, i, sma->mode, sma_nr + 1);
 	return -EINVAL;
 }
 
@@ -4315,7 +4315,7 @@ static int ptp_ocp_dpll_frequency_get(const struct dpll_pin *pin,
 	u32 val;
 	int i;
 
-	val = bp->sma_op->get(bp, sma_nr);
+	val = bp->sma_op->get(bp, sma_nr + 1);
 	tbl = bp->sma_op->tbl[sma->mode];
 	for (i = 0; tbl[i].name; i++)
 		if (val == tbl[i].value) {
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f2728ee787d7..9d2dc5e1c8aa 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -24,277 +24,358 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
-static DEFINE_MUTEX(pwm_lookup_lock);
-static LIST_HEAD(pwm_lookup_list);
-
 /* protects access to pwm_chips */
 static DEFINE_MUTEX(pwm_lock);
 
 static DEFINE_IDR(pwm_chips);
 
-static struct pwm_chip *pwmchip_find_by_name(const char *name)
+static void pwm_apply_debug(struct pwm_device *pwm,
+			    const struct pwm_state *state)
 {
-	struct pwm_chip *chip;
-	unsigned long id, tmp;
-
-	if (!name)
-		return NULL;
-
-	mutex_lock(&pwm_lock);
+	struct pwm_state *last = &pwm->last;
+	struct pwm_chip *chip = pwm->chip;
+	struct pwm_state s1 = { 0 }, s2 = { 0 };
+	int err;
 
-	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
-		const char *chip_name = dev_name(chip->dev);
+	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
+		return;
 
-		if (chip_name && strcmp(chip_name, name) == 0) {
-			mutex_unlock(&pwm_lock);
-			return chip;
-		}
-	}
+	/* No reasonable diagnosis possible without .get_state() */
+	if (!chip->ops->get_state)
+		return;
 
-	mutex_unlock(&pwm_lock);
+	/*
+	 * *state was just applied. Read out the hardware state and do some
+	 * checks.
+	 */
 
-	return NULL;
-}
+	err = chip->ops->get_state(chip, pwm, &s1);
+	trace_pwm_get(pwm, &s1, err);
+	if (err)
+		/* If that failed there isn't much to debug */
+		return;
 
-static int pwm_device_request(struct pwm_device *pwm, const char *label)
-{
-	int err;
-	struct pwm_chip *chip = pwm->chip;
-	const struct pwm_ops *ops = chip->ops;
+	/*
+	 * The lowlevel driver either ignored .polarity (which is a bug) or as
+	 * best effort inverted .polarity and fixed .duty_cycle respectively.
+	 * Undo this inversion and fixup for further tests.
+	 */
+	if (s1.enabled && s1.polarity != state->polarity) {
+		s2.polarity = state->polarity;
+		s2.duty_cycle = s1.period - s1.duty_cycle;
+		s2.period = s1.period;
+		s2.enabled = s1.enabled;
+	} else {
+		s2 = s1;
+	}
 
-	if (test_bit(PWMF_REQUESTED, &pwm->flags))
-		return -EBUSY;
+	if (s2.polarity != state->polarity &&
+	    state->duty_cycle < state->period)
+		dev_warn(pwmchip_parent(chip), ".apply ignored .polarity\n");
 
-	if (!try_module_get(chip->owner))
-		return -ENODEV;
+	if (state->enabled &&
+	    last->polarity == state->polarity &&
+	    last->period > s2.period &&
+	    last->period <= state->period)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
+			 state->period, s2.period, last->period);
 
-	if (ops->request) {
-		err = ops->request(chip, pwm);
-		if (err) {
-			module_put(chip->owner);
-			return err;
-		}
-	}
+	if (state->enabled && state->period < s2.period)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
+			 state->period, s2.period);
 
-	if (ops->get_state) {
-		/*
-		 * Zero-initialize state because most drivers are unaware of
-		 * .usage_power. The other members of state are supposed to be
-		 * set by lowlevel drivers. We still initialize the whole
-		 * structure for simplicity even though this might paper over
-		 * faulty implementations of .get_state().
-		 */
-		struct pwm_state state = { 0, };
+	if (state->enabled &&
+	    last->polarity == state->polarity &&
+	    last->period == s2.period &&
+	    last->duty_cycle > s2.duty_cycle &&
+	    last->duty_cycle <= state->duty_cycle)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply didn't pick the best available duty cycle (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
+			 state->duty_cycle, state->period,
+			 s2.duty_cycle, s2.period,
+			 last->duty_cycle, last->period);
 
-		err = ops->get_state(chip, pwm, &state);
-		trace_pwm_get(pwm, &state, err);
+	if (state->enabled && state->duty_cycle < s2.duty_cycle)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
+			 state->duty_cycle, state->period,
+			 s2.duty_cycle, s2.period);
 
-		if (!err)
-			pwm->state = state;
+	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
+		dev_warn(pwmchip_parent(chip),
+			 "requested disabled, but yielded enabled with duty > 0\n");
 
-		if (IS_ENABLED(CONFIG_PWM_DEBUG))
-			pwm->last = pwm->state;
+	/* reapply the state that the driver reported being configured. */
+	err = chip->ops->apply(chip, pwm, &s1);
+	trace_pwm_apply(pwm, &s1, err);
+	if (err) {
+		*last = s1;
+		dev_err(pwmchip_parent(chip), "failed to reapply current setting\n");
+		return;
 	}
 
-	set_bit(PWMF_REQUESTED, &pwm->flags);
-	pwm->label = label;
+	*last = (struct pwm_state){ 0 };
+	err = chip->ops->get_state(chip, pwm, last);
+	trace_pwm_get(pwm, last, err);
+	if (err)
+		return;
 
-	return 0;
+	/* reapplication of the current state should give an exact match */
+	if (s1.enabled != last->enabled ||
+	    s1.polarity != last->polarity ||
+	    (s1.enabled && s1.period != last->period) ||
+	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
+		dev_err(pwmchip_parent(chip),
+			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
+			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
+			last->enabled, last->polarity, last->duty_cycle,
+			last->period);
+	}
 }
 
-struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
+/**
+ * __pwm_apply() - atomically apply a new state to a PWM device
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 {
-	struct pwm_device *pwm;
+	struct pwm_chip *chip;
+	int err;
 
-	if (chip->of_pwm_n_cells < 2)
-		return ERR_PTR(-EINVAL);
+	if (!pwm || !state || !state->period ||
+	    state->duty_cycle > state->period)
+		return -EINVAL;
 
-	/* flags in the third cell are optional */
-	if (args->args_count < 2)
-		return ERR_PTR(-EINVAL);
+	chip = pwm->chip;
 
-	if (args->args[0] >= chip->npwm)
-		return ERR_PTR(-EINVAL);
+	if (state->period == pwm->state.period &&
+	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->polarity == pwm->state.polarity &&
+	    state->enabled == pwm->state.enabled &&
+	    state->usage_power == pwm->state.usage_power)
+		return 0;
 
-	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
+	err = chip->ops->apply(chip, pwm, state);
+	trace_pwm_apply(pwm, state, err);
+	if (err)
+		return err;
 
-	pwm->args.period = args->args[1];
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	pwm->state = *state;
 
-	if (chip->of_pwm_n_cells >= 3) {
-		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-			pwm->args.polarity = PWM_POLARITY_INVERSED;
-	}
+	/*
+	 * only do this after pwm->state was applied as some
+	 * implementations of .get_state depend on this
+	 */
+	pwm_apply_debug(pwm, state);
 
-	return pwm;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
-struct pwm_device *
-of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
+/**
+ * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 {
-	struct pwm_device *pwm;
-
-	if (chip->of_pwm_n_cells < 1)
-		return ERR_PTR(-EINVAL);
+	int err;
 
-	/* validate that one cell is specified, optionally with flags */
-	if (args->args_count != 1 && args->args_count != 2)
-		return ERR_PTR(-EINVAL);
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_might_sleep() from atomic context
+	 * is a bad idea. So make it explicit that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
 
-	pwm = pwm_request_from_chip(chip, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		err = __pwm_apply(pwm, state);
+		non_block_end();
+	} else {
+		err = __pwm_apply(pwm, state);
+	}
 
-	pwm->args.period = args->args[0];
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
-	if (args->args_count == 2 && args->args[1] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+/**
+ * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
+ * Not all PWM devices support this function, check with pwm_might_sleep().
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	WARN_ONCE(!pwm->chip->atomic,
+		  "sleeping PWM driver used in atomic context\n");
 
-	return pwm;
+	return __pwm_apply(pwm, state);
 }
-EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
-static void of_pwmchip_add(struct pwm_chip *chip)
+/**
+ * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
+ * @pwm: PWM device
+ *
+ * This function will adjust the PWM config to the PWM arguments provided
+ * by the DT or PWM lookup table. This is particularly useful to adapt
+ * the bootloader config to the Linux one.
+ */
+int pwm_adjust_config(struct pwm_device *pwm)
 {
-	if (!chip->dev || !chip->dev->of_node)
-		return;
+	struct pwm_state state;
+	struct pwm_args pargs;
 
-	if (!chip->of_xlate) {
-		u32 pwm_cells;
+	pwm_get_args(pwm, &pargs);
+	pwm_get_state(pwm, &state);
 
-		if (of_property_read_u32(chip->dev->of_node, "#pwm-cells",
-					 &pwm_cells))
-			pwm_cells = 2;
+	/*
+	 * If the current period is zero it means that either the PWM driver
+	 * does not support initial state retrieval or the PWM has not yet
+	 * been configured.
+	 *
+	 * In either case, we setup the new period and polarity, and assign a
+	 * duty cycle of 0.
+	 */
+	if (!state.period) {
+		state.duty_cycle = 0;
+		state.period = pargs.period;
+		state.polarity = pargs.polarity;
 
-		chip->of_xlate = of_pwm_xlate_with_flags;
-		chip->of_pwm_n_cells = pwm_cells;
+		return pwm_apply_might_sleep(pwm, &state);
 	}
 
-	of_node_get(chip->dev->of_node);
-}
-
-static void of_pwmchip_remove(struct pwm_chip *chip)
-{
-	if (chip->dev)
-		of_node_put(chip->dev->of_node);
-}
-
-static bool pwm_ops_check(const struct pwm_chip *chip)
-{
-	const struct pwm_ops *ops = chip->ops;
-
-	if (!ops->apply)
-		return false;
+	/*
+	 * Adjust the PWM duty cycle/period based on the period value provided
+	 * in PWM args.
+	 */
+	if (pargs.period != state.period) {
+		u64 dutycycle = (u64)state.duty_cycle * pargs.period;
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
-		dev_warn(chip->dev,
-			 "Please implement the .get_state() callback\n");
+		do_div(dutycycle, state.period);
+		state.duty_cycle = dutycycle;
+		state.period = pargs.period;
+	}
 
-	return true;
+	/*
+	 * If the polarity changed, we should also change the duty cycle.
+	 */
+	if (pargs.polarity != state.polarity) {
+		state.polarity = pargs.polarity;
+		state.duty_cycle = state.period - state.duty_cycle;
+	}
+
+	return pwm_apply_might_sleep(pwm, &state);
 }
+EXPORT_SYMBOL_GPL(pwm_adjust_config);
 
 /**
- * __pwmchip_add() - register a new PWM chip
- * @chip: the PWM chip to add
- * @owner: reference to the module providing the chip.
- *
- * Register a new PWM chip. @owner is supposed to be THIS_MODULE, use the
- * pwmchip_add wrapper to do this right.
+ * pwm_capture() - capture and report a PWM signal
+ * @pwm: PWM device
+ * @result: structure to fill with capture result
+ * @timeout: time to wait, in milliseconds, before giving up on capture
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
+int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
+		unsigned long timeout)
 {
-	unsigned int i;
-	int ret;
+	int err;
 
-	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
+	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
 
-	if (!pwm_ops_check(chip))
-		return -EINVAL;
+	if (!pwm->chip->ops->capture)
+		return -ENOSYS;
 
-	chip->owner = owner;
+	mutex_lock(&pwm_lock);
+	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	mutex_unlock(&pwm_lock);
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_capture);
 
-	mutex_lock(&pwm_lock);
+static struct pwm_chip *pwmchip_find_by_name(const char *name)
+{
+	struct pwm_chip *chip;
+	unsigned long id, tmp;
 
-	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
-		return ret;
-	}
+	if (!name)
+		return NULL;
 
-	chip->id = ret;
+	mutex_lock(&pwm_lock);
 
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
+	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
+		const char *chip_name = dev_name(pwmchip_parent(chip));
 
-		pwm->chip = chip;
-		pwm->hwpwm = i;
+		if (chip_name && strcmp(chip_name, name) == 0) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
 	}
 
 	mutex_unlock(&pwm_lock);
 
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_add(chip);
-
-	pwmchip_sysfs_export(chip);
-
-	return 0;
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(__pwmchip_add);
 
-/**
- * pwmchip_remove() - remove a PWM chip
- * @chip: the PWM chip to remove
- *
- * Removes a PWM chip.
- */
-void pwmchip_remove(struct pwm_chip *chip)
+static int pwm_device_request(struct pwm_device *pwm, const char *label)
 {
-	pwmchip_sysfs_unexport(chip);
-
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
+	int err;
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
 
-	mutex_lock(&pwm_lock);
+	if (test_bit(PWMF_REQUESTED, &pwm->flags))
+		return -EBUSY;
 
-	idr_remove(&pwm_chips, chip->id);
+	if (!try_module_get(chip->owner))
+		return -ENODEV;
 
-	mutex_unlock(&pwm_lock);
+	if (ops->request) {
+		err = ops->request(chip, pwm);
+		if (err) {
+			module_put(chip->owner);
+			return err;
+		}
+	}
 
-	kfree(chip->pwms);
-}
-EXPORT_SYMBOL_GPL(pwmchip_remove);
+	if (ops->get_state) {
+		/*
+		 * Zero-initialize state because most drivers are unaware of
+		 * .usage_power. The other members of state are supposed to be
+		 * set by lowlevel drivers. We still initialize the whole
+		 * structure for simplicity even though this might paper over
+		 * faulty implementations of .get_state().
+		 */
+		struct pwm_state state = { 0, };
 
-static void devm_pwmchip_remove(void *data)
-{
-	struct pwm_chip *chip = data;
+		err = ops->get_state(chip, pwm, &state);
+		trace_pwm_get(pwm, &state, err);
 
-	pwmchip_remove(chip);
-}
+		if (!err)
+			pwm->state = state;
 
-int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner)
-{
-	int ret;
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
+			pwm->last = pwm->state;
+	}
 
-	ret = __pwmchip_add(chip, owner);
-	if (ret)
-		return ret;
+	set_bit(PWMF_REQUESTED, &pwm->flags);
+	pwm->label = label;
 
-	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(__devm_pwmchip_add);
 
 /**
  * pwm_request_from_chip() - request a PWM device relative to a PWM chip
@@ -328,301 +409,179 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 }
 EXPORT_SYMBOL_GPL(pwm_request_from_chip);
 
-static void pwm_apply_debug(struct pwm_device *pwm,
-			    const struct pwm_state *state)
-{
-	struct pwm_state *last = &pwm->last;
-	struct pwm_chip *chip = pwm->chip;
-	struct pwm_state s1 = { 0 }, s2 = { 0 };
-	int err;
-
-	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
-		return;
-
-	/* No reasonable diagnosis possible without .get_state() */
-	if (!chip->ops->get_state)
-		return;
-
-	/*
-	 * *state was just applied. Read out the hardware state and do some
-	 * checks.
-	 */
-
-	err = chip->ops->get_state(chip, pwm, &s1);
-	trace_pwm_get(pwm, &s1, err);
-	if (err)
-		/* If that failed there isn't much to debug */
-		return;
-
-	/*
-	 * The lowlevel driver either ignored .polarity (which is a bug) or as
-	 * best effort inverted .polarity and fixed .duty_cycle respectively.
-	 * Undo this inversion and fixup for further tests.
-	 */
-	if (s1.enabled && s1.polarity != state->polarity) {
-		s2.polarity = state->polarity;
-		s2.duty_cycle = s1.period - s1.duty_cycle;
-		s2.period = s1.period;
-		s2.enabled = s1.enabled;
-	} else {
-		s2 = s1;
-	}
-
-	if (s2.polarity != state->polarity &&
-	    state->duty_cycle < state->period)
-		dev_warn(chip->dev, ".apply ignored .polarity\n");
-
-	if (state->enabled &&
-	    last->polarity == state->polarity &&
-	    last->period > s2.period &&
-	    last->period <= state->period)
-		dev_warn(chip->dev,
-			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
-			 state->period, s2.period, last->period);
-
-	if (state->enabled && state->period < s2.period)
-		dev_warn(chip->dev,
-			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
-			 state->period, s2.period);
-
-	if (state->enabled &&
-	    last->polarity == state->polarity &&
-	    last->period == s2.period &&
-	    last->duty_cycle > s2.duty_cycle &&
-	    last->duty_cycle <= state->duty_cycle)
-		dev_warn(chip->dev,
-			 ".apply didn't pick the best available duty cycle (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
-			 state->duty_cycle, state->period,
-			 s2.duty_cycle, s2.period,
-			 last->duty_cycle, last->period);
-
-	if (state->enabled && state->duty_cycle < s2.duty_cycle)
-		dev_warn(chip->dev,
-			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
-			 state->duty_cycle, state->period,
-			 s2.duty_cycle, s2.period);
-
-	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
-		dev_warn(chip->dev,
-			 "requested disabled, but yielded enabled with duty > 0\n");
-
-	/* reapply the state that the driver reported being configured. */
-	err = chip->ops->apply(chip, pwm, &s1);
-	trace_pwm_apply(pwm, &s1, err);
-	if (err) {
-		*last = s1;
-		dev_err(chip->dev, "failed to reapply current setting\n");
-		return;
-	}
-
-	*last = (struct pwm_state){ 0 };
-	err = chip->ops->get_state(chip, pwm, last);
-	trace_pwm_get(pwm, last, err);
-	if (err)
-		return;
-
-	/* reapplication of the current state should give an exact match */
-	if (s1.enabled != last->enabled ||
-	    s1.polarity != last->polarity ||
-	    (s1.enabled && s1.period != last->period) ||
-	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
-		dev_err(chip->dev,
-			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
-			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
-			last->enabled, last->polarity, last->duty_cycle,
-			last->period);
-	}
-}
 
-/**
- * __pwm_apply() - atomically apply a new state to a PWM device
- * @pwm: PWM device
- * @state: new state to apply
- */
-static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
+struct pwm_device *
+of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
-	struct pwm_chip *chip;
-	int err;
+	struct pwm_device *pwm;
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
-		return -EINVAL;
+	/* period in the second cell and flags in the third cell are optional */
+	if (args->args_count < 1)
+		return ERR_PTR(-EINVAL);
 
-	chip = pwm->chip;
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
 
-	if (state->period == pwm->state.period &&
-	    state->duty_cycle == pwm->state.duty_cycle &&
-	    state->polarity == pwm->state.polarity &&
-	    state->enabled == pwm->state.enabled &&
-	    state->usage_power == pwm->state.usage_power)
-		return 0;
+	if (args->args_count > 1)
+		pwm->args.period = args->args[1];
 
-	err = chip->ops->apply(chip, pwm, state);
-	trace_pwm_apply(pwm, state, err);
-	if (err)
-		return err;
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
 
-	pwm->state = *state;
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
-	/*
-	 * only do this after pwm->state was applied as some
-	 * implementations of .get_state depend on this
-	 */
-	pwm_apply_debug(pwm, state);
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
 
-	return 0;
+	pwm = pwm_request_from_chip(chip, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	if (args->args_count > 0)
+		pwm->args.period = args->args[0];
+
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
 }
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
-/**
- * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
- * Cannot be used in atomic context.
- * @pwm: PWM device
- * @state: new state to apply
- */
-int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+static void of_pwmchip_add(struct pwm_chip *chip)
 {
-	int err;
+	if (!pwmchip_parent(chip) || !pwmchip_parent(chip)->of_node)
+		return;
 
-	/*
-	 * Some lowlevel driver's implementations of .apply() make use of
-	 * mutexes, also with some drivers only returning when the new
-	 * configuration is active calling pwm_apply_might_sleep() from atomic context
-	 * is a bad idea. So make it explicit that calling this function might
-	 * sleep.
-	 */
-	might_sleep();
+	if (!chip->of_xlate)
+		chip->of_xlate = of_pwm_xlate_with_flags;
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
-		/*
-		 * Catch any drivers that have been marked as atomic but
-		 * that will sleep anyway.
-		 */
-		non_block_start();
-		err = __pwm_apply(pwm, state);
-		non_block_end();
-	} else {
-		err = __pwm_apply(pwm, state);
-	}
+	of_node_get(pwmchip_parent(chip)->of_node);
+}
 
-	return err;
+static void of_pwmchip_remove(struct pwm_chip *chip)
+{
+	if (pwmchip_parent(chip))
+		of_node_put(pwmchip_parent(chip)->of_node);
 }
-EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
-/**
- * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
- * Not all PWM devices support this function, check with pwm_might_sleep().
- * @pwm: PWM device
- * @state: new state to apply
- */
-int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
+static bool pwm_ops_check(const struct pwm_chip *chip)
 {
-	WARN_ONCE(!pwm->chip->atomic,
-		  "sleeping PWM driver used in atomic context\n");
+	const struct pwm_ops *ops = chip->ops;
 
-	return __pwm_apply(pwm, state);
+	if (!ops->apply)
+		return false;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
+		dev_warn(pwmchip_parent(chip),
+			 "Please implement the .get_state() callback\n");
+
+	return true;
 }
-EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
 /**
- * pwm_capture() - capture and report a PWM signal
- * @pwm: PWM device
- * @result: structure to fill with capture result
- * @timeout: time to wait, in milliseconds, before giving up on capture
+ * __pwmchip_add() - register a new PWM chip
+ * @chip: the PWM chip to add
+ * @owner: reference to the module providing the chip.
+ *
+ * Register a new PWM chip. @owner is supposed to be THIS_MODULE, use the
+ * pwmchip_add wrapper to do this right.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
-		unsigned long timeout)
+int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	int err;
+	unsigned int i;
+	int ret;
 
-	if (!pwm || !pwm->chip->ops)
+	if (!chip || !pwmchip_parent(chip) || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
-	if (!pwm->chip->ops->capture)
-		return -ENOSYS;
+	if (!pwm_ops_check(chip))
+		return -EINVAL;
+
+	chip->owner = owner;
+
+	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
+	if (!chip->pwms)
+		return -ENOMEM;
 
 	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+
+	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
+		mutex_unlock(&pwm_lock);
+		kfree(chip->pwms);
+		return ret;
+	}
+
+	chip->id = ret;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	mutex_unlock(&pwm_lock);
 
-	return err;
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_add(chip);
+
+	pwmchip_sysfs_export(chip);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pwm_capture);
+EXPORT_SYMBOL_GPL(__pwmchip_add);
 
 /**
- * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
- * @pwm: PWM device
+ * pwmchip_remove() - remove a PWM chip
+ * @chip: the PWM chip to remove
  *
- * This function will adjust the PWM config to the PWM arguments provided
- * by the DT or PWM lookup table. This is particularly useful to adapt
- * the bootloader config to the Linux one.
+ * Removes a PWM chip.
  */
-int pwm_adjust_config(struct pwm_device *pwm)
+void pwmchip_remove(struct pwm_chip *chip)
 {
-	struct pwm_state state;
-	struct pwm_args pargs;
-
-	pwm_get_args(pwm, &pargs);
-	pwm_get_state(pwm, &state);
-
-	/*
-	 * If the current period is zero it means that either the PWM driver
-	 * does not support initial state retrieval or the PWM has not yet
-	 * been configured.
-	 *
-	 * In either case, we setup the new period and polarity, and assign a
-	 * duty cycle of 0.
-	 */
-	if (!state.period) {
-		state.duty_cycle = 0;
-		state.period = pargs.period;
-		state.polarity = pargs.polarity;
+	pwmchip_sysfs_unexport(chip);
 
-		return pwm_apply_might_sleep(pwm, &state);
-	}
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
 
-	/*
-	 * Adjust the PWM duty cycle/period based on the period value provided
-	 * in PWM args.
-	 */
-	if (pargs.period != state.period) {
-		u64 dutycycle = (u64)state.duty_cycle * pargs.period;
+	mutex_lock(&pwm_lock);
 
-		do_div(dutycycle, state.period);
-		state.duty_cycle = dutycycle;
-		state.period = pargs.period;
-	}
+	idr_remove(&pwm_chips, chip->id);
 
-	/*
-	 * If the polarity changed, we should also change the duty cycle.
-	 */
-	if (pargs.polarity != state.polarity) {
-		state.polarity = pargs.polarity;
-		state.duty_cycle = state.period - state.duty_cycle;
-	}
+	mutex_unlock(&pwm_lock);
 
-	return pwm_apply_might_sleep(pwm, &state);
+	kfree(chip->pwms);
 }
-EXPORT_SYMBOL_GPL(pwm_adjust_config);
+EXPORT_SYMBOL_GPL(pwmchip_remove);
 
-static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
+static void devm_pwmchip_remove(void *data)
 {
-	struct pwm_chip *chip;
-	unsigned long id, tmp;
+	struct pwm_chip *chip = data;
 
-	mutex_lock(&pwm_lock);
+	pwmchip_remove(chip);
+}
 
-	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
-		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
-			mutex_unlock(&pwm_lock);
-			return chip;
-		}
+int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner)
+{
+	int ret;
 
-	mutex_unlock(&pwm_lock);
+	ret = __pwmchip_add(chip, owner);
+	if (ret)
+		return ret;
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
 }
+EXPORT_SYMBOL_GPL(__devm_pwmchip_add);
 
 static struct device_link *pwm_device_link_add(struct device *dev,
 					       struct pwm_device *pwm)
@@ -635,21 +594,39 @@ static struct device_link *pwm_device_link_add(struct device *dev,
 		 * impact the PM sequence ordering: the PWM supplier may get
 		 * suspended before the consumer.
 		 */
-		dev_warn(pwm->chip->dev,
+		dev_warn(pwmchip_parent(pwm->chip),
 			 "No consumer device specified to create a link to\n");
 		return NULL;
 	}
 
-	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	dl = device_link_add(dev, pwmchip_parent(pwm->chip), DL_FLAG_AUTOREMOVE_CONSUMER);
 	if (!dl) {
 		dev_err(dev, "failed to create device link to %s\n",
-			dev_name(pwm->chip->dev));
+			dev_name(pwmchip_parent(pwm->chip)));
 		return ERR_PTR(-EINVAL);
 	}
 
 	return dl;
 }
 
+static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
+{
+	struct pwm_chip *chip;
+	unsigned long id, tmp;
+
+	mutex_lock(&pwm_lock);
+
+	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
+		if (pwmchip_parent(chip) && device_match_fwnode(pwmchip_parent(chip), fwnode)) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+
+	mutex_unlock(&pwm_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
 /**
  * of_pwm_get() - request a PWM via the PWM framework
  * @dev: device for PWM consumer
@@ -784,6 +761,9 @@ static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 	return pwm;
 }
 
+static DEFINE_MUTEX(pwm_lookup_lock);
+static LIST_HEAD(pwm_lookup_list);
+
 /**
  * pwm_add_table() - register PWM device consumers
  * @table: array of consumers to register
@@ -1105,8 +1085,8 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 
 	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
 		   (char *)s->private, chip->id,
-		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
-		   dev_name(chip->dev), chip->npwm,
+		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus",
+		   dev_name(pwmchip_parent(chip)), chip->npwm,
 		   (chip->npwm != 1) ? "s" : "");
 
 	pwm_dbg_show(chip, s);
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 42179b3f7ec3..06562d4bb963 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -103,7 +103,6 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	priv->chip.dev = &pdev->dev;
 	priv->chip.npwm = 2;
 	priv->chip.of_xlate = clps711x_pwm_xlate;
-	priv->chip.of_pwm_n_cells = 1;
 
 	spin_lock_init(&priv->lock);
 
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 5fe303b8656d..339cedf3a7b1 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -279,7 +279,6 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip->dev = dev;
 	chip->ops = &cros_ec_pwm_ops;
 	chip->of_xlate = cros_ec_pwm_xlate;
-	chip->of_pwm_n_cells = 1;
 
 	if (ec_pwm->use_pwm_type) {
 		chip->npwm = CROS_EC_PWM_DT_COUNT;
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2971bbf3b5e7..52ac3277f420 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -122,7 +122,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	err = clk_prepare_enable(channel->clk);
@@ -143,12 +143,13 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(channel->clk);
 }
 
-static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
+static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	unsigned int cnt, duty_cnt;
-	unsigned long fin_freq;
+	long fin_freq;
 	u64 duty, period, freq;
 
 	duty = state->duty_cycle;
@@ -168,20 +169,21 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		freq = ULONG_MAX;
 
 	fin_freq = clk_round_rate(channel->clk, freq);
-	if (fin_freq == 0) {
-		dev_err(meson->chip.dev, "invalid source clock frequency\n");
-		return -EINVAL;
+	if (fin_freq <= 0) {
+		dev_err(pwmchip_parent(chip),
+			"invalid source clock frequency %llu\n", freq);
+		return fin_freq ? fin_freq : -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(pwmchip_parent(chip), "fin_freq: %ld Hz\n", fin_freq);
 
-	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
+	cnt = mul_u64_u64_div_u64(fin_freq, period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		dev_err(pwmchip_parent(chip), "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(pwmchip_parent(chip), "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -190,9 +192,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->hi = 0;
 		channel->lo = cnt;
 	} else {
-		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
+		duty_cnt = mul_u64_u64_div_u64(fin_freq, duty, NSEC_PER_SEC);
 
-		dev_dbg(meson->chip.dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(pwmchip_parent(chip), "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
@@ -203,8 +205,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	return 0;
 }
 
-static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
+static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
@@ -215,7 +218,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 
 	err = clk_set_rate(channel->clk, channel->rate);
 	if (err)
-		dev_err(meson->chip.dev, "setting clock rate failed\n");
+		dev_err(pwmchip_parent(chip), "setting clock rate failed\n");
 
 	spin_lock_irqsave(&meson->lock, flags);
 
@@ -230,8 +233,9 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
-static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
+static void meson_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	unsigned long flags;
 	u32 value;
 
@@ -269,16 +273,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			channel->hi = ~0;
 			channel->lo = 0;
 
-			meson_pwm_enable(meson, pwm);
+			meson_pwm_enable(chip, pwm);
 		} else {
-			meson_pwm_disable(meson, pwm);
+			meson_pwm_disable(chip, pwm);
 		}
 	} else {
-		err = meson_pwm_calc(meson, pwm, state);
+		err = meson_pwm_calc(chip, pwm, state);
 		if (err < 0)
 			return err;
 
-		meson_pwm_enable(meson, pwm);
+		meson_pwm_enable(chip, pwm);
 	}
 
 	return 0;
@@ -432,10 +436,11 @@ static const struct of_device_id meson_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
-static int meson_pwm_init_channels(struct meson_pwm *meson)
+static int meson_pwm_init_channels(struct pwm_chip *chip)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
-	struct device *dev = meson->chip.dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int i;
 	char name[255];
 	int err;
@@ -445,7 +450,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
 
-	for (i = 0; i < meson->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
@@ -543,7 +548,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(meson);
+	err = meson_pwm_init_channels(&meson->chip);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 76685f926c75..61b74fa1d348 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -180,10 +180,8 @@ static int pwm_probe(struct platform_device *pdev)
 	pc->chip.ops = &pxa_pwm_ops;
 	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
-	if (IS_ENABLED(CONFIG_OF)) {
+	if (IS_ENABLED(CONFIG_OF))
 		pc->chip.of_xlate = of_pwm_single_xlate;
-		pc->chip.of_pwm_n_cells = 1;
-	}
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 69b1113c6b82..f3df7b1895d3 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -570,6 +570,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_pwm_compat_data *cdata;
+	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
 	int irq, ret;
@@ -577,6 +578,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
 		return -ENOMEM;
+	chip = &pc->chip;
 
 	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -622,40 +624,28 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	if (cdata->pwm_num_devs) {
-		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		pc->pwm_clk = devm_clk_get_prepared(dev, "pwm");
 		if (IS_ERR(pc->pwm_clk)) {
 			dev_err(dev, "failed to get PWM clock\n");
 			return PTR_ERR(pc->pwm_clk);
 		}
-
-		ret = clk_prepare(pc->pwm_clk);
-		if (ret) {
-			dev_err(dev, "failed to prepare clock\n");
-			return ret;
-		}
 	}
 
 	if (cdata->cpt_num_devs) {
-		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		pc->cpt_clk = devm_clk_get_prepared(dev, "capture");
 		if (IS_ERR(pc->cpt_clk)) {
 			dev_err(dev, "failed to get PWM capture clock\n");
 			return PTR_ERR(pc->cpt_clk);
 		}
 
-		ret = clk_prepare(pc->cpt_clk);
-		if (ret) {
-			dev_err(dev, "failed to prepare clock\n");
-			return ret;
-		}
-
 		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
 		if (!cdata->ddata)
 			return -ENOMEM;
 	}
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
+	chip->dev = dev;
+	chip->ops = &sti_pwm_ops;
+	chip->npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
@@ -664,26 +654,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, pc);
-
-	return 0;
-}
-
-static void sti_pwm_remove(struct platform_device *pdev)
-{
-	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&pc->chip);
-
-	clk_unprepare(pc->pwm_clk);
-	clk_unprepare(pc->cpt_clk);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
@@ -698,7 +669,6 @@ static struct platform_driver sti_pwm_driver = {
 		.of_match_table = sti_pwm_of_match,
 	},
 	.probe = sti_pwm_probe,
-	.remove_new = sti_pwm_remove,
 };
 module_platform_driver(sti_pwm_driver);
 
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 1698609d91c8..3f434a771fb5 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -509,10 +509,10 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 	 * If device_create() fails the pwm_chip is still usable by
 	 * the kernel it's just not exported.
 	 */
-	parent = device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
+	parent = device_create(&pwm_class, pwmchip_parent(chip), MKDEV(0, 0), chip,
 			       "pwmchip%d", chip->id);
 	if (IS_ERR(parent)) {
-		dev_warn(chip->dev,
+		dev_warn(pwmchip_parent(chip),
 			 "device_create failed for pwm_chip sysfs export\n");
 	}
 }
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index fe7ae0f3f46a..5ab1a0befe12 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,
 
 	h->irq = irq;
 	h->desc = *d;
+	h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return ERR_PTR(-ENOMEM);
 
 	ret = init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);
diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
index 656fe330d38f..063e12c08e75 100644
--- a/drivers/regulator/qcom-refgen-regulator.c
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -140,6 +140,7 @@ static const struct of_device_id qcom_refgen_match_table[] = {
 	{ .compatible = "qcom,sm8250-refgen-regulator", .data = &sm8250_refgen_desc },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, qcom_refgen_match_table);
 
 static struct platform_driver qcom_refgen_driver = {
 	.probe = qcom_refgen_probe,
diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index 086da36abc0b..4955616517ce 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -84,6 +84,7 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
 	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_ipq4019_of_match);
 
 static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
diff --git a/drivers/s390/cio/trace.h b/drivers/s390/cio/trace.h
index 86993de25345..a4c5c6736b31 100644
--- a/drivers/s390/cio/trace.h
+++ b/drivers/s390/cio/trace.h
@@ -50,7 +50,7 @@ DECLARE_EVENT_CLASS(s390_class_schib,
 		__entry->devno = schib->pmcw.dev;
 		__entry->schib = *schib;
 		__entry->pmcw_ena = schib->pmcw.ena;
-		__entry->pmcw_st = schib->pmcw.ena;
+		__entry->pmcw_st = schib->pmcw.st;
 		__entry->pmcw_dnv = schib->pmcw.dnv;
 		__entry->pmcw_dev = schib->pmcw.dev;
 		__entry->pmcw_lpm = schib->pmcw.lpm;
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index 52db147d9979..f6dd077d47c9 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -250,7 +250,7 @@ bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -317,7 +317,7 @@ bfad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..49c57a9c110b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5850,7 +5850,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *));
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index f6e6db8b8aba..e97f4e01a865 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -239,8 +239,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd0..96174353e389 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -170,7 +170,7 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 	if (!count || *ppos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 55ff3d7482b3..a1545dad0c0c 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -274,7 +274,7 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 		seq_printf(s, "Driver: estimate iocb used [%d] high water limit [%d]\n",
 			   iocbs_used, ha->base_qpair->fwres.iocbs_limit);
 
-		seq_printf(s, "estimate exchange used[%d] high water limit [%d] n",
+		seq_printf(s, "estimate exchange used[%d] high water limit [%d]\n",
 			   exch_used, ha->base_qpair->fwres.exch_limit);
 
 		if (ql2xenforce_iocb_limit == 2) {
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..0b2e5690dacf 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -14,7 +14,8 @@
 #define CMDQ_POLL_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_REG_TYPE		1
-#define CMDQ_JUMP_RELATIVE	1
+#define CMDQ_JUMP_RELATIVE	0
+#define CMDQ_JUMP_ABSOLUTE	1
 
 struct cmdq_instruction {
 	union {
@@ -397,7 +398,7 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
 	struct cmdq_instruction inst = {};
 
 	inst.op = CMDQ_CODE_JUMP;
-	inst.offset = CMDQ_JUMP_RELATIVE;
+	inst.offset = CMDQ_JUMP_ABSOLUTE;
 	inst.value = addr >>
 		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
 	return cmdq_pkt_append_command(pkt, inst);
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index f913e9bd57ed..823fd108fa03 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/pdr.h>
 #include <linux/soc/qcom/pmic_glink.h>
+#include <linux/spinlock.h>
 
 enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
@@ -36,7 +37,7 @@ struct pmic_glink {
 	unsigned int pdr_state;
 
 	/* serializing clients list updates */
-	struct mutex client_lock;
+	spinlock_t client_lock;
 	struct list_head clients;
 };
 
@@ -58,10 +59,11 @@ static void _devm_pmic_glink_release_client(struct device *dev, void *res)
 {
 	struct pmic_glink_client *client = (struct pmic_glink_client *)res;
 	struct pmic_glink *pg = client->pg;
+	unsigned long flags;
 
-	mutex_lock(&pg->client_lock);
+	spin_lock_irqsave(&pg->client_lock, flags);
 	list_del(&client->node);
-	mutex_unlock(&pg->client_lock);
+	spin_unlock_irqrestore(&pg->client_lock, flags);
 }
 
 struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
@@ -72,6 +74,7 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 {
 	struct pmic_glink_client *client;
 	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
+	unsigned long flags;
 
 	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
 	if (!client)
@@ -83,9 +86,14 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 	client->pdr_notify = pdr;
 	client->priv = priv;
 
-	mutex_lock(&pg->client_lock);
+	mutex_lock(&pg->state_lock);
+	spin_lock_irqsave(&pg->client_lock, flags);
+
 	list_add(&client->node, &pg->clients);
-	mutex_unlock(&pg->client_lock);
+	client->pdr_notify(client->priv, pg->client_state);
+
+	spin_unlock_irqrestore(&pg->client_lock, flags);
+	mutex_unlock(&pg->state_lock);
 
 	devres_add(dev, client);
 
@@ -107,6 +115,7 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	struct pmic_glink_client *client;
 	struct pmic_glink_hdr *hdr;
 	struct pmic_glink *pg = dev_get_drvdata(&rpdev->dev);
+	unsigned long flags;
 
 	if (len < sizeof(*hdr)) {
 		dev_warn(pg->dev, "ignoring truncated message\n");
@@ -115,10 +124,12 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	hdr = data;
 
+	spin_lock_irqsave(&pg->client_lock, flags);
 	list_for_each_entry(client, &pg->clients, node) {
 		if (client->id == le32_to_cpu(hdr->owner))
 			client->cb(data, len, client->priv);
 	}
+	spin_unlock_irqrestore(&pg->client_lock, flags);
 
 	return 0;
 }
@@ -158,6 +169,7 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 {
 	struct pmic_glink_client *client;
 	unsigned int new_state = pg->client_state;
+	unsigned long flags;
 
 	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {
 		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
@@ -168,8 +180,10 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 	}
 
 	if (new_state != pg->client_state) {
+		spin_lock_irqsave(&pg->client_lock, flags);
 		list_for_each_entry(client, &pg->clients, node)
 			client->pdr_notify(client->priv, new_state);
+		spin_unlock_irqrestore(&pg->client_lock, flags);
 		pg->client_state = new_state;
 	}
 }
@@ -256,7 +270,7 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	pg->dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&pg->clients);
-	mutex_init(&pg->client_lock);
+	spin_lock_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
 	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index f35c90809414..638f08b3f21b 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -4719,6 +4719,7 @@ static int load_video_binaries(struct ia_css_pipe *pipe)
 						  sizeof(struct ia_css_binary),
 						  GFP_KERNEL);
 		if (!mycs->yuv_scaler_binary) {
+			mycs->num_yuv_scaler = 0;
 			err = -ENOMEM;
 			return err;
 		}
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index a587f860101a..323aa70fdeaf 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -162,6 +162,12 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
+
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
 }
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a..4e5c213a8922 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1530,11 +1530,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16ccb44d..4edee8d929a7 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -264,7 +264,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
+			__func__, i, p1[i], p2 ? p2[i] : 0);
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dfaa6341694a..5975bf380826 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -432,7 +432,6 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
-	thermal_debug_update_temp(tz);
 }
 
 static void thermal_zone_device_check(struct work_struct *work)
@@ -476,6 +475,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	for_each_trip(tz, trip)
 		handle_thermal_trip(tz, trip);
 
+	thermal_debug_update_temp(tz);
+
 	monitor_thermal_zone(tz);
 }
 
@@ -898,6 +899,7 @@ __thermal_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
+	unsigned long current_state;
 	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -935,6 +937,10 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (ret)
 		goto out_cdev_type;
 
+	ret = cdev->ops->get_cur_state(cdev, &current_state);
+	if (ret)
+		goto out_cdev_type;
+
 	thermal_cooling_device_setup_sysfs(cdev);
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
@@ -948,6 +954,8 @@ __thermal_cooling_device_register(struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
+	thermal_debug_cdev_add(cdev, current_state);
+
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
 
@@ -963,8 +971,6 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_unlock(&thermal_list_lock);
 
-	thermal_debug_cdev_add(cdev);
-
 	return cdev;
 
 out_cooling_dev:
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 5693cc8b231a..403f74d663dc 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -435,6 +435,14 @@ void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
 	}
 
 	cdev_dbg->current_state = new_state;
+
+	/*
+	 * Create a record for the new state if it is not there, so its
+	 * duration will be printed by cdev_dt_seq_show() as expected if it
+	 * runs before the next state transition.
+	 */
+	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, new_state);
+
 	transition = (old_state << 16) | new_state;
 
 	/*
@@ -460,8 +468,9 @@ void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
  * Allocates a cooling device object for debug, initializes the
  * statistics and create the entries in sysfs.
  * @cdev: a pointer to a cooling device
+ * @state: current state of the cooling device
  */
-void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state)
 {
 	struct thermal_debugfs *thermal_dbg;
 	struct cdev_debugfs *cdev_dbg;
@@ -478,9 +487,16 @@ void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
 		INIT_LIST_HEAD(&cdev_dbg->durations[i]);
 	}
 
-	cdev_dbg->current_state = 0;
+	cdev_dbg->current_state = state;
 	cdev_dbg->timestamp = ktime_get();
 
+	/*
+	 * Create a record for the initial cooling device state, so its
+	 * duration will be printed by cdev_dt_seq_show() as expected if it
+	 * runs before the first state transition.
+	 */
+	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, state);
+
 	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
 			    thermal_dbg, &tt_fops);
 
@@ -555,7 +571,6 @@ void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 	struct tz_episode *tze;
 	struct tz_debugfs *tz_dbg;
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
-	int temperature = tz->temperature;
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	ktime_t now = ktime_get();
 
@@ -624,12 +639,6 @@ void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 
 	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
 	tze->trip_stats[trip_id].timestamp = now;
-	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
-	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
-	tze->trip_stats[trip_id].count++;
-	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
-		(temperature - tze->trip_stats[trip_id].avg) /
-		tze->trip_stats[trip_id].count;
 
 unlock:
 	mutex_unlock(&thermal_dbg->lock);
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
index 155b9af5fe87..c28bd4c11412 100644
--- a/drivers/thermal/thermal_debugfs.h
+++ b/drivers/thermal/thermal_debugfs.h
@@ -2,7 +2,7 @@
 
 #ifdef CONFIG_THERMAL_DEBUGFS
 void thermal_debug_init(void);
-void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state);
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
 void thermal_debug_tz_add(struct thermal_zone_device *tz);
@@ -14,7 +14,7 @@ void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
 void thermal_debug_update_temp(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
-static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev, int state) {}
 static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
 						   int state) {}
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4036566febcb..afbf7837b53e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -245,16 +245,18 @@ enum gsm_encoding {
 
 enum gsm_mux_state {
 	GSM_SEARCH,
-	GSM_START,
-	GSM_ADDRESS,
-	GSM_CONTROL,
-	GSM_LEN,
-	GSM_DATA,
-	GSM_FCS,
-	GSM_OVERRUN,
-	GSM_LEN0,
-	GSM_LEN1,
-	GSM_SSOF,
+	GSM0_ADDRESS,
+	GSM0_CONTROL,
+	GSM0_LEN0,
+	GSM0_LEN1,
+	GSM0_DATA,
+	GSM0_FCS,
+	GSM0_SSOF,
+	GSM1_START,
+	GSM1_ADDRESS,
+	GSM1_CONTROL,
+	GSM1_DATA,
+	GSM1_OVERRUN,
 };
 
 /*
@@ -2847,6 +2849,30 @@ static void gsm_queue(struct gsm_mux *gsm)
 	return;
 }
 
+/**
+ * gsm0_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for basic option mode.
+ */
+
+static void gsm0_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM0_ADDRESS:
+	case GSM0_CONTROL:
+	case GSM0_LEN0:
+	case GSM0_LEN1:
+	case GSM0_DATA:
+	case GSM0_FCS:
+	case GSM0_SSOF:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
 
 /**
  *	gsm0_receive	-	perform processing for non-transparency
@@ -2860,26 +2886,27 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 {
 	unsigned int len;
 
+	gsm0_receive_state_check_and_fix(gsm);
 	switch (gsm->state) {
 	case GSM_SEARCH:	/* SOF marker */
 		if (c == GSM0_SOF) {
-			gsm->state = GSM_ADDRESS;
+			gsm->state = GSM0_ADDRESS;
 			gsm->address = 0;
 			gsm->len = 0;
 			gsm->fcs = INIT_FCS;
 		}
 		break;
-	case GSM_ADDRESS:	/* Address EA */
+	case GSM0_ADDRESS:	/* Address EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM0_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM0_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
-		gsm->state = GSM_LEN0;
+		gsm->state = GSM0_LEN0;
 		break;
-	case GSM_LEN0:		/* Length EA */
+	case GSM0_LEN0:		/* Length EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->len, c)) {
 			if (gsm->len > gsm->mru) {
@@ -2889,14 +2916,14 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 			}
 			gsm->count = 0;
 			if (!gsm->len)
-				gsm->state = GSM_FCS;
+				gsm->state = GSM0_FCS;
 			else
-				gsm->state = GSM_DATA;
+				gsm->state = GSM0_DATA;
 			break;
 		}
-		gsm->state = GSM_LEN1;
+		gsm->state = GSM0_LEN1;
 		break;
-	case GSM_LEN1:
+	case GSM0_LEN1:
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		len = c;
 		gsm->len |= len << 7;
@@ -2907,26 +2934,29 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 		}
 		gsm->count = 0;
 		if (!gsm->len)
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		else
-			gsm->state = GSM_DATA;
+			gsm->state = GSM0_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM0_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len) {
+		if (gsm->count >= MAX_MRU) {
+			gsm->bad_size++;
+			gsm->state = GSM_SEARCH;
+		} else if (gsm->count >= gsm->len) {
 			/* Calculate final FCS for UI frames over all data */
 			if ((gsm->control & ~PF) != UIH) {
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
 							     gsm->count);
 			}
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		}
 		break;
-	case GSM_FCS:		/* FCS follows the packet */
+	case GSM0_FCS:		/* FCS follows the packet */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
-		gsm->state = GSM_SSOF;
+		gsm->state = GSM0_SSOF;
 		break;
-	case GSM_SSOF:
+	case GSM0_SSOF:
 		gsm->state = GSM_SEARCH;
 		if (c == GSM0_SOF)
 			gsm_queue(gsm);
@@ -2939,6 +2969,29 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 	}
 }
 
+/**
+ * gsm1_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for advanced option mode.
+ */
+
+static void gsm1_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM1_START:
+	case GSM1_ADDRESS:
+	case GSM1_CONTROL:
+	case GSM1_DATA:
+	case GSM1_OVERRUN:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
+
 /**
  *	gsm1_receive	-	perform processing for non-transparency
  *	@gsm: gsm data for this ldisc instance
@@ -2949,6 +3002,7 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 
 static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 {
+	gsm1_receive_state_check_and_fix(gsm);
 	/* handle XON/XOFF */
 	if ((c & ISO_IEC_646_MASK) == XON) {
 		gsm->constipated = true;
@@ -2961,11 +3015,11 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 	}
 	if (c == GSM1_SOF) {
 		/* EOF is only valid in frame if we have got to the data state */
-		if (gsm->state == GSM_DATA) {
+		if (gsm->state == GSM1_DATA) {
 			if (gsm->count < 1) {
 				/* Missing FSC */
 				gsm->malformed++;
-				gsm->state = GSM_START;
+				gsm->state = GSM1_START;
 				return;
 			}
 			/* Remove the FCS from data */
@@ -2981,14 +3035,14 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 			gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->buf[gsm->count]);
 			gsm->len = gsm->count;
 			gsm_queue(gsm);
-			gsm->state  = GSM_START;
+			gsm->state  = GSM1_START;
 			return;
 		}
 		/* Any partial frame was a runt so go back to start */
-		if (gsm->state != GSM_START) {
+		if (gsm->state != GSM1_START) {
 			if (gsm->state != GSM_SEARCH)
 				gsm->malformed++;
-			gsm->state = GSM_START;
+			gsm->state = GSM1_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
 		   framing bytes */
@@ -3009,30 +3063,30 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 		gsm->escape = false;
 	}
 	switch (gsm->state) {
-	case GSM_START:		/* First byte after SOF */
+	case GSM1_START:		/* First byte after SOF */
 		gsm->address = 0;
-		gsm->state = GSM_ADDRESS;
+		gsm->state = GSM1_ADDRESS;
 		gsm->fcs = INIT_FCS;
 		fallthrough;
-	case GSM_ADDRESS:	/* Address continuation */
+	case GSM1_ADDRESS:	/* Address continuation */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM1_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM1_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
 		gsm->count = 0;
-		gsm->state = GSM_DATA;
+		gsm->state = GSM1_DATA;
 		break;
-	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
-			gsm->state = GSM_OVERRUN;
+	case GSM1_DATA:		/* Data */
+		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
+			gsm->state = GSM1_OVERRUN;
 			gsm->bad_size++;
 		} else
 			gsm->buf[gsm->count++] = c;
 		break;
-	case GSM_OVERRUN:	/* Over-long - eg a dropped SOF */
+	case GSM1_OVERRUN:	/* Over-long - eg a dropped SOF */
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 504c4c020857..4f8b70f8ce19 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -676,18 +676,46 @@ static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
 	clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
 }
 
+static u32 find_quot(struct device *dev, u32 freq, u32 baud, u32 *percent)
+{
+	u32 quot;
+	u32 rate;
+	u64 hires_rate;
+	u64 hires_baud;
+	u64 hires_err;
+
+	rate = freq / 16;
+	quot = DIV_ROUND_CLOSEST(rate, baud);
+	if (!quot)
+		return 0;
+
+	/* increase resolution to get xx.xx percent */
+	hires_rate = div_u64((u64)rate * 10000, (u64)quot);
+	hires_baud = (u64)baud * 10000;
+
+	/* get the delta */
+	if (hires_rate > hires_baud)
+		hires_err = (hires_rate - hires_baud);
+	else
+		hires_err = (hires_baud - hires_rate);
+
+	*percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
+
+	dev_dbg(dev, "Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
+		baud, freq, *percent / 100, *percent % 100);
+
+	return quot;
+}
+
 static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 			u32 baud)
 {
 	u32 percent;
 	u32 best_percent = UINT_MAX;
 	u32 quot;
+	u32 freq;
 	u32 best_quot = 1;
-	u32 rate;
-	int best_index = -1;
-	u64 hires_rate;
-	u64 hires_baud;
-	u64 hires_err;
+	u32 best_freq = 0;
 	int rc;
 	int i;
 	int real_baud;
@@ -696,44 +724,35 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 	if (priv->baud_mux_clk == NULL)
 		return;
 
-	/* Find the closest match for specified baud */
-	for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
-		if (priv->real_rates[i] == 0)
-			continue;
-		rate = priv->real_rates[i] / 16;
-		quot = DIV_ROUND_CLOSEST(rate, baud);
-		if (!quot)
-			continue;
-
-		/* increase resolution to get xx.xx percent */
-		hires_rate = (u64)rate * 10000;
-		hires_baud = (u64)baud * 10000;
-
-		hires_err = div_u64(hires_rate, (u64)quot);
-
-		/* get the delta */
-		if (hires_err > hires_baud)
-			hires_err = (hires_err - hires_baud);
-		else
-			hires_err = (hires_baud - hires_err);
-
-		percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
-		dev_dbg(up->dev,
-			"Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
-			baud, priv->real_rates[i], percent / 100,
-			percent % 100);
-		if (percent < best_percent) {
-			best_percent = percent;
-			best_index = i;
-			best_quot = quot;
+	/* Try default_mux_rate first */
+	quot = find_quot(up->dev, priv->default_mux_rate, baud, &percent);
+	if (quot) {
+		best_percent = percent;
+		best_freq = priv->default_mux_rate;
+		best_quot = quot;
+	}
+	/* If more than 1% error, find the closest match for specified baud */
+	if (best_percent > 100) {
+		for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
+			freq = priv->real_rates[i];
+			if (freq == 0 || freq == priv->default_mux_rate)
+				continue;
+			quot = find_quot(up->dev, freq, baud, &percent);
+			if (!quot)
+				continue;
+
+			if (percent < best_percent) {
+				best_percent = percent;
+				best_freq = freq;
+				best_quot = quot;
+			}
 		}
 	}
-	if (best_index == -1) {
+	if (!best_freq) {
 		dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
 		return;
 	}
-	rate = priv->real_rates[best_index];
-	rc = clk_set_rate(priv->baud_mux_clk, rate);
+	rc = clk_set_rate(priv->baud_mux_clk, best_freq);
 	if (rc)
 		dev_err(up->dev, "Error selecting BAUD MUX clock\n");
 
@@ -742,8 +761,8 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 		dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
 			baud, percent / 100, percent % 100);
 
-	real_baud = rate / 16 / best_quot;
-	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
+	real_baud = best_freq / 16 / best_quot;
+	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", best_freq);
 	dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
 		baud, real_baud);
 
@@ -752,7 +771,7 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 	i += (i / 2);
 	priv->char_wait = ns_to_ktime(i);
 
-	up->uartclk = rate;
+	up->uartclk = best_freq;
 }
 
 static void brcmstb_set_termios(struct uart_port *up,
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 9ff6bbe9c086..d14988d1492f 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -209,15 +209,19 @@ static int mtk8250_startup(struct uart_port *port)
 
 static void mtk8250_shutdown(struct uart_port *port)
 {
-#ifdef CONFIG_SERIAL_8250_DMA
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct mtk8250_data *data = port->private_data;
+	int irq = data->rx_wakeup_irq;
 
+#ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma)
 		data->rx_status = DMA_RX_SHUTDOWN;
 #endif
 
-	return serial8250_do_shutdown(port);
+	serial8250_do_shutdown(port);
+
+	if (irq >= 0)
+		serial8250_do_set_mctrl(&up->port, TIOCM_RTS);
 }
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e1..12915fffac27 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -554,16 +554,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 	return reg == SC16IS7XX_RHR_REG;
 }
 
+/*
+ * Configure programmable baud rate generator (divisor) according to the
+ * desired baud rate.
+ *
+ * From the datasheet, the divisor is computed according to:
+ *
+ *              XTAL1 input frequency
+ *             -----------------------
+ *                    prescaler
+ * divisor = ---------------------------
+ *            baud-rate x sampling-rate
+ */
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
-	u8 prescaler = 0;
+	unsigned int prescaler = 1;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
 
 	if (div >= BIT(16)) {
-		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
-		div /= 4;
+		prescaler = 4;
+		div /= prescaler;
 	}
 
 	/* Enable enhanced features */
@@ -573,9 +585,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_EFR_ENABLE_BIT);
 	sc16is7xx_efr_unlock(port);
 
+	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
+			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -591,7 +604,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index c873fd823942..7ae309681428 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -597,8 +597,7 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 	addr = le64_to_cpu(cmd_desc_base_addr) & CQE_UCD_BA;
 
 	while (sq_head_slot != hwq->sq_tail_slot) {
-		utrd = hwq->sqe_base_addr +
-				sq_head_slot * sizeof(struct utp_transfer_req_desc);
+		utrd = hwq->sqe_base_addr + sq_head_slot;
 		match = le64_to_cpu(utrd->command_desc_base_addr) & CQE_UCD_BA;
 		if (addr == match) {
 			ufshcd_mcq_nullify_sqe(utrd);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4a07a18cf835..24b54aa09481 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4244,7 +4244,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		 * Make sure UIC command completion interrupt is disabled before
 		 * issuing UIC command.
 		 */
-		wmb();
+		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 		reenable_intr = true;
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
@@ -10353,7 +10353,7 @@ int ufshcd_system_restore(struct device *dev)
 	 * are updated with the latest queue addresses. Only after
 	 * updating these addresses, we can queue the new commands.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
 
 	/* Resuming from hibernate, assume that link was OFF */
 	ufshcd_set_link_off(hba);
@@ -10570,7 +10570,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 * Make sure that UFS interrupts are disabled and any pending interrupt
 	 * status is cleared before registering UFS interrupt handler.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
 	/* IRQ registration */
 	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);
diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
index bb30267da471..66811d8d1929 100644
--- a/drivers/ufs/host/cdns-pltfrm.c
+++ b/drivers/ufs/host/cdns-pltfrm.c
@@ -136,7 +136,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 	 * Make sure the register was updated,
 	 * UniPro layer will not work with an incorrect value.
 	 */
-	mb();
+	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);
 
 	return 0;
 }
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index bcbcf758925b..e5a4bf1c553b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -284,9 +284,6 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 
 	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
-
-	/* make sure above configuration is applied before we return */
-	mb();
 }
 
 /*
@@ -415,7 +412,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
 		    REG_UFS_CFG2);
 
 	/* Ensure that HW clock gating is enabled before next operations */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG2);
 }
 
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
@@ -507,7 +504,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		 * make sure above write gets applied before we return from
 		 * this function.
 		 */
-		mb();
+		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
 	}
 
 	return 0;
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9dd9a391ebb7..b9de170983c9 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -151,10 +151,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
@@ -162,10 +162,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, 0, REG_UFS_CFG1);
 
 	/*
-	 * Make sure de-assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 /* Host controller hardware version: major.minor.step */
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ba4ab33f6094..411bf2b2c4d0 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1680,8 +1680,8 @@ config FB_COBALT
 	select FB_IOMEM_HELPERS
 
 config FB_SH7760
-	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	tristate "SH7760/SH7763/SH7720/SH7721 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_IOMEM_HELPERS
 	help
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
index 21053bf00dc5..c0a5e4cbe0ac 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -144,6 +144,12 @@ config FB_DMAMEM_HELPERS
 	select FB_SYS_IMAGEBLIT
 	select FB_SYSMEM_FOPS
 
+config FB_DMAMEM_HELPERS_DEFERRED
+	bool
+	depends on FB_CORE
+	select FB_DEFERRED_IO
+	select FB_DMAMEM_HELPERS
+
 config FB_IOMEM_FOPS
 	tristate
 	depends on FB_CORE
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index eb2297b37504..d35d2cf99998 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1575,7 +1575,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	 */
 	info->fix = sh_mobile_lcdc_overlay_fix;
 	snprintf(info->fix.id, sizeof(info->fix.id),
-		 "SH Mobile LCDC Overlay %u", ovl->index);
+		 "SHMobile ovl %u", ovl->index);
 	info->fix.smem_start = ovl->dma_handle;
 	info->fix.smem_len = ovl->fb_size;
 	info->fix.line_length = ovl->pitch;
diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index a8fb41f1a258..09329072004f 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -172,7 +172,7 @@ static const unsigned char SiS_HiTVGroup3_2[] = {
 };
 
 /* 301C / 302ELV extended Part2 TV registers (4 tap scaler) */
-
+#ifdef CONFIG_FB_SIS_315
 static const unsigned char SiS_Part2CLVX_1[] = {
     0x00,0x00,
     0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
@@ -245,7 +245,6 @@ static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
     0xFF,0xFF,
 };
 
-#ifdef CONFIG_FB_SIS_315
 /* 661 et al LCD data structure (2.03.00) */
 static const unsigned char SiS_LCDStruct661[] = {
     /* 1024x768 */
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index fa5d9ca6be57..9c75de0656d8 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -155,43 +155,83 @@ int acrn_vm_memseg_unmap(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 {
 	struct vm_memory_region_batch *regions_info;
-	int nr_pages, i = 0, order, nr_regions = 0;
+	int nr_pages, i, order, nr_regions = 0;
 	struct vm_memory_mapping *region_mapping;
 	struct vm_memory_region_op *vm_region;
 	struct page **pages = NULL, *page;
 	void *remap_vaddr;
 	int ret, pinned;
 	u64 user_vm_pa;
-	unsigned long pfn;
 	struct vm_area_struct *vma;
 
 	if (!vm || !memmap)
 		return -EINVAL;
 
+	/* Get the page number of the map region */
+	nr_pages = memmap->len >> PAGE_SHIFT;
+	if (!nr_pages)
+		return -EINVAL;
+
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, memmap->vma_base);
 	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
+		unsigned long start_pfn, cur_pfn;
+		spinlock_t *ptl;
+		bool writable;
+		pte_t *ptep;
+
 		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
 			mmap_read_unlock(current->mm);
 			return -EINVAL;
 		}
 
-		ret = follow_pfn(vma, memmap->vma_base, &pfn);
+		for (i = 0; i < nr_pages; i++) {
+			ret = follow_pte(vma->vm_mm,
+					 memmap->vma_base + i * PAGE_SIZE,
+					 &ptep, &ptl);
+			if (ret)
+				break;
+
+			cur_pfn = pte_pfn(ptep_get(ptep));
+			if (i == 0)
+				start_pfn = cur_pfn;
+			writable = !!pte_write(ptep_get(ptep));
+			pte_unmap_unlock(ptep, ptl);
+
+			/* Disallow write access if the PTE is not writable. */
+			if (!writable &&
+			    (memmap->attr & ACRN_MEM_ACCESS_WRITE)) {
+				ret = -EFAULT;
+				break;
+			}
+
+			/* Disallow refcounted pages. */
+			if (pfn_valid(cur_pfn) &&
+			    !PageReserved(pfn_to_page(cur_pfn))) {
+				ret = -EFAULT;
+				break;
+			}
+
+			/* Disallow non-contiguous ranges. */
+			if (cur_pfn != start_pfn + i) {
+				ret = -EINVAL;
+				break;
+			}
+		}
 		mmap_read_unlock(current->mm);
-		if (ret < 0) {
+
+		if (ret) {
 			dev_dbg(acrn_dev.this_device,
 				"Failed to lookup PFN at VMA:%pK.\n", (void *)memmap->vma_base);
 			return ret;
 		}
 
 		return acrn_mm_region_add(vm, memmap->user_vm_pa,
-			 PFN_PHYS(pfn), memmap->len,
+			 PFN_PHYS(start_pfn), memmap->len,
 			 ACRN_MEM_TYPE_WB, memmap->attr);
 	}
 	mmap_read_unlock(current->mm);
 
-	/* Get the page number of the map region */
-	nr_pages = memmap->len >> PAGE_SHIFT;
 	pages = vzalloc(array_size(nr_pages, sizeof(*pages)));
 	if (!pages)
 		return -ENOMEM;
@@ -235,12 +275,11 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	mutex_unlock(&vm->regions_mapping_lock);
 
 	/* Calculate count of vm_memory_region_op */
-	while (i < nr_pages) {
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		page = pages[i];
 		VM_BUG_ON_PAGE(PageTail(page), page);
 		order = compound_order(page);
 		nr_regions++;
-		i += 1 << order;
 	}
 
 	/* Prepare the vm_memory_region_batch */
@@ -257,8 +296,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	regions_info->vmid = vm->vmid;
 	regions_info->regions_gpa = virt_to_phys(vm_region);
 	user_vm_pa = memmap->user_vm_pa;
-	i = 0;
-	while (i < nr_pages) {
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		u32 region_size;
 
 		page = pages[i];
@@ -274,7 +312,6 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 
 		vm_region++;
 		user_vm_pa += region_size;
-		i += 1 << order;
 	}
 
 	/* Inform the ACRN Hypervisor to set up EPT mappings */
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6b93fae74403..8851ba7a1e27 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3722,15 +3722,43 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 		goto drop_write;
 	}
 
-	down_write(&fs_info->subvol_sem);
-
 	switch (sa->cmd) {
 	case BTRFS_QUOTA_CTL_ENABLE:
 	case BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA:
+		down_write(&fs_info->subvol_sem);
 		ret = btrfs_quota_enable(fs_info, sa);
+		up_write(&fs_info->subvol_sem);
 		break;
 	case BTRFS_QUOTA_CTL_DISABLE:
+		/*
+		 * Lock the cleaner mutex to prevent races with concurrent
+		 * relocation, because relocation may be building backrefs for
+		 * blocks of the quota root while we are deleting the root. This
+		 * is like dropping fs roots of deleted snapshots/subvolumes, we
+		 * need the same protection.
+		 *
+		 * This also prevents races between concurrent tasks trying to
+		 * disable quotas, because we will unlock and relock
+		 * qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
+		 *
+		 * We take this here because we have the dependency of
+		 *
+		 * inode_lock -> subvol_sem
+		 *
+		 * because of rename.  With relocation we can prealloc extents,
+		 * so that makes the dependency chain
+		 *
+		 * cleaner_mutex -> inode_lock -> subvol_sem
+		 *
+		 * so we must take the cleaner_mutex here before we take the
+		 * subvol_sem.  The deadlock can't actually happen, but this
+		 * quiets lockdep.
+		 */
+		mutex_lock(&fs_info->cleaner_mutex);
+		down_write(&fs_info->subvol_sem);
 		ret = btrfs_quota_disable(fs_info);
+		up_write(&fs_info->subvol_sem);
+		mutex_unlock(&fs_info->cleaner_mutex);
 		break;
 	default:
 		ret = -EINVAL;
@@ -3738,7 +3766,6 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 	}
 
 	kfree(sa);
-	up_write(&fs_info->subvol_sem);
 drop_write:
 	mnt_drop_write_file(file);
 	return ret;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 82d4559eb4b1..cacc12d0ff33 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1342,16 +1342,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
 	/*
-	 * Lock the cleaner mutex to prevent races with concurrent relocation,
-	 * because relocation may be building backrefs for blocks of the quota
-	 * root while we are deleting the root. This is like dropping fs roots
-	 * of deleted snapshots/subvolumes, we need the same protection.
-	 *
-	 * This also prevents races between concurrent tasks trying to disable
-	 * quotas, because we will unlock and relock qgroup_ioctl_lock across
-	 * BTRFS_FS_QUOTA_ENABLED changes.
+	 * Relocation will mess with backrefs, so make sure we have the
+	 * cleaner_mutex held to protect us from relocate.
 	 */
-	mutex_lock(&fs_info->cleaner_mutex);
+	lockdep_assert_held(&fs_info->cleaner_mutex);
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
@@ -1373,9 +1367,13 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
+	/*
+	 * We have nothing held here and no trans handle, just return the error
+	 * if there is one.
+	 */
 	ret = flush_reservations(fs_info);
 	if (ret)
-		goto out_unlock_cleaner;
+		return ret;
 
 	/*
 	 * 1 For the root item
@@ -1439,9 +1437,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_commit_transaction(trans);
-out_unlock_cleaner:
-	mutex_unlock(&fs_info->cleaner_mutex);
-
 	return ret;
 }
 
diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 1f2f70a1b824..decedc4ee15f 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -12,6 +12,7 @@
 #include <trace/events/dlm.h>
 
 #include "dlm_internal.h"
+#include "lvb_table.h"
 #include "memory.h"
 #include "lock.h"
 #include "user.h"
@@ -42,6 +43,7 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int rv = DLM_ENQUEUE_CALLBACK_SUCCESS;
 	struct dlm_callback *cb;
+	int copy_lvb = 0;
 	int prev_mode;
 
 	if (flags & DLM_CB_BAST) {
@@ -73,6 +75,17 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 				goto out;
 			}
 		}
+	} else if (flags & DLM_CB_CAST) {
+		if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags)) {
+			if (lkb->lkb_last_cast)
+				prev_mode = lkb->lkb_last_cb->mode;
+			else
+				prev_mode = -1;
+
+			if (!status && lkb->lkb_lksb->sb_lvbptr &&
+			    dlm_lvb_operations[prev_mode + 1][mode + 1])
+				copy_lvb = 1;
+		}
 	}
 
 	cb = dlm_allocate_cb();
@@ -85,6 +98,7 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	cb->mode = mode;
 	cb->sb_status = status;
 	cb->sb_flags = (sbflags & 0x000000FF);
+	cb->copy_lvb = copy_lvb;
 	kref_init(&cb->ref);
 	if (!test_and_set_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags))
 		rv = DLM_ENQUEUE_CALLBACK_NEED_SCHED;
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index dfc444dad329..511d0b984f58 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -222,6 +222,7 @@ struct dlm_callback {
 	int			sb_status;	/* copy to lksb status */
 	uint8_t			sb_flags;	/* copy to lksb flags */
 	int8_t			mode; /* rq mode of bast, gr mode of cast */
+	int			copy_lvb;
 
 	struct list_head	list;
 	struct kref		ref;
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 9f9b68448830..12a483deeef5 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -21,7 +21,6 @@
 #include "dlm_internal.h"
 #include "lockspace.h"
 #include "lock.h"
-#include "lvb_table.h"
 #include "user.h"
 #include "ast.h"
 #include "config.h"
@@ -806,8 +805,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	struct dlm_lkb *lkb;
 	DECLARE_WAITQUEUE(wait, current);
 	struct dlm_callback *cb;
-	int rv, ret, copy_lvb = 0;
-	int old_mode, new_mode;
+	int rv, ret;
 
 	if (count == sizeof(struct dlm_device_version)) {
 		rv = copy_version_to_user(buf, count);
@@ -864,9 +862,6 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 
 	lkb = list_first_entry(&proc->asts, struct dlm_lkb, lkb_cb_list);
 
-	/* rem_lkb_callback sets a new lkb_last_cast */
-	old_mode = lkb->lkb_last_cast->mode;
-
 	rv = dlm_dequeue_lkb_callback(lkb, &cb);
 	switch (rv) {
 	case DLM_DEQUEUE_CALLBACK_EMPTY:
@@ -895,12 +890,6 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	if (cb->flags & DLM_CB_BAST) {
 		trace_dlm_bast(lkb->lkb_resource->res_ls, lkb, cb->mode);
 	} else if (cb->flags & DLM_CB_CAST) {
-		new_mode = cb->mode;
-
-		if (!cb->sb_status && lkb->lkb_lksb->sb_lvbptr &&
-		    dlm_lvb_operations[old_mode + 1][new_mode + 1])
-			copy_lvb = 1;
-
 		lkb->lkb_lksb->sb_status = cb->sb_status;
 		lkb->lkb_lksb->sb_flags = cb->sb_flags;
 		trace_dlm_ast(lkb->lkb_resource->res_ls, lkb);
@@ -908,7 +897,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 
 	ret = copy_result_to_user(lkb->lkb_ua,
 				  test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
-				  cb->flags, cb->mode, copy_lvb, buf, count);
+				  cb->flags, cb->mode, cb->copy_lvb, buf, count);
 
 	kref_put(&cb->ref, dlm_release_callback);
 
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..7f9f68c00ef6 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -300,9 +300,11 @@ write_tag_66_packet(char *signature, u8 cipher_code,
 	 *         | Key Identifier Size      | 1 or 2 bytes |
 	 *         | Key Identifier           | arbitrary    |
 	 *         | File Encryption Key Size | 1 or 2 bytes |
+	 *         | Cipher Code              | 1 byte       |
 	 *         | File Encryption Key      | arbitrary    |
+	 *         | Checksum                 | 2 bytes      |
 	 */
-	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
+	data_len = (8 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
 	*packet = kmalloc(data_len, GFP_KERNEL);
 	message = *packet;
 	if (!message) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..c5a9a483fb53 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -875,6 +875,34 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	return res;
 }
 
+/*
+ * The ffd.file pointer may be in the process of being torn down due to
+ * being closed, but we may not have finished eventpoll_release() yet.
+ *
+ * Normally, even with the atomic_long_inc_not_zero, the file may have
+ * been free'd and then gotten re-allocated to something else (since
+ * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ *
+ * But for epoll, users hold the ep->mtx mutex, and as such any file in
+ * the process of being free'd will block in eventpoll_release_file()
+ * and thus the underlying file allocation will not be free'd, and the
+ * file re-use cannot happen.
+ *
+ * For the same reason we can avoid a rcu_read_lock() around the
+ * operation - 'ffd.file' cannot go away even if the refcount has
+ * reached zero (but we must still not call out to ->poll() functions
+ * etc).
+ */
+static struct file *epi_fget(const struct epitem *epi)
+{
+	struct file *file;
+
+	file = epi->ffd.file;
+	if (!atomic_long_inc_not_zero(&file->f_count))
+		file = NULL;
+	return file;
+}
+
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
@@ -883,14 +911,22 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
-	struct file *file = epi->ffd.file;
+	struct file *file = epi_fget(epi);
 	__poll_t res;
 
+	/*
+	 * We could return EPOLLERR | EPOLLHUP or something, but let's
+	 * treat this more as "file doesn't exist, poll didn't happen".
+	 */
+	if (!file)
+		return 0;
+
 	pt->_key = epi->event.events;
 	if (!is_file_epoll(file))
 		res = vfs_poll(file, pt);
 	else
 		res = __ep_eventpoll_poll(file, pt, depth);
+	fput(file);
 	return res & epi->event.events;
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 5ee2545c3e18..f11cfd7bce0b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -67,6 +67,7 @@
 #include <linux/time_namespace.h>
 #include <linux/user_events.h>
 #include <linux/rseq.h>
+#include <linux/ksm.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -267,6 +268,14 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 		goto err_free;
 	}
 
+	/*
+	 * Need to be called with mmap write lock
+	 * held, to avoid race with ksmd.
+	 */
+	err = ksm_execve(mm);
+	if (err)
+		goto err_ksm;
+
 	/*
 	 * Place the stack at the largest stack address the architecture
 	 * supports. Later, we'll move this to an appropriate place. We don't
@@ -288,6 +297,8 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	bprm->p = vma->vm_end - sizeof(void *);
 	return 0;
 err:
+	ksm_exit(mm);
+err_ksm:
 	mmap_write_unlock(mm);
 err_free:
 	bprm->vma = NULL;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ccf3b5e3a7c..31604907af50 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2887,9 +2887,6 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	/* In case writeback began while the folio was unlocked */
-	folio_wait_stable(folio);
-
 #ifdef CONFIG_FS_ENCRYPTION
 	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
 #else
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index cf407425d0f3..00b0839b534d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6119,6 +6119,7 @@ ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
 	ext4_mb_mark_bb(sb, block, 1, true);
 	ar->len = 1;
 
+	*errp = 0;
 	return block;
 }
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 05b647e6bc19..58fee3c6febc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2898,7 +2898,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	inode = ext4_new_inode_start_handle(idmap, dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
-			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
+			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
 			  4 + EXT4_XATTR_TRANS_BLOCKS);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..2507fe34cbdf 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -166,19 +166,45 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 	return true;
 }
 
-void gfs2_glock_free(struct gfs2_glock *gl)
+static void __gfs2_glock_free(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
-	gfs2_glock_assert_withdraw(gl, atomic_read(&gl->gl_revokes) == 0);
 	rhashtable_remove_fast(&gl_hash_table, &gl->gl_node, ht_parms);
 	smp_mb();
 	wake_up_glock(gl);
 	call_rcu(&gl->gl_rcu, gfs2_glock_dealloc);
+}
+
+void gfs2_glock_free(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	__gfs2_glock_free(gl);
+	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
+		wake_up(&sdp->sd_kill_wait);
+}
+
+void gfs2_glock_free_later(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	spin_lock(&lru_lock);
+	list_add(&gl->gl_lru, &sdp->sd_dead_glocks);
+	spin_unlock(&lru_lock);
 	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
 		wake_up(&sdp->sd_kill_wait);
 }
 
+static void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
+{
+	struct list_head *list = &sdp->sd_dead_glocks;
+
+	while(!list_empty(list)) {
+		struct gfs2_glock *gl;
+
+		gl = list_first_entry(list, struct gfs2_glock, gl_lru);
+		list_del_init(&gl->gl_lru);
+		__gfs2_glock_free(gl);
+	}
+}
+
 /**
  * gfs2_glock_hold() - increment reference count on glock
  * @gl: The glock to hold
@@ -591,7 +617,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	struct gfs2_holder *gh;
 	unsigned state = ret & LM_OUT_ST_MASK;
 
-	spin_lock(&gl->gl_lockref.lock);
 	trace_gfs2_glock_state_change(gl, state);
 	state_change(gl, state);
 	gh = find_first_waiter(gl);
@@ -639,7 +664,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 			       gl->gl_target, state);
 			GLOCK_BUG_ON(gl, 1);
 		}
-		spin_unlock(&gl->gl_lockref.lock);
 		return;
 	}
 
@@ -662,7 +686,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	}
 out:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
-	spin_unlock(&gl->gl_lockref.lock);
 }
 
 static bool is_system_glock(struct gfs2_glock *gl)
@@ -690,6 +713,7 @@ __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	unsigned int lck_flags = (unsigned int)(gh ? gh->gh_flags : 0);
 	int ret;
 
@@ -718,6 +742,9 @@ __acquires(&gl->gl_lockref.lock)
 	    (gl->gl_state == LM_ST_EXCLUSIVE) ||
 	    (lck_flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB)))
 		clear_bit(GLF_BLOCKING, &gl->gl_flags);
+	if (!glops->go_inval && !glops->go_sync)
+		goto skip_inval;
+
 	spin_unlock(&gl->gl_lockref.lock);
 	if (glops->go_sync) {
 		ret = glops->go_sync(gl);
@@ -730,6 +757,7 @@ __acquires(&gl->gl_lockref.lock)
 				fs_err(sdp, "Error %d syncing glock \n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
+			spin_lock(&gl->gl_lockref.lock);
 			goto skip_inval;
 		}
 	}
@@ -750,9 +778,10 @@ __acquires(&gl->gl_lockref.lock)
 		glops->go_inval(gl, target == LM_ST_DEFERRED ? 0 : DIO_METADATA);
 		clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 	}
+	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	gfs2_glock_hold(gl);
+	gl->gl_lockref.count++;
 	/*
 	 * Check for an error encountered since we called go_sync and go_inval.
 	 * If so, we can't withdraw from the glock code because the withdraw
@@ -794,31 +823,37 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 			clear_bit(GLF_LOCK, &gl->gl_flags);
 			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
-			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
-			goto out;
+			__gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
+			return;
 		} else {
 			clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 		}
 	}
 
-	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
-		/* lock_dlm */
-		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
+	if (ls->ls_ops->lm_lock) {
+		spin_unlock(&gl->gl_lockref.lock);
+		ret = ls->ls_ops->lm_lock(gl, target, lck_flags);
+		spin_lock(&gl->gl_lockref.lock);
+
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
-		    test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags)) {
-			finish_xmote(gl, target);
-			gfs2_glock_queue_work(gl, 0);
+		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
+			/*
+			 * The lockspace has been released and the lock has
+			 * been unlocked implicitly.
+			 */
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
+			target = gl->gl_state | LM_OUT_ERROR;
+		} else {
+			/* The operation will be completed asynchronously. */
+			return;
 		}
-	} else { /* lock_nolock */
-		finish_xmote(gl, target);
-		gfs2_glock_queue_work(gl, 0);
 	}
-out:
-	spin_lock(&gl->gl_lockref.lock);
+
+	/* Complete the operation now. */
+	finish_xmote(gl, target);
+	__gfs2_glock_queue_work(gl, 0);
 }
 
 /**
@@ -1071,11 +1106,12 @@ static void glock_work_func(struct work_struct *work)
 	struct gfs2_glock *gl = container_of(work, struct gfs2_glock, gl_work.work);
 	unsigned int drop_refs = 1;
 
-	if (test_and_clear_bit(GLF_REPLY_PENDING, &gl->gl_flags)) {
+	spin_lock(&gl->gl_lockref.lock);
+	if (test_bit(GLF_REPLY_PENDING, &gl->gl_flags)) {
+		clear_bit(GLF_REPLY_PENDING, &gl->gl_flags);
 		finish_xmote(gl, gl->gl_reply);
 		drop_refs++;
 	}
-	spin_lock(&gl->gl_lockref.lock);
 	if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
 	    gl->gl_state != LM_ST_UNLOCKED &&
 	    gl->gl_demote_state != LM_ST_EXCLUSIVE) {
@@ -2148,8 +2184,11 @@ static void thaw_glock(struct gfs2_glock *gl)
 		return;
 	if (!lockref_get_not_dead(&gl->gl_lockref))
 		return;
+
+	spin_lock(&gl->gl_lockref.lock);
 	set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
-	gfs2_glock_queue_work(gl, 0);
+	__gfs2_glock_queue_work(gl, 0);
+	spin_unlock(&gl->gl_lockref.lock);
 }
 
 /**
@@ -2225,6 +2264,8 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	wait_event_timeout(sdp->sd_kill_wait,
 			   atomic_read(&sdp->sd_glock_disposal) == 0,
 			   HZ * 600);
+	gfs2_lm_unmount(sdp);
+	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 }
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 0114f3e0ebe0..86987a59a058 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -252,6 +252,7 @@ void gfs2_gl_dq_holders(struct gfs2_sbd *sdp);
 void gfs2_glock_thaw(struct gfs2_sbd *sdp);
 void gfs2_glock_add_to_lru(struct gfs2_glock *gl);
 void gfs2_glock_free(struct gfs2_glock *gl);
+void gfs2_glock_free_later(struct gfs2_glock *gl);
 
 int __init gfs2_glock_init(void);
 void gfs2_glock_exit(void);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 45653cbc8a87..e0e8dfeee777 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -82,6 +82,9 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 	GLOCK_BUG_ON(gl, !fsync && atomic_read(&gl->gl_ail_count));
 	spin_unlock(&sdp->sd_ail_lock);
 	gfs2_log_unlock(sdp);
+
+	if (gfs2_withdrawing(sdp))
+		gfs2_withdraw(sdp);
 }
 
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 95a334d64da2..60abd7050c99 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -838,6 +838,7 @@ struct gfs2_sbd {
 	/* For quiescing the filesystem */
 	struct gfs2_holder sd_freeze_gh;
 	struct mutex sd_freeze_mutex;
+	struct list_head sd_dead_glocks;
 
 	char sd_fsname[GFS2_FSNAME_LEN + 3 * sizeof(int) + 2];
 	char sd_table_name[GFS2_FSNAME_LEN];
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index d1ac5d0679ea..e028e55e67d9 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -121,6 +121,11 @@ static void gdlm_ast(void *arg)
 	struct gfs2_glock *gl = arg;
 	unsigned ret = gl->gl_state;
 
+	/* If the glock is dead, we only react to a dlm_unlock() reply. */
+	if (__lockref_is_dead(&gl->gl_lockref) &&
+	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
+		return;
+
 	gfs2_update_reply_times(gl);
 	BUG_ON(gl->gl_lksb.sb_flags & DLM_SBF_DEMOTED);
 
@@ -171,6 +176,9 @@ static void gdlm_bast(void *arg, int mode)
 {
 	struct gfs2_glock *gl = arg;
 
+	if (__lockref_is_dead(&gl->gl_lockref))
+		return;
+
 	switch (mode) {
 	case DLM_LOCK_EX:
 		gfs2_glock_cb(gl, LM_ST_UNLOCKED);
@@ -291,8 +299,12 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int error;
 
-	if (gl->gl_lksb.sb_lkid == 0)
-		goto out_free;
+	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
+
+	if (gl->gl_lksb.sb_lkid == 0) {
+		gfs2_glock_free(gl);
+		return;
+	}
 
 	clear_bit(GLF_BLOCKING, &gl->gl_flags);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
@@ -300,13 +312,17 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_update_request_times(gl);
 
 	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags))
-		goto out_free;
+	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
+		gfs2_glock_free(gl);
+		return;
+	}
 	/* don't want to skip dlm_unlock writing the lvb when lock has one */
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
-	    !gl->gl_lksb.sb_lvbptr)
-		goto out_free;
+	    !gl->gl_lksb.sb_lvbptr) {
+		gfs2_glock_free_later(gl);
+		return;
+	}
 
 again:
 	error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_VALBLK,
@@ -321,10 +337,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		       gl->gl_name.ln_type,
 		       (unsigned long long)gl->gl_name.ln_number, error);
 	}
-	return;
-
-out_free:
-	gfs2_glock_free(gl);
 }
 
 static void gdlm_cancel(struct gfs2_glock *gl)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1281e60be639..db0df091a6a7 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -136,6 +136,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	atomic_set(&sdp->sd_log_in_flight, 0);
 	init_waitqueue_head(&sdp->sd_log_flush_wait);
 	mutex_init(&sdp->sd_freeze_mutex);
+	INIT_LIST_HEAD(&sdp->sd_dead_glocks);
 
 	return sdp;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e5f79466340d..2d780b4701a2 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -646,10 +646,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_gl_hash_clear(sdp);
 	truncate_inode_pages_final(&sdp->sd_aspace);
 	gfs2_delete_debugfs_file(sdp);
-	/*  Unmount the locking protocol  */
-	gfs2_lm_unmount(sdp);
 
-	/*  At this point, we're through participating in the lockspace  */
 	gfs2_sys_fs_del(sdp);
 	free_sbd(sdp);
 }
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index f52141ce9485..fc3ecb180ac5 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -350,7 +350,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 			fs_err(sdp, "telling LM to unmount\n");
 			lm->lm_unmount(sdp);
 		}
-		set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
 		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 00224f3a8d6e..defb4162c3d5 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -1110,6 +1110,9 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		return rc;
 
 	request = PAD(sizeof(struct jffs2_raw_xattr) + strlen(xname) + 1 + size);
+	if (request > c->sector_size - c->cleanmarker_size)
+		return -ERANGE;
+
 	rc = jffs2_reserve_space(c, request, &length,
 				 ALLOC_NORMAL, JFFS2_SUMMARY_XATTR_SIZE);
 	if (rc) {
diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..ef700d39f0f3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -240,17 +240,22 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
-static void offset_set(struct dentry *dentry, u32 offset)
+/* 0 is '.', 1 is '..', so always start with offset 2 or more */
+enum {
+	DIR_OFFSET_MIN	= 2,
+};
+
+static void offset_set(struct dentry *dentry, long offset)
 {
-	dentry->d_fsdata = (void *)((uintptr_t)(offset));
+	dentry->d_fsdata = (void *)offset;
 }
 
-static u32 dentry2offset(struct dentry *dentry)
+static long dentry2offset(struct dentry *dentry)
 {
-	return (u32)((uintptr_t)(dentry->d_fsdata));
+	return (long)dentry->d_fsdata;
 }
 
-static struct lock_class_key simple_offset_xa_lock;
+static struct lock_class_key simple_offset_lock_class;
 
 /**
  * simple_offset_init - initialize an offset_ctx
@@ -259,11 +264,9 @@ static struct lock_class_key simple_offset_xa_lock;
  */
 void simple_offset_init(struct offset_ctx *octx)
 {
-	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
-	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
-
-	/* 0 is '.', 1 is '..', so always start with offset 2 */
-	octx->next_offset = 2;
+	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
+	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
+	octx->next_offset = DIR_OFFSET_MIN;
 }
 
 /**
@@ -271,20 +274,19 @@ void simple_offset_init(struct offset_ctx *octx)
  * @octx: directory offset ctx to be updated
  * @dentry: new dentry being added
  *
- * Returns zero on success. @so_ctx and the dentry offset are updated.
+ * Returns zero on success. @octx and the dentry's offset are updated.
  * Otherwise, a negative errno value is returned.
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
-	u32 offset;
+	unsigned long offset;
 	int ret;
 
 	if (dentry2offset(dentry) != 0)
 		return -EBUSY;
 
-	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
-			      &octx->next_offset, GFP_KERNEL);
+	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
+				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -292,6 +294,18 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 	return 0;
 }
 
+static int simple_offset_replace(struct offset_ctx *octx, struct dentry *dentry,
+				 long offset)
+{
+	int ret;
+
+	ret = mtree_store(&octx->mt, offset, dentry, GFP_KERNEL);
+	if (ret)
+		return ret;
+	offset_set(dentry, offset);
+	return 0;
+}
+
 /**
  * simple_offset_remove - Remove an entry to a directory's offset map
  * @octx: directory offset ctx to be updated
@@ -300,16 +314,78 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
  */
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 {
-	u32 offset;
+	long offset;
 
 	offset = dentry2offset(dentry);
 	if (offset == 0)
 		return;
 
-	xa_erase(&octx->xa, offset);
+	mtree_erase(&octx->mt, offset);
 	offset_set(dentry, 0);
 }
 
+/**
+ * simple_offset_empty - Check if a dentry can be unlinked
+ * @dentry: dentry to be tested
+ *
+ * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
+ */
+int simple_offset_empty(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct offset_ctx *octx;
+	struct dentry *child;
+	unsigned long index;
+	int ret = 1;
+
+	if (!inode || !S_ISDIR(inode->i_mode))
+		return ret;
+
+	index = DIR_OFFSET_MIN;
+	octx = inode->i_op->get_offset_ctx(inode);
+	mt_for_each(&octx->mt, child, index, LONG_MAX) {
+		spin_lock(&child->d_lock);
+		if (simple_positive(child)) {
+			spin_unlock(&child->d_lock);
+			ret = 0;
+			break;
+		}
+		spin_unlock(&child->d_lock);
+	}
+
+	return ret;
+}
+
+/**
+ * simple_offset_rename - handle directory offsets for rename
+ * @old_dir: parent directory of source entry
+ * @old_dentry: dentry of source entry
+ * @new_dir: parent_directory of destination entry
+ * @new_dentry: dentry of destination
+ *
+ * Caller provides appropriate serialization.
+ *
+ * User space expects the directory offset value of the replaced
+ * (new) directory entry to be unchanged after a rename.
+ *
+ * Returns zero on success, a negative errno value on failure.
+ */
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
+	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
+	long new_offset = dentry2offset(new_dentry);
+
+	simple_offset_remove(old_ctx, old_dentry);
+
+	if (new_offset) {
+		offset_set(new_dentry, 0);
+		return simple_offset_replace(new_ctx, old_dentry, new_offset);
+	}
+	return simple_offset_add(new_ctx, old_dentry);
+}
+
 /**
  * simple_offset_rename_exchange - exchange rename with directory offsets
  * @old_dir: parent of dentry being moved
@@ -317,6 +393,9 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
  * @new_dir: destination parent
  * @new_dentry: destination dentry
  *
+ * This API preserves the directory offset values. Caller provides
+ * appropriate serialization.
+ *
  * Returns zero on success. Otherwise a negative errno is returned and the
  * rename is rolled back.
  */
@@ -327,18 +406,18 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
-	u32 old_index = dentry2offset(old_dentry);
-	u32 new_index = dentry2offset(new_dentry);
+	long old_index = dentry2offset(old_dentry);
+	long new_index = dentry2offset(new_dentry);
 	int ret;
 
 	simple_offset_remove(old_ctx, old_dentry);
 	simple_offset_remove(new_ctx, new_dentry);
 
-	ret = simple_offset_add(new_ctx, old_dentry);
+	ret = simple_offset_replace(new_ctx, old_dentry, new_index);
 	if (ret)
 		goto out_restore;
 
-	ret = simple_offset_add(old_ctx, new_dentry);
+	ret = simple_offset_replace(old_ctx, new_dentry, old_index);
 	if (ret) {
 		simple_offset_remove(new_ctx, old_dentry);
 		goto out_restore;
@@ -353,10 +432,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	return 0;
 
 out_restore:
-	offset_set(old_dentry, old_index);
-	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
-	offset_set(new_dentry, new_index);
-	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	(void)simple_offset_replace(old_ctx, old_dentry, old_index);
+	(void)simple_offset_replace(new_ctx, new_dentry, new_index);
 	return ret;
 }
 
@@ -369,7 +446,7 @@ int simple_offset_rename_exchange(struct inode *old_dir,
  */
 void simple_offset_destroy(struct offset_ctx *octx)
 {
-	xa_destroy(&octx->xa);
+	mtree_destroy(&octx->mt);
 }
 
 /**
@@ -399,15 +476,16 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	/* In this case, ->private_data is protected by f_pos_lock */
 	file->private_data = NULL;
-	return vfs_setpos(file, offset, U32_MAX);
+	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *offset_find_next(struct xa_state *xas)
+static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 {
+	MA_STATE(mas, &octx->mt, offset, offset);
 	struct dentry *child, *found = NULL;
 
 	rcu_read_lock();
-	child = xas_next_entry(xas, U32_MAX);
+	child = mas_find(&mas, LONG_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -421,8 +499,8 @@ static struct dentry *offset_find_next(struct xa_state *xas)
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
-	u32 offset = dentry2offset(dentry);
 	struct inode *inode = d_inode(dentry);
+	long offset = dentry2offset(dentry);
 
 	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
@@ -430,12 +508,11 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 
 static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
-	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
-	XA_STATE(xas, &so_ctx->xa, ctx->pos);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
 
 	while (true) {
-		dentry = offset_find_next(&xas);
+		dentry = offset_find_next(octx, ctx->pos);
 		if (!dentry)
 			return ERR_PTR(-ENOENT);
 
@@ -444,8 +521,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 			break;
 		}
 
+		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
-		ctx->pos = xas.xa_index + 1;
 	}
 	return NULL;
 }
@@ -481,7 +558,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == 2)
+	if (ctx->pos == DIR_OFFSET_MIN)
 		file->private_data = NULL;
 	else if (file->private_data == ERR_PTR(-ENOENT))
 		return 0;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ea3c8114245c..d8f54eb7455e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,12 +48,10 @@ enum {
 	NFSD_MaxBlkSize,
 	NFSD_MaxConnections,
 	NFSD_Filecache,
-#ifdef CONFIG_NFSD_V4
 	NFSD_Leasetime,
 	NFSD_Gracetime,
 	NFSD_RecoveryDir,
 	NFSD_V4EndGrace,
-#endif
 	NFSD_MaxReserved
 };
 
@@ -1359,7 +1357,9 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
+#endif
 		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
 #endif
 		/* last one */ {""}
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index cfb6aca5ec38..d6e3f20e8872 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 	if (argv->v_nmembs == 0)
 		return 0;
 
-	if (argv->v_size > PAGE_SIZE)
+	if ((size_t)argv->v_size > PAGE_SIZE)
 		return -EINVAL;
 
 	/*
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2bfb08052d39..5b3f53001641 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2161,8 +2161,10 @@ static void nilfs_segctor_start_timer(struct nilfs_sc_info *sci)
 {
 	spin_lock(&sci->sc_state_lock);
 	if (!(sci->sc_state & NILFS_SEGCTOR_COMMIT)) {
-		sci->sc_timer.expires = jiffies + sci->sc_interval;
-		add_timer(&sci->sc_timer);
+		if (sci->sc_task) {
+			sci->sc_timer.expires = jiffies + sci->sc_interval;
+			add_timer(&sci->sc_timer);
+		}
 		sci->sc_state |= NILFS_SEGCTOR_COMMIT;
 	}
 	spin_unlock(&sci->sc_state_lock);
@@ -2209,19 +2211,36 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	struct nilfs_segctor_wait_request wait_req;
 	int err = 0;
 
-	spin_lock(&sci->sc_state_lock);
 	init_wait(&wait_req.wq);
 	wait_req.err = 0;
 	atomic_set(&wait_req.done, 0);
+	init_waitqueue_entry(&wait_req.wq, current);
+
+	/*
+	 * To prevent a race issue where completion notifications from the
+	 * log writer thread are missed, increment the request sequence count
+	 * "sc_seq_request" and insert a wait queue entry using the current
+	 * sequence number into the "sc_wait_request" queue at the same time
+	 * within the lock section of "sc_state_lock".
+	 */
+	spin_lock(&sci->sc_state_lock);
 	wait_req.seq = ++sci->sc_seq_request;
+	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
 	spin_unlock(&sci->sc_state_lock);
 
-	init_waitqueue_entry(&wait_req.wq, current);
-	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
-	set_current_state(TASK_INTERRUPTIBLE);
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/*
+		 * Synchronize only while the log writer thread is alive.
+		 * Leave flushing out after the log writer thread exits to
+		 * the cleanup work in nilfs_segctor_destroy().
+		 */
+		if (!sci->sc_task)
+			break;
+
 		if (atomic_read(&wait_req.done)) {
 			err = wait_req.err;
 			break;
@@ -2237,7 +2256,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	return err;
 }
 
-static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
+static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
 {
 	struct nilfs_segctor_wait_request *wrq, *n;
 	unsigned long flags;
@@ -2245,7 +2264,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
 	spin_lock_irqsave(&sci->sc_wait_request.lock, flags);
 	list_for_each_entry_safe(wrq, n, &sci->sc_wait_request.head, wq.entry) {
 		if (!atomic_read(&wrq->done) &&
-		    nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq)) {
+		    (force || nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq))) {
 			wrq->err = err;
 			atomic_set(&wrq->done, 1);
 		}
@@ -2363,10 +2382,21 @@ int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
  */
 static void nilfs_segctor_accept(struct nilfs_sc_info *sci)
 {
+	bool thread_is_alive;
+
 	spin_lock(&sci->sc_state_lock);
 	sci->sc_seq_accepted = sci->sc_seq_request;
+	thread_is_alive = (bool)sci->sc_task;
 	spin_unlock(&sci->sc_state_lock);
-	del_timer_sync(&sci->sc_timer);
+
+	/*
+	 * This function does not race with the log writer thread's
+	 * termination.  Therefore, deleting sc_timer, which should not be
+	 * done after the log writer thread exits, can be done safely outside
+	 * the area protected by sc_state_lock.
+	 */
+	if (thread_is_alive)
+		del_timer_sync(&sci->sc_timer);
 }
 
 /**
@@ -2383,7 +2413,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 	if (mode == SC_LSEG_SR) {
 		sci->sc_state &= ~NILFS_SEGCTOR_COMMIT;
 		sci->sc_seq_done = sci->sc_seq_accepted;
-		nilfs_segctor_wakeup(sci, err);
+		nilfs_segctor_wakeup(sci, err, false);
 		sci->sc_flush_request = 0;
 	} else {
 		if (mode == SC_FLUSH_FILE)
@@ -2392,7 +2422,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 			sci->sc_flush_request &= ~FLUSH_DAT_BIT;
 
 		/* re-enable timer if checkpoint creation was not done */
-		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) && sci->sc_task &&
 		    time_before(jiffies, sci->sc_timer.expires))
 			add_timer(&sci->sc_timer);
 	}
@@ -2582,6 +2612,7 @@ static int nilfs_segctor_thread(void *arg)
 	int timeout = 0;
 
 	sci->sc_timer_task = current;
+	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	/* start sync. */
 	sci->sc_task = current;
@@ -2649,6 +2680,7 @@ static int nilfs_segctor_thread(void *arg)
  end_thread:
 	/* end sync. */
 	sci->sc_task = NULL;
+	timer_shutdown_sync(&sci->sc_timer);
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_kill_thread() */
 	spin_unlock(&sci->sc_state_lock);
 	return 0;
@@ -2712,7 +2744,6 @@ static struct nilfs_sc_info *nilfs_segctor_new(struct super_block *sb,
 	INIT_LIST_HEAD(&sci->sc_gc_inodes);
 	INIT_LIST_HEAD(&sci->sc_iput_queue);
 	INIT_WORK(&sci->sc_iput_work, nilfs_iput_work_func);
-	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	sci->sc_interval = HZ * NILFS_SC_DEFAULT_TIMEOUT;
 	sci->sc_mjcp_freq = HZ * NILFS_SC_DEFAULT_SR_FREQ;
@@ -2766,6 +2797,13 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 		|| sci->sc_seq_request != sci->sc_seq_done);
 	spin_unlock(&sci->sc_state_lock);
 
+	/*
+	 * Forcibly wake up tasks waiting in nilfs_segctor_sync(), which can
+	 * be called from delayed iput() via nilfs_evict_inode() and can race
+	 * with the above log writer thread termination.
+	 */
+	nilfs_segctor_wakeup(sci, 0, true);
+
 	if (flush_work(&sci->sc_iput_work))
 		flag = true;
 
@@ -2791,7 +2829,6 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
-	timer_shutdown_sync(&sci->sc_timer);
 	kfree(sci);
 }
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 5cf3d9decf64..45e556fd7c54 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -475,6 +475,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
 			ntfs_inode_err(dir, "Looks like your dir is corrupt");
+			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index daabaad63aaf..14284f0ed46a 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1533,6 +1533,11 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out1;
 	}
 
+	if (data_size <= le64_to_cpu(alloc->nres.data_size)) {
+		/* Reuse index. */
+		goto out;
+	}
+
 	/* Increase allocation. */
 	err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
 			    &indx->alloc_run, data_size, &data_size, true,
@@ -1546,6 +1551,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (in->name == I30_NAME)
 		i_size_write(&ni->vfs_inode, data_size);
 
+out:
 	*vbn = bit << indx->idx2vbn_bits;
 
 	return 0;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index eb7a8c9fba01..05f169018c4e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -37,7 +37,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	bool is_dir;
 	unsigned long ino = inode->i_ino;
 	u32 rp_fa = 0, asize, t32;
-	u16 roff, rsize, names = 0;
+	u16 roff, rsize, names = 0, links = 0;
 	const struct ATTR_FILE_NAME *fname = NULL;
 	const struct INDEX_ROOT *root;
 	struct REPARSE_DATA_BUFFER rp; // 0x18 bytes
@@ -200,11 +200,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		    rsize < SIZEOF_ATTRIBUTE_FILENAME)
 			goto out;
 
+		names += 1;
 		fname = Add2Ptr(attr, roff);
 		if (fname->type == FILE_NAME_DOS)
 			goto next_attr;
 
-		names += 1;
+		links += 1;
 		if (name && name->len == fname->name_len &&
 		    !ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len,
 					NULL, false))
@@ -429,7 +430,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		ni->mi.dirty = true;
 	}
 
-	set_nlink(inode, names);
+	set_nlink(inode, links);
 
 	if (S_ISDIR(mode)) {
 		ni->std_fa |= FILE_ATTRIBUTE_DIRECTORY;
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 6aa3a9d44df1..6c76503edc20 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -534,16 +534,9 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	if (aoff + asize > used)
 		return false;
 
-	if (ni && is_attr_indexed(attr)) {
+	if (ni && is_attr_indexed(attr) && attr->type == ATTR_NAME) {
 		u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
-		struct ATTR_FILE_NAME *fname =
-			attr->type != ATTR_NAME ?
-				NULL :
-				resident_data_ex(attr,
-						 SIZEOF_ATTRIBUTE_FILENAME);
-		if (fname && fname->type == FILE_NAME_DOS) {
-			/* Do not decrease links count deleting DOS name. */
-		} else if (!links) {
+		if (!links) {
 			/* minor error. Not critical. */
 		} else {
 			ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cef5467fd928..4643b06b1550 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1804,8 +1804,6 @@ static int __init init_ntfs_fs(void)
 {
 	int err;
 
-	pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
-
 	if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
 		pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
 	if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index c4b65a6d41cc..5cf1809d47bd 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -355,10 +355,10 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 	return inode;
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
+static int openpromfs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -366,7 +366,6 @@ static const struct super_operations openprom_sops = {
 	.alloc_inode	= openprom_alloc_inode,
 	.free_inode	= openprom_free_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
@@ -415,6 +414,7 @@ static int openpromfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations openpromfs_context_ops = {
 	.get_tree	= openpromfs_get_tree,
+	.reconfigure	= openpromfs_reconfigure,
 };
 
 static int openpromfs_init_fs_context(struct fs_context *fc)
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index a2f0a2edceb8..e0a6b758094f 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -165,8 +165,12 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
 				      GFP_KERNEL);
-		if (share->path)
+		if (share->path) {
 			share->path_sz = strlen(share->path);
+			while (share->path_sz > 1 &&
+			       share->path[share->path_sz - 1] == '/')
+				share->path[--share->path_sz] = '\0';
+		}
 		share->create_mask = resp->create_mask;
 		share->directory_mask = resp->directory_mask;
 		share->force_create_mode = resp->force_create_mode;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index dc729ab980dc..2292ca6ff00b 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -613,19 +613,24 @@ static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
 		if (opinfo->op_state == OPLOCK_CLOSING)
 			return -ENOENT;
 		else if (opinfo->level <= req_op_level) {
-			if (opinfo->is_lease &&
-			    opinfo->o_lease->state !=
-			     (SMB2_LEASE_HANDLE_CACHING_LE |
-			      SMB2_LEASE_READ_CACHING_LE))
+			if (opinfo->is_lease == false)
+				return 1;
+
+			if (opinfo->o_lease->state !=
+			    (SMB2_LEASE_HANDLE_CACHING_LE |
+			     SMB2_LEASE_READ_CACHING_LE))
 				return 1;
 		}
 	}
 
 	if (opinfo->level <= req_op_level) {
-		if (opinfo->is_lease &&
-		    opinfo->o_lease->state !=
-		     (SMB2_LEASE_HANDLE_CACHING_LE |
-		      SMB2_LEASE_READ_CACHING_LE)) {
+		if (opinfo->is_lease == false) {
+			wake_up_oplock_break(opinfo);
+			return 1;
+		}
+		if (opinfo->o_lease->state !=
+		    (SMB2_LEASE_HANDLE_CACHING_LE |
+		     SMB2_LEASE_READ_CACHING_LE)) {
 			wake_up_oplock_break(opinfo);
 			return 1;
 		}
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 863b2e7add29..472359a9d675 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -463,9 +463,15 @@ struct drm_dp_aux {
 	 * @is_remote: Is this AUX CH actually using sideband messaging.
 	 */
 	bool is_remote;
+
+	/**
+	 * @powered_down: If true then the remote endpoint is powered down.
+	 */
+	bool powered_down;
 };
 
 int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset);
+void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered);
 ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 			 void *buffer, size_t size);
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
index 566497eeb3b8..bc1f6b378195 100644
--- a/include/drm/drm_displayid.h
+++ b/include/drm/drm_displayid.h
@@ -30,7 +30,6 @@ struct drm_edid;
 #define VESA_IEEE_OUI				0x3a0292
 
 /* DisplayID Structure versions */
-#define DISPLAY_ID_STRUCTURE_VER_12		0x12
 #define DISPLAY_ID_STRUCTURE_VER_20		0x20
 
 /* DisplayID Structure v1r2 Data Blocks */
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index c0aec0d4d664..3011d33eccbd 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -241,9 +241,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
 					    u16 value);
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps);
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps);
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..de1263b1da3b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -573,9 +573,13 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_CPCV2_SUPPORT			0x00000040
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
+#define OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT	0x00000200
+#define OSC_SB_OVER_16_PSTATES_SUPPORT		0x00000400
+#define OSC_SB_GED_SUPPORT			0x00000800
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
-#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
+#define OSC_SB_IRQ_RESOURCE_SOURCE_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..f7f5a783da2a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,7 @@ __check_bitop_pr(__test_and_set_bit);
 __check_bitop_pr(__test_and_clear_bit);
 __check_bitop_pr(__test_and_change_bit);
 __check_bitop_pr(test_bit);
+__check_bitop_pr(test_bit_acquire);
 
 #undef __check_bitop_pr
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8654714421a0..75f0344bd3b9 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -219,7 +219,18 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
+#else
+static inline bool cpu_mitigations_off(void)
+{
+	return true;
+}
+static inline bool cpu_mitigations_auto_nosmt(void)
+{
+	return false;
+}
+#endif
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6bfe70decc9f..ae80a303c216 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -129,6 +129,16 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 		_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
 	})
 
+/*
+ * Dummy dev_printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define dev_no_printk(level, dev, fmt, ...)				\
+	({								\
+		if (0)							\
+			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
+	})
+
 /*
  * #defines for all the dev_<level> macros to prefix with whatever
  * possible use of #define dev_fmt(fmt) ...
@@ -158,10 +168,7 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #define dev_dbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #ifdef CONFIG_PRINTK
@@ -247,20 +254,14 @@ do {									\
 } while (0)
 #else
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-} while (0)
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #ifdef VERBOSE_DEBUG
 #define dev_vdbg	dev_dbg
 #else
 #define dev_vdbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05dc9624897d..25ca209e4d21 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -686,6 +686,10 @@ extern int fb_deferred_io_fsync(struct file *file, loff_t start,
 	__FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, sys) \
 	__FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, sys)
 
+#define FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(__prefix, __damage_range, __damage_area) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_RDWR(__prefix, __damage_range, sys) \
+	__FB_GEN_DEFAULT_DEFERRED_OPS_DRAW(__prefix, __damage_area, sys)
+
 /*
  * Initializes struct fb_ops for deferred I/O.
  */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 08ecac9d7b8b..10e32c8ef1e9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/maple_tree.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3259,13 +3260,16 @@ extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
 struct offset_ctx {
-	struct xarray		xa;
-	u32			next_offset;
+	struct maple_tree	mt;
+	unsigned long		next_offset;
 };
 
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
+int simple_offset_empty(struct dentry *dentry);
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 83c4d060a559..b69771a2e4e7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5145,7 +5145,7 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 		info_len += 1;
 
 	return prof->sta_info_len >= info_len &&
-	       fixed + prof->sta_info_len <= len;
+	       fixed + prof->sta_info_len - 1 <= len;
 }
 
 /**
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 401348e9f92b..7e2b1de3996a 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -59,6 +59,14 @@ static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 	return 0;
 }
 
+static inline int ksm_execve(struct mm_struct *mm)
+{
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		return __ksm_enter(mm);
+
+	return 0;
+}
+
 static inline void ksm_exit(struct mm_struct *mm)
 {
 	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
@@ -107,6 +115,11 @@ static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 	return 0;
 }
 
+static inline int ksm_execve(struct mm_struct *mm)
+{
+	return 0;
+}
+
 static inline void ksm_exit(struct mm_struct *mm)
 {
 }
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index b3d63123b945..a53ad4dabd7e 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -171,6 +171,7 @@ enum maple_type {
 #define MT_FLAGS_LOCK_IRQ	0x100
 #define MT_FLAGS_LOCK_BH	0x200
 #define MT_FLAGS_LOCK_EXTERN	0x300
+#define MT_FLAGS_ALLOC_WRAPPED	0x0800
 
 #define MAPLE_HEIGHT_MAX	31
 
@@ -319,6 +320,9 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp);
+int mtree_alloc_cyclic(struct maple_tree *mt, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp);
 int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp);
@@ -499,6 +503,9 @@ void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
+int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 41f03b352401..38d425a187fa 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -861,6 +861,7 @@ struct mlx5_cmd_work_ent {
 	void		       *context;
 	int			idx;
 	struct completion	handling;
+	struct completion	slotted;
 	struct completion	done;
 	struct mlx5_cmd        *cmd;
 	struct work_struct	work;
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 915033a75731..1d43371fafd2 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -36,12 +36,7 @@ int memory_add_physaddr_to_nid(u64 start);
 int phys_to_target_node(u64 start);
 #endif
 
-#ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
-{
-	return NUMA_NO_MEMBLK;
-}
-#endif
+int numa_fill_memblks(u64 start, u64 end);
 
 #else /* !CONFIG_NUMA */
 static inline int numa_nearest_node(int node, unsigned int state)
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 51af56522915..ab4fa7751623 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -321,7 +321,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * @count: Number of elements in the array; must be compile-time const.
  * @initializer: initializer expression (could be empty for no init).
  */
-#define _DEFINE_FLEX(type, name, member, count, initializer)			\
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
 		       "onstack flex array members require compile-time const count"); \
 	union {									\
@@ -331,8 +331,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	type *name = (type *)&name##_u
 
 /**
- * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
- * flexible array member.
+ * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member, when it does not have a __counted_by annotation.
  *
  * @type: structure type name, including "struct" keyword.
  * @name: Name for a variable to define.
@@ -343,7 +343,24 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@name) to get compile-time size of it afterwards.
  */
-#define DEFINE_FLEX(type, name, member, count)			\
+#define DEFINE_RAW_FLEX(type, name, member, count)	\
 	_DEFINE_FLEX(type, name, member, count, = {})
 
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @TYPE: structure type name, including "struct" keyword.
+ * @NAME: Name for a variable to define.
+ * @MEMBER: Name of the array member.
+ * @COUNTER: Name of the __counted_by member.
+ * @COUNT: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@NAME) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 955e31860095..2fde40cc9677 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -126,7 +126,7 @@ struct va_format {
 #define no_printk(fmt, ...)				\
 ({							\
 	if (0)						\
-		printk(fmt, ##__VA_ARGS__);		\
+		_printk(fmt, ##__VA_ARGS__);		\
 	0;						\
 })
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index fcc2c4496f73..07af6910bdce 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -271,7 +271,6 @@ struct pwm_ops {
  * @id: unique number of this PWM chip
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
- * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
  * @pwms: array of PWM devices allocated by the framework
  */
@@ -284,13 +283,17 @@ struct pwm_chip {
 
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
-	unsigned int of_pwm_n_cells;
 	bool atomic;
 
 	/* only used internally by the PWM framework */
 	struct pwm_device *pwms;
 };
 
+static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
+{
+	return chip->dev;
+}
+
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..c0d74f97fd18 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -117,7 +117,6 @@ struct stmmac_axi {
 
 #define EST_GCL		1024
 struct stmmac_est {
-	struct mutex lock;
 	int enable;
 	u32 btr_reserve[2];
 	u32 btr_offset[2];
@@ -127,6 +126,7 @@ struct stmmac_est {
 	u32 gcl_unaligned[EST_GCL];
 	u32 gcl[EST_GCL];
 	u32 gcl_size;
+	u32 max_sdu[MTL_MAX_TX_QUEUES];
 };
 
 struct stmmac_rxq_cfg {
diff --git a/include/net/ax25.h b/include/net/ax25.h
index 0d939e5aee4e..c2a85fd3f5ea 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -216,7 +216,7 @@ typedef struct {
 struct ctl_table;
 
 typedef struct ax25_dev {
-	struct ax25_dev		*next;
+	struct list_head	list;
 
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
@@ -330,7 +330,6 @@ int ax25_addr_size(const ax25_digi *);
 void ax25_digi_invert(const ax25_digi *, ax25_digi *);
 
 /* ax25_dev.c */
-extern ax25_dev *ax25_dev_list;
 extern spinlock_t ax25_dev_lock;
 
 #if IS_ENABLED(CONFIG_AX25)
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index eaec5d6caa29..b3228bd6cd6b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -285,7 +285,7 @@ void bt_err_ratelimited(const char *fmt, ...);
 	bt_err_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 
 /* Connection and socket states */
-enum {
+enum bt_sock_state {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
 	BT_OPEN,
 	BT_BOUND,
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f9db2d1ca5d3..9eb3d2360b1a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -33,9 +33,6 @@
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
 #define HCI_LINK_KEY_SIZE	16
-#define HCI_AMP_LINK_KEY_SIZE	(2 * HCI_LINK_KEY_SIZE)
-
-#define HCI_MAX_AMP_ASSOC_SIZE	672
 
 #define HCI_MAX_CPB_DATA_SIZE	252
 
@@ -71,26 +68,6 @@
 #define HCI_SMD		9
 #define HCI_VIRTIO	10
 
-/* HCI controller types */
-#define HCI_PRIMARY	0x00
-#define HCI_AMP		0x01
-
-/* First BR/EDR Controller shall have ID = 0 */
-#define AMP_ID_BREDR	0x00
-
-/* AMP controller types */
-#define AMP_TYPE_BREDR	0x00
-#define AMP_TYPE_80211	0x01
-
-/* AMP controller status */
-#define AMP_STATUS_POWERED_DOWN			0x00
-#define AMP_STATUS_BLUETOOTH_ONLY		0x01
-#define AMP_STATUS_NO_CAPACITY			0x02
-#define AMP_STATUS_LOW_CAPACITY			0x03
-#define AMP_STATUS_MEDIUM_CAPACITY		0x04
-#define AMP_STATUS_HIGH_CAPACITY		0x05
-#define AMP_STATUS_FULL_CAPACITY		0x06
-
 /* HCI device quirks */
 enum {
 	/* When this quirk is set, the HCI Reset command is send when
@@ -527,7 +504,6 @@ enum {
 #define ESCO_LINK	0x02
 /* Low Energy links do not have defined link type. Use invented one */
 #define LE_LINK		0x80
-#define AMP_LINK	0x81
 #define ISO_LINK	0x82
 #define INVALID_LINK	0xff
 
@@ -943,56 +919,6 @@ struct hci_cp_io_capability_neg_reply {
 	__u8     reason;
 } __packed;
 
-#define HCI_OP_CREATE_PHY_LINK		0x0435
-struct hci_cp_create_phy_link {
-	__u8     phy_handle;
-	__u8     key_len;
-	__u8     key_type;
-	__u8     key[HCI_AMP_LINK_KEY_SIZE];
-} __packed;
-
-#define HCI_OP_ACCEPT_PHY_LINK		0x0436
-struct hci_cp_accept_phy_link {
-	__u8     phy_handle;
-	__u8     key_len;
-	__u8     key_type;
-	__u8     key[HCI_AMP_LINK_KEY_SIZE];
-} __packed;
-
-#define HCI_OP_DISCONN_PHY_LINK		0x0437
-struct hci_cp_disconn_phy_link {
-	__u8     phy_handle;
-	__u8     reason;
-} __packed;
-
-struct ext_flow_spec {
-	__u8       id;
-	__u8       stype;
-	__le16     msdu;
-	__le32     sdu_itime;
-	__le32     acc_lat;
-	__le32     flush_to;
-} __packed;
-
-#define HCI_OP_CREATE_LOGICAL_LINK	0x0438
-#define HCI_OP_ACCEPT_LOGICAL_LINK	0x0439
-struct hci_cp_create_accept_logical_link {
-	__u8                  phy_handle;
-	struct ext_flow_spec  tx_flow_spec;
-	struct ext_flow_spec  rx_flow_spec;
-} __packed;
-
-#define HCI_OP_DISCONN_LOGICAL_LINK	0x043a
-struct hci_cp_disconn_logical_link {
-	__le16   log_handle;
-} __packed;
-
-#define HCI_OP_LOGICAL_LINK_CANCEL	0x043b
-struct hci_cp_logical_link_cancel {
-	__u8     phy_handle;
-	__u8     flow_spec_id;
-} __packed;
-
 #define HCI_OP_ENHANCED_SETUP_SYNC_CONN		0x043d
 struct hci_coding_format {
 	__u8	id;
@@ -1614,46 +1540,6 @@ struct hci_rp_read_enc_key_size {
 	__u8     key_size;
 } __packed;
 
-#define HCI_OP_READ_LOCAL_AMP_INFO	0x1409
-struct hci_rp_read_local_amp_info {
-	__u8     status;
-	__u8     amp_status;
-	__le32   total_bw;
-	__le32   max_bw;
-	__le32   min_latency;
-	__le32   max_pdu;
-	__u8     amp_type;
-	__le16   pal_cap;
-	__le16   max_assoc_size;
-	__le32   max_flush_to;
-	__le32   be_flush_to;
-} __packed;
-
-#define HCI_OP_READ_LOCAL_AMP_ASSOC	0x140a
-struct hci_cp_read_local_amp_assoc {
-	__u8     phy_handle;
-	__le16   len_so_far;
-	__le16   max_len;
-} __packed;
-struct hci_rp_read_local_amp_assoc {
-	__u8     status;
-	__u8     phy_handle;
-	__le16   rem_len;
-	__u8     frag[];
-} __packed;
-
-#define HCI_OP_WRITE_REMOTE_AMP_ASSOC	0x140b
-struct hci_cp_write_remote_amp_assoc {
-	__u8     phy_handle;
-	__le16   len_so_far;
-	__le16   rem_len;
-	__u8     frag[];
-} __packed;
-struct hci_rp_write_remote_amp_assoc {
-	__u8     status;
-	__u8     phy_handle;
-} __packed;
-
 #define HCI_OP_GET_MWS_TRANSPORT_CONFIG	0x140c
 
 #define HCI_OP_ENABLE_DUT_MODE		0x1803
@@ -2034,7 +1920,7 @@ struct hci_cp_le_set_ext_adv_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
@@ -2043,7 +1929,7 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_ADV_ENABLE		0x2039
@@ -2069,7 +1955,7 @@ struct hci_cp_le_set_per_adv_data {
 	__u8  handle;
 	__u8  operation;
 	__u8  length;
-	__u8  data[];
+	__u8  data[] __counted_by(length);
 } __packed;
 
 #define HCI_OP_LE_SET_PER_ADV_ENABLE		0x2040
@@ -2170,7 +2056,7 @@ struct hci_cis {
 
 struct hci_cp_le_create_cis {
 	__u8    num_cis;
-	struct hci_cis cis[];
+	struct hci_cis cis[] __counted_by(num_cis);
 } __packed;
 
 #define HCI_OP_LE_REMOVE_CIG			0x2065
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8504e10f5170..5277c6d5134c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -126,7 +126,6 @@ enum suspended_state {
 struct hci_conn_hash {
 	struct list_head list;
 	unsigned int     acl_num;
-	unsigned int     amp_num;
 	unsigned int     sco_num;
 	unsigned int     iso_num;
 	unsigned int     le_num;
@@ -247,6 +246,7 @@ struct adv_info {
 	bool	periodic;
 	__u8	mesh;
 	__u8	instance;
+	__u8	handle;
 	__u32	flags;
 	__u16	timeout;
 	__u16	remaining_time;
@@ -341,14 +341,6 @@ struct adv_monitor {
 /* Default authenticated payload timeout 30s */
 #define DEFAULT_AUTH_PAYLOAD_TIMEOUT   0x0bb8
 
-struct amp_assoc {
-	__u16	len;
-	__u16	offset;
-	__u16	rem_len;
-	__u16	len_so_far;
-	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
-};
-
 #define HCI_MAX_PAGES	3
 
 struct hci_dev {
@@ -361,7 +353,6 @@ struct hci_dev {
 	unsigned long	flags;
 	__u16		id;
 	__u8		bus;
-	__u8		dev_type;
 	bdaddr_t	bdaddr;
 	bdaddr_t	setup_addr;
 	bdaddr_t	public_addr;
@@ -467,21 +458,6 @@ struct hci_dev {
 	__u16		sniff_min_interval;
 	__u16		sniff_max_interval;
 
-	__u8		amp_status;
-	__u32		amp_total_bw;
-	__u32		amp_max_bw;
-	__u32		amp_min_latency;
-	__u32		amp_max_pdu;
-	__u8		amp_type;
-	__u16		amp_pal_cap;
-	__u16		amp_assoc_size;
-	__u32		amp_max_flush_to;
-	__u32		amp_be_flush_to;
-
-	struct amp_assoc	loc_assoc;
-
-	__u8		flow_ctl_mode;
-
 	unsigned int	auto_accept_delay;
 
 	unsigned long	quirks;
@@ -501,11 +477,6 @@ struct hci_dev {
 	unsigned int	le_pkts;
 	unsigned int	iso_pkts;
 
-	__u16		block_len;
-	__u16		block_mtu;
-	__u16		num_blocks;
-	__u16		block_cnt;
-
 	unsigned long	acl_last_tx;
 	unsigned long	sco_last_tx;
 	unsigned long	le_last_tx;
@@ -778,7 +749,6 @@ struct hci_conn {
 	void		*l2cap_data;
 	void		*sco_data;
 	void		*iso_data;
-	struct amp_mgr	*amp_mgr;
 
 	struct list_head link_list;
 	struct hci_conn	*parent;
@@ -805,7 +775,6 @@ struct hci_chan {
 	struct sk_buff_head data_q;
 	unsigned int	sent;
 	__u8		state;
-	bool		amp;
 };
 
 struct hci_conn_params {
@@ -1014,9 +983,6 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case ACL_LINK:
 		h->acl_num++;
 		break;
-	case AMP_LINK:
-		h->amp_num++;
-		break;
 	case LE_LINK:
 		h->le_num++;
 		if (c->role == HCI_ROLE_SLAVE)
@@ -1043,9 +1009,6 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case ACL_LINK:
 		h->acl_num--;
 		break;
-	case AMP_LINK:
-		h->amp_num--;
-		break;
 	case LE_LINK:
 		h->le_num--;
 		if (c->role == HCI_ROLE_SLAVE)
@@ -1067,8 +1030,6 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	switch (type) {
 	case ACL_LINK:
 		return h->acl_num;
-	case AMP_LINK:
-		return h->amp_num;
 	case LE_LINK:
 		return h->le_num;
 	case SCO_LINK:
@@ -1085,7 +1046,7 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
+	return c->acl_num + c->sco_num + c->le_num + c->iso_num;
 }
 
 static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
@@ -1533,8 +1494,8 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, struct bt_iso_qos *qos,
 				 __u8 data_len, __u8 *data);
-int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid, struct bt_iso_qos *qos);
+struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
+		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
@@ -1611,10 +1572,6 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 			}
 			break;
 
-		case AMP_LINK:
-			timeo = conn->disc_timeout;
-			break;
-
 		default:
 			timeo = 0;
 			break;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a4278aa618ab..3434cfc26b6a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -548,6 +548,9 @@ struct l2cap_chan {
 	__u16		tx_credits;
 	__u16		rx_credits;
 
+	/* estimated available receive buffer space or -1 if unknown */
+	ssize_t		rx_avail;
+
 	__u8		tx_state;
 	__u8		rx_state;
 
@@ -682,10 +685,15 @@ struct l2cap_user {
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 
+struct l2cap_rx_busy {
+	struct list_head	list;
+	struct sk_buff		*skb;
+};
+
 struct l2cap_pinfo {
 	struct bt_sock		bt;
 	struct l2cap_chan	*chan;
-	struct sk_buff		*rx_busy_skb;
+	struct list_head	rx_busy;
 };
 
 enum {
@@ -943,6 +951,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d400fe2e8668..df9b578e58bb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -932,6 +932,8 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
+ * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
+ *	due to scanning, not in normal operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -952,6 +954,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
+	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f6eba9652d01..ab62e53f187c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1494,11 +1494,10 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
-/* Assume a conservative default of 1200 bytes of payload per 4K page.
+/* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
-#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
-				   SKB_TRUESIZE(4096))
+#define TCP_DEFAULT_SCALING_RATIO (1 << (TCP_RMEM_TO_WIN_SCALE - 1))
 
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 4d8ef71090af..97a434d02135 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,6 +12,8 @@
 #define DAPM_DIRECT "(direct)"
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
+TRACE_DEFINE_ENUM(SND_SOC_DAPM_DIR_OUT);
+
 struct snd_soc_jack;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..83f31916e263 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7040,7 +7040,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
index af798f4c9680..3cc7d633456b 100644
--- a/include/uapi/linux/virtio_bt.h
+++ b/include/uapi/linux/virtio_bt.h
@@ -13,7 +13,6 @@
 
 enum virtio_bt_config_type {
 	VIRTIO_BT_CONFIG_TYPE_PRIMARY	= 0,
-	VIRTIO_BT_CONFIG_TYPE_AMP	= 1,
 };
 
 enum virtio_bt_config_vendor {
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 522196dfb0ff..318ed067dbf6 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -564,10 +564,7 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 		 * clear the stalled flag.
 		 */
 		work = io_get_next_work(acct, worker);
-		raw_spin_unlock(&acct->lock);
 		if (work) {
-			__io_worker_busy(wq, worker);
-
 			/*
 			 * Make sure cancelation can find this, even before
 			 * it becomes the active work. That avoids a window
@@ -578,9 +575,15 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 			raw_spin_lock(&worker->lock);
 			worker->next_work = work;
 			raw_spin_unlock(&worker->lock);
-		} else {
-			break;
 		}
+
+		raw_spin_unlock(&acct->lock);
+
+		if (!work)
+			break;
+
+		__io_worker_busy(wq, worker);
+
 		io_assign_current_work(worker, work);
 		__set_current_state(TASK_RUNNING);
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index d5495710c178..c0cff024db7b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -301,7 +301,7 @@ static inline int io_run_task_work(void)
 
 static inline bool io_task_work_pending(struct io_ring_ctx *ctx)
 {
-	return task_work_pending(current) || !wq_list_empty(&ctx->work_llist);
+	return task_work_pending(current) || !llist_empty(&ctx->work_llist);
 }
 
 static inline void io_tw_lock(struct io_ring_ctx *ctx, struct io_tw_state *ts)
diff --git a/io_uring/net.c b/io_uring/net.c
index 46ea09e1e382..dbabe0058f1c 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -311,7 +311,10 @@ int io_send_prep_async(struct io_kiocb *req)
 	struct io_async_msghdr *io;
 	int ret;
 
-	if (!zc->addr || req_has_async_data(req))
+	if (req_has_async_data(req))
+		return 0;
+	zc->done_io = 0;
+	if (!zc->addr)
 		return 0;
 	io = io_msg_alloc_async_prep(req);
 	if (!io)
@@ -338,8 +341,10 @@ static int io_setup_async_addr(struct io_kiocb *req,
 
 int io_sendmsg_prep_async(struct io_kiocb *req)
 {
+	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 	int ret;
 
+	sr->done_io = 0;
 	if (!io_msg_alloc_async_prep(req))
 		return -ENOMEM;
 	ret = io_sendmsg_copy_hdr(req, req->async_data);
@@ -359,6 +364,8 @@ int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
+	sr->done_io = 0;
+
 	if (req->opcode == IORING_OP_SEND) {
 		if (READ_ONCE(sqe->__pad3[0]))
 			return -EINVAL;
@@ -381,7 +388,6 @@ int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (req->ctx->compat)
 		sr->msg_flags |= MSG_CMSG_COMPAT;
 #endif
-	sr->done_io = 0;
 	return 0;
 }
 
@@ -585,9 +591,11 @@ static int io_recvmsg_copy_hdr(struct io_kiocb *req,
 
 int io_recvmsg_prep_async(struct io_kiocb *req)
 {
+	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 	struct io_async_msghdr *iomsg;
 	int ret;
 
+	sr->done_io = 0;
 	if (!io_msg_alloc_async_prep(req))
 		return -ENOMEM;
 	iomsg = req->async_data;
@@ -603,6 +611,8 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
+	sr->done_io = 0;
+
 	if (unlikely(sqe->file_index || sqe->addr2))
 		return -EINVAL;
 
@@ -639,7 +649,6 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (req->ctx->compat)
 		sr->msg_flags |= MSG_CMSG_COMPAT;
 #endif
-	sr->done_io = 0;
 	sr->nr_multishot_loops = 0;
 	return 0;
 }
@@ -1019,6 +1028,9 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *notif;
 
+	zc->done_io = 0;
+	req->flags |= REQ_F_POLL_NO_LAZY;
+
 	if (unlikely(READ_ONCE(sqe->__pad2[0]) || READ_ONCE(sqe->addr3)))
 		return -EINVAL;
 	/* we don't support IOSQE_CQE_SKIP_SUCCESS just yet */
@@ -1071,8 +1083,6 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (zc->msg_flags & MSG_DONTWAIT)
 		req->flags |= REQ_F_NOWAIT;
 
-	zc->done_io = 0;
-
 #ifdef CONFIG_COMPAT
 	if (req->ctx->compat)
 		zc->msg_flags |= MSG_CMSG_COMPAT;
@@ -1318,7 +1328,7 @@ void io_sendrecv_fail(struct io_kiocb *req)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
-	if (req->flags & REQ_F_PARTIAL_IO)
+	if (sr->done_io)
 		req->cqe.res = sr->done_io;
 
 	if ((req->flags & REQ_F_NEED_CLEANUP) &&
diff --git a/io_uring/nop.c b/io_uring/nop.c
index d956599a3c1b..1a4e312dfe51 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -12,6 +12,8 @@
 
 int io_nop_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
+	if (READ_ONCE(sqe->rw_flags))
+		return -EINVAL;
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0f90b6b27430..1860ba343726 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3852,6 +3852,11 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 			 * check permissions at attach time.
 			 */
 			return -EPERM;
+
+		ptype = attach_type_to_prog_type(attach_type);
+		if (prog->type != ptype)
+			return -EINVAL;
+
 		return prog->enforce_expected_attach_type &&
 			prog->expected_attach_type != attach_type ?
 			-EINVAL : 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11bc3af33f34..6edfcc337508 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2328,6 +2328,8 @@ static void mark_btf_ld_reg(struct bpf_verifier_env *env,
 	regs[regno].type = PTR_TO_BTF_ID | flag;
 	regs[regno].btf = btf;
 	regs[regno].btf_id = btf_id;
+	if (type_may_be_null(flag))
+		regs[regno].id = ++env->id_gen;
 }
 
 #define DEF_NOT_SUBREG	(0)
@@ -3584,7 +3586,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * sreg needs precision before this insn
 				 */
 				bt_clear_reg(bt, dreg);
-				bt_set_reg(bt, sreg);
+				if (sreg != BPF_REG_FP)
+					bt_set_reg(bt, sreg);
 			} else {
 				/* dreg = K
 				 * dreg needs precision after this insn.
@@ -3600,7 +3603,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * both dreg and sreg need precision
 				 * before this insn
 				 */
-				bt_set_reg(bt, sreg);
+				if (sreg != BPF_REG_FP)
+					bt_set_reg(bt, sreg);
 			} /* else dreg += K
 			   * dreg still needs precision before this insn
 			   */
@@ -5320,8 +5324,6 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_field->kptr.btf,
 				kptr_field->kptr.btf_id, btf_ld_kptr_type(env, kptr_field));
-		/* For mark_ptr_or_null_reg */
-		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
@@ -5632,7 +5634,8 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
 		return true;
 
 	/* Types listed in the reg2btf_ids are always trusted */
-	if (reg2btf_ids[base_type(reg->type)])
+	if (reg2btf_ids[base_type(reg->type)] &&
+	    !bpf_type_has_unsafe_modifiers(reg->type))
 		return true;
 
 	/* If a register is not referenced, it is trusted if it has the
@@ -6242,6 +6245,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
+#define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_trusted_or_null)
 
 /*
  * Allow list few fields as RCU trusted or full trusted.
@@ -6305,7 +6309,7 @@ BTF_TYPE_SAFE_TRUSTED(struct dentry) {
 	struct inode *d_inode;
 };
 
-BTF_TYPE_SAFE_TRUSTED(struct socket) {
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
@@ -6340,11 +6344,20 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
-	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
 
+static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
+				    struct bpf_reg_state *reg,
+				    const char *field_name, u32 btf_id)
+{
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+
+	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
+					  "__safe_trusted_or_null");
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -6453,6 +6466,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 */
 		if (type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
+		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
+			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {
 				/* ignore __rcu tag and mark it MEM_RCU */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 927bef3a598a..6d6e540bacbf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f8a0406ce8ba..bac70ea54e34 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3196,6 +3196,7 @@ void __init boot_cpu_hotplug_init(void)
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
+#ifdef CONFIG_CPU_MITIGATIONS
 /*
  * These are used for a global "mitigations=" cmdline option for toggling
  * optional CPU mitigations.
@@ -3206,9 +3207,7 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
-static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-					     CPU_MITIGATIONS_OFF;
+static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
@@ -3224,7 +3223,6 @@ static int __init mitigations_parse_cmdline(char *arg)
 
 	return 0;
 }
-early_param("mitigations", mitigations_parse_cmdline);
 
 /* mitigations=off */
 bool cpu_mitigations_off(void)
@@ -3239,3 +3237,11 @@ bool cpu_mitigations_auto_nosmt(void)
 	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
+#else
+static int __init mitigations_parse_cmdline(char *arg)
+{
+	pr_crit("Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable\n");
+	return 0;
+}
+#endif
+early_param("mitigations", mitigations_parse_cmdline);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 732ad5b39946..3f64268fe9ea 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1941,7 +1941,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%lu h:%lu/%lu/%lu",
+	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
 		data_race(n_trc_holdouts),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..b5ec62b2d850 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		// Print signed value, as negative values indicate a probable bug.
+		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..d3aef6283931 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11381,7 +11381,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg_get_cfs_burst(tg);
+	u64 burst = tg->cfs_bandwidth.burst;
 	u64 quota;
 	int ret;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aee5e7a70170..a01269ed968a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6669,22 +6669,42 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	unsigned long  rq_util_min, rq_util_max;
+
+	if (!sched_energy_enabled())
+		return false;
+
+	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
-static inline void update_overutilized_status(struct rq *rq)
+static inline void set_rd_overutilized_status(struct root_domain *rd,
+					      unsigned int status)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
-	}
+	if (!sched_energy_enabled())
+		return;
+
+	WRITE_ONCE(rd->overutilized, status);
+	trace_sched_overutilized_tp(rd, !!status);
+}
+
+static inline void check_update_overutilized_status(struct rq *rq)
+{
+	/*
+	 * overutilized field is used for load balancing decisions only
+	 * if energy aware scheduler is being used
+	 */
+	if (!sched_energy_enabled())
+		return;
+
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
-static inline void update_overutilized_status(struct rq *rq) { }
+static inline void check_update_overutilized_status(struct rq *rq) { }
 #endif
 
 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -6785,7 +6805,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * and the following generally works well enough in practice.
 	 */
 	if (!task_new)
-		update_overutilized_status(rq);
+		check_update_overutilized_status(rq);
 
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -10621,19 +10641,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
 	if (!env->sd->parent) {
-		struct root_domain *rd = env->dst_rq->rd;
-
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd,
+					   sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 	}
 
 	update_idle_cpu_scan(env, sum_util);
@@ -12639,7 +12654,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));
 
 	task_tick_core(rq, curr);
 }
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..82e2f7fc7c26 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -109,6 +109,7 @@ static void __init housekeeping_setup_type(enum hk_type type,
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
+	unsigned int first_cpu;
 	int err = 0;
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
@@ -129,7 +130,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
-	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
+	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		if (!housekeeping.flags) {
@@ -138,6 +140,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		}
 	}
 
+	if (cpumask_empty(non_housekeeping_mask))
+		goto free_housekeeping_staging;
+
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..4fdab14953fc 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 210cf5f8d92c..bd9716d7bb63 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -507,7 +507,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -562,8 +562,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -583,6 +582,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -918,7 +922,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83ba342aef31..2f80239348f5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1595,12 +1595,15 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	rec = lookup_rec(start, end);
 	if (rec)
-		return rec->ip;
+		ip = rec->ip;
+	rcu_read_unlock();
 
-	return 0;
+	return ip;
 }
 
 /**
@@ -1613,25 +1616,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	struct dyn_ftrace *rec;
+	unsigned long loc;
 	unsigned long offset;
 	unsigned long size;
 
-	rec = lookup_rec(ip, ip);
-	if (!rec) {
+	loc = ftrace_location_range(ip, ip);
+	if (!loc) {
 		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
 			goto out;
 
 		/* map sym+0 to __fentry__ */
 		if (!offset)
-			rec = lookup_rec(ip, ip + size - 1);
+			loc = ftrace_location_range(ip, ip + size - 1);
 	}
 
-	if (rec)
-		return rec->ip;
-
 out:
-	return 0;
+	return loc;
 }
 
 /**
@@ -6593,6 +6593,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6806,6 +6808,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -7139,6 +7144,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -7180,12 +7186,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -7202,6 +7204,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index faf56d9a9e88..943850b25fcb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1456,6 +1456,11 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
+ *
+ * Callers of this function need to guarantee that the list of pages doesn't get
+ * modified during the check. In particular, if it's possible that the function
+ * is invoked with concurrent readers which can swap in a new reader page then
+ * the caller should take cpu_buffer->reader_lock.
  */
 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -2205,8 +2210,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
+			unsigned long flags;
+
 			cpu_buffer = buffer->buffers[cpu];
+			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e76f5e1efdf2..704de62f7ae1 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -202,6 +202,8 @@ static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
 static void user_event_mm_put(struct user_event_mm *mm);
 static int destroy_user_event(struct user_event *user);
+static bool user_fields_match(struct user_event *user, int argc,
+			      const char **argv);
 
 static u32 user_event_key(char *name)
 {
@@ -1493,17 +1495,24 @@ static int destroy_user_event(struct user_event *user)
 }
 
 static struct user_event *find_user_event(struct user_event_group *group,
-					  char *name, u32 *outkey)
+					  char *name, int argc, const char **argv,
+					  u32 flags, u32 *outkey)
 {
 	struct user_event *user;
 	u32 key = user_event_key(name);
 
 	*outkey = key;
 
-	hash_for_each_possible(group->register_table, user, node, key)
-		if (!strcmp(EVENT_NAME(user), name))
+	hash_for_each_possible(group->register_table, user, node, key) {
+		if (strcmp(EVENT_NAME(user), name))
+			continue;
+
+		if (user_fields_match(user, argc, argv))
 			return user_event_get(user);
 
+		return ERR_PTR(-EADDRINUSE);
+	}
+
 	return NULL;
 }
 
@@ -1860,6 +1869,9 @@ static bool user_fields_match(struct user_event *user, int argc,
 	struct list_head *head = &user->fields;
 	int i = 0;
 
+	if (argc == 0)
+		return list_empty(head);
+
 	list_for_each_entry_reverse(field, head, link) {
 		if (!user_field_match(field, argc, argv, &i))
 			return false;
@@ -1880,10 +1892,8 @@ static bool user_event_match(const char *system, const char *event,
 	match = strcmp(EVENT_NAME(user), event) == 0 &&
 		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
 
-	if (match && argc > 0)
+	if (match)
 		match = user_fields_match(user, argc, argv);
-	else if (match && argc == 0)
-		match = list_empty(&user->fields);
 
 	return match;
 }
@@ -1913,6 +1923,80 @@ static int user_event_trace_register(struct user_event *user)
 	return ret;
 }
 
+/*
+ * Counts how many ';' without a trailing space are in the args.
+ */
+static int count_semis_no_space(char *args)
+{
+	int count = 0;
+
+	while ((args = strchr(args, ';'))) {
+		args++;
+
+		if (!isspace(*args))
+			count++;
+	}
+
+	return count;
+}
+
+/*
+ * Copies the arguments while ensuring all ';' have a trailing space.
+ */
+static char *insert_space_after_semis(char *args, int count)
+{
+	char *fixed, *pos;
+	int len;
+
+	len = strlen(args) + count;
+	fixed = kmalloc(len + 1, GFP_KERNEL);
+
+	if (!fixed)
+		return NULL;
+
+	pos = fixed;
+
+	/* Insert a space after ';' if there is no trailing space. */
+	while (*args) {
+		*pos = *args++;
+
+		if (*pos++ == ';' && !isspace(*args))
+			*pos++ = ' ';
+	}
+
+	*pos = '\0';
+
+	return fixed;
+}
+
+static char **user_event_argv_split(char *args, int *argc)
+{
+	char **split;
+	char *fixed;
+	int count;
+
+	/* Count how many ';' without a trailing space */
+	count = count_semis_no_space(args);
+
+	/* No fixup is required */
+	if (!count)
+		return argv_split(GFP_KERNEL, args, argc);
+
+	/* We must fixup 'field;field' to 'field; field' */
+	fixed = insert_space_after_semis(args, count);
+
+	if (!fixed)
+		return NULL;
+
+	/* We do a normal split afterwards */
+	split = argv_split(GFP_KERNEL, fixed, argc);
+
+	/* We can free since argv_split makes a copy */
+	kfree(fixed);
+
+	return split;
+}
+
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
@@ -1922,11 +2006,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
 			    struct user_event **newuser, int reg_flags)
 {
-	int ret;
-	u32 key;
 	struct user_event *user;
+	char **argv = NULL;
 	int argc = 0;
-	char **argv;
+	int ret;
+	u32 key;
 
 	/* Currently don't support any text based flags */
 	if (flags != NULL)
@@ -1935,41 +2019,34 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (!user_event_capable(reg_flags))
 		return -EPERM;
 
+	if (args) {
+		argv = user_event_argv_split(args, &argc);
+
+		if (!argv)
+			return -ENOMEM;
+	}
+
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
-	user = find_user_event(group, name, &key);
+	user = find_user_event(group, name, argc, (const char **)argv,
+			       reg_flags, &key);
 	mutex_unlock(&event_mutex);
 
-	if (user) {
-		if (args) {
-			argv = argv_split(GFP_KERNEL, args, &argc);
-			if (!argv) {
-				ret = -ENOMEM;
-				goto error;
-			}
+	if (argv)
+		argv_free(argv);
 
-			ret = user_fields_match(user, argc, (const char **)argv);
-			argv_free(argv);
-
-		} else
-			ret = list_empty(&user->fields);
-
-		if (ret) {
-			*newuser = user;
-			/*
-			 * Name is allocated by caller, free it since it already exists.
-			 * Caller only worries about failure cases for freeing.
-			 */
-			kfree(name);
-		} else {
-			ret = -EADDRINUSE;
-			goto error;
-		}
+	if (IS_ERR(user))
+		return PTR_ERR(user);
+
+	if (user) {
+		*newuser = user;
+		/*
+		 * Name is allocated by caller, free it since it already exists.
+		 * Caller only worries about failure cases for freeing.
+		 */
+		kfree(name);
 
 		return 0;
-error:
-		user_event_put(user, false);
-		return ret;
 	}
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
@@ -2052,25 +2129,33 @@ static int user_event_parse(struct user_event_group *group, char *name,
 }
 
 /*
- * Deletes a previously created event if it is no longer being used.
+ * Deletes previously created events if they are no longer being used.
  */
 static int delete_user_event(struct user_event_group *group, char *name)
 {
-	u32 key;
-	struct user_event *user = find_user_event(group, name, &key);
+	struct user_event *user;
+	struct hlist_node *tmp;
+	u32 key = user_event_key(name);
+	int ret = -ENOENT;
 
-	if (!user)
-		return -ENOENT;
+	/* Attempt to delete all event(s) with the name passed in */
+	hash_for_each_possible_safe(group->register_table, user, tmp, node, key) {
+		if (strcmp(EVENT_NAME(user), name))
+			continue;
 
-	user_event_put(user, true);
+		if (!user_event_last_ref(user))
+			return -EBUSY;
 
-	if (!user_event_last_ref(user))
-		return -EBUSY;
+		if (!user_event_capable(user->reg_flags))
+			return -EPERM;
 
-	if (!user_event_capable(user->reg_flags))
-		return -EPERM;
+		ret = destroy_user_event(user);
 
-	return destroy_user_event(user);
+		if (ret)
+			goto out;
+	}
+out:
+	return ret;
 }
 
 /*
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 2e4fedc81621..7830a9e64ead 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -229,28 +229,28 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(vmalloc)
 									\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc((alloc_pages) * PAGE_SIZE, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc_node((alloc_pages) * PAGE_SIZE, gfp, NUMA_NO_NODE), \
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvzalloc((alloc_pages) * PAGE_SIZE, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvzalloc_node((alloc_pages) * PAGE_SIZE, gfp, NUMA_NO_NODE), \
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvcalloc(1, (alloc_pages) * PAGE_SIZE, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvcalloc((alloc_pages) * PAGE_SIZE, 1, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc_array(1, (alloc_pages) * PAGE_SIZE, gfp),	\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc_array((alloc_pages) * PAGE_SIZE, 1, gfp),	\
-		vfree(p));						\
+		kvfree(p));						\
 									\
 	prev_size = (expected_pages) * PAGE_SIZE;			\
 	orig = kvmalloc(prev_size, gfp);				\
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 9ea399049749..3a31fe9ed6fc 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -51,7 +51,7 @@ int kunit_bus_init(void)
 
 	error = bus_register(&kunit_bus_type);
 	if (error)
-		bus_unregister(&kunit_bus_type);
+		root_device_unregister(kunit_bus_device);
 	return error;
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 1d1475578515..b8514dbb337c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -712,6 +712,9 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 {
 	unsigned int i;
 
+	if (num_suites == 0)
+		return 0;
+
 	if (!kunit_enabled() && num_suites > 0) {
 		pr_info("kunit: disabled\n");
 		return 0;
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index f7825991d576..d9d1df28cc52 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,6 +11,7 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/sched/task.h>
 
 #include "try-catch-impl.h"
 
@@ -65,13 +66,14 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	try_catch->context = context;
 	try_catch->try_completion = &try_completion;
 	try_catch->try_result = 0;
-	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
-				  try_catch,
-				  "kunit_try_catch_thread");
+	task_struct = kthread_create(kunit_generic_run_threadfn_adapter,
+				     try_catch, "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
 		try_catch->catch(try_catch->context);
 		return;
 	}
+	get_task_struct(task_struct);
+	wake_up_process(task_struct);
 
 	time_remaining = wait_for_completion_timeout(&try_completion,
 						     kunit_test_timeout());
@@ -81,6 +83,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		kthread_stop(task_struct);
 	}
 
+	put_task_struct(task_struct);
 	exit_code = try_catch->try_result;
 
 	if (!exit_code)
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d70db0575709..fe6092a1dc35 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4290,6 +4290,56 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
+/**
+ * mas_alloc_cyclic() - Internal call to find somewhere to store an entry
+ * @mas: The maple state.
+ * @startp: Pointer to ID.
+ * @range_lo: Lower bound of range to search.
+ * @range_hi: Upper bound of range to search.
+ * @entry: The entry to store.
+ * @next: Pointer to next ID to allocate.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Return: 0 if the allocation succeeded without wrapping, 1 if the
+ * allocation succeeded after wrapping, or -EBUSY if there are no
+ * free entries.
+ */
+int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp)
+{
+	unsigned long min = range_lo;
+	int ret = 0;
+
+	range_lo = max(min, *next);
+	ret = mas_empty_area(mas, range_lo, range_hi, 1);
+	if ((mas->tree->ma_flags & MT_FLAGS_ALLOC_WRAPPED) && ret == 0) {
+		mas->tree->ma_flags &= ~MT_FLAGS_ALLOC_WRAPPED;
+		ret = 1;
+	}
+	if (ret < 0 && range_lo > min) {
+		ret = mas_empty_area(mas, min, range_hi, 1);
+		if (ret == 0)
+			ret = 1;
+	}
+	if (ret < 0)
+		return ret;
+
+	do {
+		mas_insert(mas, entry);
+	} while (mas_nomem(mas, gfp));
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
+
+	*startp = mas->index;
+	*next = *startp + 1;
+	if (*next == 0)
+		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
+
+	return ret;
+}
+EXPORT_SYMBOL(mas_alloc_cyclic);
+
 static __always_inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 {
 retry:
@@ -6443,6 +6493,49 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 }
 EXPORT_SYMBOL(mtree_alloc_range);
 
+/**
+ * mtree_alloc_cyclic() - Find somewhere to store this entry in the tree.
+ * @mt: The maple tree.
+ * @startp: Pointer to ID.
+ * @range_lo: Lower bound of range to search.
+ * @range_hi: Upper bound of range to search.
+ * @entry: The entry to store.
+ * @next: Pointer to next ID to allocate.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * Finds an empty entry in @mt after @next, stores the new index into
+ * the @id pointer, stores the entry at that index, then updates @next.
+ *
+ * @mt must be initialized with the MT_FLAGS_ALLOC_RANGE flag.
+ *
+ * Context: Any context.  Takes and releases the mt.lock.  May sleep if
+ * the @gfp flags permit.
+ *
+ * Return: 0 if the allocation succeeded without wrapping, 1 if the
+ * allocation succeeded after wrapping, -ENOMEM if memory could not be
+ * allocated, -EINVAL if @mt cannot be used, or -EBUSY if there are no
+ * free entries.
+ */
+int mtree_alloc_cyclic(struct maple_tree *mt, unsigned long *startp,
+		void *entry, unsigned long range_lo, unsigned long range_hi,
+		unsigned long *next, gfp_t gfp)
+{
+	int ret;
+
+	MA_STATE(mas, mt, 0, 0);
+
+	if (!mt_is_alloc(mt))
+		return -EINVAL;
+	if (WARN_ON_ONCE(mt_is_reserved(entry)))
+		return -EINVAL;
+	mtree_lock(mt);
+	ret = mas_alloc_cyclic(&mas, startp, entry, range_lo, range_hi,
+			       next, gfp);
+	mtree_unlock(mt);
+	return ret;
+}
+EXPORT_SYMBOL(mtree_alloc_cyclic);
+
 int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 		void *entry, unsigned long size, unsigned long min,
 		unsigned long max, gfp_t gfp)
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index c527f6b75789..c85c8b121d35 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1113,6 +1113,24 @@ static void castable_to_type_test(struct kunit *test)
 #undef TEST_CASTABLE_TO_TYPE
 }
 
+struct foo {
+	int a;
+	u32 counter;
+	s16 array[] __counted_by(counter);
+};
+
+static void DEFINE_FLEX_test(struct kunit *test)
+{
+	DEFINE_RAW_FLEX(struct foo, two, array, 2);
+	DEFINE_FLEX(struct foo, eight, array, counter, 8);
+	DEFINE_FLEX(struct foo, empty, array, counter, 0);
+
+	KUNIT_EXPECT_EQ(test, __struct_size(two),
+			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
+	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
+}
+
 static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(u8_u8__u8_overflow_test),
 	KUNIT_CASE(s8_s8__s8_overflow_test),
@@ -1135,6 +1153,7 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(overflows_type_test),
 	KUNIT_CASE(same_type_test),
 	KUNIT_CASE(castable_to_type_test),
+	KUNIT_CASE(DEFINE_FLEX_test),
 	{}
 };
 
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index d4a3730b08fa..4ce960438806 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -55,7 +55,7 @@ static void test_next_pointer(struct kunit *test)
 
 	ptr_addr = (unsigned long *)(p + s->offset);
 	tmp = *ptr_addr;
-	p[s->offset] = 0x12;
+	p[s->offset] = ~p[s->offset];
 
 	/*
 	 * Expecting three errors.
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 717dcb830127..b823ba7cb6a1 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1226,8 +1226,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	unsigned long *src_pfns;
 	unsigned long *dst_pfns;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, start_pfn, npages);
 	for (i = 0; i < npages; i++) {
@@ -1250,8 +1250,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	}
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 }
 
 /* Removes free pages from the free list so they can't be re-allocated */
diff --git a/mm/shmem.c b/mm/shmem.c
index 5853f3ae36e5..935f3647bb3a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3368,7 +3368,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_empty(dentry))
+	if (!simple_offset_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3425,7 +3425,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_empty(new_dentry))
+	if (!simple_offset_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
@@ -3434,8 +3434,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 			return error;
 	}
 
-	simple_offset_remove(shmem_get_offset_ctx(old_dir), old_dentry);
-	error = simple_offset_add(shmem_get_offset_ctx(new_dir), old_dentry);
+	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (error)
 		return error;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 313f1c42768a..aa8f5a6c324e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -213,6 +213,38 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 	goto out;
 }
 
+static int mfill_atomic_pte_zeroed_folio(pmd_t *dst_pmd,
+					 struct vm_area_struct *dst_vma,
+					 unsigned long dst_addr)
+{
+	struct folio *folio;
+	int ret = -ENOMEM;
+
+	folio = vma_alloc_zeroed_movable_folio(dst_vma, dst_addr);
+	if (!folio)
+		return ret;
+
+	if (mem_cgroup_charge(folio, dst_vma->vm_mm, GFP_KERNEL))
+		goto out_put;
+
+	/*
+	 * The memory barrier inside __folio_mark_uptodate makes sure that
+	 * zeroing out the folio become visible before mapping the page
+	 * using set_pte_at(). See do_anonymous_page().
+	 */
+	__folio_mark_uptodate(folio);
+
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
+				       &folio->page, true, 0);
+	if (ret)
+		goto out_put;
+
+	return 0;
+out_put:
+	folio_put(folio);
+	return ret;
+}
+
 static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr)
@@ -221,6 +253,9 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 	spinlock_t *ptl;
 	int ret;
 
+	if (mm_forbids_zeropage(dst_vma->vm_mm))
+		return mfill_atomic_pte_zeroed_folio(dst_pmd, dst_vma, dst_addr);
+
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
 	ret = -EAGAIN;
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 282ec581c072..c9d55b99a7a5 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -22,11 +22,12 @@
 #include <net/sock.h>
 #include <linux/uaccess.h>
 #include <linux/fcntl.h>
+#include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-ax25_dev *ax25_dev_list;
+static LIST_HEAD(ax25_dev_list);
 DEFINE_SPINLOCK(ax25_dev_lock);
 
 ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
@@ -34,10 +35,11 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 	ax25_dev *ax25_dev, *res = NULL;
 
 	spin_lock_bh(&ax25_dev_lock);
-	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
+	list_for_each_entry(ax25_dev, &ax25_dev_list, list)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
 			ax25_dev_hold(ax25_dev);
+			break;
 		}
 	spin_unlock_bh(&ax25_dev_lock);
 
@@ -59,7 +61,6 @@ void ax25_dev_device_up(struct net_device *dev)
 	}
 
 	refcount_set(&ax25_dev->refcount, 1);
-	dev->ax25_ptr     = ax25_dev;
 	ax25_dev->dev     = dev;
 	netdev_hold(dev, &ax25_dev->dev_tracker, GFP_KERNEL);
 	ax25_dev->forward = NULL;
@@ -85,10 +86,9 @@ void ax25_dev_device_up(struct net_device *dev)
 #endif
 
 	spin_lock_bh(&ax25_dev_lock);
-	ax25_dev->next = ax25_dev_list;
-	ax25_dev_list  = ax25_dev;
+	list_add(&ax25_dev->list, &ax25_dev_list);
+	dev->ax25_ptr     = ax25_dev;
 	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_hold(ax25_dev);
 
 	ax25_register_dev_sysctl(ax25_dev);
 }
@@ -111,32 +111,19 @@ void ax25_dev_device_down(struct net_device *dev)
 	/*
 	 *	Remove any packet forwarding that points to this device.
 	 */
-	for (s = ax25_dev_list; s != NULL; s = s->next)
+	list_for_each_entry(s, &ax25_dev_list, list)
 		if (s->forward == dev)
 			s->forward = NULL;
 
-	if ((s = ax25_dev_list) == ax25_dev) {
-		ax25_dev_list = s->next;
-		goto unlock_put;
-	}
-
-	while (s != NULL && s->next != NULL) {
-		if (s->next == ax25_dev) {
-			s->next = ax25_dev->next;
-			goto unlock_put;
+	list_for_each_entry(s, &ax25_dev_list, list) {
+		if (s == ax25_dev) {
+			list_del(&s->list);
+			break;
 		}
-
-		s = s->next;
 	}
-	spin_unlock_bh(&ax25_dev_lock);
-	dev->ax25_ptr = NULL;
-	ax25_dev_put(ax25_dev);
-	return;
 
-unlock_put:
-	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_put(ax25_dev);
 	dev->ax25_ptr = NULL;
+	spin_unlock_bh(&ax25_dev_lock);
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
 }
@@ -200,16 +187,13 @@ struct net_device *ax25_fwd_dev(struct net_device *dev)
  */
 void __exit ax25_dev_free(void)
 {
-	ax25_dev *s, *ax25_dev;
+	ax25_dev *s, *n;
 
 	spin_lock_bh(&ax25_dev_lock);
-	ax25_dev = ax25_dev_list;
-	while (ax25_dev != NULL) {
-		s        = ax25_dev;
-		netdev_put(ax25_dev->dev, &ax25_dev->dev_tracker);
-		ax25_dev = ax25_dev->next;
+	list_for_each_entry_safe(s, n, &ax25_dev_list, list) {
+		netdev_put(s->dev, &s->dev_tracker);
+		list_del(&s->list);
 		kfree(s);
 	}
-	ax25_dev_list = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
 }
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9a369bc14fd5..7f78fc6c29cf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -1173,8 +1173,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
 
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
-		    hci_dev_test_flag(d, HCI_USER_CHANNEL) ||
-		    d->dev_type != HCI_PRIMARY)
+		    hci_dev_test_flag(d, HCI_USER_CHANNEL))
 			continue;
 
 		/* Simple routing:
@@ -2086,18 +2085,31 @@ static int create_pa_sync(struct hci_dev *hdev, void *data)
 	return hci_update_passive_scan_sync(hdev);
 }
 
-int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid, struct bt_iso_qos *qos)
+struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
+				    __u8 dst_type, __u8 sid,
+				    struct bt_iso_qos *qos)
 {
 	struct hci_cp_le_pa_create_sync *cp;
+	struct hci_conn *conn;
+	int err;
 
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
+
+	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
+	if (!conn)
+		return ERR_PTR(-ENOMEM);
+
+	conn->iso_qos = *qos;
+	conn->state = BT_LISTEN;
+
+	hci_conn_hold(conn);
 
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp) {
 		hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-		return -ENOMEM;
+		hci_conn_drop(conn);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	cp->options = qos->bcast.options;
@@ -2109,7 +2121,14 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	cp->sync_cte_type = qos->bcast.sync_cte_type;
 
 	/* Queue start pa_create_sync and scan */
-	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
+	err = hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
+	if (err < 0) {
+		hci_conn_drop(conn);
+		kfree(cp);
+		return ERR_PTR(err);
+	}
+
+	return conn;
 }
 
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index befe645d3f9b..e946ac46a176 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -395,11 +395,6 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
-	if (hdev->dev_type != HCI_PRIMARY) {
-		err = -EOPNOTSUPP;
-		goto done;
-	}
-
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		err = -EOPNOTSUPP;
 		goto done;
@@ -752,11 +747,6 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
-	if (hdev->dev_type != HCI_PRIMARY) {
-		err = -EOPNOTSUPP;
-		goto done;
-	}
-
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
 		err = -EOPNOTSUPP;
 		goto done;
@@ -910,7 +900,7 @@ int hci_get_dev_info(void __user *arg)
 
 	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
-	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
+	di.type     = (hdev->bus & 0x0f);
 	di.flags    = flags;
 	di.pkt_type = hdev->pkt_type;
 	if (lmp_bredr_capable(hdev)) {
@@ -995,8 +985,7 @@ static void hci_power_on(struct work_struct *work)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_RFKILLED) ||
 	    hci_dev_test_flag(hdev, HCI_UNCONFIGURED) ||
-	    (hdev->dev_type == HCI_PRIMARY &&
-	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+	    (!bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		hci_dev_clear_flag(hdev, HCI_AUTO_OFF);
 		hci_dev_do_close(hdev);
@@ -1738,6 +1727,15 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 
 		adv->pending = true;
 		adv->instance = instance;
+
+		/* If controller support only one set and the instance is set to
+		 * 1 then there is no option other than using handle 0x00.
+		 */
+		if (hdev->le_num_of_adv_sets == 1 && instance == 1)
+			adv->handle = 0x00;
+		else
+			adv->handle = instance;
+
 		list_add(&adv->list, &hdev->adv_instances);
 		hdev->adv_instance_cnt++;
 	}
@@ -2604,20 +2602,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->open || !hdev->close || !hdev->send)
 		return -EINVAL;
 
-	/* Do not allow HCI_AMP devices to register at index 0,
-	 * so the index can be used as the AMP controller ID.
-	 */
-	switch (hdev->dev_type) {
-	case HCI_PRIMARY:
-		id = ida_simple_get(&hci_index_ida, 0, HCI_MAX_ID, GFP_KERNEL);
-		break;
-	case HCI_AMP:
-		id = ida_simple_get(&hci_index_ida, 1, HCI_MAX_ID, GFP_KERNEL);
-		break;
-	default:
-		return -EINVAL;
-	}
-
+	id = ida_alloc_max(&hci_index_ida, HCI_MAX_ID - 1, GFP_KERNEL);
 	if (id < 0)
 		return id;
 
@@ -2669,12 +2654,10 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_dev_set_flag(hdev, HCI_SETUP);
 	hci_dev_set_flag(hdev, HCI_AUTO_OFF);
 
-	if (hdev->dev_type == HCI_PRIMARY) {
-		/* Assume BR/EDR support until proven otherwise (such as
-		 * through reading supported features during init.
-		 */
-		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
-	}
+	/* Assume BR/EDR support until proven otherwise (such as
+	 * through reading supported features during init.
+	 */
+	hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
 	write_lock(&hci_dev_list_lock);
 	list_add(&hdev->list, &hci_dev_list);
@@ -2711,7 +2694,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 err:
-	ida_simple_remove(&hci_index_ida, hdev->id);
+	ida_free(&hci_index_ida, hdev->id);
 
 	return error;
 }
@@ -2793,7 +2776,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 
 	ida_destroy(&hdev->unset_handle_ida);
-	ida_simple_remove(&hci_index_ida, hdev->id);
+	ida_free(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
 	kfree_skb(hdev->req_skb);
 	kfree_skb(hdev->recv_event);
@@ -3210,17 +3193,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 
 	hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
 
-	switch (hdev->dev_type) {
-	case HCI_PRIMARY:
-		hci_add_acl_hdr(skb, conn->handle, flags);
-		break;
-	case HCI_AMP:
-		hci_add_acl_hdr(skb, chan->handle, flags);
-		break;
-	default:
-		bt_dev_err(hdev, "unknown dev_type %d", hdev->dev_type);
-		return;
-	}
+	hci_add_acl_hdr(skb, conn->handle, flags);
 
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
@@ -3380,9 +3353,6 @@ static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
 	case ACL_LINK:
 		cnt = hdev->acl_cnt;
 		break;
-	case AMP_LINK:
-		cnt = hdev->block_cnt;
-		break;
 	case SCO_LINK:
 	case ESCO_LINK:
 		cnt = hdev->sco_cnt;
@@ -3580,12 +3550,6 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 }
 
-static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	/* Calculate count of blocks used by this packet */
-	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
-}
-
 static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 {
 	unsigned long last_tx;
@@ -3699,81 +3663,15 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, ACL_LINK);
 }
 
-static void hci_sched_acl_blk(struct hci_dev *hdev)
-{
-	unsigned int cnt = hdev->block_cnt;
-	struct hci_chan *chan;
-	struct sk_buff *skb;
-	int quote;
-	u8 type;
-
-	BT_DBG("%s", hdev->name);
-
-	if (hdev->dev_type == HCI_AMP)
-		type = AMP_LINK;
-	else
-		type = ACL_LINK;
-
-	__check_timeout(hdev, cnt, type);
-
-	while (hdev->block_cnt > 0 &&
-	       (chan = hci_chan_sent(hdev, type, &quote))) {
-		u32 priority = (skb_peek(&chan->data_q))->priority;
-		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
-			int blocks;
-
-			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
-			       skb->len, skb->priority);
-
-			/* Stop if priority has changed */
-			if (skb->priority < priority)
-				break;
-
-			skb = skb_dequeue(&chan->data_q);
-
-			blocks = __get_blocks(hdev, skb);
-			if (blocks > hdev->block_cnt)
-				return;
-
-			hci_conn_enter_active_mode(chan->conn,
-						   bt_cb(skb)->force_active);
-
-			hci_send_frame(hdev, skb);
-			hdev->acl_last_tx = jiffies;
-
-			hdev->block_cnt -= blocks;
-			quote -= blocks;
-
-			chan->sent += blocks;
-			chan->conn->sent += blocks;
-		}
-	}
-
-	if (cnt != hdev->block_cnt)
-		hci_prio_recalculate(hdev, type);
-}
-
 static void hci_sched_acl(struct hci_dev *hdev)
 {
 	BT_DBG("%s", hdev->name);
 
 	/* No ACL link over BR/EDR controller */
-	if (!hci_conn_num(hdev, ACL_LINK) && hdev->dev_type == HCI_PRIMARY)
-		return;
-
-	/* No AMP link over AMP controller */
-	if (!hci_conn_num(hdev, AMP_LINK) && hdev->dev_type == HCI_AMP)
+	if (!hci_conn_num(hdev, ACL_LINK))
 		return;
 
-	switch (hdev->flow_ctl_mode) {
-	case HCI_FLOW_CTL_MODE_PACKET_BASED:
-		hci_sched_acl_pkt(hdev);
-		break;
-
-	case HCI_FLOW_CTL_MODE_BLOCK_BASED:
-		hci_sched_acl_blk(hdev);
-		break;
-	}
+	hci_sched_acl_pkt(hdev);
 }
 
 static void hci_sched_le(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c19d78e5d205..cce73749f2dc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -913,21 +913,6 @@ static u8 hci_cc_read_local_ext_features(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
-static u8 hci_cc_read_flow_control_mode(struct hci_dev *hdev, void *data,
-					struct sk_buff *skb)
-{
-	struct hci_rp_read_flow_control_mode *rp = data;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
-
-	if (rp->status)
-		return rp->status;
-
-	hdev->flow_ctl_mode = rp->mode;
-
-	return rp->status;
-}
-
 static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
@@ -1071,28 +1056,6 @@ static u8 hci_cc_write_page_scan_type(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
-static u8 hci_cc_read_data_block_size(struct hci_dev *hdev, void *data,
-				      struct sk_buff *skb)
-{
-	struct hci_rp_read_data_block_size *rp = data;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
-
-	if (rp->status)
-		return rp->status;
-
-	hdev->block_mtu = __le16_to_cpu(rp->max_acl_len);
-	hdev->block_len = __le16_to_cpu(rp->block_len);
-	hdev->num_blocks = __le16_to_cpu(rp->num_blocks);
-
-	hdev->block_cnt = hdev->num_blocks;
-
-	BT_DBG("%s blk mtu %d cnt %d len %d", hdev->name, hdev->block_mtu,
-	       hdev->block_cnt, hdev->block_len);
-
-	return rp->status;
-}
-
 static u8 hci_cc_read_clock(struct hci_dev *hdev, void *data,
 			    struct sk_buff *skb)
 {
@@ -1127,30 +1090,6 @@ static u8 hci_cc_read_clock(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
-static u8 hci_cc_read_local_amp_info(struct hci_dev *hdev, void *data,
-				     struct sk_buff *skb)
-{
-	struct hci_rp_read_local_amp_info *rp = data;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
-
-	if (rp->status)
-		return rp->status;
-
-	hdev->amp_status = rp->amp_status;
-	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
-	hdev->amp_max_bw = __le32_to_cpu(rp->max_bw);
-	hdev->amp_min_latency = __le32_to_cpu(rp->min_latency);
-	hdev->amp_max_pdu = __le32_to_cpu(rp->max_pdu);
-	hdev->amp_type = rp->amp_type;
-	hdev->amp_pal_cap = __le16_to_cpu(rp->pal_cap);
-	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
-	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
-	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
-
-	return rp->status;
-}
-
 static u8 hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
@@ -4121,12 +4060,6 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_READ_PAGE_SCAN_TYPE, hci_cc_read_page_scan_type,
 	       sizeof(struct hci_rp_read_page_scan_type)),
 	HCI_CC_STATUS(HCI_OP_WRITE_PAGE_SCAN_TYPE, hci_cc_write_page_scan_type),
-	HCI_CC(HCI_OP_READ_DATA_BLOCK_SIZE, hci_cc_read_data_block_size,
-	       sizeof(struct hci_rp_read_data_block_size)),
-	HCI_CC(HCI_OP_READ_FLOW_CONTROL_MODE, hci_cc_read_flow_control_mode,
-	       sizeof(struct hci_rp_read_flow_control_mode)),
-	HCI_CC(HCI_OP_READ_LOCAL_AMP_INFO, hci_cc_read_local_amp_info,
-	       sizeof(struct hci_rp_read_local_amp_info)),
 	HCI_CC(HCI_OP_READ_CLOCK, hci_cc_read_clock,
 	       sizeof(struct hci_rp_read_clock)),
 	HCI_CC(HCI_OP_READ_ENC_KEY_SIZE, hci_cc_read_enc_key_size,
@@ -4317,7 +4250,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	/* Remove connection if command failed */
-	for (i = 0; cp->num_cis; cp->num_cis--, i++) {
+	for (i = 0; i < cp->num_cis; i++) {
 		struct hci_conn *conn;
 		u16 handle;
 
@@ -4333,6 +4266,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 			hci_conn_del(conn);
 		}
 	}
+	cp->num_cis = 0;
 
 	if (pending)
 		hci_le_create_cis_pending(hdev);
@@ -4461,11 +4395,6 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 			     flex_array_size(ev, handles, ev->num)))
 		return;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
-		return;
-	}
-
 	bt_dev_dbg(hdev, "num %d", ev->num);
 
 	for (i = 0; i < ev->num; i++) {
@@ -4533,78 +4462,6 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
-static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
-						 __u16 handle)
-{
-	struct hci_chan *chan;
-
-	switch (hdev->dev_type) {
-	case HCI_PRIMARY:
-		return hci_conn_hash_lookup_handle(hdev, handle);
-	case HCI_AMP:
-		chan = hci_chan_lookup_handle(hdev, handle);
-		if (chan)
-			return chan->conn;
-		break;
-	default:
-		bt_dev_err(hdev, "unknown dev_type %d", hdev->dev_type);
-		break;
-	}
-
-	return NULL;
-}
-
-static void hci_num_comp_blocks_evt(struct hci_dev *hdev, void *data,
-				    struct sk_buff *skb)
-{
-	struct hci_ev_num_comp_blocks *ev = data;
-	int i;
-
-	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_BLOCKS,
-			     flex_array_size(ev, handles, ev->num_hndl)))
-		return;
-
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_BLOCK_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d",
-			   hdev->flow_ctl_mode);
-		return;
-	}
-
-	bt_dev_dbg(hdev, "num_blocks %d num_hndl %d", ev->num_blocks,
-		   ev->num_hndl);
-
-	for (i = 0; i < ev->num_hndl; i++) {
-		struct hci_comp_blocks_info *info = &ev->handles[i];
-		struct hci_conn *conn = NULL;
-		__u16  handle, block_count;
-
-		handle = __le16_to_cpu(info->handle);
-		block_count = __le16_to_cpu(info->blocks);
-
-		conn = __hci_conn_lookup_handle(hdev, handle);
-		if (!conn)
-			continue;
-
-		conn->sent -= block_count;
-
-		switch (conn->type) {
-		case ACL_LINK:
-		case AMP_LINK:
-			hdev->block_cnt += block_count;
-			if (hdev->block_cnt > hdev->num_blocks)
-				hdev->block_cnt = hdev->num_blocks;
-			break;
-
-		default:
-			bt_dev_err(hdev, "unknown type %d conn %p",
-				   conn->type, conn);
-			break;
-		}
-	}
-
-	queue_work(hdev->workqueue, &hdev->tx_work);
-}
-
 static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
 				struct sk_buff *skb)
 {
@@ -5697,150 +5554,6 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
-#if IS_ENABLED(CONFIG_BT_HS)
-static void hci_chan_selected_evt(struct hci_dev *hdev, void *data,
-				  struct sk_buff *skb)
-{
-	struct hci_ev_channel_selected *ev = data;
-	struct hci_conn *hcon;
-
-	bt_dev_dbg(hdev, "handle 0x%2.2x", ev->phy_handle);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	amp_read_loc_assoc_final_data(hdev, hcon);
-}
-
-static void hci_phy_link_complete_evt(struct hci_dev *hdev, void *data,
-				      struct sk_buff *skb)
-{
-	struct hci_ev_phy_link_complete *ev = data;
-	struct hci_conn *hcon, *bredr_hcon;
-
-	bt_dev_dbg(hdev, "handle 0x%2.2x status 0x%2.2x", ev->phy_handle,
-		   ev->status);
-
-	hci_dev_lock(hdev);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		goto unlock;
-
-	if (!hcon->amp_mgr)
-		goto unlock;
-
-	if (ev->status) {
-		hci_conn_del(hcon);
-		goto unlock;
-	}
-
-	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
-
-	hcon->state = BT_CONNECTED;
-	bacpy(&hcon->dst, &bredr_hcon->dst);
-
-	hci_conn_hold(hcon);
-	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
-	hci_conn_drop(hcon);
-
-	hci_debugfs_create_conn(hcon);
-	hci_conn_add_sysfs(hcon);
-
-	amp_physical_cfm(bredr_hcon, hcon);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_loglink_complete_evt(struct hci_dev *hdev, void *data,
-				     struct sk_buff *skb)
-{
-	struct hci_ev_logical_link_complete *ev = data;
-	struct hci_conn *hcon;
-	struct hci_chan *hchan;
-	struct amp_mgr *mgr;
-
-	bt_dev_dbg(hdev, "log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
-		   le16_to_cpu(ev->handle), ev->phy_handle, ev->status);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	/* Create AMP hchan */
-	hchan = hci_chan_create(hcon);
-	if (!hchan)
-		return;
-
-	hchan->handle = le16_to_cpu(ev->handle);
-	hchan->amp = true;
-
-	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->amp_mgr, hchan);
-
-	mgr = hcon->amp_mgr;
-	if (mgr && mgr->bredr_chan) {
-		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
-
-		l2cap_chan_lock(bredr_chan);
-
-		bredr_chan->conn->mtu = hdev->block_mtu;
-		l2cap_logical_cfm(bredr_chan, hchan, 0);
-		hci_conn_hold(hcon);
-
-		l2cap_chan_unlock(bredr_chan);
-	}
-}
-
-static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev, void *data,
-					     struct sk_buff *skb)
-{
-	struct hci_ev_disconn_logical_link_complete *ev = data;
-	struct hci_chan *hchan;
-
-	bt_dev_dbg(hdev, "handle 0x%4.4x status 0x%2.2x",
-		   le16_to_cpu(ev->handle), ev->status);
-
-	if (ev->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	hchan = hci_chan_lookup_handle(hdev, le16_to_cpu(ev->handle));
-	if (!hchan || !hchan->amp)
-		goto unlock;
-
-	amp_destroy_logical_link(hchan, ev->reason);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev, void *data,
-					     struct sk_buff *skb)
-{
-	struct hci_ev_disconn_phy_link_complete *ev = data;
-	struct hci_conn *hcon;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
-
-	if (ev->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (hcon && hcon->type == AMP_LINK) {
-		hcon->state = BT_CLOSED;
-		hci_disconn_cfm(hcon, ev->reason);
-		hci_conn_del(hcon);
-	}
-
-	hci_dev_unlock(hdev);
-}
-#endif
-
 static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
 				u8 bdaddr_type, bdaddr_t *local_rpa)
 {
@@ -7656,28 +7369,6 @@ static const struct hci_ev {
 	/* [0x3e = HCI_EV_LE_META] */
 	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
 		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_SIZE),
-#if IS_ENABLED(CONFIG_BT_HS)
-	/* [0x40 = HCI_EV_PHY_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_PHY_LINK_COMPLETE, hci_phy_link_complete_evt,
-	       sizeof(struct hci_ev_phy_link_complete)),
-	/* [0x41 = HCI_EV_CHANNEL_SELECTED] */
-	HCI_EV(HCI_EV_CHANNEL_SELECTED, hci_chan_selected_evt,
-	       sizeof(struct hci_ev_channel_selected)),
-	/* [0x42 = HCI_EV_DISCONN_PHY_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE,
-	       hci_disconn_loglink_complete_evt,
-	       sizeof(struct hci_ev_disconn_logical_link_complete)),
-	/* [0x45 = HCI_EV_LOGICAL_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_LOGICAL_LINK_COMPLETE, hci_loglink_complete_evt,
-	       sizeof(struct hci_ev_logical_link_complete)),
-	/* [0x46 = HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_DISCONN_PHY_LINK_COMPLETE,
-	       hci_disconn_phylink_complete_evt,
-	       sizeof(struct hci_ev_disconn_phy_link_complete)),
-#endif
-	/* [0x48 = HCI_EV_NUM_COMP_BLOCKS] */
-	HCI_EV(HCI_EV_NUM_COMP_BLOCKS, hci_num_comp_blocks_evt,
-	       sizeof(struct hci_ev_num_comp_blocks)),
 	/* [0xff = HCI_EV_VENDOR] */
 	HCI_EV_VL(HCI_EV_VENDOR, msft_vendor_evt, 0, HCI_MAX_EVENT_SIZE),
 };
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3f5f0932330d..69c2ba1e843e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -101,7 +101,7 @@ static bool hci_sock_gen_cookie(struct sock *sk)
 	int id = hci_pi(sk)->cookie;
 
 	if (!id) {
-		id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
+		id = ida_alloc_min(&sock_cookie_ida, 1, GFP_KERNEL);
 		if (id < 0)
 			id = 0xffffffff;
 
@@ -119,7 +119,7 @@ static void hci_sock_free_cookie(struct sock *sk)
 
 	if (id) {
 		hci_pi(sk)->cookie = 0xffffffff;
-		ida_simple_remove(&sock_cookie_ida, id);
+		ida_free(&sock_cookie_ida, id);
 	}
 }
 
@@ -485,7 +485,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 			return NULL;
 
 		ni = skb_put(skb, HCI_MON_NEW_INDEX_SIZE);
-		ni->type = hdev->dev_type;
+		ni->type = 0x00; /* Old hdev->dev_type */
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
 		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
@@ -1007,9 +1007,6 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		return -EOPNOTSUPP;
 
-	if (hdev->dev_type != HCI_PRIMARY)
-		return -EOPNOTSUPP;
-
 	switch (cmd) {
 	case HCISETRAW:
 		if (!capable(CAP_NET_ADMIN))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 40b71bc50573..097d1c8713d8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1043,11 +1043,10 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
+	struct adv_info *adv = NULL;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
-		struct adv_info *adv;
-
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv)
 			return -EINVAL;
@@ -1066,7 +1065,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
@@ -1235,31 +1234,27 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_ext_scan_rsp_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
 	u8 len;
 	struct adv_info *adv = NULL;
 	int err;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->scan_rsp_changed)
 			return 0;
 	}
 
-	len = eir_create_scan_rsp(hdev, instance, pdu.data);
+	len = eir_create_scan_rsp(hdev, instance, pdu->data);
 
-	pdu.cp.handle = instance;
-	pdu.cp.length = len;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+	pdu->handle = adv ? adv->handle : instance;
+	pdu->length = len;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
+				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
 	if (err)
 		return err;
@@ -1267,7 +1262,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->scan_rsp_changed = false;
 	} else {
-		memcpy(hdev->scan_rsp_data, pdu.data, len);
+		memcpy(hdev->scan_rsp_data, pdu->data, len);
 		hdev->scan_rsp_data_len = len;
 	}
 
@@ -1335,7 +1330,7 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(set, 0, sizeof(*set));
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	/* Set duration per instance since controller is responsible for
 	 * scheduling it.
@@ -1411,29 +1406,25 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 
 static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_per_adv_data cp;
-		u8 data[HCI_MAX_PER_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
+		    HCI_MAX_PER_AD_LENGTH);
 	u8 len;
-
-	memset(&pdu, 0, sizeof(pdu));
+	struct adv_info *adv = NULL;
 
 	if (instance) {
-		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
-
+		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->periodic)
 			return 0;
 	}
 
-	len = eir_create_per_adv_data(hdev, instance, pdu.data);
+	len = eir_create_per_adv_data(hdev, instance, pdu->data);
 
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->length = len;
+	pdu->handle = adv ? adv->handle : instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
-				     sizeof(pdu.cp) + len, &pdu,
+				     struct_size(pdu, data, len), pdu,
 				     HCI_CMD_TIMEOUT);
 }
 
@@ -1727,31 +1718,27 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 
 static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
-	struct {
-		struct hci_cp_le_set_ext_adv_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
 	u8 len;
 	struct adv_info *adv = NULL;
 	int err;
 
-	memset(&pdu, 0, sizeof(pdu));
-
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->adv_data_changed)
 			return 0;
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu.data);
+	len = eir_create_adv_data(hdev, instance, pdu->data);
 
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+	pdu->length = len;
+	pdu->handle = adv ? adv->handle : instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
+				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
 	if (err)
 		return err;
@@ -1760,7 +1747,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	if (adv) {
 		adv->adv_data_changed = false;
 	} else {
-		memcpy(hdev->adv_data, pdu.data, len);
+		memcpy(hdev->adv_data, pdu->data, len);
 		hdev->adv_data_len = len;
 	}
 
@@ -3488,10 +3475,6 @@ static int hci_unconf_init_sync(struct hci_dev *hdev)
 /* Read Local Supported Features. */
 static int hci_read_local_features_sync(struct hci_dev *hdev)
 {
-	 /* Not all AMP controllers support this command */
-	if (hdev->dev_type == HCI_AMP && !(hdev->commands[14] & 0x20))
-		return 0;
-
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_LOCAL_FEATURES,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
@@ -3526,51 +3509,6 @@ static int hci_read_local_cmds_sync(struct hci_dev *hdev)
 	return 0;
 }
 
-/* Read Local AMP Info */
-static int hci_read_local_amp_info_sync(struct hci_dev *hdev)
-{
-	return __hci_cmd_sync_status(hdev, HCI_OP_READ_LOCAL_AMP_INFO,
-				     0, NULL, HCI_CMD_TIMEOUT);
-}
-
-/* Read Data Blk size */
-static int hci_read_data_block_size_sync(struct hci_dev *hdev)
-{
-	return __hci_cmd_sync_status(hdev, HCI_OP_READ_DATA_BLOCK_SIZE,
-				     0, NULL, HCI_CMD_TIMEOUT);
-}
-
-/* Read Flow Control Mode */
-static int hci_read_flow_control_mode_sync(struct hci_dev *hdev)
-{
-	return __hci_cmd_sync_status(hdev, HCI_OP_READ_FLOW_CONTROL_MODE,
-				     0, NULL, HCI_CMD_TIMEOUT);
-}
-
-/* Read Location Data */
-static int hci_read_location_data_sync(struct hci_dev *hdev)
-{
-	return __hci_cmd_sync_status(hdev, HCI_OP_READ_LOCATION_DATA,
-				     0, NULL, HCI_CMD_TIMEOUT);
-}
-
-/* AMP Controller init stage 1 command sequence */
-static const struct hci_init_stage amp_init1[] = {
-	/* HCI_OP_READ_LOCAL_VERSION */
-	HCI_INIT(hci_read_local_version_sync),
-	/* HCI_OP_READ_LOCAL_COMMANDS */
-	HCI_INIT(hci_read_local_cmds_sync),
-	/* HCI_OP_READ_LOCAL_AMP_INFO */
-	HCI_INIT(hci_read_local_amp_info_sync),
-	/* HCI_OP_READ_DATA_BLOCK_SIZE */
-	HCI_INIT(hci_read_data_block_size_sync),
-	/* HCI_OP_READ_FLOW_CONTROL_MODE */
-	HCI_INIT(hci_read_flow_control_mode_sync),
-	/* HCI_OP_READ_LOCATION_DATA */
-	HCI_INIT(hci_read_location_data_sync),
-	{}
-};
-
 static int hci_init1_sync(struct hci_dev *hdev)
 {
 	int err;
@@ -3584,28 +3522,9 @@ static int hci_init1_sync(struct hci_dev *hdev)
 			return err;
 	}
 
-	switch (hdev->dev_type) {
-	case HCI_PRIMARY:
-		hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_PACKET_BASED;
-		return hci_init_stage_sync(hdev, br_init1);
-	case HCI_AMP:
-		hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_BLOCK_BASED;
-		return hci_init_stage_sync(hdev, amp_init1);
-	default:
-		bt_dev_err(hdev, "Unknown device type %d", hdev->dev_type);
-		break;
-	}
-
-	return 0;
+	return hci_init_stage_sync(hdev, br_init1);
 }
 
-/* AMP Controller init stage 2 command sequence */
-static const struct hci_init_stage amp_init2[] = {
-	/* HCI_OP_READ_LOCAL_FEATURES */
-	HCI_INIT(hci_read_local_features_sync),
-	{}
-};
-
 /* Read Buffer Size (ACL mtu, max pkt, etc.) */
 static int hci_read_buffer_size_sync(struct hci_dev *hdev)
 {
@@ -3863,9 +3782,6 @@ static int hci_init2_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
-	if (hdev->dev_type == HCI_AMP)
-		return hci_init_stage_sync(hdev, amp_init2);
-
 	err = hci_init_stage_sync(hdev, hci_init2);
 	if (err)
 		return err;
@@ -4703,13 +4619,6 @@ static int hci_init_sync(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	/* HCI_PRIMARY covers both single-mode LE, BR/EDR and dual-mode
-	 * BR/EDR/LE type controllers. AMP controllers only need the
-	 * first two stages of init.
-	 */
-	if (hdev->dev_type != HCI_PRIMARY)
-		return 0;
-
 	err = hci_init3_sync(hdev);
 	if (err < 0)
 		return err;
@@ -4938,12 +4847,8 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		 * In case of user channel usage, it is not important
 		 * if a public address or static random address is
 		 * available.
-		 *
-		 * This check is only valid for BR/EDR controllers
-		 * since AMP controllers do not have an address.
 		 */
 		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-		    hdev->dev_type == HCI_PRIMARY &&
 		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
 			ret = -EADDRNOTAVAIL;
@@ -4978,8 +4883,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
 		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-		    hci_dev_test_flag(hdev, HCI_MGMT) &&
-		    hdev->dev_type == HCI_PRIMARY) {
+		    hci_dev_test_flag(hdev, HCI_MGMT)) {
 			ret = hci_powered_update_sync(hdev);
 			mgmt_power_on(hdev, ret);
 		}
@@ -5124,8 +5028,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
-	if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
-	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+	if (!auto_off && !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT))
 		__mgmt_power_off(hdev);
 
@@ -5187,9 +5090,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	hdev->flags &= BIT(HCI_RAW);
 	hci_dev_clear_volatile_flags(hdev);
 
-	/* Controller radio is available but is currently powered down */
-	hdev->amp_status = AMP_STATUS_POWERED_DOWN;
-
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
@@ -5226,8 +5126,7 @@ static int hci_power_on_sync(struct hci_dev *hdev)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_RFKILLED) ||
 	    hci_dev_test_flag(hdev, HCI_UNCONFIGURED) ||
-	    (hdev->dev_type == HCI_PRIMARY &&
-	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+	    (!bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		hci_dev_clear_flag(hdev, HCI_AUTO_OFF);
 		hci_dev_close_sync(hdev);
@@ -5329,27 +5228,11 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 	return 0;
 }
 
-static int hci_disconnect_phy_link_sync(struct hci_dev *hdev, u16 handle,
-					u8 reason)
-{
-	struct hci_cp_disconn_phy_link cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.phy_handle = HCI_PHY_HANDLE(handle);
-	cp.reason = reason;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_DISCONN_PHY_LINK,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
-}
-
 static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			       u8 reason)
 {
 	struct hci_cp_disconnect cp;
 
-	if (conn->type == AMP_LINK)
-		return hci_disconnect_phy_link_sync(hdev, conn->handle, reason);
-
 	if (test_bit(HCI_CONN_BIG_CREATED, &conn->flags)) {
 		/* This is a BIS connection, hci_conn_del will
 		 * do the necessary cleanup.
@@ -6462,10 +6345,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_le_create_cis_sync(struct hci_dev *hdev)
 {
-	struct {
-		struct hci_cp_le_create_cis cp;
-		struct hci_cis cis[0x1f];
-	} cmd;
+	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
+	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;
 
@@ -6492,8 +6373,6 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	 * remains pending.
 	 */
 
-	memset(&cmd, 0, sizeof(cmd));
-
 	hci_dev_lock(hdev);
 
 	rcu_read_lock();
@@ -6530,7 +6409,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		goto done;
 
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
+		struct hci_cis *cis = &cmd->cis[aux_num_cis];
 
 		if (hci_conn_check_create_cis(conn) ||
 		    conn->iso_qos.ucast.cig != cig)
@@ -6539,25 +6418,25 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
-		cmd.cp.num_cis++;
+		aux_num_cis++;
 
-		if (cmd.cp.num_cis >= ARRAY_SIZE(cmd.cis))
+		if (aux_num_cis >= 0x1f)
 			break;
 	}
+	cmd->num_cis = aux_num_cis;
 
 done:
 	rcu_read_unlock();
 
 	hci_dev_unlock(hdev);
 
-	if (!cmd.cp.num_cis)
+	if (!aux_num_cis)
 		return 0;
 
 	/* Wait for HCI_LE_CIS_Established */
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
-					sizeof(cmd.cp) + sizeof(cmd.cis[0]) *
-					cmd.cp.num_cis, &cmd,
-					HCI_EVT_LE_CIS_ESTABLISHED,
+					struct_size(cmd, cis, cmd->num_cis),
+					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
 					conn->conn_timeout, NULL);
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6d217df75c62..6cb41f9d174e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -3,7 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2022 Intel Corporation
- * Copyright 2023 NXP
+ * Copyright 2023-2024 NXP
  */
 
 #include <linux/module.h>
@@ -85,8 +85,9 @@ static void iso_sock_disconn(struct sock *sk);
 
 typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
 
-static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
-					iso_sock_match_t match, void *data);
+static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
+				 enum bt_sock_state state,
+				 iso_sock_match_t match, void *data);
 
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
@@ -233,10 +234,11 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 		 * terminated are not processed anymore.
 		 */
 		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
-			parent = iso_get_sock_listen(&hcon->src,
-						     &hcon->dst,
-						     iso_match_conn_sync_handle,
-						     hcon);
+			parent = iso_get_sock(&hcon->src,
+					      &hcon->dst,
+					      BT_LISTEN,
+					      iso_match_conn_sync_handle,
+					      hcon);
 
 			if (parent) {
 				set_bit(BT_SK_PA_SYNC_TERM,
@@ -581,22 +583,23 @@ static struct sock *__iso_get_sock_listen_by_sid(bdaddr_t *ba, bdaddr_t *bc,
 	return NULL;
 }
 
-/* Find socket listening:
+/* Find socket in given state:
  * source bdaddr (Unicast)
  * destination bdaddr (Broadcast only)
  * match func - pass NULL to ignore
  * match func data - pass -1 to ignore
  * Returns closest match.
  */
-static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
-					iso_sock_match_t match, void *data)
+static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
+				 enum bt_sock_state state,
+				 iso_sock_match_t match, void *data)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
 
 	read_lock(&iso_sk_list.lock);
 
 	sk_for_each(sk, &iso_sk_list.head) {
-		if (sk->sk_state != BT_LISTEN)
+		if (sk->sk_state != state)
 			continue;
 
 		/* Match Broadcast destination */
@@ -690,11 +693,8 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 		iso_sock_kill(sk);
 	}
 
-	/* If listening socket stands for a PA sync connection,
-	 * properly disconnect the hcon and socket.
-	 */
-	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon &&
-	    test_bit(HCI_CONN_PA_SYNC, &iso_pi(parent)->conn->hcon->flags)) {
+	/* If listening socket has a hcon, properly disconnect it */
+	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon) {
 		iso_sock_disconn(parent);
 		return;
 	}
@@ -1076,6 +1076,8 @@ static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
 	int err = 0;
+	struct iso_conn *conn;
+	struct hci_conn *hcon;
 
 	BT_DBG("%pMR -> %pMR (SID 0x%2.2x)", &iso_pi(sk)->src,
 	       &iso_pi(sk)->dst, iso_pi(sk)->bc_sid);
@@ -1096,18 +1098,40 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
+	hci_dev_lock(hdev);
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	hcon = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
+				  le_addr_type(iso_pi(sk)->dst_type),
+				  iso_pi(sk)->bc_sid, &iso_pi(sk)->qos);
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto unlock;
+	}
+
+	conn = iso_conn_add(hcon);
+	if (!conn) {
+		hci_conn_drop(hcon);
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	err = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
-				 le_addr_type(iso_pi(sk)->dst_type),
-				 iso_pi(sk)->bc_sid, &iso_pi(sk)->qos);
+	err = iso_chan_add(conn, sk, NULL);
+	if (err) {
+		hci_conn_drop(hcon);
+		goto unlock;
+	}
 
 	hci_dev_put(hdev);
 
+unlock:
+	hci_dev_unlock(hdev);
 	return err;
 }
 
@@ -1756,32 +1780,37 @@ static void iso_conn_ready(struct iso_conn *conn)
 						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
 
 			/* Get reference to PA sync parent socket, if it exists */
-			parent = iso_get_sock_listen(&hcon->src,
-						     &hcon->dst,
-						     iso_match_pa_sync_flag, NULL);
+			parent = iso_get_sock(&hcon->src, &hcon->dst,
+					      BT_LISTEN,
+					      iso_match_pa_sync_flag,
+					      NULL);
 			if (!parent && ev)
-				parent = iso_get_sock_listen(&hcon->src,
-							     &hcon->dst,
-							     iso_match_big, ev);
+				parent = iso_get_sock(&hcon->src,
+						      &hcon->dst,
+						      BT_LISTEN,
+						      iso_match_big, ev);
 		} else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
-				parent = iso_get_sock_listen(&hcon->src,
-							     &hcon->dst,
-							     iso_match_sid, ev2);
+				parent = iso_get_sock(&hcon->src,
+						      &hcon->dst,
+						      BT_LISTEN,
+						      iso_match_sid, ev2);
 		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
 			ev3 = hci_recv_event_data(hcon->hdev,
 						  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 			if (ev3)
-				parent = iso_get_sock_listen(&hcon->src,
-							     &hcon->dst,
-							     iso_match_sync_handle, ev3);
+				parent = iso_get_sock(&hcon->src,
+						      &hcon->dst,
+						      BT_LISTEN,
+						      iso_match_sync_handle,
+						      ev3);
 		}
 
 		if (!parent)
-			parent = iso_get_sock_listen(&hcon->src,
-							BDADDR_ANY, NULL, NULL);
+			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
+					      BT_LISTEN, NULL, NULL);
 
 		if (!parent)
 			return;
@@ -1883,7 +1912,6 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	struct hci_evt_le_big_info_adv_report *ev2;
 	struct hci_ev_le_per_adv_report *ev3;
 	struct sock *sk;
-	int lm = 0;
 
 	bt_dev_dbg(hdev, "bdaddr %pMR", bdaddr);
 
@@ -1903,8 +1931,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
-		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
-					 ev1);
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_sid, ev1);
 		if (sk && !ev1->status)
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 
@@ -1914,12 +1942,12 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Try to get PA sync listening socket, if it exists */
-		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-						iso_match_pa_sync_flag, NULL);
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_pa_sync_flag, NULL);
 
 		if (!sk) {
-			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-						 iso_match_sync_handle, ev2);
+			sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+					  iso_match_sync_handle, ev2);
 
 			/* If PA Sync is in process of terminating,
 			 * do not handle any more BIGInfo adv reports.
@@ -1927,7 +1955,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			if (sk && test_bit(BT_SK_PA_SYNC_TERM,
 					   &iso_pi(sk)->flags))
-				return lm;
+				return 0;
 		}
 
 		if (sk) {
@@ -1959,8 +1987,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		u8 *base;
 		struct hci_conn *hcon;
 
-		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-					 iso_match_sync_handle_pa_report, ev3);
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_sync_handle_pa_report, ev3);
 		if (!sk)
 			goto done;
 
@@ -2009,21 +2037,20 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
-		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
+		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
+				  BT_LISTEN, NULL, NULL);
 	}
 
 done:
 	if (!sk)
-		return lm;
-
-	lm |= HCI_LM_ACCEPT;
+		return 0;
 
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
 		*flags |= HCI_PROTO_DEFER;
 
 	sock_put(sk);
 
-	return lm;
+	return HCI_LM_ACCEPT;
 }
 
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3f7a82f10fe9..4a633c1b6882 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -457,6 +457,9 @@ struct l2cap_chan *l2cap_chan_create(void)
 	/* Set default lock nesting level */
 	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
 
+	/* Available receive buffer space is initially unknown */
+	chan->rx_avail = -1;
+
 	write_lock(&chan_list_lock);
 	list_add(&chan->global_l, &chan_list);
 	write_unlock(&chan_list_lock);
@@ -538,6 +541,28 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
 
+static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
+{
+	size_t sdu_len = chan->sdu ? chan->sdu->len : 0;
+
+	if (chan->mps == 0)
+		return 0;
+
+	/* If we don't know the available space in the receiver buffer, give
+	 * enough credits for a full packet.
+	 */
+	if (chan->rx_avail == -1)
+		return (chan->imtu / chan->mps) + 1;
+
+	/* If we know how much space is available in the receive buffer, give
+	 * out as many credits as would fill the buffer.
+	 */
+	if (chan->rx_avail <= sdu_len)
+		return 0;
+
+	return DIV_ROUND_UP(chan->rx_avail - sdu_len, chan->mps);
+}
+
 static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 {
 	chan->sdu = NULL;
@@ -546,8 +571,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
-	/* Give enough credits for a full packet */
-	chan->rx_credits = (chan->imtu / chan->mps) + 1;
+	chan->rx_credits = l2cap_le_rx_credits(chan);
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -559,7 +583,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_credits)
 	/* L2CAP implementations shall support a minimum MPS of 64 octets */
 	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
 		chan->mps = L2CAP_ECRED_MIN_MPS;
-		chan->rx_credits = (chan->imtu / chan->mps) + 1;
+		chan->rx_credits = l2cap_le_rx_credits(chan);
 	}
 }
 
@@ -3906,7 +3930,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 }
 
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
-			  u8 *data, u8 rsp_code, u8 amp_id)
+			  u8 *data, u8 rsp_code)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -3985,17 +4009,8 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 				status = L2CAP_CS_AUTHOR_PEND;
 				chan->ops->defer(chan);
 			} else {
-				/* Force pending result for AMP controllers.
-				 * The connection will succeed after the
-				 * physical link is up.
-				 */
-				if (amp_id == AMP_ID_BREDR) {
-					l2cap_state_change(chan, BT_CONFIG);
-					result = L2CAP_CR_SUCCESS;
-				} else {
-					l2cap_state_change(chan, BT_CONNECT2);
-					result = L2CAP_CR_PEND;
-				}
+				l2cap_state_change(chan, BT_CONNECT2);
+				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
@@ -4060,7 +4075,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 		mgmt_device_connected(hdev, hcon, NULL, 0);
 	hci_dev_unlock(hdev);
 
-	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
+	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
 	return 0;
 }
 
@@ -6513,9 +6528,7 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
-	u16 return_credits;
-
-	return_credits = (chan->imtu / chan->mps) + 1;
+	u16 return_credits = l2cap_le_rx_credits(chan);
 
 	if (chan->rx_credits >= return_credits)
 		return;
@@ -6534,6 +6547,19 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
+{
+	if (chan->rx_avail == rx_avail)
+		return;
+
+	BT_DBG("chan %p has %zd bytes avail for rx", chan, rx_avail);
+
+	chan->rx_avail = rx_avail;
+
+	if (chan->state == BT_CONNECTED)
+		l2cap_chan_le_send_credits(chan);
+}
+
 static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
@@ -6543,6 +6569,12 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 	/* Wait recv to confirm reception before updating the credits */
 	err = chan->ops->recv(chan, skb);
 
+	if (err < 0 && chan->rx_avail != -1) {
+		BT_ERR("Queueing received LE L2CAP data failed");
+		l2cap_send_disconn_req(chan, ECONNRESET);
+		return err;
+	}
+
 	/* Update credits whenever an SDU is received */
 	l2cap_chan_le_send_credits(chan);
 
@@ -6565,7 +6597,8 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	}
 
 	chan->rx_credits--;
-	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
+	BT_DBG("chan %p: rx_credits %u -> %u",
+	       chan, chan->rx_credits + 1, chan->rx_credits);
 
 	/* Update if remote had run out of credits, this should only happens
 	 * if the remote is not using the entire MPS.
@@ -7453,10 +7486,6 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	int len;
 
-	/* For AMP controller do not create l2cap conn */
-	if (!conn && hcon->hdev->dev_type != HCI_PRIMARY)
-		goto drop;
-
 	if (!conn)
 		conn = l2cap_conn_add(hcon);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5cc83f906c12..8645461d45e8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1131,6 +1131,34 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	ssize_t avail = sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc);
+	int expected_skbs, skb_overhead;
+
+	if (avail <= 0) {
+		l2cap_chan_rx_avail(chan, 0);
+		return;
+	}
+
+	if (!chan->mps) {
+		l2cap_chan_rx_avail(chan, -1);
+		return;
+	}
+
+	/* Correct available memory by estimated sk_buff overhead.
+	 * This is significant due to small transfer sizes. However, accept
+	 * at least one full packet if receive space is non-zero.
+	 */
+	expected_skbs = DIV_ROUND_UP(avail, chan->mps);
+	skb_overhead = expected_skbs * sizeof(struct sk_buff);
+	if (skb_overhead < avail)
+		l2cap_chan_rx_avail(chan, avail - skb_overhead);
+	else
+		l2cap_chan_rx_avail(chan, -1);
+}
+
 static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			      size_t len, int flags)
 {
@@ -1167,28 +1195,33 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	else
 		err = bt_sock_recvmsg(sock, msg, len, flags);
 
-	if (pi->chan->mode != L2CAP_MODE_ERTM)
+	if (pi->chan->mode != L2CAP_MODE_ERTM &&
+	    pi->chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    pi->chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return err;
 
-	/* Attempt to put pending rx data in the socket buffer */
-
 	lock_sock(sk);
 
-	if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
-		goto done;
+	l2cap_publish_rx_avail(pi->chan);
 
-	if (pi->rx_busy_skb) {
-		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
-			pi->rx_busy_skb = NULL;
-		else
+	/* Attempt to put pending rx data in the socket buffer */
+	while (!list_empty(&pi->rx_busy)) {
+		struct l2cap_rx_busy *rx_busy =
+			list_first_entry(&pi->rx_busy,
+					 struct l2cap_rx_busy,
+					 list);
+		if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
 			goto done;
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	/* Restore data flow when half of the receive buffer is
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
+	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 
 done:
@@ -1449,17 +1482,20 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct sock *sk = chan->data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err;
 
 	lock_sock(sk);
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
+	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
 	}
 
 	if (chan->mode != L2CAP_MODE_ERTM &&
-	    chan->mode != L2CAP_MODE_STREAMING) {
+	    chan->mode != L2CAP_MODE_STREAMING &&
+	    chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL) {
 		/* Even if no filter is attached, we could potentially
 		 * get errors from security modules, etc.
 		 */
@@ -1470,7 +1506,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	l2cap_publish_rx_avail(chan);
+
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
@@ -1479,8 +1517,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	 * acked and reassembled until there is buffer space
 	 * available.
 	 */
-	if (err < 0 && chan->mode == L2CAP_MODE_ERTM) {
-		l2cap_pi(sk)->rx_busy_skb = skb;
+	if (err < 0 &&
+	    (chan->mode == L2CAP_MODE_ERTM ||
+	     chan->mode == L2CAP_MODE_LE_FLOWCTL ||
+	     chan->mode == L2CAP_MODE_EXT_FLOWCTL)) {
+		struct l2cap_rx_busy *rx_busy =
+			kmalloc(sizeof(*rx_busy), GFP_KERNEL);
+		if (!rx_busy) {
+			err = -ENOMEM;
+			goto done;
+		}
+		rx_busy->skb = skb;
+		list_add_tail(&rx_busy->list, &pi->rx_busy);
 		l2cap_chan_busy(chan, 1);
 		err = 0;
 	}
@@ -1706,6 +1754,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1713,9 +1763,10 @@ static void l2cap_sock_destruct(struct sock *sk)
 		l2cap_chan_put(l2cap_pi(sk)->chan);
 	}
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
-		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
-		l2cap_pi(sk)->rx_busy_skb = NULL;
+	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
+		kfree_skb(rx_busy->skb);
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	skb_queue_purge(&sk->sk_receive_queue);
@@ -1799,6 +1850,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 	chan->data = sk;
 	chan->ops = &l2cap_chan_ops;
+
+	l2cap_publish_rx_avail(chan);
 }
 
 static struct proto l2cap_proto = {
@@ -1820,6 +1873,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8e05ddeedba..d58d3e13910f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -443,8 +443,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_PRIMARY &&
-		    !hci_dev_test_flag(d, HCI_UNCONFIGURED))
+		if (!hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
 
@@ -468,8 +467,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_PRIMARY &&
-		    !hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
+		if (!hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			bt_dev_dbg(hdev, "Added hci%u", d->id);
 		}
@@ -503,8 +501,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_PRIMARY &&
-		    hci_dev_test_flag(d, HCI_UNCONFIGURED))
+		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
 
@@ -528,8 +525,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_PRIMARY &&
-		    hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
+		if (hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			bt_dev_dbg(hdev, "Added hci%u", d->id);
 		}
@@ -561,10 +557,8 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_PRIMARY || d->dev_type == HCI_AMP)
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
 	rp = kmalloc(struct_size(rp, entry, count), GFP_ATOMIC);
 	if (!rp) {
@@ -585,16 +579,10 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_PRIMARY) {
-			if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
-				rp->entry[count].type = 0x01;
-			else
-				rp->entry[count].type = 0x00;
-		} else if (d->dev_type == HCI_AMP) {
-			rp->entry[count].type = 0x02;
-		} else {
-			continue;
-		}
+		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
+			rp->entry[count].type = 0x01;
+		else
+			rp->entry[count].type = 0x00;
 
 		rp->entry[count].bus = d->bus;
 		rp->entry[count++].index = cpu_to_le16(d->id);
@@ -9325,23 +9313,14 @@ void mgmt_index_added(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	switch (hdev->dev_type) {
-	case HCI_PRIMARY:
-		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-			mgmt_index_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev,
-					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
-			ev.type = 0x01;
-		} else {
-			mgmt_index_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0,
-					 HCI_MGMT_INDEX_EVENTS);
-			ev.type = 0x00;
-		}
-		break;
-	case HCI_AMP:
-		ev.type = 0x02;
-		break;
-	default:
-		return;
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+		mgmt_index_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev, NULL, 0,
+				 HCI_MGMT_UNCONF_INDEX_EVENTS);
+		ev.type = 0x01;
+	} else {
+		mgmt_index_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0,
+				 HCI_MGMT_INDEX_EVENTS);
+		ev.type = 0x00;
 	}
 
 	ev.bus = hdev->bus;
@@ -9358,25 +9337,16 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	switch (hdev->dev_type) {
-	case HCI_PRIMARY:
-		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
-		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-			mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev,
-					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
-			ev.type = 0x01;
-		} else {
-			mgmt_index_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0,
-					 HCI_MGMT_INDEX_EVENTS);
-			ev.type = 0x00;
-		}
-		break;
-	case HCI_AMP:
-		ev.type = 0x02;
-		break;
-	default:
-		return;
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+		mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0,
+				 HCI_MGMT_UNCONF_INDEX_EVENTS);
+		ev.type = 0x01;
+	} else {
+		mgmt_index_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0,
+				 HCI_MGMT_INDEX_EVENTS);
+		ev.type = 0x00;
 	}
 
 	ev.bus = hdev->bus;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 65cee0ad3c1b..79b822be6c2e 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -27,6 +27,7 @@ EXPORT_SYMBOL_GPL(nf_br_ops);
 /* net device transmit always called with BH disabled */
 netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, ETH_HLEN);
 	struct net_bridge_mcast_port *pmctx_null = NULL;
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
@@ -38,6 +39,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 	br_tc_skb_miss_set(skb, false);
 
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index ee680adcee17..3c66141d34d6 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -78,7 +78,7 @@ static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_v
 {
 	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
 
-	if (v->state == state)
+	if (br_vlan_get_state(v) == state)
 		return;
 
 	br_vlan_set_state(v, state);
@@ -100,11 +100,12 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
-	int err;
+	int err = 0;
 
+	rcu_read_lock();
 	vg = nbp_vlan_group(p);
 	if (!vg)
-		return 0;
+		goto out;
 
 	/* MSTI 0 (CST) state changes are notified via the regular
 	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
@@ -112,17 +113,20 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	if (msti) {
 		err = switchdev_port_attr_set(p->dev, &attr, extack);
 		if (err && err != -EOPNOTSUPP)
-			return err;
+			goto out;
 	}
 
-	list_for_each_entry(v, &vg->vlan_list, vlist) {
+	err = 0;
+	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
 
 		br_mst_vlan_set_state(p, v, state);
 	}
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
diff --git a/net/core/dev.c b/net/core/dev.c
index c365aa06f886..a32811aebde5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10455,8 +10455,9 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rebroadcast_time = jiffies;
 		}
 
+		rcu_barrier();
+
 		if (!wait) {
-			rcu_barrier();
 			wait = WAIT_REFS_MIN_MSECS;
 		} else {
 			msleep(wait);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 68a065c0e508..abd47159d7e4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2000,7 +2000,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason)
 {
-	u32 limit, tail_gso_size, tail_gso_segs;
+	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
 	const struct tcphdr *th;
 	struct tcphdr *thtail;
@@ -2009,6 +2009,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	bool fragstolen;
 	u32 gso_segs;
 	u32 gso_size;
+	u64 limit;
 	int delta;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
@@ -2106,7 +2107,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	__skb_push(skb, hdrlen);
 
 no_coalesce:
-	limit = (u32)READ_ONCE(sk->sk_rcvbuf) + (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
+	/* sk->sk_backlog.len is reset only at the end of __release_sock().
+	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
+	 * sk_rcvbuf in normal conditions.
+	 */
+	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
 
 	/* Only socket owner can try to collapse/prune rx queues
 	 * to reduce memory overhead, so add a little headroom here.
@@ -2114,6 +2121,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	limit += 64 * 1024;
 
+	limit = min_t(u64, limit, UINT_MAX);
+
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
 		*reason = SKB_DROP_REASON_SOCKET_BACKLOG;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9120694359af..e980869f1817 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -429,15 +429,21 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool need_rescore;
 
 	result = NULL;
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
 
+			if (need_rescore)
+				continue;
+
 			if (sk->sk_state == TCP_ESTABLISHED) {
 				result = sk;
 				continue;
@@ -458,9 +464,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(result, net, saddr, sport,
-						daddr, hnum, dif, sdif);
-
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5ebc47da1000..2af98edef87e 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -369,7 +369,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	 * the source of the fragment, with the Pointer field set to zero.
 	 */
 	nexthdr = hdr->nexthdr;
-	if (ipv6frag_thdr_truncated(skb, skb_transport_offset(skb), &nexthdr)) {
+	if (ipv6frag_thdr_truncated(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr), &nexthdr)) {
 		__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 				IPSTATS_MIB_INHDRERRORS);
 		icmpv6_param_prob(skb, ICMPV6_HDR_INCOMP, 0);
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 35508abd76f4..a31521e270f7 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -551,6 +551,8 @@ int __init seg6_init(void)
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
+#endif
+#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
 	genl_unregister_family(&seg6_genl_family);
 #endif
 out_unregister_pernet:
@@ -564,8 +566,9 @@ void seg6_exit(void)
 	seg6_hmac_exit();
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
-	unregister_pernet_subsys(&ip6_segments_ops);
 	genl_unregister_family(&seg6_genl_family);
+	unregister_pernet_subsys(&ip6_segments_ops);
 }
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 785b2d076a6b..936b51f358a9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -171,15 +171,21 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool need_rescore;
 
 	result = NULL;
 	badness = -1;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
 
+			if (need_rescore)
+				continue;
+
 			if (sk->sk_state == TCP_ESTABLISHED) {
 				result = sk;
 				continue;
@@ -200,8 +206,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(sk, net, saddr, sport,
-						daddr, hnum, dif, sdif);
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 8d21ff25f160..4a0fb8731eee 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -887,22 +887,20 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	return 1;
 }
 
-/* UDP encapsulation receive handler. See net/ipv4/udp.c.
- * Return codes:
- * 0 : success.
- * <0: error
- * >0: skb should be passed up to userspace as UDP.
+/* UDP encapsulation receive and error receive handlers.
+ * See net/ipv4/udp.c for details.
+ *
+ * Note that these functions are called from inside an
+ * RCU-protected region, but without the socket being locked.
+ *
+ * Hence we use rcu_dereference_sk_user_data to access the
+ * tunnel data structure rather the usual l2tp_sk_to_tunnel
+ * accessor function.
  */
 int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2tp_tunnel *tunnel;
 
-	/* Note that this is called from the encap_rcv hook inside an
-	 * RCU-protected region, but without the socket being locked.
-	 * Hence we use rcu_dereference_sk_user_data to access the
-	 * tunnel data structure rather the usual l2tp_sk_to_tunnel
-	 * accessor function.
-	 */
 	tunnel = rcu_dereference_sk_user_data(sk);
 	if (!tunnel)
 		goto pass_up;
@@ -919,6 +917,29 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(l2tp_udp_encap_recv);
 
+static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int err,
+				    __be16 port, u32 info, u8 *payload)
+{
+	struct l2tp_tunnel *tunnel;
+
+	tunnel = rcu_dereference_sk_user_data(sk);
+	if (!tunnel || tunnel->fd < 0)
+		return;
+
+	sk->sk_err = err;
+	sk_error_report(sk);
+
+	if (ip_hdr(skb)->version == IPVERSION) {
+		if (inet_test_bit(RECVERR, sk))
+			return ip_icmp_error(sk, skb, err, port, info, payload);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		if (inet6_test_bit(RECVERR6, sk))
+			return ipv6_icmp_error(sk, skb, err, port, info, payload);
+#endif
+	}
+}
+
 /************************************************************************
  * Transmit handling
  ***********************************************************************/
@@ -1493,6 +1514,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 			.sk_user_data = tunnel,
 			.encap_type = UDP_ENCAP_L2TPINUDP,
 			.encap_rcv = l2tp_udp_encap_recv,
+			.encap_err_rcv = l2tp_udp_encap_err_recv,
 			.encap_destroy = l2tp_udp_encap_destroy,
 		};
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac0073c8f96f..df26672fb338 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6184,7 +6184,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 			link->u.mgd.dtim_period = elems->dtim_period;
 		link->u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
-		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
+		    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
 			link->conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
 			link->conf->sync_device_ts =
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 0efdaa8f2a92..3cf252418bd3 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -877,6 +877,7 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_supported_band *sband;
+	u32 mask = ~0;
 
 	rate_control_fill_sta_table(sta, info, dest, max_rates);
 
@@ -889,9 +890,12 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	if (ieee80211_is_tx_data(skb))
 		rate_control_apply_mask(sdata, sta, sband, dest, max_rates);
 
+	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+		mask = sdata->rc_rateidx_mask[info->band];
+
 	if (dest[0].idx < 0)
 		__rate_control_send_low(&sdata->local->hw, sband, sta, info,
-					sdata->rc_rateidx_mask[info->band]);
+					mask);
 
 	if (sta)
 		rate_fixup_ratelist(vif, sband, info, dest, max_rates);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index f9d5842601fa..d613a9e3ae1f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -638,6 +638,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
+		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_SCAN_TX;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
@@ -694,19 +695,11 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		return -EBUSY;
 
 	/* For an MLO connection, if a link ID was specified, validate that it
-	 * is indeed active. If no link ID was specified, select one of the
-	 * active links.
+	 * is indeed active.
 	 */
-	if (ieee80211_vif_is_mld(&sdata->vif)) {
-		if (req->tsf_report_link_id >= 0) {
-			if (!(sdata->vif.active_links &
-			      BIT(req->tsf_report_link_id)))
-				return -EINVAL;
-		} else {
-			req->tsf_report_link_id =
-				__ffs(sdata->vif.active_links);
-		}
-	}
+	if (ieee80211_vif_is_mld(&sdata->vif) && req->tsf_report_link_id >= 0 &&
+	    !(sdata->vif.active_links & BIT(req->tsf_report_link_id)))
+		return -EINVAL;
 
 	if (!__ieee80211_can_leave_ch(sdata))
 		return -EBUSY;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fbb15b65902..a8a4912bf2cb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -701,11 +701,16 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.bss_conf = &tx->sdata->vif.bss_conf;
 	txrc.skb = tx->skb;
 	txrc.reported_rate.idx = -1;
-	txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
 
-	if (tx->sdata->rc_has_mcs_mask[info->band])
-		txrc.rate_idx_mcs_mask =
-			tx->sdata->rc_rateidx_mcs_mask[info->band];
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX)) {
+		txrc.rate_idx_mask = ~0;
+	} else {
+		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
+
+		if (tx->sdata->rc_has_mcs_mask[info->band])
+			txrc.rate_idx_mcs_mask =
+				tx->sdata->rc_rateidx_mcs_mask[info->band];
+	}
 
 	txrc.bss = (tx->sdata->vif.type == NL80211_IFTYPE_AP ||
 		    tx->sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 74c1faec271d..54e29ab911f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1687,15 +1687,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	}
 }
 
-static void mptcp_set_nospace(struct sock *sk)
-{
-	/* enable autotune */
-	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-
-	/* will be cleared on avail space */
-	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
-}
-
 static int mptcp_disconnect(struct sock *sk, int flags);
 
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
@@ -1766,6 +1757,30 @@ static int do_copy_data_nocache(struct sock *sk, int copy,
 	return 0;
 }
 
+/* open-code sk_stream_memory_free() plus sent limit computation to
+ * avoid indirect calls in fast-path.
+ * Called under the msk socket lock, so we can avoid a bunch of ONCE
+ * annotations.
+ */
+static u32 mptcp_send_limit(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 limit, not_sent;
+
+	if (sk->sk_wmem_queued >= READ_ONCE(sk->sk_sndbuf))
+		return 0;
+
+	limit = mptcp_notsent_lowat(sk);
+	if (limit == UINT_MAX)
+		return UINT_MAX;
+
+	not_sent = msk->write_seq - msk->snd_nxt;
+	if (not_sent >= limit)
+		return 0;
+
+	return limit - not_sent;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1810,6 +1825,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		struct mptcp_data_frag *dfrag;
 		bool dfrag_collapsed;
 		size_t psize, offset;
+		u32 copy_limit;
+
+		/* ensure fitting the notsent_lowat() constraint */
+		copy_limit = mptcp_send_limit(sk);
+		if (!copy_limit)
+			goto wait_for_memory;
 
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
@@ -1817,9 +1838,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		dfrag = mptcp_pending_tail(sk);
 		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
 		if (!dfrag_collapsed) {
-			if (!sk_stream_memory_free(sk))
-				goto wait_for_memory;
-
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
@@ -1834,6 +1852,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		offset = dfrag->offset + dfrag->data_len;
 		psize = pfrag->size - offset;
 		psize = min_t(size_t, psize, msg_data_left(msg));
+		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
 
 		if (!sk_wmem_schedule(sk, total_ts))
@@ -1869,7 +1888,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		continue;
 
 wait_for_memory:
-		mptcp_set_nospace(sk);
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
@@ -3770,6 +3789,7 @@ static struct proto mptcp_prot = {
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
 	.forward_alloc_get	= mptcp_forward_alloc_get,
+	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
 	.memory_allocated	= &tcp_memory_allocated,
@@ -3941,12 +3961,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
-	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
-	mptcp_set_nospace(sk);
-	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
-	if (sk_stream_is_writeable(sk))
+	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 07f6242afc1a..5f4c10c41c77 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,10 +113,9 @@
 #define MPTCP_RST_TRANSIENT	BIT(0)
 
 /* MPTCP socket atomic flags */
-#define MPTCP_NOSPACE		1
-#define MPTCP_WORK_RTX		2
-#define MPTCP_FALLBACK_DONE	4
-#define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_WORK_RTX		1
+#define MPTCP_FALLBACK_DONE	2
+#define MPTCP_WORK_CLOSE_SUBFLOW 3
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -306,6 +305,10 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	u32		notsent_lowat;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -790,14 +793,36 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline u32 mptcp_notsent_lowat(const struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	u32 val;
+
+	val = READ_ONCE(mptcp_sk(sk)->notsent_lowat);
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+}
+
+static inline bool mptcp_stream_memory_free(const struct sock *sk, int wake)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 notsent_bytes;
+
+	notsent_bytes = READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
+	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);
+}
+
+static inline bool __mptcp_stream_is_writeable(const struct sock *sk, int wake)
+{
+	return mptcp_stream_memory_free(sk, wake) &&
+	       __sk_stream_is_writeable(sk, wake);
+}
+
 static inline void mptcp_write_space(struct sock *sk)
 {
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
+	/* pairs with memory barrier in mptcp_poll */
+	smp_mb();
+	if (mptcp_stream_memory_free(sk, 1))
+		sk_stream_write_space(sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ef3edba754a3..47aa826ba5fe 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -181,8 +181,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
@@ -624,20 +622,36 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
-static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optval,
-					 unsigned int optlen)
+static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				      int (*set_val)(struct sock *, int),
+				      int *msk_val, int val)
 {
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	int val;
+	int err = 0;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret;
 
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+		lock_sock(ssk);
+		ret = set_val(ssk, val);
+		err = err ? : ret;
+		release_sock(ssk);
+	}
+
+	if (!err) {
+		*msk_val = val;
+		sockopt_seq_inc(msk);
+	}
+
+	return err;
+}
+
+static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
 
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -649,25 +663,15 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 	}
 	if (!val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
 
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
-					    unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
-
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
 
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -679,8 +683,6 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -803,25 +805,10 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	int ret, val;
 
 	switch (optname) {
-	case TCP_INQ:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		lock_sock(sk);
-		msk->recvmsg_inq = !!val;
-		release_sock(sk);
-		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
-	case TCP_CORK:
-		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
-	case TCP_NODELAY:
-		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
@@ -834,7 +821,50 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						      optval, optlen);
 	}
 
-	return -EOPNOTSUPP;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_INQ:
+		if (val < 0 || val > 1)
+			ret = -EINVAL;
+		else
+			msk->recvmsg_inq = !!val;
+		break;
+	case TCP_NOTSENT_LOWAT:
+		WRITE_ONCE(msk->notsent_lowat, val);
+		mptcp_write_space(sk);
+		break;
+	case TCP_CORK:
+		ret = __mptcp_setsockopt_sol_tcp_cork(msk, val);
+		break;
+	case TCP_NODELAY:
+		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
+		break;
+	case TCP_KEEPIDLE:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
+						 &tcp_sock_set_keepidle_locked,
+						 &msk->keepalive_idle, val);
+		break;
+	case TCP_KEEPINTVL:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
+						 &tcp_sock_set_keepintvl,
+						 &msk->keepalive_intvl, val);
+		break;
+	case TCP_KEEPCNT:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						 &tcp_sock_set_keepcnt,
+						 &msk->keepalive_cnt,
+						 val);
+		break;
+	default:
+		ret = -ENOPROTOOPT;
+	}
+
+	release_sock(sk);
+	return ret;
 }
 
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
@@ -1331,6 +1361,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1349,6 +1381,20 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
+	case TCP_KEEPIDLE:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_idle ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_time) / HZ);
+	case TCP_KEEPINTVL:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_intvl ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_intvl) / HZ);
+	case TCP_KEEPCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_cnt ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_probes));
+	case TCP_NOTSENT_LOWAT:
+		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1464,6 +1510,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 70480869ad1c..bd2b17b219ae 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -285,22 +285,14 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	return 0;
 }
 
-static inline void __nr_remove_node(struct nr_node *nr_node)
+static void nr_remove_node_locked(struct nr_node *nr_node)
 {
+	lockdep_assert_held(&nr_node_list_lock);
+
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-#define nr_remove_node_locked(__node) \
-	__nr_remove_node(__node)
-
-static void nr_remove_node(struct nr_node *nr_node)
-{
-	spin_lock_bh(&nr_node_list_lock);
-	__nr_remove_node(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
-}
-
 static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
 {
 	hlist_del_init(&nr_neigh->neigh_node);
@@ -339,6 +331,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
@@ -352,7 +345,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_node->count--;
 
 			if (nr_node->count == 0) {
-				nr_remove_node(nr_node);
+				nr_remove_node_locked(nr_node);
 			} else {
 				switch (i) {
 				case 0:
@@ -367,12 +360,14 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				nr_node_put(nr_node);
 			}
 			nr_node_unlock(nr_node);
+			spin_unlock_bh(&nr_node_list_lock);
 
 			return 0;
 		}
 	}
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 33b21a0c0548..8a848ce72e29 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -561,7 +561,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 	 */
 	key->tp.src = htons(icmp->icmp6_type);
 	key->tp.dst = htons(icmp->icmp6_code);
-	memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
 
 	if (icmp->icmp6_code == 0 &&
 	    (icmp->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
@@ -570,6 +569,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 		struct nd_msg *nd;
 		int offset;
 
+		memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
+
 		/* In order to process neighbor discovery options, we need the
 		 * entire packet.
 		 */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e6a8701a38db..91c9dc0108a2 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2522,8 +2522,7 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
-		if (!packet_read_pending(&po->tx_ring))
-			complete(&po->skb_completion);
+		complete(&po->skb_completion);
 	}
 
 	sock_wfree(skb);
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index abb0c70ffc8b..654a3cc0d347 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -725,6 +725,24 @@ int qrtr_ns_init(void)
 	if (ret < 0)
 		goto err_wq;
 
+	/* As the qrtr ns socket owner and creator is the same module, we have
+	 * to decrease the qrtr module reference count to guarantee that it
+	 * remains zero after the ns socket is created, otherwise, executing
+	 * "rmmod" command is unable to make the qrtr module deleted after the
+	 *  qrtr module is inserted successfully.
+	 *
+	 * However, the reference count is increased twice in
+	 * sock_create_kern(): one is to increase the reference count of owner
+	 * of qrtr socket's proto_ops struct; another is to increment the
+	 * reference count of owner of qrtr proto struct. Therefore, we must
+	 * decrement the module reference count twice to ensure that it keeps
+	 * zero after server's listening socket is created. Of course, we
+	 * must bump the module reference count twice as well before the socket
+	 * is closed.
+	 */
+	module_put(qrtr_ns.sock->ops->owner);
+	module_put(qrtr_ns.sock->sk->sk_prot_creator->owner);
+
 	return 0;
 
 err_wq:
@@ -739,6 +757,15 @@ void qrtr_ns_remove(void)
 {
 	cancel_work_sync(&qrtr_ns.work);
 	destroy_workqueue(qrtr_ns.workqueue);
+
+	/* sock_release() expects the two references that were put during
+	 * qrtr_ns_init(). This function is only called during module remove,
+	 * so try_stop_module() has already set the refcnt to 0. Use
+	 * __module_get() instead of try_module_get() to successfully take two
+	 * references.
+	 */
+	__module_get(qrtr_ns.sock->ops->owner);
+	__module_get(qrtr_ns.sock->sk->sk_prot_creator->owner);
 	sock_release(qrtr_ns.sock);
 }
 EXPORT_SYMBOL_GPL(qrtr_ns_remove);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 24de94184700..96ab50eda9c2 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1033,17 +1033,11 @@ svcauth_gss_proc_init_verf(struct cache_detail *cd, struct svc_rqst *rqstp,
 
 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 {
-	u32 inlen;
 	int i;
 
 	i = 0;
-	inlen = in_token->page_len;
-	while (inlen) {
-		if (in_token->pages[i])
-			put_page(in_token->pages[i]);
-		inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
-	}
-
+	while (in_token->pages[i])
+		put_page(in_token->pages[i++]);
 	kfree(in_token->pages);
 	in_token->pages = NULL;
 }
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 65fc1297c6df..383860cb1d5b 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b969e505c7b7..bd61e257cda6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1263,8 +1263,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argzero);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9df15a7bc256..eb90a255507e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2209,7 +2209,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_err;
 	}
 
-	if (sk->sk_shutdown & SEND_SHUTDOWN)
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto pipe_err;
 
 	while (sent < len) {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index daac83aa8988..4e7b517c78bf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9148,6 +9148,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct wiphy *wiphy;
 	int err, tmp, n_ssids = 0, n_channels, i;
 	size_t ie_len, size;
+	size_t ssids_offset, ie_offset;
 
 	wiphy = &rdev->wiphy;
 
@@ -9193,21 +9194,20 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	size = struct_size(request, channels, n_channels);
+	ssids_offset = size;
 	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
+	ie_offset = size;
 	size = size_add(size, ie_len);
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
+	request->n_channels = n_channels;
 
 	if (n_ssids)
-		request->ssids = (void *)&request->channels[n_channels];
+		request->ssids = (void *)request + ssids_offset;
 	request->n_ssids = n_ssids;
-	if (ie_len) {
-		if (n_ssids)
-			request->ie = (void *)(request->ssids + n_ssids);
-		else
-			request->ie = (void *)(request->channels + n_channels);
-	}
+	if (ie_len)
+		request->ie = (void *)request + ie_offset;
 
 	i = 0;
 	if (scan_freqs) {
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index cc3fd4177bce..0cf8f958081e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1747,7 +1747,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1764,7 +1764,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08596c0ef070..e6c59f688573 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -151,7 +151,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 				const __u64 allowed_access)
 {
 	int ret = 1;
-	char *env_port_name, *strport;
+	char *env_port_name, *env_port_name_next, *strport;
 	struct landlock_net_port_attr net_port = {
 		.allowed_access = allowed_access,
 		.port = 0,
@@ -163,7 +163,8 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	env_port_name = strdup(env_port_name);
 	unsetenv(env_var);
 
-	while ((strport = strsep(&env_port_name, ENV_DELIMITER))) {
+	env_port_name_next = env_port_name;
+	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
 		net_port.port = atoi(strport);
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				      &net_port, 0)) {
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index bf5bcf2836d8..89ff01a22634 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -13,6 +13,7 @@ SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		*(.export_symbol)
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
diff --git a/sound/core/init.c b/sound/core/init.c
index 22c0d217b860..d97b8af897ee 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -312,8 +312,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 	card->number = idx;
 #ifdef MODULE
 	WARN_ON(!module);
-	card->module = module;
 #endif
+	card->module = module;
 	INIT_LIST_HEAD(&card->devices);
 	init_rwsem(&card->controls_rwsem);
 	rwlock_init(&card->ctl_files_rwlock);
@@ -523,6 +523,14 @@ void snd_card_disconnect(struct snd_card *card)
 	}
 	spin_unlock(&card->files_lock);	
 
+#ifdef CONFIG_PM
+	/* wake up sleepers here before other callbacks for avoiding potential
+	 * deadlocks with other locks (e.g. in kctls);
+	 * then this notifies the shutdown and sleepers would abort immediately
+	 */
+	wake_up_all(&card->power_sleep);
+#endif
+
 	/* notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
 
@@ -550,7 +558,6 @@ void snd_card_disconnect(struct snd_card *card)
 	mutex_unlock(&snd_card_mutex);
 
 #ifdef CONFIG_PM
-	wake_up(&card->power_sleep);
 	snd_power_sync_ref(card);
 #endif
 }
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 6a384b922e4f..d1f6cdcf1866 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -557,9 +557,32 @@ static const struct config_entry *snd_intel_dsp_find_config
 		if (table->codec_hid) {
 			int i;
 
-			for (i = 0; i < table->codec_hid->num_codecs; i++)
-				if (acpi_dev_present(table->codec_hid->codecs[i], NULL, -1))
+			for (i = 0; i < table->codec_hid->num_codecs; i++) {
+				struct nhlt_acpi_table *nhlt;
+				bool ssp_found = false;
+
+				if (!acpi_dev_present(table->codec_hid->codecs[i], NULL, -1))
+					continue;
+
+				nhlt = intel_nhlt_init(&pci->dev);
+				if (!nhlt) {
+					dev_warn(&pci->dev, "%s: NHLT table not found, skipped HID %s\n",
+						 __func__, table->codec_hid->codecs[i]);
+					continue;
+				}
+
+				if (intel_nhlt_has_endpoint_type(nhlt, NHLT_LINK_SSP) &&
+				    intel_nhlt_ssp_endpoint_mask(nhlt, NHLT_DEVICE_I2S))
+					ssp_found = true;
+
+				intel_nhlt_free(nhlt);
+
+				if (ssp_found)
 					break;
+
+				dev_warn(&pci->dev, "%s: no valid SSP found for HID %s, skipped\n",
+					 __func__, table->codec_hid->codecs[i]);
+			}
 			if (i == table->codec_hid->num_codecs)
 				continue;
 		}
diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 74df2330015f..5cb8acf5b158 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -285,6 +285,7 @@ static void snd_emu1010_fpga_write_locked(struct snd_emu10k1 *emu, u32 reg, u32
 	outw(value, emu->port + A_GPIO);
 	udelay(10);
 	outw(value | 0x80 , emu->port + A_GPIO);  /* High bit clocks the value into the fpga. */
+	udelay(10);
 }
 
 void snd_emu1010_fpga_write(struct snd_emu10k1 *emu, u32 reg, u32 value)
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 4d1f8734d13f..c2067e8083c0 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -99,8 +99,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
-	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 43a445bd961f..de58a953b48d 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -629,6 +629,8 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
 			goto err_powered_up;
+
+		regcache_cache_only(cs35l56->base.regmap, false);
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
@@ -978,6 +980,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 	if (ret)
 		goto err;
 
+	regcache_cache_only(cs35l56->base.regmap, false);
+
 	ret = cs35l56_set_patch(&cs35l56->base);
 	if (ret)
 		goto err;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7c82f93ba919..c0e12e674692 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10089,8 +10089,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c89, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8d, "HP ProBook 440 G11", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8e, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c90, "HP EliteBook 640", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7a6b..1760b5d42460 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index dfb4ce53491b..f8e57a2fc3e3 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1094,6 +1094,7 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 {
 	struct wm_adsp *dsp;
+	uint32_t dsp1rx5_src;
 	int ret;
 
 	dsp = &cs35l41->dsp;
@@ -1113,16 +1114,29 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 		return ret;
 	}
 
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX5_SRC,
-			   CS35L41_INPUT_SRC_VPMON);
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_INT_BOOST:
+	case CS35L41_SHD_BOOST_ACTV:
+		dsp1rx5_src = CS35L41_INPUT_SRC_VPMON;
+		break;
+	case CS35L41_EXT_BOOST:
+	case CS35L41_SHD_BOOST_PASS:
+		dsp1rx5_src = CS35L41_INPUT_SRC_VBSTMON;
+		break;
+	default:
+		dev_err(cs35l41->dev, "wm_halo_init failed - Invalid Boost Type: %d\n",
+			cs35l41->hw_cfg.bst_type);
+		goto err_dsp;
+	}
+
+	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX5_SRC, dsp1rx5_src);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write INPUT_SRC_VPMON failed: %d\n", ret);
+		dev_err(cs35l41->dev, "Write DSP1RX5_SRC: %d failed: %d\n", dsp1rx5_src, ret);
 		goto err_dsp;
 	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX6_SRC,
-			   CS35L41_INPUT_SRC_CLASSH);
+	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX6_SRC, CS35L41_INPUT_SRC_VBSTMON);
 	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write INPUT_SRC_CLASSH failed: %d\n", ret);
+		dev_err(cs35l41->dev, "Write CS35L41_INPUT_SRC_VBSTMON failed: %d\n", ret);
 		goto err_dsp;
 	}
 	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_RX7_SRC,
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 6dd0319bc843..ea72afe3f906 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1297,6 +1297,7 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 				    "spk-id-gpios", ACPI_TYPE_PACKAGE, &obj);
 	if (ret) {
 		dev_dbg(cs35l56->base.dev, "Could not get spk-id-gpios package: %d\n", ret);
+		fwnode_handle_put(af01_fwnode);
 		return -ENOENT;
 	}
 
@@ -1304,6 +1305,7 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 	if (obj->package.count != 4) {
 		dev_warn(cs35l56->base.dev, "Unexpected spk-id element count %d\n",
 			 obj->package.count);
+		fwnode_handle_put(af01_fwnode);
 		return -ENOENT;
 	}
 
@@ -1318,6 +1320,7 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 		 */
 		ret = acpi_dev_add_driver_gpios(adev, cs35l56_af01_spkid_gpios_mapping);
 		if (ret) {
+			fwnode_handle_put(af01_fwnode);
 			return dev_err_probe(cs35l56->base.dev, ret,
 					     "Failed to add gpio mapping to AF01\n");
 		}
@@ -1325,14 +1328,17 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 		ret = devm_add_action_or_reset(cs35l56->base.dev,
 					       cs35l56_acpi_dev_release_driver_gpios,
 					       adev);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(af01_fwnode);
 			return ret;
+		}
 
 		dev_dbg(cs35l56->base.dev, "Added spk-id-gpios mapping to AF01\n");
 	}
 
 	desc = fwnode_gpiod_get_index(af01_fwnode, "spk-id", 0, GPIOD_IN, NULL);
 	if (IS_ERR(desc)) {
+		fwnode_handle_put(af01_fwnode);
 		ret = PTR_ERR(desc);
 		return dev_err_probe(cs35l56->base.dev, ret, "Get GPIO from AF01 failed\n");
 	}
@@ -1341,9 +1347,12 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private *cs35l5
 	gpiod_put(desc);
 
 	if (ret < 0) {
+		fwnode_handle_put(af01_fwnode);
 		dev_err_probe(cs35l56->base.dev, ret, "Error reading spk-id GPIO\n");
 		return ret;
-		}
+	}
+
+	fwnode_handle_put(af01_fwnode);
 
 	dev_info(cs35l56->base.dev, "Got spk-id from AF01\n");
 
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 6bc068cdcbe2..15e5e3eb592b 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -671,8 +671,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -753,6 +755,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 20191a4473c2..0384e237a548 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -444,6 +444,7 @@ struct rt5645_priv {
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_hp_det;
+	struct gpio_desc *gpiod_cbj_sleeve;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
@@ -3186,6 +3187,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
 			RT5645_CBJ_MN_JD, 0);
 
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 1);
+
 		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
@@ -3202,6 +3206,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
+			if (rt5645->gpiod_cbj_sleeve)
+				gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 		}
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
@@ -3229,6 +3235,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 	}
 
 	return rt5645->jack_type;
@@ -4012,6 +4021,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c)
 			return ret;
 	}
 
+	rt5645->gpiod_cbj_sleeve = devm_gpiod_get_optional(&i2c->dev, "cbj-sleeve",
+							   GPIOD_OUT_LOW);
+
+	if (IS_ERR(rt5645->gpiod_cbj_sleeve)) {
+		ret = PTR_ERR(rt5645->gpiod_cbj_sleeve);
+		dev_info(&i2c->dev, "failed to initialize gpiod, ret=%d\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
 		rt5645->supplies[i].supply = rt5645_supply_names[i];
 
@@ -4259,6 +4278,9 @@ static void rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 }
 
@@ -4274,6 +4296,9 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 		0);
 	msleep(20);
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
+
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 }
 
 static int __maybe_unused rt5645_sys_suspend(struct device *dev)
diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 4533eedd7e18..27d17e3cc802 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -316,7 +316,7 @@ static int rt715_sdca_set_amp_gain_8ch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 
 static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
@@ -477,7 +477,7 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_02),
-			0x2f, 0x7f, 0,
+			0x2f, 0x3f, 0,
 		rt715_sdca_set_amp_gain_get, rt715_sdca_set_amp_gain_put,
 		in_vol_tlv),
 	RT715_SDCA_EXT_TLV("FU02 Capture Volume",
@@ -485,13 +485,13 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		rt715_sdca_set_amp_gain_4ch_get,
 		rt715_sdca_set_amp_gain_4ch_put,
-		in_vol_tlv, 4, 0x7f),
+		in_vol_tlv, 4, 0x3f),
 	RT715_SDCA_EXT_TLV("FU06 Capture Volume",
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC10_11_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		rt715_sdca_set_amp_gain_4ch_get,
 		rt715_sdca_set_amp_gain_4ch_put,
-		in_vol_tlv, 4, 0x7f),
+		in_vol_tlv, 4, 0x3f),
 	/* MIC Boost Control */
 	RT715_SDCA_BOOST_EXT_TLV("FU0E Boost",
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 21f37babd148..376585f5a8dd 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -111,6 +111,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index 0e1c65a20392..9ff607984ea1 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -1329,7 +1329,7 @@ static struct snd_soc_dai_driver rt722_sdca_dai[] = {
 		.capture = {
 			.stream_name = "DP6 DMic Capture",
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 4,
 			.rates = RT722_STEREO_RATES,
 			.formats = RT722_FORMATS,
 		},
@@ -1438,9 +1438,12 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 	int loop_check, chk_cnt = 100, ret;
 	unsigned int calib_status = 0;
 
-	/* Read eFuse */
-	rt722_sdca_index_write(rt722, RT722_VENDOR_SPK_EFUSE, RT722_DC_CALIB_CTRL,
-		0x4808);
+	/* Config analog bias */
+	rt722_sdca_index_write(rt722, RT722_VENDOR_REG, RT722_ANALOG_BIAS_CTL3,
+		0xa081);
+	/* GE related settings */
+	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_GE_RELATED_CTL2,
+		0xa009);
 	/* Button A, B, C, D bypass mode */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_UMP_HID_CTL4,
 		0xcf00);
@@ -1474,9 +1477,6 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 		if ((calib_status & 0x0040) == 0x0)
 			break;
 	}
-	/* Release HP-JD, EN_CBJ_TIE_GL/R open, en_osw gating auto done bit */
-	rt722_sdca_index_write(rt722, RT722_VENDOR_REG, RT722_DIGITAL_MISC_CTRL4,
-		0x0010);
 	/* Set ADC09 power entity floating control */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_ADC0A_08_PDE_FLOAT_CTL,
 		0x2a12);
@@ -1489,8 +1489,21 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 	/* Set DAC03 and HP power entity floating control */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_DAC03_HP_PDE_FLOAT_CTL,
 		0x4040);
+	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_ENT_FLOAT_CTRL_1,
+		0x4141);
+	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_FLOAT_CTRL_1,
+		0x0101);
 	/* Fine tune PDE40 latency */
 	regmap_write(rt722->regmap, 0x2f58, 0x07);
+	regmap_write(rt722->regmap, 0x2f03, 0x06);
+	/* MIC VRefo */
+	rt722_sdca_index_update_bits(rt722, RT722_VENDOR_REG,
+		RT722_COMBO_JACK_AUTO_CTL1, 0x0200, 0x0200);
+	rt722_sdca_index_update_bits(rt722, RT722_VENDOR_REG,
+		RT722_VREFO_GAT, 0x4000, 0x4000);
+	/* Release HP-JD, EN_CBJ_TIE_GL/R open, en_osw gating auto done bit */
+	rt722_sdca_index_write(rt722, RT722_VENDOR_REG, RT722_DIGITAL_MISC_CTRL4,
+		0x0010);
 }
 
 int rt722_sdca_io_init(struct device *dev, struct sdw_slave *slave)
diff --git a/sound/soc/codecs/rt722-sdca.h b/sound/soc/codecs/rt722-sdca.h
index 44af8901352e..2464361a7958 100644
--- a/sound/soc/codecs/rt722-sdca.h
+++ b/sound/soc/codecs/rt722-sdca.h
@@ -69,6 +69,7 @@ struct rt722_sdca_dmic_kctrl_priv {
 #define RT722_COMBO_JACK_AUTO_CTL2		0x46
 #define RT722_COMBO_JACK_AUTO_CTL3		0x47
 #define RT722_DIGITAL_MISC_CTRL4		0x4a
+#define RT722_VREFO_GAT				0x63
 #define RT722_FSM_CTL				0x67
 #define RT722_SDCA_INTR_REC			0x82
 #define RT722_SW_CONFIG1			0x8a
@@ -127,6 +128,8 @@ struct rt722_sdca_dmic_kctrl_priv {
 #define RT722_UMP_HID_CTL6			0x66
 #define RT722_UMP_HID_CTL7			0x67
 #define RT722_UMP_HID_CTL8			0x68
+#define RT722_FLOAT_CTRL_1			0x70
+#define RT722_ENT_FLOAT_CTRL_1		0x76
 
 /* Parameter & Verb control 01 (0x1a)(NID:20h) */
 #define RT722_HIDDEN_REG_SW_RESET (0x1 << 14)
diff --git a/sound/soc/intel/avs/boards/ssm4567.c b/sound/soc/intel/avs/boards/ssm4567.c
index 4a0e136835ff..b64be685dc23 100644
--- a/sound/soc/intel/avs/boards/ssm4567.c
+++ b/sound/soc/intel/avs/boards/ssm4567.c
@@ -172,7 +172,6 @@ static int avs_ssm4567_probe(struct platform_device *pdev)
 	card->dapm_routes = card_base_routes;
 	card->num_dapm_routes = ARRAY_SIZE(card_base_routes);
 	card->fully_routed = true;
-	card->disable_route_checks = true;
 
 	ret = snd_soc_fixup_dai_links_platform_name(card, pname);
 	if (ret)
diff --git a/sound/soc/intel/avs/cldma.c b/sound/soc/intel/avs/cldma.c
index d7a9390b5e48..585579840b64 100644
--- a/sound/soc/intel/avs/cldma.c
+++ b/sound/soc/intel/avs/cldma.c
@@ -35,7 +35,7 @@ struct hda_cldma {
 
 	unsigned int buffer_size;
 	unsigned int num_periods;
-	unsigned int stream_tag;
+	unsigned char stream_tag;
 	void __iomem *sd_addr;
 
 	struct snd_dma_buffer dmab_data;
diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index 3aa16ee8d34c..2fae84727a3b 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -367,6 +367,7 @@ static int avs_asrc_create(struct avs_dev *adev, struct avs_path_module *mod)
 	struct avs_tplg_module *t = mod->template;
 	struct avs_asrc_cfg cfg;
 
+	memset(&cfg, 0, sizeof(cfg));
 	cfg.base.cpc = t->cfg_base->cpc;
 	cfg.base.ibs = t->cfg_base->ibs;
 	cfg.base.obs = t->cfg_base->obs;
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 4dfc5a1ebb7c..f25a293c0915 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -356,6 +356,7 @@ static int avs_dai_hda_be_prepare(struct snd_pcm_substream *substream, struct sn
 					   stream_info->sig_bits);
 	format_val = snd_hdac_stream_format(runtime->channels, bits, runtime->rate);
 
+	snd_hdac_ext_stream_decouple(bus, link_stream, true);
 	snd_hdac_ext_stream_reset(link_stream);
 	snd_hdac_ext_stream_setup(link_stream, format_val);
 
@@ -611,6 +612,7 @@ static int avs_dai_fe_prepare(struct snd_pcm_substream *substream, struct snd_so
 	struct avs_dev *adev = to_avs_dev(dai->dev);
 	struct hdac_ext_stream *host_stream;
 	unsigned int format_val;
+	struct hdac_bus *bus;
 	unsigned int bits;
 	int ret;
 
@@ -620,6 +622,8 @@ static int avs_dai_fe_prepare(struct snd_pcm_substream *substream, struct snd_so
 	if (hdac_stream(host_stream)->prepared)
 		return 0;
 
+	bus = hdac_stream(host_stream)->bus;
+	snd_hdac_ext_stream_decouple(bus, data->host_stream, true);
 	snd_hdac_stream_reset(hdac_stream(host_stream));
 
 	stream_info = snd_soc_dai_get_pcm_stream(dai, substream->stream);
diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 817e543036f2..7e781a315690 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -19,8 +19,11 @@ static int avs_dsp_init_probe(struct avs_dev *adev, union avs_connector_node_id
 	struct avs_probe_cfg cfg = {{0}};
 	struct avs_module_entry mentry;
 	u8 dummy;
+	int ret;
 
-	avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
+	ret = avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
+	if (ret)
+		return ret;
 
 	/*
 	 * Probe module uses no cycles, audio data format and input and output
@@ -39,11 +42,12 @@ static int avs_dsp_init_probe(struct avs_dev *adev, union avs_connector_node_id
 static void avs_dsp_delete_probe(struct avs_dev *adev)
 {
 	struct avs_module_entry mentry;
+	int ret;
 
-	avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
-
-	/* There is only ever one probe module instance. */
-	avs_dsp_delete_module(adev, mentry.module_id, 0, INVALID_PIPELINE_ID, 0);
+	ret = avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
+	if (!ret)
+		/* There is only ever one probe module instance. */
+		avs_dsp_delete_module(adev, mentry.module_id, 0, INVALID_PIPELINE_ID, 0);
 }
 
 static inline struct hdac_ext_stream *avs_compr_get_host_stream(struct snd_compr_stream *cstream)
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 540f7a29310a..3fe3f38c6cb6 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -768,6 +768,7 @@ static struct snd_soc_card broxton_audio_card = {
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index c0eb65c14aa9..afc499be8db2 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -574,6 +574,7 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 05f38d1f7d82..b41a1147f1c3 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -636,28 +636,30 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_USE_AMCR0F28),
 	},
 	{
+		/* Asus T100TAF, unlike other T100TA* models this one has a mono speaker */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_JD_SRC_JD2_IN4N |
 					BYT_RT5640_OVCD_TH_2000UA |
 					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
+		/* Asus T100TA and T100TAM, must come after T100TAF (mono spk) match */
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_JD_SRC_JD2_IN4N |
 					BYT_RT5640_OVCD_TH_2000UA |
 					BYT_RT5640_OVCD_SF_0P75 |
-					BYT_RT5640_MONO_SPEAKER |
-					BYT_RT5640_DIFF_MIC |
-					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 657e4658234c..4098b2d32f9b 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -649,6 +649,8 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	card = &glk_audio_card_rt5682_m98357a;
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, ctx);
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		card->disable_route_checks = true;
 
 	/* override platform name, if required */
 	mach = pdev->dev.platform_data;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index a5d8965303a8..9dbc15f9d1c9 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -639,6 +639,7 @@ static struct snd_soc_card kabylake_audio_card_da7219_m98357a = {
 	.dapm_routes = kabylake_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 98c11ec0adc0..e662da5af83b 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -1036,6 +1036,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1054,6 +1055,7 @@ static struct snd_soc_card kbl_audio_card_max98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1071,6 +1073,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1088,6 +1091,7 @@ static struct snd_soc_card kbl_audio_card_max98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 30e0aca161cd..894d127c482a 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -518,6 +518,7 @@ static struct snd_soc_card kabylake_audio_card_rt5660 = {
 	.dapm_routes = kabylake_rt5660_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_rt5660_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 9071b1f1cbd0..646e8ff8e961 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -966,6 +966,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -982,6 +983,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 	.dapm_routes = kabylake_5663_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_5663_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 178fe9c37df6..924d5d1de03a 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -791,6 +791,7 @@ static struct snd_soc_card kabylake_audio_card = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 6e172719c979..4aa7fd2a05e4 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -227,6 +227,8 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
 
 	hda_soc_card.dev = &pdev->dev;
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		hda_soc_card.disable_route_checks = true;
 
 	if (mach->mach_params.dmic_num > 0) {
 		snprintf(hda_soc_components, sizeof(hda_soc_components),
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 0e7025834594..e4630c33176e 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -654,6 +654,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.dapm_routes = skylake_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index c59c60e28091..9a8044274908 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -523,6 +523,7 @@ static struct snd_soc_card skylake_rt286 = {
 	.dapm_routes = skylake_rt286_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_rt286_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index dd2f806526c1..ef00792e1d49 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -182,6 +182,9 @@ static int kirkwood_dma_hw_params(struct snd_soc_component *component,
 	const struct mbus_dram_target_info *dram = mv_mbus_dram_info();
 	unsigned long addr = substream->runtime->dma_addr;
 
+	if (!dram)
+		return 0;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_PLAYBACK_WIN, addr, dram);
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index a58e1e3674de..000a086a8cf4 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -22,7 +22,11 @@ static int set_card_codec_info(struct snd_soc_card *card,
 
 	codec_node = of_get_child_by_name(sub_node, "codec");
 	if (!codec_node) {
-		dev_dbg(dev, "%s no specified codec\n", dai_link->name);
+		dev_dbg(dev, "%s no specified codec: setting dummy.\n", dai_link->name);
+
+		dai_link->codecs = &snd_soc_dummy_dlc;
+		dai_link->num_codecs = 1;
+		dai_link->dynamic = 1;
 		return 0;
 	}
 
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index f4cbc0ad5de3..0e665c0840d7 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -434,10 +434,17 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 			  int link_id)
 {
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	const struct hda_dai_widget_dma_ops *ops;
+	struct snd_soc_dai_link_ch_map *ch_maps;
 	struct hdac_ext_stream *hext_stream;
+	struct snd_soc_dai *dai;
 	struct snd_sof_dev *sdev;
+	bool cpu_dai_found = false;
+	int cpu_dai_id;
+	int ch_mask;
 	int ret;
+	int j;
 
 	ret = non_hda_dai_hw_params(substream, params, cpu_dai);
 	if (ret < 0) {
@@ -452,9 +459,29 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	if (!hext_stream)
 		return -ENODEV;
 
-	/* in the case of SoundWire we need to program the PCMSyCM registers */
+	/*
+	 * in the case of SoundWire we need to program the PCMSyCM registers. In case
+	 * of aggregated devices, we need to define the channel mask for each sublink
+	 * by reconstructing the split done in soc-pcm.c
+	 */
+	for_each_rtd_cpu_dais(rtd, cpu_dai_id, dai) {
+		if (dai == cpu_dai) {
+			cpu_dai_found = true;
+			break;
+		}
+	}
+
+	if (!cpu_dai_found)
+		return -ENODEV;
+
+	ch_mask = 0;
+	for_each_link_ch_maps(rtd->dai_link, j, ch_maps) {
+		if (ch_maps->cpu == cpu_dai_id)
+			ch_mask |= ch_maps->ch_mask;
+	}
+
 	ret = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id, cpu_dai->id,
-					     GENMASK(params_channels(params) - 1, 0),
+					     ch_mask,
 					     hdac_stream(hext_stream)->stream_tag,
 					     substream->stream);
 	if (ret < 0) {
diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 555a51c688dc..d6c4d6cd20b0 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -16,6 +16,7 @@
 #include "hda-ipc.h"
 #include "../sof-audio.h"
 #include "mtl.h"
+#include "lnl.h"
 #include <sound/hda-mlink.h>
 
 /* LunarLake ops */
@@ -176,7 +177,7 @@ const struct sof_intel_dsp_desc lnl_chip_info = {
 	.ipc_ack = MTL_DSP_REG_HFIPCXIDA,
 	.ipc_ack_mask = MTL_DSP_REG_HFIPCXIDA_DONE,
 	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
-	.rom_status_reg = MTL_DSP_ROM_STS,
+	.rom_status_reg = LNL_DSP_REG_HFDSC,
 	.rom_init_timeout = 300,
 	.ssp_count = MTL_SSP_COUNT,
 	.d0i3_offset = MTL_HDA_VS_D0I3C,
diff --git a/sound/soc/sof/intel/lnl.h b/sound/soc/sof/intel/lnl.h
new file mode 100644
index 000000000000..4f4734fe7e08
--- /dev/null
+++ b/sound/soc/sof/intel/lnl.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __SOF_INTEL_LNL_H
+#define __SOF_INTEL_LNL_H
+
+#define LNL_DSP_REG_HFDSC		0x160200 /* DSP core0 status */
+#define LNL_DSP_REG_HFDEC		0x160204 /* DSP core0 error */
+
+#endif /* __SOF_INTEL_LNL_H */
diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 060c34988e90..05023763080d 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -439,7 +439,7 @@ int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
-	unsigned int status;
+	unsigned int status, target_status;
 	u32 ipc_hdr, flags;
 	char *dump_msg;
 	int ret;
@@ -485,13 +485,40 @@ int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
 
 	mtl_enable_ipc_interrupts(sdev);
 
+	if (chip->rom_status_reg == MTL_DSP_ROM_STS) {
+		/*
+		 * Workaround: when the ROM status register is pointing to
+		 * the SRAM window (MTL_DSP_ROM_STS) the platform cannot catch
+		 * ROM_INIT_DONE because of a very short timing window.
+		 * Follow the recommendations and skip target state waiting.
+		 */
+		return 0;
+	}
+
 	/*
-	 * ACE workaround: don't wait for ROM INIT.
-	 * The platform cannot catch ROM_INIT_DONE because of a very short
-	 * timing window. Follow the recommendations and skip this part.
+	 * step 7:
+	 * - Cold/Full boot: wait for ROM init to proceed to download the firmware
+	 * - IMR boot: wait for ROM firmware entered (firmware booted up from IMR)
 	 */
+	if (imr_boot)
+		target_status = FSR_STATE_FW_ENTERED;
+	else
+		target_status = FSR_STATE_INIT_DONE;
 
-	return 0;
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
+					chip->rom_status_reg, status,
+					(FSR_TO_STATE_CODE(status) == target_status),
+					HDA_DSP_REG_POLL_INTERVAL_US,
+					chip->rom_init_timeout *
+					USEC_PER_MSEC);
+
+	if (!ret)
+		return 0;
+
+	if (hda->boot_iteration == HDA_FW_BOOT_ATTEMPTS)
+		dev_err(sdev->dev,
+			"%s: timeout with rom_status_reg (%#x) read\n",
+			__func__, chip->rom_status_reg);
 
 err:
 	flags = SOF_DBG_DUMP_PCI | SOF_DBG_DUMP_MBOX | SOF_DBG_DUMP_OPTIONAL;
@@ -503,6 +530,7 @@ int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
 	dump_msg = kasprintf(GFP_KERNEL, "Boot iteration failed: %d/%d",
 			     hda->boot_iteration, HDA_FW_BOOT_ATTEMPTS);
 	snd_sof_dsp_dbg_dump(sdev, dump_msg, flags);
+	mtl_enable_interrupts(sdev, false);
 	mtl_dsp_core_power_down(sdev, SOF_DSP_PRIMARY_CORE);
 
 	kfree(dump_msg);
@@ -727,7 +755,7 @@ const struct sof_intel_dsp_desc mtl_chip_info = {
 	.ipc_ack = MTL_DSP_REG_HFIPCXIDA,
 	.ipc_ack_mask = MTL_DSP_REG_HFIPCXIDA_DONE,
 	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
-	.rom_status_reg = MTL_DSP_ROM_STS,
+	.rom_status_reg = MTL_DSP_REG_HFFLGPXQWY,
 	.rom_init_timeout	= 300,
 	.ssp_count = MTL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
@@ -755,7 +783,7 @@ const struct sof_intel_dsp_desc arl_s_chip_info = {
 	.ipc_ack = MTL_DSP_REG_HFIPCXIDA,
 	.ipc_ack_mask = MTL_DSP_REG_HFIPCXIDA_DONE,
 	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
-	.rom_status_reg = MTL_DSP_ROM_STS,
+	.rom_status_reg = MTL_DSP_REG_HFFLGPXQWY,
 	.rom_init_timeout	= 300,
 	.ssp_count = MTL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index ea8c1b83f712..3c56427a966b 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -70,8 +70,8 @@
 #define MTL_DSP_ROM_STS			MTL_SRAM_WINDOW_OFFSET(0) /* ROM status */
 #define MTL_DSP_ROM_ERROR		(MTL_SRAM_WINDOW_OFFSET(0) + 0x4) /* ROM error code */
 
-#define MTL_DSP_REG_HFFLGPXQWY		0x163200 /* ROM debug status */
-#define MTL_DSP_REG_HFFLGPXQWY_ERROR	0x163204 /* ROM debug error code */
+#define MTL_DSP_REG_HFFLGPXQWY		0x163200 /* DSP core0 status */
+#define MTL_DSP_REG_HFFLGPXQWY_ERROR	0x163204 /* DSP core0 error */
 #define MTL_DSP_REG_HfIMRIS1		0x162088
 #define MTL_DSP_REG_HfIMRIS1_IU_MASK	BIT(0)
 
diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index 330f04bcd75d..a7cf52fd7645 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -409,4 +409,5 @@ const struct sof_ipc_pcm_ops ipc3_pcm_ops = {
 	.trigger = sof_ipc3_pcm_trigger,
 	.dai_link_fixup = sof_ipc3_pcm_dai_link_fixup,
 	.reset_hw_params_during_stop = true,
+	.d0i3_supported_in_s0ix = true,
 };
diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index a99fced90825..d07c1b06207a 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -37,6 +37,22 @@ struct sof_ipc4_timestamp_info {
 	snd_pcm_sframes_t delay;
 };
 
+/**
+ * struct sof_ipc4_pcm_stream_priv - IPC4 specific private data
+ * @time_info: pointer to time info struct if it is supported, otherwise NULL
+ */
+struct sof_ipc4_pcm_stream_priv {
+	struct sof_ipc4_timestamp_info *time_info;
+};
+
+static inline struct sof_ipc4_timestamp_info *
+sof_ipc4_sps_to_time_info(struct snd_sof_pcm_stream *sps)
+{
+	struct sof_ipc4_pcm_stream_priv *stream_priv = sps->private;
+
+	return stream_priv->time_info;
+}
+
 static int sof_ipc4_set_multi_pipeline_state(struct snd_sof_dev *sdev, u32 state,
 					     struct ipc4_pipeline_set_state_data *trigger_list)
 {
@@ -435,7 +451,7 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 		 * Invalidate the stream_start_offset to make sure that it is
 		 * going to be updated if the stream resumes
 		 */
-		time_info = spcm->stream[substream->stream].private;
+		time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
 		if (time_info)
 			time_info->stream_start_offset = SOF_IPC4_INVALID_STREAM_POSITION;
 
@@ -689,12 +705,16 @@ static int sof_ipc4_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 static void sof_ipc4_pcm_free(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm)
 {
 	struct snd_sof_pcm_stream_pipeline_list *pipeline_list;
+	struct sof_ipc4_pcm_stream_priv *stream_priv;
 	int stream;
 
 	for_each_pcm_streams(stream) {
 		pipeline_list = &spcm->stream[stream].pipeline_list;
 		kfree(pipeline_list->pipelines);
 		pipeline_list->pipelines = NULL;
+
+		stream_priv = spcm->stream[stream].private;
+		kfree(stream_priv->time_info);
 		kfree(spcm->stream[stream].private);
 		spcm->stream[stream].private = NULL;
 	}
@@ -704,7 +724,8 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 {
 	struct snd_sof_pcm_stream_pipeline_list *pipeline_list;
 	struct sof_ipc4_fw_data *ipc4_data = sdev->private;
-	struct sof_ipc4_timestamp_info *stream_info;
+	struct sof_ipc4_pcm_stream_priv *stream_priv;
+	struct sof_ipc4_timestamp_info *time_info;
 	bool support_info = true;
 	u32 abi_version;
 	u32 abi_offset;
@@ -732,33 +753,41 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 			return -ENOMEM;
 		}
 
+		stream_priv = kzalloc(sizeof(*stream_priv), GFP_KERNEL);
+		if (!stream_priv) {
+			sof_ipc4_pcm_free(sdev, spcm);
+			return -ENOMEM;
+		}
+
+		spcm->stream[stream].private = stream_priv;
+
 		if (!support_info)
 			continue;
 
-		stream_info = kzalloc(sizeof(*stream_info), GFP_KERNEL);
-		if (!stream_info) {
+		time_info = kzalloc(sizeof(*time_info), GFP_KERNEL);
+		if (!time_info) {
 			sof_ipc4_pcm_free(sdev, spcm);
 			return -ENOMEM;
 		}
 
-		spcm->stream[stream].private = stream_info;
+		stream_priv->time_info = time_info;
 	}
 
 	return 0;
 }
 
-static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *spcm)
+static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *sps)
 {
 	struct sof_ipc4_copier *host_copier = NULL;
 	struct sof_ipc4_copier *dai_copier = NULL;
 	struct sof_ipc4_llp_reading_slot llp_slot;
-	struct sof_ipc4_timestamp_info *info;
+	struct sof_ipc4_timestamp_info *time_info;
 	struct snd_soc_dapm_widget *widget;
 	struct snd_sof_dai *dai;
 	int i;
 
 	/* find host & dai to locate info in memory window */
-	for_each_dapm_widgets(spcm->list, i, widget) {
+	for_each_dapm_widgets(sps->list, i, widget) {
 		struct snd_sof_widget *swidget = widget->dobj.private;
 
 		if (!swidget)
@@ -778,44 +807,44 @@ static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pc
 		return;
 	}
 
-	info = spcm->private;
-	info->host_copier = host_copier;
-	info->dai_copier = dai_copier;
-	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_gpdma_reading_slots) +
-				    sdev->fw_info_box.offset;
+	time_info = sof_ipc4_sps_to_time_info(sps);
+	time_info->host_copier = host_copier;
+	time_info->dai_copier = dai_copier;
+	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
+					 llp_gpdma_reading_slots) + sdev->fw_info_box.offset;
 
 	/* find llp slot used by current dai */
 	for (i = 0; i < SOF_IPC4_MAX_LLP_GPDMA_READING_SLOTS; i++) {
-		sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+		sof_mailbox_read(sdev, time_info->llp_offset, &llp_slot, sizeof(llp_slot));
 		if (llp_slot.node_id == dai_copier->data.gtw_cfg.node_id)
 			break;
 
-		info->llp_offset += sizeof(llp_slot);
+		time_info->llp_offset += sizeof(llp_slot);
 	}
 
 	if (i < SOF_IPC4_MAX_LLP_GPDMA_READING_SLOTS)
 		return;
 
 	/* if no llp gpdma slot is used, check aggregated sdw slot */
-	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_sndw_reading_slots) +
-					sdev->fw_info_box.offset;
+	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
+					 llp_sndw_reading_slots) + sdev->fw_info_box.offset;
 	for (i = 0; i < SOF_IPC4_MAX_LLP_SNDW_READING_SLOTS; i++) {
-		sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+		sof_mailbox_read(sdev, time_info->llp_offset, &llp_slot, sizeof(llp_slot));
 		if (llp_slot.node_id == dai_copier->data.gtw_cfg.node_id)
 			break;
 
-		info->llp_offset += sizeof(llp_slot);
+		time_info->llp_offset += sizeof(llp_slot);
 	}
 
 	if (i < SOF_IPC4_MAX_LLP_SNDW_READING_SLOTS)
 		return;
 
 	/* check EVAD slot */
-	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_evad_reading_slot) +
-					sdev->fw_info_box.offset;
-	sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+	time_info->llp_offset = offsetof(struct sof_ipc4_fw_registers,
+					 llp_evad_reading_slot) + sdev->fw_info_box.offset;
+	sof_mailbox_read(sdev, time_info->llp_offset, &llp_slot, sizeof(llp_slot));
 	if (llp_slot.node_id != dai_copier->data.gtw_cfg.node_id)
-		info->llp_offset = 0;
+		time_info->llp_offset = 0;
 }
 
 static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
@@ -832,7 +861,7 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
-	time_info = spcm->stream[substream->stream].private;
+	time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
 	/* delay calculation is not supported by current fw_reg ABI */
 	if (!time_info)
 		return 0;
@@ -847,7 +876,7 @@ static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
 
 static int sof_ipc4_get_stream_start_offset(struct snd_sof_dev *sdev,
 					    struct snd_pcm_substream *substream,
-					    struct snd_sof_pcm_stream *stream,
+					    struct snd_sof_pcm_stream *sps,
 					    struct sof_ipc4_timestamp_info *time_info)
 {
 	struct sof_ipc4_copier *host_copier = time_info->host_copier;
@@ -901,7 +930,7 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	struct sof_ipc4_timestamp_info *time_info;
 	struct sof_ipc4_llp_reading_slot llp;
 	snd_pcm_uframes_t head_cnt, tail_cnt;
-	struct snd_sof_pcm_stream *stream;
+	struct snd_sof_pcm_stream *sps;
 	u64 dai_cnt, host_cnt, host_ptr;
 	struct snd_sof_pcm *spcm;
 	int ret;
@@ -910,8 +939,8 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	if (!spcm)
 		return -EOPNOTSUPP;
 
-	stream = &spcm->stream[substream->stream];
-	time_info = stream->private;
+	sps = &spcm->stream[substream->stream];
+	time_info = sof_ipc4_sps_to_time_info(sps);
 	if (!time_info)
 		return -EOPNOTSUPP;
 
@@ -921,7 +950,7 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	 * the statistics is complete. And it will not change after the first initiailization.
 	 */
 	if (time_info->stream_start_offset == SOF_IPC4_INVALID_STREAM_POSITION) {
-		ret = sof_ipc4_get_stream_start_offset(sdev, substream, stream, time_info);
+		ret = sof_ipc4_get_stream_start_offset(sdev, substream, sps, time_info);
 		if (ret < 0)
 			return -EOPNOTSUPP;
 	}
@@ -1013,15 +1042,13 @@ static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sof_ipc4_timestamp_info *time_info;
-	struct snd_sof_pcm_stream *stream;
 	struct snd_sof_pcm *spcm;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 	if (!spcm)
 		return 0;
 
-	stream = &spcm->stream[substream->stream];
-	time_info = stream->private;
+	time_info = sof_ipc4_sps_to_time_info(&spcm->stream[substream->stream]);
 	/*
 	 * Report the stored delay value calculated in the pointer callback.
 	 * In the unlikely event that the calculation was skipped/aborted, the
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index f03cee94bce6..8804e00e7251 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -325,14 +325,13 @@ static int sof_pcm_trigger(struct snd_soc_component *component,
 			ipc_first = true;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (sdev->system_suspend_target == SOF_SUSPEND_S0IX &&
+		/*
+		 * If DSP D0I3 is allowed during S0iX, set the suspend_ignored flag for
+		 * D0I3-compatible streams to keep the firmware pipeline running
+		 */
+		if (pcm_ops && pcm_ops->d0i3_supported_in_s0ix &&
+		    sdev->system_suspend_target == SOF_SUSPEND_S0IX &&
 		    spcm->stream[substream->stream].d0i3_compatible) {
-			/*
-			 * trap the event, not sending trigger stop to
-			 * prevent the FW pipelines from being stopped,
-			 * and mark the flag to ignore the upcoming DAPM
-			 * PM events.
-			 */
 			spcm->stream[substream->stream].suspend_ignored = true;
 			return 0;
 		}
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 85b26e3fefa8..05e2a899d746 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -116,6 +116,7 @@ struct snd_sof_dai_config_data {
  *				  triggers. The FW keeps the host DMA running in this case and
  *				  therefore the host must do the same and should stop the DMA during
  *				  hw_free.
+ * @d0i3_supported_in_s0ix: Allow DSP D0I3 during S0iX
  */
 struct sof_ipc_pcm_ops {
 	int (*hw_params)(struct snd_soc_component *component, struct snd_pcm_substream *substream,
@@ -135,6 +136,7 @@ struct sof_ipc_pcm_ops {
 	bool reset_hw_params_during_stop;
 	bool ipc_first_on_start;
 	bool platform_stop_during_hw_free;
+	bool d0i3_supported_in_s0ix;
 };
 
 /**
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 5168ee0360b2..d1ccd06c5312 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
@@ -698,10 +698,10 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66),(ev)
-51: vpdpbusds Vx,Hx,Wx (66),(ev)
-52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
-53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+50: vpdpbusd Vx,Hx,Wx (66)
+51: vpdpbusds Vx,Hx,Wx (66)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
 55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..958e92acca8e 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -244,29 +244,101 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
 	return fd;
 }
 
-int mount_bpffs_for_pin(const char *name, bool is_dir)
+int create_and_mount_bpffs_dir(const char *dir_name)
 {
 	char err_str[ERR_MAX_LEN];
-	char *file;
-	char *dir;
+	bool dir_exists;
 	int err = 0;
 
-	if (is_dir && is_bpffs(name))
+	if (is_bpffs(dir_name))
 		return err;
 
-	file = malloc(strlen(name) + 1);
-	if (!file) {
+	dir_exists = access(dir_name, F_OK) == 0;
+
+	if (!dir_exists) {
+		char *temp_name;
+		char *parent_name;
+
+		temp_name = strdup(dir_name);
+		if (!temp_name) {
+			p_err("mem alloc failed");
+			return -1;
+		}
+
+		parent_name = dirname(temp_name);
+
+		if (is_bpffs(parent_name)) {
+			/* nothing to do if already mounted */
+			free(temp_name);
+			return err;
+		}
+
+		if (access(parent_name, F_OK) == -1) {
+			p_err("can't create dir '%s' to pin BPF object: parent dir '%s' doesn't exist",
+			      dir_name, parent_name);
+			free(temp_name);
+			return -1;
+		}
+
+		free(temp_name);
+	}
+
+	if (block_mount) {
+		p_err("no BPF file system found, not mounting it due to --nomount option");
+		return -1;
+	}
+
+	if (!dir_exists) {
+		err = mkdir(dir_name, S_IRWXU);
+		if (err) {
+			p_err("failed to create dir '%s': %s", dir_name, strerror(errno));
+			return err;
+		}
+	}
+
+	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
+	if (err) {
+		err_str[ERR_MAX_LEN - 1] = '\0';
+		p_err("can't mount BPF file system on given dir '%s': %s",
+		      dir_name, err_str);
+
+		if (!dir_exists)
+			rmdir(dir_name);
+	}
+
+	return err;
+}
+
+int mount_bpffs_for_file(const char *file_name)
+{
+	char err_str[ERR_MAX_LEN];
+	char *temp_name;
+	char *dir;
+	int err = 0;
+
+	if (access(file_name, F_OK) != -1) {
+		p_err("can't pin BPF object: path '%s' already exists", file_name);
+		return -1;
+	}
+
+	temp_name = strdup(file_name);
+	if (!temp_name) {
 		p_err("mem alloc failed");
 		return -1;
 	}
 
-	strcpy(file, name);
-	dir = dirname(file);
+	dir = dirname(temp_name);
 
 	if (is_bpffs(dir))
 		/* nothing to do if already mounted */
 		goto out_free;
 
+	if (access(dir, F_OK) == -1) {
+		p_err("can't pin BPF object: dir '%s' doesn't exist", dir);
+		err = -1;
+		goto out_free;
+	}
+
 	if (block_mount) {
 		p_err("no BPF file system found, not mounting it due to --nomount option");
 		err = -1;
@@ -276,12 +348,12 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
 	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
 	if (err) {
 		err_str[ERR_MAX_LEN - 1] = '\0';
-		p_err("can't mount BPF file system to pin the object (%s): %s",
-		      name, err_str);
+		p_err("can't mount BPF file system to pin the object '%s': %s",
+		      file_name, err_str);
 	}
 
 out_free:
-	free(file);
+	free(temp_name);
 	return err;
 }
 
@@ -289,7 +361,7 @@ int do_pin_fd(int fd, const char *name)
 {
 	int err;
 
-	err = mount_bpffs_for_pin(name, false);
+	err = mount_bpffs_for_file(name);
 	if (err)
 		return err;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 6b0e5202ca7a..5c39c2ed36a2 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
 		goto close_obj;
 	}
 
-	err = mount_bpffs_for_pin(path, false);
+	err = mount_bpffs_for_file(path);
 	if (err)
 		goto close_link;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b8bb08d10dec..9eb764fe4cc8 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -142,7 +142,8 @@ const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(const char *path, bool quiet);
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
-int mount_bpffs_for_pin(const char *name, bool is_dir);
+int mount_bpffs_for_file(const char *file_name);
+int create_and_mount_bpffs_dir(const char *dir_name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9cb42a3366c0..4c4cf16a40ba 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1778,7 +1778,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
+	if (first_prog_only)
+		err = mount_bpffs_for_file(pinfile);
+	else
+		err = create_and_mount_bpffs_dir(pinfile);
 	if (err)
 		goto err_close_obj;
 
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 26004f0c5a6a..7bdbcac3cf62 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -102,8 +102,8 @@ int iter(struct bpf_iter__task_file *ctx)
 				       BPF_LINK_TYPE_PERF_EVENT___local)) {
 		struct bpf_link *link = (struct bpf_link *) file->private_data;
 
-		if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
-						      BPF_LINK_TYPE_PERF_EVENT___local)) {
+		if (BPF_CORE_READ(link, type) == bpf_core_enum_value(enum bpf_link_type___local,
+								     BPF_LINK_TYPE_PERF_EVENT___local)) {
 			e.has_bpf_cookie = true;
 			e.bpf_cookie = get_bpf_cookie(link);
 		}
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index d573f2640d8e..aa43dead249c 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -515,7 +515,7 @@ static int do_register(int argc, char **argv)
 	if (argc == 1)
 		linkdir = GET_ARG();
 
-	if (linkdir && mount_bpffs_for_pin(linkdir, true)) {
+	if (linkdir && create_and_mount_bpffs_dir(linkdir)) {
 		p_err("can't mount bpffs for pinning");
 		return -1;
 	}
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index bacfd35c5156..5be9d3c7435a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -185,7 +185,7 @@ void *realloc(void *old_ptr, size_t new_size)
 	if (__builtin_expect(!ret, 0))
 		return NULL;
 
-	memcpy(ret, heap->user_p, heap->len);
+	memcpy(ret, heap->user_p, user_p_len);
 	munmap(heap, heap->len);
 	return ret;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..a12f597a1c47 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7039,7 +7039,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 92bca96587a4..028d8f014c87 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7456,9 +7456,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL, *tmp;
-	int btf_fd, ret, err;
 	bool own_log_buf = true;
 	__u32 log_level = prog->log_level;
+	int ret, err;
 
 	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
 		/*
@@ -7482,9 +7482,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.prog_ifindex = prog->prog_ifindex;
 
 	/* specify func_info/line_info only if kernel supports them */
-	btf_fd = btf__fd(obj->btf);
-	if (btf_fd >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
-		load_attr.prog_btf_fd = btf_fd;
+	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
+		load_attr.prog_btf_fd = btf__fd(obj->btf);
 		load_attr.func_info = prog->func_info;
 		load_attr.func_info_rec_size = prog->func_info_rec_size;
 		load_attr.func_info_cnt = prog->func_info_cnt;
@@ -11562,7 +11561,7 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 
 	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
 	if (n < 1) {
-		pr_warn("kprobe multi pattern is invalid: %s\n", pattern);
+		pr_warn("kprobe multi pattern is invalid: %s\n", spec);
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 19be9c63d5e8..e812876d79c7 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -508,6 +508,9 @@ int cgroup_setup_and_join(const char *path) {
 /**
  * setup_classid_environment() - Setup the cgroupv1 net_cls environment
  *
+ * This function should only be called in a custom mount namespace, e.g.
+ * created by running setup_cgroup_environment.
+ *
  * After calling this function, cleanup_classid_environment should be called
  * once testing is complete.
  *
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db27a9088e9..be96bf022316 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -461,6 +461,8 @@ struct nstoken *open_netns(const char *name)
 
 	return token;
 fail:
+	if (token->orig_netns_fd != -1)
+		close(token->orig_netns_fd);
 	free(token);
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
index 74d6d7546f40..25332e596750 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
@@ -87,9 +87,12 @@ void test_cgroup1_hierarchy(void)
 		goto destroy;
 
 	/* Setup cgroup1 hierarchy */
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto destroy;
 	err = setup_classid_environment();
 	if (!ASSERT_OK(err, "setup_classid_environment"))
-		goto destroy;
+		goto cleanup_cgroup;
 
 	err = join_classid();
 	if (!ASSERT_OK(err, "join_cgroup1"))
@@ -153,6 +156,8 @@ void test_cgroup1_hierarchy(void)
 
 cleanup:
 	cleanup_classid_environment();
+cleanup_cgroup:
+	cleanup_cgroup_environment();
 destroy:
 	test_cgroup1_hierarchy__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 498d3bdaa4b0..bad0ea167be7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -107,8 +107,8 @@ void test_xdp_do_redirect(void)
 			    .attach_point = BPF_TC_INGRESS);
 
 	memcpy(&data[sizeof(__u64)], &pkt_udp, sizeof(pkt_udp));
-	*((__u32 *)data) = 0x42; /* metadata test value */
-	*((__u32 *)data + 4) = 0;
+	((__u32 *)data)[0] = 0x42; /* metadata test value */
+	((__u32 *)data)[1] = 0;
 
 	skel = test_xdp_do_redirect__open();
 	if (!ASSERT_OK_PTR(skel, "skel"))
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index e4bfbba6c193..c8ec0d0368e4 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -61,14 +61,15 @@ SEC("lsm.s/socket_post_create")
 int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
+	struct sock *sk = sock->sk;
 	struct storage *stg;
 	__u32 pid;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
-	if (pid != bench_pid)
+	if (pid != bench_pid || !sk)
 		return 0;
 
-	stg = bpf_sk_storage_get(&sk_storage_map, sock->sk, NULL,
+	stg = bpf_sk_storage_get(&sk_storage_map, sk, NULL,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 
 	if (stg)
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index e5e3a8b8dd07..637e75df2e14 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -140,11 +140,12 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
+	struct sock *sk = sock->sk;
 
-	if (pid != monitored_pid)
+	if (pid != monitored_pid || !sk)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0, 0);
+	storage = bpf_sk_storage_get(&sk_storage_map, sk, 0, 0);
 	if (!storage)
 		return 0;
 
@@ -155,24 +156,24 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	/* This tests that we can associate multiple elements
 	 * with the local storage.
 	 */
-	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (bpf_sk_storage_delete(&sk_storage_map2, sock->sk))
+	if (bpf_sk_storage_delete(&sk_storage_map2, sk))
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (bpf_sk_storage_delete(&sk_storage_map, sock->sk))
+	if (bpf_sk_storage_delete(&sk_storage_map, sk))
 		return 0;
 
 	/* Ensure that the sk_storage_map is disconnected from the storage. */
-	if (!sock->sk->sk_bpf_storage || sock->sk->sk_bpf_storage->smap)
+	if (!sk->sk_bpf_storage || sk->sk_bpf_storage->smap)
 		return 0;
 
 	sk_storage_result = 0;
@@ -185,11 +186,12 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
+	struct sock *sk = sock->sk;
 
-	if (pid != monitored_pid)
+	if (pid != monitored_pid || !sk)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index 02c11d16b692..d7598538aa2d 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -103,11 +103,15 @@ static __always_inline int real_bind(struct socket *sock,
 				     int addrlen)
 {
 	struct sockaddr_ll sa = {};
+	struct sock *sk = sock->sk;
 
-	if (sock->sk->__sk_common.skc_family != AF_PACKET)
+	if (!sk)
+		return 1;
+
+	if (sk->__sk_common.skc_family != AF_PACKET)
 		return 1;
 
-	if (sock->sk->sk_kern_sock)
+	if (sk->sk_kern_sock)
 		return 1;
 
 	bpf_probe_read_kernel(&sa, sizeof(sa), address);
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..43612de44fbf 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2104,9 +2104,9 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
+	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	close(cg_fd);
 	return err;
 }
 
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 0340d4ca8f51..432db923bced 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -195,10 +195,10 @@ int cg_write_numeric(const char *cgroup, const char *control, long value)
 	return cg_write(cgroup, control, buf);
 }
 
-int cg_find_unified_root(char *root, size_t len)
+int cg_find_unified_root(char *root, size_t len, bool *nsdelegate)
 {
 	char buf[10 * PAGE_SIZE];
-	char *fs, *mount, *type;
+	char *fs, *mount, *type, *options;
 	const char delim[] = "\n\t ";
 
 	if (read_text("/proc/self/mounts", buf, sizeof(buf)) <= 0)
@@ -211,12 +211,14 @@ int cg_find_unified_root(char *root, size_t len)
 	for (fs = strtok(buf, delim); fs; fs = strtok(NULL, delim)) {
 		mount = strtok(NULL, delim);
 		type = strtok(NULL, delim);
-		strtok(NULL, delim);
+		options = strtok(NULL, delim);
 		strtok(NULL, delim);
 		strtok(NULL, delim);
 
 		if (strcmp(type, "cgroup2") == 0) {
 			strncpy(root, mount, len);
+			if (nsdelegate)
+				*nsdelegate = !!strstr(options, "nsdelegate");
 			return 0;
 		}
 	}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 1df7f202214a..89e8519fb271 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -21,7 +21,7 @@ static inline int values_close(long a, long b, int err)
 	return abs(a - b) <= (a + b) / 100 * err;
 }
 
-extern int cg_find_unified_root(char *root, size_t len);
+extern int cg_find_unified_root(char *root, size_t len, bool *nsdelegate);
 extern char *cg_name(const char *root, const char *name);
 extern char *cg_name_indexed(const char *root, const char *name, int index);
 extern char *cg_control(const char *cgroup, const char *control);
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 80aa6b2373b9..a5672a91d273 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -18,6 +18,8 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+static bool nsdelegate;
+
 static int touch_anon(char *buf, size_t size)
 {
 	int fd;
@@ -775,6 +777,9 @@ static int test_cgcore_lesser_ns_open(const char *root)
 	pid_t pid;
 	int status;
 
+	if (!nsdelegate)
+		return KSFT_SKIP;
+
 	cg_test_a = cg_name(root, "cg_test_a");
 	cg_test_b = cg_name(root, "cg_test_b");
 
@@ -862,7 +867,7 @@ int main(int argc, char *argv[])
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), &nsdelegate))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 24020a2c68dc..186bf96f6a28 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -700,7 +700,7 @@ int main(int argc, char *argv[])
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	if (cg_read_strstr(root, "cgroup.subtree_control", "cpu"))
diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index b061ed1e05b4..4034d14ba69a 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -249,7 +249,7 @@ int main(int argc, char *argv[])
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	if (cg_read_strstr(root, "cgroup.subtree_control", "cpuset"))
diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 8845353aca53..8730645d363a 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -827,7 +827,7 @@ int main(int argc, char *argv[])
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index f0fefeb4cc24..856f9508ea56 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -214,7 +214,7 @@ int main(int argc, char **argv)
 		return ret;
 	}
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	switch (test_hugetlb_memcg(root)) {
diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
index 6153690319c9..0e5bb6c7307a 100644
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -276,7 +276,7 @@ int main(int argc, char *argv[])
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index c82f974b85c9..137506db0312 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -420,7 +420,7 @@ int main(int argc, char **argv)
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	/*
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c7c9572003a8..b462416b3806 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1314,7 +1314,7 @@ int main(int argc, char **argv)
 	char root[PATH_MAX];
 	int i, proc_status, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	/*
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 47fdaa146443..e1169d3e620f 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -324,7 +324,7 @@ int main(int argc, char **argv)
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root)))
+	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
 	if (!zswap_configured())
diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index e98cf4b6a4b7..f9fead3d0f01 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -241,6 +241,8 @@ class DamonCtx:
         nr_schemes_file = os.path.join(
                 self.sysfs_dir(), 'schemes', 'nr_schemes')
         content, err = read_file(nr_schemes_file)
+        if err is not None:
+            return err
         if int(content) != len(self.schemes):
             err = write_file(nr_schemes_file, '%d' % len(self.schemes))
             if err != None:
diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index c2f7cef919c0..eb4c3b411934 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,4 @@
 CFLAGS += $(KHDR_INCLUDES) -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
-
 include ../../lib.mk
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index b9c21a81d248..c0cdad4c400e 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -53,7 +53,7 @@ fi
 
 echo > dynamic_events
 
-if [ "$FIELDS" ] ; then
+if [ "$FIELDS" -a "$FPROBES" ] ; then
 echo "t:tpevent ${TP2} obj_size=s->object_size" >> dynamic_events
 echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
 echo "t:tpevent2 ${TP4} p->se.group_node.next->prev" >> dynamic_events
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 25110c7c0b3e..d7a8e321bb16 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 		ksft_print_header();
 		ksft_set_plan(3);
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index eef816b80993..ca917c71ff60 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -84,6 +84,18 @@ static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type,
 	return v;
 }
 
+static struct vm_gic vm_gic_create_barebones(uint32_t gic_dev_type)
+{
+	struct vm_gic v;
+
+	v.gic_dev_type = gic_dev_type;
+	v.vm = vm_create_barebones();
+	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
+
+	return v;
+}
+
+
 static void vm_gic_destroy(struct vm_gic *v)
 {
 	close(v->gic_fd);
@@ -357,6 +369,40 @@ static void test_vcpus_then_vgic(uint32_t gic_dev_type)
 	vm_gic_destroy(&v);
 }
 
+#define KVM_VGIC_V2_ATTR(offset, cpu) \
+	(FIELD_PREP(KVM_DEV_ARM_VGIC_OFFSET_MASK, offset) | \
+	 FIELD_PREP(KVM_DEV_ARM_VGIC_CPUID_MASK, cpu))
+
+#define GIC_CPU_CTRL	0x00
+
+static void test_v2_uaccess_cpuif_no_vcpus(void)
+{
+	struct vm_gic v;
+	u64 val = 0;
+	int ret;
+
+	v = vm_gic_create_barebones(KVM_DEV_TYPE_ARM_VGIC_V2);
+	subtest_dist_rdist(&v);
+
+	ret = __kvm_has_device_attr(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0));
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+	ret = __kvm_device_attr_get(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0), &val);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+	ret = __kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0), &val);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+
+	vm_gic_destroy(&v);
+}
+
 static void test_v3_new_redist_regions(void)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
@@ -675,6 +721,9 @@ void run_tests(uint32_t gic_dev_type)
 	test_vcpus_then_vgic(gic_dev_type);
 	test_vgic_then_vcpus(gic_dev_type);
 
+	if (VGIC_DEV_IS_V2(gic_dev_type))
+		test_v2_uaccess_cpuif_no_vcpus();
+
 	if (VGIC_DEV_IS_V3(gic_dev_type)) {
 		test_v3_new_redist_regions();
 		test_v3_typer_accesses();
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index aa646e0661f3..a8f0442a36bc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -7,6 +7,8 @@ else ifneq ($(filter -%,$(LLVM)),)
 LLVM_SUFFIX := $(LLVM)
 endif
 
+CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+
 CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
 CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
 CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
@@ -18,7 +20,13 @@ CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
 CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
-CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+# Default to host architecture if ARCH is not explicitly given.
+ifeq ($(ARCH),)
+CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
+else
+CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
+endif
 
 ifeq ($(CROSS_COMPILE),)
 ifeq ($(CLANG_TARGET_FLAGS),)
@@ -30,7 +38,7 @@ else
 CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif # CROSS_COMPILE
 
-CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
 else
 CC := $(CROSS_COMPILE)gcc
 endif # LLVM
diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 75528788cb95..5175a42cbe8a 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -210,8 +210,8 @@ check_features()
 
 test_ipv4_forward()
 {
-	RESULT4=$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
-	if [ "$RESULT4" == "172.17.0.2" ]; then
+	RESULT4=$(ip netns exec "${LISTENER}" timeout 15 socat - UDP4-LISTEN:4000,readbytes=128 || true)
+	if echo "$RESULT4" | grep -q "172.17.0.2"; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
 		exit 0
 	else
@@ -222,8 +222,8 @@ test_ipv4_forward()
 
 test_ipv6_forward()
 {
-	RESULT6=$(ip netns exec "${LISTENER}" nc -w 1 -l -u ff0e::5:6 6000)
-	if [ "$RESULT6" == "2001:db8:3::2" ]; then
+	RESULT6=$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-LISTEN:6000,readbytes=128 || true)
+	if echo "$RESULT6" | grep -q "2001:db8:3::2"; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv6 amt multicast forwarding"
 		exit 0
 	else
@@ -236,14 +236,14 @@ send_mcast4()
 {
 	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
-		'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
+		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
 	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
-		'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
+		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }
 
 check_features
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5e4390cac17e..04de7a6ba6f3 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -30,6 +30,7 @@ CONFIG_IP_GRE=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
+CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_SIT=y
 CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 2aa66d2a1702..e6a3e04fd83f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -478,10 +478,10 @@ v3exc_timeout_test()
 	RET=0
 	local X=("192.0.2.20" "192.0.2.30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ v3exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index e2b9ff773c6b..f84ab2e65754 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -478,10 +478,10 @@ mldv2exc_timeout_test()
 	RET=0
 	local X=("2001:db8:1::20" "2001:db8:1::30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	mldv2exclude_prepare $h1
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ mldv2exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index f9fe182dfbd4..56a9454b7ba3 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -73,15 +73,17 @@ setup_ns()
 	local ns=""
 	local ns_name=""
 	local ns_list=""
+	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
 		if unset ${ns_name} 2> /dev/null; then
 			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
 			eval readonly ${ns_name}="$ns"
+			ns_exist=false
 		else
 			eval ns='$'${ns_name}
 			cleanup_ns "$ns"
-
+			ns_exist=true
 		fi
 
 		if ! ip netns add "$ns"; then
@@ -90,7 +92,7 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		ns_list="$ns_list $ns"
+		! $ns_exist && ns_list="$ns_list $ns"
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 2deac2031de9..021863f86053 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -5,6 +5,8 @@ CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
 
+LOCAL_HDRS += $(wildcard *.h)
+
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.[ch])
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e..d975a6767329 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 
 	/* In preparation for sigreturn. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	/*
+	 * The tests for argument handling assume that `syscall(x) == x`. This
+	 * is a NOP on x86 because the syscall number is passed in %rax, which
+	 * happens to also be the function ABI return register.  Other
+	 * architectures may need to swizzle the arguments around.
+	 */
+#if defined(__riscv)
+/* REG_A7 is not defined in libc headers */
+# define REG_A7 (REG_A0 + 7)
+
+	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
+			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
+#endif
 }
 
 TEST(dispatch_and_return)
diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 0fd9c747d396..cf263fe9deaf 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -935,12 +935,12 @@ static void show_available(void)
 	}
 
 	if (!tracers) {
-		warnx(no_tracer_msg);
+		warnx("%s", no_tracer_msg);
 		return;
 	}
 
 	if (!found) {
-		warnx(no_latency_tr_msg);
+		warnx("%s", no_latency_tr_msg);
 		tracefs_list_free(tracers);
 		return;
 	}
@@ -983,7 +983,7 @@ static const char *find_default_tracer(void)
 	for (i = 0; relevant_tracers[i]; i++) {
 		valid = tracer_valid(relevant_tracers[i], &notracer);
 		if (notracer)
-			errx(EXIT_FAILURE, no_tracer_msg);
+			errx(EXIT_FAILURE, "%s", no_tracer_msg);
 		if (valid)
 			return relevant_tracers[i];
 	}
@@ -1878,7 +1878,7 @@ static void scan_arguments(int argc, char *argv[])
 			}
 			valid = tracer_valid(current_tracer, &notracer);
 			if (notracer)
-				errx(EXIT_FAILURE, no_tracer_msg);
+				errx(EXIT_FAILURE, "%s", no_tracer_msg);
 			if (!valid)
 				errx(EXIT_FAILURE,
 "The tracer %s is not supported by your kernel!\n", current_tracer);

