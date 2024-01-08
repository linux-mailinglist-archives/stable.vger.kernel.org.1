Return-Path: <stable+bounces-10181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42BD827397
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35701C22AE2
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135711E4A2;
	Mon,  8 Jan 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BECCkqM+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098C5102D;
	Mon,  8 Jan 2024 15:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4588C4339A;
	Mon,  8 Jan 2024 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728257;
	bh=lvDETJfH1yafyKAUtoTLfYgw4oe+vktYx+qvaD3fzgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BECCkqM+c2XOBXsftNFBrWArjeOakpQAqwHB9nzd/xjDyisJrHRZEaLj2XKos8ZDP
	 DkEMVI/Z32UOWwARunc67KGiVX7LDlwOBcRqx5M+dIo9wz5IrWr2nDKE866ee+wwbC
	 DAPQXWJAoB+nu7aGf5JIIGQ0yOdQLYTJVmXz6g3Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sarthak Kukreti <sarthakkukreti@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 002/150] block: Dont invalidate pagecache for invalid falloc modes
Date: Mon,  8 Jan 2024 16:34:13 +0100
Message-ID: <20240108153511.343081049@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/fops.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/block/fops.c
+++ b/block/fops.c
@@ -655,24 +655,35 @@ static long blkdev_fallocate(struct file
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
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
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;



