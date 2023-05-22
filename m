Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289470C896
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjEVTkK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjEVTkC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3720B11A
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DC9629F1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA8CC433EF;
        Mon, 22 May 2023 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784397;
        bh=YqSv9tBf9Gzwzl+jYcsq1B3Xa5jimxbqgJeXbG9/8XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BN3/gAmpyeqxK8nfshmQfPuxLGcln2qKeG9knk/+xggANFSlvrQSp/2Tn39Y/lynf
         VaDkIXc0ZxX+Dt0UNd8IYskxZ/NxxP/yLu6/oP0msOQjkOVNypRR26HfAUONiBSfe7
         vqKoC7PWqtIacN5QwckkiCOfFFEallQs/tGjYe+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 037/364] ext4: dont clear SB_RDONLY when remounting r/w until quota is re-enabled
Date:   Mon, 22 May 2023 20:05:42 +0100
Message-Id: <20230522190413.761306075@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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
index 7b36089394175..7c45ab1dbd34e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6352,6 +6352,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
+	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6538,7 +6539,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			sb->s_flags &= ~SB_RDONLY;
+			enable_rw = 1;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6597,6 +6598,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (enable_rw)
+		sb->s_flags &= ~SB_RDONLY;
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
-- 
2.39.2



