Return-Path: <stable+bounces-137385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24FAA131E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6458A16EA91
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E392472B9;
	Tue, 29 Apr 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIHJiHI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A5251798;
	Tue, 29 Apr 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945910; cv=none; b=lGBpyRO2XVo3y4iytcgov7V8WgbWlaky6tpblIxWfQ3qkhHVYO10PzTVb0+WT3rowoI5Y1pPNHkMQ1TxpKpY3Qkyenmt73TO583wsrn30zhoro2qjzZGentbTRINKDCeRsfBgV4TAGjFNASNlGNs0xrJIDs7JbldfjB1msqjoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945910; c=relaxed/simple;
	bh=K5akmzlX/6eHRFx+NZpHukgzTtOHcYHknzWL/sKCfQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7GqTlG7D4I91ejRPIgt4f/E6Po+eTduhCqp7LCkFNKsmy9mFSP9SYHQGPHn6BeFfYukGXJuLTJTugZepnSWESqg2AB9yE9qYOLVN1XBM9BF11aE6bZnXPsw5t2lxrO2VC3usgUFLgCUf7+v5ZL9NgfXnJSyHGhd6Ut8SS7qOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIHJiHI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458D0C4CEE9;
	Tue, 29 Apr 2025 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945910;
	bh=K5akmzlX/6eHRFx+NZpHukgzTtOHcYHknzWL/sKCfQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIHJiHI7Dy0EF9i1xFnMcsyUrhEmX8rucfddiEEN2z63aIa4KE2h1/dIMiwhMVlG2
	 ry6tiC2MuDZvPdeUg6LZSrN0Nxas838qum0S9JsYv3g7KIsnhQXS7yI3vc9IjlzH9t
	 VKOGF1hxlbouB/quJXg8yQBaLfFR/6t1bjPe0u4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 083/311] block: remove the backing_inode variable in bdev_statx
Date: Tue, 29 Apr 2025 18:38:40 +0200
Message-ID: <20250429161124.454622067@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit d13b7090b2510abaa83a25717466decca23e8226 ]

backing_inode is only used once, so remove it and update the comment
describing the bdev lookup to be a bit more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20250423053810.1683309-3-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 5f33b5226c9d ("block: don't autoload drivers on stat")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 8453f6a795d9a..89235796e51a5 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1271,18 +1271,15 @@ void sync_bdevs(bool wait)
 void bdev_statx(struct path *path, struct kstat *stat,
 		u32 request_mask)
 {
-	struct inode *backing_inode;
 	struct block_device *bdev;
 
-	backing_inode = d_backing_inode(path->dentry);
-
 	/*
-	 * Note that backing_inode is the inode of a block device node file,
-	 * not the block device's internal inode.  Therefore it is *not* valid
-	 * to use I_BDEV() here; the block device has to be looked up by i_rdev
+	 * Note that d_backing_inode() returns the block device node inode, not
+	 * the block device's internal inode.  Therefore it is *not* valid to
+	 * use I_BDEV() here; the block device has to be looked up by i_rdev
 	 * instead.
 	 */
-	bdev = blkdev_get_no_open(backing_inode->i_rdev);
+	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
 	if (!bdev)
 		return;
 
-- 
2.39.5




