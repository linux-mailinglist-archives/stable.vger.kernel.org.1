Return-Path: <stable+bounces-144776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790DABBD27
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02133AF7B5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868C276058;
	Mon, 19 May 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSNnZxen"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF327604B
	for <stable@vger.kernel.org>; Mon, 19 May 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655993; cv=none; b=SaJRjLRmhgDBF226Wikx3g4mDg3E6Ii8SqRSmjsWpSnPIc+5YtoP8fff0GQk+hVMaFN2m/eeTcuWX+GExPtq3g5KjJ6I/1qsRQnMP1E0YqJKblglsAKOANozt+q/Psh4+Nik9VgRhOrTWlddL4A+a0Hy7qnF3pPMWfGRtc2/Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655993; c=relaxed/simple;
	bh=nLHU28Kr2Paz39RhYm3DppOtSgp9TDmR/MR6RVLUy+U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DpfuIDuROxSGUQ+r7+2R5mpSzKgQBbKb/R0rO7BeqI9XyfWISTv/d8GTwwQuG0hQg1+3uOKklhRCp3qRMXKKetxsFDZerBoOgAAG3bYrpO9TThuH4J/le9fkTu6/FbPrpH2qmoRTlDL6mna4z6yluhj8NWn7XhvDZOQlQb5Yotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSNnZxen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1BDC4CEEF;
	Mon, 19 May 2025 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747655992;
	bh=nLHU28Kr2Paz39RhYm3DppOtSgp9TDmR/MR6RVLUy+U=;
	h=Subject:To:Cc:From:Date:From;
	b=fSNnZxenSMzJhQ222usCZHoae3R6CHQ2xdnoPvFbkZS5dzvVWxUqzCCXb87PQv80I
	 1S7bnG4Hddsevetr4KpPIxKJcPOKutTFHg4Wav5TMJYnynWO5IoePWXVyZoko3QYLu
	 f8PZQL8MSV7V2dJRz8HiMWdBCZy0FKwNpQy7k4gI=
Subject: FAILED: patch "[PATCH] btrfs: fix folio leak in submit_one_async_extent()" failed to apply to 6.6-stable tree
To: boris@bur.io,dsterba@suse.com,fdmanana@suse.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 13:59:49 +0200
Message-ID: <2025051949-line-blog-2ffe@gregkh>
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
git cherry-pick -x a0fd1c6098633f9a95fc2f636383546c82b704c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051949-line-blog-2ffe@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0fd1c6098633f9a95fc2f636383546c82b704c3 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Wed, 7 May 2025 12:42:24 -0700
Subject: [PATCH] btrfs: fix folio leak in submit_one_async_extent()

If btrfs_reserve_extent() fails while submitting an async_extent for a
compressed write, then we fail to call free_async_extent_pages() on the
async_extent and leak its folios. A likely cause for such a failure
would be btrfs_reserve_extent() failing to find a large enough
contiguous free extent for the compressed extent.

I was able to reproduce this by:

1. mount with compress-force=zstd:3
2. fallocating most of a filesystem to a big file
3. fragmenting the remaining free space
4. trying to copy in a file which zstd would generate large compressed
   extents for (vmlinux worked well for this)

Step 4. hits the memory leak and can be repeated ad nauseam to
eventually exhaust the system memory.

Fix this by detecting the case where we fallback to uncompressed
submission for a compressed async_extent and ensuring that we call
free_async_extent_pages().

Fixes: 131a821a243f ("btrfs: fallback if compressed IO fails for ENOSPC")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Co-developed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d295a37fa049..c1bd17915f81 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1109,6 +1109,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
+	bool free_pages = false;
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
@@ -1129,7 +1130,10 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
+		ASSERT(!async_extent->folios);
+		ASSERT(async_extent->nr_folios == 0);
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1145,6 +1149,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * fall back to uncompressed.
 		 */
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1186,6 +1191,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 done:
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
+	if (free_pages)
+		free_async_extent_pages(async_extent);
 	kfree(async_extent);
 	return;
 


