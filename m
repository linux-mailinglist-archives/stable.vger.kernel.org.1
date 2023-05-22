Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA0870C6E2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjEVTXZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjEVTXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3B102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D618861B3C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE127C433D2;
        Mon, 22 May 2023 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783402;
        bh=+829/fCtlQQSmjp0EgcDJ0bnUz6OZLJ7w1Fc6kuvTng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiwsohfcYqAWL+i1LJL+VPfsYb/cIHGBAKeV1xQatHlFw8IFKRKs28b+FBUlq+p3d
         OQUAdDcytd+q9wwPuCFT9W1xYh+pqvcLOayasKzTkA/LSVRlPVjWAyNTxA4KQskIEw
         eJTEdh0I14lz7B3yuWOpA5j+HYLOc5hDy+kSXQqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/292] ext4: reflect error codes from ext4_multi_mount_protect() to its callers
Date:   Mon, 22 May 2023 20:06:29 +0100
Message-Id: <20230522190406.694649909@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 3b50d5018ed06a647bb26c44bb5ae74e59c903c7 ]

This will allow more fine-grained errno codes to be returned by the
mount system call.

Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mmp.c   |  9 ++++++++-
 fs/ext4/super.c | 16 +++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 23930ed3cbda6..24b3beddaf4ba 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -296,6 +296,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
 	    mmp_block >= ext4_blocks_count(es)) {
 		ext4_warning(sb, "Invalid MMP block in superblock");
+		retval = -EINVAL;
 		goto failed;
 	}
 
@@ -321,6 +322,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (seq == EXT4_MMP_SEQ_FSCK) {
 		dump_mmp_msg(sb, mmp, "fsck is running on the filesystem");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -334,6 +336,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount\n");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -344,6 +347,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -367,6 +371,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	 */
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -377,6 +382,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -396,6 +402,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
 			     sb->s_id);
+		retval = -ENOMEM;
 		goto failed;
 	}
 
@@ -403,5 +410,5 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 failed:
 	brelse(bh);
-	return 1;
+	return retval;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d542f068ca99f..b919f34bb35d6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5281,9 +5281,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			  ext4_has_feature_orphan_present(sb) ||
 			  ext4_has_feature_journal_needs_recovery(sb));
 
-	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
-		if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
+	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb)) {
+		err = ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block));
+		if (err)
 			goto failed_mount3a;
+	}
 
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
@@ -6524,12 +6526,12 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_opts;
 
 			sb->s_flags &= ~SB_RDONLY;
-			if (ext4_has_feature_mmp(sb))
-				if (ext4_multi_mount_protect(sb,
-						le64_to_cpu(es->s_mmp_block))) {
-					err = -EROFS;
+			if (ext4_has_feature_mmp(sb)) {
+				err = ext4_multi_mount_protect(sb,
+						le64_to_cpu(es->s_mmp_block));
+				if (err)
 					goto restore_opts;
-				}
+			}
 #ifdef CONFIG_QUOTA
 			enable_quota = 1;
 #endif
-- 
2.39.2



