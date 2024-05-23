Return-Path: <stable+bounces-45937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965B18CD4A4
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE528624A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454113C66A;
	Thu, 23 May 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyZgwsq3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F401D545;
	Thu, 23 May 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470792; cv=none; b=EBm/HDV5n9exD2b9rdoZsFyv8siKaTxqDHGt4HCX6oN8TVm6OAhD9FyHcbt664giYp8DxqS73u6NJw3dd6E39paiTDP5AWTaHLHHJCtGfN7kb1V8I9O/K1rOg2q9WU0MX4Kmw18leWD0ixmcNl/Ye9kTxLwDsTpROKLBwbn1KNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470792; c=relaxed/simple;
	bh=RzD2Jr+mBwQicPaa8/MVL15mMBm9ZV7+F5rq394Lnho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl4Blq2/hMSGAIL5iQ4fzd4L2IUTHFK68v9MC8U19QCVlySQuYXn7DDjy53O0cC76IiuUpY/63/xhBLasuZ/1s/XYgikk6kEVONqFJtCwR7Qr0w1w3xYw+3Qh4BDuZWFgEIZOQ0gCmH9vzG+l6KjT397Mi12K7WsTy4fL0uzMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyZgwsq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A3C32782;
	Thu, 23 May 2024 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470792;
	bh=RzD2Jr+mBwQicPaa8/MVL15mMBm9ZV7+F5rq394Lnho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyZgwsq3QAIS0qr5jR1S56CCzRNnrFBh5C24CPojWtHXHaiY6SQwG9AYPUibPYtex
	 QyfaYe2uX5ud7A76ljaFk6umHkmmGSwnFv2jeqdLS0AHSrOju0KcJjPzvHbvghFPYj
	 caM786363zszTeIREiiKKsoRG/HrLtFcCPJmPz/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/102] smb: client: add support for WSL reparse points
Date: Thu, 23 May 2024 15:13:14 +0200
Message-ID: <20240523130344.314371167@linuxfoundation.org>
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

[ Upstream commit 5a4b09ecf8e8ad26ea03a37e52e310fe13f15b49 ]

Add support for creating special files via WSL reparse points when
using 'reparse=wsl' mount option.  They're faster than NFS reparse
points because they don't require extra roundtrips to figure out what
->d_type a specific dirent is as such information is already stored in
query dir responses and then making getdents() calls faster.

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h   |   1 +
 fs/smb/client/fs_context.c |   4 +-
 fs/smb/client/reparse.c    | 170 +++++++++++++++++++++++++++++++++++--
 fs/smb/client/reparse.h    |  13 ++-
 fs/smb/client/smb2inode.c  |   8 +-
 fs/smb/client/smb2ops.c    |   2 +-
 fs/smb/client/smb2pdu.c    |  12 +++
 fs/smb/client/smb2pdu.h    |  11 ++-
 fs/smb/client/smb2proto.h  |   3 +-
 fs/smb/common/smbfsctl.h   |   6 --
 10 files changed, 210 insertions(+), 20 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 5a902fb20ac96..54758825fa8d9 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1379,6 +1379,7 @@ struct cifs_open_parms {
 	umode_t mode;
 	bool reconnect:1;
 	bool replay:1; /* indicates that this open is for a replay */
+	struct kvec *ea_cctx;
 };
 
 struct cifs_fid {
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 535885fbdf51d..fbaa901d3493a 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -318,8 +318,8 @@ static int parse_reparse_flavor(struct fs_context *fc, char *value,
 		ctx->reparse_type = CIFS_REPARSE_TYPE_NFS;
 		break;
 	case Opt_reparse_wsl:
-		cifs_errorf(fc, "unsupported reparse= option: %s\n", value);
-		return 1;
+		ctx->reparse_type = CIFS_REPARSE_TYPE_WSL;
+		break;
 	default:
 		cifs_errorf(fc, "bad reparse= option: %s\n", value);
 		return 1;
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index c405be47c84d9..b240ccc9c887c 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -11,6 +11,7 @@
 #include "cifsproto.h"
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
+#include "fs_context.h"
 #include "reparse.h"
 
 int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
@@ -68,7 +69,7 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	iov.iov_base = buf;
 	iov.iov_len = len;
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
-				     tcon, full_path, &iov);
+				     tcon, full_path, &iov, NULL);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
 	else
@@ -114,9 +115,9 @@ static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 	return 0;
 }
 
-int smb2_make_nfs_node(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev)
+static int mknod_nfs(unsigned int xid, struct inode *inode,
+		     struct dentry *dentry, struct cifs_tcon *tcon,
+		     const char *full_path, umode_t mode, dev_t dev)
 {
 	struct cifs_open_info_data data;
 	struct reparse_posix_data *p;
@@ -136,12 +137,171 @@ int smb2_make_nfs_node(unsigned int xid, struct inode *inode,
 	};
 
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
-				     tcon, full_path, &iov);
+				     tcon, full_path, &iov, NULL);
+	if (!IS_ERR(new))
+		d_instantiate(dentry, new);
+	else
+		rc = PTR_ERR(new);
+	cifs_free_open_info(&data);
+	return rc;
+}
+
+static int wsl_set_reparse_buf(struct reparse_data_buffer *buf,
+			       mode_t mode, struct kvec *iov)
+{
+	u32 tag;
+
+	switch ((tag = reparse_mode_wsl_tag(mode))) {
+	case IO_REPARSE_TAG_LX_BLK:
+	case IO_REPARSE_TAG_LX_CHR:
+	case IO_REPARSE_TAG_LX_FIFO:
+	case IO_REPARSE_TAG_AF_UNIX:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	buf->ReparseTag = cpu_to_le32(tag);
+	buf->Reserved = 0;
+	buf->ReparseDataLength = 0;
+	iov->iov_base = buf;
+	iov->iov_len = sizeof(*buf);
+	return 0;
+}
+
+static struct smb2_create_ea_ctx *ea_create_context(u32 dlen, size_t *cc_len)
+{
+	struct smb2_create_ea_ctx *cc;
+
+	*cc_len = round_up(sizeof(*cc) + dlen, 8);
+	cc = kzalloc(*cc_len, GFP_KERNEL);
+	if (!cc)
+		return ERR_PTR(-ENOMEM);
+
+	cc->ctx.NameOffset = cpu_to_le16(offsetof(struct smb2_create_ea_ctx,
+						  name));
+	cc->ctx.NameLength = cpu_to_le16(4);
+	memcpy(cc->name, SMB2_CREATE_EA_BUFFER, strlen(SMB2_CREATE_EA_BUFFER));
+	cc->ctx.DataOffset = cpu_to_le16(offsetof(struct smb2_create_ea_ctx, ea));
+	cc->ctx.DataLength = cpu_to_le32(dlen);
+	return cc;
+}
+
+struct wsl_xattr {
+	const char	*name;
+	__le64		value;
+	u16		size;
+	u32		next;
+};
+
+static int wsl_set_xattrs(struct inode *inode, umode_t _mode,
+			  dev_t _dev, struct kvec *iov)
+{
+	struct smb2_file_full_ea_info *ea;
+	struct smb2_create_ea_ctx *cc;
+	struct smb3_fs_context *ctx = CIFS_SB(inode->i_sb)->ctx;
+	__le64 uid = cpu_to_le64(from_kuid(current_user_ns(), ctx->linux_uid));
+	__le64 gid = cpu_to_le64(from_kgid(current_user_ns(), ctx->linux_gid));
+	__le64 dev = cpu_to_le64(((u64)MINOR(_dev) << 32) | MAJOR(_dev));
+	__le64 mode = cpu_to_le64(_mode);
+	struct wsl_xattr xattrs[] = {
+		{ .name = "$LXUID", .value = uid, .size = 4, },
+		{ .name = "$LXGID", .value = gid, .size = 4, },
+		{ .name = "$LXMOD", .value = mode, .size = 4, },
+		{ .name = "$LXDEV", .value = dev, .size = 8, },
+	};
+	size_t cc_len;
+	u32 dlen = 0, next = 0;
+	int i, num_xattrs;
+	u8 name_size = strlen(xattrs[0].name) + 1;
+
+	memset(iov, 0, sizeof(*iov));
+
+	/* Exclude $LXDEV xattr for sockets and fifos */
+	if (S_ISSOCK(_mode) || S_ISFIFO(_mode))
+		num_xattrs = ARRAY_SIZE(xattrs) - 1;
+	else
+		num_xattrs = ARRAY_SIZE(xattrs);
+
+	for (i = 0; i < num_xattrs; i++) {
+		xattrs[i].next = ALIGN(sizeof(*ea) + name_size +
+				       xattrs[i].size, 4);
+		dlen += xattrs[i].next;
+	}
+
+	cc = ea_create_context(dlen, &cc_len);
+	if (!cc)
+		return PTR_ERR(cc);
+
+	ea = &cc->ea;
+	for (i = 0; i < num_xattrs; i++) {
+		ea = (void *)((u8 *)ea + next);
+		next = xattrs[i].next;
+		ea->next_entry_offset = cpu_to_le32(next);
+
+		ea->ea_name_length = name_size - 1;
+		ea->ea_value_length = cpu_to_le16(xattrs[i].size);
+		memcpy(ea->ea_data, xattrs[i].name, name_size);
+		memcpy(&ea->ea_data[name_size],
+		       &xattrs[i].value, xattrs[i].size);
+	}
+	ea->next_entry_offset = 0;
+
+	iov->iov_base = cc;
+	iov->iov_len = cc_len;
+	return 0;
+}
+
+static int mknod_wsl(unsigned int xid, struct inode *inode,
+		     struct dentry *dentry, struct cifs_tcon *tcon,
+		     const char *full_path, umode_t mode, dev_t dev)
+{
+	struct cifs_open_info_data data;
+	struct reparse_data_buffer buf;
+	struct inode *new;
+	struct kvec reparse_iov, xattr_iov;
+	int rc;
+
+	rc = wsl_set_reparse_buf(&buf, mode, &reparse_iov);
+	if (rc)
+		return rc;
+
+	rc = wsl_set_xattrs(inode, mode, dev, &xattr_iov);
+	if (rc)
+		return rc;
+
+	data = (struct cifs_open_info_data) {
+		.reparse_point = true,
+		.reparse = { .tag = le32_to_cpu(buf.ReparseTag), .buf = &buf, },
+	};
+
+	new = smb2_get_reparse_inode(&data, inode->i_sb,
+				     xid, tcon, full_path,
+				     &reparse_iov, &xattr_iov);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
 	else
 		rc = PTR_ERR(new);
 	cifs_free_open_info(&data);
+	kfree(xattr_iov.iov_base);
+	return rc;
+}
+
+int smb2_mknod_reparse(unsigned int xid, struct inode *inode,
+		       struct dentry *dentry, struct cifs_tcon *tcon,
+		       const char *full_path, umode_t mode, dev_t dev)
+{
+	struct smb3_fs_context *ctx = CIFS_SB(inode->i_sb)->ctx;
+	int rc = -EOPNOTSUPP;
+
+	switch (ctx->reparse_type) {
+	case CIFS_REPARSE_TYPE_NFS:
+		rc = mknod_nfs(xid, inode, dentry, tcon, full_path, mode, dev);
+		break;
+	case CIFS_REPARSE_TYPE_WSL:
+		rc = mknod_wsl(xid, inode, dentry, tcon, full_path, mode, dev);
+		break;
+	}
 	return rc;
 }
 
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 3ceb90da0df90..9816bac985525 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -28,6 +28,17 @@ static inline u64 reparse_mode_nfs_type(mode_t mode)
 	return 0;
 }
 
+static inline u32 reparse_mode_wsl_tag(mode_t mode)
+{
+	switch (mode & S_IFMT) {
+	case S_IFBLK: return IO_REPARSE_TAG_LX_BLK;
+	case S_IFCHR: return IO_REPARSE_TAG_LX_CHR;
+	case S_IFIFO: return IO_REPARSE_TAG_LX_FIFO;
+	case S_IFSOCK: return IO_REPARSE_TAG_AF_UNIX;
+	}
+	return 0;
+}
+
 /*
  * Match a reparse point inode if reparse tag and ctime haven't changed.
  *
@@ -64,7 +75,7 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 				struct dentry *dentry, struct cifs_tcon *tcon,
 				const char *full_path, const char *symname);
-int smb2_make_nfs_node(unsigned int xid, struct inode *inode,
+int smb2_mknod_reparse(unsigned int xid, struct inode *inode,
 		       struct dentry *dentry, struct cifs_tcon *tcon,
 		       const char *full_path, umode_t mode, dev_t dev);
 int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb, struct kvec *rsp_iov,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index e1ad54b27b63e..0e1b9a1552e71 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1060,7 +1060,8 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 				     const unsigned int xid,
 				     struct cifs_tcon *tcon,
 				     const char *full_path,
-				     struct kvec *iov)
+				     struct kvec *reparse_iov,
+				     struct kvec *xattr_iov)
 {
 	struct cifs_open_parms oparms;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
@@ -1077,8 +1078,11 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 			     FILE_CREATE,
 			     CREATE_NOT_DIR | OPEN_REPARSE_POINT,
 			     ACL_NO_MODE);
+	if (xattr_iov)
+		oparms.ea_cctx = xattr_iov;
+
 	cmds[0] = SMB2_OP_SET_REPARSE;
-	in_iov[0] = *iov;
+	in_iov[0] = *reparse_iov;
 	in_iov[1].iov_base = data;
 	in_iov[1].iov_len = sizeof(*data);
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2c59a6fc2d7c7..981a922cf38f0 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5038,7 +5038,7 @@ static int smb2_make_node(unsigned int xid, struct inode *inode,
 		rc = cifs_sfu_make_node(xid, inode, dentry, tcon,
 					full_path, mode, dev);
 	} else {
-		rc = smb2_make_nfs_node(xid, inode, dentry, tcon,
+		rc = smb2_mknod_reparse(xid, inode, dentry, tcon,
 					full_path, mode, dev);
 	}
 	return rc;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 60793143e24c6..4d805933e14f3 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2732,6 +2732,17 @@ add_query_id_context(struct kvec *iov, unsigned int *num_iovec)
 	return 0;
 }
 
+static void add_ea_context(struct cifs_open_parms *oparms,
+			   struct kvec *rq_iov, unsigned int *num_iovs)
+{
+	struct kvec *iov = oparms->ea_cctx;
+
+	if (iov && iov->iov_base && iov->iov_len) {
+		rq_iov[(*num_iovs)++] = *iov;
+		memset(iov, 0, sizeof(*iov));
+	}
+}
+
 static int
 alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 			    const char *treename, const __le16 *path)
@@ -3098,6 +3109,7 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	}
 
 	add_query_id_context(iov, &n_iov);
+	add_ea_context(oparms, iov, &n_iov);
 
 	if (n_iov > 2) {
 		/*
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index b00f707bddfcc..3334f2c364fb9 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -117,9 +117,10 @@ struct share_redirect_error_context_rsp {
  * [4] : posix context
  * [5] : time warp context
  * [6] : query id context
- * [7] : compound padding
+ * [7] : create ea context
+ * [8] : compound padding
  */
-#define SMB2_CREATE_IOV_SIZE 8
+#define SMB2_CREATE_IOV_SIZE 9
 
 /*
  * Maximum size of a SMB2_CREATE response is 64 (smb2 header) +
@@ -413,4 +414,10 @@ struct smb2_posix_info_parsed {
 	const u8 *name;
 };
 
+struct smb2_create_ea_ctx {
+	struct create_context ctx;
+	__u8 name[8];
+	struct smb2_file_full_ea_info ea;
+} __packed;
+
 #endif				/* _SMB2PDU_H */
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 64a0ef0409a6e..732169d8a67a3 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -61,7 +61,8 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 				     const unsigned int xid,
 				     struct cifs_tcon *tcon,
 				     const char *full_path,
-				     struct kvec *iov);
+				     struct kvec *reparse_iov,
+				     struct kvec *xattr_iov);
 int smb2_query_reparse_point(const unsigned int xid,
 			     struct cifs_tcon *tcon,
 			     struct cifs_sb_info *cifs_sb,
diff --git a/fs/smb/common/smbfsctl.h b/fs/smb/common/smbfsctl.h
index edd7fc2a7921b..a94d658b88e86 100644
--- a/fs/smb/common/smbfsctl.h
+++ b/fs/smb/common/smbfsctl.h
@@ -158,12 +158,6 @@
 #define IO_REPARSE_TAG_LX_CHR	     0x80000025
 #define IO_REPARSE_TAG_LX_BLK	     0x80000026
 
-#define IO_REPARSE_TAG_LX_SYMLINK_LE	cpu_to_le32(0xA000001D)
-#define IO_REPARSE_TAG_AF_UNIX_LE	cpu_to_le32(0x80000023)
-#define IO_REPARSE_TAG_LX_FIFO_LE	cpu_to_le32(0x80000024)
-#define IO_REPARSE_TAG_LX_CHR_LE	cpu_to_le32(0x80000025)
-#define IO_REPARSE_TAG_LX_BLK_LE	cpu_to_le32(0x80000026)
-
 /* fsctl flags */
 /* If Flags is set to this value, the request is an FSCTL not ioctl request */
 #define SMB2_0_IOCTL_IS_FSCTL		0x00000001
-- 
2.43.0




