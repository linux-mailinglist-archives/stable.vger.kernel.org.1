Return-Path: <stable+bounces-45916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5098CD48A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E931B235AD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E414A635;
	Thu, 23 May 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpYOkMb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FF13BAE2;
	Thu, 23 May 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470732; cv=none; b=cEJPXIw0krpvY8KlVRSw3h/T3cScCpixtwvgachu0q49Xfxml3kh5THfQb3D2mfqF7I4Xc+/IA+wZt29aF8Xp5nWTj+JxrRrEd0Wpw1Tcmku8CunIsEobrGazYhQAtDeSj0tpNRY/2P/RUc3t1zoDokFEtBcVDuHqUQRTqCQsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470732; c=relaxed/simple;
	bh=YrPc2nQPxVqv8aTFwr+iedFihNTNcLpOMvjbGeF1yio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtntHciMfVZO7Fd0SQ6BQr+lJRfLBCWs3ROVP9ilAjsrBZfS07qvRC9rzBdis2PF6bW/jAcHfkvcUvb08+5yPwSURnHAD5UewRokNV3lgNojMY0MdTTrV0WpHFlUXy5PFWs7xMRnpJZUzG4EQCn9XKCY2fq2rcl1Jr/9JH3bj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpYOkMb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8766C2BD10;
	Thu, 23 May 2024 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470732;
	bh=YrPc2nQPxVqv8aTFwr+iedFihNTNcLpOMvjbGeF1yio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpYOkMb/ufSlH07EHthxB0ioBZf7f8gXHMphyjLPFjUD3CbTg6SLsk9R+6DTM24eN
	 2QBkjD5e9Keg/9rReqE6gll9xW4BKP5laoq/kbgpF1JJXm+xNyFRlnjEA93Kv4Yo8Y
	 RUmYXRB7ZtCJq/hjsKZ+EkVAUbwjG0u5rm7QAVRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 051/102] smb: client: introduce SMB2_OP_QUERY_WSL_EA
Date: Thu, 23 May 2024 15:13:16 +0200
Message-ID: <20240523130344.388709829@linuxfoundation.org>
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

[ Upstream commit ea41367b2a602f602ea6594fc4a310520dcc64f4 ]

Add a new command to smb2_compound_op() for querying WSL extended
attributes from reparse points.

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |   5 ++
 fs/smb/client/reparse.c   |  10 +--
 fs/smb/client/smb2glob.h  |   3 +-
 fs/smb/client/smb2inode.c | 170 +++++++++++++++++++++++++++++++++-----
 fs/smb/client/smb2pdu.h   |  25 ++++++
 fs/smb/client/trace.h     |   2 +
 6 files changed, 190 insertions(+), 25 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 54758825fa8d9..ddb64af50a45d 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -214,6 +214,10 @@ struct cifs_open_info_data {
 			struct reparse_posix_data *posix;
 		};
 	} reparse;
+	struct {
+		__u8		eas[SMB2_WSL_MAX_QUERY_EA_RESP_SIZE];
+		unsigned int	eas_len;
+	} wsl;
 	char *symlink_target;
 	struct cifs_sid posix_owner;
 	struct cifs_sid posix_group;
@@ -2304,6 +2308,7 @@ struct smb2_compound_vars {
 	struct kvec close_iov;
 	struct smb2_file_rename_info rename_info;
 	struct smb2_file_link_info link_info;
+	struct kvec ea_iov;
 };
 
 static inline bool cifs_ses_exiting(struct cifs_ses *ses)
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 24feeaa32280e..e8be756e6768c 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -205,15 +205,15 @@ static int wsl_set_xattrs(struct inode *inode, umode_t _mode,
 	__le64 dev = cpu_to_le64(((u64)MINOR(_dev) << 32) | MAJOR(_dev));
 	__le64 mode = cpu_to_le64(_mode);
 	struct wsl_xattr xattrs[] = {
-		{ .name = "$LXUID", .value = uid, .size = 4, },
-		{ .name = "$LXGID", .value = gid, .size = 4, },
-		{ .name = "$LXMOD", .value = mode, .size = 4, },
-		{ .name = "$LXDEV", .value = dev, .size = 8, },
+		{ .name = SMB2_WSL_XATTR_UID,  .value = uid,  .size = SMB2_WSL_XATTR_UID_SIZE, },
+		{ .name = SMB2_WSL_XATTR_GID,  .value = gid,  .size = SMB2_WSL_XATTR_GID_SIZE, },
+		{ .name = SMB2_WSL_XATTR_MODE, .value = mode, .size = SMB2_WSL_XATTR_MODE_SIZE, },
+		{ .name = SMB2_WSL_XATTR_DEV,  .value = dev, .size = SMB2_WSL_XATTR_DEV_SIZE, },
 	};
 	size_t cc_len;
 	u32 dlen = 0, next = 0;
 	int i, num_xattrs;
-	u8 name_size = strlen(xattrs[0].name) + 1;
+	u8 name_size = SMB2_WSL_XATTR_NAME_LEN + 1;
 
 	memset(iov, 0, sizeof(*iov));
 
diff --git a/fs/smb/client/smb2glob.h b/fs/smb/client/smb2glob.h
index a0c156996fc51..2466e61551369 100644
--- a/fs/smb/client/smb2glob.h
+++ b/fs/smb/client/smb2glob.h
@@ -36,7 +36,8 @@ enum smb2_compound_ops {
 	SMB2_OP_RMDIR,
 	SMB2_OP_POSIX_QUERY_INFO,
 	SMB2_OP_SET_REPARSE,
-	SMB2_OP_GET_REPARSE
+	SMB2_OP_GET_REPARSE,
+	SMB2_OP_QUERY_WSL_EA,
 };
 
 /* Used when constructing chained read requests. */
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 0e1b9a1552e71..86f8c81791374 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -85,6 +85,82 @@ static int parse_posix_sids(struct cifs_open_info_data *data,
 	return 0;
 }
 
+struct wsl_query_ea {
+	__le32	next;
+	__u8	name_len;
+	__u8	name[SMB2_WSL_XATTR_NAME_LEN + 1];
+} __packed;
+
+#define NEXT_OFF cpu_to_le32(sizeof(struct wsl_query_ea))
+
+static const struct wsl_query_ea wsl_query_eas[] = {
+	{ .next = NEXT_OFF, .name_len = SMB2_WSL_XATTR_NAME_LEN, .name = SMB2_WSL_XATTR_UID, },
+	{ .next = NEXT_OFF, .name_len = SMB2_WSL_XATTR_NAME_LEN, .name = SMB2_WSL_XATTR_GID, },
+	{ .next = NEXT_OFF, .name_len = SMB2_WSL_XATTR_NAME_LEN, .name = SMB2_WSL_XATTR_MODE, },
+	{ .next = 0,        .name_len = SMB2_WSL_XATTR_NAME_LEN, .name = SMB2_WSL_XATTR_DEV, },
+};
+
+static int check_wsl_eas(struct kvec *rsp_iov)
+{
+	struct smb2_file_full_ea_info *ea;
+	struct smb2_query_info_rsp *rsp = rsp_iov->iov_base;
+	unsigned long addr;
+	u32 outlen, next;
+	u16 vlen;
+	u8 nlen;
+	u8 *end;
+
+	outlen = le32_to_cpu(rsp->OutputBufferLength);
+	if (outlen < SMB2_WSL_MIN_QUERY_EA_RESP_SIZE ||
+	    outlen > SMB2_WSL_MAX_QUERY_EA_RESP_SIZE)
+		return -EINVAL;
+
+	ea = (void *)((u8 *)rsp_iov->iov_base +
+		      le16_to_cpu(rsp->OutputBufferOffset));
+	end = (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
+	for (;;) {
+		if ((u8 *)ea > end - sizeof(*ea))
+			return -EINVAL;
+
+		nlen = ea->ea_name_length;
+		vlen = le16_to_cpu(ea->ea_value_length);
+		if (nlen != SMB2_WSL_XATTR_NAME_LEN ||
+		    (u8 *)ea + nlen + 1 + vlen > end)
+			return -EINVAL;
+
+		switch (vlen) {
+		case 4:
+			if (strncmp(ea->ea_data, SMB2_WSL_XATTR_UID, nlen) &&
+			    strncmp(ea->ea_data, SMB2_WSL_XATTR_GID, nlen) &&
+			    strncmp(ea->ea_data, SMB2_WSL_XATTR_MODE, nlen))
+				return -EINVAL;
+			break;
+		case 8:
+			if (strncmp(ea->ea_data, SMB2_WSL_XATTR_DEV, nlen))
+				return -EINVAL;
+			break;
+		case 0:
+			if (!strncmp(ea->ea_data, SMB2_WSL_XATTR_UID, nlen) ||
+			    !strncmp(ea->ea_data, SMB2_WSL_XATTR_GID, nlen) ||
+			    !strncmp(ea->ea_data, SMB2_WSL_XATTR_MODE, nlen) ||
+			    !strncmp(ea->ea_data, SMB2_WSL_XATTR_DEV, nlen))
+				break;
+			fallthrough;
+		default:
+			return -EINVAL;
+		}
+
+		next = le32_to_cpu(ea->next_entry_offset);
+		if (!next)
+			break;
+		if (!IS_ALIGNED(next, 4) ||
+		    check_add_overflow((unsigned long)ea, next, &addr))
+			return -EINVAL;
+		ea = (void *)addr;
+	}
+	return 0;
+}
+
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
@@ -119,7 +195,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	__u8 delete_pending[8] = {1, 0, 0, 0, 0, 0, 0, 0};
 	unsigned int size[2];
 	void *data[2];
-	int len;
+	unsigned int len;
 	int retries = 0, cur_sleep = 1;
 
 replay_again:
@@ -476,6 +552,39 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			trace_smb3_get_reparse_compound_enter(xid, ses->Suid,
 							      tcon->tid, full_path);
 			break;
+		case SMB2_OP_QUERY_WSL_EA:
+			rqst[num_rqst].rq_iov = &vars->ea_iov;
+			rqst[num_rqst].rq_nvec = 1;
+
+			if (cfile) {
+				rc = SMB2_query_info_init(tcon, server,
+							  &rqst[num_rqst],
+							  cfile->fid.persistent_fid,
+							  cfile->fid.volatile_fid,
+							  FILE_FULL_EA_INFORMATION,
+							  SMB2_O_INFO_FILE, 0,
+							  SMB2_WSL_MAX_QUERY_EA_RESP_SIZE,
+							  sizeof(wsl_query_eas),
+							  (void *)wsl_query_eas);
+			} else {
+				rc = SMB2_query_info_init(tcon, server,
+							  &rqst[num_rqst],
+							  COMPOUND_FID,
+							  COMPOUND_FID,
+							  FILE_FULL_EA_INFORMATION,
+							  SMB2_O_INFO_FILE, 0,
+							  SMB2_WSL_MAX_QUERY_EA_RESP_SIZE,
+							  sizeof(wsl_query_eas),
+							  (void *)wsl_query_eas);
+			}
+			if (!rc && (!cfile || num_rqst > 1)) {
+				smb2_set_next_command(tcon, &rqst[num_rqst]);
+				smb2_set_related(&rqst[num_rqst]);
+			} else if (rc) {
+				goto finished;
+			}
+			num_rqst++;
+			break;
 		default:
 			cifs_dbg(VFS, "Invalid command\n");
 			rc = -EINVAL;
@@ -665,11 +774,32 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 				memset(iov, 0, sizeof(*iov));
 				resp_buftype[i + 1] = CIFS_NO_BUFFER;
 			} else {
-				trace_smb3_set_reparse_compound_err(xid,  ses->Suid,
+				trace_smb3_set_reparse_compound_err(xid, ses->Suid,
 								    tcon->tid, rc);
 			}
 			SMB2_ioctl_free(&rqst[num_rqst++]);
 			break;
+		case SMB2_OP_QUERY_WSL_EA:
+			if (!rc) {
+				idata = in_iov[i].iov_base;
+				qi_rsp = rsp_iov[i + 1].iov_base;
+				data[0] = (u8 *)qi_rsp + le16_to_cpu(qi_rsp->OutputBufferOffset);
+				size[0] = le32_to_cpu(qi_rsp->OutputBufferLength);
+				rc = check_wsl_eas(&rsp_iov[i + 1]);
+				if (!rc) {
+					memcpy(idata->wsl.eas, data[0], size[0]);
+					idata->wsl.eas_len = size[0];
+				}
+			}
+			if (!rc) {
+				trace_smb3_query_wsl_ea_compound_done(xid, ses->Suid,
+								      tcon->tid);
+			} else {
+				trace_smb3_query_wsl_ea_compound_err(xid, ses->Suid,
+								     tcon->tid, rc);
+			}
+			SMB2_query_info_free(&rqst[num_rqst++]);
+			break;
 		}
 	}
 	SMB2_close_free(&rqst[num_rqst]);
@@ -737,11 +867,11 @@ int smb2_query_path_info(const unsigned int xid,
 	struct cifsFileInfo *cfile;
 	struct cached_fid *cfid = NULL;
 	struct smb2_hdr *hdr;
-	struct kvec in_iov[2], out_iov[3] = {};
+	struct kvec in_iov[3], out_iov[3] = {};
 	int out_buftype[3] = {};
-	int cmds[2];
+	int cmds[3];
 	bool islink;
-	int i, num_cmds;
+	int i, num_cmds = 0;
 	int rc, rc2;
 
 	data->adjust_tz = false;
@@ -774,21 +904,22 @@ int smb2_query_path_info(const unsigned int xid,
 			close_cached_dir(cfid);
 			return rc;
 		}
-		cmds[0] = SMB2_OP_QUERY_INFO;
+		cmds[num_cmds++] = SMB2_OP_QUERY_INFO;
 	} else {
-		cmds[0] = SMB2_OP_POSIX_QUERY_INFO;
+		cmds[num_cmds++] = SMB2_OP_POSIX_QUERY_INFO;
 	}
 
 	in_iov[0].iov_base = data;
 	in_iov[0].iov_len = sizeof(*data);
 	in_iov[1] = in_iov[0];
+	in_iov[2] = in_iov[0];
 
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	oparms = CIFS_OPARMS(cifs_sb, tcon, full_path, FILE_READ_ATTRIBUTES,
 			     FILE_OPEN, create_options, ACL_NO_MODE);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
-			      &oparms, in_iov, cmds, 1, cfile,
-			      out_iov, out_buftype, NULL);
+			      &oparms, in_iov, cmds, num_cmds,
+			      cfile, out_iov, out_buftype, NULL);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -808,17 +939,18 @@ int smb2_query_path_info(const unsigned int xid,
 		if (rc || !data->reparse_point)
 			goto out;
 
-		if (data->reparse.tag == IO_REPARSE_TAG_SYMLINK) {
-			/* symlink already parsed in create response */
-			num_cmds = 1;
-		} else {
-			cmds[1] = SMB2_OP_GET_REPARSE;
-			num_cmds = 2;
-		}
+		cmds[num_cmds++] = SMB2_OP_QUERY_WSL_EA;
+		/*
+		 * Skip SMB2_OP_GET_REPARSE if symlink already parsed in create
+		 * response.
+		 */
+		if (data->reparse.tag != IO_REPARSE_TAG_SYMLINK)
+			cmds[num_cmds++] = SMB2_OP_GET_REPARSE;
+
 		oparms = CIFS_OPARMS(cifs_sb, tcon, full_path,
-				     FILE_READ_ATTRIBUTES, FILE_OPEN,
-				     create_options | OPEN_REPARSE_POINT,
-				     ACL_NO_MODE);
+				     FILE_READ_ATTRIBUTES | FILE_READ_EA,
+				     FILE_OPEN, create_options |
+				     OPEN_REPARSE_POINT, ACL_NO_MODE);
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      &oparms, in_iov, cmds, num_cmds,
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 3334f2c364fb9..2fccf0d4f53d2 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -420,4 +420,29 @@ struct smb2_create_ea_ctx {
 	struct smb2_file_full_ea_info ea;
 } __packed;
 
+#define SMB2_WSL_XATTR_UID		"$LXUID"
+#define SMB2_WSL_XATTR_GID		"$LXGID"
+#define SMB2_WSL_XATTR_MODE		"$LXMOD"
+#define SMB2_WSL_XATTR_DEV		"$LXDEV"
+#define SMB2_WSL_XATTR_NAME_LEN	6
+#define SMB2_WSL_NUM_XATTRS		4
+
+#define SMB2_WSL_XATTR_UID_SIZE	4
+#define SMB2_WSL_XATTR_GID_SIZE	4
+#define SMB2_WSL_XATTR_MODE_SIZE	4
+#define SMB2_WSL_XATTR_DEV_SIZE	8
+
+#define SMB2_WSL_MIN_QUERY_EA_RESP_SIZE \
+	(ALIGN((SMB2_WSL_NUM_XATTRS - 1) * \
+	       (SMB2_WSL_XATTR_NAME_LEN + 1 + \
+		sizeof(struct smb2_file_full_ea_info)), 4) + \
+	 SMB2_WSL_XATTR_NAME_LEN + 1 + sizeof(struct smb2_file_full_ea_info))
+
+#define SMB2_WSL_MAX_QUERY_EA_RESP_SIZE \
+	(ALIGN(SMB2_WSL_MIN_QUERY_EA_RESP_SIZE + \
+	       SMB2_WSL_XATTR_UID_SIZE + \
+	       SMB2_WSL_XATTR_GID_SIZE + \
+	       SMB2_WSL_XATTR_MODE_SIZE + \
+	       SMB2_WSL_XATTR_DEV_SIZE, 4))
+
 #endif				/* _SMB2PDU_H */
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 522fa387fcfd7..ce90ae0d77f84 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -411,6 +411,7 @@ DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(set_eof_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(set_info_compound_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(set_reparse_compound_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(get_reparse_compound_done);
+DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(query_wsl_ea_compound_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(delete_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(mkdir_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(tdis_done);
@@ -456,6 +457,7 @@ DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(set_eof_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(set_info_compound_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(set_reparse_compound_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(get_reparse_compound_err);
+DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(query_wsl_ea_compound_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(mkdir_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(delete_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(tdis_err);
-- 
2.43.0




