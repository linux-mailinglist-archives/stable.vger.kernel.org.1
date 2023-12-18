Return-Path: <stable+bounces-7779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCE81763A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34001C2536F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0414FF9A;
	Mon, 18 Dec 2023 15:43:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D527609B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo505164a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914204; x=1703519004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lKbLU8nUv5PoP9OF8Jr8ib3Vw7a8wcdg2hlJ2VliSE=;
        b=IjjVOntnExs8Jkl3DI+uXDxPQHtnGT2KZKgPg7ybLGjezJq9H20pT2RkZ1HMmrbSvp
         gZb2CMAsllb2rMh9Rai0OgOp2Phb/01VYCgviNsZQaxC/Pdhgw+887U9eBtC66WG9rob
         zF713z3QzEsCYI/IVQsyGoTFGKcUvadh17HcVpLDWN/AMFImKT16HO0KTHJLzpt/4dUS
         soGRO0mpofvtJ6a4FOHonh0utlDPcNMQyRBpd4vdyxttnWPBLkZjfvpOB5P3YFM3x4qh
         oyDzIA+Rv2LMGOhmMNl4irhfeqEBjG64/qGWEkf14CB7Nf3ScP1qXNzHmu020JcPgRAQ
         Qu8w==
X-Gm-Message-State: AOJu0Yzo+cmFAfLT5QIxwGK5lpz3WiXH3bVdzZBzATjxpxYqVK62Fygk
	eEXv97I8cpl1sXQeIqqQlQk=
X-Google-Smtp-Source: AGHT+IFdt+nl6jqMJQH5kPPfM85lQYOL8WMmDx6yYBgzM5WUtgsaZbXqJndQ0yCZfhZAbbzfXVCL+w==
X-Received: by 2002:a17:90b:3ece:b0:286:b062:ab7 with SMTP id rm14-20020a17090b3ece00b00286b0620ab7mr7011300pjb.41.1702914204420;
        Mon, 18 Dec 2023 07:43:24 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:24 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 149/154] ksmbd: fix possible deadlock in smb2_open
Date: Tue, 19 Dec 2023 00:34:49 +0900
Message-Id: <20231218153454.8090-150-linkinjeon@kernel.org>
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

[ Upstream commit 864fb5d3716303a045c3ffb397f651bfd37bfb36 ]

[ 8743.393379] ======================================================
[ 8743.393385] WARNING: possible circular locking dependency detected
[ 8743.393391] 6.4.0-rc1+ #11 Tainted: G           OE
[ 8743.393397] ------------------------------------------------------
[ 8743.393402] kworker/0:2/12921 is trying to acquire lock:
[ 8743.393408] ffff888127a14460 (sb_writers#8){.+.+}-{0:0}, at: ksmbd_vfs_setxattr+0x3d/0xd0 [ksmbd]
[ 8743.393510]
               but task is already holding lock:
[ 8743.393515] ffff8880360d97f0 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: ksmbd_vfs_kern_path_locked+0x181/0x670 [ksmbd]
[ 8743.393618]
               which lock already depends on the new lock.

[ 8743.393623]
               the existing dependency chain (in reverse order) is:
[ 8743.393628]
               -> #1 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}:
[ 8743.393648]        down_write_nested+0x9a/0x1b0
[ 8743.393660]        filename_create+0x128/0x270
[ 8743.393670]        do_mkdirat+0xab/0x1f0
[ 8743.393680]        __x64_sys_mkdir+0x47/0x60
[ 8743.393690]        do_syscall_64+0x5d/0x90
[ 8743.393701]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 8743.393711]
               -> #0 (sb_writers#8){.+.+}-{0:0}:
[ 8743.393728]        __lock_acquire+0x2201/0x3b80
[ 8743.393737]        lock_acquire+0x18f/0x440
[ 8743.393746]        mnt_want_write+0x5f/0x240
[ 8743.393755]        ksmbd_vfs_setxattr+0x3d/0xd0 [ksmbd]
[ 8743.393839]        ksmbd_vfs_set_dos_attrib_xattr+0xcc/0x110 [ksmbd]
[ 8743.393924]        compat_ksmbd_vfs_set_dos_attrib_xattr+0x39/0x50 [ksmbd]
[ 8743.394010]        smb2_open+0x3432/0x3cc0 [ksmbd]
[ 8743.394099]        handle_ksmbd_work+0x2c9/0x7b0 [ksmbd]
[ 8743.394187]        process_one_work+0x65a/0xb30
[ 8743.394198]        worker_thread+0x2cf/0x700
[ 8743.394209]        kthread+0x1ad/0x1f0
[ 8743.394218]        ret_from_fork+0x29/0x50

This patch add mnt_want_write() above parent inode lock and remove
nested mnt_want_write calls in smb2_open().

Fixes: 40b268d384a2 ("ksmbd: add mnt_want_write to ksmbd vfs functions")
Cc: stable@vger.kernel.org
Reported-by: Marios Makassikis <mmakassikis@freebox.fr>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 47 +++++++++++++++-----------------
 fs/ksmbd/smbacl.c  |  7 +++--
 fs/ksmbd/smbacl.h  |  2 +-
 fs/ksmbd/vfs.c     | 68 ++++++++++++++++++++++++++++------------------
 fs/ksmbd/vfs.h     | 10 +++++--
 5 files changed, 75 insertions(+), 59 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8dad33251925..b0fc55bfe920 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2380,7 +2380,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			rc = 0;
 		} else {
 			rc = ksmbd_vfs_setxattr(user_ns, path, attr_name, value,
-						le16_to_cpu(eabuf->EaValueLength), 0);
+						le16_to_cpu(eabuf->EaValueLength),
+						0, true);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
 					    "ksmbd_vfs_setxattr is failed(%d)\n",
@@ -2443,7 +2444,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0);
+	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
 	return 0;
@@ -2518,7 +2519,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, false);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -2608,7 +2609,7 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 	    sizeof(struct create_sd_buf_req))
 		return -EINVAL;
 	return set_info_sec(work->conn, work->tcon, path, &sd_buf->ntsd,
-			    le32_to_cpu(sd_buf->ccontext.DataLength), true);
+			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
 }
 
 static void ksmbd_acls_fattr(struct smb_fattr *fattr,
@@ -3149,7 +3150,8 @@ int smb2_open(struct ksmbd_work *work)
 								    user_ns,
 								    &path,
 								    pntsd,
-								    pntsd_size);
+								    pntsd_size,
+								    false);
 					kfree(pntsd);
 					if (rc)
 						pr_err("failed to store ntacl in xattr : %d\n",
@@ -3225,12 +3227,6 @@ int smb2_open(struct ksmbd_work *work)
 	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
 		ksmbd_fd_set_delete_on_close(fp, file_info);
 
-	if (need_truncate) {
-		rc = smb2_create_truncate(&path);
-		if (rc)
-			goto err_out;
-	}
-
 	if (req->CreateContextsOffset) {
 		struct create_alloc_size_req *az_req;
 
@@ -3395,11 +3391,12 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created) {
-		inode_unlock(d_inode(parent_path.dentry));
-		path_put(&path);
-		path_put(&parent_path);
-	}
+	if (file_present || created)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
+	if (fp && need_truncate)
+		rc = smb2_create_truncate(&fp->filp->f_path);
+
 	ksmbd_revert_fsids(work);
 err_out1:
 	if (!rc) {
@@ -5537,7 +5534,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
 					&fp->filp->f_path,
 					xattr_stream_name,
-					NULL, 0, 0);
+					NULL, 0, 0, true);
 		if (rc < 0) {
 			pr_err("failed to store stream name in xattr: %d\n",
 			       rc);
@@ -5630,11 +5627,9 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc)
 		rc = -EINVAL;
 out:
-	if (file_present) {
-		inode_unlock(d_inode(parent_path.dentry));
-		path_put(&path);
-		path_put(&parent_path);
-	}
+	if (file_present)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
 	if (!IS_ERR(link_name))
 		kfree(link_name);
 	kfree(pathname);
@@ -5701,7 +5696,8 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns, &filp->f_path, &da);
+		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns, &filp->f_path, &da,
+				true);
 		if (rc)
 			ksmbd_debug(SMB,
 				    "failed to restore file attribute in EA\n");
@@ -6015,7 +6011,7 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 	fp->saccess |= FILE_SHARE_DELETE_LE;
 
 	return set_info_sec(fp->conn, fp->tcon, &fp->filp->f_path, pntsd,
-			buf_len, false);
+			buf_len, false, true);
 }
 
 /**
@@ -7584,7 +7580,8 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
-						     &fp->filp->f_path, &da);
+						     &fp->filp->f_path,
+						     &da, true);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index d7fd5a15dac4..9ace5027684d 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1183,7 +1183,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, pntsd_size, false);
 		kfree(pntsd);
 	}
 
@@ -1375,7 +1375,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check)
+		 bool type_check, bool get_write)
 {
 	int rc;
 	struct smb_fattr fattr = {{0}};
@@ -1435,7 +1435,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
 		ksmbd_vfs_remove_sd_xattrs(user_ns, path);
-		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, ntsd_len);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, ntsd_len,
+				get_write);
 	}
 
 out:
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index f06abf247445..17f81a510f23 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -207,7 +207,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check);
+		 bool type_check, bool get_write);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
 
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 84571bacadef..99fd29761bca 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -97,6 +97,13 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 		return -ENOENT;
 	}
 
+	err = mnt_want_write(parent_path->mnt);
+	if (err) {
+		path_put(parent_path);
+		putname(filename);
+		return -ENOENT;
+	}
+
 	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
 	if (IS_ERR(d))
@@ -123,6 +130,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 
 err_out:
 	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
 	path_put(parent_path);
 	putname(filename);
 	return -ENOENT;
@@ -451,7 +459,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
-				 0);
+				 0,
+				 true);
 	if (err < 0)
 		goto out;
 
@@ -593,10 +602,6 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		goto out_err;
 	}
 
-	err = mnt_want_write(path->mnt);
-	if (err)
-		goto out_err;
-
 	user_ns = mnt_user_ns(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
 		err = vfs_rmdir(user_ns, d_inode(parent), path->dentry);
@@ -607,7 +612,6 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		if (err)
 			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
-	mnt_drop_write(path->mnt);
 
 out_err:
 	ksmbd_revert_fsids(work);
@@ -907,18 +911,22 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value
  * @flags:	destination buffer length
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       const struct path *path, const char *attr_name,
-		       const void *attr_value, size_t attr_size, int flags)
+		       const void *attr_value, size_t attr_size, int flags,
+		       bool get_write)
 {
 	int err;
 
-	err = mnt_want_write(path->mnt);
-	if (err)
-		return err;
+	if (get_write == true) {
+		err = mnt_want_write(path->mnt);
+		if (err)
+			return err;
+	}
 
 	err = vfs_setxattr(user_ns,
 			   path->dentry,
@@ -928,7 +936,8 @@ int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 			   flags);
 	if (err)
 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
-	mnt_drop_write(path->mnt);
+	if (get_write == true)
+		mnt_drop_write(path->mnt);
 	return err;
 }
 
@@ -1254,6 +1263,13 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 	}
 
 	if (!err) {
+		err = mnt_want_write(parent_path->mnt);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+			return err;
+		}
+
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
 			path_put(path);
@@ -1263,6 +1279,14 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 	return err;
 }
 
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path)
+{
+	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
+	path_put(path);
+	path_put(parent_path);
+}
+
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -1412,7 +1436,8 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
 			   const struct path *path,
-			   struct smb_ntsd *pntsd, int len)
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write)
 {
 	int rc;
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
@@ -1472,7 +1497,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 
 	rc = ksmbd_vfs_setxattr(user_ns, path,
 				XATTR_NAME_SD, sd_ndr.data,
-				sd_ndr.offset, 0);
+				sd_ndr.offset, 0, get_write);
 	if (rc < 0)
 		pr_err("Failed to store XATTR ntacl :%d\n", rc);
 
@@ -1561,7 +1586,8 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 				   const struct path *path,
-				   struct xattr_dos_attrib *da)
+				   struct xattr_dos_attrib *da,
+				   bool get_write)
 {
 	struct ndr n;
 	int err;
@@ -1571,7 +1597,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 		return err;
 
 	err = ksmbd_vfs_setxattr(user_ns, path, XATTR_NAME_DOS_ATTRIBUTE,
-				 (void *)n.data, n.offset, 0);
+				 (void *)n.data, n.offset, 0, get_write);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
 	kfree(n.data);
@@ -1841,10 +1867,6 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
 
-	rc = mnt_want_write(path->mnt);
-	if (rc)
-		goto out_err;
-
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1857,9 +1879,7 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
-	mnt_drop_write(path->mnt);
 
-out_err:
 	free_acl_state(&acl_state);
 	posix_acl_release(acls);
 	return rc;
@@ -1888,10 +1908,6 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		}
 	}
 
-	rc = mnt_want_write(path->mnt);
-	if (rc)
-		goto out_err;
-
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1903,9 +1919,7 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
-	mnt_drop_write(path->mnt);
 
-out_err:
 	posix_acl_release(acls);
 	return rc;
 }
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 97804cb97f27..6d108cba7e0c 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -148,7 +148,8 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       const struct path *path, const char *attr_name,
-		       const void *attr_value, size_t attr_size, int flags);
+		       const void *attr_value, size_t attr_size, int flags,
+		       bool get_write);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
@@ -156,6 +157,7 @@ int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags, struct path *parent_path,
 			       struct path *path, bool caseless);
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -183,14 +185,16 @@ int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns, const struct path
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
 			   const struct path *path,
-			   struct smb_ntsd *pntsd, int len);
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 				   const struct path *path,
-				   struct xattr_dos_attrib *da);
+				   struct xattr_dos_attrib *da,
+				   bool get_write);
 int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
-- 
2.25.1


