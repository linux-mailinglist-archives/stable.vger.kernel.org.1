Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79C76AFDA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjHAJuo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjHAJu2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B9129
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75C8614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28D5C433C8;
        Tue,  1 Aug 2023 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883397;
        bh=TZp8bCNrRUv++puG26khQHyrJC4xEZzJqkpTRCepQYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+e1/Fe4o+av3ahLcUwaMNh5RUGlJ4YvBHeLjkaLt5CiVGRq/5VcJiDoGjlWuEQ5f
         la51RPVEaHWjt0vuEE3BZ4MnMqlSrTHyc0RZodMEle6IZD1rmfopUY2loX+FZTfqC/
         45ejKm0HpOvO8OP/rdL4XzncbhhqgR5XefGOwNs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 193/239] ksmbd: check if a mount point is crossed during path lookup
Date:   Tue,  1 Aug 2023 11:20:57 +0200
Message-ID: <20230801091932.663837174@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 2b57a4322b1b14348940744fdc02f9a86cbbdbeb upstream.

Since commit 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and
->d_name"), ksmbd can not lookup cross mount points. If last component is
a cross mount point during path lookup, check if it is crossed to follow it
down. And allow path lookup to cross a mount point when a crossmnt
parameter is set to 'yes' in smb.conf.

Cc: stable@vger.kernel.org
Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/ksmbd_netlink.h |    3 +-
 fs/smb/server/smb2pdu.c       |   27 +++++++++++--------
 fs/smb/server/vfs.c           |   58 +++++++++++++++++++++++-------------------
 fs/smb/server/vfs.h           |    4 +-
 4 files changed, 53 insertions(+), 39 deletions(-)

--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -352,7 +352,8 @@ enum KSMBD_TREE_CONN_STATUS {
 #define KSMBD_SHARE_FLAG_STREAMS		BIT(11)
 #define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	BIT(12)
 #define KSMBD_SHARE_FLAG_ACL_XATTR		BIT(13)
-#define KSMBD_SHARE_FLAG_UPDATE		BIT(14)
+#define KSMBD_SHARE_FLAG_UPDATE			BIT(14)
+#define KSMBD_SHARE_FLAG_CROSSMNT		BIT(15)
 
 /*
  * Tree connect request flags.
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2467,8 +2467,9 @@ static void smb2_update_xattrs(struct ks
 	}
 }
 
-static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
-		      int open_flags, umode_t posix_mode, bool is_dir)
+static int smb2_creat(struct ksmbd_work *work, struct path *parent_path,
+		      struct path *path, char *name, int open_flags,
+		      umode_t posix_mode, bool is_dir)
 {
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct ksmbd_share_config *share = tcon->share_conf;
@@ -2495,7 +2496,7 @@ static int smb2_creat(struct ksmbd_work
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, parent_path, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2565,7 +2566,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
 	struct smb2_create_rsp *rsp;
-	struct path path;
+	struct path path, parent_path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
@@ -2786,7 +2787,8 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
+					&parent_path, &path, 1);
 	if (!rc) {
 		file_present = true;
 
@@ -2908,7 +2910,8 @@ int smb2_open(struct ksmbd_work *work)
 
 	/*create file if not present */
 	if (!file_present) {
-		rc = smb2_creat(work, &path, name, open_flags, posix_mode,
+		rc = smb2_creat(work, &parent_path, &path, name, open_flags,
+				posix_mode,
 				req->CreateOptions & FILE_DIRECTORY_FILE_LE);
 		if (rc) {
 			if (rc == -ENOENT) {
@@ -3323,8 +3326,9 @@ int smb2_open(struct ksmbd_work *work)
 
 err_out:
 	if (file_present || created) {
-		inode_unlock(d_inode(path.dentry->d_parent));
-		dput(path.dentry);
+		inode_unlock(d_inode(parent_path.dentry));
+		path_put(&path);
+		path_put(&parent_path);
 	}
 	ksmbd_revert_fsids(work);
 err_out1:
@@ -5547,7 +5551,7 @@ static int smb2_create_link(struct ksmbd
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
-	struct path path;
+	struct path path, parent_path;
 	bool file_present = false;
 	int rc;
 
@@ -5577,7 +5581,7 @@ static int smb2_create_link(struct ksmbd
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
 	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
-					&path, 0);
+					&parent_path, &path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
@@ -5607,8 +5611,9 @@ static int smb2_create_link(struct ksmbd
 		rc = -EINVAL;
 out:
 	if (file_present) {
-		inode_unlock(d_inode(path.dentry->d_parent));
+		inode_unlock(d_inode(parent_path.dentry));
 		path_put(&path);
+		path_put(&parent_path);
 	}
 	if (!IS_ERR(link_name))
 		kfree(link_name);
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -63,13 +63,13 @@ int ksmbd_vfs_lock_parent(struct dentry
 
 static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 					char *pathname, unsigned int flags,
+					struct path *parent_path,
 					struct path *path)
 {
 	struct qstr last;
 	struct filename *filename;
 	struct path *root_share_path = &share_conf->vfs_path;
 	int err, type;
-	struct path parent_path;
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
@@ -84,7 +84,7 @@ static int ksmbd_vfs_path_lookup_locked(
 		return PTR_ERR(filename);
 
 	err = vfs_path_parent_lookup(filename, flags,
-				     &parent_path, &last, &type,
+				     parent_path, &last, &type,
 				     root_share_path);
 	if (err) {
 		putname(filename);
@@ -92,13 +92,13 @@ static int ksmbd_vfs_path_lookup_locked(
 	}
 
 	if (unlikely(type != LAST_NORM)) {
-		path_put(&parent_path);
+		path_put(parent_path);
 		putname(filename);
 		return -ENOENT;
 	}
 
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
 	if (IS_ERR(d))
 		goto err_out;
 
@@ -108,15 +108,22 @@ static int ksmbd_vfs_path_lookup_locked(
 	}
 
 	path->dentry = d;
-	path->mnt = share_conf->vfs_path.mnt;
-	path_put(&parent_path);
-	putname(filename);
+	path->mnt = mntget(parent_path->mnt);
+
+	if (test_share_config_flag(share_conf, KSMBD_SHARE_FLAG_CROSSMNT)) {
+		err = follow_down(path, 0);
+		if (err < 0) {
+			path_put(path);
+			goto err_out;
+		}
+	}
 
+	putname(filename);
 	return 0;
 
 err_out:
-	inode_unlock(parent_path.dentry->d_inode);
-	path_put(&parent_path);
+	inode_unlock(d_inode(parent_path->dentry));
+	path_put(parent_path);
 	putname(filename);
 	return -ENOENT;
 }
@@ -1198,14 +1205,14 @@ static int ksmbd_vfs_lookup_in_dir(const
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *path,
-			       bool caseless)
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
-	struct path parent_path;
 
-	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
+	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
+					   path);
 	if (!err)
 		return err;
 
@@ -1220,10 +1227,10 @@ int ksmbd_vfs_kern_path_locked(struct ks
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent_path = share_conf->vfs_path;
-		path_get(&parent_path);
+		*parent_path = share_conf->vfs_path;
+		path_get(parent_path);
 
-		while (d_can_lookup(parent_path.dentry)) {
+		while (d_can_lookup(parent_path->dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1232,7 +1239,7 @@ int ksmbd_vfs_kern_path_locked(struct ks
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
+			err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
 						      filename_len,
 						      work->conn->um);
 			if (err)
@@ -1249,8 +1256,8 @@ int ksmbd_vfs_kern_path_locked(struct ks
 				goto out2;
 			else if (is_last)
 				goto out1;
-			path_put(&parent_path);
-			parent_path = *path;
+			path_put(parent_path);
+			*parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
@@ -1258,16 +1265,17 @@ int ksmbd_vfs_kern_path_locked(struct ks
 
 		err = -EINVAL;
 out2:
-		path_put(&parent_path);
+		path_put(parent_path);
 out1:
 		kfree(filepath);
 	}
 
 	if (!err) {
-		err = ksmbd_vfs_lock_parent(parent_path.dentry, path->dentry);
-		if (err)
-			dput(path->dentry);
-		path_put(&parent_path);
+		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+		}
 	}
 	return err;
 }
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -115,8 +115,8 @@ int ksmbd_vfs_xattr_stream_name(char *st
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 			   const struct path *path, char *attr_name);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *path,
-			       bool caseless);
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,


