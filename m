Return-Path: <stable+bounces-8027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1E81A422
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415E9B279C4
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0C495FD;
	Wed, 20 Dec 2023 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDSk9Z09"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036B495E2;
	Wed, 20 Dec 2023 16:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD99C433C7;
	Wed, 20 Dec 2023 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088708;
	bh=p8K6/xZFc8VTb7UwNxPlc0lye2jU9lLaVoFYhKsZoE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDSk9Z09Xy/TuezbHIOSYgXBKvS6MJaGKeRy3zkicNZSFLblTRgwwrb3/GxENR55H
	 +n3ihATao3N5V+pDTeHZzXutnWYy7x5pAREFxzZfo6jtiQiCwsGtvjMqlBuUe62k1c
	 0JSXFXiKMaYcx6Fu1+q7KZyugr5P+kATYDF5jDec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 005/159] ksmbd: remove smb2_buf_length in smb2_hdr
Date: Wed, 20 Dec 2023 17:07:50 +0100
Message-ID: <20231220160931.526415758@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit cb4517201b8acdb5fd5314494aaf86c267f22345 ]

To move smb2_hdr to smbfs_common, This patch remove smb2_buf_length
variable in smb2_hdr. Also, declare smb2_get_msg function to get smb2
request/response from ->request/response_buf.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/auth.c           |    4 
 fs/ksmbd/connection.c     |    9 
 fs/ksmbd/ksmbd_work.h     |    4 
 fs/ksmbd/oplock.c         |   24 +-
 fs/ksmbd/smb2pdu.c        |  435 ++++++++++++++++++++++------------------------
 fs/ksmbd/smb2pdu.h        |   20 +-
 fs/ksmbd/smb_common.c     |   11 -
 fs/ksmbd/smb_common.h     |    6 
 fs/ksmbd/transport_rdma.c |    2 
 9 files changed, 256 insertions(+), 259 deletions(-)

--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -884,9 +884,9 @@ int ksmbd_gen_preauth_integrity_hash(str
 				     __u8 *pi_hash)
 {
 	int rc;
-	struct smb2_hdr *rcv_hdr = (struct smb2_hdr *)buf;
+	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
-	int msg_size = be32_to_cpu(rcv_hdr->smb2_buf_length);
+	int msg_size = get_rfc1002_len(buf);
 	struct ksmbd_crypto_ctx *ctx = NULL;
 
 	if (conn->preauth_info->Preauth_HashId !=
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -160,14 +160,13 @@ void ksmbd_conn_wait_idle(struct ksmbd_c
 int ksmbd_conn_write(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb_hdr *rsp_hdr = work->response_buf;
 	size_t len = 0;
 	int sent;
 	struct kvec iov[3];
 	int iov_idx = 0;
 
 	ksmbd_conn_try_dequeue_request(work);
-	if (!rsp_hdr) {
+	if (!work->response_buf) {
 		pr_err("NULL response header\n");
 		return -EINVAL;
 	}
@@ -179,7 +178,7 @@ int ksmbd_conn_write(struct ksmbd_work *
 	}
 
 	if (work->aux_payload_sz) {
-		iov[iov_idx] = (struct kvec) { rsp_hdr, work->resp_hdr_sz };
+		iov[iov_idx] = (struct kvec) { work->response_buf, work->resp_hdr_sz };
 		len += iov[iov_idx++].iov_len;
 		iov[iov_idx] = (struct kvec) { work->aux_payload_buf, work->aux_payload_sz };
 		len += iov[iov_idx++].iov_len;
@@ -187,8 +186,8 @@ int ksmbd_conn_write(struct ksmbd_work *
 		if (work->tr_buf)
 			iov[iov_idx].iov_len = work->resp_hdr_sz;
 		else
-			iov[iov_idx].iov_len = get_rfc1002_len(rsp_hdr) + 4;
-		iov[iov_idx].iov_base = rsp_hdr;
+			iov[iov_idx].iov_len = get_rfc1002_len(work->response_buf) + 4;
+		iov[iov_idx].iov_base = work->response_buf;
 		len += iov[iov_idx++].iov_len;
 	}
 
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -92,7 +92,7 @@ struct ksmbd_work {
  */
 static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
 {
-	return work->response_buf + work->next_smb2_rsp_hdr_off;
+	return work->response_buf + work->next_smb2_rsp_hdr_off + 4;
 }
 
 /**
@@ -101,7 +101,7 @@ static inline void *ksmbd_resp_buf_next(
  */
 static inline void *ksmbd_req_buf_next(struct ksmbd_work *work)
 {
-	return work->request_buf + work->next_smb2_rcv_hdr_off;
+	return work->request_buf + work->next_smb2_rcv_hdr_off + 4;
 }
 
 struct ksmbd_work *ksmbd_alloc_work_struct(void);
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -630,10 +630,10 @@ static void __smb2_oplock_break_noti(str
 		return;
 	}
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -646,7 +646,7 @@ static void __smb2_oplock_break_noti(str
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -660,7 +660,7 @@ static void __smb2_oplock_break_noti(str
 	rsp->PersistentFid = cpu_to_le64(fp->persistent_id);
 	rsp->VolatileFid = cpu_to_le64(fp->volatile_id);
 
-	inc_rfc1001_len(rsp, 24);
+	inc_rfc1001_len(work->response_buf, 24);
 
 	ksmbd_debug(OPLOCK,
 		    "sending oplock break v_id %llu p_id = %llu lock level = %d\n",
@@ -737,10 +737,10 @@ static void __smb2_lease_break_noti(stru
 		return;
 	}
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -753,7 +753,7 @@ static void __smb2_lease_break_noti(stru
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
@@ -769,7 +769,7 @@ static void __smb2_lease_break_noti(stru
 	rsp->AccessMaskHint = 0;
 	rsp->ShareMaskHint = 0;
 
-	inc_rfc1001_len(rsp, 44);
+	inc_rfc1001_len(work->response_buf, 44);
 
 	ksmbd_conn_write(work);
 	ksmbd_free_work_struct(work);
@@ -1399,7 +1399,7 @@ struct lease_ctx_info *parse_lease_state
 	if (!lreq)
 		return NULL;
 
-	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
+	data_offset = (char *)req + le32_to_cpu(req->CreateContextsOffset);
 	cc = (struct create_context *)data_offset;
 	do {
 		cc = (struct create_context *)((char *)cc + next);
@@ -1464,7 +1464,7 @@ struct create_context *smb2_find_context
 	 * CreateContextsOffset and CreateContextsLength are guaranteed to
 	 * be valid because of ksmbd_smb2_check_message().
 	 */
-	cc = (struct create_context *)((char *)req + 4 +
+	cc = (struct create_context *)((char *)req +
 				       le32_to_cpu(req->CreateContextsOffset));
 	remain_len = le32_to_cpu(req->CreateContextsLength);
 	do {
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -45,8 +45,8 @@ static void __wbuf(struct ksmbd_work *wo
 		*req = ksmbd_req_buf_next(work);
 		*rsp = ksmbd_resp_buf_next(work);
 	} else {
-		*req = work->request_buf;
-		*rsp = work->response_buf;
+		*req = smb2_get_msg(work->request_buf);
+		*rsp = smb2_get_msg(work->response_buf);
 	}
 }
 
@@ -94,7 +94,7 @@ struct channel *lookup_chann_list(struct
  */
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = work->request_buf;
+	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	int tree_id;
 
@@ -149,7 +149,7 @@ void smb2_set_err_rsp(struct ksmbd_work
 	if (work->next_smb2_rcv_hdr_off)
 		err_rsp = ksmbd_resp_buf_next(work);
 	else
-		err_rsp = work->response_buf;
+		err_rsp = smb2_get_msg(work->response_buf);
 
 	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
 		err_rsp->StructureSize = SMB2_ERROR_STRUCTURE_SIZE2_LE;
@@ -169,7 +169,7 @@ void smb2_set_err_rsp(struct ksmbd_work
  */
 bool is_smb2_neg_cmd(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -193,7 +193,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *
  */
 bool is_smb2_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->response_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->response_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -219,7 +219,7 @@ u16 get_smb2_cmd_val(struct ksmbd_work *
 	if (work->next_smb2_rcv_hdr_off)
 		rcv_hdr = ksmbd_req_buf_next(work);
 	else
-		rcv_hdr = work->request_buf;
+		rcv_hdr = smb2_get_msg(work->request_buf);
 	return le16_to_cpu(rcv_hdr->Command);
 }
 
@@ -235,7 +235,7 @@ void set_smb2_rsp_status(struct ksmbd_wo
 	if (work->next_smb2_rcv_hdr_off)
 		rsp_hdr = ksmbd_resp_buf_next(work);
 	else
-		rsp_hdr = work->response_buf;
+		rsp_hdr = smb2_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
 	smb2_set_err_rsp(work);
 }
@@ -256,13 +256,11 @@ int init_smb2_neg_rsp(struct ksmbd_work
 	if (conn->need_neg == false)
 		return -EINVAL;
 
-	rsp_hdr = work->response_buf;
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
-
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(2);
@@ -275,7 +273,7 @@ int init_smb2_neg_rsp(struct ksmbd_work
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 
 	WARN_ON(ksmbd_conn_good(work));
 
@@ -296,12 +294,12 @@ int init_smb2_neg_rsp(struct ksmbd_work
 
 	rsp->SecurityBufferOffset = cpu_to_le16(128);
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
-	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
-		sizeof(rsp->hdr.smb2_buf_length)) +
+	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
 		le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
-		sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
-		AUTH_GSS_LENGTH);
+	inc_rfc1001_len(work->response_buf,
+			sizeof(struct smb2_negotiate_rsp) -
+			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
+			AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
@@ -407,8 +405,8 @@ static void init_chained_smb2_rsp(struct
 	next_hdr_offset = le32_to_cpu(req->NextCommand);
 
 	new_len = ALIGN(len, 8);
-	inc_rfc1001_len(work->response_buf, ((sizeof(struct smb2_hdr) - 4)
-			+ new_len - len));
+	inc_rfc1001_len(work->response_buf,
+			sizeof(struct smb2_hdr) + new_len - len);
 	rsp->NextCommand = cpu_to_le32(new_len);
 
 	work->next_smb2_rcv_hdr_off += next_hdr_offset;
@@ -426,7 +424,7 @@ static void init_chained_smb2_rsp(struct
 		work->compound_fid = KSMBD_NO_FID;
 		work->compound_pfid = KSMBD_NO_FID;
 	}
-	memset((char *)rsp_hdr + 4, 0, sizeof(struct smb2_hdr) + 2);
+	memset((char *)rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -452,7 +450,7 @@ static void init_chained_smb2_rsp(struct
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -503,13 +501,13 @@ bool is_chained_smb2_message(struct ksmb
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = work->response_buf;
-	struct smb2_hdr *rcv_hdr = work->request_buf;
+	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
 	struct ksmbd_conn *conn = work->conn;
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -542,7 +540,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -554,7 +552,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_w
 	if (cmd == SMB2_QUERY_INFO_HE) {
 		struct smb2_query_info_req *req;
 
-		req = work->request_buf;
+		req = smb2_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		      req->FileInfoClass == FILE_ALL_INFORMATION)) ||
@@ -582,7 +580,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_w
  */
 int smb2_check_user_session(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = work->request_buf;
+	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
 	struct ksmbd_conn *conn = work->conn;
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
@@ -683,7 +681,7 @@ int setup_async_work(struct ksmbd_work *
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
 
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
@@ -715,7 +713,7 @@ void smb2_send_interim_resp(struct ksmbd
 {
 	struct smb2_hdr *rsp_hdr;
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	smb2_set_err_rsp(work);
 	rsp_hdr->Status = status;
 
@@ -843,11 +841,11 @@ static void build_posix_ctxt(struct smb2
 }
 
 static void assemble_neg_contexts(struct ksmbd_conn *conn,
-				  struct smb2_negotiate_rsp *rsp)
+				  struct smb2_negotiate_rsp *rsp,
+				  void *smb2_buf_len)
 {
-	/* +4 is to account for the RFC1001 len field */
 	char *pneg_ctxt = (char *)rsp +
-			le32_to_cpu(rsp->NegotiateContextOffset) + 4;
+			le32_to_cpu(rsp->NegotiateContextOffset);
 	int neg_ctxt_cnt = 1;
 	int ctxt_size;
 
@@ -856,7 +854,7 @@ static void assemble_neg_contexts(struct
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
 			   conn->preauth_info->Preauth_HashId);
 	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
-	inc_rfc1001_len(rsp, AUTH_GSS_PADDING);
+	inc_rfc1001_len(smb2_buf_len, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
 	/* Round to 8 byte boundary */
 	pneg_ctxt += round_up(sizeof(struct smb2_preauth_neg_context), 8);
@@ -910,7 +908,7 @@ static void assemble_neg_contexts(struct
 		ctxt_size += sizeof(struct smb2_signing_capabilities) + 2;
 	}
 
-	inc_rfc1001_len(rsp, ctxt_size);
+	inc_rfc1001_len(smb2_buf_len, ctxt_size);
 }
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
@@ -1012,14 +1010,14 @@ static void decode_sign_cap_ctxt(struct
 }
 
 static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
-				      struct smb2_negotiate_req *req)
+				      struct smb2_negotiate_req *req,
+				      int len_of_smb)
 {
 	/* +4 is to account for the RFC1001 len field */
-	struct smb2_neg_context *pctx = (struct smb2_neg_context *)((char *)req + 4);
+	struct smb2_neg_context *pctx = (struct smb2_neg_context *)req;
 	int i = 0, len_of_ctxts;
 	int offset = le32_to_cpu(req->NegotiateContextOffset);
 	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
-	int len_of_smb = be32_to_cpu(req->hdr.smb2_buf_length);
 	__le32 status = STATUS_INVALID_PARAMETER;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
@@ -1104,8 +1102,8 @@ static __le32 deassemble_neg_contexts(st
 int smb2_handle_negotiate(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_negotiate_req *req = work->request_buf;
-	struct smb2_negotiate_rsp *rsp = work->response_buf;
+	struct smb2_negotiate_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_negotiate_rsp *rsp = smb2_get_msg(work->response_buf);
 	int rc = 0;
 	unsigned int smb2_buf_len, smb2_neg_size;
 	__le32 status;
@@ -1119,7 +1117,7 @@ int smb2_handle_negotiate(struct ksmbd_w
 	}
 
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
-	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects) - 4;
+	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
@@ -1175,7 +1173,8 @@ int smb2_handle_negotiate(struct ksmbd_w
 			goto err_out;
 		}
 
-		status = deassemble_neg_contexts(conn, req);
+		status = deassemble_neg_contexts(conn, req,
+						 get_rfc1002_len(work->request_buf));
 		if (status != STATUS_SUCCESS) {
 			pr_err("deassemble_neg_contexts error(0x%x)\n",
 			       status);
@@ -1199,7 +1198,7 @@ int smb2_handle_negotiate(struct ksmbd_w
 						 conn->preauth_info->Preauth_HashValue);
 		rsp->NegotiateContextOffset =
 				cpu_to_le32(OFFSET_OF_NEG_CONTEXT);
-		assemble_neg_contexts(conn, rsp);
+		assemble_neg_contexts(conn, rsp, work->response_buf);
 		break;
 	case SMB302_PROT_ID:
 		init_smb3_02_server(conn);
@@ -1247,10 +1246,9 @@ int smb2_handle_negotiate(struct ksmbd_w
 
 	rsp->SecurityBufferOffset = cpu_to_le16(128);
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
-	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
-				  sizeof(rsp->hdr.smb2_buf_length)) +
-				   le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
+	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
+				  le16_to_cpu(rsp->SecurityBufferOffset));
+	inc_rfc1001_len(work->response_buf, sizeof(struct smb2_negotiate_rsp) -
 			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
 			 AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
@@ -1342,7 +1340,7 @@ static int ntlm_negotiate(struct ksmbd_w
 			  struct negotiate_message *negblob,
 			  size_t negblob_len)
 {
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct challenge_message *chgblob;
 	unsigned char *spnego_blob = NULL;
 	u16 spnego_blob_len;
@@ -1449,8 +1447,8 @@ static struct ksmbd_user *session_user(s
 
 static int ntlm_authenticate(struct ksmbd_work *work)
 {
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct channel *chann = NULL;
@@ -1473,7 +1471,7 @@ static int ntlm_authenticate(struct ksmb
 		memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
 		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 		kfree(spnego_blob);
-		inc_rfc1001_len(rsp, spnego_blob_len - 1);
+		inc_rfc1001_len(work->response_buf, spnego_blob_len - 1);
 	}
 
 	user = session_user(conn, req);
@@ -1590,8 +1588,8 @@ binding_session:
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
 static int krb5_authenticate(struct ksmbd_work *work)
 {
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	char *in_blob, *out_blob;
@@ -1606,8 +1604,7 @@ static int krb5_authenticate(struct ksmb
 	out_blob = (char *)&rsp->hdr.ProtocolId +
 		le16_to_cpu(rsp->SecurityBufferOffset);
 	out_len = work->response_sz -
-		offsetof(struct smb2_hdr, smb2_buf_length) -
-		le16_to_cpu(rsp->SecurityBufferOffset);
+		(le16_to_cpu(rsp->SecurityBufferOffset) + 4);
 
 	/* Check previous session */
 	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
@@ -1624,7 +1621,7 @@ static int krb5_authenticate(struct ksmb
 		return -EINVAL;
 	}
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
-	inc_rfc1001_len(rsp, out_len - 1);
+	inc_rfc1001_len(work->response_buf, out_len - 1);
 
 	if ((conn->sign || server_conf.enforced_signing) ||
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
@@ -1683,8 +1680,8 @@ static int krb5_authenticate(struct ksmb
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
@@ -1696,7 +1693,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 	rsp->SessionFlags = 0;
 	rsp->SecurityBufferOffset = cpu_to_le16(72);
 	rsp->SecurityBufferLength = 0;
-	inc_rfc1001_len(rsp, 9);
+	inc_rfc1001_len(work->response_buf, 9);
 
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
@@ -1777,7 +1774,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
-	if (negblob_off < (offsetof(struct smb2_sess_setup_req, Buffer) - 4) ||
+	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
 	    negblob_len < offsetof(struct negotiate_message, NegotiateFlags)) {
 		rc = -EINVAL;
 		goto out_err;
@@ -1819,7 +1816,8 @@ int smb2_sess_setup(struct ksmbd_work *w
 				 * Note: here total size -1 is done as an
 				 * adjustment for 0 size blob
 				 */
-				inc_rfc1001_len(rsp, le16_to_cpu(rsp->SecurityBufferLength) - 1);
+				inc_rfc1001_len(work->response_buf,
+						le16_to_cpu(rsp->SecurityBufferLength) - 1);
 
 			} else if (negblob->MessageType == NtLmAuthenticate) {
 				rc = ntlm_authenticate(work);
@@ -1915,8 +1913,8 @@ out_err:
 int smb2_tree_connect(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_tree_connect_req *req = work->request_buf;
-	struct smb2_tree_connect_rsp *rsp = work->response_buf;
+	struct smb2_tree_connect_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_tree_connect_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess = work->sess;
 	char *treename = NULL, *name = NULL;
 	struct ksmbd_tree_conn_status status;
@@ -1981,7 +1979,7 @@ out_err1:
 	rsp->Reserved = 0;
 	/* default manual caching */
 	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
-	inc_rfc1001_len(rsp, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 
 	if (!IS_ERR(treename))
 		kfree(treename);
@@ -2087,17 +2085,18 @@ static int smb2_create_open_flags(bool f
  */
 int smb2_tree_disconnect(struct ksmbd_work *work)
 {
-	struct smb2_tree_disconnect_rsp *rsp = work->response_buf;
+	struct smb2_tree_disconnect_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 
 	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
 	if (!tcon) {
-		struct smb2_tree_disconnect_req *req = work->request_buf;
+		struct smb2_tree_disconnect_req *req =
+			smb2_get_msg(work->request_buf);
 
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2120,11 +2119,11 @@ int smb2_tree_disconnect(struct ksmbd_wo
 int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_logoff_rsp *rsp = work->response_buf;
+	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess = work->sess;
 
 	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
@@ -2134,7 +2133,7 @@ int smb2_session_logoff(struct ksmbd_wor
 	ksmbd_conn_wait_idle(conn);
 
 	if (ksmbd_tree_conn_session_logoff(sess)) {
-		struct smb2_logoff_req *req = work->request_buf;
+		struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
 
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2161,8 +2160,8 @@ int smb2_session_logoff(struct ksmbd_wor
  */
 static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
-	struct smb2_create_rsp *rsp = work->response_buf;
-	struct smb2_create_req *req = work->request_buf;
+	struct smb2_create_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_create_req *req = smb2_get_msg(work->request_buf);
 	int id;
 	int err;
 	char *name;
@@ -2200,7 +2199,7 @@ static noinline int create_smb2_pipe(str
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
 
-	inc_rfc1001_len(rsp, 88); /* StructureSize - 1*/
+	inc_rfc1001_len(work->response_buf, 88); /* StructureSize - 1*/
 	kfree(name);
 	return 0;
 
@@ -2556,7 +2555,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
-	struct smb2_create_rsp *rsp, *rsp_org;
+	struct smb2_create_rsp *rsp;
 	struct path path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
@@ -2582,7 +2581,6 @@ int smb2_open(struct ksmbd_work *work)
 	umode_t posix_mode = 0;
 	__le32 daccess, maximal_access = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (req->hdr.NextCommand && !work->next_smb2_rcv_hdr_off &&
@@ -3240,7 +3238,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
-	inc_rfc1001_len(rsp_org, 88); /* StructureSize - 1*/
+	inc_rfc1001_len(work->response_buf, 88); /* StructureSize - 1*/
 
 	/* If lease is request send lease context response */
 	if (opinfo && opinfo->is_lease) {
@@ -3255,7 +3253,8 @@ int smb2_open(struct ksmbd_work *work)
 		create_lease_buf(rsp->Buffer, opinfo->o_lease);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_lease_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_lease_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_lease_size);
 		next_ptr = &lease_ccontext->Next;
 		next_off = conn->vals->create_lease_size;
 	}
@@ -3275,7 +3274,8 @@ int smb2_open(struct ksmbd_work *work)
 				le32_to_cpu(maximal_access));
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_mxac_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_mxac_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_mxac_size);
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &mxac_ccontext->Next;
@@ -3293,7 +3293,8 @@ int smb2_open(struct ksmbd_work *work)
 				stat.ino, tcon->id);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_disk_id_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_disk_id_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_disk_id_size);
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &disk_id_ccontext->Next;
@@ -3307,15 +3308,15 @@ int smb2_open(struct ksmbd_work *work)
 				fp);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_posix_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_posix_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_posix_size);
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 	}
 
 	if (contxt_cnt > 0) {
 		rsp->CreateContextsOffset =
-			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer)
-			- 4);
+			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer));
 	}
 
 err_out:
@@ -3918,7 +3919,7 @@ int smb2_query_dir(struct ksmbd_work *wo
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_query_directory_req *req;
-	struct smb2_query_directory_rsp *rsp, *rsp_org;
+	struct smb2_query_directory_rsp *rsp;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	struct ksmbd_file *dir_fp = NULL;
 	struct ksmbd_dir_info d_info;
@@ -3928,7 +3929,6 @@ int smb2_query_dir(struct ksmbd_work *wo
 	int buffer_sz;
 	struct smb2_query_dir_private query_dir_private = {NULL, };
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (ksmbd_override_fsids(work)) {
@@ -4052,7 +4052,7 @@ int smb2_query_dir(struct ksmbd_work *wo
 		rsp->OutputBufferOffset = cpu_to_le16(0);
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
-		inc_rfc1001_len(rsp_org, 9);
+		inc_rfc1001_len(work->response_buf, 9);
 	} else {
 no_buf_len:
 		((struct file_directory_info *)
@@ -4064,7 +4064,7 @@ no_buf_len:
 		rsp->StructureSize = cpu_to_le16(9);
 		rsp->OutputBufferOffset = cpu_to_le16(72);
 		rsp->OutputBufferLength = cpu_to_le32(d_info.data_count);
-		inc_rfc1001_len(rsp_org, 8 + d_info.data_count);
+		inc_rfc1001_len(work->response_buf, 8 + d_info.data_count);
 	}
 
 	kfree(srch_ptr);
@@ -4109,26 +4109,28 @@ err_out2:
  * Return:	0 on success, otherwise error
  */
 static int buffer_check_err(int reqOutputBufferLength,
-			    struct smb2_query_info_rsp *rsp, int infoclass_size)
+			    struct smb2_query_info_rsp *rsp,
+			    void *rsp_org, int infoclass_size)
 {
 	if (reqOutputBufferLength < le32_to_cpu(rsp->OutputBufferLength)) {
 		if (reqOutputBufferLength < infoclass_size) {
 			pr_err("Invalid Buffer Size Requested\n");
 			rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
-			rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4);
+			*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr));
 			return -EINVAL;
 		}
 
 		ksmbd_debug(SMB, "Buffer Overflow\n");
 		rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
-		rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4 +
+		*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr) +
 				reqOutputBufferLength);
 		rsp->OutputBufferLength = cpu_to_le32(reqOutputBufferLength);
 	}
 	return 0;
 }
 
-static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
+static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp,
+				   void *rsp_org)
 {
 	struct smb2_file_standard_info *sinfo;
 
@@ -4141,10 +4143,11 @@ static void get_standard_info_pipe(struc
 	sinfo->Directory = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_file_standard_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_standard_info));
 }
 
-static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num)
+static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num,
+				   void *rsp_org)
 {
 	struct smb2_file_internal_info *file_info;
 
@@ -4154,12 +4157,13 @@ static void get_internal_info_pipe(struc
 	file_info->IndexNumber = cpu_to_le64(num | (1ULL << 63));
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_file_internal_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
 }
 
 static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 				   struct smb2_query_info_req *req,
-				   struct smb2_query_info_rsp *rsp)
+				   struct smb2_query_info_rsp *rsp,
+				   void *rsp_org)
 {
 	u64 id;
 	int rc;
@@ -4177,14 +4181,16 @@ static int smb2_get_info_file_pipe(struc
 
 	switch (req->FileInfoClass) {
 	case FILE_STANDARD_INFORMATION:
-		get_standard_info_pipe(rsp);
+		get_standard_info_pipe(rsp, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, FILE_STANDARD_INFORMATION_SIZE);
+				      rsp, rsp_org,
+				      FILE_STANDARD_INFORMATION_SIZE);
 		break;
 	case FILE_INTERNAL_INFORMATION:
-		get_internal_info_pipe(rsp, id);
+		get_internal_info_pipe(rsp, id, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, FILE_INTERNAL_INFORMATION_SIZE);
+				      rsp, rsp_org,
+				      FILE_INTERNAL_INFORMATION_SIZE);
 		break;
 	default:
 		ksmbd_debug(SMB, "smb2_info_file_pipe for %u not supported\n",
@@ -4785,7 +4791,7 @@ static int find_file_posix_info(struct s
 
 static int smb2_get_info_file(struct ksmbd_work *work,
 			      struct smb2_query_info_req *req,
-			      struct smb2_query_info_rsp *rsp, void *rsp_org)
+			      struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
 	int fileinfoclass = 0;
@@ -4796,7 +4802,8 @@ static int smb2_get_info_file(struct ksm
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
 		/* smb2 info file called for pipe */
-		return smb2_get_info_file_pipe(work->sess, req, rsp);
+		return smb2_get_info_file_pipe(work->sess, req, rsp,
+					       work->response_buf);
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
@@ -4821,77 +4828,77 @@ static int smb2_get_info_file(struct ksm
 
 	switch (fileinfoclass) {
 	case FILE_ACCESS_INFORMATION:
-		get_file_access_info(rsp, fp, rsp_org);
+		get_file_access_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ACCESS_INFORMATION_SIZE;
 		break;
 
 	case FILE_BASIC_INFORMATION:
-		rc = get_file_basic_info(rsp, fp, rsp_org);
+		rc = get_file_basic_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_BASIC_INFORMATION_SIZE;
 		break;
 
 	case FILE_STANDARD_INFORMATION:
-		get_file_standard_info(rsp, fp, rsp_org);
+		get_file_standard_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_STANDARD_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALIGNMENT_INFORMATION:
-		get_file_alignment_info(rsp, rsp_org);
+		get_file_alignment_info(rsp, work->response_buf);
 		file_infoclass_size = FILE_ALIGNMENT_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALL_INFORMATION:
-		rc = get_file_all_info(work, rsp, fp, rsp_org);
+		rc = get_file_all_info(work, rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ALL_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALTERNATE_NAME_INFORMATION:
-		get_file_alternate_info(work, rsp, fp, rsp_org);
+		get_file_alternate_info(work, rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
 		break;
 
 	case FILE_STREAM_INFORMATION:
-		get_file_stream_info(work, rsp, fp, rsp_org);
+		get_file_stream_info(work, rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_STREAM_INFORMATION_SIZE;
 		break;
 
 	case FILE_INTERNAL_INFORMATION:
-		get_file_internal_info(rsp, fp, rsp_org);
+		get_file_internal_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_INTERNAL_INFORMATION_SIZE;
 		break;
 
 	case FILE_NETWORK_OPEN_INFORMATION:
-		rc = get_file_network_open_info(rsp, fp, rsp_org);
+		rc = get_file_network_open_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_NETWORK_OPEN_INFORMATION_SIZE;
 		break;
 
 	case FILE_EA_INFORMATION:
-		get_file_ea_info(rsp, rsp_org);
+		get_file_ea_info(rsp, work->response_buf);
 		file_infoclass_size = FILE_EA_INFORMATION_SIZE;
 		break;
 
 	case FILE_FULL_EA_INFORMATION:
-		rc = smb2_get_ea(work, fp, req, rsp, rsp_org);
+		rc = smb2_get_ea(work, fp, req, rsp, work->response_buf);
 		file_infoclass_size = FILE_FULL_EA_INFORMATION_SIZE;
 		break;
 
 	case FILE_POSITION_INFORMATION:
-		get_file_position_info(rsp, fp, rsp_org);
+		get_file_position_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_POSITION_INFORMATION_SIZE;
 		break;
 
 	case FILE_MODE_INFORMATION:
-		get_file_mode_info(rsp, fp, rsp_org);
+		get_file_mode_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_MODE_INFORMATION_SIZE;
 		break;
 
 	case FILE_COMPRESSION_INFORMATION:
-		get_file_compression_info(rsp, fp, rsp_org);
+		get_file_compression_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_COMPRESSION_INFORMATION_SIZE;
 		break;
 
 	case FILE_ATTRIBUTE_TAG_INFORMATION:
-		rc = get_file_attribute_tag_info(rsp, fp, rsp_org);
+		rc = get_file_attribute_tag_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ATTRIBUTE_TAG_INFORMATION_SIZE;
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
@@ -4899,7 +4906,7 @@ static int smb2_get_info_file(struct ksm
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			rc = find_file_posix_info(rsp, fp, rsp_org);
+			rc = find_file_posix_info(rsp, fp, work->response_buf);
 			file_infoclass_size = sizeof(struct smb311_posix_qinfo);
 		}
 		break;
@@ -4910,7 +4917,7 @@ static int smb2_get_info_file(struct ksm
 	}
 	if (!rc)
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp,
+				      rsp, work->response_buf,
 				      file_infoclass_size);
 	ksmbd_fd_put(work, fp);
 	return rc;
@@ -4918,7 +4925,7 @@ static int smb2_get_info_file(struct ksm
 
 static int smb2_get_info_filesystem(struct ksmbd_work *work,
 				    struct smb2_query_info_req *req,
-				    struct smb2_query_info_rsp *rsp, void *rsp_org)
+				    struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_conn *conn = work->conn;
@@ -4957,7 +4964,7 @@ static int smb2_get_info_filesystem(stru
 		info->DeviceType = cpu_to_le32(stfs.f_type);
 		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
 		rsp->OutputBufferLength = cpu_to_le32(8);
-		inc_rfc1001_len(rsp_org, 8);
+		inc_rfc1001_len(work->response_buf, 8);
 		fs_infoclass_size = FS_DEVICE_INFORMATION_SIZE;
 		break;
 	}
@@ -4987,7 +4994,7 @@ static int smb2_get_info_filesystem(stru
 		info->FileSystemNameLen = cpu_to_le32(len);
 		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(rsp_org, sz);
+		inc_rfc1001_len(work->response_buf, sz);
 		fs_infoclass_size = FS_ATTRIBUTE_INFORMATION_SIZE;
 		break;
 	}
@@ -5015,7 +5022,7 @@ static int smb2_get_info_filesystem(stru
 		info->Reserved = 0;
 		sz = sizeof(struct filesystem_vol_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(rsp_org, sz);
+		inc_rfc1001_len(work->response_buf, sz);
 		fs_infoclass_size = FS_VOLUME_INFORMATION_SIZE;
 		break;
 	}
@@ -5029,7 +5036,7 @@ static int smb2_get_info_filesystem(stru
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(24);
-		inc_rfc1001_len(rsp_org, 24);
+		inc_rfc1001_len(work->response_buf, 24);
 		fs_infoclass_size = FS_SIZE_INFORMATION_SIZE;
 		break;
 	}
@@ -5046,7 +5053,7 @@ static int smb2_get_info_filesystem(stru
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(32);
-		inc_rfc1001_len(rsp_org, 32);
+		inc_rfc1001_len(work->response_buf, 32);
 		fs_infoclass_size = FS_FULL_SIZE_INFORMATION_SIZE;
 		break;
 	}
@@ -5067,7 +5074,7 @@ static int smb2_get_info_filesystem(stru
 		info->extended_info.rel_date = 0;
 		memcpy(info->extended_info.version_string, "1.1.0", strlen("1.1.0"));
 		rsp->OutputBufferLength = cpu_to_le32(64);
-		inc_rfc1001_len(rsp_org, 64);
+		inc_rfc1001_len(work->response_buf, 64);
 		fs_infoclass_size = FS_OBJECT_ID_INFORMATION_SIZE;
 		break;
 	}
@@ -5090,7 +5097,7 @@ static int smb2_get_info_filesystem(stru
 		info->ByteOffsetForSectorAlignment = 0;
 		info->ByteOffsetForPartitionAlignment = 0;
 		rsp->OutputBufferLength = cpu_to_le32(28);
-		inc_rfc1001_len(rsp_org, 28);
+		inc_rfc1001_len(work->response_buf, 28);
 		fs_infoclass_size = FS_SECTOR_SIZE_INFORMATION_SIZE;
 		break;
 	}
@@ -5112,7 +5119,7 @@ static int smb2_get_info_filesystem(stru
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
-		inc_rfc1001_len(rsp_org, 48);
+		inc_rfc1001_len(work->response_buf, 48);
 		fs_infoclass_size = FS_CONTROL_INFORMATION_SIZE;
 		break;
 	}
@@ -5133,7 +5140,7 @@ static int smb2_get_info_filesystem(stru
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
 			rsp->OutputBufferLength = cpu_to_le32(56);
-			inc_rfc1001_len(rsp_org, 56);
+			inc_rfc1001_len(work->response_buf, 56);
 			fs_infoclass_size = FS_POSIX_INFORMATION_SIZE;
 		}
 		break;
@@ -5143,7 +5150,7 @@ static int smb2_get_info_filesystem(stru
 		return -EOPNOTSUPP;
 	}
 	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-			      rsp,
+			      rsp, work->response_buf,
 			      fs_infoclass_size);
 	path_put(&path);
 	return rc;
@@ -5151,7 +5158,7 @@ static int smb2_get_info_filesystem(stru
 
 static int smb2_get_info_sec(struct ksmbd_work *work,
 			     struct smb2_query_info_req *req,
-			     struct smb2_query_info_rsp *rsp, void *rsp_org)
+			     struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
 	struct user_namespace *user_ns;
@@ -5178,7 +5185,7 @@ static int smb2_get_info_sec(struct ksmb
 
 		secdesclen = sizeof(struct smb_ntsd);
 		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-		inc_rfc1001_len(rsp_org, secdesclen);
+		inc_rfc1001_len(work->response_buf, secdesclen);
 
 		return 0;
 	}
@@ -5223,7 +5230,7 @@ static int smb2_get_info_sec(struct ksmb
 		return rc;
 
 	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-	inc_rfc1001_len(rsp_org, secdesclen);
+	inc_rfc1001_len(work->response_buf, secdesclen);
 	return 0;
 }
 
@@ -5236,10 +5243,9 @@ static int smb2_get_info_sec(struct ksmb
 int smb2_query_info(struct ksmbd_work *work)
 {
 	struct smb2_query_info_req *req;
-	struct smb2_query_info_rsp *rsp, *rsp_org;
+	struct smb2_query_info_rsp *rsp;
 	int rc = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "GOT query info request\n");
@@ -5247,15 +5253,15 @@ int smb2_query_info(struct ksmbd_work *w
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
-		rc = smb2_get_info_file(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_file(work, req, rsp);
 		break;
 	case SMB2_O_INFO_FILESYSTEM:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILESYSTEM\n");
-		rc = smb2_get_info_filesystem(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_filesystem(work, req, rsp);
 		break;
 	case SMB2_O_INFO_SECURITY:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
-		rc = smb2_get_info_sec(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_sec(work, req, rsp);
 		break;
 	default:
 		ksmbd_debug(SMB, "InfoType %d not supported yet\n",
@@ -5280,7 +5286,7 @@ int smb2_query_info(struct ksmbd_work *w
 	}
 	rsp->StructureSize = cpu_to_le16(9);
 	rsp->OutputBufferOffset = cpu_to_le16(72);
-	inc_rfc1001_len(rsp_org, 8);
+	inc_rfc1001_len(work->response_buf, 8);
 	return 0;
 }
 
@@ -5293,8 +5299,8 @@ int smb2_query_info(struct ksmbd_work *w
 static noinline int smb2_close_pipe(struct ksmbd_work *work)
 {
 	u64 id;
-	struct smb2_close_req *req = work->request_buf;
-	struct smb2_close_rsp *rsp = work->response_buf;
+	struct smb2_close_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_close_rsp *rsp = smb2_get_msg(work->response_buf);
 
 	id = le64_to_cpu(req->VolatileFileId);
 	ksmbd_session_rpc_close(work->sess, id);
@@ -5309,7 +5315,7 @@ static noinline int smb2_close_pipe(stru
 	rsp->AllocationSize = 0;
 	rsp->EndOfFile = 0;
 	rsp->Attributes = 0;
-	inc_rfc1001_len(rsp, 60);
+	inc_rfc1001_len(work->response_buf, 60);
 	return 0;
 }
 
@@ -5325,14 +5331,12 @@ int smb2_close(struct ksmbd_work *work)
 	u64 sess_id;
 	struct smb2_close_req *req;
 	struct smb2_close_rsp *rsp;
-	struct smb2_close_rsp *rsp_org;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_file *fp;
 	struct inode *inode;
 	u64 time;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf,
@@ -5422,7 +5426,7 @@ out:
 			rsp->hdr.Status = STATUS_FILE_CLOSED;
 		smb2_set_err_rsp(work);
 	} else {
-		inc_rfc1001_len(rsp_org, 60);
+		inc_rfc1001_len(work->response_buf, 60);
 	}
 
 	return 0;
@@ -5436,11 +5440,11 @@ out:
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = work->response_buf;
+	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 	return 0;
 }
 
@@ -6061,14 +6065,13 @@ static int smb2_set_info_sec(struct ksmb
 int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
-	struct smb2_set_info_rsp *rsp, *rsp_org;
+	struct smb2_set_info_rsp *rsp;
 	struct ksmbd_file *fp;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
 	ksmbd_debug(SMB, "Received set info request\n");
 
-	rsp_org = work->response_buf;
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
@@ -6079,8 +6082,8 @@ int smb2_set_info(struct ksmbd_work *wor
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = work->request_buf;
-		rsp = work->response_buf;
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
@@ -6120,7 +6123,7 @@ int smb2_set_info(struct ksmbd_work *wor
 		goto err_out;
 
 	rsp->StructureSize = cpu_to_le16(2);
-	inc_rfc1001_len(rsp_org, 2);
+	inc_rfc1001_len(work->response_buf, 2);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6160,12 +6163,12 @@ static noinline int smb2_read_pipe(struc
 	int nbytes = 0, err;
 	u64 id;
 	struct ksmbd_rpc_command *rpc_resp;
-	struct smb2_read_req *req = work->request_buf;
-	struct smb2_read_rsp *rsp = work->response_buf;
+	struct smb2_read_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_read_rsp *rsp = smb2_get_msg(work->response_buf);
 
 	id = le64_to_cpu(req->VolatileFileId);
 
-	inc_rfc1001_len(rsp, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 	rpc_resp = ksmbd_rpc_read(work->sess, id);
 	if (rpc_resp) {
 		if (rpc_resp->flags != KSMBD_RPC_OK) {
@@ -6184,7 +6187,7 @@ static noinline int smb2_read_pipe(struc
 		       rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
-		work->resp_hdr_sz = get_rfc1002_len(rsp) + 4;
+		work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
 		work->aux_payload_sz = nbytes;
 		kvfree(rpc_resp);
 	}
@@ -6195,7 +6198,7 @@ static noinline int smb2_read_pipe(struc
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp, nbytes);
+	inc_rfc1001_len(work->response_buf, nbytes);
 	return 0;
 
 out:
@@ -6245,14 +6248,13 @@ int smb2_read(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_read_req *req;
-	struct smb2_read_rsp *rsp, *rsp_org;
+	struct smb2_read_rsp *rsp;
 	struct ksmbd_file *fp = NULL;
 	loff_t offset;
 	size_t length, mincount;
 	ssize_t nbytes = 0, remain_bytes = 0;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 	if (work->next_smb2_rcv_hdr_off) {
 		work->send_no_response = 1;
@@ -6339,10 +6341,10 @@ int smb2_read(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = cpu_to_le32(remain_bytes);
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp_org, 16);
-	work->resp_hdr_sz = get_rfc1002_len(rsp_org) + 4;
+	inc_rfc1001_len(work->response_buf, 16);
+	work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
 	work->aux_payload_sz = nbytes;
-	inc_rfc1001_len(rsp_org, nbytes);
+	inc_rfc1001_len(work->response_buf, nbytes);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6377,8 +6379,8 @@ out:
  */
 static noinline int smb2_write_pipe(struct ksmbd_work *work)
 {
-	struct smb2_write_req *req = work->request_buf;
-	struct smb2_write_rsp *rsp = work->response_buf;
+	struct smb2_write_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_write_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_rpc_command *rpc_resp;
 	u64 id = 0;
 	int err = 0, ret = 0;
@@ -6389,13 +6391,14 @@ static noinline int smb2_write_pipe(stru
 	id = le64_to_cpu(req->VolatileFileId);
 
 	if (le16_to_cpu(req->DataOffset) ==
-	    (offsetof(struct smb2_write_req, Buffer) - 4)) {
+	    offsetof(struct smb2_write_req, Buffer)) {
 		data_buf = (char *)&req->Buffer[0];
 	} else {
-		if ((u64)le16_to_cpu(req->DataOffset) + length > get_rfc1002_len(req)) {
+		if ((u64)le16_to_cpu(req->DataOffset) + length >
+		    get_rfc1002_len(work->request_buf)) {
 			pr_err("invalid write data offset %u, smb_len %u\n",
 			       le16_to_cpu(req->DataOffset),
-			       get_rfc1002_len(req));
+			       get_rfc1002_len(work->request_buf));
 			err = -EINVAL;
 			goto out;
 		}
@@ -6427,7 +6430,7 @@ static noinline int smb2_write_pipe(stru
 	rsp->DataLength = cpu_to_le32(length);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 	return 0;
 out:
 	if (err) {
@@ -6495,7 +6498,7 @@ static ssize_t smb2_write_rdma_channel(s
 int smb2_write(struct ksmbd_work *work)
 {
 	struct smb2_write_req *req;
-	struct smb2_write_rsp *rsp, *rsp_org;
+	struct smb2_write_rsp *rsp;
 	struct ksmbd_file *fp = NULL;
 	loff_t offset;
 	size_t length;
@@ -6504,7 +6507,6 @@ int smb2_write(struct ksmbd_work *work)
 	bool writethrough = false;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_PIPE)) {
@@ -6547,7 +6549,7 @@ int smb2_write(struct ksmbd_work *work)
 	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
 	    req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
 		if (le16_to_cpu(req->DataOffset) ==
-		    (offsetof(struct smb2_write_req, Buffer) - 4)) {
+		    offsetof(struct smb2_write_req, Buffer)) {
 			data_buf = (char *)&req->Buffer[0];
 		} else {
 			if (le16_to_cpu(req->DataOffset) <
@@ -6589,7 +6591,7 @@ int smb2_write(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp_org, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6623,10 +6625,9 @@ out:
 int smb2_flush(struct ksmbd_work *work)
 {
 	struct smb2_flush_req *req;
-	struct smb2_flush_rsp *rsp, *rsp_org;
+	struct smb2_flush_rsp *rsp;
 	int err;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n",
@@ -6640,7 +6641,7 @@ int smb2_flush(struct ksmbd_work *work)
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp_org, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 	return 0;
 
 out:
@@ -6661,7 +6662,7 @@ out:
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
 	struct ksmbd_work *cancel_work = NULL;
 	int canceled = 0;
@@ -6676,7 +6677,7 @@ int smb2_cancel(struct ksmbd_work *work)
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(cancel_work, command_list,
 				    async_request_entry) {
-			chdr = cancel_work->request_buf;
+			chdr = smb2_get_msg(cancel_work->request_buf);
 
 			if (cancel_work->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
@@ -6695,7 +6696,7 @@ int smb2_cancel(struct ksmbd_work *work)
 
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(cancel_work, command_list, request_entry) {
-			chdr = cancel_work->request_buf;
+			chdr = smb2_get_msg(cancel_work->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
 			    cancel_work == work)
@@ -6830,8 +6831,8 @@ static inline bool lock_defer_pending(st
  */
 int smb2_lock(struct ksmbd_work *work)
 {
-	struct smb2_lock_req *req = work->request_buf;
-	struct smb2_lock_rsp *rsp = work->response_buf;
+	struct smb2_lock_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_lock_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct smb2_lock_element *lock_ele;
 	struct ksmbd_file *fp = NULL;
 	struct file_lock *flock = NULL;
@@ -7139,7 +7140,7 @@ skip:
 	ksmbd_debug(SMB, "successful in taking lock\n");
 	rsp->hdr.Status = STATUS_SUCCESS;
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -7617,13 +7618,12 @@ static int fsctl_request_resume_key(stru
 int smb2_ioctl(struct ksmbd_work *work)
 {
 	struct smb2_ioctl_req *req;
-	struct smb2_ioctl_rsp *rsp, *rsp_org;
+	struct smb2_ioctl_rsp *rsp;
 	unsigned int cnt_code, nbytes = 0, out_buf_len, in_buf_len;
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
 
-	rsp_org = work->response_buf;
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
@@ -7633,8 +7633,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			id = work->compound_fid;
 		}
 	} else {
-		req = work->request_buf;
-		rsp = work->response_buf;
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
@@ -7936,7 +7936,7 @@ dup_ext_out:
 	rsp->Reserved = cpu_to_le16(0);
 	rsp->Flags = cpu_to_le32(0);
 	rsp->Reserved2 = cpu_to_le32(0);
-	inc_rfc1001_len(rsp_org, 48 + nbytes);
+	inc_rfc1001_len(work->response_buf, 48 + nbytes);
 
 	return 0;
 
@@ -7963,8 +7963,8 @@ out:
  */
 static void smb20_oplock_break_ack(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = work->request_buf;
-	struct smb2_oplock_break *rsp = work->response_buf;
+	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
+	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_file *fp;
 	struct oplock_info *opinfo = NULL;
 	__le32 err = 0;
@@ -8071,7 +8071,7 @@ static void smb20_oplock_break_ack(struc
 	rsp->Reserved2 = 0;
 	rsp->VolatileFid = cpu_to_le64(volatile_id);
 	rsp->PersistentFid = cpu_to_le64(persistent_id);
-	inc_rfc1001_len(rsp, 24);
+	inc_rfc1001_len(work->response_buf, 24);
 	return;
 
 err_out:
@@ -8107,8 +8107,8 @@ static int check_lease_state(struct leas
 static void smb21_lease_break_ack(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_lease_ack *req = work->request_buf;
-	struct smb2_lease_ack *rsp = work->response_buf;
+	struct smb2_lease_ack *req = smb2_get_msg(work->request_buf);
+	struct smb2_lease_ack *rsp = smb2_get_msg(work->response_buf);
 	struct oplock_info *opinfo;
 	__le32 err = 0;
 	int ret = 0;
@@ -8220,7 +8220,7 @@ static void smb21_lease_break_ack(struct
 	memcpy(rsp->LeaseKey, req->LeaseKey, 16);
 	rsp->LeaseState = lease_state;
 	rsp->LeaseDuration = 0;
-	inc_rfc1001_len(rsp, 36);
+	inc_rfc1001_len(work->response_buf, 36);
 	return;
 
 err_out:
@@ -8241,8 +8241,8 @@ err_out:
  */
 int smb2_oplock_break(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = work->request_buf;
-	struct smb2_oplock_break *rsp = work->response_buf;
+	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
+	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
 
 	switch (le16_to_cpu(req->StructureSize)) {
 	case OP_BREAK_STRUCT_SIZE_20:
@@ -8294,7 +8294,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = work->request_buf;
+	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -8313,22 +8313,22 @@ bool smb2_is_sign_req(struct ksmbd_work
  */
 int smb2_check_sign_req(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	char signature_req[SMB2_SIGNATURE_SIZE];
 	char signature[SMB2_HMACSHA256_SIZE];
 	struct kvec iov[1];
 	size_t len;
 
-	hdr_org = hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
 	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
-		len = be32_to_cpu(hdr_org->smb2_buf_length);
+		len = get_rfc1002_len(work->request_buf);
 	else if (hdr->NextCommand)
 		len = le32_to_cpu(hdr->NextCommand);
 	else
-		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
 	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
@@ -8356,25 +8356,26 @@ int smb2_check_sign_req(struct ksmbd_wor
  */
 void smb2_set_sign_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	struct smb2_hdr *req_hdr;
 	char signature[SMB2_HMACSHA256_SIZE];
 	struct kvec iov[2];
 	size_t len;
 	int n_vec = 1;
 
-	hdr_org = hdr = work->response_buf;
+	hdr = smb2_get_msg(work->response_buf);
 	if (work->next_smb2_rsp_hdr_off)
 		hdr = ksmbd_resp_buf_next(work);
 
 	req_hdr = ksmbd_req_buf_next(work);
 
 	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(hdr_org);
+		len = get_rfc1002_len(work->response_buf);
 		if (req_hdr->NextCommand)
 			len = ALIGN(len, 8);
 	} else {
-		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = get_rfc1002_len(work->response_buf) -
+			work->next_smb2_rsp_hdr_off;
 		len = ALIGN(len, 8);
 	}
 
@@ -8410,23 +8411,23 @@ int smb3_check_sign_req(struct ksmbd_wor
 {
 	struct ksmbd_conn *conn = work->conn;
 	char *signing_key;
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	struct channel *chann;
 	char signature_req[SMB2_SIGNATURE_SIZE];
 	char signature[SMB2_CMACAES_SIZE];
 	struct kvec iov[1];
 	size_t len;
 
-	hdr_org = hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
 	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
-		len = be32_to_cpu(hdr_org->smb2_buf_length);
+		len = get_rfc1002_len(work->request_buf);
 	else if (hdr->NextCommand)
 		len = le32_to_cpu(hdr->NextCommand);
 	else
-		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
@@ -8471,8 +8472,7 @@ int smb3_check_sign_req(struct ksmbd_wor
 void smb3_set_sign_rsp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *req_hdr;
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *req_hdr, *hdr;
 	struct channel *chann;
 	char signature[SMB2_CMACAES_SIZE];
 	struct kvec iov[2];
@@ -8480,18 +8480,19 @@ void smb3_set_sign_rsp(struct ksmbd_work
 	size_t len;
 	char *signing_key;
 
-	hdr_org = hdr = work->response_buf;
+	hdr = smb2_get_msg(work->response_buf);
 	if (work->next_smb2_rsp_hdr_off)
 		hdr = ksmbd_resp_buf_next(work);
 
 	req_hdr = ksmbd_req_buf_next(work);
 
 	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(hdr_org);
+		len = get_rfc1002_len(work->response_buf);
 		if (req_hdr->NextCommand)
 			len = ALIGN(len, 8);
 	} else {
-		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = get_rfc1002_len(work->response_buf) -
+			work->next_smb2_rsp_hdr_off;
 		len = ALIGN(len, 8);
 	}
 
@@ -8548,7 +8549,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_
 
 	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE_HE &&
 	    conn->preauth_info)
-		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 conn->preauth_info->Preauth_HashValue);
 
 	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE && sess) {
@@ -8566,7 +8567,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_
 			if (!hash_value)
 				return;
 		}
-		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 hash_value);
 	}
 }
@@ -8648,7 +8649,6 @@ int smb3_decrypt_req(struct ksmbd_work *
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess;
 	char *buf = work->request_buf;
-	struct smb2_hdr *hdr;
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
 	int buf_data_size = pdu_length + 4 -
@@ -8684,8 +8684,7 @@ int smb3_decrypt_req(struct ksmbd_work *
 		return rc;
 
 	memmove(buf + 4, iov[1].iov_base, buf_data_size);
-	hdr = (struct smb2_hdr *)buf;
-	hdr->smb2_buf_length = cpu_to_be32(buf_data_size);
+	*(__be32 *)buf = cpu_to_be32(buf_data_size);
 
 	return rc;
 }
@@ -8694,7 +8693,7 @@ bool smb3_11_final_sess_setup_resp(struc
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
-	struct smb2_hdr *rsp = work->response_buf;
+	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -131,11 +131,6 @@
 	cpu_to_le16(__SMB2_HEADER_STRUCTURE_SIZE)
 
 struct smb2_hdr {
-	__be32 smb2_buf_length;	/* big endian on wire */
-				/*
-				 * length is only two or three bytes - with
-				 * one or two byte type preceding it that MBZ
-				 */
 	__le32 ProtocolId;	/* 0xFE 'S' 'M' 'B' */
 	__le16 StructureSize;	/* 64 */
 	__le16 CreditCharge;	/* MBZ */
@@ -254,14 +249,14 @@ struct preauth_integrity_info {
 	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
 };
 
-/* offset is sizeof smb2_negotiate_rsp - 4 but rounded up to 8 bytes. */
+/* offset is sizeof smb2_negotiate_rsp but rounded up to 8 bytes. */
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
-/* sizeof(struct smb2_negotiate_rsp) - 4 =
+/* sizeof(struct smb2_negotiate_rsp) =
  * header(64) + response(64) + GSS_LENGTH(96) + GSS_PADDING(0)
  */
 #define OFFSET_OF_NEG_CONTEXT	0xe0
 #else
-/* sizeof(struct smb2_negotiate_rsp) - 4 =
+/* sizeof(struct smb2_negotiate_rsp) =
  * header(64) + response(64) + GSS_LENGTH(74) + GSS_PADDING(6)
  */
 #define OFFSET_OF_NEG_CONTEXT	0xd0
@@ -1707,4 +1702,13 @@ int smb2_ioctl(struct ksmbd_work *work);
 int smb2_oplock_break(struct ksmbd_work *work);
 int smb2_notify(struct ksmbd_work *ksmbd_work);
 
+/*
+ * Get the body of the smb2 message excluding the 4 byte rfc1002 headers
+ * from request/response buffer.
+ */
+static inline void *smb2_get_msg(void *buf)
+{
+	return buf + 4;
+}
+
 #endif	/* _SMB2PDU_H */
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -243,14 +243,14 @@ int ksmbd_lookup_dialect_by_id(__le16 *c
 static int ksmbd_negotiate_smb_dialect(void *buf)
 {
 	int smb_buf_length = get_rfc1002_len(buf);
-	__le32 proto = ((struct smb2_hdr *)buf)->ProtocolId;
+	__le32 proto = ((struct smb2_hdr *)smb2_get_msg(buf))->ProtocolId;
 
 	if (proto == SMB2_PROTO_NUMBER) {
 		struct smb2_negotiate_req *req;
 		int smb2_neg_size =
-			offsetof(struct smb2_negotiate_req, Dialects) - 4;
+			offsetof(struct smb2_negotiate_req, Dialects);
 
-		req = (struct smb2_negotiate_req *)buf;
+		req = (struct smb2_negotiate_req *)smb2_get_msg(buf);
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
@@ -469,11 +469,12 @@ int ksmbd_smb_negotiate_common(struct ks
 	struct ksmbd_conn *conn = work->conn;
 	int ret;
 
-	conn->dialect = ksmbd_negotiate_smb_dialect(work->request_buf);
+	conn->dialect =
+		ksmbd_negotiate_smb_dialect(work->request_buf);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 
 	if (command == SMB2_NEGOTIATE_HE) {
-		struct smb2_hdr *smb2_hdr = work->request_buf;
+		struct smb2_hdr *smb2_hdr = smb2_get_msg(work->request_buf);
 
 		if (smb2_hdr->ProtocolId != SMB2_PROTO_NUMBER) {
 			ksmbd_debug(SMB, "Downgrade to SMB1 negotiation\n");
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -464,12 +464,6 @@ struct smb_version_cmds {
 	int (*proc)(struct ksmbd_work *swork);
 };
 
-static inline size_t
-smb2_hdr_size_no_buflen(struct smb_version_values *vals)
-{
-	return vals->header_size - 4;
-}
-
 int ksmbd_min_protocol(void);
 int ksmbd_max_protocol(void);
 
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -490,7 +490,7 @@ static int smb_direct_check_recvmsg(stru
 		struct smb_direct_data_transfer *req =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
 		struct smb2_hdr *hdr = (struct smb2_hdr *)(recvmsg->packet
-				+ le32_to_cpu(req->data_offset) - 4);
+				+ le32_to_cpu(req->data_offset));
 		ksmbd_debug(RDMA,
 			    "CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemainingDataLength: %u, SMB: %x, Command: %u\n",
 			    le16_to_cpu(req->credits_granted),



