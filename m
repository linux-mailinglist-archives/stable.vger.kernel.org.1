Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB6713EE6
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjE1TkC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjE1TkB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528EB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E08FA61EA0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09751C433EF;
        Sun, 28 May 2023 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302799;
        bh=HYGronkBmM6Q51iGZWxw7XA7yrSq9r2duyuWRAfsOMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYicNzrxKrO3p0sHZiXhv18h6/yjWQB4w/EeBkDFEjVm/0FoMa8nZzAwTHkfL5q0F
         CaS75gVQWCj1Vh23ZZwQa3HbPc7mts1s0jcsQzEjCbv3j/A2+u+ratt9G73jKhTuWm
         JjYxrdQ6e8+gt6WhYczvcDcj0bAi6fK+JHP63jJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 023/211] ext4: dont clear SB_RDONLY when remounting r/w until quota is re-enabled
Date:   Sun, 28 May 2023 20:09:04 +0100
Message-Id: <20230528190844.097550661@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index edd1409663932..681efff3af50f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5797,6 +5797,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	ext4_group_t g;
 	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	int err = 0;
+	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -5989,7 +5990,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_opts;
 
-			sb->s_flags &= ~SB_RDONLY;
+			enable_rw = 1;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6048,6 +6049,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (enable_rw)
+		sb->s_flags &= ~SB_RDONLY;
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
-- 
2.39.2



