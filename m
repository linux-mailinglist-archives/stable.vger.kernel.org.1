Return-Path: <stable+bounces-146088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF280AC0C5B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2AFA27BA8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE628C025;
	Thu, 22 May 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N5Fgd9zy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839728C020;
	Thu, 22 May 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919511; cv=none; b=DhTuI0nUS+7Tie8sec84aBWuRhYzih/kDtqD4ML4aROPM7XdWxsXHXYIhU77GheM5Qtq2YtdSzat7Gn8oqJkZFS0sqC011heVi2rB9v/6Us+XP5wHMbDX+WtjRUuajINN0fAYaTkwTqfznBDrj+GfwZb5+nN8Shj+tHBVWE7FCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919511; c=relaxed/simple;
	bh=0lvoaqr6fFPTgy5Hbe58bbT53DheyBrnuJbwCdcw74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TS3+yv/i4YgSMEAT2Usmzyyj1aeDGv6rzHnrB+vUQ+4P2UJTxT6iVx36tqlLC30MJfxZg2f0cJx83QQFjFu5YA4MAM0q65+Igmz/BhTh2U+JyPMC8BmMG19ueWpqOQNpjyIdBgBxucYVnGL1a1F/mR5nSKoU44Cs5aWcQw+z1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N5Fgd9zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78915C4CEED;
	Thu, 22 May 2025 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747919510;
	bh=0lvoaqr6fFPTgy5Hbe58bbT53DheyBrnuJbwCdcw74Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5Fgd9zySLkbcSmDNDFXupRPQInBiLwQNM764aKKuAR/XgQVylhB5jAwqi7cNwKkW
	 HjXoOcNGWI9BYoe/U33+PQ27EJRVJtDcR2QbV82iQGT6/Ju8mc3NUra/wP7Ora0zeZ
	 ImeTF7J1uBdju88td6yIDzde/gwfm1EOikTRIA4s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.140
Date: Thu, 22 May 2025 15:11:37 +0200
Message-ID: <2025052237-condiment-professor-63ee@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052236-spoilage-disparity-71aa@gregkh>
References: <2025052236-spoilage-disparity-71aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 80748b7c3540..f86e26fa0b31 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 139
+SUBLEVEL = 140
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 47425311acc5..b3e101a7d04f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1259,8 +1259,10 @@ void fpsimd_release_task(struct task_struct *dead_task)
  */
 void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.za_state && flush) {
-		memset(task->thread.za_state, 0, za_state_size(task));
+	if (task->thread.za_state) {
+		if (flush)
+			memset(task->thread.za_state, 0,
+			       za_state_size(task));
 		return;
 	}
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 09b70a9b5c39..3dd23050a6c8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1942,7 +1942,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -1986,7 +1990,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->image + ctx->idx;
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 275d4d5260c7..9d4a6ab7bad9 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -38,7 +38,7 @@ endif
 
 ifdef CONFIG_64BIT
 ld-emul			= $(64bit-emul)
-cflags-y		+= -mabi=lp64s
+cflags-y		+= -mabi=lp64s -mcmodel=normal
 endif
 
 cflags-y			+= -pipe -msoft-float
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index f5d9096d18aa..af86241ae08f 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -54,7 +54,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs, unsigned long v
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last) - sizeof(unsigned long))
 
 /**
  * regs_get_register() - get register value from its offset
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 86048c60f700..fd861ac47a89 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -115,6 +115,7 @@ struct kernel_mapping {
 
 extern struct kernel_mapping kernel_map;
 extern phys_addr_t phys_ram_base;
+extern unsigned long vmemmap_start_pfn;
 
 #define is_kernel_mapping(x)	\
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7d1688f850c3..bb19a643c5c2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -79,7 +79,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
+#define vmemmap		((struct page *)VMEMMAP_START - vmemmap_start_pfn)
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ba2210b553f9..72b3462babbf 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/hugetlb.h>
 
 #include <asm/fixmap.h>
+#include <asm/sparsemem.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/soc.h>
@@ -52,6 +53,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define VMEMMAP_ADDR_ALIGN	(1ULL << SECTION_SIZE_BITS)
+
+unsigned long vmemmap_start_pfn __ro_after_init;
+EXPORT_SYMBOL(vmemmap_start_pfn);
+#endif
+
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 							__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
@@ -210,8 +218,12 @@ static void __init setup_bootmem(void)
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 	phys_ram_end = memblock_end_of_DRAM();
-	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
+	if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
 		phys_ram_base = memblock_start_of_DRAM();
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+		vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
+}
 	/*
 	 * Reserve physical address space that would be mapped to virtual
 	 * addresses greater than (void *)(-PAGE_SIZE) because:
@@ -946,6 +958,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index e73743701530..48cf91625a16 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -415,8 +415,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
-	set_vm_flush_reset_perms(trampoline);
-
 	if (likely(system_state != SYSTEM_BOOTING))
 		set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 991f00c817e6..180c708879d2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -427,7 +427,6 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
-	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 7728060b640c..c34ea5e028c4 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -74,10 +74,11 @@ void *module_alloc(unsigned long size)
 		return NULL;
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, gfp_mask,
-				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, gfp_mask, PAGE_KERNEL,
+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
+				 NUMA_NO_NODE, __builtin_return_address(0));
+
 	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
 		vfree(p);
 		return NULL;
diff --git a/block/bio.c b/block/bio.c
index a7323d567c79..7e2ce61bf247 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -576,7 +576,7 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 {
 	struct bio *bio;
 
-	if (nr_vecs > UIO_MAXIOV)
+	if (nr_vecs > BIO_MAX_INLINE_VECS)
 		return NULL;
 	return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
 }
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 79a83d8236cb..1938e4778725 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -219,16 +219,18 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 			     sizeof(struct acpi_table_pptt));
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
-	while ((unsigned long)entry + proc_sz < table_end) {
+	/* ignore subtable types that are smaller than a processor node */
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
+
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    cpu_node->parent == node_entry)
 			return 0;
 		if (entry->length == 0)
 			return 0;
+
 		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
 				     entry->length);
-
 	}
 	return 1;
 }
@@ -261,15 +263,18 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
 
 		if (entry->length == 0) {
 			pr_warn("Invalid zero length subtable\n");
 			break;
 		}
+		/* entry->length may not equal proc_sz, revalidate the processor structure length */
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    acpi_cpu_id == cpu_node->acpi_processor_id &&
+		    (unsigned long)entry + entry->length <= table_end &&
+		    entry->length == proc_sz + cpu_node->number_of_priv_resources * sizeof(u32) &&
 		     acpi_pptt_leaf_node(table_hdr, cpu_node)) {
 			return (struct acpi_pptt_processor *)entry;
 		}
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index be72681ab8ea..5f29eebef52b 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -53,7 +53,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 39f7c2d736d1..b603c25f3dfa 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -103,7 +103,7 @@ int __init clocksource_i8253_init(void)
 #ifdef CONFIG_CLKEVT_I8253
 void clockevent_i8253_disable(void)
 {
-	raw_spin_lock(&i8253_lock);
+	guard(raw_spinlock_irqsave)(&i8253_lock);
 
 	/*
 	 * Writing the MODE register should stop the counter, according to
@@ -132,8 +132,6 @@ void clockevent_i8253_disable(void)
 	outb_p(0, PIT_CH0);
 
 	outb_p(0x30, PIT_MODE);
-
-	raw_spin_unlock(&i8253_lock);
 }
 
 static int pit_shutdown(struct clock_event_device *evt)
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index e78ff9333c7a..759b4f80baee 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -308,8 +308,9 @@ void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
 	count++;
 
 	dma_resv_list_set(fobj, i, fence, usage);
-	/* pointer update must be visible before we extend the num_fences */
-	smp_store_mb(fobj->num_fences, count);
+	/* fence update must be visible before we extend the num_fences */
+	smp_wmb();
+	fobj->num_fences = count;
 }
 EXPORT_SYMBOL(dma_resv_add_fence);
 
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 78b8a97b2363..ffe621695e47 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -827,9 +827,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_timeout(thread->done_wait,
-					   done->done,
-					   msecs_to_jiffies(params->timeout));
+			wait_event_freezable_timeout(thread->done_wait,
+					done->done,
+					msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 30193195c813..7cb76db5ad60 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -141,6 +141,25 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
 	pci_free_irq_vectors(pdev);
 }
 
+static void idxd_clean_wqs(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
+		conf_dev = wq_confdev(wq);
+		put_device(conf_dev);
+		kfree(wq);
+	}
+	bitmap_free(idxd->wq_enable_map);
+	kfree(idxd->wqs);
+}
+
 static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -155,8 +174,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
-		kfree(idxd->wqs);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_bitmap;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -175,10 +194,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0) {
-			put_device(conf_dev);
+		if (rc < 0)
 			goto err;
-		}
 
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -189,7 +206,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
-			put_device(conf_dev);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -197,9 +213,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				put_device(conf_dev);
 				rc = -ENOMEM;
-				goto err;
+				goto err_opcap_bmap;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -208,15 +223,46 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	return 0;
 
- err:
+err_opcap_bmap:
+	kfree(wq->wqcfg);
+
+err:
+	put_device(conf_dev);
+	kfree(wq);
+
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
+		kfree(wq);
+
 	}
+	bitmap_free(idxd->wq_enable_map);
+
+err_bitmap:
+	kfree(idxd->wqs);
+
 	return rc;
 }
 
+static void idxd_clean_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		conf_dev = engine_confdev(engine);
+		put_device(conf_dev);
+		kfree(engine);
+	}
+	kfree(idxd->engines);
+}
+
 static int idxd_setup_engines(struct idxd_device *idxd)
 {
 	struct idxd_engine *engine;
@@ -247,6 +293,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(engine);
 			goto err;
 		}
 
@@ -260,10 +307,26 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		engine = idxd->engines[i];
 		conf_dev = engine_confdev(engine);
 		put_device(conf_dev);
+		kfree(engine);
 	}
+	kfree(idxd->engines);
+
 	return rc;
 }
 
+static void idxd_clean_groups(struct idxd_device *idxd)
+{
+	struct idxd_group *group;
+	int i;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = idxd->groups[i];
+		put_device(group_confdev(group));
+		kfree(group);
+	}
+	kfree(idxd->groups);
+}
+
 static int idxd_setup_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -294,6 +357,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(group);
 			goto err;
 		}
 
@@ -313,27 +377,25 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
+		kfree(group);
 	}
+	kfree(idxd->groups);
+
 	return rc;
 }
 
 static void idxd_cleanup_internals(struct idxd_device *idxd)
 {
-	int i;
-
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_groups(idxd);
+	idxd_clean_engines(idxd);
+	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
 }
 
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc, i;
+	int rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
@@ -358,14 +420,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	return 0;
 
  err_wkq_create:
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
+	idxd_clean_groups(idxd);
  err_group:
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
+	idxd_clean_engines(idxd);
  err_engine:
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_wqs(idxd);
  err_wqs:
 	return rc;
 }
@@ -461,6 +520,17 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
 }
 
+static void idxd_free(struct idxd_device *idxd)
+{
+	if (!idxd)
+		return;
+
+	put_device(idxd_confdev(idxd));
+	bitmap_free(idxd->opcap_bmap);
+	ida_free(&idxd_ida, idxd->id);
+	kfree(idxd);
+}
+
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
@@ -478,28 +548,34 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
 	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
 	if (idxd->id < 0)
-		return NULL;
+		goto err_ida;
 
 	idxd->opcap_bmap = bitmap_zalloc_node(IDXD_MAX_OPCAP_BITS, GFP_KERNEL, dev_to_node(dev));
-	if (!idxd->opcap_bmap) {
-		ida_free(&idxd_ida, idxd->id);
-		return NULL;
-	}
+	if (!idxd->opcap_bmap)
+		goto err_opcap;
 
 	device_initialize(conf_dev);
 	conf_dev->parent = dev;
 	conf_dev->bus = &dsa_bus_type;
 	conf_dev->type = idxd->data->dev_type;
 	rc = dev_set_name(conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
-	if (rc < 0) {
-		put_device(conf_dev);
-		return NULL;
-	}
+	if (rc < 0)
+		goto err_name;
 
 	spin_lock_init(&idxd->dev_lock);
 	spin_lock_init(&idxd->cmd_lock);
 
 	return idxd;
+
+err_name:
+	put_device(conf_dev);
+	bitmap_free(idxd->opcap_bmap);
+err_opcap:
+	ida_free(&idxd_ida, idxd->id);
+err_ida:
+	kfree(idxd);
+
+	return NULL;
 }
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
@@ -674,7 +750,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
@@ -737,6 +813,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index e323e1a5f20f..edad538928dd 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1088,8 +1088,11 @@ static void udma_check_tx_completion(struct work_struct *work)
 	u32 residue_diff;
 	ktime_t time_diff;
 	unsigned long delay;
+	unsigned long flags;
 
 	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
 		if (uc->desc) {
 			/* Get previous residue and time stamp */
 			residue_diff = uc->tx_drain.residue;
@@ -1124,6 +1127,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 				break;
 			}
 
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
 			usleep_range(ktime_to_us(delay),
 				     ktime_to_us(delay) + 10);
 			continue;
@@ -1140,6 +1145,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 
 		break;
 	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }
 
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
@@ -4209,7 +4216,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 				      struct of_dma *ofdma)
 {
 	struct udma_dev *ud = ofdma->of_dma_data;
-	dma_cap_mask_t mask = ud->ddev.cap_mask;
 	struct udma_filter_param filter_param;
 	struct dma_chan *chan;
 
@@ -4241,7 +4247,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 		}
 	}
 
-	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
+	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
 				     ofdma->of_node);
 	if (!chan) {
 		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dd22d2559720..af86402c70a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -781,6 +781,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct debugfs_blob_wrapper     debugfs_discovery_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fcd0c61499f8..079cf3292f63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -139,6 +139,10 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data);
+
 /**
  * DOC: pcie_replay_count
  *
@@ -3990,6 +3994,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
+	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
+	r = register_pm_notifier(&adev->pm_nb);
+	if (r)
+		goto failed;
+
 	return 0;
 
 release_ras_con:
@@ -4051,6 +4060,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
+	unregister_pm_notifier(&adev->pm_nb);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
@@ -4181,6 +4192,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
+ * @nb: notifier block
+ * @mode: suspend mode
+ * @data: data
+ *
+ * This function is called when the system is about to suspend or hibernate.
+ * It is used to set the appropriate flags so that eviction can be optimized
+ * in the pm prepare callback.
+ */
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data)
+{
+	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
+
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+		adev->in_s4 = true;
+		break;
+	case PM_POST_HIBERNATION:
+		adev->in_s4 = false;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * amdgpu_device_prepare - prepare for device suspend
  *
@@ -4631,6 +4669,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
+	amdgpu_device_stop_pending_resets(adev);
+
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
@@ -5502,11 +5542,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			tmp_adev->asic_reset_res = r;
 		}
 
-		/*
-		 * Drop all pending non scheduler resets. Scheduler resets
-		 * were already dropped during drm_sched_stop
-		 */
-		amdgpu_device_stop_pending_resets(tmp_adev);
+		if (!amdgpu_sriov_vf(tmp_adev))
+			/*
+			* Drop all pending non scheduler resets. Scheduler resets
+			* were already dropped during drm_sched_stop
+			*/
+			amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0a85a59519ca..1fbb73b2691d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2468,7 +2468,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	if (r)
 		return r;
@@ -2481,13 +2480,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
-
-	r = amdgpu_device_resume(drm_dev, true);
-	adev->in_s4 = false;
 
-	return r;
+	return amdgpu_device_resume(drm_dev, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2500,9 +2494,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-
-	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d7b76a3d2d55..6174bef0ecb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -32,6 +32,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
@@ -456,7 +457,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (pf2vf_info->size > 1024) {
-		DRM_ERROR("invalid pf2vf message size\n");
+		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
 		return -EINVAL;
 	}
 
@@ -467,7 +468,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			adev->virt.fw_reserve.checksum_key, checksum);
 		if (checksum != checkval) {
-			DRM_ERROR("invalid pf2vf message\n");
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
 			return -EINVAL;
 		}
 
@@ -481,7 +484,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			0, checksum);
 		if (checksum != checkval) {
-			DRM_ERROR("invalid pf2vf message\n");
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
 			return -EINVAL;
 		}
 
@@ -517,7 +522,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 		break;
 	default:
-		DRM_ERROR("invalid pf2vf version\n");
+		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
 		return -EINVAL;
 	}
 
@@ -617,8 +622,21 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	int ret;
 
 	ret = amdgpu_virt_read_pf2vf_data(adev);
-	if (ret)
+	if (ret) {
+		adev->virt.vf2pf_update_retry_cnt++;
+		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
+		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+			if (amdgpu_reset_domain_schedule(adev->reset_domain,
+							  &adev->virt.flr_work))
+				return;
+			else
+				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
+		}
+
 		goto out;
+	}
+
+	adev->virt.vf2pf_update_retry_cnt = 0;
 	amdgpu_virt_write_vf2pf_data(adev);
 
 out:
@@ -639,6 +657,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
+	adev->virt.vf2pf_update_retry_cnt = 0;
 
 	if (adev->mman.fw_vram_usage_va != NULL) {
 		/* go through this logic in ip_init and reset to init workqueue*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index dc6aaa4d67be..fc2859726f0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -51,6 +51,8 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
 	SRIOV_VF_MODE_ONE_VF,
@@ -250,6 +252,7 @@ struct amdgpu_virt {
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
+	int vf2pf_update_retry_cnt;
 
 	/* multimedia bandwidth config */
 	bool     is_mm_bw_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 12906ba74462..d39c6baae007 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -276,6 +276,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		timeout -= 10;
 	} while (timeout > 1);
 
+	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
 	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
 	up_write(&adev->reset_domain->sem);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e07757eea7ad..a311a2425ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -300,6 +300,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		timeout -= 10;
 	} while (timeout > 1);
 
+	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
 	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
 	up_write(&adev->reset_domain->sem);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 43aaf3a42b2e..0d8c020cd121 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10707,7 +10707,8 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		/* The reply is stored in the top nibble of the command. */
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	if (!payload->write && p_notify->aux_reply.length)
+	/*write req may receive a byte indicating partially written number as well*/
+	if (p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ade5dd5d8231..495491decec1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -66,6 +66,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	enum aux_return_code_type operation_result;
 	struct amdgpu_device *adev;
 	struct ddc_service *ddc;
+	uint8_t copy[16];
 
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
@@ -81,6 +82,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
 	payload.defer_delay = 0;
 
+	if (payload.write) {
+		memcpy(copy, msg->buffer, msg->size);
+		payload.data = copy;
+	}
+
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
@@ -104,9 +110,9 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	 */
 	if (payload.write && result >= 0) {
 		if (result) {
-			/*one byte indicating partially written bytes. Force 0 to retry*/
-			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
-			result = 0;
+			/*one byte indicating partially written bytes*/
+			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
 			result = msg->size;
@@ -131,11 +137,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
-		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
 	}
 
 	if (payload.reply[0])
-		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
 			payload.reply[0]);
 
 	return result;
diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index 3b81468a1df2..0bf70664c35e 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -174,6 +174,7 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 	u8 ep_addr[2] = {b_ep, 0};
 
 	if (!usb_check_int_endpoints(usbif, ep_addr)) {
+		kfree(send_buf);
 		hid_err(hdev, "Unexpected non-int endpoint\n");
 		return;
 	}
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 39114d5c55a0..5b35f9f321d4 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -142,11 +142,12 @@ static int uclogic_input_configured(struct hid_device *hdev,
 			suffix = "System Control";
 			break;
 		}
-	}
-
-	if (suffix)
+	} else {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 47e1bd8de9fc..53026356475a 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1113,68 +1113,10 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 EXPORT_SYMBOL(vmbus_sendpacket);
 
 /*
- * vmbus_sendpacket_pagebuffer - Send a range of single-page buffer
- * packets using a GPADL Direct packet type. This interface allows you
- * to control notifying the host. This will be useful for sending
- * batched data. Also the sender can control the send flags
- * explicitly.
- */
-int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-				struct hv_page_buffer pagebuffers[],
-				u32 pagecount, void *buffer, u32 bufferlen,
-				u64 requestid)
-{
-	int i;
-	struct vmbus_channel_packet_page_buffer desc;
-	u32 descsize;
-	u32 packetlen;
-	u32 packetlen_aligned;
-	struct kvec bufferlist[3];
-	u64 aligned_data = 0;
-
-	if (pagecount > MAX_PAGE_BUFFER_COUNT)
-		return -EINVAL;
-
-	/*
-	 * Adjust the size down since vmbus_channel_packet_page_buffer is the
-	 * largest size we support
-	 */
-	descsize = sizeof(struct vmbus_channel_packet_page_buffer) -
-			  ((MAX_PAGE_BUFFER_COUNT - pagecount) *
-			  sizeof(struct hv_page_buffer));
-	packetlen = descsize + bufferlen;
-	packetlen_aligned = ALIGN(packetlen, sizeof(u64));
-
-	/* Setup the descriptor */
-	desc.type = VM_PKT_DATA_USING_GPA_DIRECT;
-	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
-	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
-	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
-	desc.reserved = 0;
-	desc.rangecount = pagecount;
-
-	for (i = 0; i < pagecount; i++) {
-		desc.range[i].len = pagebuffers[i].len;
-		desc.range[i].offset = pagebuffers[i].offset;
-		desc.range[i].pfn	 = pagebuffers[i].pfn;
-	}
-
-	bufferlist[0].iov_base = &desc;
-	bufferlist[0].iov_len = descsize;
-	bufferlist[1].iov_base = buffer;
-	bufferlist[1].iov_len = bufferlen;
-	bufferlist[2].iov_base = &aligned_data;
-	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
-
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
-}
-EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
-
-/*
- * vmbus_sendpacket_multipagebuffer - Send a multi-page buffer packet
+ * vmbus_sendpacket_mpb_desc - Send one or more multi-page buffer packets
  * using a GPADL Direct packet type.
- * The buffer includes the vmbus descriptor.
+ * The desc argument must include space for the VMBus descriptor. The
+ * rangecount field must already be set.
  */
 int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 			      struct vmbus_packet_mpb_array *desc,
@@ -1196,7 +1138,6 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	desc->length8 = (u16)(packetlen_aligned >> 3);
 	desc->transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc->reserved = 0;
-	desc->rangecount = 1;
 
 	bufferlist[0].iov_base = desc;
 	bufferlist[0].iov_len = desc_size;
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 98648c679a55..2ace3aafe497 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -44,7 +44,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 74b0c85944bd..967f06cd3f94 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -169,7 +169,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 814ce0aad1cc..4085a36cd1db 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 
 	mutex_lock(&state->lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index b1a0ab3cd4bd..43dfc6fd8a3e 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -71,11 +71,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata,
 			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
-	if (err) {
-		vfree(cq->queue->buf);
-		kfree(cq->queue);
+	if (err)
 		return err;
-	}
 
 	cq->is_user = uresp;
 
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f1f1368e8146..d51d982c4bc0 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2083,6 +2083,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -2092,11 +2093,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 		mac[port].egress    = false;
 		mac[port].dyn_learn = false;
 		break;
-	case BR_STATE_LISTENING:
-		mac[port].ingress   = true;
-		mac[port].egress    = false;
-		mac[port].dyn_learn = false;
-		break;
 	case BR_STATE_LEARNING:
 		mac[port].ingress   = true;
 		mac[port].egress    = false;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 393a983f6d69..6b1245a3ab4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4041,7 +4041,7 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 	struct net_device *dev = bp->dev;
 
 	if (page_mode) {
-		bp->flags &= ~BNXT_FLAG_AGG_RINGS;
+		bp->flags &= ~(BNXT_FLAG_AGG_RINGS | BNXT_FLAG_NO_AGG_RINGS);
 		bp->flags |= BNXT_FLAG_RX_PAGE_MODE;
 
 		if (bp->xdp_prog->aux->xdp_has_frags)
@@ -12799,6 +12799,14 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 		bnxt_close_nic(bp, true, false);
 
 	dev->mtu = new_mtu;
+
+	/* MTU change may change the AGG ring settings if an XDP multi-buffer
+	 * program is attached.  We need to set the AGG rings settings and
+	 * rx_skb_func accordingly.
+	 */
+	if (READ_ONCE(bp->xdp_prog))
+		bnxt_set_rx_skb_mode(bp, true);
+
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fc3342944dbc..d2f4709dee0d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -962,22 +962,15 @@ static void macb_update_stats(struct macb *bp)
 
 static int macb_halt_tx(struct macb *bp)
 {
-	unsigned long	halt_time, timeout;
-	u32		status;
+	u32 status;
 
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(THALT));
 
-	timeout = jiffies + usecs_to_jiffies(MACB_HALT_TIMEOUT);
-	do {
-		halt_time = jiffies;
-		status = macb_readl(bp, TSR);
-		if (!(status & MACB_BIT(TGO)))
-			return 0;
-
-		udelay(250);
-	} while (time_before(halt_time, timeout));
-
-	return -ETIMEDOUT;
+	/* Poll TSR until TGO is cleared or timeout. */
+	return read_poll_timeout_atomic(macb_readl, status,
+					!(status & MACB_BIT(TGO)),
+					250, MACB_HALT_TIMEOUT, false,
+					bp, TSR);
 }
 
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index a487a98eac88..6da8d8f2a870 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -428,7 +428,8 @@ static int cn10k_mcs_write_tx_secy(struct otx2_nic *pfvf,
 	if (sw_tx_sc->encrypt)
 		sectag_tci |= (MCS_TCI_E | MCS_TCI_C);
 
-	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU, secy->netdev->mtu);
+	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU,
+			    pfvf->netdev->mtu + OTX2_ETH_HLEN);
 	/* Write SecTag excluding AN bits(1..0) */
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_TCI, sectag_tci >> 2);
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_OFFSET, tag_offset);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f520949b2024..887d44635400 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4023,6 +4023,10 @@ static netdev_features_t mlx5e_fix_uplink_rep_features(struct net_device *netdev
 	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
 		netdev_warn(netdev, "Disabling HW_VLAN CTAG FILTERING, not supported in switchdev mode\n");
 
+	features &= ~NETIF_F_HW_MACSEC;
+	if (netdev->features & NETIF_F_HW_MACSEC)
+		netdev_warn(netdev, "Disabling HW MACsec offload, not supported in switchdev mode\n");
+
 	return features;
 }
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index dc43e74147fb..4bc950d36607 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -204,7 +204,7 @@ static struct pci_driver qede_pci_driver = {
 };
 
 static struct qed_eth_cb_ops qede_ll_ops = {
-	{
+	.common = {
 #ifdef CONFIG_RFS_ACCEL
 		.arfs_filter_op = qede_arfs_filter_op,
 #endif
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 28d24d59efb8..d57b976b9040 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1484,8 +1484,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
 	}
 
 	cmd_op = (cmd.rsp.arg[0] & 0xff);
-	if (cmd.rsp.arg[0] >> 25 == 2)
-		return 2;
+	if (cmd.rsp.arg[0] >> 25 == 2) {
+		ret = 2;
+		goto out;
+	}
+
 	if (cmd_op == QLCNIC_BC_CMD_CHANNEL_INIT)
 		set_bit(QLC_BC_VF_STATE, &vf->state);
 	else
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index dd5919ec408b..e7fd72f57e36 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -156,7 +156,6 @@ struct hv_netvsc_packet {
 	u8 cp_partial; /* partial copy into send buffer */
 
 	u8 rmsg_size; /* RNDIS header and PPI size */
-	u8 rmsg_pgcnt; /* page count of RNDIS header and PPI */
 	u8 page_buf_cnt;
 
 	u16 q_idx;
@@ -891,6 +890,18 @@ struct nvsp_message {
 				 sizeof(struct nvsp_message))
 #define NETVSC_MIN_IN_MSG_SIZE sizeof(struct vmpacket_descriptor)
 
+/* Maximum # of contiguous data ranges that can make up a trasmitted packet.
+ * Typically it's the max SKB fragments plus 2 for the rndis packet and the
+ * linear portion of the SKB. But if MAX_SKB_FRAGS is large, the value may
+ * need to be limited to MAX_PAGE_BUFFER_COUNT, which is the max # of entries
+ * in a GPA direct packet sent to netvsp over VMBus.
+ */
+#if MAX_SKB_FRAGS + 2 < MAX_PAGE_BUFFER_COUNT
+#define MAX_DATA_RANGES (MAX_SKB_FRAGS + 2)
+#else
+#define MAX_DATA_RANGES MAX_PAGE_BUFFER_COUNT
+#endif
+
 /* Estimated requestor size:
  * out_ring_size/min_out_msg_size + in_ring_size/min_in_msg_size
  */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 3a834d4e1c84..ac2d706ef2d0 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -980,8 +980,7 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 		     + pend_size;
 	int i;
 	u32 padding = 0;
-	u32 page_count = packet->cp_partial ? packet->rmsg_pgcnt :
-		packet->page_buf_cnt;
+	u32 page_count = packet->cp_partial ? 1 : packet->page_buf_cnt;
 	u32 remain;
 
 	/* Add padding */
@@ -1082,6 +1081,42 @@ static int netvsc_dma_map(struct hv_device *hv_dev,
 	return 0;
 }
 
+/* Build an "array" of mpb entries describing the data to be transferred
+ * over VMBus. After the desc header fields, each "array" entry is variable
+ * size, and each entry starts after the end of the previous entry. The
+ * "offset" and "len" fields for each entry imply the size of the entry.
+ *
+ * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hyper-V
+ * uses that granularity, even if the system page size of the guest is larger.
+ * Each entry in the input "pb" array must describe a contiguous range of
+ * guest physical memory so that the pfns are sequential if the range crosses
+ * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.
+ */
+static inline void netvsc_build_mpb_array(struct hv_page_buffer *pb,
+				u32 page_buffer_count,
+				struct vmbus_packet_mpb_array *desc,
+				u32 *desc_size)
+{
+	struct hv_mpb_array *mpb_entry = &desc->range;
+	int i, j;
+
+	for (i = 0; i < page_buffer_count; i++) {
+		u32 offset = pb[i].offset;
+		u32 len = pb[i].len;
+
+		mpb_entry->offset = offset;
+		mpb_entry->len = len;
+
+		for (j = 0; j < HVPFN_UP(offset + len); j++)
+			mpb_entry->pfn_array[j] = pb[i].pfn + j;
+
+		mpb_entry = (struct hv_mpb_array *)&mpb_entry->pfn_array[j];
+	}
+
+	desc->rangecount = page_buffer_count;
+	*desc_size = (char *)mpb_entry - (char *)desc;
+}
+
 static inline int netvsc_send_pkt(
 	struct hv_device *device,
 	struct hv_netvsc_packet *packet,
@@ -1124,8 +1159,11 @@ static inline int netvsc_send_pkt(
 
 	packet->dma_range = NULL;
 	if (packet->page_buf_cnt) {
+		struct vmbus_channel_packet_page_buffer desc;
+		u32 desc_size;
+
 		if (packet->cp_partial)
-			pb += packet->rmsg_pgcnt;
+			pb++;
 
 		ret = netvsc_dma_map(ndev_ctx->device_ctx, packet, pb);
 		if (ret) {
@@ -1133,11 +1171,12 @@ static inline int netvsc_send_pkt(
 			goto exit;
 		}
 
-		ret = vmbus_sendpacket_pagebuffer(out_channel,
-						  pb, packet->page_buf_cnt,
-						  &nvmsg, sizeof(nvmsg),
-						  req_id);
-
+		netvsc_build_mpb_array(pb, packet->page_buf_cnt,
+				(struct vmbus_packet_mpb_array *)&desc,
+				 &desc_size);
+		ret = vmbus_sendpacket_mpb_desc(out_channel,
+				(struct vmbus_packet_mpb_array *)&desc,
+				desc_size, &nvmsg, sizeof(nvmsg), req_id);
 		if (ret)
 			netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
 	} else {
@@ -1286,7 +1325,7 @@ int netvsc_send(struct net_device *ndev,
 		packet->send_buf_index = section_index;
 
 		if (packet->cp_partial) {
-			packet->page_buf_cnt -= packet->rmsg_pgcnt;
+			packet->page_buf_cnt--;
 			packet->total_data_buflen = msd_len + packet->rmsg_size;
 		} else {
 			packet->page_buf_cnt = 0;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 2fba5dfd9cd0..96a1767281f7 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -325,43 +325,10 @@ static u16 netvsc_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return txq;
 }
 
-static u32 fill_pg_buf(unsigned long hvpfn, u32 offset, u32 len,
-		       struct hv_page_buffer *pb)
-{
-	int j = 0;
-
-	hvpfn += offset >> HV_HYP_PAGE_SHIFT;
-	offset = offset & ~HV_HYP_PAGE_MASK;
-
-	while (len > 0) {
-		unsigned long bytes;
-
-		bytes = HV_HYP_PAGE_SIZE - offset;
-		if (bytes > len)
-			bytes = len;
-		pb[j].pfn = hvpfn;
-		pb[j].offset = offset;
-		pb[j].len = bytes;
-
-		offset += bytes;
-		len -= bytes;
-
-		if (offset == HV_HYP_PAGE_SIZE && len) {
-			hvpfn++;
-			offset = 0;
-			j++;
-		}
-	}
-
-	return j + 1;
-}
-
 static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 			   struct hv_netvsc_packet *packet,
 			   struct hv_page_buffer *pb)
 {
-	u32 slots_used = 0;
-	char *data = skb->data;
 	int frags = skb_shinfo(skb)->nr_frags;
 	int i;
 
@@ -370,28 +337,27 @@ static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 	 * 2. skb linear data
 	 * 3. skb fragment data
 	 */
-	slots_used += fill_pg_buf(virt_to_hvpfn(hdr),
-				  offset_in_hvpage(hdr),
-				  len,
-				  &pb[slots_used]);
 
+	pb[0].offset = offset_in_hvpage(hdr);
+	pb[0].len = len;
+	pb[0].pfn = virt_to_hvpfn(hdr);
 	packet->rmsg_size = len;
-	packet->rmsg_pgcnt = slots_used;
 
-	slots_used += fill_pg_buf(virt_to_hvpfn(data),
-				  offset_in_hvpage(data),
-				  skb_headlen(skb),
-				  &pb[slots_used]);
+	pb[1].offset = offset_in_hvpage(skb->data);
+	pb[1].len = skb_headlen(skb);
+	pb[1].pfn = virt_to_hvpfn(skb->data);
 
 	for (i = 0; i < frags; i++) {
 		skb_frag_t *frag = skb_shinfo(skb)->frags + i;
+		struct hv_page_buffer *cur_pb = &pb[i + 2];
+		u64 pfn = page_to_hvpfn(skb_frag_page(frag));
+		u32 offset = skb_frag_off(frag);
 
-		slots_used += fill_pg_buf(page_to_hvpfn(skb_frag_page(frag)),
-					  skb_frag_off(frag),
-					  skb_frag_size(frag),
-					  &pb[slots_used]);
+		cur_pb->offset = offset_in_hvpage(offset);
+		cur_pb->len = skb_frag_size(frag);
+		cur_pb->pfn = pfn + (offset >> HV_HYP_PAGE_SHIFT);
 	}
-	return slots_used;
+	return frags + 2;
 }
 
 static int count_skb_frag_slots(struct sk_buff *skb)
@@ -482,7 +448,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
 	struct net_device *vf_netdev;
 	u32 rndis_msg_size;
 	u32 hash;
-	struct hv_page_buffer pb[MAX_PAGE_BUFFER_COUNT];
+	struct hv_page_buffer pb[MAX_DATA_RANGES];
 
 	/* If VF is present and up then redirect packets to it.
 	 * Skip the VF if it is marked down or has no carrier.
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index eea777ec2541..bb656ea09773 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -225,8 +225,7 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 				  struct rndis_request *req)
 {
 	struct hv_netvsc_packet *packet;
-	struct hv_page_buffer page_buf[2];
-	struct hv_page_buffer *pb = page_buf;
+	struct hv_page_buffer pb;
 	int ret;
 
 	/* Setup the packet to send it */
@@ -235,27 +234,14 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 	packet->total_data_buflen = req->request_msg.msg_len;
 	packet->page_buf_cnt = 1;
 
-	pb[0].pfn = virt_to_phys(&req->request_msg) >>
-					HV_HYP_PAGE_SHIFT;
-	pb[0].len = req->request_msg.msg_len;
-	pb[0].offset = offset_in_hvpage(&req->request_msg);
-
-	/* Add one page_buf when request_msg crossing page boundary */
-	if (pb[0].offset + pb[0].len > HV_HYP_PAGE_SIZE) {
-		packet->page_buf_cnt++;
-		pb[0].len = HV_HYP_PAGE_SIZE -
-			pb[0].offset;
-		pb[1].pfn = virt_to_phys((void *)&req->request_msg
-			+ pb[0].len) >> HV_HYP_PAGE_SHIFT;
-		pb[1].offset = 0;
-		pb[1].len = req->request_msg.msg_len -
-			pb[0].len;
-	}
+	pb.pfn = virt_to_phys(&req->request_msg) >> HV_HYP_PAGE_SHIFT;
+	pb.len = req->request_msg.msg_len;
+	pb.offset = offset_in_hvpage(&req->request_msg);
 
 	trace_rndis_send(dev->ndev, 0, &req->request_msg);
 
 	rcu_read_lock_bh();
-	ret = netvsc_send(dev->ndev, packet, NULL, pb, NULL, false);
+	ret = netvsc_send(dev->ndev, packet, NULL, &pb, NULL, false);
 	rcu_read_unlock_bh();
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index c406cb1a102f..e5c72a7d6e92 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -789,6 +789,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	int i;
 
 	mt76_worker_disable(&dev->tx_worker);
+	napi_disable(&dev->tx_napi);
 	netif_napi_del(&dev->tx_napi);
 
 	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index da858463b255..49a3cb8f1f10 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -376,7 +376,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
  * as it only leads to a small amount of wasted memory for the lifetime of
  * the I/O.
  */
-static int nvme_pci_npages_prp(void)
+static __always_inline int nvme_pci_npages_prp(void)
 {
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
@@ -1154,7 +1154,9 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	spin_lock(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
+	spin_unlock(&nvmeq->cq_poll_lock);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 7e61c6b278a7..3824e338b61e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -103,7 +103,6 @@ struct rcar_gen3_phy {
 	struct rcar_gen3_chan *ch;
 	u32 int_enable_bits;
 	bool initialized;
-	bool otg_initialized;
 	bool powered;
 };
 
@@ -311,16 +310,15 @@ static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
 	return false;
 }
 
-static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+static bool rcar_gen3_is_any_otg_rphy_initialized(struct rcar_gen3_chan *ch)
 {
-	int i;
-
-	for (i = 0; i < NUM_OF_PHYS; i++) {
-		if (ch->rphys[i].otg_initialized)
-			return false;
+	for (enum rcar_gen3_phy_index i = PHY_INDEX_BOTH_HC; i <= PHY_INDEX_EHCI;
+	     i++) {
+		if (ch->rphys[i].initialized)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
@@ -342,7 +340,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	if (sysfs_streq(buf, "host"))
@@ -380,7 +378,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -393,6 +391,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
+		return;
+
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -453,16 +454,16 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
 	writel(val, usb2_base + USB2_INT_ENABLE);
-	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
-	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
-
-	/* Initialize otg part */
-	if (channel->is_otg_channel) {
-		if (rcar_gen3_needs_init_otg(channel))
-			rcar_gen3_init_otg(channel);
-		rphy->otg_initialized = true;
+
+	if (!rcar_gen3_is_any_rphy_initialized(channel)) {
+		writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
+		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 	}
 
+	/* Initialize otg part (only if we initialize a PHY with IRQs). */
+	if (rphy->int_enable_bits)
+		rcar_gen3_init_otg(channel);
+
 	rphy->initialized = true;
 
 	return 0;
@@ -477,9 +478,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 
 	rphy->initialized = false;
 
-	if (channel->is_otg_channel)
-		rphy->otg_initialized = false;
-
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val &= ~rphy->int_enable_bits;
 	if (!rcar_gen3_is_any_rphy_initialized(channel))
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index dc22b1dd2c8b..e3acd40e7cbc 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -542,16 +542,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	err = device_add(&port->dev);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	return 0;
 
-unregister:
-	device_unregister(&port->dev);
+put_device:
+	put_device(&port->dev);
 	return err;
 }
 
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index f237c1ea8d35..8eaeb1e8f975 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -834,6 +834,10 @@ static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
 
+	/*
+	* Must be called only from the same set of dev_pm_ops handlers
+	* as i8042_pm_suspend() is called: currently just from .suspend.
+	*/
 	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
 		int rc = amd_pmc_czn_wa_irq1(pdev);
 
@@ -846,7 +850,9 @@ static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
+static const struct dev_pm_ops amd_pmc_pm = {
+	.suspend = amd_pmc_suspend_handler,
+};
 
 #endif
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 296150eaef92..33eacb4fc4c4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3804,7 +3804,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_leds;
 
 	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_WLAN, &result);
-	if (result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
+	if ((result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT)) ==
+	    (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
 		asus->driver->wlan_ctrl_by_user = 1;
 
 	if (!(asus->driver->wlan_ctrl_by_user && ashs_present())) {
diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index b8bf76c170fe..332fb58f9095 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -133,7 +133,7 @@ static int max20086_regulators_register(struct max20086 *chip)
 
 static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 {
-	struct of_regulator_match matches[MAX20086_MAX_REGULATORS] = { };
+	struct of_regulator_match *matches;
 	struct device_node *node;
 	unsigned int i;
 	int ret;
@@ -144,6 +144,11 @@ static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 		return -ENODEV;
 	}
 
+	matches = devm_kcalloc(chip->dev, chip->info->num_outputs,
+			       sizeof(*matches), GFP_KERNEL);
+	if (!matches)
+		return -ENOMEM;
+
 	for (i = 0; i < chip->info->num_outputs; ++i)
 		matches[i].name = max20086_output_names[i];
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 4c78288ffa72..5fc6bf95258c 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -197,6 +197,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 					unsigned int nr_zones, size_t *buflen)
 {
 	struct request_queue *q = sdkp->disk->queue;
+	unsigned int max_segments;
 	size_t bufsize;
 	void *buf;
 
@@ -208,12 +209,15 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 	 * Furthermore, since the report zone command cannot be split, make
 	 * sure that the allocated buffer can always be mapped by limiting the
 	 * number of pages allocated to the HBA max segments limit.
+	 * Since max segments can be larger than the max inline bio vectors,
+	 * further limit the allocated buffer to BIO_MAX_INLINE_VECS.
 	 */
 	nr_zones = min(nr_zones, sdkp->zone_info.nr_zones);
 	bufsize = roundup((nr_zones + 1) * 64, SECTOR_SIZE);
 	bufsize = min_t(size_t, bufsize,
 			queue_max_hw_sectors(q) << SECTOR_SHIFT);
-	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+	max_segments = min(BIO_MAX_INLINE_VECS, queue_max_segments(q));
+	bufsize = min_t(size_t, bufsize, max_segments << PAGE_SHIFT);
 
 	while (bufsize >= SECTOR_SIZE) {
 		buf = kvzalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6ab3fdb06965..591186daf46f 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1810,6 +1810,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 
+		payload->rangecount = 1;
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 42861bc45073..02c5f00c8a57 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1775,10 +1775,9 @@ static int cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_master *master = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_master_suspend(cqspi->master);
 	cqspi_controller_enable(cqspi, 0);
 
 	clk_disable_unprepare(cqspi->clk);
@@ -1789,7 +1788,6 @@ static int cqspi_suspend(struct device *dev)
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_master *master = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1798,7 +1796,7 @@ static int cqspi_resume(struct device *dev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	return spi_master_resume(master);
+	return spi_master_resume(cqspi->master);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index dd7de8fa37d0..ab29ae463f67 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -410,7 +410,7 @@ MODULE_LICENSE("GPL");
 static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 {
 	/* limit the hex_dump */
-	if (len < 1024) {
+	if (len <= 1024) {
 		print_hex_dump(KERN_INFO, pre,
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       ptr, len, 0);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index f564d0d471bb..f80124102328 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -543,15 +543,20 @@ static ssize_t pin_assignment_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(pin_assignment);
 
-static struct attribute *dp_altmode_attrs[] = {
+static struct attribute *displayport_attrs[] = {
 	&dev_attr_configuration.attr,
 	&dev_attr_pin_assignment.attr,
 	NULL
 };
 
-static const struct attribute_group dp_altmode_group = {
+static const struct attribute_group displayport_group = {
 	.name = "displayport",
-	.attrs = dp_altmode_attrs,
+	.attrs = displayport_attrs,
+};
+
+static const struct attribute_group *displayport_groups[] = {
+	&displayport_group,
+	NULL,
 };
 
 int dp_altmode_probe(struct typec_altmode *alt)
@@ -559,7 +564,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
-	int ret;
 
 	/* FIXME: Port can only be DFP_U. */
 
@@ -570,10 +574,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
 		return -ENODEV;
 
-	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
-	if (ret)
-		return ret;
-
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
@@ -604,7 +604,6 @@ void dp_altmode_remove(struct typec_altmode *alt)
 {
 	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
 
-	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
 
 	if (dp->connector_fwnode) {
@@ -629,6 +628,7 @@ static struct typec_altmode_driver dp_altmode_driver = {
 	.driver = {
 		.name = "typec_displayport",
 		.owner = THIS_MODULE,
+		.dev_groups = displayport_groups,
 	},
 };
 module_typec_altmode_driver(dp_altmode_driver);
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 8c19081c3255..e3b5fa3b5f95 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -54,7 +54,8 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	u8 cur = 0;
 	int ret;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override && dp->initialized) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
@@ -100,7 +101,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	schedule_work(&dp->work);
 	ret = 0;
 err_unlock:
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return ret;
 }
@@ -112,7 +113,8 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	u64 command;
 	int ret = 0;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
@@ -144,7 +146,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	schedule_work(&dp->work);
 
 out_unlock:
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return ret;
 }
@@ -202,20 +204,21 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 	int cmd = PD_VDO_CMD(header);
 	int svdm_version;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override && dp->initialized) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
 
 		dev_warn(&p->dev,
 			 "firmware doesn't support alternate mode overriding\n");
-		mutex_unlock(&dp->con->lock);
+		ucsi_con_mutex_unlock(dp->con);
 		return -EOPNOTSUPP;
 	}
 
 	svdm_version = typec_altmode_get_svdm_version(alt);
 	if (svdm_version < 0) {
-		mutex_unlock(&dp->con->lock);
+		ucsi_con_mutex_unlock(dp->con);
 		return svdm_version;
 	}
 
@@ -259,7 +262,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 		break;
 	}
 
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return 0;
 }
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2adf5fdc0c56..2a03bb992806 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1398,6 +1398,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
 }
 EXPORT_SYMBOL_GPL(ucsi_set_drvdata);
 
+/**
+ * ucsi_con_mutex_lock - Acquire the connector mutex
+ * @con: The connector interface to lock
+ *
+ * Returns true on success, false if the connector is disconnected
+ */
+bool ucsi_con_mutex_lock(struct ucsi_connector *con)
+{
+	bool mutex_locked = false;
+	bool connected = true;
+
+	while (connected && !mutex_locked) {
+		mutex_locked = mutex_trylock(&con->lock) != 0;
+		connected = con->status.flags & UCSI_CONSTAT_CONNECTED;
+		if (connected && !mutex_locked)
+			msleep(20);
+	}
+
+	connected = connected && con->partner;
+	if (!connected && mutex_locked)
+		mutex_unlock(&con->lock);
+
+	return connected;
+}
+
+/**
+ * ucsi_con_mutex_unlock - Release the connector mutex
+ * @con: The connector interface to unlock
+ */
+void ucsi_con_mutex_unlock(struct ucsi_connector *con)
+{
+	mutex_unlock(&con->lock);
+}
+
 /**
  * ucsi_create - Allocate UCSI instance
  * @dev: Device interface to the PPM (Platform Policy Manager)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 4a1a86e37fd5..793a8307dded 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -15,6 +15,7 @@
 
 struct ucsi;
 struct ucsi_altmode;
+struct ucsi_connector;
 
 /* UCSI offsets (Bytes) */
 #define UCSI_VERSION			0
@@ -62,6 +63,8 @@ int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+bool ucsi_con_mutex_lock(struct ucsi_connector *con);
+void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 8e500fe41e78..e690b6e53480 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -585,6 +585,10 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		    uc->has_multiple_dp) {
 			con_index = (uc->last_cmd_sent >> 16) &
 				    UCSI_CMD_CONNECTOR_MASK;
+			if (con_index == 0) {
+				ret = -EINVAL;
+				goto err_put;
+			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
 		}
@@ -599,6 +603,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
+err_put:
 	pm_runtime_put_sync(uc->dev);
 	mutex_unlock(&uc->lock);
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 89e7e4826efc..762704eed9ce 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -109,25 +109,6 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-static int set_brk(unsigned long start, unsigned long end, int prot)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end > start) {
-		/*
-		 * Map the last of the bss segment.
-		 * If the header is requesting these pages to be
-		 * executable, honour that (ppc32 needs this).
-		 */
-		int error = vm_brk_flags(start, end - start,
-				prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			return error;
-	}
-	current->mm->start_brk = current->mm->brk = end;
-	return 0;
-}
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -248,7 +229,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	} while (0)
 
 #ifdef ARCH_DLINFO
-	/* 
+	/*
 	 * ARCH_DLINFO must come first so PPC can do its special alignment of
 	 * AUXV.
 	 * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT() in
@@ -401,6 +382,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+static unsigned long elf_load(struct file *filep, unsigned long addr,
+		const struct elf_phdr *eppnt, int prot, int type,
+		unsigned long total_size)
+{
+	unsigned long zero_start, zero_end;
+	unsigned long map_addr;
+
+	if (eppnt->p_filesz) {
+		map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
+		if (BAD_ADDR(map_addr))
+			return map_addr;
+		if (eppnt->p_memsz > eppnt->p_filesz) {
+			zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_filesz;
+			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_memsz;
+
+			/* Zero the end of the last mapped page */
+			padzero(zero_start);
+		}
+	} else {
+		map_addr = zero_start = ELF_PAGESTART(addr);
+		zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+			eppnt->p_memsz;
+	}
+	if (eppnt->p_memsz > eppnt->p_filesz) {
+		/*
+		 * Map the last of the segment.
+		 * If the header is requesting these pages to be
+		 * executable, honour that (ppc32 needs this).
+		 */
+		int error;
+
+		zero_start = ELF_PAGEALIGN(zero_start);
+		zero_end = ELF_PAGEALIGN(zero_end);
+
+		error = vm_brk_flags(zero_start, zero_end - zero_start,
+				     prot & PROT_EXEC ? VM_EXEC : 0);
+		if (error)
+			map_addr = error;
+	}
+	return map_addr;
+}
+
+
 static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
 	elf_addr_t min_addr = -1;
@@ -829,8 +855,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
+	unsigned long elf_brk;
+	bool brk_moved = false;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1021,8 +1047,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto out_free_dentry;
-	
-	elf_bss = 0;
+
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1042,33 +1067,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-	            
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk(elf_bss + load_bias,
-					 elf_brk + load_bias,
-					 bss_prot);
-			if (retval)
-				goto out_free_dentry;
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *)elf_bss +
-							load_bias, nbyte)) {
-					/*
-					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections. So
-					 * we don't check the return value
-					 */
-				}
-			}
-		}
-
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
@@ -1096,15 +1094,49 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * Header for ET_DYN binaries to calculate the
 			 * randomization (load_bias) for all the LOAD
 			 * Program Headers.
+			 */
+
+			/*
+			 * Calculate the entire size of the ELF mapping
+			 * (total_size), used for the initial mapping,
+			 * due to load_addr_set which is set to true later
+			 * once the initial mapping is performed.
+			 *
+			 * Note that this is only sensible when the LOAD
+			 * segments are contiguous (or overlapping). If
+			 * used for LOADs that are far apart, this would
+			 * cause the holes between LOADs to be mapped,
+			 * running the risk of having the mapping fail,
+			 * as it would be larger than the ELF file itself.
+			 *
+			 * As a result, only ET_DYN does this, since
+			 * some ET_EXEC (e.g. ia64) may have large virtual
+			 * memory holes between LOADs.
+			 *
+			 */
+			total_size = total_mapping_size(elf_phdata,
+							elf_ex->e_phnum);
+			if (!total_size) {
+				retval = -EINVAL;
+				goto out_free_dentry;
+			}
+
+			/* Calculate any requested alignment. */
+			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+
+			/**
+			 * DOC: PIE handling
 			 *
-			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
-			 * and loaders (ET_DYN without INTERP, since they
-			 * _are_ the ELF interpreter). The loaders must
-			 * be loaded away from programs since the program
-			 * may otherwise collide with the loader (especially
-			 * for ET_EXEC which does not have a randomized
-			 * position). For example to handle invocations of
+			 * There are effectively two types of ET_DYN ELF
+			 * binaries: programs (i.e. PIE: ET_DYN with
+			 * PT_INTERP) and loaders (i.e. static PIE: ET_DYN
+			 * without PT_INTERP, usually the ELF interpreter
+			 * itself). Loaders must be loaded away from programs
+			 * since the program may otherwise collide with the
+			 * loader (especially for ET_EXEC which does not have
+			 * a randomized position).
+			 *
+			 * For example, to handle invocations of
 			 * "./ld.so someprog" to test out a new version of
 			 * the loader, the subsequent program that the
 			 * loader loads must avoid the loader itself, so
@@ -1117,17 +1149,49 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * ELF_ET_DYN_BASE and loaders are loaded into the
 			 * independently randomized mmap region (0 load_bias
 			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
+			 *
+			 * See below for "brk" handling details, which is
+			 * also affected by program vs loader and ASLR.
 			 */
 			if (interpreter) {
+				/* On ET_DYN with PT_INTERP, we do the ASLR. */
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
-				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+				/* Adjust alignment as requested. */
 				if (alignment)
 					load_bias &= ~(alignment - 1);
 				elf_flags |= MAP_FIXED_NOREPLACE;
-			} else
-				load_bias = 0;
+			} else {
+				/*
+				 * For ET_DYN without PT_INTERP, we rely on
+				 * the architectures's (potentially ASLR) mmap
+				 * base address (via a load_bias of 0).
+				 *
+				 * When a large alignment is requested, we
+				 * must do the allocation at address "0" right
+				 * now to discover where things will load so
+				 * that we can adjust the resulting alignment.
+				 * In this case (load_bias != 0), we can use
+				 * MAP_FIXED_NOREPLACE to make sure the mapping
+				 * doesn't collide with anything.
+				 */
+				if (alignment > ELF_MIN_ALIGN) {
+					load_bias = elf_load(bprm->file, 0, elf_ppnt,
+							     elf_prot, elf_flags, total_size);
+					if (BAD_ADDR(load_bias)) {
+						retval = IS_ERR_VALUE(load_bias) ?
+							 PTR_ERR((void*)load_bias) : -EINVAL;
+						goto out_free_dentry;
+					}
+					vm_munmap(load_bias, total_size);
+					/* Adjust alignment as requested. */
+					if (alignment)
+						load_bias &= ~(alignment - 1);
+					elf_flags |= MAP_FIXED_NOREPLACE;
+				} else
+					load_bias = 0;
+			}
 
 			/*
 			 * Since load_bias is used for all subsequent loading
@@ -1137,34 +1201,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * is then page aligned.
 			 */
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
-
-			/*
-			 * Calculate the entire size of the ELF mapping
-			 * (total_size), used for the initial mapping,
-			 * due to load_addr_set which is set to true later
-			 * once the initial mapping is performed.
-			 *
-			 * Note that this is only sensible when the LOAD
-			 * segments are contiguous (or overlapping). If
-			 * used for LOADs that are far apart, this would
-			 * cause the holes between LOADs to be mapped,
-			 * running the risk of having the mapping fail,
-			 * as it would be larger than the ELF file itself.
-			 *
-			 * As a result, only ET_DYN does this, since
-			 * some ET_EXEC (e.g. ia64) may have large virtual
-			 * memory holes between LOADs.
-			 *
-			 */
-			total_size = total_mapping_size(elf_phdata,
-							elf_ex->e_phnum);
-			if (!total_size) {
-				retval = -EINVAL;
-				goto out_free_dentry;
-			}
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
+		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR((void *)error) ?
@@ -1212,41 +1251,23 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
 			end_data = k;
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
+		if (k > elf_brk)
 			elf_brk = k;
-		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk, bss_prot);
-	if (retval)
-		goto out_free_dentry;
-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
-	}
-
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
@@ -1302,24 +1323,44 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
+	/**
+	 * DOC: "brk" handling
+	 *
+	 * For architectures with ELF randomization, when executing a
+	 * loader directly (i.e. static PIE: ET_DYN without PT_INTERP),
+	 * move the brk area out of the mmap region and into the unused
+	 * ELF_ET_DYN_BASE region. Since "brk" grows up it may collide
+	 * early with the stack growing down or other regions being put
+	 * into the mmap region by the kernel (e.g. vdso).
+	 *
+	 * In the CONFIG_COMPAT_BRK case, though, everything is turned
+	 * off because we're not allowed to move the brk at all.
+	 */
+	if (!IS_ENABLED(CONFIG_COMPAT_BRK) &&
+	    IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
+	    elf_ex->e_type == ET_DYN && !interpreter) {
+		elf_brk = ELF_ET_DYN_BASE;
+		/* This counts as moving the brk, so let brk(2) know. */
+		brk_moved = true;
+	}
+	mm->start_brk = mm->brk = ELF_PAGEALIGN(elf_brk);
+
+	if ((current->flags & PF_RANDOMIZE) && snapshot_randomize_va_space > 1) {
 		/*
-		 * For architectures with ELF randomization, when executing
-		 * a loader directly (i.e. no interpreter listed in ELF
-		 * headers), move the brk area out of the mmap region
-		 * (since it grows up, and may collide early with the stack
-		 * growing down), and into the unused ELF_ET_DYN_BASE region.
+		 * If we didn't move the brk to ELF_ET_DYN_BASE (above),
+		 * leave a gap between .bss and brk.
 		 */
-		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
-		    elf_ex->e_type == ET_DYN && !interpreter) {
-			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
-		}
+		if (!brk_moved)
+			mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
 
 		mm->brk = mm->start_brk = arch_randomize_brk(mm);
+		brk_moved = true;
+	}
+
 #ifdef compat_brk_randomized
+	if (brk_moved)
 		current->brk_randomized = 1;
 #endif
-	}
 
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
@@ -1522,7 +1563,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_align = 0;
 }
 
-static void fill_note(struct memelfnote *note, const char *name, int type, 
+static void fill_note(struct memelfnote *note, const char *name, int type,
 		unsigned int sz, void *data)
 {
 	note->name = name;
@@ -2005,8 +2046,8 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 	t->num_notes = 0;
 
 	fill_prstatus(&t->prstatus.common, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
-	
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
 		  &(t->prstatus));
 	t->num_notes++;
@@ -2296,7 +2337,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!elf_core_write_extra_phdrs(cprm, offset))
 		goto end_coredump;
 
- 	/* write out the notes section */
+	/* write out the notes section */
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c71a40927315..b2d3b6e43bb5 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1603,7 +1603,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!elf_core_write_extra_phdrs(cprm, offset))
 		goto end_coredump;
 
- 	/* write out the notes section */
+	/* write out the notes section */
 	if (!writenote(thread_list->notes, cprm))
 		goto end_coredump;
 	if (!writenote(&psinfo_note, cprm))
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index bd9dde374e5d..7b2f77a8aa98 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -78,8 +78,6 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				  struct btrfs_block_group *block_group)
 {
 	lockdep_assert_held(&discard_ctl->lock);
-	if (!btrfs_run_discard_work(discard_ctl))
-		return;
 
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
@@ -102,6 +100,9 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	if (!btrfs_is_block_group_data_only(block_group))
 		return;
 
+	if (!btrfs_run_discard_work(discard_ctl))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 	__add_to_discard_list(discard_ctl, block_group);
 	spin_unlock(&discard_ctl->lock);
@@ -233,6 +234,18 @@ static struct btrfs_block_group *peek_discard_list(
 		    block_group->used != 0) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
+				/*
+				 * The block group must have been moved to other
+				 * discard list even if discard was disabled in
+				 * the meantime or a transaction abort happened,
+				 * otherwise we can end up in an infinite loop,
+				 * always jumping into the 'again' label and
+				 * keep getting this block group over and over
+				 * in case there are no other block groups in
+				 * the discard lists.
+				 */
+				ASSERT(block_group->discard_index !=
+				       BTRFS_DISCARD_INDEX_UNUSED);
 			} else {
 				list_del_init(&block_group->discard_list);
 				btrfs_put_block_group(block_group);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9040108eda64..5395e27f9e89 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -179,6 +179,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			num_refs = btrfs_extent_refs(leaf, ei);
+			if (unlikely(num_refs == 0)) {
+				ret = -EUCLEAN;
+				btrfs_err(fs_info,
+			"unexpected zero reference count for extent item (%llu %u %llu)",
+					  key.objectid, key.type, key.offset);
+				btrfs_abort_transaction(trans, ret);
+				goto out_free;
+			}
 			extent_flags = btrfs_extent_flags(leaf, ei);
 		} else {
 			ret = -EINVAL;
@@ -190,8 +198,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 			goto out_free;
 		}
-
-		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
 		extent_flags = 0;
@@ -221,10 +227,19 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto search_again;
 		}
 		spin_lock(&head->lock);
-		if (head->extent_op && head->extent_op->update_flags)
+		if (head->extent_op && head->extent_op->update_flags) {
 			extent_flags |= head->extent_op->flags_to_set;
-		else
-			BUG_ON(num_refs == 0);
+		} else if (unlikely(num_refs == 0)) {
+			spin_unlock(&head->lock);
+			mutex_unlock(&head->mutex);
+			spin_unlock(&delayed_refs->lock);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			  "unexpected zero reference count for extent %llu (%s)",
+				  bytenr, metadata ? "metadata" : "data");
+			btrfs_abort_transaction(trans, ret);
+			goto out_free;
+		}
 
 		num_refs += head->ref_mod;
 		spin_unlock(&head->lock);
diff --git a/fs/exec.c b/fs/exec.c
index 2039414cc662..b65af8f9a4f9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -169,7 +169,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 exit:
 	fput(file);
 out:
-  	return error;
+	return error;
 }
 #endif /* #ifdef CONFIG_USELIB */
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5b06b8d4e014..acef50824d1a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6886,10 +6886,18 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	struct nfs4_unlockdata *p;
 	struct nfs4_state *state = lsp->ls_state;
 	struct inode *inode = state->inode;
+	struct nfs_lock_context *l_ctx;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return NULL;
+	l_ctx = nfs_get_lock_context(ctx);
+	if (!IS_ERR(l_ctx)) {
+		p->l_ctx = l_ctx;
+	} else {
+		kfree(p);
+		return NULL;
+	}
 	p->arg.fh = NFS_FH(inode);
 	p->arg.fl = &p->fl;
 	p->arg.seqid = seqid;
@@ -6897,7 +6905,6 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	p->lsp = lsp;
 	/* Ensure we don't close file until we're done freeing locks! */
 	p->ctx = get_nfs_open_context(ctx);
-	p->l_ctx = nfs_get_lock_context(ctx);
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f68286932019..fe0ddbce3bcb 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -732,6 +732,14 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 	return remaining;
 }
 
+static void pnfs_reset_return_info(struct pnfs_layout_hdr *lo)
+{
+	struct pnfs_layout_segment *lseg;
+
+	list_for_each_entry(lseg, &lo->plh_return_segs, pls_list)
+		pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, 0);
+}
+
 static void
 pnfs_free_returned_lsegs(struct pnfs_layout_hdr *lo,
 		struct list_head *free_me,
@@ -1180,6 +1188,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
 		pnfs_free_returned_lsegs(lo, &freeme, range, seq);
 		pnfs_set_layout_stateid(lo, stateid, NULL, true);
+		pnfs_reset_return_info(lo);
 	} else
 		pnfs_mark_layout_stateid_invalid(lo, &freeme);
 out_unlock:
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 96faa22b9cb6..c28e39c67c4f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2826,7 +2826,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	/* Eventually save off posix specific response info and timestaps */
 
 err_free_rsp_buf:
-	free_rsp_buf(resp_buftype, rsp);
+	free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 	kfree(pc_buf);
 err_free_req:
 	cifs_small_buf_release(req);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2b9fc5edf49d..00ab98ce1d43 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 
 #define BIO_MAX_VECS		256U
+#define BIO_MAX_INLINE_VECS	UIO_MAXIOV
 
 static inline unsigned int bio_max_segs(unsigned int nr_segs)
 {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index afc204370901..80d876593caa 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1224,13 +1224,6 @@ extern int vmbus_sendpacket(struct vmbus_channel *channel,
 				  enum vmbus_packet_type type,
 				  u32 flags);
 
-extern int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-					    struct hv_page_buffer pagebuffers[],
-					    u32 pagecount,
-					    void *buffer,
-					    u32 bufferlen,
-					    u64 requestid);
-
 extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 				     struct vmbus_packet_mpb_array *mpb,
 				     u32 desc_size,
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dd0784a6e07d..4a4112bb1d1b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -181,7 +181,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index d11398aa642e..7252a5aae069 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1045,6 +1045,7 @@ struct nft_rule_blob {
  *	@use: number of jump references to this chain
  *	@flags: bitmask of enum nft_chain_flags
  *	@name: name of the chain
+ *	@rcu_head: rcu head for deferred release
  */
 struct nft_chain {
 	struct nft_rule_blob		__rcu *blob_gen_0;
@@ -1121,7 +1122,7 @@ static inline bool nft_chain_is_bound(struct nft_chain *chain)
 
 int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
-void nf_tables_chain_destroy(struct nft_ctx *ctx);
+void nf_tables_chain_destroy(struct nft_chain *chain);
 
 struct nft_stats {
 	u64			bytes;
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 80f657bf2e04..b34e9e93a146 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -997,6 +997,21 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 	return skb;
 }
 
+static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool direct)
+{
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(&sch->gso_skb);
+	if (skb) {
+		sch->q.qlen--;
+		return skb;
+	}
+	if (direct)
+		return __qdisc_dequeue_head(&sch->q);
+	else
+		return sch->dequeue(sch);
+}
+
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 {
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c7b056af9ef0..3e5f07be26fc 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -91,7 +91,7 @@ typedef __s64	Elf64_Sxword;
 #define DT_INIT		12
 #define DT_FINI		13
 #define DT_SONAME	14
-#define DT_RPATH 	15
+#define DT_RPATH	15
 #define DT_SYMBOLIC	16
 #define DT_REL	        17
 #define DT_RELSZ	18
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..c9b0533407ed 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -16,7 +16,7 @@
 #include "trace_output.h"	/* for trace_event_sem */
 #include "trace_dynevent.h"
 
-static DEFINE_MUTEX(dyn_event_ops_mutex);
+DEFINE_MUTEX(dyn_event_ops_mutex);
 static LIST_HEAD(dyn_event_ops_list);
 
 bool trace_event_dyn_try_get_ref(struct trace_event_call *dyn_call)
@@ -125,6 +125,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	return ret;
 }
 
+/*
+ * Locked version of event creation. The event creation must be protected by
+ * dyn_event_ops_mutex because of protecting trace_probe_log.
+ */
+int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
+{
+	int ret;
+
+	mutex_lock(&dyn_event_ops_mutex);
+	ret = type->create(raw_command);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return ret;
+}
+
 static int create_dyn_event(const char *raw_command)
 {
 	struct dyn_event_operations *ops;
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 936477a111d3..beee3f8d7544 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -100,6 +100,7 @@ void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
 void dyn_event_seq_stop(struct seq_file *m, void *v);
 int dyn_events_release_all(struct dyn_event_operations *type);
 int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
+int dyn_event_create(const char *raw_command, struct dyn_event_operations *type);
 
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index f941ce01ee35..afdbad16d00a 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1539,7 +1539,7 @@ stacktrace_trigger(struct event_trigger_data *data,
 	struct trace_event_file *file = data->private_data;
 
 	if (file)
-		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
 	else
 		trace_dump_stack(STACK_SKIP);
 }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 69e92c7359fb..44ae51d1dc45 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -561,11 +561,7 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 
 static __always_inline void trace_stack(struct trace_array *tr)
 {
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx();
-
-	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
+	__trace_stack(tr, tracing_gen_ctx_dec(), FTRACE_STACK_SKIP);
 }
 
 static void
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 72655d81b37d..cc155c411768 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -975,7 +975,7 @@ static int create_or_delete_trace_kprobe(const char *raw_command)
 	if (raw_command[0] == '-')
 		return dyn_event_release(raw_command, &trace_kprobe_ops);
 
-	ret = trace_kprobe_create(raw_command);
+	ret = dyn_event_create(raw_command, &trace_kprobe_ops);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ba48b5e270e1..3888a59c9dfe 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -143,9 +143,12 @@ static const struct fetch_type *find_fetch_type(const char *type)
 }
 
 static struct trace_probe_log trace_probe_log;
+extern struct mutex dyn_event_ops_mutex;
 
 void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	trace_probe_log.subsystem = subsystem;
 	trace_probe_log.argc = argc;
 	trace_probe_log.argv = argv;
@@ -154,11 +157,15 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 
 void trace_probe_log_clear(void)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
 }
 
 void trace_probe_log_set_index(int index)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	trace_probe_log.index = index;
 }
 
@@ -167,6 +174,8 @@ void __trace_probe_log_err(int offset, int err_type)
 	char *command, *p;
 	int i, len = 0, pos = 0;
 
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	if (!trace_probe_log.argv)
 		return;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a6a3ff2a441e..53ef3cb65098 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -732,7 +732,7 @@ static int create_or_delete_trace_uprobe(const char *raw_command)
 	if (raw_command[0] == '-')
 		return dyn_event_release(raw_command, &trace_uprobe_ops);
 
-	ret = trace_uprobe_create(raw_command);
+	ret = dyn_event_create(raw_command, &trace_uprobe_ops);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index dc17618bad8b..c8cc2f63c3ea 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1656,8 +1656,12 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (PageHWPoison(page)) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
-			if (folio_mapped(folio))
+			if (folio_mapped(folio)) {
+				folio_lock(folio);
 				try_to_unmap(folio, TTU_IGNORE_MLOCK);
+				folio_unlock(folio);
+			}
+
 			continue;
 		}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index e37b18376714..7b986c9f4032 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2422,6 +2422,14 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return 0;
+
 		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
 		return 0;
 	}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index c82107bbd981..543d029102cf 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1580,7 +1580,8 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		 * so icmphdr does not in skb linear region and can not get icmp_type
 		 * by icmp_hdr(skb)->type.
 		 */
-		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_type == SOCK_RAW &&
+		    !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp_type = fl4->fl4_icmp_type;
 		else
 			icmp_type = icmp_hdr(skb)->type;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index ee0efd0efec4..c109bc376cc5 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -608,6 +608,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
 
+	fl4.fl4_icmp_type = 0;
+	fl4.fl4_icmp_code = 0;
+
 	if (!hdrincl) {
 		rfv.msg = msg;
 		rfv.hlen = 0;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d7f7a714bd23..f7a225da8525 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1985,7 +1985,8 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-		if (sk->sk_socket->type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_socket->type == SOCK_RAW &&
+		    !(fl6->flowi6_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp6_type = fl6->fl6_icmp_type;
 		else
 			icmp6_type = icmp6_hdr(skb)->icmp6_type;
diff --git a/net/mctp/route.c b/net/mctp/route.c
index e72cdd4ce588..62952ad5cb63 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -274,8 +274,10 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
-	if (WARN_ON(key->dev && key->dev != dev))
+	if (key->dev) {
+		WARN_ON(key->dev != dev);
 		return;
+	}
 
 	mctp_dev_set_key(dev, key);
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 656c4fb76773..0bf347a0a1dd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2034,9 +2034,9 @@ static void nf_tables_chain_free_chain_rules(struct nft_chain *chain)
 	kvfree(chain->blob_next);
 }
 
-void nf_tables_chain_destroy(struct nft_ctx *ctx)
+void nf_tables_chain_destroy(struct nft_chain *chain)
 {
-	struct nft_chain *chain = ctx->chain;
+	const struct nft_table *table = chain->table;
 	struct nft_hook *hook, *next;
 
 	if (WARN_ON(chain->use > 0))
@@ -2048,7 +2048,7 @@ void nf_tables_chain_destroy(struct nft_ctx *ctx)
 	if (nft_is_base_chain(chain)) {
 		struct nft_base_chain *basechain = nft_base_chain(chain);
 
-		if (nft_base_chain_netdev(ctx->family, basechain->ops.hooknum)) {
+		if (nft_base_chain_netdev(table->family, basechain->ops.hooknum)) {
 			list_for_each_entry_safe(hook, next,
 						 &basechain->hook_list, list) {
 				list_del_rcu(&hook->list);
@@ -2515,7 +2515,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 err_trans:
 	nft_use_dec_restore(&table->use);
 err_destroy_chain:
-	nf_tables_chain_destroy(ctx);
+	nf_tables_chain_destroy(chain);
 
 	return err;
 }
@@ -3510,8 +3510,11 @@ void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 	kfree(rule);
 }
 
+/* can only be used if rule is no longer visible to dumps */
 static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
+	lockdep_commit_lock_is_held(ctx->net);
+
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
 }
@@ -5247,6 +5250,8 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
+	lockdep_commit_lock_is_held(ctx->net);
+
 	switch (phase) {
 	case NFT_TRANS_PREPARE_ERROR:
 		nft_set_trans_unbind(ctx, set);
@@ -8994,7 +8999,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		kfree(nft_trans_chain_name(trans));
 		break;
 	case NFT_MSG_DELCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(nft_trans_chain(trans));
 		break;
 	case NFT_MSG_DELRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -9955,7 +9960,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_table_destroy(&trans->ctx);
 		break;
 	case NFT_MSG_NEWCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(nft_trans_chain(trans));
 		break;
 	case NFT_MSG_NEWRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -10662,23 +10667,43 @@ int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 }
 EXPORT_SYMBOL_GPL(nft_data_dump);
 
-int __nft_release_basechain(struct nft_ctx *ctx)
+static void __nft_release_basechain_now(struct nft_ctx *ctx)
 {
 	struct nft_rule *rule, *nr;
 
-	if (WARN_ON(!nft_is_base_chain(ctx->chain)))
-		return 0;
-
-	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
-		nft_use_dec(&ctx->chain->use);
 		nf_tables_rule_release(ctx, rule);
 	}
+	nf_tables_chain_destroy(ctx->chain);
+}
+
+int __nft_release_basechain(struct nft_ctx *ctx)
+{
+	struct nft_rule *rule;
+
+	if (WARN_ON_ONCE(!nft_is_base_chain(ctx->chain)))
+		return 0;
+
+	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
+	list_for_each_entry(rule, &ctx->chain->rules, list)
+		nft_use_dec(&ctx->chain->use);
+
 	nft_chain_del(ctx->chain);
 	nft_use_dec(&ctx->table->use);
-	nf_tables_chain_destroy(ctx);
 
+	if (!maybe_get_net(ctx->net)) {
+		__nft_release_basechain_now(ctx);
+		return 0;
+	}
+
+	/* wait for ruleset dumps to complete.  Owning chain is no longer in
+	 * lists, so new dumps can't find any of these rules anymore.
+	 */
+	synchronize_rcu();
+
+	__nft_release_basechain_now(ctx);
+	put_net(ctx->net);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
@@ -10753,10 +10778,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 		nft_obj_destroy(&ctx, obj);
 	}
 	list_for_each_entry_safe(chain, nc, &table->chains, list) {
-		ctx.chain = chain;
 		nft_chain_del(chain);
 		nft_use_dec(&table->use);
-		nf_tables_chain_destroy(&ctx);
+		nf_tables_chain_destroy(chain);
 	}
 	nf_tables_table_destroy(&ctx);
 }
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 55fcf0280c5c..731511d58b7c 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -221,7 +221,7 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 			list_del(&rule->list);
 			nf_tables_rule_destroy(&chain_ctx, rule);
 		}
-		nf_tables_chain_destroy(&chain_ctx);
+		nf_tables_chain_destroy(chain);
 		break;
 	default:
 		break;
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 5f2e06815745..63c02040b426 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -168,7 +168,7 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index f59a2cb2c803..91f5ef6be0f2 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -901,7 +901,7 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		sch_tree_lock(sch);
 	}
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		if (!skb)
 			break;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 9330923a624c..47b5a056165c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -431,7 +431,7 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	while (sch->q.qlen > sch->limit ||
 	       q->memory_usage > q->memory_limit) {
-		struct sk_buff *skb = fq_codel_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		q->cstats.drop_len += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 68e6acd0f130..607c580d75e4 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -357,7 +357,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_pie_qdisc_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		len_dropped += qdisc_pkt_len(skb);
 		num_dropped += 1;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d26cd436cbe3..83fc44f20e31 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -560,7 +560,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	qlen = sch->q.qlen;
 	prev_backlog = sch->qstats.backlog;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = hhf_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		rtnl_kfree_skbs(skb, skb);
 	}
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b60b31ef71cc..e1bb151a9719 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -190,7 +190,7 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Drop excess packets if new limit is lower */
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 916dc2e81e42..f3d09998c24d 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -518,6 +518,8 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static DEFINE_MUTEX(sctp_sysctl_mutex);
+
 static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -542,6 +544,7 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 		if (new_value > max || new_value < min)
 			return -EINVAL;
 
+		mutex_lock(&sctp_sysctl_mutex);
 		net->sctp.udp_port = new_value;
 		sctp_udp_sock_stop(net);
 		if (new_value) {
@@ -554,6 +557,7 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 		lock_sock(sk);
 		sctp_sk(sk)->udp_port = htons(net->sctp.udp_port);
 		release_sock(sk);
+		mutex_unlock(&sctp_sysctl_mutex);
 	}
 
 	return ret;
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index f37f4a0fcd3c..44d7f1aef9f1 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -396,7 +396,6 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
-	shinfo->frag_list = NULL;
 
 	/* If we don't know the length go max plus page for cipher overhead */
 	need_spc = strp->stm.full_len ?: TLS_MAX_PAYLOAD_SIZE + PAGE_SIZE;
@@ -412,6 +411,8 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 				   page, 0, 0);
 	}
 
+	shinfo->frag_list = NULL;
+
 	strp->copy_mode = 1;
 	strp->stm.offset = 0;
 
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index 6aba02a31c96..77685a7eb767 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -112,7 +112,7 @@ static int __init sample_trace_array_init(void)
 	/*
 	 * If context specific per-cpu buffers havent already been allocated.
 	 */
-	trace_printk_init_buffers();
+	trace_array_init_printk(tr);
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
 	if (IS_ERR(simple_tsk)) {
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 4a7e20bb11bc..802c5ed4a5ba 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1569,7 +1569,7 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct esschan *es;
-	int apu1, apu2;
+	int err, apu1, apu2;
 
 	apu1 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_CAPTURE);
 	if (apu1 < 0)
@@ -1613,7 +1613,9 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_es1968_capture;
 	runtime->hw.buffer_bytes_max = runtime->hw.period_bytes_max =
 		calc_available_memory_size(chip) - 1024; /* keep MIXBUF size */
-	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	if (err < 0)
+		return err;
 
 	spin_lock_irq(&chip->substream_lock);
 	list_add(&es->list, &chip->substream_list);
diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
index b75fbb3236a7..f5fa09d740b4 100644
--- a/sound/sh/Kconfig
+++ b/sound/sh/Kconfig
@@ -14,7 +14,7 @@ if SND_SUPERH
 
 config SND_AICA
 	tristate "Dreamcast Yamaha AICA sound"
-	depends on SH_DREAMCAST
+	depends on SH_DREAMCAST && SH_DMA_API
 	select SND_PCM
 	select G2_DMA
 	help
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 42302c7812c7..b2a612c5b299 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2138,6 +2138,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
@@ -2146,6 +2148,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index a0b8688b0836..a705493c04bb 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,8 +3,13 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
+ALIGNS := 0x1000 0x200000 0x1000000
+ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
+ALIGN_STATIC_PIES := $(patsubst %,load_address.static.%,$(ALIGNS))
+ALIGNMENT_TESTS   := $(ALIGN_PIES) $(ALIGN_STATIC_PIES)
+
 TEST_PROGS := binfmt_script.py
-TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
+TEST_GEN_PROGS := execveat non-regular $(ALIGNMENT_TESTS)
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
@@ -28,9 +33,9 @@ $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
 $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
-$(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
-$(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
-$(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
+$(OUTPUT)/load_address.0x%: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
+		-fPIE -pie $< -o $@
+$(OUTPUT)/load_address.static.0x%: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
+		-fPIE -static-pie $< -o $@
diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
index d487c2f6a615..8257fddba8c8 100644
--- a/tools/testing/selftests/exec/load_address.c
+++ b/tools/testing/selftests/exec/load_address.c
@@ -5,10 +5,13 @@
 #include <link.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include "../kselftest.h"
 
 struct Statistics {
 	unsigned long long load_address;
 	unsigned long long alignment;
+	bool interp;
 };
 
 int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
@@ -25,11 +28,20 @@ int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
 	stats->alignment = 0;
 
 	for (i = 0; i < info->dlpi_phnum; i++) {
+		unsigned long long align;
+
+		if (info->dlpi_phdr[i].p_type == PT_INTERP) {
+			stats->interp = true;
+			continue;
+		}
+
 		if (info->dlpi_phdr[i].p_type != PT_LOAD)
 			continue;
 
-		if (info->dlpi_phdr[i].p_align > stats->alignment)
-			stats->alignment = info->dlpi_phdr[i].p_align;
+		align = info->dlpi_phdr[i].p_align;
+
+		if (align > stats->alignment)
+			stats->alignment = align;
 	}
 
 	return 1;  // Terminate dl_iterate_phdr.
@@ -37,32 +49,57 @@ int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
 
 int main(int argc, char **argv)
 {
-	struct Statistics extracted;
-	unsigned long long misalign;
+	struct Statistics extracted = { };
+	unsigned long long misalign, pow2;
+	bool interp_needed;
+	char buf[1024];
+	FILE *maps;
 	int ret;
 
-	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
-	if (ret != 1) {
-		fprintf(stderr, "FAILED\n");
-		return 1;
-	}
+	ksft_print_header();
+	ksft_set_plan(4);
 
-	if (extracted.alignment == 0) {
-		fprintf(stderr, "No alignment found\n");
-		return 1;
-	} else if (extracted.alignment & (extracted.alignment - 1)) {
-		fprintf(stderr, "Alignment is not a power of 2\n");
-		return 1;
+	/* Dump maps file for debugging reference. */
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		ksft_exit_fail_msg("FAILED: /proc/self/maps: %s\n", strerror(errno));
+	while (fgets(buf, sizeof(buf), maps)) {
+		ksft_print_msg("%s", buf);
 	}
+	fclose(maps);
+
+	/* Walk the program headers. */
+	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
+	if (ret != 1)
+		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");
+
+	/* Report our findings. */
+	ksft_print_msg("load_address=%#llx alignment=%#llx\n",
+		       extracted.load_address, extracted.alignment);
+
+	/* If we're named with ".static." we expect no INTERP. */
+	interp_needed = strstr(argv[0], ".static.") == NULL;
+
+	/* Were we built as expected? */
+	ksft_test_result(interp_needed == extracted.interp,
+			 "%s INTERP program header %s\n",
+			 interp_needed ? "Wanted" : "Unwanted",
+			 extracted.interp ? "seen" : "missing");
 
+	/* Did we find an alignment? */
+	ksft_test_result(extracted.alignment != 0,
+			 "Alignment%s found\n", extracted.alignment ? "" : " NOT");
+
+	/* Is the alignment sane? */
+	pow2 = extracted.alignment & (extracted.alignment - 1);
+	ksft_test_result(pow2 == 0,
+			 "Alignment is%s a power of 2: %#llx\n",
+			 pow2 == 0 ? "" : " NOT", extracted.alignment);
+
+	/* Is the load address aligned? */
 	misalign = extracted.load_address & (extracted.alignment - 1);
-	if (misalign) {
-		printf("alignment = %llu, load_address = %llu\n",
-			extracted.alignment, extracted.load_address);
-		fprintf(stderr, "FAILED\n");
-		return 1;
-	}
+	ksft_test_result(misalign == 0, "Load Address is %saligned (%#llx)\n",
+			 misalign ? "MIS" : "", misalign);
 
-	fprintf(stderr, "PASS\n");
-	return 0;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 309b3750e57e..38fec412206b 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -89,6 +89,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 	int compaction_index = 0;
 	char initial_nr_hugepages[20] = {0};
 	char nr_hugepages[20] = {0};
+	char target_nr_hugepages[24] = {0};
+	int slen;
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -119,11 +121,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 
 	lseek(fd, 0, SEEK_SET);
 
-	/* Request a large number of huge pages. The Kernel will allocate
-	   as much as it can */
-	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+	/*
+	 * Request huge pages for about half of the free memory. The Kernel
+	 * will allocate as much as it can, and we expect it will get at least 1/3
+	 */
+	nr_hugepages_ul = mem_free / hugepage_size / 2;
+	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
+		 "%lu", nr_hugepages_ul);
+
+	slen = strlen(target_nr_hugepages);
+	if (write(fd, target_nr_hugepages, slen) != slen) {
+		ksft_print_msg("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
+			       nr_hugepages_ul, strerror(errno));
 		goto close_fd;
 	}
 

