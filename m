Return-Path: <stable+bounces-159154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C96BAEFCAB
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543C517807E
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696FE275110;
	Tue,  1 Jul 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTsNjwri"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F726199FAB;
	Tue,  1 Jul 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380412; cv=none; b=eBpx2EO9CXVtEbhKHwmF9VQNeIMzv3QYDW56m30h1f48WF3Yeyc6lNAvwpdg/iFZUovdSQQcCEk4xqXu+Ltx9cj4Q82QwPdPNX5AsqEh5btXTgXe36mTwWHl6WTUL6ySjbsSwjULvhk7sZnkzErUEVsMNylel9/dYeZeVjNnOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380412; c=relaxed/simple;
	bh=8IjX/6hBLH3dp7l+LESG2kt5Quix+NH+Rprw3hJzJkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnmHkXZraKYCYNM9yO1dkU8zWoY8PoKjSRR07rGfrnbQYkV3JqI2T5x479xf2w9wQLYGG0eQtgpO9on1J6WlT9D357DA1VIjLeeUqnQdcIgb3RzIFeR2APZwaPwAiqRC6tupdDXFviOfkGrjxv9oZ2PanFdrs/c0MTn2ZntkrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTsNjwri; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453066fad06so39090345e9.2;
        Tue, 01 Jul 2025 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751380409; x=1751985209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yt3x3zsr5fbqG+1bODhLJma2AVCo1fUrMLDWbtz//4=;
        b=iTsNjwriwmwIXtyX7ShuJPmRIWHzmNAeBJur1VfsHxRi3H5vzM/g05ouQsjDW1FFsq
         YL1PDINVpdDfa/R2xW08GooOiKyXbP7o/1l7fZ3cfiwm2Z6BmOSwFWen4AmKtD8l2Rkt
         P9vjys9q0Jbn5mHJ8/3OJjteWeehDNyT2/1gmWVuXaLiRhm4JLx3/AbAPpVbTDEdj/bd
         NSkxhM+CmCPQ1zUDMUw7yIWHbASSf+kC+jsGnbUWde6MRnkN4P0DpxzcHMn7cvSFqXBR
         wqF8Ss8kokj4YlCfMh7FkhEDT8inFwdHAPagKZO1vh3aAsCaUYbplXjA9PV+IvZOXCMG
         fY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380409; x=1751985209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Yt3x3zsr5fbqG+1bODhLJma2AVCo1fUrMLDWbtz//4=;
        b=o+VVx7jJs+giH43ULkHwKn6vSHKVdv4Jfc22qQpoZX3ax0wkc8MSmqa/tVFugcINLn
         obU0Rtr6cSEmX2r6VM7HZfRaHZIEHSSlC8ETt7Hhpp/UuARg7ob1w+QwgMelFeTHMJTb
         CBXJ9oatRlRXdGNZwM7Wm/9sYaTUISqVYlp1QU11HLjibPDOMz/grmxjQ7DVY+ef+g6O
         OGGXDt9xfs+imw2UHrkqrsDvyD2TT3AH22lcr2xq2MwkbdGNylUeQbpSfhTYgQRI1uu0
         cdOj+14Cy23Kb3Z4lP0++X5XquV1wH369Oyo/uDqgout8GElig5lK7ZO6cmGB7Z3sQf0
         nYig==
X-Forwarded-Encrypted: i=1; AJvYcCVaAm7vRW4c78qV0PiFr+ZmDOM31MelQgVWbp6bHlWiCevEOcBUSmejCnfoXPQ5rk6EK3QdCDGO7mvPxtU=@vger.kernel.org, AJvYcCXEa9kRdY6hN2Cd6L5j3uAmDEj9aKQ3DJL6uJiUPRyVrM4/ZaoRGNkdlPN3aknKbPTD5zWXSLeR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZarrL0WBj1fXn1po3LRTXzO5TaPAN34EPXoYqJmmUkEEkZU/
	pSqGKJVmYZ6Gea+3cf38DZF6HhjNj4d8wS1m9v4y0gxDWliMVR2IeO2T
X-Gm-Gg: ASbGncuGlV/Y62qA2GNII0hCJw44Y/J1ALkfhngrnQOrwPvxVTEWwQQLyX8SvTdbCVS
	UioYXErZSMw9dEzb5CIyA9l8yN0JQ+GDDwk4CdxEG6gXEbY/qUtBlmiI7pHkRj+3LXXwtFlW7Gl
	wS3KPOLifx3BwPo5m5vcG+rBC9q4REHWPUJ9V4hDaTWqXTtA7N10MSFeBVP778Qdh0gMcRUFlfD
	l1cFPnYpYgeZ/HE7mFo4cNmdNMK0zx7GRCNMuCbGNM/MXGwolkrVeHNFXy66Zco9dNBkzvWJqax
	hlfhaHjV06r06i8OA2b7FNAbZiwtJOzjKvywMQUEhCSK0FfcyXo=
X-Google-Smtp-Source: AGHT+IHdbiNvZTIGRfHjK3LlOcp8azh08Vy9sNOtWFRXMMltik4m+thxSCZBh8cytvB5myfYwyr7/g==
X-Received: by 2002:a05:600c:1e8a:b0:450:d3b9:a5fc with SMTP id 5b1f17b1804b1-4539551fea8mr127351845e9.27.1751380408083;
        Tue, 01 Jul 2025 07:33:28 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::305e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe592sm163990875e9.21.2025.07.01.07.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Jul 2025 07:33:27 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
X-Google-Original-From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	21cnbao@gmail.com
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	ioworker0@gmail.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	x86@kernel.org,
	huang.ying.caritas@gmail.com,
	zhengtangquan@oppo.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	mingzhe.yang@ly.com,
	stable@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table access during batched unmap
Date: Tue,  1 Jul 2025 22:31:00 +0800
Message-ID: <20250701143100.6970-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
may read past the end of a PTE table when a large folio's PTE mappings
are not fully contained within a single page table.

While this scenario might be rare, an issue triggerable from userspace must
be fixed regardless of its likelihood. This patch fixes the out-of-bounds
access by refactoring the logic into a new helper, folio_unmap_pte_batch().

The new helper correctly calculates the safe batch size by capping the scan
at both the VMA and PMD boundaries. To simplify the code, it also supports
partial batching (i.e., any number of pages from 1 up to the calculated
safe maximum), as there is no strong reason to special-case for fully
mapped folios.

[1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com

Cc: <stable@vger.kernel.org>
Reported-by: David Hildenbrand <david@redhat.com>
Closes: https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
Suggested-by: Barry Song <baohua@kernel.org>
Acked-by: Barry Song <baohua@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v3 -> v4:
 - Add Reported-by + Closes tags (per David)
 - Pick RB from Lorenzo - thanks!
 - Pick AB from David - thanks!
 - https://lore.kernel.org/linux-mm/20250630011305.23754-1-lance.yang@linux.dev

v2 -> v3:
 - Tweak changelog (per Barry and David)
 - Pick AB from Barry - thanks!
 - https://lore.kernel.org/linux-mm/20250627062319.84936-1-lance.yang@linux.dev

v1 -> v2:
 - Update subject and changelog (per Barry)
 - https://lore.kernel.org/linux-mm/20250627025214.30887-1-lance.yang@linux.dev

 mm/rmap.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index fb63d9256f09..1320b88fab74 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1845,23 +1845,32 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
 #endif
 }
 
-/* We support batch unmapping of PTEs for lazyfree large folios */
-static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
-			struct folio *folio, pte_t *ptep)
+static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
+			struct page_vma_mapped_walk *pvmw,
+			enum ttu_flags flags, pte_t pte)
 {
 	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
-	int max_nr = folio_nr_pages(folio);
-	pte_t pte = ptep_get(ptep);
+	unsigned long end_addr, addr = pvmw->address;
+	struct vm_area_struct *vma = pvmw->vma;
+	unsigned int max_nr;
+
+	if (flags & TTU_HWPOISON)
+		return 1;
+	if (!folio_test_large(folio))
+		return 1;
 
+	/* We may only batch within a single VMA and a single page table. */
+	end_addr = pmd_addr_end(addr, vma->vm_end);
+	max_nr = (end_addr - addr) >> PAGE_SHIFT;
+
+	/* We only support lazyfree batching for now ... */
 	if (!folio_test_anon(folio) || folio_test_swapbacked(folio))
-		return false;
+		return 1;
 	if (pte_unused(pte))
-		return false;
-	if (pte_pfn(pte) != folio_pfn(folio))
-		return false;
+		return 1;
 
-	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
-			       NULL, NULL) == max_nr;
+	return folio_pte_batch(folio, addr, pvmw->pte, pte, max_nr, fpb_flags,
+			       NULL, NULL, NULL);
 }
 
 /*
@@ -2024,9 +2033,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (pte_dirty(pteval))
 				folio_mark_dirty(folio);
 		} else if (likely(pte_present(pteval))) {
-			if (folio_test_large(folio) && !(flags & TTU_HWPOISON) &&
-			    can_batch_unmap_folio_ptes(address, folio, pvmw.pte))
-				nr_pages = folio_nr_pages(folio);
+			nr_pages = folio_unmap_pte_batch(folio, &pvmw, flags, pteval);
 			end_addr = address + nr_pages * PAGE_SIZE;
 			flush_cache_range(vma, address, end_addr);
 
@@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		} else {
 			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
-			folio_ref_sub(folio, nr_pages - 1);
 		}
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
-		folio_put(folio);
-		/* We have already batched the entire folio */
-		if (nr_pages > 1)
+		folio_put_refs(folio, nr_pages);
+
+		/*
+		 * If we are sure that we batched the entire folio and cleared
+		 * all PTEs, we can just optimize and stop right here.
+		 */
+		if (nr_pages == folio_nr_pages(folio))
 			goto walk_done;
 		continue;
 walk_abort:
-- 
2.49.0


