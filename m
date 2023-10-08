Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B67BCFDE
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 21:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbjJHToI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjJHToH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 15:44:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE2BAC
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 12:44:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E92CC433C7;
        Sun,  8 Oct 2023 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696794246;
        bh=3cZf1QIZU4JkwrzBomIq2eTcESEOwC5qcGCVzLwHyYI=;
        h=Subject:To:Cc:From:Date:From;
        b=FE2JnnG0hRR2cpdCqck4UTDeZGgYihrHDD67nf8zX1w+OmJpz4hNfSsNmkCkZIcEX
         17aWZhSjuqhM/c8AB/V90CJlmlBtN7vV5PdM+/3d6QDahm18uO+yzFUvNQjOQDjEat
         0kGpSvdJADLJpf/Krv+bOSj6kbBgDPRklaAUUHVw=
Subject: FAILED: patch "[PATCH] ksmbd: fix race condition with fp" failed to apply to 6.5-stable tree
To:     linkinjeon@kernel.org, rootlab@huawei.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 08 Oct 2023 21:43:54 +0200
Message-ID: <2023100854-usable-entree-9b37@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 5a7ee91d1154f35418367a6eaae74046fd06ed89
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100854-usable-entree-9b37@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

5a7ee91d1154 ("ksmbd: fix race condition with fp")
e2b76ab8b5c9 ("ksmbd: add support for read compound")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a7ee91d1154f35418367a6eaae74046fd06ed89 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Oct 2023 18:28:39 +0900
Subject: [PATCH] ksmbd: fix race condition with fp

fp can used in each command. If smb2_close command is coming at the
same time, UAF issue can happen by race condition.

                           Time
                            +
Thread A                    | Thread B1 B2 .... B5
smb2_open                   | smb2_close
                            |
 __open_id                  |
   insert fp to file_table  |
                            |
                            |   atomic_dec_and_test(&fp->refcount)
                            |   if fp->refcount == 0, free fp by kfree.
 // UAF!                    |
 use fp                     |
                            +
This patch add f_state not to use freed fp is used and not to free fp in
use.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 544022dd6d20..420e7691c8cf 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3370,8 +3370,10 @@ int smb2_open(struct ksmbd_work *work)
 	}
 	ksmbd_revert_fsids(work);
 err_out1:
-	if (!rc)
+	if (!rc) {
+		ksmbd_update_fstate(&work->sess->file_table, fp, FP_INITED);
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
+	}
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index f41f8d6108ce..c4b80ab7df74 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -333,6 +333,9 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 static struct ksmbd_file *ksmbd_fp_get(struct ksmbd_file *fp)
 {
+	if (fp->f_state != FP_INITED)
+		return NULL;
+
 	if (!atomic_inc_not_zero(&fp->refcount))
 		return NULL;
 	return fp;
@@ -382,15 +385,20 @@ int ksmbd_close_fd(struct ksmbd_work *work, u64 id)
 		return 0;
 
 	ft = &work->sess->file_table;
-	read_lock(&ft->lock);
+	write_lock(&ft->lock);
 	fp = idr_find(ft->idr, id);
 	if (fp) {
 		set_close_state_blocked_works(fp);
 
-		if (!atomic_dec_and_test(&fp->refcount))
+		if (fp->f_state != FP_INITED)
 			fp = NULL;
+		else {
+			fp->f_state = FP_CLOSED;
+			if (!atomic_dec_and_test(&fp->refcount))
+				fp = NULL;
+		}
 	}
-	read_unlock(&ft->lock);
+	write_unlock(&ft->lock);
 
 	if (!fp)
 		return -EINVAL;
@@ -570,6 +578,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	fp->tcon		= work->tcon;
 	fp->volatile_id		= KSMBD_NO_FID;
 	fp->persistent_id	= KSMBD_NO_FID;
+	fp->f_state		= FP_NEW;
 	fp->f_ci		= ksmbd_inode_get(fp);
 
 	if (!fp->f_ci) {
@@ -591,6 +600,14 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	return ERR_PTR(ret);
 }
 
+void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+			 unsigned int state)
+{
+	write_lock(&ft->lock);
+	fp->f_state = state;
+	write_unlock(&ft->lock);
+}
+
 static int
 __close_file_table_ids(struct ksmbd_file_table *ft,
 		       struct ksmbd_tree_connect *tcon,
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index fcb13413fa8d..03d0bf941216 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -60,6 +60,12 @@ struct ksmbd_inode {
 	__le32				m_fattr;
 };
 
+enum {
+	FP_NEW = 0,
+	FP_INITED,
+	FP_CLOSED
+};
+
 struct ksmbd_file {
 	struct file			*filp;
 	u64				persistent_id;
@@ -98,6 +104,7 @@ struct ksmbd_file {
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
+	unsigned int			f_state;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -142,6 +149,8 @@ int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
 int ksmbd_init_global_file_table(void);
 void ksmbd_free_global_file_table(void);
 void ksmbd_set_fd_limit(unsigned long limit);
+void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+			 unsigned int state);
 
 /*
  * INODE hash

