Return-Path: <stable+bounces-204863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D787CF4F75
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C9D31867DF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7502836E;
	Mon,  5 Jan 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRTyfJ44"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8843161A2
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633158; cv=none; b=gCaV+tEskFY9UH7tUMDI2Kbgu610/uiDDo434mcH333l7X3DtMn6b0TmtI60HhgiEBOT88bbocx9lNeljcRH1E1LGb8YRORx96KqKfZ3PZd4+ds7ZQBrrNWP+Yi0ZBLoH5gnZ6I1o6oEBDYBr8ODJ61QoweBjc6XHG2W8nvJ8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633158; c=relaxed/simple;
	bh=tdwgN/P1tbOtbEHt+u0RoUssSljCpV6Kpz6bAl6xkfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7onkptnNmAIb1/zo5jVq3NbP2UGBxfok0nla4SQObJbpZHmLlwIqX/hmrIUzjph+SfQ+x4cQxxFWaBAhoBXcfx0jfYAFItbHDoAnQ5XvhUUNhat3s5KcXxu5G7xZYHKvtJucQNvChLun8I//2SQyYRmx1g7PC9hv0W5FWdvutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRTyfJ44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47015C116D0;
	Mon,  5 Jan 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633157;
	bh=tdwgN/P1tbOtbEHt+u0RoUssSljCpV6Kpz6bAl6xkfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRTyfJ44jmJdv2FKnAjNfGmprfGKSqhhEuBHWnOXSdybaOKIxzxBkZAzDCPHMK19M
	 E8yqZuoJAPCGTwkKNCVr8ScPWl4cTNo75qJ1MM9NvpgudEFoGXIVxdvuQ5XbtxCtzw
	 Tf3EmKMju1P2LoT906uwZTKVQPlTYrkshMzPR0BQDOHePk9qbqYm1jscO0VEI+R7Ml
	 RS0FJOtP616M6WgLheogxw7XCnWBG0WgR+Hc+R22IdFFCfWYYhiwWqX/0uz5JpiWiA
	 8lUBjcpImDVyT6w/Js86lTwpjrd6jp9jFQ6PgUW/4MRI/ixC29PRq1gj6wMZjr/+Aj
	 F35xr1b5pKNlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donet Tom <donettom@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] powerpc/64s/slb: Fix SLB multihit issue during SLB preload
Date: Mon,  5 Jan 2026 12:12:35 -0500
Message-ID: <20260105171235.2685455-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010521-coma-linked-0942@gregkh>
References: <2026010521-coma-linked-0942@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Donet Tom <donettom@linux.ibm.com>

[ Upstream commit 00312419f0863964625d6dcda8183f96849412c6 ]

On systems using the hash MMU, there is a software SLB preload cache that
mirrors the entries loaded into the hardware SLB buffer. This preload
cache is subject to periodic eviction — typically after every 256 context
switches — to remove old entry.

To optimize performance, the kernel skips switch_mmu_context() in
switch_mm_irqs_off() when the prev and next mm_struct are the same.
However, on hash MMU systems, this can lead to inconsistencies between
the hardware SLB and the software preload cache.

If an SLB entry for a process is evicted from the software cache on one
CPU, and the same process later runs on another CPU without executing
switch_mmu_context(), the hardware SLB may retain stale entries. If the
kernel then attempts to reload that entry, it can trigger an SLB
multi-hit error.

The following timeline shows how stale SLB entries are created and can
cause a multi-hit error when a process moves between CPUs without a
MMU context switch.

CPU 0                                   CPU 1
-----                                    -----
Process P
exec                                    swapper/1
 load_elf_binary
  begin_new_exc
    activate_mm
     switch_mm_irqs_off
      switch_mmu_context
       switch_slb
       /*
        * This invalidates all
        * the entries in the HW
        * and setup the new HW
        * SLB entries as per the
        * preload cache.
        */
context_switch
sched_migrate_task migrates process P to cpu-1

Process swapper/0                       context switch (to process P)
(uses mm_struct of Process P)           switch_mm_irqs_off()
                                         switch_slb
                                           load_slb++
                                            /*
                                            * load_slb becomes 0 here
                                            * and we evict an entry from
                                            * the preload cache with
                                            * preload_age(). We still
                                            * keep HW SLB and preload
                                            * cache in sync, that is
                                            * because all HW SLB entries
                                            * anyways gets evicted in
                                            * switch_slb during SLBIA.
                                            * We then only add those
                                            * entries back in HW SLB,
                                            * which are currently
                                            * present in preload_cache
                                            * (after eviction).
                                            */
                                        load_elf_binary continues...
                                         setup_new_exec()
                                          slb_setup_new_exec()

                                        sched_switch event
                                        sched_migrate_task migrates
                                        process P to cpu-0

context_switch from swapper/0 to Process P
 switch_mm_irqs_off()
  /*
   * Since both prev and next mm struct are same we don't call
   * switch_mmu_context(). This will cause the HW SLB and SW preload
   * cache to go out of sync in preload_new_slb_context. Because there
   * was an SLB entry which was evicted from both HW and preload cache
   * on cpu-1. Now later in preload_new_slb_context(), when we will try
   * to add the same preload entry again, we will add this to the SW
   * preload cache and then will add it to the HW SLB. Since on cpu-0
   * this entry was never invalidated, hence adding this entry to the HW
   * SLB will cause a SLB multi-hit error.
   */
load_elf_binary continues...
 START_THREAD
  start_thread
   preload_new_slb_context
   /*
    * This tries to add a new EA to preload cache which was earlier
    * evicted from both cpu-1 HW SLB and preload cache. This caused the
    * HW SLB of cpu-0 to go out of sync with the SW preload cache. The
    * reason for this was, that when we context switched back on CPU-0,
    * we should have ideally called switch_mmu_context() which will
    * bring the HW SLB entries on CPU-0 in sync with SW preload cache
    * entries by setting up the mmu context properly. But we didn't do
    * that since the prev mm_struct running on cpu-0 was same as the
    * next mm_struct (which is true for swapper / kernel threads). So
    * now when we try to add this new entry into the HW SLB of cpu-0,
    * we hit a SLB multi-hit error.
    */

WARNING: CPU: 0 PID: 1810970 at arch/powerpc/mm/book3s64/slb.c:62
assert_slb_presence+0x2c/0x50(48 results) 02:47:29 [20157/42149]
Modules linked in:
CPU: 0 UID: 0 PID: 1810970 Comm: dd Not tainted 6.16.0-rc3-dirty #12
VOLUNTARY
Hardware name: IBM pSeries (emulated by qemu) POWER8 (architected)
0x4d0200 0xf000004 of:SLOF,HEAD hv:linux,kvm pSeries
NIP:  c00000000015426c LR: c0000000001543b4 CTR: 0000000000000000
REGS: c0000000497c77e0 TRAP: 0700   Not tainted  (6.16.0-rc3-dirty)
MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28888482  XER: 00000000
CFAR: c0000000001543b0 IRQMASK: 3
<...>
NIP [c00000000015426c] assert_slb_presence+0x2c/0x50
LR [c0000000001543b4] slb_insert_entry+0x124/0x390
Call Trace:
  0x7fffceb5ffff (unreliable)
  preload_new_slb_context+0x100/0x1a0
  start_thread+0x26c/0x420
  load_elf_binary+0x1b04/0x1c40
  bprm_execve+0x358/0x680
  do_execveat_common+0x1f8/0x240
  sys_execve+0x58/0x70
  system_call_exception+0x114/0x300
  system_call_common+0x160/0x2c4

>From the above analysis, during early exec the hardware SLB is cleared,
and entries from the software preload cache are reloaded into hardware
by switch_slb. However, preload_new_slb_context and slb_setup_new_exec
also attempt to load some of the same entries, which can trigger a
multi-hit. In most cases, these additional preloads simply hit existing
entries and add nothing new. Removing these functions avoids redundant
preloads and eliminates the multi-hit issue. This patch removes these
two functions.

We tested process switching performance using the context_switch
benchmark on POWER9/hash, and observed no regression.

Without this patch: 129041 ops/sec
With this patch:    129341 ops/sec

We also measured SLB faults during boot, and the counts are essentially
the same with and without this patch.

SLB faults without this patch: 19727
SLB faults with this patch:    19786

Fixes: 5434ae74629a ("powerpc/64s/hash: Add a SLB preload cache")
cc: stable@vger.kernel.org
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/0ac694ae683494fe8cadbd911a1a5018d5d3c541.1761834163.git.ritesh.list@gmail.com
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 -
 arch/powerpc/kernel/process.c                 |  5 --
 arch/powerpc/mm/book3s64/internal.h           |  1 -
 arch/powerpc/mm/book3s64/mmu_context.c        |  2 -
 arch/powerpc/mm/book3s64/slb.c                | 88 -------------------
 5 files changed, 97 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 3004f3323144..3cfc32ab7d49 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -524,7 +524,6 @@ void slb_dump_contents(struct slb_entry *slb_ptr);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
-void preload_new_slb_context(unsigned long start, unsigned long sp);
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 365e538ff2d7..bce508fb9ec1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1794,8 +1794,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
-void preload_new_slb_context(unsigned long start, unsigned long sp);
-
 /*
  * Set up a thread for executing a new program
  */
@@ -1803,9 +1801,6 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 {
 #ifdef CONFIG_PPC64
 	unsigned long load_addr = regs->gpr[2];	/* saved by ELF_PLAT_INIT */
-
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled())
-		preload_new_slb_context(start, sp);
 #endif
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
diff --git a/arch/powerpc/mm/book3s64/internal.h b/arch/powerpc/mm/book3s64/internal.h
index 5045048ce244..ec812afda889 100644
--- a/arch/powerpc/mm/book3s64/internal.h
+++ b/arch/powerpc/mm/book3s64/internal.h
@@ -13,7 +13,6 @@ static inline bool stress_slb(void)
 	return static_branch_unlikely(&stress_slb_key);
 }
 
-void slb_setup_new_exec(void);
 
 void exit_lazy_flush_tlb(struct mm_struct *mm, bool always_flush);
 
diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index c10fc8a72fb3..4be529c7a90d 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -147,8 +147,6 @@ static int hash__init_new_context(struct mm_struct *mm)
 void hash__setup_new_exec(void)
 {
 	slice_setup_new_exec();
-
-	slb_setup_new_exec();
 }
 
 static int radix__init_new_context(struct mm_struct *mm)
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index a4fd2901189c..bea3f5c354bf 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -329,94 +329,6 @@ static void preload_age(struct thread_info *ti)
 	ti->slb_preload_tail = (ti->slb_preload_tail + 1) % SLB_PRELOAD_NR;
 }
 
-void slb_setup_new_exec(void)
-{
-	struct thread_info *ti = current_thread_info();
-	struct mm_struct *mm = current->mm;
-	unsigned long exec = 0x10000000;
-
-	WARN_ON(irqs_disabled());
-
-	/*
-	 * preload cache can only be used to determine whether a SLB
-	 * entry exists if it does not start to overflow.
-	 */
-	if (ti->slb_preload_nr + 2 > SLB_PRELOAD_NR)
-		return;
-
-	hard_irq_disable();
-
-	/*
-	 * We have no good place to clear the slb preload cache on exec,
-	 * flush_thread is about the earliest arch hook but that happens
-	 * after we switch to the mm and have aleady preloaded the SLBEs.
-	 *
-	 * For the most part that's probably okay to use entries from the
-	 * previous exec, they will age out if unused. It may turn out to
-	 * be an advantage to clear the cache before switching to it,
-	 * however.
-	 */
-
-	/*
-	 * preload some userspace segments into the SLB.
-	 * Almost all 32 and 64bit PowerPC executables are linked at
-	 * 0x10000000 so it makes sense to preload this segment.
-	 */
-	if (!is_kernel_addr(exec)) {
-		if (preload_add(ti, exec))
-			slb_allocate_user(mm, exec);
-	}
-
-	/* Libraries and mmaps. */
-	if (!is_kernel_addr(mm->mmap_base)) {
-		if (preload_add(ti, mm->mmap_base))
-			slb_allocate_user(mm, mm->mmap_base);
-	}
-
-	/* see switch_slb */
-	asm volatile("isync" : : : "memory");
-
-	local_irq_enable();
-}
-
-void preload_new_slb_context(unsigned long start, unsigned long sp)
-{
-	struct thread_info *ti = current_thread_info();
-	struct mm_struct *mm = current->mm;
-	unsigned long heap = mm->start_brk;
-
-	WARN_ON(irqs_disabled());
-
-	/* see above */
-	if (ti->slb_preload_nr + 3 > SLB_PRELOAD_NR)
-		return;
-
-	hard_irq_disable();
-
-	/* Userspace entry address. */
-	if (!is_kernel_addr(start)) {
-		if (preload_add(ti, start))
-			slb_allocate_user(mm, start);
-	}
-
-	/* Top of stack, grows down. */
-	if (!is_kernel_addr(sp)) {
-		if (preload_add(ti, sp))
-			slb_allocate_user(mm, sp);
-	}
-
-	/* Bottom of heap, grows up. */
-	if (heap && !is_kernel_addr(heap)) {
-		if (preload_add(ti, heap))
-			slb_allocate_user(mm, heap);
-	}
-
-	/* see switch_slb */
-	asm volatile("isync" : : : "memory");
-
-	local_irq_enable();
-}
-
 static void slb_cache_slbie_kernel(unsigned int index)
 {
 	unsigned long slbie_data = get_paca()->slb_cache[index];
-- 
2.51.0


