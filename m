Return-Path: <stable+bounces-7740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97E81760D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78028281868
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31474090;
	Mon, 18 Dec 2023 15:41:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA27348D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b62c6317dso555826a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914077; x=1703518877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziBEe43LL+v+wyaYM03706ENJhk0IvDHm17QcoIpevU=;
        b=MO/5vFE/UnH45mW5myyP/TXKuRmnwrMcrvnHCKQEhVh0Wut/w3KlXYThgOcsr3UI2n
         dG9haw/oCLP2zu/06Qum5FChhn2F3MCfUi4WANbT95P5NsRi4gkLtKZnzIbmMU3BQuAS
         6G3RYjiza+nnogqEL1NKOkTaTPSeCaOaM5jBfWJxDARRb2dO8B1s8tEkcuPRiq94qjth
         klHbiAdpKnMICEjrcizALp7pP9tQ4JMd5LveVMUB2mMLLOsVGJrFEhgCrLrTpaxeFWOM
         60uEqrdfd+hbJuua+8csRalfpe2QtsZRhsmexyLn/Kj2CZ0Ts+1i8YgXf7Df2tXeHFA6
         vF3w==
X-Gm-Message-State: AOJu0YyA/X8trIDXncxP1n2GpKI67WIOkMDJVfEW6u2fB3lmJXkCd3n9
	1xwmAEaq6nzsb+2oNuaipxBCMUyqUOG2iQ==
X-Google-Smtp-Source: AGHT+IGaFEHnFS2XjUI84tLF67M3q7o2/XhmWSdJoB8ZxD2OEGDzANWB09J7Kdri50EgtAWMZk9dNQ==
X-Received: by 2002:a17:90b:3505:b0:28b:8866:a959 with SMTP id ls5-20020a17090b350500b0028b8866a959mr659502pjb.3.1702914077041;
        Mon, 18 Dec 2023 07:41:17 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:16 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 111/154] ksmbd: add missing compound request handing in some commands
Date: Tue, 19 Dec 2023 00:34:11 +0900
Message-Id: <20231218153454.8090-112-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 7b7d709ef7cf285309157fb94c33f625dd22c5e1 ]

This patch add the compound request handling to the some commands.
Existing clients do not send these commands as compound requests,
but ksmbd should consider that they may come.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 78 +++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8e17334ecee8..964e7182605b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1915,14 +1915,16 @@ int smb2_sess_setup(struct ksmbd_work *work)
 int smb2_tree_connect(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_tree_connect_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_tree_connect_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_tree_connect_req *req;
+	struct smb2_tree_connect_rsp *rsp;
 	struct ksmbd_session *sess = work->sess;
 	char *treename = NULL, *name = NULL;
 	struct ksmbd_tree_conn_status status;
 	struct ksmbd_share_config *share;
 	int rc = -EINVAL;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	treename = smb_strndup_from_utf16(req->Buffer,
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
@@ -2091,19 +2093,19 @@ static int smb2_create_open_flags(bool file_present, __le32 access,
  */
 int smb2_tree_disconnect(struct ksmbd_work *work)
 {
-	struct smb2_tree_disconnect_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_tree_disconnect_rsp *rsp;
+	struct smb2_tree_disconnect_req *req;
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
 	if (!tcon || test_and_set_bit(TREE_CONN_EXPIRE, &tcon->status)) {
-		struct smb2_tree_disconnect_req *req =
-			smb2_get_msg(work->request_buf);
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2126,10 +2128,14 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_logoff_req *req;
+	struct smb2_logoff_rsp *rsp;
 	struct ksmbd_session *sess;
-	struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
-	u64 sess_id = le64_to_cpu(req->hdr.SessionId);
+	u64 sess_id;
+
+	WORK_BUFFERS(work, req, rsp);
+
+	sess_id = le64_to_cpu(req->hdr.SessionId);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
@@ -2169,12 +2175,14 @@ int smb2_session_logoff(struct ksmbd_work *work)
  */
 static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
-	struct smb2_create_rsp *rsp = smb2_get_msg(work->response_buf);
-	struct smb2_create_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_create_rsp *rsp;
+	struct smb2_create_req *req;
 	int id;
 	int err;
 	char *name;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	name = smb_strndup_from_utf16(req->Buffer, le16_to_cpu(req->NameLength),
 				      1, work->conn->local_nls);
 	if (IS_ERR(name)) {
@@ -5314,8 +5322,10 @@ int smb2_query_info(struct ksmbd_work *work)
 static noinline int smb2_close_pipe(struct ksmbd_work *work)
 {
 	u64 id;
-	struct smb2_close_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_close_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_close_req *req;
+	struct smb2_close_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	id = req->VolatileFileId;
 	ksmbd_session_rpc_close(work->sess, id);
@@ -5457,6 +5467,9 @@ int smb2_echo(struct ksmbd_work *work)
 {
 	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
 
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = ksmbd_resp_buf_next(work);
+
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
 	inc_rfc1001_len(work->response_buf, 4);
@@ -6093,8 +6106,10 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	int nbytes = 0, err;
 	u64 id;
 	struct ksmbd_rpc_command *rpc_resp;
-	struct smb2_read_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_read_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_read_req *req;
+	struct smb2_read_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	id = req->VolatileFileId;
 
@@ -6347,14 +6362,16 @@ int smb2_read(struct ksmbd_work *work)
  */
 static noinline int smb2_write_pipe(struct ksmbd_work *work)
 {
-	struct smb2_write_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_write_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_write_req *req;
+	struct smb2_write_rsp *rsp;
 	struct ksmbd_rpc_command *rpc_resp;
 	u64 id = 0;
 	int err = 0, ret = 0;
 	char *data_buf;
 	size_t length;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	length = le32_to_cpu(req->Length);
 	id = req->VolatileFileId;
 
@@ -6623,6 +6640,9 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
 
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
 		    hdr->MessageId, hdr->Flags);
 
@@ -6782,8 +6802,8 @@ static inline bool lock_defer_pending(struct file_lock *fl)
  */
 int smb2_lock(struct ksmbd_work *work)
 {
-	struct smb2_lock_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_lock_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_lock_req *req;
+	struct smb2_lock_rsp *rsp;
 	struct smb2_lock_element *lock_ele;
 	struct ksmbd_file *fp = NULL;
 	struct file_lock *flock = NULL;
@@ -6800,6 +6820,8 @@ int smb2_lock(struct ksmbd_work *work)
 	LIST_HEAD(rollback_list);
 	int prior_lock = 0;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(SMB, "Received lock request\n");
 	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
@@ -7913,8 +7935,8 @@ int smb2_ioctl(struct ksmbd_work *work)
  */
 static void smb20_oplock_break_ack(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
-	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_oplock_break *req;
+	struct smb2_oplock_break *rsp;
 	struct ksmbd_file *fp;
 	struct oplock_info *opinfo = NULL;
 	__le32 err = 0;
@@ -7923,6 +7945,8 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	char req_oplevel = 0, rsp_oplevel = 0;
 	unsigned int oplock_change_type;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	volatile_id = req->VolatileFid;
 	persistent_id = req->PersistentFid;
 	req_oplevel = req->OplockLevel;
@@ -8057,8 +8081,8 @@ static int check_lease_state(struct lease *lease, __le32 req_state)
 static void smb21_lease_break_ack(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_lease_ack *req = smb2_get_msg(work->request_buf);
-	struct smb2_lease_ack *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_lease_ack *req;
+	struct smb2_lease_ack *rsp;
 	struct oplock_info *opinfo;
 	__le32 err = 0;
 	int ret = 0;
@@ -8066,6 +8090,8 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	__le32 lease_state;
 	struct lease *lease;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
 		    le32_to_cpu(req->LeaseState));
 	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
@@ -8191,8 +8217,10 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
  */
 int smb2_oplock_break(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
-	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_oplock_break *req;
+	struct smb2_oplock_break *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	switch (le16_to_cpu(req->StructureSize)) {
 	case OP_BREAK_STRUCT_SIZE_20:
-- 
2.25.1


