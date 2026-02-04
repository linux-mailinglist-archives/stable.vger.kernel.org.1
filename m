Return-Path: <stable+bounces-213338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEueHOqtgmliYAMAu9opvQ
	(envelope-from <stable+bounces-213338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 03:24:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DCCE0CFB
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 03:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6358130FF321
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 02:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0B2D541B;
	Wed,  4 Feb 2026 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="yzN0WC7R"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2552C1585;
	Wed,  4 Feb 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171771; cv=none; b=lnIecN8xvTSn42PYy8JUppjB+UxZ66pz+bLGgJNWfZIyd6sxk1KTRVZ4zJLw4yoCllRd1zJe6BTP37oEa1zCxTcaX876Im4prPYv+gNYjYRNE6GWE7zwA/gdD1RMY85Vairw/ONvofy9KC+S1IGMpEDX8mqv/f3zR6BAEI8LJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171771; c=relaxed/simple;
	bh=52YP6AjrVI785nfT5caWXK87M5WqExBNV/TP40tlBU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jE1T8ynbFOzAImWMTkg20lKw/5GaNkJiEQAIdN+8q3fur/qXPCc3Q3yyA55DAFYe7gkf2mgxKSJZ7Bv6XNlXLhEHuxgnxmrABL48VpzzYRi2qLgUfZcRmQjSMJd67w/5FtEXlW6FBe2eu0EPHxsi6iVknV2B69Mxe3YNvKOO0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=yzN0WC7R; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=yzN0WC7RzKplZMJNp2N3DVtqIaN7RxRdkRdzGaT9iTJhUB4A9aDBz105OeO/pjpX+k/lpUx/EOPLe
	 DxO4feBiUNBMzEfb3L7sOedzS+EzX1FLiGYI87YwImL6aS0dgSyuBBa6JMrDHNufxhj6nvecpNaSzc
	 E0C2pZTa/fb1Zhss=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-18-12021 (RichMail) with SMTP id 2ef56982ad6b994-009a0;
	Wed, 04 Feb 2026 10:22:44 +0800 (CST)
X-RM-TRANSID:2ef56982ad6b994-009a0
From: Li hongliang <1468888505@139.com>
To: mmakassikis@freebox.fr,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	ysk@kzalloc.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	akendo@akendo.eu,
	set_pte_at@outlook.com,
	linux-cifs@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 6.1.y] ksmbd: fix recursive locking in RPC handle list access
Date: Wed,  4 Feb 2026 10:22:39 +0800
Message-Id: <20260204022239.3204377-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213338-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,samba.org,chromium.org,talpey.com,akendo.eu,outlook.com,microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox.fr:email]
X-Rspamd-Queue-Id: 04DCCE0CFB
X-Rspamd-Action: no action

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 88f170814fea74911ceab798a43cbd7c5599bed4 ]

Since commit 305853cce3794 ("ksmbd: Fix race condition in RPC handle list
access"), ksmbd_session_rpc_method() attempts to lock sess->rpc_lock.

This causes hung connections / tasks when a client attempts to open
a named pipe. Using Samba's rpcclient tool:

 $ rpcclient //192.168.1.254 -U user%password
 $ rpcclient $> srvinfo
 <connection hung here>

Kernel side:
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/0:0 state:D stack:0 pid:5021 tgid:5021 ppid:2 flags:0x00200000
  Workqueue: ksmbd-io handle_ksmbd_work
  Call trace:
  __schedule from schedule+0x3c/0x58
  schedule from schedule_preempt_disabled+0xc/0x10
  schedule_preempt_disabled from rwsem_down_read_slowpath+0x1b0/0x1d8
  rwsem_down_read_slowpath from down_read+0x28/0x30
  down_read from ksmbd_session_rpc_method+0x18/0x3c
  ksmbd_session_rpc_method from ksmbd_rpc_open+0x34/0x68
  ksmbd_rpc_open from ksmbd_session_rpc_open+0x194/0x228
  ksmbd_session_rpc_open from create_smb2_pipe+0x8c/0x2c8
  create_smb2_pipe from smb2_open+0x10c/0x27ac
  smb2_open from handle_ksmbd_work+0x238/0x3dc
  handle_ksmbd_work from process_scheduled_works+0x160/0x25c
  process_scheduled_works from worker_thread+0x16c/0x1e8
  worker_thread from kthread+0xa8/0xb8
  kthread from ret_from_fork+0x14/0x38
  Exception stack(0x8529ffb0 to 0x8529fff8)

The task deadlocks because the lock is already held:
  ksmbd_session_rpc_open
    down_write(&sess->rpc_lock)
    ksmbd_rpc_open
      ksmbd_session_rpc_method
        down_read(&sess->rpc_lock)   <-- deadlock

Adjust ksmbd_session_rpc_method() callers to take the lock when necessary.

Fixes: 305853cce3794 ("ksmbd: Fix race condition in RPC handle list access")
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 fs/smb/server/mgmt/user_session.c |  7 ++-----
 fs/smb/server/smb2pdu.c           |  9 ++++++++-
 fs/smb/server/transport_ipc.c     | 12 ++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 89ae52e03858..1b5ac28d7e66 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -147,14 +147,11 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
-	int method;
 
-	down_read(&sess->rpc_lock);
+	lockdep_assert_held(&sess->rpc_lock);
 	entry = xa_load(&sess->rpc_handle_list, id);
-	method = entry ? entry->method : 0;
-	up_read(&sess->rpc_lock);
 
-	return method;
+	return entry ? entry->method : 0;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 623db96669d9..100016298f87 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4308,8 +4308,15 @@ static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 	 * pipe without opening it, checking error condition here
 	 */
 	id = req->VolatileFileId;
-	if (!ksmbd_session_rpc_method(sess, id))
+
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
+	if (!ksmbd_session_rpc_method(sess, id)) {
+		up_read(&sess->rpc_lock);
 		return -ENOENT;
+	}
+	up_read(&sess->rpc_lock);
 
 	ksmbd_debug(SMB, "FileInfoClass %u, FileId 0x%llx\n",
 		    req->FileInfoClass, req->VolatileFileId);
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 143bd4b3a6b4..ed423d0ca99d 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -775,6 +775,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -783,6 +786,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	req->flags |= KSMBD_RPC_WRITE_METHOD;
 	req->payload_sz = payload_sz;
 	memcpy(req->payload, payload, payload_sz);
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
@@ -799,6 +803,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -806,6 +813,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
 	req->flags |= rpc_context_flags(sess);
 	req->flags |= KSMBD_RPC_READ_METHOD;
 	req->payload_sz = 0;
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
@@ -826,6 +834,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -834,6 +845,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	req->flags |= KSMBD_RPC_IOCTL_METHOD;
 	req->payload_sz = payload_sz;
 	memcpy(req->payload, payload, payload_sz);
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
-- 
2.34.1



