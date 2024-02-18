Return-Path: <stable+bounces-20443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F195859609
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 10:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE5282B6B
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070E12B79;
	Sun, 18 Feb 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvmU7YgS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAC3FC8
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249090; cv=none; b=MFE4MmQyE04oUNDPai7mGb4FT2w/o9H+4gH+vD1EZxfHY6SWoyrG7y/liT6J99kwKbfe28ggS1EHRXZHZ9zcTIhezhro05K3ilCNzqAYdJp3RRRNjQVDLXPAZ7/IHNZf/XZRgdMheuZki7oIyWCruuPLkh8RzzbLhpMSPmqcUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249090; c=relaxed/simple;
	bh=IbUDjfGrGPqvY2RIk1pmvQLy/MiHmri7DTRGpYt5jY8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f7JCi/hg5X9IBmxELPbYMaDBQYltSKOoJKdK4WQwZxJ+QpUU7wZadCpCaCFLuhiUbLiDxA9t+R+aVWOlfnu0kCMe2GxrIUcURqyTNGaRvc2l8617MhVMvPp5AYCW8HPNkfiLUi9qmw9APOnK4seqx5KlNcA1Pco+BIlq1F7ci2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvmU7YgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872C1C433F1;
	Sun, 18 Feb 2024 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708249088;
	bh=IbUDjfGrGPqvY2RIk1pmvQLy/MiHmri7DTRGpYt5jY8=;
	h=Subject:To:Cc:From:Date:From;
	b=NvmU7YgSzykr4eZhMCT//SCmeexAcpFRr7+WRtMeoxGdaH9F662ralg2vK9YswSzF
	 wFJy0F5zBDPjt2wsANsurzarpXkV/8tKX6tOa8b0jL5DC9bu2b9K7VSb+/2QBoI0dS
	 6do6vxmon9i3YXrUhB+BXB8ynKkpyIm0CeUAEQF4=
Subject: FAILED: patch "[PATCH] btrfs: don't drop extent_map for free space inode on write" failed to apply to 5.10-stable tree
To: josef@toxicpanda.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2024 10:37:59 +0100
Message-ID: <2024021858-sharpie-diffusive-52e1@gregkh>
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
git cherry-pick -x 5571e41ec6e56e35f34ae9f5b3a335ef510e0ade
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021858-sharpie-diffusive-52e1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

5571e41ec6e5 ("btrfs: don't drop extent_map for free space inode on write error")
4c0c8cfc8433 ("btrfs: move btrfs_drop_extent_cache() to extent_map.c")
cef7820d6abf ("btrfs: fix missed extent on fsync after dropping extent maps")
570eb97bace8 ("btrfs: unify the lock/unlock extent variants")
dbbf49928f2e ("btrfs: remove the wake argument from clear_extent_bits")
e3974c669472 ("btrfs: move core extent_io_tree functions to extent-io-tree.c")
38830018387e ("btrfs: move a few exported extent_io_tree helpers to extent-io-tree.c")
04eba8932392 ("btrfs: temporarily export and then move extent state helpers")
91af24e48474 ("btrfs: temporarily export and move core extent_io_tree tree functions")
6962541e964f ("btrfs: move btrfs_debug_check_extent_io_range into extent-io-tree.c")
ec39e39bbf97 ("btrfs: export wait_extent_bit")
a66318872c41 ("btrfs: move simple extent bit helpers out of extent_io.c")
ad795329574c ("btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's")
83cf709a89fb ("btrfs: move extent state init and alloc functions to their own file")
c45379a20fbc ("btrfs: temporarily export alloc_extent_state helpers")
a40246e8afc0 ("btrfs: separate out the eb and extent state leak helpers")
a62a3bd9546b ("btrfs: separate out the extent state and extent buffer init code")
87c11705cc94 ("btrfs: convert the io_failure_tree to a plain rb_tree")
a2061748052c ("btrfs: unexport internal failrec functions")
0d0a762c419a ("btrfs: rename clean_io_failure and remove extraneous args")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5571e41ec6e56e35f34ae9f5b3a335ef510e0ade Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 31 Jan 2024 14:27:25 -0500
Subject: [PATCH] btrfs: don't drop extent_map for free space inode on write
 error

While running the CI for an unrelated change I hit the following panic
with generic/648 on btrfs_holes_spacecache.

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1385
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1385!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 2695096 Comm: fsstress Kdump: loaded Tainted: G        W          6.8.0-rc2+ #1
RIP: 0010:__extent_writepage_io.constprop.0+0x4c1/0x5c0
Call Trace:
 <TASK>
 extent_write_cache_pages+0x2ac/0x8f0
 extent_writepages+0x87/0x110
 do_writepages+0xd5/0x1f0
 filemap_fdatawrite_wbc+0x63/0x90
 __filemap_fdatawrite_range+0x5c/0x80
 btrfs_fdatawrite_range+0x1f/0x50
 btrfs_write_out_cache+0x507/0x560
 btrfs_write_dirty_block_groups+0x32a/0x420
 commit_cowonly_roots+0x21b/0x290
 btrfs_commit_transaction+0x813/0x1360
 btrfs_sync_file+0x51a/0x640
 __x64_sys_fdatasync+0x52/0x90
 do_syscall_64+0x9c/0x190
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

This happens because we fail to write out the free space cache in one
instance, come back around and attempt to write it again.  However on
the second pass through we go to call btrfs_get_extent() on the inode to
get the extent mapping.  Because this is a new block group, and with the
free space inode we always search the commit root to avoid deadlocking
with the tree, we find nothing and return a EXTENT_MAP_HOLE for the
requested range.

This happens because the first time we try to write the space cache out
we hit an error, and on an error we drop the extent mapping.  This is
normal for normal files, but the free space cache inode is special.  We
always expect the extent map to be correct.  Thus the second time
through we end up with a bogus extent map.

Since we're deprecating this feature, the most straightforward way to
fix this is to simply skip dropping the extent map range for this failed
range.

I shortened the test by using error injection to stress the area to make
it easier to reproduce.  With this patch in place we no longer panic
with my error injection test.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7bcc1c03437a..d232eca1bbee 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3184,8 +3184,23 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			unwritten_start += logical_len;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
-		/* Drop extent maps for the part of the extent we didn't write. */
-		btrfs_drop_extent_map_range(inode, unwritten_start, end, false);
+		/*
+		 * Drop extent maps for the part of the extent we didn't write.
+		 *
+		 * We have an exception here for the free_space_inode, this is
+		 * because when we do btrfs_get_extent() on the free space inode
+		 * we will search the commit root.  If this is a new block group
+		 * we won't find anything, and we will trip over the assert in
+		 * writepage where we do ASSERT(em->block_start !=
+		 * EXTENT_MAP_HOLE).
+		 *
+		 * Theoretically we could also skip this for any NOCOW extent as
+		 * we don't mess with the extent map tree in the NOCOW case, but
+		 * for now simply skip this if we are the free space inode.
+		 */
+		if (!btrfs_is_free_space_inode(inode))
+			btrfs_drop_extent_map_range(inode, unwritten_start,
+						    end, false);
 
 		/*
 		 * If the ordered extent had an IOERR or something else went


