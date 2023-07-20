Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C175B693
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGTSWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGTSWl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D0270C
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4729C61BBC
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F45C433CB;
        Thu, 20 Jul 2023 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689877359;
        bh=Nwr8nBCqqMsNMWOJUyV9ZX9XyLyDad3M7zXZ5TPKtXY=;
        h=Subject:To:Cc:From:Date:From;
        b=RbSwf8NNDbN3Qt8JEWwK8kBdWr97QLYRp4kp9xnwn7uEIWsVU0LO5J1Mafo2uluk0
         YKdTc3Uu9K5m29XvvOVnnHZ/ui5e9q+EMGepyXYrkskD7pmOqy0XHpE8UGdvGHEcqJ
         6VAT4Oe4K+nm+YzOhvbOAfq+K0m7GjV5NyEebedw=
Subject: FAILED: patch "[PATCH] f2fs: fix deadlock in i_xattr_sem and inode page lock" failed to apply to 5.15-stable tree
To:     jaegeuk@kernel.org, chao@kernel.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 20 Jul 2023 20:22:36 +0200
Message-ID: <2023072036-graded-regain-7c90@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5eda1ad1aaffdfebdecf7a164e586060a210f74f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072036-graded-regain-7c90@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5eda1ad1aaff ("f2fs: fix deadlock in i_xattr_sem and inode page lock")
e4544b63a7ee ("f2fs: move f2fs to use reader-unfair rwsems")
3e0203893e0d ("f2fs: support fault injection to f2fs_trylock_op()")
a9419b63bf41 ("f2fs: do not bother checkpoint by f2fs_get_node_info")
0df035c7208c ("f2fs: avoid down_write on nat_tree_lock during checkpoint")
a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
ccf7cf92373d ("f2fs: fix the f2fs_file_write_iter tracepoint")
d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
b31bf0f96e71 ("f2fs: reduce indentation in f2fs_file_write_iter()")
3d697a4a6b7d ("f2fs: rework write preallocations")
5664896ba29e ("Merge tag 'f2fs-for-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5eda1ad1aaffdfebdecf7a164e586060a210f74f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 28 Jun 2023 01:00:56 -0700
Subject: [PATCH] f2fs: fix deadlock in i_xattr_sem and inode page lock

Thread #1:

[122554.641906][   T92]  f2fs_getxattr+0xd4/0x5fc
    -> waiting for f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);

[122554.641927][   T92]  __f2fs_get_acl+0x50/0x284
[122554.641948][   T92]  f2fs_init_acl+0x84/0x54c
[122554.641969][   T92]  f2fs_init_inode_metadata+0x460/0x5f0
[122554.641990][   T92]  f2fs_add_inline_entry+0x11c/0x350
    -> Locked dir->inode_page by f2fs_get_node_page()

[122554.642009][   T92]  f2fs_do_add_link+0x100/0x1e4
[122554.642025][   T92]  f2fs_create+0xf4/0x22c
[122554.642047][   T92]  vfs_create+0x130/0x1f4

Thread #2:

[123996.386358][   T92]  __get_node_page+0x8c/0x504
    -> waiting for dir->inode_page lock

[123996.386383][   T92]  read_all_xattrs+0x11c/0x1f4
[123996.386405][   T92]  __f2fs_setxattr+0xcc/0x528
[123996.386424][   T92]  f2fs_setxattr+0x158/0x1f4
    -> f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);

[123996.386443][   T92]  __f2fs_set_acl+0x328/0x430
[123996.386618][   T92]  f2fs_set_acl+0x38/0x50
[123996.386642][   T92]  posix_acl_chmod+0xc8/0x1c8
[123996.386669][   T92]  f2fs_setattr+0x5e0/0x6bc
[123996.386689][   T92]  notify_change+0x4d8/0x580
[123996.386717][   T92]  chmod_common+0xd8/0x184
[123996.386748][   T92]  do_fchmodat+0x60/0x124
[123996.386766][   T92]  __arm64_sys_fchmodat+0x28/0x3c

Cc: <stable@vger.kernel.org>
Fixes: 27161f13e3c3 "f2fs: avoid race in between read xattr & write xattr"
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 887e55988450..d635c58cf5a3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -775,8 +775,15 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
 {
 	int err = -EAGAIN;
 
-	if (f2fs_has_inline_dentry(dir))
+	if (f2fs_has_inline_dentry(dir)) {
+		/*
+		 * Should get i_xattr_sem to keep the lock order:
+		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
+		 */
+		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
 		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
+		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
+	}
 	if (err == -EAGAIN)
 		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 213805d3592c..476b186b90a6 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -528,10 +528,12 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
+	if (!ipage)
+		f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
 				&entry, &base_addr, &base_size, &is_inline);
-	f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
+	if (!ipage)
+		f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
 

