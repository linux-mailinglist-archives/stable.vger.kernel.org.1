Return-Path: <stable+bounces-213337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MATZGmqtgmliYAMAu9opvQ
	(envelope-from <stable+bounces-213337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 03:22:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E373EE0C67
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 03:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89125300B9E4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A2299924;
	Wed,  4 Feb 2026 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="CtGrCzBp"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14929B76F;
	Wed,  4 Feb 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171744; cv=none; b=TB06OCwO9qLfIuUqyuFHE1GTFQBiY2r40Do1Ppq7XDhASyl/Q52yXLekCy4iagcbd2mC4wViftGjgVVks+6uWnTaT2SGOIcuHHKnsYqTnwIQicFAnzSsmh1aXOOJdQdCpvEpT4DZkkSkgH3I4X5L7lRmRAupKlEQRbBoe9fQQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171744; c=relaxed/simple;
	bh=q++V7uuIKNzI6SstRdiLpRLr8M2f7zydqlcGpzWMsPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0kMbUUF3cLi9d9c67F0GNxqkG3PsGxIRNjmUpPgU+8q3PlMCUEoQzQyXWji3ccBGmDfH/42+f5G4sTmAirJJbNfPkgpdU6wuwKY4YIHghkaQ1mPQpct4vPJLoYp+O/VYMA1W2//I9jnzjqQJL5rD06a+0eYppnMSvH1FJlM3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=CtGrCzBp; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CtGrCzBpoJiJIHMIgdb9Bo3Zt0BdoxDyoT6qXvvDbO1QxWcwuG0egvGlYJWXvSFZq53u/4GH1DAEm
	 0pk6W+1aDazWCtiyHoWbMgr3yIQ81sgoBN3FLsKb1N5tI4hBvOWIbl7I4nVn4BkbGcL4nkWv4SzihY
	 3O1MWinPvs/SqV5k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-37-12051 (RichMail) with SMTP id 2f136982ada9798-017b6;
	Wed, 04 Feb 2026 10:23:41 +0800 (CST)
X-RM-TRANSID:2f136982ada9798-017b6
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
Subject: [PATCH 6.6.y] ksmbd: fix recursive locking in RPC handle list access
Date: Wed,  4 Feb 2026 10:22:05 +0800
Message-Id: <20260204022205.3204230-1-1468888505@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213337-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:email]
X-Rspamd-Queue-Id: E373EE0C67
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
index 5986d6d0a90b..e344475a41bd 100644
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
index f4b3798279d9..eacfb241d3d4 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4614,8 +4614,15 @@ static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
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
index a5b90d0b9f2d..53bfcf57f167 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -778,6 +778,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -786,6 +789,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle
 	req->flags |= KSMBD_RPC_WRITE_METHOD;
 	req->payload_sz = payload_sz;
 	memcpy(req->payload, payload, payload_sz);
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
@@ -802,6 +806,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -809,6 +816,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
 	req->flags |= rpc_context_flags(sess);
 	req->flags |= KSMBD_RPC_READ_METHOD;
 	req->payload_sz = 0;
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
@@ -829,6 +837,9 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	if (!msg)
 		return NULL;
 
+	lockdep_assert_not_held(&sess->rpc_lock);
+
+	down_read(&sess->rpc_lock);
 	msg->type = KSMBD_EVENT_RPC_REQUEST;
 	req = (struct ksmbd_rpc_command *)msg->payload;
 	req->handle = handle;
@@ -837,6 +848,7 @@ struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle
 	req->flags |= KSMBD_RPC_IOCTL_METHOD;
 	req->payload_sz = payload_sz;
 	memcpy(req->payload, payload, payload_sz);
+	up_read(&sess->rpc_lock);
 
 	resp = ipc_msg_send_request(msg, req->handle);
 	ipc_msg_free(msg);
-- 
2.34.1



