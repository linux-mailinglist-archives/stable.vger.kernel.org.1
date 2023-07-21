Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E375D40A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjGUTRK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjGUTRJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E62A189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CEFF61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC84C433C8;
        Fri, 21 Jul 2023 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967026;
        bh=q8/XJ4k2zPafyQJFHApBD0absJa1MqmZfN6G2YbqkJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ji5sygHM0taCMbWrHc8PbGlqO62zNllO62dImP30HMv7QSzpZ9+IOnjz0+cVYv9N0
         SOpGirRiHXPYGGzwXnFDyzhdIChTltTTJffJKCo4TIYG/2imjmnVwGCVBxOhHUNbhK
         Mx28Oqnc6zOcJVrZv4z40JAYRdVhPsxOsXKFGe28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 006/223] ksmbd: add missing compound request handing in some commands
Date:   Fri, 21 Jul 2023 18:04:19 +0200
Message-ID: <20230721160521.144490247@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 7b7d709ef7cf285309157fb94c33f625dd22c5e1 upstream.

This patch add the compound request handling to the some commands.
Existing clients do not send these commands as compound requests,
but ksmbd should consider that they may come.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   78 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 25 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1926,14 +1926,16 @@ out_err:
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
@@ -2102,19 +2104,19 @@ static int smb2_create_open_flags(bool f
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
@@ -2137,10 +2139,14 @@ int smb2_tree_disconnect(struct ksmbd_wo
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
@@ -2180,12 +2186,14 @@ int smb2_session_logoff(struct ksmbd_wor
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
@@ -5321,8 +5329,10 @@ int smb2_query_info(struct ksmbd_work *w
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
@@ -5464,6 +5474,9 @@ int smb2_echo(struct ksmbd_work *work)
 {
 	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
 
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = ksmbd_resp_buf_next(work);
+
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
 	inc_rfc1001_len(work->response_buf, 4);
@@ -6178,8 +6191,10 @@ static noinline int smb2_read_pipe(struc
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
 
@@ -6427,14 +6442,16 @@ out:
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
 
@@ -6703,6 +6720,9 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
 
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
 		    hdr->MessageId, hdr->Flags);
 
@@ -6862,8 +6882,8 @@ static inline bool lock_defer_pending(st
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
@@ -6880,6 +6900,8 @@ int smb2_lock(struct ksmbd_work *work)
 	LIST_HEAD(rollback_list);
 	int prior_lock = 0;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(SMB, "Received lock request\n");
 	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
@@ -7992,8 +8014,8 @@ out:
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
@@ -8002,6 +8024,8 @@ static void smb20_oplock_break_ack(struc
 	char req_oplevel = 0, rsp_oplevel = 0;
 	unsigned int oplock_change_type;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	volatile_id = req->VolatileFid;
 	persistent_id = req->PersistentFid;
 	req_oplevel = req->OplockLevel;
@@ -8136,8 +8160,8 @@ static int check_lease_state(struct leas
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
@@ -8145,6 +8169,8 @@ static void smb21_lease_break_ack(struct
 	__le32 lease_state;
 	struct lease *lease;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
 		    le32_to_cpu(req->LeaseState));
 	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
@@ -8270,8 +8296,10 @@ err_out:
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


