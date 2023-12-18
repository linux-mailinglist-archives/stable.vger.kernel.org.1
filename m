Return-Path: <stable+bounces-7709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BC8175E5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9B1C2202E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142005D753;
	Mon, 18 Dec 2023 15:39:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046971446
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b406a0fbfso2458302a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913978; x=1703518778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=copwzfzkfo/I+4CWqHXkvA1ozCzX1naCDVXwz+yh/XE=;
        b=oj99hpmdEfPhKTEwAOaxkJR2QF9ZZyovgLOOwywjQedOo+6VudFtXMS8Olss9eVVBF
         PDAKvWKuB8gDEA1jKBLWuFiHGpc+mCOmhweSpFXTslYspOhuMhdiAeJV0e5yFnRXwsP7
         0ExWdSylcTzsYdsvlvWtrOfafXEUW9vBAeuQS4LeAYI038yZPQyGnsI2smdyMxhWzmTO
         L2YA3N8hWvNssnnwRjtpGs4uc8wBro+1OdxUN/F+fJT9yLLfv8sCVZbTvLUFBxfQ4U7N
         PJBbKuGVRnOXr3DbW1x4H2uo+brJgHa1O4M7nOXnGrw/VonRH6iKR/I7XCXZMvl4+0RU
         Rx4w==
X-Gm-Message-State: AOJu0Yz2uCOMounsi7uGcSJf4A07eyn+Cq1fylrUG6L1Kbe/7tFXTmkf
	DxklNErGpat+Pn5XbcDCJ+c=
X-Google-Smtp-Source: AGHT+IGrqfRYLeNNZwYyC2F9DBNJVGzkKY5jlHGnYzko6VjvaVWUHvK3QllFkOPv0xej68wfvTlYNw==
X-Received: by 2002:a17:90b:1987:b0:28b:718a:7d7 with SMTP id mv7-20020a17090b198700b0028b718a07d7mr1137794pjb.27.1702913978071;
        Mon, 18 Dec 2023 07:39:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 080/154] ksmbd: delete asynchronous work from list
Date: Tue, 19 Dec 2023 00:33:40 +0900
Message-Id: <20231218153454.8090-81-linkinjeon@kernel.org>
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
 fs/ksmbd/connection.c | 12 +++++-------
 fs/ksmbd/ksmbd_work.h |  2 +-
 fs/ksmbd/smb2pdu.c    | 33 +++++++++++++++++++++------------
 fs/ksmbd/smb2pdu.h    |  1 +
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index ccb978f48e41..54888f2819e6 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -112,10 +112,8 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct list_head *requests_queue = NULL;
 
-	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE)
 		requests_queue = &conn->requests;
-		work->synchronous = true;
-	}
 
 	if (requests_queue) {
 		atomic_inc(&conn->req_running);
@@ -136,14 +134,14 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 
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
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
index 3234f2cf6327..f8ae6144c0ae 100644
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
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f7b9480e2268..ef68a3d8c9d5 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -512,12 +512,6 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
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
 
@@ -675,7 +669,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->synchronous = false;
+	work->asynchronous = true;
 	work->async_id = id;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
@@ -695,6 +689,24 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
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
@@ -7089,13 +7101,9 @@ int smb2_lock(struct ksmbd_work *work)
 
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
@@ -7113,6 +7121,7 @@ int smb2_lock(struct ksmbd_work *work)
 						work->send_no_response = 1;
 						goto out;
 					}
+
 					init_smb2_rsp_hdr(work);
 					smb2_set_err_rsp(work);
 					rsp->hdr.Status =
@@ -7125,7 +7134,7 @@ int smb2_lock(struct ksmbd_work *work)
 				spin_lock(&work->conn->llist_lock);
 				list_del(&smb_lock->clist);
 				spin_unlock(&work->conn->llist_lock);
-
+				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
 				spin_lock(&work->conn->llist_lock);
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 77d226fee060..9cde1f8e8428 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1663,6 +1663,7 @@ int find_matching_smb2_dialect(int start_index, __le16 *cli_dialects,
 struct file_lock *smb_flock_init(struct file *f);
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **),
 		     void **arg);
+void release_async_work(struct ksmbd_work *work);
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status);
 struct channel *lookup_chann_list(struct ksmbd_session *sess,
 				  struct ksmbd_conn *conn);
-- 
2.25.1


