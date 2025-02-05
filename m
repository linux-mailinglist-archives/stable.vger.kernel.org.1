Return-Path: <stable+bounces-112309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E05A28A1B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8752818845A2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE50722B8B7;
	Wed,  5 Feb 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfyXzpYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07C21516B
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757995; cv=none; b=HjPDYio6GYwwIqnRYNWVS82S2K8crCh53IKgAN/iZX421QEcjU2+sC2cvQUKY6Mrf3w7YPWOljfuozkKbo/DXD/gs4K+AMrUw/l18ycUABZOsXCx2/M+R7LE9vNDQO275fADykugbvVDEh7P/yCFYyjnhHBVfjePzP103B988Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757995; c=relaxed/simple;
	bh=+lyHxWdV11xNev+COYc1LLs3iMpJ1anBAo4qjJcOyI0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=elICr1ACLrWN2uw1AbPRHpqiFboYZfj+louosUcwUCqyKxilnhIxwNw/VcD8x8W0RGwWNN8v4Gp2m8GvYIq+vPws7TcvKgv5gfmyU9Mv1omIjfwTuqRA9ufM1nbSOr9nZJGIqPkZnJZoYao4/iTLTNUkSqqp4foAbvnCieQeXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfyXzpYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EC9C4CEE2;
	Wed,  5 Feb 2025 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738757995;
	bh=+lyHxWdV11xNev+COYc1LLs3iMpJ1anBAo4qjJcOyI0=;
	h=Subject:To:Cc:From:Date:From;
	b=zfyXzpYpAxP1nOBgcg5b50RgkdahkjtVWcL4f5y20kiu2XVpADQfGyFy2CBkrC+hJ
	 15/XTrcs8YEhw6tzfILTJfRHUXuaSaj+AnTiHKl8WGiKPK94IMHAMxMFq3Z//JR9yk
	 j7XE1HmUS0CZA5aDhVHM7TKyeYZiKhciqQa57mhc=
Subject: FAILED: patch "[PATCH] btrfs: fix double accounting race when extent_writepage_io()" failed to apply to 5.4-stable tree
To: wqu@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Feb 2025 13:19:38 +0100
Message-ID: <2025020538-unmoving-shelving-20de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8bf334beb3496da3c3fbf3daf3856f7eec70dacc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020538-unmoving-shelving-20de@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bf334beb3496da3c3fbf3daf3856f7eec70dacc Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Thu, 12 Dec 2024 16:43:56 +1030
Subject: [PATCH] btrfs: fix double accounting race when extent_writepage_io()
 failed

[BUG]
If submit_one_sector() failed inside extent_writepage_io() for sector
size < page size cases (e.g. 4K sector size and 64K page size), then
we can hit double ordered extent accounting error.

This should be very rare, as submit_one_sector() only fails when we
failed to grab the extent map, and such extent map should exist inside
the memory and has been pinned.

[CAUSE]
For example we have the following folio layout:

    0  4K          32K    48K   60K 64K
    |//|           |//////|     |///|

Where |///| is the dirty range we need to writeback. The 3 different
dirty ranges are submitted for regular COW.

Now we hit the following sequence:

- submit_one_sector() returned 0 for [0, 4K)

- submit_one_sector() returned 0 for [32K, 48K)

- submit_one_sector() returned error for [60K, 64K)

- btrfs_mark_ordered_io_finished() called for the whole folio
  This will mark the following ranges as finished:
  * [0, 4K)
  * [32K, 48K)
    Both ranges have their IO already submitted, this cleanup will
    lead to double accounting.

  * [60K, 64K)
    That's the correct cleanup.

The only good news is, this error is only theoretical, as the target
extent map is always pinned, thus we should directly grab it from
memory, other than reading it from the disk.

[FIX]
Instead of calling btrfs_mark_ordered_io_finished() for the whole folio
range, which can touch ranges we should not touch, instead
move the error handling inside extent_writepage_io().

So that we can cleanup exact sectors that ought to be submitted but failed.

This provides much more accurate cleanup, avoiding the double accounting.

CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bc2bd103c8cc..5014134b9aa2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1420,6 +1420,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
+	bool error = false;
 	const u64 folio_start = folio_pos(folio);
 	u64 cur;
 	int bit;
@@ -1462,11 +1463,26 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			break;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
-		if (ret < 0)
-			goto out;
+		if (unlikely(ret < 0)) {
+			/*
+			 * bio_ctrl may contain a bio crossing several folios.
+			 * Submit it immediately so that the bio has a chance
+			 * to finish normally, other than marked as error.
+			 */
+			submit_one_bio(bio_ctrl);
+			/*
+			 * Failed to grab the extent map which should be very rare.
+			 * Since there is no bio submitted to finish the ordered
+			 * extent, we have to manually finish this sector.
+			 */
+			btrfs_mark_ordered_io_finished(inode, folio, cur,
+						       fs_info->sectorsize, false);
+			error = true;
+			continue;
+		}
 		submitted_io = true;
 	}
-out:
+
 	/*
 	 * If we didn't submitted any sector (>= i_size), folio dirty get
 	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
@@ -1474,8 +1490,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 *
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
+	 *
+	 * If we hit any error, the corresponding sector will still be dirty
+	 * thus no need to clear PAGECACHE_TAG_DIRTY.
 	 */
-	if (!submitted_io) {
+	if (!submitted_io && !error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
@@ -1495,7 +1514,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 {
 	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const u64 page_start = folio_pos(folio);
 	int ret;
 	size_t pg_offset;
 	loff_t i_size = i_size_read(&inode->vfs_inode);
@@ -1538,10 +1556,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
 	bio_ctrl->wbc->nr_to_write--;
 
-	if (ret)
-		btrfs_mark_ordered_io_finished(inode, folio,
-					       page_start, PAGE_SIZE, !ret);
-
 done:
 	if (ret < 0)
 		mapping_set_error(folio->mapping, ret);
@@ -2314,11 +2328,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		if (ret == 1)
 			goto next_page;
 
-		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
-						       cur, cur_len, !ret);
+		if (ret)
 			mapping_set_error(mapping, ret);
-		}
 		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;


