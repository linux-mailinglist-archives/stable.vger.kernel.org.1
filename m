Return-Path: <stable+bounces-140103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD464AAA51B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15DE1891387
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35328B4E2;
	Mon,  5 May 2025 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTLJgtmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67C28A41E;
	Mon,  5 May 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484113; cv=none; b=oNvLR2t36tvyQYb1NvJqye0fe71K3AgIFJpWESFEoi4nkX8xCNkLbwH3j42dGQZWQdA2iNtKVfqzkgxJIfwzCdnVHwVajvP+hMyXQ8uX99pQqMwI9G7pNHJoUtYrQCGaD+D4OPUBnPPwR0NECbwG++dtvHVdn6O6GfHPm61JiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484113; c=relaxed/simple;
	bh=ApFm9vLJ/UCWGBwkbNk+1UcafOAJvv7wL+n2CHNQN2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYNUZ2F2BRZ58w/UU4jqyL7CQuEjXP9P0igUjNc9Xg1IBtc+Jg8aM/vfLSnN2XEVysGp57YKaV34WCNW7hGUFwM6s+FNU/MQLVwRZCHoUXIZvnLh8O+yys4BgxlisVGRnyhtPTuh00ThCTb0fZzIiG0XD8SrSPuTIDwf7xfpEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTLJgtmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F09BC4CEED;
	Mon,  5 May 2025 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484112;
	bh=ApFm9vLJ/UCWGBwkbNk+1UcafOAJvv7wL+n2CHNQN2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTLJgtmimST+gN+SoaKK9lvljXGMaztm07ezAPoeoca39H6vP9oFW8lOeC5WjvNhG
	 V8HNQTLTJeI/RSBgWFG0DXxUjiIJ4yOWqG1MjL89NkZQoCNXxTaIQYKOM6HyOc564e
	 bmnjuIwzkVyPL1tAvEFZ4weqCyUsw9GQPSVeJcGS5l7JZjl5VF4Wt4HhjNc9cX1SH+
	 O1iZeT3IdXw4YgqRuynhuLUguTHr5jHQqQeCWTCvvresjTSMZQUUc2WHZyFAJmZxcG
	 /khnFRHASctyqKkdJiHyZNHBC9p3d8tzvSXx1vyCTEOjGhQF2bVqhuPCHqACnjnfIR
	 29MHQe9MitQ4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Manali Shukla <Manali.Shukla@amd.com>,
	Brendan Jackman <jackmanb@google.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jgross@suse.com,
	luto@kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 356/642] x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional
Date: Mon,  5 May 2025 18:09:32 -0400
Message-Id: <20250505221419.2672473-356-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

[ Upstream commit a37259732a7dc33047fa1e4f9a338088f452e017 ]

Currently x86 uses CONFIG_MMU_GATHER_TABLE_FREE when using
paravirt, and not when running on bare metal.

There is no real good reason to do things differently for
each setup. Make them all the same.

Currently get_user_pages_fast synchronizes against page table
freeing in two different ways:

 - on bare metal, by blocking IRQs, which block TLB flush IPIs
 - on paravirt, with MMU_GATHER_RCU_TABLE_FREE

This is done because some paravirt TLB flush implementations
handle the TLB flush in the hypervisor, and will do the flush
even when the target CPU has interrupts disabled.

Always handle page table freeing with MMU_GATHER_RCU_TABLE_FREE.
Using RCU synchronization between page table freeing and get_user_pages_fast()
allows bare metal to also do TLB flushing while interrupts are disabled.

Various places in the mm do still block IRQs or disable preemption
as an implicit way to block RCU frees.

That makes it safe to use INVLPGB on AMD CPUs.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20250213161423.449435-2-riel@surriel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/kernel/paravirt.c | 17 +----------------
 arch/x86/mm/pgtable.c      | 27 ++++-----------------------
 3 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aeb95b6e55369..088f7555e1ac0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -277,7 +277,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c5bb980b8a673..6669d251c4f75 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -59,21 +59,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-#ifndef CONFIG_PT_RECLAIM
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -197,7 +182,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= native_tlb_remove_table,
+	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 9b0ee41b545c7..1ddbd799acdf5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,25 +18,6 @@ EXPORT_SYMBOL(physical_mask);
 #define PGTABLE_HIGHMEM 0
 #endif
 
-#ifndef CONFIG_PARAVIRT
-#ifndef CONFIG_PT_RECLAIM
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif /* !CONFIG_PT_RECLAIM */
-#endif /* !CONFIG_PARAVIRT */
-
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
@@ -64,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_table(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -78,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_table(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
-- 
2.39.5


