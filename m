Return-Path: <stable+bounces-9047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCE820A00
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45590282F23
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0417C2;
	Sun, 31 Dec 2023 07:14:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D6186C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso4439416b3a.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006870; x=1704611670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdnCihHJ6gkwChSCjR58tqvFwRkuh3ljFFNBpYjZmYU=;
        b=NqS+Gn5DMlC0kygeL7QN/yxXD86kUHlZQepvjrHl7PFqOw5AzKFDwBa4dKoMgj0gAW
         akqzJX/rLFxD3I7k6JxSH1PfPbbONjg2G0T+hlBCKudG0rKvEYW5ZiTKQaye4PpHpixN
         BkPGhhtnlw/moo0LIZDypk+5GShH8og9CoaLJKG9s1OXlxaTIauGHveTRHw5ZN1dAd/Y
         fXyzOnRtK7U09a5hUEXvjEanNlZK2JH1iWYq3Mr9Smg3g3O48gfF7DCWfKhyiWKwa9oE
         fSBgfGFCGIxKk1yORL5ZTkr5znY8k3elxKW7I7rn+JikyIAEAiWvxugja7wRs9m6Tyzm
         vS2g==
X-Gm-Message-State: AOJu0Yxe32kxwfDWf4GCIoaHEchZcqIs9Pnb48jn9rMeC2bBRBGjw05s
	iPo572K1nM6+rdoOSxtEpLo=
X-Google-Smtp-Source: AGHT+IEuDPVesHF/NFJq3ZeoGpGhDV/Z6wrABALLAkWdpQafFjT+4k6fygMgyXg8NAm8RunHEbfGYg==
X-Received: by 2002:a05:6a20:9381:b0:196:a5c9:cf8c with SMTP id x1-20020a056a20938100b00196a5c9cf8cmr3267171pzh.8.1704006870203;
        Sat, 30 Dec 2023 23:14:30 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:29 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 13/73] ksmbd: delete asynchronous work from list
Date: Sun, 31 Dec 2023 16:12:32 +0900
Message-Id: <20231231071332.31724-14-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/smb/server/connection.c | 12 +++++-------
 fs/smb/server/ksmbd_work.h |  2 +-
 fs/smb/server/smb2pdu.c    | 33 +++++++++++++++++++++------------
 fs/smb/server/smb2pdu.h    |  1 +
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index ffbf14d02419..00a87b4acd5c 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -114,10 +114,8 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct list_head *requests_queue = NULL;
 
-	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE)
 		requests_queue = &conn->requests;
-		work->synchronous = true;
-	}
 
 	if (requests_queue) {
 		atomic_inc(&conn->req_running);
@@ -138,14 +136,14 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 
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
diff --git a/fs/smb/server/ksmbd_work.h b/fs/smb/server/ksmbd_work.h
index 3234f2cf6327..f8ae6144c0ae 100644
--- a/fs/smb/server/ksmbd_work.h
+++ b/fs/smb/server/ksmbd_work.h
@@ -68,7 +68,7 @@ struct ksmbd_work {
 	/* Request is encrypted */
 	bool                            encrypted:1;
 	/* Is this SYNC or ASYNC ksmbd_work */
-	bool                            synchronous:1;
+	bool                            asynchronous:1;
 	bool                            need_invalidate_rkey:1;
 
 	unsigned int                    remote_key;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d3939fd48149..ee128f5d38c3 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -508,12 +508,6 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
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
 
@@ -671,7 +665,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->synchronous = false;
+	work->asynchronous = true;
 	work->async_id = id;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
@@ -691,6 +685,24 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
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
@@ -7153,13 +7165,9 @@ int smb2_lock(struct ksmbd_work *work)
 
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
@@ -7177,6 +7185,7 @@ int smb2_lock(struct ksmbd_work *work)
 						work->send_no_response = 1;
 						goto out;
 					}
+
 					init_smb2_rsp_hdr(work);
 					smb2_set_err_rsp(work);
 					rsp->hdr.Status =
@@ -7189,7 +7198,7 @@ int smb2_lock(struct ksmbd_work *work)
 				spin_lock(&work->conn->llist_lock);
 				list_del(&smb_lock->clist);
 				spin_unlock(&work->conn->llist_lock);
-
+				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
 				spin_lock(&work->conn->llist_lock);
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index f13bd65993cc..59e3de95961c 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -488,6 +488,7 @@ int find_matching_smb2_dialect(int start_index, __le16 *cli_dialects,
 struct file_lock *smb_flock_init(struct file *f);
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **),
 		     void **arg);
+void release_async_work(struct ksmbd_work *work);
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status);
 struct channel *lookup_chann_list(struct ksmbd_session *sess,
 				  struct ksmbd_conn *conn);
-- 
2.25.1


