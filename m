Return-Path: <stable+bounces-45888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3318CD46B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B615B22A90
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95E14D451;
	Thu, 23 May 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvM7TeU1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3514D420;
	Thu, 23 May 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470651; cv=none; b=u5yqGhwfxC2haeYkO7JIyQmYa6EsrFy3mXmNqKrR9aJQpAbHdSJC2/z35JnN0YFWNFO+7JfrPXh1u04xEFlsfSzsbZBSR9GUmZKQYL8yz8G7ZnGoi9XGOc+t6Hcz1OfSxh/a/8Ec4RG1iVqMH/U8AsZyuh1xW3QFokFPv3M1xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470651; c=relaxed/simple;
	bh=H5KbsdvcNnwnsGd6ItpdvIFQHvfLXCC+DsbXd+Lf7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOl0k8oqHw8ifKWdIzhZwis/Mf3d+C52CJxgUHRst3SeDINlubaiDFoM0LclQl2Z82kIqHUbnhC7GTSsqMW7zCxBpmtGmc083PnFfCz4E2LxqZP6PEW3LKbsFKVbRKrbaqM1DcED7dD61+Bl+SrJiexVwOzQ8TDCDAcHNoWebWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvM7TeU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4656C4AF08;
	Thu, 23 May 2024 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470651;
	bh=H5KbsdvcNnwnsGd6ItpdvIFQHvfLXCC+DsbXd+Lf7v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvM7TeU1W8MwHp5y/zkpC80sVGVNvsaXNLnhVZq8fLmziyVjiPHgXopW8mpqteZ41
	 PUX27fU2T0WKQuUHBoLAN9+/V0GkNKBzTC/CDf+Y4hNJs3mUJCRQXTvfrwJC7bMBqE
	 d1CPZ4UYeVxqy8J21ZryFuG2T3OUhe93d37U0XTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/102] smb: client: parse owner/group when creating reparse points
Date: Thu, 23 May 2024 15:13:05 +0200
Message-ID: <20240523130343.976296119@linuxfoundation.org>
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

[ Upstream commit 858e74876c5cbff1dfd5bace99e32fbce2abd4b5 ]

Parse owner/group when creating special files and symlinks under
SMB3.1.1 POSIX mounts.

Move the parsing of owner/group to smb2_compound_op() so we don't have
to duplicate it in both smb2_get_reparse_inode() and
smb311_posix_query_path_info().

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |   2 +
 fs/smb/client/inode.c     |  25 +++-----
 fs/smb/client/smb2inode.c | 130 ++++++++++++++++++--------------------
 fs/smb/client/smb2proto.h |   4 +-
 4 files changed, 71 insertions(+), 90 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 181e9d5b10f92..678a9c671cdcd 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -209,6 +209,8 @@ struct cifs_open_info_data {
 		};
 	} reparse;
 	char *symlink_target;
+	struct cifs_sid posix_owner;
+	struct cifs_sid posix_group;
 	union {
 		struct smb2_file_all_info fi;
 		struct smb311_posix_qinfo posix_fi;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index b8260ace2bee9..0110589acb853 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -666,8 +666,6 @@ static int cifs_sfu_mode(struct cifs_fattr *fattr, const unsigned char *path,
 /* Fill a cifs_fattr struct with info from POSIX info struct */
 static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 				       struct cifs_open_info_data *data,
-				       struct cifs_sid *owner,
-				       struct cifs_sid *group,
 				       struct super_block *sb)
 {
 	struct smb311_posix_qinfo *info = &data->posix_fi;
@@ -723,8 +721,8 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 		fattr->cf_symlink_target = data->symlink_target;
 		data->symlink_target = NULL;
 	}
-	sid_to_id(cifs_sb, owner, fattr, SIDOWNER);
-	sid_to_id(cifs_sb, group, fattr, SIDGROUP);
+	sid_to_id(cifs_sb, &data->posix_owner, fattr, SIDOWNER);
+	sid_to_id(cifs_sb, &data->posix_group, fattr, SIDGROUP);
 
 	cifs_dbg(FYI, "POSIX query info: mode 0x%x uniqueid 0x%llx nlink %d\n",
 		fattr->cf_mode, fattr->cf_uniqueid, fattr->cf_nlink);
@@ -1071,9 +1069,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 				 const unsigned int xid,
 				 struct cifs_tcon *tcon,
 				 const char *full_path,
-				 struct cifs_fattr *fattr,
-				 struct cifs_sid *owner,
-				 struct cifs_sid *group)
+				 struct cifs_fattr *fattr)
 {
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
@@ -1118,7 +1114,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	}
 
 	if (tcon->posix_extensions)
-		smb311_posix_info_to_fattr(fattr, data, owner, group, sb);
+		smb311_posix_info_to_fattr(fattr, data, sb);
 	else
 		cifs_open_info_to_fattr(fattr, data, sb);
 out:
@@ -1172,8 +1168,7 @@ static int cifs_get_fattr(struct cifs_open_info_data *data,
 		 */
 		if (cifs_open_data_reparse(data)) {
 			rc = reparse_info_to_fattr(data, sb, xid, tcon,
-						   full_path, fattr,
-						   NULL, NULL);
+						   full_path, fattr);
 		} else {
 			cifs_open_info_to_fattr(fattr, data, sb);
 		}
@@ -1321,7 +1316,6 @@ static int smb311_posix_get_fattr(struct cifs_open_info_data *data,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
-	struct cifs_sid owner, group;
 	int tmprc;
 	int rc = 0;
 
@@ -1335,8 +1329,7 @@ static int smb311_posix_get_fattr(struct cifs_open_info_data *data,
 	 */
 	if (!data) {
 		rc = smb311_posix_query_path_info(xid, tcon, cifs_sb,
-						  full_path, &tmp_data,
-						  &owner, &group);
+						  full_path, &tmp_data);
 		data = &tmp_data;
 	}
 
@@ -1348,11 +1341,9 @@ static int smb311_posix_get_fattr(struct cifs_open_info_data *data,
 	case 0:
 		if (cifs_open_data_reparse(data)) {
 			rc = reparse_info_to_fattr(data, sb, xid, tcon,
-						   full_path, fattr,
-						   &owner, &group);
+						   full_path, fattr);
 		} else {
-			smb311_posix_info_to_fattr(fattr, data,
-						   &owner, &group, sb);
+			smb311_posix_info_to_fattr(fattr, data, sb);
 		}
 		break;
 	case -EREMOTE:
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 94df328a1965d..4cd4b8a63316d 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -56,6 +56,35 @@ static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
 	return buf;
 }
 
+/* Parse owner and group from SMB3.1.1 POSIX query info */
+static int parse_posix_sids(struct cifs_open_info_data *data,
+			    struct kvec *rsp_iov)
+{
+	struct smb2_query_info_rsp *qi = rsp_iov->iov_base;
+	unsigned int out_len = le32_to_cpu(qi->OutputBufferLength);
+	unsigned int qi_len = sizeof(data->posix_fi);
+	int owner_len, group_len;
+	u8 *sidsbuf, *sidsbuf_end;
+
+	if (out_len <= qi_len)
+		return -EINVAL;
+
+	sidsbuf = (u8 *)qi + le16_to_cpu(qi->OutputBufferOffset) + qi_len;
+	sidsbuf_end = sidsbuf + out_len - qi_len;
+
+	owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
+	if (owner_len == -1)
+		return -EINVAL;
+
+	memcpy(&data->posix_owner, sidsbuf, owner_len);
+	group_len = posix_info_sid_size(sidsbuf + owner_len, sidsbuf_end);
+	if (group_len == -1)
+		return -EINVAL;
+
+	memcpy(&data->posix_group, sidsbuf + owner_len, group_len);
+	return 0;
+}
+
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
@@ -69,7 +98,6 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    __u32 desired_access, __u32 create_disposition,
 			    __u32 create_options, umode_t mode, struct kvec *in_iov,
 			    int *cmds, int num_cmds, struct cifsFileInfo *cfile,
-			    __u8 **extbuf, size_t *extbuflen,
 			    struct kvec *out_iov, int *out_buftype)
 {
 
@@ -509,21 +537,9 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 					&rsp_iov[i + 1], sizeof(idata->posix_fi) /* add SIDs */,
 					(char *)&idata->posix_fi);
 			}
-			if (rc == 0) {
-				unsigned int length = le32_to_cpu(qi_rsp->OutputBufferLength);
-
-				if (length > sizeof(idata->posix_fi)) {
-					char *base = (char *)rsp_iov[i + 1].iov_base +
-						le16_to_cpu(qi_rsp->OutputBufferOffset) +
-						sizeof(idata->posix_fi);
-					*extbuflen = length - sizeof(idata->posix_fi);
-					*extbuf = kmemdup(base, *extbuflen, GFP_KERNEL);
-					if (!*extbuf)
-						rc = -ENOMEM;
-				} else {
-					rc = -EINVAL;
-				}
-			}
+			if (rc == 0)
+				rc = parse_posix_sids(idata, &rsp_iov[i + 1]);
+
 			SMB2_query_info_free(&rqst[num_rqst++]);
 			if (rc)
 				trace_smb3_posix_query_info_compound_err(xid,  ses->Suid,
@@ -714,9 +730,8 @@ int smb2_query_path_info(const unsigned int xid,
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE,
-			      in_iov, cmds, 1, cfile,
-			      NULL, NULL, out_iov, out_buftype);
+			      create_options, ACL_NO_MODE, in_iov,
+			      cmds, 1, cfile, out_iov, out_buftype);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -743,8 +758,8 @@ int smb2_query_path_info(const unsigned int xid,
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, in_iov, cmds,
-				      num_cmds, cfile, NULL, NULL, NULL, NULL);
+				      create_options, ACL_NO_MODE, in_iov,
+				      cmds, num_cmds, cfile, NULL, NULL);
 		break;
 	case -EREMOTE:
 		break;
@@ -771,19 +786,13 @@ int smb311_posix_query_path_info(const unsigned int xid,
 				 struct cifs_tcon *tcon,
 				 struct cifs_sb_info *cifs_sb,
 				 const char *full_path,
-				 struct cifs_open_info_data *data,
-				 struct cifs_sid *owner,
-				 struct cifs_sid *group)
+				 struct cifs_open_info_data *data)
 {
 	int rc;
 	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
 	struct kvec in_iov[2], out_iov[3] = {};
 	int out_buftype[3] = {};
-	__u8 *sidsbuf = NULL;
-	__u8 *sidsbuf_end = NULL;
-	size_t sidsbuflen = 0;
-	size_t owner_len, group_len;
 	int cmds[2] = { SMB2_OP_POSIX_QUERY_INFO,  };
 	int i, num_cmds;
 
@@ -803,8 +812,8 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE, in_iov, cmds, 1,
-			      cfile, &sidsbuf, &sidsbuflen, out_iov, out_buftype);
+			      create_options, ACL_NO_MODE, in_iov,
+			      cmds, 1, cfile, out_iov, out_buftype);
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
 	 * cached open file (@cfile).
@@ -831,32 +840,12 @@ int smb311_posix_query_path_info(const unsigned int xid,
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, in_iov, cmds,
-				      num_cmds, cfile, &sidsbuf, &sidsbuflen, NULL, NULL);
+				      create_options, ACL_NO_MODE, in_iov,
+				      cmds, num_cmds, cfile, NULL, NULL);
 		break;
 	}
 
 out:
-	if (rc == 0) {
-		sidsbuf_end = sidsbuf + sidsbuflen;
-
-		owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
-		if (owner_len == -1) {
-			rc = -EINVAL;
-			goto out;
-		}
-		memcpy(owner, sidsbuf, owner_len);
-
-		group_len = posix_info_sid_size(
-			sidsbuf + owner_len, sidsbuf_end);
-		if (group_len == -1) {
-			rc = -EINVAL;
-			goto out;
-		}
-		memcpy(group, sidsbuf + owner_len, group_len);
-	}
-
-	kfree(sidsbuf);
 	for (i = 0; i < ARRAY_SIZE(out_buftype); i++)
 		free_rsp_buf(out_buftype[i], out_iov[i].iov_base);
 	return rc;
@@ -869,9 +858,9 @@ smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name,
 				FILE_WRITE_ATTRIBUTES, FILE_CREATE,
-				CREATE_NOT_FILE, mode, NULL,
-				&(int){SMB2_OP_MKDIR}, 1,
-				NULL, NULL, NULL, NULL, NULL);
+				CREATE_NOT_FILE, mode,
+				NULL, &(int){SMB2_OP_MKDIR}, 1,
+				NULL, NULL, NULL);
 }
 
 void
@@ -896,7 +885,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				 CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
 				 &(int){SMB2_OP_SET_INFO}, 1,
-				 cfile, NULL, NULL, NULL, NULL);
+				 cfile, NULL, NULL);
 	if (tmprc == 0)
 		cifs_i->cifsAttrs = dosattrs;
 }
@@ -908,8 +897,9 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	drop_cached_dir_by_name(xid, tcon, name, cifs_sb);
 	return smb2_compound_op(xid, tcon, cifs_sb, name,
 				DELETE, FILE_OPEN, CREATE_NOT_FILE,
-				ACL_NO_MODE, NULL, &(int){SMB2_OP_RMDIR}, 1,
-				NULL, NULL, NULL, NULL, NULL);
+				ACL_NO_MODE, NULL,
+				&(int){SMB2_OP_RMDIR}, 1,
+				NULL, NULL, NULL);
 }
 
 int
@@ -918,8 +908,9 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
-				ACL_NO_MODE, NULL, &(int){SMB2_OP_DELETE}, 1,
-				NULL, NULL, NULL, NULL, NULL);
+				ACL_NO_MODE, NULL,
+				&(int){SMB2_OP_DELETE}, 1,
+				NULL, NULL, NULL);
 }
 
 static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
@@ -939,10 +930,9 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	in_iov.iov_base = smb2_to_name;
 	in_iov.iov_len = 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_MAX);
-
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
-			      FILE_OPEN, 0, ACL_NO_MODE, &in_iov,
-			      &command, 1, cfile, NULL, NULL, NULL, NULL);
+			      FILE_OPEN, create_options, ACL_NO_MODE,
+			      &in_iov, &command, 1, cfile, NULL, NULL);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
@@ -993,7 +983,7 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 				FILE_WRITE_DATA, FILE_OPEN,
 				0, ACL_NO_MODE, &in_iov,
 				&(int){SMB2_OP_SET_EOF}, 1,
-				cfile, NULL, NULL, NULL, NULL);
+				cfile, NULL, NULL);
 }
 
 int
@@ -1021,8 +1011,8 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN,
 			      0, ACL_NO_MODE, &in_iov,
-			      &(int){SMB2_OP_SET_INFO}, 1, cfile,
-			      NULL, NULL, NULL, NULL);
+			      &(int){SMB2_OP_SET_INFO}, 1,
+			      cfile, NULL, NULL);
 	cifs_put_tlink(tlink);
 	return rc;
 }
@@ -1057,7 +1047,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL);
 		if (!rc) {
 			rc = smb311_posix_get_inode_info(&new, full_path,
 							 data, sb, xid);
@@ -1067,7 +1057,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL);
 		if (!rc) {
 			rc = cifs_get_inode_info(&new, full_path,
 						 data, sb, xid, NULL);
@@ -1094,8 +1084,8 @@ int smb2_query_reparse_point(const unsigned int xid,
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
 			      OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
-			      &(int){SMB2_OP_GET_REPARSE}, 1, cfile,
-			      NULL, NULL, NULL, NULL);
+			      &(int){SMB2_OP_GET_REPARSE}, 1,
+			      cfile, NULL, NULL);
 	if (rc)
 		goto out;
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 330e36c6b91f0..b3069911e9dd8 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -304,9 +304,7 @@ int smb311_posix_query_path_info(const unsigned int xid,
 				 struct cifs_tcon *tcon,
 				 struct cifs_sb_info *cifs_sb,
 				 const char *full_path,
-				 struct cifs_open_info_data *data,
-				 struct cifs_sid *owner,
-				 struct cifs_sid *group);
+				 struct cifs_open_info_data *data);
 int posix_info_parse(const void *beg, const void *end,
 		     struct smb2_posix_info_parsed *out);
 int posix_info_sid_size(const void *beg, const void *end);
-- 
2.43.0




