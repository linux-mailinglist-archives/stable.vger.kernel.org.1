Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8770C6FADCD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjEHLic (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjEHLiD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30833EF80
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C076E63364
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E9BC433EF;
        Mon,  8 May 2023 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545845;
        bh=fwGLVjjir2sHo/dyJeciOimNyAil+8gsVlrWwdNitdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lK+KFehXb9Kcb8QujhG4JIZSVaN2EJFTwhASZxunrofIue4ucvzI666rvURUfrdf6
         U9+QSzMgdMMKQCQQFx4Y6410bPLKNr9rd6UlnDMZAVa2FfsxRxsiWoOzZQsncwDLx+
         3L2KHvxLrnifZvA/bJSc31aVcuPSlDzeVuqSYxl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 173/371] f2fs: apply zone capacity to all zone type
Date:   Mon,  8 May 2023 11:46:14 +0200
Message-Id: <20230508094818.997044351@linuxfoundation.org>
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

[ Upstream commit 0b37ed21e3367539b79284e0b0af2246ffcf0dca ]

If we manage the zone capacity per zone type, it'll break the GC assumption.
And, the current logic complains valid block count mismatch.
Let's apply zone capacity to all zone type, if specified.

Fixes: de881df97768 ("f2fs: support zone capacity less than zone size")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 65 +++--------------------------------------------
 fs/f2fs/segment.h |  3 +++
 2 files changed, 7 insertions(+), 61 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 880447750caf4..79ad696cddec0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5053,48 +5053,6 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_idx,
-						unsigned int dev_idx)
-{
-	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
-		return true;
-	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq);
-}
-
-/* Return the zone index in the given device */
-static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
-					int dev_idx)
-{
-	block_t sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-
-	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
-						sbi->log_blocks_per_blkz;
-}
-
-/*
- * Return the usable segments in a section based on the zone's
- * corresponding zone capacity. Zone is equal to a section.
- */
-static inline unsigned int f2fs_usable_zone_segs_in_sec(
-		struct f2fs_sb_info *sbi, unsigned int segno)
-{
-	unsigned int dev_idx, zone_idx;
-
-	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
-	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
-
-	/* Conventional zone's capacity is always equal to zone size */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->segs_per_sec;
-
-	if (!sbi->unusable_blocks_per_sec)
-		return sbi->segs_per_sec;
-
-	/* Get the segment count beyond zone capacity block */
-	return sbi->segs_per_sec - (sbi->unusable_blocks_per_sec >>
-						sbi->log_blocks_per_seg);
-}
-
 /*
  * Return the number of usable blocks in a segment. The number of blocks
  * returned is always equal to the number of blocks in a segment for
@@ -5107,23 +5065,13 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(
 			struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
-	unsigned int zone_idx, dev_idx, secno;
-
-	secno = GET_SEC_FROM_SEG(sbi, segno);
-	seg_start = START_BLOCK(sbi, segno);
-	dev_idx = f2fs_target_device_index(sbi, seg_start);
-	zone_idx = get_zone_idx(sbi, secno, dev_idx);
-
-	/*
-	 * Conventional zone's capacity is always equal to zone size,
-	 * so, blocks per segment is unchanged.
-	 */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->blocks_per_seg;
+	unsigned int secno;
 
 	if (!sbi->unusable_blocks_per_sec)
 		return sbi->blocks_per_seg;
 
+	secno = GET_SEC_FROM_SEG(sbi, segno);
+	seg_start = START_BLOCK(sbi, segno);
 	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
 	sec_cap_blkaddr = sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
 
@@ -5157,11 +5105,6 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb_info *sbi
 	return 0;
 }
 
-static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb_info *sbi,
-							unsigned int segno)
-{
-	return 0;
-}
 #endif
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 					unsigned int segno)
@@ -5176,7 +5119,7 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
 	if (f2fs_sb_has_blkzoned(sbi))
-		return f2fs_usable_zone_segs_in_sec(sbi, segno);
+		return CAP_SEGS_PER_SEC(sbi);
 
 	return sbi->segs_per_sec;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 9eb8364ac38c7..04f448ddf49ea 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -104,6 +104,9 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define CAP_BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg -		\
 	 (sbi)->unusable_blocks_per_sec)
+#define CAP_SEGS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec - ((sbi)->unusable_blocks_per_sec >>\
+	(sbi)->log_blocks_per_seg))
 #define GET_SEC_FROM_SEG(sbi, segno)				\
 	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
-- 
2.39.2



