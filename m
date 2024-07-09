Return-Path: <stable+bounces-58258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE692ABF4
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 00:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE451C2205E
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 22:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A04715279C;
	Mon,  8 Jul 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LrYjC8ST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974B152786;
	Mon,  8 Jul 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477004; cv=none; b=fmeTTf0BTvjS4fQbegqQPoaxLMCPWHlXO4tYn81trq6j9Kgj9tzqD0ayIrKyzL1HbCWTOg2EJdgo/kQLZSe/myWQt5vhVWh3OC9Vh+S8BoCw1YODjG3R+YPCyR7bqS6Q3GgUGnguiDfTWJiGqYtfLq4GtaCz0L2bsuDi07+xZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477004; c=relaxed/simple;
	bh=Hw7x3tk4lNvNspTn2B7PC09m4IG+BoSPEZOIHjpJq2E=;
	h=Date:To:From:Subject:Message-Id; b=HARjL63lkIDCr5uXIcjY2or0+PqZdzZB4nh4CB5tNEWLyHr05KoCFJT751WRwVB5yyxorBqhA9cK7TMfN1Py9lZrRmAtjgr8ecSNTH7zwpElEsKOx/rhgOEd/pAzPu/ao7CoZNSyfYhF0RHNdUVPvxf0JYpDjTOpf/xsuMXr/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LrYjC8ST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6344C4AF0E;
	Mon,  8 Jul 2024 22:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720477003;
	bh=Hw7x3tk4lNvNspTn2B7PC09m4IG+BoSPEZOIHjpJq2E=;
	h=Date:To:From:Subject:From;
	b=LrYjC8STXwH1AJjCo2pRj8tQIiQ/asiTYbuuFJr9UAe7J3yNk6aQcNsenapG73Qd8
	 prtDNJoD8ATY8kwLa7bunLgYegxsWJzGc+8dRkIUnTDrAu/OylH1nLgDPy8R5pGYi5
	 Y2wR3iJbIC/DOHlDgGoVQuoOoQCxjDzCMAKAgTME=
Date: Mon, 08 Jul 2024 15:16:42 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,mgorman@techsingularity.net,hannes@cmpxchg.org,bharata@amd.com,yuzhao@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-truncate-batch-clear-shadow-entries.patch added to mm-unstable branch
Message-Id: <20240708221643.A6344C4AF0E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/truncate: batch-clear shadow entries
has been added to the -mm mm-unstable branch.  Its filename is
     mm-truncate-batch-clear-shadow-entries.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-truncate-batch-clear-shadow-entries.patch

This patch will later appear in the mm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Yu Zhao <yuzhao@google.com>
Subject: mm/truncate: batch-clear shadow entries
Date: Mon, 8 Jul 2024 15:27:53 -0600

Make clear_shadow_entry() clear shadow entries in `struct folio_batch` so
that it can reduce contention on i_lock and i_pages locks, e.g.,

  watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
    clear_shadow_entry+0x3d/0x100
    mapping_try_invalidate+0x117/0x1d0
    invalidate_mapping_pages+0x10/0x20
    invalidate_bdev+0x3c/0x50
    blkdev_common_ioctl+0x5f7/0xa90
    blkdev_ioctl+0x109/0x270

Link: https://lkml.kernel.org/r/20240708212753.3120511-1-yuzhao@google.com
Reported-by: Bharata B Rao <bharata@amd.com>
Closes: https://lore.kernel.org/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/truncate.c |   67 +++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

--- a/mm/truncate.c~mm-truncate-batch-clear-shadow-entries
+++ a/mm/truncate.c
@@ -39,12 +39,24 @@ static inline void __clear_shadow_entry(
 	xas_store(&xas, NULL);
 }
 
-static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
-			       void *entry)
+static void clear_shadow_entry(struct address_space *mapping,
+			       struct folio_batch *fbatch, pgoff_t *indices)
 {
+	int i;
+
+	if (shmem_mapping(mapping) || dax_mapping(mapping))
+		return;
+
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
-	__clear_shadow_entry(mapping, index, entry);
+
+	for (i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+
+		if (xa_is_value(folio))
+			__clear_shadow_entry(mapping, indices[i], folio);
+	}
+
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
@@ -105,36 +117,6 @@ static void truncate_folio_batch_excepti
 	fbatch->nr = j;
 }
 
-/*
- * Invalidate exceptional entry if easily possible. This handles exceptional
- * entries for invalidate_inode_pages().
- */
-static int invalidate_exceptional_entry(struct address_space *mapping,
-					pgoff_t index, void *entry)
-{
-	/* Handled by shmem itself, or for DAX we do nothing. */
-	if (shmem_mapping(mapping) || dax_mapping(mapping))
-		return 1;
-	clear_shadow_entry(mapping, index, entry);
-	return 1;
-}
-
-/*
- * Invalidate exceptional entry if clean. This handles exceptional entries for
- * invalidate_inode_pages2() so for DAX it evicts only clean entries.
- */
-static int invalidate_exceptional_entry2(struct address_space *mapping,
-					 pgoff_t index, void *entry)
-{
-	/* Handled by shmem itself */
-	if (shmem_mapping(mapping))
-		return 1;
-	if (dax_mapping(mapping))
-		return dax_invalidate_mapping_entry_sync(mapping, index);
-	clear_shadow_entry(mapping, index, entry);
-	return 1;
-}
-
 /**
  * folio_invalidate - Invalidate part or all of a folio.
  * @folio: The folio which is affected.
@@ -494,6 +476,7 @@ unsigned long mapping_try_invalidate(str
 	unsigned long ret;
 	unsigned long count = 0;
 	int i;
+	bool xa_has_values = false;
 
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
@@ -503,8 +486,8 @@ unsigned long mapping_try_invalidate(str
 			/* We rely upon deletion not changing folio->index */
 
 			if (xa_is_value(folio)) {
-				count += invalidate_exceptional_entry(mapping,
-							     indices[i], folio);
+				xa_has_values = true;
+				count++;
 				continue;
 			}
 
@@ -522,6 +505,10 @@ unsigned long mapping_try_invalidate(str
 			}
 			count += ret;
 		}
+
+		if (xa_has_values)
+			clear_shadow_entry(mapping, &fbatch, indices);
+
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -616,6 +603,7 @@ int invalidate_inode_pages2_range(struct
 	int ret = 0;
 	int ret2 = 0;
 	int did_range_unmap = 0;
+	bool xa_has_values = false;
 
 	if (mapping_empty(mapping))
 		return 0;
@@ -629,8 +617,9 @@ int invalidate_inode_pages2_range(struct
 			/* We rely upon deletion not changing folio->index */
 
 			if (xa_is_value(folio)) {
-				if (!invalidate_exceptional_entry2(mapping,
-						indices[i], folio))
+				xa_has_values = true;
+				if (dax_mapping(mapping) &&
+				    !dax_invalidate_mapping_entry_sync(mapping, indices[i]))
 					ret = -EBUSY;
 				continue;
 			}
@@ -666,6 +655,10 @@ int invalidate_inode_pages2_range(struct
 				ret = ret2;
 			folio_unlock(folio);
 		}
+
+		if (xa_has_values)
+			clear_shadow_entry(mapping, &fbatch, indices);
+
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
_

Patches currently in -mm which might be from yuzhao@google.com are

mm-truncate-batch-clear-shadow-entries.patch


