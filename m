Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81575B5E9
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGTRwS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGTRwR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 13:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D02690
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 10:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690A461BB5
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 17:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A981C433C7;
        Thu, 20 Jul 2023 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689875534;
        bh=iOwvqnMFWwsMbk/H78OqfAIVtyeBXG9yWC21M4h7+nE=;
        h=Subject:To:Cc:From:Date:From;
        b=b16PWxRwy4bbkkiK5Jb746ucO+mtB2UUdlFSWfcDzDYDzj6jAHjy/2ldCUKZ2t8Z5
         mBrZTCdQSfrNH8uXQztR/E7kg/f7+Wu9t3w9VN3DAoD4bfbWRqaw+yRFt3pO3t93cF
         mKCrU1zTm01CBz2FiY0EEdB76rB6j6tvTTRCZSPA=
Subject: FAILED: patch "[PATCH] ksmbd: add missing compound request handing in some commands" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 20 Jul 2023 19:52:12 +0200
Message-ID: <2023072012-onlooker-chip-2a4c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7b7d709ef7cf285309157fb94c33f625dd22c5e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072012-onlooker-chip-2a4c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7b7d709ef7cf ("ksmbd: add missing compound request handing in some commands")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
30210947a343 ("ksmbd: fix racy issue under cocurrent smb2 tree disconnect")
abcc506a9a71 ("ksmbd: fix racy issue from smb2 close and logoff with multichannel")
ea174a918939 ("ksmbd: destroy expired sessions")
f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
1d9c4172110e ("ksmbd: Implements sess->ksmbd_chann_list as xarray")
62c487b53a7f ("ksmbd: limit pdu length size according to connection status")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
16b5f54e30c1 ("ksmbd: casefold utf-8 share names and fix ascii lowercase conversion")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b7d709ef7cf285309157fb94c33f625dd22c5e1 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 24 Jun 2023 12:35:39 +0900
Subject: [PATCH] ksmbd: add missing compound request handing in some commands

This patch add the compound request handling to the some commands.
Existing clients do not send these commands as compound requests,
but ksmbd should consider that they may come.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 38738b430e11..cf8822103f50 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1914,14 +1914,16 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
@@ -2090,19 +2092,19 @@ static int smb2_create_open_flags(bool file_present, __le32 access,
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
@@ -2125,10 +2127,14 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
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
@@ -2168,12 +2174,14 @@ int smb2_session_logoff(struct ksmbd_work *work)
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
@@ -5306,8 +5314,10 @@ int smb2_query_info(struct ksmbd_work *work)
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
@@ -5449,6 +5459,9 @@ int smb2_echo(struct ksmbd_work *work)
 {
 	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
 
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = ksmbd_resp_buf_next(work);
+
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
 	inc_rfc1001_len(work->response_buf, 4);
@@ -6083,8 +6096,10 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
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
 
@@ -6332,14 +6347,16 @@ int smb2_read(struct ksmbd_work *work)
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
 
@@ -6608,6 +6625,9 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
 
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
 		    hdr->MessageId, hdr->Flags);
 
@@ -6767,8 +6787,8 @@ static inline bool lock_defer_pending(struct file_lock *fl)
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
@@ -6785,6 +6805,8 @@ int smb2_lock(struct ksmbd_work *work)
 	LIST_HEAD(rollback_list);
 	int prior_lock = 0;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(SMB, "Received lock request\n");
 	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
@@ -7898,8 +7920,8 @@ int smb2_ioctl(struct ksmbd_work *work)
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
@@ -7908,6 +7930,8 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	char req_oplevel = 0, rsp_oplevel = 0;
 	unsigned int oplock_change_type;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	volatile_id = req->VolatileFid;
 	persistent_id = req->PersistentFid;
 	req_oplevel = req->OplockLevel;
@@ -8042,8 +8066,8 @@ static int check_lease_state(struct lease *lease, __le32 req_state)
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
@@ -8051,6 +8075,8 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	__le32 lease_state;
 	struct lease *lease;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
 		    le32_to_cpu(req->LeaseState));
 	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
@@ -8176,8 +8202,10 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
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

