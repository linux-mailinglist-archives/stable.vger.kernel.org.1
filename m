Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD82713CB5
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjE1TRy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjE1TRw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B10F3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3073761A1E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45860C433D2;
        Sun, 28 May 2023 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301463;
        bh=kjDxpS1S+ouR3A6pmDzptiANECN9+w6b76/64cl+HkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFzwVz2/Tbr83YO7oaTXEcrLsxPvJOphYYTKV5VJhSAY38tQEW/z7QNqtNS/QGfKs
         AztMv3OjIRK4DjReXHPXYkHGYnmAenphZa8WvwI3Af1IuvMMOPAt4+fYN67XwFkuxg
         47D6d8VpYZ6bzE3TH5YVXRuZX5PwcyySzHNuWabU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/132] ext2: Check block size validity during mount
Date:   Sun, 28 May 2023 20:09:21 +0100
Message-Id: <20230528190834.253367163@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 62aeb94433fcec80241754b70d0d1836d5926b0a ]

Check that log of block size stored in the superblock has sensible
value. Otherwise the shift computing the block size can overflow leading
to undefined behavior.

Reported-by: syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/ext2.h  | 1 +
 fs/ext2/super.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 00e759f051619..a203a5723e2c0 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -177,6 +177,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 44a1f356aca29..3349ce85d27cb 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -978,6 +978,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
+	if (le32_to_cpu(es->s_log_block_size) >
+	    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
+		ext2_msg(sb, KERN_ERR,
+			 "Invalid log block size: %u",
+			 le32_to_cpu(es->s_log_block_size));
+		goto failed_mount;
+	}
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
-- 
2.39.2



