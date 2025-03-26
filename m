Return-Path: <stable+bounces-126777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA118A71DC3
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F231888C32
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E51F7069;
	Wed, 26 Mar 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow7XzhN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A911A8407
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011696; cv=none; b=nPortzzmZNqyAITCmYpLCPpKDzIU7eCmYdzSQlGHX4kazIZdQgKzYGNoGhTK+YXohJS7vQXr9shWkMmRd3FKoxwJ6mlHE2HmD+BtXozrWZss3TXS9hXDp5VO6bdFkWYY7VNVqXw1gLz/rADqgKC6Lv4RdoBczvnCftSgd/BqApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011696; c=relaxed/simple;
	bh=u2Nta1DoolXBcL1p2tIntR8USU9dslowjPJ3vxGgVxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bohqnqk/4QQHKKTLDDKpjRAnCrg5zkw5H2rut4oJWI3tq57rW2i5OTsr2yMjpv4/BbSdVWB182po/Nxt8/Nup4xuCxPB+jSBZ2n8xSHol97Wjwl7hp21ttoicYW/+1o6KJQX82/j/iLwZcUg8Y/vHxinrG5r/Adbd/OLMrjpfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow7XzhN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689A2C4CEE2;
	Wed, 26 Mar 2025 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011694;
	bh=u2Nta1DoolXBcL1p2tIntR8USU9dslowjPJ3vxGgVxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ow7XzhN0LWlNFactwpQ0m0NzShI9OxmhH/xrR4VCNDlWJsqB4OvBp+BaJMYXkysIW
	 kKY72jsnD/qsqysPvr3MGZP0Svl3BUgjkPyfVOxDDfNlHU2Ubs+4TtayQxlFNWbiNW
	 WZGYbHa8qlJ1fyKaWcx43mt1JHCt/8EyZqiFEESKnWwsBhXkw5wB54Wwsu/tOPAoj8
	 2QAEOtGnKJc6yWnkQVTuyGqS+bhWMoN3EPtKkIqvjhWpRFn8D7uBqwW8Wec3lgjko/
	 J8qXZjWe7uIcL3SQ9eyXqcBKjJzUAIKgDoIskbHHLYIL3EoRktGlex2wXUQ8PLdS2m
	 TCo0K/f4rSmYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ksmbd: fix potencial out-of-bounds when buffer offset is invalid
Date: Wed, 26 Mar 2025 13:54:50 -0400
Message-Id: <20250326124827-b6729f136adb38d0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326083059.3723005-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Namjae Jeon<linkinjeon@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 39bdc4197acf)
6.1.y | Present (different SHA1: ad6480c9a5d8)

Note: The patch differs from the upstream commit:
---
1:  c6cd2e8d2d9aa ! 1:  0903a126928c6 ksmbd: fix potencial out-of-bounds when buffer offset is invalid
    @@ Metadata
      ## Commit message ##
         ksmbd: fix potencial out-of-bounds when buffer offset is invalid
     
    +    [ Upstream commit c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da ]
    +
         I found potencial out-of-bounds when buffer offset fields of a few requests
         is invalid. This patch set the minimum value of buffer offset field to
         ->Buffer offset to validate buffer length.
    @@ Commit message
         Cc: stable@vger.kernel.org
         Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## fs/smb/server/smb2misc.c ##
    -@@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
    + ## fs/ksmbd/smb2misc.c ##
    +@@ fs/ksmbd/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
      		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
      		break;
      	case SMB2_TREE_CONNECT:
    @@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, u
      		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
      		break;
      	case SMB2_CREATE:
    -@@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
    - 			max_t(unsigned short int,
    - 			      le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset),
    - 			      offsetof(struct smb2_create_req, Buffer));
    --
    - 		unsigned short int name_len =
    - 			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
    - 
    -@@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
    +@@ fs/ksmbd/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
      		break;
      	}
      	case SMB2_QUERY_INFO:
    @@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, u
      		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
      		break;
      	case SMB2_READ:
    -@@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
    +@@ fs/ksmbd/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
      	case SMB2_WRITE:
      		if (((struct smb2_write_req *)hdr)->DataOffset ||
      		    ((struct smb2_write_req *)hdr)->Length) {
     -			*off = max_t(unsigned int,
     +			*off = max_t(unsigned short int,
      				     le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset),
    - 				     offsetof(struct smb2_write_req, Buffer));
    + 				     offsetof(struct smb2_write_req, Buffer) - 4);
      			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
    -@@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
    +@@ fs/ksmbd/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
      		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
      		break;
      	case SMB2_QUERY_DIRECTORY:
    @@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, u
      		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
      		break;
      	case SMB2_LOCK:
    -@@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
    +@@ fs/ksmbd/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
      		break;
      	}
      	case SMB2_IOCTL:
    @@ fs/smb/server/smb2misc.c: static int smb2_get_data_area_len(unsigned int *off, u
      		break;
      	default:
     
    - ## fs/smb/server/smb2pdu.c ##
    -@@ fs/smb/server/smb2pdu.c: int smb2_tree_connect(struct ksmbd_work *work)
    + ## fs/ksmbd/smb2pdu.c ##
    +@@ fs/ksmbd/smb2pdu.c: int smb2_tree_connect(struct ksmbd_work *work)
      
      	WORK_BUFFERS(work, req, rsp);
      
    @@ fs/smb/server/smb2pdu.c: int smb2_tree_connect(struct ksmbd_work *work)
      					  le16_to_cpu(req->PathLength), true,
      					  conn->local_nls);
      	if (IS_ERR(treename)) {
    -@@ fs/smb/server/smb2pdu.c: int smb2_open(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_open(struct ksmbd_work *work)
      			goto err_out2;
      		}
      
    @@ fs/smb/server/smb2pdu.c: int smb2_open(struct ksmbd_work *work)
      				     le16_to_cpu(req->NameLength),
      				     work->conn->local_nls);
      		if (IS_ERR(name)) {
    -@@ fs/smb/server/smb2pdu.c: int smb2_query_dir(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_query_dir(struct ksmbd_work *work)
      	}
      
      	srch_flag = req->Flags;
    @@ fs/smb/server/smb2pdu.c: int smb2_query_dir(struct ksmbd_work *work)
      					  le16_to_cpu(req->FileNameLength), 1,
      					  conn->local_nls);
      	if (IS_ERR(srch_ptr)) {
    -@@ fs/smb/server/smb2pdu.c: static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
      		    sizeof(struct smb2_ea_info_req))
      			return -EINVAL;
      
    @@ fs/smb/server/smb2pdu.c: static int smb2_get_ea(struct ksmbd_work *work, struct
      	} else {
      		/* need to send all EAs, if no specific EA is requested*/
      		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      			      struct ksmbd_share_config *share)
      {
      	unsigned int buf_len = le32_to_cpu(req->BufferLength);
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      
      	switch (req->FileInfoClass) {
      	case FILE_BASIC_INFORMATION:
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      		if (buf_len < sizeof(struct smb2_file_basic_info))
      			return -EINVAL;
      
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      	}
      	case FILE_ALLOCATION_INFORMATION:
      	{
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      			return -EINVAL;
      
      		return set_file_allocation_info(work, fp,
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      	}
      	case FILE_END_OF_FILE_INFORMATION:
      	{
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      			return -EINVAL;
      
      		return set_end_of_file_info(work, fp,
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      	}
      	case FILE_RENAME_INFORMATION:
      	{
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      			return -EINVAL;
      
      		return set_rename_info(work, fp,
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      				       buf_len);
      	}
      	case FILE_LINK_INFORMATION:
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      			return -EINVAL;
      
      		return smb2_create_link(work, work->tcon->share_conf,
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      					buf_len, fp->filp,
      					work->conn->local_nls);
      	}
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      			return -EINVAL;
      
      		return set_file_disposition_info(fp,
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      	}
      	case FILE_FULL_EA_INFORMATION:
      	{
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      		if (buf_len < sizeof(struct smb2_ea_info))
      			return -EINVAL;
      
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      				   buf_len, &fp->filp->f_path, true);
      	}
      	case FILE_POSITION_INFORMATION:
    -@@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
    +@@ fs/ksmbd/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
      		if (buf_len < sizeof(struct smb2_file_pos_info))
      			return -EINVAL;
      
    @@ fs/smb/server/smb2pdu.c: static int smb2_set_info_file(struct ksmbd_work *work,
      	}
      	}
      
    -@@ fs/smb/server/smb2pdu.c: int smb2_set_info(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_set_info(struct ksmbd_work *work)
      		}
      		rc = smb2_set_info_sec(fp,
      				       le32_to_cpu(req->AdditionalInformation),
    @@ fs/smb/server/smb2pdu.c: int smb2_set_info(struct ksmbd_work *work)
      				       le32_to_cpu(req->BufferLength));
      		ksmbd_revert_fsids(work);
      		break;
    -@@ fs/smb/server/smb2pdu.c: static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
    +@@ fs/ksmbd/smb2pdu.c: static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
      				 struct smb2_ioctl_rsp *rsp)
      {
      	struct ksmbd_rpc_command *rpc_resp;
    @@ fs/smb/server/smb2pdu.c: static int fsctl_pipe_transceive(struct ksmbd_work *wor
      	int nbytes = 0;
      
      	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      	u64 id = KSMBD_NO_FID;
      	struct ksmbd_conn *conn = work->conn;
      	int ret = 0;
    @@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      
      	if (work->next_smb2_rcv_hdr_off) {
      		req = ksmbd_req_buf_next(work);
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      		goto out;
      	}
      
     +	buffer = (char *)req + le32_to_cpu(req->InputOffset);
    -+
    - 	cnt_code = le32_to_cpu(req->CtlCode);
    + 	cnt_code = le32_to_cpu(req->CntCode);
      	ret = smb2_calc_max_out_buf_len(work, 48,
      					le32_to_cpu(req->MaxOutputResponse));
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      		}
      
      		ret = fsctl_validate_negotiate_info(conn,
    @@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
      			in_buf_len);
      		if (ret < 0)
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      		rsp->VolatileFileId = req->VolatileFileId;
      		rsp->PersistentFileId = req->PersistentFileId;
      		fsctl_copychunk(work,
     -				(struct copychunk_ioctl_req *)&req->Buffer[0],
     +				(struct copychunk_ioctl_req *)buffer,
    - 				le32_to_cpu(req->CtlCode),
    + 				le32_to_cpu(req->CntCode),
      				le32_to_cpu(req->InputCount),
      				req->VolatileFileId,
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      			goto out;
      		}
      
    @@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      		if (ret < 0)
      			goto out;
      		break;
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      		}
      
      		zero_data =
    @@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      
      		off = le64_to_cpu(zero_data->FileOffset);
      		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      		}
      
      		ret = fsctl_query_allocated_ranges(work, id,
    @@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
      			out_buf_len /
      			sizeof(struct file_allocated_range_buffer), &nbytes);
    -@@ fs/smb/server/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
    +@@ fs/ksmbd/smb2pdu.c: int smb2_ioctl(struct ksmbd_work *work)
      			goto out;
      		}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

