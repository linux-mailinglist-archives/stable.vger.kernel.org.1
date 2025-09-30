Return-Path: <stable+bounces-182050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942ABABF7C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 10:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9657A595C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BB2F363E;
	Tue, 30 Sep 2025 08:12:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E927A114
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219978; cv=none; b=WI8MK/fdn+4f9INApppKIFzwWaK4KDxaqsmLwRWruTvywlCpF9nAg81sR4DoujeKroIlmQA+46fPhHo5w/D+C2PVT/r+zLeyyI+4LolYZVTfKe8J3SOL8PBCBQivG6co8NQJgixk4OSB6k1ezpiOELbqUCgJIS5K2mmNFT1eHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219978; c=relaxed/simple;
	bh=W6oDfQ3tA6Pme1gatYJbw8/yR7JHBTFPfjYXtL5BQIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbI/9GWKzV2OGTOUmb/jxs9PsJARLREPzzFfgORTgbGu4+l90Y/sOPL1cQ4tR674haBL198uuTfPDExdXVx+veMH3zp+etjGlwbUb91g2aWLV/9oaEK0rMBUDdxG8gHRePxKjb2tfSRS7Nnu5FM+f8ciHRgoTxyWfnxlA7xBigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so32026395e9.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 01:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759219974; x=1759824774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAJ15PCYe/3t3twFi4VSUK9WUI+ae4tv6+Eg5/cOO8M=;
        b=XmY92V5vGXMAd6mxrwDelhGaEIjRcyojm6Bf3hseaXDHWt+AgCfrYW6Fmqu4E/lZOB
         Bxj/bqaNpqSX2lXJpj0uH7znVT43LNXl5+7R+3Mk1a99C4cw1IiADGDYr0N1SUgosx5O
         iOv7wS9xO1ItEjSnTcT1+9nQDYy4GLT3jt3F0vNhrpihOhNuB+l+TKnbWr/qiQWBRlme
         W9xIJcMadhauod3peXFsD3o1NPYjJIt5udrFFnxGeolU50PxO39Htuhk/6rAW6d/AvPB
         Ihk0JFj4qqebDw1dulpIn8kO2+snC98k3nVx9yXIEnM/O476aInjlqSwGSpWtyGf16ii
         WuCw==
X-Forwarded-Encrypted: i=1; AJvYcCXpxvhEfm2sG8Jnulx075y4IbGqzE84wPlKXNxTnIa2NKfEDFjjMxUdYLnfTEqd2pMScB8Jgko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5zPcQGrE/lYj70WHmkE/yFg3Icz5wo7qEORUIs5VKA2LO7SJ
	5daa0I4mLv892H452nAAvd7HvKwi134tHKNhnRLkPGkwBFa1tS1s3erM
X-Gm-Gg: ASbGncsKueXFlSswosZgwsC8Fk8ZVS3fyH13QBxDzhO44wOMgN4gsXbVSkMVBP7vbvw
	WUCpFeKaOgHrmGw2pURLA9etdhLI39Vps9FxGXmz4o3wD0OnBcUr6xcFLB7sRaTMKZxs+zZT3kP
	nQCCCogliLiBr4PvtiDZ9/NkayeyTTz73XBXSUQGW5fjoBAN20Y6XDqpkBOnQULbh5+H/B34hrV
	plEovtRTdMECNzvf0haaxU4Eo+cHR6l34ZNB76TfJcskbvxpAa+jzk2HHY/5pY4owjcMbQkk06I
	/DccgqMJIkzb0pSiLVGF8roEpc+Y+olPd57RPmrPyy7VpJmjfKhMAm9YBb8LJuZdCdM/+ZBXwJo
	sR1bDQNDct1TCwkUtyXPRi4iywmAM7sz1yOmPFJk=
X-Google-Smtp-Source: AGHT+IE2NS+/omW5KgBKG9n82/mtd7IUS3Rs9tnSrN83FJMEVfCJNhTiuTT9MEUw76ccVMhV+on3xQ==
X-Received: by 2002:a05:600c:1c88:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-46e329c5735mr275530785e9.16.1759219974301;
        Tue, 30 Sep 2025 01:12:54 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f62sm258959085e9.15.2025.09.30.01.12.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Sep 2025 01:12:53 -0700 (PDT)
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
Subject: [PATCH v5 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 16:10:40 +0800
Message-ID: <20250930081040.80926-1-lance.yang@linux.dev>
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
v4 -> v5:
 - Move ptep_get() call after the !pvmw.pte check, which handles PMD-mapped
   THP migration entries.
 - https://lore.kernel.org/linux-mm/20250930071053.36158-1-lance.yang@linux.dev/
 
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

 mm/migrate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..e3065c9edb55 100644
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
@@ -364,13 +369,13 @@ static bool remove_migration_pte(struct folio *folio,
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


