Return-Path: <stable+bounces-75989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED6976830
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138FA1C2227A
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C691A0BF9;
	Thu, 12 Sep 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j38e3kla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C541A38F1;
	Thu, 12 Sep 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141724; cv=none; b=HGnSRc0QVCxhZiqJe++ENa2y9vtZogjpWrFEyNvFYWY+DNPUggK9uQQwQRmIVhuSBNQI/435MV9g/YqCfmwQ6+CVgzWztwA8JDFIYRgR6yzZUfCkwRyRb2OZsN0RhNmNtsuOqtd81dvLJMb8vHknR/I6Iyq6T5aJsZO3sZtx1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141724; c=relaxed/simple;
	bh=4ZT7mq43Z0bqg0ikFFSkwzjbNPOlPZB6kXf7wi/edyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUji9133lyauwaiY4aW13aN0wOXcSYQHn2Chkkh3fxoFhwzzFYAlnF90CzIMSfpAQUtEYVDfwN0dGhjUpHly/kPHx+jw396zDyXUPN1xTXJd+s7ai/p54Uh620QPPrQkTpVZYYfITIIIU1S90bTRPfbMkUftIMzsYO0Wo7Y0R0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j38e3kla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645FEC4CEC5;
	Thu, 12 Sep 2024 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141723;
	bh=4ZT7mq43Z0bqg0ikFFSkwzjbNPOlPZB6kXf7wi/edyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j38e3klalk96ZvPqIG7z53YQu5BEJE8EEHkNjj+qSCu45QKgUffPQOAnR98Ub+R6J
	 JExwxmE6wAMSxzZuq+50wgM442P5PuGh+2v/QRtjjb4MJ1vjgm5pQBhbqeKZHK5KHZ
	 UX9XRHbDcbnoCII/3loEcTukOccsZ3+3sC4bXcuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.167
Date: Thu, 12 Sep 2024 13:48:28 +0200
Message-ID: <2024091227-unsocial-quality-0b45@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024091227-cake-cinnamon-58fe@gregkh>
References: <2024091227-cake-cinnamon-58fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/locking/hwspinlock.rst b/Documentation/locking/hwspinlock.rst
index 6f03713b7003..2ffaa3cbd63f 100644
--- a/Documentation/locking/hwspinlock.rst
+++ b/Documentation/locking/hwspinlock.rst
@@ -85,6 +85,17 @@ is already free).
 
 Should be called from a process context (might sleep).
 
+::
+
+  int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
+
+After verifying the owner of the hwspinlock, release a previously acquired
+hwspinlock; returns 0 on success, or an appropriate error code on failure
+(e.g. -EOPNOTSUPP if the bust operation is not defined for the specific
+hwspinlock).
+
+Should be called from a process context (might sleep).
+
 ::
 
   int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int timeout);
diff --git a/Makefile b/Makefile
index 747bfa4f1a8b..461ef96b164b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 166
+SUBLEVEL = 167
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f..702587fda70c 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -97,6 +97,18 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 	return	acpi_cpu_get_madt_gicc(cpu)->uid;
 }
 
+static inline int get_cpu_for_acpi_id(u32 uid)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (acpi_cpu_get_madt_gicc(cpu) &&
+		    uid == get_acpi_id_for_cpu(cpu))
+			return cpu;
+
+	return -EINVAL;
+}
+
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
 int apei_claim_sea(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 5d88ae2ae490..31d27e36137c 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -34,17 +34,6 @@ int __init acpi_numa_get_nid(unsigned int cpu)
 	return acpi_early_node_map[cpu];
 }
 
-static inline int get_cpu_for_acpi_id(u32 uid)
-{
-	int cpu;
-
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (uid == get_acpi_id_for_cpu(cpu))
-			return cpu;
-
-	return -EINVAL;
-}
-
 static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 32ec67c9ab67..77028aa8c107 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -303,13 +303,6 @@ int r4k_clockevent_init(void)
 	if (!c0_compare_int_usable())
 		return -ENXIO;
 
-	/*
-	 * With vectored interrupts things are getting platform specific.
-	 * get_c0_compare_int is a hook to allow a platform to return the
-	 * interrupt number of its liking.
-	 */
-	irq = get_c0_compare_int();
-
 	cd = &per_cpu(mips_clockevent_device, cpu);
 
 	cd->name		= "MIPS";
@@ -320,7 +313,6 @@ int r4k_clockevent_init(void)
 	min_delta		= calculate_min_delta();
 
 	cd->rating		= 300;
-	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= mips_next_event;
 	cd->event_handler	= mips_event_handler;
@@ -332,6 +324,13 @@ int r4k_clockevent_init(void)
 
 	cp0_timer_irq_installed = 1;
 
+	/*
+	 * With vectored interrupts things are getting platform specific.
+	 * get_c0_compare_int is a hook to allow a platform to return the
+	 * interrupt number of its liking.
+	 */
+	irq = get_c0_compare_int();
+
 	if (request_irq(irq, c0_compare_interrupt, flags, "timer",
 			c0_compare_interrupt))
 		pr_err("Failed to request irq %d (timer)\n", irq);
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4c3c7592b6fc..a89c59fb08ba 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -309,6 +309,9 @@ clear_bss_done:
 #else
 	mv a0, s1
 #endif /* CONFIG_BUILTIN_DTB */
+	/* Set trap vector to spin forever to help debug */
+	la a3, .Lsecondary_park
+	csrw CSR_TVEC, a3
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 853b80770c6d..bf509f6194d0 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -72,6 +72,15 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
+	.data.rel.ro : {
+		*(.data.rel.ro .data.rel.ro.*)
+	}
+	.got : {
+		__got_start = .;
+		*(.got)
+		__got_end = .;
+	}
+
 	RW_DATA(0x100, PAGE_SIZE, THREAD_SIZE)
 	BOOT_DATA_PRESERVED
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 95ad6b190d1d..6b4faca401ea 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 059d9c255e01..bc0958eb83b4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -958,6 +958,9 @@ static __init void svm_set_cpu_caps(void)
 
 	/* CPUID 0x8000001F (SME/SEV features) */
 	sev_set_cpu_caps();
+
+	/* Don't advertise Bus Lock Detect to guest if SVM support is absent */
+	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 }
 
 static __init int svm_hardware_setup(void)
@@ -2712,6 +2715,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CSTAR:
 		msr_info->data = svm->vmcb01.ptr->save.cstar;
 		break;
+	case MSR_GS_BASE:
+		msr_info->data = svm->vmcb01.ptr->save.gs.base;
+		break;
+	case MSR_FS_BASE:
+		msr_info->data = svm->vmcb01.ptr->save.fs.base;
+		break;
 	case MSR_KERNEL_GS_BASE:
 		msr_info->data = svm->vmcb01.ptr->save.kernel_gs_base;
 		break;
@@ -2923,6 +2932,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_CSTAR:
 		svm->vmcb01.ptr->save.cstar = data;
 		break;
+	case MSR_GS_BASE:
+		svm->vmcb01.ptr->save.gs.base = data;
+		break;
+	case MSR_FS_BASE:
+		svm->vmcb01.ptr->save.fs.base = data;
+		break;
 	case MSR_KERNEL_GS_BASE:
 		svm->vmcb01.ptr->save.kernel_gs_base = data;
 		break;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 189b242d3e89..f39f360eb779 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_text)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
@@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 	if (!pmd)
 		return NULL;
 
-	/* We can't do anything sensible if we hit a large mapping. */
+	/* Large PMD mapping found */
 	if (pmd_large(*pmd)) {
-		WARN_ON(1);
-		return NULL;
+		/* Clear the PMD if we hit a large mapping from the first round */
+		if (late_text) {
+			set_pmd(pmd, __pmd(0));
+		} else {
+			WARN_ON_ONCE(1);
+			return NULL;
+		}
 	}
 
 	if (pmd_none(*pmd)) {
@@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(void)
 	if (!pte || WARN_ON(level != PG_LEVEL_4K) || pte_none(*pte))
 		return;
 
-	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
+	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
 	if (WARN_ON(!target_pte))
 		return;
 
@@ -301,7 +306,7 @@ enum pti_clone_level {
 
 static void
 pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+		  enum pti_clone_level level, bool late_text)
 {
 	unsigned long addr;
 
@@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 				return;
 
 			/* Allocate PTE in the user page-table */
-			target_pte = pti_user_pagetable_walk_pte(addr);
+			target_pte = pti_user_pagetable_walk_pte(addr, late_text);
 			if (WARN_ON(!target_pte))
 				return;
 
@@ -452,7 +457,7 @@ static void __init pti_clone_user_shared(void)
 		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
 		pte_t *target_pte;
 
-		target_pte = pti_user_pagetable_walk_pte(va);
+		target_pte = pti_user_pagetable_walk_pte(va, false);
 		if (WARN_ON(!target_pte))
 			return;
 
@@ -475,7 +480,7 @@ static void __init pti_clone_user_shared(void)
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -492,11 +497,11 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry text and force it RO.
  */
-static void pti_clone_entry_text(void)
+static void pti_clone_entry_text(bool late)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_LEVEL_KERNEL_IMAGE);
+			  PTI_LEVEL_KERNEL_IMAGE, late);
 }
 
 /*
@@ -571,7 +576,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
 
 	/*
 	 * pti_clone_pgtable() will set the global bit in any PMDs
@@ -638,8 +643,15 @@ void __init pti_init(void)
 
 	/* Undo all global bits from the init pagetables in head_64.S: */
 	pti_set_kernel_image_nonglobal();
+
 	/* Replace some of the global bits just for shared entry text: */
-	pti_clone_entry_text();
+	/*
+	 * This is very early in boot. Device and Late initcalls can do
+	 * modprobe before free_initmem() and mark_readonly(). This
+	 * pti_clone_entry_text() allows those user-mode-helpers to function,
+	 * but notably the text is still RW.
+	 */
+	pti_clone_entry_text(false);
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
@@ -656,10 +668,11 @@ void pti_finalize(void)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 	/*
-	 * We need to clone everything (again) that maps parts of the
-	 * kernel image.
+	 * This is after free_initmem() (all initcalls are done) and we've done
+	 * mark_readonly(). Text is now NX which might've split some PMDs
+	 * relative to the early clone.
 	 */
-	pti_clone_entry_text();
+	pti_clone_entry_text(true);
 	pti_clone_kernel_text();
 
 	debug_checkwx_user();
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 16d5d5338392..85edf6614b97 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -431,8 +431,6 @@ void blk_integrity_unregister(struct gendisk *disk)
 	if (!bi->profile)
 		return;
 
-	/* ensure all bios are off the integrity workqueue */
-	blk_flush_integrity();
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 6737b1cbf6d6..8bd5c4fa91f2 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -373,7 +373,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 	result = acpi_processor_get_info(device);
 	if (result) /* Processor is not physically present or unavailable */
-		return 0;
+		goto err_clear_driver_data;
 
 	BUG_ON(pr->id >= nr_cpu_ids);
 
@@ -388,7 +388,7 @@ static int acpi_processor_add(struct acpi_device *device,
 			"BIOS reported wrong ACPI id %d for the processor\n",
 			pr->id);
 		/* Give up, but do not abort the namespace scan. */
-		goto err;
+		goto err_clear_driver_data;
 	}
 	/*
 	 * processor_device_array is not cleared on errors to allow buggy BIOS
@@ -400,12 +400,12 @@ static int acpi_processor_add(struct acpi_device *device,
 	dev = get_cpu_device(pr->id);
 	if (!dev) {
 		result = -ENODEV;
-		goto err;
+		goto err_clear_per_cpu;
 	}
 
 	result = acpi_bind_one(dev, device);
 	if (result)
-		goto err;
+		goto err_clear_per_cpu;
 
 	pr->dev = dev;
 
@@ -416,10 +416,11 @@ static int acpi_processor_add(struct acpi_device *device,
 	dev_err(dev, "Processor driver could not be attached\n");
 	acpi_unbind_one(dev);
 
- err:
-	free_cpumask_var(pr->throttling.shared_cpu_map);
-	device->driver_data = NULL;
+ err_clear_per_cpu:
 	per_cpu(processors, pr->id) = NULL;
+ err_clear_driver_data:
+	device->driver_data = NULL;
+	free_cpumask_var(pr->throttling.shared_cpu_map);
  err_free_pr:
 	kfree(pr);
 	return result;
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 269d314e73a7..869ab2e8e42c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3173,6 +3173,7 @@ static void binder_transaction(struct binder_proc *proc,
 		 */
 		copy_size = object_offset - user_offset;
 		if (copy_size && (user_offset > object_offset ||
+				object_offset > tr->data_size ||
 				binder_alloc_copy_user_to_buffer(
 					&target_proc->alloc,
 					t->buffer, user_offset,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8c85d2250899..3df057d381a7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5454,8 +5454,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		kfree(host);
 		goto err_out;
+	}
 
 	devres_add(dev, dr);
 	dev_set_drvdata(dev, host);
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index be0ca8d5b345..eacebfc2ca08 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -540,7 +540,8 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 
 		while (sg_len) {
 			/* table overflow should never happen */
-			BUG_ON (pi++ >= MAX_DCMDS);
+			if (WARN_ON_ONCE(pi >= MAX_DCMDS))
+				return AC_ERR_SYSTEM;
 
 			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
 			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
@@ -552,11 +553,13 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 			addr += len;
 			sg_len -= len;
 			++table;
+			++pi;
 		}
 	}
 
 	/* Should never happen according to Tejun */
-	BUG_ON(!pi);
+	if (WARN_ON_ONCE(!pi))
+		return AC_ERR_SYSTEM;
 
 	/* Convert the last command to an input/output */
 	table--;
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 27a43b4960f5..d3f59028dec7 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -562,6 +562,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 5e44ceb730ad..6426d933153d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -38,7 +38,7 @@
 
 #define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
 # define PLL_POST_DIV_SHIFT	8
-# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width, 0)
+# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width - 1, 0)
 # define PLL_ALPHA_EN		BIT(24)
 # define PLL_ALPHA_MODE		BIT(25)
 # define PLL_VCO_SHIFT		20
@@ -1362,8 +1362,8 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	return regmap_update_bits(regmap, PLL_USER_CTL(pll),
-				  PLL_POST_DIV_MASK(pll) << PLL_POST_DIV_SHIFT,
-				  val << PLL_POST_DIV_SHIFT);
+				  PLL_POST_DIV_MASK(pll) << pll->post_div_shift,
+				  val << pll->post_div_shift);
 }
 
 const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 2cdc077a39f5..9f0aeda4031f 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -83,20 +83,28 @@ static u64 notrace tpm_read_sched_clock(void)
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
-	unsigned long next, now;
+	unsigned long next, prev, now;
 
-	next = tpm_read_counter();
-	next += delta;
+	prev = tpm_read_counter();
+	next = prev + delta;
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
+	/*
+	 * Need to wait CNT increase at least 1 cycle to make sure
+	 * the C0V has been updated into HW.
+	 */
+	if ((next & 0xffffffff) != readl(timer_base + TPM_C0V))
+		while (now == tpm_read_counter())
+			;
+
 	/*
 	 * NOTE: We observed in a very small probability, the bus fabric
 	 * contention between GPU and A7 may results a few cycles delay
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)(next - now) <= 0 ? -ETIME : 0;
+	return (now - prev) >= delta ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9912be..420202bf76e4 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -25,10 +25,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
 
 	struct clock_event_device *clkevt = &to->clkevt;
 
-	if (of_irq->percpu)
-		free_percpu_irq(of_irq->irq, clkevt);
-	else
-		free_irq(of_irq->irq, clkevt);
+	free_irq(of_irq->irq, clkevt);
 }
 
 /**
@@ -42,9 +39,6 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  * - Get interrupt number by name
  * - Get interrupt number by index
  *
- * When the interrupt is per CPU, 'request_percpu_irq()' is called,
- * otherwise 'request_irq()' is used.
- *
  * Returns 0 on success, < 0 otherwise
  */
 static __init int timer_of_irq_init(struct device_node *np,
@@ -69,12 +63,9 @@ static __init int timer_of_irq_init(struct device_node *np,
 		return -EINVAL;
 	}
 
-	ret = of_irq->percpu ?
-		request_percpu_irq(of_irq->irq, of_irq->handler,
-				   np->full_name, clkevt) :
-		request_irq(of_irq->irq, of_irq->handler,
-			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
-			    np->full_name, clkevt);
+	ret = request_irq(of_irq->irq, of_irq->handler,
+			  of_irq->flags ? of_irq->flags : IRQF_TIMER,
+			  np->full_name, clkevt);
 	if (ret) {
 		pr_err("Failed to request irq %d for %pOF\n", of_irq->irq, np);
 		return ret;
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3e8589..01a2c6b7db06 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -11,7 +11,6 @@
 struct of_timer_irq {
 	int irq;
 	int index;
-	int percpu;
 	const char *name;
 	unsigned long flags;
 	irq_handler_t handler;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index c24e6373d341..eb3f1952f986 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -61,9 +61,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
+	unsigned long freq = target_freq;
 
-	if (!perf_ops->freq_set(ph, priv->domain_id,
-				target_freq * 1000, true))
+	if (!perf_ops->freq_set(ph, priv->domain_id, freq * 1000, true))
 		return target_freq;
 
 	return 0;
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index a197f698efeb..d331745da1a3 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -708,6 +708,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	pctldev = of_pinctrl_get(pctlnp);
+	of_node_put(pctlnp);
 	if (!pctldev)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
index a4d65973bf7c..80771b1480ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
@@ -100,6 +100,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
 	amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
 	amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz, 44100);
 	amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
+	res.clock = clock;
 
 	return res;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 96b7bb13a2dd..07b1d2460a85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1475,6 +1475,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index f1a050379190..682de88cf91f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 300d3b236bb3..042f27af6856 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4406,7 +4406,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		shadow = vmbo->shadow;
 
 		/* No need to recover an evicted BO */
-		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
+		if (!shadow->tbo.resource ||
+		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 11413b3e80c5..1f7ddb65383d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -842,8 +842,7 @@ static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
 {
 	u64 micro_tile_mode;
 
-	/* Zero swizzle mode means linear */
-	if (AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0)
+	if (AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) == 1) /* LINEAR_ALIGNED */
 		return 0;
 
 	micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 4d9eb0137f8c..48652c2a17cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -177,7 +177,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
  * Returns the number of bytes read/written; -errno on error.
  */
 static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
-			      u8 *eeprom_buf, u16 buf_size, bool read)
+			      u8 *eeprom_buf, u32 buf_size, bool read)
 {
 	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
 	u16 limit;
@@ -224,7 +224,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes)
+		       u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  true);
@@ -232,7 +232,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes)
+			u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 6935adb2be1f..8083b8253ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -28,10 +28,10 @@
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes);
+		       u32 bytes);
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes);
+			u32 bytes);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f305a0f8e9b9..a8b7f0aeacf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1178,6 +1178,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
+	if (WARN_ON(!hive))
+		return;
+
 	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
 		struct psp_xgmi_topology_info *mirror_top_info;
 		int j;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 0554576d3695..de05b7f864f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -263,7 +263,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
@@ -367,8 +367,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	loff_t i;
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b508126a9738..59007024aafe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -122,8 +122,10 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 
 	if (virt->ops && virt->ops->req_full_gpu) {
 		r = virt->ops->req_full_gpu(adev, init);
-		if (r)
+		if (r) {
+			adev->no_hw_access = true;
 			return r;
+		}
 
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 	}
@@ -410,6 +412,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
 
+	memset(&bp, 0, sizeof(bp));
+
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
@@ -584,7 +588,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
-		vf2pf_info, vf2pf_info->header.size, 0, 0);
+		vf2pf_info, sizeof(*vf2pf_info), 0, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index 2d01ac0d4c11..2f5af5ddc5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
+	if (fb_channel_number >= ARRAY_SIZE(df_v1_7_channel_number))
+		fb_channel_number = 0;
 
 	return df_v1_7_channel_number[fb_channel_number];
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 74cd7543729b..af1ca5cbc2fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -370,7 +370,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index d54ceebd346b..30c70b3ab17f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -42,8 +42,6 @@
 #define CRAT_OEMTABLEID_LENGTH	8
 #define CRAT_RESERVED_LENGTH	6
 
-#define CRAT_OEMID_64BIT_MASK ((1ULL << (CRAT_OEMID_LENGTH * 8)) - 1)
-
 /* Compute Unit flags */
 #define COMPUTE_UNIT_CPU	(1 << 0)  /* Create Virtual CRAT for CPU */
 #define COMPUTE_UNIT_GPU	(1 << 1)  /* Create Virtual CRAT for GPU */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 98cca5f2b27f..59e7ca0e8470 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -910,8 +910,7 @@ static void kfd_update_system_properties(void)
 	dev = list_last_entry(&topology_device_list,
 			struct kfd_topology_device, list);
 	if (dev) {
-		sys_props.platform_id =
-			(*((uint64_t *)dev->oem_id)) & CRAT_OEMID_64BIT_MASK;
+		sys_props.platform_id = dev->oem_id64;
 		sys_props.platform_oem = *((uint64_t *)dev->oem_table_id);
 		sys_props.platform_rev = dev->oem_revision;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index a8db017c9b8e..c2dbd75b9161 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -184,7 +184,10 @@ struct kfd_topology_device {
 	struct attribute		attr_gpuid;
 	struct attribute		attr_name;
 	struct attribute		attr_props;
-	uint8_t				oem_id[CRAT_OEMID_LENGTH];
+	union {
+		uint8_t				oem_id[CRAT_OEMID_LENGTH];
+		uint64_t			oem_id64;
+	};
 	uint8_t				oem_table_id[CRAT_OEMTABLEID_LENGTH];
 	uint32_t			oem_revision;
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 333be0541893..b4ae90c3ed23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4211,7 +4211,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
-	ASSERT(primary_planes <= AMDGPU_MAX_PLANES);
+	if (primary_planes > AMDGPU_MAX_PLANES) {
+		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * Initialize primary planes, implicit planes for legacy IOCTLS.
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 6185f9475fa2..afce8f3bc67a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -489,7 +489,8 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 			ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 
 			/* Modify previous watermark range to cover up to max */
-			ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+			if (num_valid_sets > 0)
+				ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 		}
 		num_valid_sets++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ef151a1bc31c..12e4beca5e84 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1107,6 +1107,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index 880954ac0b02..1b3cba5b1d74 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -690,6 +690,9 @@ static void wbscl_set_scaler_filter(
 	int pair;
 	uint16_t odd_coef, even_coef;
 
+	if (!filter)
+		return;
+
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index dae8e489c8cf..a5de27908914 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -58,7 +58,7 @@ struct gpio_service *dal_gpio_service_create(
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
-	uint32_t index_of_id;
+	int32_t index_of_id;
 
 	service = kzalloc(sizeof(struct gpio_service), GFP_KERNEL);
 
@@ -114,7 +114,7 @@ struct gpio_service *dal_gpio_service_create(
 	return service;
 
 failure_2:
-	while (index_of_id) {
+	while (index_of_id > 0) {
 		--index_of_id;
 		kfree(service->busyness[index_of_id]);
 	}
@@ -241,6 +241,9 @@ static bool is_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return false;
+
 	return service->busyness[id][en];
 }
 
@@ -249,6 +252,9 @@ static void set_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = true;
 }
 
@@ -257,6 +263,9 @@ static void set_pin_free(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = false;
 }
 
@@ -265,7 +274,7 @@ enum gpio_result dal_gpio_service_lock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
@@ -279,7 +288,7 @@ enum gpio_result dal_gpio_service_unlock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 4233955e3c47..c9851492ec84 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -131,13 +131,21 @@ static bool hdmi_14_process_transaction(
 	const uint8_t hdcp_i2c_addr_link_primary = 0x3a; /* 0x74 >> 1*/
 	const uint8_t hdcp_i2c_addr_link_secondary = 0x3b; /* 0x76 >> 1*/
 	struct i2c_command i2c_command;
-	uint8_t offset = hdcp_i2c_offsets[message_info->msg_id];
+	uint8_t offset;
 	struct i2c_payload i2c_payloads[] = {
-		{ true, 0, 1, &offset },
+		{ true, 0, 1, 0 },
 		/* actual hdcp payload, will be filled later, zeroed for now*/
 		{ 0 }
 	};
 
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
+	offset = hdcp_i2c_offsets[message_info->msg_id];
+	i2c_payloads[0].data = &offset;
+
 	switch (message_info->link) {
 	case HDCP_LINK_SECONDARY:
 		i2c_payloads[0].address = hdcp_i2c_addr_link_secondary;
@@ -311,6 +319,11 @@ static bool dp_11_process_transaction(
 	struct dc_link *link,
 	struct hdcp_protection_message *message_info)
 {
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
 	return dpcd_access_helper(
 		link,
 		message_info->length,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 6ec918af3bff..119b00aadd9a 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -433,17 +433,20 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 	}
 
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+		if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
 				&input->bstatus_read, &status,
-				hdcp, "bstatus_read");
+				hdcp, "bstatus_read"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_link_integrity_dp,
+		if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
 				&input->link_integrity_check, &status,
-				hdcp, "link_integrity_check");
+				hdcp, "link_integrity_check"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+		if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 				&input->reauth_request_check, &status,
-				hdcp, "reauth_request_check");
+				hdcp, "reauth_request_check"))
+			goto out;
 out:
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 8e9caae7c955..1b2df97226a3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,11 +156,16 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.read_dpcd(hdcp->config.ddc.handle,
@@ -175,6 +180,11 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		success = hdcp->config.ddc.funcs.read_i2c(
 				hdcp->config.ddc.handle,
 				HDCP_I2C_ADDR,
@@ -219,11 +229,16 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.write_dpcd(
@@ -239,6 +254,11 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		hdcp->buf[0] = hdcp_i2c_offsets[msg_id];
 		memmove(&hdcp->buf[1], buf, buf_len);
 		success = hdcp->config.ddc.funcs.write_i2c(
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 1d829402cd2e..59b18395983a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
 	unsigned int i;
-	unsigned int table_entries;
 	struct pp_power_state *state;
-	int size;
+	int size, table_entries;
 
 	if (hwmgr->hwmgr_func->get_num_of_pp_table_entries == NULL)
 		return 0;
@@ -40,15 +39,19 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	if (hwmgr->hwmgr_func->get_power_state_size == NULL)
 		return 0;
 
-	hwmgr->num_ps = table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
+	table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
 
-	hwmgr->ps_size = size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
+	size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
 					  sizeof(struct pp_power_state);
 
-	if (table_entries == 0 || size == 0) {
+	if (table_entries <= 0 || size == 0) {
 		pr_warn("Please check whether power state management is supported on this asic\n");
+		hwmgr->num_ps = 0;
+		hwmgr->ps_size = 0;
 		return 0;
 	}
+	hwmgr->num_ps = table_entries;
+	hwmgr->ps_size = size;
 
 	hwmgr->ps = kcalloc(table_entries, size, GFP_KERNEL);
 	if (hwmgr->ps == NULL)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index f503e61faa60..cc3b62f73394 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
 					j++;
 				} else if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
-					table->mc_reg_table_entry[num_ranges].mc_data[i] =
-						table->mc_reg_table_entry[num_ranges].mc_data[i-1];
+					if (i)
+						table->mc_reg_table_entry[num_ranges].mc_data[i] =
+							table->mc_reg_table_entry[num_ranges].mc_data[i-1];
 				}
 			}
 			num_ranges++;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index cf74621f94a7..0a216b4fd185 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1026,7 +1026,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	switch (type) {
 	case PP_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		if (ret)
+			return ret;
 
 	/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 		if (now == data->gfx_max_freq_limit/100)
@@ -1047,7 +1049,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					i == 2 ? "*" : "");
 		break;
 	case PP_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		if (ret)
+			return ret;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -1547,7 +1551,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		}
 
 		if (input[0] == 0) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] < min_freq) {
 				pr_err("Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
 					input[1], min_freq);
@@ -1555,7 +1562,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			}
 			smu10_data->gfx_actual_soft_min_freq = input[1];
 		} else if (input[0] == 1) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] > max_freq) {
 				pr_err("Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
 					input[1], max_freq);
@@ -1570,10 +1580,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			pr_err("Input parameter number not correct\n");
 			return -EINVAL;
 		}
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
-
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+		if (ret)
+			return ret;
 		smu10_data->gfx_actual_soft_min_freq = min_freq;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+		if (ret)
+			return ret;
+
 		smu10_data->gfx_actual_soft_max_freq = max_freq;
 	} else if (type == PP_OD_COMMIT_DPM_TABLE) {
 		if (size != 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9c7c3c06327d..2d1f37aefdbd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5597,7 +5597,7 @@ static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint
 	mode = input[size];
 	switch (mode) {
 	case PP_SMC_POWER_PROFILE_CUSTOM:
-		if (size < 8 && size != 0)
+		if (size != 8 && size != 0)
 			return -EINVAL;
 		/* If only CUSTOM is passed in, use the saved values. Check
 		 * that we actually have a CUSTOM profile by ensuring that
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index f0f8ebffd9f2..c1887c21c7ab 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -584,6 +584,7 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -591,7 +592,9 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
 	data->uvd_dpm.soft_min_clk = 0;
 	data->uvd_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].vclk;
@@ -611,6 +614,7 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.vce_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -618,7 +622,9 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
 	data->vce_dpm.soft_min_clk = 0;
 	data->vce_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].ecclk;
@@ -638,6 +644,7 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.acp_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -645,7 +652,9 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
 	data->acp_dpm.soft_min_clk = 0;
 	data->acp_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].acpclk;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index aba8904ac75f..69d9c82282a0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -355,13 +355,13 @@ static int vega10_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
-	int i;
 	uint32_t sub_vendor_id, hw_revision;
 	uint32_t top32, bottom32;
 	struct amdgpu_device *adev = hwmgr->adev;
+	int ret, i;
 
 	vega10_initialize_power_tune_defaults(hwmgr);
 
@@ -486,9 +486,12 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	if (data->registry_data.vr0hot_enabled)
 		data->smu_features[GNLD_VR0HOT].supported = true;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetSmuVersion,
 			&hwmgr->smu_version);
+	if (ret)
+		return ret;
+
 		/* ACG firmware has major version 5 */
 	if ((hwmgr->smu_version & 0xff000000) == 0x5000000)
 		data->smu_features[GNLD_ACG].supported = true;
@@ -506,10 +509,16 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 		data->smu_features[GNLD_PCC_LIMIT].supported = true;
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+	return 0;
 }
 
 #ifdef PPLIB_VEGA10_EVV_SUPPORT
@@ -883,7 +892,9 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega10_set_features_platform_caps(hwmgr);
 
-	vega10_init_dpm_defaults(hwmgr);
+	result = vega10_init_dpm_defaults(hwmgr);
+	if (result)
+		return result;
 
 #ifdef PPLIB_VEGA10_EVV_SUPPORT
 	/* Get leakage voltage based on leakage ID. */
@@ -2354,15 +2365,20 @@ static int vega10_acg_enable(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	uint32_t agc_btc_response;
+	int ret;
 
 	if (data->smu_features[GNLD_ACG].supported) {
 		if (0 == vega10_enable_smc_features(hwmgr, true,
 					data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_bitmap))
 			data->smu_features[GNLD_DPM_PREFETCHER].enabled = true;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		if (ret)
+			return ret;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		if (ret)
+			agc_btc_response = 0;
 
 		if (1 == agc_btc_response) {
 			if (1 == data->acg_loop_state)
@@ -2575,8 +2591,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 		}
 	}
 
-	pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
+	result = pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
 			VOLTAGE_OBJ_SVID2,  &voltage_table);
+	PP_ASSERT_WITH_CODE(!result,
+			"Failed to get voltage table!",
+			return result);
 	pp_table->MaxVidStep = voltage_table.max_vid_step;
 
 	pp_table->GfxDpmVoltageMode =
@@ -3396,13 +3415,17 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	uint32_t sclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].gfx_clock;
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	uint32_t mclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].mem_clock;
+	uint32_t sclk, mclk;
 	uint32_t i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+	sclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].gfx_clock;
+	mclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].mem_clock;
+
 	for (i = 0; i < sclk_table->count; i++) {
 		if (sclk == sclk_table->dpm_levels[i].value)
 			break;
@@ -3709,6 +3732,9 @@ static int vega10_generate_dpm_level_enable_mask(
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -3881,11 +3907,14 @@ static int vega10_get_gpu_power(struct pp_hwmgr *hwmgr,
 		uint32_t *query)
 {
 	uint32_t value;
+	int ret;
 
 	if (!query)
 		return -EINVAL;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr, &value);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr, &value);
+	if (ret)
+		return ret;
 
 	/* SMC returning actual watts, keep consistent with legacy asics, low 8 bit as 8 fractional bits */
 	*query = value << 8;
@@ -4640,14 +4669,16 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
 	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 
-	int i, now, size = 0, count = 0;
+	int i, ret, now,  size = 0, count = 0;
 
 	switch (type) {
 	case PP_SCLK:
 		if (data->registry_data.sclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		if (ret)
+			break;
 
 		if (hwmgr->pp_one_vf &&
 		    (hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
@@ -4663,7 +4694,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.mclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4674,7 +4707,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.socclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < soc_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4685,8 +4720,10 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.dcefclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc_with_parameter(hwmgr,
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < dcef_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4835,6 +4872,9 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 
 	psa = cast_const_phw_vega10_power_state(pstate1);
 	psb = cast_const_phw_vega10_power_state(pstate2);
+	if (psa == NULL || psb == NULL)
+		return -EINVAL;
+
 	/* If the two states don't even have the same number of performance levels they cannot be the same state. */
 	if (psa->performance_level_count != psb->performance_level_count) {
 		*equal = false;
@@ -4960,6 +5000,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5011,6 +5053,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5248,6 +5292,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5270,6 +5317,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5460,6 +5510,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	ps = cast_const_phw_vega10_power_state(state);
+	if (ps == NULL)
+		return -EINVAL;
 
 	i = index > ps->performance_level_count - 1 ?
 			ps->performance_level_count - 1 : index;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index a2f4d6773d45..95ef9419c83e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -294,12 +294,12 @@ static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega12_hwmgr *data = (struct vega12_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t top32, bottom32;
-	int i;
+	int i, ret;
 
 	data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =
 			FEATURE_DPM_PREFETCHER_BIT;
@@ -365,10 +365,16 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+
+	return 0;
 }
 
 static int vega12_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
@@ -411,7 +417,11 @@ static int vega12_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega12_set_features_platform_caps(hwmgr);
 
-	vega12_init_dpm_defaults(hwmgr);
+	result = vega12_init_dpm_defaults(hwmgr);
+	if (result) {
+		pr_err("%s failed\n", __func__);
+		return result;
+	}
 
 	/* Parse pptable data read from VBIOS */
 	vega12_set_private_data_based_on_pptable(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 299b5c838bf7..b55a68ce7238 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -329,12 +329,12 @@ static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t top32, bottom32;
-	int i;
+	int i, ret;
 
 	data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =
 			FEATURE_DPM_PREFETCHER_BIT;
@@ -405,10 +405,17 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+
+	return 0;
 }
 
 static int vega20_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
@@ -428,6 +435,7 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data;
 	struct amdgpu_device *adev = hwmgr->adev;
+	int result;
 
 	data = kzalloc(sizeof(struct vega20_hwmgr), GFP_KERNEL);
 	if (data == NULL)
@@ -453,8 +461,11 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega20_set_features_platform_caps(hwmgr);
 
-	vega20_init_dpm_defaults(hwmgr);
-
+	result = vega20_init_dpm_defaults(hwmgr);
+	if (result) {
+		pr_err("%s failed\n", __func__);
+		return result;
+	}
 	/* Parse pptable data read from VBIOS */
 	vega20_set_private_data_based_on_pptable(hwmgr);
 
@@ -4098,9 +4109,11 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-		if (size == 0 && !data->is_custom_profile_set)
+
+		if (size != 10 && size != 0)
 			return -EINVAL;
-		if (size < 10 && size != 0)
+
+		if (size == 0 && !data->is_custom_profile_set)
 			return -EINVAL;
 
 		result = vega20_get_activity_monitor_coeff(hwmgr,
@@ -4162,6 +4175,8 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		result = vega20_set_activity_monitor_coeff(hwmgr,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index a70d73896649..f9c0f117725d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -130,13 +130,17 @@ int vega10_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 			    uint64_t *features_enabled)
 {
 	uint32_t enabled_features;
+	int ret;
 
 	if (features_enabled == NULL)
 		return -EINVAL;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeatures,
 			&enabled_features);
+	if (ret)
+		return ret;
+
 	*features_enabled = enabled_features;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d0c6b864d00a..31846510c1a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1775,7 +1775,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_GfxDeviceDriverReset);
-
+	if (index < 0 )
+		return -EINVAL;
 	mutex_lock(&smu->message_lock);
 	if (smu_version >= 0x00441400) {
 		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4c6f3052156b..3436d39c90b4 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1527,7 +1527,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
 
-	if (tc->hpd_pin >= 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >= 0 && tc->bridge.dev && tc->aux.drm_dev) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 43de9dfcba19..f1091cb87de0 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -318,6 +318,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OrangePi Neo */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index c589a681da77..cce8a7be11f2 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -49,7 +49,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 	debug_object_init(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 	debug_object_init_on_stack(fence, &i915_sw_fence_debug_descr);
 }
@@ -75,7 +75,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 	debug_object_destroy(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 	debug_object_free(fence, &i915_sw_fence_debug_descr);
 	smp_wmb(); /* flush the change in state before reallocation */
@@ -92,7 +92,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 }
 
@@ -113,7 +113,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 }
 
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 44aa52629443..c17abaf9b54d 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -533,6 +533,7 @@ int meson_plane_create(struct meson_drm *priv)
 	struct meson_plane *meson_plane;
 	struct drm_plane *plane;
 	const uint64_t *format_modifiers = format_modifiers_default;
+	int ret;
 
 	meson_plane = devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
 				   GFP_KERNEL);
@@ -547,12 +548,16 @@ int meson_plane_create(struct meson_drm *priv)
 	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
 		format_modifiers = format_modifiers_afbc_g12a;
 
-	drm_universal_plane_init(priv->drm, plane, 0xFF,
-				 &meson_plane_funcs,
-				 supported_drm_formats,
-				 ARRAY_SIZE(supported_drm_formats),
-				 format_modifiers,
-				 DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	ret = drm_universal_plane_init(priv->drm, plane, 0xFF,
+					&meson_plane_funcs,
+					supported_drm_formats,
+					ARRAY_SIZE(supported_drm_formats),
+					format_modifiers,
+					DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	if (ret) {
+		devm_kfree(priv->drm->dev, meson_plane);
+		return ret;
+	}
 
 	drm_plane_helper_add(plane, &meson_plane_helper_funcs);
 
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
index 3b0615c6aecf..b47228207d98 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
@@ -164,11 +164,13 @@ int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
 void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
 {
 	int i;
+	struct amdtp_hid_data *hid_data;
 
 	for (i = 0; i < cli_data->num_hid_devices; ++i) {
 		if (cli_data->hid_sensor_hubs[i]) {
-			kfree(cli_data->hid_sensor_hubs[i]->driver_data);
+			hid_data = cli_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(cli_data->hid_sensor_hubs[i]);
+			kfree(hid_data);
 			cli_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index 28d671c5e0ca..d173b13ff198 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -106,7 +106,7 @@ static void cougar_fix_g6_mapping(void)
 static __u8 *cougar_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				 unsigned int *rsize)
 {
-	if (rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
+	if (*rsize >= 117 && rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
 	    (rdesc[115] | rdesc[116] << 8) >= HID_MAX_USAGES) {
 		hid_info(hdev,
 			"usage count exceeds max: fixing up report descriptor\n");
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 115835bd562c..02aeb192e367 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2008,6 +2008,7 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 
 	return attr->mode;
 }
+EXPORT_SYMBOL_GPL(vmbus_device_unregister);
 
 static struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index fd938c70293f..739cd48228d4 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -176,7 +176,7 @@ static ssize_t adc128_in_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	/* 10 mV LSB on limit registers */
-	regval = clamp_val(DIV_ROUND_CLOSEST(val, 10), 0, 255);
+	regval = DIV_ROUND_CLOSEST(clamp_val(val, 0, 2550), 10);
 	data->in[index][nr] = regval << 4;
 	reg = index == 1 ? ADC128_REG_IN_MIN(nr) : ADC128_REG_IN_MAX(nr);
 	i2c_smbus_write_byte_data(data->client, reg, regval);
@@ -214,7 +214,7 @@ static ssize_t adc128_temp_store(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	regval = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	regval = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 	data->temp[index] = regval << 1;
 	i2c_smbus_write_byte_data(data->client,
 				  index == 1 ? ADC128_REG_TEMP_MAX
diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index ac169a994ae0..db2aecdfbd17 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -301,7 +301,8 @@ static ssize_t tcrit2_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, index ? 255 : 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, (index ? 255 : 127) * 1000),
+				1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit2[index] = val;
@@ -350,7 +351,7 @@ static ssize_t tcrit1_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit1[index] = val;
@@ -391,7 +392,7 @@ static ssize_t tcrit1_hyst_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -255000, 255000), 1000);
 	val = clamp_val((int)data->tcrit1[index] - val, 0, 31);
 
 	mutex_lock(&data->update_lock);
@@ -431,7 +432,7 @@ static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	/* Accuracy is 1/2 degrees C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 500), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -64000, 63500), 500);
 
 	mutex_lock(&data->update_lock);
 	data->toffset[index] = val;
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5bd15622a85f..3645a19cdaf4 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -2374,7 +2374,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 705a59663d42..b6bae04d656e 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -895,7 +895,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -920,7 +920,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	reg = w83627ehf_read_value(data, W83627EHF_REG_TOLERANCE[nr]);
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index fd5f5c5a5244..425597151dd3 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -302,6 +302,34 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 }
 EXPORT_SYMBOL_GPL(__hwspin_unlock);
 
+/**
+ * hwspin_lock_bust() - bust a specific hwspinlock
+ * @hwlock: a previously-acquired hwspinlock which we want to bust
+ * @id: identifier of the remote lock holder, if applicable
+ *
+ * This function will bust a hwspinlock that was previously acquired as
+ * long as the current owner of the lock matches the id given by the caller.
+ *
+ * Context: Process context.
+ *
+ * Returns: 0 on success, or -EINVAL if the hwspinlock does not exist, or
+ * the bust operation fails, and -EOPNOTSUPP if the bust operation is not
+ * defined for the hwspinlock.
+ */
+int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
+{
+	if (WARN_ON(!hwlock))
+		return -EINVAL;
+
+	if (!hwlock->bank->ops->bust) {
+		pr_err("bust operation not defined\n");
+		return -EOPNOTSUPP;
+	}
+
+	return hwlock->bank->ops->bust(hwlock, id);
+}
+EXPORT_SYMBOL_GPL(hwspin_lock_bust);
+
 /**
  * of_hwspin_lock_simple_xlate - translate hwlock_spec to return a lock id
  * @bank: the hwspinlock device bank
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index 29892767bb7a..f298fc0ee5ad 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -21,6 +21,8 @@ struct hwspinlock_device;
  * @trylock: make a single attempt to take the lock. returns 0 on
  *	     failure and true on success. may _not_ sleep.
  * @unlock:  release the lock. always succeed. may _not_ sleep.
+ * @bust:    optional, platform-specific bust handler, called by hwspinlock
+ *	     core to bust a specific lock.
  * @relax:   optional, platform-specific relax handler, called by hwspinlock
  *	     core while spinning on a lock, between two successive
  *	     invocations of @trylock. may _not_ sleep.
@@ -28,6 +30,7 @@ struct hwspinlock_device;
 struct hwspinlock_ops {
 	int (*trylock)(struct hwspinlock *lock);
 	void (*unlock)(struct hwspinlock *lock);
+	int (*bust)(struct hwspinlock *lock, unsigned int id);
 	void (*relax)(struct hwspinlock *lock);
 };
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 5e3f0ee1cfd0..b9b6be186438 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -291,7 +291,10 @@ static int hci_dma_init(struct i3c_hci *hci)
 
 		rh->ibi_chunk_sz = dma_get_cache_alignment();
 		rh->ibi_chunk_sz *= IBI_CHUNK_CACHELINES;
-		BUG_ON(rh->ibi_chunk_sz > 256);
+		if (rh->ibi_chunk_sz > 256) {
+			ret = -EINVAL;
+			goto err_out;
+		}
 
 		ibi_status_ring_sz = rh->ibi_status_sz * rh->ibi_status_entries;
 		ibi_data_ring_sz = rh->ibi_chunk_sz * rh->ibi_chunks_total;
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 101f2da2811b..471e1311e007 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -144,15 +144,18 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	enum ad7124_ref_sel refsel;
-	bool bipolar;
-	bool buf_positive;
-	bool buf_negative;
-	unsigned int vref_mv;
-	unsigned int pga_bits;
-	unsigned int odr;
-	unsigned int odr_sel_bits;
-	unsigned int filter_type;
+	/* Following fields are used to compare equality. */
+	struct_group(config_props,
+		enum ad7124_ref_sel refsel;
+		bool bipolar;
+		bool buf_positive;
+		bool buf_negative;
+		unsigned int vref_mv;
+		unsigned int pga_bits;
+		unsigned int odr;
+		unsigned int odr_sel_bits;
+		unsigned int filter_type;
+	);
 };
 
 struct ad7124_channel {
@@ -331,11 +334,12 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = (u8 *)&cfg->live - (u8 *)cfg;
+	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live && !memcmp(cfg, cfg_aux, cmp_size))
+		if (cfg_aux->live &&
+		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
 			return cfg_aux;
 	}
 
@@ -686,6 +690,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	if (ret < 0)
 		return ret;
 
+	fsleep(200);
 	timeout = 100;
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 1ac94c4e9792..cb77d26fa1b7 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -180,7 +180,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_free;
+		goto err_release;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -206,6 +206,8 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
+err_release:
+	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index bf9ce01c854b..16f25a2bede7 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -629,17 +629,17 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000LL);
 		break;
 	case IIO_VAL_INT_PLUS_NANO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000000LL);
 		break;
diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 0d523ad736c7..462908022091 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -398,8 +398,8 @@ static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue
 	return comp_ctx;
 }
 
-static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
-						   struct efa_admin_acq_entry *cqe)
+static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
+						  struct efa_admin_acq_entry *cqe)
 {
 	struct efa_comp_ctx *comp_ctx;
 	u16 cmd_id;
@@ -408,11 +408,11 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
-	if (!comp_ctx) {
+	if (comp_ctx->status != EFA_CMD_SUBMITTED) {
 		ibdev_err(aq->efa_dev,
-			  "comp_ctx is NULL. Changing the admin queue running state\n");
-		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
-		return;
+			  "Received completion with unexpected command id[%d], sq producer: %d, sq consumer: %d, cq consumer: %d\n",
+			  cmd_id, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+		return -EINVAL;
 	}
 
 	comp_ctx->status = EFA_CMD_COMPLETED;
@@ -420,14 +420,17 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 
 	if (!test_bit(EFA_AQ_STATE_POLLING_BIT, &aq->state))
 		complete(&comp_ctx->wait_event);
+
+	return 0;
 }
 
 static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 {
 	struct efa_admin_acq_entry *cqe;
 	u16 queue_size_mask;
-	u16 comp_num = 0;
+	u16 comp_cmds = 0;
 	u8 phase;
+	int err;
 	u16 ci;
 
 	queue_size_mask = aq->depth - 1;
@@ -445,10 +448,12 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 		 * phase bit was validated
 		 */
 		dma_rmb();
-		efa_com_handle_single_admin_completion(aq, cqe);
+		err = efa_com_handle_single_admin_completion(aq, cqe);
+		if (!err)
+			comp_cmds++;
 
+		aq->cq.cc++;
 		ci++;
-		comp_num++;
 		if (ci == aq->depth) {
 			ci = 0;
 			phase = !phase;
@@ -457,10 +462,9 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 		cqe = &aq->cq.entries[ci];
 	}
 
-	aq->cq.cc += comp_num;
 	aq->cq.phase = phase;
-	aq->sq.cc += comp_num;
-	atomic64_add(comp_num, &aq->stats.completed_cmd);
+	aq->sq.cc += comp_cmds;
+	atomic64_add(comp_cmds, &aq->stats.completed_cmd);
 }
 
 static int efa_com_comp_status_to_errno(u8 comp_status)
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index f2593133e524..790db3ceb208 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -416,6 +416,20 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 		return -EINVAL;
 	}
 
+	/*
+	 * Limit number of contacts to a reasonable value (100). This
+	 * ensures that we need less than 2 pages for struct input_mt
+	 * (we are not using in-kernel slot assignment so not going to
+	 * allocate memory for the "red" table), and we should have no
+	 * trouble getting this much memory.
+	 */
+	if (code == ABS_MT_SLOT && max > 99) {
+		printk(KERN_DEBUG
+		       "%s: unreasonably large number of slots requested: %d\n",
+		       UINPUT_NAME, max);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0ad33d8d99d1..1134aa24d67f 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1418,7 +1418,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	 */
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
-	while (qi->desc_status[wait_index] != QI_DONE) {
+	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index ed3574195599..8593c79cfaeb 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -379,6 +379,7 @@ static int sun50i_iommu_enable(struct sun50i_iommu *iommu)
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(3) |
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(4) |
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(5));
+	iommu_write(iommu, IOMMU_BYPASS_REG, 0);
 	iommu_write(iommu, IOMMU_INT_ENABLE_REG, IOMMU_INT_MASK);
 	iommu_write(iommu, IOMMU_DM_AUT_CTRL_REG(SUN50I_IOMMU_ACI_NONE),
 		    IOMMU_DM_AUT_CTRL_RD_UNAVAIL(SUN50I_IOMMU_ACI_NONE, 0) |
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 01709c61e364..3fa6bd70684b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,6 +546,10 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <= 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9349fc68b81a..0e57c60681aa 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -439,12 +439,12 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
+	if (ret && child)
+		of_node_put(child);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)
diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index f1964c96fb15..82696e0607a5 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -91,7 +91,6 @@ static int spi_byte_probe(struct spi_device *spi)
 		dev_err(dev, "Device must have exactly one LED sub-node.");
 		return -EINVAL;
 	}
-	child = of_get_next_available_child(dev_of_node(dev), NULL);
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
@@ -107,11 +106,13 @@ static int spi_byte_probe(struct spi_device *spi)
 	led->ldev.max_brightness = led->cdef->max_value - led->cdef->off_value;
 	led->ldev.brightness_set_blocking = spi_byte_brightness_set_blocking;
 
+	child = of_get_next_available_child(dev_of_node(dev), NULL);
 	state = of_get_property(child, "default-state", NULL);
 	if (state) {
 		if (!strcmp(state, "on")) {
 			led->ldev.brightness = led->ldev.max_brightness;
 		} else if (strcmp(state, "off")) {
+			of_node_put(child);
 			/* all other cases except "off" */
 			dev_err(dev, "default-state can only be 'on' or 'off'");
 			return -EINVAL;
@@ -122,9 +123,12 @@ static int spi_byte_probe(struct spi_device *spi)
 
 	ret = devm_led_classdev_register(&spi->dev, &led->ldev);
 	if (ret) {
+		of_node_put(child);
 		mutex_destroy(&led->mutex);
 		return ret;
 	}
+
+	of_node_put(child);
 	spi_set_drvdata(spi, led);
 
 	return 0;
diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index dc4381d68313..6e9e73a55874 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -213,8 +213,10 @@ static char __init *dm_parse_device_entry(struct dm_device *dev, char *str)
 	strscpy(dev->dmi.uuid, field[1], sizeof(dev->dmi.uuid));
 	/* minor */
 	if (strlen(field[2])) {
-		if (kstrtoull(field[2], 0, &dev->dmi.dev))
+		if (kstrtoull(field[2], 0, &dev->dmi.dev) ||
+		    dev->dmi.dev >= (1 << MINORBITS))
 			return ERR_PTR(-EINVAL);
+		dev->dmi.dev = huge_encode_dev((dev_t)dev->dmi.dev);
 		dev->dmi.flags |= DM_PERSISTENT_DEV_FLAG;
 	}
 	/* flags */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index e53f575b32f5..da5a8e18bb1e 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -835,8 +835,11 @@ static int camss_of_parse_endpoint_node(struct device *dev,
 	struct v4l2_fwnode_bus_mipi_csi2 *mipi_csi2;
 	struct v4l2_fwnode_endpoint vep = { { 0 } };
 	unsigned int i;
+	int ret;
 
-	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	if (ret)
+		return ret;
 
 	csd->interface.csiphy_id = vep.base.port;
 
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 331a3f4286d2..c663daedb82c 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -113,8 +113,9 @@ static int vid_cap_queue_setup(struct vb2_queue *vq,
 		if (*nplanes != buffers)
 			return -EINVAL;
 		for (p = 0; p < buffers; p++) {
-			if (sizes[p] < tpg_g_line_width(&dev->tpg, p) * h +
-						dev->fmt_cap->data_offset[p])
+			if (sizes[p] < tpg_g_line_width(&dev->tpg, p) * h /
+					dev->fmt_cap->vdownsampling[p] +
+					dev->fmt_cap->data_offset[p])
 				return -EINVAL;
 		}
 	} else {
@@ -1797,8 +1798,10 @@ int vidioc_s_edid(struct file *file, void *_fh,
 		return -EINVAL;
 	if (edid->blocks == 0) {
 		dev->edid_blocks = 0;
-		v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, 0);
-		v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, 0);
+		if (dev->num_outputs) {
+			v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, 0);
+			v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, 0);
+		}
 		phys_addr = CEC_PHYS_ADDR_INVALID;
 		goto set_phys_addr;
 	}
@@ -1822,8 +1825,10 @@ int vidioc_s_edid(struct file *file, void *_fh,
 			display_present |=
 				dev->display_present[i] << j++;
 
-	v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, display_present);
-	v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, display_present);
+	if (dev->num_outputs) {
+		v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, display_present);
+		v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, display_present);
+	}
 
 set_phys_addr:
 	/* TODO: a proper hotplug detect cycle should be emulated here */
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-out.c b/drivers/media/test-drivers/vivid/vivid-vid-out.c
index 9f731f085179..e96d3d014143 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
@@ -63,14 +63,16 @@ static int vid_out_queue_setup(struct vb2_queue *vq,
 		if (sizes[0] < size)
 			return -EINVAL;
 		for (p = 1; p < planes; p++) {
-			if (sizes[p] < dev->bytesperline_out[p] * h +
-				       vfmt->data_offset[p])
+			if (sizes[p] < dev->bytesperline_out[p] * h /
+					vfmt->vdownsampling[p] +
+					vfmt->data_offset[p])
 				return -EINVAL;
 		}
 	} else {
 		for (p = 0; p < planes; p++)
-			sizes[p] = p ? dev->bytesperline_out[p] * h +
-				       vfmt->data_offset[p] : size;
+			sizes[p] = p ? dev->bytesperline_out[p] * h /
+					vfmt->vdownsampling[p] +
+					vfmt->data_offset[p] : size;
 	}
 
 	if (vq->num_buffers + *nbuffers < 2)
@@ -127,7 +129,7 @@ static int vid_out_buf_prepare(struct vb2_buffer *vb)
 
 	for (p = 0; p < planes; p++) {
 		if (p)
-			size = dev->bytesperline_out[p] * h;
+			size = dev->bytesperline_out[p] * h / vfmt->vdownsampling[p];
 		size += vb->planes[p].data_offset;
 
 		if (vb2_get_plane_payload(vb, p) < size) {
@@ -334,8 +336,8 @@ int vivid_g_fmt_vid_out(struct file *file, void *priv,
 	for (p = 0; p < mp->num_planes; p++) {
 		mp->plane_fmt[p].bytesperline = dev->bytesperline_out[p];
 		mp->plane_fmt[p].sizeimage =
-			mp->plane_fmt[p].bytesperline * mp->height +
-			fmt->data_offset[p];
+			mp->plane_fmt[p].bytesperline * mp->height /
+			fmt->vdownsampling[p] + fmt->data_offset[p];
 	}
 	for (p = fmt->buffers; p < fmt->planes; p++) {
 		unsigned stride = dev->bytesperline_out[p];
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index b19c75a6f595..ef5788899503 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -936,16 +936,26 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 		goto error;
 	}
 
-	size = nformats * sizeof(*format) + nframes * sizeof(*frame)
+	/*
+	 * Allocate memory for the formats, the frames and the intervals,
+	 * plus any required padding to guarantee that everything has the
+	 * correct alignment.
+	 */
+	size = nformats * sizeof(*format);
+	size = ALIGN(size, __alignof__(*frame)) + nframes * sizeof(*frame);
+	size = ALIGN(size, __alignof__(*interval))
 	     + nintervals * sizeof(*interval);
+
 	format = kzalloc(size, GFP_KERNEL);
-	if (format == NULL) {
+	if (!format) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	frame = (struct uvc_frame *)&format[nformats];
-	interval = (u32 *)&frame[nframes];
+	frame = (void *)format + nformats * sizeof(*format);
+	frame = PTR_ALIGN(frame, __alignof__(*frame));
+	interval = (void *)frame + nframes * sizeof(*frame);
+	interval = PTR_ALIGN(interval, __alignof__(*interval));
 
 	streaming->format = format;
 	streaming->nformats = 0;
diff --git a/drivers/misc/vmw_vmci/vmci_resource.c b/drivers/misc/vmw_vmci/vmci_resource.c
index 692daa9eff34..19c9d2cdd277 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -144,7 +144,8 @@ void vmci_resource_remove(struct vmci_resource *resource)
 	spin_lock(&vmci_resource_table.lock);
 
 	hlist_for_each_entry(r, &vmci_resource_table.entries[idx], node) {
-		if (vmci_handle_is_equal(r->handle, resource->handle)) {
+		if (vmci_handle_is_equal(r->handle, resource->handle) &&
+		    resource->type == r->type) {
 			hlist_del_init_rcu(&r->node);
 			break;
 		}
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 961442e9a6c1..9569d56193bc 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -612,7 +612,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32927e66b60c..9a80de37acd4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2903,8 +2903,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
-		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
+		mmc->max_seg_size = mmc->max_req_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6..84f91c517d9a 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -513,6 +513,7 @@ static const struct of_device_id aspeed_sdhci_of_match[] = {
 	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, aspeed_sdhci_of_match);
 
 static struct platform_driver aspeed_sdhci_driver = {
 	.driver		= {
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 98c915943f32..43d038a5123e 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -75,7 +75,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 		if (skb_copy_bits(skb, BAREUDP_BASE_HLEN, &ipversion,
 				  sizeof(ipversion))) {
-			bareudp->dev->stats.rx_dropped++;
+			DEV_STATS_INC(bareudp->dev, rx_dropped);
 			goto drop;
 		}
 		ipversion >>= 4;
@@ -85,7 +85,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		} else if (ipversion == 6 && bareudp->multi_proto_mode) {
 			proto = htons(ETH_P_IPV6);
 		} else {
-			bareudp->dev->stats.rx_dropped++;
+			DEV_STATS_INC(bareudp->dev, rx_dropped);
 			goto drop;
 		}
 	} else if (bareudp->ethertype == htons(ETH_P_MPLS_UC)) {
@@ -99,7 +99,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   ipv4_is_multicast(tunnel_hdr->daddr)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				bareudp->dev->stats.rx_dropped++;
+				DEV_STATS_INC(bareudp->dev, rx_dropped);
 				goto drop;
 			}
 		} else {
@@ -115,7 +115,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   (addr_type & IPV6_ADDR_MULTICAST)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				bareudp->dev->stats.rx_dropped++;
+				DEV_STATS_INC(bareudp->dev, rx_dropped);
 				goto drop;
 			}
 		}
@@ -127,12 +127,12 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				 proto,
 				 !net_eq(bareudp->net,
 				 dev_net(bareudp->dev)))) {
-		bareudp->dev->stats.rx_dropped++;
+		DEV_STATS_INC(bareudp->dev, rx_dropped);
 		goto drop;
 	}
 	tun_dst = udp_tun_rx_dst(skb, family, TUNNEL_KEY, 0, 0);
 	if (!tun_dst) {
-		bareudp->dev->stats.rx_dropped++;
+		DEV_STATS_INC(bareudp->dev, rx_dropped);
 		goto drop;
 	}
 	skb_dst_set(skb, &tun_dst->dst);
@@ -158,8 +158,8 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 						     &((struct ipv6hdr *)oiph)->saddr);
 		}
 		if (err > 1) {
-			++bareudp->dev->stats.rx_frame_errors;
-			++bareudp->dev->stats.rx_errors;
+			DEV_STATS_INC(bareudp->dev, rx_frame_errors);
+			DEV_STATS_INC(bareudp->dev, rx_errors);
 			goto drop;
 		}
 	}
@@ -455,11 +455,11 @@ static netdev_tx_t bareudp_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_kfree_skb(skb);
 
 	if (err == -ELOOP)
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e027229c1955..07f61ee76ca6 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1840,7 +1840,7 @@ static int m_can_open(struct net_device *dev)
 	/* start the m_can controller */
 	err = m_can_start(dev);
 	if (err)
-		goto exit_irq_fail;
+		goto exit_start_fail;
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
@@ -1851,6 +1851,9 @@ static int m_can_open(struct net_device *dev)
 
 	return 0;
 
+exit_start_fail:
+	if (cdev->is_peripheral || dev->irq)
+		free_irq(dev->irq, dev);
 exit_irq_fail:
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index f02275f71e4d..653566c570df 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -755,7 +755,7 @@ static int mcp251x_hw_wake(struct spi_device *spi)
 	int ret;
 
 	/* Force wakeup interrupt to wake device, but don't execute IST */
-	disable_irq(spi->irq);
+	disable_irq_nosync(spi->irq);
 	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
 
 	/* Wait for oscillator startup timer after wake up */
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 592527f06944..36da2107b5d9 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -35,7 +35,7 @@
 #define VSC73XX_BLOCK_ANALYZER	0x2 /* Only subblock 0 */
 #define VSC73XX_BLOCK_MII	0x3 /* Subblocks 0 and 1 */
 #define VSC73XX_BLOCK_MEMINIT	0x3 /* Only subblock 2 */
-#define VSC73XX_BLOCK_CAPTURE	0x4 /* Only subblock 2 */
+#define VSC73XX_BLOCK_CAPTURE	0x4 /* Subblocks 0-4, 6, 7 */
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
@@ -371,13 +371,19 @@ int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 		break;
 
 	case VSC73XX_BLOCK_MII:
-	case VSC73XX_BLOCK_CAPTURE:
 	case VSC73XX_BLOCK_ARBITER:
 		switch (subblock) {
 		case 0 ... 1:
 			return 1;
 		}
 		break;
+	case VSC73XX_BLOCK_CAPTURE:
+		switch (subblock) {
+		case 0 ... 4:
+		case 6 ... 7:
+			return 1;
+		}
+		break;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 1766b7d94ffa..119f560b2e65 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -910,14 +910,18 @@ static inline void dpaa_setup_egress(const struct dpaa_priv *priv,
 	}
 }
 
-static void dpaa_fq_setup(struct dpaa_priv *priv,
-			  const struct dpaa_fq_cbs *fq_cbs,
-			  struct fman_port *tx_port)
+static int dpaa_fq_setup(struct dpaa_priv *priv,
+			 const struct dpaa_fq_cbs *fq_cbs,
+			 struct fman_port *tx_port)
 {
 	int egress_cnt = 0, conf_cnt = 0, num_portals = 0, portal_cnt = 0, cpu;
 	const cpumask_t *affine_cpus = qman_affine_cpus();
-	u16 channels[NR_CPUS];
 	struct dpaa_fq *fq;
+	u16 *channels;
+
+	channels = kcalloc(num_possible_cpus(), sizeof(u16), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
 
 	for_each_cpu_and(cpu, affine_cpus, cpu_online_mask)
 		channels[num_portals++] = qman_affine_channel(cpu);
@@ -976,6 +980,10 @@ static void dpaa_fq_setup(struct dpaa_priv *priv,
 				break;
 		}
 	}
+
+	kfree(channels);
+
+	return 0;
 }
 
 static inline int dpaa_tx_fq_to_id(const struct dpaa_priv *priv,
@@ -3444,7 +3452,9 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	 */
 	dpaa_eth_add_channel(priv->channel, &pdev->dev);
 
-	dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
+	err = dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
+	if (err)
+		goto free_dpaa_bps;
 
 	/* Create a congestion group for this netdev, with
 	 * dynamically-allocated CGR ID.
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 5750f9a56393..df6af1097dd2 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -541,12 +541,16 @@ static int dpaa_set_coalesce(struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 {
 	const cpumask_t *cpus = qman_affine_cpus();
-	bool needs_revert[NR_CPUS] = {false};
 	struct qman_portal *portal;
 	u32 period, prev_period;
 	u8 thresh, prev_thresh;
+	bool *needs_revert;
 	int cpu, res;
 
+	needs_revert = kcalloc(num_possible_cpus(), sizeof(bool), GFP_KERNEL);
+	if (!needs_revert)
+		return -ENOMEM;
+
 	period = c->rx_coalesce_usecs;
 	thresh = c->rx_max_coalesced_frames;
 
@@ -569,6 +573,8 @@ static int dpaa_set_coalesce(struct net_device *dev,
 		needs_revert[cpu] = true;
 	}
 
+	kfree(needs_revert);
+
 	return 0;
 
 revert_values:
@@ -582,6 +588,8 @@ static int dpaa_set_coalesce(struct net_device *dev,
 		qman_dqrr_set_ithresh(portal, prev_thresh);
 	}
 
+	kfree(needs_revert);
+
 	return res;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8c0ee9a8ff86..8a00864ead7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2751,8 +2751,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
  */
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 {
-	if (test_bit(ICE_VSI_DOWN, vsi->state))
-		return;
+	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
 
 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
@@ -2760,15 +2759,16 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
-
-			ice_vsi_close(vsi);
+			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
+			if (!already_down)
+				ice_vsi_close(vsi);
 
 			if (!locked)
 				rtnl_unlock();
-		} else {
+		} else if (!already_down) {
 			ice_vsi_close(vsi);
 		}
-	} else if (vsi->type == ICE_VSI_CTRL) {
+	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
 		ice_vsi_close(vsi);
 	}
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 03a4da6a1447..420bc34fb8c1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6799,10 +6799,20 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7605115e6a1b..27c24bfc2dbe 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7057,6 +7057,7 @@ static void igc_io_resume(struct pci_dev *pdev)
 	rtnl_lock();
 	if (netif_running(netdev)) {
 		if (igc_open(netdev)) {
+			rtnl_unlock();
 			netdev_err(netdev, "igc_open failed after reset\n");
 			return;
 		}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index b791fba82c2f..910d8973a4b0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -221,7 +221,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		name = dev_name(dev);
 
 	snprintf(intr->name, sizeof(intr->name),
-		 "%s-%s-%s", IONIC_DRV_NAME, name, q->name);
+		 "%.5s-%.16s-%.8s", IONIC_DRV_NAME, name, q->name);
 
 	return devm_request_irq(dev, intr->vector, ionic_isr,
 				0, intr->name, &qcq->napi);
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 0e4ea3c0fe82..1bff01f8b16d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -530,18 +530,15 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 
 	type = gh->proto_type;
 
-	rcu_read_lock();
 	ptype = gro_find_receive_by_type(type);
 	if (!ptype)
-		goto out_unlock;
+		goto out;
 
 	skb_gro_pull(skb, gh_len);
 	skb_gro_postpull_rcsum(skb, gh, gh_len);
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
-out_unlock:
-	rcu_read_unlock();
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
@@ -561,13 +558,10 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
 		err = ptype->callbacks.gro_complete(skb, nhoff + gh_len);
 
-	rcu_read_unlock();
-
 	skb_set_inner_mac_header(skb, nhoff + gh_len);
 
 	return err;
diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index d7f3b70d5477..f69d9b902da0 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -336,6 +336,7 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int retval = 0;
 	unsigned char data[2];
+	u8 addr[ETH_ALEN];
 
 	retval = usbnet_get_endpoints(dev, intf);
 	if (retval)
@@ -383,7 +384,8 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
 
-	retval = get_mac_address(dev, dev->net->dev_addr);
+	retval = get_mac_address(dev, addr);
+	eth_hw_addr_set(dev->net, addr);
 
 	return retval;
 }
diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index c4568a491dc4..79a47e2fd437 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -146,6 +146,7 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 link[3];
 	int timeout = 50;
 	struct cx82310_priv *priv;
+	u8 addr[ETH_ALEN];
 
 	/* avoid ADSL modems - continue only if iProduct is "USB NET CARD" */
 	if (usb_string(udev, udev->descriptor.iProduct, buf, sizeof(buf)) > 0
@@ -202,12 +203,12 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 		goto err;
 
 	/* get the MAC address */
-	ret = cx82310_cmd(dev, CMD_GET_MAC_ADDR, true, NULL, 0,
-			  dev->net->dev_addr, ETH_ALEN);
+	ret = cx82310_cmd(dev, CMD_GET_MAC_ADDR, true, NULL, 0, addr, ETH_ALEN);
 	if (ret) {
 		netdev_err(dev->net, "unable to read MAC address: %d\n", ret);
 		goto err;
 	}
+	eth_hw_addr_set(dev->net, addr);
 
 	/* start (does not seem to have any effect?) */
 	ret = cx82310_cmd(dev, CMD_START, false, NULL, 0, NULL, 0);
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index d56e276e4d80..4485388dcff2 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -353,8 +353,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index 144c686b4333..9b2bc1993ece 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -1044,8 +1044,7 @@ static int kaweth_probe(
 		goto err_all_but_rxbuf;
 
 	memcpy(netdev->broadcast, &bcast_addr, sizeof(bcast_addr));
-	memcpy(netdev->dev_addr, &kaweth->configuration.hw_addr,
-               sizeof(kaweth->configuration.hw_addr));
+	eth_hw_addr_set(netdev, (u8 *)&kaweth->configuration.hw_addr);
 
 	netdev->netdev_ops = &kaweth_netdev_ops;
 	netdev->watchdog_timeo = KAWETH_TX_TIMEOUT;
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index 8f484c4949d9..f62169216d8c 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -481,17 +481,19 @@ static const struct net_device_ops mcs7830_netdev_ops = {
 static int mcs7830_bind(struct usbnet *dev, struct usb_interface *udev)
 {
 	struct net_device *net = dev->net;
+	u8 addr[ETH_ALEN];
 	int ret;
 	int retry;
 
 	/* Initial startup: Gather MAC address setting from EEPROM */
 	ret = -EINVAL;
 	for (retry = 0; retry < 5 && ret; retry++)
-		ret = mcs7830_hif_get_mac_address(dev, net->dev_addr);
+		ret = mcs7830_hif_get_mac_address(dev, addr);
 	if (ret) {
 		dev_warn(&dev->udev->dev, "Cannot read MAC address\n");
 		goto out;
 	}
+	eth_hw_addr_set(net, addr);
 
 	mcs7830_data_set_multicast(net);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 773a54c083f6..71ee7a3c3f5b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1426,6 +1426,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
+	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 55025202dc4f..bb4cbe8fc846 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -669,6 +669,7 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 		0x00, 0x00, SIERRA_NET_HIP_MSYNC_ID, 0x00};
 	static const u8 shdwn_tmplate[sizeof(priv->shdwn_msg)] = {
 		0x00, 0x00, SIERRA_NET_HIP_SHUTD_ID, 0x00};
+	u8 mod[2];
 
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 
@@ -698,8 +699,9 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->netdev_ops = &sierra_net_device_ops;
 
 	/* change MAC addr to include, ifacenum, and to be unique */
-	dev->net->dev_addr[ETH_ALEN-2] = atomic_inc_return(&iface_counter);
-	dev->net->dev_addr[ETH_ALEN-1] = ifacenum;
+	mod[0] = atomic_inc_return(&iface_counter);
+	mod[1] = ifacenum;
+	dev_addr_mod(dev->net, ETH_ALEN - 2, mod, 2);
 
 	/* prepare shutdown message template */
 	memcpy(priv->shdwn_msg, shdwn_tmplate, sizeof(priv->shdwn_msg));
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 3cff3c9d7b89..5b29da399d95 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -327,6 +327,7 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct net_device *netdev;
 	struct mii_if_info *mii;
+	u8 addr[ETH_ALEN];
 	int ret;
 
 	ret = usbnet_get_endpoints(dev, intf);
@@ -357,11 +358,12 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 	 * EEPROM automatically to PAR. In case there is no EEPROM externally,
 	 * a default MAC address is stored in PAR for making chip work properly.
 	 */
-	if (sr_read(dev, SR_PAR, ETH_ALEN, netdev->dev_addr) < 0) {
+	if (sr_read(dev, SR_PAR, ETH_ALEN, addr) < 0) {
 		netdev_err(netdev, "Error reading MAC address\n");
 		ret = -ENODEV;
 		goto out;
 	}
+	eth_hw_addr_set(netdev, addr);
 
 	/* power up and reset phy */
 	sr_write_reg(dev, SR_PRR, PRR_PHY_RST);
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 79358369c456..2d553604f179 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -731,6 +731,7 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct sr_data *data = (struct sr_data *)&dev->data;
 	u16 led01_mux, led23_mux;
 	int ret, embd_phy;
+	u8 addr[ETH_ALEN];
 	u32 phyid;
 	u16 rx_ctl;
 
@@ -756,12 +757,12 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 	}
 
 	/* Get the MAC address */
-	ret = sr_read_cmd(dev, SR_CMD_READ_NODE_ID, 0, 0, ETH_ALEN,
-			  dev->net->dev_addr);
+	ret = sr_read_cmd(dev, SR_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, addr);
 	if (ret < 0) {
 		netdev_dbg(dev->net, "Failed to read MAC address: %d\n", ret);
 		return ret;
 	}
+	eth_hw_addr_set(dev->net, addr);
 	netdev_dbg(dev->net, "mac addr : %pM\n", dev->net->dev_addr);
 
 	/* Initialize MII structure */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 566aa01ad281..8e4f85fb8c77 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -64,9 +64,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-// randomly generated ethernet address
-static u8	node_id [ETH_ALEN];
-
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
@@ -165,12 +162,13 @@ EXPORT_SYMBOL_GPL(usbnet_get_endpoints);
 
 int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 {
+	u8		addr[ETH_ALEN];
 	int 		tmp = -1, ret;
 	unsigned char	buf [13];
 
 	ret = usb_string(dev->udev, iMACAddress, buf, sizeof buf);
 	if (ret == 12)
-		tmp = hex2bin(dev->net->dev_addr, buf, 6);
+		tmp = hex2bin(addr, buf, 6);
 	if (tmp < 0) {
 		dev_dbg(&dev->udev->dev,
 			"bad MAC string %d fetch, %d\n", iMACAddress, tmp);
@@ -178,6 +176,7 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 			ret = -EINVAL;
 		return ret;
 	}
+	eth_hw_addr_set(dev->net, addr);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
@@ -1727,7 +1726,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 
 	dev->net = net;
 	strscpy(net->name, "usb%d", sizeof(net->name));
-	memcpy (net->dev_addr, node_id, sizeof node_id);
 
 	/* rx and tx sides can use different message sizes;
 	 * bind() should set rx_urb_size in that case.
@@ -1801,9 +1799,9 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		goto out4;
 	}
 
-	/* let userspace know we have a random address */
-	if (ether_addr_equal(net->dev_addr, node_id))
-		net->addr_assign_type = NET_ADDR_RANDOM;
+	/* this flags the device for user space */
+	if (!is_valid_ether_addr(net->dev_addr))
+		eth_hw_addr_random(net);
 
 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
 		SET_NETDEV_DEVTYPE(net, &wlan_type);
@@ -2213,7 +2211,6 @@ static int __init usbnet_init(void)
 	BUILD_BUG_ON(
 		sizeof_field(struct sk_buff, cb) < sizeof(struct skb_data));
 
-	eth_random_addr(node_id);
 	return 0;
 }
 module_init(usbnet_init);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bd0cb3a03b7b..d8138ad4f865 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1548,7 +1548,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1561,7 +1561,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (__netif_tx_trylock(txq)) {
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -1580,7 +1580,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1683,7 +1683,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index eadac0f5590f..e09f5416abe7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1088,6 +1088,7 @@ static int ieee_hw_init(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	hw->extra_tx_headroom = brcms_c_get_header_len();
 	hw->queues = N_TX_QUEUES;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 6419fbfec5ac..6da3934b8e9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -252,8 +252,7 @@ static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
 		.data = { NULL, },
 	};
 
-	if (fwrt->ops && fwrt->ops->fw_running &&
-	    !fwrt->ops->fw_running(fwrt->ops_ctx))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return -EIO;
 
 	if (count < header_size + 1 || count > 1024 * 4)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 35af85a5430b..297ff92de928 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -18,7 +18,6 @@
 struct iwl_fw_runtime_ops {
 	int (*dump_start)(void *ctx);
 	void (*dump_end)(void *ctx);
-	bool (*fw_running)(void *ctx);
 	int (*send_hcmd)(void *ctx, struct iwl_host_cmd *host_cmd);
 	bool (*d3_debug_enable)(void *ctx);
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 01f65c9789e7..0b0022dabc7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -653,11 +653,6 @@ static void iwl_mvm_fwrt_dump_end(void *ctx)
 	mutex_unlock(&mvm->mutex);
 }
 
-static bool iwl_mvm_fwrt_fw_running(void *ctx)
-{
-	return iwl_mvm_firmware_running(ctx);
-}
-
 static int iwl_mvm_fwrt_send_hcmd(void *ctx, struct iwl_host_cmd *host_cmd)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)ctx;
@@ -678,7 +673,6 @@ static bool iwl_mvm_d3_debug_enable(void *ctx)
 static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 	.dump_start = iwl_mvm_fwrt_dump_start,
 	.dump_end = iwl_mvm_fwrt_dump_end,
-	.fw_running = iwl_mvm_fwrt_fw_running,
 	.send_hcmd = iwl_mvm_fwrt_send_hcmd,
 	.d3_debug_enable = iwl_mvm_d3_debug_enable,
 };
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index f4e3dce10d65..5b14fe08811e 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1310,6 +1310,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		if (adapter->priv[i]) {
+			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
+				continue;
+
 			if ((adapter->priv[i]->bss_num == bss_num) &&
 			    (adapter->priv[i]->bss_type == bss_type))
 				break;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7a363f02625d..3fdf7282a88f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2974,6 +2974,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa80d) {
+		/*
+		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
+		 * because of high power consumption (> 2 Watt) in s2idle
+		 * sleep. Only some boards with Intel CPU are affected.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
+		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	/*
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index df044a79a734..809b03b86a00 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1819,8 +1819,10 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 	}
 
 	queue->nr_cmds = sq->size * 2;
-	if (nvmet_tcp_alloc_cmds(queue))
+	if (nvmet_tcp_alloc_cmds(queue)) {
+		queue->nr_cmds = 0;
 		return NVME_SC_INTERNAL;
+	}
 	return 0;
 }
 
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1c9ae3bb8789..aa07b0d82b18 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1112,13 +1112,13 @@ void nvmem_device_put(struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(nvmem_device_put);
 
 /**
- * devm_nvmem_device_get() - Get nvmem cell of device form a given id
+ * devm_nvmem_device_get() - Get nvmem device of device form a given id
  *
  * @dev: Device that requests the nvmem device.
  * @id: name id for the requested nvmem device.
  *
- * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_cell
- * on success.  The nvmem_cell will be freed by the automatically once the
+ * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
+ * on success.  The nvmem_device will be freed by the automatically once the
  * device is freed.
  */
 struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 352e14b007e7..ad0cb49e233a 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -288,7 +288,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	struct device_node *p;
 	const __be32 *addr;
 	u32 intsize;
-	int i, res;
+	int i, res, addr_len;
+	__be32 addr_buf[3] = { 0 };
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
 
@@ -297,13 +298,19 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
-	addr = of_get_property(device, "reg", NULL);
+	addr = of_get_property(device, "reg", &addr_len);
+
+	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
+	if (addr_len > (3 * sizeof(__be32)))
+		addr_len = 3 * sizeof(__be32);
+	if (addr)
+		memcpy(addr_buf, addr, addr_len);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr_buf, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -333,7 +340,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr_buf, out_irq);
  out:
 	of_node_put(p);
 	return res;
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 09379e5f7724..24031123a550 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -35,6 +35,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -105,6 +110,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -528,7 +535,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
@@ -540,6 +551,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -561,10 +577,36 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(rc_pci_devids, bridge)) {
 		if (pcie_get_readrq(dev) > 256) {
-			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			dev_info(&dev->dev, "limiting MRRS to 256 bytes\n");
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 bytes. Force the MRRS to
+	 * 128 bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index e8afa50129a8..60a0d59a533f 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -242,18 +242,24 @@ static struct pci_ops al_child_pci_ops = {
 	.write = pci_generic_config_write,
 };
 
-static void al_pcie_config_prepare(struct al_pcie *pcie)
+static int al_pcie_config_prepare(struct al_pcie *pcie)
 {
 	struct al_pcie_target_bus_cfg *target_bus_cfg;
 	struct pcie_port *pp = &pcie->pci->pp;
 	unsigned int ecam_bus_mask;
+	struct resource_entry *ft;
 	u32 cfg_control_offset;
+	struct resource *bus;
 	u8 subordinate_bus;
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
-	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
 
+	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!ft)
+		return -ENODEV;
+
+	bus = ft->res;
 	target_bus_cfg = &pcie->target_bus_cfg;
 
 	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
@@ -287,6 +293,8 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
 
 	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
+
+	return 0;
 }
 
 static int al_pcie_host_init(struct pcie_port *pp)
@@ -305,7 +313,9 @@ static int al_pcie_host_init(struct pcie_port *pp)
 	if (rc)
 		return rc;
 
-	al_pcie_config_prepare(pcie);
+	rc = al_pcie_config_prepare(pcie);
+	if (rc)
+		return rc;
 
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index f4c2e6e01be0..e233f8402e8c 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -38,7 +38,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -57,7 +56,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a88909f2ae65..ee1d74f89a05 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5496,10 +5496,12 @@ static void pci_bus_lock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5511,8 +5513,10 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5520,15 +5524,15 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5536,8 +5540,10 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 	return 0;
 }
 
@@ -5569,9 +5575,10 @@ static void pci_slot_lock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5597,14 +5604,13 @@ static int pci_slot_trylock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
 				pci_dev_unlock(dev);
 				goto unlock;
 			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5615,7 +5621,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	return 0;
 }
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 84bfc0e85d6b..f15b72c6e57e 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -636,11 +636,11 @@ static int yenta_search_one_res(struct resource *root, struct resource *res,
 		start = PCIBIOS_MIN_CARDBUS_IO;
 		end = ~0U;
 	} else {
-		unsigned long avail = root->end - root->start;
+		unsigned long avail = resource_size(root);
 		int i;
 		size = BRIDGE_MEM_MAX;
-		if (size > avail/8) {
-			size = (avail+1)/8;
+		if (size > (avail - 1) / 8) {
+			size = avail / 8;
 			/* round size down to next power of 2 */
 			i = 0;
 			while ((size /= 2) != 0)
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 77b0f5bbe3ac..b19c5ff31a70 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -589,7 +589,10 @@ static int __init dell_smbios_init(void)
 	return 0;
 
 fail_sysfs:
-	free_group(platform_device);
+	if (!wmi)
+		exit_dell_smbios_wmi();
+	if (!smm)
+		exit_dell_smbios_smm();
 
 fail_create_group:
 	platform_device_del(platform_device);
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 94b131ef8a22..d78454deedd9 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 652fe2547587..56bf01182764 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -104,10 +104,11 @@ static void hv_uio_channel_cb(void *context)
 
 /*
  * Callback from vmbus_event when channel is rescinded.
+ * It is meant for rescind of primary channels only.
  */
 static void hv_uio_rescind(struct vmbus_channel *channel)
 {
-	struct hv_device *hv_dev = channel->primary_channel->device_obj;
+	struct hv_device *hv_dev = channel->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
 	/*
@@ -118,6 +119,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 
 	/* Wake up reader */
 	uio_event_notify(&pdata->info);
+
+	/*
+	 * With rescind callback registered, rescind path will not unregister the device
+	 * from vmbus when the primary channel is rescinded.
+	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
+	 * Unregister the device from vmbus here.
+	 */
+	vmbus_device_unregister(channel->device_obj);
 }
 
 /* Sysfs API to allow mmap of the ring buffers
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de9b638c207a..20aa0cbaae03 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1057,6 +1057,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
 	 * fails to send proper CRC checksum in CRC5 feild. Because of this
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8c8e17cc1344..d111608d2894 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -387,6 +387,7 @@
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
@@ -1197,6 +1198,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
 #define DWC3_REVISION_330A	0x5533330a
 
 #define DWC31_REVISION_ANY	0x0
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 11a551a9cd05..aa61b1041028 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -422,6 +422,7 @@ static void uas_data_cmplt(struct urb *urb)
 			uas_log_cmd_state(cmnd, "data cmplt err", status);
 		/* error: no data transfered */
 		scsi_set_resid(cmnd, sdb->length);
+		set_host_byte(cmnd, DID_ERROR);
 	} else {
 		scsi_set_resid(cmnd, sdb->length - urb->actual_length);
 	}
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 3dc3da8dbbdf..656a53ccd891 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -368,7 +368,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 5dd41e8215e0..bb34d647cf13 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -144,53 +144,62 @@ static int tweak_set_configuration_cmd(struct urb *urb)
 	if (err && err != -ENODEV)
 		dev_err(&sdev->udev->dev, "can't set config #%d, error %d\n",
 			config, err);
-	return 0;
+	return err;
 }
 
 static int tweak_reset_device_cmd(struct urb *urb)
 {
 	struct stub_priv *priv = (struct stub_priv *) urb->context;
 	struct stub_device *sdev = priv->sdev;
+	int err;
 
 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");
 
-	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
+	err = usb_lock_device_for_reset(sdev->udev, NULL);
+	if (err < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
-		return 0;
+		return err;
 	}
-	usb_reset_device(sdev->udev);
+	err = usb_reset_device(sdev->udev);
 	usb_unlock_device(sdev->udev);
 
-	return 0;
+	return err;
 }
 
 /*
  * clear_halt, set_interface, and set_configuration require special tricks.
+ * Returns 1 if request was tweaked, 0 otherwise.
  */
-static void tweak_special_requests(struct urb *urb)
+static int tweak_special_requests(struct urb *urb)
 {
+	int err;
+
 	if (!urb || !urb->setup_packet)
-		return;
+		return 0;
 
 	if (usb_pipetype(urb->pipe) != PIPE_CONTROL)
-		return;
+		return 0;
 
 	if (is_clear_halt_cmd(urb))
 		/* tweak clear_halt */
-		 tweak_clear_halt_cmd(urb);
+		err = tweak_clear_halt_cmd(urb);
 
 	else if (is_set_interface_cmd(urb))
 		/* tweak set_interface */
-		tweak_set_interface_cmd(urb);
+		err = tweak_set_interface_cmd(urb);
 
 	else if (is_set_configuration_cmd(urb))
 		/* tweak set_configuration */
-		tweak_set_configuration_cmd(urb);
+		err = tweak_set_configuration_cmd(urb);
 
 	else if (is_reset_device_cmd(urb))
-		tweak_reset_device_cmd(urb);
-	else
+		err = tweak_reset_device_cmd(urb);
+	else {
 		usbip_dbg_stub_rx("no need to tweak\n");
+		return 0;
+	}
+
+	return !err;
 }
 
 /*
@@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	int support_sg = 1;
 	int np = 0;
 	int ret, i;
+	int is_tweaked;
 
 	if (pipe == -1)
 		return;
@@ -580,8 +590,11 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 		priv->urbs[i]->pipe = pipe;
 		priv->urbs[i]->complete = stub_complete;
 
-		/* no need to submit an intercepted request, but harmless? */
-		tweak_special_requests(priv->urbs[i]);
+		/*
+		 * all URBs belong to a single PDU, so a global is_tweaked flag is
+		 * enough
+		 */
+		is_tweaked = tweak_special_requests(priv->urbs[i]);
 
 		masking_bogus_flags(priv->urbs[i]);
 	}
@@ -594,22 +607,32 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 
 	/* urb is now ready to submit */
 	for (i = 0; i < priv->num_urbs; i++) {
-		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
+		if (!is_tweaked) {
+			ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
 
-		if (ret == 0)
-			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
-					pdu->base.seqnum);
-		else {
-			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
-			usbip_dump_header(pdu);
-			usbip_dump_urb(priv->urbs[i]);
+			if (ret == 0)
+				usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
+						pdu->base.seqnum);
+			else {
+				dev_err(&udev->dev, "submit_urb error, %d\n", ret);
+				usbip_dump_header(pdu);
+				usbip_dump_urb(priv->urbs[i]);
 
+				/*
+				 * Pessimistic.
+				 * This connection will be discarded.
+				 */
+				usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+				break;
+			}
+		} else {
 			/*
-			 * Pessimistic.
-			 * This connection will be discarded.
+			 * An identical URB was already submitted in
+			 * tweak_special_requests(). Skip submitting this URB to not
+			 * duplicate the request.
 			 */
-			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
-			break;
+			priv->urbs[i]->status = 0;
+			stub_complete(priv->urbs[i]);
 		}
 	}
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8b53313bf3b2..0b8c8b5094ef 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -306,8 +306,16 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	}
 
 	owner = btrfs_header_owner(buf);
-	BUG_ON(owner == BTRFS_TREE_RELOC_OBJECTID &&
-	       !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));
+	if (unlikely(owner == BTRFS_TREE_RELOC_OBJECTID &&
+		     !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))) {
+		btrfs_crit(fs_info,
+"found tree block at bytenr %llu level %d root %llu refs %llu flags %llx without full backref flag set",
+			   buf->start, btrfs_header_level(buf),
+			   btrfs_root_id(root), refs, flags);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	if (refs > 1) {
 		if ((owner == root->root_key.objectid ||
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f19c6aa3ea4b..17ebcf19b444 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1383,7 +1383,6 @@ struct btrfs_drop_extents_args {
 struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
-	bool fsync_skip_inode_lock;
 };
 
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 24cbddc0b36f..8a526b9e8949 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5027,7 +5027,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		/* We don't care about errors in readahead. */
 		if (ret < 0)
 			continue;
-		BUG_ON(refs == 0);
+
+		/*
+		 * This could be racey, it's conceivable that we raced and end
+		 * up with a bogus refs count, if that's the case just skip, if
+		 * we are actually corrupt we will notice when we look up
+		 * everything again with our locks.
+		 */
+		if (refs == 0)
+			continue;
 
 		if (wc->stage == DROP_REFERENCE) {
 			if (refs == 1)
@@ -5086,7 +5094,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -5094,7 +5102,11 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
-		BUG_ON(wc->refs[level] == 0);
+		if (unlikely(wc->refs[level] == 0)) {
+			btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+				  eb->start);
+			return -EUCLEAN;
+		}
 	}
 
 	if (wc->stage == DROP_REFERENCE) {
@@ -5110,7 +5122,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
@@ -5224,8 +5236,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		goto out_unlock;
 
 	if (unlikely(wc->refs[level - 1] == 0)) {
-		btrfs_err(fs_info, "Missing references.");
-		ret = -EIO;
+		btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+			  bytenr);
+		ret = -EUCLEAN;
 		goto out_unlock;
 	}
 	*lookup_info = 0;
@@ -5426,7 +5439,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				path->locks[level] = 0;
 				return ret;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			if (unlikely(wc->refs[level] == 0)) {
+				btrfs_tree_unlock_rw(eb, path->locks[level]);
+				btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+					  eb->start);
+				return -EUCLEAN;
+			}
 			if (wc->refs[level] == 1) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c44dfb4370d7..44160d4ad53e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1992,13 +1992,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_ERR_OR_NULL(dio)) {
 		err = PTR_ERR_OR_ZERO(dio);
 	} else {
-		struct btrfs_file_private stack_private = { 0 };
-		struct btrfs_file_private *private;
-		const bool have_private = (file->private_data != NULL);
-
-		if (!have_private)
-			file->private_data = &stack_private;
-
 		/*
 		 * If we have a synchoronous write, we must make sure the fsync
 		 * triggered by the iomap_dio_complete() call below doesn't
@@ -2007,13 +2000,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		 * partial writes due to the input buffer (or parts of it) not
 		 * being already faulted in.
 		 */
-		private = file->private_data;
-		private->fsync_skip_inode_lock = true;
+		ASSERT(current->journal_info == NULL);
+		current->journal_info = BTRFS_TRANS_DIO_WRITE_STUB;
 		err = iomap_dio_complete(dio);
-		private->fsync_skip_inode_lock = false;
-
-		if (!have_private)
-			file->private_data = NULL;
+		current->journal_info = NULL;
 	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
@@ -2195,7 +2185,6 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2205,7 +2194,13 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
-	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
+	bool skip_ilock = false;
+
+	if (current->journal_info == BTRFS_TRANS_DIO_WRITE_STUB) {
+		skip_ilock = true;
+		current->journal_info = NULL;
+		lockdep_assert_held(&inode->i_rwsem);
+	}
 
 	trace_btrfs_sync_file(file, datasync);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 66b56ddf3f4c..f7807f36c8e3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6048,7 +6048,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
-	struct btrfs_key location;
+	struct btrfs_key location = { 0 };
 	u8 di_type = 0;
 	int ret = 0;
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 0ded32bbd001..a06bc6ad4764 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -11,6 +11,12 @@
 #include "delayed-ref.h"
 #include "ctree.h"
 
+/*
+ * Signal that a direct IO write is in progress, to avoid deadlock for sync
+ * direct IO writes when fsync is called during the direct IO write path.
+ */
+#define BTRFS_TRANS_DIO_WRITE_STUB	((void *) 1)
+
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
 	TRANS_STATE_COMMIT_START,
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index b725bd3144fb..6c30fff8a029 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -886,8 +886,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		goto oshr_exit;
 	}
 
-	atomic_inc(&tcon->num_remote_opens);
-
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
@@ -897,8 +895,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 	tcon->crfid.tcon = tcon;
 	tcon->crfid.is_valid = true;
-	tcon->crfid.dentry = dentry;
-	dget(dentry);
 	kref_init(&tcon->crfid.refcount);
 
 	/* BB TBD check to see if oplock level check can be removed below */
@@ -907,14 +903,16 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		 * See commit 2f94a3125b87. Increment the refcount when we
 		 * get a lease for root, release it if lease break occurs
 		 */
-		kref_get(&tcon->crfid.refcount);
-		tcon->crfid.has_lease = true;
 		rc = smb2_parse_contexts(server, rsp_iov,
 				&oparms.fid->epoch,
 				    oparms.fid->lease_key, &oplock,
 				    NULL, NULL);
 		if (rc)
 			goto oshr_exit;
+
+		if (!(oplock & SMB2_LEASE_READ_CACHING_HE))
+			goto oshr_exit;
+
 	} else
 		goto oshr_exit;
 
@@ -928,7 +926,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 				(char *)&tcon->crfid.file_all_info))
 		tcon->crfid.file_all_info_is_valid = true;
 	tcon->crfid.time = jiffies;
-
+	tcon->crfid.dentry = dentry;
+	dget(dentry);
+	kref_get(&tcon->crfid.refcount);
+	tcon->crfid.has_lease = true;
 
 oshr_exit:
 	mutex_unlock(&tcon->crfid.fid_mutex);
@@ -937,8 +938,15 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	if (rc == 0)
+	if (rc) {
+		if (tcon->crfid.is_valid)
+			SMB2_close(0, tcon, oparms.fid->persistent_fid,
+				   oparms.fid->volatile_fid);
+	}
+	if (rc == 0) {
 		*cfid = &tcon->crfid;
+		atomic_inc(&tcon->num_remote_opens);
+	}
 	return rc;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index e81b886d9c67..62255b3eb1b4 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -325,7 +325,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
 	spin_lock(&sbi->s_fc_lock);
-	if (sbi->s_fc_ineligible_tid < tid)
+	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
 		sbi->s_fc_ineligible_tid = tid;
 	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
@@ -1206,7 +1206,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	if (ret == -EALREADY) {
 		/* There was an ongoing commit, check if we need to restart */
 		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
-			commit_tid > journal->j_commit_sequence)
+		    tid_gt(commit_tid, journal->j_commit_sequence))
 			goto restart_fc;
 		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0);
 		return 0;
@@ -1278,7 +1278,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (iter->i_sync_tid <= tid)
+		if (tid_geq(tid, iter->i_sync_tid))
 			ext4_fc_reset_inode(&iter->vfs_inode);
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
@@ -1308,7 +1308,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
 				&sbi->s_fc_q[FC_Q_MAIN]);
 
-	if (tid >= sbi->s_fc_ineligible_tid) {
+	if (tid_geq(tid, sbi->s_fc_ineligible_tid)) {
 		sbi->s_fc_ineligible_tid = 0;
 		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e765c0d05fea..54de457f86ea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4921,9 +4921,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
-	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
+	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
 		ext4_error_inode(inode, function, line, 0, err_str);
 		ret = -EFSCORRUPTED;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 03e224401b23..6a9f841e3313 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -490,6 +490,13 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			/* A hole? We can safely clear the dirty bit */
 			if (!buffer_mapped(bh))
 				clear_buffer_dirty(bh);
+			/*
+			 * Keeping dirty some buffer we cannot write? Make
+			 * sure to redirty the page. This happens e.g. when
+			 * doing writeout for transaction commit.
+			 */
+			if (buffer_dirty(bh) && !PageDirty(page))
+				redirty_page_for_writepage(wbc, page);
 			if (io->io_bio)
 				ext4_io_submit(io);
 			continue;
@@ -497,6 +504,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		set_buffer_async_write(bh);
+		clear_buffer_dirty(bh);
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
@@ -539,7 +547,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
 			redirty_page_for_writepage(wbc, page);
 			do {
-				clear_buffer_async_write(bh);
+				if (buffer_async_write(bh)) {
+					clear_buffer_async_write(bh);
+					set_buffer_dirty(bh);
+				}
 				bh = bh->b_this_page;
 			} while (bh != head);
 			goto unlock;
@@ -552,7 +563,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			continue;
 		io_submit_add_bh(io, inode, page, bounce_page, bh);
 		nr_submitted++;
-		clear_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 
 unlock:
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2c4cac6104c9..8702ef9ff8b9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1694,10 +1694,16 @@ __acquires(fi->lock)
 	fuse_writepage_finish(fm, wpa);
 	spin_unlock(&fi->lock);
 
-	/* After fuse_writepage_finish() aux request list is private */
+	/* After rb_erase() aux request list is private */
 	for (aux = wpa->next; aux; aux = next) {
+		struct backing_dev_info *bdi = inode_to_bdi(aux->inode);
+
 		next = aux->next;
 		aux->next = NULL;
+
+		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+		dec_node_page_state(aux->ia.ap.pages[0], NR_WRITEBACK_TEMP);
+		wb_writeout_inc(&bdi->wb);
 		fuse_writepage_free(aux);
 	}
 
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 61dfaf7b7d20..2f9555fa0cee 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -82,7 +82,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	}
 	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
 		fm->fc->no_getxattr = 1;
 		ret = -EOPNOTSUPP;
@@ -144,7 +144,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	}
 	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_LIST_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_LIST_MAX);
 	if (ret > 0 && size)
 		ret = fuse_verify_xattr_list(list, ret);
 	if (ret == -ENOSYS) {
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 57f59172d821..089dc2f51229 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1705,6 +1705,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		rc = ksmbd_session_register(conn, sess);
 		if (rc)
 			goto out_err;
+
+		conn->binding = false;
 	} else if (conn->dialect >= SMB30_PROT_ID &&
 		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
@@ -1783,6 +1785,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			sess = NULL;
 			goto out_err;
 		}
+
+		conn->binding = false;
 	}
 	work->sess = sess;
 
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 9d4222154dcc..176295137045 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -618,8 +618,10 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 		for_each_netdev(&init_net, netdev) {
 			if (netif_is_bridge_port(netdev))
 				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
+				rtnl_unlock();
 				return -ENOMEM;
+			}
 		}
 		rtnl_unlock();
 		bind_additional_ifaces = 1;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a847011f36c9..9e672aed3590 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -47,6 +47,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/in6.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <net/ipv6.h>
 #include <linux/netdevice.h>
@@ -219,6 +220,7 @@ static int __nfs_list_for_each_server(struct list_head *head,
 		ret = fn(server, data);
 		if (ret)
 			goto out;
+		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 188b8cc52e2b..33c4a97519de 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -708,6 +708,33 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	brelse(bh);
 }
 
+/**
+ * nilfs_abort_roll_forward - cleaning up after a failed rollforward recovery
+ * @nilfs: nilfs object
+ */
+static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
+{
+	struct nilfs_inode_info *ii, *n;
+	LIST_HEAD(head);
+
+	/* Abandon inodes that have read recovery data */
+	spin_lock(&nilfs->ns_inode_lock);
+	list_splice_init(&nilfs->ns_dirty_files, &head);
+	spin_unlock(&nilfs->ns_inode_lock);
+	if (list_empty(&head))
+		return;
+
+	set_nilfs_purging(nilfs);
+	list_for_each_entry_safe(ii, n, &head, i_dirty) {
+		spin_lock(&nilfs->ns_inode_lock);
+		list_del_init(&ii->i_dirty);
+		spin_unlock(&nilfs->ns_inode_lock);
+
+		iput(&ii->vfs_inode);
+	}
+	clear_nilfs_purging(nilfs);
+}
+
 /**
  * nilfs_salvage_orphan_logs - salvage logs written after the latest checkpoint
  * @nilfs: nilfs object
@@ -766,15 +793,19 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 		if (unlikely(err)) {
 			nilfs_err(sb, "error %d writing segment for recovery",
 				  err);
-			goto failed;
+			goto put_root;
 		}
 
 		nilfs_finish_roll_forward(nilfs, ri);
 	}
 
- failed:
+put_root:
 	nilfs_put_root(root);
 	return err;
+
+failed:
+	nilfs_abort_roll_forward(nilfs);
+	goto put_root;
 }
 
 /**
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index c90435e8e748..75fd6e86f18a 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1833,6 +1833,9 @@ static void nilfs_segctor_abort_construction(struct nilfs_sc_info *sci,
 	nilfs_abort_logs(&logs, ret ? : err);
 
 	list_splice_tail_init(&sci->sc_segbufs, &logs);
+	if (list_empty(&logs))
+		return; /* if the first segment buffer preparation failed */
+
 	nilfs_cancel_segusage(&logs, nilfs->ns_sufile);
 	nilfs_free_incomplete_logs(&logs, nilfs);
 
@@ -2077,7 +2080,7 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 
 		err = nilfs_segctor_begin_construction(sci, nilfs);
 		if (unlikely(err))
-			goto out;
+			goto failed;
 
 		/* Update time stamp */
 		sci->sc_seg_ctime = ktime_get_real_seconds();
@@ -2140,10 +2143,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	return err;
 
  failed_to_write:
-	if (sci->sc_stage.flags & NILFS_CF_IFILE_STARTED)
-		nilfs_redirty_inodes(&sci->sc_dirty_files);
-
  failed:
+	if (mode == SC_LSEG_SR && nilfs_sc_cstage_get(sci) >= NILFS_ST_IFILE)
+		nilfs_redirty_inodes(&sci->sc_dirty_files);
 	if (nilfs_doing_gc())
 		nilfs_redirty_inodes(&sci->sc_gc_inodes);
 	nilfs_segctor_abort_construction(sci, nilfs, err);
diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 62f8a7ac19c8..453b8efe01b6 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -95,7 +95,7 @@ static ssize_t
 nilfs_snapshot_inodes_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->inodes_count));
 }
 
@@ -103,7 +103,7 @@ static ssize_t
 nilfs_snapshot_blocks_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->blocks_count));
 }
 
@@ -116,7 +116,7 @@ static ssize_t
 nilfs_snapshot_README_show(struct nilfs_snapshot_attr *attr,
 			    struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, snapshot_readme_str);
+	return sysfs_emit(buf, snapshot_readme_str);
 }
 
 NILFS_SNAPSHOT_RO_ATTR(inodes_count);
@@ -217,7 +217,7 @@ static ssize_t
 nilfs_mounted_snapshots_README_show(struct nilfs_mounted_snapshots_attr *attr,
 				    struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, mounted_snapshots_readme_str);
+	return sysfs_emit(buf, mounted_snapshots_readme_str);
 }
 
 NILFS_MOUNTED_SNAPSHOTS_RO_ATTR(README);
@@ -255,7 +255,7 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
 
 	ncheckpoints = cpstat.cs_ncps;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ncheckpoints);
+	return sysfs_emit(buf, "%llu\n", ncheckpoints);
 }
 
 static ssize_t
@@ -278,7 +278,7 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
 
 	nsnapshots = cpstat.cs_nsss;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nsnapshots);
+	return sysfs_emit(buf, "%llu\n", nsnapshots);
 }
 
 static ssize_t
@@ -292,7 +292,7 @@ nilfs_checkpoints_last_seg_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -306,7 +306,7 @@ nilfs_checkpoints_next_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static const char checkpoints_readme_str[] =
@@ -322,7 +322,7 @@ static ssize_t
 nilfs_checkpoints_README_show(struct nilfs_checkpoints_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, checkpoints_readme_str);
+	return sysfs_emit(buf, checkpoints_readme_str);
 }
 
 NILFS_CHECKPOINTS_RO_ATTR(checkpoints_number);
@@ -353,7 +353,7 @@ nilfs_segments_segments_number_show(struct nilfs_segments_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_nsegments);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_nsegments);
 }
 
 static ssize_t
@@ -361,7 +361,7 @@ nilfs_segments_blocks_per_segment_show(struct nilfs_segments_attr *attr,
 					struct the_nilfs *nilfs,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_blocks_per_segment);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_blocks_per_segment);
 }
 
 static ssize_t
@@ -375,7 +375,7 @@ nilfs_segments_clean_segments_show(struct nilfs_segments_attr *attr,
 	ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ncleansegs);
+	return sysfs_emit(buf, "%lu\n", ncleansegs);
 }
 
 static ssize_t
@@ -395,7 +395,7 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
 		return err;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sustat.ss_ndirtysegs);
+	return sysfs_emit(buf, "%llu\n", sustat.ss_ndirtysegs);
 }
 
 static const char segments_readme_str[] =
@@ -411,7 +411,7 @@ nilfs_segments_README_show(struct nilfs_segments_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segments_readme_str);
+	return sysfs_emit(buf, segments_readme_str);
 }
 
 NILFS_SEGMENTS_RO_ATTR(segments_number);
@@ -448,7 +448,7 @@ nilfs_segctor_last_pseg_block_show(struct nilfs_segctor_attr *attr,
 	last_pseg = nilfs->ns_last_pseg;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)last_pseg);
 }
 
@@ -463,7 +463,7 @@ nilfs_segctor_last_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	last_seq = nilfs->ns_last_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_seq);
+	return sysfs_emit(buf, "%llu\n", last_seq);
 }
 
 static ssize_t
@@ -477,7 +477,7 @@ nilfs_segctor_last_seg_checkpoint_show(struct nilfs_segctor_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -491,7 +491,7 @@ nilfs_segctor_current_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	seg_seq = nilfs->ns_seg_seq;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", seg_seq);
+	return sysfs_emit(buf, "%llu\n", seg_seq);
 }
 
 static ssize_t
@@ -505,7 +505,7 @@ nilfs_segctor_current_last_full_seg_show(struct nilfs_segctor_attr *attr,
 	segnum = nilfs->ns_segnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", segnum);
+	return sysfs_emit(buf, "%llu\n", segnum);
 }
 
 static ssize_t
@@ -519,7 +519,7 @@ nilfs_segctor_next_full_seg_show(struct nilfs_segctor_attr *attr,
 	nextnum = nilfs->ns_nextnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nextnum);
+	return sysfs_emit(buf, "%llu\n", nextnum);
 }
 
 static ssize_t
@@ -533,7 +533,7 @@ nilfs_segctor_next_pseg_offset_show(struct nilfs_segctor_attr *attr,
 	pseg_offset = nilfs->ns_pseg_offset;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", pseg_offset);
+	return sysfs_emit(buf, "%lu\n", pseg_offset);
 }
 
 static ssize_t
@@ -547,7 +547,7 @@ nilfs_segctor_next_checkpoint_show(struct nilfs_segctor_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static ssize_t
@@ -575,7 +575,7 @@ nilfs_segctor_last_seg_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	ctime = nilfs->ns_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ctime);
+	return sysfs_emit(buf, "%llu\n", ctime);
 }
 
 static ssize_t
@@ -603,7 +603,7 @@ nilfs_segctor_last_nongc_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	nongc_ctime = nilfs->ns_nongc_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nongc_ctime);
+	return sysfs_emit(buf, "%llu\n", nongc_ctime);
 }
 
 static ssize_t
@@ -617,7 +617,7 @@ nilfs_segctor_dirty_data_blocks_count_show(struct nilfs_segctor_attr *attr,
 	ndirtyblks = atomic_read(&nilfs->ns_ndirtyblks);
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ndirtyblks);
+	return sysfs_emit(buf, "%u\n", ndirtyblks);
 }
 
 static const char segctor_readme_str[] =
@@ -654,7 +654,7 @@ static ssize_t
 nilfs_segctor_README_show(struct nilfs_segctor_attr *attr,
 			  struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segctor_readme_str);
+	return sysfs_emit(buf, segctor_readme_str);
 }
 
 NILFS_SEGCTOR_RO_ATTR(last_pseg_block);
@@ -723,7 +723,7 @@ nilfs_superblock_sb_write_time_secs_show(struct nilfs_superblock_attr *attr,
 	sbwtime = nilfs->ns_sbwtime;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sbwtime);
+	return sysfs_emit(buf, "%llu\n", sbwtime);
 }
 
 static ssize_t
@@ -737,7 +737,7 @@ nilfs_superblock_sb_write_count_show(struct nilfs_superblock_attr *attr,
 	sbwcount = nilfs->ns_sbwcount;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sbwcount);
+	return sysfs_emit(buf, "%u\n", sbwcount);
 }
 
 static ssize_t
@@ -751,7 +751,7 @@ nilfs_superblock_sb_update_frequency_show(struct nilfs_superblock_attr *attr,
 	sb_update_freq = nilfs->ns_sb_update_freq;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sb_update_freq);
+	return sysfs_emit(buf, "%u\n", sb_update_freq);
 }
 
 static ssize_t
@@ -799,7 +799,7 @@ static ssize_t
 nilfs_superblock_README_show(struct nilfs_superblock_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, sb_readme_str);
+	return sysfs_emit(buf, sb_readme_str);
 }
 
 NILFS_SUPERBLOCK_RO_ATTR(sb_write_time);
@@ -830,11 +830,17 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 				struct the_nilfs *nilfs,
 				char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
-	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
+	struct nilfs_super_block *raw_sb;
+	u32 major;
+	u16 minor;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n", major, minor);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	major = le32_to_cpu(raw_sb->s_rev_level);
+	minor = le16_to_cpu(raw_sb->s_minor_rev_level);
+	up_read(&nilfs->ns_sem);
+
+	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
 
 static
@@ -842,7 +848,7 @@ ssize_t nilfs_dev_blocksize_show(struct nilfs_dev_attr *attr,
 				 struct the_nilfs *nilfs,
 				 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", nilfs->ns_blocksize);
+	return sysfs_emit(buf, "%u\n", nilfs->ns_blocksize);
 }
 
 static
@@ -850,10 +856,15 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
+	struct nilfs_super_block *raw_sb;
+	u64 dev_size;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	dev_size = le64_to_cpu(raw_sb->s_dev_size);
+	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", dev_size);
+	return sysfs_emit(buf, "%llu\n", dev_size);
 }
 
 static
@@ -864,7 +875,7 @@ ssize_t nilfs_dev_free_blocks_show(struct nilfs_dev_attr *attr,
 	sector_t free_blocks = 0;
 
 	nilfs_count_free_blocks(nilfs, &free_blocks);
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)free_blocks);
 }
 
@@ -873,9 +884,15 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
 
-	return snprintf(buf, PAGE_SIZE, "%pUb\n", sbp[0]->s_uuid);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = sysfs_emit(buf, "%pUb\n", raw_sb->s_uuid);
+	up_read(&nilfs->ns_sem);
+
+	return len;
 }
 
 static
@@ -883,10 +900,16 @@ ssize_t nilfs_dev_volume_name_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = scnprintf(buf, sizeof(raw_sb->s_volume_name), "%s\n",
+			raw_sb->s_volume_name);
+	up_read(&nilfs->ns_sem);
 
-	return scnprintf(buf, sizeof(sbp[0]->s_volume_name), "%s\n",
-			 sbp[0]->s_volume_name);
+	return len;
 }
 
 static const char dev_readme_str[] =
@@ -903,7 +926,7 @@ static ssize_t nilfs_dev_README_show(struct nilfs_dev_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, dev_readme_str);
+	return sysfs_emit(buf, dev_readme_str);
 }
 
 NILFS_DEV_RO_ATTR(revision);
@@ -1047,7 +1070,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
 					    struct attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n",
+	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
 }
 
@@ -1060,7 +1083,7 @@ static ssize_t nilfs_feature_README_show(struct kobject *kobj,
 					 struct attribute *attr,
 					 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, features_readme_str);
+	return sysfs_emit(buf, features_readme_str);
 }
 
 NILFS_FEATURE_RO_ATTR(revision);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..b5d8f238fce4 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,17 +103,13 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+void fsnotify_set_children_dentry_flags(struct inode *inode)
 {
 	struct dentry *alias;
-	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	/* determine if the children should tell inode about their events */
-	watched = fsnotify_inode_watches_children(inode);
-
 	spin_lock(&inode->i_lock);
 	/* run all of the dentries associated with this inode.  Since this is a
 	 * directory, there damn well better only be one item on this list */
@@ -129,10 +125,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 				continue;
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
 			spin_unlock(&child->d_lock);
 		}
 		spin_unlock(&alias->d_lock);
@@ -140,6 +133,24 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+/*
+ * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
+ * stopped watching children.
+ */
+static void fsnotify_clear_child_dentry_flag(struct inode *pinode,
+					     struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	/*
+	 * d_lock is a sufficient barrier to prevent observing a non-watched
+	 * parent state from before the fsnotify_set_children_dentry_flags()
+	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
+	 */
+	if (!fsnotify_inode_watches_children(pinode))
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+	spin_unlock(&dentry->d_lock);
+}
+
 /* Are inode/sb/mount interested in parent and name info with this event? */
 static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
 					__u32 mask)
@@ -208,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
 	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+		fsnotify_clear_child_dentry_flag(p_inode, dentry);
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc..2b4267de86e6 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -74,7 +74,7 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern void fsnotify_set_children_dentry_flags(struct inode *inode);
 
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..4be6e883d492 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -176,6 +176,24 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	return fsnotify_update_iref(conn, want_iref);
 }
 
+static bool fsnotify_conn_watches_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return false;
+
+	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
+}
+
+static void fsnotify_conn_set_children_dentry_flags(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return;
+
+	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
+}
+
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achieve
@@ -184,15 +202,23 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	bool update_children;
+
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
+	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
+	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+	/*
+	 * Set children's PARENT_WATCHED flags only if parent started watching.
+	 * When parent stops watching, we clear false positive PARENT_WATCHED
+	 * flags lazily in __fsnotify_parent().
+	 */
+	if (update_children)
+		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index dcd689ed4baa..a4ab0164d150 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -272,9 +272,12 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 	return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
 }
 
-static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
-			       const struct NTFS_DE *e, u8 *name,
-			       struct dir_context *ctx)
+/*
+ * returns false if 'ctx' if full
+ */
+static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
+				 struct ntfs_inode *ni, const struct NTFS_DE *e,
+				 u8 *name, struct dir_context *ctx)
 {
 	const struct ATTR_FILE_NAME *fname;
 	unsigned long ino;
@@ -284,29 +287,29 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	fname = Add2Ptr(e, sizeof(struct NTFS_DE));
 
 	if (fname->type == FILE_NAME_DOS)
-		return 0;
+		return true;
 
 	if (!mi_is_ref(&ni->mi, &fname->home))
-		return 0;
+		return true;
 
 	ino = ino_get(&e->ref);
 
 	if (ino == MFT_REC_ROOT)
-		return 0;
+		return true;
 
 	/* Skip meta files. Unless option to show metafiles is set. */
 	if (!sbi->options->showmeta && ntfs_is_meta_file(sbi, ino))
-		return 0;
+		return true;
 
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
-		return 0;
+		return true;
 
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
 				     PATH_MAX);
 	if (name_len <= 0) {
 		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
 			  ino);
-		return 0;
+		return true;
 	}
 
 	/*
@@ -336,17 +339,20 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		}
 	}
 
-	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
+	return dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
 
 /*
  * ntfs_read_hdr - Helper function for ntfs_readdir().
+ *
+ * returns 0 if ok.
+ * returns -EINVAL if directory is corrupted.
+ * returns +1 if 'ctx' is full.
  */
 static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			 const struct INDEX_HDR *hdr, u64 vbo, u64 pos,
 			 u8 *name, struct dir_context *ctx)
 {
-	int err;
 	const struct NTFS_DE *e;
 	u32 e_size;
 	u32 end = le32_to_cpu(hdr->used);
@@ -354,12 +360,12 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 
 	for (;; off += e_size) {
 		if (off + sizeof(struct NTFS_DE) > end)
-			return -1;
+			return -EINVAL;
 
 		e = Add2Ptr(hdr, off);
 		e_size = le16_to_cpu(e->size);
 		if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
-			return -1;
+			return -EINVAL;
 
 		if (de_is_last(e))
 			return 0;
@@ -369,14 +375,15 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			continue;
 
 		if (le16_to_cpu(e->key_size) < SIZEOF_ATTRIBUTE_FILENAME)
-			return -1;
+			return -EINVAL;
 
 		ctx->pos = vbo + off;
 
 		/* Submit the name to the filldir callback. */
-		err = ntfs_filldir(sbi, ni, e, name, ctx);
-		if (err)
-			return err;
+		if (!ntfs_dir_emit(sbi, ni, e, name, ctx)) {
+			/* ctx is full. */
+			return +1;
+		}
 	}
 }
 
@@ -475,8 +482,6 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
-			ntfs_inode_err(dir, "Looks like your dir is corrupt");
-			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
@@ -499,9 +504,16 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	__putname(name);
 	put_indx_node(node);
 
-	if (err == -ENOENT) {
+	if (err == 1) {
+		/* 'ctx' is full. */
+		err = 0;
+	} else if (err == -ENOENT) {
 		err = 0;
 		ctx->pos = pos;
+	} else if (err < 0) {
+		if (err == -EINVAL)
+			ntfs_inode_err(dir, "directory corrupted");
+		ctx->pos = eod;
 	}
 
 	return err;
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 24463145b351..f31649080a88 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -276,8 +276,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
-		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if (inode->i_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink\n");
+			return -EINVAL;
+		}
+
+		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index e2f3d2b6c245..4275d2bc0c36 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -86,6 +86,13 @@ enum {
 #define UDF_MAX_LVID_NESTING 1000
 
 enum { UDF_MAX_LINKS = 0xffff };
+/*
+ * We limit filesize to 4TB. This is arbitrary as the on-disk format supports
+ * more but because the file space is described by a linked list of extents,
+ * each of which can have at most 1GB, the creation and handling of extents
+ * gets unusably slow beyond certain point...
+ */
+#define UDF_MAX_FILESIZE (1ULL << 42)
 
 /* These are the "meat" - everything else is stuffing */
 static int udf_fill_super(struct super_block *, void *, int);
@@ -1077,12 +1084,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	u32 sum;
 	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
 	map->s_partition_len = le32_to_cpu(p->partitionLength); /* blocks */
 	map->s_partition_root = le32_to_cpu(p->partitionStartingLocation);
+	if (check_add_overflow(map->s_partition_root, map->s_partition_len,
+			       &sum)) {
+		udf_err(sb, "Partition %d has invalid location %u + %u\n",
+			p_index, map->s_partition_root, map->s_partition_len);
+		return -EFSCORRUPTED;
+	}
 
 	if (p->accessType == cpu_to_le32(PD_ACCESS_TYPE_READ_ONLY))
 		map->s_partition_flags |= UDF_PART_FLAG_READ_ONLY;
@@ -1138,6 +1152,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		bitmap->s_extPosition = le32_to_cpu(
 				phd->unallocSpaceBitmap.extPosition);
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
+		/* Check whether math over bitmap won't overflow. */
+		if (check_add_overflow(map->s_partition_len,
+				       sizeof(struct spaceBitmapDesc) << 3,
+				       &sum)) {
+			udf_err(sb, "Partition %d is too long (%u)\n", p_index,
+				map->s_partition_len);
+			return -EFSCORRUPTED;
+		}
 		udf_debug("unallocSpaceBitmap (part %d) @ %u\n",
 			  p_index, bitmap->s_extPosition);
 	}
@@ -2302,7 +2324,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 		ret = -ENOMEM;
 		goto error_out;
 	}
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_maxbytes = UDF_MAX_FILESIZE;
 	sb->s_max_links = UDF_MAX_LINKS;
 	return 0;
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d7d96c806bff..096b79e4373f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -563,12 +563,14 @@ static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
+	__u32 parent_mask = READ_ONCE(inode->i_fsnotify_mask);
+
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	if (!(parent_mask & FS_EVENT_ON_CHILD))
 		return 0;
 	/* this inode might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
 /*
@@ -582,7 +584,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 	/*
 	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
 	 * by d_lock. If inotify_inode_watched changes after we have taken
-	 * d_lock, the following __fsnotify_update_child_dentry_flags call will
+	 * d_lock, the following fsnotify_set_children_dentry_flags call will
 	 * find our entry, so it will spin until we complete here, and update
 	 * us with the new state.
 	 */
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index bfe7c1f1ac6d..f0231dbc4777 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -68,6 +68,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
 int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
+int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
 int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock);
 struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
 struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
@@ -127,6 +128,11 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
 }
 
+static inline int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
+{
+	return 0;
+}
+
 static inline int of_hwspin_lock_get_id(struct device_node *np, int index)
 {
 	return 0;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f071a121ed91..2fb2f83bd501 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -1025,7 +1025,7 @@ static inline int of_i2c_get_board_info(struct device *dev,
 struct acpi_resource;
 struct acpi_resource_i2c_serialbus;
 
-#if IS_ENABLED(CONFIG_ACPI)
+#if IS_REACHABLE(CONFIG_ACPI) && IS_REACHABLE(CONFIG_I2C)
 bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 			       struct acpi_resource_i2c_serialbus **i2c);
 int i2c_acpi_client_count(struct acpi_device *adev);
diff --git a/include/linux/udp.h b/include/linux/udp.h
index fdf5afb39316..ca31f830b011 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -94,7 +94,7 @@ struct udp_sock {
 	int		forward_deficit;
 };
 
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 
 static inline struct udp_sock *udp_sk(const struct sock *sk)
 {
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 29b19d0a324c..823e28042f41 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,8 +3,8 @@
 #define _LINUX_VIRTIO_NET_H
 
 #include <linux/if_vlan.h>
+#include <linux/udp.h>
 #include <uapi/linux/tcp.h>
-#include <uapi/linux/udp.h>
 #include <uapi/linux/virtio_net.h>
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
@@ -51,7 +51,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
-	u64 ret, remainder, gso_size;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -88,16 +87,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
 
-		if (hdr->gso_size) {
-			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
-			ret = div64_u64_rem(skb->len, gso_size, &remainder);
-			if (!(ret && (hdr->gso_size > needed) &&
-						((remainder > needed) || (remainder == 0)))) {
-				return -EINVAL;
-			}
-			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
-		}
-
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;
 
@@ -155,9 +144,27 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* UFO may not include transport header in gso_size. */
-		if (gso_type & SKB_GSO_UDP)
+		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		case SKB_GSO_UDP:
+			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
+			break;
+		case SKB_GSO_UDP_L4:
+			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+				return -EINVAL;
+			if (skb->csum_offset != offsetof(struct udphdr, check))
+				return -EINVAL;
+			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
+				return -EINVAL;
+			if (gso_type != SKB_GSO_UDP_L4)
+				return -EINVAL;
+			break;
+		case SKB_GSO_TCPV4:
+		case SKB_GSO_TCPV6:
+			if (skb->csum_offset != offsetof(struct tcphdr, check))
+				return -EINVAL;
+			break;
+		}
 
 		/* Kernel has a special handling for GSO_BY_FRAGS. */
 		if (gso_size == GSO_BY_FRAGS)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5935610c660..f6ab6fe7fd80 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -176,7 +176,6 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -186,7 +185,6 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -201,7 +199,6 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
-	u8 link_type;
 	u8 val[16];
 };
 
@@ -209,8 +206,6 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
-	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index be467aea457e..84e85561a87c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1802,9 +1802,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1f9a8cee4224..09ccb4d6bc7b 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -447,8 +447,11 @@ void debug_dma_dump_mappings(struct device *dev)
  * dma_active_cacheline entry to track per event.  dma_map_sg(), on the
  * other hand, consumes a single dma_debug_entry, but inserts 'nents'
  * entries into the tree.
+ *
+ * Use __GFP_NOWARN because the printk from an OOM, to netconsole, could end
+ * up right back in the DMA debugging code, leading to a deadlock.
  */
-static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
+static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC | __GFP_NOWARN);
 static DEFINE_SPINLOCK(radix_lock);
 #define ACTIVE_CACHELINE_MAX_OVERLAP ((1 << RADIX_TREE_MAX_TAGS) - 1)
 #define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index fc67b39d8b38..b96d4fb8407b 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -112,6 +112,22 @@ static int map_benchmark_thread(void *data)
 		atomic64_add(map_sq, &map->sum_sq_map);
 		atomic64_add(unmap_sq, &map->sum_sq_unmap);
 		atomic64_inc(&map->loops);
+
+		/*
+		 * We may test for a long time so periodically check whether
+		 * we need to schedule to avoid starving the others. Otherwise
+		 * we may hangup the kernel in a non-preemptible kernel when
+		 * the test kthreads number >= CPU number, the test kthreads
+		 * will run endless on every CPU since the thread resposible
+		 * for notifying the kthread stop (in do_map_benchmark())
+		 * could not be scheduled.
+		 *
+		 * Note this may degrade the test concurrency since the test
+		 * threads may need to share the CPU time with other load
+		 * in the system. So it's recommended to run this benchmark
+		 * on an idle system.
+		 */
+		cond_resched();
 	}
 
 out:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9f3da1e05e46..09f03377af17 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1368,8 +1368,9 @@ static void put_ctx(struct perf_event_context *ctx)
  *	  perf_event_context::mutex
  *	    perf_event::child_mutex;
  *	      perf_event_context::lock
- *	    perf_event::mmap_mutex
  *	    mmap_lock
+ *	      perf_event::mmap_mutex
+ *	        perf_buffer::aux_mutex
  *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
@@ -6275,12 +6276,11 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		event->pmu->event_unmapped(event, vma->vm_mm);
 
 	/*
-	 * rb->aux_mmap_count will always drop before rb->mmap_count and
-	 * event->mmap_count, so it is ok to use event->mmap_mutex to
-	 * serialize with perf_mmap here.
+	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
+	 * to avoid complications.
 	 */
 	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
-	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &event->mmap_mutex)) {
+	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
 		/*
 		 * Stop all AUX events that are writing to this buffer,
 		 * so that we can free its AUX pages and corresponding PMU
@@ -6297,7 +6297,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		rb_free_aux(rb);
 		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
-		mutex_unlock(&event->mmap_mutex);
+		mutex_unlock(&rb->aux_mutex);
 	}
 
 	if (atomic_dec_and_test(&rb->mmap_count))
@@ -6385,6 +6385,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	struct perf_event *event = file->private_data;
 	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user = current_user();
+	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	unsigned long locked, lock_limit;
 	unsigned long vma_size;
@@ -6433,6 +6434,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		if (!rb)
 			goto aux_unlock;
 
+		aux_mutex = &rb->aux_mutex;
+		mutex_lock(aux_mutex);
+
 		aux_offset = READ_ONCE(rb->user_page->aux_offset);
 		aux_size = READ_ONCE(rb->user_page->aux_size);
 
@@ -6583,6 +6587,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
+	if (aux_mutex)
+		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
 	/*
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 386d21c7edfa..f376b057320c 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -40,6 +40,7 @@ struct perf_buffer {
 	struct user_struct		*mmap_user;
 
 	/* AUX area */
+	struct mutex			aux_mutex;
 	long				aux_head;
 	unsigned int			aux_nest;
 	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index f3a3c294ff2b..98588e96b591 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -332,6 +332,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
 	 */
 	if (!rb->nr_pages)
 		rb->paused = 1;
+
+	mutex_init(&rb->aux_mutex);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af24dc3febbe..aa9134cd5d00 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1484,7 +1484,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 	struct xol_area *area;
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		goto out;
 
@@ -1494,7 +1494,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		goto free_area;
 
 	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ee5be1dda0c4..cf72ef77bfe7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1613,6 +1613,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 }
 
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1625,10 +1626,10 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	if (build_ww_mutex() && w->ww_ctx)
 		return;
 
-	/*
-	 * Yell loudly and stop the task right here.
-	 */
+	raw_spin_unlock_irq(&lock->wait_lock);
+
 	WARN(1, "rtmutex deadlock detected\n");
+
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
@@ -1680,7 +1681,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
 
 	/*
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b24ef77325ee..0e50ec9ded86 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1323,7 +1323,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	snprintf(buf, sizeof(buf), "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2da96d8b894a..f27d3e3fe4ed 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -205,7 +205,6 @@ struct rcu_data {
 	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
-	atomic_t nocb_lock_contended;	/* Contention experienced. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8fdf44f8523f..d170dc1f3719 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -88,8 +88,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
  * Acquire the specified rcu_data structure's ->nocb_bypass_lock.  If the
- * lock isn't immediately available, increment ->nocb_lock_contended to
- * flag the contention.
+ * lock isn't immediately available, perform minimal sanity check.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	__acquires(&rdp->nocb_bypass_lock)
@@ -97,29 +96,12 @@ static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
 		return;
-	atomic_inc(&rdp->nocb_lock_contended);
+	/*
+	 * Contention expected only when local enqueue collide with
+	 * remote flush from kthreads.
+	 */
 	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	smp_mb__after_atomic(); /* atomic_inc() before lock. */
 	raw_spin_lock(&rdp->nocb_bypass_lock);
-	smp_mb__before_atomic(); /* atomic_dec() after lock. */
-	atomic_dec(&rdp->nocb_lock_contended);
-}
-
-/*
- * Spinwait until the specified rcu_data structure's ->nocb_lock is
- * not contended.  Please note that this is extremely special-purpose,
- * relying on the fact that at most two kthreads and one CPU contend for
- * this lock, and also that the two kthreads are guaranteed to have frequent
- * grace-period-duration time intervals between successive acquisitions
- * of the lock.  This allows us to use an extremely simple throttling
- * mechanism, and further to apply it only to the CPU doing floods of
- * call_rcu() invocations.  Don't try this at home!
- */
-static void rcu_nocb_wait_contended(struct rcu_data *rdp)
-{
-	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	while (WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended)))
-		cpu_relax();
 }
 
 /*
@@ -457,7 +439,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	}
 
 	// We need to use the bypass.
-	rcu_nocb_wait_contended(rdp);
 	rcu_nocb_bypass_lock(rdp);
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
@@ -1361,12 +1342,11 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 
 	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
-		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
 		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
 		"sS"[!!rdp->nocb_cb_sleep],
 		".W"[swait_active(&rdp->nocb_cb_wq)],
diff --git a/kernel/smp.c b/kernel/smp.c
index 82825345432c..b60525b34ab0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1233,6 +1233,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ab56c8a61ec9..a1d034b7300a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4068,6 +4068,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d5f30b610217..73002260674f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5935,10 +5935,18 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 
 notrace void wq_watchdog_touch(int cpu)
 {
+	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
+	unsigned long touch_ts = READ_ONCE(wq_watchdog_touched);
+	unsigned long now = jiffies;
+
 	if (cpu >= 0)
-		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
+		per_cpu(wq_watchdog_touched_cpu, cpu) = now;
+	else
+		WARN_ONCE(1, "%s should be called with valid CPU", __func__);
 
-	wq_watchdog_touched = jiffies;
+	/* Don't unnecessarily store to global cacheline */
+	if (time_after(now, touch_ts + thresh / 4))
+		WRITE_ONCE(wq_watchdog_touched, jiffies);
 }
 
 static void wq_watchdog_set_thresh(unsigned long thresh)
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index f25eb111c051..34d3ac52de89 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -131,6 +131,8 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
 			v = new_root;
 			new_node = NULL;
+		} else {
+			new_node->children[0] = NULL;
 		}
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69dd12a79942..6dd32ed164ea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5083,11 +5083,28 @@ static struct cftype mem_cgroup_legacy_files[] = {
  */
 
 static DEFINE_IDR(mem_cgroup_idr);
+static DEFINE_SPINLOCK(memcg_idr_lock);
+
+static int mem_cgroup_alloc_id(void)
+{
+	int ret;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&memcg_idr_lock);
+	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
+			GFP_NOWAIT);
+	spin_unlock(&memcg_idr_lock);
+	idr_preload_end();
+	return ret;
+}
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		spin_lock(&memcg_idr_lock);
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		spin_unlock(&memcg_idr_lock);
+
 		memcg->id.id = 0;
 	}
 }
@@ -5201,9 +5218,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
-				 GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -5244,7 +5259,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
 #endif
+	spin_lock(&memcg_idr_lock);
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	spin_unlock(&memcg_idr_lock);
 	return memcg;
 fail:
 	mem_cgroup_id_remove(memcg);
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 8710d5d7d3c1..29c326f98743 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -483,10 +483,9 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 
 	type = vhdr->h_vlan_encapsulated_proto;
 
-	rcu_read_lock();
 	ptype = gro_find_receive_by_type(type);
 	if (!ptype)
-		goto out_unlock;
+		goto out;
 
 	flush = 0;
 
@@ -508,8 +507,6 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 					    ipv6_gro_receive, inet_gro_receive,
 					    head, skb);
 
-out_unlock:
-	rcu_read_unlock();
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
@@ -523,14 +520,12 @@ static int vlan_gro_complete(struct sk_buff *skb, int nhoff)
 	struct packet_offload *ptype;
 	int err = -ENOENT;
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
 					 skb, nhoff + sizeof(*vhdr));
 
-	rcu_read_unlock();
 	return err;
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f59775973cdf..a54eb754e9a7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2375,16 +2375,6 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "debug_keys %u key_count %u", cp->debug_keys,
 		   key_count);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_link_key_info *key = &cp->keys[i];
-
-		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
-		if (key->type > 0x08)
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_LOAD_LINK_KEYS,
-					       MGMT_STATUS_INVALID_PARAMS);
-	}
-
 	hci_dev_lock(hdev);
 
 	hci_link_keys_clear(hdev);
@@ -2409,6 +2399,19 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (key->addr.type != BDADDR_BREDR) {
+			bt_dev_warn(hdev,
+				    "Invalid link address type %u for %pMR",
+				    key->addr.type, &key->addr.bdaddr);
+			continue;
+		}
+
+		if (key->type > 0x08) {
+			bt_dev_warn(hdev, "Invalid link key type %u for %pMR",
+				    key->type, &key->addr.bdaddr);
+			continue;
+		}
+
 		/* Always ignore debug keys and require a new pairing if
 		 * the user wants to use them.
 		 */
@@ -6185,7 +6188,6 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
-		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -6195,12 +6197,8 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (irk->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    addr_type, irk->val,
+			    le_addr_type(irk->addr.type), irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -6265,15 +6263,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "key_count %u", key_count);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_ltk_info *key = &cp->keys[i];
-
-		if (!ltk_is_valid(key))
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_LOAD_LONG_TERM_KEYS,
-					       MGMT_STATUS_INVALID_PARAMS);
-	}
-
 	hci_dev_lock(hdev);
 
 	hci_smp_ltks_clear(hdev);
@@ -6281,7 +6270,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
-		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -6291,6 +6279,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
+		if (!ltk_is_valid(key)) {
+			bt_dev_warn(hdev, "Invalid LTK for %pMR",
+				    &key->addr.bdaddr);
+			continue;
+		}
+
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
@@ -6316,12 +6310,8 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (key->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    addr_type, type, authenticated,
+			    le_addr_type(key->addr.type), type, authenticated,
 			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
@@ -8688,7 +8678,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = BDADDR_BREDR;
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -8739,7 +8729,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -8768,7 +8758,7 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -8797,7 +8787,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 629d25bc7f67..724dc901eaf2 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1059,7 +1059,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1074,28 +1073,24 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->csrk) {
-		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->responder_csrk) {
-		smp->responder_csrk->link_type = hcon->type;
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
-		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->responder_ltk) {
-		smp->responder_ltk->link_type = hcon->type;
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
@@ -1115,8 +1110,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
-			key->link_type = hcon->type;
-			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 46812b659710..83ec74b67340 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1299,12 +1299,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
-		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used = jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-			/* Take over SW learned entry */
-			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		} else {
 			modified = true;
 		}
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a2fd68d1149b..8c039638b196 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1423,6 +1423,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
+#if IS_ENABLED(CONFIG_PROC_FS)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+#endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
 			notify_enodev = 1;
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 9ad4a15232af..ab2ef6250142 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -425,11 +425,10 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	type = eh->h_proto;
 
-	rcu_read_lock();
 	ptype = gro_find_receive_by_type(type);
 	if (ptype == NULL) {
 		flush = 1;
-		goto out_unlock;
+		goto out;
 	}
 
 	skb_gro_pull(skb, sizeof(*eh));
@@ -439,8 +438,6 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb)
 					    ipv6_gro_receive, inet_gro_receive,
 					    head, skb);
 
-out_unlock:
-	rcu_read_unlock();
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
@@ -458,14 +455,12 @@ int eth_gro_complete(struct sk_buff *skb, int nhoff)
 	if (skb->encapsulation)
 		skb_set_inner_mac_header(skb, nhoff);
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype != NULL)
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
 					 skb, nhoff + sizeof(*eh));
 
-	rcu_read_unlock();
 	return err;
 }
 EXPORT_SYMBOL(eth_gro_complete);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 20cdd0efb95b..b225e049daea 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1477,19 +1477,18 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	proto = iph->protocol;
 
-	rcu_read_lock();
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (!ops || !ops->callbacks.gro_receive)
-		goto out_unlock;
+		goto out;
 
 	if (*(u8 *)iph != 0x45)
-		goto out_unlock;
+		goto out;
 
 	if (ip_is_fragment(iph))
-		goto out_unlock;
+		goto out;
 
 	if (unlikely(ip_fast_csum((u8 *)iph, 5)))
-		goto out_unlock;
+		goto out;
 
 	id = ntohl(*(__be32 *)&iph->id);
 	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id & ~IP_DF));
@@ -1566,9 +1565,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	pp = indirect_call_gro_receive(tcp4_gro_receive, udp4_gro_receive,
 				       ops->callbacks.gro_receive, head, skb);
 
-out_unlock:
-	rcu_read_unlock();
-
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
@@ -1643,10 +1639,9 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 	csum_replace2(&iph->check, iph->tot_len, newlen);
 	iph->tot_len = newlen;
 
-	rcu_read_lock();
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	/* Only need to add sizeof(*iph) to get to the next hdr below
 	 * because any hdr with option will have been flushed in
@@ -1656,9 +1651,7 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 			      tcp4_gro_complete, udp4_gro_complete,
 			      skb, nhoff + sizeof(*iph));
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return err;
 }
 
diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 8fcbc6258ec5..135da756dd5a 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -48,7 +48,7 @@ struct fou_net {
 
 static inline struct fou *fou_from_sock(struct sock *sk)
 {
-	return sk->sk_user_data;
+	return rcu_dereference_sk_user_data(sk);
 }
 
 static int fou_recv_pull(struct sk_buff *skb, struct fou *fou, size_t len)
@@ -231,9 +231,15 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 				       struct sk_buff *skb)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
+	u8 proto;
+
+	if (!fou)
+		goto out;
+
+	proto = fou->protocol;
 
 	/* We can clear the encap_mark for FOU as we are essentially doing
 	 * one of two possible things.  We are either adding an L4 tunnel
@@ -246,17 +252,14 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (!ops || !ops->callbacks.gro_receive)
-		goto out_unlock;
+		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return pp;
 }
 
@@ -264,23 +267,30 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	int err = -ENOSYS;
+	u8 proto;
+	int err;
+
+	if (!fou) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	proto = fou->protocol;
 
-	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
+		err = -ENOSYS;
+		goto out;
+	}
 
 	err = ops->callbacks.gro_complete(skb, nhoff);
 
 	skb_set_inner_mac_header(skb, nhoff);
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return err;
 }
 
@@ -324,6 +334,9 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	struct gro_remcsum grc;
 	u8 proto;
 
+	if (!fou)
+		goto out;
+
 	skb_gro_remcsum_init(&grc);
 
 	off = skb_gro_offset(skb);
@@ -438,17 +451,14 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
-		goto out_unlock;
+		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
 	flush = 0;
 
-out_unlock:
-	rcu_read_unlock();
 out:
 	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
 
@@ -485,18 +495,16 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 		return err;
 	}
 
-	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	err = ops->callbacks.gro_complete(skb, nhoff + guehlen);
 
 	skb_set_inner_mac_header(skb, nhoff + guehlen);
 
-out_unlock:
-	rcu_read_unlock();
+out:
 	return err;
 }
 
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 1121a9d5fed9..9a18fd1d5648 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -162,10 +162,9 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 
 	type = greh->protocol;
 
-	rcu_read_lock();
 	ptype = gro_find_receive_by_type(type);
 	if (!ptype)
-		goto out_unlock;
+		goto out;
 
 	grehlen = GRE_HEADER_SECTION;
 
@@ -179,13 +178,13 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 	if (skb_gro_header_hard(skb, hlen)) {
 		greh = skb_gro_header_slow(skb, hlen, off);
 		if (unlikely(!greh))
-			goto out_unlock;
+			goto out;
 	}
 
 	/* Don't bother verifying checksum if we're going to flush anyway. */
 	if ((greh->flags & GRE_CSUM) && !NAPI_GRO_CB(skb)->flush) {
 		if (skb_gro_checksum_simple_validate(skb))
-			goto out_unlock;
+			goto out;
 
 		skb_gro_checksum_try_convert(skb, IPPROTO_GRE,
 					     null_compute_pseudo);
@@ -229,8 +228,6 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
-out_unlock:
-	rcu_read_unlock();
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
@@ -255,13 +252,10 @@ static int gre_gro_complete(struct sk_buff *skb, int nhoff)
 	if (greh->flags & GRE_CSUM)
 		grehlen += GRE_HEADER_SECTION;
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
 		err = ptype->callbacks.gro_complete(skb, nhoff + grehlen);
 
-	rcu_read_unlock();
-
 	skb_set_inner_mac_header(skb, nhoff + grehlen);
 
 	return err;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 5fdef5ddfbbe..93f6a20f5152 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -533,7 +533,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		err = sk_stream_error(sk, msg->msg_flags, err);
 	release_sock(sk);
 	sk_psock_put(sk, psock);
-	return copied ? copied : err;
+	return copied > 0 ? copied : err;
 }
 
 static int tcp_bpf_sendpage(struct sock *sk, struct page *page, int offset,
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fc61cd3fea65..357d3be04f84 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -71,6 +71,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+	if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+		goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index c61268849948..19a413aad063 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -272,13 +272,25 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (unlikely(skb_checksum_start(gso_skb) !=
+		     skb_transport_header(gso_skb) &&
+		     !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)))
+		return ERR_PTR(-EINVAL);
+
+	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
+							     mss);
+		return NULL;
+	}
+
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
@@ -618,13 +630,11 @@ struct sk_buff *udp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 					     inet_gro_compute_pseudo);
 skip:
 	NAPI_GRO_CB(skb)->is_ipv6 = 0;
-	rcu_read_lock();
 
 	if (static_branch_unlikely(&udp_encap_needed_key))
 		sk = udp4_gro_lookup_skb(skb, uh->source, uh->dest);
 
 	pp = udp_gro_receive(head, skb, uh, sk);
-	rcu_read_unlock();
 	return pp;
 
 flush:
@@ -659,7 +669,6 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 
 	uh->len = newlen;
 
-	rcu_read_lock();
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
 	if (sk && udp_sk(sk)->gro_complete) {
@@ -680,7 +689,6 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	} else {
 		err = udp_gro_complete_segment(skb);
 	}
-	rcu_read_unlock();
 
 	if (skb->remcsum_offload)
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TUNNEL_REMCSUM;
diff --git a/net/ipv6/ila/ila.h b/net/ipv6/ila/ila.h
index ad5f6f6ba333..85b92917849b 100644
--- a/net/ipv6/ila/ila.h
+++ b/net/ipv6/ila/ila.h
@@ -108,6 +108,7 @@ int ila_lwt_init(void);
 void ila_lwt_fini(void);
 
 int ila_xlat_init_net(struct net *net);
+void ila_xlat_pre_exit_net(struct net *net);
 void ila_xlat_exit_net(struct net *net);
 
 int ila_xlat_nl_cmd_add_mapping(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ipv6/ila/ila_main.c b/net/ipv6/ila/ila_main.c
index 36c58aa257e8..a5b0365c5e48 100644
--- a/net/ipv6/ila/ila_main.c
+++ b/net/ipv6/ila/ila_main.c
@@ -71,6 +71,11 @@ static __net_init int ila_init_net(struct net *net)
 	return err;
 }
 
+static __net_exit void ila_pre_exit_net(struct net *net)
+{
+	ila_xlat_pre_exit_net(net);
+}
+
 static __net_exit void ila_exit_net(struct net *net)
 {
 	ila_xlat_exit_net(net);
@@ -78,6 +83,7 @@ static __net_exit void ila_exit_net(struct net *net)
 
 static struct pernet_operations ila_net_ops = {
 	.init = ila_init_net,
+	.pre_exit = ila_pre_exit_net,
 	.exit = ila_exit_net,
 	.id   = &ila_net_id,
 	.size = sizeof(struct ila_net),
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 163668531a57..1f7b674b7c58 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -616,6 +616,15 @@ int ila_xlat_init_net(struct net *net)
 	return 0;
 }
 
+void ila_xlat_pre_exit_net(struct net *net)
+{
+	struct ila_net *ilan = net_generic(net, ila_net_id);
+
+	if (ilan->xlat.hooks_registered)
+		nf_unregister_net_hooks(net, ila_nf_hook_ops,
+					ARRAY_SIZE(ila_nf_hook_ops));
+}
+
 void ila_xlat_exit_net(struct net *net)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -623,10 +632,6 @@ void ila_xlat_exit_net(struct net *net)
 	rhashtable_free_and_destroy(&ilan->xlat.rhash_table, ila_free_cb, NULL);
 
 	free_bucket_spinlocks(ilan->xlat.locks);
-
-	if (ilan->xlat.hooks_registered)
-		nf_unregister_net_hooks(net, ila_nf_hook_ops,
-					ARRAY_SIZE(ila_nf_hook_ops));
 }
 
 static int ila_xlat_addr(struct sk_buff *skb, bool sir2ila)
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 172565d12570..30c56143d79b 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -210,7 +210,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 
 	flush += ntohs(iph->payload_len) != skb_gro_len(skb);
 
-	rcu_read_lock();
 	proto = iph->nexthdr;
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (!ops || !ops->callbacks.gro_receive) {
@@ -223,7 +222,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 
 		ops = rcu_dereference(inet6_offloads[proto]);
 		if (!ops || !ops->callbacks.gro_receive)
-			goto out_unlock;
+			goto out;
 
 		iph = ipv6_hdr(skb);
 	}
@@ -281,9 +280,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	pp = indirect_call_gro_receive_l4(tcp6_gro_receive, udp6_gro_receive,
 					 ops->callbacks.gro_receive, head, skb);
 
-out_unlock:
-	rcu_read_unlock();
-
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
@@ -333,18 +329,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	iph->payload_len = htons(skb->len - nhoff - sizeof(*iph));
 
-	rcu_read_lock();
-
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	err = INDIRECT_CALL_L4(ops->callbacks.gro_complete, tcp6_gro_complete,
 			       udp6_gro_complete, skb, nhoff);
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return err;
 }
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 28f63c01a595..f93195fcc059 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -144,13 +144,11 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 skip:
 	NAPI_GRO_CB(skb)->is_ipv6 = 1;
-	rcu_read_lock();
 
 	if (static_branch_unlikely(&udpv6_encap_needed_key))
 		sk = udp6_gro_lookup_skb(skb, uh->source, uh->dest);
 
 	pp = udp_gro_receive(head, skb, uh, sk);
-	rcu_read_unlock();
 	return pp;
 
 flush:
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2baed0c01922..e654701685a8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -112,7 +112,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
 			 version, flags, opsize, mp_opt->sndr_key,
 			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
@@ -126,7 +126,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 4;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
@@ -137,19 +137,19 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 8;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_ACK;
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
-			pr_debug("MP_JOIN hmac");
+			pr_debug("MP_JOIN hmac\n");
 		}
 		break;
 
 	case MPTCPOPT_DSS:
-		pr_debug("DSS");
+		pr_debug("DSS\n");
 		ptr++;
 
 		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
@@ -164,7 +164,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
 			 mp_opt->data_fin, mp_opt->dsn64,
 			 mp_opt->use_map, mp_opt->ack64,
 			 mp_opt->use_ack);
@@ -202,7 +202,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 4;
 			}
 
-			pr_debug("data_ack=%llu", mp_opt->data_ack);
+			pr_debug("data_ack=%llu\n", mp_opt->data_ack);
 		}
 
 		if (mp_opt->use_map) {
@@ -226,7 +226,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 2;
 			}
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
 				 mp_opt->csum);
@@ -288,7 +288,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ahmac = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
+		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d\n",
 			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
 		break;
@@ -304,7 +304,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->rm_list.nr = opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
 		for (i = 0; i < mp_opt->rm_list.nr; i++)
 			mp_opt->rm_list.ids[i] = *ptr++;
-		pr_debug("RM_ADDR: rm_list_nr=%d", mp_opt->rm_list.nr);
+		pr_debug("RM_ADDR: rm_list_nr=%d\n", mp_opt->rm_list.nr);
 		break;
 
 	case MPTCPOPT_MP_PRIO:
@@ -313,7 +313,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
-		pr_debug("MP_PRIO: prio=%d", mp_opt->backup);
+		pr_debug("MP_PRIO: prio=%d\n", mp_opt->backup);
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
@@ -346,7 +346,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
 		mp_opt->fail_seq = get_unaligned_be64(ptr);
-		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
+		pr_debug("MP_FAIL: data_seq=%llu\n", mp_opt->fail_seq);
 		break;
 
 	default:
@@ -409,7 +409,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
+		pr_debug("remote_token=%u, nonce=%u\n", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
@@ -493,7 +493,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 			*size = TCPOLEN_MPTCP_MPC_ACK;
 		}
 
-		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
+		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d\n",
 			 subflow, subflow->local_key, subflow->remote_key,
 			 data_len);
 
@@ -502,7 +502,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
-		pr_debug("subflow=%p", subflow);
+		pr_debug("subflow=%p\n", subflow);
 
 		/* we can use the full delegate action helper only from BH context
 		 * If we are in process context - sk is flushing the backlog at
@@ -671,7 +671,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 
 	*size = len;
 	if (drop_other_suboptions) {
-		pr_debug("drop other suboptions");
+		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
 
 		/* note that e.g. DSS could have written into the memory
@@ -688,7 +688,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 						     msk->remote_key,
 						     &opts->addr);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
 	return true;
@@ -719,7 +719,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	opts->rm_list = rm_list;
 
 	for (i = 0; i < opts->rm_list.nr; i++)
-		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
+		pr_debug("rm_list_ids[%d]=%d\n", i, opts->rm_list.ids[i]);
 
 	return true;
 }
@@ -747,7 +747,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_PRIO;
 	opts->backup = subflow->request_bkup;
 
-	pr_debug("prio=%d", opts->backup);
+	pr_debug("prio=%d\n", opts->backup);
 
 	return true;
 }
@@ -787,7 +787,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_FAIL;
 	opts->fail_seq = subflow->map_seq;
 
-	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
 
 	return true;
 }
@@ -872,7 +872,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->csum_reqd = subflow_req->csum_reqd;
 		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=%p, local_key=%llu",
+		pr_debug("subflow_req=%p, local_key=%llu\n",
 			 subflow_req, subflow_req->local_key);
 		return true;
 	} else if (subflow_req->mp_join) {
@@ -881,7 +881,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
-		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u",
+		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 			 subflow_req, opts->backup, opts->join_id,
 			 opts->thmac, opts->nonce);
 		*size = TCPOLEN_MPTCP_MPJ_SYNACK;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55e8407bcc25..b14eb6bccd36 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,7 +20,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
+	pr_debug("msk=%p, local_id=%d, echo=%d\n", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -45,7 +45,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 {
 	u8 rm_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=%d", rm_addr);
@@ -61,7 +61,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list)
 {
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
@@ -75,7 +75,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d\n", msk, msk->token, server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
@@ -89,7 +89,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -113,7 +113,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 				   enum mptcp_pm_status new_status)
 {
-	pr_debug("msk=%p status=%x new=%lx", msk, msk->pm.status,
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
 		 BIT(new_status));
 	if (msk->pm.status & BIT(new_status))
 		return false;
@@ -128,7 +128,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -152,14 +152,14 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!READ_ONCE(pm->work_pending))
 		return;
@@ -174,7 +174,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
@@ -182,14 +182,16 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
+	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
 	mptcp_event_addr_announced(msk, addr);
 
 	spin_lock_bh(&pm->lock);
 
-	if (!READ_ONCE(pm->accept_addr)) {
+	/* id0 should not have a different address */
+	if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+	    (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
@@ -202,11 +204,11 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 }
 
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -230,7 +232,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	u8 i;
 
-	pr_debug("msk=%p remote_ids_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
 
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
@@ -255,12 +257,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
-	pr_debug("fail_seq=%llu", fail_seq);
+	pr_debug("fail_seq=%llu\n", fail_seq);
 }
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1ae164711783..932be4bc1274 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -60,7 +60,7 @@ struct pm_nl_pernet {
 #define ADD_ADDR_RETRANS_MAX	3
 
 static bool addresses_equal(const struct mptcp_addr_info *a,
-			    struct mptcp_addr_info *b, bool use_port)
+			    const struct mptcp_addr_info *b, bool use_port)
 {
 	bool addr_equals = false;
 
@@ -123,7 +123,7 @@ static void remote_address(const struct sock_common *skc,
 }
 
 static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    struct mptcp_addr_info *saddr)
+				    const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -141,16 +141,19 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 }
 
 static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    struct mptcp_addr_info *daddr)
+				    const struct mptcp_addr_info *daddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}
@@ -158,12 +161,14 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     struct mptcp_sock *msk)
+		     struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
-	struct sock *sk = (struct sock *)msk;
+	const struct sock *sk = (const struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -187,18 +192,22 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		 * pending join
 		 */
 		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
-			ret = entry;
+			*new_entry = *entry;
+			found = true;
 			break;
 		}
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 	int i = 0;
 
 	rcu_read_lock();
@@ -211,24 +220,26 @@ select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 		if (i++ == pos) {
-			ret = entry;
+			*new_entry = *entry;
+			found = true;
 			break;
 		}
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	const struct pm_nl_pernet *pernet;
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet = net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
 
-unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -237,7 +248,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
 
-unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -246,7 +257,7 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
 
-unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -264,8 +275,8 @@ static void check_work_pending(struct mptcp_sock *msk)
 }
 
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-				struct mptcp_addr_info *addr)
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -306,7 +317,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!msk)
 		return;
@@ -325,7 +336,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
@@ -346,7 +357,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr, bool check_id)
+		       const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -364,7 +375,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     struct mptcp_pm_addr_entry *entry)
+				     const struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -398,7 +409,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.anno_list, &free_list);
@@ -410,8 +421,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
-static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
-				  struct mptcp_addr_info *addr)
+static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
+				  const struct mptcp_addr_info *addr)
 {
 	int i;
 
@@ -474,7 +485,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -493,13 +504,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet,
-					      msk->pm.add_addr_signaled);
-
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+		if (select_signal_address(pernet, msk->pm.add_addr_signaled,
+					  &local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local)) {
 				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
+				mptcp_pm_announce_addr(msk, &local.addr, false);
 				mptcp_pm_nl_addr_send_ack(msk);
 			}
 		} else {
@@ -514,9 +523,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	if (msk->pm.local_addr_used < local_addr_max &&
 	    msk->pm.subflows < subflows_max &&
 	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
-		local = select_local_address(pernet, msk);
-		if (local) {
-			bool fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		if (select_local_address(pernet, msk, &local)) {
+			bool fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 			int i, nr;
 
@@ -525,7 +533,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
 			spin_unlock_bh(&msk->pm.lock);
 			for (i = 0; i < nr; i++)
-				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+				__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
@@ -554,7 +562,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info local;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -562,6 +570,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -580,7 +590,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();
@@ -589,6 +605,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
 		local.family = msk->pm.remote.family;
 
@@ -613,7 +631,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("accepted %d:%d remote family %d",
+	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
@@ -654,6 +672,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_addr_send_ack(msk);
 }
 
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	remote_address((struct sock_common *)msk, &mpc_remote);
+	return addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -666,16 +693,18 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	__mptcp_flush_join_list(msk);
-	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
+			spin_unlock_bh(&msk->pm.lock);
+			pr_debug("send ack for %s\n",
+				 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
-		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
+			mptcp_subflow_send_ack(ssk);
+			spin_lock_bh(&msk->pm.lock);
+			break;
+		}
 	}
 }
 
@@ -685,7 +714,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 {
 	struct mptcp_subflow_context *subflow;
 
-	pr_debug("bkup=%d", bkup);
+	pr_debug("bkup=%d\n", bkup);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -703,7 +732,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 
 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for mp_prio");
+		pr_debug("send ack for mp_prio\n");
 		mptcp_subflow_send_ack(ssk);
 		spin_lock_bh(&msk->pm.lock);
 
@@ -721,7 +750,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	u8 i;
 
-	pr_debug("%s rm_list_nr %d",
+	pr_debug("%s rm_list_nr %d\n",
 		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
 
 	msk_owned_by_me(msk);
@@ -743,13 +772,16 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow->local_id;
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
+
 			if (rm_type == MPTCP_MIB_RMADDR)
 				id = subflow->remote_id;
 
 			if (rm_list->ids[i] != id)
 				continue;
 
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u",
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u\n",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
 				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
 			spin_unlock_bh(&msk->pm.lock);
@@ -757,7 +789,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			msk->pm.subflows--;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
@@ -767,9 +799,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+		if (rm_type == MPTCP_MIB_RMADDR && rm_list->ids[i] &&
+		    msk->pm.add_addr_accepted != 0) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
 			msk->pm.local_addr_used--;
 		}
@@ -795,7 +831,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	pr_debug("msk=%p status=%x", msk, pm->status);
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
@@ -1315,7 +1351,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 }
 
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr)
+				      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1330,7 +1366,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr,
+				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
@@ -1355,7 +1391,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 	long s_slot = 0, s_num = 0;
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	pr_debug("remove_id=%d", addr->id);
+	pr_debug("remove_id=%d\n", addr->id);
 
 	list.ids[list.nr++] = addr->id;
 
@@ -1498,8 +1534,14 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 148da412ee76..da2a1a150bc6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -136,7 +136,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -170,7 +170,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = READ_ONCE(msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -577,7 +577,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	}
 
-	pr_debug("msk=%p ssk=%p", msk, ssk);
+	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -656,7 +656,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
-	pr_debug("msk=%p empty=%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
+	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -678,7 +678,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d",
+			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
@@ -1328,7 +1328,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	size_t copy;
 	int i;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	if (WARN_ON_ONCE(info->sent > info->limit ||
@@ -1425,7 +1425,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	mpext->use_map = 1;
 	mpext->dsn64 = 1;
 
-	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d\n",
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 
@@ -1812,7 +1812,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
@@ -2136,7 +2136,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			}
 		}
 
-		pr_debug("block timeout %ld", timeo);
+		pr_debug("block timeout %ld\n", timeo);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
@@ -2146,7 +2146,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tcp_recv_timestamp(msg, sk, &tss);
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
+	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
 		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
 		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
@@ -2337,6 +2337,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 	__mptcp_close_ssk(sk, ssk, subflow);
@@ -2355,8 +2361,11 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ssk_state = inet_sk_state_load(ssk);
 
-		if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		if (ssk_state != TCP_CLOSE &&
+		    (ssk_state != TCP_CLOSE_WAIT ||
+		     inet_sk_state_load((struct sock *)ssk) != TCP_ESTABLISHED))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
@@ -2620,7 +2629,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
-			pr_debug("Fallback");
+			pr_debug("Fallback\n");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
 
@@ -2630,7 +2639,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
 			mptcp_schedule_work(sk);
 		} else {
-			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_rtx_timer_pending(sk))
 				mptcp_reset_rtx_timer(sk);
@@ -2673,7 +2682,7 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu",
+	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu\n",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
 		 msk->snd_nxt, msk->write_seq);
 
@@ -2698,7 +2707,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d",
+	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d\n",
 		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
 		 !!mptcp_send_head(sk));
 
@@ -2715,7 +2724,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	LIST_HEAD(conn_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	might_sleep();
 
@@ -2788,7 +2797,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 		inet_sk_state_store(sk, TCP_CLOSE);
 
 	sock_hold(sk);
-	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
@@ -2995,12 +3004,12 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		return NULL;
 	}
 
-	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
+	pr_debug("msk=%p, listener=%p\n", msk, mptcp_subflow_ctx(listener->sk));
 	newsk = inet_csk_accept(listener->sk, flags, err, kern);
 	if (!newsk)
 		return NULL;
 
-	pr_debug("msk=%p, subflow is mptcp=%d", msk, sk_is_mptcp(newsk));
+	pr_debug("msk=%p, subflow is mptcp=%d\n", msk, sk_is_mptcp(newsk));
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -3191,7 +3200,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct socket *ssock;
 
 	ssock = __mptcp_nmpc_socket(msk);
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
+	pr_debug("msk=%p, subflow=%p\n", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
 
@@ -3209,7 +3218,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk = subflow->conn;
 	msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, token=%u", sk, subflow->token);
+	pr_debug("msk=%p, token=%u\n", sk, subflow->token);
 
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
@@ -3250,7 +3259,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct socket *parent_sock;
 	bool ret;
 
-	pr_debug("msk=%p, subflow=%p", msk, subflow);
+	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
@@ -3297,7 +3306,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 static void mptcp_shutdown(struct sock *sk, int how)
 {
-	pr_debug("sk=%p, how=%d", sk, how);
+	pr_debug("sk=%p, how=%d\n", sk, how);
 
 	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
@@ -3427,7 +3436,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sock->sk);
 	ssock = __mptcp_nmpc_socket(msk);
@@ -3457,7 +3466,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sock->sk);
 	if (sock->sk->sk_state != TCP_LISTEN)
@@ -3561,7 +3570,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
-	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
+	pr_debug("msk=%p state=%d flags=%lx\n", msk, state, msk->flags);
 	if (state == TCP_LISTEN)
 		return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM : 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 234cf918db97..9e0a5591d4e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -441,7 +441,9 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		valid_csum_seen : 1;        /* at least one csum validated */
+		valid_csum_seen : 1,        /* at least one csum validated */
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 11;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
@@ -738,8 +740,10 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
@@ -752,10 +756,10 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr, bool check_id);
+		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-				struct mptcp_addr_info *addr);
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 					 u8 *flags, int *ifindex);
 
@@ -814,7 +818,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
@@ -830,10 +834,10 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
@@ -861,7 +865,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
-		pr_debug("TCP fallback already done (msk=%p)", msk);
+		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
@@ -875,7 +879,7 @@ static inline void mptcp_do_fallback(struct sock *sk)
 	__mptcp_do_fallback(msk);
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
+#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 36d85af12e76..93d2f028fa91 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -681,7 +681,7 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
@@ -799,7 +799,7 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2f94387f2ade..e71082dd6484 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -39,7 +39,7 @@ static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
-	pr_debug("subflow_req=%p", subflow_req);
+	pr_debug("subflow_req=%p\n", subflow_req);
 
 	if (subflow_req->msk)
 		sock_put((struct sock *)subflow_req->msk);
@@ -143,7 +143,7 @@ static int subflow_check_req(struct request_sock *req,
 	struct mptcp_options_received mp_opt;
 	bool opt_mp_capable, opt_mp_join;
 
-	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
+	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -216,7 +216,7 @@ static int subflow_check_req(struct request_sock *req,
 		}
 
 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
-			pr_debug("syn inet_sport=%d %d",
+			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
@@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
 				return -EPERM;
 		}
 
-		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
+		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 
@@ -409,7 +409,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
-	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
+	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
@@ -428,7 +428,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-		pr_debug("subflow=%p, remote_key=%llu", subflow,
+		pr_debug("subflow=%p, remote_key=%llu\n", subflow,
 			 subflow->remote_key);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
@@ -444,7 +444,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d\n",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
 
@@ -470,7 +470,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 
 		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
-			pr_debug("synack inet_dport=%d %d",
+			pr_debug("synack inet_dport=%d %d\n",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
@@ -494,7 +494,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -525,7 +525,7 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
@@ -670,7 +670,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct sock *new_msk = NULL;
 	struct sock *child;
 
-	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
+	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
 
 	/* After child creation we must look for MPC even when options
 	 * are not parsed
@@ -782,7 +782,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-				pr_debug("ack inet_sport=%d %d",
+				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
@@ -837,7 +837,7 @@ enum mapping_status {
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d\n",
 		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
@@ -1009,7 +1009,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=%llu", mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -1034,7 +1034,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				data_fin_seq &= GENMASK_ULL(31, 0);
 
 			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 				 data_fin_seq, mpext->dsn64);
 		}
 
@@ -1081,7 +1081,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (unlikely(subflow->map_csum_reqd != csum_reqd))
 		return MAPPING_INVALID;
 
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len, subflow->map_csum_reqd,
 		 subflow->map_data_csum);
@@ -1116,7 +1116,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 	avail_len = skb->len - offset;
 	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+	pr_debug("discarding=%d len=%d offset=%d seq=%d\n", incr, skb->len,
 		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
@@ -1131,12 +1131,16 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 /* sched mptcp worker to remove the subflow if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (likely(ssk->sk_state != TCP_CLOSE))
+	struct sock *sk = (struct sock *)msk;
+
+	if (likely(ssk->sk_state != TCP_CLOSE &&
+		   (ssk->sk_state != TCP_CLOSE_WAIT ||
+		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
 	if (skb_queue_empty(&ssk->sk_receive_queue) &&
 	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+		mptcp_schedule_work(sk);
 }
 
 static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
@@ -1196,7 +1200,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
-		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
+		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
 		if (unlikely(before64(ack_seq, old_ack))) {
 			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
@@ -1261,7 +1265,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 		subflow->map_valid = 0;
 		WRITE_ONCE(subflow->data_avail, 0);
 
-		pr_debug("Done with mapping: seq=%u data_len=%u",
+		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
 			 subflow->map_data_len);
 	}
@@ -1362,7 +1366,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d",
+	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d\n",
 		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 
 	if (likely(icsk->icsk_af_ops == target))
@@ -1459,7 +1463,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		goto failed;
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
+	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
 	subflow->local_id = local_id;
@@ -1584,7 +1588,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;
 
 	subflow = mptcp_subflow_ctx(sf->sk);
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	*new_sock = sf;
 	sock_hold(sk);
@@ -1608,7 +1612,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	INIT_LIST_HEAD(&ctx->node);
 	INIT_LIST_HEAD(&ctx->delegated_node);
 
-	pr_debug("subflow=%p", ctx);
+	pr_debug("subflow=%p\n", ctx);
 
 	ctx->tcp_sock = sk;
 
@@ -1689,7 +1693,7 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 
-	pr_debug("subflow=%p, family=%d", ctx, sk->sk_family);
+	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 82f36beb2e76..0ce12a33ffda 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -310,7 +310,6 @@ insert_tree(struct net *net,
 	struct nf_conncount_rb *rbconn;
 	struct nf_conncount_tuple *conn;
 	unsigned int count = 0, gc_count = 0;
-	u8 keylen = data->keylen;
 	bool do_gc = true;
 
 	spin_lock_bh(&nf_conncount_locks[hash]);
@@ -322,7 +321,7 @@ insert_tree(struct net *net,
 		rbconn = rb_entry(*rbnode, struct nf_conncount_rb, node);
 
 		parent = *rbnode;
-		diff = key_diff(key, rbconn->key, keylen);
+		diff = key_diff(key, rbconn->key, data->keylen);
 		if (diff < 0) {
 			rbnode = &((*rbnode)->rb_left);
 		} else if (diff > 0) {
@@ -367,7 +366,7 @@ insert_tree(struct net *net,
 
 	conn->tuple = *tuple;
 	conn->zone = *zone;
-	memcpy(rbconn->key, key, sizeof(u32) * keylen);
+	memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
 
 	nf_conncount_list_init(&rbconn->list);
 	list_add(&conn->node, &rbconn->list.head);
@@ -392,7 +391,6 @@ count_tree(struct net *net,
 	struct rb_node *parent;
 	struct nf_conncount_rb *rbconn;
 	unsigned int hash;
-	u8 keylen = data->keylen;
 
 	hash = jhash2(key, data->keylen, conncount_rnd) % CONNCOUNT_SLOTS;
 	root = &data->root[hash];
@@ -403,7 +401,7 @@ count_tree(struct net *net,
 
 		rbconn = rb_entry(parent, struct nf_conncount_rb, node);
 
-		diff = key_diff(key, rbconn->key, keylen);
+		diff = key_diff(key, rbconn->key, data->keylen);
 		if (diff < 0) {
 			parent = rcu_dereference_raw(parent->rb_left);
 		} else if (diff > 0) {
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 6f6e74ce927f..c952e50d3f4f 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -785,12 +785,15 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		 * queue, accept the collision, update the host tags.
 		 */
 		q->way_collisions++;
-		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
-		}
 		allocate_src = cake_dsrc(flow_mode);
 		allocate_dst = cake_ddst(flow_mode);
+
+		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
+			if (allocate_src)
+				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
+			if (allocate_dst)
+				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+		}
 found:
 		/* reserve queue for future packets in same flow */
 		reduced_hash = outer_hash + k;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e0e16b0fdb17..93ed7bac9ee6 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -733,11 +733,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 				err = qdisc_enqueue(skb, q->qdisc, &to_free);
 				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS &&
-				    net_xmit_drop_count(err)) {
-					qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1,
-								  pkt_len);
+				if (err != NET_XMIT_SUCCESS) {
+					if (net_xmit_drop_count(err))
+						qdisc_qstats_drop(sch);
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bf801adff63d..5601217febaa 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2335,6 +2335,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	case -EALREADY:
 		xprt_unlock_connect(xprt, transport);
 		return;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		fallthrough;
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e73c1bbc5ff8..eb916b2eb673 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -616,9 +616,6 @@ static void init_peercred(struct sock *sk)
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
 {
-	const struct cred *old_cred;
-	struct pid *old_pid;
-
 	if (sk < peersk) {
 		spin_lock(&sk->sk_peer_lock);
 		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
@@ -626,16 +623,12 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 		spin_lock(&peersk->sk_peer_lock);
 		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
 	}
-	old_pid = sk->sk_peer_pid;
-	old_cred = sk->sk_peer_cred;
+
 	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 
 	spin_unlock(&sk->sk_peer_lock);
 	spin_unlock(&peersk->sk_peer_lock);
-
-	put_pid(old_pid);
-	put_cred(old_cred);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a444eb84d621..b8e28025710d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1517,7 +1517,7 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_get_bss);
 
-static void rb_insert_bss(struct cfg80211_registered_device *rdev,
+static bool rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
 {
 	struct rb_node **p = &rdev->bss_tree.rb_node;
@@ -1533,7 +1533,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 		if (WARN_ON(!cmp)) {
 			/* will sort of leak this BSS */
-			return;
+			return false;
 		}
 
 		if (cmp < 0)
@@ -1544,6 +1544,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 	rb_link_node(&bss->rbn, parent, p);
 	rb_insert_color(&bss->rbn, &rdev->bss_tree);
+	return true;
 }
 
 static struct cfg80211_internal_bss *
@@ -1570,6 +1571,34 @@ rb_find_bss(struct cfg80211_registered_device *rdev,
 	return NULL;
 }
 
+static void cfg80211_insert_bss(struct cfg80211_registered_device *rdev,
+				struct cfg80211_internal_bss *bss)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	if (!rb_insert_bss(rdev, bss))
+		return;
+	list_add_tail(&bss->list, &rdev->bss_list);
+	rdev->bss_entries++;
+}
+
+static void cfg80211_rehash_bss(struct cfg80211_registered_device *rdev,
+                                struct cfg80211_internal_bss *bss)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	rb_erase(&bss->rbn, &rdev->bss_tree);
+	if (!rb_insert_bss(rdev, bss)) {
+		list_del(&bss->list);
+		if (!list_empty(&bss->hidden_list))
+			list_del_init(&bss->hidden_list);
+		if (!list_empty(&bss->pub.nontrans_list))
+			list_del_init(&bss->pub.nontrans_list);
+		rdev->bss_entries--;
+	}
+	rdev->bss_generation++;
+}
+
 static bool cfg80211_combine_bsses(struct cfg80211_registered_device *rdev,
 				   struct cfg80211_internal_bss *new)
 {
@@ -1845,9 +1874,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			bss_ref_get(rdev, pbss);
 		}
 
-		list_add_tail(&new->list, &rdev->bss_list);
-		rdev->bss_entries++;
-		rb_insert_bss(rdev, new);
+		cfg80211_insert_bss(rdev, new);
 		found = new;
 	}
 
@@ -2712,10 +2739,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		if (!WARN_ON(!__cfg80211_unlink_bss(rdev, new)))
 			rdev->bss_generation++;
 	}
-
-	rb_erase(&cbss->rbn, &rdev->bss_tree);
-	rb_insert_bss(rdev, cbss);
-	rdev->bss_generation++;
+	cfg80211_rehash_bss(rdev, cbss);
 
 	list_for_each_entry_safe(nontrans_bss, tmp,
 				 &cbss->pub.nontrans_list,
@@ -2723,9 +2747,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		bss = container_of(nontrans_bss,
 				   struct cfg80211_internal_bss, pub);
 		bss->pub.channel = chan;
-		rb_erase(&bss->rbn, &rdev->bss_tree);
-		rb_insert_bss(rdev, bss);
-		rdev->bss_generation++;
+		cfg80211_rehash_bss(rdev, bss);
 	}
 
 done:
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 8c7719108d7f..c70b86f17124 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1679,6 +1679,10 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 		struct aa_profile *p;
 		p = aa_deref_parent(profile);
 		dent = prof_dir(p);
+		if (!dent) {
+			error = -ENOENT;
+			goto fail2;
+		}
 		/* adding to parent that previously didn't have children */
 		dent = aafs_create_dir("profiles", dent);
 		if (IS_ERR(dent))
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e9d2ef3deccd..1eaf3e075db6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3641,12 +3641,18 @@ static int smack_unix_stream_connect(struct sock *sock,
 		}
 	}
 
-	/*
-	 * Cross reference the peer labels for SO_PEERSEC.
-	 */
 	if (rc == 0) {
+		/*
+		 * Cross reference the peer labels for SO_PEERSEC.
+		 */
 		nsp->smk_packet = ssp->smk_out;
 		ssp->smk_packet = osp->smk_out;
+
+		/*
+		 * new/child/established socket must inherit listening socket labels
+		 */
+		nsp->smk_out = osp->smk_out;
+		nsp->smk_in  = osp->smk_in;
 	}
 
 	return rc;
@@ -4225,7 +4231,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index aad5c4bf4d34..0ebf4d907852 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -753,6 +753,20 @@ static int hdmi_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/* a simple sanity check for input values to chmap kcontrol */
+static int chmap_value_check(struct hdac_chmap *hchmap,
+			     const struct snd_ctl_elem_value *ucontrol)
+{
+	int i;
+
+	for (i = 0; i < hchmap->channels_max; i++) {
+		if (ucontrol->value.integer.value[i] < 0 ||
+		    ucontrol->value.integer.value[i] > SNDRV_CHMAP_LAST)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -764,6 +778,10 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	unsigned char chmap[8], per_pin_chmap[8];
 	int i, err, ca, prepared = 0;
 
+	err = chmap_value_check(hchmap, ucontrol);
+	if (err < 0)
+		return err;
+
 	/* No monitor is connected in dyn_pcm_assign.
 	 * It's invalid to setup the chmap
 	 */
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index dbf7aa88e0e3..992cf82da102 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4952,6 +4952,69 @@ void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_stream_pm);
 
+/* forcibly mute the speaker output without caching; return true if updated */
+static bool force_mute_output_path(struct hda_codec *codec, hda_nid_t nid)
+{
+	if (!nid)
+		return false;
+	if (!nid_has_mute(codec, nid, HDA_OUTPUT))
+		return false; /* no mute, skip */
+	if (snd_hda_codec_amp_read(codec, nid, 0, HDA_OUTPUT, 0) &
+	    snd_hda_codec_amp_read(codec, nid, 1, HDA_OUTPUT, 0) &
+	    HDA_AMP_MUTE)
+		return false; /* both channels already muted, skip */
+
+	/* direct amp update without caching */
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+			    AC_AMP_SET_OUTPUT | AC_AMP_SET_LEFT |
+			    AC_AMP_SET_RIGHT | HDA_AMP_MUTE);
+	return true;
+}
+
+/**
+ * snd_hda_gen_shutup_speakers - Forcibly mute the speaker outputs
+ * @codec: the HDA codec
+ *
+ * Forcibly mute the speaker outputs, to be called at suspend or shutdown.
+ *
+ * The mute state done by this function isn't cached, hence the original state
+ * will be restored at resume.
+ *
+ * Return true if the mute state has been changed.
+ */
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const int *paths;
+	const struct nid_path *path;
+	int i, p, num_paths;
+	bool updated = false;
+
+	/* if already powered off, do nothing */
+	if (!snd_hdac_is_power_on(&codec->core))
+		return false;
+
+	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT) {
+		paths = spec->out_paths;
+		num_paths = spec->autocfg.line_outs;
+	} else {
+		paths = spec->speaker_paths;
+		num_paths = spec->autocfg.speaker_outs;
+	}
+
+	for (i = 0; i < num_paths; i++) {
+		path = snd_hda_get_path_from_idx(codec, paths[i]);
+		if (!path)
+			continue;
+		for (p = 0; p < path->depth; p++)
+			if (force_mute_output_path(codec, path->path[p]))
+				updated = true;
+	}
+
+	return updated;
+}
+EXPORT_SYMBOL_GPL(snd_hda_gen_shutup_speakers);
+
 /**
  * snd_hda_gen_parse_auto_config - Parse the given BIOS configuration and
  * set up the hda_gen_spec
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 362ddcaea15b..8fdbb4a14eb4 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -352,5 +352,6 @@ int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
 						     enum led_brightness));
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec);
 
 #endif /* __SOUND_HDA_GENERIC_H */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 09a272c65be1..83d976e3442c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -205,6 +205,8 @@ static void cx_auto_shutdown(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
+	snd_hda_gen_shutup_speakers(codec);
+
 	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
@@ -309,6 +311,7 @@ enum {
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
+	CXT_PINCFG_TOP_SPEAKER,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -976,6 +979,13 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
+	[CXT_PINCFG_TOP_SPEAKER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1d, 0x82170111 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1072,6 +1082,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
+	SND_PCI_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
 };
 
@@ -1091,6 +1103,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
+	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 05fb686ae250..52246a65eb89 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7026,6 +7026,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
+	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 	ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
@@ -8420,6 +8421,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led_micmute_vref,
 	},
+	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_inv_dmic,
+		.chained = true,
+		.chain_id = ALC283_FIXUP_INT_MIC,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -9170,6 +9177,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fd, "HP Laptop 14-dq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
@@ -9439,6 +9447,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
@@ -9680,6 +9689,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
+	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b957049bae33..538d84f1c29f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4002,6 +4002,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_POST_PMD:
 		kfree(substream->runtime);
+		substream->runtime = NULL;
 		break;
 
 	default:
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 55b69e3c6718..765024564e2b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -913,6 +913,8 @@ static int soc_tplg_denum_create_values(struct soc_tplg *tplg, struct soc_enum *
 		se->dobj.control.dvalues[i] = le32_to_cpu(ec->values[i]);
 	}
 
+	se->items = le32_to_cpu(ec->items);
+	se->values = (const unsigned int *)se->dobj.control.dvalues;
 	return 0;
 }
 
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 1e9116cd365e..79c76065ef93 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -100,8 +100,8 @@
 #define SUN8I_I2S_CTRL_MODE_PCM			(0 << 4)
 
 #define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK	BIT(19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED		(1 << 19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL		(0 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH	(1 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW		(0 << 19)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK	BIT(7)
@@ -709,65 +709,37 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				 unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -785,6 +757,35 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 			   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
@@ -816,65 +817,37 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				     unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -892,6 +865,36 @@ static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c201f07d8ae..d201a7356fad 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8729,7 +8729,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -8738,7 +8738,7 @@ bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 struct bpf_map *
 bpf_map__prev(const struct bpf_map *next, const struct bpf_object *obj)
 {
-	if (next == NULL) {
+	if (next == NULL && obj != NULL) {
 		if (!obj->nr_maps)
 			return NULL;
 		return obj->maps + obj->nr_maps - 1;
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 29af27acd40e..a0d3d2ed7a4a 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -29,9 +29,11 @@ static int check_vgem(int fd)
 	version.name = name;
 
 	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
-	if (ret)
+	if (ret || version.name_len != 4)
 		return 0;
 
+	name[4] = '\0';
+
 	return !strcmp(name, "vgem");
 }
 
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de2..b02080d09fbc 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -34,7 +34,7 @@
 #endif
 
 #ifndef UDP_MAX_SEGMENTS
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 #endif
 
 #define CONST_MTU_TEST	1500

