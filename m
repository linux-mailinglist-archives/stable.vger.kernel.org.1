Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7574579AF23
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376641AbjIKWUH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbjIKOSg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:18:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A472DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BBDC433C8;
        Mon, 11 Sep 2023 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441912;
        bh=7qYF1A3SsDhFgeicuZUm6hiTepdd2C8OjV6rReOAifo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBp3o7SC9f8aeOxzbLHVRjnnApcbQm54XYjawN9pWnmtONXYk+sv4QRYvY5oDnaj6
         IXhVLVEQuY3ia3/bA37W3Kbd8w0RXf8rWDyH5MXtSbEk1Y3F4cqkPqdk2AhJfE/kZb
         drQDnrZ36IIIKo63g9/frfrX+VYo6Fudz2Ze+tCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 552/739] f2fs: dont reopen the main block device in f2fs_scan_devices
Date:   Mon, 11 Sep 2023 15:45:51 +0200
Message-ID: <20230911134706.506432042@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 51bf8d3c81992ae57beeaf22df78ed7c2782af9d ]

f2fs_scan_devices reopens the main device since the very beginning, which
has always been useless, and also means that we don't pass the right
holder for the reopen, which now leads to a warning as the core super.c
holder ops aren't passed in for the reopen.

Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
Fixes: 0718afd47f70 ("block: introduce holder ops")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca31163da00a5..30883beb750a5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1561,7 +1561,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	int i;
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
-		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
+		if (i > 0)
+			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4190,16 +4191,12 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	sbi->aligned_blksize = true;
 
 	for (i = 0; i < max_devices; i++) {
-
-		if (i > 0 && !RDEV(i).path[0])
+		if (i == 0)
+			FDEV(0).bdev = sbi->sb->s_bdev;
+		else if (!RDEV(i).path[0])
 			break;
 
-		if (max_devices == 1) {
-			/* Single zoned block device mount */
-			FDEV(0).bdev =
-				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
-						  sbi->sb->s_type, NULL);
-		} else {
+		if (max_devices > 1) {
 			/* Multi-device mount */
 			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
 			FDEV(i).total_segments =
@@ -4215,10 +4212,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).end_blk = FDEV(i).start_blk +
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
+				FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
+					mode, sbi->sb->s_type, NULL);
 			}
-			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
-							  sbi->sb->s_type,
-							  NULL);
 		}
 		if (IS_ERR(FDEV(i).bdev))
 			return PTR_ERR(FDEV(i).bdev);
-- 
2.40.1



