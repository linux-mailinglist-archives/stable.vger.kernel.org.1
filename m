Return-Path: <stable+bounces-186261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4BBE74C6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE6E5623BB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5223BF91;
	Fri, 17 Oct 2025 08:51:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142602D3220
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691094; cv=none; b=sOf+Mzdw+qkBmm/G2+6EqPzpC0fmzgOZC42HzN21WJ2h5vCbsjs2LaIYF3kO4M+uWPPBz1tjQjAPzlr2XJrf0PRnRB+GMn2FQhrC8ajQTtcTpHg5J9g8qNxecQ03DF0Tt6CKtVMOF3ZjzfrF+kk+oWvF5B5PYeVrGzudnSmch3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691094; c=relaxed/simple;
	bh=x0ANs7TTnv4RJZFb7FFAd7nTMDHb0Oxx9yGqmnxwVto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdUL3AtifYOjH8Mx37W4NnkUG90RvDtINSMGruvIXflHiSVCtCyfwYuwNSrmfcdv/e9ByM6+TCs8Zo9eCqIo6g/wOQkGMj7XWsseNTxNqYVnQei0Wc2H44Gl34sM3cUDijifGMdFL5Y9RBjx1/j78hMQ0K2WkpVF1F7w8pxvgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711f156326so2884575e9.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 01:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691089; x=1761295889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4VzTJGwFWfbLsxw+5xqIYuZUN7cDkULCnpZc07/OhM=;
        b=md/20aIOIAU7BGKpS1aacsPPkqzkhxeVYHXgNr/VRo21oMcvQSAK76RZCBXV1yUb4j
         mf8dBURJBpZ2z65jzipoiiTEkNWRYQXKlizeYVaGkU3dDh+g5BZLq3+RZ38GV9y7kuKG
         KoM+SKYBE9fCEGag5mwcM88XVrEG6ZoRfYLIqwdJ5aDmq6KKW4V0SgLmGVVq5TCblg+O
         ZWGeKYWodGhTISXD0j10CiLSw16Iy2XoQP2KFGdeM4YFjmIeEWF/FFB7I1QunKoCco4a
         v1FI3pXfyEqCVH/C0oOwtWu0xLM2ig6LMFdA5pz33WtJ8sgtHQxbJPUOic3N3Slvl9LT
         EgMg==
X-Gm-Message-State: AOJu0Ywz6cp4DBruJy7ElINkLRMtW2LRrOvCUh04Iai7APWJIH8Vn4cD
	yBy4A+DCq/abIdZsM+DiB7E2u2TprHDDAOmysuVOX5NBcVAWQIm/JEoPLThsPFFM
X-Gm-Gg: ASbGncvHN+af4DSOAqsjoMuUDXHONREOo4+rSVH6UQ8uDsD8dYGKnzyDoORXAh7KRDD
	ygSjgvIuVL+ov5JFmErm3m+Gu/R/u6f+EWqvkw+FKAJTyf1jPBBZz2wdP0MVUWpKD6y+p4/2bJe
	pzUE0VnG2/ZaLZxXB4gksKmUkgAttaez95hogB+v5nN6Te91t3QOdye0ZCizLGJ6Xxu4hZBZAIB
	zsB0FeH4CBPATWgadMFzonxuOtPAQ6/8He8fdduCCJZuzM2enNoirPmdyBjDDU6DOnQwbydaUiI
	VD38mHxe8Wrirv5pSeIlr2DOZT7yYyb69HQ4fyHSt0iuwg5sIEisW8rDa4s/II3UHKgvy8aFpv7
	GbMzRGta3ju0M35hpQdRAnWKxskwrGr2+qdmfdfFR4IE+JFbeiH2ZmWgli+KCkHqEaA==
X-Google-Smtp-Source: AGHT+IEtQYJdK32nJhSmhKG1JaCoJOb22CNUuwkNfOdw4OZKvioNrRCDXGO5fiUSFcuRhqULndiX3g==
X-Received: by 2002:a05:600c:6290:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-471177c0f91mr21229275e9.0.1760691088976;
        Fri, 17 Oct 2025 01:51:28 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144516fasm76080615e9.16.2025.10.17.01.51.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Oct 2025 01:51:28 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mariano Pache <npache@redhat.com>,
	Mathew Brost <matthew.brost@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Fri, 17 Oct 2025 16:51:06 +0800
Message-ID: <20251017085106.16330-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025101627-shortage-author-7f5b@gregkh>
References: <2025101627-shortage-author-7f5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops several
important PTE bits.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing the soft-dirty bit means modified pages are
missed, leading to inconsistent memory state after restore.

As pointed out by David, the more critical uffd-wp bit is also dropped.
This breaks the userfaultfd write-protection mechanism, causing writes to
be silently missed by monitoring applications, which can lead to data
corruption.

Preserve both the soft-dirty and uffd-wp bits from the old PTE when
creating the new zeropage mapping to ensure they are correctly tracked.

Link: https://lkml.kernel.org/r/20250930081040.80926-1-lance.yang@linux.dev
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Mathew Brost <matthew.brost@intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 9658d698a8a83540bf6a6c80d13c9a61590ee985)
---
 mm/migrate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8619aa884eaa..603330ad8e0b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -198,8 +198,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 }
 
 static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
-					  struct folio *folio,
-					  unsigned long idx)
+		struct folio *folio, pte_t old_pte, unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
 	bool contains_data;
@@ -210,7 +209,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -230,6 +229,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(old_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(old_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
@@ -272,13 +277,13 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		old_pte = ptep_get(pvmw.pte);
 		if (rmap_walk_arg->map_unused_to_zeropage &&
-		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		old_pte = ptep_get(pvmw.pte);
 
 		entry = pte_to_swp_entry(old_pte);
 		if (!is_migration_entry_young(entry))
-- 
2.49.0


