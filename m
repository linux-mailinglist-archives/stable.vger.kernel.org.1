Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C836F8FA5
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEFHKf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHKf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EECE11567
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDAF612AC
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF72C4339B;
        Sat,  6 May 2023 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357033;
        bh=uO9lGNXHhh35p5iXip/jGEj4AqPyamvSXPBYcBfQBX4=;
        h=Subject:To:Cc:From:Date:From;
        b=a5B0+VyCUeG02Ex2ZIcsNvgKiC8jKMIMCee2MRMpzIqT+OxrnTgLQq/X6LIWxM9/D
         1cbups2/Y89KXaYTgQf4lDhRv/dC/F/zsp9Sj5iaDQUDaINST0mJ1q7sENi5vWm2xY
         aWUdufTP396G/tghGnlJI/1x990iAkY7H8pGYzhA=
Subject: FAILED: patch "[PATCH] ubifs: Fix memory leak in do_rename" failed to apply to 5.15-stable tree
To:     marten.lindahl@axis.com, chengzhihao1@huawei.com, richard@nod.at
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:55:07 +0900
Message-ID: <2023050607-arena-skimmer-cb9c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
git cherry-pick -x 3a36d20e012903f45714df2731261fdefac900cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050607-arena-skimmer-cb9c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

3a36d20e0129 ("ubifs: Fix memory leak in do_rename")
a0c515657307 ("ubifs: Fix AA deadlock when setting xattr for encrypted file")
278d9a243635 ("ubifs: Rename whiteout atomically")
afd427048047 ("ubifs: Fix deadlock in concurrent rename whiteout and inode writeback")
40a8f0d5e7b3 ("ubifs: rename_whiteout: Fix double free for whiteout_ui->data")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a36d20e012903f45714df2731261fdefac900cb Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Date: Thu, 30 Mar 2023 16:40:59 +0200
Subject: [PATCH] ubifs: Fix memory leak in do_rename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If renaming a file in an encrypted directory, function
fscrypt_setup_filename allocates memory for a file name. This name is
never used, and before returning to the caller the memory for it is not
freed.

When running kmemleak on it we see that it is registered as a leak. The
report below is triggered by a simple program 'rename' that renames a
file in an encrypted directory:

  unreferenced object 0xffff888101502840 (size 32):
    comm "rename", pid 9404, jiffies 4302582475 (age 435.735s)
    backtrace:
      __kmem_cache_alloc_node
      __kmalloc
      fscrypt_setup_filename
      do_rename
      ubifs_rename
      vfs_rename
      do_renameat2

To fix this we can remove the call to fscrypt_setup_filename as it's not
needed.

Fixes: 278d9a243635f26 ("ubifs: Rename whiteout atomically")
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 5f33dbad27f6..ef0499edc248 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -358,7 +358,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	umode_t mode = S_IFCHR | WHITEOUT_MODE;
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	struct fscrypt_name nm;
 
 	/*
 	 * Create an inode('nlink = 1') for whiteout without updating journal,
@@ -369,10 +368,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
 		dentry, mode, dir->i_ino);
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
-	if (err)
-		return ERR_PTR(err);
-
 	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -395,7 +390,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	make_bad_inode(inode);
 	iput(inode);
 out_free:
-	fscrypt_free_filename(&nm);
 	ubifs_err(c, "cannot create whiteout file, error %d", err);
 	return ERR_PTR(err);
 }

