Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A24726D88
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjFGUnQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjFGUnJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052B2733
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2E76462E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D97AC433EF;
        Wed,  7 Jun 2023 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170563;
        bh=P12QkZF3C6C16RHWjPfDDVPk4kIX+N03V18889yx9TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLjk8QxUHE4bZcC5T52plUIMHea/aIzhu2z1ZlDFpOFjBd2O6czqWjDFZt4o0cMXl
         nO09yZycsi8pZDleLMT7oYXtTCIbrMuODAzcb3Kgvx/Mo5MLOBh74ZBihTV3KxeZtq
         KuaT9EeoZ+0g4W8y/Tiusjw8Fw5eodq9+RezMUHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Loic Poulain <loic.poulain@linaro.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 133/225] block: Deny writable memory mapping if block is read-only
Date:   Wed,  7 Jun 2023 22:15:26 +0200
Message-ID: <20230607200918.720994292@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 69baa3a623fd2e58624f24f2f23d46f87b817c93 ]

User should not be able to write block device if it is read-only at
block level (e.g force_ro attribute). This is ensured in the regular
fops write operation (blkdev_write_iter) but not when writing via
user mapping (mmap), allowing user to actually write a read-only
block device via a PROT_WRITE mapping.

Example: This can lead to integrity issue of eMMC boot partition
(e.g mmcblk0boot0) which is read-only by default.

To fix this issue, simply deny shared writable mapping if the block
is readonly.

Note: Block remains writable if switch to read-only is performed
after the initial mapping, but this is expected behavior according
to commit a32e236eb93e ("Partially revert "block: fail op_is_write()
requests to read-only partitions"")'.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230510074223.991297-1-loic.poulain@linaro.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/fops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index e406aa605327e..6197d1c41652d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -685,6 +685,16 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	return error;
 }
 
+static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *bd_inode = bdev_file_inode(file);
+
+	if (bdev_read_only(I_BDEV(bd_inode)))
+		return generic_file_readonly_mmap(file, vma);
+
+	return generic_file_mmap(file, vma);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_close,
@@ -692,7 +702,7 @@ const struct file_operations def_blk_fops = {
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
 	.iopoll		= iocb_bio_iopoll,
-	.mmap		= generic_file_mmap,
+	.mmap		= blkdev_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= blkdev_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.39.2



