Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD26FADD7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjEHLiy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjEHLij (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621C30AF2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B276633FB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8997FC4339B;
        Mon,  8 May 2023 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545842;
        bh=sk+DmaSwmVvuX/7iXBbB7WhmY1toirRi+JkpyjAoqHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDy0LyGu6p9UzyO0IV2Y48FW28hlCzX8T5eLKJB+xX29BnhXeAIwiea85IWfP7LOU
         N5mzDw2mipUb4ebgH1npTUTkttWfrggy2PDHwSxQjP5k72HEnOKXlouoao7sxRXUkp
         IJUW3VpK5qgI1ut3spDT8/vn/ArPKnx3YJ6/N7qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 172/371] f2fs: enforce single zone capacity
Date:   Mon,  8 May 2023 11:46:13 +0200
Message-Id: <20230508094818.958837539@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit b771aadc6e4c221a468fe4a2dfcfffec01a06722 ]

In order to simplify the complicated per-zone capacity, let's support
only one capacity for entire zoned device.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 0b37ed21e336 ("f2fs: apply zone capacity to all zone type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 19 ++++++-------------
 fs/f2fs/segment.h |  3 +++
 fs/f2fs/super.c   | 33 ++++++++++++---------------------
 4 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 80e4f9afe86f7..7424470c68cbe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1211,7 +1211,6 @@ struct f2fs_dev_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_blkz;		/* Total number of zones */
 	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
-	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
 #endif
 };
 
@@ -1632,6 +1631,7 @@ struct f2fs_sb_info {
 	unsigned int meta_ino_num;		/* meta inode number*/
 	unsigned int log_blocks_per_seg;	/* log2 blocks per segment */
 	unsigned int blocks_per_seg;		/* blocks per segment */
+	unsigned int unusable_blocks_per_sec;	/* unusable blocks per section */
 	unsigned int segs_per_sec;		/* segments per section */
 	unsigned int secs_per_zone;		/* sections per zone */
 	unsigned int total_sections;		/* total section count */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 58dd4de41986e..880447750caf4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5078,7 +5078,7 @@ static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
 static inline unsigned int f2fs_usable_zone_segs_in_sec(
 		struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
+	unsigned int dev_idx, zone_idx;
 
 	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
 	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
@@ -5087,18 +5087,12 @@ static inline unsigned int f2fs_usable_zone_segs_in_sec(
 	if (is_conv_zone(sbi, zone_idx, dev_idx))
 		return sbi->segs_per_sec;
 
-	/*
-	 * If the zone_capacity_blocks array is NULL, then zone capacity
-	 * is equal to the zone size for all zones
-	 */
-	if (!FDEV(dev_idx).zone_capacity_blocks)
+	if (!sbi->unusable_blocks_per_sec)
 		return sbi->segs_per_sec;
 
 	/* Get the segment count beyond zone capacity block */
-	unusable_segs_in_sec = (sbi->blocks_per_blkz -
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx]) >>
-				sbi->log_blocks_per_seg;
-	return sbi->segs_per_sec - unusable_segs_in_sec;
+	return sbi->segs_per_sec - (sbi->unusable_blocks_per_sec >>
+						sbi->log_blocks_per_seg);
 }
 
 /*
@@ -5127,12 +5121,11 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(
 	if (is_conv_zone(sbi, zone_idx, dev_idx))
 		return sbi->blocks_per_seg;
 
-	if (!FDEV(dev_idx).zone_capacity_blocks)
+	if (!sbi->unusable_blocks_per_sec)
 		return sbi->blocks_per_seg;
 
 	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-	sec_cap_blkaddr = sec_start_blkaddr +
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
+	sec_cap_blkaddr = sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
 
 	/*
 	 * If segment starts before zone capacity and spans beyond
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 957edb6d70d7b..9eb8364ac38c7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -101,6 +101,9 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
+#define CAP_BLKS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec * (sbi)->blocks_per_seg -		\
+	 (sbi)->unusable_blocks_per_sec)
 #define GET_SEC_FROM_SEG(sbi, segno)				\
 	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ae72211e422e7..4cc9b948139ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1515,7 +1515,6 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
-		kfree(FDEV(i).zone_capacity_blocks);
 #endif
 	}
 	kvfree(sbi->devs);
@@ -3631,24 +3630,29 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct f2fs_report_zones_args {
+	struct f2fs_sb_info *sbi;
 	struct f2fs_dev_info *dev;
-	bool zone_cap_mismatch;
 };
 
 static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
 	struct f2fs_report_zones_args *rz_args = data;
+	block_t unusable_blocks = (zone->len - zone->capacity) >>
+					F2FS_LOG_SECTORS_PER_BLOCK;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return 0;
 
 	set_bit(idx, rz_args->dev->blkz_seq);
-	rz_args->dev->zone_capacity_blocks[idx] = zone->capacity >>
-						F2FS_LOG_SECTORS_PER_BLOCK;
-	if (zone->len != zone->capacity && !rz_args->zone_cap_mismatch)
-		rz_args->zone_cap_mismatch = true;
-
+	if (!rz_args->sbi->unusable_blocks_per_sec) {
+		rz_args->sbi->unusable_blocks_per_sec = unusable_blocks;
+		return 0;
+	}
+	if (rz_args->sbi->unusable_blocks_per_sec != unusable_blocks) {
+		f2fs_err(rz_args->sbi, "F2FS supports single zone capacity\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -3682,26 +3686,13 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!FDEV(devi).blkz_seq)
 		return -ENOMEM;
 
-	/* Get block zones type and zone-capacity */
-	FDEV(devi).zone_capacity_blocks = f2fs_kzalloc(sbi,
-					FDEV(devi).nr_blkz * sizeof(block_t),
-					GFP_KERNEL);
-	if (!FDEV(devi).zone_capacity_blocks)
-		return -ENOMEM;
-
+	rep_zone_arg.sbi = sbi;
 	rep_zone_arg.dev = &FDEV(devi);
-	rep_zone_arg.zone_cap_mismatch = false;
 
 	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_cb,
 				  &rep_zone_arg);
 	if (ret < 0)
 		return ret;
-
-	if (!rep_zone_arg.zone_cap_mismatch) {
-		kfree(FDEV(devi).zone_capacity_blocks);
-		FDEV(devi).zone_capacity_blocks = NULL;
-	}
-
 	return 0;
 }
 #endif
-- 
2.39.2



