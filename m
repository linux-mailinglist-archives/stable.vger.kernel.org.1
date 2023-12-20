Return-Path: <stable+bounces-8024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2B81A41D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F307B22A50
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B400B48CD7;
	Wed, 20 Dec 2023 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zgwCCpQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79787482E7;
	Wed, 20 Dec 2023 16:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942A9C433C8;
	Wed, 20 Dec 2023 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088699;
	bh=l3vFsJd0dKjhNJDZoharITHDRa+UVfcn9krw7Tnw6AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zgwCCpQXtG6mWQK52louvL1G7y6Am/2UQVkEBsHozz/JDuu3c/B7KPQ1EYxQpQuf2
	 KbdnXptgTlWSwxajGLME2f3KnqPh3ZWaPdOKK5vA1GLudRtODtnaL0zZnSHlMta8IW
	 wR/VRodLemYWANm3V7rXEZMSXETNrI95kWN2ue0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@cjr.nz>,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 026/159] ksmbd: store fids as opaque u64 integers
Date: Wed, 20 Dec 2023 17:08:11 +0100
Message-ID: <20231220160932.501998840@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>

[ Upstream commit 2d004c6cae567e33ab2e197757181c72a322451f ]

There is no need to store the fids as le64 integers as they are opaque
to the client and only used for equality.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   94 +++++++++++++++++++++--------------------------------
 fs/ksmbd/smb2pdu.h |   34 +++++++++----------
 2 files changed, 56 insertions(+), 72 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -392,12 +392,8 @@ static void init_chained_smb2_rsp(struct
 	 * command in the compound request
 	 */
 	if (req->Command == SMB2_CREATE && rsp->Status == STATUS_SUCCESS) {
-		work->compound_fid =
-			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
-				VolatileFileId);
-		work->compound_pfid =
-			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
-				PersistentFileId);
+		work->compound_fid = ((struct smb2_create_rsp *)rsp)->VolatileFileId;
+		work->compound_pfid = ((struct smb2_create_rsp *)rsp)->PersistentFileId;
 		work->compound_sid = le64_to_cpu(rsp->SessionId);
 	}
 
@@ -2192,7 +2188,7 @@ static noinline int create_smb2_pipe(str
 	rsp->EndofFile = cpu_to_le64(0);
 	rsp->FileAttributes = ATTR_NORMAL_LE;
 	rsp->Reserved2 = 0;
-	rsp->VolatileFileId = cpu_to_le64(id);
+	rsp->VolatileFileId = id;
 	rsp->PersistentFileId = 0;
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
@@ -3230,8 +3226,8 @@ int smb2_open(struct ksmbd_work *work)
 
 	rsp->Reserved2 = 0;
 
-	rsp->PersistentFileId = cpu_to_le64(fp->persistent_id);
-	rsp->VolatileFileId = cpu_to_le64(fp->volatile_id);
+	rsp->PersistentFileId = fp->persistent_id;
+	rsp->VolatileFileId = fp->volatile_id;
 
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
@@ -3939,9 +3935,7 @@ int smb2_query_dir(struct ksmbd_work *wo
 		goto err_out2;
 	}
 
-	dir_fp = ksmbd_lookup_fd_slow(work,
-				      le64_to_cpu(req->VolatileFileId),
-				      le64_to_cpu(req->PersistentFileId));
+	dir_fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!dir_fp) {
 		rc = -EBADF;
 		goto err_out2;
@@ -4169,12 +4163,12 @@ static int smb2_get_info_file_pipe(struc
 	 * Windows can sometime send query file info request on
 	 * pipe without opening it, checking error condition here
 	 */
-	id = le64_to_cpu(req->VolatileFileId);
+	id = req->VolatileFileId;
 	if (!ksmbd_session_rpc_method(sess, id))
 		return -ENOENT;
 
 	ksmbd_debug(SMB, "FileInfoClass %u, FileId 0x%llx\n",
-		    req->FileInfoClass, le64_to_cpu(req->VolatileFileId));
+		    req->FileInfoClass, req->VolatileFileId);
 
 	switch (req->FileInfoClass) {
 	case FILE_STANDARD_INFORMATION:
@@ -4804,7 +4798,7 @@ static int smb2_get_info_file(struct ksm
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
@@ -4813,8 +4807,8 @@ static int smb2_get_info_file(struct ksm
 	}
 
 	if (!has_file_id(id)) {
-		id = le64_to_cpu(req->VolatileFileId);
-		pid = le64_to_cpu(req->PersistentFileId);
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
 	}
 
 	fp = ksmbd_lookup_fd_slow(work, id, pid);
@@ -5188,7 +5182,7 @@ static int smb2_get_info_sec(struct ksmb
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
@@ -5197,8 +5191,8 @@ static int smb2_get_info_sec(struct ksmb
 	}
 
 	if (!has_file_id(id)) {
-		id = le64_to_cpu(req->VolatileFileId);
-		pid = le64_to_cpu(req->PersistentFileId);
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
 	}
 
 	fp = ksmbd_lookup_fd_slow(work, id, pid);
@@ -5299,7 +5293,7 @@ static noinline int smb2_close_pipe(stru
 	struct smb2_close_req *req = smb2_get_msg(work->request_buf);
 	struct smb2_close_rsp *rsp = smb2_get_msg(work->response_buf);
 
-	id = le64_to_cpu(req->VolatileFileId);
+	id = req->VolatileFileId;
 	ksmbd_session_rpc_close(work->sess, id);
 
 	rsp->StructureSize = cpu_to_le16(60);
@@ -5358,7 +5352,7 @@ int smb2_close(struct ksmbd_work *work)
 	}
 
 	if (work->next_smb2_rcv_hdr_off &&
-	    !has_file_id(le64_to_cpu(req->VolatileFileId))) {
+	    !has_file_id(req->VolatileFileId)) {
 		if (!has_file_id(work->compound_fid)) {
 			/* file already closed, return FILE_CLOSED */
 			ksmbd_debug(SMB, "file already closed\n");
@@ -5377,7 +5371,7 @@ int smb2_close(struct ksmbd_work *work)
 			work->compound_pfid = KSMBD_NO_FID;
 		}
 	} else {
-		volatile_id = le64_to_cpu(req->VolatileFileId);
+		volatile_id = req->VolatileFileId;
 	}
 	ksmbd_debug(SMB, "volatile_id = %llu\n", volatile_id);
 
@@ -6070,7 +6064,7 @@ int smb2_set_info(struct ksmbd_work *wor
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
@@ -6082,8 +6076,8 @@ int smb2_set_info(struct ksmbd_work *wor
 	}
 
 	if (!has_file_id(id)) {
-		id = le64_to_cpu(req->VolatileFileId);
-		pid = le64_to_cpu(req->PersistentFileId);
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
 	}
 
 	fp = ksmbd_lookup_fd_slow(work, id, pid);
@@ -6161,7 +6155,7 @@ static noinline int smb2_read_pipe(struc
 	struct smb2_read_req *req = smb2_get_msg(work->request_buf);
 	struct smb2_read_rsp *rsp = smb2_get_msg(work->response_buf);
 
-	id = le64_to_cpu(req->VolatileFileId);
+	id = req->VolatileFileId;
 
 	inc_rfc1001_len(work->response_buf, 16);
 	rpc_resp = ksmbd_rpc_read(work->sess, id);
@@ -6302,8 +6296,7 @@ int smb2_read(struct ksmbd_work *work)
 			goto out;
 	}
 
-	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
 		err = -ENOENT;
 		goto out;
@@ -6422,7 +6415,7 @@ static noinline int smb2_write_pipe(stru
 	size_t length;
 
 	length = le32_to_cpu(req->Length);
-	id = le64_to_cpu(req->VolatileFileId);
+	id = req->VolatileFileId;
 
 	if (le16_to_cpu(req->DataOffset) ==
 	    offsetof(struct smb2_write_req, Buffer)) {
@@ -6558,8 +6551,7 @@ int smb2_write(struct ksmbd_work *work)
 		goto out;
 	}
 
-	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
 		err = -ENOENT;
 		goto out;
@@ -6668,12 +6660,9 @@ int smb2_flush(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n",
-		    le64_to_cpu(req->VolatileFileId));
+	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n", req->VolatileFileId);
 
-	err = ksmbd_vfs_fsync(work,
-			      le64_to_cpu(req->VolatileFileId),
-			      le64_to_cpu(req->PersistentFileId));
+	err = ksmbd_vfs_fsync(work, req->VolatileFileId, req->PersistentFileId);
 	if (err)
 		goto out;
 
@@ -6888,12 +6877,9 @@ int smb2_lock(struct ksmbd_work *work)
 	int prior_lock = 0;
 
 	ksmbd_debug(SMB, "Received lock request\n");
-	fp = ksmbd_lookup_fd_slow(work,
-				  le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
-		ksmbd_debug(SMB, "Invalid file id for lock : %llu\n",
-			    le64_to_cpu(req->VolatileFileId));
+		ksmbd_debug(SMB, "Invalid file id for lock : %llu\n", req->VolatileFileId);
 		err = -ENOENT;
 		goto out2;
 	}
@@ -7249,8 +7235,8 @@ static int fsctl_copychunk(struct ksmbd_
 
 	ci_rsp = (struct copychunk_ioctl_rsp *)&rsp->Buffer[0];
 
-	rsp->VolatileFileId = cpu_to_le64(volatile_id);
-	rsp->PersistentFileId = cpu_to_le64(persistent_id);
+	rsp->VolatileFileId = volatile_id;
+	rsp->PersistentFileId = persistent_id;
 	ci_rsp->ChunksWritten =
 		cpu_to_le32(ksmbd_server_side_copy_max_chunk_count());
 	ci_rsp->ChunkBytesWritten =
@@ -7464,8 +7450,8 @@ ipv6_retry:
 	if (nii_rsp)
 		nii_rsp->Next = 0;
 
-	rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
-	rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+	rsp->PersistentFileId = SMB2_NO_FID;
+	rsp->VolatileFileId = SMB2_NO_FID;
 	return nbytes;
 }
 
@@ -7635,9 +7621,7 @@ static int fsctl_request_resume_key(stru
 {
 	struct ksmbd_file *fp;
 
-	fp = ksmbd_lookup_fd_slow(work,
-				  le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp)
 		return -ENOENT;
 
@@ -7667,7 +7651,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
@@ -7678,7 +7662,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	}
 
 	if (!has_file_id(id))
-		id = le64_to_cpu(req->VolatileFileId);
+		id = req->VolatileFileId;
 
 	if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
 		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
@@ -7749,8 +7733,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 
 		nbytes = sizeof(struct validate_negotiate_info_rsp);
-		rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
-		rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+		rsp->PersistentFileId = SMB2_NO_FID;
+		rsp->VolatileFileId = SMB2_NO_FID;
 		break;
 	case FSCTL_QUERY_NETWORK_INTERFACE_INFO:
 		ret = fsctl_query_iface_info_ioctl(conn, rsp, out_buf_len);
@@ -7798,8 +7782,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 				(struct copychunk_ioctl_req *)&req->Buffer[0],
 				le32_to_cpu(req->CntCode),
 				le32_to_cpu(req->InputCount),
-				le64_to_cpu(req->VolatileFileId),
-				le64_to_cpu(req->PersistentFileId),
+				req->VolatileFileId,
+				req->PersistentFileId,
 				rsp);
 		break;
 	case FSCTL_SET_SPARSE:
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -634,8 +634,8 @@ struct create_durable_reconn_req {
 	union {
 		__u8  Reserved[16];
 		struct {
-			__le64 PersistentFileId;
-			__le64 VolatileFileId;
+			__u64 PersistentFileId;
+			__u64 VolatileFileId;
 		} Fid;
 	} Data;
 } __packed;
@@ -644,8 +644,8 @@ struct create_durable_reconn_v2_req {
 	struct create_context ccontext;
 	__u8   Name[8];
 	struct {
-		__le64 PersistentFileId;
-		__le64 VolatileFileId;
+		__u64 PersistentFileId;
+		__u64 VolatileFileId;
 	} Fid;
 	__u8 CreateGuid[16];
 	__le32 Flags;
@@ -889,8 +889,8 @@ struct smb2_ioctl_req {
 	__le16 StructureSize; /* Must be 57 */
 	__le16 Reserved; /* offset from start of SMB2 header to write data */
 	__le32 CntCode;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__le32 InputOffset; /* Reserved MBZ */
 	__le32 InputCount;
 	__le32 MaxInputResponse;
@@ -907,8 +907,8 @@ struct smb2_ioctl_rsp {
 	__le16 StructureSize; /* Must be 49 */
 	__le16 Reserved; /* offset from start of SMB2 header to write data */
 	__le32 CntCode;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__le32 InputOffset; /* Reserved MBZ */
 	__le32 InputCount;
 	__le32 OutputOffset;
@@ -977,7 +977,7 @@ struct file_object_buf_type1_ioctl_rsp {
 } __packed;
 
 struct resume_key_ioctl_rsp {
-	__le64 ResumeKey[3];
+	__u64 ResumeKey[3];
 	__le32 ContextLength;
 	__u8 Context[4]; /* ignored, Windows sets to 4 bytes of zero */
 } __packed;
@@ -1089,8 +1089,8 @@ struct smb2_lock_req {
 	__le16 StructureSize; /* Must be 48 */
 	__le16 LockCount;
 	__le32 Reserved;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	/* Followed by at least one */
 	struct smb2_lock_element locks[1];
 } __packed;
@@ -1125,8 +1125,8 @@ struct smb2_query_directory_req {
 	__u8   FileInformationClass;
 	__u8   Flags;
 	__le32 FileIndex;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
@@ -1172,8 +1172,8 @@ struct smb2_query_info_req {
 	__le32 InputBufferLength;
 	__le32 AdditionalInformation;
 	__le32 Flags;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__u8   Buffer[1];
 } __packed;
 
@@ -1194,8 +1194,8 @@ struct smb2_set_info_req {
 	__le16 BufferOffset;
 	__u16  Reserved;
 	__le32 AdditionalInformation;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__u8   Buffer[1];
 } __packed;
 



