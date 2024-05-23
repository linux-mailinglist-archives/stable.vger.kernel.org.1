Return-Path: <stable+bounces-45904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F08CD47C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BAC285C8C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337914B941;
	Thu, 23 May 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jK3DFwgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FD14AD0E;
	Thu, 23 May 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470697; cv=none; b=lLwG3/z78+GXHf2KOueVhF0wo+4DB3Np8bzDQGvczpp/BNilDwiO7in/G2WD3P9oRUoO4rKqtObBHx5amRf7dhjOJOO/GTXNYPwocMvQs0dNJT1CQoIAR3cOmax0i9aeKoRUxVtvY6tEnUvFos7WAcJaCHV8geS5C0hazdJCnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470697; c=relaxed/simple;
	bh=fM0pZyhqv79jQdDk0PAcxs6t4FO7TGU1d+Ysk9B67qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvGKTJhiyR77J+z1KJ3aia2U29fQQkYiSeWkTQIUwAP5Z80FpuXX2gTGgxrYsUJRRQpGnAJriS1Igs18x/HCzs/CdW4MevRvZdWhYoF+1aNsaoZgoH8O4WBRGnxUNcWa8hTGTyVcS9SgRg81a9eaAC5a7Et8GQJsbVQfPrPzqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jK3DFwgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07DEC2BD10;
	Thu, 23 May 2024 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470697;
	bh=fM0pZyhqv79jQdDk0PAcxs6t4FO7TGU1d+Ysk9B67qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK3DFwgmAUzXzy8Dn19nbzhRNix7Y1W20tJkxiwBbtn8OzfHlmKjBsKARtkRX3vYn
	 rl8lv+cWVD/KdqUjF6hJRqrahS+THdJrUi6E0QxBxLoadApgdVM+a8iFmr5zBPtaEL
	 /zgJdDAMPl5C93zZ8XQJn2tqcsDlilWaNrxWXF1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/102] smb: client: optimise reparse point querying
Date: Thu, 23 May 2024 15:12:40 +0200
Message-ID: <20240523130343.040095291@linuxfoundation.org>
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

[ Upstream commit 67ec9949b0dfe78c99e110dd975eb7dc5645630c ]

Reduce number of roundtrips to server when querying reparse points in
->query_path_info() by sending a single compound request of
create+get_reparse+get_info+close.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |  10 ++--
 fs/smb/client/cifsproto.h |   7 +++
 fs/smb/client/inode.c     |   5 +-
 fs/smb/client/smb2glob.h  |   3 +-
 fs/smb/client/smb2inode.c | 122 ++++++++++++++++++++++++++++++--------
 fs/smb/client/trace.h     |   3 +
 6 files changed, 119 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index cb86b1bf69b58..3e7c3c3d73a73 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -192,6 +192,11 @@ struct cifs_open_info_data {
 		bool symlink;
 	};
 	struct {
+		/* ioctl response buffer */
+		struct {
+			int buftype;
+			struct kvec iov;
+		} io;
 		__u32 tag;
 		union {
 			struct reparse_data_buffer *buf;
@@ -218,11 +223,6 @@ static inline bool cifs_open_data_reparse(struct cifs_open_info_data *data)
 	return ret;
 }
 
-static inline void cifs_free_open_info(struct cifs_open_info_data *data)
-{
-	kfree(data->symlink_target);
-}
-
 /*
  *****************************************************************
  * Except the CIFS PDUs themselves all the
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 49de2545f34ce..996ca413dd8bd 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -769,4 +769,11 @@ static inline void release_mid(struct mid_q_entry *mid)
 	kref_put(&mid->refcount, __release_mid);
 }
 
+static inline void cifs_free_open_info(struct cifs_open_info_data *data)
+{
+	kfree(data->symlink_target);
+	free_rsp_buf(data->reparse.io.buftype, data->reparse.io.iov.iov_base);
+	memset(data, 0, sizeof(*data));
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 391839feb29d5..89dfb405f9c1e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1080,6 +1080,9 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 						      &rsp_iov, &rsp_buftype);
 		if (!rc)
 			iov = &rsp_iov;
+	} else if (data->reparse.io.buftype != CIFS_NO_BUFFER &&
+		   data->reparse.io.iov.iov_base) {
+		iov = &data->reparse.io.iov;
 	}
 
 	rc = -EOPNOTSUPP;
@@ -1099,7 +1102,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 		/* Check for cached reparse point data */
 		if (data->symlink_target || data->reparse.buf) {
 			rc = 0;
-		} else if (server->ops->parse_reparse_point) {
+		} else if (iov && server->ops->parse_reparse_point) {
 			rc = server->ops->parse_reparse_point(cifs_sb,
 							      iov, data);
 		}
diff --git a/fs/smb/client/smb2glob.h b/fs/smb/client/smb2glob.h
index ca87a0011c337..a0c156996fc51 100644
--- a/fs/smb/client/smb2glob.h
+++ b/fs/smb/client/smb2glob.h
@@ -35,7 +35,8 @@ enum smb2_compound_ops {
 	SMB2_OP_SET_EOF,
 	SMB2_OP_RMDIR,
 	SMB2_OP_POSIX_QUERY_INFO,
-	SMB2_OP_SET_REPARSE
+	SMB2_OP_SET_REPARSE,
+	SMB2_OP_GET_REPARSE
 };
 
 /* Used when constructing chained read requests. */
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index e74d3a1e49dfa..11c1e06ab5417 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -38,6 +38,24 @@ static inline __u32 file_create_options(struct dentry *dentry)
 	return 0;
 }
 
+static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
+{
+	struct reparse_data_buffer *buf;
+	struct smb2_ioctl_rsp *io = iov->iov_base;
+	u32 off, count, len;
+
+	count = le32_to_cpu(io->OutputCount);
+	off = le32_to_cpu(io->OutputOffset);
+	if (check_add_overflow(off, count, &len) || len > iov->iov_len)
+		return ERR_PTR(-EIO);
+
+	buf = (struct reparse_data_buffer *)((u8 *)io + off);
+	len = sizeof(*buf);
+	if (count < len || count < le16_to_cpu(buf->ReparseDataLength) + len)
+		return ERR_PTR(-EIO);
+	return buf;
+}
+
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
@@ -54,8 +72,10 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    __u8 **extbuf, size_t *extbuflen,
 			    struct kvec *out_iov, int *out_buftype)
 {
+
+	struct reparse_data_buffer *rbuf;
 	struct smb2_compound_vars *vars = NULL;
-	struct kvec *rsp_iov;
+	struct kvec *rsp_iov, *iov;
 	struct smb_rqst *rqst;
 	int rc;
 	__le16 *utf16_path = NULL;
@@ -375,6 +395,21 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			trace_smb3_set_reparse_compound_enter(xid, ses->Suid,
 							      tcon->tid, full_path);
 			break;
+		case SMB2_OP_GET_REPARSE:
+			rqst[num_rqst].rq_iov = vars->io_iov;
+			rqst[num_rqst].rq_nvec = ARRAY_SIZE(vars->io_iov);
+
+			rc = SMB2_ioctl_init(tcon, server, &rqst[num_rqst],
+					     COMPOUND_FID, COMPOUND_FID,
+					     FSCTL_GET_REPARSE_POINT,
+					     NULL, 0, CIFSMaxBufSize);
+			if (rc)
+				goto finished;
+			smb2_set_next_command(tcon, &rqst[num_rqst]);
+			smb2_set_related(&rqst[num_rqst++]);
+			trace_smb3_get_reparse_compound_enter(xid, ses->Suid,
+							      tcon->tid, full_path);
+			break;
 		default:
 			cifs_dbg(VFS, "Invalid command\n");
 			rc = -EINVAL;
@@ -541,6 +576,30 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			}
 			SMB2_ioctl_free(&rqst[num_rqst++]);
 			break;
+		case SMB2_OP_GET_REPARSE:
+			if (!rc) {
+				iov = &rsp_iov[i + 1];
+				idata = in_iov[i].iov_base;
+				idata->reparse.io.iov = *iov;
+				idata->reparse.io.buftype = resp_buftype[i + 1];
+				rbuf = reparse_buf_ptr(iov);
+				if (IS_ERR(rbuf)) {
+					rc = PTR_ERR(rbuf);
+					trace_smb3_set_reparse_compound_err(xid,  ses->Suid,
+									    tcon->tid, rc);
+				} else {
+					idata->reparse.tag = le32_to_cpu(rbuf->ReparseTag);
+					trace_smb3_set_reparse_compound_done(xid, ses->Suid,
+									     tcon->tid);
+				}
+				memset(iov, 0, sizeof(*iov));
+				resp_buftype[i + 1] = CIFS_NO_BUFFER;
+			} else {
+				trace_smb3_set_reparse_compound_err(xid,  ses->Suid,
+								    tcon->tid, rc);
+			}
+			SMB2_ioctl_free(&rqst[num_rqst++]);
+			break;
 		}
 	}
 	SMB2_close_free(&rqst[num_rqst]);
@@ -601,10 +660,11 @@ int smb2_query_path_info(const unsigned int xid,
 	struct cifsFileInfo *cfile;
 	struct cached_fid *cfid = NULL;
 	struct smb2_hdr *hdr;
-	struct kvec in_iov, out_iov[3] = {};
+	struct kvec in_iov[2], out_iov[3] = {};
 	int out_buftype[3] = {};
+	int cmds[2] = { SMB2_OP_QUERY_INFO,  };
 	bool islink;
-	int cmd = SMB2_OP_QUERY_INFO;
+	int i, num_cmds;
 	int rc, rc2;
 
 	data->adjust_tz = false;
@@ -626,14 +686,16 @@ int smb2_query_path_info(const unsigned int xid,
 		return rc;
 	}
 
-	in_iov.iov_base = data;
-	in_iov.iov_len = sizeof(*data);
+	in_iov[0].iov_base = data;
+	in_iov[0].iov_len = sizeof(*data);
+	in_iov[1] = in_iov[0];
 
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE, &in_iov,
-			      &cmd, 1, cfile, NULL, NULL, out_iov, out_buftype);
+			      create_options, ACL_NO_MODE,
+			      in_iov, cmds, 1, cfile,
+			      NULL, NULL, out_iov, out_buftype);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -649,13 +711,19 @@ int smb2_query_path_info(const unsigned int xid,
 		if (rc || !data->reparse_point)
 			goto out;
 
+		if (data->reparse.tag == IO_REPARSE_TAG_SYMLINK) {
+			/* symlink already parsed in create response */
+			num_cmds = 1;
+		} else {
+			cmds[1] = SMB2_OP_GET_REPARSE;
+			num_cmds = 2;
+		}
 		create_options |= OPEN_REPARSE_POINT;
-		/* Failed on a symbolic link - query a reparse point info */
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, &in_iov,
-				      &cmd, 1, cfile, NULL, NULL, NULL, NULL);
+				      create_options, ACL_NO_MODE, in_iov, cmds,
+				      num_cmds, cfile, NULL, NULL, NULL, NULL);
 		break;
 	case -EREMOTE:
 		break;
@@ -673,9 +741,8 @@ int smb2_query_path_info(const unsigned int xid,
 	}
 
 out:
-	free_rsp_buf(out_buftype[0], out_iov[0].iov_base);
-	free_rsp_buf(out_buftype[1], out_iov[1].iov_base);
-	free_rsp_buf(out_buftype[2], out_iov[2].iov_base);
+	for (i = 0; i < ARRAY_SIZE(out_buftype); i++)
+		free_rsp_buf(out_buftype[i], out_iov[i].iov_base);
 	return rc;
 }
 
@@ -690,13 +757,14 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	int rc;
 	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
-	struct kvec in_iov, out_iov[3] = {};
+	struct kvec in_iov[2], out_iov[3] = {};
 	int out_buftype[3] = {};
 	__u8 *sidsbuf = NULL;
 	__u8 *sidsbuf_end = NULL;
 	size_t sidsbuflen = 0;
 	size_t owner_len, group_len;
-	int cmd = SMB2_OP_POSIX_QUERY_INFO;
+	int cmds[2] = { SMB2_OP_POSIX_QUERY_INFO,  };
+	int i, num_cmds;
 
 	data->adjust_tz = false;
 	data->reparse_point = false;
@@ -707,13 +775,14 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	 * when we already have an open file handle for this. For now this is fast enough
 	 * (always using the compounded version).
 	 */
-	in_iov.iov_base = data;
-	in_iov.iov_len = sizeof(*data);
+	in_iov[0].iov_base = data;
+	in_iov[0].iov_len = sizeof(*data);
+	in_iov[1] = in_iov[0];
 
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE, &in_iov, &cmd, 1,
+			      create_options, ACL_NO_MODE, in_iov, cmds, 1,
 			      cfile, &sidsbuf, &sidsbuflen, out_iov, out_buftype);
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -730,13 +799,19 @@ int smb311_posix_query_path_info(const unsigned int xid,
 		if (rc || !data->reparse_point)
 			goto out;
 
+		if (data->reparse.tag == IO_REPARSE_TAG_SYMLINK) {
+			/* symlink already parsed in create response */
+			num_cmds = 1;
+		} else {
+			cmds[1] = SMB2_OP_GET_REPARSE;
+			num_cmds = 2;
+		}
 		create_options |= OPEN_REPARSE_POINT;
-		/* Failed on a symbolic link - query a reparse point info */
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, &in_iov, &cmd, 1,
-				      cfile, &sidsbuf, &sidsbuflen, NULL, NULL);
+				      create_options, ACL_NO_MODE, in_iov, cmds,
+				      num_cmds, cfile, &sidsbuf, &sidsbuflen, NULL, NULL);
 		break;
 	}
 
@@ -761,9 +836,8 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	}
 
 	kfree(sidsbuf);
-	free_rsp_buf(out_buftype[0], out_iov[0].iov_base);
-	free_rsp_buf(out_buftype[1], out_iov[1].iov_base);
-	free_rsp_buf(out_buftype[2], out_iov[2].iov_base);
+	for (i = 0; i < ARRAY_SIZE(out_buftype); i++)
+		free_rsp_buf(out_buftype[i], out_iov[i].iov_base);
 	return rc;
 }
 
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 34f507584274b..522fa387fcfd7 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -371,6 +371,7 @@ DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(rmdir_enter);
 DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(set_eof_enter);
 DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(set_info_compound_enter);
 DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(set_reparse_compound_enter);
+DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(get_reparse_compound_enter);
 DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(delete_enter);
 DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(mkdir_enter);
 DEFINE_SMB3_INF_COMPOUND_ENTER_EVENT(tdis_enter);
@@ -409,6 +410,7 @@ DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(rmdir_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(set_eof_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(set_info_compound_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(set_reparse_compound_done);
+DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(get_reparse_compound_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(delete_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(mkdir_done);
 DEFINE_SMB3_INF_COMPOUND_DONE_EVENT(tdis_done);
@@ -453,6 +455,7 @@ DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(rmdir_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(set_eof_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(set_info_compound_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(set_reparse_compound_err);
+DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(get_reparse_compound_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(mkdir_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(delete_err);
 DEFINE_SMB3_INF_COMPOUND_ERR_EVENT(tdis_err);
-- 
2.43.0




