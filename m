Return-Path: <stable+bounces-82966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCCD994FAF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DE31F23B90
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED01DEFCE;
	Tue,  8 Oct 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="opMnS8ac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997091DF256;
	Tue,  8 Oct 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394031; cv=none; b=np2ZHlAubh4byX9sLYv+1/cK/Cns1os1L8pbiQl52UAW3daN9rpsKtxT6gqfiykCa9p4TQ1Fv2H2I/Kfy9+fNg47JDL+PBi1BkMLK4K7AQy8cfFj1UrNJTOLVLzxlXVWs9tkZkAu2NLOlVfRzoIGwVFLa+I/GRtlWxTT2GKcEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394031; c=relaxed/simple;
	bh=un62S25FCQXG34sF31XdxIlPGSKqn39faHgTZh6QgmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay4cPIZMszrpQVplISSNUYjLp4qcWo9Ae5KlTjvwXBhJFh3dpud5yB7v4BSMk5ffPjCh29UIgTyuNsjqzNnphMt64lSA5v4SxxUSrrhOnkFs2rRG0D/xsOjLlpSmBnRbqoo5v3gwn9xaWIRwyN5X5Jsw545ZQK6W3ghOmwjAGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=opMnS8ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E3C4CEC7;
	Tue,  8 Oct 2024 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394031;
	bh=un62S25FCQXG34sF31XdxIlPGSKqn39faHgTZh6QgmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opMnS8acBDW+/Xo2jwTRZsAOLC8XVuKZBxXWpnOcGuYpahVWJGNjB8+JG9nydaLbg
	 q1OV2+cOugXqSp7obUXFO6SDEJ9hytUcquwr/X/aKSY0iOrHae95XccbdrhF7x/S1w
	 OugCWWUIWRdQJcz66VerMuzLVerV3VjtTkCo6roM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangrong <wangrong@uniontech.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 295/386] smb: client: use actual path when queryfs
Date: Tue,  8 Oct 2024 14:09:00 +0200
Message-ID: <20241008115640.995629220@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

From: wangrong <wangrong@uniontech.com>

commit a421e3fe0e6abe27395078f4f0cec5daf466caea upstream.

Due to server permission control, the client does not have access to
the shared root directory, but can access subdirectories normally, so
users usually mount the shared subdirectories directly. In this case,
queryfs should use the actual path instead of the root directory to
avoid the call returning an error (EACCES).

Signed-off-by: wangrong <wangrong@uniontech.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsfs.c   |   13 ++++++++++++-
 fs/smb/client/cifsglob.h |    2 +-
 fs/smb/client/smb1ops.c  |    2 +-
 fs/smb/client/smb2ops.c  |   19 ++++++++++++-------
 4 files changed, 26 insertions(+), 10 deletions(-)

--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -312,8 +312,17 @@ cifs_statfs(struct dentry *dentry, struc
 	struct TCP_Server_Info *server = tcon->ses->server;
 	unsigned int xid;
 	int rc = 0;
+	const char *full_path;
+	void *page;
 
 	xid = get_xid();
+	page = alloc_dentry_path();
+
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
+		goto statfs_out;
+	}
 
 	if (le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength) > 0)
 		buf->f_namelen =
@@ -329,8 +338,10 @@ cifs_statfs(struct dentry *dentry, struc
 	buf->f_ffree = 0;	/* unlimited */
 
 	if (server->ops->queryfs)
-		rc = server->ops->queryfs(xid, tcon, cifs_sb, buf);
+		rc = server->ops->queryfs(xid, tcon, full_path, cifs_sb, buf);
 
+statfs_out:
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -485,7 +485,7 @@ struct smb_version_operations {
 			__u16 net_fid, struct cifsInodeInfo *cifs_inode);
 	/* query remote filesystem */
 	int (*queryfs)(const unsigned int, struct cifs_tcon *,
-		       struct cifs_sb_info *, struct kstatfs *);
+		       const char *, struct cifs_sb_info *, struct kstatfs *);
 	/* send mandatory brlock to the server */
 	int (*mand_lock)(const unsigned int, struct cifsFileInfo *, __u64,
 			 __u64, __u32, int, int, bool);
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -909,7 +909,7 @@ cifs_oplock_response(struct cifs_tcon *t
 
 static int
 cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	int rc = -EOPNOTSUPP;
 
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2783,7 +2783,7 @@ out_free_path:
 
 static int
 smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	struct smb2_query_info_rsp *rsp;
 	struct smb2_fs_full_size_info *info = NULL;
@@ -2792,7 +2792,7 @@ smb2_queryfs(const unsigned int xid, str
 	int rc;
 
 
-	rc = smb2_query_info_compound(xid, tcon, "",
+	rc = smb2_query_info_compound(xid, tcon, path,
 				      FILE_READ_ATTRIBUTES,
 				      FS_FULL_SIZE_INFORMATION,
 				      SMB2_O_INFO_FILESYSTEM,
@@ -2820,28 +2820,33 @@ qfs_exit:
 
 static int
 smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	       struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	       const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	int rc;
-	__le16 srch_path = 0; /* Null - open root of share */
+	__le16 *utf16_path = NULL;
 	u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 
 	if (!tcon->posix_extensions)
-		return smb2_queryfs(xid, tcon, cifs_sb, buf);
+		return smb2_queryfs(xid, tcon, path, cifs_sb, buf);
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
-		.path = "",
+		.path = path,
 		.desired_access = FILE_READ_ATTRIBUTES,
 		.disposition = FILE_OPEN,
 		.create_options = cifs_create_options(cifs_sb, 0),
 		.fid = &fid,
 	};
 
-	rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL,
+	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
+	if (utf16_path == NULL)
+		return -ENOMEM;
+
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL,
 		       NULL, NULL);
+	kfree(utf16_path);
 	if (rc)
 		return rc;
 



