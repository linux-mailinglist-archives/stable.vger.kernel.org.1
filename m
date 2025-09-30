Return-Path: <stable+bounces-182041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D43FBABC5C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077893B24C2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819F29AAEA;
	Tue, 30 Sep 2025 07:13:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E2277C81
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216393; cv=none; b=Cq8usurnMMScmOn4Qce/ZG05Ik/O8kTk9YOMgVzumcIIFgzDH3zTyDjoy4Q8xuYRkm/4jWSBGjyTwdc0r5MX9oHMuS5G6CifEF+a1uQ+hZY7ITjEDxtBAZCd3yls4GFN8aBTn05t40ZwedYIEnJzzxr5wledygrhjfpUrDkZBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216393; c=relaxed/simple;
	bh=jZLUYO9y0S453l34VftfAEuNf7vhvQMizNgY3IHOQ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwYWTiuwMVszY6ygTj8/e9l444qE7UoMSex62hv9kS96VrPwwzycY30oEtpWBf1PCKQ8c8P7h/JKhDAjPu5Qyojm99Am8RzHGF0OK4a4yzomfTWnVTD5R8vWdyZgvVnlnLYBZeTjUXJSYyGCJa+bFjUzBGRFQCnOet9B96TjmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso31071805e9.2
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 00:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216390; x=1759821190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJg+MB8jkyhooYHl7VPWRbhLVwCzgwHPNjrxfT41vz8=;
        b=KQA0oSz0oZNsgdDpnDLpFeQkcV+dLEvt9oRG5qbUBLc18g9OOjlaMhyS9bWXEKf2aR
         GLZ76qGb68jPUtaANV5zb5mMr7wDqcqYxYDVl7JYyVuyHo7b+pseRuypvHihi1hFeAJs
         WRAJTGLI8+94mftpIqLtLkOnHxVy4oikVrFDH8cAPN2ID0whp+4E2b/Eppz7tphGRqyT
         jDUhj0RCUhYEaJvSPbhYOip+X2ompWtKjAsvU6dFwbztM8Qu8cwD4DUPWq2HUyjHw3jY
         QCPrazkXPN4A7uQHICrYzla+p81bUT3FVfd8U86RB8K57wr/qeJh/hFxX8bTjHZMGJTf
         Z1iw==
X-Forwarded-Encrypted: i=1; AJvYcCV7zfjrbgLJdI6zt24/VDlhq9lXn2jvQeScs/a1Bc8PyefVW8i7ZSBPPrOiQlpS6WLnPFY0Pd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Aau2bmg4LUT9iRIysf+HZlJENYr1fvWQmIqTCc3XtycRmuli
	5DP1J6ZdHIKnHoyRMesdE3GFo/274bbz6BrI4DM2JTdxApum6VVt+vD8
X-Gm-Gg: ASbGnct+y6XojR49/IpORIs0mayFAJFEAqAwQ8x2Rwexg7GDTaQmvTHlZPtTplbuinA
	sS3xqUBLrrRFDKqbmS0S40ZqF0oyTzNWSRNlysuOUsxJuAPBpM0zdlJBa824t3/fIL1YqXvYNQR
	a+Z/z1s5xqTTOBeyJQteDadIqMtNuOx+/E8awo2pxRrhEB332S5R1yF7rhPGUc8DzYo2INTsGj4
	2eLvkZPFpI0v7LKxfgdQHq3xVwZWbfTyfxfXxygnYE+Eo60uxkNo2m88XnJvaCYaSVXrmElDBkW
	aINoTikJiUlabFOZnAD8uk9nYcJ5PFdLomYOWYHal81gc3+QKJ5iUV5w021Y52OCgcO25D3YmPi
	iVtiCT20eJES1nOgzr1cr0yxDW4i2epdw0bbfIOWSnE6q7uvp/A==
X-Google-Smtp-Source: AGHT+IHG/vdhpkUdLGzDD/hQegsFD5o72BWBQNk08ly8bjkRBa9wOlUTaVnXFyckUgCALWtyUUhxsA==
X-Received: by 2002:a05:600c:8b58:b0:45d:e326:96fb with SMTP id 5b1f17b1804b1-46e32a17d2bmr190697065e9.30.1759216389605;
        Tue, 30 Sep 2025 00:13:09 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f64d06sm42221855e9.12.2025.09.30.00.13.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Sep 2025 00:13:09 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: peterx@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	npache@redhat.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	usamaarif642@gmail.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v4 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 15:10:53 +0800
Message-ID: <20250930071053.36158-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops several important
PTE bits.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing the soft-dirty bit means modified pages are
missed, leading to inconsistent memory state after restore.

As pointed out by David, the more critical uffd-wp bit is also dropped.
This breaks the userfaultfd write-protection mechanism, causing writes
to be silently missed by monitoring applications, which can lead to data
corruption.

Preserve both the soft-dirty and uffd-wp bits from the old PTE when
creating the new zeropage mapping to ensure they are correctly tracked.

Cc: <stable@vger.kernel.org>
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v3 -> v4:
 - Minor formatting tweak in try_to_map_unused_to_zeropage() function
   signature (per David and Dev)
 - Collect Reviewed-by from Dev - thanks!
 - https://lore.kernel.org/linux-mm/20250930060557.85133-1-lance.yang@linux.dev/

v2 -> v3:
 - ptep_get() gets called only once per iteration (per Dev)
 - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/

v1 -> v2:
 - Avoid calling ptep_get() multiple times (per Dev)
 - Double-check the uffd-wp bit (per David)
 - Collect Acked-by from David - thanks!
 - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/

 mm/migrate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..21a2a1bf89f7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -296,8 +296,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 }
 
 static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
-					  struct folio *folio,
-					  unsigned long idx)
+		struct folio *folio, pte_t old_pte, unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
 	pte_t newpte;
@@ -306,7 +305,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +321,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
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
@@ -344,7 +349,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
-		pte_t old_pte;
+		pte_t old_pte = ptep_get(pvmw.pte);
 		pte_t pte;
 		swp_entry_t entry;
 		struct page *new;
@@ -365,12 +370,11 @@ static bool remove_migration_pte(struct folio *folio,
 		}
 #endif
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


