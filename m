Return-Path: <stable+bounces-93485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED09CDA95
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272FCB25211
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827618FC84;
	Fri, 15 Nov 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eO/OVykJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4D189919
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659584; cv=none; b=aI7FdNM7xm9SxA52ccVq57qhKTO/XtnbhwKlLBS4qV0bI8bj+FvES8h+IrXljTFTULCuMTfnCL4Gv+BOl9BL/LqTabjRHrkwsX6lC5ZPtGDnCCNa7y9P0N2dnsoKWSPoEU1i2BrWwZw/foHpu4ZL2XJadU15cyrNCxBCJt7o6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659584; c=relaxed/simple;
	bh=2VVsWJrco36QOBvZICeCv8RoEB0WvJ+A8xYHLsPFqVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u2cvpc8+nE/mYqQi9LcTG/XMQ6LULhhABwSI5punAByxWEs+uGbnFVpcjVIx1Z8KOFqhjT+u+3uKYt3VMpa62mI9UI91t5jMIkC7vTj1L76FWMHh7KiHfBc/FAXEIQ2TXJ56Ewvi8tw7XOBqiiy/MZeYwzm429ihrF32gW+wZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eO/OVykJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4609c96b2e5so10247871cf.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731659581; x=1732264381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9huFcHpgkOMekePN9oM6pWVjT0WK26mwbaUBeABXVE=;
        b=eO/OVykJEWQbX43nWxbdhGTb5dgCFVzRSEOzFGfMlwPRVbCuJ3f4/AJEcv/Y4ef4z1
         53mGpW5jM4pZTV8FQqCBXbWABhxAqo0TPkpCeOXclqiym4dg7IamjiLIJvJXyrmbKbYf
         yT5BjT0GxI52Ic3VpM7O3emVD7xZQtSzxUMr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659581; x=1732264381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9huFcHpgkOMekePN9oM6pWVjT0WK26mwbaUBeABXVE=;
        b=guTa5RNhC46BGAUoeh1XjXfHLhM5vfNKOUIAw8NlypFg2ATk/VXemezWeUuS3zrjLm
         ieOsrLXRymnfugfH8HnFeMfLeGNAPthgbB2Mop6kXFybRFOpD0yTgQrlmoDZMWq/gh1a
         Z5kWrVo74V/uIZNt0+289M/cRIP7pWm9H2jN6XdeloNnfLbOjSRoWMMiay8TOwTJN7ZF
         lG6NG/8Myp80gFNHvDqQyzMwM1GFwDW9lcYj36OtIxNH7rCTB9zuV2POhUMLzYM6T1ml
         5kug+GpCrPfAD67FnGT/G9bfp4N1Cd7ll28AdpXm0FX+4z53X2bQKszL26Y12QNOyjCd
         yCKQ==
X-Gm-Message-State: AOJu0Yx03BvovoVy3EGbcBLCYx9g0OzcgIoXgNhfjIHHvCmV+2jMNVnz
	jHh7JOIyvCRiNFn3l5CfiaJRRzMIxZOA6rJGWR0A2onEwv+4AID/qghCAepObbviO0+hKn+PSB0
	6+THGosM/EmIZuin+6175FG/aSB5hv1gcslofKRDDiRtR35Me0W/pqy0KK59nwzcHQZDSZI3NgO
	LRRzmySgbGzH4H8U8aWo0Z/yJruW7WqsJty65pG8jraiWEWBftO/N/r0RYTAhjuwU=
X-Google-Smtp-Source: AGHT+IE0ORg2IPxeLB2SEtJk6yiuBs8ng23DcvcNqYuEVaDcG4kAhcSkrVdcc0mE83+uIPPh+d3ZFg==
X-Received: by 2002:a05:622a:4815:b0:463:17d2:4b7b with SMTP id d75a77b69052e-46363ec0ab5mr26048091cf.48.1731659581044;
        Fri, 15 Nov 2024 00:33:01 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa37c54sm16584231cf.53.2024.11.15.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:32:59 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: yuxuanzhe@outlook.com,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	sashal@kernel.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 2/2] ksmbd: fix potencial out-of-bounds when buffer offset is invalid
Date: Fri, 15 Nov 2024 08:32:40 +0000
Message-Id: <20241115083240.230361-3-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20241115083240.230361-1-vamsi-krishna.brahmajosyula@broadcom.com>
References: <20241115083240.230361-1-vamsi-krishna.brahmajosyula@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da ]

I found potencial out-of-bounds when buffer offset fields of a few requests
is invalid. This patch set the minimum value of buffer offset field to
->Buffer offset to validate buffer length.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
---
 fs/smb/server/smb2misc.c | 23 +++++++++++++------
 fs/smb/server/smb2pdu.c  | 48 ++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 7c872ffb4b0a..727cb49926ee 100644
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
index 9b5847bf9b2a..7e068c4187a8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1961,7 +1961,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	treename = smb_strndup_from_utf16(req->Buffer,
+	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
 	if (IS_ERR(treename)) {
@@ -2723,7 +2723,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 
-		name = smb2_get_name(req->Buffer,
+		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -4096,7 +4096,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	srch_flag = req->Flags;
-	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+	srch_ptr = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->FileNameOffset),
 					  le16_to_cpu(req->FileNameLength), 1,
 					  conn->local_nls);
 	if (IS_ERR(srch_ptr)) {
@@ -4357,7 +4357,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
-		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+		ea_req = (struct smb2_ea_info_req *)((char *)req +
+						     le16_to_cpu(req->InputBufferOffset));
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
@@ -5971,6 +5972,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			      struct ksmbd_share_config *share)
 {
 	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+	char *buffer = (char *)req + le16_to_cpu(req->BufferOffset);
 
 	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
@@ -5978,7 +5980,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_basic_info))
 			return -EINVAL;
 
-		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)buffer, share);
 	}
 	case FILE_ALLOCATION_INFORMATION:
 	{
@@ -5986,7 +5988,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_allocation_info(work, fp,
-						(struct smb2_file_alloc_info *)req->Buffer);
+						(struct smb2_file_alloc_info *)buffer);
 	}
 	case FILE_END_OF_FILE_INFORMATION:
 	{
@@ -5994,7 +5996,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_end_of_file_info(work, fp,
-					    (struct smb2_file_eof_info *)req->Buffer);
+					    (struct smb2_file_eof_info *)buffer);
 	}
 	case FILE_RENAME_INFORMATION:
 	{
@@ -6002,7 +6004,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_rename_info(work, fp,
-				       (struct smb2_file_rename_info *)req->Buffer,
+				       (struct smb2_file_rename_info *)buffer,
 				       buf_len);
 	}
 	case FILE_LINK_INFORMATION:
@@ -6011,7 +6013,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)req->Buffer,
+					(struct smb2_file_link_info *)buffer,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -6021,7 +6023,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_disposition_info(fp,
-						 (struct smb2_file_disposition_info *)req->Buffer);
+						 (struct smb2_file_disposition_info *)buffer);
 	}
 	case FILE_FULL_EA_INFORMATION:
 	{
@@ -6034,7 +6036,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_ea_info))
 			return -EINVAL;
 
-		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+		return smb2_set_ea((struct smb2_ea_info *)buffer,
 				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
@@ -6042,14 +6044,14 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
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
 
@@ -6130,7 +6132,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
-				       req->Buffer,
+				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
 		ksmbd_revert_fsids(work);
 		break;
@@ -7576,7 +7578,7 @@ static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
 				 struct smb2_ioctl_rsp *rsp)
 {
 	struct ksmbd_rpc_command *rpc_resp;
-	char *data_buf = (char *)&req->Buffer[0];
+	char *data_buf = (char *)req + le32_to_cpu(req->InputOffset);
 	int nbytes = 0;
 
 	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
@@ -7689,6 +7691,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
+	char *buffer;
 
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
@@ -7711,6 +7714,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 		goto out;
 	}
 
+	buffer = (char *)req + le32_to_cpu(req->InputOffset);
+
 	cnt_code = le32_to_cpu(req->CtlCode);
 	ret = smb2_calc_max_out_buf_len(work, 48,
 					le32_to_cpu(req->MaxOutputResponse));
@@ -7768,7 +7773,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_validate_negotiate_info(conn,
-			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_req *)buffer,
 			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
 			in_buf_len);
 		if (ret < 0)
@@ -7821,7 +7826,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->VolatileFileId = req->VolatileFileId;
 		rsp->PersistentFileId = req->PersistentFileId;
 		fsctl_copychunk(work,
-				(struct copychunk_ioctl_req *)&req->Buffer[0],
+				(struct copychunk_ioctl_req *)buffer,
 				le32_to_cpu(req->CtlCode),
 				le32_to_cpu(req->InputCount),
 				req->VolatileFileId,
@@ -7834,8 +7839,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		ret = fsctl_set_sparse(work, id,
-				       (struct file_sparse *)&req->Buffer[0]);
+		ret = fsctl_set_sparse(work, id, (struct file_sparse *)buffer);
 		if (ret < 0)
 			goto out;
 		break;
@@ -7858,7 +7862,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		zero_data =
-			(struct file_zero_data_information *)&req->Buffer[0];
+			(struct file_zero_data_information *)buffer;
 
 		off = le64_to_cpu(zero_data->FileOffset);
 		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
@@ -7889,7 +7893,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_query_allocated_ranges(work, id,
-			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)buffer,
 			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
 			out_buf_len /
 			sizeof(struct file_allocated_range_buffer), &nbytes);
@@ -7933,7 +7937,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+		dup_ext = (struct duplicate_extents_to_file *)buffer;
 
 		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
 					     dup_ext->PersistentFileHandle);
-- 
2.39.4


