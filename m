Return-Path: <stable+bounces-139439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B4AA6A75
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7027B2B9B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83721EDA08;
	Fri,  2 May 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdHU4jb4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F01DE8A6;
	Fri,  2 May 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166057; cv=none; b=VIUwLarRQxuAfiH491DE2m4Wgx7CTrg7xya7u9GrO4jtVwkRUDs0Xdzd8S4WaVNeQROdaJZDQJyGHs0UZHwKru55vlEPI9UR7+HGA3zxWw16GhdkNf6qaYUNV9YXfVyOvvwXqxBXdzUMa70rSnMf66Rc/m0WyeDBNDi7b0mOSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166057; c=relaxed/simple;
	bh=tU9/e4+Ztgt278rvgU5HXyfr2ZoPWxeag1I9tP358zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTRs+Wzo7yFUQ2FVhUX5zOVWCnACpF8o1hyM/0bWl7I/8vekcpuGZyLZGREZWVcCqJDBra0prpmuqeEV6CFS3Olhcoesa7QfKfHU0oe6ZajyyWVgI5nQnOPfSKu4GiTaLLLnV0Mcpn7+4MakbC+ommFkWwOknAIVyygGhVMpZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UdHU4jb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87A6C4CEE4;
	Fri,  2 May 2025 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166057;
	bh=tU9/e4+Ztgt278rvgU5HXyfr2ZoPWxeag1I9tP358zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdHU4jb4TMDNAdavci6VZzzOpuuyTZlU1eSPVgWcgROPbm1N97ar3f6H/yj88daNw
	 lWzr6b30K7Jagky9OvdwZn3z/L/eLk44f+ErZ6/TCV3zEJ8hZgxi2pPi1NLhh8/lPa
	 hrnjGzKKmuDkCQGkTsIBGY/H6qSlXh1cK0x4IRNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.136
Date: Fri,  2 May 2025 08:07:21 +0200
Message-ID: <2025050221-unbitten-dehydrate-7273@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050221-unwashed-food-9850@gregkh>
References: <2025050221-unwashed-food-9850@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index be531bb0f734..2a22ff32509d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 135
+SUBLEVEL = 136
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0166d357069d..6c55d85b1c76 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -51,6 +51,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 59c4608de91d..f5d9096d18aa 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -32,9 +32,9 @@ struct pt_regs {
 	unsigned long __last[];
 } __aligned(8);
 
-static inline int regs_irqs_disabled(struct pt_regs *regs)
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
-	return arch_irqs_disabled_flags(regs->csr_prmd);
+	return !(regs->csr_prmd & CSR_PRMD_PIE);
 }
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index ba138117b124..cf3b8785a921 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -47,7 +47,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 				pmd = pmd_offset(pud, addr);
 		}
 	}
-	return (pte_t *) pmd;
+	return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
 }
 
 /*
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index f42a3be5f28d..3861ae6942a0 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -89,9 +89,6 @@ void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-#ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
-#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
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
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b4f7d950c846..e21c2fd76167 100644
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
index e391b175f5ec..7dbb241a9fb7 100644
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
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index fa0744732444..a8732dd9fedb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -623,7 +623,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
-	if (!event->attr.freq && x86_pmu.limit_period) {
+	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7d73b5311551..0be0edb07a2a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1553,7 +1553,7 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	rrsba_disabled = true;
 }
 
-static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
+static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
 	 * Similar to context switches, there are two types of RSB attacks
@@ -1577,27 +1577,30 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	 */
 	switch (mode) {
 	case SPECTRE_V2_NONE:
-		return;
+		break;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
+	case SPECTRE_V2_EIBRS_LFENCE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
-		return;
+		break;
 
-	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
+		pr_info("Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
-		return;
-	}
+		break;
 
-	pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation at VM exit");
-	dump_stack();
+	default:
+		pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation\n");
+		dump_stack();
+		break;
+	}
 }
 
 /*
@@ -1822,10 +1825,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 *
 	 * FIXME: Is this pointless for retbleed-affected AMD?
 	 */
-	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
-
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	spectre_v2_select_rsb_mitigation(mode);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 80e262bb627f..cb9852ad6098 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -46,7 +46,8 @@ bool __init pit_timer_init(void)
 		 * VMMs otherwise steal CPU time just to pointlessly waggle
 		 * the (masked) IRQ.
 		 */
-		clockevent_i8253_disable();
+		scoped_guard(irq)
+			clockevent_i8253_disable();
 		return false;
 	}
 	clockevent_i8253_init(true);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index fb125b54ee68..0adbf0677b7c 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -839,7 +839,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * Allocating new amd_iommu_pi_data, which will get
 	 * add to the per-vcpu ir_list.
 	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_KERNEL_ACCOUNT);
+	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ir) {
 		ret = -ENOMEM;
 		goto out;
@@ -915,6 +915,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	int idx, ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) ||
@@ -952,6 +953,8 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		    kvm_vcpu_apicv_active(&svm->vcpu)) {
 			struct amd_iommu_pi_data pi;
 
+			enable_remapped_mode = false;
+
 			/* Try to enable guest_mode in IRTE */
 			pi.base = __sme_set(page_to_phys(svm->avic_backing_page) &
 					    AVIC_HPA_MASK);
@@ -970,33 +973,6 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
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
@@ -1012,6 +988,34 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
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
index 1b56c5e5c9fb..0d04382f37af 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -272,6 +272,7 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
@@ -310,21 +311,8 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 
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
 
 		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
 		vcpu_info.vector = irq.vector;
@@ -332,11 +320,12 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
 				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
 
-		if (set)
-			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		else
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
+		if (!set)
+			continue;
 
+		enable_remapped_mode = false;
+
+		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 		if (ret < 0) {
 			printk(KERN_INFO "%s: failed to update PI IRTE\n",
 					__func__);
@@ -344,6 +333,9 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		}
 	}
 
+	if (enable_remapped_mode)
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
+
 	ret = 0;
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4d5be4956c48..580730b1e589 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13426,7 +13426,8 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
 				  struct kvm_kernel_irq_routing_entry *new)
 {
-	if (new->type != KVM_IRQ_ROUTING_MSI)
+	if (old->type != KVM_IRQ_ROUTING_MSI ||
+	    new->type != KVM_IRQ_ROUTING_MSI)
 		return true;
 
 	return !!memcmp(&old->msi, &new->msi, sizeof(new->msi));
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b07e2167fceb..8d46b9c0e920 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -385,9 +385,9 @@ static void cond_mitigation(struct task_struct *next)
 	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
 
 	/*
-	 * Avoid user/user BTB poisoning by flushing the branch predictor
-	 * when switching between processes. This stops one process from
-	 * doing Spectre-v2 attacks on another.
+	 * Avoid user->user BTB/RSB poisoning by flushing them when switching
+	 * between processes. This stops one process from doing Spectre-v2
+	 * attacks on another.
 	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
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
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 63803091f8b1..577698739090 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2260,6 +2260,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
 		},
 	},
+	/*
+	 * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
+	 * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
+		}
+	},
 	{ },
 };
 
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index ced3eb15bd8b..79a83d8236cb 100644
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
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index d56a5d508ccd..8b690f59df27 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,13 +313,13 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
 }
 
-static int hd44780_remove(struct platform_device *pdev)
+static void hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -328,8 +328,7 @@ static int hd44780_remove(struct platform_device *pdev)
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
-	return 0;
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {
@@ -340,7 +339,7 @@ MODULE_DEVICE_TABLE(of, hd44780_of_match);
 
 static struct platform_driver hd44780_driver = {
 	.probe = hd44780_probe,
-	.remove = hd44780_remove,
+	.remove_new = hd44780_remove,
 	.driver		= {
 		.name	= "hd44780",
 		.of_match_table = hd44780_of_match,
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1c356bda9dfa..e3e5d533a7ec 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -441,7 +441,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == ITER_SOURCE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 899036ce3802..5c7885307a25 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1615,8 +1615,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
-			__u16 cols;
+			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
@@ -1624,7 +1624,8 @@ static void handle_control_message(struct virtio_device *vdev,
 
 		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
 		       sizeof(size));
-		set_console_size(port, size.rows, size.cols);
+		set_console_size(port, virtio16_to_cpu(vdev, size.rows),
+				 virtio16_to_cpu(vdev, size.cols));
 
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8ecbb8f49465..5a01ba04e47c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5128,6 +5128,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	/* Check if node in clkspec is in disabled/fail state */
+	if (!of_device_is_available(clkspec->np))
+		return ERR_PTR(-ENOENT);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 0b56688ecbfc..ac60251d7284 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -14,6 +14,17 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
+/* Clock status configuration. */
+#define SEL_SDHI0_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
+#define SEL_SDHI1_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
@@ -75,8 +86,12 @@ static const struct clk_div_table dtable_1_32[] = {
 
 /* Mux clock tables */
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
+#ifdef CONFIG_ARM64
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
-static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
+#endif
+static const char * const sel_sdhi[] = { ".clk_533", ".clk_400", ".clk_266" };
+
+static const u32 mtable_sdhi[] = { 1, 2, 3 };
 
 static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	/* External Clock Inputs */
@@ -120,11 +135,18 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2, DIVPL3A, dtable_1_32),
 	DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 	DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
+#ifdef CONFIG_ARM64
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_FIXED("HP", R9A07G043_CLK_HP, CLK_PLL6_250, 1, 1),
+#endif
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, sel_shdi),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, sel_shdi),
+	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_sdhi,
+		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, SEL_SDHI1_STS, sel_sdhi,
+		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
 };
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 02a4fc41bb6e..77e1a3a4ef1e 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -15,6 +15,17 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
+/* Clock status configuration. */
+#define SEL_SDHI0_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
+#define SEL_SDHI1_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
@@ -95,9 +106,11 @@ static const struct clk_div_table dtable_16_128[] = {
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
 static const char * const sel_pll5_4[] = { ".pll5_foutpostdiv", ".pll5_fout1ph0" };
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
-static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
+static const char * const sel_sdhi[] = { ".clk_533", ".clk_400", ".clk_266" };
 static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
+static const u32 mtable_sdhi[] = { 1, 2, 3 };
+
 static const struct {
 	struct cpg_core_clk common[56];
 #ifdef CONFIG_CLK_R9A07G054
@@ -163,8 +176,10 @@ static const struct {
 		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, sel_shdi),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, sel_shdi),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_sdhi,
+			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, SEL_SDHI1_STS, sel_sdhi,
+			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 5617040f307c..af4f40c108d8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -57,15 +57,37 @@
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
 
+#define CPG_WEN_BIT		BIT(16)
+
 #define MAX_VCLK_FREQ		(148500000)
 
-struct sd_hw_data {
+/**
+ * struct clk_hw_data - clock hardware data
+ * @hw: clock hw
+ * @conf: clock configuration (register offset, shift, width)
+ * @sconf: clock status configuration (register offset, shift, width)
+ * @priv: CPG private data structure
+ */
+struct clk_hw_data {
 	struct clk_hw hw;
 	u32 conf;
+	u32 sconf;
 	struct rzg2l_cpg_priv *priv;
 };
 
-#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw)
+#define to_clk_hw_data(_hw)	container_of(_hw, struct clk_hw_data, hw)
+
+/**
+ * struct sd_mux_hw_data - SD MUX clock hardware data
+ * @hw_data: clock hw data
+ * @mtable: clock mux table
+ */
+struct sd_mux_hw_data {
+	struct clk_hw_data hw_data;
+	const u32 *mtable;
+};
+
+#define to_sd_mux_hw_data(_hw)	container_of(_hw, struct sd_mux_hw_data, hw_data)
 
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
@@ -119,6 +141,76 @@ static void rzg2l_cpg_del_clk_provider(void *data)
 	of_clk_del_provider(data);
 }
 
+/* Must be called in atomic context. */
+static int rzg2l_cpg_wait_clk_update_done(void __iomem *base, u32 conf)
+{
+	u32 bitmask = GENMASK(GET_WIDTH(conf) - 1, 0) << GET_SHIFT(conf);
+	u32 off = GET_REG_OFFSET(conf);
+	u32 val;
+
+	return readl_poll_timeout_atomic(base + off, val, !(val & bitmask), 10, 200);
+}
+
+int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event,
+				  void *data)
+{
+	struct clk_notifier_data *cnd = data;
+	struct clk_hw *hw = __clk_get_hw(cnd->clk);
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
+	const u32 clk_src_266 = 3;
+	unsigned long flags;
+	int ret;
+
+	if (event != PRE_RATE_CHANGE || (cnd->new_rate / MEGA == 266))
+		return NOTIFY_DONE;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+
+	/*
+	 * As per the HW manual, we should not directly switch from 533 MHz to
+	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
+	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
+	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
+	 * (400 MHz)).
+	 * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
+	 * switching register is prohibited.
+	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
+	 * the index to value mapping is done by adding 1 to the index.
+	 */
+
+	writel((CPG_WEN_BIT | clk_src_266) << shift, priv->base + off);
+
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	if (ret)
+		dev_err(priv->dev, "failed to switch to safe clk source\n");
+
+	return notifier_from_errno(ret);
+}
+
+static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
+				   struct rzg2l_cpg_priv *priv)
+{
+	struct notifier_block *nb;
+
+	if (!core->notifier)
+		return 0;
+
+	nb = devm_kzalloc(priv->dev, sizeof(*nb), GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+
+	nb->notifier_call = core->notifier;
+
+	return clk_notifier_register(hw->clk, nb);
+}
+
 static struct clk * __init
 rzg2l_cpg_div_clk_register(const struct cpg_core_clk *core,
 			   struct clk **clks,
@@ -187,63 +279,44 @@ static int rzg2l_cpg_sd_clk_mux_determine_rate(struct clk_hw *hw,
 
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = hwdata->priv;
-	u32 off = GET_REG_OFFSET(hwdata->conf);
-	u32 shift = GET_SHIFT(hwdata->conf);
-	const u32 clk_src_266 = 2;
-	u32 msk, val, bitmask;
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
 	unsigned long flags;
+	u32 val;
 	int ret;
 
-	/*
-	 * As per the HW manual, we should not directly switch from 533 MHz to
-	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
-	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
-	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
-	 * (400 MHz)).
-	 * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
-	 * switching register is prohibited.
-	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
-	 * the index to value mapping is done by adding 1 to the index.
-	 */
-	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
-	msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+	val = clk_mux_index_to_val(sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
+
 	spin_lock_irqsave(&priv->rmw_lock, flags);
-	if (index != clk_src_266) {
-		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
-
-		ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
-						!(val & msk), 10,
-						CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-		if (ret)
-			goto unlock;
-	}
 
-	writel(bitmask | ((index + 1) << shift), priv->base + off);
+	writel((CPG_WEN_BIT | val) << shift, priv->base + off);
+
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
 
-	ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
-					!(val & msk), 10,
-					CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-unlock:
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 
 	if (ret)
-		dev_err(priv->dev, "failed to switch clk source\n");
+		dev_err(priv->dev, "Failed to switch parent\n");
 
 	return ret;
 }
 
 static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 {
-	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = hwdata->priv;
-	u32 val = readl(priv->base + GET_REG_OFFSET(hwdata->conf));
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 val;
 
-	val >>= GET_SHIFT(hwdata->conf);
-	val &= GENMASK(GET_WIDTH(hwdata->conf) - 1, 0);
+	val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
+	val >>= GET_SHIFT(clk_hw_data->conf);
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
 
-	return val ? val - 1 : 0;
+	return clk_mux_val_to_index(hw, sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
 }
 
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
@@ -257,31 +330,40 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 			      void __iomem *base,
 			      struct rzg2l_cpg_priv *priv)
 {
-	struct sd_hw_data *clk_hw_data;
+	struct sd_mux_hw_data *sd_mux_hw_data;
 	struct clk_init_data init;
 	struct clk_hw *clk_hw;
 	int ret;
 
-	clk_hw_data = devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL);
-	if (!clk_hw_data)
+	sd_mux_hw_data = devm_kzalloc(priv->dev, sizeof(*sd_mux_hw_data), GFP_KERNEL);
+	if (!sd_mux_hw_data)
 		return ERR_PTR(-ENOMEM);
 
-	clk_hw_data->priv = priv;
-	clk_hw_data->conf = core->conf;
+	sd_mux_hw_data->hw_data.priv = priv;
+	sd_mux_hw_data->hw_data.conf = core->conf;
+	sd_mux_hw_data->hw_data.sconf = core->sconf;
+	sd_mux_hw_data->mtable = core->mtable;
 
 	init.name = GET_SHIFT(core->conf) ? "sd1" : "sd0";
 	init.ops = &rzg2l_cpg_sd_clk_mux_ops;
-	init.flags = 0;
+	init.flags = core->flag;
 	init.num_parents = core->num_parents;
 	init.parent_names = core->parent_names;
 
-	clk_hw = &clk_hw_data->hw;
+	clk_hw = &sd_mux_hw_data->hw_data.hw;
 	clk_hw->init = &init;
 
 	ret = devm_clk_hw_register(priv->dev, clk_hw);
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = rzg2l_register_notifier(clk_hw, core, priv);
+	if (ret) {
+		dev_err(priv->dev, "Failed to register notifier for %s\n",
+			core->name);
+		return ERR_PTR(ret);
+	}
+
 	return clk_hw->clk;
 }
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index aefa53a90059..6418961dc882 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -9,6 +9,8 @@
 #ifndef __RENESAS_RZG2L_CPG_H__
 #define __RENESAS_RZG2L_CPG_H__
 
+#include <linux/notifier.h>
+
 #define CPG_SIPLL5_STBY		(0x140)
 #define CPG_SIPLL5_CLK1		(0x144)
 #define CPG_SIPLL5_CLK3		(0x14C)
@@ -19,7 +21,6 @@
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
 #define CPG_PL6_DDIV		(0x210)
-#define CPG_PL2SDHI_DSEL	(0x218)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
@@ -43,8 +44,6 @@
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
-#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	200
-
 /* n = 0/1/2 for PLL1/4/6 */
 #define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * n))
 #define CPG_SAMPLL_CLK2(n)	(0x08 + (16 * n))
@@ -69,9 +68,6 @@
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 #define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
-#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
-#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
-
 #define EXTAL_FREQ_IN_MEGA_HZ	(24)
 
 /**
@@ -90,10 +86,13 @@ struct cpg_core_clk {
 	unsigned int mult;
 	unsigned int type;
 	unsigned int conf;
+	unsigned int sconf;
 	const struct clk_div_table *dtable;
+	const u32 *mtable;
 	const char * const *parent_names;
-	int flag;
-	int mux_flags;
+	notifier_fn_t notifier;
+	u32 flag;
+	u32 mux_flags;
 	int num_parents;
 };
 
@@ -151,10 +150,11 @@ enum clk_types {
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names), \
 		 .mux_flags = CLK_MUX_READ_ONLY)
-#define DEF_SD_MUX(_name, _id, _conf, _parent_names) \
-	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
+#define DEF_SD_MUX(_name, _id, _conf, _sconf, _parent_names, _mtable, _clk_flags, _notifier) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, .sconf = _sconf, \
 		 .parent_names = _parent_names, \
-		 .num_parents = ARRAY_SIZE(_parent_names))
+		 .num_parents = ARRAY_SIZE(_parent_names), \
+		 .mtable = _mtable, .flag = _clk_flags, .notifier = _notifier)
 #define DEF_PLL5_FOUTPOSTDIV(_name, _id, _parent) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SIPLL5, .parent = _parent)
 #define DEF_PLL5_4_MUX(_name, _id, _conf, _parent_names) \
@@ -269,4 +269,6 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
+int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event, void *data);
+
 #endif
diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 951c23fa0369..88f1e7862614 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -87,6 +87,7 @@ struct jr3_pci_poll_delay {
 struct jr3_pci_dev_private {
 	struct timer_list timer;
 	struct comedi_device *dev;
+	bool timer_enable;
 };
 
 union jr3_pci_single_range {
@@ -596,10 +597,11 @@ static void jr3_pci_poll_dev(struct timer_list *t)
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
@@ -748,6 +750,7 @@ static int jr3_pci_auto_attach(struct comedi_device *dev,
 	devpriv->dev = dev;
 	timer_setup(&devpriv->timer, jr3_pci_poll_dev, 0);
 	devpriv->timer.expires = jiffies + msecs_to_jiffies(1000);
+	devpriv->timer_enable = true;
 	add_timer(&devpriv->timer);
 
 	return 0;
@@ -757,8 +760,12 @@ static void jr3_pci_detach(struct comedi_device *dev)
 {
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
-	if (devpriv)
-		del_timer_sync(&devpriv->timer);
+	if (devpriv) {
+		spin_lock_bh(&dev->spinlock);
+		devpriv->timer_enable = false;
+		spin_unlock_bh(&dev->spinlock);
+		timer_delete_sync(&devpriv->timer);
+	}
 
 	comedi_pci_detach(dev);
 }
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 12fc07ed3502..cfa2e3f0e56b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -749,7 +749,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	int ret;
 
 	if (!policy)
-		return -ENODEV;
+		return 0;
 
 	cpu_data = policy->driver_data;
 
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 079940c69ee0..e4989764efe2 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -33,11 +33,17 @@ static const struct scmi_perf_proto_ops *perf_ops;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 433deec4b61f..217073faf60c 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -29,9 +29,16 @@ static struct scpi_ops *scpi_ops;
 
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
index a84b657598c6..51738c730717 100644
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
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index ef99174d81ce..546bba502fbc 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -186,7 +186,7 @@ static long udmabuf_create(struct miscdevice *device,
 	if (!ubuf)
 		return -ENOMEM;
 
-	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
+	pglimit = ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
 	for (i = 0; i < head->count; i++) {
 		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
 			goto err;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e47..78b8a97b2363 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -827,9 +827,9 @@ static int dmatest_func(void *data)
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f4db6c13049d..7dee02e8ba6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2795,16 +2795,16 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	for (k = 0; k < dc_state->stream_count; k++) {
 		bundle->stream_update.stream = dc_state->streams[k];
 
-		for (m = 0; m < dc_state->stream_status->plane_count; m++) {
+		for (m = 0; m < dc_state->stream_status[k].plane_count; m++) {
 			bundle->surface_updates[m].surface =
-				dc_state->stream_status->plane_states[m];
+				dc_state->stream_status[k].plane_states[m];
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
 
 		update_planes_and_stream_adapter(dm->dc,
 					 UPDATE_TYPE_FULL,
-					 dc_state->stream_status->plane_count,
+					 dc_state->stream_status[k].plane_count,
 					 dc_state->streams[k],
 					 &bundle->stream_update,
 					 bundle->surface_updates);
@@ -9358,6 +9358,9 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
 		return true;
 
+	if (amdgpu_in_reset(adev) && state->allow_modeset)
+		return true;
+
 	/* Exit early if we know that we're adding or removing the plane. */
 	if (old_plane_state->crtc != new_plane_state->crtc)
 		return true;
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 70a25949142c..74b0c85944bd 100644
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
@@ -370,12 +370,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = ad7768_scan_direct(indio_dev);
-		if (ret >= 0)
-			*val = ret;
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 182a89bb24ef..caade796bc3c 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -55,6 +55,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5d34416b3468..4421b464947b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3589,7 +3589,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
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
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 76f7ca53d812..38e77a4b6b33 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2068,14 +2068,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
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
@@ -2214,10 +2209,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
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
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index b93404d65650..e82d9543a0c5 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -28,6 +28,13 @@ static const unsigned long rodata = 0xAA55AA55;
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
+/*
+ * This is a pointer to do_nothing() which is initialized at runtime rather
+ * than build time to avoid objtool IBT validation warnings caused by an
+ * inlined unrolled memcpy() in execute_location().
+ */
+static void __ro_after_init *do_nothing_ptr;
+
 /*
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
@@ -65,13 +72,12 @@ static noinline void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
-	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing_text);
+	pr_info("attempting ok execution at %px\n", do_nothing_ptr);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing_text, EXEC_SIZE);
+		memcpy(dst, do_nothing_ptr, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
@@ -267,6 +273,8 @@ static void lkdtm_ACCESS_NULL(void)
 
 void __init lkdtm_perms_init(void)
 {
+	do_nothing_ptr = dereference_function_descriptor(do_nothing);
+
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 }
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index c6199ded8f6d..e9f40abf21d2 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -37,6 +37,7 @@
 struct pci1xxxx_gpio {
 	struct auxiliary_device *aux_dev;
 	void __iomem *reg_base;
+	raw_spinlock_t wa_lock;
 	struct gpio_chip gpio;
 	spinlock_t lock;
 	int irq_base;
@@ -164,7 +165,7 @@ static void pci1xxxx_gpio_irq_ack(struct irq_data *data)
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	pci1xxx_assign_bit(priv->reg_base, INTR_STAT_OFFSET(gpio), (gpio % 32), true);
+	writel(BIT(gpio % 32), priv->reg_base + INTR_STAT_OFFSET(gpio));
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
@@ -250,6 +251,7 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 	struct pci1xxxx_gpio *priv = dev_id;
 	struct gpio_chip *gc =  &priv->gpio;
 	unsigned long int_status = 0;
+	unsigned long wa_flags;
 	unsigned long flags;
 	u8 pincount;
 	int bit;
@@ -273,7 +275,9 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 			writel(BIT(bit), priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
 			spin_unlock_irqrestore(&priv->lock, flags);
 			irq = irq_find_mapping(gc->irq.domain, (bit + (gpiobank * 32)));
-			handle_nested_irq(irq);
+			raw_spin_lock_irqsave(&priv->wa_lock, wa_flags);
+			generic_handle_irq(irq);
+			raw_spin_unlock_irqrestore(&priv->wa_lock, wa_flags);
 		}
 	}
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index a4668ddd9455..4adfa5af162f 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,7 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
 /*
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index be9b5d36a077..17648443a419 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -124,6 +124,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4c60f79ce269..29e4c94c8405 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -470,11 +470,11 @@ static int mv88e6xxx_port_setup_mac(struct mv88e6xxx_chip *chip, int port,
 	return err;
 }
 
-static int mv88e6xxx_phy_is_internal(struct dsa_switch *ds, int port)
+static int mv88e6xxx_phy_is_internal(struct mv88e6xxx_chip *chip, int port)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
-
-	return port < chip->info->num_internal_phys;
+	return port >= chip->info->internal_phys_offset &&
+		port < chip->info->num_internal_phys +
+			chip->info->internal_phys_offset;
 }
 
 static int mv88e6xxx_port_ppu_updates(struct mv88e6xxx_chip *chip, int port)
@@ -591,7 +591,7 @@ static void mv88e6095_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 
-	if (mv88e6xxx_phy_is_internal(chip->ds, port)) {
+	if (mv88e6xxx_phy_is_internal(chip, port)) {
 		__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
 	} else {
 		if (cmode < ARRAY_SIZE(mv88e6185_phy_interface_modes) &&
@@ -839,7 +839,7 @@ static void mv88e6xxx_get_caps(struct dsa_switch *ds, int port,
 	chip->info->ops->phylink_get_caps(chip, port, config);
 	mv88e6xxx_reg_unlock(chip);
 
-	if (mv88e6xxx_phy_is_internal(ds, port)) {
+	if (mv88e6xxx_phy_is_internal(chip, port)) {
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		/* Internal ports with no phy-mode need GMII for PHYLIB */
@@ -848,29 +848,38 @@ static void mv88e6xxx_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
+static int mv88e6xxx_mac_prepare(struct dsa_switch *ds, int port,
+				 unsigned int mode, phy_interface_t interface)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err = 0;
+
+	/* In inband mode, the link may come up at any time while the link
+	 * is not forced down. Force the link down while we reconfigure the
+	 * interface mode.
+	 */
+	if (mode == MLO_AN_INBAND &&
+	    chip->ports[port].interface != interface &&
+	    chip->info->ops->port_set_link) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->port_set_link(chip, port,
+						     LINK_FORCED_DOWN);
+		mv88e6xxx_reg_unlock(chip);
+	}
+
+	return err;
+}
+
 static void mv88e6xxx_mac_config(struct dsa_switch *ds, int port,
 				 unsigned int mode,
 				 const struct phylink_link_state *state)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
-	struct mv88e6xxx_port *p;
 	int err = 0;
 
-	p = &chip->ports[port];
-
 	mv88e6xxx_reg_lock(chip);
 
-	if (mode != MLO_AN_PHY || !mv88e6xxx_phy_is_internal(ds, port)) {
-		/* In inband mode, the link may come up at any time while the
-		 * link is not forced down. Force the link down while we
-		 * reconfigure the interface mode.
-		 */
-		if (mode == MLO_AN_INBAND &&
-		    p->interface != state->interface &&
-		    chip->info->ops->port_set_link)
-			chip->info->ops->port_set_link(chip, port,
-						       LINK_FORCED_DOWN);
-
+	if (mode != MLO_AN_PHY || !mv88e6xxx_phy_is_internal(chip, port)) {
 		err = mv88e6xxx_port_config_interface(chip, port,
 						      state->interface);
 		if (err && err != -EOPNOTSUPP)
@@ -887,24 +896,38 @@ static void mv88e6xxx_mac_config(struct dsa_switch *ds, int port,
 			err = 0;
 	}
 
+err_unlock:
+	mv88e6xxx_reg_unlock(chip);
+
+	if (err && err != -EOPNOTSUPP)
+		dev_err(ds->dev, "p%d: failed to configure MAC/PCS\n", port);
+}
+
+static int mv88e6xxx_mac_finish(struct dsa_switch *ds, int port,
+				unsigned int mode, phy_interface_t interface)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err = 0;
+
 	/* Undo the forced down state above after completing configuration
 	 * irrespective of its state on entry, which allows the link to come
 	 * up in the in-band case where there is no separate SERDES. Also
 	 * ensure that the link can come up if the PPU is in use and we are
 	 * in PHY mode (we treat the PPU as an effective in-band mechanism.)
 	 */
+	mv88e6xxx_reg_lock(chip);
+
 	if (chip->info->ops->port_set_link &&
-	    ((mode == MLO_AN_INBAND && p->interface != state->interface) ||
+	    ((mode == MLO_AN_INBAND &&
+	      chip->ports[port].interface != interface) ||
 	     (mode == MLO_AN_PHY && mv88e6xxx_port_ppu_updates(chip, port))))
-		chip->info->ops->port_set_link(chip, port, LINK_UNFORCED);
-
-	p->interface = state->interface;
+		err = chip->info->ops->port_set_link(chip, port, LINK_UNFORCED);
 
-err_unlock:
 	mv88e6xxx_reg_unlock(chip);
 
-	if (err && err != -EOPNOTSUPP)
-		dev_err(ds->dev, "p%d: failed to configure MAC/PCS\n", port);
+	chip->ports[port].interface = interface;
+
+	return err;
 }
 
 static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
@@ -5150,6 +5173,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5174,8 +5198,10 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5198,6 +5224,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5221,8 +5248,10 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5790,7 +5819,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6189,9 +6218,11 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6214,9 +6245,11 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6225,6 +6258,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
@@ -6247,7 +6281,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -7024,7 +7058,9 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_teardown		= mv88e6xxx_port_teardown,
 	.phylink_get_caps	= mv88e6xxx_get_caps,
 	.phylink_mac_link_state	= mv88e6xxx_serdes_pcs_get_state,
+	.phylink_mac_prepare	= mv88e6xxx_mac_prepare,
 	.phylink_mac_config	= mv88e6xxx_mac_config,
+	.phylink_mac_finish	= mv88e6xxx_mac_finish,
 	.phylink_mac_an_restart	= mv88e6xxx_serdes_pcs_an_restart,
 	.phylink_mac_link_down	= mv88e6xxx_mac_link_down,
 	.phylink_mac_link_up	= mv88e6xxx_mac_link_up,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index b34e96e689d5..4a8b56ed1bd6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -167,6 +167,11 @@ struct mv88e6xxx_info {
 
 	/* Supports PTP */
 	bool ptp_support;
+
+	/* Internal PHY start index. 0 means that internal PHYs range starts at
+	 * port 0, 1 means internal PHYs range starts at port 1, etc
+	 */
+	unsigned int internal_phys_offset;
 };
 
 struct mv88e6xxx_atu_entry {
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index ac302a935ce6..8480d08e6f94 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1184,31 +1184,22 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip)
 int mv88e6xxx_g2_irq_mdio_setup(struct mv88e6xxx_chip *chip,
 				struct mii_bus *bus)
 {
-	int phy, irq, err, err_phy;
+	int phy_start = chip->info->internal_phys_offset;
+	int phy_end = chip->info->internal_phys_offset +
+		      chip->info->num_internal_phys;
+	int phy, irq;
 
-	for (phy = 0; phy < chip->info->num_internal_phys; phy++) {
+	for (phy = phy_start; phy < phy_end; phy++) {
 		irq = irq_find_mapping(chip->g2_irq.domain, phy);
-		if (irq < 0) {
-			err = irq;
-			goto out;
-		}
+		if (irq < 0)
+			return irq;
+
 		bus->irq[chip->info->phy_base_addr + phy] = irq;
 	}
 	return 0;
-out:
-	err_phy = phy;
-
-	for (phy = 0; phy < err_phy; phy++)
-		irq_dispose_mapping(bus->irq[phy]);
-
-	return err;
 }
 
 void mv88e6xxx_g2_irq_mdio_free(struct mv88e6xxx_chip *chip,
 				struct mii_bus *bus)
 {
-	int phy;
-
-	for (phy = 0; phy < chip->info->num_internal_phys; phy++)
-		irq_dispose_mapping(bus->irq[phy]);
 }
diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb9da..6f9d8da76c4d 100644
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
@@ -103,10 +102,9 @@ int phy_led_triggers_register(struct phy_device *phy)
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
@@ -127,11 +125,11 @@ int phy_led_triggers_register(struct phy_device *phy)
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
@@ -145,8 +143,13 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 
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
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4620a0d5c77b..7c390c2c608d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2146,7 +2146,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 
 	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
-	skb_queue_purge(&rtwdev->tx_report.queue);
+	ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
 	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index ab39245e9c2f..05e6911a4044 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -169,7 +169,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 	rtw_warn(rtwdev, "failed to get tx report from firmware\n");
 
 	spin_lock_irqsave(&tx_report->q_lock, flags);
-	skb_queue_purge(&tx_report->queue);
+	ieee80211_purge_tx_queue(rtwdev->hw, &tx_report->queue);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 8425226c09f0..69ef50fb2e1b 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -985,20 +985,27 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_TX:
-		get_page(pdata);
 		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			trace_xdp_exception(queue->info->netdev, prog, act);
+			break;
+		}
+		get_page(pdata);
 		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
-		if (unlikely(!err))
+		if (unlikely(err <= 0)) {
+			if (err < 0)
+				trace_xdp_exception(queue->info->netdev, prog, act);
 			xdp_return_frame_rx_napi(xdpf);
-		else if (unlikely(err < 0))
-			trace_xdp_exception(queue->info->netdev, prog, act);
+		}
 		break;
 	case XDP_REDIRECT:
 		get_page(pdata);
 		err = xdp_do_redirect(queue->info->netdev, xdp, prog);
 		*need_xdp_flush = true;
-		if (unlikely(err))
+		if (unlikely(err)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_buff(xdp);
+		}
 		break;
 	case XDP_PASS:
 	case XDP_DROP:
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 730f2103b91d..9c8dd5dea273 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1323,6 +1323,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 51799fccf840..6f7620b15303 100644
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
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a636fe6506b..4c40ebb9503d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4704,6 +4704,15 @@ static void nvme_scan_work(struct work_struct *work)
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
index d40d5a4ea932..570c58d2b5a5 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1030,33 +1030,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * Caller holds a reference on tgtport.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1065,6 +1056,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
@@ -1099,7 +1091,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *
diff --git a/drivers/of/device.c b/drivers/of/device.c
index ce225d2590b5..91d92bfe5735 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -264,14 +264,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
 			 of_node_get_device_type(dev->of_node));
 	tsize = csize;
+	if (csize >= len)
+		csize = len > 0 ? len - 1 : 0;
 	len -= csize;
-	if (str)
-		str += csize;
+	str += csize;
 
 	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
-		if (csize > len)
+		if (csize >= len)
 			continue;
 
 		csize = snprintf(str, len, "C%s", compat);
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index b278ab4338ce..d5c1b2a126a5 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -262,25 +262,22 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
  */
 int of_resolve_phandles(struct device_node *overlay)
 {
-	struct device_node *child, *local_fixups, *refnode;
-	struct device_node *tree_symbols, *overlay_fixups;
+	struct device_node *child, *refnode;
+	struct device_node *overlay_fixups;
+	struct device_node __free(device_node) *local_fixups = NULL;
 	struct property *prop;
 	const char *refpath;
 	phandle phandle, phandle_delta;
 	int err;
 
-	tree_symbols = NULL;
-
 	if (!overlay) {
 		pr_err("null overlay\n");
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (!of_node_check_flag(overlay, OF_DETACHED)) {
 		pr_err("overlay not detached\n");
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	phandle_delta = live_tree_max_phandle() + 1;
@@ -292,7 +289,7 @@ int of_resolve_phandles(struct device_node *overlay)
 
 	err = adjust_local_phandle_references(local_fixups, overlay, phandle_delta);
 	if (err)
-		goto out;
+		return err;
 
 	overlay_fixups = NULL;
 
@@ -301,16 +298,13 @@ int of_resolve_phandles(struct device_node *overlay)
 			overlay_fixups = child;
 	}
 
-	if (!overlay_fixups) {
-		err = 0;
-		goto out;
-	}
+	if (!overlay_fixups)
+		return 0;
 
-	tree_symbols = of_find_node_by_path("/__symbols__");
+	struct device_node __free(device_node) *tree_symbols = of_find_node_by_path("/__symbols__");
 	if (!tree_symbols) {
 		pr_err("no symbols in root of device tree.\n");
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	for_each_property_of_node(overlay_fixups, prop) {
@@ -324,14 +318,12 @@ int of_resolve_phandles(struct device_node *overlay)
 		if (err) {
 			pr_err("node label '%s' not found in live devicetree symbols table\n",
 			       prop->name);
-			goto out;
+			return err;
 		}
 
 		refnode = of_find_node_by_path(refpath);
-		if (!refnode) {
-			err = -ENOENT;
-			goto out;
-		}
+		if (!refnode)
+			return -ENOENT;
 
 		phandle = refnode->phandle;
 		of_node_put(refnode);
@@ -341,11 +333,8 @@ int of_resolve_phandles(struct device_node *overlay)
 			break;
 	}
 
-out:
 	if (err)
 		pr_err("overlay phandle fixup failed: %d\n", err);
-	of_node_put(tree_symbols);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_resolve_phandles);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8a35a9887302..10436a193b3b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6808,60 +6808,70 @@ static void pci_no_domains(void)
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
@@ -6869,6 +6879,13 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
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
index b4ed95c4a5a6..03f7550d8982 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -888,6 +888,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -906,6 +907,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
 	else
 		bus->domain_nr = bridge->domain_nr;
+	if (bus->domain_nr < 0) {
+		err = bus->domain_nr;
+		goto free;
+	}
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
@@ -947,6 +952,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
+	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -1030,9 +1036,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
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
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 4c54c75050dc..22d39e12b236 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -157,6 +157,13 @@ void pci_remove_root_bus(struct pci_bus *bus)
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
 
diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 211ce84d980f..4f334ac5a7a9 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -50,6 +50,7 @@
 
 enum imx8_pcie_phy_type {
 	IMX8MM,
+	IMX8MP,
 };
 
 struct imx8_pcie_phy_drvdata {
@@ -62,6 +63,7 @@ struct imx8_pcie_phy {
 	struct clk		*clk;
 	struct phy		*phy;
 	struct regmap		*iomuxc_gpr;
+	struct reset_control	*perst;
 	struct reset_control	*reset;
 	u32			refclk_pad_mode;
 	u32			tx_deemph_gen1;
@@ -76,11 +78,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	u32 val, pad_mode;
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
 
-	reset_control_assert(imx8_phy->reset);
-
 	pad_mode = imx8_phy->refclk_pad_mode;
 	switch (imx8_phy->drvdata->variant) {
 	case IMX8MM:
+		reset_control_assert(imx8_phy->reset);
+
 		/* Tune PHY de-emphasis setting to pass PCIe compliance. */
 		if (imx8_phy->tx_deemph_gen1)
 			writel(imx8_phy->tx_deemph_gen1,
@@ -89,6 +91,8 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			writel(imx8_phy->tx_deemph_gen2,
 			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
 		break;
+	case IMX8MP: /* Do nothing. */
+		break;
 	}
 
 	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ||
@@ -139,18 +143,21 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
 	usleep_range(100, 200);
 
-	/* Do the PHY common block reset */
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_CMN_RST,
-			   IMX8MM_GPR_PCIE_CMN_RST);
-
 	switch (imx8_phy->drvdata->variant) {
+	case IMX8MP:
+		reset_control_deassert(imx8_phy->perst);
+		fallthrough;
 	case IMX8MM:
 		reset_control_deassert(imx8_phy->reset);
 		usleep_range(200, 500);
 		break;
 	}
 
+	/* Do the PHY common block reset */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_CMN_RST,
+			   IMX8MM_GPR_PCIE_CMN_RST);
+
 	/* Polling to check the phy is ready or not. */
 	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG75,
 				 val, val == PCIE_PHY_CMN_REG75_PLL_DONE,
@@ -158,6 +165,16 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	return ret;
 }
 
+static int imx8_pcie_phy_power_off(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
+
+	reset_control_assert(imx8_phy->reset);
+	reset_control_assert(imx8_phy->perst);
+
+	return 0;
+}
+
 static int imx8_pcie_phy_init(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
@@ -178,6 +195,7 @@ static const struct phy_ops imx8_pcie_phy_ops = {
 	.init		= imx8_pcie_phy_init,
 	.exit		= imx8_pcie_phy_exit,
 	.power_on	= imx8_pcie_phy_power_on,
+	.power_off	= imx8_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
@@ -186,8 +204,14 @@ static const struct imx8_pcie_phy_drvdata imx8mm_drvdata = {
 	.variant = IMX8MM,
 };
 
+static const struct imx8_pcie_phy_drvdata imx8mp_drvdata = {
+	.gpr = "fsl,imx8mp-iomuxc-gpr",
+	.variant = IMX8MP,
+};
+
 static const struct of_device_id imx8_pcie_phy_of_match[] = {
 	{.compatible = "fsl,imx8mm-pcie-phy", .data = &imx8mm_drvdata, },
+	{.compatible = "fsl,imx8mp-pcie-phy", .data = &imx8mp_drvdata, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
@@ -243,6 +267,14 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx8_phy->reset);
 	}
 
+	if (imx8_phy->drvdata->variant == IMX8MP) {
+		imx8_phy->perst =
+			devm_reset_control_get_exclusive(dev, "perst");
+		if (IS_ERR(imx8_phy->perst))
+			return dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
+				      "Failed to get PCIE PHY PERST control\n");
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx8_phy->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(imx8_phy->base))
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 2d6072e9f5a8..6f0d3fda61c2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -242,6 +242,9 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 	int ret;
 
 	chip.label = devm_kasprintf(priv->dev, GFP_KERNEL, "%pOFn", np);
+	if (!chip.label)
+		return -ENOMEM;
+
 	chip.parent = priv->dev;
 	chip.ngpio = priv->npins;
 
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 6ffdc10b32d3..4a29b44e75e6 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -35,6 +35,7 @@
 #define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL1_EXT_TEST	BIT(7)
+#define PCF85063_REG_CTRL1_SWR		0x58
 
 #define PCF85063_REG_CTRL2		0x01
 #define PCF85063_CTRL2_AF		BIT(6)
@@ -606,7 +607,7 @@ static int pcf85063_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, pcf85063);
 
-	err = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL1, &tmp);
+	err = regmap_read(pcf85063->regmap, PCF85063_REG_SC, &tmp);
 	if (err) {
 		dev_err(&client->dev, "RTC chip is not present\n");
 		return err;
@@ -616,6 +617,22 @@ static int pcf85063_probe(struct i2c_client *client)
 	if (IS_ERR(pcf85063->rtc))
 		return PTR_ERR(pcf85063->rtc);
 
+	/*
+	 * If a Power loss is detected, SW reset the device.
+	 * From PCF85063A datasheet:
+	 * There is a low probability that some devices will have corruption
+	 * of the registers after the automatic power-on reset...
+	 */
+	if (tmp & PCF85063_REG_SC_OS) {
+		dev_warn(&client->dev,
+			 "POR issue detected, sending a SW reset\n");
+		err = regmap_write(pcf85063->regmap, PCF85063_REG_CTRL1,
+				   PCF85063_REG_CTRL1_SWR);
+		if (err < 0)
+			dev_warn(&client->dev,
+				 "SW reset failed, trying to continue\n");
+	}
+
 	err = pcf85063_load_capacitance(pcf85063, client->dev.of_node,
 					config->force_cap_7000 ? 7000 : 0);
 	if (err < 0)
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index e5d947c763ea..6a030ba38bf3 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -263,6 +263,19 @@ static struct console sclp_console =
 	.index = 0 /* ttyS0 */
 };
 
+/*
+ *  Release allocated pages.
+ */
+static void __init __sclp_console_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_con_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 /*
  * called by console_init() in drivers/char/tty_io.c at boot-time.
  */
@@ -282,6 +295,10 @@ sclp_console_init(void)
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		if (!page) {
+			__sclp_console_free_pages();
+			return -ENOMEM;
+		}
 		list_add_tail(page, &sclp_con_pages);
 	}
 	sclp_conbuf = NULL;
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 971fbb52740b..432dad2a2266 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -490,6 +490,17 @@ static const struct tty_operations sclp_ops = {
 	.flush_buffer = sclp_tty_flush_buffer,
 };
 
+/* Release allocated pages. */
+static void __init __sclp_tty_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_tty_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 static int __init
 sclp_tty_init(void)
 {
@@ -516,6 +527,7 @@ sclp_tty_init(void)
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL) {
+			__sclp_tty_free_pages();
 			tty_driver_kref_put(driver);
 			return -ENOMEM;
 		}
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 2116f5ee36e2..02855164bf28 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -865,8 +865,28 @@ static void hisi_sas_phyup_work_common(struct work_struct *work,
 		container_of(work, typeof(*phy), works[event]);
 	struct hisi_hba *hisi_hba = phy->hisi_hba;
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
+	struct asd_sas_port *sas_port = sas_phy->port;
+	struct hisi_sas_port *port = phy->port;
+	struct device *dev = hisi_hba->dev;
+	struct domain_device *port_dev;
 	int phy_no = sas_phy->id;
 
+	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags) &&
+	    sas_port && port && (port->id != phy->port_id)) {
+		dev_info(dev, "phy%d's hw port id changed from %d to %llu\n",
+				phy_no, port->id, phy->port_id);
+		port_dev = sas_port->port_dev;
+		if (port_dev && !dev_is_expander(port_dev->dev_type)) {
+			/*
+			 * Set the device state to gone to block
+			 * sending IO to the device.
+			 */
+			set_bit(SAS_DEV_GONE, &port_dev->state);
+			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
+			return;
+		}
+	}
+
 	phy->wait_phyup_cnt = 0;
 	if (phy->identify.target_port_protocols == SAS_PROTOCOL_SSP)
 		hisi_hba->hw->sl_notify_ssp(hisi_hba, phy_no);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 8e3f2f9ddaac..a87c3d7e3e5c 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -720,6 +720,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
+		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8e75eb1b6eab..df61d7b90665 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1158,8 +1158,12 @@ EXPORT_SYMBOL_GPL(scsi_alloc_request);
  */
 static void scsi_cleanup_rq(struct request *rq)
 {
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+
+	cmd->flags = 0;
+
 	if (rq->rq_flags & RQF_DONTPREP) {
-		scsi_mq_uninit_cmd(blk_mq_rq_to_pdu(rq));
+		scsi_mq_uninit_cmd(cmd);
 		rq->rq_flags &= ~RQF_DONTPREP;
 	}
 }
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index df73a2c7120c..13a6ebef0189 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1605,10 +1605,13 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
+	int ret;
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	unsigned long hz_per_byte, byte_limit;
 
-	spi_imx_setupxfer(spi, transfer);
+	ret = spi_imx_setupxfer(spi, transfer);
+	if (ret < 0)
+		return ret;
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
 
 	/* flush rxfifo before transfer */
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 5ac5cb885552..442d42130ec8 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1110,9 +1110,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON(ret == 0)) {
-				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
-					ret);
+			if (WARN_ON_ONCE(ret == 0)) {
+				dev_err_ratelimited(tqspi->dev,
+						    "QSPI Transfer failed with timeout\n");
 				if (tqspi->is_curr_dma_xfer &&
 				    (tqspi->cur_direction & DATA_DIR_TX))
 					dmaengine_terminate_all
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c592032657a1..0668e1645bc5 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -640,11 +640,15 @@ static void tb_scan_port(struct tb_port *port)
 		goto out_rpm_put;
 	}
 
-	tb_retimer_scan(port, true);
-
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
 	if (IS_ERR(sw)) {
+		/*
+		 * Make the downstream retimers available even if there
+		 * is no router connected.
+		 */
+		tb_retimer_scan(port, true);
+
 		/*
 		 * If there is an error accessing the connected switch
 		 * it may be connected to another domain. Also we allow
@@ -704,6 +708,14 @@ static void tb_scan_port(struct tb_port *port)
 	tb_switch_lane_bonding_enable(sw);
 	/* Set the link configured */
 	tb_switch_configure_link(sw);
+	/*
+	 * Scan for downstream retimers. We only scan them after the
+	 * router has been enumerated to avoid issues with certain
+	 * Pluggable devices that expect the host to enumerate them
+	 * within certain timeout.
+	 */
+	tb_retimer_scan(port, true);
+
 	/*
 	 * CL0s and CL1 are enabled and supported together.
 	 * Silently ignore CLx enabling in case CLx is not supported.
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7dd19a281579..fd50342526d1 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1745,6 +1745,12 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	/* Disable DM / single-character modes */
+	msm_write(&device->port, 0, UARTDM_DMEN);
+	msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
+	msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
+	msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
+
 	device->con->write = msm_serial_early_write_dm;
 	return 0;
 }
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 2affd1351ae7..4d7825c4d769 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -583,8 +583,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -592,9 +595,12 @@ static int sifive_serial_startup(struct uart_port *port)
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
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 064829640c18..e981f1f8805f 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -990,9 +990,14 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 	exynos_ufs_config_intr(ufs, DFES_DEF_L4_ERRS, UNIPRO_L4);
 	exynos_ufs_set_unipro_pclk_div(ufs);
 
+	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
+
 	/* unipro */
 	exynos_ufs_config_unipro(ufs);
 
+	if (ufs->drv_data->pre_link)
+		ufs->drv_data->pre_link(ufs);
+
 	/* m-phy */
 	exynos_ufs_phy_init(ufs);
 	if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)) {
@@ -1000,11 +1005,6 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 		exynos_ufs_config_phy_cap_attr(ufs);
 	}
 
-	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
-
-	if (ufs->drv_data->pre_link)
-		ufs->drv_data->pre_link(ufs);
-
 	return 0;
 }
 
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 2b8f98f0707e..c12d7f040171 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1960,6 +1960,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2001,6 +2002,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 07872440a8d9..9a4c7ea1241c 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -324,6 +324,13 @@ static int ci_hdrc_imx_notify_event(struct ci_hdrc *ci, unsigned int event)
 	return ret;
 }
 
+static void ci_hdrc_imx_disable_regulator(void *arg)
+{
+	struct ci_hdrc_imx_data *data = arg;
+
+	regulator_disable(data->hsic_pad_regulator);
+}
+
 static int ci_hdrc_imx_probe(struct platform_device *pdev)
 {
 	struct ci_hdrc_imx_data *data;
@@ -381,6 +388,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 					"Failed to enable HSIC pad regulator\n");
 				goto err_put;
 			}
+			ret = devm_add_action_or_reset(dev,
+					ci_hdrc_imx_disable_regulator, data);
+			if (ret) {
+				dev_err(dev,
+					"Failed to add regulator devm action\n");
+				goto err_put;
+			}
 		}
 	}
 
@@ -419,11 +433,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	ret = imx_get_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	ret = imx_prepare_enable_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	data->phy = devm_usb_get_phy_by_phandle(dev, "fsl,usbphy", 0);
 	if (IS_ERR(data->phy)) {
@@ -449,7 +463,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-		usb_phy_init(pdata.usb_phy);
+		ret = usb_phy_init(pdata.usb_phy);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_clk;
+		}
 	}
 
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
@@ -458,7 +476,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -467,7 +485,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
 		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	if (data->usbmisc_data) {
@@ -501,17 +519,18 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	imx_disable_unprepare_clks(dev);
-disable_hsic_regulator:
-	if (data->hsic_pad_regulator)
-		/* don't overwrite original ret (cf. EPROBE_DEFER) */
-		regulator_disable(data->hsic_pad_regulator);
+qos_remove_request:
 	if (pdata.flags & CI_HDRC_PMQOS)
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 err_put:
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
@@ -532,10 +551,9 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
 		imx_disable_unprepare_clks(&pdev->dev);
 		if (data->plat_data->flags & CI_HDRC_PMQOS)
 			cpu_latency_qos_remove_request(&data->pm_qos_req);
-		if (data->hsic_pad_regulator)
-			regulator_disable(data->hsic_pad_regulator);
 	}
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index eb0f5d7cc756..e3408a67af45 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -726,7 +726,7 @@ static int wdm_open(struct inode *inode, struct file *file)
 		rv = -EBUSY;
 		goto out;
 	}
-
+	smp_rmb(); /* ordered against wdm_wwan_port_stop() */
 	rv = usb_autopm_get_interface(desc->intf);
 	if (rv < 0) {
 		dev_err(&desc->intf->dev, "Error autopm - %d\n", rv);
@@ -829,6 +829,7 @@ static struct usb_class_driver wdm_class = {
 static int wdm_wwan_port_start(struct wwan_port *port)
 {
 	struct wdm_device *desc = wwan_port_get_drvdata(port);
+	int rv;
 
 	/* The interface is both exposed via the WWAN framework and as a
 	 * legacy usbmisc chardev. If chardev is already open, just fail
@@ -848,7 +849,15 @@ static int wdm_wwan_port_start(struct wwan_port *port)
 	wwan_port_txon(port);
 
 	/* Start getting events */
-	return usb_submit_urb(desc->validity, GFP_KERNEL);
+	rv = usb_submit_urb(desc->validity, GFP_KERNEL);
+	if (rv < 0) {
+		wwan_port_txoff(port);
+		desc->manage_power(desc->intf, 0);
+		/* this must be last lest we race with chardev open */
+		clear_bit(WDM_WWAN_IN_USE, &desc->flags);
+	}
+
+	return rv;
 }
 
 static void wdm_wwan_port_stop(struct wwan_port *port)
@@ -859,8 +868,10 @@ static void wdm_wwan_port_stop(struct wwan_port *port)
 	poison_urbs(desc);
 	desc->manage_power(desc->intf, 0);
 	clear_bit(WDM_READ, &desc->flags);
-	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 	unpoison_urbs(desc);
+	smp_wmb(); /* ordered against wdm_open() */
+	/* this must be last lest we open a poisoned device */
+	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 }
 
 static void wdm_wwan_port_tx_complete(struct urb *urb)
@@ -868,7 +879,7 @@ static void wdm_wwan_port_tx_complete(struct urb *urb)
 	struct sk_buff *skb = urb->context;
 	struct wdm_device *desc = skb_shinfo(skb)->destructor_arg;
 
-	usb_autopm_put_interface(desc->intf);
+	usb_autopm_put_interface_async(desc->intf);
 	wwan_port_txon(desc->wwanp);
 	kfree_skb(skb);
 }
@@ -898,7 +909,7 @@ static int wdm_wwan_port_tx(struct wwan_port *port, struct sk_buff *skb)
 	req->bRequestType = (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE);
 	req->bRequest = USB_CDC_SEND_ENCAPSULATED_COMMAND;
 	req->wValue = 0;
-	req->wIndex = desc->inum;
+	req->wIndex = desc->inum; /* already converted */
 	req->wLength = cpu_to_le16(skb->len);
 
 	skb_shinfo(skb)->destructor_arg = desc;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6926bd639ec6..4903c733d37a 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -369,6 +369,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
@@ -383,6 +386,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0904, 0x6103), .driver_info =
 			USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL },
 
+	/* Silicon Motion Flash Drive */
+	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
 			USB_QUIRK_ENDPOINT_IGNORE },
@@ -536,6 +542,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* VLI disk */
+	{ USB_DEVICE(0x2109, 0x0711), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Raydium Touchscreen */
 	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 6110ab1f9131..e2401cc4f155 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -143,11 +143,21 @@ static const struct property_entry dwc3_pci_intel_byt_properties[] = {
 	{}
 };
 
+/*
+ * Intel Merrifield SoC uses these endpoints for tracing and they cannot
+ * be re-allocated if being used because the side band flow control signals
+ * are hard wired to certain endpoints:
+ * - 1 High BW Bulk IN (IN#1) (RTIT)
+ * - 1 1KB BW Bulk IN (IN#8) + 1 1KB BW Bulk OUT (Run Control) (OUT#8)
+ */
+static const u8 dwc3_pci_mrfld_reserved_endpoints[] = { 3, 16, 17 };
+
 static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
+	PROPERTY_ENTRY_U8_ARRAY("snps,reserved-endpoints", dwc3_pci_mrfld_reserved_endpoints),
 	PROPERTY_ENTRY_BOOL("snps,usb2-gadget-lpm-disable"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a8bda2a81acd..8070c55c2170 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -208,15 +208,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
-	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
 		return dev_err_probe(dev, PTR_ERR(reset_gpio),
 				     "Failed to request reset GPIO\n");
 	}
 
 	if (reset_gpio) {
-		/* Toggle ulpi to reset the phy. */
-		gpiod_set_value_cansleep(reset_gpio, 1);
 		usleep_range(5000, 10000);
 		gpiod_set_value_cansleep(reset_gpio, 0);
 		usleep_range(5000, 10000);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f227f6c7c6d7..3360a59c3d33 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -555,6 +555,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -571,8 +572,13 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 		return ret;
 
 	/* Reset resource allocation flags */
-	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
-		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	}
 
 	return 0;
 }
@@ -721,9 +727,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
 		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -3525,6 +3533,8 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
@@ -3713,6 +3723,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
+		return;
+	}
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
@@ -4409,6 +4423,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
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
index 4f3bc27c1c62..73664a123c7a 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -549,6 +549,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index ab12d76b01fb..8aaafba058aa 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1955,6 +1955,12 @@ max3421_remove(struct spi_device *spi)
 	usb_put_hcd(hcd);
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
@@ -1964,6 +1970,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = of_match_ptr(max3421_of_match_table),
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index d7b4f40f9ff4..747d6a0cbb60 100644
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
diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 87f1597a0e5a..257e4d79971f 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -73,13 +73,3 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 
 	return 0;
 }
-
-int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
-{
-	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
-
-	/* Without reset on resume, the HC won't work at all */
-	xhci->quirks |= XHCI_RESET_ON_RESUME;
-
-	return 0;
-}
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index 3be021793cc8..9d26e22c4842 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -12,16 +12,10 @@ struct usb_hcd;
 
 #if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
 int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd);
-int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd);
 #else
 static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 {
 	return 0;
 }
-
-static inline int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
-{
-	return 0;
-}
 #endif
 #endif /* __LINUX_XHCI_MVEBU_H */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b387d39bfb81..59f1cb68e657 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -111,7 +111,7 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
 };
 
 static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
-	.init_quirk = xhci_mvebu_a3700_init_quirk,
+	.quirks = XHCI_RESET_ON_RESUME,
 };
 
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 85a2b3ca0507..0862fdd3e568 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1175,16 +1175,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again, on
-			 * chips where this is known to help. Wait for 100ms.
+			 * Keep retrying until the EP starts and stops again.
 			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
+			/*
+			 * Don't retry forever if we guessed wrong or a defective HC never starts
+			 * the EP or says 'Running' but fails the command. We must give back TDs.
+			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index f1498b511a81..56e1c574f667 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1093,6 +1093,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 52be47d684ea..9acb6f837327 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -442,6 +442,11 @@
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
index 715738d70cbf..b09d95da2fe5 100644
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
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index f54d256e2d54..589dae9ebb63 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -217,7 +217,7 @@ static int led_bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int led_bl_remove(struct platform_device *pdev)
+static void led_bl_remove(struct platform_device *pdev)
 {
 	struct led_bl_data *priv = platform_get_drvdata(pdev);
 	struct backlight_device *bl = priv->bl_dev;
@@ -226,10 +226,11 @@ static int led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
-
-	return 0;
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 }
 
 static const struct of_device_id led_bl_of_match[] = {
@@ -245,7 +246,7 @@ static struct platform_driver led_bl_driver = {
 		.of_match_table	= of_match_ptr(led_bl_of_match),
 	},
 	.probe		= led_bl_probe,
-	.remove		= led_bl_remove,
+	.remove_new	= led_bl_remove,
 };
 
 module_platform_driver(led_bl_driver);
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d5d7c402b651..ab135c3e4341 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -271,7 +271,7 @@ config XEN_PRIVCMD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9e06d1a0d373..3814f09dc4ae 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2224,15 +2224,20 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	 * will always return true.
 	 * So here we need to do extra page alignment for
 	 * filemap_range_has_page().
+	 *
+	 * And do not decrease page_lockend right now, as it can be 0.
 	 */
 	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
-	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
+	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE);
 
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
+		/* The same page or adjacent pages. */
+		if (page_lockend <= page_lockstart)
+			break;
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2244,7 +2249,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * we do, unlock the range and retry.
 		 */
 		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend))
+					    page_lockend - 1))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b565..4d6ba140276b 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
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
index f460150ec73e..abe7f769054f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -406,10 +406,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
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
diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
index 6b231d0d0071..603aae17a693 100644
--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -96,7 +96,7 @@ struct dinode {
 #define di_gengen	u._file._u1._imap._gengen
 
 			union {
-				xtpage_t _xtroot;
+				xtroot_t _xtroot;
 				struct {
 					u8 unused[16];	/* 16: */
 					dxd_t _dxd;	/* 16: */
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 155f66812934..9adb29e7862c 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -673,7 +673,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * This is the special xtree inside the directory for storing
 		 * the directory table
 		 */
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		jfs_ip->xtlid = 0;
@@ -687,7 +687,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * copy xtree root from inode to dinode:
 		 */
 		p = &jfs_ip->i_xtroot;
-		xp = (xtpage_t *) &dp->di_dirtable;
+		xp = (xtroot_t *) &dp->di_dirtable;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
 			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
@@ -716,7 +716,7 @@ int diWrite(tid_t tid, struct inode *ip)
 	 *	regular file: 16 byte (XAD slot) granularity
 	 */
 	if (type & tlckXTREE) {
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		/*
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 721def69e732..dd4264aa9bed 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -66,7 +66,7 @@ struct jfs_inode_info {
 	lid_t	xtlid;		/* lid of xtree lock on directory */
 	union {
 		struct {
-			xtpage_t _xtroot;	/* 288: xtree root */
+			xtroot_t _xtroot;	/* 288: xtree root */
 			struct inomap *_imap;	/* 4: inode map header	*/
 		} file;
 		struct {
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ce4b4760fcb1..dccc8b3f1045 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -783,7 +783,7 @@ struct tlock *txLock(tid_t tid, struct inode *ip, struct metapage * mp,
 			if (mp->xflag & COMMIT_PAGE)
 				p = (xtpage_t *) mp->data;
 			else
-				p = &jfs_ip->i_xtroot;
+				p = (xtpage_t *) &jfs_ip->i_xtroot;
 			xtlck->lwm.offset =
 			    le16_to_cpu(p->header.nextindex);
 		}
@@ -1676,7 +1676,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 
 	if (tlck->type & tlckBTROOT) {
 		lrd->log.redopage.type |= cpu_to_le16(LOG_BTROOT);
-		p = &JFS_IP(ip)->i_xtroot;
+		p = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 		if (S_ISDIR(ip->i_mode))
 			lrd->log.redopage.type |=
 			    cpu_to_le16(LOG_DIR_XTREE);
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 2d304cee884c..5ee618d17e77 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -1213,7 +1213,7 @@ xtSplitRoot(tid_t tid,
 	struct xtlock *xtlck;
 	int rc;
 
-	sp = &JFS_IP(ip)->i_xtroot;
+	sp = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 
 	INCREMENT(xtStat.split);
 
@@ -2098,7 +2098,7 @@ int xtAppend(tid_t tid,		/* transaction id */
  */
 void xtInitRoot(tid_t tid, struct inode *ip)
 {
-	xtpage_t *p;
+	xtroot_t *p;
 
 	/*
 	 * acquire a transaction lock on the root
diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
index 142caafc73b1..15da4e16d8b2 100644
--- a/fs/jfs/jfs_xtree.h
+++ b/fs/jfs/jfs_xtree.h
@@ -65,24 +65,33 @@ struct xadlist {
 #define XTPAGEMAXSLOT	256
 #define XTENTRYSTART	2
 
-/*
- *	xtree page:
- */
-typedef union {
-	struct xtheader {
-		__le64 next;	/* 8: */
-		__le64 prev;	/* 8: */
+struct xtheader {
+	__le64 next;	/* 8: */
+	__le64 prev;	/* 8: */
 
-		u8 flag;	/* 1: */
-		u8 rsrvd1;	/* 1: */
-		__le16 nextindex;	/* 2: next index = number of entries */
-		__le16 maxentry;	/* 2: max number of entries */
-		__le16 rsrvd2;	/* 2: */
+	u8 flag;	/* 1: */
+	u8 rsrvd1;	/* 1: */
+	__le16 nextindex;	/* 2: next index = number of entries */
+	__le16 maxentry;	/* 2: max number of entries */
+	__le16 rsrvd2;	/* 2: */
 
-		pxd_t self;	/* 8: self */
-	} header;		/* (32) */
+	pxd_t self;	/* 8: self */
+};
 
+/*
+ *	xtree root (in inode):
+ */
+typedef union {
+	struct xtheader header;
 	xad_t xad[XTROOTMAXSLOT];	/* 16 * maxentry: xad array */
+} xtroot_t;
+
+/*
+ *	xtree page:
+ */
+typedef union {
+	struct xtheader header;
+	xad_t xad[XTPAGEMAXSLOT];	/* 16 * maxentry: xad array */
 } xtpage_t;
 
 /*
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 72e25842f5dc..46eec986ec9c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -354,6 +354,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
index 9f7c5103bc82..39f203256c4f 100644
--- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -131,6 +131,14 @@
 #define RX_CODEC_DMA_RX_7	126
 #define QUINARY_MI2S_RX		127
 #define QUINARY_MI2S_TX		128
+#define DISPLAY_PORT_RX_0	DISPLAY_PORT_RX
+#define DISPLAY_PORT_RX_1	129
+#define DISPLAY_PORT_RX_2	130
+#define DISPLAY_PORT_RX_3	131
+#define DISPLAY_PORT_RX_4	132
+#define DISPLAY_PORT_RX_5	133
+#define DISPLAY_PORT_RX_6	134
+#define DISPLAY_PORT_RX_7	135
 
 #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
 #define LPASS_CLK_ID_PRI_MI2S_EBIT	2
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 01f97956572c..f3ef1a8965bb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -775,7 +775,14 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	u32 act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	u32 act;
+
+	if (ri->map_id || ri->map_type) {
+		ri->map_id = 0;
+		ri->map_type = BPF_MAP_TYPE_UNSPEC;
+	}
+	act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
 
 	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
 		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28f91982402a..2fd6c6050bb5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1779,6 +1779,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 { return 0; }
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index f96b61d9768e..e26bace77479 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -888,9 +888,15 @@ struct dsa_switch_ops {
 						      phy_interface_t iface);
 	int	(*phylink_mac_link_state)(struct dsa_switch *ds, int port,
 					  struct phylink_link_state *state);
+	int	(*phylink_mac_prepare)(struct dsa_switch *ds, int port,
+				       unsigned int mode,
+				       phy_interface_t interface);
 	void	(*phylink_mac_config)(struct dsa_switch *ds, int port,
 				      unsigned int mode,
 				      const struct phylink_link_state *state);
+	int	(*phylink_mac_finish)(struct dsa_switch *ds, int port,
+				      unsigned int mode,
+				      phy_interface_t interface);
 	void	(*phylink_mac_an_restart)(struct dsa_switch *ds, int port);
 	void	(*phylink_mac_link_down)(struct dsa_switch *ds, int port,
 					 unsigned int mode,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a5a5a2915736..6ef8348b5e93 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2956,6 +2956,19 @@ ieee80211_get_alt_retry_rate(const struct ieee80211_hw *hw,
  */
 void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb);
 
+/**
+ * ieee80211_purge_tx_queue - purge TX skb queue
+ * @hw: the hardware
+ * @skbs: the skbs
+ *
+ * Free a set of transmit skbs. Use this function when device is going to stop
+ * but some transmit skbs without TX status are still queued.
+ * This function does not take the list lock and the caller must hold the
+ * relevant locks to use it.
+ */
+void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
+			      struct sk_buff_head *skbs);
+
 /**
  * DOC: Hardware crypto acceleration
  *
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27..155c495b89ea 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
 
@@ -40,6 +43,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __get_rel_sockaddr
 #define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 5800d13146c3..8f3bf1e17707 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
 
@@ -41,6 +44,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __get_rel_sockaddr
 #define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
 
diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index 1b7bab60434c..69e0dae453bf 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -32,6 +32,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(char, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -47,6 +50,9 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(char, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 1b7a8f764fdd..469b6a64293d 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -38,6 +38,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -53,5 +56,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(unsigned long, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index e3b183e9d18e..816c2da7a46f 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -42,6 +42,9 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_cpumask
+#define __get_cpumask(field) __get_bitmask(field)
+
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field)						\
 	({								\
@@ -51,6 +54,9 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) __get_rel_bitmask(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
 
@@ -113,6 +119,14 @@
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	({								\
+		__print_array(__get_dynamic_array(array),		\
+			      __get_dynamic_array_len(array) / (el_size), \
+			      (el_size));				\
+	})
+
 #undef __print_hex_dump
 #define __print_hex_dump(prefix_str, prefix_type,			\
 			 rowsize, groupsize, buf, len, ascii)		\
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index fae467ccd0c3..b6f679ae21aa 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -47,6 +47,12 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __cpumask
+#define __cpumask(item) {						\
+	.type = "__data_loc cpumask_t", .name = #item,			\
+	.size = 4, .align = 4,						\
+	.is_signed = 0, .filter_type = FILTER_OTHER },
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -65,5 +71,11 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) {						\
+	.type = "__rel_loc cpumask_t", .name = #item,			\
+	.size = 4, .align = 4,						\
+	.is_signed = 0, .filter_type = FILTER_OTHER },
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index def36fbb8c5c..e30a13be46ba 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -95,10 +95,16 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __cpumask
+#define __cpumask(item) __bitmask(item, nr_cpumask_bits)
+
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_bitmask(item, nr_cpumask_bits)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 3c554a585320..49c32394b53f 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -57,6 +57,16 @@
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __cpumask
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
+
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
+#undef __assign_cpumask
+#define __assign_cpumask(dst, src)					\
+	memcpy(__get_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -98,6 +108,16 @@
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(unsigned long, item, -1)
+
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
+#undef __assign_rel_cpumask
+#define __assign_rel_cpumask(dst, src)					\
+	memcpy(__get_rel_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8a7ec24c246d..5e3e43adb73e 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -13,13 +13,16 @@
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_cpumask
 #undef __get_sockaddr
 #undef __get_rel_dynamic_array
 #undef __get_rel_dynamic_array_len
 #undef __get_rel_str
 #undef __get_rel_bitmask
+#undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
+#undef __print_dynamic_array
 #undef __print_hex_dump
 
 /*
diff --git a/init/Kconfig b/init/Kconfig
index b6786ddc88a8..8b6a2848da4a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -678,7 +678,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42622..24d96a2fe062 100644
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
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 26ea5d04f56c..cf0da0f844f9 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -131,6 +131,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 choice
 	prompt "Which hash algorithm should modules be signed with?"
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	default MODULE_SIG_SHA512
 	help
 	  This determines which sort of hashing algorithm will be used during
 	  signature generation.  This algorithm _must_ be built into the kernel
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6b5bb0e380b5..7254c808b27c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -403,7 +403,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
-static void __set_printk_clr_event(void)
+static void __set_printk_clr_event(struct work_struct *work)
 {
 	/*
 	 * This program might be calling bpf_trace_printk,
@@ -416,10 +416,11 @@ static void __set_printk_clr_event(void)
 	if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
 		pr_warn_ratelimited("could not enable bpf_trace_printk events");
 }
+static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
 
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_printk_proto;
 }
 
@@ -462,7 +463,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_vprintk_proto;
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed0d0c8a2b4b..8723ad2f9c63 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -456,6 +456,7 @@ static void test_event_printk(struct trace_event_call *call)
 			case '%':
 				continue;
 			case 'p':
+ do_pointer:
 				/* Find dereferencing fields */
 				switch (fmt[i + 1]) {
 				case 'B': case 'R': case 'r':
@@ -484,6 +485,12 @@ static void test_event_printk(struct trace_event_call *call)
 						continue;
 					if (fmt[i + j] == '*') {
 						star = true;
+						/* Handle %*pbl case */
+						if (!j && fmt[i + 1] == 'p') {
+							arg++;
+							i++;
+							goto do_pointer;
+						}
 						continue;
 					}
 					if ((fmt[i + j] == 's')) {
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 2062be1f2e80..f90f2b9842ec 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -35,18 +35,22 @@ static void test_ubsan_shift_out_of_bounds(void)
 
 static void test_ubsan_out_of_bounds(void)
 {
-	volatile int i = 4, j = 5, k = -1;
-	volatile char above[4] = { }; /* Protect surrounding memory. */
-	volatile int arr[4];
-	volatile char below[4] = { }; /* Protect surrounding memory. */
+	int i = 4, j = 4, k = -1;
+	volatile struct {
+		char above[4]; /* Protect surrounding memory. */
+		int arr[4];
+		char below[4]; /* Protect surrounding memory. */
+	} data;
 
-	above[0] = below[0];
+	OPTIMIZER_HIDE_VAR(i);
+	OPTIMIZER_HIDE_VAR(j);
+	OPTIMIZER_HIDE_VAR(k);
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
-	arr[j] = i;
+	data.arr[j] = i;
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
-	arr[k] = i;
+	data.arr[k] = i;
 }
 
 enum ubsan_test_enum {
diff --git a/net/9p/client.c b/net/9p/client.c
index e876d6fea2fc..e89a91802e03 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1545,7 +1545,8 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
 	int count = iov_iter_count(to);
-	int rsize, received, non_zc = 0;
+	u32 rsize, received;
+	bool non_zc = false;
 	char *dataptr;
 
 	*err = 0;
@@ -1568,7 +1569,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 				       0, 11, "dqd", fid->fid,
 				       offset, rsize);
 	} else {
-		non_zc = 1;
+		non_zc = true;
 		req = p9_client_rpc(clnt, P9_TREAD, "dqd", fid->fid, offset,
 				    rsize);
 	}
@@ -1589,11 +1590,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		return 0;
 	}
 	if (rsize < received) {
-		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1620,9 +1621,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	*err = 0;
 
 	while (iov_iter_count(from)) {
-		int count = iov_iter_count(from);
-		int rsize = fid->iounit;
-		int written;
+		size_t count = iov_iter_count(from);
+		u32 rsize = fid->iounit;
+		u32 written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1630,7 +1631,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
-		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %u (/%zu)\n",
 			 fid->fid, offset, rsize, count);
 
 		/* Don't bother zerocopy for small IO (< 1024) */
@@ -1656,11 +1657,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 		if (rsize < written) {
-			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			pr_err("bogus RWRITE count (%u > %u)\n", written, rsize);
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));
@@ -2056,7 +2057,8 @@ EXPORT_SYMBOL_GPL(p9_client_xattrcreate);
 
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 {
-	int err, rsize, non_zc = 0;
+	int err, non_zc = 0;
+	u32 rsize;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
 	char *dataptr;
@@ -2065,7 +2067,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 
 	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
-	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
+	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %u\n",
 		 fid->fid, offset, count);
 
 	err = 0;
@@ -2101,11 +2103,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 		goto free_and_error;
 	}
 	if (rsize < count) {
-		pr_err("bogus RREADDIR count (%d > %d)\n", count, rsize);
+		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
 		count = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);
 
 	if (non_zc)
 		memmove(data, dataptr, count);
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 4417a18b3e95..f63586c9ce02 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -332,6 +332,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -347,8 +349,10 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -363,11 +367,13 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
+	goto out;
 
 drop:
 	kfree_skb(skb);
 
+out:
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_output);
@@ -379,6 +385,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	local_bh_disable();
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
@@ -395,8 +403,10 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
@@ -411,11 +421,13 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	if (ret == -EOPNOTSUPP)
 		goto drop;
 
-	return ret;
+	goto out;
 
 drop:
 	kfree_skb(skb);
 
+out:
+	local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_xmit);
@@ -427,6 +439,8 @@ int lwtunnel_input(struct sk_buff *skb)
 	struct dst_entry *dst;
 	int ret;
 
+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
 	if (dev_xmit_recursion()) {
 		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
 				     __func__);
diff --git a/net/core/selftests.c b/net/core/selftests.c
index acb1ee97bbd3..7af99d07762e 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -100,10 +100,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	ehdr->h_proto = htons(ETH_P_IP);
 
 	if (attr->tcp) {
+		memset(thdr, 0, sizeof(*thdr));
 		thdr->source = htons(attr->sport);
 		thdr->dest = htons(attr->dport);
 		thdr->doff = sizeof(struct tcphdr) / 4;
-		thdr->check = 0;
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
@@ -144,10 +144,18 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	attr->id = net_test_next_id;
 	shdr->id = net_test_next_id++;
 
-	if (attr->size)
-		skb_put(skb, attr->size);
-	if (attr->max_size && attr->max_size > skb->len)
-		skb_put(skb, attr->max_size - skb->len);
+	if (attr->size) {
+		void *payload = skb_put(skb, attr->size);
+
+		memset(payload, 0, attr->size);
+	}
+
+	if (attr->max_size && attr->max_size > skb->len) {
+		size_t pad_len = attr->max_size - skb->len;
+		void *pad = skb_put(skb, pad_len);
+
+		memset(pad, 0, pad_len);
+	}
 
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 750fe68d9b2a..cd1741792f6a 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1599,6 +1599,21 @@ dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 	return pcs;
 }
 
+static int dsa_port_phylink_mac_prepare(struct phylink_config *config,
+					unsigned int mode,
+					phy_interface_t interface)
+{
+	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_switch *ds = dp->ds;
+	int err = 0;
+
+	if (ds->ops->phylink_mac_prepare)
+		err = ds->ops->phylink_mac_prepare(ds, dp->index, mode,
+						   interface);
+
+	return err;
+}
+
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
@@ -1612,6 +1627,21 @@ static void dsa_port_phylink_mac_config(struct phylink_config *config,
 	ds->ops->phylink_mac_config(ds, dp->index, mode, state);
 }
 
+static int dsa_port_phylink_mac_finish(struct phylink_config *config,
+				       unsigned int mode,
+				       phy_interface_t interface)
+{
+	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
+	struct dsa_switch *ds = dp->ds;
+	int err = 0;
+
+	if (ds->ops->phylink_mac_finish)
+		err = ds->ops->phylink_mac_finish(ds, dp->index, mode,
+						  interface);
+
+	return err;
+}
+
 static void dsa_port_phylink_mac_an_restart(struct phylink_config *config)
 {
 	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
@@ -1667,7 +1697,9 @@ static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
 	.validate = dsa_port_phylink_validate,
 	.mac_select_pcs = dsa_port_phylink_mac_select_pcs,
 	.mac_pcs_get_state = dsa_port_phylink_mac_pcs_get_state,
+	.mac_prepare = dsa_port_phylink_mac_prepare,
 	.mac_config = dsa_port_phylink_mac_config,
+	.mac_finish = dsa_port_phylink_mac_finish,
 	.mac_an_restart = dsa_port_phylink_mac_an_restart,
 	.mac_link_down = dsa_port_phylink_mac_link_down,
 	.mac_link_up = dsa_port_phylink_mac_link_up,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8a3af4144d3f..4cd413bd764f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1984,8 +1984,6 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  u32 info_flags,
 				  u32 ctrl_flags,
 				  u64 *cookie);
-void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
-			      struct sk_buff_head *skbs);
 struct sk_buff *
 ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 info_flags);
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3f9ddd7f04b6..3a96aa306616 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1294,3 +1294,4 @@ void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
 	while ((skb = __skb_dequeue(skbs)))
 		ieee80211_free_txskb(hw, skb);
 }
+EXPORT_SYMBOL(ieee80211_purge_tx_queue);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 36395e5db3b4..bbc34987bd09 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -255,31 +255,31 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
 	m_eaction = READ_ONCE(m->tcfm_eaction);
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	retval = READ_ONCE(m->tcf_action);
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
-		goto out;
+		goto err_cant_do;
 	}
 
 	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
-		goto out;
+		goto err_cant_do;
 	}
 
 	/* we could easily avoid the clone only if called by ingress and clsact;
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
 	 */
-	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	at_ingress = skb_at_tc_ingress(skb);
 	use_reinsert = at_ingress && is_redirect &&
 		       tcf_mirred_can_reinsert(retval);
 	if (!use_reinsert) {
 		skb2 = skb_clone(skb, GFP_ATOMIC);
 		if (!skb2)
-			goto out;
+			goto err_cant_do;
 	}
 
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
@@ -321,12 +321,16 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	err = tcf_mirred_forward(want_ingress, skb2);
-	if (err) {
-out:
+	if (err)
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (tcf_mirred_is_act_redirect(m_eaction))
-			retval = TC_ACT_SHOT;
-	}
+	__this_cpu_dec(mirred_nest_level);
+
+	return retval;
+
+err_cant_do:
+	if (is_redirect)
+		retval = TC_ACT_SHOT;
+	tcf_action_inc_overlimit_qstats(&m->common);
 	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 54dddc2ff502..dbed490aafd3 100644
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
@@ -1631,10 +1636,16 @@ hfsc_dequeue(struct Qdisc *sch)
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
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 9618e4429f0f..23efd35adaa3 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -716,7 +716,8 @@ void tipc_mon_reinit_self(struct net *net)
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
-		mon->self->addr = tipc_own_addr(net);
+		if (mon->self)
+			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
 }
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 608c4ae3b08a..ecc7db237f2e 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -50,7 +50,7 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)
 
 	trace_foo_with_template_print("I have to be different", cnt);
 
-	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask);
+	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask, current->cpus_ptr);
 }
 
 static void simple_thread_func(int cnt)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1a92226202fc..06be777b3b14 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -200,6 +200,16 @@
  *
  *         __assign_bitmask(target_cpus, cpumask_bits(bar), nr_cpumask_bits);
  *
+ *   __cpumask: This is pretty much the same as __bitmask but is specific for
+ *         CPU masks. The type displayed to the user via the format files will
+ *         be "cpumaks_t" such that user space may deal with them differently
+ *         if they choose to do so, and the bits is always set to nr_cpumask_bits.
+ *
+ *         __cpumask(target_cpu)
+ *
+ *         To assign a cpumask, use the __assign_cpumask() helper macro.
+ *
+ *         __assign_cpumask(target_cpus, cpumask_bits(bar));
  *
  * fast_assign: This is a C like function that is used to store the items
  *    into the ring buffer. A special variable called "__entry" will be the
@@ -212,8 +222,8 @@
  *    This is also used to print out the data from the trace files.
  *    Again, the __entry macro is used to access the data from the ring buffer.
  *
- *    Note, __dynamic_array, __string, and __bitmask require special helpers
- *       to access the data.
+ *    Note, __dynamic_array, __string, __bitmask and __cpumask require special
+ *       helpers to access the data.
  *
  *      For __dynamic_array(int, foo, bar) use __get_dynamic_array(foo)
  *            Use __get_dynamic_array_len(foo) to get the length of the array
@@ -226,6 +236,8 @@
  *
  *      For __bitmask(target_cpus, nr_cpumask_bits) use __get_bitmask(target_cpus)
  *
+ *      For __cpumask(target_cpus) use __get_cpumask(target_cpus)
+ *
  *
  * Note, that for both the assign and the printk, __entry is the handler
  * to the data structure in the ring buffer, and is defined by the
@@ -288,7 +300,9 @@ TRACE_EVENT(foo_bar,
 		__dynamic_array(int,	list,   __length_of(lst))
 		__string(	str,	string			)
 		__bitmask(	cpus,	num_possible_cpus()	)
+		__cpumask(	cpum				)
 		__vstring(	vstr,	fmt,	va		)
+		__string_len(	lstr,	foo,	bar / 2 < strlen(foo) ? bar / 2 : strlen(foo) )
 	),
 
 	TP_fast_assign(
@@ -297,11 +311,14 @@ TRACE_EVENT(foo_bar,
 		memcpy(__get_dynamic_array(list), lst,
 		       __length_of(lst) * sizeof(int));
 		__assign_str(str, string);
+		__assign_str(lstr, foo);
 		__assign_vstr(vstr, fmt, va);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
+		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
+		  __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -345,7 +362,17 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
-		  __get_str(str), __get_bitmask(cpus), __get_str(vstr))
+
+/*     A shortcut is to use __print_dynamic_array for dynamic arrays */
+
+		  __print_dynamic_array(list, sizeof(int)),
+
+		  __get_str(str), __get_str(lstr),
+		  __get_bitmask(cpus), __get_cpumask(cpum),
+		  __get_str(vstr),
+		  __get_dynamic_array_len(cpus),
+		  __get_dynamic_array_len(cpus),
+		  __get_dynamic_array(cpus))
 );
 
 /*
@@ -542,15 +569,16 @@ DEFINE_EVENT_PRINT(foo_template, foo_with_template_print,
 
 TRACE_EVENT(foo_rel_loc,
 
-	TP_PROTO(const char *foo, int bar, unsigned long *mask),
+	TP_PROTO(const char *foo, int bar, unsigned long *mask, const cpumask_t *cpus),
 
-	TP_ARGS(foo, bar, mask),
+	TP_ARGS(foo, bar, mask, cpus),
 
 	TP_STRUCT__entry(
 		__rel_string(	foo,	foo	)
 		__field(	int,	bar	)
 		__rel_bitmask(	bitmask,
 			BITS_PER_BYTE * sizeof(unsigned long)	)
+		__rel_cpumask(	cpumask )
 	),
 
 	TP_fast_assign(
@@ -558,10 +586,12 @@ TRACE_EVENT(foo_rel_loc,
 		__entry->bar = bar;
 		__assign_rel_bitmask(bitmask, mask,
 			BITS_PER_BYTE * sizeof(unsigned long));
+		__assign_rel_cpumask(cpumask, cpus);
 	),
 
-	TP_printk("foo_rel_loc %s, %d, %s", __get_rel_str(foo), __entry->bar,
-		  __get_rel_bitmask(bitmask))
+	TP_printk("foo_rel_loc %s, %d, %s, %s", __get_rel_str(foo), __entry->bar,
+		  __get_rel_bitmask(bitmask),
+		  __get_rel_cpumask(cpumask))
 );
 #endif
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 685ef0c610c6..ceeb76a29591 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -263,7 +263,7 @@ objtool-args-$(CONFIG_SLS)				+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
-objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
+objtool-args-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+= --no-unreachable
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 0b5999c819db..04c50f9acda1 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2281,7 +2281,7 @@ static irqreturn_t wcd934x_slim_irq_handler(int irq, void *data)
 {
 	struct wcd934x_codec *wcd = data;
 	unsigned long status = 0;
-	int i, j, port_id;
+	unsigned int i, j, port_id;
 	unsigned int val, int_val = 0;
 	irqreturn_t ret = IRQ_NONE;
 	bool tx;
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index dd78600fc7b0..b96116ea8116 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -13,10 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <dt-bindings/sound/qcom,lpass.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include "lpass-hdmi.h"
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
-#define LPASS_MAX_PORTS			(LPASS_CDC_DMA_VA_TX8 + 1)
+#define LPASS_MAX_PORTS			(DISPLAY_PORT_RX_7 + 1)
 #define LPASS_MAX_MI2S_PORTS			(8)
 #define LPASS_MAX_DMA_CHANNELS			(8)
 #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8bb7452b8f18..8fe38f842e7a 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -496,7 +496,7 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"HDMI Playback", NULL, "HDMI_RX"},
-	{"Display Port Playback", NULL, "DISPLAY_PORT_RX"},
+	{"DISPLAY_PORT_RX_0 Playback", NULL, "DISPLAY_PORT_RX"},
 	{"Slimbus Playback", NULL, "SLIMBUS_0_RX"},
 	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
 	{"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
index f67c16fd90b9..ac937a6bf909 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
@@ -79,6 +79,22 @@
 		.id = did,						\
 	}
 
+#define Q6AFE_DP_RX_DAI(did) {						\
+		.playback = {						\
+			.stream_name = #did" Playback",			\
+			.rates = SNDRV_PCM_RATE_48000 |			\
+				SNDRV_PCM_RATE_96000 |			\
+				SNDRV_PCM_RATE_192000,			\
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+				   SNDRV_PCM_FMTBIT_S24_LE,		\
+			.channels_min = 2,				\
+			.channels_max = 8,				\
+			.rate_min = 48000,				\
+			.rate_max = 192000,				\
+		},							\
+		.name = #did,						\
+		.id = did,						\
+	}
 
 static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
 	{
@@ -528,22 +544,14 @@ static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
 	Q6AFE_TDM_CAP_DAI("Quinary", 5, QUINARY_TDM_TX_5),
 	Q6AFE_TDM_CAP_DAI("Quinary", 6, QUINARY_TDM_TX_6),
 	Q6AFE_TDM_CAP_DAI("Quinary", 7, QUINARY_TDM_TX_7),
-	{
-		.playback = {
-			.stream_name = "Display Port Playback",
-			.rates = SNDRV_PCM_RATE_48000 |
-				 SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE |
-				   SNDRV_PCM_FMTBIT_S24_LE,
-			.channels_min = 2,
-			.channels_max = 8,
-			.rate_max =     192000,
-			.rate_min =	48000,
-		},
-		.id = DISPLAY_PORT_RX,
-		.name = "DISPLAY_PORT",
-	},
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_0),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_1),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_2),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_3),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_4),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_5),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_6),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_7),
 	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_0),
 	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_0),
 	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_1),
@@ -603,6 +611,9 @@ struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
 		case DISPLAY_PORT_RX:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6hdmi_ops;
 			break;
+		case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
+			q6dsp_audio_fe_dais[i].ops = cfg->q6hdmi_ops;
+			break;
 		case SLIMBUS_0_RX ... SLIMBUS_6_TX:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6slim_ops;
 			break;
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index c10d91fff2fb..1ddec1f4f05d 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -337,6 +337,21 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 	if (!snd->substreams)
 		return -ENOMEM;
 
+	/*
+	 * Initialize critical substream fields early in case we hit an
+	 * error path and end up trying to clean up uninitialized structures
+	 * elsewhere.
+	 */
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		vss->snd = snd;
+		vss->sid = i;
+		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		init_waitqueue_head(&vss->msg_empty);
+		spin_lock_init(&vss->lock);
+	}
+
 	info = kcalloc(snd->nsubstreams, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -350,12 +365,6 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 		struct virtio_pcm *vpcm;
 
-		vss->snd = snd;
-		vss->sid = i;
-		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
-		init_waitqueue_head(&vss->msg_empty);
-		spin_lock_init(&vss->lock);
-
 		rc = virtsnd_pcm_build_hw(vss, &info[i]);
 		if (rc)
 			goto on_exit;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6ea78612635b..828c91aaf55b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3368,6 +3368,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (!strncmp(func->name, "__cfi_", 6))
 				return 0;
 
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
@@ -3582,6 +3585,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (!next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
 		}
@@ -3731,6 +3737,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_FUNC("teh end!", insn->sec, insn->offset);
 			return -1;
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 4c88238fc8f0..c0ae86c28d7f 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -261,9 +261,6 @@ TEST(check_file_mmap)
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
index 8e00276b4e69..dc3fc438b3d9 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -27,7 +27,7 @@ fi
 if [[ $cgroup2 ]]; then
   cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup2 none $cgroup_path
     do_umount=1
   fi
@@ -35,7 +35,7 @@ if [[ $cgroup2 ]]; then
 else
   cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup memory,hugetlb $cgroup_path
     do_umount=1
   fi
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index 14d26075c863..302f2c7003f0 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -22,7 +22,7 @@ fi
 if [[ $cgroup2 ]]; then
   CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
-    CGROUP_ROOT=/dev/cgroup/memory
+    CGROUP_ROOT=$(mktemp -d)
     mount -t cgroup2 none $CGROUP_ROOT
     do_umount=1
   fi

