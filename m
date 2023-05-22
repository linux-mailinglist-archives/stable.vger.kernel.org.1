Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439970C6E4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjEVTXm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjEVTXj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7012B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E780D617C7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D48C433EF;
        Mon, 22 May 2023 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783405;
        bh=gap071EMed19P+6YOtoDGyRSVmIA54rjXTKvuFLNEKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5KqIC6jdKyyI6ILsjMnrJn/ZHQkIvtND6ZdG99ixeF6s56zOtA15y89mRu9m8MT4
         eszfIfVbuG92HgH0nVl3ZqfN3IXGt+EkjSKTOCq7j4Zq3olPFLwP1wO2VC42kvVec5
         Hy+HCd9doGbFI8YUP+OaCvgUFd1gxkVynOSOVUTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/292] ext4: dont clear SB_RDONLY when remounting r/w until quota is re-enabled
Date:   Mon, 22 May 2023 20:06:30 +0100
Message-Id: <20230522190406.719343119@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit a44be64bbecb15a452496f60db6eacfee2b59c79 ]

When a file system currently mounted read/only is remounted
read/write, if we clear the SB_RDONLY flag too early, before the quota
is initialized, and there is another process/thread constantly
attempting to create a directory, it's possible to trigger the

	WARN_ON_ONCE(dquot_initialize_needed(inode));

in ext4_xattr_block_set(), with the following stack trace:

   WARNING: CPU: 0 PID: 5338 at fs/ext4/xattr.c:2141 ext4_xattr_block_set+0x2ef2/0x3680
   RIP: 0010:ext4_xattr_block_set+0x2ef2/0x3680 fs/ext4/xattr.c:2141
   Call Trace:
    ext4_xattr_set_handle+0xcd4/0x15c0 fs/ext4/xattr.c:2458
    ext4_initxattrs+0xa3/0x110 fs/ext4/xattr_security.c:44
    security_inode_init_security+0x2df/0x3f0 security/security.c:1147
    __ext4_new_inode+0x347e/0x43d0 fs/ext4/ialloc.c:1324
    ext4_mkdir+0x425/0xce0 fs/ext4/namei.c:2992
    vfs_mkdir+0x29d/0x450 fs/namei.c:4038
    do_mkdirat+0x264/0x520 fs/namei.c:4061
    __do_sys_mkdirat fs/namei.c:4076 [inline]
    __se_sys_mkdirat fs/namei.c:4074 [inline]
    __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4074

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230506142419.984260-1-tytso@mit.edu
Reported-by: syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=6513f6cb5cd6b5fc9f37e3bb70d273b94be9c34c
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b919f34bb35d6..c56192a84bf41 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6339,6 +6339,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
+	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6525,7 +6526,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			sb->s_flags &= ~SB_RDONLY;
+			enable_rw = 1;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6584,6 +6585,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (enable_rw)
+		sb->s_flags &= ~SB_RDONLY;
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
-- 
2.39.2



