Return-Path: <stable+bounces-7662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC68175AA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BC61F214A8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00414989D;
	Mon, 18 Dec 2023 15:37:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F854FF63
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b6afc7302so624318a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913829; x=1703518629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FizngNHr0rauKkQVqGI/UPQkk0HJzw6+s2XfTzhmfo=;
        b=UHja9h9BmJ6/pT/gr66PZAl1axM543EmfQE647V6lgYyyjgJXhOP+KyMETD0QLjOCH
         RWczCE5GsE2laLewRqXfX8iyXeJxLSp0JQtSUE4aZYXpDRDbzXaQeKdfMboWs9DnIDlJ
         Zo7VKbP+Ky2frpGf9YtzTtyqRImIyPB41fC2dvSVfzRCmQrtZ2Z/dqFTinhdiRl+plEv
         2oV3VgEn5hZkMkZFO72ni+aFxNYNfE7Ist81OoolKbJixqWB5RlzVpDOV8t8/TyfABY3
         d41fXO2WUshuu/fSDaaLNcY+tLGlrNWrP5oj4Apd63sJ//ZmiFgBRR836+WSMPzIjqm5
         D7/Q==
X-Gm-Message-State: AOJu0Yw5lGZb6umbLxpE2xvwikZAT1jJW7NbCeSJmCtb/VHGaZEr/1x9
	EvNEnvxtQWKYoaCXCwHQK5c=
X-Google-Smtp-Source: AGHT+IG9RYftjpjUfyUF50B7R8HwMFDRLD3DbhWZJNOnM0kA4zB0/8k9mXyuaH8RJLRPo+KcwW9FcQ==
X-Received: by 2002:a17:90a:51e5:b0:286:c318:42ca with SMTP id u92-20020a17090a51e500b00286c31842camr7170852pjh.58.1702913828812;
        Mon, 18 Dec 2023 07:37:08 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:08 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 033/154] ksmbd: smbd: change prototypes of RDMA read/write related functions
Date: Tue, 19 Dec 2023 00:32:53 +0900
Message-Id: <20231218153454.8090-34-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 1807abcf8778bcbbf584fe54da9ccbe9029c49bb ]

Change the prototypes of RDMA read/write
operations to accept a pointer and length
of buffer descriptors.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c     | 20 ++++++++++----------
 fs/ksmbd/connection.h     | 27 ++++++++++++++++-----------
 fs/ksmbd/smb2pdu.c        | 23 ++++++++---------------
 fs/ksmbd/transport_rdma.c | 30 +++++++++++++++++-------------
 4 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 6e3416d9c65e..192646b8920e 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -206,31 +206,31 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 	return 0;
 }
 
-int ksmbd_conn_rdma_read(struct ksmbd_conn *conn, void *buf,
-			 unsigned int buflen, u32 remote_key, u64 remote_offset,
-			 u32 remote_len)
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn,
+			 void *buf, unsigned int buflen,
+			 struct smb2_buffer_desc_v1 *desc,
+			 unsigned int desc_len)
 {
 	int ret = -EINVAL;
 
 	if (conn->transport->ops->rdma_read)
 		ret = conn->transport->ops->rdma_read(conn->transport,
 						      buf, buflen,
-						      remote_key, remote_offset,
-						      remote_len);
+						      desc, desc_len);
 	return ret;
 }
 
-int ksmbd_conn_rdma_write(struct ksmbd_conn *conn, void *buf,
-			  unsigned int buflen, u32 remote_key,
-			  u64 remote_offset, u32 remote_len)
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
+			  void *buf, unsigned int buflen,
+			  struct smb2_buffer_desc_v1 *desc,
+			  unsigned int desc_len)
 {
 	int ret = -EINVAL;
 
 	if (conn->transport->ops->rdma_write)
 		ret = conn->transport->ops->rdma_write(conn->transport,
 						       buf, buflen,
-						       remote_key, remote_offset,
-						       remote_len);
+						       desc, desc_len);
 	return ret;
 }
 
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index fd243cdddb22..e0a25cddbb29 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -116,11 +116,14 @@ struct ksmbd_transport_ops {
 	int (*writev)(struct ksmbd_transport *t, struct kvec *iovs, int niov,
 		      int size, bool need_invalidate_rkey,
 		      unsigned int remote_key);
-	int (*rdma_read)(struct ksmbd_transport *t, void *buf, unsigned int len,
-			 u32 remote_key, u64 remote_offset, u32 remote_len);
-	int (*rdma_write)(struct ksmbd_transport *t, void *buf,
-			  unsigned int len, u32 remote_key, u64 remote_offset,
-			  u32 remote_len);
+	int (*rdma_read)(struct ksmbd_transport *t,
+			 void *buf, unsigned int len,
+			 struct smb2_buffer_desc_v1 *desc,
+			 unsigned int desc_len);
+	int (*rdma_write)(struct ksmbd_transport *t,
+			  void *buf, unsigned int len,
+			  struct smb2_buffer_desc_v1 *desc,
+			  unsigned int desc_len);
 };
 
 struct ksmbd_transport {
@@ -142,12 +145,14 @@ struct ksmbd_conn *ksmbd_conn_alloc(void);
 void ksmbd_conn_free(struct ksmbd_conn *conn);
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
 int ksmbd_conn_write(struct ksmbd_work *work);
-int ksmbd_conn_rdma_read(struct ksmbd_conn *conn, void *buf,
-			 unsigned int buflen, u32 remote_key, u64 remote_offset,
-			 u32 remote_len);
-int ksmbd_conn_rdma_write(struct ksmbd_conn *conn, void *buf,
-			  unsigned int buflen, u32 remote_key, u64 remote_offset,
-			  u32 remote_len);
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn,
+			 void *buf, unsigned int buflen,
+			 struct smb2_buffer_desc_v1 *desc,
+			 unsigned int desc_len);
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
+			  void *buf, unsigned int buflen,
+			  struct smb2_buffer_desc_v1 *desc,
+			  unsigned int desc_len);
 void ksmbd_conn_enqueue_request(struct ksmbd_work *work);
 int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
 void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 134a725332a0..d26af17f383c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6193,7 +6193,6 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 static int smb2_set_remote_key_for_rdma(struct ksmbd_work *work,
 					struct smb2_buffer_desc_v1 *desc,
 					__le32 Channel,
-					__le16 ChannelInfoOffset,
 					__le16 ChannelInfoLength)
 {
 	unsigned int i, ch_count;
@@ -6219,7 +6218,8 @@ static int smb2_set_remote_key_for_rdma(struct ksmbd_work *work,
 
 	work->need_invalidate_rkey =
 		(Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
-	work->remote_key = le32_to_cpu(desc->token);
+	if (Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE)
+		work->remote_key = le32_to_cpu(desc->token);
 	return 0;
 }
 
@@ -6227,14 +6227,12 @@ static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
 				      struct smb2_read_req *req, void *data_buf,
 				      size_t length)
 {
-	struct smb2_buffer_desc_v1 *desc =
-		(struct smb2_buffer_desc_v1 *)&req->Buffer[0];
 	int err;
 
 	err = ksmbd_conn_rdma_write(work->conn, data_buf, length,
-				    le32_to_cpu(desc->token),
-				    le64_to_cpu(desc->offset),
-				    le32_to_cpu(desc->length));
+				    (struct smb2_buffer_desc_v1 *)
+				    ((char *)req + le16_to_cpu(req->ReadChannelInfoOffset)),
+				    le16_to_cpu(req->ReadChannelInfoLength));
 	if (err)
 		return err;
 
@@ -6283,7 +6281,6 @@ int smb2_read(struct ksmbd_work *work)
 						   (struct smb2_buffer_desc_v1 *)
 						   ((char *)req + ch_offset),
 						   req->Channel,
-						   req->ReadChannelInfoOffset,
 						   req->ReadChannelInfoLength);
 		if (err)
 			goto out;
@@ -6461,21 +6458,18 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 				       struct ksmbd_file *fp,
 				       loff_t offset, size_t length, bool sync)
 {
-	struct smb2_buffer_desc_v1 *desc;
 	char *data_buf;
 	int ret;
 	ssize_t nbytes;
 
-	desc = (struct smb2_buffer_desc_v1 *)&req->Buffer[0];
-
 	data_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
 	if (!data_buf)
 		return -ENOMEM;
 
 	ret = ksmbd_conn_rdma_read(work->conn, data_buf, length,
-				   le32_to_cpu(desc->token),
-				   le64_to_cpu(desc->offset),
-				   le32_to_cpu(desc->length));
+				   (struct smb2_buffer_desc_v1 *)
+				   ((char *)req + le16_to_cpu(req->WriteChannelInfoOffset)),
+				   le16_to_cpu(req->WriteChannelInfoLength));
 	if (ret < 0) {
 		kvfree(data_buf);
 		return ret;
@@ -6527,7 +6521,6 @@ int smb2_write(struct ksmbd_work *work)
 						   (struct smb2_buffer_desc_v1 *)
 						   ((char *)req + ch_offset),
 						   req->Channel,
-						   req->WriteChannelInfoOffset,
 						   req->WriteChannelInfoLength);
 		if (err)
 			goto out;
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index c723e0552d77..991eefe7fe1f 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1357,14 +1357,18 @@ static void write_done(struct ib_cq *cq, struct ib_wc *wc)
 	read_write_done(cq, wc, DMA_TO_DEVICE);
 }
 
-static int smb_direct_rdma_xmit(struct smb_direct_transport *t, void *buf,
-				int buf_len, u32 remote_key, u64 remote_offset,
-				u32 remote_len, bool is_read)
+static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
+				void *buf, int buf_len,
+				struct smb2_buffer_desc_v1 *desc,
+				unsigned int desc_len,
+				bool is_read)
 {
 	struct smb_direct_rdma_rw_msg *msg;
 	int ret;
 	DECLARE_COMPLETION_ONSTACK(completion);
 	struct ib_send_wr *first_wr = NULL;
+	u32 remote_key = le32_to_cpu(desc[0].token);
+	u64 remote_offset = le64_to_cpu(desc[0].offset);
 
 	ret = wait_for_credits(t, &t->wait_rw_avail_ops, &t->rw_avail_ops);
 	if (ret < 0)
@@ -1429,22 +1433,22 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t, void *buf,
 	return ret;
 }
 
-static int smb_direct_rdma_write(struct ksmbd_transport *t, void *buf,
-				 unsigned int buflen, u32 remote_key,
-				 u64 remote_offset, u32 remote_len)
+static int smb_direct_rdma_write(struct ksmbd_transport *t,
+				 void *buf, unsigned int buflen,
+				 struct smb2_buffer_desc_v1 *desc,
+				 unsigned int desc_len)
 {
 	return smb_direct_rdma_xmit(smb_trans_direct_transfort(t), buf, buflen,
-				    remote_key, remote_offset,
-				    remote_len, false);
+				    desc, desc_len, false);
 }
 
-static int smb_direct_rdma_read(struct ksmbd_transport *t, void *buf,
-				unsigned int buflen, u32 remote_key,
-				u64 remote_offset, u32 remote_len)
+static int smb_direct_rdma_read(struct ksmbd_transport *t,
+				void *buf, unsigned int buflen,
+				struct smb2_buffer_desc_v1 *desc,
+				unsigned int desc_len)
 {
 	return smb_direct_rdma_xmit(smb_trans_direct_transfort(t), buf, buflen,
-				    remote_key, remote_offset,
-				    remote_len, true);
+				    desc, desc_len, true);
 }
 
 static void smb_direct_disconnect(struct ksmbd_transport *t)
-- 
2.25.1


