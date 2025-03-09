Return-Path: <stable+bounces-121597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79384A586F5
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE593AB3DC
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70D7E105;
	Sun,  9 Mar 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNhOF3iQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0A288DB
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544166; cv=none; b=u6vykGY5TdZ0/gRx3xECZKFCZ0b7L8ryC9ybEia7f3ZKDd/GIAFtQhFmlD7wtv+VFBoUcb165nQ585L0GFcqwa2TSQO8XF/TILw6uKqOKD/zlXosyaPe0CsL3XFZNnXCdBBN8MDX8MufNoNuVAJ0LmPKJS82U3hN+W0K7XsCveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544166; c=relaxed/simple;
	bh=IvkQ7kzZutWwx+raJBG4satMqGCaT5tI2392u2uQ9ks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rWusaz0FBLWALXDhUn/VBv9VjHA2X14n352/+PCLEnMGmYLh+AjhQ0yNys+Ejpvxbo59GHxvLqavz/3tkqUFM14QLXToQxr9pouu7zGUh3bK/yh74xKX7BIN2e8exeNjNc7Y+F1T65HoAqbC9+xK/TDaqQoEUg2AaRaaDT6UQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNhOF3iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582E6C4CEE3;
	Sun,  9 Mar 2025 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741544164;
	bh=IvkQ7kzZutWwx+raJBG4satMqGCaT5tI2392u2uQ9ks=;
	h=Subject:To:Cc:From:Date:From;
	b=NNhOF3iQMFM1CMDA6NKdwcf0bmf3dssCmxRTtYwX3tNBNqfbAaZ47PCwx7L/m2Zbv
	 wTvRWfcl19FGMqyCtcYdFHNEAYefmfPjlgKnyuZw3YrpF19cgq7mS4XV01KozkXiQB
	 ikzR9UgrV5URX7PK3NrzKAsubMaSMLT04D2pcicM=
Subject: FAILED: patch "[PATCH] mm: shmem: fix potential data corruption during shmem swapin" failed to apply to 6.12-stable tree
To: baolin.wang@linux.alibaba.com,akpm@linux-foundation.org,alex_y_xu@yahoo.ca,david@redhat.com,hughd@google.com,ioworker0@gmail.com,kasong@tencent.com,ryncsn@gmail.com,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 19:15:54 +0100
Message-ID: <2025030954-polish-overeater-d2be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 058313515d5aab10d0a01dd634f92ed4a4e71d4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030954-polish-overeater-d2be@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 058313515d5aab10d0a01dd634f92ed4a4e71d4c Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Date: Tue, 25 Feb 2025 17:52:55 +0800
Subject: [PATCH] mm: shmem: fix potential data corruption during shmem swapin

Alex and Kairui reported some issues (system hang or data corruption) when
swapping out or swapping in large shmem folios.  This is especially easy
to reproduce when the tmpfs is mount with the 'huge=within_size'
parameter.  Thanks to Kairui's reproducer, the issue can be easily
replicated.

The root cause of the problem is that swap readahead may asynchronously
swap in order 0 folios into the swap cache, while the shmem mapping can
still store large swap entries.  Then an order 0 folio is inserted into
the shmem mapping without splitting the large swap entry, which overwrites
the original large swap entry, leading to data corruption.

When getting a folio from the swap cache, we should split the large swap
entry stored in the shmem mapping if the orders do not match, to fix this
issue.

Link: https://lkml.kernel.org/r/2fe47c557e74e9df5fe2437ccdc6c9115fa1bf70.1740476943.git.baolin.wang@linux.alibaba.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Reported-by: Kairui Song <ryncsn@gmail.com>
Closes: https://lore.kernel.org/all/1738717785.im3r5g2vxc.none@localhost/
Tested-by: Kairui Song <kasong@tencent.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Matthew Wilcow <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..cebbac97a221 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2253,7 +2253,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
 	swp_entry_t swap;
-	int error, nr_pages;
+	int error, nr_pages, order, split_order;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
 	swap = radix_to_swp_entry(*foliop);
@@ -2272,10 +2272,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
+	order = xa_get_order(&mapping->i_pages, index);
 	if (!folio) {
-		int order = xa_get_order(&mapping->i_pages, index);
 		bool fallback_order0 = false;
-		int split_order;
 
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
@@ -2339,6 +2338,29 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
+	} else if (order != folio_order(folio)) {
+		/*
+		 * Swap readahead may swap in order 0 folios into swapcache
+		 * asynchronously, while the shmem mapping can still stores
+		 * large swap entries. In such cases, we should split the
+		 * large swap entry to prevent possible data corruption.
+		 */
+		split_order = shmem_split_large_entry(inode, index, swap, gfp);
+		if (split_order < 0) {
+			error = split_order;
+			goto failed;
+		}
+
+		/*
+		 * If the large swap entry has already been split, it is
+		 * necessary to recalculate the new swap entry based on
+		 * the old order alignment.
+		 */
+		if (split_order > 0) {
+			pgoff_t offset = index - round_down(index, 1 << split_order);
+
+			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+		}
 	}
 
 alloced:
@@ -2346,7 +2368,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
 	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap)) {
+	    !shmem_confirm_swap(mapping, index, swap) ||
+	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
 		error = -EEXIST;
 		goto unlock;
 	}


