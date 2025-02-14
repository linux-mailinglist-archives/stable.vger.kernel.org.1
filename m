Return-Path: <stable+bounces-116356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C8A3552C
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 04:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE51516A8E9
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 03:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFC14F136;
	Fri, 14 Feb 2025 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GRwzHSOw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF584039
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502336; cv=none; b=RdBYpZ09JpzdxXzpE93LjacniUriNCNFmBjV/fKNl5mW/eQ5erNG2srEAjZrQAWkvHyptLrsGOHmavqQwrLJHv8hnwwEDrEGSvM8vKaEDf3LsM6zVy9znBSkAMVdjwwcQufk6nEoPy3ITEoyN8RKHmQeLNjuv2wQDRskHrQWaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502336; c=relaxed/simple;
	bh=TJDCSBAj2ec3338N/q1YZZCvJ2Une4i1PCUFYWpwQNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I40RoHSZ3eDPHN5W0Nb8VSOx3jFwaORugRF/He+DVJTrPDOWBzmEYDl/ecdl5DatwHt08sIL2i3bMeqrhQuFSbwUs6MSuztLYlTitR5V5K/kVE8Kzee6Bw5WyteYdpk4oJiKXaSFUaXt10AO8qmPp5bLpeiIBbRiHwRqr+AVugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GRwzHSOw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bff984a0so27746235ad.3
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739502334; x=1740107134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=880EogUQ7YhTtxOXOr4zFxC4yPI4QQKvoHhCveXLots=;
        b=GRwzHSOwGUOCdTx1eJgNHclXW8qxNa8otx49Y24oxx94G8lZUn6Rn94o/o/Jrwh+eW
         SjvTdrdlQwRixDeUKAFs05674s+hwHbNFe/WNZ3MtsTBwStmePCc/O1l04oXGNM1WFVa
         P+BRcL8BR/wl3AhwVtVyl2T3cYiaOq39l3H+7bR1lEntl/GcN3B+yU315gyGlPcC3/CZ
         R8X4uv+FxNzdSjIGXhnOXstWALCXxOY2TwuayPdVqzSZ0a/M+ouWeMp7A/70mRFEUrUR
         dpao/Y6NpUAPTVIkMHsck9wWXEuIqdmb2l15PP0bLAlqsOIz/A5zkswpA0u3fWgi7kxI
         69Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739502334; x=1740107134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=880EogUQ7YhTtxOXOr4zFxC4yPI4QQKvoHhCveXLots=;
        b=aLX7YIvUOYzlZ75y3ZdYsB4TzPJSqwRJt/JSbH2bgXNamRggWj+2phYKKUEq/AwN0G
         oGoHsRCbidREHovrl50vF9LdqMIKXATxZQvwfCOqpD++5TQzeXd2Cs20J8gcQkLdMymI
         gftiEZZ0ksREZMg35oYRM509+Kc7MKmqTTdWbQAAyVE4Qp8J0mRk5m+mFURFnFc5irNT
         2rmbq4Omlr9su2dJZvTa8p6vSsQq+x0mKZxTnFp+vvzKvogXrO525MJ5gUEzgKCWrB19
         KJnEpA9Rc1Xu2mdqN56UkX+L43OWLnVvJGTw0I6KmijEVNJLFBjItfd/vLYU5fJXGvyO
         o/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWa2Vbf/yJYNsxt7zxx40gTaZdpCH9mBl25i6M3EIWvCsVxOvG0U2r6MbhVFKgOLyut3uneOr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrci2Klu3OWe/YmVLn8sVNB9I8VhnD1X8wD7s0oXBRyofQUAY2
	J+ziYNU55+eY9a7h4gISC1QMnspfXPOMjPDiNpGBTjwTlcXjalGqxSDG0dbPl7Q8gmP7rZ5BvJ6
	H
X-Gm-Gg: ASbGncteZqWmjOi0CrP6mzXsMl/672lWDfGUQRn7h7dKmFS6VlOTzLkbovZSu21ZEYo
	jjp9VXDlh4+b0yBEpLOTmbnmlG2VmdrsAfGcc4UK+s2Q7tPehxs2It4q9otG/ca5lKelL2GoPIl
	BUCpUgDjtp+mHLI4AgJYQlPg81t18T/Z1e31a/1nMbJZypJTQcsi7iX97z2g+lDm6QspKm19Fw2
	8HSS4atGML1JsETwO5Gbgxo3k6lf0oV3tHbYbtz3YXF8Ywm9rkRK9Y2zQB8QuW241Dy7qh+eYQb
	sXznHM41zTieRCEkb9fkQ0Bt4XIhbwpo/t2UMk3pMCZT2WVIf4ZDE8eS
X-Google-Smtp-Source: AGHT+IE0j4ifNKT9H6YLxFTZoD5WzE6IGo9wOiQNtVXNtqnV2ixJQoeneDIT/l4UNMn6vQM3UgH1KQ==
X-Received: by 2002:a05:6a20:431b:b0:1ee:6032:b1e9 with SMTP id adf61e73a8af0-1ee6b360aa3mr9894032637.21.1739502334088;
        Thu, 13 Feb 2025 19:05:34 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a78sm2130486b3a.55.2025.02.13.19.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:05:33 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: linux@armlinux.org.uk,
	ezra@easyb.ch,
	david@redhat.com,
	hughd@google.com,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm: pgtable: fix NULL pointer dereference issue
Date: Fri, 14 Feb 2025 11:03:49 +0800
Message-Id: <20250214030349.45524-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
enabled. In addition, if two vmas map to the same PTE page, there is no
need to hold the pte lock again, otherwise a deadlock will occur. Just add
the need_lock parameter to let adjust_pte() know this information.

Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Changes in v2:
 - change Ezra's email address (Ezra Buehler)
 - some cleanups (David Hildenbrand)

 arch/arm/mm/fault-armv.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 2bec87c3327d2..ea4c4e15f0d31 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
 }
 
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
-		      unsigned long pfn, struct vm_fault *vmf)
+		      unsigned long pfn, bool need_lock)
 {
 	spinlock_t *ptl;
 	pgd_t *pgd;
@@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
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
@@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	if (ptl != vmf->ptl)
+	if (need_lock)
 		spin_unlock(ptl);
 	pte_unmap(pte);
 
@@ -123,16 +122,18 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 static void
 make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
-	      unsigned long addr, pte_t *ptep, unsigned long pfn,
-	      struct vm_fault *vmf)
+	      unsigned long addr, pte_t *ptep, unsigned long pfn)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
+	unsigned long pmd_start_addr, pmd_end_addr;
 	pgoff_t pgoff;
 	int aliases = 0;
 
 	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
+	pmd_end_addr = pmd_start_addr + PMD_SIZE;
 
 	/*
 	 * If we have any shared mappings that are in the same mm
@@ -141,6 +142,14 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
 	 */
 	flush_dcache_mmap_lock(mapping);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
+		/*
+		 * If we are using split PTE locks, then we need to take the pte
+		 * lock. Otherwise we are using shared mm->page_table_lock which
+		 * is already locked, thus cannot take it.
+		 */
+		bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
+		unsigned long mpnt_addr;
+
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
@@ -151,7 +160,12 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
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
@@ -194,7 +208,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
+			make_coherent(mapping, vma, addr, ptep, pfn);
 		else if (vma->vm_flags & VM_EXEC)
 			__flush_icache_all();
 	}
-- 
2.20.1


