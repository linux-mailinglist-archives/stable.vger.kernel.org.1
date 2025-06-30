Return-Path: <stable+bounces-158906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90649AED890
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DB3189A737
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55438242D8B;
	Mon, 30 Jun 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uKf8IrZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154882405E4
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275347; cv=none; b=cm95zNECdHyskR/igqc4/uOtXMbDa3WjYL7IhdNNmdmCxqYLGk93xp+ZzuoPi+bd1j9kLcmGFA9hsANCi2Zq0v1cnCh2a0D1fTy1lWmativsVrXokOknjXf77pX8hycRL9fZzsjHuTbkAUBldpoCashJxX/l+b23TSxDQCtz5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275347; c=relaxed/simple;
	bh=tfj98FVm9np1kTtJYChG0lR10FNqh66NoHH7GG0sSFI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fHVpaJ6HxnmOez4s4QRBC8mwf5fdxNUHFenP94q2/01yWAXqQRcsjfF+m0zPqemSILxCRA/IZhibHrzJhefU9IOgJg+FC72N5zhFcSs1V+BhT8KQIHfRf+XeNKKJhGGoBZm3+ChwLWd9vpWWLJM0M4T69JIllNYppJr8aJzG6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uKf8IrZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AF5C4CEE3;
	Mon, 30 Jun 2025 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275346;
	bh=tfj98FVm9np1kTtJYChG0lR10FNqh66NoHH7GG0sSFI=;
	h=Subject:To:Cc:From:Date:From;
	b=uKf8IrZJ2M7wwEST5KzYkarkcrAymyHmo43jVL2X8wfMlMpYxWDDICujqHjip3uFT
	 LKYcQ2LaezN5xiobDAahuyTvpEvMtqoe1m/Krsk4+VTyzHVZr31/AHAvmZIetTSEYZ
	 UKCiRZgiQcjJ8jT3lZQp0LQKNgo8YJfPS2G+cKfw=
Subject: FAILED: patch "[PATCH] mm/gup: revert "mm: gup: fix infinite loop within" failed to apply to 6.1-stable tree
To: david@redhat.com,aijun.sun@unisoc.com,akpm@linux-foundation.org,apopple@nvidia.com,hyesoo.yu@samsung.com,jgg@ziepe.ca,jhubbard@nvidia.com,peterx@redhat.com,stable@vger.kernel.org,zhaoyang.huang@unisoc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:22:15 +0200
Message-ID: <2025063015-rumor-coconut-92be@gregkh>
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
git cherry-pick -x 517f496e1e61bd169d585dab4dd77e7147506322
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063015-rumor-coconut-92be@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 517f496e1e61bd169d585dab4dd77e7147506322 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 11 Jun 2025 15:13:14 +0200
Subject: [PATCH] mm/gup: revert "mm: gup: fix infinite loop within
 __get_longterm_locked"

After commit 1aaf8c122918 ("mm: gup: fix infinite loop within
__get_longterm_locked") we are able to longterm pin folios that are not
supposed to get longterm pinned, simply because they temporarily have the
LRU flag cleared (esp.  temporarily isolated).

For example, two __get_longterm_locked() callers can race, or
__get_longterm_locked() can race with anything else that temporarily
isolates folios.

The introducing commit mentions the use case of a driver that uses
vm_ops->fault to insert pages allocated through cma_alloc() into the page
tables, assuming they can later get longterm pinned.  These pages/ folios
would never have the LRU flag set and consequently cannot get isolated.
There is no known in-tree user making use of that so far, fortunately.

To handle that in the future -- and avoid retrying forever to
isolate/migrate them -- we will need a different mechanism for the CMA
area *owner* to indicate that it actually already allocated the page and
is fine with longterm pinning it.  The LRU flag is not suitable for that.

Probably we can lookup the relevant CMA area and query the bitmap; we only
have have to care about some races, probably.  If already allocated, we
could just allow longterm pinning)

Anyhow, let's fix the "must not be longterm pinned" problem first by
reverting the original commit.

Link: https://lkml.kernel.org/r/20250611131314.594529-1-david@redhat.com
Fixes: 1aaf8c122918 ("mm: gup: fix infinite loop within __get_longterm_locked")
Signed-off-by: David Hildenbrand <david@redhat.com>
Closes: https://lore.kernel.org/all/20250522092755.GA3277597@tiffany/
Reported-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Cc: Aijun Sun <aijun.sun@unisoc.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup.c b/mm/gup.c
index e065a49842a8..3c39cbbeebef 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2303,13 +2303,13 @@ static void pofs_unpin(struct pages_or_folios *pofs)
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
-static void collect_longterm_unpinnable_folios(
+static unsigned long collect_longterm_unpinnable_folios(
 		struct list_head *movable_folio_list,
 		struct pages_or_folios *pofs)
 {
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
-	unsigned long i;
 
 	for (i = 0; i < pofs->nr_entries; i++) {
 		struct folio *folio = pofs_get_folio(pofs, i);
@@ -2321,6 +2321,8 @@ static void collect_longterm_unpinnable_folios(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
+		collected++;
+
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -2342,6 +2344,8 @@ static void collect_longterm_unpinnable_folios(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
+
+	return collected;
 }
 
 /*
@@ -2418,9 +2422,11 @@ static long
 check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
 {
 	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
 
-	collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
-	if (list_empty(&movable_folio_list))
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+						       pofs);
+	if (!collected)
 		return 0;
 
 	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);


