Return-Path: <stable+bounces-121601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B4A58704
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBECC169B4F
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C91140E5F;
	Sun,  9 Mar 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaDvl2qS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF21F8728
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544179; cv=none; b=CSeKCVa5+SZm8voyydKJnpQGsmBOiHvHBBt/n35kk5EljIIxPbnOmjk0QwyharGDA6cnViFfqjfT1sE50lszHXrnHtz9umukKEAwa0hiHD0aWZr+A9h3S43I+GHPRi9/QIMc3p8m8PyTgtvEmwSNJ6i5BMjPOpP7AQnFyLP9nHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544179; c=relaxed/simple;
	bh=ryVIJAJKnkHtYqvjdQ6tYGPzWZItzlhM2krq75VBGm4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iV6lkra+U+ap2osfB/FWuAfeDUTotOji9BKQrJWh9EwFwZ7dAFQPkoBzuSPDlgg/PZWAMm5FxhVAnRTEj2W0ZEsL8jEEY4biwcxT9lI9TusKyLI12AA6J4KZu5rlpNU8DYPhI/WC8yTuprsBzbnJn1kytQZP1rvk9PtQPEa34BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LaDvl2qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD6C4CEED;
	Sun,  9 Mar 2025 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741544176;
	bh=ryVIJAJKnkHtYqvjdQ6tYGPzWZItzlhM2krq75VBGm4=;
	h=Subject:To:Cc:From:Date:From;
	b=LaDvl2qS1Z0KpOqVk4k6MS5MGlDewgqkLnlXZDzSlPNpZSH7Es31mFbbp9Y/ngNVb
	 nu4ZmCjW1ddXg+DPGOQr+Rtt5D+dqqo2mo33FqG54Xymqzov30ZkzmZyrUjqxL3wxv
	 hfCBqs9VC0Xo7jCJEqrPukquANrTlm9kbRhAJ8I8=
Subject: FAILED: patch "[PATCH] mm/hugetlb: wait for hugetlb folios to be freed" failed to apply to 6.1-stable tree
To: yangge1116@126.com,21cnbao@gmail.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 19:16:05 +0100
Message-ID: <2025030905-parchment-riddance-0a09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 67bab13307c83fb742c2556b06cdc39dbad27f07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030905-parchment-riddance-0a09@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


