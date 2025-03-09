Return-Path: <stable+bounces-121600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70BA58701
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DDF3AB5E8
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2A20C01A;
	Sun,  9 Mar 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hA9lMdAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C96207A10
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544173; cv=none; b=FP35Vdfx+B1afhsm+5oK0KWChfFe4sb3gtf3L1k3HLei40cgNGd2t6xj29lhMfTNKeT3teZoh9WIYMb/q0mx414t47Um+DlvteRKrZJslWo0UYTTmo6LKgIwlQhyIkvnHjVoW/qqXrAL4NJNUwsp4uijszpjVgPU9t4T2f78Kao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544173; c=relaxed/simple;
	bh=dAb3qGE/wQwdmGabM4Ps+a6gDncMg7aLTOn7Q2SFiGM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dPelKORmk93GzoLglIG449fuKnikT6gb3Hj9L16+frzLJTiSX9Z8c68CpsCLyd0wXG+mZigH7oeAI4h2hqlilctPKOO+9vK4Qxv11Zu+iuYk90ZH8U0KkqwfgS6Rt/Hh14/kOyjvK3dycbbfLddTltMUeKYEl7pCbY/i3qKhcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hA9lMdAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31832C4CEF0;
	Sun,  9 Mar 2025 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741544173;
	bh=dAb3qGE/wQwdmGabM4Ps+a6gDncMg7aLTOn7Q2SFiGM=;
	h=Subject:To:Cc:From:Date:From;
	b=hA9lMdAsPhSbaYRsIXJ/U/huOKJ3c6fI4Jd2dc6xC23Xf7ldQ6e6pgEZg/pnFlgQh
	 RgHJZfg3SM7OUhFV5oWVe8CGrSk+Fg81xqWqTXT+ZsTvSYfDSq3rt0TnyqETPGY3qU
	 BeFhV5PVDRM6RjUJ/j7SVEtmS34TuDZszMK0lnq0=
Subject: FAILED: patch "[PATCH] mm/hugetlb: wait for hugetlb folios to be freed" failed to apply to 6.6-stable tree
To: yangge1116@126.com,21cnbao@gmail.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 19:16:04 +0100
Message-ID: <2025030904-splendor-sly-a852@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 67bab13307c83fb742c2556b06cdc39dbad27f07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030904-splendor-sly-a852@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67bab13307c83fb742c2556b06cdc39dbad27f07 Mon Sep 17 00:00:00 2001
From: Ge Yang <yangge1116@126.com>
Date: Wed, 19 Feb 2025 11:46:44 +0800
Subject: [PATCH] mm/hugetlb: wait for hugetlb folios to be freed

Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing
of huge pages if in non-task context"), which supports deferring the
freeing of hugetlb pages, the allocation of contiguous memory through
cma_alloc() may fail probabilistically.

In the CMA allocation process, if it is found that the CMA area is
occupied by in-use hugetlb folios, these in-use hugetlb folios need to be
migrated to another location.  When there are no available hugetlb folios
in the free hugetlb pool during the migration of in-use hugetlb folios,
new folios are allocated from the buddy system.  A temporary state is set
on the newly allocated folio.  Upon completion of the hugetlb folio
migration, the temporary state is transferred from the new folios to the
old folios.  Normally, when the old folios with the temporary state are
freed, it is directly released back to the buddy system.  However, due to
the deferred freeing of hugetlb pages, the PageBuddy() check fails,
ultimately leading to the failure of cma_alloc().

Here is a simplified call trace illustrating the process:
cma_alloc()
    ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
        ->unmap_and_move_huge_page()
            ->folio_putback_hugetlb() // Free old folios
    ->test_pages_isolated()
        ->__test_page_isolated_in_pageblock()
             ->PageBuddy(page) // Check if the page is in buddy

To resolve this issue, we have implemented a function named
wait_for_freed_hugetlb_folios().  This function ensures that the hugetlb
folios are properly released back to the buddy system after their
migration is completed.  By invoking wait_for_freed_hugetlb_folios()
before calling PageBuddy(), we ensure that PageBuddy() will succeed.

Link: https://lkml.kernel.org/r/1739936804-18199-1-git-send-email-yangge1116@126.com
Fixes: c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in non-task context")
Signed-off-by: Ge Yang <yangge1116@126.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ec8c0ccc8f95..dbe76d4f1bfc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -682,6 +682,7 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
+void wait_for_freed_hugetlb_folios(void);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1066,6 +1067,10 @@ static inline int replace_free_hugepage_folios(unsigned long start_pfn,
 	return 0;
 }
 
+static inline void wait_for_freed_hugetlb_folios(void)
+{
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 163190e89ea1..811b29f77abf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2943,6 +2943,14 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 	return ret;
 }
 
+void wait_for_freed_hugetlb_folios(void)
+{
+	if (llist_empty(&hpage_freelist))
+		return;
+
+	flush_work(&free_hpage_work);
+}
+
 typedef enum {
 	/*
 	 * For either 0/1: we checked the per-vma resv map, and one resv
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c608e9d72865..a051a29e95ad 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -607,6 +607,16 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	struct zone *zone;
 	int ret;
 
+	/*
+	 * Due to the deferred freeing of hugetlb folios, the hugepage folios may
+	 * not immediately release to the buddy system. This can cause PageBuddy()
+	 * to fail in __test_page_isolated_in_pageblock(). To ensure that the
+	 * hugetlb folios are properly released back to the buddy system, we
+	 * invoke the wait_for_freed_hugetlb_folios() function to wait for the
+	 * release to complete.
+	 */
+	wait_for_freed_hugetlb_folios();
+
 	/*
 	 * Note: pageblock_nr_pages != MAX_PAGE_ORDER. Then, chunks of free
 	 * pages are not aligned to pageblock_nr_pages.


