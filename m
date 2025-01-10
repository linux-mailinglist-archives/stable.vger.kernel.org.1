Return-Path: <stable+bounces-108191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C6A0924C
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 14:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B08188E283
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04E20E015;
	Fri, 10 Jan 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DqKhg9iC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C520D4F2;
	Fri, 10 Jan 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516580; cv=none; b=uxxqusHF/1mD2IcaFyAMPlMvhx/OawKmCi86aJvZZQergd9yebVS7nZpG57dsK+TXvq284FFGKUA9uhvupYjr7MHJzmPHF0/ZqZWCaWAnnVzoVdxC8RS43yZowqY6VrHNGM6Cs3jBvI96euyM5OQO/3yk9tSwRQNeGiMEl76/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516580; c=relaxed/simple;
	bh=0cUbAbBH7Bb02trp8F2lU7usCbd8VLIP4IXokSYnl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksPOzTIXWK0JekzxLZ6r+9tXQybdu8wtofR/azDbE+xNRapb9P5GU9Yz8eEMZH8BajYWLsin7xGZAa4nS/RxmJAVC8XLJTRGZv2jbSGFPZsL2a6BDM68DJS4ZhaKdoB05VO5jy6GUKdLjmpOs3bx6o6yBd6g1HxQAvdinH13QYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DqKhg9iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A183EC4CED6;
	Fri, 10 Jan 2025 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736516580;
	bh=0cUbAbBH7Bb02trp8F2lU7usCbd8VLIP4IXokSYnl0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqKhg9iCs4ls70gZh1xLOytLF6OFCQ5sh+nfI+cfHXSMIbl3Z2eZHONcdXSLzXwty
	 En891jAZec+jvtfueiXYFQXjOuMz9xynxVj3kPB+o2Jsbn5oOjSe2n/95v018DlTKO
	 FwFVPzq5heCqxEDJK7Nq6lDyCf82DZmSEWf+mURQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.71
Date: Fri, 10 Jan 2025 14:42:53 +0100
Message-ID: <2025011031-antennae-runt-917a@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025011030-glass-dainty-efee@gregkh>
References: <2025011030-glass-dainty-efee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 4c0dd62e02e4..9476e4502bbb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 70
+SUBLEVEL = 71
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 15fc9fc3dcf0..3269a0e23d3a 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -99,9 +99,9 @@ obj-$(CONFIG_TRACING)		+= trace.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
-obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o
+obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
-obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o crash.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_X86_32)		+= doublefault_32.o
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 6328cf56e59b..5ae77d966caf 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -209,9 +209,7 @@ static void hv_machine_shutdown(void)
 	if (kexec_in_progress)
 		hyperv_cleanup();
 }
-#endif /* CONFIG_KEXEC_CORE */
 
-#ifdef CONFIG_CRASH_DUMP
 static void hv_machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (hv_crash_handler)
@@ -223,7 +221,7 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	/* Disable the hypercall page when there is only 1 active CPU. */
 	hyperv_cleanup();
 }
-#endif /* CONFIG_CRASH_DUMP */
+#endif /* CONFIG_KEXEC_CORE */
 
 static u64 hv_ref_counter_at_suspend;
 static void (*old_save_sched_clock_state)(void);
@@ -552,13 +550,9 @@ static void __init ms_hyperv_init_platform(void)
 	no_timer_check = 1;
 #endif
 
-#if IS_ENABLED(CONFIG_HYPERV)
-#if defined(CONFIG_KEXEC_CORE)
+#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_KEXEC_CORE)
 	machine_ops.shutdown = hv_machine_shutdown;
-#endif
-#if defined(CONFIG_CRASH_DUMP)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
-#endif
 #endif
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		/*
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 0de509c02d18..a61c12c01270 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -263,13 +263,11 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	memset(&params->hd0_info, 0, sizeof(params->hd0_info));
 	memset(&params->hd1_info, 0, sizeof(params->hd1_info));
 
-#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = crash_setup_memmap_entries(image, params);
 		if (ret)
 			return ret;
 	} else
-#endif
 		setup_e820_entries(params);
 
 	nr_e820_entries = params->e820_entries;
@@ -430,14 +428,12 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		return ERR_PTR(-EINVAL);
 	}
 
-#ifdef CONFIG_CRASH_DUMP
 	/* Allocate and load backup region */
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
 	}
-#endif
 
 	/*
 	 * Load purgatory. For 64bit entry point, purgatory  code can be
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 38d88c8b56ec..b8ab9ee5896c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -769,7 +769,7 @@ static struct notifier_block kvm_pv_reboot_nb = {
  * won't be valid. In cases like kexec, in which you install a new kernel, this
  * means a random memory location will be kept being written.
  */
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_KEXEC_CORE
 static void kvm_crash_shutdown(struct pt_regs *regs)
 {
 	kvm_guest_cpu_offline(true);
@@ -852,7 +852,7 @@ static void __init kvm_guest_init(void)
 	kvm_guest_cpu_init();
 #endif
 
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_KEXEC_CORE
 	machine_ops.crash_shutdown = kvm_crash_shutdown;
 #endif
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index aaeac2deb85d..2fa12d1dc676 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -545,8 +545,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC_FILE */
 
-#ifdef CONFIG_CRASH_DUMP
-
 static int
 kexec_mark_range(unsigned long start, unsigned long end, bool protect)
 {
@@ -591,7 +589,6 @@ void arch_kexec_unprotect_crashkres(void)
 {
 	kexec_mark_crashkres(false);
 }
-#endif
 
 /*
  * During a traditional boot under SME, SME will encrypt the kernel,
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f3130f762784..830425e6d38e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -796,7 +796,7 @@ struct machine_ops machine_ops __ro_after_init = {
 	.emergency_restart = native_machine_emergency_restart,
 	.restart = native_machine_restart,
 	.halt = native_machine_halt,
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_KEXEC_CORE
 	.crash_shutdown = native_machine_crash_shutdown,
 #endif
 };
@@ -826,7 +826,7 @@ void machine_halt(void)
 	machine_ops.halt();
 }
 
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_KEXEC_CORE
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	machine_ops.crash_shutdown(regs);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8bcecabd475b..eb129277dcdd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -547,7 +547,7 @@ static void __init reserve_crashkernel(void)
 	bool high = false;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
 	total_mem = memblock_phys_mem_size();
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 52c3823b7211..96a771f9f930 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -282,7 +282,7 @@ struct smp_ops smp_ops = {
 	.smp_cpus_done		= native_smp_cpus_done,
 
 	.stop_other_cpus	= native_stop_other_cpus,
-#if defined(CONFIG_CRASH_DUMP)
+#if defined(CONFIG_KEXEC_CORE)
 	.crash_stop_other_cpus	= kdump_nmi_shootdown_cpus,
 #endif
 	.smp_send_reschedule	= native_smp_send_reschedule,
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index ade22feee7ae..70be57e8f51c 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -141,9 +141,7 @@ static void xen_hvm_shutdown(void)
 	if (kexec_in_progress)
 		xen_reboot(SHUTDOWN_soft_reset);
 }
-#endif
 
-#ifdef CONFIG_CRASH_DUMP
 static void xen_hvm_crash_shutdown(struct pt_regs *regs)
 {
 	native_machine_crash_shutdown(regs);
@@ -231,8 +229,6 @@ static void __init xen_hvm_guest_init(void)
 
 #ifdef CONFIG_KEXEC_CORE
 	machine_ops.shutdown = xen_hvm_shutdown;
-#endif
-#ifdef CONFIG_CRASH_DUMP
 	machine_ops.crash_shutdown = xen_hvm_crash_shutdown;
 #endif
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index bfd57d07f4b5..6b201e64d8ab 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2517,7 +2517,7 @@ int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(xen_remap_pfn);
 
-#ifdef CONFIG_VMCORE_INFO
+#ifdef CONFIG_KEXEC_CORE
 phys_addr_t paddr_vmcoreinfo_note(void)
 {
 	if (xen_pv_domain())

