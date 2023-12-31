Return-Path: <stable+bounces-9118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55A820A49
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F2DB217DE
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B517C3;
	Sun, 31 Dec 2023 07:20:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB317D3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fe9a6609eso57761145ab.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007213; x=1704612013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgRRJ+VZOGusJcA8x5lEDvUID24/mG5ChoZoqsapYNk=;
        b=NkvCCpZfMJbOSUEruGFBgnMyJPSua6w8eSOvOQyrgecVKEN+kYP+sVwDhTqixV8ixL
         asSmjjED60THYDv8/dPSZgWHezqPF2OfrfaVMZn89CBndyXm+LqDZVOafog7x9RPtMdF
         mt2STPdgvjBERCKe1rEP60TzTTTBqAleEwLELXQY6TcWI/I7AUecG2qxShd8G+qSvVZp
         p5q89oBYBQ7LwulF1UlS0Urgq6RdmK1zdlsWOdlPnUeU/GlCFrS/8Be6WwzeEghnwnMH
         a7GxnvQMJn83DDdljeS8D/fYWlA+ttqv4O7HLtj/xTb2vpsqbTK5bOjrf+8beNMLkl8l
         xJZg==
X-Gm-Message-State: AOJu0YzkLr+bS7DhlKKympIWMW2vCgx7CqS33eJiTK2RBlA1B4J+a7tW
	GCWNHrwOtkwHamXDr96vDNg=
X-Google-Smtp-Source: AGHT+IF6XmYu3j1fKbJ1NLILnFR36Nsmjo7SGnDQP4iZCYALy+PyIkZyaEHw/qhzT8gufJoPQEY8sQ==
X-Received: by 2002:a05:6e02:1baf:b0:35f:f11a:4655 with SMTP id n15-20020a056e021baf00b0035ff11a4655mr21448663ili.71.1704007212989;
        Sat, 30 Dec 2023 23:20:12 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 10/19] ksmbd: move oplock handling after unlock parent dir
Date: Sun, 31 Dec 2023 16:19:10 +0900
Message-Id: <20231231071919.32103-11-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 2e450920d58b4991a436c8cecf3484bcacd8e535 ]

ksmbd should process secound parallel smb2 create request during waiting
oplock break ack. parent lock range that is too large in smb2_open() causes
smb2_open() to be serialized. Move the oplock handling to the bottom of
smb2_open() and make it called after parent unlock. This fixes the failure
of smb2.lease.breaking1 testcase.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 121 +++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 56 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 28b61dad2749..e58504d0e9c1 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2691,7 +2691,7 @@ int smb2_open(struct ksmbd_work *work)
 		    *(char *)req->Buffer == '\\') {
 			pr_err("not allow directory name included leading slash\n");
 			rc = -EINVAL;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		name = smb2_get_name(req->Buffer,
@@ -2702,7 +2702,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc != -ENOMEM)
 				rc = -ENOENT;
 			name = NULL;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		ksmbd_debug(SMB, "converted name = %s\n", name);
@@ -2710,28 +2710,28 @@ int smb2_open(struct ksmbd_work *work)
 			if (!test_share_config_flag(work->tcon->share_conf,
 						    KSMBD_SHARE_FLAG_STREAMS)) {
 				rc = -EBADF;
-				goto err_out1;
+				goto err_out2;
 			}
 			rc = parse_stream_name(name, &stream_name, &s_type);
 			if (rc < 0)
-				goto err_out1;
+				goto err_out2;
 		}
 
 		rc = ksmbd_validate_filename(name);
 		if (rc < 0)
-			goto err_out1;
+			goto err_out2;
 
 		if (ksmbd_share_veto_filename(share, name)) {
 			rc = -ENOENT;
 			ksmbd_debug(SMB, "Reject open(), vetoed file: %s\n",
 				    name);
-			goto err_out1;
+			goto err_out2;
 		}
 	} else {
 		name = kstrdup("", GFP_KERNEL);
 		if (!name) {
 			rc = -ENOMEM;
-			goto err_out1;
+			goto err_out2;
 		}
 	}
 
@@ -2744,14 +2744,14 @@ int smb2_open(struct ksmbd_work *work)
 		       le32_to_cpu(req->ImpersonationLevel));
 		rc = -EIO;
 		rsp->hdr.Status = STATUS_BAD_IMPERSONATION_LEVEL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK_LE)) {
 		pr_err("Invalid create options : 0x%x\n",
 		       le32_to_cpu(req->CreateOptions));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	} else {
 		if (req->CreateOptions & FILE_SEQUENTIAL_ONLY_LE &&
 		    req->CreateOptions & FILE_RANDOM_ACCESS_LE)
@@ -2761,13 +2761,13 @@ int smb2_open(struct ksmbd_work *work)
 		    (FILE_OPEN_BY_FILE_ID_LE | CREATE_TREE_CONNECTION |
 		     FILE_RESERVE_OPFILTER_LE)) {
 			rc = -EOPNOTSUPP;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE) {
 				rc = -EINVAL;
-				goto err_out1;
+				goto err_out2;
 			} else if (req->CreateOptions & FILE_NO_COMPRESSION_LE) {
 				req->CreateOptions = ~(FILE_NO_COMPRESSION_LE);
 			}
@@ -2779,21 +2779,21 @@ int smb2_open(struct ksmbd_work *work)
 		pr_err("Invalid create disposition : 0x%x\n",
 		       le32_to_cpu(req->CreateDisposition));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (!(req->DesiredAccess & DESIRED_ACCESS_MASK)) {
 		pr_err("Invalid desired access : 0x%x\n",
 		       le32_to_cpu(req->DesiredAccess));
 		rc = -EACCES;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->FileAttributes && !(req->FileAttributes & FILE_ATTRIBUTE_MASK_LE)) {
 		pr_err("Invalid file attribute : 0x%x\n",
 		       le32_to_cpu(req->FileAttributes));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->CreateContextsOffset) {
@@ -2801,19 +2801,19 @@ int smb2_open(struct ksmbd_work *work)
 		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ea_buf = (struct create_ea_buf_req *)context;
 			if (le16_to_cpu(context->DataOffset) +
 			    le32_to_cpu(context->DataLength) <
 			    sizeof(struct create_ea_buf_req)) {
 				rc = -EINVAL;
-				goto err_out1;
+				goto err_out2;
 			}
 			if (req->CreateOptions & FILE_NO_EA_KNOWLEDGE_LE) {
 				rsp->hdr.Status = STATUS_ACCESS_DENIED;
 				rc = -EACCES;
-				goto err_out1;
+				goto err_out2;
 			}
 		}
 
@@ -2821,7 +2821,7 @@ int smb2_open(struct ksmbd_work *work)
 						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ksmbd_debug(SMB,
 				    "get query maximal access context\n");
@@ -2832,11 +2832,11 @@ int smb2_open(struct ksmbd_work *work)
 						 SMB2_CREATE_TIMEWARP_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ksmbd_debug(SMB, "get timewarp context\n");
 			rc = -EBADF;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		if (tcon->posix_extensions) {
@@ -2844,7 +2844,7 @@ int smb2_open(struct ksmbd_work *work)
 							 SMB2_CREATE_TAG_POSIX, 16);
 			if (IS_ERR(context)) {
 				rc = PTR_ERR(context);
-				goto err_out1;
+				goto err_out2;
 			} else if (context) {
 				struct create_posix *posix =
 					(struct create_posix *)context;
@@ -2852,7 +2852,7 @@ int smb2_open(struct ksmbd_work *work)
 				    le32_to_cpu(context->DataLength) <
 				    sizeof(struct create_posix) - 4) {
 					rc = -EINVAL;
-					goto err_out1;
+					goto err_out2;
 				}
 				ksmbd_debug(SMB, "get posix context\n");
 
@@ -2864,7 +2864,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (ksmbd_override_fsids(work)) {
 		rc = -ENOMEM;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
@@ -3177,11 +3177,6 @@ int smb2_open(struct ksmbd_work *work)
 
 	fp->attrib_only = !(req->DesiredAccess & ~(FILE_READ_ATTRIBUTES_LE |
 			FILE_WRITE_ATTRIBUTES_LE | FILE_SYNCHRONIZE_LE));
-	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
-	    !fp->attrib_only && !stream_name) {
-		smb_break_all_oplock(work, fp);
-		need_truncate = 1;
-	}
 
 	/* fp should be searchable through ksmbd_inode.m_fp_list
 	 * after daccess, saccess, attrib_only, and stream are
@@ -3197,13 +3192,39 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc)
+		goto err_out;
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr =
+			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
+	if (file_present || created)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
+	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
+	    !fp->attrib_only && !stream_name) {
+		smb_break_all_oplock(work, fp);
+		need_truncate = 1;
+	}
+
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
 	     !(conn->vals->capabilities & SMB2_GLOBAL_CAP_LEASING))) {
 		if (share_ret < 0 && !S_ISDIR(file_inode(fp->filp)->i_mode)) {
 			rc = share_ret;
-			goto err_out;
+			goto err_out1;
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
@@ -3213,7 +3234,7 @@ int smb2_open(struct ksmbd_work *work)
 				    name, req_op_level, lc->req_state);
 			rc = find_same_lease_key(sess, fp->f_ci, lc);
 			if (rc)
-				goto err_out;
+				goto err_out1;
 		} else if (open_flags == O_RDONLY &&
 			   (req_op_level == SMB2_OPLOCK_LEVEL_BATCH ||
 			    req_op_level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
@@ -3224,12 +3245,18 @@ int smb2_open(struct ksmbd_work *work)
 				      le32_to_cpu(req->hdr.Id.SyncId.TreeId),
 				      lc, share_ret);
 		if (rc < 0)
-			goto err_out;
+			goto err_out1;
 	}
 
 	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
 		ksmbd_fd_set_delete_on_close(fp, file_info);
 
+	if (need_truncate) {
+		rc = smb2_create_truncate(&fp->filp->f_path);
+		if (rc)
+			goto err_out1;
+	}
+
 	if (req->CreateContextsOffset) {
 		struct create_alloc_size_req *az_req;
 
@@ -3237,7 +3264,7 @@ int smb2_open(struct ksmbd_work *work)
 					SMB2_CREATE_ALLOCATION_SIZE, 4);
 		if (IS_ERR(az_req)) {
 			rc = PTR_ERR(az_req);
-			goto err_out;
+			goto err_out1;
 		} else if (az_req) {
 			loff_t alloc_size;
 			int err;
@@ -3246,7 +3273,7 @@ int smb2_open(struct ksmbd_work *work)
 			    le32_to_cpu(az_req->ccontext.DataLength) <
 			    sizeof(struct create_alloc_size_req)) {
 				rc = -EINVAL;
-				goto err_out;
+				goto err_out1;
 			}
 			alloc_size = le64_to_cpu(az_req->AllocationSize);
 			ksmbd_debug(SMB,
@@ -3264,30 +3291,13 @@ int smb2_open(struct ksmbd_work *work)
 		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out;
+			goto err_out1;
 		} else if (context) {
 			ksmbd_debug(SMB, "get query on disk id context\n");
 			query_disk_id = 1;
 		}
 	}
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc)
-		goto err_out;
-
-	if (stat.result_mask & STATX_BTIME)
-		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
-	else
-		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
-	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
-		fp->f_ci->m_fattr =
-			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
-
-	if (!created)
-		smb2_update_xattrs(tcon, &path, fp);
-	else
-		smb2_new_xattrs(tcon, &path, fp);
-
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
 	rsp->StructureSize = cpu_to_le16(89);
@@ -3394,14 +3404,13 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created)
+	if (rc && (file_present || created))
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
-	if (fp && need_truncate)
-		rc = smb2_create_truncate(&fp->filp->f_path);
-
-	ksmbd_revert_fsids(work);
 err_out1:
+	ksmbd_revert_fsids(work);
+
+err_out2:
 	if (!rc) {
 		ksmbd_update_fstate(&work->sess->file_table, fp, FP_INITED);
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
-- 
2.25.1


