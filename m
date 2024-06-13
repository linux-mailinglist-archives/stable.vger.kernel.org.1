Return-Path: <stable+bounces-50428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9BF9065C5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B90B21CF1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DC13CA9B;
	Thu, 13 Jun 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8yKQH14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29013CA99
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265326; cv=none; b=XTp5hPA4Zgh1ogDU8cT2Mk8JGKSa6i3S5vt0CXloZ35xOoQOlsvldd1a10mcBMyQBhmh8l9pL1iESkfaVoKdn/Yv5ctc5U8YnBCLRtkOYOeqAL1Thz66OiljvHQxPMqMh3IZ9w0bWUxy8SxRcPI4i1jOI+SVHMrRCSPNzR1yT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265326; c=relaxed/simple;
	bh=shjOJhMtzEnqbsXSRb20Ncw9u23kG9m1qF8qk1gGCcc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mu8Wu1kHx6tS5vkQDZLbv/mJ95M6D8r48O8zs0RaJVLUjCqqqTYS9GkuThmXb/ZHF4YAOArxfmJMY/qTQb2kqD2z2LB83bYoOD9lw2rZ3f7BF4tqlh9gssQevdhW4WRMYSMqjpMAnAcP4zdbYS8m2FVAHn+DSDQOFHkwJG2asho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8yKQH14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16616C4AF1A;
	Thu, 13 Jun 2024 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265326;
	bh=shjOJhMtzEnqbsXSRb20Ncw9u23kG9m1qF8qk1gGCcc=;
	h=Subject:To:Cc:From:Date:From;
	b=e8yKQH14CzLBbwmCGXemCTpjr13nB0kMHX9YnqZ8H6+sy7WemXuKcFDwZp/tioUAS
	 Wn+6yxR95FE6OCRJeLOB/9iOEPSQ5EJdNAtHzhwbOlT9xXIyUc6gtFAAFYOy1BWQB8
	 fxPQLnM98nzP+21Om2p//ts7KbdnO78GFlIQkcKs=
Subject: FAILED: patch "[PATCH] mm/hugetlb: pass correct order_per_bit to" failed to apply to 5.10-stable tree
To: fvdl@google.com,akpm@linux-foundation.org,david@redhat.com,m.szyprowski@samsung.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:55:18 +0200
Message-ID: <2024061318-magical-unclamped-49ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 55d134a7b499c77e7cfd0ee41046f3c376e791e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061318-magical-unclamped-49ef@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

55d134a7b499 ("mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid")
a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")
79dfc695525f ("hugetlb: add demote hugetlb page sysfs interfaces")
6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
262443c0421e ("hugetlb: no need to drop hugetlb_lock to call cma_release")
9157c31186c3 ("hugetlb: convert PageHugeTemporary() to HPageTemporary flag")
8f251a3d5ce3 ("hugetlb: convert page_huge_active() HPageMigratable flag")
d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
dbfee5aee7e5 ("hugetlb: fix update_and_free_page contig page struct assumption")
ecbf4724e606 ("mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active")
0eb2df2b5629 ("mm: hugetlb: fix a race between isolating and freeing page")
585fc0d2871c ("mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55d134a7b499c77e7cfd0ee41046f3c376e791e5 Mon Sep 17 00:00:00 2001
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 16:25:15 +0000
Subject: [PATCH] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid

The hugetlb_cma code passes 0 in the order_per_bit argument to
cma_declare_contiguous_nid (the alignment, computed using the page order,
is correctly passed in).

This causes a bit in the cma allocation bitmap to always represent a 4k
page, making the bitmaps potentially very large, and slower.

It would create bitmaps that would be pretty big.  E.g.  for a 4k page
size on x86, hugetlb_cma=64G would mean a bitmap size of (64G / 4k) / 8
== 2M.  With HUGETLB_PAGE_ORDER as order_per_bit, as intended, this
would be (64G / 2M) / 8 == 4k.  So, that's quite a difference.

Also, this restricted the hugetlb_cma area to ((PAGE_SIZE <<
MAX_PAGE_ORDER) * 8) * PAGE_SIZE (e.g.  128G on x86) , since
bitmap_alloc uses normal page allocation, and is thus restricted by
MAX_PAGE_ORDER.  Specifying anything about that would fail the CMA
initialization.

So, correctly pass in the order instead.

Link: https://lkml.kernel.org/r/20240404162515.527802-2-fvdl@google.com
Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Signed-off-by: Frank van der Linden <fvdl@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 228c886c46c1..5dc3f5ea3a2e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7794,9 +7794,9 @@ void __init hugetlb_cma_reserve(int order)
 		 * huge page demotion.
 		 */
 		res = cma_declare_contiguous_nid(0, size, 0,
-						PAGE_SIZE << HUGETLB_PAGE_ORDER,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
+					PAGE_SIZE << HUGETLB_PAGE_ORDER,
+					HUGETLB_PAGE_ORDER, false, name,
+					&hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
 				res, nid);


