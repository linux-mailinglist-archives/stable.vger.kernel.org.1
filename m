Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86E73E7E6
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFZSUT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjFZSUR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79853ED
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0405560E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D104DC433C0;
        Mon, 26 Jun 2023 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803613;
        bh=F5Q+J+qxINMxI5YQPBcn1sWIgwi2LBRUs46uvMH1g/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChEAb+wfcrcykenS3GH5SiDcKNVxHDn4ohEr0ZOaqp51McaBis0CxE+Pv7ssxbstG
         vvuXb7W1P3fFs4LrZ3nMIt+jg9PR5sNsE53i7/FAvchDp6k9G5w+NumHrCdBp0rQ1T
         n43en+kpdYcqvPgMSx3pzi+X7BEYfS/DQTwe/CdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 093/199] ksmbd: fix racy issue from using ->d_parent and ->d_name
Date:   Mon, 26 Jun 2023 20:09:59 +0200
Message-ID: <20230626180809.694570348@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 74d7970febf7e9005375aeda0df821d2edffc9f7 ]

Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
in ksmbd_vfs_unlink and smb2_vfs_rename(). and use new lock_rename_child()
to lock stable parent while underlying rename racy.
Introduce vfs_path_parent_lookup helper to avoid out of share access and
export vfs functions like the following ones to use
vfs_path_parent_lookup().
 - rename __lookup_hash() to lookup_one_qstr_excl().
 - export lookup_one_qstr_excl().
 - export getname_kernel() and putname().

vfs_path_parent_lookup() is used for parent lookup of destination file
using absolute pathname given from FILE_RENAME_INFORMATION request.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 40b268d384a2 ("ksmbd: add mnt_want_write to ksmbd vfs functions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c    | 147 ++++----------
 fs/ksmbd/vfs.c        | 435 ++++++++++++++++++------------------------
 fs/ksmbd/vfs.h        |  19 +-
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            |  57 ++++--
 include/linux/namei.h |   6 +
 6 files changed, 283 insertions(+), 386 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 36843bef05c5f..06a335356e373 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2515,7 +2515,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2806,8 +2806,10 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
 	if (!rc) {
+		file_present = true;
+
 		if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
 			/*
 			 * If file exists with under flags, return access
@@ -2816,7 +2818,6 @@ int smb2_open(struct ksmbd_work *work)
 			if (req->CreateDisposition == FILE_OVERWRITE_IF_LE ||
 			    req->CreateDisposition == FILE_OPEN_IF_LE) {
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 
@@ -2824,26 +2825,23 @@ int smb2_open(struct ksmbd_work *work)
 				ksmbd_debug(SMB,
 					    "User does not have write permission\n");
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 		} else if (d_is_symlink(path.dentry)) {
 			rc = -EACCES;
-			path_put(&path);
 			goto err_out;
 		}
-	}
 
-	if (rc) {
+		file_present = true;
+		idmap = mnt_idmap(path.mnt);
+	} else {
 		if (rc != -ENOENT)
 			goto err_out;
 		ksmbd_debug(SMB, "can not get linux path for %s, rc = %d\n",
 			    name, rc);
 		rc = 0;
-	} else {
-		file_present = true;
-		idmap = mnt_idmap(path.mnt);
 	}
+
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (s_type == DATA_STREAM) {
@@ -2971,8 +2969,9 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = ksmbd_vfs_may_delete(idmap,
-							  path.dentry);
+				rc = inode_permission(idmap,
+						      d_inode(path.dentry->d_parent),
+						      MAY_EXEC | MAY_WRITE);
 				if (rc)
 					goto err_out;
 			}
@@ -3343,10 +3342,13 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created)
-		path_put(&path);
+	if (file_present || created) {
+		inode_unlock(d_inode(path.dentry->d_parent));
+		dput(path.dentry);
+	}
 	ksmbd_revert_fsids(work);
 err_out1:
+
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -5485,44 +5487,19 @@ int smb2_echo(struct ksmbd_work *work)
 
 static int smb2_rename(struct ksmbd_work *work,
 		       struct ksmbd_file *fp,
-		       struct mnt_idmap *idmap,
 		       struct smb2_file_rename_info *file_info,
 		       struct nls_table *local_nls)
 {
 	struct ksmbd_share_config *share = fp->tcon->share_conf;
-	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
-	char *pathname = NULL;
-	struct path path;
-	bool file_present = true;
-	int rc;
+	char *new_name = NULL;
+	int rc, flags = 0;
 
 	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-
-	abs_oldname = file_path(fp->filp, pathname, PATH_MAX);
-	if (IS_ERR(abs_oldname)) {
-		rc = -EINVAL;
-		goto out;
-	}
-	old_name = strrchr(abs_oldname, '/');
-	if (old_name && old_name[1] != '\0') {
-		old_name++;
-	} else {
-		ksmbd_debug(SMB, "can't get last component in path %s\n",
-			    abs_oldname);
-		rc = -ENOENT;
-		goto out;
-	}
-
 	new_name = smb2_get_name(file_info->FileName,
 				 le32_to_cpu(file_info->FileNameLength),
 				 local_nls);
-	if (IS_ERR(new_name)) {
-		rc = PTR_ERR(new_name);
-		goto out;
-	}
+	if (IS_ERR(new_name))
+		return PTR_ERR(new_name);
 
 	if (strchr(new_name, ':')) {
 		int s_type;
@@ -5548,7 +5525,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(idmap,
+		rc = ksmbd_vfs_setxattr(file_mnt_idmap(fp->filp),
 					fp->filp->f_path.dentry,
 					xattr_stream_name,
 					NULL, 0, 0);
@@ -5563,47 +5540,18 @@ static int smb2_rename(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "new name %s\n", new_name);
-	rc = ksmbd_vfs_kern_path(work, new_name, LOOKUP_NO_SYMLINKS, &path, 1);
-	if (rc) {
-		if (rc != -ENOENT)
-			goto out;
-		file_present = false;
-	} else {
-		path_put(&path);
-	}
-
 	if (ksmbd_share_veto_filename(share, new_name)) {
 		rc = -ENOENT;
 		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
 		goto out;
 	}
 
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, new_name);
-			if (rc) {
-				if (rc != -ENOTEMPTY)
-					rc = -EINVAL;
-				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
-					    new_name, rc);
-				goto out;
-			}
-		}
-	} else {
-		if (file_present &&
-		    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
-			rc = -EEXIST;
-			ksmbd_debug(SMB,
-				    "cannot rename already existing file\n");
-			goto out;
-		}
-	}
+	if (!file_info->ReplaceIfExists)
+		flags = RENAME_NOREPLACE;
 
-	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
+	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
-	kfree(pathname);
-	if (!IS_ERR(new_name))
-		kfree(new_name);
+	kfree(new_name);
 	return rc;
 }
 
@@ -5643,18 +5591,17 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
-	rc = ksmbd_vfs_kern_path(work, link_name, LOOKUP_NO_SYMLINKS, &path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
+					&path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
 		file_present = false;
-	} else {
-		path_put(&path);
 	}
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, link_name);
+			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
 				ksmbd_debug(SMB, "cannot delete %s\n",
@@ -5674,6 +5621,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc)
 		rc = -EINVAL;
 out:
+	if (file_present) {
+		inode_unlock(d_inode(path.dentry->d_parent));
+		path_put(&path);
+	}
 	if (!IS_ERR(link_name))
 		kfree(link_name);
 	kfree(pathname);
@@ -5851,12 +5802,6 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			   struct smb2_file_rename_info *rename_info,
 			   unsigned int buf_len)
 {
-	struct mnt_idmap *idmap;
-	struct ksmbd_file *parent_fp;
-	struct dentry *parent;
-	struct dentry *dentry = fp->filp->f_path.dentry;
-	int ret;
-
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
 		return -EACCES;
@@ -5866,32 +5811,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			le32_to_cpu(rename_info->FileNameLength))
 		return -EINVAL;
 
-	idmap = file_mnt_idmap(fp->filp);
-	if (ksmbd_stream_fd(fp))
-		goto next;
-
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(parent));
-	inode_unlock(d_inode(parent));
-	dput(parent);
+	if (!le32_to_cpu(rename_info->FileNameLength))
+		return -EINVAL;
 
-	if (parent_fp) {
-		if (parent_fp->daccess & FILE_DELETE_LE) {
-			pr_err("parent dir is opened with delete access\n");
-			ksmbd_fd_put(work, parent_fp);
-			return -ESHARE;
-		}
-		ksmbd_fd_put(work, parent_fp);
-	}
-next:
-	return smb2_rename(work, fp, idmap, rename_info,
-			   work->conn->local_nls);
+	return smb2_rename(work, fp, rename_info, work->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 1ad97df1dfb6f..448c442ad3f49 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -18,6 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
+#include <linux/namei.h>
 
 #include "glob.h"
 #include "oplock.h"
@@ -35,19 +36,6 @@
 #include "mgmt/user_session.h"
 #include "mgmt/user_config.h"
 
-static char *extract_last_component(char *path)
-{
-	char *p = strrchr(path, '/');
-
-	if (p && p[1] != '\0') {
-		*p = '\0';
-		p++;
-	} else {
-		p = NULL;
-	}
-	return p;
-}
-
 static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 				    struct inode *parent_inode,
 				    struct inode *inode)
@@ -61,65 +49,77 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 
 /**
  * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
- *
- * the parent dentry got by dget_parent or @parent could be
- * unstable, we try to lock a parent inode and lookup the
- * child dentry again.
- *
- * the reference count of @parent isn't incremented.
  */
-int ksmbd_vfs_lock_parent(struct mnt_idmap *idmap, struct dentry *parent,
-			  struct dentry *child)
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 {
-	struct dentry *dentry;
-	int ret = 0;
-
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(idmap, child->d_name.name, parent,
-			    child->d_name.len);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out_err;
-	}
-
-	if (dentry != child) {
-		ret = -ESTALE;
-		dput(dentry);
-		goto out_err;
+	if (child->d_parent != parent) {
+		inode_unlock(d_inode(parent));
+		return -ENOENT;
 	}
 
-	dput(dentry);
 	return 0;
-out_err:
-	inode_unlock(d_inode(parent));
-	return ret;
 }
 
-int ksmbd_vfs_may_delete(struct mnt_idmap *idmap,
-			 struct dentry *dentry)
+static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
+					char *pathname, unsigned int flags,
+					struct path *path)
 {
-	struct dentry *parent;
-	int ret;
+	struct qstr last;
+	struct filename *filename;
+	struct path *root_share_path = &share_conf->vfs_path;
+	int err, type;
+	struct path parent_path;
+	struct dentry *d;
+
+	if (pathname[0] == '\0') {
+		pathname = share_conf->path;
+		root_share_path = NULL;
+	} else {
+		flags |= LOOKUP_BENEATH;
+	}
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
+	filename = getname_kernel(pathname);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
+
+	err = vfs_path_parent_lookup(filename, flags,
+				     &parent_path, &last, &type,
+				     root_share_path);
+	putname(filename);
+	if (err)
+		return err;
+
+	if (unlikely(type != LAST_NORM)) {
+		path_put(&parent_path);
+		return -ENOENT;
 	}
 
-	ret = inode_permission(idmap, d_inode(parent),
-			       MAY_EXEC | MAY_WRITE);
+	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	if (IS_ERR(d))
+		goto err_out;
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
+	if (d_is_negative(d)) {
+		dput(d);
+		goto err_out;
+	}
+
+	path->dentry = d;
+	path->mnt = share_conf->vfs_path.mnt;
+	path_put(&parent_path);
+
+	return 0;
+
+err_out:
+	inode_unlock(parent_path.dentry->d_inode);
+	path_put(&parent_path);
+	return -ENOENT;
 }
 
 int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	struct dentry *parent;
 	int ret = 0;
 
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
@@ -136,18 +136,9 @@ int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_EXEC))
 		*daccess |= FILE_EXECUTE_LE;
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	if (!inode_permission(idmap, d_inode(parent), MAY_EXEC | MAY_WRITE))
+	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
 	return ret;
 }
 
@@ -580,54 +571,32 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 {
 	struct mnt_idmap *idmap;
-	struct path path;
-	struct dentry *parent;
+	struct dentry *parent = path->dentry->d_parent;
 	int err;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	err = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, false);
-	if (err) {
-		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	idmap = mnt_idmap(path.mnt);
-	parent = dget_parent(path.dentry);
-	err = ksmbd_vfs_lock_parent(idmap, parent, path.dentry);
-	if (err) {
-		dput(parent);
-		path_put(&path);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	if (!d_inode(path.dentry)->i_nlink) {
+	if (!d_inode(path->dentry)->i_nlink) {
 		err = -ENOENT;
 		goto out_err;
 	}
 
-	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
-		err = vfs_rmdir(idmap, d_inode(parent), path.dentry);
+	idmap = mnt_idmap(path->mnt);
+	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
+		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
 		if (err && err != -ENOTEMPTY)
-			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
 	} else {
-		err = vfs_unlink(idmap, d_inode(parent), path.dentry, NULL);
+		err = vfs_unlink(idmap, d_inode(parent), path->dentry, NULL);
 		if (err)
-			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
 
 out_err:
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	path_put(&path);
 	ksmbd_revert_fsids(work);
 	return err;
 }
@@ -686,149 +655,114 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	return err;
 }
 
-static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags)
 {
-	struct dentry *dst_dent;
-
-	spin_lock(&src_dent->d_lock);
-	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
-		struct ksmbd_file *child_fp;
+	struct dentry *old_parent, *new_dentry, *trap;
+	struct dentry *old_child = old_path->dentry;
+	struct path new_path;
+	struct qstr new_last;
+	struct renamedata rd;
+	struct filename *to;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct ksmbd_file *parent_fp;
+	int new_type;
+	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
 
-		if (d_really_is_negative(dst_dent))
-			continue;
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
 
-		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
-		if (child_fp) {
-			spin_unlock(&src_dent->d_lock);
-			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
-			return -EACCES;
-		}
+	to = getname_kernel(newname);
+	if (IS_ERR(to)) {
+		err = PTR_ERR(to);
+		goto revert_fsids;
 	}
-	spin_unlock(&src_dent->d_lock);
 
-	return 0;
-}
+retry:
+	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
+				     &new_path, &new_last, &new_type,
+				     &share_conf->vfs_path);
+	if (err)
+		goto out1;
 
-static int __ksmbd_vfs_rename(struct ksmbd_work *work,
-			      struct mnt_idmap *src_idmap,
-			      struct dentry *src_dent_parent,
-			      struct dentry *src_dent,
-			      struct mnt_idmap *dst_idmap,
-			      struct dentry *dst_dent_parent,
-			      struct dentry *trap_dent,
-			      char *dst_name)
-{
-	struct dentry *dst_dent;
-	int err;
+	if (old_path->mnt != new_path.mnt) {
+		err = -EXDEV;
+		goto out2;
+	}
 
-	if (!work->tcon->posix_extensions) {
-		err = ksmbd_validate_entry_in_use(src_dent);
-		if (err)
-			return err;
+	trap = lock_rename_child(old_child, new_path.dentry);
+
+	old_parent = dget(old_child->d_parent);
+	if (d_unhashed(old_child)) {
+		err = -EINVAL;
+		goto out3;
 	}
 
-	if (d_really_is_negative(src_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(dst_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(src_dent))
-		return -ENOENT;
-	if (src_dent == trap_dent)
-		return -EINVAL;
+	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			err = -ESHARE;
+			ksmbd_fd_put(work, parent_fp);
+			goto out3;
+		}
+		ksmbd_fd_put(work, parent_fp);
+	}
 
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | LOOKUP_RENAME_TARGET);
+	if (IS_ERR(new_dentry)) {
+		err = PTR_ERR(new_dentry);
+		goto out3;
+	}
 
-	dst_dent = lookup_one(dst_idmap, dst_name,
-			      dst_dent_parent, strlen(dst_name));
-	err = PTR_ERR(dst_dent);
-	if (IS_ERR(dst_dent)) {
-		pr_err("lookup failed %s [%d]\n", dst_name, err);
-		goto out;
+	if (d_is_symlink(new_dentry)) {
+		err = -EACCES;
+		goto out4;
 	}
 
-	err = -ENOTEMPTY;
-	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
-		struct renamedata rd = {
-			.old_mnt_idmap	= src_idmap,
-			.old_dir	= d_inode(src_dent_parent),
-			.old_dentry	= src_dent,
-			.new_mnt_idmap	= dst_idmap,
-			.new_dir	= d_inode(dst_dent_parent),
-			.new_dentry	= dst_dent,
-		};
-		err = vfs_rename(&rd);
+	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
+		err = -EEXIST;
+		goto out4;
 	}
-	if (err)
-		pr_err("vfs_rename failed err %d\n", err);
-	if (dst_dent)
-		dput(dst_dent);
-out:
-	ksmbd_revert_fsids(work);
-	return err;
-}
 
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname)
-{
-	struct mnt_idmap *idmap;
-	struct path dst_path;
-	struct dentry *src_dent_parent, *dst_dent_parent;
-	struct dentry *src_dent, *trap_dent, *src_child;
-	char *dst_name;
-	int err;
+	if (old_child == trap) {
+		err = -EINVAL;
+		goto out4;
+	}
 
-	dst_name = extract_last_component(newname);
-	if (!dst_name) {
-		dst_name = newname;
-		newname = "";
+	if (new_dentry == trap) {
+		err = -ENOTEMPTY;
+		goto out4;
 	}
 
-	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
-	src_dent = fp->filp->f_path.dentry;
+	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt),
+	rd.old_dir		= d_inode(old_parent),
+	rd.old_dentry		= old_child,
+	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt),
+	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dentry		= new_dentry,
+	rd.flags		= flags,
+	err = vfs_rename(&rd);
+	if (err)
+		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
-	err = ksmbd_vfs_kern_path(work, newname,
-				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
-				  &dst_path, false);
-	if (err) {
-		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
-		goto out;
+out4:
+	dput(new_dentry);
+out3:
+	dput(old_parent);
+	unlock_rename(old_parent, new_path.dentry);
+out2:
+	path_put(&new_path);
+
+	if (retry_estale(err, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
 	}
-	dst_dent_parent = dst_path.dentry;
-
-	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
-	dget(src_dent);
-	dget(dst_dent_parent);
-	idmap = file_mnt_idmap(fp->filp);
-	src_child = lookup_one(idmap, src_dent->d_name.name, src_dent_parent,
-			       src_dent->d_name.len);
-	if (IS_ERR(src_child)) {
-		err = PTR_ERR(src_child);
-		goto out_lock;
-	}
-
-	if (src_child != src_dent) {
-		err = -ESTALE;
-		dput(src_child);
-		goto out_lock;
-	}
-	dput(src_child);
-
-	err = __ksmbd_vfs_rename(work,
-				 idmap,
-				 src_dent_parent,
-				 src_dent,
-				 mnt_idmap(dst_path.mnt),
-				 dst_dent_parent,
-				 trap_dent,
-				 dst_name);
-out_lock:
-	dput(src_dent);
-	dput(dst_dent_parent);
-	unlock_rename(src_dent_parent, dst_dent_parent);
-	path_put(&dst_path);
-out:
-	dput(src_dent_parent);
+out1:
+	putname(to);
+revert_fsids:
+	ksmbd_revert_fsids(work);
 	return err;
 }
 
@@ -1079,14 +1013,16 @@ int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 	return vfs_removexattr(idmap, dentry, attr_name);
 }
 
-int ksmbd_vfs_unlink(struct mnt_idmap *idmap,
-		     struct dentry *dir, struct dentry *dentry)
+int ksmbd_vfs_unlink(struct file *filp)
 {
 	int err = 0;
+	struct dentry *dir, *dentry = filp->f_path.dentry;
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 
-	err = ksmbd_vfs_lock_parent(idmap, dir, dentry);
+	dir = dget_parent(dentry);
+	err = ksmbd_vfs_lock_parent(dir, dentry);
 	if (err)
-		return err;
+		goto out;
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
@@ -1098,6 +1034,8 @@ int ksmbd_vfs_unlink(struct mnt_idmap *idmap,
 	inode_unlock(d_inode(dir));
 	if (err)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+out:
+	dput(dir);
 
 	return err;
 }
@@ -1200,7 +1138,7 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 }
 
 /**
- * ksmbd_vfs_kern_path() - lookup a file and get path info
+ * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
  * @name:	file path that is relative to share
  * @flags:	lookup flags
  * @path:	if lookup succeed, return path info
@@ -1208,24 +1146,20 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
-			unsigned int flags, struct path *path, bool caseless)
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *path,
+			       bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
+	struct path parent_path;
 
-	flags |= LOOKUP_BENEATH;
-	err = vfs_path_lookup(share_conf->vfs_path.dentry,
-			      share_conf->vfs_path.mnt,
-			      name,
-			      flags,
-			      path);
+	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
 	if (!err)
-		return 0;
+		return err;
 
 	if (caseless) {
 		char *filepath;
-		struct path parent;
 		size_t path_len, remain_len;
 
 		filepath = kstrdup(name, GFP_KERNEL);
@@ -1235,10 +1169,10 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent = share_conf->vfs_path;
-		path_get(&parent);
+		parent_path = share_conf->vfs_path;
+		path_get(&parent_path);
 
-		while (d_can_lookup(parent.dentry)) {
+		while (d_can_lookup(parent_path.dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1247,12 +1181,11 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent, filename,
+			err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
 						      filename_len,
 						      work->conn->um);
-			path_put(&parent);
 			if (err)
-				goto out;
+				goto out2;
 
 			next[0] = '\0';
 
@@ -1260,23 +1193,31 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 					      share_conf->vfs_path.mnt,
 					      filepath,
 					      flags,
-					      &parent);
+					      path);
 			if (err)
-				goto out;
-			else if (is_last) {
-				*path = parent;
-				goto out;
-			}
+				goto out2;
+			else if (is_last)
+				goto out1;
+			path_put(&parent_path);
+			parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
 		}
 
-		path_put(&parent);
 		err = -EINVAL;
-out:
+out2:
+		path_put(&parent_path);
+out1:
 		kfree(filepath);
 	}
+
+	if (!err) {
+		err = ksmbd_vfs_lock_parent(parent_path.dentry, path->dentry);
+		if (err)
+			dput(path->dentry);
+		path_put(&parent_path);
+	}
 	return err;
 }
 
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 9d676ab0cd25b..a4ae89f3230de 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -71,9 +71,7 @@ struct ksmbd_kstat {
 	__le32			file_attributes;
 };
 
-int ksmbd_vfs_lock_parent(struct mnt_idmap *idmap, struct dentry *parent,
-			  struct dentry *child);
-int ksmbd_vfs_may_delete(struct mnt_idmap *idmap, struct dentry *dentry);
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
 int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
@@ -84,12 +82,12 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
 int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname);
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		       struct ksmbd_file *fp, loff_t size);
 struct srv_copychunk;
@@ -116,9 +114,9 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, char *attr_name);
-int ksmbd_vfs_kern_path(struct ksmbd_work *work,
-			char *name, unsigned int flags, struct path *path,
-			bool caseless);
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *path,
+			       bool caseless);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -131,8 +129,7 @@ struct file_allocated_range_buffer;
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 			 struct file_allocated_range_buffer *ranges,
 			 unsigned int in_count, unsigned int *out_count);
-int ksmbd_vfs_unlink(struct mnt_idmap *idmap, struct dentry *dir,
-		     struct dentry *dentry);
+int ksmbd_vfs_unlink(struct file *filp);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct mnt_idmap *idmap,
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 054a7d2e0f489..2d0138e72d783 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -244,7 +244,6 @@ void ksmbd_release_inode_hash(void)
 
 static void __ksmbd_inode_close(struct ksmbd_file *fp)
 {
-	struct dentry *dir, *dentry;
 	struct ksmbd_inode *ci = fp->f_ci;
 	int err;
 	struct file *filp;
@@ -263,11 +262,9 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (atomic_dec_and_test(&ci->m_count)) {
 		write_lock(&ci->m_lock);
 		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
-			dentry = filp->f_path.dentry;
-			dir = dentry->d_parent;
 			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
 			write_unlock(&ci->m_lock);
-			ksmbd_vfs_unlink(file_mnt_idmap(filp), dir, dentry);
+			ksmbd_vfs_unlink(filp);
 			write_lock(&ci->m_lock);
 		}
 		write_unlock(&ci->m_lock);
diff --git a/fs/namei.c b/fs/namei.c
index 6bc1964e2214e..c1d59ae5af83e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -254,6 +254,7 @@ getname_kernel(const char * filename)
 
 	return result;
 }
+EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
@@ -271,6 +272,7 @@ void putname(struct filename *name)
 	} else
 		__putname(name);
 }
+EXPORT_SYMBOL(putname);
 
 /**
  * check_acl - perform ACL permission checking
@@ -1581,8 +1583,9 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * when directory is guaranteed to have no in-lookup children
  * at all.
  */
-static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1606,6 +1609,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	}
 	return dentry;
 }
+EXPORT_SYMBOL(lookup_one_qstr_excl);
 
 static struct dentry *lookup_fast(struct nameidata *nd)
 {
@@ -2532,16 +2536,17 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 }
 
 /* Note: this does not consume "name" */
-static int filename_parentat(int dfd, struct filename *name,
-			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+static int __filename_parentat(int dfd, struct filename *name,
+			       unsigned int flags, struct path *parent,
+			       struct qstr *last, int *type,
+			       const struct path *root)
 {
 	int retval;
 	struct nameidata nd;
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	set_nameidata(&nd, dfd, name, NULL);
+	set_nameidata(&nd, dfd, name, root);
 	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
 	if (unlikely(retval == -ECHILD))
 		retval = path_parentat(&nd, flags, parent);
@@ -2556,6 +2561,13 @@ static int filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
+{
+	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
+}
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
 {
@@ -2571,7 +2583,7 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = __lookup_hash(&last, path->dentry, 0);
+	d = lookup_one_qstr_excl(&last, path->dentry, 0);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -2599,6 +2611,24 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
 }
 EXPORT_SYMBOL(kern_path);
 
+/**
+ * vfs_path_parent_lookup - lookup a parent path relative to a dentry-vfsmount pair
+ * @filename: filename structure
+ * @flags: lookup flags
+ * @parent: pointer to struct path to fill
+ * @last: last component
+ * @type: type of the last component
+ * @root: pointer to struct path of the base directory
+ */
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root)
+{
+	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
+				    type, root);
+}
+EXPORT_SYMBOL(vfs_path_parent_lookup);
+
 /**
  * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
  * @dentry:  pointer to dentry of the base directory
@@ -3852,7 +3882,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (last.name[last.len] && !want_dir)
 		create_flags = 0;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path->dentry, reval_flag | create_flags);
+	dentry = lookup_one_qstr_excl(&last, path->dentry,
+				      reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
 
@@ -4212,7 +4243,7 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit2;
 
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4345,7 +4376,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		goto exit2;
 retry_deleg:
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 
@@ -4909,7 +4940,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
 
-	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
+	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
+					  lookup_flags);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -4917,7 +4949,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = __lookup_hash(&new_last, new_path.dentry, lookup_flags | target_flags);
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | target_flags);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5864e4d82e567..1463cbda48886 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,18 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 	return user_path_at_empty(dfd, name, flags, path, NULL);
 }
 
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root);
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
-- 
2.39.2



