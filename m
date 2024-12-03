Return-Path: <stable+bounces-98092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7CC9E26F9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F09289525
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B01F8907;
	Tue,  3 Dec 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GavMmCDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080FD1AB6C9;
	Tue,  3 Dec 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242763; cv=none; b=Q2rf+pXFeM4R0/YxFhD0RVtunntMlHuhm2mFRE1owuYojXTPqTNITiR6pjtXEpBvSucYmfgaLsBNyVVTglXkyh3pMRYsZhVLVzCg2SXYtar/HJSBNxEjfHcxDsAGj1MLs1eP78aoZgRx17xiaBlhssl3nAllpk8nl0lkRZ01IbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242763; c=relaxed/simple;
	bh=dLv4qW7vMi541/aCN7oY2tyH1rCNJYLo5fpshZxYIOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6pjDqmWIa6UJG9Db6QnT4W2Dw7SmdQ15CLJb949tT6T/2Giusc5ATulEtmioDwrR5Th2nwwE3/XgFWAb0Aon8vJkC04Uf7+zmjEBCXLg2snmDsZV1lCbJNetmH2+i67UXCgyJmnUXJZwIHB4Xoa0OMqf/S5bPtBz8LSu1fB1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GavMmCDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736FDC4CECF;
	Tue,  3 Dec 2024 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242762;
	bh=dLv4qW7vMi541/aCN7oY2tyH1rCNJYLo5fpshZxYIOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GavMmCDTR414a+6pMdhSU818BBqq0c6wvzBqsAXa8BuwGr5Vp1VTeB3PGqITwjUMl
	 43peaOb+OFtZbwiws0sTRZCqfOVd6nQRRmjk6ps2Z+YiU/AlKPs0DvUEmtVQTJRLba
	 2tlQ0KHatRH7+P4JPQhOQP2AE6bK+whalZpGDOmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 803/826] cifs: Fix parsing native symlinks relative to the export
Date: Tue,  3 Dec 2024 15:48:50 +0100
Message-ID: <20241203144815.081408447@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 723f4ef90452aa629f3d923e92e0449d69362b1d ]

SMB symlink which has SYMLINK_FLAG_RELATIVE set is relative (as opposite of
the absolute) and it can be relative either to the current directory (where
is the symlink stored) or relative to the top level export path. To what it
is relative depends on the first character of the symlink target path.

If the first character is path separator then symlink is relative to the
export, otherwise to the current directory. Linux (and generally POSIX
systems) supports only symlink paths relative to the current directory
where is symlink stored.

Currently if Linux SMB client reads relative SMB symlink with first
character as path separator (slash), it let as is. Which means that Linux
interpret it as absolute symlink pointing from the root (/). But this
location is different than the top level directory of SMB export (unless
SMB export was mounted to the root) and thefore SMB symlinks relative to
the export are interpreted wrongly by Linux SMB client.

Fix this problem. As Linux does not have equivalent of the path relative to
the top of the mount point, convert such symlink target path relative to
the current directory. Do this by prepending "../" pattern N times before
the SMB target path, where N is the number of path separators found in SMB
symlink path.

So for example, if SMB share is mounted to Linux path /mnt/share/, symlink
is stored in file /mnt/share/test/folder1/symlink (so SMB symlink path is
test\folder1\symlink) and SMB symlink target points to \test\folder2\file,
then convert symlink target path to Linux path ../../test/folder2/file.

Deduplicate code for parsing SMB symlinks in native form from functions
smb2_parse_symlink_response() and parse_reparse_native_symlink() into new
function smb2_parse_native_symlink() and pass into this new function a new
full_path parameter from callers, which specify SMB full path where is
symlink stored.

This change fixes resolving of the native Windows symlinks relative to the
top level directory of the SMB share.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f4ca4f5a36ea ("cifs: Fix parsing reparse point with native symlink in SMB1 non-UNICODE session")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |  1 +
 fs/smb/client/cifsproto.h |  1 +
 fs/smb/client/inode.c     |  1 +
 fs/smb/client/reparse.c   | 90 +++++++++++++++++++++++++++++++++------
 fs/smb/client/reparse.h   |  4 +-
 fs/smb/client/smb1ops.c   |  3 +-
 fs/smb/client/smb2file.c  | 21 +++++----
 fs/smb/client/smb2inode.c |  6 ++-
 fs/smb/client/smb2proto.h |  9 +++-
 9 files changed, 108 insertions(+), 28 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 31ea19e7b998a..9a4b3608b7d6f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -588,6 +588,7 @@ struct smb_version_operations {
 	/* Check for STATUS_NETWORK_NAME_DELETED */
 	bool (*is_network_name_deleted)(char *buf, struct TCP_Server_Info *srv);
 	int (*parse_reparse_point)(struct cifs_sb_info *cifs_sb,
+				   const char *full_path,
 				   struct kvec *rsp_iov,
 				   struct cifs_open_info_data *data);
 	int (*create_reparse_symlink)(const unsigned int xid,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index d312ea9776ce5..0c6468844c4b5 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -668,6 +668,7 @@ char *extract_hostname(const char *unc);
 char *extract_sharename(const char *unc);
 int parse_reparse_point(struct reparse_data_buffer *buf,
 			u32 plen, struct cifs_sb_info *cifs_sb,
+			const char *full_path,
 			bool unicode, struct cifs_open_info_data *data);
 int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 			 struct dentry *dentry, struct cifs_tcon *tcon,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 527f7982368cd..6d567b1699811 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1115,6 +1115,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 			rc = 0;
 		} else if (iov && server->ops->parse_reparse_point) {
 			rc = server->ops->parse_reparse_point(cifs_sb,
+							      full_path,
 							      iov, data);
 		}
 		break;
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 90da1e2b6217b..f74d0a86f44a4 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -535,9 +535,76 @@ static int parse_reparse_posix(struct reparse_posix_data *buf,
 	return 0;
 }
 
+int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
+			      bool unicode, bool relative,
+			      const char *full_path,
+			      struct cifs_sb_info *cifs_sb)
+{
+	char sep = CIFS_DIR_SEP(cifs_sb);
+	char *linux_target = NULL;
+	char *smb_target = NULL;
+	int levels;
+	int rc;
+	int i;
+
+	smb_target = cifs_strndup_from_utf16(buf, len, unicode, cifs_sb->local_nls);
+	if (!smb_target) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	if (smb_target[0] == sep && relative) {
+		/*
+		 * This is a relative SMB symlink from the top of the share,
+		 * which is the top level directory of the Linux mount point.
+		 * Linux does not support such relative symlinks, so convert
+		 * it to the relative symlink from the current directory.
+		 * full_path is the SMB path to the symlink (from which is
+		 * extracted current directory) and smb_target is the SMB path
+		 * where symlink points, therefore full_path must always be on
+		 * the SMB share.
+		 */
+		int smb_target_len = strlen(smb_target)+1;
+		levels = 0;
+		for (i = 1; full_path[i]; i++) { /* i=1 to skip leading sep */
+			if (full_path[i] == sep)
+				levels++;
+		}
+		linux_target = kmalloc(levels*3 + smb_target_len, GFP_KERNEL);
+		if (!linux_target) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		for (i = 0; i < levels; i++) {
+			linux_target[i*3 + 0] = '.';
+			linux_target[i*3 + 1] = '.';
+			linux_target[i*3 + 2] = sep;
+		}
+		memcpy(linux_target + levels*3, smb_target+1, smb_target_len); /* +1 to skip leading sep */
+	} else {
+		linux_target = smb_target;
+		smb_target = NULL;
+	}
+
+	if (sep == '\\')
+		convert_delimiter(linux_target, '/');
+
+	rc = 0;
+	*target = linux_target;
+
+	cifs_dbg(FYI, "%s: symlink target: %s\n", __func__, *target);
+
+out:
+	if (rc != 0)
+		kfree(linux_target);
+	kfree(smb_target);
+	return rc;
+}
+
 static int parse_reparse_symlink(struct reparse_symlink_data_buffer *sym,
 				 u32 plen, bool unicode,
 				 struct cifs_sb_info *cifs_sb,
+				 const char *full_path,
 				 struct cifs_open_info_data *data)
 {
 	unsigned int len;
@@ -552,20 +619,18 @@ static int parse_reparse_symlink(struct reparse_symlink_data_buffer *sym,
 		return -EIO;
 	}
 
-	data->symlink_target = cifs_strndup_from_utf16(sym->PathBuffer + offs,
-						       len, unicode,
-						       cifs_sb->local_nls);
-	if (!data->symlink_target)
-		return -ENOMEM;
-
-	convert_delimiter(data->symlink_target, '/');
-	cifs_dbg(FYI, "%s: target path: %s\n", __func__, data->symlink_target);
-
-	return 0;
+	return smb2_parse_native_symlink(&data->symlink_target,
+					 sym->PathBuffer + offs,
+					 len,
+					 unicode,
+					 le32_to_cpu(sym->Flags) & SYMLINK_FLAG_RELATIVE,
+					 full_path,
+					 cifs_sb);
 }
 
 int parse_reparse_point(struct reparse_data_buffer *buf,
 			u32 plen, struct cifs_sb_info *cifs_sb,
+			const char *full_path,
 			bool unicode, struct cifs_open_info_data *data)
 {
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
@@ -580,7 +645,7 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 	case IO_REPARSE_TAG_SYMLINK:
 		return parse_reparse_symlink(
 			(struct reparse_symlink_data_buffer *)buf,
-			plen, unicode, cifs_sb, data);
+			plen, unicode, cifs_sb, full_path, data);
 	case IO_REPARSE_TAG_LX_SYMLINK:
 	case IO_REPARSE_TAG_AF_UNIX:
 	case IO_REPARSE_TAG_LX_FIFO:
@@ -596,6 +661,7 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 }
 
 int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+			     const char *full_path,
 			     struct kvec *rsp_iov,
 			     struct cifs_open_info_data *data)
 {
@@ -605,7 +671,7 @@ int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 
 	buf = (struct reparse_data_buffer *)((u8 *)io +
 					     le32_to_cpu(io->OutputOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, true, data);
+	return parse_reparse_point(buf, plen, cifs_sb, full_path, true, data);
 }
 
 static void wsl_to_fattr(struct cifs_open_info_data *data,
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 2a9f4f9f79de0..ff05b0e75c928 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -117,7 +117,9 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 int smb2_mknod_reparse(unsigned int xid, struct inode *inode,
 		       struct dentry *dentry, struct cifs_tcon *tcon,
 		       const char *full_path, umode_t mode, dev_t dev);
-int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb, struct kvec *rsp_iov,
+int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+			     const char *full_path,
+			     struct kvec *rsp_iov,
 			     struct cifs_open_info_data *data);
 
 #endif /* _CIFS_REPARSE_H */
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 9a6ece66c4d34..abca214f923c2 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -994,6 +994,7 @@ static int cifs_query_symlink(const unsigned int xid,
 }
 
 static int cifs_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+				    const char *full_path,
 				    struct kvec *rsp_iov,
 				    struct cifs_open_info_data *data)
 {
@@ -1004,7 +1005,7 @@ static int cifs_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 
 	buf = (struct reparse_data_buffer *)((__u8 *)&io->hdr.Protocol +
 					     le32_to_cpu(io->DataOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, unicode, data);
+	return parse_reparse_point(buf, plen, cifs_sb, full_path, unicode, data);
 }
 
 static bool
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index e301349b0078d..e836bc2193ddd 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -63,12 +63,12 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 	return sym;
 }
 
-int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec *iov, char **path)
+int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec *iov,
+				const char *full_path, char **path)
 {
 	struct smb2_symlink_err_rsp *sym;
 	unsigned int sub_offs, sub_len;
 	unsigned int print_offs, print_len;
-	char *s;
 
 	if (!cifs_sb || !iov || !iov->iov_base || !iov->iov_len || !path)
 		return -EINVAL;
@@ -86,15 +86,13 @@ int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec
 	    iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + print_offs + print_len)
 		return -EINVAL;
 
-	s = cifs_strndup_from_utf16((char *)sym->PathBuffer + sub_offs, sub_len, true,
-				    cifs_sb->local_nls);
-	if (!s)
-		return -ENOMEM;
-	convert_delimiter(s, '/');
-	cifs_dbg(FYI, "%s: symlink target: %s\n", __func__, s);
-
-	*path = s;
-	return 0;
+	return smb2_parse_native_symlink(path,
+					 (char *)sym->PathBuffer + sub_offs,
+					 sub_len,
+					 true,
+					 le32_to_cpu(sym->Flags) & SYMLINK_FLAG_RELATIVE,
+					 full_path,
+					 cifs_sb);
 }
 
 int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock, void *buf)
@@ -126,6 +124,7 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32
 			goto out;
 		if (hdr->Status == STATUS_STOPPED_ON_SYMLINK) {
 			rc = smb2_parse_symlink_response(oparms->cifs_sb, &err_iov,
+							 oparms->path,
 							 &data->symlink_target);
 			if (!rc) {
 				memset(smb2_data, 0, sizeof(*smb2_data));
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index e49d0c25eb038..a188908914fe8 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -828,6 +828,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int parse_create_response(struct cifs_open_info_data *data,
 				 struct cifs_sb_info *cifs_sb,
+				 const char *full_path,
 				 const struct kvec *iov)
 {
 	struct smb2_create_rsp *rsp = iov->iov_base;
@@ -841,6 +842,7 @@ static int parse_create_response(struct cifs_open_info_data *data,
 		break;
 	case STATUS_STOPPED_ON_SYMLINK:
 		rc = smb2_parse_symlink_response(cifs_sb, iov,
+						 full_path,
 						 &data->symlink_target);
 		if (rc)
 			return rc;
@@ -930,14 +932,14 @@ int smb2_query_path_info(const unsigned int xid,
 
 	switch (rc) {
 	case 0:
-		rc = parse_create_response(data, cifs_sb, &out_iov[0]);
+		rc = parse_create_response(data, cifs_sb, full_path, &out_iov[0]);
 		break;
 	case -EOPNOTSUPP:
 		/*
 		 * BB TODO: When support for special files added to Samba
 		 * re-verify this path.
 		 */
-		rc = parse_create_response(data, cifs_sb, &out_iov[0]);
+		rc = parse_create_response(data, cifs_sb, full_path, &out_iov[0]);
 		if (rc || !data->reparse_point)
 			goto out;
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 71504b30909e1..09349fa8da039 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -111,7 +111,14 @@ extern int smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
 			  const unsigned char *path, char *pbuf,
 			  unsigned int *pbytes_read);
-int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec *iov, char **path);
+int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
+			      bool unicode, bool relative,
+			      const char *full_path,
+			      struct cifs_sb_info *cifs_sb);
+int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb,
+				const struct kvec *iov,
+				const char *full_path,
+				char **path);
 int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
 		   void *buf);
 extern int smb2_unlock_range(struct cifsFileInfo *cfile,
-- 
2.43.0




