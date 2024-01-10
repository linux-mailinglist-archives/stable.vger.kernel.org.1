Return-Path: <stable+bounces-9333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B38231DF
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1969E1C22872
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75421BDF1;
	Wed,  3 Jan 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n8pu+C22"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C621B29F;
	Wed,  3 Jan 2024 16:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8C2C433C8;
	Wed,  3 Jan 2024 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301189;
	bh=TrVYOElkSc98xsLmDKIAZOqTfIjs6FH6/DUQGNJ2Pjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8pu+C22y0O+sd8f7+RhvlMdbYvVDwlscqFGHOD329zXL1hGnDpzz7p3sBAShoUpu
	 pDV/L9HxvvG8ME4FVt/uN8eNTdSrAaD/6dp69rF5iTMFWxwhRWNb7H+dkpBHgT99zR
	 D4pO1Nj/eLj9DBnWPPaGJ7w48mXPH+xERB4DI+Jw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/100] ksmbd: fix possible deadlock in smb2_open
Date: Wed,  3 Jan 2024 17:54:50 +0100
Message-ID: <20240103164905.263454727@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 47 +++++++++++++---------------
 fs/smb/server/smbacl.c  |  7 +++--
 fs/smb/server/smbacl.h  |  2 +-
 fs/smb/server/vfs.c     | 68 +++++++++++++++++++++++++----------------
 fs/smb/server/vfs.h     | 10 ++++--
 5 files changed, 75 insertions(+), 59 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a89a69d752a3b..b8340f1382bef 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
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
@@ -3152,7 +3153,8 @@ int smb2_open(struct ksmbd_work *work)
 								    user_ns,
 								    &path,
 								    pntsd,
-								    pntsd_size);
+								    pntsd_size,
+								    false);
 					kfree(pntsd);
 					if (rc)
 						pr_err("failed to store ntacl in xattr : %d\n",
@@ -3228,12 +3230,6 @@ int smb2_open(struct ksmbd_work *work)
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
 
@@ -3398,11 +3394,12 @@ int smb2_open(struct ksmbd_work *work)
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
@@ -6013,7 +6009,7 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 	fp->saccess |= FILE_SHARE_DELETE_LE;
 
 	return set_info_sec(fp->conn, fp->tcon, &fp->filp->f_path, pntsd,
-			buf_len, false);
+			buf_len, false, true);
 }
 
 /**
@@ -7583,7 +7579,8 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
-						     &fp->filp->f_path, &da);
+						     &fp->filp->f_path,
+						     &da, true);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 7a42728d8047c..d9bbd2eb89c35 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1185,7 +1185,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, pntsd_size, false);
 		kfree(pntsd);
 	}
 
@@ -1377,7 +1377,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check)
+		 bool type_check, bool get_write)
 {
 	int rc;
 	struct smb_fattr fattr = {{0}};
@@ -1437,7 +1437,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
 		ksmbd_vfs_remove_sd_xattrs(user_ns, path);
-		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, ntsd_len);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, ntsd_len,
+				get_write);
 	}
 
 out:
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 618f2e0236b31..9651a25518881 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -207,7 +207,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check);
+		 bool type_check, bool get_write);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d4298a751d4a2..08f3f66e4b38e 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -98,6 +98,13 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
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
@@ -124,6 +131,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 
 err_out:
 	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
 	path_put(parent_path);
 	putname(filename);
 	return -ENOENT;
@@ -452,7 +460,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
-				 0);
+				 0,
+				 true);
 	if (err < 0)
 		goto out;
 
@@ -594,10 +603,6 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		goto out_err;
 	}
 
-	err = mnt_want_write(path->mnt);
-	if (err)
-		goto out_err;
-
 	user_ns = mnt_user_ns(path->mnt);
 	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
 		err = vfs_rmdir(user_ns, d_inode(parent), path->dentry);
@@ -608,7 +613,6 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 		if (err)
 			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
-	mnt_drop_write(path->mnt);
 
 out_err:
 	ksmbd_revert_fsids(work);
@@ -908,18 +912,22 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value
  * @flags:	destination buffer length
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       const struct path *path, const char *attr_name,
-		       void *attr_value, size_t attr_size, int flags)
+		       void *attr_value, size_t attr_size, int flags,
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
@@ -929,7 +937,8 @@ int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 			   flags);
 	if (err)
 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
-	mnt_drop_write(path->mnt);
+	if (get_write == true)
+		mnt_drop_write(path->mnt);
 	return err;
 }
 
@@ -1253,6 +1262,13 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
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
@@ -1262,6 +1278,14 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
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
@@ -1411,7 +1435,8 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
 			   const struct path *path,
-			   struct smb_ntsd *pntsd, int len)
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write)
 {
 	int rc;
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
@@ -1471,7 +1496,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 
 	rc = ksmbd_vfs_setxattr(user_ns, path,
 				XATTR_NAME_SD, sd_ndr.data,
-				sd_ndr.offset, 0);
+				sd_ndr.offset, 0, get_write);
 	if (rc < 0)
 		pr_err("Failed to store XATTR ntacl :%d\n", rc);
 
@@ -1560,7 +1585,8 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 				   const struct path *path,
-				   struct xattr_dos_attrib *da)
+				   struct xattr_dos_attrib *da,
+				   bool get_write)
 {
 	struct ndr n;
 	int err;
@@ -1570,7 +1596,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 		return err;
 
 	err = ksmbd_vfs_setxattr(user_ns, path, XATTR_NAME_DOS_ATTRIBUTE,
-				 (void *)n.data, n.offset, 0);
+				 (void *)n.data, n.offset, 0, get_write);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
 	kfree(n.data);
@@ -1840,10 +1866,6 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
 
-	rc = mnt_want_write(path->mnt);
-	if (rc)
-		goto out_err;
-
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1856,9 +1878,7 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
-	mnt_drop_write(path->mnt);
 
-out_err:
 	free_acl_state(&acl_state);
 	posix_acl_release(acls);
 	return rc;
@@ -1887,10 +1907,6 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 		}
 	}
 
-	rc = mnt_want_write(path->mnt);
-	if (rc)
-		goto out_err;
-
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1902,9 +1918,7 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
-	mnt_drop_write(path->mnt);
 
-out_err:
 	posix_acl_release(acls);
 	return rc;
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 93799ca4cc345..e761dde2443e2 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -109,7 +109,8 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       const struct path *path, const char *attr_name,
-		       void *attr_value, size_t attr_size, int flags);
+		       void *attr_value, size_t attr_size, int flags,
+		       bool get_write);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
@@ -117,6 +118,7 @@ int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags, struct path *parent_path,
 			       struct path *path, bool caseless);
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -144,14 +146,16 @@ int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns, const struct path
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
2.43.0




