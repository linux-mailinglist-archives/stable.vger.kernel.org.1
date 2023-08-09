Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74F775BD3
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjHILV2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHILV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C51BFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C44631ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822EBC433C7;
        Wed,  9 Aug 2023 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580085;
        bh=8EcGk7ENve7WRkJljXSzc46TUW3A4zOel/+vao75dz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kG2XD8g2yjBCurnnF7FP5C5vkgI4vZeok0Pk5derlJLPGzmjjc6FkhwCeXdyjmxTZ
         jiPmorAWdOEOgcetXtWVwkEx7CjWULTlsH61RMD6HTlEykPQCkVt0tZl9expjzMTQD
         ENJAS1AXBTx3EMMkMBYIu+hA5Vw3iyXvuNRHmL3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunguang Xu <brookxu@tencent.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 222/323] ext4: rename journal_dev to s_journal_dev inside ext4_sb_info
Date:   Wed,  9 Aug 2023 12:41:00 +0200
Message-ID: <20230809103708.258473687@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

[ Upstream commit ee7ed3aa0f08621dbf897d2a98dc6f2c7e7d0335 ]

Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
the naming rules consistent with other variables, which is
convenient for code reading and writing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/1600916623-544-1-git-send-email-brookxu@tencent.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 26fb5290240d ("ext4: Fix reusing stale buffer heads from last failed mounting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  8 ++++----
 fs/ext4/super.c | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 19e2a52d1e5a1..909f231a387d7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1412,7 +1412,7 @@ struct ext4_sb_info {
 	unsigned long s_commit_interval;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
-	struct block_device *journal_bdev;
+	struct block_device *s_journal_bdev;
 #ifdef CONFIG_QUOTA
 	/* Names of quota files with journalled quota */
 	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 6b52ace1463c2..69c76327792e0 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -576,8 +576,8 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
 		return true;
-	if (EXT4_SB(sb)->journal_bdev &&
-	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->journal_bdev->bd_dev))
+	if (EXT4_SB(sb)->s_journal_bdev &&
+	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
 		return true;
 	return false;
 }
@@ -647,9 +647,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
 	handlers[0].gfd_fn = ext4_getfsmap_datadev;
-	if (EXT4_SB(sb)->journal_bdev) {
+	if (EXT4_SB(sb)->s_journal_bdev) {
 		handlers[1].gfd_dev = new_encode_dev(
-				EXT4_SB(sb)->journal_bdev->bd_dev);
+				EXT4_SB(sb)->s_journal_bdev->bd_dev);
 		handlers[1].gfd_fn = ext4_getfsmap_logdev;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ce5abd25eb99c..da7ca0b73e4b4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -905,10 +905,10 @@ static void ext4_blkdev_put(struct block_device *bdev)
 static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 {
 	struct block_device *bdev;
-	bdev = sbi->journal_bdev;
+	bdev = sbi->s_journal_bdev;
 	if (bdev) {
 		ext4_blkdev_put(bdev);
-		sbi->journal_bdev = NULL;
+		sbi->s_journal_bdev = NULL;
 	}
 }
 
@@ -1032,14 +1032,14 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->journal_bdev && sbi->journal_bdev != sb->s_bdev) {
+	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
-		sync_blockdev(sbi->journal_bdev);
-		invalidate_bdev(sbi->journal_bdev);
+		sync_blockdev(sbi->s_journal_bdev);
+		invalidate_bdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 	if (sbi->s_ea_inode_cache) {
@@ -3537,7 +3537,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -4848,7 +4848,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 			be32_to_cpu(journal->j_superblock->s_nr_users));
 		goto out_journal;
 	}
-	EXT4_SB(sb)->journal_bdev = bdev;
+	EXT4_SB(sb)->s_journal_bdev = bdev;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
-- 
2.39.2



