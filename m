Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF3775DFF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjHILnF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjHILnE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209F1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E00D6370E
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E6FC433CC;
        Wed,  9 Aug 2023 11:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581379;
        bh=KhZ83DXOCagNtRJlacUwHiQG5v/fPI4ECKEnb/kB57I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuEa0MQgKrt43aRcI/pO8NSKdzJuuHvDyacLvNYS+p8LYNyBuH2tsNDyJ6v1LpDZN
         9zdbitbEqVn+pZioeVsevwTpf11j/zh71+rp2ysxw8+q2R8hd8938g1GOgujZJJQm2
         PNNX5lFGsGiZieb7swUgSnZ1yfwfn6ZvLPO6T8ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.10 182/201] ext2: Drop fragment support
Date:   Wed,  9 Aug 2023 12:43:04 +0200
Message-ID: <20230809103649.878676171@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
@@ -673,10 +673,9 @@ static int ext2_setup_super (struct supe
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
@@ -1014,14 +1013,7 @@ static int ext2_fill_super(struct super_
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
 
 	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
@@ -1047,11 +1039,10 @@ static int ext2_fill_super(struct super_
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
 
@@ -1061,12 +1052,6 @@ static int ext2_fill_super(struct super_
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


