Return-Path: <stable+bounces-34183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BEC893E40
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948BCB20C65
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404E4778E;
	Mon,  1 Apr 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2oHFMMbi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5279383BA;
	Mon,  1 Apr 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987268; cv=none; b=Mqnt0H4WqG0YjdW5TSJE+O4eQ8KAJaQvBA1WJpVhh04y+9s6eDyjEqgP4fP3nCZ6vELkGreUaSfj7E8MraNP5+7v3XPAOX46EMOENmuiLj1QysWEWcZs+j3N7n7X2hLWXt0REmFz0Yaxw9oRCNgNQnBYrC8vfuPPp9uYVxcMI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987268; c=relaxed/simple;
	bh=RNyDZQlAMSdF1IveKi3J+JlAmkB4h/moXuQbEoVfDtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yankzw6YRoPi/RkVSyrwQYVTOCSLpd5Lfu3y4WvI7GniwokEq8JPKACWB92IuCyKZZLyjEdHCLunDwERyFZEDG2S2p+XxRgP0zDICxL7cH7KIQkUX/Mu+PP9lew1ttH4yBuOThHkoxZuvxK0GR7Q7UEgkJGDt+ax2GYBORgDZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2oHFMMbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD2C433C7;
	Mon,  1 Apr 2024 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987268;
	bh=RNyDZQlAMSdF1IveKi3J+JlAmkB4h/moXuQbEoVfDtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2oHFMMbivd7IFIUw/dtkqzUFTiEozgGRiqr4ND06NEKgI9ID82Wd+kw0MvYVXF7Pd
	 hdrSkGT35/rL2hpdEyoRBu60lFkXFdRt/OeXKa3+t/eXPvmrK4adYn34x8MXp87Nfq
	 Fzy5bSF5fwif4lNhOFFtg6jwLH0Ld4yEkDhiTkXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 196/399] ksmbd: fix potencial out-of-bounds when buffer offset is invalid
Date: Mon,  1 Apr 2024 17:42:42 +0200
Message-ID: <20240401152555.032447748@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da ]

I found potencial out-of-bounds when buffer offset fields of a few requests
is invalid. This patch set the minimum value of buffer offset field to
->Buffer offset to validate buffer length.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2misc.c | 23 +++++++++++++------
 fs/smb/server/smb2pdu.c  | 48 ++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 7c872ffb4b0a9..727cb49926ee5 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -101,7 +101,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
 	case SMB2_TREE_CONNECT:
-		*off = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
+			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
 	case SMB2_CREATE:
@@ -110,7 +112,6 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 			max_t(unsigned short int,
 			      le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset),
 			      offsetof(struct smb2_create_req, Buffer));
-
 		unsigned short int name_len =
 			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
 
@@ -131,11 +132,15 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_QUERY_INFO:
-		*off = le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
+			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
 	case SMB2_SET_INFO:
-		*off = le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
+			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
 	case SMB2_READ:
@@ -145,7 +150,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	case SMB2_WRITE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
-			*off = max_t(unsigned int,
+			*off = max_t(unsigned short int,
 				     le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset),
 				     offsetof(struct smb2_write_req, Buffer));
 			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
@@ -156,7 +161,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
 	case SMB2_QUERY_DIRECTORY:
-		*off = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
+			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
 	case SMB2_LOCK:
@@ -171,7 +178,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_IOCTL:
-		*off = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset);
+		*off = max_t(unsigned int,
+			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
+			     offsetof(struct smb2_ioctl_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputCount);
 		break;
 	default:
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 199c31c275e5b..88db6e207e0ee 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1951,7 +1951,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	treename = smb_strndup_from_utf16(req->Buffer,
+	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
 	if (IS_ERR(treename)) {
@@ -2704,7 +2704,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 
-		name = smb2_get_name(req->Buffer,
+		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -4080,7 +4080,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	srch_flag = req->Flags;
-	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+	srch_ptr = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->FileNameOffset),
 					  le16_to_cpu(req->FileNameLength), 1,
 					  conn->local_nls);
 	if (IS_ERR(srch_ptr)) {
@@ -4340,7 +4340,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
-		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+		ea_req = (struct smb2_ea_info_req *)((char *)req +
+						     le16_to_cpu(req->InputBufferOffset));
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
@@ -5986,6 +5987,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			      struct ksmbd_share_config *share)
 {
 	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+	char *buffer = (char *)req + le16_to_cpu(req->BufferOffset);
 
 	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
@@ -5993,7 +5995,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_basic_info))
 			return -EINVAL;
 
-		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)buffer, share);
 	}
 	case FILE_ALLOCATION_INFORMATION:
 	{
@@ -6001,7 +6003,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_allocation_info(work, fp,
-						(struct smb2_file_alloc_info *)req->Buffer);
+						(struct smb2_file_alloc_info *)buffer);
 	}
 	case FILE_END_OF_FILE_INFORMATION:
 	{
@@ -6009,7 +6011,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_end_of_file_info(work, fp,
-					    (struct smb2_file_eof_info *)req->Buffer);
+					    (struct smb2_file_eof_info *)buffer);
 	}
 	case FILE_RENAME_INFORMATION:
 	{
@@ -6017,7 +6019,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_rename_info(work, fp,
-				       (struct smb2_file_rename_info *)req->Buffer,
+				       (struct smb2_file_rename_info *)buffer,
 				       buf_len);
 	}
 	case FILE_LINK_INFORMATION:
@@ -6026,7 +6028,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)req->Buffer,
+					(struct smb2_file_link_info *)buffer,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -6036,7 +6038,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_disposition_info(fp,
-						 (struct smb2_file_disposition_info *)req->Buffer);
+						 (struct smb2_file_disposition_info *)buffer);
 	}
 	case FILE_FULL_EA_INFORMATION:
 	{
@@ -6049,7 +6051,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_ea_info))
 			return -EINVAL;
 
-		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+		return smb2_set_ea((struct smb2_ea_info *)buffer,
 				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
@@ -6057,14 +6059,14 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_pos_info))
 			return -EINVAL;
 
-		return set_file_position_info(fp, (struct smb2_file_pos_info *)req->Buffer);
+		return set_file_position_info(fp, (struct smb2_file_pos_info *)buffer);
 	}
 	case FILE_MODE_INFORMATION:
 	{
 		if (buf_len < sizeof(struct smb2_file_mode_info))
 			return -EINVAL;
 
-		return set_file_mode_info(fp, (struct smb2_file_mode_info *)req->Buffer);
+		return set_file_mode_info(fp, (struct smb2_file_mode_info *)buffer);
 	}
 	}
 
@@ -6145,7 +6147,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
-				       req->Buffer,
+				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
 		ksmbd_revert_fsids(work);
 		break;
@@ -7591,7 +7593,7 @@ static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
 				 struct smb2_ioctl_rsp *rsp)
 {
 	struct ksmbd_rpc_command *rpc_resp;
-	char *data_buf = (char *)&req->Buffer[0];
+	char *data_buf = (char *)req + le32_to_cpu(req->InputOffset);
 	int nbytes = 0;
 
 	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
@@ -7704,6 +7706,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
+	char *buffer;
 
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
@@ -7726,6 +7729,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 		goto out;
 	}
 
+	buffer = (char *)req + le32_to_cpu(req->InputOffset);
+
 	cnt_code = le32_to_cpu(req->CtlCode);
 	ret = smb2_calc_max_out_buf_len(work, 48,
 					le32_to_cpu(req->MaxOutputResponse));
@@ -7783,7 +7788,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_validate_negotiate_info(conn,
-			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_req *)buffer,
 			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
 			in_buf_len);
 		if (ret < 0)
@@ -7836,7 +7841,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->VolatileFileId = req->VolatileFileId;
 		rsp->PersistentFileId = req->PersistentFileId;
 		fsctl_copychunk(work,
-				(struct copychunk_ioctl_req *)&req->Buffer[0],
+				(struct copychunk_ioctl_req *)buffer,
 				le32_to_cpu(req->CtlCode),
 				le32_to_cpu(req->InputCount),
 				req->VolatileFileId,
@@ -7849,8 +7854,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		ret = fsctl_set_sparse(work, id,
-				       (struct file_sparse *)&req->Buffer[0]);
+		ret = fsctl_set_sparse(work, id, (struct file_sparse *)buffer);
 		if (ret < 0)
 			goto out;
 		break;
@@ -7873,7 +7877,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		zero_data =
-			(struct file_zero_data_information *)&req->Buffer[0];
+			(struct file_zero_data_information *)buffer;
 
 		off = le64_to_cpu(zero_data->FileOffset);
 		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
@@ -7904,7 +7908,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_query_allocated_ranges(work, id,
-			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)buffer,
 			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
 			out_buf_len /
 			sizeof(struct file_allocated_range_buffer), &nbytes);
@@ -7948,7 +7952,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+		dup_ext = (struct duplicate_extents_to_file *)buffer;
 
 		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
 					     dup_ext->PersistentFileHandle);
-- 
2.43.0




