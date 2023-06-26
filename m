Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE2D73E7E7
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjFZSUW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjFZSUU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453CE8
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C94260F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03057C433CA;
        Mon, 26 Jun 2023 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803616;
        bh=TK4PoJNx6Ck6/10yJL3WXjXIEER4/CB9T3uPXYEO5D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7sq3e1UWdvG9+ktRmRy5snelBEvF0PDYlTwqeqklc14IkdrA0rP2a2cqZXqmrYZZ
         ghSVqwbhgDho5kZcbpJU7srl+kvATPd5uB0IQ07bFA6qpq+SCZR6D9NCyqpwRP0aQE
         bX+rYrtPHsb8BOwD9mmExIrUUNbmOTqPJA5M8Sx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 094/199] ksmbd: add mnt_want_write to ksmbd vfs functions
Date:   Mon, 26 Jun 2023 20:10:00 +0200
Message-ID: <20230626180809.739741283@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 40b268d384a22276dca1450549f53eed60e21deb ]

ksmbd is doing write access using vfs helpers. There are the cases that
mnt_want_write() is not called in vfs helper. This patch add missing
mnt_want_write() to ksmbd vfs functions.

Cc: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c   |  26 ++++------
 fs/ksmbd/smbacl.c    |  10 ++--
 fs/ksmbd/vfs.c       | 117 ++++++++++++++++++++++++++++++++++---------
 fs/ksmbd/vfs.h       |  17 +++----
 fs/ksmbd/vfs_cache.c |   2 +-
 5 files changed, 117 insertions(+), 55 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 06a335356e373..1d365eb79c3ef 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2311,7 +2311,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* delete the EA only when it exits */
 			if (rc > 0) {
 				rc = ksmbd_vfs_remove_xattr(idmap,
-							    path->dentry,
+							    path,
 							    attr_name);
 
 				if (rc < 0) {
@@ -2325,8 +2325,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* if the EA doesn't exist, just do nothing. */
 			rc = 0;
 		} else {
-			rc = ksmbd_vfs_setxattr(idmap,
-						path->dentry, attr_name, value,
+			rc = ksmbd_vfs_setxattr(idmap, path, attr_name, value,
 						le16_to_cpu(eabuf->EaValueLength), 0);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
@@ -2383,8 +2382,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(idmap, path->dentry,
-				xattr_stream_name, NULL, 0, 0);
+	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
 	return 0;
@@ -2412,7 +2410,7 @@ static int smb2_remove_smb_xattrs(const struct path *path)
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
 		    !strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
 			     STREAM_PREFIX_LEN)) {
-			err = ksmbd_vfs_remove_xattr(idmap, path->dentry,
+			err = ksmbd_vfs_remove_xattr(idmap, path,
 						     name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n",
@@ -2459,8 +2457,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt),
-					    path->dentry, &da);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt), path, &da);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -3034,7 +3031,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct inode *inode = d_inode(path.dentry);
 
 		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(idmap,
-							   path.dentry,
+							   &path,
 							   d_inode(path.dentry->d_parent));
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
@@ -3050,7 +3047,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc) {
 				if (posix_acl_rc)
 					ksmbd_vfs_set_init_posix_acl(idmap,
-								     path.dentry);
+								     &path);
 
 				if (test_share_config_flag(work->tcon->share_conf,
 							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
@@ -3090,7 +3087,7 @@ int smb2_open(struct ksmbd_work *work)
 
 					rc = ksmbd_vfs_set_sd_xattr(conn,
 								    idmap,
-								    path.dentry,
+								    &path,
 								    pntsd,
 								    pntsd_size);
 					kfree(pntsd);
@@ -5526,7 +5523,7 @@ static int smb2_rename(struct ksmbd_work *work,
 			goto out;
 
 		rc = ksmbd_vfs_setxattr(file_mnt_idmap(fp->filp),
-					fp->filp->f_path.dentry,
+					&fp->filp->f_path,
 					xattr_stream_name,
 					NULL, 0, 0);
 		if (rc < 0) {
@@ -5691,8 +5688,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap,
-						    filp->f_path.dentry, &da);
+		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap, &filp->f_path, &da);
 		if (rc)
 			ksmbd_debug(SMB,
 				    "failed to restore file attribute in EA\n");
@@ -7547,7 +7543,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(idmap,
-						     fp->filp->f_path.dentry, &da);
+						     &fp->filp->f_path, &da);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 0a5862a61c773..ad919a4239d0a 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1162,8 +1162,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, idmap,
-				       path->dentry, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, pntsd_size);
 		kfree(pntsd);
 	}
 
@@ -1383,7 +1382,7 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	newattrs.ia_valid |= ATTR_MODE;
 	newattrs.ia_mode = (inode->i_mode & ~0777) | (fattr.cf_mode & 0777);
 
-	ksmbd_vfs_remove_acl_xattrs(idmap, path->dentry);
+	ksmbd_vfs_remove_acl_xattrs(idmap, path);
 	/* Update posix acls */
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && fattr.cf_dacls) {
 		rc = set_posix_acl(idmap, path->dentry,
@@ -1414,9 +1413,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
-		ksmbd_vfs_remove_sd_xattrs(idmap, path->dentry);
-		ksmbd_vfs_set_sd_xattr(conn, idmap,
-				       path->dentry, pntsd, ntsd_len);
+		ksmbd_vfs_remove_sd_xattrs(idmap, path);
+		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
 	}
 
 out:
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 448c442ad3f49..fb19deba58cd9 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -166,6 +166,10 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
+	err = mnt_want_write(path.mnt);
+	if (err)
+		goto out_err;
+
 	mode |= S_IFREG;
 	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
 			 dentry, mode, true);
@@ -175,6 +179,9 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	} else {
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
+	mnt_drop_write(path.mnt);
+
+out_err:
 	done_path_create(&path, dentry);
 	return err;
 }
@@ -205,30 +212,35 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
+	err = mnt_want_write(path.mnt);
+	if (err)
+		goto out_err2;
+
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
-	if (err) {
-		goto out;
-	} else if (d_unhashed(dentry)) {
+	if (!err && d_unhashed(dentry)) {
 		struct dentry *d;
 
 		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
 			       dentry->d_name.len);
 		if (IS_ERR(d)) {
 			err = PTR_ERR(d);
-			goto out;
+			goto out_err1;
 		}
 		if (unlikely(d_is_negative(d))) {
 			dput(d);
 			err = -ENOENT;
-			goto out;
+			goto out_err1;
 		}
 
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
 		dput(d);
 	}
-out:
+
+out_err1:
+	mnt_drop_write(path.mnt);
+out_err2:
 	done_path_create(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
@@ -439,7 +451,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	memcpy(&stream_buf[*pos], buf, count);
 
 	err = ksmbd_vfs_setxattr(idmap,
-				 fp->filp->f_path.dentry,
+				 &fp->filp->f_path,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
@@ -585,6 +597,10 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		goto out_err;
 	}
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		goto out_err;
+
 	idmap = mnt_idmap(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
 		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
@@ -595,6 +611,7 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		if (err)
 			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
+	mnt_drop_write(path->mnt);
 
 out_err:
 	ksmbd_revert_fsids(work);
@@ -640,11 +657,16 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 		goto out3;
 	}
 
+	err = mnt_want_write(newpath.mnt);
+	if (err)
+		goto out3;
+
 	err = vfs_link(oldpath.dentry, mnt_idmap(newpath.mnt),
 		       d_inode(newpath.dentry),
 		       dentry, NULL);
 	if (err)
 		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
+	mnt_drop_write(newpath.mnt);
 
 out3:
 	done_path_create(&newpath, dentry);
@@ -690,6 +712,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out2;
 	}
 
+	err = mnt_want_write(old_path->mnt);
+	if (err)
+		goto out2;
+
 	trap = lock_rename_child(old_child, new_path.dentry);
 
 	old_parent = dget(old_child->d_parent);
@@ -752,6 +778,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 out3:
 	dput(old_parent);
 	unlock_rename(old_parent, new_path.dentry);
+	mnt_drop_write(old_path->mnt);
 out2:
 	path_put(&new_path);
 
@@ -892,19 +919,24 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
-		       struct dentry *dentry, const char *attr_name,
+		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags)
 {
 	int err;
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
 	err = vfs_setxattr(idmap,
-			   dentry,
+			   path->dentry,
 			   attr_name,
 			   attr_value,
 			   attr_size,
 			   flags);
 	if (err)
 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
+	mnt_drop_write(path->mnt);
 	return err;
 }
 
@@ -1008,9 +1040,18 @@ int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 }
 
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
-			   struct dentry *dentry, char *attr_name)
+			   const struct path *path, char *attr_name)
 {
-	return vfs_removexattr(idmap, dentry, attr_name);
+	int err;
+
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
+	err = vfs_removexattr(idmap, path->dentry, attr_name);
+	mnt_drop_write(path->mnt);
+
+	return err;
 }
 
 int ksmbd_vfs_unlink(struct file *filp)
@@ -1019,6 +1060,10 @@ int ksmbd_vfs_unlink(struct file *filp)
 	struct dentry *dir, *dentry = filp->f_path.dentry;
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 
+	err = mnt_want_write(filp->f_path.mnt);
+	if (err)
+		return err;
+
 	dir = dget_parent(dentry);
 	err = ksmbd_vfs_lock_parent(dir, dentry);
 	if (err)
@@ -1036,6 +1081,7 @@ int ksmbd_vfs_unlink(struct file *filp)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
 out:
 	dput(dir);
+	mnt_drop_write(filp->f_path.mnt);
 
 	return err;
 }
@@ -1239,13 +1285,13 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 }
 
 int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
-				struct dentry *dentry)
+				const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1253,6 +1299,10 @@ int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 		goto out;
 	}
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		goto out;
+
 	for (name = xattr_list; name - xattr_list < xattr_list_len;
 	     name += strlen(name) + 1) {
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
@@ -1261,25 +1311,26 @@ int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
 		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
 			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
-			err = vfs_remove_acl(idmap, dentry, name);
+			err = vfs_remove_acl(idmap, path->dentry, name);
 			if (err)
 				ksmbd_debug(SMB,
 					    "remove acl xattr failed : %s\n", name);
 		}
 	}
+	mnt_drop_write(path->mnt);
+
 out:
 	kvfree(xattr_list);
 	return err;
 }
 
-int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
-			       struct dentry *dentry)
+int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap, const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1292,7 +1343,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
 		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
-			err = ksmbd_vfs_remove_xattr(idmap, dentry, name);
+			err = ksmbd_vfs_remove_xattr(idmap, path, name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
 		}
@@ -1369,13 +1420,14 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *id
 
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
-			   struct dentry *dentry,
+			   const struct path *path,
 			   struct smb_ntsd *pntsd, int len)
 {
 	int rc;
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
 	struct xattr_ntacl acl = {0};
 	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 
 	acl.version = 4;
@@ -1427,7 +1479,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	rc = ksmbd_vfs_setxattr(idmap, dentry,
+	rc = ksmbd_vfs_setxattr(idmap, path,
 				XATTR_NAME_SD, sd_ndr.data,
 				sd_ndr.offset, 0);
 	if (rc < 0)
@@ -1517,7 +1569,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 }
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry,
+				   const struct path *path,
 				   struct xattr_dos_attrib *da)
 {
 	struct ndr n;
@@ -1527,7 +1579,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	err = ksmbd_vfs_setxattr(idmap, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+	err = ksmbd_vfs_setxattr(idmap, path, XATTR_NAME_DOS_ATTRIBUTE,
 				 (void *)n.data, n.offset, 0);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
@@ -1764,10 +1816,11 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 }
 
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
-				 struct dentry *dentry)
+				 struct path *path)
 {
 	struct posix_acl_state acl_state;
 	struct posix_acl *acls;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 	int rc;
 
@@ -1797,6 +1850,11 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 		return -ENOMEM;
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
+
+	rc = mnt_want_write(path->mnt);
+	if (rc)
+		goto out_err;
+
 	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1808,16 +1866,20 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
+	mnt_drop_write(path->mnt);
+
+out_err:
 	free_acl_state(&acl_state);
 	posix_acl_release(acls);
 	return rc;
 }
 
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
-				struct dentry *dentry, struct inode *parent_inode)
+				struct path *path, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
 	struct posix_acl_entry *pace;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 	int rc, i;
 
@@ -1836,6 +1898,10 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 		}
 	}
 
+	rc = mnt_want_write(path->mnt);
+	if (rc)
+		goto out_err;
+
 	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1847,6 +1913,9 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
+	mnt_drop_write(path->mnt);
+
+out_err:
 	posix_acl_release(acls);
 	return rc;
 }
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index a4ae89f3230de..8c0931d4d5310 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -108,12 +108,12 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
-		       struct dentry *dentry, const char *attr_name,
+		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
-			   struct dentry *dentry, char *attr_name);
+			   const struct path *path, char *attr_name);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags, struct path *path,
 			       bool caseless);
@@ -139,26 +139,25 @@ void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
 void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
 int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
-				struct dentry *dentry);
-int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
-			       struct dentry *dentry);
+				const struct path *path);
+int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap, const struct path *path);
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
-			   struct dentry *dentry,
+			   const struct path *path,
 			   struct smb_ntsd *pntsd, int len);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
 int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry,
+				   const struct path *path,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
-				 struct dentry *dentry);
+				 struct path *path);
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
-				struct dentry *dentry,
+				struct path *path,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 2d0138e72d783..f41f8d6108ce9 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -252,7 +252,7 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
 		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
 		err = ksmbd_vfs_remove_xattr(file_mnt_idmap(filp),
-					     filp->f_path.dentry,
+					     &filp->f_path,
 					     fp->stream.name);
 		if (err)
 			pr_err("remove xattr failed : %s\n",
-- 
2.39.2



