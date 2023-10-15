Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D67C9ABE
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJOSXb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:23:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4985BAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E09CC433C9;
        Sun, 15 Oct 2023 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697394210;
        bh=qcfwoWi4vVvpHH2FZMaGG0iinG+c2heoUDnBM1QE2gQ=;
        h=Subject:To:Cc:From:Date:From;
        b=AeYeM6G9ZKCi6Gm1wZZr/i2W/7ZQS+kvg0EVDsDbkItHBFdzAo1ymGfME5KmbQKBH
         E2Hra+AMVjcnZpBhHY3TlcfISh6aK9lrJ9nrpsDIKFbpdIQtIBiE5Jox5uHkco57rd
         PKOxq6wR1JE2SCPV4j9Kp7hhltRQnIqxKnTgq1BE=
Subject: FAILED: patch "[PATCH] block: Don't invalidate pagecache for invalid falloc modes" failed to apply to 4.19-stable tree
To:     sarthakkukreti@chromium.org, axboe@kernel.dk, djwong@kernel.org,
        hch@lst.de, snitzer@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:23:16 +0200
Message-ID: <2023101516-genetics-gratify-225c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1364a3c391aedfeb32aa025303ead3d7c91cdf9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101516-genetics-gratify-225c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1364a3c391ae ("block: Don't invalidate pagecache for invalid falloc modes")
05bdb9965305 ("block: replace fmode_t with a block-specific type for block open flags")
5e4ea834676e ("block: remove unused fmode_t arguments from ioctl handlers")
cfb425761c79 ("block: move a few internal definitions out of blkdev.h")
99b07780814e ("rnbd-srv: replace sess->open_flags with a "bool readonly"")
658afed19cee ("mtd: block: use a simple bool to track open for write")
7d9d7d59d44b ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
2e80089c1824 ("scsi: replace the fmode_t argument to scsi_ioctl with a simple bool")
5f4eb9d5413f ("scsi: replace the fmode_t argument to scsi_cmd_allowed with a simple bool")
81b1fb7d17c0 ("fs: remove sb->s_mode")
3f0b3e785e8b ("block: add a sb_open_mode helper")
2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
2ef789288afd ("btrfs: don't pass a holder for non-exclusive blkdev_get_by_path")
29499ab060fe ("bcache: don't pass a stack address to blkdev_get_by_path")
c889d0793d9d ("swsusp: don't pass a stack address to blkdev_get_by_path")
ae220766d87c ("block: remove the unused mode argument to ->release")
d32e2bf83791 ("block: pass a gendisk to ->open")
444aa2c58cb3 ("block: pass a gendisk on bdev_check_media_change")
7ae24fcee992 ("cdrom: remove the unused mode argument to cdrom_release")
473399b50de1 ("cdrom: remove the unused mode argument to cdrom_ioctl")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1364a3c391aedfeb32aa025303ead3d7c91cdf9d Mon Sep 17 00:00:00 2001
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Wed, 11 Oct 2023 13:12:30 -0700
Subject: [PATCH] block: Don't invalidate pagecache for invalid falloc modes

Only call truncate_bdev_range() if the fallocate mode is supported. This
fixes a bug where data in the pagecache could be invalidated if the
fallocate() was called on the block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Cc: stable@vger.kernel.org
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Fixes: line?  I've never seen those wrapped.
Link: https://lore.kernel.org/r/20231011201230.750105-1-sarthakkukreti@chromium.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..73e42742543f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -772,24 +772,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;

