Return-Path: <stable+bounces-40272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF928AACF8
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B6DB20B4C
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5717BB12;
	Fri, 19 Apr 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BV2xGW9m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4AB199C2
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523207; cv=none; b=Lt1S5ODI5BPG4F7HzPfmLJfYd4ZB2mv6IEzC96NjNO1jyg+UQB+neDzPW5GI6Q49cJW3nz8axHwk576v58yN80EPYUWjpL9SWWMDbp+Bbc4QTPAUdW1Zs/7T6YAwcKoOtKn87CYrXRp3wLXeJpebFLWwGahR3Cet/W0bidbRjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523207; c=relaxed/simple;
	bh=m3InNOsuH2pOPXCsGkYSHNdnTqIEK+TE00sj650iOsY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cg2/+xeBQK1+WYthLnrC6qAwahwHYwPPjkq+HepHKLZKZPEdPr/HEbeqOC3MnzyhSMiDV+HNHmLbsbbwer+3iZ8AfgCWiPjofgUknZFY7tdGXOHUN/s7ZrX1vRlbEHpU2jJoGrvjph0+EE582k07bgWRiVD0BCcCrksoAHK1X2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BV2xGW9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4708FC072AA;
	Fri, 19 Apr 2024 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523207;
	bh=m3InNOsuH2pOPXCsGkYSHNdnTqIEK+TE00sj650iOsY=;
	h=Subject:To:Cc:From:Date:From;
	b=BV2xGW9m1WceHVpMsDMIBPFy3RzrZUX1ePj+28l/T2owLaWy1ltGaokETGMap+/RG
	 +NLWjdXZKl+4Hvo/Tgn2O7HgvJ0saLXqjpZU4ngTF5Uh3V2oqXvm5IEYI5DS9ruchD
	 uA10iuOCA+fHxSa3iaQ4SF/rydhNfgQWNTIl15mU=
Subject: FAILED: patch "[PATCH] btrfs: do not wait for short bulk allocation" failed to apply to 6.1-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com,julian.taylor@1und1.de,sweettea-kernel@dorminy.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Apr 2024 12:39:54 +0200
Message-ID: <2024041954-bullish-slingshot-109f@gregkh>
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
git cherry-pick -x 1db7959aacd905e6487d0478ac01d89f86eb1e51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041954-bullish-slingshot-109f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1db7959aacd9 ("btrfs: do not wait for short bulk allocation")
09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
397239ed6a6c ("btrfs: allow extent buffer helpers to skip cross-page handling")
94dbf7c0871f ("btrfs: free the allocated memory if btrfs_alloc_page_array() fails")
096d23016543 ("btrfs: refactor main loop in memmove_extent_buffer()")
13840f3f2837 ("btrfs: refactor main loop in memcpy_extent_buffer()")
730c374e5b2c ("btrfs: use write_extent_buffer() to implement write_extent_buffer_*id()")
cb22964f1dad ("btrfs: refactor extent buffer bitmaps operations")
52ea5bfbfa6d ("btrfs: move eb subpage preallocation out of the loop")
5a96341927b0 ("btrfs: subpage: make alloc_extent_buffer() handle previously uptodate range efficiently")
2af2aaf98205 ("btrfs: scrub: introduce structure for new BTRFS_STRIPE_LEN based interface")
5eb30ee26fa4 ("btrfs: raid56: introduce the main entrance for RMW path")
6486d21c99cb ("btrfs: raid56: extract rwm write bios assembly into a helper")
509c27aa2fb6 ("btrfs: raid56: extract the rmw bio list build code into a helper")
30e3c897f4a8 ("btrfs: raid56: extract the pq generation code into a helper")
2fc6822c99d7 ("btrfs: move scrub prototypes into scrub.h")
677074792a1d ("btrfs: move relocation prototypes into relocation.h")
33cf97a7b658 ("btrfs: move acl prototypes into acl.h")
af142b6f44d3 ("btrfs: move file prototypes to file.h")
7572dec8f522 ("btrfs: move ioctl prototypes into ioctl.h")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1db7959aacd905e6487d0478ac01d89f86eb1e51 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 26 Mar 2024 09:16:46 +1030
Subject: [PATCH] btrfs: do not wait for short bulk allocation

[BUG]
There is a recent report that when memory pressure is high (including
cached pages), btrfs can spend most of its time on memory allocation in
btrfs_alloc_page_array() for compressed read/write.

[CAUSE]
For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
even if the bulk allocation failed (fell back to single page
allocation) we still retry but with extra memalloc_retry_wait().

If the bulk alloc only returned one page a time, we would spend a lot of
time on the retry wait.

The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
incomplete batch memory allocations").

[FIX]
Although the commit mentioned that other filesystems do the wait, it's
not the case at least nowadays.

All the mainlined filesystems only call memalloc_retry_wait() if they
failed to allocate any page (not only for bulk allocation).
If there is any progress, they won't call memalloc_retry_wait() at all.

For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
if there is no allocation progress at all, and the call is not for
metadata readahead.

So I don't believe we should call memalloc_retry_wait() unconditionally
for short allocation.

Call memalloc_retry_wait() if it fails to allocate any page for tree
block allocation (which goes with __GFP_NOFAIL and may not need the
special handling anyway), and reduce the latency for
btrfs_alloc_page_array().

Reported-by: Julian Taylor <julian.taylor@1und1.de>
Tested-by: Julian Taylor <julian.taylor@1und1.de>
Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b18034f2ab80..2776112dbdf8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -681,31 +681,21 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   gfp_t extra_gfp)
 {
+	const gfp_t gfp = GFP_NOFS | extra_gfp;
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
 		unsigned int last = allocated;
 
-		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
-						   nr_pages, page_array);
-
-		if (allocated == nr_pages)
-			return 0;
-
-		/*
-		 * During this iteration, no page could be allocated, even
-		 * though alloc_pages_bulk_array() falls back to alloc_page()
-		 * if  it could not bulk-allocate. So we must be out of memory.
-		 */
-		if (allocated == last) {
+		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
+		if (unlikely(allocated == last)) {
+			/* No progress, fail and do cleanup. */
 			for (int i = 0; i < allocated; i++) {
 				__free_page(page_array[i]);
 				page_array[i] = NULL;
 			}
 			return -ENOMEM;
 		}
-
-		memalloc_retry_wait(GFP_NOFS);
 	}
 	return 0;
 }


