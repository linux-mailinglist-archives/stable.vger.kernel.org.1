Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE0D775AC5
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjHILL0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjHILLZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F7ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59DCF6237C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E9EC433C7;
        Wed,  9 Aug 2023 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579483;
        bh=euwBlSNnrv+lJCndowg+XL48O4JzGKtTJNyCutwPPqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egxLezirMwEtt3ef4upPPZC3Xrt7242MoJu/ztmjV8lqc3E1P86rVgAFFuctJOzYL
         la7l3jAC0UOunQcGfTJ1gaHOMGKsNrxr/vII1f3wowrB7DWyFzR8Qxf/KsY4AGGEDz
         EGR2sUkxZ+nu0JnGbIlw6nStVeekOC2/iUQ/6REs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 202/204] ext2: Drop fragment support
Date:   Wed,  9 Aug 2023 12:42:20 +0200
Message-ID: <20230809103649.264643195@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 404615d7f1dcd4cca200e9a7a9df3a1dcae1dd62 upstream.

Ext2 has fields in superblock reserved for subblock allocation support.
However that never landed. Drop the many years dead code.

Reported-by: syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext2/ext2.h  |   12 ------------
 fs/ext2/super.c |   23 ++++-------------------
 2 files changed, 4 insertions(+), 31 deletions(-)

--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -68,10 +68,7 @@ struct mb_cache;
  * second extended-fs super-block data in memory
  */
 struct ext2_sb_info {
-	unsigned long s_frag_size;	/* Size of a fragment in bytes */
-	unsigned long s_frags_per_block;/* Number of fragments per block */
 	unsigned long s_inodes_per_block;/* Number of inodes per block */
-	unsigned long s_frags_per_group;/* Number of fragments in a group */
 	unsigned long s_blocks_per_group;/* Number of blocks in a group */
 	unsigned long s_inodes_per_group;/* Number of inodes in a group */
 	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
@@ -186,15 +183,6 @@ static inline struct ext2_sb_info *EXT2_
 #define EXT2_FIRST_INO(s)		(EXT2_SB(s)->s_first_ino)
 
 /*
- * Macro-instructions used to manage fragments
- */
-#define EXT2_MIN_FRAG_SIZE		1024
-#define	EXT2_MAX_FRAG_SIZE		4096
-#define EXT2_MIN_FRAG_LOG_SIZE		  10
-#define EXT2_FRAG_SIZE(s)		(EXT2_SB(s)->s_frag_size)
-#define EXT2_FRAGS_PER_BLOCK(s)		(EXT2_SB(s)->s_frags_per_block)
-
-/*
  * Structure of a blocks group descriptor
  */
 struct ext2_group_desc
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -684,10 +684,9 @@ static int ext2_setup_super (struct supe
 		es->s_max_mnt_count = cpu_to_le16(EXT2_DFL_MAX_MNT_COUNT);
 	le16_add_cpu(&es->s_mnt_count, 1);
 	if (test_opt (sb, DEBUG))
-		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, fs=%lu, gc=%lu, "
+		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sbi->s_frag_size,
 			sbi->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
@@ -1024,14 +1023,7 @@ static int ext2_fill_super(struct super_
 		}
 	}
 
-	sbi->s_frag_size = EXT2_MIN_FRAG_SIZE <<
-				   le32_to_cpu(es->s_log_frag_size);
-	if (sbi->s_frag_size == 0)
-		goto cantfind_ext2;
-	sbi->s_frags_per_block = sb->s_blocksize / sbi->s_frag_size;
-
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
 	if (EXT2_INODE_SIZE(sb) == 0)
@@ -1059,11 +1051,10 @@ static int ext2_fill_super(struct super_
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sbi->s_frag_size) {
+	if (es->s_log_frag_size != es->s_log_block_size) {
 		ext2_msg(sb, KERN_ERR,
-			"error: fragsize %lu != blocksize %lu"
-			"(not supported yet)",
-			sbi->s_frag_size, sb->s_blocksize);
+			"error: fragsize log %u != blocksize log %u",
+			le32_to_cpu(es->s_log_frag_size), sb->s_blocksize_bits);
 		goto failed_mount;
 	}
 
@@ -1073,12 +1064,6 @@ static int ext2_fill_super(struct super_
 			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
-		ext2_msg(sb, KERN_ERR,
-			"error: #fragments per group too big: %lu",
-			sbi->s_frags_per_group);
-		goto failed_mount;
-	}
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,


