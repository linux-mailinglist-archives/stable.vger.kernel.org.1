Return-Path: <stable+bounces-9070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4C5820A16
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFCC1F22116
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F91017D3;
	Sun, 31 Dec 2023 07:15:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537817C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2053f5e97b2so286847fac.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006951; x=1704611751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdpAe3xCdEYnKrymiOWrlmSMXOXwLnTGLaU43oPPSTA=;
        b=XfWu1OFQCw6bnMBqzI3TmIc05i52CVdiB9bfO7NSwJrxT2+59DGiwzsrtVJTgJ07Nx
         4M31qay8pXGvySuVcZMjXfPzSMi9L/1HOgqPx4ragKL5JeICtFSwEv+eIwVBS0Zy/MYc
         AzglA3buHPqvfcE7A4s50MpcKboIZE5G5J+gqdl9dQyALIaZ7f3QCjYhysKId19uTJ0B
         KsSrzetZwn75+pHN/FYeAtDsG5jReocR4VcpK1bBccx8DYAGNYhIrEFSOpBOhn536BF5
         +JYOiw/mbi1BswHpBPUgtUWMuulrSJrLgK88N24FZrvhcUkq/daAC7kepFT2ge+GBVZc
         bn6A==
X-Gm-Message-State: AOJu0YyMPGMmHrakEgSDquY5EjPLvhXxsrLtpj5kGiUQMcKv/9aAQJ6B
	mqAB11tDQI51x/auKsyZS4c=
X-Google-Smtp-Source: AGHT+IFkfDOfvNQoxZC1F/uckxJCeufAtH6NSlkZ7eLk15Mq6XvBYcvK1YVeg88JdYlPxNNmWih3fQ==
X-Received: by 2002:a05:6870:1601:b0:204:1c3a:f15e with SMTP id b1-20020a056870160100b002041c3af15emr17221860oae.38.1704006950680;
        Sat, 30 Dec 2023 23:15:50 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 36/73] ksmbd: fix wrong interim response on compound
Date: Sun, 31 Dec 2023 16:12:55 +0900
Message-Id: <20231231071332.31724-37-linkinjeon@kernel.org>
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

[ Upstream commit 041bba4414cda37d00063952c9bff9c3d5812a19 ]

If smb2_lock or smb2_open request is compound, ksmbd could send wrong
interim response to client. ksmbd allocate new interim buffer instead of
using resonse buffer to support compound request.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/ksmbd_work.c | 10 ++++++----
 fs/smb/server/ksmbd_work.h |  2 +-
 fs/smb/server/oplock.c     | 14 ++------------
 fs/smb/server/smb2pdu.c    | 26 +++++++++++++++++---------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index f49c2e01ea9f..51def3ca74c0 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
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
diff --git a/fs/smb/server/ksmbd_work.h b/fs/smb/server/ksmbd_work.h
index 255157eb26dc..8ca2c813246e 100644
--- a/fs/smb/server/ksmbd_work.h
+++ b/fs/smb/server/ksmbd_work.h
@@ -131,5 +131,5 @@ bool ksmbd_queue_work(struct ksmbd_work *work);
 int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
 			   void *aux_buf, unsigned int aux_size);
 int ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len);
-void ksmbd_iov_reset(struct ksmbd_work *work);
+int allocate_interim_rsp_buf(struct ksmbd_work *work);
 #endif /* __KSMBD_WORK_H__ */
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 4e12e3031bc5..90a035c27130 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
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
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7c17bf9b1ccd..c942c30c4427 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -152,8 +152,8 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
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
@@ -709,13 +709,24 @@ void release_async_work(struct ksmbd_work *work)
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
@@ -7050,8 +7061,6 @@ int smb2_lock(struct ksmbd_work *work)
 				list_del(&work->fp_entry);
 				spin_unlock(&fp->f_lock);
 
-				ksmbd_iov_reset(work);
-
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
@@ -7069,7 +7078,6 @@ int smb2_lock(struct ksmbd_work *work)
 						goto out;
 					}
 
-					init_smb2_rsp_hdr(work);
 					rsp->hdr.Status =
 						STATUS_RANGE_NOT_LOCKED;
 					kfree(smb_lock);
-- 
2.25.1


