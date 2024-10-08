Return-Path: <stable+bounces-82543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA028994D3E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5401C2544D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA561DE4CC;
	Tue,  8 Oct 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q2b45w0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5941DFD1;
	Tue,  8 Oct 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392617; cv=none; b=shXBHJrCYYHgN4Xk6+8zJsUF0TV+gbGdZP1tkG7jgNi97NA5f0ihCn/ws7vZOKAXza4R4hdMlbi5nAvgO8I/i7fov5tcGVwtGEutL3UeCUCc2WABqQdtdbbazCFznK3Y4AqvhWvmq/6Baw44RvYe/ZStGlBOVUDDd+vcvOUxK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392617; c=relaxed/simple;
	bh=N6l3vol0AHudpi/peHLkPII01CLvgTZZs5S9jOUkw9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6FEEYpRJ0tdH+o2XoubA3hhvmp389NfWNZq15Iq7sx/SJ1XKga9ex+j9rAkRU+NrPYzMra/vN9aojq93/Fsvs5TAArUQynO+now7mr1PWrtA7DrsF6TF5snrJ4a+ZXpdx7Iuor2Cp11c91T0qc3yLrWVVGncnsmRWppEHJOENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q2b45w0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E4FC4CEC7;
	Tue,  8 Oct 2024 13:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392616;
	bh=N6l3vol0AHudpi/peHLkPII01CLvgTZZs5S9jOUkw9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2b45w0RLpSFSNwUMNbd8M6bcWWc7Fq3XzP3n/Srkqy8aXl44i2a7UAOmeDn0OMjO
	 VMSrjuALOR6enNdzxVUs37qJrafFeQkVXGO5RQGLic+YaKvz0+zQD4bLSOk2MF0fm0
	 QDqxQcVEezzyiqF4PvoCbkYirOI1K28Ibvs+RUVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangrong <wangrong@uniontech.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.11 468/558] smb: client: use actual path when queryfs
Date: Tue,  8 Oct 2024 14:08:18 +0200
Message-ID: <20241008115720.665549869@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
@@ -313,8 +313,17 @@ cifs_statfs(struct dentry *dentry, struc
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
@@ -330,8 +339,10 @@ cifs_statfs(struct dentry *dentry, struc
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
@@ -482,7 +482,7 @@ struct smb_version_operations {
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
@@ -2836,7 +2836,7 @@ out_free_path:
 
 static int
 smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	struct smb2_query_info_rsp *rsp;
 	struct smb2_fs_full_size_info *info = NULL;
@@ -2845,7 +2845,7 @@ smb2_queryfs(const unsigned int xid, str
 	int rc;
 
 
-	rc = smb2_query_info_compound(xid, tcon, "",
+	rc = smb2_query_info_compound(xid, tcon, path,
 				      FILE_READ_ATTRIBUTES,
 				      FS_FULL_SIZE_INFORMATION,
 				      SMB2_O_INFO_FILESYSTEM,
@@ -2873,28 +2873,33 @@ qfs_exit:
 
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
 



