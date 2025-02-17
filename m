Return-Path: <stable+bounces-116522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946FA379EA
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 03:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801343AEA2C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC31474DA;
	Mon, 17 Feb 2025 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DzenUUVT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA6C2C9
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760582; cv=none; b=UhuzoqxJ6fHtN5YSO+kf3pgSYVT0hSuJ5oq55GMROTwevvEAEt0+T4IPlD/CQqhUEuGfeYKVq7yVmSy1pbgXK1KMyUeicpGgM10kOSyS5dOtuClPQcFvL59saTTH3DVNcyAOM65EcZToYfCSPLHmqRLka4uZDCfdH6ItsL8ZRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760582; c=relaxed/simple;
	bh=OPkOrqOU3T2OquUtXl1dDwsvVSDYWn7LrdDhRAKERJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEbVXGLBd8XlCrl0k0TBSgal0asZxg8rvNTE23iAp+HAbnYOpbGMk00ImWBEWY3TaepKMcTVYl5DT1OImbxYzvuOHB63v2iCxYiY75c63tVfm1IIwe10wu1xh0yjRDmus8bpOUMPOQFLHMxtK7UIUveMN8M2ID1C5Yobq7RVDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DzenUUVT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-221206dbd7eso11427965ad.2
        for <stable@vger.kernel.org>; Sun, 16 Feb 2025 18:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739760579; x=1740365379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyusY8LOZ2yGcku6OPIUO2n+8tkrExwGCuVjXg24M28=;
        b=DzenUUVT/hFLaUqVR0fcv5bIbblD2pMqJCTkmAHsdOHdOHX7zDRfJaRqLW+YFzrP49
         ++IdiX+hxsAjpsVv8Vh+ff2/PwT91rmLQ65ogtK4WcKvTi/FLBu2sB/bONlkbv2d4tn8
         fOiQ+hBxa8U1U2S7WBeduVAKXGd8jhLFZKtOo3yl6kbZUkKR4kKAfOnao4l3om9ErFwO
         fo9INhroezscPTJMmcxbPiUJADeCQkpD6s00RbbWWT3/i+ZWJencmB0fyTQC9jaQAtwO
         Uy2PQ99DTCgvY7QCPFHJY2eFr6kXZrUeiIMSMhohP9bugdbIr1zbAYE/ujbc1rQP3df8
         JhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739760579; x=1740365379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyusY8LOZ2yGcku6OPIUO2n+8tkrExwGCuVjXg24M28=;
        b=deFweDBXWjagpe+gGHyIhDgol9y8MwyeWQ5llrV3hSs1p1cd4h6u/y0akoDw9O6Yj9
         TA3GJitUUAVDDzGaIMpZ95PzcSm90FJghXoLTPBAUAnqeG4Ti8ZWQQ+QScTNDVdjumWz
         DnsHHhiuIarm9jMjudoXZ3bLy7ooRRS+zPw4vKNSJLfatc3NqF/nJJEr4NBPR72HwwfZ
         31lkODwaRiVPoSkoG9XqClnmsn5L3YgvsILKXxcV9nrPgo2QNxQibCG84Z8Jyh11+XYM
         RngUvfMabdI6j0g+CqsZarr5hjGhkxF07UVAQlyX7ldzntjwRoZGOQvCGAh97BMa1+lO
         XV4w==
X-Forwarded-Encrypted: i=1; AJvYcCVKhQ+g1V6k3pZQ4SyoouqkzmqibryAh7mDoKr2vvlrdqSEPbaGzFu8HGS6w+mD39YERsjkkks=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEM6UA6OoVO8imMC2fr45NIWPjd9pxDJdePzGOdvhnMiLhp6m
	py8f7FlYVYkVmIdiDzVh0W+nKB07eFQz20hupw9KSJ1ftOk5OgaATqxCIhlK/tA=
X-Gm-Gg: ASbGncuDJaKDLJgiDdbxE0AfB/V1wBiQy0MxaDhSlsNMsPNFxp0c3HP6V0ekzh+zUU8
	yBdH130hnJEzBtPjil4f//Yv/5fsPSkOGGWWIvqgcHyzvOFgWeqrJuG915Pk6+AIWZX/t8yR0T6
	dJVW+zBJC0YtUEoA70LRtdhZ66IrOZLH1tWbzbPfc0F6nVrvH4ZaAF8dXpTGl18uYWsv1X+t4Lo
	Pb8meCUPsn955NgmrDaX/qBRCJmtFw+vb6uiDo72xFWOginnuMjUbSau85h3fR6YuZJnDyObJWk
	VD/MPJftDKYQ8RMGUEuzYUUkElZ1jRmLA0VMwnB8ssK1hsS1yRe++Lo=
X-Google-Smtp-Source: AGHT+IFciXt96/01ZBgsdmjwKLN9qYlNk8Q0caweyaAHGXTWtcDu/3P5N7kTsRChFbonsJzIjM6PrA==
X-Received: by 2002:a17:902:d58b:b0:21f:7821:55b0 with SMTP id d9443c01a7336-22103f064b5mr135755745ad.14.1739760578735;
        Sun, 16 Feb 2025 18:49:38 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d000sm61823135ad.111.2025.02.16.18.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:49:38 -0800 (PST)
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
Subject: [PATCH v3] arm: pgtable: fix NULL pointer dereference issue
Date: Mon, 17 Feb 2025 10:49:24 +0800
Message-Id: <20250217024924.57996-1-zhengqi.arch@bytedance.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
Changes in v3:
 - move pmd_start_addr and pmd_end_addr to the top and initialize directly
   (David Hildenbrand)
 - collect an Acked-by

Changes in v2:
 - change Ezra's email address (Ezra Buehler)
 - some cleanups (David Hildenbrand)

 arch/arm/mm/fault-armv.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 2bec87c3327d2..39fd5df733178 100644
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
 
@@ -123,9 +122,10 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
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
@@ -141,6 +141,14 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
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
@@ -151,7 +159,12 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
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
@@ -194,7 +207,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
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


