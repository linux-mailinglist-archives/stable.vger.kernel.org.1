Return-Path: <stable+bounces-139435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934DCAA6A6C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E511893859
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5BB1DE4E6;
	Fri,  2 May 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBn2i5wB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F461E1E1B;
	Fri,  2 May 2025 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166038; cv=none; b=s+Rn7xjBpAZ8Nmw3D0HMaKABhNOdMdsBeKkjhzAvwP3ylPnCwjjxemTs1GflvP9k46ywbwE1qGJj6P1dDbikeTqlySOkGLCCkotXAdaWvOca5SFi+tp+vOuHrA0+eaWgF14ItZJsnnjvUlp3vVQ0NLpcp29oUv+9vrrF9GaFQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166038; c=relaxed/simple;
	bh=wtFo/6pVSJqxVYhAw1fIc+G2AyQCIV7Tlciqlv86cBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fv+MsKQOoid5BZiibcTtNIDnX5M7syvQ8hacCtMQcIwMq8ToZl2JjnszL9Md71nfrSj6k89bCBX5QJTB7wyNSJ8eQIwQRxu2r41qHWNOB/bPPD7czWWwHkMy5AR/ODJVpMjm9xmoorwDLdb9dHoDCasjyOGVTFNAQsy+YG4skPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBn2i5wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A704C4CEE4;
	Fri,  2 May 2025 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166037;
	bh=wtFo/6pVSJqxVYhAw1fIc+G2AyQCIV7Tlciqlv86cBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBn2i5wBGbn9QiBdT/eurhWJ/KU/dAJTeJToGgFrn19Uu6ZfpYPu68O4S4zgxnlv9
	 1IeGfmLAHzkyT3M7Tl5e+FoTnxSN8Z4IPR4YfcmjtmbeQ3MJdquoN2CSXlUsFyQ1cA
	 dLdL/zpFFuRj2TsK3KLUg6Ce3BEhoHufZAxDQZ3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.237
Date: Fri,  2 May 2025 08:07:04 +0200
Message-ID: <2025050204-gluten-refocus-cf9b@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050204-edging-exclaim-56c3@gregkh>
References: <2025050204-edging-exclaim-56c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index e13f8f8a9ea9..b0e2f455eb87 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 236
+SUBLEVEL = 237
 EXTRAVERSION =
 NAME = Dare mighty things
 
@@ -976,6 +976,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b5df98ee5d17..4b554cc8fa58 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,7 +13,6 @@ menuconfig ARCH_EXYNOS
 	select ARM_GIC
 	select EXYNOS_IRQ_COMBINER
 	select COMMON_CLK_SAMSUNG
-	select EXYNOS_ASV
 	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 592c6bc10dd1..b4268950db18 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1193,8 +1193,7 @@ dpi0_out: endpoint {
 		};
 
 		pwm0: pwm@1401e000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401e000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
@@ -1204,8 +1203,7 @@ pwm0: pwm@1401e000 {
 		};
 
 		pwm1: pwm@1401f000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401f000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d8305b4657d2..423bc03a21f2 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -74,6 +74,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
@@ -110,6 +111,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -136,6 +138,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
@@ -167,6 +170,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 90337910c3f5..45fdfe70b69f 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -874,6 +874,7 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k11_list[] = {
diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
index cc988bbd27fc..0880a5551d97 100644
--- a/arch/mips/dec/prom/init.c
+++ b/arch/mips/dec/prom/init.c
@@ -42,7 +42,7 @@ int (*__pmax_close)(int);
  * Detect which PROM the DECSTATION has, and set the callback vectors
  * appropriately.
  */
-void __init which_prom(s32 magic, s32 *prom_vec)
+static void __init which_prom(s32 magic, s32 *prom_vec)
 {
 	/*
 	 * No sign of the REX PROM's magic number means we assume a non-REX
diff --git a/arch/mips/include/asm/ds1287.h b/arch/mips/include/asm/ds1287.h
index 46cfb01f9a14..51cb61fd4c03 100644
--- a/arch/mips/include/asm/ds1287.h
+++ b/arch/mips/include/asm/ds1287.h
@@ -8,7 +8,7 @@
 #define __ASM_DS1287_H
 
 extern int ds1287_timer_state(void);
-extern void ds1287_set_base_clock(unsigned int clock);
+extern int ds1287_set_base_clock(unsigned int hz);
 extern int ds1287_clockevent_init(int irq);
 
 #endif
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 696b40beb774..8494466740cc 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -47,6 +47,16 @@ extern phys_addr_t __mips_cm_phys_base(void);
  */
 extern int mips_cm_is64;
 
+/*
+ * mips_cm_is_l2_hci_broken  - determine if HCI is broken
+ *
+ * Some CM reports show that Hardware Cache Initialization is
+ * complete, but in reality it's not the case. They also incorrectly
+ * indicate that Hardware Cache Initialization is supported. This
+ * flags allows warning about this broken feature.
+ */
+extern bool mips_cm_is_l2_hci_broken;
+
 /**
  * mips_cm_error_report - Report CM cache errors
  */
@@ -85,6 +95,18 @@ static inline bool mips_cm_present(void)
 #endif
 }
 
+/**
+ * mips_cm_update_property - update property from the device tree
+ *
+ * Retrieve the properties from the device tree if a CM node exist and
+ * update the internal variable based on this.
+ */
+#ifdef CONFIG_MIPS_CM
+extern void mips_cm_update_property(void);
+#else
+static inline void mips_cm_update_property(void) {}
+#endif
+
 /**
  * mips_cm_has_l2sync - determine whether an L2-only sync region is present
  *
diff --git a/arch/mips/kernel/cevt-ds1287.c b/arch/mips/kernel/cevt-ds1287.c
index 9a47fbcd4638..de64d6bb7ba3 100644
--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -10,6 +10,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/irq.h>
 
+#include <asm/ds1287.h>
 #include <asm/time.h>
 
 int ds1287_timer_state(void)
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 72c8374a3900..a0d9cde26dc5 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/of.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
@@ -14,6 +15,7 @@
 void __iomem *mips_gcr_base;
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+bool mips_cm_is_l2_hci_broken;
 
 static char *cm2_tr[8] = {
 	"mem",	"gcr",	"gic",	"mmio",
@@ -238,6 +240,18 @@ static void mips_cm_probe_l2sync(void)
 	mips_cm_l2sync_base = ioremap(addr, MIPS_CM_L2SYNC_SIZE);
 }
 
+void mips_cm_update_property(void)
+{
+	struct device_node *cm_node;
+
+	cm_node = of_find_compatible_node(of_root, NULL, "mobileye,eyeq6-cm");
+	if (!cm_node)
+		return;
+	pr_info("HCI (Hardware Cache Init for the L2 cache) in GCR_L2_RAM_CONFIG from the CM3 is broken");
+	mips_cm_is_l2_hci_broken = true;
+	of_node_put(cm_node);
+}
+
 int mips_cm_probe(void)
 {
 	phys_addr_t addr;
diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index fcc761b0e11b..d20e8283c5b8 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -62,6 +62,7 @@ static unsigned long pdt_entry[MAX_PDT_ENTRIES] __page_aligned_bss;
 #define PDT_ADDR_PERM_ERR	(pdt_type != PDT_PDC ? 2UL : 0UL)
 #define PDT_ADDR_SINGLE_ERR	1UL
 
+#ifdef CONFIG_PROC_FS
 /* report PDT entries via /proc/meminfo */
 void arch_report_meminfo(struct seq_file *m)
 {
@@ -73,6 +74,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "PDT_cur_entries: %7lu\n",
 			pdt_status.pdt_entries);
 }
+#endif
 
 static int get_info_pat_new(void)
 {
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 5976a25c6264..a8299981798a 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -16,6 +16,7 @@
 #include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
@@ -1173,6 +1174,9 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	    || nargs + nret > ARRAY_SIZE(args.args))
 		return -EINVAL;
 
+	nargs = array_index_nospec(nargs, ARRAY_SIZE(args.args));
+	nret = array_index_nospec(nret, ARRAY_SIZE(args.args) - nargs);
+
 	/* Copy in args. */
 	if (copy_from_user(args.args, uargs->args,
 			   nargs * sizeof(rtas_arg_t)) != 0)
diff --git a/arch/riscv/include/asm/kgdb.h b/arch/riscv/include/asm/kgdb.h
index 46677daf708b..cc11c4544cff 100644
--- a/arch/riscv/include/asm/kgdb.h
+++ b/arch/riscv/include/asm/kgdb.h
@@ -19,16 +19,9 @@
 
 #ifndef	__ASSEMBLY__
 
+void arch_kgdb_breakpoint(void);
 extern unsigned long kgdb_compiled_break;
 
-static inline void arch_kgdb_breakpoint(void)
-{
-	asm(".global kgdb_compiled_break\n"
-	    ".option norvc\n"
-	    "kgdb_compiled_break: ebreak\n"
-	    ".option rvc\n");
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #define DBG_REG_ZERO "zero"
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 49350c8bd7b0..9fa0729bc669 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -60,8 +60,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 	args[0] = regs->orig_a0;
-	args++;
-	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
+	args[1] = regs->a1;
+	args[2] = regs->a2;
+	args[3] = regs->a3;
+	args[4] = regs->a4;
+	args[5] = regs->a5;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 963ed7edcff2..1d83b3696721 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -273,6 +273,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	regs->epc = pc;
 }
 
+noinline void arch_kgdb_breakpoint(void)
+{
+	asm(".global kgdb_compiled_break\n"
+	    "kgdb_compiled_break: ebreak\n");
+}
+
 void kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 				char *remcom_out_buffer)
 {
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 6f0209d45164..9c5f546a2e1a 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -56,7 +56,7 @@ TRACE_EVENT(kvm_s390_create_vcpu,
 		    __entry->sie_block = sie_block;
 		    ),
 
-	    TP_printk("create cpu %d at 0x%pK, sie block at 0x%pK",
+	    TP_printk("create cpu %d at 0x%p, sie block at 0x%p",
 		      __entry->id, __entry->vcpu, __entry->sie_block)
 	);
 
@@ -255,7 +255,7 @@ TRACE_EVENT(kvm_s390_enable_css,
 		    __entry->kvm = kvm;
 		    ),
 
-	    TP_printk("enabling channel I/O support (kvm @ %pK)\n",
+	    TP_printk("enabling channel I/O support (kvm @ %p)\n",
 		      __entry->kvm)
 	);
 
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 20ee14739333..c7d396a2703f 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -51,8 +51,10 @@ void flush_tlb_pending(void)
 
 void arch_enter_lazy_mmu_mode(void)
 {
-	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
+	struct tlb_batch *tb;
 
+	preempt_disable();
+	tb = this_cpu_ptr(&tlb_batch);
 	tb->active = 1;
 }
 
@@ -63,6 +65,7 @@ void arch_leave_lazy_mmu_mode(void)
 	if (tb->tlb_nr)
 		flush_tlb_pending();
 	tb->active = 0;
+	preempt_enable();
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index f4419afc7147..bda217961172 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -16,7 +16,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 48f30ffef1f4..ed34e38e206b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -988,8 +988,10 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
-	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
-	       (attr->sample_regs_intr & PEBS_GP_REGS);
+	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		(attr->sample_regs_user & PEBS_GP_REGS));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -1572,7 +1574,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ad084a5a1463..f95da6fee787 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4487,28 +4487,28 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
 	/* Free-Running IIO BANDWIDTH IN Counters */
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
@@ -5013,37 +5013,6 @@ static struct freerunning_counters icx_iio_freerunning[] = {
 	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
 };
 
-static struct uncore_event_desc icx_uncore_iio_freerunning_events[] = {
-	/* Free-Running IIO CLOCKS Counter */
-	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
-	/* Free-Running IIO BANDWIDTH IN Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
-	{ /* end: all zeroes */ },
-};
-
 static struct intel_uncore_type icx_uncore_iio_free_running = {
 	.name			= "iio_free_running",
 	.num_counters		= 9,
@@ -5051,7 +5020,7 @@ static struct intel_uncore_type icx_uncore_iio_free_running = {
 	.num_freerunning_types	= ICX_IIO_FREERUNNING_TYPE_MAX,
 	.freerunning		= icx_iio_freerunning,
 	.ops			= &skx_uncore_iio_freerunning_ops,
-	.event_descs		= icx_uncore_iio_freerunning_events,
+	.event_descs		= snr_uncore_iio_freerunning_events,
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c10f7dcaa7b7..5f0bdb53b006 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -839,7 +839,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 * (model = 0x14) and later actually support it.
 	 * (AMD Erratum #110, docId: 25759).
 	 */
-	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
+	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 725f827718a7..045ab6d0a98b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1543,20 +1543,20 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	case SPECTRE_V2_NONE:
 		return;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
+	case SPECTRE_V2_EIBRS_LFENCE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
 		return;
 
-	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
-		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		return;
 	}
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7f57110f958e..bebaeb9ef83e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -753,22 +753,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
 	int i;
-	unsigned long pfn = 0;
+	u64 last_addr = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 
-		if (pfn < PFN_UP(entry->addr))
-			register_nosave_region(pfn, PFN_UP(entry->addr));
-
-		pfn = PFN_DOWN(entry->addr + entry->size);
-
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
-			register_nosave_region(PFN_UP(entry->addr), pfn);
+			continue;
 
-		if (pfn >= limit_pfn)
-			break;
+		if (last_addr < entry->addr)
+			register_nosave_region(PFN_DOWN(last_addr), PFN_UP(entry->addr));
+
+		last_addr = entry->addr + entry->size;
 	}
+
+	register_nosave_region(PFN_DOWN(last_addr), limit_pfn);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3e5cb74c0b53..63dbf67d107b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -742,7 +742,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * Allocating new amd_iommu_pi_data, which will get
 	 * add to the per-vcpu ir_list.
 	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_KERNEL_ACCOUNT);
+	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ir) {
 		ret = -ENOMEM;
 		goto out;
@@ -806,6 +806,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	int idx, ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) ||
@@ -843,6 +844,8 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 		    kvm_vcpu_apicv_active(&svm->vcpu)) {
 			struct amd_iommu_pi_data pi;
 
+			enable_remapped_mode = false;
+
 			/* Try to enable guest_mode in IRTE */
 			pi.base = __sme_set(page_to_phys(svm->avic_backing_page) &
 					    AVIC_HPA_MASK);
@@ -861,33 +864,6 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 			 */
 			if (!ret && pi.is_guest_mode)
 				svm_ir_list_add(svm, &pi);
-		} else {
-			/* Use legacy mode in IRTE */
-			struct amd_iommu_pi_data pi;
-
-			/**
-			 * Here, pi is used to:
-			 * - Tell IOMMU to use legacy mode for this interrupt.
-			 * - Retrieve ga_tag of prior interrupt remapping data.
-			 */
-			pi.prev_ga_tag = 0;
-			pi.is_guest_mode = false;
-			ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-			/**
-			 * Check if the posted interrupt was previously
-			 * setup with the guest_mode by checking if the ga_tag
-			 * was cached. If so, we need to clean up the per-vcpu
-			 * ir_list.
-			 */
-			if (!ret && pi.prev_ga_tag) {
-				int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
-				struct kvm_vcpu *vcpu;
-
-				vcpu = kvm_get_vcpu_by_id(kvm, id);
-				if (vcpu)
-					svm_ir_list_del(to_svm(vcpu), &pi);
-			}
 		}
 
 		if (!ret && svm) {
@@ -903,6 +879,34 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 	}
 
 	ret = 0;
+	if (enable_remapped_mode) {
+		/* Use legacy mode in IRTE */
+		struct amd_iommu_pi_data pi;
+
+		/**
+		 * Here, pi is used to:
+		 * - Tell IOMMU to use legacy mode for this interrupt.
+		 * - Retrieve ga_tag of prior interrupt remapping data.
+		 */
+		pi.prev_ga_tag = 0;
+		pi.is_guest_mode = false;
+		ret = irq_set_vcpu_affinity(host_irq, &pi);
+
+		/**
+		 * Check if the posted interrupt was previously
+		 * setup with the guest_mode by checking if the ga_tag
+		 * was cached. If so, we need to clean up the per-vcpu
+		 * ir_list.
+		 */
+		if (!ret && pi.prev_ga_tag) {
+			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
+			struct kvm_vcpu *vcpu;
+
+			vcpu = kvm_get_vcpu_by_id(kvm, id);
+			if (vcpu)
+				svm_ir_list_del(to_svm(vcpu), &pi);
+		}
+	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5f8acd2faa7c..e4c3da27524c 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -255,6 +255,7 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
@@ -293,21 +294,8 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 
 		kvm_set_msi_irq(kvm, e, &irq);
 		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
-		    !kvm_irq_is_postable(&irq)) {
-			/*
-			 * Make sure the IRTE is in remapped mode if
-			 * we don't handle it in posted mode.
-			 */
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
-			if (ret < 0) {
-				printk(KERN_INFO
-				   "failed to back to remapped mode, irq: %u\n",
-				   host_irq);
-				goto out;
-			}
-
+		    !kvm_irq_is_postable(&irq))
 			continue;
-		}
 
 		vcpu_info.pi_desc_addr = __pa(&to_vmx(vcpu)->pi_desc);
 		vcpu_info.vector = irq.vector;
@@ -315,11 +303,12 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
 				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
 
-		if (set)
-			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		else
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
+		if (!set)
+			continue;
+
+		enable_remapped_mode = false;
 
+		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 		if (ret < 0) {
 			printk(KERN_INFO "%s: failed to update PI IRTE\n",
 					__func__);
@@ -327,6 +316,9 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 		}
 	}
 
+	if (enable_remapped_mode)
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
+
 	ret = 0;
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index b0490701da2a..bfd4e63a90cb 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -99,7 +99,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	call xen_prepare_pvh
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	subq phys_base(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
 
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 13a17ad646e0..dbd18b75ec91 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -191,6 +191,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
+		pd->online = false;
 	}
 
 	return blkg;
@@ -288,8 +289,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
+			if (blkg->pd[i]) {
+				if (pol->pd_online_fn)
+					pol->pd_online_fn(blkg->pd[i]);
+				blkg->pd[i]->online = true;
+			}
 		}
 	}
 	blkg->online = true;
@@ -389,8 +393,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
+		if (blkg->pd[i] && blkg->pd[i]->online) {
+			if (pol->pd_offline_fn)
+				pol->pd_offline_fn(blkg->pd[i]);
+			blkg->pd[i]->online = false;
+		}
 	}
 
 	blkg->online = false;
@@ -1364,6 +1371,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 	}
 
 	/* all allocated, init in the same order */
@@ -1371,9 +1379,11 @@ int blkcg_activate_policy(struct request_queue *q,
 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	if (pol->pd_online_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
+		blkg->pd[pol->plid]->online = true;
+	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
@@ -1435,7 +1445,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 		spin_lock(&blkcg->lock);
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 20b51868cf5a..6e895fa90602 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1389,8 +1389,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	lockdep_assert_held(&iocg->ioc->lock);
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	/* make sure that nobody messed with @iocg */
-	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	/*
+	 * make sure that nobody messed with @iocg. Check iocg->pd.online
+	 * to avoid warn when removing blkcg or disk.
+	 */
+	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
 	WARN_ON_ONCE(iocg->inuse > 1);
 
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
diff --git a/crypto/crypto_null.c b/crypto/crypto_null.c
index 5b84b0f7cc17..337867028653 100644
--- a/crypto/crypto_null.c
+++ b/crypto/crypto_null.c
@@ -17,10 +17,10 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 
-static DEFINE_MUTEX(crypto_default_null_skcipher_lock);
+static DEFINE_SPINLOCK(crypto_default_null_skcipher_lock);
 static struct crypto_sync_skcipher *crypto_default_null_skcipher;
 static int crypto_default_null_skcipher_refcnt;
 
@@ -152,23 +152,32 @@ MODULE_ALIAS_CRYPTO("cipher_null");
 
 struct crypto_sync_skcipher *crypto_get_default_null_skcipher(void)
 {
+	struct crypto_sync_skcipher *ntfm = NULL;
 	struct crypto_sync_skcipher *tfm;
 
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	tfm = crypto_default_null_skcipher;
 
 	if (!tfm) {
-		tfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
-		if (IS_ERR(tfm))
-			goto unlock;
-
-		crypto_default_null_skcipher = tfm;
+		spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+		ntfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
+		if (IS_ERR(ntfm))
+			return ntfm;
+
+		spin_lock_bh(&crypto_default_null_skcipher_lock);
+		tfm = crypto_default_null_skcipher;
+		if (!tfm) {
+			tfm = ntfm;
+			ntfm = NULL;
+			crypto_default_null_skcipher = tfm;
+		}
 	}
 
 	crypto_default_null_skcipher_refcnt++;
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
 
-unlock:
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	crypto_free_sync_skcipher(ntfm);
 
 	return tfm;
 }
@@ -176,12 +185,16 @@ EXPORT_SYMBOL_GPL(crypto_get_default_null_skcipher);
 
 void crypto_put_default_null_skcipher(void)
 {
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	struct crypto_sync_skcipher *tfm = NULL;
+
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	if (!--crypto_default_null_skcipher_refcnt) {
-		crypto_free_sync_skcipher(crypto_default_null_skcipher);
+		tfm = crypto_default_null_skcipher;
 		crypto_default_null_skcipher = NULL;
 	}
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+	crypto_free_sync_skcipher(tfm);
 }
 EXPORT_SYMBOL_GPL(crypto_put_default_null_skcipher);
 
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 4ae93350b70d..38581001811b 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -217,7 +217,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	while ((unsigned long)entry + proc_sz < table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
@@ -258,7 +258,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
 	while ((unsigned long)entry + proc_sz < table_end) {
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 04b53bb7a692..2bb9555663e7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -591,6 +591,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 48130b254396..e700024a8b48 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1479,8 +1479,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
-	/* is it pointless to prefer PIO for "safety reasons"? */
-	if (ap->flags & ATA_FLAG_PIO_DMA) {
+	/*
+	 * Do not use DMA if the connected device only supports PIO, even if the
+	 * port prefers PIO commands via DMA.
+	 *
+	 * Ideally, we should call atapi_check_dma() to check if it is safe for
+	 * the LLD to use DMA for REQUEST_SENSE, but we don't have a qc.
+	 * Since we can't check the command, perhaps we should only use pio?
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_DMA) && !(dev->flags & ATA_DFLAG_PIO)) {
 		tf.protocol = ATAPI_PROT_DMA;
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 41430f79663c..3502bfb03c56 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -223,10 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
 						resource_size(cmd_res));
+	if (!ap->ioaddr.cmd_addr)
+		return -ENOMEM;
 	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
 						resource_size(ctl_res));
+	if (!ap->ioaddr.ctl_addr)
+		return -ENOMEM;
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
+	if (!ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 
 	/*
 	 * Adjust register offsets
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index c95685f693a6..20b73e0d835a 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -308,15 +308,9 @@ static inline void pdc20621_ata_sg(u8 *buf, unsigned int portno,
 	/* output ATA packet S/G table */
 	addr = PDC_20621_DIMM_BASE + PDC_20621_DIMM_DATA +
 	       (PDC_DIMM_DATA_STEP * portno);
-	VPRINTK("ATA sg addr 0x%x, %d\n", addr, addr);
+
 	buf32[dw] = cpu_to_le32(addr);
 	buf32[dw + 1] = cpu_to_le32(total_len | ATA_PRD_EOT);
-
-	VPRINTK("ATA PSG @ %x == (0x%x, 0x%x)\n",
-		PDC_20621_DIMM_BASE +
-		       (PDC_DIMM_WINDOW_STEP * portno) +
-		       PDC_DIMM_APKT_PRD,
-		buf32[dw], buf32[dw + 1]);
 }
 
 static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
@@ -332,12 +326,6 @@ static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
 
 	buf32[dw] = cpu_to_le32(addr);
 	buf32[dw + 1] = cpu_to_le32(total_len | ATA_PRD_EOT);
-
-	VPRINTK("HOST PSG @ %x == (0x%x, 0x%x)\n",
-		PDC_20621_DIMM_BASE +
-		       (PDC_DIMM_WINDOW_STEP * portno) +
-		       PDC_DIMM_HPKT_PRD,
-		buf32[dw], buf32[dw + 1]);
 }
 
 static inline unsigned int pdc20621_ata_pkt(struct ata_taskfile *tf,
@@ -351,7 +339,6 @@ static inline unsigned int pdc20621_ata_pkt(struct ata_taskfile *tf,
 	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
 			       (PDC_DIMM_WINDOW_STEP * portno) +
 			       PDC_DIMM_APKT_PRD;
-	VPRINTK("ENTER, dimm_sg == 0x%x, %d\n", dimm_sg, dimm_sg);
 
 	i = PDC_DIMM_ATA_PKT;
 
@@ -406,8 +393,6 @@ static inline void pdc20621_host_pkt(struct ata_taskfile *tf, u8 *buf,
 	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
 			       (PDC_DIMM_WINDOW_STEP * portno) +
 			       PDC_DIMM_HPKT_PRD;
-	VPRINTK("ENTER, dimm_sg == 0x%x, %d\n", dimm_sg, dimm_sg);
-	VPRINTK("host_sg == 0x%x, %d\n", host_sg, host_sg);
 
 	dw = PDC_DIMM_HOST_PKT >> 2;
 
@@ -424,14 +409,6 @@ static inline void pdc20621_host_pkt(struct ata_taskfile *tf, u8 *buf,
 	buf32[dw + 1] = cpu_to_le32(host_sg);
 	buf32[dw + 2] = cpu_to_le32(dimm_sg);
 	buf32[dw + 3] = 0;
-
-	VPRINTK("HOST PKT @ %x == (0x%x 0x%x 0x%x 0x%x)\n",
-		PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * portno) +
-			PDC_DIMM_HOST_PKT,
-		buf32[dw + 0],
-		buf32[dw + 1],
-		buf32[dw + 2],
-		buf32[dw + 3]);
 }
 
 static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
@@ -447,8 +424,6 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
@@ -492,7 +467,8 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
+	ata_port_dbg(ap, "ata pkt buf ofs %u, prd size %u, mmio copied\n",
+		     i, sgt_len);
 }
 
 static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
@@ -504,8 +480,6 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 	unsigned int portno = ap->port_no;
 	unsigned int i;
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
@@ -527,7 +501,7 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, mmio copied\n", i);
+	ata_port_dbg(ap, "ata pkt buf ofs %u, mmio copied\n", i);
 }
 
 static enum ata_completion_errors pdc20621_qc_prep(struct ata_queued_cmd *qc)
@@ -633,8 +607,6 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	wmb();			/* flush PRD, pkt writes */
 
 	port_ofs = PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * port_no);
@@ -645,7 +617,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 
 		pdc20621_dump_hdma(qc);
 		pdc20621_push_hdma(qc, seq, port_ofs + PDC_DIMM_HOST_PKT);
-		VPRINTK("queued ofs 0x%x (%u), seq %u\n",
+		ata_port_dbg(ap, "queued ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_HOST_PKT,
 			port_ofs + PDC_DIMM_HOST_PKT,
 			seq);
@@ -656,7 +628,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 		writel(port_ofs + PDC_DIMM_ATA_PKT,
 		       ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-		VPRINTK("submitted ofs 0x%x (%u), seq %u\n",
+		ata_port_dbg(ap, "submitted ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_ATA_PKT,
 			port_ofs + PDC_DIMM_ATA_PKT,
 			seq);
@@ -696,14 +668,12 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	u8 status;
 	unsigned int handled = 0;
 
-	VPRINTK("ENTER\n");
-
 	if ((qc->tf.protocol == ATA_PROT_DMA) &&	/* read */
 	    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 
 		/* step two - DMA from DIMM to host */
 		if (doing_hdma) {
-			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "read hdma, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -714,7 +684,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 		/* step one - exec ATA command */
 		else {
 			u8 seq = (u8) (port_no + 1 + 4);
-			VPRINTK("ata%u: read ata, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "read ata, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit hdma pkt */
@@ -729,7 +699,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 		/* step one - DMA from host to DIMM */
 		if (doing_hdma) {
 			u8 seq = (u8) (port_no + 1);
-			VPRINTK("ata%u: write hdma, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "write hdma, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit ata pkt */
@@ -742,7 +712,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 
 		/* step two - execute ATA command */
 		else {
-			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "write ata, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -755,7 +725,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
 
 		status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		ata_port_dbg(ap, "BUS_NODATA (drv_stat 0x%X)\n", status);
 		qc->err_mask |= ac_err_mask(status);
 		ata_qc_complete(qc);
 		handled = 1;
@@ -781,29 +751,21 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 	unsigned int handled = 0;
 	void __iomem *mmio_base;
 
-	VPRINTK("ENTER\n");
-
-	if (!host || !host->iomap[PDC_MMIO_BAR]) {
-		VPRINTK("QUICK EXIT\n");
+	if (!host || !host->iomap[PDC_MMIO_BAR])
 		return IRQ_NONE;
-	}
 
 	mmio_base = host->iomap[PDC_MMIO_BAR];
 
 	/* reading should also clear interrupts */
 	mmio_base += PDC_CHIP0_OFS;
 	mask = readl(mmio_base + PDC_20621_SEQMASK);
-	VPRINTK("mask == 0x%x\n", mask);
 
-	if (mask == 0xffffffff) {
-		VPRINTK("QUICK EXIT 2\n");
+	if (mask == 0xffffffff)
 		return IRQ_NONE;
-	}
+
 	mask &= 0xffff;		/* only 16 tags possible */
-	if (!mask) {
-		VPRINTK("QUICK EXIT 3\n");
+	if (!mask)
 		return IRQ_NONE;
-	}
 
 	spin_lock(&host->lock);
 
@@ -816,7 +778,8 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 		else
 			ap = host->ports[port_no];
 		tmp = mask & (1 << i);
-		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
+		if (ap)
+			ata_port_dbg(ap, "seq %u, tmp %x\n", i, tmp);
 		if (tmp && ap) {
 			struct ata_queued_cmd *qc;
 
@@ -829,10 +792,6 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("mask == 0x%x\n", mask);
-
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(handled);
 }
 
@@ -1165,9 +1124,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
 	mmio += PDC_CHIP0_OFS;
 
 	for (i = 0; i < ARRAY_SIZE(pdc_i2c_read_data); i++)
-		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
-				  pdc_i2c_read_data[i].reg,
-				  &spd0[pdc_i2c_read_data[i].ofs]);
+		if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
+				       pdc_i2c_read_data[i].reg,
+				       &spd0[pdc_i2c_read_data[i].ofs])) {
+			dev_err(host->dev,
+				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
+				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
+			return -EIO;
+		}
 
 	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
 	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
@@ -1272,7 +1236,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	/* Initialize Time Period Register */
 	writel(0xffffffff, mmio + PDC_TIME_PERIOD);
 	time_period = readl(mmio + PDC_TIME_PERIOD);
-	VPRINTK("Time Period Register (0x40): 0x%x\n", time_period);
+	dev_dbg(host->dev, "Time Period Register (0x40): 0x%x\n", time_period);
 
 	/* Enable timer */
 	writel(PDC_TIMER_DEFAULT, mmio + PDC_TIME_CONTROL);
@@ -1287,7 +1251,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	*/
 
 	tcount = readl(mmio + PDC_TIME_COUNTER);
-	VPRINTK("Time Counter Register (0x44): 0x%x\n", tcount);
+	dev_dbg(host->dev, "Time Counter Register (0x44): 0x%x\n", tcount);
 
 	/*
 	   If SX4 is on PCI-X bus, after 3 seconds, the timer counter
@@ -1295,17 +1259,19 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	*/
 	if (tcount >= PCI_X_TCOUNT) {
 		ticks = (time_period - tcount);
-		VPRINTK("Num counters 0x%x (%d)\n", ticks, ticks);
+		dev_dbg(host->dev, "Num counters 0x%x (%d)\n", ticks, ticks);
 
 		clock = (ticks / 300000);
-		VPRINTK("10 * Internal clk = 0x%x (%d)\n", clock, clock);
+		dev_dbg(host->dev, "10 * Internal clk = 0x%x (%d)\n",
+			clock, clock);
 
 		clock = (clock * 33);
-		VPRINTK("10 * Internal clk * 33 = 0x%x (%d)\n", clock, clock);
+		dev_dbg(host->dev, "10 * Internal clk * 33 = 0x%x (%d)\n",
+			clock, clock);
 
 		/* PLL F Param (bit 22:16) */
 		fparam = (1400000 / clock) - 2;
-		VPRINTK("PLL F Param: 0x%x (%d)\n", fparam, fparam);
+		dev_dbg(host->dev, "PLL F Param: 0x%x (%d)\n", fparam, fparam);
 
 		/* OD param = 0x2 (bit 31:30), R param = 0x5 (bit 29:25) */
 		pci_status = (0x8a001824 | (fparam << 16));
@@ -1313,7 +1279,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		pci_status = PCI_PLL_INIT;
 
 	/* Initialize PLL. */
-	VPRINTK("pci_status: 0x%x\n", pci_status);
+	dev_dbg(host->dev, "pci_status: 0x%x\n", pci_status);
 	writel(pci_status, mmio + PDC_CTL_STATUS);
 	readl(mmio + PDC_CTL_STATUS);
 
@@ -1325,15 +1291,18 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		printk(KERN_ERR "Detect Local DIMM Fail\n");
 		return 1;	/* DIMM error */
 	}
-	VPRINTK("Local DIMM Speed = %d\n", speed);
+	dev_dbg(host->dev, "Local DIMM Speed = %d\n", speed);
 
 	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
 	size = pdc20621_prog_dimm0(host);
-	VPRINTK("Local DIMM Size = %dMB\n", size);
+	if (size < 0)
+		return size;
+	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
 
 	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
 	if (pdc20621_prog_dimm_global(host)) {
-		printk(KERN_ERR "Programming DIMM Module Global Control Register Fail\n");
+		dev_err(host->dev,
+			"Programming DIMM Module Global Control Register Fail\n");
 		return 1;
 	}
 
@@ -1370,13 +1339,14 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			       PDC_DIMM_SPD_TYPE, &spd0)) {
-		pr_err("Failed in i2c read: device=%#x, subaddr=%#x\n",
+		dev_err(host->dev,
+			"Failed in i2c read: device=%#x, subaddr=%#x\n",
 		       PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
 		return 1;
 	}
 	if (spd0 == 0x02) {
 		void *buf;
-		VPRINTK("Start ECC initialization\n");
+		dev_dbg(host->dev, "Start ECC initialization\n");
 		addr = 0;
 		length = size * 1024 * 1024;
 		buf = kzalloc(ECC_ERASE_BUF_SZ, GFP_KERNEL);
@@ -1388,7 +1358,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 			addr += ECC_ERASE_BUF_SZ;
 		}
 		kfree(buf);
-		VPRINTK("Finish ECC initialization\n");
+		dev_dbg(host->dev, "Finish ECC initialization\n");
 	}
 	return 0;
 }
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 3a9afc905f24..77de43d8d796 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -625,6 +625,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
+			if (!ret)
+				ret = -EINVAL;
 			goto err_free;
 		}
 	}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e7d78937f7d6..93bb58971dbe 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 	if (!skb) {
 		percpu_down_read(&hu->proto_lock);
 
-		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+		    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 			skb = hu->proto->dequeue(hu);
 
 		percpu_up_read(&hu->proto_lock);
@@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	if (!percpu_down_read_trylock(&hu->proto_lock))
 		return 0;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;
 
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return -EUNATCH;
 	}
@@ -579,7 +582,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -605,7 +609,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -706,12 +711,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 4e039d7a16f8..4f33074860af 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -89,6 +89,7 @@ struct hci_uart {
 #define HCI_UART_PROTO_SET	0
 #define HCI_UART_REGISTERED	1
 #define HCI_UART_PROTO_READY	2
+#define HCI_UART_PROTO_INIT	4
 
 /* TX states  */
 #define HCI_UART_SENDING	1
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1734b4341585..5c8f009bb6f7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1617,8 +1617,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
-			__u16 cols;
+			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
@@ -1626,7 +1626,8 @@ static void handle_control_message(struct virtio_device *vdev,
 
 		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
 		       sizeof(size));
-		set_console_size(port, size.rows, size.cols);
+		set_console_size(port, virtio16_to_cpu(vdev, size.rows),
+				 virtio16_to_cpu(vdev, size.cols));
 
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7dc3b0cca252..950dfa059a20 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4858,6 +4858,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	/* Check if node in clkspec is in disabled/fail state */
+	if (!of_device_is_available(clkspec->np))
+		return ERR_PTR(-ENOENT);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index db2841d0beb8..90c10f378df2 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -168,9 +168,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
 
 		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 162de402b113..d13139497da4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2593,10 +2593,18 @@ EXPORT_SYMBOL(cpufreq_update_policy);
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
+	struct cpufreq_policy *policy;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
+
 	if (cpufreq_driver->update_limits)
 		cpufreq_driver->update_limits(cpu);
 	else
 		cpufreq_update_policy(cpu);
+
+	cpufreq_cpu_put(policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index c79cdf1be780..f990de8c6ed0 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -37,9 +37,16 @@ static struct scpi_ops *scpi_ops;
 
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scpi_data *priv = policy->driver_data;
-	unsigned long rate = clk_get_rate(priv->clk);
+	struct cpufreq_policy *policy;
+	struct scpi_data *priv;
+	unsigned long rate;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+	rate = clk_get_rate(priv->clk);
 
 	return rate / 1000;
 }
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index c96c14e7dab1..0ef92109ce22 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -107,7 +107,12 @@ static int atmel_sha204a_probe(struct i2c_client *client,
 
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
-	i2c_priv->hwrng.quality = 1024;
+
+	/*
+	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
+	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+	 */
+	i2c_priv->hwrng.quality = 1;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
 	if (ret)
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 8e9f6097114e..82afae9ca907 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -115,12 +115,12 @@ int caam_qi_enqueue(struct device *qidev, struct caam_drv_req *req)
 	qm_fd_addr_set64(&fd, addr);
 
 	do {
+		refcount_inc(&req->drv_ctx->refcnt);
 		ret = qman_enqueue(req->drv_ctx->req_fq, &fd);
-		if (likely(!ret)) {
-			refcount_inc(&req->drv_ctx->refcnt);
+		if (likely(!ret))
 			return 0;
-		}
 
+		refcount_dec(&req->drv_ctx->refcnt);
 		if (ret != -EBUSY)
 			break;
 		num_retries++;
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index c319e7e3917d..8efcdd6a2eab 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -118,14 +118,17 @@ static bool sp_pci_is_master(struct sp_device *sp)
 	pdev_new = to_pci_dev(dev_new);
 	pdev_cur = to_pci_dev(dev_cur);
 
-	if (pdev_new->bus->number < pdev_cur->bus->number)
-		return true;
+	if (pci_domain_nr(pdev_new->bus) != pci_domain_nr(pdev_cur->bus))
+		return pci_domain_nr(pdev_new->bus) < pci_domain_nr(pdev_cur->bus);
 
-	if (PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn))
-		return true;
+	if (pdev_new->bus->number != pdev_cur->bus->number)
+		return pdev_new->bus->number < pdev_cur->bus->number;
 
-	if (PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn))
-		return true;
+	if (PCI_SLOT(pdev_new->devfn) != PCI_SLOT(pdev_cur->devfn))
+		return PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn);
+
+	if (PCI_FUNC(pdev_new->devfn) != PCI_FUNC(pdev_cur->devfn))
+		return PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn);
 
 	return false;
 }
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 14b79458ac7f..597a92438afc 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -177,7 +177,7 @@ static long udmabuf_create(struct miscdevice *device,
 	if (!ubuf)
 		return -ENOMEM;
 
-	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
+	pglimit = ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
 	for (i = 0; i < head->count; i++) {
 		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
 			goto err;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a3a172173e34..915724fd7ea6 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -825,9 +825,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+			wait_event_timeout(thread->done_wait,
+					   done->done,
+					   msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index c288a7502de2..7f73f775d6ba 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -1016,6 +1016,7 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_warn(&pdev->dev, "pm_runtime_get_sync() Failed\n");
+	device_init_wakeup(&pdev->dev, 0);
 	gpiochip_remove(&gpio->chip);
 	clk_disable_unprepare(gpio->clk);
 	device_set_wakeup_capable(&pdev->dev, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e93ccdc5faf4..e4d0a9377e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -357,17 +357,12 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
-		amdgpu_vram_mgr_free_sgt(adev, attach->dev, dir, sgt);
+		amdgpu_vram_mgr_free_sgt(attach->dev, dir, sgt);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a87951b2f06d..bd873b1b760c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -113,8 +113,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table **sgt);
-void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
-			      struct device *dev,
+void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt);
 uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 0c6b7c5ecfec..ad72db21b8d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -530,13 +530,13 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 /**
  * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
  *
- * @adev: amdgpu device pointer
+ * @dev: device pointer
+ * @dir: data direction of resource to unmap
  * @sgt: sg table to free
  *
  * Free a previously allocate sg table.
  */
-void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
-			      struct device *dev,
+void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9a444b17530a..869c8786df5c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -190,6 +190,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	if (!access_ok((const void __user *) args->read_pointer_address,
 			sizeof(uint32_t))) {
 		pr_err("Can't access read pointer\n");
@@ -394,6 +399,11 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
 	properties.queue_percent = args->queue_percentage;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 43c07ac2c6fc..cabe0012ab5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -384,7 +384,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 786cd892f179..260133562db5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3397,17 +3397,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
+	if (link_cnt > (MAX_PIPES * 2)) {
+		DRM_ERROR(
+			"KMS: Cannot support more than %d display indexes\n",
+				MAX_PIPES * 2);
+		goto fail;
+	}
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
 
-		if (i > AMDGPU_DM_MAX_DISPLAY_INDEX) {
-			DRM_ERROR(
-				"KMS: Cannot support more than %d display indexes\n",
-					AMDGPU_DM_MAX_DISPLAY_INDEX);
-			continue;
-		}
-
 		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 		if (!aconnector)
 			goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 01c4e8753294..f02305089b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1698,7 +1698,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index 0b30f73649a8..49f97d612421 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -261,10 +261,10 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
 			(hwmgr->thermal_controller.fanInfo.
 			ucTachometerPulsesPerRevolution == 0) ||
-			speed == 0 ||
+			(!speed || speed > UINT_MAX/8) ||
 			(speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
 			(speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM))
-		return 0;
+		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 952cd3d7240e..303538efdc97 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -311,10 +311,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	int result = 0;
 
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
-	    speed == 0 ||
+	    (!speed || speed > UINT_MAX/8) ||
 	    (speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
 	    (speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM))
-		return -1;
+		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		result = vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 364162ddaa9c..87b7baa9492b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -189,7 +189,7 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	uint32_t tach_period, crystal_clock_freq;
 	int result = 0;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl)) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 0fde260b7edd..dee3b81dec58 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1268,7 +1268,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		DRM_DEBUG_ATOMIC("modeset on [ENCODER:%d:%s]\n",
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 7fd3de89ed07..acd29b4f43f8 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -49,7 +49,7 @@ static LIST_HEAD(panel_list);
  * @dev: parent device of the panel
  * @funcs: panel operations
  * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
- *	the panel interface
+ *	the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
  *
  * Initialize the panel structure for subsequent registration with
  * drm_panel_add().
@@ -57,6 +57,9 @@ static LIST_HEAD(panel_list);
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs, int connector_type)
 {
+	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
+		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
+
 	INIT_LIST_HEAD(&panel->list);
 	panel->dev = dev;
 	panel->funcs = funcs;
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index bf90a5be956f..6fc9d638ccd2 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -166,10 +166,10 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* AYA NEO AYANEO 2 */
+	}, {	/* AYA NEO AYANEO 2/2S */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
@@ -235,6 +235,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 2 (correct DMI strings) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WIN2")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* GPD Win 3 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index a19537706ed1..eb6f4d7f1e34 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -904,8 +904,13 @@ int intel_engines_init(struct intel_gt *gt)
 			return err;
 
 		err = setup(engine);
-		if (err)
+		if (err) {
+			intel_engine_cleanup_common(engine);
 			return err;
+		}
+
+		/* The backend should now be responsible for cleanup */
+		GEM_BUG_ON(engine->release == NULL);
 
 		err = engine_init_common(engine);
 		if (err)
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index aa3d472c79d7..ac75c10aed2f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -369,6 +369,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -385,6 +386,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_engine;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
@@ -394,6 +401,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7633f56bc0a4..35263e17863b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -143,6 +143,9 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	nouveau_bo_del_io_reserve_lru(bo);
 	nv10_bo_put_tile_region(dev, nvbo->tile, NULL);
 
+	if (bo->base.import_attach)
+		drm_prime_gem_destroy(&bo->base, bo->sg);
+
 	/*
 	 * If nouveau_bo_new() allocated this buffer, the GEM object was never
 	 * initialized, so don't attempt to release it.
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 6504ebec1190..567b43aa4a31 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -51,9 +51,6 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
 		return;
 	}
 
-	if (gem->import_attach)
-		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-
 	ttm_bo_put(&nvbo->bo);
 
 	pm_runtime_mark_last_busy(dev);
diff --git a/drivers/gpu/drm/sti/Makefile b/drivers/gpu/drm/sti/Makefile
index f203ac5514ae..f778a4eee7c9 100644
--- a/drivers/gpu/drm/sti/Makefile
+++ b/drivers/gpu/drm/sti/Makefile
@@ -7,8 +7,6 @@ sti-drm-y := \
 	sti_compositor.o \
 	sti_crtc.o \
 	sti_plane.o \
-	sti_crtc.o \
-	sti_plane.o \
 	sti_hdmi.o \
 	sti_hdmi_tx3g4c28phy.o \
 	sti_dvo.o \
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 2e01cf0a9876..6395b7016f13 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -454,7 +454,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
 				       enum repaper_stage stage)
 {
 	u64 start = local_clock();
-	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
+	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
 
 	do {
 		repaper_frame_fixed(epd, fixed_value, stage);
@@ -465,7 +465,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
 				      const u8 *mask, enum repaper_stage stage)
 {
 	u64 start = local_clock();
-	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
+	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
 
 	do {
 		repaper_frame_data(epd, image, mask, stage);
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 07a9fe97d2e0..d237736cb25a 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -21,6 +21,7 @@
 #include "usbhid.h"
 
 #define	PID_EFFECTS_MAX		64
+#define	PID_INFINITE		0xffff
 
 /* Report usage table used to put reports into an array */
 
@@ -261,10 +262,22 @@ static void pidff_set_envelope_report(struct pidff_device *pidff,
 static int pidff_needs_set_envelope(struct ff_envelope *envelope,
 				    struct ff_envelope *old)
 {
-	return envelope->attack_level != old->attack_level ||
-	       envelope->fade_level != old->fade_level ||
+	bool needs_new_envelope;
+	needs_new_envelope = envelope->attack_level  != 0 ||
+			     envelope->fade_level    != 0 ||
+			     envelope->attack_length != 0 ||
+			     envelope->fade_length   != 0;
+
+	if (!needs_new_envelope)
+		return false;
+
+	if (!old)
+		return needs_new_envelope;
+
+	return envelope->attack_level  != old->attack_level  ||
+	       envelope->fade_level    != old->fade_level    ||
 	       envelope->attack_length != old->attack_length ||
-	       envelope->fade_length != old->fade_length;
+	       envelope->fade_length   != old->fade_length;
 }
 
 /*
@@ -301,7 +314,12 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
 		pidff->create_new_effect_type->value[0];
-	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
+
+	/* Convert infinite length from Linux API (0)
+	   to PID standard (NULL) if needed */
+	pidff->set_effect[PID_DURATION].value[0] =
+		effect->replay.length == 0 ? PID_INFINITE : effect->replay.length;
+
 	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
 	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
 		effect->trigger.interval;
@@ -574,11 +592,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_constant(effect, old))
 			pidff_set_constant_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.constant.envelope,
-					&old->u.constant.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.constant.envelope);
+		if (pidff_needs_set_envelope(&effect->u.constant.envelope,
+					old ? &old->u.constant.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.constant.envelope);
 		break;
 
 	case FF_PERIODIC:
@@ -613,11 +629,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_periodic(effect, old))
 			pidff_set_periodic_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.periodic.envelope,
-					&old->u.periodic.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.periodic.envelope);
+		if (pidff_needs_set_envelope(&effect->u.periodic.envelope,
+					old ? &old->u.periodic.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.periodic.envelope);
 		break;
 
 	case FF_RAMP:
@@ -631,11 +645,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_ramp(effect, old))
 			pidff_set_ramp_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.ramp.envelope,
-					&old->u.ramp.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.ramp.envelope);
+		if (pidff_needs_set_envelope(&effect->u.ramp.envelope,
+					old ? &old->u.ramp.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.ramp.envelope);
 		break;
 
 	case FF_SPRING:
@@ -760,6 +772,11 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 {
 	int i, j, k, found;
 
+	if (!report) {
+		pr_debug("pidff_find_fields, null report\n");
+		return -1;
+	}
+
 	for (k = 0; k < count; k++) {
 		found = 0;
 		for (i = 0; i < report->maxfield; i++) {
@@ -873,6 +890,11 @@ static struct hid_field *pidff_find_special_field(struct hid_report *report,
 {
 	int i;
 
+	if (!report) {
+		pr_debug("pidff_find_special_field, null report\n");
+		return NULL;
+	}
+
 	for (i = 0; i < report->maxfield; i++) {
 		if (report->field[i]->logical == (HID_UP_PID | usage) &&
 		    report->field[i]->report_count > 0) {
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 96d0eccca3aa..8f7c4fd100d6 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -403,6 +403,7 @@ static void ssip_reset(struct hsi_client *cl)
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 790ea3fda693..69607ae7cdab 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -247,6 +247,9 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	u32 remote_bus;
 	int err;
 
+	if (!ec)
+		return dev_err_probe(dev, -EPROBE_DEFER, "couldn't find parent EC device\n");
+
 	if (!ec->cmd_xfer) {
 		dev_err(dev, "Missing sendrecv\n");
 		return -EINVAL;
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0d8210f40ff6..6d56d23d6429 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2282,6 +2282,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
  */
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 {
+	if (!dev->ibi || !slot)
+		return;
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->common.master->wq, &slot->work);
 }
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 4afa50e5c058..2445ebc551dd 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -369,12 +369,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = ad7768_scan_direct(indio_dev);
-		if (ret >= 0)
-			*val = ret;
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index af4af4789ef2..dd69b20ed286 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -78,12 +78,14 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 		npfns = (end - start) >> PAGE_SHIFT;
 		umem_odp->pfn_list = kvcalloc(
-			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
+			npfns, sizeof(*umem_odp->pfn_list),
+			GFP_KERNEL | __GFP_NOWARN);
 		if (!umem_odp->pfn_list)
 			return -ENOMEM;
 
 		umem_odp->dma_list = kvcalloc(
-			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
+			ndmas, sizeof(*umem_odp->dma_list),
+			GFP_KERNEL | __GFP_NOWARN);
 		if (!umem_odp->dma_list) {
 			ret = -ENOMEM;
 			goto out_pfn_list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f520e43e4e14..3c79668c6b3b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -552,7 +552,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
-	dma_set_max_seg_size(dev, UINT_MAX);
+	dma_set_max_seg_size(dev, SZ_2G);
 	ret = ib_register_device(ib_dev, "hns_%d", dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index e336d778e076..5ec67e3c2d03 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -56,6 +56,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index aa2e65fc5cd6..ea3e28e3e0b2 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -378,7 +378,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	if (!us_ibdev) {
 		usnic_err("Device %s context alloc failed\n",
 				netdev_name(pci_get_drvdata(dev)));
-		return ERR_PTR(-EFAULT);
+		return NULL;
 	}
 
 	us_ibdev->ufdev = usnic_fwd_dev_alloc(dev);
@@ -519,8 +519,8 @@ static struct usnic_ib_dev *usnic_ib_discover_pf(struct usnic_vnic *vnic)
 	}
 
 	us_ibdev = usnic_ib_device_add(parent_pci);
-	if (IS_ERR_OR_NULL(us_ibdev)) {
-		us_ibdev = us_ibdev ? us_ibdev : ERR_PTR(-EFAULT);
+	if (!us_ibdev) {
+		us_ibdev = ERR_PTR(-EFAULT);
 		goto out;
 	}
 
@@ -583,10 +583,10 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 	}
 
 	pf = usnic_ib_discover_pf(vf->vnic);
-	if (IS_ERR_OR_NULL(pf)) {
-		usnic_err("Failed to discover pf of vnic %s with err%ld\n",
-				pci_name(pdev), PTR_ERR(pf));
-		err = pf ? PTR_ERR(pf) : -EFAULT;
+	if (IS_ERR(pf)) {
+		err = PTR_ERR(pf);
+		usnic_err("Failed to discover pf of vnic %s with err%d\n",
+				pci_name(pdev), err);
 		goto out_clean_vnic;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0a061a196b53..a9a3f9c649c7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3979,7 +3979,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 1ae37e693de0..d080e21df666 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -101,7 +101,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	return 0;
 
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 63eac25ec881..8a03357f8c93 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1960,16 +1960,13 @@ static void check_migrations(struct work_struct *ws)
  * This function gets called on the error paths of the constructor, so we
  * have to cope with a partially initialised struct.
  */
-static void destroy(struct cache *cache)
+static void __destroy(struct cache *cache)
 {
-	unsigned i;
-
 	mempool_exit(&cache->migration_pool);
 
 	if (cache->prison)
 		dm_bio_prison_destroy_v2(cache->prison);
 
-	cancel_delayed_work_sync(&cache->waker);
 	if (cache->wq)
 		destroy_workqueue(cache->wq);
 
@@ -1997,13 +1994,22 @@ static void destroy(struct cache *cache)
 	if (cache->policy)
 		dm_cache_policy_destroy(cache->policy);
 
+	bioset_exit(&cache->bs);
+
+	kfree(cache);
+}
+
+static void destroy(struct cache *cache)
+{
+	unsigned int i;
+
+	cancel_delayed_work_sync(&cache->waker);
+
 	for (i = 0; i < cache->nr_ctr_args ; i++)
 		kfree(cache->ctr_args[i]);
 	kfree(cache->ctr_args);
 
-	bioset_exit(&cache->bs);
-
-	kfree(cache);
+	__destroy(cache);
 }
 
 static void cache_dtr(struct dm_target *ti)
@@ -2616,7 +2622,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	*result = cache;
 	return 0;
 bad:
-	destroy(cache);
+	__destroy(cache);
 	return r;
 }
 
@@ -2667,7 +2673,7 @@ static int cache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	r = copy_ctr_args(cache, argc - 3, (const char **)argv + 3);
 	if (r) {
-		destroy(cache);
+		__destroy(cache);
 		goto out;
 	}
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 067be1d9f51c..934887f8a855 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4303,16 +4303,19 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 		ic->recalc_bitmap = dm_integrity_alloc_page_list(n_bitmap_pages);
 		if (!ic->recalc_bitmap) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
 		ic->may_write_bitmap = dm_integrity_alloc_page_list(n_bitmap_pages);
 		if (!ic->may_write_bitmap) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
 		ic->bbs = kvmalloc_array(ic->n_bitmap_blocks, sizeof(struct bitmap_block_status), GFP_KERNEL);
 		if (!ic->bbs) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3619db7e382a..dada9b2258a6 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2034,14 +2034,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				if (!rdev_set_badblocks(rdev, sect, s, 0))
 					abort = 1;
 			}
-			if (abort) {
-				conf->recovery_disabled =
-					mddev->recovery_disabled;
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_done_sync(mddev, r1_bio->sectors, 0);
-				put_buf(r1_bio);
+			if (abort)
 				return 0;
-			}
+
 			/* Try next page */
 			sectors -= s;
 			sect += s;
@@ -2181,10 +2176,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 	int disks = conf->raid_disks * 2;
 	struct bio *wbio;
 
-	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
-		/* ouch - failed to read all of that. */
-		if (!fix_sync_read_error(r1_bio))
+	if (!test_bit(R1BIO_Uptodate, &r1_bio->state)) {
+		/*
+		 * ouch - failed to read all of that.
+		 * No need to fix read error for check/repair
+		 * because all member disks are read.
+		 */
+		if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) ||
+		    !fix_sync_read_error(r1_bio)) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_done_sync(mddev, r1_bio->sectors, 0);
+			put_buf(r1_bio);
 			return;
+		}
+	}
 
 	if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 		process_checks(r1_bio);
diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
index 7cc654bc52d3..660e348708e6 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -1210,6 +1210,8 @@ static int __init smsdvb_module_init(void)
 	smsdvb_debugfs_register();
 
 	rc = smscore_register_hotplug(smsdvb_hotplug);
+	if (rc)
+		smsdvb_debugfs_unregister();
 
 	pr_debug("\n");
 
diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index 1061f425ece5..20e2c738f6e7 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -322,7 +322,7 @@ struct adv748x_state {
 
 /* Free run pattern select */
 #define ADV748X_SDP_FRP			0x14
-#define ADV748X_SDP_FRP_MASK		GENMASK(3, 1)
+#define ADV748X_SDP_FRP_MASK		GENMASK(2, 0)
 
 /* Saturation */
 #define ADV748X_SDP_SD_SAT_U		0xe3	/* user_map_rw_reg_e3 */
diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 0c10203f822b..aab6ea94e5ae 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -748,6 +748,8 @@ static int ov7251_set_power_on(struct ov7251 *ov7251)
 		return ret;
 	}
 
+	usleep_range(1000, 1100);
+
 	gpiod_set_value_cansleep(ov7251->enable_gpio, 1);
 
 	/* wait at least 65536 external clock cycles */
@@ -1330,7 +1332,7 @@ static int ov7251_probe(struct i2c_client *client)
 		return PTR_ERR(ov7251->analog_regulator);
 	}
 
-	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ov7251->enable_gpio)) {
 		dev_err(dev, "cannot get enable gpio\n");
 		return PTR_ERR(ov7251->enable_gpio);
diff --git a/drivers/media/platform/qcom/venus/Makefile b/drivers/media/platform/qcom/venus/Makefile
index dfc636865709..09ebf4671692 100644
--- a/drivers/media/platform/qcom/venus/Makefile
+++ b/drivers/media/platform/qcom/venus/Makefile
@@ -3,7 +3,8 @@
 
 venus-core-objs += core.o helpers.o firmware.o \
 		   hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
-		   hfi_parser.o pm_helpers.o dbgfs.o
+		   hfi_parser.o pm_helpers.o dbgfs.o \
+		   hfi_platform.o hfi_platform_v4.o \
 
 venus-dec-objs += vdec.o vdec_ctrls.o
 venus-enc-objs += venc.o venc_ctrls.o
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 1859dd3f7f54..987b1d010c04 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -529,17 +529,6 @@ static const struct freq_tbl sdm845_freq_table[] = {
 	{  244800, 100000000 },	/* 1920x1080@30 */
 };
 
-static const struct codec_freq_data sdm845_codec_freq_data[] =  {
-	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
-	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
-	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
-	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10 },
-};
-
 static const struct bw_tbl sdm845_bw_table_enc[] = {
 	{ 1944000, 1612000, 0, 2416000, 0 },	/* 3840x2160@60 */
 	{  972000,  951000, 0, 1434000, 0 },	/* 3840x2160@30 */
@@ -561,8 +550,6 @@ static const struct venus_resources sdm845_res = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sdm845_bw_table_enc),
 	.bw_tbl_dec = sdm845_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
-	.codec_freq_data = sdm845_codec_freq_data,
-	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.vcodec0_clks = { "core", "bus" },
@@ -584,8 +571,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sdm845_bw_table_enc),
 	.bw_tbl_dec = sdm845_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
-	.codec_freq_data = sdm845_codec_freq_data,
-	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
@@ -635,8 +620,6 @@ static const struct venus_resources sc7180_res = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sc7180_bw_table_enc),
 	.bw_tbl_dec = sc7180_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
-	.codec_freq_data = sdm845_codec_freq_data,
-	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 75d006803327..785a5bbb19c3 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -14,6 +14,7 @@
 
 #include "dbgfs.h"
 #include "hfi.h"
+#include "hfi_platform.h"
 
 #define VDBGL	"VenusLow : "
 #define VDBGM	"VenusMed : "
@@ -36,13 +37,6 @@ struct reg_val {
 	u32 value;
 };
 
-struct codec_freq_data {
-	u32 pixfmt;
-	u32 session_type;
-	unsigned long vpp_freq;
-	unsigned long vsp_freq;
-};
-
 struct bw_tbl {
 	u32 mbs_per_sec;
 	u32 avg;
@@ -61,8 +55,6 @@ struct venus_resources {
 	unsigned int bw_tbl_dec_size;
 	const struct reg_val *reg_tbl;
 	unsigned int reg_tbl_size;
-	const struct codec_freq_data *codec_freq_data;
-	unsigned int codec_freq_data_size;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	unsigned int clks_num;
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
@@ -91,30 +83,6 @@ struct venus_format {
 	u32 flags;
 };
 
-#define MAX_PLANES		4
-#define MAX_FMT_ENTRIES		32
-#define MAX_CAP_ENTRIES		32
-#define MAX_ALLOC_MODE_ENTRIES	16
-#define MAX_CODEC_NUM		32
-
-struct raw_formats {
-	u32 buftype;
-	u32 fmt;
-};
-
-struct venus_caps {
-	u32 codec;
-	u32 domain;
-	bool cap_bufs_mode_dynamic;
-	unsigned int num_caps;
-	struct hfi_capability caps[MAX_CAP_ENTRIES];
-	unsigned int num_pl;
-	struct hfi_profile_level pl[HFI_MAX_PROFILE_COUNT];
-	unsigned int num_fmts;
-	struct raw_formats fmts[MAX_FMT_ENTRIES];
-	bool valid;	/* used only for Venus v1xx */
-};
-
 /**
  * struct venus_core - holds core parameters valid for all instances
  *
@@ -207,7 +175,7 @@ struct venus_core {
 	void *priv;
 	const struct hfi_ops *ops;
 	struct delayed_work work;
-	struct venus_caps caps[MAX_CODEC_NUM];
+	struct hfi_plat_caps caps[MAX_CODEC_NUM];
 	unsigned int codecs_count;
 	unsigned int core0_usage_count;
 	unsigned int core1_usage_count;
@@ -279,7 +247,8 @@ struct venus_buffer {
 struct clock_data {
 	u32 core_id;
 	unsigned long freq;
-	const struct codec_freq_data *codec_freq_data;
+	unsigned long vpp_freq;
+	unsigned long vsp_freq;
 };
 
 #define to_venus_buffer(ptr)	container_of(ptr, struct venus_buffer, vb)
@@ -441,7 +410,7 @@ static inline void *to_hfi_priv(struct venus_core *core)
 	return core->priv;
 }
 
-static inline struct venus_caps *
+static inline struct hfi_plat_caps *
 venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
 {
 	unsigned int c;
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 5fdce5f07364..dcf9fc0da1ce 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -15,6 +15,7 @@
 #include "helpers.h"
 #include "hfi_helper.h"
 #include "pm_helpers.h"
+#include "hfi_platform.h"
 
 struct intbuf {
 	struct list_head list;
@@ -480,7 +481,7 @@ session_process_buf(struct venus_inst *inst, struct vb2_v4l2_buffer *vbuf)
 static bool is_dynamic_bufmode(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
-	struct venus_caps *caps;
+	struct hfi_plat_caps *caps;
 
 	/*
 	 * v4 doesn't send BUFFER_ALLOC_MODE_SUPPORTED property and supports
@@ -1040,36 +1041,6 @@ int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_work_mode);
 
-int venus_helper_init_codec_freq_data(struct venus_inst *inst)
-{
-	const struct codec_freq_data *data;
-	unsigned int i, data_size;
-	u32 pixfmt;
-	int ret = 0;
-
-	if (!IS_V4(inst->core))
-		return 0;
-
-	data = inst->core->res->codec_freq_data;
-	data_size = inst->core->res->codec_freq_data_size;
-	pixfmt = inst->session_type == VIDC_SESSION_TYPE_DEC ?
-			inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
-
-	for (i = 0; i < data_size; i++) {
-		if (data[i].pixfmt == pixfmt &&
-		    data[i].session_type == inst->session_type) {
-			inst->clk_data.codec_freq_data = &data[i];
-			break;
-		}
-	}
-
-	if (!inst->clk_data.codec_freq_data)
-		ret = -EINVAL;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(venus_helper_init_codec_freq_data);
-
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs,
 			      unsigned int output2_bufs)
@@ -1535,6 +1506,29 @@ void venus_helper_m2m_job_abort(void *priv)
 }
 EXPORT_SYMBOL_GPL(venus_helper_m2m_job_abort);
 
+int venus_helper_session_init(struct venus_inst *inst)
+{
+	enum hfi_version version = inst->core->res->hfi_version;
+	u32 session_type = inst->session_type;
+	u32 codec;
+	int ret;
+
+	codec = inst->session_type == VIDC_SESSION_TYPE_DEC ?
+			inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
+
+	ret = hfi_session_init(inst, codec);
+	if (ret)
+		return ret;
+
+	inst->clk_data.vpp_freq = hfi_platform_get_codec_vpp_freq(version, codec,
+								  session_type);
+	inst->clk_data.vsp_freq = hfi_platform_get_codec_vsp_freq(version, codec,
+								  session_type);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(venus_helper_session_init);
+
 void venus_helper_init_instance(struct venus_inst *inst)
 {
 	if (inst->session_type == VIDC_SESSION_TYPE_DEC) {
@@ -1545,7 +1539,7 @@ void venus_helper_init_instance(struct venus_inst *inst)
 }
 EXPORT_SYMBOL_GPL(venus_helper_init_instance);
 
-static bool find_fmt_from_caps(struct venus_caps *caps, u32 buftype, u32 fmt)
+static bool find_fmt_from_caps(struct hfi_plat_caps *caps, u32 buftype, u32 fmt)
 {
 	unsigned int i;
 
@@ -1562,7 +1556,7 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 			      u32 *out_fmt, u32 *out2_fmt, bool ubwc)
 {
 	struct venus_core *core = inst->core;
-	struct venus_caps *caps;
+	struct hfi_plat_caps *caps;
 	u32 ubwc_fmt, fmt = to_hfi_raw_fmt(v4l2_fmt);
 	bool found, found_ubwc;
 
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index a4a0562bc83f..5407979bf234 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -33,7 +33,6 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 				       unsigned int width, unsigned int height,
 				       u32 buftype);
 int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
-int venus_helper_init_codec_freq_data(struct venus_inst *inst);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs,
 			      unsigned int output2_bufs);
@@ -48,6 +47,7 @@ unsigned int venus_helper_get_opb_size(struct venus_inst *inst);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
+int venus_helper_session_init(struct venus_inst *inst);
 int venus_helper_get_out_fmts(struct venus_inst *inst, u32 fmt, u32 *out_fmt,
 			      u32 *out2_fmt, bool ubwc);
 int venus_helper_alloc_dpb_bufs(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 966b4d9b57a9..5fd53227c2c0 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -178,6 +178,8 @@ static int wait_session_msg(struct venus_inst *inst)
 int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
 {
 	struct venus_core *core = inst->core;
+	bool max;
+	int ret;
 
 	if (!ops)
 		return -EINVAL;
@@ -187,11 +189,19 @@ int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
 	inst->ops = ops;
 
 	mutex_lock(&core->lock);
-	list_add_tail(&inst->list, &core->instances);
-	atomic_inc(&core->insts_count);
+
+	max = atomic_add_unless(&core->insts_count, 1,
+				core->max_sessions_supported);
+	if (!max) {
+		ret = -EAGAIN;
+	} else {
+		list_add_tail(&inst->list, &core->instances);
+		ret = 0;
+	}
+
 	mutex_unlock(&core->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hfi_session_create);
 
@@ -202,7 +212,7 @@ int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
 	int ret;
 
 	if (inst->state != INST_UNINIT)
-		return -EINVAL;
+		return -EALREADY;
 
 	inst->hfi_codec = to_codec_type(pixfmt);
 	reinit_completion(&inst->done);
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index e13e555b3515..5475879c2669 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -11,14 +11,16 @@
 #include "hfi_helper.h"
 #include "hfi_parser.h"
 
-typedef void (*func)(struct venus_caps *cap, const void *data,
+typedef void (*func)(struct hfi_plat_caps *cap, const void *data,
 		     unsigned int size);
 
 static void init_codecs(struct venus_core *core)
 {
-	struct venus_caps *caps = core->caps, *cap;
+	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	core->codecs_count = 0;
+
 	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
 		return;
 
@@ -37,11 +39,11 @@ static void init_codecs(struct venus_core *core)
 	}
 }
 
-static void for_each_codec(struct venus_caps *caps, unsigned int caps_num,
+static void for_each_codec(struct hfi_plat_caps *caps, unsigned int caps_num,
 			   u32 codecs, u32 domain, func cb, void *data,
 			   unsigned int size)
 {
-	struct venus_caps *cap;
+	struct hfi_plat_caps *cap;
 	unsigned int i;
 
 	for (i = 0; i < caps_num; i++) {
@@ -54,7 +56,7 @@ static void for_each_codec(struct venus_caps *caps, unsigned int caps_num,
 }
 
 static void
-fill_buf_mode(struct venus_caps *cap, const void *data, unsigned int num)
+fill_buf_mode(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 {
 	const u32 *type = data;
 
@@ -62,7 +64,7 @@ fill_buf_mode(struct venus_caps *cap, const void *data, unsigned int num)
 		cap->cap_bufs_mode_dynamic = true;
 }
 
-static void
+static int
 parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_buffer_alloc_mode_supported *mode = data;
@@ -70,7 +72,7 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	u32 *type;
 
 	if (num_entries > MAX_ALLOC_MODE_ENTRIES)
-		return;
+		return -EINVAL;
 
 	type = mode->data;
 
@@ -82,9 +84,11 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 		type++;
 	}
+
+	return sizeof(*mode);
 }
 
-static void fill_profile_level(struct venus_caps *cap, const void *data,
+static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 			       unsigned int num)
 {
 	const struct hfi_profile_level *pl = data;
@@ -96,7 +100,7 @@ static void fill_profile_level(struct venus_caps *cap, const void *data,
 	cap->num_pl += num;
 }
 
-static void
+static int
 parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_profile_level_supported *pl = data;
@@ -104,16 +108,18 @@ parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_profile_level pl_arr[HFI_MAX_PROFILE_COUNT] = {};
 
 	if (pl->profile_count > HFI_MAX_PROFILE_COUNT)
-		return;
+		return -EINVAL;
 
 	memcpy(pl_arr, proflevel, pl->profile_count * sizeof(*proflevel));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_profile_level, pl_arr, pl->profile_count);
+
+	return pl->profile_count * sizeof(*proflevel) + sizeof(u32);
 }
 
 static void
-fill_caps(struct venus_caps *cap, const void *data, unsigned int num)
+fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 {
 	const struct hfi_capability *caps = data;
 
@@ -124,7 +130,7 @@ fill_caps(struct venus_caps *cap, const void *data, unsigned int num)
 	cap->num_caps += num;
 }
 
-static void
+static int
 parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_capabilities *caps = data;
@@ -133,15 +139,17 @@ parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_capability caps_arr[MAX_CAP_ENTRIES] = {};
 
 	if (num_caps > MAX_CAP_ENTRIES)
-		return;
+		return -EINVAL;
 
 	memcpy(caps_arr, cap, num_caps * sizeof(*cap));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_caps, caps_arr, num_caps);
+
+	return sizeof(*caps);
 }
 
-static void fill_raw_fmts(struct venus_caps *cap, const void *fmts,
+static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 			  unsigned int num_fmts)
 {
 	const struct raw_formats *formats = fmts;
@@ -153,7 +161,7 @@ static void fill_raw_fmts(struct venus_caps *cap, const void *fmts,
 	cap->num_fmts += num_fmts;
 }
 
-static void
+static int
 parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_uncompressed_format_supported *fmt = data;
@@ -162,7 +170,8 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct raw_formats rawfmts[MAX_FMT_ENTRIES] = {};
 	u32 entries = fmt->format_entries;
 	unsigned int i = 0;
-	u32 num_planes;
+	u32 num_planes = 0;
+	u32 size;
 
 	while (entries) {
 		num_planes = pinfo->num_planes;
@@ -172,7 +181,7 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		i++;
 
 		if (i >= MAX_FMT_ENTRIES)
-			return;
+			return -EINVAL;
 
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
@@ -184,9 +193,13 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_raw_fmts, rawfmts, i);
+	size = fmt->format_entries * (sizeof(*constr) * num_planes + 2 * sizeof(u32))
+		+ 2 * sizeof(u32);
+
+	return size;
 }
 
-static void parse_codecs(struct venus_core *core, void *data)
+static int parse_codecs(struct venus_core *core, void *data)
 {
 	struct hfi_codec_supported *codecs = data;
 
@@ -198,21 +211,27 @@ static void parse_codecs(struct venus_core *core, void *data)
 		core->dec_codecs &= ~HFI_VIDEO_CODEC_SPARK;
 		core->enc_codecs &= ~HFI_VIDEO_CODEC_HEVC;
 	}
+
+	return sizeof(*codecs);
 }
 
-static void parse_max_sessions(struct venus_core *core, const void *data)
+static int parse_max_sessions(struct venus_core *core, const void *data)
 {
 	const struct hfi_max_sessions_supported *sessions = data;
 
 	core->max_sessions_supported = sessions->max_sessions;
+
+	return sizeof(*sessions);
 }
 
-static void parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
+static int parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
 {
 	struct hfi_codec_mask_supported *mask = data;
 
 	*codecs = mask->codecs;
 	*domain = mask->video_domains;
+
+	return sizeof(*mask);
 }
 
 static void parser_init(struct venus_inst *inst, u32 *codecs, u32 *domain)
@@ -226,7 +245,7 @@ static void parser_init(struct venus_inst *inst, u32 *codecs, u32 *domain)
 
 static void parser_fini(struct venus_inst *inst, u32 codecs, u32 domain)
 {
-	struct venus_caps *caps, *cap;
+	struct hfi_plat_caps *caps, *cap;
 	unsigned int i;
 	u32 dom;
 
@@ -243,11 +262,50 @@ static void parser_fini(struct venus_inst *inst, u32 codecs, u32 domain)
 	}
 }
 
+static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
+{
+	const struct hfi_platform *plat;
+	const struct hfi_plat_caps *caps = NULL;
+	u32 enc_codecs, dec_codecs, count = 0;
+	unsigned int entries;
+
+	plat = hfi_platform_get(core->res->hfi_version);
+	if (!plat)
+		return -EINVAL;
+
+	if (inst)
+		return 0;
+
+	if (plat->codecs)
+		plat->codecs(&enc_codecs, &dec_codecs, &count);
+
+	if (plat->capabilities)
+		caps = plat->capabilities(&entries);
+
+	if (!caps || !entries || !count)
+		return -EINVAL;
+
+	core->enc_codecs = enc_codecs;
+	core->dec_codecs = dec_codecs;
+	core->codecs_count = count;
+	core->max_sessions_supported = MAX_SESSIONS;
+	memset(core->caps, 0, sizeof(*caps) * MAX_CODEC_NUM);
+	memcpy(core->caps, caps, sizeof(*caps) * entries);
+
+	return 0;
+}
+
 u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 	       u32 size)
 {
-	unsigned int words_count = size >> 2;
-	u32 *word = buf, *data, codecs = 0, domain = 0;
+	u32 *words = buf, *payload, codecs = 0, domain = 0;
+	u32 *frame_size = buf + size;
+	u32 rem_bytes = size;
+	int ret;
+
+	ret = hfi_platform_parser(core, inst);
+	if (!ret)
+		return HFI_ERR_NONE;
 
 	if (size % 4)
 		return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
@@ -259,40 +317,71 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 		memset(core->caps, 0, sizeof(core->caps));
 	}
 
-	while (words_count) {
-		data = word + 1;
+	while (words < frame_size) {
+		payload = words + 1;
 
-		switch (*word) {
+		switch (*words) {
 		case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
-			parse_codecs(core, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs(core, payload);
+			if (ret < 0)
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
 			init_codecs(core);
 			break;
 		case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
-			parse_max_sessions(core, data);
+			if (rem_bytes <= sizeof(struct hfi_max_sessions_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_max_sessions(core, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
-			parse_codecs_mask(&codecs, &domain, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_mask_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs_mask(&codecs, &domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
-			parse_raw_formats(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_uncompressed_format_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_raw_formats(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
-			parse_caps(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_capabilities))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_caps(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_SUPPORTED:
-			parse_profile_level(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_profile_level_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_profile_level(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
-			parse_alloc_mode(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_buffer_alloc_mode_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_alloc_mode(core, codecs, domain, payload);
 			break;
 		default:
+			ret = sizeof(u32);
 			break;
 		}
 
-		word++;
-		words_count--;
+		if (ret < 0)
+			return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+		words += ret / sizeof(u32);
+		rem_bytes -= ret;
 	}
 
+	if (!core->max_sessions_supported)
+		core->max_sessions_supported = MAX_SESSIONS;
+
 	parser_fini(inst, codecs, domain);
 
 	return HFI_ERR_NONE;
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.h b/drivers/media/platform/qcom/venus/hfi_parser.h
index 264e6dd2415f..7f59d82110f9 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.h
+++ b/drivers/media/platform/qcom/venus/hfi_parser.h
@@ -16,7 +16,7 @@ static inline u32 get_cap(struct venus_inst *inst, u32 type, u32 which)
 {
 	struct venus_core *core = inst->core;
 	struct hfi_capability *cap = NULL;
-	struct venus_caps *caps;
+	struct hfi_plat_caps *caps;
 	unsigned int i;
 
 	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
new file mode 100644
index 000000000000..65559cae21aa
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_platform.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+#include "hfi_platform.h"
+
+const struct hfi_platform *hfi_platform_get(enum hfi_version version)
+{
+	switch (version) {
+	case HFI_VERSION_4XX:
+		return &hfi_plat_v4;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+unsigned long
+hfi_platform_get_codec_vpp_freq(enum hfi_version version, u32 codec, u32 session_type)
+{
+	const struct hfi_platform *plat;
+	unsigned long freq = 0;
+
+	plat = hfi_platform_get(version);
+	if (!plat)
+		return 0;
+
+	if (plat->codec_vpp_freq)
+		freq = plat->codec_vpp_freq(session_type, codec);
+
+	return freq;
+}
+
+unsigned long
+hfi_platform_get_codec_vsp_freq(enum hfi_version version, u32 codec, u32 session_type)
+{
+	const struct hfi_platform *plat;
+	unsigned long freq = 0;
+
+	plat = hfi_platform_get(version);
+	if (!plat)
+		return 0;
+
+	if (plat->codec_vpp_freq)
+		freq = plat->codec_vsp_freq(session_type, codec);
+
+	return freq;
+}
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
new file mode 100644
index 000000000000..50512d142662
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_platform.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __HFI_PLATFORM_H__
+#define __HFI_PLATFORM_H__
+
+#include <linux/types.h>
+#include <linux/videodev2.h>
+
+#include "hfi.h"
+#include "hfi_helper.h"
+
+#define MAX_PLANES		4
+#define MAX_FMT_ENTRIES		32
+#define MAX_CAP_ENTRIES		32
+#define MAX_ALLOC_MODE_ENTRIES	16
+#define MAX_CODEC_NUM		32
+#define MAX_SESSIONS		16
+
+struct raw_formats {
+	u32 buftype;
+	u32 fmt;
+};
+
+struct hfi_plat_caps {
+	u32 codec;
+	u32 domain;
+	bool cap_bufs_mode_dynamic;
+	unsigned int num_caps;
+	struct hfi_capability caps[MAX_CAP_ENTRIES];
+	unsigned int num_pl;
+	struct hfi_profile_level pl[HFI_MAX_PROFILE_COUNT];
+	unsigned int num_fmts;
+	struct raw_formats fmts[MAX_FMT_ENTRIES];
+	bool valid;	/* used only for Venus v1xx */
+};
+
+struct hfi_platform_codec_freq_data {
+	u32 pixfmt;
+	u32 session_type;
+	unsigned long vpp_freq;
+	unsigned long vsp_freq;
+};
+
+struct hfi_platform {
+	unsigned long (*codec_vpp_freq)(u32 session_type, u32 codec);
+	unsigned long (*codec_vsp_freq)(u32 session_type, u32 codec);
+	void (*codecs)(u32 *enc_codecs, u32 *dec_codecs, u32 *count);
+	const struct hfi_plat_caps *(*capabilities)(unsigned int *entries);
+};
+
+extern const struct hfi_platform hfi_plat_v4;
+
+const struct hfi_platform *hfi_platform_get(enum hfi_version version);
+unsigned long hfi_platform_get_codec_vpp_freq(enum hfi_version version, u32 codec,
+					      u32 session_type);
+unsigned long hfi_platform_get_codec_vsp_freq(enum hfi_version version, u32 codec,
+					      u32 session_type);
+#endif
diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
new file mode 100644
index 000000000000..4fc2fd04ca9d
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+#include "hfi_platform.h"
+
+static const struct hfi_platform_codec_freq_data codec_freq_data[] =  {
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
+	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
+	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10 },
+};
+
+static const struct hfi_platform_codec_freq_data *
+get_codec_freq_data(u32 session_type, u32 pixfmt)
+{
+	const struct hfi_platform_codec_freq_data *data = codec_freq_data;
+	unsigned int i, data_size = ARRAY_SIZE(codec_freq_data);
+	const struct hfi_platform_codec_freq_data *found = NULL;
+
+	for (i = 0; i < data_size; i++) {
+		if (data[i].pixfmt == pixfmt && data[i].session_type == session_type) {
+			found = &data[i];
+			break;
+		}
+	}
+
+	return found;
+}
+
+static unsigned long codec_vpp_freq(u32 session_type, u32 codec)
+{
+	const struct hfi_platform_codec_freq_data *data;
+
+	data = get_codec_freq_data(session_type, codec);
+	if (data)
+		return data->vpp_freq;
+
+	return 0;
+}
+
+static unsigned long codec_vsp_freq(u32 session_type, u32 codec)
+{
+	const struct hfi_platform_codec_freq_data *data;
+
+	data = get_codec_freq_data(session_type, codec);
+	if (data)
+		return data->vsp_freq;
+
+	return 0;
+}
+
+const struct hfi_platform hfi_plat_v4 = {
+	.codec_vpp_freq = codec_vpp_freq,
+	.codec_vsp_freq = codec_vsp_freq,
+};
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 8b1375c97c81..91584d197af9 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -188,6 +188,9 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 	/* ensure rd/wr indices's are read from memory */
 	rmb();
 
+	if (qsize > IFACEQ_QUEUE_SIZE / 4)
+		return -EINVAL;
+
 	if (wr_idx >= rd_idx)
 		empty_space = qsize - (wr_idx - rd_idx);
 	else
@@ -256,6 +259,9 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	wr_idx = qhdr->write_idx;
 	qsize = qhdr->q_size;
 
+	if (qsize > IFACEQ_QUEUE_SIZE / 4)
+		return -EINVAL;
+
 	/* make sure data is valid before using it */
 	rmb();
 
@@ -978,18 +984,26 @@ static void venus_sfr_print(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
 	struct hfi_sfr *sfr = hdev->sfr.kva;
+	u32 size;
 	void *p;
 
 	if (!sfr)
 		return;
 
-	p = memchr(sfr->data, '\0', sfr->buf_size);
+	size = sfr->buf_size;
+	if (!size)
+		return;
+
+	if (size > ALIGNED_SFR_SIZE)
+		size = ALIGNED_SFR_SIZE;
+
+	p = memchr(sfr->data, '\0', size);
 	/*
 	 * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
 	 * that Venus is in the process of crashing.
 	 */
 	if (!p)
-		sfr->data[sfr->buf_size - 1] = '\0';
+		sfr->data[size - 1] = '\0';
 
 	dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
 }
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index fd55352d743e..7c3541c35ab6 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -18,6 +18,7 @@
 #include "hfi_parser.h"
 #include "hfi_venus_io.h"
 #include "pm_helpers.h"
+#include "hfi_platform.h"
 
 static bool legacy_binding;
 
@@ -506,7 +507,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load)
 		if (inst_pos->state != INST_START)
 			continue;
 
-		vpp_freq = inst_pos->clk_data.codec_freq_data->vpp_freq;
+		vpp_freq = inst_pos->clk_data.vpp_freq;
 		coreid = inst_pos->clk_data.core_id;
 
 		mbs_per_sec = load_per_instance(inst_pos);
@@ -555,7 +556,7 @@ static int decide_core(struct venus_inst *inst)
 		return 0;
 
 	inst_load = load_per_instance(inst);
-	inst_load *= inst->clk_data.codec_freq_data->vpp_freq;
+	inst_load *= inst->clk_data.vpp_freq;
 	max_freq = core->res->freq_tbl[0].freq;
 
 	min_loaded_core(inst, &min_coreid, &min_load);
@@ -937,10 +938,13 @@ static unsigned long calculate_inst_freq(struct venus_inst *inst,
 
 	mbs_per_sec = load_per_instance(inst) / fps;
 
-	vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
+	if (inst->state != INST_START)
+		return 0;
+
+	vpp_freq = mbs_per_sec * inst->clk_data.vpp_freq;
 	/* 21 / 20 is overhead factor */
 	vpp_freq += vpp_freq / 20;
-	vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vsp_freq;
+	vsp_freq = mbs_per_sec * inst->clk_data.vsp_freq;
 
 	/* 10 / 7 is overhead factor */
 	if (inst->session_type == VIDC_SESSION_TYPE_ENC)
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index d91030a134c0..68390143d37d 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -767,8 +767,8 @@ static int vdec_session_init(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = hfi_session_init(inst, inst->fmt_out->pixfmt);
-	if (ret == -EINVAL)
+	ret = venus_helper_session_init(inst);
+	if (ret == -EALREADY)
 		return 0;
 	else if (ret)
 		return ret;
@@ -778,10 +778,6 @@ static int vdec_session_init(struct venus_inst *inst)
 	if (ret)
 		goto deinit;
 
-	ret = venus_helper_init_codec_freq_data(inst);
-	if (ret)
-		goto deinit;
-
 	return 0;
 deinit:
 	hfi_session_deinit(inst);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index e2d0fd5eaf29..bc62cb02458c 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -726,8 +726,10 @@ static int venc_init_session(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = hfi_session_init(inst, inst->fmt_cap->pixfmt);
-	if (ret)
+	ret = venus_helper_session_init(inst);
+	if (ret == -EALREADY)
+		return 0;
+	else if (ret)
 		return ret;
 
 	ret = venus_helper_set_input_resolution(inst, inst->width,
@@ -745,10 +747,6 @@ static int venc_init_session(struct venus_inst *inst)
 	if (ret)
 		goto deinit;
 
-	ret = venus_helper_init_codec_freq_data(inst);
-	if (ret)
-		goto deinit;
-
 	ret = venc_set_properties(inst);
 	if (ret)
 		goto deinit;
@@ -764,17 +762,13 @@ static int venc_out_num_buffers(struct venus_inst *inst, unsigned int *num)
 	struct hfi_buffer_requirements bufreq;
 	int ret;
 
-	ret = venc_init_session(inst);
+	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
-
 	*num = bufreq.count_actual;
 
-	hfi_session_deinit(inst);
-
-	return ret;
+	return 0;
 }
 
 static int venc_queue_setup(struct vb2_queue *q,
@@ -783,7 +777,7 @@ static int venc_queue_setup(struct vb2_queue *q,
 {
 	struct venus_inst *inst = vb2_get_drv_priv(q);
 	unsigned int num, min = 4;
-	int ret = 0;
+	int ret;
 
 	if (*num_planes) {
 		if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
@@ -805,6 +799,13 @@ static int venc_queue_setup(struct vb2_queue *q,
 		return 0;
 	}
 
+	mutex_lock(&inst->lock);
+	ret = venc_init_session(inst);
+	mutex_unlock(&inst->lock);
+
+	if (ret)
+		return ret;
+
 	switch (q->type) {
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
 		*num_planes = inst->fmt_out->num_planes;
@@ -840,6 +841,49 @@ static int venc_queue_setup(struct vb2_queue *q,
 	return ret;
 }
 
+static int venc_buf_init(struct vb2_buffer *vb)
+{
+	struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+
+	inst->buf_count++;
+
+	return venus_helper_vb2_buf_init(vb);
+}
+
+static void venc_release_session(struct venus_inst *inst)
+{
+	int ret;
+
+	mutex_lock(&inst->lock);
+
+	ret = hfi_session_deinit(inst);
+	if (ret || inst->session_error)
+		hfi_session_abort(inst);
+
+	mutex_unlock(&inst->lock);
+
+	venus_pm_load_scale(inst);
+	INIT_LIST_HEAD(&inst->registeredbufs);
+	venus_pm_release_core(inst);
+}
+
+static void venc_buf_cleanup(struct vb2_buffer *vb)
+{
+	struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct venus_buffer *buf = to_venus_buffer(vbuf);
+
+	mutex_lock(&inst->lock);
+	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		if (!list_empty(&inst->registeredbufs))
+			list_del_init(&buf->reg_list);
+	mutex_unlock(&inst->lock);
+
+	inst->buf_count--;
+	if (!inst->buf_count)
+		venc_release_session(inst);
+}
+
 static int venc_verify_conf(struct venus_inst *inst)
 {
 	enum hfi_version ver = inst->core->res->hfi_version;
@@ -890,38 +934,32 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	inst->sequence_cap = 0;
 	inst->sequence_out = 0;
 
-	ret = venc_init_session(inst);
-	if (ret)
-		goto bufs_done;
-
 	ret = venus_pm_acquire_core(inst);
 	if (ret)
-		goto deinit_sess;
+		goto error;
 
 	ret = venc_set_properties(inst);
 	if (ret)
-		goto deinit_sess;
+		goto error;
 
 	ret = venc_verify_conf(inst);
 	if (ret)
-		goto deinit_sess;
+		goto error;
 
 	ret = venus_helper_set_num_bufs(inst, inst->num_input_bufs,
 					inst->num_output_bufs, 0);
 	if (ret)
-		goto deinit_sess;
+		goto error;
 
 	ret = venus_helper_vb2_start_streaming(inst);
 	if (ret)
-		goto deinit_sess;
+		goto error;
 
 	mutex_unlock(&inst->lock);
 
 	return 0;
 
-deinit_sess:
-	hfi_session_deinit(inst);
-bufs_done:
+error:
 	venus_helper_buffers_done(inst, q->type, VB2_BUF_STATE_QUEUED);
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		inst->streamon_out = 0;
@@ -933,7 +971,8 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static const struct vb2_ops venc_vb2_ops = {
 	.queue_setup = venc_queue_setup,
-	.buf_init = venus_helper_vb2_buf_init,
+	.buf_init = venc_buf_init,
+	.buf_cleanup = venc_buf_cleanup,
 	.buf_prepare = venus_helper_vb2_buf_prepare,
 	.start_streaming = venc_start_streaming,
 	.stop_streaming = venus_helper_vb2_stop_streaming,
diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 9f3cd9fb6b6e..c0a48f991d9d 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -26,7 +26,6 @@
 #include <linux/usb/input.h>
 #include <media/rc-core.h>
 
-#define DRIVER_VERSION	"1.61"
 #define DRIVER_NAME	"streamzap"
 #define DRIVER_DESC	"Streamzap Remote Control driver"
 
@@ -67,9 +66,6 @@ struct streamzap_ir {
 	struct device *dev;
 
 	/* usb */
-	struct usb_device	*usbdev;
-	struct usb_interface	*interface;
-	struct usb_endpoint_descriptor *endpoint;
 	struct urb		*urb_in;
 
 	/* buffer & dma */
@@ -86,9 +82,7 @@ struct streamzap_ir {
 	/* start time of signal; necessary for gap tracking */
 	ktime_t			signal_last;
 	ktime_t			signal_start;
-	bool			timeout_enabled;
 
-	char			name[128];
 	char			phys[64];
 };
 
@@ -179,39 +173,10 @@ static void sz_push_half_space(struct streamzap_ir *sz,
 	sz_push_full_space(sz, value & SZ_SPACE_MASK);
 }
 
-/*
- * streamzap_callback - usb IRQ handler callback
- *
- * This procedure is invoked on reception of data from
- * the usb remote.
- */
-static void streamzap_callback(struct urb *urb)
+static void sz_process_ir_data(struct streamzap_ir *sz, int len)
 {
-	struct streamzap_ir *sz;
 	unsigned int i;
-	int len;
-
-	if (!urb)
-		return;
-
-	sz = urb->context;
-	len = urb->actual_length;
-
-	switch (urb->status) {
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/*
-		 * this urb is terminated, clean up.
-		 * sz might already be invalid at this point
-		 */
-		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
-		return;
-	default:
-		break;
-	}
 
-	dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
 	for (i = 0; i < len; i++) {
 		dev_dbg(sz->dev, "sz->buf_in[%d]: %x\n",
 			i, (unsigned char)sz->buf_in[i]);
@@ -242,10 +207,7 @@ static void streamzap_callback(struct urb *urb)
 					.duration = sz->rdev->timeout
 				};
 				sz->idle = true;
-				if (sz->timeout_enabled)
-					sz_push(sz, rawir);
-				ir_raw_event_handle(sz->rdev);
-				ir_raw_event_reset(sz->rdev);
+				sz_push(sz, rawir);
 			} else {
 				sz_push_full_space(sz, sz->buf_in[i]);
 			}
@@ -264,32 +226,65 @@ static void streamzap_callback(struct urb *urb)
 	}
 
 	ir_raw_event_handle(sz->rdev);
+}
+
+/*
+ * streamzap_callback - usb IRQ handler callback
+ *
+ * This procedure is invoked on reception of data from
+ * the usb remote.
+ */
+static void streamzap_callback(struct urb *urb)
+{
+	struct streamzap_ir *sz;
+	int len;
+
+	if (!urb)
+		return;
+
+	sz = urb->context;
+	len = urb->actual_length;
+
+	switch (urb->status) {
+	case 0:
+		dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
+		sz_process_ir_data(sz, len);
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/*
+		 * this urb is terminated, clean up.
+		 * sz might already be invalid at this point
+		 */
+		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
+		return;
+	default:
+		break;
+	}
+
 	usb_submit_urb(urb, GFP_ATOMIC);
 
 	return;
 }
 
-static struct rc_dev *streamzap_init_rc_dev(struct streamzap_ir *sz)
+static struct rc_dev *streamzap_init_rc_dev(struct streamzap_ir *sz,
+					    struct usb_device *usbdev)
 {
 	struct rc_dev *rdev;
 	struct device *dev = sz->dev;
 	int ret;
 
 	rdev = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!rdev) {
-		dev_err(dev, "remote dev allocation failed\n");
+	if (!rdev)
 		goto out;
-	}
 
-	snprintf(sz->name, sizeof(sz->name), "Streamzap PC Remote Infrared Receiver (%04x:%04x)",
-		 le16_to_cpu(sz->usbdev->descriptor.idVendor),
-		 le16_to_cpu(sz->usbdev->descriptor.idProduct));
-	usb_make_path(sz->usbdev, sz->phys, sizeof(sz->phys));
+	usb_make_path(usbdev, sz->phys, sizeof(sz->phys));
 	strlcat(sz->phys, "/input0", sizeof(sz->phys));
 
-	rdev->device_name = sz->name;
+	rdev->device_name = "Streamzap PC Remote Infrared Receiver";
 	rdev->input_phys = sz->phys;
-	usb_to_input_id(sz->usbdev, &rdev->input_id);
+	usb_to_input_id(usbdev, &rdev->input_id);
 	rdev->dev.parent = dev;
 	rdev->priv = sz;
 	rdev->allowed_protocols = RC_PROTO_BIT_ALL_IR_DECODER;
@@ -320,9 +315,9 @@ static int streamzap_probe(struct usb_interface *intf,
 			   const struct usb_device_id *id)
 {
 	struct usb_device *usbdev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *endpoint;
 	struct usb_host_interface *iface_host;
 	struct streamzap_ir *sz = NULL;
-	char buf[63], name[128] = "";
 	int retval = -ENOMEM;
 	int pipe, maxp;
 
@@ -331,9 +326,6 @@ static int streamzap_probe(struct usb_interface *intf,
 	if (!sz)
 		return -ENOMEM;
 
-	sz->usbdev = usbdev;
-	sz->interface = intf;
-
 	/* Check to ensure endpoint information matches requirements */
 	iface_host = intf->cur_altsetting;
 
@@ -344,22 +336,22 @@ static int streamzap_probe(struct usb_interface *intf,
 		goto free_sz;
 	}
 
-	sz->endpoint = &(iface_host->endpoint[0].desc);
-	if (!usb_endpoint_dir_in(sz->endpoint)) {
+	endpoint = &iface_host->endpoint[0].desc;
+	if (!usb_endpoint_dir_in(endpoint)) {
 		dev_err(&intf->dev, "%s: endpoint doesn't match input device 02%02x\n",
-			__func__, sz->endpoint->bEndpointAddress);
+			__func__, endpoint->bEndpointAddress);
 		retval = -ENODEV;
 		goto free_sz;
 	}
 
-	if (!usb_endpoint_xfer_int(sz->endpoint)) {
+	if (!usb_endpoint_xfer_int(endpoint)) {
 		dev_err(&intf->dev, "%s: endpoint attributes don't match xfer 02%02x\n",
-			__func__, sz->endpoint->bmAttributes);
+			__func__, endpoint->bmAttributes);
 		retval = -ENODEV;
 		goto free_sz;
 	}
 
-	pipe = usb_rcvintpipe(usbdev, sz->endpoint->bEndpointAddress);
+	pipe = usb_rcvintpipe(usbdev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(usbdev, pipe, usb_pipeout(pipe));
 
 	if (maxp == 0) {
@@ -381,25 +373,13 @@ static int streamzap_probe(struct usb_interface *intf,
 	sz->dev = &intf->dev;
 	sz->buf_in_len = maxp;
 
-	if (usbdev->descriptor.iManufacturer
-	    && usb_string(usbdev, usbdev->descriptor.iManufacturer,
-			  buf, sizeof(buf)) > 0)
-		strscpy(name, buf, sizeof(name));
-
-	if (usbdev->descriptor.iProduct
-	    && usb_string(usbdev, usbdev->descriptor.iProduct,
-			  buf, sizeof(buf)) > 0)
-		snprintf(name + strlen(name), sizeof(name) - strlen(name),
-			 " %s", buf);
-
-	sz->rdev = streamzap_init_rc_dev(sz);
+	sz->rdev = streamzap_init_rc_dev(sz, usbdev);
 	if (!sz->rdev)
 		goto rc_dev_fail;
 
 	sz->idle = true;
 	sz->decoder_state = PulseSpace;
 	/* FIXME: don't yet have a way to set this */
-	sz->timeout_enabled = true;
 	sz->rdev->timeout = SZ_TIMEOUT * SZ_RESOLUTION;
 	#if 0
 	/* not yet supported, depends on patches from maxim */
@@ -412,8 +392,7 @@ static int streamzap_probe(struct usb_interface *intf,
 
 	/* Complete final initialisations */
 	usb_fill_int_urb(sz->urb_in, usbdev, pipe, sz->buf_in,
-			 maxp, (usb_complete_t)streamzap_callback,
-			 sz, sz->endpoint->bInterval);
+			 maxp, streamzap_callback, sz, endpoint->bInterval);
 	sz->urb_in->transfer_dma = sz->dma_in;
 	sz->urb_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
@@ -422,9 +401,6 @@ static int streamzap_probe(struct usb_interface *intf,
 	if (usb_submit_urb(sz->urb_in, GFP_ATOMIC))
 		dev_err(sz->dev, "urb submit failed\n");
 
-	dev_info(sz->dev, "Registered %s on usb%d:%d\n", name,
-		 usbdev->bus->busnum, usbdev->devnum);
-
 	return 0;
 
 rc_dev_fail:
@@ -457,9 +433,8 @@ static void streamzap_disconnect(struct usb_interface *interface)
 	if (!sz)
 		return;
 
-	sz->usbdev = NULL;
-	rc_unregister_device(sz->rdev);
 	usb_kill_urb(sz->urb_in);
+	rc_unregister_device(sz->rdev);
 	usb_free_urb(sz->urb_in);
 	usb_free_coherent(usbdev, sz->buf_in_len, sz->buf_in, sz->dma_in);
 
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index a24624353f9e..2f95d7050097 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1326,9 +1326,6 @@ static int vim2m_probe(struct platform_device *pdev)
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1355,6 +1352,9 @@ static int vim2m_probe(struct platform_device *pdev)
 		goto error_m2m;
 	}
 
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_SCALER);
diff --git a/drivers/media/v4l2-core/v4l2-dv-timings.c b/drivers/media/v4l2-core/v4l2-dv-timings.c
index 2cf5dcee0ce8..4d05873892c1 100644
--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -764,7 +764,7 @@ bool v4l2_detect_gtf(unsigned int frame_height,
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_D_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_D_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_D_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_D_C_PRIME) + GTF_D_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
@@ -774,7 +774,7 @@ bool v4l2_detect_gtf(unsigned int frame_height,
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_S_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_S_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_S_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_S_C_PRIME) + GTF_S_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 1c32ff586816..148b2c0523ee 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -162,7 +162,7 @@ static int kb3930_probe(struct i2c_client *client)
 			devm_gpiod_get_array_optional(dev, "off", GPIOD_IN);
 		if (IS_ERR(ddata->off_gpios))
 			return PTR_ERR(ddata->off_gpios);
-		if (ddata->off_gpios->ndescs < 2) {
+		if (ddata->off_gpios && ddata->off_gpios->ndescs < 2) {
 			dev_err(dev, "invalid off-gpios property\n");
 			return -EINVAL;
 		}
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index dfe272fe6f7e..8aaab87b5054 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,7 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
 /*
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 31012ea4c01a..e6d55511de47 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -123,6 +123,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index cdb9a55a2c70..7ea1ac3fc65f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -246,7 +246,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return true;
 
 fail:
-	switch (irq_type) {
+	switch (test->irq_type) {
 	case IRQ_TYPE_LEGACY:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
@@ -263,6 +263,9 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return false;
 }
 
@@ -715,6 +718,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
+	irq_type = test->irq_type;
 	return true;
 
 err:
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index a0d6c00e7b85..76e0c28cb7f4 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -482,10 +482,11 @@ static inline u16 INFTL_findwriteunit(struct INFTLrecord *inftl, unsigned block)
 		silly = MAX_LOOPS;
 
 		while (thisEUN <= inftl->lastEUN) {
-			inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
-				       blockofs, 8, &retlen, (char *)&bci);
-
-			status = bci.Status | bci.Status1;
+			if (inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
+				       blockofs, 8, &retlen, (char *)&bci) < 0)
+				status = SECTOR_IGNORE;
+			else
+				status = bci.Status | bci.Status1;
 			pr_debug("INFTL: status of block %d in EUN %d is %x\n",
 					block , writeEUN, status);
 
diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index a3ae8778f6a9..5594a22c0137 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -417,11 +417,11 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	}
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
-	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
-	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->rmmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
+	cxt->usedmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
-	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
 	cxt->dev.total_size = mtd->size;
 	/* just support dmesg right now */
@@ -527,9 +527,6 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
 	mtdpstore_flush_removed(cxt);
 
 	unregister_pstore_device(&cxt->dev);
-	kfree(cxt->badmap);
-	kfree(cxt->usedmap);
-	kfree(cxt->rmmap);
 	cxt->mtd = NULL;
 	cxt->index = -1;
 }
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 11d706ff30dd..cb3509051047 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2914,7 +2914,7 @@ static int brcmnand_resume(struct device *dev)
 		brcmnand_save_restore_cs_config(host, 1);
 
 		/* Reset the chip, required by some chips after power-up */
-		nand_reset_op(chip);
+		nand_reset(chip, 0);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index c742354c1b0b..df7bc0d1148e 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -387,6 +387,9 @@ static int r852_wait(struct nand_chip *chip)
 static int r852_ready(struct nand_chip *chip)
 {
 	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
+	if (dev->card_unstable)
+		return 0;
+
 	return !(r852_read_reg(dev, R852_CARD_STA) & R852_CARD_STA_BUSY);
 }
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2fc33019e814..d3428e62bef2 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -686,6 +686,15 @@ static void b53_enable_mib(struct b53_device *dev)
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
 }
 
+static void b53_enable_stp(struct b53_device *dev)
+{
+	u8 gc;
+
+	b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &gc);
+	gc |= GC_RX_BPDU_EN;
+	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
+}
+
 static u16 b53_default_pvid(struct b53_device *dev)
 {
 	if (is5325(dev) || is5365(dev))
@@ -807,6 +816,7 @@ static int b53_switch_reset(struct b53_device *dev)
 	}
 
 	b53_enable_mib(dev);
+	b53_enable_stp(dev);
 
 	return b53_flush_arl(dev, FAST_AGE_STATIC);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4cc60135589d..ebc858087394 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2832,6 +2832,21 @@ static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_stats_clear(chip);
 }
 
+static int mv88e6320_setup_errata(struct mv88e6xxx_chip *chip)
+{
+	u16 dummy;
+	int err;
+
+	/* Workaround for erratum
+	 *   3.3 RGMII timing may be out of spec when transmit delay is enabled
+	 */
+	err = mv88e6xxx_port_hidden_write(chip, 0, 0xf, 0x7, 0xe000);
+	if (err)
+		return err;
+
+	return mv88e6xxx_port_hidden_read(chip, 0, 0xf, 0x7, &dummy);
+}
+
 /* Check if the errata has already been applied. */
 static bool mv88e6390_setup_errata_applied(struct mv88e6xxx_chip *chip)
 {
@@ -4122,6 +4137,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -4154,8 +4170,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -4164,6 +4180,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -4195,8 +4212,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 7080cb6c83e4..0f36319eb311 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2258,6 +2258,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 						   GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
 			ret = -ENOMEM;
+			kvfree(eth_filter->port[i].loc_array);
 			goto free_eth_finfo;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 65cf7035b02d..7593e8b7469c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5405,6 +5405,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 err_register:
 	igc_release_hw_control(adapter);
+	igc_ptp_stop(adapter);
 err_eeprom:
 	if (!igc_check_reset_block(hw))
 		igc_reset_phy(hw);
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 25b238c6a675..d99f597a83be 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -578,8 +578,12 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
  **/
 void igc_ptp_stop(struct igc_adapter *adapter)
 {
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	igc_ptp_suspend(adapter);
 
+	adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	if (adapter->ptp_clock) {
 		ptp_clock_unregister(adapter->ptp_clock);
 		netdev_info(adapter->netdev, "PHC removed\n");
@@ -598,6 +602,9 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	unsigned long flags;
 
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
index 58e27038c947..bbc182e9e535 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
@@ -129,9 +129,8 @@ static void mlx5e_rep_neigh_update(struct work_struct *work)
 							     work);
 	struct mlx5e_neigh_hash_entry *nhe = update_work->nhe;
 	struct neighbour *n = update_work->n;
-	struct mlx5e_encap_entry *e;
+	struct mlx5e_encap_entry *e = NULL;
 	unsigned char ha[ETH_ALEN];
-	struct mlx5e_priv *priv;
 	bool neigh_connected;
 	u8 nud_state, dead;
 
@@ -152,14 +151,12 @@ static void mlx5e_rep_neigh_update(struct work_struct *work)
 
 	trace_mlx5e_rep_neigh_update(nhe, ha, neigh_connected);
 
-	list_for_each_entry(e, &nhe->encap_list, encap_list) {
-		if (!mlx5e_encap_take(e))
-			continue;
+	/* mlx5e_get_next_init_encap() releases previous encap before returning
+	 * the next one.
+	 */
+	while ((e = mlx5e_get_next_init_encap(nhe, e)) != NULL)
+		mlx5e_rep_update_flows(netdev_priv(e->out_dev), e, neigh_connected, ha);
 
-		priv = netdev_priv(e->out_dev);
-		mlx5e_rep_update_flows(priv, e, neigh_connected, ha);
-		mlx5e_encap_put(priv, e);
-	}
 	rtnl_unlock();
 	mlx5e_release_neigh_update_work(update_work);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
index 2fdea05eec1d..552c07e52682 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
@@ -91,13 +91,9 @@ void mlx5e_rep_update_flows(struct mlx5e_priv *priv,
 
 	ASSERT_RTNL();
 
-	/* wait for encap to be fully initialized */
-	wait_for_completion(&e->res_ready);
-
 	mutex_lock(&esw->offloads.encap_tbl_lock);
 	encap_connected = !!(e->flags & MLX5_ENCAP_ENTRY_VALID);
-	if (e->compl_result < 0 || (encap_connected == neigh_connected &&
-				    ether_addr_equal(e->h_dest, ha)))
+	if (encap_connected == neigh_connected && ether_addr_equal(e->h_dest, ha))
 		goto unlock;
 
 	mlx5e_take_all_encap_flows(e, &flow_list);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index c6a81a51530d..6b4e028de9bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1653,9 +1653,12 @@ void mlx5e_put_encap_flow_list(struct mlx5e_priv *priv, struct list_head *flow_l
 		mlx5e_flow_put(priv, flow);
 }
 
+typedef bool (match_cb)(struct mlx5e_encap_entry *);
+
 static struct mlx5e_encap_entry *
-mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
-			   struct mlx5e_encap_entry *e)
+mlx5e_get_next_matching_encap(struct mlx5e_neigh_hash_entry *nhe,
+			   struct mlx5e_encap_entry *e,
+			   match_cb match)
 {
 	struct mlx5e_encap_entry *next = NULL;
 
@@ -1690,7 +1693,7 @@ mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
 	/* wait for encap to be fully initialized */
 	wait_for_completion(&next->res_ready);
 	/* continue searching if encap entry is not in valid state after completion */
-	if (!(next->flags & MLX5_ENCAP_ENTRY_VALID)) {
+	if (!match(next)) {
 		e = next;
 		goto retry;
 	}
@@ -1698,6 +1701,30 @@ mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
 	return next;
 }
 
+static bool mlx5e_encap_valid(struct mlx5e_encap_entry *e)
+{
+	return e->flags & MLX5_ENCAP_ENTRY_VALID;
+}
+
+static struct mlx5e_encap_entry *
+mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
+			   struct mlx5e_encap_entry *e)
+{
+	return mlx5e_get_next_matching_encap(nhe, e, mlx5e_encap_valid);
+}
+
+static bool mlx5e_encap_initialized(struct mlx5e_encap_entry *e)
+{
+	return e->compl_result >= 0;
+}
+
+struct mlx5e_encap_entry *
+mlx5e_get_next_init_encap(struct mlx5e_neigh_hash_entry *nhe,
+			  struct mlx5e_encap_entry *e)
+{
+	return mlx5e_get_next_matching_encap(nhe, e, mlx5e_encap_initialized);
+}
+
 void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 {
 	struct mlx5e_neigh *m_neigh = &nhe->m_neigh;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index 4a2ce241522e..e7e5f0c080fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -161,6 +161,9 @@ void mlx5e_take_all_encap_flows(struct mlx5e_encap_entry *e, struct list_head *f
 void mlx5e_put_encap_flow_list(struct mlx5e_priv *priv, struct list_head *flow_list);
 
 struct mlx5e_neigh_hash_entry;
+struct mlx5e_encap_entry *
+mlx5e_get_next_init_encap(struct mlx5e_neigh_hash_entry *nhe,
+			  struct mlx5e_encap_entry *e);
 void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe);
 
 void mlx5e_tc_reoffload_flows_work(struct work_struct *work);
diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index 59a94e07e7c5..ae28aa2f9a39 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -91,9 +91,8 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (!phy->phy_num_led_triggers)
 		return 0;
 
-	phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
-					     sizeof(*phy->led_link_trigger),
-					     GFP_KERNEL);
+	phy->led_link_trigger = kzalloc(sizeof(*phy->led_link_trigger),
+					GFP_KERNEL);
 	if (!phy->led_link_trigger) {
 		err = -ENOMEM;
 		goto out_clear;
@@ -108,10 +107,9 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (err)
 		goto out_free_link;
 
-	phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
-					    phy->phy_num_led_triggers,
-					    sizeof(struct phy_led_trigger),
-					    GFP_KERNEL);
+	phy->phy_led_triggers = kcalloc(phy->phy_num_led_triggers,
+					sizeof(struct phy_led_trigger),
+					GFP_KERNEL);
 	if (!phy->phy_led_triggers) {
 		err = -ENOMEM;
 		goto out_unreg_link;
@@ -131,11 +129,11 @@ int phy_led_triggers_register(struct phy_device *phy)
 out_unreg:
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
+	kfree(phy->phy_led_triggers);
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
-	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
+	kfree(phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
 	phy->phy_num_led_triggers = 0;
@@ -149,8 +147,13 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 
 	for (i = 0; i < phy->phy_num_led_triggers; i++)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 
-	if (phy->led_link_trigger)
+	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
+		kfree(phy->led_link_trigger);
+		phy->led_link_trigger = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(phy_led_triggers_unregister);
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 717431636275..11725cab4912 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -517,6 +517,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 	unsigned char *data;
 	int islcp;
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3)) {
+		kfree_skb(skb);
+		return NULL;
+	}
 	data  = skb->data;
 	proto = get_unaligned_be16(data);
 
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 9d1b0890f310..418e40560f59 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2649,9 +2650,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	netif_napi_del(&ar->napi);
 
-	ath10k_core_destroy(ar);
-
 	destroy_workqueue(ar_sdio->workqueue);
+
+	ath10k_core_destroy(ar);
 }
 
 static const struct sdio_device_id ath10k_sdio_devices[] = {
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 404257800033..706de33d0ed4 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2553,7 +2553,7 @@ static void at76_disconnect(struct usb_interface *interface)
 
 	wiphy_info(priv->hw->wiphy, "disconnecting\n");
 	at76_delete_device(priv);
-	usb_put_dev(priv->udev);
+	usb_put_dev(interface_to_usbdev(interface));
 	dev_info(&interface->dev, "disconnected\n");
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 4e003c7b62cf..82a193aac09d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -21,6 +21,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index 98cd39619d57..5771f61392ef 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -342,8 +342,10 @@ void wl1251_tx_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&wl->tx_queue))) {
 		if (!woken_up) {
 			ret = wl1251_ps_elp_wakeup(wl);
-			if (ret < 0)
+			if (ret < 0) {
+				skb_queue_head(&wl->tx_queue, skb);
 				goto out;
+			}
 			woken_up = true;
 		}
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 99711dd0b6e8..d39fc55f8b0c 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
 static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 				       unsigned char *mw_cnt)
 {
-	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
+	struct idt_mw_cfg *mws;
 	const struct idt_ntb_bar *bars;
 	enum idt_mw_type mw_type;
 	unsigned char widx, bidx, en_cnt;
@@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	int aprt_size;
 	u32 data;
 
+	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
+			   sizeof(*mws), GFP_KERNEL);
+	if (!mws)
+		return ERR_PTR(-ENOMEM);
+
 	/* Retrieve the array of the BARs registers */
 	bars = portdata_tbl[port].bars;
 
@@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 		}
 	}
 
-	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
-			       GFP_KERNEL);
-	if (!ret_mws)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy the info of detected memory windows */
-	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
-
-	return ret_mws;
+	return mws;
 }
 
 /*
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 859570017ef3..17ae14002439 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1340,7 +1340,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (nt->use_msi) {
 		qp_count -= 1;
-		nt->msi_db_mask = 1 << qp_count;
+		nt->msi_db_mask = BIT_ULL(qp_count);
 		ntb_db_clear_mask(ndev, nt->msi_db_mask);
 	}
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5f16fc9111a9..b19fba64beb0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -850,6 +850,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
 		else
 			kfree(page_address(page) + req->special_vec.bv_offset);
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
@@ -4265,6 +4266,15 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else if (ctrl->ana_log_buf)
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 846fb41da643..321859753ae8 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -169,20 +169,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index f2c5136bf2b8..f1aaabc5bec7 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -478,7 +478,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (targetport) {
 		tport = targetport->private;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		schedule_work(&tport->ls_work);
 	}
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index ddb3ed0483d9..5c4254ab5d83 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -36,11 +36,15 @@
 unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 {
 	struct of_phandle_args oirq;
+	unsigned int ret;
 
 	if (of_irq_parse_one(dev, index, &oirq))
 		return 0;
 
-	return irq_create_of_mapping(&oirq);
+	ret = irq_create_of_mapping(&oirq);
+	of_node_put(oirq.np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
@@ -443,8 +447,10 @@ int of_irq_count(struct device_node *dev)
 	struct of_phandle_args irq;
 	int nr = 0;
 
-	while (of_irq_parse_one(dev, nr, &irq) == 0)
+	while (of_irq_parse_one(dev, nr, &irq) == 0) {
+		of_node_put(irq.np);
 		nr++;
+	}
 
 	return nr;
 }
@@ -549,6 +555,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 						desc->interrupt_parent);
 			if (ret) {
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -579,6 +587,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index be6af5585dd6..bbc9786bc36c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1215,7 +1215,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node, *msi_np;
+	struct device_node *np = pdev->dev.of_node;
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
@@ -1280,9 +1280,14 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
 
-	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
-	if (pci_msi_enabled() && msi_np == pcie->np) {
-		ret = brcm_pcie_enable_msi(pcie);
+	if (pci_msi_enabled()) {
+		struct device_node *msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
+
+		if (msi_np == pcie->np)
+			ret = brcm_pcie_enable_msi(pcie);
+
+		of_node_put(msi_np);
+
 		if (ret) {
 			dev_err(pcie->dev, "probe of internal MSI failed");
 			goto fail;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d4585b07de3..24916e78c507 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6467,60 +6467,70 @@ static void pci_no_domains(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-static atomic_t __domain_nr = ATOMIC_INIT(-1);
+static DEFINE_IDA(pci_domain_nr_static_ida);
+static DEFINE_IDA(pci_domain_nr_dynamic_ida);
 
-static int pci_get_new_domain_nr(void)
+static void of_pci_reserve_static_domain_nr(void)
 {
-	return atomic_inc_return(&__domain_nr);
+	struct device_node *np;
+	int domain_nr;
+
+	for_each_node_by_type(np, "pci") {
+		domain_nr = of_get_pci_domain_nr(np);
+		if (domain_nr < 0)
+			continue;
+		/*
+		 * Permanently allocate domain_nr in dynamic_ida
+		 * to prevent it from dynamic allocation.
+		 */
+		ida_alloc_range(&pci_domain_nr_dynamic_ida,
+				domain_nr, domain_nr, GFP_KERNEL);
+	}
 }
 
 static int of_pci_bus_find_domain_nr(struct device *parent)
 {
-	static int use_dt_domains = -1;
-	int domain = -1;
+	static bool static_domains_reserved = false;
+	int domain_nr;
 
-	if (parent)
-		domain = of_get_pci_domain_nr(parent->of_node);
+	/* On the first call scan device tree for static allocations. */
+	if (!static_domains_reserved) {
+		of_pci_reserve_static_domain_nr();
+		static_domains_reserved = true;
+	}
+
+	if (parent) {
+		/*
+		 * If domain is in DT, allocate it in static IDA.  This
+		 * prevents duplicate static allocations in case of errors
+		 * in DT.
+		 */
+		domain_nr = of_get_pci_domain_nr(parent->of_node);
+		if (domain_nr >= 0)
+			return ida_alloc_range(&pci_domain_nr_static_ida,
+					       domain_nr, domain_nr,
+					       GFP_KERNEL);
+	}
 
 	/*
-	 * Check DT domain and use_dt_domains values.
-	 *
-	 * If DT domain property is valid (domain >= 0) and
-	 * use_dt_domains != 0, the DT assignment is valid since this means
-	 * we have not previously allocated a domain number by using
-	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
-	 * 1, to indicate that we have just assigned a domain number from
-	 * DT.
-	 *
-	 * If DT domain property value is not valid (ie domain < 0), and we
-	 * have not previously assigned a domain number from DT
-	 * (use_dt_domains != 1) we should assign a domain number by
-	 * using the:
-	 *
-	 * pci_get_new_domain_nr()
-	 *
-	 * API and update the use_dt_domains value to keep track of method we
-	 * are using to assign domain numbers (use_dt_domains = 0).
-	 *
-	 * All other combinations imply we have a platform that is trying
-	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
-	 * which is a recipe for domain mishandling and it is prevented by
-	 * invalidating the domain value (domain = -1) and printing a
-	 * corresponding error.
+	 * If domain was not specified in DT, choose a free ID from dynamic
+	 * allocations. All domain numbers from DT are permanently in
+	 * dynamic allocations to prevent assigning them to other DT nodes
+	 * without static domain.
 	 */
-	if (domain >= 0 && use_dt_domains) {
-		use_dt_domains = 1;
-	} else if (domain < 0 && use_dt_domains != 1) {
-		use_dt_domains = 0;
-		domain = pci_get_new_domain_nr();
-	} else {
-		if (parent)
-			pr_err("Node %pOF has ", parent->of_node);
-		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
-		domain = -1;
-	}
+	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
+}
 
-	return domain;
+static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	if (bus->domain_nr < 0)
+		return;
+
+	/* Release domain from IDA where it was allocated. */
+	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
+		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
+	else
+		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
 }
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
@@ -6528,6 +6538,13 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
 			       acpi_pci_bus_find_domain_nr(bus);
 }
+
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	if (!acpi_disabled)
+		return;
+	of_pci_bus_release_domain_nr(bus, parent);
+}
 #endif
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 84edae9ba2e6..7f3d10957eca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -595,6 +595,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 
 	device_initialize(&bridge->dev);
 }
@@ -877,11 +878,12 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
-	struct resource_entry *window, *n;
+	struct resource_entry *window, *next, *n;
 	struct pci_bus *bus, *b;
-	resource_size_t offset;
+	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
-	struct resource *res;
+	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -899,7 +901,14 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+	else
+		bus->domain_nr = bridge->domain_nr;
+	if (bus->domain_nr < 0) {
+		err = bus->domain_nr;
+		goto free;
+	}
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
@@ -936,6 +945,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
+	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -958,11 +968,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Coalesce contiguous windows */
+	resource_list_for_each_entry_safe(window, n, &resources) {
+		if (list_is_last(&window->node, &resources))
+			break;
+
+		next = list_next_entry(window, node);
+		offset = window->offset;
+		res = window->res;
+		next_offset = next->offset;
+		next_res = next->res;
+
+		if (res->flags != next_res->flags || offset != next_offset)
+			continue;
+
+		if (res->end + 1 == next_res->start) {
+			next_res->start = res->start;
+			res->flags = res->start = res->end = 0;
+		}
+	}
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
-		list_move_tail(&window->node, &bridge->windows);
 		offset = window->offset;
 		res = window->res;
+		if (!res->end)
+			continue;
+
+		list_move_tail(&window->node, &bridge->windows);
 
 		if (res->flags & IORESOURCE_BUS)
 			pci_bus_insert_busn_res(bus, bus->number, res->end);
@@ -993,9 +1026,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
-
 free:
-	kfree(bus);
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	pci_bus_release_domain_nr(bus, parent);
+#endif
+	if (bus_registered)
+		put_device(&bus->dev);
+	else
+		kfree(bus);
+
 	return err;
 }
 
@@ -1105,7 +1144,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 95dec03d9f2a..fb69debd5e8d 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -156,6 +156,13 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	list_for_each_entry_safe(child, tmp,
 				 &bus->devices, bus_list)
 		pci_remove_bus_device(child);
+
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	/* Release domain_nr if it was dynamically allocated */
+	if (host_bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
+#endif
+
 	pci_remove_bus(bus);
 	host_bridge->bus = NULL;
 
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7fd11ef5cb8a..8568b5a78c45 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -338,12 +338,10 @@ armpmu_add(struct perf_event *event, int flags)
 	if (idx < 0)
 		return idx;
 
-	/*
-	 * If there is an event in the counter we are going to use then make
-	 * sure it is disabled.
-	 */
+	/* The newly-allocated counter should be empty */
+	WARN_ON_ONCE(hw_events->events[idx]);
+
 	event->hw.idx = idx;
-	armpmu->disable(event);
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 856397def89a..8bd8d1f8eba2 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -449,7 +449,7 @@ tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
 	name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
 	if (!name) {
 		of_node_put(ports);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	np = of_get_child_by_name(ports, name);
 	kfree(name);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 37526aa1fb2c..ad52846b6beb 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -955,8 +955,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g;
 	unsigned long flags;
-	bool was_enabled;
-	u32 val;
+	u32 val, oldval;
 
 	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
 		set_bit(d->hwirq, pctrl->dual_edge_irqs);
@@ -1016,8 +1015,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	 * internal circuitry of TLMM, toggling the RAW_STATUS
 	 * could cause the INTR_STATUS to be set for EDGE interrupts.
 	 */
-	val = msm_readl_intr_cfg(pctrl, g);
-	was_enabled = val & BIT(g->intr_raw_status_bit);
+	val = oldval = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
 	if (g->intr_detection_width == 2) {
 		val &= ~(3 << g->intr_detection_bit);
@@ -1070,9 +1068,11 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	/*
 	 * The first time we set RAW_STATUS_EN it could trigger an interrupt.
 	 * Clear the interrupt.  This is safe because we have
-	 * IRQCHIP_SET_TYPE_MASKED.
+	 * IRQCHIP_SET_TYPE_MASKED. When changing the interrupt type, we could
+	 * also still have a non-matching interrupt latched, so clear whenever
+	 * making changes to the interrupt configuration.
 	 */
-	if (!was_enabled)
+	if (val != oldval)
 		msm_ack_intr_status(pctrl, g);
 
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 0edafe687fa9..b1084c4bc9da 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -427,11 +427,14 @@ static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
 
 static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
 {
+	unsigned long long val = (unsigned long long)curr;
+	acpi_status status;
 	int i, delta;
-	unsigned long long val;
-	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
-		acpi_evaluate_integer(asus->handle, method, NULL, &val);
 
+	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
+		status = acpi_evaluate_integer(asus->handle, method, NULL, &val);
+		if (ACPI_FAILURE(status))
+			continue;
 		/* The output is noisy.  From reading the ASL
 		 * dissassembly, timeout errors are returned with 1's
 		 * in the high word, and the lack of locking around
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 407afafc7e83..e0f7368e7e3e 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -77,7 +77,7 @@ static DECLARE_HASHTABLE(isst_hash, 8);
 static DEFINE_MUTEX(isst_hash_lock);
 
 static int isst_store_new_cmd(int cmd, u32 cpu, int mbox_cmd_type, u32 param,
-			      u32 data)
+			      u64 data)
 {
 	struct isst_cmd *sst_cmd;
 
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 59272a920479..8221f286f582 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -123,6 +123,9 @@ static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
 	unsigned long long exval;
 
 	rate = clk_get_rate(fpc->clk[fpc->period.clk_select]);
+	if (rate >> fpc->period.clk_ps == 0)
+		return 0;
+
 	exval = ticks;
 	exval *= 1000000000UL;
 	do_div(exval, rate >> fpc->period.clk_ps);
@@ -195,6 +198,9 @@ static unsigned int fsl_pwm_calculate_duty(struct fsl_pwm_chip *fpc,
 	unsigned int period = fpc->period.mod_period + 1;
 	unsigned int period_ns = fsl_pwm_ticks_to_ns(fpc, period);
 
+	if (!period_ns)
+		return 0;
+
 	duty = (unsigned long long)duty_ns * period;
 	do_div(duty, period_ns);
 
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ab001ce55178..f2cb5e0347e3 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -30,12 +30,14 @@
 #define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
 #define PWM45THRES_FIXUP	0x34
+#define PWM_CK_26M_SEL		0x210
 
 #define PWM_CLK_DIV_MAX		7
 
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
+	bool has_ck_26m_sel;
 };
 
 /**
@@ -124,17 +126,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
 
+	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
+	/* Make sure we use the bus clock and not the 26MHz clock */
+	if (pc->soc->has_ck_26m_sel)
+		writel(0, pc->regs + PWM_CK_26M_SEL);
+
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
@@ -281,31 +291,37 @@ static int pwm_mediatek_remove(struct platform_device *pdev)
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = true,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = true,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 	.num_pwms = 1,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = true,
 };
 
 static const struct of_device_id pwm_mediatek_of_match[] = {
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 7ab9eb6616d9..83da73895407 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -8,6 +8,7 @@
  * - The hardware cannot generate a 0% duty cycle.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -103,23 +104,24 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
-				int period_ns)
+static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
+				u64 period_ns)
 {
-	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
+	unsigned long long tmp;
 	unsigned long clk_rate = clk_get_rate(rp->clk);
 	u32 cyc, ph;
 
-	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
-	do_div(one_cycle, clk_rate);
+	/* div <= 24 == RCAR_PWM_MAX_DIVISION, so the shift doesn't overflow. */
+	tmp = mul_u64_u64_div_u64(period_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_CYC0_MASK);
 
-	tmp = period_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
+	cyc = FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, tmp);
 
-	tmp = duty_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	ph = tmp & RCAR_PWMCNT_PH0_MASK;
+	tmp = mul_u64_u64_div_u64(duty_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_PH0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_PH0_MASK);
+	ph = FIELD_PREP(RCAR_PWMCNT_PH0_MASK, tmp);
 
 	/* Avoid prohibited setting */
 	if (cyc == 0 || ph == 0)
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0b09ed6ac133..a3eddca14cbf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3637,12 +3637,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline = base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	/* check_device will allocate block device if necessary */
@@ -3650,8 +3649,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
 			dev_name(&cdev->dev), discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 68ff233f936e..3ff76ca147a5 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6790,7 +6790,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a16ed0695f1a..3244f30dffec 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -892,6 +892,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
+		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index c636a6d3bdcc..548adbe54444 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3185,11 +3185,14 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 	}
 
 	/* see similar check in iscsi_if_set_param() */
-	if (strlen(data) > ev->u.set_host_param.len)
-		return -EINVAL;
+	if (strlen(data) > ev->u.set_host_param.len) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
+out:
 	scsi_host_put(shost);
 	return err;
 }
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 3b819c6b15a5..465fe83b49e9 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4144,7 +4144,7 @@ static void validate_options(void)
  */
 static int __init st_setup(char *str)
 {
-	int i, len, ints[5];
+	int i, len, ints[ARRAY_SIZE(parms) + 1];
 	char *stp;
 
 	stp = get_options(str, ARRAY_SIZE(ints), ints);
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 05c7347eda18..a7e1b011202b 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -175,6 +175,7 @@ void ufs_bsg_remove(struct ufs_hba *hba)
 		return;
 
 	bsg_remove_queue(hba->bsg_queue);
+	hba->bsg_queue = NULL;
 
 	device_del(bsg_dev);
 	put_device(bsg_dev);
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index fc7f48a92288..5745d7e5908e 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -7,21 +7,19 @@ menuconfig SOC_SAMSUNG
 
 if SOC_SAMSUNG
 
-config EXYNOS_ASV
-	bool "Exynos Adaptive Supply Voltage support" if COMPILE_TEST
-	depends on (ARCH_EXYNOS && EXYNOS_CHIPID) || COMPILE_TEST
-	select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
-
 # There is no need to enable these drivers for ARMv8
 config EXYNOS_ASV_ARM
 	bool "Exynos ASV ARMv7-specific driver extensions" if COMPILE_TEST
-	depends on EXYNOS_ASV
+	depends on EXYNOS_CHIPID
 
 config EXYNOS_CHIPID
-	bool "Exynos Chipid controller driver" if COMPILE_TEST
+	bool "Exynos ChipID controller and ASV driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || COMPILE_TEST
+	select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
 	select MFD_SYSCON
 	select SOC_BUS
+	help
+	  Support for Samsung Exynos SoC ChipID and Adaptive Supply Voltage.
 
 config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 59e8e9453f27..0c523a8de4eb 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_EXYNOS_ASV)	+= exynos-asv.o
 obj-$(CONFIG_EXYNOS_ASV_ARM)	+= exynos5422-asv.o
 
-obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o exynos-asv.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index 5daeadc36382..d60af8acc391 100644
--- a/drivers/soc/samsung/exynos-asv.c
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -2,7 +2,9 @@
 /*
  * Copyright (c) 2019 Samsung Electronics Co., Ltd.
  *	      http://www.samsung.com/
+ * Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
  * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
  *
  * Samsung Exynos SoC Adaptive Supply Voltage support
  */
@@ -10,12 +12,7 @@
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/mfd/syscon.h>
-#include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <linux/soc/samsung/exynos-chipid.h>
@@ -111,7 +108,7 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
 	return	0;
 }
 
-static int exynos_asv_probe(struct platform_device *pdev)
+int exynos_asv_init(struct device *dev, struct regmap *regmap)
 {
 	int (*probe_func)(struct exynos_asv *asv);
 	struct exynos_asv *asv;
@@ -119,21 +116,16 @@ static int exynos_asv_probe(struct platform_device *pdev)
 	u32 product_id = 0;
 	int ret, i;
 
-	asv = devm_kzalloc(&pdev->dev, sizeof(*asv), GFP_KERNEL);
+	asv = devm_kzalloc(dev, sizeof(*asv), GFP_KERNEL);
 	if (!asv)
 		return -ENOMEM;
 
-	asv->chipid_regmap = device_node_to_regmap(pdev->dev.of_node);
-	if (IS_ERR(asv->chipid_regmap)) {
-		dev_err(&pdev->dev, "Could not find syscon regmap\n");
-		return PTR_ERR(asv->chipid_regmap);
-	}
-
+	asv->chipid_regmap = regmap;
+	asv->dev = dev;
 	ret = regmap_read(asv->chipid_regmap, EXYNOS_CHIPID_REG_PRO_ID,
 			  &product_id);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Cannot read revision from ChipID: %d\n",
-			ret);
+		dev_err(dev, "Cannot read revision from ChipID: %d\n", ret);
 		return -ENODEV;
 	}
 
@@ -142,7 +134,9 @@ static int exynos_asv_probe(struct platform_device *pdev)
 		probe_func = exynos5422_asv_init;
 		break;
 	default:
-		return -ENODEV;
+		dev_dbg(dev, "No ASV support for this SoC\n");
+		devm_kfree(dev, asv);
+		return 0;
 	}
 
 	cpu_dev = get_cpu_device(0);
@@ -150,14 +144,11 @@ static int exynos_asv_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return -EPROBE_DEFER;
 
-	ret = of_property_read_u32(pdev->dev.of_node, "samsung,asv-bin",
+	ret = of_property_read_u32(dev->of_node, "samsung,asv-bin",
 				   &asv->of_bin);
 	if (ret < 0)
 		asv->of_bin = -EINVAL;
 
-	asv->dev = &pdev->dev;
-	dev_set_drvdata(&pdev->dev, asv);
-
 	for (i = 0; i < ARRAY_SIZE(asv->subsys); i++)
 		asv->subsys[i].asv = asv;
 
@@ -167,17 +158,3 @@ static int exynos_asv_probe(struct platform_device *pdev)
 
 	return exynos_asv_update_opps(asv);
 }
-
-static const struct of_device_id exynos_asv_of_device_ids[] = {
-	{ .compatible = "samsung,exynos4210-chipid" },
-	{}
-};
-
-static struct platform_driver exynos_asv_driver = {
-	.driver = {
-		.name = "exynos-asv",
-		.of_match_table = exynos_asv_of_device_ids,
-	},
-	.probe	= exynos_asv_probe,
-};
-module_platform_driver(exynos_asv_driver);
diff --git a/drivers/soc/samsung/exynos-asv.h b/drivers/soc/samsung/exynos-asv.h
index 3fd1f2acd999..dcbe154db31e 100644
--- a/drivers/soc/samsung/exynos-asv.h
+++ b/drivers/soc/samsung/exynos-asv.h
@@ -68,4 +68,6 @@ static inline u32 exynos_asv_opp_get_frequency(const struct exynos_asv_subsys *s
 	return __asv_get_table_entry(&subsys->table, level, 0);
 }
 
+int exynos_asv_init(struct device *dev, struct regmap *regmap);
+
 #endif /* __LINUX_SOC_EXYNOS_ASV_H */
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 8d4d05086906..e52f907fe7d0 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -2,20 +2,40 @@
 /*
  * Copyright (c) 2019 Samsung Electronics Co., Ltd.
  *	      http://www.samsung.com/
+ * Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
  *
  * Exynos - CHIP ID support
  * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
  * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * Samsung Exynos SoC Adaptive Supply Voltage and Chip ID support
  */
 
-#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/soc/samsung/exynos-chipid.h>
 #include <linux/sys_soc.h>
 
+#include "exynos-asv.h"
+
+struct exynos_chipid_variant {
+	unsigned int rev_reg;		/* revision register offset */
+	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
+	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
+};
+
+struct exynos_chipid_info {
+	u32 product_id;
+	u32 revision;
+};
+
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -35,45 +55,64 @@ static const struct exynos_soc_id {
 	{ "EXYNOS5433", 0xE5433000 },
 };
 
-static const char * __init product_id_to_soc_id(unsigned int product_id)
+static const char *product_id_to_soc_id(unsigned int product_id)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
-		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+		if (product_id == soc_ids[i].id)
 			return soc_ids[i].name;
 	return NULL;
 }
 
-static int __init exynos_chipid_early_init(void)
+static int exynos_chipid_get_chipid_info(struct regmap *regmap,
+		const struct exynos_chipid_variant *data,
+		struct exynos_chipid_info *soc_info)
 {
+	int ret;
+	unsigned int val, main_rev, sub_rev;
+
+	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
+	if (ret < 0)
+		return ret;
+	soc_info->product_id = val & EXYNOS_MASK;
+
+	if (data->rev_reg != EXYNOS_CHIPID_REG_PRO_ID) {
+		ret = regmap_read(regmap, data->rev_reg, &val);
+		if (ret < 0)
+			return ret;
+	}
+	main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
+	sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
+	soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
+
+	return 0;
+}
+
+static int exynos_chipid_probe(struct platform_device *pdev)
+{
+	const struct exynos_chipid_variant *drv_data;
+	struct exynos_chipid_info soc_info;
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device_node *root;
-	struct device_node *syscon;
 	struct regmap *regmap;
-	u32 product_id;
-	u32 revision;
 	int ret;
 
-	syscon = of_find_compatible_node(NULL, NULL,
-					 "samsung,exynos4210-chipid");
-	if (!syscon)
-		return -ENODEV;
-
-	regmap = device_node_to_regmap(syscon);
-	of_node_put(syscon);
+	drv_data = of_device_get_match_data(&pdev->dev);
+	if (!drv_data)
+		return -EINVAL;
 
+	regmap = device_node_to_regmap(pdev->dev.of_node);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
+	ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
 	if (ret < 0)
 		return ret;
 
-	revision = product_id & EXYNOS_REV_MASK;
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -83,31 +122,67 @@ static int __init exynos_chipid_early_init(void)
 	of_property_read_string(root, "model", &soc_dev_attr->machine);
 	of_node_put(root);
 
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
-	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"%x", soc_info.revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	/* please note that the actual registration will be deferred */
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	ret = exynos_asv_init(&pdev->dev, regmap);
+	if (ret)
 		goto err;
-	}
 
-	/* it is too early to use dev_info() here (soc_dev is NULL) */
-	pr_info("soc soc0: Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
-		soc_dev_attr->soc_id, product_id, revision);
+	platform_set_drvdata(pdev, soc_dev);
+
+	dev_info(&pdev->dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+		 soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
 
 	return 0;
 
 err:
-	kfree(soc_dev_attr->revision);
-	kfree(soc_dev_attr);
+	soc_device_unregister(soc_dev);
+
 	return ret;
 }
 
-early_initcall(exynos_chipid_early_init);
+static int exynos_chipid_remove(struct platform_device *pdev)
+{
+	struct soc_device *soc_dev = platform_get_drvdata(pdev);
+
+	soc_device_unregister(soc_dev);
+
+	return 0;
+}
+
+static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
+	.rev_reg	= 0x0,
+	.main_rev_shift	= 4,
+	.sub_rev_shift	= 0,
+};
+
+static const struct of_device_id exynos_chipid_of_device_ids[] = {
+	{
+		.compatible	= "samsung,exynos4210-chipid",
+		.data		= &exynos4210_chipid_drv_data,
+	},
+	{ }
+};
+
+static struct platform_driver exynos_chipid_driver = {
+	.driver = {
+		.name = "exynos-chipid",
+		.of_match_table = exynos_chipid_of_device_ids,
+	},
+	.probe	= exynos_chipid_probe,
+	.remove	= exynos_chipid_remove,
+};
+builtin_platform_driver(exynos_chipid_driver);
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 4a782bfd753c..2ce8a8f4f005 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -381,6 +381,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	data = prm->data;
 	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
 
 	prmd->dev = dev;
 	prmd->prm = prm;
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 23d50a19ae27..8b31aaa1d0f1 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1120,6 +1120,12 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	if (IS_ERR(cqspi->rx_chan)) {
 		int ret = PTR_ERR(cqspi->rx_chan);
 		cqspi->rx_chan = NULL;
+		if (ret == -ENODEV) {
+			/* DMA support is not mandatory */
+			dev_info(&cqspi->pdev->dev, "No Rx DMA available\n");
+			return 0;
+		}
+
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
 	init_completion(&cqspi->rx_dma_complete);
diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
index 7a02c4fa3cda..cc1232609f32 100644
--- a/drivers/staging/comedi/drivers/jr3_pci.c
+++ b/drivers/staging/comedi/drivers/jr3_pci.c
@@ -88,6 +88,7 @@ struct jr3_pci_poll_delay {
 struct jr3_pci_dev_private {
 	struct timer_list timer;
 	struct comedi_device *dev;
+	bool timer_enable;
 };
 
 union jr3_pci_single_range {
@@ -612,10 +613,11 @@ static void jr3_pci_poll_dev(struct timer_list *t)
 				delay = sub_delay.max;
 		}
 	}
+	if (devpriv->timer_enable) {
+		devpriv->timer.expires = jiffies + msecs_to_jiffies(delay);
+		add_timer(&devpriv->timer);
+	}
 	spin_unlock_irqrestore(&dev->spinlock, flags);
-
-	devpriv->timer.expires = jiffies + msecs_to_jiffies(delay);
-	add_timer(&devpriv->timer);
 }
 
 static struct jr3_pci_subdev_private *
@@ -764,6 +766,7 @@ static int jr3_pci_auto_attach(struct comedi_device *dev,
 	devpriv->dev = dev;
 	timer_setup(&devpriv->timer, jr3_pci_poll_dev, 0);
 	devpriv->timer.expires = jiffies + msecs_to_jiffies(1000);
+	devpriv->timer_enable = true;
 	add_timer(&devpriv->timer);
 
 	return 0;
@@ -773,8 +776,12 @@ static void jr3_pci_detach(struct comedi_device *dev)
 {
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
-	if (devpriv)
+	if (devpriv) {
+		spin_lock_bh(&dev->spinlock);
+		devpriv->timer_enable = false;
+		spin_unlock_bh(&dev->spinlock);
 		del_timer_sync(&devpriv->timer);
+	}
 
 	comedi_pci_detach(dev);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 9531ba54e95b..364e6cd76054 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -826,7 +826,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
+		spin_unlock_bh(&pmlmepriv->lock);
 		del_timer_sync(&pmlmepriv->scan_to_timer);
+		spin_lock_bh(&pmlmepriv->lock);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	} else {
 
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index aa9e0e31ef98..f62ae8b0239c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -363,6 +363,7 @@ static const struct tsadc_table rk3328_code_table[] = {
 	{296, -40000},
 	{304, -35000},
 	{313, -30000},
+	{322, -25000},
 	{331, -20000},
 	{340, -15000},
 	{349, -10000},
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index c234114b5052..34b38795096f 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -596,8 +596,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -605,9 +608,12 @@ static int sifive_serial_startup(struct uart_port *port)
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index eeea892248b5..45b5a909e190 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -1961,6 +1961,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2002,6 +2003,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e21541f80e40..d9936c530874 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -366,6 +366,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
@@ -380,6 +383,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0904, 0x6103), .driver_info =
 			USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL },
 
+	/* Silicon Motion Flash Drive */
+	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
 			USB_QUIRK_ENDPOINT_IGNORE },
@@ -534,6 +540,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* VLI disk */
+	{ USB_DEVICE(0x2109, 0x0711), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Raydium Touchscreen */
 	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 97e6c6fb49df..f3103baa7459 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3896,6 +3896,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d268306a7bfe..92755a2fe4ff 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -543,6 +543,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 44a35629d68c..db1b73486e90 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1956,6 +1956,12 @@ max3421_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id max3421_spi_ids[] = {
+	{ "max3421" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, max3421_spi_ids);
+
 static const struct of_device_id max3421_of_match_table[] = {
 	{ .compatible = "maxim,max3421", },
 	{},
@@ -1965,6 +1971,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = of_match_ptr(max3421_of_match_table),
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 41efe927d8f3..70153ce60128 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -165,6 +165,25 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ohci_quirk_loongson(struct usb_hcd *hcd)
+{
+	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+
+	/*
+	 * Loongson's LS7A OHCI controller (rev 0x02) has a
+	 * flaw. MMIO register with offset 0x60/64 is treated
+	 * as legacy PS2-compatible keyboard/mouse interface.
+	 * Since OHCI only use 4KB BAR resource, LS7A OHCI's
+	 * 32KB BAR is wrapped around (the 2nd 4KB BAR space
+	 * is the same as the 1st 4KB internally). So add 4KB
+	 * offset (0x1000) to the OHCI registers as a quirk.
+	 */
+	if (pdev->revision == 0x2)
+		hcd->regs += SZ_4K;	/* SZ_4K = 0x1000 */
+
+	return 0;
+}
+
 static int ohci_quirk_qemu(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
@@ -224,6 +243,10 @@ static const struct pci_device_id ohci_pci_quirks[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4399),
 		.driver_data = (unsigned long)ohci_quirk_amd700,
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a24),
+		.driver_data = (unsigned long)ohci_quirk_loongson,
+	},
 	{
 		.vendor		= PCI_VENDOR_ID_APPLE,
 		.device		= 0x003f,
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 39d862f25a70..749c8630cd0c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1071,6 +1071,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index f4d729562355..9c95ca876bae 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -435,6 +435,11 @@
 #define LINX_FUTURE_1_PID   0xF44B	/* Linx future device */
 #define LINX_FUTURE_2_PID   0xF44C	/* Linx future device */
 
+/*
+ * Abacus Electrics
+ */
+#define ABACUS_OPTICAL_PROBE_PID	0xf458 /* ABACUS ELECTRICS Optical Probe */
+
 /*
  * Oceanic product ids
  */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2d11cd74d360..99fa4fb56920 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -611,6 +611,7 @@ static void option_instat_callback(struct urb *urb);
 /* Sierra Wireless products */
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
+#define SIERRA_PRODUCT_EM9291			0x90e3
 
 /* UNISOC (Spreadtrum) products */
 #define UNISOC_VENDOR_ID			0x1782
@@ -2432,6 +2433,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 24b8772a345e..bac5ab6377ae 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -101,6 +101,11 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
+/* OWON electronic test and measurement equipment driver */
+#define OWON_IDS()			\
+	{ USB_DEVICE(0x5345, 0x1234) } /* HDS200 oscilloscopes and others */
+DEVICE(owon, OWON_IDS);
+
 /* Siemens USB/MPI adapter */
 #define SIEMENS_IDS()			\
 	{ USB_DEVICE(0x908, 0x0004) }
@@ -135,6 +140,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
+	&owon_device,
 	&siemens_mpi_device,
 	&suunto_device,
 	&vivopay_device,
@@ -154,6 +160,7 @@ static const struct usb_device_id id_table[] = {
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
+	OWON_IDS(),
 	SIEMENS_IDS(),
 	SUUNTO_IDS(),
 	VIVOPAY_IDS(),
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1f8c9b16a0fb..d460d71b4257 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_LUNS),
 
+/* Reported-by: Oliver Neukum <oneukum@suse.com> */
+UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
+		"ADATA",
+		"Portable HDD CH94",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
 UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
 		"Initio Corporation",
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 4615f827cd0c..3259901c4c38 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -165,9 +165,12 @@ static void fill_indir(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mkey, v
 			klm->bcount = cpu_to_be32(klm_bcount(dmr->end - dmr->start));
 			preve = dmr->end;
 		} else {
+			u64 bcount = min_t(u64, dmr->start - preve, MAX_KLM_SIZE);
+
 			klm->key = cpu_to_be32(mvdev->res.null_mkey);
-			klm->bcount = cpu_to_be32(klm_bcount(dmr->start - preve));
-			preve = dmr->start;
+			klm->bcount = cpu_to_be32(klm_bcount(bcount));
+			preve += bcount;
+
 			goto again;
 		}
 	}
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 57ae8b46b836..7835712f730d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -299,6 +299,19 @@ int vfio_pci_set_power_state(struct vfio_pci_device *vdev, pci_power_t state)
 	if (!ret) {
 		/* D3 might be unsupported via quirk, skip unless in D3 */
 		if (needs_save && pdev->current_state >= PCI_D3hot) {
+			/*
+			 * The current PCI state will be saved locally in
+			 * 'pm_save' during the D3hot transition. When the
+			 * device state is changed to D0 again with the current
+			 * function, then pci_store_saved_state() will restore
+			 * the state and will free the memory pointed by
+			 * 'pm_save'. There are few cases where the PCI power
+			 * state can be changed to D0 without the involvement
+			 * of the driver. For these cases, free the earlier
+			 * allocated memory first before overwriting 'pm_save'
+			 * to prevent the memory leak.
+			 */
+			kfree(vdev->pm_save);
 			vdev->pm_save = pci_store_saved_state(pdev);
 		} else if (needs_restore) {
 			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index f54d256e2d54..1020e4405a4d 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -226,8 +226,11 @@ static int led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 
 	return 0;
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index b2d6e6df2161..d852bef1d507 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -2751,9 +2751,13 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool mem_to_mem)
 {
 	int r;
-	enum omap_overlay_caps caps = dss_feat_get_overlay_caps(plane);
+	enum omap_overlay_caps caps;
 	enum omap_channel channel;
 
+	if (plane == OMAP_DSS_WB)
+		return -EINVAL;
+
+	caps = dss_feat_get_overlay_caps(plane);
 	channel = dispc_ovl_get_channel_out(plane);
 
 	DSSDBG("dispc_ovl_setup %d, pa %pad, pa_uv %pad, sw %d, %d,%d, %dx%d ->"
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index c6c73a33c44d..18bc11756ad3 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -48,7 +48,7 @@ static int xensyms_next_sym(struct xensyms *xs)
 			return -ENOMEM;
 
 		set_xen_guest_handle(symdata->name, xs->name);
-		symdata->symnum--; /* Rewind */
+		symdata->symnum = symnum; /* Rewind */
 
 		ret = HYPERVISOR_platform_op(&xs->op);
 		if (ret < 0)
@@ -78,7 +78,7 @@ static void *xensyms_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct xensyms *xs = (struct xensyms *)m->private;
 
-	xs->op.u.symdata.symnum = ++(*pos);
+	*pos = xs->op.u.symdata.symnum;
 
 	if (xensyms_next_sym(xs))
 		return NULL;
diff --git a/fs/Kconfig b/fs/Kconfig
index 11b60d160f88..b2d01d27d4c3 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -316,6 +316,7 @@ config GRACE_PERIOD
 config LOCKD
 	tristate
 	depends on FILE_LOCKING
+	select CRC32
 	select GRACE_PERIOD
 
 config LOCKD_V4
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 139599c42b73..1c4a7eb488f3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1502,8 +1502,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
 			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	if (!IS_ERR(subvol_name)) {
-		seq_puts(seq, ",subvol=");
-		seq_escape(seq, subvol_name, " \t\n\\");
+		seq_show_option(seq, "subvol", subvol_name);
 		kfree(subvol_name);
 	}
 	return 0;
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 53588d7517b4..11d0eaa603ca 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -183,6 +183,8 @@ static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
 				    tcp_ses_list);
 		list_for_each(tmp, &server->smb_ses_list) {
 			ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each(tmp1, &ses->tcon_list) {
 				tcon = list_entry(tmp1, struct cifs_tcon, tcon_list);
 				spin_lock(&tcon->open_file_lock);
@@ -356,6 +358,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 		list_for_each(tmp2, &server->smb_ses_list) {
 			ses = list_entry(tmp2, struct cifs_ses,
 					 smb_ses_list);
+			if (ses->status == CifsExiting)
+				continue;
 			if ((ses->serverDomain == NULL) ||
 				(ses->serverOS == NULL) ||
 				(ses->serverNOS == NULL)) {
@@ -591,6 +595,8 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
 		list_for_each(tmp2, &server->smb_ses_list) {
 			ses = list_entry(tmp2, struct cifs_ses,
 					 smb_ses_list);
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each(tmp3, &ses->tcon_list) {
 				tcon = list_entry(tmp3,
 						  struct cifs_tcon,
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 92a7628560cc..fab543bb0eaf 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1768,6 +1768,7 @@ static inline bool is_retryable_error(int error)
 #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
 #define   MID_RESPONSE_MALFORMED 0x10
 #define   MID_SHUTDOWN		 0x20
+#define   MID_RESPONSE_READY 0x40 /* ready for other process handle the rsp */
 
 /* Flags */
 #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
@@ -2115,4 +2116,12 @@ static inline struct scatterlist *cifs_sg_set_buf(struct scatterlist *sg,
 	return sg;
 }
 
+static inline bool cifs_ses_exiting(struct cifs_ses *ses)
+{
+	bool ret;
+
+	ret = ses->status == CifsExiting;
+	return ret;
+}
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index ca34cc1e1931..8c0ed2b60285 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -85,7 +85,7 @@ extern struct mid_q_entry *AllocMidQEntry(const struct smb_hdr *smb_buffer,
 					struct TCP_Server_Info *server);
 extern void DeleteMidQEntry(struct mid_q_entry *midEntry);
 extern void cifs_delete_mid(struct mid_q_entry *mid);
-extern void cifs_mid_q_entry_release(struct mid_q_entry *midEntry);
+void _cifs_mid_q_entry_release(struct kref *refcount);
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
@@ -646,4 +646,9 @@ static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
 		return options;
 }
 
+static inline void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
+{
+	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a3c0e6a4e484..2c0522d97e03 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2770,7 +2770,7 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb_vol *volume_info)
 		goto out;
 	}
 
-	cifs_dbg(FYI, "IPC tcon rc = %d ipc tid = %d\n", rc, tcon->tid);
+	cifs_dbg(FYI, "IPC tcon rc=%d ipc tid=0x%x\n", rc, tcon->tid);
 
 	ses->tcon_ipc = tcon;
 out:
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 660e00eb4206..c0b80ba8875a 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -780,7 +780,7 @@ __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
 {
 	struct close_cancelled_open *cancelled;
 
-	cancelled = kzalloc(sizeof(*cancelled), GFP_ATOMIC);
+	cancelled = kzalloc(sizeof(*cancelled), GFP_KERNEL);
 	if (!cancelled)
 		return -ENOMEM;
 
@@ -809,11 +809,12 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 
-		if (tcon->ses)
+		if (tcon->ses) {
 			server = tcon->ses->server;
-
-		cifs_server_dbg(FYI, "tid=%u: tcon is closing, skipping async close retry of fid %llu %llu\n",
-				tcon->tid, persistent_fid, volatile_fid);
+			cifs_server_dbg(FYI,
+					"tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
+					tcon->tid, persistent_fid, volatile_fid);
+		}
 
 		return 0;
 	}
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 70a4d101b542..aa1acc698caa 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4291,7 +4291,7 @@ smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
  */
 static int
 crypt_message(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int enc)
+	      struct smb_rqst *rqst, int enc, struct crypto_aead *tfm)
 {
 	struct smb2_transform_hdr *tr_hdr =
 		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
@@ -4302,8 +4302,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
-	DECLARE_CRYPTO_WAIT(wait);
-	struct crypto_aead *tfm;
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 
@@ -4314,15 +4312,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	rc = smb3_crypto_aead_allocate(server);
-	if (rc) {
-		cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
-		return rc;
-	}
-
-	tfm = enc ? server->secmech.ccmaesencrypt :
-						server->secmech.ccmaesdecrypt;
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
 		(server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
@@ -4361,11 +4350,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
-	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				  crypto_req_done, &wait);
-
-	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
-				: crypto_aead_decrypt(req), &wait);
+	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
 
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
@@ -4454,7 +4439,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	/* fill the 1st iov with a transform header */
 	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
 
-	rc = crypt_message(server, num_rqst, new_rq, 1);
+	rc = crypt_message(server, num_rqst, new_rq, 1, server->secmech.ccmaesencrypt);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
 	if (rc)
 		goto err_free;
@@ -4480,8 +4465,9 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		 unsigned int npages, unsigned int page_data_size,
 		 bool is_offloaded)
 {
-	struct kvec iov[2];
+	struct crypto_aead *tfm;
 	struct smb_rqst rqst = {NULL};
+	struct kvec iov[2];
 	int rc;
 
 	iov[0].iov_base = buf;
@@ -4496,9 +4482,31 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 	rqst.rq_pagesz = PAGE_SIZE;
 	rqst.rq_tailsz = (page_data_size % PAGE_SIZE) ? : PAGE_SIZE;
 
-	rc = crypt_message(server, 1, &rqst, 0);
+	if (is_offloaded) {
+		if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
+		    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+			tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+		else
+			tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
+		if (IS_ERR(tfm)) {
+			rc = PTR_ERR(tfm);
+			cifs_server_dbg(VFS, "%s: Failed alloc decrypt TFM, rc=%d\n", __func__, rc);
+
+			return rc;
+		}
+	} else {
+		if (unlikely(!server->secmech.ccmaesdecrypt))
+			return -EIO;
+
+		tfm = server->secmech.ccmaesdecrypt;
+	}
+
+	rc = crypt_message(server, 1, &rqst, 0, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
+	if (is_offloaded)
+		crypto_free_aead(tfm);
+
 	if (rc)
 		return rc;
 
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 03651cc6b7a5..4197096e7fdb 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -963,7 +963,9 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	 * SMB3.0 supports only 1 cipher and doesn't have a encryption neg context
 	 * Set the cipher type manually.
 	 */
-	if (server->dialect == SMB30_PROT_ID && (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
+	if ((server->dialect == SMB30_PROT_ID ||
+	     server->dialect == SMB302_PROT_ID) &&
+	    (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
 		server->cipher_type = SMB2_ENCRYPTION_AES128_CCM;
 
 	security_blob = smb2_get_data_area_len(&blob_offset, &blob_length,
@@ -998,6 +1000,12 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 		else
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
 	}
+
+	if (server->cipher_type && !rc) {
+		rc = smb3_crypto_aead_allocate(server);
+		if (rc)
+			cifs_server_dbg(VFS, "%s: crypto alloc failed, rc=%d\n", __func__, rc);
+	}
 neg_exit:
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 4409f56fc37e..c6fd4223b3be 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -47,6 +47,8 @@
 void
 cifs_wake_up_task(struct mid_q_entry *mid)
 {
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 	wake_up_process(mid->callback_data);
 }
 
@@ -86,7 +88,7 @@ AllocMidQEntry(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	return temp;
 }
 
-static void _cifs_mid_q_entry_release(struct kref *refcount)
+void _cifs_mid_q_entry_release(struct kref *refcount)
 {
 	struct mid_q_entry *midEntry =
 			container_of(refcount, struct mid_q_entry, refcount);
@@ -99,7 +101,8 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	struct TCP_Server_Info *server = midEntry->server;
 
 	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
-	    midEntry->mid_state == MID_RESPONSE_RECEIVED &&
+	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
+	     midEntry->mid_state == MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
 		server->ops->handle_cancelled_mid(midEntry, server);
 
@@ -165,13 +168,6 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	mempool_free(midEntry, cifs_mid_poolp);
 }
 
-void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
-{
-	spin_lock(&GlobalMid_Lock);
-	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
-	spin_unlock(&GlobalMid_Lock);
-}
-
 void DeleteMidQEntry(struct mid_q_entry *midEntry)
 {
 	cifs_mid_q_entry_release(midEntry);
@@ -733,7 +729,8 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 	int error;
 
 	error = wait_event_freezekillable_unsafe(server->response_q,
-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
+				    midQ->mid_state != MID_REQUEST_SUBMITTED &&
+				    midQ->mid_state != MID_RESPONSE_RECEIVED);
 	if (error < 0)
 		return -ERESTARTSYS;
 
@@ -885,7 +882,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 
 	spin_lock(&GlobalMid_Lock);
 	switch (mid->mid_state) {
-	case MID_RESPONSE_RECEIVED:
+	case MID_RESPONSE_READY:
 		spin_unlock(&GlobalMid_Lock);
 		return rc;
 	case MID_RETRY_NEEDED:
@@ -984,6 +981,9 @@ cifs_compound_callback(struct mid_q_entry *mid)
 	credits.instance = server->reconnect_instance;
 
 	add_credits(server, &credits, mid->optype);
+
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 }
 
 static void
@@ -1172,7 +1172,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			send_cancel(server, &rqst[i], midQ[i]);
 			spin_lock(&GlobalMid_Lock);
 			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
@@ -1193,7 +1194,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 
 		if (!midQ[i]->resp_buf ||
-		    midQ[i]->mid_state != MID_RESPONSE_RECEIVED) {
+		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
@@ -1372,7 +1373,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		send_cancel(server, &rqst, midQ);
 		spin_lock(&GlobalMid_Lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
 			midQ->callback = DeleteMidQEntry;
 			spin_unlock(&GlobalMid_Lock);
@@ -1389,7 +1391,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	    midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_server_dbg(VFS, "Bad MID state?\n");
 		goto out;
@@ -1509,13 +1511,15 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Wait for a reply - allow signals to interrupt. */
 	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED)) ||
+		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
 		((server->tcpStatus != CifsGood) &&
 		 (server->tcpStatus != CifsNew)));
 
 	/* Were we interrupted by a signal ? */
 	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
+		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
 		((server->tcpStatus == CifsGood) ||
 		 (server->tcpStatus == CifsNew))) {
 
@@ -1545,7 +1549,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		if (rc) {
 			send_cancel(server, &rqst, midQ);
 			spin_lock(&GlobalMid_Lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
 				midQ->callback = DeleteMidQEntry;
 				spin_unlock(&GlobalMid_Lock);
@@ -1563,7 +1568,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 
 	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 295e89d93295..5d5befac5622 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -353,10 +353,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	if (journal && inode == journal->j_inode)
 		return 0;
 
 	while (bref < p+max) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c991955412a4..15d020279d3b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -409,10 +409,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
 		return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
@@ -4681,22 +4682,43 @@ static inline u64 ext4_inode_peek_iversion(const struct inode *inode)
 		return inode_peek_iversion(inode);
 }
 
-static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
-
+static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
+			    const char *function, unsigned int line)
 {
+	const char *err_str;
+
 	if (flags & EXT4_IGET_EA_INODE) {
-		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "missing EA_INODE flag";
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			err_str = "missing EA_INODE flag";
+			goto error;
+		}
 		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
-		    EXT4_I(inode)->i_file_acl)
-			return "ea_inode with extended attributes";
+		    EXT4_I(inode)->i_file_acl) {
+			err_str = "ea_inode with extended attributes";
+			goto error;
+		}
 	} else {
-		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "unexpected EA_INODE flag";
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			/*
+			 * open_by_handle_at() could provide an old inode number
+			 * that has since been reused for an ea_inode; this does
+			 * not indicate filesystem corruption
+			 */
+			if (flags & EXT4_IGET_HANDLE)
+				return -ESTALE;
+			err_str = "unexpected EA_INODE flag";
+			goto error;
+		}
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
+		err_str = "unexpected bad inode w/o EXT4_IGET_BAD";
+		goto error;
 	}
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
-		return "unexpected bad inode w/o EXT4_IGET_BAD";
-	return NULL;
+	return 0;
+
+error:
+	ext4_error_inode(inode, function, line, 0, err_str);
+	return -EFSCORRUPTED;
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -4707,7 +4729,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4732,10 +4753,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW)) {
-		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-			ext4_error_inode(inode, function, line, 0, err_str);
+		ret = check_igot_inode(inode, flags, function, line);
+		if (ret) {
 			iput(inode);
-			return ERR_PTR(-EFSCORRUPTED);
+			return ERR_PTR(ret);
 		}
 		return inode;
 	}
@@ -5004,16 +5025,27 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
-	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
+	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
-	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-		ext4_error_inode(inode, function, line, 0, err_str);
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-
+	ret = check_igot_inode(inode, flags, function, line);
+	/*
+	 * -ESTALE here means there is nothing inherently wrong with the inode,
+	 * it's just not an inode we can return for an fhandle lookup.
+	 */
+	if (ret == -ESTALE) {
+		brelse(iloc.bh);
+		unlock_new_inode(inode);
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	if (ret)
+		goto bad_inode;
 	brelse(iloc.bh);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 703c4282b19e..b220d5ca7fd0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1930,7 +1930,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	 * split it in half by count; each resulting block will have at least
 	 * half the space free.
 	 */
-	if (i > 0)
+	if (i >= 0)
 		split = count - move;
 	else
 		split = count/2;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 20e89ffe9a06..3957ff246bff 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5185,8 +5185,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
 failed_mount3:
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 failed_mount2:
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
@@ -6251,12 +6251,25 @@ static int ext4_release_dquot(struct dquot *dquot)
 {
 	int ret, err;
 	handle_t *handle;
+	bool freeze_protected = false;
+
+	/*
+	 * Trying to sb_start_intwrite() in a running transaction
+	 * can result in a deadlock. Further, running transactions
+	 * are already protected from freezing.
+	 */
+	if (!ext4_journal_current_handle()) {
+		sb_start_intwrite(dquot->dq_sb);
+		freeze_protected = true;
+	}
 
 	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
 				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
 	if (IS_ERR(handle)) {
 		/* Release dquot anyway to avoid endless cycle in dqput() */
 		dquot_release(dquot);
+		if (freeze_protected)
+			sb_end_intwrite(dquot->dq_sb);
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
@@ -6267,6 +6280,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
+
+	if (freeze_protected)
+		sb_end_intwrite(dquot->dq_sb);
+
 	return ret;
 }
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index d1d930d09cb8..4eb75216218a 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1123,15 +1123,24 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
+	struct ext4_iloc iloc;
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
 	int credits;
+	void *end;
+
+	if (block_csum)
+		end = (void *)bh->b_data + bh->b_size;
+	else {
+		ext4_get_inode_loc(parent, &iloc);
+		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
+	}
 
 	/* One credit for dec ref on ea_inode, one for orphan list addition, */
 	credits = 2 + extra_credits;
 
-	for (entry = first; !IS_LAST_ENTRY(entry);
+	for (entry = first; (void *)entry < end && !IS_LAST_ENTRY(entry);
 	     entry = EXT4_XATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 348ad1d6199f..57baaba17174 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1047,7 +1047,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
 	level = get_node_path(inode, from, offset, noffset);
-	if (level < 0) {
+	if (level <= 0) {
+		if (!level) {
+			level = -EFSCORRUPTED;
+			f2fs_err(sbi, "%s: inode ino=%lx has corrupted node block, from:%lu addrs:%u",
+					__func__, inode->i_ino,
+					from, ADDRS_PER_INODE(inode));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
 		trace_f2fs_truncate_inode_blocks_exit(inode, level);
 		return level;
 	}
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c50999ad9f7a..d405cdf36247 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1447,6 +1447,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
+	if (!fsc->source)
+		return invalf(fsc, "No source specified");
+
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 397e02a56697..2251286cd83f 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -70,6 +70,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 1;
 
+	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfs_btree_key));
+		pr_err("hfs: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 177fae4e6581..cf6e5de7b9da 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -69,6 +69,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 2;
 
+	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfsplus_btree_key));
+		pr_err("hfsplus: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 35768a63fb1d..421d247fae52 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -180,7 +180,7 @@ static struct dentry *isofs_fh_to_parent(struct super_block *sb,
 		return NULL;
 
 	return isofs_export_iget(sb,
-			fh_len > 2 ? ifid->parent_block : 0,
+			fh_len > 3 ? ifid->parent_block : 0,
 			ifid->parent_offset,
 			fh_len > 4 ? ifid->parent_generation : 0);
 }
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 972f30f527bb..23314218fb0d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1649,7 +1649,6 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
-	WARN_ON(!sb->s_sequence);
 	journal->j_flags &= ~JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index ef220709c7f5..9dccebbee55a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
@@ -1694,6 +1698,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
@@ -3465,7 +3471,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
@@ -3728,8 +3734,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index da3a1c27d349..84e2c67c9070 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -458,7 +458,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 	dp += inum % 8;		/* 8 inodes per 4K page */
 
 	/* copy on-disk inode to in-memory inode */
-	if ((copy_from_dinode(dp, ip)) != 0) {
+	if ((copy_from_dinode(dp, ip) != 0) || (ip->i_nlink == 0)) {
 		/* handle bad return by returning NULL for ip */
 		set_nlink(ip, 1);	/* Don't want iput() deleting it */
 		iput(ip);
diff --git a/fs/namespace.c b/fs/namespace.c
index 7e67db7456b3..2f97112657ad 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1716,6 +1716,7 @@ static inline bool may_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1725,7 +1726,7 @@ static int can_umount(const struct path *path, int flags)
 		return -EINVAL;
 	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		return -EINVAL;
-	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
+	if (flags & MNT_FORCE && !ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..899e25e9b4eb 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -2,6 +2,7 @@
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
@@ -194,7 +195,6 @@ config NFS_USE_KERNEL_DNS
 config NFS_DEBUG
 	bool
 	depends on NFS_FS && SUNRPC_DEBUG
-	select CRC32
 	default y
 
 config NFS_DISABLE_UDP_SUPPORT
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 394a82d470d5..2fdc7c2a17fe 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -775,33 +775,11 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
 	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
 }
 
-#ifdef CONFIG_CRC32
-/**
- * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
- * @fh - pointer to filehandle
- *
- * returns a crc32 hash for the filehandle that is compatible with
- * the one displayed by "wireshark".
- */
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
-}
 static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
 				NFS4_STATEID_OTHER_SIZE);
 }
-#else
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return 0;
-}
-static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
-{
-	return 0;
-}
-#endif
 
 static inline bool nfs_error_is_fatal(int err)
 {
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index b996ee23f1ba..8ad99938aae1 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -147,16 +147,12 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
 	memcpy(dst->data, src->data, NFS4_MAX_SESSIONID_LEN);
 }
 
-#ifdef CONFIG_CRC32
 /*
  * nfs_session_id_hash - calculate the crc32 hash for the session id
  * @session - pointer to session
  */
 #define nfs_session_id_hash(sess_id) \
 	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
-#else
-#define nfs_session_id_hash(session) (0)
-#endif
 #else /* defined(CONFIG_NFS_V4_1) */
 
 static inline int nfs4_init_session(struct nfs_client *clp)
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 6d2d498a5957..ba6cfc8caee3 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -4,6 +4,7 @@ config NFSD
 	depends on INET
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 311409be7374..bf78745b19ca 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4940,7 +4940,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	queued = nfsd4_run_cb(&dp->dl_recall);
 	WARN_ON_ONCE(!queued);
 	if (!queued)
-		nfs4_put_stid(&dp->dl_stid);
+		refcount_dec(&dp->dl_stid.sc_count);
 }
 
 /* Called from break_lease() with flc_lock held. */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 513e028b0bbe..40aee06ebd95 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -263,7 +263,6 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
-#ifdef CONFIG_CRC32
 /**
  * knfsd_fh_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
@@ -275,12 +274,6 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
 }
-#else
-static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
-{
-	return 0;
-}
-#endif
 
 /**
  * fh_clear_pre_post_attrs - Reset pre/post attributes
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 18a4588c35be..8fba6d39e776 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -443,12 +443,12 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	int permitted;
 	struct mm_struct *mm;
 	unsigned long long start_time;
-	unsigned long cmin_flt = 0, cmaj_flt = 0;
-	unsigned long  min_flt = 0,  maj_flt = 0;
-	u64 cutime, cstime, utime, stime;
-	u64 cgtime, gtime;
+	unsigned long cmin_flt, cmaj_flt, min_flt, maj_flt;
+	u64 cutime, cstime, cgtime, utime, stime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -476,12 +476,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = utime = stime = 0;
-	cgtime = gtime = 0;
+	utime = stime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
-		struct signal_struct *sig = task->signal;
-
 		if (sig->tty) {
 			struct pid *pgrp = tty_get_pgrp(sig->tty);
 			tty_pgrp = pid_nr_ns(pgrp, ns);
@@ -492,37 +489,48 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		num_threads = get_nr_threads(task);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
+		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
+
+		sid = task_session_nr_ns(task, ns);
+		ppid = task_tgid_nr_ns(task->real_parent, ns);
+		pgid = task_pgrp_nr_ns(task, ns);
+
+		unlock_task_sighand(task, &flags);
+	}
+
+	if (permitted && (!whole || num_threads < 2))
+		wchan = get_wchan(task);
+
+	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
+		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+
 		cmin_flt = sig->cmin_flt;
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
 		cstime = sig->cstime;
 		cgtime = sig->cgtime;
-		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
-		/* add up live thread stats at the group level */
 		if (whole) {
 			struct task_struct *t = task;
+
+			min_flt = sig->min_flt;
+			maj_flt = sig->maj_flt;
+			gtime = sig->gtime;
+
+			rcu_read_lock();
 			do {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
 			} while_each_thread(task, t);
+			rcu_read_unlock();
 
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
 			thread_group_cputime_adjusted(task, &utime, &stime);
-			gtime += sig->gtime;
 		}
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
-		sid = task_session_nr_ns(task, ns);
-		ppid = task_tgid_nr_ns(task->real_parent, ns);
-		pgid = task_pgrp_nr_ns(task, ns);
-
-		unlock_task_sighand(task, &flags);
-	}
-
-	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..4e83ba0edd6d 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -281,6 +281,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b89099360a86..d0a5e62cf520 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -87,6 +87,7 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
+	bool				online;
 };
 
 /*
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 840b2a05c1b9..e3aca0dc7d9c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -758,6 +758,10 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * already takes rcu_read_lock() when fetching the program, so
 	 * it's not necessary here anymore.
 	 */
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+
+	if (ri->map)
+		ri->map = NULL;
 	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
 }
 
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index b06375e88e58..095a95c1fae8 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -10,6 +10,7 @@
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
+#include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
 /*
@@ -44,4 +45,16 @@ enum nfs3_stable_how {
 	/* used by direct.c to mark verf as invalid */
 	NFS_INVALID_STABLE_HOW = -1
 };
+
+/**
+ * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
+ * @fh - pointer to filehandle
+ *
+ * returns a crc32 hash for the filehandle that is compatible with
+ * the one displayed by "wireshark".
+ */
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
+}
 #endif /* _LINUX_NFS_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 30bc462fb196..d3d84eb466f0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -538,6 +538,16 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+/*
+ * Currently in ACPI spec, for each PCI host bridge, PCI Segment
+ * Group number is limited to a 16-bit value, therefore (int)-1 is
+ * not a valid PCI domain number, and can be used as a sentinel
+ * value indicating ->domain_nr is not set by the driver (and
+ * CONFIG_PCI_DOMAINS_GENERIC=y archs will set it with
+ * pci_bus_find_domain_nr()).
+ */
+#define PCI_DOMAIN_NR_NOT_SET (-1)
+
 struct pci_host_bridge {
 	struct device	dev;
 	struct pci_bus	*bus;		/* Root bus */
@@ -545,6 +555,7 @@ struct pci_host_bridge {
 	struct pci_ops	*child_ops;
 	void		*sysdata;
 	int		busnr;
+	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
@@ -1656,6 +1667,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 { return 0; }
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
index 8bca6763f99c..62f0e2531068 100644
--- a/include/linux/soc/samsung/exynos-chipid.h
+++ b/include/linux/soc/samsung/exynos-chipid.h
@@ -9,10 +9,8 @@
 #define __LINUX_SOC_EXYNOS_CHIPID_H
 
 #define EXYNOS_CHIPID_REG_PRO_ID	0x00
-#define EXYNOS_SUBREV_MASK		(0xf << 4)
-#define EXYNOS_MAINREV_MASK		(0xf << 0)
-#define EXYNOS_REV_MASK			(EXYNOS_SUBREV_MASK | \
-					 EXYNOS_MAINREV_MASK)
+#define EXYNOS_REV_PART_MASK		0xf
+#define EXYNOS_REV_PART_SHIFT		4
 #define EXYNOS_MASK			0xfffff000
 
 #define EXYNOS_CHIPID_REG_PKG_ID	0x04
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 3cf6a5c17b84..1f985b64a666 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -80,6 +80,7 @@ struct net {
 						 * or to unregister pernet ops
 						 * (pernet_ops_rwsem write locked).
 						 */
+	struct llist_node	defer_free_list;
 	struct llist_node	cleanup_list;	/* namespaces on death row */
 
 #ifdef CONFIG_KEYS
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 108eb62cdc2c..8d058b50f138 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -771,6 +771,7 @@ struct sctp_transport {
 
 	/* Reference counting. */
 	refcount_t refcnt;
+	__u32	dead:1,
 		/* RTO-Pending : A flag used to track if one of the DATA
 		 *		chunks sent to this address is currently being
 		 *		used to compute a RTT. If this flag is 0,
@@ -780,7 +781,7 @@ struct sctp_transport {
 		 *		calculation completes (i.e. the DATA chunk
 		 *		is SACK'd) clear this flag.
 		 */
-	__u32	rto_pending:1,
+		rto_pending:1,
 
 		/*
 		 * hb_sent : a flag that signals that we have a pending
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 695b606da4b1..94af84e84554 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -47,6 +47,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 7483a78d2425..20a3b320d1a5 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -371,7 +371,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
diff --git a/init/Kconfig b/init/Kconfig
index 9807c66b24bb..233166e54df3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -656,7 +656,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
@@ -2211,6 +2211,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 choice
 	prompt "Which hash algorithm should modules be signed with?"
 	depends on MODULE_SIG
+	default MODULE_SIG_SHA512
 	help
 	  This determines which sort of hashing algorithm will be used during
 	  signature generation.  This algorithm _must_ be built into the kernel
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 31e3a5482156..238a51daefa4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3,6 +3,7 @@
  */
 #include <linux/bpf.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/topology.h>
@@ -24,12 +25,12 @@
  *
  * Different map implementations will rely on rcu in map methods
  * lookup/update/delete, therefore eBPF programs must run under rcu lock
- * if program is allowed to access maps, so check rcu_read_lock_held in
- * all three functions.
+ * if program is allowed to access maps, so check rcu_read_lock_held() or
+ * rcu_read_lock_trace_held() in all three functions.
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -45,7 +46,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -62,7 +63,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 008bb4e5c4dd..dc3d9a111cf1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -647,7 +647,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map))
 		return -ENOTSUPP;
@@ -671,7 +671,12 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 			err = -EACCES;
 			goto out;
 		}
+		bpf_map_write_active_inc(map);
 	}
+out:
+	mutex_unlock(&map->freeze_mutex);
+	if (err)
+		return err;
 
 	/* set default open/close callbacks */
 	vma->vm_ops = &bpf_map_default_vmops;
@@ -682,13 +687,11 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 		vma->vm_flags &= ~VM_MAYWRITE;
 
 	err = map->ops->map_mmap(map, vma);
-	if (err)
-		goto out;
+	if (err) {
+		if (vma->vm_flags & VM_WRITE)
+			bpf_map_write_active_dec(map);
+	}
 
-	if (vma->vm_flags & VM_MAYWRITE)
-		bpf_map_write_active_inc(map);
-out:
-	mutex_unlock(&map->freeze_mutex);
 	return err;
 }
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 16b95ff12e4d..3a4e094e4b1f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -69,8 +69,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
-	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+#define size_bytes ((phys_addr_t)CMA_SIZE_MBYTES * SZ_1M)
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b576dd00516b..47d939a0373d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5921,6 +5921,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
+		/* Class allocated but not used, -1 in nr_unused_locks */
+		if (class->usage_mask == 0)
+			debug_atomic_dec(nr_unused_locks);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
 		if (class - lock_classes == max_lock_class_idx)
diff --git a/kernel/resource.c b/kernel/resource.c
index 1087f33d70c4..ea4d7a02b8e8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -53,14 +53,6 @@ struct resource_constraint {
 
 static DEFINE_RWLOCK(resource_lock);
 
-/*
- * For memory hotplug, there is no way to free resource entries allocated
- * by boot mem after the system is up. So for reusing the resource entry
- * we need to remember the resource.
- */
-static struct resource *bootmem_resource_free;
-static DEFINE_SPINLOCK(bootmem_resource_lock);
-
 static struct resource *next_resource(struct resource *p, bool sibling_only)
 {
 	/* Caller wants to traverse through siblings only */
@@ -149,36 +141,19 @@ __initcall(ioresources_init);
 
 static void free_resource(struct resource *res)
 {
-	if (!res)
-		return;
-
-	if (!PageSlab(virt_to_head_page(res))) {
-		spin_lock(&bootmem_resource_lock);
-		res->sibling = bootmem_resource_free;
-		bootmem_resource_free = res;
-		spin_unlock(&bootmem_resource_lock);
-	} else {
+	/**
+	 * If the resource was allocated using memblock early during boot
+	 * we'll leak it here: we can only return full pages back to the
+	 * buddy and trying to be smart and reusing them eventually in
+	 * alloc_resource() overcomplicates resource handling.
+	 */
+	if (res && PageSlab(virt_to_head_page(res)))
 		kfree(res);
-	}
 }
 
 static struct resource *alloc_resource(gfp_t flags)
 {
-	struct resource *res = NULL;
-
-	spin_lock(&bootmem_resource_lock);
-	if (bootmem_resource_free) {
-		res = bootmem_resource_free;
-		bootmem_resource_free = res->sibling;
-	}
-	spin_unlock(&bootmem_resource_lock);
-
-	if (res)
-		memset(res, 0, sizeof(struct resource));
-	else
-		res = kzalloc(sizeof(struct resource), flags);
-
-	return res;
+	return kzalloc(sizeof(struct resource), flags);
 }
 
 /* Return the conflict entry if you can't request it */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d8b9e1d25200..c1307bbdc291 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -90,7 +90,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = true;
 		return true;
 	}
 
@@ -102,10 +102,22 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->need_freq_update)
+	if (sg_policy->need_freq_update) {
 		sg_policy->need_freq_update = false;
-	else if (sg_policy->next_freq == next_freq)
+		/*
+		 * The policy limits have changed, but if the return value of
+		 * cpufreq_driver_resolve_freq() after applying the new limits
+		 * is still equal to the previously selected frequency, the
+		 * driver callback need not be invoked unless the driver
+		 * specifically wants that to happen on every update of the
+		 * policy limits.
+		 */
+		if (sg_policy->next_freq == next_freq &&
+		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+			return false;
+	} else if (sg_policy->next_freq == next_freq) {
 		return false;
+	}
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index feade7f3c2b0..7425989c3a12 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6096,6 +6096,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
 out:
 	mutex_unlock(&ftrace_lock);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7c90872f2435..f47938d8401a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -109,6 +109,10 @@ enum trace_type {
 	unlikely(__ret_warn_once);				\
 })
 
+#define HIST_STACKTRACE_DEPTH	16
+#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
+#define HIST_STACKTRACE_SKIP	5
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4b5a8d7275be..92693e2140a9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -411,7 +411,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c1db5b62d811..5f5a38d4780f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -676,7 +676,7 @@ static __always_inline char *test_string(char *str)
 	kstr = ubuf->buffer;
 
 	/* For safety, do not trust the string pointer */
-	if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
 		return NULL;
 	return kstr;
 }
@@ -695,7 +695,7 @@ static __always_inline char *test_ustring(char *str)
 
 	/* user space address? */
 	ustr = (char __user *)str;
-	if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
+	if (strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE) < 0)
 		return NULL;
 
 	return kstr;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 059a106e62be..a0342b45a06d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -282,10 +282,6 @@ DEFINE_HIST_FIELD_FN(u8);
 #define for_each_hist_key_field(i, hist_data)	\
 	for ((i) = (hist_data)->n_vals; (i) < (hist_data)->n_fields; (i)++)
 
-#define HIST_STACKTRACE_DEPTH	16
-#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
-#define HIST_STACKTRACE_SKIP	5
-
 #define HITCOUNT_IDX		0
 #define HIST_KEY_SIZE_MAX	(MAX_FILTER_STR_VAL + HIST_STACKTRACE_SIZE)
 
@@ -3356,6 +3352,9 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
+	if (strstr(hist_field->type, "long[") && field->is_stack)
+		return 0;
+
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
 		    (!field->is_string && field->is_signed != hist_field->is_signed))
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e43426aa1283..613d45e7b608 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -162,6 +162,14 @@ static int synth_field_is_string(char *type)
 	return false;
 }
 
+static int synth_field_is_stack(char *type)
+{
+	if (strstr(type, "long[") != NULL)
+		return true;
+
+	return false;
+}
+
 static int synth_field_string_size(char *type)
 {
 	char buf[4], *end, *start;
@@ -237,6 +245,8 @@ static int synth_field_size(char *type)
 		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
+	else if (synth_field_is_stack(type))
+		size = 0;
 
 	return size;
 }
@@ -280,7 +290,9 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%.*s";
+		fmt = "%s";
+	else if (synth_field_is_stack(type))
+		fmt = "%s";
 
 	return fmt;
 }
@@ -360,6 +372,23 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
+		} else if (se->fields[i]->is_stack) {
+			u32 offset, data_offset, len;
+			unsigned long *p, *end;
+
+			offset = (u32)entry->fields[n_u64];
+			data_offset = offset & 0xffff;
+			len = offset >> 16;
+
+			p = (void *)entry + data_offset;
+			end = (void *)p + len - (sizeof(long) - 1);
+
+			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
+
+			for (; *p && p < end; p++)
+				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			n_u64++;
+
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -427,6 +456,43 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	return len;
 }
 
+static unsigned int trace_stack(struct synth_trace_event *entry,
+				 struct synth_event *event,
+				 long *stack,
+				 unsigned int data_size,
+				 unsigned int *n_u64)
+{
+	unsigned int len;
+	u32 data_offset;
+	void *data_loc;
+
+	data_offset = struct_size(entry, fields, event->n_u64);
+	data_offset += data_size;
+
+	for (len = 0; len < HIST_STACKTRACE_DEPTH; len++) {
+		if (!stack[len])
+			break;
+	}
+
+	/* Include the zero'd element if it fits */
+	if (len < HIST_STACKTRACE_DEPTH)
+		len++;
+
+	len *= sizeof(long);
+
+	/* Find the dynamic section to copy the stack into. */
+	data_loc = (void *)entry + data_offset;
+	memcpy(data_loc, stack, len);
+
+	/* Fill in the field that holds the offset/len combo */
+	data_offset |= len << 16;
+	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	(*n_u64)++;
+
+	return len;
+}
+
 static notrace void trace_event_raw_event_synth(void *__data,
 						u64 *var_ref_vals,
 						unsigned int *var_ref_idx)
@@ -479,6 +545,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
+		} if (event->fields[i]->is_stack) {
+		        long *stack = (long *)(long)var_ref_vals[val_idx];
+
+			len = trace_stack(entry, event, stack,
+					   data_size, &n_u64);
+			data_size += len;
 		} else {
 			struct synth_field *field = event->fields[i];
 			u64 val = var_ref_vals[val_idx];
@@ -541,6 +613,9 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		    event->fields[i]->is_dynamic)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", __get_str(%s)", event->fields[i]->name);
+		else if (event->fields[i]->is_stack)
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", __get_stacktrace(%s)", event->fields[i]->name);
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 					", REC->%s", event->fields[i]->name);
@@ -660,7 +735,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
-		if (synth_field_is_string(field->type)) {
+		if (synth_field_is_string(field->type) ||
+		    synth_field_is_stack(field->type)) {
 			char *type;
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
@@ -691,6 +767,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 
 	if (synth_field_is_string(field->type))
 		field->is_string = true;
+	else if (synth_field_is_stack(field->type))
+		field->is_stack = true;
 
 	field->is_signed = synth_field_signed(field->type);
  out:
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 4007fe95cf42..077c748a8b3a 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -18,6 +18,7 @@ struct synth_field {
 	bool is_signed;
 	bool is_string;
 	bool is_dynamic;
+	bool is_stack;
 };
 
 struct synth_event {
diff --git a/lib/sg_split.c b/lib/sg_split.c
index 60a0babebf2e..0f89aab5c671 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
 			if (!j) {
 				out_sg->offset += split->skip_sg0;
 				out_sg->length -= split->skip_sg0;
-			} else {
-				out_sg->offset = 0;
 			}
 			sg_dma_address(out_sg) = 0;
 			sg_dma_len(out_sg) = 0;
diff --git a/mm/memory.c b/mm/memory.c
index 29cce8aadb61..3ebf3f1da428 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2469,11 +2469,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	if (fn) {
 		do {
 			if (create || !pte_none(*pte)) {
-				err = fn(pte++, addr, data);
+				err = fn(pte, addr, data);
 				if (err)
 					break;
 			}
-		} while (addr += PAGE_SIZE, addr != end);
+		} while (pte++, addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b05304e5854..bfc384c84139 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4264,7 +4264,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (!ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_FAILED);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b7cf430006e5..c134f8210b21 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -272,17 +272,6 @@ static int vlan_dev_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (dev->flags & IFF_ALLMULTI) {
-		err = dev_set_allmulti(real_dev, 1);
-		if (err < 0)
-			goto del_unicast;
-	}
-	if (dev->flags & IFF_PROMISC) {
-		err = dev_set_promiscuity(real_dev, 1);
-		if (err < 0)
-			goto clear_allmulti;
-	}
-
 	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
 
 	if (vlan->flags & VLAN_FLAG_GVRP)
@@ -296,12 +285,6 @@ static int vlan_dev_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	return 0;
 
-clear_allmulti:
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -314,10 +297,6 @@ static int vlan_dev_stop(struct net_device *dev)
 
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-	if (dev->flags & IFF_PROMISC)
-		dev_set_promiscuity(real_dev, -1);
 
 	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
 		dev_uc_del(real_dev, dev->dev_addr);
@@ -474,12 +453,10 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
-	if (dev->flags & IFF_UP) {
-		if (change & IFF_ALLMULTI)
-			dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
-			dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
-	}
+	if (change & IFF_ALLMULTI)
+		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
+	if (change & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
 }
 
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 546795425119..7f26c1aab9a0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5644,11 +5644,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * event or send an immediate device found event if the data
 	 * should not be stored for later.
 	 */
-	if (!ext_adv &&	!has_pending_adv_report(hdev)) {
+	if (!has_pending_adv_report(hdev)) {
 		/* If the report will trigger a SCAN_REQ store it for
 		 * later merging.
 		 */
-		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
+		if (!ext_adv && (type == LE_ADV_IND ||
+				 type == LE_ADV_SCAN_IND)) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
 						 rssi, flags, data, len);
 			return;
diff --git a/net/core/dev.c b/net/core/dev.c
index 2c11247509b4..c0dc524548ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3186,6 +3186,7 @@ static u16 skb_tx_hash(const struct net_device *dev,
 	}
 
 	if (skb_rx_queue_recorded(skb)) {
+		BUILD_BUG_ON_INVALID(qcount == 0);
 		hash = skb_get_rx_queue(skb);
 		if (hash >= qoffset)
 			hash -= qoffset;
diff --git a/net/core/filter.c b/net/core/filter.c
index d9f4d98acc45..b262cad02bad 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -208,24 +208,36 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
 	return 0;
 }
 
+static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int offset)
+{
+	if (likely(offset >= 0))
+		return offset;
+
+	if (offset >= SKF_NET_OFF)
+		return offset - SKF_NET_OFF + skb_network_offset(skb);
+
+	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+		return offset - SKF_LL_OFF + skb_mac_offset(skb);
+
+	return INT_MIN;
+}
+
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u8 tmp, *ptr;
+	u8 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return *(u8 *)(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return tmp;
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return *(u8 *)ptr;
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return *(u8 *)(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return tmp;
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -238,21 +250,19 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u16 tmp, *ptr;
+	__be16 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return get_unaligned_be16(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be16_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be16(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be16(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be16_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -265,21 +275,19 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u32 tmp, *ptr;
+	__be32 tmp;
 	const int len = sizeof(tmp);
 
-	if (likely(offset >= 0)) {
-		if (headlen - offset >= len)
-			return get_unaligned_be32(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be32_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be32(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be32(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be32_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index bcf3533cb8ff..feee95cf2991 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -455,11 +455,28 @@ static struct net *net_alloc(void)
 	goto out;
 }
 
+static LLIST_HEAD(defer_free_list);
+
+static void net_complete_free(void)
+{
+	struct llist_node *kill_list;
+	struct net *net, *next;
+
+	/* Get the list of namespaces to free from last round. */
+	kill_list = llist_del_all(&defer_free_list);
+
+	llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
+		kmem_cache_free(net_cachep, net);
+
+}
+
 static void net_free(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
-		kmem_cache_free(net_cachep, net);
+
+		/* Wait for an extra rcu_barrier() before final free. */
+		llist_add(&net->defer_free_list, &defer_free_list);
 	}
 }
 
@@ -643,6 +660,8 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	rcu_barrier();
 
+	net_complete_free();
+
 	/* Finally it is safe to free my network namespace structure */
 	list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
 		list_del_init(&net->exit_list);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 08fbf4049c10..a11809b3149b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -485,7 +485,13 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 * in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
 		return;
 
 	/* Periodic warning */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6ebe43b4d28f..723aab818b52 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -722,21 +722,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(req_to_sk(req));
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
+	if (!from_timer && timer_delete_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	if (unlinked) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -804,7 +814,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 		return;
 	}
 drop:
-	inet_csk_reqsk_queue_drop_and_put(sk_listener, req);
+	__inet_csk_reqsk_queue_drop(sk_listener, req, true);
+	reqsk_put(req);
 }
 
 static void reqsk_queue_hash_req(struct request_sock *req,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 55e3dfa7505d..644eabaf10e3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -595,6 +595,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
+	if (sdata->vif.txq)
+		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
+
 	sdata->bss = NULL;
 
 	if (local->open_count == 0)
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 3db514c4c63a..4848e3c2f0af 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -360,6 +360,12 @@ u32 airtime_link_metric_get(struct ieee80211_local *local,
 	return (u32)result;
 }
 
+/* Check that the first metric is at least 10% better than the second one */
+static bool is_metric_better(u32 x, u32 y)
+{
+	return (x < y) && (x < (y - x / 10));
+}
+
 /**
  * hwmp_route_info_get - Update routing info to originator and transmitter
  *
@@ -450,8 +456,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 				    (mpath->sn == orig_sn &&
 				     (rcu_access_pointer(mpath->next_hop) !=
 						      sta ?
-					      mult_frac(new_metric, 10, 9) :
-					      new_metric) >= mpath->metric)) {
+					      !is_metric_better(new_metric, mpath->metric) :
+					      new_metric >= mpath->metric))) {
 					process = false;
 					fresh_info = false;
 				}
@@ -521,8 +527,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 			if ((mpath->flags & MESH_PATH_FIXED) ||
 			    ((mpath->flags & MESH_PATH_ACTIVE) &&
 			     ((rcu_access_pointer(mpath->next_hop) != sta ?
-				       mult_frac(last_hop_metric, 10, 9) :
-				       last_hop_metric) > mpath->metric)))
+				      !is_metric_better(last_hop_metric, mpath->metric) :
+				       last_hop_metric > mpath->metric))))
 				fresh_info = false;
 		} else {
 			mpath = mesh_path_add(sdata, ta);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 51b552fa392a..f33c3150e690 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2395,6 +2395,49 @@ static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
+				int __user *optlen, int val)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+	if (len < 0)
+		return -EINVAL;
+
+	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
+		unsigned char ucval = (unsigned char)val;
+
+		len = 1;
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &ucval, 1))
+			return -EFAULT;
+	} else {
+		len = min_t(unsigned int, len, sizeof(int));
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &val, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    sk->sk_ipv6only);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, int __user *option)
 {
@@ -2415,6 +2458,8 @@ static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	return -EOPNOTSUPP;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c3434069fb0a..9a8d0d877bd1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -454,8 +454,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(msk->remote_key, msk->local_key,
 			      subflow_req->remote_nonce,
@@ -578,11 +576,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			fallback = true;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!mp_opt.mp_join)
 			fallback = true;
-		}
 	}
 
 create_child:
@@ -636,6 +631,14 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (!owner)
 				goto dispose_child;
 
+			if (!subflow_hmac_valid(req, &mp_opt)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				goto dispose_child;
+			}
+
+			if (!mptcp_can_accept_new_subflow(owner))
+				goto dispose_child;
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index fb9f1badeddb..4c9ef2ae4d68 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1384,20 +1384,20 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		sched = NULL;
 	}
 
-	/* Bind the ct retriever */
-	RCU_INIT_POINTER(svc->pe, pe);
-	pe = NULL;
-
 	/* Update the virtual service counters */
 	if (svc->port == FTPPORT)
 		atomic_inc(&ipvs->ftpsvc_counter);
 	else if (svc->port == 0)
 		atomic_inc(&ipvs->nullsvc_counter);
-	if (svc->pe && svc->pe->conn_out)
+	if (pe && pe->conn_out)
 		atomic_inc(&ipvs->conn_out_counter);
 
 	ip_vs_start_estimator(ipvs, &svc->stats);
 
+	/* Bind the ct retriever */
+	RCU_INIT_POINTER(svc->pe, pe);
+	pe = NULL;
+
 	/* Count only IPv4 services for old get/setsockopt interface */
 	if (svc->af == AF_INET)
 		ipvs->num_services++;
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 13c7e22c9384..0a23d297084d 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -985,8 +985,9 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(5, lt,  8,  pkt[8], bsize);
 
 		NFT_PIPAPO_AVX2_AND(6, 2, 3);
+		NFT_PIPAPO_AVX2_AND(3, 4, 7);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(7, lt,  9,  pkt[9], bsize);
-		NFT_PIPAPO_AVX2_AND(0, 4, 5);
+		NFT_PIPAPO_AVX2_AND(0, 3, 5);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(1, lt, 10, pkt[10], bsize);
 		NFT_PIPAPO_AVX2_AND(2, 6, 7);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(3, lt, 11, pkt[11], bsize);
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 80fee9d118ee..a02ea493c269 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -912,7 +912,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport)) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index cff18a5bbf38..3f8f43dbf44f 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2834,7 +2834,8 @@ static int validate_set(const struct nlattr *a,
 	size_t key_len;
 
 	/* There can be only one key in a action */
-	if (nla_total_size(nla_len(ovs_key)) != nla_len(a))
+	if (!nla_ok(ovs_key, nla_len(a)) ||
+	    nla_total_size(nla_len(ovs_key)) != nla_len(a))
 		return -EINVAL;
 
 	key_len = nla_len(ovs_key);
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index adcf87d417ae..aad090fd165b 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -959,6 +959,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (cl != NULL) {
 		int old_flags;
+		int len = 0;
 
 		if (parentid) {
 			if (cl->cl_parent &&
@@ -989,9 +990,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (usc != NULL)
 			hfsc_change_usc(cl, usc, cur_time);
 
+		if (cl->qdisc->q.qlen != 0)
+			len = qdisc_peek_len(cl->qdisc);
+		/* Check queue length again since some qdisc implementations
+		 * (e.g., netem/codel) might empty the queue during the peek
+		 * operation.
+		 */
 		if (cl->qdisc->q.qlen != 0) {
-			int len = qdisc_peek_len(cl->qdisc);
-
 			if (cl->cl_flags & HFSC_RSC) {
 				if (old_flags & HFSC_RSC)
 					update_ed(cl, len);
@@ -1638,10 +1643,16 @@ hfsc_dequeue(struct Qdisc *sch)
 		if (cl->qdisc->q.qlen != 0) {
 			/* update ed */
 			next_len = qdisc_peek_len(cl->qdisc);
-			if (realtime)
-				update_ed(cl, next_len);
-			else
-				update_d(cl, next_len);
+			/* Check queue length again since some qdisc implementations
+			 * (e.g., netem/codel) might empty the queue during the peek
+			 * operation.
+			 */
+			if (cl->qdisc->q.qlen != 0) {
+				if (realtime)
+					update_ed(cl, next_len);
+				else
+					update_d(cl, next_len);
+			}
 		} else {
 			/* the class becomes passive */
 			eltree_remove(cl);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index f529574aa068..3d6c9e35781e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -70,8 +70,9 @@
 /* Forward declarations for internal helper functions. */
 static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1828,7 +1829,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 
 	if (sctp_wspace(asoc) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
 		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
 		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
@@ -8963,8 +8964,9 @@ void sctp_sock_rfree(struct sk_buff *skb)
 
 
 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
 	long current_timeo = *timeo_p;
@@ -8974,7 +8976,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -8983,7 +8987,7 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 					  TASK_INTERRUPTIBLE);
 		if (asoc->base.dead)
 			goto do_dead;
-		if (!*timeo_p)
+		if ((!*timeo_p) || (transport && transport->dead))
 			goto do_nonblock;
 		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
@@ -9010,7 +9014,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 60fcf31cdcfb..9c721d70df9c 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -116,6 +116,8 @@ struct sctp_transport *sctp_transport_new(struct net *net,
  */
 void sctp_transport_free(struct sctp_transport *transport)
 {
+	transport->dead = 1;
+
 	/* Try to delete the heartbeat timer.  */
 	if (del_timer(&transport->hb_timer))
 		sctp_transport_put(transport);
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 5f849c730028..336d1bb2cf6a 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1033,6 +1033,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	if (unlikely(l->backlog[imp].len >= l->backlog[imp].limit)) {
 		if (imp == TIPC_SYSTEM_IMPORTANCE) {
 			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			__skb_queue_purge(list);
 			return -ENOBUFS;
 		}
 		rc = link_schedule_user(l, hdr);
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 1d90f39129ca..ba0a308d41d8 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -685,7 +685,8 @@ void tipc_mon_reinit_self(struct net *net)
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
-		mon->self->addr = tipc_own_addr(net);
+		if (mon->self)
+			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
 }
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index ebf856cf821d..9d7b52370155 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -623,6 +623,11 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static int tls_disconnect(struct sock *sk, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 struct tls_context *tls_ctx_create(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -717,6 +722,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE] = *base;
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE][TLS_BASE].disconnect	= tls_disconnect;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fad3e8853be0..407bbf9264ac 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1399,8 +1399,21 @@ static void azx_free(struct azx *chip)
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
-		if (hda->vga_switcheroo_registered)
+		if (hda->vga_switcheroo_registered) {
 			vga_switcheroo_unregister_client(chip->pci);
+
+			/* Some GPUs don't have sound, and azx_first_init fails,
+			 * leaving the device probed but non-functional. As long
+			 * as it's probed, the PCI subsystem keeps its runtime
+			 * PM status as active. Force it to suspended (as we
+			 * actually stop the chip) to allow GPU to suspend via
+			 * vga_switcheroo, and print a warning.
+			 */
+			dev_warn(&pci->dev, "GPU sound probed, but not operational: please add a quirk to driver_denylist\n");
+			pm_runtime_disable(&pci->dev);
+			pm_runtime_set_suspended(&pci->dev);
+			pm_runtime_enable(&pci->dev);
+		}
 	}
 
 	if (bus->chip_init) {
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 104751ac6cd1..8580f5e95ccf 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2188,7 +2188,7 @@ static irqreturn_t wcd934x_slim_irq_handler(int irq, void *data)
 {
 	struct wcd934x_codec *wcd = data;
 	unsigned long status = 0;
-	int i, j, port_id;
+	unsigned int i, j, port_id;
 	unsigned int val, int_val = 0;
 	irqreturn_t ret = IRQ_NONE;
 	bool tx;
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 84cf190aa01a..1bae6f70ea89 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -916,9 +916,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 		if (ret < 0) {
 			dev_err(dev, "q6asm_open_write failed\n");
-			q6asm_audio_client_free(prtd->audio_client);
-			prtd->audio_client = NULL;
-			return ret;
+			goto open_err;
 		}
 	}
 
@@ -927,7 +925,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		return ret;
+		goto q6_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -935,7 +933,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 						 prtd->stream_id);
 	if (ret) {
 		dev_err(dev, "codec param setup failed ret:%d\n", ret);
-		return ret;
+		goto q6_err;
 	}
 
 	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
@@ -944,12 +942,21 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 	if (ret < 0) {
 		dev_err(dev, "Buffer Mapping failed ret:%d\n", ret);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto q6_err;
 	}
 
 	prtd->state = Q6ASM_STREAM_RUNNING;
 
 	return 0;
+
+q6_err:
+	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+
+open_err:
+	q6asm_audio_client_free(prtd->audio_client);
+	prtd->audio_client = NULL;
+	return ret;
 }
 
 static int q6asm_dai_compr_set_metadata(struct snd_soc_component *component,
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index f0a70e912bdd..b09b7b3c0110 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -505,16 +505,84 @@ static void ch345_broken_sysex_input(struct snd_usb_midi_in_endpoint *ep,
 
 /*
  * CME protocol: like the standard protocol, but SysEx commands are sent as a
- * single USB packet preceded by a 0x0F byte.
+ * single USB packet preceded by a 0x0F byte, as are system realtime
+ * messages and MIDI Active Sensing.
+ * Also, multiple messages can be sent in the same packet.
  */
 static void snd_usbmidi_cme_input(struct snd_usb_midi_in_endpoint *ep,
 				  uint8_t *buffer, int buffer_length)
 {
-	if (buffer_length < 2 || (buffer[0] & 0x0f) != 0x0f)
-		snd_usbmidi_standard_input(ep, buffer, buffer_length);
-	else
-		snd_usbmidi_input_data(ep, buffer[0] >> 4,
-				       &buffer[1], buffer_length - 1);
+	int remaining = buffer_length;
+
+	/*
+	 * CME send sysex, song position pointer, system realtime
+	 * and active sensing using CIN 0x0f, which in the standard
+	 * is only intended for single byte unparsed data.
+	 * So we need to interpret these here before sending them on.
+	 * By default, we assume single byte data, which is true
+	 * for system realtime (midi clock, start, stop and continue)
+	 * and active sensing, and handle the other (known) cases
+	 * separately.
+	 * In contrast to the standard, CME does not split sysex
+	 * into multiple 4-byte packets, but lumps everything together
+	 * into one. In addition, CME can string multiple messages
+	 * together in the same packet; pressing the Record button
+	 * on an UF6 sends a sysex message directly followed
+	 * by a song position pointer in the same packet.
+	 * For it to have any reasonable meaning, a sysex message
+	 * needs to be at least 3 bytes in length (0xf0, id, 0xf7),
+	 * corresponding to a packet size of 4 bytes, and the ones sent
+	 * by CME devices are 6 or 7 bytes, making the packet fragments
+	 * 7 or 8 bytes long (six or seven bytes plus preceding CN+CIN byte).
+	 * For the other types, the packet size is always 4 bytes,
+	 * as per the standard, with the data size being 3 for SPP
+	 * and 1 for the others.
+	 * Thus all packet fragments are at least 4 bytes long, so we can
+	 * skip anything that is shorter; this also conveniantly skips
+	 * packets with size 0, which CME devices continuously send when
+	 * they have nothing better to do.
+	 * Another quirk is that sometimes multiple messages are sent
+	 * in the same packet. This has been observed for midi clock
+	 * and active sensing i.e. 0x0f 0xf8 0x00 0x00 0x0f 0xfe 0x00 0x00,
+	 * but also multiple note ons/offs, and control change together
+	 * with MIDI clock. Similarly, some sysex messages are followed by
+	 * the song position pointer in the same packet, and occasionally
+	 * additionally by a midi clock or active sensing.
+	 * We handle this by looping over all data and parsing it along the way.
+	 */
+	while (remaining >= 4) {
+		int source_length = 4; /* default */
+
+		if ((buffer[0] & 0x0f) == 0x0f) {
+			int data_length = 1; /* default */
+
+			if (buffer[1] == 0xf0) {
+				/* Sysex: Find EOX and send on whole message. */
+				/* To kick off the search, skip the first
+				 * two bytes (CN+CIN and SYSEX (0xf0).
+				 */
+				uint8_t *tmp_buf = buffer + 2;
+				int tmp_length = remaining - 2;
+
+				while (tmp_length > 1 && *tmp_buf != 0xf7) {
+					tmp_buf++;
+					tmp_length--;
+				}
+				data_length = tmp_buf - buffer;
+				source_length = data_length + 1;
+			} else if (buffer[1] == 0xf2) {
+				/* Three byte song position pointer */
+				data_length = 3;
+			}
+			snd_usbmidi_input_data(ep, buffer[0] >> 4,
+					       &buffer[1], data_length);
+		} else {
+			/* normal channel events */
+			snd_usbmidi_standard_input(ep, buffer, source_length);
+		}
+		buffer += source_length;
+		remaining -= source_length;
+	}
 }
 
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bcc9948645a0..20ccdd60353b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3249,6 +3249,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_FUNC("teh end!", insn->sec, insn->offset);
 			return -1;
diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index e63dc11fa3a5..48e25be6e163 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -120,6 +120,10 @@ FILE *prepare_output(const char *dirname)
 struct config *prepare_default_config()
 {
 	struct config *config = malloc(sizeof(struct config));
+	if (!config) {
+		perror("malloc");
+		return NULL;
+	}
 
 	dprintf("loading defaults\n");
 
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 2cf6f2f277ab..31820435825b 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -262,9 +262,6 @@ TEST(check_file_mmap)
 		TH_LOG("No read-ahead pages found in memory");
 	}
 
-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
-	}
 	/*
 	 * End of the readahead window. The rest of the pages shouldn't
 	 * be in memory.
diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
new file mode 100755
index 000000000000..1f2b642381d1
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_04"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount on zero copy"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 28192ec98498..c44226b4e0bf 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -24,7 +24,7 @@ fi
 if [[ $cgroup2 ]]; then
   cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup2 none $cgroup_path
     do_umount=1
   fi
@@ -32,7 +32,7 @@ if [[ $cgroup2 ]]; then
 else
   cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup memory,hugetlb $cgroup_path
     do_umount=1
   fi
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index c665b16f1e37..a4123632942d 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -19,7 +19,7 @@ fi
 if [[ $cgroup2 ]]; then
   CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
-    CGROUP_ROOT=/dev/cgroup/memory
+    CGROUP_ROOT=$(mktemp -d)
     mount -t cgroup2 none $CGROUP_ROOT
     do_umount=1
   fi

