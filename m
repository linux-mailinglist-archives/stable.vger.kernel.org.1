Return-Path: <stable+bounces-121819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B594A59C7D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90162188DC82
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FD230BF9;
	Mon, 10 Mar 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZSkt+m6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25685230BF8;
	Mon, 10 Mar 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626721; cv=none; b=qdZXbtAaxIIPxjhG4gPKZU6XKC3S0hqj2BjuEI2RwB5IDtTWKEtE+pjVJeTo/Rqgr68oUNOwZWm1jEEbWFc5QOtKbaDYkq5c+J1KfuA2KAhbQJFOzIoP7cWM/esQXFrXi9VlGtiYFj3EOWDvqmgxpoxNGvv/xgnt7UzToW34Dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626721; c=relaxed/simple;
	bh=BwRJwRcwffq3SGGcaBbIJtCnFvBZYPNDgT9o1DwOU5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1Sg5v7INyPQWOX26GQ0sUZTIGbEnSZcFi2CNgxHpZxJymtfp/KzFIpCQMjsIu244MubuPN5f779MzxFvXI2kdWqYItF8utaePY2TxcbulsktbL7iNVByI3NDqsLzVadjvQyUkIHDsuS4OZ5I2N0tAGgzd77Tcv1TUnn4CYMyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZSkt+m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D3AC4CEE5;
	Mon, 10 Mar 2025 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626720;
	bh=BwRJwRcwffq3SGGcaBbIJtCnFvBZYPNDgT9o1DwOU5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZSkt+m6Fw1nwfFUVvQsYMj85TbAeBFkDBt05EldaTSuIEZipytkW8HvRSSTmoDes
	 94dHEmqx+GYF9V8rczJhXt5mXIaHlFPpDnmdPJSeaHpeR5kZOIQuWfmZFv1fwfa76K
	 ZobLmHVwSsZVvpNceZ6BwgtoIomBufo5qwE/miqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Russel King <linux@armlinux.org.uk>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 072/207] arm: pgtable: fix NULL pointer dereference issue
Date: Mon, 10 Mar 2025 18:04:25 +0100
Message-ID: <20250310170450.625676290@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Zheng <zhengqi.arch@bytedance.com>

commit a564ccfe300fa6a065beda06ab7f3c140d6b4d63 upstream.

When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
parameter is NULL, which will cause a NULL pointer dereference issue in
adjust_pte():

Unable to handle kernel NULL pointer dereference at virtual address 00000030 when read
Hardware name: Atmel AT91SAM9
PC is at update_mmu_cache_range+0x1e0/0x278
LR is at pte_offset_map_rw_nolock+0x18/0x2c
Call trace:
 update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
 remove_migration_pte from rmap_walk_file+0xcc/0x130
 rmap_walk_file from remove_migration_ptes+0x90/0xa4
 remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
 migrate_pages_batch from migrate_pages+0x188/0x488
 migrate_pages from compact_zone+0x56c/0x954
 compact_zone from compact_node+0x90/0xf0
 compact_node from kcompactd+0x1d4/0x204
 kcompactd from kthread+0x120/0x12c
 kthread from ret_from_fork+0x14/0x38
Exception stack(0xc0d8bfb0 to 0xc0d8bff8)

To fix it, do not rely on whether 'ptl' is equal to decide whether to hold
the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
enabled.  In addition, if two vmas map to the same PTE page, there is no
need to hold the pte lock again, otherwise a deadlock will occur.  Just
add the need_lock parameter to let adjust_pte() know this information.

Link: https://lkml.kernel.org/r/20250217024924.57996-1-zhengqi.arch@bytedance.com
Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Russel King <linux@armlinux.org.uk>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mm/fault-armv.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_
 }
 
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
-		      unsigned long pfn, struct vm_fault *vmf)
+		      unsigned long pfn, bool need_lock)
 {
 	spinlock_t *ptl;
 	pgd_t *pgd;
@@ -99,12 +99,11 @@ again:
 	if (!pte)
 		return 0;
 
-	/*
-	 * If we are using split PTE locks, then we need to take the page
-	 * lock here.  Otherwise we are using shared mm->page_table_lock
-	 * which is already locked, thus cannot take it.
-	 */
-	if (ptl != vmf->ptl) {
+	if (need_lock) {
+		/*
+		 * Use nested version here to indicate that we are already
+		 * holding one similar spinlock.
+		 */
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
 			pte_unmap_unlock(pte, ptl);
@@ -114,7 +113,7 @@ again:
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	if (ptl != vmf->ptl)
+	if (need_lock)
 		spin_unlock(ptl);
 	pte_unmap(pte);
 
@@ -123,9 +122,10 @@ again:
 
 static void
 make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
-	      unsigned long addr, pte_t *ptep, unsigned long pfn,
-	      struct vm_fault *vmf)
+	      unsigned long addr, pte_t *ptep, unsigned long pfn)
 {
+	const unsigned long pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
+	const unsigned long pmd_end_addr = pmd_start_addr + PMD_SIZE;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
@@ -142,6 +142,14 @@ make_coherent(struct address_space *mapp
 	flush_dcache_mmap_lock(mapping);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		/*
+		 * If we are using split PTE locks, then we need to take the pte
+		 * lock. Otherwise we are using shared mm->page_table_lock which
+		 * is already locked, thus cannot take it.
+		 */
+		bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
+		unsigned long mpnt_addr;
+
+		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
 		 * that we are fixing up.
@@ -151,7 +159,12 @@ make_coherent(struct address_space *mapp
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
+		mpnt_addr = mpnt->vm_start + offset;
+
+		/* Avoid deadlocks by not grabbing the same PTE lock again. */
+		if (mpnt_addr >= pmd_start_addr && mpnt_addr < pmd_end_addr)
+			need_lock = false;
+		aliases += adjust_pte(mpnt, mpnt_addr, pfn, need_lock);
 	}
 	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
@@ -194,7 +207,7 @@ void update_mmu_cache_range(struct vm_fa
 		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
+			make_coherent(mapping, vma, addr, ptep, pfn);
 		else if (vma->vm_flags & VM_EXEC)
 			__flush_icache_all();
 	}



