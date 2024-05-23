Return-Path: <stable+bounces-45907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14F8CD480
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27F2281560
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735FC14B956;
	Thu, 23 May 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h3G7V81s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A214A604;
	Thu, 23 May 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470706; cv=none; b=CzXHYQbVjRomtgO6clRvrRmfsPd7NJOEwKft4l4RrcsCCxmc8hAO3cFYwaVKJ8nbRYPcOSfr9WYHHi3hdGateOagfr7B6AwYuyI9bPMSJiowrkgMlKLvT1+zUYJu0mJXejpna0m9rExkp/h16O77eKpMoK0YYo6ElqmWhoHY7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470706; c=relaxed/simple;
	bh=iOGljJyUasAvCy4ax4rtblUS7FAhjsSpFMJQZU5fGvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czBQWnYj1RzPoeq+4yhhZa8w1wr/c4Jgt79oXwdMohfrFm5ZQyjyQjkmY/6QINtPI/0PLirjnDX7cQRwxnGTkz/ZyX6VgiQKe+AVs9CMuVbmYWTzaS0KDGEu5EWIJWQjvraooLSlzSZzKkZKJqdmnT2RTo1uYjG4Y+biBCmEb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h3G7V81s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80504C2BD10;
	Thu, 23 May 2024 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470706;
	bh=iOGljJyUasAvCy4ax4rtblUS7FAhjsSpFMJQZU5fGvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3G7V81s6cUUNRMadtfBmJtaCIJBG7XlUAm7sVbfVuV50vKHSzW5UEYDDzvrGSmzs
	 wG+WXPlKwUC2CoasnPLL+SRzO5qCzR3yR0VlxeP5csBXqGUyj+eWmiPfAjlhHRqs3v
	 6+NRkKZKWgvwKXM8pDbYP3sJGLOMOtRrbI2FKrDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 060/102] ksmbd: add support for durable handles v1/v2
Date: Thu, 23 May 2024 15:13:25 +0200
Message-ID: <20240523130344.733769853@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit c8efcc786146a951091588e5fa7e3c754850cb3c ]

Durable file handles allow reopening a file preserved on a short
network outage and transparent client reconnection within a timeout.
i.e. Durable handles aren't necessarily cleaned up when the opening
process terminates.

This patch add support for durable handle version 1 and 2.

To prove durable handles work on ksmbd, I have tested this patch with
the following smbtorture tests:

smb2.durable-open.open-oplock
smb2.durable-open.open-lease
smb2.durable-open.reopen1
smb2.durable-open.reopen1a
smb2.durable-open.reopen1a-lease
smb2.durable-open.reopen2
smb2.durable-open.reopen2a
smb2.durable-open.reopen2-lease
smb2.durable-open.reopen2-lease-v2
smb2.durable-open.reopen3
smb2.durable-open.reopen4
smb2.durable-open.delete_on_close2
smb2.durable-open.file-position
smb2.durable-open.lease
smb2.durable-open.alloc-size
smb2.durable-open.read-only
smb2.durable-v2-open.create-blob
smb2.durable-v2-open.open-oplock
smb2.durable-v2-open.open-lease
smb2.durable-v2-open.reopen1
smb2.durable-v2-open.reopen1a
smb2.durable-v2-open.reopen1a-lease
smb2.durable-v2-open.reopen2
smb2.durable-v2-open.reopen2b

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/ksmbd_netlink.h     |   1 +
 fs/smb/server/mgmt/user_session.c |   1 +
 fs/smb/server/oplock.c            |  94 +++++++++--
 fs/smb/server/oplock.h            |   7 +-
 fs/smb/server/smb2ops.c           |   6 +
 fs/smb/server/smb2pdu.c           | 257 +++++++++++++++++++++++++++++-
 fs/smb/server/smb2pdu.h           |  15 ++
 fs/smb/server/vfs_cache.c         | 137 +++++++++++++++-
 fs/smb/server/vfs_cache.h         |   9 ++
 9 files changed, 506 insertions(+), 21 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 4464a62228cf3..686b321c5a8bb 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -75,6 +75,7 @@ struct ksmbd_heartbeat {
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(1)
 #define KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL	BIT(2)
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF	BIT(3)
+#define KSMBD_GLOBAL_FLAG_DURABLE_HANDLE	BIT(4)
 
 /*
  * IPC request for ksmbd server startup
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 83074672fe812..aec0a7a124052 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -324,6 +324,7 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz))
 		goto out;
 
+	ksmbd_destroy_file_table(&prev_sess->file_table);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 out:
 	up_write(&conn->session_lock);
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index dc729ab980dc0..7bdae2adad228 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -159,7 +159,8 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
 					op_entry);
 	if (opinfo) {
-		if (!atomic_inc_not_zero(&opinfo->refcount))
+		if (opinfo->conn == NULL ||
+		    !atomic_inc_not_zero(&opinfo->refcount))
 			opinfo = NULL;
 		else {
 			atomic_inc(&opinfo->conn->r_count);
@@ -527,7 +528,7 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 	 */
 	read_lock(&ci->m_lock);
 	list_for_each_entry(opinfo, &ci->m_op_list, op_entry) {
-		if (!opinfo->is_lease)
+		if (!opinfo->is_lease || !opinfo->conn)
 			continue;
 		read_unlock(&ci->m_lock);
 		lease = opinfo->o_lease;
@@ -651,7 +652,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_file *fp;
 
-	fp = ksmbd_lookup_durable_fd(br_info->fid);
+	fp = ksmbd_lookup_global_fd(br_info->fid);
 	if (!fp)
 		goto out;
 
@@ -1115,7 +1116,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 
 	read_lock(&p_ci->m_lock);
 	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
-		if (!opinfo->is_lease)
+		if (opinfo->conn == NULL || !opinfo->is_lease)
 			continue;
 
 		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE &&
@@ -1160,7 +1161,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 
 	read_lock(&p_ci->m_lock);
 	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
-		if (!opinfo->is_lease)
+		if (opinfo->conn == NULL || !opinfo->is_lease)
 			continue;
 
 		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE) {
@@ -1372,6 +1373,9 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
+		if (brk_op->conn == NULL)
+			continue;
+
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
 
@@ -1508,11 +1512,10 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 /**
  * parse_lease_state() - parse lease context containted in file open request
  * @open_req:	buffer containing smb2 file open(create) request
- * @is_dir:	whether leasing file is directory
  *
  * Return:  oplock state, -ENOENT if create lease context not found
  */
-struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
+struct lease_ctx_info *parse_lease_state(void *open_req)
 {
 	struct create_context *cc;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
@@ -1530,12 +1533,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		if (is_dir) {
-			lreq->req_state = lc->lcontext.LeaseState &
-				~SMB2_LEASE_WRITE_CACHING_LE;
-			lreq->is_dir = true;
-		} else
-			lreq->req_state = lc->lcontext.LeaseState;
+		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
 		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
@@ -1659,6 +1657,8 @@ void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp)
 	buf->Name[3] = 'Q';
 
 	buf->Timeout = cpu_to_le32(fp->durable_timeout);
+	if (fp->is_persistent)
+		buf->Flags = cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT);
 }
 
 /**
@@ -1826,3 +1826,71 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 	read_unlock(&lease_list_lock);
 	return ret_op;
 }
+
+int smb2_check_durable_oplock(struct ksmbd_conn *conn,
+			      struct ksmbd_share_config *share,
+			      struct ksmbd_file *fp,
+			      struct lease_ctx_info *lctx,
+			      char *name)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	int ret = 0;
+
+	if (!opinfo)
+		return 0;
+
+	if (opinfo->is_lease == false) {
+		if (lctx) {
+			pr_err("create context include lease\n");
+			ret = -EBADF;
+			goto out;
+		}
+
+		if (opinfo->level != SMB2_OPLOCK_LEVEL_BATCH) {
+			pr_err("oplock level is not equal to SMB2_OPLOCK_LEVEL_BATCH\n");
+			ret = -EBADF;
+		}
+
+		goto out;
+	}
+
+	if (memcmp(conn->ClientGUID, fp->client_guid,
+				SMB2_CLIENT_GUID_SIZE)) {
+		ksmbd_debug(SMB, "Client guid of fp is not equal to the one of connction\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (!lctx) {
+		ksmbd_debug(SMB, "create context does not include lease\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
+				SMB2_LEASE_KEY_SIZE)) {
+		ksmbd_debug(SMB,
+			    "lease key of fp does not match lease key in create context\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (!(opinfo->o_lease->state & SMB2_LEASE_HANDLE_CACHING_LE)) {
+		ksmbd_debug(SMB, "lease state does not contain SMB2_LEASE_HANDLE_CACHING\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (opinfo->o_lease->version != lctx->version) {
+		ksmbd_debug(SMB,
+			    "lease version of fp does not match the one in create context\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (!ksmbd_inode_pending_delete(fp))
+		ret = ksmbd_validate_name_reconnect(share, fp, name);
+out:
+	opinfo_put(opinfo);
+	return ret;
+}
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 5b93ea9196c01..e9da63f25b206 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -111,7 +111,7 @@ void opinfo_put(struct oplock_info *opinfo);
 
 /* Lease related functions */
 void create_lease_buf(u8 *rbuf, struct lease *lease);
-struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir);
+struct lease_ctx_info *parse_lease_state(void *open_req);
 __u8 smb2_map_lease_to_oplock(__le32 lease_state);
 int lease_read_to_write(struct oplock_info *opinfo);
 
@@ -130,4 +130,9 @@ void destroy_lease_table(struct ksmbd_conn *conn);
 void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				      struct lease_ctx_info *lctx);
 void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp);
+int smb2_check_durable_oplock(struct ksmbd_conn *conn,
+			      struct ksmbd_share_config *share,
+			      struct ksmbd_file *fp,
+			      struct lease_ctx_info *lctx,
+			      char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 8600f32c981a1..606aa3c5189a2 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -261,6 +261,9 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
 }
 
 /**
@@ -283,6 +286,9 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
+
 	INIT_LIST_HEAD(&conn->preauth_sess_table);
 	return 0;
 }
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 61717917db765..218adb3c55816 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2622,6 +2622,165 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
 	}
 }
 
+enum {
+	DURABLE_RECONN_V2 = 1,
+	DURABLE_RECONN,
+	DURABLE_REQ_V2,
+	DURABLE_REQ,
+};
+
+struct durable_info {
+	struct ksmbd_file *fp;
+	unsigned short int type;
+	bool persistent;
+	bool reconnected;
+	unsigned int timeout;
+	char *CreateGuid;
+};
+
+static int parse_durable_handle_context(struct ksmbd_work *work,
+					struct smb2_create_req *req,
+					struct lease_ctx_info *lc,
+					struct durable_info *dh_info)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct create_context *context;
+	int dh_idx, err = 0;
+	u64 persistent_id = 0;
+	int req_op_level;
+	static const char * const durable_arr[] = {"DH2C", "DHnC", "DH2Q", "DHnQ"};
+
+	req_op_level = req->RequestedOplockLevel;
+	for (dh_idx = DURABLE_RECONN_V2; dh_idx <= ARRAY_SIZE(durable_arr);
+	     dh_idx++) {
+		context = smb2_find_context_vals(req, durable_arr[dh_idx - 1], 4);
+		if (IS_ERR(context)) {
+			err = PTR_ERR(context);
+			goto out;
+		}
+		if (!context)
+			continue;
+
+		switch (dh_idx) {
+		case DURABLE_RECONN_V2:
+		{
+			struct create_durable_reconn_v2_req *recon_v2;
+
+			if (dh_info->type == DURABLE_RECONN ||
+			    dh_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			recon_v2 = (struct create_durable_reconn_v2_req *)context;
+			persistent_id = recon_v2->Fid.PersistentFileId;
+			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
+			if (!dh_info->fp) {
+				ksmbd_debug(SMB, "Failed to get durable handle state\n");
+				err = -EBADF;
+				goto out;
+			}
+
+			if (memcmp(dh_info->fp->create_guid, recon_v2->CreateGuid,
+				   SMB2_CREATE_GUID_SIZE)) {
+				err = -EBADF;
+				ksmbd_put_durable_fd(dh_info->fp);
+				goto out;
+			}
+
+			dh_info->type = dh_idx;
+			dh_info->reconnected = true;
+			ksmbd_debug(SMB,
+				"reconnect v2 Persistent-id from reconnect = %llu\n",
+					persistent_id);
+			break;
+		}
+		case DURABLE_RECONN:
+		{
+			struct create_durable_reconn_req *recon;
+
+			if (dh_info->type == DURABLE_RECONN_V2 ||
+			    dh_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			recon = (struct create_durable_reconn_req *)context;
+			persistent_id = recon->Data.Fid.PersistentFileId;
+			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
+			if (!dh_info->fp) {
+				ksmbd_debug(SMB, "Failed to get durable handle state\n");
+				err = -EBADF;
+				goto out;
+			}
+
+			dh_info->type = dh_idx;
+			dh_info->reconnected = true;
+			ksmbd_debug(SMB, "reconnect Persistent-id from reconnect = %llu\n",
+				    persistent_id);
+			break;
+		}
+		case DURABLE_REQ_V2:
+		{
+			struct create_durable_req_v2 *durable_v2_blob;
+
+			if (dh_info->type == DURABLE_RECONN ||
+			    dh_info->type == DURABLE_RECONN_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			durable_v2_blob =
+				(struct create_durable_req_v2 *)context;
+			ksmbd_debug(SMB, "Request for durable v2 open\n");
+			dh_info->fp = ksmbd_lookup_fd_cguid(durable_v2_blob->CreateGuid);
+			if (dh_info->fp) {
+				if (!memcmp(conn->ClientGUID, dh_info->fp->client_guid,
+					    SMB2_CLIENT_GUID_SIZE)) {
+					if (!(req->hdr.Flags & SMB2_FLAGS_REPLAY_OPERATION)) {
+						err = -ENOEXEC;
+						goto out;
+					}
+
+					dh_info->fp->conn = conn;
+					dh_info->reconnected = true;
+					goto out;
+				}
+			}
+
+			if (((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
+			     req_op_level == SMB2_OPLOCK_LEVEL_BATCH)) {
+				dh_info->CreateGuid =
+					durable_v2_blob->CreateGuid;
+				dh_info->persistent =
+					le32_to_cpu(durable_v2_blob->Flags);
+				dh_info->timeout =
+					le32_to_cpu(durable_v2_blob->Timeout);
+				dh_info->type = dh_idx;
+			}
+			break;
+		}
+		case DURABLE_REQ:
+			if (dh_info->type == DURABLE_RECONN)
+				goto out;
+			if (dh_info->type == DURABLE_RECONN_V2 ||
+			    dh_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
+			     req_op_level == SMB2_OPLOCK_LEVEL_BATCH)) {
+				ksmbd_debug(SMB, "Request for durable open\n");
+				dh_info->type = dh_idx;
+			}
+		}
+	}
+
+out:
+	return err;
+}
+
 /**
  * smb2_open() - handler for smb file open request
  * @work:	smb work containing request buffer
@@ -2645,6 +2804,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct lease_ctx_info *lc = NULL;
 	struct create_ea_buf_req *ea_buf = NULL;
 	struct oplock_info *opinfo;
+	struct durable_info dh_info = {0};
 	__le32 *next_ptr = NULL;
 	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
 	int rc = 0;
@@ -2725,6 +2885,49 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
+	req_op_level = req->RequestedOplockLevel;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE &&
+	    req->CreateContextsOffset) {
+		lc = parse_lease_state(req);
+		rc = parse_durable_handle_context(work, req, lc, &dh_info);
+		if (rc) {
+			ksmbd_debug(SMB, "error parsing durable handle context\n");
+			goto err_out2;
+		}
+
+		if (dh_info.reconnected == true) {
+			rc = smb2_check_durable_oplock(conn, share, dh_info.fp, lc, name);
+			if (rc) {
+				ksmbd_put_durable_fd(dh_info.fp);
+				goto err_out2;
+			}
+
+			rc = ksmbd_reopen_durable_fd(work, dh_info.fp);
+			if (rc) {
+				ksmbd_put_durable_fd(dh_info.fp);
+				goto err_out2;
+			}
+
+			if (ksmbd_override_fsids(work)) {
+				rc = -ENOMEM;
+				ksmbd_put_durable_fd(dh_info.fp);
+				goto err_out2;
+			}
+
+			fp = dh_info.fp;
+			file_info = FILE_OPENED;
+
+			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
+			if (rc)
+				goto err_out2;
+
+			ksmbd_put_durable_fd(fp);
+			goto reconnected_fp;
+		}
+	} else if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+		lc = parse_lease_state(req);
+
 	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
@@ -3187,10 +3390,6 @@ int smb2_open(struct ksmbd_work *work)
 		need_truncate = 1;
 	}
 
-	req_op_level = req->RequestedOplockLevel;
-	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
-		lc = parse_lease_state(req, S_ISDIR(file_inode(filp)->i_mode));
-
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
@@ -3201,6 +3400,11 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			if (S_ISDIR(file_inode(filp)->i_mode)) {
+				lc->req_state &= ~SMB2_LEASE_WRITE_CACHING_LE;
+				lc->is_dir = true;
+			}
+
 			/*
 			 * Compare parent lease using parent key. If there is no
 			 * a lease that has same parent key, Send lease break
@@ -3297,6 +3501,24 @@ int smb2_open(struct ksmbd_work *work)
 
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
+	if (dh_info.type == DURABLE_REQ_V2 || dh_info.type == DURABLE_REQ) {
+		if (dh_info.type == DURABLE_REQ_V2 && dh_info.persistent)
+			fp->is_persistent = true;
+		else
+			fp->is_durable = true;
+
+		if (dh_info.type == DURABLE_REQ_V2) {
+			memcpy(fp->create_guid, dh_info.CreateGuid,
+					SMB2_CREATE_GUID_SIZE);
+			if (dh_info.timeout)
+				fp->durable_timeout = min(dh_info.timeout,
+						300000);
+			else
+				fp->durable_timeout = 60;
+		}
+	}
+
+reconnected_fp:
 	rsp->StructureSize = cpu_to_le16(89);
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
@@ -3383,6 +3605,33 @@ int smb2_open(struct ksmbd_work *work)
 		next_off = conn->vals->create_disk_id_size;
 	}
 
+	if (dh_info.type == DURABLE_REQ || dh_info.type == DURABLE_REQ_V2) {
+		struct create_context *durable_ccontext;
+
+		durable_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		if (dh_info.type == DURABLE_REQ) {
+			create_durable_rsp_buf(rsp->Buffer +
+					le32_to_cpu(rsp->CreateContextsLength));
+			le32_add_cpu(&rsp->CreateContextsLength,
+					conn->vals->create_durable_size);
+			iov_len += conn->vals->create_durable_size;
+		} else {
+			create_durable_v2_rsp_buf(rsp->Buffer +
+					le32_to_cpu(rsp->CreateContextsLength),
+					fp);
+			le32_add_cpu(&rsp->CreateContextsLength,
+					conn->vals->create_durable_v2_size);
+			iov_len += conn->vals->create_durable_v2_size;
+		}
+
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &durable_ccontext->Next;
+		next_off = conn->vals->create_durable_size;
+	}
+
 	if (posix_ctxt) {
 		contxt_cnt++;
 		create_posix_rsp_buf(rsp->Buffer +
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index d12cfd3b09278..bd1d2a0e9203a 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -72,6 +72,18 @@ struct create_durable_req_v2 {
 	__u8 CreateGuid[16];
 } __packed;
 
+struct create_durable_reconn_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	union {
+		__u8  Reserved[16];
+		struct {
+			__u64 PersistentFileId;
+			__u64 VolatileFileId;
+		} Fid;
+	} Data;
+} __packed;
+
 struct create_durable_reconn_v2_req {
 	struct create_context ccontext;
 	__u8   Name[8];
@@ -98,6 +110,9 @@ struct create_durable_rsp {
 	} Data;
 } __packed;
 
+/* See MS-SMB2 2.2.13.2.11 */
+/* Flags */
+#define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
 struct create_durable_v2_rsp {
 	struct create_context ccontext;
 	__u8   Name[8];
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 4e82ff627d122..030f70700036c 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -305,7 +305,8 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 	fd_limit_close();
 	__ksmbd_remove_durable_fd(fp);
-	__ksmbd_remove_fd(ft, fp);
+	if (ft)
+		__ksmbd_remove_fd(ft, fp);
 
 	close_id_del_oplock(fp);
 	filp = fp->filp;
@@ -465,11 +466,32 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 	return fp;
 }
 
-struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
+struct ksmbd_file *ksmbd_lookup_global_fd(unsigned long long id)
 {
 	return __ksmbd_lookup_fd(&global_ft, id);
 }
 
+struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
+{
+	struct ksmbd_file *fp;
+
+	fp = __ksmbd_lookup_fd(&global_ft, id);
+	if (fp && fp->conn) {
+		ksmbd_put_durable_fd(fp);
+		fp = NULL;
+	}
+
+	return fp;
+}
+
+void ksmbd_put_durable_fd(struct ksmbd_file *fp)
+{
+	if (!atomic_dec_and_test(&fp->refcount))
+		return;
+
+	__ksmbd_close_fd(NULL, fp);
+}
+
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
 {
 	struct ksmbd_file	*fp = NULL;
@@ -639,6 +661,32 @@ __close_file_table_ids(struct ksmbd_file_table *ft,
 	return num;
 }
 
+static inline bool is_reconnectable(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	bool reconn = false;
+
+	if (!opinfo)
+		return false;
+
+	if (opinfo->op_state != OPLOCK_STATE_NONE) {
+		opinfo_put(opinfo);
+		return false;
+	}
+
+	if (fp->is_resilient || fp->is_persistent)
+		reconn = true;
+	else if (fp->is_durable && opinfo->is_lease &&
+		 opinfo->o_lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		reconn = true;
+
+	else if (fp->is_durable && opinfo->level == SMB2_OPLOCK_LEVEL_BATCH)
+		reconn = true;
+
+	opinfo_put(opinfo);
+	return reconn;
+}
+
 static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
 			       struct ksmbd_file *fp)
 {
@@ -648,7 +696,28 @@ static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
 static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 			     struct ksmbd_file *fp)
 {
-	return false;
+	struct ksmbd_inode *ci;
+	struct oplock_info *op;
+	struct ksmbd_conn *conn;
+
+	if (!is_reconnectable(fp))
+		return false;
+
+	conn = fp->conn;
+	ci = fp->f_ci;
+	write_lock(&ci->m_lock);
+	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
+		if (op->conn != conn)
+			continue;
+		op->conn = NULL;
+	}
+	write_unlock(&ci->m_lock);
+
+	fp->conn = NULL;
+	fp->tcon = NULL;
+	fp->volatile_id = KSMBD_NO_FID;
+
+	return true;
 }
 
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
@@ -687,6 +756,68 @@ void ksmbd_free_global_file_table(void)
 	ksmbd_destroy_file_table(&global_ft);
 }
 
+int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
+				  struct ksmbd_file *fp, char *name)
+{
+	char *pathname, *ab_pathname;
+	int ret = 0;
+
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -EACCES;
+
+	ab_pathname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
+	if (IS_ERR(ab_pathname)) {
+		kfree(pathname);
+		return -EACCES;
+	}
+
+	if (name && strcmp(&ab_pathname[share->path_sz + 1], name)) {
+		ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
+		ret = -EINVAL;
+	}
+
+	kfree(pathname);
+
+	return ret;
+}
+
+int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	struct ksmbd_inode *ci;
+	struct oplock_info *op;
+
+	if (!fp->is_durable || fp->conn || fp->tcon) {
+		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
+		return -EBADF;
+	}
+
+	if (has_file_id(fp->volatile_id)) {
+		pr_err("Still in use durable fd: %llu\n", fp->volatile_id);
+		return -EBADF;
+	}
+
+	fp->conn = work->conn;
+	fp->tcon = work->tcon;
+
+	ci = fp->f_ci;
+	write_lock(&ci->m_lock);
+	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
+		if (op->conn)
+			continue;
+		op->conn = fp->conn;
+	}
+	write_unlock(&ci->m_lock);
+
+	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (!has_file_id(fp->volatile_id)) {
+		fp->conn = NULL;
+		fp->tcon = NULL;
+		return -EBADF;
+	}
+	return 0;
+}
+
 int ksmbd_init_file_table(struct ksmbd_file_table *ft)
 {
 	ft->idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index a528f0cc775ae..ed44fb4e18e79 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 
 #include "vfs.h"
+#include "mgmt/share_config.h"
 
 /* Windows style file permissions for extended response */
 #define	FILE_GENERIC_ALL	0x1F01FF
@@ -106,6 +107,9 @@ struct ksmbd_file {
 	int				dot_dotdot[2];
 	unsigned int			f_state;
 	bool				reserve_lease_break;
+	bool				is_durable;
+	bool				is_persistent;
+	bool				is_resilient;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -141,7 +145,9 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
 struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d);
 void ksmbd_inode_put(struct ksmbd_inode *ci);
+struct ksmbd_file *ksmbd_lookup_global_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
+void ksmbd_put_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
@@ -173,6 +179,9 @@ void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
 				  int file_info);
+int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp);
+int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
+				  struct ksmbd_file *fp, char *name);
 int ksmbd_init_file_cache(void);
 void ksmbd_exit_file_cache(void);
 #endif /* __VFS_CACHE_H__ */
-- 
2.43.0




