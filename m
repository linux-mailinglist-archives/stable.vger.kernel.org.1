Return-Path: <stable+bounces-134811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C3A95216
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8B2173078
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E8265CB6;
	Mon, 21 Apr 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZiCRe8LA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31F27463
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243771; cv=none; b=q2l+H2V6igg7lM4TRVQaogoRaX7rRcnozm8yqRv+zYlZVYnKXNRltahzYAO1rdeezXVe5w/rKqQOTqMD9RTYoDn+7Z9RU4ng1T4BfLbEUC/DmFDJYjkiraI9425owtTKDMUkHn9kx+bRhYqAXK+a3ZvGzEz5MSDauZQ7HC1b6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243771; c=relaxed/simple;
	bh=PniJo37jCUuiKEy+snsZNqmaAHdWOLCdVFwLTVmpprg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nbQNCFUjq/yzRoxSyq5ug1+YizRRgVnjCTSJ9/PTRZMIdOD24lYJd64xCc6MbkOF40hJhwWMPaIY/eyHLLlogdn24BTciKoqmO6ihRqoZ2F0CB0oUsNh3BZsBqaQSc3VJz/9wTU7f5sNyR7WH0w1SMCSLxLHaRTiUgkkcfHXXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZiCRe8LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D71DC4CEEC;
	Mon, 21 Apr 2025 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243770;
	bh=PniJo37jCUuiKEy+snsZNqmaAHdWOLCdVFwLTVmpprg=;
	h=Subject:To:Cc:From:Date:From;
	b=ZiCRe8LAWVuCLmF+Qwl0J9dPdSfnHVcRKQX5Xy2xSDMbd20ahsebx6I8MUKYe9zCc
	 8h0zN/NT/QcavvE9/dlgyl3eqfVQBh0D+jSX1Z+m07XfLDeCi67cFMKGJoS2CwiHD7
	 WahdDVQph+WcrZmR6cQkzLm/EYSYz6CuMsQUNqPc=
Subject: FAILED: patch "[PATCH] mm/compaction: fix bug in hugetlb handling pathway" failed to apply to 6.1-stable tree
To: vishal.moola@gmail.com,akpm@linux-foundation.org,linmiaohe@huawei.com,osalvador@suse.de,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:56:00 +0200
Message-ID: <2025042100-cabbie-enzyme-2411@gregkh>
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
git cherry-pick -x a84edd52f0a0fa193f0f685769939cf84510755b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042100-cabbie-enzyme-2411@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a84edd52f0a0fa193f0f685769939cf84510755b Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Mon, 31 Mar 2025 19:10:24 -0700
Subject: [PATCH] mm/compaction: fix bug in hugetlb handling pathway

The compaction code doesn't take references on pages until we're certain
we should attempt to handle it.

In the hugetlb case, isolate_or_dissolve_huge_page() may return -EBUSY
without taking a reference to the folio associated with our pfn.  If our
folio's refcount drops to 0, compound_nr() becomes unpredictable, making
low_pfn and nr_scanned unreliable.  The user-visible effect is minimal -
this should rarely happen (if ever).

Fix this by storing the folio statistics earlier on the stack (just like
the THP and Buddy cases).

Also revert commit 66fe1cf7f581 ("mm: compaction: use helper compound_nr
in isolate_migratepages_block") to make backporting easier.

Link: https://lkml.kernel.org/r/20250401021025.637333-1-vishal.moola@gmail.com
Fixes: 369fa227c219 ("mm: make alloc_contig_range handle free hugetlb pages")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/compaction.c b/mm/compaction.c
index 139f00c0308a..ca71fd3c3181 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -981,13 +981,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page)) {
+			const unsigned int order = compound_order(page);
 			/*
 			 * skip hugetlbfs if we are not compacting for pages
 			 * bigger than its order. THPs and other compound pages
 			 * are handled below.
 			 */
 			if (!cc->alloc_contig) {
-				const unsigned int order = compound_order(page);
 
 				if (order <= MAX_PAGE_ORDER) {
 					low_pfn += (1UL << order) - 1;
@@ -1011,8 +1011,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				 /* Do not report -EBUSY down the chain */
 				if (ret == -EBUSY)
 					ret = 0;
-				low_pfn += compound_nr(page) - 1;
-				nr_scanned += compound_nr(page) - 1;
+				low_pfn += (1UL << order) - 1;
+				nr_scanned += (1UL << order) - 1;
 				goto isolate_fail;
 			}
 


