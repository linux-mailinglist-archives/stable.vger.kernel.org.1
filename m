Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29F7022C4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjEOEOU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEOEOQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF16E79
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D4C61207
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCCAC433EF;
        Mon, 15 May 2023 04:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684124053;
        bh=pMLqXCWMe7ju+XVwQ5K5uoQXmV3twranaxwyIGEeZGo=;
        h=Subject:To:Cc:From:Date:From;
        b=nayhOHOqI4y4tuz2eW1A7QLuFm1qMFTra4fm6UbR6+FoH7vxuMKjPLKCBbVWq/+Gv
         FjToIx6bT44HKbL0AlwIc+0sYBmr8VSRRe3fKlyJNTepPXfGZjqgrwnVnsjWX5OUbw
         T7OkNQd/fj6sVY4Pg1Hk0LA52DSDtsICm2woLy0Y=
Subject: FAILED: patch "[PATCH] ext4: don't clear SB_RDONLY when remounting r/w until quota" failed to apply to 4.14-stable tree
To:     tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 15 May 2023 06:13:55 +0200
Message-ID: <2023051555-reiterate-strainer-a247@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x a44be64bbecb15a452496f60db6eacfee2b59c79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051555-reiterate-strainer-a247@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")
3b50d5018ed0 ("ext4: reflect error codes from ext4_multi_mount_protect() to its callers")
3bbef91bdd21 ("ext4: remove an unused variable warning with CONFIG_QUOTA=n")
61bb4a1c417e ("ext4: fix possible UAF when remounting r/o a mmp-protected file system")
618f003199c6 ("ext4: fix memory leak in ext4_fill_super")
2a4ae3bcdf05 ("ext4: fix timer use-after-free on failed mount")
c92dc856848f ("ext4: defer saving error info from atomic context")
02a7780e4d2f ("ext4: simplify ext4 error translation")
4067662388f9 ("ext4: move functions in super.c")
014c9caa29d3 ("ext4: make ext4_abort() use __ext4_error()")
b08070eca9e2 ("ext4: don't remount read-only with errors=continue on reboot")
9b5f6c9b83d9 ("ext4: make s_mount_flags modifications atomic")
f8f4acb6cded ("ext4: use generic casefolding support")
ababea77bc50 ("ext4: use s_mount_flags instead of s_mount_state for fast commit state")
8016e29f4362 ("ext4: fast commit recovery path")
5b849b5f96b4 ("jbd2: fast commit recovery path")
aa75f4d3daae ("ext4: main fast-commit commit path")
ff780b91efe9 ("jbd2: add fast commit machinery")
6866d7b3f2bb ("ext4 / jbd2: add fast commit initialization")
995a3ed67fc8 ("ext4: add fast_commit feature and handling for extended mount options")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a44be64bbecb15a452496f60db6eacfee2b59c79 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 5 May 2023 21:02:30 -0400
Subject: [PATCH] ext4: don't clear SB_RDONLY when remounting r/w until quota
 is re-enabled

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

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 425b95a7a0ab..c7bc4a2709cc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6387,6 +6387,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
+	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6573,7 +6574,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			sb->s_flags &= ~SB_RDONLY;
+			enable_rw = 1;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6632,6 +6633,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (enable_rw)
+		sb->s_flags &= ~SB_RDONLY;
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 

