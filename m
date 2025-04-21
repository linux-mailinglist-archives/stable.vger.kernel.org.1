Return-Path: <stable+bounces-134810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3BA95215
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD61318854D9
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149A266581;
	Mon, 21 Apr 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCq2YveV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4E27463
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243762; cv=none; b=iEsaXTLWEOW7G8CKyZ/oKZH10a//zftemCylfHY8kBZUe/E6iObcpPG9pc1ltAz5D12aNYC/CV7ketH8vNOE8sCplJuY+ohSwq988e6VbeiVs5AlrtSDqibcqjLhz0aJfSTxgijtXYEQJoLSg91FoALCWNoHqzpni1uJI/PjHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243762; c=relaxed/simple;
	bh=rRmDq/oeAiu6ak/SMFBpEHohuPiiNwKGsgsIGge6J5c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HJX49tIH5kE/Y9qEO2FB7nhdchyGAw7hEYxkbKPwX9VHkI8ZDbrqqeL9hb8scp4c1tT6eJ9s7zlyEa6Cr/HHGKl4ZpQuu7IXlRt9bcHIocTYQP9/DhZwRbOYrEU/VPtK6oiac/rZJSPY3hjVrUde9nPAmpNJwK4b8100eKINLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mCq2YveV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC665C4CEE4;
	Mon, 21 Apr 2025 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243762;
	bh=rRmDq/oeAiu6ak/SMFBpEHohuPiiNwKGsgsIGge6J5c=;
	h=Subject:To:Cc:From:Date:From;
	b=mCq2YveVQ8CGjlRjU3MNYP3ogLe7VdIQnHnS06OjXITkUIwsg9b7XyZ7q3leiMzHh
	 foD0MhdPBnR8+M4Pzn/mMJP1+0ngprnXmti8cfxklJZxpVeLoTnoNNEWsAFXNNGNmN
	 W48bl2TJ88PWCuj1B9VdCqMBeK938yijEbMT91bQ=
Subject: FAILED: patch "[PATCH] mm/compaction: fix bug in hugetlb handling pathway" failed to apply to 6.6-stable tree
To: vishal.moola@gmail.com,akpm@linux-foundation.org,linmiaohe@huawei.com,osalvador@suse.de,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:55:59 +0200
Message-ID: <2025042159-bobcat-kennel-5f94@gregkh>
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
git cherry-pick -x a84edd52f0a0fa193f0f685769939cf84510755b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042159-bobcat-kennel-5f94@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


