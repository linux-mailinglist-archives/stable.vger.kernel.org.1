Return-Path: <stable+bounces-7749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA6817617
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D809280C17
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B72F498A8;
	Mon, 18 Dec 2023 15:41:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B245740A1
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2681976a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914107; x=1703518907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPWs99z6mRPlaLQ0hHFACQ6VK4NNRo6Cb1lFiGv70ss=;
        b=IeTv54Ty5KMPDBX+4NXkG2Brb9vtD9vU7iK0RQ2meqydJg2IB267otBs5Qm5k0ZZHf
         waN0wOyQt3bOZNYOsZHyJvEhR417g94FJwahi2rYy1VUcWfFFpsmuCtYUoudygFrZ1Wz
         8slqSHtqtJzXhmiQGa3YE0v/Fpo3Vd5AdeNIkQ9zR0k2WAFJCmfxwfnH5/KoWIKpfZ/Z
         sYU3k81yQgVetYIHzWqwSw7C9fU8Hyvqw/j7EIHu8iJsnNtCJTDA9Oc48im6BSZmI6XW
         Ac/J+VEa8ExlvPhp2TYgKGSjfqVAotVsZJEKC5o+x5L0ZlkJ1E1iFYY9LGtNqFwZ/fm3
         Eusw==
X-Gm-Message-State: AOJu0YxXg8ellV+yxJK4nuZ8k4Iq7ef++fsn+wTL59pYVgIEtbD5k1je
	Kzz8513Nhh0m5L8WvMRCPYI=
X-Google-Smtp-Source: AGHT+IF7hrStXt3U2LUdKRlGP53Hl/yTzNiApnNqC4QWFwKGf4nO0KMP9RmbAwrCBD63JyoOccmyvA==
X-Received: by 2002:a17:90a:970b:b0:28b:3322:687 with SMTP id x11-20020a17090a970b00b0028b33220687mr2733838pjo.33.1702914106976;
        Mon, 18 Dec 2023 07:41:46 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 120/154] ksmbd: fix wrong interim response on compound
Date: Tue, 19 Dec 2023 00:34:20 +0900
Message-Id: <20231218153454.8090-121-linkinjeon@kernel.org>
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

[ Upstream commit 041bba4414cda37d00063952c9bff9c3d5812a19 ]

If smb2_lock or smb2_open request is compound, ksmbd could send wrong
interim response to client. ksmbd allocate new interim buffer instead of
using resonse buffer to support compound request.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/ksmbd_work.c | 10 ++++++----
 fs/ksmbd/ksmbd_work.h |  2 +-
 fs/ksmbd/oplock.c     | 14 ++------------
 fs/ksmbd/smb2pdu.c    | 26 +++++++++++++++++---------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index f49c2e01ea9f..51def3ca74c0 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
@@ -160,9 +160,11 @@ int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
 	return __ksmbd_iov_pin_rsp(work, ib, len, aux_buf, aux_size);
 }
 
-void ksmbd_iov_reset(struct ksmbd_work *work)
+int allocate_interim_rsp_buf(struct ksmbd_work *work)
 {
-	work->iov_idx = 0;
-	work->iov_cnt = 0;
-	*(__be32 *)work->iov[0].iov_base = 0;
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
+	if (!work->response_buf)
+		return -ENOMEM;
+	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+	return 0;
 }
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
index 255157eb26dc..8ca2c813246e 100644
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -131,5 +131,5 @@ bool ksmbd_queue_work(struct ksmbd_work *work);
 int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
 			   void *aux_buf, unsigned int aux_size);
 int ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len);
-void ksmbd_iov_reset(struct ksmbd_work *work);
+int allocate_interim_rsp_buf(struct ksmbd_work *work);
 #endif /* __KSMBD_WORK_H__ */
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 13c9842a089c..13185c74b912 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -616,15 +616,6 @@ static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
 	return 0;
 }
 
-static inline int allocate_oplock_break_buf(struct ksmbd_work *work)
-{
-	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
-	if (!work->response_buf)
-		return -ENOMEM;
-	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
-	return 0;
-}
-
 /**
  * __smb2_oplock_break_noti() - send smb2 oplock break cmd from conn
  * to client
@@ -647,7 +638,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	if (!fp)
 		goto out;
 
-	if (allocate_oplock_break_buf(work)) {
+	if (allocate_interim_rsp_buf(work)) {
 		pr_err("smb2_allocate_rsp_buf failed! ");
 		ksmbd_fd_put(work, fp);
 		goto out;
@@ -752,7 +743,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	struct lease_break_info *br_info = work->request_buf;
 	struct smb2_hdr *rsp_hdr;
 
-	if (allocate_oplock_break_buf(work)) {
+	if (allocate_interim_rsp_buf(work)) {
 		ksmbd_debug(OPLOCK, "smb2_allocate_rsp_buf failed! ");
 		goto out;
 	}
@@ -843,7 +834,6 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 			setup_async_work(in_work, NULL, NULL);
 			smb2_send_interim_resp(in_work, STATUS_PENDING);
 			list_del(&in_work->interim_entry);
-			ksmbd_iov_reset(in_work);
 		}
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bee7a022952b..3eede04bdcb2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -153,8 +153,8 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 		err_rsp->ByteCount = 0;
 		err_rsp->ErrorData[0] = 0;
 		err = ksmbd_iov_pin_rsp(work, (void *)err_rsp,
-				  work->conn->vals->header_size +
-				  SMB2_ERROR_STRUCTURE_SIZE2);
+					__SMB2_HEADER_STRUCTURE_SIZE +
+						SMB2_ERROR_STRUCTURE_SIZE2);
 		if (err)
 			work->send_no_response = 1;
 	}
@@ -710,13 +710,24 @@ void release_async_work(struct ksmbd_work *work)
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 {
 	struct smb2_hdr *rsp_hdr;
+	struct ksmbd_work *in_work = ksmbd_alloc_work_struct();
 
-	rsp_hdr = ksmbd_resp_buf_next(work);
-	smb2_set_err_rsp(work);
+	if (allocate_interim_rsp_buf(in_work)) {
+		pr_err("smb_allocate_rsp_buf failed!\n");
+		ksmbd_free_work_struct(in_work);
+		return;
+	}
+
+	in_work->conn = work->conn;
+	memcpy(smb2_get_msg(in_work->response_buf), ksmbd_resp_buf_next(work),
+	       __SMB2_HEADER_STRUCTURE_SIZE);
+
+	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	smb2_set_err_rsp(in_work);
 	rsp_hdr->Status = status;
 
-	ksmbd_conn_write(work);
-	rsp_hdr->Status = 0;
+	ksmbd_conn_write(in_work);
+	ksmbd_free_work_struct(in_work);
 }
 
 static __le32 smb2_get_reparse_tag_special_file(umode_t mode)
@@ -7051,8 +7062,6 @@ int smb2_lock(struct ksmbd_work *work)
 				list_del(&work->fp_entry);
 				spin_unlock(&fp->f_lock);
 
-				ksmbd_iov_reset(work);
-
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
@@ -7070,7 +7079,6 @@ int smb2_lock(struct ksmbd_work *work)
 						goto out;
 					}
 
-					init_smb2_rsp_hdr(work);
 					rsp->hdr.Status =
 						STATUS_RANGE_NOT_LOCKED;
 					kfree(smb_lock);
-- 
2.25.1


