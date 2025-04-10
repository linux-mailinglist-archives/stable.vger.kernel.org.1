Return-Path: <stable+bounces-132101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E620A843DB
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC8D1B84B41
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00828A3E9;
	Thu, 10 Apr 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NB7xxEwV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8928540E;
	Thu, 10 Apr 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289867; cv=none; b=Td5pmQ5da9UTUUp9ESMYfXGMPb3CxhJchkFbbM/ECCuq+nf/m5Xyyoe57n866fHt6nVYOWJyDgFSEXZNelGCs+2MTpbE4R1iVpbEknr3cIJXmYOHKKNy6lAaSZSeDywvmXjij9wQ+0LGlY+gK4OoGmsUFDnKgp24MlKUi5UjHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289867; c=relaxed/simple;
	bh=HwrvrANPHViHRFp4PGUOYFxKwdr4+LADb2Ucs7nc3eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq/JEyRiNx1mvtMDLsGIQLhCzVkaAcryko4qvI0akP70spI6TeAzwsZem1STvwqfOe/P4jjJV+xLStkzhNIEgEAn1EW69cLR5ibMpanxs3ZeKu1Y7aN2+DyKGIJU+89CLeX7lqDxzqXg+yyy8ql1EA2UY0Ts9b94bK0Gw/F45Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NB7xxEwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78641C4CEE8;
	Thu, 10 Apr 2025 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744289867;
	bh=HwrvrANPHViHRFp4PGUOYFxKwdr4+LADb2Ucs7nc3eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NB7xxEwV3EI4PQ2HbgCOO/2OTZu7TlykL5d4XXd36r5Jegzmg8NHeqaR3t9RyJjjs
	 GpaJvl9l10gVojUDmJqB90lRA9uH18KkU64FV0mIiq5OdegazpjZYT3gXPV9LZAc6N
	 qYvrYAj/tzmUWuefXdpTrvbJAyEL4U9Yn/Bikce8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.236
Date: Thu, 10 Apr 2025 14:55:55 +0200
Message-ID: <2025041055-elongated-theology-3a83@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041055-viable-ember-1805@gregkh>
References: <2025041055-viable-ember-1805@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index c4c70e1aada3..f136f1b057d5 100644
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
index c73255fd9258..e13f8f8a9ea9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 235
+SUBLEVEL = 236
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
index 8049997fa372..2039a8c8d547 100644
--- a/arch/alpha/include/asm/elf.h
+++ b/arch/alpha/include/asm/elf.h
@@ -74,7 +74,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == EM_ALPHA)
+#define elf_check_arch(x) (((x)->e_machine == EM_ALPHA) && !((x)->e_flags & EF_ALPHA_32BIT))
 
 /*
  * These are used to set parameters in the core dumps.
@@ -145,10 +145,6 @@ extern int dump_elf_task_fp(elf_fpreg_t *dest, struct task_struct *task);
 	: amask (AMASK_CIX) ? "ev6" : "ev67");	\
 })
 
-#define SET_PERSONALITY(EX)					\
-	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
-	   ? PER_LINUX_32BIT : PER_LINUX)
-
 extern int alpha_l1i_cacheshape;
 extern int alpha_l1d_cacheshape;
 extern int alpha_l2_cacheshape;
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 12c120e436a2..1cffeda415a4 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -347,7 +347,7 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 
 extern void paging_init(void);
 
-/* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
+/* We have our own get_unmapped_area */
 #define HAVE_ARCH_UNMAPPED_AREA
 
 #endif /* _ALPHA_PGTABLE_H */
diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index 6100431da07a..d27db62c3247 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -8,23 +8,19 @@
 #ifndef __ASM_ALPHA_PROCESSOR_H
 #define __ASM_ALPHA_PROCESSOR_H
 
-#include <linux/personality.h>	/* for ADDR_LIMIT_32BIT */
-
 /*
  * We have a 42-bit user address space: 4TB user VM...
  */
 #define TASK_SIZE (0x40000000000UL)
 
-#define STACK_TOP \
-  (current->personality & ADDR_LIMIT_32BIT ? 0x80000000 : 0x00120000000UL)
+#define STACK_TOP (0x00120000000UL)
 
 #define STACK_TOP_MAX	0x00120000000UL
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE \
-  ((current->personality & ADDR_LIMIT_32BIT) ? 0x40000000 : TASK_SIZE / 2)
+#define TASK_UNMAPPED_BASE (TASK_SIZE / 2)
 
 typedef struct {
 	unsigned long seg;
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d5367a1c6300..6f53eecbb575 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1212,8 +1212,7 @@ SYSCALL_DEFINE1(old_adjtimex, struct timex32 __user *, txc_p)
 	return ret;
 }
 
-/* Get an address range which is currently unmapped.  Similar to the
-   generic version except that we know how to honor ADDR_LIMIT_32BIT.  */
+/* Get an address range which is currently unmapped. */
 
 static unsigned long
 arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
@@ -1235,13 +1234,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		       unsigned long len, unsigned long pgoff,
 		       unsigned long flags)
 {
-	unsigned long limit;
-
-	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
-	if (current->personality & ADDR_LIMIT_32BIT)
-		limit = 0x80000000;
-	else
-		limit = TASK_SIZE;
+	unsigned long limit = TASK_SIZE;
 
 	if (len > limit)
 		return -ENOMEM;
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index b50229c3102f..9bb98338609b 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -133,7 +133,7 @@ uart2: serial@7e201400 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -144,7 +144,7 @@ uart3: serial@7e201600 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -155,7 +155,7 @@ uart4: serial@7e201800 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -166,7 +166,7 @@ uart5: serial@7e201a00 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -424,8 +424,6 @@ IRQ_TYPE_LEVEL_LOW)>,
 					  IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
 					  IRQ_TYPE_LEVEL_LOW)>;
-		/* This only applies to the ARMv7 stub */
-		arm,cpu-registers-not-fw-configured;
 	};
 
 	cpus: cpus {
@@ -1115,6 +1113,7 @@ &txp {
 };
 
 &uart0 {
+	arm,primecell-periphid = <0x00341011>;
 	interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 };
 
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
index af5177801fb1..bf1577216ffa 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -26,6 +26,13 @@
 
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
@@ -552,6 +559,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 908e9b8e79fe..373814bbc43d 100644
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
@@ -436,8 +438,11 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
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
index 00ae2e2adcad..93a1f9937a9b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -174,7 +174,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_EISA
+	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4b357e5bbfe..b6715c835f9f 100644
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
index 8c87a2e0b660..041163f773fe 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -222,7 +222,7 @@ void flush_tlb_others(const struct cpumask *cpumask,
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 936085d819b1..9fb144f11a33 100644
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
index 14e5e1d7d0e8..33b64fff2b3c 100644
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
@@ -389,16 +388,6 @@ static void __init ms_hyperv_init_platform(void)
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
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a932a07d0025..49e9e7407753 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -399,10 +399,8 @@ int crash_load_segments(struct kimage *image)
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
-	if (ret) {
-		vfree((void *)image->arch.elf_headers);
+	if (ret)
 		return ret;
-	}
 	image->arch.elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.bufsz);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b9736aac20ee..cf92191de2b2 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,6 +195,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -213,9 +214,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
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
index ce904c89c6c7..3e01b8086403 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -22,8 +22,10 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a98e5b..19f6aafd595a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -402,9 +402,6 @@ void machine_kexec(struct kimage *image)
 #ifdef CONFIG_KEXEC_FILE
 void *arch_kexec_kernel_image_load(struct kimage *image)
 {
-	vfree(image->arch.elf_headers);
-	image->arch.elf_headers = NULL;
-
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
 
@@ -540,6 +537,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 	       (int)ELF64_R_TYPE(rel[i].r_info), value);
 	return -ENOEXEC;
 }
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
 #endif /* CONFIG_KEXEC_FILE */
 
 static int
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 4f731981d326..38c517a786f4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -88,7 +88,12 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
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
index 13d1a0ac8916..d59ed209f02e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -919,7 +919,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -939,7 +939,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	local_irq_save(flags);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 20eb8f55e1f1..e097faf12c82 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1618,6 +1618,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
 	u32 vector;
 	bool all_cpus;
 
+	if (!lapic_in_kernel(current_vcpu))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 	if (!ex) {
 		if (!fast) {
 			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
@@ -2060,7 +2063,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
-			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
+			if (!vcpu || lapic_in_kernel(vcpu))
+				ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
 			if (evmcs_ver)
 				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index 0612a73638a8..7641cff719bd 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -183,7 +183,7 @@ static int pageattr_test(void)
 			break;
 
 		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			err = change_page_attr_set(addrs, len[i], PAGE_CPA_TEST, 1);
 			break;
 
 		case 2:
diff --git a/block/bio.c b/block/bio.c
index 6f7a1aa9ea22..88a09c31095f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -55,7 +55,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static struct bio_slab *bio_slabs;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 16857612103e..8992fdb92902 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -484,7 +484,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
 			family = call_pkg->nd_family;
-			if (family > NVDIMM_BUS_FAMILY_MAX ||
+			if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
 			    !test_bit(family, &nd_desc->bus_family_mask))
 				return -EINVAL;
 			family = array_index_nospec(family,
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ae07927910ca..42c7bdb352d2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -270,6 +270,10 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 			 ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT 0x%x",
 			 pr->power.states[ACPI_STATE_C3].address);
 
+	if (!pr->power.states[ACPI_STATE_C2].address &&
+	    !pr->power.states[ACPI_STATE_C3].address)
+		return -ENODEV;
+
 	return 0;
 }
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b00dad7ea8d4..14898b4fadf0 100644
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
index fbc57c4fcdd0..00a0bdcbb4aa 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -900,6 +900,9 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Complete;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -918,9 +921,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -960,7 +960,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_suspended = false;
 
- Unlock:
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
 
@@ -1242,14 +1241,13 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	dev->power.is_noirq_suspended = true;
 
 	/*
-	 * Skipping the resume of devices that were in use right before the
-	 * system suspend (as indicated by their PM-runtime usage counters)
-	 * would be suboptimal.  Also resume them if doing that is not allowed
-	 * to be skipped.
+	 * Devices must be resumed unless they are explicitly allowed to be left
+	 * in suspend, but even in that case skipping the resume of devices that
+	 * were in use right before the system suspend (as indicated by their
+	 * runtime PM usage counters and child counters) would be suboptimal.
 	 */
-	if (atomic_read(&dev->power.usage_count) > 1 ||
-	    !(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
-	      dev->power.may_skip_resume))
+	if (!(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
+	      dev->power.may_skip_resume) || !pm_runtime_need_not_resume(dev))
 		dev->power.must_resume = true;
 
 	if (dev->power.must_resume)
@@ -1646,6 +1644,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev)) {
 				pm_dev_dbg(dev, state, "direct-complete ");
+				dev->power.is_suspended = true;
 				goto Complete;
 			}
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index f5c9e6629f0c..4950864d3ea5 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1811,7 +1811,7 @@ void pm_runtime_drop_link(struct device_link *link)
 	pm_request_idle(link->supplier);
 }
 
-static bool pm_runtime_need_not_resume(struct device *dev)
+bool pm_runtime_need_not_resume(struct device *dev)
 {
 	return atomic_read(&dev->power.usage_count) <= 1 &&
 		(atomic_read(&dev->power.child_count) == 0 ||
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 2876bb83d9d0..3280b7410a13 100644
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
@@ -4124,7 +4136,7 @@ static MESON_GATE(g12a_spicc_1,			HHI_GCLK_MPEG0,	14);
 static MESON_GATE(g12a_hiu_reg,			HHI_GCLK_MPEG0,	19);
 static MESON_GATE(g12a_mipi_dsi_phy,		HHI_GCLK_MPEG0,	20);
 static MESON_GATE(g12a_assist_misc,		HHI_GCLK_MPEG0,	23);
-static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	4);
+static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	24);
 static MESON_GATE(g12a_emmc_b,			HHI_GCLK_MPEG0,	25);
 static MESON_GATE(g12a_emmc_c,			HHI_GCLK_MPEG0,	26);
 static MESON_GATE(g12a_audio_codec,		HHI_GCLK_MPEG0,	28);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index d42551a46ec9..cfdb1ce6d361 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1269,14 +1269,13 @@ static struct clk_regmap gxbb_cts_i958 = {
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
@@ -1286,6 +1285,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 		.offset = HHI_32K_CLK_CNTL,
 		.mask = 0x3,
 		.shift = 16,
+		.table = gxbb_32k_clk_parents_val_table,
 		},
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_sel",
@@ -1309,7 +1309,7 @@ static struct clk_regmap gxbb_32k_clk_div = {
 			&gxbb_32k_clk_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 2429b7c2a8b3..f02188714749 100644
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
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1949ae7851b2..0468ce5506ae 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -64,11 +64,11 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
+	ctx->clk_data.num = nr_clks;
 	for (i = 0; i < nr_clks; ++i)
 		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
 	ctx->reg_base = base;
-	ctx->clk_data.num = nr_clks;
 	spin_lock_init(&ctx->lock);
 
 	return ctx;
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
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 6f17644b6e0b..40d02df8acf7 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -377,6 +377,25 @@ static int mchp_tc_probe(struct platform_device *pdev)
 			channel);
 	}
 
+	/* Disable Quadrature Decoder and position measure */
+	ret = regmap_update_bits(regmap, ATMEL_TC_BMR, ATMEL_TC_QDEN | ATMEL_TC_POSEN, 0);
+	if (ret)
+		return ret;
+
+	/* Setup the period capture mode */
+	ret = regmap_update_bits(regmap, ATMEL_TC_REG(priv->channel[0], CMR),
+				 ATMEL_TC_WAVE | ATMEL_TC_ABETRG | ATMEL_TC_CMR_MASK |
+				 ATMEL_TC_TCCLKS,
+				 ATMEL_TC_CMR_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable clock and trigger counter */
+	ret = regmap_write(regmap, ATMEL_TC_REG(priv->channel[0], CCR),
+			   ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
+	if (ret)
+		return ret;
+
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
 	priv->counter.name = dev_name(&pdev->dev);
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index b084e971a493..04309e561926 100644
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
index 63f7c219062b..d8b1a0d4cd21 100644
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
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index e5140ad63db8..c79cdf1be780 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -47,8 +47,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	u64 rate = policy->freq_table[index].frequency * 1000;
+	unsigned long freq_khz = policy->freq_table[index].frequency;
 	struct scpi_data *priv = policy->driver_data;
+	unsigned long rate = freq_khz * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
@@ -56,7 +57,7 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (ret)
 		return ret;
 
-	if (clk_get_rate(priv->clk) != rate)
+	if (clk_get_rate(priv->clk) / 1000 != freq_khz)
 		return -EIO;
 
 	return 0;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 2dbec638cca8..ce2ff9538c8d 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -856,11 +856,6 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 	struct crypto_shash *hash_tfm = ctx->hash_tfm;
 	int blocksize, ret;
 
-	if (!keys->authkeylen) {
-		pr_err("hisi_sec2: aead auth key error!\n");
-		return -EINVAL;
-	}
-
 	blocksize = crypto_shash_blocksize(hash_tfm);
 	if (keys->authkeylen > blocksize) {
 		ret = crypto_shash_tfm_digest(hash_tfm, keys->authkey,
@@ -871,7 +866,8 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 		}
 		ctx->a_key_len = blocksize;
 	} else {
-		memcpy(ctx->a_key, keys->authkey, keys->authkeylen);
+		if (keys->authkeylen)
+			memcpy(ctx->a_key, keys->authkey, keys->authkeylen);
 		ctx->a_key_len = keys->authkeylen;
 	}
 
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index c47963240b65..cad20e87783b 100644
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
@@ -609,7 +608,7 @@ static int __init ie31200_init(void)
 
 	pci_rc = pci_register_driver(&ie31200_driver);
 	if (pci_rc < 0)
-		goto fail0;
+		return pci_rc;
 
 	if (!mci_pdev) {
 		ie31200_registered = 0;
@@ -620,11 +619,13 @@ static int __init ie31200_init(void)
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
@@ -632,12 +633,12 @@ static int __init ie31200_init(void)
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
index dca79caccd01..fa25c082109a 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -279,6 +279,7 @@ static int imx_scu_probe(struct platform_device *pdev)
 		return ret;
 
 	sc_ipc->fast_ipc = of_device_is_compatible(args.np, "fsl,imx8-mu-scu");
+	of_node_put(args.np);
 
 	num_channel = sc_ipc->fast_ipc ? 2 : SCU_MU_CHAN_NUM;
 	for (i = 0; i < num_channel; i++) {
diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 7127a04bca19..0d96dbbba74e 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -312,7 +312,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 50921b340b88..786cd892f179 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3719,10 +3719,53 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 };
 
 
+static void get_min_max_dc_plane_scaling(struct drm_device *dev,
+					 struct drm_framebuffer *fb,
+					 int *min_downscale, int *max_upscale)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc *dc = adev->dm.dc;
+	/* Caps for all supported planes are the same on DCE and DCN 1 - 3 */
+	struct dc_plane_cap *plane_cap = &dc->caps.planes[0];
+
+	switch (fb->format->format) {
+	case DRM_FORMAT_P010:
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
+		*max_upscale = plane_cap->max_upscale_factor.nv12;
+		*min_downscale = plane_cap->max_downscale_factor.nv12;
+		break;
+
+	case DRM_FORMAT_XRGB16161616F:
+	case DRM_FORMAT_ARGB16161616F:
+	case DRM_FORMAT_XBGR16161616F:
+	case DRM_FORMAT_ABGR16161616F:
+		*max_upscale = plane_cap->max_upscale_factor.fp16;
+		*min_downscale = plane_cap->max_downscale_factor.fp16;
+		break;
+
+	default:
+		*max_upscale = plane_cap->max_upscale_factor.argb8888;
+		*min_downscale = plane_cap->max_downscale_factor.argb8888;
+		break;
+	}
+
+	/*
+	 * A factor of 1 in the plane_cap means to not allow scaling, ie. use a
+	 * scaling factor of 1.0 == 1000 units.
+	 */
+	if (*max_upscale == 1)
+		*max_upscale = 1000;
+
+	if (*min_downscale == 1)
+		*min_downscale = 1000;
+}
+
+
 static int fill_dc_scaling_info(const struct drm_plane_state *state,
 				struct dc_scaling_info *scaling_info)
 {
-	int scale_w, scale_h;
+	int scale_w, scale_h, min_downscale, max_upscale;
 
 	memset(scaling_info, 0, sizeof(*scaling_info));
 
@@ -3788,17 +3831,25 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	/* DRM doesn't specify clipping on destination output. */
 	scaling_info->clip_rect = scaling_info->dst_rect;
 
-	/* TODO: Validate scaling per-format with DC plane caps */
+	/* Validate scaling per-format with DC plane caps */
+	if (state->plane && state->plane->dev && state->fb) {
+		get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
+					     &min_downscale, &max_upscale);
+	} else {
+		min_downscale = 250;
+		max_upscale = 16000;
+	}
+
 	scale_w = scaling_info->dst_rect.width * 1000 /
 		  scaling_info->src_rect.width;
 
-	if (scale_w < 250 || scale_w > 16000)
+	if (scale_w < min_downscale || scale_w > max_upscale)
 		return -EINVAL;
 
 	scale_h = scaling_info->dst_rect.height * 1000 /
 		  scaling_info->src_rect.height;
 
-	if (scale_h < 250 || scale_h > 16000)
+	if (scale_h < min_downscale || scale_h > max_upscale)
 		return -EINVAL;
 
 	/*
@@ -6010,12 +6061,51 @@ static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 static int dm_plane_helper_check_state(struct drm_plane_state *state,
 				       struct drm_crtc_state *new_crtc_state)
 {
-	int max_downscale = 0;
-	int max_upscale = INT_MAX;
+	struct drm_framebuffer *fb = state->fb;
+	int min_downscale, max_upscale;
+	int min_scale = 0;
+	int max_scale = INT_MAX;
+
+	/* Plane enabled? Validate viewport and get scaling factors from plane caps. */
+	if (fb && state->crtc) {
+		/* Validate viewport to cover the case when only the position changes */
+		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
+			int viewport_width = state->crtc_w;
+			int viewport_height = state->crtc_h;
+
+			if (state->crtc_x < 0)
+				viewport_width += state->crtc_x;
+			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
+				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
+
+			if (state->crtc_y < 0)
+				viewport_height += state->crtc_y;
+			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
+				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
+
+			/* If completely outside of screen, viewport_width and/or viewport_height will be negative,
+			 * which is still OK to satisfy the condition below, thereby also covering these cases
+			 * (when plane is completely outside of screen).
+			 * x2 for width is because of pipe-split.
+			 */
+			if (viewport_width < MIN_VIEWPORT_SIZE*2 || viewport_height < MIN_VIEWPORT_SIZE)
+				return -EINVAL;
+		}
+
+		/* Get min/max allowed scaling factors from plane caps. */
+		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
+					     &min_downscale, &max_upscale);
+		/*
+		 * Convert to drm convention: 16.16 fixed point, instead of dc's
+		 * 1.0 == 1000. Also drm scaling is src/dst instead of dc's
+		 * dst/src, so min_scale = 1.0 / max_upscale, etc.
+		 */
+		min_scale = (1000 << 16) / max_upscale;
+		max_scale = (1000 << 16) / min_downscale;
+	}
 
-	/* TODO: These should be checked against DC plane caps */
 	return drm_atomic_helper_check_plane_state(
-		state, new_crtc_state, max_downscale, max_upscale, true, true);
+		state, new_crtc_state, min_scale, max_scale, true, true);
 }
 
 static int dm_plane_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 32dbd2a27088..6914738f0275 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -424,7 +424,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -576,7 +576,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -1091,7 +1091,7 @@ static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 						(long *)param, buf,
 						max_param_num,
 						&param_nums)) {
@@ -1272,7 +1272,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1426,7 +1426,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1580,7 +1580,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1727,7 +1727,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0c3b15992b81..12f478294805 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -383,6 +383,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	for (i = 0; i < hdcp_work->max_link; i++) {
 		cancel_delayed_work_sync(&hdcp_work[i].callback_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
+		cancel_delayed_work_sync(&hdcp_work[i].property_validate_dwork);
 	}
 
 	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3af9591baa76..8dace2e401bb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -647,124 +647,23 @@ static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *spli
 	}
 }
 
-static void calculate_viewport(struct pipe_ctx *pipe_ctx)
+/*
+ * This is a preliminary vp size calculation to allow us to check taps support.
+ * The result is completely overridden afterwards.
+ */
+static void calculate_viewport_size(struct pipe_ctx *pipe_ctx)
 {
-	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-	const struct dc_stream_state *stream = pipe_ctx->stream;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
-	struct rect surf_src = plane_state->src_rect;
-	struct rect clip, dest;
-	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
-			|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
-	int split_count = 0;
-	int split_idx = 0;
-	bool orthogonal_rotation, flip_y_start, flip_x_start;
-
-	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
-
-	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE ||
-		stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM) {
-		split_count = 0;
-		split_idx = 0;
-	}
-
-	/* The actual clip is an intersection between stream
-	 * source and surface clip
-	 */
-	dest = plane_state->dst_rect;
-	clip.x = stream->src.x > plane_state->clip_rect.x ?
-			stream->src.x : plane_state->clip_rect.x;
-
-	clip.width = stream->src.x + stream->src.width <
-			plane_state->clip_rect.x + plane_state->clip_rect.width ?
-			stream->src.x + stream->src.width - clip.x :
-			plane_state->clip_rect.x + plane_state->clip_rect.width - clip.x ;
-
-	clip.y = stream->src.y > plane_state->clip_rect.y ?
-			stream->src.y : plane_state->clip_rect.y;
-
-	clip.height = stream->src.y + stream->src.height <
-			plane_state->clip_rect.y + plane_state->clip_rect.height ?
-			stream->src.y + stream->src.height - clip.y :
-			plane_state->clip_rect.y + plane_state->clip_rect.height - clip.y ;
-
-	/*
-	 * Need to calculate how scan origin is shifted in vp space
-	 * to correctly rotate clip and dst
-	 */
-	get_vp_scan_direction(
-			plane_state->rotation,
-			plane_state->horizontal_mirror,
-			&orthogonal_rotation,
-			&flip_y_start,
-			&flip_x_start);
-
-	if (orthogonal_rotation) {
-		swap(clip.x, clip.y);
-		swap(clip.width, clip.height);
-		swap(dest.x, dest.y);
-		swap(dest.width, dest.height);
-	}
-	if (flip_x_start) {
-		clip.x = dest.x + dest.width - clip.x - clip.width;
-		dest.x = 0;
-	}
-	if (flip_y_start) {
-		clip.y = dest.y + dest.height - clip.y - clip.height;
-		dest.y = 0;
-	}
-
-	/* offset = surf_src.ofs + (clip.ofs - surface->dst_rect.ofs) * scl_ratio
-	 * num_pixels = clip.num_pix * scl_ratio
-	 */
-	data->viewport.x = surf_src.x + (clip.x - dest.x) * surf_src.width / dest.width;
-	data->viewport.width = clip.width * surf_src.width / dest.width;
-
-	data->viewport.y = surf_src.y + (clip.y - dest.y) * surf_src.height / dest.height;
-	data->viewport.height = clip.height * surf_src.height / dest.height;
-
-	/* Handle split */
-	if (split_count) {
-		/* extra pixels in the division remainder need to go to pipes after
-		 * the extra pixel index minus one(epimo) defined here as:
-		 */
-		int epimo = 0;
-
-		if (orthogonal_rotation) {
-			if (flip_y_start)
-				split_idx = split_count - split_idx;
-
-			epimo = split_count - data->viewport.height % (split_count + 1);
-
-			data->viewport.y += (data->viewport.height / (split_count + 1)) * split_idx;
-			if (split_idx > epimo)
-				data->viewport.y += split_idx - epimo - 1;
-			data->viewport.height = data->viewport.height / (split_count + 1) + (split_idx > epimo ? 1 : 0);
-		} else {
-			if (flip_x_start)
-				split_idx = split_count - split_idx;
 
-			epimo = split_count - data->viewport.width % (split_count + 1);
-
-			data->viewport.x += (data->viewport.width / (split_count + 1)) * split_idx;
-			if (split_idx > epimo)
-				data->viewport.x += split_idx - epimo - 1;
-			data->viewport.width = data->viewport.width / (split_count + 1) + (split_idx > epimo ? 1 : 0);
-		}
+	data->viewport.width = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.horz, data->recout.width));
+	data->viewport.height = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.vert, data->recout.height));
+	data->viewport_c.width = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.horz_c, data->recout.width));
+	data->viewport_c.height = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.vert_c, data->recout.height));
+	if (pipe_ctx->plane_state->rotation == ROTATION_ANGLE_90 ||
+			pipe_ctx->plane_state->rotation == ROTATION_ANGLE_270) {
+		swap(data->viewport.width, data->viewport.height);
+		swap(data->viewport_c.width, data->viewport_c.height);
 	}
-
-	/* Round down, compensate in init */
-	data->viewport_c.x = data->viewport.x / vpc_div;
-	data->viewport_c.y = data->viewport.y / vpc_div;
-	data->inits.h_c = (data->viewport.x % vpc_div) != 0 ? dc_fixpt_half : dc_fixpt_zero;
-	data->inits.v_c = (data->viewport.y % vpc_div) != 0 ? dc_fixpt_half : dc_fixpt_zero;
-
-	/* Round up, assume original video size always even dimensions */
-	data->viewport_c.width = (data->viewport.width + vpc_div - 1) / vpc_div;
-	data->viewport_c.height = (data->viewport.height + vpc_div - 1) / vpc_div;
-
-	data->viewport_unadjusted = data->viewport;
-	data->viewport_c_unadjusted = data->viewport_c;
 }
 
 static void calculate_recout(struct pipe_ctx *pipe_ctx)
@@ -773,26 +672,21 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	const struct dc_stream_state *stream = pipe_ctx->stream;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
 	struct rect surf_clip = plane_state->clip_rect;
-	bool pri_split_tb = pipe_ctx->bottom_pipe &&
-			pipe_ctx->bottom_pipe->plane_state == pipe_ctx->plane_state &&
-			stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
-	bool sec_split_tb = pipe_ctx->top_pipe &&
-			pipe_ctx->top_pipe->plane_state == pipe_ctx->plane_state &&
-			stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
-	int split_count = 0;
-	int split_idx = 0;
+	bool split_tb = stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
+	int split_count, split_idx;
 
 	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
+	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
+		split_idx = 0;
 
 	/*
 	 * Only the leftmost ODM pipe should be offset by a nonzero distance
 	 */
-	if (!pipe_ctx->prev_odm_pipe) {
+	if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
 		data->recout.x = stream->dst.x;
 		if (stream->src.x < surf_clip.x)
 			data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
 						/ stream->src.width;
-
 	} else
 		data->recout.x = 0;
 
@@ -809,26 +703,31 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	if (data->recout.height + data->recout.y > stream->dst.y + stream->dst.height)
 		data->recout.height = stream->dst.y + stream->dst.height - data->recout.y;
 
-	/* Handle h & v split, handle rotation using viewport */
-	if (sec_split_tb) {
-		data->recout.y += data->recout.height / 2;
-		/* Floor primary pipe, ceil 2ndary pipe */
-		data->recout.height = (data->recout.height + 1) / 2;
-	} else if (pri_split_tb)
+	/* Handle h & v split */
+	if (split_tb) {
+		ASSERT(data->recout.height % 2 == 0);
 		data->recout.height /= 2;
-	else if (split_count) {
-		/* extra pixels in the division remainder need to go to pipes after
-		 * the extra pixel index minus one(epimo) defined here as:
-		 */
-		int epimo = split_count - data->recout.width % (split_count + 1);
-
-		/*no recout offset due to odm */
+	} else if (split_count) {
 		if (!pipe_ctx->next_odm_pipe && !pipe_ctx->prev_odm_pipe) {
+			/* extra pixels in the division remainder need to go to pipes after
+			 * the extra pixel index minus one(epimo) defined here as:
+			 */
+			int epimo = split_count - data->recout.width % (split_count + 1);
+
 			data->recout.x += (data->recout.width / (split_count + 1)) * split_idx;
 			if (split_idx > epimo)
 				data->recout.x += split_idx - epimo - 1;
+			ASSERT(stream->view_format != VIEW_3D_FORMAT_SIDE_BY_SIDE || data->recout.width % 2 == 0);
+			data->recout.width = data->recout.width / (split_count + 1) + (split_idx > epimo ? 1 : 0);
+		} else {
+			/* odm */
+			if (split_idx == split_count) {
+				/* rightmost pipe is the remainder recout */
+				data->recout.width -= data->h_active * split_count - data->recout.x;
+				data->recout.x = 0;
+			} else
+				data->recout.width = data->h_active - data->recout.x;
 		}
-		data->recout.width = data->recout.width / (split_count + 1) + (split_idx > epimo ? 1 : 0);
 	}
 }
 
@@ -882,9 +781,15 @@ static void calculate_scaling_ratios(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.ratios.vert_c, 19);
 }
 
-static inline void adjust_vp_and_init_for_seamless_clip(
+
+/*
+ * We completely calculate vp offset, size and inits here based entirely on scaling
+ * ratios and recout for pixel perfect pipe combine.
+ */
+static void calculate_init_and_vp(
 		bool flip_scan_dir,
-		int recout_skip,
+		int recout_offset_within_recout_full,
+		int recout_size,
 		int src_size,
 		int taps,
 		struct fixed31_32 ratio,
@@ -892,91 +797,87 @@ static inline void adjust_vp_and_init_for_seamless_clip(
 		int *vp_offset,
 		int *vp_size)
 {
-	if (!flip_scan_dir) {
-		/* Adjust for viewport end clip-off */
-		if ((*vp_offset + *vp_size) < src_size) {
-			int vp_clip = src_size - *vp_size - *vp_offset;
-			int int_part = dc_fixpt_floor(dc_fixpt_sub(*init, ratio));
-
-			int_part = int_part > 0 ? int_part : 0;
-			*vp_size += int_part < vp_clip ? int_part : vp_clip;
-		}
-
-		/* Adjust for non-0 viewport offset */
-		if (*vp_offset) {
-			int int_part;
-
-			*init = dc_fixpt_add(*init, dc_fixpt_mul_int(ratio, recout_skip));
-			int_part = dc_fixpt_floor(*init) - *vp_offset;
-			if (int_part < taps) {
-				int int_adj = *vp_offset >= (taps - int_part) ?
-							(taps - int_part) : *vp_offset;
-				*vp_offset -= int_adj;
-				*vp_size += int_adj;
-				int_part += int_adj;
-			} else if (int_part > taps) {
-				*vp_offset += int_part - taps;
-				*vp_size -= int_part - taps;
-				int_part = taps;
-			}
-			init->value &= 0xffffffff;
-			*init = dc_fixpt_add_int(*init, int_part);
-		}
-	} else {
-		/* Adjust for non-0 viewport offset */
-		if (*vp_offset) {
-			int int_part = dc_fixpt_floor(dc_fixpt_sub(*init, ratio));
+	struct fixed31_32 temp;
+	int int_part;
 
-			int_part = int_part > 0 ? int_part : 0;
-			*vp_size += int_part < *vp_offset ? int_part : *vp_offset;
-			*vp_offset -= int_part < *vp_offset ? int_part : *vp_offset;
-		}
-
-		/* Adjust for viewport end clip-off */
-		if ((*vp_offset + *vp_size) < src_size) {
-			int int_part;
-			int end_offset = src_size - *vp_offset - *vp_size;
-
-			/*
-			 * this is init if vp had no offset, keep in mind this is from the
-			 * right side of vp due to scan direction
-			 */
-			*init = dc_fixpt_add(*init, dc_fixpt_mul_int(ratio, recout_skip));
-			/*
-			 * this is the difference between first pixel of viewport available to read
-			 * and init position, takning into account scan direction
-			 */
-			int_part = dc_fixpt_floor(*init) - end_offset;
-			if (int_part < taps) {
-				int int_adj = end_offset >= (taps - int_part) ?
-							(taps - int_part) : end_offset;
-				*vp_size += int_adj;
-				int_part += int_adj;
-			} else if (int_part > taps) {
-				*vp_size += int_part - taps;
-				int_part = taps;
-			}
-			init->value &= 0xffffffff;
-			*init = dc_fixpt_add_int(*init, int_part);
-		}
+	/*
+	 * First of the taps starts sampling pixel number <init_int_part> corresponding to recout
+	 * pixel 1. Next recout pixel samples int part of <init + scaling ratio> and so on.
+	 * All following calculations are based on this logic.
+	 *
+	 * Init calculated according to formula:
+	 * 	init = (scaling_ratio + number_of_taps + 1) / 2
+	 * 	init_bot = init + scaling_ratio
+	 * 	to get pixel perfect combine add the fraction from calculating vp offset
+	 */
+	temp = dc_fixpt_mul_int(ratio, recout_offset_within_recout_full);
+	*vp_offset = dc_fixpt_floor(temp);
+	temp.value &= 0xffffffff;
+	*init = dc_fixpt_truncate(dc_fixpt_add(dc_fixpt_div_int(
+			dc_fixpt_add_int(ratio, taps + 1), 2), temp), 19);
+	/*
+	 * If viewport has non 0 offset and there are more taps than covered by init then
+	 * we should decrease the offset and increase init so we are never sampling
+	 * outside of viewport.
+	 */
+	int_part = dc_fixpt_floor(*init);
+	if (int_part < taps) {
+		int_part = taps - int_part;
+		if (int_part > *vp_offset)
+			int_part = *vp_offset;
+		*vp_offset -= int_part;
+		*init = dc_fixpt_add_int(*init, int_part);
 	}
+	/*
+	 * If taps are sampling outside of viewport at end of recout and there are more pixels
+	 * available in the surface we should increase the viewport size, regardless set vp to
+	 * only what is used.
+	 */
+	temp = dc_fixpt_add(*init, dc_fixpt_mul_int(ratio, recout_size - 1));
+	*vp_size = dc_fixpt_floor(temp);
+	if (*vp_size + *vp_offset > src_size)
+		*vp_size = src_size - *vp_offset;
+
+	/* We did all the math assuming we are scanning same direction as display does,
+	 * however mirror/rotation changes how vp scans vs how it is offset. If scan direction
+	 * is flipped we simply need to calculate offset from the other side of plane.
+	 * Note that outside of viewport all scaling hardware works in recout space.
+	 */
+	if (flip_scan_dir)
+		*vp_offset = src_size - *vp_offset - *vp_size;
 }
 
-static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
+static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	const struct dc_stream_state *stream = pipe_ctx->stream;
-	struct pipe_ctx *odm_pipe = pipe_ctx;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
-	struct rect src = pipe_ctx->plane_state->src_rect;
-	int recout_skip_h, recout_skip_v, surf_size_h, surf_size_v;
+	struct rect src = plane_state->src_rect;
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
-			|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
+				|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
+	int split_count, split_idx, ro_lb, ro_tb, recout_full_x, recout_full_y;
 	bool orthogonal_rotation, flip_vert_scan_dir, flip_horz_scan_dir;
-	int odm_idx = 0;
 
+	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
 	/*
-	 * Need to calculate the scan direction for viewport to make adjustments
+	 * recout full is what the recout would have been if we didnt clip
+	 * the source plane at all. We only care about left(ro_lb) and top(ro_tb)
+	 * offsets of recout within recout full because those are the directions
+	 * we scan from and therefore the only ones that affect inits.
+	 */
+	recout_full_x = stream->dst.x + (plane_state->dst_rect.x - stream->src.x)
+			* stream->dst.width / stream->src.width;
+	recout_full_y = stream->dst.y + (plane_state->dst_rect.y - stream->src.y)
+			* stream->dst.height / stream->src.height;
+	if (pipe_ctx->prev_odm_pipe && split_idx)
+		ro_lb = data->h_active * split_idx - recout_full_x;
+	else
+		ro_lb = data->recout.x - recout_full_x;
+	ro_tb = data->recout.y - recout_full_y;
+	ASSERT(ro_lb >= 0 && ro_tb >= 0);
+
+	/*
+	 * Work in recout rotation since that requires less transformations
 	 */
 	get_vp_scan_direction(
 			plane_state->rotation,
@@ -985,145 +886,62 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 			&flip_vert_scan_dir,
 			&flip_horz_scan_dir);
 
-	/* Calculate src rect rotation adjusted to recout space */
-	surf_size_h = src.x + src.width;
-	surf_size_v = src.y + src.height;
-	if (flip_horz_scan_dir)
-		src.x = 0;
-	if (flip_vert_scan_dir)
-		src.y = 0;
 	if (orthogonal_rotation) {
-		swap(src.x, src.y);
 		swap(src.width, src.height);
+		swap(flip_vert_scan_dir, flip_horz_scan_dir);
 	}
 
-	/*modified recout_skip_h calculation due to odm having no recout offset*/
-	while (odm_pipe->prev_odm_pipe) {
-		odm_idx++;
-		odm_pipe = odm_pipe->prev_odm_pipe;
-	}
-	/*odm_pipe is the leftmost pipe in the ODM group*/
-	recout_skip_h = odm_idx * data->recout.width;
-
-	/* Recout matching initial vp offset = recout_offset - (stream dst offset +
-	 *			((surf dst offset - stream src offset) * 1/ stream scaling ratio)
-	 *			- (surf surf_src offset * 1/ full scl ratio))
-	 */
-	recout_skip_h += odm_pipe->plane_res.scl_data.recout.x
-				- (stream->dst.x + (plane_state->dst_rect.x - stream->src.x)
-					* stream->dst.width / stream->src.width -
-					src.x * plane_state->dst_rect.width / src.width
-					* stream->dst.width / stream->src.width);
-
-
-	recout_skip_v = data->recout.y - (stream->dst.y + (plane_state->dst_rect.y - stream->src.y)
-					* stream->dst.height / stream->src.height -
-					src.y * plane_state->dst_rect.height / src.height
-					* stream->dst.height / stream->src.height);
-	if (orthogonal_rotation)
-		swap(recout_skip_h, recout_skip_v);
-	/*
-	 * Init calculated according to formula:
-	 * 	init = (scaling_ratio + number_of_taps + 1) / 2
-	 * 	init_bot = init + scaling_ratio
-	 * 	init_c = init + truncated_vp_c_offset(from calculate viewport)
-	 */
-	data->inits.h = dc_fixpt_truncate(dc_fixpt_div_int(
-			dc_fixpt_add_int(data->ratios.horz, data->taps.h_taps + 1), 2), 19);
-
-	data->inits.h_c = dc_fixpt_truncate(dc_fixpt_add(data->inits.h_c, dc_fixpt_div_int(
-			dc_fixpt_add_int(data->ratios.horz_c, data->taps.h_taps_c + 1), 2)), 19);
-
-	data->inits.v = dc_fixpt_truncate(dc_fixpt_div_int(
-			dc_fixpt_add_int(data->ratios.vert, data->taps.v_taps + 1), 2), 19);
-
-	data->inits.v_c = dc_fixpt_truncate(dc_fixpt_add(data->inits.v_c, dc_fixpt_div_int(
-			dc_fixpt_add_int(data->ratios.vert_c, data->taps.v_taps_c + 1), 2)), 19);
-
-	/*
-	 * Taps, inits and scaling ratios are in recout space need to rotate
-	 * to viewport rotation before adjustment
-	 */
-	adjust_vp_and_init_for_seamless_clip(
+	calculate_init_and_vp(
 			flip_horz_scan_dir,
-			recout_skip_h,
-			surf_size_h,
-			orthogonal_rotation ? data->taps.v_taps : data->taps.h_taps,
-			orthogonal_rotation ? data->ratios.vert : data->ratios.horz,
-			orthogonal_rotation ? &data->inits.v : &data->inits.h,
+			ro_lb,
+			data->recout.width,
+			src.width,
+			data->taps.h_taps,
+			data->ratios.horz,
+			&data->inits.h,
 			&data->viewport.x,
 			&data->viewport.width);
-	adjust_vp_and_init_for_seamless_clip(
+	calculate_init_and_vp(
 			flip_horz_scan_dir,
-			recout_skip_h,
-			surf_size_h / vpc_div,
-			orthogonal_rotation ? data->taps.v_taps_c : data->taps.h_taps_c,
-			orthogonal_rotation ? data->ratios.vert_c : data->ratios.horz_c,
-			orthogonal_rotation ? &data->inits.v_c : &data->inits.h_c,
+			ro_lb,
+			data->recout.width,
+			src.width / vpc_div,
+			data->taps.h_taps_c,
+			data->ratios.horz_c,
+			&data->inits.h_c,
 			&data->viewport_c.x,
 			&data->viewport_c.width);
-	adjust_vp_and_init_for_seamless_clip(
+	calculate_init_and_vp(
 			flip_vert_scan_dir,
-			recout_skip_v,
-			surf_size_v,
-			orthogonal_rotation ? data->taps.h_taps : data->taps.v_taps,
-			orthogonal_rotation ? data->ratios.horz : data->ratios.vert,
-			orthogonal_rotation ? &data->inits.h : &data->inits.v,
+			ro_tb,
+			data->recout.height,
+			src.height,
+			data->taps.v_taps,
+			data->ratios.vert,
+			&data->inits.v,
 			&data->viewport.y,
 			&data->viewport.height);
-	adjust_vp_and_init_for_seamless_clip(
+	calculate_init_and_vp(
 			flip_vert_scan_dir,
-			recout_skip_v,
-			surf_size_v / vpc_div,
-			orthogonal_rotation ? data->taps.h_taps_c : data->taps.v_taps_c,
-			orthogonal_rotation ? data->ratios.horz_c : data->ratios.vert_c,
-			orthogonal_rotation ? &data->inits.h_c : &data->inits.v_c,
+			ro_tb,
+			data->recout.height,
+			src.height / vpc_div,
+			data->taps.v_taps_c,
+			data->ratios.vert_c,
+			&data->inits.v_c,
 			&data->viewport_c.y,
 			&data->viewport_c.height);
-
-	/* Interlaced inits based on final vert inits */
-	data->inits.v_bot = dc_fixpt_add(data->inits.v, data->ratios.vert);
-	data->inits.v_c_bot = dc_fixpt_add(data->inits.v_c, data->ratios.vert_c);
-
-}
-
-/*
- * When handling 270 rotation in mixed SLS mode, we have
- * stream->timing.h_border_left that is non zero.  If we are doing
- * pipe-splitting, this h_border_left value gets added to recout.x and when it
- * calls calculate_inits_and_adj_vp() and
- * adjust_vp_and_init_for_seamless_clip(), it can cause viewport.height for a
- * pipe to be incorrect.
- *
- * To fix this, instead of using stream->timing.h_border_left, we can use
- * stream->dst.x to represent the border instead.  So we will set h_border_left
- * to 0 and shift the appropriate amount in stream->dst.x.  We will then
- * perform all calculations in resource_build_scaling_params() based on this
- * and then restore the h_border_left and stream->dst.x to their original
- * values.
- *
- * shift_border_left_to_dst() will shift the amount of h_border_left to
- * stream->dst.x and set h_border_left to 0.  restore_border_left_from_dst()
- * will restore h_border_left and stream->dst.x back to their original values
- * We also need to make sure pipe_ctx->plane_res.scl_data.h_active uses the
- * original h_border_left value in its calculation.
- */
-int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
-{
-	int store_h_border_left = pipe_ctx->stream->timing.h_border_left;
-
-	if (store_h_border_left) {
-		pipe_ctx->stream->timing.h_border_left = 0;
-		pipe_ctx->stream->dst.x += store_h_border_left;
+	if (orthogonal_rotation) {
+		swap(data->viewport.x, data->viewport.y);
+		swap(data->viewport.width, data->viewport.height);
+		swap(data->viewport_c.x, data->viewport_c.y);
+		swap(data->viewport_c.width, data->viewport_c.height);
 	}
-	return store_h_border_left;
-}
-
-void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
-                                  int store_h_border_left)
-{
-	pipe_ctx->stream->dst.x -= store_h_border_left;
-	pipe_ctx->stream->timing.h_border_left = store_h_border_left;
+	data->viewport.x += src.x;
+	data->viewport.y += src.y;
+	ASSERT(src.x % vpc_div == 0 && src.y % vpc_div == 0);
+	data->viewport_c.x += src.x / vpc_div;
+	data->viewport_c.y += src.y / vpc_div;
 }
 
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
@@ -1131,48 +949,52 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	bool res = false;
-	int store_h_border_left = shift_border_left_to_dst(pipe_ctx);
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
-	/* Important: scaling ratio calculation requires pixel format,
-	 * lb depth calculation requires recout and taps require scaling ratios.
-	 * Inits require viewport, taps, ratios and recout of split pipe
-	 */
-	pipe_ctx->plane_res.scl_data.format = convert_pixel_format_to_dalsurface(
-			pipe_ctx->plane_state->format);
-
-	calculate_scaling_ratios(pipe_ctx);
-
-	calculate_viewport(pipe_ctx);
 
-	if (pipe_ctx->plane_res.scl_data.viewport.height < 12 ||
-		pipe_ctx->plane_res.scl_data.viewport.width < 12) {
-		if (store_h_border_left) {
-			restore_border_left_from_dst(pipe_ctx,
-				store_h_border_left);
-		}
+	/* Invalid input */
+	if (!plane_state ||
+			!plane_state->dst_rect.width ||
+			!plane_state->dst_rect.height ||
+			!plane_state->src_rect.width ||
+			!plane_state->src_rect.height) {
+		ASSERT(0);
 		return false;
 	}
 
-	calculate_recout(pipe_ctx);
+	pipe_ctx->plane_res.scl_data.format = convert_pixel_format_to_dalsurface(
+			pipe_ctx->plane_state->format);
 
-	/**
-	 * Setting line buffer pixel depth to 24bpp yields banding
-	 * on certain displays, such as the Sharp 4k
+	/* Timing borders are part of vactive that we are also supposed to skip in addition
+	 * to any stream dst offset. Since dm logic assumes dst is in addressable
+	 * space we need to add the the left and top borders to dst offsets temporarily.
+	 * TODO: fix in DM, stream dst is supposed to be in vactive
 	 */
-	pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
-	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
-
-	pipe_ctx->plane_res.scl_data.recout.x += timing->h_border_left;
-	pipe_ctx->plane_res.scl_data.recout.y += timing->v_border_top;
+	pipe_ctx->stream->dst.x += timing->h_border_left;
+	pipe_ctx->stream->dst.y += timing->v_border_top;
 
+	/* Calculate H and V active size */
 	pipe_ctx->plane_res.scl_data.h_active = timing->h_addressable +
-		store_h_border_left + timing->h_border_right;
+			timing->h_border_left + timing->h_border_right;
 	pipe_ctx->plane_res.scl_data.v_active = timing->v_addressable +
 		timing->v_border_top + timing->v_border_bottom;
 	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe)
 		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx) + 1;
 
-	/* Taps calculations */
+	/* depends on h_active */
+	calculate_recout(pipe_ctx);
+	/* depends on pixel format */
+	calculate_scaling_ratios(pipe_ctx);
+	/* depends on scaling ratios and recout, does not calculate offset yet */
+	calculate_viewport_size(pipe_ctx);
+
+	/*
+	 * LB calculations depend on vp size, h/v_active and scaling ratios
+	 * Setting line buffer pixel depth to 24bpp yields banding
+	 * on certain displays, such as the Sharp 4k
+	 */
+	pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
+	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
+
 	if (pipe_ctx->plane_res.xfm != NULL)
 		res = pipe_ctx->plane_res.xfm->funcs->transform_get_optimal_number_of_taps(
 				pipe_ctx->plane_res.xfm, &pipe_ctx->plane_res.scl_data, &plane_state->scaling_quality);
@@ -1199,9 +1021,31 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 					&plane_state->scaling_quality);
 	}
 
+	/*
+	 * Depends on recout, scaling ratios, h_active and taps
+	 * May need to re-check lb size after this in some obscure scenario
+	 */
 	if (res)
-		/* May need to re-check lb size after this in some obscure scenario */
-		calculate_inits_and_adj_vp(pipe_ctx);
+		calculate_inits_and_viewports(pipe_ctx);
+
+	/*
+	 * Handle side by side and top bottom 3d recout offsets after vp calculation
+	 * since 3d is special and needs to calculate vp as if there is no recout offset
+	 * This may break with rotation, good thing we aren't mixing hw rotation and 3d
+	 */
+	if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->plane_state == plane_state) {
+		ASSERT(plane_state->rotation == ROTATION_ANGLE_0 ||
+			(pipe_ctx->stream->view_format != VIEW_3D_FORMAT_TOP_AND_BOTTOM &&
+				pipe_ctx->stream->view_format != VIEW_3D_FORMAT_SIDE_BY_SIDE));
+		if (pipe_ctx->stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM)
+			pipe_ctx->plane_res.scl_data.recout.y += pipe_ctx->plane_res.scl_data.recout.height;
+		else if (pipe_ctx->stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
+			pipe_ctx->plane_res.scl_data.recout.x += pipe_ctx->plane_res.scl_data.recout.width;
+	}
+
+	if (pipe_ctx->plane_res.scl_data.viewport.height < MIN_VIEWPORT_SIZE ||
+			pipe_ctx->plane_res.scl_data.viewport.width < MIN_VIEWPORT_SIZE)
+		res = false;
 
 	DC_LOG_SCALER("%s pipe %d:\nViewport: height:%d width:%d x:%d y:%d  Recout: height:%d width:%d x:%d y:%d  HACTIVE:%d VACTIVE:%d\n"
 			"src_rect: height:%d width:%d x:%d y:%d  dst_rect: height:%d width:%d x:%d y:%d  clip_rect: height:%d width:%d x:%d y:%d\n",
@@ -1230,8 +1074,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 			plane_state->clip_rect.x,
 			plane_state->clip_rect.y);
 
-	if (store_h_border_left)
-		restore_border_left_from_dst(pipe_ctx, store_h_border_left);
+	pipe_ctx->stream->dst.x -= timing->h_border_left;
+	pipe_ctx->stream->dst.y -= timing->v_border_top;
 
 	return res;
 }
@@ -1975,10 +1819,13 @@ static int get_norm_pix_clk(const struct dc_crtc_timing *timing)
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
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1df7c49ac8d7..d3a4a55f3f1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -48,6 +48,7 @@
 #define MAX_PLANES 6
 #define MAX_STREAMS 6
 #define MAX_SINKS_PER_LINK 4
+#define MIN_VIEWPORT_SIZE 12
 
 /*******************************************************************************
  * Display Core Interfaces
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c47a19719de2..c8c2ba7e7b05 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -268,11 +268,6 @@ struct dc_edid_caps {
 	struct dc_panel_patch panel_patch;
 };
 
-struct view {
-	uint32_t width;
-	uint32_t height;
-};
-
 struct dc_mode_flags {
 	/* note: part of refresh rate flag*/
 	uint32_t INTERLACE :1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 8bb5912d837d..bd842055ea95 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -617,8 +617,10 @@ static void dpp1_dscl_set_manual_ratio_init(
 		SCL_V_INIT_INT, init_int);
 
 	if (REG(SCL_VERT_FILTER_INIT_BOT)) {
-		init_frac = dc_fixpt_u0d19(data->inits.v_bot) << 5;
-		init_int = dc_fixpt_floor(data->inits.v_bot);
+		struct fixed31_32 bot = dc_fixpt_add(data->inits.v, data->ratios.vert);
+
+		init_frac = dc_fixpt_u0d19(bot) << 5;
+		init_int = dc_fixpt_floor(bot);
 		REG_SET_2(SCL_VERT_FILTER_INIT_BOT, 0,
 			SCL_V_INIT_FRAC_BOT, init_frac,
 			SCL_V_INIT_INT_BOT, init_int);
@@ -631,8 +633,10 @@ static void dpp1_dscl_set_manual_ratio_init(
 		SCL_V_INIT_INT_C, init_int);
 
 	if (REG(SCL_VERT_FILTER_INIT_BOT_C)) {
-		init_frac = dc_fixpt_u0d19(data->inits.v_c_bot) << 5;
-		init_int = dc_fixpt_floor(data->inits.v_c_bot);
+		struct fixed31_32 bot = dc_fixpt_add(data->inits.v_c, data->ratios.vert_c);
+
+		init_frac = dc_fixpt_u0d19(bot) << 5;
+		init_int = dc_fixpt_floor(bot);
 		REG_SET_2(SCL_VERT_FILTER_INIT_BOT_C, 0,
 			SCL_V_INIT_FRAC_BOT_C, init_frac,
 			SCL_V_INIT_INT_BOT_C, init_int);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 53ac82693532..b4bff3b3d842 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2281,12 +2281,14 @@ int dcn20_populate_dml_pipes_from_context(
 
 			pipes[pipe_cnt].pipe.src.source_scan = pln->rotation == ROTATION_ANGLE_90
 					|| pln->rotation == ROTATION_ANGLE_270 ? dm_vert : dm_horz;
-			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport_unadjusted.y;
-			pipes[pipe_cnt].pipe.src.viewport_y_c = scl->viewport_c_unadjusted.y;
-			pipes[pipe_cnt].pipe.src.viewport_width = scl->viewport_unadjusted.width;
-			pipes[pipe_cnt].pipe.src.viewport_width_c = scl->viewport_c_unadjusted.width;
-			pipes[pipe_cnt].pipe.src.viewport_height = scl->viewport_unadjusted.height;
-			pipes[pipe_cnt].pipe.src.viewport_height_c = scl->viewport_c_unadjusted.height;
+			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport.y;
+			pipes[pipe_cnt].pipe.src.viewport_y_c = scl->viewport_c.y;
+			pipes[pipe_cnt].pipe.src.viewport_width = scl->viewport.width;
+			pipes[pipe_cnt].pipe.src.viewport_width_c = scl->viewport_c.width;
+			pipes[pipe_cnt].pipe.src.viewport_height = scl->viewport.height;
+			pipes[pipe_cnt].pipe.src.viewport_height_c = scl->viewport_c.height;
+			pipes[pipe_cnt].pipe.src.viewport_width_max = pln->src_rect.width;
+			pipes[pipe_cnt].pipe.src.viewport_height_max = pln->src_rect.height;
 			pipes[pipe_cnt].pipe.src.surface_width_y = pln->plane_size.surface_size.width;
 			pipes[pipe_cnt].pipe.src.surface_height_y = pln->plane_size.surface_size.height;
 			pipes[pipe_cnt].pipe.src.surface_width_c = pln->plane_size.chroma_size.width;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index e5b1002d7f3f..ed4e7f3728ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -283,10 +283,10 @@ static void CalculateDynamicMetadataParameters(
 		double DISPCLK,
 		double DCFClkDeepSleep,
 		double PixelClock,
-		long HTotal,
-		long VBlank,
-		long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired,
+		unsigned int HTotal,
+		unsigned int VBlank,
+		unsigned int DynamicMetadataTransmittedBytes,
+		int DynamicMetadataLinesBeforeActiveRequired,
 		int InterlaceEnable,
 		bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup,
@@ -3373,8 +3373,8 @@ static double CalculateWriteBackDelay(
 
 
 static void CalculateDynamicMetadataParameters(int MaxInterDCNTileRepeaters, double DPPCLK, double DISPCLK,
-		double DCFClkDeepSleep, double PixelClock, long HTotal, long VBlank, long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
+		double DCFClkDeepSleep, double PixelClock, unsigned int HTotal, unsigned int VBlank, unsigned int DynamicMetadataTransmittedBytes,
+		int DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup, double *Tdmbf, double *Tdmec, double *Tdmsks)
 {
 	double TotalRepeaterDelayTime = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 6ab74640c0da..a86b821d61c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -255,6 +255,8 @@ struct _vcs_dpi_display_pipe_source_params_st {
 	unsigned int viewport_y_c;
 	unsigned int viewport_width_c;
 	unsigned int viewport_height_c;
+	unsigned int viewport_width_max;
+	unsigned int viewport_height_max;
 	unsigned int data_pitch;
 	unsigned int data_pitch_c;
 	unsigned int meta_pitch;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index b32093136089..bfb0be4e60a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -628,6 +628,19 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 				}
 			}
 		}
+		if (src->viewport_width_max) {
+			int hdiv_c = src->source_format >= dm_420_8 && src->source_format <= dm_422_10 ? 2 : 1;
+			int vdiv_c = src->source_format >= dm_420_8 && src->source_format <= dm_420_12 ? 2 : 1;
+
+			if (mode_lib->vba.ViewportWidth[mode_lib->vba.NumberOfActivePlanes] > src->viewport_width_max)
+				mode_lib->vba.ViewportWidth[mode_lib->vba.NumberOfActivePlanes] = src->viewport_width_max;
+			if (mode_lib->vba.ViewportHeight[mode_lib->vba.NumberOfActivePlanes] > src->viewport_height_max)
+				mode_lib->vba.ViewportHeight[mode_lib->vba.NumberOfActivePlanes] = src->viewport_height_max;
+			if (mode_lib->vba.ViewportWidthChroma[mode_lib->vba.NumberOfActivePlanes] > src->viewport_width_max / hdiv_c)
+				mode_lib->vba.ViewportWidthChroma[mode_lib->vba.NumberOfActivePlanes] = src->viewport_width_max / hdiv_c;
+			if (mode_lib->vba.ViewportHeightChroma[mode_lib->vba.NumberOfActivePlanes] > src->viewport_height_max / vdiv_c)
+				mode_lib->vba.ViewportHeightChroma[mode_lib->vba.NumberOfActivePlanes] = src->viewport_height_max / vdiv_c;
+		}
 
 		if (pipes[k].pipe.src.immediate_flip) {
 			mode_lib->vba.ImmediateFlipSupport = true;
@@ -825,11 +838,30 @@ static unsigned int CursorBppEnumToBits(enum cursor_bpp ebpp)
 	}
 }
 
+static unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx)
+{
+	int pipe_idx = -1;
+	int i;
+
+	ASSERT(plane_idx < DC__NUM_DPP__MAX);
+
+	for (i = 0; i < DC__NUM_DPP__MAX ; i++) {
+		if (plane_idx == mode_lib->vba.pipe_plane[i]) {
+			pipe_idx = i;
+			break;
+		}
+	}
+	ASSERT(pipe_idx >= 0);
+
+	return pipe_idx;
+}
+
 void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 {
 	soc_bounding_box_st *soc = &mode_lib->vba.soc;
 	unsigned int k;
 	unsigned int total_pipes = 0;
+	unsigned int pipe_idx = 0;
 
 	mode_lib->vba.VoltageLevel = mode_lib->vba.cache_pipes[0].clks_cfg.voltage;
 	mode_lib->vba.ReturnBW = mode_lib->vba.ReturnBWPerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb];
@@ -849,8 +881,14 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 		mode_lib->vba.DISPCLK = soc->clock_limits[mode_lib->vba.VoltageLevel].dispclk_mhz;
 
 	// Total Available Pipes Support Check
-	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k)
+	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
+		pipe_idx = get_pipe_idx(mode_lib, k);
+		if (pipe_idx == -1) {
+			ASSERT(0);
+			continue; // skip inactive planes
+		}
 		total_pipes += mode_lib->vba.DPPPerPlane[k];
+	}
 	ASSERT(total_pipes <= DC__NUM_DPP__MAX);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
index 2947d1b15512..2a0db2b03047 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
@@ -162,9 +162,7 @@ struct scl_inits {
 	struct fixed31_32 h;
 	struct fixed31_32 h_c;
 	struct fixed31_32 v;
-	struct fixed31_32 v_bot;
 	struct fixed31_32 v_c;
-	struct fixed31_32 v_c_bot;
 };
 
 struct scaler_data {
@@ -173,8 +171,6 @@ struct scaler_data {
 	struct scaling_taps taps;
 	struct rect viewport;
 	struct rect viewport_c;
-	struct rect viewport_unadjusted;
-	struct rect viewport_c_unadjusted;
 	struct rect recout;
 	struct scaling_ratios ratios;
 	struct scl_inits inits;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index a7773b6453d5..0af9ee3a520a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -900,19 +900,22 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static int navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
-	uint32_t clk_index = 0;
+	int clk_index = 0;
 
 	clk_index = smu_cmn_to_asic_specific_index(smu,
 						   CMN2ASIC_MAPPING_CLK,
 						   clk_type);
+	if (clk_index < 0)
+		return clk_index;
+
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
-	return dpm_desc->SnapToDiscrete == 0 ? true : false;
+	return dpm_desc->SnapToDiscrete == 0 ? 1 : 0;
 }
 
 static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
@@ -964,7 +967,11 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1127,7 +1134,11 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (ret) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index f6d8bee10fa0..e6e64cff3335 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -936,6 +936,10 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 
 	if (mode != DRM_MODE_DPMS_ON)
 		mode = DRM_MODE_DPMS_OFF;
+
+	if (connector->dpms == mode)
+		goto out;
+
 	connector->dpms = mode;
 
 	crtc = connector->state->crtc;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index c4ed4f1b369c..db8ede9d56d1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -990,6 +990,10 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  * 	callback. For atomic drivers the remapping to the "ACTIVE" property is
  * 	implemented in the DRM core.
  *
+ * 	On atomic drivers any DPMS setproperty ioctl where the value does not
+ * 	change is completely skipped, otherwise a full atomic commit will occur.
+ * 	On legacy drivers the exact behavior is driver specific.
+ *
  * 	Note that this property cannot be set through the MODE_ATOMIC ioctl,
  * 	userspace must use "ACTIVE" on the CRTC instead.
  *
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0eb2f30c1e3e..702ab6148425 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -178,13 +178,13 @@ static int
 drm_dp_mst_rad_to_str(const u8 rad[8], u8 lct, char *out, size_t len)
 {
 	int i;
-	u8 unpacked_rad[16];
+	u8 unpacked_rad[16] = {};
 
-	for (i = 0; i < lct; i++) {
+	for (i = 1; i < lct; i++) {
 		if (i % 2)
-			unpacked_rad[i] = rad[i / 2] >> 4;
+			unpacked_rad[i] = rad[(i - 1) / 2] >> 4;
 		else
-			unpacked_rad[i] = rad[i / 2] & BIT_MASK(4);
+			unpacked_rad[i] = rad[(i - 1) / 2] & 0xF;
 	}
 
 	/* TODO: Eventually add something to printk so we can format the rad
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
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 17d45f06cedf..3fa22af13f74 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -920,12 +920,12 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 				     const struct mipi_dsi_msg *msg)
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
-	u32 recv_cnt, i;
+	ssize_t recv_cnt;
 	u8 read_data[16];
 	void *src_addr;
 	u8 irq_flag = CMD_DONE_INT_FLAG;
 	u32 dsi_mode;
-	int ret;
+	int ret, i;
 
 	dsi_mode = readl(dsi->regs + DSI_MODE_CTRL);
 	if (dsi_mode & MODE) {
@@ -974,7 +974,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (recv_cnt)
 		memcpy(msg->rx_buf, src_addr, recv_cnt);
 
-	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
+	DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));
 
 restore_dsi_mode:
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 97a1ff529a1d..f0e25ba86081 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -138,7 +138,7 @@ enum hdmi_aud_channel_swap_type {
 
 struct hdmi_audio_param {
 	enum hdmi_audio_coding_type aud_codec;
-	enum hdmi_audio_sample_size aud_sampe_size;
+	enum hdmi_audio_sample_size aud_sample_size;
 	enum hdmi_aud_input_type aud_input_type;
 	enum hdmi_aud_i2s_fmt aud_i2s_fmt;
 	enum hdmi_aud_mclk aud_mclk;
@@ -172,6 +172,7 @@ struct mtk_hdmi {
 	unsigned int sys_offset;
 	void __iomem *regs;
 	enum hdmi_colorspace csp;
+	struct platform_device *audio_pdev;
 	struct hdmi_audio_param aud_param;
 	bool audio_enable;
 	bool powered;
@@ -1091,7 +1092,7 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 
 	hdmi->csp = HDMI_COLORSPACE_RGB;
 	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-	aud_param->aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+	aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
 	aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 	aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
@@ -1617,14 +1618,14 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
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
@@ -1706,6 +1707,11 @@ static const struct hdmi_codec_ops mtk_hdmi_audio_codec_ops = {
 	.no_capture_mute = 1,
 };
 
+static void mtk_hdmi_unregister_audio_driver(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int mtk_hdmi_register_audio_driver(struct device *dev)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
@@ -1715,13 +1721,20 @@ static int mtk_hdmi_register_audio_driver(struct device *dev)
 		.i2s = 1,
 		.data = hdmi,
 	};
-	struct platform_device *pdev;
+	int ret;
 
-	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
-					     PLATFORM_DEVID_AUTO, &codec_data,
-					     sizeof(codec_data));
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	hdmi->audio_pdev = platform_device_register_data(dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_AUTO,
+							 &codec_data,
+							 sizeof(codec_data));
+	if (IS_ERR(hdmi->audio_pdev))
+		return PTR_ERR(hdmi->audio_pdev);
+
+	ret = devm_add_action_or_reset(dev, mtk_hdmi_unregister_audio_driver,
+				       hdmi->audio_pdev);
+	if (ret)
+		return ret;
 
 	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
 	return 0;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 6b8ad830c034..aa8e4a732b7c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -751,7 +751,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 5e8006444704..6605cdf9304d 100644
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
index 0747614a78f0..310fefac46c2 100644
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
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 5f6eea81f3cc..ad081838c449 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -218,6 +218,8 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+
 	/* Try the reserved memory. Proceed if there's none. */
 	of_reserved_mem_device_init(&pdev->dev);
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index fd8c68d3ed8e..d86720fce48f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1014,6 +1014,7 @@
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
index 67953cdae31c..9c1afe9cdddf 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -870,6 +870,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
 	{ }
 };
 
diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index a45ac7fa417b..da896f5c7442 100644
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
index 39339b152b8b..e8bea7c79169 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2331,12 +2331,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 	struct resource *iter;
 
 	mutex_lock(&hyperv_mmio_lock);
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
 	mutex_unlock(&hyperv_mmio_lock);
 
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3645a19cdaf4..71cfc1c5bd12 100644
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
index 8e19e8cdcce5..3357e55fc559 100644
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
index fb93152845f4..b36b75fc5b08 100644
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
index cc58feacd082..28a57cb6efb9 100644
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
index 8955f62b497e..5c045c4da660 100644
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
@@ -1475,7 +1463,7 @@ omap_i2c_probe(struct platform_device *pdev)
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
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index dafad891998e..f0bd4ae19df6 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -669,17 +669,22 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 	i2c_dev->dev.class = i2c_dev_class;
 	i2c_dev->dev.parent = &adap->dev;
 	i2c_dev->dev.release = i2cdev_dev_release;
-	dev_set_name(&i2c_dev->dev, "i2c-%d", adap->nr);
+
+	res = dev_set_name(&i2c_dev->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_put_i2c_dev;
 
 	res = cdev_device_add(&i2c_dev->cdev, &i2c_dev->dev);
-	if (res) {
-		put_i2c_dev(i2c_dev, false);
-		return res;
-	}
+	if (res)
+		goto err_put_i2c_dev;
 
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
 		 adap->name, adap->nr);
 	return 0;
+
+err_put_i2c_dev:
+	put_i2c_dev(i2c_dev, false);
+	return res;
 }
 
 static int i2cdev_detach_adapter(struct device *dev, void *dummy)
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b12e80464706..760ee0685034 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -711,7 +711,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -771,14 +771,18 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
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
index 521c3d050be2..19540a13cb84 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2686,11 +2686,11 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
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
@@ -2700,7 +2700,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 	recv_wr.sg_list = &sg_list;
 	recv_wr.num_sge = 1;
 
-	do {
+	while (true) {
 		/* Allocate and map receive buffer */
 		if (mad) {
 			mad_priv = mad;
@@ -2708,10 +2708,8 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
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
@@ -2720,37 +2718,41 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
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
index 4ed78d25b6e9..d5bb8017a468 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1163,8 +1163,6 @@ static void __modify_flags_from_init_state(struct bnxt_qplib_qp *qp)
 			qp->path_mtu =
 				CMDQ_MODIFY_QP_PATH_MTU_MTU_2048;
 		}
-		qp->modify_flags &=
-			~CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID;
 		/* Bono FW require the max_dest_rd_atomic to be >= 1 */
 		if (qp->max_dest_rd_atomic < 1)
 			qp->max_dest_rd_atomic = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 69aa1a52c7f8..db98fac4b562 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -218,9 +218,10 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn);
 void bnxt_qplib_mark_qp_error(void *qp_handle);
+
 static inline u32 map_qp_id_to_tbl_indx(u32 qid, struct bnxt_qplib_rcfw *rcfw)
 {
 	/* Last index of the qp_tbl is for QP1 ie. qp_tbl_size - 1*/
-	return (qid == 1) ? rcfw->qp_tbl_size - 1 : qid % rcfw->qp_tbl_size - 2;
+	return (qid == 1) ? rcfw->qp_tbl_size - 1 : (qid % (rcfw->qp_tbl_size - 2));
 }
 #endif /* __BNXT_QPLIB_RCFW_H__ */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 61ec96b3a89d..7cb98d09fb9b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1384,6 +1384,11 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+/* This is the bottom bt pages number of a 100G MR on 4K OS, assuming
+ * the bt page size is not expanded by cal_best_bt_pg_sz()
+ */
+#define RESCHED_LOOP_CNT_THRESHOLD_ON_4K 12800
+
 /* construct the base address table and link them by address hop config */
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
@@ -1392,6 +1397,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
+	int loop;
 	int unit;
 	int ret;
 	int i;
@@ -1409,7 +1415,10 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			continue;
 
 		end = r->offset + r->count;
-		for (ofs = r->offset; ofs < end; ofs += unit) {
+		for (ofs = r->offset, loop = 1; ofs < end; ofs += unit, loop++) {
+			if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+				cond_resched();
+
 			ret = hem_list_alloc_mid_bt(hr_dev, r, unit, ofs,
 						    hem_list->mid_bt[i],
 						    &hem_list->btm_bt);
@@ -1462,19 +1471,22 @@ void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list)
 
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
-				 int offset, int *mtt_cnt, u64 *phy_addr)
+				 int offset, int *mtt_cnt)
 {
 	struct list_head *head = &hem_list->btm_bt;
 	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
-	u64 phy_base = 0;
+	int loop = 1;
 	int nr = 0;
 
 	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
+		if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+			cond_resched();
+		loop++;
+
 		if (hem_list_page_is_in_range(hem, offset)) {
 			nr = offset - hem->start;
 			cpu_base = hem->addr + nr * BA_BYTE_LEN;
-			phy_base = hem->dma_addr + nr * BA_BYTE_LEN;
 			nr = hem->end + 1 - offset;
 			break;
 		}
@@ -1483,8 +1495,5 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 	if (mtt_cnt)
 		*mtt_cnt = nr;
 
-	if (phy_addr)
-		*phy_addr = phy_base;
-
 	return cpu_base;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 5b2162a2b8ce..ecf5159aba9f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -131,7 +131,7 @@ void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_list *hem_list);
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
-				 int offset, int *mtt_cnt, u64 *phy_addr);
+				 int offset, int *mtt_cnt);
 
 static inline void hns_roce_hem_first(struct hns_roce_hem *hem,
 				      struct hns_roce_hem_iter *iter)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index a0f243ffa5b5..f520e43e4e14 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -199,7 +199,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 				  IB_DEVICE_RC_RNR_NAK_GEN;
 	props->max_send_sge = hr_dev->caps.max_sq_sg;
 	props->max_recv_sge = hr_dev->caps.max_rq_sg;
-	props->max_sge_rd = 1;
+	props->max_sge_rd = hr_dev->caps.max_sq_sg;
 	props->max_cq = hr_dev->caps.num_cqs;
 	props->max_cqe = hr_dev->caps.max_cqes;
 	props->max_mr = hr_dev->caps.num_mtpts;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b06230125868..66098d25cb49 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -649,7 +649,7 @@ static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	while (offset < end && npage < max_count) {
 		count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
-						  offset, &count, NULL);
+						  offset, &count);
 		if (!mtts)
 			return -ENOBUFS;
 
@@ -923,7 +923,7 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtt_count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  start_index + total,
-						  &mtt_count, NULL);
+						  &mtt_count);
 		if (!mtts || !mtt_count)
 			goto done;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 74644b6ea0ff..e6d3ac4e10dc 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -481,7 +481,7 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
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
diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index 256acf73d5ea..4d7c4eac5e20 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1460,7 +1460,7 @@ static int et8ek8_probe(struct i2c_client *client)
 	return ret;
 }
 
-static int __exit et8ek8_remove(struct i2c_client *client)
+static int et8ek8_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
 	struct et8ek8_sensor *sensor = to_et8ek8_sensor(subdev);
@@ -1504,7 +1504,7 @@ static struct i2c_driver et8ek8_i2c_driver = {
 		.of_match_table	= et8ek8_of_table,
 	},
 	.probe_new	= et8ek8_probe,
-	.remove		= __exit_p(et8ek8_remove),
+	.remove		= et8ek8_remove,
 	.id_table	= et8ek8_id_table,
 };
 
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
index 37ad72d8cde2..8c67fdc2af7f 100644
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
index c468f9a02ef6..bd53d8b75dca 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2507,8 +2507,10 @@ static int atmci_probe(struct platform_device *pdev)
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
index a6d89a3f1946..e59bfd316305 100644
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
index 429950241de3..586c13d855e0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -2113,8 +2113,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
 }
@@ -2125,7 +2126,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2143,6 +2143,8 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 		}
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return 0;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c7f93329ae75..4cc60135589d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5578,13 +5578,13 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
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
 
@@ -5603,7 +5603,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (chip->info->g2_irqs > 0) {
 		err = mv88e6xxx_g2_irq_setup(chip);
@@ -5643,6 +5643,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+out_phy:
+	mv88e6xxx_phy_destroy(chip);
 out:
 	if (pdata)
 		dev_put(pdata->netdev);
@@ -5660,7 +5662,6 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_ptp_free(chip);
 	}
 
-	mv88e6xxx_phy_destroy(chip);
 	mv88e6xxx_unregister_switch(chip);
 	mv88e6xxx_mdios_unregister(chip);
 
@@ -5674,6 +5675,8 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 6560acd76c94..632f16ffee40 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -510,7 +510,7 @@ void ice_init_arfs(struct ice_vsi *vsi)
 	struct hlist_head *arfs_fltr_list;
 	unsigned int i;
 
-	if (!vsi || vsi->type != ICE_VSI_PF)
+	if (!vsi || vsi->type != ICE_VSI_PF || ice_is_arfs_active(vsi))
 		return;
 
 	arfs_fltr_list = kzalloc(sizeof(*arfs_fltr_list) * ICE_MAX_ARFS_LIST,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 78309821ce29..f8e86f253563 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2056,7 +2056,7 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 		rvupf_write64(rvu, RVU_PF_VFPF_MBOX_INTX(1), intr);
 
 		rvu_queue_work(&rvu->afvf_wq_info, 64, vfs, intr);
-		vfs -= 64;
+		vfs = 64;
 	}
 
 	intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(0));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index aeb8bb3c549a..c3ff1fc577a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4604,11 +4604,9 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
index 77c6287c90d5..0e255ff95a50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
@@ -267,6 +267,11 @@ mlx5_chains_create_table(struct mlx5_fs_chains *chains,
 		ns = mlx5_get_flow_namespace(chains->dev, chains->ns);
 	}
 
+	if (!ns) {
+		mlx5_core_warn(chains->dev, "Failed to get flow namespace\n");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	ft_attr.autogroup.num_reserved_entries = 2;
 	ft_attr.autogroup.max_num_groups = chains->group_num;
 	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index e864c453c5e6..256b19f68cae 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -454,8 +454,10 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 
 	num_vlans = sriov->num_allowed_vlans;
 	sriov->allowed_vlans = kcalloc(num_vlans, sizeof(u16), GFP_KERNEL);
-	if (!sriov->allowed_vlans)
+	if (!sriov->allowed_vlans) {
+		qlcnic_sriov_free_vlans(adapter);
 		return -ENOMEM;
+	}
 
 	vlans = (u16 *)&cmd->rsp.arg[3];
 	for (i = 0; i < num_vlans; i++)
@@ -2173,8 +2175,10 @@ int qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
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
index b271e6da2924..3ab7b27b6bac 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1306,9 +1306,11 @@ static const struct usb_device_id products[] = {
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
index b3d363ebea26..ad425e09c75f 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -164,6 +164,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
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
@@ -1712,13 +1723,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
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
index 79d08e5d9a81..558caf78a56d 100644
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
index ffcfc3e02c35..a5aa96a31f4a 100644
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
index ad09946100b5..c5c1963c699d 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -288,7 +288,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (size != 0 && xlate_pos < 12)
 		return -EINVAL;
 
-	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
+	if (xlate_pos >= 0 && !IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
 		/*
 		 * In certain circumstances we can get a buffer that is
 		 * not aligned to its size. (Most of the time
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 5a7a02408166..04690897a067 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -839,10 +839,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	dma_set_unmap(tx, unmap);
 
 	ret = dma_submit_error(dmaengine_submit(tx));
-	if (ret) {
-		dmaengine_unmap_put(unmap);
+	if (ret)
 		goto err_free_resource;
-	}
 
 	dmaengine_unmap_put(unmap);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 019a6dbdcbc2..5f16fc9111a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -384,8 +384,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8e05239073ef..f49e98c2e31d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3536,8 +3536,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ae04bdce560a..a56baaafe79d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1867,6 +1867,18 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	/*
+	 * Controllers may support a CMB size larger than their BAR, for
+	 * example, due to being behind a bridge. Reduce the CMB to the
+	 * reported size of the BAR
+	 */
+	size = min(size, bar_size - offset);
+
+	if (!IS_ALIGNED(size, memremap_compat_align()) ||
+	    !IS_ALIGNED(pci_resource_start(pdev, bar),
+			memremap_compat_align()))
+		return;
+
 	/*
 	 * Tell the controller about the host side address mapping the CMB,
 	 * and enable CMB decoding for the NVMe 1.4+ scheme:
@@ -1877,17 +1889,10 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
+		hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
 		return;
 	}
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ea4d3170acae..93835c019b8e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2462,6 +2462,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
+	int ret;
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
@@ -2469,9 +2470,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
-	nvme_tcp_try_recv(queue);
+	ret = nvme_tcp_try_recv(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return queue->nr_cqe;
+	return ret < 0 ? ret : queue->nr_cqe;
 }
 
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 944e8a276663..503e1f59013c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -996,6 +996,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
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
@@ -1037,17 +1058,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
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
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 4c5e6349d78c..403ff93bc850 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -311,8 +311,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
-		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
-		 CDNS_PCIE_MSG_NO_DATA;
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index e0b59730bffb..3139ea9f02c8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -224,7 +224,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
 #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+#define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
 
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9c3d2982248d..be6af5585dd6 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -402,10 +402,10 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
 	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
-	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
-	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	lnkctl2 = (lnkctl2 & ~0xf) | gen;
 	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 67937facd90c..1b8366fa9f78 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -556,13 +556,15 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		return err;
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
-	if (!bus)
-		return -ENODEV;
+	if (!bus) {
+		err = -ENODEV;
+		goto err_free_irq_domains;
+	}
 
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
-		goto err_parse_dt;
+		goto err_free_irq_domains;
 	}
 
 	xilinx_cpm_pcie_init_port(port);
@@ -586,7 +588,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	xilinx_cpm_free_interrupts(port);
 err_setup_irq:
 	pci_ecam_free(port->cfg);
-err_parse_dt:
+err_free_irq_domains:
 	xilinx_cpm_free_irq_domains(port);
 	return err;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 75c6c72ec32a..d1e524078793 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -840,7 +840,9 @@ void pcie_enable_interrupt(struct controller *ctrl)
 {
 	u16 mask;
 
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	mask = PCI_EXP_SLTCTL_DLLSCE;
+	if (!pciehp_poll_mode)
+		mask |= PCI_EXP_SLTCTL_HPIE;
 	pcie_write_cmd(ctrl, mask, mask);
 }
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8ab8abd79e89..94b0b32340a8 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1014,16 +1014,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
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
@@ -1034,6 +1034,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_config_aspm_path(parent_link);
 	}
 
+ out:
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 3779b264dbec..e3d998173433 100644
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
index 02a75f3b5920..84edae9ba2e6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -918,10 +918,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
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
index 9ab1f427286a..fbfddcc39d5c 100644
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
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index ddd8ee6b604e..1fd3191d9f8d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -253,6 +253,8 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 		return ret;
 	}
 
+	of_node_put(of_args.np);
+
 	if ((of_args.args[0] != 0) ||
 	    (of_args.args[1] != 0) ||
 	    (of_args.args[2] != priv->npins)) {
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 195cfe557511..90de78e4175c 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -270,6 +270,9 @@ static int tegra_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	val = pmx_readl(pmx, g->mux_bank, g->mux_reg);
 	val &= ~(0x3 << g->mux_bit);
 	val |= i << g->mux_bit;
+	/* Set the SFIO/GPIO selection to SFIO when under pinmux control*/
+	if (pmx->soc->sfsel_in_mux)
+		val |= (1 << g->sfsel_bit);
 	pmx_writel(pmx, val, g->mux_bank, g->mux_reg);
 
 	return 0;
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 0b0602fc4360..9bc2652b15e7 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -100,6 +100,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
 		},
 	},
+	{
+		.ident = "Microsoft Surface Go 4",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 4"),
+		},
+	},
 	{ }
 };
 
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
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7082cffdd10e..a0cc907a76c1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1924,6 +1924,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			if (!r) {
+				ret = -EPROBE_DEFER;
+				goto out;
+			}
 			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
@@ -1941,6 +1945,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			goto out;
 		}
 		r = dummy_regulator_rdev;
+		if (!r) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
 		get_device(&r->dev);
 	}
 
@@ -2049,8 +2057,10 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
+			if (!rdev)
+				return ERR_PTR(-EPROBE_DEFER);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			get_device(&rdev->dev);
 			break;
 
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1a0d6eb9425b..653d20433828 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -309,16 +309,16 @@ static int adsp_pds_attach(struct device *dev, struct device **devs,
 	if (!pd_names)
 		return 0;
 
+	while (pd_names[num_pds])
+		num_pds++;
+
 	/* Handle single power domain */
-	if (dev->pm_domain) {
+	if (num_pds == 1 && dev->pm_domain) {
 		devs[0] = dev;
 		pm_runtime_enable(dev);
 		return 1;
 	}
 
-	while (pd_names[num_pds])
-		num_pds++;
-
 	for (i = 0; i < num_pds; i++) {
 		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
 		if (IS_ERR_OR_NULL(devs[i])) {
@@ -343,7 +343,7 @@ static void adsp_pds_detach(struct qcom_adsp *adsp, struct device **pds,
 	int i;
 
 	/* Handle single power domain */
-	if (dev->pm_domain && pd_count) {
+	if (pd_count == 1 && dev->pm_domain) {
 		pm_runtime_disable(dev);
 		return;
 	}
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 93e22785a0e0..0b84ced33b3c 100644
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
index 545936cb3980..8c08a0102e09 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2876,7 +2876,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 			dprintk(3, "S/G Segment phys_addr=%x %x, len=0x%x\n",
 				cpu_to_le32(upper_32_bits(dma_handle)),
 				cpu_to_le32(lower_32_bits(dma_handle)),
-				cpu_to_le32(sg_dma_len(sg_next(s))));
+				cpu_to_le32(sg_dma_len(s)));
 			remseg--;
 		}
 		dprintk(5, "qla1280_64bit_start_scsi: Scatter/gather "
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 6e3cbd822663..d2ae4ac1ee12 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -74,7 +74,6 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 {
 	struct pdr_handle *pdr = container_of(qmi, struct pdr_handle,
 					      locator_hdl);
-	struct pdr_service *pds;
 
 	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
@@ -86,12 +85,7 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 	mutex_unlock(&pdr->lock);
 
 	/* Service pending lookup requests */
-	mutex_lock(&pdr->list_lock);
-	list_for_each_entry(pds, &pdr->lookups, node) {
-		if (pds->need_locator_lookup)
-			schedule_work(&pdr->locator_work);
-	}
-	mutex_unlock(&pdr->list_lock);
+	schedule_work(&pdr->locator_work);
 
 	return 0;
 }
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 6e1d6a31ee4f..f1ae1530aa64 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -58,8 +58,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
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
index cbaac0a5137d..47ae1fbe805b 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -148,7 +148,7 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
 	 */
 	dma->tx_size = 0;
 
-	dmaengine_terminate_async(dma->rxchan);
+	dmaengine_terminate_async(dma->txchan);
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b6f0c297d67f..ea32b5c03e70 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5160,6 +5160,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
@@ -5340,6 +5348,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b16ad6db1ef8..110d98fed726 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1351,7 +1351,20 @@ static int lpuart32_config_rs485(struct uart_port *port,
 			struct lpuart_port, port);
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
-				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
+				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
+	u32 ctrl;
+
+	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	if (ctrl & UARTCTRL_TE) {
+		/* wait for the transmit engine to complete */
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+
+		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+			cpu_relax();
+	}
+
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	/* clear unsupported configurations */
@@ -1361,7 +1374,7 @@ static int lpuart32_config_rs485(struct uart_port *port,
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
-		modem |= UARTMODEM_TXRTSE;
+		modem |= UARTMODIR_TXRTSE;
 
 		/*
 		 * RTS needs to be logic HIGH either during transfer _or_ after
@@ -1383,15 +1396,19 @@ static int lpuart32_config_rs485(struct uart_port *port,
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem |= UARTMODEM_TXRTSPOL;
+			modem |= UARTMODIR_TXRTSPOL;
 		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
+			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
 	/* Store the new configuration */
 	sport->port.rs485 = *rs485;
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	if (ctrl & UARTCTRL_TE)
+		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+
 	return 0;
 }
 
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 66aa999efa6d..39d862f25a70 100644
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
index 29f5449ba0fd..2d11cd74d360 100644
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
index 47c493957772..67aeb4e6494b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -23,7 +23,7 @@ config VGA_CONSOLE
 	  Say Y.
 
 config MDA_CONSOLE
-	depends on !M68K && !PARISC && ISA
+	depends on VGA_CONSOLE && ISA
 	tristate "MDA text console (dual-headed)"
 	help
 	  Say Y here if you have an old MDA or monochrome Hercules graphics
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 37a6512feda0..abb769824840 100644
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
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index f0a66a344d87..d523cd4de9d4 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1129,7 +1129,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 
 	if (par->need_docopy) {
 		vfree(par->dio_vp);
-		iounmap(info->screen_base);
+		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
 		hvfb_release_phymem(hdev, info->fix.smem_start,
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 6a52eba64559..3c46838651b0 100644
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
index c3d89fa1bab7..bc88ba29d393 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -597,7 +597,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 		BUG_ON(tmp > bsize);
 		AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 		AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_fix_checksum(sb, bh);
 		bh->b_state &= ~(1UL << BH_New);
@@ -725,7 +725,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		tmp = min(bsize - boff, to - from);
 		BUG_ON(boff + tmp > bsize || tmp > bsize);
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
-		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
+		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(
+			max(boff + tmp, be32_to_cpu(AFFS_DATA_HEAD(bh)->size)));
 		affs_fix_checksum(sb, bh);
 		mark_buffer_dirty_inode(bh, inode);
 		written += tmp;
@@ -747,7 +748,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(bsize);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
@@ -781,7 +782,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a8089bf2be98..cf2b65be04b5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5240,7 +5240,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				ret = btrfs_dec_ref(trans, root, eb, 1);
 			else
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			if (is_fstree(root->root_key.objectid)) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a1481e47a761..b6cce8225d05 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -208,7 +208,7 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		clu = next;
 		if (exfat_ent_get(sb, clu, &next))
 			return -EIO;
-	} while (next != EXFAT_EOF_CLUSTER);
+	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
 	if (p_chain->size != count) {
 		exfat_fs_error(sb,
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 70a0f5e56f4d..513360234b14 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -88,6 +88,9 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
+	else if (unlikely(next_offset == size && de->name_len == 1 &&
+			  de->name[0] == '.'))
+		error_msg = "'.' directory cannot be the last in data block";
 	else
 		return 0;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9d7800d66200..20e89ffe9a06 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6123,22 +6123,29 @@ static int ext4_statfs_project(struct super_block *sb,
 			     dquot->dq_dqb.dqb_bhardlimit);
 	limit >>= sb->s_blocksize_bits;
 
-	if (limit && buf->f_blocks > limit) {
+	if (limit) {
+		uint64_t	remaining = 0;
+
 		curblock = (dquot->dq_dqb.dqb_curspace +
 			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
-		buf->f_blocks = limit;
-		buf->f_bfree = buf->f_bavail =
-			(buf->f_blocks > curblock) ?
-			 (buf->f_blocks - curblock) : 0;
+		if (limit > curblock)
+			remaining = limit - curblock;
+
+		buf->f_blocks = min(buf->f_blocks, limit);
+		buf->f_bfree = min(buf->f_bfree, remaining);
+		buf->f_bavail = min(buf->f_bavail, remaining);
 	}
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
 			     dquot->dq_dqb.dqb_ihardlimit);
-	if (limit && buf->f_files > limit) {
-		buf->f_files = limit;
-		buf->f_ffree =
-			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
-			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dquot->dq_dqb.dqb_curinodes)
+			remaining = limit - dquot->dq_dqb.dqb_curinodes;
+
+		buf->f_files = min(buf->f_files, limit);
+		buf->f_ffree = min(buf->f_ffree, remaining);
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d131f34cd3e1..4488a53a192d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1384,7 +1384,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
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
index a3d1d560f4c8..417d1c2fc291 100644
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
index 72521a614514..3eb0130f0c3f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4678,10 +4678,9 @@ const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
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
 
@@ -4700,8 +4699,23 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
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
 
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 02d9af026ad1..dbed8d44d805 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -552,17 +552,6 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
-	else if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
-		struct inode *inode;
-
-		spin_lock(&delegation->lock);
-		inode = delegation->inode;
-		if (inode && list_empty(&NFS_I(inode)->open_files))
-			ret = true;
-		spin_unlock(&delegation->lock);
-	}
-	if (ret)
-		clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
@@ -800,11 +789,25 @@ int nfs4_inode_make_writeable(struct inode *inode)
 	return nfs4_inode_return_delegation(inode);
 }
 
-static void nfs_mark_return_if_closed_delegation(struct nfs_server *server,
-		struct nfs_delegation *delegation)
+static void
+nfs_mark_return_if_closed_delegation(struct nfs_server *server,
+				     struct nfs_delegation *delegation)
 {
-	set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
-	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
+	struct inode *inode;
+
+	if (test_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
+	    test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags))
+		return;
+	spin_lock(&delegation->lock);
+	inode = delegation->inode;
+	if (!inode)
+		goto out;
+	if (list_empty(&NFS_I(inode)->open_files))
+		nfs_mark_return_delegation(server, delegation);
+	else
+		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+out:
+	spin_unlock(&delegation->lock);
 }
 
 static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5543ea891398..311409be7374 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1069,6 +1069,12 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
 	return openlockstateid(stid);
 }
 
+/*
+ * As the sc_free callback of deleg, this may be called by nfs4_put_stid
+ * in nfsd_break_one_deleg.
+ * Considering nfsd_break_one_deleg is called with the flc->flc_lock held,
+ * this function mustn't ever sleep.
+ */
 static void nfs4_free_deleg(struct nfs4_stid *stid)
 {
 	struct nfs4_delegation *dp = delegstateid(stid);
@@ -4922,6 +4928,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
+	bool queued;
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -4930,7 +4937,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
-	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
+	queued = nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!queued);
+	if (!queued)
+		nfs4_put_stid(&dp->dl_stid);
 }
 
 /* Called from break_lease() with flc_lock held. */
@@ -6236,14 +6246,19 @@ deleg_reaper(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (clp->cl_state != NFSD4_ACTIVE ||
-			list_empty(&clp->cl_delegations) ||
-			atomic_read(&clp->cl_delegs_in_recall) ||
-			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
-			(ktime_get_boottime_seconds() -
-				clp->cl_ra_time < 5)) {
+
+		if (clp->cl_state != NFSD4_ACTIVE)
+			continue;
+		if (list_empty(&clp->cl_delegations))
+			continue;
+		if (atomic_read(&clp->cl_delegs_in_recall))
+			continue;
+		if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags))
+			continue;
+		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
+			continue;
+		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
-		}
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index a9a6276ff29b..94c7acfebe18 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1798,6 +1798,14 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
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
index b955ba5db72c..b09cc9e6d591 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -415,7 +415,7 @@ static const struct file_operations proc_pid_cmdline_ops = {
 #ifdef CONFIG_KALLSYMS
 /*
  * Provides a wchan file via kallsyms in a proper one-value-per-file format.
- * Returns the resolved symbol.  If that fails, simply return the address.
+ * Returns the resolved symbol to user space.
  */
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5898761698c2..7b6d9c77b425 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -563,10 +563,16 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static inline void pde_set_flags(struct proc_dir_entry *pde)
+static void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (pde->proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (pde->proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
@@ -630,6 +636,7 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -660,6 +667,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index bde6b6f69852..ba35ffc426ea 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -684,13 +684,13 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-		if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_read_iter(de))
 			inode->i_fop = &proc_iter_file_ops;
 		else
 			inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (de->proc_ops->proc_compat_ioctl) {
-			if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_compat_ioctl(de)) {
+			if (pde_has_proc_read_iter(de))
 				inode->i_fop = &proc_iter_file_ops_compat;
 			else
 				inode->i_fop = &proc_reg_file_ops_compat;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index afbe96b6bf77..939adac4bfa3 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -79,6 +79,20 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_has_proc_read_iter(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_read_iter;
+}
+
+static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
+{
+#ifdef CONFIG_COMPAT
+	return pde->flags & PROC_ENTRY_proc_compat_ioctl;
+#else
+	return false;
+#endif
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index f11bcbac7727..4a77a5a3109e 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,7 +21,8 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
+						       '\375' };
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index bd1c39907b92..9c14d181397c 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -232,6 +232,13 @@ struct drm_dp_mst_branch {
 	 */
 	struct list_head destroy_next;
 
+	/**
+	 * @rad: Relative Address of the MST branch.
+	 * For &drm_dp_mst_topology_mgr.mst_primary, it's rad[8] are all 0,
+	 * unset and unused. For MST branches connected after mst_primary,
+	 * in each element of rad[] the nibbles are ordered by the most
+	 * signifcant 4 bits first and the least significant 4 bits second.
+	 */
 	u8 rad[8];
 	u8 lct;
 	int num_ports;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4e475ded5cf5..9463dddce6bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3242,6 +3242,8 @@ extern const struct file_operations generic_ro_fops;
 
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
index 0652b4858ba6..71d3fa7f0265 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -426,7 +426,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 static inline void disable_irq_nosync_lockdep(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_disable();
 #endif
 }
@@ -434,7 +434,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
 static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_save(*flags);
 #endif
 }
@@ -449,7 +449,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep(unsigned int irq)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_enable();
 #endif
 	enable_irq(irq);
@@ -457,7 +457,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_restore(*flags);
 #endif
 	enable_irq(irq);
diff --git a/include/linux/netfilter/nf_conntrack_common.h b/include/linux/netfilter/nf_conntrack_common.h
index 0c7d8d1e945d..ce8a4eb69b5c 100644
--- a/include/linux/netfilter/nf_conntrack_common.h
+++ b/include/linux/netfilter/nf_conntrack_common.h
@@ -2,7 +2,7 @@
 #ifndef _NF_CONNTRACK_COMMON_H
 #define _NF_CONNTRACK_COMMON_H
 
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <uapi/linux/netfilter/nf_conntrack_common.h>
 
 struct ip_conntrack_stat {
@@ -24,19 +24,19 @@ struct ip_conntrack_stat {
 #define NFCT_PTRMASK	~(NFCT_INFOMASK)
 
 struct nf_conntrack {
-	atomic_t use;
+	refcount_t use;
 };
 
 void nf_conntrack_destroy(struct nf_conntrack *nfct);
 static inline void nf_conntrack_put(struct nf_conntrack *nfct)
 {
-	if (nfct && atomic_dec_and_test(&nfct->use))
+	if (nfct && refcount_dec_and_test(&nfct->use))
 		nf_conntrack_destroy(nfct);
 }
 static inline void nf_conntrack_get(struct nf_conntrack *nfct)
 {
 	if (nfct)
-		atomic_inc(&nfct->use);
+		refcount_inc(&nfct->use);
 }
 
 #endif /* _NF_CONNTRACK_COMMON_H */
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index ca856e582914..96e3256738e4 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -32,6 +32,7 @@ static inline bool queue_pm_work(struct work_struct *work)
 
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
+extern bool pm_runtime_need_not_resume(struct device *dev);
 extern int pm_runtime_force_suspend(struct device *dev);
 extern int pm_runtime_force_resume(struct device *dev);
 
@@ -220,6 +221,7 @@ static inline bool queue_pm_work(struct work_struct *work) { return false; }
 
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
+static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
 static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
 static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 8c892730a1f1..9f8e0072b30f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,10 +20,13 @@ enum {
 	 * If in doubt, ignore this flag.
 	 */
 #ifdef MODULE
-	PROC_ENTRY_PERMANENT = 0U,
+	PROC_ENTRY_PERMANENT		= 0U,
 #else
-	PROC_ENTRY_PERMANENT = 1U << 0,
+	PROC_ENTRY_PERMANENT		= 1U << 0,
 #endif
+
+	PROC_ENTRY_proc_read_iter	= 1U << 1,
+	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
 };
 
 struct proc_ops {
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
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 47d644de0e47..2909233427de 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -991,7 +991,7 @@ int ip6_find_1stfragopt(struct sk_buff *skb, u8 **nexthdr);
 int ip6_append_data(struct sock *sk,
 		    int getfrag(void *from, char *to, int offset, int len,
 				int odd, struct sk_buff *skb),
-		    void *from, int length, int transhdrlen,
+		    void *from, size_t length, int transhdrlen,
 		    struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 		    struct rt6_info *rt, unsigned int flags);
 
@@ -1007,7 +1007,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk, struct sk_buff_head *queue,
 struct sk_buff *ip6_make_skb(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
-			     void *from, int length, int transhdrlen,
+			     void *from, size_t length, int transhdrlen,
 			     struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 			     struct rt6_info *rt, unsigned int flags,
 			     struct inet_cork_full *cork);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ffca72b8c4c6..74802ec5ab14 100644
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
index 9aa855a96c4a..aadde6540291 100644
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
index d91295d3059f..6548bd90c5c3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2577,7 +2577,7 @@ int sched_dl_global_validate(void)
 	 * cycling on root_domains... Discussion on different/better
 	 * solutions is welcome!
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
 		cpus = dl_bw_cpus(cpu);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7f9f2fc183fe..c202488695c4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -144,11 +144,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -273,11 +268,6 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1275,6 +1265,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
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
index 1656a7d9bb69..6957381b139c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1081,7 +1081,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (!preemptible()) {
+	if (preempt_count() != 0 || irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9a2c8727b033..225dbe4a5641 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5768,9 +5768,9 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
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
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index ee174de0b8f6..e43426aa1283 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -749,6 +749,38 @@ static struct trace_event_fields synth_event_fields_array[] = {
 	{}
 };
 
+static int synth_event_reg(struct trace_event_call *call,
+		    enum trace_reg type, void *data)
+{
+	struct synth_event *event = container_of(call, struct synth_event, call);
+
+	switch (type) {
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+#endif
+	case TRACE_REG_REGISTER:
+		if (!try_module_get(event->mod))
+			return -EBUSY;
+		break;
+	default:
+		break;
+	}
+
+	int ret = trace_event_reg(call, type, data);
+
+	switch (type) {
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_UNREGISTER:
+#endif
+	case TRACE_REG_UNREGISTER:
+		module_put(event->mod);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 static int register_synth_event(struct synth_event *event)
 {
 	struct trace_event_call *call = &event->call;
@@ -778,7 +810,7 @@ static int register_synth_event(struct synth_event *event)
 		goto out;
 	}
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = trace_event_reg;
+	call->class->reg = synth_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
 	call->data = event;
 	call->tp = event->tp;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 60d66278aa0d..2aafe12842cb 100644
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
index 619a60944bb6..10d1719c3d4d 100644
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
index 037e1e863b17..97b10bb31a1f 100644
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
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 73717917d816..37da8647b4ec 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -274,6 +274,15 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	/*
+	 * pipe_resize_ring() does not update nr_accounted for watch_queue
+	 * pipes, because the above vastly overprovisions. Set nr_accounted on
+	 * and max_usage this pipe to the number that was actually charged to
+	 * the user above via account_pipe_buffers.
+	 */
+	pipe->max_usage = nr_pages;
+	pipe->nr_accounted = nr_pages;
+
 	ret = -ENOMEM;
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
 	if (!pages)
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
index 7226c784dbe0..ca9952c52fb5 100644
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
 
 static void lec_tx_timeout(struct net_device *dev, unsigned int txqueue)
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
index c0aa54d21c64..e0b41afa3472 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -326,8 +326,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index aff877203cd2..d43fc72af9a9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -850,8 +850,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 7601ce9143c1..7e698b0ac7bc 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -855,11 +855,16 @@ static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
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
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 58c029958759..546795425119 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4751,19 +4751,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	/* If no side requires MITM protection; auto-accept */
+	/* If no side requires MITM protection; use JUST_CFM method */
 	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
 	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
-		/* If we're not the initiators request authorization to
-		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM or if the local IO capability is
-		 * NoInputNoOutput, in which case we do auto-accept
+		/* If we're not the initiator of request authorization and the
+		 * local IO capability is not NoInputNoOutput, use JUST_WORKS
+		 * method (mgmt_user_confirm with confirm_hint set to 1).
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
-		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-		    (loc_mitm || rem_mitm)) {
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			BT_DBG("Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index de47c16b134b..3e77a52709aa 100644
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
 
@@ -649,8 +649,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	int matches;
 
 	/* update statistics */
-	pkg_stats->rx_frames++;
-	pkg_stats->rx_frames_delta++;
+	atomic_long_inc(&pkg_stats->rx_frames);
+	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
@@ -671,8 +671,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
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
index b15760b5c1cc..2be4a239f31e 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -122,6 +122,13 @@ void can_stat_update(struct timer_list *t)
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
@@ -131,35 +138,33 @@ void can_stat_update(struct timer_list *t)
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
@@ -172,9 +177,9 @@ void can_stat_update(struct timer_list *t)
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
@@ -216,9 +221,12 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
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
index f04ba63e9851..37f7bcbc2adc 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2181,6 +2181,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NDTPA_QUEUE_LENBYTES]		= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4475b2174bcc..66a6f6241239 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -326,6 +326,7 @@ static int netpoll_owner_active(struct net_device *dev)
 static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	netdev_tx_t status = NETDEV_TX_BUSY;
+	netdev_tx_t ret = NET_XMIT_DROP;
 	struct net_device *dev;
 	unsigned long tries;
 	/* It is up to the caller to keep npinfo alive. */
@@ -334,11 +335,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	lockdep_assert_irqs_disabled();
 
 	dev = np->dev;
+	rcu_read_lock();
 	npinfo = rcu_dereference_bh(dev->npinfo);
 
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
-		return NET_XMIT_DROP;
+		goto out;
 	}
 
 	/* don't get messages out of order, and no recursion */
@@ -377,7 +379,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
-	return NETDEV_TX_OK;
+	ret = NETDEV_TX_OK;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2806b9ed6387..bc86034e17ea 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -950,6 +950,9 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 				 /* IFLA_VF_STATS_TX_DROPPED */
 				 nla_total_size_64bit(sizeof(__u64)));
 		}
+		if (dev->netdev_ops->ndo_get_vf_guid)
+			size += num_vfs * 2 *
+				nla_total_size(sizeof(struct ifla_vf_guid));
 		return size;
 	} else
 		return 0;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index fd4c16391552..d334a2ccd523 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -420,15 +420,14 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	int err = 0;
 
 	if (irqs_disabled())
 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
 
 	raw_spin_lock_bh(&stab->lock);
-	sk = *psk;
-	if (!sk_test || sk_test == sk)
+	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
 
 	if (likely(sk))
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index ba1388ba6c6e..01d362b5b882 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -415,7 +415,7 @@ int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (!reply || skb->pkt_type == PACKET_HOST)
+	if (!reply)
 		return 0;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -459,7 +459,7 @@ static const struct nla_policy
 geneve_opt_policy[LWTUNNEL_IP_OPT_GENEVE_MAX + 1] = {
 	[LWTUNNEL_IP_OPT_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[LWTUNNEL_IP_OPT_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 455bb4668407..d38d15ccc750 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5658,6 +5658,27 @@ static void snmp6_fill_stats(u64 *stats, struct inet6_dev *idev, int attrtype,
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
@@ -5679,18 +5700,10 @@ static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 
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
index 0ea66e9db249..e17e756bb1ad 100644
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
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5003c5a23fa7..426330b8dfa4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1449,7 +1449,7 @@ static int __ip6_append_data(struct sock *sk,
 			     struct page_frag *pfrag,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
-			     void *from, int length, int transhdrlen,
+			     void *from, size_t length, int transhdrlen,
 			     unsigned int flags, struct ipcm6_cookie *ipc6)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
@@ -1795,7 +1795,7 @@ static int __ip6_append_data(struct sock *sk,
 int ip6_append_data(struct sock *sk,
 		    int getfrag(void *from, char *to, int offset, int len,
 				int odd, struct sk_buff *skb),
-		    void *from, int length, int transhdrlen,
+		    void *from, size_t length, int transhdrlen,
 		    struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 		    struct rt6_info *rt, unsigned int flags)
 {
@@ -1989,7 +1989,7 @@ EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
 struct sk_buff *ip6_make_skb(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
-			     void *from, int length, int transhdrlen,
+			     void *from, size_t length, int transhdrlen,
 			     struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 			     struct rt6_info *rt, unsigned int flags,
 			     struct inet_cork_full *cork)
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
index 178c56f6f618..b47f89600c2f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3519,7 +3519,8 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		in6_dev_put(idev);
 
 	if (err) {
-		lwtstate_put(fib6_nh->fib_nh_lws);
+		fib_nh_common_release(&fib6_nh->nh_common);
+		fib6_nh->nh_common.nhc_pcpu_rth_output = NULL;
 		fib6_nh->fib_nh_lws = NULL;
 		if (dev)
 			dev_put(dev);
@@ -3696,10 +3697,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2330140d6b1c..f5aeb3061408 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -530,6 +530,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index d0b64c36471d..fb9f1badeddb 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2852,12 +2852,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
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
@@ -2893,12 +2893,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
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
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 99d5d8cd3895..aea25823fbc1 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -564,7 +564,7 @@ struct nf_conn *nf_ct_tmpl_alloc(struct net *net,
 	tmpl->status = IPS_TEMPLATE;
 	write_pnet(&tmpl->ct_net, net);
 	nf_ct_zone_add(tmpl, zone);
-	atomic_set(&tmpl->ct_general.use, 0);
+	refcount_set(&tmpl->ct_general.use, 1);
 
 	return tmpl;
 }
@@ -597,7 +597,7 @@ destroy_conntrack(struct nf_conntrack *nfct)
 	struct nf_conn *ct = (struct nf_conn *)nfct;
 
 	pr_debug("destroy_conntrack(%p)\n", ct);
-	WARN_ON(atomic_read(&nfct->use) != 0);
+	WARN_ON(refcount_read(&nfct->use) != 0);
 
 	if (unlikely(nf_ct_is_template(ct))) {
 		nf_ct_tmpl_free(ct);
@@ -716,9 +716,12 @@ nf_ct_match(const struct nf_conn *ct1, const struct nf_conn *ct2)
 /* caller must hold rcu readlock and none of the nf_conntrack_locks */
 static void nf_ct_gc_expired(struct nf_conn *ct)
 {
-	if (!atomic_inc_not_zero(&ct->ct_general.use))
+	if (!refcount_inc_not_zero(&ct->ct_general.use))
 		return;
 
+	/* load ->status after refcount increase */
+	smp_acquire__after_ctrl_dep();
+
 	if (nf_ct_should_gc(ct))
 		nf_ct_kill(ct);
 
@@ -784,7 +787,10 @@ __nf_conntrack_find_get(struct net *net, const struct nf_conntrack_zone *zone,
 		 * in, try to obtain a reference and re-check tuple
 		 */
 		ct = nf_ct_tuplehash_to_ctrack(h);
-		if (likely(atomic_inc_not_zero(&ct->ct_general.use))) {
+		if (likely(refcount_inc_not_zero(&ct->ct_general.use))) {
+			/* re-check key after refcount */
+			smp_acquire__after_ctrl_dep();
+
 			if (likely(nf_ct_key_equal(h, tuple, zone, net)))
 				goto found;
 
@@ -853,7 +859,7 @@ nf_conntrack_hash_check_insert(struct nf_conn *ct)
 
 	smp_wmb();
 	/* The caller holds a reference to this object */
-	atomic_set(&ct->ct_general.use, 2);
+	refcount_set(&ct->ct_general.use, 2);
 	__nf_conntrack_hash_insert(ct, hash, reply_hash);
 	nf_conntrack_double_unlock(hash, reply_hash);
 	NF_CT_STAT_INC(net, insert);
@@ -902,7 +908,7 @@ static void __nf_conntrack_insert_prepare(struct nf_conn *ct)
 {
 	struct nf_conn_tstamp *tstamp;
 
-	atomic_inc(&ct->ct_general.use);
+	refcount_inc(&ct->ct_general.use);
 	ct->status |= IPS_CONFIRMED;
 
 	/* set conntrack timestamp, if enabled. */
@@ -1281,9 +1287,12 @@ static unsigned int early_drop_list(struct net *net,
 		    nf_ct_is_dying(tmp))
 			continue;
 
-		if (!atomic_inc_not_zero(&tmp->ct_general.use))
+		if (!refcount_inc_not_zero(&tmp->ct_general.use))
 			continue;
 
+		/* load ->ct_net and ->status after refcount increase */
+		smp_acquire__after_ctrl_dep();
+
 		/* kill only if still in same netns -- might have moved due to
 		 * SLAB_TYPESAFE_BY_RCU rules.
 		 *
@@ -1397,9 +1406,12 @@ static void gc_worker(struct work_struct *work)
 				continue;
 
 			/* need to take reference to avoid possible races */
-			if (!atomic_inc_not_zero(&tmp->ct_general.use))
+			if (!refcount_inc_not_zero(&tmp->ct_general.use))
 				continue;
 
+			/* load ->status after refcount increase */
+			smp_acquire__after_ctrl_dep();
+
 			if (gc_worker_skip_ct(tmp)) {
 				nf_ct_put(tmp);
 				continue;
@@ -1498,7 +1510,7 @@ __nf_conntrack_alloc(struct net *net,
 	/* Because we use RCU lookups, we set ct_general.use to zero before
 	 * this is inserted in any list.
 	 */
-	atomic_set(&ct->ct_general.use, 0);
+	refcount_set(&ct->ct_general.use, 0);
 	return ct;
 out:
 	atomic_dec(&net->ct.count);
@@ -1522,7 +1534,7 @@ void nf_conntrack_free(struct nf_conn *ct)
 	/* A freed object has refcnt == 0, that's
 	 * the golden rule for SLAB_TYPESAFE_BY_RCU
 	 */
-	WARN_ON(atomic_read(&ct->ct_general.use) != 0);
+	WARN_ON(refcount_read(&ct->ct_general.use) != 0);
 
 	nf_ct_ext_destroy(ct);
 	kmem_cache_free(nf_conntrack_cachep, ct);
@@ -1610,8 +1622,18 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 	if (!exp)
 		__nf_ct_try_assign_helper(ct, tmpl, GFP_ATOMIC);
 
-	/* Now it is inserted into the unconfirmed list, bump refcount */
-	nf_conntrack_get(&ct->ct_general);
+	/* Other CPU might have obtained a pointer to this object before it was
+	 * released.  Because refcount is 0, refcount_inc_not_zero() will fail.
+	 *
+	 * After refcount_set(1) it will succeed; ensure that zeroing of
+	 * ct->status and the correct ct->net pointer are visible; else other
+	 * core might observe CONFIRMED bit which means the entry is valid and
+	 * in the hash table, but its not (anymore).
+	 */
+	smp_wmb();
+
+	/* Now it is inserted into the unconfirmed list, set refcount to 1. */
+	refcount_set(&ct->ct_general.use, 1);
 	nf_ct_add_to_unconfirmed_list(ct);
 
 	local_bh_enable();
@@ -2214,7 +2236,7 @@ get_next_corpse(int (*iter)(struct nf_conn *i, void *data),
 
 	return NULL;
 found:
-	atomic_inc(&ct->ct_general.use);
+	refcount_inc(&ct->ct_general.use);
 	spin_unlock(lockp);
 	local_bh_enable();
 	return ct;
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 42557d2b6a90..516a9f05a87a 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -187,12 +187,12 @@ nf_ct_find_expectation(struct net *net,
 	 * about to invoke ->destroy(), or nf_ct_delete() via timeout
 	 * or early_drop().
 	 *
-	 * The atomic_inc_not_zero() check tells:  If that fails, we
+	 * The refcount_inc_not_zero() check tells:  If that fails, we
 	 * know that the ct is being destroyed.  If it succeeds, we
 	 * can be sure the ct cannot disappear underneath.
 	 */
 	if (unlikely(nf_ct_is_dying(exp->master) ||
-		     !atomic_inc_not_zero(&exp->master->ct_general.use)))
+		     !refcount_inc_not_zero(&exp->master->ct_general.use)))
 		return NULL;
 
 	if (exp->flags & NF_CT_EXPECT_PERMANENT) {
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 8c9edad0826e..b2b06033ef2c 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -506,7 +506,7 @@ static int ctnetlink_dump_id(struct sk_buff *skb, const struct nf_conn *ct)
 
 static int ctnetlink_dump_use(struct sk_buff *skb, const struct nf_conn *ct)
 {
-	if (nla_put_be32(skb, CTA_USE, htonl(atomic_read(&ct->ct_general.use))))
+	if (nla_put_be32(skb, CTA_USE, htonl(refcount_read(&ct->ct_general.use))))
 		goto nla_put_failure;
 	return 0;
 
@@ -1149,8 +1149,9 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 				continue;
 			ct = nf_ct_tuplehash_to_ctrack(h);
 			if (nf_ct_is_expired(ct)) {
+				/* need to defer nf_ct_kill() until lock is released */
 				if (i < ARRAY_SIZE(nf_ct_evict) &&
-				    atomic_inc_not_zero(&ct->ct_general.use))
+				    refcount_inc_not_zero(&ct->ct_general.use))
 					nf_ct_evict[i++] = ct;
 				continue;
 			}
@@ -1701,7 +1702,7 @@ ctnetlink_dump_list(struct sk_buff *skb, struct netlink_callback *cb, bool dying
 						  NFNL_MSG_TYPE(cb->nlh->nlmsg_type),
 						  ct, dying ? true : false, 0);
 			if (res < 0) {
-				if (!atomic_inc_not_zero(&ct->ct_general.use))
+				if (!refcount_inc_not_zero(&ct->ct_general.use))
 					continue;
 				cb->args[0] = cpu;
 				cb->args[1] = (unsigned long)ct;
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index b613de96ad85..8498bf27a353 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -300,9 +300,12 @@ static int ct_seq_show(struct seq_file *s, void *v)
 	int ret = 0;
 
 	WARN_ON(!ct);
-	if (unlikely(!atomic_inc_not_zero(&ct->ct_general.use)))
+	if (unlikely(!refcount_inc_not_zero(&ct->ct_general.use)))
 		return 0;
 
+	/* load ->status after refcount increase */
+	smp_acquire__after_ctrl_dep();
+
 	if (nf_ct_should_gc(ct)) {
 		nf_ct_kill(ct);
 		goto release;
@@ -367,7 +370,7 @@ static int ct_seq_show(struct seq_file *s, void *v)
 	ct_show_zone(s, ct, NF_CT_DEFAULT_ZONE_DIR);
 	ct_show_delta_time(s, ct);
 
-	seq_printf(s, "use=%u\n", atomic_read(&ct->ct_general.use));
+	seq_printf(s, "use=%u\n", refcount_read(&ct->ct_general.use));
 
 	if (seq_has_overflowed(s))
 		goto release;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index d091d51b5e19..e05e09c07b97 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -48,7 +48,7 @@ struct flow_offload *flow_offload_alloc(struct nf_conn *ct)
 	struct flow_offload *flow;
 
 	if (unlikely(nf_ct_is_dying(ct) ||
-	    !atomic_inc_not_zero(&ct->ct_general.use)))
+	    !refcount_inc_not_zero(&ct->ct_general.use)))
 		return NULL;
 
 	flow = kzalloc(sizeof(*flow), GFP_ATOMIC);
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 3d6d49420db8..2dfc5dae0656 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -349,7 +349,6 @@ static int __net_init synproxy_net_init(struct net *net)
 		goto err2;
 
 	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
-	nf_conntrack_get(&ct->ct_general);
 	snet->tmpl = ct;
 
 	snet->stats = alloc_percpu(struct synproxy_stats);
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 2a8dfa68f6e2..f95f1dbc48de 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -239,6 +239,7 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 	enum ip_conntrack_info ctinfo;
 	u16 value = nft_reg_load16(&regs->data[priv->sreg]);
 	struct nf_conn *ct;
+	int oldcnt;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) /* already tracked */
@@ -259,10 +260,14 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 
 	ct = this_cpu_read(nft_ct_pcpu_template);
 
-	if (likely(atomic_read(&ct->ct_general.use) == 1)) {
+	__refcount_inc(&ct->ct_general.use, &oldcnt);
+	if (likely(oldcnt == 1)) {
 		nf_ct_zone_add(ct, &zone);
 	} else {
-		/* previous skb got queued to userspace */
+		refcount_dec(&ct->ct_general.use);
+		/* previous skb got queued to userspace, allocate temporary
+		 * one until percpu template can be reused.
+		 */
 		ct = nf_ct_tmpl_alloc(nft_net(pkt), &zone, GFP_ATOMIC);
 		if (!ct) {
 			regs->verdict.code = NF_DROP;
@@ -270,7 +275,6 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 		}
 	}
 
-	atomic_inc(&ct->ct_general.use);
 	nf_ct_set(skb, ct, IP_CT_NEW);
 }
 #endif
@@ -375,7 +379,6 @@ static bool nft_ct_tmpl_alloc_pcpu(void)
 			return false;
 		}
 
-		atomic_set(&tmp->ct_general.use, 1);
 		per_cpu(nft_ct_pcpu_template, cpu) = tmp;
 	}
 
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index c9f89f035ccf..5bde436b8754 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -85,7 +85,6 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	unsigned char optbuf[sizeof(struct ip_options) + 40];
 	struct ip_options *opt = (struct ip_options *)optbuf;
 	struct iphdr *iph, _iph;
-	unsigned int start;
 	bool found = false;
 	__be32 info;
 	int optlen;
@@ -93,7 +92,6 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	iph = skb_header_pointer(skb, 0, sizeof(_iph), &_iph);
 	if (!iph)
 		return -EBADMSG;
-	start = sizeof(struct iphdr);
 
 	optlen = iph->ihl * 4 - (int)sizeof(struct iphdr);
 	if (optlen <= 0)
@@ -103,7 +101,7 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	/* Copy the options since __ip_options_compile() modifies
 	 * the options.
 	 */
-	if (skb_copy_bits(skb, start, opt->__data, optlen))
+	if (skb_copy_bits(skb, sizeof(struct iphdr), opt->__data, optlen))
 		return -EBADMSG;
 	opt->optlen = optlen;
 
@@ -118,18 +116,18 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
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
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index c8822fa8196d..cfe6cf1be421 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -305,13 +305,13 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 static const struct nla_policy nft_tunnel_opts_geneve_policy[NFTA_TUNNEL_KEY_GENEVE_MAX + 1] = {
 	[NFTA_TUNNEL_KEY_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[NFTA_TUNNEL_KEY_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static int nft_tunnel_obj_geneve_init(const struct nlattr *attr,
 				      struct nft_tunnel_opts *opts)
 {
-	struct geneve_opt *opt = (struct geneve_opt *)opts->u.data + opts->len;
+	struct geneve_opt *opt = (struct geneve_opt *)(opts->u.data + opts->len);
 	struct nlattr *tb[NFTA_TUNNEL_KEY_GENEVE_MAX + 1];
 	int err, data_len;
 
@@ -592,7 +592,7 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 		if (!inner)
 			goto failure;
 		while (opts->len > offset) {
-			opt = (struct geneve_opt *)opts->u.data + offset;
+			opt = (struct geneve_opt *)(opts->u.data + offset);
 			if (nla_put_be16(skb, NFTA_TUNNEL_KEY_GENEVE_CLASS,
 					 opt->opt_class) ||
 			    nla_put_u8(skb, NFTA_TUNNEL_KEY_GENEVE_TYPE,
diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index d4deee39158b..ffff1e1f79b9 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -24,7 +24,7 @@ static inline int xt_ct_target(struct sk_buff *skb, struct nf_conn *ct)
 		return XT_CONTINUE;
 
 	if (ct) {
-		atomic_inc(&ct->ct_general.use);
+		refcount_inc(&ct->ct_general.use);
 		nf_ct_set(skb, ct, IP_CT_NEW);
 	} else {
 		nf_ct_set(skb, ct, IP_CT_UNTRACKED);
@@ -202,7 +202,6 @@ static int xt_ct_tg_check(const struct xt_tgchk_param *par,
 			goto err4;
 	}
 	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
-	nf_conntrack_get(&ct->ct_general);
 out:
 	info->ct = ct;
 	return 0;
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 4095456f413d..80fee9d118ee 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -923,12 +923,6 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
-		/* Need to set the pkt_type to involve the routing layer.  The
-		 * packet movement through the OVS datapath doesn't generally
-		 * use routing, but this is needed for tunnel cases.
-		 */
-		skb->pkt_type = PACKET_OUTGOING;
-
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 30f5e414018b..9e8b3b930f92 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1713,7 +1713,6 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 		goto err_free_ct;
 
 	__set_bit(IPS_CONFIRMED_BIT, &ct_info.ct->status);
-	nf_conntrack_get(&ct_info.ct->ct_general);
 	return 0;
 err_free_ct:
 	__ovs_ct_free_action(&ct_info);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 4ea7a81707f3..d9748c917a50 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1235,7 +1235,6 @@ static int tcf_ct_fill_params(struct net *net,
 		return -ENOMEM;
 	}
 	__set_bit(IPS_CONFIRMED_BIT, &tmpl->status);
-	nf_conntrack_get(&tmpl->ct_general);
 	p->tmpl = tmpl;
 
 	return 0;
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 85c0d0d5b9da..0d90349636f0 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -67,7 +67,7 @@ geneve_opt_policy[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS]	   = { .type = NLA_U16 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_TYPE]	   = { .type = NLA_U8 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]	   = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 98f333aa0aac..9f6f8430d037 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -717,7 +717,7 @@ geneve_opt_policy[TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_CLASS]      = { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_TYPE]       = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_DATA]       = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 238ae7b0ca5b..b8fb94bfa960 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2169,6 +2169,12 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
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
index df72fb83d9c7..c9e422e46615 100644
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
index ee6514af830f..0527728aee98 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -735,7 +735,7 @@ struct sctp_chunk *sctp_process_strreset_tsnreq(
 	 *     value SHOULD be the smallest TSN not acknowledged by the
 	 *     receiver of the request plus 2^31.
 	 */
-	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1 << 31);
+	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1U << 31);
 	sctp_tsnmap_init(&asoc->peer.tsn_map, SCTP_TSN_MAP_INITIAL,
 			 init_tsn, GFP_ATOMIC);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d7395601a0e3..fc0306ba2d43 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1382,7 +1382,11 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
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
index ac907b9d32d1..40f7a98abdd1 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -601,7 +601,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
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
index ea12b7f815e1..3fdd2337919e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -577,6 +577,9 @@ static void alc_shutup_pins(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
+	if (spec->no_shutup_pins)
+		return;
+
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
@@ -592,8 +595,7 @@ static void alc_shutup_pins(struct hda_codec *codec)
 		alc_headset_mic_no_shutup(codec);
 		break;
 	default:
-		if (!spec->no_shutup_pins)
-			snd_hda_shutup_pins(codec);
+		snd_hda_shutup_pins(codec);
 		break;
 	}
 }
@@ -4700,6 +4702,21 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 	}
 }
 
+static void alc295_fixup_hp_mute_led_coefbit11(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0xb;
+		spec->mute_led_coef.mask = 3 << 3;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 1 << 4;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 static void alc285_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -6940,6 +6957,7 @@ enum {
 	ALC290_FIXUP_MONO_SPEAKERS_HSJACK,
 	ALC290_FIXUP_SUBWOOFER,
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
+	ALC295_FIXUP_HP_MUTE_LED_COEFBIT11,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
 	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
@@ -8485,6 +8503,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC283_FIXUP_INT_MIC,
 	},
+	[ALC295_FIXUP_HP_MUTE_LED_COEFBIT11] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_hp_mute_led_coefbit11,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -9193,6 +9215,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
@@ -9239,6 +9262,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x881e, "HP Laptop 15s-du3xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1228f2de0297..f796b8e5865d 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -967,7 +967,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending++;
-			priv->out_up_delay += 17;
+			priv->out_up_delay += 17000;
 			break;
 		case ARIZONA_OUT4L_ENA_SHIFT:
 		case ARIZONA_OUT4R_ENA_SHIFT:
@@ -977,7 +977,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			case WM8997:
 				break;
 			default:
-				priv->out_up_delay += 10;
+				priv->out_up_delay += 10000;
 				break;
 			}
 			break;
@@ -999,7 +999,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			if (!priv->out_up_pending && priv->out_up_delay) {
 				dev_dbg(component->dev, "Power up delay: %d\n",
 					priv->out_up_delay);
-				msleep(priv->out_up_delay);
+				fsleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
 			break;
@@ -1017,7 +1017,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending++;
-			priv->out_down_delay++;
+			priv->out_down_delay += 1000;
 			break;
 		case ARIZONA_OUT4L_ENA_SHIFT:
 		case ARIZONA_OUT4R_ENA_SHIFT:
@@ -1028,10 +1028,10 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 				break;
 			case WM8998:
 			case WM1814:
-				priv->out_down_delay += 5;
+				priv->out_down_delay += 5000;
 				break;
 			default:
-				priv->out_down_delay++;
+				priv->out_down_delay += 1000;
 				break;
 			}
 		default:
@@ -1052,7 +1052,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			if (!priv->out_down_pending && priv->out_down_delay) {
 				dev_dbg(component->dev, "Power down delay: %d\n",
 					priv->out_down_delay);
-				msleep(priv->out_down_delay);
+				fsleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
 			break;
diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index bbab4bc1f6b5..aa7543a15d8c 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -2322,10 +2322,10 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 	case CS42L92:
 	case CS47L92:
 	case CS47L93:
-		out_up_delay = 6;
+		out_up_delay = 6000;
 		break;
 	default:
-		out_up_delay = 17;
+		out_up_delay = 17000;
 		break;
 	}
 
@@ -2356,7 +2356,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending--;
 			if (!priv->out_up_pending) {
-				msleep(priv->out_up_delay);
+				fsleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
 			break;
@@ -2375,7 +2375,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3L_ENA_SHIFT:
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending++;
-			priv->out_down_delay++;
+			priv->out_down_delay += 1000;
 			break;
 		default:
 			break;
@@ -2392,7 +2392,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending--;
 			if (!priv->out_down_pending) {
-				msleep(priv->out_down_delay);
+				fsleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
 			break;
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index c8f6f5122cac..dd8eeafa223e 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -315,7 +315,7 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -324,12 +324,14 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_RISING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
 		fallthrough;
 	case SND_SOC_DAIFMT_IB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_FALLING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_RISING;
 		break;
 	}
 
@@ -339,6 +341,12 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2764_TDM_CFG4,
+					    TAS2764_TDM_CFG4_TX_MASK,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index f015f22a083b..337bc611bee9 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
@@ -75,6 +75,12 @@
 #define TAS2764_TDM_CFG3_RXS_SHIFT	0x4
 #define TAS2764_TDM_CFG3_MASK		GENMASK(3, 0)
 
+/* TDM Configuration Reg4 */
+#define TAS2764_TDM_CFG4		TAS2764_REG(0X0, 0x0d)
+#define TAS2764_TDM_CFG4_TX_MASK	BIT(0)
+#define TAS2764_TDM_CFG4_TX_RISING	0x0
+#define TAS2764_TDM_CFG4_TX_FALLING	BIT(0)
+
 /* TDM Configuration Reg5 */
 #define TAS2764_TDM_CFG5		TAS2764_REG(0X0, 0x0e)
 #define TAS2764_TDM_CFG5_VSNS_MASK	BIT(6)
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c213c8096142..1928c1616a52 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -508,7 +508,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 28b4656c4e14..b2f87af1bfc8 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -952,7 +952,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(wm0010->dev, "Failed to set IRQ %d as wake source: %d\n",
 			irq, ret);
-		return ret;
+		goto free_irq;
 	}
 
 	if (spi->max_speed_hz)
@@ -964,9 +964,18 @@ static int wm0010_spi_probe(struct spi_device *spi)
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
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index d0cef982215d..aed067bf346f 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -302,7 +302,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 		} else {
 			wseq = wm5110_no_dre_left_enable;
 			nregs = ARRAY_SIZE(wm5110_no_dre_left_enable);
-			priv->out_up_delay += 10;
+			priv->out_up_delay += 10000;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
@@ -312,7 +312,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 		} else {
 			wseq = wm5110_no_dre_right_enable;
 			nregs = ARRAY_SIZE(wm5110_no_dre_right_enable);
-			priv->out_up_delay += 10;
+			priv->out_up_delay += 10000;
 		}
 		break;
 	default:
@@ -338,7 +338,7 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 			snd_soc_component_update_bits(component,
 						      ARIZONA_SPARE_TRIGGERS,
 						      ARIZONA_WS_TRG1, 0);
-			priv->out_down_delay += 27;
+			priv->out_down_delay += 27000;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
@@ -350,7 +350,7 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 			snd_soc_component_update_bits(component,
 						      ARIZONA_SPARE_TRIGGERS,
 						      ARIZONA_WS_TRG2, 0);
-			priv->out_down_delay += 27;
+			priv->out_down_delay += 27000;
 		}
 		break;
 	default:
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 289928d4c0c9..1471d163a7f7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1599,20 +1599,6 @@ int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io)
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
index 6b519370fd64..b5a7741848d7 100644
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
 
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 8d65004c917a..aed8440ef525 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -260,6 +260,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 756cd9694cbe..b749bcc6f041 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -179,6 +179,8 @@ static int j721e_configure_refclk(struct j721e_priv *priv,
 		clk_id = J721E_CLK_PARENT_48000;
 	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_44100])
 		clk_id = J721E_CLK_PARENT_44100;
+	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_48000])
+		clk_id = J721E_CLK_PARENT_48000;
 	else
 		return ret;
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 46504bf0ce3a..eee5a3ce9471 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3296,6 +3296,52 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
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
@@ -3313,5 +3359,10 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
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
index ae8edde7c50e..240f9a0a7297 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -131,7 +131,7 @@ struct pyrf_event {
 };
 
 #define sample_members \
-	sample_member_def(sample_ip, ip, T_ULONGLONG, "event type"),			 \
+	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
 	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
@@ -558,6 +558,11 @@ static PyObject *pyrf_event__new(union perf_event *event)
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
@@ -1057,20 +1062,22 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		evsel = perf_evlist__event2evsel(evlist, event);
 		if (!evsel) {
+			Py_DECREF(pyevent);
 			Py_INCREF(Py_None);
 			return Py_None;
 		}
 
 		pevent->evsel = evsel;
 
-		err = evsel__parse_sample(evsel, event, &pevent->sample);
-
-		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
 
-		if (err)
+		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
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

