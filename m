Return-Path: <stable+bounces-116365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E3A35723
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 07:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E143AD5C6
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC882045AC;
	Fri, 14 Feb 2025 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZYZTJieX"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60B153803;
	Fri, 14 Feb 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514776; cv=none; b=qncZYZGaf2Bk3ty0HEDmy9+eG3VqIxL8L2LzxLiCEkAI1ks0ixK0RM2gQXfPW95muTqt1l1pkptPJ2xY1VgY8GTwn7QZCHVfLEO/8CMhq0Id//EzijRct4ZbJAgNfKtgfK82jmCtSpJkQxHdruTtzB3kP23Tf1zIZjSEYF1PAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514776; c=relaxed/simple;
	bh=hyvDeMOuihb0txnXJaqThDD8Not1D1+IXKBX+xiJxo0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oPwyBm7PnfgTkwDuI/fQ78MApw9dfhpyfrn+fXeVLXXaZlVRCZh/09hX/GywWDa2YtCkbUGPS6RSUh88/Xdec2aOePGf28Ix1ts4gI6WFw9qfJzlBTavVrmC+dAbi44vE2U2GPv1nim3jcjE5xDra+cwR+N0M7myYOvdApMJZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZYZTJieX; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=t5/NFgvwirXTPslamx
	of568wydxGxcgJ439GsLJwwTY=; b=ZYZTJieXJhxWhh8S3SfQ0Mnp4T0+i4C7zb
	qSh25YigieruRXhhNC/0NPCKX9PNOgvUb0SeWLxQ3l9a51QRN/m47QSGR0P2MkiI
	fANlyCh5VHq9HFsjJupK9wgVlmFiQ+CDxq86s+XUaFvJmkJ2K28zJmHqrRWlhbjY
	y0Vxt6AlE=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnr2Jr465nOc+UAw--.56792S2;
	Fri, 14 Feb 2025 14:32:12 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH] mm/hugetlb: wait for hugepage folios to be freed
Date: Fri, 14 Feb 2025 14:32:09 +0800
Message-Id: <1739514729-21265-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:PykvCgDnr2Jr465nOc+UAw--.56792S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryrCFy8Xr45tw4UKr1UAwb_yoWrKFWrpF
	yUKwnrGrWDJrZakr17Xws5Zr1ay395ZFW2kFWIqw43Z3ZxJw1DKFy2vw1qq3y5ArZ7CFWx
	ZrWjv3yDuF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifhnzG2eu3KhoTQAAsX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Ge Yang <yangge1116@126.com>

Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer freeing
of HugeTLB pages"), which supports deferring the freeing of HugeTLB pages,
the allocation of contiguous memory through cma_alloc() may fail
probabilistically.

In the CMA allocation process, if it is found that the CMA area is occupied
by in-use hugepage folios, these in-use hugepage folios need to be migrated
to another location. When there are no available hugepage folios in the
free HugeTLB pool during the migration of in-use HugeTLB pages, new folios
are allocated from the buddy system. A temporary state is set on the newly
allocated folio. Upon completion of the hugepage folio migration, the
temporary state is transferred from the new folios to the old folios.
Normally, when the old folios with the temporary state are freed, it is
directly released back to the buddy system. However, due to the deferred
freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
to the failure of cma_alloc().

Here is a simplified call trace illustrating the process:
cma_alloc()
    ->__alloc_contig_migrate_range() // Migrate in-use hugepage
        ->unmap_and_move_huge_page()
            ->folio_putback_hugetlb() // Free old folios
    ->test_pages_isolated()
        ->__test_page_isolated_in_pageblock()
             ->PageBuddy(page) // Check if the page is in buddy

To resolve this issue, we have implemented a function named
wait_for_hugepage_folios_freed(). This function ensures that the hugepage
folios are properly released back to the buddy system after their migration
is completed. By invoking wait_for_hugepage_folios_freed() following the
migration process, we guarantee that when test_pages_isolated() is
executed, it will successfully pass.

Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")
Signed-off-by: Ge Yang <yangge1116@126.com>
---
 include/linux/hugetlb.h |  5 +++++
 mm/hugetlb.c            |  7 +++++++
 mm/migrate.c            | 16 ++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6c6546b..c39e0d5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
+void wait_for_hugepage_folios_freed(struct hstate *h);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1092,6 +1093,10 @@ static inline int replace_free_hugepage_folios(unsigned long start_pfn,
 	return 0;
 }
 
+static inline void wait_for_hugepage_folios_freed(struct hstate *h)
+{
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 30bc34d..64cae39 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2955,6 +2955,13 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 	return ret;
 }
 
+void wait_for_hugepage_folios_freed(struct hstate *h)
+{
+	WARN_ON(!h);
+
+	flush_free_hpage_work(h);
+}
+
 typedef enum {
 	/*
 	 * For either 0/1: we checked the per-vma resv map, and one resv
diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18..5dd1851 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1448,6 +1448,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	unsigned long size;
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
@@ -1533,9 +1534,20 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 out_unlock:
 	folio_unlock(src);
 out:
-	if (rc == MIGRATEPAGE_SUCCESS)
+	if (rc == MIGRATEPAGE_SUCCESS) {
+		size = folio_size(src);
 		folio_putback_hugetlb(src);
-	else if (rc != -EAGAIN)
+
+		/*
+		 * Due to the deferred freeing of HugeTLB folios, the hugepage 'src' may
+		 * not immediately release to the buddy system. This can lead to failure
+		 * in allocating memory through the cma_alloc() function. To ensure that
+		 * the hugepage folios are properly released back to the buddy system,
+		 * we invoke the wait_for_hugepage_folios_freed() function to wait for
+		 * the release to complete.
+		 */
+		wait_for_hugepage_folios_freed(size_to_hstate(size));
+	} else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 
 	/*
-- 
2.7.4


