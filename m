Return-Path: <stable+bounces-8058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B3B81A45A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F36A28C3AC
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F34B13D;
	Wed, 20 Dec 2023 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWZ2V4CX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D74D137;
	Wed, 20 Dec 2023 16:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425FC433C7;
	Wed, 20 Dec 2023 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088793;
	bh=EBK2RiciI0oTeiyd6cLyf24nRzamWwB/YdH+keEpbXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWZ2V4CXs4cKyAQe5/0JkOSz53JXeIo27EfyAJ3JslAEqSwxeeEYKi2gobePo4zE+
	 VH3xUiE6ppPKjblcfjlWDF3qyX2rWyPaz0Eh+aQKONYwCmuHzrlemFgWBIjH9ajQUh
	 m0kSEv4gD4pNzUz1PpU0HsjUIw7dqvmPP4ExC2Gs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 031/159] ksmbd: remove filename in ksmbd_file
Date: Wed, 20 Dec 2023 17:08:16 +0100
Message-ID: <20231220160932.730845536@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 50f500b7f6335404b18bbffa93e3a905a08d061a ]

If the filename is change by underlying rename the server, fp->filename
and real filename can be different. This patch remove the uses of
fp->filename in ksmbd and replace it with d_path().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/misc.c      |   40 +++++++++++++++++++++++++++++++---------
 fs/ksmbd/misc.h      |    3 ++-
 fs/ksmbd/oplock.c    |   30 ------------------------------
 fs/ksmbd/oplock.h    |    2 --
 fs/ksmbd/smb2pdu.c   |   21 +++++++--------------
 fs/ksmbd/vfs.c       |    6 ++----
 fs/ksmbd/vfs_cache.c |    1 -
 fs/ksmbd/vfs_cache.h |    1 -
 8 files changed, 42 insertions(+), 62 deletions(-)

--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -158,19 +158,41 @@ out:
  * Return : windows path string or error
  */
 
-char *convert_to_nt_pathname(char *filename)
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     struct path *path)
 {
-	char *ab_pathname;
+	char *pathname, *ab_pathname, *nt_pathname;
+	int share_path_len = share->path_sz;
 
-	if (strlen(filename) == 0)
-		filename = "\\";
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return ERR_PTR(-EACCES);
 
-	ab_pathname = kstrdup(filename, GFP_KERNEL);
-	if (!ab_pathname)
-		return NULL;
+	ab_pathname = d_path(path, pathname, PATH_MAX);
+	if (IS_ERR(ab_pathname)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
 
-	ksmbd_conv_path_to_windows(ab_pathname);
-	return ab_pathname;
+	if (strncmp(ab_pathname, share->path, share_path_len)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2, GFP_KERNEL);
+	if (!nt_pathname) {
+		nt_pathname = ERR_PTR(-ENOMEM);
+		goto free_pathname;
+	}
+	if (ab_pathname[share_path_len] == '\0')
+		strcpy(nt_pathname, "/");
+	strcat(nt_pathname, &ab_pathname[share_path_len]);
+
+	ksmbd_conv_path_to_windows(nt_pathname);
+
+free_pathname:
+	kfree(pathname);
+	return nt_pathname;
 }
 
 int get_nlink(struct kstat *st)
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -14,7 +14,8 @@ struct ksmbd_file;
 int match_pattern(const char *str, size_t len, const char *pattern);
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
-char *convert_to_nt_pathname(char *filename);
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1696,33 +1696,3 @@ out:
 	read_unlock(&lease_list_lock);
 	return ret_op;
 }
-
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name)
-{
-	struct oplock_info *opinfo = opinfo_get(fp);
-	int ret = 0;
-
-	if (opinfo && opinfo->is_lease) {
-		if (!lctx) {
-			pr_err("open does not include lease\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
-			   SMB2_LEASE_KEY_SIZE)) {
-			pr_err("invalid lease key\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (name && strcmp(fp->filename, name)) {
-			pr_err("invalid name reconnect %s\n", name);
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-out:
-	if (opinfo)
-		opinfo_put(opinfo);
-	return ret;
-}
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -124,6 +124,4 @@ struct oplock_info *lookup_lease_in_tabl
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name);
 #endif /* __KSMBD_OPLOCK_H */
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2988,7 +2988,6 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	fp->filename = name;
 	fp->cdoption = req->CreateDisposition;
 	fp->daccess = daccess;
 	fp->saccess = req->ShareAccess;
@@ -3343,14 +3342,13 @@ err_out1:
 		if (!rsp->hdr.Status)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 
-		if (!fp || !fp->filename)
-			kfree(name);
 		if (fp)
 			ksmbd_fd_put(work, fp);
 		smb2_set_err_rsp(work);
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
 
+	kfree(name);
 	kfree(lc);
 
 	return 0;
@@ -3969,8 +3967,6 @@ int smb2_query_dir(struct ksmbd_work *wo
 		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
 	}
 
-	ksmbd_debug(SMB, "Directory name is %s\n", dir_fp->filename);
-
 	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
 		ksmbd_debug(SMB, "Restart directory scan\n");
 		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
@@ -4456,9 +4452,9 @@ static int get_file_all_info(struct ksmb
 		return -EACCES;
 	}
 
-	filename = convert_to_nt_pathname(fp->filename);
-	if (!filename)
-		return -ENOMEM;
+	filename = convert_to_nt_pathname(work->tcon->share_conf, &fp->filp->f_path);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
 
 	inode = file_inode(fp->filp);
 	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
@@ -5761,8 +5757,7 @@ static int set_file_allocation_info(stru
 		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
-			pr_err("truncate failed! filename : %s, err %d\n",
-			       fp->filename, rc);
+			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
 		if (size < alloc_blks * 512)
@@ -5792,12 +5787,10 @@ static int set_end_of_file_info(struct k
 	 * truncated range.
 	 */
 	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
-		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
-			    fp->filename, newsize);
+		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
-			ksmbd_debug(SMB, "truncate failed! filename : %s err %d\n",
-				    fp->filename, rc);
+			ksmbd_debug(SMB, "truncate failed!, err %d\n", rc);
 			if (rc != -EAGAIN)
 				rc = -EBADF;
 			return rc;
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -397,8 +397,7 @@ int ksmbd_vfs_read(struct ksmbd_work *wo
 
 	nbytes = kernel_read(filp, rbuf, count, pos);
 	if (nbytes < 0) {
-		pr_err("smb read failed for (%s), err = %zd\n",
-		       fp->filename, nbytes);
+		pr_err("smb read failed, err = %zd\n", nbytes);
 		return nbytes;
 	}
 
@@ -873,8 +872,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work
 
 	err = vfs_truncate(&filp->f_path, size);
 	if (err)
-		pr_err("truncate failed for filename : %s err %d\n",
-		       fp->filename, err);
+		pr_err("truncate failed, err %d\n", err);
 	return err;
 }
 
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -328,7 +328,6 @@ static void __ksmbd_close_fd(struct ksmb
 		kfree(smb_lock);
 	}
 
-	kfree(fp->filename);
 	if (ksmbd_stream_fd(fp))
 		kfree(fp->stream.name);
 	kmem_cache_free(filp_cache, fp);
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -62,7 +62,6 @@ struct ksmbd_inode {
 
 struct ksmbd_file {
 	struct file			*filp;
-	char				*filename;
 	u64				persistent_id;
 	u64				volatile_id;
 



