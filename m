Return-Path: <stable+bounces-7732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716A817601
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707F9B22CCC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86C7206C;
	Mon, 18 Dec 2023 15:40:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C549885
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b4a73d3c7so1957956a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914052; x=1703518852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alNJ26DTiYlJZNIqEkJf4fna27vejaF0rnVyUjeqTQk=;
        b=siorGvUbnW8q4r43QTadReWc5bGRRM8Egr6wigMFzfOy900sfo21GJnOmv23VLaVrV
         wi+w5Qu465ihU2Xo1UAyePZaiYmtXoZJP8cCCPMcKzOPWYxTcpPSPXlpMn+iYd5pzCyc
         DhgXXDSdUC4HDLs+NCzlR1aDOqzAToEcJ7jMNmM4u6IBribnbSKl7NPnbjacwxxkSXPL
         H+ZxZZ1fnwM7Z2LSSdD1HEZF5T406+3XVIYe4bt7Zc+40WQuZNY7Zq8kEG0ZfvKtw+Qg
         Rbf8IPpFy5rEeA/DI75OSR2//YlN9BDnXnnXk0RWgOqK8g6ytXyOQueATPudjs881BrZ
         VqRw==
X-Gm-Message-State: AOJu0YxCp2Vm33dtli5ZrzgNbP/ZCZs+/k8wZOIHgZW0uwAaK41XDn5Y
	5KsEz7Bb1r4G7Qf2JyFT0o5W68vBqME=
X-Google-Smtp-Source: AGHT+IHgx/GmPsXdtAKr0I6oS9zEn58PeisyQ7EBTmnyLPdCsVfdWgAALyVMjgriIAlL9H+3kH16/Q==
X-Received: by 2002:a17:90b:4c42:b0:28b:8bc2:aa4b with SMTP id np2-20020a17090b4c4200b0028b8bc2aa4bmr961826pjb.24.1702914051871;
        Mon, 18 Dec 2023 07:40:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:51 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 103/154] ksmbd: add mnt_want_write to ksmbd vfs functions
Date: Tue, 19 Dec 2023 00:34:03 +0900
Message-Id: <20231218153454.8090-104-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 40b268d384a22276dca1450549f53eed60e21deb ]

ksmbd is doing write access using vfs helpers. There are the cases that
mnt_want_write() is not called in vfs helper. This patch add missing
mnt_want_write() to ksmbd vfs functions.

Cc: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c   |  26 +++++-----
 fs/ksmbd/smbacl.c    |  10 ++--
 fs/ksmbd/vfs.c       | 112 +++++++++++++++++++++++++++++++++----------
 fs/ksmbd/vfs.h       |  17 ++++---
 fs/ksmbd/vfs_cache.c |   2 +-
 5 files changed, 112 insertions(+), 55 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d25d3a046a7f..d6c9092ff230 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2284,7 +2284,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* delete the EA only when it exits */
 			if (rc > 0) {
 				rc = ksmbd_vfs_remove_xattr(user_ns,
-							    path->dentry,
+							    path,
 							    attr_name);
 
 				if (rc < 0) {
@@ -2298,8 +2298,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* if the EA doesn't exist, just do nothing. */
 			rc = 0;
 		} else {
-			rc = ksmbd_vfs_setxattr(user_ns,
-						path->dentry, attr_name, value,
+			rc = ksmbd_vfs_setxattr(user_ns, path, attr_name, value,
 						le16_to_cpu(eabuf->EaValueLength), 0);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
@@ -2363,8 +2362,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, path->dentry,
-				xattr_stream_name, NULL, 0, 0);
+	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
 	return 0;
@@ -2392,7 +2390,7 @@ static int smb2_remove_smb_xattrs(const struct path *path)
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
 		    !strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
 			     STREAM_PREFIX_LEN)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, path->dentry,
+			err = ksmbd_vfs_remove_xattr(user_ns, path,
 						     name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n",
@@ -2439,8 +2437,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt),
-					    path->dentry, &da);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -3011,7 +3008,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct inode *inode = d_inode(path.dentry);
 
 		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns,
-							   inode,
+							   &path,
 							   d_inode(path.dentry->d_parent));
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
@@ -3027,7 +3024,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc) {
 				if (posix_acl_rc)
 					ksmbd_vfs_set_init_posix_acl(user_ns,
-								     inode);
+								     &path);
 
 				if (test_share_config_flag(work->tcon->share_conf,
 							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
@@ -3067,7 +3064,7 @@ int smb2_open(struct ksmbd_work *work)
 
 					rc = ksmbd_vfs_set_sd_xattr(conn,
 								    user_ns,
-								    path.dentry,
+								    &path,
 								    pntsd,
 								    pntsd_size);
 					kfree(pntsd);
@@ -5506,7 +5503,7 @@ static int smb2_rename(struct ksmbd_work *work,
 			goto out;
 
 		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
-					fp->filp->f_path.dentry,
+					&fp->filp->f_path,
 					xattr_stream_name,
 					NULL, 0, 0);
 		if (rc < 0) {
@@ -5671,8 +5668,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
-						    filp->f_path.dentry, &da);
+		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns, &filp->f_path, &da);
 		if (rc)
 			ksmbd_debug(SMB,
 				    "failed to restore file attribute in EA\n");
@@ -7534,7 +7530,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
-						     fp->filp->f_path.dentry, &da);
+						     &fp->filp->f_path, &da);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 34db75af8c62..8fbcc6a8cef0 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1183,8 +1183,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, user_ns,
-				       path->dentry, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, pntsd_size);
 		kfree(pntsd);
 	}
 
@@ -1404,7 +1403,7 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	newattrs.ia_valid |= ATTR_MODE;
 	newattrs.ia_mode = (inode->i_mode & ~0777) | (fattr.cf_mode & 0777);
 
-	ksmbd_vfs_remove_acl_xattrs(user_ns, path->dentry);
+	ksmbd_vfs_remove_acl_xattrs(user_ns, path);
 	/* Update posix acls */
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && fattr.cf_dacls) {
 		rc = set_posix_acl(user_ns, inode,
@@ -1435,9 +1434,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
-		ksmbd_vfs_remove_sd_xattrs(user_ns, path->dentry);
-		ksmbd_vfs_set_sd_xattr(conn, user_ns,
-				       path->dentry, pntsd, ntsd_len);
+		ksmbd_vfs_remove_sd_xattrs(user_ns, path);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, ntsd_len);
 	}
 
 out:
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 97e723956fe8..e58fbbfda7b2 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -170,6 +170,10 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
+	err = mnt_want_write(path.mnt);
+	if (err)
+		goto out_err;
+
 	mode |= S_IFREG;
 	err = vfs_create(mnt_user_ns(path.mnt), d_inode(path.dentry),
 			 dentry, mode, true);
@@ -179,6 +183,9 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	} else {
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
+	mnt_drop_write(path.mnt);
+
+out_err:
 	done_path_create(&path, dentry);
 	return err;
 }
@@ -209,30 +216,35 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
+	err = mnt_want_write(path.mnt);
+	if (err)
+		goto out_err2;
+
 	user_ns = mnt_user_ns(path.mnt);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(user_ns, d_inode(path.dentry), dentry, mode);
-	if (err) {
-		goto out;
-	} else if (d_unhashed(dentry)) {
+	if (!err && d_unhashed(dentry)) {
 		struct dentry *d;
 
 		d = lookup_one(user_ns, dentry->d_name.name, dentry->d_parent,
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
@@ -443,7 +455,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	memcpy(&stream_buf[*pos], buf, count);
 
 	err = ksmbd_vfs_setxattr(user_ns,
-				 fp->filp->f_path.dentry,
+				 &fp->filp->f_path,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
@@ -589,6 +601,10 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		goto out_err;
 	}
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		goto out_err;
+
 	user_ns = mnt_user_ns(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
 		err = vfs_rmdir(user_ns, d_inode(parent), path->dentry);
@@ -599,6 +615,7 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		if (err)
 			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
+	mnt_drop_write(path->mnt);
 
 out_err:
 	ksmbd_revert_fsids(work);
@@ -644,11 +661,16 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 		goto out3;
 	}
 
+	err = mnt_want_write(newpath.mnt);
+	if (err)
+		goto out3;
+
 	err = vfs_link(oldpath.dentry, mnt_user_ns(newpath.mnt),
 		       d_inode(newpath.dentry),
 		       dentry, NULL);
 	if (err)
 		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
+	mnt_drop_write(newpath.mnt);
 
 out3:
 	done_path_create(&newpath, dentry);
@@ -694,6 +716,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out2;
 	}
 
+	err = mnt_want_write(old_path->mnt);
+	if (err)
+		goto out2;
+
 	trap = lock_rename_child(old_child, new_path.dentry);
 
 	old_parent = dget(old_child->d_parent);
@@ -757,6 +783,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 out3:
 	dput(old_parent);
 	unlock_rename(old_parent, new_path.dentry);
+	mnt_drop_write(old_path->mnt);
 out2:
 	path_put(&new_path);
 
@@ -897,19 +924,24 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
-		       struct dentry *dentry, const char *attr_name,
+		       const struct path *path, const char *attr_name,
 		       const void *attr_value, size_t attr_size, int flags)
 {
 	int err;
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
 	err = vfs_setxattr(user_ns,
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
 
@@ -1013,9 +1045,18 @@ int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 }
 
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
-			   struct dentry *dentry, char *attr_name)
+			   const struct path *path, char *attr_name)
 {
-	return vfs_removexattr(user_ns, dentry, attr_name);
+	int err;
+
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
+	err = vfs_removexattr(user_ns, path->dentry, attr_name);
+	mnt_drop_write(path->mnt);
+
+	return err;
 }
 
 int ksmbd_vfs_unlink(struct file *filp)
@@ -1024,6 +1065,10 @@ int ksmbd_vfs_unlink(struct file *filp)
 	struct dentry *dir, *dentry = filp->f_path.dentry;
 	struct user_namespace *user_ns = file_mnt_user_ns(filp);
 
+	err = mnt_want_write(filp->f_path.mnt);
+	if (err)
+		return err;
+
 	dir = dget_parent(dentry);
 	err = ksmbd_vfs_lock_parent(dir, dentry);
 	if (err)
@@ -1041,6 +1086,7 @@ int ksmbd_vfs_unlink(struct file *filp)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
 out:
 	dput(dir);
+	mnt_drop_write(filp->f_path.mnt);
 
 	return err;
 }
@@ -1246,13 +1292,13 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 }
 
 int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
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
@@ -1268,25 +1314,25 @@ int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
 			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
 		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
 			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			err = ksmbd_vfs_remove_xattr(user_ns, path, name);
 			if (err)
 				ksmbd_debug(SMB,
 					    "remove acl xattr failed : %s\n", name);
 		}
 	}
+
 out:
 	kvfree(xattr_list);
 	return err;
 }
 
-int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
-			       struct dentry *dentry)
+int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns, const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1299,7 +1345,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
 		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			err = ksmbd_vfs_remove_xattr(user_ns, path, name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
 		}
@@ -1376,13 +1422,14 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
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
@@ -1434,7 +1481,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, dentry,
+	rc = ksmbd_vfs_setxattr(user_ns, path,
 				XATTR_NAME_SD, sd_ndr.data,
 				sd_ndr.offset, 0);
 	if (rc < 0)
@@ -1524,7 +1571,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 }
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
-				   struct dentry *dentry,
+				   const struct path *path,
 				   struct xattr_dos_attrib *da)
 {
 	struct ndr n;
@@ -1534,7 +1581,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 	if (err)
 		return err;
 
-	err = ksmbd_vfs_setxattr(user_ns, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+	err = ksmbd_vfs_setxattr(user_ns, path, XATTR_NAME_DOS_ATTRIBUTE,
 				 (void *)n.data, n.offset, 0);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
@@ -1771,10 +1818,11 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 }
 
 int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
-				 struct inode *inode)
+				 struct path *path)
 {
 	struct posix_acl_state acl_state;
 	struct posix_acl *acls;
+	struct inode *inode = d_inode(path->dentry);
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
@@ -1803,6 +1851,11 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 		return -ENOMEM;
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
+
+	rc = mnt_want_write(path->mnt);
+	if (rc)
+		goto out_err;
+
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1815,16 +1868,20 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
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
 
 int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
-				struct inode *inode, struct inode *parent_inode)
+				struct path *path, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
 	struct posix_acl_entry *pace;
+	struct inode *inode = d_inode(path->dentry);
 	int rc, i;
 
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
@@ -1842,6 +1899,10 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		}
 	}
 
+	rc = mnt_want_write(path->mnt);
+	if (rc)
+		goto out_err;
+
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1853,6 +1914,9 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
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
index bd92b8a6edbe..adaf511dace1 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -147,12 +147,12 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
-		       struct dentry *dentry, const char *attr_name,
+		       const struct path *path, const char *attr_name,
 		       const void *attr_value, size_t attr_size, int flags);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
-			   struct dentry *dentry, char *attr_name);
+			   const struct path *path, char *attr_name);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags, struct path *path,
 			       bool caseless);
@@ -178,26 +178,25 @@ void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
 void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
 int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
-				struct dentry *dentry);
-int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
-			       struct dentry *dentry);
+				const struct path *path);
+int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns, const struct path *path);
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
-			   struct dentry *dentry,
+			   const struct path *path,
 			   struct smb_ntsd *pntsd, int len);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
-				   struct dentry *dentry,
+				   const struct path *path,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
-				 struct inode *inode);
+				 struct path *path);
 int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
-				struct inode *inode,
+				struct path *path,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index bafb34d4b5bb..94ad8fa07b46 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -251,7 +251,7 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
 		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
 		err = ksmbd_vfs_remove_xattr(file_mnt_user_ns(filp),
-					     filp->f_path.dentry,
+					     &filp->f_path,
 					     fp->stream.name);
 		if (err)
 			pr_err("remove xattr failed : %s\n",
-- 
2.25.1


