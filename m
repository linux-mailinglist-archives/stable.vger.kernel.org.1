Return-Path: <stable+bounces-182027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB294BABA27
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75BC19258C1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82821CC60;
	Tue, 30 Sep 2025 06:08:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773B211290
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212493; cv=none; b=ZGMjzdASuaD2FgfCVOgPSVGUrwxP5U+o7OZEJ9PMd0oBHosfKP9OzyMdI0ECcLOuGbT9QbEv5GC71dUnU1pTTYvqKBKkXrLIHxqQTv3WuykEOvbLE+nQTuCjrcOEe5QMC8DGzF6lp2PMuC4a+jaO3mUX9MYYUtpVH1hKBL1bboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212493; c=relaxed/simple;
	bh=P2NYa7XC6DgDhMIYYHqSv5QAg5zuqvm96XjzcfMZrYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jC6iUy346Jv2ltbCr/GAu5w/Mk0jKhxh76FVIAIU3/Uu7uOzxjrtqD/QAXV+4OLANFiIYiKOLjynFUIEKH6bv5NU4BSqjDI2B0ZrdfBka5mKtHF+k9ershBSJCQv5T/b7k760uY6/rKy92DbocJdHyjVWN/DAwQ4f0QKi9XHm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so4278855f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 23:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212489; x=1759817289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeJ1hI+H1D/hmfkjwX/xQ5MOCbl8qf09bM4saMftPHU=;
        b=NPo6SInRAYLrFDng/0WWvAs0pnJrmXtf/BGjBeYlumzC58S3G4vOGt/iQA6via7I8r
         uCziVKbbLI+FDQqT/4aN7opaQ30wAZ9BAhqvmYU0FvUnQ2FYzMxw+eiRR+oxmKcL49S2
         tcAkLL8lkZw8YTfm2CiMeB5f6iSXDQM9GV+WLnqv5hc9ETM4VgYnKgBxUMDZ3PEqdjVC
         VaJBAzPikrhK+iwReZHu2FAD4M9QXpZEKLRM+Fej0UpNPoCjXRpk24eVFd6ia6SR43AK
         cYIUVtL3dgclAluSG6ZDobHTC8A9HmGHLSgSvOuO7JNayo+IQZ4X8aS3EGwWcBEANn+p
         CDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrcSKMh1aWWk1uD9ByeXTowE+umB40/7tGVJxR/9XMxSw/73yn2xoohfdU6Lu3x6d6KC1kxIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZRHLreT4hg279vJJZRHsqjVIk1uobeg1pvU1cQyt6RKbPY+k
	UJN6gixmVUzogjlR+b7MPw9HOrc4x7K2+eqZWt7v4BOmk0eNg3RjIhJ3
X-Gm-Gg: ASbGncuU6ldpGN2FoolqlNLkA+x2Fz7+x9KdqoDDAENbbX+oAwl4sEc7rqilrPO7iSu
	AeyikDsDM++9cSieMgtjLhY2/hKj1+H+7JeETMsy7XJK5wfqAmwgPXooWKGPzyLCU0d10YlIl9g
	YvvAioHfF18TeWFFn1GQK5yBB7P61vRvueHbSgG+ZWtuff5pI+x2nTp2ZOyk6Z6vfgE9dLXOwrf
	vzdCBJ5O+c9PMlh/FRXzfWBTbS7HscHec/bJ3P1Sq4zE18pFK/nGF1jiprSWbjedm7b3YqTOC8x
	/ta2tIauPdPzSMJtyrY2zT0WwWNo+L4NnZIYAKFGH4pdoLCyWCNKqw8s3K1CdTs0u/2ZII+l/qN
	OrEmn+AkZES50+NK3PJiLKMv3btDlUl8wQZNBioI=
X-Google-Smtp-Source: AGHT+IHPnDFHgycvIIpRvpyKAjmZRopUiUot6cWIQicV70c4OwLebr3Y9E0pFRTisiPKYlM7bgtdTg==
X-Received: by 2002:a05:6000:2089:b0:3eb:2437:97c5 with SMTP id ffacd0b85a97d-40e468e7384mr17999022f8f.22.1759212489345;
        Mon, 29 Sep 2025 23:08:09 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f77956sm41935605e9.20.2025.09.29.23.08.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:08:09 -0700 (PDT)
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
Subject: [PATCH v3 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 14:05:57 +0800
Message-ID: <20250930060557.85133-1-lance.yang@linux.dev>
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
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
 - ptep_get() gets called only once per iteration (per Dev)
 - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/

v1 -> v2:
 - Avoid calling ptep_get() multiple times (per Dev)
 - Double-check the uffd-wp bit (per David)
 - Collect Acked-by from David - thanks!
 - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/

 mm/migrate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..bafd8cb3bebe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -297,6 +297,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 
 static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 					  struct folio *folio,
+					  pte_t old_pte,
 					  unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
@@ -306,7 +307,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
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
@@ -344,7 +351,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
-		pte_t old_pte;
+		pte_t old_pte = ptep_get(pvmw.pte);
 		pte_t pte;
 		swp_entry_t entry;
 		struct page *new;
@@ -365,12 +372,11 @@ static bool remove_migration_pte(struct folio *folio,
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


