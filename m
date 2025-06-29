Return-Path: <stable+bounces-158843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D949AECC9E
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D921890F53
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF91E521D;
	Sun, 29 Jun 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UWDSQhHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7FEEA9
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201145; cv=none; b=B6Nq6IvsmKVkZuvSD9hgbZ1khykdPzuKqsJd1C3poCO6mraZeeOtXorDLFrZgJng50/hjkHpaa5YTShoG1PGtcsF34CeoKTkYK+qyM7GC9Pu869hXzzhg1ugbytW1fe71j/sSTP8370TaKlXxhpTTNPc+fnAm8FpxG5RxZpSFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201145; c=relaxed/simple;
	bh=U7iEsyK/zUimR4khgIE93lDITtHyn8ddM9a25G/J8Mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WZSdsWgMtgPMJ0UecqfCx8Z1/GT7ahnktKHCiX1lIh3Hz/E6tnjynF4pywrZu8lpwb1a4BNozJBG8ay4S2vUa7lQ8JHnsrtE2ZzwI3r2C7GIBLhZamtCzgV8nQZ2P/4gQBrRzt7PUGPvZqi9UCGlKf64JCtjgcDGc/sKhu5puqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UWDSQhHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E537BC4CEEB;
	Sun, 29 Jun 2025 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201145;
	bh=U7iEsyK/zUimR4khgIE93lDITtHyn8ddM9a25G/J8Mc=;
	h=Subject:To:Cc:From:Date:From;
	b=UWDSQhHZ+/RCDO+gAgT6vjOYoLhwAMqB0rkIEquz3YaFmUzHG+d7NTiYzJ5cyEaNW
	 eLF+l5pgMu2YUfdvcHNxq1bjLRHMf6vcZ1uOVFETWGPEUvsU7xnuIHmp6xYbjzICPl
	 IT12ZNb3aK7h3+8Rtqc8Ltzf1exMqOH3wtrVNOJQ=
Subject: FAILED: patch "[PATCH] mm/hugetlb: remove unnecessary holding of hugetlb_lock" failed to apply to 6.15-stable tree
To: yangge1116@126.com,21cnbao@gmail.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:42:48 +0200
Message-ID: <2025062948-cape-pebble-cad9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 344ef45b03336e7f74658814f66483b5417c9cf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062948-cape-pebble-cad9@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 344ef45b03336e7f74658814f66483b5417c9cf1 Mon Sep 17 00:00:00 2001
From: Ge Yang <yangge1116@126.com>
Date: Tue, 27 May 2025 11:36:50 +0800
Subject: [PATCH] mm/hugetlb: remove unnecessary holding of hugetlb_lock

In isolate_or_dissolve_huge_folio(), after acquiring the hugetlb_lock, it
is only for the purpose of obtaining the correct hstate, which is then
passed to alloc_and_dissolve_hugetlb_folio().

alloc_and_dissolve_hugetlb_folio() itself also acquires the hugetlb_lock.
We can have alloc_and_dissolve_hugetlb_folio() obtain the hstate by
itself, so that isolate_or_dissolve_huge_folio() no longer needs to
acquire the hugetlb_lock.  In addition, we keep the folio_test_hugetlb()
check within isolate_or_dissolve_huge_folio().  By doing so, we can avoid
disrupting the normal path by vainly holding the hugetlb_lock.

replace_free_hugepage_folios() has the same issue, and we should address
it as well.

Addresses a possible performance problem which was added by the hotfix
113ed54ad276 ("mm/hugetlb: fix kernel NULL pointer dereference when
replacing free hugetlb folios").

Link: https://lkml.kernel.org/r/1748317010-16272-1-git-send-email-yangge1116@126.com
Fixes: 113ed54ad276 ("mm/hugetlb: fix kernel NULL pointer dereference when replacing free hugetlb folios")
Signed-off-by: Ge Yang <yangge1116@126.com>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8746ed2fec13..9dc95eac558c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2787,20 +2787,24 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 /*
  * alloc_and_dissolve_hugetlb_folio - Allocate a new folio and dissolve
  * the old one
- * @h: struct hstate old page belongs to
  * @old_folio: Old folio to dissolve
  * @list: List to isolate the page in case we need to
  * Returns 0 on success, otherwise negated error.
  */
-static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
-			struct folio *old_folio, struct list_head *list)
+static int alloc_and_dissolve_hugetlb_folio(struct folio *old_folio,
+			struct list_head *list)
 {
-	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	gfp_t gfp_mask;
+	struct hstate *h;
 	int nid = folio_nid(old_folio);
 	struct folio *new_folio = NULL;
 	int ret = 0;
 
 retry:
+	/*
+	 * The old_folio might have been dissolved from under our feet, so make sure
+	 * to carefully check the state under the lock.
+	 */
 	spin_lock_irq(&hugetlb_lock);
 	if (!folio_test_hugetlb(old_folio)) {
 		/*
@@ -2829,8 +2833,10 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		cond_resched();
 		goto retry;
 	} else {
+		h = folio_hstate(old_folio);
 		if (!new_folio) {
 			spin_unlock_irq(&hugetlb_lock);
+			gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid,
 							      NULL, NULL);
 			if (!new_folio)
@@ -2874,35 +2880,24 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
 int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list)
 {
-	struct hstate *h;
 	int ret = -EBUSY;
 
-	/*
-	 * The page might have been dissolved from under our feet, so make sure
-	 * to carefully check the state under the lock.
-	 * Return success when racing as if we dissolved the page ourselves.
-	 */
-	spin_lock_irq(&hugetlb_lock);
-	if (folio_test_hugetlb(folio)) {
-		h = folio_hstate(folio);
-	} else {
-		spin_unlock_irq(&hugetlb_lock);
+	/* Not to disrupt normal path by vainly holding hugetlb_lock */
+	if (!folio_test_hugetlb(folio))
 		return 0;
-	}
-	spin_unlock_irq(&hugetlb_lock);
 
 	/*
 	 * Fence off gigantic pages as there is a cyclic dependency between
 	 * alloc_contig_range and them. Return -ENOMEM as this has the effect
 	 * of bailing out right away without further retrying.
 	 */
-	if (hstate_is_gigantic(h))
+	if (folio_order(folio) > MAX_PAGE_ORDER)
 		return -ENOMEM;
 
 	if (folio_ref_count(folio) && folio_isolate_hugetlb(folio, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
-		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
+		ret = alloc_and_dissolve_hugetlb_folio(folio, list);
 
 	return ret;
 }
@@ -2916,7 +2911,6 @@ int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list)
  */
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 {
-	struct hstate *h;
 	struct folio *folio;
 	int ret = 0;
 
@@ -2925,23 +2919,9 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 	while (start_pfn < end_pfn) {
 		folio = pfn_folio(start_pfn);
 
-		/*
-		 * The folio might have been dissolved from under our feet, so make sure
-		 * to carefully check the state under the lock.
-		 */
-		spin_lock_irq(&hugetlb_lock);
-		if (folio_test_hugetlb(folio)) {
-			h = folio_hstate(folio);
-		} else {
-			spin_unlock_irq(&hugetlb_lock);
-			start_pfn++;
-			continue;
-		}
-		spin_unlock_irq(&hugetlb_lock);
-
-		if (!folio_ref_count(folio)) {
-			ret = alloc_and_dissolve_hugetlb_folio(h, folio,
-							       &isolate_list);
+		/* Not to disrupt normal path by vainly holding hugetlb_lock */
+		if (folio_test_hugetlb(folio) && !folio_ref_count(folio)) {
+			ret = alloc_and_dissolve_hugetlb_folio(folio, &isolate_list);
 			if (ret)
 				break;
 


