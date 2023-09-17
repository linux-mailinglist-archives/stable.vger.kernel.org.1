Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB127A3B25
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbjIQUN6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjIQUNj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8C21BB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71053C433CD;
        Sun, 17 Sep 2023 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981588;
        bh=5/SZgLsMvf+ShrBhYDUAid2l/X2OZbZZvgCMipiyxyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMFbXwuqpb4rrbsd/QX2KqPs1SMspLo9c0ZAxivOTWCHZznA7h81NWhOgBXTKBBiR
         /6WQ8vNc45tZbTH1aTE/nDp3dDKu7XQryyjNO4r+yCSKYGDpwtZer2tX8uMFOzj5Ul
         /gIYPSWAIfI8VNsdwzI7tN4gaMun9cY6OdqRhVkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Wang Jianjian <wangjianjian0@foxmail.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 144/219] ext4: add correct group descriptors and reserved GDT blocks to system zone
Date:   Sun, 17 Sep 2023 21:14:31 +0200
Message-ID: <20230917191046.211481649@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Jianjian <wangjianjian0@foxmail.com>

commit 68228da51c9a436872a4ef4b5a7692e29f7e5bc7 upstream.

When setup_system_zone, flex_bg is not initialized so it is always 1.
Use a new helper function, ext4_num_base_meta_blocks() which does not
depend on sbi->s_log_groups_per_flex being initialized.

[ Squashed two patches in the Link URL's below together into a single
  commit, which is simpler to review/understand.  Also fix checkpatch
  warnings. --TYT ]

Cc: stable@kernel.org
Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
Link: https://lore.kernel.org/r/tencent_21AF0D446A9916ED5C51492CC6C9A0A77B05@qq.com
Link: https://lore.kernel.org/r/tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/balloc.c         |   15 +++++++++++----
 fs/ext4/block_validity.c |    8 ++++----
 fs/ext4/ext4.h           |    2 ++
 3 files changed, 17 insertions(+), 8 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -910,11 +910,11 @@ unsigned long ext4_bg_num_gdb(struct sup
 }
 
 /*
- * This function returns the number of file system metadata clusters at
+ * This function returns the number of file system metadata blocks at
  * the beginning of a block group, including the reserved gdt blocks.
  */
-static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
-				     ext4_group_t block_group)
+unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
+				       ext4_group_t block_group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned num;
@@ -932,8 +932,15 @@ static unsigned ext4_num_base_meta_clust
 	} else { /* For META_BG_BLOCK_GROUPS */
 		num += ext4_bg_num_gdb(sb, block_group);
 	}
-	return EXT4_NUM_B2C(sbi, num);
+	return num;
 }
+
+static unsigned int ext4_num_base_meta_clusters(struct super_block *sb,
+						ext4_group_t block_group)
+{
+	return EXT4_NUM_B2C(EXT4_SB(sb), ext4_num_base_meta_blocks(sb, block_group));
+}
+
 /**
  *	ext4_inode_to_goal_block - return a hint for block allocation
  *	@inode: inode for block allocation
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -215,7 +215,6 @@ int ext4_setup_system_zone(struct super_
 	struct ext4_system_blocks *system_blks;
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
-	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -223,12 +222,13 @@ int ext4_setup_system_zone(struct super_
 		return -ENOMEM;
 
 	for (i=0; i < ngroups; i++) {
+		unsigned int meta_blks = ext4_num_base_meta_blocks(sb, i);
+
 		cond_resched();
-		if (ext4_bg_has_super(sb, i) &&
-		    ((i < 5) || ((i % flex_size) == 0))) {
+		if (meta_blks != 0) {
 			ret = add_system_zone(system_blks,
 					ext4_group_first_block_no(sb, i),
-					ext4_bg_num_gdb(sb, i) + 1, 0);
+					meta_blks, 0);
 			if (ret)
 				goto err;
 		}
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3096,6 +3096,8 @@ extern const char *ext4_decode_error(str
 extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
+extern unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
+					      ext4_group_t block_group);
 
 extern __printf(7, 8)
 void __ext4_error(struct super_block *, const char *, unsigned int, bool,


