Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C17703827
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbjEOR1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbjEOR1c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E1914341
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE0C62CEB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B918DC433EF;
        Mon, 15 May 2023 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171579;
        bh=Sl9uHhQsKqr1GZzNJuE9C36hdrfw1GyfWUq3AnEfEj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVMwsXGIjmG6fmPTra2qnlQpoRwFkPpdW6OyAaymMQOdMOYe/plIE1s3zawT7j8ci
         OFBaNC0BBhGmPZvgO0qdhkTXCyqHk3kCx/vf81nS9kNyCmTfvlIuDpfNw4p9Df+gc8
         IhmZx1X/GTJkoqZXEWBs5YBiaABxGPbVdNj7ml+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 003/134] ubifs: Fix AA deadlock when setting xattr for encrypted file
Date:   Mon, 15 May 2023 18:28:00 +0200
Message-Id: <20230515161703.024684686@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit a0c51565730729f0df2ee886e34b4da6d359a10b ]

Following process:
vfs_setxattr(host)
  ubifs_xattr_set
    down_write(host_ui->xattr_sem)   <- lock first time
      create_xattr
        ubifs_new_inode(host)
          fscrypt_prepare_new_inode(host)
            fscrypt_policy_to_inherit(host)
              if (IS_ENCRYPTED(inode))
                fscrypt_require_key(host)
                  fscrypt_get_encryption_info(host)
                    ubifs_xattr_get(host)
                      down_read(host_ui->xattr_sem) <- AA deadlock

, which may trigger an AA deadlock problem:

[  102.620871] INFO: task setfattr:1599 blocked for more than 10 seconds.
[  102.625298]       Not tainted 5.19.0-rc7-00001-gb666b6823ce0-dirty #711
[  102.628732] task:setfattr        state:D stack:    0 pid: 1599
[  102.628749] Call Trace:
[  102.628753]  <TASK>
[  102.628776]  __schedule+0x482/0x1060
[  102.629964]  schedule+0x92/0x1a0
[  102.629976]  rwsem_down_read_slowpath+0x287/0x8c0
[  102.629996]  down_read+0x84/0x170
[  102.630585]  ubifs_xattr_get+0xd1/0x370 [ubifs]
[  102.630730]  ubifs_crypt_get_context+0x1f/0x30 [ubifs]
[  102.630791]  fscrypt_get_encryption_info+0x7d/0x1c0
[  102.630810]  fscrypt_policy_to_inherit+0x56/0xc0
[  102.630817]  fscrypt_prepare_new_inode+0x35/0x160
[  102.630830]  ubifs_new_inode+0xcc/0x4b0 [ubifs]
[  102.630873]  ubifs_xattr_set+0x591/0x9f0 [ubifs]
[  102.630961]  xattr_set+0x8c/0x3e0 [ubifs]
[  102.631003]  __vfs_setxattr+0x71/0xc0
[  102.631026]  vfs_setxattr+0x105/0x270
[  102.631034]  do_setxattr+0x6d/0x110
[  102.631041]  setxattr+0xa0/0xd0
[  102.631087]  __x64_sys_setxattr+0x2f/0x40

Fetch a reproducer in [Link].

Just like ext4 does, which skips encrypting for inode with
EXT4_EA_INODE_FL flag. Stop encypting xattr inode for ubifs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216260
Fixes: f4e3634a3b64222 ("ubifs: Fix races between xattr_{set|get} ...")
Fixes: d475a507457b5ca ("ubifs: Add skeleton for fscrypto")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Stable-dep-of: 3a36d20e0129 ("ubifs: Fix memory leak in do_rename")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ubifs/dir.c   | 25 ++++++++++++++-----------
 fs/ubifs/ubifs.h |  2 +-
 fs/ubifs/xattr.c |  2 +-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 7717d23906dbe..005566bc6dc13 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -68,13 +68,14 @@ static int inherit_flags(const struct inode *dir, umode_t mode)
  * @c: UBIFS file-system description object
  * @dir: parent directory inode
  * @mode: inode mode flags
+ * @is_xattr: whether the inode is xattr inode
  *
  * This function finds an unused inode number, allocates new inode and
  * initializes it. Returns new inode in case of success and an error code in
  * case of failure.
  */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode)
+			      umode_t mode, bool is_xattr)
 {
 	int err;
 	struct inode *inode;
@@ -99,10 +100,12 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			 current_time(inode);
 	inode->i_mapping->nrpages = 0;
 
-	err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
-	if (err) {
-		ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
-		goto out_iput;
+	if (!is_xattr) {
+		err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+		if (err) {
+			ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
+			goto out_iput;
+		}
 	}
 
 	switch (mode & S_IFMT) {
@@ -309,7 +312,7 @@ static int ubifs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
@@ -370,7 +373,7 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	if (err)
 		return ERR_PTR(err);
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_free;
@@ -462,7 +465,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		return err;
 	}
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_budg;
@@ -1005,7 +1008,7 @@ static int ubifs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFDIR | mode);
+	inode = ubifs_new_inode(c, dir, S_IFDIR | mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
@@ -1092,7 +1095,7 @@ static int ubifs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		kfree(dev);
 		err = PTR_ERR(inode);
@@ -1174,7 +1177,7 @@ static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO);
+	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index efbb4554a4a6f..398551bef5986 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2002,7 +2002,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 
 /* dir.c */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode);
+			      umode_t mode, bool is_xattr);
 int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int flags);
 int ubifs_check_dir_empty(struct inode *dir);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index e4f193eae4b2b..9ff2614bdeca0 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -110,7 +110,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	if (err)
 		return err;
 
-	inode = ubifs_new_inode(c, host, S_IFREG | S_IRWXUGO);
+	inode = ubifs_new_inode(c, host, S_IFREG | S_IRWXUGO, true);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_budg;
-- 
2.39.2



