Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4C7CAC77
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjJPOzA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJPOzA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB0AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:54:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3439EC433C7;
        Mon, 16 Oct 2023 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468098;
        bh=a5jIfQZaTZ9AGsiV1AwiApkV2b7GQTZAPNRRGfa/k7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1z5GGOuIFUKKrCIsxKahW8Meb08OU3/2yeL+7f06eCBdcy5yQNXLJyFSWuwHlpXoT
         jj3+sxPwDRb06xnkv+5byZIqCOwoGfeCCl4rnlpcIiL7MspiwwG9CQzDPy7U39z9Vf
         GfbU69MM88/n3AdKW8ZCRjSqDELm+rYjb2QzOp1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 157/191] block: Dont invalidate pagecache for invalid falloc modes
Date:   Mon, 16 Oct 2023 10:42:22 +0200
Message-ID: <20231016084019.040034473@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

commit 1364a3c391aedfeb32aa025303ead3d7c91cdf9d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/fops.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/block/fops.c
+++ b/block/fops.c
@@ -659,24 +659,35 @@ static long blkdev_fallocate(struct file
 
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


