Return-Path: <stable+bounces-45927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91768CD499
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487661F23160
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671214B061;
	Thu, 23 May 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RU6ivNUx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963714AD38;
	Thu, 23 May 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470763; cv=none; b=XbCb77AESMAPsZHdudoLga7zOSbOdlglDaGS19jSoZi3/uGnr0e5q0YD/iATEy01nxVXDXUowKuJEPEPr5WOWc4sgHxrf+SS/UHg/0HanQOC7/bIMnQkSC8/lWAEOhjMU+k8XSsqSJ/0lRZM4Blqo0WW2rhyD0OfB86E8Y17Ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470763; c=relaxed/simple;
	bh=DvbRP32WXTe/wDNsgM+Utj2wM6TgBEBswbaqwwZwV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOT9gh8XN1wP+Zun3PPRFguJoZSHD4lLeYbf8pRIMfGIUA/FItL6bScXbwdiwq2ob1/pLbvgL1yxPsNpnc9tI4lDEzKZFQII65h0pwMefbvrUsw/kTXjHosYlIk9RdEMS/p7/6IXs202pnUWs9vgFW5Woi+HSlsYdlFM+K13g/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RU6ivNUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673CCC4AF0A;
	Thu, 23 May 2024 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470763;
	bh=DvbRP32WXTe/wDNsgM+Utj2wM6TgBEBswbaqwwZwV9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RU6ivNUxCHGqDPljf5tH3jfCUeWe7akwlnx7pFCgZ1zu/eSj9bW6kgjubYAv8n7vf
	 BxERmKFHvF3O7GhGL2stN2D2vfOIbqrG3lpdYCj276mRLEE8X2FU1SfnRxVLe4yu3j
	 QU93AS1/Bv8SIWDhi8fapscMiikGV7OP21/Pj00g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 052/102] smb: client: parse uid, gid, mode and dev from WSL reparse points
Date: Thu, 23 May 2024 15:13:17 +0200
Message-ID: <20240523130344.427692417@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 78e26bec4d6d3aef04276e28bed48a45fd00e116 ]

Parse the extended attributes from WSL reparse points to correctly
report uid, gid mode and dev from ther instantiated inodes.

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c   |  5 ++-
 fs/smb/client/readdir.c |  2 ++
 fs/smb/client/reparse.c | 78 +++++++++++++++++++++++++++++++++--------
 fs/smb/client/reparse.h | 29 +++++++++++++++
 4 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 8aff8382cfb54..67bc1a1e54fde 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -759,6 +759,8 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 	fattr->cf_bytes = le64_to_cpu(info->AllocationSize);
 	fattr->cf_createtime = le64_to_cpu(info->CreationTime);
 	fattr->cf_nlink = le32_to_cpu(info->NumberOfLinks);
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
 
 	fattr->cf_mode = cifs_sb->ctx->file_mode;
 	if (cifs_open_data_reparse(data) &&
@@ -801,9 +803,6 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 		fattr->cf_symlink_target = data->symlink_target;
 		data->symlink_target = NULL;
 	}
-
-	fattr->cf_uid = cifs_sb->ctx->linux_uid;
-	fattr->cf_gid = cifs_sb->ctx->linux_gid;
 }
 
 static int
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 3e5d22b356e92..06111d9f39500 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -125,6 +125,8 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 					if (likely(reparse_inode_match(inode, fattr))) {
 						fattr->cf_mode = inode->i_mode;
 						fattr->cf_rdev = inode->i_rdev;
+						fattr->cf_uid = inode->i_uid;
+						fattr->cf_gid = inode->i_gid;
 						fattr->cf_eof = CIFS_I(inode)->server_eof;
 						fattr->cf_symlink_target = NULL;
 					} else {
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index e8be756e6768c..29a47f20643b1 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -258,7 +258,9 @@ static int mknod_wsl(unsigned int xid, struct inode *inode,
 {
 	struct cifs_open_info_data data;
 	struct reparse_data_buffer buf;
+	struct smb2_create_ea_ctx *cc;
 	struct inode *new;
+	unsigned int len;
 	struct kvec reparse_iov, xattr_iov;
 	int rc;
 
@@ -275,6 +277,11 @@ static int mknod_wsl(unsigned int xid, struct inode *inode,
 		.reparse = { .tag = le32_to_cpu(buf.ReparseTag), .buf = &buf, },
 	};
 
+	cc = xattr_iov.iov_base;
+	len = le32_to_cpu(cc->ctx.DataLength);
+	memcpy(data.wsl.eas, &cc->ea, len);
+	data.wsl.eas_len = len;
+
 	new = smb2_get_reparse_inode(&data, inode->i_sb,
 				     xid, tcon, full_path,
 				     &reparse_iov, &xattr_iov);
@@ -408,6 +415,62 @@ int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 	return parse_reparse_point(buf, plen, cifs_sb, true, data);
 }
 
+static void wsl_to_fattr(struct cifs_open_info_data *data,
+			 struct cifs_sb_info *cifs_sb,
+			 u32 tag, struct cifs_fattr *fattr)
+{
+	struct smb2_file_full_ea_info *ea;
+	u32 next = 0;
+
+	switch (tag) {
+	case IO_REPARSE_TAG_LX_SYMLINK:
+		fattr->cf_mode |= S_IFLNK;
+		break;
+	case IO_REPARSE_TAG_LX_FIFO:
+		fattr->cf_mode |= S_IFIFO;
+		break;
+	case IO_REPARSE_TAG_AF_UNIX:
+		fattr->cf_mode |= S_IFSOCK;
+		break;
+	case IO_REPARSE_TAG_LX_CHR:
+		fattr->cf_mode |= S_IFCHR;
+		break;
+	case IO_REPARSE_TAG_LX_BLK:
+		fattr->cf_mode |= S_IFBLK;
+		break;
+	}
+
+	if (!data->wsl.eas_len)
+		goto out;
+
+	ea = (struct smb2_file_full_ea_info *)data->wsl.eas;
+	do {
+		const char *name;
+		void *v;
+		u8 nlen;
+
+		ea = (void *)((u8 *)ea + next);
+		next = le32_to_cpu(ea->next_entry_offset);
+		if (!le16_to_cpu(ea->ea_value_length))
+			continue;
+
+		name = ea->ea_data;
+		nlen = ea->ea_name_length;
+		v = (void *)((u8 *)ea->ea_data + ea->ea_name_length + 1);
+
+		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen))
+			fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
+		else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen))
+			fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
+		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen))
+			fattr->cf_mode = (umode_t)le32_to_cpu(*(__le32 *)v);
+		else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen))
+			fattr->cf_rdev = wsl_mkdev(v);
+	} while (next);
+out:
+	fattr->cf_dtype = S_DT(fattr->cf_mode);
+}
+
 bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 				 struct cifs_fattr *fattr,
 				 struct cifs_open_info_data *data)
@@ -448,24 +511,11 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
-		fattr->cf_mode |= S_IFLNK;
-		fattr->cf_dtype = DT_LNK;
-		break;
 	case IO_REPARSE_TAG_LX_FIFO:
-		fattr->cf_mode |= S_IFIFO;
-		fattr->cf_dtype = DT_FIFO;
-		break;
 	case IO_REPARSE_TAG_AF_UNIX:
-		fattr->cf_mode |= S_IFSOCK;
-		fattr->cf_dtype = DT_SOCK;
-		break;
 	case IO_REPARSE_TAG_LX_CHR:
-		fattr->cf_mode |= S_IFCHR;
-		fattr->cf_dtype = DT_CHR;
-		break;
 	case IO_REPARSE_TAG_LX_BLK:
-		fattr->cf_mode |= S_IFBLK;
-		fattr->cf_dtype = DT_BLK;
+		wsl_to_fattr(data, cifs_sb, tag, fattr);
 		break;
 	case 0: /* SMB1 symlink */
 	case IO_REPARSE_TAG_SYMLINK:
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 9816bac985525..6b55d1df9e2f8 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -8,6 +8,8 @@
 
 #include <linux/fs.h>
 #include <linux/stat.h>
+#include <linux/uidgid.h>
+#include "fs_context.h"
 #include "cifsglob.h"
 
 static inline dev_t reparse_nfs_mkdev(struct reparse_posix_data *buf)
@@ -17,6 +19,33 @@ static inline dev_t reparse_nfs_mkdev(struct reparse_posix_data *buf)
 	return MKDEV(v >> 32, v & 0xffffffff);
 }
 
+static inline dev_t wsl_mkdev(void *ptr)
+{
+	u64 v = le64_to_cpu(*(__le64 *)ptr);
+
+	return MKDEV(v & 0xffffffff, v >> 32);
+}
+
+static inline kuid_t wsl_make_kuid(struct cifs_sb_info *cifs_sb,
+				   void *ptr)
+{
+	u32 uid = le32_to_cpu(*(__le32 *)ptr);
+
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_OVERR_UID)
+		return cifs_sb->ctx->linux_uid;
+	return make_kuid(current_user_ns(), uid);
+}
+
+static inline kgid_t wsl_make_kgid(struct cifs_sb_info *cifs_sb,
+				   void *ptr)
+{
+	u32 gid = le32_to_cpu(*(__le32 *)ptr);
+
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_OVERR_GID)
+		return cifs_sb->ctx->linux_gid;
+	return make_kgid(current_user_ns(), gid);
+}
+
 static inline u64 reparse_mode_nfs_type(mode_t mode)
 {
 	switch (mode & S_IFMT) {
-- 
2.43.0




