Return-Path: <stable+bounces-8078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D381A470
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4F1C22BCD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568594B5DA;
	Wed, 20 Dec 2023 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txdnlv2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65648788;
	Wed, 20 Dec 2023 16:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943DBC433C8;
	Wed, 20 Dec 2023 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088847;
	bh=S8kSRL9UWqk0q5r5AAzXukSNOtspw3rd3XAlNiGF/HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txdnlv2/NfqV8li6Ze+ZBdDc1IbgfRf6f7iCGuEHyO/wuyRBlOPSqb1Qstu+PMISu
	 AbSNA/24agy0xDBHQqTzvw4FeWqxMnRQepuB6ZWFRKXmGubfXFgH7pIejiKXI5Mzze
	 RVDdY93uenQ9MSCVutPjAYj62Xclk1uwRVLK39dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 080/159] ksmbd: delete asynchronous work from list
Date: Wed, 20 Dec 2023 17:09:05 +0100
Message-ID: <20231220160935.111292504@linuxfoundation.org>
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

[ Upstream commit 3a9b557f44ea8f216aab515a7db20e23f0eb51b9 ]

When smb2_lock request is canceled by smb2_cancel or smb2_close(),
ksmbd is missing deleting async_request_entry async_requests list.
Because calling init_smb2_rsp_hdr() in smb2_lock() mark ->synchronous
as true and then it will not be deleted in
ksmbd_conn_try_dequeue_request(). This patch add release_async_work() to
release the ones allocated for async work.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/connection.c |   12 +++++-------
 fs/ksmbd/ksmbd_work.h |    2 +-
 fs/ksmbd/smb2pdu.c    |   33 +++++++++++++++++++++------------
 fs/ksmbd/smb2pdu.h    |    1 +
 4 files changed, 28 insertions(+), 20 deletions(-)

--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -112,10 +112,8 @@ void ksmbd_conn_enqueue_request(struct k
 	struct ksmbd_conn *conn = work->conn;
 	struct list_head *requests_queue = NULL;
 
-	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE)
 		requests_queue = &conn->requests;
-		work->synchronous = true;
-	}
 
 	if (requests_queue) {
 		atomic_inc(&conn->req_running);
@@ -136,14 +134,14 @@ int ksmbd_conn_try_dequeue_request(struc
 
 	if (!work->multiRsp)
 		atomic_dec(&conn->req_running);
-	spin_lock(&conn->request_lock);
 	if (!work->multiRsp) {
+		spin_lock(&conn->request_lock);
 		list_del_init(&work->request_entry);
-		if (!work->synchronous)
-			list_del_init(&work->async_request_entry);
+		spin_unlock(&conn->request_lock);
+		if (work->asynchronous)
+			release_async_work(work);
 		ret = 0;
 	}
-	spin_unlock(&conn->request_lock);
 
 	wake_up_all(&conn->req_running_q);
 	return ret;
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -68,7 +68,7 @@ struct ksmbd_work {
 	/* Request is encrypted */
 	bool                            encrypted:1;
 	/* Is this SYNC or ASYNC ksmbd_work */
-	bool                            synchronous:1;
+	bool                            asynchronous:1;
 	bool                            need_invalidate_rkey:1;
 
 	unsigned int                    remote_key;
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -512,12 +512,6 @@ int init_smb2_rsp_hdr(struct ksmbd_work
 	rsp_hdr->SessionId = rcv_hdr->SessionId;
 	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
 
-	work->synchronous = true;
-	if (work->async_id) {
-		ksmbd_release_id(&conn->async_ida, work->async_id);
-		work->async_id = 0;
-	}
-
 	return 0;
 }
 
@@ -675,7 +669,7 @@ int setup_async_work(struct ksmbd_work *
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->synchronous = false;
+	work->asynchronous = true;
 	work->async_id = id;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
@@ -695,6 +689,24 @@ int setup_async_work(struct ksmbd_work *
 	return 0;
 }
 
+void release_async_work(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+
+	spin_lock(&conn->request_lock);
+	list_del_init(&work->async_request_entry);
+	spin_unlock(&conn->request_lock);
+
+	work->asynchronous = 0;
+	work->cancel_fn = NULL;
+	kfree(work->cancel_argv);
+	work->cancel_argv = NULL;
+	if (work->async_id) {
+		ksmbd_release_id(&conn->async_ida, work->async_id);
+		work->async_id = 0;
+	}
+}
+
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 {
 	struct smb2_hdr *rsp_hdr;
@@ -7090,13 +7102,9 @@ skip:
 
 				ksmbd_vfs_posix_lock_wait(flock);
 
-				spin_lock(&work->conn->request_lock);
 				spin_lock(&fp->f_lock);
 				list_del(&work->fp_entry);
-				work->cancel_fn = NULL;
-				kfree(argv);
 				spin_unlock(&fp->f_lock);
-				spin_unlock(&work->conn->request_lock);
 
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
@@ -7114,6 +7122,7 @@ skip:
 						work->send_no_response = 1;
 						goto out;
 					}
+
 					init_smb2_rsp_hdr(work);
 					smb2_set_err_rsp(work);
 					rsp->hdr.Status =
@@ -7126,7 +7135,7 @@ skip:
 				spin_lock(&work->conn->llist_lock);
 				list_del(&smb_lock->clist);
 				spin_unlock(&work->conn->llist_lock);
-
+				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
 				spin_lock(&work->conn->llist_lock);
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1663,6 +1663,7 @@ int find_matching_smb2_dialect(int start
 struct file_lock *smb_flock_init(struct file *f);
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **),
 		     void **arg);
+void release_async_work(struct ksmbd_work *work);
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status);
 struct channel *lookup_chann_list(struct ksmbd_session *sess,
 				  struct ksmbd_conn *conn);



