Return-Path: <stable+bounces-105337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285E9F8222
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760427A235E
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195331AB6ED;
	Thu, 19 Dec 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lekdn0M8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5B1AB523;
	Thu, 19 Dec 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629905; cv=none; b=g1mr+q41zl8fIErDrQEtOH1qmGjKjMy7Nd3tHFbrb2+KKkcj2ru0iZfHTvq1OFDiWhOsCsvW6ITpQ9wOEJ5Zjegih2weheuvCDdjbx1dIE7/5EYFSG+6fPlKaeUQ0lA6pJ1ipvAYsBjoLRmeQQPMZpy3vlv+SBUymVKD35Vm3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629905; c=relaxed/simple;
	bh=pEMibVjCix2tCRVMgcQbHbooV2IWHPh0ow001hWEqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh6I7ct+PXCfGufKxtMYj1jPoZ00Tcur2wu1WJR2vYUFyuNCrv/OQQDYMXlxu8UzwEiBeYdng3sdwLQek09OckGO9Nx19pullj/qvlSrEGZ5fPc8X58u5LT8CEh+XEpD4kOtJHyyjnA/xoEX2UL9wx9h9BrVkwAbTHx3RGcwIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lekdn0M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C7C4CED0;
	Thu, 19 Dec 2024 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629905;
	bh=pEMibVjCix2tCRVMgcQbHbooV2IWHPh0ow001hWEqj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lekdn0M8DY4E+jggZ4OVg8C/2pD5O+OER23nqxOWUrb1b0hfskU8cl+QffNU12zGQ
	 +c/IIN9Gr8tZLc8o6Hi1j7Vdta/CPSfvdQRMM4QO+vvNsjvlQPD9bjrxxAuJTVVeB9
	 3C24Kcsu7qcT7a0F6/BH//vZpGeOF5LG+asowjJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.121
Date: Thu, 19 Dec 2024 18:38:11 +0100
Message-ID: <2024121910-tricycle-suspend-7b39@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024121910-flint-available-a248@gregkh>
References: <2024121910-flint-available-a248@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 65b86e487afe..b6d5a3a8febc 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -347,7 +347,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
 
   `int pm_runtime_resume_and_get(struct device *dev);`
     - run pm_runtime_resume(dev) and if successful, increment the device's
-      usage counter; return the result of pm_runtime_resume
+      usage counter; returns 0 on success (whether or not the device's
+      runtime PM status was already 'active') or the error code from
+      pm_runtime_resume() on failure.
 
   `int pm_request_idle(struct device *dev);`
     - submit a request to execute the subsystem-level idle callback for the
diff --git a/Makefile b/Makefile
index 5a7eaf74ff15..ddb75912d2a8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 120
+SUBLEVEL = 121
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d2b93b68fe56..d8fd09de63d5 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -199,6 +199,8 @@ static inline unsigned long long l1tf_pfn_limit(void)
 	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
 }
 
+void init_cpu_devs(void);
+void get_cpu_vendor(struct cpuinfo_x86 *c);
 extern void early_cpu_init(void);
 extern void identify_boot_cpu(void);
 extern void identify_secondary_cpu(struct cpuinfo_x86 *);
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 343b722ccaf2..35d75c19b1e3 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -65,4 +65,19 @@
 
 extern bool __static_call_fixup(void *tramp, u8 op, void *dest);
 
+extern void __static_call_update_early(void *tramp, void *func);
+
+#define static_call_update_early(name, _func)				\
+({									\
+	typeof(&STATIC_CALL_TRAMP(name)) __F = (_func);			\
+	if (static_call_initialized) {					\
+		__static_call_update(&STATIC_CALL_KEY(name),		\
+				     STATIC_CALL_TRAMP_ADDR(name), __F);\
+	} else {							\
+		WRITE_ONCE(STATIC_CALL_KEY(name).func, _func);		\
+		__static_call_update_early(STATIC_CALL_TRAMP_ADDR(name),\
+					   __F);			\
+	}								\
+})
+
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index ab7382f92aff..96bda43538ee 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -8,7 +8,7 @@
 #include <asm/special_insns.h>
 
 #ifdef CONFIG_X86_32
-static inline void iret_to_self(void)
+static __always_inline void iret_to_self(void)
 {
 	asm volatile (
 		"pushfl\n\t"
@@ -19,7 +19,7 @@ static inline void iret_to_self(void)
 		: ASM_CALL_CONSTRAINT : : "memory");
 }
 #else
-static inline void iret_to_self(void)
+static __always_inline void iret_to_self(void)
 {
 	unsigned int tmp;
 
@@ -55,7 +55,7 @@ static inline void iret_to_self(void)
  * Like all of Linux's memory ordering operations, this is a
  * compiler barrier as well.
  */
-static inline void sync_core(void)
+static __always_inline void sync_core(void)
 {
 	/*
 	 * The SERIALIZE instruction is the most straightforward way to
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index e5e0fe10c692..9b4eddd5833a 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -39,9 +39,11 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/pgtable.h>
+#include <linux/instrumentation.h>
 
 #include <trace/events/xen.h>
 
+#include <asm/alternative.h>
 #include <asm/page.h>
 #include <asm/smap.h>
 #include <asm/nospec-branch.h>
@@ -86,11 +88,20 @@ struct xen_dm_op_buf;
  * there aren't more than 5 arguments...)
  */
 
-extern struct { char _entry[32]; } hypercall_page[];
+void xen_hypercall_func(void);
+DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 
-#define __HYPERCALL		"call hypercall_page+%c[offset]"
-#define __HYPERCALL_ENTRY(x)						\
-	[offset] "i" (__HYPERVISOR_##x * sizeof(hypercall_page[0]))
+#ifdef MODULE
+#define __ADDRESSABLE_xen_hypercall
+#else
+#define __ADDRESSABLE_xen_hypercall __ADDRESSABLE_ASM_STR(__SCK__xen_hypercall)
+#endif
+
+#define __HYPERCALL					\
+	__ADDRESSABLE_xen_hypercall			\
+	"call __SCT__xen_hypercall"
+
+#define __HYPERCALL_ENTRY(x)	"a" (x)
 
 #ifdef CONFIG_X86_32
 #define __HYPERCALL_RETREG	"eax"
@@ -148,7 +159,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	__HYPERCALL_0ARG();						\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_0PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER0);				\
 	(type)__res;							\
 })
@@ -159,7 +170,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	__HYPERCALL_1ARG(a1);						\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_1PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER1);				\
 	(type)__res;							\
 })
@@ -170,7 +181,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	__HYPERCALL_2ARG(a1, a2);					\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_2PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER2);				\
 	(type)__res;							\
 })
@@ -181,7 +192,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	__HYPERCALL_3ARG(a1, a2, a3);					\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_3PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER3);				\
 	(type)__res;							\
 })
@@ -192,7 +203,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	__HYPERCALL_4ARG(a1, a2, a3, a4);				\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_4PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER4);				\
 	(type)__res;							\
 })
@@ -206,12 +217,9 @@ xen_single_call(unsigned int call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
-	if (call >= PAGE_SIZE / sizeof(hypercall_page[0]))
-		return -EINVAL;
-
-	asm volatile(CALL_NOSPEC
+	asm volatile(__HYPERCALL
 		     : __HYPERCALL_5PARAM
-		     : [thunk_target] "a" (&hypercall_page[call])
+		     : __HYPERCALL_ENTRY(call)
 		     : __HYPERCALL_CLOBBER5);
 
 	return (long)__res;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d85423ec5bea..62aaabea7e33 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -906,7 +906,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void get_cpu_vendor(struct cpuinfo_x86 *c)
+void get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
 	int i;
@@ -1672,15 +1672,11 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	detect_nopl();
 }
 
-void __init early_cpu_init(void)
+void __init init_cpu_devs(void)
 {
 	const struct cpu_dev *const *cdev;
 	int count = 0;
 
-#ifdef CONFIG_PROCESSOR_SELECT
-	pr_info("KERNEL supported cpus:\n");
-#endif
-
 	for (cdev = __x86_cpu_dev_start; cdev < __x86_cpu_dev_end; cdev++) {
 		const struct cpu_dev *cpudev = *cdev;
 
@@ -1688,20 +1684,30 @@ void __init early_cpu_init(void)
 			break;
 		cpu_devs[count] = cpudev;
 		count++;
+	}
+}
 
+void __init early_cpu_init(void)
+{
 #ifdef CONFIG_PROCESSOR_SELECT
-		{
-			unsigned int j;
-
-			for (j = 0; j < 2; j++) {
-				if (!cpudev->c_ident[j])
-					continue;
-				pr_info("  %s %s\n", cpudev->c_vendor,
-					cpudev->c_ident[j]);
-			}
-		}
+	unsigned int i, j;
+
+	pr_info("KERNEL supported cpus:\n");
 #endif
+
+	init_cpu_devs();
+
+#ifdef CONFIG_PROCESSOR_SELECT
+	for (i = 0; i < X86_VENDOR_NUM && cpu_devs[i]; i++) {
+		for (j = 0; j < 2; j++) {
+			if (!cpu_devs[i]->c_ident[j])
+				continue;
+			pr_info("  %s %s\n", cpu_devs[i]->c_vendor,
+				cpu_devs[i]->c_ident[j]);
+		}
 	}
+#endif
+
 	early_identify_cpu(&boot_cpu_data);
 }
 
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index b32134b093ec..587975eca728 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -170,6 +170,15 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
 
+noinstr void __static_call_update_early(void *tramp, void *func)
+{
+	BUG_ON(system_state != SYSTEM_BOOTING);
+	BUG_ON(!early_boot_irqs_disabled);
+	BUG_ON(static_call_initialized);
+	__text_gen_insn(tramp, JMP32_INSN_OPCODE, tramp, func, JMP32_INSN_SIZE);
+	sync_core();
+}
+
 #ifdef CONFIG_RETHUNK
 /*
  * This is called by apply_returns() to fix up static call trampolines,
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 3c61bb98c10e..31f4a4dd8c62 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -5,6 +5,7 @@
 #endif
 #include <linux/console.h>
 #include <linux/cpu.h>
+#include <linux/instrumentation.h>
 #include <linux/kexec.h>
 #include <linux/slab.h>
 #include <linux/panic_notifier.h>
@@ -25,7 +26,8 @@
 #include "smp.h"
 #include "pmu.h"
 
-EXPORT_SYMBOL_GPL(hypercall_page);
+DEFINE_STATIC_CALL(xen_hypercall, xen_hypercall_hvm);
+EXPORT_STATIC_CALL_TRAMP(xen_hypercall);
 
 /*
  * Pointer to the xen_vcpu_info structure or
@@ -72,6 +74,67 @@ EXPORT_SYMBOL(xen_start_flags);
  */
 struct shared_info *HYPERVISOR_shared_info = &xen_dummy_shared_info;
 
+static __ref void xen_get_vendor(void)
+{
+	init_cpu_devs();
+	cpu_detect(&boot_cpu_data);
+	get_cpu_vendor(&boot_cpu_data);
+}
+
+void xen_hypercall_setfunc(void)
+{
+	if (static_call_query(xen_hypercall) != xen_hypercall_hvm)
+		return;
+
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
+		static_call_update(xen_hypercall, xen_hypercall_amd);
+	else
+		static_call_update(xen_hypercall, xen_hypercall_intel);
+}
+
+/*
+ * Evaluate processor vendor in order to select the correct hypercall
+ * function for HVM/PVH guests.
+ * Might be called very early in boot before vendor has been set by
+ * early_cpu_init().
+ */
+noinstr void *__xen_hypercall_setfunc(void)
+{
+	void (*func)(void);
+
+	/*
+	 * Xen is supported only on CPUs with CPUID, so testing for
+	 * X86_FEATURE_CPUID is a test for early_cpu_init() having been
+	 * run.
+	 *
+	 * Note that __xen_hypercall_setfunc() is noinstr only due to a nasty
+	 * dependency chain: it is being called via the xen_hypercall static
+	 * call when running as a PVH or HVM guest. Hypercalls need to be
+	 * noinstr due to PV guests using hypercalls in noinstr code. So we
+	 * can safely tag the function body as "instrumentation ok", since
+	 * the PV guest requirement is not of interest here (xen_get_vendor()
+	 * calls noinstr functions, and static_call_update_early() might do
+	 * so, too).
+	 */
+	instrumentation_begin();
+
+	if (!boot_cpu_has(X86_FEATURE_CPUID))
+		xen_get_vendor();
+
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
+		func = xen_hypercall_amd;
+	else
+		func = xen_hypercall_intel;
+
+	static_call_update_early(xen_hypercall, func);
+
+	instrumentation_end();
+
+	return func;
+}
+
 static int xen_cpu_up_online(unsigned int cpu)
 {
 	xen_init_lock_cpu(cpu);
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c66807dd0270..3a453207f3c7 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -108,15 +108,8 @@ static void __init init_hvm_pv_info(void)
 	/* PVH set up hypercall page in xen_prepare_pvh(). */
 	if (xen_pvh_domain())
 		pv_info.name = "Xen PVH";
-	else {
-		u64 pfn;
-		uint32_t msr;
-
+	else
 		pv_info.name = "Xen HVM";
-		msr = cpuid_ebx(base + 2);
-		pfn = __pa(hypercall_page);
-		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-	}
 
 	xen_setup_features();
 
@@ -299,6 +292,10 @@ static uint32_t __init xen_platform_hvm(void)
 	if (xen_pv_domain())
 		return 0;
 
+	/* Set correct hypercall function. */
+	if (xen_domain)
+		xen_hypercall_setfunc();
+
 	if (xen_pvh_domain() && nopv) {
 		/* Guest booting via the Xen-PVH boot entry goes here */
 		pr_info("\"nopv\" parameter is ignored in PVH guest\n");
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 9280e15de3af..ee8f452cc58b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1248,6 +1248,9 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
+	/* Interrupts are guaranteed to be off initially. */
+	early_boot_irqs_disabled = true;
+	static_call_update_early(xen_hypercall, xen_hypercall_pv);
 
 	xen_setup_features();
 
@@ -1340,7 +1343,6 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_pv, xen_cpu_dead_pv));
 
 	local_irq_disable();
-	early_boot_irqs_disabled = true;
 
 	xen_raw_console_write("mapping kernel into physical memory\n");
 	xen_setup_kernel_pagetable((pgd_t *)xen_start_info->pt_base,
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index ada3868c02c2..00ee9399fd0c 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -27,17 +27,10 @@ EXPORT_SYMBOL_GPL(xen_pvh);
 
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
-	u32 msr;
-	u64 pfn;
-
 	xen_pvh = 1;
 	xen_domain_type = XEN_HVM_DOMAIN;
 	xen_start_flags = pvh_start_info.flags;
 
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-
 	if (xen_initial_domain())
 		x86_init.oem.arch_setup = xen_add_preferred_consoles;
 	x86_init.oem.banner = xen_banner;
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index dec5e03e7a2c..aa2676a7e2a4 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -20,9 +20,32 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <../entry/calling.h>
 
 .pushsection .noinstr.text, "ax"
+/*
+ * PV hypercall interface to the hypervisor.
+ *
+ * Called via inline asm(), so better preserve %rcx and %r11.
+ *
+ * Input:
+ *	%eax: hypercall number
+ *	%rdi, %rsi, %rdx, %r10, %r8: args 1..5 for the hypercall
+ * Output: %rax
+ */
+SYM_FUNC_START(xen_hypercall_pv)
+	ANNOTATE_NOENDBR
+	push %rcx
+	push %r11
+	UNWIND_HINT_SAVE
+	syscall
+	UNWIND_HINT_RESTORE
+	pop %r11
+	pop %rcx
+	RET
+SYM_FUNC_END(xen_hypercall_pv)
+
 /*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
@@ -176,7 +199,6 @@ SYM_CODE_START(xen_early_idt_handler_array)
 SYM_CODE_END(xen_early_idt_handler_array)
 	__FINIT
 
-hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
 /*
  * Xen64 iret frame:
  *
@@ -186,17 +208,28 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  *	cs
  *	rip		<-- standard iret frame
  *
- *	flags
+ *	flags		<-- xen_iret must push from here on
  *
- *	rcx		}
- *	r11		}<-- pushed by hypercall page
- * rsp->rax		}
+ *	rcx
+ *	r11
+ * rsp->rax
  */
+.macro xen_hypercall_iret
+	pushq $0	/* Flags */
+	push %rcx
+	push %r11
+	push %rax
+	mov  $__HYPERVISOR_iret, %eax
+	syscall		/* Do the IRET. */
+#ifdef CONFIG_MITIGATION_SLS
+	int3
+#endif
+.endm
+
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR
-	pushq $0
-	jmp hypercall_iret
+	xen_hypercall_iret
 SYM_CODE_END(xen_iret)
 
 /*
@@ -301,8 +334,7 @@ SYM_CODE_START(xen_entry_SYSENTER_compat)
 	ENDBR
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
-	pushq $0
-	jmp hypercall_iret
+	xen_hypercall_iret
 SYM_CODE_END(xen_entry_SYSENTER_compat)
 SYM_CODE_END(xen_entry_SYSCALL_compat)
 
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ffaa62167f6e..1cf94caa7600 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -6,9 +6,11 @@
 
 #include <linux/elfnote.h>
 #include <linux/init.h>
+#include <linux/instrumentation.h>
 
 #include <asm/boot.h>
 #include <asm/asm.h>
+#include <asm/frame.h>
 #include <asm/msr.h>
 #include <asm/page_types.h>
 #include <asm/percpu.h>
@@ -20,28 +22,6 @@
 #include <xen/interface/xen-mca.h>
 #include <asm/xen/interface.h>
 
-.pushsection .noinstr.text, "ax"
-	.balign PAGE_SIZE
-SYM_CODE_START(hypercall_page)
-	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_FUNC
-		ANNOTATE_NOENDBR
-		ANNOTATE_UNRET_SAFE
-		ret
-		/*
-		 * Xen will write the hypercall page, and sort out ENDBR.
-		 */
-		.skip 31, 0xcc
-	.endr
-
-#define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
-	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
-#include <asm/xen-hypercalls.h>
-#undef HYPERCALL
-SYM_CODE_END(hypercall_page)
-.popsection
-
 #ifdef CONFIG_XEN_PV
 	__INIT
 SYM_CODE_START(startup_xen)
@@ -80,6 +60,87 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #endif
 #endif
 
+	.pushsection .noinstr.text, "ax"
+/*
+ * Xen hypercall interface to the hypervisor.
+ *
+ * Input:
+ *     %eax: hypercall number
+ *   32-bit:
+ *     %ebx, %ecx, %edx, %esi, %edi: args 1..5 for the hypercall
+ *   64-bit:
+ *     %rdi, %rsi, %rdx, %r10, %r8: args 1..5 for the hypercall
+ * Output: %[er]ax
+ */
+SYM_FUNC_START(xen_hypercall_hvm)
+	ENDBR
+	FRAME_BEGIN
+	/* Save all relevant registers (caller save and arguments). */
+#ifdef CONFIG_X86_32
+	push %eax
+	push %ebx
+	push %ecx
+	push %edx
+	push %esi
+	push %edi
+#else
+	push %rax
+	push %rcx
+	push %rdx
+	push %rdi
+	push %rsi
+	push %r11
+	push %r10
+	push %r9
+	push %r8
+#ifdef CONFIG_FRAME_POINTER
+	pushq $0	/* Dummy push for stack alignment. */
+#endif
+#endif
+	/* Set the vendor specific function. */
+	call __xen_hypercall_setfunc
+	/* Set ZF = 1 if AMD, Restore saved registers. */
+#ifdef CONFIG_X86_32
+	lea xen_hypercall_amd, %ebx
+	cmp %eax, %ebx
+	pop %edi
+	pop %esi
+	pop %edx
+	pop %ecx
+	pop %ebx
+	pop %eax
+#else
+	lea xen_hypercall_amd(%rip), %rbx
+	cmp %rax, %rbx
+#ifdef CONFIG_FRAME_POINTER
+	pop %rax	/* Dummy pop. */
+#endif
+	pop %r8
+	pop %r9
+	pop %r10
+	pop %r11
+	pop %rsi
+	pop %rdi
+	pop %rdx
+	pop %rcx
+	pop %rax
+#endif
+	/* Use correct hypercall function. */
+	jz xen_hypercall_amd
+	jmp xen_hypercall_intel
+SYM_FUNC_END(xen_hypercall_hvm)
+
+SYM_FUNC_START(xen_hypercall_amd)
+	vmmcall
+	RET
+SYM_FUNC_END(xen_hypercall_amd)
+
+SYM_FUNC_START(xen_hypercall_intel)
+	vmcall
+	RET
+SYM_FUNC_END(xen_hypercall_intel)
+	.popsection
+
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
@@ -93,7 +154,6 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #ifdef CONFIG_XEN_PV
 	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
 #endif
-	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,
 		.ascii "!writable_page_tables|pae_pgdir_above_4gb")
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index b2b2f4315b78..3a939418a2f2 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -162,4 +162,13 @@ void xen_hvm_post_suspend(int suspend_cancelled);
 static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
 #endif
 
+#ifdef CONFIG_XEN_PV
+void xen_hypercall_pv(void);
+#endif
+void xen_hypercall_hvm(void);
+void xen_hypercall_amd(void);
+void xen_hypercall_intel(void);
+void xen_hypercall_setfunc(void);
+void *__xen_hypercall_setfunc(void);
+
 #endif /* XEN_OPS_H */
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1b7fd1fc2f33..b7bf1cfdbb4b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1110,10 +1110,14 @@ void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css)
 	struct blkcg *blkcg = css_to_blkcg(blkcg_css);
 
 	do {
+		struct blkcg *parent;
+
 		if (!refcount_dec_and_test(&blkcg->online_pin))
 			break;
+
+		parent = blkcg_parent(blkcg);
 		blkcg_destroy_blkgs(blkcg);
-		blkcg = blkcg_parent(blkcg);
+		blkcg = parent;
 	} while (blkcg);
 }
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 772e909e9fbf..e270e64ba342 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1082,7 +1082,14 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 		inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
 					   iocg->child_active_sum);
 	} else {
-		inuse = clamp_t(u32, inuse, 1, active);
+		/*
+		 * It may be tempting to turn this into a clamp expression with
+		 * a lower limit of 1 but active may be 0, which cannot be used
+		 * as an upper limit in that situation. This expression allows
+		 * active to clamp inuse unless it is 0, in which case inuse
+		 * becomes 1.
+		 */
+		inuse = min(inuse, active) ?: 1;
 	}
 
 	iocg->last_inuse = iocg->inuse;
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 0a8372bf6a77..6fa6b485e30d 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -201,8 +201,6 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 			/* Now we can delete the handler object */
 
-			acpi_os_release_mutex(handler_obj->address_space.
-					      context_mutex);
 			acpi_ut_remove_reference(handler_obj);
 			goto unlock_and_exit;
 		}
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 6d4ac934cd49..1535fe196646 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
-	if (cmd == ND_CMD_CALL)
+	if (cmd == ND_CMD_CALL) {
+		if (!buf || buf_len < sizeof(*call_pkg))
+			return -EINVAL;
+
 		call_pkg = buf;
+	}
+
 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
 	if (func < 0)
 		return func;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d57bc814dec4..b36b8592667d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -250,6 +250,9 @@ static bool acpi_decode_space(struct resource_win *win,
 	switch (addr->resource_type) {
 	case ACPI_MEMORY_RANGE:
 		acpi_dev_memresource_flags(res, len, wp);
+
+		if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
+			res->flags |= IORESOURCE_PREFETCH;
 		break;
 	case ACPI_IO_RANGE:
 		acpi_dev_ioresource_flags(res, len, iodec,
@@ -265,9 +268,6 @@ static bool acpi_decode_space(struct resource_win *win,
 	if (addr->producer_consumer == ACPI_PRODUCER)
 		res->flags |= IORESOURCE_WINDOW;
 
-	if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
-		res->flags |= IORESOURCE_PREFETCH;
-
 	return !(res->flags & IORESOURCE_DISABLED);
 }
 
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index dfbf9493e451..88a44543c598 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -348,6 +348,7 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
 			phy_nodes[phy] = phy_data.np;
 			cphy_base[phy] = of_iomap(phy_nodes[phy], 0);
 			if (cphy_base[phy] == NULL) {
+				of_node_put(phy_data.np);
 				return 0;
 			}
 			phy_count += 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index e668b3baa8c6..1c5d79528ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1284,7 +1284,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
+	struct amdgpu_ring *ring = amdgpu_job_ring(job);
 	unsigned i;
 
 	/* No patching necessary for the first instance */
diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 762127dd56c5..70a854557e6e 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(slab_priorities);
+	kmem_cache_destroy(slab_dependencies);
 	return -ENOMEM;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 26a9f99882e6..ded9e369e403 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1454,6 +1454,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 
 #define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_ENCAP_ALL | \
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 0186482194d2..391c4e3cb66f 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -22,7 +22,7 @@
 #define VSC9959_NUM_PORTS		6
 
 #define VSC9959_TAS_GCL_ENTRY_MAX	63
-#define VSC9959_TAS_MIN_GATE_LEN_NS	33
+#define VSC9959_TAS_MIN_GATE_LEN_NS	35
 #define VSC9959_VCAP_POLICER_BASE	63
 #define VSC9959_VCAP_POLICER_MAX	383
 #define VSC9959_SWITCH_PCI_BAR		4
@@ -1057,11 +1057,15 @@ static void vsc9959_mdio_bus_free(struct ocelot *ocelot)
 	mdiobus_free(felix->imdio);
 }
 
-/* The switch considers any frame (regardless of size) as eligible for
- * transmission if the traffic class gate is open for at least 33 ns.
+/* The switch considers any frame (regardless of size) as eligible
+ * for transmission if the traffic class gate is open for at least
+ * VSC9959_TAS_MIN_GATE_LEN_NS.
+ *
  * Overruns are prevented by cropping an interval at the end of the gate time
- * slot for which egress scheduling is blocked, but we need to still keep 33 ns
- * available for one packet to be transmitted, otherwise the port tc will hang.
+ * slot for which egress scheduling is blocked, but we need to still keep
+ * VSC9959_TAS_MIN_GATE_LEN_NS available for one packet to be transmitted,
+ * otherwise the port tc will hang.
+ *
  * This function returns the size of a gate interval that remains available for
  * setting the guard band, after reserving the space for one egress frame.
  */
@@ -1293,7 +1297,8 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 			 * per-tc static guard band lengths, so it reduces the
 			 * useful gate interval length. Therefore, be careful
 			 * to calculate a guard band (and therefore max_sdu)
-			 * that still leaves 33 ns available in the time slot.
+			 * that still leaves VSC9959_TAS_MIN_GATE_LEN_NS
+			 * available in the time slot.
 			 */
 			max_sdu = div_u64(remaining_gate_len_ps, picos_per_byte);
 			/* A TC gate may be completely closed, which is a
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 5657ac8cfca0..f1a8ae047821 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -2084,7 +2084,7 @@ void t4_idma_monitor(struct adapter *adapter,
 		     struct sge_idma_monitor_state *idma,
 		     int hz, int ticks);
 int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
-		      unsigned int naddr, u8 *addr);
+		      u8 start, unsigned int naddr, u8 *addr);
 void t4_tp_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
 		    u32 start_index, bool sleep_ok);
 void t4_tp_tm_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 9cbce1faab26..7ce112b95b62 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3247,7 +3247,7 @@ static int cxgb4_mgmt_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
 
 	dev_info(pi->adapter->pdev_dev,
 		 "Setting MAC %pM on VF %d\n", mac, vf);
-	ret = t4_set_vf_mac_acl(adap, vf + 1, 1, mac);
+	ret = t4_set_vf_mac_acl(adap, vf + 1, pi->lport, 1, mac);
 	if (!ret)
 		ether_addr_copy(adap->vfinfo[vf].vf_mac_addr, mac);
 	return ret;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 76de55306c4d..175bf9b13058 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -10215,11 +10215,12 @@ int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
  *	t4_set_vf_mac_acl - Set MAC address for the specified VF
  *	@adapter: The adapter
  *	@vf: one of the VFs instantiated by the specified PF
+ *	@start: The start port id associated with specified VF
  *	@naddr: the number of MAC addresses
  *	@addr: the MAC address(es) to be set to the specified VF
  */
 int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
-		      unsigned int naddr, u8 *addr)
+		      u8 start, unsigned int naddr, u8 *addr)
 {
 	struct fw_acl_mac_cmd cmd;
 
@@ -10234,7 +10235,7 @@ int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
 	cmd.en_to_len16 = cpu_to_be32((unsigned int)FW_LEN16(cmd));
 	cmd.nmac = naddr;
 
-	switch (adapter->pf) {
+	switch (start) {
 	case 3:
 		memcpy(cmd.macaddr3, addr, sizeof(cmd.macaddr3));
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
index fc6ae49b5ecc..d462017c6a95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
@@ -195,7 +195,9 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
-		return ERR_PTR(ret);
+		if (ret == -EBUSY)
+			return ERR_PTR(-EBUSY);
+		return NULL;
 	}
 
 	return vport_caps;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 7031f41287e0..1ed69e77b895 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -680,12 +680,11 @@ static int sparx5_start(struct sparx5 *sparx5)
 	err = -ENXIO;
 	if (sparx5->fdma_irq >= 0) {
 		if (GCB_CHIP_ID_REV_ID_GET(sparx5->chip_id) > 0)
-			err = devm_request_threaded_irq(sparx5->dev,
-							sparx5->fdma_irq,
-							NULL,
-							sparx5_fdma_handler,
-							IRQF_ONESHOT,
-							"sparx5-fdma", sparx5);
+			err = devm_request_irq(sparx5->dev,
+					       sparx5->fdma_irq,
+					       sparx5_fdma_handler,
+					       0,
+					       "sparx5-fdma", sparx5);
 		if (!err)
 			err = sparx5_fdma_start(sparx5);
 		if (err)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 212bf6f4ed72..e1df6bc86949 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1113,7 +1113,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	spx5_inst_rmw(DEV10G_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
 		      DEV10G_MAC_MAXLEN_CFG_MAX_LEN,
 		      devinst,
-		      DEV10G_MAC_ENA_CFG(0));
+		      DEV10G_MAC_MAXLEN_CFG(0));
 
 	/* Handle Signal Detect in 10G PCS */
 	spx5_inst_wr(PCS10G_BR_PCS_SD_CFG_SD_POL_SET(sd_pol) |
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index cb32234a5bf1..34a2d8ea3b2d 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -14,6 +14,8 @@
 #include <soc/mscc/ocelot.h>
 #include "ocelot.h"
 
+#define OCELOT_PTP_TX_TSTAMP_TIMEOUT		(5 * HZ)
+
 int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
@@ -495,6 +497,28 @@ static int ocelot_traps_to_ptp_rx_filter(unsigned int proto)
 	return HWTSTAMP_FILTER_NONE;
 }
 
+static int ocelot_ptp_tx_type_to_cmd(int tx_type, int *ptp_cmd)
+{
+	switch (tx_type) {
+	case HWTSTAMP_TX_ON:
+		*ptp_cmd = IFH_REW_OP_TWO_STEP_PTP;
+		break;
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+		/* IFH_REW_OP_ONE_STEP_PTP updates the correctionField,
+		 * what we need to update is the originTimestamp.
+		 */
+		*ptp_cmd = IFH_REW_OP_ORIGIN_PTP;
+		break;
+	case HWTSTAMP_TX_OFF:
+		*ptp_cmd = 0;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
 int ocelot_hwstamp_get(struct ocelot *ocelot, int port, struct ifreq *ifr)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
@@ -521,30 +545,19 @@ EXPORT_SYMBOL(ocelot_hwstamp_get);
 int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	int ptp_cmd, old_ptp_cmd = ocelot_port->ptp_cmd;
 	bool l2 = false, l4 = false;
 	struct hwtstamp_config cfg;
+	bool old_l2, old_l4;
 	int err;
 
 	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
 		return -EFAULT;
 
 	/* Tx type sanity check */
-	switch (cfg.tx_type) {
-	case HWTSTAMP_TX_ON:
-		ocelot_port->ptp_cmd = IFH_REW_OP_TWO_STEP_PTP;
-		break;
-	case HWTSTAMP_TX_ONESTEP_SYNC:
-		/* IFH_REW_OP_ONE_STEP_PTP updates the correctional field, we
-		 * need to update the origin time.
-		 */
-		ocelot_port->ptp_cmd = IFH_REW_OP_ORIGIN_PTP;
-		break;
-	case HWTSTAMP_TX_OFF:
-		ocelot_port->ptp_cmd = 0;
-		break;
-	default:
-		return -ERANGE;
-	}
+	err = ocelot_ptp_tx_type_to_cmd(cfg.tx_type, &ptp_cmd);
+	if (err)
+		return err;
 
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
@@ -569,13 +582,27 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
+	old_l2 = ocelot_port->trap_proto & OCELOT_PROTO_PTP_L2;
+	old_l4 = ocelot_port->trap_proto & OCELOT_PROTO_PTP_L4;
+
 	err = ocelot_setup_ptp_traps(ocelot, port, l2, l4);
 	if (err)
 		return err;
 
+	ocelot_port->ptp_cmd = ptp_cmd;
+
 	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg))) {
+		err = -EFAULT;
+		goto out_restore_ptp_traps;
+	}
+
+	return 0;
+out_restore_ptp_traps:
+	ocelot_setup_ptp_traps(ocelot, port, old_l2, old_l4);
+	ocelot_port->ptp_cmd = old_ptp_cmd;
+	return err;
 }
 EXPORT_SYMBOL(ocelot_hwstamp_set);
 
@@ -607,34 +634,87 @@ int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 }
 EXPORT_SYMBOL(ocelot_get_ts_info);
 
-static int ocelot_port_add_txtstamp_skb(struct ocelot *ocelot, int port,
-					struct sk_buff *clone)
+static struct sk_buff *ocelot_port_dequeue_ptp_tx_skb(struct ocelot *ocelot,
+						      int port, u8 ts_id,
+						      u32 seqid)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	unsigned long flags;
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct ptp_header *hdr;
 
-	spin_lock_irqsave(&ocelot->ts_id_lock, flags);
+	spin_lock(&ocelot->ts_id_lock);
 
-	if (ocelot_port->ptp_skbs_in_flight == OCELOT_MAX_PTP_ID ||
-	    ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
-		spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
-		return -EBUSY;
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (OCELOT_SKB_CB(skb)->ts_id != ts_id)
+			continue;
+
+		/* Check that the timestamp ID is for the expected PTP
+		 * sequenceId. We don't have to test ptp_parse_header() against
+		 * NULL, because we've pre-validated the packet's ptp_class.
+		 */
+		hdr = ptp_parse_header(skb, OCELOT_SKB_CB(skb)->ptp_class);
+		if (seqid != ntohs(hdr->sequence_id))
+			continue;
+
+		__skb_unlink(skb, &ocelot_port->tx_skbs);
+		ocelot->ptp_skbs_in_flight--;
+		skb_match = skb;
+		break;
 	}
 
-	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
-	/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
-	OCELOT_SKB_CB(clone)->ts_id = ocelot_port->ts_id;
+	spin_unlock(&ocelot->ts_id_lock);
 
-	ocelot_port->ts_id++;
-	if (ocelot_port->ts_id == OCELOT_MAX_PTP_ID)
-		ocelot_port->ts_id = 0;
+	return skb_match;
+}
+
+static int ocelot_port_queue_ptp_tx_skb(struct ocelot *ocelot, int port,
+					struct sk_buff *clone)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	DECLARE_BITMAP(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long n;
+
+	spin_lock(&ocelot->ts_id_lock);
+
+	/* To get a better chance of acquiring a timestamp ID, first flush the
+	 * stale packets still waiting in the TX timestamping queue. They are
+	 * probably lost.
+	 */
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (time_before(OCELOT_SKB_CB(skb)->ptp_tx_time +
+				OCELOT_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d invalidating stale timestamp ID %u which seems lost\n",
+					     port, OCELOT_SKB_CB(skb)->ts_id);
+			__skb_unlink(skb, &ocelot_port->tx_skbs);
+			kfree_skb(skb);
+			ocelot->ptp_skbs_in_flight--;
+		} else {
+			__set_bit(OCELOT_SKB_CB(skb)->ts_id, ts_id_in_flight);
+		}
+	}
+
+	if (ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
+		spin_unlock(&ocelot->ts_id_lock);
+		return -EBUSY;
+	}
+
+	n = find_first_zero_bit(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	if (n == OCELOT_MAX_PTP_ID) {
+		spin_unlock(&ocelot->ts_id_lock);
+		return -EBUSY;
+	}
 
-	ocelot_port->ptp_skbs_in_flight++;
+	/* Found an available timestamp ID, use it */
+	OCELOT_SKB_CB(clone)->ts_id = n;
+	OCELOT_SKB_CB(clone)->ptp_tx_time = jiffies;
 	ocelot->ptp_skbs_in_flight++;
+	__skb_queue_tail(&ocelot_port->tx_skbs, clone);
 
-	skb_queue_tail(&ocelot_port->tx_skbs, clone);
+	spin_unlock(&ocelot->ts_id_lock);
 
-	spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
+	dev_dbg_ratelimited(ocelot->dev, "port %d timestamp id %lu\n", port, n);
 
 	return 0;
 }
@@ -691,10 +771,14 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 		if (!(*clone))
 			return -ENOMEM;
 
-		err = ocelot_port_add_txtstamp_skb(ocelot, port, *clone);
-		if (err)
+		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
+		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
+		if (err) {
+			kfree_skb(*clone);
 			return err;
+		}
 
+		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
 		OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
 		OCELOT_SKB_CB(*clone)->ptp_class = ptp_class;
 	}
@@ -730,28 +814,15 @@ static void ocelot_get_hwtimestamp(struct ocelot *ocelot,
 	spin_unlock_irqrestore(&ocelot->ptp_clock_lock, flags);
 }
 
-static bool ocelot_validate_ptp_skb(struct sk_buff *clone, u16 seqid)
-{
-	struct ptp_header *hdr;
-
-	hdr = ptp_parse_header(clone, OCELOT_SKB_CB(clone)->ptp_class);
-	if (WARN_ON(!hdr))
-		return false;
-
-	return seqid == ntohs(hdr->sequence_id);
-}
-
 void ocelot_get_txtstamp(struct ocelot *ocelot)
 {
 	int budget = OCELOT_PTP_QUEUE_SZ;
 
 	while (budget--) {
-		struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u32 val, id, seqid, txport;
-		struct ocelot_port *port;
+		struct sk_buff *skb_match;
 		struct timespec64 ts;
-		unsigned long flags;
 
 		val = ocelot_read(ocelot, SYS_PTP_STATUS);
 
@@ -766,36 +837,14 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
 		seqid = SYS_PTP_STATUS_PTP_MESS_SEQ_ID(val);
 
-		port = ocelot->ports[txport];
-
-		spin_lock(&ocelot->ts_id_lock);
-		port->ptp_skbs_in_flight--;
-		ocelot->ptp_skbs_in_flight--;
-		spin_unlock(&ocelot->ts_id_lock);
-
 		/* Retrieve its associated skb */
-try_again:
-		spin_lock_irqsave(&port->tx_skbs.lock, flags);
-
-		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
-			if (OCELOT_SKB_CB(skb)->ts_id != id)
-				continue;
-			__skb_unlink(skb, &port->tx_skbs);
-			skb_match = skb;
-			break;
-		}
-
-		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
-
-		if (WARN_ON(!skb_match))
-			continue;
-
-		if (!ocelot_validate_ptp_skb(skb_match, seqid)) {
-			dev_err_ratelimited(ocelot->dev,
-					    "port %d received stale TX timestamp for seqid %d, discarding\n",
-					    txport, seqid);
-			dev_kfree_skb_any(skb);
-			goto try_again;
+		skb_match = ocelot_port_dequeue_ptp_tx_skb(ocelot, txport, id,
+							   seqid);
+		if (!skb_match) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
+					     txport, seqid, id);
+			goto next_ts;
 		}
 
 		/* Get the h/w timestamp */
@@ -806,7 +855,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
 		skb_complete_tx_timestamp(skb_match, &shhwtstamps);
 
-		/* Next ts */
+next_ts:
 		ocelot_write(ocelot, SYS_PTP_NXT_PTP_NXT, SYS_PTP_NXT);
 	}
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 926a087ae1c6..b7af824116ea 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(qcaspi_burst_len, "Number of data bytes per burst. Use 1-5000."
 
 #define QCASPI_PLUGGABLE_MIN 0
 #define QCASPI_PLUGGABLE_MAX 1
-static int qcaspi_pluggable = QCASPI_PLUGGABLE_MIN;
+static int qcaspi_pluggable = QCASPI_PLUGGABLE_MAX;
 module_param(qcaspi_pluggable, int, 0);
 MODULE_PARM_DESC(qcaspi_pluggable, "Pluggable SPI connection (yes/no).");
 
@@ -829,7 +829,6 @@ qcaspi_netdev_init(struct net_device *dev)
 
 	dev->mtu = QCAFRM_MAX_MTU;
 	dev->type = ARPHRD_ETHER;
-	qca->clkspeed = qcaspi_clkspeed;
 	qca->burst_len = qcaspi_burst_len;
 	qca->spi_thread = NULL;
 	qca->buffer_size = (dev->mtu + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
@@ -918,17 +917,15 @@ qca_spi_probe(struct spi_device *spi)
 	legacy_mode = of_property_read_bool(spi->dev.of_node,
 					    "qca,legacy-mode");
 
-	if (qcaspi_clkspeed == 0) {
-		if (spi->max_speed_hz)
-			qcaspi_clkspeed = spi->max_speed_hz;
-		else
-			qcaspi_clkspeed = QCASPI_CLK_SPEED;
-	}
+	if (qcaspi_clkspeed)
+		spi->max_speed_hz = qcaspi_clkspeed;
+	else if (!spi->max_speed_hz)
+		spi->max_speed_hz = QCASPI_CLK_SPEED;
 
-	if ((qcaspi_clkspeed < QCASPI_CLK_SPEED_MIN) ||
-	    (qcaspi_clkspeed > QCASPI_CLK_SPEED_MAX)) {
-		dev_err(&spi->dev, "Invalid clkspeed: %d\n",
-			qcaspi_clkspeed);
+	if (spi->max_speed_hz < QCASPI_CLK_SPEED_MIN ||
+	    spi->max_speed_hz > QCASPI_CLK_SPEED_MAX) {
+		dev_err(&spi->dev, "Invalid clkspeed: %u\n",
+			spi->max_speed_hz);
 		return -EINVAL;
 	}
 
@@ -953,14 +950,13 @@ qca_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	dev_info(&spi->dev, "ver=%s, clkspeed=%d, burst_len=%d, pluggable=%d\n",
+	dev_info(&spi->dev, "ver=%s, clkspeed=%u, burst_len=%d, pluggable=%d\n",
 		 QCASPI_DRV_VERSION,
-		 qcaspi_clkspeed,
+		 spi->max_speed_hz,
 		 qcaspi_burst_len,
 		 qcaspi_pluggable);
 
 	spi->mode = SPI_MODE_3;
-	spi->max_speed_hz = qcaspi_clkspeed;
 	if (spi_setup(spi) < 0) {
 		dev_err(&spi->dev, "Unable to setup SPI device\n");
 		return -EFAULT;
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/ethernet/qualcomm/qca_spi.h
index 58ad910068d4..b3b17bd46e12 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -101,7 +101,6 @@ struct qcaspi {
 #endif
 
 	/* user configurable options */
-	u32 clkspeed;
 	u8 legacy_mode;
 	u16 burst_len;
 };
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 293eaf6b3ec9..872640a9e73a 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -984,7 +984,8 @@ static void team_port_disable(struct team *team,
 
 #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
 			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO)
+			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
+			    NETIF_F_GSO_ENCAP_ALL)
 
 #define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 95b5ab4b964e..8425226c09f0 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -867,7 +867,7 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
 static int xennet_close(struct net_device *dev)
 {
 	struct netfront_info *np = netdev_priv(dev);
-	unsigned int num_queues = dev->real_num_tx_queues;
+	unsigned int num_queues = np->queues ? dev->real_num_tx_queues : 0;
 	unsigned int i;
 	struct netfront_queue *queue;
 	netif_tx_stop_all_queues(np->netdev);
@@ -882,6 +882,9 @@ static void xennet_destroy_queues(struct netfront_info *info)
 {
 	unsigned int i;
 
+	if (!info->queues)
+		return;
+
 	for (i = 0; i < info->netdev->real_num_tx_queues; i++) {
 		struct netfront_queue *queue = &info->queues[i];
 
diff --git a/drivers/ptp/ptp_kvm_arm.c b/drivers/ptp/ptp_kvm_arm.c
index b7d28c8dfb84..e68e6943167b 100644
--- a/drivers/ptp/ptp_kvm_arm.c
+++ b/drivers/ptp/ptp_kvm_arm.c
@@ -22,6 +22,10 @@ int kvm_arch_ptp_init(void)
 	return 0;
 }
 
+void kvm_arch_ptp_exit(void)
+{
+}
+
 int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 {
 	return kvm_arch_ptp_get_crosststamp(NULL, ts, NULL);
diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/ptp_kvm_common.c
index fcae32f56f25..051114a59286 100644
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -130,6 +130,7 @@ static struct kvm_ptp_clock kvm_ptp_clock;
 static void __exit ptp_kvm_exit(void)
 {
 	ptp_clock_unregister(kvm_ptp_clock.ptp_clock);
+	kvm_arch_ptp_exit();
 }
 
 static int __init ptp_kvm_init(void)
diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 4991054a2135..5e5b2ef78547 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -14,27 +14,64 @@
 #include <uapi/linux/kvm_para.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/ptp_kvm.h>
+#include <linux/set_memory.h>
 
 static phys_addr_t clock_pair_gpa;
-static struct kvm_clock_pairing clock_pair;
+static struct kvm_clock_pairing clock_pair_glbl;
+static struct kvm_clock_pairing *clock_pair;
 
 int kvm_arch_ptp_init(void)
 {
+	struct page *p;
 	long ret;
 
 	if (!kvm_para_available())
-		return -ENODEV;
+		return -EOPNOTSUPP;
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		p = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!p)
+			return -ENOMEM;
+
+		clock_pair = page_address(p);
+		ret = set_memory_decrypted((unsigned long)clock_pair, 1);
+		if (ret) {
+			__free_page(p);
+			clock_pair = NULL;
+			goto nofree;
+		}
+	} else {
+		clock_pair = &clock_pair_glbl;
+	}
 
-	clock_pair_gpa = slow_virt_to_phys(&clock_pair);
-	if (!pvclock_get_pvti_cpu0_va())
-		return -ENODEV;
+	clock_pair_gpa = slow_virt_to_phys(clock_pair);
+	if (!pvclock_get_pvti_cpu0_va()) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
 
 	ret = kvm_hypercall2(KVM_HC_CLOCK_PAIRING, clock_pair_gpa,
 			     KVM_CLOCK_PAIRING_WALLCLOCK);
-	if (ret == -KVM_ENOSYS)
-		return -ENODEV;
+	if (ret == -KVM_ENOSYS) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
 
 	return ret;
+
+err:
+	kvm_arch_ptp_exit();
+nofree:
+	return ret;
+}
+
+void kvm_arch_ptp_exit(void)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		WARN_ON(set_memory_encrypted((unsigned long)clock_pair, 1));
+		free_page((unsigned long)clock_pair);
+		clock_pair = NULL;
+	}
 }
 
 int kvm_arch_ptp_get_clock(struct timespec64 *ts)
@@ -49,8 +86,8 @@ int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 		return -EOPNOTSUPP;
 	}
 
-	ts->tv_sec = clock_pair.sec;
-	ts->tv_nsec = clock_pair.nsec;
+	ts->tv_sec = clock_pair->sec;
+	ts->tv_nsec = clock_pair->nsec;
 
 	return 0;
 }
@@ -81,9 +118,9 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
 			pr_err_ratelimited("clock pairing hypercall ret %lu\n", ret);
 			return -EOPNOTSUPP;
 		}
-		tspec->tv_sec = clock_pair.sec;
-		tspec->tv_nsec = clock_pair.nsec;
-		*cycle = __pvclock_read_cycles(src, clock_pair.tsc);
+		tspec->tv_sec = clock_pair->sec;
+		tspec->tv_nsec = clock_pair->nsec;
+		*cycle = __pvclock_read_cycles(src, clock_pair->tsc);
 	} while (pvclock_read_retry(src, version));
 
 	*cs = &kvm_clock;
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index b90571396a60..5015c2f6fd9f 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -239,7 +239,7 @@ static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
 
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, offset, op->cmd.opcode);
 	if (ret < 0)
-		return ret;
+		goto stop_user;
 
 	if (op->dummy.buswidth && op->dummy.nbytes) {
 		for (i = 0; i < op->dummy.nbytes / op->dummy.buswidth; i++)
@@ -249,8 +249,9 @@ static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
 	aspeed_spi_set_io_mode(chip, io_mode);
 
 	aspeed_spi_read_from_ahb(buf, chip->ahb_base, len);
+stop_user:
 	aspeed_spi_stop_user(chip);
-	return 0;
+	return ret;
 }
 
 static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
@@ -261,10 +262,11 @@ static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
 	aspeed_spi_start_user(chip);
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, op->addr.val, op->cmd.opcode);
 	if (ret < 0)
-		return ret;
+		goto stop_user;
 	aspeed_spi_write_to_ahb(chip->ahb_base, op->data.buf.out, op->data.nbytes);
+stop_user:
 	aspeed_spi_stop_user(chip);
-	return 0;
+	return ret;
 }
 
 /* support for 1-1-1, 1-1-2 or 1-1-4 */
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dd5b1c5691e1..c1de38de2806 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3546,11 +3546,9 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			port_status |= USB_PORT_STAT_C_OVERCURRENT << 16;
 		}
 
-		if (!hsotg->flags.b.port_connect_status) {
+		if (dwc2_is_device_mode(hsotg)) {
 			/*
-			 * The port is disconnected, which means the core is
-			 * either in device mode or it soon will be. Just
-			 * return 0's for the remainder of the port status
+			 * Just return 0's for the remainder of the port status
 			 * since the port register can't be read if the core
 			 * is in device mode.
 			 */
@@ -3620,13 +3618,11 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 		if (wvalue != USB_PORT_FEAT_TEST && (!windex || windex > 1))
 			goto error;
 
-		if (!hsotg->flags.b.port_connect_status) {
+		if (dwc2_is_device_mode(hsotg)) {
 			/*
-			 * The port is disconnected, which means the core is
-			 * either in device mode or it soon will be. Just
-			 * return without doing anything since the port
-			 * register can't be written if the core is in device
-			 * mode.
+			 * Just return 0's for the remainder of the port status
+			 * since the port register can't be read if the core
+			 * is in device mode.
 			 */
 			break;
 		}
@@ -4349,7 +4345,7 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 	if (hsotg->bus_suspended)
 		goto skip_power_saving;
 
-	if (hsotg->flags.b.port_connect_status == 0)
+	if (!(dwc2_read_hprt0(hsotg) & HPRT0_CONNSTS))
 		goto skip_power_saving;
 
 	switch (hsotg->params.power_down) {
@@ -4431,6 +4427,7 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 	 * Power Down mode.
 	 */
 	if (hprt0 & HPRT0_CONNSTS) {
+		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 		hsotg->lx_state = DWC2_L0;
 		goto unlock;
 	}
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 0745e9f11b2e..a8bda2a81acd 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -122,8 +122,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * in use but the usb3-phy entry is missing from the device tree.
 	 * Therefore, skip these operations in this case.
 	 */
-	if (!priv_data->usb3_phy)
+	if (!priv_data->usb3_phy) {
+		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 		goto skip_usb3_phy;
+	}
 
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
 	if (IS_ERR(crst)) {
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 1f143c6ba86b..8802dd53fbea 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -570,9 +570,12 @@ static int gs_start_io(struct gs_port *port)
 		 * we didn't in gs_start_tx() */
 		tty_wakeup(port->port.tty);
 	} else {
-		gs_free_requests(ep, head, &port->read_allocated);
-		gs_free_requests(port->port_usb->in, &port->write_pool,
-			&port->write_allocated);
+		/* Free reqs only if we are still connected */
+		if (port->port_usb) {
+			gs_free_requests(ep, head, &port->read_allocated);
+			gs_free_requests(port->port_usb->in, &port->write_pool,
+				&port->write_allocated);
+		}
 		status = -EIO;
 	}
 
diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index c25c51d26f26..395913113686 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -120,8 +120,12 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iclk))
 		priv->iclk = NULL;
 
-	clk_enable(priv->fclk);
-	clk_enable(priv->iclk);
+	ret = clk_enable(priv->fclk);
+	if (ret)
+		goto fail_request_resource;
+	ret = clk_enable(priv->iclk);
+	if (ret)
+		goto fail_iclk;
 
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret != 0) {
@@ -137,6 +141,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 
 fail_add_hcd:
 	clk_disable(priv->iclk);
+fail_iclk:
 	clk_disable(priv->fclk);
 
 fail_request_resource:
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 19111e83ac13..ab12d76b01fb 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -785,11 +785,17 @@ max3421_check_unlink(struct usb_hcd *hcd)
 				retval = 1;
 				dev_dbg(&spi->dev, "%s: URB %p unlinked=%d",
 					__func__, urb, urb->unlinked);
-				usb_hcd_unlink_urb_from_ep(hcd, urb);
-				spin_unlock_irqrestore(&max3421_hcd->lock,
-						       flags);
-				usb_hcd_giveback_urb(hcd, urb, 0);
-				spin_lock_irqsave(&max3421_hcd->lock, flags);
+				if (urb == max3421_hcd->curr_urb) {
+					max3421_hcd->urb_done = 1;
+					max3421_hcd->hien &= ~(BIT(MAX3421_HI_HXFRDN_BIT) |
+							       BIT(MAX3421_HI_RCVDAV_BIT));
+				} else {
+					usb_hcd_unlink_urb_from_ep(hcd, urb);
+					spin_unlock_irqrestore(&max3421_hcd->lock,
+							       flags);
+					usb_hcd_giveback_urb(hcd, urb, 0);
+					spin_lock_irqsave(&max3421_hcd->lock, flags);
+				}
 			}
 		}
 	}
diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index b8f3b75fd7eb..dfe4affa1757 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -289,6 +289,8 @@ struct anx7411_data {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	struct device *dev;
+	struct fwnode_handle *switch_node;
+	struct fwnode_handle *mux_node;
 };
 
 static u8 snk_identity[] = {
@@ -1020,6 +1022,16 @@ static void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
 		}
 }
 
+static void anx7411_port_unregister(struct typec_params *typecp)
+{
+	fwnode_handle_put(typecp->caps.fwnode);
+	anx7411_port_unregister_altmodes(typecp->port_amode);
+	if (typecp->port)
+		typec_unregister_port(typecp->port);
+	if (typecp->role_sw)
+		usb_role_switch_put(typecp->role_sw);
+}
+
 static int anx7411_usb_mux_set(struct typec_mux_dev *mux,
 			       struct typec_mux_state *state)
 {
@@ -1088,6 +1100,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
 	if (ctx->typec.typec_mux) {
 		typec_mux_unregister(ctx->typec.typec_mux);
 		ctx->typec.typec_mux = NULL;
+		fwnode_handle_put(ctx->mux_node);
 	}
 }
 
@@ -1096,6 +1109,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
 	if (ctx->typec.typec_switch) {
 		typec_switch_unregister(ctx->typec.typec_switch);
 		ctx->typec.typec_switch = NULL;
+		fwnode_handle_put(ctx->switch_node);
 	}
 }
 
@@ -1103,28 +1117,29 @@ static int anx7411_typec_switch_probe(struct anx7411_data *ctx,
 				      struct device *dev)
 {
 	int ret;
-	struct device_node *node;
 
-	node = of_get_child_by_name(dev->of_node, "orientation_switch");
-	if (!node)
+	ctx->switch_node = device_get_named_child_node(dev, "orientation_switch");
+	if (!ctx->switch_node)
 		return 0;
 
-	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
+	ret = anx7411_register_switch(ctx, dev, ctx->switch_node);
 	if (ret) {
 		dev_err(dev, "failed register switch");
+		fwnode_handle_put(ctx->switch_node);
 		return ret;
 	}
 
-	node = of_get_child_by_name(dev->of_node, "mode_switch");
-	if (!node) {
+	ctx->mux_node = device_get_named_child_node(dev, "mode_switch");
+	if (!ctx->mux_node) {
 		dev_err(dev, "no typec mux exist");
 		ret = -ENODEV;
 		goto unregister_switch;
 	}
 
-	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
+	ret = anx7411_register_mux(ctx, dev, ctx->mux_node);
 	if (ret) {
 		dev_err(dev, "failed register mode switch");
+		fwnode_handle_put(ctx->mux_node);
 		ret = -ENODEV;
 		goto unregister_switch;
 	}
@@ -1153,34 +1168,34 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
 	if (ret) {
 		dev_err(dev, "power-role not found: %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	ret = typec_find_port_power_role(buf);
 	if (ret < 0)
-		return ret;
+		goto put_fwnode;
 	cap->type = ret;
 
 	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
 	if (ret) {
 		dev_err(dev, "data-role not found: %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	ret = typec_find_port_data_role(buf);
 	if (ret < 0)
-		return ret;
+		goto put_fwnode;
 	cap->data = ret;
 
 	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
 	if (ret) {
 		dev_err(dev, "try-power-role not found: %d\n", ret);
-		return ret;
+		goto put_fwnode;
 	}
 
 	ret = typec_find_power_role(buf);
 	if (ret < 0)
-		return ret;
+		goto put_fwnode;
 	cap->prefer_role = ret;
 
 	/* Get source pdos */
@@ -1192,7 +1207,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 						     typecp->src_pdo_nr);
 		if (ret < 0) {
 			dev_err(dev, "source cap validate failed: %d\n", ret);
-			return -EINVAL;
+			goto put_fwnode;
 		}
 
 		typecp->caps_flags |= HAS_SOURCE_CAP;
@@ -1206,7 +1221,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 						     typecp->sink_pdo_nr);
 		if (ret < 0) {
 			dev_err(dev, "sink cap validate failed: %d\n", ret);
-			return -EINVAL;
+			goto put_fwnode;
 		}
 
 		for (i = 0; i < typecp->sink_pdo_nr; i++) {
@@ -1250,13 +1265,21 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
 		ret = PTR_ERR(ctx->typec.port);
 		ctx->typec.port = NULL;
 		dev_err(dev, "Failed to register type c port %d\n", ret);
-		return ret;
+		goto put_usb_role_switch;
 	}
 
 	typec_port_register_altmodes(ctx->typec.port, NULL, ctx,
 				     ctx->typec.port_amode,
 				     MAX_ALTMODE);
 	return 0;
+
+put_usb_role_switch:
+	if (ctx->typec.role_sw)
+		usb_role_switch_put(ctx->typec.role_sw);
+put_fwnode:
+	fwnode_handle_put(fwnode);
+
+	return ret;
 }
 
 static int anx7411_typec_check_connection(struct anx7411_data *ctx)
@@ -1528,8 +1551,7 @@ static int anx7411_i2c_probe(struct i2c_client *client,
 	destroy_workqueue(plat->workqueue);
 
 free_typec_port:
-	typec_unregister_port(plat->typec.port);
-	anx7411_port_unregister_altmodes(plat->typec.port_amode);
+	anx7411_port_unregister(&plat->typec);
 
 free_typec_switch:
 	anx7411_unregister_switch(plat);
@@ -1554,17 +1576,11 @@ static void anx7411_i2c_remove(struct i2c_client *client)
 	if (plat->spi_client)
 		i2c_unregister_device(plat->spi_client);
 
-	if (plat->typec.role_sw)
-		usb_role_switch_put(plat->typec.role_sw);
-
 	anx7411_unregister_mux(plat);
 
 	anx7411_unregister_switch(plat);
 
-	if (plat->typec.port)
-		typec_unregister_port(plat->typec.port);
-
-	anx7411_port_unregister_altmodes(plat->typec.port_amode);
+	anx7411_port_unregister(&plat->typec);
 }
 
 static const struct i2c_device_id anx7411_id[] = {
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 51b03b0dd5f7..d58c69018051 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -613,6 +613,10 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 			bforget(es->bh[i]);
 		else
 			brelse(es->bh[i]);
+
+	if (IS_DYNAMIC_ES(es))
+		kfree(es->bh);
+
 	kfree(es);
 	return err;
 }
@@ -845,6 +849,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	/* byte offset in sector */
 	off = EXFAT_BLK_OFFSET(byte_offset, sb);
 	es->start_off = off;
+	es->bh = es->__bh;
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -864,6 +869,16 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	es->num_entries = num_entries;
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	if (num_bh > ARRAY_SIZE(es->__bh)) {
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_NOFS);
+		if (!es->bh) {
+			brelse(bh);
+			kfree(es);
+			return NULL;
+		}
+		es->bh[0] = bh;
+	}
+
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index e0af6ace633c..c79c78bf265b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -169,10 +169,13 @@ struct exfat_entry_set_cache {
 	bool modified;
 	unsigned int start_off;
 	int num_bh;
-	struct buffer_head *bh[DIR_CACHE_SIZE];
+	struct buffer_head *__bh[DIR_CACHE_SIZE];
+	struct buffer_head **bh;
 	unsigned int num_entries;
 };
 
+#define IS_DYNAMIC_ES(es)	((es)->__bh != (es)->bh)
+
 struct exfat_dir_entry {
 	struct exfat_chain dir;
 	int entry;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 87ce71b39b77..db30c4b8a221 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -259,7 +259,13 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
-		/* check if iface is still active */
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
+		spin_unlock(&ses->ses_lock);
+
 		spin_lock(&ses->chan_lock);
 		if (!cifs_chan_is_iface_active(ses, server)) {
 			spin_unlock(&ses->chan_lock);
@@ -1977,31 +1983,6 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	return rc;
 }
 
-/**
- * cifs_free_ipc - helper to release the session IPC tcon
- * @ses: smb session to unmount the IPC from
- *
- * Needs to be called everytime a session is destroyed.
- *
- * On session close, the IPC is closed and the server must release all tcons of the session.
- * No need to send a tree disconnect here.
- *
- * Besides, it will make the server to not close durable and resilient files on session close, as
- * specified in MS-SMB2 3.3.5.6 Receiving an SMB2 LOGOFF Request.
- */
-static int
-cifs_free_ipc(struct cifs_ses *ses)
-{
-	struct cifs_tcon *tcon = ses->tcon_ipc;
-
-	if (tcon == NULL)
-		return 0;
-
-	tconInfoFree(tcon);
-	ses->tcon_ipc = NULL;
-	return 0;
-}
-
 static struct cifs_ses *
 cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
@@ -2035,35 +2016,44 @@ void cifs_put_smb_ses(struct cifs_ses *ses)
 {
 	unsigned int rc, xid;
 	unsigned int chan_count;
+	bool do_logoff;
+	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server = ses->server;
 
+	spin_lock(&cifs_tcp_ses_lock);
 	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_EXITING) {
+	cifs_dbg(FYI, "%s: id=0x%llx ses_count=%d ses_status=%u ipc=%s\n",
+		 __func__, ses->Suid, ses->ses_count, ses->ses_status,
+		 ses->tcon_ipc ? ses->tcon_ipc->tree_name : "none");
+	if (ses->ses_status == SES_EXITING || --ses->ses_count > 0) {
 		spin_unlock(&ses->ses_lock);
-		return;
-	}
-	spin_unlock(&ses->ses_lock);
-
-	cifs_dbg(FYI, "%s: ses_count=%d\n", __func__, ses->ses_count);
-	cifs_dbg(FYI,
-		 "%s: ses ipc: %s\n", __func__, ses->tcon_ipc ? ses->tcon_ipc->tree_name : "NONE");
-
-	spin_lock(&cifs_tcp_ses_lock);
-	if (--ses->ses_count > 0) {
 		spin_unlock(&cifs_tcp_ses_lock);
 		return;
 	}
-	spin_unlock(&cifs_tcp_ses_lock);
-
 	/* ses_count can never go negative */
 	WARN_ON(ses->ses_count < 0);
 
-	if (ses->ses_status == SES_GOOD)
-		ses->ses_status = SES_EXITING;
+	spin_lock(&ses->chan_lock);
+	cifs_chan_clear_need_reconnect(ses, server);
+	spin_unlock(&ses->chan_lock);
 
-	cifs_free_ipc(ses);
+	do_logoff = ses->ses_status == SES_GOOD && server->ops->logoff;
+	ses->ses_status = SES_EXITING;
+	tcon = ses->tcon_ipc;
+	ses->tcon_ipc = NULL;
+ 	spin_unlock(&ses->ses_lock);
+	spin_unlock(&cifs_tcp_ses_lock);
 
-	if (ses->ses_status == SES_EXITING && server->ops->logoff) {
+	/*
+	 * On session close, the IPC is closed and the server must release all
+	 * tcons of the session.  No need to send a tree disconnect here.
+	 *
+	 * Besides, it will make the server to not close durable and resilient
+	 * files on session close, as specified in MS-SMB2 3.3.5.6 Receiving an
+	 * SMB2 LOGOFF Request.
+	 */
+	tconInfoFree(tcon);
+	if (do_logoff) {
 		xid = get_xid();
 		rc = server->ops->logoff(xid, ses);
 		if (rc)
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 229a6527870d..8e24a6665abd 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -1010,6 +1010,8 @@ static int ksmbd_get_encryption_key(struct ksmbd_work *work, __u64 ses_id,
 
 	ses_enc_key = enc ? sess->smb3encryptionkey :
 		sess->smb3decryptionkey;
+	if (enc)
+		ksmbd_user_session_get(sess);
 	memcpy(key, ses_enc_key, SMB3_ENC_DEC_KEY_SIZE);
 
 	return 0;
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 710ac7b976fa..b1c2219ec0b4 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -262,8 +262,10 @@ struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 
 	down_read(&conn->session_lock);
 	sess = xa_load(&conn->sessions, id);
-	if (sess)
+	if (sess) {
 		sess->last_active = jiffies;
+		ksmbd_user_session_get(sess);
+	}
 	up_read(&conn->session_lock);
 	return sess;
 }
@@ -274,6 +276,8 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		ksmbd_user_session_get(sess);
 	up_read(&sessions_table_lock);
 
 	return sess;
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index da5b9678ad05..27d8d6c6fdac 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -241,14 +241,14 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	if (work->tcon)
 		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
-	if (work->sess)
-		ksmbd_user_session_put(work->sess);
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
 		rc = conn->ops->encrypt_resp(work);
 		if (rc < 0)
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
 	}
+	if (work->sess)
+		ksmbd_user_session_put(work->sess);
 
 	ksmbd_conn_write(work);
 }
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index cb7756469621..96d441ca511d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -66,8 +66,10 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 		return false;
 
 	sess = ksmbd_session_lookup_all(conn, id);
-	if (sess)
+	if (sess) {
+		ksmbd_user_session_put(sess);
 		return true;
+	}
 	pr_err("Invalid user session id: %llu\n", id);
 	return false;
 }
@@ -604,10 +606,8 @@ int smb2_check_user_session(struct ksmbd_work *work)
 
 	/* Check for validity of user session */
 	work->sess = ksmbd_session_lookup_all(conn, sess_id);
-	if (work->sess) {
-		ksmbd_user_session_get(work->sess);
+	if (work->sess)
 		return 1;
-	}
 	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
 	return -ENOENT;
 }
@@ -1720,29 +1720,35 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 		if (conn->dialect != sess->dialect) {
 			rc = -EINVAL;
+			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (!(req->hdr.Flags & SMB2_FLAGS_SIGNED)) {
 			rc = -EINVAL;
+			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (strncmp(conn->ClientGUID, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			rc = -ENOENT;
+			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (sess->state == SMB2_SESSION_IN_PROGRESS) {
 			rc = -EACCES;
+			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (sess->state == SMB2_SESSION_EXPIRED) {
 			rc = -EFAULT;
+			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
+		ksmbd_user_session_put(sess);
 
 		if (ksmbd_conn_need_reconnect(conn)) {
 			rc = -EFAULT;
@@ -1750,7 +1756,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (ksmbd_session_lookup(conn, sess_id)) {
+		sess = ksmbd_session_lookup(conn, sess_id);
+		if (!sess) {
 			rc = -EACCES;
 			goto out_err;
 		}
@@ -1761,7 +1768,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		conn->binding = true;
-		ksmbd_user_session_get(sess);
 	} else if ((conn->dialect < SMB30_PROT_ID ||
 		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
@@ -1788,7 +1794,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		conn->binding = false;
-		ksmbd_user_session_get(sess);
 	}
 	work->sess = sess;
 
@@ -2207,9 +2212,9 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
 	struct smb2_logoff_req *req;
 	struct smb2_logoff_rsp *rsp;
-	struct ksmbd_session *sess;
 	u64 sess_id;
 	int err;
 
@@ -2231,11 +2236,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	ksmbd_close_session_fds(work);
 	ksmbd_conn_wait_idle(conn, sess_id);
 
-	/*
-	 * Re-lookup session to validate if session is deleted
-	 * while waiting request complete
-	 */
-	sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (ksmbd_tree_conn_session_logoff(sess)) {
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -8682,6 +8682,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 		       le64_to_cpu(tr_hdr->SessionId));
 		return -ECONNABORTED;
 	}
+	ksmbd_user_session_put(sess);
 
 	iov[0].iov_base = buf;
 	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 6b084b3cac83..f5c3be85b135 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -3430,14 +3430,31 @@ xfs_btree_insrec(
 	xfs_btree_log_block(cur, bp, XFS_BB_NUMRECS);
 
 	/*
-	 * If we just inserted into a new tree block, we have to
-	 * recalculate nkey here because nkey is out of date.
+	 * Update btree keys to reflect the newly added record or keyptr.
+	 * There are three cases here to be aware of.  Normally, all we have to
+	 * do is walk towards the root, updating keys as necessary.
 	 *
-	 * Otherwise we're just updating an existing block (having shoved
-	 * some records into the new tree block), so use the regular key
-	 * update mechanism.
+	 * If the caller had us target a full block for the insertion, we dealt
+	 * with that by calling the _make_block_unfull function.  If the
+	 * "make unfull" function splits the block, it'll hand us back the key
+	 * and pointer of the new block.  We haven't yet added the new block to
+	 * the next level up, so if we decide to add the new record to the new
+	 * block (bp->b_bn != old_bn), we have to update the caller's pointer
+	 * so that the caller adds the new block with the correct key.
+	 *
+	 * However, there is a third possibility-- if the selected block is the
+	 * root block of an inode-rooted btree and cannot be expanded further,
+	 * the "make unfull" function moves the root block contents to a new
+	 * block and updates the root block to point to the new block.  In this
+	 * case, no block pointer is passed back because the block has already
+	 * been added to the btree.  In this case, we need to use the regular
+	 * key update function, just like the first case.  This is critical for
+	 * overlapping btrees, because the high key must be updated to reflect
+	 * the entire tree, not just the subtree accessible through the first
+	 * child of the root (which is now two levels down from the root).
 	 */
-	if (bp && xfs_buf_daddr(bp) != old_bn) {
+	if (!xfs_btree_ptr_is_null(cur, &nptr) &&
+	    bp && xfs_buf_daddr(bp) != old_bn) {
 		xfs_btree_get_keys(cur, block, lkey);
 	} else if (xfs_btree_needs_key_update(cur, optr)) {
 		error = xfs_btree_update_keys(cur, level);
diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
index bdc777b9ec4a..8828d854e34f 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.c
+++ b/fs/xfs/libxfs/xfs_symlink_remote.c
@@ -89,8 +89,10 @@ xfs_symlink_verify(
 	struct xfs_mount	*mp = bp->b_mount;
 	struct xfs_dsymlink_hdr	*dsl = bp->b_addr;
 
+	/* no verification of non-crc buffers */
 	if (!xfs_has_crc(mp))
-		return __this_address;
+		return NULL;
+
 	if (!xfs_verify_magic(bp, dsl->sl_magic))
 		return __this_address;
 	if (!uuid_equal(&dsl->sl_uuid, &mp->m_sb.sb_meta_uuid))
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 93ece6df02e3..0afc978e9983 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -464,7 +464,7 @@ TRACE_EVENT(xchk_ifork_btree_error,
 	TP_fast_assign(
 		xfs_fsblock_t fsbno = xchk_btree_cur_fsbno(cur, level);
 		__entry->dev = sc->mp->m_super->s_dev;
-		__entry->ino = sc->ip->i_ino;
+		__entry->ino = cur->bc_ino.ip->i_ino;
 		__entry->whichfork = cur->bc_ino.whichfork;
 		__entry->type = sc->sm->sm_type;
 		__entry->btnum = cur->bc_btnum;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 595a5bcf46b9..8de40cf63a5b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1161,6 +1161,14 @@ xfs_file_remap_range(
 	xfs_iunlock2_io_mmap(src, dest);
 	if (ret)
 		trace_xfs_reflink_remap_range_error(dest, ret, _RET_IP_);
+	/*
+	 * If the caller did not set CAN_SHORTEN, then it is not prepared to
+	 * handle partial results -- either the whole remap succeeds, or we
+	 * must say why it did not.  In this case, any error should be returned
+	 * to the caller.
+	 */
+	if (ret && remapped < len && !(remap_flags & REMAP_FILE_CAN_SHORTEN))
+		return ret;
 	return remapped > 0 ? remapped : ret;
 }
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index b45879868f90..24233e0b57fd 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -955,13 +955,6 @@ __xfs_trans_commit(
 
 	trace_xfs_trans_commit(tp, _RET_IP_);
 
-	error = xfs_trans_run_precommits(tp);
-	if (error) {
-		if (tp->t_flags & XFS_TRANS_PERM_LOG_RES)
-			xfs_defer_cancel(tp);
-		goto out_unreserve;
-	}
-
 	/*
 	 * Finish deferred items on final commit. Only permanent transactions
 	 * should ever have deferred ops.
@@ -972,13 +965,12 @@ __xfs_trans_commit(
 		error = xfs_defer_finish_noroll(&tp);
 		if (error)
 			goto out_unreserve;
-
-		/* Run precommits from final tx in defer chain. */
-		error = xfs_trans_run_precommits(tp);
-		if (error)
-			goto out_unreserve;
 	}
 
+	error = xfs_trans_run_precommits(tp);
+	if (error)
+		goto out_unreserve;
+
 	/*
 	 * If there is nothing to be logged by the transaction,
 	 * then unlock all of the items associated with the
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 973a1bfd7ef5..fdfe8e6ff0b2 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -205,28 +205,43 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #endif /* __KERNEL__ */
 
+/**
+ * offset_to_ptr - convert a relative memory offset to an absolute pointer
+ * @off:	the address of the 32-bit offset value
+ */
+static inline void *offset_to_ptr(const int *off)
+{
+	return (void *)((unsigned long)off + *off);
+}
+
+#endif /* __ASSEMBLY__ */
+
+#ifdef CONFIG_64BIT
+#define ARCH_SEL(a,b) a
+#else
+#define ARCH_SEL(a,b) b
+#endif
+
 /*
  * Force the compiler to emit 'sym' as a symbol, so that we can reference
  * it from inline assembler. Necessary in case 'sym' could be inlined
  * otherwise, or eliminated entirely due to lack of references that are
  * visible to the compiler.
  */
-#define ___ADDRESSABLE(sym, __attrs) \
-	static void * __used __attrs \
+#define ___ADDRESSABLE(sym, __attrs)						\
+	static void * __used __attrs						\
 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
+
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
-/**
- * offset_to_ptr - convert a relative memory offset to an absolute pointer
- * @off:	the address of the 32-bit offset value
- */
-static inline void *offset_to_ptr(const int *off)
-{
-	return (void *)((unsigned long)off + *off);
-}
+#define __ADDRESSABLE_ASM(sym)						\
+	.pushsection .discard.addressable,"aw";				\
+	.align ARCH_SEL(8,4);						\
+	ARCH_SEL(.quad, .long) __stringify(sym);			\
+	.popsection;
 
-#endif /* __ASSEMBLY__ */
+#define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))
 
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index 6fbfbde68a37..620a3260fc08 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -15,6 +15,7 @@
 struct ocelot_skb_cb {
 	struct sk_buff *clone;
 	unsigned int ptp_class; /* valid only for clones */
+	unsigned long ptp_tx_time; /* valid only for clones */
 	u32 tstamp_lo;
 	u8 ptp_cmd;
 	u8 ts_id;
diff --git a/include/linux/ptp_kvm.h b/include/linux/ptp_kvm.h
index c2e28deef33a..746fd67c3480 100644
--- a/include/linux/ptp_kvm.h
+++ b/include/linux/ptp_kvm.h
@@ -14,6 +14,7 @@ struct timespec64;
 struct clocksource;
 
 int kvm_arch_ptp_init(void);
+void kvm_arch_ptp_exit(void);
 int kvm_arch_ptp_get_clock(struct timespec64 *ts);
 int kvm_arch_ptp_get_crosststamp(u64 *cycle,
 		struct timespec64 *tspec, struct clocksource **cs);
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index df53bed9d71f..d73384f50603 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -160,6 +160,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern bool static_call_initialized;
+
 extern int __init static_call_init(void);
 
 struct static_call_mod {
@@ -223,6 +225,8 @@ extern long __static_call_return0(void);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+#define static_call_initialized 0
+
 static inline int static_call_init(void) { return 0; }
 
 #define DEFINE_STATIC_CALL(name, _func)					\
@@ -279,6 +283,8 @@ extern long __static_call_return0(void);
 
 #else /* Generic implementation */
 
+#define static_call_initialized 0
+
 static inline int static_call_init(void) { return 0; }
 
 static inline long __static_call_return0(void)
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 41fc7f12971a..5689b4744764 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,6 +122,7 @@ struct bt_voice {
 
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
+#define BT_VOICE_TRANSPARENT_16BIT		0x0063
 
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
diff --git a/include/net/lapb.h b/include/net/lapb.h
index 124ee122f2c8..6c07420644e4 100644
--- a/include/net/lapb.h
+++ b/include/net/lapb.h
@@ -4,7 +4,7 @@
 #include <linux/lapb.h>
 #include <linux/refcount.h>
 
-#define	LAPB_HEADER_LEN	20		/* LAPB over Ethernet + a bit more */
+#define	LAPB_HEADER_LEN MAX_HEADER		/* LAPB over Ethernet + a bit more */
 
 #define	LAPB_ACK_PENDING_CONDITION	0x01
 #define	LAPB_REJECT_CONDITION		0x02
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 8c3587d5c308..7ca4b7af57ca 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -81,6 +81,7 @@ struct net {
 						 * or to unregister pernet ops
 						 * (pernet_ops_rwsem write locked).
 						 */
+	struct llist_node	defer_free_list;
 	struct llist_node	cleanup_list;	/* namespaces on death row */
 
 #ifdef CONFIG_KEYS
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 9b5562f54548..99cfaa9347c9 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -941,7 +941,6 @@ struct ocelot_port {
 
 	phy_interface_t			phy_mode;
 
-	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
 	unsigned int			trap_proto;
@@ -949,7 +948,6 @@ struct ocelot_port {
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
-	u8				ts_id;
 
 	u8				index;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b68572c41e96..bdd5105337dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10350,8 +10350,11 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 	struct bpf_reg_state *reg;
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
+			s32 saved_subreg_def = reg->subreg_def;
 			copy_register_state(reg, known_reg);
+			reg->subreg_def = saved_subreg_def;
+		}
 	}));
 }
 
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 6f566fe27ec1..f0bd892ef157 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -15,7 +15,7 @@ extern struct static_call_site __start_static_call_sites[],
 extern struct static_call_tramp_key __start_static_call_tramp_key[],
 				    __stop_static_call_tramp_key[];
 
-static bool static_call_initialized;
+bool static_call_initialized;
 
 /* mutex to protect key modules/sites */
 static DEFINE_MUTEX(static_call_mutex);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d8212fea1e99..e7b7be074e5a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2180,6 +2180,9 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		goto unlock;
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
+	if (!old_array)
+		goto put;
+
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
@@ -2188,6 +2191,14 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		bpf_prog_array_free_sleepable(old_array);
 	}
 
+put:
+	/*
+	 * It could be that the bpf_prog is not sleepable (and will be freed
+	 * via normal RCU), but is called from a point that supports sleepable
+	 * programs and uses tasks-trace-RCU.
+	 */
+	synchronize_rcu_tasks_trace();
+
 	bpf_prog_put(event->prog);
 	event->prog = NULL;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e3993d19687d..8657c9b1448e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1816,7 +1816,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
-	if (func) {
+	if (func && !strchr(func, ':')) {
 		unsigned int count;
 
 		count = number_of_same_symbols(func);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4fc66cd95dc4..2b5453801bf0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -990,16 +990,25 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_len, tt_change_len = 0;
 	int tt_diff_entries_num = 0;
 	int tt_diff_entries_count = 0;
+	bool drop_changes = false;
+	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
 	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
-	 * and wait for the tt table request which will be fragmented
+	 * and wait for the tt table request so we can reply with the full
+	 * (fragmented) table.
+	 *
+	 * The local change history should still be cleaned up so the next
+	 * TT round can start again with a clean state.
 	 */
-	if (tt_diff_len > bat_priv->soft_iface->mtu)
+	if (tt_diff_len > bat_priv->soft_iface->mtu) {
 		tt_diff_len = 0;
+		tt_diff_entries_num = 0;
+		drop_changes = true;
+	}
 
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
@@ -1008,7 +1017,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 	tt_data->flags = BATADV_TT_OGM_DIFF;
 
-	if (tt_diff_len == 0)
+	if (!drop_changes && tt_diff_len == 0)
 		goto container_register;
 
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -1027,6 +1036,9 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
+	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
+				     tt_diff_entries_count);
+
 	/* Keep the buffer for possible tt_request */
 	spin_lock_bh(&bat_priv->tt.last_changeset_lock);
 	kfree(bat_priv->tt.last_changeset);
@@ -1035,6 +1047,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	tt_change_len = batadv_tt_len(tt_diff_entries_count);
 	/* check whether this new OGM has no changes due to size problems */
 	if (tt_diff_entries_count > 0) {
+		tt_diff_len -= tt_extra_len;
 		/* if kmalloc() fails we will reply with the full table
 		 * instead of providing the diff
 		 */
@@ -1047,6 +1060,8 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 	spin_unlock_bh(&bat_priv->tt.last_changeset_lock);
 
+	/* Remove extra packet space for OGM */
+	tvlv_len -= tt_extra_len;
 container_register:
 	batadv_tvlv_container_register(bat_priv, BATADV_TVLV_TT, 1, tt_data,
 				       tvlv_len);
@@ -2747,14 +2762,16 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
  *
  * Fills the tvlv buff with the tt entries from the specified hash. If valid_cb
  * is not provided then this becomes a no-op.
+ *
+ * Return: Remaining unused length in tvlv_buff.
  */
-static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
-				    struct batadv_hashtable *hash,
-				    void *tvlv_buff, u16 tt_len,
-				    bool (*valid_cb)(const void *,
-						     const void *,
-						     u8 *flags),
-				    void *cb_data)
+static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
+				   struct batadv_hashtable *hash,
+				   void *tvlv_buff, u16 tt_len,
+				   bool (*valid_cb)(const void *,
+						    const void *,
+						    u8 *flags),
+				   void *cb_data)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
@@ -2768,7 +2785,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	tt_change = tvlv_buff;
 
 	if (!valid_cb)
-		return;
+		return tt_len;
 
 	rcu_read_lock();
 	for (i = 0; i < hash->size; i++) {
@@ -2794,6 +2811,8 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 		}
 	}
 	rcu_read_unlock();
+
+	return batadv_tt_len(tt_tot - tt_num_entries);
 }
 
 /**
@@ -3069,10 +3088,11 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 			goto out;
 
 		/* fill the rest of the tvlv with the real TT entries */
-		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
-					tt_change, tt_len,
-					batadv_tt_global_valid,
-					req_dst_orig_node);
+		tvlv_len -= batadv_tt_tvlv_generate(bat_priv,
+						    bat_priv->tt.global_hash,
+						    tt_change, tt_len,
+						    batadv_tt_global_valid,
+						    req_dst_orig_node);
 	}
 
 	/* Don't send the response, if larger than fragmented packet. */
@@ -3196,9 +3216,11 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			goto out;
 
 		/* fill the rest of the tvlv with the real TT entries */
-		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
-					tt_change, tt_len,
-					batadv_tt_local_valid, NULL);
+		tvlv_len -= batadv_tt_tvlv_generate(bat_priv,
+						    bat_priv->tt.local_hash,
+						    tt_change, tt_len,
+						    batadv_tt_local_valid,
+						    NULL);
 	}
 
 	tvlv_tt_data->flags = BATADV_TT_RESPONSE;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ff15d5192768..437cbeaa9619 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -964,7 +964,11 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 	long timeo;
 	int err = 0;
 
-	lock_sock(sk);
+	/* Use explicit nested locking to avoid lockdep warnings generated
+	 * because the parent socket and the child socket are locked on the
+	 * same thread.
+	 */
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
 	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
 
@@ -995,7 +999,7 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 		release_sock(sk);
 
 		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
-		lock_sock(sk);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ad5afde17213..fe8728041ad0 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -268,10 +268,13 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
-		err = -EOPNOTSUPP;
-		goto unlock;
+	switch (sco_pi(sk)->setting & SCO_AIRMODE_MASK) {
+	case SCO_AIRMODE_TRANSP:
+		if (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
+		break;
 	}
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
@@ -888,13 +891,6 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		/* Explicitly check for these values */
-		if (voice.setting != BT_VOICE_TRANSPARENT &&
-		    voice.setting != BT_VOICE_CVSD_16BIT) {
-			err = -EINVAL;
-			break;
-		}
-
 		sco_pi(sk)->setting = voice.setting;
 		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
 				     BDADDR_BREDR);
@@ -902,9 +898,14 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			err = -EBADFD;
 			break;
 		}
-		if (enhanced_sync_conn_capable(hdev) &&
-		    voice.setting == BT_VOICE_TRANSPARENT)
-			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
+
+		switch (sco_pi(sk)->setting & SCO_AIRMODE_MASK) {
+		case SCO_AIRMODE_TRANSP:
+			if (enhanced_sync_conn_capable(hdev))
+				sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
+			break;
+		}
+
 		hci_dev_put(hdev);
 		break;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1d95a5adce4e..6c6d2a785c00 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -435,11 +435,28 @@ static struct net *net_alloc(void)
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
 
@@ -614,6 +631,8 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	rcu_barrier();
 
+	net_complete_free();
+
 	/* Finally it is safe to free my network namespace structure */
 	list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
 		list_del_init(&net->exit_list);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 25b5abab60ed..e674a686ff71 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -158,6 +158,7 @@ static void sock_map_del_link(struct sock *sk,
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
+			break;
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3f54b76bc281..40568365cdb3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -827,8 +827,10 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		unsigned int size;
 
 		if (mptcp_syn_options(sk, skb, &size, &opts->mptcp)) {
-			opts->options |= OPTION_MPTCP;
-			remaining -= size;
+			if (remaining >= size) {
+				opts->options |= OPTION_MPTCP;
+				remaining -= size;
+			}
 		}
 	}
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c0dccaceb05e..be48d3f7ffcd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1683,7 +1683,6 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 				     struct sta_info *sta, bool new_link,
 				     struct link_station_parameters *params)
 {
-	int ret = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
@@ -1725,6 +1724,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->txpwr_set) {
+		int ret;
+
 		link_sta->pub->txpwr.type = params->txpwr.type;
 		if (params->txpwr.type == NL80211_TX_POWER_LIMITED)
 			link_sta->pub->txpwr.power = params->txpwr.power;
@@ -1766,6 +1767,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						    params->eht_capa_len,
 						    link_sta);
 
+	ieee80211_sta_init_nss(link_sta);
+
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
@@ -1775,9 +1778,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
-	ieee80211_sta_init_nss(link_sta);
-
-	return ret;
+	return 0;
 }
 
 static int sta_apply_parameters(struct ieee80211_local *local,
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0eba06613dcd..f47ab622399f 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -77,6 +77,8 @@ struct netem_sched_data {
 	struct sk_buff	*t_head;
 	struct sk_buff	*t_tail;
 
+	u32 t_len;
+
 	/* optional qdisc for classful handling (NULL at netem init) */
 	struct Qdisc	*qdisc;
 
@@ -373,6 +375,7 @@ static void tfifo_reset(struct Qdisc *sch)
 	rtnl_kfree_skbs(q->t_head, q->t_tail);
 	q->t_head = NULL;
 	q->t_tail = NULL;
+	q->t_len = 0;
 }
 
 static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
@@ -402,6 +405,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 		rb_link_node(&nskb->rbnode, parent, p);
 		rb_insert_color(&nskb->rbnode, &q->t_root);
 	}
+	q->t_len++;
 	sch->q.qlen++;
 }
 
@@ -508,7 +512,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<prandom_u32_max(8);
 	}
 
-	if (unlikely(sch->q.qlen >= sch->limit)) {
+	if (unlikely(q->t_len >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
@@ -692,8 +696,8 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 tfifo_dequeue:
 	skb = __qdisc_dequeue_head(&sch->q);
 	if (skb) {
-		qdisc_qstats_backlog_dec(sch, skb);
 deliver:
+		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_bstats_update(sch, skb);
 		return skb;
 	}
@@ -709,8 +713,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 		if (time_to_send <= now && q->slot.slot_next <= now) {
 			netem_erase_head(q, skb);
-			sch->q.qlen--;
-			qdisc_qstats_backlog_dec(sch, skb);
+			q->t_len--;
 			skb->next = NULL;
 			skb->prev = NULL;
 			/* skb->dev shares skb->rbnode area,
@@ -737,16 +740,21 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
 					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
+					sch->qstats.backlog -= pkt_len;
+					sch->q.qlen--;
 				}
 				goto tfifo_dequeue;
 			}
+			sch->q.qlen--;
 			goto deliver;
 		}
 
 		if (q->qdisc) {
 			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb)
+			if (skb) {
+				sch->q.qlen--;
 				goto deliver;
+			}
 		}
 
 		qdisc_watchdog_schedule_ns(&q->watchdog,
@@ -756,8 +764,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 	if (q->qdisc) {
 		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb)
+		if (skb) {
+			sch->q.qlen--;
 			goto deliver;
+		}
 	}
 	return NULL;
 }
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 3f5a12b85b2d..f5bd75d931c1 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -811,6 +811,7 @@ static void cleanup_bearer(struct work_struct *work)
 {
 	struct udp_bearer *ub = container_of(work, struct udp_bearer, work);
 	struct udp_replicast *rcast, *tmp;
+	struct tipc_net *tn;
 
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
 		dst_cache_destroy(&rcast->dst_cache);
@@ -818,10 +819,14 @@ static void cleanup_bearer(struct work_struct *work)
 		kfree_rcu(rcast, rcu);
 	}
 
+	tn = tipc_net(sock_net(ub->ubsock->sk));
+
 	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->ubsock);
+
+	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
-	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
+	atomic_dec(&tn->wq_count);
 	kfree(ub);
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3e1c4e23484d..0ba824c3fd1b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -806,7 +806,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_LINKS] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_policy),
 	[NL80211_ATTR_MLO_LINK_ID] =
-		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
+		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS - 1),
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index af9601bea275..9c1bf0eb2deb 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -473,14 +473,19 @@ static int acp6x_probe(struct platform_device *pdev)
 
 	handle = ACPI_HANDLE(pdev->dev.parent);
 	ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
-	if (!ACPI_FAILURE(ret))
+	if (!ACPI_FAILURE(ret)) {
 		wov_en = dmic_status;
+		if (!wov_en)
+			return -ENODEV;
+	} else {
+		/* Incase of ACPI method read failure then jump to check_dmi_entry */
+		goto check_dmi_entry;
+	}
 
-	if (is_dmic_enable && wov_en)
+	if (is_dmic_enable)
 		platform_set_drvdata(pdev, &acp6x_card);
-	else
-		return 0;
 
+check_dmi_entry:
 	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
 	if (dmi_id)
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ecb49ba8432c..673591fbf917 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -553,7 +553,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interface *intf)
 {
 	struct usb_host_config *config = dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
 	int err;
 
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
@@ -564,15 +564,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interfac
 				      0x10, 0x43, 0x0001, 0x000a, NULL, 0);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
+
+		new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
+		if (!new_device_descriptor)
+			return -ENOMEM;
 		err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-				&new_device_descriptor, sizeof(new_device_descriptor));
+				new_device_descriptor, sizeof(*new_device_descriptor));
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-		if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+		if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
 			dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-				new_device_descriptor.bNumConfigurations);
+				new_device_descriptor->bNumConfigurations);
 		else
-			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
+			memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
 		err = usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -904,7 +908,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -939,15 +943,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "device initialised!\n");
 
+	new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
+	if (!new_device_descriptor)
+		return -ENOMEM;
+
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&new_device_descriptor, sizeof(new_device_descriptor));
+		new_device_descriptor, sizeof(*new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
 		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-			new_device_descriptor.bNumConfigurations);
+			new_device_descriptor->bNumConfigurations);
 	else
-		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
+		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
@@ -1261,7 +1269,7 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
 	int err;
 	int descriptor_size;
 
@@ -1274,15 +1282,19 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "device initialised!\n");
 
+	new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
+	if (!new_device_descriptor)
+		return -ENOMEM;
+
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&new_device_descriptor, sizeof(new_device_descriptor));
+		new_device_descriptor, sizeof(*new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
 		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-			new_device_descriptor.bNumConfigurations);
+			new_device_descriptor->bNumConfigurations);
 	else
-		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
+		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
@@ -2065,6 +2077,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x09a4, /* Logitech QuickCam E 3500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x0499, 0x1506, /* Yamaha THR5 */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0499, 0x3108, /* Yamaha YIT-W12TX */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cb363b507a32..6ea78612635b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3521,10 +3521,13 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CONTEXT_SWITCH:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_FUNC("unsupported instruction in callable function",
-					  sec, insn->offset);
-				return 1;
+			if (func) {
+				if (!next_insn || !next_insn->hint) {
+					WARN_FUNC("unsupported instruction in callable function",
+						  sec, insn->offset);
+					return 1;
+				}
+				break;
 			}
 			return 0;
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index 0c47faff9274..c068e6c2a580 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -22,20 +22,34 @@ SB_ITC=0
 h1_create()
 {
 	simple_if_init $h1 192.0.1.1/24
+	tc qdisc add dev $h1 clsact
+
+	# Add egress filter on $h1 that will guarantee that the packet sent,
+	# will be the only packet being passed to the device.
+	tc filter add dev $h1 egress pref 2 handle 102 matchall action drop
 }
 
 h1_destroy()
 {
+	tc filter del dev $h1 egress pref 2 handle 102 matchall action drop
+	tc qdisc del dev $h1 clsact
 	simple_if_fini $h1 192.0.1.1/24
 }
 
 h2_create()
 {
 	simple_if_init $h2 192.0.1.2/24
+	tc qdisc add dev $h2 clsact
+
+	# Add egress filter on $h2 that will guarantee that the packet sent,
+	# will be the only packet being passed to the device.
+	tc filter add dev $h2 egress pref 1 handle 101 matchall action drop
 }
 
 h2_destroy()
 {
+	tc filter del dev $h2 egress pref 1 handle 101 matchall action drop
+	tc qdisc del dev $h2 clsact
 	simple_if_fini $h2 192.0.1.2/24
 }
 
@@ -101,6 +115,11 @@ port_pool_test()
 	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
+	tc filter add dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
+
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
 	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
@@ -108,11 +127,6 @@ port_pool_test()
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-	RET=0
-	max_occ=$(sb_occ_pool_check $dl_port1 $SB_POOL_ING $exp_max_occ)
-	check_err $? "Expected iPool($SB_POOL_ING) max occupancy to be $exp_max_occ, but got $max_occ"
-	log_test "physical port's($h1) ingress pool"
-
 	RET=0
 	max_occ=$(sb_occ_pool_check $dl_port2 $SB_POOL_ING $exp_max_occ)
 	check_err $? "Expected iPool($SB_POOL_ING) max occupancy to be $exp_max_occ, but got $max_occ"
@@ -122,6 +136,11 @@ port_pool_test()
 	max_occ=$(sb_occ_pool_check $cpu_dl_port $SB_POOL_EGR_CPU $exp_max_occ)
 	check_err $? "Expected ePool($SB_POOL_EGR_CPU) max occupancy to be $exp_max_occ, but got $max_occ"
 	log_test "CPU port's egress pool"
+
+	tc filter del dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
 }
 
 port_tc_ip_test()
@@ -129,6 +148,11 @@ port_tc_ip_test()
 	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
+	tc filter add dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
+
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
 	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
@@ -136,11 +160,6 @@ port_tc_ip_test()
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-	RET=0
-	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
-	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
-	log_test "physical port's($h1) ingress TC - IP packet"
-
 	RET=0
 	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
 	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
@@ -150,6 +169,11 @@ port_tc_ip_test()
 	max_occ=$(sb_occ_etc_check $cpu_dl_port $SB_ITC_CPU_IP $exp_max_occ)
 	check_err $? "Expected egress TC($SB_ITC_CPU_IP) max occupancy to be $exp_max_occ, but got $max_occ"
 	log_test "CPU port's egress TC - IP packet"
+
+	tc filter del dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
 }
 
 port_tc_arp_test()
@@ -157,17 +181,15 @@ port_tc_arp_test()
 	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
+	tc filter add dev $h1 egress protocol arp pref 1 handle 101 flower \
+		src_mac $h1mac action pass
+
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
 	$MZ $h1 -c 1 -p 10 -a $h1mac -A 192.0.1.1 -t arp -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-	RET=0
-	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
-	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
-	log_test "physical port's($h1) ingress TC - ARP packet"
-
 	RET=0
 	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
 	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
@@ -177,6 +199,9 @@ port_tc_arp_test()
 	max_occ=$(sb_occ_etc_check $cpu_dl_port $SB_ITC_CPU_ARP $exp_max_occ)
 	check_err $? "Expected egress TC($SB_ITC_IP2ME) max occupancy to be $exp_max_occ, but got $max_occ"
 	log_test "CPU port's egress TC - ARP packet"
+
+	tc filter del dev $h1 egress protocol arp pref 1 handle 101 flower \
+		src_mac $h1mac action pass
 }
 
 setup_prepare()

