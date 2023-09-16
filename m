Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF237A2FF3
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjIPMTc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjIPMTS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:19:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B018E
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:19:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B6C433C7;
        Sat, 16 Sep 2023 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866753;
        bh=lmHAYJZxVGGE4vWs7G21X9TQMAzbWRW8x9ZMgV7qfaI=;
        h=Subject:To:Cc:From:Date:From;
        b=E93JhmjHVh8k7YVlsFGkzQ+TsNqoWsxfiqnBWxyBcKnutHqDL457JtaE89CO+KF+W
         HTfU3tW/AXkCsq8WUNvwvPjwpNne2hZts5a7aRbNJ7TM91Vp7Tv9phsbvB+xBunXRU
         dcV768OdiBoiDwP333CiCjWeR/XPMSY1O/I0Qm8A=
Subject: FAILED: patch "[PATCH] fuse: nlookup missing decrement in fuse_direntplus_link" failed to apply to 4.14-stable tree
To:     ruan.meisi@zte.com.cn, mszeredi@redhat.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:19:02 +0200
Message-ID: <2023091602-untapped-scapegoat-dd85@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x b8bd342d50cbf606666488488f9fea374aceb2d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091602-untapped-scapegoat-dd85@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

b8bd342d50cb ("fuse: nlookup missing decrement in fuse_direntplus_link")
d123d8e1833c ("fuse: split out readdir.c")
63576c13bd17 ("fuse: fix initial parallel dirops")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8bd342d50cbf606666488488f9fea374aceb2d5 Mon Sep 17 00:00:00 2001
From: ruanmeisi <ruan.meisi@zte.com.cn>
Date: Tue, 25 Apr 2023 19:13:54 +0800
Subject: [PATCH] fuse: nlookup missing decrement in fuse_direntplus_link

During our debugging of glusterfs, we found an Assertion failed error:
inode_lookup >= nlookup, which was caused by the nlookup value in the
kernel being greater than that in the FUSE file system.

The issue was introduced by fuse_direntplus_link, where in the function,
fuse_iget increments nlookup, and if d_splice_alias returns failure,
fuse_direntplus_link returns failure without decrementing nlookup
https://github.com/gluster/glusterfs/pull/4081

Signed-off-by: ruanmeisi <ruan.meisi@zte.com.cn>
Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
Cc: <stable@vger.kernel.org> # v3.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index dc603479b30e..b3d498163f97 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -243,8 +243,16 @@ static int fuse_direntplus_link(struct file *file,
 			dput(dentry);
 			dentry = alias;
 		}
-		if (IS_ERR(dentry))
+		if (IS_ERR(dentry)) {
+			if (!IS_ERR(inode)) {
+				struct fuse_inode *fi = get_fuse_inode(inode);
+
+				spin_lock(&fi->lock);
+				fi->nlookup--;
+				spin_unlock(&fi->lock);
+			}
 			return PTR_ERR(dentry);
+		}
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);

