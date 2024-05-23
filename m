Return-Path: <stable+bounces-45891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF18CD46D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA0C1C2139D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32F13BAE2;
	Thu, 23 May 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pp7Ma2VX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BC1E497;
	Thu, 23 May 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470660; cv=none; b=M2IwTSV2G9xz3U8WyTQo+a1ldVZdOa96MV/sijrPKBtwY6kymA1gSMJN0zCeKfQdC/Nfkli/j96NhS1QZNzQX9hvvw9bd9nnwtkVCZGsvwoTZhJsDgLtDpVtdHf238XNvJtAihDUnGH83kJhoSexq1O48LlAgGGuJDwMyMBULvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470660; c=relaxed/simple;
	bh=Dge6HeSmbvBjJwuG8LE8ACOwXSRuks8niBRloYIOPqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3xFLJKPZUv5h9FdjHSSewa1aO333vipWk+OuqAZpaBHkhQDyRYpgKbCC5yI0Ef3689quBZTpEynL3PLBzBTv4p2jswMP3IhLeCSdwBuPsDg5epniGSXHWuIIzMLi6HgUBAl9BjxvHiJPJsCJlEU1tK2IuVxrn6v184sZB+1JAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pp7Ma2VX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32827C2BD10;
	Thu, 23 May 2024 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470659;
	bh=Dge6HeSmbvBjJwuG8LE8ACOwXSRuks8niBRloYIOPqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pp7Ma2VXVWAlfEltWJx6KQ/j8bveP4U9JzKuqcY4/6+PDlzlVHl31ft+73V2PnWum
	 zmx5G1X/Z2DeDwztMJ7Qc0Ifdwikhs2mZQnWk78Gdfv/zc1ykcwJo3UWaMuMoJut99
	 kLTZ8okRu/YJQYITe7Fi11u+QDTWPxh/B5Ir9CIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 043/102] smb: client: do not defer close open handles to deleted files
Date: Thu, 23 May 2024 15:13:08 +0200
Message-ID: <20240523130344.090689692@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit ffceb7640cbfe6ea60e7769e107451d63a2fe3d3 ]

When a file/dentry has been deleted before closing all its open
handles, currently, closing them can add them to the deferred
close list. This can lead to problems in creating file with the
same name when the file is re-created before the deferred close
completes. This issue was seen while reusing a client's already
existing lease on a file for compound operations and xfstest 591
failed because of the deferred close handle that remained valid
even after the file was deleted and was being reused to create a
file with the same name. The server in this case returns an error
on open with STATUS_DELETE_PENDING. Recreating the file would
fail till the deferred handles are closed (duration specified in
closetimeo).

This patch fixes the issue by flagging all open handles for the
deleted file (file path to be precise) by setting
status_file_deleted to true in the cifsFileInfo structure. As per
the information classes specified in MS-FSCC, SMB2 query info
response from the server has a DeletePending field, set to true
to indicate that deletion has been requested on that file. If
this is the case, flag the open handles for this file too.

When doing close in cifs_close for each of these handles, check the
value of this boolean field and do not defer close these handles
if the corresponding filepath has been deleted.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |  1 +
 fs/smb/client/cifsproto.h |  4 ++++
 fs/smb/client/file.c      |  3 ++-
 fs/smb/client/inode.c     | 28 +++++++++++++++++++++++++---
 fs/smb/client/misc.c      | 34 ++++++++++++++++++++++++++++++++++
 fs/smb/client/smb2inode.c |  9 ++++++++-
 6 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a149579910add..fdadda4024f46 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1427,6 +1427,7 @@ struct cifsFileInfo {
 	bool invalidHandle:1;	/* file closed via session abend */
 	bool swapfile:1;
 	bool oplock_break_cancelled:1;
+	bool status_file_deleted:1; /* file has been deleted */
 	bool offload:1; /* offload final part of _put to a wq */
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index e9b38b279a6c5..50040990e70b9 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -298,6 +298,10 @@ extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
 extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 				const char *path);
+
+extern void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
+				const char *path);
+
 extern struct TCP_Server_Info *
 cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		     struct TCP_Server_Info *primary_server);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 751ae89cefe36..8eaf195ef5604 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -501,6 +501,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	cfile->uid = current_fsuid();
 	cfile->dentry = dget(dentry);
 	cfile->f_flags = file->f_flags;
+	cfile->status_file_deleted = false;
 	cfile->invalidHandle = false;
 	cfile->deferred_close_scheduled = false;
 	cfile->tlink = cifs_get_tlink(tlink);
@@ -1167,7 +1168,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
 		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
-		    dclose) {
+		    dclose && !(cfile->status_file_deleted)) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 156713186b3c9..2739cb8390804 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -894,6 +894,9 @@ cifs_get_file_info(struct file *filp)
 	struct cifsFileInfo *cfile = filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
+	struct dentry *dentry = filp->f_path.dentry;
+	void *page = alloc_dentry_path();
+	const unsigned char *path;
 
 	if (!server->ops->query_file_info)
 		return -ENOSYS;
@@ -908,7 +911,14 @@ cifs_get_file_info(struct file *filp)
 			data.symlink = true;
 			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
 		}
+		path = build_path_from_dentry(dentry, page);
+		if (IS_ERR(path)) {
+			free_dentry_path(page);
+			return PTR_ERR(path);
+		}
 		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
+		if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
+			cifs_mark_open_handles_for_deleted_file(inode, path);
 		break;
 	case -EREMOTE:
 		cifs_create_junction_fattr(&fattr, inode->i_sb);
@@ -938,6 +948,7 @@ cifs_get_file_info(struct file *filp)
 	rc = cifs_fattr_to_inode(inode, &fattr, false);
 cgfi_exit:
 	cifs_free_open_info(&data);
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
@@ -1076,6 +1087,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	struct kvec rsp_iov, *iov = NULL;
 	int rsp_buftype = CIFS_NO_BUFFER;
 	u32 tag = data->reparse.tag;
+	struct inode *inode = NULL;
 	int rc = 0;
 
 	if (!tag && server->ops->query_reparse_point) {
@@ -1115,8 +1127,12 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 
 	if (tcon->posix_extensions)
 		smb311_posix_info_to_fattr(fattr, data, sb);
-	else
+	else {
 		cifs_open_info_to_fattr(fattr, data, sb);
+		inode = cifs_iget(sb, fattr);
+		if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
+			cifs_mark_open_handles_for_deleted_file(inode, full_path);
+	}
 out:
 	fattr->cf_cifstag = data->reparse.tag;
 	free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
@@ -1171,6 +1187,8 @@ static int cifs_get_fattr(struct cifs_open_info_data *data,
 						   full_path, fattr);
 		} else {
 			cifs_open_info_to_fattr(fattr, data, sb);
+			if (fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
+				cifs_mark_open_handles_for_deleted_file(*inode, full_path);
 		}
 		break;
 	case -EREMOTE:
@@ -1853,16 +1871,20 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 
 psx_del_no_retry:
 	if (!rc) {
-		if (inode)
+		if (inode) {
+			cifs_mark_open_handles_for_deleted_file(inode, full_path);
 			cifs_drop_nlink(inode);
+		}
 	} else if (rc == -ENOENT) {
 		d_drop(dentry);
 	} else if (rc == -EBUSY) {
 		if (server->ops->rename_pending_delete) {
 			rc = server->ops->rename_pending_delete(full_path,
 								dentry, xid);
-			if (rc == 0)
+			if (rc == 0) {
+				cifs_mark_open_handles_for_deleted_file(inode, full_path);
 				cifs_drop_nlink(inode);
+			}
 		}
 	} else if ((rc == -EACCES) && (dosattr == 0) && inode) {
 		attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index d56959d02e36d..669d27b4d414a 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -853,6 +853,40 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 	free_dentry_path(page);
 }
 
+/*
+ * If a dentry has been deleted, all corresponding open handles should know that
+ * so that we do not defer close them.
+ */
+void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
+					     const char *path)
+{
+	struct cifsFileInfo *cfile;
+	void *page;
+	const char *full_path;
+	struct cifsInodeInfo *cinode = CIFS_I(inode);
+
+	page = alloc_dentry_path();
+	spin_lock(&cinode->open_file_lock);
+
+	/*
+	 * note: we need to construct path from dentry and compare only if the
+	 * inode has any hardlinks. When number of hardlinks is 1, we can just
+	 * mark all open handles since they are going to be from the same file.
+	 */
+	if (inode->i_nlink > 1) {
+		list_for_each_entry(cfile, &cinode->openFileList, flist) {
+			full_path = build_path_from_dentry(cfile->dentry, page);
+			if (!IS_ERR(full_path) && strcmp(full_path, path) == 0)
+				cfile->status_file_deleted = true;
+		}
+	} else {
+		list_for_each_entry(cfile, &cinode->openFileList, flist)
+			cfile->status_file_deleted = true;
+	}
+	spin_unlock(&cinode->open_file_lock);
+	free_dentry_path(page);
+}
+
 /* parses DFS referral V3 structure
  * caller is responsible for freeing target_nodes
  * returns:
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index e452c59c13e2d..0b7b083352919 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -561,8 +561,15 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		case SMB2_OP_DELETE:
 			if (rc)
 				trace_smb3_delete_err(xid,  ses->Suid, tcon->tid, rc);
-			else
+			else {
+				/*
+				 * If dentry (hence, inode) is NULL, lease break is going to
+				 * take care of degrading leases on handles for deleted files.
+				 */
+				if (inode)
+					cifs_mark_open_handles_for_deleted_file(inode, full_path);
 				trace_smb3_delete_done(xid, ses->Suid, tcon->tid);
+			}
 			break;
 		case SMB2_OP_MKDIR:
 			if (rc)
-- 
2.43.0




