Return-Path: <stable+bounces-134812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F5A95217
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0361C3B385E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1AE26658C;
	Mon, 21 Apr 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TVWGOkH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4C266588
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243774; cv=none; b=k8l4OdpqEF/JQ6qbdTDPmk3t67pnAjlnHe7ju8mGbLXIsa7XTb2cY/nzRtt2x+pFtSVIlWk1A5L2z5ImlercfsMWfVXDPzgxTEvKWwPc6iZw79XbYpANJNYlhF2L/vk4JS2q4Tb4Sxpn8ivapjdWrGFdFVTr7ZPKiUEeamjgb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243774; c=relaxed/simple;
	bh=Bv394Ov/iQwouYnb08Js2e5twFS+ts4pvwvj3stJ6vg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=utTLTt4oBUfgBRpSBGrWi7DWHMiDRbgY09kFRKgVMqU5+5NysfUdlryrUqHp1e18uOm7ymkxQcrAbkRVXfvEDUly3uLetVFip9oKXTgKyztcBs4pqf+pnPhOww7xJWotzdH1Ip5XkcbNcse5xOpusxDZzwA3pEY20R8q9ybB6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TVWGOkH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C037C4CEEA;
	Mon, 21 Apr 2025 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243773;
	bh=Bv394Ov/iQwouYnb08Js2e5twFS+ts4pvwvj3stJ6vg=;
	h=Subject:To:Cc:From:Date:From;
	b=TVWGOkH98dvM2pm04qEGafYKnmHeud4BRQEJbIpWpvP3TINcNKTHMW6jayqfmDaB2
	 PIQgMUXcJSj1FwK1LywIW3qQkvB+Mq794GrrgX9RqomCsOHcGzikAGGFu6sa++WCfA
	 /KBoKMHvuVgPUXe25+cwRvFZClSMDFldRu7RwdgE=
Subject: FAILED: patch "[PATCH] mm/compaction: fix bug in hugetlb handling pathway" failed to apply to 5.15-stable tree
To: vishal.moola@gmail.com,akpm@linux-foundation.org,linmiaohe@huawei.com,osalvador@suse.de,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:56:01 +0200
Message-ID: <2025042101-algorithm-simply-9ce6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a84edd52f0a0fa193f0f685769939cf84510755b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042101-algorithm-simply-9ce6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


