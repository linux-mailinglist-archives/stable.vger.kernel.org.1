Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548F79BF12
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjIKVT6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbjIKNwP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:52:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6981FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:52:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F39C433C7;
        Mon, 11 Sep 2023 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440331;
        bh=UJ8H1wA8PBIzn8qU+H73b1C+Avn9y1S0i3TQ8+0RLMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W60X4Nff7PBskOHPgC5SUMoIRpmHqEYqtMtQAs7m2RtRF7wWyBWgLP3D1I68WqDnk
         hhrrV9Y7ybSWWGXh8vS5e8oRa8savRCEQ/MkiTofdN3NhVLNsV7/dPwfGlDGWYKq17
         RkS6HpA1nC2EfHGY0fnT86kQxqXjErCL9XISZCKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.5 008/739] Revert "f2fs: clean up w/ sbi->log_sectors_per_block"
Date:   Mon, 11 Sep 2023 15:36:47 +0200
Message-ID: <20230911134651.221827085@linuxfoundation.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 579c7e41507e85dc3eedf998a3dca14a2a1526ad upstream.

This reverts commit bfd476623999118d9c509cb0fa9380f2912bc225.

Shinichiro Kawasaki reported:

When I ran workloads on f2fs using v6.5-rcX with fixes [1][2] and a zoned block
devices with 4kb logical block size, I observe mount failure as follows. When
I revert this commit, the failure goes away.

[  167.781975][ T1555] F2FS-fs (dm-0): IO Block Size:        4 KB
[  167.890728][ T1555] F2FS-fs (dm-0): Found nat_bits in checkpoint
[  171.482588][ T1555] F2FS-fs (dm-0): Zone without valid block has non-zero write pointer. Reset the write pointer: wp[0x1300,0x8]
[  171.496000][ T1555] F2FS-fs (dm-0): (0) : Unaligned zone reset attempted (block 280000 + 80000)
[  171.505037][ T1555] F2FS-fs (dm-0): Discard zone failed:  (errno=-5)

The patch replaced "sbi->log_blocksize - SECTOR_SHIFT" with
"sbi->log_sectors_per_block". However, I think these two are not equal when the
device has 4k logical block size. The former uses Linux kernel sector size 512
byte. The latter use 512b sector size or 4kb sector size depending on the
device. mkfs.f2fs obtains logical block size via BLKSSZGET ioctl from the device
and reflects it to the value sbi->log_sector_size_per_block. This causes
unexpected write pointer calculations in check_zone_write_pointer(). This
resulted in unexpected zone reset and the mount failure.

[1] https://lkml.kernel.org/linux-f2fs-devel/20230711050101.GA19128@lst.de/
[2] https://lore.kernel.org/linux-f2fs-devel/20230804091556.2372567-1-shinichiro.kawasaki@wdc.com/

Cc: stable@vger.kernel.org
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: bfd476623999 ("f2fs: clean up w/ sbi->log_sectors_per_block")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0457d620011f..cbb4bd95ea19 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4846,17 +4846,17 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 {
 	unsigned int wp_segno, wp_blkoff, zone_secno, zone_segno, segno;
 	block_t zone_block, wp_block, last_valid_block;
+	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	int i, s, b, ret;
 	struct seg_entry *se;
 
 	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
-	wp_block = fdev->start_blk + (zone->wp >> sbi->log_sectors_per_block);
+	wp_block = fdev->start_blk + (zone->wp >> log_sectors_per_block);
 	wp_segno = GET_SEGNO(sbi, wp_block);
 	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-	zone_block = fdev->start_blk + (zone->start >>
-						sbi->log_sectors_per_block);
+	zone_block = fdev->start_blk + (zone->start >> log_sectors_per_block);
 	zone_segno = GET_SEGNO(sbi, zone_block);
 	zone_secno = GET_SEC_FROM_SEG(sbi, zone_segno);
 
@@ -4906,7 +4906,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 			    "pointer. Reset the write pointer: wp[0x%x,0x%x]",
 			    wp_segno, wp_blkoff);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
-				zone->len >> sbi->log_sectors_per_block);
+					zone->len >> log_sectors_per_block);
 		if (ret)
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 fdev->path, ret);
@@ -4967,6 +4967,7 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	struct blk_zone zone;
 	unsigned int cs_section, wp_segno, wp_blkoff, wp_sector_off;
 	block_t cs_zone_block, wp_block;
+	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	sector_t zone_sector;
 	int err;
 
@@ -4978,8 +4979,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 		return 0;
 
 	/* report zone for the sector the curseg points to */
-	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk) <<
-						sbi->log_sectors_per_block;
+	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk)
+		<< log_sectors_per_block;
 	err = blkdev_report_zones(zbd->bdev, zone_sector, 1,
 				  report_one_zone_cb, &zone);
 	if (err != 1) {
@@ -4991,10 +4992,10 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
-	wp_block = zbd->start_blk + (zone.wp >> sbi->log_sectors_per_block);
+	wp_block = zbd->start_blk + (zone.wp >> log_sectors_per_block);
 	wp_segno = GET_SEGNO(sbi, wp_block);
 	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-	wp_sector_off = zone.wp & GENMASK(sbi->log_sectors_per_block - 1, 0);
+	wp_sector_off = zone.wp & GENMASK(log_sectors_per_block - 1, 0);
 
 	if (cs->segno == wp_segno && cs->next_blkoff == wp_blkoff &&
 		wp_sector_off == 0)
@@ -5021,8 +5022,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	if (!zbd)
 		return 0;
 
-	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk) <<
-						sbi->log_sectors_per_block;
+	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk)
+		<< log_sectors_per_block;
 	err = blkdev_report_zones(zbd->bdev, zone_sector, 1,
 				  report_one_zone_cb, &zone);
 	if (err != 1) {
@@ -5040,7 +5041,7 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 			    "Reset the zone: curseg[0x%x,0x%x]",
 			    type, cs->segno, cs->next_blkoff);
 		err = __f2fs_issue_discard_zone(sbi, zbd->bdev,	cs_zone_block,
-					zone.len >> sbi->log_sectors_per_block);
+					zone.len >> log_sectors_per_block);
 		if (err) {
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 zbd->path, err);
-- 
2.42.0



