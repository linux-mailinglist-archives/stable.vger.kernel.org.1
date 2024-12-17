Return-Path: <stable+bounces-105008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E109F5498
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D6A1892D3A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4A1FD783;
	Tue, 17 Dec 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IMJD1BML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE21F9A99;
	Tue, 17 Dec 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456814; cv=none; b=DkBL5z1BS91jVwEFU0SWbeNw6wh+Io6vkI+QYxWcItTcwybrpjnY8UE1jCs22num4GFk/yAKA5FG+gWVBwhdMDcfCqIdVb/k1POA+oePbDxBdgl4jnoIR/6rYx9U5vVtgcErmPqm6uwnT4DIRsI+3ooXTbE+htzb9coQWQ1t4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456814; c=relaxed/simple;
	bh=UhPkrFlifO23Djq4E7x/DkN+7Xj2of6U+78jAOwlcrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mmw+3CmVAQcENC1320P4dYrR8EhRU/D4IH2IIsuCJATlldWV7K3WEOfCFxPuV/Jyhm9iFRgqCiuK+FB0CvnqcwggyJNilRs+hnIwwJMQOMd+sps6FsMIC8GQo3mC+Vv2revyfa8mQ/HHgK+UzPmQPLBKTpniZbHY0B9oWuaFQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IMJD1BML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DF0C4CED3;
	Tue, 17 Dec 2024 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456814;
	bh=UhPkrFlifO23Djq4E7x/DkN+7Xj2of6U+78jAOwlcrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMJD1BMLZ+rqBgzi61pEpOSPnEnqH5Q/5O4HyZW0phD6thOda3T0+GCxg2RtFB8vq
	 HAy9IishVTasdql0y8Y13MAqX9JhNpSPuAEYRdUSwg4tkklMZFSmnWApA8xZRuUIwg
	 O2/EJl2pwcJT+oOsH42RbMUbsvv3XdAgwnd/PmX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.12 170/172] x86/xen: add central hypercall functions
Date: Tue, 17 Dec 2024 18:08:46 +0100
Message-ID: <20241217170553.389173695@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit b4845bb6383821a9516ce30af3a27dc873e37fd4 upstream.

Add generic hypercall functions usable for all normal (i.e. not iret)
hypercalls. Depending on the guest type and the processor vendor
different functions need to be used due to the to be used instruction
for entering the hypervisor:

- PV guests need to use syscall
- HVM/PVH guests on Intel need to use vmcall
- HVM/PVH guests on AMD and Hygon need to use vmmcall

As PVH guests need to issue hypercalls very early during boot, there
is a 4th hypercall function needed for HVM/PVH which can be used on
Intel and AMD processors. It will check the vendor type and then set
the Intel or AMD specific function to use via static_call().

This is part of XSA-466 / CVE-2024-53241.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/xen/hypercall.h |    3 +
 arch/x86/xen/enlighten.c             |   64 ++++++++++++++++++++++++++
 arch/x86/xen/enlighten_hvm.c         |    4 +
 arch/x86/xen/enlighten_pv.c          |    4 +
 arch/x86/xen/xen-asm.S               |   23 +++++++++
 arch/x86/xen/xen-head.S              |   83 +++++++++++++++++++++++++++++++++++
 arch/x86/xen/xen-ops.h               |    9 +++
 7 files changed, 189 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -88,6 +88,9 @@ struct xen_dm_op_buf;
 
 extern struct { char _entry[32]; } hypercall_page[];
 
+void xen_hypercall_func(void);
+DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
+
 #define __HYPERCALL		"call hypercall_page+%c[offset]"
 #define __HYPERCALL_ENTRY(x)						\
 	[offset] "i" (__HYPERVISOR_##x * sizeof(hypercall_page[0]))
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -2,6 +2,7 @@
 
 #include <linux/console.h>
 #include <linux/cpu.h>
+#include <linux/instrumentation.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
@@ -23,6 +24,9 @@
 
 EXPORT_SYMBOL_GPL(hypercall_page);
 
+DEFINE_STATIC_CALL(xen_hypercall, xen_hypercall_hvm);
+EXPORT_STATIC_CALL_TRAMP(xen_hypercall);
+
 /*
  * Pointer to the xen_vcpu_info structure or
  * &HYPERVISOR_shared_info->vcpu_info[cpu]. See xen_hvm_init_shared_info
@@ -68,6 +72,66 @@ EXPORT_SYMBOL(xen_start_flags);
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
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -300,6 +300,10 @@ static uint32_t __init xen_platform_hvm(
 	if (xen_pv_domain())
 		return 0;
 
+	/* Set correct hypercall function. */
+	if (xen_domain)
+		xen_hypercall_setfunc();
+
 	if (xen_pvh_domain() && nopv) {
 		/* Guest booting via the Xen-PVH boot entry goes here */
 		pr_info("\"nopv\" parameter is ignored in PVH guest\n");
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1341,6 +1341,9 @@ asmlinkage __visible void __init xen_sta
 
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
+	/* Interrupts are guaranteed to be off initially. */
+	early_boot_irqs_disabled = true;
+	static_call_update_early(xen_hypercall, xen_hypercall_pv);
 
 	xen_setup_features();
 
@@ -1431,7 +1434,6 @@ asmlinkage __visible void __init xen_sta
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_pv, xen_cpu_dead_pv));
 
 	local_irq_disable();
-	early_boot_irqs_disabled = true;
 
 	xen_raw_console_write("mapping kernel into physical memory\n");
 	xen_setup_kernel_pagetable((pgd_t *)xen_start_info->pt_base,
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -20,10 +20,33 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <../entry/calling.h>
 
 .pushsection .noinstr.text, "ax"
 /*
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
+/*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
  */
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
@@ -87,6 +89,87 @@ SYM_CODE_END(xen_cpu_bringup_again)
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
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -326,4 +326,13 @@ static inline void xen_smp_intr_free_pv(
 static inline void xen_smp_count_cpus(void) { }
 #endif /* CONFIG_SMP */
 
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



