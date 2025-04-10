Return-Path: <stable+bounces-132099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01FA843CE
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA31E7A929B
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1492857C1;
	Thu, 10 Apr 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YX1jj5F7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF72857F7;
	Thu, 10 Apr 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289857; cv=none; b=K7k11t+aUQPGgxds1yvzcq2Q5SLyjpW8KCrC4t8ry/H4WqwynNNj1y0HEmmjGozzrg9F4J9tA2YfAp5EGnplCgky+kLKoa7cB44L3wTXTLMgBeCtoDrRQw1624sG8i3VXEp12lob+blp4sXCfw0OAkFFDMk48Yao/YJT4c/sPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289857; c=relaxed/simple;
	bh=LGu7mF5k1kiKN0M/MLPmezv6JbxqzXxealt6MauUNts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/XCAKCSO2pdu85vBNfrs/AE5tlFY9Nm89eHN+Luhw/ca60mKSntluqIUH26YIP7x6zzF5ci0kiVuYQWx3bOm+uwrGIKcfaZKDSom9UVEoUl3nA7U2GTBK7h87keAHYB0J0T/QqiAUnm5OQndKdHetDC7pzzp6q1ERlKcLiq9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YX1jj5F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ADEC4AF09;
	Thu, 10 Apr 2025 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744289856;
	bh=LGu7mF5k1kiKN0M/MLPmezv6JbxqzXxealt6MauUNts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YX1jj5F7i2L1N+tBwfDuZhfEzb6I4NnzQwAETGVeC0cRZl2dxQHpAUxtQL/E51vwy
	 +tlhVTq0zzwJsFtqsO/QKZ0Z/VkEV5PVLQsPsFHL/9tv9bm3ynDV98LWlhB6XpDi8a
	 hxBDwInGFUs1lbovFhQqrn5Bv5noQBVcMGJFLWPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.292
Date: Thu, 10 Apr 2025 14:55:49 +0200
Message-ID: <2025041049-pointing-automated-e317@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041049-denote-unhinge-7564@gregkh>
References: <2025041049-denote-unhinge-7564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index 065db217cb04..16bda468423e 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
 online to handle timekeeping tasks in order to ensure that system
 calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
 (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
-user processes to observe slight drifts in clock rate.)  Therefore, the
-boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
-"nohz_full=" mask that includes the boot CPU will result in a boot-time
-error message, and the boot CPU will be removed from the mask.  Note that
-this means that your system must have at least two CPUs in order for
+user processes to observe slight drifts in clock rate.) Note that this
+means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
diff --git a/Makefile b/Makefile
index 010b5c1c3cf5..6cb965fe2cb3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 291
+SUBLEVEL = 292
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 9466ae61f56a..b45c68d88275 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -136,6 +136,7 @@ ENDPROC(shmobile_smp_sleep)
 	.long	shmobile_smp_arg - 1b
 
 	.bss
+	.align	2
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
 	.space	NR_CPUS * 4
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index d62393243720..569a74b03c15 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -27,6 +27,13 @@
 
 #ifdef CONFIG_MMU
 
+bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+{
+	unsigned long addr = (unsigned long)unsafe_src;
+
+	return addr >= TASK_SIZE && ULONG_MAX - addr >= size;
+}
+
 /*
  * This is useful to dump out the page tables associated with
  * 'addr' in mm 'mm'.
@@ -563,6 +570,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 99e688498a9c..93214d52ae82 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -189,8 +189,10 @@ static int spufs_fill_dir(struct dentry *dir,
 			return -ENOMEM;
 		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
 					files->mode & mode, files->size, ctx);
-		if (ret)
+		if (ret) {
+			dput(dentry);
 			return ret;
+		}
 		files++;
 	}
 	return 0;
@@ -438,8 +440,11 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 	}
 
 	ret = spufs_mkdir(inode, dentry, flags, mode & 0777);
-	if (ret)
+	if (ret) {
+		if (neighbor)
+			put_spu_context(neighbor);
 		goto out_aff_unlock;
+	}
 
 	if (affinity) {
 		spufs_set_affinity(flags, SPUFS_I(d_inode(dentry))->i_ctx,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index df0a3a1b08ae..e92b5eb57acd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -160,7 +160,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_EISA
+	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 29e5675c6d4f..6819ace46d8d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -104,6 +104,8 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
+	/* We just clobbered the return address - use the IRET frame for unwinding: */
+	UNWIND_HINT_IRET_REGS offset=3*8
 	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6f66d841262d..7ad744c1e62e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -572,7 +572,7 @@ struct flush_tlb_info {
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2852c99196fa..6848f13cb2a5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -862,7 +862,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 		return ret;
 	}
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index cebbcc6c36ae..44d8ae0bdbd2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
@@ -310,16 +309,6 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
-	/*
-	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
-	 * counter register during PIT shutdown restarts the PIT. So it
-	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
-	 * to false tells pit_shutdown() not to zero the counter so that
-	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
-	 * and setting this value has no effect.
-	 */
-	i8253_clear_counter_on_shutdown = false;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9b2bbb66d0c8..caf14c49539b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -171,6 +171,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -189,9 +190,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for (stack = stack ?: get_stack_pointer(task, regs);
-	     stack;
-	     stack = stack_info.next_sp) {
+	for (; stack; stack = stack_info.next_sp) {
 		const char *stack_name;
 
 		stack = PTR_ALIGN(stack, sizeof(long));
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 7dfd0185767c..76600d8f6937 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -20,8 +20,10 @@
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c402b079b74e..cc9d682a98a1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,7 +96,12 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (incomplete FPU state) */
+	if (unlikely(src == &init_task))
+		memcpy_and_pad(dst, arch_task_struct_size, src, sizeof(init_task), 0);
+	else
+		memcpy(dst, src, arch_task_struct_size);
+
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fe4200b89582..c5f60206c7c2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -912,7 +912,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -932,7 +932,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	local_irq_save(flags);
diff --git a/arch/x86/mm/pageattr-test.c b/arch/x86/mm/pageattr-test.c
index facce271e8b9..0d24ab91cce3 100644
--- a/arch/x86/mm/pageattr-test.c
+++ b/arch/x86/mm/pageattr-test.c
@@ -184,7 +184,7 @@ static int pageattr_test(void)
 			break;
 
 		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			err = change_page_attr_set(addrs, len[i], PAGE_CPA_TEST, 1);
 			break;
 
 		case 2:
diff --git a/block/bio.c b/block/bio.c
index e3d3e75c97e0..239f6bd421a8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -53,7 +53,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static struct bio_slab *bio_slabs;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 2750518a5d5e..dadc275a1ef7 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -442,6 +442,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1404VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1504VAP */
 		.matches = {
@@ -482,6 +489,12 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ae382c4018fd..7375624de564 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -968,6 +968,9 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Complete;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -986,9 +989,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -1028,7 +1028,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_suspended = false;
 
- Unlock:
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
 
@@ -1758,6 +1757,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev)) {
 				pm_dev_dbg(dev, state, "direct-complete ");
+				dev->power.is_suspended = true;
 				goto Complete;
 			}
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a55b22ebf103..4400e73d4c93 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1135,8 +1135,18 @@ static struct clk_regmap g12a_cpu_clk_div16_en = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "cpu_clk_div16_en",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&g12a_cpu_clk.hw
+		.parent_data = &(const struct clk_parent_data) {
+			/*
+			 * Note:
+			 * G12A and G12B have different cpu clocks (with
+			 * different struct clk_hw). We fallback to the global
+			 * naming string mechanism so this clock picks
+			 * up the appropriate one. Same goes for the other
+			 * clock using cpu cluster A clock output and present
+			 * on both G12 variant.
+			 */
+			.name = "cpu_clk",
+			.index = -1,
 		},
 		.num_parents = 1,
 		/*
@@ -1201,7 +1211,10 @@ static struct clk_regmap g12a_cpu_clk_apb_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_apb_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1235,7 +1248,10 @@ static struct clk_regmap g12a_cpu_clk_atb_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_atb_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1269,7 +1285,10 @@ static struct clk_regmap g12a_cpu_clk_axi_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_axi_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1304,13 +1323,6 @@ static struct clk_regmap g12a_cpu_clk_trace_div = {
 		.name = "cpu_clk_trace_div",
 		.ops = &clk_regmap_divider_ro_ops,
 		.parent_data = &(const struct clk_parent_data) {
-			/*
-			 * Note:
-			 * G12A and G12B have different cpu_clks (with
-			 * different struct clk_hw). We fallback to the global
-			 * naming string mechanism so cpu_clk_trace_div picks
-			 * up the appropriate one.
-			 */
 			.name = "cpu_clk",
 			.index = -1,
 		},
@@ -3898,7 +3910,7 @@ static MESON_GATE(g12a_spicc_1,			HHI_GCLK_MPEG0,	14);
 static MESON_GATE(g12a_hiu_reg,			HHI_GCLK_MPEG0,	19);
 static MESON_GATE(g12a_mipi_dsi_phy,		HHI_GCLK_MPEG0,	20);
 static MESON_GATE(g12a_assist_misc,		HHI_GCLK_MPEG0,	23);
-static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	4);
+static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	24);
 static MESON_GATE(g12a_emmc_b,			HHI_GCLK_MPEG0,	25);
 static MESON_GATE(g12a_emmc_c,			HHI_GCLK_MPEG0,	26);
 static MESON_GATE(g12a_audio_codec,		HHI_GCLK_MPEG0,	28);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index e8e36ec70b27..c541fb085351 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1265,14 +1265,13 @@ static struct clk_regmap gxbb_cts_i958 = {
 	},
 };
 
+/*
+ * This table skips a clock named 'cts_slow_oscin' in the documentation
+ * This clock does not exist yet in this controller or the AO one
+ */
+static u32 gxbb_32k_clk_parents_val_table[] = { 0, 2, 3 };
 static const struct clk_parent_data gxbb_32k_clk_parent_data[] = {
 	{ .fw_name = "xtal", },
-	/*
-	 * FIXME: This clock is provided by the ao clock controller but the
-	 * clock is not yet part of the binding of this controller, so string
-	 * name must be use to set this parent.
-	 */
-	{ .name = "cts_slow_oscin", .index = -1 },
 	{ .hw = &gxbb_fclk_div3.hw },
 	{ .hw = &gxbb_fclk_div5.hw },
 };
@@ -1282,6 +1281,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 		.offset = HHI_32K_CLK_CNTL,
 		.mask = 0x3,
 		.shift = 16,
+		.table = gxbb_32k_clk_parents_val_table,
 		},
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_sel",
@@ -1305,7 +1305,7 @@ static struct clk_regmap gxbb_32k_clk_div = {
 			&gxbb_32k_clk_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index c186a1985bf4..e9b471a623b5 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -200,7 +200,7 @@ PNAME(mux_aclk_peri_pre_p)	= { "cpll_peri",
 				    "gpll_peri",
 				    "hdmiphy_peri" };
 PNAME(mux_ref_usb3otg_src_p)	= { "xin24m",
-				    "clk_usb3otg_ref" };
+				    "clk_ref_usb3otg_src" };
 PNAME(mux_xin24m_32k_p)		= { "xin24m",
 				    "clk_rtc32k" };
 PNAME(mux_mac2io_src_p)		= { "clk_mac2io_src",
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index cb215e6f2e83..39f7c2d736d1 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,13 +20,6 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-/*
- * Handle PIT quirk in pit_shutdown() where zeroing the counter register
- * restarts the PIT, negating the shutdown. On platforms with the quirk,
- * platform specific code can set this to false.
- */
-bool i8253_clear_counter_on_shutdown __ro_after_init = true;
-
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -112,12 +105,33 @@ void clockevent_i8253_disable(void)
 {
 	raw_spin_lock(&i8253_lock);
 
+	/*
+	 * Writing the MODE register should stop the counter, according to
+	 * the datasheet. This appears to work on real hardware (well, on
+	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
+	 * shed).
+	 *
+	 * However, some virtual implementations differ, and the MODE change
+	 * doesn't have any effect until either the counter is written (KVM
+	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
+	 * it may not stop the *count*, only the interrupts. Although in
+	 * the virt case, that probably doesn't matter, as the value of the
+	 * counter will only be calculated on demand if the guest reads it;
+	 * it's the interrupts which cause steal time.
+	 *
+	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
+	 * firing repeatedly if the counter is running. But it *does* do the
+	 * right thing when the MODE register is written.
+	 *
+	 * So: write the MODE and then load the counter, which ensures that
+	 * the IRQ is stopped on those buggy virt implementations. And then
+	 * write the MODE again, which is the right way to stop it.
+	 */
 	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
 
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
+	outb_p(0x30, PIT_MODE);
 
 	raw_spin_unlock(&i8253_lock);
 }
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 95f8f2e217db..3080dad1b851 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -58,37 +58,43 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 		return 0;
 	}
 
+	ret = clk_enable(priv->clk);
+	if (ret)
+		goto disable_cnt;
+
 	/* LP timer must be enabled before writing CMP & ARR */
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->ceiling);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	/* ensure CMP & ARR registers are properly written */
 	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
 			   STM32_LPTIM_CMPOKCF_ARROKCF);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
-	ret = clk_enable(priv->clk);
-	if (ret) {
-		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
-		return ret;
-	}
 	priv->enabled = true;
 
 	/* Start LP timer in continuous mode */
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
 				  STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
+
+disable_clk:
+	clk_disable(priv->clk);
+disable_cnt:
+	regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+
+	return ret;
 }
 
 static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 4bb054d0cb43..01d19d9ac0fe 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -145,7 +145,23 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		time_elapsed = update_time - j_cdbs->prev_update_time;
 		j_cdbs->prev_update_time = update_time;
 
-		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
+		/*
+		 * cur_idle_time could be smaller than j_cdbs->prev_cpu_idle if
+		 * it's obtained from get_cpu_idle_time_jiffy() when NOHZ is
+		 * off, where idle_time is calculated by the difference between
+		 * time elapsed in jiffies and "busy time" obtained from CPU
+		 * statistics.  If a CPU is 100% busy, the time elapsed and busy
+		 * time should grow with the same amount in two consecutive
+		 * samples, but in practice there could be a tiny difference,
+		 * making the accumulated idle time decrease sometimes.  Hence,
+		 * in this case, idle_time should be regarded as 0 in order to
+		 * make the further process correct.
+		 */
+		if (cur_idle_time > j_cdbs->prev_cpu_idle)
+			idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
+		else
+			idle_time = 0;
+
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
@@ -162,7 +178,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * calls, so the previous load value can be used then.
 			 */
 			load = j_cdbs->prev_load;
-		} else if (unlikely((int)idle_time > 2 * sampling_rate &&
+		} else if (unlikely(idle_time > 2 * sampling_rate &&
 				    j_cdbs->prev_load)) {
 			/*
 			 * If the CPU had gone completely idle and a task has
@@ -189,30 +205,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			load = j_cdbs->prev_load;
 			j_cdbs->prev_load = 0;
 		} else {
-			if (time_elapsed >= idle_time) {
+			if (time_elapsed > idle_time)
 				load = 100 * (time_elapsed - idle_time) / time_elapsed;
-			} else {
-				/*
-				 * That can happen if idle_time is returned by
-				 * get_cpu_idle_time_jiffy().  In that case
-				 * idle_time is roughly equal to the difference
-				 * between time_elapsed and "busy time" obtained
-				 * from CPU statistics.  Then, the "busy time"
-				 * can end up being greater than time_elapsed
-				 * (for example, if jiffies_64 and the CPU
-				 * statistics are updated by different CPUs),
-				 * so idle_time may in fact be negative.  That
-				 * means, though, that the CPU was busy all
-				 * the time (on the rough average) during the
-				 * last sampling interval and 100 can be
-				 * returned as the load.
-				 */
-				load = (int)idle_time < 0 ? 100 : 0;
-			}
+			else
+				load = 0;
+
 			j_cdbs->prev_load = load;
 		}
 
-		if (unlikely((int)idle_time > 2 * sampling_rate)) {
+		if (unlikely(idle_time > 2 * sampling_rate)) {
 			unsigned int periods = idle_time / sampling_rate;
 
 			if (periods < idle_periods)
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9be43b4f9c50..d3d9916b1ba3 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -83,8 +83,6 @@
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
 
-#define IE31200_DIMMS			4
-#define IE31200_RANKS			8
 #define IE31200_RANKS_PER_CHANNEL	4
 #define IE31200_DIMMS_PER_CHANNEL	2
 #define IE31200_CHANNELS		2
@@ -156,6 +154,7 @@
 #define IE31200_MAD_DIMM_0_OFFSET		0x5004
 #define IE31200_MAD_DIMM_0_OFFSET_SKL		0x500C
 #define IE31200_MAD_DIMM_SIZE			GENMASK_ULL(7, 0)
+#define IE31200_MAD_DIMM_SIZE_SKL		GENMASK_ULL(5, 0)
 #define IE31200_MAD_DIMM_A_RANK			BIT(17)
 #define IE31200_MAD_DIMM_A_RANK_SHIFT		17
 #define IE31200_MAD_DIMM_A_RANK_SKL		BIT(10)
@@ -370,7 +369,7 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 static void __skl_populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
 				     int chan)
 {
-	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE;
+	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE_SKL;
 	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK_SKL << (chan << 4))) ? 1 : 0;
 	dd->x16_width = ((addr_decode & (IE31200_MAD_DIMM_A_WIDTH_SKL << (chan << 4))) >>
 				(IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT + (chan << 4)));
@@ -419,7 +418,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 
 	nr_channels = how_many_channels(pdev);
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = IE31200_DIMMS;
+	layers[0].size = IE31200_RANKS_PER_CHANNEL;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = nr_channels;
@@ -612,7 +611,7 @@ static int __init ie31200_init(void)
 
 	pci_rc = pci_register_driver(&ie31200_driver);
 	if (pci_rc < 0)
-		goto fail0;
+		return pci_rc;
 
 	if (!mci_pdev) {
 		ie31200_registered = 0;
@@ -623,11 +622,13 @@ static int __init ie31200_init(void)
 			if (mci_pdev)
 				break;
 		}
+
 		if (!mci_pdev) {
 			edac_dbg(0, "ie31200 pci_get_device fail\n");
 			pci_rc = -ENODEV;
-			goto fail1;
+			goto fail0;
 		}
+
 		pci_rc = ie31200_init_one(mci_pdev, &ie31200_pci_tbl[i]);
 		if (pci_rc < 0) {
 			edac_dbg(0, "ie31200 init fail\n");
@@ -635,12 +636,12 @@ static int __init ie31200_init(void)
 			goto fail1;
 		}
 	}
-	return 0;
 
+	return 0;
 fail1:
-	pci_unregister_driver(&ie31200_driver);
-fail0:
 	pci_dev_put(mci_pdev);
+fail0:
+	pci_unregister_driver(&ie31200_driver);
 
 	return pci_rc;
 }
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index a3b11bc71dcb..c973760ed949 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -266,6 +266,7 @@ static int imx_scu_probe(struct platform_device *pdev)
 		return ret;
 
 	sc_ipc->fast_ipc = of_device_is_compatible(args.np, "fsl,imx8-mu-scu");
+	of_node_put(args.np);
 
 	num_channel = sc_ipc->fast_ipc ? 2 : SCU_MU_CHAN_NUM;
 	for (i = 0; i < num_channel; i++) {
diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 7e12cbdf957c..daf42b5319e8 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -311,7 +311,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
 		str += sprintf_ipaddr(str, nic->ip_addr);
 		break;
 	case ISCSI_BOOT_ETH_SUBNET_MASK:
-		val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
+		if (nic->subnet_mask_prefix > 32)
+			val = cpu_to_be32(~0);
+		else
+			val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
 		str += sprintf(str, "%pI4", &val);
 		break;
 	case ISCSI_BOOT_ETH_PREFIX_LEN:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b498f2f48582..b8646d8f076b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1834,10 +1834,13 @@ static int get_norm_pix_clk(const struct dc_crtc_timing *timing)
 			break;
 		case COLOR_DEPTH_121212:
 			normalized_pix_clk = (pix_clk * 36) / 24;
-		break;
+			break;
+		case COLOR_DEPTH_141414:
+			normalized_pix_clk = (pix_clk * 42) / 24;
+			break;
 		case COLOR_DEPTH_161616:
 			normalized_pix_clk = (pix_clk * 48) / 24;
-		break;
+			break;
 		default:
 			ASSERT(0);
 		break;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 2b07de235e0d..52a31e1c30a1 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -929,6 +929,10 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 
 	if (mode != DRM_MODE_DPMS_ON)
 		mode = DRM_MODE_DPMS_OFF;
+
+	if (connector->dpms == mode)
+		goto out;
+
 	connector->dpms = mode;
 
 	crtc = connector->state->crtc;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 123b04f44ca8..70f8b59d93e5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -912,6 +912,10 @@ static const struct drm_prop_enum_list hdmi_colorspaces[] = {
  * 	implemented in the DRM core.  This is the only standard connector
  * 	property that userspace can change.
  *
+ * 	On atomic drivers any DPMS setproperty ioctl where the value does not
+ * 	change is completely skipped, otherwise a full atomic commit will occur.
+ * 	On legacy drivers the exact behavior is driver specific.
+ *
  * 	Note that this property cannot be set through the MODE_ATOMIC ioctl,
  * 	userspace must use "ACTIVE" on the CRTC instead.
  *
diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index 8ab44fec4bfa..b76b86278e0e 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -277,6 +277,11 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 					    0, PCI_DEVFN(2, 0));
 	int ret = -1;
 
+	if (pci_gfx_root == NULL) {
+		WARN_ON(1);
+		return;
+	}
+
 	/* Get the address of the platform config vbt */
 	pci_read_config_dword(pci_gfx_root, 0xFC, &addr);
 	pci_dev_put(pci_gfx_root);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 74a54a9e3533..afc0de27c976 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -135,7 +135,7 @@ enum hdmi_aud_channel_swap_type {
 
 struct hdmi_audio_param {
 	enum hdmi_audio_coding_type aud_codec;
-	enum hdmi_audio_sample_size aud_sampe_size;
+	enum hdmi_audio_sample_size aud_sample_size;
 	enum hdmi_aud_input_type aud_input_type;
 	enum hdmi_aud_i2s_fmt aud_i2s_fmt;
 	enum hdmi_aud_mclk aud_mclk;
@@ -1085,7 +1085,7 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 
 	hdmi->csp = HDMI_COLORSPACE_RGB;
 	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-	aud_param->aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+	aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
 	aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 	aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
@@ -1589,14 +1589,14 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 	switch (daifmt->fmt) {
 	case HDMI_I2S:
 		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 		hdmi_params.aud_input_type = HDMI_AUD_INPUT_I2S;
 		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
 		break;
 	case HDMI_SPDIF:
 		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
 		break;
 	default:
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index c49303ba30c8..6f2bf5e9992f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -759,7 +759,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 59db54ace428..bc9ce8e4f524 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -558,7 +558,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 {
 	int session_idx = -1;
 	bool destroyed = false, created = false, allocated = false;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	int i, r = 0;
 
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 8c2df6d95283..769ec41f82e4 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -188,11 +188,15 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
+	v3d->tfu_job = job;
+
 	fence = v3d_fence_create(v3d, V3D_TFU);
 	if (IS_ERR(fence))
 		return NULL;
 
-	v3d->tfu_job = job;
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
 	job->base.irq_fence = dma_fence_get(fence);
@@ -226,6 +230,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int i;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	v3d->csd_job = job;
 
 	v3d_invalidate_caches(v3d);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index bc0115548a57..d5369577b475 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1005,6 +1005,7 @@
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001		0x3001
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
+#define USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473		0x5473
 
 #define I2C_VENDOR_ID_RAYDIUM		0x2386
 #define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index 25cfd964dc25..acb9eb18f7cc 100644
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2015-2018 Terry Junge <terry.junge@plantronics.com>
  */
 
-/*
- */
-
 #include "hid-ids.h"
 
 #include <linux/hid.h>
@@ -23,30 +20,28 @@
 
 #define PLT_VOL_UP		0x00b1
 #define PLT_VOL_DOWN		0x00b2
+#define PLT_MIC_MUTE		0x00b5
 
 #define PLT1_VOL_UP		(PLT_HID_1_0_PAGE | PLT_VOL_UP)
 #define PLT1_VOL_DOWN		(PLT_HID_1_0_PAGE | PLT_VOL_DOWN)
+#define PLT1_MIC_MUTE		(PLT_HID_1_0_PAGE | PLT_MIC_MUTE)
 #define PLT2_VOL_UP		(PLT_HID_2_0_PAGE | PLT_VOL_UP)
 #define PLT2_VOL_DOWN		(PLT_HID_2_0_PAGE | PLT_VOL_DOWN)
+#define PLT2_MIC_MUTE		(PLT_HID_2_0_PAGE | PLT_MIC_MUTE)
+#define HID_TELEPHONY_MUTE	(HID_UP_TELEPHONY | 0x2f)
+#define HID_CONSUMER_MUTE	(HID_UP_CONSUMER | 0xe2)
 
 #define PLT_DA60		0xda60
 #define PLT_BT300_MIN		0x0413
 #define PLT_BT300_MAX		0x0418
 
-
-#define PLT_ALLOW_CONSUMER (field->application == HID_CP_CONSUMERCONTROL && \
-			    (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
-
-#define PLT_QUIRK_DOUBLE_VOLUME_KEYS BIT(0)
-#define PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS BIT(1)
-
 #define PLT_DOUBLE_KEY_TIMEOUT 5 /* ms */
-#define PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT 220 /* ms */
 
 struct plt_drv_data {
 	unsigned long device_type;
-	unsigned long last_volume_key_ts;
-	u32 quirks;
+	unsigned long last_key_ts;
+	unsigned long double_key_to;
+	__u16 last_key;
 };
 
 static int plantronics_input_mapping(struct hid_device *hdev,
@@ -58,34 +53,43 @@ static int plantronics_input_mapping(struct hid_device *hdev,
 	unsigned short mapped_key;
 	struct plt_drv_data *drv_data = hid_get_drvdata(hdev);
 	unsigned long plt_type = drv_data->device_type;
+	int allow_mute = usage->hid == HID_TELEPHONY_MUTE;
+	int allow_consumer = field->application == HID_CP_CONSUMERCONTROL &&
+			(usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER &&
+			usage->hid != HID_CONSUMER_MUTE;
 
 	/* special case for PTT products */
 	if (field->application == HID_GD_JOYSTICK)
 		goto defaulted;
 
-	/* handle volume up/down mapping */
 	/* non-standard types or multi-HID interfaces - plt_type is PID */
 	if (!(plt_type & HID_USAGE_PAGE)) {
 		switch (plt_type) {
 		case PLT_DA60:
-			if (PLT_ALLOW_CONSUMER)
+			if (allow_consumer)
 				goto defaulted;
-			goto ignored;
+			if (usage->hid == HID_CONSUMER_MUTE) {
+				mapped_key = KEY_MICMUTE;
+				goto mapped;
+			}
+			break;
 		default:
-			if (PLT_ALLOW_CONSUMER)
+			if (allow_consumer || allow_mute)
 				goto defaulted;
 		}
+		goto ignored;
 	}
-	/* handle standard types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
-	/* 'basic telephony compliant' - allow default consumer page map */
-	else if ((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
-		 (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) {
-		if (PLT_ALLOW_CONSUMER)
-			goto defaulted;
-	}
-	/* not 'basic telephony' - apply legacy mapping */
-	/* only map if the field is in the device's primary vendor page */
-	else if (!((field->application ^ plt_type) & HID_USAGE_PAGE)) {
+
+	/* handle standard consumer control mapping */
+	/* and standard telephony mic mute mapping */
+	if (allow_consumer || allow_mute)
+		goto defaulted;
+
+	/* handle vendor unique types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
+	/* if not 'basic telephony compliant' - map vendor unique controls */
+	if (!((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
+	      (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) &&
+	      !((field->application ^ plt_type) & HID_USAGE_PAGE))
 		switch (usage->hid) {
 		case PLT1_VOL_UP:
 		case PLT2_VOL_UP:
@@ -95,8 +99,11 @@ static int plantronics_input_mapping(struct hid_device *hdev,
 		case PLT2_VOL_DOWN:
 			mapped_key = KEY_VOLUMEDOWN;
 			goto mapped;
+		case PLT1_MIC_MUTE:
+		case PLT2_MIC_MUTE:
+			mapped_key = KEY_MICMUTE;
+			goto mapped;
 		}
-	}
 
 /*
  * Future mapping of call control or other usages,
@@ -105,6 +112,8 @@ static int plantronics_input_mapping(struct hid_device *hdev,
  */
 
 ignored:
+	hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
+		usage->hid, field->application);
 	return -1;
 
 defaulted:
@@ -123,38 +132,26 @@ static int plantronics_event(struct hid_device *hdev, struct hid_field *field,
 			     struct hid_usage *usage, __s32 value)
 {
 	struct plt_drv_data *drv_data = hid_get_drvdata(hdev);
+	unsigned long prev_tsto, cur_ts;
+	__u16 prev_key, cur_key;
 
-	if (drv_data->quirks & PLT_QUIRK_DOUBLE_VOLUME_KEYS) {
-		unsigned long prev_ts, cur_ts;
+	/* Usages are filtered in plantronics_usages. */
 
-		/* Usages are filtered in plantronics_usages. */
+	/* HZ too low for ms resolution - double key detection disabled */
+	/* or it is a key release - handle key presses only. */
+	if (!drv_data->double_key_to || !value)
+		return 0;
 
-		if (!value) /* Handle key presses only. */
-			return 0;
+	prev_tsto = drv_data->last_key_ts + drv_data->double_key_to;
+	cur_ts = drv_data->last_key_ts = jiffies;
+	prev_key = drv_data->last_key;
+	cur_key = drv_data->last_key = usage->code;
 
-		prev_ts = drv_data->last_volume_key_ts;
-		cur_ts = jiffies;
-		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_DOUBLE_KEY_TIMEOUT)
-			return 1; /* Ignore the repeated key. */
-
-		drv_data->last_volume_key_ts = cur_ts;
+	/* If the same key occurs in <= double_key_to -- ignore it */
+	if (prev_key == cur_key && time_before_eq(cur_ts, prev_tsto)) {
+		hid_dbg(hdev, "double key %d ignored\n", cur_key);
+		return 1; /* Ignore the repeated key. */
 	}
-	if (drv_data->quirks & PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS) {
-		unsigned long prev_ts, cur_ts;
-
-		/* Usages are filtered in plantronics_usages. */
-
-		if (!value) /* Handle key presses only. */
-			return 0;
-
-		prev_ts = drv_data->last_volume_key_ts;
-		cur_ts = jiffies;
-		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT)
-			return 1; /* Ignore the followed opposite volume key. */
-
-		drv_data->last_volume_key_ts = cur_ts;
-	}
-
 	return 0;
 }
 
@@ -196,12 +193,16 @@ static int plantronics_probe(struct hid_device *hdev,
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
-		goto err;
+		return ret;
 	}
 
 	drv_data->device_type = plantronics_device_type(hdev);
-	drv_data->quirks = id->driver_data;
-	drv_data->last_volume_key_ts = jiffies - msecs_to_jiffies(PLT_DOUBLE_KEY_TIMEOUT);
+	drv_data->double_key_to = msecs_to_jiffies(PLT_DOUBLE_KEY_TIMEOUT);
+	drv_data->last_key_ts = jiffies - drv_data->double_key_to;
+
+	/* if HZ does not allow ms resolution - disable double key detection */
+	if (drv_data->double_key_to < PLT_DOUBLE_KEY_TIMEOUT)
+		drv_data->double_key_to = 0;
 
 	hid_set_drvdata(hdev, drv_data);
 
@@ -210,29 +211,10 @@ static int plantronics_probe(struct hid_device *hdev,
 	if (ret)
 		hid_err(hdev, "hw start failed\n");
 
-err:
 	return ret;
 }
 
 static const struct hid_device_id plantronics_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3210_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3220_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3215_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES),
-		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES),
-		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
 	{ }
 };
@@ -241,6 +223,14 @@ MODULE_DEVICE_TABLE(hid, plantronics_devices);
 static const struct hid_usage_id plantronics_usages[] = {
 	{ HID_CP_VOLUMEUP, EV_KEY, HID_ANY_ID },
 	{ HID_CP_VOLUMEDOWN, EV_KEY, HID_ANY_ID },
+	{ HID_TELEPHONY_MUTE, EV_KEY, HID_ANY_ID },
+	{ HID_CONSUMER_MUTE, EV_KEY, HID_ANY_ID },
+	{ PLT2_VOL_UP, EV_KEY, HID_ANY_ID },
+	{ PLT2_VOL_DOWN, EV_KEY, HID_ANY_ID },
+	{ PLT2_MIC_MUTE, EV_KEY, HID_ANY_ID },
+	{ PLT1_VOL_UP, EV_KEY, HID_ANY_ID },
+	{ PLT1_VOL_DOWN, EV_KEY, HID_ANY_ID },
+	{ PLT1_MIC_MUTE, EV_KEY, HID_ANY_ID },
 	{ HID_TERMINATOR, HID_TERMINATOR, HID_TERMINATOR }
 };
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 99009fda7b80..9b375ca53946 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -876,6 +876,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
 	{ }
 };
 
diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 8f8dfdf64833..871f043eeba1 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -549,14 +549,14 @@ static void fw_reset_work_fn(struct work_struct *unused)
 static void _ish_sync_fw_clock(struct ishtp_device *dev)
 {
 	static unsigned long	prev_sync;
-	uint64_t	usec;
+	struct ipc_time_update_msg time = {};
 
 	if (prev_sync && jiffies - prev_sync < 20 * HZ)
 		return;
 
 	prev_sync = jiffies;
-	usec = ktime_to_us(ktime_get_boottime());
-	ipc_send_mng_msg(dev, MNG_SYNC_FW_CLOCK, &usec, sizeof(uint64_t));
+	/* The fields of time would be updated while sending message */
+	ipc_send_mng_msg(dev, MNG_SYNC_FW_CLOCK, &time, sizeof(time));
 }
 
 /**
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 01a2eeb2ec96..ecf79f3126b5 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -107,7 +107,7 @@ static struct notifier_block hyperv_panic_block = {
 static const char *fb_mmio_name = "fb_range";
 static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
-static DEFINE_SEMAPHORE(hyperv_mmio_lock);
+static DEFINE_MUTEX(hyperv_mmio_lock);
 
 static int vmbus_exists(void)
 {
@@ -2082,7 +2082,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 	int retval;
 
 	retval = -ENXIO;
-	down(&hyperv_mmio_lock);
+	mutex_lock(&hyperv_mmio_lock);
 
 	/*
 	 * If overlaps with frame buffers are allowed, then first attempt to
@@ -2137,7 +2137,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 	}
 
 exit:
-	up(&hyperv_mmio_lock);
+	mutex_unlock(&hyperv_mmio_lock);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
@@ -2154,15 +2154,28 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 {
 	struct resource *iter;
 
-	down(&hyperv_mmio_lock);
+	mutex_lock(&hyperv_mmio_lock);
+
+	/*
+	 * If all bytes of the MMIO range to be released are within the
+	 * special case fb_mmio shadow region, skip releasing the shadow
+	 * region since no corresponding __request_region() was done
+	 * in vmbus_allocate_mmio().
+	 */
+	if (fb_mmio && start >= fb_mmio->start &&
+	    (start + size - 1 <= fb_mmio->end))
+		goto skip_shadow_release;
+
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
 
 		__release_region(iter, start, size);
 	}
+
+skip_shadow_release:
 	release_mem_region(start, size);
-	up(&hyperv_mmio_lock);
+	mutex_unlock(&hyperv_mmio_lock);
 
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index da6bbfca15fe..a6b7919ab63f 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -420,8 +420,8 @@ static const s8 NCT6776_BEEP_BITS[] = {
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c, 0xb0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 16ebf38a9f66..da205738e8c9 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -267,7 +267,7 @@ catu_init_sg_table(struct device *catu_dev, int node,
 	 * Each table can address upto 1MB and we can have
 	 * CATU_PAGES_PER_SYSPAGE tables in a system page.
 	 */
-	nr_tpages = DIV_ROUND_UP(size, SZ_1M) / CATU_PAGES_PER_SYSPAGE;
+	nr_tpages = DIV_ROUND_UP(size, CATU_PAGES_PER_SYSPAGE * SZ_1M);
 	catu_table = tmc_alloc_sg_table(catu_dev, node, nr_tpages,
 					size >> PAGE_SHIFT, pages);
 	if (IS_ERR(catu_table))
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index a43deea390f5..2e547b03e5c9 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -490,6 +490,8 @@ MODULE_DEVICE_TABLE(pci, ali1535_ids);
 
 static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (ali1535_setup(dev)) {
 		dev_warn(&dev->dev,
 			"ALI1535 not detected, module not inserted.\n");
@@ -501,7 +503,15 @@ static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
 		"SMBus ALI1535 adapter at %04x", ali1535_offset);
-	return i2c_add_adapter(&ali1535_adapter);
+	ret = i2c_add_adapter(&ali1535_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
+	return ret;
 }
 
 static void ali1535_remove(struct pci_dev *dev)
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 02185a1cfa77..0cb78c47d800 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -473,6 +473,8 @@ MODULE_DEVICE_TABLE (pci, ali15x3_ids);
 
 static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (ali15x3_setup(dev)) {
 		dev_err(&dev->dev,
 			"ALI15X3 not detected, module not inserted.\n");
@@ -484,7 +486,15 @@ static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	snprintf(ali15x3_adapter.name, sizeof(ali15x3_adapter.name),
 		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
-	return i2c_add_adapter(&ali15x3_adapter);
+	ret = i2c_add_adapter(&ali15x3_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+	return ret;
 }
 
 static void ali15x3_remove(struct pci_dev *dev)
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a788f2e70677..6c758e4a6860 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1049,23 +1049,6 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	return 0;
 }
 
-static irqreturn_t
-omap_i2c_isr(int irq, void *dev_id)
-{
-	struct omap_i2c_dev *omap = dev_id;
-	irqreturn_t ret = IRQ_HANDLED;
-	u16 mask;
-	u16 stat;
-
-	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
-
-	if (stat & mask)
-		ret = IRQ_WAKE_THREAD;
-
-	return ret;
-}
-
 static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 {
 	u16 bits;
@@ -1096,8 +1079,13 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 		}
 
 		if (stat & OMAP_I2C_STAT_NACK) {
-			err |= OMAP_I2C_STAT_NACK;
+			omap->cmd_err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_NACK);
+
+			if (!(stat & ~OMAP_I2C_STAT_NACK)) {
+				err = -EAGAIN;
+				break;
+			}
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
@@ -1480,7 +1468,7 @@ omap_i2c_probe(struct platform_device *pdev)
 				IRQF_NO_SUSPEND, pdev->name, omap);
 	else
 		r = devm_request_threaded_irq(&pdev->dev, omap->irq,
-				omap_i2c_isr, omap_i2c_isr_thread,
+				NULL, omap_i2c_isr_thread,
 				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				pdev->name, omap);
 
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index cfb8e04a2a83..6befa6ff83f2 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -509,6 +509,8 @@ MODULE_DEVICE_TABLE(pci, sis630_ids);
 
 static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (sis630_setup(dev)) {
 		dev_err(&dev->dev,
 			"SIS630 compatible bus not detected, "
@@ -522,7 +524,15 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
 		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
 
-	return i2c_add_adapter(&sis630_adapter);
+	ret = i2c_add_adapter(&sis630_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION);
+	return ret;
 }
 
 static void sis630_remove(struct pci_dev *dev)
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 74942bfc676a..ecf24ca653d9 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -710,7 +710,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -770,14 +770,18 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = mma8452_get_odr_index(data);
+		j = mma8452_get_odr_index(data);
 
 		for (i = 0; i < ARRAY_SIZE(mma8452_os_ratio); i++) {
-			if (mma8452_os_ratio[i][ret] == val) {
+			if (mma8452_os_ratio[i][j] == val) {
 				ret = mma8452_set_power_mode(data, i);
 				break;
 			}
 		}
+		if (i == ARRAY_SIZE(mma8452_os_ratio)) {
+			ret = -EINVAL;
+			break;
+		}
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 2284930b5f91..92d9e314238a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2926,11 +2926,11 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad)
 {
 	unsigned long flags;
-	int post, ret;
 	struct ib_mad_private *mad_priv;
 	struct ib_sge sg_list;
 	struct ib_recv_wr recv_wr;
 	struct ib_mad_queue *recv_queue = &qp_info->recv_queue;
+	int ret = 0;
 
 	/* Initialize common scatter list fields */
 	sg_list.lkey = qp_info->port_priv->pd->local_dma_lkey;
@@ -2940,7 +2940,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 	recv_wr.sg_list = &sg_list;
 	recv_wr.num_sge = 1;
 
-	do {
+	while (true) {
 		/* Allocate and map receive buffer */
 		if (mad) {
 			mad_priv = mad;
@@ -2948,10 +2948,8 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 		} else {
 			mad_priv = alloc_mad_private(port_mad_size(qp_info->port_priv),
 						     GFP_ATOMIC);
-			if (!mad_priv) {
-				ret = -ENOMEM;
-				break;
-			}
+			if (!mad_priv)
+				return -ENOMEM;
 		}
 		sg_list.length = mad_priv_dma_size(mad_priv);
 		sg_list.addr = ib_dma_map_single(qp_info->port_priv->device,
@@ -2960,37 +2958,41 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
-			kfree(mad_priv);
 			ret = -ENOMEM;
-			break;
+			goto free_mad_priv;
 		}
 		mad_priv->header.mapping = sg_list.addr;
 		mad_priv->header.mad_list.mad_queue = recv_queue;
 		mad_priv->header.mad_list.cqe.done = ib_mad_recv_done;
 		recv_wr.wr_cqe = &mad_priv->header.mad_list.cqe;
-
-		/* Post receive WR */
 		spin_lock_irqsave(&recv_queue->lock, flags);
-		post = (++recv_queue->count < recv_queue->max_active);
-		list_add_tail(&mad_priv->header.mad_list.list, &recv_queue->list);
+		if (recv_queue->count >= recv_queue->max_active) {
+			/* Fully populated the receive queue */
+			spin_unlock_irqrestore(&recv_queue->lock, flags);
+			break;
+		}
+		recv_queue->count++;
+		list_add_tail(&mad_priv->header.mad_list.list,
+			      &recv_queue->list);
 		spin_unlock_irqrestore(&recv_queue->lock, flags);
+
 		ret = ib_post_recv(qp_info->qp, &recv_wr, NULL);
 		if (ret) {
 			spin_lock_irqsave(&recv_queue->lock, flags);
 			list_del(&mad_priv->header.mad_list.list);
 			recv_queue->count--;
 			spin_unlock_irqrestore(&recv_queue->lock, flags);
-			ib_dma_unmap_single(qp_info->port_priv->device,
-					    mad_priv->header.mapping,
-					    mad_priv_dma_size(mad_priv),
-					    DMA_FROM_DEVICE);
-			kfree(mad_priv);
 			dev_err(&qp_info->port_priv->device->dev,
 				"ib_post_recv failed: %d\n", ret);
 			break;
 		}
-	} while (post);
+	}
 
+	ib_dma_unmap_single(qp_info->port_priv->device,
+			    mad_priv->header.mapping,
+			    mad_priv_dma_size(mad_priv), DMA_FROM_DEVICE);
+free_mad_priv:
+	kfree(mad_priv);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 18b579c8a8c5..e14c9f83cf62 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1105,8 +1105,6 @@ static void __modify_flags_from_init_state(struct bnxt_qplib_qp *qp)
 			qp->path_mtu =
 				CMDQ_MODIFY_QP_PATH_MTU_MTU_2048;
 		}
-		qp->modify_flags &=
-			~CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID;
 		/* Bono FW require the max_dest_rd_atomic to be >= 1 */
 		if (qp->max_dest_rd_atomic < 1)
 			qp->max_dest_rd_atomic = 1;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 70991649dc69..4c5179e45dad 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -198,7 +198,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 				  IB_DEVICE_RC_RNR_NAK_GEN;
 	props->max_send_sge = hr_dev->caps.max_sq_sg;
 	props->max_recv_sge = hr_dev->caps.max_rq_sg;
-	props->max_sge_rd = 1;
+	props->max_sge_rd = hr_dev->caps.max_sq_sg;
 	props->max_cq = hr_dev->caps.num_cqs;
 	props->max_cqe = hr_dev->caps.max_cqes;
 	props->max_mr = hr_dev->caps.num_mtpts;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 7f659c240c99..eb20f8fa2bd3 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -483,7 +483,7 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 	}
 
 	qpn = ntohl(cqe64->sop_drop_qpn) & 0xffffff;
-	if (!*cur_qp || (qpn != (*cur_qp)->ibqp.qp_num)) {
+	if (!*cur_qp || (qpn != (*cur_qp)->trans_qp.base.mqp.qpn)) {
 		/* We do not have to take the QP table lock here,
 		 * because CQs will be locked while QPs are removed
 		 * from the table.
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index 02cb48223dc6..a28cbbd9e475 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2701,8 +2701,11 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 	u8 ratio;
 
 	if (state->revision == 0x8090) {
+		u32 internal = dib8000_read32(state, 23) / 1000;
+
 		ratio = 4;
-		unit_khz_dds_val = (1<<26) / (dib8000_read32(state, 23) / 1000);
+
+		unit_khz_dds_val = (1<<26) / (internal ?: 1);
 		if (offset_khz < 0)
 			dds = (1 << 26) - (abs_offset_khz * unit_khz_dds_val);
 		else
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 29271ad4728a..dec279845a75 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -813,6 +813,7 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 
 	host->eject = true;
 	cancel_work_sync(&host->handle_req);
+	cancel_delayed_work_sync(&host->poll_card);
 
 	mutex_lock(&host->host_mutex);
 	if (host->req) {
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index aab8d8910319..96616f826753 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -920,7 +920,7 @@ static void sm501_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct sm501_gpio_chip *smchip = gpiochip_get_data(chip);
 	struct sm501_gpio *smgpio = smchip->ourgpio;
-	unsigned long bit = 1 << offset;
+	unsigned long bit = BIT(offset);
 	void __iomem *regs = smchip->regbase;
 	unsigned long save;
 	unsigned long val;
@@ -946,7 +946,7 @@ static int sm501_gpio_input(struct gpio_chip *chip, unsigned offset)
 	struct sm501_gpio_chip *smchip = gpiochip_get_data(chip);
 	struct sm501_gpio *smgpio = smchip->ourgpio;
 	void __iomem *regs = smchip->regbase;
-	unsigned long bit = 1 << offset;
+	unsigned long bit = BIT(offset);
 	unsigned long save;
 	unsigned long ddr;
 
@@ -971,7 +971,7 @@ static int sm501_gpio_output(struct gpio_chip *chip,
 {
 	struct sm501_gpio_chip *smchip = gpiochip_get_data(chip);
 	struct sm501_gpio *smgpio = smchip->ourgpio;
-	unsigned long bit = 1 << offset;
+	unsigned long bit = BIT(offset);
 	void __iomem *regs = smchip->regbase;
 	unsigned long save;
 	unsigned long val;
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 4d8f2778d8f9..0d526e7afd72 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2502,8 +2502,10 @@ static int atmci_probe(struct platform_device *pdev)
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
 	ret = atmci_configure_dma(host);
-	if (ret == -EPROBE_DEFER)
+	if (ret == -EPROBE_DEFER) {
+		clk_disable_unprepare(host->mck);
 		goto err_dma_probe_defer;
+	}
 	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e55037ceda73..6aa92e8a2d0f 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -401,6 +401,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 9d9e4200064f..00a80f0adece 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -250,18 +250,33 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-tx",
 							dev->dev_id, i);
+			if (!card->tx_led.default_trigger) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
-
+			if (!card->tx_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
 			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-recon",
 							dev->dev_id, i);
+			if (!card->recon_led.default_trigger) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
+			if (!card->recon_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7ec15cb356c0..69b4318b1a77 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1723,8 +1723,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return err;
 }
@@ -1735,7 +1736,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err = 0;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -1747,6 +1747,8 @@ static int __maybe_unused flexcan_resume(struct device *device)
 		} else {
 			err = flexcan_chip_enable(priv);
 		}
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return err;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index cf3d57437437..047e328b770d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5151,13 +5151,13 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	err = mv88e6xxx_switch_reset(chip);
 	mv88e6xxx_reg_unlock(chip);
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (np) {
 		chip->irq = of_irq_get(np, 0);
 		if (chip->irq == -EPROBE_DEFER) {
 			err = chip->irq;
-			goto out;
+			goto out_phy;
 		}
 	}
 
@@ -5176,7 +5176,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (chip->info->g2_irqs > 0) {
 		err = mv88e6xxx_g2_irq_setup(chip);
@@ -5216,6 +5216,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+out_phy:
+	mv88e6xxx_phy_destroy(chip);
 out:
 	if (pdata)
 		dev_put(pdata->netdev);
@@ -5233,7 +5235,6 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_ptp_free(chip);
 	}
 
-	mv88e6xxx_phy_destroy(chip);
 	mv88e6xxx_unregister_switch(chip);
 	mv88e6xxx_mdios_unregister(chip);
 
@@ -5247,6 +5248,8 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+
+	mv88e6xxx_phy_destroy(chip);
 }
 
 static const struct of_device_id mv88e6xxx_of_match[] = {
diff --git a/drivers/net/dsa/mv88e6xxx/phy.c b/drivers/net/dsa/mv88e6xxx/phy.c
index 252b5b3a3efe..d2104bd346ea 100644
--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -197,7 +197,10 @@ static void mv88e6xxx_phy_ppu_state_init(struct mv88e6xxx_chip *chip)
 
 static void mv88e6xxx_phy_ppu_state_destroy(struct mv88e6xxx_chip *chip)
 {
+	mutex_lock(&chip->ppu_mutex);
 	del_timer_sync(&chip->ppu_timer);
+	cancel_work_sync(&chip->ppu_work);
+	mutex_unlock(&chip->ppu_mutex);
 }
 
 int mv88e6185_phy_ppu_read(struct mv88e6xxx_chip *chip, struct mii_bus *bus,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index f569a98e35a0..57e3a11451b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1740,7 +1740,7 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 		rvupf_write64(rvu, RVU_PF_VFPF_MBOX_INTX(1), intr);
 
 		rvu_queue_work(&rvu->afvf_wq_info, 64, vfs, intr);
-		vfs -= 64;
+		vfs = 64;
 	}
 
 	intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(0));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 363c4ab05990..b3ba996004f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4684,11 +4684,9 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 mode, setting;
-	int err;
 
-	err = mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting);
-	if (err)
-		return err;
+	if (mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting))
+		return -EOPNOTSUPP;
 	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 7c782df3793d..5d8b9e10ddf8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -455,8 +455,10 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 
 	num_vlans = sriov->num_allowed_vlans;
 	sriov->allowed_vlans = kcalloc(num_vlans, sizeof(u16), GFP_KERNEL);
-	if (!sriov->allowed_vlans)
+	if (!sriov->allowed_vlans) {
+		qlcnic_sriov_free_vlans(adapter);
 		return -ENOMEM;
+	}
 
 	vlans = (u16 *)&cmd->rsp.arg[3];
 	for (i = 0; i < num_vlans; i++)
@@ -2174,8 +2176,10 @@ int qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
 		vf = &sriov->vf_info[i];
 		vf->sriov_vlans = kcalloc(sriov->num_allowed_vlans,
 					  sizeof(*vf->sriov_vlans), GFP_KERNEL);
-		if (!vf->sriov_vlans)
+		if (!vf->sriov_vlans) {
+			qlcnic_sriov_free_vlans(adapter);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 347521ec52c3..d0032db3e9f4 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1328,9 +1328,11 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10b0, 0)}, /* Telit FE990B */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10d0, 0)}, /* Telit FN990B */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 7439f4ab72c5..1e8f395c8639 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -167,6 +167,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1730,13 +1741,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d")
+		 */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index cb5465d9c068..286b5ca3b167 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -619,41 +619,71 @@ static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
 }
 
 /*
- * alloc_sgtable - allocates scallerlist table in the given size,
- * fills it with pages and returns it
+ * alloc_sgtable - allocates (chained) scatterlist in the given size,
+ *	fills it with pages and returns it
  * @size: the size (in bytes) of the table
-*/
-static struct scatterlist *alloc_sgtable(int size)
+ */
+static struct scatterlist *alloc_sgtable(ssize_t size)
 {
-	int alloc_size, nents, i;
-	struct page *new_page;
-	struct scatterlist *iter;
-	struct scatterlist *table;
+	struct scatterlist *result = NULL, *prev;
+	int nents, i, n_prev;
 
 	nents = DIV_ROUND_UP(size, PAGE_SIZE);
-	table = kcalloc(nents, sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return NULL;
-	sg_init_table(table, nents);
-	iter = table;
-	for_each_sg(table, iter, sg_nents(table), i) {
-		new_page = alloc_page(GFP_KERNEL);
-		if (!new_page) {
-			/* release all previous allocated pages in the table */
-			iter = table;
-			for_each_sg(table, iter, sg_nents(table), i) {
-				new_page = sg_page(iter);
-				if (new_page)
-					__free_page(new_page);
-			}
-			kfree(table);
+
+#define N_ENTRIES_PER_PAGE (PAGE_SIZE / sizeof(*result))
+	/*
+	 * We need an additional entry for table chaining,
+	 * this ensures the loop can finish i.e. we can
+	 * fit at least two entries per page (obviously,
+	 * many more really fit.)
+	 */
+	BUILD_BUG_ON(N_ENTRIES_PER_PAGE < 2);
+
+	while (nents > 0) {
+		struct scatterlist *new, *iter;
+		int n_fill, n_alloc;
+
+		if (nents <= N_ENTRIES_PER_PAGE) {
+			/* last needed table */
+			n_fill = nents;
+			n_alloc = nents;
+			nents = 0;
+		} else {
+			/* fill a page with entries */
+			n_alloc = N_ENTRIES_PER_PAGE;
+			/* reserve one for chaining */
+			n_fill = n_alloc - 1;
+			nents -= n_fill;
+		}
+
+		new = kcalloc(n_alloc, sizeof(*new), GFP_KERNEL);
+		if (!new) {
+			if (result)
+				_devcd_free_sgtable(result);
 			return NULL;
 		}
-		alloc_size = min_t(int, size, PAGE_SIZE);
-		size -= PAGE_SIZE;
-		sg_set_page(iter, new_page, alloc_size, 0);
+		sg_init_table(new, n_alloc);
+
+		if (!result)
+			result = new;
+		else
+			sg_chain(prev, n_prev, new);
+		prev = new;
+		n_prev = n_alloc;
+
+		for_each_sg(new, iter, n_fill, i) {
+			struct page *new_page = alloc_page(GFP_KERNEL);
+
+			if (!new_page) {
+				_devcd_free_sgtable(result);
+				return NULL;
+			}
+
+			sg_set_page(iter, new_page, PAGE_SIZE, 0);
+		}
 	}
-	return table;
+
+	return result;
 }
 
 static void iwl_fw_get_prph_len(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index c3397160db7f..0076a73c5172 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -215,6 +215,9 @@ static int gen3_init_ntb(struct intel_ntb_dev *ndev)
 	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	/* Make sure we are not using DB's used for link status */
+	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
+		ndev->db_valid_mask &= ~ndev->db_link_mask;
 
 	ndev->reg->db_iowrite(ndev->db_valid_mask,
 			      ndev->self_mmio +
diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index db9be3ce1cd0..4dfb0dea2bda 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -288,7 +288,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (xlate_pos < 12)
 		return -EINVAL;
 
-	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
+	if (xlate_pos >= 0 && !IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
 		/*
 		 * In certain circumstances we can get a buffer that is
 		 * not aligned to its size. (Most of the time
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 251fe75798c1..cd0b5023f7f2 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -838,10 +838,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	dma_set_unmap(tx, unmap);
 
 	ret = dma_submit_error(dmaengine_submit(tx));
-	if (ret) {
-		dmaengine_unmap_put(unmap);
+	if (ret)
 		goto err_free_resource;
-	}
 
 	dmaengine_unmap_put(unmap);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd4b99ea956a..9816debe5cb5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -351,8 +351,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0d2c22cf12a0..f3c0bff714eb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3164,8 +3164,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ae41b6001c7e..b6d84b6493e1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -777,6 +777,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	nvmet_req_complete(&cmd->req, status);
 }
 
+static bool nvmet_rdma_recv_not_live(struct nvmet_rdma_queue *queue,
+		struct nvmet_rdma_rsp *rsp)
+{
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	/*
+	 * recheck queue state is not live to prevent a race condition
+	 * with RDMA_CM_EVENT_ESTABLISHED handler.
+	 */
+	if (queue->state == NVMET_RDMA_Q_LIVE)
+		ret = false;
+	else if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+	else
+		nvmet_rdma_put_rsp(rsp);
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+	return ret;
+}
+
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
@@ -818,17 +839,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->req.port = queue->port;
 	rsp->n_rdma = 0;
 
-	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
-		spin_unlock_irqrestore(&queue->state_lock, flags);
+	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE) &&
+	    nvmet_rdma_recv_not_live(queue, rsp))
 		return;
-	}
 
 	nvmet_rdma_handle_command(queue, rsp);
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bdbe01d4d9e9..c3512a0e5b14 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -765,7 +765,9 @@ void pcie_enable_interrupt(struct controller *ctrl)
 {
 	u16 mask;
 
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	mask = PCI_EXP_SLTCTL_DLLSCE;
+	if (!pciehp_poll_mode)
+		mask |= PCI_EXP_SLTCTL_HPIE;
 	pcie_write_cmd(ctrl, mask, mask);
 }
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ee51e433fded..c55ea6f0b955 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1012,16 +1012,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	parent_link = link->parent;
 
 	/*
-	 * link->downstream is a pointer to the pci_dev of function 0.  If
-	 * we remove that function, the pci_dev is about to be deallocated,
-	 * so we can't use link->downstream again.  Free the link state to
-	 * avoid this.
+	 * Free the parent link state, no later than function 0 (i.e.
+	 * link->downstream) being removed.
 	 *
-	 * If we're removing a non-0 function, it's possible we could
-	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
-	 * programming the same ASPM Control value for all functions of
-	 * multi-function devices, so disable ASPM for all of them.
+	 * Do not free the link state any earlier. If function 0 is a
+	 * switch upstream port, this link state is parent_link to all
+	 * subordinate ones.
 	 */
+	if (pdev != link->downstream)
+		goto out;
+
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
 	free_link_state(link);
@@ -1032,6 +1032,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_config_aspm_path(parent_link);
 	}
 
+ out:
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 8637f6068f9c..07d269928644 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -214,10 +214,12 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		/*
 		 * Disable hot-plug interrupts in case they have been enabled
-		 * by the BIOS and the hot-plug service driver is not loaded.
+		 * by the BIOS and the hot-plug service driver won't be loaded
+		 * to handle them.
 		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
 	}
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a41d04c57642..701489c1c5d3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -869,10 +869,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		goto free;
 
 	err = device_add(&bridge->dev);
-	if (err) {
-		put_device(&bridge->dev);
+	if (err)
 		goto free;
-	}
+
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index bc3b232a727a..3452005342ad 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -981,7 +981,7 @@ static const struct regmap_config bcm281xx_pinctrl_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = BCM281XX_PIN_VC_CAM3_SDA,
+	.max_register = BCM281XX_PIN_VC_CAM3_SDA * 4,
 };
 
 static int bcm281xx_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinctrl-rza2.c b/drivers/pinctrl/pinctrl-rza2.c
index 8c3174d00750..fb6dccc5c304 100644
--- a/drivers/pinctrl/pinctrl-rza2.c
+++ b/drivers/pinctrl/pinctrl-rza2.c
@@ -253,6 +253,8 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 		return ret;
 	}
 
+	of_node_put(of_args.np);
+
 	if ((of_args.args[0] != 0) ||
 	    (of_args.args[1] != 0) ||
 	    (of_args.args[2] != priv->npins)) {
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index a2c5c9858639..ef3482fa4023 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -556,7 +556,7 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 	case 4700000:
 	case 4800000:
 	case 4900000:
-		data = (uvolt - 4700000) / 100000;
+		data = ((uvolt - 4700000) / 100000) + 1;
 		break;
 	default:
 		dev_err(chg->dev, "Wrong value for charge input voltage regulation threshold\n");
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 7a3109a53881..fe5d05da7ce7 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -627,8 +627,7 @@ struct powercap_control_type *powercap_register_control_type(
 	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
-		if (control_type->allocated)
-			kfree(control_type);
+		put_device(&control_type->dev);
 		return ERR_PTR(result);
 	}
 	idr_init(&control_type->idr);
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 1fd982b4d64b..18b2fc50463b 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -646,7 +646,8 @@ static int info_update(void)
 	if (time_after(jiffies, chp_info_expires)) {
 		/* Data is too old, update. */
 		rc = sclp_chp_read_info(&chp_info);
-		chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL ;
+		if (!rc)
+			chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL;
 	}
 	mutex_unlock(&info_lock);
 
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 832af4213046..a13db27b04ed 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2871,7 +2871,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 			dprintk(3, "S/G Segment phys_addr=%x %x, len=0x%x\n",
 				cpu_to_le32(upper_32_bits(dma_handle)),
 				cpu_to_le32(lower_32_bits(dma_handle)),
-				cpu_to_le32(sg_dma_len(sg_next(s))));
+				cpu_to_le32(sg_dma_len(s)));
 			remseg--;
 		}
 		dprintk(5, "qla1280_64bit_start_scsi: Scatter/gather "
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 43fa351e2b9e..b7fdf25bfd23 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -45,6 +45,9 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	struct int3402_thermal_data *d;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	if (!acpi_has_method(adev->handle, "_TMP"))
 		return -ENODEV;
 
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 0b4139c0a975..820c9dad9fed 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -139,7 +139,7 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
 	 */
 	dma->tx_size = 0;
 
-	dmaengine_terminate_async(dma->rxchan);
+	dmaengine_terminate_async(dma->txchan);
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 9bce71e450e9..45934f764ea9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5132,6 +5132,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-235/246
 	 */
@@ -5312,6 +5320,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C42,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C43,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes UC-420
 	 */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index bfb0be4e70d5..97eb83f3b055 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1057,6 +1057,20 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	/* GMC devices */
 	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
+	/* Altera USB Blaster 3 */
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6022_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6025_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 3) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6029_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 3) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602C_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index b2aec1106678..f4d729562355 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1605,3 +1605,16 @@
  */
 #define GMC_VID				0x1cd7
 #define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
+
+/*
+ *  Altera USB Blaster 3 (http://www.altera.com).
+ */
+#define ALTERA_VID			0x09fb
+#define ALTERA_UB3_6022_PID		0x6022
+#define ALTERA_UB3_6025_PID		0x6025
+#define ALTERA_UB3_6026_PID		0x6026
+#define ALTERA_UB3_6029_PID		0x6029
+#define ALTERA_UB3_602A_PID		0x602a
+#define ALTERA_UB3_602C_PID		0x602c
+#define ALTERA_UB3_602D_PID		0x602d
+#define ALTERA_UB3_602E_PID		0x602e
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 1f7a2db1b193..93aee4b7441e 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1368,13 +1368,13 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1082, 0xff),	/* Telit FE990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1082, 0xff),	/* Telit FE990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
@@ -1388,28 +1388,44 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x30),	/* Telit FE990B (rmnet) */
+	  .driver_info = NCTRL(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b1, 0xff, 0xff, 0x30),	/* Telit FE990B (MBIM) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b1, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b1, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b2, 0xff, 0xff, 0x30),	/* Telit FE990B (RNDIS) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b2, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b2, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x30),	/* Telit FE990B (ECM) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x60) },	/* Telit FN990B (rmnet) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x30),	/* Telit FN990B (rmnet) */
 	  .driver_info = NCTRL(5) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x60) },	/* Telit FN990B (MBIM) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x60) },	/* Telit FN990B (RNDIS) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d2, 0xff, 0xff, 0x30),	/* Telit FN990B (RNDIS) */
 	  .driver_info = NCTRL(6) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x60) },	/* Telit FN990B (ECM) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d2, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d2, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d3, 0xff, 0xff, 0x30),	/* Telit FN990B (ECM) */
 	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d3, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d3, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 3b432a18b5ab..60102eea17ab 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -23,7 +23,7 @@ config VGA_CONSOLE
 	  Say Y.
 
 config MDA_CONSOLE
-	depends on !M68K && !PARISC && ISA
+	depends on VGA_CONSOLE && ISA
 	tristate "MDA text console (dual-headed)"
 	---help---
 	  Say Y here if you have an old MDA or monochrome Hercules graphics
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 99941ae1f3a1..514bd874a627 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -137,13 +137,15 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 	 */
 int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
-	struct fb_info *info = &fbdev->info;
+	struct fb_info *info;
 	u32 words;
 	int index;
 
 	if (!fbdev)
 		return -EINVAL;
 
+	info = &fbdev->info;
+
 	/* Update var-dependent FB info */
 	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
 		if (info->var.bits_per_pixel <= 8) {
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 3dd1b1d76e98..a7acf0acd3e9 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -326,6 +326,13 @@ static int sm501fb_check_var(struct fb_var_screeninfo *var,
 	if (var->xres_virtual > 4096 || var->yres_virtual > 2048)
 		return -EINVAL;
 
+	/* geometry sanity checks */
+	if (var->xres + var->xoffset > var->xres_virtual)
+		return -EINVAL;
+
+	if (var->yres + var->yoffset > var->yres_virtual)
+		return -EINVAL;
+
 	/* can cope with 8,16 or 32bpp */
 
 	if (var->bits_per_pixel <= 8)
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 82bb38370aa9..199b92f6a994 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -596,7 +596,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 		BUG_ON(tmp > bsize);
 		AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 		AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_fix_checksum(sb, bh);
 		bh->b_state &= ~(1UL << BH_New);
@@ -724,7 +724,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		tmp = min(bsize - boff, to - from);
 		BUG_ON(boff + tmp > bsize || tmp > bsize);
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
-		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
+		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(
+			max(boff + tmp, be32_to_cpu(AFFS_DATA_HEAD(bh)->size)));
 		affs_fix_checksum(sb, bh);
 		mark_buffer_dirty_inode(bh, inode);
 		written += tmp;
@@ -746,7 +747,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(bsize);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
@@ -780,7 +781,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b2f37809fa9b..6b4bf30b0247 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1275,7 +1275,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 		goto out_err;
 
 	if (fc->cache_symlinks)
-		return page_get_link(dentry, inode, callback);
+		return page_get_link_raw(dentry, inode, callback);
 
 	err = -ECHILD;
 	if (!dentry)
diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index b9e6a7ec78be..23c73bb56d82 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -147,7 +147,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 			de = tmpde;
 		}
 		/* Basic sanity check, whether name doesn't exceed dir entry */
-		if (de_len < de->name_len[0] +
+		if (de_len < sizeof(struct iso_directory_record) ||
+		    de_len < de->name_len[0] +
 					sizeof(struct iso_directory_record)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %lu\n", block,
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 4692c50d615f..4666aee2e1f4 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -117,7 +117,8 @@ do {									\
 	if (!(RC)) {							\
 		if (((P)->header.nextindex >				\
 		     (((BN) == 0) ? DTROOTMAXSLOT : (P)->header.maxslot)) || \
-		    ((BN) && ((P)->header.maxslot > DTPAGEMAXSLOT))) {	\
+		    ((BN) && (((P)->header.maxslot > DTPAGEMAXSLOT) ||	\
+		    ((P)->header.stblindex >= DTPAGEMAXSLOT)))) {	\
 			BT_PUTPAGE(MP);					\
 			jfs_error((IP)->i_sb,				\
 				  "DT_GETPAGE: dtree page corrupt\n");	\
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 28e89af8eef6..d7141472123d 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -559,11 +559,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
-
-		printk(KERN_ERR "ea_get: invalid extended attribute\n");
-		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, size, 1);
+		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
+			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
+			       EALIST_SIZE(ea_buf->xattr));
+		} else {
+			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
+
+			printk(KERN_ERR "ea_get: invalid extended attribute\n");
+			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
+				       ea_buf->xattr, size, 1);
+		}
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
diff --git a/fs/namei.c b/fs/namei.c
index a4cba6991a4d..038a9a4b9927 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4859,10 +4859,9 @@ const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
 EXPORT_SYMBOL(vfs_get_link);
 
 /* get the link contents into pagecache */
-const char *page_get_link(struct dentry *dentry, struct inode *inode,
-			  struct delayed_call *callback)
+static char *__page_get_link(struct dentry *dentry, struct inode *inode,
+			     struct delayed_call *callback)
 {
-	char *kaddr;
 	struct page *page;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -4881,8 +4880,23 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
 	}
 	set_delayed_call(callback, page_put_link, page);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
-	kaddr = page_address(page);
-	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
+	return page_address(page);
+}
+
+const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
+			      struct delayed_call *callback)
+{
+	return __page_get_link(dentry, inode, callback);
+}
+EXPORT_SYMBOL_GPL(page_get_link_raw);
+
+const char *page_get_link(struct dentry *dentry, struct inode *inode,
+					struct delayed_call *callback)
+{
+	char *kaddr = __page_get_link(dentry, inode, callback);
+
+	if (!IS_ERR(kaddr))
+		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
 	return kaddr;
 }
 
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 52ccd8d4ed82..0d2dbf3fded2 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1799,6 +1799,14 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
 	el = root_el;
 	while (el->l_tree_depth) {
+		if (unlikely(le16_to_cpu(el->l_tree_depth) >= OCFS2_MAX_PATH_DEPTH)) {
+			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
+				    "Owner %llu has invalid tree depth %u in extent list\n",
+				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
+				    le16_to_cpu(el->l_tree_depth));
+			ret = -EROFS;
+			goto out;
+		}
 		if (le16_to_cpu(el->l_next_free_rec) == 0) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
 				    "Owner %llu has empty extent list at depth %u\n",
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 34e15da39fdf..d785d148e15f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -413,7 +413,7 @@ static const struct file_operations proc_pid_cmdline_ops = {
 #ifdef CONFIG_KALLSYMS
 /*
  * Provides a wchan file via kallsyms in a proper one-value-per-file format.
- * Returns the resolved symbol.  If that fails, simply return the address.
+ * Returns the resolved symbol to user space.
  */
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c0967df13715..d3648a55590c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3234,6 +3234,8 @@ extern const struct file_operations generic_ro_fops;
 
 extern int readlink_copy(char __user *, int, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);
+extern const char *page_get_link_raw(struct dentry *, struct inode *,
+				     struct delayed_call *);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
 extern void page_put_link(void *);
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index bf169cfef7f1..56c280eb2d4f 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,7 +21,6 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 extern void clockevent_i8253_disable(void);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index b70a35b97210..7b8bdc468492 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -411,7 +411,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 static inline void disable_irq_nosync_lockdep(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_disable();
 #endif
 }
@@ -419,7 +419,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
 static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_save(*flags);
 #endif
 }
@@ -434,7 +434,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep(unsigned int irq)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_enable();
 #endif
 	enable_irq(irq);
@@ -442,7 +442,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_restore(*flags);
 #endif
 	enable_irq(irq);
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 3ff030367284..f8f5270a891d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -63,15 +63,7 @@ int netpoll_setup(struct netpoll *np);
 void __netpoll_cleanup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
-void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
-			     struct net_device *dev);
-static inline void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	netpoll_send_skb_on_dev(np, skb, np->dev);
-	local_irq_restore(flags);
-}
+netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index 59d3736c454c..737b50f40137 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -12,7 +12,7 @@ static __always_inline bool sched_smt_active(void)
 	return static_branch_likely(&sched_smt_present);
 }
 #else
-static inline bool sched_smt_active(void) { return false; }
+static __always_inline bool sched_smt_active(void) { return false; }
 #endif
 
 void arch_smt_update(void);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 679cc87b40f4..0611477e4dad 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 	irq_work_queue(&handle->event->pending);
diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index d3689632e8b9..3a5c25b2adc9 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 			 struct kexec_buf *kbuf,
 			 unsigned long *lowest_load_addr)
 {
-	unsigned long lowest_addr = UINT_MAX;
+	unsigned long lowest_addr = ULONG_MAX;
 	int ret;
 	size_t i;
 
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index d9dd94defc0a..19389fdbfdfb 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -37,7 +38,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -178,13 +179,16 @@ EXPORT_SYMBOL(down_timeout);
 void up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -252,11 +256,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ba3d7c223999..023d52d2a0f1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2513,7 +2513,7 @@ int sched_dl_global_validate(void)
 	 * cycling on root_domains... Discussion on different/better
 	 * solutions is welcome!
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
 		cpus = dl_bw_cpus(cpu);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 539bc80787ee..69713fa32437 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -140,11 +140,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -269,11 +264,6 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1276,6 +1266,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
 	}
 }
 
+#ifdef CONFIG_SMP
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+#else
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+#endif
+
 /*
  * This function is called on PREEMPT_RT kernels when the fast path
  * deletion of a timer failed because the timer callback function was
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ac3125d0c73f..75ea2ab53213 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -653,7 +653,7 @@ BPF_CALL_1(bpf_send_signal, u32, sig)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (!preemptible()) {
+	if (preempt_count() != 0 || irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2011219c11a9..b12838d4c327 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5195,9 +5195,9 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
 		/* Ignore dropped events before test starts. */
 		if (started) {
 			if (nested)
-				data->bytes_dropped += len;
-			else
 				data->bytes_dropped_nested += len;
+			else
+				data->bytes_dropped += len;
 		}
 		return len;
 	}
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index f577c11720a4..6ff245fc51e9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1246,6 +1246,7 @@ void graph_trace_close(struct trace_iterator *iter)
 	if (data) {
 		free_percpu(data->cpu_data);
 		kfree(data);
+		iter->private = NULL;
 	}
 }
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 07557904dab8..f68f04ecf504 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -228,8 +228,6 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 7b2d8f776ae2..617e297f46dc 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -171,8 +171,6 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..055356508d97 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -532,6 +532,8 @@ int sw842_compress(const u8 *in, unsigned int ilen,
 		}
 		if (repeat_count) {
 			ret = add_repeat_template(p, repeat_count);
+			if (ret)
+				return ret;
 			repeat_count = 0;
 			if (next == last) /* reached max repeat bits */
 				goto repeat;
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index dca1ec705b6c..a3b68243fd4b 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -186,10 +186,14 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 	else if (dev->mtu > max_mtu)
 		return -EINVAL;
 
+	/* Note: If this initial vlan_changelink() fails, we need
+	 * to call vlan_dev_free_egress_priority() to free memory.
+	 */
 	err = vlan_changelink(dev, tb, data, extack);
-	if (err)
-		return err;
-	err = register_vlan_dev(dev, extack);
+
+	if (!err)
+		err = register_vlan_dev(dev, extack);
+
 	if (err)
 		vlan_dev_free_egress_priority(dev);
 	return err;
diff --git a/net/atm/lec.c b/net/atm/lec.c
index 3625a04a6c70..07d4f256c38c 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -181,6 +181,7 @@ static void
 lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	unsigned int len = skb->len;
 
 	ATM_SKB(skb)->vcc = vcc;
 	atm_account_tx(vcc, skb);
@@ -191,7 +192,7 @@ lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 	}
 
 	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_bytes += len;
 }
 
 static void lec_tx_timeout(struct net_device *dev)
diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 033871e718a3..583c27131b7d 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1314,6 +1314,8 @@ static void MPOA_cache_impos_rcvd(struct k_message *msg,
 	holding_time = msg->content.eg_info.holding_time;
 	dprintk("(%s) entry = %p, holding_time = %u\n",
 		mpc->dev->name, entry, holding_time);
+	if (entry == NULL && !holding_time)
+		return;
 	if (entry == NULL && holding_time) {
 		entry = mpc->eg_ops->add_entry(msg, mpc);
 		mpc->eg_ops->put(entry);
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 8be8a1feca84..1fce3ca83f32 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -325,8 +325,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f13a779b8656..49cd08cab36f 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -845,8 +845,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index bccad8c048da..12052b766441 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -847,11 +847,16 @@ static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
 					 unsigned long hdr_len,
 					 unsigned long len, int nb)
 {
+	struct sk_buff *skb;
+
 	/* Note that we must allocate using GFP_ATOMIC here as
 	 * this function is called originally from netdev hard xmit
 	 * function in atomic context.
 	 */
-	return bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	skb = bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+	return skb;
 }
 
 static void chan_suspend_cb(struct l2cap_chan *chan)
diff --git a/net/can/af_can.c b/net/can/af_can.c
index bc06016a4fe9..d2fd12da30c6 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -288,8 +288,8 @@ int can_send(struct sk_buff *skb, int loop)
 		netif_rx_ni(newskb);
 
 	/* update statistics */
-	pkg_stats->tx_frames++;
-	pkg_stats->tx_frames_delta++;
+	atomic_long_inc(&pkg_stats->tx_frames);
+	atomic_long_inc(&pkg_stats->tx_frames_delta);
 
 	return 0;
 
@@ -647,8 +647,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	int matches;
 
 	/* update statistics */
-	pkg_stats->rx_frames++;
-	pkg_stats->rx_frames_delta++;
+	atomic_long_inc(&pkg_stats->rx_frames);
+	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
@@ -669,8 +669,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	consume_skb(skb);
 
 	if (matches > 0) {
-		pkg_stats->matches++;
-		pkg_stats->matches_delta++;
+		atomic_long_inc(&pkg_stats->matches);
+		atomic_long_inc(&pkg_stats->matches_delta);
 	}
 }
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 7c2d9161e224..22f3352c77fe 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -66,9 +66,9 @@ struct receiver {
 struct can_pkg_stats {
 	unsigned long jiffies_init;
 
-	unsigned long rx_frames;
-	unsigned long tx_frames;
-	unsigned long matches;
+	atomic_long_t rx_frames;
+	atomic_long_t tx_frames;
+	atomic_long_t matches;
 
 	unsigned long total_rx_rate;
 	unsigned long total_tx_rate;
@@ -82,9 +82,9 @@ struct can_pkg_stats {
 	unsigned long max_tx_rate;
 	unsigned long max_rx_match_ratio;
 
-	unsigned long rx_frames_delta;
-	unsigned long tx_frames_delta;
-	unsigned long matches_delta;
+	atomic_long_t rx_frames_delta;
+	atomic_long_t tx_frames_delta;
+	atomic_long_t matches_delta;
 };
 
 /* persistent statistics */
diff --git a/net/can/proc.c b/net/can/proc.c
index a5fc63c78370..ea442ddd4fd9 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -123,6 +123,13 @@ void can_stat_update(struct timer_list *t)
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	unsigned long j = jiffies; /* snapshot */
 
+	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
+	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
+	long matches = atomic_long_read(&pkg_stats->matches);
+	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
+	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
+	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
+
 	/* restart counting in timer context on user request */
 	if (user_reset)
 		can_init_stats(net);
@@ -132,35 +139,33 @@ void can_stat_update(struct timer_list *t)
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (pkg_stats->rx_frames > (ULONG_MAX / HZ))
+	if (rx_frames > (LONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (pkg_stats->tx_frames > (ULONG_MAX / HZ))
+	if (tx_frames > (LONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* matches overflow - very improbable */
-	if (pkg_stats->matches > (ULONG_MAX / 100))
+	if (matches > (LONG_MAX / 100))
 		can_init_stats(net);
 
 	/* calc total values */
-	if (pkg_stats->rx_frames)
-		pkg_stats->total_rx_match_ratio = (pkg_stats->matches * 100) /
-			pkg_stats->rx_frames;
+	if (rx_frames)
+		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
 
 	pkg_stats->total_tx_rate = calc_rate(pkg_stats->jiffies_init, j,
-					    pkg_stats->tx_frames);
+					    tx_frames);
 	pkg_stats->total_rx_rate = calc_rate(pkg_stats->jiffies_init, j,
-					    pkg_stats->rx_frames);
+					    rx_frames);
 
 	/* calc current values */
-	if (pkg_stats->rx_frames_delta)
+	if (rx_frames_delta)
 		pkg_stats->current_rx_match_ratio =
-			(pkg_stats->matches_delta * 100) /
-			pkg_stats->rx_frames_delta;
+			(matches_delta * 100) /	rx_frames_delta;
 
-	pkg_stats->current_tx_rate = calc_rate(0, HZ, pkg_stats->tx_frames_delta);
-	pkg_stats->current_rx_rate = calc_rate(0, HZ, pkg_stats->rx_frames_delta);
+	pkg_stats->current_tx_rate = calc_rate(0, HZ, tx_frames_delta);
+	pkg_stats->current_rx_rate = calc_rate(0, HZ, rx_frames_delta);
 
 	/* check / update maximum values */
 	if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
@@ -173,9 +178,9 @@ void can_stat_update(struct timer_list *t)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
 	/* clear values for 'current rate' calculation */
-	pkg_stats->tx_frames_delta = 0;
-	pkg_stats->rx_frames_delta = 0;
-	pkg_stats->matches_delta   = 0;
+	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->matches_delta, 0);
 
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
@@ -217,9 +222,12 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 
 	seq_putc(m, '\n');
-	seq_printf(m, " %8ld transmitted frames (TXF)\n", pkg_stats->tx_frames);
-	seq_printf(m, " %8ld received frames (RXF)\n", pkg_stats->rx_frames);
-	seq_printf(m, " %8ld matched frames (RXMF)\n", pkg_stats->matches);
+	seq_printf(m, " %8ld transmitted frames (TXF)\n",
+		   atomic_long_read(&pkg_stats->tx_frames));
+	seq_printf(m, " %8ld received frames (RXF)\n",
+		   atomic_long_read(&pkg_stats->rx_frames));
+	seq_printf(m, " %8ld matched frames (RXMF)\n",
+		   atomic_long_read(&pkg_stats->matches));
 
 	seq_putc(m, '\n');
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7ef3630ea20d..005cc630f74f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2176,6 +2176,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NDTPA_QUEUE_LENBYTES]		= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 9a67aa989d60..940d371f5f3b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -70,10 +70,11 @@ module_param(carrier_timeout, uint, 0644);
 #define np_notice(np, fmt, ...)				\
 	pr_notice("%s: " fmt, np->name, ##__VA_ARGS__)
 
-static int netpoll_start_xmit(struct sk_buff *skb, struct net_device *dev,
-			      struct netdev_queue *txq)
+static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
+				      struct net_device *dev,
+				      struct netdev_queue *txq)
 {
-	int status = NETDEV_TX_OK;
+	netdev_tx_t status = NETDEV_TX_OK;
 	netdev_features_t features;
 
 	features = netif_skb_features(skb);
@@ -322,20 +323,24 @@ static int netpoll_owner_active(struct net_device *dev)
 }
 
 /* call with IRQ disabled */
-void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
-			     struct net_device *dev)
+static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	int status = NETDEV_TX_BUSY;
+	netdev_tx_t status = NETDEV_TX_BUSY;
+	netdev_tx_t ret = NET_XMIT_DROP;
+	struct net_device *dev;
 	unsigned long tries;
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;
 
 	lockdep_assert_irqs_disabled();
 
-	npinfo = rcu_dereference_bh(np->dev->npinfo);
+	dev = np->dev;
+	rcu_read_lock();
+	npinfo = rcu_dereference_bh(dev->npinfo);
+
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
-		return;
+		goto out;
 	}
 
 	/* don't get messages out of order, and no recursion */
@@ -374,8 +379,23 @@ void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
+	ret = NETDEV_TX_OK;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
+{
+	unsigned long flags;
+	netdev_tx_t ret;
+
+	local_irq_save(flags);
+	ret = __netpoll_send_skb(np, skb);
+	local_irq_restore(flags);
+	return ret;
 }
-EXPORT_SYMBOL(netpoll_send_skb_on_dev);
+EXPORT_SYMBOL(netpoll_send_skb);
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 57c55909cb6a..4b9bced728c2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5600,6 +5600,27 @@ static void snmp6_fill_stats(u64 *stats, struct inet6_dev *idev, int attrtype,
 	}
 }
 
+static int inet6_fill_ifla6_stats_attrs(struct sk_buff *skb,
+					struct inet6_dev *idev)
+{
+	struct nlattr *nla;
+
+	nla = nla_reserve(skb, IFLA_INET6_STATS, IPSTATS_MIB_MAX * sizeof(u64));
+	if (!nla)
+		goto nla_put_failure;
+	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_STATS, nla_len(nla));
+
+	nla = nla_reserve(skb, IFLA_INET6_ICMP6STATS, ICMP6_MIB_MAX * sizeof(u64));
+	if (!nla)
+		goto nla_put_failure;
+	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_ICMP6STATS, nla_len(nla));
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 				  u32 ext_filter_mask)
 {
@@ -5621,18 +5642,10 @@ static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 
 	/* XXX - MC not implemented */
 
-	if (ext_filter_mask & RTEXT_FILTER_SKIP_STATS)
-		return 0;
-
-	nla = nla_reserve(skb, IFLA_INET6_STATS, IPSTATS_MIB_MAX * sizeof(u64));
-	if (!nla)
-		goto nla_put_failure;
-	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_STATS, nla_len(nla));
-
-	nla = nla_reserve(skb, IFLA_INET6_ICMP6STATS, ICMP6_MIB_MAX * sizeof(u64));
-	if (!nla)
-		goto nla_put_failure;
-	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_ICMP6STATS, nla_len(nla));
+	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS)) {
+		if (inet6_fill_ifla6_stats_attrs(skb, idev) < 0)
+			goto nla_put_failure;
+	}
 
 	nla = nla_reserve(skb, IFLA_INET6_TOKEN, sizeof(struct in6_addr));
 	if (!nla)
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 7426e33686d1..9bc612b3f834 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1075,8 +1075,13 @@ static int calipso_sock_getattr(struct sock *sk,
 	struct ipv6_opt_hdr *hop;
 	int opt_len, len, ret_val = -ENOMSG, offset;
 	unsigned char *opt;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
 
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
@@ -1128,8 +1133,13 @@ static int calipso_sock_setattr(struct sock *sk,
 {
 	int ret_val;
 	struct ipv6_opt_hdr *old, *new;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
 
+	txopts = txopt_get(pinfo);
 	old = NULL;
 	if (txopts)
 		old = txopts->hopopt;
@@ -1156,8 +1166,13 @@ static int calipso_sock_setattr(struct sock *sk,
 static void calipso_sock_delattr(struct sock *sk)
 {
 	struct ipv6_opt_hdr *new_hop;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return;
 
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
index aa5bb8789ba0..697b9e60e24e 100644
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -103,6 +103,10 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 	struct sk_buff *data_skb = NULL;
 	int doff = 0;
 	int thoff = 0, tproto;
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn const *ct;
+#endif
 
 	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
 	if (tproto < 0) {
@@ -136,6 +140,25 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 		return NULL;
 	}
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	/* Do the lookup with the original socket address in
+	 * case this is a reply packet of an established
+	 * SNAT-ted connection.
+	 */
+	ct = nf_ct_get(skb, &ctinfo);
+	if (ct &&
+	    ((tproto != IPPROTO_ICMPV6 &&
+	      ctinfo == IP_CT_ESTABLISHED_REPLY) ||
+	     (tproto == IPPROTO_ICMPV6 &&
+	      ctinfo == IP_CT_RELATED_REPLY)) &&
+	    (ct->status & IPS_SRC_NAT_DONE)) {
+		daddr = &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u3.in6;
+		dport = (tproto == IPPROTO_TCP) ?
+			ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u.tcp.port :
+			ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u.udp.port;
+	}
+#endif
+
 	return nf_socket_get_sock_v6(net, data_skb, doff, tproto, saddr, daddr,
 				     sport, dport, indev);
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 99908861246d..b321cec71127 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3549,7 +3549,8 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		in6_dev_put(idev);
 
 	if (err) {
-		lwtstate_put(fib6_nh->fib_nh_lws);
+		fib_nh_common_release(&fib6_nh->nh_common);
+		fib6_nh->nh_common.nhc_pcpu_rth_output = NULL;
 		fib6_nh->fib_nh_lws = NULL;
 		if (dev)
 			dev_put(dev);
@@ -3728,10 +3729,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (nh) {
 		if (rt->fib6_src.plen) {
 			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
+			err = -EINVAL;
 			goto out_free;
 		}
 		if (!nexthop_get(nh)) {
 			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			err = -ENOENT;
 			goto out_free;
 		}
 		rt->nh = nh;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 2bc82dabfe3b..dcce6aaac970 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2809,12 +2809,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	case IP_VS_SO_GET_SERVICES:
 	{
 		struct ip_vs_get_services *get;
-		int size;
+		size_t size;
 
 		get = (struct ip_vs_get_services *)arg;
 		size = struct_size(get, entrytable, get->num_services);
 		if (*len != size) {
-			pr_err("length: %u != %u\n", *len, size);
+			pr_err("length: %u != %zu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2850,12 +2850,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	case IP_VS_SO_GET_DESTS:
 	{
 		struct ip_vs_get_dests *get;
-		int size;
+		size_t size;
 
 		get = (struct ip_vs_get_dests *)arg;
 		size = struct_size(get, entrytable, get->num_dests);
 		if (*len != size) {
-			pr_err("length: %u != %u\n", *len, size);
+			pr_err("length: %u != %zu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 0ce12a33ffda..a66a27fe7f45 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -366,6 +366,8 @@ insert_tree(struct net *net,
 
 	conn->tuple = *tuple;
 	conn->zone = *zone;
+	conn->cpu = raw_smp_processor_id();
+	conn->jiffies32 = (u32)jiffies;
 	memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
 
 	nf_conncount_list_init(&rbconn->list);
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index ca268293cfa1..de43abf6d119 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -83,7 +83,6 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	unsigned char optbuf[sizeof(struct ip_options) + 40];
 	struct ip_options *opt = (struct ip_options *)optbuf;
 	struct iphdr *iph, _iph;
-	unsigned int start;
 	bool found = false;
 	__be32 info;
 	int optlen;
@@ -91,7 +90,6 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	iph = skb_header_pointer(skb, 0, sizeof(_iph), &_iph);
 	if (!iph)
 		return -EBADMSG;
-	start = sizeof(struct iphdr);
 
 	optlen = iph->ihl * 4 - (int)sizeof(struct iphdr);
 	if (optlen <= 0)
@@ -101,7 +99,7 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	/* Copy the options since __ip_options_compile() modifies
 	 * the options.
 	 */
-	if (skb_copy_bits(skb, start, opt->__data, optlen))
+	if (skb_copy_bits(skb, sizeof(struct iphdr), opt->__data, optlen))
 		return -EBADMSG;
 	opt->optlen = optlen;
 
@@ -116,18 +114,18 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 		found = target == IPOPT_SSRR ? opt->is_strictroute :
 					       !opt->is_strictroute;
 		if (found)
-			*offset = opt->srr + start;
+			*offset = opt->srr;
 		break;
 	case IPOPT_RR:
 		if (!opt->rr)
 			break;
-		*offset = opt->rr + start;
+		*offset = opt->rr;
 		found = true;
 		break;
 	case IPOPT_RA:
 		if (!opt->router_alert)
 			break;
-		*offset = opt->router_alert + start;
+		*offset = opt->router_alert;
 		found = true;
 		break;
 	default:
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 178044a845df..60c8b81a22dc 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2159,6 +2159,12 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EOPNOTSUPP;
 	}
 
+	/* Prevent creation of traffic classes with classid TC_H_ROOT */
+	if (clid == TC_H_ROOT) {
+		NL_SET_ERR_MSG(extack, "Cannot create traffic class with classid TC_H_ROOT");
+		return -EINVAL;
+	}
+
 	new_cl = cl;
 	err = -EOPNOTSUPP;
 	if (cops->change)
diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 7a5e4c454715..7dca66026ca4 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -121,8 +121,6 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Check to update highest and lowest priorities. */
 	if (skb_queue_empty(lp_qdisc)) {
 		if (q->lowest_prio == q->highest_prio) {
-			/* The incoming packet is the only packet in queue. */
-			BUG_ON(sch->q.qlen != 1);
 			q->lowest_prio = prio;
 			q->highest_prio = prio;
 		} else {
@@ -154,7 +152,6 @@ static struct sk_buff *skbprio_dequeue(struct Qdisc *sch)
 	/* Update highest priority field. */
 	if (skb_queue_empty(hpq)) {
 		if (q->lowest_prio == q->highest_prio) {
-			BUG_ON(sch->q.qlen);
 			q->highest_prio = 0;
 			q->lowest_prio = SKBPRIO_MAX_PRIORITY - 1;
 		} else {
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index ca8fdc9abca5..08cd06078fab 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -736,7 +736,7 @@ struct sctp_chunk *sctp_process_strreset_tsnreq(
 	 *     value SHOULD be the smallest TSN not acknowledged by the
 	 *     receiver of the request plus 2^31.
 	 */
-	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1 << 31);
+	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1U << 31);
 	sctp_tsnmap_init(&asoc->peer.tsn_map, SCTP_TSN_MAP_INITIAL,
 			 init_tsn, GFP_ATOMIC);
 
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 7777c0096a38..f6fe63f60acd 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -326,7 +326,8 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
-	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.sctp_hmac_alg);
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";
@@ -441,8 +442,7 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
-	struct net *net = container_of(ctl->data, struct net,
-				       sctp.sctp_hmac_alg);
+	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
 	struct ctl_table tbl;
 	int new_value, ret;
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5d490633a7f1..7877515a6962 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1204,7 +1204,11 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 	timeout = vsk->connect_timeout;
 	prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
-	while (sk->sk_state != TCP_ESTABLISHED && sk->sk_err == 0) {
+	/* If the socket is already closing or it is in an error state, there
+	 * is no point in waiting.
+	 */
+	while (sk->sk_state != TCP_ESTABLISHED &&
+	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
 		if (flags & O_NONBLOCK) {
 			/* If we're not going to block, we schedule a timeout
 			 * function to generate a timeout on the connection
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 9a6a8c4008ab..4499ff95e0e8 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -586,7 +586,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		xfrm_state_hold(x);
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol)
+			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 20af56ce245c..c68f0e045fb0 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -6,27 +6,24 @@ if [ `id -u` -ne 0 ]; then
 	exit 1
 fi
 
-SF=`which setfiles`
-if [ $? -eq 1 ]; then
+SF=`which setfiles` || {
 	echo "Could not find setfiles"
 	echo "Do you have policycoreutils installed?"
 	exit 1
-fi
+}
 
-CP=`which checkpolicy`
-if [ $? -eq 1 ]; then
+CP=`which checkpolicy` || {
 	echo "Could not find checkpolicy"
 	echo "Do you have checkpolicy installed?"
 	exit 1
-fi
+}
 VERS=`$CP -V | awk '{print $1}'`
 
-ENABLED=`which selinuxenabled`
-if [ $? -eq 1 ]; then
+ENABLED=`which selinuxenabled` || {
 	echo "Could not find selinuxenabled"
 	echo "Do you have libselinux-utils installed?"
 	exit 1
-fi
+}
 
 if selinuxenabled; then
     echo "SELinux is already enabled"
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 93bb7c5922e7..2e7b45f5f8b1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -519,6 +519,9 @@ static void alc_shutup_pins(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
+	if (spec->no_shutup_pins)
+		return;
+
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
@@ -534,8 +537,7 @@ static void alc_shutup_pins(struct hda_codec *codec)
 		alc_headset_mic_no_shutup(codec);
 		break;
 	default:
-		if (!spec->no_shutup_pins)
-			snd_hda_shutup_pins(codec);
+		snd_hda_shutup_pins(codec);
 		break;
 	}
 }
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 727d6703c905..ff4bd7d5c59e 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -955,7 +955,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(wm0010->dev, "Failed to set IRQ %d as wake source: %d\n",
 			irq, ret);
-		return ret;
+		goto free_irq;
 	}
 
 	if (spi->max_speed_hz)
@@ -967,9 +967,18 @@ static int wm0010_spi_probe(struct spi_device *spi)
 				     &soc_component_dev_wm0010, wm0010_dai,
 				     ARRAY_SIZE(wm0010_dai));
 	if (ret < 0)
-		return ret;
+		goto disable_irq_wake;
 
 	return 0;
+
+disable_irq_wake:
+	irq_set_irq_wake(wm0010->irq, 0);
+
+free_irq:
+	if (wm0010->irq)
+		free_irq(wm0010->irq, wm0010);
+
+	return ret;
 }
 
 static int wm0010_spi_remove(struct spi_device *spi)
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index df8d7b53b760..1564809dff3c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1612,20 +1612,6 @@ int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io)
 	return 1;
 }
 
-int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io)
-{
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-
-	if (!runtime) {
-		dev_warn(dev, "Can't update kctrl when idle\n");
-		return 0;
-	}
-
-	return 1;
-}
-
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg)
 {
 	cfg->cfg.val = cfg->val;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index d47608ff5fac..ea7a9939981b 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -737,7 +737,6 @@ struct rsnd_kctrl_cfg_s {
 #define rsnd_kctrl_vals(x)	((x).val)	/* = (x).cfg.val[0] */
 
 int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io);
-int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg);
 int rsnd_kctrl_new(struct rsnd_mod *mod,
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index fd52e26a3808..577d50e2cf8c 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -521,6 +521,22 @@ static irqreturn_t rsnd_src_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int rsnd_src_kctrl_accept_runtime(struct rsnd_dai_stream *io)
+{
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+
+	if (!runtime) {
+		struct rsnd_priv *priv = rsnd_io_to_priv(io);
+		struct device *dev = rsnd_priv_to_dev(priv);
+
+		dev_warn(dev, "\"SRC Out Rate\" can use during running\n");
+
+		return 0;
+	}
+
+	return 1;
+}
+
 static int rsnd_src_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -584,7 +600,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       rsnd_io_is_play(io) ?
 			       "SRC Out Rate" :
 			       "SRC In Rate",
-			       rsnd_kctrl_accept_runtime,
+			       rsnd_src_kctrl_accept_runtime,
 			       rsnd_src_set_convert_rate,
 			       &src->sync, 192000);
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1b547094de59..e752b6bb03ec 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2531,6 +2531,52 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 	}
 }
 
+/*
+ * Some Plantronics headsets have control names that don't meet ALSA naming
+ * standards. This function fixes nonstandard source names. By the time
+ * this function is called the control name should look like one of these:
+ * "source names Playback Volume"
+ * "source names Playback Switch"
+ * "source names Capture Volume"
+ * "source names Capture Switch"
+ * If any of the trigger words are found in the name then the name will
+ * be changed to:
+ * "Headset Playback Volume"
+ * "Headset Playback Switch"
+ * "Headset Capture Volume"
+ * "Headset Capture Switch"
+ * depending on the current suffix.
+ */
+static void snd_fix_plt_name(struct snd_usb_audio *chip,
+			     struct snd_ctl_elem_id *id)
+{
+	/* no variant of "Sidetone" should be added to this list */
+	static const char * const trigger[] = {
+		"Earphone", "Microphone", "Receive", "Transmit"
+	};
+	static const char * const suffix[] = {
+		" Playback Volume", " Playback Switch",
+		" Capture Volume", " Capture Switch"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(trigger); i++)
+		if (strstr(id->name, trigger[i]))
+			goto triggered;
+	usb_audio_dbg(chip, "no change in %s\n", id->name);
+	return;
+
+triggered:
+	for (i = 0; i < ARRAY_SIZE(suffix); i++)
+		if (strstr(id->name, suffix[i])) {
+			usb_audio_dbg(chip, "fixing kctl name %s\n", id->name);
+			snprintf(id->name, sizeof(id->name), "Headset%s",
+				 suffix[i]);
+			return;
+		}
+	usb_audio_dbg(chip, "something wrong in kctl name %s\n", id->name);
+}
+
 void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 				  struct usb_mixer_elem_info *cval, int unitid,
 				  struct snd_kcontrol *kctl)
@@ -2548,5 +2594,10 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			cval->min_mute = 1;
 		break;
 	}
+
+	/* ALSA-ify some Plantronics headset control names */
+	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
+	    (cval->control == UAC_FU_MUTE || cval->control == UAC_FU_VOLUME))
+		snd_fix_plt_name(mixer->chip, &kctl->id);
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 02460362256d..3cfaa843b6a9 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -110,7 +110,7 @@ struct pyrf_event {
 };
 
 #define sample_members \
-	sample_member_def(sample_ip, ip, T_ULONGLONG, "event type"),			 \
+	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
 	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
@@ -537,6 +537,11 @@ static PyObject *pyrf_event__new(union perf_event *event)
 	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
 		return NULL;
 
+	// FIXME this better be dynamic or we need to parse everything
+	// before calling perf_mmap__consume(), including tracepoint fields.
+	if (sizeof(pevent->event) < event->header.size)
+		return NULL;
+
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL)
@@ -1036,6 +1041,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		evsel = perf_evlist__event2evsel(evlist, event);
 		if (!evsel) {
+			Py_DECREF(pyevent);
 			Py_INCREF(Py_None);
 			return Py_None;
 		}
@@ -1047,9 +1053,12 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(md);
 
-		if (err)
+		if (err) {
+			Py_DECREF(pyevent);
 			return PyErr_Format(PyExc_OSError,
 					    "perf: can't parse sample, err=%d", err);
+		}
+
 		return pyevent;
 	}
 end:
diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index a46762aec4c9..24c83b8b8c98 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -57,7 +57,7 @@ unsigned long convert_unit(unsigned long value, char *unit)
 
 int unit_number__scnprintf(char *buf, size_t size, u64 n)
 {
-	char unit[4] = "BKMG";
+	char unit[] = "BKMG";
 	int i = 0;
 
 	while (((n / 1024) > 1) && (i < 3)) {

